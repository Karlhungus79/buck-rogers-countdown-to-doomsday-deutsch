# Glossar – Grundsätze und Stand

Stand: 23.10.2026 – **Glossar abgenommen (21.10.2026): Grundsätze G1–G9 und alle 186 Listeneinträge = A.**
Ausnahme: G1 und G2 neu entschieden am 23.10.2026 (Marcel: „G1 = B“): Großbuchstaben, ß → SS, siehe `Zeichensatz.md`.

Listen (Excel, Semikolon, UTF-8) in `05_German_Script\Glossar\`:

| Datei | Inhalt | Einträge |
|---|---|---|
| `Glossar_1_Eigennamen_Figuren.csv` | Figuren, KIs, Titel | 28 |
| `Glossar_2_Fraktionen_Orte.csv` | NEO, RAM, Völker, Planeten, Orte | 32 |
| `Glossar_3_UI_Begriffe.csv` | Menüs, Zustände, Raumkampf, Planetendaten | 42 |
| `Glossar_4_Klassen_Rassen_Attribute.csv` | Klassen, Rassen, Werte, Fertigkeiten | 31 |
| `Glossar_5_Ausruestung_Gegner.csv` | Waffen, Ausrüstung, Schiffe, Monster | 53 |

Erzeugt mit `03_Tools\glossar_vorschlag.py` (Zeichenzahlen und Fundorte automatisch).
Nummern: `1-07` = Liste 1, Eintrag 7. Antwortform: „alles A, 2-31 = B, G3 = B“.
Eine Entscheidung gilt erst, wenn sie hier und in der Spalte „Entscheidung“ steht.

## Grundsatzentscheidungen (vor den Einzelbegriffen)

| Nr | Frage | A (Empfehlung) | B | C |
|---|---|---|---|---|
| G1 | Schreibung der Dialoge | **Groß-/Kleinschreibung** wie normales Deutsch (~~Kleinbuchstaben sind im Font vorhanden~~ – falsch, Korrektur 23.10.2026 in `Zeichensatz.md`) – besser lesbar, Substantive erkennbar | ALLES GROSS wie im Original | – |
| G2 | ß | ß als eigene Kachel (bei G1 = A) | „SS“ (bei G1 = B üblich) | – |
| G3 | Anrede der Gruppe durch NEO, Verbündete | **„ihr“** (Kameraden im Widerstand) | „Sie“ | – |
| G4 | Anrede durch Fremde, Behörden, RAM, Händler | **„Sie“** | „ihr“ | – |
| G5 | Wort für die Gruppe („team“) | **Team** (gleich kurz, im Spiel 47× im Dialog + Menüs) | Trupp | Gruppe |
| G6 | Eigennamen, Schiffe, Fraktionen, KIs (.DOS) | **unverändert** (Sci-Fi-Lizenz, international üblich) | eindeutschen | – |
| G7 | Regelwerte (AD&D-Basis) | **deutsche AD&D-2E-Kürzel**: ST GE KO CH TE, TP, RK, ETW0, Stufe, EP | englische Kürzel lassen | – |
| G8 | Maßeinheiten (Planetendaten in Meilen) | **in km umrechnen** | Meilen lassen | – |
| G9 | Sprachfärbungen | **beibehalten**: Leander/Terrine zischen („SSTAY“, „HHELP“) → deutsch ebenso („bleibt hhier“, „sso“); der Sonnenkönig spricht Französisch → bleibt Französisch | glätten | – |

Hinweise:
- G1 hat Folgen für den Zeichensatz: Für A brauchen wir ä ö ü ß Ä Ö Ü (7 Kacheln),
  für B nur Ä Ö Ü (3), Systemtexte brauchen in beiden Fällen ä ö ü (sie sind klein geschrieben).
  Ob die Dialogfenster Kleinbuchstaben sauber darstellen: technisch wahrscheinlich
  (gleiche Ausgaberoutine), **im Spieltest prüfen**.
- G3/G4: Der Erzähltext („YOU SEE …“) spricht das Team an → deutsch „Ihr seht …“
  (folgt aus G3 = A). Bei G3 = B würde der Erzähltext trotzdem „ihr“ bleiben müssen,
  sonst klingt er nach Behördenbrief.

## Technische Grenzen, die das Glossar betreffen

- Monsternamen: höchstens **15 Zeichen** (Feld 16 Byte inkl. Ende). Alle A-Vorschläge passen
  (Skript prüft das). „ROBOTER“ passt nicht überall → „ROBOT“ bleibt.
- Menüs (HMENU): alle Punkte zusammen höchstens 39 Zeichen.
- Systemtexte: Fensterbreiten sind noch nicht gemessen → Spalte „max. Zeichen“ meist leer.
  Kritisch zu prüfen: Ja/Nein, Fertigkeitsnamen, Raumkampf-Menü, Planetendaten.
- Gegenstandsnamen werden aus Wortteilen zusammengesetzt (S001–S044: „mono“ + „sword“).
  Deutsche Komposita („Monoschwert“) gehen evtl. nicht 1:1 → Mechanik in Phase 2 prüfen.
  Bis dahin gelten die Glossarformen als Ziel.

## Offene Fragen zum Spielinhalt

- ECG: Bedeutung noch unklar (Monster „E.C. GENNIE“, „STAGE 3 ECG“) → bleibt Kürzel.
- Deutsche Namensformen aus der TV-Serie (1979) oder deutschen Rollenspielausgaben:
  nicht geprüft; betrifft nur Wilma und Huer, beide bleiben ohnehin unverändert.

## Entscheidungen

### Grundsätze – entschieden 21.10.2026 (Marcel: „G alles A“)

| Nr | Entscheidung | Status |
|---|---|---|
| G1 | **B (neu entschieden 23.10.2026, Marcel „G1 = B“):** Anzeige in GROSSBUCHSTABEN wie im Original. Texte werden trotzdem in normaler Groß-/Kleinschreibung geschrieben (Spiel zeigt sie groß). Vorherige Entscheidung A (21.10.) beruhte auf einer falschen Annahme (Schrift hat keine Kleinbuchstaben) | entschieden |
| G2 | **ß → „SS“** (folgt aus G1 = B, 23.10.2026); in den Textdateien bleibt ß stehen, das Einsetz-Skript wandelt um | entschieden |
| G3 | NEO, Verbündete und Erzähltext sprechen das Team mit „ihr“ an („Ihr seht …“) | entschieden |
| G4 | Fremde, Behörden, Händler, RAM: „Sie“ | entschieden |
| G5 | Gruppe heißt „Team“ | entschieden |
| G6 | Eigennamen, Schiffe, Fraktionen, KIs (.DOS) unverändert | entschieden |
| G7 | Deutsche AD&D-2E-Kürzel: ST GE KO CH TE, TP, RK, ETW0, Stufe, EP | entschieden |
| G8 | Planetendaten in km umrechnen | entschieden |
| G9 | Sprachfärbungen bleiben (Terrine zischen, Sonnenkönig spricht Französisch) | entschieden |

Folgen:
- Zeichensatz braucht Ä Ö Ü (3 neue Kacheln, gebaut 23.10.2026); ä ö ü werden groß angezeigt, ß als SS (G1/G2 = B seit 23.10.2026).
- Alle 2407 Dialogtexte werden in normaler Groß-/Kleinschreibung geschrieben (spätere Umstellung
  auf Kleinbuchstaben ohne Textänderung möglich); angezeigt wird groß. Die englische Vorlage bleibt
  in Großbuchstaben (nur Referenz).
- 49 Listeneinträge folgen direkt aus G5–G8 und sind in der Spalte „Entscheidung“
  eingetragen: Eigennamen ohne Alternative (Liste 1 und 2, Schiffsnamen 5-32) = „A (G6)“,
  3-01 Team = „A (G5)“, 4-09 bis 4-16 Kürzel = „A (G7)“, 3-41 km = „A (G8)“.
- `2b_glossar_vorschlag.bat` verweigert ab der Abnahme das Überschreiben (Schutz eingebaut).

### Begriffslisten – entschieden 21.10.2026 (Marcel: „Listen alles A“)

Alle 186 Einträge gelten in der Form A. In den CSV-Dateien steht in der Spalte
„Entscheidung“ entweder „A (G5/G6/G7/G8)“ (folgt aus dem Grundsatz) oder „A“.

Vorbehalte (Breite/Technik, im Spieltest prüfen, ggf. Glossar mit Datum ändern):
- UI-Begriffe (Liste 3) und Fertigkeiten (Liste 4): Fensterbreiten noch nicht gemessen.
- 3-16 „ja~nein“: Breite im Spiel messen.
- Liste 5, Gegenstände: zusammengesetzte Itemnamen (Phase 2).
- 2-27 „Udus Café“: é nur, wenn die Kachel kommt, sonst „Udus Cafe“.

**Tor Phase 0 erreicht: Glossar abgenommen am 21.10.2026.**

### Phase 2 – entschieden 24.10.2026 (Marcel: „E alles A“, Vorlage `Phase2_Entscheidungen.md`)

- **E1 Platz:** 3-09 done → **OK**, 3-15 abort → **Zurück**, 3-24 → **Aus dem Kampf fliehen?**,
  4-17 → **Raketenflug/Notreparatur**, neu 4-32 career skill → **Klasse: …**,
  neu 5-54/5-55 Herkunftsrüstungen → **Mars-Schwerpanzerung**, **Mars-Kampfpanz. m. Feld**.
- **E2 Original-Kuriositäten:** **Mikrowellenpistole** (Annahme), **Sanitätsgranate**,
  **Mars-Hitzepistole**, **Merkur-Monoschwert** (5-56 bis 5-58).
- **E3:** Feindschiffe mit Artikel **„die“** (5-59).
- **E4:** Copyright-Zeilen bleiben **englisch**.
Alle im Spieltest prüfen (`Testliste_Phase2.md`). Entspricht dem Bau CRC32 598A9641, kein Neubau.
