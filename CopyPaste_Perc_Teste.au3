#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons8-conta-3d-64.ico
#AutoIt3Wrapper_Outfile_x64=EasyMoney - v1-4-2021.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****



#include <String.au3>
#include <AutoItConstants.au3>
#include <Date.au3>
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <ProgressConstants.au3>
#include <Array.au3>

Global $g_hTimer, $g_iSecs, $g_iMins, $g_iHour, $g_sTime, $endtime = 0
Global $inicio
Global $stop
Global $previsao
Global $valorprevisao
Global $relogio
Global $sell
Global $buy
Global $status
Global $vendabar
Global $comprabar
Global $zerar = False
Global $tempo
Global $play
Global $max
Global $p = [0, 0]

GuiCotation()

Func GuiCotation()

	; Create GUI
	GUICreate("EasyMoney - v1-4-2021", 350, 120, 15, @DesktopHeight-200)
	$inicio = GUICtrlCreateButton("INICIO", 70, 85, 100, 30)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	$previsao = GUICtrlCreateLabel("PREVISÃO", 280, 5, 80, 30)
	$tempoinput = GUICtrlCreateLabel("TEMPO", 210, 65, 45, 20)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	$valorprevisao = GUICtrlCreateLabel("0 ticks", 280, 25, 80, 30)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	$relogio = GUICtrlCreateLabel("00:00:00", 15, 60, 80, 20)
	GUICtrlSetFont(-1, 15, 600, 0, "Nachlieli CLM", 4)
	$sell = GUICtrlCreateLabel("SELL: ", 175, 10, 100, 20)
	GUICtrlSetFont(-1, 12, 500, 0, "Nachlieli CLM", 4)
	$buy = GUICtrlCreateLabel("BUY: ", 175, 35, 100, 20)
	GUICtrlSetFont(-1, 12, 500, 0, "Nachlieli CLM", 4)
	$status = GUICtrlCreateLabel("STATUS : ", 100, 61, 100, 20)
	GUICtrlSetFont(-1, 12, 500, 0, "Nachlieli CLM", 4)
	$vendabar = GUICtrlCreateProgress(15, 5, 150, 20, -1)
	$comprabar = GUICtrlCreateProgress(15, 30, 150, 20, -1)
	$time = GUICtrlCreateInput("", 260, 60, 80, 20, -1)
	GUISetState(@SW_SHOW)

	While 1
		; FileWriteLine("debug.log",@MIN & ":" & @SEC & " ==> before")
		Switch GUIGetMsg()
			Case $inicio
				$tempo = GUICtrlRead($time)
				$play = True
				_GetCotation($play, $tempo)

			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch
		; FileWriteLine("debug.log",@MIN & ":" & @SEC & " ==> after")
	WEnd
EndFunc   ;==>Example


