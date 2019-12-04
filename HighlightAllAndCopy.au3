#include-once

Func HighlightAllAndCopy()

	Local $sPreviousClipboard = ClipGet()
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("^a") ;to highlight all
	SafelyCopyHighlightedToClipboard()

	$g_sClipboardWithBookingNumber = ClipGet()
	;now check if clipboard is not empty, as that would indicate potential error, be it not loaded page or something else.

	If Not StringRegExp($g_sClipboardWithBookingNumber, "(Sent)") Then  ;if it doesn't contain "Sent", which would normally be in the email header

		HighlightAllAndCopy() ;call itself

	EndIf


	If @error Or $sPreviousClipboard == $g_sClipboardWithBookingNumber Then     ;if clipboard is empty OR contains a non-text entry OR cannot access the clipboard

		HighlightAllAndCopy()     ;call itself

	EndIf

EndFunc   ;==>HighlightAllAndCopy

