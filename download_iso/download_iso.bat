@echo off

cd /d "%~dp0"

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul
powerShell -Command "Write-Host 'Firefox provided by https://sourceforge.net/projects/portableapps' -ForegroundColor Green; exit" && timeout 04>nul

:MAINMENU
CLS
SET MENU=
echo.
ECHO [1] Download win 10 
ECHO [2] Download win 11
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :win10
IF /I '%MENU%'=='2' GOTO :win11
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

:win10
7z.exe x *.zip* -oPortable
Portable\FirefoxPortable.exe https://www.microsoft.com/en-us/software-download/windows10ISO
goto clear

:win11
7z.exe x *.zip* -oPortable
Portable\FirefoxPortable.exe https://www.microsoft.com/en-us/software-download/windows11

:clear
rmdir "Portable" /s /q