#include <AutoItConstants.au3>

Global Const $LOADING_TIME_SLOW_PC_RELATED = 600 ;don't go lower than that
Local $fTotal, $fCashTotal, $fXread

If @UserName = "User" Then ;if YP PC
	Local Const $iPixelChecksum = 116970486
	Local Const $iCashYcoordinate = 302
	MouseClick("left", 1209, 45, 1, 10)
ElseIf @UserName = "Ballantrae" Then ;if albany left PC
	Local Const $iPixelChecksum = 3388790433
	Local Const $iCashYcoordinate = 329
	MouseClick("left", 902, 47, 1, 10)
Else
	MsgBox(0, "", "" & @UserName & " is unsupported")
	Exit
EndIf

While $iPixelChecksum <> PixelChecksum(527, 11, 548, 18) ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
	Sleep(100)
WEnd

Sleep($LOADING_TIME_SLOW_PC_RELATED)
Send("{END}")
Sleep($LOADING_TIME_SLOW_PC_RELATED)
MouseClick("left", 1175, 283, 3, 0) ;common for both hotels. Copies totals
Send("^c") ;to copy
Sleep($LOADING_TIME_SLOW_PC_RELATED)
$fTotal = ClipGet()
$fTotal = StringReplace($fTotal, ",", "")
Send("{PGUP}")
Sleep($LOADING_TIME_SLOW_PC_RELATED)
MouseClick("left", 1170, $iCashYcoordinate, 3, 0)
Send("^c") ;to copy
Sleep($LOADING_TIME_SLOW_PC_RELATED)
$fCashTotal = ClipGet()
$fCashTotal = StringReplace($fCashTotal, ",", "")
$fXread = $fTotal - $fCashTotal
MsgBox(0, "", "" & $fXread)
