@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

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

powershell -command "$ErrorActionPreference = 'SilentlyContinue'; Get-AppxPackage -AllUsers | Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*|Microsoft.WindowsAppRuntime*''} | Remove-AppxPackage"

echo "Done"
timeout 10