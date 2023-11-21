@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

title win11_custom_iso

rem check if the resources folder exist
IF NOT EXIST "resources" (
    color 4 && echo "ERROR: Can't find the resources folder" && pause && exit /b 1
)

set "resource_dir=resources"
set "files=7z.dll 7z.exe firefox_installer.exe Windows_italia_debloater.bat oscdimg.exe tweaks.bat unattend.xml start.ps1 PowerRun.exe get_country.ps1"

for %%i in (%files%) do (
  if not exist "%resource_dir%\%%i" (
    color 4 && echo "ERROR: You are missing something inside the resources folder" && pause && exit /b 1
    goto :EOF
  )
)

:winfolder
IF EXIST "C:\ISO\Win11" (
    rmdir "C:\ISO\Win11" /s /q 
)

:mountfolder
IF EXIST "C:\mount\mount" (
    rmdir "C:\mount\mount" /s /q 
)

rem create folder
mkdir "C:\ISO\Win11" 2>nul
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\ISO\Win11!" && pause && exit /b 1
)

mkdir "C:\mount\mount" 2>nul
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't create C:\mount\mount!" && pause && exit /b 1
)

powerShell -Command "Write-Host 'You need the stock win11 ISO to continue' -ForegroundColor Green; exit" && timeout 04 >nul 

:loop
ping 8.8.8.8 -n 1 >nul
if %errorlevel% equ 0 (
    goto :end
) else (
    echo Internet connection not available. Retrying...
    timeout /t 5 >nul
    cls
    goto :loop
)
:end

rem Call the PowerShell script and capture its output to a variable
for /f %%i in ('powershell -executionpolicy bypass -file resources\get_country.ps1') do (
    set countryvar=%%i
)

rem ISO if IT
IF "%countryvar%" == "IT" (
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
powerShell -Command "Write-Host 'Select win11 ISO file' -ForegroundColor Green; exit"  
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
  cls
) ELSE (
  color 4 && echo "ERROR: Extraction failed!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\Win11\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win11\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy "resources\unattend.xml" "C:\ISO\Win11\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't copy unattend.xml!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem check if wim or esd
IF EXIST "C:\ISO\Win11\sources\install.wim" (
    goto :wim
)

IF EXIST "C:\ISO\Win11\sources\install.esd" (
    goto :esd
)

:esd
dism /Get-WimInfo /WimFile:"C:\ISO\Win11\sources\install.esd"
echo.
powerShell -Command "Write-Host 'Select the windows version you want to use' -ForegroundColor Green; exit"
echo.
set /p index="Please enter the number of the index: "
cls
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:"C:\ISO\Win11\sources\install.esd" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install.wim" /Compress:max /CheckIntegrity
goto :copy_esd

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
  cls
) ELSE (
  color 4 && echo "ERROR: Can't export the image!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the old install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win11\sources\install_pro.wim" "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't move the new install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountstep

:copy_esd
rem del esd
del "C:\ISO\Win11\sources\install.esd"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERRORE: Can''t delete old install.esd!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

:mountstep
rem mount the image with dism
powerShell -Command "Write-Host 'Mounting image' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win11\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem disable defender
:defender
set /p answer="Do you want to disable Windows Defender (Antivirus)? (yes/no) : "
if /i "%answer%"=="yes" (
    echo > C:\mount\mount\Windows\nodefender.pref
    set defender_status=defender_disabled
) else if /i "%answer%"=="no" (
    set defender_status=defender_enabled
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :defender
)

rem delete edge
:edge
set /p answer="Do you want to remove Edge? (yes/no): "
if /i "%answer%"=="yes" (
    echo > C:\mount\mount\Windows\noedge.pref
    set edge_status=edge_removed
    goto :edge_step
) else if /i "%answer%"=="no" (
    set edge_status=edge_not_removed
    goto :features
) ELSE (
    echo Invalid input. Please answer with 'yes' or 'no'.
    goto :edge
)

:edge_step
copy "resources\firefox_installer.exe" "C:\mount\mount"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't copy Firefox setup!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'Removing useless features' -ForegroundColor Green; exit"
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

rem copy batch file
cls
powerShell -Command "Write-Host 'Copying bat' -ForegroundColor Green; exit"
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy tweaks.bat!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloat if IT
IF "%countryvar%" == "IT" (
    copy "resources\Windows_italia_debloater.bat" "C:\mount\mount\Windows"
)

rem copy start.ps1
copy "resources\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy start.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy PowerRun.exe
copy "resources\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy PowerRun.exe!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:unmount
rem unmount the image
powerShell -Command "Write-Host 'Unmounting image' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ######## boot.wim edits #################
rem mount the image with dism
powerShell -Command "Write-Host 'Sto montando l''immagine' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win11\sources\boot.wim" /index:2 /mountdir:"C:\mount\mount"
cls

  echo "Bypass reg"
  Reg load "HKLM\TK_BOOT_SYSTEM" "C:\mount\mount\Windows\System32\Config\SYSTEM" 
  Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /t REG_DWORD /d "1" /f 
  Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d "1" /f 
  Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d "1" /f 
  Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /t REG_DWORD /d "1" /f 
  Reg add "HKLM\TK_BOOT_SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d "1" /f 
  Reg unload "HKLM\TK_BOOT_SYSTEM" 
  move "C:\ISO\Win11\sources\appraiserres.dll" "C:\ISO\Win11\sources\appraiserres.dll.bak"
timeout 04

rem unmount the image
powerShell -Command "Write-Host 'Smontando l''immagine' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls
rem ######## boot.wim edits #################

rem rebuild image 
set "path_to_use=C:\Windows_iso_maker"

powerShell -Command "Write-Host 'Building the ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 "%path_to_use%\Windows11_%defender_status%_%edge_status%.iso"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't build the ISO!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't delete the working folder2!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Process completed!' -ForegroundColor Green; exit"  

rem flash iso
powerShell -Command "Write-Host 'Use the rufus.exe on the C:\Windows_iso_maker folder' -ForegroundColor Green; exit"  
powerShell -Command "Write-Host 'This is a forked rufus that works with custom ISOs' -ForegroundColor Green; exit"  
copy "resources\rufus_forked_for_custom.exe" %path_to_use%
powerShell -Command "Write-Host 'Completed, press enter to close the script!' -ForegroundColor Green; exit"  
pause
endlocal