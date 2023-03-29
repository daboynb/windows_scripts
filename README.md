# !! WARNING !!

Ps1 files were converted with ps2exe.

Bat files were converted with Bat To Exe Converter (B2E).

Some antivirus will flag those files as malicious.

# remove_windows_apps.exe
Remove all apps except calculator, photo and store.

It works on 10 and 11.

Why this is different from the others?

Different windows builds have different pre-installed apps, this script will debloat the system automatically even if them will change. 

# add_store_windows_10_ltsc_2021.exe
Install Microsoft Store on Windows 10 LTSC 2021.

# remove_store_windows_10_ltsc_2021.exe
Remove Microsoft Store on Windows 10 LTSC 2021.

# win11.bat
Bypass windows 11 requirements.

Boot the windows usb, run the bat file with the cmd pressing Shift + F10.

<details>
  <summary>Video guide</summary>
  
https://user-images.githubusercontent.com/106079917/194064964-8bd1e919-be01-448e-a831-28e8662a532e.mp4

</details>

# sticky_keys.bat
Classic sticky_keys to reset the windows password. 

Boot the windows usb, run the bat file with the cmd pressing Shift + F10.

# clean_win_update.exe
Delete windows update cache.
In case the old downloaded Windows updates were corrupted on your system, this action would get a fresh download of the update and try installing again.

# remove_onedrive.exe
Remove onedrive from system.

# remove_edge.exe
Remove edge from system.

# delete_defender_history.exe
Delete the windows defender protection history.

# hyper-V.exe
Add hyper-V on windows 10 Home.

# kaspersky_trial_reset.exe
Kaspersky trial reset tool. This has been made only for educational and research purposes.

You need to disable the self protection and exit from kaspersky, otherwise it won't work.

It works with :

"kaspersky anti virus 21.3" -> 31 days

"kaspersky internet security 21.3" -> 31 days

"kaspersky total security 21.3" -> 62 days

# powershell_win_update.ps1
Update the system using windows update from powershell. 

NOTE: the script will reboot automatically your machine if needed!

# unattend_auto.bat
Script that integrates a custom unattend.xml file into an ISO. 

Follow these steps:
1) Install all programs inside the "req" folder
2) Create a custom unattend.xml file and save it in the same folder where the "unattend_auto.bat" file is located
3) Run the bat file