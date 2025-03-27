Attribute VB_Name = "m_TorneoXvsX"
Option Explicit

Private TAG_EVENT As String

Private Type tUsers
    UI As Integer
    PreviousPos As WorldPos
    PosKit As Position
    LastChar As Char
End Type

Private Type tTeams
    users() As tUsers
    Deaths As Byte
    Wins As Byte
    Counters As Byte
    PlayersDie As Byte
End Type

Private Type tEvent
    Active As Boolean
    Started As Boolean
    Quotas As Byte
    Sleep As Byte
    KitsNum(1 To 2) As tTeams
    Inscription As Long

    Oro As Long
    Puntos As Byte
    CaenItems As Boolean

    TimeAtacking As Byte
    MaxVic As Byte
    MaxRounds As Byte
    VoucherResu As Byte
    ClasesValidas(1 To NUMCLASES) As eClass
    MinLevel As Byte
    Maxlevel As Byte

End Type

Private KITS_MAP As Integer
Private KITS_ROOM As WorldPos
Private KITS_CORNERS(0 To 1) As Position

Public Evento As tEvent

Public Sub LoadPosXvsX()

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "Evento_GanaSigue.dat")

    KITS_MAP = CInt(Leer.GetValue("INIT", "Mapa"))

    KITS_ROOM.Map = CInt(Leer.GetValue("INIT", "Waiting_Room"))
    KITS_ROOM.X = CByte(Leer.GetValue("INIT", "Waiting_X"))
    KITS_ROOM.Y = CByte(Leer.GetValue("INIT", "Waiting_Y"))

    KITS_CORNERS(0).X = CByte(Leer.GetValue("INIT", "X1"))
    KITS_CORNERS(0).Y = CByte(Leer.GetValue("INIT", "Y1"))

    KITS_CORNERS(1).X = CByte(Leer.GetValue("INIT", "X2"))
    KITS_CORNERS(1).Y = CByte(Leer.GetValue("INIT", "Y2"))

    Set Leer = Nothing

End Sub

Private Sub GivePositionsXvsX()

    Dim LoopX As Long, count(0 To 1) As Byte

    With Evento

        If (.Quotas < 2) Then

            .KitsNum(1).users(1).PosKit.X = KITS_CORNERS(0).X
            .KitsNum(1).users(1).PosKit.Y = KITS_CORNERS(0).Y

            .KitsNum(2).users(1).PosKit.X = KITS_CORNERS(1).X
            .KitsNum(2).users(1).PosKit.Y = KITS_CORNERS(1).Y

        Else

            Dim Extra As Byte
            Extra = CByte(.Quotas / 2.5)

            .KitsNum(1).users(1).PosKit.X = KITS_CORNERS(0).X - Extra
            .KitsNum(2).users(1).PosKit.X = KITS_CORNERS(1).X + Extra

            .KitsNum(1).users(1).PosKit.Y = KITS_CORNERS(0).Y - Extra
            .KitsNum(2).users(1).PosKit.Y = KITS_CORNERS(1).Y + Extra

            For LoopX = 2 To .Quotas

                .KitsNum(1).users(LoopX).PosKit.Y = .KitsNum(1).users(1).PosKit.Y
                .KitsNum(2).users(LoopX).PosKit.Y = .KitsNum(2).users(1).PosKit.Y

                If LoopX Mod 2 <> 0 Then
                    count(0) = count(0) + 1

                    .KitsNum(1).users(LoopX).PosKit.X = .KitsNum(1).users(1).PosKit.X + count(0)
                    .KitsNum(2).users(LoopX).PosKit.X = .KitsNum(2).users(1).PosKit.X - count(0)
                Else
                    .KitsNum(1).users(LoopX).PosKit.Y = .KitsNum(1).users(LoopX).PosKit.Y + 1
                    .KitsNum(2).users(LoopX).PosKit.Y = .KitsNum(2).users(LoopX).PosKit.Y - 1

                    .KitsNum(1).users(LoopX).PosKit.X = .KitsNum(1).users(1).PosKit.X + count(1)
                    .KitsNum(2).users(LoopX).PosKit.X = .KitsNum(2).users(1).PosKit.X - count(1)

                    count(1) = count(1) + 1
                End If

            Next LoopX



        End If

        Dim X As Long, Y As Long

        For X = .KitsNum(1).users(1).PosKit.X - 1 To .KitsNum(2).users(1).PosKit.X + 1

            ' Arriba
            MapData(KITS_MAP, X, (.KitsNum(1).users(1).PosKit.Y) - 1).Blocked = 1

            ' Abajo
            MapData(KITS_MAP, X, (.KitsNum(2).users(1).PosKit.Y) + 1).Blocked = 1

        Next X

        For Y = .KitsNum(1).users(1).PosKit.Y To .KitsNum(2).users(1).PosKit.Y

            ' Lateral Izquierdo
            MapData(KITS_MAP, .KitsNum(1).users(1).PosKit.X - 1, Y).Blocked = 1

            ' Lateral Derecho
            MapData(KITS_MAP, .KitsNum(2).users(1).PosKit.X + 1, Y).Blocked = 1

        Next Y

    End With

