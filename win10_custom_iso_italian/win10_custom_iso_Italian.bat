@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem check if the resources folder exist
IF NOT EXIST "resources" (
    color 4 && echo "ERRORE: Impossibile trovare la cartella resources" && pause && exit /b 1
)

set "resource_dir=resources"
set "files=7z.dll 7z.exe Debloat_Windows_Italia.lnk debloat3.0.ps1 firefox_installer.exe oscdimg.exe tweaks.bat unattend.xml edge_removal.bat unpin_start_tiles.ps1"

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
    start "" "https://drive.google.com/uc?id=1zAbQBsJeU4ctHl7A7ZBSrajkMEZsyHKJ&export=download&confirm=t"
    goto :iso_scaricata
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
    goto :winfolder
) else (
    echo I valori accettati sono solamente si e no.
    goto :iso
)

:iso_scaricata
powerShell -Command "Write-Host 'Digita terminato al termine del download per proseguire' -ForegroundColor Green; exit"
set /p answer=":"
if /i "%answer%"=="terminato" (
  echo Proseguiamo
) else (
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
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\ISO\Win10 creata correttamente!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile creare C:\ISO\Win10!" && pause && exit /b 1
)

mkdir "C:\mount\mount" 2>nul
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\mount\mount creata correttamente!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
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
) else (
  echo Nessun file selezionato
  goto :select_file
)

powerShell -Command "Write-Host 'Sto estraendo la iso in C:\ISO\Win10... Attendi!' -ForegroundColor Green; exit"  
resources\7z.exe x -y -o"C:\ISO\Win10" "%filepath%" > nul
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Estrazione della ISO completata!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Estrazione fallita!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

IF NOT EXIST "C:\ISO\Win10\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win10\sources\$OEM$\$$\Panther"
)

rem edit unattend.xml
powershell -command "Write-Host 'Inserisci il nome che desideri per l''utente di windows' -ForegroundColor Green; $newName = Read-Host ':'; (Get-Content -path resources\unattend.xml -Raw) -replace 'nomeutente',$newName | Set-Content -Path resources\unattend_edited.xml"

rem copy unattended.xml
copy "resources\unattend_edited.xml" "C:\ISO\Win10\sources\$OEM$\$$\Panther\unattend.xml"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile copiare unattend.xml!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem check if wim or esd
IF EXIST "C:\ISO\Win10\sources\install.wim" (
    goto :wim
)

IF EXIST "C:\ISO\Win10\sources\install.esd" (
    goto :esd
)

:esd
dism /Get-WimInfo /WimFile::C:\ISO\Win10\sources\install.esd
echo.
powerShell -Command "Write-Host 'Seleziona la versione di windows da usare' -ForegroundColor Green; exit"
echo.
set /p index="Inserisci il numero corrispondente: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:C:\ISO\Win10\sources\install.esd /SourceIndex:%index% /DestinationImageFile:C:\ISO\Win10\sources\install.wim /Compress:max /CheckIntegrity
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :copy_wim

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
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win10\sources\install.wim"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile eliminare old install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win10\sources\install_pro.wim" "C:\ISO\Win10\sources\install.wim"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Il nuovo install.wim e'' stato spostato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile spostare il nuovo install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

rem mount the image with dism
powerShell -Command "Write-Host 'Sto montando l''immagine' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win10\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

rem delete edge
:edge
set /p answer="Vuoi rimuovere edge? (si/no) Consigliato (si) : "
if /i "%answer%"=="si" (
    goto :edge_first_step
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
    goto :features
) else (
    echo I valori accettati sono solamente si e no.
    goto :edge
)

:edge_first_step
rmdir "C:\mount\mount\Program Files (x86)\Microsoft\EdgeUpdate" /s /q
rmdir "C:\mount\mount\Program Files (x86)\Microsoft\Edge" /s /q
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Edge rimosso!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile rimuovere edge!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:edge_second_step
copy "resources\edge_removal.bat" "C:\mount\mount\Windows"
copy "resources\firefox_installer.exe" "C:\mount\mount"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Lo script per la rimozione completa di edge e l''installer di firefox sono stati copiati con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile copiare lo script per la rimozione completa di edge e l''installer di firefox!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'Lista delle funzionalità che possono essere rimosse :' -ForegroundColor Green;
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
set /p answer="Rimuovere? (tutte/nessuna/seleziona): "
if /i "%answer%"=="tutte" (
    goto :features_removal_all
) else if /i "%answer%"=="nessuna" (
    echo "Saltiamo questo passaggio..."
    goto :skipping_features
) else if /i "%answer%"=="seleziona" (
    goto :features_removal_select
) else (
    echo I valori accettati sono solamente 'tutte', 'nessuna', o 'seleziona'.
    goto :features
)

:features_removal_all
powerShell -Command "Write-Host 'Iniziamo la rimozione...' -ForegroundColor Green; exit"
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
goto :skipping_features

