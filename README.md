# Windots - Windows Bootstrap Repo

## Info

For ease-of-use, set the `WINDOTS_DIR` env var to this abspath of this directory.

## Bootstrap scripts

[packages/](packages/) contains several bootstrap scripts that install tools using `winget`. Run them by double clicking on them or `./script_name.bat`.

## Komorebi

I use [komorebi](https://github.com/LGUG2Z/komorebi) as my tiling window manager. Komorebi suggests using the [whkd](https://github.com/LGUG2Z/whkd), but because my [workflow requires that I rebind windows hotkeys](https://github.com/LGUG2Z/whkd/issues/6), I use the more powerful [AutoHotkey scripting language](https://www.autohotkey.com) to manage hotkey registrations in [komorebi.ahk](config\komorebi\komorebi.ahk)

### Run on Boot

- **Requirements**:
    1. If you did not run the [essentials.bat](packages/essentials.bat) script, manually check:
        - `komorebic.exe` and `komorebi.exe` must be avaiable at `C:\Program Files\komorebi\bin\` (default `winget` install location)
        - `AutoHotkey.exe` (v2, 64-bit) must be installed and available on `$PATH`
    2. **Manual Step**: Ensure the `KOMOREBI_CONFIG_HOME` var is set to `%WINDOTS_DIR%\config\komorebi`
- Once the requirements are met, to run komorebi on system boot simply copy `komorebic_ahk_startup.exe.lnk` to your windows startup dir (run `Win-r` + `shell:startup`).
    - On my workstation, this looks like `C:\Users\dgonz\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
- **Troubleshooting**:
    - See [this github issue comment](https://github.com/LGUG2Z/komorebi/issues/383#issuecomment-1670429774)
    - Check for updated with the komorebi code:
        - [KOMOREBI_CONFIG_HOME env](https://github.com/LGUG2Z/komorebi/blob/8afad7246fde6e00c1b1136a295e5078cfb93be1/komorebic/src/main.rs#L56C24-L56C44)
        - [`--ahk` flag](https://github.com/LGUG2Z/komorebi/blob/8afad7246fde6e00c1b1136a295e5078cfb93be1/komorebic/src/main.rs#L1708)

## YASB

[YASB](https://github.com/da-rth/yasb) is a nice multiplatform status bar written in python. YASB has native integration with komorebi, but it is under heavy development and I found it to be unstable so **I removed it form the startup script.**

To run YASB, first make sure to [go through the installation and building instructions on the repo](https://github.com/da-rth/yasb), then run the [`start_yasb.bat`](start_yasb.bat).

To get the proper icons, ensure that a Nerdfont is installed and specify it in [styles.css](config/.yasb/styles.css) (ctrl-f "font-family"). Default: [`MesloLGL Nerd Font`](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Meslo.zip)
