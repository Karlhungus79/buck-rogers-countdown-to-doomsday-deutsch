#!/usr/bin/env python3
"""
Erzeugt src/buckrogers.asm und data_manifest.txt aus dem Tracing (disasm.py).

- Code wird als AS-Quelltext (Motorola-Syntax) ausgegeben.
- Jeder Befehl wird vorab einzeln mit AS assembliert und mit dem Original
  verglichen. Abweichende Befehle werden als dc.w ausgegeben, das
  Original-Mnemonic steht dahinter als Kommentar.
- Datenbereiche werden NICHT in den Quelltext geschrieben, sondern per
  binclude aus data/*.bin eingebunden. Diese Dateien erzeugt tools/extract.py
  aus der eigenen ROM (Liste: data_manifest.txt).

Aufruf:  0_disassembly_erzeugen.bat   bzw.  python 03_Tools/gen_asm.py [ROM-Pfad]
Benoetigt: pip install capstone
"""
import sys, os, re, struct, zlib, subprocess, tempfile
sys.path.insert(0, os.path.dirname(__file__))
from disasm import Disasm, load_rom, ROM_DEFAULT, DIS_DIR

_HERE = os.path.dirname(os.path.abspath(__file__))
_WIN = os.path.join(_HERE, "AS", "win64")
ASL = os.environ.get("ASL") or (os.path.join(_WIN, "asl.exe") if os.name == "nt" else "asl")
P2BIN = os.environ.get("P2BIN") or (os.path.join(_WIN, "p2bin.exe") if os.name == "nt" else "p2bin")
if os.name == "nt":
    os.environ.setdefault("AS_MSGPATH", _WIN)

BIT_OPS = ("btst", "bset", "bclr", "bchg")
NOSIZE = BIT_OPS + ("lea", "pea", "link", "jsr", "jmp", "exg", "swap", "scc", "scs", "seq", "sf", "sge",
                    "sgt", "shi", "sle", "sls", "slt", "smi", "sne", "spl", "st", "svc", "svs", "nbcd", "tas", "unlk")


def lbl_name(a, kind):
    p = {"sub": "sub", "loc": "loc", "jt": "jt", "dat": "dat"}.get(kind, "dat")
    return "%s_%X" % (p, a)


def split_ops(s):
    out, depth, cur = [], 0, ""
    for c in s:
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
        if c == "," and depth == 0:
            out.append(cur.strip())
            cur = ""
        else:
            cur += c
    if cur.strip():
        out.append(cur.strip())
    return out


def hexu(v, neg=False):
    if neg and v < 0:
        return "-$%X" % (-v)
    return "$%X" % v


class Formatter:
    def __init__(self, labels):
        self.labels = labels   # addr -> name

    def ref(self, a):
        return self.labels.get(a)

    def operand(self, op, m, idx, nops):
        op = op.replace(" ", "")
        # Branch-/dbcc-Ziel (letzter Operand, reine Zahl)
        if (m[0] == "b" and m not in BIT_OPS or m.startswith("db")) and idx == nops - 1 and re.fullmatch(r"\$[0-9a-f]+", op):
            a = int(op[1:], 16)
            return self.ref(a) or hexu(a)
        mm = re.fullmatch(r"\$([0-9a-f]+)\.w", op)
        if mm:
            v = int(mm.group(1), 16)
            if v >= 0x8000:
                v |= 0xFFFF0000
            return "(%s).w" % hexu(v)
        mm = re.fullmatch(r"\$([0-9a-f]+)\.l", op)
        if mm:
            v = int(mm.group(1), 16)
            return "(%s).l" % (self.ref(v) or hexu(v))
        mm = re.fullmatch(r"\$([0-9a-f]+)\(pc(,[ad][0-7]\.[wl])?\)", op)
        if mm:
            v = int(mm.group(1), 16)
            return "%s(pc%s)" % (self.ref(v) or hexu(v), mm.group(2) or "")
        mm = re.fullmatch(r"#(-?)\$([0-9a-f]+)", op)
        if mm:
            v = int(mm.group(2), 16) * (-1 if mm.group(1) else 1)
            if m == "moveq" and v >= 0x80:
                v -= 0x100
            if m == "link" and v >= 0x8000:
                v -= 0x10000
            return "#" + hexu(v, neg=True)
        # Displacements in Grossbuchstaben
        op = re.sub(r"\$([0-9a-f]+)", lambda x: "$" + x.group(1).upper(), op)
        return op

    def instr(self, mnemonic, op_str):
        parts = mnemonic.split(".")
        m = parts[0]
        size = parts[1] if len(parts) > 1 else ""
        if m == "dbra":
            m = "dbf"
        if m[0] == "b" and m not in BIT_OPS and size == "b":
            size = "s"
        if m in NOSIZE:
            size = ""
        if m == "move" and ("usp" in op_str) and not size:
            size = "l"
        if m == "illegal":
            return "illegal"
        ops = split_ops(op_str)
        ops = [self.operand(o, m, i, len(ops)) for i, o in enumerate(ops)]
        mn = m + ("." + size if size else "")
        return ("%s\t%s" % (mn, ",".join(ops))).rstrip()


