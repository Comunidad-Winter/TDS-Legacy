Attribute VB_Name = "m_ClanVsClanV2"
Option Explicit

Public Enum mCVC_Accion
    
    cvc_EnviarSolicitud = 1
    
    cvc_AceptarSolicitud = 2
    cvc_RechazarSolicitud = 3
    
    cvc_CambiarSeleccion = 4
    cvc_ConfirmarSeleccion = 5
    
    cvc_Cancelar = 6
    cvc_EstoyListo = 7
    cvc_Iniciar = 8
End Enum

Public cvcManager As cvcManager


Sub TEST_CVC()

    Dim Players(2) As Integer, cvcID As Byte, Response As String, tBool As Boolean

    Players(1) = NameIndex("betatester")
    Players(2) = NameIndex("elcujo")

    If Players(1) = 0 Or Players(2) = 0 Then Exit Sub

    ' @@ Self validations
    If UserList(Players(1)).InCVCID Then
        Call WriteConsoleMsg(Players(1), "Ya estás en un reto Clan vs Clan!")
        Exit Sub
    End If
    If UserList(Players(1)).GuildIndex = 0 Then
        Call WriteConsoleMsg(Players(1), "No perteneces a ningún clan!")
        Exit Sub
    End If
    If Not UCase$(UserList(Players(1)).Name) = UCase$(guilds(UserList(Players(1)).GuildIndex).GetLeader) Then
        Call WriteConsoleMsg(Players(1), "No eres el lider del clan!")
        Exit Sub
    End If

    ' @@ Target validations
    If Players(2) = 0 Then
        Call WriteConsoleMsg(Players(1), "El personaje no existe o no está conectado!")
        Exit Sub
    End If
    If UserList(Players(2)).GuildIndex = 0 Then
        Call WriteConsoleMsg(Players(1), "Ya estás en un reto Clan vs Clan!")
        Exit Sub
    End If
    If UserList(Players(1)).InCVCID Then
        Call WriteConsoleMsg(Players(1), "Ya estás en un reto Clan vs Clan!")
        Exit Sub
    End If
    If Not UCase$(UserList(Players(2)).Name) = UCase$(guilds(UserList(Players(2)).GuildIndex).GetLeader) Then
        Call WriteConsoleMsg(Players(1), UserList(Players(2)).Name & " no es el lider del clan!")
        Exit Sub
    End If
    
    UserList(Players(1)).cvc_MaxUsers = 2
    
    Call WriteConsoleMsg(Players(1), "Le mandaste solicitud de Reto Clan vs Clan a " & Players(2) & ". Máximo de miembros permitidos en el reto: " & UserList(Players(1)).cvc_MaxUsers)
    Call WriteConsoleMsg(Players(2), "Te ha mandado solicitud de Reto Clan vs Clan!" & " Máximo de miembros permitidos en el reto: " & UserList(Players(1)).cvc_MaxUsers)
    UserList(Players(1)).flags.TargetGuildIndex = UserList(Players(2)).GuildIndex
    UserList(Players(2)).flags.TargetGuildIndex = UserList(Players(1)).GuildIndex
       
       
    'cvcManager.HandleAcceptCVCRequest Players(1), "ElCujo" ' TESTING
    cvcManager.HandleAcceptCVCRequest Players(2), "Betatester" ' ACEPTO
    'cvcManager.HandleRejectCVCRequest Players(2), "Betatester" ' RECHAZO
    
    cvcManager.HandleSelectPlayers Players(1), "Betatester"
    cvcManager.HandleSelectPlayers Players(2), "ElCujo"
    
    cvcManager.HandlePlay Players(1)
    cvcManager.HandlePlay Players(2)
        
    cvcManager.HandleConfirmSelection Players(1)
    cvcManager.HandleConfirmSelection Players(2)
        
    cvcManager.HandleReady Players(1)
    cvcManager.HandleReady Players(2)
           
    ' @@ ARRANCÓ EL GAME
    
    cvcManager.HandleDeath Players(1)
    cvcManager.HandleDeath Players(2)
    
    ' @@ FORZAMOS LA VICTORIA DEL TEAM 2
    cvcManager.HandleDisconnect Players(1)
    
End Sub


