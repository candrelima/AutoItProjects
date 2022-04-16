#include <File.au3>
#include <ButtonConstants.au3>
#include <GUIListBox.au3>
#include <7-FunctionsVisualizador.au3>
#include <FontConstants.au3>
#include <Misc.au3>
#include <Date.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <String.au3>
#include <Array.au3>
#include <StaticConstants.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ColorConstants.au3>
#include <Timers.au3>
#include <DateTimeConstants.au3>
#include <ProgressConstants.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <ImageSearch.au3>
#include <AutoItConstants.au3>
#include "Math.au3"
#include "5-Cores.au3"
;-------------------------------------------------------------------------
#Region ### VARIÁVEIS
Local $hDLL = DllOpen("user32.dll")
Global $coordsbuy[2], $coordssell[2], _
		$coordsqtdbuy[4], $coordsqtdsell[4], _
		$coordsqtdbuydezena[14], $coordsqtdbuyunidade[14], _
		$coordsqtdselldezena[14], $coordsqtdsellunidade[14], _
		$coordsconexao[2], $coordsdif2disaply[2], $dif2display, _
		$coordsmilharc[14], $coordscentenac[14], $coordsdezenac[14], $coordsunidadec[14], _
		$coordsmilharv[14], $coordscentenav[14], $coordsdezenav[14], $coordsunidadev[14], _
		$coordshorad[14], $coordshorau[14], $coordsminutod[14], $coordsminutou[14], $coordssegundod[14], $coordssegundou[14]

Global $salvar = False, $numcor, $complete = False, $ligado = False, $i = 0, $ativo, $tipo, _
		$leep = 25, $beep = 1440, $messageErro = "DADOS NÃO LOCALIZADOS" & @CRLF
Global $playCot, $dados, $play, $leilao, $placas[7], $conectado
#EndRegion
;-------------------------------------------------------------------------

; _PararMarket()
Func _PararMarket()

	If $play Then
		$play = False
		While _IsPressed("71", $hDLL)
			Sleep(25)
		WEnd
	EndIf
;~ 	HotKeySet("{F2}")
;~ 	Send("{F2}")
;~ 	HotKeySet("{F2}", "_PararMarket")

EndFunc   ;==>_PararMarket
;-------------------------------------------------------------------------


; _CreateFile()
Func _CreateFile()

	Local $nomearquivo = InputBox("NOME DO ARQUIVO", "DIGITE O NOME DO ARQUIVO A SER CRIADO:", "", "", 250, 150, 50, 50)

	$file = $nomearquivo & ".txt"
	Local $pathfile = @ScriptFullPath & $file
	If Not FileExists($pathfile) Then
		$file = FileOpen($file, $FO_APPEND)
		If $file = -1 Then
			MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO ABRIR ARQUIVO REPLAY - " & $file)
			Return False
		EndIf
		FileWrite($file, "COTAÇÕES" & @CRLF)
		Return $file
	Else
		MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO SALVAR ARQUIVO REPLAY - " & $file)
		Return False
	EndIf

EndFunc   ;==>_CreateFile()
;-------------------------------------------------------------------------


; _capturarcoordsTipo()
Func _capturarcoordsTipo($tipo)

	Local $out = False, $resp

	While Not $out

		$cor = "0x" & Hex(PixelGetColor(MouseGetPos(0), MouseGetPos(1)), 6)
		ToolTip("", MouseGetPos(0), MouseGetPos(1), "")
		Sleep($leep)

		If $cor == "0x0000FF" Then ; $COR_COMPRA
			ToolTip("0x0000FF", MouseGetPos(0), MouseGetPos(1), "COMPRA", $TIP_INFOICON)
			Beep($beep, 5)
			Sleep($leep)
		EndIf
		If $cor == "0xFF0000" Then ; $COR_VENDA
			ToolTip("0xFF0000", MouseGetPos(0), MouseGetPos(1), "VENDA", $TIP_INFOICON)
			Beep($beep, 5)
			Sleep($leep)
		EndIf
		If $cor == "0x00EE5E" Then ; $COR_CONEXAO
			ToolTip("0x00EE5E", MouseGetPos(0), MouseGetPos(1), "CONEXÃO", $TIP_INFOICON)
			Beep($beep, 5)
			Sleep($leep)
		EndIf
		If $tipo = "HORA" Then ; HORA
			If _IsPressed("31", $hDLL) Then
				GUICtrlSetData($Inputhorax1, "")
				GUICtrlSetData($Inputhoray1, "")
				$coordshora[0] = MouseGetPos(0)
				$coordshora[1] = MouseGetPos(1)
				GUICtrlSetData($Inputhorax1, MouseGetPos(0))
				GUICtrlSetData($Inputhoray1, MouseGetPos(1))
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				GUICtrlSetData($Inputhorax2, "")
				GUICtrlSetData($Inputhoray2, "")
				$coordshora[2] = MouseGetPos(0)
				$coordshora[3] = MouseGetPos(1)
				GUICtrlSetData($Inputhorax2, MouseGetPos(0))
				GUICtrlSetData($Inputhoray2, MouseGetPos(1))
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "PAINEL" Then ; PAINEL
			If _IsPressed("31", $hDLL) Then
				GUICtrlSetData($Inputpainelx1, "")
				GUICtrlSetData($Inputpainely1, "")
				$coordspainel[0] = MouseGetPos(0)
				$coordspainel[1] = MouseGetPos(1)
				GUICtrlSetData($Inputpainelx1, MouseGetPos(0))
				GUICtrlSetData($Inputpainely1, MouseGetPos(1))
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				GUICtrlSetData($Inputpainelx2, "")
				GUICtrlSetData($Inputpainely2, "")
				$coordspainel[2] = MouseGetPos(0)
				$coordspainel[3] = MouseGetPos(1)
				GUICtrlSetData($Inputpainelx2, MouseGetPos(0))
				GUICtrlSetData($Inputpainely2, MouseGetPos(1))
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "CONEXAO" Then ; CONEXAO
			If _IsPressed("31", $hDLL) Then
				GUICtrlSetData($Inputconexaox1, "")
				GUICtrlSetData($Inputconexaoy1, "")
				$coordsconexao[0] = MouseGetPos(0)
				$coordsconexao[1] = MouseGetPos(1)
				GUICtrlSetData($Inputconexaox1, MouseGetPos(0))
				GUICtrlSetData($Inputconexaoy1, MouseGetPos(1))
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				GUICtrlSetData($Inputconexaox2, "")
				GUICtrlSetData($Inputconexaoy2, "")
				$coordsconexao[2] = MouseGetPos(0)
				$coordsconexao[3] = MouseGetPos(1)
				GUICtrlSetData($Inputconexaox2, MouseGetPos(0))
				GUICtrlSetData($Inputconexaoy2, MouseGetPos(1))
				Sleep($leep)
			EndIf
		EndIf
		If _IsPressed("30", $hDLL) Then
			$resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
			EndIf
		EndIf
	WEnd
	If $tipo = "HORA" Then ; HORA
		Return $coordshora
	EndIf
	If $tipo = "PAINEL" Then ; PAINEL
		Return $coordspainel
	EndIf
	If $tipo = "CONEXAO" Then ; CONEXAO
		Return $coordsconexao
	EndIf

EndFunc   ;==>_capturarcoordsTipo()
;-------------------------------------------------------------------------


