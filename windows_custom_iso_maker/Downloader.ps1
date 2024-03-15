if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "irm -Uri https://shorturl.at/xEFS6 | iex"
    break
}

$folderPath = "C:\Windows_iso_maker"

if (Test-Path -Path $folderPath -PathType Container) {
    Remove-Item -Path "C:\Windows_iso_maker" -Recurse -Force
} 

mkdir "C:\Windows_iso_maker"

$path_to_use = "C:\Windows_iso_maker"

Set-Location $path_to_use

# Download the script from GitHub
$wc = New-Object net.webclient
$msu_url = 'https://github.com/daboynb/windows_scripts/archive/refs/heads/main.zip'
$local_msu_url = "$path_to_use\windows_script_daboynb.zip"
$wc.Downloadfile($msu_url, $local_msu_url)

# Extract all from "windows_script_daboynb.zip"
Expand-Archive -Path "windows_script_daboynb.zip" -DestinationPath "." -Force

# Move the "windows_custom_iso_maker" folder to the current directory
Move-Item -Path "windows_scripts-main\windows_custom_iso_maker" -Destination "windows_custom_iso_maker" -Force

# Remove the "windows_scripts-main" directory 
Remove-Item -Path "windows_scripts-main" -Recurse -Force

# Remove the "windows_script_daboynb.zip" file 
Remove-Item -Path "windows_script_daboynb.zip" -Force

# Run the script
Start-Process -FilePath ".\windows_custom_iso_maker\Menu.bat"