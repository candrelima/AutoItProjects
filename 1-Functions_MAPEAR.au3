
#include <ButtonConstants.au3> ; INCLUDES
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Array.au3>
#include <ColorConstants.au3>
#include <ProgressConstants.au3>
#include <ScreenCapture.au3>
#include <Timers.au3>
#include <Date.au3>
#include <File.au3>
#include <GDIPlus.au3>
#include <5-Cores.au3>
;-------------------------------------------------------------------------
#Region ; ELEMENTOS
Global $Buttoniniciarcaptura, $Buttonhora, $Buttonpainel, $Buttonconexao, $Buttonlocalizar, $Buttonteste, $Buttoncapturar
Global $Buttonhorad, $Buttonhorau, $Buttonminutod, $Buttonminutou, $Buttonsegundod, $Buttonsegundou ;
Global $Labelplaca1hd, $Labelplaca2hd, $Labelplaca3hd, $Labelplaca4hd, $Labelplaca5hd, $Labelplaca6hd, $Labelplaca7hd ; LABEL HORA DEZENA
Global $Labelplaca1hu, $Labelplaca2hu, $Labelplaca3hu, $Labelplaca4hu, $Labelplaca5hu, $Labelplaca6hu, $Labelplaca7hu ; LABEL HORA UNIDADE
Global $Labelplaca1md, $Labelplaca2md, $Labelplaca3md, $Labelplaca4md, $Labelplaca5md, $Labelplaca6md, $Labelplaca7md ; LABEL MINUTO DEZENA
Global $Labelplaca1mu, $Labelplaca2mu, $Labelplaca3mu, $Labelplaca4mu, $Labelplaca5mu, $Labelplaca6mu, $Labelplaca7mu ; LABEL HORA UNIDADE
Global $Labelplaca1sd, $Labelplaca2sd, $Labelplaca3sd, $Labelplaca4sd, $Labelplaca5sd, $Labelplaca6sd, $Labelplaca7sd ; LABEL SEGUNDO DEZENA
Global $Labelplaca1su, $Labelplaca2su, $Labelplaca3su, $Labelplaca4su, $Labelplaca5su, $Labelplaca6su, $Labelplaca7su ; LABEL SEGUNDO UNIDADE
Global $Inputhorax1, $Inputhoray1, $Inputhorax2, $Inputhoray2 ; LABEL HORA
Global $Inputpainelx1, $Inputpainely1, $Inputpainelx2, $Inputpainely2 ; LABEL PAINEL
Global $Inputconexaox1, $Inputconexaoy1, $Inputconexaox2, $Inputconexaoy2 ; LABEL CONEXAO
Global $Listhorariosalvo, $Pic1, $Labelrelogio, $Progressprogresso
Global $Inputbrilho, $Inputcontraste, $Inputraio, $Inputgrandeza
#EndRegion
;-------------------------------------------------------------------------
#Region ; VARIÁVEIS
Local $hDLL = DllOpen("user32.dll")
Global $coordshorad[14], $coordshorau[14], $coordsminutod[14], $coordsminutou[14], $coordssegundod[14], $coordssegundou[14] ; COORDS HORA, MINUTO E SEGUNDO
Global $coordshora[4], $coordspainel[4], $coordsconexao[4] ; QUADRANTE
Global $bar, $Progressler
Global $tipo, $messageErro = "DADOS NÃO LOCALIZADOS" & @CRLF
Global $play, $status, $placas[7], $conectado, $placa[2], $cor, $botao, $posicao[2], $num, $out, $resp, $arqopened, $allcoords[14], $section15,  $section5, $ordem
Global $hImage, $hEffectContrast, $hEffectSharpen, $saved
Global $brilho, $contraste, $raio, $grandeza
Global $leep = 25, $beep = 1440
Global $pathfile = @ScriptDir &"\Fotos", $sTempFile_1, $file
#EndRegion

;-------------------------------------------------------------------------
_ScreenCapture_SetBMPFormat(32) ; QUALIDADE BITMAP MÁXIMA
;-------------------------------------------------------------------------


; _AplicarEfeitoSalvar()
Func _AplicarEfeitoSalvar($sTempFile_1, $path)

	#Region
	_GDIPlus_Startup() ; INICIALIZAR GDI+
	$hImage = _GDIPlus_BitmapCreateFromHBITMAP($sTempFile_1)
	_GDIPlus_BitmapSetResolution($hImage, 300, 300)
	$hEffectSharpen = _GDIPlus_EffectCreateSharpen($raio, $grandeza)
	_GDIPlus_BitmapApplyEffect($hImage, $hEffectSharpen)
	$hEffectContrast = _GDIPlus_EffectCreateBrightnessContrast($brilho, $contraste)
	_GDIPlus_BitmapApplyEffect($hImage, $hEffectContrast)
	$saved = _GDIPlus_ImageSaveToFile($hImage, $path)
;~ 	ConsoleWrite(_GDIPlus_ImageSaveToFile($hImage, $path))
	; LIMPANDO RESOURCES
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_EffectDispose($hEffectContrast)
	_GDIPlus_EffectDispose($hEffectSharpen)
	_GDIPlus_Shutdown() ; DESLIGANDO LIVRARIA GDI+

	Return $saved
	#EndRegion

