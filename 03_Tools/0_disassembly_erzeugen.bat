@echo off
REM Erzeugt 02_Extracted\src\buckrogers.asm neu aus der Original-ROM (benoetigt: pip install capstone)
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% gen_asm.py
echo.
pause
