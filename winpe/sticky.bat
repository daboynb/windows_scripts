@echo off

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS BYPASS
echo.
ECHO [1] Add an administrator account
ECHO [2] Change user password
echo.
SET /P MENU=Type 1, 2 then press ENTER :
IF /I '%MENU%'=='1' GOTO :ADMIN
IF /I '%MENU%'=='2' GOTO :CHANGE
GOTO :MAINMENU

:ADMIN
set /p username="Insert the username: "
net user /add "%username%" 
net localgroup administrators "%username%" /add
pause
shutdown /r /t 0

:CHANGE
set /p username="Insert the username: "
set /p password="Insert the password: "
net user "%username%" "%password%"
pause
exit