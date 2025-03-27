Attribute VB_Name = "modPalabras"
Option Explicit
Private Prohibidas(1 To 10) As String
Public Sub InitProhibidas()
   '' Prohibidas(1) = "DSAO"
   '' Prohibidas(2) = "DESTERIUM"
   '' Prohibidas(3) = "STRIKEN"
   '' Prohibidas(4) = "SAO"
   '' Prohibidas(5) = "WEGNING"
   '' Prohibidas(6) = "WAO"
   '' Prohibidas(7) = "TDN"
   '' Prohibidas(8) = "TIERRAS DEL"
   '' Prohibidas(9) = "LOGIA DS"
   '' Prohibidas(10) = "GO DS"
End Sub

Public Function PalabraProhibida(ByVal msg As String) As Boolean
    ''Dim x As Long, p As Long
    ''For x = 1 To 10
    ''    p = InStr(UCase$(Prohibidas(x)), UCase$(msg))
    ''    If p > 0 Then
            ''PalabraProhibida = True
            ''Exit Function
    ''    End If
    ''Next x
End Function
