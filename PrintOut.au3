#include-once

Func PrintOut()

	ControlClick("Print", "", "[CLASS:Button; INSTANCE:6]")

	Sleep($LOADING_TIME_SLOW_PC_RELATED*2)
	Send("{ENTER}")
	WinWaitNotActive("Print")
	WinWaitNotActive("Printing")

EndFunc   ;==>PrintoutOut