:features_removal_select
powerShell -Command "Write-Host 'Inziamo la rimozione...' -ForegroundColor Green; exit"

:Microsoft-Windows-InternetExplorer-Optional-Package
set /p answer="Rimuovere Microsoft-Windows-InternetExplorer-Optional-Package ? (si/no): "
if /i "%answer%"=="si" (
    powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-InternetExplorer-Optional-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
    powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-InternetExplorer-Optional-Package
)

:Microsoft-Windows-Kernel-LA57-FoD
set /p answer="Rimuovere Microsoft-Windows-Kernel-LA57-FoD ? (si/no): "
if /i "%answer%"=="si" (
  powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Kernel-LA57-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
  powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-Kernel-LA57-FoD
)

:Microsoft-Windows-LanguageFeatures-Handwriting
set /p answer="Rimuovere Microsoft-Windows-LanguageFeatures-Handwriting ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Handwriting*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-LanguageFeatures-Handwriting
)

:Microsoft-Windows-LanguageFeatures-OCR
set /p answer="Rimuovere Microsoft-Windows-LanguageFeatures-OCR ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-OCR*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-LanguageFeatures-OCR
)

:Microsoft-Windows-LanguageFeatures-Speech
set /p answer="Rimuovere Microsoft-Windows-LanguageFeatures-Speech ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-Speech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-LanguageFeatures-Speech
)

:Microsoft-Windows-LanguageFeatures-TextToSpeech
set /p answer="Rimuovere Microsoft-Windows-LanguageFeatures-TextToSpeech ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-LanguageFeatures-TextToSpeech*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-LanguageFeatures-TextToSpeech
)

:Microsoft-Windows-MediaPlayer-Package
set /p answer="Rimuovere Microsoft-Windows-MediaPlayer-Package ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-MediaPlayer-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-MediaPlayer-Package
)

:Microsoft-Windows-TabletPCMath-Package
set /p answer="Rimuovere Microsoft-Windows-TabletPCMath-Package ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-TabletPCMath-Package*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-TabletPCMath-Package
)

:Microsoft-Windows-Wallpaper-Content-Extended-FoD
set /p answer="Rimuovere Microsoft-Windows-Wallpaper-Content-Extended-FoD ? (si/no): "
if /i "%answer%"=="si" (
powershell -Command "Get-WindowsPackage -Path 'C:\mount\mount' | Where-Object {$_.PackageName -like 'Microsoft-Windows-Wallpaper-Content-Extended-FoD*'} | ForEach-Object {dism /image:C:\mount\mount /Remove-Package /PackageName:$($_.PackageName) /NoRestart | Out-Null}"
powershell -Command "Write-Host 'Completato!' -ForegroundColor Green; exit"  
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-Wallpaper-Content-Extended-FoD
)

:skipping_features
rem copy batch file
cls
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat ccopiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "Impossibile copiare tweaks.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloater
cls
copy "resources\debloat3.0.ps1" "C:\mount\mount\Windows"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.ps1 copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "Impossibile copiare Debloat.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

copy "resources\debloat.bat" "C:\mount\mount\Windows"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.bat ccopiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "Impossibile copiare Debloat.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

copy "resources\debloat_Windows_Italia.lnk" "C:\mount\mount\Windows"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.ink ccopiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "Impossibile copiare Debloat.ink!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy unpin_start_tiles.ps1
copy "resources\unpin_start_tiles.ps1" "C:\mount\mount\Windows"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unpin_start_tiles.ps1 ccopiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "Impossibile copiare Unpin_start_tiles.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem unmount the image
powerShell -Command "Write-Host 'Smontando l''immagine' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ######################################################################################## 

rem rebuild image 
powerShell -Command "Write-Host 'Creando la ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win10\boot\etfsboot.com#pEF,e,bC:\ISO\Win10\efi\microsoft\boot\efisys.bin C:\ISO\Win10 C:\ISO\Windows10_edited.iso
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO creata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile creare la ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy the iso and clean
copy "C:\ISO\Windows10_edited.iso" "C:\Users\%USERNAME%\Desktop"
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copiata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile copiare la ISO sul desktop!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Le directory usate per la creazione della ISO sono state eliminate con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile eliminare le directory usate per la creazione della ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Le directory usate per la creazione della ISO sono state eliminate con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile eliminare le directory usate per la creazione della ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

del "resources\unattend_edited.xml" /q
if %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unattend eliminato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) else (
  color 4 && echo "ERRORE: Impossibile eliminare unattend!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:delete_iso
set /p answer="Rimuovere la ISO originale di microsoft ? (si/no): "
if /i "%answer%"=="si" (
del "%filepath%" /q
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) else (
    echo I valori accettati sono solamente si e no.
    goto :delete_iso
)

powerShell -Command "Write-Host 'Processo completato! Press any key to exit' -ForegroundColor Green; exit"  
pause