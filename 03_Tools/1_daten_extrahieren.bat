@echo off
REM Zieht die Datenbloecke aus der Original-ROM nach 02_Extracted\data
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% extract.py
echo.
pause
