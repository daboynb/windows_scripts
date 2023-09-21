@echo off

cd /d %~dp0

:MAINMENU
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 UEFI ITALIAN
echo    (Crea un'ISO di Windows 11 debloated in modalita' UEFI.
echo     Non include il bypass della RAM minima di 4 GB,
echo     tutti gli altri requisiti sono bypassati: CPU, TPM e SECUREBOOT)
echo.
echo [2] WINDOWS 11 UEFI ENGLISH
echo    (Create a debloated Windows 11 ISO in legacy mode.
echo     This does not include the 4 GB minimum RAM bypass,
echo     all the other requisites are bypassed: CPU, TPM, and SECUREBOOT)
echo.
echo [3] WINDOWS 11 LEGACY ITALIAN
echo    (Crea un'ISO di Windows 11 debloated in modalita' legacy.
echo     Tutti i requisiti sono bypassati, compreso il bypass della RAM minima di 4 GB)
echo.
echo [4] WINDOWS 11 LEGACY ENGLISH
echo    (Create a debloated Windows 11 ISO in legacy mode.
echo     All the requisites are bypassed, including the 4 GB minimum RAM bypass)
echo.
echo [5] WINDOWS 10 ITA
echo    (Crea una ISO debloated si Windows 10)
echo.
echo [6] WINDOWS 10 EN
echo    (Create a debloated Windows 10 ISO)
echo.
echo [0] EXIT
echo.
SET /P MENU=Type 1, 2, 3, 4, 5 ,6 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :win_11_uefi_ita
IF /I '%MENU%'=='2' GOTO :win_11_uefi_en
IF /I '%MENU%'=='3' GOTO :win_11_legacy_ita
IF /I '%MENU%'=='4' GOTO :win_11_legacy_en
IF /I '%MENU%'=='5' GOTO :win_10_it
IF /I '%MENU%'=='6' GOTO :win_10_en
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

:win_11_uefi_ita
win11_custom_iso_italian_uefi\Runme.bat


:win_11_uefi_en
win11_custom_iso_en_uefi\Runme.bat


:win_11_legacy_ita
win11_custom_iso_italian_legacy\Runme.bat


:win_11_legacy_en
win11_custom_iso_en_legacy\Runme.bat


:win_10_it
win10_custom_iso_italian\Runme.bat


:win_10_en
win10_custom_iso_en\Runme.bat
