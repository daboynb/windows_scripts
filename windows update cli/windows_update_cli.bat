@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powershell -Command "Set-ExecutionPolicy Unrestricted -Force"

rem Check if NuGet PackageProvider is installed
powershell -Command "if (-not (Get-PackageProvider -Name NuGet -ListAvailable)) { Install-PackageProvider -Name NuGet -Confirm:$False -Force | Out-Null }"

rem Check if PSWindowsUpdate module is installed
powershell -Command "if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) { Install-Module PSWindowsUpdate -Confirm:$False -Force | Out-Null }"

rem Run PowerShell commands
powershell -Command "Get-WindowsUpdate; Install-WindowsUpdate -AcceptAll -AutoReboot"

rem Exit the batch script
pause