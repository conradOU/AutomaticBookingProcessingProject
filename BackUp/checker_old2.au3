;ClipPut(PixelChecksum(48, 416, 139, 436) )
;~    MouseMove(725, 289, 0)
;~    MouseDown("left")
;~    MouseMove(1317, 289, 0)
;~    MouseUp("left")

;~    SafelyCopyHighlightedToClipboard()

;~    $sClipBoard = ClipGet()
;#include <MsgBoxConstants.au3>
#include <EditConstants.au3> ;needed for the button
;#include <GUIConstantsEx.au3>
;#include <StaticConstants.au3>
#include <WindowsConstants.au3> ;needed
#include <ButtonConstants.au3> ;needed for the button

Local $idMsg, $bContinueWithPosting

If g_bIsItForToday = True And $g_bIsItNecessaryToPrintOutSiteminder = False And $g_bWasItSiteminderBooking = False Then
    $amount = ReturnProjectedBalance() ;that covers you for prepaids, except for Siteminder bookings
ElseIf $g_bIsItADV = True Then
    $amount = ReturnProjectedBalance()
Else
    $amount = ReturnRate()
EndIf

GUICreate("", 300, 100, 581, 440)
$idBtnPost = GUICtrlCreateButton("Post: £" & $amount, 1, 1, 100, 100, $BS_DEFPUSHBUTTON)
$idBtnDeclined = GUICtrlCreateButton("DECLINED", 100, 1, 100, 100)
$idBtnCancel = GUICtrlCreateButton("Cancel", 200, 1, 100, 100)
GUISetState()

Do
    $idMsg = GUIGetMsg()
    Switch $idMsg
        Case $idBtnCancel
            $idMsg = $GUI_EVENT_CLOSE
        Case $idBtnDeclined
            MsgBox(514, "Title", "This message box will timeout after 10 seconds or select the OK button." & $bContinueWithPosting, 10)
        Case $idBtnPost
            $idMsg = $GUI_EVENT_CLOSE
            $bContinueWithPosting = True
    EndSwitch
Until $idMsg = $GUI_EVENT_CLOSE

If $bContinueWithPosting = True Then