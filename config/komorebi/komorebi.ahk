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
EnsureNamedWorkspaces(1, "A B C D E F")

; Assign layouts to workspaces, possible values: bsp, columns, rows, vertical-stack, horizontal-stack, ultrawide-vertical-stack
; NOTE: assigning them a workspace layout prevents resizing
; NamedWorkspaceLayout("I", "ultrawide-vertical-stack")
; NamedWorkspaceLayout("II", "ultrawide-vertical-stack")
; NamedWorkspaceLayout("III", "vertical-stack")

; Set the gaps around the edge of the screen for a workspace
NamedWorkspacePadding("I", 0)
NamedWorkspacePadding("II", 0)
NamedWorkspacePadding("III", 0)
NamedWorkspacePadding("IIII", 0)
NamedWorkspacePadding("IV", 0)
; Set the gaps between the containers for a workspace
NamedWorkspaceContainerPadding("I", 0)
NamedWorkspaceContainerPadding("II", 0)
NamedWorkspaceContainerPadding("III", 0)
NamedWorkspaceContainerPadding("IIII", 0)
NamedWorkspaceContainerPadding("IV", 0)

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
; ActiveWindowBorderColour(66, 165, 245, "single")
;ActiveWindowBorderColour(256, 165, 66, "stack")
; ActiveWindowBorderColour(255, 51, 153, "monocle")

; Nicer, more muted colours
; active/single = light green
ActiveWindowBorderColour(161, 203, 187, "single")
; stack = blue
ActiveWindowBorderColour(53, 114, 165, "stack")
; monacle = red
ActiveWindowBorderColour(211, 134, 155, "monocle")

; NOTE: CompleteConfiguration denotes the end of the declarative config,
; NOTE: i.e. komorebi.exe can now safely start
; Everything after this is for runtime declaractions like hotkeys
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
; Backup for RDP, when win-L cannot be bound
; #left::Focus("left")
; #down::Focus("down")
; #up::Focus("up")
; #right::Focus("right")

; Focus
#Enter::Promote()
#!Enter::PromoteFocus()

; Move windows
#+h::Move("left")
#+j::Move("down")
#+k::Move("up")
#+l::Move("right")
#+left::Move("left")
#+down::Move("down")
#+up::Move("up")
#+right::Move("right")

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
#]::ResizeAxis("horizontal", "increase")
#[::ResizeAxis("horizontal", "decrease")
#+]::ResizeAxis("vertical", "increase")
#+[::ResizeAxis("vertical", "decrease")

; Manipulate windows
#t::ToggleFloat()
#f::ToggleMonocle()
;; BUG: appears broken; use my own win+m
; #!up::ToggleMaximize()
#!down::Minimize()

; Window manager options
#!r::Retile()
#!p::TogglePause()

;; komorebi Process management
;; kill and restart process - finally confirmed working
#!^r:: {
    Run "taskkill /f /im komorebi.exe"
    Run "komorebic.exe start -a --ahk"
    Reload
}
#!^s::Start("", true, "")
; #!^s::Run "komorebic start -c $Env:KOMOREBI_CONFIG_HOME\komorebi.json"
;; nuke it
#!^q::Run "taskkill /f /im komorebi.exe"
#!^o::ReloadConfiguration()
; NOTE: Sometimes works to reload
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

; TODO: custom layout; currently looks identical to ultrawide-vertical-stack
#+n::{
    Run "komorebic load-custom-layout $Env:KOMOREBI_CONFIG_HOME\custom\ultrawide.json", ,"Hide"
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
