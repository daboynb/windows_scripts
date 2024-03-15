@echo off

cd /d %~dp0

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

:LANGMENU
CLS
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 
echo    (Create a debloated Windows 11 ISO , all the requisites are bypassed: CPU, TPM, Ram and SECUREBOOT)
echo.
echo [2] WINDOWS 10
echo    (Create a debloated Windows 10 ISO)
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :win_11
IF /I '%MENU%'=='2' GOTO :win_10
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :LANGMENU

:win_11
win11_custom_iso\create.bat

:win_10
win10_custom_iso\create.bat