@echo off
setlocal EnableDelayedExpansion

rem uninstall all useless apps
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"

rem Hide Meet Now icon in the taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t "REG_DWORD" /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "HideSCAMeetNow" /t "REG_DWORD" /d 1 /f

rem Remove Search Icon from Windows 10 Taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

rem Remove Task View from Windows 10 Taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowTaskViewButton" /t REG_DWORD /d 0 /f

rem disable interest and news
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" /v "EnableFeeds" /t "REG_DWORD" /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarViewMode" /t "REG_DWORD" /d 2 /f

rem show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

rem Check the system architecture
wmic os get osarchitecture 2>NUL | find "64-bit">NUL
if "%ERRORLEVEL%"=="0" echo "64 bit!" && goto :64bit

wmic os get osarchitecture 2>NUL | find "32-bit">NUL
if "%ERRORLEVEL%"=="0" echo "32 bit!" && goto :32bit

:64bit
rem uninstall onedrive 64 bit
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall"
goto :bing

:32bit
rem uninstall onedrive 32 bit
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\System32\OneDriveSetup.exe /uninstall"

:bing
rem disable bing search on start
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Search /v BingSearchEnabled /t REG_DWORD /d 0 /f

rem enable dark theme
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v EnableTransparency /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Colors" /v ImmersiveApplicationForeground /t REG_SZ /d "255 255 255" /f

rem delete pinned on taskbar
del /f /s /q /a "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*"
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f

rem delete edge icon on desktop
del /s /q "C:\Users\%username%\Desktop\*.lnk" 

rem copy debloater shortcut
copy "C:\Windows\debloat_Windows_Italia.lnk" "C:\Users\%username%\Desktop"

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

rem unpin from start the tiles
powerShell -ExecutionPolicy Bypass -File "C:\Windows\unpin_start_tiles.ps1"

rem stuff from paki
bcdedit /set {current} bootmenupolicy Legacy

rem disable defender 
IF EXIST "C:\Windows\PowerRun.exe" (
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

        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\wscsvc /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisDrv /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdNisSvc /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdBoot /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmAgent /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SgrmBroker /f">NUL
        C:\Windows\PowerRun.exe cmd.exe /c "reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend /f">NUL

        C:\Windows\PowerRun.exe cmd.exe /c reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
        C:\Windows\PowerRun.exe cmd.exe /k "cd C:\Windows\System32 && ren smartscreen.exe smartscreendisabled.exe"
        start explorer.exe
)

rem copy firefox installer to the desktop and remove edge using Edge removal script by AveYo 
IF EXIST "C:\firefox_installer.exe" (
    move "C:\firefox_installer.exe" "C:\Users\%username%\Desktop"
    C:\Windows\edge_removal.bat
)

IF NOT EXIST "C:\Windows\edge_removal.bat" (
    powershell write-host -fore Green "Done, rebooting in 5 seconds"
    timeout 5
    shutdown /r /t 00 
)