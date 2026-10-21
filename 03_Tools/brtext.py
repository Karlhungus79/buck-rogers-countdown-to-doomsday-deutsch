#!/usr/bin/env python3
"""
brtext.py - Gemeinsame Bibliothek fuer Text-Werkzeuge (Buck Rogers MD).

Enthaelt:
  - LZW-Dekoder (Nachbau von sub_9E76 / sub_9ED8 / sub_A092 im Spiel)
  - Lesen der ECL-Modultabellen (sub_40D0)
  - ECL-Bytecode-Parser (Opcode-Tabelle aus den Handlern ab jt_336E abgeleitet)
  - Systemtext-Tabelle (dat_11DC4)

Erkenntnisse und Begruendungen: claude/Textformat.md
"""
import struct
import zlib

ROM_CRC32 = 0x44E3BFFF
ROM_SIZE = 0x100000

# --- Adressen in der Original-ROM -------------------------------------------
ECL_IDS = 0x38CE6          # Liste der Modul-IDs (Bytes, Ende = Byte >= 0x80)
ECL_TAB_PTR = 0x38CE2      # Langwort -> Offsettabelle ECL-Code (0x38D02)
TXT_TAB_PTR = 0x42B0A      # Langwort -> Offsettabelle Textbloecke (0x42B2A)
ECL_RAM = 0xFFFF6AF6       # Ladeadresse ECL-Code im RAM
ECL_RAM_END = 0xFFFF96F6   # Ende des Bereichs (dahinter ECL-Variablen, sub_115A)
ECL_RAM_SIZE = ECL_RAM_END - ECL_RAM   # 0x2C00 = 11264 Byte fuer Code + Text
OPNAMES_ADR = 0x452A       # Opcode-Namen (EXIT, GOTO, ...), nullterminiert
SYS_BASE = 0x11DC4         # Systemtexte: Tabelle 16-Bit-Offsets relativ zu SYS_BASE
SYS_COUNT = 0x312 // 2     # 393 Eintraege (erster Offset 0x312 = Tabellengroesse)


def load_rom(path):
    rom = open(path, "rb").read()
    crc = zlib.crc32(rom) & 0xFFFFFFFF
    if crc != ROM_CRC32 or len(rom) != ROM_SIZE:
        raise SystemExit("Falsche ROM: CRC32 %08X, %d Byte (erwartet %08X, %d Byte)"
                         % (crc, len(rom), ROM_CRC32, ROM_SIZE))
    return rom


# --- LZW ----------------------------------------------------------------------
class LZW:
    """LZW wie im Spiel: 9..12 Bit, Code 0x100 = Reset, 0x101 = Ende,
    MSB-zuerst, verkuerzte Codes (n-1 Bit, wenn der Wert eindeutig ist)."""

    def __init__(self, rom, addr):
        self.rom = rom
        self.start = addr
        self.p = addr
        self.step = 1 if (addr & 0xFF0000) == 0x200000 else 0   # SRAM: nur ungerade Bytes
        self.buf = 0
        self.nb = 0
        self.prefix = {}
        self.suffix = {}
        self.pending = []
        self.done = False
        self._reset()

    def _reset(self):
        self.next = 0x102
        self.thr = 2
        self.first = True
        self.width = 9
        self.maxc = 0x1FF

    def _code(self):
        while self.nb <= 0x18:
            self.buf |= self.rom[self.p] << (0x18 - self.nb)
            self.buf &= 0xFFFFFFFF
            self.p += 1 + self.step
            self.nb += 8
        n = self.width
        v = self.buf >> (0x21 - n)
        if v > self.thr:
            self.buf = (self.buf << (n - 1)) & 0xFFFFFFFF
            used = n - 1
        else:
            top = (self.buf >> (32 - n)) & 1
            self.buf = (self.buf << n) & 0xFFFFFFFF
            used = n
            if top:
                v |= 1 << (n - 1)
        self.nb -= used
        return v

    def _expand(self, c):
        out = []
        while c > 0xFF:
            out.append(self.suffix[c])
            c = self.prefix[c]
        out.append(c)
        out.reverse()
        return out

    def read(self, count):
        while len(self.pending) < count and not self.done:
            c = self._code()
            if c == 0x101:
                self.done = True
                break
            if self.first:
                self.first = False
                self.old = c
                self.fch = c
                self.pending.append(c)
                continue
            if c == 0x100:
                self._reset()
                continue
            s = self._expand(self.old) + [self.fch] if c >= self.next else self._expand(c)
            self.pending.extend(s)
            fch = s[0]
            if self.next <= self.maxc:
                self.prefix[self.next] = self.old
                self.suffix[self.next] = fch
                self.next += 1
                self.thr = (self.thr + 1) & 0xFFFF
                if self.next == self.maxc and self.width < 12:
                    self.width += 1
                    self.maxc = (1 << self.width) - 1
                    self.thr = 0xFFFF
            self.old = c
            self.fch = fch
        out = bytes(self.pending[:count])
        self.pending = self.pending[count:]
        return out


def lzw_unpack(rom, addr, limit=0x40000):
    d = LZW(rom, addr)
    data = d.read(limit)
    return data, d.p - addr


# --- ECL-Module ---------------------------------------------------------------
def be32(rom, a):
    return struct.unpack(">I", rom[a:a + 4])[0]