End Sub

Private Sub Event_Clear(ByVal KitWinner As Byte)

    Dim LoopC As Long, N As Integer, Ganadores As String

    With Evento

        For LoopC = 1 To .Quotas

            N = .KitsNum(KitWinner).users(LoopC).UI

            If N > 0 Then

                UserList(N).XvsX.Slot_ID = 0
                UserList(N).XvsX.Team_ID = 0
                UserList(N).flags.EnEvento = 0

                UserList(N).Stats.GLD = UserList(N).Stats.GLD + Evento.Oro: If UserList(N).Stats.GLD > MAXORO Then UserList(N).Stats.GLD = MAXORO
                WriteUpdateGold N
                WriteConsoleMsg N, "¡Felicitaciones por el 1° lugar!. Se te entregó el premio de " & Evento.Oro & " monedas de oro.", FontTypeNames.FONTTYPE_EVENTOS

                'UserList(N).Stats.Torneos2vs2Ganados = UserList(N).Stats.Torneos2vs2Ganados + 1
                'Call m_Ranking.CheckRankingUser(N, TopTorneo2vs2)

                Call LogDesarrollo(UserList(N).Name & " ganó un " & TAG_EVENT & " y gano " & .Oro & " monedas de oro.")

                If .TimeAtacking > 0 Then
                    Call WritePauseToggle(N)
                End If

                Call WarpUserCharX(N, .KitsNum(KitWinner).users(LoopC).PreviousPos.Map, .KitsNum(KitWinner).users(LoopC).PreviousPos.X, .KitsNum(KitWinner).users(LoopC).PreviousPos.Y, True)

                Ganadores = Ganadores & UserList(N).Name & ", "

            End If

        Next LoopC

        If .Quotas > 1 Then
            If KitWinner > 0 Then
                If Len(Ganadores) > 1 Then Ganadores = mid$(Ganadores, 1, Len(Ganadores) - 2)

                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "GANADOR EQUIPO #" & KitWinner & ", cada participante gana " & .Oro & " monedas de oro" & IIf(.Puntos > 0, " y " & .Puntos & " Puntos de Canje", "") & ".", FontTypeNames.FONTTYPE_DIOS))
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganadores: " & Ganadores & ".", FontTypeNames.FONTTYPE_DIOS))
            End If
        Else
            If N > 0 Then
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganador del torneo " & UserList(N).Name & ", gana " & .Oro & " monedas de oro.", FontTypeNames.FONTTYPE_DIOS))
            End If
        End If

    End With

    Call ClearEventMap

End Sub