EndFunc		;==>_AplicarEfeitoSalvar()
;-------------------------------------------------------------------------


; _Timer1()
Func _Timer()

    GUICtrlSetData($Labelrelogio, _NowTime(5))

EndFunc   ;==>Timer1()
;-------------------------------------------------------------------------


; _PararMarket()
Func _PararMarket()

	$play = False
	While _IsPressed("71", $hDLL)
		Sleep(10)
	WEnd

EndFunc   ;==>_PararMarket()
;-------------------------------------------------------------------------


; _LookPlaca()
Func _LookPlaca($beep)

	Local $placa[2]
	Local $pos = MouseGetPos()
	$cor = "0x" & Hex(PixelGetColor($pos[0], $pos[1]), 6)
	If $cor == "0xFFFFFF" Or $cor == "0xE6E6E6" Then ; $COR_PLACA ou $COR_RELOGIO
		ToolTip($pos[0] & " x " & $pos[1], $pos[0], $pos[1], "PLACA", $TIP_INFOICON)
		Beep($beep, 5)
	Else
		ToolTip("", $pos[0], $pos[1], "PLACA", $TIP_INFOICON)
	EndIf
	_ArrayPush($placa, $pos[0])
	_ArrayPush($placa, $pos[1])
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
	If $botao = "HORA" Then
		GUICtrlSetData($Inputhorax1, $posicao[0])
		GUICtrlSetData($Inputhoray1, $posicao[1])
		GUICtrlSetData($Inputhorax2, $posicao[2])
		GUICtrlSetData($Inputhoray2, $posicao[3])
	EndIf
	If $botao = "PAINEL" Then
		GUICtrlSetData($Inputpainelx1, $posicao[0])
		GUICtrlSetData($Inputpainely1, $posicao[1])
		GUICtrlSetData($Inputpainelx2, $posicao[2])
		GUICtrlSetData($Inputpainely2, $posicao[3])
	EndIf
	If $botao = "CONEXAO" Then
		GUICtrlSetData($Inputconexaox1, $posicao[0])
		GUICtrlSetData($Inputconexaoy1, $posicao[1])
		GUICtrlSetData($Inputconexaox2, $posicao[2])
		GUICtrlSetData($Inputconexaoy2, $posicao[3])
	EndIf
	If $botao = "HORA D" Then
		GUICtrlSetData($arrayLabels[0][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao = "HORA U" Then
		GUICtrlSetData($arrayLabels[1][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao = "MINU D" Then
		GUICtrlSetData($arrayLabels[2][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao = "MINU U" Then
		GUICtrlSetData($arrayLabels[3][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao = "SEGS D" Then
		GUICtrlSetData($arrayLabels[4][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf
	If $botao = "SEGS U" Then
		GUICtrlSetData($arrayLabels[5][$num-1], $posicao[0]&" x "&$posicao[1])
	EndIf

EndFunc ;==>_LoadInput()
;-------------------------------------------------------------------------


; _capturarcoordsTipo()
Func _capturarcoordsTipo($tipo)

	$out = False

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
				$coordshora[0] = MouseGetPos(0)
				$coordshora[1] = MouseGetPos(1)
				GUICtrlSetData($Inputhorax1,$coordshora[0])
				GUICtrlSetData($Inputhoray1, $coordshora[1])
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				$coordshora[2] = MouseGetPos(0)
				$coordshora[3] = MouseGetPos(1)
				GUICtrlSetData($Inputhorax2, $coordshora[2])
				GUICtrlSetData($Inputhoray2, $coordshora[3])
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "PAINEL" Then ; PAINEL
			If _IsPressed("31", $hDLL) Then
				$coordspainel[0] = MouseGetPos(0)
				$coordspainel[1] = MouseGetPos(1)
				GUICtrlSetData($Inputpainelx1, $coordspainel[0])
				GUICtrlSetData($Inputpainely1, $coordspainel[1])
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				$coordspainel[2] = MouseGetPos(0)
				$coordspainel[3] = MouseGetPos(1)
				GUICtrlSetData($Inputpainelx2, $coordspainel[2])
				GUICtrlSetData($Inputpainely2, $coordspainel[3])
				Sleep($leep)
			EndIf
		EndIf
		If $tipo = "CONEXAO" Then ; CONEXAO
			If _IsPressed("31", $hDLL) Then
				$coordsconexao[0] = MouseGetPos(0)
				$coordsconexao[1] = MouseGetPos(1)
				GUICtrlSetData($Inputconexaox1, $coordsconexao[0])
				GUICtrlSetData($Inputconexaoy1, $coordsconexao[1])
				Sleep($leep)
			EndIf
			If _IsPressed("32", $hDLL) Then
				$coordsconexao[2] = MouseGetPos(0)
				$coordsconexao[3] = MouseGetPos(1)
				GUICtrlSetData($Inputconexaox2, $coordsconexao[2])
				GUICtrlSetData($Inputconexaoy2, $coordsconexao[3])
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


; _capturarcoordsPlacas()
Func _capturarcoordsPlacas($botao)

	$out = False

	While Not $out

		Sleep(25)
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


; _SalvarParametrosCaptFotos()
Func _SalvarParametrosCaptFotos()

	$bar = GUICreate("SALVANDO DADOS - CAPTURA DE FOTOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	$Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, 32250)

;~ 	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")
	$arqsaved = FileSaveDialog("SALVAR PARÂMETROS CAPTURA", @ScriptDir & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST, $FD_PROMPTOVERWRITE), "param")

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

		If UBound($coordshorad) <> 14 Or UBound($coordshorau) <> 14 Or _ ; HORA
			UBound($coordsminutod) <> 14 Or UBound($coordsminutou) <> 14 Or _ ; MINUTO
			UBound($coordssegundod) <> 14 Or UBound($coordssegundou) <> 14 Or _ ; SEGUNDO
			UBound($coordshora) <> 4 And UBound($coordspainel) <> 4 And UBound($coordsconexao) <> 4 Then  ; HORA, PAINEL E CONEXÃO

			MsgBox(48, "ALERTA", "DADOS INCOMPLETOS" & @CRLF & _
					"ATENÇÃO: Dados incompletos ocasionará o mal " & @CR & _
					"funcionamento do programa. É necessário realizar" & @CR & _
					"o correto mapeamento de todas as coordenadas" & @CR & _
					"para garantir a integridade do programa." & @CR & _
					">>>>FALHA" & $arqsaved)

			GUIDelete($bar)
		Else
			GUISetState(@SW_SHOW)

			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "horad", String($i + 1), $coordshorad[$i])
			Next
				GUICtrlSetData($Progressler, 15)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "horau", String($i + 1), $coordshorau[$i])
			Next
				GUICtrlSetData($Progressler, 30)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "minutod", String($i + 1), $coordsminutod[$i])
			Next
				GUICtrlSetData($Progressler, 45)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "minutou", String($i + 1), $coordsminutou[$i])
			Next
				GUICtrlSetData($Progressler, 60)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "segundod", String($i + 1), $coordssegundod[$i])
			Next
				GUICtrlSetData($Progressler, 75)
			For $i = 0 To 13 Step 1
				IniWrite($arqsaved, "segundou", String($i + 1), $coordssegundou[$i])
			Next
				GUICtrlSetData($Progressler, 90)
			For $i = 0 To 3 Step 1
				IniWrite($arqsaved, "hora", String($i + 1), $coordshora[$i])
				IniWrite($arqsaved, "painel", String($i + 1), $coordspainel[$i])
				IniWrite($arqsaved, "conexao", String($i + 1), $coordsconexao[$i])
			Next
				GUICtrlSetData($Progressler, 100)
			MsgBox($MB_SYSTEMMODAL, "DADOS", "DADOS LIDOS COM SUCESSO." & @CRLF & $arqsaved, 1)

			GUIDelete($bar)
			Return 1
		EndIf
	EndIf

EndFunc   ;==>_SalvarParametrosCaptFotos
;-------------------------------------------------------------------------


; _AbrirParametrosMapeamento()
Func _AbrirParametrosMapeamento()

	$bar = GUICreate("LOCALIZANDO DADOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	$Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, "FFF")
;~ 	$arqopened = FileOpenDialog("ABRIR PARÂMETROS", "::{450D8FBA-AD25-11D0-98A8-0800361B1103}" & "\", "params (*.ini)", BitOR($FD_PATHMUSTEXIST), "param")
	$arqopened = FileOpenDialog("ABRIR PARÂMETROS", @ScriptDir & "\", "(*.ini)", $FD_PATHMUSTEXIST, "param")

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "ERRO", "FALHA AO ABRIR ARQUIVO.")
		Return 0
	Else
		GUISetState(@SW_SHOW)
		; --------------------------------------------------------------------------- HORAD -----
		$section15 = IniReadSection($arqopened, "horad")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordshorad, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
;~ 				_ArrayDisplay($posicao, "horad")
				If Mod($i, 2) == 0 Then
					_LoadInput("HORA D", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
;~ 					_ArrayDisplay($posicao, "horad")
				EndIf
			Next
;~ 			_ArrayDisplay($coordshorad, "$coordshorad")
			GUICtrlSetBkColor($Buttonhorad, $COLOR_LIME)
			GUICtrlSetData($Progressler, 20)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonhorad, $COLOR_RED)
			$messageErro += "COORDENADAS DA HORA(DEZENA) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- HORAU -----
		$section15 = IniReadSection($arqopened, "horau")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordshorau, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadInput("HORA U", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
;~ 			_ArrayDisplay($coordshorau, "$coordshorau")
			GUICtrlSetBkColor($Buttonhorau, $COLOR_LIME)
			GUICtrlSetData($Progressler, 30)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonhorau, $COLOR_RED)
			$messageErro += "COORDENADAS DA HORA(UNIDADE) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MINUTOD -----
		$section15 = IniReadSection($arqopened, "minutod")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsminutod, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadInput("MINU D", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
;~ 			_ArrayDisplay($coordsminutod, "$coordsminutod")
			GUICtrlSetBkColor($Buttonminutod, $COLOR_LIME)
			GUICtrlSetData($Progressler, 40)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonminutod, $COLOR_RED)
			$messageErro += "COORDENADAS DA MINUTO(DEZENA) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- MINUTOU -----
		$section15 = IniReadSection($arqopened, "minutou")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordsminutou, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadInput("MINU U", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
;~ 			_ArrayDisplay($coordsminutou, "$coordsminutou")
			GUICtrlSetBkColor($Buttonminutou, $COLOR_LIME)
			GUICtrlSetData($Progressler, 50)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonminutou, $COLOR_RED)
			$messageErro += "COORDENADAS DA MINUTO(UNIDADE) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- SEGUNDOD -----
		$section15 = IniReadSection($arqopened, "segundod")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordssegundod, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadInput("SEGS D", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
;~ 			_ArrayDisplay($coordssegundod, "$coordssegundod")
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_LIME)
			GUICtrlSetData($Progressler, 60)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_RED)
			$messageErro += "COORDENADAS DA SEGUNDO(DEZENA) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- SEGUNDOU -----
		$section15 = IniReadSection($arqopened, "segundou")
		If IsNumber(Int($section15[1][1])) And IsNumber(Int($section15[3][1])) _
		And IsNumber(Int($section15[5][1])) And IsNumber(Int($section15[7][1])) _
		And IsNumber(Int($section15[9][1])) And IsNumber(Int($section15[11][1])) _
		And IsNumber(Int($section15[13][1])) Then
			$ordem = 1
			_ArrayPop($posicao)
			_ArrayPop($posicao)
			For $i = 1 To 14 Step 1
				_ArrayPush($coordssegundou, $section15[$i][1])
				_ArrayAdd($posicao, $section15[$i][1])
				If Mod($i, 2) == 0 Then
					_LoadInput("SEGS U", $posicao, $ordem)
					$ordem += 1
					_ArrayPop($posicao)
					_ArrayPop($posicao)
				EndIf
			Next
;~ 			_ArrayDisplay($coordssegundou, "$coordssegundou")
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_LIME)
			GUICtrlSetData($Progressler, 70)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_RED)
			$messageErro += "COORDENADAS DA SEGUNDO(UNIDADE) - FALHA." & @CRLF
		EndIf
		; --------------------------------------------------------------------------- HORA -----
		$section5 = IniReadSection($arqopened, "hora")
;~ 		_ArrayDisplay($section5, "hora")
		If IsNumber(Int($section5[1][1])) And IsNumber(Int($section5[2][1])) And _
			IsNumber(Int($section5[3][1])) And IsNumber(Int($section5[4][1])) Then
			_ArrayPush($coordshora, Int($section5[1][1]))
			_ArrayPush($coordshora, Int($section5[2][1]))
			_ArrayPush($coordshora, Int($section5[3][1]))
			_ArrayPush($coordshora, Int($section5[4][1]))
			_LoadInput("HORA", $coordshora, 0)
			GUICtrlSetBkColor($Buttonhora, $COLOR_LIME)
			GUICtrlSetData($Progressler, 80)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonhora, $COLOR_RED)
			$messageErro += "COORDENADAS HORA - FALHA." & @CR
		EndIf
		; --------------------------------------------------------------------------- PAINEL -----
		$section5 = IniReadSection($arqopened, "painel")
;~ 		_ArrayDisplay($section5, "painel")
		If IsNumber(Int($section5[1][1])) And IsNumber(Int($section5[2][1])) And _
			IsNumber(Int($section5[3][1])) And IsNumber(Int($section5[4][1])) Then
			_ArrayPush($coordspainel, Int($section5[1][1]))
			_ArrayPush($coordspainel, Int($section5[2][1]))
			_ArrayPush($coordspainel, Int($section5[3][1]))
			_ArrayPush($coordspainel, Int($section5[4][1]))
			_LoadInput("PAINEL", $coordspainel, 0)
			GUICtrlSetBkColor($Buttonpainel, $COLOR_LIME)
			GUICtrlSetData($Progressler, 90)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonpainel, $COLOR_RED)
			$messageErro += "COORDENADAS PAINEL - FALHA." & @CR
		EndIf
		; --------------------------------------------------------------------------- CONEXAO -----
		$section5 = IniReadSection($arqopened, "conexao")
;~ 		_ArrayDisplay($section5, "conexao")
		If IsNumber(Int($section5[1][1])) And IsNumber(Int($section5[2][1])) And _
			IsNumber(Int($section5[3][1])) And IsNumber(Int($section5[4][1])) Then
			_ArrayPush($coordsconexao, Int($section5[1][1]))
			_ArrayPush($coordsconexao, Int($section5[2][1]))
			_ArrayPush($coordsconexao, Int($section5[3][1]))
			_ArrayPush($coordsconexao, Int($section5[4][1]))
			_LoadInput("CONEXAO", $coordsconexao, 0)
			GUICtrlSetBkColor($Buttonconexao, $COLOR_LIME)
			GUICtrlSetData($Progressler, 100)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonconexao, $COLOR_RED)
			$messageErro += "COORDENADAS CONEXAO - FALHA." & @CR
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

EndFunc   ;==>_AbrirParametrosMapeamento()
;-------------------------------------------------------------------------


; _TestePosicaoCoords()
Func _TestePosicaoCoords($playCot)

	Local $arrayHora = [$coordshorad, $coordshorau, $coordsminutod, $coordsminutou, $coordssegundod, $coordssegundou]
	Local $hora, $painel, $conexao
	Local $horad[7], $horau[7], $minutod[7], $minutou[7], $segundod[7], $segundou[7]
	Local $relogio = 0xE6E6E6 ; DESVIO DO BRANCO DO RELÓGIO
	$play = $playCot
	Local $timer

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttonteste, "TESTANDO")
	GUICtrlSetState($Buttonteste, $GUI_DISABLE)

	While $play

		$conectado = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[2], $coordsconexao[3], $COR_CONECTADO, 15)

		If IsArray($conectado) Then

			GUICtrlSetBkColor($Buttonteste, $COLOR_MONEYGREEN)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: TESTANDO POSIÇÕES...", 1, 1)

			#Region
			$horad 		= _GetCotationCasaMove($coordshorad, 0, $relogio)
			$horad 		= _FindNumber($horad)
			$horau		= _GetCotationCasaMove($coordshorau, 0, $relogio)
			$horau		= _FindNumber($horau)