def ecl_modules(rom):
    """Liefert je Modul: id, ROM-Adressen, Code, Text (wie das Spiel sie entpackt)."""
    ids = []
    p = ECL_IDS
    while rom[p] < 0x80:
        ids.append(rom[p])
        p += 1
    t1 = be32(rom, ECL_TAB_PTR)
    t2 = be32(rom, TXT_TAB_PTR)
    mods = []
    for i, mid in enumerate(ids):
        a1 = t1 + be32(rom, t1 + 4 * i)
        a2 = t2 + be32(rom, t2 + 4 * i)
        code, n1 = lzw_unpack(rom, a1, ECL_RAM_SIZE)
        text, n2 = lzw_unpack(rom, a2, ECL_RAM_SIZE)
        mods.append(dict(index=i, id=mid, ecl_rom=a1, ecl_packed=n1, code=code,
                         text_rom=a2, text_packed=n2, text=text))
    return mods


# --- ECL-Parser ---------------------------------------------------------------
def opnames(rom):
    return [n.decode("latin1") for n in rom[OPNAMES_ADR:0x4830].split(b"\0")][:94]


# Feste Operandenzahl je Opcode. Aus den Handlern (jt_336E) abgeleitet; fuer
# Befehle, die das Spiel nicht unterstuetzt ("command not supported!"), aus der
# Tabelle dat_482E. Geprueft: alle 2407 Strings der 27 Module werden genau so
# referenziert (siehe claude/Textformat.md).
OPS_FIX = {0: 0, 1: 1, 2: 1, 3: 2, 4: 3, 5: 3, 6: 3, 7: 3, 8: 2, 9: 2, 10: 1, 11: 3, 12: 4,
           13: 0, 14: 1, 15: 2, 16: 3, 17: 1, 18: 1, 19: 0, 20: 4, 22: 0, 23: 0, 24: 0,
           25: 0, 26: 0, 27: 0, 28: 0, 29: 2, 30: 6, 31: 4, 32: 1, 33: 3, 34: 3, 35: 3,
           36: 0, 40: 3, 41: 0, 42: 3, 44: 0, 45: 0, 46: 5, 47: 3, 48: 3, 50: 1, 51: 0,
           52: 1, 53: 3, 54: 2, 55: 1, 56: 1, 57: 1, 58: 0, 59: 3, 60: 1, 61: 0, 62: 0,
           63: 2, 64: 2, 65: 2, 66: 0, 67: 1, 68: 0, 69: 2, 70: 2, 71: 0, 72: 1, 73: 6,
           74: 0, 75: 1, 76: 2, 77: 0, 78: 0, 79: 0, 80: 0, 81: 1, 82: 0, 83: 4, 84: 3,
           85: 4, 86: 3, 87: 1, 88: 0, 89: 1, 90: 0, 91: 0}
# Variable Laenge: Variable, Anzahl N, dann N (bzw. 4*N) Operanden
OPS_LIST = {37: 1, 38: 1, 39: 1, 43: 1, 49: 1, 92: 4}

T_STRING = 0x80   # Operandtyp: 16-Bit-Offset (little endian) in den Textblock


def operand(e, p):
    t = e[p]
    if t == 0:
        return p + 2, (t, e[p + 1])
    if t == 4:
        return p + 5, (t, int.from_bytes(e[p + 1:p + 5], "little"))
    return p + 3, (t, e[p + 1] | e[p + 2] << 8)


def parse_one(e, p):
    """Ein Befehl ab p -> (op, [(typ, wert, pos)], naechste Position) oder None."""
    op = e[p]
    q = p + 1
    args = []

    def take():
        nonlocal q
        pos = q
        q, (t, v) = operand(e, q)
        args.append((t, v, pos))
        return v

    try:
        if op in OPS_LIST:
            take()
            n = take()
            for _ in range(n * OPS_LIST[op]):
                take()
        elif op in OPS_FIX:
            for _ in range(OPS_FIX[op]):
                take()
        else:
            return None
    except IndexError:
        return None
    if q > len(e):
        return None
    return op, args, q


def parse_ecl(e, start=0x14):
    """Linear ab Ende des Kopfes (5 GOTO-Vektoren). Bricht am Datenanhang ab
    (einige Module haben am Ende Tabellen statt Code)."""
    out = []
    p = start
    while p < len(e):
        r = parse_one(e, p)
        if r is None:
            break
        op, args, q = r
        out.append((p, op, args))
        p = q
    return out, p


def string_refs(e):
    """{offset: [(ecl_pos, opcode, operand_pos), ...]} fuer alle String-Operanden."""
    out, end = parse_ecl(e)
    refs = {}
    for p, op, args in out:
        for t, v, pos in args:
            if t == T_STRING:
                refs.setdefault(v, []).append((p, op, pos))
    return refs, end


# --- Systemtexte ----------------------------------------------------------------
def system_texts(rom):
    offs = struct.unpack(">%dH" % SYS_COUNT, rom[SYS_BASE:SYS_BASE + 2 * SYS_COUNT])
    res = []
    for i, o in enumerate(offs):
        a = SYS_BASE + o
        s = rom[a:rom.index(b"\0", a)]
        res.append((i, a, s))
    return res
