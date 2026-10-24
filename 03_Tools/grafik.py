#!/usr/bin/env python3
"""Grafik-Werkzeug fuer Buck Rogers (Phase 3).

Bildformat im Spiel (Lader sub_9DD4 / sub_9D66, alles LZW-gepackt):
  Wort 0  Anzahl Kacheln
  Wort 1  Laenge der Kachelkarte in Byte
  Wort 2  Paletten-Bits (Bit 0..3: je gesetztem Bit folgt eine Palette von 32 Byte fuer CRAM-Zeile n)
  Karte   Worte: Bit 0-9 Kachel, 11 H-Spiegel, 12 V-Spiegel, 13-14 Palette, 15 Prioritaet
  Paletten
  Kacheln je 32 Byte (4 bpp)

Funktionen:
  lzw_pack(data)          Packer passend zum Entpacker des Spiels (brtext.LZW), Rundreise geprueft
  bild_lesen(raw)         -> dict(kacheln, karte, paletten, bits)
  bild_schreiben(...)     -> Rohdaten (ungepackt)
  karte_pixel(...)        Kachelkarte -> Pixelfeld (Index 0..63 = Palette*16 + Farbe)
  pixel_karte(...)        Pixelfeld -> Kacheln + Karte (Doppelte und Spiegelungen zusammengefasst)

Aufruf:  python grafik.py export   -> 05_German_Script/Grafik/original/*.png (+ .json)
         python grafik.py pruefen  -> Rundreise aller Bilder (Entpacken, Packen, Entpacken)
"""
import os, sys, json, struct
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import brtext

ROM = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")

# Bilder mit englischem Text (Bestandsaufnahme 24.10.2026, claude/Grafik.md)
BILDER = {
    "G1_presents":  dict(adr=0x99B5F, breite=40, text="STRATEGIC SIMULATIONS, INC. PRESENTS (Vorspann)"),
    "G2_doomsday":  dict(adr=0x9AB8B, breite=28, text="DOOMSDAY LASER (Vorspann)"),
    "G3_active":    dict(adr=0x9ACF7, breite=11, text="ACTIVE (Vorspann)"),
    "G4_target":    dict(adr=0x9AE4D, breite=14, text="TARGET? (Vorspann)"),
    "G5_earth":     dict(adr=0x9AFAA, breite=10, text="EARTH (Vorspann)"),
    "G6_abspann":   dict(adr=0x725C6, breite=40, text="Abspann-Kopf: BUCK ROGERS / COUNTDOWN TO DOOMSDAY / CREATED BY THE / SSI / SPECIAL PROJECTS TEAM"),
    "G7_schiff":    dict(adr=0xE8BF4, breite=30, text="Raumkampf-Anzeige: WEAP / CNTL / ENGN / HULL"),
}


# --- LZW-Packer ----------------------------------------------------------------
class _Bits:
    def __init__(self):
        self.out = bytearray(); self.acc = 0; self.n = 0

    def put(self, val, n):
        for i in range(n - 1, -1, -1):
            self.acc = (self.acc << 1) | ((val >> i) & 1); self.n += 1
            if self.n == 8:
                self.out.append(self.acc); self.acc = 0; self.n = 0

    def done(self):
        if self.n:
            self.out.append(self.acc << (8 - self.n)); self.acc = 0; self.n = 0
        return bytes(self.out) + b"\0\0\0\0"   # Entpacker liest bis zu 4 Byte voraus


