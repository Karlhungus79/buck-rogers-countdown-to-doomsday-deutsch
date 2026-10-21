#!/usr/bin/env python3
"""
Buck Rogers: Countdown to Doomsday (Mega Drive) - Disassembler

Erzeugt aus der Original-ROM ein AS-kompatibles Disassembly (src/buckrogers.asm)
und ein Daten-Manifest (data_manifest.txt). Die Binaerdaten selbst landen NICHT
im Repo, sie werden von tools/extract.py aus der eigenen ROM gezogen.

Vorgehen:
  1. Rekursives Tracing ab Reset-/Interrupt-Vektoren.
  2. Zusaetzliche Einstiegspunkte: C-Funktionsanfaenge (link a6,#n) und
     Funktionszeiger-Tabellen (32-Bit-Werte, die auf link a6 zeigen).
     Kandidaten werden nur uebernommen, wenn das Tracing sauber bleibt.
  3. Jeder Befehl wird einzeln mit AS gegenassembliert (tools/verify).
     Weicht die Kodierung ab, wird der Befehl als dc.w ausgegeben
     (Original-Mnemonic als Kommentar) -> bit-genauer Rebuild garantiert.

Aufruf:  python 03_Tools/disasm.py   (nur Statistik; das Disassembly schreibt gen_asm.py)
Benoetigt: pip install capstone
"""
import sys, os, re, struct, zlib, json
import capstone as cs

ROM_CRC32 = 0x44E3BFFF
ROM_SIZE = 0x100000
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM_DEFAULT = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
DIS_DIR = os.path.join(ROOT, "02_Extracted")

VALID_MNEM = set("""abcd add adda addi addq addx and andi asl asr bcc bcs beq bge bgt bhi ble bls blt bmi bne bpl bvc bvs bra bsr
bchg bclr bset btst chk clr cmp cmpa cmpi cmpm dbcc dbcs dbeq dbf dbra dbge dbgt dbhi dble dbls dblt dbmi dbne dbpl dbt dbvc dbvs
divs divu eor eori exg ext illegal jmp jsr lea link lsl lsr move movea movem movep moveq muls mulu nbcd neg negx nop not or ori pea
reset rol ror roxl roxr rte rtr rts sbcd scc scs seq sf sge sgt shi sle sls slt smi sne spl st svc svs stop sub suba subi subq subx
swap tas trap trapv tst unlk""".split())

END_FLOW = {"rts", "rte", "rtr", "jmp", "bra", "illegal", "stop"}
# Routinen, die nicht zurueckkehren (Fehleranzeige: Text ab a0, danach Endlosschleife)
NORETURN = {0x132A6}

BRANCHES = {"bcc","bcs","beq","bge","bgt","bhi","ble","bls","blt","bmi","bne","bpl","bvc","bvs","bra","bsr"}


def load_rom(path):
    d = open(path, "rb").read()
    crc = zlib.crc32(d) & 0xFFFFFFFF
    if crc != ROM_CRC32 or len(d) != ROM_SIZE:
        sys.exit("Falsche ROM: CRC32 %08X (erwartet %08X), Groesse %d" % (crc, ROM_CRC32, len(d)))
    return d


