# Testumgebung – automatische Emulator-Tests (Claude)

Stand: 23.10.2026

Damit Claude Bauten selbst ansehen kann, bevor Marcel testet. **Ersetzt nicht den Test in Ares**
(„bestätigt“ heißt weiterhin: von Marcel im Spiel gesehen).

- Kern: Genesis Plus GX (libretro), Commit 60bee4c (GitHub libretro/Genesis-Plus-GX), ergänzt
  um Exporte für VRAM, CRAM, VDP-Register, 68000-RAM und PC.
  Bauen: `03_Tools\emu_test\kern_bauen.sh` (nur Linux).
- Frontend: `03_Tools\emu_test\mdemu.py` (Python, ctypes): ROM laden, SRAM vorgeben (Ares-`.ram`
  wird auf die ungeraden Bytes umgesetzt), Tasten drücken, Bilder, Savestates (nur intern),
  VRAM-Kacheln als Bild.
- Tastenbelegung im Spiel: C = bestätigen/weiter, Start = Titel überspringen.
- Weg zum Intro (Kaltstart): 900 Bilder, Start, 6 × Start, 3 × rechts („Restore Game“),
  C, C (Spielstand 1), rechts („Begin Adventure“), C → erster Dialog M016_000.
- Spielstand: Marcels `08_Savestates\Buck Rogers - Countdown to Doomsday (gebaut).ram`
  (Team „Pregenerated Team“, Spielbeginn) lädt auch im Testkern.

Grenzen: Ein Bild-für-Bild-Vergleich zweier Bauten läuft auseinander, sobald sich Ladezeiten
unterscheiden (Zufallsgenerator hängt an der Zeit) – siehe `Textablage.md`.
