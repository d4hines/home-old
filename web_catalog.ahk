; Sets up the hook to tell Windows to run ShellMessage function in this script when a Shell Hook event occurs
DllCall( "RegisterShellHookWindow", UInt, A_ScriptHwnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
Return

ShellMessage( wParam,lParam )	; Gets all Shell Hook messages
{
	If ( wParam = 1 ) ;  HSHELL_WINDOWCREATED := 1 ; Only act on Window Created messages
	{
		wId:= lParam				; wID is Window Handle
		WinGetTitle, wTitle, ahk_id %wId%	; wTitle is Window Title
		WinGetClass, wClass, ahk_id %wId%	; wClass is Window Class
		WinGet, wExe, ProcessName, ahk_id %wId%	; wExe is Window Execute
		if (wExe = "Roam Research.exe")			; Only act on the specific Window
			DisableCloseButton(wId)
	}
}

; Skan (https://autohotkey.com/board/topic/80593-how-to-disable-grey-out-the-close-button/)
DisableCloseButton(hWnd) 
{
	hSysMenu:=DllCall("GetSystemMenu","Int",hWnd,"Int",FALSE)
	nCnt:=DllCall("GetMenuItemCount","Int",hSysMenu)
	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-1,"Uint","0x400")
	DllCall("RemoveMenu","Int",hSysMenu,"UInt",nCnt-2,"Uint","0x400")
	DllCall("DrawMenuBar","Int",hWnd)
	Return 
}	

