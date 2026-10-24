# Textformat – wo die Texte liegen und wie sie kodiert sind

Stand: 21.10.2026

Alles hier ist aus der ROM und dem Disassembly abgeleitet und per Skript
gegengeprüft. **Im Spiel noch nicht bestätigt** (kein Einsetz-Test bisher).

## Überblick

| Textquelle | Ort in der ROM | Format | Umfang | Verweis |
|---|---|---|---|---|
| Dialog/Ereignisse (ECL) | Textblöcke `$042B96–$051100` | LZW-gepackt, ASCII, nur Großbuchstaben, `$00`-Ende | 27 Module, 2407 Texte, 107.674 Zeichen | 16-Bit-Offset im ECL-Operand `$80` |
| Systemtexte | `$0120D6–$013268` (in `data/011DC4.bin`) | ASCII Klartext, meist Kleinbuchstaben, `$00`-Ende | 393 Einträge | Tabelle 16-Bit-Offsets ab `$011DC4` |
| Monsternamen | in `dat_9E77C` (LZW) | ASCII, feste Feldlänge (ca. 15 Zeichen) | ca. 50 | Datensatz 0xD6 Byte, noch nicht analysiert |
| Vorgefertigte Figuren | in `dat_6BAAD` (LZW) | ASCII | 6 Namen | noch nicht analysiert |
| Abspann | `$006331–$00664C` | ASCII Klartext | ca. 60 Zeilen | noch nicht analysiert |
| Grafiktexte (Titel usw.) | komprimierte Grafik | Kacheln | ? | Phase 3 |

Extraktion: `03_Tools\2_text_extrahieren.bat` → `04_English_Script\` (nicht im Repo).
IDs: `Mmmm_nnn` (Modul, laufende Nummer), `Snnn` (Systemtext-Index).

## LZW-Kompression (Dialoge, ECL, Monster, Karten …)

- Entpacker im Spiel: `sub_9E76` (Start, a0 = Quelle), `sub_9ED8` (d0 = Ziel, d1 = Anzahl Bytes,
  Zustand bleibt zwischen Aufrufen erhalten), Bitleser `sub_A092`, Stringaufbau `sub_A00C`
  (Fehlermeldungen „Error #1/#2 in decodeString").
- Codes 9 bis 12 Bit, MSB zuerst. `$100` = Wörterbuch zurücksetzen, `$101` = Ende, erster freier Code `$102`.
- Besonderheit: verkürzte Codes. Ist der Wert der oberen n-1 Bits größer als
  (nächster Code − 2^(n-1)), werden nur n-1 Bit gelesen, sonst n Bit.
- Wörterbuch voll bei 4095, dann wird nicht mehr erweitert (Reset kommt per Code `$100`).
- Nachbau in Python: `03_Tools\brtext.py` (Klasse `LZW`). Prüfung: alle Blöcke enden genau
  dort, wo der nächste beginnt (0–2 Byte Füllung) → Dekoder liest exakt den Datenstrom.
- **Korrektur zu Disassembly.md:** `sub_1F5E` ist kein Entpacker, sondern der LZW-**Packer**
  für Spielstände (schreibt nach SRAM `$200011`, Meldung „compression overflow").

## ECL-Module

- Laden: `sub_40D0` (Opcode NEWECL). Modul-IDs in `dat_38CE6` (27 Stück:
  0, 1, 3, 16, 17, 32–35, 48–50, 52, 64–67, 80–83, 94–99).
- Offsettabellen (Langworte, relativ zur Tabelle): ECL-Code `$038D02`, Text `$042B2A`.
- Code wird nach `$FFFF6AF6` entpackt, der Text direkt dahinter; `$FFFFB9A4` zeigt auf den Textanfang.
- **RAM-Grenze:** Code + Text müssen in `$FFFF6AF6–$FFFF96F6` passen (0x2C00 = 11.264 Byte).
  Dahinter liegen die ECL-Variablen (`sub_115A` löscht ab `$FFFF96F6`), der Interpreter
  prüft den Befehlszeiger gegen genau diese Grenzen (`loc_3308`, „Bad ECL address").
- Kopf jedes Moduls: 5 × GOTO (Ereignisvektoren), Code ab Offset `$14`.
  Adressen im ECL = RAM-Adresse (low word), Basis `$6AF6`.

### Operanden

| Typ-Byte | Länge | Bedeutung |
|---|---|---|
| `$00` | 2 | 8-Bit-Wert |
| `$01`, `$02`, `$03` … | 3 | 16-Bit-Wert/Adresse (little endian), ungerade Typen = Variable |
| `$04` | 5 | 32-Bit-Wert |
| `$80` | 3 | **Text**: 16-Bit-Byte-Offset (little endian) in den Textblock |
| `$81` … | 3 | Variable mit Textinhalt |

### Befehle mit Text

PRINT, PRINTCLEAR (Fließtext, Umbruch macht das Spiel), HMENU/WHMENU (Menüpunkte),
JOURNAL, INPUTNUMBER/INPUTSTRING (Aufforderung) u. a. Die Operandenzahl je Befehl steht in
`brtext.py` (`OPS_FIX`, `OPS_LIST`), abgeleitet aus den Handlern ab `jt_336E`.
Prüfung: Der lineare Parser findet für **alle 2407 Texte genau einen bzw. die richtigen
Verweise**, keinen Verweis ins Leere.

### Grenzen, die beim Übersetzen zählen

- **HMENU/WHMENU:** Alle Menüpunkte werden mit `~` verkettet in einen Puffer
  `$FFFFD5AE–$FFFFD5D5` kopiert → zusammen höchstens **39 Zeichen** inkl. Trennern.
  In den TOML-Dateien mit `menue = true` markiert.
- **RAM-Rest je Modul** (frei bis 0x2C00, Stand Original):

| Modul | Code | Text | Rest | Rest in % vom Text |
|---|---|---|---|---|
| M050 | 3920 | 6242 | 1102 | 17 % |
| M032 | 3973 | 5912 | 1379 | 23 % |
| M097 | 2427 | 6756 | 2081 | 30 % |
| M099 | 4518 | 4617 | 2129 | 46 % |
| M082 | 3059 | 5939 | 2266 | 38 % |
| M096 | 2312 | 6655 | 2297 | 34 % |
| übrige | | | | 43 % bis über 1000 % |

  Deutsch wird erfahrungsgemäß deutlich länger als Englisch (Annahme 10–30 %, im
  Spieltest/Übersetzung zu bestätigen) → **M050 und M032 würden voraussichtlich nicht passen.**
  Gelöst durch Entscheidung A (siehe unten): Text liegt in der ROM, die RAM-Grenze gilt nur noch für den ECL-Code.
- Modul 97: Der Original-Textstrom hat kein sauberes Ende, das Spiel entpackt hinter dem
  letzten Text ca. 1.900 Byte Datenmüll (stört nicht, Platz bleibt unter 0x2C00). Beim
  Neubau entfällt der Müll.

## Systemtexte

- Tabelle `dat_11DC4`: 393 Wörter, Offset relativ zu `$011DC4`, Texte direkt dahinter.
- Zugriff über `lea dat_11DC4` (4 Stellen im Code) → die Tabelle kann neu aufgebaut und bei
  Bedarf komplett verschoben werden (nur diese 4 Verweise anpassen).
- Steuerzeichen: `$0D` = Zeilenumbruch, `~` = Menütrenner.
- S103 ist ein Datumsstempel aus der Entwicklung („9/5/91 3:19:13 PM").
- Umsetzung der deutschen Systemtexte (Phase 2): `Systemtexte.md`.

## Zeichensatz (Stand der Analyse)

- Dialoge nutzen nur: Leerzeichen, `! # % ' ( ) , - . 0–9 : ; < = ?` und `A–Z`.
- Systemtexte zusätzlich `a–z`, `+ /`, `~`.
- Umlaute/ß kommen nicht vor → Font-Kacheln müssen ergänzt werden (Phase 1, Zeichensatz.md).
- **Nachtrag 23.10.2026:** Die Schrift hat nur Großbuchstaben; Kleinbuchstaben in Systemtexten
  erscheinen groß (`Zeichensatz.md`).