;~ 			_ArrayDisplay($coordsminutod, "$coordsminutod")
			$minutod 	= _GetCotationCasaMove($coordsminutod, 0, $relogio)
			$minutod 	= _FindNumber($minutod)
			$minutou 	= _GetCotationCasaMove($coordsminutou, 0, $relogio)
			$minutou 	= _FindNumber($minutou)
			$segundod 	= _GetCotationCasaMove($coordssegundod, 0, $relogio)
			$segundod 	= _FindNumber($segundod)
			$segundou 	= _GetCotationCasaMove($coordssegundou, 0, $relogio)
			$segundou 	= _FindNumber($segundou)
			$timer 		= $horad&$horau& ":" &$minutod&$minutou& ":" &$segundod&$segundou
			GUICtrlSetData($Labelrelogio, $timer)
			$hora 		= _GetCotationCasaMove($coordshora, 1, "") ; 0 PARA BUSCAR COR / 1 PARA APENAS MOVER (NÃO RETORNA NENHUM VALOR)
			$painel		= _GetCotationCasaMove($coordspainel, 1, "") ; 0 PARA BUSCAR COR / 1 PARA APENAS MOVER (NÃO RETORNA NENHUM VALOR)
			$conexao	= _GetCotationCasaMove($coordsconexao, 1, "") ; 0 PARA BUSCAR COR / 1 PARA APENAS MOVER (NÃO RETORNA NENHUM VALOR)
			#EndRegion
			GUICtrlSetData($Buttonteste, "TESTE")
			GUICtrlSetBkColor($Buttonteste, $COLOR_MONEYGREEN)
			GUICtrlSetState($Buttonteste, $GUI_ENABLE)
			MsgBox(0, "STATUS", "TESTE: SUCESSO - " & $timer, 2)
			ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
			ToolTip("")
		Else
			GUICtrlSetBkColor($Buttonteste, $COLOR_YELLOW)
			MsgBox(0, "STATUS", "TESTE: FALHA", 2)
			ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
			ToolTip("", 0, 0, "STATUS: STOPPED", 1, 1)
			Sleep(1000)
		EndIf

		GUICtrlSetData($Buttonteste, "TESTE")
		GUICtrlSetState($Buttonteste, $GUI_ENABLE)
		GUICtrlSetBkColor($Buttonteste, 0xC0C0C0)

		$play = False
	WEnd

