#include-once

Func PrintoutRegCard()

	MouseClick("left", 513, 171, 1, 0) ;you can change it to 4 tabs and enter
	_WinWaitActivate("Select Document to Print or E-Mail", "") ;that window name is always correct, at both hotels
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB 6}{ENTER}") ;more accurate than clicking

	While $g_iCheckSumRegCard <> PixelChecksum(463, 122, 499, 176) ;tested on the left PC at the Albany and YP
		Sleep(100)
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	PrintOut()

	Send("^w") ;closes the tab and goes back to the tab where you started
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

EndFunc   ;==>PrintoutRegCard

