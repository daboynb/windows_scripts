@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

echo win10_custom_iso_ita
timeout 2

rem check if the resources folder exist
IF NOT EXIST "resources" (
    color 4 && echo "ERRORE: Impossibile trovare la cartella resources" && pause && exit /b 1
)

set "resource_dir=resources"
set "files=7z.dll 7z.exe Windows_italia_debloater.bat firefox_installer.exe oscdimg.exe tweaks.bat unattend.xml unpin_start_tiles.ps1 start.ps1 PowerRun.exe"

for %%i in (%files%) do (
  if not exist "%resource_dir%\%%i" (
    color 4 && echo "ERRORE: Mancano dei file dentro la cartella resources" && pause && exit /b 1
    goto :EOF
  )
)

rem Download iso
:iso
powerShell -Command "Write-Host 'Vuoi scaricare la iso di windows? (si/no)' -ForegroundColor Green; exit"
set /p answer=":"
if /i "%answer%"=="si" (
    start "" "https://shorturl.at/ostJW"
    goto :iso_scaricata
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
    goto :winfolder
) ELSE (
    echo I valori accettati sono solamente si e no.
    goto :iso
)

:iso_scaricata
powerShell -Command "Write-Host 'Digita terminato al termine del download per proseguire' -ForegroundColor Yellow; exit"
set /p answer=":"
if /i "%answer%"=="terminato" (
  echo Proseguiamo
) ELSE (
    echo Valore non accettato.
    goto :iso_scaricata
)

:winfolder
IF EXIST "C:\ISO\Win10" (
    echo "ERRORE: C:\ISO\Win10 esiste gia', elimina la cartella prima di procedere" && timeout 04 >nul && cls && goto :winfolder 
)

:mountfolder
IF EXIST "C:\mount\mount" (
    echo "ERRORE: C:\mount\mount esiste gia', elimina la cartella prima di procedere" && timeout 04 >nul && cls && goto :mountfolder 
)

rem create folder
mkdir "C:\ISO\Win10" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\ISO\Win10 creata correttamente!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare C:\ISO\Win10!" && pause && exit /b 1
)

mkdir "C:\mount\mount" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\mount\mount creata correttamente!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare C:\mount\mount!" && pause && exit /b 1
)

rem set iso path
set "filepath="
set "dialogTitle=seleziona il file iso"

rem Open file dialog to select file
:select_file
powerShell -Command "Write-Host 'Seleziona il file iso' -ForegroundColor Green; exit"  
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'ISO files (*.iso)|*.iso'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  powerShell -Command "Write-Host 'Hai selezionato %filepath%' -ForegroundColor Green; exit"  
  cls
) ELSE (
  echo Nessun file selezionato
  goto :select_file
)

powerShell -Command "Write-Host 'Sto estraendo la iso in C:\ISO\Win10... Attendi!' -ForegroundColor Green; exit"  
resources\7z.exe x -y -o"C:\ISO\Win10" "%filepath%" > nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Estrazione della ISO completata!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Estrazione fallita!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\Win10\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win10\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy "resources\unattend.xml" "C:\ISO\Win10\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare unattend.xml!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
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
powerShell -Command "Write-Host 'Seleziona la versione di windows da usare' -ForegroundColor Green; exit"
echo.
set /p index="Inserisci il numero corrispondente: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:"C:\ISO\Win10\sources\install.esd" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win10\sources\install.wim" /Compress:max /CheckIntegrity
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :copy_esd

:wim
rem export windows edition
dism /Get-WimInfo /WimFile:C:\ISO\Win10\sources\install.wim
echo.
powerShell -Command "Write-Host 'Seleziona la versione di windows da usare' -ForegroundColor Green; exit"
echo.
set /p index="Inserisci il numero corrispondente: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor Green; exit"  
dism /Export-Image /SourceImageFile:"C:\ISO\Win10\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win10\sources\install_pro.wim" /compress:max
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win10\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win10\sources\install_pro.wim" "C:\ISO\Win10\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Il nuovo install.wim e'' stato spostato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile spostare il nuovo install.wim!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountstep

:copy_esd
rem del esd
del "C:\ISO\Win10\sources\install.esd"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.esd eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.esd!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

:mountstep
rem mount the image with dism
powerShell -Command "Write-Host 'Sto montando l''immagine' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win10\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem disable defender
:defender
set /p answer="Vuoi disattivare Windows Defender (Antivirus)? (si/no) : "
if /i "%answer%"=="si" (
    echo > C:\mount\mount\Windows\nodefender.pref
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) ELSE (
    echo I valori accettati sono solamente si e no.
    goto :defender
)

rem delete edge
:edge
set /p answer="Vuoi rimuovere edge? (si/no) "
if /i "%answer%"=="si" (
    echo > C:\mount\mount\Windows\noedge.pref
    goto :edge_step
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
    goto :features
) ELSE (
    echo I valori accettati sono solamente si e no.
    goto :edge
)

:edge_step
copy "resources\firefox_installer.exe" "C:\mount\mount"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'L''installer di firefox e'' stato copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare l''installer di firefox!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'Iniziamo la rimozione delle funzionalita''...' -ForegroundColor Green; exit"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powerShell -Command "Write-Host 'Completato' -ForegroundColor Green; exit"

rem copy batch file
cls
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare tweaks.bat!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloater
cls
copy "resources\Windows_italia_debloater.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Windows_italia_debloater.bat copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare Windows_italia_debloater.bat!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy unpin_start_tiles.ps1
copy "resources\unpin_start_tiles.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unpin_start_tiles.ps1 copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare Unpin_start_tiles.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy start.ps1
copy "resources\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'start.ps1 copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare start.ps1!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)



rem copy PowerRun.exe
copy "resources\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare PowerRun.exe!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem unmount the image
powerShell -Command "Write-Host 'Smontando l''immagine' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ######################################################################################## 

rem rebuild image 
powerShell -Command "Write-Host 'Creando la ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win10\boot\etfsboot.com#pEF,e,bC:\ISO\Win10\efi\microsoft\boot\efisys.bin C:\ISO\Win10 C:\ISO\Windows10_edited.iso
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO creata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare la ISO!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy the iso and clean
copy "C:\ISO\Windows10_edited.iso" "C:\Users\%USERNAME%\Desktop"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copiata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare la ISO sul desktop!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory1 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare le directory1 usata per la creazione della ISO!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory2 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare la directory2 usata per la creazione della ISO!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Processo completato!' -ForegroundColor Green; exit"  

rem flash iso
:rufus
powerShell -Command "Write-Host 'Scaricando una versione custom di rufus per le iso custom' -ForegroundColor Green; exit"  
powershell -command "Invoke-WebRequest -Uri 'https://shorturl.at/fkpD8' -OutFile "C:\Users\%USERNAME%\Desktop\rufus.exe""
IF EXIST "C:\Users\%USERNAME%\Desktop\rufus.exe" (
    start "" "C:\Users\%USERNAME%\Desktop\rufus.exe"
) ELSE (
    goto :rufus
)

pause