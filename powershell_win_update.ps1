Install-PackageProvider -Name NuGet -Confirm:$False -Force | out-null 
Install-Module PSWindowsUpdate -Confirm:$False -Force | out-null 

$kb="(Get-WindowsUpdate).kb"

if ( $kb -eq $null ) 
{
    Write-Host "No updates" 
}
else
{
    Write-Host "Start updating"
    (Get-WindowsUpdate).kb | ForEach-Object { 
        Install-WindowsUpdate -AcceptAll  -AutoReboot | out-null 
    }
} 