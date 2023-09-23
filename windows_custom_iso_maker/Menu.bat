@echo off

cd /d %~dp0

:LANGMENU
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] ITALIAN 
echo.
echo [2] ENGLISH
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :ITA_MENU
IF /I '%MENU%'=='2' GOTO :EN_MENU
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :LANGMENU



:ITA_MENU
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 
echo.
echo [2] WINDOWS 10
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :ITA_11
IF /I '%MENU%'=='2' GOTO :win_10_ita
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :ITA_MENU

:ITA_11
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 UEFI ITALIANO 
echo    (Crea un'ISO di Windows 11 debloated in modalita' UEFI. Non include il bypass della RAM minima di 4 GB,
echo     tutti gli altri requisiti sono bypassati: CPU, TPM e SECUREBOOT)
echo.
echo [2] WINDOWS 11 LEGACY ITALIANO (necessita di due iso stock di windows, 10 e 11)
echo    (Crea un'ISO di Windows 11 debloated in modalita' legacy.
echo     Tutti i requisiti sono bypassati, compreso il bypass della RAM minima di 4 GB)
echo.
echo [3] WINDOWS 11 LEGACY ITALIANO (iso ibrida da scaricare obbligatoriamente)
echo    (Crea un'ISO di Windows 11 debloated in modalita' legacy.
echo     Tutti i requisiti sono bypassati, compreso il bypass della RAM minima di 4 GB)
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :win_11_uefi_ita
IF /I '%MENU%'=='2' GOTO :win_11_legacy_ita
IF /I '%MENU%'=='3' GOTO :win_11_legacy_ita_hybrid
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :ITA_11


:EN_MENU
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 
echo.
echo [2] WINDOWS 10
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :EN_11
IF /I '%MENU%'=='2' GOTO :win_10_en
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :EN_MENU

:EN_11
CLS
color 0A
SET MENU=
cls
echo *******************************
echo *   WINDOWS CUSTOM ISO MAKER  *
echo *******************************
echo.
echo [1] WINDOWS 11 UEFI ENGLISH
echo    (Create a debloated Windows 11 ISO in UEFI mode. This does not include the 4 GB minimum RAM bypass,
echo     all the other requisites are bypassed: CPU, TPM, and SECUREBOOT)
echo.
echo [2] WINDOWS 11 LEGACY ENGLISH (you need the stock ISO's of win10 and win11)
echo    (Create a debloated Windows 11 ISO in legacy mode.
echo     All the requisites are bypassed, including the 4 GB minimum RAM bypass)
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :win_11_uefi_en
IF /I '%MENU%'=='2' GOTO :win_11_legacy_en
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :EN_11

:win_11_uefi_ita
win11_custom_iso_italian_uefi\Runme.bat


:win_11_uefi_en
win11_custom_iso_en_uefi\Runme.bat


:win_11_legacy_ita
win11_custom_iso_italian_legacy\Runme.bat


:win_11_legacy_ita_hybrid
win11_custom_iso_italian_legacy_hybrid\Runme.bat

:win_11_legacy_en
win11_custom_iso_en_legacy\Runme.bat


:win_10_it
win10_custom_iso_italian\Runme.bat


:win_10_en
win10_custom_iso_en\Runme.bat
