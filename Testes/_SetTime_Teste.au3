#include <Date.au3>

$tme = _SetTime(20, 15) ; Set time to 20:15
_SetTime(20, 15, 30) ; Set time to 20:15:30

$time = _NowTime(3)

While 1
	MsgBox(0, "_Now", $time, 1)
	Sleep(100)
WEnd
