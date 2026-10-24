#!/usr/bin/env python3
"""
Legt die deutschen Textdateien an:
  05_German_Script\\ecl\\Mxxx.toml        Dialogtexte, eine Datei je ECL-Modul
  05_German_Script\\systemtexte.toml      Systemtexte S000-S392 + fertige Gegenstandsnamen

Je Text: id, befehl, en (englisches Original, nur Referenz), de (deutsch, anfangs leer).
Leeres "de" bedeutet: im Bau steht der englische Text.
Vorhandene Dateien werden NIE ueberschrieben (Schutz der Uebersetzung).

Aufruf:  3_deutsch_vorlage.bat  bzw.  python 03_Tools/deutsch_vorlage.py
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import brtext as bt

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
ROM = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
DE_DIR = os.path.join(ROOT, "05_German_Script", "ecl")
SYS_DE = os.path.join(ROOT, "05_German_Script", "systemtexte.toml")
SYS_TAB = 0x11DC4          # dat_11DC4: 16-Bit-Offsets, 393 Eintraege
SYS_ANZ = 393
ITEM_TAB = 0xF17D6         # Gegenstandsvorlagen, 10 Byte je Eintrag, Namensteile in Byte 1-3
ITEM_ANZ = 91


def systemtexte(rom):
    """Liste der englischen Systemtexte (Bytes) aus der Tabelle dat_11DC4."""
    out = []
    for i in range(SYS_ANZ):
        o = int.from_bytes(rom[SYS_TAB + 2 * i:SYS_TAB + 2 * i + 2], "big")
        a = SYS_TAB + o
        out.append(rom[a:rom.index(b"\0", a)])
    return out


def gegenstaende(rom):
    """Namens-Tripel (p1, p2, p3) der Gegenstandsvorlagen, ohne Doppelte, in ROM-Reihenfolge."""
    seen = []
    for i in range(ITEM_ANZ):
        r = rom[ITEM_TAB + 10 * i:ITEM_TAB + 10 * i + 10]
        t = (r[1], r[2], r[3])
        if t not in seen:
            seen.append(t)
    return seen


def systemtexte_vorlage(rom):
    if os.path.exists(SYS_DE):
        return False
    sys_en = systemtexte(rom)
    lines = ["# Buck Rogers: Countdown to Doomsday - deutsche Systemtexte (Tabelle dat_11DC4)",
             "# de = deutsch (leer = englisches Original bleibt), leer = true: absichtlich leerer Text.",
             "# Leerzeichen am Anfang/Ende sind Teil des Textes (Satzbausteine) und muessen bleiben.",
             "# \\n = Zeilenumbruch (nur wo das Original einen hat), ~ = Trenner zwischen Menuepunkten.",
             ""]
    for i, en in enumerate(sys_en):
        lines += ["[[text]]", 'id = "S%03d"' % i, "en = " + q(en.decode("latin1")), 'de = ""', ""]
    lines += ["# Fertige Gegenstandsnamen (DEUTSCH-HOOK 6/7): teile = Namensteile p1,p2,p3 aus der",
              "# Gegenstandstabelle (ROM $F17D6). Leeres de = aus den Teilen zusammengesetzt.",
              "# de_mehrzahl: Form fuer Anzahl ab 2 (leer = wie Einzahl).", ""]
    for t in gegenstaende(rom):
        en = " ".join(sys_en[x].decode("latin1") for x in (t[2], t[1], t[0]) if x)
        lines += ["[[gegenstand]]", "teile = [%d, %d, %d]" % t, "en = " + q(en), 'de = ""', 'de_mehrzahl = ""', ""]
    open(SYS_DE, "w", encoding="utf-8", newline="\n").write("\n".join(lines))
    return True


def q(s):
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("\r", "\\n") + '"'


def main():
    rom = bt.load_rom(ROM)
    names = bt.opnames(rom)
    os.makedirs(DE_DIR, exist_ok=True)
    neu = alt = 0
    for m in bt.ecl_modules(rom):
        p = os.path.join(DE_DIR, "M%03d.toml" % m["id"])
        if os.path.exists(p):
            alt += 1
            continue
        refs, _ = bt.string_refs(m["code"])
        text = m["text"]
        used = text.index(b"\0", max(refs)) + 1
        starts = [0] + [i + 1 for i, c in enumerate(text) if c == 0 and i + 1 < used]
        lines = ["# Buck Rogers: Countdown to Doomsday - deutscher Dialogtext, ECL-Modul %d" % m["id"],
                 "# de = deutscher Text (leer = englisches Original bleibt). en = nur Referenz, nicht aendern.",
                 "# Zeichen: normale Gross-/Kleinschreibung, ä ö ü Ä Ö Ü, ß; \\n = Zeilenumbruch (nur wo das Original einen hat).",
                 ""]
        for n, off in enumerate(starts):
            en = text[off:text.index(b"\0", off)].decode("latin1")
            ops = sorted({names[op] for _, op, _ in refs.get(off, [])})
            lines += ["[[text]]", 'id = "M%03d_%03d"' % (m["id"], n),
                      "befehl = [%s]" % ", ".join('"%s"' % o for o in ops)]
            if any(op in (43, 49) for _, op, _ in refs.get(off, [])):
                lines.append("menue = true")
            if not refs.get(off):
                lines.append("unbenutzt = true")
            lines += ["en = " + q(en), 'de = ""', ""]
        open(p, "w", encoding="utf-8", newline="\n").write("\n".join(lines))
        neu += 1
    print("%d Dateien neu angelegt, %d vorhandene unveraendert gelassen (%s)." % (neu, alt, DE_DIR))
    if systemtexte_vorlage(rom):
        print("Systemtexte angelegt: %s" % SYS_DE)
    else:
        print("Systemtexte vorhanden, unveraendert gelassen: %s" % SYS_DE)


if __name__ == "__main__":
    main()
