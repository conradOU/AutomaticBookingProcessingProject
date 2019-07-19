#include-once

Func QuantityOfRooms()

	Local $Result

	$Result = StringTrimLeft($g_sSkywareArrivalRateNumberOfRooms, StringInStr($g_sSkywareArrivalRateNumberOfRooms, "Rooms") + 4)
	$Result = StringTrimRight($Result, StringInStr($Result, "#") + 1)
	$Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)

	Return $Result

EndFunc   ;==>QuantityOfRooms