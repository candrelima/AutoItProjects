
#include <GUIConstantsEx.au3>
#include <Misc.au3>
#include <Excel.au3>
#include <ColorConstants.au3>
#include <FileConstants.au3>
#include <Date.au3>
#include <Timers.au3>

AdlibRegister("_Timing", 1000)
AdlibRegister("_Timer", 1000)

;-------------------------------------------------------------------------

#Region ; ELEMENTOS
Global $Button_ler, $Button_coletar, $Button_salvar, $List_Valores, $Label_Data, $Label_Clock, $Label_Specs
Global $Label_Timerbuy5, $Label_Timersell5, $Label_Timerbuy15, $Label_Timersell15, $Label_Timerbuy30, $Label_Timersell30
Global $Label_displaytime5, $Label_displaytime15, $Label_displaytime30, $Button_Compra, $Button_Venda
#EndRegion
;-------------------------------------------------------------------------

#Region ; VARIÁVEIS
Local $hDLL = DllOpen("user32.dll")
Global $Progressler
Global $tipo
Global $play
Global $leep = 25, $beep = 1440
Global $time = "", $if_time = "", $fix_time = "", $salvar_mediabanda = False
Global $pathsavefile = "wdo21"
#EndRegion

; _Timer()
Func _Timer()

    GUICtrlSetData($Label_Clock, "Clock: " & _NowTime(5))

;~ 	ConsoleWrite(StringTrimLeft(_NowTime(5), 3) & @CRLF)

EndFunc   ;==>Timer()
;-------------------------------------------------------------------------


; _PararMarket()
Func _PararMarket()

	$play = False
	While _IsPressed("71", $hDLL) ; press button F2
		Sleep(10)
	WEnd

EndFunc   ;==>_PararMarket()
;-------------------------------------------------------------------------


; _Timing()
Func _Timing()
	$time = _NowTime(5)
	$if_time = StringSplit(StringTrimLeft($time, 4), ":")
;~ 	ConsoleWrite($if_time[2] & @CRLF)
	; se os dígitos coninciderem deve-se salvar as médias das bandas
	If $if_time[1] = 0 Or $if_time[1] = 4 Then
;~ 			ConsoleWrite($if_time[2] & @CRLF)
		If $if_time[2] = 59 Then
;~ 				ConsoleWrite($if_time[1] & @CRLF) ; exibir os segundos
			$fix_time = $time
			$salvar_mediabanda = True
		EndIf
	EndIf
EndFunc   ;==>_Timing()
;-------------------------------------------------------------------------


; _IniciarTime()
Func _IniciarTime($playCot)

	$play = $playCot

	; modificando a aparência dos botões
	GUICtrlSetData($Button_Coletar, "PARAR(F2)")
	GUICtrlSetState($Button_Coletar, $GUI_DISABLE)
	GUICtrlSetState($Button_Ler, $GUI_HIDE)
	GUICtrlSetState($Button_Salvar, $GUI_HIDE)
	GUICtrlSetBkColor($Button_Coletar, $COLOR_YELLOW)

	Local $timerb5 = 0
	Local $timers5 = 0
	Local $timerb15 = 0
	Local $timers15 = 0
	Local $timer_init, $fix_time1 = 0, $if_time2 = 0
	Local $value, $qtd_buy = 0,  $qtd_sell = 0, $media = 0

	Local $b5 = [0,0,0]
	Local $b15 = [0,0,0]
	Local $s5 = [0,0,0]
	Local $s15 = [0,0,0]

	;~ Local $var = "D:\projetos_autoit\WinProMoney1.0\ProTrading\Livro_Futuro_Novo.xlsx"
	Local $oExcel_1 = _Excel_Open()
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	Local $oWorkbook = _Excel_BookOpen($oExcel_1, "D:\projetos_autoit\WinProMoney1.0\ProTrading\Livro_Futuro_Novo.xlsx")
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example 1", "Error opening '" & $oWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

;~ 	ConsoleWrite("$oWorkbook: " & $oWorkbook & @CRLF) ; não mostra nada

