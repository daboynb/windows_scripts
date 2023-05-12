@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem ####################################################################################### 

IF EXIST "C:\Windows\backup_defender_services.reg" (
    goto :skip_backup
)

set backupFile=C:\Windows\backup_defender_services.reg

reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker %backupFile% /y
reg export HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend %backupFile% /y

:skip_backup
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker /f"
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /f"

PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v DisableEnhancedNotifications /t REG_DWORD /d 1 /f
PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v DisableNotifications /t REG_DWORD /d 1 /f

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 