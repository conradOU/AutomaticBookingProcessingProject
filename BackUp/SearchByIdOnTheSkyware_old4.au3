#include-once

Func SearchByIdOnTheSkyware()

	WinActivate("Webmail - Mozilla Firefox")
	;WinWaitActive("Webmail")
	Send("^5") ;navigates to the fifth tab, which is where you always have the Skyware open
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Send("{ENTER}") ;in case if there are any pop-ups (if Skyware was left on some reservation and not default page), if there are none that enter doesn't do "harm"
		Sleep(100)
	WEnd

   Sleep($LOADING_TIME_SLOW_PC_RELATED)
   Send("{PGUP}")
   Sleep($LOADING_TIME_SLOW_PC_RELATED)

	MouseClick("left", 700, 140, 2, 0) ;clicks twice on the field next to search button on the Skyware, twice as if there is anything there it would select it and then get replaced by ctrl+v key compination
	Send("^v") ;pastes the clipboard
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	MouseClick("left", 679, 341, 1, 0) ;accesses the booking
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Send("{ENTER}") ;in case if there are any pop-ups, if there are none that enter doesn't do "harm"
		Sleep(100)
	WEnd

	CheckBookingDate()

	If $g_bIsItForToday = False And _
			StringRegExp($g_sClipboardWithBookingNumber, "(Expedia Collect Booking|virtual credit card|Agoda)") = True Then

		 AddPrepaidCommentOnSkyware()

	EndIf

	TryToAssignRoom()

EndFunc   ;==>SearchByIdOnTheSkyware
