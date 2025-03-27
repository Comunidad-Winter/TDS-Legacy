Attribute VB_Name = "Mod_TCP"
Option Explicit
Public Warping As Boolean
Public LlegaronSkills As Boolean
Public LlegaronAtrib As Boolean
Public LlegoFama As Boolean



Public Function PuedoQuitarFoco() As Boolean
    PuedoQuitarFoco = True
    'PuedoQuitarFoco = Not frmEstadisticas.Visible And _
     '                 Not frmGuildAdm.Visible And _
     '                 Not frmGuildDetails.Visible And _
     '                 Not frmGuildBrief.Visible And _
     '                 Not frmGuildFoundation.Visible And _
     '                 Not frmGuildLeader.Visible And _
     '                 Not frmCharInfo.Visible And _
     '                 Not frmGuildNews.Visible And _
     '                 Not frmGuildSol.Visible And _
     '                 Not frmCommet.Visible And _
     '                 Not frmPeaceProp.Visible

End Function

Sub Login()
    If EstadoLogin = E_MODO.LoginChar Then
        Call WriteLoginExistingChar
    ElseIf EstadoLogin = E_MODO.CrearNuevoPj Then
        Call WriteLoginNewChar
    ElseIf EstadoLogin = E_MODO.Dados Then
        Call WriteThrowDices
    End If
End Sub

Sub LoginOrConnect(ByVal Modo As E_MODO)
    EstadoLogin = Modo
    If (Not modNetwork.IsConnected) Then
        Call modNetwork.Connect(IP, port)
    Else
        Call Login
    End If
End Sub
