#include <Excel.au3>
#include <Array.au3>
#include <MsgBoxConstants.au3>
;~ Local $var = "D:\AutoIt\WinProMoney1.0\Excel\d_lotfac.xlsx"
Local $oExcel_1 = _Excel_Open()
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

Local $oWorkbook = _Excel_BookOpen($oExcel_1, "D:\AutoIt\WinProMoney1.0\Excel\d_lotfac.xls")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example 1", "Error opening '" & $oWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


Local $linha = 2 ; linha 1 = cabeçalho
Local $linhafinal = 3 ; linha 1 = cabeçalho
Local $value
Local $arr10[10]
Local $arrnumber15[15]
Local $arrnumbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25]
Local $arrletter = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q"]
Local $arrletter10 = ["S","T","U","V","W","X","Y","Z","AA","AB"]
Local $letter = 0
Local $concurso
Local $result
Local $saved
Local $deletado


;-------------------------------------
Local $allprimosdistribuicao
$allprimosdistribuicao = _PrimosDistributiva(2, 2186)
_ArrayDisplay($allprimosdistribuicao)
;-------------------------------------
;~ _ConferirLinhas()
;-------------------------------------
;~ Local $allprimos
;~ $allprimos = _Primos(2, 2186)
;~ _ArrayDisplay($allprimos)
;-------------------------------------
;~ $arr10 = _Find10($concurso, $linha, $linhafinal)
;~ _Find10(2174, 2186)
;-------------------------------------
#cs
Do
	$concurso = _Excel_RangeRead($oWorkbook, Default, "A"&$linha, 1)
;~ 	MsgBox(0, "", $concurso, 5)
	_Find10($concurso, 18, 19)
;~ 	_Delete($linha, $linha)

Until $concurso = 2174
$saved = _Excel_BookSave($oWorkbook)
;~ MsgBox(0, "SAVE FILE?", $saved, 2)
;~ Sleep(3000)
ConsoleWrite("CONCLUÍDO!"&@CRLF)
_Excel_close($oExcel_1)
#ce

; FUNÇÃO CONFERIR DISTRIBUIÇÃO DE PRIMOS;________________________________________________________

; FUNÇÃO CONFERIR DISTRIBUIÇÃO DE PRIMOS;________________________________________________________
Func _PrimosDistributiva($linhaini, $linhafinal)
	Local $inicio = $linhaini
	Local $arrprimos = [2, 3, 5, 7, 11, 13, 17, 19, 23]
	Local $numletra = 19 ; S
	Local $contador
	Local $colunaletra
	Local $porcConcPrimo2 = 0
	Local $porcConcPrimo3 = 0
	Local $porcConcPrimo5 = 0
	Local $porcConcPrimo7 = 0
	Local $porcConcPrimo11 = 0
	Local $porcConcPrimo13 = 0
	Local $porcConcPrimo17 = 0
	Local $porcConcPrimo19 = 0
	Local $porcConcPrimo23 = 0
	Local $all[9]

	$colunaletra = _Excel_ColumnToLetter($numletra)
	Local $index
	Do

		Local $concurso = _Excel_RangeRead($oWorkbook, Default, "A"&$inicio, 1)
		ConsoleWrite("Concurso - "&$concurso&" - Linha - "&$inicio&@CRLF)
		For $i = 0 To 9 Step 1
			$numero = _Excel_RangeRead($oWorkbook, Default, $colunaletra&$inicio, 1)
			If $numero = $arrprimos[0] Then
				$porcConcPrimo2 += 1
			ElseIf $numero = $arrprimos[1] Then
				$porcConcPrimo3 += 1
			ElseIf $numero = $arrprimos[2] Then
				$porcConcPrimo5 += 1
			ElseIf $numero = $arrprimos[3] Then
				$porcConcPrimo7 += 1
			ElseIf $numero = $arrprimos[4] Then
				$porcConcPrimo11 += 1
			ElseIf $numero = $arrprimos[5] Then
				$porcConcPrimo13 += 1
			ElseIf $numero = $arrprimos[6] Then
				$porcConcPrimo17 += 1
			ElseIf $numero = $arrprimos[7] Then
				$porcConcPrimo19 += 1
			ElseIf $numero = $arrprimos[8] Then
				$porcConcPrimo23 += 1
			EndIf
			$numletra = _Excel_ColumnToNumber($colunaletra)
