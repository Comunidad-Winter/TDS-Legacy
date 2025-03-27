Attribute VB_Name = "m_TorneoJDH"
Option Explicit

Private Const TimeRespawn As Byte = 5

Private Type tExtra
    Y As Byte
    X As Byte
    Map As Integer
End Type

Private Type tUsers
    UI As Integer
    PreviousPos As WorldPos

    Killed As Integer
    Deaths As Integer
    Points As Integer

    EquipID As Byte

    InventTempJDH As Inventario
    LastChar As Char
End Type

Private Type tEvent
    Active As Boolean
    Quotas As Byte
    Entered As Byte
    Inscription As Long
    PrizeGLD As Long
    PrizePoints As Long
    EventStarted As Boolean
    Rounds As Byte
    TimeRemaining As Byte
    TimeAtacking As Byte

    LastKilled As Byte

    EventName As String
    eventIndex As Byte

    users() As tUsers
    ClasesValidas(1 To NUMCLASES) As eClass

    MinLevel As Byte
    Maxlevel As Byte

End Type

Public Events As tEvent

Private Cofres_OpenedLeft As Byte
Private Const Cofre_Open As Byte = 10
Private Const Cofre_Close As Byte = 11

Private Type tCofres
    Cant As Byte
    Object() As Obj
End Type

Private MapsEvent As tExtra

Private CofresJDH(1 To NUMCLASES - 2) As tCofres

Public Sub CreateEvent(ByVal UI As Integer, ByVal Quotas As Byte, ByVal Inscription As Long, ByVal Prize As Long, ByVal Puntos As Byte, ByVal MinLevel As Byte, ByVal Maxlevel As Byte, ByVal cMago As Byte, ByVal cClerigo As Byte, ByVal cGuerrero As Byte, ByVal cAsesino As Byte, ByVal cLadron As Byte, ByVal cBardo As Byte, ByVal cDruida As Byte, ByVal cBandido As Byte, ByVal cPaladin As Byte, ByVal cCazador As Byte, ByVal cTrabajador As Byte, ByVal cPirata As Byte)

    If Quotas > 60 Then Quotas = 60
    If Quotas < 2 Then Quotas = 2

    If Prize < 1 Then
        Prize = Inscription * Quotas
    End If

    With Events
        If .Active Then
            Call WriteConsoleMsg(UI, "El evento ya esta en curso.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        NOMBRE_TORNEO_ACTUAL = "Juegos del Hambre> "
        TOURNAMENT_ACTIVE = 4

        .Active = True
        .EventStarted = False
        .Quotas = Quotas
        .Inscription = Inscription
        .PrizeGLD = Prize
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel


        Dim T As Boolean
        .ClasesValidas(eClass.Mage) = cMago: If T = False Then T = (cMago > 0)
        .ClasesValidas(eClass.Cleric) = cClerigo: If T = False Then T = (cClerigo > 0)
        .ClasesValidas(eClass.Bard) = cBardo: If T = False Then T = (cBardo > 0)
        .ClasesValidas(eClass.Paladin) = cPaladin: If T = False Then T = (cPaladin > 0)
        .ClasesValidas(eClass.Assasin) = cAsesino: If T = False Then T = (cAsesino > 0)
        .ClasesValidas(eClass.Hunter) = cCazador: If T = False Then T = (cCazador > 0)
        .ClasesValidas(eClass.Warrior) = cGuerrero: If T = False Then T = (cGuerrero > 0)
        .ClasesValidas(eClass.Druid) = cDruida: If T = False Then T = (cDruida > 0)
        .ClasesValidas(eClass.Thief) = cLadron: If T = False Then T = (cLadron > 0)
        .ClasesValidas(eClass.Blacksmith) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Carpenter) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Fisherman) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Miner) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Woodcutter) = cTrabajador: If T = False Then T = (cBandido > 0)
        .ClasesValidas(eClass.Pirat) = cPirata: If T = False Then T = (cPirata > 0)

        .EventName = "Juegos del hambre"

        .PrizePoints = Puntos
        .TimeAtacking = 4

        ReDim .users(1 To .Quotas) As tUsers

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & Quotas & " Cupos" & ", Inscripción " & IIf(.Inscription > 0, "de: " & Inscription & " monedas de oro, ", "Gratis, ") & vbNewLine & IIf(.PrizeGLD > 0, "Premio de: " & .PrizeGLD & " monedas de oro. ", "") & IIf(.PrizePoints > 0, "Premio de: " & .PrizePoints & " Puntos de canje.", "") & vbNewLine & "Nivel mínimo: " & .MinLevel & ", Nivel máximo: " & .Maxlevel & " ", FontTypeNames.FONTTYPE_EVENTOS))

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Para ingresar escribe /PARTICIPAR", FontTypeNames.FONTTYPE_EVENTOS))

        If T Then
            SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Clases prohibidas: " & IIf(cMago > 0, " MAGO ", "") & IIf(cClerigo > 0, " CLERIGO ", "") & IIf(cBardo > 0, " BARDO ", "") & IIf(cPaladin > 0, " PALADIN ", "") & IIf(cAsesino > 0, " ASESINO ", "") & IIf(cCazador > 0, " CAZADOR ", "") & IIf(cGuerrero > 0, " GUERRERO ", "") & IIf(cDruida > 0, " DRUIDA ", "") & IIf(cLadron > 0, " LADRON ", "") & IIf(cBandido > 0, " BANDIDO ", "") & IIf(cTrabajador > 0, " TRABAJADOR ", "") & IIf(cPirata > 0, " PIRATA ", ""), FontTypeNames.FONTTYPE_INFOBOLD)
        End If

    End With

