#include <MsgBoxConstants.au3>

; Wait until something changes in the region 0,0 to 50,50

; Get initial checksum
Local $iCheckSum = PixelChecksum(563, 178, 611, 219)
;~ MsgBox($MB_SYSTEMMODAL, "", "Something in the region has changed!" & $iCheckSum)


; Wait for the region to change, the region is checked every 100ms to reduce CPU load
While $iCheckSum = PixelChecksum(563, 178, 611, 219)
	Sleep(100)
WEnd

MsgBox($MB_SYSTEMMODAL, "", "Something in the region has changed!" & $iCheckSum)
