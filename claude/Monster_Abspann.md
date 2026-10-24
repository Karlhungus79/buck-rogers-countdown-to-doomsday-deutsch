# Monsternamen, vorgefertigte Figuren, Abspann

Stand: 24.10.2026 – **gebaut, im Testemulator gesehen (Kampfleiste „TERRINE-KRIEGER“, Abspann
deutsch); Test in Ares offen.** Bild: `Vorschau\Phase2_Monster_Abspann_Testemulator_2026-10-24.png`.

## Monsternamen (DEUTSCH-HOOK 12)

- Daten: `dat_9E77C` (LZW): 2 Byte Anzahl (54), Monsternummern, dann je Monster ein Datensatz
  von `$D6` Byte (gleiches Format wie Teamfiguren), **Name = Byte 0–15** (15 Zeichen + Ende).
- Laden: `sub_48E8` entpackt die Datensätze nacheinander in den Figurenplatz (`$FFFFBA68 + n × $D6`),
  bis die gesuchte Nummer (`d2`) erreicht ist.
- Hook 12 am Ende des Ladens (`move.b d3,$3F(a3) / moveq #0,d0`, 6 Byte) → `jsr DE_Monstername`:
  führt die zwei Befehle aus und kopiert den deutschen Namen aus `DE_Monstertabelle`
  (1 Byte Nummer + 16 Byte Name, Ende `$FF`) über das Namensfeld. Rückfallwert: Originalbefehle.
  Die komprimierten Daten bleiben unverändert (kein LZW-Packer nötig).
- Textdatei: `05_German_Script\monster.toml` (`nr`, `en`, `de`), Prüfung ≤ 15 Zeichen.
- 33 Namen deutsch nach Glossar Liste 5 (5-33 bis 5-53). Unverändert (Glossar): HEXADILLO,
  URSADDER, ACIDICIUM, RAM L.D./H.D./L.S./H.S. ROBOT, MER./VEN. H.S. ROBOT, RAM MAR/MER/VEN
  CGENNIE, RAM G.D. GENNIE (Kürzel, nicht im Glossar – wie die übrigen Kürzel unverändert),
  Eigennamen TALON, TUSKON, LEANDER, ZANE, BUCK ROGERS, BEOWULF SAND, JASON BRAGA, CARLOS RIOJA.
- Monster in Spielständen behalten den Namen, mit dem sie geladen wurden (Kampf läuft in RAM).

## Vorgefertigte Figuren

`dat_6BAAD` (LZW, 8 Figurenplätze): enthält nur die Namen FLAVIUS, CELESTE, PIERRE, NICHOLE,
ROARKE, JANELLE und Werte – **keine Übersetzung nötig** (G6 Eigennamen).

## Abspann (DEUTSCH-HOOK 13)

- Daten: `dat_632E` (ROM `$632E`, 799 Byte): `$FC n` Bild, `$FF n` Seitenwechsel mit Bild,
  `$FE` + Text = Überschrift (x=0, weiß), Text = Name (x=3, grün), `$FD` Ende. Ausgabe `sub_61..`
  (Schleife ab `loc_61CA`).
- Hook 13: `lea (dat_632E).l,a2` → `lea (DE_Abspann).l,a2` (6 Byte). Rückfallwert: Original.
- Textdatei: `05_German_Script\abspann.toml` (`[[zeile]]` mit `art`, `wert`/`en`/`de`).
  **Neue Zeilen dürfen eingefügt werden** (Phase 6: Übersetzungs-Credits, Projektanweisung 10).
  Prüfung: Zeile ≤ 24 Zeichen (längstes Original 22; Platz links neben dem Planeten ca. 20–22,
  im Bild geprüft: „PROGRAMMIERASSISTENZ“ passt).
- Überschriften deutsch (Claude, im Spieltest prüfen): Spielentwicklung, Chefprogrammierer,
  Programmierassistenz, Technische Hilfe, Begegnungsdesign, Grafikleitung, Chefgrafiker,
  Porträts, Großgrafiken, Wände und Böden, Raumkampfschiffe, Kampffiguren, Musik und Klänge,
  Spieltests, Weitere Spieltests, Projektleitung, Produzent für EA. Namen unverändert.
- Der Kopf „BUCK ROGERS / COUNTDOWN TO DOOMSDAY / CREATED BY THE SSI SPECIAL PROJECTS TEAM“
  ist **Grafik** (nicht in den Texten gefunden) → Phase 3.
- **Deutsche Lokalisierung (Marcel 24.10.2026):** eigene letzte Seite vor dem Ende, Bild 62
  (Buck-Rogers-Porträt), **Variante C (Marcel 24.10.2026: „C“)**: „DEUTSCHE LOKALISIERUNG“, dann
  je Aufgabe Überschrift (weiß) + Name (grün): PROJEKTLEITUNG / KARLHUNGUS, ÜBERSETZUNG /
  KARLHUNGUS, TESTS / KARLHUNGUS. Im Testemulator gesehen (`Vorschau\Abspann_Ende_2026-10-24.png`).
  Vergleich A/C: `Vorschau\Abspann_Lokalisierung_A_C_2026-10-24.png`; A gesichert in
  `03_Tools\bak\credits_2026-10-24\abspann_variante_A.toml`.
- Bildnummern für `seite`/`bild` (Testemulator 24.10.2026): 48 Venus-Berg, 49 Skorpion, 50 Terrine,
  51 Dschungelruine, 52 Desert Runner, 53–57 und 63 Sternenhimmel, 58 Pirat, 59 Lowlander,
  60 Echsenkrieger, 61 Gennie, **62 Buck Rogers**, 64 Scot.DOS, 65 Station, 66 NEO-Offizier,
  67 Monster, 68/69 Labor, 70–72 Planeten.
- Breite: Zeilen über ca. 22 Zeichen laufen in den Planeten (unleserlich) → Prüfung 24.
- **Keine Musik im Test-Abspann** (Marcel 24.10.2026): auch in einer Testfassung mit englischem
  Original-Abspann (nur Jumper freigeschaltet) stumm – also Verhalten des Entwickler-Tests, nicht
  der Übersetzung. Ob das echte Spielende Musik spielt: im Spieltest des Finales prüfen.
- Abspann im Spiel ansehen: Testfassung, Jumper → NEXT → NEXT → TESTS → CREDITS.
- Englischer Vergleichsbau: Abspann bytegleich mit dem Original (geprüft).