Public Sub CreateXvsX(ByVal Quotas As Byte, ByVal Inscription As Long, ByVal Prize As Long, ByVal Puntos As Byte, ByVal CaenItems As Boolean, ByVal MaxVic As Byte, ByVal MaxRounds As Byte, ByVal VoucherResu As Byte, ByVal MinLevel As Byte, ByVal Maxlevel As Byte, ByVal cMago As Byte, ByVal cClerigo As Byte, ByVal cGuerrero As Byte, ByVal cAsesino As Byte, ByVal cLadron As Byte, ByVal cBardo As Byte, ByVal cDruida As Byte, ByVal cBandido As Byte, ByVal cPaladin As Byte, ByVal cCazador As Byte, ByVal cTrabajador As Byte, ByVal cPirata As Byte)

    If Inscription < 0 Then Inscription = 0
    If Prize < 0 Then Prize = 0
    If Puntos < 0 Then Puntos = 0
    If MaxVic < 1 Then MaxVic = 1
    If MaxRounds < 1 Then MaxRounds = 1
    If VoucherResu > 1 Then VoucherResu = 1


    KITS_ROOM.Map = 198

    If Quotas < 1 Then Quotas = 1
    TAG_EVENT = Quotas & "vs" & Quotas

    If Prize < 1 Then
        Prize = Inscription * (MaxVic + 1)
    End If

    With Evento
        .Active = True
        .Started = False
        .Quotas = Quotas
        .Inscription = Inscription
        .Oro = Prize
        .Puntos = Puntos
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel

        .CaenItems = CaenItems
        .MaxVic = MaxVic
        .MaxRounds = MaxRounds
        .VoucherResu = VoucherResu

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
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel

        ReDim .KitsNum(1).users(1 To Quotas) As tUsers
        ReDim .KitsNum(2).users(1 To Quotas) As tUsers

    End With

    Call GivePositionsXvsX
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "MaxVic: " & MaxVic & ". " & IIf(MaxRounds > 1, "Al mejor de " & MaxRounds & " rounds", "A un round") & IIf(Quotas > 1, IIf(VoucherResu > 0, " (Vale resu),", " (No vale resu),"), ".") & " Para ingresar escribe /PARTICIPAR", FontTypeNames.FONTTYPE_DIOS))
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & IIf(Prize > 0, "El premio es de " & Prize & " monedas de oro.", "No hay premio.") & IIf(Inscription > 0, " El costo de inscripción es de " & Inscription & " monedas de oro.", " No hay costo de inscripción."), FontTypeNames.FONTTYPE_DIOS))

    If T Then
        SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Clases prohibidas: " & IIf(cMago > 0, " MAGO ", "") & IIf(cClerigo > 0, " CLERIGO ", "") & IIf(cBardo > 0, " BARDO ", "") & IIf(cPaladin > 0, " PALADIN ", "") & IIf(cAsesino > 0, " ASESINO ", "") & IIf(cCazador > 0, " CAZADOR ", "") & IIf(cGuerrero > 0, " GUERRERO ", "") & IIf(cDruida > 0, " DRUIDA ", "") & IIf(cLadron > 0, " LADRON ", "") & IIf(cBandido > 0, " BANDIDO ", "") & IIf(cTrabajador > 0, " TRABAJADOR ", "") & IIf(cPirata > 0, " PIRATA ", ""), FontTypeNames.FONTTYPE_INFOBOLD)
    End If


End Sub

Private Sub ClearEventMap()

    Dim LoopX As Long, LoopY As Long

    With Evento

        For LoopX = .KitsNum(1).users(1).PosKit.X - 1 To .KitsNum(2).users(1).PosKit.X + 1
            For LoopY = .KitsNum(1).users(1).PosKit.Y - 1 To .KitsNum(2).users(1).PosKit.Y + 1
                If MapData(KITS_MAP, LoopX, LoopY).ObjInfo.ObjIndex > 0 Then
                    Call EraseObj(MapData(KITS_MAP, LoopX, LoopY).ObjInfo.Amount, KITS_MAP, LoopX, LoopY)
                End If
            Next LoopY
        Next LoopX

        .Active = False
        .Started = False
        .Quotas = 0
        .Inscription = 0
        .Oro = 0
        .TimeAtacking = 0
        .MaxVic = 0
        .MaxRounds = 0
        .VoucherResu = 0
        .CaenItems = False
        .Puntos = 0

        Erase .KitsNum

    End With

