@echo off

rem original method discovered by hiranokite on reddit

cd /d "%~dp0"
rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

IF exist files_detect.ps1 (
    echo ok
) ELSE (
    echo files_detect.ps1 not present! && pause && exit /b 1
)

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

ping 8.8.8.8 -n 1 -w 1000 > nul
IF "%ERRORLEVEL%"=="1" color 0C && echo "Internet is not avibale, EXITING!" && pause && exit

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS 11 RECOMMENDED SECTION MANAGER
echo.
ECHO [1] HIDE RECOMMENDED SECTION 
ECHO [2] SHOW RECOMMENDED SECTION
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :INSTALL
IF /I '%MENU%'=='2' GOTO :UNINSTALL
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

rem ####################################################################################### INSTALL SECTION

:INSTALL
powershell -Command "$url = (Invoke-RestMethod -Uri 'https://api.github.com/repos/valinet/ExplorerPatcher/releases/latest').assets[0].browser_download_url; Invoke-WebRequest -Uri $url -OutFile \"$env:APPDATA\\\ep_setup.exe\""

"%appdata%\ep_setup.exe" /extract "%appdata%\ep_setup"
copy "%appdata%\ep_setup\ExplorerPatcher.amd64.dll" "%appdata%\dxgi.dll"
rmdir "%appdata%\ep_setup" /s /q
del "%appdata%\ep_setup.exe"
IF exist "%appdata%\dxgi.dll" (
    echo ok
) ELSE (
    echo dxgi.dll not present! && pause && exit /b 1
)

rem copy dll's
copy "%appdata%\dxgi.dll" "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\dxgi.dll"
copy "%appdata%\dxgi.dll" "%SystemRoot%\dxgi.dll"

rem add keys
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher" /v "StartDocked_DisableRecommendedSection" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher\StartDocked" /v "StartDocked::LauncherFrame::OnVisibilityChanged" /t REG_DWORD /d 1869808 /f

rem restart processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe & start explorer.exe

rem wait until the start menu is ready
timeout 03 >nul
powerShell -Command "Write-Host 'Wait until all files are downloaded!' -ForegroundColor Green; exit"
powershell.exe -ExecutionPolicy Bypass -File "files_detect.ps1"
timeout 03 >nul

rem disable one dll
PowerRun.exe cmd.exe /c "move "%SystemRoot%\dxgi.dll" "%SystemRoot%\adxgi.dll""

rem restart processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe & start explorer.exe

rem delete one dll
del C:\Windows\adxgi.dll
timeout 03 >nul
shutdown /r /t 00

rem ####################################################################################### UNINSTALL SECTION

:UNINSTALL
rem kill processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe

rem delete reg keys
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher" /v "StartDocked_DisableRecommendedSection" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher\StartDocked" /v "StartDocked::LauncherFrame::OnVisibilityChanged" /f

rem delete dxgi.dll
del "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\dxgi.dll" /Q

rem restart explorer
start explorer.exe
timeout 03 >nul
shutdown /r /t 00