@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

mkdir "C:\Program Files\debloater"

cd "C:\Program Files\debloater"

powershell -command "Invoke-WebRequest -Uri 'https://codeload.github.com/Iblis94/debloat3.0/zip/refs/heads/main' -OutFile 'debloater.zip'"

powershell -command "Expand-Archive -Path "debloater.zip" -DestinationPath "." -Force"

del "debloater.zip"
rmdir /s /q "debloat3.0-main"
copy "debloat3.0-main\Debloat3.0.ps1" "Debloat3.0.ps1"

if not exist "C:\Program Files\debloater\debloat.bat" (
  echo @echo off
  echo powerShell -ExecutionPolicy Bypass -File "C:\Program Files\debloater\Debloat3.0.ps1"
) > "C:\Program Files\debloater\debloat.bat"

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

copy "C:\Program Files\debloater\debloat.bat" "%path_to_use%\Debloat_windows_italia.bat"

setx PATH "%PATH%;C:\Program Files\debloater"

"C:\Program Files\debloater\debloat.bat"

rem Delete this batch file
del "%~f0"