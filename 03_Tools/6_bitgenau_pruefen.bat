@echo off
REM Baut die ROM und vergleicht sie mit der Original-ROM
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% build.py --pruefen
echo.
pause
