# setze.py Mxxx datei : Zeilen "nnn|Deutsch" -> de-Felder
import sys,re,json
R='/home/claude/buck-rogers-countdown-to-doomsday-deutsch/05_German_Script/ecl/'
m=sys.argv[1]; p=R+m+'.toml'
L=open(p,encoding='utf-8').read().split('\n')
idx={}
for i,l in enumerate(L):
    mo=re.match(r'id = "(\w+)"$',l)
    if mo: cur=mo.group(1)
    if l.startswith('de = '): idx[cur]=i
n=0
for l in open(sys.argv[2],encoding='utf-8'):
    l=l.rstrip('\n')
    if not l.strip() or l.startswith('#'): continue
    k,v=l.split('|',1)
    i='%s_%s'%(m,k.strip().zfill(3))
    v=v.replace('\\n','\n')
    assert '"' not in v,(i,v)
    L[idx[i]]='de = '+json.dumps(v,ensure_ascii=False); n+=1
open(p,'w',encoding='utf-8').write('\n'.join(L)); print(m,n,'gesetzt')
