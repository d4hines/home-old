#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode RegEx
CoordMode, Mouse, Screen

^+k::run "https://chartiq.kanbanize.com/ctrl_board/18"
^!r::OpenRoam()
;; Activate Slack
^!s::Click, 2358, 1426

OpenRoam() {
  IfWinExist, Chrome
  {
    WinActivate ; Automatically uses the window found above.
    return
  } else {
    Run, C:\Program Files (x86)\Google\Chrome\Application\Chrome.exe https://roamresearch.com/#/app/d4hines
  }
}