End Sub

Private Function CheckAllowedClasses(ByRef AllowedClasses() As Byte) As String

    Dim LoopC As Long

    For LoopC = 1 To NUMCLASES - 2
        If AllowedClasses(LoopC) = 1 Then
            If CheckAllowedClasses <> vbNullString Then
                CheckAllowedClasses = CheckAllowedClasses & ", " & ListaClases(LoopC)
            Else
                CheckAllowedClasses = ListaClases(LoopC)
            End If
        End If
    Next LoopC

End Function

Public Sub CancelEvent(Optional ByVal Cancel As Boolean = False)

    Dim LoopC As Long, N As Integer

    With Events

        If Not .Active Then Exit Sub

        If Not Cancel Then
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & " El evento ha sido cancelado.", FontTypeNames.FONTTYPE_EVENTOS))
        Else
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & " El evento ha sido auto-cancelado.", FontTypeNames.FONTTYPE_EVENTOS))
        End If

        For LoopC = 1 To .Quotas
            N = .users(LoopC).UI

            If N > 0 Then
                UserList(N).Slot_ID = 0
                UserList(N).flags.EnEvento = 0

                If Not .EventStarted Then
                    Call WritePauseToggle(N)
                End If
                Call RestoreInventory(LoopC)

                Call ReturnGold(N)
                Call WarpUserCharX(N, .users(LoopC).PreviousPos.Map, .users(LoopC).PreviousPos.X, .users(LoopC).PreviousPos.Y, True)
            End If

        Next LoopC

        Call ClearEventMap
        TOURNAMENT_ACTIVE = 0

    End With

End Sub

Private Sub ClearEventMap()

    Dim Map As Integer

    With Events
        Map = MapsEvent.Map

        .Active = False
        .EventStarted = False

        .Quotas = 0
        .Entered = 0
        .Inscription = 0
        .PrizeGLD = 0
        .PrizePoints = 0


        .EventName = vbNullString
        .Rounds = 0
        .TimeRemaining = 0
        .TimeAtacking = 0
        .eventIndex = 0

        Erase .users()
    End With

    Cofres_OpenedLeft = 0

    If MapaValido(Map) Then
        Dim X As Long, Y As Long

        For Y = MinYBorder To MaxYBorder
            For X = MinXBorder To MaxXBorder
                If MapData(Map, X, Y).ObjInfo.ObjIndex > 0 Then
                    If MapData(Map, X, Y).TileExit.Map < 1 Then
                        If Not EsObjetoFijo(ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).OBJType) Then
                            MapData(Map, X, Y).ObjInfo.ObjIndex = 0
                            MapData(Map, X, Y).ObjInfo.Amount = 0

                            Select Case MapData(Map, X, Y).ObjInfo.ObjIndex
                            Case Cofre_Close, Cofre_Open
                                MapData(Map, X, Y).Blocked = 0
                            End Select
                        End If
                    End If
                End If
            Next X
        Next Y
    End If

