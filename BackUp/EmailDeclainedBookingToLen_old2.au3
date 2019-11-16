#include-once

Func EmailDeclainedBookingToLen()

	MouseClick("left", 918, 248, 1, 0) ;clicks the finish button

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	 WEnd

	Send("^4") ;navigates to the fourth tab, which is where you always have the email open
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("f") ;to forward the email
    Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While 879760830 <> PixelChecksum(680, 70, 755, 86) ;tested on the YP PC, sleep when it "loads"
		Sleep(100)
    WEnd

    Sleep($LOADING_TIME_SLOW_PC_RELATED)
    Send('"len carthy" <lenfiat@hotmail.com>, ')
    Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB 3}") ;navigates to part with the email body
	Sleep($LOADING_TIME_SLOW_PC_RELATED*3)
	Send("approximate time of the card being declined: as sent^")
	Sleep($LOADING_TIME_SLOW_PC_RELATED*3)

    MouseClick("left", 521, 177, 1, 0) ;click save as a draft

	While 879760830 <> PixelChecksum(680, 70, 755, 86) ;tested on the YP PC, sleep when it "loads"
		Sleep(100)
    WEnd

    Sleep(600*10)

    MouseClick("left", 1032, 144, 1, 0) ;closes the window

   ; Send("{ESCAPE}") doesn't wokr at the YORK place, must be something to do with the keyboard layout, as it behaves as if WINDOWS key was pressed

EndFunc   ;==>EmailDeclainedBookingToLen
