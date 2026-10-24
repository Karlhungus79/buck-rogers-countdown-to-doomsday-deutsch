# Textablage A – Umsetzung (Dialogtexte direkt aus der ROM)

Stand: 24.10.2026 – **in Ares bestätigt am 24.10.2026** (Bau CRC32 E60AE2AA: Start, Spielstand, Intro M016_000–002).

Entscheidung A vom 21.10.2026 (Begründung: `Textformat.md`). Dieses Dokument beschreibt,
wie sie umgesetzt ist.

## Prinzip

- Original: Beim Laden eines ECL-Moduls entpackt `sub_40D0` erst den ECL-Code, dann den
  Textblock nach `$FFFF6AF6…`; `$FFFFB9A4` zeigt auf den Textanfang. Ein Text-Operand ($80)
  ist ein Byte-Offset; `sub_404A`/`loc_40AA` rechnet `Offset + ($FFFFB9A4)`.
- Deutsch: Der Text wird nicht mehr entpackt. `$FFFFB9A4` zeigt auf eine **Zeigertabelle des
  Moduls in der ROM** (ein Langwort je Original-Offset). `loc_40AA` holt daraus die Adresse
  des deutschen Textes. Der ECL-Code bleibt unverändert (kein Neupacken, keine neuen Offsets).
- Geprüft: `$FFFFB9A4` wird nur an diesen 3 Stellen benutzt (2× `sub_40D0`, 1× `loc_40AA`).
  Alle Befehle mit Text (PRINT, PRINTCLEAR, HMENU, WHMENU, SAVE, COMPARE, WHO) holen den Text
  über `sub_404A` und arbeiten mit der vollen 32-Bit-Adresse (SAVE kopiert per strcpy,
  COMPARE vergleicht per Zeiger). INPUTSTRING ist auf dem Mega Drive nicht umgesetzt (Fehlerhandler).

## Änderungen am Code (`02_Extracted\src\buckrogers.asm`, Marke `DEUTSCH-HOOK`)

Nur aktiv mit `-D DEUTSCH=1` (`build.py --deutsch`). Ohne bleibt der Bau bit-genau (geprüft 23.10.2026).

| Hook | Ort (ROM) | Original | Deutsch | Rückfallwert |
|---|---|---|---|---|
| 1 | `$411C` (32 Byte, in `sub_40D0`) | Text entpacken, `$FFFFB9A4` = Textanfang | `lea DE_Modultabelle,a0` / `move.l (a0,d2.w),($FFFFB9A4).w` / `bra` + 9 × NOP | Original-Befehle im `else`-Zweig |
| 2 | `$40B4` (8 Byte, `loc_40AA`) | `add.l ($FFFFB9A4).w,d0` / `movea.l d0,a0` / `rts` | `jmp DE_TextZeiger` + NOP | dito |
| 3 | `$051102` (512 Byte) | Schrift 1 bpp | Schrift mit Ä Ö Ü auf den Plätzen `[ £ ]` (`Zeichensatz.md`) | dito |
| 4 | ab `$100000` | – | `src\deutsch.asm`: `DE_TextZeiger` (Offset × 4 + Tabelle → Zeiger), ab `$108000` `texte.bin` | entfällt |

Größe gleich geblieben (32 bzw. 8 Byte), alle übrigen Adressen unverändert (Byte-Vergleich: nur
`$18E`, `$1A5`, `$1B0–$1BB`, `$40B4`, `$411C`, `$512DA–$512F0`, `$FFFCC` geändert).

## Nachbearbeitung in `build.py --deutsch`

- ROM auf **2 MB** aufgefüllt (`$FF`), Header `$1A4` = `$001FFFFF`.
- Header `$1B0`: SRAM-Angabe `RA $F8 $20`, `$200001–$203FFF` (8 KB, ungerade Bytes). Das Original
  hat keine SRAM-Angabe; Emulatoren erkannten das Spiel bisher über die Datenbank (CRC). Mit
  geänderter ROM greift die nicht mehr → Angabe nötig.
- **Selbstprüfung des Spiels** (`sub_FFFB0`, beim Start): Summe aller Langworte `$0–$FFFAF`
  (ohne `$18C`) muss `$10D1310C` sein, sonst Bildschirm und Endlosschleife. Jede Änderung im
  ersten MB ändert die Summe → `build.py` schreibt den neuen Sollwert in das Immediate bei
  `$FFFCC` (liegt selbst außerhalb der Summe). Rückfallwert: `$10D1310C`.
