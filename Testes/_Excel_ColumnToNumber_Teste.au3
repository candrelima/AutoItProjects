#include <Excel.au3>
#include <MsgBoxConstants.au3>

; Translate an Excel column letter to the column number

Local $iColY = "eg" ; Y
Local $iColEJ = 140 ; EJ
;~ Local $sLetter = _Excel_ColumnToLetter($iColY)
Local $iNumber = _Excel_ColumnToNumber($iColY)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToNumber Example 1", "Error converting letter to number." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_ColumnToNumber Example 1", "Letter: " & $iColY & " = Number: " & $iNumber)