class Disasm:
    def __init__(self, rom):
        self.rom = rom
        self.md = cs.Cs(cs.CS_ARCH_M68K, cs.CS_MODE_M68K_000)
        self.md.detail = True
        self.ins = {}          # addr -> (size, mnemonic, op_str, targets)
        self.owner = {}        # byte addr -> instr start
        self.labels = {}       # addr -> kind ('sub','loc','dat','ptr')
        self.data_refs = set()
        self.indirect = []     # jmp/jsr (An) ohne aufgeloestes Ziel

    def decode(self, pc):
        if pc & 1 or pc < 0x200 or pc >= len(self.rom):
            return None
        for i in self.md.disasm(self.rom[pc:pc + 10], pc, 1):
            return i
        return None

    @staticmethod
    def valid(i):
        m = i.mnemonic.split(".")[0]
        if m not in VALID_MNEM:
            return False
        o = i.op_str
        if "*" in o or "[" in o or "{" in o:
            return False
        if i.mnemonic in ("link.l", "chk.l", "muls.l", "mulu.l", "divs.l", "divu.l", "extb.l", "tst.l a", "cmpi.l pc"):
            return False
        if m in ("tst", "cmpi") and "(pc" in o.split(",")[-1]:
            return False
        if re.sub(r"\([^)]*\)", "", o).count(",") > 1:
            return False
        if m == "movep":     # in C-Code dieses Spiels nicht zu erwarten
            return False
        # Byte-Immediates: Assembler/Compiler schreiben das obere Byte immer als 0.
        # Andere Werte = nicht-kanonische Kodierung = Daten, kein Code.
        if (m in ("ori", "andi", "subi", "addi", "eori", "cmpi", "move", "btst", "bset", "bclr", "bchg")
                and i.mnemonic.endswith(".b") and o.startswith("#") and len(i.bytes) >= 4 and i.bytes[2] != 0):
            return False
        return True

    def targets(self, i):
        """Kontrollfluss-Ziele und Datenreferenzen eines Befehls."""
        m = i.mnemonic.split(".")[0]
        code, data = [], []
        nums = [int(x, 16) for x in re.findall(r"\$([0-9a-f]+)(?:\(pc|\.l|$|,)", i.op_str)]
        if m in BRANCHES or m.startswith("db"):
            t = int(re.findall(r"\$([0-9a-f]+)\s*$", i.op_str)[0], 16)
            code.append(t)
        elif m in ("jsr", "jmp"):
            mm = re.match(r"^\$([0-9a-f]+)(\.l|\.w|\(pc\))$", i.op_str)
            if mm:
                code.append(int(mm.group(1), 16))
        # Datenreferenzen: pc-relativ oder absolut in ROM
        for mm in re.finditer(r"\$([0-9a-f]+)(\(pc[^)]*\)|\.l)", i.op_str):
            a = int(mm.group(1), 16)
            if a < len(self.rom) and not (m in ("jsr", "jmp") and a in code):
                data.append(a)
        return code, data

    def trace(self, entry, tentative=False):
        """Verfolgt den Kontrollfluss. tentative=True: bei Fehler nichts uebernehmen."""
        new_ins, new_owner, work, seen = {}, {}, [entry], set()
        new_labels, new_data, new_ind = {}, set(), []
        while work:
            pc = work.pop()
            last_call = False
            while True:
                if pc in self.ins or pc in new_ins:
                    break
                if pc in self.owner or pc in new_owner:
                    # Sprung mitten in einen Befehl
                    if tentative:
                        return False
                    break
                i = self.decode(pc)
                if i is None or not self.valid(i):
                    if tentative and not last_call:
                        return False
                    break
                for b in range(pc, pc + i.size):
                    if (b in self.owner or b in new_owner) and b != pc:
                        if tentative:
                            return False
                code, data = self.targets(i)
                new_ins[pc] = (i.size, i.mnemonic, i.op_str)
                for b in range(pc, pc + i.size):
                    new_owner[b] = pc
                m = i.mnemonic.split(".")[0]
                for t in code:
                    if t >= len(self.rom) or t & 1:
                        if tentative:
                            return False
                        continue
                    new_labels[t] = "sub" if m in ("bsr", "jsr") else "loc"
                    work.append(t)
                for a in data:
                    new_data.add(a)
                if m in ("jmp", "jsr") and not code:
                    new_ind.append(pc)
                if m in END_FLOW:
                    break
                if m in ("jsr", "bsr") and any(t in NORETURN for t in code):
                    break
                last_call = m in ("jsr", "bsr")
                pc += i.size
        # uebernehmen
        self.ins.update(new_ins)
        self.owner.update(new_owner)
        for k, v in new_labels.items():
            if self.labels.get(k) != "sub":
                self.labels[k] = v
        self.data_refs |= new_data
        self.indirect += new_ind
        return True

    def find_c_functions(self):
        """link a6,#n nach rts/unlk-Grenzen und Funktionszeiger auf link a6."""
        rom = self.rom
        cands = set()
        for a in range(0x200, len(rom) - 4, 2):
            if rom[a:a + 2] == b"\x4e\x56":
                prev = rom[a - 2:a]
                if prev in (b"\x4e\x75", b"\x4e\x73") or (a - 2) in self.ins:
                    cands.add(a)
        # Zeiger
        for a in range(0, len(rom) - 4, 2):
            v = struct.unpack(">I", rom[a:a + 4])[0]
            if 0x200 <= v < len(rom) and not v & 1 and rom[v:v + 2] == b"\x4e\x56":
                cands.add(v)
        return sorted(cands)

    # ---------------------------------------------------------------
    # Sprungtabellen:  lea T,aN ; adda.w (aN,dX.w),aN ; jmp/jsr (aN)
    #                  lea T,aN ; move.w (aN,dX.w),dY ; jmp/jsr (aN,dY.w)
    # Eintraege = Wort-Offsets relativ zu T.
    # ---------------------------------------------------------------
    def resolve_jump_tables(self):
        found = 0
        for pc in list(self.indirect):
            if pc in self.jt_sites:
                continue
            _, mn, op = self.ins[pc]
            mm = re.match(r"^\((a[0-6])(?:, (d[0-7])\.w)?\)$", op)
            if not mm:
                continue
            areg = mm.group(1)
            prev = sorted(k for k in self.ins if pc - 24 <= k < pc)
            base, form_ok = None, False
            for q in reversed(prev):
                _, m2, o2 = self.ins[q]
                if m2.startswith("adda.w") and o2.startswith("(%s, " % areg) and o2.endswith(", " + areg):
                    form_ok = True
                if m2.startswith("move.w") and o2.startswith("(%s, " % areg) and mm.group(2) and o2.endswith(", " + mm.group(2)):
                    form_ok = True
                lm = re.match(r"^\$([0-9a-f]+)(?:\.l|\(pc\)), " + areg + "$", o2)
                if m2.startswith("lea") and lm:
                    base = int(lm.group(1), 16)
                    break
            if base is None or not form_ok or base in self.jtables:
                continue
            entries, limit, a = [], base + 2 * 256, base
            while a < limit and a + 2 <= len(self.rom):
                if a in self.owner:
                    break
                off = struct.unpack(">h", self.rom[a:a + 2])[0]
                t = base + off
                if t & 1 or not (0x200 <= t < len(self.rom)) or (base <= t < a + 2):
                    break
                i = self.decode(t)
                if i is None or not self.valid(i):
                    break
                entries.append(t)
                limit = min(limit, t) if t > base else limit
                a += 2
            if not entries:
                continue
            # Ziele verfolgen; Tabelle beim ersten Fehler kuerzen
            ok = []
            for t in entries:
                if t in self.ins or self.trace(t, tentative=True):
                    ok.append(t)
                    self.labels.setdefault(t, "loc")
                else:
                    break
            if ok:
                self.jtables[base] = ok
                self.jt_sites.add(pc)
                self.labels[base] = "jt"
                for b in range(base, base + 2 * len(ok)):
                    self.owner.setdefault(b, -1)   # als Daten belegt
                found += 1
        return found

    def gap_candidates(self):
        """Adressen direkt nach Flussende-Befehlen, die wie ein Funktionsanfang aussehen."""
        rom, cands = self.rom, set()
        ends = [a + self.ins[a][0] for a, v in self.ins.items() if v[1].split(".")[0] in END_FLOW]
        ptr_targets = set()
        for a in range(0, len(rom) - 4, 2):
            v = struct.unpack(">I", rom[a:a + 4])[0]
            if 0x200 <= v < 0x40000 and not v & 1:
                ptr_targets.add(v)
        for e in ends:
            a = e
            while a < len(rom) - 2 and rom[a:a + 2] == b"\0\0" and a - e < 16:
                a += 2          # Fuellwoerter ueberspringen
            if a in self.owner or a + 2 > len(rom):
                continue
            w = rom[a:a + 2]
            prologue = (w == b"\x48\xe7" or w == b"\x4e\x56" or
                        (w[0] in (0x2f, 0x3f) and (w[1] & 0xf0) == 0x00))
            if prologue or a in ptr_targets:
                cands.add(a)
        return sorted(cands)

    def run(self):
        self.jtables, self.jt_sites = {}, set()
        vec = struct.unpack(">64I", self.rom[:256])
        self.labels[vec[1]] = "sub"
        entries = [vec[1]] + [v for v in vec[2:] if 0x200 <= v < len(self.rom)]
        for e in entries:
            self.labels.setdefault(e, "sub")
            self.trace(e)
        rounds = 0
        while True:
            rounds += 1
            before = len(self.ins)
            for c in self.find_c_functions():
                if c not in self.owner:
                    if self.trace(c, tentative=True):
                        self.labels[c] = "sub"
            self.resolve_jump_tables()
            for c in self.gap_candidates():
                if c not in self.owner:
                    if self.trace(c, tentative=True):
                        self.labels[c] = "sub"
            if len(self.ins) == before or rounds > 30:
                break
        self.rounds = rounds
        return entries


def main():
    rom_path = sys.argv[1] if len(sys.argv) > 1 else ROM_DEFAULT
    rom = load_rom(rom_path)
    d = Disasm(rom)
    d.run()
    code_bytes = sum(v[0] for v in d.ins.values())
    print("Befehle: %d, Codebytes: %d (%.1f%% der ROM), Labels: %d, indirekte Spruenge: %d, Sprungtabellen: %d, Runden: %d"
          % (len(d.ins), code_bytes, 100.0 * code_bytes / len(rom), len(d.labels), len(d.indirect), len(d.jtables), d.rounds))


if __name__ == "__main__":
    main()
