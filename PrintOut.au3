#include-once

Func PrintOut()

;~ 	ControlClick("Print", "", "[CLASS:Button; INSTANCE:6]")
;~
;~ 	Sleep($LOADING_TIME_SLOW_PC_RELATED*4)
	ControlClick("Print", "", "[CLASS:Button; INSTANCE:10]")

	Sleep($LOADING_TIME_SLOW_PC_RELATED*4)
	Send("{ENTER}")
	WinWaitNotActive("Print")
	WinWaitNotActive("Printing")

EndFunc   ;==>PrintoutOut
