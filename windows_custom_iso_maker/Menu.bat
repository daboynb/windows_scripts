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
IF /I '%MENU%'=='2' GOTO :win_10_it
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
echo [1] WINDOWS 11 ITALIANO 
echo    (Crea un'ISO di Windows 11 debloated, i requisiti sono bypassati: CPU, TPM, RAM e SECUREBOOT)
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :win_11_ita
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
echo [1] WINDOWS 11 ENGLISH
echo    (Create a debloated Windows 11 ISO , all the requisites are bypassed: CPU, TPM, Ram and SECUREBOOT)
echo.
echo [0] EXIT
echo.
echo *******************************
SET /P MENU=Type 1, 2 or 0 then press ENTER : 
IF /I '%MENU%'=='1' GOTO :win_11_en
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :EN_11

:win_11_ita
win11_custom_iso_italian\Runme.bat

:win_11_en
win11_custom_iso_en\Runme.bat

:win_10_it
win10_custom_iso_italian\Runme.bat

:win_10_en
win10_custom_iso_en\Runme.bat