; _capturarcoordsBuySell()
Func _capturarcoordsBuySell($tipo)

	Local $out = False, $resp, $coords, $compracor, _
			$vendacor, $conexaocor, $replaycor, _
			$leilaocor, $cor

	If $tipo = 1 Then
		GUICtrlSetData($Inputbuyx, "")
		GUICtrlSetData($Inputbuyy, "")
	EndIf
	If $tipo = 2 Then
		GUICtrlSetData($Inputsellx, "")
		GUICtrlSetData($Inputselly, "")
	EndIf
	If $tipo = 3 Then
		GUICtrlSetData($Inputdif2display, "")
	EndIf
	If $tipo = 4 Then
		GUICtrlSetData($Inputconexaox, "")
		GUICtrlSetData($Inputconexaoy, "")
	EndIf
	If $tipo = 5 Then
		GUICtrlSetData($InputreplayORpregaox, "")
		GUICtrlSetData($InputreplayORpregaoy, "")
	EndIf
	If $tipo = 6 Then
		GUICtrlSetData($Inputqtdcomprax, "")
		GUICtrlSetData($Inputqtdcompray, "")
		GUICtrlSetData($Inputqtdcompraxx, "")
		GUICtrlSetData($Inputqtdcomprayy, "")
	EndIf
	If $tipo = 7 Then
		GUICtrlSetData($Inputqtdvendax, "")
		GUICtrlSetData($Inputqtdvenday, "")
		GUICtrlSetData($Inputqtdvendaxx, "")
		GUICtrlSetData($Inputqtdvendayy, "")
	EndIf

	While Not $out

		$coords = MouseGetPos()
		$cor = PixelGetColor($coords[0], $coords[1])
		$cor = "0x" & Hex($cor, 6)

		If $cor == "0x0000FF" Then
			ToolTip("0x0000FF", $coords[0], $coords[1], "COMPRA")
			Beep(500, 25)
			Sleep(5)
		ElseIf $cor == "0xFF0000" Then
			ToolTip("0xFF0000", $coords[0], $coords[1], "VENDA")
			Beep(500, 25)
			Sleep(5)
		ElseIf $cor == "0x00EE5E" Then
			ToolTip("0x00EE5E", $coords[0], $coords[1], "CONEXÃO")
			Beep(500, 25)
			Sleep(5)
		ElseIf $cor == "0xE0A521" Then
			ToolTip("0xE0A521", $coords[0], $coords[1], "REPLAY")
			Beep(500, 25)
			Sleep(5)
		ElseIf $cor == "0x178CFF" Then
			ToolTip("0x178CFF", $coords[0], $coords[1], "LEILÃO")
			Beep(500, 25)
			Sleep(5)
		Else
			ToolTip("", $coords[0], $coords[1], "")
			Sleep(5)
		EndIf

		If $tipo == 6 Then
			If _IsPressed("31", $hDLL) Then
				GUICtrlSetData($Inputqtdcomprax, $coords[0])
				GUICtrlSetData($Inputqtdcompray, $coords[1])
				$coordsqtdbuy[0] = $coords[0]
				$coordsqtdbuy[1] = $coords[1]
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				GUICtrlSetData($Inputqtdcompraxx, $coords[0])
				GUICtrlSetData($Inputqtdcomprayy, $coords[1])
				$coordsqtdbuy[2] = $coords[0]
				$coordsqtdbuy[3] = $coords[1]
				Sleep($leep)
			EndIf
		ElseIf $tipo == 7 Then
			If _IsPressed("31", $hDLL) Then
				GUICtrlSetData($Inputqtdvendax, $coords[0])
				GUICtrlSetData($Inputqtdvenday, $coords[1])
				$coordsqtdsell[0] = $coords[0]
				$coordsqtdsell[1] = $coords[1]
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				GUICtrlSetData($Inputqtdvendaxx, $coords[0])
				GUICtrlSetData($Inputqtdvendayy, $coords[1])
				$coordsqtdsell[2] = $coords[0]
				$coordsqtdsell[3] = $coords[1]
				Sleep($leep)
			EndIf
		Else
			If _IsPressed("31", $hDLL) Then
				If $tipo == 1 Then
					GUICtrlSetData($Inputbuyx, $coords[0])
					GUICtrlSetData($Inputbuyy, $coords[1])
				EndIf
				If $tipo == 2 Then
					GUICtrlSetData($Inputsellx, $coords[0])
					GUICtrlSetData($Inputselly, $coords[1])
				EndIf
				If $tipo == 3 Then
	;~ 				GUICtrlSetData($Inputdif2display, $coords[0])
					GUICtrlSetData($Inputdif2display, $coords[1])
				EndIf
				If $tipo == 4 Then
					GUICtrlSetData($Inputconexaox, $coords[0])
					GUICtrlSetData($Inputconexaoy, $coords[1])
				EndIf
				If $tipo == 5 Then
					GUICtrlSetData($InputreplayORpregaox, $coords[0])
					GUICtrlSetData($InputreplayORpregaoy, $coords[1])
				EndIf
				Sleep($leep)
			EndIf
		EndIf
		If _IsPressed("30", $hDLL) Then
			$resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
			EndIf
			Sleep($leep)
		EndIf
	WEnd
	If $tipo == 6 Then
		Return $coordsqtdbuy
	ElseIf $tipo == 7 Then
		Return $coordsqtdsell
	ElseIf IsArray($coords) Then
		Return $coords
	Else
		Return 0
	EndIf

EndFunc   ;==>_capturarcoordsBuySell
;-------------------------------------------------------------------------


; _LookPlaca()
Func _LookPlaca($beep)

	Local $placa[2], $cor
	$cor = "0x" & Hex(PixelGetColor(MouseGetPos(0), MouseGetPos(1)), 6)
	If $cor == "0xFFFFFF" Or $cor == "0xE6E6E6" Then ; $COR_PLACA ou $COR_RELOGIO
		ToolTip(MouseGetPos(0) & " x " & MouseGetPos(1), MouseGetPos(0), MouseGetPos(1), "PLACA", $TIP_INFOICON)
		Beep($beep, 5)
	Else
		ToolTip("", MouseGetPos(0), MouseGetPos(1), "PLACA", $TIP_INFOICON)
	EndIf
	_ArrayPush($placa, MouseGetPos(0))
	_ArrayPush($placa, MouseGetPos(1))
	Return $placa

EndFunc ;==>_LookPlaca()
;-------------------------------------------------------------------------


