#!/usr/bin/env python3
"""
Zieht den englischen Referenztext aus der Original-ROM nach 04_English_Script.

  04_English_Script\\ecl\\Mxxx.toml   Dialog/Ereignistexte je ECL-Modul (27 Module)
  04_English_Script\\systemtexte.toml Menues, Kampf, Items, Klassen ... (393 Eintraege)
  04_English_Script\\uebersicht.csv   alles in einer Tabelle (Excel: Semikolon, UTF-8)

Diese Dateien sind Spieldaten und gehoeren NICHT ins Repo (.gitignore).
Sie werden nie von Hand bearbeitet; bei Bedarf einfach neu erzeugen.

Aufruf:  2_text_extrahieren.bat   bzw.  python 03_Tools/text_extrahieren.py [ROM-Pfad]
"""
import os
import sys
import datetime

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import brtext as bt

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
OUT = os.path.join(ROOT, "04_English_Script")
ROM = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")

MENU_OPS = {43, 49}   # HMENU, WHMENU: Eintraege mit "~" verkettet, Puffer 40 Byte


def q(b):
    """Bytes -> TOML-String (Basic String)."""
    s = b.decode("latin1")
    s = s.replace("\\", "\\\\").replace('"', '\\"').replace("\r", "\\r").replace("\n", "\\n")
    return '"' + s + '"'


def csvq(b):
    s = b.decode("latin1").replace("\r", "\\r")
    return '"' + s.replace('"', '""') + '"'


def main():
    rom = bt.load_rom(sys.argv[1] if len(sys.argv) > 1 else ROM)
    names = bt.opnames(rom)
    stamp = datetime.datetime.now().strftime("%d.%m.%Y %H:%M")
    os.makedirs(os.path.join(OUT, "ecl"), exist_ok=True)
    csv = ["id;quelle;befehl;zeichen;en"]
    total = 0
    print("Modul  Code  Text genutzt  Rest-RAM  Strings")
    for m in bt.ecl_modules(rom):
        code, text = m["code"], m["text"]
        refs, end = bt.string_refs(code)
        starts = [0] + [i + 1 for i, c in enumerate(text) if c == 0 and i + 1 < len(text)]
        last = max(refs)
        used = text.index(b"\0", last) + 1
        rest = bt.ECL_RAM_SIZE - len(code) - used
        lines = [
            "# Buck Rogers: Countdown to Doomsday (Mega Drive) - englischer Referenztext",
            "# ECL-Modul %d. NICHT BEARBEITEN - erzeugt von 03_Tools\\text_extrahieren.py am %s" % (m["id"], stamp),
            "# Felder: offset = Byte-Offset im Textblock (so verweist das ECL darauf),",
            "#         befehl = ECL-Befehl(e), die den Text benutzen, ecl = Befehlsposition im Modul",
            "",
            "[modul]",
            "id = %d" % m["id"],
            'ecl_rom = "0x%05X"' % m["ecl_rom"],
            "ecl_bytes = %d" % len(code),
            'text_rom = "0x%05X"' % m["text_rom"],
            "text_bytes = %d" % used,
            "text_anhang_bytes = %d  # Datenrest hinter dem letzten String (unbenutzt)" % (len(text) - used),
            "ram_rest = %d  # frei bis 0x2C00 (ECL-Code + Text muessen in den RAM passen)" % rest,
            "strings = %d" % len([s for s in starts if s < used]),
            "",
        ]
        n = 0
        for off in starts:
            if off >= used:
                break
            s = text[off:text.index(b"\0", off)]
            sid = "M%03d_%03d" % (m["id"], n)
            r = refs.get(off, [])
            ops = sorted({names[op] for _, op, _ in r})
            menu = any(op in MENU_OPS for _, op, _ in r)
            lines += [
                "[[text]]",
                'id = "%s"' % sid,
                "offset = %d" % off,
                "befehl = [%s]" % ", ".join('"%s"' % o for o in ops),
                "ecl = [%s]" % ", ".join('"0x%04X"' % p for p, _, _ in r),
            ]
            if menu:
                lines.append("menue = true  # HMENU/WHMENU: alle Eintraege zusammen max. 39 Zeichen inkl. Trennern")
            if not r:
                lines.append("unbenutzt = true")
            lines += ["en = %s" % q(s), ""]
            csv.append("%s;M%03d;%s;%d;%s" % (sid, m["id"], "/".join(ops), len(s), csvq(s)))
            n += 1
        total += n
        open(os.path.join(OUT, "ecl", "M%03d.toml" % m["id"]), "w", encoding="utf-8", newline="\n").write("\n".join(lines))
        print("M%03d  %5d  %5d        %5d     %4d" % (m["id"], len(code), used, rest, n))

    # Systemtexte
    lines = [
        "# Buck Rogers: Countdown to Doomsday (Mega Drive) - englischer Referenztext",
        "# Systemtexte (Tabelle 0x11DC4, 16-Bit-Offsets). NICHT BEARBEITEN - erzeugt am %s" % stamp,
        "# Zeichen: \\r = Zeilenumbruch, ~ = Trenner zwischen Menuepunkten",
        "",
    ]
    for i, a, s in bt.system_texts(rom):
        sid = "S%03d" % i
        lines += ["[[text]]", 'id = "%s"' % sid, 'rom = "0x%05X"' % a, "en = %s" % q(s), ""]
        csv.append("%s;SYS;;%d;%s" % (sid, len(s), csvq(s)))
    open(os.path.join(OUT, "systemtexte.toml"), "w", encoding="utf-8", newline="\n").write("\n".join(lines))
    open(os.path.join(OUT, "uebersicht.csv"), "w", encoding="utf-8-sig", newline="\r\n").write("\n".join(csv) + "\n")
    print()
    print("%d Dialog-/Ereignistexte und %d Systemtexte nach %s geschrieben." % (total, bt.SYS_COUNT, OUT))


if __name__ == "__main__":
    main()
