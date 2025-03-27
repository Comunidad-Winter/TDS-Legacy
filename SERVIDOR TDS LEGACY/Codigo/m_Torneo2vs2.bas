Attribute VB_Name = "m_Torneo2vs2"
Option Explicit
Private Const NUMCLASES As Byte = 12
Private Enum eClass
    Mage = 1
    Cleric = 2
    Warrior = 3
    Assasin = 4
    Thief = 5
    Bard
    Druid
    Bandit
    Paladin
    Hunter
    Worker
    Pirat
End Enum
Private Type WorldPos
    map As Integer
    X As Byte
    Y As Byte
End Type

Private Type tGroupArena
    SpawnPos(1) As WorldPos
    DeathPos As WorldPos
End Type

Private Type tArena
    Team(1) As tGroupArena
End Type


Private Type tGroup
    UserIndex(1) As Integer
    nick(1) As String
    maxMuertes As Byte
    Muertes As Byte
    Rounds As Byte
End Type
Private Type GroupStruct
    TeamGroup(1) As tGroup
    Fighting As Boolean
    CountDown As Byte
    GroupWinner As Byte
End Type
Public Type tTorneoUserStruct
    CurrentID As Byte
    CurrentTeam As Byte
    CurrentGroup As Byte
End Type
Private Type tTorneo2vs2
    Active As Boolean
    Started As Boolean
    Quotas As Integer
    Entered As Integer
    Groups() As GroupStruct
    GroupWins As Byte
    WaitingPos As WorldPos
    MinLevel As Byte
    Maxlevel As Byte
    Inscription As Long
    MaxRounds As Byte
    Oro As Long
    PrizePoints As Long
    DropItems As Boolean
    Resu As Boolean
    ClasesValidas(1 To NUMCLASES) As eClass

    Max_Arenas As Byte
    Arenas() As tArena
End Type

Private Arena_Size As Byte

Public iTorneo2vs2 As tTorneo2vs2

Public Sub LoadTorneo2vs2Arena()

    On Error GoTo Errhandler

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Dim i As Long, Grupo As Long, Team As Long, ID As Byte, Max_Arenas As Byte, ln As String

    Call Leer.Initialize(App.path & "\Dat\Torneo_2vs2.dat")

    With iTorneo2vs2
        .PrizePoints = CLng(val(Leer.GetValue("INIT", "PuntosDeCanje")))
        .Oro = CLng(val(Leer.GetValue("INIT", "Oro")))
        .Inscription = CLng(val(Leer.GetValue("INIT", "Inscripcion")))

        Max_Arenas = CByte(val(Leer.GetValue("ARENAS", "Tot")))
        Arena_Size = CByte(val(Leer.GetValue("ARENAS", "Size")))
        ReDim .Arenas(1 To Max_Arenas)

        If Max_Arenas = 0 Then GoTo Errhandler

        For i = 1 To Max_Arenas
            ln = Leer.GetValue("ARENAS", "Arena" & i)

            .Arenas(i).Team(0).SpawnPos(0).map = val(ReadField(1, ln, 45))
            .Arenas(i).Team(1).SpawnPos(1).map = .Arenas(i).Team(0).SpawnPos(0).map
            .Arenas(i).Team(1).SpawnPos(0).map = .Arenas(i).Team(0).SpawnPos(0).map
            .Arenas(i).Team(0).SpawnPos(1).map = .Arenas(i).Team(0).SpawnPos(0).map
            .Arenas(i).Team(0).DeathPos.map = .Arenas(i).Team(0).SpawnPos(0).map
            .Arenas(i).Team(1).DeathPos.map = .Arenas(i).Team(0).SpawnPos(0).map

            .Arenas(i).Team(0).SpawnPos(0).X = val(ReadField(2, ln, 45))
            .Arenas(i).Team(0).SpawnPos(0).Y = val(ReadField(3, ln, 45))

            .Arenas(i).Team(0).SpawnPos(1).X = .Arenas(i).Team(0).SpawnPos(0).X + 1
            .Arenas(i).Team(0).SpawnPos(1).Y = .Arenas(i).Team(0).SpawnPos(0).Y

            .Arenas(i).Team(1).SpawnPos(0).X = val(ReadField(4, ln, 45))
            .Arenas(i).Team(1).SpawnPos(0).Y = val(ReadField(5, ln, 45))

            .Arenas(i).Team(1).SpawnPos(1).X = .Arenas(i).Team(1).SpawnPos(0).X - 1
            .Arenas(i).Team(1).SpawnPos(1).Y = .Arenas(i).Team(1).SpawnPos(0).Y

            .Arenas(i).Team(0).DeathPos.X = .Arenas(i).Team(0).SpawnPos(0).X - 2
            .Arenas(i).Team(0).DeathPos.Y = .Arenas(i).Team(0).SpawnPos(0).Y

            .Arenas(i).Team(1).DeathPos.X = .Arenas(i).Team(1).SpawnPos(1).X + 2
            .Arenas(i).Team(1).DeathPos.Y = .Arenas(i).Team(1).SpawnPos(1).Y

        Next i

    End With

19  Set Leer = Nothing
    Exit Sub