; LoadInput()
Func _LoadInput($botao, $posicao, $num)

	Global $arrayLabels = [[$Labelplaca1hd, $Labelplaca2hd, $Labelplaca3hd, $Labelplaca4hd, $Labelplaca5hd, $Labelplaca6hd, $Labelplaca7hd], _ ; HORA D
							[$Labelplaca1hu, $Labelplaca2hu, $Labelplaca3hu, $Labelplaca4hu, $Labelplaca5hu, $Labelplaca6hu, $Labelplaca7hu], _ ; HORA U
							[$Labelplaca1md, $Labelplaca2md, $Labelplaca3md, $Labelplaca4md, $Labelplaca5md, $Labelplaca6md, $Labelplaca7md], _ ; MINUTO D
							[$Labelplaca1mu, $Labelplaca2mu, $Labelplaca3mu, $Labelplaca4mu, $Labelplaca5mu, $Labelplaca6mu, $Labelplaca7mu], _ ; MINUTO U
							[$Labelplaca1sd, $Labelplaca2sd, $Labelplaca3sd, $Labelplaca4sd, $Labelplaca5sd, $Labelplaca6sd, $Labelplaca7sd], _ ; SEGUNDO D
							[$Labelplaca1su, $Labelplaca2su, $Labelplaca3su, $Labelplaca4su, $Labelplaca5su, $Labelplaca6su, $Labelplaca7su]]   ; SEGUNDO U


	If $botao == "HORA" Then
		GUICtrlSetData($Inputhorax1, "")
		GUICtrlSetData($Inputhoray1, "")
		GUICtrlSetData($Inputhorax2, "")
		GUICtrlSetData($Inputhoray2, "")
		GUICtrlSetData($Inputhorax1, $posicao[0])
		GUICtrlSetData($Inputhoray1, $posicao[1])
		GUICtrlSetData($Inputhorax2, $posicao[2])
		GUICtrlSetData($Inputhoray2, $posicao[3])
	EndIf
	If $botao == "PAINEL" Then
		GUICtrlSetData($Inputpainelx1, "")
		GUICtrlSetData($Inputpainely1, "")
		GUICtrlSetData($Inputpainelx2, "")
		GUICtrlSetData($Inputpainely2, "")
		GUICtrlSetData($Inputpainelx1, $posicao[0])
		GUICtrlSetData($Inputpainely1, $posicao[1])
		GUICtrlSetData($Inputpainelx2, $posicao[2])
		GUICtrlSetData($Inputpainely2, $posicao[3])
	EndIf
	If $botao == "CONEXAO" Then
		GUICtrlSetData($Inputconexaox1, "")
		GUICtrlSetData($Inputconexaoy1, "")
		GUICtrlSetData($Inputconexaox2, "")
		GUICtrlSetData($Inputconexaoy2, "")
		GUICtrlSetData($Inputconexaox1, $posicao[0])
		GUICtrlSetData($Inputconexaoy1, $posicao[1])
		GUICtrlSetData($Inputconexaox2, $posicao[2])
		GUICtrlSetData($Inputconexaoy2, $posicao[3])
	EndIf
	If $botao == "HORA D" Then
		GUICtrlSetData($arrayLabels[0][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao == "HORA U" Then
		GUICtrlSetData($arrayLabels[1][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao == "MINU D" Then
		GUICtrlSetData($arrayLabels[2][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao == "MINU U" Then
		GUICtrlSetData($arrayLabels[3][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao == "SEGS D" Then
		GUICtrlSetData($arrayLabels[4][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao == "SEGS U" Then
		GUICtrlSetData($arrayLabels[5][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf

EndFunc ;==>_LoadInput()
;-------------------------------------------------------------------------


; _capturarcoordsPlacas()
Func _capturarcoordsPlacas($botao)

	Local $allcoords[14], $out = False, $posicao[2]

	While Not $out

		Sleep(15)
		$posicao = _LookPlaca($beep)

		If _IsPressed("31", $hDLL) Then
			$allcoords[0] = $posicao[0]
			$allcoords[1] = $posicao[1]
			While _IsPressed("31", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 1)
		EndIf
		If _IsPressed("32", $hDLL) Then
			$allcoords[2] = $posicao[0]
			$allcoords[3] = $posicao[1]
			While _IsPressed("32", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 2)
		EndIf
		If _IsPressed("33", $hDLL) Then
			$allcoords[4] = $posicao[0]
			$allcoords[5] = $posicao[1]
			While _IsPressed("33", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 3)
		EndIf
		If _IsPressed("34", $hDLL) Then
			$allcoords[6] = $posicao[0]
			$allcoords[7] = $posicao[1]
			While _IsPressed("34", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 4)
		EndIf
		If _IsPressed("35", $hDLL) Then
			$allcoords[8] = $posicao[0]
			$allcoords[9] = $posicao[1]
			While _IsPressed("35", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 5)
		EndIf
		If _IsPressed("36", $hDLL) Then
			$allcoords[10] = $posicao[0]
			$allcoords[11] = $posicao[1]
			While _IsPressed("36", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 6)
		EndIf
		If _IsPressed("37", $hDLL) Then
			$allcoords[12] = $posicao[0]
			$allcoords[13] = $posicao[1]
			While _IsPressed("37", $hDLL)
				Sleep($leep)
			WEnd
			; MODIFICANDO LABEL
			_LoadInput($botao, $posicao, 7)
		EndIf
		If _IsPressed("30", $hDLL) Then
			Local $resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
			EndIf
			While _IsPressed("30", $hDLL)
				Sleep($leep)
			WEnd
		EndIf

	WEnd ; SAIR SE $out = TRUE
	Return $allcoords

EndFunc   ;==>_capturarcoordsPlacas()
;-------------------------------------------------------------------------


; _SalvarParametros()
Func _SalvarParametros($cor, $dif2display)

	Local $bar = GUICreate("SALVANDO DADOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	Local $Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, 32250)

;~ 	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")
	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS", @ScriptDir & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")

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

		If GUICtrlGetState($Radiodol) == $GUI_CHECKED Then
			$ativo = GUICtrlRead($Radiodol, $GUI_READ_EXTENDED)
		ElseIf GUICtrlGetState($Radioind) == $GUI_CHECKED Then
			$ativo = GUICtrlRead($Radioind, $GUI_READ_EXTENDED)
		ElseIf GUICtrlGetState($Radiowdo) == $GUI_CHECKED Then
			$ativo = GUICtrlRead($Radiowdo, $GUI_READ_EXTENDED)
		ElseIf GUICtrlGetState($Radiowin) == $GUI_CHECKED Then
			$ativo = GUICtrlRead($Radiowin, $GUI_READ_EXTENDED)
		EndIf
		If GUICtrlGetState($Radioreplay) == $GUI_CHECKED Then
			$tipo = GUICtrlRead($Radioreplay, $GUI_READ_EXTENDED)
		ElseIf GUICtrlGetState($Radiopregao) == $GUI_CHECKED Then
			$tipo = GUICtrlRead($Radiopregao, $GUI_READ_EXTENDED)
		EndIf

		If Not IsNumber($coordsbuy[1]) Or Not IsNumber($coordsqtdbuy[1]) Or _ ; buy e qtdbuy
			Not IsNumber($coordssell[1]) Or Not IsNumber($coordsqtdsell[1]) Or _ ; sell e qtdsell
			Not IsNumber($coordsconexao[1]) Or Not IsNumber($dif2display) Or _ ; conexão e difdistdisplay
			Not IsNumber($coordsqtdbuydezena[1]) Or Not IsNumber($coordsqtdbuyunidade[1]) Or _ ; dezena unidade qtd compra
			Not IsNumber($coordsqtdselldezena[1]) Or Not IsNumber($coordsqtdsellunidade[1]) Or _ ; dezena unidade qtd venda
			Not IsNumber($coordsmilharc[1]) Or Not IsNumber($coordscentenac[1]) Or _  ; milhar centena compra
			Not IsNumber($coordsdezenac[1]) Or Not IsNumber($coordsunidadec[1]) Or _ ; dezena unidade compra
			Not IsNumber($coordsmilharv[1]) Or Not IsNumber($coordscentenav[1]) Or _ ; milhar centena venda
			Not IsNumber($coordsdezenav[1]) Or Not IsNumber($coordsunidadev[1]) Or _ ; dezena unidade venda
			Not IsNumber($coordshorad[1]) Or Not IsNumber($coordshorau[1]) Or _ ; hora dezena e unidade
			Not IsNumber($coordsminutod[1]) Or Not IsNumber($coordsminutou[1]) Or _ ; minuto dezena e unidade
			Not IsNumber($coordssegundod[1]) Or Not IsNumber($coordssegundou[1]) Then ; segundo dezena e unidade

			MsgBox(48, "ALERTA", "DADOS INCOMPLETOS" & @CRLF & _
					"ATENÇÃO: Dados incompletos ocasionará o mal " & @CR & _
					"funcionamento do programa. É necessário realizar" & @CR & _
					"o correto mapeamento de todas as coordenadas" & @CR & _
					"para garantir a integridade do programa." & @CR & _
					"Reading data fail.", 2)

			GUIDelete($bar)
		Else
			GUISetState(@SW_SHOW)
			; buy e qtdbuy
			IniWrite($arqsaved, "buy", "1", $coordsbuy[0])
			Sleep($leep)
			IniWrite($arqsaved, "buy", "2", $coordsbuy[1])
			Sleep($leep)
			IniWrite($arqsaved, "qtdbuy", "1", $coordsqtdbuy[0])
			IniWrite($arqsaved, "qtdbuy", "2", $coordsqtdbuy[1])
			IniWrite($arqsaved, "qtdbuy", "3", $coordsqtdbuy[2])
			IniWrite($arqsaved, "qtdbuy", "4", $coordsqtdbuy[3])
			Sleep($leep)
			; sell e qtdsell
			IniWrite($arqsaved, "sell", "1", $coordssell[0])
			Sleep($leep)
			IniWrite($arqsaved, "sell", "2", $coordssell[1])
			Sleep($leep)
			IniWrite($arqsaved, "qtdsell", "1", $coordsqtdsell[0])
			IniWrite($arqsaved, "qtdsell", "2", $coordsqtdsell[1])
			IniWrite($arqsaved, "qtdsell", "3", $coordsqtdsell[2])
			IniWrite($arqsaved, "qtdsell", "4", $coordsqtdsell[3])
			GUICtrlSetData($Progressler, 10)
			Sleep($leep)
			; dezena unidade compra
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "qtdbuydezena", String($i + 1), $coordsqtdbuydezena[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "qtdbuyunidade", String($i + 1), $coordsqtdbuyunidade[$i])
			Next
			; dezena unidade qtd venda
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "qtdselldezena", String($i + 1), $coordsqtdselldezena[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "qtdsellunidade", String($i + 1), $coordsqtdsellunidade[$i])
			Next
			; milhar centena dezena unidade compra
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "milharc", String($i + 1), $coordsmilharc[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "centenac", String($i + 1), $coordscentenac[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "dezenac", String($i + 1), $coordsdezenac[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "unidadec", String($i + 1), $coordsunidadec[$i])
			Next
			Sleep($leep)
			; milhar centena dezena unidade venda
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "milharv", String($i + 1), $coordsmilharv[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "centenav", String($i + 1), $coordscentenav[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "dezenav", String($i + 1), $coordsdezenav[$i])
			Next
			Sleep($leep)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "unidadev", String($i + 1), $coordsunidadev[$i])
			Next
			Sleep($leep)
			GUICtrlSetData($Progressler, 50)

			; hora dezena e unidade
			; minuto dezena e unidade
			; segundo dezena e unidade
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "horad", String($i + 1), $coordshorad[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "horau", String($i + 1), $coordshorau[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "minutod", String($i + 1), $coordsminutod[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "minutou", String($i + 1), $coordsminutou[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "segundod", String($i + 1), $coordssegundod[$i])
			Next
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "segundou", String($i + 1), $coordssegundou[$i])
			Next
			; conexão e difdistdisplay
			IniWrite($arqsaved, "conexao", "1", $coordsconexao[0])
			Sleep($leep)
			IniWrite($arqsaved, "conexao", "2", $coordsconexao[1])
			Sleep($leep)
			IniWrite($arqsaved, "modoconexao", "1", $coordsreplayORpregao[0])
			Sleep($leep)
			IniWrite($arqsaved, "modoconexao", "2", $coordsreplayORpregao[1])
			Sleep($leep)
			IniWrite($arqsaved, "distDisplay", "1", $dif2display)


			; diversos
			IniWrite($arqsaved, "ativo", "1", $ativo)
			Sleep($leep)
			IniWrite($arqsaved, "mercado", "1", $tipo)
			Sleep($leep)
			IniWrite($arqsaved, "tema", "1", $cor)
			GUICtrlSetData($Progressler, 100)
			Sleep($leep)

			MsgBox($MB_SYSTEMMODAL, "DADOS", "SUCESSO: DADOS COMPLETOS" & @CRLF & $arqsaved, 2)

			GUIDelete($bar)
			Return 1
		EndIf
	EndIf

EndFunc   ;==>_SalvarParametros
;-------------------------------------------------------------------------


; _AbrirParametros()
Func _AbrirParametros()

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
		; --------------------------------------------------------------------------- HORAD -----
		$section = IniReadSection($arqopened, "horad")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordshorad, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordshorad, "$coordshorad")
			GUICtrlSetBkColor($Buttonhorad, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonhorad, $COLOR_RED)
			$messageErro += "COORDENADAS DA HORA(DEZENA)" & @CRLF
		EndIf
		GUICtrlSetData($Progressler, 5)
		; --------------------------------------------------------------------------- HORAU -----
		$section = IniReadSection($arqopened, "horau")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordshorau, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordshorau, "$coordshorau")
			GUICtrlSetBkColor($Buttonhorau, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonhorau, $COLOR_RED)
			$messageErro += "COORDENADAS DA HORA(UNIDADE)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MINUTOD -----
		$section = IniReadSection($arqopened, "minutod")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsminutod, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsminutod, "$coordsminutod")
			GUICtrlSetBkColor($Buttonminutod, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonminutod, $COLOR_RED)
			$messageErro += "COORDENADAS DA MINUTO(DEZENA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MINUTOU -----
		$section = IniReadSection($arqopened, "minutou")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsminutou, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsminutou, "$coordsminutou")
			GUICtrlSetBkColor($Buttonminutou, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonminutou, $COLOR_RED)
			$messageErro += "COORDENADAS DA MINUTO(UNIDADE)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- SEGUNDOD -----
		$section = IniReadSection($arqopened, "segundod")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordssegundod, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordssegundod, "$coordssegundod")
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_RED)
			$messageErro += "COORDENADAS DA SEGUNDO(DEZENA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- SEGUNDOU -----
		$section = IniReadSection($arqopened, "segundou")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordssegundou, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordssegundou, "$coordssegundou")
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_RED)
			$messageErro += "COORDENADAS DA SEGUNDO(UNIDADE)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- BUY ------
		; LER AS KEYS[1][0],[2][0],[3][0],...
		; LER OS VALORES[1][1],[2][1],[3][1],...
		$section = IniReadSection($arqopened, "buy")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordsbuy, Int($section[1][1]))
			_ArrayPush($coordsbuy, Int($section[2][1]))
;~ 		_ArrayDisplay($coordsbuy)
			GUICtrlSetData($Inputbuyx, $section[1][1])
			GUICtrlSetData($Inputbuyy, $section[2][1])
			GUICtrlSetBkColor($Buttoncompra, $COLOR_LIME)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA COMPRA" & @CR
		EndIf
		; --------------------------------------------------------------------------- SELL ------
		$section = IniReadSection($arqopened, "sell")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordssell, Int($section[1][1]))
			_ArrayPush($coordssell, Int($section[2][1]))
;~ 			_ArrayDisplay($coordssell)
			GUICtrlSetData($Inputsellx, $section[1][1])
			GUICtrlSetData($Inputselly, $section[2][1])
			GUICtrlSetBkColor($Buttonvenda, $COLOR_LIME)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA VENDA" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- DIST DISPLAY ------
		$section = IniReadSection($arqopened, "distDisplay")
		If IsNumber(Int($section[1][1])) Then
			$dif2display = Int($section[1][1])
			GUICtrlSetData($Inputdif2display, $section[1][1])
;~ 			MsgBox(0, "", "DISTÂNCIA ENTRE COTAÇOES: " & $coordsdif2display, 2)
			GUICtrlSetBkColor($Buttondif2display, $COLOR_LIME)
			Sleep($leep)
		Else
			$messageErro += "COORDENADA DIFERENÇA ENTRE COTAÇÕES" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- QTD COMPRA DEZENA ------
		$section = IniReadSection($arqopened, "qtdbuydezena")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdbuydezena, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsqtdbuydezena, "$coordsqtdbuydezena")
			GUICtrlSetBkColor($ButtonqtdCompraD, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdCompraD, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD COMPRA DEZENA" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- QTD COMPRA UNIDADE ------
		$section = IniReadSection($arqopened, "qtdbuyunidade")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdbuyunidade, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsqtdbuyunidade, "$coordsqtdbuyunidade")
			GUICtrlSetBkColor($ButtonqtdCompraU, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdCompraU, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD COMPRA UNIDADE" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- QTD VENDA DEZENA ------
		$section = IniReadSection($arqopened, "qtdselldezena")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdselldezena, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsqtdselldezena, "$coordsqtdselldezena")
			GUICtrlSetBkColor($ButtonqtdVendaD, $COLOR_LIME)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdVendaD, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD VENDA DEZENA" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- QTD VENDA UNIDADE ------
		$section = IniReadSection($arqopened, "qtdsellunidade")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsqtdsellunidade, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsqtdsellunidade, "$coordsqtdsellunidade")
			GUICtrlSetBkColor($ButtonqtdVendaU, $COLOR_LIME)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdVendaU, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD VENDA UNIDADE" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MILHARC -----
		$section = IniReadSection($arqopened, "milharc")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsmilharc, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsmilharc, "$coordsmilharc")
			GUICtrlSetBkColor($Buttonmilharc, $COLOR_LIME)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharc, $COLOR_RED)
			$messageErro += "COORDENADAS DA MILHAR(COMPRA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- CENTENAC -----
		$section = IniReadSection($arqopened, "centenac")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentenac, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordscentenac, "$coordscentenac")
			GUICtrlSetBkColor($Buttoncentenac, $COLOR_LIME)
;~ 			ConsoleWrite("60% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentenac, $COLOR_RED)
			$messageErro += "COORDENADAS DA CENTENA(COMPRA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- DEZENAC -----
		$section = IniReadSection($arqopened, "dezenac")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsdezenac, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsdezenac, "$coordsdezenac")
			GUICtrlSetBkColor($Buttondezenac, $COLOR_LIME)
;~ 			ConsoleWrite("65% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenac, $COLOR_RED)
			$messageErro += "COORDENADAS DA DEZENA(COMPRA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- UNIDADEC -----
		$section = IniReadSection($arqopened, "unidadec")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsunidadec, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsunidadec, "$coordsunidadec")
			GUICtrlSetBkColor($Buttonunidadec, $COLOR_LIME)
;~ 			ConsoleWrite("70% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadec, $COLOR_RED)
			$messageErro += "COORDENADAS DA UNIDADE(COMPRA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MILHARV ----
		$section = IniReadSection($arqopened, "milharv")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsmilharv, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsmilharv, "$coordsmilharv")
			GUICtrlSetBkColor($Buttonmilharv, $COLOR_LIME)
;~ 			ConsoleWrite("75% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharv, $COLOR_RED)
			$messageErro += "COORDENADAS DA MILHAR(VENDA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- CENTENAV ----
		$section = IniReadSection($arqopened, "centenav")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordscentenav, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordscentenav, "$coordscentenav")
			GUICtrlSetBkColor($Buttoncentenav, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($coordscentenav, $COLOR_RED)
			$messageErro += "COORDENADAS DA CENTENA(VENDA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- DEZENAV ----
		$section = IniReadSection($arqopened, "dezenav")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsdezenav, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsdezenav, "$coordsdezenav")
			GUICtrlSetBkColor($Buttondezenav, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenav, $COLOR_RED)
			$messageErro += "COORDENADAS DA DEZENA(VENDA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- UNIDADEV ----
		$section = IniReadSection($arqopened, "unidadev")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[3][1])) _
		And IsNumber(Int($section[5][1])) And IsNumber(Int($section[7][1])) _
		And IsNumber(Int($section[9][1])) And IsNumber(Int($section[11][1])) _
		And IsNumber(Int($section[13][1])) Then
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsunidadev, $section[$i][1])
			Next
