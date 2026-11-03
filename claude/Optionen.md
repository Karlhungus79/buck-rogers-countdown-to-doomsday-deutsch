# Optionsmenü (Extra, Phase 3+)

Stand: 03.11.2026 (Claude, Opus). **Entschieden 02.11.2026, 23:01 (Marcel): O1 = C, O2–O4 = A, alle Vorschläge V1–V10 einbauen. Stufe 1 gebaut 02.11.2026, Stufe 2 gebaut 03.11.2026 (siehe unten), Spieltest in Ares offen.** Auftrag Marcel 02.11.2026: Optionsmenü im Hauptmenü,
Symbol nach Claudes Wahl („mach es einfach schön“), Raumkampf: eigene Treffer / Gegner daneben, prozentual einstellbar;
weitere Vorschläge (z. B. Würfeln).

## Befund aus dem Code (Original-ROM 44E3BFFF)

### Hauptmenü
- `sub_3D2` lädt die Symbolbank `dat_4EE` (67 Symbol-Nummern, Ende `$FF`) über `sub_A768`, dann Schleife
  `loc_418`: `sub_13C9C` mit Menü 0 → Auswahl 0–4 → Sprungtabelle `jt_4E2` (Auswahl > 0 wird um 1 erhöht,
  „Figur ausbilden“ ist im Hauptmenü ausgeblendet).
- Menütabelle `dat_13CC6`: je Menü 2 Wortversätze (Symbole, Beschriftung). Menü 0: 5 Symbole je 3 Byte
  (x, y in Kacheln, Symbol), y = 21, x = 8/13/18/23/28; Beschriftung: Fenster (2,25,37,25) + Systemtexte 61/63/64/65/66.
  Die Versätze sind 16 Bit (vorzeichenbehaftet) → eigene Tabellen ab `$100000` sind so nicht erreichbar;
  Lösung: Hook ruft `sub_1391A` direkt mit `a2` = eigene Symbolliste, `a3` = eigene Beschriftung.
- Platz für 6 Symbole: x = 6/11/16/21/26/31 (gleiche Mitte wie das Original).
- Menü 2/4 = START-Menü im Spiel (Ende, Speichern, Laden, Spieltempo, Musik an/aus).

### Symbole
- Bibliothek: Zeigertabelle `dat_F14F2`, 110 Symbole (Nr. 0–109), je LZW-Bild 3 × 3 Kacheln (24 × 24 Pixel),
  ohne eigene Palette. Lader `sub_A768` (`lea dat_F14F2.l`). Übersicht: `claude/Vorschau/Symbole_alle.png`.
- Neues Symbol = Nr. 110: Tabelle nach `$100000+` kopieren und um 1 Eintrag verlängern, `lea` in `sub_A768`
  umbiegen (gleiche Länge), Symbol in die Bank des Hauptmenüs (Kopie von `dat_4EE`) aufnehmen.
- Palette (aus Marcels Screenshot, ungefähr): 2 schwarz, 4 dunkelrot, 5 violett, 6 braun, 7 grau, 8 dunkelgrau,
  9 blau, 12 hellrot, 15 weiß. Hintergrund der Hauptmenü-Symbole: Schachbrett 9/5.

### Raumkampf-Treffer
- Gegner schießt: `loc_1824C`, W20 (`$6C8C`), 20 trifft immer, sonst Treffer wenn Wurf ≥ Zielwert (`d2`).
  Testfassung Hook 20 (`$1828A`) erzwingt Fehlschuss.
- Eigenes Schiff schießt: `loc_18A1A`, W20, 20 trifft immer, sonst Treffer wenn Wurf ≥ `-$CE(a6)`.
  Testfassung Hook 21 (`$18A3A`) erzwingt Treffer.
