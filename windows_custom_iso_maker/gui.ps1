#################################### start the gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows Custom ISO Maker"
$form.Size = New-Object System.Drawing.Size(480, 460) 
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'

# Set form background color to dark
$form.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)

# Set text color to white
$form.ForeColor = [System.Drawing.Color]::White

# Define the event handler for downloading Windows 10 ISO
$downloadWin10_Click = {
    Start-Process -FilePath "C:\windows_custom_iso_maker\Portable\FirefoxPortable.exe" -ArgumentList "https://www.microsoft.com/en-us/software-download/windows10ISO"
}

# Define the event handler for downloading Windows 11 ISO
$downloadWin11_Click = {
    Start-Process -FilePath "C:\windows_custom_iso_maker\Portable\FirefoxPortable.exe" -ArgumentList "https://www.microsoft.com/en-us/software-download/windows11"
}

# Create label for download file
$labelISOFile = New-Object System.Windows.Forms.Label
$labelISOFile.Location = New-Object System.Drawing.Point(10,20)
$labelISOFile.Size = New-Object System.Drawing.Size(110,20)
$labelISOFile.Text = "Download :"
$form.Controls.Add($labelISOFile)

# Create download buttons for Windows 10 and Windows 11
$downloadButtonWin10 = New-Object System.Windows.Forms.Button
$downloadButtonWin10.Location = New-Object System.Drawing.Point(130, 10)
$downloadButtonWin10.Size = New-Object System.Drawing.Size(140, 23)
$downloadButtonWin10.Text = "Download Windows 10"
$downloadButtonWin10.Add_Click($downloadWin10_Click)
$form.Controls.Add($downloadButtonWin10)

$downloadButtonWin11 = New-Object System.Windows.Forms.Button
$downloadButtonWin11.Location = New-Object System.Drawing.Point(280, 10)
$downloadButtonWin11.Size = New-Object System.Drawing.Size(140, 23)
$downloadButtonWin11.Text = "Download Windows 11"
$downloadButtonWin11.Add_Click($downloadWin11_Click)
$form.Controls.Add($downloadButtonWin11)

# Create label for ISO file
$labelISOFile = New-Object System.Windows.Forms.Label
$labelISOFile.Location = New-Object System.Drawing.Point(10,55)
$labelISOFile.Size = New-Object System.Drawing.Size(120,20)
$labelISOFile.Text = "Select an ISO file:"
$form.Controls.Add($labelISOFile)

# Create textbox for ISO file
$textBoxISOFile = New-Object System.Windows.Forms.TextBox
$textBoxISOFile.Location = New-Object System.Drawing.Point(10,55)
$textBoxISOFile.Size = New-Object System.Drawing.Size(350,20) 
$form.Controls.Add($textBoxISOFile)

# Create browse button
$browseButton = New-Object System.Windows.Forms.Button
$browseButton.Location = New-Object System.Drawing.Point(370,55) 
$browseButton.Size = New-Object System.Drawing.Size(80,20)
$browseButton.Text = "Browse"
$browseButton.Add_Click({
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "ISO Files (*.iso)|*.iso|All files (*.*)|*.*"
    $openFileDialog.Title = "Select an ISO File"
    $openFileDialog.Multiselect = $false
    $result = $openFileDialog.ShowDialog()
    if ($result -eq 'OK') {
        $selectedFile = $openFileDialog.FileName
        $textBoxISOFile.Text = $selectedFile    
    }
})
$form.Controls.Add($browseButton)

# Create group box for System Info
$groupBoxSystemInfo = New-Object System.Windows.Forms.GroupBox
$groupBoxSystemInfo.Location = New-Object System.Drawing.Point(240, 100)
$groupBoxSystemInfo.Size = New-Object System.Drawing.Size(210, 90) 
$groupBoxSystemInfo.Text = "System Info"
$form.Controls.Add($groupBoxSystemInfo)

# Get Windows version and architecture
$winVersion = (Get-WmiObject -Class Win32_OperatingSystem).Caption
$arch = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture

# Create label text with the gathered information
$labelText = "Windows Version: $winVersion`n`nArchitecture: $arch`n`n"

