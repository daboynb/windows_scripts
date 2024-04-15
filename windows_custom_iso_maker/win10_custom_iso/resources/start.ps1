# Ask for admin privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

########################################################

# Disable quick edit mode
Add-Type -MemberDefinition @"
[DllImport("kernel32.dll", SetLastError=true)]
public static extern bool SetConsoleMode(IntPtr hConsoleHandle, int mode);
[DllImport("kernel32.dll", SetLastError=true)]
public static extern IntPtr GetStdHandle(int handle);
"@ -Namespace Win32 -Name NativeMethods

$Handle = [Win32.NativeMethods]::GetStdHandle(-10)
$success = $false

while (-not $success) {
    $success = [Win32.NativeMethods]::SetConsoleMode($Handle, 0x0080)

    if ($success) {
        Write-Host "Quick Edit mode has been disabled."
    } else {
        Write-Host "Failed to disable Quick Edit mode. Retrying..."
        Start-Sleep -Seconds 3
    }
}

########################################################

# check for process
Write-Host -fore Green 'The debloat process will start shortly, the mouse and keyboard will be disabled until the operations are completed'

while ($true) {
    $process = Get-Process -Name SecurityHealthSystray -ErrorAction SilentlyContinue

    if ($process) {
        Write-Host "SecurityHealthSystray is running."
        break  # Exit the loop
    }
    
    Start-Sleep -Seconds 3  # Wait for 1 second before checking again
}

########################################################

# Block user input
$code = @"
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
"@

$userInput = Add-Type -MemberDefinition $code -Name UserInput -Namespace UserInput -PassThru

function Disable-UserInput {
    $userInput::BlockInput($true)
}

# Disable user Input
Disable-UserInput

Start-Sleep -Seconds 30 | Out-Null

######################################################################### Allow edge unistall
# Check if the current PowerShell session has administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # If not, relaunch the script with elevated permissions
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
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
    copy C:\BK_IntegratedServicesRegionPolicySet.json C:\Windows\System32\IntegratedServicesRegionPolicySet.json

    # Set the original permissions to the new file
    Set-Acl -Path $integratedServicesPath -AclObject $acl
}
else {
    # File does not exist
    Write-Host "The file $integratedServicesPath does not exist."
}
#########################################################################

# Start bat
Start-Process -FilePath "C:\Windows\tweaks.bat" -Wait