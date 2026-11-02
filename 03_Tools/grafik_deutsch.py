#!/usr/bin/env python3
"""Deutsche Grafiken (Phase 3) aus den Original-Bildern der ROM erzeugen.

Die Buchstaben werden aus den vorhandenen Buchstaben derselben Schrift genommen; fehlende
Buchstaben (K, Z, I, V, F, R, S, M, Ae) sind unten im gleichen Stil als Pixelmuster festgelegt.
Ergebnis: 02_Extracted/deutsch/grafik_Gn.bin (LZW-gepackt, fuer src/deutsch.asm) und, wenn Pillow
vorhanden ist, Vorschaubilder in 05_German_Script/Grafik/deutsch/.

Entscheidungen (Claude 24.10.2026, selbstaendig, im Spieltest pruefen): claude/Grafik.md
Aufruf: python grafik_deutsch.py   (wird von text_einsetzen.py nicht benoetigt; 7_deutsch_bauen.bat ruft es auf)
"""
import os, sys
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import brtext, grafik as gr

AUS = os.path.join(ROOT, "02_Extracted", "deutsch")
VORSCHAU = os.path.join(ROOT, "05_German_Script", "Grafik", "deutsch")


def maske(zeilen):
    return [[1 if c == "#" else 0 for c in z] for z in zeilen]


def spalten_segmente(pix, y0, y1, x0, x1, ist_hintergrund):
    seg = []; x = x0
    while x < x1:
        if any(not ist_hintergrund(pix[y][x]) for y in range(y0, y1)):
            b = x
            while x < x1 and any(not ist_hintergrund(pix[y][x]) for y in range(y0, y1)):
                x += 1
            seg.append((b, x))
        x += 1
    return seg


def ausschnitt(pix, y0, y1, x0, x1):
    return [r[x0:x1] for r in pix[y0:y1]]


# ---------------------------------------------------------------------------
# Vorspann-Schrift (G2-G5): eine Farbe, 14 px breit, 22 Zeilen, 2 px Abstand
GROSS_K = maske([
    "###.......####",
    "###......####.",
    "###.....####..",
    "###....####...",
    "###...####....",
    "###..####.....",
    "###.####......",
    "#######.......",
    "######........",
    "#######.......",
    "########......",
    "####.####.....",
    "####..####....",
    "####...####...",
    "####....####..",
    "####.....####.",
    "####......####",
    "####......####",
    "####......####",
    "####......####",
    "####......####",
    "####......####",
])
GROSS_Z = maske([
    "##############",
    "##############",
    "##############",
    "........######",
    "........#####.",
    ".......####...",
    "......####....",
    ".....####.....",
    "....####......",
    "...####.......",
    "..####........",
    ".####.........",
    "####..........",
    "####..........",
    "####..........",
    "####..........",
    "####..........",
    "####......####",
    "####......####",
    "##############",
    "##############",
    "##############",
])


def vorspann_glyphen(rom):
    """Buchstaben aus ACTIVE, TARGET?, EARTH, DOOMSDAY LASER (Zeilen 1-22 des Bildes)."""
    g = {}
    for name, wort in (("G3_active", "ACTIVE"), ("G4_target", "TARGET?"), ("G5_earth", "EARTH"),
                       ("G2_doomsday", "DOOMSDAYLASER")):
        info = gr.BILDER[name]
        b = gr.bild_lesen(brtext.LZW(rom, info["adr"]).read(0x100000))
        pix = gr.karte_pixel(b, info["breite"])
        seg = spalten_segmente(pix, 1, 23, 0, len(pix[0]), lambda v: v == 0)
        if len(seg) != len(wort):
            raise SystemExit("Segmente %s: %d statt %d" % (name, len(seg), len(wort)))
        for ch, (x0, x1) in zip(wort, seg):
            if ch not in g:
                g[ch] = [[1 if v else 0 for v in r] for r in ausschnitt(pix, 1, 23, x0, x1)]
        farbe = next(v for r in pix for v in r if v)
    g["K"] = GROSS_K; g["Z"] = GROSS_Z
    return g, farbe