# Create label to display system info
$labelSystemInfo = New-Object System.Windows.Forms.Label
$labelSystemInfo.Location = New-Object System.Drawing.Point(10, 20)
$labelSystemInfo.Size = New-Object System.Drawing.Size(180, 60)
$labelSystemInfo.Text = $labelText

# Add label to group box
$groupBoxSystemInfo.Controls.Add($labelSystemInfo)

# Create group box for Details
$groupBoxAdditionalInfo = New-Object System.Windows.Forms.GroupBox
$groupBoxAdditionalInfo.Location = New-Object System.Drawing.Point(10, 250) 
$groupBoxAdditionalInfo.Size = New-Object System.Drawing.Size(440, 165)   
$groupBoxAdditionalInfo.Text = "Details"
$form.Controls.Add($groupBoxAdditionalInfo)

# Text to display in the Details group box with white characters and black background
$additionalInfoText = @"

1. Hardware requirements are bypassed.

2. Offline account creation.

3. All preinstalled apps are removed.

4. Edge can be removed natively, just press 'Win+r' and type aio.

5. Defender can be toggled on and off, just press 'Win+r' and type aio.

All the applied tweaks -> https://pastebin.com/raw/k0bdihNw
"@

# Create RichTextBox for Details with vertical scrolling
$richTextBoxDetails = New-Object System.Windows.Forms.RichTextBox
$richTextBoxDetails.Location = New-Object System.Drawing.Point(10, 20)
$richTextBoxDetails.Size = New-Object System.Drawing.Size(420, 135)
$richTextBoxDetails.ScrollBars = "Vertical"  
$richTextBoxDetails.Text = $additionalInfoText
$richTextBoxDetails.ForeColor = "White"  
$richTextBoxDetails.BackColor = "Black"  
$richTextBoxDetails.ReadOnly = $true  
$richTextBoxDetails.Font = New-Object System.Drawing.Font("Arial", 10)
$groupBoxAdditionalInfo.Controls.Add($richTextBoxDetails)

# Create donate button
$donateButton = New-Object System.Windows.Forms.Button
$donateButton.Location = New-Object System.Drawing.Point(240, 210) 
$donateButton.Size = New-Object System.Drawing.Size(100,23) 
$donateButton.Text = "Donate"
$donateButton.Add_Click({
    Start-Process "https://www.buymeacoffee.com/daboynb"
})
$form.Controls.Add($donateButton)

# Create group box for Windows Edition
$groupBoxWindowsEdition = New-Object System.Windows.Forms.GroupBox
$groupBoxWindowsEdition.Location = New-Object System.Drawing.Point(10, 100)
$groupBoxWindowsEdition.Size = New-Object System.Drawing.Size(220,90)
$groupBoxWindowsEdition.Text = "Select Windows Edition"
$form.Controls.Add($groupBoxWindowsEdition)

# Create radio buttons for Windows Edition
$radioButtonHome = New-Object System.Windows.Forms.RadioButton
$radioButtonHome.Location = New-Object System.Drawing.Point(10,20)
$radioButtonHome.Size = New-Object System.Drawing.Size(120,20)
$radioButtonHome.Text = "Home"
$groupBoxWindowsEdition.Controls.Add($radioButtonHome)

$radioButtonPro = New-Object System.Windows.Forms.RadioButton
$radioButtonPro.Location = New-Object System.Drawing.Point(10,45)
$radioButtonPro.Size = New-Object System.Drawing.Size(120,20)
$radioButtonPro.Text = "Pro"
$groupBoxWindowsEdition.Controls.Add($radioButtonPro)

