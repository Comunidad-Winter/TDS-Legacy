Attribute VB_Name = "mod_HungerGames"
 Option Explicit

Private Const MAX_SLOTS As Byte = 16 '// Cantidad máxima de cupos.

Private Type tPos
    x As Byte               '// Posición Y del usuario.
    Y As Byte               '// Posición X del usuario.
    Occupied As Boolean     '// ¿Posición ocupada?
End Type

Private Type tCoffer
    Items(1 To 5) As Obj    '// Cantidad de items en el cofre.
    x As Byte               '// Posición X del cofre.
    Y As Byte               '// Posición Y del cofre.
    Empty As Boolean        '// ¿Está vacío?
End Type

Private Const NumCofres As Byte = 9

Private Type tHunger_Games
    Indexs() As Integer         '// ID de cada usuario en el evento.
    Pos(1 To MAX_SLOTS) As tPos '// Posiciones de cada usuario.
    Coffers(1 To NumCofres) As tCoffer '// Cofres
    Active As Boolean           '// ¿Activo?
    CountDown As Integer        '// Cuenta regresiva
    No_Slots_Occupied As Byte   '// Cupos no ocupados (o cupos restantes)
    Slots As Byte               '// Cupos
    User_Remaining As Byte      '// Usuarios restantes
    Starting As Boolean         '// Comenzando
End Type

Public Hunger_Games As tHunger_Games


Public Const MAP_Hunger_Games As Integer = 197    '// MAPA
Private Const ESPERA_X As Byte = 0              '// Sala de espera X
Private Const ESPERA_Y As Byte = 0              '// Sala de espera Y
Public Const COFRE_CERRADO_OBJINDEX As Integer = 11   '// Index del cofre cerrado.
Public Const COFRE_ABIERTO_OBJINDEX As Integer = 10   '// Index del cofre abierto.

Public Sub LoadHungerGames()
''On Error GoTo errh
    Dim path As String
    path = App.path & "\Dat\JDH.dat"
    ' // POST DEFAULTS
    With Hunger_Games
        Dim z As Long, i As Long, tStr As String
        For z = 1 To MAX_SLOTS
            With .Pos(z)
                .x = val(ReadField(1, GetVar(path, "USUARIOS", "POS" & z), Asc("-")))
                .Y = val(ReadField(2, GetVar(path, "USUARIOS", "POS" & z), Asc("-")))
            End With
        Next z
        
        For z = 1 To NumCofres
            With .Coffers(z)
                .x = val(ReadField(1, GetVar(path, "COFRE" & z, "POS"), Asc("-")))
                .Y = val(ReadField(2, GetVar(path, "COFRE" & z, "POS"), Asc("-")))
                For i = 1 To 5
                    .Items(i).ObjIndex = val(ReadField(1, GetVar(path, "COFRE" & z, "ITEM" & i), Asc("-")))
                    .Items(i).Amount = val(ReadField(2, GetVar(path, "COFRE" & z, "ITEM" & i), Asc("-")))
                Next i
            End With
        Next z
    End With
    
    ''Set Reader = Nothing
    
    Exit Sub
errh:
    MsgBox "Error " & Err.Number & " (" & Err.description & ") cargando 'JDH.dat'"
End Sub

Public Sub AbrirCofre(ByVal UserIndex As Integer, ByVal map As Integer, ByVal x As Byte, ByVal Y As Byte, ByVal Abierto As Boolean)
    Dim z As Long, i As Long, cPos As WorldPos, cObj As Obj
    If map <> MAP_Hunger_Games Then Exit Sub
    cPos.x = x
    cPos.Y = Y
    cPos.map = map
    If Distancia(cPos, UserList(UserIndex).Pos) > 2 Then
        Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If
    
    If Hunger_Games.Active = False Then Exit Sub
    
    For z = 1 To NumCofres
        With Hunger_Games.Coffers(z)
            
            If .x = x And .Y = Y Then
                If Abierto = False Then
                    If .Empty = False Then
                        For i = 1 To 5
                            If .Items(i).ObjIndex <> 0 Then
                                Call TirarItemAlPiso(cPos, .Items(i))
                            End If
                        Next i
                    End If
                    Call EraseObj(100, map, x, Y)
                    cObj.Amount = 1
                    cObj.ObjIndex = COFRE_ABIERTO_OBJINDEX
                    Call MakeObj(cObj, cPos.map, cPos.x, cPos.Y)
                    .Empty = True
                Else
                    Call EraseObj(1, MAP_Hunger_Games, cPos.x, cPos.Y)
                    cObj.Amount = 1
                    cObj.ObjIndex = COFRE_CERRADO_OBJINDEX
                    Call MakeObj(cObj, cPos.map, cPos.x, cPos.Y)
                End If
            End If
        End With
    Next z
End Sub

Public Sub ResetCofres()
    Dim z As Long, cPos As WorldPos, cObj As Obj
    For z = 1 To NumCofres
        With Hunger_Games.Coffers(z)
            cPos.map = MAP_Hunger_Games
            cPos.x = .x
            cPos.Y = .Y
            Call EraseObj(1, MAP_Hunger_Games, .x, .Y)
            cObj.Amount = 1
            cObj.ObjIndex = COFRE_CERRADO_OBJINDEX
            Call MakeObj(cObj, cPos.map, cPos.x, cPos.Y)
            .Empty = False
        End With
    Next z
End Sub

Public Sub IniciarHunger_Games()
On Error GoTo errh
    With Hunger_Games
        If .Active = True Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Ya hay un HungerGames en curso", FontTypeNames.FONTTYPE_INFOBOLD))
            Exit Sub
        End If
        .Active = True
        .CountDown = 10
        .Slots = 16
        .No_Slots_Occupied = 16
        .User_Remaining = 16
        .Starting = True
        ReDim .Indexs(1 To .Slots)
        Call MensajeGlobal("Juegos del Hambre> El evento ha comenzado. Cupos disponibles: 16. Reglas: Ingresar con el inventario vacio. Inscripcion: 200.000 monedas de oro. Escribe /JDH para ingresar", FontTypeNames.FONTTYPE_GUILD)
        Call ResetCofres
        Call LimpiarMapa(MAP_Hunger_Games)
    End With
    Exit Sub
errh:
    Debug.Print "Error en iniciarHunger en linea: " & Err.source
End Sub

Public Sub Muere_HungerGames(ByVal ID_Death As Integer, Optional ByVal Disconnect As Boolean = False)
    
    With UserList(ID_Death)
        If Not .HungerGames.HungerGamers Then Exit Sub
        .HungerGames.HungerGamers = False
        .EnEvento = False
        Call TirarTodosLosItems(ID_Death)
        
        Call WarpUserChar(ID_Death, .HungerGames.lastPos.map, .HungerGames.lastPos.x, .HungerGames.lastPos.Y, True, , True)
        Dim LoopC As Long
        For LoopC = 1 To Hunger_Games.Slots
            If Hunger_Games.Indexs(LoopC) = ID_Death Then
                Hunger_Games.Indexs(LoopC) = 0
            End If
        Next LoopC
        
        If Disconnect = True And Hunger_Games.Starting = False Then
            Hunger_Games.No_Slots_Occupied = Hunger_Games.No_Slots_Occupied + 1
        End If
        If Disconnect Then
            If Hunger_Games.Starting = True Then
                Call MensajeGlobal("Juegos del Hambre> " & .name & " se ha desconectado" & IIf(Hunger_Games.User_Remaining > 2, ". Quedan " & Hunger_Games.User_Remaining - 1 & " usuarios vivos.", ""), FontTypeNames.FONTTYPE_GUILD)
            Else
                Call MensajeGlobal("Juegos del Hambre> Se ha liberado un cupo por la desconexión de " & .name, FontTypeNames.FONTTYPE_GUILD)
            End If
        Else
            Call MensajeGlobal("Juegos del Hambre> " & .name & " ha muerto" & IIf(Hunger_Games.User_Remaining > 2, ". Quedan " & Hunger_Games.User_Remaining & " usuarios vivos.", "."), FontTypeNames.FONTTYPE_GUILD)
        End If
        If Disconnect = False And Hunger_Games.Starting = True Then
            Hunger_Games.User_Remaining = Hunger_Games.User_Remaining - 1
            
            If Hunger_Games.User_Remaining = 1 Then
                Call HungerGames_Finish
            End If
        End If
    End With
End Sub

Private Sub HungerGames_Finish()
    With Hunger_Games
        Dim LoopC As Long, Winner As Integer
        For LoopC = 1 To .Slots
            If .Indexs(LoopC) > 0 Then
                Winner = .Indexs(LoopC)
                Exit For
            End If
        Next LoopC
        If Winner <= 0 Then Exit Sub 'Raro, pero por las dudas
        Call MensajeGlobal("Juegos del Hambre> Evento finalizado. Ganador: " & UserList(Winner).name & ". Premio: 1.000.000 monedas de oro", FontTypeNames.FONTTYPE_GUILD)
        With UserList(Winner)
            .Stats.GLD = .Stats.GLD + 1000000
            Call WriteUpdateGold(Winner)
            WriteConsoleMsg Winner, "Juegos del Hambre> Tenés 1 minuto para agarrar los items.", FontTypeNames.FONTTYPE_GUILD
            .HungerGames.SecondsBack = 60
        End With
        
    End With
End Sub

Public Sub EnterHungerGames(ByVal ID As Integer)
    With UserList(ID)
        Dim lError As String '<=esta es la variable
        Call Can_HungerGames(ID, lError)
        If LenB(lError) <> 0 Then
            Call WriteConsoleMsg(ID, "Juegos del hambre> " & lError, FontTypeNames.FONTTYPE_INFO)
            Exit Sub 'Si tiene algun error, le decimos cual es y salimos.
        End If
        With .HungerGames
            .HungerGamers = True
            .lastPos = UserList(ID).Pos
        End With
        .EnEvento = True
        If .Stats.GLD >= 200000 Then
            .Stats.GLD = .Stats.GLD - 200000
        Else
            .Stats.GLD = 0
        End If
        Call WriteUpdateGold(ID)
        With Hunger_Games
            .No_Slots_Occupied = .No_Slots_Occupied - 1
            Dim LoopC As Long, find As Byte
            For LoopC = 1 To .Slots
                If .Indexs(LoopC) <= 0 Then
                    find = CByte(LoopC)
                    Exit For
                End If
            Next LoopC
            .Indexs(find) = ID
            ''WarpUserChar ID, MAP_Hunger_Games, ESPERA_X, ESPERA_Y, True, , True
            WarpUserChar .Indexs(find), MAP_Hunger_Games, .Pos(find).x, .Pos(find).Y, True
            WritePauseToggle ID
            Call MensajeGlobal("Juegos del Hambre> " & UserList(ID).name & " ha ingresado al evento.", FontTypeNames.FONTTYPE_GUILD)
            If .No_Slots_Occupied = 0 Then
                HungerGames_Go
            End If
        End With
    End With
End Sub

Public Sub PassSecondHungerGames()
    With Hunger_Games
        'Death_Finish
        If .Active And .Starting = True And .CountDown >= 0 Then
            Select Case .CountDown
                Case 0
                    Call MensajeGlobal("Juegos del Hambre> ¡Ya!", FontTypeNames.FONTTYPE_GUILD)
                    Call HungerGames_GO1
                
                Case Else
                    Call MensajeGlobal("Juegos del Hambre> ¡" & .CountDown & "!", FontTypeNames.FONTTYPE_GUILD)
            
            End Select
            .CountDown = .CountDown - 1
        End If
    End With
End Sub
Sub Cancel_HungerGames()
    With Hunger_Games
        Dim x As Long
        For x = 1 To .Slots
            If .Indexs(x) > 0 Then
                WarpUserChar .Indexs(x), UserList(.Indexs(x)).HungerGames.lastPos.map, UserList(.Indexs(x)).HungerGames.lastPos.x, UserList(.Indexs(x)).HungerGames.lastPos.Y, True, , True
                UserList(.Indexs(x)).HungerGames.HungerGamers = False
                UserList(.Indexs(x)).EnEvento = False
                .Indexs(x) = 0
            End If
        Next x
        .Active = False
        .Starting = False
        .CountDown = 0
        Call MensajeGlobal("Juegos del Hambre> El evento ha sido cancelado", FontTypeNames.FONTTYPE_GUILD)
    End With
End Sub

Function HungerGames_CanAttack(ByVal ID As Integer) As Boolean
    With Hunger_Games
        If .Active = True And .Starting = True And .CountDown <= 0 Then
            HungerGames_CanAttack = True
            Exit Function
        End If
        
        If .Active = True And .CountDown > 0 Then
            HungerGames_CanAttack = False
            WriteConsoleMsg ID, "Juegos del Hambre> Espera que termine la cuenta regresiva", FontTypeNames.FONTTYPE_GUILD
        End If
    End With
End Function

Private Sub HungerGames_GO1()
    Dim x As Long
    For x = 1 To Hunger_Games.Slots
        If Hunger_Games.Indexs(x) > 0 Then
            WritePauseToggle Hunger_Games.Indexs(x)
        End If
    Next x
End Sub

Private Sub HungerGames_Go()
    
    Dim Pos_Index As Byte
    With Hunger_Games
        .Starting = True

        Dim x As Long
        For x = 1 To .Slots
            If .Indexs(x) > 0 Then
                Pos_Index = There_Pos
                .Pos(Pos_Index).Occupied = True
                ''WarpUserChar .Indexs(X), MAP_Hunger_Games, .Pos(Pos_Index).X, .Pos(Pos_Index).Y, True, , True
                ''WritePauseToggle .Indexs(x)
            End If
        Next x
    End With
End Sub

Private Function There_Pos() As Boolean
    There_Pos = False
    
    Dim LoopC As Long
    With Hunger_Games
        For LoopC = 1 To 16
            If .Pos(LoopC).Occupied = False Then
                There_Pos = LoopC
                Exit Function
            End If
        Next LoopC
    End With
End Function

Private Function InventarioVacio(ByVal ID As Integer) As Boolean
    Dim x As Long
    For x = 1 To MAX_INVENTORY_SLOTS
        With UserList(ID).Invent.Object(x)
            If .ObjIndex <> 0 Then
                InventarioVacio = False
                Exit Function
            End If
        End With
    Next x
    InventarioVacio = True
End Function

Private Sub Can_HungerGames(ByVal ID As Integer, ByRef lError As String)
    With UserList(ID)
        
        If Hunger_Games.Active = False Then
            lError = "Evento inactivo"
            Exit Sub
        End If
        
        If Hunger_Games.No_Slots_Occupied <= 0 Then
            lError = "Cupos completos"
            Exit Sub
        End If
        
        If (.flags.Muerto <> 0) Then
            lError = "Estás muerto"
            Exit Sub
        End If
        
        If (.Counters.Pena <> 0) Then
            lError = "Estás en la cárcel"
            Exit Sub
        End If
        
        If .Stats.ELV < 25 Then
            lError = "Necesitas ser nivel 25"
            Exit Sub
        End If
    
        If MapInfo(.Pos.map).Pk = True Then
            lError = "Estás en zona insegura"
            Exit Sub
        End If
        
        If .EnEvento = True Then
            lError = "Estás en otro evento"
            Exit Sub
        End If
        
        If .Stats.GLD < 200000 Then
            lError = "No tenes suficiente oro"
            Exit Sub
        End If
        
        If InventarioVacio(ID) = False Then
            lError = "Debes tener el inventario vacio para ingresar a este evento"
            Exit Sub
        End If
    End With
End Sub

Private Sub MensajeGlobal(ByVal Chat As String, ByVal FontIndex As FontTypeNames)
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(Chat, FontIndex))
End Sub

