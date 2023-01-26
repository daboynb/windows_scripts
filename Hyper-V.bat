@echo off
"%SYSTEMROOT%\system32\config\system" >nul 2>&1
If %errorLevel% NEQ 0 (
 echo "Please run as admin" 
 pause 
) 
for %%f in ( %SystemRoot%\servicing\Packages\*Hyper-V*.mum) do dism /online /norestart /add-package:"%%f" 
dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL 
pause