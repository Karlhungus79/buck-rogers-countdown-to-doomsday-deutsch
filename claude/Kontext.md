# Kontext – Buck Rogers: Countdown to Doomsday (Mega Drive) Deutsch

Stand: 23.10.2026

## Spiel

- Buck Rogers: Countdown to Doomsday, Sega Mega Drive/Genesis
- Hersteller: Electronic Arts / SSI, basiert auf den AD&D-"Gold Box"-Regeln
- NA-Release: Dezember 1991. EU-Release: April 1992.
- Keine japanische Mega-Drive-Fassung bekannt (noch im Spieltest/Recherche zu bestätigen)
- PC/Amiga/C64-Fassungen (1990) sind nur Lore-Hintergrund, keine Textquelle –
  eigene, gekürzte Texte und eigene UI auf der Mega-Drive-Fassung

## Referenz-ROM

- Datei: `H:\Übersetzungen - Disassemblys - Lets Plays\Buck Rogers Disassembly\01_Original_ROM\Buck Rogers - Countdown to Doomsday (USA, Europe).md`
  (plus gleichnamige ZIP-Fassung, Inhalt identisch)
- Größe: 1.048.576 Byte (1 MB / 8 Mbit)
- Seriennummer (Header): GM T-50286 -00
- Copyright (Header): (C)T-50 1991.DEC
- Interner Titel (Header): BUCK RODGERS COUNTDOWN TO DOOMSD (so im Original geschrieben, mit "RODGERS")
- Regionsbyte (Header, altes Einzelbyte-Format): U
- Header-Checksumme (Offset 0x18E): D7B6 – stimmt mit tatsächlich berechneter Checksumme über den ROM-Body überein → Datei intakt
- MD5: `f768fbba021636fff3682b9ae116076a`
- SHA-1: `89c39f00745f2a8798fe985ad8ce28411b977f9e`
- CRC32: `44E3BFFF`
- **Basis-Entscheidung (21.10.2026):** Diese eine Datei ist die Basis für das gesamte Projekt.
- **Annahme (noch nicht widerlegt):** Es gibt keine separate EU-Revision mit
  abweichendem ROM-Inhalt. Die Datei ist von den Preservation-Projekten mit
  der kombinierten Region-Angabe "(USA, Europe)" benannt, was üblicherweise
  bedeutet: dieselbe Datei ist für beide Regionen nachgewiesen identisch.
  Falls doch eine separate EU-only-ROM auftaucht: Checksummen vergleichen.

## Bestandsaufnahme (Stand 21.10.2026)

Keine bestehende deutsche Übersetzung, kein öffentliches Disassembly-Projekt,
keine bekannten Tools zu diesem Titel gefunden. Details und Quellen:
siehe `BuckRogers_Bestandsaufnahme.md`. Folge: Phase 0 (Textformat, Werkzeuge)
braucht mehr Zeit als bei den Phantasy-Star-Projekten, da kein Vorlauf aus
Community-Arbeit existiert.

## Rollen und Zusammenarbeit (Kurzfassung)

- Marcel entscheidet (Namen, Begriffe, Stil), testet im Emulator, meldet per
  Screenshot/Rückmeldung. Trägt selbst keine Entscheidungen in Dateien ein.
- Claude macht den Rest: Analyse, Werkzeuge, Skripte, Übersetzung, Einsetzen,
  Bauen, Dokumentation – und trägt Entscheidungen ein.
- Entscheidungen als Auswahl (A/B/C) mit Empfehlung vorlegen, möglichst mit
  Pixelbreite/Platzbedarf. Eine Entscheidung gilt erst, wenn sie in Glossar
  und Projektdokument steht.
- "Entscheide selbständig" → Claude entscheidet, hält es schriftlich fest,
  markiert als "im Spieltest prüfen".
- Korrekturen sofort im selben Chat.
- Jede Antwort endet mit den nächsten Schritten.
- Ehrlichkeit vor Optimismus: nicht Getestetes heißt "gebaut, Test offen",
  nicht "erledigt".

## Übersetzungsgrundsätze (entschieden 21.10.2026, Details `Glossar.md`)

- Anzeige in GROSSBUCHSTABEN wie im Original, ß → SS (G1/G2 = B, neu entschieden 23.10.2026; die
  Schrift hat keine Kleinbuchstaben, `Zeichensatz.md`). Texte werden trotzdem normal geschrieben.
- Anrede: NEO/Verbündete/Erzähltext „ihr“, Fremde/Behörden/Händler/RAM „Sie“
- Gruppe = „Team“; Eigennamen, Schiffe, Fraktionen, KIs (.DOS) unverändert
- Werte: ST GE KO CH TE, TP, RK, ETW0, Stufe, EP; Planetendaten in km
- Sprachfärbungen bleiben (Terrine zischen, Sonnenkönig spricht Französisch)

## Modellwahl

Noch keine feste Tabelle. Bis dahin gilt: im Zweifel Opus. Mechanische
Aufgaben (Checksummen, Dateioperationen, reine Recherche/Dokumentation ohne
Übersetzungs- oder Analyseentscheidung) laufen auf Sonnet; sobald echte
ROM-/Code-Analyse, Textformat-Reverse-Engineering oder Übersetzungsentscheidungen
anstehen, auf Opus wechseln. Jede Antwort nennt das explizit.

## Phasen (Kurzübersicht, siehe Projektanweisung Abschnitt 4 für Details)

