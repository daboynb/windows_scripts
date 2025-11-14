<h3>⚠️ Kaspersky trial reset ⚠️</h3>
After some research, I found that the reset works correctly, it provides the option to activate a trial. However, it always uses the same key (even if it was deleted beforehand), and the key immediately shows as expired.
It seems Kaspersky has changed its activation and sales model from “try for 30 days, then buy” to “buy first, then try for 30 days.
So I removed the trial reset from the repository since it doesn’t work anymore.


# If you wanna help me

<a href="https://www.buymeacoffee.com/daboynb" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

# utilities_gui.ps1
How to use?
```powershell
powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/daboynb/windows_scripts/refs/heads/main/utilities/utilities_gui.ps1' -OutFile $env:TEMP\utilities_gui.ps1; Start-Process powershell -Verb RunAs -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-File','$env:TEMP\utilities_gui.ps1'"
```

<img width="707" height="532" alt="gui" src="https://github.com/user-attachments/assets/b2ca9f1d-3088-4de9-b7a0-1b6e5d521484" />

## Buttons overview
- `Install ADB/Fastboot`: Installs Android platform‑tools.
- `Install Microsoft Store`: Installs the Microsoft Store; may take up to 5 minutes.
- `Remove Edge`: Force‑uninstalls Microsoft Edge.
- `Create admin user`: Creates a local admin user.
- `Reinstall Edge`: Reinstalls Edge.
- `Clean Windows Update`: Clears the Windows Update cache.
- `Clear Defender history`: Deletes Windows Defender scan history files.
- `Remove OneDrive`: Uninstalls OneDrive.
- `Remove Microsoft Store`: Uninstalls the Microsoft Store.
- `Remove Windows apps`: Debloats preinstalled UWP apps, keeping a safe whitelist.
- `Tweaks`: Imports registry tweaks for privacy and a cleaner UI.
- `Enable Hyper‑V`: Enables Hyper‑V on Windows editions that don't support it, like Home versions.
- `Repair SFC/DISM`: Runs `sfc /scannow` and `dism /Online /Cleanup-Image /RestoreHealth`.
- `Disable Defender`: Applies policies to disable real‑time protection and related services, then restarts after 5 seconds.
- `Enable Defender`: Restores Defender policies and services to the enabled state, then restarts after 5 seconds.
- `Windows 11 Patcher`: Builds an ISO with all Windows 11 requirements bypassed.
- `Convert from Base64`: Decodes all embedded Base64 resources to the TEMP folder and opens it so the user can see what the script does.

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

External tools:
Note: The following third‑party tools are bundled in this repository only for convenience. They remain owned and maintained by their respective authors and are distributed under their own licenses.
- PS2EXE — License: Microsoft Public License (Ms‑PL) — Developer: Markus Scholtes (original by Ingo Karstein) — converts PowerShell `.ps1` scripts to `.exe`
- 7‑Zip — License: GNU LGPL (with unRAR restriction for parts) — Developer: Igor Pavlov — extracts archives/ISOs
- PowerRun — License: Freeware (Sordum EULA) — Developer: Sordum — edits protected registry keys with elevated privileges
- oscdimg — License: Microsoft Software License Terms (Windows ADK) — Developer: Microsoft — creates ISO images
