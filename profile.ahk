#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode RegEx
CoordMode, Mouse, Screen

^+k::run "https://chartiq.kanbanize.com/ctrl_board/18"
^!r::run "http://roamresearch.com/#/v10/d4hines"
;; Activate Slack
^!s::Click, 2358, 1426

; ^f::OpenTheThing()
; 
; OpenTheThing() {
;   IfWinExist, MINGW64`:/c/Users/d4hin/my_special_folder
;   {
;     WinActivate  ; Automatically uses the window found above.
;     return
;   } else {
;     Run,  C:\Program Files\Git\git-bash.exe, C:/Users/d4hin/my_special_folder
;   }
; }