;~ 	GUICtrlSetData($Label_Timerbuy5, "Buy: " & 0)
;~ 	GUICtrlSetData($Label_Timersell5, "Sell: " & 0)
;~ 	GUICtrlSetData($Label_Timerbuy15, "Buy: " & 0)
;~ 	GUICtrlSetData($Label_Timersell15, "Sell: " & 0)

	While $play

		$timer_init = _Timer_Init()
		$fix_time = _NowTime(5)
		$value = _Excel_RangeRead($oWorkbook, Default, "G23", 1)
		$qtd_buy = Round(_Excel_RangeRead($oWorkbook, Default, "E23", 1), 8)
		$qtd_sell = Round(_Excel_RangeRead($oWorkbook, Default, "H23", 1), 8)
		$media = Round(_Excel_RangeRead($oWorkbook, Default, "G22", 1), 2)

		GUICtrlSetData($Label_Specs, $qtd_buy & " <-> " & $qtd_sell & " >> " & $media)
;~ 		ConsoleWrite("$value: " & $value & @CRLF)
		If $value = 0 Or $value = "" Then
			ContinueLoop
		EndIf
		If $value = 1 Then
			$timerb5 += Round(_Timer_Diff($timer_init)/1000, 2)
			$timerb15 += Round(_Timer_Diff($timer_init)/1000, 2)
			$b5 = StringSplit($timerb5, ".")
			$b15 = StringSplit($timerb15, ".")
			GUICtrlSetBkColor($Button_Compra, $COLOR_GREEN)
			GUICtrlSetBkColor($Button_Venda, 0xB9D1EA)
		ElseIf $value = -1 Then
			$timers5 += Round(_Timer_Diff($timer_init)/1000, 2)
			$timers15 += Round(_Timer_Diff($timer_init)/1000, 2)
			$s5 = StringSplit($timers5, ".")
			$s15 = StringSplit($timers15, ".")
			GUICtrlSetBkColor($Button_Venda, $COLOR_RED)
			GUICtrlSetBkColor($Button_Compra, 0xB9D1EA)
		Else
			GUICtrlSetBkColor($Button_Venda, 0xB9D1EA)
			GUICtrlSetBkColor($Button_Compra, 0xB9D1EA)
		EndIf

		GUICtrlSetData($Label_Timerbuy5, "Buy: " & $b5[1])
;~ 		ConsoleWrite("$b5[1]: " & $b5[1] & @CRLF)
		GUICtrlSetData($Label_Timersell5, "Sell: " & $s5[1])
;~ 		ConsoleWrite("$s5[1]: " & $s5[1] & @CRLF)
		GUICtrlSetData($Label_Timerbuy15, "Buy: " & $b15[1])
;~ 		ConsoleWrite("$b15[1]: " & $b15[1] & @CRLF)
		GUICtrlSetData($Label_Timersell15, "Sell: " & $s15[1])
;~ 		ConsoleWrite("$s15[1]: " & $s15[1] & @CRLF)

		$if_time1 = StringTrimLeft($fix_time, 4) ; 00:00:00 -> xx:x0:00
;~ 		ConsoleWrite("$if_time1: " & $if_time1 & @CRLF)
		$if_time2 = StringTrimLeft($fix_time, 3) ; 00:00:00 -> xx:00:00
;~ 		ConsoleWrite("$if_time2: " & $if_time2 & @CRLF)

		; de 5 em 5 minutos
		If $if_time1 = "4:59" Or $if_time1 = "9:59" Then

			_SalvarTime($pathsavefile, "5 min <> " & $b5[1] &"<>"& $s5[1] & "<>" & $fix_time, "wdo.txt")
			GUICtrlSetData($Label_displaytime5, "Save 5m: SAVED" & $fix_time)
			GUICtrlSetData($Label_Timerbuy5, "Buy: " & $b15[1])
			GUICtrlSetData($Label_Timersell5, "Sell: " & $s15[1])
			; de 15 em 15 minutos
			If $if_time2 = "14:59" Or $if_time2 = "29:59" Or $if_time2 = "44:59" Or $if_time2 = "59:59" Then
				_SalvarTime($pathsavefile, "15 min <> " & $b15[1] &"<>"& $s15[1] & "<>" & $fix_time, "wdo.txt")
				GUICtrlSetData($Label_displaytime15, "Save 15m: SAVED" & $fix_time)
				$timerb15 = 0
				$timers15 = 0
				$b15[1] = 0
				$s15[1] = 0
				GUICtrlSetData($Label_Timerbuy15, "Buy: " & $b15[1])
				GUICtrlSetData($Label_Timersell15, "Sell: " & $s15[1])
			Else
				GUICtrlSetData($Label_Timerbuy15, "Buy: " & $b15[1])
				GUICtrlSetData($Label_Timersell15, "Sell: " & $s15[1])
			EndIf
			$timerb5 = 0
			$timers5 = 0
			$b5[1] = 0
			$s5[1] = 0
			Sleep(1000)
		Else
			GUICtrlSetData($Label_Timerbuy5, "Buy: " & $b5[1])
			GUICtrlSetData($Label_Timersell5, "Sell: " & $s5[1])
		Endif
		GUICtrlSetData($Label_displaytime5, "Save 5m: --:--:--")
		GUICtrlSetData($Label_displaytime15, "Save 15m: --:--:--")
		GUICtrlSetData($Label_displaytime30, "Save 30m: --:--:--")
	WEnd

	GUICtrlSetData($Button_Coletar, "COLETAR")
	GUICtrlSetState($Button_Coletar, $GUI_ENABLE)
	GUICtrlSetState($Button_Ler, $GUI_SHOW)
	GUICtrlSetState($Button_Salvar, $GUI_SHOW)
	GUICtrlSetBkColor($Button_Coletar, $COLOR_AQUA)

