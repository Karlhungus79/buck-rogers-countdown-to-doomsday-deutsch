# Projektstatus – Buck Rogers: Countdown to Doomsday Deutsch

Stand: 03.11.2026

## Aktuelle Phase

Phase 3 – Grafik: gebaut, Ares offen. **Phase 5 – Dialog: Erstübersetzung aller Spielmodule fertig, gebaut
(deutsch 59F0785A, Test 9CF3FBF3), Ares offen** (`Dialog.md`, `Testliste_Phase5.md`). **Tor Phase 2 erreicht am 24.10.2026** (Marcel „Tor Phase 2“,
Bau deutsch 0B58AE77 / Test 37DE7A79).
**24.10.2026, 21:51 – Fehler G7 Raumkampf-Anzeige (Ares, Marcel):** Balken zeigten Buchstabenstücke,
weil die Kacheln von G7 neu nummeriert waren. Skripte korrigiert (`Grafik.md`, Abschnitt „Befund und
Korrektur G7“), **Neubau durch Marcel nötig** (erwartet deutsch FFB78D02, Test 31A7C400), Test in Ares offen.
**24.10.2026, 22:16 – G7 bestätigt in Ares** (Schiffsanzeige korrekt). **Neuer Befund Planetenscan (Mars):**
„Atmosphäre:“ fehlt, vermutlich weil „253 Millionen“ (13 Zeichen) eine Spalte zu breit ist (12 passen) und
umbricht. **Entschieden 22:18, Marcel „B“:** einheitlich Mio./Mrd. (Glossar 3-43), eingesetzt, Neubau nötig:
erwartet deutsch **989ABA78**, Test **815930C9**. Raumkampf-Hilfen (Hooks 20–22) bestätigt gebaut: Test 82DFF8A8 = Vorhersage.
**24.10.2026, 22:35 – Testfassung: Jumper-Sprung ab ECL 94 setzt Endspiel-Stand automatisch** (Hook 23, `Testfassung.md`).
Erwartet Test **A11EB65A**, deutsch **989ABA78**. Test offen.
**24.10.2026, 22:10 – Testfassung: Raumkampf-Hilfen** (Hooks 20–22: Gegner trifft nie, eigenes Schiff trifft
immer, Maelstrom Rider unverwundbar; nur Testfassung, `Testfassung.md`). Erwartet Test 82DFF8A8, deutsch FFB78D02. Test offen.
Ares legt Spielstände im Unterordner `08_Savestates\Mega Drive\` ab (`Testfassung.md`).
Tor Phase 1 erreicht am 24.10.2026 (Intro deutsch in Ares bestätigt).
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
- **Entscheidungen E1–E4 (24.10.2026): alles A**, im Glossar eingetragen.
- **Testfassung (24.10.2026, `Testfassung.md`):** Entwickler-Jumper des Spiels freigeschaltet
  (Hook 10, nur `--test`), Sprung in alle 23 Spielmodule im Testemulator geprüft, Abspann-Test
  gefunden. Gebaut, CRC32 AD97A30C, Ares offen.
- **Befund Marcel (24.10.2026, Ares-Screenshot Schiffsstatus):** „TRIEBWERKE“ brach um und wurde
  überdeckt → S251 „Antrieb“ (7 Zeichen, E5 = A am 24.10.2026).
- **Befund Marcel (24.10.2026, Kampfende/Team vernichtet):** Texte erscheinen deutsch, korrekt:
  „Jede Figur erhält 50 Erfahrungspunkte.“, „Euer Team wurde vernichtet.“ Geändert: S150–S152
  („Das Team hat erbeutet: keine Beute.“ – vorher fehlte im Credits-Fall das Verb), S114 kürzer
  (eine Zeile). Neu gebaut: deutsch F1129EAD, Test 85474848.
- **Spieltest Systemtexte: Marcel „alle Tests erfolgreich“ (24.10.2026, Ares)** – Testliste Nr. 1–15
  bestätigt (inkl. Laden, Raumkampf mit ANTRIEB, Kampfmeldungen, Stufenaufstieg, Planetenscan).
  Danach Beute-Zeile korrigiert (Hook 11, Zusatztext S393 „Erbeutet: “, eine Zeile).
  Neu gebaut: deutsch **2E33C97D**, Test **5BD1A1AE**; Original-Bau bit-genau.
- **Monsternamen und Abspann (24.10.2026, `Monster_Abspann.md`):** Hook 12 (Monstername nach dem
  Laden ersetzen, 33 deutsche Namen nach Glossar), Hook 13 (Abspann aus `abspann.toml`, 17 Überschriften
  deutsch). Vorgefertigte Figuren: nur Eigennamen, nichts zu tun. Abspann-Kopf ist Grafik → Phase 3.
  Gebaut: deutsch **5D421395**, Test **C719F1FC**; im Testemulator gesehen, Ares offen.
- **Abspann-Seite „Deutsche Lokalisierung“ (Marcel 24.10.2026):** Projektleitung, Übersetzung, Tests:
  Karlhungus; eigene Seite mit Buck-Rogers-Porträt (Bild 62). Fehlende Musik im Test-Abspann ist
  Verhalten des Entwicklertests (auch mit englischem Abspann stumm). Aufbau: **Variante C**
  (Marcel 24.10.2026). Gebaut: deutsch **0B58AE77**, Test **37DE7A79** (Bau 17:28, CRC32 auf H: geprüft).
  Spielstand `08_Savestates\…(test).ram`.
- **Tor Phase 2 erreicht (24.10.2026):** Marcel bestätigt „Tor Phase 2“ mit dem Bau deutsch 0B58AE77 /
  Test 37DE7A79. In Ares bestätigt: Testliste Nr. 1–15 („alle Tests erfolgreich“), Raumkampf mit ANTRIEB,
  Kampfende/Team vernichtet, Abspann in der Testfassung (Variante C).
  **Nicht einzeln gemeldet, in Phase 4 (Gerüst-Abnahme) mitprüfen:** Beute-Zeile „ERBEUTET: …“ (Hook 11),
  Monsternamen außer TERRINE-KRIEGER, Menüs/Ja-Nein (Fahrplan 2.9), M016_003 (Schlachtbild) in Ares,
  Musik beim echten Spielende.
- Figurenfrage teilweise geklärt: Im Dialog kommen WILMA (10×), HUER (1×), TUSKON,
  SCOT.DOS vor; KANE und ARDALA nicht (Monster-/Systemtexte noch nicht geprüft).

- **Phase 3 Grafik (24.10.2026, Claude selbständig, Marcel nicht erreichbar):** Bildformat entschlüsselt
  (LZW, Kopf + Kachelkarte + Paletten + Kacheln), LZW-Packer in `grafik.py`, 7 Bilder mit Text gefunden
  (G1–G7, `Grafik.md`). Deutsch gebaut: PRÄSENTIERT, AKTIV, ZIEL?, ERDE, ENTWICKELT VOM,
  WAFF/STRG/ANTR/RUMPF (Hooks 14–19). **Gebaut: deutsch 814E4C76, Test F436B9D1.** Vorspann und
  Abspann-Kopf im Testemulator gesehen, G7 nur Vorschau, Ares offen. Original-Bau bit-genau.
- **Wecker 19:10 (24.10.2026)** hat ausgelöst, die Meldung kam aber erst um ca. 20:22 in der Sitzung an
  (als Marcel schrieb) – die Sitzung war bis dahin inaktiv. Künftig Übergabe auf H: vor dem Wecker ablegen.
- **Phase 6 vorbereitet (24.10.2026):** `03_Tools\10_patch_erstellen.bat` (`patch_erstellen.py`) erzeugt BPS + IPS
  gegen das Original (CRC32 44E3BFFF), prüft beide durch Anwenden, schreibt LIESMICH/README aus
  `03_Tools\release\`. Erster Lauf: `07_Output_ROM\2026-10-24_20-48-03_patch\` (Ziel-CRC32 59F0785A).
  Gegenprobe mit einem fremden Patch-Programm (Floating IPS) offen. Erst nach den Spieltests veröffentlichen.

- **Phase 5 Dialog (24.10.2026, Claude selbständig):** alle Spielmodule übersetzt (2130 von 2407 Texten; Rest:
  Entwicklermodule M000/M001, Eigennamen, Passwörter, Satzzeichen). Fenstergrenze gemessen (Fenster
  überschreibt reihum) → Zeilenprüfung ist jetzt Fehler. SAVE-Längen geprüft. Textblock-Grenze $1C0000.
  **Gebaut: deutsch 59F0785A, Test 9CF3FBF3**, Original bit-genau. Intro im Testemulator gesehen. Ares offen.

## Offen / nächste Schritte

1. ~~Windows-Bau~~ **bestätigt 24.10.2026**: CRC32 E60AE2AA (Header-Checksumme D034, Selbstprüfung 141FB059), identisch zum Linux-Bau.
2. ~~Repo verbinden~~ erledigt 24.10.2026.
3. ~~Bau 0B58AE77 / Test 37DE7A79~~ auf H: geprüft 24.10.2026.
4. ~~Entscheidungen E1–E4~~ entschieden 24.10.2026: alles A (Glossar eingetragen).
5. ~~Monsternamen, Figuren, Abspann~~ gebaut 24.10.2026 → Spieltest Marcel (Testliste Nr. 16–17).
6. ~~Tor Phase 2~~ **erreicht 24.10.2026.**
7. Marcel: `7_deutsch_bauen.bat` → CRC32 814E4C76, `7b_testfassung_bauen.bat` → F436B9D1, dann
   `Testliste_Phase3.md` in Ares. Danach Tor Phase 3.
8. ~~Phase 3 Grafik (Opus): Schritt 3.1 Bestandsaufnahme aller Grafiken mit englischem Text → `Grafik.md`
   (Titelbild, Abspann-Kopf „CREATED BY THE …“, weitere Bilder), dann Grafik-Werkzeug mit
   Rundreise-Prüfung, Wortlisten und Entwürfe A/B/C je Bild (`Fahrplan.md`, Phase 3).~~ gebaut 24.10.2026.
9. ~~Phase 5 Dialog~~ Erstübersetzung fertig 24.10.2026 → Marcel: Spieltest nach `Testliste_Phase5.md`.
10. Danach: Korrekturen aus den Spieltests, Phase 4/6 (Testpaket, Patch, Readme, Release).

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

## Nachtrag 25.10.2026 (Claude, Sonnet): offene Analyse für Opus

- Umgebung im Container bestätigt: AS-Assembler gebaut, Bauten = Marcels Bauten (deutsch 989ABA78, Test A11EB65A,
  Original 44E3BFFF). GitHub verknüpft, Abendstand 24.10. gepusht (40f9bcb).
- **Offen (Opus):** (1) Warum kommt der Merkur-Kreuzer im Endspiel nie? (Code: Typ 4 „Merkur Medium“, ca. 1 von 8,
  Beobachtung passt nicht) (2) Wo bekommt man den **Plasmawerfer** im Spiel? Marcel: sicher beim Entern
  merkurianischer Schiffe; im Code (Läden, TREASURE, M052) nicht gefunden → Beute-Routine der Engine analysieren.
  Details und Aufgabenliste: `Uebergabe_2026-10-25.md`. **Neu bauen: NEIN.**

## Nachtrag 25.10.2026 (Claude, Opus): Plasmawerfer geklärt

- Die Beute kommt nicht aus `TREASURE`, sondern aus dem **Inventar der besiegten Gegner** (`sub_1631E`/`sub_16268`).
  Plasmawerfer trägt der **MER. LEADER** (Nr. 7). Beim Entern eines Merkur-Kreuzers (M052): sicher im
  **Maschinenraum** (unterstes Deck); außerdem in fast allen Truppenkämpfen auf Mariposa Three (M096/M098).
  Details: `Beute_Plasmawerfer.md`. Marcels Erinnerung ist damit bestätigt (Code). **Im Spiel nicht getestet.**
- Offen bleibt Frage (1) Merkur-Kreuzer selten/nie (`Uebergabe_2026-10-25.md`). **Neu bauen: NEIN.**

## Nachtrag 02.11.2026 (Marcel, Claude Sonnet)

- **Marcel, 02.11.2026:** Die bisherige Übersetzung gefällt ihm („soweit“). Das Thema **Plasmawerfer ist erledigt**
  (siehe `Beute_Plasmawerfer.md`); der Punkt ist damit nicht mehr offen. Details zum Test hat Marcel nicht genannt.
- Projektordner liegt jetzt unter **F:\Buck Rogers Disassembly** (vorher H:). Stand der Bauten unverändert:
  deutsch 989ABA78, Testfassung A11EB65A, Original 44E3BFFF. **Neu bauen: NEIN.**
- Weiter offen (laut Stand 25.10., nicht neu bestätigt): Frage Merkur-Kreuzer selten/nie, Planetenscan („Atmosphäre:“),
  `Testliste_Phase3.md` / `Testliste_Phase5.md` in Ares, Tor Phase 3, GitHub-Abgleich nach dem Ordnerumzug, Patch neu erzeugen.

- **Umzug auf F: (Marcel, 02.11.2026):** Projektordner liegt jetzt unter `F:\Buck Rogers Disassembly`. Ältere Dokumente nennen noch den
  H:-Pfad (historisch). `.git` ist mitgezogen, `origin` zeigt unverändert auf das GitHub-Repo; der lokale Stand ist noch der vom 24.10.
  Wahrscheinliche Ursache für die unterbrochene Verbindung: Git kennt den neuen Ordner nicht als sicher („dubious ownership“).
  `8_repo_verbinden.bat` und `9_repo_abgleich.bat` tragen den Ordner jetzt selbst ein; `8_` funktioniert auch mit vorhandenem `.git`
  (setzt `origin` neu, `fetch`, `reset` ohne `--hard`, Dateien bleiben unverändert). Sicherung der alten Skripte:
  `03_Tools\bak\repo_umzug_F_2026-11-02\`. **Test offen:** Marcel startet `8_repo_verbinden.bat` und meldet die Ausgabe.
  GitHub-Stand: Commit fb882e1 enthält bereits Plasmawerfer-Befund und Statusnachtrag.
- **GitHub-Verbindung auf F: bestätigt (Marcel, Screenshot, 02.11.2026, 22:35):** `8_repo_verbinden.bat` lief durch,
  `main` folgt `origin/main`, HEAD = e58a18e. Restliche Unterschiede und ihre Behandlung: 7 Dateien in
  `03_Tools\claude_werkzeuge\` fehlten auf F: (nur im Repo, von Claude erzeugt) → nach F: kopiert;
  `Uebergabe_2026-10-24.md` auf F: war der ältere Stand (20:55) → durch den Repo-Stand (21:20) ersetzt, alte Fassung in
  `03_Tools\bak\repo_umzug_F_2026-11-02\`; 5 PNGs in `claude\Vorschau\` „M“ (bekannt: C2PA-Herkunft, Pixel gleich);
  `Wechsel\` ist nicht im Repo (bewusst, Übergabedateien liegen nur lokal).

## Nachtrag 02.11.2026, 22:55 (Claude, Opus): Optionsmenü – Konzept
- Auftrag Marcel: Optionsmenü im Hauptmenü (Symbol frei), Raumkampf-Treffer eigene/Gegner prozentual, weitere Vorschläge.
- Code analysiert (Hauptmenü, Symbolbibliothek, Trefferwürfe), Entwurf und Entscheidungen O1–O4, Vorschläge V1–V10:
  `Optionen.md`, Vorschau `Vorschau/Optionen_Symbol_Vorschau.png`. **Nichts gebaut, Entscheidung Marcel offen. Neu bauen: NEIN.**
- **Entschieden 02.11.2026, 23:01 (Marcel):** O1 = C (Schieberegler), O2–O4 = A, alle Vorschläge V1–V10 einbauen. Bau beginnt (`Optionen.md`).
- **Optionsmenü Stufe 1 gebaut (02.11.2026, Claude, Opus):** Symbol, Optionsbildschirm, Raumkampf-Treffer, Unverwundbar,
  Munition, Würfeln, TP, EP, Credits, Heilung. Bau deutsch **DD098CB9**, Test **C0FAD96E**, Original bit-genau.
  Im Testemulator: Menü, Bildschirm, Werte, Würfeln MAXIMUM. Spieltest offen (`Testliste_Optionen.md`).
  **Stufe 2 offen:** V5 Bodenkampf, V8 Begegnungen, V10 START-Menü (`Optionen.md`). **Neu bauen: JA.**

## Nachtrag 03.11.2026 (Claude, Opus): Optionsmenü Stufe 2
- V5 Bodenkampf-Treffer, V8 Begegnungen im All (normal/halb/keine/Merkur+), V10 Optionen im START-Menü gebaut (Hooks 35–38, `Optionen.md`).
- Bau deutsch **CEDCE590**, Test **23B93157**, Original bit-genau. Im Testemulator geprüft (Messwerte in `Optionen.md`), **Spieltest in Ares offen** (`Testliste_Optionen.md`). **Neu bauen: JA.**
- Damit sind alle Vorschläge V1–V10 gebaut. Offen: Spieltest, Patch neu erzeugen, Phase 4 Testpaket, Release.
