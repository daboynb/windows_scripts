@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

rem Check the system architecture
wmic os get osarchitecture 2>NUL | find "64-bit">NUL
IF "%ERRORLEVEL%"=="0" echo "64 bit!" && goto :64bit

wmic os get osarchitecture 2>NUL | find "32-bit">NUL
IF "%ERRORLEVEL%"=="0" echo "32 bit!" && goto :32bit

:64bit
rem Uninstall onedrive 64 bit
powershell -command "if (Get-Process -Name OneDrive -ErrorAction SilentlyContinue) { Stop-Process -Name OneDrive -Force }"
powershell -command "if (Test-Path 'C:\Windows\SysWOW64\OneDriveSetup.exe') { C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall }"

:32bit
rem Uninstall onedrive 32 bit
powershell -command "if (Get-Process -Name OneDrive -ErrorAction SilentlyContinue) { Stop-Process -Name OneDrive -Force }"
powershell -command "if (Test-Path 'C:\Windows\System32\OneDriveSetup.exe') { C:\Windows\System32\OneDriveSetup.exe /uninstall }"

rem Debloat
whoami /groups | findstr /C:"S-1-5-32-544" >nul
if %errorlevel% equ 1 (
    echo "The current user is not a member of the Administrators group."
    echo "Adding the user to the Administrators group..."
    net localgroup Administrators "%USERNAME%" /add
    if %errorlevel% equ 0 (
        echo "User added to the Administrators group successfully."
        echo "Please reboot to apply the changes and then relaunch the script"
        pause
        exit
    ) else (
        echo "Failed to add user to the Administrators group."
        pause
        exit /b 1
    )
) else (
    echo "Good! The current user is a member of the Administrators group."
)

rem Detect the windows version
wmic os get Caption 2>NUL | find "10">NUL
IF "%ERRORLEVEL%"=="0" echo "Win 10!" && goto :10

wmic os get Caption 2>NUL | find "11">NUL
IF "%ERRORLEVEL%"=="0" echo "Win 11!" && goto :11

:10
rem ###################################################################################################################################
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
rem ###################################################################################################################################

powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*|Microsoft.WindowsAppRuntime*'} | Remove-AppxPackage"
goto :All

:11
rem ####################################################################################################################################
rem Some regs were taken from OFGB and tiny 11

rem disable online tips 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "AllowOnlineTips" /t REG_DWORD /d 0 /f

rem restore the old menu
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

rem remove search icon in taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

rem disable chat icon
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Chat" /v "ChatIcon" /t REG_DWORD /d 3 /f

rem requirements bypass related
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV1" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v "SV2" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /t REG_DWORD /d 1 /f

rem disable widgets
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d 0 /f

rem Disable Sync provider notifications in File Explorer
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f

rem Disable Suggest ways to get the most out of Windows and finish setting up this device
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v "ScoobeSystemSettingEnabled" /t REG_DWORD /d 0 /f

rem Disable Let apps show me personalized ads by using my advertising ID
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

rem Disable Tailored experiences
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy" /v "TailoredExperiencesWithDiagnosticDataEnabled" /t REG_DWORD /d 0 /f

rem Disable "Show recommendations for tips, shortcuts, new apps, and more" on Start
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_IrisRecommendations" /t REG_DWORD /d 0 /f

rem 'Deleting Application Compatibility Appraiser'
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0600DD45-FAF2-4131-A006-0B17509B9F78}" /f"

rem 'Deleting Customer Experience Improvement Program'
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{4738DE7A-BCC1-4E2D-B1B0-CADB044BFA81}" /f"
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{6FAC31FA-4A85-4E64-BFD5-2154FF4594B3}" /f"
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{FC931F16-B50A-472E-B061-B6F79A71EF59}" /f"

rem 'Deleting Program Data Updater' 
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0671EB05-7D95-4153-A32B-1426B9FE61DB}" /f"

rem 'Deleting autochk proxy'
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{87BF85F4-2CE1-4160-96EA-52F554AA28A2}" /f"
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{8A9C643C-3D74-4099-B6BD-9C6D170898B1}" /f"

rem 'Deleting QueueReporting'
PowerRun.exe cmd.exe /c "reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{E3176A65-4E44-4ED3-AA73-3283660ACB9C}" /f"
rem ####################################################################################################################################

powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Notepad|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*|Microsoft.WindowsAppRuntime*'} | Remove-AppxPackage"

:All
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

powershell -ExecutionPolicy Bypass -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File remove_edge.ps1' -Wait"

rem fix indexing was turned off
sc config wsearch start=auto

rem disable telemetry
sc config DiagTrack start=disabled
sc config dmwappushservice start=disabled

rem disable bing search on start
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f

rem show file extensions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f

echo "Done, bye"
pause