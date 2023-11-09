# Run the PowerShell command and save the output to a variable
$myvar = (curl.exe -s ipinfo.io | Select-String -Pattern '\"country\": \"(.*?)\"').Matches.Groups[1].Value

# Output the value of $myvar
$myvar