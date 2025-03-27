Attribute VB_Name = "Matematicas"
Option Explicit

Function max(ByVal a As Double, ByVal b As Double) As Double
    On Error GoTo max_Err
100 If a > b Then
102     max = a
    Else
104     max = b
    End If
    Exit Function
max_Err:
106 Call LogError("General.max en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function
Function min(ByVal a As Double, ByVal b As Double) As Double
    On Error GoTo min_Err
100 If a < b Then
102     min = a
    Else
104     min = b
    End If
    Exit Function
min_Err:
106 Call LogError("General.min en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function
