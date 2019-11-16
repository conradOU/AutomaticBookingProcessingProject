#include-once

Func SafelyCopyHighlightedToClipboard()

	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately
	Send("^c") ;to copy
	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately

	;now check if clipboard is not empty, as that would indicate potential error, be it not loaded page or something else.

	ClipGet()
	If @error Then ;if clipboard is empty OR contains a non-text entry OR cannot access the clipboard
		SafelyCopyHighlightedToClipboard()
	EndIf

EndFunc   ;==>SafelyCopyHighlightedToClipboard
