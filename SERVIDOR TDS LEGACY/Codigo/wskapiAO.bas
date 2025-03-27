Attribute VB_Name = "wskapiAO"
'**************************************************************
' wskapiAO.bas
'
'**************************************************************

'**************************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'**************************************************************************

Option Explicit

Private WebLastUser As Integer

'Tipo de los Usuarios
Public Type UserWeb
    Name As String
    ID As Long
    ConnectionIDValida As Boolean
    ConnectionID As Long
    IP As String
    outgoingData As clsByteQueue
    incomingData As clsByteQueue

End Type

Public WebUserList() As UserWeb
''
' Modulo para manejar Winsock
'

'Si la variable esta en TRUE , al iniciar el WsApi se crea
'una ventana LABEL para recibir los mensajes. Al detenerlo,
'se destruye.
'Si es FALSE, los mensajes se envian al form frmMain (o el
'que sea).
#Const WSAPI_CREAR_LABEL = True

Private Const SD_BOTH As Long = &H2

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private Declare Function GetWindowLong _
                          Lib "user32" _
                              Alias "GetWindowLongA" (ByVal hWnd As Long, _
                                                      ByVal nIndex As Long) As Long

Private Declare Function SetWindowLong _
                          Lib "user32" _
                              Alias "SetWindowLongA" (ByVal hWnd As Long, _
                                                      ByVal nIndex As Long, _
                                                      ByVal dwNewLong As Long) As Long

Private Declare Function CallWindowProc _
                          Lib "user32" _
                              Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Long, _
                                                       ByVal hWnd As Long, _
                                                       ByVal msg As Long, _
                                                       ByVal wParam As Long, _
                                                       ByVal lParam As Long) As Long

Private Declare Function CreateWindowEx _
                          Lib "user32" _
                              Alias "CreateWindowExA" (ByVal dwExStyle As Long, _
                                                       ByVal lpClassName As String, _
                                                       ByVal lpWindowName As String, _
                                                       ByVal dwStyle As Long, _
                                                       ByVal X As Long, _
                                                       ByVal Y As Long, _
                                                       ByVal nWidth As Long, _
                                                       ByVal nHeight As Long, _
                                                       ByVal hwndParent As Long, _
                                                       ByVal hMenu As Long, _
                                                       ByVal hInstance As Long, _
                                                       lpParam As Any) As Long

Private Declare Function DestroyWindow Lib "user32" (ByVal hWnd As Long) As Long

Private Const WS_CHILD = &H40000000

Private Const GWL_WNDPROC = (-4)

Private Const SIZE_RCVBUF As Long = 8192

Private Const SIZE_SNDBUF As Long = 8192

Private Const WM_USER As Long = &H400

Public Const WM_WINSOCK As Long = WM_USER + 1

Private OldWProc As Long

Private ActualWProc As Long

Public hWndMsg As Long

Public SockListen As Long
Public LastSockListen As Long

Public Sub IniciaWsApi(ByVal hwndParent As Long)

    #If WSAPI_CREAR_LABEL Then
        hWndMsg = CreateWindowEx(0, "STATIC", "AOMSG", WS_CHILD, 0, 0, 0, 0, hwndParent, 0, App.hInstance, ByVal 0&)
    #Else
        hWndMsg = hwndParent
    #End If    'WSAPI_CREAR_LABEL

    OldWProc = SetWindowLong(hWndMsg, GWL_WNDPROC, AddressOf WndProc)
    ActualWProc = GetWindowLong(hWndMsg, GWL_WNDPROC)

    Dim Desc As String

    Call StartWinsock(Desc)

End Sub

Public Sub LimpiaWsApi()

    If WSAStartedUp Then
        Call EndWinsock

    End If

    If OldWProc <> 0 Then
        SetWindowLong hWndMsg, GWL_WNDPROC, OldWProc
        OldWProc = 0

    End If

    #If WSAPI_CREAR_LABEL Then

        If hWndMsg <> 0 Then
            DestroyWindow hWndMsg

        End If

    #End If

End Sub