Errhandler:
    Call LogError("Error en LoadTorneo2vs2Arena en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub


Public Function Loop2vs2()    '<>
    If iTorneo2vs2.Started = False Then Exit Function
    Dim i As Long, j As Long, TmpIndex As Integer, GI As Integer, m As String
    For GI = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
        With iTorneo2vs2.Groups(GI)
            If Not .Fighting Then Exit Function
            If .CountDown > 0 Then
                .CountDown = .CountDown - 1
                m = IIf(.CountDown > 0, CStr(.CountDown) & "...", "¡YA!")
                If .CountDown = 0 Then
                    For i = LBound(.TeamGroup()) To UBound(.TeamGroup())
                        For j = LBound(.TeamGroup(i).UserIndex) To UBound(.TeamGroup(i).UserIndex)
                            TmpIndex = .TeamGroup(i).UserIndex(j)
                            If TmpIndex <> 0 Then
                                Call SetBloqs(False, GI)
                                Call FullStats(TmpIndex)
                            End If
                        Next j
                    Next i
                End If
                Call PublicarMensaje(m, GI)
            End If
        End With
    Next GI
End Function
Private Function PublicarMensaje(ByVal Str As String, Optional ByVal GI As Integer = -1)
    Dim i As Long, j As Long, k As Long, TmpIndex As Integer
    If GI = -1 Then    ' To all
        For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
            For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
                With iTorneo2vs2.Groups(k).TeamGroup(i)
                    For j = LBound(.UserIndex()) To UBound(.UserIndex())
                        TmpIndex = .UserIndex(j)
                        If TmpIndex <> 0 Then Call WriteConsoleMsg(TmpIndex, NOMBRE_TORNEO_ACTUAL & Str)
                    Next j
                End With
            Next i
        Next k
    Else    ' To GroupIndex
        For i = LBound(iTorneo2vs2.Groups(GI).TeamGroup()) To UBound(iTorneo2vs2.Groups(GI).TeamGroup())
            With iTorneo2vs2.Groups(GI).TeamGroup(i)
                For j = LBound(.UserIndex()) To UBound(.UserIndex())
                    TmpIndex = .UserIndex(j)
                    If TmpIndex <> 0 Then Call WriteConsoleMsg(TmpIndex, NOMBRE_TORNEO_ACTUAL & Str)
                Next j
            End With
        Next i
    End If
End Function
Private Function FullStats(ByVal UI As Integer)
    If (UserList(UI).flags.Muerto) Then Call RevivirUsuario(UI)
    UserList(UI).Stats.MinHP = UserList(UI).Stats.MaxHP: UserList(UI).Stats.MinMAN = UserList(UI).Stats.MaxMAN: UserList(UI).Stats.MinHam = 100: UserList(UI).Stats.MinAGU = 100: UserList(UI).Stats.minSta = UserList(UI).Stats.MaxSta: Call WriteUpdateUserStats(UI)
End Function
Private Function find_free_slot(ByRef CG As Byte, ByRef CT As Byte, ByRef cID As Byte) As Boolean
    Dim i As Long, j As Long, k As Long

    For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
        For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
            With iTorneo2vs2.Groups(k).TeamGroup(i)
                For j = LBound(.UserIndex()) To UBound(.UserIndex())
                    If .UserIndex(j) = 0 Then
                        CG = k
                        CT = i
                        cID = j
                        find_free_slot = True: Exit Function
                    End If
                Next j
            End With
        Next i
    Next k
End Function
Public Sub Desconexion2vs2(ByVal UI As Integer)
    With iTorneo2vs2
        Dim CG As Byte, CTl As Byte, cID As Byte

        Call WarpUserCharX(UI, Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y)

        CG = UserList(UI).flags.T2vs2.CurrentGroup
        CTl = UserList(UI).flags.T2vs2.CurrentTeam
        cID = UserList(UI).flags.T2vs2.CurrentID
        If Not .Started Then .Entered = .Entered - 1
        If CG = 0 Then Exit Sub

        .Groups(CG).TeamGroup(CTl).UserIndex(cID) = 0
        UserList(UI).flags.T2vs2.CurrentGroup = 0
        UserList(UI).flags.T2vs2.CurrentTeam = 0
        UserList(UI).flags.T2vs2.CurrentID = 0

        Call PublicarMensaje(UserList(UI).Name & " se desconectó del evento.")

        If .Groups(CG).Fighting Then
            .Groups(CG).TeamGroup(CTl).Muertes = .Groups(CG).TeamGroup(CTl).Muertes + 1
        End If

        If .Started Then
            If iTorneo2vs2.DropItems Then
                Call WarpUserCharX(UI, TORNEO_Drop.map, TORNEO_Drop.X, TORNEO_Drop.Y, False)
                Call TirarTodosLosItems(UI, TORNEO_Drop.map, TORNEO_Drop.X, TORNEO_Drop.Y)
            End If

            Call WarpUserCharX(UI, Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y, False)

            If .Groups(CG).TeamGroup(CTl).Muertes = .Groups(CG).TeamGroup(CTl).maxMuertes Then
                Call RoundWin(CG, IIf(CTl = 0, 1, 0), CTl)
            Else
                .Groups(CG).TeamGroup(CTl).UserIndex(cID) = 0
            End If
        Else
            ' le damo el oro
            UserList(UI).Stats.GLD = UserList(UI).Stats.GLD + .Inscription
        End If


    End With
End Sub
Private Function PuedeIngresar(ByVal UI As Integer) As Boolean

    If Not iTorneo2vs2.Active Then WriteConsoleMsg UI, "No hay ningún evento actualmente.": Exit Function
    If iTorneo2vs2.Started Then WriteConsoleMsg UI, "El evento ya esta en curso.": Exit Function
    With UserList(UI)
        If .flags.T2vs2.CurrentID > 0 Then WriteConsoleMsg UI, "Ya estás dentro del torneo.": Exit Function
        If .Stats.GLD < iTorneo2vs2.Inscription Then WriteConsoleMsg UI, "No tienes el oro suficiente.": Exit Function
        If .Stats.ELV < iTorneo2vs2.MinLevel Then WriteConsoleMsg UI, NOMBRE_TORNEO_ACTUAL & "Torneo solo para gente nivel mayor a " & iTorneo2vs2.MinLevel & ".": Exit Function
        If .Stats.ELV > iTorneo2vs2.Maxlevel Then WriteConsoleMsg UI, NOMBRE_TORNEO_ACTUAL & "Torneo solo para gente nivel menor a " & iTorneo2vs2.Maxlevel & ".": Exit Function
    End With
    PuedeIngresar = True
End Function
Public Sub Ingreso2vs2(ByVal UI As Integer)
    With iTorneo2vs2
        If .Started Then Exit Sub
        Dim CG As Byte, CT As Byte, cID As Byte, SlotLibre As Boolean
        SlotLibre = find_free_slot(CG, CT, cID)
        If Not PuedeIngresar(UI) Then Exit Sub
        If Not SlotLibre Then Call WriteConsoleMsg(UI, "No hay cupos!"): Exit Sub
        UserList(UI).flags.T2vs2.CurrentGroup = CG
        UserList(UI).flags.T2vs2.CurrentTeam = CT
        UserList(UI).flags.T2vs2.CurrentID = cID
        UserList(UI).flags.lastPos = UserList(UI).Pos
        UserList(UI).flags.EnEvento = 2

        iTorneo2vs2.Groups(CG).TeamGroup(CT).UserIndex(cID) = UI

        UserList(UI).Stats.GLD = UserList(UI).Stats.GLD - .Inscription
        WriteUpdateGold UI

        .Groups(CG).TeamGroup(CT).nick(cID) = UserList(UI).Name
        Call PublicarMensaje(UserList(UI).Name & " ingresó al evento.")
        Call WriteConsoleMsg(UI, NOMBRE_TORNEO_ACTUAL & "Ingresaste en el equipo #" & CT + 1)

        .Entered = .Entered + 1

        Call MandarASalaDeEspera(UI)

        If .Entered = .Quotas Then
            Call StartEvent
        End If
    End With
End Sub
Public Sub Crea2vs2(ByVal UserIndex As Integer, ByVal Quotas As Byte, ByVal Inscripcion As Long, ByVal DropItems As Boolean, ByVal Resu As Boolean, ByVal Oro As Long, ByVal Puntos As Long, ByVal MinLevel As Byte, ByVal Maxlevel As Byte, ByVal cMago As Byte, ByVal cClerigo As Byte, ByVal cGuerrero As Byte, ByVal cAsesino As Byte, ByVal cLadron As Byte, ByVal cBardo As Byte, ByVal cDruida As Byte, ByVal cBandido As Byte, ByVal cPaladin As Byte, ByVal cCazador As Byte, ByVal cTrabajador As Byte, ByVal cPirata As Byte)
    Dim T As Boolean

    With iTorneo2vs2
        .DropItems = DropItems
        .PrizePoints = Abs(Puntos)
        .Resu = Resu
        .Inscription = Abs(Inscripcion)
        .MaxRounds = 2
        .Entered = 0
        .Oro = Oro
        .ClasesValidas(eClass.Mage) = cMago: If T = False Then T = (cMago > 0): .ClasesValidas(eClass.Cleric) = cClerigo: If T = False Then T = (cClerigo > 0): .ClasesValidas(eClass.Bard) = cBardo: If T = False Then T = (cBardo > 0): .ClasesValidas(eClass.Paladin) = cPaladin: If T = False Then T = (cPaladin > 0): .ClasesValidas(eClass.Assasin) = cAsesino: If T = False Then T = (cAsesino > 0): .ClasesValidas(eClass.Hunter) = cCazador: If T = False Then T = (cCazador > 0): .ClasesValidas(eClass.Warrior) = cGuerrero: If T = False Then T = (cGuerrero > 0): .ClasesValidas(eClass.Druid) = cDruida: If T = False Then T = (cDruida > 0): .ClasesValidas(eClass.Thief) = cLadron: If T = False Then T = (cLadron > 0): .ClasesValidas(eClass.Bandit) = cBandido: If T = False Then T = (cBandido > 0): .ClasesValidas(eClass.Worker) = cTrabajador: If T = False Then T = (cTrabajador > 0): .ClasesValidas(eClass.Pirat) = cPirata: If T = False Then T = (cPirata > 0)
        If Not Quotas >= 4 Then Quotas = 4
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel
        .Started = False
        .Active = True
        .Quotas = Quotas
        ReDim .Groups(1 To Quotas / 4)
        NOMBRE_TORNEO_ACTUAL = "Torneo2vs2 "

        TOURNAMENT_ACTIVE = 2

        If UBound(.Groups) = 1 Then
            NOMBRE_TORNEO_ACTUAL = NOMBRE_TORNEO_ACTUAL & "FINAL> "
        ElseIf UBound(.Groups) = 2 Then
            NOMBRE_TORNEO_ACTUAL = NOMBRE_TORNEO_ACTUAL & "CUARTOS> "
        ElseIf UBound(.Groups) = 3 Then
            NOMBRE_TORNEO_ACTUAL = NOMBRE_TORNEO_ACTUAL & "OCTAVOS> "
        End If

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Torneo 2vs2 abierto para " & Quotas & " jugadores, Inscripción" & IIf(.Inscription > 0, " de: " & .Inscription & " Monedas de oro, ", " Gratis, ") & "Nivel mínimo: " & .MinLevel & ", Nivel máximo: " & .Maxlevel & vbNewLine & "PREMIOS: " & vbNewLine & IIf(.PrizePoints > 0, " " & .PrizePoints & " puntos de Canje" & vbNewLine, "") & IIf(.Oro > 0, " " & .Oro & " monedas de oro" & vbNewLine, "") & "Manden /PARTICIPAR si desean participar.", FontTypeNames.FONTTYPE_EVENTOS))

        If T Then
            SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Clases prohibidas: " & IIf(cMago > 0, " MAGO ", "") & IIf(cClerigo > 0, " CLERIGO ", "") & IIf(cBardo > 0, " BARDO ", "") & IIf(cPaladin > 0, " PALADIN ", "") & IIf(cAsesino > 0, " ASESINO ", "") & IIf(cCazador > 0, " CAZADOR ", "") & IIf(cGuerrero > 0, " GUERRERO ", "") & IIf(cDruida > 0, " DRUIDA ", "") & IIf(cLadron > 0, " LADRON ", "") & IIf(cBandido > 0, " BANDIDO ", "") & IIf(cTrabajador > 0, " TRABAJADOR ", "") & IIf(cPirata > 0, " PIRATA ", ""), FontTypeNames.FONTTYPE_INFOBOLD)
        End If

        If DropItems Then
            SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "ATENCION!! CAEN ITEMS", FontTypeNames.FONTTYPE_FIGHT)
        End If

    End With

