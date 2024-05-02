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

###############################################

# Start bat
Start-Process -FilePath "C:\Windows\scripts\tweaks.bat" -Wait