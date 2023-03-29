@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem create folders
mkdir "C:\mount\mount" 
mkdir "C:\ISO" 
mkdir "C:\ISO\Win11" 

rem set iso path
set /p iso_path="Please enter the path to your ISO file: "
echo Extracting ISO contents to C:\ISO\Win11...
"C:\Program Files\WinRAR\WinRAR.exe" x "%iso_path%" "C:\ISO\Win11"
echo ISO extraction complete!
 
rem mount image
dism /Get-WimInfo /WimFile:C:\ISO\Win11\sources\boot.wim
set /p index="Please enter thenumber of the index: "
dism /mount-wim /wimfile:"C:\ISO\Win11\sources\boot.wim" /index:%index% /mountdir:C:\mount\mount

rem copy unattended.xml
copy unattend.xml "C:\ISO\Win11\sources\$OEM$\$$\Panther\unattend.xml"

rem add the stuff that requires the image to be mounted

rem unmount image
dism /unmount-wim /mountdir:C:\mount\mount /commit

rem rebuild image
cd "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg"
oscdimg -m -o -u2 -bootdata:2#p0,e,bC:\ISO\Win11\boot\etfsboot.com#pEF,e,bC:\ISO\Win11\efi\microsoft\boot\efisys.bin C:\ISO\Win11 C:\ISO\Windows11_edited.iso