EndFunc   ;==>_IniciarTime()
;-------------------------------------------------------------------------

; _Iniciar()
Func _Iniciar($playCot)

	Global $pathsavefile
;~ 	ConsoleWrite($pathsavefile & @CRLF)
	$play = $playCot
	Local $horabuy = 0, $horasell = 0
	Local $novahorabuy = 1, $novahorasell = 1
	Local $buy = 0, $sell = 0, $qtdbuy = 0, $qtdsell = 0
	Local $novobuy = 1, $novosell = 1, $novoqtdbuy = 1, $novoqtdsell = 1

	; caso tenha uma oferta nova no livro de ofertas serão feitas as leituras dos seguintes dados
	Local $precoatual = 0
;~ 	Local $media = 0
;~ 	Local $fator = 0
	Local $razao = 0
	Local $novarazao = 0
	Local $count = 0
	Local $valores = [[0,0]]
	Local $bandas = [["0",0,0]]
	Local $banda_buy = 0, $banda_sell = 0, $banda_min_total = 0, $banda_max_total = 0
	Local $lista_preco_razao = [[0,0]]
	Local $lista_bandas = [["00:00:00",0,10000]]
	Local $lista_soma
	Local $lista_soma_salva = False
	Local $lista_bandas_salva = False
	Local $resultado = False

	; modificando a aparência dos botões
	GUICtrlSetData($Button_Coletar, "PARAR(F2)")
	GUICtrlSetState($Button_Coletar, $GUI_DISABLE)
	GUICtrlSetState($Button_Ler, $GUI_HIDE)
	GUICtrlSetState($Button_Salvar, $GUI_HIDE)
	GUICtrlSetBkColor($Button_Coletar, $COLOR_YELLOW)

	; realizando testes
;~ 	ConsoleWrite($lista_preco_razao[0][0]&"----"&@CRLF)
;~ 	ConsoleWrite($lista_preco_razao[0][1]&"----"&@CRLF)
;~ 	ConsoleWrite($lista_bandas[0][0]&"----"&@CRLF)
;~ 	ConsoleWrite($lista_bandas[0][1]&"----"&@CRLF)
;~ 	ConsoleWrite($lista_bandas[0][2]&"----"&@CRLF)
;~ 	_ArrayAdd($total_listas, $lista_preco_razao[0][0][0])
;~ 	_ArrayAdd($total_listas, $lista_bandas[0][0][0])

	; exibir lista preço-razão ou lista bandas
;~ 	_ArrayDisplay($lista_bandas, "$lista_bandas")

	;~ Local $var = "D:\projetos_autoit\WinProMoney1.0\ProTrading\Livro_Futuro.xlsx"
	Local $oExcel_1 = _Excel_Open()
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	Local $oWorkbook = _Excel_BookOpen($oExcel_1, "D:\projetos_autoit\WinProMoney1.0\ProTrading\Livro_Futuro.xlsx")
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example 1", "Error opening '" & $oWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	; inicio do while play

	While $play

		$razao = Round(_Excel_RangeRead($oWorkbook, Default, "E23", 1), 8)

		$horabuy = _Excel_RangeRead($oWorkbook, Default, "A26", 1)
		$qtdbuy = _Excel_RangeRead($oWorkbook, Default, "B26", 1)
		$buy = _Excel_RangeRead($oWorkbook, Default, "C26", 1)

		$horasell = _Excel_RangeRead($oWorkbook, Default, "F26", 1)
		$qtdsell = _Excel_RangeRead($oWorkbook, Default, "E26", 1)
		$sell = _Excel_RangeRead($oWorkbook, Default, "D26", 1)
