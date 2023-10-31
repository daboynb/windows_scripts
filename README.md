If you wanna help me

<a href="https://www.buymeacoffee.com/daboynb" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

# remove_windows_apps.bat
Remove all apps except calculator, photo and store.

It works on 10 and 11.

Why this is different from the others?

Different windows builds have different pre-installed apps, this script will debloat the system automatically even if them will change. 

# add_store_windows_10_11.bat
Install Microsoft Store on Windows 10 and 11.

# remove_store_windows_10_11.bat
Remove Microsoft Store on Windows 10 and 11.

# win11_bypass_from_usb.bat
Bypass windows 11 requirements.

Boot the windows usb, run the bat file with the cmd pressing Shift + F10.

<details>
  <summary>Video guide</summary>
  
https://user-images.githubusercontent.com/106079917/194064964-8bd1e919-be01-448e-a831-28e8662a532e.mp4

</details>

# sticky_keys.bat
Classic sticky_keys to reset the windows password. 

Boot the windows usb, run the bat file with the cmd pressing Shift + F10.

# clean_win_update.bat
Delete windows update cache.
In case the old downloaded Windows updates were corrupted on your system, this action would get a fresh download of the update and try installing again.

# remove_onedrive.bat
Remove onedrive from system.

# remove_edge.bat
Remove edge from system.

# delete_defender_history.bat
Delete the windows defender protection history.

# hyper-V.bat
Add hyper-V on windows 10 Home.

# kaspersky_trial_reset.bat
Kaspersky trial reset tool. This has been made only for educational and research purposes.

You need to disable the self protection and exit from kaspersky, otherwise it won't work.

It works with :

"kaspersky anti virus 21.3" -> 31 days

"kaspersky internet security 21.3" -> 31 days

"kaspersky total security 21.3" -> 62 days

<details>
  <summary>Guide</summary>
  
![1](https://user-images.githubusercontent.com/106079917/228910713-3e71d198-d273-4a89-8f31-1787965acc7c.PNG)
![2](https://user-images.githubusercontent.com/106079917/228910715-21d23203-35eb-4552-b6bd-c48821218214.PNG)
![3](https://user-images.githubusercontent.com/106079917/228910718-c39a3816-8e21-43ce-ae66-cce92cdbdda2.PNG)
![4](https://user-images.githubusercontent.com/106079917/228910720-e707df3d-4dc5-476d-9689-b63e1ae3925a.PNG)
![5](https://user-images.githubusercontent.com/106079917/228910722-25391b8d-3dd7-4042-ab0c-de12164778dd.PNG)
![6](https://user-images.githubusercontent.com/106079917/228910725-57ef4f9b-d6e4-4302-b3ac-5860e8279e5f.PNG)
![7](https://user-images.githubusercontent.com/106079917/228910727-6fca4891-8518-40e8-831f-f72b53beaecf.PNG)
![8](https://user-images.githubusercontent.com/106079917/228910728-6c318701-2c1b-441d-abf3-f96e8d621a85.PNG)


</details>

# windows_update_cli.bat
Update the system using windows update from powershell. The script will reboot the system if needed.

# section_manager.bat
This script uses the ExplorerPatcher DLL to remove the recommended section in Windows 11 without installing the entire software.

# defender.bat
This script allows you to enable or disable Windows Defender using PowerRun, a tool created by Sordum.

# adb_fastboot.bat
This script installs adb and fastboot on your pc.

# windows_custom_iso_maker
This script creates a custom ISO's of Windows 10 and 11 with the following features:

- The hardware requirements are bypassed.
- All apps are removed, including the sponsored one on the start menu.
- Telemetry is disabled.
- Edge can be removed.
- Defender can be disabled.
- Some other minor tweaks.

How to use?

       irm -Uri "https://raw.githubusercontent.com/daboynb/windows_scripts/main/windows_custom_iso_maker/Downloader.ps1" | iex

- Download the windows ISO from microsoft
- Run the bat file and select when asked the ISO file
- Wait... the edited ISO will be available on your desktop

If you use rufus to flash DO NOT SELECT ANYTHING LIKE LOCAL ACCOUNT, BYPASS ETC ...
it will overwrites the unattend.xml and the installation will FAIL.