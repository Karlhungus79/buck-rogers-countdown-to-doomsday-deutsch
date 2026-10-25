# Grafik – Phase 3

Stand: 24.10.2026, 20:40 (Claude, selbständig – Marcel nicht erreichbar, Entscheidungen „im Spieltest prüfen“)

**Stand Umsetzung:** G1, G3–G7 deutsch **gebaut** (deutsch CRC32 **814E4C76**, Test **F436B9D1**).
Im Testemulator gesehen: Vorspann PRÄSENTIERT / DOOMSDAY LASER AKTIV / ZIEL? / ERDE
(`Vorschau\Phase3_Vorspann_Testemulator_2026-10-24.png`), Abspann-Kopf „ENTWICKELT VOM“
(`Vorschau\Phase3_Abspannkopf_Testemulator_2026-10-24.png`). G7 (Raumkampf-Anzeige) nur als Vorschau
(`Vorschau\Phase3_G6_G7_Vorschau_2026-10-24.png`), im Spiel noch nicht gesehen. **Ares offen.**
Original-Bau weiterhin bit-genau (geprüft 24.10.2026).

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

## Umsetzung (24.10.2026)

- `03_Tools\grafik_deutsch.py` erzeugt aus den Original-Bildern der ROM die deutschen Bilder
  (Buchstaben aus derselben Schrift, fehlende Buchstaben als Pixelmuster im Skript), packt sie mit
  dem LZW-Packer aus `grafik.py` nach `02_Extracted\deutsch\grafik_G*.bin` (nicht im Repo) und legt
  Vorschaubilder in `05_German_Script\Grafik\deutsch\` ab. `7_deutsch_bauen.bat` und
  `7b_testfassung_bauen.bat` rufen es nach dem Texteinsetzen auf.
- Ablage in der ROM ab `$1C0000` (`src\deutsch.asm`, Prüfung auf Ende vor `$200000`).
- DEUTSCH-HOOKs 14–19 in `buckrogers.asm`: je ein `lea (dat_…).l,a0` → `lea (DE_Grafik_Gn).l,a0`
  (6 Byte wie Original, Rückfallwert = Original-Zeiger):
  14 = G1 (`sub_12FC`), 15 = G3, 16 = G4, 17 = G5 (alle Vorspann `sub_12FC`), 18 = G6 (Abspann
  `loc_6160`), 19 = G7 (Raumkampf `loc_8462`).
- Kachelzahlen: G1 283 (Original 275), G3 25 (26), G4 26 (31), G5 15 (22), G6 59 (59), G7 42 (42).
  G1 hat 8 Kacheln mehr – im Testemulator ohne Fehler (VRAM reicht), im Spieltest beobachten.
- Gewählte Texte (Claude, im Spieltest prüfen): PRÄSENTIERT, AKTIV, ZIEL?, ERDE,
  ENTWICKELT VOM (liest sich mit Logo und Zeile darunter: „entwickelt vom SSI Special Projects
  Team“), Raumkampf-Kürzel WAFF / STRG / ANTR / RUMPF.

## Befund und Korrektur G7 (24.10.2026, 21:51)

- **Befund (Marcels Ares-Screenshot, Raumkampf):** In der Schiffsanzeige standen in den Balken
  Buchstabenstücke und Kürzel (z. B. „ANTR | LLLLLLL WAFF“) statt Balken. **Ursache:** Das Spiel nutzt
  die Kacheln von G7 nicht nur über die Kachelkarte, sondern zeichnet die Balken mit **festen
  Kachelnummern** ($00–$17 Balkenteile, $18 Leerfeld, $19 Rand). `pixel_karte()` hatte die Kacheln
  beim Neupacken neu durchnummeriert (Kürzel vorne, Balkenteile hinten) – Anzahl 42 gleich, Reihenfolge nicht.
- **Korrektur:** neue Funktion `pixel_karte_fest()` in `03_Tools\grafik.py`: Kachelnummern,
  Reihenfolge und Karte bleiben wie im Original, nur der Inhalt der Kürzel-Kacheln $1A–$29 wird ersetzt.
  `grafik_deutsch.py` nutzt sie für G7 (`FESTE_KACHELN`) und bricht ab, wenn sich eine Kachel
  $00–$19 ändert. Geprüft (Linux, 24.10.2026): Karte = Original, nur $1A–$29 geändert, Pixel wie gewollt.
  G7 gepackt jetzt 818 Byte (vorher 808). Sicherung der alten Skripte:
  `03_Tools\bak\G7_Kachelreihenfolge_2026-10-24\`.
- **Lehre:** Bei Bildern, deren Kacheln der Code direkt anspricht, nie neu durchnummerieren.
  G1, G3–G6 zeigen nur über die Karte an (im Testemulator gesehen) – dort bleibt `pixel_karte()`.
- Erwartete CRC32 nach Neubau (sonst unverändert gegenüber Bau 21:09): deutsch **FFB78D02**, Test **31A7C400**.
  **Bestätigt am 24.10.2026 in Ares** (Marcel, Screenshot Sonnensystem-Karte): WAFF / STRG / ANTR / RUMPF
  mit sauberen Balken. Beobachten: das F von RUMPF steht dicht am Balken.