;~ 		ConsoleWrite($horabuy & @CRLF)
;~ 		ConsoleWrite($buy & @CRLF)
;~ 		ConsoleWrite($horasell & @CRLF)
;~ 		ConsoleWrite($sell & @CRLF)
;~ 		ConsoleWrite($qtdbuy & @CRLF)
;~ 		ConsoleWrite($qtdsell & @CRLF)
;~ 		ConsoleWrite($razao & @CRLF)

		If $razao = 0 Or $razao = $novarazao Or $razao = "" Then
			ContinueLoop
		Else
			If ($horabuy <> $novahorabuy) Or ($qtdbuy <> $novoqtdbuy) Or ($buy <> $novobuy) Or _
				($horasell <> $novahorasell) Or ($qtdsell <> $novoqtdsell) Or ($sell <> $novosell) Then

;~ 				$precoatual = Round(_Excel_RangeRead($oWorkbook, Default, "B23", 1), 5)
				$precoatual = Ceiling(Round(_Excel_RangeRead($oWorkbook, Default, "B23", 1), 7))
				If $precoatual = 0 Then
					ContinueLoop
				EndIf
;~	 			ConsoleWrite($precoatual & @CRLF)

				; SALVAR NA LISTA GERAL
				$valores[0][0] = $precoatual
				$valores[0][1] = $razao * 100
				_ArrayAdd($lista_preco_razao, $valores)

				; CALCULANDO AS BANDAS BUY E SELL, MÁXIMO E MÍNIMO
				$banda_buy = Round($precoatual - ($precoatual * $razao * $qtdbuy), 2)
				$banda_sell = Round(($precoatual * $razao * $qtdsell) + $precoatual, 2)
				$banda_min_total += $banda_buy
				$banda_max_total += $banda_sell
				$count += 1

;~ 				_ArrayDisplay($lista_preco_razao, "$lista_preco_razao")
;~ 				ConsoleWrite("p " & $valores[0][0] & " <-> " & "r " & $valores[0][1] & @CRLF)
				GUICtrlSetData($List_Valores, $valores[0][0] &" <-> "& $valores[0][1] & @CRLF)
;~ 				ConsoleWrite("############" & @CRLF)

				$novarazao = $razao
				$novahorabuy = $horabuy
				$novahorasell = $horasell
				$novoqtdbuy = $qtdbuy
				$novoqtdsell = $qtdsell
				$novobuy = $buy
				$novosell = $sell

			EndIf
		EndIf

		; SALVANDO NA LISTA BANDAS
;~ 		ConsoleWrite("Máximo e mínimo salvos com sucesso." & @CRLF)
		If $salvar_mediabanda = True Then
			$bandas[0][0] = $fix_time ; hora salva
			$bandas[0][1] = Ceiling(Round($banda_min_total/$count, 2)) ; media da banda minima
			$bandas[0][2] = Ceiling(Round($banda_max_total/$count, 2)) ; media da banda maxima
			GUICtrlSetData($List_Valores, $bandas[0][0] &" <-> "& $bandas[0][1] & " <-> "& $bandas[0][2] & @CRLF)
			_ArrayAdd($lista_bandas, $bandas)

			; zerando valores das medias das bandas totais e count
			$banda_min_total = 0
			$banda_max_total = 0
			$count 			 = 0
			$salvar_mediabanda = False
;~ 			ConsoleWrite("bandas: " & $bandas[0][0] &" <-> "& $bandas[0][1] & " <-> "& $bandas[0][2] & @CRLF)
		EndIf

	WEnd

	GUICtrlSetData($Button_Coletar, "COLETAR")
	GUICtrlSetState($Button_Coletar, $GUI_ENABLE)
	GUICtrlSetState($Button_Ler, $GUI_SHOW)
	GUICtrlSetState($Button_Salvar, $GUI_SHOW)
	GUICtrlSetBkColor($Button_Coletar, $COLOR_AQUA)

	; adicionando as duas listas a lista final para salvar:
	; listas com preco e razão/lista com bandas máxima e mínima

	; exibir lista preço-razão ou lista bandas
