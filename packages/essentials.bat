@echo off

REM --- Desktop ---

winget install -e --id AutoHotkey.AutoHotkey
REM see scripts/komorebi.ahk
winget install -e --id LGUG2Z.komorebi
REM allows us to do things without displaying a terminal
REM ASK: is this still needed now that I use komorebi --ahk flag?
winget install -e --id NirSoft.NirCmd

REM TODO: add flow launcher config
winget install -e --id Flow-Launcher.Flow-Launcher
winget install -e --id voidtools.Everything

winget install -e --id ActivityWatch.ActivityWatch

REM --- Dev Tools ---

winget install -e --id wez.wezterm
winget install -e --id Python.Python.3.11
winget install -e --id Microsoft.PowerShell

winget install -e --id gerardog.gsudo
winget install -e --id Nushell.Nushell
REM TODO: investigate starship vs cmder
REM cons:
REM - I don't use starship on linux
REM - prob not worth extra effort of configuring msysgit
winget install -e --id Starship.Starship

REM TODO: cmder must be installed through choco or manually, or perhaps using wingetui's exports

REM --- Workflow ---

winget install -e --id VivaldiTechnologies.Vivaldi
winget install -e --id Obsidian.Obsidian
winget install -e --id SomePythonThings.WingetUIStore
