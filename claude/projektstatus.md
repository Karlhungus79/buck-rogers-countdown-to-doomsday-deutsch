# Projektstatus – Buck Rogers: Countdown to Doomsday Deutsch

Stand: 21.10.2026 (spät)

## Aktuelle Phase

Phase 1 – Technisches Gerüst. Beginnt. Phase 0 abgeschlossen am 21.10.2026 (Glossar abgenommen).

## Erledigt

- Projektordner mit vorgegebener Struktur angelegt
  (`H:\Übersetzungen - Disassemblys - Lets Plays\Buck Rogers Disassembly\`)
- Original-ROM geprüft: Header-Checksumme bestätigt, Datei intakt,
  MD5/SHA-1/CRC32 notiert (siehe `Kontext.md`)
- Entscheidung: die eine vorhandene Datei ("USA, Europe") ist die Basis
- Bestandsaufnahme-Recherche abgeschlossen: keine bestehende Übersetzung,
  kein Disassembly, keine Tools gefunden (siehe `BuckRogers_Bestandsaufnahme.md`)
- Einstiegsdateien angelegt: `Kontext.md`, `projektstatus.md`, `MEMORY.md`
- Disassembly erstellt, baut bit-genau (CRC32 44E3BFFF) – unter Linux und
  unter Windows bestätigt am 21.10.2026 (`03_Tools\6_bitgenau_pruefen.bat`)
- GitHub-Repo angelegt und gepusht (21.10.2026): privat,
  https://github.com/Karlhungus79/buck-rogers-countdown-to-doomsday-deutsch
  (Beschreibung englisch)
- **Textformat geklärt (21.10.2026, Details `Textformat.md`):**
  - Dialoge: 27 ECL-Module, je ein LZW-gepackter Textblock, ASCII-Großbuchstaben,
    Verweis per 16-Bit-Byte-Offset. LZW-Entpacker in Python nachgebaut.
  - ECL-Parser: findet alle 2407 Texte mit korrekten Verweisen.
  - Systemtexte: 393 Einträge, Offsettabelle bei `$011DC4`, verschiebbar.
  - RAM-Grenze je Modul (0x2C00 für Code + Text) gemessen; M050 und M032 knapp.
  - Korrektur: `sub_1F5E` ist der Spielstand-**Packer**, nicht der Entpacker.
- **Referenztext extrahiert (21.10.2026):** `03_Tools\2_text_extrahieren.bat` →
  `04_English_Script\ecl\M000.toml … M099.toml` (2407 Texte),
  `systemtexte.toml` (393), `uebersicht.csv`. Nicht im Repo (Spieldaten).
  Gebaut und per Skript geprüft; Ausführung unter Windows: **Test offen**.
- **Entscheidung 21.10.2026: Textablage A** – deutscher Dialogtext unkomprimiert in der
  ROM (2 MB), Spiel liest direkt von dort. Umsetzung Phase 1 (`Textformat.md`).
- **Glossar-Vorschlag vorgelegt (21.10.2026):** 9 Grundsätze (G1–G9) und 186 Begriffe
  in 5 CSV-Listen, je mit Empfehlung A und Alternativen, Zeichenzahl, Fundort.
  Monsternamen gegen 15-Zeichen-Grenze geprüft.
- **Grundsätze G1–G9 entschieden (21.10.2026, alle A):** Groß-/Kleinschreibung, ß-Kachel,
  „ihr“ für NEO/Verbündete/Erzähltext, „Sie“ für Fremde, „Team“, Eigennamen unverändert,
  deutsche AD&D-Kürzel, km, Sprachfärbungen bleiben (`Glossar.md`).
- **Glossar abgenommen (21.10.2026, „Listen alles A“):** alle 186 Einträge = A.
  **Tor Phase 0 erreicht.**
- Figurenfrage teilweise geklärt: Im Dialog kommen WILMA (10×), HUER (1×), TUSKON,
  SCOT.DOS vor; KANE und ARDALA nicht (Monster-/Systemtexte noch nicht geprüft).

## Offen / nächste Schritte

0. Marcel: Projektordner auf H: lokal mit dem Repo verbinden (git init/fetch/reset)
1. Marcel: `03_Tools\2_text_extrahieren.bat` starten, Ausgabe prüfen (27 Module,
   2407 + 393 Texte), `04_English_Script\uebersicht.csv` in Excel öffnen
2. `Fahrplan.md` für Phase 1 anlegen (Reihenfolge: Font finden → Umlaute/ß →
   Textablage A umsetzen → ein Intro-Text deutsch im Spiel)
3. Zeichensatz: Font-Kacheln finden, 7 neue Zeichen ä ö ü ß Ä Ö Ü (`Zeichensatz.md`)
4. Textablage A umsetzen: `sub_40D0` ändern, ROM auf 2 MB, Einsetz-Skript
   (Prüfregeln aus Projektanweisung 7.5), Kleinbuchstaben im Dialogfenster testen
5. Tor Phase 1: Intro (M016/M003) läuft deutsch – Marcel bestätigt im Emulator
6. Monsternamen, vorgefertigte Figuren, Abspann: Datenstruktur analysieren und
   in die Extraktion aufnehmen
7. Emulator mit Debugger festlegen und Version notieren

## Offene Punkte / Annahmen (im Spieltest/Recherche zu bestätigen)

- Keine separate EU-Revision des ROMs bekannt (nur eine Datei vorhanden,
  Region-Byte "U")
- Keine japanische Mega-Drive-Fassung bekannt
- LZW-Nachbau entspricht dem Spiel (per Blockgrenzen geprüft, im Spiel erst mit dem
  ersten Einsetz-Test bestätigt)
- Deutsche Texte werden 10–30 % länger (Annahme); durch Entscheidung A unkritisch
- Annahme zu A: Kein ECL-Befehl schreibt in den Textblock (im Spieltest prüfen)
