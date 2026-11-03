#!/bin/sh
# git commit+push und Dateiliste fuer F: (Dateien seit Commit $1)
cd /home/claude/buck-rogers-countdown-to-doomsday-deutsch || exit 1
git add -A && git commit -q -m "$2

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Claude-Session: https://claude.ai/code/session_01NnA977RTikovriEcQLHD8U" && git push -q
git log --oneline -1
O=/mnt/user-data/outputs/s && rm -rf $O && mkdir -p $O
for f in $(git diff --name-only $1 HEAD) $3; do [ -f "$f" ] && mkdir -p "$O/$(dirname "$f")" && cp "$f" "$O/$f"; done
cd $O && python3 -c "
import json,os
H='F:\\\\Buck Rogers Disassembly\\\\'
L=[{'stagedPath':'/mnt/user-data/outputs/s/'+os.path.join(r,x)[2:],'devicePath':H+os.path.join(r,x)[2:].replace('/','\\\\')} for r,d,f in os.walk('.') for x in f]
print(json.dumps(L,ensure_ascii=False))"