End Sub

Public Function CancelarTorneo2vs2(Optional ByVal UserIndex As Integer) As Boolean

1   On Error GoTo CancelarTorneo2vs2_Error

2   With iTorneo2vs2

        TOURNAMENT_ACTIVE = 0

3       If (Not .Active) Then Exit Function

4       .Active = False
5       .Entered = 0
        .GroupWins = 0
        .Started = False
        .DropItems = False

        Dim b() As String
        b = Split(NOMBRE_TORNEO_ACTUAL, " ")
        NOMBRE_TORNEO_ACTUAL = b(0) & "> "

        Dim i As Long, j As Long, k As Long, UI As Integer

        For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
            For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
                With iTorneo2vs2.Groups(k).TeamGroup(i)
                    For j = LBound(.UserIndex()) To UBound(.UserIndex())
                        If .UserIndex(j) > 0 Then
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentGroup = 0
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentID = 0
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentTeam = 0
                            UserList(.UserIndex(j)).flags.EnEvento = 0
                            If Not iTorneo2vs2.Inscription = 0 Then
22                              UserList(.UserIndex(j)).Stats.GLD = UserList(.UserIndex(j)).Stats.GLD + iTorneo2vs2.Inscription
23                              Call WriteUpdateGold(.UserIndex(j))
24                              Call WriteConsoleMsg(.UserIndex(j), NOMBRE_TORNEO_ACTUAL & "Se te ha devuelto el costo de la inscripción.", FontTypeNames.FONTTYPE_EVENTOS)
                            End If
                            Call WarpUserCharX(.UserIndex(j), UserList(.UserIndex(j)).flags.lastPos.map, UserList(.UserIndex(j)).flags.lastPos.X, UserList(.UserIndex(j)).flags.lastPos.Y, True)
                        End If
                        .nick(j) = ""
                        .Rounds = 0
                        .maxMuertes = 0
                        .Muertes = 0
                        .UserIndex(j) = 0
                    Next j
                End With
            Next i
        Next k

        CancelarTorneo2vs2 = True

