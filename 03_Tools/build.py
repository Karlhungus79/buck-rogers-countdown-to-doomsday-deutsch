#!/usr/bin/env python3
"""
Baut die ROM aus dem Disassembly (02_Extracted/src/buckrogers.asm).

Ablauf:
  1. Prueft, ob die Datenbloecke (02_Extracted/data) da sind, sonst Extraktion
     aus der Original-ROM (01_Original_ROM).
  2. Assembliert mit AS (03_Tools/AS/win64/asl.exe bzw. asl unter Linux).
  3. Setzt die Header-Checksumme (Offset 0x18E) neu.
  4. Legt das Ergebnis in 07_Output_ROM/<Zeitstempel>/ ab.
  5. Mit --pruefen: Vergleich mit der Original-ROM (bit-genau?).

Aufruf:  5_rom_bauen.bat  bzw.  6_bitgenau_pruefen.bat
         python 03_Tools/build.py [--pruefen]
"""
import sys, os, subprocess, zlib, struct, datetime, shutil

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
DIS = os.path.join(ROOT, "02_Extracted")
ORIG = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
OUTROOT = os.path.join(ROOT, "07_Output_ROM")
ORIG_CRC = 0x44E3BFFF

if os.name == "nt":
    ASL = os.path.join(HERE, "AS", "win64", "asl.exe")
    P2BIN = os.path.join(HERE, "AS", "win64", "p2bin.exe")
    os.environ["AS_MSGPATH"] = os.path.join(HERE, "AS", "win64")
else:
    ASL = os.environ.get("ASL", "asl")
    P2BIN = os.environ.get("P2BIN", "p2bin")


def crc(b):
    return zlib.crc32(b) & 0xFFFFFFFF


def data_ok():
    man = os.path.join(DIS, "data_manifest.txt")
    for line in open(man):
        if not line.strip() or line.startswith("#"):
            continue
        off, ln, c, fn = line.split(None, 3)
        p = os.path.join(DIS, fn.strip())
        if not os.path.exists(p) or crc(open(p, "rb").read()) != int(c, 16):
            return False
    return True


def fix_checksum(rom):
    rom = bytearray(rom)
    body = rom[0x200:]
    if len(body) & 1:
        body += b"\0"
    s = sum(struct.unpack(">%dH" % (len(body) // 2), body)) & 0xFFFF
    old = struct.unpack(">H", rom[0x18E:0x190])[0]
    rom[0x18E:0x190] = struct.pack(">H", s)
    return bytes(rom), old, s


def main():
    pruefen = "--pruefen" in sys.argv
    if not data_ok():
        print("Datenbloecke fehlen oder sind veraltet -> Extraktion aus der Original-ROM ...")
        r = subprocess.run([sys.executable, os.path.join(HERE, "extract.py")])
        if r.returncode != 0:
            sys.exit(1)
    ts = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    out = os.path.join(OUTROOT, ts + ("_pruefung" if pruefen else ""))
    os.makedirs(out, exist_ok=True)
    pfile = os.path.join(out, "buckrogers.p")
    print("Assembliere ...")
    r = subprocess.run([ASL, "-xx", "-q", "-U", "-L", "src/buckrogers.asm", "-o", pfile],
                       cwd=DIS, capture_output=True, text=True, errors="replace")
    log = r.stdout + r.stderr
    open(os.path.join(out, "bau.log"), "w", encoding="utf-8").write(log)
    lst = os.path.join(DIS, "src", "buckrogers.lst")
    if os.path.exists(lst):
        shutil.move(lst, os.path.join(out, "buckrogers.lst"))
    if r.returncode != 0 or not os.path.exists(pfile) or "error" in log.lower():
        print(log[-4000:])
        print("\nFEHLER beim Assemblieren. Details: %s" % os.path.join(out, "bau.log"))
        sys.exit(1)
    rom_out = os.path.join(out, "Buck Rogers - Countdown to Doomsday (gebaut).md")
    r = subprocess.run([P2BIN, "-l", "0", pfile, rom_out], capture_output=True, text=True, errors="replace")
    if r.returncode != 0 or not os.path.exists(rom_out):
        print(r.stdout + r.stderr)
        sys.exit("FEHLER bei p2bin")
    os.remove(pfile)
    rom, old, new = fix_checksum(open(rom_out, "rb").read())
    open(rom_out, "wb").write(rom)
    c = crc(rom)
    print("Fertig: %s" % rom_out)
    print("Groesse: %d Byte, Header-Checksumme: %04X%s, CRC32: %08X"
          % (len(rom), new, "" if old == new else " (neu gesetzt, vorher %04X)" % old, c))
    if pruefen:
        orig = open(ORIG, "rb").read()
        if rom == orig:
            print("\nBIT-GENAU IDENTISCH mit der Original-ROM (CRC32 %08X)." % ORIG_CRC)
        else:
            diffs = [i for i in range(min(len(rom), len(orig))) if rom[i] != orig[i]]
            print("\nABWEICHUNG: Groesse %d vs. %d, %d Bytes unterschiedlich." % (len(rom), len(orig), len(diffs)))
            for i in diffs[:20]:
                print("  Offset %06X: gebaut %02X, Original %02X" % (i, rom[i], orig[i]))
            sys.exit(2)


if __name__ == "__main__":
    main()
