@echo off
setlocal

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem check for adks
IF NOT EXIST "C:\Program Files (x86)\Windows Kits" (
    color 4 && echo "ERROR: Can't find the adk folder" && pause && exit /b 1
)

rem Set the path of *.bat
set "HACK_BAT=%~dp0hack.bat"
set "sticky_BAT=%~dp0sticky.bat"
set "sticky_run_BAT=%~dp0sticky_run.bat"
set "detect_bat=%~dp0detect.bat"
set "findstr=%~dp0findstr.exe"

rem set adk path
SET adk_dir="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools"
SET adk_env="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat"
CD %adk_dir%
CALL %adk_env%

rem clean dism
dism /cleanup-wim 

rem copy boot files
CALL copype amd64 C:\WinPE_amd64

rem create folder
md C:\mount

rem mount boot.wim
dism /Mount-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"C:\mount"

rem copy files
copy "%HACK_BAT%" "C:\mount\Windows\System32"
copy "%sticky_BAT%" "C:\mount\Windows\System32"
copy "%sticky_run_BAT%" "C:\mount\Windows\System32"
copy "%detect_bat%" "C:\mount\Windows\System32"
copy "%findstr%" "C:\mount\Windows\System32"

rem unmount the image
dism /Unmount-Image /MountDir:"C:\mount" /commit

rem build the iso
CALL MakeWinPEMedia /ISO C:\WinPE_amd64 C:\WinPEx64.iso

rem clean leftovers
rmdir "C:\mount" /s /q
rmdir "C:\WinPE_amd64" /s /q

pause