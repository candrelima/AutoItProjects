#include <Array.au3>

# FUNÇÃO SOMA
Func _SumMed($array)

	Local $sumMed = 0
	Local $count = 0

	For $loop = 0 To Ubound($array) - 1 Step 1
		If $array[$loop] <> "" Then
			$sumMed += Int($array[$loop])
			$count += 1
		EndIf
	Next
	$sumMed /= $count

	Return $sumMed
EndFunc

# RETORNA A MEDIA ENTRE BUY E SELL
Func _GetMedio($buy, $sell)

	Local $medio = abs($buy - $sell)/2

	Return $medio

EndFunc

# RETORNA MEDIANA
Func _GetMediana($buy, $sell)

	Local $medio = _GetMedio($buy, $sell)
	Local $mediana

	$mediana = $medio + $buy

	Return $mediana

EndFunc