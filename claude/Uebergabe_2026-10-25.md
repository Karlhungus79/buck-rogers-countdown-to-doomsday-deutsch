# Übergabe 25.10.2026, 14:10 – offene Analyse: Plasmawerfer und Merkur-Kreuzer

Stand: 25.10.2026 (Claude, Sonnet). Für die nächste Sitzung (**Opus**: ROM-/Code-Analyse).
Einstieg: Kontext.md, projektstatus.md, MEMORY.md, diese Übergabe. Ansonsten gilt `Uebergabe_2026-10-24.md`
und die WECHSEL-Datei im Ordner `Wechsel\`.

## Umgebung heute geprüft (Container)

- GitHub verknüpft, Repo `Karlhungus79/buck-rogers-countdown-to-doomsday-deutsch` angehängt, Push funktioniert.
  Abendstand 24.10. gepusht (Commit 40f9bcb), Remote = H: (geprüft).
- AS-Assembler (Commit 592c5fa) im Container gebaut: `/home/claude/tools/asl/build` (PATH setzen).
- Container-Bauten stimmen mit Marcels Bauten überein: deutsch **989ABA78**, Testfassung **A11EB65A**,
  Original bit-genau **44E3BFFF**. Testkern gebaut (`03_Tools/emu_test/kern_bauen.sh`, Tastennamen GROSS: `START`, `A`, `B`, `C`).
- `device_bash` (Shell auf Marcels PC) steht in dieser Sitzung nicht zur Verfügung → Dateien per Staging
  holen, nach H: per `device_commit_files` (Quelle unter `/mnt/user-data/outputs/`).

## Frage 1: Merkur-Kreuzer kommt im Endspiel nie (Marcel, 24.10., stundenlang gesucht)

Befund (nur aus dem Code, **nicht im Spiel getestet**):
- Zufallsbegegnung im All: M034, Einstieg `$71C7`. Typ: `RANDOM 7` → `$97FB`; Wert > 4 → minus 5.
  Typen: 0 RAM-Scout, 1 RAM Medium, 2 RAM Heavy, 3 Piraten Medium, 4 **Merkur Medium** (0–2 doppelt gewichtet).
  Ohne Merker (`$9876`, `$9855`, `$98B0` = 1) wird der Typ danach auf `RANDOM 1` (nur 0/1) überschrieben.
- Es gibt **keinen schweren Merkur-Kreuzer**, nur „MERCURIAN MEDIUM“ (Text M034_104, im Original gleich).
  Die deutsche Fassung übersetzt das richtig („Ein mittlerer merkurianischer Kreuzer“).
- Erwartung: ca. 1 von 8 Begegnungen. Marcels Beobachtung (viele RAM Heavy und Piraten, nie Merkur) passt dazu **nicht gut**.
- Offen: (a) Ob `RANDOM n` 0..n liefert und wie der Zufallsgenerator verteilt. (b) Was `SPACECOMBAT` mit Typ 4
  macht (Schiffstabelle, evtl. Fehler/Absturz). (c) Spielstand/Merker in Marcels Test (waren die Merker wirklich gesetzt?).
- Vorschlag: Testkern, viele Begegnungen automatisch, Typ-Verteilung zählen (`$97FB` im RAM mitlesen).

## Frage 2: Plasmawerfer (Gegenstand 17 = `$11`, Preis 1600, deutsch „Plasmawerfer“)

Marcel: Im Spiel bekommt man ihn **sicher** beim Entern merkurianischer Schiffe von den Gegnern (aus eigener Erfahrung).
Er hat ihn nur über **Jump Treasure** (Entwickler-Jumper, M000) bekommen; Screenshot: Flavius, „BEREIT: PLASMAWERFER“.
Befund (Code, nicht im Spiel getestet):
- Gegenstandstabelle ROM `$F17CC` + ID × 10 (ID 1 bei `$F17D6`). Plasmawerfer: `11 00 00 12 00 00 06 40 00 0a`.
- Läden: 16 Inventare ab `$3D76` (Format: Wortoffsets, je Laden Anzahl, Gegenstands-IDs, dann 1 Byte Zusatz). **ID 0x11 in keinem Laden.**
- `TREASURE`/`FINDITEM` in allen Spielmodulen: **ID 0x11 nur in M000** (Jumper-Testbeute). M035 vergibt über `$9E72` die ID `$18`.
- Entern: **M052** (Besatzung nach Schiffstyp `$9924`, Tabellen `$764A/$7664/$7673/$7682/$7691`),
  Beute dort nur Credits (`TREASURE 1000+200·RANDOM(20)`) und zweimal `TREASURE 0,0` – **kein Gegenstand**.
- Monsterdatensätze (54, `$D6` Byte, `dat_9E77C`): kein 10-Byte-Gegenstandskopie-Block mit dem Plasmawerfer.
  Das Byte 29 (nach Name) sieht wie eine Waffen-/Gegenstandsnummer aus (z. B. MER. LEADER `$2E`, MER. WARRIOR `$35`/`$2E`),
  liefert aber nicht durchgehend passende Namen → **Bedeutung ungeklärt**. Merkur-Besatzungen: Nr. 7 MER. LEADER,
  8 MER. TECHNICIAN, 9 MER. H.S. ROBOT, 38 und 45 MER. WARRIOR.
- Vermutung: Die Engine bestimmt Beute selbst (Meldung „ERBEUTET: …“, `sub_169C6`/Beute-Routine, Hook 7 in
  `Systemtexte.md`) aus den Gegnerdaten; das ist **nicht analysiert**.

## Aufgaben für Opus (Reihenfolge)

1. Beute-Routine der Engine nach `COMBAT` finden (Aufrufer von `sub_169C6`, Zugriffe auf `dat_F17CC`, Monsterfeld Byte 29).
   Klären: Wann wird welcher Gegenstand fallen gelassen, gilt das für Merkur-Besatzungen (Nr. 7/8/38/45)?
2. M052: Wie wird `$9924` (Schiffstyp) gesetzt (von M034/`SPACECOMBAT`-Ergebnis?), welche Besatzung für Typ 4?
3. Merkur-Kreuzer: Zufallsverteilung im Testkern messen (siehe oben).
4. Spieltest vorbereiten (nur Testfassung): Sprung ECL 52 (Disk 3) mit gesetztem Typ (Jumper-Party-Variable, Offset =
   `$9924 − $96F6` = 558, Wert 4; **nicht getestet**), Besatzung besiegen, Inventar prüfen. Optional Hook, der den Typ erzwingt.
5. Ergebnis in `Testfassung.md`/`Dialog.md` dokumentieren; Marcel testet in Ares.

## Dateien / Stand

- Repo und H: sind auf Stand 40f9bcb plus diese Übergabe. Keine Bauänderung: **Neu bauen: NEIN**
  (deutsch 989ABA78, Testfassung A11EB65A bleiben).
- Offene Punkte aus der Übergabe vom 24.10. (Spieltests ECL 99, Planetenscan, Spielstand 4, Patch neu erzeugen) unverändert.
