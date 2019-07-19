#include-once

Func ReturnProjectedBalance()

	Local $Result

	$Result = $g_sSkywareArrivalRateNumberOfRooms
	$Result = StringStripCR(StringReplace($Result, @CRLF, " "))
	$Result = StringReplace($Result, @TAB, "")
	$Result = StringTrimLeft($Result, StringInStr($Result, "Balance:") + 7)
	$Result = StringTrimRight($Result, StringLen($Result) - StringInStr($Result, "Arrive") + 3)
	$Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)

	Return $Result

EndFunc   ;==>ReturnProjectedBalance
