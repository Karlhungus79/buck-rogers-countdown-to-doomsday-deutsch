#!/usr/bin/env python3
"""
Legt die deutschen Textdateien 05_German_Script\\ecl\\Mxxx.toml an (eine je ECL-Modul).

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


if __name__ == "__main__":
    main()
