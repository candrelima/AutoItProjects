#include <Array.au3>
#include <File.au3>
#include <ButtonConstants.au3>
#include <ProgressConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <Misc.au3>
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <Date.au3>
#include <Timers.au3>
#include "5-Cores.au3"

#Region ; ELEMENTOS
Local $hDLL = DllOpen("user32.dll")
Global $Form1, $Groupcontroles, $Buttonprimeiro, $Buttonanterior, $Inputlocalizar, $Buttonlocalizar, $Buttonproximo, _
		$Buttonultimo, $Progress, $Labelprogresso, $Buttoncima, $Buttonbaixo, $Sliderfotos, $Labeltotaldeimagens, _
		$Labelqtdimagens, $Sliderzoom, $Labelzoom, $Labelqtdzoom, $Listimagens, $Labeltimer, $Checkboxefeito, $Labelefeito, $Pic
Global $Groupcapturando, $Tabcoords, $COORDSCOMPRA, $COORDSVENDA, _
		$Buttonmilharc, $Buttoncentenac, $Buttondezenac, $Buttonunidadec, $Buttoncentavoc, $Buttonqtddezc, $Buttonqtdunidc, $Buttoncampoc, _
		$Buttonmilharv, $Buttoncentenav, $Buttondezenav, $Buttonunidadev, $Buttoncentavov, $Buttonqtddezv, $Buttonqtdunidv, $Buttoncampov, _
		$Buttondistordem
Global $Labelplaca1MC, $Labelplaca2MC, $Labelplaca3MC, $Labelplaca4MC, $Labelplaca5MC, $Labelplaca6MC, $Labelplaca7MC, _
		$Labelplaca1CC, $Labelplaca2CC, $Labelplaca3CC, $Labelplaca4CC, $Labelplaca5CC, $Labelplaca6CC, $Labelplaca7CC, _
		$Labelplaca1DC, $Labelplaca2DC, $Labelplaca3DC, $Labelplaca4DC, $Labelplaca5DC, $Labelplaca6DC, $Labelplaca7DC, _
		$Labelplaca1UC, $Labelplaca2UC, $Labelplaca3UC, $Labelplaca4UC, $Labelplaca5UC, $Labelplaca6UC, $Labelplaca7UC, _
		$Labelplaca1CEC, $Labelplaca2CEC, $Labelplaca3CEC, $Labelplaca4CEC, $Labelplaca5CEC, $Labelplaca6CEC, $Labelplaca7CEC, _
		$Labelplaca1QTDDC, $Labelplaca2QTDDC, $Labelplaca3QTDDC, $Labelplaca4QTDDC, $Labelplaca5QTDDC, $Labelplaca6QTDDC, $Labelplaca7QTDDC, _
		$Labelplaca1QTDUC, $Labelplaca2QTDUC, $Labelplaca3QTDUC, $Labelplaca4QTDUC, $Labelplaca5QTDUC, $Labelplaca6QTDUC, $Labelplaca7QTDUC, _
		$Labelplaca1CORC, $Labelplaca2CORC, $Labelplaca1distordem, $Labelplaca2distordem, $Buttonmilharv, _
		$Labelplaca1MV, $Labelplaca2MV, $Labelplaca3MV, $Labelplaca4MV, $Labelplaca5MV, $Labelplaca6MV, $Labelplaca7MV, _
		$Labelplaca1CV, $Labelplaca2CV, $Labelplaca3CV, $Labelplaca4CV, $Labelplaca5CV, $Labelplaca6CV, $Labelplaca7CV, _
		$Labelplaca1DV, $Labelplaca2DV, $Labelplaca3DV, $Labelplaca4DV, $Labelplaca5DV, $Labelplaca6DV, $Labelplaca7DV, _
		$Labelplaca1UV, $Labelplaca2UV, $Labelplaca3UV, $Labelplaca4UV, $Labelplaca5UV, $Labelplaca6UV, $Labelplaca7UV, _
		$Labelplaca1CEV, $Labelplaca2CEV, $Labelplaca3CEV, $Labelplaca4CEV, $Labelplaca5CEV, $Labelplaca6CEV, $Labelplaca7CEV, _
		$Labelplaca1QTDDV, $Labelplaca2QTDDV, $Labelplaca3QTDDV, $Labelplaca4QTDDV, $Labelplaca5QTDDV, $Labelplaca6QTDDV, $Labelplaca7QTDDV, _
		$Labelplaca1QTDUV, $Labelplaca2QTDUV, $Labelplaca3QTDUV, $Labelplaca4QTDUV, $Labelplaca5QTDUV, $Labelplaca6QTDUV, $Labelplaca7QTDUV, _
		$Labelplaca1CORV, $Labelplaca2CORV, $Labelvalor, $Labelqtd, $Labelprice, $Labelmediana, $Labelshadowb, $Labelshadows, _
		$Labelask, $Labelbid, $Labelpriceask, $Labelpricebid
Global $Buttonhideshowg1, $Buttonhideshowg2, $Buttonpasta, $Buttoniniciar, $Buttonabrirmapa, _
		$Buttonsalvarmapa, $Buttonteste, $Buttonsair
#EndRegion

#Region ; VARIÁVEIS
Global $localDir, $img, $dirpasta, $pasta, $path, $Progressler, $distY = 123
Global $fileList
Global $maxItens, $files, $loop = 0, $zoom, $posicaohora, _
		$LargForm = 1209, $compForm = 681, $X, $Y, $posY, $hide, $hide2
Global $diretorio, $diretorio2, $hGraphics, $g_hBitmap, $g_hGfxCtxt, $hImage, $iBgColor = 0x303030, $aDim[2], _
		$efeitizar, $raio, $grandeza, $brilho, $contraste
Global $coordsmilharc[14], $coordscentenac[14], $coordsdezenac[14], $coordsunidadec[14], $coordscentavoc[14], $coordscorc[4], _
		$coordsmilharv[14], $coordscentenav[14], $coordsdezenav[14], $coordsunidadev[14], $coordscentavov[14], $coordscorv[4], _
		$coordsqtddezc[14], $coordsqtdunidc[14], $coordsqtddezv[14], $coordsqtdunidv[14], $coordsdist[4], $coordsconexao
Global $leep = 20, $beep = 1440, $messageErro = ""

Global $DadosOrdens, $DadosEstudoGeral, $DadosCandle, $play = True, $Ordem = 0

Global $ordemcompra = 0, $ordemvenda = 0, $qtdcompra[2], $qtdvenda[2]
Global $hascompra = 0, $hasvenda = 0, $buy = 0, $sell = 0, $timeimg
Global $saved1 = 0, $saved2 = 0, $saved3 = 0
Global $mediana_venda = 0, $mediana_compra = 10000, _
		$Buy2mediana = 0, $Sell2mediana = 0, $Buy2medianaGeral = 0, $Sell2medianaGeral = 0, $medianaGeral = 0, _
		$somatorioQtdCompra = 0, $somatorioQtdVenda = 0, $somatorioQtdCompraTotal = 0, $somatorioQtdVendaTotal = 0, _
		$medianaGeralMin = 10000, $medianaGeralMax = 0

Global $arrayLotesCompra[20], $arrayLotesVenda[20], $minimo = 100, $maximo = -100 ; NON-ZERO SUM
Global $Buy2shadow = 0, $Sell2shadow = 0, $BuySum = 0, $SellSum = 0, $shadowPriceB = 0, $shadowPriceS = 0 ; SHADOW PRICE
Global $min = 10000, $max = 0, $open = 0, $close = 0, $ciclo = 0
Global $amountc, $amountv
Global $cotacoes = [False, False], $markInicial, $markFinal, $playRead, $candle[4], $abertura
Global $g_hTimer, $g_iSecs, $g_iMins, $g_iHour, $g_sTime
#EndRegion


;------------------------------------------ FUNÇOES
; _PararMarket()
Func _PararMarket()

	$playRead = False
	While _IsPressed("71", $hDLL)
		Sleep(10)
	WEnd

EndFunc   ;==>_PararMarket()
;-------------------------------------------------------------------------


; _capturarPlaca()
Func _capturarPlaca($botao)

	Local $allcoords[14], $out = False, $posicao[2]

	While Not $out

		Sleep(15)
		$posicao = _HasPlaca()

		If _IsPressed("31", $hDLL) Then
			$allcoords[0] = $posicao[0]
			$allcoords[1] = $posicao[1]
			While _IsPressed("31", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 1)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("32", $hDLL) Then
			$allcoords[2] = $posicao[0]
			$allcoords[3] = $posicao[1]
			While _IsPressed("32", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 2)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("33", $hDLL) Then
			$allcoords[4] = $posicao[0]
			$allcoords[5] = $posicao[1]
			While _IsPressed("33", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 3)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("34", $hDLL) Then
			$allcoords[6] = $posicao[0]
			$allcoords[7] = $posicao[1]
			While _IsPressed("34", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 4)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("35", $hDLL) Then
			$allcoords[8] = $posicao[0]
			$allcoords[9] = $posicao[1]
			While _IsPressed("35", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 5)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("36", $hDLL) Then
			$allcoords[10] = $posicao[0]
			$allcoords[11] = $posicao[1]
			While _IsPressed("36", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 6)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("37", $hDLL) Then
			$allcoords[12] = $posicao[0]
			$allcoords[13] = $posicao[1]
			While _IsPressed("37", $hDLL)
				; MODIFICANDO LABEL
				_LoadLabelVisual($botao, $posicao, 7)
				Sleep($leep)
			WEnd
		EndIf
		If _IsPressed("30", $hDLL) Then
			Local $resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
				ToolTip("", "", "", "", $TIP_NOICON)
			EndIf
			While _IsPressed("30", $hDLL)
				Sleep($leep)
			WEnd
		EndIf

	WEnd ; SAIR SE $out = TRUE

	Return $allcoords

EndFunc   ;==>_capturarPlaca()
;-------------------------------------------------------------------------


; _HasPlaca()
Func _HasPlaca()

	Local $placa[2]
	Local $pos = MouseGetPos()
	$cor = "0x" & Hex(PixelGetColor($pos[0], $pos[1]), 6)
	If $cor == "0xFFFFFF" Or $cor == "0xE6E6E6" Then ; $COR_PLACA ou $COR_RELOGIO
		ToolTip($pos[0] & " x " & $pos[1], $pos[0] + 30, $pos[1], "PLACA", $TIP_INFOICON)
		Beep($beep, 5)
	Else
		ToolTip($pos[0] & " x " & $pos[1], $pos[0] + 30, $pos[1], $TIP_INFOICON)
	EndIf
	_ArrayPush($placa, $pos[0])
	_ArrayPush($placa, $pos[1])
	Return $placa

EndFunc ;==>_HasPlaca()
;-------------------------------------------------------------------------


; _capturarcoordsCampo()
Func _capturarcoordsCampo($tipo)

	Local $out = False, $resp

	While Not $out

		Sleep(15)
		$cor = "0x" & Hex(PixelGetColor(MouseGetPos(0), MouseGetPos(1)), 6)
		ToolTip("", MouseGetPos(0), MouseGetPos(1), "")
		Sleep($leep)

		If $cor == "0x0000FF" Then ; $COR_COMPRA
			ToolTip("0x0000FF" & MouseGetPos(0) &"x"& MouseGetPos(1), MouseGetPos(0), MouseGetPos(1), "COMPRA", $TIP_INFOICON)
;~ 			Beep($beep, 5)
			Sleep($leep)
		EndIf
		If $cor == "0xFF0000" Then ; $COR_VENDA
			ToolTip("0xFF0000" & MouseGetPos(0) &"x"& MouseGetPos(1), MouseGetPos(0), MouseGetPos(1), "VENDA", $TIP_INFOICON)