End Sub

Public Sub EventPassSecond()

    If Not Events.EventStarted Then Exit Sub

    If Events.TimeAtacking > 0 Then
        Events.TimeAtacking = Events.TimeAtacking - 1

        If Events.TimeAtacking < 1 Then

            Dim LoopC As Long, N As Integer

            For LoopC = 1 To Events.Quotas
                N = Events.users(LoopC).UI
                If N > 0 Then
                    Call WritePauseToggle(N)
                End If
            Next LoopC

        End If
    End If

End Sub

Private Function FindFreeSlot() As Byte

    Dim LoopC As Long

    For LoopC = 1 To Events.Quotas
        If Events.users(LoopC).UI < 1 Then
            FindFreeSlot = LoopC
            Exit Function
        End If
    Next LoopC

End Function

Private Function FindTeamIndex(ByVal Slot_ID As Byte) As Byte

    If Slot_ID Mod 2 = 0 Then
        FindTeamIndex = 0
    Else
        FindTeamIndex = 1
    End If

End Function

Public Sub EnterEvent(ByVal UI As Integer)

    If Not CanEnterEvent(UI) Then Exit Sub

    Dim Freeslot As Byte
    Freeslot = FindFreeSlot

    If Freeslot < 1 Then Exit Sub

    UserList(UI).Slot_ID = Freeslot

    With Events
        .Entered = .Entered + 1
        .users(Freeslot).UI = UI
        .users(Freeslot).PreviousPos = UserList(UI).Pos

        If UserList(UI).Stats.minSta > 0 Then
            Call QuitarSta(UI, UserList(UI).Stats.minSta)
        End If

        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Has ingresado a los juegos del hambre." & vbNewLine & "Tus items fueron guardados correctamente.", FontTypeNames.FONTTYPE_INFO)
        Call WritePauseToggle(UI)

        Call SaveInventory(Freeslot)
        Call DarCuerpoDesnudo(UI)
        Call WarpUserCharX(UI, MapsEvent.Map, MapsEvent.X, MapsEvent.Y)

        If .Inscription > 0 Then
            UserList(UI).Stats.GLD = UserList(UI).Stats.GLD - .Inscription
            Call WriteUpdateGold(UI)
        End If

        Call SendData(SendTarget.toMap, MapsEvent.Map, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UI).Name & " ingresó al Torneo!", FontTypeNames.FONTTYPE_INFO))

        If .Entered >= .Quotas Then
            .EventStarted = True

            Call SendData(SendTarget.toMap, MapsEvent.Map, PrepareMessageCuentaRegresiva(.TimeAtacking))

            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El cupo ha sido completado.", FontTypeNames.FONTTYPE_DIOS))

            Call SettedCofres
            Call WarpToRandomMap

        End If

        UserList(UI).flags.EnEvento = 4

    End With

End Sub

Private Function CanEnterEvent(ByVal UI As Integer) As Boolean
    If Not Events.Active Then
        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "El evento no está en curso.", FontTypeNames.FONTTYPE_EVENTOS)
        Exit Function
    End If
    If Events.EventStarted Then
        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "El evento ya no tiene cupos disponibles.", FontTypeNames.FONTTYPE_EVENTOS)
        Exit Function
    End If

    With UserList(UI)

        If .flags.EnEvento > 0 Then Exit Function

        Dim i As Long

        For i = 1 To NUMCLASES
            If Events.ClasesValidas(i) = 1 And .Clase = i Then
                Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Tu clase no esta permitida en este evento.", FontTypeNames.FONTTYPE_EVENTOS)
                Exit Function
            End If
        Next i

        If .Stats.GLD < Events.Inscription Then
            Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "No tienes el oro suficiente.", FontTypeNames.FONTTYPE_EVENTOS)
            Exit Function
        End If

    End With
    CanEnterEvent = True
