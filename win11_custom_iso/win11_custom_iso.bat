@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem create folder
mkdir "C:\ISO\Win11" 2>nul
if %errorlevel% equ 0 (
  powershell write-host -fore Green "C:\ISO\Win11 created successfully!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't create C:\ISO\Win11!" && exit /b 1
)

rem set iso path
set "filepath="
set "dialogTitle=Select a file"

rem Open file dialog to select file
:select_file
powershell write-host -fore Green Select an ISO file
for /f "usebackq delims=" %%f in (`powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog; $openFileDialog.InitialDirectory = [Environment]::GetFolderPath('Desktop'); $openFileDialog.Title = '%dialogTitle%'; $openFileDialog.Filter = 'All files (*.*)|*.*'; $openFileDialog.FilterIndex = 1; $openFileDialog.Multiselect = $false; $openFileDialog.ShowDialog() | Out-Null; $openFileDialog.FileName}"`) do set "filepath=%%f"

if defined filepath (
  powershell write-host -fore Green "You selected %filepath%"
  cls
) else (
  echo No file selected
  goto :select_file
)

powershell write-host -fore Green "Extracting ISO to C:\ISO\Win11... Please wait"
executables\7z.exe x -y -o"C:\ISO\Win11" "%filepath%" > nul
if %errorlevel% equ 0 (
  powershell write-host -fore Green "ISO extraction completed!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Extraction failed!" && exit /b 1
)

IF NOT EXIST "C:\ISO\Win11\sources\$OEM$\$$\Panther" (
    mkdir "C:\ISO\Win11\sources\$OEM$\$$\Panther"
)

rem copy unattended.xml
copy unattend.xml C:\ISO\Win11\sources\$OEM$\$$\Panther
if %errorlevel% equ 0 (
  powershell write-host -fore Green "unattend.xml successfully copied!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't copy unattend.xml!" && exit /b 1
)

rem export windows edition
dism /Get-WimInfo /WimFile:C:\ISO\Win11\sources\install.wim
echo.
powershell write-host -fore Green "Select the windows version you want to use"
echo.
set /p index="Please enter the number of the index: "
cls
powershell write-host -fore Green "Exporting"
dism /Export-Image /SourceImageFile:"C:\ISO\Win11\sources\install.wim" /SourceIndex:%index% /DestinationImageFile:"C:\ISO\Win11\sources\install_pro.wim" /compress:max
if %errorlevel% equ 0 (
  powershell write-host -fore Green "Image exported successfully!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't export the image!" && exit /b 1
)

rem copy the new install.wim
del "C:\ISO\Win11\sources\install.wim"
if %errorlevel% equ 0 (
  powershell write-host -fore Green "Old install.wim deleted!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't delete the old install.wim!" && exit /b 1
)
move "C:\ISO\Win11\sources\install_pro.wim" "C:\ISO\Win11\sources\install.wim"
if %errorlevel% equ 0 (
  powershell write-host -fore Green "The new install.wim is now inside the ISO!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't move the new install.wim!" && exit /b 1
)

rem rebuild image 
powershell write-host -fore Green "Building the ISO"
executables\oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 C:\ISO\Windows11_edited.iso
if %errorlevel% equ 0 (
  powershell write-host -fore Green "ISO builded successfully!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't build the ISO!" && exit /b 1
)

rem copy the iso and clean
copy "C:\ISO\Windows11_edited.iso" "C:\Users\%USERNAME%\Desktop"
if %errorlevel% equ 0 (
  powershell write-host -fore Green "ISO copied on the desktop!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't copy the ISO to the desktop!" && exit /b 1
)
rmdir "C:\ISO" /s /q
if %errorlevel% equ 0 (
  powershell write-host -fore Green "Working folder successfully deleted!" && timeout 04 >nul && cls
) else (
  powershell write-host -fore Red "ERROR: Can't delete the working folder!" && exit /b 1
)

color 0A && echo "Process completed! Press any key to exit"
pause