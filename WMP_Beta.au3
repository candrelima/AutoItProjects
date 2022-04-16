#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons8-conta-3d-64.ico
#AutoIt3Wrapper_Outfile_x64=WMP.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ColorConstants.au3>
#include <ProgressConstants.au3>
#include <MsgBoxConstants.au3>
#include <Date.au3>
#include <String.au3>
#include "Functions.au3"
#include "Cores.au3"

#Region ### START Koda GUI section ### Form=D:\AutoIt\WinProMoney1.0\Form2.kxf
Global $Form2				= GUICreate("WinProMoney_v1_2_20", 492, 620, (@DesktopWidth/2 + 40), (@DesktopHeight/2 + 260), _
										$GUI_SS_DEFAULT_GUI, BitOR($WS_EX_TOPMOST, $WS_EX_APPWINDOW))
;~ Global $Form2				= GUICreate("WinProMoney_v1_2_20", 492, 580, (@DesktopWidth/2)+550, (@DesktopHeight/2) - 350, _
;~ 										$GUI_SS_DEFAULT_GUI, BitOR($WS_EX_TOPMOST, $WS_EX_APPWINDOW))
Global $Buttoniniciar		= GUICtrlCreateButton("INICIAR", 377, 392, 105, 33)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Groupcapturando 	= GUICtrlCreateGroup("CAPTURANDO COORDENADAS", 8, 8, 473, 377, BitOR($GUI_SS_DEFAULT_GROUP,$BS_LEFT))
Global $Pic1				= GUICtrlCreatePic("D:\AutoIt\WinProMoney1.0\TRACKING_MAP.jpg", 16, 96, 457, 93)
Global $Inputbuyx			= GUICtrlCreateInput("x", 163, 120, 35, 21)
Global $Inputbuyy			= GUICtrlCreateInput("y", 200, 120, 35, 21)
Global $Inputconexaox		= GUICtrlCreateInput("x", 300, 177, 35, 21)
Global $Inputconexaoy		= GUICtrlCreateInput("y", 337, 177, 35, 21)
Global $InputreplayORpregaox	= GUICtrlCreateInput("x", 40, 165, 35, 21)
Global $InputreplayORpregaoy	= GUICtrlCreateInput("y", 77, 165, 35, 21)
Global $Inputsellx			= GUICtrlCreateInput("x", 254, 120, 35, 21)
Global $Inputselly			= GUICtrlCreateInput("y", 291, 120, 35, 21)
Global $Inputdif2display 	= GUICtrlCreateInput("y", 170, 177, 35, 21)
Global $Inputax				= GUICtrlCreateInput("y", 216, 224, 33, 21)
Global $Inputay				= GUICtrlCreateInput("x", 256, 224, 33, 21)
Global $Inputbx 			= GUICtrlCreateInput("x", 280, 256, 33, 21)
Global $Inputby				= GUICtrlCreateInput("y", 320, 256, 33, 21)
Global $Inputcx				= GUICtrlCreateInput("x", 280, 328, 33, 21)
Global $Inputcy				= GUICtrlCreateInput("y", 320, 328, 33, 21)
Global $Inputdx				= GUICtrlCreateInput("x", 211, 359, 33, 21)
Global $Inputdy				= GUICtrlCreateInput("y", 251, 359, 33, 21)
Global $Inputex				= GUICtrlCreateInput("x", 136, 328, 33, 21)
Global $Inputey				= GUICtrlCreateInput("y", 176, 328, 33, 21)
Global $Inputfx				= GUICtrlCreateInput("x", 136, 256, 33, 21)
Global $Inputfy				= GUICtrlCreateInput("y", 176, 256, 33, 21)
Global $Inputgx				= GUICtrlCreateInput("x", 207, 299, 33, 21)
Global $Inputgy				= GUICtrlCreateInput("y", 247, 299, 33, 21)
Global $Buttontema			= GUICtrlCreateButton("TEMA", 392, 42, 83, 25)
Global $Buttonteste		= GUICtrlCreateButton("TESTE", 392, 68, 83, 25)
Global $Labeldata			= GUICtrlCreateLabel("DATA DA COTAÇÃO:", 16, 26, 108, 17, $SS_SIMPLE)
Global $Datedata			= GUICtrlCreateDate("ESCOLHA A DATA", 130, 23, 167, 20, $DTS_SHORTDATEFORMAT, -1)
Local $datastyle			= "dd-MM-yyy"
GUICtrlSendMsg($Datedata, $DTM_SETFORMATW, 0, $datastyle)
;~ Global $ComboBoxdia = GUICtrlCreateCombo(@MDAY, 125, 24, 47, 25)
;~ GUICtrlSetData(-1, "01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31")
;~ Global $ComboBoxmes = GUICtrlCreateCombo(@MON, 180, 24, 47, 25)
;~ GUICtrlSetData(-1, "02|03|04|05|06|07|08|09|10|11|12")
;~ Global $ComboBoxano = GUICtrlCreateCombo(@YEAR, 235, 24, 47, 25)
;~ GUICtrlSetData(-1, "2019|2018|2017")
Global $Groupmercado 		= GUICtrlCreateGroup("MERCADO", 304, 16, 81, 73)
Global $Radiopregao			= GUICtrlCreateRadio("PREGÃO", 312, 64, 65, 17)
Global $Radioreplay 		= GUICtrlCreateRadio("REPLAY", 312, 40, 65, 17)
;~ GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $ButtonAbrirVisual 	= GUICtrlCreateButton("VISUAL", 392, 16, 83, 25)
Global $Groupativo			= GUICtrlCreateGroup("ATIVO", 16, 48, 281, 41)
Global $Radiodol			= GUICtrlCreateRadio("DOL", 24, 64, 41, 17)
Global $Radioind			= GUICtrlCreateRadio("IND", 91, 64, 41, 17)
Global $Radiowdo			= GUICtrlCreateRadio("WDO", 165, 64, 49, 17)
;~ GUICtrlSetState(-1, $GUI_CHECKED)
Global $Radiowin			= GUICtrlCreateRadio("WIN", 240, 64, 41, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Labelplaca1 		= GUICtrlCreateLabel("a", 240, 203, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca2 		= GUICtrlCreateLabel("b", 304, 232, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca3 		= GUICtrlCreateLabel("c", 304, 300, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca4 		= GUICtrlCreateLabel("d", 232, 336, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca5 		= GUICtrlCreateLabel("e", 152, 300, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca6 		= GUICtrlCreateLabel("f", 152, 232, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Labelplaca7 		= GUICtrlCreateLabel("g", 232, 272, 25, 20, $SS_CENTER)
GUICtrlSetFont(-1, 13, 400, 0, "MS Sans Serif")
Global $Groupvenda			= GUICtrlCreateGroup("COORDENADAS", 360, 248, 113, 129, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
Global $Buttonvenda 		= GUICtrlCreateButton("VENDA", 368, 264, 99, 17)
Global $Buttonmilharv 		= GUICtrlCreateButton("MILHAR", 368, 286, 99, 17)
Global $Buttoncentenav 		= GUICtrlCreateButton("CENTENA", 368, 308, 99, 17)
Global $Buttondezenav 		= GUICtrlCreateButton("DEZENA", 368, 330, 99, 17)
Global $Buttonunidadev		= GUICtrlCreateButton("UNIDADE", 368, 352, 99, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Buttondif2display	= GUICtrlCreateButton("DIST DISPLAY", 129, 204, 99, 17)
Global $ButtonreplayORpregao	= GUICtrlCreateButton("REPLAY/LEILÃO", 30, 190, 99, 17)
Global $Buttonqtdcompra	= GUICtrlCreateButton("QTD COMPRA", 30, 210, 99, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Inputqtdcomprax	= GUICtrlCreateInput("x", 11, 227, 35, 21)
Global $Inputqtdcompray	= GUICtrlCreateInput("y", 47, 227, 35, 21)
Global $Inputqtdcompraxx	= GUICtrlCreateInput("x", 83, 227, 35, 21)
Global $Inputqtdcomprayy	= GUICtrlCreateInput("y", 119, 227, 35, 21)
Global $Buttonqtdvenda	= GUICtrlCreateButton("QTD VENDA", 368, 210, 99, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Inputqtdvendax	= GUICtrlCreateInput("x", 335, 227, 35, 21)
Global $Inputqtdvenday	= GUICtrlCreateInput("y", 371, 227, 35, 21)
Global $Inputqtdvendaxx	= GUICtrlCreateInput("x", 407, 227, 35, 21)
Global $Inputqtdvendayy	= GUICtrlCreateInput("y", 443, 227, 35, 21)
Global $Buttonconexao		= GUICtrlCreateButton("CONEXÃO", 270, 204, 99, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Groupcompra			= GUICtrlCreateGroup("COORDENADAS", 16, 248, 113, 129, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
Global $Buttoncompra		= GUICtrlCreateButton("COMPRA", 24, 264, 99, 17)
Global $Buttonmilharc		= GUICtrlCreateButton("MILHAR", 24, 286, 99, 17)
Global $Buttoncentenac		= GUICtrlCreateButton("CENTENA", 24, 308, 99, 17)
Global $Buttondezenac		= GUICtrlCreateButton("DEZENA", 24, 330, 99, 17)
Global $Buttonunidadec		= GUICtrlCreateButton("UNIDADE", 24, 352, 99, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Groupautorais		= GUICtrlCreateGroup("WinProMoney_Beta©Copyrights - André Lima", 8, 584, 473, 25, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Buttonabrirpar		= GUICtrlCreateButton("ABRIR DADOS", 269, 392, 105, 33)
Global $Buttonsalvarpar		= GUICtrlCreateButton("SALVAR DADOS", 161, 392, 105, 33)
Global $Buttonsalvarparcaptfotos		= GUICtrlCreateButton("SALVAR DADOS C. FOTOS", 7, 392, 150, 33)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonhorad		= GUICtrlCreateButton("HORA D", 24, 434, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonhorau		= GUICtrlCreateButton("HORA U", 24, 454, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonminutod		= GUICtrlCreateButton("MINUTO D", 104, 434, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonminutou		= GUICtrlCreateButton("MINUTO U", 104, 454, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonsegundod		= GUICtrlCreateButton("SEGUNDO D", 184, 434, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $Buttonsegundou		= GUICtrlCreateButton("SEGUNDO U", 184, 454, 73, 17)
GUICtrlSetBkColor(-1, 0xE0A521)
Global $ButtonqtdCompraD	= GUICtrlCreateButton("QTD COMPRA D", 264, 434, 93, 17)
Global $ButtonqtdCompraU	= GUICtrlCreateButton("QTD COMPRA U", 264, 454, 93, 17)
Global $ButtonqtdVendaD		= GUICtrlCreateButton("QTD VENDA D", 364, 434, 93, 17)
Global $ButtonqtdVendaU		= GUICtrlCreateButton("QTD VENDA U", 364, 454, 93, 17)
Global $Groupcotacao		= GUICtrlCreateGroup("COTAÇÃO", 8, 472, 473, 105, BitOR($GUI_SS_DEFAULT_GROUP,$BS_CENTER))
Global $Groupvalores		= GUICtrlCreateGroup("------BID---------------------ASK--------------MEDIANA" & _
												"-------------------MEDIO----------------------HORA-------------", 16, 488, 457, 49)
Global $Labelbid			= GUICtrlCreateLabel("----.-", 34, 504, 59, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
Global $Labelask			= GUICtrlCreateLabel("----.-", 116, 504, 59, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
Global $Labelmediana		= GUICtrlCreateLabel("----.-", 195, 504, 65, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
Global $Labelmedio			= GUICtrlCreateLabel("----.-", 294, 504, 65, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
Global $Labelhora			= GUICtrlCreateLabel("--:--:--", 389, 504, 74, 28)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $Buttonsair = GUICtrlCreateButton("SAIR", 344, 544, 129, 25)
Global $Buttoncalculos = GUICtrlCreateButton("CALCULAR MEDS", 212, 544, 129, 25)
Global $Buttoncapturarfotos = GUICtrlCreateButton("CAPTURAR FOTOS", 99, 544, 110, 25)
Global $Labelclock = GUICtrlCreateLabel("--:--:--", 16, 544, 74, 28, $SS_CENTER)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOWNOACTIVATE)
#EndRegion ### END Koda GUI section ###

Global $coordsBuySell, $coordsPlacas, $arqINI
Global $Inputx1, $Inputx2, $Inputx3, $Inputx4, $Inputx5, _
		$Inputx6, $Inputx7, $Inputx8, $Inputx9
Global $Inputy1, $Inputy2, $Inputy3, $Inputy4, $Inputy5, _
		$Inputy6, $Inputy7, $Inputy8, $Inputy9
Global  $coordsbuy[2],  $coordssell[2], $coordsqtdbuy[4], $coordsqtdsell[4], $coordsconexao[2], $coordsreplayORpregao[2], $coordsdif2display[2], _
		$dif2display, $coordsmilharc[14], $coordscentenac[14], $coordsdezenac[14], $coordsunidadec[14], _
		$coordsmilharv[14], $coordscentenav[14], $coordsdezenav[14], $coordsunidadev[14]
Global $tSystem, $g_sTime, $playCot, $play, $dados, $leep = 5, $salvar = False, $ans = 0, $message = "", $arqopen, $arqsaved, $ativo, $tipo, $status = False, _
		$calculated, $ans = 0, $buy, $sell, $time, $ligado = False, $cor = 1
GLobal $coordshorad, $coordshorau, $coordsminutod, $coordsminutou, $coordssegundod, $coordssegundou

GUICtrlSetData($Buttontema, "TEMA " & $cor & "/20")
GUICtrlSetState($Buttondif2display, $GUI_DISABLE)

;~ $g_hTimer = TimerInit()
AdlibRegister("Timer2", 1000)

While 1

	If $tipo == "" Or $tipo == "PREGÃO" Then
		$tSystem = _Date_Time_EncodeSystemTime(@MON, @MDAY, @YEAR, @HOUR, @MIN, @SEC)
		$tSystem = _Date_Time_SystemTimeToDateTimeStr($tSystem)
		$hr = StringTrimRight(StringTrimLeft($tSystem, 11), 6)
		$mn = StringTrimRight(StringTrimLeft($tSystem, 14), 3)
		$sg = StringTrimRight(StringTrimLeft($tSystem, 17), 0)
		$g_sTime = StringFormat("%02i:%02i:%02i", $hr, $mn, $sg)
	EndIf
	ControlSetText("WinProMoney_v1_2_20", "", "Static15", $g_sTime)

	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $Radiodol
			$ativo = GUICtrlRead($Radiodol, $GUI_READ_EXTENDED)
			MsgBox(0, "ATIVO", "ATIVO ESCOLHIDO: " & $ativo, 1)

		Case $Radioind
			$ativo = GUICtrlRead($Radioind, $GUI_READ_EXTENDED)
			MsgBox(0, "ATIVO", "ATIVO ESCOLHIDO: " & $ativo, 1)

		Case $Radiowdo
			$ativo = GUICtrlRead($Radiowdo, $GUI_READ_EXTENDED)
			MsgBox(0, "ATIVO", "ATIVO ESCOLHIDO: " & $ativo, 1)

		Case $Radiowin
			$ativo = GUICtrlRead($Radiowin, $GUI_READ_EXTENDED)
			MsgBox(0, "ATIVO", "ATIVO ESCOLHIDO: " & $ativo, 1)

		Case $Radioreplay
			$tipo = GUICtrlRead($Radioreplay, $GUI_READ_EXTENDED)
			MsgBox(0, "MERCADO", "MERCADO ESCOLHIDO: " & $tipo, 1)

		Case $Radiopregao
			$tipo = GUICtrlRead($Radiopregao, $GUI_READ_EXTENDED)
			MsgBox(0, "MERCADO", "MERCADO ESCOLHIDO: " & $tipo, 1)

		Case $ButtonAbrirVisual

			Run("D:\AutoIt\WinProMoney1.0\Visual.exe")
;~ 			$tSystem = _Date_Time_EncodeSystemTime(@MON, @MDAY, @YEAR, @HOUR, @MIN, @SEC)
;~ 			$tSystem = _Date_Time_SystemTimeToDateTimeStr($tSystem)
;~ 			$hr = StringTrimRight(StringTrimLeft($tSystem, 11), 6)
;~ 			$mn = StringTrimRight(StringTrimLeft($tSystem, 14), 3)
;~ 			$sg = StringTrimRight(StringTrimLeft($tSystem, 17), 0)
;~ 			$g_sTime = StringFormat("%02i:%02i:%02i", $hr, $mn, $sg)

		Case $Buttontema
			$cor = _Tema($cor)
			GUICtrlSetData($Buttontema, "TEMA " & $cor & "/20")

		; ----- DEFINIR HORA, MINUTO E SEGUNDO
		; ----- DEFINIR HORA
		Case $Buttonhorad
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonhorad, $COLOR_YELLOW)
			$coordshorad = _capturarcoordsPlacas()
			If  IsNumber($coordshorad[0]) and IsNumber($coordshorad[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonhorad, $COLOR_LIME)
			EndIf
		Case $Buttonhorau
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonhorau, $COLOR_YELLOW)
			$coordshorau = _capturarcoordsPlacas()
			If  IsNumber($coordshorau[0]) and IsNumber($coordshorau[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonhorau, $COLOR_LIME)
			EndIf

		; ----- DEFINIR MINUTO
		Case $Buttonminutod
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonminutod, $COLOR_YELLOW)
			$coordsminutod = _capturarcoordsPlacas()
			If  IsNumber($coordsminutod[0]) and IsNumber($coordsminutod[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonminutod, $COLOR_LIME)
			EndIf
		Case $Buttonminutou
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonminutou, $COLOR_YELLOW)
			$coordsminutou = _capturarcoordsPlacas()
			If  IsNumber($coordsminutou[0]) and IsNumber($coordsminutou[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonminutou, $COLOR_LIME)
			EndIf

		; ----- DEFINIR SEGUNDO
		Case $Buttonsegundod
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonsegundod, $COLOR_YELLOW)
			$coordssegundod = _capturarcoordsPlacas()
			If  IsNumber($coordssegundod[0]) and IsNumber($coordssegundod[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonsegundod, $COLOR_LIME)
			EndIf
		Case $Buttonsegundou
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonsegundou, $COLOR_YELLOW)
			$coordssegundou = _capturarcoordsPlacas()
			If  IsNumber($coordssegundou[0]) and IsNumber($coordssegundou[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonsegundou, $COLOR_LIME)
			EndIf
		; -----------------------------------------------------------------

		; ----- 1 - INPUTBUY/2 - INPUTSELL/3 - DIF2DISPLAY/4 - CONEXÃO/5 - LARANJA DO REPLAY OU LEILÃO/6 - QTDCOMPRA/7 - QTDVENDA
		Case $Buttoncompra
			GUICtrlSetBkColor($Buttoncompra, $COLOR_YELLOW)
			$coordsbuy = _capturarcoordsBuySell(1)
			If IsNumber($coordsbuy[0]) And IsNumber($coordsbuy[1]) Then
;~ 				$COMPRACOR = PixelGetColor($coordsbuy[0], $coordsbuy[1])
;~ 				_ArrayDisplay($coordsbuy, "")
				GUICtrlSetBkColor($Buttoncompra, $COLOR_LIME)
				GUICtrlSetState($Buttondif2display, $GUI_ENABLE)
			EndIf

		Case $Buttonvenda
			GUICtrlSetBkColor($Buttonvenda, $COLOR_YELLOW)
			$coordssell = _capturarcoordsBuySell(2)
			If IsNumber($coordssell[0]) And IsNumber($coordssell[1]) Then
;~ 				$VENDACOR = PixelGetColor($coordssell[0], $coordssell[1])
;~ 				_ArrayDisplay($coordssell, "")
				GUICtrlSetBkColor($Buttonvenda, $COLOR_LIME)
			EndIf

		Case $Buttonqtdcompra
			GUICtrlSetBkColor($Buttonqtdcompra, $COLOR_YELLOW)
			$coordsqtdbuy = _capturarcoordsBuySell(6)
			If IsNumber($coordsqtdbuy[0]) And IsNumber($coordsqtdbuy[1]) _
						And IsNumber($coordsqtdbuy[2]) And IsNumber($coordsqtdbuy[3]) Then
;~ 				$COMPRACOR = PixelGetColor($coordsqtdbuy[0], $coordsqtdbuy[1])
;~ 				_ArrayDisplay($coordsqtdbuy, "")
				GUICtrlSetBkColor($Buttonqtdcompra, $COLOR_LIME)
			EndIf

		Case $Buttonqtdvenda
			GUICtrlSetBkColor($Buttonqtdvenda, $COLOR_YELLOW)
			$coordsqtdbuydezena = _capturarcoordsBuySell(7)
			If IsNumber($coordsqtdsell[0]) And IsNumber($coordsqtdsell[1]) _
				And ($coordsqtdsell[2]) And IsNumber($coordsqtdsell[3]) Then
;~ 				$VENDACOR = PixelGetColor($coordsqtdsell[0], $coordsqtdsell[1])
;~ 				_ArrayDisplay($coordsqtdsell, "")
				GUICtrlSetBkColor($Buttonqtdvenda, $COLOR_LIME)
			EndIf

		Case $ButtonqtdCompraD
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($ButtonqtdCompraD, $COLOR_YELLOW)
			$coordsqtdbuydezena = _capturarcoordsPlacas()
			If  IsNumber($coordsqtdbuydezena[0]) and IsNumber($coordsqtdbuydezena[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsqtdbuydezena[0], $coordsqtdbuydezena[1])
;~ 				_ArrayDisplay($coordsqtdbuydezena, "")
				GUICtrlSetBkColor($ButtonqtdCompraD, $COLOR_LIME)
			EndIf

		Case $ButtonqtdCompraU
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($ButtonqtdCompraU, $COLOR_YELLOW)
			$coordsqtdbuyunidade = _capturarcoordsPlacas()
			If  IsNumber($coordsqtdbuyunidade[0]) and IsNumber($coordsqtdbuyunidade[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsqtdbuyunidade[0], $coordsqtdbuyunidade[1])
;~ 				_ArrayDisplay($coordsqtdbuyunidade, "")
				GUICtrlSetBkColor($ButtonqtdCompraU, $COLOR_LIME)
			EndIf

		Case $ButtonqtdVendaD
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($ButtonqtdVendaD, $COLOR_YELLOW)
			$coordsqtdselldezena = _capturarcoordsPlacas()
			If  IsNumber($coordsqtdselldezena[0]) and IsNumber($coordsqtdselldezena[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsqtdselldezena[0], $coordsqtdselldezena[1])
;~ 				_ArrayDisplay($coordsqtdselldezena, "")
				GUICtrlSetBkColor($ButtonqtdVendaD, $COLOR_LIME)
			EndIf

		case $ButtonqtdVendaU
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($ButtonqtdVendaU, $COLOR_YELLOW)
			$coordsqtdsellunidade = _capturarcoordsPlacas()
			If  IsNumber($coordsqtdsellunidade[0]) and IsNumber($coordsqtdsellunidade[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsqtdsellunidade[0], $coordsqtdsellunidade[1])
;~ 				_ArrayDisplay($coordsqtdsellunidade, "")
				GUICtrlSetBkColor($ButtonqtdVendaU, $COLOR_LIME)
			EndIf

		Case $Buttondif2display
			GUICtrlSetBkColor($Buttondif2display, $COLOR_YELLOW)
			$coordsdif2display = _capturarcoordsBuySell(3)
			If IsNumber($coordsdif2display[0]) And IsNumber($coordsdif2display[1]) Then
;~ 				_ArrayDisplay($coordsdif2display, "")
				$dif2display = Int($coordsdif2display[1]) - Int($coordsbuy[1])
				GUICtrlSetData($Inputdif2display, $dif2display)
				GUICtrlSetBkColor($Buttondif2display, $COLOR_LIME)
			EndIf

		Case $ButtonreplayORpregao
			GUICtrlSetBkColor($ButtonreplayORpregao, $COLOR_YELLOW)
			$coordsreplayORpregao = _capturarcoordsBuySell(5)
			If IsNumber($coordsreplayORpregao[0]) and IsNumber($coordsreplayORpregao[1]) Then
;~ 				_ArrayDisplay($coordsdif2display, "")
				GUICtrlSetBkColor($ButtonreplayORpregao, $COLOR_LIME)
			EndIf

		Case $Buttonconexao
			GUICtrlSetBkColor($Buttonconexao, $COLOR_YELLOW)
			$coordsconexao = _capturarcoordsBuySell(4)
			If IsNumber($coordsconexao[0]) and IsNumber($coordsconexao[1]) Then
;~ 				_ArrayDisplay($coordsconexao, "")
				GUICtrlSetBkColor($Buttonconexao, $COLOR_LIME)
			EndIf

		Case $Buttonmilharc
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonmilharc, $COLOR_YELLOW)
			$coordsmilharc = _capturarcoordsPlacas()
			If  IsNumber($coordsmilharc[0]) and IsNumber($coordsmilharc[1]) Then
;~ 				$PLACACOR = PixelGetColor($coordsmilharc[0], $coordsmilharc[1])
;~ 				_ArrayDisplay($coordsmilharc, "")
				GUICtrlSetBkColor($Buttonmilharc, $COLOR_LIME)
			EndIf

		Case $Buttonmilharv
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonmilharv, $COLOR_YELLOW)
			$coordsmilharv = _capturarcoordsPlacas()
			If  IsNumber($coordsmilharv[0]) and IsNumber($coordsmilharv[1]) Then
;~ 				_ArrayDisplay($coordsmilharv, "")
				GUICtrlSetBkColor($Buttonmilharv, $COLOR_LIME)
			EndIf

		Case $Buttoncentenac
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttoncentenac, $COLOR_YELLOW)
			$coordscentenac = _capturarcoordsPlacas()
			If  IsNumber($coordscentenac[0]) and IsNumber($coordscentenac[1]) Then
;~ 				_ArrayDisplay($coordscentenac, "")
				GUICtrlSetBkColor($Buttoncentenac, $COLOR_LIME)
			EndIf

		Case $Buttoncentenav
		GUICtrlSetData($Labelplaca1, "a")
		GUICtrlSetData($Labelplaca2, "b")
		GUICtrlSetData($Labelplaca3, "c")
		GUICtrlSetData($Labelplaca4, "d")
		GUICtrlSetData($Labelplaca5, "e")
		GUICtrlSetData($Labelplaca6, "f")
		GUICtrlSetData($Labelplaca7, "g")
		GUICtrlSetBkColor($Buttoncentenav, $COLOR_YELLOW)
		$coordscentenav = _capturarcoordsPlacas()
		If  IsNumber($coordscentenav[0]) and IsNumber($coordscentenav[1]) Then
;~ 				_ArrayDisplay($coordscentenav, "")
			GUICtrlSetBkColor($Buttoncentenav, $COLOR_LIME)
		EndIf

		Case $Buttondezenac
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttondezenac, $COLOR_YELLOW)
			$coordsdezenac = _capturarcoordsPlacas()
			If  IsNumber($coordsdezenac[0]) and IsNumber($coordsdezenac[1]) Then
;~ 				_ArrayDisplay($coordsdezenac, "")
				GUICtrlSetBkColor($Buttondezenac, $COLOR_LIME)
			EndIf

		Case $Buttondezenav
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttondezenav, $COLOR_YELLOW)
			$coordsdezenav = _capturarcoordsPlacas()
			If  IsNumber($coordsdezenav[0]) and IsNumber($coordsdezenav[1]) Then
;~ 				_ArrayDisplay($coordsdezenav, "")
				GUICtrlSetBkColor($Buttondezenav, $COLOR_LIME)
			EndIf

		Case $Buttonunidadec
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonunidadec, $COLOR_YELLOW)
			$coordsunidadec = _capturarcoordsPlacas()
			If  IsNumber($coordsunidadec[0]) and IsNumber($coordsunidadec[1]) Then
;~ 				_ArrayDisplay($coordsunidade, "")
				GUICtrlSetBkColor($Buttonunidadec, $COLOR_LIME)
			EndIf

		Case $Buttonunidadev
			GUICtrlSetData($Labelplaca1, "a")
			GUICtrlSetData($Labelplaca2, "b")
			GUICtrlSetData($Labelplaca3, "c")
			GUICtrlSetData($Labelplaca4, "d")
			GUICtrlSetData($Labelplaca5, "e")
			GUICtrlSetData($Labelplaca6, "f")
			GUICtrlSetData($Labelplaca7, "g")
			GUICtrlSetBkColor($Buttonunidadev, $COLOR_YELLOW)
			$coordsunidadev = _capturarcoordsPlacas()
			If  IsNumber($coordsunidadev[0]) and IsNumber($coordsunidadev[1]) Then
;~ 				_ArrayDisplay($coordsunidadev, "")
				GUICtrlSetBkColor($Buttonunidadev, $COLOR_LIME)
			EndIf

		Case $Buttoniniciar
			If GUICtrlRead($Radiopregao) == $GUI_CHECKED Then
				$tipo = "PREGÃO"
			ElseIf GUICtrlRead($Radioreplay) == $GUI_CHECKED Then
				$tipo = "REPLAY"
			EndIf
			If $playCot Then
				_IniciarCotacao($playCot, $tipo)
			ElseIf $play Then
				$playCot = False
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($playCot)?")
			EndIf

		Case $Buttonsalvarpar
			$message	= ">>>>>>>>>>>>> Atenção <<<<<<<<<<<<<" & @CR & _
							"Caso os dados não estejam mapeados e já exista" & @CR & _
							"um arquivo mapeado, os dados" & @CR & _
							"já existentes serão apagados." & @CR & _
							"Portanto, preencha todo o mapeamento antes" & @CR & _
							"de reescrever o arquivo existente." & @CR & _
							"Deseja continuar e salvar os dados?"

			$ans = MsgBox(4659, "SALVAR DADOS", $message)

			If $ans == 6 Then
				GUICtrlSetBkColor($Buttonsalvarpar, $COLOR_YELLOW)
				$status = _SalvarParametros($cor, $dif2display)
				If $status Then
					GUICtrlSetBkColor($Buttonsalvarpar, $COLOR_MONEYGREEN)
					$playCot = True
				Else
					GUICtrlSetBkColor($Buttonsalvarpar, $COLOR_RED)
				EndIf
			EndIf

		Case $Buttonsalvarparcaptfotos
			$message	= ">>>>>>>>>>>>> Atenção <<<<<<<<<<<<<" & @CR & _
							"Caso os dados não estejam mapeados e já exista" & @CR & _
							"um arquivo mapeado, os dados" & @CR & _
							"já existentes serão apagados." & @CR & _
							"Portanto, preencha todo o mapeamento antes" & @CR & _
							"de reescrever o arquivo existente." & @CR & _
							"Deseja continuar e salvar os dados?"

			$ans = MsgBox(4659, "SALVAR DADOS", $message)

			If $ans == 6 Then
				GUICtrlSetBkColor($Buttonsalvarparcaptfotos, $COLOR_YELLOW)
				$status = _SalvarParametrosCaptFotos($cor)
				If $status Then
					GUICtrlSetBkColor($Buttonsalvarparcaptfotos, $COLOR_MONEYGREEN)
					$playCot = True
				Else
					GUICtrlSetBkColor($Buttonsalvarparcaptfotos, $COLOR_RED)
				EndIf
			EndIf

		Case $Buttonabrirpar
			$status = False
			If Not $status Then
				GUICtrlSetBkColor($Buttonabrirpar, $COLOR_YELLOW)
				Local $answer = InputBox("TIPO DE DADOS - CAPTURA/AO VIVO", "ESCOLHA: 1 >> PARA AO VIVO/2 >> PARA CAPTURA ", "", "", 300, 120, (@DesktopWidth/2)-75, (@DesktopHeight/2)-60)
				If $answer == 1 Then
					$status = _AbrirParametros()
					If $status Then
						$playCot	= True
;~ 						MsgBox(0, "STATUS", "$playCot: " & $playCot, 2)
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_MONEYGREEN)
						If GUICtrlRead($Radioreplay) == "REPLAY" Then
							$replay = True
						EndIf
	;~ 					MsgBox(0, "STATUS", "INICIAR: " & $playCot)
					Else
	;~ 					MsgBox(0, "STATUS", "INICIAR: " & $playCot)
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_RED)
					EndIf
				ElseIf $answer == 2 Then
					$status = _AbrirParametros2()
					If $status Then
						$playCot	= True
;~ 						MsgBox(0, "STATUS", "$playCot: " & $playCot, 2)
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_MONEYGREEN)
						If GUICtrlRead($Radioreplay) == "REPLAY" Then
							$replay = True
						EndIf
	;~ 					MsgBox(0, "STATUS", "INICIAR: " & $playCot)
					Else
	;~ 					MsgBox(0, "STATUS", "INICIAR: " & $playCot)
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_RED)
					EndIf
				Else
					MsgBox(1, "ERROR", "OPÇÃO INEXISTENTE (1 OU 2)", 2)
				EndIf

			Else
				Local $outromapa = MsgBox(4659, "STATUS", "STATUS MAPEAMENTO: OK" & @CR & _
															"DESEJA ABRIR OUTRO MAPA?")
				If $outromapa == 6 Then
					GUICtrlSetBkColor($Buttonabrirpar, $COLOR_YELLOW)
					$status = _AbrirParametros()
					If $status Then
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_MONEYGREEN)
						$playCot	= True
;~ 						MsgBox(0, "STATUS", "INICIAR: " & $playCot)
					Else
;~ 						MsgBox(0, "STATUS", "INICIAR: " & $playCot)
						GUICtrlSetBkColor($Buttonabrirpar, $COLOR_RED)
					EndIf
				EndIf
			EndIf

		Case $Buttonteste
			If $playCot Then
				_TestePosicao($playCot)
			ElseIf $play Then
				$playCot = False
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($playCot)?")
			EndIf

		Case $Buttoncalculos
			If Not $calculated Then
				GUICtrlSetBkColor($Buttoncalculos, $COLOR_YELLOW)
				$calculated = _CalcularMedioMediana()
				If $calculated Then
					GUICtrlSetBkColor($Buttoncalculos, $COLOR_MONEYGREEN)
				Else
					GUICtrlSetBkColor($Buttoncalculos, $COLOR_RED)
				EndIf
			Else
				Local $outromapa = MsgBox(4659, "STATUS", "STATUS CÁLCULOS: OK" & @CR & _
															"DESEJA ABRIR OUTRO MAPA DE COTAÇÕES?")
				If $outromapa == 6 Then
					GUICtrlSetBkColor($Buttoncalculos, $COLOR_YELLOW)
					$calculated = _CalcularMedioMediana()
					If $calculated Then
						GUICtrlSetBkColor($Buttoncalculos, $COLOR_MONEYGREEN)
					Else
						GUICtrlSetBkColor($Buttoncalculos, $COLOR_RED)
					EndIf
				EndIf
			EndIf

		Case $Buttoncapturarfotos
			If GUICtrlRead($Radiopregao) == $GUI_CHECKED Then
				$tipo = "PREGÃO"
			ElseIf GUICtrlRead($Radioreplay) == $GUI_CHECKED Then
				$tipo = "REPLAY"
			EndIf
			If IsArray($coordsqtdbuy) And IsArray($coordsqtdsell) Then
				$playCot = True
				_IniciarCotacao2($playCot, $tipo)
			Else
				MsgBox(0, "STATUS", "SISTEMA DEFINIDO($coordsqtdbuy e $coordsqtdsell)?")
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