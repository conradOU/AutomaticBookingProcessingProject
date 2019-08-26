#include-once

Func TryToAssignRoom()

	Local $numberOfRooms = QuantityOfRooms()

	MouseClick("left", 617, 172, 1, 0)   ;clicks on modify stay
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd

	If QuantityOfRooms() > 1 Then ;do it if there is over 1 room booked, as you won't be able to automatically assign multiple rooms, it's not scriptable
		MouseClick("left", 441, 215, 1, 0) ;clicks to open the screen with multi room assignment
;~ 		Sleep($LOADING_TIME_SLOW_PC_RELATED)
;~ 		 While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
;~ 			Sleep(100)
;~ 		 WEnd
;~ 		;if prepaid and not for today, go to email
;~ 		If $g_bIsItForToday = False And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
;~ 			Send("^4") ;goes to email
;~ 			MsgBox(0, "", "multroom booking not for today, please assign rooms, no payment to be taken")
;~ 			;if prepaid and for today, then open Payment Tab in a new tab then CheckIfDeclinedOrPaid()
;~ 		ElseIf $g_bIsItForToday = True And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
;~ 			$amount = ReturnProjectedBalance()
;~ 			;code to duplicate the tab here [CTRL key, then type(lowercase) L C T V ENTER]
;~ 			PostPaymentOnSkyware($amount) ; you will need to modify PostPaymentOnSkyware to work in this case (the beginning only that is the location of the finish button, maybe have it as an if statement or some switch in the function call)
;~ 			MsgBox(0, "", "Booking for today, payment posted, now allocate the rooms")
;~ 			;if adv then open Payment Tab in a new tab then CheckIfDeclinedOrPaid()
;~ 		ElseIf $g_bIsItADV = True Then
;~ 			;if adv but not prepaid and not for today
;~ 			;code to duplicate the tab here [CTRL key, then type(lowercase) L C T V ENTER]
;~ 			CheckIfDeclinedOrPaid()
;~ 			MsgBox(0, "", "Allocate the rooms")
;~ 		Else
;~ 			;if not adv and for a single night then you'll take full payment anyway
;~ 			;you need to check $g_sSkywareArrivalRateNumberOfRooms for number of nights, if only one then
;~ 			$amount = ReturnProjectedBalance()
;~ 			;code to duplicate the tab here [CTRL key, then type(lowercase) L C T V ENTER]
;~ 			PostPaymentOnSkyware($amount)    ; you will need to modify PostPaymentOnSkyware to work in this case (the beginning only that is the location of the finish button, maybe have it as an if statement or some switch in the function call)

;~ 			;if breakfast rate and for multiple days
;~ 			;code to duplicate the tab here [CTRL key, then type(lowercase) L C T V ENTER]
;~ 			;Send("^4") ;navigates to the fourth tab, which is where you always have the email open
;~ 			;now you're in the email. Display prompt to add up the rates and that the scripts waits for some key combination
;~ 			;wait for key combination
;~ 			;go to posting section then prompt how much to post or if it was declined
;~ 			MsgBox(0, "", "Allocate the rooms")
;~ 		EndIf

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

				Opt("SendKeyDelay", 15)
				Send("{SHIFTDOWN}{TAB 23}{SHIFTUP}{ENTER}")
				Opt("SendKeyDelay", Default) ;selects and clicks the finish button

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
