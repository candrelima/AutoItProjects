#include <Date.au3>

While 1

$time = _NowTime(5)

$time2 = StringTrimLeft($time, 4)
$time2 = StringSplit($time2, ":")
If ($time2[1] = 1 Or $time2[1] = 4) And $time2[2] = 59 Then
	ConsoleWrite($time2[1] & @CRLF)
	ConsoleWrite($time2[2] & @CRLF)
	ConsoleWrite("Máximo e mínimo salvos com sucesso." & @CRLF)
	Sleep(1000)
EndIf

;~ ConsoleWrite($time & @CRLF)
;~ ConsoleWrite($time2[0] & @CRLF) ; quantidade de elementos no array $time2
WEnd