Public Function WndProc(ByVal hWnd As Long, _
                        ByVal msg As Long, _
                        ByVal wParam As Long, _
                        ByVal lParam As Long) As Long

    On Error Resume Next

    Dim Ret As Long

    Dim Tmp() As Byte

    Dim s As Long

    Dim E As Long

    Dim N As Integer

    Dim UltError As Long

    If msg = WM_WINSOCK Then
        s = wParam
        E = WSAGetSelectEvent(lParam)

        If E = FD_ACCEPT Then
            If s = SockListen Then
                Call EventoSockAccept(s)

            End If

        End If

    ElseIf (msg > WM_WINSOCK) And (msg <= (WM_WINSOCK + 500)) Then
        s = wParam
        E = WSAGetSelectEvent(lParam)

        N = msg - WM_WINSOCK

        Select Case E

        Case FD_READ
            'create appropiate sized buffer
            ReDim Preserve Tmp(SIZE_RCVBUF - 1) As Byte

            Ret = recv(s, Tmp(0), SIZE_RCVBUF, 0)

            ' Comparo por = 0 ya que esto es cuando se cierra
            ' "gracefully". (mas abajo)
            If Ret < 0 Then
                UltError = Err.LastDllError

                If UltError = WSAEMSGSIZE Then

                    Ret = SIZE_RCVBUF
                Else
                    Debug.Print "Error en Recv: " & GetWSAErrorString(UltError)
                    'Call LogApiSock("Error en Recv: N=" & N & " S=" & s & " Str=" & GetWSAErrorString(UltError))

                    'no hay q llamar a CloseSocket() directamente,
                    'ya q pueden abusar de algun error para
                    'desconectarse sin los 10segs. CREEME.
                    ' Call CloseSocketSL(N)
                    ' Call Cerrar_Usuario(N)
                    Exit Function

                End If

            ElseIf Ret = 0 Then
                '  Call CloseSocketSL(N)
                ' Call Cerrar_Usuario(N)

            End If

            ReDim Preserve Tmp(Ret - 1) As Byte

            Call HandleWebData(N, StrConv(Tmp, vbUnicode))

        Case FD_WRITE
            Call FlushBuffer(N)

        Case FD_CLOSE
            Call apiclosesocket(s)

            If WebUserList(N).ConnectionID <> -1 Then    'Si se cerró bien el socket en esta instancia ConnectionID tendría que ser -1
                WebUserList(N).ConnectionID = -1
                WebUserList(N).ConnectionIDValida = False
                Call EventoSockClose(N)

            End If

        End Select

    Else
        WndProc = CallWindowProc(OldWProc, hWnd, msg, wParam, lParam)

    End If

End Function

'Retorna 0 cuando se envió o se metio en la cola,
'retorna <> 0 cuando no se pudo enviar o no se pudo meter en la cola
Public Function WsApiEnviar(ByVal Slot As Integer, ByRef Str As String) As Long

    Dim Ret As String

    Dim Retorno As Long

    Dim Data() As Byte

    Dim length As Long

    ReDim Preserve Data(Len(Str) - 1) As Byte

    Data = StrConv(Str, vbFromUnicode)


    length = UBound(Data) + 1    'No hago con len(str) porque tengo las esperanzas de cambiar el parametro string por un array de bytes

    If WebUserList(Slot).ConnectionID <> -1 And WebUserList(Slot).ConnectionIDValida Then
        Ret = WSKSOCK.send(ByVal WebUserList(Slot).ConnectionID, Data(0), ByVal length, ByVal 0)

        If Ret < 0 Then
            Ret = Err.LastDllError

            If Ret = WSAEWOULDBLOCK Then

                ' WSAEWOULDBLOCK, put the data again in the outgoingData Buffer
                Call WebUserList(Slot).outgoingData.WriteASCIIStringFixed(Str)

            End If

        ElseIf Ret < length Then

            Dim Buff() As Byte

            ReDim Buff(Ret - 1) As Byte

            Data = StrConv(Str, vbFromUnicode)

            Call CopyMemory(Buff(0), Data(0), Ret)

            ReDim Buff((length - Ret) - 1) As Byte

            Call CopyMemory(Buff(0), Data(Ret), length - Ret)

            Call WebUserList(Slot).outgoingData.WriteBlock(Buff())

        End If

    ElseIf WebUserList(Slot).ConnectionID <> -1 And Not WebUserList(Slot).ConnectionIDValida Then

        Retorno = -1

    End If

    WsApiEnviar = Retorno

End Function