End Sub

Public Sub CancelXvsX()

    Dim i As Long, j As Long, N As Integer

    With Evento

        For i = 1 To 2

            For j = 1 To .Quotas

                N = .KitsNum(i).users(j).UI

                If N > 0 Then

                    UserList(N).XvsX.Slot_ID = 0
                    UserList(N).XvsX.Team_ID = 0
                    UserList(N).flags.EnEvento = 0

                    If .Inscription > 0 Then
                        UserList(N).Stats.GLD = UserList(N).Stats.GLD + .Inscription
                        Call WriteUpdateGold(N)
                        Call WriteConsoleMsg(N, "Se te ha devuelto el costo de la inscripción.", FontTypeNames.FONTTYPE_INFO)
                    End If

                    If .TimeAtacking > 0 Then
                        Call WritePauseToggle(N)
                    End If

                    Call WarpUserCharX(N, .KitsNum(i).users(j).PreviousPos.Map, .KitsNum(i).users(j).PreviousPos.X, .KitsNum(i).users(j).PreviousPos.Y, True)

                End If

            Next j

        Next i

    End With

    Call ClearEventMap
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El evento ha sido cancelado.", FontTypeNames.FONTTYPE_DIOS))

End Sub

Public Sub RestoreCharAndRevive(ByVal UI As Integer)

    Dim Slot_ID As Byte
    Dim Team_ID As Byte

    Slot_ID = UserList(UI).XvsX.Slot_ID
    If Slot_ID < 1 Then Exit Sub

    Team_ID = UserList(UI).XvsX.Team_ID
    If Team_ID < 1 Then Exit Sub

    With Evento.KitsNum(Team_ID).users(Slot_ID)
        UserList(UI).Char.body = .LastChar.body
        UserList(UI).Char.CascoAnim = .LastChar.CascoAnim
        UserList(UI).Char.WeaponAnim = .LastChar.WeaponAnim
        UserList(UI).Char.ShieldAnim = .LastChar.ShieldAnim
    End With

    With UserList(UI)

        If .Stats.MinHP <> .Stats.MaxHP Then
            .Stats.MinHP = .Stats.MaxHP
            Call WriteUpdateHP(UI)
        End If

        If .Stats.minSta <> .Stats.MaxSta Then
            .Stats.minSta = .Stats.MaxSta
            Call WriteUpdateSta(UI)
        End If

        If .Stats.MinMAN <> .Stats.MaxMAN Then
            .Stats.MinMAN = .Stats.MaxMAN
            Call WriteUpdateMana(UI)
        End If

        If .flags.Muerto > 0 Then
            .flags.Muerto = 0
            .Char.Head = .OrigChar.Head
        End If

        Call WarpUserCharX(UI, KITS_ROOM.Map, Evento.KitsNum(2).users(Slot_ID).PosKit.X - RandomNumber(4, 10), Evento.KitsNum(2).users(Slot_ID).PosKit.Y - RandomNumber(1, 3), True)

    End With

End Sub

Public Sub SaveCharXvsX(ByVal UI As Integer)

    Dim Slot_ID As Byte
    Dim Team_ID As Byte

    Slot_ID = UserList(UI).XvsX.Slot_ID
    If Slot_ID < 1 Then Exit Sub

    Team_ID = UserList(UI).XvsX.Team_ID
    If Team_ID < 1 Then Exit Sub

    With Evento.KitsNum(Team_ID).users(Slot_ID)
        .LastChar.body = UserList(UI).Char.body
        .LastChar.CascoAnim = UserList(UI).Char.CascoAnim
        .LastChar.WeaponAnim = UserList(UI).Char.WeaponAnim
        .LastChar.ShieldAnim = UserList(UI).Char.ShieldAnim
    End With

