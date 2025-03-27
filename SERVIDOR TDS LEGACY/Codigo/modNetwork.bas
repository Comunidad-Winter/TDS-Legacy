Attribute VB_Name = "modNetwork"
Option Explicit

Private Const MaxActiveConnections As Integer = 1000

Public Type t_ConnectionMapping
    UI As Integer
    IP As String
    ConnIDValida As Boolean
    ConnID As Long
    BadPackets As Long
    OnConnectTimeStamp As Long
End Type

Private PendingConnections As New Dictionary

Public Mapping() As t_ConnectionMapping

Public Server As Network.Server

Public Sub listen(ByVal Address As String, ByVal service As String)

    Set Server = New Network.Server
    Call Server.Attach(AddressOf OnServerConnect, AddressOf OnServerClose, AddressOf OnServerSend, AddressOf OnServerRecv, AddressOf OnServerError)

    Call Server.listen(maxUsers, Address, service)
    ReDim Mapping(MaxActiveConnections) As t_ConnectionMapping

End Sub

Private Sub OnServerError(ByVal code As Long, ByVal Description As String)
    On Error GoTo Errhandler
    Debug.Print "OnServerError", code, Description
    Exit Sub
Errhandler:
    Call LogError("Error en modNetwork.OnServerError " & code & " - " & Description)
End Sub

Public Sub Flush(ByVal UserIndex As Long)
    On Error GoTo Errhandler
    Call Server.Flush(UserList(UserIndex).ConnID)
    Exit Sub
Errhandler:
    Call LogError("Error en modNetwork.Flush")
End Sub

Public Sub Disconnect()
    On Error GoTo Errhandler
    Call Server.Close
    Exit Sub
Errhandler:
    Call LogError("Error en modNetwork.Close")
End Sub

Public Sub send(ByVal UserIndex As Long, Optional ByVal Urgent As Boolean = False)
    On Error GoTo Errhandler
    Server.send UserIndex, Urgent, Protocol_Writes.Writer
    Exit Sub
Errhandler:
    Call LogError("Error en modNetwork.send")
End Sub

Public Sub SendToUser(ByVal UserIndex As Long)
    On Error GoTo Errhandler
    If UserList(UserIndex).ConnIDValida Then
        Server.send UserIndex, False, Protocol_Writes.Writer
    End If
    Protocol_Writes.Writer.Clear
    Exit Sub
Errhandler:
    Call LogError("Error en modNetwork.SendToUser")
End Sub

Public Sub SendToConnection(ByVal ConnectionID As Long, ByRef Buffer As Network.Writer)
    Call Server.send(ConnectionID, False, Buffer)
End Sub

Public Sub Kick(ByVal Connection As Long, Optional ByVal Message As String = vbNullString)

    On Error GoTo Errhandler

    If (Message <> vbNullString) Then
        Dim UserIndex As Long
        UserIndex = Mapping(Connection).UI

        If UserIndex > 0 Then
            Call WriteErrorMsg(UserIndex, Message)
            Debug.Print Now, UserList(UserIndex).Name, "ERROR!!"

            If UserList(UserIndex).flags.UserLogged Then
                Call Cerrar_Usuario(UserIndex)
            End If
        End If
    End If

    Call Server.Flush(Connection)
    Call Server.Kick(Connection, True)

    Exit Sub

Errhandler:

    Call LogError("Error en modNetwork.Kick")

End Sub

Public Sub OnServerConnect(ByVal Connection As Long, ByVal Address As String)

    On Error GoTo Errhandler
    
1   If Connection <= MaxActiveConnections Then
2       If PendingConnections.Exists(Connection) Then
3           Call LogError("opening a new connection id " & Connection & " with ip: " & Address & " but there already a pending connection with this id and ip: " & Mapping(Connection).IP)
4           Call PendingConnections.Remove(Connection)
        End If

5       Mapping(Connection).ConnIDValida = True
6       Mapping(Connection).IP = Address
7       Mapping(Connection).ConnID = Connection
8       Mapping(Connection).OnConnectTimeStamp = GetTickCount()

9       Call PendingConnections.Add(Connection, Connection)

        Debug.Print Now, "OnServerConnect", "Connection: " & Connection, "UI: " & Mapping(Connection).UI

10      Call modSendData.SendToConnection(Connection, PrepareConnected(Connection))
    Else
11      Call Kick(Connection, "El server se encuentra lleno en este momento. Disculpe las molestias ocasionadas.")
    End If

    Exit Sub

Errhandler:

    Call LogError("Error" & Err.Number & "(" & Err.Description & ") en Sub OnServerConnect de modNetwork.bas linea " & Erl)

End Sub

Public Sub OnServerClose(ByVal Connection As Long)

    On Error GoTo Errhandler

    Dim UserIndex As Long
    UserIndex = Mapping(Connection).UI

    If UserIndex > 0 Then
        If UserList(UserIndex).flags.UserLogged Then
            Debug.Print Now, "OnServerClose:", "LOGGED", UserIndex & " Nick:" & UserList(UserIndex).Name
            Call CloseSocketSL(UserIndex)
            Call Cerrar_Usuario(UserIndex)
        Else
            Debug.Print Now, "OnServerClose:", "NOT LOGGED", UserIndex
            Call CloseSocket(UserIndex)
        End If

        UserList(UserIndex).ConnIDValida = False
        UserList(UserIndex).ConnID = -1
        
        Mapping(Connection).UI = 0
        Mapping(Connection).BadPackets = 0
        Mapping(Connection).OnConnectTimeStamp = 0
        
    ElseIf PendingConnections.Exists(Connection) Then
        Debug.Print Now, "OnServerClose:", "NOT EXISTS", "Connection: " & Connection
        Call PendingConnections.Remove(Connection)
    End If

   ' Call ClearConnection(Connection)

    Exit Sub