End Function

Private Sub RestoreStatsEvent(ByVal UI As Integer)

    With UserList(UI)

        If .Stats.MinHP <> .Stats.MaxHP Then
            .Stats.MinHP = .Stats.MaxHP
            Call WriteUpdateHP(UI)
        End If

        If .flags.Muerto > 0 Then
            .flags.Muerto = 0

            Call DarCuerpoDesnudo(UI)
            .Char.Head = .OrigChar.Head
            Call ChangeUserChar(UI, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
        End If

        If .Stats.MinMAN <> .Stats.MaxMAN Then
            .Stats.MinMAN = .Stats.MaxMAN
            Call WriteUpdateMana(UI)
        End If

    End With

End Sub

Private Function RandOdd(ByVal LowerBound As Byte, ByVal UpperBound As Byte) As Byte
    Randomize Timer
    RandOdd = Fix(Rnd * (UpperBound - LowerBound + 1)) + LowerBound
    If RandOdd Mod 2 = 0 Then RandOdd = RandOdd - 1
End Function

Private Function RandEven(ByVal LowerBound As Byte, ByVal UpperBound As Byte) As Byte
    Randomize Timer
    RandEven = Fix(Rnd * (UpperBound - LowerBound + 1)) + LowerBound
    If RandEven Mod 2 = 1 Then
        If RandEven = UpperBound Then
            RandEven = LowerBound
        Else
            RandEven = RandEven + 1
        End If
    End If
End Function

Private Sub WarpToRandomMap()

    Dim LoopC As Long, UI As Integer

    With Events
        For LoopC = 1 To .Quotas
            UI = .users(LoopC).UI

            If UI > 0 Then
                'Call WritePauseToggle(UI)

                Call WarpUserCharX(UI, MapsEvent.Map, RandomNumber(MinXBorder, MaxXBorder), RandomNumber(MinYBorder, MaxYBorder), True)


                'Call RestoreStatsEvent(UI)
            End If
        Next LoopC
    End With

End Sub

Private Sub ReturnGold(ByVal UI As Integer)

    If Events.Inscription > 0 Then
        UserList(UI).Stats.GLD = UserList(UI).Stats.GLD + Events.Inscription
        Call WriteUpdateGold(UI)
    End If

End Sub

Private Sub FinishEvent(Optional ByVal WinnerID As Integer = 0, Optional ByVal UserDesconectado As Integer = -1)

    Dim LoopC As Long, N As Integer, StrNames As String

    With Events

        LoopC = IIf(.LastKilled > 0, .LastKilled, GetWinner(UserDesconectado))

        If LoopC < 1 Then
            Call CancelEvent
            Exit Sub
        End If

        Call RestoreInventory(0, 1)

        If UserDesconectado > 0 Then

            UserList(UserDesconectado).flags.EnEvento = 0

            Call WarpUserCharX(UserDesconectado, .users(UserList(UserDesconectado).Slot_ID).PreviousPos.Map, .users(UserList(UserDesconectado).Slot_ID).PreviousPos.X, .users(UserList(UserDesconectado).Slot_ID).PreviousPos.Y, True)
            UserList(UserDesconectado).Slot_ID = 0
        End If


        N = .users(LoopC).UI
        'Call RestoreInventory(LoopC)

        UserList(N).Slot_ID = 0
        UserList(N).flags.EnEvento = 0

        Call WarpUserCharX(N, .users(LoopC).PreviousPos.Map, .users(LoopC).PreviousPos.X, .users(LoopC).PreviousPos.Y, True)
        Call GivePrizes(N, .PrizeGLD, .PrizePoints)

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganador del evento: " & UserList(N).Name & " se lleva una cantidad de " & .PrizeGLD & " monedas de oro, " & IIf(.PrizePoints, .PrizePoints & " Puntos de Canje", "") & ". Felicitaciones!", FontTypeNames.FONTTYPE_DIOS))
        Call LogGM("JDH_WIN", UserList(N).Name & " ganó los juegos del hambre de " & .Quotas & " cupos y gano " & .PrizePoints & " canjes y " & .PrizeGLD & " de oro")

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El evento ha finalizado.", FontTypeNames.FONTTYPE_DIOS))



        TOURNAMENT_ACTIVE = 0
        NOMBRE_TORNEO_ACTUAL = ""

    End With

    Call ClearEventMap

End Sub

Private Function GetWinner(Optional ByVal UI_Desconectado As Integer = -1) As Byte

    Dim LoopC As Long

    For LoopC = 1 To Events.Quotas
        If Events.users(LoopC).UI > 0 Then
            If UserList(Events.users(LoopC).UI).Pos.Map = MapsEvent.Map And Events.users(LoopC).UI <> UI_Desconectado Then
                GetWinner = LoopC
                Exit Function
            End If
        End If
    Next LoopC

End Function

Public Sub SetKilled(ByVal Slot_ID As Byte)
    If Events.Entered < 3 Then
        Events.LastKilled = Slot_ID
    End If
End Sub

Public Sub EventDie(ByVal Slot_ID As Byte)

    Dim UI As Integer
    Dim Team_Losser_ID As Byte
    Dim Team_Winner_ID As Byte

    With Events

        UI = .users(Slot_ID).UI
        If UI < 1 Then Exit Sub

        Call TirarTodosLosItems(UI, UserList(UI).Pos.Map, UserList(UI).Pos.X, UserList(UI).Pos.Y)
        Call RestoreInventory(Slot_ID)
        Call RestoreStatsEvent(UI)
        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Has sido derrotado en los juegos del hambre.", FontTypeNames.FONTTYPE_INFO)
        Call SendData(SendTarget.toMap, MapsEvent.Map, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UI).Name & " ha sido derrotado.", FontTypeNames.FONTTYPE_DIOS))
        Call WarpUserCharX(UI, .users(Slot_ID).PreviousPos.Map, .users(Slot_ID).PreviousPos.X, .users(Slot_ID).PreviousPos.Y, True)

        If Slot_ID >= .Quotas Then
            .Quotas = .Quotas - 1
        End If

        UserList(UI).flags.EnEvento = 0

        .users(Slot_ID).UI = 0
        .users(Slot_ID).Deaths = 0
        .users(Slot_ID).Killed = 0
        .users(Slot_ID).Points = 0

        If .Entered > 0 Then
            .Entered = .Entered - 1

            If .Entered < 2 Then
                Call FinishEvent(0, .users(Slot_ID).UI)
            End If
        End If

        UserList(UI).Slot_ID = 0
    End With

