#include-once

Func PostPaymentOnSkyware()
	;only get to the question about posting if it 1. wasn't agoda/expedia/booking.com prepaid but yes if it was for today 3. room was successfully allocated 4. it wasn't a cancellation
	;1. 2. If $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bIsItForToday = Flase Then Exit 3. just do the call to this function inside the correct if statement 4. script won't get to this point if it was a cancellation
	;^above problem solved by making a call to this function in the right place
	;$g_sClipboardWithBookingNumber - search that for advanced rates and yes, suggest that as amount to post
	;"Non-refundable" booking.com, "non refundable" siteminder, "Non Refundable" expedia - if found, sugest to post full amount. You will not get prepaid cards on this level
	;if not, sugest to just post the rate, unless it's a prepaid and for today, then suggest to post the full amount. If $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bIsItForToday = True Then post the full amount
	;get a reliable way to search for and cut out the full amount
	;$g_sSkywareArrivalRateNumberOfRooms - this contains the rate per night, needs to be filtered first
;~ 		Rate per night:
;~ 			$Result = StringTrimLeft($sClipBoard, StringInStr($sClipBoard, "Rate") +3)
;~ 			$Result = StringTrimRight($Result, StringInStr($Result, "Rooms"))
;~ 			$Result = StringTrimRight($Result, StringInStr($Result, "Room")-1)
;~ 			$Result = StringReplace ($Result, "*", " ")
;~ 			$Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)
	;once you can read the rate plan, then the script will be able to decide to copy correct ammount of £ for faster posting later on.
	;EmailDeclainedBookingToLen()
	#include <WindowsConstants.au3>;needed
	#include <ButtonConstants.au3>;needed For the button#include<EditConstants.au3>;needed For the buttonLocal $idMsg, $bContinueWithPosting
	#include <EditConstants.au3>;needed For the button
	#include <GUIConstantsEx.au3>


	If $g_bIsItForToday = True And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
		$amount = ReturnProjectedBalance() ;that covers you for prepaids, except for Siteminder bookings
	ElseIf $g_bIsItADV = True Then
		$amount = ReturnProjectedBalance()
	Else
		$amount = ReturnRate()
	EndIf

	GUICreate("", 300, 100, 581, 440)
	$idBtnPost = GUICtrlCreateButton("Post: £" & $amount, 1, 1, 100, 100, $BS_DEFPUSHBUTTON)
	$idBtnDeclined = GUICtrlCreateButton("DECLINED", 100, 1, 100, 100)
	$idBtnCancel = GUICtrlCreateButton("Cancel", 200, 1, 100, 100)
	GUISetState()

	Do
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $idBtnCancel
				$idMsg = $GUI_EVENT_CLOSE
			Case $idBtnDeclined
				MsgBox(514, "Title", "This message box will timeout after 10 seconds or select the OK button." & $bContinueWithPosting, 10)
			Case $idBtnPost
				$idMsg = $GUI_EVENT_CLOSE
				$bContinueWithPosting = True
		EndSwitch
	Until $idMsg = $GUI_EVENT_CLOSE

	If $bContinueWithPosting = True Then
		MouseClick(918, 248, 1, 0) ;clicks the finish button
		;wait for the Skyware to load, put code here
		MouseClick(622, 171, 1, 0) ;clicks goldcoin
		;wait for the Skyware to load, put code here AND send enter in case of a pop up, it's not a problem if there is no popup
		;click 392, 421 then send arror down, then send ENTER and wait for the skyware to load
		;click 519, 419 then send arrow down three times, then send ENTER, not need to wait for the Skyware to load
		;click 375, 447 then paste the $amount
		;click 399, 519 ctrl a and then delete
		;click 412, 522 ctrl a and then delete
		;click 365, 547 to post amount and wait for the skyware to load
		;click 785, 665 to submit transaction
		;wait for the skyware skyware to load and in the same loop press ENTER to once again accept any popups

		;
		EndIf
	EndFunc   ;==>PostPaymentOnSkyware

