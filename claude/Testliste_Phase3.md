# Testliste Phase 3 – Grafik

Stand: 24.10.2026. Bau: `07_Output_ROM\Buck Rogers - Countdown to Doomsday (gebaut).md`, **CRC32 814E4C76**,
Testfassung `(test).md` **F436B9D1** (Bedienung `Testfassung.md`).
Alle Texte hat Claude selbständig gewählt (Marcel nicht erreichbar) – **im Spieltest prüfen**, bei
Nichtgefallen einfach Wunschtext melden.

| Nr | Stelle | So hinkommen | Erwartung | Testemulator / Ares |
|---|---|---|---|---|
| 1 | SSI-Logo | Einschalten, warten | unter dem Logo „PRÄSENTIERT“, nichts abgeschnitten | gesehen |
| 2 | Laser-Vorspann | weiter warten | „DOOMSDAY LASER“ / „AKTIV“ werden eingetippt, dann „ZIEL?“, dann „ERDE“; keine Reste der englischen Wörter | gesehen |
| 3 | Titel | weiter warten | Titelbild unverändert (Logo + englische Copyright-Zeilen, E4 = A) | gesehen |
| 4 | Abspann-Kopf | Testfassung: Jumper → NEXT → NEXT → TESTS → CREDITS | „BUCK ROGERS / COUNTDOWN TO DOOMSDAY / ENTWICKELT VOM / SSI-Logo / SPECIAL PROJECTS TEAM“ | gesehen |
| 5 | Raumkampf-Anzeige | Raumkampf (Testliste Phase 2 Nr. 14) | Schiffsanzeige mit WAFF / STRG / ANTR / RUMPF, Balken unverändert | **offen** (im Testemulator nicht erreicht) |
| 6 | Allgemein | Spiel normal starten und laden | keine Bildfehler (Kacheln, Farben) nach dem Vorspann | Vorspann ok |
