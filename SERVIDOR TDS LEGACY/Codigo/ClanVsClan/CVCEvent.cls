VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVCEvent"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Clase CVCEvent
Option Explicit

Const PREFIX As String = "CLAN VS CLAN> "

Private p_CVCID As Byte
Private p_SelectedMap As CVCMap
Private guild(1 To 2) As CVCTeam
Private cvcEnabled As Boolean
Private cvcStarted As Boolean
Private p_maxUsers As Byte
Private p_MapID As Integer

Private team1Spawn As WorldPos
Private team2Spawn As WorldPos

Public Property Get cvcID() As Byte
    cvcID = p_CVCID
End Property

Public Property Let cvcID(ByVal value As Byte)
    p_CVCID = value
End Property

Public Property Get SelectedMap() As CVCMap
    Set SelectedMap = p_SelectedMap
End Property

Public Property Set SelectedMap(ByVal value As CVCMap)
    Set p_SelectedMap = value
End Property

Public Property Get IsEnabled() As Boolean
    IsEnabled = cvcEnabled
End Property

Public Property Let IsEnabled(ByVal value As Boolean)
    cvcEnabled = value
End Property

Public Property Get IsStarted() As Boolean
    IsStarted = cvcStarted
End Property

Public Property Let IsStarted(ByVal value As Boolean)
    cvcStarted = value
End Property

Public Property Get maxUsers() As Byte
    maxUsers = p_maxUsers
End Property

Public Property Let maxUsers(ByVal value As Byte)
    p_maxUsers = value
End Property

Public Property Get mapID() As Integer
    mapID = p_MapID
End Property

Public Property Let mapID(ByVal value As Integer)
    p_MapID = value
End Property

' Maneja la muerte de un jugador en el evento
Public Sub HandleDeath(ByVal UserIndex As Integer)

    Dim GuildNum As Byte
    GuildNum = Find_Guild_Num(UserList(UserIndex).GuildIndex)

    guild(GuildNum).MuereUser UserIndex

    If guild(GuildNum).GetNumDeadUsers() >= guild(GuildNum).NumUsers Then
        Dim otherGuild As Byte

        otherGuild = IIf(GuildNum = 1, 2, 1)

        guild(otherGuild).RoundsWon = guild(otherGuild).RoundsWon + 1
        Call NotifyAll("Ronda ganada por el Clan " & GuildName(guild(otherGuild).GuildIndex))

        ' Si el otro clan ha ganado 3 rondas, termina el evento
        If guild(otherGuild).RoundsWon >= 3 Then
            EndEvent (otherGuild)
        Else
            ReiniciarRonda
        End If
    End If
End Sub

Public Sub NotifyAll(ByVal Message As String, Optional ByVal ft As FontTypeNames = FontTypeNames.FONTTYPE_GMMSG)

    Call SendData(SendTarget.toMap, p_SelectedMap.mapID, PrepareMessageConsoleMsg(PREFIX & Message, ft))

End Sub

Public Sub NotifyTeam(ByVal GuildNum As Byte, ByVal Message As String, Optional ByVal ft As FontTypeNames = FontTypeNames.FONTTYPE_GMMSG)

    Call SendData(SendTarget.toMap, p_SelectedMap.mapID, PrepareMessageConsoleMsg(PREFIX & Message, ft))

End Sub

Private Sub ResetRound()

    Call NotifyAll("La ronda se reiniciará en 1 segundo. ¡Prepárarense!")

End Sub

Public Sub HandleUserDisconnect(ByVal UserIndex As Integer)

    Call NotifyTeam(Find_Guild_Num(UserList(UserIndex).GuildIndex), "El usuario " & UserList(UserIndex).Name & " se ha desconectado")

    ' @@ Super feo
    Call WriteVar(CharPath & UCase$(UserList(UserIndex).Name) & ".chr", "INIT", "LastPos", UserList(UserIndex).flags.lastPos.Map & "-" & UserList(UserIndex).flags.lastPos.X & "-" & UserList(UserIndex).flags.lastPos.Y)

    Call HandleDeath(UserIndex)

End Sub

