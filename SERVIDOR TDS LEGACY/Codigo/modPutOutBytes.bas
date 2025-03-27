Attribute VB_Name = "modPutOutBytes"
Option Explicit

Private prvStaticSendBytes As Long, prvStaticRecieveBytes As Long
Attribute prvStaticRecieveBytes.VB_VarUserMemId = 1073741824

Public Sub set_ByteRecieve(ByVal Data As Long)
    prvStaticRecieveBytes = prvStaticRecieveBytes + Data
End Sub

Public Sub set_ByteSend(ByVal Data As Long)
    prvStaticSendBytes = prvStaticSendBytes + Data / 2
End Sub

Public Sub PutInfoBytes()

    If frmMain.Visible Then
        'frmMain.lblBytesSalida.Caption = "Bytes End: " & Round(prvStaticSendBytes / 1024, 3) & "kb/s"
        frmMain.lblBytesEntrada.Caption = "Bytes In: " & Round(prvStaticRecieveBytes / 1024, 3) & "kb/s"
    End If

    prvStaticRecieveBytes = 0
    prvStaticSendBytes = 0

End Sub