| Phase | Inhalt | Tor |
|---|---|---|
| 0 | Bestandsaufnahme + Glossar | Glossar abgenommen |
| 1 | Technisches Gerüst, Intro deutsch | Intro läuft deutsch |
| 2 | Systemtexte | im Spiel bestätigt |
| 3 | Grafik | im Spiel bestätigt |
| 3+ | Extras (optional) | im Spiel bestätigt |
| 4 | Gerüst-Abnahme, Testpaket | Tester-Rückmeldung eingearbeitet |
| 5 | Dialog | durchgespielt |
| 6 | Endtest, Release, Doku, Patch | veröffentlicht |

Aktueller Stand: Phase 2 läuft. Systemtexte + Gegenstandsnamen in Ares bestätigt 24.10.2026 (`Systemtexte.md`), E1–E5 entschieden. Monsternamen + Abspann gebaut 24.10.2026 (`Monster_Abspann.md`). Bau deutsch CRC32 D1F2D473, Testfassung mit Jumper BACCC158 (`Testfassung.md`). Als Nächstes: Ares-Test, Tor Phase 2, dann Phase 3 Grafik.

## Ordnerstruktur (angelegt am 21.10.2026)

```
H:\Übersetzungen - Disassemblys - Lets Plays\Buck Rogers Disassembly\
  01_Original_ROM\
  02_Extracted\
    src\          (Disassembly)
    data\         (aus ROM gezogen, nicht im Repo)
  03_Tools\
    AS\win64\
    bak\
  04_English_Script\
  05_German_Script\
    Dialog\
  07_Output_ROM\
  08_Savestates\
  claude\
```

Regeln: Original-ROM und englischer Referenztext werden nie verändert. Jeder
Bau erzeugt einen neuen Zeitstempel-Ordner in `07_Output_ROM`. Vor jeder
Änderung an Originalen/Skripten/Blättern: Sicherung in
`03_Tools\bak\<Grund>_<Datum>\`.

## Toolchain

- Assembler: Macro Assembler AS (flamewing-Fork), Commit 592c5fa (13.10.2026),
  Windows-Fassung in `03_Tools\AS\win64\` (selbst kompiliert, Details `claude\Disassembly.md`)
- Disassembler: eigenes `03_Tools\disasm.py` + `gen_asm.py` (Capstone 5.0.7)
- Python 3 für alle Skripte, jeweils mit .bat-Wrapper
- Textablage A (Entscheidung 21.10.2026, gebaut 23.10.2026): Dialogtext unkomprimiert in der ROM ab
  `$108000`, ROM 2 MB, Details `Textablage.md`
- Deutsche Texte: `05_German_Script\ecl\Mxxx.toml` (Feld `de`), Vollbau `03_Tools\7_deutsch_bauen.bat`
  → Testdatei `07_Output_ROM\Buck Rogers - Countdown to Doomsday (gebaut).md` (fester Name für den Ares-Spielstand)
- **Nie** `0_disassembly_erzeugen.bat` ohne Not: würde die DEUTSCH-HOOKs löschen (Skript bricht ab)
- Selbstprüfung im Spiel (`sub_FFFB0`): jede Änderung im ersten MB → Sollwert neu (macht `build.py --deutsch`)
- Text: `03_Tools\brtext.py` (LZW, ECL-Parser, Systemtexte), `2_text_extrahieren.bat`
- Test-Emulator: **Ares v147** (festgelegt von Marcel am 21.10.2026).
  Saves-Pfad in Ares (Einstellungen > Pfade > Saves) war am 23.10.2026 noch auf
  `…\Phantasy Star 2 Disassembly\08_Savestates` gestellt → für Buck Rogers auf
  `H:\Übersetzungen - Disassemblys - Lets Plays\Buck Rogers Disassembly\08_Savestates` stellen.
  Ares legt den Spielstand je ROM-Dateiname ab: `Buck Rogers - Countdown to Doomsday (gebaut).ram`
  (8 KB, Spielstand 1 = vorgefertigtes Team am Spielbeginn). Tile-Editor: noch offen.
- Claude-Testemulator: Genesis Plus GX (libretro) mit eigenem Frontend, `Testumgebung.md`

## Disassembly und GitHub (Stand 21.10.2026)

- Bit-genaues Disassembly: `02_Extracted\src\buckrogers.asm`, Details `claude\Disassembly.md`
- Repo: privat, `buck-rogers-countdown-to-doomsday-deutsch`, Repo-Wurzel = Projektordner
- Keine ROM und keine Spieldaten im Repo; `02_Extracted\data\` wird aus der eigenen ROM gezogen
- Bauen: `03_Tools\5_rom_bauen.bat`, bit-genau prüfen: `03_Tools\6_bitgenau_pruefen.bat`
- Code: C-Compiler, Gold-Box-Engine mit ECL-Skripten; LZW-Entpacker `sub_9E76`/`sub_9ED8` (`sub_1F5E` = Packer für Spielstände);
  Systemtexte als ASCII ab ca. $012000; $020000–$0EFFFF komprimierte Daten

## Bekannte Fallen (aus PSG2/PS2 MD, siehe Projektanweisung Abschnitt 11)

1. Dokumente nur im Chat = Verlust → alles im Projektordner.
2. Glossar zuerst, sonst überall Nacharbeit.
3. Breite messen statt schätzen.
4. Jede Anpassung am Einsetz-Skript sichern und begründen.
5. Spieltests decken auf, was Skripte nicht sehen.
6. Annahmen als Annahmen kennzeichnen.
7. Risiken bei Eingriffen in den Programmcode notieren, samt Rückfallwert.
8. Erst ein kleines Stück vollständig durch die Pipeline bringen, dann skalieren.
9. Bau/Test nie ungesichert über den letzten funktionierenden Stand legen.
10. Persönliche Entscheidungen sofort festhalten.
11. Kein vorhandenes Disassembly hier (anders als bei Phantasy Star) – Phase 0
    braucht mehr Zeit.
