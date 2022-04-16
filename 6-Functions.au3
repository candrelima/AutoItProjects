#include <File.au3>
#include <ButtonConstants.au3>
#include <GUIListBox.au3>
#include <FunctionsVisualizador.au3>
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
#include "Cores.au3"
;-------------------------------------------------------------------------
Local $hDLL = DllOpen("user32.dll")
Global $coordsbuy[2], $coordssell[2], _
		$coordsqtdbuy[4], $coordsqtdsell[4], _
		$coordsqtdbuydezena[14], $coordsqtdbuyunidade[14], _
		$coordsqtdselldezena[14], $coordsqtdsellunidade[14], _
		$coordsconexao[2], $coordsreplayORpregao[2], $coordsdif2disaply[2], $dif2display, _
		$coordsmilharc[14], $coordscentenac[14], $coordsdezenac[14], $coordsunidadec[14], _
		$coordsmilharv[14], $coordscentenav[14], $coordsdezenav[14], $coordsunidadev[14], _
		$coordshorad[14], $coordshorau[14], $coordsminutod[14], $coordsminutou[14], $coordssegundod[14], $coordssegundou[14]
Global $Form2, $Datedata, _
		$ButtonqtdCompraD, $ButtonqtdCompraU, $ButtonqtdVendaD, $ButtonqtdVendaU, _
		$Buttonhorad, $Buttonhorau, $Buttonminutod, $Buttonminutou, $Buttonsegundod, $Buttonsegundou, _
		$Buttoncompra, $Buttonvenda, $Buttonqtdcompra, $Buttonqtdvenda, $Buttonconexao, $ButtonreplayORpregao, _
		$Buttondif2display, $Buttonmilharc, $Buttoncentenac, $Buttondezenac, $Buttonunidadec, _
		$Buttonmilharv, $Buttoncentenav, $Buttondezenav, $Buttonunidadev, _
		$Radiodol, $Radioind, $Radiowdo, $Radiowin, $Radioreplay, $Radiopregao, _
		$Buttonsalvar, $Buttonabrir, $Progressler, $Buttontema, $Buttoniniciar, _
		$Buttonteste, $Labelbid, $Labelask, $Labelmediana, $Labelmedio, $Groupvalores
Global $Labelplaca1, $Labelplaca2, $Labelplaca3, $Labelplaca4, $Labelplaca5, $Labelplaca6, $Labelplaca7, $Labelhora
Global $Labelclock, $Inputax, $Inputay, $Inputbx, $Inputby, $Inputcx, $Inputcy, _
		$Inputdx, $Inputdy, $Inputex, $Inputey, $Inputfx, $Inputfy, $Inputgx, $Inputgy
Global $Labelclock, $Inputbuyx, $Inputbuyy, $Inputsellx, $Inputselly, _
		$Inputqtdcomprax, $Inputqtdcompray, $Inputqtdvendax, $Inputqtdvenday,$Inputdif2display, _
		$Inputqtdcompraxx, $Inputqtdcomprayy, $Inputqtdvendaxx, $Inputqtdvendayy,$Inputdif2display, _
		$Inputconexaox, $Inputconexaoy, $InputreplayORpregaox, $InputreplayORpregaoy
Global $salvar = False, $numcor, $complete = False, $ligado = False, $i = 0, $ativo, $tipo, _
		$leep = 25, $messageErro = "DADOS NÃO LOCALIZADOS" & @CRLF
Global $playCot, $dados, $play, $leilao, $redimensionar = False, $placas[7], $conectado
Global $hr, $mn, $sg, $r_hora = 0, $r_min = 0, $r_seg = 0, $g_hTimer, $g_sTime, $g_iSecs, $g_iMins, $g_iHour, $arrayTime[3]
;-------------------------------------------------------------------------

$numcor = GUICtrlRead($Buttontema, $GUI_READ_EXTENDED)
$numcor = Int(_StringBetween($numcor, "TEMA ", "/20"))

#--------=================----------#
#----------STOP PROGRAM-------------#
HotKeySet("{F2}", "_PararMarket")

; _PararMarket
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


; _SalvarCotations
Func _SalvarCotations($filex, $time, $medio, $mediana)

	Local $file = $filex & ".txt"
	Local $pathfile = @ScriptFullPath & $file
	If Not FileExists($pathfile) Then
		If $file = -1 Then
			MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO CRIAR ARQUIVO DE MEDIANAS - " & $file)
			Return False
		Else
			$file = FileOpen($file, $FO_APPEND)
			FileWrite($file, "<"&$time&"|"&$medio&"|"&$mediana&">" & @CRLF)
			Return True
		EndIf
	Else
		$file = FileOpen($file, $FO_APPEND)
		FileWrite($file, "<"&$time&"|"&$medio&"|"&$mediana&">" & @CRLF)
		Return True
	EndIf

	FileClose($file)

EndFunc   ;==>_SalvarCotations
;-------------------------------------------------------------------------


; _Tema
Func _Tema($cor)

	If $cor > 19 Then
		$cor = 0
	EndIf
	GUISetBkColor($iCOR[$cor])
	$cor += 1
	Return $cor

EndFunc   ;==>_Tema
;-------------------------------------------------------------------------


; _CreateFile
Func _CreateFile($replay, $nomearquivo)

	Local $re = $replay
	Local $data = GUICtrlRead($Datedata)

	If $re == "REPLAY" Then
		$file = "DATA-" &  $data & "-" & $nomearquivo & ".txt"
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
	ElseIf $re == "PREGÃO" Then
		$file = "DATA-" & $data & "-" & $nomearquivo & ".txt"
		Local $pathfile = @ScriptFullPath & $file
		If Not FileExists($pathfile) Then
			$file = FileOpen($file, $FO_APPEND)
			If $file = -1 Then
				MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO ABRIR ARQUIVO PREGÃO - " & $file)
				Return False
			EndIf
			FileWrite($file, "COTAÇÕES" & @CRLF)
			Return $file
		Else
			MsgBox($MB_SYSTEMMODAL, "ERROR", "OCORREU UM ERRO AO SALVAR ARQUIVO PREGÃO - " & $file)
		EndIf
	EndIf

EndFunc   ;==>_CreateFile
;-------------------------------------------------------------------------