28  End With

29  Exit Function

CancelarTorneo2vs2_Error:

30  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure CancelarTorneo2vs2 of Módulo m_Torneo2vs2" & Erl & ".")

End Function
Private Sub StartEvent()
    With iTorneo2vs2
        .Started = True
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Cupos llenos, inicia el torneo!", FontTypeNames.FONTTYPE_EVENTOS))
        Dim i As Long, j As Long, k As Long, UI As Integer
        Dim tot As Byte
        For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
            For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
                With iTorneo2vs2.Groups(k).TeamGroup(i)
                    For j = LBound(.UserIndex()) To UBound(.UserIndex())
                        If .UserIndex(j) > 0 Then
                            Call MandarASuArena(.UserIndex(j))
                            SetBloqs True, k
                            .maxMuertes = .maxMuertes + 1
                        End If
                    Next j
                End With
            Next i
            iTorneo2vs2.Groups(k).CountDown = 5
            iTorneo2vs2.Groups(k).Fighting = True
        Next k
    End With
End Sub
Private Sub MandarASalaDeEspera(ByVal UI As Integer)
    If UI = 0 Then Exit Sub
    Call WarpUserCharX(UI, TORNEO_Espera.map, TORNEO_Espera.X, TORNEO_Espera.Y)
End Sub
Private Sub MandarASuArena(ByVal UI As Integer)
    If UI = 0 Then Exit Sub
    Call WarpUserCharX(UI, iTorneo2vs2.Arenas(UserList(UI).flags.T2vs2.CurrentGroup).Team(UserList(UI).flags.T2vs2.CurrentTeam).SpawnPos(UserList(UI).flags.T2vs2.CurrentID).map, iTorneo2vs2.Arenas(UserList(UI).flags.T2vs2.CurrentGroup).Team(UserList(UI).flags.T2vs2.CurrentTeam).SpawnPos(UserList(UI).flags.T2vs2.CurrentID).X, iTorneo2vs2.Arenas(UserList(UI).flags.T2vs2.CurrentGroup).Team(UserList(UI).flags.T2vs2.CurrentTeam).SpawnPos(UserList(UI).flags.T2vs2.CurrentID).Y)
