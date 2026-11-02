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
Kampf mit 120 TP noch nicht im Spiel gesehen.

**Ablageort in Ares (Befund 24.10.2026):** Ares ist auf `08_Savestates` eingestellt, liest und schreibt die
Spielstände aber im Unterordner `08_Savestates\Mega Drive\`. Die Datei mit dem starken Team muss deshalb nach
`08_Savestates\Mega Drive\Buck Rogers - Countdown to Doomsday (test).ram` – **nur bei geschlossenem Ares
kopieren**, sonst überschreibt Ares sie beim Beenden (ist am 24.10.2026 einmal passiert). Leere Ares-Datei
gesichert in `08_Savestates\bak_ares_leer_2026-10-24\`.

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
| 2 | EXP | Erfahrungspunkte für das Team: 5-stellige Eingabe, LINKS = nächsthöhere Stelle, OBEN = +1. **Höchstens 65535** (90000 ergab 24464 – Überlauf). Danach Stufenaufstieg über Hauptmenü FIGUR AUSBILDEN (Spiel vorher speichern: START, vermutlich Schubladen-Symbol – nicht geprüft) | geprüft 24.10.2026 im Testemulator |
| 2 | STORE | Laden Nr. 1–16 öffnen | nicht geprüft |
| 2 | ADDBUCK / SOUND | nicht geprüft | – |
| 3 | TESTS → CREDITS | **Abspann** (ohne Musik – auch mit Original-Abspann so) | läuft, deutsch |
| 3 | TESTS → MARIPOSA | nicht geprüft | – |
| 3 | SPRITE / ARTTOOL / DEMO | Entwicklerwerkzeuge | – |

## Raumkampf gegen bestimmte Schiffe (Analyse ECL-Modul 34, 24.10.2026, Claude)

Zufallsbegegnungen im All laufen in M034 (`$71C7`): Typ = Zufall 0–4 →
0 RAM-Scout, 1 RAM Medium, 2 RAM Heavy, 3 Piraten Medium, **4 Merkur Medium** (0–2 doppelt gewichtet).
Ein Ort wird dort nicht geprüft. **Solange keiner der drei Merker gesetzt ist, kommen nur RAM-Scout und
RAM Medium.** Freigeschaltet wird die volle Liste durch einen dieser Merker:

| Merker | gesetzt in | Ereignis |
|---|---|---|
| `$9876` | M050 (ECL 50) | Piratenkreuzer-Hinterhalt am Asteroiden (gleich zu Beginn des Moduls) |
| `$9876` | M049 (ECL 49) | Nachricht im RAM-Computer Gradivus Mons |
| `$9855` | M066 (ECL 66) | Flucht aus der RAM-Basis Mars (Atha mit Passkarten) |
| `$98B0` | M082 (ECL 82) | Retina-Dietrich unter der Bodenplatte (Venus) |

Danach ist etwa jede 7. bis 8. Zufallsbegegnung ein Merkur-Kreuzer. Nur aus dem Code abgeleitet, im Spiel nicht geprüft.

## Raumkampf-Hilfen der Testfassung (24.10.2026, Claude, auf Marcels Wunsch)

**Seit 02.11.2026 Optionen in beiden Fassungen** (`Optionen.md`): Hooks 20–22 rufen jetzt `DE_RaumGegner`,
`DE_RaumEigen`, `DE_Unverwundbar` auf. Die Testfassung startet mit 100 % / 100 % / AN (= Verhalten wie unten),
die deutsche Fassung mit AUS. Einstellbar im Hauptmenü unter OPTIONEN. Die Tabelle unten ist der alte Stand.

Nur mit `-D DEUTSCH_TEST=1` (`7b_testfassung_bauen.bat`), die deutsche Fassung bleibt unverändert.
Alle Eingriffe gleich lang wie das Original, Rückfallwert jeweils in `buckrogers.asm` (`else`-Zweig).

| Hook | Stelle | Wirkung | Rückfallwert |
|---|---|---|---|
| 20 | `$1828A` (Bordwaffen Gegner, Wurf W20) | Gegner trifft nie (`bra.s loc_182B2`) | `beq.s loc_18290` |
| 21 | `$18A3A` (eigene Bordwaffen, Wurf W20) | eigenes Schiff trifft immer (`bra.s loc_18A44`) | `beq.s loc_18A44` |
| 22 | `$19368` (Anfang `sub_19360`, jeder Schiffstreffer) | `jsr DE_Unverwundbar` (`src\deutsch.asm`, `$1000C8`): Ziel eigenes Schiff → Schaden 0 auf Rumpf, keine Systemausfälle, kein Besatzungsschaden | `bsr.w sub_1991C` / `move.l d1,d2` |

Hook 22 fängt auch Schaden aus anderen Quellen ab (z. B. Rammen/Ausmanövrieren `sub_192B2`); dann steht
eine Meldung mit 0 Schadenspunkten. Nicht abgedeckt: Gegner-Raketen (`sub_182D4`, eigener Wurf), Bodenkämpfe
nach dem Entern (dafür: Spielstand 4 mit 120 TP). Erwartete CRC32 Testfassung: **82DFF8A8**
(berechnet aus Bau 21:09 + G7-Korrektur + Hooks 20–22; Assembler unter Linux nicht verfügbar).
**Gebaut, Test in Ares offen.**

## Handlungsstand per Jumper setzen (Analyse M000, 24.10.2026, Claude)

**Automatisch (seit 24.10.2026, 22:35, DEUTSCH-HOOK 23, nur Testfassung):** Jeder Jumper-Sprung (JUMP) auf
**ECL 94 oder höher** setzt die drei Merker unten selbst auf 1 = Endspiel-Stand. Für Weltraum im Endspiel:
**ECL 99, Disk 6** (Raumhafen) anspringen und abfliegen, oder ECL 94, Disk 5. Sprünge unter 94 bleiben unverändert.
Technik: `jsr DE_JumperStand` statt `move.b ($FFFFB9F0).w,($FFFF97E8).w` am Anfang von NEWECL (`loc_383E`);
Bedingung Modul 0, `$9E6F` = 0 (JUMP), `$9E70` ≥ 94. Rückfallwert: der Original-Befehl.
Erwartete CRC32 Testfassung **A11EB65A** (inkl. Mio./Mrd.), deutsch unverändert **989ABA78**. Gebaut, Test offen.

Von Hand (für andere Ziele):

„Set party variables?“ → YES → „PARTY PLUS WHAT OFFSET?“ (3 Stellen) → „WHAT WILL THE VARIABLE BE SET TO?“.
Gespeichert wird bei `$96F6 + Offset`; Offset **≤ 256 beendet** die Eingabe, dann folgt der Sprung.
Die drei Hauptauftrags-Merker (abgefragt u. a. in M017, M034, M094):

| Offset | Adresse | Bedeutung (wo im Spiel gesetzt) |
|---|---|---|
| 384 | `$9876` | Gradivus Mons / Piratenhinterhalt erledigt (M049, M050) |
| 351 | `$9855` | RAM-Basis Mars erledigt (M066) |
| 442 | `$98B0` | Venus-Labor erledigt, Retina-Dietrich (M082) |

Alle drei auf 1 = Endspiel-Stand: im All volle Gegnerliste (RAM Heavy, Piraten, Merkur-Kreuzer), Mariposa-Anflug (M094)
wie nach allen Aufträgen. Nur aus dem Code abgeleitet, im Spiel nicht geprüft.
Der Raumkampf-Test im Jumper („SPACE COMBAT“, Schiffstyp A–E) ist im Original nicht erreichbar (steht hinter NEWECL).