def vorspann_wort(rom, name, wort):
    info = gr.BILDER[name]
    b = gr.bild_lesen(brtext.LZW(rom, info["adr"]).read(0x100000))
    pix = gr.karte_pixel(b, info["breite"])
    g, farbe = vorspann_glyphen(rom)
    breite_px = len(pix[0])
    glyphen = [g[c] for c in wort]
    gesamt = sum(len(x[0]) for x in glyphen) + 2 * (len(glyphen) - 1)
    neu = [[0] * breite_px for _ in pix]
    x = max(1, (breite_px - gesamt) // 2)
    for gl in glyphen:
        for y, r in enumerate(gl):
            for dx, v in enumerate(r):
                if v:
                    neu[1 + y][x + dx] = farbe
        x += len(gl[0]) + 2
    return b, neu


# ---------------------------------------------------------------------------
# G1: PRESENTS -> PRAESENTIERT (rote Schrift, Farbe 3, Umriss Farbe 6, Hintergrund 2 in Palette 2)
def g1_neu(rom):
    info = gr.BILDER["G1_presents"]
    b = gr.bild_lesen(brtext.LZW(rom, info["adr"]).read(0x100000))
    pix = gr.karte_pixel(b, info["breite"])
    ROT, RAND, GRUND = 35, 38, 34
    y0, y1 = 182, 200                     # Zeilen mit Rand
    seg = spalten_segmente(pix, y0, y1, 0, 320, lambda v: v != ROT)
    if len(seg) != 8:
        raise SystemExit("PRESENTS: %d Segmente" % len(seg))
    rot = {}; rand = {}
    for ch, (a, e) in zip("PRESENTS", seg):
        if ch in rot:
            continue
        r = [[1 if pix[y][x] == ROT else 0 for x in range(a, e)] for y in range(y0, y1)]
        # eigener Rand: Randpixel im Abstand <= 2 um diesen Buchstaben
        rd = [[0] * (e - a + 4) for _ in range(y1 - y0 + 4)]
        for yy in range(y0 - 2, y1 + 2):
            for xx in range(a - 2, e + 2):
                if pix[yy][xx] == RAND and any(
                        a <= xx + dx < e and y0 <= yy + dy < y1 and pix[yy + dy][xx + dx] == ROT
                        for dy in range(-2, 3) for dx in range(-2, 3)):
                    rd[yy - y0 + 2][xx - a + 2] = 1
        rot[ch] = r; rand[ch] = rd
    # neue Buchstaben: A (aus P: rechter Strich bis unten), I (linker Strich von P)
    P = rot["P"]; h = len(P); w = len(P[0])
    A = [row[:] for row in P]
    oben = min(y for y in range(h) if P[y][w - 1])
    for y in range(oben, h):
        A[y][w - 2] = A[y][w - 1] = 1
    I = [[r[0], r[1]] for r in P]
    rot["A"] = A; rot["I"] = I
    wort = "PRÄSENTIERT"
    teile = []
    for ch in wort:
        teile.append(("A", True) if ch == "Ä" else (ch, False))
    gesamt = sum(len(rot[c][0]) for c, _ in teile) + 2 * (len(teile) - 1)
    # Bereich leeren (Zeilen 176-205)
    for y in range(176, 206):
        for x in range(320):
            pix[y][x] = GRUND
    x = (320 - gesamt) // 2
    rotfeld = [[0] * 320 for _ in range(240)]
    randfeld = [[0] * 320 for _ in range(240)]
    for ch, umlaut in teile:
        g = rot[ch]; gw = len(g[0])
        for y in range(h):
            for dx in range(gw):
                if g[y][dx]:
                    rotfeld[y0 + y][x + dx] = 1
        if umlaut:
            for (px) in (x + 2, x + gw - 4):
                for yy in (y0 - 3, y0 - 2):
                    rotfeld[yy][px] = rotfeld[yy][px + 1] = 1
        if ch in rand and not umlaut:
            rd = rand[ch]
            for yy in range(len(rd)):
                for xx in range(len(rd[0])):
                    if rd[yy][xx]:
                        randfeld[y0 - 2 + yy][x - 2 + xx] = 1
        x += gw + 2
    # Rand fuer neue Buchstaben (A, I, Umlautpunkte): runde Ausdehnung um 2 px
    kern = [(dy, dx) for dy in range(-2, 3) for dx in range(-2, 3) if abs(dy) + abs(dx) < 4]
    for y in range(170, 206):
        for x in range(2, 318):
            if rotfeld[y][x]:
                continue
            if randfeld[y][x]:
                continue
            for dy, dx in kern:
                if rotfeld[y + dy][x + dx]:
                    # nur um Pixel ohne eigenen Originalrand
                    randfeld[y][x] = 2
                    break
    for y in range(170, 206):
        for x in range(320):
            if rotfeld[y][x]:
                pix[y][x] = ROT
            elif randfeld[y][x]:
                pix[y][x] = RAND
    return b, pix


# ---------------------------------------------------------------------------
# G6: Abspann-Kopf, Zeile "CREATED BY THE" -> "ENTWICKELT VOM" (8-px-Raster, Zeilen 25-30)
KLEIN_V = maske([
    "#....#",
    "#....#",
    "#....#",
    "#....#",
    ".#..#.",
    "..##..",
])


def g6_neu(rom):
    info = gr.BILDER["G6_abspann"]
    b = gr.bild_lesen(brtext.LZW(rom, info["adr"]).read(0x100000))
    pix = gr.karte_pixel(b, info["breite"])
    g = {}
    for y0, start, text in ((1, 169, "BUCK ROGERS"), (17, 129, "COUNTDOWN TO DOOMSDAY"),
                            (25, 161, "CREATED BY THE"), (73, None, "SPECIAL PROJECTS TEAM")):
        if start is None:
            seg = spalten_segmente(pix, y0, y0 + 6, 0, 320, lambda v: v == 0)
            start = seg[0][0] - (seg[0][0] % 8) + 1 if seg else 0
            start = seg[0][0]
            # Raster an den ersten Buchstaben anlehnen
        for i, ch in enumerate(text):
            if ch == " " or ch in g:
                continue
            x0 = start + 8 * i
            g[ch] = [[1 if v else 0 for v in r] for r in ausschnitt(pix, y0, y0 + 6, x0 - 1, x0 + 7)]
    farbe = next(v for r in ausschnitt(pix, 25, 31, 150, 280) for v in r if v)
    vneu = [[0] + r + [0] for r in KLEIN_V]
    g["V"] = vneu
    for y in range(25, 31):
        for x in range(150, 290):
            pix[y][x] = 0
    for i, ch in enumerate("ENTWICKELT VOM"):
        if ch == " ":
            continue
        x0 = 161 + 8 * i - 1
        for y in range(6):
            for dx in range(8):
                if g[ch][y][dx]:
                    pix[25 + y][x0 + dx] = farbe
    return b, pix


# ---------------------------------------------------------------------------
# G7: Raumkampf-Anzeige, Kuerzel 4 Felder breit (Hauptfarbe + Schatten rechts/unten)
KL = {
    "F": ["#####", "#....", "####.", "#....", "#....", "#...."],
    "R": ["####.", "#...#", "#...#", "####.", "#..#.", "#...#"],
    "S": [".####", "#....", ".###.", "....#", "....#", "####."],
    "M": ["#...#", "##.##", "#.#.#", "#...#", "#...#", "#...#"],
    "U": ["#...#", "#...#", "#...#", "#...#", "#...#", ".###."],
    "T": ["#####", "..#..", "..#..", "..#..", "..#..", "..#.."],
    "G": [".####", "#....", "#....", "#..##", "#...#", ".####"],
    "A": [".###.", "#...#", "#...#", "#####", "#...#", "#...#"],
    "N": ["#...#", "##..#", "#.#.#", "#..##", "#...#", "#...#"],
    "P": ["####.", "#...#", "#...#", "####.", "#....", "#...."],
    "W": ["#.....#", "#.....#", "#.....#", "#..#..#", "#..#..#", ".##.##."],
}


# schmale Buchstaben (4 px) fuer 5-stellige Kuerzel (RUMPF), Abstand 2 px wie im Original
KL4 = {
    "R": ["###.", "#..#", "#..#", "###.", "#.#.", "#..#"],
    "U": ["#..#", "#..#", "#..#", "#..#", "#..#", ".##."],
    "M": ["#...#", "##.##", "#.#.#", "#...#", "#...#", "#...#"],
    "P": ["###.", "#..#", "#..#", "###.", "#...", "#..."],
    "F": ["####", "#...", "###.", "#...", "#...", "#..."],
}


def g7_neu(rom, kuerzel):
    info = gr.BILDER["G7_schiff"]
    b = gr.bild_lesen(brtext.LZW(rom, info["adr"]).read(0x100000))
    pix = gr.karte_pixel(b, info["breite"])
    # Felder: (y0, x0, Breite bis vor den Rahmen)
    felder = {"WEAP": (0, 0, 31), "ENGN": (8, 0, 31), "CNTL": (0, 120, 31), "HULL": (8, 120, 31)}
    for alt, (yb, x0, bw) in felder.items():
        werte = {}
        for y in range(yb, yb + 8):
            for x in range(x0, x0 + bw):
                werte[pix[y][x]] = werte.get(pix[y][x], 0) + 1
        grund = max(werte, key=werte.get)
        # Farben je Feld (aus dem Original abgelesen): Strich, Schatten rechts, Schatten unten
        f_haupt, f_rechts, f_unten = {"WEAP": (9, 14, 14), "ENGN": (9, 3, 3),
                                      "CNTL": (1, 12, 4), "HULL": (7, 8, 8)}[alt]
        pal = grund & 0x30
        haupt, s_r, s_u = pal | f_haupt, pal | f_rechts, pal | f_unten
        y0 = min(y for y in range(yb, yb + 8) if haupt in pix[y][x0:x0 + bw])
        for y in range(yb, yb + 8):
            for x in range(x0, x0 + bw):
                pix[y][x] = grund
        wort = kuerzel[alt]
        satz, abstand = (KL4, 2) if len(wort) > 4 else (KL, 1)
        x = x0 + 2
        m = {}
        for ch in wort:
            gl = satz[ch]
            for yy, z in enumerate(gl):
                for xx, c in enumerate(z):
                    if c == "#":
                        m[(y0 + yy, x + xx)] = 1
            x += len(gl[0]) + abstand
        if x - abstand > x0 + bw:
            raise SystemExit("G7 %s zu breit" % wort)
        for (y, xx) in m:
            pix[y][xx] = haupt
        for (y, xx) in m:
            if (y + 1, xx) not in m and y + 1 < yb + 8:
                pix[y + 1][xx] = s_u
        for (y, xx) in m:
            if (y, xx + 1) not in m and xx + 1 < x0 + bw:
                pix[y][xx + 1] = s_r
    return b, pix


# ---------------------------------------------------------------------------
KUERZEL = {"WEAP": "WAFF", "ENGN": "ANTR", "CNTL": "STRG", "HULL": "RUMPF"}
# Bilder, deren Kacheln das Spiel auch ueber feste Nummern nutzt -> Kachelreihenfolge wie im Original.
# G7: Kacheln $00-$17 = Balkenteile, $18 = Leerfeld, $19 = Rand; nur $1A-$29 (Kuerzel) duerfen sich aendern.
# Befund 24.10.2026 (Ares-Screenshot Marcel): mit neu sortierten Kacheln zeigten die Balken Buchstabenstuecke.
FESTE_KACHELN = {"G7_schiff": range(0x00, 0x1A)}
VORSPANN = {"G3_active": "AKTIV", "G4_target": "ZIEL?", "G5_earth": "ERDE"}


def alle(rom):
    out = {}
    out["G1_presents"] = g1_neu(rom)
    for n, w in VORSPANN.items():
        out[n] = vorspann_wort(rom, n, w)
    out["G6_abspann"] = g6_neu(rom)
    out["G7_schiff"] = g7_neu(rom, KUERZEL)
    return out


def main():
    rom = open(gr.ROM, "rb").read()
    os.makedirs(AUS, exist_ok=True); os.makedirs(VORSCHAU, exist_ok=True)
    for name, (b, pix) in alle(rom).items():
        info = gr.BILDER[name]
        if name in FESTE_KACHELN:
            # Kachelnummern wie im Original: das Spiel nutzt hier Kacheln ueber feste Nummern
            kach, karte = gr.pixel_karte_fest(pix, info["breite"], b)
            unveraendert = FESTE_KACHELN[name]
            if any(kach[t] != b["kacheln"][t] for t in unveraendert):
                raise SystemExit("%s: Kacheln mit fester Nummer veraendert" % name)
        else:
            kach, karte = gr.pixel_karte(pix, info["breite"], b["karte"])
        raw = gr.bild_schreiben(dict(b, kacheln=kach, karte=karte))
        blob = gr.lzw_pack(raw)
        if gr.lzw_unpack(blob)[:len(raw)] != raw:
            raise SystemExit("LZW-Rundreise fehlgeschlagen: " + name)
        open(os.path.join(AUS, "grafik_%s.bin" % name.split("_")[0]), "wb").write(blob)
        gr.png_schreiben(pix, gr.standard_paletten(b), os.path.join(VORSCHAU, name + ".png"))
        print("%-12s %3d Kacheln (Original %3d), %5d Byte gepackt" % (name, len(kach), len(b["kacheln"]), len(blob)))
    symbol_optionen(rom)
    return 0


# --- Neues Symbol 110 "Optionen" (Schieberegler, Entscheidung O1 = C, 02.11.2026, claude/Optionen.md) ---
# Symbolformat wie die Bibliothek dat_F14F2: 3 x 3 Kacheln, Karte 0..8, keine eigene Palette (CRAM-Zeile 0:
# 1 gelb, 2 schwarz, 5 violett, 8 dunkelgrau, 9 blau, 11 cyan, 12 hellrot, 15 weiss).
def symbol_optionen_pixel():
    p = [[9 if (x + y) % 2 == 0 else 5 for x in range(24)] for y in range(24)]
    for ty, kx, farbe in ((5, 15, 12), (11, 7, 1), (17, 17, 11)):
        for x in range(2, 22):
            p[ty][x] = 2
            p[ty + 1][x] = 8
        for y in range(ty - 3, ty + 5):
            for x in range(kx - 2, kx + 3):
                rand = y in (ty - 3, ty + 4) or x in (kx - 2, kx + 2)
                p[y][x] = 2 if rand else (15 if x == kx - 1 else farbe)
    return p


def symbol_optionen(rom):
    pix = symbol_optionen_pixel()
    kach = [gr.pixel_kachel([r[tx * 8:tx * 8 + 8] for r in pix[ty * 8:ty * 8 + 8]])
            for ty in range(3) for tx in range(3)]
    # Vorlage: Kopf eines vorhandenen Symbols (Nr. 0), nur Kacheln ersetzen
    adr = int.from_bytes(rom[0xF14F2:0xF14F6], "big")
    b = gr.bild_lesen(gr.lzw_unpack(rom[adr:adr + 0x4000]))
    if len(b["karte"]) != 9 or b["bits"]:
        raise SystemExit("Symbolformat unerwartet")
    raw = gr.bild_schreiben(dict(b, kacheln=kach, karte=list(range(9))))
    blob = gr.lzw_pack(raw)
    if gr.lzw_unpack(blob)[:len(raw)] != raw:
        raise SystemExit("LZW-Rundreise fehlgeschlagen: Symbol 110")
    open(os.path.join(AUS, "symbol_110.bin"), "wb").write(blob)
    print("Symbol 110   %3d Kacheln, %5d Byte gepackt (Optionen, Schieberegler)" % (len(kach), len(blob)))


if __name__ == "__main__":
    sys.exit(main())
