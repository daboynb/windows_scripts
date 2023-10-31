@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powershell -command "Invoke-WebRequest -Uri 'https://codeload.github.com/Iblis94/debloat3.0/zip/refs/heads/main' -OutFile 'debloater.zip'"

move "debloater.zip" "C:\Users\%USERNAME%\Desktop"

powershell -command "Expand-Archive -Path "C:\Users\%USERNAME%\Desktop\debloater.zip" -DestinationPath "C:\Users\%USERNAME%\Desktop\." -Force"

copy "C:\Users\%USERNAME%\Desktop\debloat3.0-main\Debloat3.0.ps1" "C:\Windows\Debloat3.0.ps1"

del "C:\Users\%USERNAME%\Desktop\debloater.zip"
rmdir /s /q "C:\Users\%USERNAME%\Desktop\debloat3.0-main"

if not exist "C:\Windows\debloat.bat" (
  echo @echo off
  echo powerShell -ExecutionPolicy Bypass -File "C:\Windows\Debloat3.0.ps1"
) > "C:\Windows\debloat.bat"

copy "C:\Windows\debloat.bat" "C:\Users\%USERNAME%\Desktop\Debloat_windows_italia.bat"

rem Delete this batch file
del "%~f0"