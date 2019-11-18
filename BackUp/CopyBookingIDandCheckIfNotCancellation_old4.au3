#include-once

Func CopyBookingIDandCheckIfNotCancellation()

	Local $sBookingID = ""

	Sleep($LOADING_TIME_SLOW_PC_RELATED*4)

	Send("^a") ;to highlight all
	SafelyCopyHighlightedToClipboard()

	$g_sClipboardWithBookingNumber = ClipGet()
	;now check if clipboard is not empty, as that would indicate potential error, be it not loaded page or something else.
	If @error Then ;if clipboard is empty OR contains a non-text entry OR cannot access the clipboard

		Sleep($LOADING_TIME_SLOW_PC_RELATED*4)

		Send("^a") ;to highlight all
		SafelyCopyHighlightedToClipboard()
	EndIf

	If StringRegExp($g_sClipboardWithBookingNumber, "(Cancellation Charge|Reservation Cancellation|THE FOLLOWING RESERVATION HAS BEEN CANCELLED)") = True Then

	   Send("^p") ;to print
	   _WinWaitActivate("Print", "") ;that window name is always correct, at both hotels
	   Sleep($LOADING_TIME_SLOW_PC_RELATED) ;necessary

	   PrintOut()

	   WinClose($g_sPrintOutWindowCharacterics)

	   Exit
	EndIf

	If StringRegExp($g_sClipboardWithBookingNumber, "(SiteMinder)") = True Then $g_bWasItSiteminderBooking = True
	If StringRegExp($g_sClipboardWithBookingNumber, "(Non-refundable|Advanced Purchase|non refundable|Non Refundable)") = True Then $g_bIsItADV = True

    If StringRegExp($g_sClipboardWithBookingNumber, "Agoda") = False And _
			StringRegExp($g_sClipboardWithBookingNumber, "(Expedia Collect Booking|virtual credit card)") = False Then

	  Send("^p") ;to print
	  _WinWaitActivate("Print", "") ;that window name is always correct, at both hotels
	  Sleep($LOADING_TIME_SLOW_PC_RELATED) ;necessary

	  PrintOut()

    EndIf

    WinClose($g_sPrintOutWindowCharacterics)

	$sBookingID = StringRegExp($g_sClipboardWithBookingNumber, "([0-9,B]{8,15})", 1)
	If @error Then Exit MsgBox(0, "Error", "StringRegExp returned error, if 1 then it wasn't able to find booking ID: " & @error)

	PrintOutSiteminderPaperwork()    ;logically if cancellation, then it won't print out the skyware, as the program won't get to this point if it was a cancellation
	If ClipPut($sBookingID[0]) = False Then MsgBox(0, "Error", "Clipboard didn't change")

	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;because it was too fast and ctrl5 was being set to the the wrong window
	SearchByIdOnTheSkyware()

EndFunc   ;==>CopyBookingIDandCheckIfNotCancellation
