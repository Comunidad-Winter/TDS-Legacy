Attribute VB_Name = "Logging"
Option Explicit

Private Declare Function ReportEvent _
                          Lib "advapi32.dll" Alias "ReportEventA" ( _
                              ByVal hEventLog As Long, _
                              ByVal wType As Integer, _
                              ByVal wCategory As Integer, _
                              ByVal dwEventID As Long, _
                              ByVal lpUserSid As Long, _
                              ByVal wNumStrings As Integer, _
                              ByVal dwDataSize As Long, _
                              plpStrings As String, _
                              lpRawData As Long) As Long

Private Enum type_log
    e_LogearEventoDeSubasta = 0
    e_LogBan = 1
    e_LogCreditosPatreon = 2
    e_LogShopTransactions = 3
    e_LogShopErrors = 4
    e_LogEdicionPaquete = 5
    e_LogMacroServidor = 6
    e_LogMacroCliente = 7
    e_LogVentaCasa = 8
    e_LogCriticEvent = 9
    e_LogEjercitoReal = 10
    e_LogEjercitoCaos = 11
    e_LogError = 12
    e_LogPerformance = 13
    e_LogConsulta = 14
    e_LogClanes = 15
    e_LogGM = 16
    e_LogPremios = 17
    e_LogDatabaseError = 18
    e_LogSecurity = 19
    e_LogDesarrollo = 20
End Enum

Private Declare Function RegisterEventSource Lib "advapi32.dll" Alias "RegisterEventSourceA" ( _
                                             ByVal lpUNCServerName As String, _
                                             ByVal lpSourceName As String) As Long

Public Sub LogThis(nErrNo As Long, sLogMsg As String, EventType As LogEventTypeConstants)
    Dim hEvent As Long
    hEvent = RegisterEventSource("", "TDSLegacy")
    Call ReportEvent(hEvent, EventType, 0, nErrNo, 0, 1, Len(sLogMsg), sLogMsg, 0)
End Sub

Sub LogBan(ByVal BannedIndex As Integer, ByVal UserIndex As Integer, ByVal Motivo As String)
    Dim s As String
    s = UserList(BannedIndex).Name & " BannedBy " & UserList(UserIndex).Name & " Reason " & Motivo
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\ban.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & s
    Close #nFile

    Exit Sub
Errhandler:
End Sub


Public Sub LogShopErrors(Desc As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\ShopError.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub


Public Sub LogEdicionPaquete(texto As String)
    On Error GoTo Errhandler
    Call LogThis(type_log.e_LogEdicionPaquete, "[EdicionPaquete.log] " & texto, vbLogEventTypeWarning)

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\LogEdicionPaquete.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub

Errhandler:
End Sub

Public Sub LogMacroServidor(texto As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\MACRO_Server.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogMacroCliente(texto As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\MACRO_Client.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub
Errhandler:
End Sub
Public Sub logVentaCasa(ByVal texto As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\Ventas_Casas.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub logPromedios(ByVal texto As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\promedios.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogCriticEvent(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\logAntiCheat.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile


    On Error GoTo Errhandler
    Call LogThis(type_log.e_LogCriticEvent, "[Eventos.log] " & Desc, vbLogEventTypeWarning)

    Exit Sub
Errhandler:
End Sub

Public Sub LogEjercitoReal(Desc As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\ejercitoReal.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogEjercitoCaos(Desc As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\ejercitoCaos.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogError(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\errores.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub


Public Sub LogCheques(Desc As String, Optional ByVal Fail As Boolean = False)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\cheques" & IIf(Fail, "_fail", "") & ".log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogCustom(namefile As String, Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\" & namefile & ".log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub


Public Sub LogPerformance(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\performance.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogConsulta(Desc As String)
    On Error GoTo Errhandler
    Call LogThis(type_log.e_LogConsulta, "[obtenemos.log] " & Desc, vbLogEventTypeInformation)
    Exit Sub
Errhandler:
End Sub

Public Sub LogClanes(ByVal Str As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\clanes.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Str
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogProtegidos(ByVal Str As String)

    Dim nFile As Integer
    On Error GoTo Errhandler

    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\intentos-log-protegidos.log" For Append Shared As #nFile
    Print #nFile, Date$ & " " & Time$ & " " & Str
    Close #nFile
Errhandler:
End Sub

Public Sub LogReset(ByVal Str As String)

    Dim nFile As Integer
    On Error GoTo Errhandler

    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\reseteos.log" For Append Shared As #nFile
    Print #nFile, Date$ & " " & Time$ & " " & Str
    Close #nFile
Errhandler:
End Sub

Public Sub LogGM(Name As String, Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\gm/" & Name & ".log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogDesarrolloRetos(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\DesarrolloRetos.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub
Public Sub LogGlobal(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\Global.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogDesarrolloNiveles(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\DesarrolloNiveles.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub logDenuncias(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\Denuncias.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogChat(ByVal Desc As String)
    Call LogInPython("D", Desc)
End Sub

Public Sub LogDesarrollo(ByVal Desc As String)

    On Error GoTo Errhandler

    Call LogInPython("A", Desc)
    Exit Sub
    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\desarrollo.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogPremios(GM As String, UserName As String, ByVal ObjIndex As Integer, ByVal cantidad As Integer, Motivo As String)
    On Error GoTo Errhandler
    Dim s As String
    s = "Item: " & ObjData(ObjIndex).Name & " (" & ObjIndex & ") Cantidad: " & cantidad & vbNewLine _
      & "Motivo: " & Motivo & vbNewLine & vbNewLine



    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\premios.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & s & "-"; GM & "-" & UserName
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogDatabaseError(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\DB_ERROR.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogSecurity(Str As String)
    On Error GoTo Errhandler
    Call LogThis(type_log.e_LogSecurity, "[Cheating.log] " & Str, vbLogEventTypeWarning)

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\LogSecurity.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Str
    Close #nFile

    Exit Sub
Errhandler:
End Sub

Public Sub LogUserAction(nick As String, Str As String)
    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open LogUserPath & nick & ".log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Str
    Close #nFile

    Exit Sub
Errhandler:
End Sub



Public Sub TraceError(ByVal Numero As Long, ByVal Descripcion As String, ByVal Componente As String, Optional ByVal Linea As Integer)
    Debug.Print "TraceError", Numero, "Linea:" & Linea, Descripcion, Componente

    On Error GoTo Errhandler

    Dim nFile As Integer

    nFile = FreeFile    ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\errores_TRACE.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Numero & " - " & Descripcion & " - " & Componente
    Close #nFile

    Exit Sub
Errhandler:

End Sub