Errhandler:
    Call LogError("Error" & Err.Number & "(" & Err.Description & ") en Sub OnClose de modNetwork.bas")
End Sub

Public Sub OnServerSend(ByVal Connection As Long, ByVal Message As Network.Reader)
    On Error GoTo Errhandler
    Exit Sub

Errhandler:
    Call LogError("Error" & Err.Number & "(" & Err.Description & ") en Sub OnServerSend de modNetwork.bas")
End Sub

Public Sub OnServerRecv(ByVal Connection As Long, ByVal Message As Network.Reader)

    On Error GoTo Errhandler

    Set Reader = Message

    Do
        Call HandleIncomingData(Mapping(Connection).UI, Mapping(Connection).ConnID)

        If Message.GetAvailable() < 1 Then
            Mapping(Connection).BadPackets = 0
            Exit Do
        Else
            Mapping(Connection).BadPackets = Mapping(Connection).BadPackets + 1

            If Mapping(Connection).BadPackets > 150 Then
                Mapping(Connection).BadPackets = 0
                Call LogError("La (IP: " & Mapping(Connection).IP & " ha sido expulsado por saturacion del protocolo.")

                If Mapping(Connection).UI > 0 Then
                    Call CloseSocket(Mapping(Connection).UI)
                Else
                    Call KickConnection(Connection)
                End If

                Exit Do
            End If
        End If
    Loop

    Set Reader = Nothing
    Exit Sub

Errhandler:
    Call LogError("Error" & Err.Number & "(" & Err.Description & ") en Sub OnServerRecv de modNetwork.bas")
End Sub

Public Sub KickConnection(ByVal Connection As Long)

    On Error GoTo Errhandler:

1   Call Server.Flush(Connection)
2   Call Server.Kick(Connection, True)

3   Call ClearConnection(Connection)

4   If PendingConnections.Exists(Connection) Then
5       Call PendingConnections.Remove(Connection)
6   End If

    Exit Sub

Errhandler:

    Call LogError("Error en modNetwork.KickConnection en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Private Function GetStringIp(ByVal IPAddress As Double) As String

    On Error GoTo Errhandler

    Dim X As Long
    Dim num As Integer

    If IPAddress < 0 Then IPAddress = IPAddress + 4294967296#

    For X = 1 To 4
        num = Int(IPAddress / 256 ^ (4 - X))
        IPAddress = IPAddress - (num * 256 ^ (4 - X))
        If num > 255 Then
            GetStringIp = "0.0.0.0"
            Exit Function
        End If

        If X = 1 Then
            GetStringIp = num
        Else
            GetStringIp = GetStringIp & "." & num
        End If
    Next X

    Exit Function

Errhandler:

    Call LogError("Error en modNetwork.GetStringIp en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Function

Public Function MapConnectionToUser(ByVal ConnectionID As Long) As Integer

    On Error GoTo Errhandler

1   If Not PendingConnections.Exists(ConnectionID) Then
2       'Call LogError("Connection " & ConnectionID & " is not waiting for assign")
        Exit Function
    Else
10      Call PendingConnections.Remove(ConnectionID)
    End If

    Dim FreeUser As Long
3   FreeUser = NextOpenUser()

4   If FreeUser <= 0 Then
5       Call Kick(ConnectionID, "El server se encuentra lleno en este momento. Disculpe las molestias ocasionadas.")
        Exit Function
    End If

11  UserList(FreeUser).ConnIDValida = Mapping(ConnectionID).ConnIDValida
12  UserList(FreeUser).ConnID = Mapping(ConnectionID).ConnID
13  UserList(FreeUser).IP = Mapping(ConnectionID).IP

14  MapConnectionToUser = FreeUser
15  Mapping(ConnectionID).UI = FreeUser

16  If FreeUser > LastUser Then
17      LastUser = FreeUser
    End If

    Exit Function

Errhandler:

    Call LogError("Error en modNetwork.MapConnectionToUser en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Function

Public Sub CloseNotLogged()

    On Error GoTo Errhandler:

    Dim key As Variant
    Dim Ticks As Long
    Dim ConnectionID As Long

100 Ticks = GetTickCount

102 For Each key In PendingConnections.Keys
106     ConnectionID = key

110     If Ticks - Mapping(ConnectionID).OnConnectTimeStamp > 120000 Then
            If Mapping(ConnectionID).UI > 0 Then
114             Call LogError("trying to kick an assigned connection: " & ConnectionID & " assigned to: " & Mapping(ConnectionID).UI)
            Else
116             Call KickConnection(ConnectionID)
            End If
        End If
118 Next key

    Exit Sub

Errhandler:

    Call LogError("Error en CloseNotLogged")

End Sub

Public Function GetIDOnPendingConnections(ByVal ID As Long) As Long

    On Error GoTo Errhandler:

    Dim key As Variant
    Dim Ticks As Long
    Dim ConnectionID As Long

102 For Each key In PendingConnections.Keys
        If key = ID Then
            GetIDOnPendingConnections = key
            Exit Function
        End If
118 Next key

    Exit Function

Errhandler:

    Call LogError("Error en GetIDOnPendingConnections")

End Function

Public Sub ClearConnection(ByVal Connection As Long)
    Mapping(Connection).UI = 0
    Mapping(Connection).BadPackets = 0
    Mapping(Connection).OnConnectTimeStamp = 0
End Sub

