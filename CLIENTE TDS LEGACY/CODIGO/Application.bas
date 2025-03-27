Attribute VB_Name = "Application"
Option Explicit

Private Const ERROR_ALREADY_EXISTS = 183&
Private Const WAIT_ABANDONED = &H80

Private Declare Function GetActiveWindow Lib "user32" () As Long
Private Declare Function CreateMutex Lib "kernel32" Alias "CreateMutexA" (ByRef lpMutexAttributes As SECURITY_ATTRIBUTES, ByVal bInitialOwner As Long, ByVal lpName As String) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long

Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type

Private MutexID_ As Long

Private Type UltimoError
    Componente As String
    Contador As Byte
    ErrorCode As Long
End Type: Private HistorialError As UltimoError

Public Function IsAppRunning() As Boolean

    Dim Attributes As SECURITY_ATTRIBUTES

    With Attributes
        .bInheritHandle = 0
        .lpSecurityDescriptor = 0
        .nLength = LenB(Attributes)
    End With

    MutexID_ = CreateMutex(Attributes, False, "Global\" & App.ProductName)

    If (Err.LastDllError = ERROR_ALREADY_EXISTS) Then
        IsAppRunning = True

        If (WaitForSingleObject(MutexID_, 100) = WAIT_ABANDONED) Then
            MutexID_ = CreateMutex(Attributes, True, "Global\" & App.ProductName)   ' Takes ownership as the mutex has been abandoned

            IsAppRunning = False
        End If
    Else
        IsAppRunning = False
    End If

End Function

Public Function IsAppDebug() As Boolean

    IsAppDebug = CBool(App.LogMode = 0)

End Function
Public Function IsAppActive() As Boolean
    IsAppActive = (GetActiveWindow <> 0)
End Function

Public Function Angulo(ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Single
    If X2 - X1 = 0 Then
        If Y2 - Y1 = 0 Then
            Angulo = 90
        Else
            Angulo = 270
        End If
    Else
        Angulo = Atn((Y2 - Y1) / (X2 - X1)) * RadianToDegree
        If (X2 - X1) < 0 Or (Y2 - Y1) < 0 Then Angulo = Angulo + 180
        If (X2 - X1) > 0 And (Y2 - Y1) < 0 Then Angulo = Angulo - 180
        If Angulo < 0 Then Angulo = Angulo + 360
    End If
End Function

Public Sub RegistrarError(ByVal Numero As Long, ByVal Descripcion As String, ByVal Componente As String, Optional ByVal Linea As Integer)
    On Error GoTo RegistrarError_Err


    Debug.Print Now, Numero, Descripcion, Componente, Linea

    'Si lo del parametro Componente es ES IGUAL, al Componente del anterior error...
100 If Componente = HistorialError.Componente And _
       Numero = HistorialError.ErrorCode Then

        'Si ya recibimos error en el mismo componente 10 veces, es bastante probable que estemos en un bucle
        'x lo que no hace falta registrar el error.
102     ' If HistorialError.Contador = 10 Then
        '     Debug.Print "Mismo error"
        '     Debug.Assert False
        '     Exit Sub
        ' End If

        'Agregamos el error al historial.
104     HistorialError.Contador = HistorialError.Contador + 1

    Else    'Si NO es igual, reestablecemos el contador.

106     HistorialError.Contador = 0
108     HistorialError.ErrorCode = Numero
110     HistorialError.Componente = Componente

    End If

    'Registramos el error en Errores.log
112 Dim File As Integer: File = FreeFile

114 Open App.Path & "\logs\Errores.log" For Append As #File

116 Print #File, "Error: " & Numero
118 Print #File, "Descripcion: " & Descripcion

120 Print #File, "Componente: " & Componente

122 If LenB(Linea) <> 0 Then
124     Print #File, "Linea: " & Linea
    End If

126 Print #File, "Fecha y Hora: " & Date$ & "-" & time$

128 Print #File, vbNullString

130 Close #File

132 Debug.Print "Error: " & Numero & vbNewLine & _
                "Descripcion: " & Descripcion & vbNewLine & _
                "Componente: " & Componente & vbNewLine & _
                "Linea: " & Linea & vbNewLine & _
                "Fecha y Hora: " & Date$ & "-" & time$ & vbNewLine

    Exit Sub

RegistrarError_Err:
    Call RegistrarError(Err.number, Err.Description, "ES.RegistrarError", Erl)

End Sub

