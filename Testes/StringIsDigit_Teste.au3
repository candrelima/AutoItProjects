#include <MsgBoxConstants.au3>
$digito = 100.00
MsgBox($MB_SYSTEMMODAL, "", "Is the string 42 a digit: " & StringIsDigit("42") & @CRLF & _ ; Returns 1, as the string contains only digit (0-9) characters.
		"Is the string -1000 a digit: " & StringIsDigit("-1000") & @CRLF & _ ; Returns 1, as the string contains only digit (0-9) characters.
		"Is the string 1.0 a digit: " & StringIsDigit("1.0") & @CRLF & _ ; Returns 0, due to the decimal point.
		"Is the number "&$digito&" a digit: " & StringIsDigit(10000) & @CRLF & _ ; Returns 1, due to the number to string conversion.
		"Is the string 1+2 a digit: " & StringIsDigit("1+2") & @CRLF) ; Returns 0, as the + (plus) symbol is present in the string.