; _capturarcoordsBuySell
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
;~ 		$compracor	= PixelSearch($coords[0], $coords[1], $coords[0] + 1, $coords[1] + 1, $COR_COMPRA, 10)
;~ 		$vendacor	= PixelSearch($coords[0], $coords[1], $coords[0] + 1, $coords[1] + 1, $COR_VENDA, 10)
;~ 		$conexaocor	= PixelSearch($coords[0], $coords[1], $coords[0] + 1, $coords[1] + 1, $COR_CONECTADO, 10)
;~ 		$replaycor	= PixelSearch($coords[0], $coords[1], $coords[0] + 1, $coords[1] + 1, $COR_REPLAY, 10)
;~ 		$leilaocor	= PixelSearch($coords[0], $coords[1], $coords[0] + 1, $coords[1] + 1, $COR_LEILAO, 10)

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


; _capturarcoordsPlacas
Func _capturarcoordsPlacas()

	Local $allcoords[14], $out = False, $resp, $coords, _
			$placacor, $cor

	GUICtrlSetData($Inputax, "")
	GUICtrlSetData($Inputay, "")
	GUICtrlSetData($Inputbx, "")
	GUICtrlSetData($Inputby, "")
	GUICtrlSetData($Inputcx, "")
	GUICtrlSetData($Inputcy, "")
	GUICtrlSetData($Inputdx, "")
	GUICtrlSetData($Inputdy, "")
	GUICtrlSetData($Inputex, "")
	GUICtrlSetData($Inputey, "")
	GUICtrlSetData($Inputfx, "")
	GUICtrlSetData($Inputfy, "")
	GUICtrlSetData($Inputgx, "")
	GUICtrlSetData($Inputgy, "")

	While Not $out

		$coords = MouseGetPos()
		$cor = PixelGetColor($coords[0], $coords[1])
		$cor = "0x" & Hex($cor, 6)
		If $cor == "0xFFFFFF" Then
			ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
			Beep(500, 25)
			Sleep(15)
		Else
			ToolTip("", $coords[0], $coords[1], "")
			Sleep($leep)
		EndIf

		If _IsPressed("31", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[0] = $coords[0]
			$allcoords[1] = $coords[1]
			GUICtrlSetData($Inputax, $coords[0])
			GUICtrlSetData($Inputay, $coords[1])
			While _IsPressed("31", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca1, "OK")
		EndIf
		If _IsPressed("32", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[2] = $coords[0]
			$allcoords[3] = $coords[1]
			GUICtrlSetData($Inputbx, $coords[0])
			GUICtrlSetData($Inputby, $coords[1])
			While _IsPressed("32", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca2, "OK")
		EndIf
		If _IsPressed("33", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[4] = $coords[0]
			$allcoords[5] = $coords[1]
			GUICtrlSetData($Inputcx, $coords[0])
			GUICtrlSetData($Inputcy, $coords[1])
			While _IsPressed("33", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca3, "OK")
		EndIf
		If _IsPressed("34", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[6] = $coords[0]
			$allcoords[7] = $coords[1]
			GUICtrlSetData($Inputdx, $coords[0])
			GUICtrlSetData($Inputdy, $coords[1])
			While _IsPressed("34", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca4, "OK")
		EndIf
		If _IsPressed("35", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[8] = $coords[0]
			$allcoords[9] = $coords[1]
			GUICtrlSetData($Inputex, $coords[0])
			GUICtrlSetData($Inputey, $coords[1])
			While _IsPressed("35", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca5, "OK")
		EndIf
		If _IsPressed("36", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[10] = $coords[0]
			$allcoords[11] = $coords[1]
			GUICtrlSetData($Inputfx, $coords[0])
			GUICtrlSetData($Inputfy, $coords[1])
			While _IsPressed("36", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca6, "OK")
		EndIf
		If _IsPressed("37", $hDLL) Then
			$coords = MouseGetPos()
			$cor = PixelGetColor($coords[0], $coords[1])
			$cor = "0x" & Hex($cor, 6)
			If $cor == "0xFFFFFF" Then
				ToolTip($coords[0] & " x " & $coords[1], $coords[0], $coords[1], "PLACA")
				Sleep($leep)
			Else
				ToolTip("", $coords[0], $coords[1], "")
				Sleep($leep)
			EndIf
			$allcoords[12] = $coords[0]
			$allcoords[13] = $coords[1]
			GUICtrlSetData($Inputgx, $coords[0])
			GUICtrlSetData($Inputgy, $coords[1])
			While _IsPressed("37", $hDLL)
				Sleep($leep)
			WEnd
			GUICtrlSetData($Labelplaca7, "OK")
		EndIf
		If _IsPressed("30", $hDLL) Then
			$resp = MsgBox(36, "MAPEAMENTO", "SAIR DO MAPEAMENTO?")
			If $resp == 6 Then
				$out = True
			EndIf
			While _IsPressed("30", $hDLL)
				Sleep($leep)
			WEnd
		EndIf
		Sleep($leep)

	WEnd ; SAIR SE $out = TRUE
	Return $allcoords

EndFunc   ;==>_capturarcoordsPlacas
;-------------------------------------------------------------------------


; _SalvarParametros
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


; _SalvarParametrosCaptFotos
Func _SalvarParametrosCaptFotos($cor)

	Local $bar = GUICreate("SALVANDO DADOS - CAPTURA DE FOTOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	Local $Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
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

		If Not IsNumber($coordsqtdbuy[1]) Or Not IsNumber($coordsqtdsell[1]) Or _ ; qtdbuy e qtdsell
			Not IsNumber($coordshorad[1]) Or Not IsNumber($coordshorau[1]) Or _ ; hora dezena e unidade
			Not IsNumber($coordsminutod[1]) Or Not IsNumber($coordsminutou[1]) Or _ ; minuto dezena e unidade
			Not IsNumber($coordssegundod[1]) Or Not IsNumber($coordssegundou[1]) Or _ ; segundo dezena e unidade
			Not IsNumber($coordsconexao[1]) Then  ; conexão

			MsgBox(48, "ALERTA", "DADOS INCOMPLETOS" & @CRLF & _
					"ATENÇÃO: Dados incompletos ocasionará o mal " & @CR & _
					"funcionamento do programa. É necessário realizar" & @CR & _
					"o correto mapeamento de todas as coordenadas" & @CR & _
					"para garantir a integridade do programa." & @CR & _
					"fail" & $arqsaved)

			GUIDelete($bar)
		Else
			GUISetState(@SW_SHOW)

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

			IniWrite($arqsaved, "ativo", "1", $ativo)
			GUICtrlSetData($Progressler, 15)
			Sleep($leep)
			IniWrite($arqsaved, "mercado", "1", $tipo)
			GUICtrlSetData($Progressler, 30)
			Sleep($leep)
			IniWrite($arqsaved, "tema", "1", $cor)
			GUICtrlSetData($Progressler, 45)
			Sleep($leep)
			IniWrite($arqsaved, "qtdbuy", "1", $coordsqtdbuy[0])
			IniWrite($arqsaved, "qtdbuy", "2", $coordsqtdbuy[1])
			IniWrite($arqsaved, "qtdbuy", "3", $coordsqtdbuy[2])
			IniWrite($arqsaved, "qtdbuy", "4", $coordsqtdbuy[3])
			GUICtrlSetData($Progressler, 60)
			Sleep($leep)
			IniWrite($arqsaved, "qtdsell", "1", $coordsqtdsell[0])
			IniWrite($arqsaved, "qtdsell", "2", $coordsqtdsell[1])
			IniWrite($arqsaved, "qtdsell", "3", $coordsqtdsell[2])
			IniWrite($arqsaved, "qtdsell", "4", $coordsqtdsell[3])
			GUICtrlSetData($Progressler, 75)
			Sleep($leep)
			IniWrite($arqsaved, "conexao", "1", $coordsconexao[0])
			GUICtrlSetData($Progressler, 90)
			Sleep($leep)
			IniWrite($arqsaved, "conexao", "2", $coordsconexao[1])
			GUICtrlSetData($Progressler, 100)
			Sleep($leep)
			MsgBox($MB_SYSTEMMODAL, "DADOS", "SUCESSO: DADOS COMPLETOS" & @CRLF & $arqsaved, 2)

			GUIDelete($bar)
			Return 1
		EndIf
	EndIf

EndFunc   ;==>_SalvarParametrosCaptFotos
;-------------------------------------------------------------------------


; _AbrirParametros
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

		$section = IniReadSection($arqopened, "ativo")
		If $section[1][1] == "DOL" Then
			GUICtrlSetState($Radiodol, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "IND" Then
			GUICtrlSetState($Radioind, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "WDO" Then
			GUICtrlSetState($Radiowdo, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "WIN" Then
			GUICtrlSetState($Radiowin, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "ATIVO NÃO LOCALIZADO" & @CR
		EndIf
;~ 		ConsoleWrite("10% COMPLETE..." & @CR)
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "mercado")
		If $section[1][1] == "REPLAY" Then
			GUICtrlSetState($Radioreplay, $GUI_CHECKED)
;~ 			$replay = True
			GUICtrlSetData($Progressler, 20)
;~ 			ConsoleWrite("20% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "PREGÃO" Then
			GUICtrlSetState($Radiopregao, $GUI_CHECKED)
;~ 			$replay = False
			GUICtrlSetData($Progressler, 20)
;~ 			ConsoleWrite("20% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "MERCADO NÃO LOCALIZADO" & @CR
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "tema")
		$cor = Int($section[1][1])
		If $cor > 20 Then
			$cor = 1
		Endif
		If $cor > 0 Then
			GUICtrlSetData($Buttontema, "TEMA " & $cor & "/20")
			GUISetBkColor($iCOR[($cor - 1)], $Form2)
			GUICtrlSetData($Progressler, 30)
;~ 			ConsoleWrite("30% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetData($Buttontema, "TEMA")
		EndIf

		; ------ HORA ------
		; ------ horad -----
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
		; ------ horau -----
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
		; ------ minutod -----
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
		; ------ minutou -----
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
		; ------ segundod -----
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
		; ------ segundou -----
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
		GUICtrlSetData($Progressler, 33)
;~ 		ConsoleWrite("33% COMPLETE..." & @CR)


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
			GUICtrlSetData($Progressler, 35)
;~ 			ConsoleWrite("35% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA COMPRA" & @CR
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "qtdbuy")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordsqtdbuy, Int($section[1][1]))
			_ArrayPush($coordsqtdbuy, Int($section[2][1]))
			_ArrayPush($coordsqtdbuy, Int($section[3][1]))
			_ArrayPush($coordsqtdbuy, Int($section[4][1]))
;~ 		_ArrayDisplay($coordsqtdbuy)
			GUICtrlSetData($Inputqtdcomprax, $section[1][1])
			GUICtrlSetData($Inputqtdcompray, $section[2][1])
			GUICtrlSetData($Inputqtdcompraxx, $section[3][1])
			GUICtrlSetData($Inputqtdcomprayy, $section[4][1])
			GUICtrlSetBkColor($Buttonqtdcompra, $COLOR_LIME)
			GUICtrlSetData($Progressler, 37)
;~ 			ConsoleWrite("37% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS QTD DA COMPRA" & @CR
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "sell")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordssell, Int($section[1][1]))
			_ArrayPush($coordssell, Int($section[2][1]))
;~ 			_ArrayDisplay($coordssell)
			GUICtrlSetData($Inputsellx, $section[1][1])
			GUICtrlSetData($Inputselly, $section[2][1])
			GUICtrlSetBkColor($Buttonvenda, $COLOR_LIME)
			GUICtrlSetData($Progressler, 40)
;~ 			ConsoleWrite("40% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA VENDA" & @CRLF
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "qtdsell")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordsqtdsell, Int($section[1][1]))
			_ArrayPush($coordsqtdsell, Int($section[2][1]))
			_ArrayPush($coordsqtdsell, Int($section[3][1]))
			_ArrayPush($coordsqtdsell, Int($section[4][1]))
;~ 			_ArrayDisplay($coordsqtdsell)
			GUICtrlSetData($Inputqtdvendax, $section[1][1])
			GUICtrlSetData($Inputqtdvenday, $section[2][1])
			GUICtrlSetData($Inputqtdvendaxx, $section[3][1])
			GUICtrlSetData($Inputqtdvendayy, $section[4][1])
			GUICtrlSetBkColor($Buttonqtdvenda, $COLOR_LIME)
			GUICtrlSetData($Progressler, 39)
;~ 			ConsoleWrite("39% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS QTD DA VENDA" & @CR
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "modoconexao")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordsreplayORpregao, Int($section[1][1]))
			_ArrayPush($coordsreplayORpregao, Int($section[2][1]))
;~ 		_ArrayDisplay($coordssell)
			GUICtrlSetData($InputreplayORpregaox, $section[1][1])
			GUICtrlSetData($InputreplayORpregaoy, $section[2][1])
			GUICtrlSetBkColor($ButtonreplayORpregao, $COLOR_LIME)
			GUICtrlSetData($Progressler, 40)
;~ 			ConsoleWrite("40% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA VENDA" & @CRLF
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "conexao")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordsconexao, Int($section[1][1]))
			_ArrayPush($coordsconexao, Int($section[2][1]))
;~ 		_ArrayDisplay($coordsconexao)
			GUICtrlSetData($Inputconexaox, $section[1][1])
			GUICtrlSetData($Inputconexaoy, $section[2][1])
			GUICtrlSetBkColor($Buttonconexao, $COLOR_LIME)
			GUICtrlSetData($Progressler, 43)
;~ 			ConsoleWrite("43% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA CONEXÃO" & @CRLF
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "distDisplay")
		If IsNumber(Int($section[1][1])) Then
			$dif2display = Int($section[1][1])
			GUICtrlSetData($Inputdif2display, $section[1][1])
;~ 			MsgBox(0, "", "DISTÂNCIA ENTRE COTAÇOES: " & $coordsdif2display, 2)
			GUICtrlSetBkColor($Buttondif2display, $COLOR_LIME)
			GUICtrlSetData($Progressler, 50)
;~ 			ConsoleWrite("50% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADA DIFERENÇA ENTRE COTAÇÕES" & @CRLF
		EndIf
;~ 		Sleep($leep)

		; ------ QTD COMPRA DEZENA ------
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
			GUICtrlSetData($Progressler, 55)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdCompraD, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD COMPRA DEZENA" & @CRLF
		EndIf
;~ 		Sleep($leep)

		; ------ QTD COMPRA UNIDADE ------
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
			GUICtrlSetData($Progressler, 55)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdCompraU, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD COMPRA UNIDADE" & @CRLF
		EndIf
;~ 		Sleep($leep)

		; ------ QTD VENDA DEZENA ------
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
			GUICtrlSetData($Progressler, 55)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdVendaD, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD VENDA DEZENA" & @CRLF
		EndIf
;~ 		Sleep($leep)

		; ------ QTD VENDA UNIDADE ------
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
			GUICtrlSetData($Progressler, 55)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($ButtonqtdVendaU, $COLOR_RED)
			$messageErro += "COORDENADAS DA QTD VENDA UNIDADE" & @CRLF
		EndIf
;~ 		Sleep($leep)

		; ------ COMPRA ------
		; ------ milharc -----
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
			GUICtrlSetData($Progressler, 55)
;~ 			ConsoleWrite("55% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharc, $COLOR_RED)
			$messageErro += "COORDENADAS DA MILHAR(COMPRA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ centenac -----
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
			GUICtrlSetData($Progressler, 60)
;~ 			ConsoleWrite("60% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttoncentenac, $COLOR_RED)
			$messageErro += "COORDENADAS DA CENTENA(COMPRA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ dezenac -----
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
			GUICtrlSetData($Progressler, 65)
;~ 			ConsoleWrite("65% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenac, $COLOR_RED)
			$messageErro += "COORDENADAS DA DEZENA(COMPRA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ unidadec -----
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
			GUICtrlSetData($Progressler, 70)
;~ 			ConsoleWrite("70% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadec, $COLOR_RED)
			$messageErro += "COORDENADAS DA UNIDADE(COMPRA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ VENDA ------
		; ------ milharv ----
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
			GUICtrlSetData($Progressler, 75)
;~ 			ConsoleWrite("75% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonmilharv, $COLOR_RED)
			$messageErro += "COORDENADAS DA MILHAR(VENDA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ centenav ----
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
			GUICtrlSetData($Progressler, 80)
;~ 			ConsoleWrite("80% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($coordscentenav, $COLOR_RED)
			$messageErro += "COORDENADAS DA CENTENA(VENDA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ dezenav ----
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
			GUICtrlSetData($Progressler, 85)
;~ 			ConsoleWrite("85% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttondezenav, $COLOR_RED)
			$messageErro += "COORDENADAS DA DEZENA(VENDA)" & @CRLF
		EndIf
;~ 		Sleep($leep)
		; ------ unidadev ----
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
			GUICtrlSetData($Progressler, 100)
;~ 			ConsoleWrite("100% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetBkColor($Buttonunidadev, $COLOR_RED)
			$messageErro += "COORDENADAS DA UNIDADE(VENDA)" & @CRLF
		EndIf
;~ 		Sleep($leep)

		If GUICtrlRead($Progressler) == 100 Then
			MsgBox(48, "RESUMO", "DADOS LIDOS COM SUCESSO", 2)
			GUIDelete($bar)
			Return 1
		Else
			MsgBox(48, "RESUMO", $messageErro)
			Return 0
		EndIf
	EndIf

EndFunc   ;==>_AbrirParametros
;-------------------------------------------------------------------------


; _AbrirParametros2
Func _AbrirParametros2()

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

		$section = IniReadSection($arqopened, "qtdbuy")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordsqtdbuy, Int($section[1][1]))
			_ArrayPush($coordsqtdbuy, Int($section[2][1]))
			_ArrayPush($coordsqtdbuy, Int($section[3][1]))
			_ArrayPush($coordsqtdbuy, Int($section[4][1]))
;~ 			_ArrayDisplay($coordsqtdbuy)
			GUICtrlSetData($Inputqtdcomprax, $section[1][1])
			GUICtrlSetData($Inputqtdcompray, $section[2][1])
			GUICtrlSetData($Inputqtdcompraxx, $section[3][1])
			GUICtrlSetData($Inputqtdcomprayy, $section[4][1])
			GUICtrlSetBkColor($Buttonqtdcompra, $COLOR_LIME)
			GUICtrlSetData($Progressler, 2)
;~ 			ConsoleWrite("2% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS QTD DA COMPRA" & @CR
		EndIf

		$section = IniReadSection($arqopened, "qtdsell")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) And _
			IsNumber(Int($section[3][1])) And IsNumber(Int($section[4][1])) Then
			_ArrayPush($coordsqtdsell, Int($section[1][1]))
			_ArrayPush($coordsqtdsell, Int($section[2][1]))
			_ArrayPush($coordsqtdsell, Int($section[3][1]))
			_ArrayPush($coordsqtdsell, Int($section[4][1]))
;~ 			_ArrayDisplay($coordsqtdsell)
			GUICtrlSetData($Inputqtdvendax, $section[1][1])
			GUICtrlSetData($Inputqtdvenday, $section[2][1])
			GUICtrlSetData($Inputqtdvendaxx, $section[3][1])
			GUICtrlSetData($Inputqtdvendayy, $section[4][1])
			GUICtrlSetBkColor($Buttonqtdvenda, $COLOR_LIME)
			GUICtrlSetData($Progressler, 39)
;~ 			ConsoleWrite("39% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS QTD DA VENDA" & @CR
		EndIf
;~ 		Sleep($leep)

		; ------ HORA ------
		; ------ horad -----
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
		; ------ horau -----
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
		; ------ minutod -----
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
		; ------ minutou -----
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
		; ------ segundod -----
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
		; ------ segundou -----
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

		$section = IniReadSection($arqopened, "ativo")
		If $section[1][1] == "DOL" Then
			GUICtrlSetState($Radiodol, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "IND" Then
			GUICtrlSetState($Radioind, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "WDO" Then
			GUICtrlSetState($Radiowdo, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "WIN" Then
			GUICtrlSetState($Radiowin, $GUI_CHECKED)
			GUICtrlSetData($Progressler, 10)
;~ 			ConsoleWrite("10% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "ATIVO NÃO LOCALIZADO" & @CR
		EndIf
;~ 		ConsoleWrite("10% COMPLETE..." & @CR)
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "mercado")
		If $section[1][1] == "REPLAY" Then
			GUICtrlSetState($Radioreplay, $GUI_CHECKED)
;~ 			$replay = True
			GUICtrlSetData($Progressler, 20)
;~ 			ConsoleWrite("20% COMPLETE..." & @CR)
			Sleep($leep)
		ElseIf $section[1][1] == "PREGÃO" Then
			GUICtrlSetState($Radiopregao, $GUI_CHECKED)
;~ 			$replay = False
			GUICtrlSetData($Progressler, 20)
;~ 			ConsoleWrite("20% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "MERCADO NÃO LOCALIZADO" & @CR
		EndIf
;~ 		Sleep($leep)

		$section = IniReadSection($arqopened, "tema")
		$cor = Int($section[1][1])
		If $cor > 20 Then
			$cor = 1
		Endif
		If $cor > 0 Then
			GUICtrlSetData($Buttontema, "TEMA " & $cor & "/20")
			GUISetBkColor($iCOR[($cor - 1)], $Form2)
			GUICtrlSetData($Progressler, 30)
;~ 			ConsoleWrite("30% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			GUICtrlSetData($Buttontema, "TEMA")
		EndIf

		$section = IniReadSection($arqopened, "conexao")
		If IsNumber(Int($section[1][1])) And IsNumber(Int($section[2][1])) Then
			_ArrayPush($coordsconexao, Int($section[1][1]))
			_ArrayPush($coordsconexao, Int($section[2][1]))
;~ 			_ArrayDisplay($coordsconexao)
			GUICtrlSetData($Inputconexaox, $section[1][1])
			GUICtrlSetData($Inputconexaoy, $section[2][1])
			GUICtrlSetBkColor($Buttonconexao, $COLOR_LIME)
			GUICtrlSetData($Progressler, 100)
;~ 			ConsoleWrite("100% COMPLETE..." & @CR)
			Sleep($leep)
		Else
			$messageErro += "COORDENADAS DA CONEXÃO" & @CRLF
		EndIf
;~ 		Sleep($leep)

		If GUICtrlRead($Progressler) == 100 Then
			MsgBox(48, "RESUMO", "DADOS LIDOS COM SUCESSO", 2)
			GUIDelete($bar)
			Return 1
		Else
			MsgBox(48, "RESUMO ERRO", $messageErro)
			Return 0
		EndIf
	EndIf

EndFunc   ;==>_AbrirParametros2
;-------------------------------------------------------------------------


; _Exit
Func _Exit()
		_GDIPlus_Shutdown()
		Exit
	EndFunc   ;==>_Exit
;-------------------------------------------------------------------------


; _CalcularMedioMediana
Func _CalcularMedioMediana()

	Local $bar = GUICreate("COLETANDO DADOS", 310, 30, (@DesktopWidth / 2) - 155, (@DesktopHeight / 2) - 130)
	Local $Progressler = GUICtrlCreateProgress(5, 5, 300, 20, $PBS_SMOOTH)
	GUICtrlSetColor($Progressler, "FFF")
	$arqopened = FileOpenDialog("ABRIR ARQUIVO", @ScriptDir & "\", "(*.txt)", $FD_PATHMUSTEXIST, "param")

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "ERRO", "FALHA AO ABRIR ARQUIVO DE COTAÇÕES.")
		Return 0
	Else
		GUISetState(@SW_SHOW)
		$file = FileOpen($arqopened, $FO_READ)
		If @error = -1 Then
			MsgBox($MB_SYSTEMMODAL, "ERRO - ", $file)
			Return False
		Else
;~ 			MsgBox($MB_SYSTEMMODAL, "", "SUCESS - FILE OPENED " & @CRLF)
			Local $line = 1, $percent = 1
			Local $arrayTime, $arrayBuy, $arraySell, $stringParts[3]
			Local $somaMedio[100], $somaMediana[100], $getMedio, $getMediana, $sucess, $sizeBound = 0, _
					$hora, $segundos, $maxValue = 1000, $minValue = 10000, $linhamin, $linhamax
			Local $numberStrings[4]
			local $continue = False

			Local $linha = FileReadLine($file, $line)
			$numberStrings = StringSplit($linha, "|", 0)

			If $linha == "COTAÇÕES" Then
				Local $nomearArq = InputBox("NOME DO ARQUIVO", "QUAL O NOME DO ARQUIVO MÉDIOS/MEDIANAS?", _
											"MEDIANAS_DATA-", "", 400, 200, @DesktopWidth/2 - 200, _
											@DesktopHeight/2 - 200, $Form2)
				$continue = True
				$line += 1
			Else
				GUISetState(@SW_HIDE)
				MsgBox($MB_SYSTEMMODAL, "ERRO", "ERRO TIPO DE ARQUIVO - COLETA NÃO REALIZADA." & @CRLF)
				Return False
			EndIf

			While $continue
				$linha = FileReadLine($file, $line)
				$numberStrings = StringSplit($linha, "|", 0) ;  (0)arraysize, (1)time, (2)ordem, (3)buy, (4)sell

				If $numberStrings[0] == 1 Then
					GUICtrlSetData($Progressler, 100)
					MsgBox($MB_SYSTEMMODAL, "", "DADOS CONSOLIDADOS - 100%"& @CRLF, 2)
					GUISetState(@SW_HIDE)
					$continue = False
					Break(1)
				EndIf

				If $numberStrings[0] == 2 Then
					$line += 1
					ContinueLoop
				EndIf

				If $numberStrings[0] > 2 Then
;~ 					ConsoleWrite("READ LINE..."& $linha & @CR)
;~	 				ConsoleWrite("NUMBER OF ELEMENTS: "& $numberStrings[0] & @CR)

;~ 					$stringParts[0] = StringTrimLeft($numberStrings[1], 1) ; time ("<00:00:00") --> ("00:00:00")

					; REALIZAR CALCULO DE 5 EM 5 MINUTOS () - CAPTURAR APENAS OS MINUTOS
					$stringParts[0] = StringTrimRight(StringTrimLeft($numberStrings[1], 1), 3) ; hora ("<00:00:00") --> ("--:00:00")
					$hora = StringTrimRight(StringTrimLeft($numberStrings[1], 3), 4) ; hora ("<00:00:00") --> ("--:00:00")
					$minutos = StringTrimRight(StringTrimLeft($numberStrings[1], 5), 3) ; minutos ("<00:00:00") --> ("--:00:--")
					$segundos = StringTrimLeft($numberStrings[1], 6) ; segundos ("<00:00:00") --> ("--:--:00")
;~ 					ConsoleWrite("$segundos: " & $segundos & @CRLF)

					$stringParts[1] = $numberStrings[3] ; buy ("5555")
					If Int($stringParts[1]) < 5000 Then
						$line += 1
						ContinueLoop
					EndIf
					If $minValue > Int($stringParts[1]) Then
						$linhamin = $line
						$minValue = Int($stringParts[1])
					EndIf
					$stringParts[2] = StringTrimRight($numberStrings[4], 1) ; sell ("5555>") --> ("5555")
					If $maxValue < Int($stringParts[1]) Then
						$linhamax = $line
						$maxValue = Int($stringParts[2])
					EndIf

					$getMedio = _GetMedio($stringParts[1], $stringParts[2])
					_ArrayPush($somaMedio, $getMedio)
					$getMediana = _GetMediana($stringParts[1], $stringParts[2])
					_ArrayPush($somaMediana, $getMediana)

					If $line > 1 Then
						If $minutos == "4" Or $minutos == "9" And $segundos == ":59" Then ; 5 EM 5 MINUTOS
	;~ 						_ArrayDisplay($somaMedio, "$somaMedio", "", 1)
	;~ 						_ArrayDisplay($somaMediana, "$somaMediana", "", 1)

							$getMedio = Round(_SumMed($somaMedio), 2)
							$getMediana = Round(_SumMed($somaMediana), 2)
							$hora = $stringParts[0]
							; zerando os arrays
							$sizeBound = UBound($somaMedio) - 1
							_ArrayTrim($somaMedio, 4, 1, 1, $sizeBound)
							$sizeBound = UBound($somaMediana) - 1
							_ArrayTrim($somaMediana, 6, 1, 1, $sizeBound)

	;~ 						_ArrayDisplay($somaMedio, "$somaMedio", "", 1)
	;~ 						_ArrayDisplay($somaMediana, "$somaMediana", "", 1)

							; salvando hora, medio e mnediana
							$sucess = _SalvarCotations($nomearArq, $hora, $getMedio, $getMediana)
							If $sucess Then
								ConsoleWrite("COTAÇÃO SALVA" & "--"& $hora &"--" & @CRLF)
							EndIf
						Else
;~ 							$sucess = _SalvarCotations($nomearArq, $hora, "PENDENTE", "PENDENTE")
;~ 							If $sucess Then
;~ 								ConsoleWrite("COTAÇÃO PENDENTE" & "--"& $hora &"--" & @CRLF)
;~ 							EndIf
						EndIf
					EndIf


;~ 					ConsoleWrite("Time: " & $stringParts[0] & @CRLF)
;~ 					ConsoleWrite("Buy: " & $stringParts[1] & @CRLF)
;~ 					ConsoleWrite("Sell: " & $stringParts[2] & @CRLF)
					; CALCULANDO MEDIO E MEDIANA

					$line += 1
					$percent = Ceiling($i/100)
					If $percent == 100 Then
						$percent = 1
						$i = 1
					Else
						$i += 1
					EndIf
					GUICtrlSetData($Progressler, $percent)
				EndIf

			WEnd
			$sucess = _SalvarCotations($nomearArq, "LinhaMin:"&$linhamin&"/LinhaMax:"&$linhamax, $minValue, $maxValue) ; SALVANDO MAXIMO E MINIMO
			If $sucess Then
				ConsoleWrite("MAXIMO/MINIMO SALVOS" & @CRLF)
				ConsoleWrite("---------END---------")
			EndIf
		EndIf

		Return True

	EndIf

EndFunc   ;==>_CalcularMedioMediana
;-------------------------------------------------------------------------


; Timer
Func Timer()

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
		If $sTime <> $g_sTime Then ControlSetText("WinProMoney_v1_2_20", "", "Static15", $g_sTime)
	EndIf

EndFunc   ;==>Timer
;-------------------------------------------------------------------------


; Timer2
Func Timer2()

	If $tipo == "REPLAY" And $play == True Then
		If $r_seg > 59 Then
			$r_seg	= 0
			$r_min	+= 1
		EndIf
		If $r_min > 59 Then
			$r_hora		+= 1
			$r_min		= 0
		EndIf
		$g_sTime = StringFormat("%02i:%02i:%02i", $r_hora, $r_min, $r_seg)
		$r_seg += 1
	Else
		If  $mn > 59 Then
			$hr += 1
			$mn = 0
			If $hr == 24 Then
				$hr = 00
			EndIf
		EndIf
		If  $sg > 59 Then
			$sg = 0
			$mn += 1
		EndIf
		$g_sTime = StringFormat("%02i:%02i:%02i", $hr, $mn, $sg)
		$sg += 1
	EndIf
	ControlSetText("WinProMoney_v1_2_20", "", "Static15", $g_sTime)

EndFunc   ;==>Timer2
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


; _TestePosicao
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


; _IniciarCotacao
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


; _IniciarCotacao2
Func _IniciarCotacao2($playCot, $tipo)

	Local $capture = "", $file
	Local $time, $contador = 1
	Local $pathfile = @ScriptDir &"\Fotos"
	$play = $playCot
	Local $pixelChangeBuy1, $pixelChangeBuy2, $pixelChangeSell1, $pixelChangeSell2
	Local $relogio = 0xE6E6E6 ; desvio de branco
	Local $conexao, $imagepath, $timeInit, $timeEnd, $timeSpend

;~ 	GUISetState(@SW_HIDE, $Form2)
	GUICtrlSetData($Buttoniniciar, "PARAR(F2)")
	GUICtrlSetState($Buttoniniciar, $GUI_DISABLE)

	While $play

		$conexao = PixelSearch($coordsconexao[0]-1, $coordsconexao[1]-1, _
									$coordsconexao[0]+1, $coordsconexao[1]+1, $COR_CONECTADO, 5, 1)

		If IsArray($conexao) Then

			GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
			ToolTip("<<F2=STOP>>", 0, 0, "STATUS: CONNECTED", 1, 1)
;~ 			MsgBox(0, "", $segundou, 2)
;~ 			$pixelChangeBuy1 = 0
;~ 			$pixelChangeBuy2 = 0

			; vamos usar a $pixelChangeBuy1 e $pixelChangeBuy2 para mapear a mudança no relógio
			; vamos usar a $pixelChangeSell1 e $pixelChangeSell2 para capturar os preços ask e bid da tabela
;~ 			$pixelChangeBuy1		= PixelChecksum($coordsqtdbuy[0], $coordsqtdbuy[1], _
;~ 													$coordsqtdbuy[2], $coordsqtdbuy[3]) ; coords da tela para captar as mudanças da hora
;~ 			While $pixelChangeBuy1	= PixelChecksum($coordsqtdbuy[0], $coordsqtdbuy[1], _
;~ 													$coordsqtdbuy[2], $coordsqtdbuy[3])
			Sleep(250)
;~ 			WEnd
;~ 			$pixelChangeSell1		= PixelChecksum($coordsqtdsell[0], $coordsqtdsell[1], _
;~ 													$coordsqtdsell[2], $coordsqtdsell[3]) ; coords da tela para captar as mudanças ask e bid

;~ 			$pixelChangeBuy2		= PixelChecksum($coordsqtdbuy[0], $coordsqtdbuy[1], _
;~ 													$coordsqtdbuy[2], $coordsqtdbuy[3]) ; coords da tela para captar as mudanças da hora
;~ 			$pixelChangeSell2		= PixelChecksum($coordsqtdsell[0], $coordsqtdsell[1], _
;~ 													$coordsqtdsell[2], $coordsqtdsell[3]) ; coords da tela para captar as mudanças ask e bid
;~ 			$time	= GUICtrlRead($Labelclock, $GUI_READ_EXTENDED)
;~ 			$hora	= StringReplace($time, ":", "-")
;~ 			If $pixelChangeBuy1 <> $pixelChangeBuy2 Then ; se o mapeamento da hora mudar, captura a imagem do ask e bid
				; capturar a cada 10 segundos
				$timeInit = _Timer_Init()
				$horad 		= _GetCotationCasa($coordshorad, 0, $relogio)
				$horad 		= _FindNumber($horad)
				$horau		= _GetCotationCasa($coordshorau, 0, $relogio)
				$horau		= _FindNumber($horau)
				$minutod 	= _GetCotationCasa($coordsminutod, 0, $relogio)
				$minutod 	= _FindNumber($minutod)
				$minutou 	= _GetCotationCasa($coordsminutou, 0, $relogio)
				$minutou 	= _FindNumber($minutou)
				$segundou 	= _GetCotationCasa($coordssegundou, 0, $relogio)
				$segundou 	= _FindNumber($segundou)
				$segundod 	= _GetCotationCasa($coordssegundod, 0, $relogio)
				$segundod 	= _FindNumber($segundod)
				If $segundou == 0 Then
;~ 					$file = String($contador&"-"&$segundod&$segundou) & ".jpg"
					$file = String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou) & ".jpg"
					$imagepath = $pathfile & "\" & $file
					$capture = _ScreenCapture_Capture($imagepath, $coordsqtdsell[0], $coordsqtdsell[1], _
									$coordsqtdsell[2], $coordsqtdsell[3], False)
;~ 					If FileExists($pathfile) Then
;~ 						$imagepath = $pathfile & "\" & $file
;~ 						$capture = _ScreenCapture_Capture($imagepath, $coordsqtdsell[0], $coordsqtdsell[1], _
;~ 															$coordsqtdsell[2], $coordsqtdsell[3], False)
						_ScreenCapture_SaveImage($imagepath, $capture)
						$timeEnd = Round(_Timer_Diff($timeInit)/3)
						$time = String($contador&"-"&$segundod&$segundou)
						$time = String($horad&$horau&"-"&$minutod&$minutou&"-"&$segundod&$segundou)
;~ 						GUICtrlSetData($Labelhora, $time)
						GUICtrlSetData($Labelhora, $timeEnd)
						GUICtrlSetBkColor($Groupvalores, 0xCDCDCD)
						$contador += 1
;~ 					Else
;~ 						DirCreate($pathfile)
;~ 						MsgBox($MB_SYSTEMMODAL, "ERROR", "A PASTA \Fotos FOI CRIADA - ")
;~ 					EndIf
				Else
					GUICtrlSetData($Labelhora, $time)
					GUICtrlSetBkColor($Groupvalores, 0x00FF00)
				EndIf
;~ 			Else
;~ 				GUICtrlSetData($Labelhora, $time)
;~ 				GUICtrlSetBkColor($Groupvalores, 0x00FF00)
;~ 			EndIf
		Else
			GUICtrlSetBkColor($Buttoniniciar, 0xFF0000)
			ToolTip("<<>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<.>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<..>>", 0, 0, "STATUS: CONNECTING", 1, 1)
			ToolTip("<<...>>", 0, 0, "STATUS: CONNECTING", 1, 1)
		EndIf

		If $time == "18:01:00" Then
			$play = False
		EndIf
	WEnd
;~ 	GUISetState(@SW_SHOW, $Form2)
	GUICtrlSetData($Buttoniniciar, "INICIAR")
	GUICtrlSetState($Buttoniniciar, $GUI_ENABLE)
	GUICtrlSetBkColor($Buttoniniciar, $COLOR_MONEYGREEN)
	MsgBox(0, "STATUS", "ANÁLISE DOS DADOS INTERROMPIDA - " & $time, 1.5)
	ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
	Sleep(1000)
	ToolTip("")

EndFunc   ;==>_IniciarCotacao2
;---------------------------------------------------------------------------------


; _FindNumber
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
	$a = $plates[0]
	$b = $plates[1]
	$c = $plates[2]
	$d = $plates[3]
	$e = $plates[4]
	$f = $plates[5]
	$g = $plates[6]
	For $i = 0 To UBound($plates) - 1 Step 1
		If $plates[$i] == 1 Then
			$contador += 1
		EndIf
	Next

	If $contador == 2 Then
		$number = 1
	EndIf
	If $contador == 7 Then
		$number = 8
	EndIf
	If $contador == 4 And $g Then
		$number  = 4
	EndIf
	If $contador == 4 And Not $g Then
		$number = 7
	EndIf
	If $contador == 5 And Not $c Then
		$number = 2
	EndIf
	If $contador == 5 And Not $e And Not $f Then
		$number = 3
	EndIf
	If $contador == 5 And Not $b Then
		$number = 5
	EndIf
	If $contador == 6 And Not $b Then
		$number = 6
	EndIf
	If $contador == 6 And Not $e Then
		$number = 9
	EndIf
	If $contador == 6 And Not $g Then
		$number = 0
	EndIf
;~ 	If String($number) <> "" Then
;~ 		MsgBox(0, "TESTING PLACAS", "Número = " & $number,1)
;~ 	EndIf
	Return $number

	# COMPARANDO CADA ELEMENTO DO ARRAY AOS ARRAY DOS NUMEROS
	# RETORNADO O NUMERO EXATO DE 0 A 9
	; nada encontrado
;~ 	If Not $a And Not $g And Not $d Then
;~ 		Return 1
;~ 	EndIf
;~ 	If Not $c And Not $f And $g Then
;~ 		Return 2
;~ 	EndIf
;~ 	If Not $e And Not $f And $g Then
;~ 		Return 3
;~ 	EndIf
;~ 	If Not $a And Not $d And $g Then
;~ 		Return 4
;~ 	EndIf
;~ 	If Not $b And Not $e And $g Then
;~ 		Return 5
;~ 	EndIf
;~ 	If Not $b And $e And $g Then
;~ 		Return 6
;~ 	EndIf
;~ 	If Not $d And Not $e And Not $g And $f Then
;~ 		Return 7
;~ 	EndIf
;~ 	If $b And $c And $e And $g Then
;~ 		Return 8
;~ 	EndIf
;~ 	If $d And $g And Not $e Then
;~ 		Return 9
;~ 	EndIf
;~ 	If Not $a _
;~ 		And Not $b _
;~ 			And Not $c _
;~ 				And Not $d _
;~ 					And Not $e _
;~ 						And Not $f _
;~ 							And $g Then
;~ 		Return 0
;~ 	EndIf

EndFunc   ;==>_FindNumber
;---------------------------------------------------------------------------------


; _HasBuyCotation
Func _HasBuyCotation($coordsbuy, $ordem, $color)

;~ 	If $redimensionar Then
;~ 		$coordsbuy[1] += 18
;~ 	EndIf

	Local $x0 = $coordsbuy[0]
	Local $y0 = $coordsbuy[1] + ($ordem * $dif2display)
	Local $x1 = $coordsbuy[0]
	Local $y1 = $coordsbuy[1] + ($ordem * $dif2display)

	Local $hasBuy = PixelSearch($x0, $y0, $x1, $y1, $color, 5, 1)

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
Func _HasSellCotation($coordssell, $ordem, $color)

;~ 	If $redimensionar Then
;~ 		$coordssell[1] += 18
;~ 	EndIf

	Local $x0 = $coordssell[0]
	Local $y0 = $coordssell[1] + ($ordem * $dif2display)
	Local $x1 = $coordssell[0]
	Local $y1 = $coordssell[1] + ($ordem * $dif2display)

	Local $hasSell = PixelSearch($x0, $y0, $x1, $y1, $color, 5, 1)

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


; _GetCotationCasa
Func _GetCotationCasa($coordscasa, $ordem, $color)

	Local $hasplaca, $x0 = 0, $y0 = 0
;~ 	_ArrayDisplay($coordscasa, "$coordscasa")
	For $i = 0 To UBound($coordscasa) - 2 Step 2
		$x0 = $coordscasa[$i]
;~ 		If $redimensionar Then
;~ 			$y1 = $coordscasa[$i + 1] + 18 + ($ordem * $dif2display) ; 18 é a medida da barra do replay ou leilão
;~ 			$y0	= $coordscasa[$i + 1] + ($ordem * $dif2display)
;~ 		Else
			$y0 = $coordscasa[$i + 1] + ($ordem * $dif2display)
;~ 		EndIf
		$hasplaca = PixelSearch($x0, $y0, $x0, $y0, $color, 5, 1)
		If IsArray($hasplaca) Then
;~ 			MouseMove($hasplaca[0], $hasplaca[1], 3)
			_ArrayPush($placas, 1)
;~ 			ConsoleWrite("1" & @CRLF)
		Else
			_ArrayPush($placas, 0)
;~ 			ConsoleWrite("0" & @CRLF)
		EndIf
	Next
	Return $placas

EndFunc   ;==>_GetCotationCasa
;---------------------------------------------------------------------------------
