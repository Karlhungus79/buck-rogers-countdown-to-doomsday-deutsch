# Systemtexte – Umsetzung (Phase 2)

Stand: 24.10.2026 – **gebaut, im Testemulator geprüft (Menüs, Charakterbogen, Gegenstände,
Erschaffung, Namenseingabe, Ausbildung, Spieltempo, Kampfleiste); Test in Ares offen.**

## Was die Systemtexte sind

- Tabelle `dat_11DC4` (ROM `$011DC4`): 393 Einträge S000–S392, 16-Bit-Offsets relativ zum
  Tabellenanfang (`adda.w` → vorzeichenbehaftet, Tabelle muss < 32 KB bleiben), Texte dahinter.
- Zugriff nur über 4 Stellen `lea (dat_11DC4).l` (`sub_11B9A`, `sub_11BE0`, `sub_11C8E`, `sub_136DA`).
- Viele Texte sind **Satzbausteine**, die der Code zusammensetzt (Puffer `$FFFFD5AE`, 40 Byte):
  - `sub_11BDC` hängt mit Leerzeichen an, `sub_11BE0` ohne, `sub_11B9A` setzt **vorne** davor.
  - `sub_11C8E` druckt direkt, `sub_11C4C` druckt den Puffer zentriert.
  - Die Ausgaberoutine `sub_11CA4` bricht wortweise am Fensterrand um (Fenster `$FFFFD5DA–E0`).
    Ein Text, der für das Fenster zu lang ist, springt bei einzeiligen Fenstern an den
    Zeilenanfang zurück und überschreibt sich selbst (gesehen 24.10.2026 bei der Ausbildung).
- Menüs aus Systemtexten (`sub_136DA`, Tabelle `dat_13866`): Frage + 1 Spalte + Punkte mit `~`;
  Puffer 42 Byte → höchstens 41 Zeichen.

## Umsetzung

| Hook | Ort (ROM) | Original | Deutsch | Rückfallwert |
|---|---|---|---|---|
| 5 | `$11BA0`, `$11BE4`, `$11C8E`, `$13714` (je 6 Byte) | `lea (dat_11DC4).l,aX` | `lea (DE_Systemtexte).l,aX` | Original im `else`-Zweig |
| 6 | `$7EE4` (66 Byte, `sub_7E6E`, Gegenstandszeile Inventar) | Namensteile 3-2-1 + Mehrzahl-„s“ | `jsr DE_Gegenstandsname` + NOPs | dito |
| 7 | `$16A52` (70 Byte, `sub_169C6`, Laden/Beute) | dito, Anzahl `& $7F` | dito | dito |
| 8 | `$18226` (Immediate-Byte `$18229`) | Mehrzahl Schiffswaffe `'s'` | `' '` (`DE_PLURAL_WAFFE`) | `$73` |
| 9 | `$18F26` (Immediate-Byte `$18F29`) | Mehrzahl „ hit point“ `'s'` | `'e'` → „Trefferpunkte“ (`DE_PLURAL_TP`) | `$73` |

Byte-Vergleich deutsch ↔ Original (erstes MB): nur Header, Hooks 1–9, Schrift, Selbstprüfung
geändert (geprüft 24.10.2026). Original-Bau weiterhin bit-genau (CRC32 44E3BFFF).

- `src\deutsch.asm`: `DE_Gegenstandsname` (ab `$100000`), `DE_Systemtexte` + `DE_Namenstabelle`
  ab `$101000` (Grenze `$108000`, Prüfung im Assembler).
- **Gegenstandsnamen:** Das Original setzt Namen aus bis zu 3 Teilen zusammen („martian“ +
  „laser“ + „pistol“). Deutsche Komposita („Mars-Laserpistole“) gehen so nicht. Lösung: Tabelle
  Namens-Tripel → fertiger deutscher Name (Einzahl/Mehrzahl) als neue Systemtexte ab S393.
  Nicht gefundene Tripel werden wie im Original aus den (übersetzten) Teilen zusammengesetzt.
  Spielstände bleiben gültig (das Tripel steht im Spielstand, der Name nicht).
  Grundlage: Gegenstandstabelle ROM `$F17D6` (91 Einträge, 10 Byte, Namensteile Byte 1–3).
- Mehrzahl deutsch: nur über `de_mehrzahl` (Granaten, Seile, Gegengifte).

## Textdatei und Prüfregeln

