#!/usr/bin/env python3
"""
Erzeugt die Glossar-Vorschlagslisten (CSV, Excel) in 05_German_Script\\Glossar\\.
Zeichenzahlen und Fundorte werden aus 04_English_Script ermittelt.

Spalten: Nr; Original; A (Empfehlung); B; C; Zeichen EN; Zeichen A; max. Zeichen;
         Begruendung; Entscheidung; Fundort
Die Spalte "Entscheidung" traegt Claude nach Marcels Antwort ein.

Aufruf: python 03_Tools/glossar_vorschlag.py   (braucht vorher 2_text_extrahieren.bat)
"""
import csv
import glob
import os
import re
import tomllib

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
EN = os.path.join(ROOT, "04_English_Script")
OUT = os.path.join(ROOT, "05_German_Script", "Glossar")

MONSTER = """D.R. WARRIOR|LL. WARRIOR|LL. TECHNICIAN|DESERT APE|HEXADILLO|SAND SQUID|MER. LEADER|
MER. TECHNICIAN|MER. H.S. ROBOT|SM. E.C. GENNIE|LG. E.C. GENNIE|PIRATE WARRIOR|PIRATE LEADER|
P. COMBAT ROBOT|RAM ASSASSIN|RAM G.D. GENNIE|HYPERCRAB|HYPERSCORP|HYPERSNAKE|RAM MAR CGENNIE|
RAM MER CGENNIE|RAM VEN CGENNIE|RAM ASSAULT BOT|RAM COMBAT BOT|RAM L.D. ROBOT|RAM H.D. ROBOT|
RAM L.S. ROBOT|RAM H.S. ROBOT|RAM TECHNICIAN|RAM WARRIOR|SPACE RAT|TERRINE LEADER|SWAMP HORNET|
URSADDER|ACID FROG|ACIDICIUM|VEN. H.S. ROBOT|MER. WARRIOR|NEO WARRIOR|TERRINE WARRIOR|STAGE 3  ECG|
TALON|TUSKON|LEANDER|ZANE|BUCK ROGERS|BEOWULF SAND|JASON BRAGA|CARLOS RIOJA""".replace("\n", "")
MONSTER = set(MONSTER.split("|"))
PREGEN = {"FLAVIUS", "CELESTE", "PIERRE", "NICHOLE", "ROARKE", "JANELLE"}

