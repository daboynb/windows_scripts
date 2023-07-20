@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

IF exist PowerRun.exe (
    echo ok
) ELSE (
    echo powerrun not present! && pause && exit /b 1
)

echo.
echo Killing Microsoft Edge...
echo.
taskkill /F /IM msedge.exe 2>nul

echo.
echo removing Microsoft Edge...
echo.
PowerRun.exe cmd.exe /c "rmdir "C:\Program Files (x86)\Microsoft\EdgeUpdate" /s /q" 1>nul 2>nul
PowerRun.exe cmd.exe /c "rmdir "C:\Program Files (x86)\Microsoft\Edge" /s /q" 1>nul 2>nul
PowerRun.exe powershell.exe -Command "Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage; $filePath = 'C:\Windows\edge1.txt'; $textContent = 'Removal completed successfully.'; Set-Content -Path $filePath -Value $textContent" 1>nul 2>nul

echo.
echo Finding the installed version of Microsoft Edge Legacy/UWP
echo.
for /f "tokens=8 delims=\" %%i in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" ^| findstr "Microsoft-Windows-Internet-Browser-Package" ^| findstr "~~"') do (
    set "edge_legacy_package_version=%%i"
)

echo.
echo Deleting the owners of the Edge Legacy package in the registry
echo.
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\%edge_legacy_package_version%\Owners" /va /f 1>nul 2>nul

echo.
echo Removing the Edge Legacy package using DISM
echo.
dism /online /Remove-Package /PackageName:%edge_legacy_package_version% 1>nul 2>nul

echo.
echo Adding registry key to prevent Edge updates
echo.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\EdgeUpdate" /v "DoNotUpdateToEdgeWithChromium" /t REG_DWORD /d 1 /f 1>nul 2>nul

echo.
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk" 1>nul 2>nul

:check
IF EXIST "C:\Windows\edge1.txt" (
    powershell write-host -fore Green "Done"
) ELSE (
    goto :check
)

powershell write-host -fore Green "Rebooting in 5 seconds"
timeout 5
shutdown /r /t 00 