if ((Get-WmiObject win32_operatingsystem | Select-Object osarchitecture).osarchitecture -eq "64 bit")
{
    #64 bit logic here
    Write-Output "Removing OneDrive"
    %systemroot%\SysWOW64\OneDriveSetup.exe /uninstall
}
else
{
    #32 bit logic here
    Write-Output "Removing OneDrive"
    %systemroot%\System32\OneDriveSetup.exe /uninstall
}