# (Original, A, B, C, max, Begruendung, Suchbegriff optional)
LISTEN = {
"1_Eigennamen_Figuren": [
 ("Buck Rogers", "Buck Rogers", "", "", "", "Eigenname, unverändert"),
 ("Wilma", "Wilma", "", "", "", "Eigenname (Wilma Deering), unverändert"),
 ("Huer.DOS", "Huer.DOS", "", "", "", "Digitale Persönlichkeit (Dr. Huer), .DOS bleibt"),
 ("Scot.DOS", "Scot.DOS", "", "", "", "KI des Schiffs, .DOS bleibt"),
 ("Holzerhein.DOS", "Holzerhein.DOS", "", "", "", "RAM-KI, unverändert"),
 ("Kilroy.DOS", "Kilroy.DOS", "", "", "", "Anspielung „Kilroy was here“ → „KILROY.DOS WAR HIER“"),
 ("Tuskon", "Tuskon", "", "", "", "Anführer der Desert Runner"),
 ("Atha", "Atha", "", "", "", "Desert Runner, entführt"),
 ("Talon", "Talon", "", "", "", "Gegenspieler (Asteroidenbasis)"),
 ("Leander", "Leander", "", "", "", "Terrine, spricht zischend (siehe Glossar.md G9)"),
 ("Zane", "Zane", "", "", "", "Eigenname"),
 ("Beowulf Sand", "Beowulf Sand", "", "", "", "Mitstreiter, Eigenname"),
 ("Jason Braga", "Jason Braga", "", "", "", "Mitstreiter, Eigenname"),
 ("Carlos Rioja", "Carlos Rioja", "", "", "", "Mitstreiter, Eigenname"),
 ("Carlton Turabian", "Carlton Turabian", "", "", "", "NEO-Kommandant Salvation III"),
 ("Justin Robeno", "Justin Robeno", "", "", "", "Eigenname", "ROBENO"),
 ("Jason Dupare", "Jason Dupare", "", "", "", "Eigenname", "DUPARE"),
 ("Landon", "Landon", "", "", "", "Eigenname"),
 ("Dr. Conchitez", "Dr. Conchitez", "", "", "", "Eigenname", "CONCHITEZ"),
 ("Vilnikov", "Vilnikov", "", "", "", "Eigenname"),
 ("Garrity", "Garrity", "", "", "", "Eigenname"),
 ("Milo", "Milo", "", "", "", "Eigenname"),
 ("Ragon", "Ragon", "", "", "", "Eigenname"),
 ("Eliph", "Eliph", "", "", "", "Eigenname"),
 ("Gavilan", "Gavilan", "", "", "", "Eigenname"),
 ("Sun King", "Sonnenkönig", "Sun King", "", "", "Herrscher einer Mariposa, spricht Französisch; Titel, daher übersetzen"),
 ("Mr.", "Mr.", "Herr", "", "", "Mr. ist in deutscher Sci-Fi üblich (vgl. Mr. Spock), kürzer", r"\bMR\."),
 ("Flavius, Celeste, Pierre, Nichole, Roarke, Janelle", "unverändert", "", "", "", "Vorgefertigte Figuren", "PREGEN"),
],
"2_Fraktionen_Orte": [
 ("NEO", "NEO", "", "", "", "Fraktion, Kürzel bleibt", r"\bNEO\b"),
 ("New Earth Organization", "New Earth Organization", "Neue-Erde-Organisation", "", "", "Langform nur im Vorspann; A wie Lizenz international", "NEW EARTH ORGANIZATION"),
 ("RAM", "RAM", "", "", "", "Fraktion, Kürzel bleibt", r"\bRAM\b"),
 ("Russo-American Mercantile", "Russo-American Mercantile", "Russisch-Amerikanische Handelsgesellschaft", "", "", "Langform; B erklärt, ist aber sehr lang", "RUSSO-AMERICAN"),
 ("Desert Runner(s)", "Wüstenläufer", "Desert Runner", "", "13", "Volk/Rasse; A verständlich und gleich lang wie S072", "DESERT RUNNER"),
 ("Lowlander(s)", "Tiefländer", "Lowlander", "", "", "Venus-Dorfbewohner", "LOWLANDER"),
 ("Terrine", "Terrine", "", "", "", "Gennie-Volk, Eigenname", "TERRINE"),
 ("Mercurian", "Merkurianer", "", "", "", "Bewohner Merkurs", "MERCURIAN"),
 ("Venusian", "Venusianer", "", "", "", "Bewohner der Venus", "VENUSIAN"),
 ("Martian", "Marsianer", "", "", "", "Bewohner des Mars", "MARTIAN"),
 ("Lunarian", "Lunarier", "", "", "", "Bewohner des Mondes", "LUNARIAN"),
 ("Earth", "Erde", "", "", "", "", r"\bEARTH\b"),
 ("Mercury", "Merkur", "", "", "", "", "MERCURY"),
 ("Mars / Venus", "Mars / Venus", "", "", "", "gleich", r"\bMARS\b"),
 ("Luna", "Luna", "Mond", "", "", "„Chez Luna“ bleibt Name", r"\bLUNA\b"),
 ("Ceres, Vesta, Fortuna, Pallas, Psyche, Juno, Aurora, Thule", "unverändert", "", "", "", "Asteroiden", r"\bCERES\b"),
 ("Hygeia", "Hygeia", "Hygiea", "", "", "A wie Original, B korrekte deutsche Schreibung", "HYGEIA"),
 ("Mariposa(s)", "Mariposa(s)", "", "", "", "Orbitalstädte bei Merkur", "MARIPOSA"),
 ("Salvation III / Salvation Station", "Salvation III / Station Salvation", "Salvation III / Salvation-Station", "", "", "NEO-Hauptquartier", "SALVATION"),
 ("Chicagorg", "Chicagorg", "", "", "", "Stadt auf der Erde, Eigenname", "CHICAGORG"),
 ("Gradivus Mons", "Gradivus Mons", "", "", "", "RAM-Basis auf dem Mars", "GRADIVUS"),
 ("Pavonis", "Pavonis", "", "", "", "Ort auf dem Mars (Raumhafen, Bibliothek)", "PAVONIS"),
 ("Tycho", "Tycho", "", "", "", "Mondkrater", "TYCHO"),
 ("Chez Luna", "Chez Luna", "", "", "", "Restaurant, Name bleibt", "CHEZ LUNA"),
 ("Holst Plaza", "Holst-Plaza", "Holst-Platz", "", "", "", "HOLST"),
 ("Marat's Bazaar", "Marats Basar", "", "", "", "", "MARAT"),
 ("Udu's Cafe", "Udus Café", "Udus Cafe", "", "", "é nur, wenn die Kachel kommt", "UDU"),
 ("Johji's Magnetic Footwear", "Johjis Magnetschuhe", "", "", "", "Laden", "JOHJI"),
 ("Spaceport / Starport", "Raumhafen", "", "", "", "", "SPACEPORT"),
 ("Asteroid Base", "Asteroidenbasis", "", "", "", "", "ASTEROID BASE"),
 ("Doomsday Device / Weapon / Laser", "Doomsday-Laser (-Waffe)", "Weltuntergangslaser (-waffe)", "Jüngster-Tag-Laser", "", "Bezug zum englischen Spieltitel (Logo bleibt englisch)", "DOOMSDAY"),
 ("Maelstrom Rider", "Maelstrom Rider", "", "", "15", "Schiffsname, bleibt", "MAELSTROM"),
],
"3_UI_Begriffe": [
 ("team", "Team", "Trupp", "Gruppe", "", "Grundsatz G5; im Spiel sehr häufig, A gleich kurz", r"\bTEAM\b"),
 ("create character", "Figur erschaffen", "Figur erstellen", "", "", "Hauptmenü", "S"),
 ("train character", "Figur ausbilden", "", "", "", "", "S"),
 ("drop character", "Figur entlassen", "Figur löschen", "", "", "", "S"),
 ("save game", "Spiel speichern", "", "", "", "", "S"),
 ("restore game", "Spiel laden", "", "", "", "", "S"),
 ("begin adventure", "Abenteuer starten", "Los geht's", "", "", "", "S"),
 ("reroll stats", "neu würfeln", "", "", "", "", "S"),
 ("done", "fertig", "", "", "", "", "S"),
 ("exit", "Ende", "zurück", "", "", "", "S"),
 ("del / spc", "Lö / Lz", "Entf / Leer", "", "3", "Namenseingabe, Platz 3 Zeichen", "del"),
 ("enter character's name", "Name der Figur:", "Namen eingeben:", "", "", "", "S"),
 ("congratulations", "Glückwunsch", "Gratulation", "", "", "", "S"),
 ("is now a level", "ist jetzt Stufe", "", "", "", "Satzbau: <Name> ist jetzt Stufe <n>", "S"),
 ("abort", "Abbruch", "", "", "", "", "S"),
 ("yes~no", "ja~nein", "j~n", "", "", "Ja/Nein-Breite im Spiel messen (Falle aus PSG2)", "S"),
 ("press c to continue", "C: weiter", "weiter mit C", "", "", "", "S"),
 ("view team / view skills / view items", "Team / Fertigkeiten / Gegenstände", "Team / Können / Ausrüstung", "", "", "Menüpunkte, Breite offen", "view team"),
 ("reorder team", "Team ordnen", "", "", "", "", "S"),
 ("change game speed", "Spieltempo", "", "", "", "", "S"),
 ("toggle music", "Musik an/aus", "", "", "", "", "S"),
 ("choose combat figure", "Kampffigur wählen", "", "", "", "", "S"),
 ("quick combat", "Schnellkampf", "Autokampf", "", "", "", "S"),
 ("flee the battle?", "Kampf fliehen?", "Flucht?", "", "", "", "S"),
 ("target", "Ziel", "", "", "", "", "S"),
 ("move / wait", "bewegen / warten", "", "", "", "", "wait"),
 ("readied", "bereit", "ausgerüstet", "", "", "", "S"),
 ("drop / sell / trade with / sell for", "ablegen / verkaufen / geben an / Preis", "", "", "", "", "sell for"),
 ("credits", "Credits", "", "", "", "Währung, bleibt", "S"),
 ("experience points", "Erfahrungspunkte", "EP", "", "", "", "S"),
 ("hit point(s)", "Trefferpunkt(e)", "", "", "", "", "hit point"),
 ("slow / medium / fast", "langsam / mittel / schnell", "", "", "", "Spieltempo", "medium"),
 ("dead / dying / unconscious / fleeing", "tot / sterbend / bewusstlos / flieht", "", "", "", "Zustände", "unconscious"),
 ("poisoned / comatose / blinded / stunned / dizzy", "vergiftet / im Koma / geblendet / betäubt / benommen", "", "", "", "Zustände", "comatose"),
 ("logbook entry", "Logbucheintrag", "", "", "", "", "logbook"),
 ("fire / reload / aid / end turn", "Feuer / laden / Hilfe / Zugende", "", "", "", "Raumkampf-Menü", "end turn"),
 ("close / withdraw / ram! / board / maneuver", "annähern / abdrehen / rammen! / entern / manövrieren", "", "", "", "Raumkampf-Menü", "withdraw"),
 ("hull / controls / engines / weapons", "Rumpf / Steuerung / Triebwerke / Waffen", "", "", "", "Schiffssysteme", "controls"),
 ("range / to hit / ammo left / ready", "Reichweite / Treffer / Munition / bereit", "", "", "", "Raumkampf-Anzeige, Breite offen", "ammo left:"),
 ("scanning / population / atmosphere / gravity / revolution / rotation / diameter", "Scan / Bevölkerung / Atmosphäre / Schwerkraft / Umlauf / Rotation / Durchmesser", "", "", "", "Planetendaten", "population:"),
 ("miles", "km (umgerechnet)", "Meilen", "", "", "Grundsatz G8", "miles"),
 ("save / restore", "speichern / laden", "", "", "", "", "restore"),
],
"4_Klassen_Rassen_Attribute": [
 ("rocket jock", "Raketenpilot", "Rocketjock", "Raketenjockey", "", "Klasse; A sagt, was die Figur kann", "S"),
 ("medic", "Sanitäter", "Mediziner", "Medic", "", "Klasse", "S"),
 ("warrior", "Krieger", "", "", "", "Klasse", "S"),
 ("rogue", "Schurke", "Gauner", "", "", "Klasse (AD&D-Tradition: Schurke)", "S"),
 ("human", "Mensch", "", "", "", "Rasse", "S"),
 ("desert runner", "Wüstenläufer", "Desert Runner", "", "", "Rasse, wie Fraktion", "S"),
 ("tinker", "Tüftler", "Tinker", "", "", "Rasse (kleine Technik-Gennies); A beschreibt sie", "S"),
 ("male / female", "männlich / weiblich", "Mann / Frau", "", "", "", "female"),
 ("str / dex / con / cha / tch", "ST / GE / KO / CH / TE", "STÄ / GES / KON / CHA / TEC", "", "3", "Grundsatz G7: deutsche AD&D-Kürzel", "str"),
 ("hp", "TP", "", "", "", "Trefferpunkte", "S"),
 ("ac", "RK", "", "", "", "Rüstungsklasse", "S"),
 ("thac0", "ETW0", "THAC0", "", "", "deutsche AD&D-2E: ETW0", "S"),
 ("level", "Stufe", "", "", "", "", "S"),
 ("move", "Bew.", "", "", "", "", "S"),
 ("damage", "Schaden", "", "", "", "", "S"),
 ("exp", "EP", "", "", "", "", "S"),
 ("pilot rocket/juryrig", "Raketen fliegen/Notreparatur", "Pilot/Notreparatur", "", "", "Karrierefertigkeit Raketenpilot", "S"),
 ("treat wounds", "Wunden versorgen", "", "", "", "Karrierefertigkeit Sanitäter", "S"),
 ("tactics/leadership", "Taktik/Führung", "", "", "", "Karrierefertigkeit Krieger", "S"),
 ("bypass security", "Sicherung umgehen", "Schlösser knacken", "", "", "Karrierefertigkeit Schurke", "S"),
 ("zero gravity maneuvering", "Schwerelosigkeit", "Null-G-Manöver", "", "", "", "S"),
 ("perception", "Wahrnehmung", "", "", "", "", "S"),
 ("demolition", "Sprengen", "Sprengtechnik", "", "", "", "S"),
 ("stealth", "Schleichen", "", "", "", "", "S"),
 ("climbing", "Klettern", "", "", "", "", "S"),
 ("fast talk", "Überreden", "Schwatzen", "", "", "", "S"),
 ("first aid", "Erste Hilfe", "", "", "", "", "S"),
 ("repair rocket", "Rakete reparieren", "Raketenreparatur", "", "", "", "S"),
 ("library search", "Recherche", "Archivsuche", "", "", "", "S"),
 ("programming", "Programmieren", "", "", "", "", "S"),
 ("weapon specialization", "Waffenspezialisierung", "", "", "", "", "specialization"),
],
"5_Ausruestung_Gegner": [
 ("knife / sword / cutlass / polearm", "Messer / Schwert / Entermesser / Stangenwaffe", "", "", "", "Achtung: Itemnamen werden aus Wortteilen zusammengesetzt (S001–S044), Mechanik in Phase 2 prüfen", "cutlass"),
 ("mono sword", "Monoschwert", "Monoklinge", "", "", "", "S"),
 ("needle gun", "Nadelpistole", "", "", "", "", "S"),
 ("heat gun", "Hitzepistole", "", "", "", "", "S"),
 ("laser pistol / laser rifle", "Laserpistole / Lasergewehr", "", "", "", "", "laser pistol"),
 ("rocket pistol / rocket rifle", "Raketenpistole / Raketengewehr", "", "", "", "", "rocket pistol"),
 ("d.r. x-bow", "W.L.-Armbrust", "Wüstenarmbrust", "", "", "Desert-Runner-Armbrust", "S"),
 ("sonic stunner", "Schallbetäuber", "Schallstunner", "", "", "", "S"),
 ("grenade / grenade launcher", "Granate / Granatwerfer", "", "", "", "", "grenade"),
 ("stun / dazzle / chaff (grenade)", "Betäubungs- / Blend- / Düppel-", "Stun- / Blend- / Chaff-", "", "", "Granatentypen", "chaff"),
 ("plasma thrower", "Plasmawerfer", "", "", "", "", "S"),
 ("spacesuit / smartsuit", "Raumanzug / Smartsuit", "Raumanzug / Smartanzug", "", "", "", "spacesuit"),
 ("armor / heavy body armor / battle armor w/fields", "Panzerung / schwere Körperpanzerung / Kampfpanzerung m. Feld", "", "", "", "", "battle armor"),
 ("aerosol mist", "Aerosolnebel", "", "", "", "", "S"),
 ("demo charge / explosive", "Sprengladung / Sprengstoff", "", "", "", "", "demo charge"),
 ("ecm package", "ECM-Paket", "Störsender", "", "", "", "S"),
 ("protective goggles", "Schutzbrille", "", "", "", "", "goggles"),
 ("rope / belt", "Seil / Gürtel", "", "", "", "", "rope"),
 ("poison antidote", "Gegengift", "", "", "", "", "S"),
 ("behind cover", "in Deckung", "", "", "", "", "S"),
 ("autodoc", "Autodoc", "Medoautomat", "", "", "", "AUTODOC"),
 ("keycard / passcard", "Schlüsselkarte / Ausweiskarte", "", "", "", "", "KEYCARD"),
 ("Gravitol", "Gravitol", "", "", "", "Droge, Eigenname", "GRAVITOL"),
 ("gennie(s)", "Gennie(s)", "Genwesen", "", "", "Fachbegriff des XXVc-Universums", "GENNIE"),
 ("ECG", "ECG", "", "", "", "Bedeutung noch unklar (E.C. Gennie) – bleibt Kürzel", r"\bECGS?\b"),
 ("DL-Sat", "DL-Sat", "", "", "", "Doomsday-Laser-Satellit, Kürzel bleibt", r"DL-SAT"),
 ("Scout / Medium / Heavy Cruiser", "Aufklärer / Mittl. Kreuzer / Schw. Kreuzer", "Aufklärungskreuzer / Mittlerer Kreuzer / Schwerer Kreuzer", "", "", "Schiffsklassen", "Scout Cruiser"),
 ("beam / pumped laser", "Strahllaser / Pumplaser", "", "", "", "Schiffswaffen", "beam laser"),
 ("gyrocannon / K-Cannon", "Gyrokanone / K-Kanone", "", "", "", "Schiffswaffen", "gyrocannon"),
 ("(heavy) missile", "(schwere) Rakete", "(schwerer) Flugkörper", "", "", "", "heavy missile"),
 ("Light / Heavy Acceleration Gun", "Leichte / Schwere Beschl.-Kanone", "LBK / SBK", "", "", "lang; Breite im Spiel prüfen", "Light Acceleration Gun"),
 ("Schiffsnamen (Adder, Viper, Anaconda …)", "unverändert", "", "", "", "Eigennamen", "Anaconda"),
 ("D.R. WARRIOR", "W.L. KRIEGER", "D.R. KRIEGER", "", "15", "Monsterfeld 15 Zeichen", "M"),
 ("LL. WARRIOR / LL. TECHNICIAN", "T.L. KRIEGER / T.L. TECHNIKER", "", "", "15", "Lowlander = Tiefländer", "M:LL. WARRIOR"),
 ("DESERT APE", "WÜSTENAFFE", "", "", "15", "", "M"),
 ("SAND SQUID", "SANDKRAKE", "", "", "15", "", "M"),
 ("MER. LEADER / MER. TECHNICIAN / MER. WARRIOR", "MER. ANFÜHRER / MER. TECHNIKER / MER. KRIEGER", "", "", "15", "", "M:MER. LEADER"),
 ("RAM L.D./H.D./L.S./H.S. ROBOT, MER./VEN. H.S. ROBOT", "unverändert", "RAM L.D. ROBOTER", "", "15", "„ROBOT“ bleibt, „ROBOTER“ passt nicht in 15 Zeichen (RAM L.D. ROBOTER = 16); Kürzel bleiben", "M:RAM L.D. ROBOT"),
 ("SM. / LG. E.C. GENNIE", "KL. / GR. E.C. GENNIE", "", "", "15", "", "M:SM. E.C. GENNIE"),
 ("PIRATE WARRIOR / PIRATE LEADER", "PIRATENKRIEGER / PIRATENANFÜHRER", "", "", "15", "15 Zeichen genau", "M:PIRATE LEADER"),
 ("P. COMBAT ROBOT", "P. KAMPFROBOT", "", "", "15", "", "M"),
 ("RAM ASSASSIN", "RAM-ATTENTÄTER", "RAM-MEUCHLER", "", "15", "", "M"),
 ("RAM ASSAULT BOT / RAM COMBAT BOT", "RAM STURMBOT / RAM KAMPFBOT", "", "", "15", "", "M:RAM ASSAULT BOT"),
 ("RAM MAR/MER/VEN CGENNIE", "unverändert", "RAM MAR KGENNIE", "", "15", "C = Combat; Kürzel bleibt", "M:RAM MAR CGENNIE"),
 ("RAM TECHNICIAN / RAM WARRIOR", "RAM TECHNIKER / RAM KRIEGER", "", "", "15", "", "M:RAM WARRIOR"),
 ("HYPERCRAB / HYPERSCORP / HYPERSNAKE", "HYPERKRABBE / HYPERSKORPION / HYPERSCHLANGE", "", "", "15", "", "M:HYPERCRAB"),
 ("SPACE RAT", "RAUMRATTE", "", "", "15", "", "M"),
 ("TERRINE LEADER / TERRINE WARRIOR", "TERRINE-FÜHRER / TERRINE-KRIEGER", "", "", "15", "", "M:TERRINE WARRIOR"),
 ("SWAMP HORNET", "SUMPFHORNISSE", "", "", "15", "", "M"),
 ("ACID FROG", "SÄUREFROSCH", "", "", "15", "", "M"),
 ("HEXADILLO / URSADDER / ACIDICIUM", "unverändert", "", "", "15", "Fantasienamen", "M:HEXADILLO"),
 ("NEO WARRIOR", "NEO-KRIEGER", "", "", "15", "", "M"),
 ("STAGE 3 ECG", "ECG STUFE 3", "", "", "15", "", "M:STAGE 3  ECG"),
],
}