;~ 			Beep($beep, 5)
			Sleep($leep)
		EndIf
		If $tipo = "CAMPO COMPRA" Then ; CAMPO COMPRA
			If _IsPressed("31", $hDLL) Then
				$coordscorc[0] = MouseGetPos(0)
				$coordscorc[1] = MouseGetPos(1)
				$coordscorc[2] = Int(MouseGetPos(0)) + 1
				$coordscorc[3] = Int(MouseGetPos(1)) + 1
				GUICtrlSetData($Labelplaca1CORC, $coordscorc[0]&" x "&$coordscorc[1])
				GUICtrlSetData($Labelplaca2CORC, $coordscorc[2]&" x "&$coordscorc[3])
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "CAMPO VENDA" Then ; CAMPO COMPRA
			If _IsPressed("31", $hDLL) Then
				$coordscorv[0] = MouseGetPos(0)
				$coordscorv[1] = MouseGetPos(1)
				$coordscorv[2] = Int(MouseGetPos(0)) + 1
				$coordscorv[3] = Int(MouseGetPos(1)) + 1
				GUICtrlSetData($Labelplaca1CORV, $coordscorv[0]&" x "&$coordscorv[1])
				GUICtrlSetData($Labelplaca2CORV, $coordscorv[2]&" x "&$coordscorv[3])
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "DISTANCIA ORDEM" Then ; DISTANCIA
			If _IsPressed("31", $hDLL) Then
				$coordsdist[0] = MouseGetPos(0)
				$coordsdist[1] = MouseGetPos(1)
				$coordsdist[2] = Int(MouseGetPos(0)) + 1
				$coordsdist[3] = Int(MouseGetPos(1)) + 1
				GUICtrlSetData($Labelplaca1distordem, $coordsdist[0]&" x "&$coordsdist[1])
				GUICtrlSetData($Labelplaca2distordem, $coordsdist[2]&" x "&$coordsdist[3])
				Sleep($leep)
			EndIf
		EndIf

		ToolTip("", "", "", $TIP_INFOICON)
		If _IsPressed("30", $hDLL) Then
			$resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
			EndIf
		EndIf
	WEnd
	If $tipo = "CAMPO COMPRA" Then ; HORA
		Return $coordscorc
	EndIf
	If $tipo = "CAMPO VENDA" Then ; PAINEL
		Return $coordscorv
	EndIf
	If $tipo = "DISTANCIA ORDEM" Then ; CONEXAO
		Return $coordsdist
	EndIf

EndFunc   ;==>_capturarcoordsCampo()
;-------------------------------------------------------------------------


; _LoadLabelVisual()
Func _LoadLabelVisual($botao, $posicao, $num)

	Local $wait = 5
	Global $arrayLabels = [[$Labelplaca1MC, $Labelplaca2MC, $Labelplaca3MC, $Labelplaca4MC, $Labelplaca5MC, $Labelplaca6MC, $Labelplaca7MC], _ ; [0]MILHAR C
		[$Labelplaca1CC, $Labelplaca2CC, $Labelplaca3CC, $Labelplaca4CC, $Labelplaca5CC, $Labelplaca6CC, $Labelplaca7CC], _ ; [1]CENTENA C
		[$Labelplaca1DC, $Labelplaca2DC, $Labelplaca3DC, $Labelplaca4DC, $Labelplaca5DC, $Labelplaca6DC, $Labelplaca7DC], _ ; [2]DEZENAC
		[$Labelplaca1UC, $Labelplaca2UC, $Labelplaca3UC, $Labelplaca4UC, $Labelplaca5UC, $Labelplaca6UC, $Labelplaca7UC], _ ; [3]UNIDADEC
		[$Labelplaca1CEC, $Labelplaca2CEC, $Labelplaca3CEC, $Labelplaca4CEC, $Labelplaca5CEC, $Labelplaca6CEC, $Labelplaca7CEC], _ ; [4]CENTAVOC
		[$Labelplaca1QTDDC, $Labelplaca2QTDDC, $Labelplaca3QTDDC, $Labelplaca4QTDDC, $Labelplaca5QTDDC, $Labelplaca6QTDDC, $Labelplaca7QTDDC], _ ; [5]DEZ QTD C
		[$Labelplaca1QTDUC, $Labelplaca2QTDUC, $Labelplaca3QTDUC, $Labelplaca4QTDUC, $Labelplaca5QTDUC, $Labelplaca6QTDUC, $Labelplaca7QTDUC], _ ; [6]UNID QTD C
		[$Labelplaca1CORC, $Labelplaca2CORC], [$Labelplaca1distordem, $Labelplaca2distordem], _ ; [7]CORC [8]DISTORDEM
		[$Labelplaca1MV, $Labelplaca2MV, $Labelplaca3MV, $Labelplaca4MV, $Labelplaca5MV, $Labelplaca6MV, $Labelplaca7MV], _ ; [9]MILHARV
		[$Labelplaca1CV, $Labelplaca2CV, $Labelplaca3CV, $Labelplaca4CV, $Labelplaca5CV, $Labelplaca6CV, $Labelplaca7CV], _ ; [10]CENTENAV
		[$Labelplaca1DV, $Labelplaca2DV, $Labelplaca3DV, $Labelplaca4DV, $Labelplaca5DV, $Labelplaca6DV, $Labelplaca7DV], _ ; [11]DEZENAV
		[$Labelplaca1UV, $Labelplaca2UV, $Labelplaca3UV, $Labelplaca4UV, $Labelplaca5UV, $Labelplaca6UV, $Labelplaca7UV], _ ; [12]UNIDADEV
		[$Labelplaca1CEV, $Labelplaca2CEV, $Labelplaca3CEV, $Labelplaca4CEV, $Labelplaca5CEV, $Labelplaca6CEV, $Labelplaca7CEV], _ ; [13]CENTAVOV
		[$Labelplaca1QTDDV, $Labelplaca2QTDDV, $Labelplaca3QTDDV, $Labelplaca4QTDDV, $Labelplaca5QTDDV, $Labelplaca6QTDDV, $Labelplaca7QTDDV], _ ; [14]DEZ QTD V
		[$Labelplaca1QTDUV, $Labelplaca2QTDUV, $Labelplaca3QTDUV, $Labelplaca4QTDUV, $Labelplaca5QTDUV, $Labelplaca6QTDUV, $Labelplaca7QTDUV], _ ; [15]UNID QTD V
		[$Labelplaca1CORV, $Labelplaca2CORV]] ; [16]
	If $botao == "CENTAVO C" Then ;[4]
		GUICtrlSetData($arrayLabels[4][$num-1], $posicao[0]&" x "&$posicao[1]) ; CENTAVO C [4]
;~ 		GUICtrlSetData($arrayLabels[3][$num-1], $posicao[0] - (2*$distX)&" x "&$posicao[1]) ; UNIDADE C [3]
;~ 		GUICtrlSetData($arrayLabels[2][$num-1], $posicao[0] - (3*$distX)&" x "&$posicao[1]) ; DEZENA C [2]
;~ 		GUICtrlSetData($arrayLabels[1][$num-1], $posicao[0] - (4*$distX)&" x "&$posicao[1]) ; CENTENA C [1]
;~ 		GUICtrlSetData($arrayLabels[0][$num-1], $posicao[0] - (6*$distX)&" x "&$posicao[1]) ; MILHAR C [0]
		Sleep($wait)
	EndIf
	If $botao == "CENTAVO V" Then ;[13]
		GUICtrlSetData($arrayLabels[13][$num-1], $posicao[0]&" x "&$posicao[1]) ; CENTAVO V [13]
;~ 		GUICtrlSetData($arrayLabels[12][$num-1], $posicao[0] - (2*$distX)&" x "&$posicao[1]) ; UNIDADE V [12]
;~ 		GUICtrlSetData($arrayLabels[11][$num-1], $posicao[0] - (3*$distX)&" x "&$posicao[1]) ; DEZENA V [11]
;~ 		GUICtrlSetData($arrayLabels[10][$num-1], $posicao[0] - (4*$distX)&" x "&$posicao[1]) ; CENTENA V [10]
;~ 		GUICtrlSetData($arrayLabels[9][$num-1], $posicao[0] - (6*$distX)&" x "&$posicao[1]) ; MILHAR V [9]
		Sleep($wait)
	EndIf
	If $botao == "UNID QTD C" Then ;[6]
		GUICtrlSetData($arrayLabels[6][$num-1], $posicao[0]&" x "&$posicao[1]) ; UNIDADE QTD C [6]
;~ 		GUICtrlSetData($arrayLabels[5][$num-1], $posicao[0] - $distX&" x "&$posicao[1]) ; DEZENA QTD C [5]
;~ 		GUICtrlSetData($arrayLabels[1][$num-1], $posicao[0]-(2*$distX)&" x "&$posicao[1]) ; CENTENA QTD C [1]
		Sleep($wait)
	EndIf
	If $botao == "UNID QTD V" Then ;[15]
		GUICtrlSetData($arrayLabels[15][$num-1], $posicao[0]&" x "&$posicao[1]) ; UNIDADE QTD V [15]
