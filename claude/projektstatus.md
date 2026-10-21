# Projektstatus – Buck Rogers: Countdown to Doomsday Deutsch

Stand: 21.10.2026 (spät)

## Aktuelle Phase

Phase 0 – Bestandsaufnahme. Läuft. Referenztext extrahiert, Textformat geklärt.

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
- Figurenfrage teilweise geklärt: Im Dialog kommen WILMA (10×), HUER (1×), TUSKON,
  SCOT.DOS vor; KANE und ARDALA nicht (Monster-/Systemtexte noch nicht geprüft).

## Offen / nächste Schritte

0. Marcel: Projektordner auf H: lokal mit dem Repo verbinden (git init/fetch/reset)
1. Marcel: `03_Tools\2_text_extrahieren.bat` starten, Ausgabe prüfen (27 Module,
   2407 + 393 Texte), `04_English_Script\uebersicht.csv` in Excel öffnen
2. Entscheidung Textablage Phase 1 (A/B/C, siehe `Textformat.md`, Empfehlung A)
3. Glossar-Vorschläge als CSV (Eigennamen, Fraktionen, Klassen/Rassen, UI)
   aus `uebersicht.csv` ableiten, Marcel entscheidet
4. Zeichensatz: Font-Kacheln finden, Platz für Ä Ö Ü ß (Großbuchstaben reichen für
   Dialoge; Systemtexte brauchen auch ä ö ü)
5. Monsternamen, vorgefertigte Figuren, Abspann: Datenstruktur analysieren und
   in die Extraktion aufnehmen
6. Emulator mit Debugger festlegen und Version notieren
7. `Fahrplan.md` anlegen

## Offene Punkte / Annahmen (im Spieltest/Recherche zu bestätigen)

- Keine separate EU-Revision des ROMs bekannt (nur eine Datei vorhanden,
  Region-Byte "U")
- Keine japanische Mega-Drive-Fassung bekannt
- LZW-Nachbau entspricht dem Spiel (per Blockgrenzen geprüft, im Spiel erst mit dem
  ersten Einsetz-Test bestätigt)
- Deutsche Texte werden 10–30 % länger (Annahme) → RAM-Grenze in M050/M032
