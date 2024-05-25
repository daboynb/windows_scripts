@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

rem Download platform-tools-latest-windows.zip
powershell -Command "Set-Variable ProgressPreference SilentlyContinue; Invoke-WebRequest "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" -OutFile "C:\Program` Files\platform-tools.zip" | Out-Null"

rem Extract all from platform-tools-latest-windows.zip
powershell -Command "Expand-Archive -Path "C:\Program` Files\platform-tools.zip" -DestinationPath "C:\Program` Files\." -Force | Out-Null"

rem Remove the C:\Program Files\platform-tools.zip file 
powershell -Command "Remove-Item -Path "C:\Program` Files\platform-tools.zip" -Force | Out-Null"

setx PATH "%PATH%;C:\Program Files\platform-tools"