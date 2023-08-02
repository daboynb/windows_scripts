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
set "files=7z.dll 7z.exe Debloat_Windows_Italia.lnk debloat3.1.ps1 firefox_installer.exe oscdimg.exe tweaks.bat unattend.xml start.ps1 PowerRun.exe"

for %%i in (%files%) do (
  if not exist "%resource_dir%\%%i" (
    color 4 && echo "ERRORE: Mancano dei file dentro la cartella resources" && pause && exit /b 1
    goto :EOF
  )
)

rem Download iso
:iso
powerShell -Command "Write-Host 'Le iso stock di windows 10 e 11 sono necessarie per questo script, scaricarle (si/no)' -ForegroundColor Green; exit"
set /p answer=":"
if /i "%answer%"=="si" (
    start "" "https://onedrive.live.com/?authkey=%21AP24oPyBwZAQ0VQ&id=FAE869A1D69A7846%212063&cid=FAE869A1D69A7846&parId=root&parQt=sharedby&o=OneUp"
    start "" "https://onedrive.live.com/?authkey=%21ANcjojTuUiXQBJE&cid=FAE869A1D69A7846&id=FAE869A1D69A7846%212064&parId=FAE869A1D69A7846%212062&o=OneUp"
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
IF EXIST "C:\ISO\Win11" (
    echo "ERRORE: C:\ISO\Win11 esiste gia', elimina la cartella prima di procedere" && timeout 04 >nul && cls && goto :winfolder 
)

:mountfolder
IF EXIST "C:\mount\mount" (
    echo "ERRORE: C:\mount\mount esiste gia', elimina la cartella prima di procedere" && timeout 04 >nul && cls && goto :mountfolder 
)

rem create folder
mkdir "C:\ISO\Win11" 2>nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'C:\ISO\Win11 creata correttamente!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare C:\ISO\Win11!" && pause && exit /b 1
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
powerShell -Command "Write-Host 'Seleziona il file iso di windows 11' -ForegroundColor Green; exit"  
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'ISO files (*.iso)|*.iso'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  powerShell -Command "Write-Host 'Hai selezionato %filepath%' -ForegroundColor Green; exit"  
  cls
) ELSE (
  echo Nessun file selezionato
  goto :select_file
)

powerShell -Command "Write-Host 'Sto estraendo la iso in C:\ISO\Win11... Attendi!' -ForegroundColor Green; exit"  
resources\7z.exe x -y -o"C:\ISO\Win11" "%filepath%" > nul
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Estrazione della ISO completata!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Estrazione fallita!" && pause && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem Open file dialog to select file
:select_file
powerShell -Command "Write-Host 'Seleziona il file iso di win 10' -ForegroundColor Green; exit"  
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

rem edit unattend.xml
powershell -command "Write-Host 'Inserisci il nome che desideri per l''utente di windows' -ForegroundColor Green; $newName = Read-Host ':'; (Get-Content -path resources\unattend.xml -Raw) -replace 'nomeutente',$newName | Set-Content -Path resources\unattend_edited.xml"

rem copy unattended.xml
copy "resources\unattend_edited.xml" "C:\ISO\Win10\sources\$OEM$\$$\Panther\unattend.xml"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'unattend.xml copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare unattend.xml!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
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
powerShell -Command "Write-Host 'Seleziona la versione di windows da usare' -ForegroundColor Green; exit"
echo.
set /p index="Inserisci il numero corrispondente: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor Green; exit"
dism /export-image /SourceImageFile:"C:\ISO\Win11\sources\install.esd" /SourceIndex:%index% /DestinationImageFile:C:\ISO\Win11\sources\install.wim /Compress:max /CheckIntegrity
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :copy_esd

:wim
rem export windows edition
dism /Get-WimInfo /WimFile:C:\ISO\Win11\sources\install.wim
echo.
powerShell -Command "Write-Host 'Seleziona la versione di windows da usare' -ForegroundColor Green; exit"
echo.
set /p index="Inserisci il numero corrispondente: "
cls
powerShell -Command "Write-Host 'Attendi' -ForegroundColor Green; exit"  
dism /Export-Image /SourceImageFile:"C:\ISO\Win11\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install_pro.wim" /compress:max
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Immagine esportata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile esportare l''immagine!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:copy_wim
rem copy the new install.wim
del "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.wim eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