EndFunc   ;==>_TestePosicaoCoords()
;---------------------------------------------------------------------------------


; _LocalizarHorarios1min()
Func _LocalizarHorarios1min()

	Local $diretorio = "D:\AutoIt\WinProMoney1.0\Fotos\"
	Local $files, $pasta, $filelist, $maxItens, $progresso, $loop

	$files			= FileSelectFolder("POR FAVOR, ESCOLHA A PASTA COM ARQUIVO LOG: ", $diretorio, 1)
	If $files <> "" Then
		GUICtrlSetData($Progressprogresso, 0)
;~ 		$diretorio2 	= StringTrimRight($files, 13) & "\" ; D:\AutoIt\WinProMoney1.0\Fotos\
;~ 		MsgBox(0, "", $diretorio2, 2)
		$pasta			= StringTrimLeft($files, 31) & "\" ; O NOME DA PASTA PRECEISA TER 12 CARACTERES
;~ 		MsgBox(0, "", $pasta, 2)
		$fileList		= _FileListToArrayRec($files, "*.bmp", 1, 0, 2, 0)
;~ 		_ArrayDisplay($fileList, "ARRAY")
		$maxItens		= $fileList[0]
		$progresso 		= $maxItens/100

		Local $horario = ""
		For $i = 1 To $maxItens Step 1
			$horario = StringTrimLeft($fileList[$i], 4) ; 00-00-00.jpg > StringTrimLeft = 00-0 > 0-00.jpg
			$horario = StringTrimRight($horario, 4) ; 00-00-00 > StringTrimRight = .jpg > 0-00
			If $horario = "1-00" Or $horario = "2-00" Or $horario = "3-00" Or $horario = "4-00" Or $horario = "5-00" Or _
				$horario = "6-00" Or $horario = "7-00" Or $horario = "8-00" Or $horario = "9-00" Or $horario = "0-00" Then
				GUICtrlSetData($Listhorariosalvo, $fileList[$i] & @CRLF)
				GUICtrlSetData($Progressprogresso, $loop/$progresso)
			EndIf
		Next
		GUICtrlSetData($Progressprogresso, 100)
		MsgBox($MB_SYSTEMMODAL, "RESULTADO", "HORÁRIOS ENCONTRADOS", 1.2)
		GUICtrlSetBkColor($Progressprogresso, 0x00EE5E) ; $COLOR_CONECTADO
		Return 1
	Else
		MsgBox(0, "RESULTADO", "NENHUMA PASTA SELECIONADA.", 2)
		GUICtrlSetData($Progressprogresso, 0)
		Return 0
	EndIf

