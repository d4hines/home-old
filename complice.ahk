#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Goto, ReconcileCompliceGreyScale

ReconcileCompliceGreyScale:
	WinHTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
	WinHTTP.Open("GET", "https://complice.co/api/v0/u/me/today/timer/all?auth_token=9fca198955303db6e09e", 0)
	Body := ""
	WinHTTP.Send(Body)
	Result := WinHTTP.ResponseText
	IfInString, Result, "inactive"
	{
		RegRead, GreyScaleEnabled, HKEY_CURRENT_USER\SOFTWARE\Microsoft\ColorFiltering, Active
		if !GreyScaleEnabled {
	 		send, #^c
		}
	}
	else {
		RegRead, GreyScaleEnabled, HKEY_CURRENT_USER\SOFTWARE\Microsoft\ColorFiltering, Active
		if GreyScaleEnabled {
			send, #^c
			GreyScaleEnabled = false
		}
	}
	sleep 1000
	Goto, ReconcileCompliceGreyScale
