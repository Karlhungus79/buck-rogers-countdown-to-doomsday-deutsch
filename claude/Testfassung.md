# Testfassung mit Entwickler-Jumper

Stand: 24.10.2026 (Bau CRC32 C719F1FC) – **gebaut, im Testemulator geprüft (Sprünge in alle 23 Spielmodule, Arena,
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

## Bedienung

1. Testdatei in Ares starten, **Spiel laden → Spielstand 1 (vorgefertigtes Team)**, **Abenteuer starten**.
2. „JUMPER“ wählen (C), Text mit C weiter → Menü „WHERE DO YOU WISH TO GO?“.
3. **JUMP** → „What ECL …“: Zahl eingeben. OBEN/UNTEN ändert die Einerstelle, **RECHTS** wechselt
   zur Zehnerstelle, C bestätigt.
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
| 2 | EXP | Erfahrungspunkte für das Team | nicht geprüft |
| 2 | STORE | Laden Nr. 1–16 öffnen | nicht geprüft |
| 2 | ADDBUCK / SOUND | nicht geprüft | – |
| 3 | TESTS → CREDITS | **Abspann** | läuft (noch englisch) |
| 3 | TESTS → MARIPOSA | nicht geprüft | – |
| 3 | SPRITE / ARTTOOL / DEMO | Entwicklerwerkzeuge | – |
