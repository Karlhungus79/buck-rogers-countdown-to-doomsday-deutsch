#!/usr/bin/env python3
"""
Zieht alle Datenbereiche (Grafik, Text, ECL-Skripte, Tabellen, Musik) aus der
eigenen Original-ROM nach data/*.bin. Diese Dateien sind NICHT im Repo.

Erwartet die ROM in 01_Original_ROM (oder Pfad als Argument):
    Buck Rogers - Countdown to Doomsday (USA, Europe).md
    CRC32 44E3BFFF, 1.048.576 Byte

Aufruf:  1_daten_extrahieren.bat   bzw.  python 03_Tools/extract.py [ROM-Pfad]
"""
import sys, os, zlib

ROM_CRC32 = 0x44E3BFFF
ROM_SIZE = 0x100000


def main():
    root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    dis = os.path.join(root, "02_Extracted")
    rom_path = sys.argv[1] if len(sys.argv) > 1 else os.path.join(
        root, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
    if not os.path.exists(rom_path):
        sys.exit("ROM nicht gefunden: %s\nBitte die Original-ROM dorthin kopieren (siehe README)." % rom_path)
    rom = open(rom_path, "rb").read()
    crc = zlib.crc32(rom) & 0xFFFFFFFF
    if crc != ROM_CRC32 or len(rom) != ROM_SIZE:
        sys.exit("Falsche ROM: CRC32 %08X, %d Byte (erwartet 44E3BFFF, 1048576 Byte)" % (crc, len(rom)))
    n = 0
    for line in open(os.path.join(dis, "data_manifest.txt")):
        if not line.strip() or line.startswith("#"):
            continue
        off, ln, c, fn = line.split(None, 3)
        off, ln, c, fn = int(off, 16), int(ln, 16), int(c, 16), fn.strip()
        chunk = rom[off:off + ln]
        if zlib.crc32(chunk) & 0xFFFFFFFF != c:
            sys.exit("Pruefsumme falsch fuer %s" % fn)
        path = os.path.join(dis, fn)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        open(path, "wb").write(chunk)
        n += 1
    print("%d Datenbloecke nach %s extrahiert. ROM OK (CRC32 %08X)." % (n, os.path.join(dis, "data"), crc))


if __name__ == "__main__":
    main()
