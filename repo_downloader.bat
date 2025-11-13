@echo off

IF exist "C:\Users\%USERNAME%\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\Desktop"
)

IF exist "C:\Users\%USERNAME%\OneDrive\Desktop" (
  set "path_to_use=C:\Users\%USERNAME%\OneDrive\Desktop"
)

IF exist "%path_to_use%\windows_scripts-old_branch" (
  rmdir /s /q "%path_to_use%\windows_scripts-old_branch"
)

powershell -command "$wc = New-Object net.webclient; $wc.DownloadFile('https://github.com/daboynb/windows_scripts/archive/refs/heads/old_branch.zip', '%path_to_use%\old_branch.zip'.Replace('path_to_use', '%path_to_use%'))"
powershell -command "Expand-Archive -Path '%path_to_use%\old_branch.zip' -DestinationPath '%path_to_use%' -Force"

del /f "%path_to_use%\old_branch.zip"

echo "The downloaded folder is located on %path_to_use%"

timeout 04