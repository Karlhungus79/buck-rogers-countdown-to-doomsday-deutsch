#!/usr/bin/env python3
"""
Setzt die deutschen Dialogtexte ein (Textablage A, Beschreibung: claude/Textablage.md).

Eingang:  05_German_Script\\ecl\\Mxxx.toml        (Feld "de"; leer = englischer Originaltext)
          05_German_Script\\systemtexte.toml      Systemtexte S000-S392 + fertige Gegenstandsnamen
          Original-ROM (englische Texte, Offsets, ECL-Code, Schrift)
Ausgang:  02_Extracted\\deutsch\\texte.bin        Zeigertabellen + Texte ab ROM $108000
          02_Extracted\\deutsch\\systemtexte.bin  Systemtexttabelle ab ROM $101000 (claude/Systemtexte.md)
          02_Extracted\\deutsch\\namen.bin        Tabelle fertiger Gegenstandsnamen
          02_Extracted\\deutsch\\optionen.inc     Mehrzahl-Zeichen fuer DEUTSCH-HOOK 8/9, Zusatztext-Nummern
          02_Extracted\\deutsch\\monster.bin      Monsternamen (DEUTSCH-HOOK 12)
          02_Extracted\\deutsch\\abspann.bin      Abspann (DEUTSCH-HOOK 13)
          02_Extracted\\deutsch\\font_1bpp.bin    Schrift mit Ä Ö Ü
          02_Extracted\\deutsch\\pruefbericht.txt

Prueft (Projektanweisung 7.5), Fehler mit Text-ID:
  - nur darstellbare Zeichen
  - Steuerzeichen (Zeilenumbruch, ~) in gleicher Reihenfolge wie im Original
  - Menues (HMENU/WHMENU): alle Punkte zusammen hoechstens 39 Zeichen inkl. Trennern
  - Dialog (PRINT/PRINTCLEAR): kein Wort laenger als eine Zeile (36 Zeichen);
    Zeilenzahl wird gemeldet (Grenze noch nicht gemessen -> nur Hinweis)
Systemtexte: Zeichen, Steuerzeichen, Leerzeichen am Anfang/Ende wie im Original (Satzbausteine),
  (Ausnahme: leerzeichen_geprueft = true), Menues (~) hoechstens 41 Zeichen, Gegenstandsnamen hoechstens 25 Zeichen (Mehrzahl 21),
  Tabelle kleiner 32 KB (16-Bit-Offsets).
Bei Fehlern wird nichts geschrieben (Rueckgabe 1).

Aufruf:  4_text_einsetzen.bat  bzw.  python 03_Tools/text_einsetzen.py [--nur-englisch]
         --nur-englisch: alle Texte englisch (Vergleichsbau: muss sich wie das Original verhalten)
"""
import os
import sys
import struct
try:
    import tomllib
except ImportError:
    raise SystemExit("Python 3.11 oder neuer noetig (tomllib). Bitte Python aktualisieren.")

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import brtext as bt
import zeichensatz as zs
import deutsch_vorlage as dv

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
ROM = os.path.join(ROOT, "01_Original_ROM", "Buck Rogers - Countdown to Doomsday (USA, Europe).md")
DE_DIR = os.path.join(ROOT, "05_German_Script", "ecl")
OUT = os.path.join(ROOT, "02_Extracted", "deutsch")

BASIS = 0x108000          # muss zu "org $108000" in 02_Extracted/src/deutsch.asm passen
ROM_ENDE = 0x200000       # ROM wird 2 MB gross
ZEILE = 36                # Zeichen je Dialogzeile (Fenster Spalte 2-37, gemessen 23.10.2026)
MENUE_MAX = 39            # Puffer $FFFFD5AE-$FFFFD5D5
OP_MENUE = {43, 49}       # HMENU, WHMENU
OP_DIALOG = {"PRINT", "PRINTCLEAR"}
SENTINEL = b"?TEXT?\0"    # Ziel fuer Offsets, die im Original kein Textanfang sind
SYS_DE = os.path.join(ROOT, "05_German_Script", "systemtexte.toml")
SYS_BASIS = 0x101000      # muss zu "org $101000" in deutsch.asm passen
SYS_GRENZE = 0x108000     # danach beginnt DE_Modultabelle
SYS_MENUE_MAX = 41        # sub_136DA: Puffer -$2A(a6), 42 Byte inkl. Ende
ZUSATZ_ORIGINAL = {"KAMPFBEUTE": 0x91}   # Hook 11: Rueckfallwert S145 'the team has '
NAME_MAX = 25             # Gegenstandszeile: Fenster x2-34 (sub_7FC0) = 33 Zeichen minus "bereit: "
NAME_MAX_ANZAHL = 21      # dazu Anzahl "  3 "


