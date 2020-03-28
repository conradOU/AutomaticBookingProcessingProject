#include-once
#include <misc.au3>

Func PrintOutSiteminderPaperwork()


   If @UserName = "User" Then ;if YP PC
	  Local Const $sEmailAddress = "info@ballantraehotel.co.uk"
   ElseIf @UserName = "Ballantrae" Then ;if albany left PC
	  Local Const $sEmailAddress = "info@ballantrae-albanyhotel.co.uk"
   Else
	   MsgBox(0, "", "" & @UserName & " is unsupported")
	   Exit
   EndIf

	If StringRegExp($g_sClipboardWithBookingNumber, "(SiteMinder|Agoda)") = False And _
			StringRegExp($g_sClipboardWithBookingNumber, "(Expedia Collect Booking|virtual credit card)") = False Then

		;steps necessary to printout the siteminder
		$g_bIsItNecessaryToPrintOutSiteminder = True
		_WinWaitActivate("Webmail", "")
		Sleep($LOADING_TIME_SLOW_PC_RELATED * 2) ;necessary here
		MouseClick("left", 1400, 282, 1, 0)
		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		Send("{END}")
		Sleep($LOADING_TIME_SLOW_PC_RELATED)

		MouseClick("left", 873, 742, 1, 0)     ;clicks on the siteminder link, it will automatically open a new tab

		ClipPut($sEmailAddress) ;put the email address into clipboard, to speed up logging into siteminder

		TrayTip("", "Pauses the script until the Ctrl+P is pressed. Takes control from there. Do not close the siteminder tab. If you need to log-in to sitemider - the email address in already in the clipboard", 5)

		Do
			Sleep(100)
		Until _IsPressed("11") And _IsPressed("50")   ;11 for ctrl key and 50 for p key

		WinWaitNotActive("SiteMinder - Mozilla Firefox")

		PrintOut()

		Send("^w")  ;to close siteminder tab

	EndIf

EndFunc   ;==>PrintOutSiteminderPaperwork