EndFunc   ;==>_LocalizarHorarios1min()
;-------------------------------------------------------------------------


; _LocalizarHorario5min()
Func _LocalizarHorarios5min()

	Local $diretorio = "D:\AutoIt\WinProMoney1.0\Fotos\"
	Local $files, $pasta, $filelist, $maxItens, $progresso, $loop

	$files			= FileSelectFolder("POR FAVOR, ESCOLHA A PASTA COM ARQUIVO LOG: ", $diretorio, 1)
	If $files <> "" Then
		GUICtrlSetData($Progressprogresso, 0)
;~ 		$diretorio2 	= StringTrimRight($files, 13) & "\" ; D:\AutoIt\WinProMoney1.0\Fotos\
;~ 		MsgBox(0, "", $diretorio2, 2)
		$pasta			= StringTrimLeft($files, 31) & "\" ; O NOME DA PASTA PRECEISA TER 12 CARACTERES
;~ 		MsgBox(0, "", $pasta, 2)
		$fileList		= _FileListToArrayRec($files, "*.bmp", 1, 0, 2, 0)
;~ 		_ArrayDisplay($fileList, "ARRAY")
		$maxItens		= $fileList[0]
		$progresso 		= $maxItens/100

		Local $horario = ""
		For $i = 1 To $maxItens Step 1
			$horario = StringTrimLeft($fileList[$i], 4) ; 00-00-00.jpg > StringTrimLeft = 00-0 > 0-00.jpg
			$horario = StringTrimRight($horario, 4) ; 00-00-00 > StringTrimRight = .jpg > 0-00
			If $horario = "5-00" Or $horario = "0-00" Then
				GUICtrlSetData($Listhorariosalvo, $fileList[$i] & @CRLF)
				GUICtrlSetData($Progressprogresso, $loop/$progresso)
			EndIf
		Next
		GUICtrlSetData($Progressprogresso, 100)
		MsgBox($MB_SYSTEMMODAL, "RESULTADO", "HORÁRIOS ENCONTRADOS", 1.2)
		GUICtrlSetBkColor($Progressprogresso, 0x00EE5E) ; $COLOR_CONECTADO
		Return 1
	Else
		MsgBox(0, "RESULTADO", "NENHUMA PASTA SELECIONADA.", 2)
		GUICtrlSetData($Progressprogresso, 0)
		Return 0
	EndIf