def load():
    dlg, sysd = [], []
    for f in sorted(glob.glob(os.path.join(EN, "ecl", "*.toml"))):
        dlg += [(e["id"], e["en"]) for e in tomllib.load(open(f, "rb"))["text"]]
    sysd = [(e["id"], e["en"]) for e in tomllib.load(open(os.path.join(EN, "systemtexte.toml"), "rb"))["text"]]
    return dlg, sysd


def fundort(orig, such, dlg, sysd):
    if such == "PREGEN":
        return "Spielstand-Vorlagen (dat_6BAAD)"
    if such and (such == "M" or such.startswith("M:")):
        n = orig if such == "M" else such[2:]
        return "Monsterliste (dat_9E77C)" + ("" if n in MONSTER else " ?")
    key = orig if such in ("S", None, "") else such
    s_ids = [i for i, t in sysd if t.strip().lower() == key.strip().lower()]
    if not s_ids:
        s_ids = [i for i, t in sysd if key.lower() in t.lower()]
    pat = such if such and (such.startswith("\\") or such == "DL-SAT") else r"\b" + re.escape(key.upper()) + r"\b"
    d_ids = [i for i, t in dlg if re.search(pat, t)]
    parts = []
    if s_ids:
        parts.append(" ".join(s_ids[:4]) + (" …" if len(s_ids) > 4 else ""))
    if d_ids:
        parts.append("Dialog %d× (%s)" % (len(d_ids), ", ".join(d_ids[:2])))
    return "; ".join(parts) or "–"


