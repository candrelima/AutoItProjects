#include <MsgBoxConstants.au3>
#include <AutoItConstants.au3>

_Example()
Func _Example()
	Local $iDec = Hex(255, 6)
	MsgBox($MB_SYSTEMMODAL, "", $iDec) ; Displays the number 4095.
EndFunc

