#include-once
#include <WindowsConstants.au3>;needed
#include <ButtonConstants.au3>;needed For the button#include<EditConstants.au3>;needed For the buttonLocal $idMsg, $bContinueWithPosting
#include <EditConstants.au3>;needed For the button
#include <GUIConstantsEx.au3>

Func CheckIfDeclinedOrPaid()

	Local $bContinueWithPosting, $bIsDeclined, $amount = False

	If $g_bIsItForToday And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
		$amount = ReturnProjectedBalance() ;that covers you for prepaids, except for Siteminder bookings
	ElseIf $g_bIsItADV Then
		$amount = ReturnProjectedBalance()
	Else
		$amount = ReturnRate()
	EndIf

	GUICreate("", 200, 100, 581, 440)
	$idBtnPost = GUICtrlCreateButton("Post: £" & $amount, 1, 1, 100, 100, $BS_DEFPUSHBUTTON)
	$idBtnDeclined = GUICtrlCreateButton("DECLINED", 100, 1, 100, 100)
	GUISetState()

	While 1
		$idMsg = GUIGetMsg()
		Switch $idMsg
			Case $GUI_EVENT_CLOSE
				Exit ;clould be ExitLoop but since you there will be no more steps, you can just exit the program
			Case $idBtnPost
				$bContinueWithPosting = True
				ExitLoop
			Case $idBtnDeclined
				$bIsDeclined = True
				ExitLoop
		EndSwitch
	WEnd

	GUIDelete() ;this part is important

	Sleep(3000)

	If $bIsDeclined Then EmailDeclainedBookingToLen()

	If $bContinueWithPosting Then PostPaymentOnSkyware($amount)

EndFunc   ;==>CheckIfDeclinedOrPaid
