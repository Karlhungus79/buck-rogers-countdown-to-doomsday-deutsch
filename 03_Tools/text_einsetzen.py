#!/usr/bin/env python3
"""
Setzt die deutschen Dialogtexte ein (Textablage A, Beschreibung: claude/Textablage.md).

Eingang:  05_German_Script\\ecl\\Mxxx.toml  (Feld "de"; leer = englischer Originaltext)
          Original-ROM (englische Texte, Offsets, ECL-Code, Schrift)
Ausgang:  02_Extracted\\deutsch\\texte.bin      Zeigertabellen + Texte ab ROM $108000
          02_Extracted\\deutsch\\font_1bpp.bin  Schrift mit Ä Ö Ü
          02_Extracted\\deutsch\\pruefbericht.txt

Prueft (Projektanweisung 7.5), Fehler mit Text-ID:
  - nur darstellbare Zeichen
  - Steuerzeichen (Zeilenumbruch, ~) in gleicher Reihenfolge wie im Original
  - Menues (HMENU/WHMENU): alle Punkte zusammen hoechstens 39 Zeichen inkl. Trennern
  - Dialog (PRINT/PRINTCLEAR): kein Wort laenger als eine Zeile (36 Zeichen);
    Zeilenzahl wird gemeldet (Grenze noch nicht gemessen -> nur Hinweis)
Bei Fehlern wird nichts geschrieben (Rueckgabe 1).

Aufruf:  4_text_einsetzen.bat  bzw.  python 03_Tools/text_einsetzen.py [--nur-englisch]
         --nur-englisch: alle Texte englisch (Vergleichsbau: muss sich wie das Original verhalten)
"""
import os
import sys
import struct
try:
    import tomllib
except ImportError:
    raise SystemExit("Python 3.11 oder neuer noetig (tomllib). Bitte Python aktualisieren.")

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import brtext as bt
import zeichensatz as zs

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
ROM = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
DE_DIR = os.path.join(ROOT, "05_German_Script", "ecl")
OUT = os.path.join(ROOT, "02_Extracted", "deutsch")

BASIS = 0x108000          # muss zu "org $108000" in 02_Extracted/src/deutsch.asm passen
ROM_ENDE = 0x200000       # ROM wird 2 MB gross
ZEILE = 36                # Zeichen je Dialogzeile (Fenster Spalte 2-37, gemessen 23.10.2026)
MENUE_MAX = 39            # Puffer $FFFFD5AE-$FFFFD5D5
OP_MENUE = {43, 49}       # HMENU, WHMENU
OP_DIALOG = {"PRINT", "PRINTCLEAR"}
SENTINEL = b"?TEXT?\0"    # Ziel fuer Offsets, die im Original kein Textanfang sind


def umbrechen(s, breite=ZEILE):
    """Grober Nachbau des Umbruchs von sub_11CA4: wortweise, Zeilenumbruch $0D erzwingt."""
    zeilen = []
    for absatz in s.split("\n"):
        z = ""
        for w in absatz.split(" "):
            if not z:
                z = w
            elif len(z) + 1 + len(w) <= breite:
                z += " " + w
            else:
                zeilen.append(z)
                z = w
        zeilen.append(z)
    return zeilen


def strings_im_modul(text, refs):
    starts = [0] + [i + 1 for i, c in enumerate(text) if c == 0 and i + 1 < len(text)]
    used = text.index(b"\0", max(refs)) + 1
    return [(o, text[o:text.index(b"\0", o)]) for o in starts if o < used], used


def lade_deutsch(mid):
    if "--nur-englisch" in sys.argv:
        return {}
    p = os.path.join(DE_DIR, "M%03d.toml" % mid)
    if not os.path.exists(p):
        return {}
    d = tomllib.load(open(p, "rb"))
    return {t["id"]: t.get("de", "") for t in d.get("text", [])}


