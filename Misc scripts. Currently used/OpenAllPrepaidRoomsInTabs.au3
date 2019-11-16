#include <GUIConstantsEx.au3>
#include <GuiConstants.au3>
#include <Array.au3>

Global $LOADING_TIME_SLOW_PC_RELATED = 800
Global $array[0]
Global $sRoomChartAddress

Func addVerticalSeparator($iX, $iY, $iH)

    GUICtrlCreateLabel("", $iX, $iY, 1, $iH)
    GUICtrlSetBkColor(-1, 0x999999)

EndFunc

Func addHorizontalSeparator($iX, $iY, $iW)

	GUICtrlCreateLabel("", $iX, $iY, $iW, 1)
	GUICtrlSetBkColor(-1, 0x999999)

EndFunc

Func _IsChecked($idControlID)
   Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

Func Continue()

	  ;when clicked on continue button, activiate "Room Chart - Mozilla Firefox"
	  ;ctrl+l then go to (room chart) "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263526354456555942453526584267276460653527252634262526252633303025303232&MenuRowID=19&SKYMENU=CLEAR"

	  Local $iXcoordinates = 382 ;not checked
	  Local $iYcoordinates = 267 ;checked

	  ClipPut($sRoomChartAddress)

	  WinActivate("[TITLE:Select Guest to Check-in for; CLASS:MozillaWindowClass]")
	  WinWaitActive("[TITLE:Select Guest to Check-in for; CLASS:MozillaWindowClass]")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{CTRLDOWN}l{CTRLUP}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{CTRLDOWN}v{CTRLUP}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED)
	  Send("{ENTER}")
	  Sleep($LOADING_TIME_SLOW_PC_RELATED*12)

	  For $room = 1 To 42 Step 1
		  If $room = 26 Then
			  MouseMove(328, 458, 0)
			  MouseDown("left")
			  MouseMove(328, 800, 0)
			  MouseUp("left") ;for mouse drag as page down didn't work in this case

			  If @UserName = "Ballantrae" Then ;if albany left PC
				  $iYcoordinates = 376-21 ;logically should work as math adds up, but not tested yet
			   ElseIf @UserName = "User" Then ;if YP PC
				  $iYcoordinates = 376+210
			   EndIf

			   Sleep(500) ;wait for the website to render itself

		  EndIf

		  If _ArraySearch($array, $room) <> -1 Then;if room was selected, then click on it, sleep, then move back to the tab 5
			  MouseClick("left", $iXcoordinates, $iYcoordinates, 2, 1)
			  Sleep($LOADING_TIME_SLOW_PC_RELATED)
			  Send("{CTRLDOWN}5{CTRLUP}") ;move back to the tab 5 with room chart open
			  Sleep($LOADING_TIME_SLOW_PC_RELATED)

		  EndIf

		  $iYcoordinates += 21 ;checked, that's the correct number

  Next

  Send("{CTRLDOWN}{PGDN}{CTRLUP}") ; {PGUP}
  Sleep($LOADING_TIME_SLOW_PC_RELATED*4)

  Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & "PostFullAmountForPrepaid.au3" & '"')

EndFunc