;~ 	_ArrayDisplay($lista_preco_razao, "$lista_precos")
;~ 	_ArrayDisplay($lista_bandas, "$lista_bandas")

	; lista com valores somados e em ordem decrescente
	$lista_soma = _SomarPares($lista_preco_razao) ; soma os valores e já salva ao mesmo tempo
	$lista_soma_salva = _SalvarParametros($pathsavefile, $lista_soma, "LISTA P-R SOMA")
	$lista_bandas_salva = _SalvarParametros($pathsavefile, $lista_bandas, "LISTA BANDAS")

	If $lista_soma_salva = True Then
		MsgBox($MB_SYSTEMMODAL, "STATUS", "LISTA P-R SOMA SALVA.", 2)
	EndIf
	If $lista_bandas_salva = True Then
		MsgBox($MB_SYSTEMMODAL, "STATUS", "LISTA BANDAS SALVA.", 2)
	EndIf
	Return $lista_preco_razao

EndFunc   ;==>_Iniciar()
;---------------------------------------------------------------------------------


; _SomarPares()
Func _SomarPares($lista_base)

	Local $lista_precos = $lista_base
	Local $find_index_lista, $index_preco, $index_razao, $razao_total = 0
	Local $ja_pesquisados = []
	Local $par[1][2]
	Local $nova_lista_soma = [[0,0]]

	_ArraySort($lista_precos)
;~ 	_ArrayDisplay($lista_precos, "$lista_precos")

	; buscar valores iguais e reduzir para apenas uma ocorrência, somando-se a razão dos seus pares
	; após a soma dos pares devem ser deletados as ocorrências do preco procurado, em seguida reinserido o novo preço com a soma realizada
	; após realizado o for a procura de todos os pares deve-se eralizar o sort do array lista_precos e retornado a lista para salvar

	; exibindo valores antes da compactação - funcional
;~ 	ConsoleWrite("##########PREGÃO" & @CRLF)
;~ 	ConsoleWrite("Lista size antes de compactação: " & UBound($lista_precos) & @CRLF)
;~ 	For $i = 1 to (UBound($lista_precos) - 1)
;~ 		$index_preco = $lista_precos[$i][0]
;~ 		$index_razao = $lista_precos[$i][1]
;~ 		ConsoleWrite("PRECO: " & $index_preco &" <-> "& "RAZÃO: " & $index_razao & @CRLF)
;~ 	Next

;~ 	ConsoleWrite("##########OCORRÊNCIAS" & @CRLF)
	; compactando valores - funcional (VALORES ABSOLUTOS)
	For $i = 1 to (UBound($lista_precos) - 1)
		$index_preco = $lista_precos[$i][0]
		If _ArraySearch($ja_pesquisados, $index_preco) <> -1 Then
			ContinueLoop
		Else
			$find_index_lista = _ArrayFindAll($lista_precos, $index_preco)
;~ 			ConsoleWrite("Indices encontrados (" & $index_preco & ") -> " & _ArrayToString($find_index_lista, "-> ") & @CRLF)
			For $j = 0 to (UBound($find_index_lista) - 1)
				$razao_total += Round($lista_precos[$find_index_lista[$j]][1], 7)
			Next
			$par[0][0] = $index_preco
			$par[0][1] = Abs($razao_total)
			_ArrayAdd($nova_lista_soma, $par)
;~ 			ConsoleWrite("PREÇO " & $index_preco & " <> SOMA TOTAL: " & $razao_total & @CRLF)
			$razao_total = 0
			Sleep(10)
		EndIf
		_ArrayAdd($ja_pesquisados, $index_preco)
;~ 		ConsoleWrite(UBound($find_index_lista) & " ocorrências." & @CRLF)
;~ 		ConsoleWrite("--------------------------------------------------" & @CRLF)
		Sleep(10)
	Next

;~ 	ConsoleWrite("##########COMPACTADA" & @CRLF)
	; exibindo valores após compactação - funcional