;~ 			_ArrayDisplay($coordsunidadev, "$coordsunidadev")
			GUICtrlSetBkColor($Buttonunidadev, $COLOR_LIME)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadev, $COLOR_RED)
			$messageErro += "COORDENADAS DA UNIDADE(VENDA)" & @CRLF
		EndIf
		; --------------------------------------------------------------------------- CONLCUSÃO ----
		GUICtrlSetData($Progress, 100)

		If GUICtrlRead($Progressler) == 100 Then
			MsgBox(48, "RESUMO", "DADOS 100% LIDOS COM SUCESSO.", 2)
			GUIDelete($bar)
			Return 1
		Else
			MsgBox(48, "RESUMO", $messageErro)
			Return 0
		EndIf
	EndIf

EndFunc   ;==>_AbrirParametros()
;-------------------------------------------------------------------------


; _ColetarDigitos()
Func _ColetarDigitos($arrayCoords, $ord, $tipo)

	Local $placamilhar, $placacentena, $placadezena, $placaunidade, $placas[14]
	Local $m, $c, $d, $u

	If $tipo == "preço" Then
		Local $arrayNumber[4]
;~	 	ConsoleWrite("<<< ")
		$placamilhar = _GetCotationCasa($arrayCoords[0], $ord, $COR_PLACA)
