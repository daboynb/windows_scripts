@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem check if the resources folder exist
IF NOT EXIST "resources" (
    color 4 && echo "ERROR: Can't find the resources folder" && pause && exit /b 1
)

set "resource_dir=resources"
set "files=7z.dll 7z.exe firefox_installer.exe oscdimg.exe tweaks.bat unattend.xml start.ps1 PowerRun.exe"

for %%i in (%files%) do (
  if not exist "%resource_dir%\%%i" (
    color 4 && echo "ERROR: You are missing something inside the resources folder" && pause && exit /b 1
    goto :EOF
  )
)

:winfolder
IF EXIST "C:\ISO\Win11" (
    echo "ERROR: C:\ISO\Win11 already exist, please delete that folder" && timeout 04 >nul && cls goto :winfolder 
)

:mountfolder
IF EXIST "C:\mount\mount" (
    echo "ERROR: C:\mount\mount already exist, please delete that folder" && timeout 04 >nul && cls && goto :mountfolder
)

rem create folder
mkdir "C:\ISO\Win11" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\ISO\Win11 created successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\ISO\Win11!" && pause && exit /b 1
)

mkdir "C:\mount\mount" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\mount\mount created successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\mount\mount!" && pause && exit /b 1
)

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

powerShell -Command "Write-Host 'Extracting ISO to C:\ISO\Win11... Please wait!' -ForegroundColor Green; exit"  
resources\7z.exe x -y -o"C:\ISO\Win11" "%filepath%" > nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO extraction completed!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Extraction failed!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\Win11\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win11\sources\$OEM$\$$\Panther"
)

rem edit unattend.xml
powershell -command "Write-Host 'Insert your username for windows' -ForegroundColor Green; $newName = Read-Host ':'; (Get-Content -path resources\unattend.xml -Raw) -replace 'nomeutente',$newName | Set-Content -Path resources\unattend_edited.xml"
cls
powershell -command "Write-Host 'Setting up locale...' -ForegroundColor Green; $output = dism /image:C:\mount\mount /get-intl | Select-String -Pattern 'Default system UI language : (\w{2}-\w{2})' | Foreach-Object { $_.Matches.Groups[1].Value }; (Get-Content -path resources\unattend_edited.xml -Raw) -replace 'locale_set',$output | Set-Content -Path resources\unattend_edited.xml"
cls

rem copy unattended.xml
copy "resources\unattend_edited.xml" "C:\ISO\Win11\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml successfully copied!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't copy unattend.xml!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem check if wim or esd
IF EXIST "C:\ISO\Win11\sources\install.wim" (
    goto :wim
)

IF EXIST "C:\ISO\Win11\sources\install.esd" (
    goto :esd
)

:esd
dism /Get-WimInfo /WimFile:C:\ISO\Win11\sources\install.esd
echo.
powerShell -Command "Write-Host 'Select the windows version you want to use' -ForegroundColor Green; exit"
echo.
set /p index="Please enter the number of the index: "
cls
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:C:\ISO\Win11\sources\install.esd /SourceIndex:%index% /DestinationImageFile:C:\ISO\Win11\sources\install.wim /Compress:max /CheckIntegrity
goto :copy_wim

:wim
rem export windows edition
dism /Get-WimInfo /WimFile:C:\ISO\Win11\sources\install.wim
echo.
powerShell -Command "Write-Host 'Select the windows version you want to use' -ForegroundColor Green; exit"
echo.
set /p index="Please enter the number of the index: "
cls
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"  
dism /Export-Image /SourceImageFile:"C:\ISO\Win11\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install_pro.wim" /compress:max
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Image exported successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't export the image!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the old install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win11\sources\install_pro.wim" "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'The new install.wim is now inside the ISO!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't move the new install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

rem mount the image with dism
powerShell -Command "Write-Host 'Mounting image' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win11\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

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
  color 4 && echo "ERROR: Can't copy Firefox setup!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'List of features that can be removed :' -ForegroundColor Green;