;~ 				ConsoleWrite($numletra&@CRLF)
			$numletra += 1
			$colunaletra = _Excel_ColumnToLetter($numletra)
;~ 				ConsoleWrite($colunaletra&@CRLF)
		Next

;~ 		ConsoleWrite("Contador - "&$contador&@CRLF)
		ConsoleWrite("---------------------"&@CRLF)
		$inicio += 1
		$numletra = 19
		$colunaletra = _Excel_ColumnToLetter($numletra)

	Until $inicio > $linhafinal

	_ArrayPush($all, $porcConcPrimo2)
	_ArrayPush($all, $porcConcPrimo3)
	_ArrayPush($all, $porcConcPrimo5)
	_ArrayPush($all, $porcConcPrimo7)
	_ArrayPush($all, $porcConcPrimo11)
	_ArrayPush($all, $porcConcPrimo13)
	_ArrayPush($all, $porcConcPrimo17)
	_ArrayPush($all, $porcConcPrimo19)
	_ArrayPush($all, $porcConcPrimo23)

	Return $all

EndFunc;__________________________________________________________________________________________


; FUNÇÃO CONFERIR QUANTITATIVO DE PRIMOS;________________________________________________________
Func _Primos($linhaini, $linhafinal)
	Local $inicio = $linhaini
	Local $arrprimos = [2, 3, 5, 7, 11, 13, 17, 19, 23]
	Local $numletra = 19 ; S
	Local $contador
	Local $colunaletra
	Local $porcConcPrimos1
	Local $porcConcPrimos2
	Local $porcConcPrimos3
	Local $porcConcPrimos4
	Local $porcConcPrimos5
	Local $porcConcPrimos6
	Local $porcConcPrimos7
	Local $porcConcPrimos8
	Local $porcConcPrimos9
	Local $all[9]

	$colunaletra = _Excel_ColumnToLetter($numletra)
	Local $index
	Do

		Local $concurso = _Excel_RangeRead($oWorkbook, Default, "A"&$inicio, 1)
		ConsoleWrite("Concurso - "&$concurso&" - Letra - "&$colunaletra&" - Linha - "&$inicio&@CRLF)
		For $i = 0 To 9 Step 1
			$numero = _Excel_RangeRead($oWorkbook, Default, $colunaletra&$inicio, 1)
			$index = _ArraySearch($arrprimos, $numero)
			If $index <> -1 Then
				$contador += 1
;~ 				ConsoleWrite($index&@CRLF)
			EndIf
			$numletra = _Excel_ColumnToNumber($colunaletra)
;~ 				ConsoleWrite($numletra&@CRLF)
			$numletra += 1
			$colunaletra = _Excel_ColumnToLetter($numletra)
;~ 				ConsoleWrite($colunaletra&@CRLF)
		Next

		ConsoleWrite("Contador - "&$contador&@CRLF)
		ConsoleWrite("---------------------"&@CRLF)

		If $contador = 1 Then
			$porcConcPrimos1 += 1
		ElseIf $contador = 2 Then
			$porcConcPrimos2 += 1
		ElseIf $contador = 3 Then
			$porcConcPrimos3 += 1
		ElseIf $contador = 4 Then
			$porcConcPrimos4 += 1
		ElseIf $contador = 5 Then
			$porcConcPrimos5 += 1
		ElseIf $contador = 6 Then
			$porcConcPrimos6 += 1
		ElseIf $contador = 7 Then
			$porcConcPrimos7 += 1
		ElseIf $contador = 8 Then
			$porcConcPrimos8 += 1
		ElseIf $contador = 9 Then
			$porcConcPrimos9 += 1
		EndIf

		$inicio += 1
		$contador = 0
		$numletra = 19
		$colunaletra = _Excel_ColumnToLetter($numletra)

	Until $inicio > $linhafinal

	_ArrayPush($all, $porcConcPrimos1)
	_ArrayPush($all, $porcConcPrimos2)
	_ArrayPush($all, $porcConcPrimos3)
	_ArrayPush($all, $porcConcPrimos4)
	_ArrayPush($all, $porcConcPrimos5)
	_ArrayPush($all, $porcConcPrimos6)
	_ArrayPush($all, $porcConcPrimos7)
	_ArrayPush($all, $porcConcPrimos8)
	_ArrayPush($all, $porcConcPrimos9)

	Return $all

