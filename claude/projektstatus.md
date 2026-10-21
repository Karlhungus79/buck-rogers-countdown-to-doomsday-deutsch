# Projektstatus – Buck Rogers: Countdown to Doomsday Deutsch

Stand: 21.10.2026

## Aktuelle Phase

Phase 0 – Bestandsaufnahme. Läuft.

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

## Offen / nächste Schritte

0. Marcel: Projektordner auf H: lokal mit dem Repo verbinden (git init/fetch/reset)
1. Referenztext (US/EU-Fassung) extrahieren und als Dialogstruktur ablegen
2. Textformat und Zeichensatz am Intro/Titelbildschirm testen
   (Umlaute, ß, Umbruch) – Toolchain-Versionen dabei notieren
3. Glossar-Vorschläge als CSV (Eigennamen, Fraktionen, Klassen/Rassen, UI)
   vorlegen, Marcel entscheidet
4. `Fahrplan.md` anlegen

## Offene Punkte / Annahmen (im Spieltest/Recherche zu bestätigen)

- Keine separate EU-Revision des ROMs bekannt (nur eine Datei vorhanden,
  Region-Byte "U")
- Keine japanische Mega-Drive-Fassung bekannt
- Ob Figuren aus der weiteren Buck-Rogers-Fiktion (Wilma Deering, Dr. Huer,
  Killer Kane, Prinzessin Ardala) im Spieltext vorkommen: noch nicht geprüft