;~ 	ConsoleWrite("Lista size após de compactação: " & UBound($nova_lista) & @CRLF)
;~ 	For $i = 0 to (UBound($nova_lista_soma) - 1)
;~ 		$index_preco = $nova_lista_soma[$i][0]
;~ 		$index_razao = $nova_lista_soma[$i][1]
;~ 		ConsoleWrite("PRECO: " & $index_preco &" <-> "& "RAZÃO: " & $index_razao & @CRLF)
;~ 	Next
;~ 	ConsoleWrite("##########" & @CRLF)

	; retornando a lista (preço e razão) com valores já ordenados
	_ArraySort($nova_lista_soma, 1)

	Return $nova_lista_soma

EndFunc   ;==>_SomarPares()
;---------------------------------------------------------------------------------


; _SalvarTime()
Func _SalvarTime($path, $times, $file)

	Local $path_pasta_pregoes = @ScriptDir & "\Leituras\" & $path & "\" & $file


	; Open the file for writing (append to the end of a file) and store the handle to a variable.
    Local $hFileOpen = FileOpen($path_pasta_pregoes, $FO_APPEND)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
        Return False
    EndIf

	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "STATUS", "FALHA AO SALVAR ARQUIVO.", 2)
		Return 0
	Else
		If $path_pasta_pregoes <> ".txt" Then
			FileWrite($path_pasta_pregoes, ">>>>>>>>>>	"& $times &"	>>>>>>>>>>" & @CRLF)
			Return 1
		EndIf
		Return 0
	EndIf

EndFunc   ;==>_SalvarTime()
;-------------------------------------------------------------------------


; _SalvarParametros()
Func _SalvarParametros($path, $lista_from_coleta, $nome_salvamento)

	Local $path_pasta_pregoes = @ScriptDir & "\Leituras\" & $path & "\"

;~ 	$arqsaved = FileSaveDialog("SALVAR PREGÃO", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.txt)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "wdo")
	$arqsaved = FileSaveDialog("SALVAR PREGÃO", $path_pasta_pregoes, "params (*.txt)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "wdo")

;~ 	MsgBox($MB_SYSTEMMODAL, "$arqsaved", $arqsaved, 2)

	; Retrieve the filename from the filepath e.g. Example.txt.
	Local $sFileName = StringTrimLeft($arqsaved, StringInStr($arqsaved, "\", $STR_NOCASESENSEBASIC, -1))

	; Check if the extension .txt is appended to the end of the filename.
	Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSEBASIC)

	; If a period (dot) is found then check whether or not the extension is equal to .txt.
	If $iExtension Then
		; If the extension isn't equal to .txt then append to the end of the filepath.
		If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".txt") Then
			$arqsaved &= ".txt"
		EndIf
	Else
		; If no period (dot) was found then append to the end of the file.
		$arqsaved &= ".txt"
	EndIf

	; Open the file for writing (append to the end of a file) and store the handle to a variable.
    Local $hFileOpen = FileOpen($arqsaved, $FO_APPEND)
    If $hFileOpen = -1 Then
        MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
        Return False
    EndIf

	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "STATUS", "FALHA AO SALVAR ARQUIVO.", 2)
		Return 0
	Else
		If $arqsaved <> ".txt" Then
			FileWrite($arqsaved, ">>>>>>>>>>	"& $nome_salvamento &"	>>>>>>>>>>" & @CRLF)
			Local $size_i = UBound($lista_from_coleta, 1) - 1 ; size_i = nº de linhas (ROWS)
			For $i = 0 to $size_i
				Local $size_j = UBound($lista_from_coleta, 2) - 1 ; size_j = nº de colunas (COLUMNS)
				For $j = 0 to $size_j
					Local $index = $lista_from_coleta[$i][$j]
					FileWrite($arqsaved, "	-> " & $index)
				Next
				FileWrite($arqsaved, @CRLF)
			Next
			FileWrite($arqsaved, "<<<<<<<<<<" & @CRLF)
;~ 			ConsoleWrite($nome_salvamento & " - SALVA COM SUCESSO!" & @CRLF)
			MsgBox($MB_SYSTEMMODAL, "RESULTADO", $nome_salvamento & " - SALVA COM SUCESSO!" & @CRLF & $path_pasta_pregoes & @CRLF, 2)
;~ 			MsgBox($MB_SYSTEMMODAL, "$arqsaved", $arqsaved & @CRLF, 2)
			Return 1
		EndIf
		Return 0
	EndIf

EndFunc   ;==>_SalvarParametros
;-------------------------------------------------------------------------