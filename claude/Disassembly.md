# Disassembly – Aufbau, Werkzeuge, Erkenntnisse

Stand: 21.10.2026

## Ergebnis

- `02_Extracted\src\buckrogers.asm` baut **bit-genau** zur Original-ROM
  (CRC32 44E3BFFF, Header-Checksumme D7B6). Bestätigt am 21.10.2026 unter Linux
  mit AS (flamewing, Commit 592c5fa). Unter Windows mit `03_Tools\AS\win64\asl.exe`
  (gleicher Stand): **bestätigt am 21.10.2026** (Marcel, `6_bitgenau_pruefen.bat`,
  Ausgabe `07_Output_ROM\2026-10-21_22-19-18_pruefung\`, CRC32 44E3BFFF, Checksumme D7B6).
- 26.658 Befehle als Quelltext, 2 als `dc.w` (AS optimiert `0(An)` zu `(An)`:
  `$005FE0 movem.w d2-d3,0(a0)` und `$00FACE move.w 0(a0),d0`).
- 11 Sprungtabellen aufgelöst, 240 Datenblöcke per `binclude` aus `02_Extracted\data\`.

## Entscheidungen (21.10.2026, Marcel)

- GitHub-Repo: **privat**, Name `buck-rogers-countdown-to-doomsday-deutsch`,
  Disassembly und Übersetzung in **einem** Repo.
- Spieldaten **nicht** im Repo: `03_Tools\extract.py` zieht sie aus der eigenen ROM
  (Liste mit CRC32 je Block: `02_Extracted\data_manifest.txt`).
- Repo-Wurzel = Projektordner `H:\Übersetzungen - Disassemblys - Lets Plays\Buck Rogers Disassembly\`.

## Toolchain

| Werkzeug | Version | Zweck |
|---|---|---|
| Macro Assembler AS (flamewing-Fork) | Commit 592c5fa57b874266bfb625aedaa5197fcd09cec1 (13.10.2026) | Assemblieren (wie PS2-Disassembly) |
| AS Windows-Binärdateien | daraus mit Zig 0.17.0 für x86_64-windows-gnu kompiliert | `03_Tools\AS\win64\` |
| Capstone | 5.0.7 | 68000-Dekodierung im Disassembler |
| Ares (Emulator) | v147 | Spieltest, Savestates, Speicher-/VRAM-Ansicht (festgelegt 21.10.2026) |
| Python | 3.x | alle Skripte |

## Skripte (03_Tools)

| Datei | Zweck |
|---|---|
| `disasm.py` | Tracing: Vektoren, Sprungtabellen, C-Funktionen, Funktionszeiger |
| `gen_asm.py` + `0_disassembly_erzeugen.bat` | schreibt `buckrogers.asm` und `data_manifest.txt`, prüft jeden Befehl einzeln mit AS |
| `extract.py` + `1_daten_extrahieren.bat` | Datenblöcke aus der ROM ziehen (prüft ROM-CRC32 und Block-CRC32) |
| `build.py` + `5_rom_bauen.bat` | ROM bauen, Header-Checksumme setzen, Ausgabe in `07_Output_ROM\<Zeitstempel>\` |
| `build.py --pruefen` + `6_bitgenau_pruefen.bat` | zusätzlich Vergleich mit Original |

## Erkenntnisse zur ROM (für Textformat/Phase 1)

- Code ist mit einem **C-Compiler** erzeugt (`link a6`/`unlk a6`, `movem.l` Prologe).
- **Gold-Box-Engine mit ECL-Skripten** (Event Control Language): Befehlsnamen
  wie `PRINTCLEAR`, `INPUTSTRING`, `LOADMONSTER`, `NEWECL` liegen ab ca. `$004534` im Klartext,
  Fehlermeldungen "cant load ecl", "Bad ECL address".
- `sub_9E76`/`sub_9ED8` = **LZW-Entpacker** (9–12 Bit, Fehlermeldungen "decodeString").
- `sub_1F5E` = **LZW-Packer** für Spielstände nach SRAM (meldet "compression overflow").
  (Korrigiert 21.10.2026, vorher fälschlich als Entpacker geführt.)
- `sub_132A6` = Fehleranzeige (Text ab a0, kehrt nicht zurück).
- Systemtexte (Menüs, Items, Kampf, Schiffe, Klassen) als **ASCII-Klartext** ab ca. `$012000`,
  meist Kleinbuchstaben. Credits im Klartext ab ca. `$006331`.
- `$020000–$0EFFFF`: hohe Entropie (~7,9 Bit/Byte) → komprimierte Daten
  (Grafik, ECL-Skripte, Dialoge – alles LZW, siehe `claude\Textformat.md`).
- `$0F0000–$0FFFFF`: fast nur `$FF`-Füllung, dazu HBlank-Handler bei `$0F1B64`.
- VBlank-Handler bei `$00DE8C`, Reset bei `$000200`.

## Offene Punkte

- Zeiger in Datenblöcken und Immediate-Werte noch als Zahlen → nicht verschiebbar.
  Für Texte, die länger werden, ist das der nächste Ausbauschritt.
- Labels benennen (Dekomprimierung, Textausgabe, ECL-Interpreter zuerst).
- Code-Abdeckung prüfen: Funktionen, die nur über Zeiger in RAM erreicht werden.