End Sub
Public Sub Muere2vs2(ByVal UI As Integer)
    With iTorneo2vs2
        Dim CG As Byte, TeamLooser As Byte, TeamWinner As Byte
        CG = UserList(UI).flags.T2vs2.CurrentGroup
        TeamLooser = UserList(UI).flags.T2vs2.CurrentTeam
        TeamWinner = IIf(UserList(UI).flags.T2vs2.CurrentTeam = 1, 0, 1)

        .Groups(CG).TeamGroup(TeamLooser).Muertes = .Groups(CG).TeamGroup(TeamLooser).Muertes + 1

        If .Groups(CG).TeamGroup(TeamLooser).Muertes = .Groups(CG).TeamGroup(TeamLooser).maxMuertes Then
            Call RoundWin(CG, TeamWinner, TeamLooser)
        Else
            If .Resu = False Then Call WarpUserCharX(UI, .Arenas(CG).Team(TeamLooser).DeathPos.map, .Arenas(CG).Team(TeamLooser).DeathPos.X, .Arenas(CG).Team(TeamLooser).DeathPos.Y, True)
        End If

    End With
End Sub
Public Sub Revive2vs2(ByVal UI As Integer)
    iTorneo2vs2.Groups(UserList(UI).flags.T2vs2.CurrentGroup).TeamGroup(UserList(UI).flags.T2vs2.CurrentTeam).Muertes = iTorneo2vs2.Groups(UserList(UI).flags.T2vs2.CurrentGroup).TeamGroup(UserList(UI).flags.T2vs2.CurrentTeam).Muertes - 1
