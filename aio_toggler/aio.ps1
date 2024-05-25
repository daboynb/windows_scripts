
# Run as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Checks 
$folderPath = "C:\Windows\scripts"

# Check if folder exists
if (-not (Test-Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath | Out-Null
}

# Get the PATH variable
$path = [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "User")

# Check if the directory is in the PATH
if ($path -match [regex]::Escape($folderPath)) {
    Write-Host "$folderPath is already in the PATH."
} else {
    Write-Host "$folderPath is not in the PATH. Adding..."
    [System.Environment]::SetEnvironmentVariable("PATH", "$path;$folderPath", "Machine")
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
}

# Ping Google to check internet connection
$pingResult = Test-Connection -ComputerName google.com -Count 1 -Quiet

# Delete old files
if ($pingResult) {

    $filePaths = @(
        "C:\Windows\scripts\PowerRun.exe",
        "C:\Windows\scripts\disable_defender.bat",
        "C:\Windows\scripts\enable_defender.bat",
        "C:\Windows\scripts\remove_edge.bat",
        "C:\Windows\scripts\remove_edge.ps1",
        "C:\Windows\scripts\reinstall_edge.bat",
        "C:\Windows\scripts\reinstall_edge.ps1"
    )
    Remove-Item $filePaths -Force -ErrorAction SilentlyContinue

}
# Check if ping was successful
if ($pingResult) {
    Write-Host "Internet connection is active."
    
    # Check if winget is installed
    function Install-WinGet() {

        $progressPreference = 'silentlyContinue'
    
        $wc = New-Object net.webclient
        $maxRetries = 3
    
        function DownloadFileWithRetries($url, $localPath) {
            $attempts = 0
            while ($attempts -lt $maxRetries) {
                try {
                    $wc.Downloadfile($url, $localPath)
                    Write-Output "Download of $localPath successful."
                    return $true
                } catch {
                    $attempts++
                    Write-Output "Download failed (attempt $attempts): $($_.Exception.Message)"
                    Start-Sleep -Seconds 2 
                }
            }
            return $false
        }
    
        # Download winget
        $msu_url = 'https://aka.ms/getwinget'
        $local_msu_url = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        if (-not (DownloadFileWithRetries $msu_url $local_msu_url)) {
            Write-Output "Unable to download $local_msu_url after $maxRetries attempts."
            return
        }
    
        # Download VCLibs
        $msu_url = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
        $local_msu_url = "Microsoft.VCLibs.x64.14.00.Desktop.appx"
        if (-not (DownloadFileWithRetries $msu_url $local_msu_url)) {
            Write-Output "Unable to download $local_msu_url after $maxRetries attempts."
            return
        }
    
        # Download Microsoft.UI.Xaml
        $msu_url = 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx'
        $local_msu_url = "Microsoft.UI.Xaml.2.8.x64.appx"
        if (-not (DownloadFileWithRetries $msu_url $local_msu_url)) {
            Write-Output "Unable to download $local_msu_url after $maxRetries attempts."
            return
        }
    
        # Install downloaded packages
        Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
        Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
        Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    }  

    if (Test-Path "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe") {
        Write-Output "Winget Already Installed"
    }  
    else {
        Write-Output "Installing Winget"
        Install-WinGet
    }

    function Download_Required_Files {
        param(
            [string]$sourceUrl,
            [string]$destinationPath,
            [string]$message
        )

        Write-Output $message
        try {
            $wc = New-Object net.webclient
            $wc.DownloadFile($sourceUrl, $destinationPath)
            Write-Output "Download successful: $destinationPath"
        } catch {
            Write-Output "Download failed: $($_.Exception.Message)"
        }
    }

    Write-Output "Checking and downloading required files..."

    # Define files to download
    $filesToDownload = @(
        # Powerrun
        @{ 'sourceUrl' = 'https://github.com/daboynb/windows_scripts/raw/main/windows_defender_manager/PowerRun.exe'; 'destinationPath' = 'C:\Windows\scripts\PowerRun.exe'; 'message' = "Downloading PowerRun..." },
        # Windows defender
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/windows_defender_manager/disable_defender.bat'; 'destinationPath' = 'C:\Windows\scripts\disable_defender.bat'; 'message' = "Downloading disable_defender.bat..." },
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/windows_defender_manager/enable_defender.bat'; 'destinationPath' = 'C:\Windows\scripts\enable_defender.bat'; 'message' = "Downloading enable_defender.bat..." },
        # Microsoft Edge
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/remove_edge_current/remove_edge.bat'; 'destinationPath' = 'C:\Windows\scripts\remove_edge.bat'; 'message' = "Downloading remove_edge.bat..." },
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/remove_edge_current/remove_edge.ps1'; 'destinationPath' = 'C:\Windows\scripts\remove_edge.ps1'; 'message' = "Downloading remove_edge.ps1..." },
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/remove_edge_current/reinstall_edge.bat'; 'destinationPath' = 'C:\Windows\scripts\reinstall_edge.bat'; 'message' = "Downloading reinstall_edge.bat..." },
        @{ 'sourceUrl' = 'https://raw.githubusercontent.com/daboynb/windows_scripts/main/remove_edge_current/reinstall_edge.ps1'; 'destinationPath' = 'C:\Windows\scripts\reinstall_edge.ps1'; 'message' = "Downloading reinstall_edge.ps1..." }
    )

    # Download files
    foreach ($file in $filesToDownload) {
        Download_Required_Files -sourceUrl $file['sourceUrl'] -destinationPath $file['destinationPath'] -message $file['message']
    }

    Write-Output "Download and setup completed."
} else {
    Write-Host "No internet connection."
    if (Test-Path "$env:LOCALAPPDATA\Microsoft\WindowsApps\winget.exe") {
        Write-Output "Winget Already Installed"
    }  
    else {
        Write-Output "We can't continue. There's no internet and no Winget."
    }
    
    # Define file paths
    $filePaths = @(
        "C:\Windows\scripts\PowerRun.exe",
        "C:\Windows\scripts\disable_defender.bat",
        "C:\Windows\scripts\enable_defender.bat",
        "C:\Windows\scripts\remove_edge.bat",
        "C:\Windows\scripts\remove_edge.ps1",
        "C:\Windows\scripts\reinstall_edge.bat",
        "C:\Windows\scripts\reinstall_edge.ps1"
    )

    # Iterate through each file path and check existence
    foreach ($filePath in $filePaths) {
        if (Test-Path $filePath) {
            Write-Host "$filePath exists."
        } else {
            Write-Host "$filePath does not exist."
            Write-Output "We can't continue. There's no internet connection, and you are missing some required files."
        }
    }
}

#################################### 
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Aio toggler"
$form.Size = New-Object System.Drawing.Size(330, 120) 
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'

# Set form background color to dark
$form.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)

