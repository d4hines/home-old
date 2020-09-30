#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode RegEx
CoordMode, Mouse, Screen

^+k::run "https://chartiq.kanbanize.com/ctrl_board/18"
^!d::run "https://bit.ly/3k9OyQ3"
^!b::run "https://bit.ly/3kOkjyr"
^!r::OpenRoam()
;; Activate Slack
^!s::OpenSlack()
OpenSlack() {
  send, ^{Esc}
  sleep, 200
  send, slack
  sleep, 100
  send, {Enter}
}

OpenRoam() {
  IfWinExist, Chrome
  {
    WinActivate ; Automatically uses the window found above.
    return
  } else {
    Run, C:\Program Files (x86)\Google\Chrome\Application\Chrome.exe https://roamresearch.com/#/app/d4hines
  }
}

; Open a new Notepad++ document
; In the menu bar, click on Encoding > Encode in UTF-8 BOM
; Paste this into Notepad++
; Save as emoji_expansion.ahk
; run
; type "!shrug" (without quotes) to get ¯\_(ツ)_/¯

::!shrug::¯\_(ツ)_/¯
::!whatever::◔_◔
::!why::щ(ºДºщ)
::!happy::(ﾟヮﾟ)
::!flip::(╯°□°）╯︵ ┻━┻
::!\lambda::λ
::!\waw::ϝ
::!\Gamma::Γ
::!\Pi::Π
::!\forall::∀

::smd::SmartDesktop