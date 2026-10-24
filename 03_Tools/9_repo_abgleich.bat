@echo off
REM Gleicht den Projektordner (H:) mit GitHub ab. Dateien im Ordner werden NICHT veraendert.
REM Zeigt, ob Projektordner und GitHub-Stand uebereinstimmen.
setlocal
chcp 65001 >nul
cd /d "%~dp0.."

if not exist ".git" (
  echo Ordner ist noch nicht verbunden. Bitte zuerst 8_repo_verbinden.bat starten.
  pause
  exit /b 1
)

git fetch origin
if errorlevel 1 (
  echo FEHLER beim Holen von GitHub, siehe Meldung oben.
  pause
  exit /b 1
)
git reset origin/main
echo.
echo ===== Unterschiede zwischen Projektordner und GitHub =====
echo (leer = alles gleich)
echo.
git status --short
echo ===== Ende =====
echo.
git log --oneline -5
echo.
pause