MONSTER_DE = os.path.join(ROOT, "05_German_Script", "monster.toml")
ABSPANN_DE = os.path.join(ROOT, "05_German_Script", "abspann.toml")
MONSTER_MAX = 15          # Namensfeld 16 Byte inkl. Ende
ABSPANN_MAX = 24          # laengste Originalzeile 22 (Ueberschrift), Fenster nicht gemessen


def monster_bauen(rom, fehler, stat):
    """DE_Monstertabelle: je Eintrag Nummer (1 Byte) + Name (16 Byte, mit 0 aufgefuellt), Ende $FF."""
    englisch = "--nur-englisch" in sys.argv
    out = bytearray()
    if not englisch and os.path.exists(MONSTER_DE):
        gesehen = set()
        for m in tomllib.load(open(MONSTER_DE, "rb")).get("monster", []):
            if not m.get("de") or m["nr"] in gesehen:
                continue
            gesehen.add(m["nr"])
            try:
                b = zs.kodieren(m["de"])
            except zs.ZeichenFehler as x:
                fehler.append("Monster %d: %s" % (m["nr"], x))
                continue
            if len(b) > MONSTER_MAX:
                fehler.append("Monster %d: %d Zeichen > %d: %r" % (m["nr"], len(b), MONSTER_MAX, m["de"]))
                continue
            out += bytes([m["nr"]]) + b + bytes(16 - len(b))
            stat["monster"] += 1
    return bytes(out + b"\xFF")


def abspann_bauen(rom, fehler, stat):
    """DE_Abspann im Format von dat_632E; englischer Vergleichsbau = Original-Bytes."""
    if "--nur-englisch" in sys.argv or not os.path.exists(ABSPANN_DE):
        zeilen = [{"art": a, "wert": w} if a in ("bild", "seite") else {"art": a, "en": w or ""}
                  for a, w in dv.abspann(rom)]
    else:
        zeilen = tomllib.load(open(ABSPANN_DE, "rb")).get("zeile", [])
    out = bytearray()
    for n, z in enumerate(zeilen):
        art = z["art"]
        if art in ("bild", "seite"):
            out += bytes([0xFC if art == "bild" else 0xFF, z["wert"]])
        elif art == "ende":
            out.append(0xFD)
        elif art in ("ueberschrift", "name"):
            t = z.get("de") or z.get("en", "")
            try:
                b = zs.kodieren(t) if z.get("de") else t.encode("latin1")
            except zs.ZeichenFehler as x:
                fehler.append("Abspann Zeile %d: %s" % (n, x))
                continue
            if len(b) > ABSPANN_MAX:
                fehler.append("Abspann Zeile %d: %d Zeichen > %d: %r" % (n, len(b), ABSPANN_MAX, t))
            if z.get("de"):
                stat["abspann"] += 1
            out += (b"\xFE" if art == "ueberschrift" else b"") + b + b"\0"
        else:
            fehler.append("Abspann Zeile %d: unbekannte art %r" % (n, art))
    if not out or out[-1] != 0xFD:
        fehler.append("Abspann: letzte Zeile muss art = \"ende\" sein")
    return bytes(out)


