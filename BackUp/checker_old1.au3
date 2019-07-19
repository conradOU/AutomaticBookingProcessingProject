 ;ClipPut(PixelChecksum(48, 416, 139, 436) )
;~    MouseMove(725, 289, 0)
;~    MouseDown("left")
;~    MouseMove(1317, 289, 0)
;~    MouseUp("left")

;~    SafelyCopyHighlightedToClipboard()

;~    $sClipBoard = ClipGet()
#include <Date.au3>

   $sClipBoard = "	Arrive on 06-07-2019, Sun to 08-07-2019, Mon for 1 night(s). 	 	Rate 	 	63.00 	 	Room Type 	K/T 	 	Rooms 	40 	 	Room # 	 	105"
   $Result = StringTrimLeft($sClipBoard, StringInStr($sClipBoard, "Rooms") +4)
   $Result = StringTrimRight($Result, StringInStr($Result, "#") +1)
   $Result = StringStripWS ($Result, 8) ;flag 8 used - $STR_STRIPALL (8) = strip all spaces (over-rides all other flags)

   ;$Result = StringTrimRight($Result, StringInStr($Result, ' ') )
   MsgBox(0, "Error", " " & $Result)

