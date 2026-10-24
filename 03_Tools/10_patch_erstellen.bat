@echo off
REM Erstellt den Veroeffentlichungs-Patch (BPS + IPS) und die Readmes gegen die Original-ROM.
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% patch_erstellen.py
echo.
pause
