#include-once
#include <Date.au3>

Func CheckBookingDate()

	Local $dateFromSkyware, $changeDateFormat, $daysToArrival

	MouseMove(344, 265, 0)
	MouseDown("left")
	MouseMove(1409, 290, 0)
	MouseUp("left")

	SafelyCopyHighlightedToClipboard()
	$g_sSkywareArrivalRateNumberOfRooms = ClipGet()

    $Result = StringTrimLeft($g_sSkywareArrivalRateNumberOfRooms, StringInStr($g_sSkywareArrivalRateNumberOfRooms, " on") + 2)
	$Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)
	$Result = StringLeft($Result, 10)
	$changeDateFormat = StringRight($Result, 4) & "/" & StringMid($Result, 4, 2) & "/" & StringLeft($Result, 2)
	$daysToArrival = _DateDiff("D", _NowCalcDate(), $changeDateFormat) ;YYYY/MM/DD

	If $daysToArrival <= 3 Then
		If $daysToArrival = 0 Then $g_bIsItForToday = True
		PrintoutRegCard()
	EndIf

EndFunc   ;==>CheckBookingDate


