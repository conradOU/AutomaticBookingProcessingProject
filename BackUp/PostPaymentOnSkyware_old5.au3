#include-once

Func PostPaymentOnSkyware($amount)

	MouseClick("left", 918, 248, 1, 0)     ;clicks the finish button
    Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum( _
									   $g_aSkywareIconLocation[$firstParam], _
									   $g_aSkywareIconLocation[$secondParam], _
									   $g_aSkywareIconLocation[$thirdParam], _
									   $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

    Sleep($LOADING_TIME_SLOW_PC_RELATED*3);necessary here

	If $g_bIsItForToday = True Then
	   MouseClick("left", 659, 174, 1, 0) ;if it's for today and after night audit, Skyware adds an extra check in button, which shifts the location of the gold coin. Also same as 8 tabs and enter
	Else
	   MouseClick("left", 622, 171, 1, 0)     ;clicks goldcoin, also same as 7 tabs and enter
	EndIf

   While Send("{ENTER}") And Sleep(2000) And $g_iCheckSumSkywareIcon <> PixelChecksum( _
									   $g_aSkywareIconLocation[$firstParam], _
									   $g_aSkywareIconLocation[$secondParam], _
									   $g_aSkywareIconLocation[$thirdParam], _
									   $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
									   ;above sleep() and send() in the while was necessary to acomodate to how the website was behaving in that particular case, do not refactor it to the inside of the loop
		Sleep(100)
	WEnd

;~ 	Sleep(10000)

;~     Send("{ENTER}")      ;send ENTER to agree
    Sleep($LOADING_TIME_SLOW_PC_RELATED)

	MouseClick("left", 392, 421, 1, 0)      ;click 392, 421 then send arror down, then send ENTER and wait for the skyware to load
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DOWN}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])     ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	MouseClick("left", 519, 419, 1, 0)      ;click 519, 419 then send arrow down three times, then send ENTER, not need to wait for the Skyware to load
	Send("{DOWN 3}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	MouseClick("left", 375, 447, 1, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send($amount)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB 6}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DEL}")      ;to delete highlighted
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DEL}")      ;to delete highlighted
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
    Send("{TAB 2}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
    Send("{ENTER}")

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

    Sleep($LOADING_TIME_SLOW_PC_RELATED*2)
	MouseClick("left", 785, 665, 1, 0)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
		Send("{ENTER}")      ;send ENTER to agree
	WEnd     ;wait for the Skyware to load, put code here AND send enter in case of a pop up, it's not a problem if there is no popup

EndFunc   ;==>JustPosting
