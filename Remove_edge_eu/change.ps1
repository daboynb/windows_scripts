
# Run as admin
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

function Install-WinGet() {
$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}

if (Test-Path ~\AppData\Local\Microsoft\WindowsApps\winget.exe){
    Write-Host 'Winget Already Installed'
    }  
    else{
    Write-Host 'Installing Winget'
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
    Stop-Process -Name "MsEdge" -Force -ErrorAction SilentlyContinue | Out-Null

    # Uninstall with winget
    winget uninstall "Microsoft Edge" --accept-source-agreements --silent | out-null

    Write-Host "Done, file edited."
    Write-Host "If Edge is still present, that means you have not installed the KB that enables that feature."
    Write-Host "Please install the latest updates from Windows Update and retry."
    
    Start-Sleep 05

}
else {
    # File does not exist
    Write-Host "The file $integratedServicesPath does not exist. Install the latest updates from windows update and retry!"
    Start-Sleep 05
    exit
}