Attribute VB_Name = "mod_Connect"
Option Explicit

Private Declare Function GetVolumeInformation Lib "kernel32" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Long, lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long) As Long
Private Const MAX_PATH As Long = 260

Private Function GetSerialNumber() As Long
    Dim strRootPath As String
    Dim strVolumeName As String
    Dim lngSerialNumber As Long
    Dim lngMaximumComponentLength As Long
    Dim lngFileSystemFlags As Long
    Dim strFileSystemName As String
    Dim lngResult As Long

    strRootPath = Left(App.Path, 3)
    strVolumeName = String(MAX_PATH, Chr(0))
    strFileSystemName = String(MAX_PATH, Chr(0))
    lngResult = GetVolumeInformation(strRootPath, strVolumeName, MAX_PATH, _
                                     lngSerialNumber, lngMaximumComponentLength, lngFileSystemFlags, _
                                     strFileSystemName, MAX_PATH)
    If lngResult <> 0 Then
        GetSerialNumber = lngSerialNumber
    End If
End Function

Public Function GetHD() As String
    GetHD = GetSerialNumber()
End Function

Sub Login()
    If EstadoLogin = E_MODO.LoginChar Then
        Call WriteLoginExistingChar
    ElseIf EstadoLogin = E_MODO.CrearNuevoPj Then
        Call WriteLoginNewChar
    ElseIf EstadoLogin = E_MODO.Dados Then
        'Call WriteThrowDices

        If Not frmCrearPersonaje.visible = True Then
            Call frmCrearPersonaje.Show

46          If modEngine_Audio.MusicEnabled Then
47              Call modEngine_Audio.PlayMusic("2.MID")
            End If

            Unload frmConnect    '@@PATCH
        End If

        UserAtributos(eAtributos.Fuerza) = 18
        UserAtributos(eAtributos.Agilidad) = 18
        UserAtributos(eAtributos.Inteligencia) = 18
        UserAtributos(eAtributos.Carisma) = 18
        UserAtributos(eAtributos.Constitucion) = 18

        With frmCrearPersonaje
            GuiTexto(eAtributos.Fuerza).Texto = UserAtributos(eAtributos.Fuerza)
            GuiTexto(eAtributos.Agilidad).Texto = UserAtributos(eAtributos.Agilidad)
            GuiTexto(eAtributos.Inteligencia).Texto = UserAtributos(eAtributos.Inteligencia)
            GuiTexto(eAtributos.Carisma).Texto = UserAtributos(eAtributos.Carisma)

            GuiTexto(eAtributos.Constitucion).Texto = UserAtributos(eAtributos.Constitucion)

        End With

    End If
End Sub

Sub LoginOrConnect(ByVal Modo As E_MODO)

' @@ AntiFlood
    If Not ConnectInterval Then Exit Sub

    EstadoLogin = Modo
    If (Not Connected) Then
        Call modNetwork.NetConnect(IP, Port)
    Else
        Call Login
    End If
End Sub
