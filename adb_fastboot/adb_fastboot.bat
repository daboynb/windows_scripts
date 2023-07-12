@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

chcp 65001>nul 2>&1
echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║     Downloading latest platform-tools.zip...                           ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
echo.

rem Download the script from GitHub
powershell -Command "Set-Variable ProgressPreference SilentlyContinue; Invoke-WebRequest "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" -OutFile "C:\Program` Files\platform-tools.zip" | Out-Null"
IF EXIST "C:\Program Files\platform-tools.zip" (
  powerShell -Command "Write-Host 'Platform tools downloaded successfully' -ForegroundColor Green; exit" && timeout 04 >nul
) ELSE (
  color 4 && echo "ERROR, can''t download platform tools!" && pause && exit /b 1
)

echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║     Extracting latest platform-tools.zip...                            ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
echo.

rem Extract all from "windows_script_daboynb.zip"
powershell -Command "Expand-Archive -Path "C:\Program` Files\platform-tools.zip" -DestinationPath "C:\Program` Files\." -Force | Out-Null"
IF EXIST "C:\Program Files\platform-tools" (
  powerShell -Command "Write-Host 'Platform tools extracted successfully' -ForegroundColor Green; exit" && timeout 04 >nul
) ELSE (
  color 4 && echo "ERROR, can''t extract platform tools!" && pause && exit /b 1
)

echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║     Removing downloaded zip...                                         ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
echo.

rem Remove the C:\Program Files\platform-tools.zip file 
powershell -Command "Remove-Item -Path "C:\Program` Files\platform-tools.zip" -Force | Out-Null"
IF NOT EXIST "C:\Program Files\platform-tools.zip" (
  powerShell -Command "Write-Host 'platform-tools.zip removed successfully' -ForegroundColor Green; exit" && timeout 04 >nul
) ELSE (
  color 4 && echo "ERROR, can''tremove platform-tools.zip!" && pause && exit /b 1
)

echo.
echo.
echo ╔════════════════════════════════════════════════════════════════════════╗
echo ║     Setting path...                                                    ║
echo ╚════════════════════════════════════════════════════════════════════════╝
echo.
echo.

setx PATH "%PATH%;C:\Program Files\platform-tools"

IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Platform tools were added successfully to the system path' -ForegroundColor Green; exit" && timeout 04 >nul
) ELSE (
  color 4 && echo "ERROR, platform tools weren''t added successfully to the system path!" && pause && exit /b 1
)

pause