move "C:\ISO\Win11\sources\install_pro.wim" "C:\ISO\Win11\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Il nuovo install.wim e'' stato spostato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile spostare il nuovo install.wim!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
goto :mountstep

:copy_esd
rem del esd
del "C:\ISO\Win11\sources\install.esd"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Old install.esd eliminato!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare old install.esd!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

:mountstep
rem mount the image with dism
powerShell -Command "Write-Host 'Sto montando l''immagine' -ForegroundColor Green; exit"  
dism /mount-image /imagefile:"C:\ISO\Win11\sources\install.wim" /index:1 /mountdir:"C:\mount\mount"
cls

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
  color 4 && echo "ERRORE: Impossibile copiare l''installer di firefox!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:features
powerShell -Command "Write-Host 'Lista delle funzionalita'' che possono essere rimosse :' -ForegroundColor Green;
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
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
) ELSE (
    echo I valori accettati sono solamente si e no.
    goto :Microsoft-Windows-Wallpaper-Content-Extended-FoD
)

:skipping_features
rem copy batch file
cls
copy "resources\tweaks.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'tweaks.bat copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare tweaks.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy debloater
cls
copy "resources\debloat3.1.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.ps1 copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare Debloat.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

copy "resources\debloat.bat" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.bat copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare Debloat.bat!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

copy "resources\debloat_Windows_Italia.lnk" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Debloat.ink copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare Debloat.ink!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy start.ps1
copy "resources\start.ps1" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'start.ps1 copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare start.ps1!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

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

rem copy PowerRun.exe
copy "resources\PowerRun.exe" "C:\mount\mount\Windows"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'PowerRun.exe copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "Impossibile copiare PowerRun.exe!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem unmount the image
powerShell -Command "Write-Host 'Smontando l''immagine' -ForegroundColor Green; exit"  
dism /unmount-image /mountdir:"C:\mount\mount" /commit
cls

rem ########################################################################################

del "C:\ISO\Win10\sources\install.wim"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'install.wim eliminato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare install.wim !" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)
copy "C:\ISO\Win11\sources\install.wim" "C:\ISO\Win10\sources" 
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'install.wim copiato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare install.wim !" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem ######################################################################################## 

rem rebuild image 
powerShell -Command "Write-Host 'Creando la ISO' -ForegroundColor Green; exit"  
resources\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win10\boot\etfsboot.com#pEF,e,bC:\ISO\Win10\efi\microsoft\boot\efisys.bin C:\ISO\Win10 C:\ISO\Windows11_edited.iso
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO creata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile creare la ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rem copy the iso and clean
copy "C:\ISO\Windows11_edited.iso" "C:\Users\%USERNAME%\Desktop"
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'ISO copiata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile copiare la ISO sul desktop!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\ISO" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory1 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare la directory1 usata per la creazione della ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

rmdir "C:\mount" /s /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'La directory2 usata per la creazione della ISO e'' stata eliminata con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare la directory2 usatq per la creazione della ISO!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

del "resources\unattend_edited.xml" /q
IF %errorlevel% equ 0 (
  powerShell -Command "Write-Host 'Unattend eliminato con successo!' -ForegroundColor Green; exit" && timeout 04 >nul && cls
) ELSE (
  color 4 && echo "ERRORE: Impossibile eliminare unattend!" && pause && del "resources\unattend_edited.xml" /q && rmdir "C:\mount" /s /q && rmdir "C:\ISO" /s /q && exit /b 1
)

:delete_iso
set /p answer="Rimuovere la ISO originale di microsoft ? (si/no): "
if /i "%answer%"=="si" (
del "%filepath%" /q
) else if /i "%answer%"=="no" (
    echo "Saltiamo questo passaggio..."
) ELSE (
    echo I valori accettati sono solamente si e no.
    goto :delete_iso
)

:: Enable QuickEdit Mode
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f

powerShell -Command "Write-Host 'Processo completato! Press any key to exit' -ForegroundColor Green; exit"  
pause