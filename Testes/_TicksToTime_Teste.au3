; *** Demo to show a timer window
#include <Date.au3>
#include <GUIConstantsEx.au3>

Global $g_hTimer, $g_iSecs, $g_iMins, $g_iHour, $g_sTime

Example()

Func Example()
	; Create GUI
	GUICreate("Timer", 260, 90)
	GUICtrlCreateLabel("00:00:00", 15, 60, 100, 20)
	GUICtrlSetFont(-1, 14, 500, 0, "Nachlieli CLM", 4)
	GUISetState(@SW_SHOW)
	; Start timer
	$g_hTimer = TimerInit()
	AdlibRegister("Timer", 1000)
	While 1
		; FileWriteLine("debug.log",@MIN & ":" & @SEC & " ==> before")
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch
		; FileWriteLine("debug.log",@MIN & ":" & @SEC & " ==> after")
	WEnd
EndFunc   ;==>Example

Func Timer()
	_TicksToTime(Int(TimerDiff($g_hTimer)), $g_iHour, $g_iMins, $g_iSecs)
	Local $sTime = $g_sTime ; save current time to be able to test and avoid flicker..
	$g_sTime = StringFormat("%02i:%02i:%02i", $g_iHour, $g_iMins, $g_iSecs)
	If $sTime <> $g_sTime Then ControlSetText("Timer", "", "Static1", $g_sTime)
EndFunc   ;==>Timer
