
;-------------------------------------------------------------------------
#include <ButtonConstants.au3> ; INCLUDES
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ColorConstants.au3>
#include <ProgressConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
#include <String.au3>
#include <1-Functions_Excel.au3>
#include <5-Cores.au3>
#include <Memory.au3>
;-------------------------------------------------------------------------

#Region ; ELEMENTOS
$Form2_1 = GUICreate("WPM_MAPEAR/CAPTURAR", 310, 633, 184, 125, -1, BitOR($WS_EX_APPWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$Groupcapturando = GUICtrlCreateGroup("CAPTURANDO COORDENADAS", 8, 8, 297, 617, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER,$BS_FLAT), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 10, 400, 0, "Nachlieli CLM")
$Inputpainelx1 = GUICtrlCreateInput("x", 128, 80, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputpainely1 = GUICtrlCreateInput("y", 171, 80, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputconexaox1 = GUICtrlCreateInput("x", 128, 104, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputconexaoy1 = GUICtrlCreateInput("y", 171, 104, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputhorax1 = GUICtrlCreateInput("x", 128, 56, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputhoray1 = GUICtrlCreateInput("y", 171, 56, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Buttontema = GUICtrlCreateButton("TEMA", 176, 24, 59, 25)
$Buttonteste = GUICtrlCreateButton("TESTE", 240, 24, 59, 25)
$Buttonpainel = GUICtrlCreateButton("PAINEL", 16, 80, 107, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0x0000FF)
$Buttonhora = GUICtrlCreateButton("HORA", 16, 56, 107, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xC0C0C0)
$Buttonconexao = GUICtrlCreateButton("CONEXAO", 16, 104, 107, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0x00FF00)
$Buttoniniciarcaptura = GUICtrlCreateButton("INICIAR CAPTURA", 16, 136, 150, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xFFFF00)
$Buttonsair = GUICtrlCreateButton("SAIR", 227, 559, 72, 25, $BS_CENTER)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0x008080)
$Labelrelogio = GUICtrlCreateLabel("--:--:--", 200, 384, 98, 28, $SS_CENTER)
GUICtrlSetFont(-1, 15, 800, 0, "Nachlieli CLM")
$Groupautorais = GUICtrlCreateGroup("WPM_MAPEAR@Andre Lima", 16, 600, 281, 17, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Buttonsalvarmapa = GUICtrlCreateButton("SALVAR MAPA", 168, 136, 126, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Listhorariosalvo = GUICtrlCreateList("", 16, 408, 207, 180)
GUICtrlSetFont(-1, 13, 800, 0, "Nachlieli CLM")
GUICtrlSetData(-1, "")
$Labellistahorario = GUICtrlCreateLabel("LISTA DE HORÁRIO:", 16, 384, 183, 26, $SS_CENTER)
GUICtrlSetFont(-1, 15, 400, 0, "Nachlieli CLM")
$Buttonabrirmapa = GUICtrlCreateButton("ABRIR MAPA", 227, 409, 72, 25)
$Inputhoray2 = GUICtrlCreateInput("y", 256, 56, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputhorax2 = GUICtrlCreateInput("x", 213, 56, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputpainelx2 = GUICtrlCreateInput("x", 213, 80, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputpainely2 = GUICtrlCreateInput("y", 256, 80, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputconexaox2 = GUICtrlCreateInput("x", 213, 104, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Inputconexaoy2 = GUICtrlCreateInput("y", 256, 104, 35, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
$Tabcoords = GUICtrlCreateTab(16, 168, 281, 201, $WS_BORDER)
$HOURD = GUICtrlCreateTabItem("HOURD")
$Labelplaca1hd = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Buttonhorad = GUICtrlCreateButton("HORA D", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca2hd = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3hd = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4hd = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5hd = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6hd = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7hd = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$HOURU = GUICtrlCreateTabItem("HOURU")
$Buttonhorau = GUICtrlCreateButton("HORA U", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca1hu = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2hu = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3hu = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4hu = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5hu = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7hu = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6hu = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$MIND = GUICtrlCreateTabItem("MIND")
$Buttonminutod = GUICtrlCreateButton("MINU D", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca1md = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2md = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3md = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4md = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5md = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6md = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7md = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$MINU = GUICtrlCreateTabItem("MINU")
$Buttonminutou = GUICtrlCreateButton("MINU U", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca1mu = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2mu = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3mu = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4mu = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5mu = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6mu = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7mu = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$SECD = GUICtrlCreateTabItem("SECD")
$Buttonsegundod = GUICtrlCreateButton("SEGS D", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca1sd = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2sd = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3sd = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4sd = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5sd = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6sd = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7sd = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$SECU = GUICtrlCreateTabItem("SECU")
GUICtrlSetState(-1,$GUI_SHOW)
$Buttonsegundou = GUICtrlCreateButton("SEGS U", 20, 193, 78, 25, BitOR($BS_PUSHBOX,$WS_BORDER))
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetBkColor(-1, 0xE0A521)
$Labelplaca1su = GUICtrlCreateLabel("777x777 ", 132, 201, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2su = GUICtrlCreateLabel("777x777 ", 204, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3su = GUICtrlCreateLabel("777x777 ", 204, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4su = GUICtrlCreateLabel("777x777 ", 132, 345, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5su = GUICtrlCreateLabel("777x777 ", 60, 313, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6su = GUICtrlCreateLabel("777x777 ", 60, 241, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7su = GUICtrlCreateLabel("777x777 ", 132, 273, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
GUICtrlCreateTabItem("")
$Buttoncapturar = GUICtrlCreateButton("CAPTURAR", 227, 435, 72, 25)
GUICtrlSetTip(-1, "Capturar uma única imagem da hora desejada.")
$Buttonlocalizar1min = GUICtrlCreateButton("1MIN", 227, 460, 72, 25)
GUICtrlSetTip(-1, "Localizar tempos chaves não mapeados.")
$Buttonlocalizar5min = GUICtrlCreateButton("5MIN", 227, 485, 72, 25)
GUICtrlSetTip(-1, "Botão indefinido.")
$Buttonindefinido = GUICtrlCreateButton("INDEFINIDO", 227, 510, 72, 25)
$Inputletraexcel = GUICtrlCreateInput("y", 228, 536, 70, 22, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER))
GUICtrlSetTip(-1, "Botão indefinido.")
$Radiopregao = GUICtrlCreateRadio("Radiopregao", 16, 25, 15, 17)
$Radioreplay = GUICtrlCreateRadio("Radio1", 96, 25, 15, 17)
$Labelreplay = GUICtrlCreateLabel("Replay", 112, 24, 49, 22)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
$Labelpregao = GUICtrlCreateLabel("Pregao", 32, 24, 51, 22)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Progressprogresso = GUICtrlCreateProgress(16, 588, 281, 8)
GUICtrlSetColor(-1, 0x008080)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;~ $Pic1 = GUICtrlCreatePic("D:\AutoIt\WinProMoney1.0\MAPA.jpg", 314, 6, 348, 616, BitOR($GUI_SS_DEFAULT_PIC,$WS_BORDER))
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;-------------------------------------------------------------------------
#Region ; VARIÁVEIS
Global $coordshorad[14], $coordshorau[14], $coordsminutod[14], $coordsminutou[14], $coordssegundod[14], $coordssegundou[14] ; COORDS HORA, MINUTO E SEGUNDO
Global  $coordshora[4], $coordspainel[4], $coordsconexao[4] ; QUADRANTE
Global $playCot, $leep = 5, $message = "", $arqopen, $status = False, $ans = 0, $letra
Global $imagemselected, $tipo, $botao, $outromapa, $g_hTimer
Global $brilho = 100, $contraste = 100, $raio = 5, $grandeza = 10
#EndRegion
;-------------------------------------------------------------------------

#--------=================----------#
#----------STOP PROGRAM-------------#
HotKeySet("{F2}", "_PararMarket")
;~ $g_hTimer = _Timer_Init()

;~ GUICtrlSetState($Radioreplay, $GUI_CHECKED)
While 1

	If GUICtrlRead($Inputletraexcel, 0) <> "" Then
		$letra = StringUpper(GUICtrlRead($Inputletraexcel, 0))
	EndIf
;~ 	If GUICtrlRead($Radioreplay) = $GUI_CHECKED Then
;~ 		AdlibRegister("_Timer1", 1000)
;~ 	EndIf
	If GUICtrlRead($Radioreplay) = $GUI_CHECKED Then
		GUICtrlSetData($Labelrelogio, "REPLAY")
	EndIf

	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $Radiopregao
			$tipo = "pregao"

		Case $Radioreplay
			$tipo = "replay"

		Case $Buttonhorad
			GUICtrlSetBkColor($Buttonhorad, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonhorad, 0)
			$coordshorad = _capturarcoordsPlacas($botao)
			If IsNumber($coordshorad[0]) And IsNumber($coordshorad[1]) _
				And IsNumber($coordshorad[2]) And IsNumber($coordshorad[3]) _
				And IsNumber($coordshorad[4]) And IsNumber($coordshorad[5]) _
				And IsNumber($coordshorad[6]) Then
;~ 					_ArrayDisplay($coordshorad, "$coordshorad", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonhorad, $COLOR_LIME)
			EndIf

		Case $Buttonhorau
			GUICtrlSetBkColor($Buttonhorau, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonhorau, 0)
			$coordshorau = _capturarcoordsPlacas($botao)
			If IsNumber($coordshorau[0]) And IsNumber($coordshorau[1]) _
				And IsNumber($coordshorau[2]) And IsNumber($coordshorau[3]) _
				And IsNumber($coordshorau[4]) And IsNumber($coordshorau[5]) _
				And IsNumber($coordshorau[6]) Then
;~ 					_ArrayDisplay($coordshorau, "$coordshorau", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonhorau, $COLOR_LIME)
			EndIf

		Case $Buttonminutod
			GUICtrlSetBkColor($Buttonminutod, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonminutod, 0)
			$coordsminutod = _capturarcoordsPlacas($botao)
			If IsNumber($coordsminutod[0]) And IsNumber($coordsminutod[1]) _
				And IsNumber($coordsminutod[2]) And IsNumber($coordsminutod[3]) _
				And IsNumber($coordsminutod[4]) And IsNumber($coordsminutod[5]) _
				And IsNumber($coordsminutod[6]) Then
;~ 					_ArrayDisplay($coordsminutod, "$coordsminutod", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonminutod, $COLOR_LIME)
			EndIf

		Case $Buttonminutou
			GUICtrlSetBkColor($Buttonminutou, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonminutou, 0)
			$coordsminutou = _capturarcoordsPlacas($botao)
			If IsNumber($coordsminutou[0]) And IsNumber($coordsminutou[1]) _
				And IsNumber($coordsminutou[2]) And IsNumber($coordsminutou[3]) _
				And IsNumber($coordsminutou[4]) And IsNumber($coordsminutou[5]) _
				And IsNumber($coordsminutou[6]) Then
;~ 					_ArrayDisplay($coordsminutou, "$coordsminutou", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonminutou, $COLOR_LIME)
			EndIf

		Case $Buttonsegundod
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonsegundod, 0)
			$coordssegundod = _capturarcoordsPlacas($botao)
			If IsNumber($coordssegundod[0]) And IsNumber($coordssegundod[1]) _
				And IsNumber($coordssegundod[2]) And IsNumber($coordssegundod[3]) _
				And IsNumber($coordssegundod[4]) And IsNumber($coordssegundod[5]) _
				And IsNumber($coordssegundod[6]) Then
;~ 					_ArrayDisplay($coordssegundod, "$coordssegundod", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonsegundod, $COLOR_LIME)
			EndIf

		Case $Buttonsegundou
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonsegundou, 0)
			$coordssegundou = _capturarcoordsPlacas($botao)
			If IsNumber($coordssegundou[0]) And IsNumber($coordssegundou[1]) _
				And IsNumber($coordssegundou[2]) And IsNumber($coordssegundou[3]) _
				And IsNumber($coordssegundou[4]) And IsNumber($coordssegundou[5]) _
				And IsNumber($coordssegundou[6]) Then
;~ 					_ArrayDisplay($coordssegundou, "$coordssegundou", "", $ARRAYDISPLAY_COLALIGNCENTER)
					GUICtrlSetBkColor($Buttonsegundou, $COLOR_LIME)
			EndIf

		Case $Buttonhora
			GUICtrlSetBkColor($Buttonhora, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonhora, 0)
			$coordshora = _capturarcoordsTipo($botao)

		Case $Buttonpainel
			GUICtrlSetBkColor($Buttonpainel, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonpainel, 0)
			$coordspainel = _capturarcoordsTipo($botao)

		Case $Buttonconexao
			GUICtrlSetBkColor($Buttonconexao, $COLOR_YELLOW)
			$botao = GUICtrlRead($Buttonconexao, 0)
			$coordsconexao = _capturarcoordsTipo($botao)

		Case $Buttonsalvarmapa
			$message	= ">>>>>>>>>>>>> Atenção <<<<<<<<<<<<<" & @CR & _
							"Caso os dados não estejam mapeados e já exista" & @CR & _
							"um arquivo mapeado, os dados" & @CR & _
							"já existentes serão reescritos." & @CR & _
							"Portanto, preencha todo o mapeamento antes" & @CR & _
							"de reescrever o arquivo existente." & @CR & _
							"Deseja continuar e salvar o mapa?"

			$ans = MsgBox(4659, "SALVAR MAPA", $message)

			If $ans == 6 Then ; YES
				GUICtrlSetBkColor($Buttonsalvarmapa, $COLOR_YELLOW)
				$status = _SalvarParametrosCaptFotos()
				If $status Then
					$playCot = True
					GUICtrlSetBkColor($Buttonsalvarmapa, $COLOR_MONEYGREEN)
				Else
					$playCot = False
					GUICtrlSetBkColor($Buttonsalvarmapa, $COLOR_RED)
				EndIf
			ElseIf $ans == 2 Or $ans == 7 Then ; NO / CANCEL
				MsgBox(4659, "SALVAR MAPA", "OPERAÇÃO CANCELADA.", 1)
			EndIf

		Case $Buttonabrirmapa
			$message	= ">>>>>>>>>>>>> Atenção <<<<<<<<<<<<<" & @CR & _
							"Caso já exista um mapeamento, os dados" & @CR & _
							"do mapa já existentes serão reabertos." & @CR & _
							"Deseja continuar e abrir o mapa?"

			$ans = MsgBox(4659, "ABRIR MAPA", $message)

			If Not $status Then
				If $ans == 6 Then ; YES
					GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_YELLOW)
					$status = _AbrirParametrosMapeamento()
					If $status Then
						$playCot = True
						GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_MONEYGREEN)
					Else
						$playCot = False
						GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_RED)
					EndIf
				ElseIf $ans == 2 Or $ans == 7 Then ; NO / CANCEL
					MsgBox(4659, "ABRIR MAPA", "OPERAÇÃO CANCELADA.", 1)
				EndIf
			Else
				$outromapa = MsgBox(4659, "ABRIR MAPA", "STATUS MAPEAMENTO: OK" & @CR & _
															"DESEJA ABRIR OUTRO MAPA?")
				If $outromapa == 6 Then
					GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_YELLOW)
					$status = _AbrirParametrosMapeamento()
					If $status Then
						$playCot = True
						GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_MONEYGREEN)
					Else
						$playCot = False
						GUICtrlSetBkColor($Buttonabrirmapa, $COLOR_RED)
					EndIf
				ElseIf $ans == 2 Or $ans == 7 Then ; NO / CANCEL
					MsgBox(4659, "ABRIR MAPA", "MAPEAMANETO ATUAL MANTIDO.", 1)
				EndIf
			EndIf

		Case $Buttonteste
			If $status Then
				_TestePosicaoCoords($playCot)
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($playCot)?", 1)
			EndIf

		Case $Buttoniniciarcaptura
			If $playCot And $tipo = "pregao" Then
				_IniciarCapturaPregao($playCot)
			ElseIf $playCot And $tipo = "replay" Then
				_IniciarCapturaReplayNOVO($playCot, $letra)
			Else
				MsgBox(0, "STATUS", "SISTEMA INDEFINIDO (LER MAPA, PREGÃO OU REPLAY?).", 1)
			EndIf
		Case $Buttonlocalizar1min
			_LocalizarHorarios1min()
		Case $Buttonlocalizar5min
			_LocalizarHorarios5min()
		Case $Buttoncapturar
			If $status Then
				_Captura($playCot)
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO?", 1)
			EndIf

		Case $Buttonsair
;~ 			$ans = MsgBox(4148, "INTERROMPER EXECUÇÃO", "DESEJA PARAR EXECUÇÃO DO PROGRAMA?")
;~ 		If $ans == 6 Then
			ExitLoop
;~ 		EndIf

		Case $GUI_EVENT_CLOSE
;~ 			$ans = MsgBox(4148, "INTERROMPER EXECUÇÃO", "DESEJA PARAR EXECUÇÃO DO PROGRAMA?")
;~ 			If $ans == 6 Then
				ExitLoop
;~ 			EndIf

	EndSwitch

WEnd