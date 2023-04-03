@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem check the requirements
IF NOT EXIST "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit" (
    echo " Adk not found! Install the requirements"
    pause && exit
)

IF NOT EXIST "C:\Program Files\WinRAR\WinRAR.exe" (
    echo "Winrar not found! Install the requirements"
    pause && exit
)

rem create folder
mkdir "C:\ISO\Win11" 

rem set iso path
set "filepath="
set "dialogTitle=Select a file"

rem Open file dialog to select file
echo "Select an ISO file"
echo "Wait for explorer to open"
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'All files (*.*)|*.*'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  echo You selected %filepath%
) else (
  echo No file selected.
)

echo Extracting ISO contents to C:\ISO\Win11...
"C:\Program Files\WinRAR\WinRAR.exe" x "%filepath%" "C:\ISO\Win11"
echo ISO extraction complete!

IF NOT EXIST "C:\ISO\Win11\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win11\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy unattend.xml C:\ISO\Win11\sources\$OEM$\$$\Panther

rem rebuild image
cd "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"
oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 C:\ISO\Windows11_edited.iso

rem copy the iso and clean
copy "C:\ISO\Windows11_edited.iso" "C:\Users\%USERNAME%\Desktop"
rmdir "C:\ISO" /s /q

color 0A
echo "Process completed!"
timeout 04