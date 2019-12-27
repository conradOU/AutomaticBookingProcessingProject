#include-once

Func PostPaymentOnSkyware($amount)

	If QuantityOfRooms() > 1 Then
		Exit  ;added on 11/11 not tested yet
	Else
		MouseClick("left", 918, 248, 1, 0)     ;clicks the finish button
	EndIf

	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum( _
			$g_aSkywareIconLocation[$firstParam], _
			$g_aSkywareIconLocation[$secondParam], _
			$g_aSkywareIconLocation[$thirdParam], _
			$g_aSkywareIconLocation[$fourthParam])                                 ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED * 3) ;necessary here

	If $g_bIsItForToday Then
		MouseClick("left", 710, 173, 1, 0)        ;if it's for today and after night audit, Skyware adds an extra check in button, which shifts the location of the gold coin. Also same as 8 tabs and enter
	Else
		MouseClick("left", 674, 174, 1, 0)    ;clicks goldcoin, also same as 7 tabs and enter
	EndIf

	While Send("{ENTER}") And Sleep(2000) And $g_iCheckSumSkywareIcon <> PixelChecksum( _
			$g_aSkywareIconLocation[$firstParam], _
			$g_aSkywareIconLocation[$secondParam], _
			$g_aSkywareIconLocation[$thirdParam], _
			$g_aSkywareIconLocation[$fourthParam])                                 ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		;above sleep() and send() in the while was necessary to acomodate to how the website was behaving in that particular case, do not refactor it to the inside of the loop
		Sleep(100)
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])     ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	MouseClick("left", 580, 421, 1, 0) ;clicks on the posting type, don't do it by tab as it varies at random between 12 and 13 tabs, independednt of the hotel
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	Send("{DOWN 3}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB 2}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send($amount)
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	If @UserName = "User" Then   ;if YP PC
		Send("{TAB 5}")
	ElseIf @UserName = "Ballantrae" Then   ;if albany left PC
		Send("{TAB 6}")  ;due to currency option being available at the albant, but not at the yp
	Else
		MsgBox(0, "", "" & @UserName & " is unsupported")
		Exit
	EndIf
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{DEL}")      ;to delete highlighted
	Send("{SPACE}")            ;necessary here to fix a bug
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

	Sleep($LOADING_TIME_SLOW_PC_RELATED * 3)
	Send("{SHIFTDOWN}{TAB 2}{SHIFTUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])      ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
		Send("{ENTER}")      ;send ENTER to agree
	WEnd      ;wait for the Skyware to load, put code here AND send enter in case of a pop up, it's not a problem if there is no popup

	Send("^4")  ;navigates to the fourth tab, which is where you always have the email open; changed as now this script can work with ProcessMultipleBookings.au3 one

EndFunc   ;==>PostPaymentOnSkyware