;~ 	 	_ArrayDisplay($placamilhar, "$placas")
		$m = _FindNumber($placamilhar)
		_ArrayPush($arrayNumber, $m)
		$placacentena = _GetCotationCasa($arrayCoords[1], $ord, $COR_PLACA)
;~	 	 _ArrayDisplay($placacentena, "$placas")
		$c = _FindNumber($placacentena)
		_ArrayPush($arrayNumber, $c)
		$placadezena = _GetCotationCasa($arrayCoords[2], $ord, $COR_PLACA)
;~	 	_ArrayDisplay($placadezena, "$placas")
		$d = _FindNumber($placadezena)
		_ArrayPush($arrayNumber, $d)
		$placaunidade = _GetCotationCasa($arrayCoords[3], $ord, $COR_PLACA)
;~	 	_ArrayDisplay($placaunidade, "$placas")
		$u = _FindNumber($placaunidade)
		_ArrayPush($arrayNumber, $u)
		Return $arrayNumber
	ElseIf $tipo == "qtd" Then
		Local $arrayNumber[1]
		$placas = _GetCotationCasa($arrayCoords, $ord, $COR_PLACA)
;~ 	 	_ArrayDisplay($placas, "$placas")
		$u = _FindNumber($placas)
		_ArrayPush($arrayNumber, $u)
