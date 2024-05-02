@echo off
rem RunAsTI - lean and mean snippet by AveYo, 2018-2022

whoami /user | findstr /i /c:S-1-5-18 >nul || ( call :RunAsTI "%~f0" & exit /b )

powerShell -Command "Write-Host 'My github -> https://github.com/daboynb' -ForegroundColor Green; exit" && timeout 04>nul

:::::::::::::::::::::::::
:: .bat script content ::
:::::::::::::::::::::::::
IF exist files_detect.ps1 (
    echo ok
) ELSE (
    echo files_detect.ps1 not present! && pause && exit /b 1
)

ping 8.8.8.8 -n 1 -w 1000 > nul
IF "%ERRORLEVEL%"=="1" color 0C && echo "Internet is not avibale, EXITING!" && pause && exit

:MAINMENU
CLS
SET MENU=
ECHO WINDOWS 11 RECOMMENDED SECTION MANAGER
echo.
ECHO [1] HIDE RECOMMENDED SECTION 
ECHO [2] SHOW RECOMMENDED SECTION
ECHO [0] EXIT
echo.
SET /P MENU=Type 1, 2 or 0 then press ENTER :
IF /I '%MENU%'=='1' GOTO :INSTALL
IF /I '%MENU%'=='2' GOTO :UNINSTALL
IF /I '%MENU%'=='0' GOTO :EXIT
GOTO :MAINMENU

rem ####################################################################################### INSTALL SECTION

:INSTALL
powershell -Command "$url = (Invoke-RestMethod -Uri 'https://api.github.com/repos/valinet/ExplorerPatcher/releases/latest').assets[0].browser_download_url; Invoke-WebRequest -Uri $url -OutFile \"$env:APPDATA\\\ep_setup.exe\""

"%appdata%\ep_setup.exe" /extract "%appdata%\ep_setup"
copy "%appdata%\ep_setup\ExplorerPatcher.amd64.dll" "%appdata%\dxgi.dll"
rmdir "%appdata%\ep_setup" /s /q
del "%appdata%\ep_setup.exe"
IF exist "%appdata%\dxgi.dll" (
    echo ok
) ELSE (
    echo dxgi.dll not present! && pause && exit /b 1
)

rem copy dll's
copy "%appdata%\dxgi.dll" "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\dxgi.dll"
copy "%appdata%\dxgi.dll" "%SystemRoot%\dxgi.dll"

rem add keys
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher" /v "StartDocked_DisableRecommendedSection" /t REG_DWORD /d 1 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher\StartDocked" /v "StartDocked::LauncherFrame::OnVisibilityChanged" /t REG_DWORD /d 1869808 /f

rem restart processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe & start explorer.exe

rem wait until the start menu is ready
timeout 03 >nul
powerShell -Command "Write-Host 'Wait until all files are downloaded!' -ForegroundColor Green; exit"
powershell.exe -ExecutionPolicy Bypass -File "files_detect.ps1"
timeout 03 >nul

rem disable one dll
move "%SystemRoot%\dxgi.dll" "%SystemRoot%\adxgi.dll"

rem restart processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe & start explorer.exe

rem delete one dll
del C:\Windows\adxgi.dll
timeout 03 >nul
shutdown /r /t 00

rem ####################################################################################### UNINSTALL SECTION

:UNINSTALL
rem kill processes
taskkill /f /im StartMenuExperienceHost.exe & taskkill /f /im explorer.exe

rem delete reg keys
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher" /v "StartDocked_DisableRecommendedSection" /f
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ExplorerPatcher\StartDocked" /v "StartDocked::LauncherFrame::OnVisibilityChanged" /f

rem delete dxgi.dll
del "%SystemRoot%\SystemApps\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\dxgi.dll" /Q

rem restart explorer
start explorer.exe
timeout 03 >nul
shutdown /r /t 00

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: .bat script content end - copy-paste RunAsTI snippet ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

