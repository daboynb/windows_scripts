Write-Output "Removing the store... Please wait."
Get-AppxPackage *windowsstore* | Remove-AppxPackage
Write-Output "Done"