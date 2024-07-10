If you wanna help me

<a href="https://www.buymeacoffee.com/daboynb" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

# windows_custom_iso_maker 

NOTICE, the new edge removing method works starting in Windows 10 Build 19045.3757 and Windows 11 Build 22621.2787. On earlier version you won't be able to uninstall edge .

This script creates a custom ISO's of Windows 10 and 11 with the following features:

    1. Hardware requirements are bypassed.

    2. Offline account creation.
       
    3. All preinstalled apps are removed.
       
    4. Edge can be removed natively, just press 'Win+r' and type aio.
       
    5. Defender can be toggled on and off, just press 'Win+r' and type aio.
       
    All the applied tweaks -> https://pastebin.com/raw/k0bdihNw

How to use?

       irm -Uri "https://raw.githubusercontent.com/daboynb/windows_scripts/main/windows_custom_iso_maker/downloader.ps1" | iex
       
![Capture](https://github.com/daboynb/windows_scripts/assets/106079917/6ecd99db-ffbc-4fa3-8792-5f413dc7807b)

# Win11_patcher
Patch the win 11 image to bypass requirements and oobe leaving the system image untouched.

How to use?

       irm -Uri "https://raw.githubusercontent.com/daboynb/windows_scripts/main/win11_patcher/downloader.ps1" | iex

# Repo_downloader.bat
Download all the stuff from this repo, with a single click!

# remove_windows_apps.bat
Remove all apps except calculator, photo and store.

It works on 10 and 11.

Why this is different from the others?

Different windows builds have different pre-installed apps, this script will debloat the system automatically even if them will change. 

# add_store_windows_10_11.bat
Install Microsoft Store on Windows 10 and 11.

# remove_store_windows_10_11.bat
Remove Microsoft Store on Windows 10 and 11.

# clean_win_update.bat
Delete windows update cache.
In case the old downloaded Windows updates were corrupted on your system, this action would get a fresh download of the update and try installing again.

# remove_onedrive.bat
Remove onedrive from system.

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

# section_manager.bat
This script uses the ExplorerPatcher DLL to remove the recommended section in Windows 11 without installing the entire software.

# defender.bat
This script allows you to enable or disable Windows Defender using PowerRun, a tool created by Sordum.

# adb_fastboot.bat
This script installs adb and fastboot on your pc.

# sfc_dism.bat

Run dism and sfc to try to fix some problems.

# add_user.bat

Add offline users since ms removed this option.

# download_iso.bat

Use the linux user agent to download iso from MS.

# winpe.bat 
Create a winpe iso that bypass the user account password.

How to build the ISO?

      - install the Windows ADK
      - install the Windows PE add-on for the Windows ADK
      - double click on winpe.bat and wait
      - the iso will be created in C:\

How to use the ISO?

      - Boot the ISO from USB
      - Follow the guided procedure
      - The PC will restart upon completion
      - At login, press the "SHIFT" key 5 times
      - A CMD window will open
      - Type "sticky_run.bat"
      - Follow the guided procedure to change the password or create a new user

Pre-built ISO :
      https://t.me/WindowsItalyISO/151
      
# remove_edge.bat
Run the bat file, you should be able to remove edge, if not, install the latest updates and retry.

# aio_debloater.bat
Very light debloater to remove windows crap.