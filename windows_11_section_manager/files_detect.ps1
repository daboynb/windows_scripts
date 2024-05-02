$folderPath = "C:\Users\$($env:USERNAME)\AppData\Roaming\ExplorerPatcher"
$file1Path = "$folderPath\StartDocked.pdb"
$file2Path = "$folderPath\twinui.pcshell.pdb"
$file3Path = "$folderPath\StartUI.pdb"

$previousSize1 = -1
$previousSize2 = -1
$previousSize3 = -1

do {
    $file1Exists = Test-Path $file1Path
    $file2Exists = Test-Path $file2Path
    $file3Exists = Test-Path $file3Path

    if (-not ($file1Exists -and $file2Exists -and $file3Exists)) {
        Start-Sleep -Seconds 3
        continue
    }

    $currentSize1 = (Get-Item $file1Path -ErrorAction SilentlyContinue).Length
    $currentSize2 = (Get-Item $file2Path -ErrorAction SilentlyContinue).Length
    $currentSize3 = (Get-Item $file3Path -ErrorAction SilentlyContinue).Length

    if ($currentSize1 -eq $previousSize1 -and $currentSize2 -eq $previousSize2 -and $currentSize3 -eq $previousSize3) {
        Write-Host "All files are downloaded!" -ForegroundColor Green
        Start-Sleep 05
        exit
    }

    Start-Sleep -Seconds 3

    $previousSize1 = $currentSize1
    $previousSize2 = $currentSize2
    $previousSize3 = $currentSize3
} while ($true)