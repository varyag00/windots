@echo off
title startup script
nircmd win hide title "yasb"

:: set $HOME so yasb takes it configuration from this dir; kinda silly
:: TODO: check if yasb can specify config location via CLI flag
set HOME="%WINDOWS_BOOTSTRAP_DIR%\config"

pythonw.exe C:\Users\dgonz\SRC\yasb\src\main.py
