@echo off
REM Vollbau deutsche Fassung: Texte einsetzen + pruefen, dann ROM bauen (2 MB)
REM Ergebnis: 07_Output_ROM\<Zeitstempel>_deutsch\ und Testdatei
REM           07_Output_ROM\Buck Rogers - Countdown to Doomsday (gebaut).md
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% text_einsetzen.py
if errorlevel 1 (
  echo.
  echo Abbruch: Fehler in den Texten, siehe Pruefbericht.
  pause
  exit /b 1
)
echo.
%PY% build.py --deutsch
echo.
pause
