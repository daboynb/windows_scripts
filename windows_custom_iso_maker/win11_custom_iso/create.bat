@echo off
setlocal EnableDelayedExpansion

rem ############################################################################## arguments and vars
rem Extracting arguments
set "selectedFile=%~1"
set "windowsVersion=%~2"
set "edgeRemovalPreference=%~3"
set "defenderPreference=%~4"
set "windowsEdition=%~5"

for %%I in ("%selectedFile%") do set "dest_path=%%~dpI"

rem export windows edition
if "%windowsEdition%"=="Home" (
    set "index=1"
) else (
    set "index=5"
)
echo %index%

set "path_to_use=C:\"
rem ##############################################################################

title win11_custom_iso

rem ############################################################################## check files and create folders
rem check if the resources folder exist
IF NOT EXIST "%path_to_use%\windows_custom_iso_maker\win10_custom_iso\resources" (
    color 4 && echo "ERROR: Can't find the resources folder" && pause && exit /b 1
)

set "resource_dir=%path_to_use%\windows_custom_iso_maker\win11_custom_iso\resources"
set "files=7z.dll 7z.exe firefox_installer.exe oscdimg.exe tweaks.bat unattend.xml start.ps1 PowerRun.exe"

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

powerShell -Command "Write-Host 'Extracting ISO to C:\ISO\Win11... Please wait!' -ForegroundColor Green; exit"  
%resource_dir%\7z.exe x -y -o"C:\ISO\Win11" "%selectedFile%" > nul
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Extraction failed!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
rem ##############################################################################
rem ############################################################################## export wim and set unattend
rem set iso path
IF NOT EXIST "C:\ISO\Win11\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win11\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy "%resource_dir%\unattend.xml" "C:\ISO\Win11\sources\$OEM$\$$\Panther\unattend.xml"
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
powerShell -Command "Write-Host 'Exporting' -ForegroundColor Green; exit"
dism /English /export-image /SourceImageFile:"C:\ISO\Win11\sources\install.esd" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install.wim" /Compress:max /CheckIntegrity
goto :copy_esd

:wim
dism /English /Export-Image /SourceImageFile:"C:\ISO\Win11\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install_pro.wim" /compress:max

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
rem ##############################################################################
rem ############################################################################## mount the image and customize
:mountstep
rem mount the image with dism /English
powerShell -Command "Write-Host 'Mounting image' -ForegroundColor Green; exit"  
dism /English /mount-image /imagefile:"C:\ISO\Win11\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem disable defender
:edge
if "%defenderPreference%"=="Disable Windows Defender" (
    echo > C:\mount\mount\Windows\nodefender.pref
    set defender_status=whithout_defender
) else (
    set defender_status=with_defender
)

rem delete edge
:edge
if "%edgeRemovalPreference%"=="Remove Edge" (
    echo > C:\mount\mount\Windows\noedge.pref
    set edge_status=without_edge
    goto :edge_step
) else (
    set edge_status=with_edge
    goto :features
)

:edge_step
copy "%resource_dir%\firefox_installer.exe" "C:\mount\mount"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "ERROR: Can't copy Firefox setup!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'Removing useless features' -ForegroundColor Green; exit"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /English /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powerShell -Command "Write-Host 'Done' -ForegroundColor Green; exit"

rem copy batch file
cls
powerShell -Command "Write-Host 'Copying bat' -ForegroundColor Green; exit"
copy "%resource_dir%\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy tweaks.bat!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

reg query "HKLM\system\controlset001\control\nls\language" /v Installlanguage | findstr /C:"0410"
IF ERRORLEVEL 1 (
    echo.
) ELSE (
    mkdir "C:\mount\mount\Program Files\debloater"
  
    echo @echo off > "C:\mount\mount\Program Files\debloater\debloat.bat"
    echo powerShell -ExecutionPolicy Bypass -File "C:\Program Files\debloater\Debloat3.0.ps1" >> "C:\mount\mount\Program Files\debloater\debloat.bat"
    
    powershell -command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Iblis94/debloat3.0/main/Debloat3.0.ps1' -OutFile 'C:\mount\mount\Program Files\debloater\Debloat3.0.ps1'"
)

rem copy start.ps1
copy "%resource_dir%\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy start.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy PowerRun.exe
copy "%resource_dir%\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  cls
) ELSE (
  color 4 && echo "Can't copy PowerRun.exe!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:unmount
rem unmount the image
powerShell -Command "Write-Host 'Unmounting image' -ForegroundColor Green; exit"  
dism /English /unmount-image /mountdir:"C:\mount\mount" /commit
cls
rem ##############################################################################
rem ############################################################################## boot.wim edits 
rem mount the image with dism /English
powerShell -Command "Write-Host 'Mounting the image' -ForegroundColor Green; exit"  
dism /English /mount-image /imagefile:"C:\ISO\Win11\sources\boot.wim" /index:2 /mountdir:"C:\mount\mount"
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
powerShell -Command "Write-Host 'Unmounting the image' -ForegroundColor Green; exit"  
dism /English /unmount-image /mountdir:"C:\mount\mount" /commit
cls
rem ##############################################################################
rem ############################################################################## Build the iso
rem rebuild image 
powerShell -Command "Write-Host 'Building the ISO' -ForegroundColor Green; exit"  
%resource_dir%\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 "%dest_path%\Windows11_%defender_status%_%edge_status%.iso"
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
rem ##############################################################################
rem ############################################################################## Clean 
rem  Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f
echo. 
powerShell -Command "Write-Host 'Process completed!' -ForegroundColor Green; exit"  
echo "The edited iso is here %dest_path%"
echo. 
copy "%resource_dir%\rufus_forked_for_custom.exe" %dest_path% > NUL
echo "The normal rufus is not compatible with this ISO, use the rufus_forked_for_custom.exe in %dest_path%"
pause
endlocal
rem ##############################################################################