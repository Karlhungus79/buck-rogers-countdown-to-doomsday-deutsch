# Projektstatus – Buck Rogers: Countdown to Doomsday Deutsch

Stand: 24.10.2026

## Aktuelle Phase

Phase 2 – Systemtexte. Läuft (`Fahrplan.md`). **Tor Phase 1 erreicht am 24.10.2026** (Intro deutsch in Ares bestätigt).
Phase 0 abgeschlossen am 21.10.2026 (Glossar abgenommen).

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
  Unter Windows **bestätigt am 21.10.2026** (Marcel, Screenshot: alle 27 Module mit
  denselben Werten wie unter Linux, 2407 + 393 Texte).
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
- **Phase 1, 23.10.2026 (Details `Textablage.md`, `Zeichensatz.md`):**
  - Schrift gefunden: nur Großbuchstaben (64 Zeichen, ROM `$051102`); Kleinbuchstaben werden
    vom Spiel groß angezeigt. **G1-Annahme vom 21.10. war falsch** → G1 neu zur Entscheidung.
  - Ä Ö Ü in die Schrift (Plätze `[ £ ]`), Kodierung festgelegt (`zeichensatz.py`).
  - Textablage A umgesetzt: 4 Hooks in `buckrogers.asm` (`if DEUTSCH`), `src\deutsch.asm`,
    Texte + Zeigertabellen ab `$108000`, ROM 2 MB, SRAM-Header, Sollwert der Selbstprüfung
    (`sub_FFFB0`) wird neu gesetzt. Original-Bau weiterhin bit-genau.
  - Einsetz-Skript `text_einsetzen.py` mit Prüfregeln (Zeichen, Steuerzeichen, Menü 39, Wortlänge 36),
    getestet. Deutsche Textdateien `05_German_Script\ecl\M000–M099.toml` angelegt.
  - Intro M016_000–003 deutsch. **Gebaut 23.10.2026, CRC32 E60AE2AA** (2 MB).
    Im Testemulator (Genesis Plus GX) gesehen: Start, Spielstand laden, Intro deutsch mit Ä Ö Ü.
    **Test in Ares offen.**
  - Testumgebung für Claude: `Testumgebung.md`.
  - **G1/G2 neu entschieden (23.10.2026, Marcel „G1 = B“):** Großbuchstaben wie Original, ß → SS.
    Entspricht dem gebauten Stand, kein Neubau nötig.
- **Tor Phase 1 erreicht (24.10.2026):** Marcel hat in Ares v147 mit der Testdatei (CRC32 E60AE2AA)
  den Spielstand geladen und M016_000–002 deutsch gesehen (Screenshots `claude\Vorschau\Ares_Intro_2026-10-24_1–3.png`).
  Bestätigt: Start trotz Selbstprüfung, SRAM der 2-MB-ROM, Text aus der ROM, Ä Ö Ü, ß → SS („DRAUSSEN“),
  Zeilenumbruch bei 36 Zeichen, 4 Zeilen + „PRESS C“ passen ins Fenster.
  M016_003 (Schlachtbild, 6 Zeilen) nur im Testemulator gesehen.
- **Repo mit H: verbunden (24.10.2026):** `03_Tools\8_repo_verbinden.bat` (Marcel), Abgleich mit
  `9_repo_abgleich.bat`. Unterschiede nur bei PNGs (Claude-App hängt C2PA-Herkunft an, Pixel gleich).
- **Phase 2, 24.10.2026 (Details `Systemtexte.md`):**
  - Systemtexte in der Pipeline: Tabelle neu ab `$101000` (Hook 5), 393 Texte, davon 352 deutsch
    (Rest: Schiffsnamen, Copyright, Debug-Texte, Datum bleiben englisch).
  - Gegenstandsnamen: Tabelle fertiger Namen (Hook 6/7, 90 Namen), deutsche Mehrzahl (Hook 8/9).
  - Prüfregeln erweitert (Leerzeichen der Satzbausteine, Menüs 41, Namen 25/21, `max`).
  - Grenzen im Testemulator gemessen; „fertig“ (Namenseingabe) und „Raketen fliegen/Notreparatur“
    passten nicht → E1.
  - **Gebaut 24.10.2026, CRC32 598A9641.** Im Testemulator gesehen: Hauptmenü, Laden, Bogen,
    Gegenstände, Erschaffung, Namenseingabe, Ausbildung, Spieltempo, Kampfleiste. **Ares offen.**
  - Original-Bau weiterhin bit-genau; `--nur-englisch`: Systemtexte identisch zum Original.
- Figurenfrage teilweise geklärt: Im Dialog kommen WILMA (10×), HUER (1×), TUSKON,
  SCOT.DOS vor; KANE und ARDALA nicht (Monster-/Systemtexte noch nicht geprüft).

## Offen / nächste Schritte

1. ~~Windows-Bau~~ **bestätigt 24.10.2026**: CRC32 E60AE2AA (Header-Checksumme D034, Selbstprüfung 141FB059), identisch zum Linux-Bau.
2. ~~Repo verbinden~~ erledigt 24.10.2026.
3. Marcel: `7_deutsch_bauen.bat` → CRC32 598A9641? Dann Spieltest nach `Testliste_Phase2.md`.
4. Marcel: Entscheidungen E1–E4 (`Phase2_Entscheidungen.md`).
5. Claude: Monsternamen, vorgefertigte Figuren, Abspann in die Pipeline (Fahrplan 2.7/2.8).

## Offene Punkte / Annahmen (im Spieltest/Recherche zu bestätigen)

- Keine separate EU-Revision des ROMs bekannt (nur eine Datei vorhanden,
  Region-Byte "U")
- Keine japanische Mega-Drive-Fassung bekannt
- LZW-Nachbau entspricht dem Spiel (per Blockgrenzen geprüft, im Spiel erst mit dem
  ersten Einsetz-Test bestätigt)
- Deutsche Texte werden 10–30 % länger (Annahme); durch Entscheidung A unkritisch
- Annahme zu A: Kein ECL-Befehl schreibt in den Textblock – per Code geprüft (nur 3 Zugriffe auf
  `$FFFFB9A4`, SAVE kopiert aus dem Text heraus), im Spieltest weiter beobachten
- Ares erkennt die SRAM der 2-MB-ROM: bestätigt 24.10.2026 (Spielstand geladen)
- Zeilenzahl je Dialogfenster: 4 Zeilen im kleinen Fenster, 6 im Bildfenster gesehen; Grenze bei
  längeren Texten noch nicht gemessen
