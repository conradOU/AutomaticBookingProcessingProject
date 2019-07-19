#include-once

Func ReturnRate()

	Local $Result

	$Result = $g_sSkywareArrivalRateNumberOfRooms
	$Result = StringTrimLeft($g_sSkywareArrivalRateNumberOfRooms, StringInStr($g_sSkywareArrivalRateNumberOfRooms, "Rate") +3)
	$Result = StringTrimRight($Result, StringLen($Result) - StringInStr($Result, "Rooms"))
	$Result = StringTrimRight($Result, StringLen($Result) - StringInStr($Result, "Room")+1)
	$Result = StringReplace ($Result, "*", " ")
	$Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)

	Return $Result

EndFunc