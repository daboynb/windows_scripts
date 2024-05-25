#################################### start the gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows 11 image patcher"
$form.Size = New-Object System.Drawing.Size(600, 200) 
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'

# Set form background color to dark
$form.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)

# Set text color to white
$form.ForeColor = [System.Drawing.Color]::White

# Set font to Arial 12
$font = New-Object System.Drawing.Font("Arial", 12)

# Create label for ISO file
$labelISOFile = New-Object System.Windows.Forms.Label
$labelISOFile.Location = New-Object System.Drawing.Point(10,20)
$labelISOFile.Size = New-Object System.Drawing.Size(240,20)
$labelISOFile.Text = "Select an ISO file:"
$labelISOFile.Font = $font
$form.Controls.Add($labelISOFile)

# Create textbox for ISO file
$textBoxISOFile = New-Object System.Windows.Forms.TextBox
$textBoxISOFile.Location = New-Object System.Drawing.Point(10,40)
$textBoxISOFile.Size = New-Object System.Drawing.Size(350,20) 
$textBoxISOFile.Font = $font
$form.Controls.Add($textBoxISOFile)

# Create browse button
$browseButton = New-Object System.Windows.Forms.Button
$browseButton.Location = New-Object System.Drawing.Point(370,40) 
$browseButton.Size = New-Object System.Drawing.Size(100,23)
$browseButton.Text = "Browse"
$browseButton.Font = $font
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

# Create label for custom word
$labelCustomWord = New-Object System.Windows.Forms.Label
$labelCustomWord.Location = New-Object System.Drawing.Point(10,80)
$labelCustomWord.Size = New-Object System.Drawing.Size(240,30)
$labelCustomWord.Text = "Enter the username for win 11:"
$labelCustomWord.Font = $font
$form.Controls.Add($labelCustomWord)

# Create textbox for custom word
$textBoxCustomWord = New-Object System.Windows.Forms.TextBox
$textBoxCustomWord.Location = New-Object System.Drawing.Point(10,110)
$textBoxCustomWord.Size = New-Object System.Drawing.Size(120,20) 
$textBoxCustomWord.Font = $font
$form.Controls.Add($textBoxCustomWord)

# Create build button
$buildButton = New-Object System.Windows.Forms.Button
$buildButton.Location = New-Object System.Drawing.Point(160,110) 
$buildButton.Size = New-Object System.Drawing.Size(100,23) 
$buildButton.Text = "Build!"
$buildButton.Font = $font
$buildButton.Add_Click({
    $selectedFile = $textBoxISOFile.Text
    $customWord = $textBoxCustomWord.Text

    if (-not [string]::IsNullOrWhiteSpace($selectedFile) -and -not [string]::IsNullOrWhiteSpace($customWord)) {
        $xmlfile = "C:\win11_patcher\win11_custom_iso\resources\unattend.xml"

        # Read the content of the XML file
        $xmlContent = Get-Content -Path $xmlfile

        # Replace the word
        $xmlContent = $xmlContent -replace '24h4', $customWord

        # Save the modified XML file
        $xmlContent | Set-Content -Path $xmlfile

        Start-Process -FilePath "C:\win11_patcher\win11_custom_iso\create.bat" -ArgumentList "$selectedFile" 
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please fill in both the ISO file and the username.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
$form.Controls.Add($buildButton)

# Add event handler for OK button click
$form.Add_Shown({$form.Activate()})
$form.ShowDialog() | Out-Null
####################################
