@echo off

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

IF exist "%path_to_use%\windows_scripts-main" (
  rmdir /s /q "%path_to_use%\windows_scripts-main"
)

powershell -command "$wc = New-Object net.webclient; $wc.DownloadFile('https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip', '%path_to_use%\main.zip'.Replace('path_to_use', '%path_to_use%'))"
powershell -command "Expand-Archive -Path '%path_to_use%\main.zip' -DestinationPath '%path_to_use%' -Force"

del /f "%path_to_use%\main.zip"

echo "The downloaded folder is located on %path_to_use%"

timeout 04