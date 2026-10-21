# Glossar – Grundsätze und Stand

Stand: 21.10.2026 – **Grundsätze G1–G9 entschieden (alle A). Begriffslisten: Vorschlag, offen.**

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
| G1 | Schreibung der Dialoge | **Groß-/Kleinschreibung** wie normales Deutsch (Kleinbuchstaben sind im Font vorhanden, Systemtexte nutzen sie schon) – besser lesbar, Substantive erkennbar | ALLES GROSS wie im Original | – |
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
| G1 | Dialoge in normaler Groß-/Kleinschreibung | entschieden; Darstellung von Kleinbuchstaben im Dialogfenster **im Spieltest prüfen** |
| G2 | ß als eigenes Zeichen (neue Kachel) | entschieden |
| G3 | NEO, Verbündete und Erzähltext sprechen das Team mit „ihr“ an („Ihr seht …“) | entschieden |
| G4 | Fremde, Behörden, Händler, RAM: „Sie“ | entschieden |
| G5 | Gruppe heißt „Team“ | entschieden |
| G6 | Eigennamen, Schiffe, Fraktionen, KIs (.DOS) unverändert | entschieden |
| G7 | Deutsche AD&D-2E-Kürzel: ST GE KO CH TE, TP, RK, ETW0, Stufe, EP | entschieden |
| G8 | Planetendaten in km umrechnen | entschieden |
| G9 | Sprachfärbungen bleiben (Terrine zischen, Sonnenkönig spricht Französisch) | entschieden |

Folgen:
- Zeichensatz braucht ä ö ü ß Ä Ö Ü (7 neue Kacheln) → Phase 1, `Zeichensatz.md`.
- G1 heißt: Alle 2407 Dialogtexte werden in Groß-/Kleinschreibung gesetzt; die englische
  Vorlage bleibt in Großbuchstaben (nur Referenz).
- 49 Listeneinträge folgen direkt aus G5–G8 und sind in der Spalte „Entscheidung“
  eingetragen: Eigennamen ohne Alternative (Liste 1 und 2, Schiffsnamen 5-32) = „A (G6)“,
  3-01 Team = „A (G5)“, 4-09 bis 4-16 Kürzel = „A (G7)“, 3-41 km = „A (G8)“.
- Achtung: `2b_glossar_vorschlag.bat` überschreibt die Listen samt Entscheidungen –
  nach der Abnahme nicht mehr benutzen.

### Begriffslisten

(offen – wartet auf Marcels Antwort)
