#include-once

Func _WinWaitActivate($title, $text, $timeout = 0)

	;WinWait($title,$text,$timeout) ;waiting for a window to even exist in the first place
	If Not WinActive($title, $text) Then WinActivate($title, $text)
	WinWaitActive($title, $text, $timeout)

EndFunc   ;==>_WinWaitActivate