;~ 	 	_ArrayDisplay($arrayNumber, "$arrayNumber")

		Return $arrayNumber
	EndIf

EndFunc		;==>_ColetarDigitos
;-------------------------------------------------------------------------


; _TestePosica()
Func _TestePosicao($playCot)

	Local $ordemcompra = 0, $ordemvenda = 0
	Local $compra, $venda

	Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec]
	Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev]

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)

	; INICIAR PROGRAMA

	$play = $playCot
;~ 	$dados = _CreateFile($tipo, "teste_posição")

	While $play

		$conectado = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[0]+1, $coordsconexao[1]+1, $COR_CONECTADO, 5, 1)

		If IsArray($conectado) Then

			GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: TESTING HORA", 1, 1)

			; captar horário
			#Region
			$horad 		= _GetCotationCasa($coordshorad, 0, $COR_PLACA)
			$horad 		= _FindNumber($horad)
			$horau		= _GetCotationCasa($coordshorau, 0, $COR_PLACA)
			$horau		= _FindNumber($horau)
			$minutod 	= _GetCotationCasa($coordsminutod, 0, $COR_PLACA)
			$minutod 	= _FindNumber($minutod)
			$minutou 	= _GetCotationCasa($coordsminutou, 0, $COR_PLACA)
			$minutou 	= _FindNumber($minutou)
			$segundod 	= _GetCotationCasa($coordssegundod, 0, $COR_PLACA)
			$segundod 	= _FindNumber($segundod)
			$segundou 	= _GetCotationCasa($coordssegundou, 0, $COR_PLACA)
			$segundou 	= _FindNumber($segundou)
			$time 		= $horad&$horau& ":" &$minutod&$minutou& ":" &$segundod&$segundou
			GUICtrlSetData($Labelhora, $time)
			#EndRegion

			; compra
			$compra	= _HasBuyCotation($coordsbuy, $ordemcompra, $COR_COMPRA)
			While $compra
				ToolTip("<<F2=STOP>>", 0, 0, "STATUS: TESTING BUY", 1, 1)
				$compraOrdens = _ColetarDigitos($arrayCoordsBuy, $ordemcompra, "preço")
				$qtdcompraD	= _ColetarDigitos($coordsqtdbuydezena, $ordemcompra, "qtd")
				$qtdcompraU	= _ColetarDigitos($coordsqtdbuyunidade, $ordemcompra, "qtd")

				; reavaliar se há próxima compra
				$compra	= _HasBuyCotation($coordsbuy, $ordemcompra, $COR_COMPRA)
				If $compra = 0 Then
					; zerando valores
					$ordemcompra = 0
					ExitLoop
				Else
					$ordemcompra += 1
				EndIf
			WEnd

			; venda
			$venda	= _HasSellCotation($coordssell, $ordemvenda, $COR_VENDA)
			While $venda
				ToolTip("<<F2=STOP>>", 0, 0, "STATUS: TESTING SELL", 1, 1)
				$vendaOrdens = _ColetarDigitos($arrayCoordsSell, $ordemvenda, "preço")
				$qtdvendaD	= _ColetarDigitos($coordsqtdselldezena, $ordemvenda, "qtd")
				$qtdvendaU	= _ColetarDigitos($coordsqtdsellunidade, $ordemvenda, "qtd")

				; reavaliar se há próxima venda
				$venda	= _HasSellCotation($coordssell, $ordemvenda, $COR_VENDA)
				If $venda = 0 Then
					; zerando valores
					$ordemvenda = 0
					ExitLoop
				Else
					$ordemvenda += 1
				EndIf
			WEnd
		Else
			GUICtrlSetBkColor($Buttoniniciar, $COLOR_YELLOW)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)

			$ordemcompra			= 0
			$ordemvenda 			= 0
		EndIf
	WEnd
	GUICtrlSetData($Buttoniniciar, "INICIAR")
	GUICtrlSetState($Buttoniniciar, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
	MsgBox(0, "STATUS", "TESTE COORDENADAS COM SUCESSO - " & $time, 2)
	ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
	ToolTip("")

EndFunc   ;==>_TestePosicao
;---------------------------------------------------------------------------------


; _IniciarCotacao()
Func _IniciarCotacao($playCot, $tipo)

	Local $saved1 = 0, $saved2 = 0, $saved3 = 0
	Local $ordemcompra = 0, $ordemvenda = 0, _
			$qtdcompraD = 0, $qtdcompraU = 0, _
			$qtdvendaD = 0, $qtdvendaU = 0, $totalQtd = 0
	Local $compra = 0, $venda = 0, $buy = 0, $sell = 0, $time = "-:-:-", _
			$markInicial, $markFinal = 5, _
			$Buyparamediana = 0, $Sellparamediana = 0, _
			$BuyparamedianaGeral = 0, $SellparamedianaGeral = 0, _
			$somatorioQtdCompra = 0, $somatorioQtdCompraTotal = 0, _
			$somatorioQtdVenda = 0, $somatorioQtdVendaTotal = 0, _
			$medianaGeralMin = 10000, $medianaGeralMax = 0, _
			$medioGeral = 0
	Local $min = 10000, $max = 0, $open = 0, $close = 0, $ciclo = 1, _
			$medianaGeral = 0, $mediana_compra = 0, $mediana_venda = 0, _
			$compraOrdens = 0, $vendaOrdens = 0
	Local $mediana_venda = 0, $mediana_compra = 0
	Local $totalImagens
	Local $arrayCoordsBuy	= [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec]
	Local $arrayCoordsSell	= [$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev]

	Local $timeInit, $timeEnd, $totalTime, $resto

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)

	; INICIAR PROGRAMA
	$play = $playCot
	; SALVAR DADOS MEDIANA GERAL
	$dadosBuySell = _CreateFile($tipo, "DadosBuySell")
	; SALVAR DADOS EM GERAL
	$dadosEstudoGeral = _CreateFile($tipo, "DadosEstudoGeral")
	; SALVAR DADOS MAX, OPEN, CLOSE, MIN
	$dadosCandle = _CreateFile($tipo, "DadosCandle")

	Do
		$totalImagens = InputBox("ESTIMATIVA DE TEMPO", "Quantas imagens deseja calcular?", "", "")
		If $totalImagens = "" Then
			MsgBox(0, "ESTIMATIVA DE TEMPO", "VALOR INVÁLIDO")
			$play = False
			ExitLoop
		EndIf
	Until $totalImagens <> 0

	While $play

		$conectado = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[0]+1, $coordsconexao[1]+1, $COR_CONECTADO, 5, 1)

		If IsArray($conectado) Then

			GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: CONNECTED", 1, 1)

			$timeInit = _Timer_Init()
			; CAPTAR HORARIO
			#Region
			$horad 		= _GetCotationCasa($coordshorad, 0, $COR_PLACA)
			$horad 		= _FindNumber($horad)
			$horau		= _GetCotationCasa($coordshorau, 0, $COR_PLACA)
			$horau		= _FindNumber($horau)
			$minutod 	= _GetCotationCasa($coordsminutod, 0, $COR_PLACA)
			$minutod 	= _FindNumber($minutod)
			$minutou 	= _GetCotationCasa($coordsminutou, 0, $COR_PLACA)
			$minutou 	= _FindNumber($minutou)
			$segundod 	= _GetCotationCasa($coordssegundod, 0, $COR_PLACA)
			$segundod 	= _FindNumber($segundod)
			$segundou 	= _GetCotationCasa($coordssegundou, 0, $COR_PLACA)
			$segundou 	= _FindNumber($segundou)
			$time 		= String($horad&$horau& ":" &$minutod&$minutou& ":" &$segundod&$segundou)
			GUICtrlSetData($Labelhora, $time)

			$markInicial = $minutou
			#EndRegion

			#Region ; BUSCANDO COMPRAS E VENDAS
			; BUSCANDO COMPRAS
			$saved1 = FileWrite($dadosBuySell, "<TIME>" & $time & @CRLF)
			$compra	= _HasBuyCotation($coordsbuy, $ordemcompra, $COR_COMPRA)
			While $compra
				$compraOrdens = _ColetarDigitos($arrayCoordsBuy, $ordemcompra, "preço")
