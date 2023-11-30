#Requires AutoHotkey v2.0

; Shortcut Guide
;\
;\ # = Super
;\ ! = Alt
;\ ^ = Ctrl
;\ + = Shift

#SingleInstance Force

; Load library
#Include komorebic.lib.ahk
; Load configuration
#Include komorebi.generated.ahk

;; NOTE: configuration section (ending in CompleteConfiguration() if using static config (komorebi.json)
; Send the ALT key whenever changing focus to force focus changes
AltFocusHack("enable")
; Default to cloaking windows when switching workspaces
; WindowHidingBehaviour("minimize")
WindowHidingBehaviour("cloak")
; Set cross-monitor move behaviour to insert instead of swap
CrossMonitorMoveBehaviour("Insert")
; NOTE: dangerous? Enable hot reloading of changes to this file
WatchConfiguration("enable")

; Create named workspaces I-V on monitor 0
EnsureNamedWorkspaces(0, "I II III IV V")
; You can do the same thing for secondary monitors too
; EnsureNamedWorkspaces(1, "A B C D E F")

; Assign layouts to workspaces, possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack
; NOTE: assigning them a workspace layout prevents resizing
NamedWorkspaceLayout("I", "ultrawide-vertical-stack")
; NamedWorkspaceLayout("II", "ultrawide-vertical-stack")
; NamedWorkspaceLayout("III", "vertical-stack")

; Set the gaps around the edge of the screen for a workspace
NamedWorkspacePadding("I", 5)
NamedWorkspacePadding("II", 5)
NamedWorkspacePadding("III", 5)
; Set the gaps between the containers for a workspace
NamedWorkspaceContainerPadding("I", 10)
NamedWorkspaceContainerPadding("II", 10)
NamedWorkspaceContainerPadding("III", 10)

; You can assign specific apps to named workspaces
; NamedWorkspaceRule("exe", "Vivaldi.exe", "I")

; NamedWorkspaceRule("exe", "mstsc.exe", "II")
; NamedWorkspaceRule("exe", "Teams.exe", "II")

; NamedWorkspaceRule("exe", "Steam.exe", "III")
; NamedWorkspaceRule("exe", "TidalPlayer.exe", "III")
; NamedWorkspaceRule("exe", "Creative.App.exe", "III")
; NamedWorkspaceRule("exe", "SteelSeriesGGClient.exe", "III")

; Configure the invisible border dimensions
InvisibleBorders(7, 0, 14, 7)

; Uncomment the next lines if you want a visual border around the active window
ActiveWindowBorder("enable")
ActiveWindowBorderColour(66, 165, 245, "single")
;ActiveWindowBorderColour(256, 165, 66, "stack")
ActiveWindowBorderColour(255, 51, 153, "monocle")

; Nicer, more muted colours
; active/single = light green
ActiveWindowBorderColour(161, 203, 187, "single")
;ActiveWindowBorderColour(131, 165, 152, "stack")
; stack = blue
ActiveWindowBorderColour(53, 114, 165, "stack")
; monacle = red
ActiveWindowBorderColour(211, 134, 155, "monocle")
CompleteConfiguration()


#!^6:: {
    ;; BUG: annoying that it open a new vivaldi window when there is an existing hidden one in a stack
    ;; BUG: Seems to only happen when NOT on using WindowHidingBehaviour("minimize") above (default is "cloak")
    if WinExist("ahk_exe" "vivaldi.exe") ;; TODO: try AND ProcessExist: https://www.autohotkey.com/docs/v2/lib/ProcessExist.htm
        WinActivate
    ; else
    ;     Run "vivaldi.exe"
}
#!^7:: {
    if WinExist("ahk_exe" "Teams.exe")
        WinActivate
    ; else
    ;     Run "Teams.exe"
}
; #!^7:: {
;     if WinExist("ahk_exe" "WindowsTerminal.exe")
;         WinActivate
;     ; else
;     ;     Run "wt.exe"
; }
#!^8:: {
    if WinExist("ahk_exe" "mstsc.exe")
        WinActivate
}
#!^9:: {
    if WinExist("ahk_exe" "TIDAL.exe")
        WinActivate
    ; else
    ;     Run "TIDAL.exe"
}

; Focus windows
#h::Focus("left")
#j::Focus("down")
#k::Focus("up")
#l::Focus("right")
#o::CycleFocus("previous")
#i::CycleFocus("next")
; Backup for RDP (win-L can't be bound)
#left::Focus("left")
#down::Focus("down")
#up::Focus("up")
#right::Focus("right")

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#+left::Move("left")
#+down::Move("down")
#+up::Move("up")
#+right::Move("right")

; Focus
#Enter::Promote()
#!Enter::PromoteFocus()

; Stack windows
#^h::Stack("left")
#^l::Stack("right")
#^k::Stack("up")
#^j::Stack("down")
#^;::Unstack()
#;::Unstack()
#^o::CycleStack("previous")
#^i::CycleStack("next")

; Resize
; BUG: these don't reliably work
#]::ResizeAxis("horizontal", "increase")
#[::ResizeAxis("horizontal", "decrease")
#!]::ResizeAxis("vertical", "increase")
#![::ResizeAxis("vertical", "decrease")

; Manipulate windows
; #!t::ToggleFloat()
#t::ToggleFloat()
; #!f::ToggleMonocle()
#f::ToggleMonocle()
;; BUG: appears broken; use my own win+m
#^+!Enter::ToggleMaximize()
#^+!Backspace::Minimize()

; Window manager options
#!r::Retile()
#!p::TogglePause()

;; komorebi Process management
;; kill and restart process - finally confirmed working
#!^r:: {
    Run "taskkill /f /im komorebi.exe"
    Run "komorebic.exe start -a"
    Reload
}
#!^s::Start("", true, "")
; #!^s::Run "komorebic start -c $Env:KOMOREBI_CONFIG_HOME\komorebi.json"
;; nuke it
#!^q::Run "taskkill /f /im komorebi.exe"
#!^o::ReloadConfiguration()
#!^h::Reload

; Layouts
#x::FlipLayout("horizontal")
#y::FlipLayout("vertical")

; Switch to an equal-width
; max-height column layout on the main workspace, Win + Shift + C
; -------------
; |   |   |   |
; |   |   |   |
; -------------
#+c::{
    Run "komorebic change-layout columns", ,"Hide"
}
; -------------
; |  |     |  |
; |  |     |  |
; -------------
#+v::{
    Run "komorebic change-layout ultrawide-vertical-stack", ,"Hide"
}
; NOTE: (B)inary (S)pace (P)artition
; --------------
; |    |       |
; |    |--------
; |    |   |   |
; --------------
#+b::{
    Run "komorebic change-layout bsp", ,"Hide"
}

;; Manage & Unmanage focused application
#!m::Manage()
#!u::Unmanage()

; Workspaces

#F5::QuickSaveResize()
#!^+s::QuickSaveResize()
#F6::QuickLoadResize()
#!^+l::QuickLoadResize()

#+F5::SaveResize("$Env:HOME\.config\komorebi\workspace")
#+F6::LoadResize("$Env:HOME\.config\komorebi\workspace")

; move to workspace
#6::FocusWorkspace(0)
#7::FocusWorkspace(1)
#8::FocusWorkspace(2)
#9::FocusWorkspace(3)
#0::FocusWorkspace(4)

; Move windows across workspaces
#+6::MoveToWorkspace(0)
#+7::MoveToWorkspace(1)
#+8::MoveToWorkspace(2)
#+9::MoveToWorkspace(3)
#+0::MoveToWorkspace(4)
