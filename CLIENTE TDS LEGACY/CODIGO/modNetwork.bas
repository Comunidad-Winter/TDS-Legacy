Attribute VB_Name = "modNetwork"
Option Explicit

' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
' [Engine::Services]
' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Public Aurora_Audio    As Audio_Service
Public Aurora_Content  As Content_Service
Public Aurora_Graphic  As Graphic_Service
Public Aurora_Renderer As Graphic_Renderer

' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
' [Engine::Network]
' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Private NetConnection_ As Network_Client
Private NetProtocol_   As Network_Protocol

Private LastConnectionTick As Long
Private Const ConnectionInterval As Long = 2000

Public PingTick As Long

Public Function IsConnected() As Boolean

    IsConnected = Connected

    If IsConnected Then
        If frmConnect.visible = True And Not frmCrearPersonaje.visible = True Then
            If Not frmConnect.QuieroCrearPj Then
                If UserCharIndex = 0 Then IsConnected = False
            End If
        End If
    End If

End Function

Function ConnectInterval(Optional ByVal Reset As Boolean = False) As Boolean

    On Error GoTo ErrHandler

    Dim tActualTick As Long
1   tActualTick = GetTickCount

2   If Reset Then
3       LastConnectionTick = tActualTick + ConnectionInterval
    Else
4       If LastConnectionTick > 0 Then
5           If tActualTick - LastConnectionTick < ConnectionInterval Then
6               frmMensaje.msg.Caption = "Demasiado rápido..."
7               frmMensaje.Show vbModal, frmConnect
8               ConnectInterval = False
9           Else
10              ConnectInterval = True
11              LastConnectionTick = tActualTick
            End If
        Else
12          ConnectInterval = True
13          LastConnectionTick = tActualTick
        End If
    End If
    Exit Function
ErrHandler:
    Call RegistrarError(Err.Number, Err.Description, "DLOH", Erl)
End Function

Public Sub Initialize()

    Dim Configuration As Kernel_Properties
    Configuration.WindowHandle = frmMain.MainViewPic.hwnd
    Configuration.WindowWidth = frmMain.MainViewPic.ScaleWidth
    Configuration.WindowHeight = frmMain.MainViewPic.ScaleHeight
    Configuration.WindowTitle = "TDS Legacy"
    
    Call Kernel.Initialize(eKernelModeClient, Configuration)

    Set Aurora_Audio = Kernel.Audio
    
    Set Aurora_Content = Kernel.Content
    Call Aurora_Content.AddSystemLocator("Resources", "Resources")

    Set Aurora_Graphic = Kernel.Graphics
    Set Aurora_Renderer = Kernel.Renderer
    
End Sub

' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
' [Engine::Network]
' -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Public Sub NetConnect(ByVal Address As String, ByVal Port As Long)
    Set NetProtocol_ = New Network_Protocol
    Call NetProtocol_.Attach(AddressOf Network_OnAttach, AddressOf Network_OnDetach, AddressOf Network_OnRecv, AddressOf Network_OnSend, AddressOf Network_OnError)
    Set NetConnection_ = Kernel.Network.Connect(Address, Port, 0, 0)
    Call NetConnection_.SetProtocol(NetProtocol_)
    Call Protocol_Writes.Initialize
End Sub

Public Sub NetClose(Optional ByVal Forcibly As Boolean = False)
    If (Not NetConnection_ Is Nothing) Then
        Call NetConnection_.Close(Forcibly)
    End If
End Sub

Public Sub NetWrite(ByVal Message As BinaryWriter, Optional ByVal Immediately As Boolean = False)
    If (Not NetConnection_ Is Nothing) Then
        Call NetConnection_.Write(Message, eChannelReliable)
        Call Message.Clear
        If (Immediately) Then
            Call NetConnection_.Flush
        End If
    End If
End Sub

Public Sub NetFlush()
    
    If (Not NetConnection_ Is Nothing) Then
        Call NetConnection_.Flush
    End If

End Sub

Private Sub Network_OnAttach(ByVal Connection As Network_Client)
    Call Login
End Sub

Private Sub Network_OnDetach(ByVal Connection As Network_Client)
    Call HandleDisconnect
End Sub

Private Sub Network_OnRecv(ByVal Connection As Network_Client, ByVal Message As BinaryReader)
    While (Message.GetAvailable() > 0)
        Call Protocol.Decode(Message)
        Call Protocol.handle(Message)
    Wend
End Sub

Private Sub Network_OnSend(ByVal Connection As Network_Client, ByVal Message As BinaryReader)
    Call Protocol.Encode(Message)
End Sub

Private Sub Network_OnError(ByVal Connection As Network_Client, ByVal Error As Long, ByVal Description As String)
    ' TODO: Log.Error(...)
End Sub

Public Sub Tick()

    Call Kernel.Tick
    
End Sub
