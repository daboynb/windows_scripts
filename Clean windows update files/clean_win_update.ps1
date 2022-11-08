Write-Host "Stopping Windows Update Service..." 
net stop wuauserv | out-null 
Get-ChildItem -LiteralPath C:\Windows\SoftwareDistribution\Download -Recurse | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
Write-Host "Starting Windows Update Service..." 
net start wuauserv | out-null 
Write-Output "Done"