echo.
echo Microsoft-Windows-InternetExplorer-Optional-Package
echo Microsoft-Windows-Kernel-LA57-FoD
echo Microsoft-Windows-LanguageFeatures-Handwriting
echo Microsoft-Windows-LanguageFeatures-OCR
echo Microsoft-Windows-LanguageFeatures-Speech
echo Microsoft-Windows-LanguageFeatures-TextToSpeech
echo Microsoft-Windows-MediaPlayer-Package
echo Microsoft-Windows-TabletPCMath-Package
echo Microsoft-Windows-Wallpaper-Content-Extended-FoD
echo.
set /p answer="Remove (all/none/select): "
if /i "%answer%"=="all" (
    echo Removing all features...
    goto :features_removal_all
) else if /i "%answer%"=="none" (
    echo Skipping...
    goto :skipping_features
) else if /i "%answer%"=="select" (
    goto :features_removal_select
) ELSE (
    echo Invalid input. Please choose 'all', 'none', or 'select'.
    goto :features
)

:features_removal_all
powerShell -Command "Write-Host 'Starting removal' -ForegroundColor Green; exit"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powerShell -Command "Write-Host 'Done' -ForegroundColor Green; exit"
goto :skipping_features

:features_removal_select
powerShell -Command "Write-Host 'Starting removal' -ForegroundColor Green; exit"

:Microsoft-Windows-InternetExplorer-Optional-Package
set /p answer="Remove Microsoft-Windows-InternetExplorer-Optional-Package ? (yes/no): "
if /i "%answer%"=="yes" (
    powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
    powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-InternetExplorer-Optional-Package
)

:Microsoft-Windows-Kernel-LA57-FoD
set /p answer="Remove Microsoft-Windows-Kernel-LA57-FoD ? (yes/no): "
if /i "%answer%"=="yes" (
  powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
  powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-Kernel-LA57-FoD
)

:Microsoft-Windows-LanguageFeatures-Handwriting
set /p answer="Remove Microsoft-Windows-LanguageFeatures-Handwriting ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-LanguageFeatures-Handwriting
)

:Microsoft-Windows-LanguageFeatures-OCR
set /p answer="Remove Microsoft-Windows-LanguageFeatures-OCR ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-LanguageFeatures-OCR
)

:Microsoft-Windows-LanguageFeatures-Speech
set /p answer="Remove Microsoft-Windows-LanguageFeatures-Speech ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-LanguageFeatures-Speech
)

:Microsoft-Windows-LanguageFeatures-TextToSpeech
set /p answer="Remove Microsoft-Windows-LanguageFeatures-TextToSpeech ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-LanguageFeatures-TextToSpeech
)

:Microsoft-Windows-MediaPlayer-Package
set /p answer="Remove Microsoft-Windows-MediaPlayer-Package ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-MediaPlayer-Package
)

:Microsoft-Windows-TabletPCMath-Package
set /p answer="Remove Microsoft-Windows-TabletPCMath-Package ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-TabletPCMath-Package
)

:Microsoft-Windows-Wallpaper-Content-Extended-FoD
set /p answer="Remove Microsoft-Windows-Wallpaper-Content-Extended-FoD ? (yes/no): "
if /i "%answer%"=="yes" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Done!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :Microsoft-Windows-Wallpaper-Content-Extended-FoD
)

:skipping_features
rem copy batch file
cls
powerShell -Command "Write-Host 'Copying bat' -ForegroundColor Green; exit"
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy tweaks.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy start.ps1
copy "resources\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'start.ps1 copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy start.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem disable defender
:defender
set /p answer="Do you want to disable Windows Defender (Antivirus)? (yes/no) : "
if /i "%answer%"=="yes" (
    echo > C:\mount\mount\Windows\nodefender.pref
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :defender
)

rem copy PowerRun.exe
copy "resources\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copied successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Can't copy PowerRun.exe!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:unmount
rem unmount the image
powerShell -Command "Write-Host 'Unmounting image' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ######################################################################################## 

rem rebuild image 
powerShell -Command "Write-Host 'Building the ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 C:\ISO\Windows11_edited.iso
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO builded successfully!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't build the ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy the iso and clean
copy "C:\ISO\Windows11_edited.iso" "C:\Users\%USERNAME%\Desktop"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copied on the desktop!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't copy the ISO to the desktop!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Working folder1 successfully deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Working folder2 successfully deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder2!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

del "resources\unattend_edited.xml" /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unattend successfully deleted!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERROR: Can't delete unattend!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:delete_iso
set /p answer="Remove the original iso file? (yes/no): "
if /i "%answer%"=="yes" (
del "%filepath%" /q
) else if /i "%answer%"=="no" (
    echo Skipping...
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :delete_iso
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Process completed! Press any key to exit' -ForegroundColor Green; exit"  
pause