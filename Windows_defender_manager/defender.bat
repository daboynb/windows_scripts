@echo off

cd /d "%~dp0"
rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS DEFENDER MANAGER
echo.
ECHO [1] Disable defender
ECHO [2] enable defender
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :disable
IF /I '%MENU%'=='2' GOTO :enable
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

rem ####################################################################################### 

:disable

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

rem Disable Windows Defender Services and Windows Security Center
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MsSecCore /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdFiltrer /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker /v Start /t REG_DWORD /d 4 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /v Start /t REG_DWORD /d 4 /f">NUL

rem Disable Windows Defender WMI Logger
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger /v Start /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger /v Status /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v Start /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v Status /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v EnableSecurityProvider /t REG_DWORD /d 0 /f">NUL

rem Disable Windows Security Health Service Startup Entry
PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v SecurityHealth /f">NUL

rem Disable Windows Defender Tamper Protection
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v MpPlatformKillbitsFromEngine /t REG_BINARY /d 0000000000000000 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v TamperProtectionSource /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v MpCapability /t REG_BINARY /d 000000000000000000 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v TamperProtection /t REG_DWORD /d 0 /f">NUL

rem Disable Windows Defender antispyware and smartscreen
PowerRun.exe cmd.exe /c "for /r "C:\ProgramData\Microsoft\Windows Defender\Platform" %I in (MsMpEng.exe) do @if exist "%I" ren "%I" MsMpEng.exe.bak"
PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
PowerRun.exe cmd.exe /c "cd C:\Windows\System32 && ren smartscreen.exe smartscreen.exe.bak"
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

rem Enable Windows Defender Services and Windows Security Center
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MsSecCore /v Start /t REG_DWORD /d 3 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc /v Start /t REG_DWORD /d 2 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /v Start /t REG_DWORD /d 3 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /v Start /t REG_DWORD /d 3 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdFiltrer /v Start /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /v Start /t REG_DWORD /d 2 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService /v Start /t REG_DWORD /d 2 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent /v Start /t REG_DWORD /d 2 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker /v Start /t REG_DWORD /d 2 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /v Start /t REG_DWORD /d 2 /f">NUL

rem Enable Windows Defender WMI Logger
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger /v Start /t REG_DWORD /d 1 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderApiLogger /v Status /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v Start /t REG_DWORD /d 1 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v Status /t REG_DWORD /d 0 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\DefenderAuditLogger /v EnableSecurityProvider /t REG_DWORD /d 1 /f">NUL

rem Enable Windows Security Health Service Startup Entry
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /d "%windir%\system32\SecurityHealthSystray.exe" /t REG_SZ /f

rem Disable Windows Defender Tamper Protection
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v TamperProtection /t REG_DWORD /d 1 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v MpPlatformKillbitsFromEngine /t REG_BINARY /d 0000000000000001 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v TamperProtectionSource /t REG_DWORD /d 5 /f">NUL
PowerRun.exe cmd.exe /c "reg add HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Features /v MpCapability /t REG_BINARY /d ff01000000000000 /f">NUL

rem Enable Windows Defender antispyware and smartscreen
PowerRun.exe cmd.exe /c "for /r "C:\ProgramData\Microsoft\Windows Defender\Platform" %I in (MsMpEng.exe.bak) do @if exist "%I" ren "%I" MsMpEng.exe"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
PowerRun.exe cmd.exe /c "cd C:\Windows\System32 && ren smartscreen.exe.bak smartscreen.exe"
start explorer.exe

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 