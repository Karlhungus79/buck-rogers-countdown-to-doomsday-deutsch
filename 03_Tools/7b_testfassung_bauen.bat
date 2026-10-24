@echo off
REM Testfassung (nur zum Testen, nicht veroeffentlichen): deutsche Fassung + Entwickler-Jumper
REM Ergebnis: 07_Output_ROM\<Zeitstempel>_test\ und Testdatei
REM           07_Output_ROM\Buck Rogers - Countdown to Doomsday (test).md
REM Beschreibung: claude\Testfassung.md
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
%PY% grafik_deutsch.py
if errorlevel 1 (
  echo.
  echo Abbruch: Fehler beim Erzeugen der deutschen Grafiken.
  pause
  exit /b 1
)
echo.
%PY% build.py --test
echo.
pause
