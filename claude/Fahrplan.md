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
| 1.7 | Bau unter Windows reproduzieren (gleiche CRC32) | wartet auf Marcel |
| 1.8 | Tor Phase 1: Marcel bestätigt Intro in Ares | **erreicht 24.10.2026** (Screenshots `claude\Vorschau\Ares_Intro_2026-10-24_1–3.png`) |

## Danach (Phase 2 – Systemtexte), vorläufige Reihenfolge

1. Systemtexte (393, Tabelle `$011DC4`) in die Pipeline: Einsetzen, Tabelle bei Bedarf nach `$1xxxxx`
   verschieben (4 Verweise), Fensterbreiten messen.
2. Monsternamen (`dat_9E77C`, LZW, 15 Zeichen), vorgefertigte Figuren, Abspann: Struktur analysieren.
3. Zusammengesetzte Gegenstandsnamen (S001–S044) prüfen.
4. Menüs (HMENU) im Spiel ansehen, ja/nein-Breite.
