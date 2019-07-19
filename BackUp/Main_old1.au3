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

#Region --- Global variables Start ---
Global $g_bIsItNecessaryToPrintOutSiteminder, $g_bWasItSiteminderBooking = False
Global $g_sClipboardWithBookingNumber = ""
Global Const $LOADING_TIME_SLOW_PC_RELATED = 600 ;don't go lower than that

#Region
Global Const $g_iCheckSumSkywareIcon = 3487089813 ;YP PC
Global Const $g_iSiteminderWaitCheck = 1712426405 ;yp PC
Global Const $g_iSkywareSuccessfulRoomAllocation = 1520580581 ;albany left PC and YP PC
#EndRegion

#Region
;Global Const $g_iCheckSumSkywareIcon = 2675949942 ;albany left PC
;Global Const $g_iSiteminderWaitCheck = 297160731 ;albany left PC
;Global Const $g_iSkywareSuccessfulRoomAllocation = 1520580581 ;albany left PC and YP PC
#EndRegion

#Region
;Global Const $g_iCheckSumSkywareIcon = 1948833437 ;albany right PC
;Global Const $g_iSiteminderWaitCheck = 1948833437 ;albany right PC
;Global Const $g_iSkywareSuccessfulRoomAllocation = 1948833437 ;albany right PC
#EndRegion

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
Sleep($LOADING_TIME_SLOW_PC_RELATED*4)

CopyBookingIDandCheckIfNotCancellation()


#cs archive/change log
;WinClose("[CLASS:MozillaWindowClass; REGEXPTITLE:^(?!.*Webmail).*$, "") ;regex works, but function doesn't
840,185 agoda(cancelations too), expedia(cancelations too) and booking.com(NOT cancelations), siteminder bookings (979, 184), if Cancelation, then don't copy the text to the clipboard. You can remmove anything but numbers
;https://www.autoitscript.com/autoit3/docs/keywords/Switch.htm use it for expression when searching for booking number
TO DO:
   -if it's for the next three days, then print out reg card
	  decide if it's necessary to print out reg card, on the Skyware, date has format: Arrive on 11-07-2019, Thu to 12-07-2019, Fri for 1 night(s). You could search that with regex or click+ctlr+shift then arrow
	  ([0-9]{2,4}), then you'll have day in arr[0], month in [1], year in arr[2], do enum on that
   -if
   -multidiamensional array with all the variables
   -proper scr bin folder structure
		maybe add Include folder for functions
   -do printout card details if that lock button doesn't exist
   -make it look nice as in variables for different hotels to be together in a block or something, so that it's fast just to toggle that before compiling
   -improve searching for number of rooms.
	  Format: 	Confirmation #:  1284640916 	Status 		Folio Name 		 	Projected Balance: 0.00
 	Arrive on 02-07-2019, Tue to 04-07-2019, Thu for 2 night(s). 	 	Rate 	 	138.60 	 	Room Type 	SUPDBL 	 	Rooms 	1 	 	Room # 	 	101
	  -([0-9]{1,}) then it would be the last number, assuming the room is not yet assigned
   -posting the payment
	  ask if the payment went thru or was declined
		 if declined have it open the draft to len and fill it in

#ce archive/change log
