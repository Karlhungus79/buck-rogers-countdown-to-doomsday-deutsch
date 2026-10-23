@echo off
REM Legt fehlende deutsche Textdateien 05_German_Script\ecl\Mxxx.toml an (vorhandene bleiben unveraendert)
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% deutsch_vorlage.py
echo.
pause
