Global Const $LOADING_TIME_SLOW_PC_RELATED = 600 ;don't go lower than that

Global Enum $firstParam, $secondParam, $thirdParam, $fourthParam
Global $g_aSkywareIconLocation[4] = [527, 9, 548, 18] ;to-do use multidimensional array with enum, one for PixelChecksum and another one for MouseClicks

Func _WinWaitActivate($title, $text, $timeout = 0)

	;WinWait($title,$text,$timeout) ;waiting for a window to even exist in the first place
	If Not WinActive($title, $text) Then WinActivate($title, $text)
	WinWaitActive($title, $text, $timeout)

EndFunc   ;==>_WinWaitActivate

Global Const $g_iCheckSumSkywareIcon = 2675949942 ;albany left PC
Local $iCheckSumRegCard = 1542064209

Send("{ENTER}")
Sleep($LOADING_TIME_SLOW_PC_RELATED)

While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])     ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
	Sleep(100)
WEnd

MouseClick("left", 679, 341, 1, 0)     ;accesses the booking
Sleep($LOADING_TIME_SLOW_PC_RELATED)

While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam])     ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
	Send("{ENTER}")     ;in case if there are any pop-ups, if there are none that enter doesn't do "harm"
	Sleep(100)
WEnd

MouseClick("left", 462, 173, 1, 0)     ;you can change it to 4 tabs and enter
_WinWaitActivate("Select Document to Print or E-Mail", "")     ;that window name is always correct, at both hotels
Sleep($LOADING_TIME_SLOW_PC_RELATED)
Send("{TAB 6}{ENTER}")     ;more accurate than clicking

While $iCheckSumRegCard <> PixelChecksum(463, 122, 499, 176)     ;tested on the left PC at the Albany
	Sleep(100)
WEnd

Sleep($LOADING_TIME_SLOW_PC_RELATED)
Send("^p")     ;to print
_WinWaitActivate("Print", "")
Sleep($LOADING_TIME_SLOW_PC_RELATED * 2)
ControlClick("Print", "", "[CLASS:Button; INSTANCE:6]")

Sleep($LOADING_TIME_SLOW_PC_RELATED)
Send("{ENTER}")
Sleep($LOADING_TIME_SLOW_PC_RELATED * 5)

Send("^w")     ;closes the tab and goes back to the tab where you started
;~ 	Sleep($LOADING_TIME_SLOW_PC_RELATED)

;~ 	While $g_iCheckSumSkywareIcon <> PixelChecksum($g_aSkywareIconLocation[$firstParam], $g_aSkywareIconLocation[$secondParam], $g_aSkywareIconLocation[$thirdParam], $g_aSkywareIconLocation[$fourthParam]) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
;~ 		Sleep(100)
;~ 	WEnd


