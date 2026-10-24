# Phase 2 – Entscheidungen Systemtexte

Stand: 24.10.2026 – **entschieden 24.10.2026, Marcel: „E alles A“.** Eingetragen in Glossar
(CSV 3/4/5, `Glossar.md`). Entspricht dem Bau CRC32 598A9641, kein Neubau. Im Spieltest prüfen.

## E1 – Glossar-Abweichungen aus Platzgründen

Das Glossar (21.10.2026) wurde vor dem Messen der Fenster abgenommen. Im Testemulator gemessen:

| Nr | Original | Glossar | A (gebaut, Empfehlung) | Grund |
|---|---|---|---|---|
| 3-09 | done | fertig | **OK** | Namenseingabe: Platz für 4 Zeichen, „FERTIG“ brach in die nächste Zeile um (Bild `Vorschau\Phase2_…`) |
| 3-15 | abort | Abbruch | **Zurück** | Namenseingabe: höchstens 6 Zeichen |
| 3-24 | flee the battle? | Kampf fliehen? | **Aus dem Kampf fliehen?** | grammatisch vollständig, passt (22 + „ja nein“) |
| 4-17 | pilot rocket/juryrig | Raketen fliegen/Notreparatur | **Raketenflug/Notreparatur** | 28 Zeichen zu lang für die Ausbildungszeile; 24 wie das längste Original |
| neu | career skill: … | – | **Klasse: …** („Klasse: Raketenflug/Notreparatur“) | „Hauptfertigkeit: …“ (45 Zeichen) überschrieb sich selbst |
| 5-13 | martian heavy body armor | (Mars-) schwere Körperpanzerung | **Mars-Schwerpanzerung** | Gegenstandszeile 33 Zeichen inkl. „bereit: “ → Name höchstens 25 |
| 5-13 | martian battle armor w/fields | (Mars-) Kampfpanzerung m. Feld | **Mars-Kampfpanz. m. Feld** | dito; ohne Herkunft bleibt „Kampfpanzerung m. Feld“ |

B: Glossarform behalten und an anderer Stelle kürzen (z. B. „Abbr.“, „Fertg“) – nicht empfohlen.

## E2 – Kuriositäten in den Original-Gegenstandsnamen

Die Gegenstandstabelle (ROM `$F17D6`) enthält Namen, die wie Datenfehler aussehen:

| Original (zusammengesetzt) | A (gebaut, Empfehlung) | B (wörtlich) | Begründung A |
|---|---|---|---|
| behind cover gun | **Mikrowellenpistole** | Deckungspistole | **Annahme:** gemeint ist die „Microwave Gun“ der PC-Fassung; Namensteil S012 („behind cover“) ist offenbar falsch verknüpft. Nicht bestätigt. |
| treating wounds grenade | **Sanitätsgranate** | Wundversorgungsgranate (Mehrzahl zu lang) | sinngemäß, kurz |
| martian sword gun | **Mars-Hitzepistole** | Mars-Schwertpistole | Gegenstandstyp ist die Hitzepistole (Byte 0 = `$0E`) |
| mercurian mono bolt | **Merkur-Monoschwert** | Merkur-Monobolzen | Gegenstandstyp ist das Monoschwert (Byte 0 = `$08`) |

## E3 – Artikel vor Feindschiffen im Raumkampf

Das Spiel setzt „the“ vor feindliche Schiffe („the Viper“). Die Satzbausteine stehen fest.

| | A (gebaut, Empfehlung) | B |
|---|---|---|
| Form | „die Viper“ (Schiffe weiblich); alle Bausteine so formuliert, dass nur Nominativ/Akkusativ vorkommt: „überlistet die Viper“, „5 Schaden für die Viper: Rumpf“, „Rakete zerstört: die Viper“ | ohne Artikel: „überlistet Viper“; Nachteil: ein Leerzeichen zu viel vor dem Namen (Code setzt es) |

## E4 – Copyright-Zeilen im Titel

| | A (gebaut, Empfehlung) | B |
|---|---|---|
| | englisch lassen („(c) 1991 TSR, Inc.“, „All rights reserved“, „Licensed by Sega …“) – Rechtstexte üblich unverändert | „Alle Rechte vorbehalten“, „Lizenziert von Sega …“ |

## Nach der Entscheidung

Claude trägt die Entscheidung in Glossar (CSV + `Glossar.md`) und `systemtexte.toml` ein.
Bei „alles A“ ist kein Neubau nötig.
