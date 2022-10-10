@ echo off

ECHO OFF
CLS
:MENU
ECHO.
ECHO 1 - Bypass windows 11 rquirements
ECHO 2 - Bypass network requirements (not working for build 22567 and higher)
ECHO 3 - Bypass network requirements (working for all)
ECHO.
SET /P M=Type 1, 2, or 3 then press ENTER:
IF %M%==1 GOTO BYPASS
IF %M%==2 GOTO NETWORK
IF %M%==3 GOTO NETWORK2

:BYPASS

echo "Adding regedit values"
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /f /t REG_DWORD /d 1 > nul
echo "Completed"
pause
exit

:NETWORK

echo "This need to be used when the setup asks for a connection"
taskkill /f /im oobenetworkconnectionflow.exe
echo "Completed"
pause
exit

:NETWORK2
echo "This need to be used when the initial setup starts"
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /v BypassNRO /t REG_DWORD /d 1 /f
shutdown /r /t 0
exit
