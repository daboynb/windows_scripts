$packages = Get-WindowsPackage -Path "C:\mount\mount" | Where-Object {
    $_.PackageName -like "Microsoft-Windows-InternetExplorer-Optional-Package*" -or
    $_.PackageName -like "Microsoft-Windows-Kernel-LA57-FoD*" -or
    $_.PackageName -like "Microsoft-Windows-LanguageFeatures-Handwriting*" -or
    $_.PackageName -like "Microsoft-Windows-LanguageFeatures-OCR*" -or
    $_.PackageName -like "Microsoft-Windows-LanguageFeatures-Speech*" -or
    $_.PackageName -like "Microsoft-Windows-LanguageFeatures-TextToSpeech*" -or
    $_.PackageName -like "Microsoft-Windows-MediaPlayer-Package*" -or
    $_.PackageName -like "Microsoft-Windows-TabletPCMath-Package*" -or
    $_.PackageName -like "Microsoft-Windows-Wallpaper-Content-Extended-FoD*"
}

foreach ($package in $packages) {
    dism /image:C:\mount\mount /Remove-Package /PackageName:$($package.PackageName) /NoRestart | Out-Null
}