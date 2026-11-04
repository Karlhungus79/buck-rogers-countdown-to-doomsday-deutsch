# pruefe.py Mxxx : zeigt deutsche Texte mit zu vielen Zeilen (Regel wie text_einsetzen)
import sys,tomllib
R='/home/claude/buck-rogers-countdown-to-doomsday-german-translation/'
sys.path.insert(0,R+'03_Tools')
import text_einsetzen as te, zeichensatz as zs
for m in sys.argv[1:]:
    en={t['id']:t['en'] for t in tomllib.load(open(R+'04_English_Script/ecl/%s.toml'%m,'rb'))['text']}
    for t in tomllib.load(open(R+'05_German_Script/ecl/%s.toml'%m,'rb'))['text']:
        d=t['de']
        if not d or not set(t.get('befehl',[]))&{'PRINT','PRINTCLEAR'}: continue
        try: b=zs.kodieren(d)
        except Exception as ex: print(t['id'],'ZEICHEN',ex); continue
        zl=len(te.umbrechen(zs.anzeigen(b))); ze=len(te.umbrechen(en[t['id']]))
        if zl>max(4,ze): print('%s %d>%d %s'%(t['id'],zl,max(4,ze),d))