End Sub
Private Sub RoundWin(ByVal CG As Byte, ByVal CTw As Byte, ByVal CTl As Byte)
    Dim i As Long, j As Long, TmpIndex As Integer, tString As String

    If iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex(0) = 0 Then
        tString = iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(1)
    ElseIf iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex(1) = 0 Then
        tString = iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(0)
    Else
        tString = iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(0) & " y " & iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(1)
    End If

    tString = tString & " VS "

    If iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(0) = 0 Then
        tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTl).nick(1)
    ElseIf iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(1) = 0 Then
        tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTl).nick(0)
    Else
        tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTl).nick(0) & " y " & iTorneo2vs2.Groups(CG).TeamGroup(CTl).nick(1)
    End If

    iTorneo2vs2.Groups(CG).TeamGroup(CTw).Rounds = iTorneo2vs2.Groups(CG).TeamGroup(CTw).Rounds + 1

    ' @@ salteamos
    If iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(0) = 0 And iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(1) = 0 Then
        iTorneo2vs2.Groups(CG).TeamGroup(CTw).Rounds = iTorneo2vs2.MaxRounds
    End If

    If iTorneo2vs2.Groups(CG).TeamGroup(CTw).Rounds = iTorneo2vs2.MaxRounds Then

        tString = tString & vbNewLine & "Ganador del Round: "

        If iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex(0) = 0 Then
            tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(1)
        ElseIf iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex(1) = 0 Then
            tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(0)
        Else
            tString = tString & iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(0) & " y " & iTorneo2vs2.Groups(CG).TeamGroup(CTw).nick(1)
        End If

        If iTorneo2vs2.Groups(CG).TeamGroup(CTl).Muertes = iTorneo2vs2.Groups(CG).TeamGroup(CTl).maxMuertes Then
            iTorneo2vs2.GroupWins = iTorneo2vs2.GroupWins + 1

            iTorneo2vs2.Groups(CG).GroupWinner = CTw
            iTorneo2vs2.Groups(CG).TeamGroup(CTw).Rounds = 0

            For i = LBound(iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex) To UBound(iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex)
                TmpIndex = iTorneo2vs2.Groups(CG).TeamGroup(CTw).UserIndex(i)
                If TmpIndex <> 0 Then
                    Call MandarASalaDeEspera(TmpIndex)
                    Call FullStats(TmpIndex)
                End If
            Next i

            For i = LBound(iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex) To UBound(iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex)
                TmpIndex = iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(i)

                If TmpIndex <> 0 Then

                    If iTorneo2vs2.DropItems Then
                        Call WarpUserCharX(TmpIndex, TORNEO_Drop.map, TORNEO_Drop.X, TORNEO_Drop.Y, False)
                        Call TirarTodosLosItems(TmpIndex, TORNEO_Drop.map, TORNEO_Drop.X, TORNEO_Drop.Y)
                    End If


                    Call WarpUserCharX(TmpIndex, Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y)
                    UserList(TmpIndex).flags.T2vs2.CurrentGroup = 0
                    UserList(TmpIndex).flags.T2vs2.CurrentID = 0
                    UserList(TmpIndex).flags.T2vs2.CurrentTeam = 0
                    UserList(TmpIndex).flags.EnEvento = 0

                    Call FullStats(TmpIndex)
                    iTorneo2vs2.Groups(CG).TeamGroup(CTl).UserIndex(i) = 0
                End If
            Next i

            iTorneo2vs2.Groups(CG).Fighting = False

        End If

        If iTorneo2vs2.GroupWins = UBound(iTorneo2vs2.Groups) Then

            ' era la final
            If iTorneo2vs2.GroupWins = 1 Or iTorneo2vs2.GroupWins > UBound(iTorneo2vs2.Groups) Then
                Call WinnerEvent
                Exit Sub
            End If

            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & tString, FontTypeNames.FONTTYPE_EVENTOS))

            Dim winners() As Integer
            ReDim winners(1 To iTorneo2vs2.Entered / 2)
            iTorneo2vs2.Entered = iTorneo2vs2.Entered / 2
            Dim Index As Integer
            Index = 0
            For i = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups)
                Index = Index + 1
                winners(Index) = iTorneo2vs2.Groups(i).TeamGroup(iTorneo2vs2.Groups(i).GroupWinner).UserIndex(0)
                Index = Index + 1
                winners(Index) = iTorneo2vs2.Groups(i).TeamGroup(iTorneo2vs2.Groups(i).GroupWinner).UserIndex(1)
            Next i

            Dim q As Byte
            Dim PrimerGrupo As Boolean
            Dim count As Byte
            Dim cGroup As Byte
            Dim cTeam As Byte
            Dim cID As Byte
            cGroup = 1

            For i = 1 To UBound(winners)

                If cID = 2 Then
                    cID = 0
                    cTeam = cTeam + 1
                End If

                If cTeam = 2 Then
                    cTeam = 0
                    cGroup = cGroup + 1
                    cID = 0

                End If

                If winners(i) = 0 Then
                    iTorneo2vs2.Groups(cGroup).TeamGroup(cTeam).nick(cID) = ""
                Else
                    iTorneo2vs2.Groups(cGroup).TeamGroup(cTeam).nick(cID) = UserList(winners(i)).Name
                    UserList(winners(i)).flags.T2vs2.CurrentGroup = cGroup
                    UserList(winners(i)).flags.T2vs2.CurrentTeam = cTeam
                    UserList(winners(i)).flags.T2vs2.CurrentID = cID
                End If
                iTorneo2vs2.Groups(cGroup).TeamGroup(cTeam).UserIndex(cID) = winners(i)
                cID = cID + 1

            Next i

            If UBound(winners) = 16 Then cGroup = 3
            If UBound(winners) = 8 Then cGroup = 2
            If UBound(winners) = 4 Then cGroup = 1

            ReDim Preserve iTorneo2vs2.Groups(1 To cGroup)

            iTorneo2vs2.GroupWins = 0

            For q = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())

                iTorneo2vs2.Groups(q).GroupWinner = 0
                iTorneo2vs2.Groups(q).CountDown = 5
                iTorneo2vs2.Groups(q).Fighting = True
                SetBloqs True, q
                For i = LBound(iTorneo2vs2.Groups(q).TeamGroup()) To UBound(iTorneo2vs2.Groups(q).TeamGroup())
                    iTorneo2vs2.Groups(q).TeamGroup(i).Rounds = 0
                    iTorneo2vs2.Groups(q).TeamGroup(i).Muertes = 0
                    iTorneo2vs2.Groups(q).TeamGroup(i).maxMuertes = 0
                    For j = LBound(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex) To UBound(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex)

                        If Not iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j) = 0 Then
                            iTorneo2vs2.Groups(q).TeamGroup(i).maxMuertes = iTorneo2vs2.Groups(q).TeamGroup(i).maxMuertes + 1
                        End If

                        If j = UBound(iTorneo2vs2.Groups(q).TeamGroup()) Then
                            If iTorneo2vs2.Groups(q).TeamGroup(i).maxMuertes = 0 Then
                                iTorneo2vs2.Groups(q).GroupWinner = iTorneo2vs2.Groups(q).GroupWinner + 1
                                If iTorneo2vs2.Groups(q).GroupWinner = 2 Then iTorneo2vs2.Groups(q).GroupWinner = 0
                                iTorneo2vs2.Groups(q).CountDown = 0
                                iTorneo2vs2.Groups(q).Fighting = False
                                SetBloqs False, q
                                Call MandarASalaDeEspera(iTorneo2vs2.Groups(q).TeamGroup(iTorneo2vs2.Groups(q).GroupWinner).UserIndex(0))
                                Call MandarASalaDeEspera(iTorneo2vs2.Groups(q).TeamGroup(iTorneo2vs2.Groups(q).GroupWinner).UserIndex(0))
                            End If
                        End If
                    Next j
                Next i
            Next q

            Dim N() As String

            N = Split(NOMBRE_TORNEO_ACTUAL, " ")

            If cGroup = 1 Then
                NOMBRE_TORNEO_ACTUAL = N(0) & " FINAL> "
            ElseIf cGroup = 2 Then
                NOMBRE_TORNEO_ACTUAL = N(0) & " CUARTOS> "
            ElseIf cGroup = 3 Then
                NOMBRE_TORNEO_ACTUAL = N(0) & " OCTAVOS> "
            End If
            tString = "Siguiente pelea: "
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Siguiente fase en proceso!", FontTypeNames.FONTTYPE_EVENTOS))
            ' ahora el string..
            For q = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())

                tString = ""
                If iTorneo2vs2.Groups(q).Fighting = False Then
                    tString = tString & "El equipo " & iTorneo2vs2.Groups(q).GroupWinner & " ganó por desconexión completa del equipo enemigo, pasa de ronda."
                Else


                    For i = LBound(iTorneo2vs2.Groups(q).TeamGroup) To UBound(iTorneo2vs2.Groups(q).TeamGroup)
                        For j = LBound(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex) To UBound(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex)
                            If Not iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j) = 0 Then

                                Call WarpUserCharX(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j), iTorneo2vs2.Arenas(q).Team(i).SpawnPos(UserList(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j)).flags.T2vs2.CurrentID).map, iTorneo2vs2.Arenas(q).Team(i).SpawnPos(UserList(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j)).flags.T2vs2.CurrentID).X, iTorneo2vs2.Arenas(q).Team(i).SpawnPos(UserList(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j)).flags.T2vs2.CurrentID).Y)
                                'Call WritePauseToggle(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(1))

                                Call FullStats(iTorneo2vs2.Groups(q).TeamGroup(i).UserIndex(j))
                            End If
                        Next j
                    Next i

                    If iTorneo2vs2.Groups(q).TeamGroup(0).UserIndex(0) = 0 Then
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(0).nick(1)
                    ElseIf iTorneo2vs2.Groups(q).TeamGroup(0).UserIndex(1) = 0 Then
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(0).nick(0)
                    Else
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(0).nick(0) & " y " & iTorneo2vs2.Groups(q).TeamGroup(0).nick(1)
                    End If

                    tString = tString & " Vs "

                    If iTorneo2vs2.Groups(q).TeamGroup(1).UserIndex(0) = 0 Then
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(1).nick(1)
                    ElseIf iTorneo2vs2.Groups(q).TeamGroup(1).UserIndex(1) = 0 Then
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(1).nick(0)
                    Else
                        tString = tString & iTorneo2vs2.Groups(q).TeamGroup(1).nick(0) & " y " & iTorneo2vs2.Groups(q).TeamGroup(1).nick(1)
                    End If

                End If

                'Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & tString, FontTypeNames.FONTTYPE_eventos))
                iTorneo2vs2.Groups(q).CountDown = 5
                iTorneo2vs2.Groups(q).Fighting = True
                iTorneo2vs2.Groups(q).TeamGroup(0).Rounds = 0
                SetBloqs True, q
                iTorneo2vs2.Groups(q).TeamGroup(1).Rounds = 0

                iTorneo2vs2.Groups(q).TeamGroup(0).Muertes = 0
                iTorneo2vs2.Groups(q).TeamGroup(1).Muertes = 0
            Next q

        End If

    Else

        '''''''''''''''''''''''''' RESPAWN ROUND '''''''''''''''''''''''''''''''''''''''
        For i = LBound(iTorneo2vs2.Groups(CG).TeamGroup()) To UBound(iTorneo2vs2.Groups(CG).TeamGroup())
            iTorneo2vs2.Groups(CG).TeamGroup(i).Muertes = 0
            iTorneo2vs2.Groups(CG).TeamGroup(i).maxMuertes = 0

            For j = LBound(iTorneo2vs2.Groups(CG).TeamGroup(i).UserIndex) To UBound(iTorneo2vs2.Groups(CG).TeamGroup(i).UserIndex)
                TmpIndex = iTorneo2vs2.Groups(CG).TeamGroup(i).UserIndex(j)
                If TmpIndex <> 0 Then
                    iTorneo2vs2.Groups(CG).TeamGroup(i).maxMuertes = iTorneo2vs2.Groups(CG).TeamGroup(i).maxMuertes + 1
                    Call WarpUserCharX(TmpIndex, iTorneo2vs2.Arenas(CG).Team(i).SpawnPos(UserList(TmpIndex).flags.T2vs2.CurrentID).map, iTorneo2vs2.Arenas(CG).Team(i).SpawnPos(UserList(TmpIndex).flags.T2vs2.CurrentID).X, iTorneo2vs2.Arenas(CG).Team(i).SpawnPos(UserList(TmpIndex).flags.T2vs2.CurrentID).Y)
                    Call FullStats(TmpIndex)
                End If
            Next j
        Next i
        Call PublicarMensaje("Siguiente round empieza en 5...", CG)
        Call SetBloqs(True, CG)

        iTorneo2vs2.Groups(CG).CountDown = 5

        '''''''''''''''''''''''''' RESPAWN ROUND '''''''''''''''''''''''''''''''''''''''
    End If

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & tString, FontTypeNames.FONTTYPE_EVENTOS))
End Sub

