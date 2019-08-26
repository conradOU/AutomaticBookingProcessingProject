#include-once

Func AddPrepaidCommentOnSkyware()

	Send("{CTRLDOWN}f{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("**Comments**")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)

	Local $aCoord = PixelSearch(350, 300, 800, 820, $g_sGreenColour) ;searches for the highlighted green, Albany
	MouseClick("left", $aCoord[0], $aCoord[1], 1, 0) ;location of the comment section
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{TAB}") ;to enter comment section
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("PREPAID{Enter}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	MouseClick("left", 416, 172, 1, 0) ; location of save button.
    Sleep($LOADING_TIME_SLOW_PC_RELATED)

	; there is no pop up after saving
	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])
		Sleep(100)
	WEnd

EndFunc