# Create build button
$buildButton = New-Object System.Windows.Forms.Button
$buildButton.Location = New-Object System.Drawing.Point(360,210) 
$buildButton.Size = New-Object System.Drawing.Size(100,23) 
$buildButton.Text = "Build!"
$buildButton.Add_Click({
    if ($textBoxISOFile.Text -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Please select an ISO file.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    if (-not ($radioButtonHome.Checked -or $radioButtonPro.Checked)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a Windows edition.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    $selectedFile = $textBoxISOFile.Text
    
    Write-Host "Wait while the programs detects your windows version"

    # Mount ISO image
    Mount-DiskImage -ImagePath $selectedFile | Out-Null

    # Detect letter 
    $mountedDrive = (Get-DiskImage -ImagePath $selectedFile | Get-Volume).DriveLetter + ":"

    # Detect if wim or esd
    $is_wim = Join-Path -Path $mountedDrive -ChildPath "\sources\install.wim"
    if (-not (Test-Path -Path $is_wim)) {
        $is_esd = Join-Path -Path $mountedDrive -ChildPath "\sources\install.esd"
        $dism_pro_or_home = dism /Get-WimInfo /WimFile:$is_esd
    } else {
        $dism_pro_or_home = dism /Get-WimInfo /WimFile:$is_wim
    }   

    # Extract the index of the selected windows version
    if ($radioButtonHome.Checked) {
        Write-Host "The RadioButton Home is checked, the Windows edition selected is: Home"
        if ($dism_pro_or_home -like "*Windows ** Home*") {
            $outLines = $dism_pro_or_home -split "`n"
            
            for ($i = 1; $i -lt $outLines.Length; $i++) {
                if ($outLines[$i] -like "*Windows ** Home*") {
                    $indexLine = $outLines[$i - 1]
                    $index = ($indexLine -split ":")[1].Trim()
                    break
                }
            }
        } else {
            Write-Host "This Windows image does not contain Home."
            Start-Sleep 15
            exit
        }
    } else {
        Write-Host "The RadioButton Pro is checked, the Windows edition selected is: Pro"
        if ($dism_pro_or_home -like "*Windows ** Pro*") {
            $outLines = $dism_pro_or_home -split "`n"
            
            for ($i = 1; $i -lt $outLines.Length; $i++) {
                if ($outLines[$i] -like "*Windows ** Pro*") {
                    $indexLine = $outLines[$i - 1]
                    $index = ($indexLine -split ":")[1].Trim()
                    break
                }
            }
        } else {
            Write-Host "This Windows image does not contain Pro."
            Start-Sleep 15
            exit
        }
    }    

    # Arguments to pass to the bat file
    $arguments = @(
        """$selectedFile""",
        """$index"""
    )

    $argumentString = $arguments -join ' '
    
    # Detect if Windows 10 or 11
    if (Test-Path "$mountedDrive\sources\install.wim") {
        $dism_10_or_11 = dism /Get-WimInfo /WimFile:"$mountedDrive\sources\install.wim"
    } else {
        $dism_10_or_11 = dism /Get-WimInfo /WimFile:"$mountedDrive\sources\install.esd"
    }

    Dismount-DiskImage -ImagePath $selectedFile
    
    if ($dism_10_or_11 -like "*Windows 11*") {
        Write-Host "This is a Windows 11 image."
        $windowsVersion = "Windows 11"
        Write-Host $windowsVersion
        Start-Process -FilePath "powershell.exe" -ArgumentList "-WindowStyle Hidden", "-File", "C:\windows_custom_iso_maker\xml.ps1" -Wait
    } elseif ($dism_10_or_11 -like "*Windows 10*") {
        Write-Host "This is a Windows 10 image."
        $windowsVersion = "Windows 10"
        Write-Host $windowsVersion
    } else {
        Write-Host "The image does not seem to contain Windows 10 or Windows 11 information."
    }    
    
    # Launch bat with args
    if ($windowsVersion -eq "Windows 10") {
        Start-Process -FilePath "C:\windows_custom_iso_maker\win10_custom_iso\create.bat" -ArgumentList "$argumentString"  
    }
    if ($windowsVersion -eq "Windows 11") {
        Start-Process -FilePath "C:\windows_custom_iso_maker\win11_custom_iso\create.bat" -ArgumentList "$argumentString" 
    }

    $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.Close()
})
$form.Controls.Add($buildButton)

# Add event handler for OK button click
$form.Add_Shown({$form.Activate()})
$form.ShowDialog() | Out-Null
####################################