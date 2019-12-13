#include <AutoItConstants.au3>
#include <WindowsConstants.au3>;needed
#include <ButtonConstants.au3>;needed For the button#include<EditConstants.au3>;needed For the buttonLocal $idMsg, $bContinueWithPosting
#include <EditConstants.au3>;needed For the button
#include <GUIConstantsEx.au3>
#include "..\PrintOut.au3"
#include "..\_WinWaitActivate.au3"

Global Const $LOADING_TIME_SLOW_PC_RELATED = 800 ;don't go lower than that
Local $fTotal, $fCashTotal, $fXread
Local $bSetPrint = False

Opt('WinDetectHiddenText', 1)
Opt('WinTitleMatchMode', 2)

_WinWaitActivate("Mozilla Firefox","")

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

;;;;;;;;;;;;;;;;
GUICreate("", 200, 100, 581, 440)
$idBtnBalance = GUICtrlCreateButton("X totals: £" & $fXread, 1, 1, 100, 100)
$idBtnPrint = GUICtrlCreateButton("PRINT", 100, 1, 100, 100, $BS_DEFPUSHBUTTON)
GUISetState()

While 1
   $idMsg = GUIGetMsg()
	  Switch $idMsg
		 Case $GUI_EVENT_CLOSE
			ExitLoop ;clould be ExitLoop but since you there will be no more steps, you can just exit the program
		 Case $idBtnBalance
			ExitLoop ;clould be ExitLoop but since you there will be no more steps, you can just exit the program
		 Case $idBtnPrint
			$bSetPrint = True
			ExitLoop
	EndSwitch
WEnd

GUIDelete() ;this part is important

If $bSetPrint Then
   _WinWaitActivate("Skyware Report","")
   PrintOut()
EndIf
