
# Run as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$ErrorActionPreference = "SilentlyContinue"

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

# That's the JSON where the configs are stored
$integratedServicesPath = "C:\Windows\System32\IntegratedServicesRegionPolicySet.json"

if (Test-Path $integratedServicesPath) {

    # Get the permissions (ACL) of the original file
    $acl = Get-Acl -Path $integratedServicesPath

    # Take ownership of the file
    takeown /f $integratedServicesPath /a 

    # Grant the full control to be able to edit it
    icacls $integratedServicesPath /grant Administrators:F

    # Read the JSON
    $jsonContent = Get-Content $integratedServicesPath | ConvertFrom-Json

    # Edit the JSON to allow uninstall
    foreach ($policy in $jsonContent.policies) {
        if ($policy.'$comment' -like "*Edge*" -and $policy.'$comment' -like "*uninstall*") {
            $policy.defaultState = 'enabled'
            # Set region to all ISO 3166-1 alpha-2 country codes
            $allCountryCodes = @("AT", "BE", "BG", "CH", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GF", "GP", "GR", "HR", "HU", "IE", "IS", "IT", "LI", "LT", "LU", "LV", "MT", "MQ", "NL", "NO", "PL", "PT", "RE", "RO", "SE", "SI", "SK", "YT", "AD", "AE", "AF", "AG", "AI", "AL", "AM", "AO", "AQ", "AR", "AS", "AU", "AW", "AX", "AZ", "BA", "BB", "BD", "BF", "BH", "BI", "BJ", "BL", "BM", "BN", "BO", "BQ", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD", "CF", "CG", "CI", "CK", "CL", "CM", "CN", "CO", "CR", "CU", "CV", "CW", "CX", "DJ", "DM", "DO", "DZ", "EC", "EG", "EH", "ER", "ET", "FK", "FM", "FO", "GA", "GB", "GD", "GE", "GG", "GH", "GI", "GL", "GM", "GN", "GQ", "GS", "GT", "GU", "GW", "GY", "HK", "HM", "HN", "HT", "ID", "IL", "IM", "IN", "IO", "IQ", "IR", "JE", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW", "KY", "KZ", "LA", "LB", "LC", "LK", "LR", "LS", "LY", "MA", "MC", "MD", "ME", "MF", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MR", "MS", "MU", "MV", "MW", "MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PM", "PN", "PR", "PS", "PW", "PY", "QA", "RE", "RS", "RU", "RW", "SA", "SB", "SC", "SD", "SG", "SH", "SJ", "SL", "SM", "SN", "SO", "SR", "SS", "ST", "SV", "SX", "SY", "SZ", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL", "TM", "TN", "TO", "TT", "TV", "TW", "TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "YE", "YT", "ZA", "ZM", "ZW")
            $policy.conditions.region.enabled = $allCountryCodes
        }
    }

    # Write the JSON file to another location to avoid the 'permission denied' error
    $jsonContent | ConvertTo-Json -Depth 100 | Set-Content -Path "C:\BK_IntegratedServicesRegionPolicySet.json"

    # Move the new JSON file to C:\Windows\System32\IntegratedServicesRegionPolicySet.json
    Copy-Item C:\BK_IntegratedServicesRegionPolicySet.json C:\Windows\System32\IntegratedServicesRegionPolicySet.json

    # Set the original permissions to the new file
    Set-Acl -Path $integratedServicesPath -AclObject $acl

    # Kill edge processes
    Stop-Process -Name "MsEdge" -Force | Out-Null

    # Uninstall with winget
    winget uninstall "Microsoft.Edge" --accept-source-agreements --silent | Out-Null
    winget uninstall --name "Microsoft Edge" --accept-source-agreements --silent | Out-Null

    # Start the Microsoft Edge process
    Start-Process -Name "MsEdge"
    Start-Sleep 03

    # Check if Microsoft Edge is running
    if (Get-Process -Name "MsEdge") {
        Write-Host "You have not installed the KB that enables that feature."
        Write-Host "Please install the latest updates from Windows Update and retry."
        Start-Sleep 5
    } else {
        Write-Host "Microsoft Edge was removed succesfully!"
        Start-Sleep 5
    }

}
else {
    # File does not exist
    Write-Host "The file $integratedServicesPath does not exist."
    Write-Host "Install the latest updates from windows update and retry!"
    Start-Sleep 05
    exit
}