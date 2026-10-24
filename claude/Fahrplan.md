# Fahrplan

Stand: 24.10.2026

## Phase 1 – Technisches Gerüst (Tor: Intro läuft deutsch, von Marcel bestätigt)

| Nr | Schritt | Stand |
|---|---|---|
| 1.1 | Schrift finden (ROM, Ladeweg, Ausgaberoutine) | erledigt 23.10.2026 (`Zeichensatz.md`) |
| 1.2 | Ä Ö Ü in die Schrift (Plätze `[ £ ]`) | **bestätigt in Ares 24.10.2026** |
| 1.3 | Textablage A: Text aus der ROM, 2 MB, Selbstprüfung, SRAM-Header | **bestätigt in Ares 24.10.2026** (Start, Spielstand laden, Texte) (`Textablage.md`) |
| 1.4 | Einsetz-Skript mit Prüfregeln, deutsche Textdateien, Vollbau-.bat | erledigt, Prüfregeln getestet |
| 1.5 | Intro M016_000–003 deutsch | **M016_000–002 bestätigt in Ares 24.10.2026**; M016_003 (Schlachtbild) nur im Testemulator gesehen |
| 1.6 | Entscheidung G1 neu (Kleinbuchstaben A/B) | entschieden 23.10.2026: B (Großbuchstaben, ß → SS) |
| 1.7 | Bau unter Windows reproduzieren (gleiche CRC32) | **bestätigt 24.10.2026**: Windows-Bau 14:27 (`2026-10-24_14-27-16_deutsch`), CRC32 E60AE2AA, 2.097.152 Byte, Header-Checksumme D034, Selbstprüfung 141FB059 (Screenshot `claude\Vorschau\Windows_Bau_2026-10-24.png`) |
| 1.8 | Tor Phase 1: Marcel bestätigt Intro in Ares | **erreicht 24.10.2026** (Screenshots `claude\Vorschau\Ares_Intro_2026-10-24_1–3.png`) |

## Phase 2 – Systemtexte (Tor: im Spiel bestätigt)

| Nr | Schritt | Stand |
|---|---|---|
| 2.1 | Systemtexte (393, `dat_11DC4`) in die Pipeline: Tabelle nach `$101000` (Hook 5), Prüfregeln | gebaut 24.10.2026 (`Systemtexte.md`) |
| 2.2 | Gegenstandsnamen: Tabelle fertiger Namen (Hook 6/7), Mehrzahl (Hook 8/9) | gebaut 24.10.2026 |
| 2.3 | Erstübersetzung aller Systemtexte + 90 Gegenstandsnamen | gebaut 24.10.2026, CRC32 598A9641 |
| 2.4 | Fensterbreiten messen (Testemulator) | teilweise: Menüs, Bogen, Gegenstände, Erschaffung, Namenseingabe, Ausbildung, Tempo, Kampfleiste |
| 2.5 | Entscheidungen E1–E4 (`Phase2_Entscheidungen.md`) | **entschieden 24.10.2026: alles A** |
| 2.6 | Spieltest Systemtexte in Ares (`Testliste_Phase2.md`) | **bestätigt 24.10.2026** (Marcel: alle Tests erfolgreich); Beute-Zeile danach geändert, Nachtest offen |
| 2.6a | Testfassung mit Entwickler-Jumper (Sprung in jedes Modul, `Testfassung.md`) | gebaut 24.10.2026, aktuell CRC32 7FF6DF75, Ares offen |
| 2.6c | Befund Marcel 24.10.2026: Kampfende „erbeutet: …“, S114 kürzer | S114 bestätigt; Beute-Zeile → 2.6d |
| 2.6d | Beute-Zeile „Erbeutet: keine Beute.“ (Hook 11, Zusatztext S393) | gebaut, deutsch CRC32 2E33C97D, Test 5BD1A1AE, Nachtest offen |
| 2.6b | Befund Marcel 24.10.2026: „Triebwerke“ im Schiffsstatus zu lang → „Antrieb“ (E5 = A) | gebaut, deutsch CRC32 88E08E82, Test offen |
| 2.7 | Monsternamen (`dat_9E77C`, Hook 12, `Monster_Abspann.md`) | gebaut 24.10.2026, Testemulator gesehen, Ares offen |
| 2.8 | Vorgefertigte Figuren (nur Eigennamen → nichts zu tun), Abspann (Hook 13) + Seite „Deutsche Lokalisierung“ (Variante C) | gebaut 24.10.2026, deutsch CRC32 0B58AE77, Test 37DE7A79, Ares offen |
| 2.9 | Menüs (HMENU) und ja/nein im Spiel ansehen | nicht einzeln gemeldet → in Phase 4 mitprüfen |
| 2.10 | Tor Phase 2: Marcel bestätigt Systemtexte im Spiel | **erreicht 24.10.2026** (Bau deutsch 0B58AE77, Test 37DE7A79) |

Nicht einzeln gemeldet, in Phase 4 mitprüfen: Beute-Zeile „ERBEUTET: …“ (2.6d), Monsternamen außer
TERRINE-KRIEGER (2.7), 2.9, M016_003 in Ares, Musik beim echten Spielende.

## Phase 3 – Grafik (Tor: im Spiel bestätigt)

| Nr | Schritt | Stand |
|---|---|---|
| 3.1 | Bestandsaufnahme: alle Grafiken mit englischem Text finden (Titelbild, Abspann-Kopf „CREATED BY THE …“, Game Over, Zwischenbilder, Karten), je Ort in der ROM, Format/Kompression, Kachelzahl, Palette → `Grafik.md` | erledigt 24.10.2026: 7 Bilder mit Text (G1–G7), Bildformat entschlüsselt |
| 3.2 | Grafik-Werkzeug (Python + .bat): Entpacken → PNG, PNG → Packen, Rundreise bit-genau | erledigt 24.10.2026 (`grafik.py` mit LZW-Packer, Rundreise geprüft; `grafik_deutsch.py`) |
| 3.3 | Wortlisten je Bild (Original → Deutsch, Breite in Kacheln), Entwürfe A/B/C als PNG in `Vorschau\` | Wortliste in `Grafik.md`; Marcel nicht erreichbar → je Bild eine Fassung |
| 3.4 | Marcel entscheidet je Bild | Claude selbständig entschieden 24.10.2026 (Auftrag Marcel), **im Spieltest prüfen** |
| 3.5 | Einsetzen, bauen, Testemulator, dann Spieltest in Ares (`Testliste_Phase3.md`) | gebaut 24.10.2026, deutsch CRC32 814E4C76, Test F436B9D1; Vorspann + Abspann-Kopf im Testemulator gesehen; G7 und Ares offen |
| 3.6 | Tor Phase 3: Marcel bestätigt Grafiken im Spiel | offen |
