@echo off
REM Prueft die deutschen Texte und erzeugt 02_Extracted\deutsch\ (Texte, Schrift, Pruefbericht)
setlocal
chcp 65001 >nul
cd /d "%~dp0"
set PY=python
where py >nul 2>nul && set PY=py -3
%PY% text_einsetzen.py
echo.
pause
