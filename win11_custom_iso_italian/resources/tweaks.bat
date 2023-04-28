@echo off

rem uninstall all useless apps
powershell -command "Write-Host -fore Green 'Tweaking, press enter to start'; pause; $ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} | Remove-AppxPackage"

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

rem copy firefox installer to the desktop and remove edge using Edge removal script by AveYo 
IF EXIST "C:\firefox_installer.exe" (
    move "C:\firefox_installer.exe" "C:\Users\%username%\Desktop"
    C:\Windows\edge_removal.bat
)
