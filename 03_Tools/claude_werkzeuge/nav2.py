import sys; sys.path.insert(0,'/home/claude/buck-rogers-countdown-to-doomsday-deutsch/03_Tools/emu_test')
from mdemu import MD_Emu
R='/home/claude/buck-rogers-countdown-to-doomsday-deutsch/07_Output_ROM/'
rom=R+sys.argv[1]
ram=open('/home/claude/buck-rogers-countdown-to-doomsday-deutsch/08_Savestates/Buck Rogers - Countdown to Doomsday (test).ram','rb').read()
sr=bytearray(0x10000)
for i,b in enumerate(ram): sr[2*i+1]=b
e=MD_Emu(rom, sram=bytes(sr))
if sys.argv[2]!='-': e.load_state(open(sys.argv[2],'rb').read())
for tok in sys.argv[3].split():
    if tok.startswith('w'): e.run(int(tok[1:]))
    else: e.press(tok.upper(),hold=4,after=20)
e.run(30); e.shot(sys.argv[4]+'.png'); open(sys.argv[4]+'.bin','wb').write(e.save_state())
