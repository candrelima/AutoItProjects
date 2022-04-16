#include <String.au3>
#include <1-Functions_Excel.au3>
#include <AutoItConstants.au3>
HotKeySet("{F2}", "_PararMarket")
$play = true
Local $clipboard
Local $array = []
Local $x = 763
Local $y = 134
;~ Local $soma
Local $percSelling
Local $percBuying
Local $par = True, $impar = False
While $play
;~ 	$soma = 0
	MouseMove($x, $y, 5)
	Sleep(5)
	MouseClick($MOUSE_CLICK_RIGHT)
	Sleep(5)
	MouseMove($x+75, $y+261)
	MouseClick($MOUSE_CLICK_RIGHT)
	Sleep(5)
	$clipboard = ClipGet()

	$array = _StringExplode($clipboard, @LF)
;~ 	_ArrayDisplay($array, "Clipboard")
;~ 	ConsoleWrite(">>>>>>>>>>>>>>>>>"&@LF)
	For $i = 1 To UBound($array) - 2 Step 1
		$array[$i] = Number(StringReplace($array[$i], ".", ""))
		If $array[$i] < 0 Then

		ElseIf $array[$i] > 0 Then
		EndIf
;~ 		$soma += Number($array[$i])
;~ 		ConsoleWrite("i -  " & $i & " <<<>>>  " & $array[$i]&@LF)
;~ 		ConsoleWrite("SALDO >>>  " & $soma&@CRLF)
		Sleep(5)
	Next



;~ 	ConsoleWrite("Valor SALDO >>>  " & $soma&@CRLF)
	ToolTip('SALDO >>>  '& $soma & @LF & 'SALDO >>>  '& $soma, 0, 0)
	Sleep(50)

	;~ 	While UBound($array)
;~ 		ToolTip('Valor removido  >>>  '&_ArrayPop($array), 0, 0)
;~ 		Sleep(5)
;~ 	WEnd
;~ 	_ArrayDisplay($array, "RESUMO")

;~ 	$play = False

WEnd