End Sub

Private Sub Start_Event(ByVal IsRespawn As Boolean)

    Dim i As Long, j As Long, N As Integer
    Dim TeamNames(0 To 1) As String

    With Evento

        .TimeAtacking = 5

        .KitsNum(1).PlayersDie = 0
        .KitsNum(2).PlayersDie = 0

        For i = 1 To 2

            For j = 1 To .Quotas

                N = .KitsNum(i).users(j).UI

                If N > 0 Then

                    If UserList(N).flags.Muerto <> 0 Then

                        Call RevivirUsuario(N)

                        UserList(N).Stats.MinHP = UserList(N).Stats.MaxHP
                        UserList(N).Stats.MinMAN = UserList(N).Stats.MaxMAN
                        UserList(N).Stats.minSta = UserList(N).Stats.MaxSta

                        Call WriteUpdateUserStats(N)

                    End If

                    Call WritePauseToggle(N)

                    If UserList(N).XvsX.Team_ID <> 1 Then
                        TeamNames(1) = TeamNames(1) & UserList(N).Name & ", "
                        UserList(N).Char.Heading = eHeading.WEST

                    Else
                        TeamNames(0) = TeamNames(0) & UserList(N).Name & ", "
                        UserList(N).Char.Heading = eHeading.EAST
                    End If

                    Call WarpUserCharX(N, KITS_ROOM.Map, .KitsNum(i).users(j).PosKit.X, .KitsNum(i).users(j).PosKit.Y, True)

                End If

            Next j
        Next i

        If Len(TeamNames(0)) > 1 Then TeamNames(0) = mid$(TeamNames(0), 1, Len(TeamNames(0)) - 2)
        If Len(TeamNames(1)) > 1 Then TeamNames(1) = mid$(TeamNames(1), 1, Len(TeamNames(1)) - 2)

        If IsRespawn Then
            Call SendData(SendTarget.toMap, KITS_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Resultado parcial: " & vbNewLine & IIf(.Quotas > 1, "Equipo#1 ", TeamNames(0) & " ") & .KitsNum(2).Deaths & " - " & IIf(.Quotas > 1, "Equipo#2 ", TeamNames(1) & " ") & .KitsNum(1).Deaths, FontTypeNames.FONTTYPE_DIOS))
        Else
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & TeamNames(0) & " vs " & TeamNames(1) & ".", FontTypeNames.FONTTYPE_DIOS))
        End If

        MapInfo(KITS_MAP).ResuSinEfecto = IIf(.VoucherResu > 0, 0, 1)

        Call SendData(SendTarget.toMap, KITS_MAP, PrepareMessageCuentaRegresiva(.TimeAtacking))



    End With

End Sub

Public Sub MuereUserInxVsX(ByVal UI As Integer)

    Dim UserKit As Byte
    UserKit = UserList(UI).XvsX.Team_ID

    If UserKit < 1 Then Exit Sub

    With Evento

        .KitsNum(UserKit).PlayersDie = .KitsNum(UserKit).PlayersDie + 1
        If .KitsNum(UserKit).PlayersDie < .Quotas Then Exit Sub

        .KitsNum(UserKit).Deaths = .KitsNum(UserKit).Deaths + 1

        If .KitsNum(UserKit).Deaths < .MaxRounds Then
            Call Start_Event(True)
        Else

            If IIf(UserKit = 1, 2, 1) = 2 Then
                Call SendToUlla(1)
                Call ChangeTeamXvsX
            Else
                Call SendToUlla(2)
            End If

            Call Event_Win(1)
        End If

    End With

End Sub

