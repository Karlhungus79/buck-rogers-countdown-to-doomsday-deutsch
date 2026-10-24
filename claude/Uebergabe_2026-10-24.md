# Übergabe 24.10.2026, 21:20

Auftrag Marcel (24.10.2026): eigenständig weiterarbeiten, selbst entscheiden (schriftlich, „im Spieltest prüfen“),
Ziel Projekt fertigstellen. Marcel testet in Ares v147 und meldet per Screenshot.

## Was gilt

- Tore erreicht: Phase 0, 1, 2 (24.10.2026). Phase 3 Grafik gebaut, Phase 5 Dialog erstübersetzt und gebaut,
  Phase 6 Patch-Werkzeug fertig. **Nichts davon in Ares bestätigt.**
- Aktueller Bau: deutsch **59F0785A**, Testfassung **9CF3FBF3** (H: `07_Output_ROM\2026-10-24_20-44-45_*`,
  feste Namen `(gebaut).md` / `(test).md`). Original-Bau bit-genau (44E3BFFF).
- Patch: `07_Output_ROM\2026-10-24_20-48-03_patch\` (BPS + IPS + LIESMICH/README), selbst geprüft.
- Dialog: 2130 von 2407 Texten deutsch; Rest Absicht (M000/M001 Entwicklermodule, Namen, Passwörter).
  Regeln und Sprachentscheidungen: `Dialog.md`. Grafik: `Grafik.md` (Hooks 14–19, ab `$1C0000`).
- Test-Spielstand „starkes Team“: Spielstand 4, 120 TP je Figur, ohne Spielort (Jumper-Frage kommt).
  Gute Datei CRC32 **4FC48986** (im Chat angehängt, nicht im Repo; neu erzeugen: `03_Tools\claude_werkzeuge\starkes_team.py`).

## Wie es entsteht (Claude-Container)

1. Repo klonen (add_repo Karlhungus79/buck-rogers-countdown-to-doomsday-deutsch, push), ROM + `.ram` von H: stagen.
2. `python3 03_Tools/extract.py`, `python3 03_Tools/text_extrahieren.py`.
3. AS-Assembler (flamewing, Commit 592c5fa) nach `/home/claude/tools/asl/build` bauen, PATH setzen.
4. Testkern: `sh 03_Tools/emu_test/kern_bauen.sh`. Werkzeuge: `03_Tools/claude_werkzeuge/LIESMICH.md`.
5. Bau: `text_einsetzen.py` → `grafik_deutsch.py` → `build.py --deutsch` / `--test`; `build.py --pruefen`.
6. Nach jedem Schritt: commit + push, geänderte Dateien per device_commit_files nach H:.

## Fallen

- Dialogfenster scrollt nicht, es überschreibt reihum → mehr als max(4, Original) Zeilen = Fehler (Prüfung aktiv).
- SAVE-Texte werden per strcpy in 20/40/50-Byte-Variablen kopiert → nie länger als Original/Variable.
- Textblock darf nur bis `$1C0000` (danach Grafiken).
- Schrift hat keine Akzente (é, è) → Französisch ohne Akzente.
- Jumper-Zahleneingabe: **LINKS** = nächsthöhere Stelle (nicht RECHTS). EXP höchstens 65535 (Überlauf).
- Jumper-EXP: danach in den Figurendaten kein EP-Wert gefunden; Hauptmenü hat mit Team **kein**
  „Figur ausbilden“ – 2. Symbol ist **Figur entlassen**. Nicht als Weg zum Aufleveln empfehlen.
- Im Spiel speichern (START → Kiste) speichert den Spielort → keine Jumper-Frage mehr. Teststände daher im
  Hauptmenü speichern.
- Savestates des Testkerns enthalten keine SRAM: Speichern im Spiel und SRAM-Auslesen im selben Lauf.
- Ares schreibt die `.ram` beim Beenden zurück → Dateien nur bei geschlossenem Ares ersetzen.
- Wecker (send_later) feuert, wird aber erst zugestellt, wenn die Sitzung wieder aktiv ist → vorher Übergabe ablegen.
- Bricht die PC-Verbindung (remote-devices) ab, kann die Sitzung sie nicht neu aufbauen → neue Aufgabe starten.

## Noch offen (nächste Schritte)

1. **Spielstand 4 „klappt nicht“ (Marcel 21:13)** – Ursache klären: Ares Einstellungen → Pfade → Saves,
   Änderungsdatum der `(test).ram`, steht bei „Spiel laden“ Spielstand 4 „Neuestes“ oder „Leeres Team“?
   Ggf. Datei mit CRC32 4FC48986 neu ablegen (Ares geschlossen). Falls weiter zu schwach: Schadensmodus
   nur für die Testfassung bauen (Schadensroutine suchen, TP-Feld = Byte 46 des Figurendatensatzes).
2. Marcel: CRC32 der .bat-Bauten bestätigen (59F0785A / 9CF3FBF3), Spieltests `Testliste_Phase3.md`,
   `Testliste_Phase5.md`, Raumkampf-Anzeige G7.
3. Korrekturen einarbeiten, Anrede-Regeln von Marcel abnehmen lassen (`Dialog.md`).
4. Patch-Gegenprobe mit Floating IPS, dann Phase 4 (Testpaket) und Release.
