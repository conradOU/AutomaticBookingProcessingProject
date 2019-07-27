#include-once

Func TryToAssignRoom()

	Local $numberOfRooms = QuantityOfRooms()

	MouseClick("left", 565, 171, 1, 0)   ;clicks on modify stay
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	If QuantityOfRooms() > 1 Then ;do it if there is over 1 room booked, as you won't be able to automatically assign multiple rooms, it's not scriptable
		MouseClick("left", 441, 215, 1, 0) ;clicks to open the screen with multi room assignment
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
;~ 		 While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
;~ 			Sleep(100)
;~ 		 WEnd
		 ;if prepaid and not for today, go to email
		 ;if prepaid and for today, then open Payment Tab in a new tab then CheckIfDeclinedOrPaid()
		 ;if adv then open Payment Tab in a new tab then CheckIfDeclinedOrPaid()
		 ;if bfast rate then open payment tab in a new tab, then navigate to email then prompt to enter the amout taken or declined (new gui!) then hook that up with  EmailDeclainedBookingToLen() and PostPaymentOnSkyware($amount)
		;Send("^4") ;navigates to the fourth tab, which is where you always have the email open
		;now you're in the email. Display prompt to add up the rates
	Else   ;if there is only one room
		;make sure if its empty then it should throw error, but still try to proceed to try to assign the room
		MouseClick("left", 796, 397, 1, 0)  ;clicks on trying to assign the room
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		Send("{DOWN}")  ;changes from blank to a first available room
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		Send("{ENTER}")  ;send ENTER to agree
		Sleep($LOADING_TIME_SLOW_PC_RELATED)

		If $g_iSkywareSuccessfulRoomAllocation <> PixelChecksum(762, 391, 780, 400) Then
			If $g_bIsItNecessaryToPrintOutSiteminder = True Or $g_bWasItSiteminderBooking = True Or $g_bIsItForToday = True Then
				MouseClick("left", 522, 805, 1, 0) ;clicks to uncover the card details, to allow charging, only does it if the card isn't prepaid and you were able to automatically allocate the room, hence the check
				Sleep($LOADING_TIME_SLOW_PC_RELATED) ;important here, don't remove it
				CheckIfDeclinedOrPaid()
			 Else

			   Opt("SendKeyDelay", 100)
			   Send("{SHIFTDOWN}{TAB 23}{SHIFTUP}{ENTER}")
			   Opt("SendKeyDelay", default) ;selects and clicks the finish button

;~ 				MouseClick("left", 918, 248, 1, 0) ;clicks the finish button
				Sleep($LOADING_TIME_SLOW_PC_RELATED)
				While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
					Sleep(100)
				WEnd
				Send("^4") ;navigates to the fourth tab, which is where you always have the email open
			EndIf
		EndIf
	EndIf

EndFunc   ;==>TryToAssignRoom