Private Sub ChangeTeamXvsX()

    Dim LoopC As Long, N As Integer, tmpPos As Position

    With Evento

        .TimeAtacking = 0

        If .KitsNum(2).Counters > 0 Then

            For LoopC = 1 To .KitsNum(2).Counters

                N = .KitsNum(2).users(LoopC).UI

                If N > 0 Then

                    UserList(N).XvsX.Slot_ID = LoopC
                    UserList(N).XvsX.Team_ID = 1

                    tmpPos = .KitsNum(1).users(LoopC).PosKit

                    .KitsNum(1).users(LoopC).UI = .KitsNum(2).users(LoopC).UI
                    .KitsNum(1).users(LoopC).PreviousPos = .KitsNum(2).users(LoopC).PreviousPos

                    .KitsNum(1).users(LoopC).PosKit = .KitsNum(2).users(LoopC).PosKit
                    .KitsNum(2).users(LoopC).PosKit = tmpPos

                    .KitsNum(2).users(LoopC).UI = 0

                End If

            Next LoopC
        End If

        .KitsNum(2).Wins = 0
        .KitsNum(2).Deaths = 0
        .KitsNum(2).Counters = 0

        .KitsNum(1).Wins = 0
        .KitsNum(1).Deaths = 0

    End With

End Sub

Public Sub DisconnectXvsX(ByVal UI As Integer)

    Dim UserKit As Byte
    UserKit = UserList(UI).XvsX.Team_ID

    If UserKit < 1 Then Exit Sub

    With Evento

        ' ++ Si estan en sala de espera.
        If .Started Then

            If .KitsNum(UserKit).Counters > 0 Then
                .KitsNum(UserKit).Counters = .KitsNum(UserKit).Counters - 1
                If .KitsNum(UserKit).Counters < 1 Then
                    .KitsNum(UserKit).Deaths = 0
                    .KitsNum(UserKit).Wins = 0
                End If
            End If

        Else

            .KitsNum(UserKit).PlayersDie = .KitsNum(UserKit).PlayersDie + 1

            If .KitsNum(UserKit).PlayersDie >= .Quotas Then
                Call SendToUlla(UserKit)

                If UserKit <> 2 Then
                    Call ChangeTeamXvsX
                End If

                Call Event_Win(1)
                Exit Sub
            End If

        End If

        Dim Slot_ID As Byte
        Slot_ID = UserList(UI).XvsX.Slot_ID

        If Slot_ID > 0 Then
            Call WarpUserCharX(UI, .KitsNum(UserKit).users(Slot_ID).PreviousPos.Map, .KitsNum(UserKit).users(Slot_ID).PreviousPos.X, .KitsNum(UserKit).users(Slot_ID).PreviousPos.Y, False)
            .KitsNum(UserKit).users(Slot_ID).UI = 0
        End If

    End With

    UserList(UI).XvsX.Slot_ID = 0
    UserList(UI).XvsX.Team_ID = 0
    UserList(UI).flags.EnEvento = 0

End Sub

Public Sub PassSecondXvsX()

    With Evento

        If .Sleep > 0 Then
            .Sleep = .Sleep - 1
            If .Sleep < 1 Then
                .Started = True
                Call Start_Event(False)
            End If
        End If


        If .TimeAtacking > 0 Then
            .TimeAtacking = .TimeAtacking - 1

            If .TimeAtacking < 1 Then
                Dim i As Long
                Dim j As Long
                Dim N As Integer

                For i = 1 To 2
                    For j = 1 To .Quotas
                        N = .KitsNum(i).users(j).UI

                        If N > 0 Then
                            Call WritePauseToggle(N)
                        Else
                            .KitsNum(i).PlayersDie = .KitsNum(i).PlayersDie + 1        '++ Genialidad o explota to jajaj
                        End If
                    Next j
                Next i
            End If
        End If

    End With

End Sub

