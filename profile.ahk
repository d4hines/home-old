#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include, complice.ahk
#Persistent

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetTitleMatchMode RegEx
CoordMode, Mouse, Screen

;Esc::CapsLock

Capslock::Esc

#IfWinNotActive ahk_exe brave.exe
XButton2::^]

#IfWinNotActive ahk_exe brave.exe
XButton1::^[

:*:;;shrug::¯\_(ツ)_/¯
:*:;;shrug::¯\_(ツ)_/¯
:*:;;whatever::◔_◔
:*:;;why::щ(ºДºщ)
:*:;;happy::(ﾟヮﾟ)
:*:;;flip::(╯°□°）╯︵ ┻━┻
:*:;;lambda::λ
:*:;;waw::ϝ
:*:;;Gamma::Γ
:*:;;Pi::Π
:*:;;forall::∀
:*:;;exists::∃
:*:;;tz::ꜩ
:*:;;f::d4hines@FIXME:
