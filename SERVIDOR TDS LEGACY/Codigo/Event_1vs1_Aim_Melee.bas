Attribute VB_Name = "Event_1vs1_Aim_Melee"
Option Explicit

'*****************************
'Author: G Toyz
'Fecha: 08/11
'Hora: 00:30 A.M
'Testeado: 100%
'*****************************
Private Type tUser
    ID As Integer          'ID del usuario.
    lastPos As WorldPos    'Última posición del usuario.
    Wins As Byte           'Ganadas llevadas hasta el momento.
    x As Byte              'X Arena.
    Y As Byte              'Y Arena.
    X_Room As Byte         'X Espera.
    Y_Room As Byte         'Y Espera
    Deaths As Byte         'Cantidad de veces que murió (Rounds)
End Type

Private Type tEvent
    Active  As Boolean     '¿Está activo?
    Active_Send As Boolean '¿Se puede enviar solicitudes de ingreso?
    Users(1 To 2) As tUser 'Usuarios en evento
    Max_Win As Byte        'Cantidad máxima de ganadas para terminar el evento
    Drop_Items As Byte     '¿Caen items?
    MAP_Event As Byte      'Mapa en donde se hace el evento.
    MAP_Items As Byte      'Mapa en donde caen los objetos.
    Count_Down As Integer  'Cuenta regresiva.
    Gold As Long           'Oro.
    UsersInEvent As Byte   'Usuarios en Evento.
    LastUser As String     'Último usuario que jugó.
    X_Items As Byte        'Posición X donde caen los items.
    Y_Items As Byte        'Posición Y donde caen los items
End Type

Private Evento As tEvent

Public Sub Load_Arenas()
    '// 1 Sola arena.
    With Evento
        .MAP_Event = 196
        .Users(1).x = 39
        .Users(1).Y = 41
        .Users(2).x = 54
        .Users(2).Y = 56
        .Users(1).X_Room = 40
        .Users(1).Y_Room = 42
        .Users(2).X_Room = 53
        .Users(2).Y_Room = 55
        .MAP_Items = 196
        .X_Items = 46
        .Y_Items = 77
    End With
End Sub

Public Sub Do_Event(ByVal Max_Win As Byte, ByVal Drop_Items As Boolean)
    
    '@@ CONDICIONALES.
    
    Dim Msg As String

    With Evento
        .Active_Send = True
        .Active = True
        .Max_Win = Max_Win
        .Drop_Items = Drop_Items
        Msg = PrepareMessageConsoleMsg("1VS1 Gana Sigue> Gana sigue, Maximos ganados: " & Max_Win & ". Al mejor de 3 Rounds" & IIf(Drop_Items = True, ". Caen los items ", vbNullString) & ". Para participar escriba /GANASIGUE", FontTypeNames.FONTTYPE_GUILD)
        Call SendData(SendTarget.ToAll, 0, Msg)
        Call Rules
        .Count_Down = 5
        Call LimpiarMapa(Evento.MAP_Event)
    End With
End Sub

Private Function GiveBack_ID() As Byte
    Dim LoopC As Long
    For LoopC = 1 To 2
        If Evento.Users(LoopC).ID = 0 Then
            GiveBack_ID = LoopC
            Exit For
        End If
    Next LoopC
End Function

Private Function ID_Array(ByVal ID As Integer) As Byte
    ID_Array = UserList(ID).EventAim.ID_Array
End Function

Public Sub Enter_Event(ByVal ID As Integer)
    
    '@@ Condicionales
    Dim ID_Array As Byte
    ID_Array = GiveBack_ID()
    If CanAim(ID) = False Then Exit Sub
    With Evento
        .UsersInEvent = .UsersInEvent + 1
        .Users(ID_Array).ID = ID
        .Users(ID_Array).lastPos = UserList(ID).Pos
        UserList(ID).EventAim.ID_Array = ID_Array
        UserList(ID).EnEvento = True
        Call WarpUserChar(ID, .MAP_Event, .Users(ID_Array).X_Room, .Users(ID_Array).Y_Room, False)
        If .UsersInEvent = 2 Then
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> Cupo completado!", FontTypeNames.FONTTYPE_FIGHT))
            Call Start_Event
            .Active_Send = False
            .Active = True
        End If
    End With
End Sub

Private Sub Start_Event()
    With Evento
        .Count_Down = 10 'Cuenta regresiva para que peleen
        Dim LoopC As Long
        For LoopC = 1 To 2
            Call WritePauseToggle(.Users(LoopC).ID)
        Next LoopC
        Call GO_Corner
    End With
End Sub

Public Sub Death_Event(ByVal ID As Integer)
    With Evento
        Dim uWin As Byte
        If ID_Array(ID) = 1 Then uWin = 2
        If ID_Array(ID) = 2 Then uWin = 1
        .Users(ID_Array(ID)).Deaths = .Users(ID_Array(ID)).Deaths + 1
        Call RevivirUsuario(ID)
        With UserList(ID)
            .Stats.MinHp = .Stats.MaxHp
            .Stats.MinMAN = .Stats.MaxMAN
            .Stats.MinSta = .Stats.MaxSta
            Call WriteUpdateUserStats(ID)
        End With
        Call WriteConsoleMsg(ID, "Has perdido el round!", FontTypeNames.FONTTYPE_GUILD)
        Call WriteConsoleMsg(.Users(uWin).ID, "Has ganado el round!", FontTypeNames.FONTTYPE_GUILD)
        If .Users(ID_Array(ID)).Deaths = 2 Then
            If .Drop_Items = True Then
                Call WarpUserChar(ID, .MAP_Items, .X_Items, .Y_Items, False)
                Call TirarTodosLosItems(ID)
            End If
            Call Bye_User(ID)
            Call Win_Round(uWin)
            Exit Sub
        End If
        Call GO_Corner
        .Count_Down = 10
        Call WritePauseToggle(.Users(1).ID)
        Call WritePauseToggle(.Users(2).ID)
    End With
End Sub

Private Sub End_Event(ByVal ID_Array As Byte)
    With Evento
        Dim ID As Integer
        ID = .Users(ID_Array).ID
        UserList(ID).Stats.GLD = UserList(ID).Stats.GLD + .Max_Win * 100000
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> Ganador del evento: " & UserList(ID).Name, FontTypeNames.FONTTYPE_GUILD))
        Call WriteUpdateGold(ID)
        Call WriteConsoleMsg(ID, "¡Has ganado el evento! ¡Has sido premiado con " & .Max_Win * 100000 & " monedas de oro!", FontTypeNames.FONTTYPE_GUILD)
        Call Bye_User(ID)
    End With
End Sub

Private Sub GO_Corner()
    With Evento
        Call WarpUserChar(.Users(1).ID, .MAP_Event, .Users(1).x, .Users(1).Y, False)
        Call WarpUserChar(.Users(2).ID, .MAP_Event, .Users(2).x, .Users(2).Y, False)
    End With
End Sub

Private Sub GO_LastPos(ByVal ID As Integer)
    With Evento
        Call WarpUserChar(ID, .Users(ID_Array(ID)).lastPos.map, .Users(ID_Array(ID)).lastPos.x, .Users(ID_Array(ID)).lastPos.Y, False)
    End With
End Sub

Private Sub Clean_User(ByVal ID As Integer)
    With Evento
        .Users(ID_Array(ID)).Deaths = 0
        .Users(ID_Array(ID)).ID = 0
        .Users(ID_Array(ID)).Wins = 0
    End With
End Sub

Private Sub Bye_User(ByVal ID As Integer)
    With UserList(ID).EventAim
        Evento.UsersInEvent = Evento.UsersInEvent - 1
        Evento.LastUser = UCase$(UserList(ID).Name)
        Call GO_LastPos(ID)
        Call Clean_User(ID)
        .ID_Array = 0
        UserList(ID).EnEvento = False
    End With
End Sub

Public Sub Count()
    With Evento
        If .Count_Down = 0 Then
            .Count_Down = -1
            If .Active = True And .Active_Send = False Then
                Call WriteConsoleMsg(.Users(1).ID, "Conteo> Ya!", FontTypeNames.FONTTYPE_CONSEJO)
                Call WriteConsoleMsg(.Users(2).ID, "Conteo> Ya!", FontTypeNames.FONTTYPE_CONSEJO)
                Call WritePauseToggle(.Users(1).ID)
                Call WritePauseToggle(.Users(2).ID)
            End If
            If .Active = True And .Active_Send = True Then
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> Conteo> Ya!", FontTypeNames.FONTTYPE_FIGHT))
                .Active = False
            End If
            
        End If
        If .Count_Down > 0 Then
            If .Active = True And .Active_Send = False Then
                Call WriteConsoleMsg(.Users(1).ID, "Conteo> " & .Count_Down, FontTypeNames.FONTTYPE_CONSEJO)
                Call WriteConsoleMsg(.Users(2).ID, "Conteo> " & .Count_Down, FontTypeNames.FONTTYPE_CONSEJO)
            End If
            If .Active = True And .Active_Send = True Then _
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> Conteo> " & .Count_Down, FontTypeNames.FONTTYPE_CONSEJO))
            
            .Count_Down = .Count_Down - 1
            
        End If
    End With
End Sub

