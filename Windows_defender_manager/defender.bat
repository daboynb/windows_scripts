@echo off

cd /d "%~dp0"
rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS DEFENDER MANAGER
echo.
ECHO [1] Disable defender
ECHO [2] enable defender
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2, 3, or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :disable
IF /I '%MENU%'=='2' GOTO :enable
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

rem ####################################################################################### 

:disable

IF EXIST "C:\Windows\backup_reg" (
    goto :skip_backup
)

mkdir C:\Windows\backup_reg
set backupFolder=C:\Windows\backup_reg

reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc %backupFolder%\wscsvc.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv %backupFolder%\WdNisDrv.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc %backupFolder%\WdNisSvc.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot %backupFolder%\WdBoot.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService %backupFolder%\SecurityHealthService.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent %backupFolder%\SgrmAgent.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker %backupFolder%\SgrmBroker.reg /y>NUL
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend %backupFolder%\WinDefend.reg /y>NUL

:skip_backup

taskkill /f /im explorer.exe >nul 2>nul
taskkill /f /im smartscreen.exe >nul 2>nul
taskkill /f /im SecurityHealthSystray.exe >nul 2>nul
taskkill /f /im SecurityHealthHost.exe >nul 2>nul
taskkill /f /im SecurityHealthService.exe >nul 2>nul
taskkill /f /im SecurityHealthHost.exe >nul 2>nul
taskkill /f /im DWWIN.EXE >nul 2>nul
taskkill /f /im CompatTelRunner.exe >nul 2>nul
taskkill /f /im GameBarPresenceWriter.exe >nul 2>nul
taskkill /f /im DeviceCensus.exe >nul 2>nul

PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker /f">NUL
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /f">NUL

PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
PowerRun.exe cmd.exe /k "cd C:\Windows\System32 && ren smartscreen.exe smartscreendisabled.exe"
start explorer.exe

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 

:enable

taskkill /f /im explorer.exe >nul 2>nul
taskkill /f /im smartscreen.exe >nul 2>nul
taskkill /f /im SecurityHealthSystray.exe >nul 2>nul
taskkill /f /im SecurityHealthHost.exe >nul 2>nul
taskkill /f /im SecurityHealthService.exe >nul 2>nul
taskkill /f /im SecurityHealthHost.exe >nul 2>nul
taskkill /f /im DWWIN.EXE >nul 2>nul
taskkill /f /im CompatTelRunner.exe >nul 2>nul
taskkill /f /im GameBarPresenceWriter.exe >nul 2>nul
taskkill /f /im DeviceCensus.exe >nul 2>nul

reg import C:\Windows\backup_reg\SecurityHealthService.reg
reg import C:\Windows\backup_reg\SgrmAgent.reg
reg import C:\Windows\backup_reg\SgrmBroker.reg
reg import C:\Windows\backup_reg\WdBoot.reg
reg import C:\Windows\backup_reg\WdNisDrv.reg
reg import C:\Windows\backup_reg\WdNisSvc.reg
reg import C:\Windows\backup_reg\WinDefend.reg
reg import C:\Windows\backup_reg\wscsvc.reg

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
PowerRun.exe cmd.exe /k "cd C:\Windows\System32 && ren smartscreendisabled.exe smartscreen.exe"

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 