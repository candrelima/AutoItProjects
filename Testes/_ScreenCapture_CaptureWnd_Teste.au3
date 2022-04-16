#include <ScreenCapture.au3>

Example()

Func Example()
	Local $hGUI

	; Create GUI
	$hGUI = GUICreate("Screen Capture", 229, 817)
	GUISetState(@SW_SHOW)
	Sleep(2500)

	; Capture window
	_ScreenCapture_CaptureWnd(@MyDocumentsDir & "\GDIPlus_Image.jpg", $hGUI)

	ShellExecute(@MyDocumentsDir & "\GDIPlus_Image.jpg")
EndFunc   ;==>Example
