#include-once

Func PrintoutOut()

	Local $iCheckSumRegCard = 1542064209

	MouseClick("left", 462, 173, 1, 0) ;you can change it to 4 tabs and enter
	_WinWaitActivate("Select Document to Print or E-Mail", "") ;that window name is always correct, at both hotels
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB 6}{ENTER}") ;more accurate than clicking

	While $iCheckSumRegCard <> PixelChecksum(463, 122, 499, 176) ;tested on the left PC at the Albany
		Sleep(100)
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("^p") ;to print
;~ 	_WinWaitActivate("Print", "")
    WinWaitNotActive("Custom Registration Card")
	ControlClick("Print", "", "[CLASS:Button; INSTANCE:6]")

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	WinWaitNotActive("Print")
   WinWaitNotActive("Printing")
;~ 	Sleep($LOADING_TIME_SLOW_PC_RELATED * 5)

	Send("^w") ;closes the tab and goes back to the tab where you started
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

EndFunc   ;==>PrintoutRegCard