Private Function SetBloqs(ByVal block As Boolean, Optional ByVal Arena As Byte = 0)
    Dim i As Long
    Dim map As Integer
    With iTorneo2vs2
        map = .Arenas(1).Team(0).SpawnPos(0).map
        Dim X As Byte, Y As Byte
        i = Arena

        If Arena = 0 Then
            For i = 1 To UBound(.Arenas)

                X = .Arenas(i).Team(0).SpawnPos(1).X
                Y = .Arenas(i).Team(0).SpawnPos(1).Y + 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(0).SpawnPos(1).X + 1
                Y = .Arenas(i).Team(0).SpawnPos(1).Y
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(0).SpawnPos(1).X - 1
                Y = .Arenas(i).Team(0).SpawnPos(1).Y + 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                ''''''''''
                X = .Arenas(i).Team(1).SpawnPos(1).X - 1
                Y = .Arenas(i).Team(1).SpawnPos(1).Y
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(1).SpawnPos(1).X
                Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(1).SpawnPos(1).X - 1
                Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(1).SpawnPos(1).X - 1
                Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)

                X = .Arenas(i).Team(1).SpawnPos(1).X + 1
                Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
                MapData(map, X, Y).Blocked = block
                Call Bloquear(True, map, X, Y, block)
            Next i
        Else
            X = .Arenas(i).Team(0).SpawnPos(1).X
            Y = .Arenas(i).Team(0).SpawnPos(1).Y + 1
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            X = .Arenas(i).Team(0).SpawnPos(1).X + 1
            Y = .Arenas(i).Team(0).SpawnPos(1).Y
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            X = .Arenas(i).Team(0).SpawnPos(1).X - 1
            Y = .Arenas(i).Team(0).SpawnPos(1).Y + 1
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            ''''''''''
            X = .Arenas(i).Team(1).SpawnPos(1).X - 1
            Y = .Arenas(i).Team(1).SpawnPos(1).Y
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            X = .Arenas(i).Team(1).SpawnPos(1).X
            Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            X = .Arenas(i).Team(1).SpawnPos(1).X - 1
            Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)

            X = .Arenas(i).Team(1).SpawnPos(1).X + 1
            Y = .Arenas(i).Team(1).SpawnPos(1).Y - 1
            MapData(map, X, Y).Blocked = block
            Call Bloquear(True, map, X, Y, block)
        End If
    End With
