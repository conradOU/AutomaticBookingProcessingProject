#include "Constants.au3"

#include-once

Func PrintOut()

	Send("^p") ;to print

	_WinWaitActivate("Print", "") ;that window name is always correct, at both hotels

	While ControlClick("Print", "", "[CLASS:Button; INSTANCE:10]") = 0 ;if it wasn't able to do it. This loop will always execute condition first, as opposed to Do...Until loop
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		ContinueLoop
	WEnd

   Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While ControlClick("Print", "", "[CLASS:Button; INSTANCE:13]") = 0 ;if it wasn't able to do it. This loop will always execute condition first, as opposed to Do...Until loop
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		ContinueLoop
	WEnd

	WinWaitNotActive("Print")
	WinWaitNotActive("Printing")

EndFunc   ;==>PrintOut
