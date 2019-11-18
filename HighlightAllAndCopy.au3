#include-once

Func HighlightAllAndCopy()

	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("^a") ;to highlight all
	SafelyCopyHighlightedToClipboard()

	$g_sClipboardWithBookingNumber = ClipGet()
	;now check if clipboard is not empty, as that would indicate potential error, be it not loaded page or something else.

	If @error Then ;if clipboard is empty OR contains a non-text entry OR cannot access the clipboard

		HighlightAllAndCopy() ;call itself

	EndIf

EndFunc   ;==>HighlightAllAndCopy
