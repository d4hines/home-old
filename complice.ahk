; Enforces Complice usage by turning on a greyscale
; filter whenever a Complice Pomodoro isn't running.
; (honesty not included).

; Usage:
; - Install Autohotkey
; - Create an environment variable with key "CompliceURL"
;   and value "https://complice.co/api/v0/u/me/today/timer/all?auth_token=YOUR_AUTH_TOKEN"
;   Be sure to replace with your correct token. Complice will display it for you
;   at https://complice.co/apidocs.
; - Create a shortcut to this script and place it in your startup folder. You can
;   find this folder by using "Run" (Win+R) and entering "shell:startup". This will
;   ensure the script runs every time you log in.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Goto, ReconcileCompliceGreyScale

ReconcileCompliceGreyScale:
    EnvGet, CompliceURL, CompliceURL
	WinHTTP := ComObjCreate("WinHTTP.WinHttpRequest.5.1")
	WinHTTP.Open("GET", CompliceURL, 0)
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
