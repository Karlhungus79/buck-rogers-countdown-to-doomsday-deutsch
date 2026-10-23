# Zeichensatz – Schrift, Umlaute, Kodierung

Stand: 23.10.2026

## Befund (23.10.2026, aus Code und VRAM im Emulator)

- Die Spielschrift hat **nur 64 Zeichen** (`$20–$5F`): Leerzeichen, Satzzeichen, Ziffern,
  `A–Z`, `[ £ ] ↑ ←`. **Keine Kleinbuchstaben.**
- Ablage: ROM `$051102` (`dat_51102`), 512 Byte, 1 Bit pro Pixel, 8×8, Zeichen in Zeilen 1–6
  und Spalten 1–6. `sub_A71E` wandelt sie bei jedem Bildschirmaufbau nach VRAM-Kachel 6–69 um.
- Ausgabe: `sub_11CA4` (alle Fenster). Kachel = Zeichen − `$20` + 6; Zeichen ab `$60` werden
  vorher um `$20` verschoben → **Kleinbuchstaben erscheinen als Großbuchstaben**.
  Die Systemtexte stehen klein in der ROM, erscheinen aber groß („RESTORE GAME“).
- **Korrektur:** Im Glossar (Grundsatz G1, 21.10.2026) stand „Kleinbuchstaben sind im Font
  vorhanden, Systemtexte nutzen sie schon“. Das war falsch – ich hatte aus den Kleinbuchstaben
  in den Systemtexten auf die Schrift geschlossen, ohne die Ausgaberoutine zu prüfen.
  G1 muss deshalb neu entschieden werden (siehe unten).

## Kodierung der deutschen Texte (gilt ab 23.10.2026, `03_Tools\zeichensatz.py`)

| Zeichen | Byte | Anzeige heute |
|---|---|---|
| A–Z, 0–9, Satzzeichen | ASCII | wie Original |
| a–z | ASCII `$61–$7A` | als Großbuchstabe |
| Ä Ö Ü | `$5B $5C $5D` (Plätze von `[ £ ]`, nirgends benutzt) | neue Glyphen, Punkte in Zeile 0 |
| ä ö ü | `$7B $7C $7D` | Spiel faltet auf `$5B–$5D` → Ä Ö Ü |
| ß | „SS“ (G2 = B); `$7F` nur falls später Kleinbuchstaben kommen | SS |
| Zeilenumbruch, Menütrenner | `$0D`, `~` | wie Original |
| „ “ ’ … – | werden zu ' ' ... - | |

Wichtig: Übersetzt wird **immer in normaler Groß-/Kleinschreibung**. Ob das Spiel klein oder
groß anzeigt, entscheidet nur die Schrift. Die Entscheidung G1 kostet also keine Nacharbeit
an den Texten.

Ä Ö Ü: im Spiel bestätigt (Emulator, 23.10.2026, Intro „BEKÄMPFEN“, „VERWÜSTET“, „KÖNNEN“).
Test in Ares offen.

## Entscheidung G1 neu: Kleinbuchstaben ja oder nein?

**Entschieden 23.10.2026 (Marcel: „G1 = B“): B – Großbuchstaben wie im Original, ß → „SS“.**
Anzeige groß, Texte werden normal geschrieben; A bleibt als mögliches Extra (Phase 3+).
`zeichensatz.py`: `KLEINBUCHSTABEN = False` (so gebaut seit 23.10.2026, kein Neubau nötig).

Vorlage vom 23.10.2026:

Vorschaubilder (Entwurf, echte Fenstergrafik, Schrift aus der ROM):
`claude\Vorschau\G1_A_Kleinbuchstaben.png`, `claude\Vorschau\G1_B_Grossbuchstaben.png`

| | A: Kleinbuchstaben nachrüsten | B: Großbuchstaben wie im Original (Empfehlung) |
|---|---|---|
| Aussehen | normales Deutsch, Substantive erkennbar | wie das Original und alle Menüs |
| ß | eigenes Zeichen | „SS“ (übliche Form in Großschrift) |
| Neue Kacheln | 30 (a–z, ä ö ü ß), selbst gezeichnet (Entwurf liegt vor) | 0 (Ä Ö Ü sind schon drin) |
| Code | `sub_A71E` lädt 30 Kacheln mehr, `sub_11CA4` neue Zuordnung ab `$60` | keine Änderung |
| Grafikspeicher | Freier Bereich nötig, der in **jeder** Szene frei ist. Gefunden: `$727–$75F` grob frei in Menü, Dialog, Charakter- und Kampfbildschirm, aber im Kampf einzelne Kacheln belegt (`$730`, `$743–$745`, `$753–$755`) → zusammenhängend nur 18 + 13. Raumkampf, Läden, Karte, Zwischenbilder noch nicht geprüft. | entfällt |
| Risiko | mittel bis hoch: überschriebene Grafik in einzelnen Szenen fällt erst im Spieltest auf | keins |
| Aufwand | mehrere Sitzungen (Speicheranalyse, Code, Feinschliff der Schrift, Tests aller Szenen) | erledigt |
| Später umstellbar? | – | ja, ohne Textänderung (nur Schrift + Code nachrüsten, z. B. als Extra in Phase 3+) |

Empfehlung B: Das Gerüst bleibt klein und sicher, die Übersetzung wird trotzdem normal
geschrieben, und A bleibt als späteres Extra möglich.

## Freie Plätze in der Schrift

`↑` (`$5E`) und `←` (`$5F`): in keinem Text benutzt; ob der Code sie als Grafik nutzt
(Pfeile), ist ungeprüft → vorerst nicht belegen. Kandidat für `é` (Udus Café) oder ß.
