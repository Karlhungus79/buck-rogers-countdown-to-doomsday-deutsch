import tomllib,sys
R='/home/claude/buck-rogers-countdown-to-doomsday-german-translation/'
m=sys.argv[1]
de={t['id']:t['de'] for t in tomllib.load(open(R+'05_German_Script/ecl/%s.toml'%m,'rb'))['text']}
for t in tomllib.load(open(R+'04_English_Script/ecl/%s.toml'%m,'rb'))['text']:
    b=','.join(t.get('befehl',[]))
    if de.get(t['id']): continue
    print('%s %s|%s'%(t['id'][5:],b[:2],t['en'].replace('\n','\\n')))