Public Sub EnterXvsX(ByVal UI As Integer)

    Dim Team_ID As Byte, Freeslot As Byte

    Team_ID = IIf(Evento.KitsNum(1).Counters > Evento.KitsNum(2).Counters, 2, 1)
    Freeslot = FindFreeSlot(Team_ID)
    If Freeslot < 1 Then Exit Sub

    With Evento

        .KitsNum(Team_ID).Counters = .KitsNum(Team_ID).Counters + 1
        .KitsNum(Team_ID).users(Freeslot).UI = UI
        .KitsNum(Team_ID).users(Freeslot).PreviousPos = UserList(UI).Pos

        UserList(UI).XvsX.Slot_ID = Freeslot
        UserList(UI).XvsX.Team_ID = Team_ID
        UserList(UI).flags.EnEvento = 5

        Call WarpUserCharX(UI, KITS_ROOM.Map, KITS_ROOM.X, KITS_ROOM.Y, True)

        If .Inscription > 0 Then
            UserList(UI).Stats.GLD = UserList(UI).Stats.GLD - .Inscription
            Call WriteUpdateGold(UI)
            'Call WriteConsoleMsg(UI, "Has ingresado al evento, se te han descontado " & .Inscription & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        Else
            'Call WriteConsoleMsg(UI, "Has ingresado al evento.", FontTypeNames.FONTTYPE_INFO)
        End If

        If .KitsNum(1).Counters <> .Quotas Then Exit Sub
        If .KitsNum(2).Counters <> .Quotas Then Exit Sub

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Tienen un minuto para prepararse.", FontTypeNames.FONTTYPE_DIOS))

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Inscripciones finalizadas. Personajes inscriptos (" & .Quotas * 2 & "):", FontTypeNames.FONTTYPE_DIOS))

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & Event_players, FontTypeNames.FONTTYPE_DIOS))
        .Sleep = 60
        '.Started = True
        'Call Start_Event(False)

    End With


End Sub

Private Function ConvertNumStr(ByVal num As Integer) As String
    Select Case num
    Case 1
        ConvertNumStr = num & "er"
    Case 2
        ConvertNumStr = num & "da"
    Case 3
        ConvertNumStr = num & "er"
    Case 4, 5, 6
        ConvertNumStr = num & "ta"
    Case 7
        ConvertNumStr = num & "ma"
    Case 8
        ConvertNumStr = num & "va"
    Case 9
        ConvertNumStr = num & "na"
    End Select
End Function

Private Function Event_players() As String
    Dim i As Long, j As Long, s As String, N As Long

    With Evento
        For i = 1 To 2
            For j = 1 To .Quotas
                N = .KitsNum(i).users(j).UI
                If N > 0 Then
                    s = s & UserList(N).Name & " - "
                End If
            Next j
        Next i
        If Len(s) > 1 Then s = mid$(s, 1, Len(s) - 3)
        Event_players = s
    End With
End Function

Private Sub Event_Win(ByVal KitWinner As Byte)
    Dim LoopC As Long, N As Integer
    With Evento
        .KitsNum(1).Wins = .KitsNum(1).Wins + 1

        If .KitsNum(1).Wins >= .MaxVic Then Call Event_Clear(1): Exit Sub

        If .Quotas > 1 Then
            For LoopC = 1 To .Quotas
                N = .KitsNum(1).users(LoopC).UI
                If N > 0 Then
                    If .TimeAtacking > 0 Then
                        Call WritePauseToggle(N)
                    End If
                    Call WarpUserCharX(N, KITS_ROOM.Map, KITS_ROOM.X, KITS_ROOM.Y, True)
                    Call WriteConsoleMsg(N, "¡Has ganado el combate!, nuevamente estás en la sala de espera.", FontTypeNames.FONTTYPE_INFO)
                End If
            Next LoopC
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El equipo 1 acumula su " & ConvertNumStr(.KitsNum(1).Wins) & " victoria." & vbNewLine & "Para ingresar escribe /PARTICIPAR despues del conteo.", FontTypeNames.FONTTYPE_DIOS))
        Else
            N = .KitsNum(1).users(1).UI
            If N > 0 Then
                If .TimeAtacking > 0 Then
                    Call WritePauseToggle(N)
                End If
                Call WarpUserCharX(N, KITS_ROOM.Map, KITS_ROOM.X, KITS_ROOM.Y, True)
                Call WriteConsoleMsg(N, "¡Has ganado el combate!, nuevamente estás en la sala de espera.", FontTypeNames.FONTTYPE_INFO)
            Else
                Call CancelXvsX        'Alto error JAJAAJAJAJ
                Exit Sub
            End If
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El personaje " & UserList(N).Name & " acumula su " & ConvertNumStr(.KitsNum(1).Wins) & " victoria." & vbNewLine & "Para ingresar escribe /PARTICIPAR despues del conteo.", FontTypeNames.FONTTYPE_DIOS))
        End If
        .KitsNum(1).Deaths = 0
        '.Started = True
        .Started = False
    End With
