# Testliste Phase 2 – Systemtexte

Stand: 24.10.2026. **Marcel: „alle Tests erfolgreich“ (24.10.2026, Ares)** – Nr. 1–15 bestätigt;
Nr. 12 Beute-Zeile danach geändert (Hook 11, „ERBEUTET: KEINE BEUTE.“), Nachtest offen. Bau: `07_Output_ROM\Buck Rogers - Countdown to Doomsday (gebaut).md`,
**CRC32 2E33C97D** (Testfassung 5BD1A1AE) (Zeitstempel-Ordner `07_Output_ROM\<Zeit>_deutsch\`).
Spielstand: Ares lädt `08_Savestates\Buck Rogers - Countdown to Doomsday (gebaut).ram` (Spielstand 1).
Schneller: Testfassung `(test).md` mit Jumper (`Testfassung.md`) – Spalte „Jumper“ = ECL/Disk.

Bitte Screenshot bei allem, was abgeschnitten, umgebrochen, überschrieben oder englisch ist.
„Im Testemulator gesehen“ = Claude hat es schon geprüft, in Ares noch offen.

| Nr | Stelle | So hinkommen | Erwartung | Testemulator / Ares |
|---|---|---|---|---|
| 1 | Hauptmenü | Start | Symbole beschriftet: FIGUR ERSCHAFFEN, FIGUR AUSBILDEN, FIGUR ENTLASSEN, SPIEL SPEICHERN, SPIEL LADEN, ABENTEUER STARTEN | gesehen |
| 2 | Spielstand laden | SPIEL LADEN | „LADEN SPIEL 1 : VORGEFERTIGTES TEAM“, leere Plätze „: LEERES TEAM“ | gesehen |
| 3 | Team / Charakterbogen | A, dann C auf eine Figur | TP RK, ST GE KO CH TE, STUFE, EP, BEW., ETW0, ANGRIFFE, SCHADEN – nichts überlappt | gesehen |
| 4 | Gegenstände | im Charakterbogen GEGENSTÄNDE | „BEREIT: LASERPISTOLE“, „BEREIT: RAUMANZUG“, „6000 CREDITS“, „ANSEHEN <NAME>“ | gesehen |
| 5 | Figur erschaffen | eine Figur entlassen, dann FIGUR ERSCHAFFEN | „WÄHLE RASSE, KLASSE UND GESCHLECHT“, MENSCH/WÜSTENLÄUFER/TÜFTLER, RAKETENPILOT/SANITÄTER/KRIEGER/SCHURKE, MÄNNLICH/WEIBLICH, NEU WÜRFELN, OK | gesehen (neues Spiel) |
| 6 | Namenseingabe | dort OK | „NAME DER FIGUR:“, unten „ZURÜCK OK“ in einer Zeile, „LZ LÖ“ | gesehen |
| 7 | Kampffigur / Ausbildung | weiter | „KAMPFFIGUR WÄHLEN“, „AUSBILDEN IN:“, Fertigkeiten, „KLASSE: RAKETENFLUG/NOTREPARATUR“ | gesehen |
| 8 | Ausbildung Stufenaufstieg | FIGUR AUSBILDEN mit genug EP | „GLÜCKWUNSCH“, „<NAME> IST JETZT STUFE“ / Zahl + Klasse | offen |
| 9 | Spieltempo | im Abenteuer Start → Uhr | LANGSAMSTE … LANGSAM, MITTEL, SCHNELL, SCHNELLSTE | gesehen |
| 10 | Bodenkampf | erster Kampf nach dem Intro | Leiste: ANGRIFFE, ZIEL, BEWEGEN, SCHNELLKAMPF, WARTEN, ZUGENDE, TREFFER: 45%, VERBÜNDET; „EINSATZ VON TAKTIK/FÜHRUNG“, „<NAME> BEFEHLIGT...“ | gesehen (Leiste) |
| 11 | Kampfmeldungen | Angriffe abwarten | „<NAME> ERLEIDET 5 SCHADEN.“, „GEHT ZU BODEN.“, „LIEGT IM STERBEN.“ usw. | offen (zu schnell) |
| 12 | Kampfende | Kampf gewinnen | „DAS TEAM HAT GEWONNEN.“, „JEDE FIGUR ERHÄLT … ERFAHRUNGSPUNKTE.“, „DAS TEAM HAT ERBEUTET: KEINE BEUTE.“ / „… ERBEUTET: 500 CREDITS“, ggf. „WUNDVERSORGUNG“; Team vernichtet: „RAM VERFOLGT SEINE PLÄNE UNGESTÖRT.“ in einer Zeile | Erfahrung + Team vernichtet in Ares gesehen (Marcel 24.10.2026), Fix gebaut |
| 13 | Laden (Chicagorg) | Raumhafen-Shop (Jumper: ECL 99 / Disk 6) | Gegenstandsnamen (z. B. MARS-LASERPISTOLE), „PREIS: … CREDITS JE STÜCK“, „WIE VIELE STÜCK?“, „ICH BIETE …“, „OKAY? JA NEIN“ | offen |
| 14 | Raumkampf | Jumper: ECL 50 / Disk 3 (Piraten); Schiffsstatus: RUMPF / ANTRIEB (rechts), WAFFEN / STEUERUNG (links) ohne Überdeckung | Menü FEUER/LADEN/HILFE/ZUGENDE/ANNÄHERN/ABDREHEN/RAMMEN!/ENTERN/MANÖVRIEREN, Meldungen „… FEUERT: RAKETE“, „5 SCHADEN FÜR DIE VIPER: RUMPF“ | offen |
| 15 | Planetenscan | Jumper: ECL 34 / Disk 2 | SCAN:, BEVÖLKERUNG:, ATMOSPHÄRE:, SCHWERKRAFT:, UMLAUF:, ROTATION:, DURCHMESSER: mit Werten in km | Erde gesehen (passt) |

Noch englisch (kommt später in Phase 2): Monsternamen (z. B. „TERRINE WARRIOR“), vorgefertigte
Figuren, Abspann, alle Dialoge außer dem Intro.