If @UserName = "Ballantrae" Then ;if albany left PC

   $sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263526354456555942453526584267276460653527252634262526252633303025303232&MenuRowID=19&SKYMENU=CLEAR"

   GUICreate("Rooms to be charged", 600, 475)
   addVerticalSeparator(80, 20, 360)
   addHorizontalSeparator(20, 20+90, 560)
   addHorizontalSeparator(20, 20+90*2, 560)
   addHorizontalSeparator(20, 20+90*3, 560)
   addHorizontalSeparator(20, 20+90*4, 560)
   GUICtrlCreateLabel("1", 20, 30, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   GUICtrlCreateLabel("2", 20, 30+90, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   GUICtrlCreateLabel("3", 20, 30+90*2, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   GUICtrlCreateLabel("4", 20, 30+90*3, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)

   Local $idCheckbox100 = GUICtrlCreateCheckbox("0", 80+10, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox101 = GUICtrlCreateCheckbox("1", 80+10+35, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox102 = GUICtrlCreateCheckbox("2", 80+10+35*2, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox103 = GUICtrlCreateCheckbox("3", 80+10+35*3, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox104 = GUICtrlCreateCheckbox("4", 80+10+35*4, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox105 = GUICtrlCreateCheckbox("5", 80+10+35*5, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox106 = GUICtrlCreateCheckbox("6", 80+10+35*6, 30, 35, 70, $BS_PUSHLIKE)

   Local $idCheckbox201 = GUICtrlCreateCheckbox("1", 80+10, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox202 = GUICtrlCreateCheckbox("2", 80+10+35, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox203 = GUICtrlCreateCheckbox("3", 80+10+35*2, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox204 = GUICtrlCreateCheckbox("4", 80+10+35*3, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox205 = GUICtrlCreateCheckbox("5", 80+10+35*4, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox206 = GUICtrlCreateCheckbox("6", 80+10+35*5, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox207 = GUICtrlCreateCheckbox("7", 80+10+35*6, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox208 = GUICtrlCreateCheckbox("8", 80+10+35*7, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox209 = GUICtrlCreateCheckbox("9", 80+10+35*8, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox210 = GUICtrlCreateCheckbox("10", 80+10+35*9, 30+90, 35, 70, $BS_PUSHLIKE)

   Local $idCheckbox301 = GUICtrlCreateCheckbox("1", 80+10, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox302 = GUICtrlCreateCheckbox("2", 80+10+35, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox303 = GUICtrlCreateCheckbox("3", 80+10+35*2, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox304 = GUICtrlCreateCheckbox("4", 80+10+35*3, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox305 = GUICtrlCreateCheckbox("5", 80+10+35*4, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox306 = GUICtrlCreateCheckbox("6", 80+10+35*5, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox307 = GUICtrlCreateCheckbox("7", 80+10+35*6, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox308 = GUICtrlCreateCheckbox("8", 80+10+35*7, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox309 = GUICtrlCreateCheckbox("9", 80+10+35*8, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox310 = GUICtrlCreateCheckbox("10", 80+10+35*9, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox311 = GUICtrlCreateCheckbox("11", 80+10+35*10, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox312 = GUICtrlCreateCheckbox("12", 80+10+35*11, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox313 = GUICtrlCreateCheckbox("13", 80+10+35*12, 30+90*2, 35, 70, $BS_PUSHLIKE)

   Local $idCheckbox401 = GUICtrlCreateCheckbox("1", 80+10, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox402 = GUICtrlCreateCheckbox("2", 80+10+35, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox403 = GUICtrlCreateCheckbox("3", 80+10+35*2, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox404 = GUICtrlCreateCheckbox("4", 80+10+35*3, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox405 = GUICtrlCreateCheckbox("5", 80+10+35*4, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox406 = GUICtrlCreateCheckbox("6", 80+10+35*5, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox407 = GUICtrlCreateCheckbox("7", 80+10+35*6, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox408 = GUICtrlCreateCheckbox("8", 80+10+35*7, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox409 = GUICtrlCreateCheckbox("9", 80+10+35*8, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox410 = GUICtrlCreateCheckbox("10", 80+10+35*9, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox411 = GUICtrlCreateCheckbox("11", 80+10+35*10, 30+90*3, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox412 = GUICtrlCreateCheckbox("12", 80+10+35*11, 30+90*3, 35, 70, $BS_PUSHLIKE)

   Local $idButton_Continue = GUICtrlCreateButton("Continue", 20, 390, 560, 75)

   GUISetState(@SW_SHOW)

   While 1
	   Sleep(10)
	   Switch GUIGetMsg()
		   Case $GUI_EVENT_CLOSE
			   Exit
		   Case $idButton_Continue
			   GUIDelete()
			   Continue()
			   Exit
			Case $idCheckbox100
			   If _IsChecked($idCheckbox100) Then
				   _ArrayAdd($array, 1)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 1))
			   EndIf
			Case $idCheckbox101
			   If _IsChecked($idCheckbox101) Then
				   _ArrayAdd($array, 2)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 2))
			   EndIf
			Case $idCheckbox102
			   If _IsChecked($idCheckbox102) Then
				   _ArrayAdd($array, 3)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 3))
			   EndIf
			Case $idCheckbox103
			   If _IsChecked($idCheckbox103) Then
				   _ArrayAdd($array, 4)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 4))
			   EndIf
			Case $idCheckbox104
			   If _IsChecked($idCheckbox104) Then
				   _ArrayAdd($array, 5)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 5))
			   EndIf
			Case $idCheckbox105
			   If _IsChecked($idCheckbox105) Then
				   _ArrayAdd($array, 6)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 6))
			   EndIf
			Case $idCheckbox106
			   If _IsChecked($idCheckbox106) Then
				   _ArrayAdd($array, 7)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 7))
			   EndIf
			   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			Case $idCheckbox201
			   If _IsChecked($idCheckbox201) Then
				   _ArrayAdd($array, 8)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 8))
			   EndIf
			Case $idCheckbox202
			   If _IsChecked($idCheckbox202) Then
				   _ArrayAdd($array, 9)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 9))
			   EndIf
			Case $idCheckbox203
			   If _IsChecked($idCheckbox203) Then
				   _ArrayAdd($array, 10)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 10))
			   EndIf
			Case $idCheckbox204
			   If _IsChecked($idCheckbox204) Then
				   _ArrayAdd($array, 11)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 11))
			   EndIf
			Case $idCheckbox205
			   If _IsChecked($idCheckbox205) Then
				   _ArrayAdd($array, 12)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 12))
			   EndIf
			Case $idCheckbox206
			   If _IsChecked($idCheckbox206) Then
				   _ArrayAdd($array, 13)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 13))
			   EndIf
			Case $idCheckbox207
			   If _IsChecked($idCheckbox207) Then
				   _ArrayAdd($array, 14)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 14))
			   EndIf
			Case $idCheckbox208
			   If _IsChecked($idCheckbox208) Then
				   _ArrayAdd($array, 15)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 15))
			   EndIf
			Case $idCheckbox209
			   If _IsChecked($idCheckbox209) Then
				   _ArrayAdd($array, 16)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 16))
			   EndIf
			Case $idCheckbox210
			   If _IsChecked($idCheckbox210) Then
				   _ArrayAdd($array, 17)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 17))
			   EndIf
			   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			Case $idCheckbox301
			   If _IsChecked($idCheckbox301) Then
				   _ArrayAdd($array, 18)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 18))
			   EndIf
			Case $idCheckbox302
			   If _IsChecked($idCheckbox302) Then
				   _ArrayAdd($array, 19)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 19))
			   EndIf
			Case $idCheckbox303
			   If _IsChecked($idCheckbox303) Then
				   _ArrayAdd($array, 20)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 20))
			   EndIf
			Case $idCheckbox304
			   If _IsChecked($idCheckbox304) Then
				   _ArrayAdd($array, 21)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 21))
			   EndIf
			Case $idCheckbox305
			   If _IsChecked($idCheckbox305) Then
				   _ArrayAdd($array, 22)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 22))
			   EndIf
			Case $idCheckbox306
			   If _IsChecked($idCheckbox306) Then
				   _ArrayAdd($array, 23)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 23))
			   EndIf
			Case $idCheckbox307
			   If _IsChecked($idCheckbox307) Then
				   _ArrayAdd($array, 24)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 24))
			   EndIf
			Case $idCheckbox308
			   If _IsChecked($idCheckbox308) Then
				   _ArrayAdd($array, 25)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 25))
			   EndIf
			Case $idCheckbox309
			   If _IsChecked($idCheckbox309) Then
				   _ArrayAdd($array, 26)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 26))
			   EndIf
			Case $idCheckbox310
			   If _IsChecked($idCheckbox310) Then
				   _ArrayAdd($array, 27)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 27))
			   EndIf
			Case $idCheckbox311
			   If _IsChecked($idCheckbox311) Then
				   _ArrayAdd($array, 28)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 28))
			   EndIf
			Case $idCheckbox312
			   If _IsChecked($idCheckbox312) Then
				   _ArrayAdd($array, 29)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 29))
			   EndIf
			Case $idCheckbox313
			   If _IsChecked($idCheckbox313) Then
				   _ArrayAdd($array, 30)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 30))
			   EndIf
			   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			Case $idCheckbox401
			   If _IsChecked($idCheckbox401) Then
				   _ArrayAdd($array, 31)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 31))
			   EndIf
			Case $idCheckbox402
			   If _IsChecked($idCheckbox402) Then
				   _ArrayAdd($array, 32)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 32))
			   EndIf
			Case $idCheckbox403
			   If _IsChecked($idCheckbox403) Then
				   _ArrayAdd($array, 33)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 33))
			   EndIf
			Case $idCheckbox404
			   If _IsChecked($idCheckbox404) Then
				   _ArrayAdd($array, 34)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 34))
			   EndIf
			Case $idCheckbox405
			   If _IsChecked($idCheckbox405) Then
				   _ArrayAdd($array, 35)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 35))
			   EndIf
			Case $idCheckbox406
			   If _IsChecked($idCheckbox406) Then
				   _ArrayAdd($array, 36)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 36))
			   EndIf
			Case $idCheckbox407
			   If _IsChecked($idCheckbox407) Then
				   _ArrayAdd($array, 37)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 37))
			   EndIf
			Case $idCheckbox408
			   If _IsChecked($idCheckbox408) Then
				   _ArrayAdd($array, 38)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 38))
			   EndIf
			Case $idCheckbox409
			   If _IsChecked($idCheckbox409) Then
				   _ArrayAdd($array, 39)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 39))
			   EndIf
			Case $idCheckbox410
			   If _IsChecked($idCheckbox410) Then
				   _ArrayAdd($array, 40)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 40))
			   EndIf
			Case $idCheckbox411
			   If _IsChecked($idCheckbox411) Then
				   _ArrayAdd($array, 41)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 41))
			   EndIf
			Case $idCheckbox412
			   If _IsChecked($idCheckbox412) Then
				   _ArrayAdd($array, 42)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 42))
			   EndIf
	   EndSwitch
	WEnd