def systemtexte_bauen(rom, fehler, hinweise, stat):
    """Systemtexttabelle (wie dat_11DC4) + Namenstabelle + Optionen. Rueckgabe (sys_bin, namen_bin, optionen)."""
    englisch = "--nur-englisch" in sys.argv
    sys_en = dv.systemtexte(rom)
    d = {} if englisch or not os.path.exists(SYS_DE) else tomllib.load(open(SYS_DE, "rb"))
    texte = {t["id"]: t for t in d.get("text", [])}
    out = []
    for i, en in enumerate(sys_en):
        tid = "S%03d" % i
        t = texte.get(tid, {})
        if t.get("leer"):
            out.append(b"")
            stat["sys_deutsch"] += 1
            continue
        de = t.get("de", "")
        if not de:
            out.append(en)
            continue
        stat["sys_deutsch"] += 1
        try:
            b = zs.kodieren(de)
        except zs.ZeichenFehler as x:
            fehler.append("%s: %s" % (tid, x))
            continue
        if [c for c in en if c in (0x0D, 0x7E)] != [c for c in b if c in (0x0D, 0x7E)]:
            fehler.append("%s: Steuerzeichen (Umbruch/~) weichen vom Original ab" % tid)
        for name, f in (("Anfang", lambda x: len(x) - len(x.lstrip(b" "))),
                        ("Ende", lambda x: len(x) - len(x.rstrip(b" ")))):
            if f(en) != f(b) and not t.get("leerzeichen_geprueft"):
                fehler.append("%s: Leerzeichen am %s weichen ab (Original %d, deutsch %d): %r"
                              % (tid, name, f(en), f(b), de))
        if 0x7E in en and len(b) > SYS_MENUE_MAX:
            fehler.append("%s: Menue %d Zeichen > %d" % (tid, len(b), SYS_MENUE_MAX))
        if "max" in t and len(zs.anzeigen(b)) > t["max"]:
            fehler.append("%s: %d Zeichen > %d (max): %r" % (tid, len(zs.anzeigen(b)), t["max"], de))
        out.append(b)

    # Zusatztexte (neue Systemtexte direkt ab Nr. 393, Nummer als Symbol DE_TXT_<NAME> in optionen.inc)
    zusatz_sym = {}
    for z in d.get("zusatz", []):
        try:
            b = zs.kodieren(z["de"])
        except zs.ZeichenFehler as x:
            fehler.append("Zusatz %s: %s" % (z["name"], x))
            b = b"?"
        if "max" in z and len(b) > z["max"]:
            fehler.append("Zusatz %s: %d Zeichen > %d" % (z["name"], len(b), z["max"]))
        zusatz_sym[z["name"]] = len(out)
        out.append(b)
        stat["sys_deutsch"] += 1

    # Fertige Gegenstandsnamen -> neue Systemtexte nach den Zusatztexten
    namen = bytearray(b"\0s" if englisch else b"\0\0")   # Kopf: Mehrzahl-Zeichen beim Zusammensetzen
    for g in d.get("gegenstand", []):
        if not g.get("de"):
            continue
        gid = "Gegenstand %s (%s)" % (g["teile"], g["en"])
        nr = []
        for feld, grenze in (("de", NAME_MAX), ("de_mehrzahl", NAME_MAX_ANZAHL)):
            v = g.get(feld, "")
            if not v:
                nr.append(0)
                continue
            try:
                b = zs.kodieren(v)
            except zs.ZeichenFehler as x:
                fehler.append("%s: %s" % (gid, x))
                b = b"?"
            if len(b) > grenze:
                fehler.append("%s: %s %d Zeichen > %d: %r" % (gid, feld, len(b), grenze, v))
            nr.append(len(out))
            out.append(b)
        namen += bytes(g["teile"]) + b"\0" + struct.pack(">HH", nr[0], nr[1])
        stat["namen"] += 1
    namen += bytes(4)

    tab = bytearray(2 * len(out))
    blob = bytearray()
    for i, b in enumerate(out):
        struct.pack_into(">H", tab, 2 * i, len(tab) + len(blob))
        blob += b + b"\0"
    sys_bin = bytes(tab + blob)
    if len(sys_bin) >= 0x8000:
        fehler.append("Systemtexttabelle %d Byte >= 32 KB (16-Bit-Offsets)" % len(sys_bin))
    gesamt = len(sys_bin) + (len(sys_bin) & 1) + len(namen)
    if SYS_BASIS + gesamt > SYS_GRENZE:
        fehler.append("Systemtexte + Namen %d Byte passen nicht vor $%06X" % (gesamt, SYS_GRENZE))
    stat["sys_byte"] = gesamt
    optionen = ("; erzeugt von text_einsetzen.py - nicht von Hand aendern\n"
                "DE_PLURAL_WAFFE = $%02X\t; Mehrzahl Schiffswaffe (DEUTSCH-HOOK 8), Original $73 's'\n"
                "DE_PLURAL_TP = $%02X\t; Mehrzahl ' Trefferpunkt' (DEUTSCH-HOOK 9), Original $73 's'\n"
                % ((0x73, 0x73) if englisch else (0x20, 0x65)))
    # Zusatztexte: im englischen Vergleichsbau der Originaltext (Rueckfallwert)
    for name, orig in ZUSATZ_ORIGINAL.items():
        optionen += "DE_TXT_%s = $%X\t; Zusatztext (Original S%03d)\n" % (name, zusatz_sym.get(name, orig), orig)
    return sys_bin, bytes(namen), optionen