Public Sub EndEvent(ByVal winningTeam As Byte)
    
    Dim i As Long, tTeam As Byte, tIndex As Integer, emptyPos As WorldPos
    Dim Players() As String
    
    ' Lideres
    Dim Lideres(1 To 2) As String, LideresIndex(1 To 2) As Integer
    Lideres(1) = guilds(guild(1).GuildIndex).GetLeader: LideresIndex(1) = NameIndex(Lideres(1))
    Lideres(2) = guilds(guild(2).GuildIndex).GetLeader: LideresIndex(2) = NameIndex(Lideres(2))
    
    NotifyAll "El reto Clan vs Clan ha terminado. Ganó el clan " & GuildName(guild(winningTeam).GuildIndex)

    For tTeam = 1 To 2

        ' @@ Lider
        If Lideres(tTeam) Then
            If cvcStarted Then
                Call WarpUserCharX(tIndex, UserList(tIndex).flags.lastPos.Map, UserList(tIndex).flags.lastPos.X, UserList(tIndex).flags.lastPos.Y, True)
            End If
            UserList(tIndex).flags.lastPos = emptyPos
            UserList(tIndex).InCVCID = 0
            UserList(tIndex).flags.TargetGuildIndex = 0
        Else
            If cvcStarted Then
                Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "Position", GetVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos"))    ' @@ Lo dejamos en su lastPos
                Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos", emptyPos.Map & "-" & emptyPos.X & "-" & emptyPos.Y)
            End If
        End If

        Players() = Split(guild(tTeam).selectedPlayers, ",")

        ' @@ Players.
        For i = LBound(Players()) To UBound(Players())

            tIndex = NameIndex(Players(i))

            If tIndex Then
                If cvcStarted Then
                    Call WarpUserCharX(tIndex, UserList(tIndex).flags.lastPos.Map, UserList(tIndex).flags.lastPos.X, UserList(tIndex).flags.lastPos.Y, True)
                End If
                UserList(tIndex).flags.lastPos = emptyPos
                UserList(tIndex).InCVCID = 0
                UserList(tIndex).flags.TargetGuildIndex = 0
            Else
                If cvcStarted Then
                    Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "Position", GetVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos"))    ' @@ Lo dejamos en su lastPos
                    Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos", emptyPos.Map & "-" & emptyPos.X & "-" & emptyPos.Y)
                End If
            End If

        Next i
    Next tTeam

    Set guild(1) = New CVCTeam
    Set guild(2) = New CVCTeam
    cvcEnabled = False
    cvcStarted = False
    Set SelectedMap = Nothing
    Call cvcManager.RemoveEvent(Me)
End Sub

Public Sub CancelEvent()

    NotifyAll "El reto Clan vs Clan ha sido cancelado."

    Dim i As Long, tTeam As Byte, tIndex As Integer, emptyPos As WorldPos
    Dim Players() As String

    ' Lideres
    Dim Lideres(1 To 2) As String, LideresIndex(1 To 2) As Integer
    Lideres(1) = guilds(guild(1).GuildIndex).GetLeader: LideresIndex(1) = NameIndex(Lideres(1))
    Lideres(2) = guilds(guild(2).GuildIndex).GetLeader: LideresIndex(2) = NameIndex(Lideres(2))

    For tTeam = 1 To 2

        ' @@ Lider
        If LideresIndex(tTeam) Then
            If cvcStarted Then
                Call WarpUserCharX(LideresIndex(tTeam), UserList(LideresIndex(tTeam)).flags.lastPos.Map, UserList(LideresIndex(tTeam)).flags.lastPos.X, UserList(LideresIndex(tTeam)).flags.lastPos.Y, True)
            End If
            UserList(LideresIndex(tTeam)).flags.lastPos = emptyPos
            UserList(LideresIndex(tTeam)).InCVCID = 0
            UserList(LideresIndex(tTeam)).flags.TargetGuildIndex = 0
        Else
            If cvcStarted Then
                Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "Position", GetVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos"))    ' @@ Lo dejamos en su lastPos
                Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos", emptyPos.Map & "-" & emptyPos.X & "-" & emptyPos.Y)
            End If
        End If

        Players() = Split(guild(tTeam).selectedPlayers, ",")

        ' @@ Players.
        For i = LBound(Players()) To UBound(Players())

            tIndex = NameIndex(Players(i))

            If tIndex Then
                If cvcStarted Then
                    Call WarpUserCharX(tIndex, UserList(tIndex).flags.lastPos.Map, UserList(tIndex).flags.lastPos.X, UserList(tIndex).flags.lastPos.Y, True)
                End If
                UserList(tIndex).flags.lastPos = emptyPos
                UserList(tIndex).InCVCID = 0
                UserList(tIndex).flags.TargetGuildIndex = 0
            Else
                If cvcStarted Then
                    Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "Position", GetVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos"))    ' @@ Lo dejamos en su lastPos
                    Call WriteVar(CharPath & UCase$(Players(i)) & ".chr", "INIT", "LastPos", emptyPos.Map & "-" & emptyPos.X & "-" & emptyPos.Y)
                End If
            End If

        Next i
    Next tTeam

    Set guild(1) = New CVCTeam
    Set guild(2) = New CVCTeam
    cvcEnabled = False
    cvcStarted = False
    Set SelectedMap = Nothing
    Call cvcManager.RemoveEvent(Me)
