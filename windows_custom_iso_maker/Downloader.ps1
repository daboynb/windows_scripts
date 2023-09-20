# Change to the desktop directory
cd "$env:USERPROFILE\Desktop"

# Download the script from GitHub
$url = "https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip"
$outputFile = "windows_script_daboynb.zip"

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($url, $outputFile)

# Extract all from "windows_script_daboynb.zip"
Expand-Archive -Path "windows_script_daboynb.zip" -DestinationPath "." -Force

# Move the "windows_custom_iso_maker" folder to the current directory
Move-Item -Path "windows_scripts-main\windows_custom_iso_maker" -Destination "windows_custom_iso_maker" -Force

# Remove the "windows_scripts-main" directory 
Remove-Item -Path "windows_scripts-main" -Recurse -Force

# Remove the "windows_script_daboynb.zip" file 
Remove-Item -Path "windows_script_daboynb.zip" -Force

# Run the script
Start-Process -FilePath ".\windows_custom_iso_maker\Runme.bat"