;~ 		GUICtrlSetData($arrayLabels[14][$num-1], $posicao[0] - $distX&" x "&$posicao[1]) ; DEZENA QTD V [14]
;~ 		GUICtrlSetData($arrayLabels[10][$num-1], $posicao[0]-(2*38)&" x "&$posicao[1]) ; CENTENA QTD V [10]
		Sleep($wait)
	EndIf

	If $botao == "MILHAR C" Then ;[0]
		GUICtrlSetData($arrayLabels[0][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "CENTENA C" Then ;[1]
		GUICtrlSetData($arrayLabels[1][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "DEZENA C" Then ;[2]
		GUICtrlSetData($arrayLabels[2][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "UNIDADE C" Then ;[3]
		GUICtrlSetData($arrayLabels[3][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "DEZ QTD C" Then ;[5]
		GUICtrlSetData($arrayLabels[5][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "MILHAR V" Then ;[9]
		GUICtrlSetData($arrayLabels[9][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "CENTENA V" Then ;[10]
		GUICtrlSetData($arrayLabels[10][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "DEZENA V" Then ;[11]
		GUICtrlSetData($arrayLabels[11][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "UNIDADE V" Then ;[12]
		GUICtrlSetData($arrayLabels[12][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "DEZ QTD V" Then ;[14]
		GUICtrlSetData($arrayLabels[14][$num-1], $posicao[0]&" x "&$posicao[1])
		Sleep($wait)
	EndIf
	If $botao == "CAMPO COMPRA" Then ;[7]
		GUICtrlSetData($arrayLabels[7][0], $posicao[0]&" x "&$posicao[1])
		GUICtrlSetData($arrayLabels[7][1], $posicao[2]&" x "&$posicao[3])
		Sleep($wait)
	EndIf
	If $botao == "DISTANCIA ORDEM" Then ;[8]
		GUICtrlSetData($arrayLabels[8][0], $posicao[0]&" x "&$posicao[1])
		GUICtrlSetData($arrayLabels[8][1], $posicao[2]&" x "&$posicao[3])
		Sleep($wait)
	EndIf
	If $botao == "CAMPO VENDA" Then ;[16]
		GUICtrlSetData($arrayLabels[16][0], $posicao[0]&" x "&$posicao[1])
		GUICtrlSetData($arrayLabels[16][1], $posicao[2]&" x "&$posicao[3])
		Sleep($wait)
	EndIf

EndFunc ;==>_LoadLabelVisual()
;-------------------------------------------------------------------------


; _AbrirParametrosMapa()
Func _AbrirParametrosMapa()

	Local $bar = GUICreate("LOCALIZANDO DADOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	Local $Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, "FFF")
;~ 	$arqopened = FileOpenDialog("ABRIR PARÂMETROS", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST), "param")
	$arqopened = FileOpenDialog("ABRIR PARÂMETROS", @ScriptDir & "\", "(*.ini)", $FD_PATHMUSTEXIST, "param")

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "ERRO", "FALHA AO ABRIR ARQUIVO.")
		Return 0
	Else
		GUISetState(@SW_SHOW)

		; COMPRA
		; ---------------------------------------------------------------------------MILHARC
		$section = IniReadSection($arqopened, "coordsmilharc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsmilharc, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("MILHAR C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsmilharc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonmilharc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonmilharc, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 5)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharc, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsmilharc - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------CENTENAC
		$section = IniReadSection($arqopened, "coordscentenac")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentenac, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("CENTENA C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordscentenac, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncentenac, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentenac, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 10)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentenac, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordscentenac - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------DEZENAC
		$section = IniReadSection($arqopened, "coordsdezenac")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsdezenac, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("DEZENA C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsdezenac, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondezenac, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondezenac, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 15)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenac, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsdezenac - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------UNIDADEC
		$section = IniReadSection($arqopened, "coordsunidadec")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsunidadec, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("UNIDADE C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsunidadec, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonunidadec, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonunidadec, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 20)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadec, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsunidadec - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------CENTAVOC
		$section = IniReadSection($arqopened, "coordscentavoc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentavoc, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("CENTAVO C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordscentavoc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncentavoc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentavoc, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 25)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentavoc, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordscentavoc - FALHA." & @CRLF
		EndIf
		#EndRegion ; COMPRA
		#Region ; VENDA
		; ---------------------------------------------------------------------------MILHARV
		$section = IniReadSection($arqopened, "coordsmilharv")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsmilharv, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("MILHAR V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsmilharv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonmilharv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonmilharv, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 30)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharv, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsmilharv - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------CENTENAV
		$section = IniReadSection($arqopened, "coordscentenav")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentenav, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("CENTENA V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordscentenav, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncentenav, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentenav, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 35)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentenav, 0xFF0000) ; COLOR_RED)
			$messageErro += "COORDENADAS DA coordscentenav - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------DEZENAV
		$section = IniReadSection($arqopened, "coordsdezenav")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsdezenav, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("DEZENA V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsdezenav, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondezenav, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondezenav, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 40)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenav, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsdezenav - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------UNIDADEV
		$section = IniReadSection($arqopened, "coordsunidadev")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsunidadev, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("UNIDADE V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsunidadev, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonunidadev, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonunidadev, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 45)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadev, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsunidadev - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------CENTAVOV
		$section = IniReadSection($arqopened, "coordscentavov")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentavov, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("CENTAVO V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordscentavov, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncentavov, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentavov, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 50)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentavov, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordscentavov - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------CAMPO COMPRA
		$section = IniReadSection($arqopened, "coordscorc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordscorc, Int($section[1][1]))
			_ArrayPush($coordscorc, Int($section[2][1]))
			_ArrayPush($coordscorc, Int($section[3][1]))
			_ArrayPush($coordscorc, Int($section[4][1]))
			_LoadLabelVisual("CAMPO COMPRA", $coordscorc, 0)
			If Not UBound(_ArrayFindAll($coordscorc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncampoc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncampoc, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 55)
			Sleep($leep)
;~ 			_ArrayDisplay($coordscentenav, "$coordscentenav")
		Else
			GUICtrlSetBkColor($Buttoncampoc, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS coordscorc - FALHA." & @CR
		EndIf
		; ---------------------------------------------------------------------------CAMPO VENDA
		$section = IniReadSection($arqopened, "coordscorv")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordscorv, Int($section[1][1]))
			_ArrayPush($coordscorv, Int($section[2][1]))
			_ArrayPush($coordscorv, Int($section[3][1]))
			_ArrayPush($coordscorv, Int($section[4][1]))
			_LoadLabelVisual("CAMPO VENDA", $coordscorv, 0)
			If Not UBound(_ArrayFindAll($coordscorv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncampov, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncampov, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 60)
			Sleep($leep)
;~ 			_ArrayDisplay($coordscorv, "$coordscorv")
		Else
			GUICtrlSetBkColor($Buttoncampov, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS coordscorv - FALHA." & @CR
		EndIf
		; ---------------------------------------------------------------------------DISTANCIA ORDEM
		$section = IniReadSection($arqopened, "coordsdist")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordsdist, Int($section[1][1]))
			_ArrayPush($coordsdist, Int($section[2][1]))
			_ArrayPush($coordsdist, Int($section[3][1]))
			_ArrayPush($coordsdist, Int($section[4][1]))
			_LoadLabelVisual("DISTANCIA ORDEM", $coordsdist, 0)
			If Not UBound(_ArrayFindAll($coordsdist, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondistordem, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondistordem, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 65)
			Sleep($leep)
;~ 			_ArrayDisplay($coordsdist, "$coordsdist")
		Else
			GUICtrlSetBkColor($Buttondistordem, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS coordsdist - FALHA." & @CR
		EndIf
		; ---------------------------------------------------------------------------DEZ QTD COMPRA
		$section = IniReadSection($arqopened, "coordsqtddezc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtddezc, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("DEZ QTD C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsqtddezc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtddezc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtddezc, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 70)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonqtddezc, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsqtddezc - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------UNID QTD COMPRA
		$section = IniReadSection($arqopened, "coordsqtdunidc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdunidc, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("UNID QTD C", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsqtdunidc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtdunidc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtdunidc, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 75)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonqtdunidc, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsqtdunidc - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------DEZ QTD VENDA
		$section = IniReadSection($arqopened, "coordsqtddezv")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtddezv, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("DEZ QTD V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsqtddezv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtddezv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtddezv, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 80)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonqtddezv, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsqtddezv - FALHA." & @CRLF
		EndIf
		; ---------------------------------------------------------------------------UNID QTD VENDA
		$section = IniReadSection($arqopened, "coordsqtdunidv")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			Local $posicao[2], $ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdunidv, $section[$i][1])
				_ArrayAdd($posicao, $section[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadLabelVisual("UNID QTD V", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
			If Not UBound(_ArrayFindAll($coordsqtdunidv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtdunidv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtdunidv, 0x8B1C62) ; COLOR_RED
			EndIf
			GUICtrlSetData($Progressler, 100)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonqtdunidv, 0xFF0000) ; COLOR_RED
			$messageErro += "COORDENADAS DA coordsqtdunidv - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- CONCLUSÃO -----
		If GUICtrlRead($Progressler) == 100 Then
			MsgBox(48, "RESUMO DA LEITURA", "DADOS 100% LIDOS COM SUCESSO.", 1)
			GUIDelete($bar)
			Return 1
		Else
			MsgBox(48, "RESUMO DA LEITURA", $messageErro)
			GUIDelete($bar)
			Return 0
		EndIf
	EndIf

EndFunc   ;==>_AbrirParametrosMapa()
;-------------------------------------------------------------------------


; _SalvarParametros()
Func _SalvarParametros()

	Local $bar = GUICreate("MAPA DE PARÂMETROS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	Local $Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, 32250)

;~ 	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")
	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS LEITURA", @ScriptDir & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")

	; Retrieve the filename from the filepath e.g. Example.ini.
	Local $sFileName = StringTrimLeft($arqsaved, StringInStr($arqsaved, "\", $STR_NOCASESENSEBASIC, -1))
	; Check if the extension .ini is appended to the end of the filename.
	Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSEBASIC)
	; If a period (dot) is found then check whether or not the extension is equal to .ini.
	If $iExtension Then
		; If the extension isn't equal to .ini then append to the end of the filepath.
		If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".ini") Then
			$arqsaved &= ".ini"
		EndIf
	Else
		; If no period (dot) was found then append to the end of the file.
		$arqsaved &= ".ini"
	EndIf

	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "ERRO", "FALHA AO SALVAR ARQUIVO.")
		Return 0
	Else

		MsgBox(48, "ALERTA DADOS", "ATENÇÃO: Este processo realizará o salvamento das"  & @CR & _
				"coordenadas mesmo que estejam incompletas." & @CR & _
				"Por gentileza, realizar a conferência de todas" & @CR & _
				"as coordenadas antes de salvar para" & @CR & _
				"garantir o processo corretamente." & @CR & _
				$arqsaved)

		GUISetState(@SW_SHOW)

		; COMPRA
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsmilharc", String($i + 1), $coordsmilharc[$i])
;~ 			ConsoleWrite("$coordsmilharc salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsmilharc, "MILHAR C")
			GUICtrlSetData($Progressler, 5)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordscentenac", String($i + 1), $coordscentenac[$i])
;~ 			ConsoleWrite("$coordscentenac salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscentenac, "CENTENA C")
			GUICtrlSetData($Progressler, 10)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsdezenac", String($i + 1), $coordsdezenac[$i])
;~ 			ConsoleWrite("$coordsdezenac salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsdezenac, "DEZENA C")
			GUICtrlSetData($Progressler, 15)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsunidadec", String($i + 1), $coordsunidadec[$i])
;~ 			ConsoleWrite("$coordsunidadec salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsunidadec, "UNIDADE C")
			GUICtrlSetData($Progressler, 20)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordscentavoc", String($i + 1), $coordscentavoc[$i])
;~ 			ConsoleWrite("$coordscentavoc salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscentavoc, "CENTAVO C")
			GUICtrlSetData($Progressler, 25)
		; VENDA
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsmilharv", String($i + 1), $coordsmilharv[$i])
;~ 			ConsoleWrite("$coordsmilharv salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsmilharv, "MILHAR V")
			GUICtrlSetData($Progressler, 40)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordscentenav", String($i + 1), $coordscentenav[$i])
;~ 			ConsoleWrite("$coordscentenav salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscentenav, "CENTENA V")
			GUICtrlSetData($Progressler, 45)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsdezenav", String($i + 1), $coordsdezenav[$i])
;~ 			ConsoleWrite("$coordsdezenav salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsdezenav, "DEZENA V")
			GUICtrlSetData($Progressler, 50)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsunidadev", String($i + 1), $coordsunidadev[$i])
;~ 			ConsoleWrite("$coordsunidadev salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsunidadev, "UNIDADE V")
			GUICtrlSetData($Progressler, 55)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordscentavov", String($i + 1), $coordscentavov[$i])
;~ 			ConsoleWrite("$coordscentavov salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscentavov, "CENTAVO V")
			GUICtrlSetData($Progressler, 60)
		For $i = 0 To 3 Step 1
			IniWrite($arqsaved, "coordscorc", String($i + 1), $coordscorc[$i])
;~ 			ConsoleWrite("$coordscorc salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscorc, "COR C")
			GUICtrlSetData($Progressler, 65)
		For $i = 0 To 3 Step 1
			IniWrite($arqsaved, "coordscorv", String($i + 1), $coordscorv[$i])
;~ 			ConsoleWrite("$coordscorv salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordscorv, "COR V")
			GUICtrlSetData($Progressler, 70)
		For $i = 0 To 3 Step 1
			IniWrite($arqsaved, "coordsdist", String($i + 1), $coordsdist[$i])
;~ 			ConsoleWrite("$coordsdist salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsdist, "DISTANCIA ORDEM")
			GUICtrlSetData($Progressler, 75)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsqtddezc", String($i + 1), $coordsqtddezc[$i])
;~ 			ConsoleWrite("$coordsqtddezc salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsqtddezc, "DEZ QTD C")
			GUICtrlSetData($Progressler, 30)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsqtdunidc", String($i + 1), $coordsqtdunidc[$i])
;~ 			ConsoleWrite("$coordsqtdunidc salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsqtdunidc, "UNID QTD C")
			GUICtrlSetData($Progressler, 35)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsqtddezv", String($i + 1), $coordsqtddezv[$i])
;~ 			ConsoleWrite("$coordsqtddezv salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsqtddezv, "DEZ QTD V")
			GUICtrlSetData($Progressler, 80)
		For $i = 0 To 13 Step 1
			IniWrite($arqsaved, "coordsqtdunidv", String($i + 1), $coordsqtdunidv[$i])
;~ 			ConsoleWrite("$coordsqtdunidv salvo com sucesso!"&$i&@CRLF)
			Sleep(5)
		Next
;~ 			_ArrayDisplay($coordsqtdunidv, "UNID QTD V")
			GUICtrlSetData($Progressler, 100)
		MsgBox($MB_SYSTEMMODAL, "SALVAMENTO DE DADOS", "DADOS SALVOS COM SUCESSO." & @CRLF & $arqsaved, 1)

		GUIDelete($bar)
		Return 1
	EndIf

EndFunc   ;==>_SalvarParametros
;-------------------------------------------------------------------------


; _RedrawBotoes()
Func _RedrawBotoes()

	Local $array3 = [$Buttonhideshowg1, $Buttonhideshowg2, $Buttonpasta, $Buttoniniciar, _
					$Buttonabrirmapa, $Buttonsalvarmapa, $Buttonteste, $Buttonsair, $Checkboxefeito]

	For $i = 0 To UBound($array3) - 1 Step 1
		GUICtrlSetState($array3[$i], $GUI_DISABLE)
		GUICtrlSetState($array3[$i], $GUI_HIDE)
	Next
	For $i = 0 To UBound($array3) - 1 Step 1
		GUICtrlSetState($array3[$i], $GUI_ENABLE)
		GUICtrlSetState($array3[$i], $GUI_SHOW)
	Next


EndFunc		;==>_RedrawBotoes()
;-------------------------------------------------------------------------


; _HideControles1()
Func _HideControles1($hide)

	#Region ; ARRAY1
	Local $array1 = [$Groupcontroles, $Buttonprimeiro, $Buttonanterior, $Inputlocalizar, $Buttonlocalizar, $Buttonproximo, _
					$Buttonultimo, $Progress, $Labelprogresso, $Buttoncima, $Buttonbaixo, $Sliderfotos, $Labeltotaldeimagens, _
					$Labelqtdimagens, $Sliderzoom, $Labelzoom, $Labelqtdzoom, $Listimagens, $Checkboxefeito, $Labelefeito]
	#EndRegion

	If $hide Then
		For $i = 0 To UBound($array1) - 1 Step 1
			GUICtrlSetState($array1[$i], $GUI_DISABLE)
			GUICtrlSetState($array1[$i], $GUI_HIDE)
		Next
		$hide = True
	Else
		For $i = 0 To UBound($array1) - 1 Step 1
			GUICtrlSetState($array1[$i], $GUI_ENABLE)
			GUICtrlSetState($array1[$i], $GUI_SHOW)
		Next
		$hide = False
	EndIf
	Return $hide

EndFunc		;==>_HideControles1()
;-------------------------------------------------------------------------


; _HideControles2()
Func _HideControles2($hide2)

	#Region ; ARRAY2
	Local $array2 = [$Groupcapturando, $Tabcoords, $COORDSCOMPRA, $COORDSVENDA, _
	$Buttonmilharc, $Buttoncentenac, $Buttondezenac, $Buttonunidadec,$Buttoncentavoc, $Buttonqtddezc, $Buttonqtdunidc, $Buttoncampoc, $Buttondistordem, _
	$Buttonmilharv, $Buttoncentenav, $Buttondezenav, $Buttonunidadev,$Buttoncentavov, $Buttonqtddezv, $Buttonqtdunidv, $Buttoncampov, _
	$Labelplaca1MC, $Labelplaca2MC, $Labelplaca3MC, $Labelplaca4MC, $Labelplaca5MC, $Labelplaca6MC, $Labelplaca7MC, _
	$Labelplaca1CC, $Labelplaca2CC, $Labelplaca3CC, $Labelplaca4CC, $Labelplaca5CC, $Labelplaca6CC, $Labelplaca7CC, _
	$Labelplaca1DC, $Labelplaca2DC, $Labelplaca3DC, $Labelplaca4DC, $Labelplaca5DC, $Labelplaca6DC, $Labelplaca7DC, _
	$Labelplaca1UC, $Labelplaca2UC, $Labelplaca3UC, $Labelplaca4UC, $Labelplaca5UC, $Labelplaca6UC, $Labelplaca7UC, _
	$Labelplaca1CEC, $Labelplaca2CEC, $Labelplaca3CEC, $Labelplaca4CEC, $Labelplaca5CEC, $Labelplaca6CEC, $Labelplaca7CEC, _
	$Labelplaca1QTDDC, $Labelplaca2QTDDC, $Labelplaca3QTDDC, $Labelplaca4QTDDC, $Labelplaca5QTDDC, $Labelplaca6QTDDC, $Labelplaca7QTDDC, _
	$Labelplaca1QTDUC, $Labelplaca2QTDUC, $Labelplaca3QTDUC, $Labelplaca4QTDUC, $Labelplaca5QTDUC, $Labelplaca6QTDUC, $Labelplaca7QTDUC, _
	$Labelplaca1CORC, $Labelplaca2CORC, $Labelplaca1distordem, $Labelplaca2distordem, _
	$Labelplaca1MV, $Labelplaca2MV, $Labelplaca3MV, $Labelplaca4MV, $Labelplaca5MV, $Labelplaca6MV, $Labelplaca7MV, _
	$Labelplaca1CV, $Labelplaca2CV, $Labelplaca3CV, $Labelplaca4CV, $Labelplaca5CV, $Labelplaca6CV, $Labelplaca7CV, _
	$Labelplaca1DV, $Labelplaca2DV, $Labelplaca3DV, $Labelplaca4DV, $Labelplaca5DV, $Labelplaca6DV, $Labelplaca7DV, _
	$Labelplaca1UV, $Labelplaca2UV, $Labelplaca3UV, $Labelplaca4UV, $Labelplaca5UV, $Labelplaca6UV, $Labelplaca7UV, _
	$Labelplaca1CEV, $Labelplaca2CEV, $Labelplaca3CEV, $Labelplaca4CEV, $Labelplaca5CEV, $Labelplaca6CEV, $Labelplaca7CEV, _
	$Labelplaca1QTDDV, $Labelplaca2QTDDV, $Labelplaca3QTDDV, $Labelplaca4QTDDV, $Labelplaca5QTDDV, $Labelplaca6QTDDV, $Labelplaca7QTDDV, _
	$Labelplaca1QTDUV, $Labelplaca2QTDUV, $Labelplaca3QTDUV, $Labelplaca4QTDUV, $Labelplaca5QTDUV, $Labelplaca6QTDUV, $Labelplaca7QTDUV, _
	$Labelplaca1CORV, $Labelplaca2CORV]
	#EndRegion

	If $hide2 Then
		For $i = 0 To UBound($array2) - 1 Step 1
			GUICtrlSetState($array2[$i], $GUI_DISABLE)
			GUICtrlSetState($array2[$i], $GUI_HIDE)
		Next
		$hide2 = True
	Else
		For $i = 0 To UBound($array2) - 1 Step 1
			GUICtrlSetState($array2[$i], $GUI_ENABLE)
			GUICtrlSetState($array2[$i], $GUI_SHOW)
		Next
		$hide2 = False
	EndIf
	Return $hide2

EndFunc		;==>_HideControles2()
;-------------------------------------------------------------------------


; _ContrasteImg()
Func _ContrasteImg($path, $zoom, $move, $efeito)

	Sleep(5)
;~ 	ConsoleWrite($efeito&@CRLF)
	_GDIPlus_Startup() ;initialize GDI+
	Local $zom = $zoom, $posY = $move
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($Form1)
	_GDIPlus_GraphicsClear($hGraphics, 0xFF000000 + $iBgColor) ; clear bitmap for repaint
	$hImage = _GDIPlus_ImageLoadFromFile($path)
	$aDim = _GDIPlus_ImageGetDimension($hImage)
	$g_hBitmap = _GDIPlus_BitmapCreateFromGraphics($aDim[0], $aDim[1], $hGraphics)
	$g_hGfxCtxt = _GDIPlus_ImageGetGraphicsContext($g_hBitmap)
	$X = $aDim[0] * $zom
	$Y = $aDim[1] * $zom
;~ 	$Y = 370 * $zom
;~ 	$Y = 884 * $zom
	If $efeito Then
		_GDIPlus_BitmapSetResolution($hImage, 300, 300)
		$hEffectSharpen = _GDIPlus_EffectCreateSharpen(5, 50)
		_GDIPlus_BitmapApplyEffect($hImage, $hEffectSharpen)
		$hEffectContrast = _GDIPlus_EffectCreateBrightnessContrast(100, 100)
		_GDIPlus_BitmapApplyEffect($hImage, $hEffectContrast)
		ConsoleWrite("Aplicou efeito!"&@CRLF)
	EndIf
;~ 	$g_hBMP = _GDIPlus_BitmapCreateFromHBITMAP($hImage)
;~ 	_GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hImage, _
;~ 										0, 0, _ ; X e Y COORDENADA SOURCE
;~ 										$aDim[0], $aDim[1], _ ; WIDTH E HEIGHT DA SOURCE
;~ 										($LargForm/2)-($X/2), 120, _ ; X e Y COORDENADA COPIA
;~ 										$X, $Y) ; WIDTH E HEIGHT DA COPIA
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, _
										($LargForm/2)-($X/2), $posY, _ ; X e Y COORDENADA COPIA
										$X, $Y) ; WIDTH E HEIGHT DA COPIA

	_RedrawBotoes()
	_HideControles1(False)
	_HideControles2(False)
	; LIMPANDO RESOURCES
;~ 	_GDIPlus_GraphicsDispose($hGraphics)
;~ 	_GDIPlus_ImageDispose($g_hBitmap)
;~ 	_WinAPI_DeleteObject($g_hGfxCtxt)
;~ 	_WinAPI_DeleteObject($hImage)

	_RedrawBotoes()
	; DESLIGANADO LIVRARIA GDI+
	_GDIPlus_Shutdown()

	Return $posY

EndFunc		;==>_ContrasteImg()
;-------------------------------------------------------------------------


; _CreateFile
Func _CreateFile($nomearquivo)

	$file = $nomearquivo & ".txt"
	Local $pathfile = @ScriptFullPath&"\Data\"&$file
	If Not FileExists($pathfile) Then
		$file = FileOpen($file, $FO_APPEND)
		If $file = -1 Then
			MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO ABRIR ARQUIVO COM DADOS - " & $file)
			Return False
		EndIf
		FileWrite($file, "COTAÇÕES" & @CRLF)
		Return $file
	Else
		MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO SALVAR ARQUIVO COM DADOS - " & $file)
		Return False
	EndIf

EndFunc   ;==>_CreateFile
;-------------------------------------------------------------------------


; _HasBuyCotation
Func _HasBuyCotation($coordsbuy, $color)

;~ 	If $redimensionar Then
;~ 		$coordsbuy[1] += 18
;~ 	EndIf

;~ 	Local $x0 = $coordsbuy[0]
;~ 	Local $y0 = $coordsbuy[1]

	Local $hasBuy = PixelSearch($coordsbuy[0], $coordsbuy[1], $coordsbuy[0]+1, $coordsbuy[1]+1, $color, 5)

	If IsArray($hasBuy) Then
;~ 		ConsoleWrite("Has BUY!" & @CRLF)
;~ 		MouseMove($hasBuy[0], $hasBuy[1], 2)
		Return True
	Else
;~ 		ConsoleWrite("BUY?...." & @CRLF)
		Return False
	EndIf

EndFunc   ;==>_HasBuyCotation
;---------------------------------------------------------------------------------


; _HasSellCotation
Func _HasSellCotation($coordssell, $color)

;~ 	If $redimensionar Then
;~ 		$coordssell[1] += 18
;~ 	EndIf

;~ 	Local $x0 = $coordssell[0]
;~ 	Local $y0 = $coordssell[1]

	Local $hasSell = PixelSearch($coordssell[0], $coordssell[1], $coordssell[0]+1, $coordssell[1]+1, $color, 5)

	If IsArray($hasSell) Then
;~ 		ConsoleWrite("Has SELL!" & @CRLF)
;~ 		MouseMove($hasSell[0], $hasSell[1], 2)
		Return True
	Else
;~ 		ConsoleWrite("SELL?...." & @CRLF)
		Return False
	EndIf

EndFunc   ;==>_HasSellCotation
;---------------------------------------------------------------------------------


; _IniciarBuscarValores()
Func _IniciarBuscaValores()

	Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec, $coordscentavoc]
	Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev, $coordscentavov]
	Local $arrayCoordsQtdBuy = [$coordsqtddezc, $coordsqtdunidc]
	Local $arrayCoordsQtdSell = [$coordsqtddezv, $coordsqtdunidv]
	Local $arrayCoordsCor	= [$coordscorc, $coordscorv] ; [0] COMPRA [1] VENDA

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)
	GUICtrlSetBkColor($Buttoniniciar, 0x00EE5E) ; COR_CONECTADO
	ToolTip("<<F2=STOP>>", @DesktopWidth/2, 0, "STATUS: LEITURA", 1, 1)

	; <$b>		= $buy
	; <$s>		= $sell
	; <$+qc> 	= $somatorioQtdCompra
	; <$+qv>	= $somatorioQtdVenda
	; <$+qcT> 	= $somatorioQtdCompraTotal
	; <$+qvT>	= $somatorioQtdVendaTotal
	; <$b2m>	= $Buy2mediana
	; <$s2m>	= $Sell2mediana
	; <$m_c>	= $mediana_compra
	; <$m_v>	= $mediana_venda

	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

	$saved1 = FileWrite($DadosOrdens, "<------------------------Ordem: "&$Ordem&"------->" & @CRLF)
	If $hascompra Then
		; CALCULOS saved1------------------------------
		$Ordemcompra = _ColetarDigitos($arrayCoordsBuy, "preço") ; $arrayCoordsBuy[0][1][2][3]
;~ 		GUICtrlSetData($Labelvalor, $Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&$Ordemcompra[3]&"."&$Ordemcompra[4]&"0 - C")
		GUICtrlSetData($Labelvalor, "5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]&" - C")
		GUICtrlSetBkColor($Labelpriceask, $COR_COMPRA)
		GUICtrlSetColor($Labelask, $COR_PLACA)
		$qtdcompra	= _ColetarDigitos($arrayCoordsQtdBuy, "qtd") ; $arrayCoordsQtdBuy[0][1]
		If $qtdcompra[0] = "-" Then
			GUICtrlSetData($Labelask, $qtdcompra[1])
			$amountc = Number($qtdcompra[1])
		Else
			GUICtrlSetData($Labelask, $qtdcompra[0]&$qtdcompra[1])
			$amountc = Number($qtdcompra[0]&$qtdcompra[1])
		EndIf
		GUICtrlSetBkColor($Labelask, $COR_COMPRA)
		GUICtrlSetColor($Labelask, $COR_PLACA)
		; DADOS saved1-----------------------------------
		$buy						= Round(Number("5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]), 2)
		$somatorioQtdCompra			= Number($amountc)
		$Buy2mediana				= Round($somatorioQtdCompra * $buy, 2)
		$Buy2medianaGeral 			+= Number($Buy2mediana, 2)
		$somatorioQtdCompraTotal	+= $somatorioQtdCompra
;~ 		; SALVANDO DADOS saved1---------------------------
		$saved1 = FileWrite($DadosOrdens, "<$b>"&$buy&" * "&"<$+qc>"&$somatorioQtdCompra&" = "&"<$b2m>"&$Buy2mediana&@CRLF)
	Else
		GUICtrlSetData($Labelpriceask, "-")
		GUICtrlSetBkColor($Labelpriceask, 0x000000)
		GUICtrlSetData($Labelask, "-")
		GUICtrlSetBkColor($Labelask, 0x000000)
	EndIf

	If $hasvenda Then
		; CALCULOS saved1--------------------------------
		$Ordemvenda = _ColetarDigitos($arrayCoordsSell, "preço") ; $arrayCoordsSell[0][1][2][3]
		GUICtrlSetData($Labelvalor, "5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]&" - V")
		GUICtrlSetBkColor($Labelpricebid, $COR_VENDA)
		GUICtrlSetColor($Labelpricebid, $COR_PLACA)
		$qtdvenda	= _ColetarDigitos($arrayCoordsQtdSell, "qtd") ; $arrayCoordsQtdSell[0][1]
		If $qtdvenda[0] = "-" Then
			GUICtrlSetData($Labelbid, $qtdvenda[1])
			$amountv = Number($qtdvenda[1])
		Else
			GUICtrlSetData($Labelbid, $qtdvenda[0]&$qtdvenda[1])
			$amountv = Number($qtdvenda[0]&$qtdvenda[1])
		EndIf
		GUICtrlSetBkColor($Labelbid, $COR_VENDA)
		GUICtrlSetColor($Labelbid, $COR_PLACA)
		; DADOS saved1------------------------------------
		$sell						= Round(Number("5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]), 2)
		$somatorioQtdVenda			= Number($amountv)
		$Sell2mediana				= Round($somatorioQtdVenda * $sell, 2)
		$Sell2medianaGeral 			+= Round($Sell2mediana, 2)
		$somatorioQtdVendaTotal		+= $somatorioQtdVenda
		; SALVANDO DADOS saved1---------------------------
		$saved1 = FileWrite($DadosOrdens, "<$s>"&$sell&" * "&"<$+qv>"&$somatorioQtdVenda&" = "&"<$s2m>"&$Sell2mediana&@CRLF)
	Else
		GUICtrlSetData($Labelpricebid, "-")
		GUICtrlSetBkColor($Labelpricebid, 0x000000)
		GUICtrlSetData($Labelbid, "-")
		GUICtrlSetBkColor($Labelbid, 0x000000)
	EndIf

	$posY -= $distY
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

	If Not $hascompra And Not $hasvenda Then
		; DADOS saved2------------------------------------
		$totalQtd = $somatorioQtdCompraTotal + $somatorioQtdVendaTotal
		$mediana_compra	= Round($Buy2medianaGeral/$somatorioQtdCompraTotal, 2)
		$mediana_venda	= Round($Sell2medianaGeral/$somatorioQtdVendaTotal, 2)
		$medianaGeral	= Round((($mediana_venda - $mediana_compra)/2) + $mediana_compra, 2)
		; SALVANDO DADOS saved2---------------------------
		$saved2 = FileWrite($DadosEstudoGeral, "<$mediana_venda>" & $mediana_venda & @CRLF)
		$saved2 = FileWrite($DadosEstudoGeral, "<$medianaGeral>" & $medianaGeral & @CRLF)
		$saved2 = FileWrite($DadosEstudoGeral, "<$mediana_compra>" & $mediana_compra & @CRLF)
		GUICtrlSetData($Listimagens, $mediana_venda&"	-	"& _
									$medianaGeral&"		-	 "& _
									$mediana_compra&@CRLF)

;~ 		If $medianaGeral >= $medianaGeralMax Then
;~ 			$medianaGeralMax = $medianaGeral
;~ 		ElseIf $medianaGeral <= $medianaGeralMin Then
;~ 			$medianaGeralMin = $medianaGeral
;~ 		EndIf

		If $mediana_venda >= $max Then
			$max = $mediana_venda
		ElseIf $mediana_compra <= $min Then
			$min = $mediana_compra
		EndIf

		; OPEN, CLOSE, MAX, MIN
		If $ciclo = 0 Then ; CANDLE DE ABERTURA
			If $timeimg = "09-00-00" Then
				$abertura = $medianaGeral
				_ArrayPush($candle, $abertura)
			EndIf
			If StringTrimLeft($timeimg, 4) = $markFinal Then
				; SALVANDO DADOS saved3---------------------------
				$saved3 = FileWrite($DadosCandle, "<---------------------------TIME>" & $timeimg & @CRLF)
				$close = $medianaGeral
				_ArrayPush($candle, $close)
				_ArrayPush($candle, $max)
				_ArrayPush($candle, $min)
;~ 				_ArrayDisplay($candle, "$candle")
				$saved3 = FileWrite($DadosCandle, "<$open>" & $candle[0] & @CRLF)
				$saved3 = FileWrite($DadosCandle, "<$close>" & $candle[1] & @CRLF)
				$saved3 = FileWrite($DadosCandle, "<$maxcandle>" & $candle[2] & @CRLF)
				$saved3 = FileWrite($DadosCandle, "<$mincandle>" & $candle[3] & @CRLF)
				$open = $close
				$ciclo = 1
			EndIf
			If $timeimg = "17-59-59" Then
				$playRead = False
			EndIf
			_ArrayPush($cotacoes, $hascompra)
			_ArrayPush($cotacoes, $hasvenda)
			Return $cotacoes
		Else
			If $ciclo = 1 Then ; CANDLE DE 5-00 A 0-00
				If StringTrimLeft($timeimg, 4) = $markInicial Then
					; SALVANDO DADOS saved3---------------------------
					$saved3 = FileWrite($DadosCandle, "<---------------------------TIME>" & $timeimg & @CRLF)
					_ArrayPush($candle, $open)
					$close = $medianaGeral
					_ArrayPush($candle, $close)
					_ArrayPush($candle, $max)
					_ArrayPush($candle, $min)
	;~ 				_ArrayDisplay($candle, "$candle")
					$saved3 = FileWrite($DadosCandle, "<$open>" & $candle[0] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$close>" & $candle[1] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$maxcandle>" & $candle[2] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$mincandle>" & $candle[3] & @CRLF)
					$open = $close
					$ciclo = 2
					$mediana_compra = 0
					$mediana_venda = 0
					$max = 0
					$min = 10000
					$Buy2medianaGeral		= 0
					$Sell2medianaGeral		= 0
					$somatorioQtdCompraTotal	= 0
					$somatorioQtdVendaTotal	= 0
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf

			If $ciclo = 2 Then ; CANDLE DE 0-00 A 5-00
				If StringTrimLeft($timeimg, 4) = $markFinal Then
					; SALVANDO DADOS saved3---------------------------
					$saved3 = FileWrite($DadosCandle, "<---------------------------TIME>" & $timeimg & @CRLF)
					_ArrayPush($candle, $open)
					$close = $medianaGeral
					_ArrayPush($candle, $close)
					_ArrayPush($candle, $max)
					_ArrayPush($candle, $min)
	;~ 				_ArrayDisplay($candle, "$candle")
					$saved3 = FileWrite($DadosCandle, "<$open>" & $candle[0] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$close>" & $candle[1] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$maxcandle>" & $candle[2] & @CRLF)
					$saved3 = FileWrite($DadosCandle, "<$mincandle>" & $candle[3] & @CRLF)
					$open = $close
					$ciclo = 1
					$mediana_compra = 0
					$mediana_venda = 0
					$max = 0
					$min = 10000
					$Buy2medianaGeral		= 0
					$Sell2medianaGeral		= 0
					$somatorioQtdCompraTotal	= 0
					$somatorioQtdVendaTotal	= 0
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					$max = 0
					$min = 10000
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf
		EndIf
	Else
		; INCREMENTA PARA A LEITURA DA PROXIMA ORDEM NO MESMO HORARIO
		$Ordem += 1
	EndIf


	_ArrayPush($cotacoes, $hascompra)
	_ArrayPush($cotacoes, $hasvenda)
	Return $cotacoes

EndFunc   ;==>_IniciarBuscarValores
;---------------------------------------------------------------------------------


; _ColetarDigitos()
Func _ColetarDigitos($arrayCoords, $tipo)

	Local $placamilhar, $placacentena, $placadezena, $placaunidade, $placacentavo, $qtdd[14], $qtdu[14]
	Local $valor

	If $tipo == "preço" Then
		Local $arrayNumber[4]
;~ 		$placamilhar = _GetCotationCasaMove($arrayCoords[0], 0, $COR_PLACA)
;~ 	 	_ArrayDisplay($placamilhar, "$placamilhar", "", 4)
;~ 		$valor = _FindNumber($placamilhar)
;~ 		_ArrayPush($arrayNumber, $valor)
		$placacentena = _GetCotationCasaMove($arrayCoords[1], 0, $COR_PLACA)
;~ 	 	 _ArrayDisplay($placacentena, "$placacentena", "", 4)
		$valor = _FindNumber($placacentena)
		_ArrayPush($arrayNumber, $valor)
		$placadezena = _GetCotationCasaMove($arrayCoords[2], 0, $COR_PLACA)
;~ 	 	_ArrayDisplay($placadezena, "$placadezena", "", 4)
		$valor = _FindNumber($placadezena)
		_ArrayPush($arrayNumber, $valor)
		$placaunidade = _GetCotationCasaMove($arrayCoords[3], 0, $COR_PLACA)
;~ 	 	_ArrayDisplay($placaunidade, "$placaunidade", "", 4)
		$valor = _FindNumber($placaunidade)
		_ArrayPush($arrayNumber, $valor)
		$placacentavo = _GetCotationCasaMove($arrayCoords[4], 0, $COR_PLACA)
		If $placacentavo[4] = 0 Then
			$valor = 5
		ElseIf $placacentavo[4] = 1 Then
			$valor = 0
		EndIf
;~ 	 	_ArrayDisplay($placacentavo, "$placacentavo", "", 4)
;~ 		$valor = _FindNumber($placacentavo)
		_ArrayPush($arrayNumber, $valor)
		Return $arrayNumber

	ElseIf $tipo == "qtd" Then
		Local $arrayNumber[2], $arrayunico
		$qtdd = _GetCotationCasaMove($arrayCoords[0], 0, $COR_PLACA)
		$valor = _FindNumber($qtdd)
		_ArrayPush($arrayNumber, $valor)
;~ 		_ArrayDisplay($arrayNumber, "$qtdd", "", 4)

		; ESTE PROCESSO REPOSICIONA A CAPTAÇÃO PARA A QTD UNIDADE,
		; CASO NÃO HAJA, A QTD DEZENA REDUZINDO -6 NA POSIÇÃO
		; CASO NÃO ENCONTRE NENHUMA PLACA NA DEZENA
		; REALIZA DIRETO A CAPTAÇÃO UNID QTD
		If $valor = "-" Then
			$arrayunico = $arrayCoords[1]
;~ 			_ArrayDisplay($arrayunico, "$arrayunico", "", 4)
			For $i = 0 To UBound($arrayunico) - 1 Step 2
				If Mod($i, 2) = 0 Then
					$arrayunico[$i] -= 6
				EndIf
			Next
			$qtdu = _GetCotationCasaMove($arrayunico, 0, $COR_PLACA)
;~ 			_ArrayDisplay($qtdu, "$qtdu", "", 4)
			$valor = _FindNumber($qtdu)
			_ArrayPush($arrayNumber, $valor)
;~	 	 	_ArrayDisplay($arrayNumber, "$arrayNumber", "", 4)
			;-----------
			Return $arrayNumber ; RETORNA "VAZIO" E A UNIDADE REPOSICIONADA
			;-----------
		Else
;~ 			_ArrayDisplay($qtdd, "$qtdd", "", 4)
			$valor = _FindNumber($qtdd)
			_ArrayPush($arrayNumber, $valor)
;~	 	 	_ArrayDisplay($arrayNumber, "$arrayNumber", "", 4)
			$qtdu = _GetCotationCasaMove($arrayCoords[1], 0, $COR_PLACA)
;~ 			_ArrayDisplay($qtdu, "$qtdu", "", 4)
			$valor = _FindNumber($qtdu)
			_ArrayPush($arrayNumber, $valor)
;~	 	 	_ArrayDisplay($arrayNumber, "$arrayNumber", "", 4)
			;-----------
			Return $arrayNumber ; RETONRA DEZENA E UNIDADE
			;-----------
		EndIf

	EndIf

EndFunc		;==>_ColetarDigitos
;-------------------------------------------------------------------------


; _IniciarBuscaNonZeroSum()
Func _IniciarBuscaNonZeroSum() ; non-zero sum game


	Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec, $coordscentavoc]
	Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev, $coordscentavov]
	Local $arrayCoordsQtdBuy = [$coordsqtddezc, $coordsqtdunidc]
	Local $arrayCoordsQtdSell = [$coordsqtddezv, $coordsqtdunidv]
	Local $arrayCoordsCor	= [$coordscorc, $coordscorv] ; [0] COMPRA [1] VENDA
	Local $ask[2], $bid[2], $calculos[0][0]

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)
	GUICtrlSetBkColor($Buttoniniciar, 0x00EE5E) ; COR_CONECTADO
	ToolTip("<<F2=STOP>>", @DesktopWidth/2, 0, "STATUS: LEITURA", 1, 1)

	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

;~ 	$saved1 = FileWrite($DadosOrdens, "<------------------------Ordem: "&$Ordem&"------->" & @CRLF)
	If $hascompra Then
		$Ordemcompra = _ColetarDigitos($arrayCoordsBuy, "preço") ; $arrayCoordsBuy[0][1][2][3]
;~ 		GUICtrlSetData($Labelvalor, $Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&$Ordemcompra[3]&"."&$Ordemcompra[4]&"0 - C")
		GUICtrlSetData($Labelvalor, "5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]&" - C")
		GUICtrlSetBkColor($Labelvalor, $COR_COMPRA)
		GUICtrlSetColor($Labelvalor, $COR_PLACA)

		$qtdcompra	= _ColetarDigitos($arrayCoordsQtdBuy, "qtd") ; $arrayCoordsQtdBuy[0][1]
		If $qtdcompra[0] = "-" Then
			GUICtrlSetData($Labelqtd, $qtdcompra[1])
			$amountc = Number($qtdcompra[1])
		Else
			GUICtrlSetData($Labelqtd, $qtdcompra[0]&$qtdcompra[1])
			$amountc = Number($qtdcompra[0]&$qtdcompra[1])
		EndIf
		GUICtrlSetBkColor($Labelqtd, $COR_COMPRA)
		GUICtrlSetColor($Labelqtd, $COR_PLACA)
		$buy						= Round(Number("5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]), 2)
		$somatorioQtdCompra			= Number($amountc)
		_ArrayPush($ask, $buy)
		_ArrayPush($ask, $somatorioQtdCompra)
;~ 		MsgBox(0, "size array compra", UBound($arrayLotesCompra), 2)
		Local $index = _ArrayInsert($arrayLotesCompra, $Ordem, $ask, Default, Default, Default, $ARRAYFILL_FORCE_SINGLEITEM)
;~ 		MsgBox(0, "NEW size array compra", $index, 2)
		$index = _ArrayDelete($arrayLotesCompra, $index-1)
;~ 		MsgBox(0, "new size array compra", $index, 2)
	Else
		GUICtrlSetData($Labelvalor, "-")
		GUICtrlSetBkColor($Labelvalor, 0x000000)
		GUICtrlSetData($Labelqtd, "-")
		GUICtrlSetBkColor($Labelqtd, 0x000000)
	EndIf
;~ 	_ArrayDisplay($arrayLotesCompra[$Ordem], "$arrayLotesCompra[$Ordem]") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd
;~ 	_ArrayDisplay($arrayLotesCompra, "$arrayLotesCompra") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd

	If $hasvenda Then
		$Ordemvenda = _ColetarDigitos($arrayCoordsSell, "preço") ; $arrayCoordsSell[0][1][2][3]
		GUICtrlSetData($Labelvalor, "5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]&" - V")
		GUICtrlSetBkColor($Labelvalor, $COR_VENDA)
		GUICtrlSetColor($Labelvalor, $COR_PLACA)

		$qtdvenda	= _ColetarDigitos($arrayCoordsQtdSell, "qtd") ; $arrayCoordsQtdSell[0][1]
		If $qtdvenda[0] = "-" Then
			GUICtrlSetData($Labelqtd, $qtdvenda[1])
			$amountv = Number($qtdvenda[1])
		Else
			GUICtrlSetData($Labelqtd, $qtdvenda[0]&$qtdvenda[1])
			$amountv = Number($qtdvenda[0]&$qtdvenda[1])
		EndIf
		GUICtrlSetBkColor($Labelqtd, $COR_VENDA)
		GUICtrlSetColor($Labelqtd, $COR_PLACA)
		$sell						= Round(Number("5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]), 2)
		$somatorioQtdVenda			= Number($amountv)
		_ArrayPush($bid, $sell)
		_ArrayPush($bid, $somatorioQtdVenda)
;~ 		MsgBox(0, "size array compra", UBound($arrayLotesVenda), 2)
		Local $index = _ArrayInsert($arrayLotesVenda, $Ordem, $bid, Default, Default, Default, $ARRAYFILL_FORCE_SINGLEITEM)
;~ 		MsgBox(0, "NEW size array venda", $index, 2)
		$index = _ArrayDelete($arrayLotesVenda, $index-1)
;~ 		MsgBox(0, "new size array venda", $index, 2)
	Else
		GUICtrlSetData($Labelvalor, "-")
		GUICtrlSetBkColor($Labelvalor, 0x000000)
		GUICtrlSetData($Labelqtd, "-")
		GUICtrlSetBkColor($Labelqtd, 0x000000)
	EndIf
;~ 	_ArrayDisplay($arrayLotesVenda[$Ordem], "$arrayLotesVenda[$Ordem]") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd
;~ 	_ArrayDisplay($arrayLotesVenda, "$arrayLotesVenda") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd

	$posY -= $distY
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

	If Not $hascompra And Not $hasvenda Then
		_ArrayExtract($arrayLotesCompra, 0, $Ordem)
		_ArrayExtract($arrayLotesVenda, 0, $Ordem)
		MsgBox(0, "array compra after extraction", UBound($arrayLotesCompra), 2)
		_ArrayDisplay($arrayLotesCompra, "$arrayLotesCompra") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd
		MsgBox(0, "array venda after extraction", UBound($arrayLotesVenda), 2)
		_ArrayDisplay($arrayLotesVenda, "$arrayLotesVenda") ; [[x,y],[x,y],[x,y]] x=preço  y=qtd


		Local $maxmin = -100, $minmax = 100, $value, $index, $toSaddlePoint[2]

		; CALCULAR OS MINIMOS - ENCONTRAR O MAXMIN
		For $i = 0 To UBound($arrayLotesCompra) - 1 Step 1
			If Not $arrayLotesCompra[$i] = "" Then
				For $j = 0 To UBound($arrayLotesVenda) - 1 Step 1
					If Not $arrayLotesVenda[$j] = "" Then
						$value = $arrayLotesCompra[$i][1] - $arrayLotesVenda[$j][1]
						If $value < $minimo Then
							$minimo = $value
						EndIf
						_ArrayInsert($calculos[$i], $j, $minimo, $ARRAYFILL_FORCE_SINGLEITEM)
					Else
						ContinueLoop
					EndIf
				Next
			Else
				ContinueLoop
			EndIf
			_ArrayDisplay($calculos[$i], "$calculos[$i]", "", 64)
		Next

;~ 		$playRead = False
	#cs
		; OPEN, CLOSE, MAX, MIN
		If $ciclo = 0 Then ; CANDLE DE ABERTURA
			If $timeimg = "09-00-00" Then
				$abertura = $medianaGeral
				_ArrayPush($candle, $abertura)
			EndIf
			If StringTrimLeft($timeimg, 4) = $markFinal Then
;~ 				$saved3 = FileWrite($DadosCandle, "<---------------------------TIME>" & $timeimg & @CRLF)
				$ciclo = 1
			EndIf
			If $timeimg = "17-59-59" Then
				$playRead = False
			EndIf
			_ArrayPush($cotacoes, $hascompra)
			_ArrayPush($cotacoes, $hasvenda)
			Return $cotacoes
		Else
			If $ciclo = 1 Then ; CANDLE DE 5-00 A 0-00
				If StringTrimLeft($timeimg, 4) = $markInicial Then
					$ciclo = 2
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf

			If $ciclo = 2 Then ; CANDLE DE 0-00 A 5-00
				If StringTrimLeft($timeimg, 4) = $markFinal Then
					$ciclo = 1
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf
		EndIf
	#ce
	Else
		; INCREMENTA PARA A LEITURA DA PROXIMA ORDEM NO MESMO HORARIO
		$Ordem += 1
	EndIf

	_ArrayPush($cotacoes, $hascompra)
	_ArrayPush($cotacoes, $hasvenda)
	Return $cotacoes

EndFunc   ;==>_IniciarBuscaNonZeroSum()
;---------------------------------------------------------------------------------


; _IniciarBuscarShadowPrice()
Func _IniciarBuscarShadowPrice() ; ShadowPrice


	Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec, $coordscentavoc]
	Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev, $coordscentavov]
	Local $arrayCoordsQtdBuy = [$coordsqtddezc, $coordsqtdunidc]
	Local $arrayCoordsQtdSell = [$coordsqtddezv, $coordsqtdunidv]
	Local $arrayCoordsCor	= [$coordscorc, $coordscorv] ; [0] COMPRA [1] VENDA
	Local $momentum = 0

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)
	GUICtrlSetBkColor($Buttoniniciar, 0x00EE5E) ; COR_CONECTADO
	ToolTip("<<F2=STOP>>", @DesktopWidth/2, 0, "STATUS: LEITURA", 1, 1)


	GUICtrlSetBkColor($Labelprice, $COR_COMPRA)
	GUICtrlSetColor($Labelprice, $COR_PLACA)
	GUICtrlSetBkColor($Labelshadowb, $COR_COMPRA)
	GUICtrlSetColor($Labelshadowb, $COR_PLACA)
	GUICtrlSetBkColor($Labelshadows, $COR_COMPRA)
	GUICtrlSetColor($Labelshadows, $COR_PLACA)
	GUICtrlSetBkColor($Labelmediana, $COR_COMPRA)
	GUICtrlSetColor($Labelmediana, $COR_PLACA)

	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

;~ 	$saved1 = FileWrite($DadosOrdens, "<------------------------Ordem: "&$Ordem&"------->" & @CRLF)
	If $hascompra Then
		$Ordemcompra = _ColetarDigitos($arrayCoordsBuy, "preço") ; $arrayCoordsBuy[0][1][2][3]
;~ 		GUICtrlSetData($Labelvalor, $Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&$Ordemcompra[3]&"."&$Ordemcompra[4]&"0 - C")
		GUICtrlSetData($Labelask, "5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]&" - C")

		$qtdcompra	= _ColetarDigitos($arrayCoordsQtdBuy, "qtd") ; $arrayCoordsQtdBuy[0][1]
		If $qtdcompra[0] = "-" Then
			$amountc = Number($qtdcompra[1])
		Else
			$amountc = Number($qtdcompra[0]&$qtdcompra[1])
		EndIf
		$buy						= Round(Number("5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]), 2)
		$somatorioQtdCompra			= Number($amountc)
;~ 		$somatorioQtdCompra			= 1
		$somatorioQtdCompraTotal	= $somatorioQtdCompra
		$Buy2shadow					= Round($somatorioQtdCompra * $buy, 2)
		$BuySum 					+= Number($Buy2shadow, 3)
	EndIf

	If $hasvenda Then
		$Ordemvenda = _ColetarDigitos($arrayCoordsSell, "preço") ; $arrayCoordsSell[0][1][2][3]
;~ 		GUICtrlSetData($Labelvalor, $Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&$Ordemvenda[3]&"."&$Ordemvenda[4]&"0 - C")
		GUICtrlSetData($Labelbid, "5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]&" - V")

		$qtdvenda	= _ColetarDigitos($arrayCoordsQtdSell, "qtd") ; $arrayCoordsQtdSell[0][1]
		If $qtdvenda[0] = "-" Then
			$amountv = Number($qtdvenda[1])
		Else
			$amountv = Number($qtdvenda[0]&$qtdvenda[1])
		EndIf
		GUICtrlSetColor($Labelqtd, $COR_PLACA)
		$sell						= Round(Number("5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]), 2)
		$somatorioQtdVenda			= Number($amountv)
;~ 		$somatorioQtdVenda			= 1
		$somatorioQtdVendaTotal		+= $somatorioQtdVenda
		$Sell2shadow				= Round($somatorioQtdVenda * $sell, 2)
		$SellSum 					+= Number($Sell2shadow, 3)
	EndIf

	If $Ordem = 0 Then
		$momentum = ($sell - $buy)/2
		$momentum += $buy
		GUICtrlSetData($Labelprice, $momentum)
	EndIf

	$posY -= $distY
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	$hascompra	= _HasBuyCotation($arrayCoordsCor[0], $COR_COMPRA)
	$hasvenda	= _HasSellCotation($arrayCoordsCor[1], $COR_VENDA)

	If Not $hascompra And Not $hasvenda Then

		$shadowPriceB = Round($BuySum/$SellSum, 3)
		GUICtrlSetData($Labelshadowb, $shadowPriceB)
		$shadowPriceB = 0
		$BuySum = 0
		$SellSum = 0
		$somatorioQtdCompraTotal = 0
		$somatorioQtdVendaTotal = 0

;~ 		$playRead = False

;~ 	#cs
		; OPEN, CLOSE, MAX, MIN
		If $ciclo = 0 Then ; CANDLE DE ABERTURA
			If $timeimg = "09-00-00" Then
				$abertura = $medianaGeral
				_ArrayPush($candle, $abertura)
			EndIf
			If StringTrimLeft($timeimg, 4) = $markFinal Then
;~ 				$saved3 = FileWrite($DadosCandle, "<---------------------------TIME>" & $timeimg & @CRLF)
				$ciclo = 1
			EndIf
			If $timeimg = "17-59-59" Then
				$playRead = False
			EndIf
			_ArrayPush($cotacoes, $hascompra)
			_ArrayPush($cotacoes, $hasvenda)
			Return $cotacoes
		Else
			If $ciclo = 1 Then ; CANDLE DE 5-00 A 0-00
				If StringTrimLeft($timeimg, 4) = $markInicial Then
					$ciclo = 2
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf

			If $ciclo = 2 Then ; CANDLE DE 0-00 A 5-00
				If StringTrimLeft($timeimg, 4) = $markFinal Then
					$ciclo = 1
					If $timeimg = "17-59-59" Or $timeimg = "18-00-00" Then
						$playRead = False
					EndIf
					_ArrayPush($cotacoes, $hascompra)
					_ArrayPush($cotacoes, $hasvenda)
					Return $cotacoes
				EndIf
			EndIf
		EndIf
;~ 	#ce

	GUICtrlSetBkColor($Labelprice, $COR_COMPRA)
	GUICtrlSetColor($Labelprice, 0x000000)
	GUICtrlSetBkColor($Labelshadowb, $COR_COMPRA)
	GUICtrlSetColor($Labelshadowb, 0x000000)
	GUICtrlSetBkColor($Labelmediana, $COR_COMPRA)
	GUICtrlSetColor($Labelmediana, 0x000000)
	GUICtrlSetBkColor($Labelshadows, $COR_COMPRA)
	GUICtrlSetColor($Labelshadows, 0x000000)

	Else
		; INCREMENTA PARA A LEITURA DA PROXIMA ORDEM NO MESMO HORARIO
		$Ordem += 1
	EndIf

	_ArrayPush($cotacoes, $hascompra)
	_ArrayPush($cotacoes, $hasvenda)
	Return $cotacoes

EndFunc   ;==>_IniciarBuscarShadowPrice()
;---------------------------------------------------------------------------------


; _TestePosCoords()
Func _TestePosCoords($arrayCoords)

		Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec, $coordscentavoc]
		Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev, $coordscentavov]
		Local $arrayCoordsQtdBuy = [$coordsqtddezc, $coordsqtdunidc]
		Local $arrayCoordsQtdSell = [$coordsqtddezv, $coordsqtdunidv]
		Local $Ordemcompra, $Ordemvenda, $qtdcompra, $qtdvenda

		GUICtrlSetData($Buttonteste, "PARAR(F7)")
		GUICtrlSetBkColor($Buttonteste, 0xFFFF00) ; COR AMARELO
		GUICtrlSetState($Buttonteste, $GUI_DISABLE)
		ToolTip("<<F7=STOP>>", @DesktopWidth/2, 0, "STATUS: TESTANDO", 1, 1)

		; CASO O 1º VALOR ($Ordemcompra[0] = "-") DO ARRAY SEJA "-"
		; O LABEL JÁ EXIBIRÁ NENHUM VALOR
		$Ordemcompra = _ColetarDigitos($arrayCoordsBuy, "preço") ; $arrayCoordsBuy[0][1][2][3]
		If $Ordemcompra[0] <> "-" Then
			GUICtrlSetData($Labelvalor, "5"&$Ordemcompra[0]&$Ordemcompra[1]&$Ordemcompra[2]&"."&$Ordemcompra[3]&" - C")
			GUICtrlSetBkColor($Labelvalor, $COR_COMPRA)
			GUICtrlSetColor($Labelvalor, $COR_PLACA)
			$qtdcompra	= _ColetarDigitos($arrayCoordsQtdBuy, "qtd") ; $arrayCoordsQtdBuy[0][1]
			If $qtdcompra[0] = "-" Then
				GUICtrlSetData($Labelqtd, $qtdcompra[1])
			Else
				GUICtrlSetData($Labelqtd, $qtdcompra[0]&$qtdcompra[1])
			EndIf
			GUICtrlSetBkColor($Labelqtd, $COR_COMPRA)
			GUICtrlSetColor($Labelqtd, $COR_PLACA)
		Else
			GUICtrlSetData($Labelvalor, "-")
			GUICtrlSetBkColor($Labelvalor, 0x000000)
			GUICtrlSetData($Labelqtd, "-")
			GUICtrlSetBkColor($Labelqtd, 0x000000)
		EndIf

		; CASO O 1º VALOR ($Ordemvenda[0] = "-") DO ARRAY SEJA "-"
		; O LABEL JÁ EXIBIRÁ NENHUM VALOR
		$Ordemvenda = _ColetarDigitos($arrayCoordsSell, "preço") ; $arrayCoordsSell[0][1][2][3]
		If $Ordemvenda[0] <> "-" Then
			GUICtrlSetData($Labelvalor, "5"&$Ordemvenda[0]&$Ordemvenda[1]&$Ordemvenda[2]&"."&$Ordemvenda[3]&" - V")
			GUICtrlSetBkColor($Labelvalor, $COR_VENDA)
			GUICtrlSetColor($Labelvalor, $COR_PLACA)
			$qtdvenda	= _ColetarDigitos($arrayCoordsQtdSell, "qtd") ; $arrayCoordsQtdSell[0][1]
			If $qtdvenda[0] = "-" Then
				GUICtrlSetData($Labelqtd, $qtdvenda[1])
			Else
				GUICtrlSetData($Labelqtd, $qtdvenda[0]&$qtdvenda[1])
			EndIf
			GUICtrlSetBkColor($Labelqtd, $COR_VENDA)
			GUICtrlSetColor($Labelqtd, $COR_PLACA)
		Else
			GUICtrlSetData($Labelvalor, "-")
			GUICtrlSetBkColor($Labelvalor, 0x000000)
			GUICtrlSetData($Labelqtd, "-")
			GUICtrlSetBkColor($Labelqtd, 0x000000)
		EndIf

		GUICtrlSetData($Buttonteste, "TESTE")
		GUICtrlSetBkColor($Buttonteste, 0xCCCDCF) ; COR AQUA
		GUICtrlSetState($Buttonteste, $GUI_ENABLE)

EndFunc   ;==>_TestePosCoords()
;---------------------------------------------------------------------------------


; _Timer()
Func _Timer()
    _TicksToTime(Int(TimerDiff($g_hTimer)), $g_iHour, $g_iMins, $g_iSecs)
    Local $sTime = $g_sTime ; save current time to be able to test and avoid flicker..
;~     $g_sTime = StringFormat("%02i:%02i:%02i", $g_iHour, $g_iMins, $g_iSecs)
    $g_sTime = StringFormat("%02i:%02i", $g_iHour, $g_iMins)
    If $sTime <> $g_sTime Then ControlSetText("WPM_LER", "", "Static109", $g_sTime)

EndFunc   ;==>Timer
;---------------------------------------------------------------------------------


; _FindNumber()
Func _FindNumber($plates)

	Local $contador = 0, $number, $a, $b, $c, $d, $e, $f, $g

	; ------------ v = a,b,c,d,e,f,g
	; ------------ 0 = 1,1,1,1,1,1,0
	; ------------ 1 = 1,1,0,0,0,0,0
	; ------------ 2 = 1,1,0,1,1,0,1
	; ------------ 3 = 1,1,1,1,1,0,0
	; ------------ 4 = 0,1,1,0,0,1,1
	; ------------ 5 = 1,1,1,1,1,1,0
	; ------------ 6 = 1,0,1,1,1,1,1
	; ------------ 7 = 1,1,1,0,0,1,0
	; ------------ 8 = 1,1,1,1,1,1,1
	; ------------ 9 = 1,1,1,1,0,1,1
	; ------------ . = 0,0,0,1,0,0,0
	; ------------ , = 0,0,1,1,0,0,0
	; ------------ vazio = 0,0,0,0,0,0,0

	$a = $plates[0]
	$b = $plates[1]
	$c = $plates[2]
	$d = $plates[3]
	$e = $plates[4]
	$f = $plates[5]
	$g = $plates[6]
	For $i = 0 To UBound($plates) - 1 Step 1
		If $plates[$i] = 1 Then
			$contador += 1
		EndIf
	Next
	#Region
	If $contador = 0 Then
		$number = "-"
	EndIf
	If $contador = 6 And Not $plates[6] Then
		$number = 0
	EndIf
	If $contador = 2 Then
		$number = 1
	EndIf
	If $contador = 5 And Not $plates[2] Then
		$number = 2
	EndIf
	If $contador = 5 And Not $plates[4] And Not $plates[5] Then
		$number = 3
	EndIf
	If $contador = 4 And $plates[6] Then
		$number  = 4
	EndIf
	If $contador = 5 And Not $plates[1] Then
		$number = 5
	EndIf
	If $contador = 6 And Not $plates[1] Then
		$number = 6
	EndIf
	If $contador = 4 And Not $plates[6] Then
		$number = 7
	EndIf
	If $contador = 7 Then
		$number = 8
	EndIf
	If $contador = 6 And Not $plates[4] Then
		$number = 9
	EndIf

	Return $number
	#EndRegion

EndFunc   ;==>_FindNumber
;---------------------------------------------------------------------------------


; _MoverImagemCima()
Func _MoverImagemCima($path, $zoom, $move)

	Local $posY = $move
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	Return $posY

EndFunc		;==>_MoverImagemCima()
;-------------------------------------------------------------------------


; _MoverImagemBaixo()
Func _MoverImagemBaixo($path, $zoom, $move)

	Local $posY = $move
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	Return $posY

EndFunc		;==>_MoverImagemBaixo()
;-------------------------------------------------------------------------


; _LocalizarHorario()
Func _LocalizarHorario($hora, $zoom, $posY, $efeitizar)

	Local $horario = $hora&".bmp"
	$posicaohora = _ArraySearch($filelist, $horario)
	_ArrayDisplay($posicaohora, "")
	If $posicaohora = 6 Then
		MsgBox(0, "RESULTADO", "Horário não localizado!", 1)
	Else
		$path	= $diretorio2 & $pasta & $horario
		$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
		GUICtrlSetData($Sliderfotos, $posicaohora)
		GUICtrlSetData($Labelqtdimagens, $posicaohora&"/"&$maxItens&" - "&$filelist[$posicaohora])
		Return $posY
	EndIf

EndFunc   ;==>_LocalizarHorario)
;---------------------------------------------------------------------------------


; _Slider()
Func _Slider($zoom, $move)

	Local $posY = $move
	If IsInt($posY) Then
		$posicaohora = GUICtrlread($Sliderfotos)
		GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
		$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
		$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)

		If $posicaohora == 1 Then
			GUICtrlSetState($Buttonanterior, $GUI_DISABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_DISABLE)
			GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
			GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		ElseIf $posicaohora == $maxItens Then
			GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
			GUICtrlSetState($Buttonproximo, $GUI_DISABLE)
			GUICtrlSetState($Buttonultimo, $GUI_DISABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		ElseIf $posicaohora <> 1 And $posicaohora <> $maxItens Then
			GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
			GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
			GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		EndIf
	EndIf
	Return $posY

EndFunc   ;==>_Slider()
;-------------------------------------------------------------------------


; _First()
Func _First($zoom, $move)

	Local $posY = $move
	$posicaohora = 1
	$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	GUICtrlSetState($Buttonanterior, $GUI_DISABLE)
	GUICtrlSetState($Buttonprimeiro, $GUI_DISABLE)
	GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
	GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
	GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
	GUICtrlSetData($Sliderfotos, $posicaohora)
	GUICtrlSetState($Listimagens, $GUI_ENABLE)
	GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
	Return $posY

EndFunc   ;==>_First()
;-------------------------------------------------------------------------


; _Last()
Func _Last($zoom, $move)

	Local $posY = $move
	$posicaohora = $maxItens
	$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
	$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
	GUICtrlSetState($Buttonproximo, $GUI_DISABLE)
	GUICtrlSetState($Buttonultimo, $GUI_DISABLE)
	GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
	GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
	GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
	GUICtrlSetData($Sliderfotos, $posicaohora)
	GUICtrlSetState($Listimagens, $GUI_ENABLE)
	GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
	Return $posY

EndFunc   ;==>_Last()
;-------------------------------------------------------------------------


; _PreImagem()
Func _PreImagem()

	If IsInt($posY) Then
		If $posicaohora <> 1 Then
			$posicaohora -= 1
			GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
			GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
			GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		Else
			$posicaohora = 1
			GUICtrlSetState($Buttonanterior, $GUI_DISABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_DISABLE)
			GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
			GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		EndIf
		GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
		GUICtrlSetData($Sliderfotos, $posicaohora)
		$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
		$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
		Return $posY
	EndIf

EndFunc   ;==>_PreImagem()
;-------------------------------------------------------------------------


; _PosImagem()
Func _PosImagem()

;~ 	GUICtrlDelete($Picfotos)
	If IsInt($posY) <> 0 Then
		If $posicaohora <> $maxItens Then
			$posicaohora += 1
			GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
			GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
			GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		Else
			$posicaohora = $maxItens
			GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
			GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
			GUICtrlSetState($Buttonproximo, $GUI_DISABLE)
			GUICtrlSetState($Buttonultimo, $GUI_DISABLE)
			GUICtrlSetState($Listimagens, $GUI_ENABLE)
			GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		EndIf
		GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
		GUICtrlSetData($Sliderfotos, $posicaohora)
		$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
		$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
		Return $posY
	EndIf

EndFunc   ;==>_PosImagem()
;-------------------------------------------------------------------------


; _AbrirDir()
Func _AbrirDir($zoom, $posY)

	GUICtrlSetBkColor($Buttonpasta, 0xFFFF00) ; $COLOR_YELLOW
	$files			= FileSelectFolder("POR FAVOR, ESCOLHA A PASTA COM AS IMAGENS: ", $diretorio, 1)
;~ 	MsgBox(0, "", $files, 2)
	If $files <> "" Then
		GUICtrlSetState($Sliderfotos, $GUI_ENABLE)
		GUICtrlSetState($Sliderzoom, $GUI_ENABLE)
		GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
		GUICtrlSetState($Buttonproximo, $GUI_ENABLE)
		GUICtrlSetState($Buttonultimo, $GUI_ENABLE)
		GUICtrlSetState($Buttonanterior, $GUI_ENABLE)
		GUICtrlSetState($Buttoncima, $GUI_ENABLE)
		GUICtrlSetState($Buttonbaixo, $GUI_ENABLE)
		GUICtrlSetState($Buttonlocalizar, $GUI_ENABLE)
		$loop = 0
		GUICtrlSetData($Labelqtdimagens,"0/0")
		GUICtrlSetData($Progress, 0)
		GUICtrlSetData($Labelprogresso, "0/0")
		GUICtrlSetData($Listimagens, "")
		$diretorio2 	= StringTrimRight($files, 13) & "\" ; D:\AutoIt\WinProMoney1.0\Fotos\
;~ 		MsgBox(0, "", $diretorio2, 2)
		$pasta			= StringTrimLeft($files, 31) & "\" ; O NOME DA PASTA PRECEISA TER 12 CARACTERES
;~ 		MsgBox(0, "", $pasta, 2)
		$fileList		= _FileListToArrayRec($files, "*.bmp;*.jpg", 1, 0, 2, 0) ; O 1º INDEX REPRESENTA A QUANTIDADE TOTAL DE VALORES DO ARRAY
;~ 		_ArrayDisplay($fileList, "ARRAY")
		$maxItens		= $fileList[0]
		GUICtrlSetData($Labelqtdimagens,  $maxItens)
		$progresso 		= $maxItens/100

		For $i = 1 To $maxItens Step 1
			$path	= $diretorio2 & $pasta & $fileList[$i]
;~ 			GUICtrlSetData($Listimagens, $fileList[$i])
			GUICtrlSetData($Progress, $loop/$progresso)
			GUICtrlSetData($Labelprogresso, $loop & "/" & $maxItens)
			$loop += 1
		Next

		$posicaohora = 1
		$path	= $diretorio2 & $pasta & $fileList[$posicaohora]
		GUICtrlSetLimit($Sliderfotos, $maxItens, 1)
		GUICtrlSetData($Labelqtdimagens, $posicaohora & "/" & $maxItens & " - " & $fileList[$posicaohora])
		GUICtrlSetData($Labelprogresso, $maxItens & "/" & $maxItens)
		GUICtrlSetBkColor($Buttonpasta, 0x00EE5E) ; $COLOR_CONECTADO
		GUICtrlSetData($Progress, 100)
		$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
		GUICtrlSetState($Buttonprimeiro, $GUI_ENABLE)
		GUICtrlSetState($Listimagens, $GUI_ENABLE)
		GUICtrlSetState($Buttonpasta, $GUI_ENABLE)
		Return 1
	Else
		MsgBox(0, "RESULTADO", "NENHUMA PASTA FOI SELECIOANDA!", 2)
		GUICtrlSetData($Progress, 0)
		GUICtrlSetData($Labelprogresso, "0/0")
		GUICtrlSetData($Listimagens, "")
		Return 0
	EndIf

EndFunc   ;==>_AbrirDir()
;-------------------------------------------------------------------------


; _GetCotationCasaMove()
Func _GetCotationCasaMove($coordscasa, $ordem, $color)

	Local $hasplaca, $x0, $y0, $placas[7]
;~ 	_ArrayDisplay($coordscasa, "$coordscasa")
	If $ordem == 0 Then ; BUSCAR COR DA E RETORNA PLACAS
		For $i = 0 To UBound($coordscasa) - 2 Step 2
			$x0 = $coordscasa[$i]
			$y0 = $coordscasa[$i + 1]
			$hasplaca = PixelSearch($x0, $y0, $x0, $y0, $color, 5)
			If IsArray($hasplaca) Then
;~ 				MouseMove($hasplaca[0], $hasplaca[1], 10)
				_ArrayPush($placas, 1)
			Else
				_ArrayPush($placas, 0)
			EndIf
		Next
		Return $placas
	ElseIf $ordem == 1 Then ; APEANS MOVER O MOUSE ATÉ A PLACA
		For $i = 0 To UBound($coordscasa) - 2 Step 2
			$x0 = $coordscasa[$i]
			$y0 = $coordscasa[$i + 1]
			MouseMove($x0, $y0, 3)
			Sleep(10)
		Next
	EndIf

EndFunc   ;==>_GetCotationCasaMove()
;---------------------------------------------------------------------------------