End Sub

Public Sub EventDisconnect(ByVal Slot_ID As Byte)

    Dim UI As Integer
    Dim Team_Losser_ID As Byte
    Dim Team_Winner_ID As Byte

    With Events

        UI = .users(Slot_ID).UI
        If UI < 1 Then Exit Sub

        .users(Slot_ID).Deaths = 0
        .users(Slot_ID).Killed = 0
        .users(Slot_ID).Points = 0

        UserList(UI).flags.EnEvento = 0

        If .EventStarted Then
            If .Entered > 2 Then
                Call TirarTodosLosItems(UI, UserList(UI).Pos.Map, UserList(UI).Pos.X, UserList(UI).Pos.Y)
                Call SendData(SendTarget.toMap, MapsEvent.Map, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UI).Name & " abandona los juegos del hambre.", FontTypeNames.FONTTYPE_DIOS))
            Else
                Call FinishEvent(0, UI)
                Exit Sub
            End If
        Else
            Call ReturnGold(UI)
        End If

        Call WarpUserCharX(UI, .users(Slot_ID).PreviousPos.Map, .users(Slot_ID).PreviousPos.X, .users(Slot_ID).PreviousPos.Y, True)
        Call RestoreInventory(Slot_ID)

        If Slot_ID >= .Quotas Then
            .Quotas = .Quotas - 1
        End If

        If .Entered > 0 Then
            .Entered = .Entered - 1
        End If

        .users(Slot_ID).UI = 0

    End With

    UserList(UI).Slot_ID = 0
    UserList(UI).flags.EnEvento = 0

    Call WritePauseToggle(UI)


End Sub

