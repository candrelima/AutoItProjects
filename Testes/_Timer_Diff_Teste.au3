#include <Timers.au3>

Example()

Func Example()
	HotKeySet("{ESC}", "_Quit")

	Local $hStarttime = _Timer_Init()
	While 1
		ToolTip(round(_Timer_Diff($hStarttime)/1000, 0))
	WEnd
EndFunc   ;==>Example

Func _Quit()
	Exit
EndFunc   ;==>_Quit
