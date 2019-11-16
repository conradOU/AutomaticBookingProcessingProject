;~ left arrow, then up arrow, to process the booking above, then execuste main, once the counter runs out, then exit

Global $LOADING_TIME_SLOW_PC_RELATED = 800

Local $sNumberOfBookings = InputBox("", "Enter number of bookings to process:", "2")


For $iCounter = Number($sNumberOfBookings) To 1 Step -1

   RunWait('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & "Main.au3" &'"')

   Sleep($LOADING_TIME_SLOW_PC_RELATED)
   Send("{LEFT}")
   Sleep($LOADING_TIME_SLOW_PC_RELATED)
   Send("{UP}")
   Sleep($LOADING_TIME_SLOW_PC_RELATED)

Next


