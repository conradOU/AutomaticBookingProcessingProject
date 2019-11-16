;~ Posts full amount to speed up deposit taking for prepaid cards (in the morning). Middle click to continue after taking the deposit

#include <misc.au3>

Global $LOADING_TIME_SLOW_PC_RELATED = 700

Opt('WinDetectHiddenText', 1)
Opt('WinTitleMatchMode', 2)

Func _WinWaitActivate($title, $text, $timeout = 0)

	If Not WinActive($title, $text) Then WinActivate($title, $text)
	WinWaitActive($title, $text, $timeout)

EndFunc   ;==>_WinWaitActivate

Func ProcessBooking()

   If WinActive ("Main Folio") <> 0 Then

	  Send("{ENTER}")

;~ 	  MouseClick("left", 704, 576, 1, 0) ;clicks on the payment tab
;~ 	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{CTRLDOWN}f{CTRLUP}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("Payment")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)

	  If @UserName = "User" Then ;if YP PC
		 Local $aCoord = PixelSearch(350, 300, 800, 820, 0x39D77B)
	  ElseIf @UserName = "Ballantrae" Then ;if albany left PC
		 Local $aCoord = PixelSearch(350, 300, 800, 820, 0x38D878)
	  Else
		 MsgBox(0, "", "" & @UserName & " is unsupported")
	  Exit
	  EndIf

	  MouseClick("left", $aCoord[0], $aCoord[1], 1, 0) ;location of the Payment section
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)

	  MouseClick("left", 643, 508, 1, 0) ;clicks on the card long number to uncover

	  Do
		 Sleep(100)
	  Until _IsPressed("04")   ;waits until middle mouse button is pressed

	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  MouseClick("left", 273, 524, 1, 0)	;to unslect middle mouse click, you could also send ESC, works too
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  MouseMove(1095, 270, 0)
	  MouseDown("left")
	  MouseMove(1152, 270, 0)
	  MouseUp("left")

	  Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately
	  Send("^c") ;to copy
	  Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately

	  ClipPut(StringStripWS(ClipGet(), 8))

	  MouseClick("left", 710, 173, 1, 0) ;gold coin
	  Sleep(5000)
	  Send("{ENTER}")

	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  MouseClick("left", 580, 421, 1, 0) ;clicks on the posting type, don't do it by tab as it varies at random between 12 and 13 tabs, independednt of the hotel
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)

	  Send("{DOWN 3}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{ENTER}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{TAB 2}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send(ClipGet())
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  If @UserName = "User" Then ;if YP PC
		 Send("{TAB 5}")
	  ElseIf @UserName = "Ballantrae" Then ;if albany left PC
		 Send("{TAB 6}") ;due to currency option being available at the albant, but not at the yp
	  Else
		 MsgBox(0, "", "" & @UserName & " is unsupported")
	  Exit
	  EndIf

	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{DEL}")          ;to delete highlighted
	  Send("{SPACE}")			;necessary here to fix a bug
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{TAB}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{DEL}")          ;to delete highlighted
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{TAB 2}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{ENTER}")

	  Sleep(5000)

	  Sleep($LOADING_TIME_SLOW_PC_RELATED * 3)
	  Send("{SHIFTDOWN}{TAB 2}{SHIFTUP}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{ENTER}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)

	  Sleep(5000)

	  Send("^w") ;closes the tab and goes back to the tab where you started
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)

	  ProcessBooking()

   EndIf

EndFunc

_WinWaitActivate("Firefox", "")

ProcessBooking()

_WinWaitActivate("Firefox", "")

Sleep($LOADING_TIME_SLOW_PC_RELATED)

Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & "CheckIfBalancedScript.au3" & '"')