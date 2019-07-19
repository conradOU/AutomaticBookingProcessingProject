#include-once

Func TryToAssignRoom()
	;check first if it's over 1 room, if yes, proceed as normal, if no, only got to and execute ;clicks on modify stay position - 1038, 288 the copied value will be just a number
	MouseClick("left", 1047, 289, 3, 0) ;briefly tested with both YP and Albany, tries to find out number of rooms
	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't alway changing immediately
	Send("^c") ;to copy
	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't alway changing immediately
	MouseClick("left", 565, 171, 1, 0)   ;clicks on modify stay
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
		Sleep(100)
	WEnd
	If ClipGet() > 1 Then ;do it if there is over 1 room booked, as you won't be able to automatically assign multiple rooms, it's not scriptable
		MouseClick("left", 441, 215, 1, 0) ;clicks to open the screen with multi room assignment
	Else   ;if there is only one room
		;make sure if its empty then it should throw error, but still try to proceed to try to assign the room
		MouseClick("left", 796, 397, 1, 0)  ;clicks on trying to assign the room
		Send("{DOWN}")  ;changes from blank to a first available room
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		Send("{ENTER}")  ;send ENTER to agree
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		If $g_iSkywareSuccessfulRoomAllocation <> PixelChecksum(762, 391, 780, 400) Then
			If $g_bIsItNecessaryToPrintOutSiteminder = True Or $g_bWasItSiteminderBooking = True Then
				MouseClick("left", 522, 805, 1, 0) ;clicks to uncover the card details, to allow charging, only does it if the card isn't prepaid and you were able to automatically allocate the room, hence the check
				MouseMove(918, 248, 0) ;moves the mouse over the finish button
			Else
				MouseClick("left", 918, 248, 1, 0) ;clicks the finish button
				Sleep($LOADING_TIME_SLOW_PC_RELATED)
				While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
					Sleep(100)
				WEnd
				Send("^4") ;navigates to the fourth tab, which is where you always have the email open
			EndIf
			;think, once you can read the rate plan, then the script will be able to decide to copy correct ammount of £ for faster posting later on.
			;it's always possible to have another component switching on in appriopriate place asking question (was the card declined?) and then do the posting (which takes 13-14 clicks). You can search the text from email, as ctrl+a before closing that window with printout... Then search for "Non-refundable" " Advanced Purchase ()" You could search for way more info with just one highlighting to make script faster and more efficient, but it would require major changes in program's logic. Also that would be a good point to decide if printing the reg card is necessary and then do it. Use paper and diagrams to plan it out. This is a good place to call the function responsible for posting the payment, let it ask you how much did you charge and if it went through, then go with posting or reporting as declined (f shortcut on the email then email to len, let it be saved in the drafts) from there
		EndIf
	EndIf
EndFunc   ;==>TryToAssignRoom