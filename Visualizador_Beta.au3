#include <File.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <7-FunctionsVisualizador.au3>
#include <FontConstants.au3>
#include <GDIPlus.au3>
#include "5-Cores.au3"

#Region ### START Koda GUI section ### Form=d:\autoit\winpromoney1.0\visualizador_beta.kxf
Global $Form1 = GUICreate("Visualizador", 1070, 1800, 2, 10)
Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($Form1)
Global $Picfotos = GUICtrlCreatePic("", 5, 8, 1060, 1660, BitOR($BS_BITMAP,$WS_BORDER)) ; razão de proporção: 1,094657919400187
Global $Listimagens = GUICtrlCreateList("LOCALIZAR TODAS AS FOTOS...", 632, 1673, 257, 122)
Global $Buttondiretorio = GUICtrlCreateButton("DIRETÓRIO", 518, 1672, 100, 33)
Global $Buttonsair = GUICtrlCreateButton("SAIR", 918, 1672, 100, 33)
Global $Buttonanterior = GUICtrlCreateButton("<<<--- ANTERIOR", 110, 1672, 100, 33)
GUICtrlSetState($Buttonanterior, $GUI_HIDE)
Global $Buttonprimeiro = GUICtrlCreateButton("<<<---PRIMEIRO", 4, 1672, 100, 33)
GUICtrlSetState($Buttonprimeiro, $GUI_HIDE)
Global $Buttonproximo = GUICtrlCreateButton("PRÓXIMO", 288, 1672, 100, 33)
GUICtrlSetState($Buttonproximo, $GUI_HIDE)
Global $Buttonultimo = GUICtrlCreateButton("ÚLTIMO--->>>", 393, 1672, 120, 33)
GUICtrlSetState($Buttonultimo, $GUI_HIDE)
Global $Sliderfotos = GUICtrlCreateSlider(10, 1710, 430, 33, -1, -1)
GUICtrlSetState($Sliderfotos, $GUI_HIDE)
Global $Labeltotaldeimagens = GUICtrlCreateLabel("TOTAL DE IMAGENS:", 456, 1710, 112, 17)
Global $Labelqtdimagens = GUICtrlCreateLabel("0", 457, 1725, 160, 20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, 0xA0A0A4)
Global $Progress = GUICtrlCreateProgress(16, 1760, 500, 25)
Global $Groupprogresso = GUICtrlCreateGroup("INFO PROGRESSO - LEITURA", 8, 1745, 609, 49)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Labelprogresso = GUICtrlCreateLabel("0/0", 522, 1760, 90, 25, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, 0xA0A0A4)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $img, $diretorio, $diretorio2, $pasta, $path, $progresso
Global $fileList
Global $maxItens, $files, $loop = 0, $foto, $localDir = 0, $value
$diretorio = @ScriptDir & "\Fotos"

;~ ConsoleWrite($Picfotos & @CRLF)

HotKeySet("{RIGHT}", "_PosImagem")
HotKeySet("{LEFT}", "_PreImagem")

While 1

	$nMsg = GUIGetMsg()

	Switch $nMsg

		Case $Sliderfotos
			_Slider()

		Case $Buttondiretorio
			$localDir = _Abrirdir()
			If $localDir = 1 Then
				GUICtrlSetLimit($Sliderfotos, $maxItens, 1)
				GUICtrlSetState($Buttonprimeiro, $GUI_SHOW)
				GUICtrlSetState($Buttonanterior, $GUI_SHOW)
				GUICtrlSetState($Buttonproximo, $GUI_SHOW)
				GUICtrlSetState($Buttonultimo, $GUI_SHOW)
				GUICtrlSetState($Sliderfotos, $GUI_SHOW)
			Else
				MsgBox(0, "ERROR", "ERRO AO ABRIR DIRETÓRIO", 2)
			EndIf

		Case $Buttonprimeiro
			_First()

		Case $Buttonultimo
			_Last()

		Case $Buttonanterior
			_PreImagem()

		Case $Buttonproximo
			_PosImagem()

		Case $Buttonsair
			ExitLoop

		Case $GUI_EVENT_CLOSE
			Local $resp
			$resp = MsgBox(36, "VISUALIZADOR DE IMAGENS", "DESEJA FECHAR O VISUALIZADOR?")
			If $resp == 6 Then
				Exit
			EndIf

	EndSwitch

WEnd