End Sub

Private Sub SendToUlla(ByVal EquipID As Byte)
    Dim LoopC As Long, N As Integer
    With Evento
        For LoopC = 1 To .Quotas
            N = .KitsNum(EquipID).users(LoopC).UI
            If N > 0 Then
                UserList(N).XvsX.Slot_ID = 0
                UserList(N).XvsX.Team_ID = 0
                UserList(N).flags.EnEvento = 0

                If .TimeAtacking > 0 Then Call WritePauseToggle(N)

                Call WarpUserCharX(N, .KitsNum(EquipID).users(LoopC).PreviousPos.Map, .KitsNum(EquipID).users(LoopC).PreviousPos.X, .KitsNum(EquipID).users(LoopC).PreviousPos.Y, True)
                .KitsNum(EquipID).users(LoopC).UI = 0
            End If
        Next LoopC

        .TimeAtacking = 0
        If EquipID = 2 Then
            .KitsNum(EquipID).Deaths = 0
            .KitsNum(EquipID).Wins = 0
            .KitsNum(EquipID).Counters = 0
        End If
    End With
End Sub

Public Function CanEnterXvsX(ByVal UI As Integer, ByRef error As String) As Boolean

    If Not Evento.Active Then error = "No hay ningún evento actualmente.": Exit Function
    If Not Evento.Started Then error = "El evento ya esta en curso.": Exit Function

    With UserList(UI)

        If .XvsX.Slot_ID > 0 Then error = "Ya estás dentro del torneo.": Exit Function
        If .Stats.GLD < Evento.Inscription Then error = "No tienes el oro suficiente.": Exit Function
        If .Stats.ELV < Evento.MinLevel Then error = "Torneo solo para gente nivel mayor a " & Evento.MinLevel & ".": Exit Function
        If .Stats.ELV > Evento.Maxlevel Then error = "Torneo solo para gente nivel menor a " & Evento.Maxlevel & ".": Exit Function

    End With

    CanEnterXvsX = True

End Function

Private Function FindFreeSlot(ByVal UserKit As Byte) As Byte
    Dim LoopC As Long
    For LoopC = 1 To Evento.Quotas
        If Evento.KitsNum(UserKit).users(LoopC).UI < 1 Then FindFreeSlot = LoopC: Exit Function
    Next LoopC
End Function

Public Sub ResuciteinxVsX(ByVal UserKit As Byte)
    If Evento.VoucherResu Then
        If Evento.KitsNum(UserKit).PlayersDie > 0 Then
            Evento.KitsNum(UserKit).PlayersDie = Evento.KitsNum(UserKit).PlayersDie - 1
        End If
    End If
End Sub

Public Function BlockEventAttack(ByVal UI As Integer) As Boolean
    If Evento.TimeAtacking > 0 And UserList(UI).XvsX.Slot_ID > 0 Then BlockEventAttack = True: Exit Function
End Function