def main():
    rom = bt.load_rom(ROM)
    names = bt.opnames(rom)
    mods = bt.ecl_modules(rom)
    fehler, hinweise = [], []
    stat = dict(gesamt=0, deutsch=0)

    # 1. Texte je Modul kodieren und pruefen
    module = []
    for m in mods:
        refs, _ = bt.string_refs(m["code"])
        liste, used = strings_im_modul(m["text"], refs)
        de = lade_deutsch(m["id"])
        texte = {}
        for n, (off, en) in enumerate(liste):
            tid = "M%03d_%03d" % (m["id"], n)
            stat["gesamt"] += 1
            d = de.get(tid, "")
            if not d:
                texte[off] = en
                continue
            stat["deutsch"] += 1
            try:
                b = zs.kodieren(d)
            except zs.ZeichenFehler as x:
                fehler.append("%s: %s" % (tid, x))
                continue
            st_en = [c for c in en if c in (0x0D, 0x7E)]
            st_de = [c for c in b if c in (0x0D, 0x7E)]
            if st_en != st_de:
                fehler.append("%s: Steuerzeichen weichen ab (Original %d x Umbruch/~, deutsch %d)"
                              % (tid, len(st_en), len(st_de)))
            ops = {names[op] for _, op, _ in refs.get(off, [])}
            if ops & OP_DIALOG:
                for w in zs.anzeigen(b).replace("\n", " ").split(" "):
                    if len(w) > ZEILE:
                        fehler.append("%s: Wort laenger als eine Zeile (%d > %d): %s" % (tid, len(w), ZEILE, w))
                zl = len(umbrechen(zs.anzeigen(b)))
                zl_en = len(umbrechen(en.decode("latin1").replace("\r", "\n")))
                if zl > max(4, zl_en):
                    hinweise.append("%s: %d Zeilen (Original %d)" % (tid, zl, zl_en))
            texte[off] = b
        # Menuegrenze je HMENU/WHMENU-Befehl
        code_ops, _ = bt.parse_ecl(m["code"])
        for p, op, args in code_ops:
            if op in OP_MENUE:
                offs = [v for t, v, _ in args if t == bt.T_STRING]
                if offs:
                    laenge = sum(len(texte[o]) for o in offs) + len(offs) - 1
                    if laenge > MENUE_MAX:
                        ids = ["M%03d_%03d" % (m["id"], [o for o, _ in liste].index(o)) for o in offs]
                        fehler.append("Menue bei ECL 0x%04X (%s): %d Zeichen > %d"
                                      % (p, ", ".join(ids), laenge, MENUE_MAX))
        module.append((m, used, texte))

    # 2. Binaerblock: Modultabelle, je Modul Zeigertabelle (4 Byte je Original-Offset), Texte
    blob = bytearray(4 * len(module))
    for i, (m, used, texte) in enumerate(module):
        tab = len(blob)
        struct.pack_into(">I", blob, 4 * i, BASIS + tab)
        blob += bytes(4 * used)
        sentinel = BASIS + len(blob)
        blob += SENTINEL
        for o in range(used):
            struct.pack_into(">I", blob, tab + 4 * o, sentinel)
        for off, b in sorted(texte.items()):
            struct.pack_into(">I", blob, tab + 4 * off, BASIS + len(blob))
            blob += b + b"\0"
        if len(blob) & 1:
            blob += b"\0"
    frei = ROM_ENDE - BASIS - len(blob)
    if frei < 0:
        fehler.append("Texte passen nicht in die ROM (%d Byte zu viel)" % -frei)

    bericht = ["Pruefbericht text_einsetzen.py",
               "Texte: %d, davon deutsch: %d" % (stat["gesamt"], stat["deutsch"]),
               "Textblock ab $%06X: %d Byte, frei bis 2 MB: %d Byte" % (BASIS, len(blob), frei),
               "", "FEHLER (%d):" % len(fehler)] + fehler + ["", "HINWEISE (%d):" % len(hinweise)] + hinweise
    print("\n".join(bericht[:4]))
    os.makedirs(OUT, exist_ok=True)
    open(os.path.join(OUT, "pruefbericht.txt"), "w", encoding="utf-8").write("\n".join(bericht) + "\n")
    for h in hinweise[:20]:
        print("Hinweis: " + h)
    if fehler:
        for f in fehler:
            print("FEHLER: " + f)
        print("\n%d Fehler - nichts geschrieben. Bericht: %s" % (len(fehler), os.path.join(OUT, "pruefbericht.txt")))
        return 1

    # 3. Schreiben
    open(os.path.join(OUT, "texte.bin"), "wb").write(blob)
    font = rom[0x51102:0x51102 + 512]
    open(os.path.join(OUT, "font_1bpp.bin"), "wb").write(zs.font_1bpp(font))
    print("Geschrieben nach %s (texte.bin, font_1bpp.bin, pruefbericht.txt)" % OUT)
    return 0


if __name__ == "__main__":
    sys.exit(main())
