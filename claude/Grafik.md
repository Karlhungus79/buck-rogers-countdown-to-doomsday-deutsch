# Grafik – Phase 3

Stand: 24.10.2026 (Claude, selbständig – Marcel nicht erreichbar, Entscheidungen „im Spieltest prüfen“)

## Bildformat (aus dem Code, `sub_9DD4` / `sub_9D66` / `sub_9BB6`)

Alle Bilder sind LZW-gepackt (gleicher Packer wie die Texte) und haben diesen Aufbau:

| Teil | Inhalt |
|---|---|
| Wort 0 | Anzahl Kacheln |
| Wort 1 | Länge der Kachelkarte in Byte |
| Wort 2 | Paletten-Bits: je gesetztem Bit 0–3 folgt eine Palette (32 Byte) für CRAM-Zeile 0–3 |
| Karte | Worte: Bit 0–9 Kachel, 11 H-Spiegel, 12 V-Spiegel, 13–14 Palette, 15 Priorität |
| Paletten | je 16 Farben |
| Kacheln | je 32 Byte, 4 bpp |

Breite und Bildschirmposition stehen nicht im Bild, sondern im Code (Aufruf `sub_95BE`, `sub_166C`
= Buchstabe für Buchstabe einblenden, `sub_1628`). Die Kachelkarte nutzt doppelte und gespiegelte
Kacheln.

Werkzeug: `03_Tools\grafik.py` – LZW-**Packer** (neu, passend zum Entpacker des Spiels),
Bild lesen/schreiben, PNG-Export, Rundreise-Prüfung. Prüfung 24.10.2026: alle 7 Bilder
entpacken → neu packen → entpacken = gleich (Pixel und Daten), Original-Datenströme ebenso.

## Bestandsaufnahme: Bilder mit englischem Text

Gefunden durch Entpacken aller 36 Bilddateien der ROM und Durchsicht (Übersicht
`Vorschau\Grafik_alle_Bilder_2026-10-24.png`) sowie Mitschnitt des Vorspanns im Testemulator.

| Nr | ROM | Größe (Kacheln) | Wo | Text | Entscheidung (Claude, im Spieltest prüfen) |
|---|---|---|---|---|---|
| G1 | `$099B5F` | 40 × 28 | Vorspann, SSI-Logo | STRATEGIC SIMULATIONS, INC. / PRESENTS | Firmenname bleibt; PRESENTS → PRÄSENTIERT |
| G2 | `$09AB8B` | 28 × 3 | Vorspann, Terrine-Bild, wird eingetippt | DOOMSDAY LASER | bleibt (Glossar 2-31: Doomsday-Laser) |
| G3 | `$09ACF7` | 11 × 3 | Vorspann | ACTIVE | → AKTIV |
| G4 | `$09AE4D` | 14 × 3 | Vorspann | TARGET? | → ZIEL? |
| G5 | `$09AFAA` | 10 × 3 | Vorspann, Erdbild, wird eingetippt | EARTH | → ERDE |
| G6 | `$0725C6` | 40 × 10 | Abspann-Kopf | BUCK ROGERS / COUNTDOWN TO DOOMSDAY / CREATED BY THE / SSI / SPECIAL PROJECTS TEAM | Titel und Teamname bleiben; CREATED BY THE → ENTWICKELT VOM |
| G7 | `$0E8BF4` | 30 × 4 | Raumkampf, Schiffsanzeige | WEAP / CNTL / ENGN / HULL | → Kürzel nach Glossar 3-38 (Waffen/Steuerung/Antrieb/Rumpf) |

Bleibt unverändert (keine Übersetzung nötig): EA-Logo, Titelbild „BUCK ROGERS“ mit XXVc-Logo
(Spieltitel), Copyright-Zeilen im Titel (E4 = A, Text), Countdown-Ziffern (G0 `$09B0B9`),
alle übrigen Bilder (Landschaften, Porträts, Schiffe, Karten – ohne Schrift).

Noch nicht geprüft (Phase 4 im Spieltest beobachten): Sprite-Grafiken außerhalb dieser
Bilddateien (z. B. Raumkampf-Symbole), Spielende/Game Over.

## Vorgehen beim Einsetzen

- Neue Buchstaben werden aus den vorhandenen Buchstaben derselben Schrift zusammengesetzt bzw.
  im gleichen Stil gezeichnet (K, Z, Ä, I …), Daten neu gepackt und in den deutschen Bereich
  der ROM gelegt; im Code wird nur der Zeiger (`lea (dat_…).l,a0`) umgestellt (DEUTSCH-HOOK 14 ff.,
  gleiche Länge, Rückfallwert = Original-Zeiger).
- Breite der eingetippten Texte (G2–G5) wird im Code mitgegeben; bei abweichender Breite
  wird der Aufruf angepasst.