End Sub

Public Sub ReiniciarRonda()
    NotifyAll "Se inicia una nueva ronda del reto Clan vs Clan."
    ' Aquí se podría reiniciar la lógica del juego, como revivir jugadores, asignar posiciones, etc.
End Sub

Private Function Find_Guild_Num(ByVal Guild_Index As Integer) As Byte
    Find_Guild_Num = IIf(guild(1).GuildIndex = Guild_Index, 1, 2)
End Function

Public Function IsUserInEvent(ByVal UserIndex As Integer) As Boolean
    Dim i As Integer
    For i = 1 To guild(1).NumUsers
        If guild(1).GetUser(i) = UserIndex Then
            IsUserInEvent = True
            Exit Function
        End If
    Next i
    For i = 1 To guild(2).NumUsers
        If guild(2).GetUser(i) = UserIndex Then
            IsUserInEvent = True
            Exit Function
        End If
    Next i
    
    ' @@ Compruebo si los lideres también están
    If UCase$(guilds(guild(1).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Or UCase$(guilds(guild(2).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Then
        IsUserInEvent = True
        Exit Function
    End If
    
    IsUserInEvent = False
End Function

' Inicializa los clanes participantes en el evento
Public Sub InitializeTeams(ByVal team1Guild As Integer, ByVal team2Guild As Integer, ByVal maxUsers As Byte)
' Inicializa los equipos
    Set guild(1) = New CVCTeam
    Set guild(2) = New CVCTeam

    guild(1).GuildIndex = team1Guild
    guild(2).GuildIndex = team2Guild

    guild(1).InitializeUsers maxUsers
    guild(2).InitializeUsers maxUsers

    Me.maxUsers = maxUsers

    cvcEnabled = True

    ' Asigna las posiciones iniciales
    team1Spawn.Map = p_SelectedMap.mapID
    team1Spawn.X = val(ReadField(1, p_SelectedMap.SpawnPointsTeam1, 45))
    team1Spawn.Y = val(ReadField(2, p_SelectedMap.SpawnPointsTeam1, 45))

    team2Spawn.Map = p_SelectedMap.mapID
    team2Spawn.X = val(ReadField(1, p_SelectedMap.SpawnPointsTeam2, 45))
    team2Spawn.Y = val(ReadField(2, p_SelectedMap.SpawnPointsTeam2, 45))


End Sub

Public Function SelectPlayers(ByVal LeaderIndex As Integer, ByVal GuildNumber As Byte, ByVal Players As String, ByRef Response As String) As Boolean

    If cvcStarted Then Response = "El reto Clan vs Clan ya está en marcha!": Exit Function

    If SelectionConfirmed(GuildNumber) Then
        Response = "Ya has confirmado tu selección!"
        Exit Function
    End If

    If guild(GuildNumber).SelectPlayers(LeaderIndex, Players, maxUsers, Response) Then
        guild(1).SelectionConfirmed = False
        guild(2).SelectionConfirmed = False
        SelectPlayers = True
    End If

End Function

Public Sub StartEvent()

    cvcStarted = True
    NotifyAll "El reto Clan vs Clan ha comenzado en el Mapa " & SelectedMap.mapID

    'guild(1).NumUsers = UBound(Split(guild(1).selectedPlayers, ",")) + 1
    'guild(2).NumUsers = UBound(Split(guild(2).selectedPlayers, ",")) + 1

    guild(1).CompactUsers
    guild(2).CompactUsers

    'NotifyAll "Equipo 1 en posición (" & SelectedMap.SpawnPointsTeam1 & ")"
    'NotifyAll "Equipo 2 en posición (" & SelectedMap.SpawnPointsTeam2 & ")"

End Sub

Public Function ConfirmCVCSelection(ByVal UserIndex As Integer, ByRef Response As String) As Boolean

    If cvcStarted Then Response = "El reto Clan vs Clan ya está en marcha!": Exit Function

    Dim cvcEvent As cvcEvent
    Dim tIndex As Integer
    Dim GuildNumber As Byte

    Set cvcEvent = cvcManager.GetCVCEventByUser(UserIndex)

    If Not cvcEvent Is Nothing Then
        GuildNumber = FindGuildNum_ByIndex(UserIndex)
        If SelectionConfirmed(GuildNumber) Then
            Response = "Ya has confirmado tu selección y no se puede modificar!"
            Exit Function
        End If
        
        If cvcEvent.GetDataFromCVC_Team(UserList(UserIndex).GuildIndex, 1) < 1 Then
            Response = "Debes elegir al menos 1 miembro"
            Exit Function
        End If

        Call SetSelectionConfirmed(GuildNumber, True)

        If cvcEvent.SelectionConfirmed(1) And cvcEvent.SelectionConfirmed(2) And AllPlayersReady() Then
            Response = "Todos los jugadores están listos para el reto Clan vs Clan. Ahora ambos lideres deben presionar en JUGAR!"
            If tIndex Then Call WriteConsoleMsg(tIndex, PREFIX & Response, FontTypeNames.FONTTYPE_GUILDMSG)

            tIndex = IIf(cvcEvent.GuildIndex(1) = UserList(UserIndex).GuildIndex, NameIndex(guilds(cvcEvent.GuildIndex(2)).GetLeader), NameIndex(guilds(cvcEvent.GuildIndex(1)).GetLeader))
            If tIndex Then Call WriteCVCListSend(tIndex, mCVC_Accion.cvc_ConfirmarSeleccion, False, 2)
            Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_ConfirmarSeleccion, True, 2)

        Else
            
            If cvcEvent.SelectionConfirmed(1) And cvcEvent.SelectionConfirmed(2) Then
                Response = "Ahora todos los jugadores deberán confirmar su participación para comenzar el reto!"
            Else
                Response = "Ahora espera al otro clan a que complete y confirme su selección."
            End If
            
            tIndex = IIf(cvcEvent.GuildIndex(1) = UserList(UserIndex).GuildIndex, NameIndex(guilds(cvcEvent.GuildIndex(2)).GetLeader), NameIndex(guilds(cvcEvent.GuildIndex(1)).GetLeader))
            If tIndex Then Call WriteCVCListSend(tIndex, mCVC_Accion.cvc_ConfirmarSeleccion, False, 1)
            Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_ConfirmarSeleccion, True, 1)
            
        End If
    Else
        Response = "No estás participando en ningún reto Clan vs Clan activo."
    End If
End Function

Private Function sendConfirmationRequest(ByVal UserName As String) As Boolean
    Dim tIndex As Integer
    tIndex = NameIndex(UserName)

    If tIndex = 0 Then Exit Function
    
    Call WriteCVCListSend(tIndex, mCVC_Accion.cvc_EstoyListo)
    sendConfirmationRequest = True

End Function

Public Function ChangeCVCSelection(ByVal UserIndex As Integer, ByVal newSelection As String, ByRef Response As String) As Boolean

    If cvcStarted Then Response = "El reto Clan vs Clan ya está en marcha!": Exit Function

    Dim cvcEvent As cvcEvent
    Set cvcEvent = cvcManager.GetCVCEventByUser(UserIndex)
    If Not cvcEvent Is Nothing Then
        Dim GuildNumber As Byte
        GuildNumber = cvcEvent.FindGuildNum_ByGuild(UserList(UserIndex).GuildIndex)
        If cvcEvent.SelectPlayers(UserIndex, GuildNumber, newSelection, Response) Then
            Response = "La selección de jugadores ha sido actualizada para Clan " & GuildNumber & ": " & newSelection
            Call cvcEvent.SetSelectionConfirmed(1, False)
            Call cvcEvent.SetSelectionConfirmed(2, False)
            Response = Response & vbCrLf & "Ambos clanes deben volver a confirmar su selección."
        Else
            Response = "La nueva selección de jugadores excede el límite permitido."
        End If
        ChangeCVCSelection = True
    Else
        Response = "No estás participando en ningún reto Clan vs Clan activo."
    End If
End Function

Public Function AllPlayersReady() As Boolean

    If Me.IsStarted Then Exit Function

    Dim i As Long
    For i = 1 To guild(1).NumUsers
        If Not guild(1).IsUserReady(i) Then
            AllPlayersReady = False
            Exit Function
        End If
    Next i
    For i = 1 To guild(2).NumUsers
        If Not guild(2).IsUserReady(i) Then
            AllPlayersReady = False
            Exit Function
        End If
    Next i
    AllPlayersReady = True
End Function

Public Function AreGuildPlayersReady(ByVal GuildNumber As Byte) As Boolean

    If Me.IsStarted Then Exit Function

    Dim i As Long
    For i = 1 To guild(GuildNumber).NumUsers
        If Not guild(GuildNumber).IsUserReady(i) Then
            AreGuildPlayersReady = False
            Exit Function
        End If
    Next i
    AreGuildPlayersReady = True
End Function

Public Function AreAllGuildsReady() As Boolean

    If Me.IsStarted Then Exit Function

    If Not guild(1).CanStart Then
        AreAllGuildsReady = False
        Exit Function
    End If
    If Not guild(2).CanStart Then
        AreAllGuildsReady = False
        Exit Function
    End If
    AreAllGuildsReady = True
End Function

Public Function GetDataFromCVC_Team(ByVal GuildIndex As Integer, ByVal QueBusco As Byte) As Variant

    Dim var As Variant

    With guild(FindGuildNum_ByGuild(GuildIndex))
        Select Case QueBusco
        Case 1
            ' @@ Cantidad de miembros
            var = CInt(.NumUsers)
        Case 2
            ' @@ Cantidad de miembros muertos
            var = CInt(.GetNumDeadUsers)
        Case 3
            ' @@ Jugadores seleccionados
            var = CStr(.selectedPlayers)
        End Select
    End With

    GetDataFromCVC_Team = var

End Function

Public Function GetDataFromCVC_Map(ByVal GuildIndex As Integer, ByVal QueBusco As Byte) As Variant

    Dim var As Variant

    With p_SelectedMap
        Select Case QueBusco
        Case 1
            ' @@ Número del mapa
            var = CInt(.mapID)
        Case 2
            ' @@ Disponibilidad el mapa
            var = CInt(.available)
        Case 3
            ' @@ Pos del Team 1
            var = CStr(.SpawnPointsTeam1)
        Case 4
            ' @@ Ppos del Team 2
            var = CStr(.SpawnPointsTeam2)
        End Select
    End With

    GetDataFromCVC_Map = var

End Function

Public Function MarkGuildReady(ByVal UserIndex As Integer)
    guild(FindGuildNum_ByGuild(UserList(UserIndex).GuildIndex)).CanStart = True
End Function

Public Function MarkPlayerReady(ByVal UserIndex As Integer, ByRef Response As String) As Boolean

    If Me.IsStarted Then Response = "El reto Clan vs Clan ya está en marcha!": Exit Function

    Dim GuildIndex As Long
    Dim i As Long

    Response = "Ya has confirmado tu participación!"

    For GuildIndex = 1 To 2
        For i = 1 To guild(GuildIndex).NumUsers
            If guild(GuildIndex).GetUser(i) = UserIndex Then
                If Not guild(GuildIndex).IsUserReady(i) Then
                    guild(GuildIndex).SetUserReady i, True
                    MarkPlayerReady = True
                    Response = "Has confirmado tu participación!"
                    Exit Function
                Else
                    Exit Function
                End If
            End If
        Next i
    Next GuildIndex

    Response = "No estás en la lista de jugadores"

    MarkPlayerReady = False

End Function

Public Function GuildIndex(ByVal ID As Byte) As Integer
    GuildIndex = guild(ID).GuildIndex
End Function

Public Function SelectionConfirmed(ByVal ID As Byte) As Boolean
    SelectionConfirmed = guild(ID).SelectionConfirmed
End Function

Public Function SetSelectionConfirmed(ByVal ID As Byte, ByVal value As Boolean)
    guild(ID).SelectionConfirmed = value
End Function

Public Function SetPlay(ByVal ID As Byte, ByVal value As Boolean)
    guild(ID).SelectionConfirmed = value
End Function

Public Function FindGuildNum_ByIndex(ByVal UserIndex As Integer) As Byte
    Dim i As Integer
    For i = 1 To guild(1).NumUsers
        If guild(1).GetUser(i) = UserIndex Then
            FindGuildNum_ByIndex = 1
            Exit Function
        End If
    Next i

    For i = 1 To guild(2).NumUsers
        If guild(2).GetUser(i) = UserIndex Then
            FindGuildNum_ByIndex = 2
            Exit Function
        End If
    Next i
    
    ' @@ Compruebo si los lideres también están
    If UCase$(guilds(guild(1).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Then ' Or UCase$(guilds(guild(2).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Then
        FindGuildNum_ByIndex = 1
        Exit Function
    End If
    
    If UCase$(guilds(guild(2).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Then ' Or UCase$(guilds(guild(2).GuildIndex).GetLeader) = UCase$(UserList(UserIndex).Name) Then
        FindGuildNum_ByIndex = 2
        Exit Function
    End If
    
    FindGuildNum_ByIndex = 0
End Function

Public Function FindGuildNum_ByGuild(ByVal GuildIndex As Integer) As Integer
    If guild(1).GuildIndex = GuildIndex Then
        FindGuildNum_ByGuild = 1    'guild(2).GuildIndex
    ElseIf guild(2).GuildIndex = GuildIndex Then
        FindGuildNum_ByGuild = 2    'guild(1).GuildIndex
    End If
End Function