def main():
    # Schutz: nach der Abnahme (Spalte "Entscheidung" gefuellt) nie ueberschreiben
    for f in glob.glob(os.path.join(OUT, "*.csv")):
        rows = list(csv.reader(open(f, encoding="utf-8-sig"), delimiter=";"))
        if any(len(r) > 9 and r[9].strip() for r in rows[1:]):
            raise SystemExit("Abbruch: %s enthaelt bereits Entscheidungen (Glossar abgenommen)."
                             % os.path.basename(f))
    dlg, sysd = load()
    os.makedirs(OUT, exist_ok=True)
    head = ["Nr", "Original", "A (Empfehlung)", "B", "C", "Zeichen EN", "Zeichen A",
            "max. Zeichen", "Begründung", "Entscheidung", "Fundort"]
    total = 0
    for name, rows in LISTEN.items():
        path = os.path.join(OUT, "Glossar_%s.csv" % name)
        with open(path, "w", encoding="utf-8-sig", newline="") as f:
            w = csv.writer(f, delimiter=";")
            w.writerow(head)
            for n, r in enumerate(rows, 1):
                orig, a, b, c, mx, why = r[:6]
                such = r[6] if len(r) > 6 else None
                if mx and a != "unverändert":
                    for part in a.split(" / "):
                        if len(part) > int(mx):
                            raise SystemExit("Zu lang (%d > %s): %s" % (len(part), mx, part))
                w.writerow(["%s-%02d" % (name[0], n), orig, a, b, c, len(orig), len(a), mx, why, "",
                            fundort(orig, such, dlg, sysd)])
        total += len(rows)
        print("%-45s %3d Einträge" % (os.path.basename(path), len(rows)))
    print("Gesamt %d Einträge in %s" % (total, OUT))


if __name__ == "__main__":
    main()
