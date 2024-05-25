#################################### start the gui
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Windows 11 image patcher"
$form.Size = New-Object System.Drawing.Size(670, 100)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'

# Set form background color to dark
$form.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)

# Set text color to white
$form.ForeColor = [System.Drawing.Color]::White

# Set font size
$font = New-Object System.Drawing.Font("Arial", 12)

# Create label for custom word
$labelCustomWord = New-Object System.Windows.Forms.Label
$labelCustomWord.Location = New-Object System.Drawing.Point(10,20)
$labelCustomWord.Size = New-Object System.Drawing.Size(300,30)
$labelCustomWord.Text = "Enter the username for windows 11   >>"
$labelCustomWord.Font = $font
$form.Controls.Add($labelCustomWord)

# Create textbox for custom word
$textBoxCustomWord = New-Object System.Windows.Forms.TextBox
$textBoxCustomWord.Location = New-Object System.Drawing.Point(320,20)
$textBoxCustomWord.Size = New-Object System.Drawing.Size(200,30)
$textBoxCustomWord.Font = $font
$form.Controls.Add($textBoxCustomWord)

# Create build button
$buildButton = New-Object System.Windows.Forms.Button
$buildButton.Location = New-Object System.Drawing.Point(540,20)
$buildButton.Size = New-Object System.Drawing.Size(100,30)
$buildButton.Text = "OK!"
$buildButton.Font = $font
$buildButton.Add_Click({
    $customWord = $textBoxCustomWord.Text

    if (-not [string]::IsNullOrWhiteSpace($customWord)) {
        $xmlfile = "C:\windows_custom_iso_maker\win11_custom_iso\resources\unattend.xml"

        # Read the content of the XML file
        $xmlContent = Get-Content -Path $xmlfile

        # Replace the word
        $xmlContent = $xmlContent -replace '24h4', $customWord

        # Save the modified XML file
        $xmlContent | Set-Content -Path $xmlfile
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Please fill in the username.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    }
})
$form.Controls.Add($buildButton)

# Add event handler for OK button click
$form.Add_Shown({$form.Activate()})
$form.ShowDialog() | Out-Null
####################################