EndFunc   ;==>_LocalizarHorario5min()
;-------------------------------------------------------------------------

; _IniciarCapturaPregao()
Func _IniciarCapturaPregao($playCot)

	Local $relogio = 0xE6E6E6 ; DESVIO DO BRANCO DO RELÓGIO
	Local $conexao
	$play = $playCot
	Local $savedimg, $time, $sTempFile_1

	GUICtrlSetData($Buttoniniciarcaptura, "PARAR(F2)")
	GUICtrlSetData($Listhorariosalvo, "")

	While $play

		$conexao = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[2], $coordsconexao[3], $COR_CONECTADO, 25)

		If IsArray($conexao) Then
			GUICtrlSetBkColor($Buttoniniciarcaptura, $COLOR_MONEYGREEN)
			GUICtrlSetBkColor($Labelrelogio, $COR_CONECTADO)
			$time = _NowTime(5)
			If StringTrimLeft($time, 7) = "0" Then
				$sTempFile_1 = _ScreenCapture_Capture("", $coordspainel[0], $coordspainel[1], $coordspainel[2], $coordspainel[3], False)
				$pathfile &= "\" & StringReplace($time, ":", "-") & ".bmp"
;~ 				ConsoleWrite($pathfile)
				$savedimg = _AplicarEfeitoSalvar($sTempFile_1, $pathfile)
				If $savedimg Then
					GUICtrlSetData($Listhorariosalvo, StringReplace($time, ":", "-") & ".bmp")
					GUICtrlSetData($Labelrelogio, _Nowtime(5))
					GUICtrlSetBkColor($Labelrelogio, 0x00FFFF) ; COLOR AQUA
					Sleep(1000)
				EndIf
				$pathfile = StringTrimRight($pathfile, 13)
				GUICtrlSetBkColor($Labelrelogio, $COR_CONECTADO)
			EndIf

			If $time = "18:29:50" Then
				_Captura($playCot)
				$play = False
			EndIf
		Else
			GUICtrlSetBkColor($Buttoniniciarcaptura, $COR_VERMELHO)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)
		EndIf
	WEnd
	GUICtrlSetData($Buttoniniciarcaptura, "INICIAR")
	GUICtrlSetBkColor($Labelrelogio, 0xFFFF00)
