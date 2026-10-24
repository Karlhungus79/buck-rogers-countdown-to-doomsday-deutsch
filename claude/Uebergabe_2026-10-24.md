# Übergabe 24.10.2026, ca. 20:55

## Auftrag
Marcel (24.10.2026, 17:44 und 20:21): eigenständig weiterarbeiten, selbst entscheiden (Entscheidungen
schriftlich, „im Spieltest prüfen“), Ziel: Projekt fertigstellen. Marcel ist meist nicht am PC.

## Stand
- Tor Phase 0, 1, 2 erreicht. Phase 3 (Grafik) gebaut: deutsch **814E4C76**, Test **F436B9D1**
  (`Grafik.md`, `Testliste_Phase3.md`). Ares-Test durch Marcel offen.
- Phase 5 (Dialog): Erstübersetzung aller Spielmodule fertig (2130 Texte, `Dialog.md`), gebaut deutsch
  **59F0785A**, Test **9CF3FBF3**, Ares offen (`Testliste_Phase5.md`).
- Bauten liegen auf H: in `07_Output_ROM\2026-10-24_20-44-…_deutsch\` / `_test\` und unter den festen
  Namen `(gebaut).md` / `(test).md`. Vorher: `2026-10-24_20-22-08_…` (Grafik, 814E4C76 / F436B9D1),
  `2026-10-24_17-28-…` (Tor Phase 2, 0B58AE77 / 37DE7A79).

## Arbeitsumgebung neu aufsetzen (Claude-Container)
1. Repo klonen (`add_repo` Karlhungus79/buck-rogers-countdown-to-doomsday-deutsch, push).
2. Original-ROM und Spielstände von H: stagen → `01_Original_ROM\`, `08_Savestates\`; `python3 03_Tools/extract.py`;
   `python3 03_Tools/text_extrahieren.py` (englischer Referenztext).
3. AS-Assembler bauen (flamewing asl, Commit 592c5fa) nach `/home/claude/tools/asl/build`, PATH setzen.
4. Testkern: `sh 03_Tools/emu_test/kern_bauen.sh`.
5. Bauen: `text_einsetzen.py`, `grafik_deutsch.py`, `build.py --deutsch` / `--test`, `build.py --pruefen`.
6. Testemulator-Weg zum Jumper: 900 Bilder, 7 × Start (je 60 Bilder), 3 × rechts, C, C, rechts, C →
   „Jumper/Start“ → C. Seiten mit NEXT (5 × rechts, C). Zahleneingabe: RECHTS = Zehner, OBEN = +1.

## Nächste Schritte
1. Marcel: Phase 3 in Ares testen (`Testliste_Phase3.md`), vor allem G7 (Raumkampf-Anzeige).
2. ~~Claude: Phase 5 Dialog~~ Erstübersetzung erledigt. Nächster Claude-Schritt: Korrekturen aus Marcels
   Spieltests; danach Phase 6 vorbereiten (BPS/IPS-Patch gegen CRC32 44E3BFFF, Readme deutsch/englisch).
   Alt: Phase 5 Dialog – Reihenfolge nach Spielverlauf (M016, M017, M032 …), Grundsätze G1–G9,
   Glossar, Anrede („ihr“ NEO/Verbündete, „Sie“ Fremde). Nach jedem Modul: einsetzen, bauen, Prüfregeln,
   Stichprobe im Testemulator, Commit + H:. Entscheidungen in `Dialog.md` („im Spieltest prüfen“).
   Begründung für die Reihenfolge (Dialog vor Phase-4-Abnahme): Marcel nicht erreichbar, Phase 4
   braucht seine Tests; Dialog braucht sie nicht sofort.
