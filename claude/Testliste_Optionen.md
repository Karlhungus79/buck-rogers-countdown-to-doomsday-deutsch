# Testliste Optionsmenü (Stufe 1 und 2)

Stand: 03.11.2026, 22:30. Bau: `7_deutsch_bauen.bat` → CRC32 **B9B201DF**, `7b_testfassung_bauen.bat` → **B2835D58**.

| Nr. | Stelle | Fassung / Spielstand | Erwartung | Ergebnis |
|---|---|---|---|---|
| 1 | Hauptmenü | deutsch | 6 Symbole, ganz rechts Schieberegler, Beschriftung OPTIONEN | gesehen (Testemulator) |
| 2 | Optionsbildschirm | deutsch | 12 Zeilen, 13 Symbole, alle AUS/ORIGINAL/NORMAL; C schaltet weiter, B zurück; Ende/START zurück | gesehen (Testemulator) |
| 3 | Optionsbildschirm | Testfassung | Raumkampf 100 % / 100 %, unverwundbar AN | gesehen (Testemulator) |
| 4 | Figur erschaffen | Attribute MAXIMUM | alle Attribute 18 (+ Zuschläge); NEU WÜRFELN bleibt bei 18 | gesehen (Testemulator) |
| 5 | Figur erschaffen | Attribute 2 WÜRFE / MIN. 14 | mehrmals würfeln: Werte höher bzw. nie unter 14 (vor Zuschlägen) | offen |
| 6 | Figur ausbilden (Stufenaufstieg) | TP MAXIMUM | TP-Zuwachs = Höchstwert des Klassenwürfels + KO-Bonus | offen |
| 7 | Raumkampf | Testfassung, Spielstand 4, ECL 99 Disk 6 | eigene Schüsse treffen immer, Gegner nie, Schiff ohne Schaden (wie bisher) | offen |
| 8 | Raumkampf | deutsch, Raumkampf 50 % | spürbar mehr eigene Treffer / weniger Gegnertreffer | offen |
| 9 | Raumkampf | Munition AN | Raketen werden nicht weniger | offen |
| 10 | Bodenkampf gewinnen | EP X 2, Credits X 2, Heilung AN | Meldung „Jede Figur erhält …“ doppelt so hoch, Beute-Credits doppelt, TP danach voll | offen |
| 11 | Reset-Knopf | beliebig | Einstellungen bleiben? (nach Aus/Ein: Standard) | offen |
| 12 | Bodenkampf | Gegner daneben 100 % | Team nimmt durch normale Angriffe keinen Schaden | gesehen (Testemulator, Arena) |
| 13 | Bodenkampf | eigene Treffer 100 % | jeder eigene Angriff trifft, auch bei niedriger „TREFFER“-Anzeige | offen |
| 14 | Bodenkampf | eigene Treffer / Gegner 50 % | spürbar mehr eigene Treffer, weniger Gegnertreffer | offen |
| 15 | Bodenkampf | Flächenwaffe (Granate) mit eigene Treffer 100 % | Wurf landet immer auf dem Ziel | offen |
| 16 | Sonnensystem-Karte | Begegnungen KEINE | keine Zufallsbegegnung | gesehen (Testemulator) |
| 17 | Sonnensystem-Karte | Begegnungen HALB | Begegnungen etwa halb so oft | gesehen (Testemulator) |
| 18 | Sonnensystem-Karte | Testfassung, ECL 99 Disk 6, Begegnungen MERKUR+ | etwa jede zweite Begegnung ein Merkur-Kreuzer | gesehen (Testemulator, 23 von 40) |
| 19 | START-Menü im Spiel | beide Fassungen | rechts neues Symbol OPTIONEN; öffnet den Optionsbildschirm | gesehen (Testemulator) |
| 20 | START → Optionen → zurück | an mehreren Orten (Raumhafen, Station, Mars) | Spielbild, Musik und Steuerung wie vorher; Speichern und Laden gehen weiter | teilweise (Testemulator, nur Jumper-Arena) |
| 21 | Raumkampf | Munition AN | jede Figur kann in derselben Runde jede Waffe wählen, auch K-Kanone auf großer Reichweite; Munition sinkt nicht | gesehen (Testemulator, Spielstand Luke) |
| 22 | Raumkampf | Munition AUS | K-Kanone ab Reichweite 3 gesperrt, Schüsse je Runde begrenzt | teilweise (Testemulator, Reichweite) |
| 23 | Figur erschaffen, danach Hauptmenü und Optionen | beliebig | alle Symbole sichtbar | gesehen (Testemulator) |
| 24 | Optionsbildschirm aus dem Hauptmenü mit geladenem Team | beliebig | **bekannter Fehler:** blaue Flächen über dem Text | offen, nicht behoben |
