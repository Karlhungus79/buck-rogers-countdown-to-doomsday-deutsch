#!/usr/bin/env python3
"""Erstellt den Veroeffentlichungs-Patch (BPS und IPS) gegen die Original-ROM.

Eingang:  01_Original_ROM\\Buck Rogers - Countdown to Doomsday (USA, Europe).md  (CRC32 44E3BFFF)
          07_Output_ROM\\Buck Rogers - Countdown to Doomsday (gebaut).md       (deutsche Fassung)
Ausgang:  07_Output_ROM\\<Zeitstempel>_patch\\
            Buck Rogers - Countdown to Doomsday (Deutsch).bps / .ips
            LIESMICH.txt, README.txt (aus 03_Tools\\release\\, Platzhalter ersetzt)
Prueft:   beide Patches werden auf das Original angewendet und muessen die deutsche ROM ergeben.
Aufruf:   10_patch_erstellen.bat  bzw.  python 03_Tools/patch_erstellen.py
"""
import os, sys, zlib, time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
ORIG = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
NEU = os.path.join(ROOT, "07_Output_ROM", "Buck Rogers - Countdown to Doomsday (gebaut).md")
ORIG_CRC = 0x44E3BFFF
NAME = "Buck Rogers - Countdown to Doomsday (Deutsch)"


def crc(b):
    return zlib.crc32(b) & 0xFFFFFFFF


# --- BPS --------------------------------------------------------------------
def vlq(n):
    out = bytearray()
    while True:
        x = n & 0x7F
        n >>= 7
        if n == 0:
            out.append(0x80 | x)
            return bytes(out)
        out.append(x)
        n -= 1


def bps_erstellen(src, dst):
    p = bytearray(b"BPS1") + vlq(len(src)) + vlq(len(dst)) + vlq(0)
    i = 0
    while i < len(dst):
        gleich = i < len(src) and src[i] == dst[i]
        j = i
        while j < len(dst) and (j < len(src) and src[j] == dst[j]) == gleich:
            j += 1
        n = j - i
        if gleich:
            p += vlq(((n - 1) << 2) | 0)          # SourceRead
        else:
            p += vlq(((n - 1) << 2) | 1) + dst[i:j]  # TargetRead
        i = j
    p += src_crc(src) + src_crc(dst)
    p += src_crc(bytes(p))
    return bytes(p)


def src_crc(b):
    return crc(b).to_bytes(4, "little")


def bps_anwenden(src, p):
    assert p[:4] == b"BPS1"
    pos = 4

    def lies():
        nonlocal pos
        d, s = 0, 1
        while True:
            x = p[pos]; pos += 1
            d += (x & 0x7F) * s
            if x & 0x80:
                return d
            s <<= 7
            d += s
    ss, ts, ml = lies(), lies(), lies()
    pos += ml
    out = bytearray()
    so = to = 0
    while pos < len(p) - 12:
        d = lies(); n = (d >> 2) + 1; a = d & 3
        if a == 0:
            out += src[len(out):len(out) + n]
        elif a == 1:
            out += p[pos:pos + n]; pos += n
        elif a == 2:
            d = lies(); so += (-1 if d & 1 else 1) * (d >> 1)
            out += src[so:so + n]; so += n
        else:
            d = lies(); to += (-1 if d & 1 else 1) * (d >> 1)
            for _ in range(n):
                out.append(out[to]); to += 1
    assert len(out) == ts
    assert int.from_bytes(p[-12:-8], "little") == crc(src)
    assert int.from_bytes(p[-8:-4], "little") == crc(bytes(out))
    assert int.from_bytes(p[-4:], "little") == crc(p[:-4])
    return bytes(out)


# --- IPS --------------------------------------------------------------------
def ips_erstellen(src, dst):
    assert len(dst) <= 0x1000000
    p = bytearray(b"PATCH")
    i = 0
    while i < len(dst):
        if i < len(src) and src[i] == dst[i]:
            i += 1
            continue
        j = i
        while j < len(dst) and j - i < 0xFFFF and not (j < len(src) and src[j] == dst[j]
                                                        and j + 1 < len(src) and src[j + 1] == dst[j + 1]):
            j += 1
        if i == 0x454F46:            # Offset "EOF" ist in IPS verboten
            i -= 1
        p += i.to_bytes(3, "big") + (j - i).to_bytes(2, "big") + dst[i:j]
        i = j
    p += b"EOF"
    if len(dst) < len(src):
        p += len(dst).to_bytes(3, "big")
    return bytes(p)


def ips_anwenden(src, p):
    assert p[:5] == b"PATCH"
    out = bytearray(src)
    pos = 5
    while p[pos:pos + 3] != b"EOF":
        o = int.from_bytes(p[pos:pos + 3], "big"); n = int.from_bytes(p[pos + 3:pos + 5], "big"); pos += 5
        if n == 0:
            n = int.from_bytes(p[pos:pos + 2], "big"); v = p[pos + 2]; pos += 3
            data = bytes([v]) * n
        else:
            data = p[pos:pos + n]; pos += n
        if len(out) < o + n:
            out += bytes(o + n - len(out))
        out[o:o + n] = data
    return bytes(out)


def main():
    src = open(ORIG, "rb").read()
    if crc(src) != ORIG_CRC:
        sys.exit("Original-ROM hat CRC32 %08X, erwartet %08X." % (crc(src), ORIG_CRC))
    if not os.path.exists(NEU):
        sys.exit("Deutsche ROM fehlt: %s (zuerst 7_deutsch_bauen.bat)" % NEU)
    dst = open(NEU, "rb").read()
    zeit = time.strftime("%Y-%m-%d_%H-%M-%S")
    aus = os.path.join(ROOT, "07_Output_ROM", zeit + "_patch")
    os.makedirs(aus)
    bps = bps_erstellen(src, dst)
    ips = ips_erstellen(src, dst)
    assert bps_anwenden(src, bps) == dst, "BPS-Pruefung fehlgeschlagen"
    assert ips_anwenden(src, ips) == dst, "IPS-Pruefung fehlgeschlagen"
    open(os.path.join(aus, NAME + ".bps"), "wb").write(bps)
    open(os.path.join(aus, NAME + ".ips"), "wb").write(ips)
    werte = {"{ORIG_CRC}": "%08X" % ORIG_CRC, "{NEU_CRC}": "%08X" % crc(dst),
             "{DATUM}": time.strftime("%d.%m.%Y"), "{DATE}": time.strftime("%Y-%m-%d")}
    for vorlage, ziel in (("LIESMICH_vorlage.txt", "LIESMICH.txt"), ("README_vorlage.txt", "README.txt")):
        t = open(os.path.join(HERE, "release", vorlage), encoding="utf-8").read()
        for k, v in werte.items():
            t = t.replace(k, v)
        open(os.path.join(aus, ziel), "w", encoding="utf-8", newline="\r\n").write(t)
    print("Patch erstellt in", aus)
    print("Original CRC32 %08X  ->  deutsch CRC32 %08X" % (ORIG_CRC, crc(dst)))
    print("BPS %d Byte, IPS %d Byte, beide geprueft (ergeben die deutsche ROM)." % (len(bps), len(ips)))


if __name__ == "__main__":
    main()