`05_German_Script\systemtexte.toml` (angelegt von `3_deutsch_vorlage.bat`, nie überschrieben):
- `[[text]]`: `id`, `en`, `de` (leer = Englisch), `leer = true` (absichtlich leer), `max`,
  `hinweis` (Satzbau/Fundort), `leerzeichen_geprueft = true` (Ausnahme, s. u.).
- `[[gegenstand]]`: `teile = [p1, p2, p3]`, `en`, `de`, `de_mehrzahl`, `hinweis`.

`text_einsetzen.py` prüft (Fehler mit ID, dann wird nichts geschrieben):
- nur darstellbare Zeichen; Steuerzeichen (`\n`, `~`) wie im Original
- **Leerzeichen am Anfang/Ende wie im Original** (Satzbausteine!) – Ausnahme nur mit
  `leerzeichen_geprueft` (S287 „ nachgeladen“, S306 „ wird benutzt.“: im Englischen hängen
  „s reloaded“ / „'s antidote.“ direkt am Wort)
- Menüs mit `~` höchstens 41 Zeichen; `max` je Text
- Gegenstandsnamen höchstens **25** Zeichen, Mehrzahl **21** (Gegenstandszeile: Fenster x2–34 =
  33 Zeichen, davor ggf. „bereit: “ und Anzahl „  3 “)
- Tabelle < 32 KB, Block vor `$108000`
- `--nur-englisch`: Systemtexte wie Original, keine Namenstabelle, Mehrzahl-„s“ wie Original
  (geprüft: alle 393 Texte identisch).

## Gemessene Grenzen (24.10.2026, Testemulator, Code)

| Stelle | Grenze | Quelle |
|---|---|---|
| Namenseingabe „abort“ (x+2) | 6 Zeichen | Code `sub_1413E`, Bild |
| Namenseingabe „done“ (x+9, Fenster bis x+12) | **4 Zeichen** („fertig“ brach um) | Bild |
| Ausbildung, Beschriftungszeile | ca. 34 Zeichen (einzeilig, sonst Selbstüberschreibung) | Bild, RAM |
| Fertigkeitsnamen S084–S097 | 24 (wie längstes Original) | `max` |
| Gegenstandszeile | 33 Zeichen (Fenster `sub_7FC0`: x2–34) | Code |
| Spieltempo | 11 Zeichen (Fenster `sub_4D62`: x6–16) | Code |
| Charakterbogen | Beschriftung x=21, Werte ab x=29/30 → 8–9 Zeichen | `dat_717A`, Bild |
| Erschaffung „Wähle Rasse,“ | x=25 bis Rand (15 Zeichen) | `dat_8994`, Bild |
| Planetendaten | Beschriftung x=13 | `dat_D688` |
| Schiffsstatus (Raumkampf) „hull“/„Engines“ | x=32, Fensterrand x=38 → **7 Zeichen** („Triebwerke“ brach um, Marcel 24.10.2026) | `sub_173CE`, `dat_17426` |
| Schiffsstatus „controls“/„weapons“ | x=1 | dito |
| Menüs aus Systemtexten | 41 Zeichen | `sub_136DA` |

## Satzbau (Telegrammstil, weil die Reihenfolge der Bausteine fest ist)

- „<Name> hat Erfolg: <Fertigkeit>“ / „<Name> scheitert: …“ / „Das Team scheitert: …“
- „<Name> erleidet 5 Schaden.“ (keine Einzahl/Mehrzahl-Frage)
- „Das Team hat keine Beute gefunden.“ (S150 „found“ leer, „gefunden“ steht in S152)
- Feindschiffe mit Artikel „die“ (Schiffe weiblich), Bausteine nur mit Nominativ/Akkusativ:
  „Maelstrom Rider überlistet die Viper“, „5 Schaden für die Viper: Rumpf“,
  „Rakete zerstört: die Viper“, „<Schiff> feuert: Rakete“ / „feuert Salve: Rakete“
- „<Name> flickt: Rumpf“ (Artikel the/a entfallen, S261/S262 leer)
- „Gegengift von <Name> wird benutzt.“
- Spielstand: „laden Spiel 1 : vorgefertigtes Team“

## Offen

- ~~Entscheidungen E1–E4~~ entschieden 24.10.2026: alles A.
- Nicht im Testemulator gesehen: Kampfmeldungen (laufen zu schnell), Laden, Raumkampf,
  Planetenscan, Spielstandmeldungen, Ausbildung „ist jetzt Stufe“ → Spieltest Marcel.
- Noch nicht in der Pipeline: Monsternamen (`dat_9E77C`), vorgefertigte Figuren, Abspann.
