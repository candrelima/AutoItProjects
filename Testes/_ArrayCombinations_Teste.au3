; Declare a 1-dimensional array, and create an array showing the Possible Combinations

#include <Array.au3>

Local $aArray[20] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

;~ For $i = 1 To UBound($aArray)
	Local $aArrayCombo = _ArrayCombinations($aArray, 15, ",")
	_ArrayDisplay($aArrayCombo, "iSet = " & 15)
;~ Next
