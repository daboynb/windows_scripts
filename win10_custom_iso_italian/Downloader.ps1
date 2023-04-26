# Download the from GitHub repository 
Invoke-WebRequest -Uri "https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip" -OutFile "windows_script_daboynb.zip"

# Extract all from "windows_script_daboynb.zip"
Expand-Archive -Path "windows_script_daboynb.zip" -DestinationPath "." -Force

# Move the "win10_custom_iso_italian" folder to the current directory
Move-Item -Path "./windows_scripts-main/win10_custom_iso_italian" -Destination "./win10_custom_iso_italian" -Force

# Remove the "./windows_scripts-main/" directory 
Remove-Item -Path "./windows_scripts-main" -Recurse -Force

# Remove  "windows_script_daboynb.zip" file 
Remove-Item -Path "./windows_script_daboynb.zip" -Force

# Run it
win10_custom_iso_italian\win10_custom_iso_Italian.bat