Func _GetCotation($playornot, $time)

	$g_hTimer = TimerInit()
	AdlibRegister("Timer", 1000)

	$stop = GUICtrlCreateButton("STOP", 200, 85, 100, 30)
	GUICtrlSetFont(-1, 10, 300, 0, "Nachlieli CLM", 4)
	GUICtrlSetData($vendabar, 0)
	GUICtrlSetData($comprabar, 0)
	GUICtrlSetData($buy, "BUY: 0")
	GUICtrlSetData($sell, "SELL: 0")
	GUICtrlSetState($inicio, $GUI_HIDE)

	$play = $playornot
	Local $clipboard
	Local $x = 69
	Local $y = 33
	Local $difneg = 0
	Local $somaantesneg = 0
	Local $somadepoisneg = 0
	Local $totalpercSelling = 0
	Local $totalpercBuying = 0
	Local $par = True
	Local $arrayantes = []
	Local $arraydepois = []

	While $play

		Switch GUIGetMsg()
			Case $stop
				$play = False
				ControlSetText("EasyMoney - v1-4-2021", "", "Static4", "00:00:00")
				GUICtrlSetData($status, "STOPPED")
				GUICtrlSetState($stop, $GUI_HIDE)
				GUICtrlSetState($inicio, $GUI_SHOW)
				$difneg			= 0
				$somaantesneg	= 0
				$somadepoisneg	= 0
				$totalpercSelling = 0
				$totalpercBuying = 0

			Case $GUI_EVENT_CLOSE
				Exit
		EndSwitch

		ControlClick("Times && Trades WDOK21 - A partir de 09/04/2021", "", "[CLASS:TGridView; INSTANCE:1]", "left", 1, $x, $y)
		Sleep(3)
		Send('{CTRLDOWN}{c}')
		Sleep(3)
		Send('{CTRLUP}')
		Sleep(3)

		$clipboard = ClipGet()
	;~ 	ConsoleWrite($clipboard)
		If $par Then
			$arrayantes = _StringExplode($clipboard, @LF)
			$par = False
			ContinueLoop
		Else
			$arraydepois = _StringExplode($clipboard, @LF)
			$par = True
		EndIf

		; SOMANDO NEGATIVOS
		For $i = 1 To UBound($arrayantes) - 2 Step 1
			If $arrayantes[$i] < 0 Then
				$arrayantes[$i] = Number(StringReplace($arrayantes[$i], ".", ""))
				$somaantesneg += $arrayantes[$i]
			EndIf
		Next
		For $i = 1 To UBound($arraydepois) - 2 Step 1
			If $arraydepois[$i] < 0 Then
				$arraydepois[$i] = Number(StringReplace($arraydepois[$i], ".", ""))
				$somadepoisneg += $arraydepois[$i]
			EndIf
		Next
;~ 		$difneg = Abs($somaantesneg - $somadepoisneg)
		If $somaantesneg < $somadepoisneg Then
			$totalpercBuying += Abs($somaantesneg - $somadepoisneg)
;~ 			ConsoleWrite("VENDENDO - "&Abs($somaantesneg - $somadepoisneg)&@LF)
		ElseIf $somaantesneg > $somadepoisneg Then
			$totalpercSelling += Abs($somaantesneg - $somadepoisneg)
;~ 			ConsoleWrite("COMPRANDO - "&Abs($somaantesneg - $somadepoisneg)&@LF)
		EndIf
		GUICtrlSetData($status, "STATUS : " & $somaantesneg - $somadepoisneg)

		; EXIBINDO VALORES
		GUICtrlSetData($sell, "SELL: " & Abs($totalpercBuying))
		GUICtrlSetData($buy, "BUY: " & Abs($totalpercSelling))
		$difneg			= 0
		$somadepoisneg	= 0
		$somaantesneg	= 0

		If $zerar Then
			$totalpercBuying = 0
			$totalpercSelling = 0
			GUICtrlSetData($sell, "SELL: 0")
			GUICtrlSetData($buy, "BUY: 0")
		EndIf
		$max = Abs($totalpercSelling) + Abs($totalpercBuying)
		GUICtrlSetLimit($vendabar, $max)
		GUICtrlSetLimit($comprabar, $max)
		GUICtrlSetData($valorprevisao, Round((($p[1]-$p[0])/$p[0])*10, 1)&" ticks")
		GUICtrlSetData($vendabar, $totalpercBuying/($max/100))
		GUICtrlSetData($comprabar, $totalpercSelling/($max/100))
		$endtime = TimerDiff($g_hTimer)
;~ 		GUICtrlSetData($valorprevisao, $endtime)
;~ 		$g_hTimer = TimerInit()
	WEnd
EndFunc


Func Timer()
	_TicksToTime(Int(TimerDiff($g_hTimer)), $g_iHour, $g_iMins, $g_iSecs)
	Local $sTime = $g_sTime ; save current time to be able to test and avoid flicker..
	$g_sTime = StringFormat("%02i:%02i:%02i", $g_iHour, $g_iMins, $g_iSecs)
	If $sTime <> $g_sTime Then ControlSetText("EasyMoney - v1-4-2021", "", "Static4", $g_sTime)

	If $g_sTime = "00:0"&$tempo&":00" Then
		_ArrayPush($p, $max)
		ControlSetText("EasyMoney - v1-4-2021", "", "Static4", "00:00:00")
		$zerar = True
		$g_hTimer = TimerInit()
	Else
		$zerar = False
	EndIf
EndFunc   ;==>Timer