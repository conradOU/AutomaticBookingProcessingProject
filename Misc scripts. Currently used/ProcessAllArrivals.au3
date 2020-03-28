#include <Array.au3>
#include "..\PrintOut.au3"
#include "..\CheckIfPageIsLoaded.au3"
#include "..\SafelyCopyHighlightedToClipboard.au3"
#include "..\Constants.au3"

Global $array[0]
Global $sRoomChartAddress
Global $aGlobalResult[0]
Global $aYProoms[31] = [101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,20,21,22,23,24,25,26,27,28,29,30,31]
Global $aAlbanyRooms[42] = [100,101,102,103,104,105,106,201,202,203,204,205,206,207,208,209,210,301,302,303,304,305,306,307,308,309,310,311,312,313,401,402,403,404,405,406,407,408,409,410,411,412]
Global $bIsScrollDownNecessary = False
Local $aRooms = []

If @UserName = "Ballantrae" Then ;if albany left PC
	$sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263526354456555942453526584267276460653527252634262526252633303025303232&MenuRowID=19&SKYMENU=CLEAR"
	$aRooms = $aAlbanyRooms
Else
    $sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263527354456555942453526584267276460653527252634262526292634252525343032&MenuRowID=19&SKYMENU=CLEAR"
	$aRooms = $aYProoms
EndIf

WinWaitActive("Select Guest to Check-in for: - Mozilla Firefox")
Sleep($LOADING_TIME_SLOW_PC_RELATED) ;it was too fast and clipboard wasn't always changing immediately
Send("^a")
SafelyCopyHighlightedToClipboard()

$g_sRawWebContent = ClipGet()
$aResult = StringSplit($g_sRawWebContent, @CRLF, 1)

$aPreResult = _ArrayFindAll($aResult, '\s0\.00', 0, 0, 0, 3)

For $i = 0 To UBound($aPreResult)-1
   _ArrayAdd($aGlobalResult, $aResult[$aPreResult[$i]])
Next

For $i = 0 To UBound($aGlobalResult)-1
   $aGlobalResult[$i] = StringTrimRight($aGlobalResult[$i], StringLen($aGlobalResult[$i])-StringInStr($aGlobalResult[$i], "Resv") +1)
   $temp = StringRegExp($aGlobalResult[$i], '\s\d{2,3}\s',1)
   If @error Then
	  $temp = StringRegExp($aGlobalResult[$i], '\d{2,3}\s',1)
   EndIf
   $aGlobalResult[$i] = $temp[0]
Next

_ArraySort($aGlobalResult)

Continue()

Func Continue()

	;when clicked on continue button, activiate "Room Chart - Mozilla Firefox"
	;ctrl+l then go to (room chart) "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263526354456555942453526584267276460653527252634262526252633303025303232&MenuRowID=19&SKYMENU=CLEAR"

	Local $iXcoordinates = 382   ;not checked
	Local $iYcoordinates = 267   ;checked

	ClipPut($sRoomChartAddress)

	WinActivate("[TITLE:Select Guest to Check-in for; CLASS:MozillaWindowClass]")
	WinWaitActive("[TITLE:Select Guest to Check-in for; CLASS:MozillaWindowClass]")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{CTRLDOWN}l{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{CTRLDOWN}v{CTRLUP}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	Send("{ENTER}")
	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	CheckIfPageIsLoaded()

	For $room = 1 To 42 Step 1
		If $room = 26 Then

		   	For $roomInnerLoopVariable = 26 To UBound($aRooms) Step 1
			   If _ArraySearch($aGlobalResult, $aRooms[$roomInnerLoopVariable-1]) <> -1 Then  ;if a room is in the list
				  $bIsScrollDownNecessary = True
				  ExitLoop
			   EndIf
			Next

			if $bIsScrollDownNecessary = False Then ExitLoop ;that would exit the For loop, and continue with statements outside the For loop

			MouseMove(328, 458, 0)
			MouseDown("left")
			MouseMove(328, 800, 0)
			MouseUp("left")   ;for mouse drag as page down didn't work in this case

			If @UserName = "Ballantrae" Then   ;if albany left PC
				$iYcoordinates = 376 - 21 ;logically should work as math adds up, but not tested yet
			ElseIf @UserName = "User" Then    ;if YP PC
				$iYcoordinates = 376 + 210
			EndIf

			Sleep($LOADING_TIME_SLOW_PC_RELATED)    ;wait for the website to render itself

		EndIf

		If _ArraySearch($aGlobalResult, $aRooms[$room-1]) <> -1 Then  ;if room was selected, then click on it, sleep, then move back to the tab 5
		   MouseClick("left", $iXcoordinates, $iYcoordinates, 2, 1)
		   Sleep($LOADING_TIME_SLOW_PC_RELATED*4.5) ;just one here wasn't enough
		   Send("{CTRLDOWN}5{CTRLUP}")   ;move back to the tab 5 with room chart open
		   Sleep($LOADING_TIME_SLOW_PC_RELATED*3)
		EndIf


	    If @UserName = "User" AND $room = 31 Then   ;if YP PC
			ExitLoop   ;$room = 43; ExitLoop didn't work, hence another way to stop the loop
	    EndIf

		$iYcoordinates += 21   ;checked, that's the correct number

	Next

	Send("{CTRLDOWN}{PGDN}{CTRLUP}") ; {PGUP}
;~ 	Sleep($LOADING_TIME_SLOW_PC_RELATED)
	CheckIfPageIsLoaded()

	Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & "PostFullAmountForPrepaid.au3" & '"')

EndFunc   ;==>Continue