## Entscheidung (21.10.2026, Marcel): Textablage A

**A gilt:** Der deutsche Dialogtext liegt unkomprimiert in der ROM, `sub_40D0` setzt
`$FFFFB9A4` auf die ROM-Adresse des Textblocks statt ihn zu entpacken. ROM wächst auf 2 MB.
Umsetzung in Phase 1. Status: **gebaut 23.10.2026, im Testemulator geprüft, Ares offen** – Details `Textablage.md`.
(Umgesetzt als Zeigertabelle je Modul statt Textblock-Adresse, damit der ECL-Code unverändert bleibt.)

Begründung: RAM-Grenze (0x2C00) fällt für den Text weg, kein Kürzen in M050/M032 nötig,
kein LZW-Packer nötig, kleiner Eingriff mit klarem Rückfallwert.

Vorher vorgelegte Optionen:

| | Lösung | Vorteil | Nachteil |
|---|---|---|---|
| **A (Empfehlung)** | Text unkomprimiert in die ROM, `sub_40D0` setzt `$FFFFB9A4` auf die ROM-Adresse statt den Text zu entpacken | RAM-Grenze entfällt komplett, kein Packer nötig, Änderung ca. 10 Byte Code | ROM wächst auf 2 MB (Mega Drive ohne Mapper bis 2 MB problemlos, SRAM bleibt bei `$200000`) |
| B | Text weiter LZW-gepackt im RAM | Original-Aufbau | M050/M032 vermutlich zu lang → Kürzen nötig |
| C | wie B, aber Module mit Platzproblem gezielt kürzen | ROM bleibt 1 MB | Übersetzung leidet, Nacharbeit |

Risiko bei A: Befehle, die in Texte schreiben, würden in ROM schreiben (wirkungslos).
Laut Analyse schreibt kein Textbefehl in den Textblock – im Spieltest prüfen.
Rückfallwert: Original-`sub_40D0`.
