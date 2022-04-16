#include <MsgBoxConstants.au3>

while 1
	Local $aPos = MouseGetPos()
	If MouseClick Then
		ConsoleWrite("Mouse x, y:" & $aPos[0] & ", " & $aPos[1])
		ToolTip("x:" & $aPos[0] & " - y:" & $aPos[1])
		Sleep(250)
		MsgBox($MB_SYSTEMMODAL, "Mouse x, y:", $aPos[0] & ", " & $aPos[1])
	EndIf
WEnd