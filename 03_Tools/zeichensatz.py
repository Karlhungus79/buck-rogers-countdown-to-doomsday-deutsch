#!/usr/bin/env python3
"""
Zeichensatz der deutschen Fassung (Beschreibung: claude/Zeichensatz.md).

Die Spielschrift: 64 Zeichen $20-$5F, 1 Bit pro Pixel, 8x8, ROM $051102 (dat_51102),
wird von sub_A71E bei jedem Bildschirmaufbau nach VRAM-Kachel 6 geladen.
Die Ausgaberoutine sub_11CA4 rechnet Kleinbuchstaben ($60-$7F) auf $40-$5F um,
d.h. im Original erscheint alles in GROSSBUCHSTABEN.

Kodierung deutscher Texte (Bytes in der ROM):
  A-Z 0-9 Satzzeichen  wie ASCII
  a-z                  wie ASCII (Spiel zeigt sie derzeit gross an)
  Ä Ö Ü                $5B $5C $5D  (Plaetze der ungenutzten Zeichen [ £ ])
  ä ö ü                $7B $7C $7D  (Spiel faltet sie auf $5B-$5D -> Ä Ö Ü)
  ß                    $7F nur mit Kleinbuchstaben-Schrift, sonst "SS"
  Zeilenumbruch \\r     $0D,  Menue-Trenner ~ $7E
"""
import os

KLEINBUCHSTABEN = False   # Grundsatz G1: erst nach Entscheidung zur Schrift (siehe Zeichensatz.md)

# Neue Glyphen fuer die Plaetze $5B-$5D (Spalten wie die Grossbuchstaben, Punkte in Zeile 0)
GLYPHEN = {
    0x5B: ["..#..#..",   # Ä
           "........",
           "..####..",
           ".#....#.",
           ".#.####.",
           ".#....#.",
           ".#....#.",
           "........"],
    0x5C: ["..#..#..",   # Ö
           "........",
           "..####..",
           ".#....#.",
           ".#....#.",
           ".#....#.",
           "..####..",
           "........"],
    0x5D: ["..#..#..",   # Ü
           "........",
           ".#....#.",
           ".#....#.",
           ".#....#.",
           ".#....#.",
           "..####..",
           "........"],
}

ERLAUBT = set(b" !%'(),-.0123456789:;<=?ABCDEFGHIJKLMNOPQRSTUVWXYZ#/+")
ERLAUBT |= set(range(0x61, 0x7B)) | {0x5B, 0x5C, 0x5D, 0x7B, 0x7C, 0x7D, 0x0D, 0x7E}
if KLEINBUCHSTABEN:
    ERLAUBT.add(0x7F)

UMLAUT = {"Ä": b"\x5B", "Ö": b"\x5C", "Ü": b"\x5D", "ä": b"\x7B", "ö": b"\x7C", "ü": b"\x7D",
          "\r": b"\x0D", "\n": b"\x0D"}


class ZeichenFehler(ValueError):
    pass


def kodieren(text):
    """Deutscher Text (str) -> Bytes fuer die ROM. Unbekannte Zeichen -> ZeichenFehler."""
    out = bytearray()
    for ch in text:
        if ch in UMLAUT:
            out += UMLAUT[ch]
        elif ch == "ß":
            out += b"\x7F" if KLEINBUCHSTABEN else b"SS"
        elif ch in "„“”«»":
            out += b"'"          # Anfuehrungszeichen: Spiel kennt nur ' (Glossar/Typografie)
        elif ch == "’":
            out += b"'"
        elif ch == "…":
            out += b"..."
        elif ch == "–":
            out += b"-"
        else:
            if ord(ch) > 0x7F:
                raise ZeichenFehler("Zeichen nicht darstellbar: %r" % ch)
            b = ch.encode("ascii")
            if b[0] not in ERLAUBT:
                raise ZeichenFehler("Zeichen nicht darstellbar: %r" % ch)
            out += b
    return bytes(out)


def anzeigen(b):
    """So zeigt das Spiel die Bytes an (Grossbuchstaben-Faltung wie sub_11CA4)."""
    s = ""
    for c in b:
        if c == 0x0D:
            s += "\n"
            continue
        if not KLEINBUCHSTABEN and c >= 0x60:
            c -= 0x20
        s += {0x5B: "Ä", 0x5C: "Ö", 0x5D: "Ü", 0x7B: "ä", 0x7C: "ö", 0x7D: "ü", 0x7F: "ß"}.get(c, chr(c))
    return s


def font_1bpp(original_font):
    """Original-Schrift (512 Byte) mit den neuen Glyphen."""
    f = bytearray(original_font)
    assert len(f) == 512
    for code, rows in GLYPHEN.items():
        i = (code - 0x20) * 8
        f[i:i + 8] = bytes(int(r.replace(".", "0").replace("#", "1"), 2) for r in rows)
    return bytes(f)
