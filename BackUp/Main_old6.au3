#comments-start
Author
   Conrad R
-----
What the test should do
   Prints paperwork including siteminder and tries to assign the room.
   This script will still print out canceled booking, which is how the script is supposed to behave.
-----
Parameters
   Input: currently none
#comments-end

#include <AutoItConstants.au3>
#include "PrintOutSiteminderPaperwork.au3"
#include "CopyBookingIDandCheckIfNotCancellation.au3"
#include "SearchByIdOnTheSkyware.au3"
#include "TryToAssignRoom.au3"
#include "SafelyCopyHighlightedToClipboard.au3"
#include "PostPaymentOnSkyware.au3"
#include "EmailDeclainedBookingToLen.au3"
#include "CheckBookingDate.au3"
#include "PrintoutRegCard.au3"
#include "QuantityOfRooms.au3"
#include "CheckBookingDate.au3"
#include "ReturnProjectedBalance.au3"
#include "ReturnRate.au3"


#Region --- Global variables Start ---
Global $g_bIsItNecessaryToPrintOutSiteminder, $g_bWasItSiteminderBooking, $g_bIsItForToday, $g_bIsItADV = False
Global $g_sClipboardWithBookingNumber, $g_sSkywareArrivalRateNumberOfRooms = ""
Global Const $LOADING_TIME_SLOW_PC_RELATED = 600 ;don't go lower than that

#Region --- YP PC variables ---
;~ Global Const $g_iCheckSumSkywareIcon = 3487089813 ;YP PC
;~ Global Const $g_iSiteminderWaitCheck = 1712426405 ;yp PC
;~ Global Const $g_iSkywareSuccessfulRoomAllocation = 1520580581 ;albany left PC and YP PC
#EndRegion --- YP PC variables ---

#Region --- Albany left PC variables ---
Global Const $g_iCheckSumSkywareIcon = 2675949942 ;albany left PC
Global Const $g_iSiteminderWaitCheck = 1251178366 ;albany left PC
Global Const $g_iSkywareSuccessfulRoomAllocation = 1520580581 ;albany left PC and YP PC
#EndRegion --- Albany left PC variables ---

#Region --- Albany right PC variables ---
;~ Global Const $g_iCheckSumSkywareIcon = 1948833437 ;albany right PC
;~ Global Const $g_iSiteminderWaitCheck = 1948833437 ;albany right PC
;~ Global Const $g_iSkywareSuccessfulRoomAllocation = 1948833437 ;albany right PC
#EndRegion --- Albany right PC variables ---

Global Enum $firstParam, $secondParam, $thirdParam, $fourthParam
Global $g_aSkywareIconLocation[4] = [527, 9, 548, 18] ;to-do use multidimensional array with enum, one for PixelChecksum and another one for MouseClicks
#EndRegion --- Global variables Start ---

#Region --- Internal functions Au3Recorder Start ---
Func _Au3RecordSetup()

	Opt('WinWaitDelay', 100)
	Opt('WinDetectHiddenText', 1)

EndFunc   ;==>_Au3RecordSetup

Func _WinWaitActivate($title, $text, $timeout = 0)

	;WinWait($title,$text,$timeout) ;waiting for a window to even exist in the first place
	If Not WinActive($title, $text) Then WinActivate($title, $text)
	WinWaitActive($title, $text, $timeout)

EndFunc   ;==>_WinWaitActivate
#EndRegion --- Internal functions Au3Recorder Start ---

_Au3RecordSetup()
MouseClick("left", 501, 150, 1, 0) ;clicks on the print button
_WinWaitActivate("Print", "") ;that window name is always correct, at both hotels
Sleep($LOADING_TIME_SLOW_PC_RELATED) ;necessary
MouseClick("left", 489, 412, 1, 0)
Sleep($LOADING_TIME_SLOW_PC_RELATED)
MouseClick("left", 765, 482, 1, 0)
Sleep($LOADING_TIME_SLOW_PC_RELATED * 4)

CopyBookingIDandCheckIfNotCancellation()


#cs archive/change log

WinClose("[CLASS:MozillaWindowClass; REGEXPTITLE:^(?!.*Webmail).*$, "") ;regex works, but function doesn't

https://www.autoitscript.com/autoit3/docs/keywords/Switch.htm

TO DO:
   -multidiamensional array with all the variables - but for what variables... for mouseclicks it doesn't make sense, and other pixelchecksum are very rare and doesn't make sense to make it as global variables
   -proper scr bin folder structure
		maybe add Include folder for functions
   -do printout card details if that lock button doesn't exist
   -have the rate per night; date of arrival and number of rooms copied just from one select...,
		 you can get number of rooms from what you alredy have, now work on everything else
		 date of arrival:
			   $Result = StringTrimLeft($sClipBoard, StringInStr($sClipBoard, "on") +1)
			   $Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)
			   $Result = StringLeft($Result, 10)
		 Rate per night:
			   $Result = StringTrimLeft($sClipBoard, StringInStr($sClipBoard, "Rate") +3)
			   $Result = StringTrimRight($Result, StringInStr($Result, "Rooms"))
			   $Result = StringTrimRight($Result, StringInStr($Result, "Room")-1)
			   $Result = StringReplace ($Result, "*", " ")
			   $Result = StringStripWS($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)
   -posting the payment
	  ask if the payment went thru or was declined
		 if declined have it open the draft to len and fill it in
	-check that stuff in try to assign room, there is only sleep without enter, maybe enter would be needed in case of a pop up, if yes then modify that + EmailDeclinedBooking toLen
#ce archive/change log
