@echo off
REM Zieht den englischen Referenztext aus der Original-ROM nach 04_English_Script
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% text_extrahieren.py
echo.
pause
