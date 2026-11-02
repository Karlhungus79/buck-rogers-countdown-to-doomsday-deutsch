# Kampfbeute und Plasmawerfer

Stand: 25.10.2026 (Claude, Opus). Aus Code und Spieldaten der Original-ROM (44E3BFFF) abgeleitet.
**Im Spiel nicht getestet.**

## Wie die Engine Beute vergibt

- Nach jedem Kampf (`COMBAT`, Opcode 36, Handler `sub_38BA`) läuft `sub_1631E`. Für jeden besiegten
  Gegner (Kampfplatz ab 8, Statusbyte negativ) werden seine Credits (Figur `+$1A`) und **alle 13
  Gegenstandsplätze** (Figur `+$54`, je 10 Byte) über `sub_16268` in die Beuteliste `$FFFFB9F4` übernommen.
- Ein Gegenstand fällt nicht, wenn Byte 5 Bit 6 gesetzt ist (z. B. eingebaute Roboterwaffen, `$40`/`$C0`).
  Byte 5 = `$80` (Bit 7, „bereit“) fällt.
- Keine Beute bei `HIDEITEMS 0` (`$97AE`) oder bei `DUEL` (`$BA5B`). Beides kommt in M052, M096 und M098 nicht vor.
- Gleiche Gegenstände werden in der Liste zusammengefasst, höchstens 14 Einträge.
- `TREASURE` (Handler `loc_392C`) füllt dieselbe Liste aus dem ECL-Skript. Das ist nur ein **zweiter**
  Weg; deshalb war der Plasmawerfer über `TREASURE`, Läden und M052-Texte nicht zu finden.
- Die Monsterdatensätze (`dat_9E77C`, `$D6` Byte) haben dasselbe Format wie Teamfiguren, inklusive Inventar.

## Plasmawerfer (Gegenstand `$11`, Systemtext S018)

Wer ihn im Inventar hat (Monsterdatensatz):

| Nr. | Gegner | Eintrag | fällt? |
|---|---|---|---|
| 7 | MER. LEADER | `11 00 00 12 00 80 06 40 00 0A` | **ja** |
| 23 | RAM ASSAULT BOT | `11 00 00 12 00 C0 …` | nein (eingebaut) |
| 107 | JASON BRAGA (Figur) | `11 00 00 12 00 80 …` | – (keine Kampffigur) |

Die Sonnet-Suche vom Vormittag hat den Eintrag nicht gefunden, weil Byte 5 im Inventar `$80` ist,
in der Gegenstandstabelle `$00`.

## Wo der MER. LEADER kämpft

### Entern eines merkurianischen Kreuzers (M052, Schiffstyp `$9924` = 4)

Besatzung je Kampf: Index = 5 × Typ + Versatz, Tabellen `$75E2/$75FC` (Gegner), `$7616/$7630` (Anzahl).

| Versatz | Gruppe 1 | Gruppe 2 | Kampf im Skript |
|---|---|---|---|
| 1 | 1 × MER. TECHNICIAN | 11 × MER. WARRIOR | Rückweg zur Schleuse, Gefängnis, Kapitänswache |
| 2 | 4 × RAM H.S. ROBOT (Nr. 28, so im Original) | 8 × MER. WARRIOR | Patrouille |
| 3 | 4 × MER. TECHNICIAN | 11 × MER. WARRIOR | **Brücke** („GUARDS HOLD THE BRIDGE CONTROLS“) |
| **4** | **1 × MER. LEADER** | 10 × MER. WARRIOR | **Maschinenraum** („GUARDS HOLD THE ENGINE CONTROLS“, unterstes Deck), Angriff durch die Schleuse, zufällig Gefängnis/Patrouille |
| 5 | 6 × MER. WARRIOR | – | Patrouille |

Sicherer Weg beim Entern: **Maschinenraum auf dem untersten Deck** (einmal je Schiff, Merker `$9802` Bit `$20`).

### Mariposa Three (M096, M098) – häufiger und ohne Merkur-Kreuzer

MER. LEADER kämpft dort in fast jedem Truppenkampf:
- M096 `$6F49` „TROOPS CHARGE. DO YOU SURRENDER?“ (NEIN): 2 Leader, 10 Warrior, 8 H.S.-Roboter
- M096 `$6FC4` Sicherheitsalarm: 1 Leader, 5 Warrior
- M096 `$7013` „GUARDS BURST OUT FROM EVERYWHERE“: 1 Leader, 7 Warrior, 6 Roboter
- M096 `$71C3` Truppen auf der Plaza (nicht fliehen): 1 Leader, 5 Warrior, wiederholbar
- M098 `$6E00` „WARRIORS SENT BY THE SUN KING …“: 1 Leader, 4–7 Warrior

## Test (offen)

Testfassung A11EB65A, Spielstand 4, Jumper **ECL 96 / Disk 6** (Mariposa: Einschleusung), einen der
Kämpfe oben gewinnen. Erwartung: Beute „ERBEUTET: …“ mit PLASMAWERFER.
