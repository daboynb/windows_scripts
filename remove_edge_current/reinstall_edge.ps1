
# Run as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Check if winget is installed
function Install-WinGet() {

    $progressPreference = 'silentlyContinue'

    $wc = New-Object net.webclient

    try {
        # Download winget
        $msu_url = 'https://aka.ms/getwinget'
        $local_msu_url = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        $wc.Downloadfile($msu_url, $local_msu_url)
        Write-Output "Download of $local_msu_url successful."

        # Download VCLibs
        $msu_url = 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'
        $local_msu_url = "Microsoft.VCLibs.x64.14.00.Desktop.appx"
        $wc.Downloadfile($msu_url, $local_msu_url)
        Write-Output "Download of $local_msu_url successful."

        # Download Microsoft.UI.Xaml
        $msu_url = 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx'
        $local_msu_url = "Microsoft.UI.Xaml.2.8.x64.appx"
        $wc.Downloadfile($msu_url, $local_msu_url)
        Write-Output "Download of $local_msu_url successful."

    } catch {
        Write-Output "Download failed: $($_.Exception.Message)"
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

winget install "Microsoft.Edge" --accept-source-agreements --silent --source winget | out-null