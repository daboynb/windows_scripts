@echo off
setlocal EnableDelayedExpansion

rem set password never expire
wmic UserAccount set PasswordExpires=False

rem uninstall all useless apps
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"

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

rem copy debloater shortcut
copy "C:\Windows\debloat_Windows_Italia.lnk" "C:\Users\%username%\Desktop"

rem stuff from paki
bcdedit /set {current} bootmenupolicy Legacy

rem disable widgets
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f

rem disable defender 
IF EXIST "C:\Windows\nodefender.pref" (
    goto :disable_def
) ELSE (
    goto :skip_disable_def
)

:disable_def
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f"
PowerRun.exe cmd.exe /c "reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f"

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

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f

PowerRun.exe cmd.exe /c "rmdir /s / q "C:\Program Files (x86)\Microsoft\Edge""
PowerRun.exe cmd.exe /c "rmdir /s / q "C:\Program Files\Microsoft\Edge""

del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"2>nul
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk"2>nul

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 

:skip_edge
powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 