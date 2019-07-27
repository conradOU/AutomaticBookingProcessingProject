#include-once

Func JustPosting(ByRef $amount)

	MouseClick(918, 248, 1, 0)     ;clicks the finish button

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	MouseClick(622, 171, 1, 0)     ;clicks goldcoin
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
		Send("{ENTER}")      ;send ENTER to agree
	WEnd     ;wait for the Skyware to load, put code here AND send enter in case of a pop up, it's not a problem if there is no popup

	MouseClick(519, 419, 1, 0)      ;click 519, 419 then send arrow down three times, then send ENTER, not need to wait for the Skyware to load
	Send("{DOWN 3}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	MouseClick(375, 447, 1, 0)	;switch to doing that with TAB keys not mouseclick
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send($amount)
	MouseClick(399, 519, 2, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("^x")      ;to delete highlighted
	MouseClick(412, 522, 2, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("^x")      ;to delete highlighted
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	MouseClick(365, 547, 2, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	MouseClick(785, 665, 2, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
		Send("{ENTER}")      ;send ENTER to agree
	WEnd     ;wait for the Skyware to load, put code here AND send enter in case of a pop up, it's not a problem if there is no popup

EndFunc   ;==>JustPosting
