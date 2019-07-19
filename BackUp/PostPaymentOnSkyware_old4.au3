#include-once
#include <WindowsConstants.au3>;needed
#include <ButtonConstants.au3>;needed For the button#include<EditConstants.au3>;needed For the buttonLocal $idMsg, $bContinueWithPosting
#include <EditConstants.au3>;needed For the button
#include <GUIConstantsEx.au3>

Func PostPaymentOnSkyware()

	Local $bContinueWithPosting, $bIsDeclined = False

	If $g_bIsItForToday = True And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
		$amount = ReturnProjectedBalance() ;that covers you for prepaids, except for Siteminder bookings
	ElseIf $g_bIsItADV = True Then
		$amount = ReturnProjectedBalance()
	Else
		$amount = ReturnRate()
	EndIf

	GUICreate("", 200, 100, 581, 440)
	$idBtnPost = GUICtrlCreateButton("Post: £" & $amount, 1, 1, 100, 100) ;$BS_DEFPUSHBUTTON
	$idBtnDeclined = GUICtrlCreateButton("DECLINED", 100, 1, 100, 100)
	;$idBtnCancel = GUICtrlCreateButton("Cancel", 200, 1, 100, 100)
	GUISetState()

	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $GUI_EVENT_CLOSE
			   Exit
			Case $idBtnPost
			   ExitLoop
			   JustPosting($amount)
	;		  Exit
			   ;$idMsg = $GUI_EVENT_CLOSE
			Case $idBtnDeclined
			   Sleep(3000)
			   EmailDeclainedBookingToLen()
;			   Exit
			   ;	$idMsg = $GUI_EVENT_CLOSE
		EndSwitch
	 WEnd


   Sleep(600)

	;If $bContinueWithPosting = True Then


	;If $bIsDeclined = True Then EmailDeclainedBookingToLen()

EndFunc   ;==>PostPaymentOnSkyware

