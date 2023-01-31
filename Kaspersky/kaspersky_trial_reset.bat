@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo "DISABLE THE SELF PROTECTION AND EXIT FROM KASPERSKY, OTHERWISE IT WON'T WORK!"
echo "THIS TRIAL RESET WORKS WITH: "
echo "kaspersky anti virus 21.3"
echo "kaspersky internet security 21.3"
echo "kaspersky total security 21.3"
pause

rem Check if system is 64 bit
wmic os get osarchitecture 2>NUL | find "64-bit">NUL
if "%ERRORLEVEL%"=="0" color 0A && echo "64 bit!" 
if "%ERRORLEVEL%"=="1" color 0C && echo "Not a 64 bit system!" && pause && exit

rem Check if kaspersky is off
tasklist /fi "ImageName eq avp.exe" /fo csv 2>NUL | find /I "avp.exe">NUL
if "%ERRORLEVEL%"=="0" color 0C && echo "kaspersky is running, EXITING!" && pause && exit
if "%ERRORLEVEL%"=="1" color 0A && echo "kaspersky is not running, OK!"

rem Check if Self Protection is on or off
reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\settings /v EnableSelfProtection | find "0x1">NUL
if "%ERRORLEVEL%"=="0" color 0C && echo "SelfProtection is ON, EXITING!" && pause && exit
if "%ERRORLEVEL%"=="1" color 0A && echo "SelfProtection is OFF, OK!" 

rem Delete files
del /f "C:\ProgramData\Kaspersky Lab\AVP21.3\Data\stor*.bin"
del /f "C:\ProgramData\Kaspersky Lab\AVP21.3\Bases\Cache\cat_engine*"

rem Delete registry keys
reg delete HKLM\SOFTWARE\Microsoft\SystemCertificates\SPC /f 
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\Data\LicCache /f 
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\Data\LicensingActivationErrorStorageLogic /f 
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\Data\UPAO /f 
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\LicStrg /f 

rem Add registry keys
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\Data /v UseKSN /f /t REG_DWORD /d 1 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v ShowActivateTrialOption /f /t REG_SZ /d "1" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\settings /v Ins_InitMode /f /t REG_DWORD /d 1 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\settings /v EnableSelfProtection /f /t REG_DWORD /d 1 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v ActivationCode_kfa /f /t REG_SZ /d "" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v TrialActCode_kav /f /t REG_SZ /d "" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v TrialActCode_kis /f /t REG_SZ /d "" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v TrialActCode_pure /f /t REG_SZ /d "" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\environment /v TrialActCode_saas /f /t REG_SZ /d "" 
reg add HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\KasperskyLab\AVP21.3\settings /v Kaspersky_ID /f /t REG_SZ /d "" 

rem Ask to reboot the machine
echo "You need to reboot to apply"
choice /c yn /m "Reboot now?"
if %errorlevel% equ 1 shutdown /r /t 00
pause && exit