;~ 				_ArrayDisplay($compraOrdens, "$compraOrdens")
				$qtdcompraD	= _ColetarDigitos($coordsqtdbuydezena, $ordemcompra, "qtd")
;~ 				_ArrayDisplay($qtdcompraD, "$qtdcompraD")
				$qtdcompraU	= _ColetarDigitos($coordsqtdbuyunidade, $ordemcompra, "qtd")
;~ 				_ArrayDisplay($qtdcompraU, "$qtdcompraU")
				$buy				= ($compraOrdens[0] * 1000) + ($compraOrdens[1] * 100) + ($compraOrdens[2] * 10) + $compraOrdens[3]
				$somatorioQtdCompra	= ($qtdcompraD[0]*10) + $qtdcompraU[0]
				$Buyparamediana		= $somatorioQtdCompra * $buy
				If $buy <> 0 Then
					$saved1 = FileWrite($dadosBuySell, "<$buy>" & $buy & "|" _
												& "<$somatorioQtdCompra>" & $somatorioQtdCompra & "|" _
												& "<$Buyparamediana>" & $Buyparamediana & @CRLF)
				EndIf
				$somatorioQtdCompraTotal	+= $somatorioQtdCompra
				$BuyparamedianaGeral 		+= $Buyparamediana
				$compra	= _HasBuyCotation($coordsbuy, $ordemcompra, $COR_COMPRA)
				If Not $compra Then
					GUICtrlSetData($Labelbid, "----")
;~ 					MsgBox(0, "QUITLOOP", "OUT LOOP - BUY", 2)
					ExitLoop
				Else
					GUICtrlSetData($Labelbid, $buy)
					$ordemcompra += 1
				EndIf
			WEnd
			$saved1 = FileWrite($dadosBuySell, "<--------------->" & @CRLF)

			; BUSCANDO VENDAS
			$venda	= _HasSellCotation($coordssell, $ordemvenda, $COR_VENDA)
			While $venda
				$vendaOrdens = _ColetarDigitos($arrayCoordsSell, $ordemvenda, "preço")
;~ 				_ArrayDisplay($vendaOrdens, "$vendaOrdens")
				$qtdvendaD	= _ColetarDigitos($coordsqtdselldezena, $ordemvenda, "qtd")
;~ 				_ArrayDisplay($qtdvendaD, "$qtdvendaD")
				$qtdvendaU	= _ColetarDigitos($coordsqtdsellunidade, $ordemvenda, "qtd")
;~ 				_ArrayDisplay($qtdvendaU, "$qtdvendaU")
				$sell	= ($vendaOrdens[0] * 1000) + ($vendaOrdens[1] * 100) + ($vendaOrdens[2] * 10) + $vendaOrdens[3]
				$somatorioQtdVenda			= ($qtdvendaD[0]*10) + $qtdvendaU[0]
				$Sellparamediana			= $somatorioQtdVenda * $sell
				If $sell <> 0 Then
					$saved1 = FileWrite($dadosBuySell, "<$sell>" & $sell & "|" _
												& "<$somatorioQtdVenda>" & $somatorioQtdVenda & "|" _
												& "<$Sellparamediana>" & $Sellparamediana & @CRLF)
				EndIf
				$somatorioQtdVendaTotal		+= $somatorioQtdVenda
				$SellparamedianaGeral 		+= $Sellparamediana
				$venda	= _HasSellCotation($coordssell, $ordemvenda, $COR_VENDA)
				If Not $venda Then
					GUICtrlSetData($Labelask, "----")
;~ 					MsgBox(0, "QUITLOOP", "OUT LOOP - SELL", 2)
					ExitLoop
				Else
					GUICtrlSetData($Labelask, $sell)
					$ordemvenda += 1
				EndIf
			WEnd
			#EndRegion

			; ANALISANDO A MEDIANA MINIMA, MAXIMA, MEDIO E MEDIANA GERAL
			If $compra = 0 And $venda = 0 Then
				$totalQtd = $somatorioQtdCompraTotal + $somatorioQtdVendaTotal
				; MEDIANA COMPRA
				$mediana_compra	= Round($BuyparamedianaGeral/$somatorioQtdCompraTotal)
				; MEDIANA VENDA
				$mediana_venda	= Round($SellparamedianaGeral/$somatorioQtdVendaTotal)
				; DISTANCIA MEDIO
				$medioGeral		= ($mediana_venda - $mediana_compra)/2
				; MEDIANA GERAL
				$medianaGeral	= Round(($SellparamedianaGeral + $BuyparamedianaGeral)/$totalQtd, 2)

				; SALVANDO DADOS
				$saved2 = FileWrite($dadosEstudoGeral, "<TIME>" & $time & @CRLF)
				$saved2 = FileWrite($dadosEstudoGeral, "<$mediana_compra>" & $mediana_compra & @CRLF)
				$saved2 = FileWrite($dadosEstudoGeral, "<$mediana_venda>" & $mediana_venda & @CRLF)
				$saved2 = FileWrite($dadosEstudoGeral, "<$medioGeral>" & $medioGeral & @CRLF)
				$saved2 = FileWrite($dadosEstudoGeral, "<$medianaGeral>" & $medianaGeral & @CRLF)
				$saved2 = FileWrite($dadosEstudoGeral, "<--------------->" & @CRLF)

				If $time = "09:00:00" Then
					$open = $medianaGeral
				EndIf
				If $medianaGeral >= $max Then
					$max = $medianaGeral
				EndIf
				If $medianaGeral <= $min Then
					$min = $medianaGeral
				EndIf

				If $markInicial == $markFinal Then
					$close = $medianaGeral
					$saved3 = FileWrite($dadosCandle, "<TIME>" & $time & @CRLF)
					$saved3 = FileWrite($dadosCandle, "<$max>" & $max & @CRLF)
					$saved3 = FileWrite($dadosCandle, "<$open>" & $open & @CRLF)
					$saved3 = FileWrite($dadosCandle, "<$close>" & $close & @CRLF)
					$saved3 = FileWrite($dadosCandle, "<$min>" & $min & @CRLF)
					$saved3 = FileWrite($dadosCandle, "<--------------->" & @CRLF)
					$open = $close
					$markInicial = $markFinal
					$markFinal = 0
				EndIf

				Local $timeEnd = Round(_Timer_Diff($timeInit)/1000, 1)
				Local $totalTime = $timeEnd*$totalImagens
				Local $resto = Mod($totalTime, 60)
				$totalTime -= $resto

				GUICtrlSetData($Labelmediana, $timeEnd)
				GUICtrlSetData($Labelmedio, String($totalTime/60 & ":00"))
				GUICtrlSetData($Labelclock, $time)
				GUICtrlSetBkColor($Groupvalores, 0xCDCDCD)

