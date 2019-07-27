#include-once

Func CopyBookingIDandCheckIfNotCancellation()

	Local $sBookingID = ""

   Sleep($LOADING_TIME_SLOW_PC_RELATED)

	Send("^a") ;to highlight all
	SafelyCopyHighlightedToClipboard()

;~ WinClose("[CLASS:MozillaWindowClass; X:395\Y:90\W:666\H:732]")
;~    WinWaitClose("[CLASS:MozillaWindowClass; X:395\Y:90\W:666\H:732]")
   WinClose($g_sPrintOutWindowCharacterics)

	$g_sClipboardWithBookingNumber = ClipGet()

	If StringRegExp($g_sClipboardWithBookingNumber, "(Cancellation Charge|Reservation Cancellation|THE FOLLOWING RESERVATION HAS BEEN CANCELLED)") = True Then Exit
	If StringRegExp($g_sClipboardWithBookingNumber, "(SiteMinder)") = True Then $g_bWasItSiteminderBooking = True
	If StringRegExp($g_sClipboardWithBookingNumber, "(Non-refundable|Advanced Purchase|non refundable|Non Refundable)") = True Then $g_bIsItADV = True

	$sBookingID = StringRegExp($g_sClipboardWithBookingNumber, "([0-9,B]{8,15})", 1)
	If @error Then Exit MsgBox(0, "Error", "StringRegExp returned error, if 1 then it wasn't able to find booking ID: " & @error)

	PrintOutSiteminderPaperwork()    ;logically if cancellation, then it won't print out the skyware, as the program won't get to this point if it was a cancellation
	If ClipPut($sBookingID[0]) = False Then MsgBox(0, "Error", "Clipboard didn't change")

    Sleep($LOADING_TIME_SLOW_PC_RELATED) ;because it was too fast and ctrl5 was being set to the the wrong window
	SearchByIdOnTheSkyware()

EndFunc   ;==>CopyBookingIDandCheckIfNotCancellation
