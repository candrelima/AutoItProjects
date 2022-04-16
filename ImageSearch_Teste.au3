#include <ImageSearch.au3>
Local $x, $y
While 1

	Sleep(100)
	If _ImageSearchArea("Numeros\Azul\teste.bmp", 1, 228, 172, 700, 231, $x, $y, 0, 0) Then
		ConsoleWrite("ImageFound:" & $x & "x" & $y & @CRLF)
		MouseMove($x, $y, 10)
	Else
		ConsoleWrite("Searching" & @CRLF)
	EndIf
WEnd