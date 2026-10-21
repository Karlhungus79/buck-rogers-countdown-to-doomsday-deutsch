@echo off
REM Erzeugt die Glossar-Vorschlagslisten in 05_German_Script\Glossar (braucht vorher 2_text_extrahieren.bat)
REM ACHTUNG: ueberschreibt die Listen samt Spalte Entscheidung - nur vor der Abnahme benutzen
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% glossar_vorschlag.py
echo.
pause
