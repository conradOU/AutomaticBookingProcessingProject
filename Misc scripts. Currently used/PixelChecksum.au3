;good idea to have the tab pinned for pixel search, as that would "fix" its location
;if $g_bIsITNecessaryToPrintOutSiteminder = True then pixel location will be different
;when it's clicked on, it's slightly hightlighted, and therefore the checksum will be different

#include <MsgBoxConstants.au3>

; Wait until something changes in the region 0,0 to 50,50

; Get initial checksum

Local $iYcoordinates = 256



Sleep(4000)

ClipPut(PixelGetColor(427, $iYcoordinates+(21*7)))



