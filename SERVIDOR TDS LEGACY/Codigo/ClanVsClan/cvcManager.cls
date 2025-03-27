VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVCManager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private activeEvents() As cvcEvent
Private Const MAX_CVC_InProgress As Integer = 10

Private availableMaps() As CVCMap
Private MAX_MAPS As Integer

Const PREFIX As String = "CLAN VS CLAN> "

Private Sub Class_Initialize()

    ReDim activeEvents(1 To MAX_CVC_InProgress)
    InitializeMaps

End Sub

Private Sub InitializeMaps()

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "RetosClanvsClan.ini")

    MAX_MAPS = val(Leer.GetValue("INIT", "MAX_MAPS"))

    If MAX_MAPS = 0 Then Exit Sub

    ReDim availableMaps(1 To MAX_MAPS)

    Dim i As Long, ln As String
    For i = 1 To MAX_MAPS
        Set availableMaps(i) = New CVCMap

        Call availableMaps(i).InitializeMap(val(Leer.GetValue(i, "Mapa")), Leer.GetValue(i, "SpawnPoint_Team1"), Leer.GetValue(i, "SpawnPoint_Team2"), val(Leer.GetValue(i, "Habilitado")))
    Next i

    Set Leer = Nothing

End Sub

Private Function GetRandomMap() As CVCMap

    Dim available As Collection
    Dim i As Long
    Dim randomIndex As Integer

    Set available = New Collection
    For i = 1 To MAX_MAPS
        If Not availableMaps(i) Is Nothing Then
            If availableMaps(i).available Then
                available.Add availableMaps(i)
            End If
        End If
    Next i

    If available.count > 0 Then
        randomIndex = Int((available.count) * Rnd + 1)
        Set GetRandomMap = available(randomIndex)
    Else
        Set GetRandomMap = Nothing
    End If

End Function

' Crear un evento CVC
Public Function CreateCVCEvent(ByVal team1Guild As Integer, ByVal team2Guild As Integer, ByVal maxUsers As Byte, ByRef Response As String) As Byte

    Dim cvcEvent As cvcEvent
    Set cvcEvent = New cvcEvent

    Dim SelectedMap As CVCMap
    Set SelectedMap = GetRandomMap()

    If SelectedMap Is Nothing Then
        Response = "No hay arenas disponibles para iniciar el evento.": Exit Function
    End If

    cvcEvent.mapID = SelectedMap.mapID
    Set cvcEvent.SelectedMap = SelectedMap

    cvcEvent.InitializeTeams team1Guild, team2Guild, maxUsers

    CreateCVCEvent = AddEvent(cvcEvent)

    If CreateCVCEvent = 0 Then
        Response = "Todas las arenas están ocupadas."
    End If

End Function

Private Function AddEvent(ByRef cvcEvent As cvcEvent) As Byte

    Dim i As Long
    For i = LBound(activeEvents) To UBound(activeEvents)
        If activeEvents(i) Is Nothing Then
            Set activeEvents(i) = cvcEvent
            cvcEvent.cvcID = i
            AddEvent = i
            Exit Function
        End If
    Next i

End Function

Public Sub RemoveEvent(ByVal cvcEvent As cvcEvent)

    Dim i As Long
    For i = LBound(activeEvents) To UBound(activeEvents)
        If activeEvents(i) Is cvcEvent Then
            Set activeEvents(i) = Nothing
            Exit For
        End If
    Next i

End Sub

Public Sub HandleDeath(ByVal UserIndex As Integer)
    
    If UserList(UserIndex).InCVCID Then
        If Not activeEvents(UserList(UserIndex).InCVCID) Is Nothing Then
            activeEvents(UserList(UserIndex).InCVCID).HandleDeath UserIndex
        End If
    End If

End Sub

Public Sub HandleDisconnect(ByVal UserIndex As Integer)
    
    If UserList(UserIndex).InCVCID Then
        If Not activeEvents(UserList(UserIndex).InCVCID) Is Nothing Then
            activeEvents(UserList(UserIndex).InCVCID).HandleUserDisconnect UserIndex
        End If
    End If

End Sub

