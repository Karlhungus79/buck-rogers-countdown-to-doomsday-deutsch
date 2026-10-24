# Dialog – Phase 5

Stand: 24.10.2026, ca. 20:50 (Claude, selbständig – Marcel nicht erreichbar). **Alle Entscheidungen hier: im Spieltest prüfen.**

## Stand

- Erstübersetzung **aller Spielmodule fertig**: M003, M016, M017, M032–M035, M048–M050, M052, M064–M067,
  M080–M083, M094–M099. 2130 von 2407 Texten deutsch.
- Englisch bleiben (Absicht): M000 und M001 (Entwickler-Jumper/Testarena, nur in der Testfassung sichtbar),
  Eigennamen in COMPARE/Menüs (BUCK ROGERS, TUSKON, LEANDER, ZANE, VILNIKOV, WILLIAMS, CONCHITEZ),
  Passwörter (ALPHA, RAGON, ELIPH, BRG, DNA), Ortsnamen der Asteroiden, Lokalnamen (Chez Luna, Hexaburger,
  Queen of Hearts, Carnival), leere Texte und reine Satzzeichen.
- Gebaut 24.10.2026: deutsch **59F0785A**, Test **9CF3FBF3**. Original-Bau bit-genau. Im Testemulator
  gesehen: Intro M016_000–002 (`Vorschau\Phase5_Intro_Testemulator_2026-10-24.png`). **Ares offen.**
- Werkzeuge (Claude-Container, nicht im Repo): Ausgabe der offenen Texte je Modul, Setzen aus `nnn|Text`-Listen,
  Zeilenprüfung wie `text_einsetzen.py`.

## Technische Regeln (neu, 24.10.2026)

- **Fenstergrenze gemessen:** Das Dialogfenster scrollt nicht, es überschreibt reihum (Testemulator, Text mit
  10 Zeilen zeigte Zeilen 9, 10, 7, 8). `text_einsetzen.py` meldet jetzt **Fehler**, wenn ein Text mehr als
  max(4, Original) Zeilen hat (vorher nur Hinweis). Alle deutschen Texte halten das ein.
- Texte, die an einen Namen oder Wert anschließen (beginnen mit Leerzeichen oder Satzteil), bleiben Satzteile in
  derselben Reihenfolge; die deutschen Teile sind so formuliert, dass der zusammengesetzte Satz stimmt
  (z. B. „Repariert: “ + „Rumpf“ + „.“, „Ihr seid “ + „im Raumhafen Tycho“ + „.“).
- **SAVE-Texte** (werden per strcpy in String-Variablen kopiert): nie länger als das Original bzw. als die
  Variable (Abstände $A086/$A09A/$A0AE/$A0C2 = 20 Byte, $A022/$A054 = 50 Byte, $9FFA = 40 Byte).
  Deshalb z. B. M032 „einem Freund“ / „einer Freundin“, M096 „Kontrolltor“.
- Textblock darf nur bis `$1C0000` reichen (ab dort Grafiken, Phase 3) – Prüfung in `text_einsetzen.py`.
- Zeichen: keine Akzente (é, è) – Schrift kennt sie nicht; Französisch daher ohne Akzente.

## Sprachentscheidungen (Claude, im Spieltest prüfen)

- Anrede „ihr“: NEO, Buck, Wilma, Scot.DOS, Erzähltext, Wüstenläufer, Tiefländer, Kinder (Jim, Milo),
  Piraten (Talon, Wachen), Sonnenkönig (herablassend-königlich).
- Anrede „Sie“: RAM-Beamte, -Soldaten und -Kommandanten (auch Gilbert), Sicherheitsleute, Lautsprecher/Ansagen,
  Diener und Wachen des Sonnenkönigs, alter Schachspieler, Techniker, Tiefländer-Leute in Mariposa-Ansagen.
- Sprachfärbungen (G9): Tiefländer zischen (doppeltes s, „hh“), Sonnenkönig spricht Französisch.
- Menüs kurz (Grenze 39 Zeichen gesamt): Gehen, Angreifen, Fliehen, Bluffen, Hoch/Runter/Bleiben.
- Commander Gilbert = „Kommandantin“ (weiblich im Original).
- „One if by land“ (Paul-Revere-Zitat, Losung der Tänzer) → „Einmal, wenn zu Land“.
- Dante-Inschrift → „Lasst, die ihr eintretet, alle Hoffnung fahren.“
- Lokalnamen ohne Apostroph: Gabes Saloon, Bretskis, Daves Diner, Udus Cafe usw.

## Offen

- Spieltest in Ares nach `Testliste_Phase5.md` (Umbrüche, zusammengesetzte Sätze, Anrede).
- Optional: Dialog-Editor (Projektanweisung 9) – vorerst nicht gebaut, da Marcel nicht erreichbar war.