#:RunAsTI snippet to run as TI/System, with innovative HKCU load, ownership privileges, high priority, and explorer support  
set ^ #=& set "0=%~f0"& set 1=%*& powershell -c iex(([io.file]::ReadAllText($env:0)-split'#\:RunAsTI .*')[1])& exit /b
function RunAsTI ($cmd,$arg) { $id='RunAsTI'; $key="Registry::HKU\$(((whoami /user)-split' ')[-1])\Volatile Environment"; $code=@'
 $I=[int32]; $M=$I.module.gettype("System.Runtime.Interop`Services.Mar`shal"); $P=$I.module.gettype("System.Int`Ptr"); $S=[string]
 $D=@(); $T=@(); $DM=[AppDomain]::CurrentDomain."DefineDynami`cAssembly"(1,1)."DefineDynami`cModule"(1); $Z=[uintptr]::size 
 0..5|% {$D += $DM."Defin`eType"("AveYo_$_",1179913,[ValueType])}; $D += [uintptr]; 4..6|% {$D += $D[$_]."MakeByR`efType"()}
 $F='kernel','advapi','advapi', ($S,$S,$I,$I,$I,$I,$I,$S,$D[7],$D[8]), ([uintptr],$S,$I,$I,$D[9]),([uintptr],$S,$I,$I,[byte[]],$I)
 0..2|% {$9=$D[0]."DefinePInvok`eMethod"(('CreateProcess','RegOpenKeyEx','RegSetValueEx')[$_],$F[$_]+'32',8214,1,$S,$F[$_+3],1,4)}
 $DF=($P,$I,$P),($I,$I,$I,$I,$P,$D[1]),($I,$S,$S,$S,$I,$I,$I,$I,$I,$I,$I,$I,[int16],[int16],$P,$P,$P,$P),($D[3],$P),($P,$P,$I,$I)
 1..5|% {$k=$_; $n=1; $DF[$_-1]|% {$9=$D[$k]."Defin`eField"('f' + $n++, $_, 6)}}; 0..5|% {$T += $D[$_]."Creat`eType"()}
 0..5|% {nv "A$_" ([Activator]::CreateInstance($T[$_])) -fo}; function F ($1,$2) {$T[0]."G`etMethod"($1).invoke(0,$2)}   
 $TI=(whoami /groups)-like'*1-16-16384*'; $As=0; if(!$cmd) {$cmd='control';$arg='admintools'}; if ($cmd-eq'This PC'){$cmd='file:'}
 if (!$TI) {'TrustedInstaller','lsass','winlogon'|% {if (!$As) {$9=sc.exe start $_; $As=@(get-process -name $_ -ea 0|% {$_})[0]}}
 function M ($1,$2,$3) {$M."G`etMethod"($1,[type[]]$2).invoke(0,$3)}; $H=@(); $Z,(4*$Z+16)|% {$H += M "AllocHG`lobal" $I $_}
 M "WriteInt`Ptr" ($P,$P) ($H[0],$As.Handle); $A1.f1=131072; $A1.f2=$Z; $A1.f3=$H[0]; $A2.f1=1; $A2.f2=1; $A2.f3=1; $A2.f4=1
 $A2.f6=$A1; $A3.f1=10*$Z+32; $A4.f1=$A3; $A4.f2=$H[1]; M "StructureTo`Ptr" ($D[2],$P,[boolean]) (($A2 -as $D[2]),$A4.f2,$false)
 $Run=@($null, "powershell -win 1 -nop -c iex `$env:R; # $id", 0, 0, 0, 0x0E080600, 0, $null, ($A4 -as $T[4]), ($A5 -as $T[5]))
 F 'CreateProcess' $Run; return}; $env:R=''; rp $key $id -force; $priv=[diagnostics.process]."GetM`ember"('SetPrivilege',42)[0]   
 'SeSecurityPrivilege','SeTakeOwnershipPrivilege','SeBackupPrivilege','SeRestorePrivilege' |% {$priv.Invoke($null, @("$_",2))}
 $HKU=[uintptr][uint32]2147483651; $NT='S-1-5-18'; $reg=($HKU,$NT,8,2,($HKU -as $D[9])); F 'RegOpenKeyEx' $reg; $LNK=$reg[4]
 function L ($1,$2,$3) {sp 'HKLM:\Software\Classes\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}' 'RunAs' $3 -force -ea 0
  $b=[Text.Encoding]::Unicode.GetBytes("\Registry\User\$1"); F 'RegSetValueEx' @($2,'SymbolicLinkValue',0,6,[byte[]]$b,$b.Length)}
 function Q {[int](gwmi win32_process -filter 'name="explorer.exe"'|?{$_.getownersid().sid-eq$NT}|select -last 1).ProcessId}
 $11bug=($((gwmi Win32_OperatingSystem).BuildNumber)-eq'22000')-AND(($cmd-eq'file:')-OR(test-path -lit $cmd -PathType Container))
 if ($11bug) {'System.Windows.Forms','Microsoft.VisualBasic' |% {[Reflection.Assembly]::LoadWithPartialName("'$_")}}
 if ($11bug) {$path=$path='^(l)'+$($cmd -replace '([\+\^\%\~\(\)\[\]])','{$1}')+'{ENTER}'; $cmd='control.exe'; $arg='admintools'}
 L ($key-split'\\')[1] $LNK ''; $R=[diagnostics.process]::start($cmd,$arg); if ($R) {$R.PriorityClass='High'; $R.WaitForExit()}
 if ($11bug) {$w=0; do {if($w-gt40){break}; sleep -mi 250;$w++} until (Q); [Microsoft.VisualBasic.Interaction]::AppActivate($(Q))}
 if ($11bug) {[Windows.Forms.SendKeys]::SendWait($path)}; do {sleep 7} while(Q); L '.Default' $LNK 'Interactive User'
'@; $V='';'cmd','arg','id','key'|%{$V+="`n`$$_='$($(gv $_ -val)-replace"'","''")';"}; sp $key $id $($V,$code) -type 7 -force -ea 0
 start powershell -args "-win 1 -nop -c `n$V `$env:R=(gi `$key -ea 0).getvalue(`$id)-join''; iex `$env:R" -verb runas
}; $A=$env:1-split'"([^"]+)"|([^ ]+)',2|%{$_.Trim(' "')}; RunAsTI $A[1] $A[2]; #:RunAsTI lean & mean snippet by AveYo, 2022.01.28