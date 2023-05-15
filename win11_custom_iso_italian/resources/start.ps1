# Richiede l'esecuzione con privilegi elevati
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$code = @"
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
"@

$userInput = Add-Type -MemberDefinition $code -Name UserInput -Namespace UserInput -PassThru

function Disable-UserInput {
    $userInput::BlockInput($true)
}

Write-Host -fore Green 'Il mouse e la tastiera verranno disabilitati fino al completamento delle operazioni'
Write-Host -fore Green 'Inizio'

while ($true) {
    $process = Get-Process -Name SecurityHealthSystray -ErrorAction SilentlyContinue

    if ($process) {
        Write-Host "SecurityHealthSystray is running."
        break  # Exit the loop
    }
    
    Start-Sleep -Seconds 3  # Wait for 1 second before checking again
}

# Disabilita l'input dell'utente
Disable-UserInput

# Avvia il tuo batch file
Start-Process -FilePath "C:\Windows\tweaks.bat" -Wait