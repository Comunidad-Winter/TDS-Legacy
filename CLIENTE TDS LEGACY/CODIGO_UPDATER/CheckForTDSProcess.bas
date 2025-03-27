Attribute VB_Name = "CheckForTDSProcess"
Option Explicit
 
''# preparation (in a separate module)
Private Declare Function FindWindow Lib "user32.dll" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long
Private Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long

Public Function FindWindowHandle(Caption As String) As Long
  FindWindowHandle = FindWindow(vbNullString, Caption)
End Function
 Sub WriteVar(ByVal File As String, ByVal Main As String, ByVal Var As String, ByVal Value As String)
    '*****************************************************************
    'Writes a var to a text file
    '*****************************************************************
    writeprivateprofilestring Main, Var, Value, File
End Sub
Public Sub BuscarTDSL()

    Dim winHwnd As Long
    
    winHwnd = FindWindowHandle("Juego TDS Legacy")

    If winHwnd = 0 Then Exit Sub ' está cerrado
    
    Do While FindWindow(vbNullString, "Juego TDS Legacy") > 0
        
        If MsgBox("Atención, TDS Legacy (o su carpeta) está abierto!!" & vbCrLf & "Cierra el juego para actualizarlo", vbRetryCancel, "Error") = vbCancel Then
            End
        End If
        
    Loop
    
    
End Sub



