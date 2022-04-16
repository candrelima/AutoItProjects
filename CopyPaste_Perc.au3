#include <String.au3>
#include <1-Functions_Excel.au3>
#include <AutoItConstants.au3>
#include <Date.au3>



Func _GetCotation($play)
	HotKeySet("{F2}", "_PararMarket")

	Local $play = true
	Local $clipboard
	Local $arraypar = []
	Local $arrayimpar = []
	Local $x = 69
	Local $y = 33
	Local $totalpercSelling = 0
	Local $totalpercBuying = 0
	Local $par = True
	Local $dif
	Local $somaIMPARNEG
	Local $somaIMPARPOS
	Local $somaPARNEG
	Local $somaPARPOS
	While $play
	;~ 	$soma = 0
	;~ 	MouseMove($x, $y, 5)
	;~ 	Sleep(1)
		ControlClick("Times && Trades WDOK21 - A partir de 09/04/2021", "", "[CLASS:TGridView; INSTANCE:1]", "left", 1, $x, $y)
		Sleep(5)
		Send('{CTRLDOWN}{c}')
		Sleep(5)
		Send('{CTRLUP}')
		Sleep(5)

	;~ 	Sleep(1)
	;~ 	MouseMove($x+75, $y+261)
	;~ 	MouseClick($MOUSE_CLICK_RIGHT
	;~ 	Sleep(1)

		$clipboard = ClipGet()
	;~ 	ConsoleWrite($clipboard)
		Sleep(500)
		If $par Then
			$arraypar = _StringExplode($clipboard, @LF)
			$par = False
			ContinueLoop
		Else
			$arrayimpar = _StringExplode($clipboard, @LF)
			$par = True
		EndIf

		$dif = 0
		$somaIMPARNEG = 0
		$somaIMPARPOS = 0
		$somaPARNEG = 0
		$somaPARPOS = 0
		If UBound($arraypar) = UBound($arrayimpar) Then
			For $i = 1 To UBound($arraypar) - 2 Step 1
				If $arraypar[$i] < 0 Then
					$arraypar[$i] = Number(StringReplace($arraypar[$i], ".", ""))
					$somaPARNEG += $arraypar[$i]
					$arrayimpar[$i] = Number(StringReplace($arrayimpar[$i], ".", ""))
					$somaIMPARNEG += $arrayimpar[$i]
				EndIf
			Next
			$dif = $somaPARNEG - $somaIMPARNEG

			ConsoleWrite(">>>>>>  " &@CRLF)
			If $somaPARNEG < $somaIMPARNEG Then
				ConsoleWrite($difvenda & " COMPRANDO" & @LF)
				$totalpercBuying += $difvenda
			Else
				$totalpercSelling += $difcompra
				ConsoleWrite($difvenda & " VENDENDO" & @LF)
			EndIf
		EndIf

	;~ 	$play = False

	WEnd
EndFunc

Func Timer()
	_TicksToTime(Int(TimerDiff($g_hTimer)), $g_iHour, $g_iMins, $g_iSecs)
	Local $sTime = $g_sTime ; save current time to be able to test and avoid flicker..
	$g_sTime = StringFormat("%02i:%02i:%02i", $g_iHour, $g_iMins, $g_iSecs)
	If $sTime <> $g_sTime Then ControlSetText("Timer", "", "Static1", $g_sTime)
EndFunc   ;==>Timer