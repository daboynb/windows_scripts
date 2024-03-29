#################################### run as admin
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "irm -Uri https://raw.githubusercontent.com/daboynb/windows_scripts/main/windows_custom_iso_maker/downloader.ps1 | iex"
    break
}
####################################

#################################### Set cli
Set-ExecutionPolicy Unrestricted -Force
[console]::WindowWidth=80; 
[console]::WindowHeight=40; 
[console]::BufferWidth=[console]::WindowWidth
$Host.ui.rawui.backgroundcolor = "Black"
$Host.ui.rawui.foregroundcolor = "Green"
Clear-Host
####################################

#################################### download script
Write-Output "Downloading, please be patient"

# Set location without displaying it
Set-Location C:\ | Out-Null

# Check if the directory exists
if (Test-Path "C:\windows_custom_iso_maker") {
    Remove-Item -Path "C:\windows_custom_iso_maker" -Recurse -Force
}

# Download the script from GitHub
$wc = New-Object net.webclient
$msu_url = 'https://codeload.github.com/daboynb/windows_scripts/zip/refs/heads/main'
$local_msu_url = "C:\windows_script_daboynb.zip"
$wc.Downloadfile($msu_url, $local_msu_url)

# Extract all from "windows_script_daboynb.zip"
Expand-Archive -Path "windows_script_daboynb.zip" -DestinationPath "." -Force

# Move the "windows_custom_iso_maker" folder to the current directory
Move-Item -Path "windows_scripts-main\windows_custom_iso_maker" -Destination "windows_custom_iso_maker" -Force

# Remove the "windows_scripts-main" directory 
Remove-Item -Path "windows_scripts-main" -Recurse -Force

# Remove the "windows_script_daboynb.zip" file 
Remove-Item -Path "windows_script_daboynb.zip" -Force

Set-Location "C:\windows_custom_iso_maker" | Out-Null

# Extract FF portable
Clear-Host
Write-Output "Extracting Firefox"
C:\windows_custom_iso_maker\win10_custom_iso\resources\7z.exe x *.zip* -oPortable | Out-Null
####################################

#################################### edit quickedit
# Set the registry key path
$regKeyPath = "HKCU:\Console"
$valueName = "QuickEdit"
$valueData = 0

# Create the registry value
New-ItemProperty -Path $regKeyPath -Name $valueName -Value $valueData -PropertyType DWORD -Force | Out-Null
####################################

#################################### start the gui
Clear-Host

Start-Process -FilePath "powershell.exe" -ArgumentList "-WindowStyle Hidden", "-File", "C:\windows_custom_iso_maker\gui.ps1"

exit