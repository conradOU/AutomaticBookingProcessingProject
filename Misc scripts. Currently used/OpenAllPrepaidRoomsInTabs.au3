#include <GUIConstantsEx.au3>
#include <GuiConstants.au3>
#include <Array.au3>

#AutoIt3Wrapper_Run_Au3Check=N

Global $LOADING_TIME_SLOW_PC_RELATED = 800
Global $array[0]
Global $sRoomChartAddress

Func addVerticalSeparator($iX, $iY, $iH)

	GUICtrlCreateLabel("", $iX, $iY, 1, $iH)
	GUICtrlSetBkColor(-1, 0x999999)

EndFunc   ;==>addVerticalSeparator

Func addHorizontalSeparator($iX, $iY, $iW)

	GUICtrlCreateLabel("", $iX, $iY, $iW, 1)
	GUICtrlSetBkColor(-1, 0x999999)

EndFunc   ;==>addHorizontalSeparator

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

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
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 12)

	For $room = 1 To 42 Step 1
		If $room = 26 Then
			MouseMove(328, 458, 0)
			MouseDown("left")
			MouseMove(328, 800, 0)
			MouseUp("left")   ;for mouse drag as page down didn't work in this case

			If @UserName = "Ballantrae" Then   ;if albany left PC
				$iYcoordinates = 376 - 21 ;logically should work as math adds up, but not tested yet
			ElseIf @UserName = "User" Then    ;if YP PC
				$iYcoordinates = 376 + 210
			EndIf

			Sleep(500)    ;wait for the website to render itself

		EndIf

		If _ArraySearch($array, $room) <> -1 Then  ;if room was selected, then click on it, sleep, then move back to the tab 5
			MouseClick("left", $iXcoordinates, $iYcoordinates, 2, 1)
			Sleep($LOADING_TIME_SLOW_PC_RELATED)
			Send("{CTRLDOWN}5{CTRLUP}")   ;move back to the tab 5 with room chart open
			Sleep($LOADING_TIME_SLOW_PC_RELATED)

		EndIf

		$iYcoordinates += 21   ;checked, that's the correct number

	Next

	Send("{CTRLDOWN}{PGDN}{CTRLUP}") ; {PGUP}
	Sleep($LOADING_TIME_SLOW_PC_RELATED * 4)

	Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & "PostFullAmountForPrepaid.au3" & '"')

EndFunc   ;==>Continue

If @UserName = "Ballantrae" Then ;if albany left PC

	$sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263526354456555942453526584267276460653527252634262526252633303025303232&MenuRowID=19&SKYMENU=CLEAR"

	GUICreate("Rooms to be charged", 600, 475)
	addVerticalSeparator(80, 20, 360)

	For $i = 0 To 3
		GUICtrlCreateLabel($i+1, 20, 30 + 90 * $i, 50, 70, $SS_SUNKEN + $SS_CENTER + $SS_CENTERIMAGE)
		addHorizontalSeparator(20, 20 + 90 * ($i+1), 560)
	Next

	Local $idCheckbox[42]

	For $i = 0 To 6
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i, 80 + 10 + 35 * $i, 30, 35, 70, $BS_PUSHLIKE)
	Next

	For $i = 7 To 16
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i-6, 80 + 10 + 35 * ($i-7), 30 + 90, 35, 70, $BS_PUSHLIKE)
	Next

	For $i = 17 To 29
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i-16, 80 + 10 + 35 * ($i-17), 30 + 90 * 2, 35, 70, $BS_PUSHLIKE)
	Next

	For $i = 30 To 41
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i-29, 80 + 10 + 35 * ($i-30), 30 + 90 * 3, 35, 70, $BS_PUSHLIKE)
	 Next

	Local $idButton_Continue = GUICtrlCreateButton("Continue", 20, 390, 560, 75)

	GUISetState(@SW_SHOW)

	While 1
		Sleep(10)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $idButton_Continue
				GUIDelete()
				Continue()
				Exit
			Case $idCheckbox[0] To $idCheckbox[41]
				For $i = 0 To 41
					If $nMsg = $idCheckbox[$i] Then
						(_IsChecked($idCheckbox[$i])) ? (_ArrayAdd($array, ($i+1))) : (_ArrayDelete($array, _ArraySearch($array, $i+1)))
					EndIf
				 Next

		EndSwitch
	WEnd

ElseIf @UserName = "User" Then                                                                                                                                                             ;if YP PC

	$sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263527354456555942453526584267276460653527252634262526292634252525343032&MenuRowID=19&SKYMENU=CLEAR"

	GUICreate("Rooms to be charged", 775, 385)

	addVerticalSeparator(80, 20, 270)

	For $i = 0 To 2
		GUICtrlCreateLabel($i+1, 20, 30 + 90 * $i, 50, 70, $SS_SUNKEN + $SS_CENTER + $SS_CENTERIMAGE)
		addHorizontalSeparator(20, 20 + 90 * ($i+1), 735)
	Next

	Local $idButton_Continue = GUICtrlCreateButton("Continue", 20, 300, 735, 75)

	Local $idCheckbox[31]

	For $i = 0 To 18
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i+1, 80 + 10 + 35 * $i, 30, 35, 70, $BS_PUSHLIKE)
	Next

	For $i = 19 To 28
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i-19, 80 + 10 + 35 * ($i-19), 30 + 90, 35, 70, $BS_PUSHLIKE)
	Next

	For $i = 29 To 30
		$idCheckbox[$i] = GUICtrlCreateCheckbox($i-29, 80 + 10 + 35 * ($i-29), 30 + 90 * 2, 35, 70, $BS_PUSHLIKE)
	Next

	GUISetState(@SW_SHOW)

	While 1
		Sleep(10)
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				Exit
			Case $idButton_Continue
				GUIDelete()
				Continue()
				Exit
			Case $idCheckbox[0] To $idCheckbox[30]
				For $i = 0 To 30
					If $nMsg = $idCheckbox[$i] Then
						(_IsChecked($idCheckbox[$i])) ? (_ArrayAdd($array, $i+1)) : (_ArrayDelete($array, _ArraySearch($array, $i+1)))
					EndIf
				Next

		EndSwitch
	WEnd

EndIf