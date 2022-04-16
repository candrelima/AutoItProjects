#include <MsgBoxConstants.au3>

; Wait until something changes in the region 0,0 to 50,50

; Get initial checksum
;~ MsgBox($MB_SYSTEMMODAL, "", "Something in the region has changed!" & $iCheckSum)
Global $coordsqtdbuy, $coordsqtdsell
AdlibRegister("pixelbuy", 1000)
AdlibRegister("pixelsell", 1000)
While 1
WEnd
; Wait for the region to change, the region is checked every 100ms to reduce CPU load

Func pixelbuy()
	Local $iCheckSum = PixelChecksum($coordsqtdbuy[0], $coordsqtdbuy[1], $coordsqtdbuy[2], $coordsqtdbuy[3])
	While $iCheckSum = PixelChecksum($coordsqtdbuy[0], $coordsqtdbuy[1], $coordsqtdbuy[2], $coordsqtdbuy[3])
		ToolTip("Whiling", 10, 10, "Testing")
	WEnd
	Return False

;~ 	MsgBox($MB_SYSTEMMODAL, "", "Something in the region has changed!" & $iCheckSum)
EndFunc

Func pixelsell()
	Local $iCheckSum = PixelChecksum($coordsqtdsell[0], $coordsqtdsell[1], $coordsqtdsell[2], $coordsqtdsell[3])
	While $iCheckSum = PixelChecksum($coordsqtdsell[0], $coordsqtdsell[1], $coordsqtdsell[2], $coordsqtdsell[3])
		ToolTip("Whiling", 10, 10, "Testing")
	WEnd
	Return False

;~ 	MsgBox($MB_SYSTEMMODAL, "", "Something in the region has changed!" & $iCheckSum)
EndFunc