def lzw_pack(data, max_eintraege=0xF00):
    """LZW wie im Spiel. Der Entpacker legt einen Eintrag erst beim naechsten Code an
    (ein Schritt hinter dem Packer); Breite und Schwelle werden hier genauso mitgezaehlt."""
    bits = _Bits()
    st = {}

    def reset():
        st.update(next=0x102, thr=2, width=9, maxc=0x1FF, first=True)

    def emit(code):
        n = st["width"]; lo = code & ((1 << (n - 1)) - 1); hi = code >> (n - 1)
        if hi > 1:
            raise ValueError("Code zu gross")
        if lo > st["thr"]:
            if hi:
                raise ValueError("Code nicht darstellbar")
            bits.put(lo, n - 1)
        else:
            bits.put(lo, n - 1); bits.put(hi, 1)

    def dec_add():           # Entpacker legt nach jedem Code (ausser dem ersten) einen Eintrag an
        if st["next"] <= st["maxc"]:
            st["next"] += 1
            st["thr"] = (st["thr"] + 1) & 0xFFFF
            if st["next"] == st["maxc"] and st["width"] < 12:
                st["width"] += 1; st["maxc"] = (1 << st["width"]) - 1; st["thr"] = 0xFFFF

    reset()
    d = {}
    nxt = 0x102
    i = 0
    n = len(data)
    if n == 0:
        emit(0x101); return bits.done()
    while i < n:
        w = data[i]; j = i + 1
        while j < n and (w, data[j]) in d:
            w = d[(w, data[j])]; j += 1
        emit(w)
        if st["first"]:
            st["first"] = False
        else:
            dec_add()
        if j < n:
            if nxt < 0x1000 and nxt < max_eintraege:
                d[(w, data[j])] = nxt; nxt += 1
            elif nxt >= max_eintraege:
                # Woerterbuch voll: Reset senden (Entpacker legt dafuer keinen Eintrag an)
                emit(0x100); reset(); d.clear(); nxt = 0x102
        i = j
    emit(0x101)
    return bits.done()


def lzw_unpack(blob):
    dec = brtext.LZW(blob + b"\0" * 8, 0)
    return dec.read(0x100000)


