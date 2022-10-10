# Remove all apps except calculator, photo and store
$ErrorActionPreference = 'SilentlyContinue'
Write-Output "Removing apps... Please wait. You will be notified when it's done"
Get-AppxPackage -AllUsers |
Where-Object {$_.name -notmatch 'Microsoft.VP9VideoExtensions|Microsoft.WebMediaExtensions|Microsoft.WebpImageExtension|Microsoft.Windows.ShellExperienceHost|Microsoft.VCLibs*|Microsoft.DesktopAppInstaller|Microsoft.StorePurchaseApp|Microsoft.Windows.Photos|Microsoft.WindowsStore|Microsoft.XboxIdentityProvider|Microsoft.WindowsCamera|Microsoft.WindowsCalculator|Microsoft.HEIFImageExtension|Microsoft.UI.Xaml*'} |
Remove-AppxPackage 
Get-AppxPackage -allusers *Microsoft.WindowsStore* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”} 
Get-AppxPackage -allusers *Microsoft.Windows.Photos* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”} 
Get-AppxPackage -allusers *Microsoft.WindowsCalculator* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register “$($_.InstallLocation)\AppXManifest.xml”} 
Write-Output "Done"