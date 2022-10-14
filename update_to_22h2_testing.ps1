reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassCPUCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassStorageCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /f /t REG_DWORD /d 1 > nul
reg add "HKLM\SYSTEM\Setup\MoSetup" /v "AllowUpgradesWithUnsupportedTPMOrCPU" /f /t REG_DWORD /d 1 > nul

net stop wuauserv | out-null 
Get-ChildItem -LiteralPath C:\Windows\SoftwareDistribution\Download -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
net start wuauserv | out-null 

curl.exe https://download.microsoft.com/download/9/a/b/9ab525a1-fe83-4d05-9b7f-0c3250e2fe35/Windows11InstallationAssistant.exe --output Windows11InstallationAssistant.exe

.\Windows11InstallationAssistant.exe