Private Function NextOpenWEBUser() As Integer

    Dim LoopC As Long

    For LoopC = 1 To 900 + 1
        If LoopC > 900 Then Exit For
        If (WebUserList(LoopC).ConnectionID = -1) Then Exit For
    Next LoopC

    NextOpenWEBUser = LoopC
End Function

Public Sub EventoSockAccept(ByVal SockID As Long)

    Dim NewIndex As Integer
    Dim Ret As Long
    Dim Tam As Long, sa As sockaddr
    Dim NuevoSock As Long
    Dim i As Long
    Dim Str As String
    Dim Data() As Byte

    Tam = sockaddr_size

    Ret = accept(SockID, sa, Tam)

    If Ret = INVALID_SOCKET Then
        i = Err.LastDllError
        Debug.Print ("Error en Accept() API " & i & ": " & GetWSAErrorString(i))
        Exit Sub

    End If

    NuevoSock = Ret

    If setsockopt(NuevoSock, SOL_SOCKET, SO_LINGER, 0, 4) <> 0 Then
        i = Err.LastDllError
        Debug.Print ("Error al setear lingers." & i & ": " & GetWSAErrorString(i))

    End If

    If SecurityIp.IPSecuritySuperaLimiteConexiones(sa.sin_addr) Then
        ' acá podemos hacer algo??
        ' str = "Limite de conexiones para su IP alcanzado."

        '  ReDim Preserve Data(Len(str) - 1) As Byte

        '   Data = StrConv(str, vbFromUnicode)

        '    Call WSKSOCK.send(ByVal NuevoSock, Data(0), ByVal UBound(Data()) + 1, ByVal 0)
        '    Call WSApiCloseSocket(NuevoSock, 0)
        '      Exit Sub

    End If

    'Seteamos el tamaño del buffer de entrada
    If setsockopt(NuevoSock, SOL_SOCKET, SO_RCVBUFFER, SIZE_RCVBUF, 4) <> 0 Then
        i = Err.LastDllError
        Call LogCriticEvent("Error al setear el tamaño del buffer de entrada " & i & ": " & GetWSAErrorString(i))

    End If

    'Seteamos el tamaño del buffer de salida
    If setsockopt(NuevoSock, SOL_SOCKET, SO_SNDBUFFER, SIZE_SNDBUF, 4) <> 0 Then
        i = Err.LastDllError
        Call LogCriticEvent("Error al setear el tamaño del buffer de salida " & i & ": " & GetWSAErrorString(i))

    End If

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '   BIENVENIDO AL SERVIDOR!!!!!!!!
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    ReDim WebUserList(1 To 900)
    Dim j As Long
    For j = 1 To 900
        WebUserList(j).ConnectionID = -1
        WebUserList(j).ConnectionIDValida = False
        Set WebUserList(j).incomingData = New clsByteQueue
        Set WebUserList(j).outgoingData = New clsByteQueue
    Next j
    'Mariano: Baje la busqueda de slot abajo de CondicionSocket y limite x ip
    NewIndex = NextOpenWEBUser    ' Nuevo indice

    If NewIndex <= 900 Then

        'Make sure both outgoing and incoming data buffers are clean
        Call WebUserList(NewIndex).incomingData.ReadASCIIStringFixed(WebUserList(NewIndex).incomingData.length)
        Call WebUserList(NewIndex).outgoingData.ReadASCIIStringFixed(WebUserList(NewIndex).outgoingData.length)

        WebUserList(NewIndex).IP = GetAscIP(sa.sin_addr)

        'Busca si esta banneada la ip
        For i = 1 To IP_Blacklist.count

            If IP_Blacklist.Item(i) = WebUserList(NewIndex).IP Then
                'Call apiclosesocket(NuevoSock)
                '   Call WriteErrorMsg(NewIndex, "Su IP se encuentra bloqueada en este servidor.")
                '  Call FlushBuffer(NewIndex)
                Call SecurityIp.IpRestarConexion(sa.sin_addr)
                Call WSApiCloseSocket(NuevoSock, 0)
                Exit Sub

            End If

        Next i

        If NewIndex > WebLastUser Then WebLastUser = NewIndex

        WebUserList(NewIndex).ConnectionID = NuevoSock
        WebUserList(NewIndex).ConnectionIDValida = True

        If WSAAsyncSelect(NuevoSock, hWndMsg, ByVal WM_WINSOCK + NewIndex, ByVal (FD_READ Or FD_WRITE Or FD_CLOSE)) Then
            Call WSApiCloseSocket(NuevoSock, 0)

        End If

    Else
        Str = "El servidor se encuentra lleno en este momento. Disculpe las molestias ocasionadas."

        ReDim Preserve Data(Len(Str) - 1) As Byte

        Data = StrConv(Str, vbFromUnicode)

        #If SeguridadAlkon Then
            Call Security.DataSent(Security.NO_SLOT, Data)
        #End If

        Call WSKSOCK.send(ByVal NuevoSock, Data(0), ByVal UBound(Data()) + 1, ByVal 0)
        Call WSApiCloseSocket(NuevoSock, 0)

    End If