EndFunc;__________________________________________________________________________________________


; FUNÇÃO CONFERIR ORDEM DAS LINHAS(1ª ATÉ ÚLTIMA);_______________________________________________
Func _ConferirLinhas()
	$linha = 2
	$concurso = 1
	Do

		If $concurso + 1 = $linha Then
			$concurso = $linha
			$linha += 1
			ContinueLoop
		Else
			MsgBox(0, "Erro", "ERRO LINHA = "& $linha, 2)
			Exit
		EndIf

	Until $linha > 2173

	MsgBox(0, "Erro", "ERRO LINHA = "& $linha, 2)

EndFunc;_________________________________________________________________________________________


; FUNÇÃO DELETAR LINHAS;_________________________________________________________________________
Func _Delete($linhaini, $linhafin)
	If StringIsAlpha($concurso) Then
		$deletado = _Excel_RangeDelete($oWorkbook.ActiveSheet, String($linhaini&":"&$linhafin), Default, Default)
		If $deletado = 1 Then
			ConsoleWrite("LINHA DELETADA: "&$linhaini&@CRLF)
		Else
			ConsoleWrite("ERRO AO DELETAR LINHA "&$linhaini&@CRLF)
		EndIf
;~ 		$saved = _Excel_BookSave($oWorkbook)
	EndIf
	If $concurso <> "" Then
;~ 		ConsoleWrite("CONCURSO FOUND!"&@CRLF)
		$linha += 1
	Else
		$deletado = _Excel_RangeDelete($oWorkbook.ActiveSheet, String($linhaini&":"&$linhafin), Default, Default)
		If $deletado = 1 Then
			ConsoleWrite("LINHA DELETADA: "&$linhaini&@CRLF)
		Else
			ConsoleWrite("ERRO AO DELETAR LINHA "&@CRLF)
		EndIf
;~ 		$saved = _Excel_BookSave($oWorkbook)
	EndIf

EndFunc;_________________________________________________________________________________________


; FUNÇÃO ACHAR ARRAY DE 10 RESTANTES;____________________________________________________________
Func _Find10($linhaini, $linhafin)

	Local $concurso
	Do

		$concurso = _Excel_RangeRead($oWorkbook, Default, "A"&$linhaini, 1)
		If isString($concurso) Then
			$linhaini += 1
		EndIf
		If $concurso <> "" Then
			For $j = 2 To 16 Step 1
				$value = Int(_Excel_RangeRead($oWorkbook, Default, $arrletter[$j]&$linhaini, 1))
				_ArrayPush($arrnumber15, $value)
			Next

			For $i = 0 To 24 Step 1
				$result = _ArraySearch($arrnumber15, Int($arrnumbers[$i]))
				If $result = -1 Then
					_ArrayPush($arr10, Int($arrnumbers[$i]))
					_Excel_RangeWrite($oWorkbook, Default, Int($arrnumbers[$i]), $arrletter10[$letter]&$linhaini, True)
					$letter += 1
					ConsoleWrite("ADDED: "&$arrnumbers[$i]&" - CONC.: "&$concurso&@CRLF)
				Else
					ConsoleWrite("FOUND: "&$arrnumbers[$i]&" - CONC.: "&$concurso&@CRLF)
					ContinueLoop
				EndIf
	 	Next
			$letter = 0
			$linhaini += 1
			$saved = _Excel_BookSave($oWorkbook)
		Else
			$linhaini += 1
		EndIf

	Until $linhaini > $linhafin

	Return $arr10

EndFunc;_________________________________________________________________________________________