Public Sub HandleConfirmSelection(ByVal UserIndex As Integer)

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    Dim GuildIndex As Integer, Response As String, cvcID As Integer
    
    GuildIndex = UserList(UserIndex).GuildIndex
    cvcID = UserList(UserIndex).InCVCID

    If cvcID = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "Tu clan no está en ningún reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    If Not activeEvents(cvcID) Is Nothing Then
        activeEvents(cvcID).ConfirmCVCSelection UserIndex, Response
    Else
        Response = "No estás en ningún reto Clan vs Clan activo."
    End If

    Call WriteConsoleMsg(UserIndex, PREFIX & Response, FontTypeNames.FONTTYPE_GUILDMSG)

End Sub

Public Sub HandleRequestCVC(ByVal UserIndex As Integer, ByVal targetGuildName As String, ByVal maxUsers As Byte)

    If maxUsers < 1 Then maxUsers = 1
    
    Dim TargetGuild As Integer
    TargetGuild = findGuildIndex(targetGuildName)
    
    If TargetGuild = -1 Then
        Call WriteConsoleMsg(UserIndex, "El clan " & Chr(34) & targetGuildName & Chr(34) & " no existe!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    Dim requestingGuild As Integer
    requestingGuild = UserList(UserIndex).GuildIndex
        
    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If TargetGuild = requestingGuild Then
        Call WriteConsoleMsg(UserIndex, "El clan que estás intentando retar es tuyo!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    Dim TargetIndex As Integer
    TargetIndex = NameIndex(guilds(TargetGuild).GetLeader)
    
    If TargetIndex = 0 Then
        Call WriteConsoleMsg(UserIndex, "Debes estar cerca del lider del clan (a su vez éste debe estar conectado)!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If IsGuildInCVC(requestingGuild) = 0 And IsGuildInCVC(TargetGuild) = 0 Then
        
        'newEvent = CreateCVCEvent(requestingGuild, TargetGuild, maxUsers, Response)
        'If newEvent Then
        ' @@ Aviso.
        'End If
    
        Call SendData(SendTarget.ToGuildMembers, requestingGuild, PrepareMessageConsoleMsg(PREFIX & "El clan " & GuildName(requestingGuild) & " ha solicitado un reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG))
            
        UserList(UserIndex).cvc_MaxUsers = maxUsers
        UserList(UserIndex).flags.TargetGuildIndex = UserList(TargetIndex).GuildIndex

        Call WriteConsoleMsg(UserIndex, "Le mandaste solicitud de Reto Clan vs Clan al lider del clan " & GuildName(TargetGuild) & ". Máximo de miembros permitidos en el reto: " & maxUsers, FontTypeNames.FONTTYPE_GUILDMSG)
        
        ' @@ Le invitamos cordialmente
        Call WriteCVCListSend(TargetIndex, mCVC_Accion.cvc_EnviarSolicitud, maxUsers, requestingGuild)
                
    Else
        Call WriteConsoleMsg(UserIndex, "Uno de los clanes ya está participando en un evento activo.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If
End Sub

Public Sub HandleRejectCVCRequest(ByVal UserIndex As Integer, ByVal targetGuildName As String)
    
    Dim TargetGuild As Integer
    TargetGuild = findGuildIndex(targetGuildName)
    
    If TargetGuild = -1 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "El clan " & Chr(34) & targetGuildName & Chr(34) & " no existe.", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    Dim TargetIndex As Integer
    TargetIndex = NameIndex(guilds(TargetGuild).GetLeader)

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    If TargetIndex = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & targetGuildName & " no mandó ninguna solicitud de reto Clan vs Clan o su lider está desconectado o no existe.", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    If Not isLeader(TargetIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & TargetIndex & " No tiene o no es lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If IsGuildInCVC(UserList(UserIndex).GuildIndex) Or IsGuildInCVC(TargetGuild) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "Alguno de los clanes está en un reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If UserList(TargetIndex).flags.TargetGuildIndex = UserList(UserIndex).GuildIndex Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "Has rechazado la solicitud de reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
        Call WriteConsoleMsg(TargetIndex, PREFIX & "El lider del Clan " & GuildName(UserList(UserIndex).GuildIndex) & " ha rechazado la solicitud de reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
        
        UserList(TargetIndex).flags.TargetGuildIndex = 0
        
    Else
        Call WriteConsoleMsg(UserIndex, PREFIX & "El lider del clan " & GuildName(UserList(UserIndex).GuildIndex) & " no te ha mandado una solicitud de reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If

End Sub

Public Sub HandleCancelCVCRequest(ByVal UserIndex As Integer)

    Dim tIndex As Integer
    Dim eventIndex As Integer
    Dim otherGuildNum As Integer

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    eventIndex = FindCVCEvent(UserList(UserIndex).GuildIndex, -1)

    If eventIndex > 0 Then
        otherGuildNum = activeEvents(eventIndex).FindGuildNum_ByGuild(UserList(UserIndex).GuildIndex)

        If otherGuildNum = 0 Then
            Call WriteConsoleMsg(UserIndex, "No has mandado una solicitud de reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
            Exit Sub
        End If
        
        Call WriteConsoleMsg(UserIndex, "Has cancelado el reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
        Call SendData(SendTarget.ToGuildMembers, UserList(UserIndex).flags.TargetGuildIndex, PrepareMessageConsoleMsg(PREFIX & "El lider del Clan " & GuildName(UserList(UserIndex).GuildIndex) & " ha cancelado el reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG))

        Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_Cancelar)
        
        tIndex = NameIndex(guilds(UserList(UserIndex).flags.TargetGuildIndex).GetLeader)
        
        If tIndex Then
            Call WriteCVCListSend(tIndex, mCVC_Accion.cvc_Cancelar)
        End If
                
        ' @@ Sacarle el flag a todos!
        Call activeEvents(eventIndex).CancelEvent
                
        Call RemoveEvent(activeEvents(eventIndex))
    Else
        Call WriteConsoleMsg(UserIndex, "No hay solicitudes activas para cancelar.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If
End Sub

Public Sub HandleAcceptCVCRequest(ByVal UserIndex As Integer, ByVal GuildNameSender As String)

    Dim acceptingGuild As Integer
    Dim maxUsers As Byte
    acceptingGuild = UserList(UserIndex).GuildIndex

    ' @@ Mínimo 3 jugadores en cada equipo!
    'If maxUsers < 3 Then maxUsers = 3

    Dim otherIndex As Integer

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    Dim otherGuild As Integer
    otherGuild = findGuildIndex(GuildNameSender)
    
    If otherGuild = -1 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "El clan " & Chr(34) & GuildNameSender & Chr(34) & " no existe!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    otherIndex = NameIndex(guilds(otherGuild).GetLeader)

    If otherIndex = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "El lider del clan debe estar conectado!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    If UserList(otherIndex).InCVCID Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "El clan" & Chr(34) & GuildNameSender & Chr(34) & " ya se encuentra en otro reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    If UserList(otherIndex).flags.TargetGuildIndex = 0 Or Not UserList(otherIndex).flags.TargetGuildIndex = UserList(UserIndex).GuildIndex Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "El lider del clan" & Chr(34) & GuildNameSender & Chr(34) & " no te mandó un reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    maxUsers = UserList(otherIndex).cvc_MaxUsers

    If maxUsers = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "Tu no tienes que confirmar el reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    Dim eventIndex As Byte
    Dim Response As String
    eventIndex = cvcManager.CreateCVCEvent(otherGuild, acceptingGuild, maxUsers, Response)

    If eventIndex > 0 Then

        ' @@ Inicialmente a los líderes se les asigna el flag del clan enemigo y en qué CVC están
        UserList(UserIndex).flags.TargetGuildIndex = UserList(otherIndex).GuildIndex
        UserList(otherIndex).flags.TargetGuildIndex = UserList(UserIndex).GuildIndex
        
        UserList(UserIndex).InCVCID = eventIndex
        UserList(otherIndex).InCVCID = eventIndex

        ' @@ Avisar a ambos clanes!
        Dim tStr As String
        tStr = PREFIX & "¡¡Ha comenzado un nuevo reto!! " & GuildNameSender & " VS " & GuildName(acceptingGuild) & "."
        Call SendData(SendTarget.ToGuildMembers, otherGuild, PrepareMessageConsoleMsg(Response, FontTypeNames.FONTTYPE_GUILDMSG))

        Call SendData(SendTarget.ToGuildMembers, acceptingGuild, PrepareMessageConsoleMsg(Response, FontTypeNames.FONTTYPE_GUILDMSG))

        ' @@ Abrir formulario para ambos lideres para la selección de los que jugarán
        Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_AceptarSolicitud, otherGuild)
        Call WriteCVCListSend(otherIndex, mCVC_Accion.cvc_AceptarSolicitud, acceptingGuild)

    Else
        Call WriteConsoleMsg(UserIndex, Response, FontTypeNames.FONTTYPE_GUILDMSG)
    End If

End Sub

Public Sub HandlePlay(ByVal UserIndex As Integer)

    Dim cvcEvent As cvcEvent
    Set cvcEvent = GetCVCEventByUser(UserIndex)
        
    If Not cvcEvent Is Nothing Then
                
        Dim Response As String
        Dim currentTeam As Byte
        Dim currentTeamLeaderIndex As Integer
        Dim success As Boolean
        
        ' @@ Marcamos en el evento que estoy listo!
        success = activeEvents(UserList(UserIndex).InCVCID).MarkPlayerReady(UserIndex, Response)
        Call WriteConsoleMsg(UserIndex, PREFIX & Response, FontTypeNames.FONTTYPE_GUILDMSG)
        
        If success Then
            currentTeam = activeEvents(UserList(UserIndex).InCVCID).FindGuildNum_ByGuild(UserList(UserIndex).GuildIndex)
            currentTeamLeaderIndex = NameIndex(guilds(UserList(UserIndex).GuildIndex).GetLeader)
            Call WriteCVCListSend(currentTeamLeaderIndex, mCVC_Accion.cvc_EstoyListo, 4, UserList(UserIndex).Name)
            If cvcEvent.AreGuildPlayersReady(currentTeam) Then
                If currentTeamLeaderIndex Then Call WriteCVCListSend(currentTeamLeaderIndex, mCVC_Accion.cvc_Iniciar) ' @@ Habilitamos el botoncinho de PLAY!
            End If
        End If
    Else
        Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en ningún reto Clan vs Clan activo.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If
End Sub

Public Sub HandleReady(ByVal UserIndex As Integer)

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If UserList(UserIndex).InCVCID = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en un reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    If UserList(UserIndex).flags.TargetGuildIndex = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en ningún reto Clan vs Clan activo!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
        
    Dim tIndex As Integer
    tIndex = NameIndex(GuildLeader(UserList(UserIndex).flags.TargetGuildIndex))
    
    If UserList(tIndex).flags.TargetGuildIndex = 0 Or Not UserList(tIndex).flags.TargetGuildIndex = UserList(UserIndex).GuildIndex Then
        Call WriteConsoleMsg(UserIndex, PREFIX & UserList(tIndex).Name & " no te mandó un reto Clan vs Clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If
    
    Dim cvcEvent As cvcEvent
    Set cvcEvent = GetCVCEventByUser(UserIndex)

    If Not cvcEvent Is Nothing Then

        ' Empezó?
        If cvcEvent.IsStarted Then
            Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en ningún reto Clan vs Clan activo.", FontTypeNames.FONTTYPE_GUILDMSG)
            Exit Sub
        End If
        
        cvcEvent.MarkGuildReady UserIndex
        
        If cvcEvent.AllPlayersReady() And cvcEvent.AreAllGuildsReady Then
            Call cvcEvent.StartEvent
        Else
            Call WriteConsoleMsg(UserIndex, PREFIX & "Has confirmado, espera la respuesta del lider del otro clan para comenzar!", FontTypeNames.FONTTYPE_GUILDMSG)
            
            Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_EstoyListo, 1)
            If tIndex Then Call WriteCVCListSend(tIndex, mCVC_Accion.cvc_EstoyListo, 2)
            
        End If
    Else
        Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en ningún reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If
End Sub

Private Function isLeader(ByVal UserIndex As Integer) As Boolean

    If UserList(UserIndex).GuildIndex Then
        isLeader = UCase$(GuildLeader(UserList(UserIndex).GuildIndex)) = UCase$(UserList(UserIndex).Name)
    End If

End Function

' @@ Seleccionar jugadores
Public Sub HandleSelectPlayers(ByVal UserIndex As Integer, ByVal Players As String)

    If Not isLeader(UserIndex) Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No tienes o no eres lider del clan!", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    Dim otherGuild As Integer
    Dim currentGuild As Integer

    currentGuild = UserList(UserIndex).GuildIndex
    otherGuild = UserList(UserIndex).flags.TargetGuildIndex

    If otherGuild = 0 Then
        Call WriteConsoleMsg(UserIndex, PREFIX & "No estás en ningún reto Clan vs Clan", FontTypeNames.FONTTYPE_GUILDMSG)
        Exit Sub
    End If

    Dim eventIndex As Integer
    eventIndex = FindCVCEvent(currentGuild, otherGuild)

    If eventIndex > 0 Then

        Dim currentTeam As Byte
        currentTeam = activeEvents(eventIndex).FindGuildNum_ByGuild(currentGuild)

        Dim Response As String
        If activeEvents(eventIndex).SelectPlayers(UserIndex, currentTeam, Players, Response) Then
            
            Call SendData(SendTarget.ToGuildMembers, currentGuild, PrepareMessageConsoleMsg(PREFIX & GuildName(currentGuild) & ": " & Response, FontTypeNames.FONTTYPE_GUILDMSG))
            Call SendData(SendTarget.ToGuildMembers, otherGuild, PrepareMessageConsoleMsg(PREFIX & GuildName(currentGuild) & ": " & Response, FontTypeNames.FONTTYPE_GUILDMSG))
            
            Call WriteCVCListSend(UserIndex, mCVC_Accion.cvc_CambiarSeleccion, True, currentGuild)
            Dim otherIndex As Integer
            otherIndex = NameIndex(guilds(otherGuild).GetLeader)
            
            If otherIndex Then Call WriteCVCListSend(otherIndex, mCVC_Accion.cvc_CambiarSeleccion, False, currentGuild)
            
        Else
            If Len(Response) Then
                Call WriteConsoleMsg(UserIndex, PREFIX & Response, FontTypeNames.FONTTYPE_GUILDMSG)
            End If
        End If
    Else
        Call WriteConsoleMsg(UserIndex, PREFIX & "Tu clan no se encuentra en un reto Clan vs Clan.", FontTypeNames.FONTTYPE_GUILDMSG)
    End If

End Sub

Public Function IsGuildInCVC(ByVal GuildIndex As Integer) As Byte

    Dim i As Integer

    For i = LBound(activeEvents) To UBound(activeEvents)
        If Not activeEvents(i) Is Nothing Then
            If activeEvents(i).GuildIndex(1) = GuildIndex Or activeEvents(i).GuildIndex(2) = GuildIndex Then
                IsGuildInCVC = i
                Exit Function
            End If
        End If
    Next i

    IsGuildInCVC = 0

End Function

Public Function GetDataFromCVC(ByVal ID As Byte, ByVal GuildIndex As Integer, ByVal QueBusco As Byte) As Variant
    
    Dim var As Variant
    
    With activeEvents(ID)
        Select Case QueBusco
            Case 1
                ' @@ Cantidad de jugadores
                var = CInt(.GetDataFromCVC_Team(GuildIndex, 1))
            Case 2
                ' @@ Premio en honor
                var = CInt(.GetDataFromCVC_Team(GuildIndex, 2))
            Case 3
                ' @@ Jugadores seleccionados
                var = CStr(.GetDataFromCVC_Team(GuildIndex, 3))
            Case 4
                ' @@ Cantidad máxima usada para calcular el honor, que se yo.
                var = CInt(.maxUsers)
        End Select
    End With

    GetDataFromCVC = var

End Function

Private Function FindCVCEvent(ByVal guild1 As Integer, ByVal guild2 As Integer) As Byte

    Dim i As Long

    For i = LBound(activeEvents) To UBound(activeEvents)
        If Not activeEvents(i) Is Nothing Then
            ' Si guild1 = team1 o team2 y guild2 = -1, o ambos guilds coinciden con el evento
            If (activeEvents(i).GuildIndex(1) = guild1 And (activeEvents(i).GuildIndex(2) = guild2 Or guild2 = -1)) _
            Or (activeEvents(i).GuildIndex(2) = guild1 And (activeEvents(i).GuildIndex(1) = guild2 Or guild2 = -1)) Then
                FindCVCEvent = i
                Exit Function
            End If
        End If
    Next i

    FindCVCEvent = 0

End Function


Public Function GetCVCEventByUser(ByVal UserIndex As Integer) As cvcEvent

    Dim i As Long

    For i = LBound(activeEvents) To UBound(activeEvents)
        If Not activeEvents(i) Is Nothing Then
            If activeEvents(i).IsUserInEvent(UserIndex) Then
                Set GetCVCEventByUser = activeEvents(i): Exit Function
            End If
        End If
    Next i
    
    Set GetCVCEventByUser = Nothing

End Function