End Sub

Public Sub EventoSockClose(ByVal Slot As Integer)
'Call CloseSocket(Slot)
    Call SecurityIp.IpRestarConexion(WebUserList(Slot).IP)
    Call WSApiCloseSocket(WebUserList(Slot).ConnectionID, Slot)

    WebUserList(Slot).ConnectionIDValida = False
End Sub

Public Sub WSApiReiniciarSockets()

    Dim i As Long

    'Cierra el socket de escucha
    If SockListen >= 0 Then Call apiclosesocket(SockListen)

    For i = 1 To 900
        'Set WebUserList(i).incomingData = Nothing
        'Set WebUserList(i).outgoingData = Nothing
    Next i

    ' No 'ta el PRESERVE :p
    ReDim WebUserList(1 To 900)

    For i = 1 To 900
        WebUserList(i).ConnectionID = -1
        WebUserList(i).ConnectionIDValida = False
        Set WebUserList(i).incomingData = New clsByteQueue
        Set WebUserList(i).outgoingData = New clsByteQueue
    Next i
    WebLastUser = 1

    Call LimpiaWsApi
    Call Sleep(100)
    Call IniciaWsApi(frmMain.hWnd)
    SockListen = ListenForConnect(Puerto, hWndMsg, vbNullString)

End Sub

Public Sub WSApiCloseSocket(ByVal Socket As Long, ByVal UserIndex As Long)
    Call WSAAsyncSelect(Socket, hWndMsg, ByVal WM_WINSOCK + UserIndex, ByVal FD_CLOSE)
    Call ShutDown(Socket, SD_BOTH)

End Sub

Public Function CondicionSocket(ByRef lpCallerId As WSABUF, _
                                ByRef lpCallerData As WSABUF, _
                                ByRef lpSQOS As FLOWSPEC, _
                                ByVal Reserved As Long, _
                                ByRef lpCalleeId As WSABUF, _
                                ByRef lpCalleeData As WSABUF, _
                                ByRef Group As Long, _
                                ByVal dwCallbackData As Long) As Long

    Dim sa As sockaddr

    'Check if we were requested to force reject

    If dwCallbackData = 1 Then
        CondicionSocket = CF_REJECT
        Exit Function

    End If

    'Get the address

    CopyMemory sa, ByVal lpCallerId.lpBuffer, lpCallerId.dwBufferLen

    If Not SecurityIp.IpSecurityAceptarNuevaConexion(sa.sin_addr) Then
        CondicionSocket = CF_REJECT
        Exit Function

    End If

    CondicionSocket = CF_ACCEPT    'En realdiad es al pedo, porque CondicionSocket se inicializa a 0, pero así es más claro....

End Function

Public Function EnviarDatosASlot(ByVal UserIndex As Integer, ByRef datos As String, Optional ByVal isString As Boolean = False) As Long
    On Error GoTo Err
    Dim Ret As Long

    If isString Then datos = "|" & datos & "|"

    Ret = WsApiEnviar(UserIndex, datos)

    If Ret <> 0 And Ret <> WSAEWOULDBLOCK Then
        'Call CloseSocketSL(UserIndex)
    End If
    Exit Function
Err:
End Function

Public Sub FlushBuffer(ByVal UserIndex As Integer)
    Dim sndData As String

    With WebUserList(UserIndex).outgoingData

        If .length = 0 Then _
           Exit Sub

        sndData = .ReadASCIIStringFixed(.length)

        Call EnviarDatosASlot(UserIndex, sndData)

    End With

End Sub