End Function

Private Sub WinnerEvent()
    With iTorneo2vs2

        Dim winners As String
        Dim CG As Byte
        CG = iTorneo2vs2.Groups(1).GroupWinner

        .GroupWins = 0

        Dim WinMsg As String

        If iTorneo2vs2.Groups(1).TeamGroup(CG).UserIndex(0) = 0 Then
            WinMsg = iTorneo2vs2.Groups(1).TeamGroup(CG).nick(1)
        ElseIf iTorneo2vs2.Groups(1).TeamGroup(CG).UserIndex(1) = 0 Then
            WinMsg = iTorneo2vs2.Groups(1).TeamGroup(CG).nick(0)
        Else
            WinMsg = iTorneo2vs2.Groups(1).TeamGroup(CG).nick(0) & " y " & iTorneo2vs2.Groups(1).TeamGroup(CG).nick(1)
        End If

        Dim i As Long, j As Long, k As Long, UI As Integer

        For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
            For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
                If Not i = CG Then
                    With iTorneo2vs2.Groups(k).TeamGroup(i)
                        For j = LBound(.UserIndex()) To UBound(.UserIndex())
                            If .UserIndex(j) > 0 Then
                                Call WarpUserCharX(.UserIndex(j), Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y, True)
                                UserList(.UserIndex(j)).flags.T2vs2.CurrentGroup = 0
                                UserList(.UserIndex(j)).flags.T2vs2.CurrentID = 0
                                UserList(.UserIndex(j)).flags.T2vs2.CurrentTeam = 0
                                UserList(.UserIndex(j)).flags.EnEvento = 0
                            End If
                        Next j
                    End With
                End If
            Next i
        Next k
        Dim gold As Long

        k = 1

        With iTorneo2vs2.Groups(k).TeamGroup(CG)
            For j = LBound(.UserIndex()) To UBound(.UserIndex())
                If .UserIndex(j) > 0 Then
                    Call GivePrizes(.UserIndex(j), iTorneo2vs2.Oro, iTorneo2vs2.PrizePoints)

                    If iTorneo2vs2.DropItems Then
                        Call WarpUserCharX(.UserIndex(j), TORNEO_Drop.map, TORNEO_Drop.X, TORNEO_Drop.Y, True)
                        UserList(.UserIndex(j)).Counters.lastPos = 120
                        Call WriteConsoleMsg(.UserIndex(j), "Tienes 2 minutos para recoger los items y luego volverás a la posición donde estabas.", FontTypeNames.FONTTYPE_SERVER)
                    Else
                        Call WarpUserCharX(.UserIndex(j), Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y, True)
                    End If

                    UserList(.UserIndex(j)).flags.T2vs2.CurrentGroup = 0
                    UserList(.UserIndex(j)).flags.T2vs2.CurrentID = 0
                    UserList(.UserIndex(j)).flags.T2vs2.CurrentTeam = 0
                    UserList(.UserIndex(j)).flags.EnEvento = 0

                    'UserList(.UserIndex(j)).Stats.Torneos2vs2Ganados = UserList(.UserIndex(j)).Stats.Torneos2vs2Ganados + 1
                    'Call m_Ranking.CheckRankingUser(.UserIndex(j), TopTorneo2vs2)

                Else
                    gold = val(GetVar(CharPath & UCase$(.nick(j)) & ".chr", "STATS", "GLD"))
                    Call WriteVar(CharPath & UCase$(.nick(j)) & ".chr", "STATS", "GLD", gold + iTorneo2vs2.Oro)

                    'gold = GetVar(CharPath & UCase$(.Nick(j)) & ".chr", "STATS", "Torneos2vs2Ganados")
                    'Call WriteVar(CharPath & UCase$(.Nick(j)) & ".chr", "STATS", "Torneos2vs2Ganados", gold + 1)

                End If
            Next j
        End With

        Dim b() As String
        b = Split(NOMBRE_TORNEO_ACTUAL, " ")
        NOMBRE_TORNEO_ACTUAL = b(0) & "> "
        
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganadores del torneo 2vs2: " & WinMsg, FontTypeNames.FONTTYPE_EVENTOS))
        
        TOURNAMENT_ACTIVE = 0
        If iTorneo2vs2.DropItems = False Then
            Call CancelarTorneo2vs2(-1)
            Exit Sub
        End If

4       .Active = False
5       .Entered = 0
        .GroupWins = 0
        .Started = False
        .DropItems = False

        For k = LBound(iTorneo2vs2.Groups()) To UBound(iTorneo2vs2.Groups())
            For i = LBound(iTorneo2vs2.Groups(k).TeamGroup()) To UBound(iTorneo2vs2.Groups(k).TeamGroup())
                With iTorneo2vs2.Groups(k).TeamGroup(i)
                    For j = LBound(.UserIndex()) To UBound(.UserIndex())
                        If .UserIndex(j) > 0 Then
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentGroup = 0
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentID = 0
                            UserList(.UserIndex(j)).flags.T2vs2.CurrentTeam = 0
                            UserList(.UserIndex(j)).flags.EnEvento = 0
                        End If
                        .nick(j) = ""
                        .Rounds = 0
                        .maxMuertes = 0
                        .Muertes = 0
                        .UserIndex(j) = 0
                    Next j
                End With
            Next i
        Next k
        
    End With


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

