@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo.
echo downloading
powershell -Command "$url = (Invoke-RestMethod -Uri 'https://api.github.com/repos/thebookisclosed/ViVe/releases/latest').assets[1].browser_download_url; Invoke-WebRequest -Uri $url -OutFile \"$env:APPDATA\\\vivetool.zip\""

echo.
echo unzipping
7z.exe x -y -o"C:\vivetool" "%appdata%\vivetool.zip"

echo.
echo using the tool
C:\vivetool\ViVeTool.exe /enable /id:44774629,44776738,44850061,42105254,41655236

echo.
echo set en us
powershell -Command "Set-WinHomeLocation -GeoID 244"

echo.
echo apply reg
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Copilot\BingChat" /v IsUserEligible /t REG_DWORD /d 1 /f

rmdir "C:\vivetool" /s /q

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

copy copilot.url "%path_to_use%\copilot.url"

timeout 15
shutdown /r /t 00