- Plan: die Folge „Wurf, Vergleich 20, Vergleich Zielwert“ (gleich lang) durch `jsr DE_…` + Sprung ersetzen.
  Neu pro Schuss: Zusatzwurf 1–100; ist er ≤ Einstellung, dann sicherer Treffer (eigenes Schiff) bzw. sicherer
  Fehlschuss (Gegner), sonst normaler W20-Wurf. 0 % = Original, 100 % = immer bzw. nie.
- Offen: weitere Würfe (`sub_18E6C`, `sub_1956E`, Raketen) prüfen, ob sie auch Schüsse sind.

### Speichern der Einstellungen
- SRAM ist voll: 8 KB (`$200001–$203FFF`, ungerade Bytes) = 8 Byte Kopf + 3 Spielstände × `$AA8`.

## Entwurf Optionsbildschirm

Gleicher Rahmen und Hintergrund wie das Hauptmenü. Oben eine Liste aller Einstellungen mit Wert, unten eine
Symbolreihe. Symbol wählen und C drücken schaltet den Wert weiter (0 → 25 → 50 → 75 → 100 → 0 %).

```
            OPTIONEN

   EIGENE TREFFER (RAUMKAMPF)   +50 %
   GEGNER TREFFEN NICHT         100 %

   [Fadenkreuz] [Schild] [Ende]
```

## Entscheidungen (Marcel, 02.11.2026, 23:01: „O1 = C, O2 bis O4 alles A, alle Vorschläge V einbauen“)

Ergebnis: **O1 = C** Schieberegler (neues Symbol), **O2 = A** 25-%-Schritte, **O3 = A** beide Fassungen
(deutsch Standard 0 %, Testfassung 100 %), **O4 = A** gilt bis zum Ausschalten. **V1–V10: alle einbauen.**

| Nr. | Frage | A (Empfehlung) | B | C |
|---|---|---|---|---|
| O1 | Symbol im Hauptmenü | Zahnrad (neu gezeichnet) | Schraubenschlüssel (Nr. 43, vorhanden) | Schieberegler (neu) |
| O2 | Schritte | 25 % (0/25/50/75/100) | 10 % (0–100) | – |
| O3 | Fassung | deutsche Fassung und Testfassung; deutsch Standard 0 % (= Original), Test Standard 100 % (= Hooks 20/21) | nur Testfassung | – |
| O4 | Speichern | bis zum Ausschalten (RAM), danach Original | im Spielstand mitspeichern (Platz noch zu suchen) | SRAM auf 16 KB (Risiko für vorhandene .ram) |

Vorschau der Symbole: `claude/Vorschau/Optionen_Symbol_Vorschau.png` (Pixelgrafik ist ein Entwurf, Feinschliff beim Bau).

## Weitere Vorschläge (Aufwand geschätzt, Code noch nicht geprüft)

| Nr. | Option | Werte | Aufwand |
|---|---|---|---|
| V1 | Würfelmodus bei der Figurenerschaffung | Original / 4W6, beste 3 / Mindestwert 12 / alles Höchstwert | mittel |
| V2 | Trefferpunkte beim Stufenaufstieg | Original / immer Höchstwert | klein–mittel |
| V3 | Erfahrungspunkte | ×1 / ×1,5 / ×2 / ×3 | klein |
| V4 | Credits aus Beute | ×1 / ×2 / ×3 | klein |
| V5 | Bodenkampf: eigene Treffer / Gegner daneben | wie Raumkampf in % | mittel |
| V6 | Maelstrom Rider unverwundbar | aus / an (Hook 22 als Option) | klein |
| V7 | Raketen/Munition im Raumkampf nicht verbrauchen | aus / an | klein–mittel |
| V8 | Zufallsbegegnungen im All | normal / halb / aus; Merkur-Kreuzer häufiger | mittel |
| V9 | Volle Heilung nach jedem Kampf | aus / an | mittel |
| V10 | Optionen auch im START-Menü während des Spiels (neben Spieltempo/Musik) | – | mittel |

## Stufe 1 – gebaut 02.11.2026 (Claude, Opus)