;~ 	GUICtrlSetState($Buttoniniciarcaptura, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoniniciarcaptura, $COLOR_MONEYGREEN)
	MsgBox(0, "STATUS", "ANÁLISE DOS DADOS INTERROMPIDA - " & _NowTime(5), 1.5)
	ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
	Sleep(500)
	ToolTip("")

EndFunc   ;==>_IniciarCapturaPregao()
;---------------------------------------------------------------------------------


; _IniciarCapturaReplay()
Func _IniciarCapturaReplay($playCot)

	Local $relogio = 0xE6E6E6 ; DESVIO DO BRANCO DO RELÓGIO
	Local $conexao
	$play = $playCot
	Local $sucessimg, $sTempFile_1
	Local $horad, $horau, $minutod, $minutou, $segundod, $segundou

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciarcaptura, "PARAR(F2)")
	GUICtrlSetData($Listhorariosalvo, "")

	While $play

		$conexao = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[2], $coordsconexao[3], $COR_CONECTADO, 25)

		If IsArray($conexao) Then
			$segundou 	= _FindNumber(_GetCotationCasa($coordssegundou, 0, $relogio))
			GUICtrlSetBkColor($Buttoniniciarcaptura, $COLOR_MONEYGREEN)
			GUICtrlSetBkColor($Labelrelogio, $COR_CONECTADO)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: CONNECTED", 1, 1)
			If $segundou = 0 Then
				ConsoleWrite($segundou&@CRLF)
				$sTempFile_1 = _ScreenCapture_Capture("", $coordspainel[0], $coordspainel[1], $coordspainel[2], $coordspainel[3], False)
				$segundod 	= _FindNumber(_GetCotationCasa($coordssegundod, 0, $relogio))
				If $segundod 	= 0 Then
;~ 					$segundou 	= _FindNumber(_GetCotationCasa($coordssegundou, 0, $relogio))
;~ 					$segundod 	= _FindNumber(_GetCotationCasa($coordssegundod, 0, $relogio))
					$minutou 	= _FindNumber(_GetCotationCasa($coordsminutou, 0, $relogio))
					$minutod 	= _FindNumber(_GetCotationCasa($coordsminutod, 0, $relogio))
					$horau		= _FindNumber(_GetCotationCasa($coordshorau, 0, $relogio))
					$horad 		= _FindNumber(_GetCotationCasa($coordshorad, 0, $relogio))
;~ 					ConsoleWrite(String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)&@CRLF)
					If StringLen(String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)) = 8 Then
						$pathfile &= "\" & String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou) & ".bmp"
						ConsoleWrite($pathfile)
						$sucessimg = _AplicarEfeitoSalvar($sTempFile_1, $pathfile)
						If $sucessimg Then
							GUICtrlSetData($Listhorariosalvo, $horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou & ".bmp")
							GUICtrlSetData($Labelrelogio, $horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)
							GUICtrlSetBkColor($Labelrelogio, 0x00FFFF) ; COLOR AQUA
							Sleep(250)
							GUICtrlSetData($Labelrelogio, _Nowtime(5))
						EndIf
						$pathfile = StringTrimRight($pathfile, 13)
						GUICtrlSetBkColor($Labelrelogio, $COR_CONECTADO)
					EndIf
				Else
					FileDelete($sTempFile_1)
				EndIf
			EndIf
			Local $hora = String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)
			If $hora = "17-59-50" Then
				_Captura($playCot)
				$play = False
			EndIf
		Else
			GUICtrlSetBkColor($Buttoniniciarcaptura, $COR_VERMELHO)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)
		EndIf
	WEnd
;~ 	GUISetState(@SW_SHOW, $Form2)
	GUICtrlSetData($Buttoniniciarcaptura, "INICIAR")
	GUICtrlSetBkColor($Labelrelogio, 0xFFFF00)
;~ 	GUICtrlSetState($Buttoniniciarcaptura, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoniniciarcaptura, $COLOR_MONEYGREEN)
	MsgBox(0, "STATUS", "ANÁLISE DOS DADOS INTERROMPIDA - " & _NowTime(5), 1.5)
	ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
	Sleep(500)
	ToolTip("")

EndFunc   ;==>_IniciarCapturaReplay
;---------------------------------------------------------------------------------