def assemble(src_text, workdir, name):
    asm = os.path.join(workdir, name + ".asm")
    open(asm, "w").write(src_text)
    r = subprocess.run([ASL, "-xx", "-q", "-U", name + ".asm"], cwd=workdir,
                       capture_output=True, text=True)
    out = r.stdout + r.stderr
    p = os.path.join(workdir, name + ".p")
    if not os.path.exists(p):
        return None, out
    b = os.path.join(workdir, name + ".bin")
    subprocess.run([P2BIN, "-l", "0", "-r", "$0-$FFFFF", name + ".p", name + ".bin"], cwd=workdir, capture_output=True)
    return open(b, "rb").read(), out


HEADER = """\tcpu 68000
\tpadding off
\tsupmode on
\tlisting purecode
\tpage 0
"""


def verify_instructions(rom, d, fmt):
    """Assembliert alle Befehle an ihren Originaladressen; liefert Menge der Abweichler."""
    texts = {}
    for a in sorted(d.ins):
        size, mn, op = d.ins[a]
        texts[a] = fmt.instr(mn, op)
    bad = set()
    for attempt in range(20):
        lines = HEADER.rstrip("\n").split("\n")
        for a, name in sorted(fmt.labels.items()):
            lines.append("%s equ $%X" % (name, a))
        line_addr = {}
        for a in sorted(d.ins):
            size = d.ins[a][0]
            lines.append("\torg $%X" % a)
            if a in bad:
                lines.append("\tdc.b\t" + ",".join("$%02X" % b for b in rom[a:a + size]))
            else:
                line_addr[len(lines) + 1] = a     # 1-basierte Zeilennummer
                lines.append("\t" + texts[a])
            lines += ["\tif *<>$%X" % (a + size), "\tmessage \"LEN $%X\"" % a, "\tendif"]
        with tempfile.TemporaryDirectory() as w:
            binr, out = assemble("\n".join(lines) + "\n", w, "verify")
        err_lines = {int(x) for x in re.findall(r"verify\.asm\((\d+)\)[^\n]*error", out)}
        new_bad = {line_addr[l] for l in err_lines if l in line_addr}
        if binr is None and not new_bad:
            raise SystemExit("AS-Fehler beim Verifizieren:\n" + out[-3000:])
        if new_bad:
            bad |= new_bad
            continue
        for mm in re.finditer(r"LEN \$([0-9A-F]+)", out):
            bad.add(int(mm.group(1), 16))
        for a in sorted(d.ins):
            size = d.ins[a][0]
            if a not in bad and binr[a:a + size] != rom[a:a + size]:
                bad.add(a)
        return texts, bad, out
    raise SystemExit("Verifikation konvergiert nicht")


