#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <GUIListBox.au3>
#include <GuiStatusBar.au3>
#include <ProgressConstants.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <TabConstants.au3>
#include <File.au3>
;~ #include <1-Functions_MAPEAR.au3>
#include <7-FunctionsVisualizador.au3>
#include <5-Cores.au3>
;-------------------------------------------------------------------------
#Region ### START Koda GUI section ### Form=D:\AutoIt\WinProMoney1.0\Kxf\Form2_LER.kxf
$Form1 = GUICreate("WPM_LER", 1210, 682, 281, 125)
GUISetBkColor(0x646464)
Global $coordx1, $coordx2, $coordx3, $coordx4, $coordx5, $coordx6, $coordx7, $coordx8, $ordemcasa
Global $labelx1, $labelx2, $labelx3
$coordx1 = 20
$coordx2 = 40
$coordx3 = 68
$coordx4 = 68
$coordx5 = 40
$coordx6 = 12
$coordx7 = 12
$coordx8 = 40
$labelx1 = 120
$labelx2 = 120
$labelx3 = 120
; -------------------------------------------------------PAINEL CAPTURANDO COORDENADAS
$Groupcapturando = GUICtrlCreateGroup("CAPTURANDO COORDENADAS", 8, 488, 1057, 185, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER, $BS_FLAT), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 10, 400, 0, "Nachlieli CLM")
$Tabcoords = GUICtrlCreateTab(11, 504, 1049, 161, $WS_BORDER)
; -------------------------------------------------------COMPRA
$COORDSCOMPRA = GUICtrlCreateTabItem("COORDS COMPRA")
GUICtrlSetBkColor(-1, 0x0000FF)
; -------------------------------------------------------
$Buttonmilharc = GUICtrlCreateButton("MILHAR C", $coordx1, 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1MC = GUICtrlCreateLabel("777x777", $coordx2, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2MC = GUICtrlCreateLabel("777x777", $coordx3, 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3MC = GUICtrlCreateLabel("777x777", $coordx4 , 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4MC = GUICtrlCreateLabel("777x777", $coordx5, 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5MC = GUICtrlCreateLabel("777x777", $coordx6, 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6MC = GUICtrlCreateLabel("777x777", $coordx7, 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7MC = GUICtrlCreateLabel("777x777", $coordx8, 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------CENTENA
$ordemcasa = 1
$Buttoncentenac = GUICtrlCreateButton("CENTENA C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1CC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3CC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4CC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5CC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6CC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7CC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------DEZENA
$ordemcasa = 2
$Buttondezenac = GUICtrlCreateButton("DEZENA C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1DC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2DC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3DC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4DC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5DC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6DC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7DC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------UNIDADE
$ordemcasa = 3
$Buttonunidadec = GUICtrlCreateButton("UNIDADE C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1UC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2UC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3UC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4UC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5UC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6UC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7UC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------CENTAVO
$ordemcasa = 4
$Buttoncentavoc = GUICtrlCreateButton("CENTAVO C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1CEC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CEC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3CEC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4CEC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5CEC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6CEC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7CEC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------DEZENA QUANTIDADE COMPRA
$ordemcasa = 5
$Buttonqtddezc = GUICtrlCreateButton("DEZ QTD C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1QTDDC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2QTDDC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3QTDDC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4QTDDC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5QTDDC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6QTDDC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7QTDDC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------UNIDADE QUANTIDADE COMPRA
$ordemcasa = 6
$Buttonqtdunidc = GUICtrlCreateButton("UNID QTD C", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1QTDUC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2QTDUC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3QTDUC = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4QTDUC = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5QTDUC = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6QTDUC = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7QTDUC = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------CAMPO COMPRA
$ordemcasa = 7
$Buttoncampoc = GUICtrlCreateButton("CAMPO COMPRA", $coordx1 + ($ordemcasa*$labelx1), 527, 142, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1CORC = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx3)-25, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CORC = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx2)+60, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; ------------------------------------------------------DISTÂNCIA
$Buttondistordem = GUICtrlCreateButton("DISTANCIA ORDEM", $coordx1 + ($ordemcasa*$labelx1), 587, 142, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x0000FF)
$Labelplaca1distordem = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx3)-25, 619, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2distordem = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx2)+60, 619, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------VENDA
$COORDSVENDA = GUICtrlCreateTabItem("COORDS VENDA")
GUICtrlSetBkColor(-1, 0x0000FF)
; -------------------------------------------------------MILHAR
$Buttonmilharv = GUICtrlCreateButton("MILHAR V", $coordx1, 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1MV = GUICtrlCreateLabel("777x777", $coordx2, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2MV = GUICtrlCreateLabel("777x777", $coordx3, 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3MV = GUICtrlCreateLabel("777x777", $coordx4 , 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4MV = GUICtrlCreateLabel("777x777", $coordx5, 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5MV = GUICtrlCreateLabel("777x777", $coordx6, 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6MV = GUICtrlCreateLabel("777x777", $coordx7, 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7MV = GUICtrlCreateLabel("777x777", $coordx8, 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------CENTENA
$ordemcasa = 1
$Buttoncentenav = GUICtrlCreateButton("CENTENA V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1CV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3CV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4CV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5CV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6CV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7CV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
;~ ; -------------------------------------------------------DEZENA
$ordemcasa = 2
$Buttondezenav = GUICtrlCreateButton("DEZENA V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1DV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2DV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3DV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4DV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5DV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6DV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7DV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
;~ ; -------------------------------------------------------UNIDADE
$ordemcasa = 3
$Buttonunidadev = GUICtrlCreateButton("UNIDADE V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1UV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2UV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3UV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4UV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5UV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6UV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7UV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
; -------------------------------------------------------CENTAVO
$ordemcasa = 4
$Buttoncentavov = GUICtrlCreateButton("CENTAVO V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1CEV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CEV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3CEV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4CEV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5CEV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6CEV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7CEV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
;~ ; -------------------------------------------------------QUANTIDADE DEZENA VENDA
$ordemcasa = 5
$Buttonqtddezv = GUICtrlCreateButton("DEZ QTD V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1QTDDV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2QTDDV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3QTDDV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4QTDDV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5QTDDV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6QTDDV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7QTDDV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
;~ ; -------------------------------------------------------QUANTIDADE UNIDADE VENDA
$ordemcasa = 6
$Buttonqtdunidv = GUICtrlCreateButton("UNID QTD V", $coordx1 + ($ordemcasa*$labelx1), 527, 78, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1QTDUV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx1), 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2QTDUV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx2), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca3QTDUV = GUICtrlCreateLabel("777x777", $coordx4 + ($ordemcasa*$labelx2), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca4QTDUV = GUICtrlCreateLabel("777x777", $coordx5 + ($ordemcasa*$labelx1), 639, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca5QTDUV = GUICtrlCreateLabel("777x777", $coordx6 + ($ordemcasa*$labelx3), 623, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca6QTDUV = GUICtrlCreateLabel("777x777", $coordx7 + ($ordemcasa*$labelx3), 575, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca7QTDUV = GUICtrlCreateLabel("777x777", $coordx8 + ($ordemcasa*$labelx1), 599, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
;~ ; -------------------------------------------------------CAMPO VENDA
$ordemcasa = 7
$Buttoncampov = GUICtrlCreateButton("CAMPO VENDA", $coordx1 + ($ordemcasa*$labelx1), 527, 142, 25, $GUI_SS_DEFAULT_BUTTON)
GUICtrlSetFont(-1, 10, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xFF0000)
$Labelplaca1CORV = GUICtrlCreateLabel("777x777", $coordx3 + ($ordemcasa*$labelx3)-25, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelplaca2CORV = GUICtrlCreateLabel("777x777", $coordx2 + ($ordemcasa*$labelx2)+60, 559, 58, 14, $SS_CENTER)
GUICtrlSetFont(-1, 5, 400, 0, "MS Sans Serif")
$Labelpriceask = GUICtrlCreateLabel("PRICE", $coordx3-60 + ($ordemcasa*$labelx3), 585, 90, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 600, 0, "MS Sans Serif")
$Labelask = GUICtrlCreateLabel("ASK", $coordx3-60 + ($ordemcasa*$labelx3), 610, 90, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 600, 0, "MS Sans Serif")
$Labelpricebid = GUICtrlCreateLabel("PRICE", $coordx3+40 + ($ordemcasa*$labelx3), 585, 90, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 600, 0, "MS Sans Serif")
$Labelbid = GUICtrlCreateLabel("BID", $coordx3+40 + ($ordemcasa*$labelx3), 610, 90, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 600, 0, "MS Sans Serif")
$Labeltimer = GUICtrlCreateLabel("TIMER", $coordx3 + ($ordemcasa*$labelx3), 630, 70, 20, $SS_CENTER)
GUICtrlSetFont(-1, 12, 600, 0, "MS Sans Serif")
GUICtrlCreateTabItem("")
GUICtrlCreateGroup("", -99, -99, 1, 1)
; -------------------------------------------------------PAINEL CONTROLES
$Groupcontroles = GUICtrlCreateGroup("CONTROLES", 8, 408, 769, 80, BitOR($GUI_SS_DEFAULT_GROUP, $BS_CENTER, $BS_FLAT), $WS_EX_TRANSPARENT)
GUICtrlSetFont(-1, 10, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
$Buttonprimeiro = GUICtrlCreateButton("<<", 11, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Buttonanterior = GUICtrlCreateButton("<", 59, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Inputlocalizar = GUICtrlCreateInput("Localizar hora", 107, 423, 105, 24, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
GUICtrlSetFont(-1, 10, 400, 2, "MS Sans Serif")
GUICtrlSetTip(-1, "Localizar hora.")
$Buttonlocalizar = GUICtrlCreateButton("@", 219, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Buttonproximo = GUICtrlCreateButton(">", 267, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Buttonultimo = GUICtrlCreateButton(">>", 315, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Progress = GUICtrlCreateProgress(371, 423, 100, 25)
$Labelprogresso = GUICtrlCreateLabel("0/0", 480, 425, 72, 20, $SS_CENTER)
GUICtrlSetBkColor(-1, 0xA0A0A4)
$Checkboxefeito = GUICtrlCreateCheckbox("", 565, 423, 20, 20, $BS_AUTOCHECKBOX)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
$Labelefeito = GUICtrlCreateLabel("EFEITO(BCRG)", 580, 425, 100, 20, $SS_CENTER)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Buttoncima = GUICtrlCreateButton("/\", 728, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetTip(-1, "Mover para cima.")
$Buttonbaixo = GUICtrlCreateButton("\/", 680, 423, 44, 25)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
GUICtrlSetTip(-1, "Mover para baixo.")
$Sliderfotos = GUICtrlCreateSlider(11, 449, 206, 33, $TBS_NOTICKS)
GUICtrlSetData($Sliderfotos, 1)
$Labeltotaldeimagens = GUICtrlCreateLabel("TOTAL DE IMAGENS", 221, 455, 128, 16)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Labelqtdimagens = GUICtrlCreateLabel("0", 347, 453, 145, 20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, 0xA0A0A4)
$Sliderzoom = GUICtrlCreateSlider(524, 449, 126, 33, $TBS_NOTICKS)
$Labelzoom = GUICtrlCreateLabel("ZOOM x", 653, 455, 56, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Labelqtdzoom = GUICtrlCreateLabel("0", 707, 453, 64, 20, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, 0xA0A0A4)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Buttonteste = GUICtrlCreateButton("TESTE", 1072, 618, 124, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x008080)
$Buttonabrirmapa = GUICtrlCreateButton("ABRIR MAPA", 1072, 557, 124, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x008080)
$Buttonsalvarmapa = GUICtrlCreateButton("SALVAR MAPA", 1072, 587, 124, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x008080)
$Buttonsair = GUICtrlCreateButton("SAIR", 1072, 648, 124, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x800000)
$Buttoniniciar = GUICtrlCreateButton("INICIAR", 1072, 526, 124, 25)
GUICtrlSetFont(-1, 12, 800, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x00FF00)
$Buttonhideshowg1 = GUICtrlCreateButton("G1", 1072, 416, 60, 71)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetTip(-1, 'Exibir/esconder grupo "CONTROLES".')
$Buttonhideshowg2 = GUICtrlCreateButton("G2", 1136, 416, 60, 71)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x008080)
GUICtrlSetTip(-1, 'Exibir/esconder grupo "CAPTURANDO COORDENADAS".')
$Buttonpasta = GUICtrlCreateButton("PASTA", 1072, 496, 124, 25)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0xA6CAF0)
$Listimagens = GUICtrlCreateList("", 784, 416, 281, 71)
GUICtrlSetFont(-1, 12, 400, 0, "Nachlieli CLM")
GUICtrlSetLimit(-1, 300)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;-------------------------------------------------------------------------
#Region ### VARIÁVEIS
Global $img, $diretorio, $diretorio2, $pasta, $path, $progressom, $abrirmapa, $distY = 123, $Ordem = 0
Global $fileList
Global $maxItens, $files, $loop = 0, $foto, $localDir, $value, $zoom = 1, $iBgColor = 0x303030, _
		$open, $posY = 0, $hide = True, $hide2 = True, $efeitizar = False, $playRead = False
Global $coordsmilharc[14], $coordscentenac[14], $coordsdezenac[14], $coordsunidadec[14], $coordscentavoc[14], $coordscorc[4], _
		$coordsmilharv[14], $coordscentenav[14], $coordsdezenav[14], $coordsunidadev[14], $coordscentavov[14], $coordscorv[4], _
		$coordsqtddezc[14], $coordsqtdunidc[14], $coordsqtddezv[14], $coordsqtdunidv[14], $coordsdist[4]

Global $ordemcompra = 0, $ordemvenda = 0, $qtdcompra[2], $qtdvenda[2]
Global $hascompra = 0, $hasvenda = 0, $buy = 0, $sell = 0, $time = "-:-:-"
Global $saved1 = 0, $saved2 = 0, $saved3 = 0
Global $mediana_venda = 0, $mediana_compra = 0, _
		$Buy2mediana = 0, $Sell2mediana = 0, $Buy2medianaGeral = 0, $Sell2medianaGeral = 0, $medianaGeral = 0, _
		$somatorioQtdCompra = 0, $somatorioQtdVenda = 0, $somatorioQtdCompraTotal = 0, $somatorioQtdVendaTotal = 0, _
		$medianaGeralMin = 10000, $medianaGeralMax = 0

Global $min = 10000, $max = 0, $open = 0, $close = 0, $ciclo
Global $amountc, $amountv
Global $cotacoes = [False, False], $markInicial, $markFinal, $candle[4], $abertura
Global $g_hTimer, $g_iSecs, $g_iMins, $g_iHour, $g_sTime
#EndRegion
;-------------------------------------------------------------------------

#----------STOP PROGRAM-------------#
HotKeySet("{F2}", "_PararMarket")
#----------MOVE RIGHT---------------#
HotKeySet("{RIGHT}", "_PosImagem")
#----------MOVE LEFT----------------#
HotKeySet("{LEFT}", "_PreImagem")
#--------=================----------#

GUISetBkColor($iBgColor, $Form1) ; set GUI background color
GUICtrlSetLimit($Sliderzoom, 4, 1)
GUICtrlSetData($Sliderzoom, $zoom)
GUICtrlSetData($Labelqtdzoom, $zoom)
GUICtrlSetState($Sliderfotos, $GUI_DISABLE)
GUICtrlSetState($Sliderzoom, $GUI_DISABLE)
GUICtrlSetState($Buttonprimeiro, $GUI_DISABLE)
GUICtrlSetState($Buttonproximo, $GUI_DISABLE)
GUICtrlSetState($Buttonultimo, $GUI_DISABLE)
GUICtrlSetState($Buttonanterior, $GUI_DISABLE)
GUICtrlSetState($Buttoncima, $GUI_DISABLE)
GUICtrlSetState($Buttonbaixo, $GUI_DISABLE)
GUICtrlSetState($Buttonlocalizar, $GUI_DISABLE)
$diretorio = "D:\AutoIt\WinProMoney1.0\Fotos\"
;~ _HideControles1($hide)
;~ _HideControles2($hide2)

AdlibRegister("_Timer", 1000)

While 1
	; FUNÇÃO PARA APLICAR EFEITO DE BRILHO/CONTRASTE E RAIO/GRANDEZA
	If GUICtrlRead($Checkboxefeito) = $GUI_CHECKED Then
		$efeitizar = True
	Else
		$efeitizar = False
	EndIf

	$nMsg = GUIGetMsg()

	Switch $nMsg

		#Region ; OUTROS MAPAS AUTOMATICOS
		Case $Buttonmilharc ;----------------------------------------------------------MILHAR C
			GUICtrlSetBkColor($Buttonmilharc, 0xFFFF00) ; COR AMARELO
			$coordsmilharc = _capturarPlaca("MILHAR C")
			If Not UBound(_ArrayFindAll($coordsmilharc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonmilharc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonmilharc, 0x8B1C62) ; COLOR_RED
			EndIf
;~ 			_ArrayDisplay($coordsmilharc, "$coordsmilharc", "", $ARRAYDISPLAY_COLALIGNCENTER)
		Case $Buttoncentenac ;---------------------------------------------------------CENTENA C
			GUICtrlSetBkColor($Buttoncentenac, 0xFFFF00) ; COR AMARELO
			$coordscentenac = _capturarPlaca("CENTENA C")
			If Not UBound(_ArrayFindAll($coordscentenac, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncentenac, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentenac, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttondezenac ;----------------------------------------------------------DEZENA C
			GUICtrlSetBkColor($Buttondezenac, 0xFFFF00) ; COR AMARELO
			$coordsdezenac = _capturarPlaca("DEZENA C")
			If Not UBound(_ArrayFindAll($coordsdezenac, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondezenac, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondezenac, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonunidadec ;---------------------------------------------------------UNIDADE C
			GUICtrlSetBkColor($Buttonunidadec, 0xFFFF00) ; COR AMARELO
			$coordsunidadec = _capturarPlaca("UNIDADE C")
			If Not UBound(_ArrayFindAll($coordsunidadec, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonunidadec, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonunidadec, 0x8B1C62) ; COLOR_RED
			EndIf

		Case $Buttonqtddezc ;----------------------------------------------------------DEZ QTD C
			GUICtrlSetBkColor($Buttonqtddezc, 0xFFFF00) ; COR AMARELO
			$coordsqtddezc = _capturarPlaca("DEZ QTD C")
			If Not UBound(_ArrayFindAll($coordsqtddezc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtddezc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtddezc, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonmilharv ;----------------------------------------------------------MILHAR V
			GUICtrlSetBkColor($Buttonmilharv, 0xFFFF00) ; COR AMARELO
			$coordsmilharv = _capturarPlaca("MILHAR V")
			If Not UBound(_ArrayFindAll($coordsmilharv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonmilharv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonmilharv, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttoncentenav ;---------------------------------------------------------CENTENA V
		GUICtrlSetBkColor($Buttoncentenav, 0xFFFF00) ; COR AMARELO
		$coordscentenav = _capturarPlaca("CENTENA V")
		If Not UBound(_ArrayFindAll($coordscentenav, "")) >= 1  Then
			GUICtrlSetBkColor($Buttoncentenav, 0x00FFFF) ; COR AQUA
		Else
			GUICtrlSetBkColor($Buttoncentenav, 0x8B1C62) ; COLOR_RED
		EndIf
		Case $Buttondezenav ;----------------------------------------------------------DEZENA V
			GUICtrlSetBkColor($Buttondezenav, 0xFFFF00) ; COR AMARELO
			$coordsdezenav = _capturarPlaca("DEZENA V")
			If Not UBound(_ArrayFindAll($coordsdezenav, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondezenav, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondezenav, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonunidadev ;---------------------------------------------------------UNIDADE V
			GUICtrlSetBkColor($Buttonunidadev, 0xFFFF00) ; COR AMARELO
			$coordsunidadev = _capturarPlaca("UNIDADE V")
			If Not UBound(_ArrayFindAll($coordsunidadev, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonunidadev, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonunidadev, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonqtddezv ;----------------------------------------------------------DEZ QTD V
			GUICtrlSetBkColor($Buttonqtddezv, 0xFFFF00) ; COR AMARELO
			$coordsqtddezv = _capturarPlaca("DEZ QTD V")
			If Not UBound(_ArrayFindAll($coordsqtddezv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttonqtddezv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtddezv, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttoncampoc ;-----------------------------------------------------------CAMPO COMPRA
			GUICtrlSetBkColor($Buttoncampoc, 0xFFFF00) ; COR AMARELO
			$coordscorc = _capturarcoordsCampo("CAMPO COMPRA")
			If Not UBound(_ArrayFindAll($coordscorc, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncampoc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncampoc, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttoncampov ;-----------------------------------------------------------CAMPO VENDA
			GUICtrlSetBkColor($Buttoncampov, 0xFFFF00) ; COR AMARELO
			$coordscorv = _capturarcoordsCampo("CAMPO VENDA")
			If Not UBound(_ArrayFindAll($coordscorv, "")) >= 1  Then
				GUICtrlSetBkColor($Buttoncampov, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncampov, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttondistordem ;--------------------------------------------------------DISTANCIA ORDEM
			GUICtrlSetBkColor($Buttondistordem, 0xFFFF00) ; COR AMARELO
			$coordsdist = _capturarcoordsCampo("DISTANCIA ORDEM")
			If Not UBound(_ArrayFindAll($coordsdist, "")) >= 1  Then
				GUICtrlSetBkColor($Buttondistordem, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttondistordem, 0x8B1C62) ; COLOR_RED
			EndIf
		#EndRegion
		#EndRegion

		#Region ; MAPA NOVO
		Case $Buttonqtdunidc ;-----------------------------------------------------------UNID QTD C
			GUICtrlSetBkColor($Buttonqtdunidc, 0xFFFF00) ; COR AMARELO
			$coordsqtdunidc = _capturarPlaca("UNID QTD C")
			If Not UBound(_ArrayFindAll($coordsqtdunidc, "")) >= 1  Then
				; PREENCHENDO AUTOMATICAMENTE DEZENA QTD C
;~ 				For $i = 0 To UBound($coordsqtdunidc) - 1
;~ 					If Mod($i, 2) = 0 Then
;~ 						$coordsqtddezc[$i] = $coordsqtdunidc[$i] - $distX
;~ 					Else
;~ 						$coordsqtddezc[$i] = $coordsqtdunidc[$i]
;~ 					EndIf
;~ 				Next
;~ 				GUICtrlSetBkColor($Buttonqtddezc, 0x00FFFF) ; COR AQUA
				GUICtrlSetBkColor($Buttonqtdunidc, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtdunidc, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonqtdunidv ;-----------------------------------------------------------UNID QTD V
			GUICtrlSetBkColor($Buttonqtdunidv, 0xFFFF00) ; COR AMARELO
			$coordsqtdunidv = _capturarPlaca("UNID QTD V")
			If Not UBound(_ArrayFindAll($coordsqtdunidv, "")) >= 1  Then
				; PREENCHENDO AUTOMATICAMENTE DEZENA QTD V
;~ 				For $i = 0 To UBound($coordsqtdunidv) - 1
;~ 					If Mod($i, 2) = 0 Then
;~ 						$coordsqtddezv[$i] = $coordsqtdunidv[$i] - $distX
;~ 					Else
;~ 						$coordsqtddezv[$i] = $coordsqtdunidv[$i]
;~ 					EndIf
;~ 				Next
;~ 				GUICtrlSetBkColor($Buttonqtddezv, 0x00FFFF) ; COR AQUA
				GUICtrlSetBkColor($Buttonqtdunidv, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonqtdunidv, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttoncentavoc ;-----------------------------------------------------------CENTAVO C
		GUICtrlSetBkColor($Buttoncentavoc, 0xFFFF00) ; COR AMARELO
		$coordscentavoc = _capturarPlaca("CENTAVO C")
		If Not UBound(_ArrayFindAll($coordscentavoc, "")) >= 1  Then
			; PREENCHENDO AUTOMATICAMENTE
;~ 			For $i = 0 To UBound($coordscentavoc)-1
;~ 				If Mod($i, 2) = 0 Then
;~ 					$coordsunidadec[$i] = $coordscentavoc[$i] - (2*$distX)
;~ 					$coordsdezenac[$i] = $coordscentavoc[$i] - (3*$distX)
;~ 					$coordscentenac[$i] = $coordscentavoc[$i] - (4*$distX)
;~ 					$coordsmilharc[$i] = $coordscentavoc[$i] - (6*$distX)
;~ 				Else
;~ 					$coordsunidadec[$i] = $coordscentavoc[$i]
;~ 					$coordsdezenac[$i] = $coordscentavoc[$i]
;~ 					$coordscentenac[$i] = $coordscentavoc[$i]
;~ 					$coordsmilharc[$i] = $coordscentavoc[$i]
;~ 				EndIf
;~ 			Next
;~ 			GUICtrlSetBkColor($Buttonunidadec, 0x00FFFF) ; COR AQUA
;~ 			GUICtrlSetBkColor($Buttondezenac, 0x00FFFF) ; COR AQUA
;~ 			GUICtrlSetBkColor($Buttoncentenac, 0x00FFFF) ; COR AQUA
;~ 			GUICtrlSetBkColor($Buttonmilharc, 0x00FFFF) ; COR AQUA
			GUICtrlSetBkColor($Buttoncentavoc, 0x00FFFF) ; COR AQUA
		Else
			GUICtrlSetBkColor($Buttoncentavoc, 0x8B1C62) ; COLOR_RED
		EndIf
		Case $Buttoncentavov ;-----------------------------------------------------------CENTAVO V
			GUICtrlSetBkColor($Buttoncentavov, 0xFFFF00) ; COR AMARELO
			$coordscentavov = _capturarPlaca("CENTAVO V")
			If Not UBound(_ArrayFindAll($coordscentavov, "")) >= 1  Then
				; PREENCHENDO AUTOMATICAMENTE
;~ 				For $i = 0 To UBound($coordscentavov) - 1
;~ 					If Mod($i, 2) = 0 Then
;~ 						$coordsunidadev[$i] = $coordscentavov[$i] - (2*$distX)
;~ 						$coordsdezenav[$i] = $coordscentavov[$i] - (3*$distX)
;~ 						$coordscentenav[$i] = $coordscentavov[$i] - (4*$distX)
;~ 						$coordsmilharv[$i] = $coordscentavov[$i] - (6*$distX)
;~ 					Else
;~ 						$coordsunidadev[$i] = $coordscentavov[$i]
;~ 						$coordsdezenav[$i] = $coordscentavov[$i]
;~ 						$coordscentenav[$i] = $coordscentavov[$i]
;~ 						$coordsmilharv[$i] = $coordscentavov[$i]
;~ 					EndIf
;~ 				Next
;~ 				GUICtrlSetBkColor($Buttonunidadev, 0x00FFFF) ; COR AQUA
;~ 				GUICtrlSetBkColor($Buttondezenav, 0x00FFFF) ; COR AQUA
;~ 				GUICtrlSetBkColor($Buttoncentenav, 0x00FFFF) ; COR AQUA
;~ 				GUICtrlSetBkColor($Buttonmilharv, 0x00FFFF) ; COR AQUA
				GUICtrlSetBkColor($Buttoncentavov, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttoncentavov, 0x8B1C62) ; COLOR_RED
			EndIf
		#EndRegion

		#Region ; OUTROS
		Case $Buttonhideshowg1
			If Not $hide Then
				$hide = _HideControles1(True)
			Else
				$hide = _HideControles1(False)
			EndIf

		Case $Buttonhideshowg2
			If Not $hide2 Then
				$hide2 = _HideControles2(True)
			Else
				$hide2 = _HideControles2(False)
			EndIf

		Case $Buttoniniciar
			$g_hTimer = TimerInit()
			Local $timeimg
			; INICIAR PROGRAMA
			If $abrirmapa Then
				; CRIAR ARQUIVO MEDIANA GERAL saved1
;~ 				$DadosOrdens 		= _CreateFile("DadosOrdens")
				; CRIAR ARQUIVO EM GERAL saved2
;~ 				$DadosEstudoGeral 	= _CreateFile("DadosEstudoGeral")
				; CRIAR ARQUIVO MAX, OPEN, CLOSE, MIN saved3
;~ 				$DadosCandle 		= _CreateFile("DadosCandle")

				GUICtrlSetBkColor($Buttoniniciar, 0x00FFFF) ; COR AQUA

				$posY = _ContrasteImg($path, $zoom, 0, $efeitizar)
				$playRead = True
				$ciclo = 0 ; ABERTURA DO PREGÃO - 1º CANDLE
;~ 				$ciclo = 1 ; 5 a 0
;~ 				$ciclo = 2 ; 0 a 5
				$timeimg = StringTrimRight($filelist[$posicaohora], 4)
				$markInicial = "0-00"
				$markFinal = "5-00"
;~ 				$saved1 = FileWrite($DadosOrdens, "<----------------------------------TIME>" & $timeimg & @CRLF)
;~ 				$saved2 = FileWrite($DadosEstudoGeral, "<------------------------TIME>" & $timeimg & @CRLF)
				GUICtrlSetData($Listimagens, ""&@CRLF)
				GUICtrlSetBkColor($Labelmediana, $COR_PLACA)
				GUICtrlSetColor($Labelmediana, $COR_PLACA)
				While $playRead
					$cotacoes = _IniciarBuscarShadowPrice()
					If Not $cotacoes[0] And Not $cotacoes[1] Then
						If $ciclo = 0 Or $ciclo = 1 Or $ciclo = 2 Then
							$Ordem = 0
							$posY = 0
							$posy = _PosImagem()
							$timeimg = StringTrimRight($filelist[$posicaohora], 4)

;~ 							$saved1 = FileWrite($DadosOrdens, "<----------------------------------TIME>" & $timeimg & @CRLF)
;~ 							$saved2 = FileWrite($DadosEstudoGeral, "<------------------------TIME>" & $timeimg & @CRLF)
						EndIf
					EndIf
				WEnd

				FileClose($DadosOrdens)
				FileClose($dadosEstudoGeral)
				FileClose($dadosCandle)
				GUICtrlSetData($Buttoniniciar, "INICIAR")
				GUICtrlSetState($Buttoniniciar, $GUI_ENABLE)
				GUICtrlSetBkColor($Buttoniniciar, 0xCCCDCF) ; CINZA
				MsgBox(0, "STATUS", "ANÁLISE DOS DADOS INTERROMPIDA - " & $fileList[$posicaohora], 2)
				ToolTip("<<...>>", 0, 0, "STATUS: STOPPED", 1, 1)
				ToolTip("")
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($abrirmapa)?", 1)
				GUICtrlSetBkColor($Buttoniniciar, 0x8B1C62) ; COLOR_RED
			EndIf

		Case $Buttonabrirmapa
			$posY = 0
			$abrirmapa = _AbrirParametrosMapa()
			If Not $abrirmapa  Then
				GUICtrlSetBkColor($Buttonabrirmapa, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonabrirmapa, 0x00FFFF) ; COLOR_GREEN
			EndIf

		Case $Buttonsalvarmapa
			Local $salvarmapa = _SalvarParametros()
			If Not $salvarmapa  Then
				GUICtrlSetBkColor($Buttonsalvarmapa, 0x00FFFF) ; COR AQUA
			Else
				GUICtrlSetBkColor($Buttonsalvarmapa, 0x8B1C62) ; COLOR_RED
			EndIf

		Case $Buttonpasta
			$posY = _Abrirdir($zoom, $posY)
			If Not isInt($posY) Then
				MsgBox(0, "ERROR", "ERRO AO ABRIR DIRETÓRIO", 2)
			EndIf

		Case $Sliderfotos
			$posY = _Slider($zoom, $posY)

		Case $Sliderzoom
			$zoom = GUICtrlRead($Sliderzoom, $FO_READ)
			GUICtrlSetData($Labelqtdzoom, $zoom)
			$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)

		Case $Buttonprimeiro
			$posY = _First($zoom, $posY)

		Case $Buttonanterior
			$posY = _PreImagem()

		Case $Buttonproximo
			$posY = _PosImagem()

		Case $Buttonultimo
			$posY = _Last($zoom, $posY)

		Case $Buttoncima
			$posY -= 1
			$posY = _MoverImagemCima($path, $zoom, $posY)

		Case $Buttonbaixo
			$posY += 1
			$posY = _MoverImagemBaixo($path, $zoom, $posY)

		Case $Buttonteste
			Local $arrayCoords = [$coordsmilharc, $coordscentenac, $coordsdezenac, $coordsunidadec, $coordscentavoc, _
									$coordsmilharv, $coordscentenav, $coordsdezenav, $coordsunidadev, $coordscentavov, _
									$coordsqtddezc, $coordsqtdunidc, $coordsqtddezv, $coordsqtdunidv]
			If $abrirmapa Then
				$posy = _ContrasteImg($path, $zoom, 0, $efeitizar)
				$play = True
				While $play
					_TestePosCoords($arrayCoords)
					$posY -= $distY
					$posY = _ContrasteImg($path, $zoom, $posY, $efeitizar)
					If Not _HasBuyCotation($coordscorc, 0x0000FF) And Not _HasSellCotation($coordscorv, 0xFF0000) Then ; COMPRA E VENDA
						$posY = 0
						$posy = _PosImagem()
					EndIf
				WEnd
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($abrirmapa)?", 1)
				GUICtrlSetBkColor($Buttonteste, 0x8B1C62) ; COLOR_RED
			EndIf
		Case $Buttonlocalizar
			Local $horario = GUICtrlRead($Inputlocalizar)
			If $horario <> "Localizar hora" Or $horario <> "" Then
				$posY = _LocalizarHorario($horario, $zoom, $posY, $efeitizar)
			EndIf
		Case $Buttonsair
			Local $resp
;~ 			$resp = MsgBox(36, "VISUALIZADOR DE IMAGENS", "DESEJA FECHAR O VISUALIZADOR?")
;~ 			If $resp == 6 Then
				Exit
;~ 			EndIf

		Case $GUI_EVENT_CLOSE
			Local $resp
;~ 			$resp = MsgBox(36, "VISUALIZADOR DE IMAGENS", "DESEJA FECHAR O VISUALIZADOR?")
;~ 			If $resp == 6 Then
				Exit
;~ 			EndIf
		#EndRegion

	EndSwitch

WEnd