#include-once
#include <misc.au3>

Func PrintOutSiteminderPaperwork()

	If StringRegExp($g_sClipboardWithBookingNumber, "(SiteMinder|Agoda)") = False And _
			StringRegExp($g_sClipboardWithBookingNumber, "(Expedia Collect Booking|virtual credit card)") = False Then

		;steps necessary to printout the siteminder
		$g_bIsItNecessaryToPrintOutSiteminder = True
		_WinWaitActivate("Webmail", "")
		Sleep($LOADING_TIME_SLOW_PC_RELATED * 2) ;necessary here
		Send("{END}")
		Sleep($LOADING_TIME_SLOW_PC_RELATED)

		MouseClick("left", 873, 742, 1, 0)     ;clicks on the siteminder link, it will automatically open a new tab

;~ 		While $g_iSiteminderWaitCheck <> PixelChecksum(48, 416, 139, 436)     ;change it while it's not equal to preset number, sleep, then carry on with execution as it should
;~ 			Sleep(100)
;~ 		WEnd

;~ 		Sleep($LOADING_TIME_SLOW_PC_RELATED*2)     ;not really slow PC related, but the website is slow to load
;~ 		MouseClick("left", 92, 465, 1, 0)     ;clicks on the reservation ID
;~ 		Sleep($LOADING_TIME_SLOW_PC_RELATED)     ;with pixel check it's possible now to fully automate that, including printing and then closing the tab

;~ 		;needs checking if siteminder is protected by pswd or not, if not, the printit out and close the tab
;~ 		Send("{CTRLDOWN}{SHIFTDOWN}{PGDN}{SHIFTUP}{CTRLUP}")     ;move this tab to the right
;~ 		Sleep($LOADING_TIME_SLOW_PC_RELATED)
;~ 		;some sleep time, then send ctrl+p to and then enter to print. That's only assuming you don't need to get the security key and that you're logged it.
;~ 		;after printing close the tab
		;^above commented section doesn't work, because they change layout of that website way too often
		MsgBox(0, "", "Pauses the script until the Ctrl+P is pressed. Takes control from there. Do not close the siteminder tab.")
		Do
			Sleep(100)
		Until _IsPressed("11") And _IsPressed("50")   ;11 for ctrl key and 50 for p key
		WinWaitNotActive("SiteMinder - Mozilla Firefox")
		ControlClick("Print", "", "[CLASS:Button; INSTANCE:6]")

		Sleep($LOADING_TIME_SLOW_PC_RELATED)
		Send("{ENTER}")
		WinWaitNotActive("Print")
		WinWaitNotActive("Printing")

		Send("^w")  ;to close siteminder tab

	EndIf

EndFunc   ;==>PrintOutSiteminderPaperwork
