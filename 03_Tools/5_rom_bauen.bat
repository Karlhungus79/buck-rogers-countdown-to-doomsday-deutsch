@echo off
REM Baut die ROM aus dem Disassembly nach 07_Output_ROM\<Zeitstempel>
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% build.py
echo.
pause
