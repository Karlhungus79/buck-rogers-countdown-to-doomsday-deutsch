# Buck Rogers: Countdown to Doomsday (Mega Drive/Genesis) – Disassembly & deutsche Übersetzung

Bit-genaues Disassembly von *Buck Rogers: Countdown to Doomsday* (Electronic Arts/SSI, 1991)
für das Sega Mega Drive/Genesis, als Grundlage für eine deutsche Fan-Übersetzung.

**Stand:** 21.10.2026 – Disassembly baut bit-genau. Übersetzung: Phase 0 (Bestandsaufnahme).

## Benötigte ROM

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

## Bauen (Windows, Doppelklick)

Voraussetzung: Python 3 (https://www.python.org/downloads/). Der Assembler liegt bei.

| Datei | Zweck |
|---|---|
| `03_Tools\1_daten_extrahieren.bat` | Datenblöcke aus der ROM nach `02_Extracted\data\` ziehen (macht `5_` bei Bedarf automatisch) |
| `03_Tools\5_rom_bauen.bat` | ROM bauen → `07_Output_ROM\<Zeitstempel>\` |
| `03_Tools\6_bitgenau_pruefen.bat` | bauen und mit der Original-ROM vergleichen |
| `03_Tools\0_disassembly_erzeugen.bat` | Disassembly komplett neu erzeugen (nur für Werkzeug-Entwicklung, braucht `pip install capstone`) |

Unter Linux: `python3 03_Tools/build.py --pruefen` mit `asl`/`p2bin` im PATH
(oder Umgebungsvariablen `ASL`/`P2BIN`).

## Aufbau

```
01_Original_ROM\     eigene ROM (nicht im Repo)
02_Extracted\
  src\buckrogers.asm  Disassembly (AS-Syntax, Motorola 68000)
  src\macrosetup.asm  Assembler-Grundeinstellungen
  data_manifest.txt   Liste der Datenblöcke (Offset, Länge, CRC32)
  data\               Datenblöcke aus der ROM (nicht im Repo)
03_Tools\             Disassembler, Extraktion, Bau, Assembler (AS)
04_English_Script\    englischer Referenztext (folgt)
05_German_Script\     deutsche Texte, Glossare (folgt)
07_Output_ROM\        Bauten mit Zeitstempel (nicht im Repo)
08_Savestates\        Speicherstände (nicht im Repo)
claude\               Projektdokumentation
```

## Wie das Disassembly entsteht

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

## Bekannte Grenzen

- **Nicht vollständig verschiebbar:** Zeiger innerhalb der Datenblöcke und als
  Immediate-Werte (`move.l #$xxxxx,…`) sind noch Zahlen, keine Labels. Code oder Daten
  zu verschieben verschiebt diese Verweise nicht mit.
- Code, der nur über Funktionszeiger in RAM-Strukturen erreicht wird, kann noch
  als Datenblock vorliegen.
- Labels sind generisch (`sub_`, `loc_`, `jt_`, `dat_` + Adresse). Benennung folgt.

## Werkzeuge und Lizenzen

- Macro Assembler AS, flamewing-Fork (https://github.com/flamewing/asl-releases),
  Commit `592c5fa57b874266bfb625aedaa5197fcd09cec1`, GPL v2 (siehe `03_Tools/AS/COPYING`).
  Windows-Binärdateien aus diesem Stand selbst kompiliert.
- Capstone (https://www.capstone-engine.org/) für die 68000-Dekodierung.

---

## English summary

Bit-perfect disassembly of *Buck Rogers: Countdown to Doomsday* (Sega Mega Drive/Genesis),
base for a German fan translation. No ROM and no game data are included; data blocks are
extracted from your own ROM (`Buck Rogers - Countdown to Doomsday (USA, Europe).md`,
CRC32 `44E3BFFF`, place it in `01_Original_ROM\`). Build on Windows with
`03_Tools\6_bitgenau_pruefen.bat` (build + compare) or `5_rom_bauen.bat` (build);
requires Python 3. Assembler: Macro Assembler AS (flamewing fork), included.
