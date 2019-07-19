#include-once

Func SafelyCopyHighlightedToClipboard()

	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately
	Send("^c") ;to copy
	Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately

EndFunc   ;==>SafelyCopyHighlightedToClipboard
