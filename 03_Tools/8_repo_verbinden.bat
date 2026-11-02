@echo off
REM Verbindet den Projektordner mit dem GitHub-Repo. Einmalig, und nach einem Umzug
REM auf ein anderes Laufwerk oder einen anderen Windows-Benutzer noch einmal starten.
REM Es werden KEINE Dateien im Projektordner geaendert oder geloescht:
REM nur der versteckte Ordner .git wird angelegt bzw. aktualisiert.
setlocal
chcp 65001 >nul
cd /d "%~dp0.."
set URL=https://github.com/Karlhungus79/buck-rogers-countdown-to-doomsday-deutsch.git

echo Projektordner: %CD%
echo.

where git >nul 2>nul
if errorlevel 1 (
  echo FEHLER: git ist nicht installiert.
  echo Bitte installieren: https://git-scm.com/download/win
  echo Danach diese Datei noch einmal starten.
  pause
  exit /b 1
)

REM Neues Laufwerk oder anderer Besitzer: git verweigert sonst die Arbeit ("dubious ownership").
REM Der aktuelle Ordner wird als sicher eingetragen, falls er es noch nicht ist.
set SAFE=%CD:\=/%
git config --global --get-all safe.directory | findstr /x /c:"%SAFE%" >nul
if errorlevel 1 git config --global --add safe.directory "%SAFE%"
git config --global core.quotepath false

if exist ".git" goto vorhanden

git init
if errorlevel 1 goto fehler
git symbolic-ref HEAD refs/heads/main
git remote add origin %URL%
if errorlevel 1 goto fehler
goto holen

:vorhanden
echo Im Ordner gibt es schon ein Repo. Es wird neu mit GitHub verbunden:
git remote set-url origin %URL%
if errorlevel 1 goto fehler
git symbolic-ref HEAD refs/heads/main
git remote -v

:holen
echo.
echo Jetzt holt git den Stand von GitHub. Falls ein Anmeldefenster (Browser)
echo erscheint: bei GitHub anmelden und die Anmeldung erlauben.
echo Das Repo ist privat, ohne Anmeldung geht es nicht.
echo.
git fetch origin
if errorlevel 1 goto fehler

REM "reset" ohne --hard: Index und Verlauf werden auf GitHub gesetzt,
REM die Dateien im Ordner bleiben unveraendert.
git reset origin/main
if errorlevel 1 goto fehler
git branch --set-upstream-to=origin/main main

echo.
echo ===== Unterschiede zwischen Projektordner und GitHub =====
echo (leer = alles gleich; "M" = Datei hier anders; "D" = fehlt hier)
echo (ROM, Savestates, Bauten und englischer Text sind absichtlich nicht im Repo)
echo.
git status --short
echo ===== Ende =====
echo.
git log --oneline -3
echo.
echo Fertig. Bitte den Text oben kopieren oder fotografieren und Claude schicken.
pause
exit /b 0

:fehler
echo.
echo FEHLER: siehe Meldung oben. Der Ordner .git kann gefahrlos geloescht
echo und die Datei danach neu gestartet werden. Bitte Claude die Meldung zeigen.
pause
exit /b 1