Bau: deutsch **DD098CB9**, Testfassung **C0FAD96E** (2 MB), Original weiterhin bit-genau (44E3BFFF).
Im Testemulator gesehen: Hauptmenü mit 6. Symbol (Schieberegler, „OPTIONEN“), Optionsbildschirm, Werte mit C vor
und B zurück, START/Ende zurück ins Hauptmenü (Zeiger bleibt auf „Optionen“), Testfassung zeigt Standard 100 %/100 %/AN,
Attribute „MAXIMUM“ → alle 18 (vor Rassen-/Klassenzuschlag), TP „MAXIMUM“ wirkt bei der Erschaffung.
**Nicht im Spiel getestet:** Raumkampf-Treffer, Unverwundbar, Munition, EP-/Credits-Faktor, Heilung.

Technik (Code `src/optionen.asm`, eingebunden aus `src/deutsch.asm`; alle Hooks gleich lang wie das Original,
Rückfallwert jeweils im `else`-Zweig von `buckrogers.asm`, Sicherung `03_Tools\bak\optionen_2026-11-02\`):

| Hook | Stelle | Wirkung |
|---|---|---|
| 24 | Anfang `sub_13C9C` | `DE_Menue`: Menü 0 mit 6 Symbolen, Auswahl 5 → `DE_Optionen`; andere Menüs wie Original (`loc_13CA2`) |
| 25 | `sub_4C0` | Hauptmenü-Symbole `DE_M0_Symbole` (x = 6/11/16/21/26/31) |
| 26 | `sub_3D2` | Symbolbank `DE_Bank0` = Original + 110 + Symbole des Optionsbildschirms (eine zweite Bank geht nicht: Grafikspeicher ist ein Stapel, „GRAPHICS FREED OUT OF ORDER“) |
| 27 | `sub_A768`, `loc_10AC0` | Symboltabelle `DE_Symboltabelle` (Kopie + Symbol 110, `grafik_deutsch.py` → `deutsch\symbol_110.bin`) |
| 20 | `loc_1824C` | `DE_RaumGegner` (ersetzt den alten Testfassungs-Hook) |
| 21 | `loc_18A1A` | `DE_RaumEigen` (ersetzt den alten Testfassungs-Hook) |
| 22 | `sub_19360` | `DE_Unverwundbar` jetzt in beiden Fassungen, wirkt nur mit Option AN |
| 33 | vor `loc_18A1A` | `DE_Munition`: Munition `$3(a2)` wird nicht verringert |
| 28 | `loc_622` | `DE_Attributwurf`: W8 / bester von 2 / mindestens 4 / 8 (+10 durch das Spiel) |
| 29 | `sub_B1C` | `DE_TPWurf`: Trefferwürfel der Klasse oder Höchstwert (Stufenaufstieg **und** Erschaffung) |
| 30 | `loc_163F8` | `DE_EPEnde`: EP je Figur nach dem Kampf × Faktor (Meldung zeigt den neuen Wert) |
| 31 | `loc_3BCE` | `DE_EPEcl`: EP aus Ereignissen × Faktor |
| 32 | `sub_1631E` | `DE_Credits`: Credits je besiegtem Gegner × Faktor |
| 34 | `sub_16560` | `DE_EPHeilung`: EP wie Original, bei Option AN aktuelle TP = Höchst-TP (nur wenn der Kampf EP bringt) |

Einstellungen im RAM `$FFFFF6–$FFFFFB` (über dem Stapel, vom Spiel nie benutzt), je 4 Bit, gespeichert als
„Wert XOR Standard“ → nach dem Einschalten (RAM = 0) gilt der Standard der Fassung. Nach einem Reset (Knopf)
bleiben die Einstellungen vermutlich erhalten (das Spiel löscht den RAM nur beim Einschalten) – im Spieltest prüfen.

## Stufe 2 – gebaut 03.11.2026 (Claude, Opus)

Bau: deutsch **CEDCE590**, Testfassung **23B93157** (2 MB), Original weiterhin bit-genau (44E3BFFF).
Sicherung vor dem Umbau: `03_Tools\bak\optionen_stufe2_2026-11-03\`. Alle Hooks gleich lang wie das Original, Rückfallwert im `else`-Zweig.

| Hook | Stelle | Wirkung |
|---|---|---|
| 35 | `loc_10804` und `sub_10FAA` | `DE_BodenWurf`: Trefferwurf im Bodenkampf und Zielwurf der Flächenwaffen; Bit 0 von `$1(a3)` gesetzt = eigenes Team |
| 36 | `sub_B91A`, zweiter W100 | `DE_Begegnung`: Grenze 10 (normal, Merkur+), 5 (halb), 0 (keine) |
| 37 | `loc_351E` (ECL `RANDOM`) | `DE_EclZufall`: nur M034 `$71CA` „RANDOM 7 $97FB“; bei Merkur+ Typ zur Hälfte 4, sonst Wurf wie im Original |
| 38 | `dat_4CA8` | Symbolbank des START-Menüs mit Symbol 110 |
| 24 | `DE_Menue` (erweitert) | Menü 2 und 4 mit zusätzlichem Symbol, Auswahl → `DE_OptionenSpiel` |

### Befund
- **Bodenkampf:** Alle normalen Angriffe (Spieler, Gegner, Gelegenheitsangriffe) laufen über `sub_1074A` → `sub_107E8` → `loc_10804`: W20, Treffer wenn Wurf ≤ `$D511` (1–19). Flächenwaffen (`sub_10FAA`): Wurf > `$D511` = Ziel verzieht (`sub_1137E`).
- **Begegnungen:** Nicht im ECL-Skript entschieden, sondern im Kartencode `sub_B91A`, nur im leeren All (`d7` = 0): je Bild W100 = 1 und W100 ≤ 10, also 1 : 1000 je Bild, danach 300 Bilder Pause (`$BA62`). Danach `$979B` = 0 → M034 `$71C7` wählt den Schiffstyp.
- **START-Menü:** Aufruf nur aus der Laufschleife (`loc_4A82` → `sub_4BF0`). Menü 4 ist der Normalfall, Menü 2 (zusätzlich Symbol 38, Skript-Protokoll) nur mit `$CA21` = 0.
- **Neuzeichnen:** Ablauf wie „Speichern“ (`sub_1930`/`sub_1A9E`): Symbolbank frei, Modus merken, `sub_AF00` im Modus 0 baut das Grundbild (Rahmen, Schrift), eigene Bank `DE_BankOpt`, Optionsbildschirm, Bank frei, Werte zurück, `sub_AF00` stellt das Spielbild wieder her.

### Im Testemulator geprüft (03.11.2026, nicht in Ares)
- **Optionsbildschirm:** 12 Zeilen, 13 Symbole in beiden Fassungen; deutsch alles AUS/ORIGINAL/NORMAL.
- **V5, 30 Runden Arena gegen 3 Gegner:** Gegner 0 %: Team verliert 20 TP; Gegner 100 %: Team verliert 0 TP, eigene Treffer unverändert. Eigene Treffer 100 %: Kampf durchgehend gewonnen, Schadenssumme höher. **Die genaue Trefferquote bei 25/50/75 % ist nicht gemessen.**
- **V8, je 40 Versuche mit gemischtem Zufallsspeicher:** Zeit bis zur Begegnung im Mittel normal 1048, halb 2150 Bilder; keine: 12 Versuche je 9000 Bilder ohne Begegnung. Typen (0 Scout, 1 Medium, 2 Heavy, 3 Piraten, 4 Merkur): normal 8/6/12/7/7, Merkur+ 2/9/4/2/**23**; Merkur+ ohne Merker 17/23/0/0/0 (nur RAM, wie im Original).
- **V10:** START-Menü mit Symbol (Menü 4 und 2), Optionsbildschirm, Rückkehr über Ende und START, Spielbild pixelgleich bis auf blinkende Lampen. Danach gehen, Arena-Kampf bis zum Sieg, Speichern-Menü ohne Absturz.

### Entscheidungen von Claude (im Spieltest prüfen)
- **Merkur+** wirkt nur, wenn einer der Merker `$9876`, `$9855`, `$98B0` gesetzt ist; vorher kommen wie im Original nur RAM-Scout und RAM Medium (Handlung bleibt intakt). Häufigkeit gemessen etwa 58 % statt etwa 12,5 %.
- **Testfassung:** Bodenkampf-Optionen stehen auch dort standardmäßig auf AUS (O3 nennt nur den Raumkampf).
- **Flächenwaffen:** Sicherer Treffer heißt: kein Verziehen; bei „Gegner daneben“ verzieht der Wurf immer, kann aber trotzdem jemanden treffen.
- **Anzeige „TREFFER: 65 %“** im Zielmodus zeigt weiter den Wert ohne Option.

## Nachtrag 03.11.2026, 22:30 (Claude, Opus): Waffen frei, Korrektur Symbolbank

Bau: deutsch **B9B201DF**, Testfassung **B2835D58**, Original weiterhin bit-genau. Sicherung: `03_Tools\bak\optionen_waffen_2026-11-03\`.

| Hook | Stelle | Wirkung |
|---|---|---|
| 40 | Anfang `sub_18792` (Figurenmenü Raumkampf) | `DE_WaffenFrei`: mit Option „Munition unbegrenzt“ Schusszähler `-$5E(a6)` je Waffe = intakte Geschütze |
| 39 | `lea ($4EE).w` hinter `sub_A768`, nach „Kampffigur wählen“ | `DE_Bank0Laden`: Fehler aus Stufe 1 behoben, nach dem Erschaffen einer Figur fehlten Symbol 110 und Symbole des Optionsbildschirms |

### Befund Waffen
- Waffenplatz `$C(a1)` + 5 × n: Typ, Geschütze gesamt, intakt, Munition, Magazine. Typtabelle `dat_176FA` je 5 Byte: Reichweite, Schuss je Magazin, Schaden, Treffer-Änderung, Text.
- Marcels Schiff (Spielstand Luke): K-Kanone 2 Geschütze, Reichweite 2, Munition 12, 5 Magazine; Rakete 2 Geschütze, Munition 8; Strahllaser 5 Geschütze.
- Bisher wirkte die Option nur auf den Munitionsverbrauch. Drei Grenzen blieben: Schüsse je Runde (`-$5E` wird je Schuss verringert), Reichweite (`loc_191D2`, feste Sperre beim Abdrehen in `sub_18C30`), leeres Magazin.

### Im Testemulator geprüft (Spielstand mit Luke, Reichweite 3, nicht in Ares)
- Option AN: alle 6 Figuren können in derselben Runde die K-Kanone wählen; Munition bleibt 12. Mit eigenen Treffern 100 % zerstörten zwei Schüsse den Aufklärer.
- Option AUS: K-Kanone bei Reichweite 3 gesperrt wie im Original.
- Hook 39: nach dem Erschaffen einer Figur sind Hauptmenü-Symbol und alle Optionssymbole da.

### Entscheidungen von Claude (im Spieltest prüfen)
- Die Option hebt auch die **Reichweite** auf, weil die K-Kanone sonst ohne Piloten kaum nutzbar ist. **Zerstörte Geschütze bleiben gesperrt.**
- Gilt nur für das eigene Schiff, Gegner unverändert. Bodenkampf-Waffen sind nicht betroffen.
- Die Trefferchance bleibt: Die K-Kanone zeigt bei Luke auf Reichweite 3 „TREFFER: 0“. Für sichere Treffer zusätzlich „Raumkampf: eigene Treffer“ setzen.

### Offen
- **Blaue Flächen:** Optionsbildschirm aus dem Hauptmenü mit geladenem Team zeigt blaue Flächen und Reste der Lebensbalken über dem Text. Ursache offen; über das START-Menü tritt es nicht auf.
