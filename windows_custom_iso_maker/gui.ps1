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

# Create download buttons for Windows 10 and Windows 11
$downloadButtonWin10 = New-Object System.Windows.Forms.Button
$downloadButtonWin10.Location = New-Object System.Drawing.Point(120, 10)
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
$labelISOFile.Location = New-Object System.Drawing.Point(10,20)
$labelISOFile.Size = New-Object System.Drawing.Size(260,20)
$labelISOFile.Text = "Select an ISO file:"
$form.Controls.Add($labelISOFile)

# Create textbox for ISO file
$textBoxISOFile = New-Object System.Windows.Forms.TextBox
$textBoxISOFile.Location = New-Object System.Drawing.Point(10,40)
$textBoxISOFile.Size = New-Object System.Drawing.Size(350,20) 
$form.Controls.Add($textBoxISOFile)

# Create browse button
$browseButton = New-Object System.Windows.Forms.Button
$browseButton.Location = New-Object System.Drawing.Point(370,38) 
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
$groupBoxSystemInfo.Location = New-Object System.Drawing.Point(240, 70)
$groupBoxSystemInfo.Size = New-Object System.Drawing.Size(210, 90) 
$groupBoxSystemInfo.Text = "System Info"
$form.Controls.Add($groupBoxSystemInfo)

# Get Windows version, architecture
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

2. All preinstalled apps are removed.

3. Edge can be removed from the Control Panel !
(It requires an additional reboot after the initial setup.)

4. Defender can be toggled on and off !
(Simply type 'defender' in a cmd window, and a menu will appear.)

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

# Create group box for Windows version
$groupBoxWindowsVersion = New-Object System.Windows.Forms.GroupBox
$groupBoxWindowsVersion.Location = New-Object System.Drawing.Point(10, 70)
$groupBoxWindowsVersion.Size = New-Object System.Drawing.Size(220,90)
$groupBoxWindowsVersion.Text = "Select Windows version"
$form.Controls.Add($groupBoxWindowsVersion)

# Create radio buttons for Windows version
$radioButtonWindows10 = New-Object System.Windows.Forms.RadioButton
$radioButtonWindows10.Location = New-Object System.Drawing.Point(10,20)
$radioButtonWindows10.Size = New-Object System.Drawing.Size(120,20)
$radioButtonWindows10.Text = "Windows 10"
$groupBoxWindowsVersion.Controls.Add($radioButtonWindows10)

$radioButtonWindows11 = New-Object System.Windows.Forms.RadioButton
$radioButtonWindows11.Location = New-Object System.Drawing.Point(10,45)
$radioButtonWindows11.Size = New-Object System.Drawing.Size(120,20)
$radioButtonWindows11.Text = "Windows 11"
$groupBoxWindowsVersion.Controls.Add($radioButtonWindows11)

# Create group box for Windows Edition
$groupBoxWindowsEdition = New-Object System.Windows.Forms.GroupBox
$groupBoxWindowsEdition.Location = New-Object System.Drawing.Point(10, 170)
$groupBoxWindowsEdition.Size = New-Object System.Drawing.Size(220,70)
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

# Create OK button
$buildButton = New-Object System.Windows.Forms.Button
$buildButton.Location = New-Object System.Drawing.Point(360,210) 
$buildButton.Size = New-Object System.Drawing.Size(100,23) 
$buildButton.Text = "Build!"
$buildButton.Add_Click({
    if ($textBoxISOFile.Text -eq "") {
        [System.Windows.Forms.MessageBox]::Show("Please select an ISO file.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    if (-not ($radioButtonWindows10.Checked -or $radioButtonWindows11.Checked)) {
        [System.Windows.Forms.MessageBox]
        ::Show("Please select a Windows version.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    if (-not ($radioButtonHome.Checked -or $radioButtonPro.Checked)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a Windows edition.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        return
    }

    $selectedFile = $textBoxISOFile.Text
    $windowsVersion = if ($radioButtonWindows10.Checked) { "Windows 10" } else { "Windows 11" }
    $windowsEdition = if ($radioButtonHome.Checked) { "Home" } else { "Pro" }

        $arguments = @(
        """$selectedFile""",
        """$windowsVersion""",
        """$windowsEdition"""
    )

    $argumentString = $arguments -join ' '

    if ($windowsVersion -eq "Windows 10") {
        Start-Process -FilePath "C:\windows_custom_iso_maker\win10_custom_iso\create.bat" -ArgumentList "$argumentString"  
    }
    else {
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