Private Sub RestoreInventory(ByVal Slot_ID As Byte, Optional ByVal ALL As Boolean = False)

    Dim UI As Integer

    If ALL Then
        Dim i As Long

        For i = LBound(Events.users()) To UBound(Events.users())

            UI = Events.users(i).UI
            If Not UI < 1 Then

                UserList(UI).Char.body = Events.users(UI).LastChar.body
                UserList(UI).Char.CascoAnim = Events.users(UI).LastChar.CascoAnim
                UserList(UI).Char.WeaponAnim = Events.users(UI).LastChar.WeaponAnim
                UserList(UI).Char.ShieldAnim = Events.users(UI).LastChar.ShieldAnim
                UserList(UI).Invent = Events.users(UI).InventTempJDH

                Call UpdateUserInvAll(UI)
            End If

        Next i
    Else
        UI = Events.users(Slot_ID).UI

        If UI < 1 Then Exit Sub

        With Events.users(Slot_ID)
            UserList(UI).Char.body = .LastChar.body
            UserList(UI).Char.CascoAnim = .LastChar.CascoAnim
            UserList(UI).Char.WeaponAnim = .LastChar.WeaponAnim
            UserList(UI).Char.ShieldAnim = .LastChar.ShieldAnim
            UserList(UI).Invent = .InventTempJDH
        End With
        Call UpdateUserInvAll(UI)
    End If


End Sub

Sub UpdateUserInvAll(ByVal UserIndex As Integer)

    Dim NullObj As UserOBJ
    Dim LoopC As Long
    For LoopC = 1 To UserList(UserIndex).CurrentInventorySlots
        If UserList(UserIndex).Invent.Object(LoopC).ObjIndex > 0 Then
            Call ChangeUserInv(UserIndex, LoopC, UserList(UserIndex).Invent.Object(LoopC))
        Else
            Call ChangeUserInv(UserIndex, LoopC, NullObj)
        End If
    Next LoopC

End Sub
Private Sub SaveInventory(ByVal Slot_ID As Byte)

    Dim UI As Integer
    UI = Events.users(Slot_ID).UI

    If UI < 1 Then Exit Sub

    With Events.users(Slot_ID)
        .LastChar.body = UserList(UI).Char.body
        .LastChar.CascoAnim = UserList(UI).Char.CascoAnim
        .LastChar.WeaponAnim = UserList(UI).Char.WeaponAnim
        .LastChar.ShieldAnim = UserList(UI).Char.ShieldAnim
        .InventTempJDH = UserList(UI).Invent
    End With

    UserList(UI).Char.CascoAnim = 0
    UserList(UI).Char.WeaponAnim = 0
    UserList(UI).Char.ShieldAnim = 0

    Call LimpiarInventario(UI)
    Call UpdateUserInvAll(UI)

End Sub


Public Sub DoubleClickCofre(ByRef Pos As WorldPos, ByVal Slot_ID As Byte)

    Dim UI As Integer
    UI = Events.users(Slot_ID).UI

    If UI < 1 Then Exit Sub

    If Cofres_OpenedLeft = 0 Then
        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Ya se abrieron todos los cofres!", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    Select Case MapData(Pos.Map, Pos.X, Pos.Y).ObjInfo.ObjIndex

    Case Cofre_Close

        If distancia(UserList(UI).Pos, Pos) > 3 Then
            Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Debes estar mas cerca para abrir el cofre.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        Dim Clase As Byte

        If RandomNumber(1, 100) < 50 Then
            Clase = UserList(UI).Clase
        Else
            Clase = RandomNumber(1, NUMCLASES - 2)
        End If

        Dim n_Pos As WorldPos
        Dim MiObj As Obj

        MiObj.ObjIndex = IIf(UserList(UI).raza < eRaza.Gnomo, 31, 240)
        MiObj.Amount = 1

        Call Tilelibre(Pos, n_Pos, MiObj, False, True)
        Call MakeObj(MiObj, n_Pos.Map, n_Pos.X, n_Pos.Y)

        If CofresJDH(Clase).Cant > 0 Then
            MapData(Pos.Map, Pos.X, Pos.Y).ObjInfo.ObjIndex = 10
            Call modSendData.SendToAreaByPos(Pos.Map, Pos.X, Pos.Y, PrepareMessageObjectCreate(502, Pos.X, Pos.Y))

            Dim LoopC As Long

            For LoopC = 1 To CofresJDH(Clase).Cant
                Call Tilelibre(Pos, n_Pos, CofresJDH(Clase).Object(LoopC), False, True)
                Call MakeObj(CofresJDH(Clase).Object(LoopC), n_Pos.Map, n_Pos.X, n_Pos.Y)
            Next LoopC

            Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Has abierto un cofre.", FontTypeNames.FONTTYPE_INFO)

            If Cofres_OpenedLeft > 0 Then
                Cofres_OpenedLeft = Cofres_OpenedLeft - 1

                If Cofres_OpenedLeft < 1 Then
                    Call SendData(SendTarget.toMap, MapsEvent.Map, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "¡Todos los cofres han sido abiertos!", FontTypeNames.FONTTYPE_DIOS))
                    Exit Sub
                End If
            End If
        End If

    Case Cofre_Open
        Call WriteConsoleMsg(UI, "Este cofre ya fue abierto.", FontTypeNames.FONTTYPE_INFO)

    Case Else
        Exit Sub

    End Select

