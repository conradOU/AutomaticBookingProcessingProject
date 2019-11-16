#include-once

Func PrintOut()

	While ControlClick("Print", "", "[CLASS:Button; INSTANCE:10]") = 0 ;if it wasn't able to do it. This loop will always execute condition first, as opposed to Do...Until loop
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		ControlClick("Print", "", "[CLASS:Button; INSTANCE:10]")
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	WinWaitNotActive("Print")
	WinWaitNotActive("Printing")

EndFunc   ;==>PrintoutOut
