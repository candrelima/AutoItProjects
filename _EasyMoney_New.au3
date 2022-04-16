; *** Demo to show a timer window
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>


Global $g_hTimer, $g_iSecs, $g_iMins, $g_iHour, $g_sTime

Example()

Func Example()
	; Create GUI
	GUICreate("Timer", 350, 120)
	$inicio = GUICtrlCreateButton("INICIO", 125, 85, 100, 30)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	GUICtrlCreateLabel("00:00:00", 15, 60, 80, 20)
	GUICtrlSetFont(-1, 14, 500, 0, "Nachlieli CLM", 4)
	GUICtrlCreateLabel("SELL: ", 167, 10, 100, 20)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	GUICtrlCreateLabel("BUY: ", 167, 35, 100, 20)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	GUICtrlCreateLabel("STATUS : ", 100, 65, 100, 20)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	$venda = GUICtrlCreateProgress(15, 5, 150, 20, -1, -1)
	$compra = GUICtrlCreateProgress(15, 30, 150, 20, -1, -1)
	GUISetState(@SW_SHOW)
	; Start timer
	$g_hTimer = TimerInit()
	AdlibRegister("Timer", 1000)
	While 1
		; FileWriteLine("debug.log",@MIN & ":" & @SEC & " ==> before")
		Switch GUIGetMsg()
			Case $inicio
				_GetCotation($play)

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