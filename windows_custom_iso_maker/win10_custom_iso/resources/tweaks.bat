@echo off
setlocal EnableDelayedExpansion

rem ###################################################################################################################################
rem Stock config for 10 and 11 (tweaks.bat)

rem set password never expire
wmic UserAccount set PasswordExpires=False

rem uninstall all useless apps
powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*|Microsoft.WindowsAppRuntime*''} | Remove-AppxPackage"

rem Check the system architecture
wmic os get osarchitecture 2>NUL | find "64-bit">NUL
IF "%ERRORLEVEL%"=="0" echo "64 bit!" && goto :64bit

wmic os get osarchitecture 2>NUL | find "32-bit">NUL
IF "%ERRORLEVEL%"=="0" echo "32 bit!" && goto :32bit

:64bit
rem uninstall onedrive 64 bit
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall"
goto :bing

:32bit
rem uninstall onedrive 32 bit
powershell -command "Get-Process OneDrive | Stop-Process -Force"
powershell -command "C:\Windows\System32\OneDriveSetup.exe /uninstall"

rem disable bing search on start
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f

rem show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

rem enable dark theme
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "EnableTransparency" /t REG_DWORD /d 1 /f
reg add "HKCU\Control Panel\Colors" /v "ImmersiveApplicationForeground" /t REG_SZ /d "255 255 255" /f

rem delete pinned on taskbar
del /f /s /q /a "%AppData%\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\*" > nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f

rem delete edge icon on desktop
del /s /q "C:\Users\%username%\Desktop\*.lnk" > nul 2>&1

rem Disable Edge Bar
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "WebWidgetAllowed" /t REG_DWORD /d 0 /f

rem disable contentdelivery and cloudcontent
set regKeyPath=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
set exportedRegFile=ContentDeliveryManager.reg

reg query "%regKeyPath%" >nul 2>&1
if %errorlevel% equ 0 (
    powershell -command "$regKeyPath='%regKeyPath%';$exportedRegFile='%exportedRegFile%';reg export $regKeyPath $exportedRegFile;((Get-Content $exportedRegFile) -replace '=dword:00000001','=dword:00000000') | Set-Content $exportedRegFile;reg import $exportedRegFile;Remove-Item $exportedRegFile"
) 

set regKeyPath=HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent
set exportedRegFile=CloudContent.reg

reg query "%regKeyPath%" >nul 2>&1
if %errorlevel% equ 0 (
    powershell -command "$regKeyPath='%regKeyPath%';$exportedRegFile='%exportedRegFile%';reg export $regKeyPath $exportedRegFile;((Get-Content $exportedRegFile) -replace '=dword:00000001','=dword:00000000') | Set-Content $exportedRegFile;reg import $exportedRegFile;Remove-Item $exportedRegFile"
)

rem fix indexing was turned off
sc config wsearch start=auto

rem disable telemetry
sc config DiagTrack start=disabled
sc config dmwappushservice start=disabled

rem add the script folder to the path
setx PATH "%PATH%;C:\Windows\scripts"

rem End of stock config for 10 and 11 (tweaks.bat)
rem ###################################################################################################################################

rem ###################################################################################################################################
rem Clean the ui

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

rem End of clean the ui
rem ###################################################################################################################################

rem unpin from start the tiles
powerShell -ExecutionPolicy Bypass -File "C:\Windows\scripts\unpin_start_tiles.ps1"

powershell write-host -fore Green "Done, rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 