;~ 				MsgBox(0, "RESULTADO", "ARQUIVOS SALVOS _
;~ 				=>>> $saved1 - " & $saved1 & " _ ; gravação de candle de 5 minutos
;~ 				=>>> $saved2 - " & $saved2 & " _ ; gravação mediana geral
;~ 				=>>> $saved3 - " & $saved3, 2) ; gravação mediana compra, mediana venda e medio geral

				; PROXIMA FOTO
				If $play Then
					; ZERANDO VALORES
					$saved1 				= 0
					$saved2 				= 0
					$saved3 				= 0
					$max 					= 0
					$min					= 10000
					$medianaGeralMax 		= 0
					$medianaGeralMin 		= 10000
					$BuyparamedianaGeral	= 0
					$SellparamedianaGeral	= 0
					$mediana_compra			= 0
					$mediana_venda			= 0
					$totalQtd				= 0
					$ordemcompra			= 0
					$ordemvenda 			= 0
					$qtdvendaD				= 0
					$qtdvendaU				= 0
					$buy					= 0
					$sell					= 0
					$somatorioQtdCompra		= 0
					$somatorioQtdVenda		= 0
					$somatorioQtdCompraTotal = 0
					$somatorioQtdVendaTotal = 0
					$totalImagens -= 1
				EndIf
			EndIf

			If $time == "18:01:00" Then
				$play = False
			EndIf

			MouseClick($MOUSE_CLICK_LEFT, 344, 1725, 1, 10)
			GUICtrlSetBkColor($Groupvalores, 0x00FF00)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: NEXT IMAGE...", 1, 1)
			Sleep(5)
;~ 			MsgBox(0, "", "Next Image", .3)
		Else
			; zerando valores
			$open 					= 0
			$close					= 0
			$max 					= 0
			$min					= 0
			$medianaGeralMin 		= 10000
			$medianaGeralMax 		= 0
			$BuyparamedianaGeral	= 0
			$SellparamedianaGeral	= 0
			$ordemcompra			= 0
			$ordemvenda 			= 0
			$qtdvendaD				= 0
			$qtdvendaU				= 0
			$buy					= 0
			$sell					= 0
			$somatorioQtdCompra		= 0
			$somatorioQtdVenda		= 0
			$somatorioQtdCompraTotal = 0
			$somatorioQtdVendaTotal = 0

;~ 			ConsoleWrite("< DISCONNECTED >" & $time & @CRLF)
			GUICtrlSetBkColor($Buttoniniciar, $COLOR_YELLOW)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)

			$saved = FileWrite($dados, "<" & $time & "|DISCONNECTED>" & @CRLF)
		EndIf

	WEnd

	FileClose($dados)
;~ 	GUISetState(@SW_SHOW, $Form2)
	GUICtrlSetData($Buttoniniciar, "INICIAR")
	GUICtrlSetState($Buttoniniciar, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
	MsgBox(0, "STATUS", "ANÁLISE DOS DADOS INTERROMPIDA - " & $time, 1.5)
	ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
	ToolTip("")

EndFunc   ;==>_IniciarCotacao
;---------------------------------------------------------------------------------


; _HasBuyCotation()
Func _HasBuyCotation($coordsbuy, $ordem, $color)

	Local $x0 = $coordsbuy[0]
	Local $y0 = $coordsbuy[1] + ($ordem * $dif2display)
	Local $x1 = $coordsbuy[0]
	Local $y1 = $coordsbuy[1] + ($ordem * $dif2display)

	Local $hasBuy = PixelSearch($x0, $y0, $x1, $y1, $color)

	If IsArray($hasBuy) Then
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>_HasBuyCotation()
;---------------------------------------------------------------------------------


; _HasSellCotation()
Func _HasSellCotation($coordssell, $ordem, $color)

	Local $x0 = $coordssell[0]
	Local $y0 = $coordssell[1] + ($ordem * $dif2display)
	Local $x1 = $coordssell[0]
	Local $y1 = $coordssell[1] + ($ordem * $dif2display)

	Local $hasSell = PixelSearch($x0, $y0, $x1, $y1, $color)

	If IsArray($hasSell) Then
;~ 		MouseMove($hasSell[0], $hasSell[1], 2)
		Return True
	Else
		Return False
	EndIf

EndFunc   ;==>_HasSellCotation()
;---------------------------------------------------------------------------------


; _FindNumber()
Func _FindNumber($plates)

	Local $contador, $number, $a, $b, $c, $d, $e, $f, $g

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
	If $contador = 2 Then
		$number = 1
	EndIf
	If $contador = 7 Then
		$number = 8
	EndIf
	If $contador = 4 And $plates[6] Then
		$number  = 4
	EndIf
	If $contador = 4 And Not $plates[6] Then
		$number = 7
	EndIf
	If $contador = 5 And Not $plates[2] Then
		$number = 2
	EndIf
	If $contador = 5 And Not $plates[4] And Not $plates[5] Then
		$number = 3
	EndIf
	If $contador = 5 And Not $plates[1] Then
		$number = 5
	EndIf
	If $contador = 6 And Not $plates[1] Then
		$number = 6
	EndIf
	If $contador = 6 And Not $plates[4] Then
		$number = 9
	EndIf
	If $contador = 6 And Not $plates[6] Then
		$number = 0
	EndIf
	Return $number
	#EndRegion

EndFunc   ;==>_FindNumber
;---------------------------------------------------------------------------------


; _GetCotationCasa()
Func _GetCotationCasa($coordscasa, $ordem, $color)

	Local $hasplaca, $x0, $y0
;~ 	_ArrayDisplay($coordscasa, "$coordscasa")
	For $i = 0 To UBound($coordscasa) - 2 Step 2
		$x0 = $coordscasa[$i]
		$y0 = $coordscasa[$i + 1]
		$hasplaca = PixelSearch($x0, $y0, $x0, $y0, $color)
		If IsArray($hasplaca) Then
			_ArrayPush($placas, 1)
		Else
			_ArrayPush($placas, 0)
		EndIf
	Next
	Return $placas

EndFunc   ;==>_GetCotationCasa()
;---------------------------------------------------------------------------------


; _GetCotationCasaMove()
Func _GetCotationCasaMove($coordscasa, $ordem, $color)

	Local $hasplaca, $x0, $y0
;~ 	_ArrayDisplay($coordscasa, "$coordscasa")
	If $ordem == 0 Then
		For $i = 0 To UBound($coordscasa) - 2 Step 2
			$x0 = $coordscasa[$i]
			$y0 = $coordscasa[$i + 1]
			$hasplaca = PixelSearch($x0, $y0, $x0, $y0, $color)
			If IsArray($hasplaca) Then
				MouseMove($hasplaca[0], $hasplaca[1], 10)
				_ArrayPush($placas, 1)
			Else
				_ArrayPush($placas, 0)
			EndIf
		Next
		Return $placas
	ElseIf $ordem == 1 Then
		For $i = 0 To UBound($coordscasa) - 2 Step 2
			$x0 = $coordscasa[$i]
			$y0 = $coordscasa[$i + 1]
			MouseMove($x0, $y0, 5)
		Next
	EndIf

EndFunc   ;==>_GetCotationCasaMove()
;---------------------------------------------------------------------------------


#--------=================----------#
#----------STOP PROGRAM-------------#
HotKeySet("{F2}", "_PararMarket")