def main():
    rom_path = sys.argv[1] if len(sys.argv) > 1 else ROM_DEFAULT
    rom = load_rom(rom_path)
    os.chdir(DIS_DIR)
    d = Disasm(rom)
    d.run()

    # ---- Labels
    labels = {}
    for a, k in d.labels.items():
        if a < len(rom):
            labels[a] = lbl_name(a, k)
    for a in d.data_refs:
        if a >= 0x200 and a not in labels:
            # Ziel in der Mitte eines Befehls? -> kein Label (Zahl bleibt stehen)
            if a in d.owner and d.owner[a] not in (a, -1):
                continue
            labels[a] = lbl_name(a, "dat")
    # Labels innerhalb von Sprungtabellen (ausser Tabellenstart) und mitten in Befehlen entfernen
    for a in list(labels):
        o = d.owner.get(a)
        if o is not None and o != a and o != -1:
            del labels[a]
        if o == -1 and labels[a][:3] != "jt_":
            # Datenlabel in einer Sprungtabelle
            if not any(t <= a < t + 2 * len(v) and a == t for t, v in d.jtables.items()):
                del labels[a]
    fmt = Formatter(labels)

    texts, bad, out = verify_instructions(rom, d, fmt)
    print("Befehle: %d, davon per AS nicht identisch -> dc.w: %d" % (len(texts), len(bad)))
    from collections import Counter
    c = Counter(texts[a].split("\t")[0] for a in bad)
    print("Abweichler nach Mnemonic:", c.most_common(12))
    for a in sorted(bad)[:12]:
        print("  %06X  %-30s orig %s" % (a, texts[a], rom[a:a + d.ins[a][0]].hex()))

    # ---- Ausgabe
    jt_bytes = {}
    for t, v in d.jtables.items():
        for i, tgt in enumerate(v):
            jt_bytes[t + 2 * i] = tgt
    src = []
    manifest = []
    src.append("; ===========================================================================")
    src.append("; Buck Rogers: Countdown to Doomsday (Mega Drive/Genesis) - Disassembly")
    src.append("; Basis-ROM: Buck Rogers - Countdown to Doomsday (USA, Europe).md")
    src.append(";            CRC32 44E3BFFF, 1.048.576 Byte")
    src.append("; Erzeugt mit 03_Tools/disasm.py + 03_Tools/gen_asm.py. Datenbereiche: data/*.bin")
    src.append("; (aus der eigenen ROM erzeugt mit 03_Tools/extract.py, nicht im Repo).")
    src.append("; ===========================================================================")
    src.append("")
    src.append('\tinclude "src/macrosetup.asm"')
    src.append("")

    # Vektoren + Header (0x000-0x1FF)
    vec = struct.unpack(">64I", rom[:256])
    src.append("; --- Vektortabelle")
    for i, v in enumerate(vec):
        name = labels.get(v) if 0x200 <= v < len(rom) else None
        src.append("\tdc.l\t%s" % (name or "$%08X" % v))
    src.append("; --- ROM-Header")
    hdr = rom[0x100:0x200]
    src.append("Header:")
    for off in range(0, 0x100, 16):
        chunk = hdr[off:off + 16]
        if all(32 <= b < 127 and b != 0x22 for b in chunk):
            src.append('\tdc.b\t"%s"' % chunk.decode())
        else:
            src.append("\tdc.b\t" + ",".join("$%02X" % b for b in chunk))
    src.append("")

    a = 0x200
    n_code = n_dcw = 0
    data_start = None

    def flush_data(end):
        nonlocal data_start
        if data_start is None:
            return
        s, l = data_start, end - data_start
        chunk = rom[s:end]
        if len(set(chunk)) == 1 and l >= 4:
            src.append("\tdc.b\t[%d]$%02X" % (l, chunk[0]))
        elif l <= 8:
            src.append("\tdc.b\t" + ",".join("$%02X" % b for b in chunk))
        else:
            fn = "data/%06X.bin" % s
            manifest.append((s, l, zlib.crc32(chunk) & 0xFFFFFFFF, fn))
            src.append('\tbinclude\t"%s"' % fn)
        data_start = None

    while a < len(rom):
        if a in labels and (a in d.ins or a in jt_bytes or data_start is not None or a not in d.owner):
            if a not in d.ins and a not in jt_bytes:
                flush_data(a)
                src.append("%s:" % labels[a])
                data_start = a
                a += 1
                continue
            flush_data(a)
            if labels[a].startswith("sub_"):
                src.append("")
                src.append("; ---------------------------------------------------------------------------")
            src.append("%s:" % labels[a])
        if a in d.ins:
            flush_data(a)
            size = d.ins[a][0]
            if a in bad:
                words = [rom[i:i + 2].hex().upper() for i in range(a, a + size, 2)]
                src.append("\tdc.w\t%s\t; %s" % (",".join("$" + w for w in words), texts[a].replace("\t", " ")))
                n_dcw += 1
            else:
                src.append("\t" + texts[a])
                n_code += 1
            a += size
        elif a in jt_bytes:
            flush_data(a)
            base = max(t for t in d.jtables if t <= a)
            src.append("\tdc.w\t%s-%s" % (labels.get(jt_bytes[a], "$%X" % jt_bytes[a]), labels[base]))
            a += 2
        else:
            if data_start is None:
                data_start = a
            a += 1
    flush_data(len(rom))
    src.append("")
    src.append("\tEND")

    os.makedirs("src", exist_ok=True)
    open("src/buckrogers.asm", "w").write("\n".join(src) + "\n")
    with open("data_manifest.txt", "w") as f:
        f.write("# Offset  Laenge  CRC32     Datei   (erzeugt von 03_Tools/gen_asm.py)\n")
        for s, l, c, fn in manifest:
            f.write("%06X %06X %08X %s\n" % (s, l, c, fn))
    print("Quelltext: %d Befehle als Mnemonic, %d als dc.w, %d Datenbloecke" % (n_code, n_dcw, len(manifest)))


if __name__ == "__main__":
    main()
