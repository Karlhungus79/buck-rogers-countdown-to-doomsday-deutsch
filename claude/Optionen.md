# Optionsmenü (Extra, Phase 3+)

Stand: 02.11.2026 (Claude, Opus). **Konzept, nichts gebaut.** Auftrag Marcel 02.11.2026: Optionsmenü im Hauptmenü,
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

## Entscheidungen (offen, Marcel)

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
