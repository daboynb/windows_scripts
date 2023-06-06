# Change to the desktop directory
cd "$env:USERPROFILE\Desktop"

# Download the script from GitHub
Invoke-WebRequest -Uri "https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip" -OutFile "windows_script_daboynb.zip"

# Extract all from "windows_script_daboynb.zip"
Expand-Archive -Path "windows_script_daboynb.zip" -DestinationPath "." -Force

# Move the "win11_custom_iso_italian" folder to the current directory
Move-Item -Path "windows_scripts-main\win11_custom_iso_italian" -Destination "win11_custom_iso_italian" -Force

# Remove the "windows_scripts-main" directory 
Remove-Item -Path "windows_scripts-main" -Recurse -Force

# Remove the "windows_script_daboynb.zip" file 
Remove-Item -Path "windows_script_daboynb.zip" -Force

# Run the script
Start-Process -FilePath ".\win11_custom_iso_italian\create.bat"
