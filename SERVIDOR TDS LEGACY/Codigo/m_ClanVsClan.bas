Attribute VB_Name = "m_ClanVsClan"
Option Explicit

'enviarcvc nameindex("BETATESTER"),nameindex("ELCUJO")
'AceptarCVC NameIndex("ELCUJO"), NameIndex("BETATESTER")

Public Enum mCVC_Accion
    
    cvc_EnviarSolicitud = 1
    
    cvc_AceptarSolicitud = 2
    cvc_RechazarSolicitud = 3
    
    cvc_CambiarSeleccion = 4
    cvc_ConfirmarSeleccion = 5
    
    cvc_Cancelar = 6
    cvc_EstoyListo = 7
End Enum

Public Type cvc_User
    en_CVC As Boolean
    cvc_TargetIndex As Integer
    cvc_ID As Byte
    cvc_MaxUsers As Byte
    cvc_Seleccionado As Boolean
End Type

Type cvc_Clanes
    Guild_Index As Integer
    Num_Users As Byte
    UsUaRiOs() As Integer
    Rounds As Byte
End Type

Type cvc_Data
    guild(1 To 2) As cvc_Clanes
    cvc_Enabled As Boolean
    cvc_Started As Boolean

    count_Down As Byte
    max_Users As Byte
    Puntos_Por_Cabeza As Integer
    cvc_ID As Byte

    MAPA_CVC As Integer
End Type

Public CVC_Info(1 To 5) As cvc_Data

Public usersClan1 As Byte
Public usersClan2 As Byte

Public menorCant As Byte

Const PRIMER_CLAN_X As Byte = 39
Const SECOND_CLAN_X As Byte = 20
Const PRIMER_CLAN_Y As Byte = 78
Const SECOND_CLAN_Y As Byte = 74
Const PREFIX As String = "CLAN VS CLAN> "