End Sub

Public Sub LoadJDH()

    On Error Resume Next

    Dim LoopC As Long
    Dim values() As String

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "Torneo_JDH.dat")
    
    Dim sTemp As String
    sTemp = Leer.GetValue("JDH", "Waiting")

    With MapsEvent
        .Map = CInt(ReadField(1, sTemp, 45))
        .X = CByte(ReadField(2, sTemp, 45))
        .Y = CByte(ReadField(3, sTemp, 45))
    End With

    Dim j As Long, Str As String

    For LoopC = 1 To NUMCLASES - 2
        With CofresJDH(LoopC)
            If LoopC <> 5 And LoopC <> 8 Then
                .Cant = val(Leer.GetValue(ListaClases(LoopC), "Cant"))

                If .Cant > 0 Then
                    ReDim .Object(1 To .Cant) As Obj

                    For j = 1 To .Cant
                        Str = Leer.GetValue(ListaClases(LoopC), "Obj" & j)

                        .Object(j).ObjIndex = CInt(ReadField(1, Str, 45))
                        .Object(j).Amount = CInt(ReadField(2, Str, 45))
                    Next j
                End If
            End If
        End With
    Next LoopC

    Set Leer = Nothing

End Sub

Private Sub SettedCofres()

    Dim Map As Integer, X As Byte, Y As Byte, CantCofres As Byte

    CantCofres = Events.Quotas * 3
    Map = MapsEvent.Map
    Cofres_OpenedLeft = CantCofres

    Do
        X = RandomNumber(MinXBorder, MaxYBorder)
        Y = RandomNumber(MinYBorder, MaxYBorder)

        If MapData(Map, X, Y).Blocked < 1 Then
            If MapData(Map, X, Y).ObjInfo.ObjIndex < 1 Then
                If Not HayAgua(Map, X, Y) Then
                    MapData(Map, X, Y).Blocked = 1
                    Call Bloquear(True, Map, X, Y, True)

                    MapData(Map, X, Y).ObjInfo.ObjIndex = 11
                    MapData(Map, X, Y).ObjInfo.Amount = 1

                    CantCofres = CantCofres - 1
                    If CantCofres < 1 Then Exit Do
                End If
            End If
        End If
    Loop

End Sub

Private Sub GivePrizes(ByVal UI As Integer, ByVal gold As Long, ByVal Points As Long)

    Dim Str As String

    With UserList(UI)

        If gold > 0 Then
            .Stats.GLD = .Stats.GLD + gold
            If .Stats.GLD > MAXORO Then .Stats.GLD = MAXORO

            Call WriteUpdateGold(UI)
            Str = gold & " monedas de oro"
        End If


        If LenB(Str) > 0 Then
            Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Has ganado " & Format$(Str, "###,###,###") & " como recompensa.", FontTypeNames.FONTTYPE_INFO)
        End If

    End With

End Sub

