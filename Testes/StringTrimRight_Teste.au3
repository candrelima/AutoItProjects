#include <MsgBoxConstants.au3>
Local $text = "This is a sentence with whitespace."
Local $tam = StringLen($text)
Local $sString = StringTrimRight($text, $tam - 1) ; Remove the 5 rightmost characters from the string.
MsgBox($MB_SYSTEMMODAL, "", $sString)
