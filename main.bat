@echo off

cd /d %~dp0

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

:LANGMENU
CLS
SET MENU=
cls
echo *******************************
echo *   WINDOWS AIO               *
echo *******************************
echo.
echo [1] adb_fastboot drivers
echo.
echo [2] add_store_windows_10_11
echo.
echo [3] Clean windows update files
echo
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :adb_fastboot
IF /I '%MENU%'=='2' GOTO :add_store_windows_10_11
IF /I '%MENU%'=='2' GOTO :clean_windows_update
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :LANGMENU

:win_1adb_fastboot1
start "adb_fastboot\adb_fastboot.bat"

:add_store_windows_10_11
start "add_store_windows_10_11\add_store_windows_10_11.bat"

:clean_windows_update_files
start "Clean windows update files\clean_win_update.bat"