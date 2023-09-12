@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo Set policy Unrestricted
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"

rem Check if NuGet PackageProvider is installed
echo Install nuget
powershell -Command "Install-PackageProvider -Name NuGet"

rem Check if PSWindowsUpdate module is installed
echo install PSWindowsUpdate
powershell -Command "Install-Module PSWindowsUpdate"

echo Install Updates if avaiable
rem Run PowerShell commands
powershell -Command "Get-WindowsUpdate; Install-WindowsUpdate -AcceptAll -AutoReboot"

echo Set policy Restricted
powershell -Command "Set-ExecutionPolicy Restricted -Force"

rem Exit the batch script
pause