Public Sub Disconnect_User(ByVal UserIndex As Integer)
    Dim uWin As Byte
    Dim IDArray As Byte
    Dim tLong As Long
    IDArray = ID_Array(UserIndex)
    If UserList(UserIndex).Stats.GLD >= 500000 Then
        UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD - 500000     '@@ Penalización
    Else
        tLong = UserList(UserIndex).Stats.GLD
        If UserList(UserIndex).Stats.Banco >= (500000 - tLong) Then
            UserList(UserIndex).Stats.Banco = UserList(UserIndex).Stats.Banco - (500000 - tLong)
        Else
            UserList(UserIndex).Stats.Banco = 0
        End If
    End If
    UserList(UserIndex).Stats.GLD = 0
    Call WriteUpdateGold(UserIndex)
    Call Bye_User(UserIndex)
    'Call Encarcelar(UserIndex, 11)
    
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> " & UserList(UserIndex).Name & " ha abandonado el evento, ha sido penalizado con un quite de 500.000 monedas de oro. Cupos restantes: " & Evento.UsersInEvent, FontTypeNames.FONTTYPE_GUILD))
    If Evento.Count_Down > 0 Then Evento.Count_Down = 0
    If IDArray = 1 Then uWin = 2
    If IDArray = 2 Then uWin = 1
    If Evento.Users(uWin).ID > 0 Then
        Call WritePauseToggle(Evento.Users(uWin).ID)
        Call Win_Round(uWin)
    End If
End Sub

Private Sub Win_Round(ByVal uWin As Byte)
    With Evento
    .Users(uWin).Wins = .Users(uWin).Wins + 1
    Call WarpUserChar(.Users(uWin).ID, .MAP_Event, .Users(uWin).X_Room, .Users(uWin).Y_Room, False)
    Call WriteConsoleMsg(.Users(uWin).ID, "¡Has ganado el combate!", FontTypeNames.FONTTYPE_GUILD)
    If .Users(uWin).Wins = .Max_Win Then _
        Call End_Event(uWin)
        
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("1VS1 Gana Sigue> " & UserList(.Users(uWin).ID).Name & " acumula su " & .Users(uWin).Wins & " Victoria. Escribe /GANASIGUE luego del conteo .", FontTypeNames.FONTTYPE_GUILD))
    Call Rules
    .Active_Send = True
    .Count_Down = 5
    End With
End Sub

Private Function CanAim(ByVal UserIndex As Integer) As Boolean
    CanAim = False
    
    With UserList(UserIndex)
        
        If Evento.Active_Send = False And Evento.Active = False Then
            WriteConsoleMsg UserIndex, "El evento no está en disputa.", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If Evento.Active_Send = False Then
            WriteConsoleMsg UserIndex, "No hay cupos disponibles.", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If Evento.Active = True And Evento.Active_Send = True Then
            WriteConsoleMsg UserIndex, "¡No hay cupos disponibles.!", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
      
        If UserList(UserIndex).EventAim.ID_Array > 0 Then
            WriteConsoleMsg UserIndex, "¡Ya estás en el evento!", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
                
        If MapInfo(.Pos.map).Pk = True Then
            WriteConsoleMsg UserIndex, "Estás en una zona insegura", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .flags.Muerto <> 0 Then
            WriteConsoleMsg UserIndex, "Estás muerto", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .Stats.GLD < Evento.Gold Then
            WriteConsoleMsg UserIndex, "No tenés suficiente oro", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
    
        If .UserReto.EnReto = True Then
            WriteConsoleMsg UserIndex, "¡Estás en reto!", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        ''If Items_Restricted(UserIndex) = True Then
        ''    WriteConsoleMsg UserIndex, "¡Tienes items no válidos para el evento.", FontTypeNames.FONTTYPE_INFO
        ''    Exit Function
        ''End If
        
        If UCase$(UserList(UserIndex).Name) = Evento.LastUser Then
            WriteConsoleMsg UserIndex, "Debes esperar una ronda más para poder jugar nuevamente.", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .EnEvento = True Then
            WriteConsoleMsg UserIndex, "¡Estás en un evento!", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .Counters.Pena > 0 Then
            WriteConsoleMsg UserIndex, "¡Estás en la cárcel!", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
    
    End With

    CanAim = True
End Function

Private Function Items_Restricted(ByVal ID As Integer) As Boolean
 
    '@@ Función que devuelve si tiene pociones o items prohibidos el usuario
    Dim LoopC As Long
    
    With UserList(ID)
    
        Dim oType As Byte
            
        For LoopC = 1 To .CurrentInventorySlots
            If .Invent.Object(LoopC).ObjIndex = 38 Or .Invent.Object(LoopC).ObjIndex = 37 Or .Invent.Object(LoopC).ObjIndex = 36 Or .Invent.Object(LoopC).ObjIndex = 39 Then
                Items_Restricted = True
                Exit Function
            End If
            If .Invent.Object(LoopC).ObjIndex <> 0 Then
                oType = ObjData(.Invent.Object(LoopC).ObjIndex).OBJType
                If oType = eOBJType.otESCUDO Or _
                    oType = eOBJType.otCASCO Or _
                    oType = eOBJType.otFlechas Then
                    Items_Restricted = True
                    Exit Function
                End If
            End If
        Next LoopC
        
        Items_Restricted = False
        
    End With
End Function

Private Sub Rules()
    ''Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Reglas> Venir sin; cascos, escudos, arcos, flechas, pociones. Clases permitidas: Paladín, Guerrero, Clerigo", FontTypeNames.FONTTYPE_FIGHT))
End Sub

