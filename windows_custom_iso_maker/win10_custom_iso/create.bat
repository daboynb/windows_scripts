@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

title win10_custom_iso_en

rem check if the resources folder exist
IF NOT EXIST "resources" (
    color 4 && echo "ERROR: Can't find the resources folder" && pause && exit /b 1
)

set "resource_dir=resources"
set "files=7z.dll 7z.exe firefox_installer.exe Windows_italia_debloater.bat oscdimg.exe tweaks.bat unattend.xml unpin_start_tiles.ps1 start.ps1 PowerRun.exe get_country.ps1"

for %%i in (%files%) do (
  if not exist "%resource_dir%\%%i" (
    color 4 && echo "ERROR: You are missing something inside the resources folder" && pause && exit /b 1
    goto :EOF
  )
)

:winfolder
IF EXIST "C:\ISO\Win10" (
    echo "ERROR: C:\ISO\Win10 already exist, please delete that folder" && timeout 04 >nul && cls && goto :winfolder 
)

:mountfolder
IF EXIST "C:\mount\mount" (
    echo "ERROR: C:\mount\mount already exist, please delete that folder" && timeout 04 >nul && cls && goto :mountfolder 
)

rem create folder
mkdir "C:\ISO\Win10" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\ISO\Win10 created successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\ISO\Win10!" && pause && exit /b 1
)

mkdir "C:\mount\mount" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\mount\mount created successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\mount\mount!" && pause && exit /b 1
)

powerShell -Command "Write-Host 'You need the stock win10 ISO to continue' -ForegroundColor Green; exit" && timeout 04 >nul 

echo.
:loop
ping 8.8.8.8 -n 1 >nul
if %errorlevel% equ 0 (
    echo Internet connection is available.
    goto :end
) else (
    echo Internet connection not available. Retrying...
    timeout /t 5 >nul
    goto :loop
)
:end
echo.

rem Call the PowerShell script and capture its output to a variable
for /f %%i in ('powershell -executionpolicy bypass -file resources\get_country.ps1') do (
    set myvar=%%i
)

rem Display the value of the variable
echo The country code is: %myvar%

rem ISO if IT
IF "%myvar%" == "IT" (
  start "" "https://tinyurl.com/4ty38tpk"
)

powerShell -Command "Write-Host 'Press enter when you have downloaded it' -ForegroundColor Green; exit" && timeout 04 >nul 
pause
cls

rem set iso path
set "filepath="
set "dialogTitle=Select a file"

rem Open file dialog to select file
:select_file
powerShell -Command "Write-Host 'Select an ISO file' -ForegroundColor Green; exit"  
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'ISO files (*.iso)|*.iso'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  powerShell -Command "Write-Host 'You selected %filepath%' -ForegroundColor Green; exit"  
  cls
) ELSE (
  echo No file selected
  goto :select_file
)

powerShell -Command "Write-Host 'Extracting ISO to C:\ISO\Win10... Please wait!' -ForegroundColor Green; exit"  
resources\7z.exe x -y -o"C:\ISO\Win10" "%filepath%" > nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO extraction completed!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Extraction failed!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\Win10\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win10\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy "resources\unattend.xml" "C:\ISO\Win10\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml successfully copied!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't copy unattend.xml!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem check if wim or esd
IF EXIST "C:\ISO\Win10\sources\install.wim" (
    goto :wim
)

IF EXIST "C:\ISO\Win10\sources\install.esd" (
    goto :esd
)

:esd
dism /Get-WimInfo /WimFile:"C:\ISO\Win10\sources\install.esd"
echo.
powerShell -Command "Write-Host 'Select the windows version you want to use' -ForegroundColor Green; exit"
echo.
set /p index="Please enter the number of the index: "
cls
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:"C:\ISO\Win10\sources\install.esd" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win10\sources\install.wim" /Compress:max /CheckIntegrity
goto :copy_esd

:wim
rem export windows edition
dism /Get-WimInfo /WimFile:C:\ISO\Win10\sources\install.wim
echo.
powerShell -Command "Write-Host 'Select the windows version you want to use' -ForegroundColor Green; exit"
echo.
set /p index="Please enter the number of the index: "
cls
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"  
dism /Export-Image /SourceImageFile:"C:\ISO\Win10\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win10\sources\install_pro.wim" /compress:max
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Image exported successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't export the image!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win10\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the old install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win10\sources\install_pro.wim" "C:\ISO\Win10\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'The new install.wim is now inside the ISO!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't move the new install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountstep

:copy_esd
rem del esd
del "C:\ISO\Win10\sources\install.esd"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.esd deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Can''t delete old install.esd!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

:mountstep
rem mount the image with dism
powerShell -Command "Write-Host 'Mounting image' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win10\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem disable defender
:defender
set /p answer="Do you want to disable Windows Defender (Antivirus)? (yes/no) : "
if /i "%answer%"=="yes" (
    echo > C:\mount\mount\Windows\nodefender.pref
) else if /i "%answer%"=="no" (
    echo "Skipping..."
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :defender
)

rem delete edge
:edge
set /p answer="Do you want to remove Edge? (yes/no): "
if /i "%answer%"=="yes" (
    echo > C:\mount\mount\Windows\noedge.pref
    goto :edge_step
) else if /i "%answer%"=="no" (
    echo Skipping...
    goto :features
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :edge
)

:edge_step
copy "resources\firefox_installer.exe" "C:\mount\mount"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Firefox setup copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't copy Firefox setup!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
rem powerShell -Command "Write-Host 'Starting features removal' -ForegroundColor Green; exit"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
rem powerShell -Command "Write-Host 'Done' -ForegroundColor Green; exit"

rem copy batch file
cls
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy tweaks.bat!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy unpin_start_tiles.ps1
copy "resources\unpin_start_tiles.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unpin_start_tiles.ps1 copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy Unpin_start_tiles.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloat if IT
IF "%myvar%" == "IT" (
    copy "resources\Windows_italia_debloater.bat" "C:\mount\mount\Windows"
)

rem copy start.ps1
copy "resources\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'start.ps1 copied successfull!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy start.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy PowerRun.exe
copy "resources\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy PowerRun.exe!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem unmount the image
powerShell -Command "Write-Host 'Unmounting image' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ######################################################################################## 

rem rebuild image 
powerShell -Command "Write-Host 'Building the ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win10\boot\etfsboot.com#pEF,e,bC:\ISO\Win10\efi\microsoft\boot\efisys.bin C:\ISO\Win10 C:\ISO\Windows10_edited.iso
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO built successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't build the ISO!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

rem copy the iso and clean
copy "C:\ISO\Windows10_edited.iso" "%path_to_use%"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copied on the desktop!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't copy the ISO to the desktop!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Working folder1 successfully deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Working folder2 successfully deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder2!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Process completed!' -ForegroundColor Green; exit"  

rem flash iso
echo.
:loop
ping 8.8.8.8 -n 1 >nul
if %errorlevel% equ 0 (
    echo Internet connection is available.
    goto :end
) else (
    echo Internet connection not available. Retrying...
    timeout /t 5 >nul
    goto :loop
)
:end
echo.
:rufus
powerShell -Command "Write-Host 'Downloading a forked rufus that works with custom ISOs' -ForegroundColor Green; exit"  
powershell -command "Invoke-WebRequest -Uri 'https://shorturl.at/fkpD8' -OutFile "$env:APPDATA\rufus.exe""
copy %appdata%\rufus.exe %path_to_use%
IF EXIST "%path_to_use%\rufus.exe" (
    start "" "%path_to_use%\rufus.exe">nul
) ELSE (
    goto :rufus
)