# --- Bildformat ----------------------------------------------------------------
def bild_lesen(raw):
    nt, mb, bits = struct.unpack(">HHH", raw[:6])
    karte = list(struct.unpack(">%dH" % (mb // 2), raw[6:6 + mb]))
    p = 6 + mb
    paletten = {}
    for b in range(4):
        if bits & (1 << b):
            paletten[b] = list(struct.unpack(">16H", raw[p:p + 32])); p += 32
    kacheln = [raw[p + 32 * k:p + 32 * k + 32] for k in range(nt)]
    rest = raw[p + 32 * nt:]
    return dict(kacheln=kacheln, karte=karte, paletten=paletten, bits=bits, rest=rest)


def bild_schreiben(b):
    raw = struct.pack(">HHH", len(b["kacheln"]), 2 * len(b["karte"]), b["bits"])
    raw += struct.pack(">%dH" % len(b["karte"]), *b["karte"])
    for k in range(4):
        if b["bits"] & (1 << k):
            raw += struct.pack(">16H", *b["paletten"][k])
    raw += b"".join(b["kacheln"]) + b.get("rest", b"")
    return raw


def kachel_pixel(t):
    a = np.zeros((8, 8), np.uint8)
    for y in range(8):
        for x in range(4):
            v = t[y * 4 + x]; a[y, 2 * x] = v >> 4; a[y, 2 * x + 1] = v & 15
    return a


def pixel_kachel(a):
    return bytes(int(a[y, 2 * x]) << 4 | int(a[y, 2 * x + 1]) for y in range(8) for x in range(4))


def karte_pixel(b, breite):
    n = len(b["karte"]); hoehe = (n + breite - 1) // breite
    pix = np.zeros((hoehe * 8, breite * 8), np.uint8)
    for k, e in enumerate(b["karte"]):
        a = kachel_pixel(b["kacheln"][e & 0x3FF]) if (e & 0x3FF) < len(b["kacheln"]) else np.zeros((8, 8), np.uint8)
        if e & 0x800: a = a[:, ::-1]
        if e & 0x1000: a = a[::-1]
        pal = (e >> 13) & 3
        y, x = (k // breite) * 8, (k % breite) * 8
        pix[y:y + 8, x:x + 8] = np.where(a > 0, a + pal * 16, 0)
    return pix


def pixel_karte(pix, breite, karte_alt, leer_kachel=None):
    """Pixelfeld (Palette*16+Farbe) -> Kacheln + Karte. Palette und Prioritaet je Feld
    kommen aus der alten Karte (Feld ohne Farbe behaelt die alte Palette)."""
    kacheln = []; idx = {}; karte = []
    hoehe = len(karte_alt) // breite
    for k in range(len(karte_alt)):
        y, x = (k // breite) * 8, (k % breite) * 8
        blk = pix[y:y + 8, x:x + 8]
        pal_alt = (karte_alt[k] >> 13) & 3
        farben = blk[blk > 0]
        pal = int(farben[0] >> 4) if len(farben) else pal_alt
        if len(farben) and np.any((farben >> 4) != pal):
            raise ValueError("Feld %d,%d mischt Paletten" % (x // 8, y // 8))
        a = np.where(blk > 0, blk & 15, 0).astype(np.uint8)
        treffer = None
        for fl, v in ((0, a), (0x800, a[:, ::-1]), (0x1000, a[::-1]), (0x1800, a[::-1, ::-1])):
            key = pixel_kachel(v)
            if key in idx:
                treffer = (idx[key], fl); break
        if treffer is None:
            key = pixel_kachel(a); idx[key] = len(kacheln); kacheln.append(key); treffer = (idx[key], 0)
        karte.append(treffer[0] | treffer[1] | (pal << 13) | (karte_alt[k] & 0x8000))
    return kacheln, karte


def cram_rgb(w):
    r, g, b = (w >> 1) & 7, (w >> 5) & 7, (w >> 9) & 7
    return (r * 36, g * 36, b * 36)


def png_schreiben(pix, paletten64, pfad):
    from PIL import Image
    im = Image.fromarray(pix, "P")
    flat = []
    for c in paletten64: flat += list(c)
    flat += [0] * (768 - len(flat))
    im.putpalette(flat)
    im.save(pfad)


def png_lesen(pfad):
    from PIL import Image
    return np.array(Image.open(pfad))


def standard_paletten(b):
    """64 Farben: eingebettete Paletten, sonst Graustufen/Toene je Zeile."""
    out = []
    for z in range(4):
        if z in b["paletten"]:
            out += [cram_rgb(w) for w in b["paletten"][z]]
        else:
            out += [(0, 0, 0)] + [((10 + i * 12) * (z in (0, 2)) + 20, (10 + i * 12) * (z in (1, 2)) + 20,
                                   (10 + i * 12) * (z in (0, 3)) + 20) for i in range(1, 16)]
    return out


def main():
    rom = open(ROM, "rb").read()
    cmd = sys.argv[1] if len(sys.argv) > 1 else "pruefen"
    ziel = os.path.join(ROOT, "05_German_Script", "Grafik", "original")
    os.makedirs(ziel, exist_ok=True)
    fehler = 0
    for name, info in BILDER.items():
        dec = brtext.LZW(rom, info["adr"]); raw = dec.read(0x100000); gepackt = dec.p - info["adr"]
        b = bild_lesen(raw)
        pix = karte_pixel(b, info["breite"])
        if cmd == "export":
            png_schreiben(pix, standard_paletten(b), os.path.join(ziel, name + ".png"))
        # Rundreise: Pixel -> Kacheln/Karte -> Rohdaten -> LZW -> zurueck -> Pixel gleich?
        kach, karte = pixel_karte(pix, info["breite"], b["karte"])
        b2 = dict(b, kacheln=kach, karte=karte)
        raw2 = bild_schreiben(b2)
        blob = lzw_pack(raw2)
        raw3 = lzw_unpack(blob)
        ok_lzw = raw3[:len(raw2)] == raw2
        ok_pix = np.array_equal(karte_pixel(bild_lesen(raw3), info["breite"]), pix)
        blob_o = lzw_pack(raw)
        ok_orig = lzw_unpack(blob_o)[:len(raw)] == raw
        print("%-12s $%06X  %3d Kacheln (neu %3d), %4d Felder, gepackt %5d (neu %5d)  LZW %s  Pixel %s  Original %s"
              % (name, info["adr"], len(b["kacheln"]), len(kach), len(b["karte"]), gepackt, len(blob),
                 "OK" if ok_lzw else "FEHLER", "OK" if ok_pix else "FEHLER", "OK" if ok_orig else "FEHLER"))
        fehler += (not ok_lzw) + (not ok_pix) + (not ok_orig)
    print("Fehler:", fehler)
    return 1 if fehler else 0


if __name__ == "__main__":
    sys.exit(main())
