# Testfassung mit Entwickler-Jumper

Stand: 24.10.2026 (Bau CRC32 37DE7A79) – **gebaut, im Testemulator geprüft (Sprünge in alle 23 Spielmodule, Arena,
Abspann-Test); Test in Ares offen.** Nur zum Testen, **nicht veröffentlichen**.

## Was es ist

Im Spiel steckt ein Testmenü der Entwickler („JUMPER“, ECL-Modul 0). Das Original zeigt es nur,
wenn keine Batterie-SRAM gefunden wird. Die Testfassung schaltet es frei: Beim Abenteuerstart mit
einem Team, das noch keinen Spielort hat (z. B. Spielstand 1 „vorgefertigtes Team“), kommt die
Frage „Start from scratch or use the jumper?“. Damit springt man in jedes Spielmodul.

- Bau: `03_Tools\7b_testfassung_bauen.bat` → `07_Output_ROM\<Zeit>_test\…(test).md` und Testdatei
  `07_Output_ROM\Buck Rogers - Countdown to Doomsday (test).md`.
- Technik: DEUTSCH-HOOK 10 in `buckrogers.asm` (`loc_4154`, `bne.s loc_4160` → `nop`, nur mit
  `-D DEUTSCH_TEST=1`). Sonst identisch mit der deutschen Fassung. Rückfallwert: `bne.s`.
- Spielstand für Ares: `08_Savestates\Buck Rogers - Countdown to Doomsday (test).ram`
  (Kopie von Marcels `(gebaut).ram`, 24.10.2026). Getrennt vom normalen Spielstand.
- Die Jumper-Texte sind Entwicklertexte (englisch) und werden nicht übersetzt.

## Starkes Team zum Testen (Spielstand 4)

