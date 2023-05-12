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

taskkill /f /im explorer.exe >nul
taskkill /f /im smartscreen.exe >nul
taskkill /f /im SecurityHealthSystray.exe >nul
taskkill /f /im SecurityHealthHost.exe >nul
taskkill /f /im SecurityHealthService.exe >nul
taskkill /f /im SecurityHealthHost.exe >nul
taskkill /f /im DWWIN.EXE >nul
taskkill /f /im CompatTelRunner.exe >nul
taskkill /f /im GameBarPresenceWriter.exe >nul
taskkill /f /im DeviceCensus.exe >nul

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

for %%d in ("C:\Windows\WinSxS\FileMaps\wow64_windows-defender*.manifest" "C:\Windows\WinSxS\FileMaps\x86_windows-defender*.manifest" "C:\Windows\WinSxS\FileMaps\amd64_windows-defender*.manifest" "C:\Windows\System32\SecurityAndMaintenance_Error.png" "C:\Windows\System32\SecurityAndMaintenance.png" "C:\Windows\System32\SecurityHealthSystray.exe" "C:\Windows\System32\SecurityHealthService.exe" "C:\Windows\System32\SecurityHealthHost.exe" "C:\Windows\System32\drivers\SgrmAgent.sys" "C:\Windows\System32\drivers\WdDevFlt.sys" "C:\Windows\System32\drivers\WdBoot.sys" "C:\Windows\System32\drivers\WdFilter.sys" "C:\Windows\System32\wscsvc.dll" "C:\Windows\System32\drivers\WdNisDrv.sys" "C:\Windows\System32\wscsvc.dll" "C:\Windows\System32\wscproxystub.dll" "C:\Windows\System32\wscisvif.dll" "C:\Windows\System32\SecurityHealthProxyStub.dll" "C:\Windows\System32\smartscreen.dll" "C:\Windows\SysWOW64\smartscreen.dll" "C:\Windows\System32\smartscreen.exe" "C:\Windows\SysWOW64\smartscreen.exe" "C:\Windows\System32\DWWIN.EXE" "C:\Windows\SysWOW64\smartscreenps.dll" "C:\Windows\System32\smartscreenps.dll" "C:\Windows\System32\SecurityHealthCore.dll" "C:\Windows\System32\SecurityHealthSsoUdk.dll" "C:\Windows\System32\SecurityHealthUdk.dll" "C:\Windows\System32\SecurityHealthAgent.dll" "C:\Windows\System32\wscapi.dll" "C:\Windows\System32\wscadminui.exe" "C:\Windows\SysWOW64\GameBarPresenceWriter.exe" "C:\Windows\System32\GameBarPresenceWriter.exe" "C:\Windows\SysWOW64\DeviceCensus.exe" "C:\Windows\SysWOW64\CompatTelRunner.exe" "C:\Windows\system32\drivers\msseccore.sys" "C:\Windows\System32\smartscreen.exe") DO PowerRun cmd.exe /c del /f "%%d"
for %%d in ("C:\Windows\WinSxS\amd64_security-octagon*" "C:\Windows\WinSxS\x86_windows-defender*" "C:\Windows\WinSxS\wow64_windows-defender*" "C:\Windows\WinSxS\amd64_windows-defender*" "C:\Windows\SystemApps\Microsoft.Windows.AppRep.ChxApp_cw5n1h2txyewy" "C:\ProgramData\Microsoft\Windows Defender" "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection" "C:\Program Files (x86)\Windows Defender Advanced Threat Protection" "C:\Program Files\Windows Defender Advanced Threat Protection" "C:\ProgramData\Microsoft\Windows Security Health" "C:\ProgramData\Microsoft\Storage Health" "C:\WINDOWS\System32\drivers\wd" "C:\Program Files (x86)\Windows Defender" "C:\Program Files\Windows Defender" "C:\Windows\System32\SecurityHealth" "C:\Windows\System32\WebThreatDefSvc" "C:\Windows\System32\Sgrm" "C:\Windows\Containers" "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\DefenderPerformance" "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\Defender" "C:\Windows\System32\Tasks_Migrated\Microsoft\Windows\Windows Defender" "C:\Windows\System32\Tasks\Microsoft\Windows\Windows Defender" "C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\Defender" "C:\Windows\System32\HealthAttestationClient" "C:\Windows\GameBarPresenceWriter" "C:\Windows\bcastdvr") do PowerRun cmd.exe /c rmdir "%%~d" /s /q

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 