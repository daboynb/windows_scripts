# Set the path for the desktop folder
$desktopPath = [Environment]::GetFolderPath("Desktop")

# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip" -OutFile "$desktopPath\windows_script_daboynb.zip"

# Extract all from "windows_script_daboynb.zip" to the desktop
Expand-Archive -Path "$desktopPath\windows_script_daboynb.zip" -DestinationPath "$desktopPath" -Force

# Move the "win10_custom_iso_italian" folder to the desktop
Move-Item -Path "$desktopPath\windows_scripts-main\win10_custom_iso_italian" -Destination "$desktopPath\win10_custom_iso_italian" -Force

# Remove the "./windows_scripts-main/" directory
Remove-Item -Path "$desktopPath\windows_scripts-main" -Recurse -Force

# Remove "windows_script_daboynb.zip" file
Remove-Item -Path "$desktopPath\windows_script_daboynb.zip" -Force

# Execute the script
Start-Process -FilePath "$desktopPath\win10_custom_iso_italian\win10_custom_iso_Italian.bat"