- Header-Checksumme `$18E` neu.
- Kopie als feste Testdatei `07_Output_ROM\Buck Rogers - Countdown to Doomsday (gebaut).md`
  (gleicher Name → Ares findet den Spielstand `… (gebaut).ram` bei jedem Bau wieder).

## Textblock (`03_Tools\text_einsetzen.py` → `02_Extracted\deutsch\texte.bin`, ab `$108000`)

```
$108000  DE_Modultabelle: 27 Langworte (Reihenfolge wie dat_38CE6) → Zeigertabelle je Modul
je Modul: Zeigertabelle (4 Byte je Original-Offset 0..Textlänge-1)
          "?TEXT?" (Ziel für Offsets, die kein Textanfang sind)
          Texte (deutsch oder englisch, 0-terminiert)
```

- Stand 23.10.2026: 550.778 Byte, frei bis 2 MB: 465.030 Byte. Die Zeigertabellen sind der
  Großteil (4 × 107.674). Falls später Platz fehlt: Tabelle auf 2 Byte je Eintrag verkleinern.
- Leeres `de` → englischer Originaltext. So lässt sich Modul für Modul übersetzen.
- `--nur-englisch`: Vergleichsbau, alle Texte englisch (CRC32 32A88467).

## Prüfregeln (`text_einsetzen.py`, Projektanweisung 7.5) – getestet 23.10.2026

| Regel | Umsetzung | Test |
|---|---|---|
| nur darstellbare Zeichen | `zeichensatz.kodieren` | „€“ → Fehler mit ID ✔ |
| Steuerzeichen gleiche Reihenfolge | Zeilenumbruch `$0D` und `~` je Text verglichen | zusätzlicher Umbruch → Fehler ✔ |
| Menügrenze | je HMENU/WHMENU-Befehl Summe aller Punkte + Trenner ≤ 39 | 63 Zeichen → Fehler mit allen IDs ✔ |
| Zeilenbreite | kein Wort länger als 36 Zeichen (Dialogfenster Spalte 2–37) | Wort mit 42 Zeichen → Fehler ✔ |
| Zeilenzahl | Hinweis, wenn mehr als max(4, Original) Zeilen | Grenze noch nicht gemessen |
| Platzhalter | – | Dialogtexte haben keine (Namen kommen über eigene Befehle) |

Bei einem Fehler wird nichts geschrieben; Bericht in `02_Extracted\deutsch\pruefbericht.txt`.

## Bauablauf (Windows)

1. `03_Tools\3_deutsch_vorlage.bat` – nur einmal: legt `05_German_Script\ecl\Mxxx.toml` an
   (vorhandene Dateien werden nie überschrieben).
2. Übersetzung in `05_German_Script\ecl\Mxxx.toml`, Feld `de`.
3. `03_Tools\7_deutsch_bauen.bat` – prüft und setzt ein (`4_text_einsetzen.bat`), baut die
   2-MB-ROM nach `07_Output_ROM\<Zeitstempel>_deutsch\` und die Testdatei.

## Prüfung (23.10.2026)

- Emulator Genesis Plus GX (libretro, eigener Testaufbau, siehe `Testumgebung.md`):
  Kaltstart, Selbstprüfung bestanden, Spielstand 1 (Marcels `.ram`) geladen, Intro M016_000–003
  deutsch mit Ä Ö Ü, danach englische Texte unverändert, Kampf startet.
- Ein Bild-für-Bild-Vergleich Original ↔ Vergleichsbau ist nicht aussagekräftig: Der deutsche
  Bau lädt Module schneller (kein Entpacken), dadurch verschieben sich Zeitpunkte und der
  Zufallsgenerator. Abweichungen waren nur Zeit-/Zufallseffekte (Explosionen, Blitze).
- Ares v147 (Marcel, 24.10.2026): Start, Spielstand 1, Intro M016_000–002 deutsch – bestätigt.
- Windows-Bau (Marcel, 24.10.2026, `7_deutsch_bauen.bat`): CRC32 E60AE2AA = identisch mit Linux-Bau, bestätigt.
- **Offen:** Menüs (HMENU) im Spiel gesehen; SAVE/COMPARE-Texte.