# Set text color to white
$form.ForeColor = [System.Drawing.Color]::White

# Define the event handler to enable defender
$enable_defender_Click = {
    Start-Process -FilePath "C:\Windows\scripts\enable_defender.bat"
}

# Define the event handler to disable defender
$disable_defender_Click = {
    Start-Process -FilePath "C:\Windows\scripts\disable_defender.bat"
}

# Define the event handler to reinstall edge
$install_edge_Click = {
    Start-Process -FilePath "C:\Windows\scripts\reinstall_edge.bat"}

# Define the event handler to remove edge
$remove_edge_Click = {
    Start-Process -FilePath "C:\Windows\scripts\remove_edge.bat"
}

# Create download buttons for enable defender
$enable_defender = New-Object System.Windows.Forms.Button
$enable_defender.Location = New-Object System.Drawing.Point(10, 10)
$enable_defender.Size = New-Object System.Drawing.Size(140, 20)
$enable_defender.Text = "Enable defender"
$enable_defender.Add_Click($enable_defender_Click)
$form.Controls.Add($enable_defender)

$disable_defender = New-Object System.Windows.Forms.Button
$disable_defender.Location = New-Object System.Drawing.Point(160, 10)
$disable_defender.Size = New-Object System.Drawing.Size(140, 20)
$disable_defender.Text = "Disable defender"
$disable_defender.Add_Click($disable_defender_Click)
$form.Controls.Add($disable_defender)

# Create download buttons for install edge
$install_edge = New-Object System.Windows.Forms.Button
$install_edge.Location = New-Object System.Drawing.Point(10, 40)
$install_edge.Size = New-Object System.Drawing.Size(140, 20)
$install_edge.Text = "Install edge"
$install_edge.Add_Click($install_edge_Click)
$form.Controls.Add($install_edge)

# Create download buttons for remove edge
$remove_edge = New-Object System.Windows.Forms.Button
$remove_edge.Location = New-Object System.Drawing.Point(160, 40)
$remove_edge.Size = New-Object System.Drawing.Size(140, 20)
$remove_edge.Text = "Remove edge"
$remove_edge.Add_Click($remove_edge_Click)
$form.Controls.Add($remove_edge)

# Add event handler for OK button click
$form.Add_Shown({$form.Activate()})
$form.ShowDialog() | Out-Null
####################################