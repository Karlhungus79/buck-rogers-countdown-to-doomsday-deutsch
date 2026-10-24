@echo off
REM Einmalig: verbindet den Projektordner (H:) mit dem GitHub-Repo.
REM Es werden KEINE Dateien im Projektordner geaendert oder geloescht:
REM nur der versteckte Ordner .git wird angelegt, danach zeigt "git status" Unterschiede.
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

if exist ".git" (
  echo Der Ordner ist schon mit einem Repo verbunden:
  git remote -v
  echo.
  echo Nichts zu tun. Zum Abgleichen: 9_repo_abgleich.bat
  pause
  exit /b 0
)

REM H: gehoert evtl. einem anderen Windows-Benutzer, dann verweigert git sonst die Arbeit
set SAFE=%CD:\=/%
git config --global --add safe.directory "%SAFE%"
git config --global core.quotepath false

git init
if errorlevel 1 goto fehler
git symbolic-ref HEAD refs/heads/main
git remote add origin %URL%
if errorlevel 1 goto fehler

echo.
echo Jetzt holt git den Stand von GitHub. Beim ersten Mal oeffnet sich ein
echo Anmeldefenster (Browser): bei GitHub anmelden und die Anmeldung erlauben.
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
echo Fertig. Bitte den Text oben kopieren oder fotografieren und Claude schicken.
pause
exit /b 0

:fehler
echo.
echo FEHLER: siehe Meldung oben. Der Ordner .git kann gefahrlos geloescht
echo und die Datei danach neu gestartet werden. Bitte Claude die Meldung zeigen.
pause
exit /b 1
