Get-ChildItem -LiteralPath "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service" -Recurse | Remove-Item -Force -Recurse 
Write-Output "Done"