; _Captura()
Func _Captura($playCot)

	Local $relogio = 0xE6E6E6 ; DESVIO DO BRANCO DO RELÓGIO
	Local $conexao
	$playCot = True
	Local $sucessimgcaptura, $sTempFile_1
	Local $horad, $horau, $minutod, $minutou, $segundod, $segundou

	While $playCot

		$conexao = PixelSearch($coordsconexao[0], $coordsconexao[1], _
									$coordsconexao[2], $coordsconexao[3], $COR_CONECTADO, 25)

		If IsArray($conexao) Then

			GUICtrlSetBkColor($Buttoncapturar, $COLOR_MONEYGREEN)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: CAPTURANDO", 1, 1)
			; CAPTURAR IMAGEM
			$horad 		= _GetCotationCasa($coordshorad, 0, $relogio)
			$horad 		= _FindNumber($horad)
			$horau		= _GetCotationCasa($coordshorau, 0, $relogio)
			$horau		= _FindNumber($horau)
			$minutod 	= _GetCotationCasa($coordsminutod, 0, $relogio)
			$minutod 	= _FindNumber($minutod)
			$minutou 	= _GetCotationCasa($coordsminutou, 0, $relogio)
			$minutou 	= _FindNumber($minutou)
			$segundod 	= _GetCotationCasa($coordssegundod, 0, $relogio)
			$segundod 	= _FindNumber($segundod)
			$segundou 	= _GetCotationCasa($coordssegundou, 0, $relogio)
			$segundou 	= _FindNumber($segundou)

			$sTempFile_1 = _ScreenCapture_Capture("", $coordspainel[0], $coordspainel[1], $coordspainel[2], $coordspainel[3], False)
			$pathfile &= "\" & String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou) & ".bmp"
			$sucessimgcaptura = _AplicarEfeitoSalvar($sTempFile_1, $pathfile)
			If $sucessimgcaptura Then
				GUICtrlSetData($Labelrelogio, $horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)
				GUICtrlSetBkColor($Labelrelogio, 0x00FFFF) ; COLOR AQUA
				GUICtrlSetData($Listhorariosalvo, "CAPTURA OK - "&$horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou&".bmp")
				Sleep(1000)
			EndIf
			$pathfile = StringTrimRight($pathfile, 13)
		Else
			GUICtrlSetBkColor($Buttoncapturar, $COR_VERMELHO)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			Sleep(250)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			Sleep(250)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			Sleep(250)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			Sleep(250)
		EndIf
			$playCot = False
	WEnd
	GUICtrlSetData($Buttoncapturar, "CAPTURAR")
	GUICtrlSetState($Buttoncapturar, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoncapturar, 0x00FFFF)
	ToolTip("<<...>>", 0, 0, "STATUS: CAPTURADO", 1, 1)
	Sleep(25)
	ToolTip("")

EndFunc   ;==>_Captura
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
	If $ordem == 0 Then ; BUSCAR COR DA PLACA
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
	ElseIf $ordem == 1 Then ; APEANS MOVER O MOUSE ATÉ A PLACA
		For $i = 0 To UBound($coordscasa) - 2 Step 2
			$x0 = $coordscasa[$i]
			$y0 = $coordscasa[$i + 1]
			MouseMove($x0, $y0, 15)
		Next
	EndIf

EndFunc   ;==>_GetCotationCasaMove()
;---------------------------------------------------------------------------------


; OBSOLETO
#cs ; _Timer()
Func _Timer()

	Local $h, $m, $sTime, $g_iHour = 0, $g_iMins = 0, $g_iSecs = 0

	If $tipo == "REPLAY" And $play == True Then
		_TicksToTime(Int(TimerDiff(Round($g_hTimer))), $g_iHour, $g_iMins, $g_iSecs)
		$sTime	= $g_sTime
		$h		= $g_iHour + $r_hora
		$m		= $g_iMins + $r_min
		$s		= $r_seg
		If $s > 59 Then
			$r_seg		= 0
			$r_min		+= 1
			$g_iSecs	= 0
		EndIf
		If $m > 59 Then
			$r_hora		+= 1
			$r_min		= 0
			$g_iMins	= 0
		EndIf
		$g_sTime = StringFormat("%02s:%02i:%02i", $h, $m, $g_iSecs)
		If $sTime <> $g_sTime Then ControlSetText("WinProMoney_v1_2_20", "", "Static15", $g_sTime)
	Else
		_TicksToTime(Int(TimerDiff(Round($g_hTimer))), $g_iHour, $g_iMins, $g_iSecs)
		$sTime	= $g_sTime
		$h		= $g_iHour + $hr
		$m		= $g_iMins + $mn
		If  $m > 59 Then
			$hr += 1
			$mn = 0
		EndIf
		If  $g_iSecs > 59 Then
			$g_iSecs = 0
			$m += 1
		EndIf
		$g_sTime = StringFormat("%02s:%02i:%02i", $h, $m, $g_iSecs)
		If $sTime <> $g_sTime Then ControlSetText("WinProMoney_v1_2_20", "", $Labelrelogio, $g_sTime)
	EndIf

EndFunc   ;==>Timer3()
;-------------------------------------------------------------------------
#ce