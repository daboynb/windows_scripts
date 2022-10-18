Write-Output "Installing the store... Please wait."
WSReset -i 
TimeOut 20 | out-null
WSReset -i
Write-Output "Store is downloading... it will be installed soon"