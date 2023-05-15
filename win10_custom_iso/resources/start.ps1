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

Write-Host -fore Green 'Press Enter to complete the installation, mouse and keyboard won''t be available until the process is finished'

# Disabilita l'input dell'utente
Disable-UserInput

while ($true) {
    $process1 = Get-Process -Name SecurityHealthSystray -ErrorAction SilentlyContinue
    $process2 = Get-Process -Name OneDrive -ErrorAction SilentlyContinue

    if ($process1 -and $process2) {
        break
    }

    Start-Sleep -Seconds 3
}

# Avvia il tuo batch file
Start-Process -FilePath "C:\Windows\tweaks.bat" -Wait