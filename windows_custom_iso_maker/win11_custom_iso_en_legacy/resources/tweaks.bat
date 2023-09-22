@echo off
setlocal EnableDelayedExpansion

rem set password never expire
wmic UserAccount set PasswordExpires=False

rem uninstall all useless apps
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCamera|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"

rem uninstall onedrive
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\System32\OneDriveSetup.exe /uninstall"

rem show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

rem disable bing search on start
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f

rem enable dark theme
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Colors" /v ImmersiveApplicationForeground /t REG_SZ /d "255 255 255" /f

rem disable online tips 
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v AllowOnlineTips /t REG_DWORD /d 0 /f

rem restore the old menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

rem delete pinned on taskbar
del /f /s /q /a "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f

rem remove search icon in taskbar
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f

rem delete edge icon on desktop
del /s /q "C:\Users\%username%\Desktop\*.lnk" 

rem disable chat icon
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v ChatIcon /t REG_DWORD /d 3 /f

rem requirements bypass related
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v SV1 /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v SV2 /t REG_DWORD /d 0 /f
reg add HKLM\SYSTEM\Setup\MoSetup /v AllowUpgradesWithUnsupportedTPMOrCPU /t REG_DWORD /d 1 /f

rem disable contentdelivery
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent /v DisableWindowsConsumerFeatures /t REG_DWORD /d 1 /f

rem fix indexing was turned off
sc config wsearch start=auto

rem disable telemetry
sc config DiagTrack start=disabled
sc config dmwappushservice start=disabled

rem disable widgets
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f

rem disable defender 
IF EXIST "C:\Windows\nodefender.pref" (
    goto :disable_def
) ELSE (
    goto :skip_disable_def
)

:disable_def
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

:skip_disable_def
rem copy firefox installer to the desktop and remove edge
IF EXIST "C:\Windows\noedge.pref" (
move "C:\firefox_installer.exe" "C:\Users\%username%\Desktop"
goto :edge
) ELSE (
    goto :skip_edge
)

:edge
echo.
echo Killing Microsoft Edge...
echo.
taskkill /F /IM msedge.exe 2>nul

echo.
echo Killing Microsoft Edge...
echo.
taskkill /F /IM msedge.exe 2>nul

echo.
echo removing Microsoft Edge...
echo.
PowerRun.exe cmd.exe /c "rmdir "C:\Program Files (x86)\Microsoft\EdgeUpdate" /s /q" 1>nul 2>nul
PowerRun.exe cmd.exe /c "rmdir "C:\Program Files (x86)\Microsoft\Edge" /s /q" 1>nul 2>nul
PowerRun.exe powershell.exe -Command "Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage; $filePath = 'C:\Windows\edge1.txt'; $textContent = 'Removal completed successfully.'; Set-Content -Path $filePath -Value $textContent" 1>nul 2>nul

echo.
echo Finding the installed version of Microsoft Edge Legacy/UWP
echo.
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" ^| findstr "Microsoft-Windows-Internet-Browser-Package" ^| findstr "~~"') do (
    set "edge_legacy_package_version=%%i"
)

echo.
echo Deleting the owners of the Edge Legacy package in the registry
echo.
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%\Owners" /va /f 1>nul 2>nul

echo.
echo Removing the Edge Legacy package using DISM
echo.
dism /online /Remove-Package /PackageName:%edge_legacy_package_version% 1>nul 2>nul

echo.
echo Adding registry key to prevent Edge updates
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f 1>nul 2>nul

echo.
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" 1>nul 2>nul

:check
IF EXIST "C:\Windows\edge1.txt" (
    powershell write-host -fore Green "Done"
) ELSE (
    goto :check
)

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 

:skip_edge
powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 