def umbrechen(s, breite=ZEILE):
    """Grober Nachbau des Umbruchs von sub_11CA4: wortweise, Zeilenumbruch $0D erzwingt."""
    zeilen = []
    for absatz in s.split("\n"):
        z = ""
        for w in absatz.split(" "):
            if not z:
                z = w
            elif len(z) + 1 + len(w) <= breite:
                z += " " + w
            else:
                zeilen.append(z)
                z = w
        zeilen.append(z)
    return zeilen


def strings_im_modul(text, refs):
    starts = [0] + [i + 1 for i, c in enumerate(text) if c == 0 and i + 1 < len(text)]
    used = text.index(b"\0", max(refs)) + 1
    return [(o, text[o:text.index(b"\0", o)]) for o in starts if o < used], used


def lade_deutsch(mid):
    if "--nur-englisch" in sys.argv:
        return {}
    p = os.path.join(DE_DIR, "M%03d.toml" % mid)
    if not os.path.exists(p):
        return {}
    d = tomllib.load(open(p, "rb"))
    return {t["id"]: t.get("de", "") for t in d.get("text", [])}


def main():
    rom = bt.load_rom(ROM)
    names = bt.opnames(rom)
    mods = bt.ecl_modules(rom)
    fehler, hinweise = [], []
    stat = dict(gesamt=0, deutsch=0, sys_deutsch=0, namen=0, sys_byte=0, monster=0, abspann=0)

    # 1. Texte je Modul kodieren und pruefen
    module = []
    for m in mods:
        refs, _ = bt.string_refs(m["code"])
        liste, used = strings_im_modul(m["text"], refs)
        de = lade_deutsch(m["id"])
        texte = {}
        for n, (off, en) in enumerate(liste):
            tid = "M%03d_%03d" % (m["id"], n)
            stat["gesamt"] += 1
            d = de.get(tid, "")
            if not d:
                texte[off] = en
                continue
            stat["deutsch"] += 1
            try:
                b = zs.kodieren(d)
            except zs.ZeichenFehler as x:
                fehler.append("%s: %s" % (tid, x))
                continue
            st_en = [c for c in en if c in (0x0D, 0x7E)]
            st_de = [c for c in b if c in (0x0D, 0x7E)]
            if st_en != st_de:
                fehler.append("%s: Steuerzeichen weichen ab (Original %d x Umbruch/~, deutsch %d)"
                              % (tid, len(st_en), len(st_de)))
            ops = {names[op] for _, op, _ in refs.get(off, [])}
            if ops & OP_DIALOG:
                for w in zs.anzeigen(b).replace("\n", " ").split(" "):
                    if len(w) > ZEILE:
                        fehler.append("%s: Wort laenger als eine Zeile (%d > %d): %s" % (tid, len(w), ZEILE, w))
                zl = len(umbrechen(zs.anzeigen(b)))
                zl_en = len(umbrechen(en.decode("latin1").replace("\r", "\n")))
                if zl > max(4, zl_en):
                    hinweise.append("%s: %d Zeilen (Original %d)" % (tid, zl, zl_en))
            texte[off] = b
        # Menuegrenze je HMENU/WHMENU-Befehl
        code_ops, _ = bt.parse_ecl(m["code"])
        for p, op, args in code_ops:
            if op in OP_MENUE:
                offs = [v for t, v, _ in args if t == bt.T_STRING]
                if offs:
                    laenge = sum(len(texte[o]) for o in offs) + len(offs) - 1
                    if laenge > MENUE_MAX:
                        ids = ["M%03d_%03d" % (m["id"], [o for o, _ in liste].index(o)) for o in offs]
                        fehler.append("Menue bei ECL 0x%04X (%s): %d Zeichen > %d"
                                      % (p, ", ".join(ids), laenge, MENUE_MAX))
        module.append((m, used, texte))

    # 2. Binaerblock: Modultabelle, je Modul Zeigertabelle (4 Byte je Original-Offset), Texte
    blob = bytearray(4 * len(module))
    for i, (m, used, texte) in enumerate(module):
        tab = len(blob)
        struct.pack_into(">I", blob, 4 * i, BASIS + tab)
        blob += bytes(4 * used)
        sentinel = BASIS + len(blob)
        blob += SENTINEL
        for o in range(used):
            struct.pack_into(">I", blob, tab + 4 * o, sentinel)
        for off, b in sorted(texte.items()):
            struct.pack_into(">I", blob, tab + 4 * off, BASIS + len(blob))
            blob += b + b"\0"
        if len(blob) & 1:
            blob += b"\0"
    sys_bin, namen_bin, optionen = systemtexte_bauen(rom, fehler, hinweise, stat)
    monster_bin = monster_bauen(rom, fehler, stat)
    abspann_bin = abspann_bauen(rom, fehler, stat)
    sys_gesamt = stat["sys_byte"] + len(monster_bin) + (len(monster_bin) & 1) + len(abspann_bin)
    if SYS_BASIS + sys_gesamt > SYS_GRENZE:
        fehler.append("Systemtexte + Monster + Abspann %d Byte passen nicht vor $%06X" % (sys_gesamt, SYS_GRENZE))
    frei = ROM_ENDE - BASIS - len(blob)
    if frei < 0:
        fehler.append("Texte passen nicht in die ROM (%d Byte zu viel)" % -frei)

    bericht = ["Pruefbericht text_einsetzen.py",
               "Texte: %d, davon deutsch: %d" % (stat["gesamt"], stat["deutsch"]),
               "Textblock ab $%06X: %d Byte, frei bis 2 MB: %d Byte" % (BASIS, len(blob), frei),
               "Systemtexte: %d, davon deutsch: %d, fertige Gegenstandsnamen: %d, Block ab $%06X: %d Byte (Grenze %d)"
               % (len(dv.systemtexte(rom)), stat["sys_deutsch"], stat["namen"], SYS_BASIS, stat["sys_byte"],
                  SYS_GRENZE - SYS_BASIS),
               "Monsternamen deutsch: %d, Abspann-Zeilen deutsch: %d" % (stat["monster"], stat["abspann"]),
               "", "FEHLER (%d):" % len(fehler)] + fehler + ["", "HINWEISE (%d):" % len(hinweise)] + hinweise
    print("\n".join(bericht[:6]))
    os.makedirs(OUT, exist_ok=True)
    open(os.path.join(OUT, "pruefbericht.txt"), "w", encoding="utf-8").write("\n".join(bericht) + "\n")
    for h in hinweise[:20]:
        print("Hinweis: " + h)
    if fehler:
        for f in fehler:
            print("FEHLER: " + f)
        print("\n%d Fehler - nichts geschrieben. Bericht: %s" % (len(fehler), os.path.join(OUT, "pruefbericht.txt")))
        return 1

    # 3. Schreiben
    open(os.path.join(OUT, "texte.bin"), "wb").write(blob)
    open(os.path.join(OUT, "systemtexte.bin"), "wb").write(sys_bin)
    open(os.path.join(OUT, "namen.bin"), "wb").write(namen_bin)
    open(os.path.join(OUT, "monster.bin"), "wb").write(monster_bin)
    open(os.path.join(OUT, "abspann.bin"), "wb").write(abspann_bin)
    open(os.path.join(OUT, "optionen.inc"), "w", encoding="ascii", newline="\n").write(optionen)
    font = rom[0x51102:0x51102 + 512]
    open(os.path.join(OUT, "font_1bpp.bin"), "wb").write(zs.font_1bpp(font))
    print("Geschrieben nach %s (texte.bin, systemtexte.bin, namen.bin, monster.bin, abspann.bin, optionen.inc, font_1bpp.bin, pruefbericht.txt)" % OUT)
    return 0


if __name__ == "__main__":
    sys.exit(main())
