@echo off

rem Ask for admin privileges
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/c cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

echo "Stopping Windows Update Service..." 
net stop wuauserv  
for /r "C:\Windows\SoftwareDistribution\Download" %%F in (*) do (
    del /q /s "%%F"
)
echo "Starting Windows Update Service..." 
net start wuauserv  
echo "Done"
timeout 10