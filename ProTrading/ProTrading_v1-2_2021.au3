#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_Outfile_x64=ProTrading_v1-2_2021.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ListBoxConstants.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Functions.au3>
#include <ColorConstants.au3>

#Region ### START Koda GUI section ### Form=d:\projetos_autoit\winpromoney1.0\protrading\form1_protrading.kxf
$Form1 = GUICreate("ProTrading", 299, 445, 55, 189, $WS_OVERLAPPEDWINDOW, $WS_EX_APPWINDOW)
$MenuItem1 = GUICtrlCreateMenu("&Arquivo")
$MenuItem2 = GUICtrlCreateMenu("&Ferramentas")
$MenuItem3 = GUICtrlCreateMenu("&Configuração")
$MenuItem4 = GUICtrlCreateMenu("A&juda")
GUISetBkColor(0x008080)
GUICtrlSetDefColor(0xFFFFFF)
$Group_Funcoes = GUICtrlCreateGroup("Funções", 8, 312, 281, 81)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Button_Coletar = GUICtrlCreateButton("Coletar", 104, 328, 89, 33)
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUICtrlSetTip(-1, "Iniciar processo de coleta")
$Button_Ler = GUICtrlCreateButton("Ler", 16, 328, 81, 33)
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUICtrlSetTip(-1, "Ler arquivo para montar gráfico")
$Button_Salvar = GUICtrlCreateButton("Salvar", 200, 328, 81, 33)
GUICtrlSetBkColor(-1, 0xA6CAF0)
GUICtrlSetTip(-1, "Salvar dados da lista")
$Progress = GUICtrlCreateProgress(16, 368, 265, 17)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group_Visualizar = GUICtrlCreateGroup("Visualizar dados", 8, 8, 281, 297)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
;~ $List_Valores = GUICtrlCreateList("", 16, 188, 265, 92, $GUI_SS_DEFAULT_LIST, 0)
;~ GUICtrlSetFont(-1, 9, 400, 0, "Century Gothic")
;~ GUICtrlSetBkColor(-1, 0xC8C8C8)
$Label_Specs = GUICtrlCreateLabel("P - R", 16, 28, 61, 17)
$Label_Timeroverall5 = GUICtrlCreateLabel("Time Overall - 5 min:", 16, 48, 130, 17)
$Label_Timerbuy5 = GUICtrlCreateLabel("Buy: --:--", 16, 68, 130, 17)
$Label_Timersell5 = GUICtrlCreateLabel("Sell: --:--", 146, 68, 130, 17)
$Label_Timeroverall15 = GUICtrlCreateLabel("Time Overall - 15 min:", 16, 98, 130, 17)
$Label_Timerbuy15 = GUICtrlCreateLabel("Buy: --:--", 16, 118, 130, 17)
$Label_Timersell15 = GUICtrlCreateLabel("Sell: --:--", 146, 118, 130, 17)
$Label_Timeroverall30 = GUICtrlCreateLabel("Time Overall - 30 min:", 16, 148, 130, 17)
$Label_Timerbuy30 = GUICtrlCreateLabel("Buy: --:--", 16, 168, 130, 17)
$Label_Timersell30 = GUICtrlCreateLabel("Sell: --:--", 146, 168, 130, 17)
$Label_displaytime5 = GUICtrlCreateLabel("Save 5m: --:--", 16, 198, 130, 17)
$Label_displaytime15 = GUICtrlCreateLabel("Save 15m: --:--", 16, 228, 130, 17)
$Label_displaytime30 = GUICtrlCreateLabel("Save 30m: --:--", 16, 258, 130, 17)
$Label_Clock = GUICtrlCreateLabel("Clock: 00:00:00", 16, 283, 135, 17)
GUICtrlSetFont(-1, 14, 400, 0, "Century Gothic")
$Button_Copiar = GUICtrlCreateButton("Copiar", 104, 24, 81, 20)
GUICtrlSetBkColor(-1, 0xB9D1EA)
GUICtrlSetTip(-1, "Copiar dados da lista")
$Button_Colar = GUICtrlCreateButton("Colar", 200, 24, 81, 20)
GUICtrlSetBkColor(-1, 0xB9D1EA)
GUICtrlSetTip(-1, "Colar dados na lista")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group_Direitos = GUICtrlCreateGroup("ProTrading 2021 ® Direitos reservados André Lima", 8, 400, 281, 17, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $answer, $playCot
Global $lista = [[]]
Global $listas_salvas = False
Global $pathsavefile = "wdo21"
Global $dirpath = @ScriptDir & "\Leituras\"
#----------STOP PROGRAM-------------#
HotKeySet("{F2}", "_PararMarket")

While 1
	$nMsg = GUIGetMsg()

	$playCot = False

	Switch $nMsg

		Case $Button_Ler
			$aberto = FileOpenDialog("LER LISTA SALVA", $dirpath, "Text files (*.txt)", $FD_FILEMUSTEXIST)
			Local $hFileOpen = FileOpen($aberto, $FO_READ)
			If $hFileOpen = -1 Then
				MsgBox($MB_SYSTEMMODAL, "", "An error occurred whilst writing the temporary file.")
			EndIf
			Local $fileread = FileRead($hFileOpen)
			MsgBox($MB_SYSTEMMODAL, "$fileread", $fileread)
;~ 			FileDelete($aberto)

;~ 			If UBound($lista_compactada) > 1 Then
;~ 				_ArrayDisplay($lista_compactada, "LISTA COMPACTADA")
;~ 			Else
;~ 				MsgBox(0, "STATUS", "IMPOSSÍVEL LER LISTA VAZIA.", 2)
;~ 			EndIf
;~ 			$pathsavefile = InputBox("LEITURA PREGÃO", "Digite o nome da pasta a ser salvo o pregão")
;~ 			$return = _SalvarParametros($pathsavefile, $lista)
		;------------------------------------------------------------------

		Case $Button_coletar
			$playCot = True
			If $playCot Then
				_IniciarTime($playCot)
			EndIf
		;------------------------------------------------------------------

		Case $Button_Salvar
			; somando todas as razões para cada valor lançado no preço
;~ 			$listas_salvas = _SomarPares($lista)
;~ 			_ArrayDisplay($lista_compactada, "LISTA COMPACTADA")

			; lista com valores iguais já somados, razão + lista de hora, banda min e banda max
;~ 			If $listas_salvas = True Then
;~ 				MsgBox(0, "STATUS", "SALVO COM SUCESSO.", 2)
;~ 			Else
;~ 				MsgBox(0, "STATUS", "FALHA AO SALVAR ARQUIVO.", 2)
;~ 			EndIf
			ExitLoop
		;------------------------------------------------------------------

		Case $GUI_EVENT_CLOSE
			$answer = MsgBox(4148, "INTERROMPER EXECUÇÃO", "DESEJA PARAR EXECUÇÃO DO PROGRAMA?")
			If $answer == 6 Then
				ExitLoop
			EndIf
		;------------------------------------------------------------------

		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
WEnd
