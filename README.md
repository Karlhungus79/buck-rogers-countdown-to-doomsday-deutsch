# Buck Rogers: Countdown to Doomsday (Mega Drive/Genesis) – Disassembly & German Translation

[English](#english) | [Deutsch](#deutsch)

---

## English

Bit-perfect disassembly of *Buck Rogers: Countdown to Doomsday* (Electronic Arts/SSI, 1991)
for the Sega Mega Drive/Genesis, serving as the base for a German fan translation.

**Status:** 21 Oct 2026 – the disassembly rebuilds bit-perfect (confirmed on Linux and Windows).
Translation: phase 0 (survey).

### Required ROM

This repository contains **no** ROM and **no** game data (graphics, text, scripts, music).
The data is extracted from your own ROM on the first build.

| | |
|---|---|
| File | `Buck Rogers - Countdown to Doomsday (USA, Europe).md` |
| Size | 1,048,576 bytes |
| CRC32 | `44E3BFFF` |
| MD5 | `f768fbba021636fff3682b9ae116076a` |
| SHA-1 | `89c39f00745f2a8798fe985ad8ce28411b977f9e` |
| Header checksum | `D7B6` |

Place the ROM in `01_Original_ROM\` (file name exactly as above).

### Building (Windows, double-click)

Requirement: Python 3 (https://www.python.org/downloads/). The assembler is included.

| File | Purpose |
|---|---|
| `03_Tools\1_daten_extrahieren.bat` | extract the data blocks from the ROM into `02_Extracted\data\` (done automatically by `5_` if needed) |
| `03_Tools\2_text_extrahieren.bat` | extract the English reference text (dialogue + system text) into `04_English_Script\` |
| `03_Tools\5_rom_bauen.bat` | build the ROM → `07_Output_ROM\<timestamp>\` |
| `03_Tools\6_bitgenau_pruefen.bat` | build and compare with the original ROM |
| `03_Tools\0_disassembly_erzeugen.bat` | regenerate the disassembly from scratch (tool development only, needs `pip install capstone`) |

On Linux: `python3 03_Tools/build.py --pruefen` with `asl`/`p2bin` in the PATH
(or set the environment variables `ASL`/`P2BIN`).

### Layout

```
01_Original_ROM\     your own ROM (not in the repo)
02_Extracted\
  src\buckrogers.asm  disassembly (AS syntax, Motorola 68000)
  src\macrosetup.asm  assembler settings
  data_manifest.txt   list of data blocks (offset, length, CRC32)
  data\               data blocks from the ROM (not in the repo)
03_Tools\             disassembler, extraction, build, assembler (AS)
04_English_Script\    English reference text (generated from your ROM, not in repo)
05_German_Script\     German text, glossaries (to follow)
07_Output_ROM\        timestamped builds (not in the repo)
08_Savestates\        save states (not in the repo)
claude\               project documentation (German)
```

### How the disassembly is made

`03_Tools/disasm.py` traces the program flow from the reset/interrupt vectors and detects
jump tables, C function entry points and function pointers.
`03_Tools/gen_asm.py` writes the code as AS source and **assembles every single instruction
against the original**. If an encoding differs (e.g. AS optimises `0(a0)` to `(a0)`), the
instruction is emitted as `dc.w` with the mnemonic as a comment. This guarantees a
bit-perfect rebuild.

Current coverage:
- 26,658 instructions (about 88 KB of code, range `$000200–$01C000` plus the HBlank handler at `$0F1B64`)
- 2 of them as `dc.w` (AS `0(An)` optimisation)
- 11 resolved jump tables
- 240 data blocks via `binclude`

### Findings so far

- The code was produced by a C compiler (`link a6`/`unlk a6` frames, `movem.l` prologues).
- The game runs on SSI's Gold Box engine with ECL scripts (Event Control Language).
- `sub_9E76`/`sub_9ED8` is the LZW decompressor (9–12 bit codes); `sub_1F5E` is the LZW
  compressor for save games (SRAM). `sub_132A6` is the fatal error display.
- System text (menus, items, combat, ships, classes) is plain ASCII from about `$012000`.
- `$020000–$0EFFFF` holds LZW-compressed data (graphics, maps, monsters, ECL scripts).
- Dialogue: 27 ECL modules, each with an LZW-compressed text block (uppercase ASCII,
  null-terminated), referenced by 16-bit byte offsets (operand type `$80`). See `claude/Textformat.md`.

### Known limitations

- **Not fully relocatable:** pointers inside the data blocks and in immediate values
  (`move.l #$xxxxx,…`) are still plain numbers, not labels. Moving code or data does not
  move these references.
- Code that is only reached through function pointers in RAM structures may still be
  part of a data block.
- Labels are generic (`sub_`, `loc_`, `jt_`, `dat_` + address). Naming will follow.

### Tools and licences

- Macro Assembler AS, flamewing fork (https://github.com/flamewing/asl-releases),
  commit `592c5fa57b874266bfb625aedaa5197fcd09cec1`, GPL v2 (see `03_Tools/AS/COPYING`).
  The Windows binaries were compiled from exactly this revision.
- Capstone (https://www.capstone-engine.org/) for 68000 decoding.

---

## Deutsch

Bit-genaues Disassembly von *Buck Rogers: Countdown to Doomsday* (Electronic Arts/SSI, 1991)
für das Sega Mega Drive/Genesis, als Grundlage für eine deutsche Fan-Übersetzung.

**Stand:** 21.10.2026 – das Disassembly baut bit-genau (unter Linux und Windows bestätigt).
Übersetzung: Phase 0 (Bestandsaufnahme).

### Benötigte ROM

Dieses Repo enthält **keine** ROM und **keine** Spieldaten (Grafik, Text, Skripte, Musik).
Die Daten werden beim ersten Bau aus der eigenen ROM gezogen.

| | |
|---|---|
| Datei | `Buck Rogers - Countdown to Doomsday (USA, Europe).md` |
| Größe | 1.048.576 Byte |
| CRC32 | `44E3BFFF` |
| MD5 | `f768fbba021636fff3682b9ae116076a` |
| SHA-1 | `89c39f00745f2a8798fe985ad8ce28411b977f9e` |
| Header-Checksumme | `D7B6` |

Die ROM gehört nach `01_Original_ROM\` (Dateiname genau wie oben).

### Bauen (Windows, Doppelklick)

Voraussetzung: Python 3 (https://www.python.org/downloads/). Der Assembler liegt bei.

| Datei | Zweck |
|---|---|
| `03_Tools\1_daten_extrahieren.bat` | Datenblöcke aus der ROM nach `02_Extracted\data\` ziehen (macht `5_` bei Bedarf automatisch) |
| `03_Tools\2_text_extrahieren.bat` | englischen Referenztext (Dialoge + Systemtexte) nach `04_English_Script\` ziehen |
| `03_Tools\5_rom_bauen.bat` | ROM bauen → `07_Output_ROM\<Zeitstempel>\` |
| `03_Tools\6_bitgenau_pruefen.bat` | bauen und mit der Original-ROM vergleichen |
| `03_Tools\0_disassembly_erzeugen.bat` | Disassembly komplett neu erzeugen (nur für Werkzeug-Entwicklung, braucht `pip install capstone`) |

Unter Linux: `python3 03_Tools/build.py --pruefen` mit `asl`/`p2bin` im PATH
(oder Umgebungsvariablen `ASL`/`P2BIN`).

### Aufbau

```
01_Original_ROM\     eigene ROM (nicht im Repo)
02_Extracted\
  src\buckrogers.asm  Disassembly (AS-Syntax, Motorola 68000)
  src\macrosetup.asm  Assembler-Grundeinstellungen
  data_manifest.txt   Liste der Datenblöcke (Offset, Länge, CRC32)
  data\               Datenblöcke aus der ROM (nicht im Repo)
03_Tools\             Disassembler, Extraktion, Bau, Assembler (AS)
04_English_Script\    englischer Referenztext (aus der eigenen ROM erzeugt, nicht im Repo)
05_German_Script\     deutsche Texte, Glossare (folgt)
07_Output_ROM\        Bauten mit Zeitstempel (nicht im Repo)
08_Savestates\        Speicherstände (nicht im Repo)
claude\               Projektdokumentation
```

### Wie das Disassembly entsteht

`03_Tools/disasm.py` verfolgt den Programmfluss ab den Reset-/Interrupt-Vektoren,
erkennt Sprungtabellen, C-Funktionsanfänge und Funktionszeiger.
`03_Tools/gen_asm.py` gibt den Code als AS-Quelltext aus und **assembliert jeden Befehl
einzeln gegen das Original**. Weicht eine Kodierung ab (z. B. optimiert AS `0(a0)` zu `(a0)`),
wird der Befehl als `dc.w` mit dem Mnemonic als Kommentar geschrieben. So ist der Rebuild
garantiert bit-genau.

Aktueller Umfang:
- 26.658 Befehle (ca. 88 KB Code, Bereich `$000200–$01C000` plus HBlank-Handler bei `$0F1B64`)
- davon 2 als `dc.w` (AS-Optimierung `0(An)`)
- 11 aufgelöste Sprungtabellen
- 240 Datenblöcke per `binclude`

### Bisherige Erkenntnisse

- Der Code stammt von einem C-Compiler (`link a6`/`unlk a6`, `movem.l`-Prologe).
- Das Spiel läuft auf SSIs Gold-Box-Engine mit ECL-Skripten (Event Control Language).
- `sub_9E76`/`sub_9ED8` ist der LZW-Entpacker (9–12 Bit); `sub_1F5E` ist der LZW-Packer
  für Spielstände (SRAM). `sub_132A6` ist die Fehleranzeige.
- Systemtexte (Menüs, Items, Kampf, Schiffe, Klassen) liegen als ASCII-Klartext ab ca. `$012000`.
- `$020000–$0EFFFF` enthält LZW-gepackte Daten (Grafik, Karten, Monster, ECL-Skripte).
- Dialoge: 27 ECL-Module mit je einem LZW-gepackten Textblock (ASCII-Großbuchstaben,
  `$00`-Ende), Verweis per 16-Bit-Byte-Offset (Operandtyp `$80`). Details `claude/Textformat.md`.

### Bekannte Grenzen

- **Nicht vollständig verschiebbar:** Zeiger innerhalb der Datenblöcke und als
  Immediate-Werte (`move.l #$xxxxx,…`) sind noch Zahlen, keine Labels. Code oder Daten
  zu verschieben verschiebt diese Verweise nicht mit.
- Code, der nur über Funktionszeiger in RAM-Strukturen erreicht wird, kann noch
  als Datenblock vorliegen.
- Labels sind generisch (`sub_`, `loc_`, `jt_`, `dat_` + Adresse). Benennung folgt.

### Werkzeuge und Lizenzen

- Macro Assembler AS, flamewing-Fork (https://github.com/flamewing/asl-releases),
  Commit `592c5fa57b874266bfb625aedaa5197fcd09cec1`, GPL v2 (siehe `03_Tools/AS/COPYING`).
  Windows-Binärdateien aus genau diesem Stand selbst kompiliert.
- Capstone (https://www.capstone-engine.org/) für die 68000-Dekodierung.