Seit 24.10.2026 (Claude): In `08_Savestates\Buck Rogers - Countdown to Doomsday (test).ram` liegt in **Spielstand 4**
das vorgefertigte Team mit **120 Trefferpunkten je Figur** (Feld Byte 46 im Figurendatensatz, sonst unverändert;
der Bogen zeigt weiter die normalen TP, der Balken ist entsprechend länger). Kein Spielort gespeichert, daher
kommt beim Abenteuerstart die Jumper-Frage. Spielstände 1–3 sind unverändert. Alte Datei:
`08_Savestates\bak_vor_starkes_team_2026-10-24\`. Achtung: Heilen (Autodoc, Ruhe) setzt die TP vermutlich auf
den Normalwert zurück – dann Spielstand 4 neu laden. Im Testemulator geprüft: lädt, Jumper-Frage erscheint.
Kampf mit 120 TP noch nicht im Spiel gesehen. **Marcel 24.10.2026 21:13: „klappt nicht“** – Ursache offen
(Verdacht: Ares-Saves-Pfad zeigt woanders hin, oder Ares hat die Datei beim Beenden überschrieben). Gute Datei:
CRC32 4FC48986 (im Chat angehängt; neu erzeugen mit `03_Tools\claude_werkzeuge\starkes_team.py`).

## Bedienung

1. Testdatei in Ares starten, **Spiel laden → Spielstand 4 (starkes Team)** oder 1 (normales vorgefertigtes Team), **Abenteuer starten**.
2. „JUMPER“ wählen (C), Text mit C weiter → Menü „WHERE DO YOU WISH TO GO?“.
3. **JUMP** → „What ECL …“: Zahl eingeben. OBEN/UNTEN ändert die Stelle, **LINKS** wechselt zur
   nächsthöheren Stelle (RECHTS springt reihum), C bestätigt.
4. „Set CURDISK to?“: Disk aus der Tabelle eingeben, C.
5. „IS THIS OK?“ → JA. „Set X,Y positions?“ → **NO**. „Set party variables?“ → **NO**.
6. Man steht am Anfang des Moduls. Jetzt **Ares-Speicherstand** anlegen (Schnellspeichern) –
   das sind die Sprungpunkte. Alternativ im Spiel speichern (3 Plätze).

Hinweis: Der Sprung überspringt die Handlung davor. Für Texttests reicht das; Ereignisse, die
auf frühere Handlung prüfen, können anders ablaufen als im normalen Spiel. Das vorgefertigte
Team ist schwach (Stufe 2): **EXP** (Menüseite 2) gibt dem Team Erfahrungspunkte.

## Sprungziele (im Testemulator angesprungen, 24.10.2026)

| ECL | Disk | Ort | Erster Eindruck |
|---|---|---|---|
| 16 | 1 | Erde, Raumhafen Chicagorg | Spielbeginn, Intro (deutsch) |
| 17 | 1 | Salvation III (NEO-Station) | Einweisung durch NEO-Offizier |
| 32 | 2 | Wrack im All | „Signs of fierce combat …“ |
| 33 | 2 | Salvation III, Gennie-Befall | verbarrikadierte Türen, Stufe-3-ECG |
| 34 | 2 | Sonnensystem-Karte (Raumflug) | Planetenscan (Erde), Autodoc |
| 35 | 2 | Asteroidenbasis mit ECGs | „The emergency lighting is on …“ |
| 48 | 3 | Gradivus Mons (Mars), Evakuierung | Kinder, Rettungsschiff |
| 49 | 3 | Gradivus Mons, RAM-Basis innen | „Shortly after you descend …“ |
| 50 | 3 | Piratenkreuzer im Asteroidengürtel | Raumkampf-Ereignis |
| 52 | 3 | Entern des Piratenschiffs | „You charge through the boarding tube …“ |
| 64 | 4 | Mars, Landung und Wildnis | Scot.DOS, RAM-Gleiter-Angriff |
| 65 | 4 | Tuskons Dorf (Desert Runners) | Dorftor |
| 66 | 4 | RAM-Basis Mars | Servicekorridor, Käfige mit Wüstenaffen |
| 67 | 4 | Tunnel/Mine (Commander Gilbert) | „RAM has a reception committee …“ |
| 80 | 5 | Venus, Landung (Lowlands) | Riesenblumen, Lowlander-Dorf in der Nähe |
| 81 | 5 | Zerstörtes Lowlander-Dorf | Babyschreie |
| 82 | 5 | RAM-Kaserne/Labor Venus | „The tunnel ends in a small barrack.“ |
| 83 | 5 | Ruinen des Venus-Weltraumaufzugs | Scot.DOS |
| 94 | 5 | Anflug auf die Mariposa Three | „Mariposa Three located …“ |
| 95 | 5 | Gerüchte/Tipps im Raumhafen | Venusianer erzählt |
| 96 | 6 | Mariposa: Einschleusung | Embarkation Section |
| 97 | 6 | Mariposa: Kern, Sonnenkönig | |
| 98 | 6 | Mariposa: Finale (Doomsday-Laser, Wilma) | Notfalltreppe |
| 99 | 6 | Raumhafen (z. B. Hielo): Läden, Training, Bibliothek | „You are at the Hielo orbital spacestation.“ |

Disk = ECL geteilt durch 16 (abgerundet). ECL 0, 1, 3 sind Test-/Vorspannmodule.

## Weitere Jumper-Funktionen (Menüseiten mit NEXT/PREV)

| Seite | Punkt | Wirkung | geprüft |
|---|---|---|---|
| 1 | ARENA | Testkarte für Bodenkämpfe | Karte erscheint |
| 1 | GO UP / TREASURE | nicht geprüft | – |
| 2 | EXP | Erfahrungspunkte für das Team: 5-stellige Eingabe, LINKS = nächsthöhere Stelle, OBEN = +1. **Höchstens 65535** (90000 ergab 24464 – Überlauf). **Nutzen offen:** in den Figurendaten danach kein EP-Wert gefunden; das Hauptmenü hat mit geladenem Team kein „Figur ausbilden“ (2. Symbol = Figur entlassen!). Speichern im Spiel: START → 2. Symbol (Kiste) = Spiel speichern, 3. = Spiel laden. Stattdessen Spielstand 4 „starkes Team“ benutzen | geprüft 24.10.2026 im Testemulator |
| 2 | STORE | Laden Nr. 1–16 öffnen | nicht geprüft |
| 2 | ADDBUCK / SOUND | nicht geprüft | – |
| 3 | TESTS → CREDITS | **Abspann** (ohne Musik – auch mit Original-Abspann so) | läuft, deutsch |
| 3 | TESTS → MARIPOSA | nicht geprüft | – |
| 3 | SPRITE / ARTTOOL / DEMO | Entwicklerwerkzeuge | – |
