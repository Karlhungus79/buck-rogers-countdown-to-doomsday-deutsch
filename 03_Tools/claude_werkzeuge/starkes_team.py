"""Erzeugt den Test-Spielstand 'starkes Team' (Spielstand 4) fuer die Testfassung.
Ablauf (Testemulator, 24.10.2026 erprobt): Testfassung booten, Spiel laden -> Spielstand 1 (vorgefertigtes
Team, OHNE Spielort, damit spaeter die Jumper-Frage kommt), im RAM je Figur Byte 46 des Datensatzes
($FFBA68 + n*$D6 + 46 = aktuelle TP) auf TP setzen, im Hauptmenue 'Spiel speichern' -> Spielstand 4.
SRAM wird als Ares-.ram (8 KB, nur ungerade Bytes) geschrieben.
Aufruf: python3 starkes_team.py <test-rom> <ares-ram-ein> <ares-ram-aus> [TP=120]
Fallen: TP > 127 vermeiden (Byte evtl. vorzeichenbehaftet). Im Spiel speichern (START-Menue) speichert den
Spielort mit -> dann keine Jumper-Frage. Das Hauptmenue hat mit geladenem Team KEIN 'Figur ausbilden'
(2. Symbol = Figur entlassen!). Jumper-EXP (max 65535, sonst Ueberlauf) taucht in den Figurendaten nicht auf.
"""
import sys, ctypes as C, os
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'emu_test'))
from mdemu import MD_Emu
rom, ein, aus = sys.argv[1:4]; TP = int(sys.argv[4]) if len(sys.argv) > 4 else 120
ram = open(ein, 'rb').read(); sr = bytearray(0x10000)
for i, b in enumerate(ram): sr[2*i+1] = b
e = MD_Emu(rom, sram=bytes(sr))
def go(seq):
    for t in seq.split():
        if t.startswith('w'): e.run(int(t[1:]))
        else: e.press(t.upper(), hold=4, after=20)
go("w900 start w60 start w60 start w60 start w60 start w60 start w60 start w120 right right right c w90 c w200 c w200")
p = e.lib.retro_br_ram()
for n in range(6):
    a = 0xBA68 + n*0xD6 + 46
    C.memmove(p + (a ^ 1), bytes([TP]), 1)
go("w30 left w30 c w150 right w30 down w30 c w300")   # Spiel speichern -> Spielstand 4
s = e.sram(); out = bytes(s[2*i+1] for i in range(len(ram)))
open(aus, 'wb').write(out); e.shot(aus + '.png')
print(sum(a != b for a, b in zip(out, ram)), 'Bytes geaendert ->', aus)