ElseIf @UserName = "User" Then  ;if YP PC

   $sRoomChartAddress = "https://www.skywaresystems.net/RoomChart.aspx?UserString=2627263527354456555942453526584267276460653527252634262526292634252525343032&MenuRowID=19&SKYMENU=CLEAR"

   GUICreate("Rooms to be charged", 775, 385)
   addVerticalSeparator(80, 20, 270)
   addHorizontalSeparator(20, 20+90, 735)
   addHorizontalSeparator(20, 20+90*2, 735)
   addHorizontalSeparator(20, 20+90*3, 735)
   GUICtrlCreateLabel("1", 20, 30, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   GUICtrlCreateLabel("2", 20, 30+90, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   GUICtrlCreateLabel("3", 20, 30+90*2, 50, 70, $SS_SUNKEN+$SS_CENTER+$SS_CENTERIMAGE)
   Local $idButton_Continue = GUICtrlCreateButton("Continue", 20, 300, 735, 75)
   GUISetState(@SW_SHOW)

   Local $idCheckbox101 = GUICtrlCreateCheckbox("1", 80+10, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox102 = GUICtrlCreateCheckbox("2", 80+10+35, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox103 = GUICtrlCreateCheckbox("3", 80+10+35*2, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox104 = GUICtrlCreateCheckbox("4", 80+10+35*3, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox105 = GUICtrlCreateCheckbox("5", 80+10+35*4, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox106 = GUICtrlCreateCheckbox("6", 80+10+35*5, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox107 = GUICtrlCreateCheckbox("7", 80+10+35*6, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox108 = GUICtrlCreateCheckbox("8", 80+10+35*7, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox109 = GUICtrlCreateCheckbox("9", 80+10+35*8, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox110 = GUICtrlCreateCheckbox("10", 80+10+35*9, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox111 = GUICtrlCreateCheckbox("11", 80+10+35*10, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox112 = GUICtrlCreateCheckbox("12", 80+10+35*11, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox113 = GUICtrlCreateCheckbox("13", 80+10+35*12, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox114 = GUICtrlCreateCheckbox("14", 80+10+35*13, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox115 = GUICtrlCreateCheckbox("15", 80+10+35*14, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox116 = GUICtrlCreateCheckbox("16", 80+10+35*15, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox117 = GUICtrlCreateCheckbox("17", 80+10+35*16, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox118 = GUICtrlCreateCheckbox("18", 80+10+35*17, 30, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox119 = GUICtrlCreateCheckbox("19", 80+10+35*18, 30, 35, 70, $BS_PUSHLIKE)

   Local $idCheckbox20 = GUICtrlCreateCheckbox("0", 80+10, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox21 = GUICtrlCreateCheckbox("1", 80+10+35, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox22 = GUICtrlCreateCheckbox("2", 80+10+35*2, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox23 = GUICtrlCreateCheckbox("3", 80+10+35*3, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox24 = GUICtrlCreateCheckbox("4", 80+10+35*4, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox25 = GUICtrlCreateCheckbox("5", 80+10+35*5, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox26 = GUICtrlCreateCheckbox("6", 80+10+35*6, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox27 = GUICtrlCreateCheckbox("7", 80+10+35*7, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox28 = GUICtrlCreateCheckbox("8", 80+10+35*8, 30+90, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox29 = GUICtrlCreateCheckbox("9", 80+10+35*9, 30+90, 35, 70, $BS_PUSHLIKE)

   Local $idCheckbox30 = GUICtrlCreateCheckbox("0", 80+10, 30+90*2, 35, 70, $BS_PUSHLIKE)
   Local $idCheckbox31 = GUICtrlCreateCheckbox("1", 80+10+35, 30+90*2, 35, 70, $BS_PUSHLIKE)

   While 1
   Sleep(10)
	  Switch GUIGetMsg()
		 Case $GUI_EVENT_CLOSE
			  Exit
		 Case $idButton_Continue
			  GUIDelete()
			  Continue()
			  Exit
			Case $idCheckbox101
			   If _IsChecked($idCheckbox101) Then
				   _ArrayAdd($array, 1)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 1))
			   EndIf
			Case $idCheckbox102
			   If _IsChecked($idCheckbox102) Then
				   _ArrayAdd($array, 2)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 2))
			   EndIf
			Case $idCheckbox103
			   If _IsChecked($idCheckbox103) Then
				   _ArrayAdd($array, 3)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 3))
			   EndIf
			Case $idCheckbox104
			   If _IsChecked($idCheckbox104) Then
				   _ArrayAdd($array, 4)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 4))
			   EndIf
			Case $idCheckbox105
			   If _IsChecked($idCheckbox105) Then
				   _ArrayAdd($array, 5)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 5))
			   EndIf
			Case $idCheckbox106
			   If _IsChecked($idCheckbox106) Then
				   _ArrayAdd($array, 6)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 6))
			   EndIf
			Case $idCheckbox107
			   If _IsChecked($idCheckbox107) Then
				   _ArrayAdd($array, 7)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 7))
			   EndIf
			Case $idCheckbox108
			   If _IsChecked($idCheckbox108) Then
				   _ArrayAdd($array, 8)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 8))
			   EndIf
			Case $idCheckbox109
			   If _IsChecked($idCheckbox109) Then
				   _ArrayAdd($array, 9)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 9))
			   EndIf
			Case $idCheckbox110
			   If _IsChecked($idCheckbox110) Then
				   _ArrayAdd($array, 10)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 10))
			   EndIf
			Case $idCheckbox111
			   If _IsChecked($idCheckbox111) Then
				   _ArrayAdd($array, 11)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 11))
			   EndIf
			Case $idCheckbox112
			   If _IsChecked($idCheckbox112) Then
				   _ArrayAdd($array, 12)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 12))
			   EndIf
			Case $idCheckbox113
			   If _IsChecked($idCheckbox113) Then
				   _ArrayAdd($array, 13)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 13))
			   EndIf
			Case $idCheckbox114
			   If _IsChecked($idCheckbox114) Then
				   _ArrayAdd($array, 14)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 14))
			   EndIf
			Case $idCheckbox115
			   If _IsChecked($idCheckbox115) Then
				   _ArrayAdd($array, 15)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 15))
			   EndIf
			Case $idCheckbox116
			   If _IsChecked($idCheckbox116) Then
				   _ArrayAdd($array, 16)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 16))
			   EndIf
			Case $idCheckbox117
			   If _IsChecked($idCheckbox117) Then
				   _ArrayAdd($array, 17)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 17))
			   EndIf
			Case $idCheckbox118
			   If _IsChecked($idCheckbox118) Then
				   _ArrayAdd($array, 18)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 18))
			   EndIf
			Case $idCheckbox119
			   If _IsChecked($idCheckbox119) Then
				   _ArrayAdd($array, 19)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 19))
			   EndIf
			   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			Case $idCheckbox20
			   If _IsChecked($idCheckbox20) Then
				   _ArrayAdd($array, 20)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 20))
			   EndIf
			Case $idCheckbox21
			   If _IsChecked($idCheckbox21) Then
				   _ArrayAdd($array, 21)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 21))
			   EndIf
			Case $idCheckbox22
			   If _IsChecked($idCheckbox22) Then
				   _ArrayAdd($array, 22)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 22))
			   EndIf
			Case $idCheckbox23
			   If _IsChecked($idCheckbox23) Then
				   _ArrayAdd($array, 23)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 23))
			   EndIf
			Case $idCheckbox24
			   If _IsChecked($idCheckbox24) Then
				   _ArrayAdd($array, 24)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 24))
			   EndIf
			Case $idCheckbox25
			   If _IsChecked($idCheckbox25) Then
				   _ArrayAdd($array, 25)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 25))
			   EndIf
			Case $idCheckbox26
			   If _IsChecked($idCheckbox26) Then
				   _ArrayAdd($array, 26)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 26))
			   EndIf
			Case $idCheckbox27
			   If _IsChecked($idCheckbox27) Then
				   _ArrayAdd($array, 27)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 27))
			   EndIf
			Case $idCheckbox28
			   If _IsChecked($idCheckbox28) Then
				   _ArrayAdd($array, 28)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 28))
			   EndIf
			Case $idCheckbox29
			   If _IsChecked($idCheckbox29) Then
				   _ArrayAdd($array, 29)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 29))
			   EndIf
			   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
			Case $idCheckbox30
			   If _IsChecked($idCheckbox30) Then
				   _ArrayAdd($array, 30)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 30))
			   EndIf
			Case $idCheckbox31
			   If _IsChecked($idCheckbox31) Then
				   _ArrayAdd($array, 31)
			   Else
				  _ArrayDelete($array, _ArraySearch($array, 31))
			   EndIf
      EndSwitch
   WEnd

EndIf