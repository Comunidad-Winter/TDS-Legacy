Attribute VB_Name = "m_Retos2vs2"
Option Explicit

Public Const RETO_MAP_2 As Integer = 230

Public Const RETO_MAP_2_DROP As Integer = 193

Public COSTO_RETOS_2VS2 As Long
Public ESTADO_RETOS_2VS2 As Byte

Private Const MIN_GOLD As Long = 25000
Private Const MAX_GOLD As Long = 2000000

Private Type tRetoUser
    UserIndex(1 To 2) As Integer
    Rounds_Win As Byte

    TmpNick(1 To 2) As String
    PlayersDisconnect As Byte
End Type

Public Type RetoStruct
    Run As Boolean
    UsersTeam(1 To 2) As tRetoUser
    count_Down As Byte

    gold As Long
    Drop As Boolean
    NoValeResu As Boolean
End Type

Public Type UserStruct
    TempStruct As RetoStruct
    Accept_Count As Byte
    Reto_Index As Byte
    Team_Index As Byte

    IndexSender As Integer
    IndexRecieve As Integer

    ReturnHome As Byte
    AcceptedOK As Boolean
    AcceptLimitCount As Byte

    Nick_Sender As String
End Type

Private Retos2vs2Activos As New Collection
Public Reto_List() As RetoStruct

Public Sub Retos2vs2Load()

    On Error GoTo Errhandler

    Dim Leer As New clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "Retos2vs2.ini")

    Dim nArenas As Integer
    nArenas = val(Leer.GetValue("INIT", "Arenas"))

    If nArenas > 0 Then
        ReDim RetoPos(1 To nArenas, 1 To 2, 1 To 2) As Position
        ReDim Reto_List(1 To nArenas) As RetoStruct

        Dim i As Long
        Dim j As Long
        Dim p As Long
        Dim s As String

        For i = 1 To nArenas
            For j = 1 To 2
                For p = 1 To 2
                    s = Leer.GetValue("ARENA" & CStr(i), "Equipo" & CStr(j) & "Jugador" & CStr(p))

                    RetoPos(i, j, p).X = val(ReadField(2, s, 45))
                    RetoPos(i, j, p).Y = val(ReadField(3, s, 45))
                Next p
            Next j
        Next i
    End If

    Set Leer = Nothing
    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Retos2vs2Load en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Function Get_Reto_Slot() As Byte
    On Error GoTo Errhandler
    Dim LoopC As Long

    For LoopC = 1 To 8
        If Not Reto_List(LoopC).Run Then
            Get_Reto_Slot = LoopC
            Exit Function
        End If
    Next LoopC

    Get_Reto_Slot = 0
    Exit Function
Errhandler:
    Call LogError("Retos2vs2 - Error en Get_Reto_Slot en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Sub Set_Reto_Struct(ByVal UserIndex As Integer, _
                           ByVal My_Team As String, _
                           ByRef Enemy_Name As String, _
                           ByRef Team_Enemy As String, _
                           ByVal Drop As Boolean, _
                           ByVal gold As Long, _
                           ByVal Points As Long, _
                           ByVal Resu As Boolean)
1   On Error GoTo Errhandler
2   With UserList(UserIndex).sReto
3       .Accept_Count = 0
4       With .TempStruct
5           .count_Down = 0
6           .Run = False
7           With .UsersTeam(1)
8               .UserIndex(1) = UserIndex
9               .UserIndex(2) = NameIndex(My_Team)
10              .TmpNick(1) = UserList(.UserIndex(1)).Name
232             .TmpNick(2) = UserList(.UserIndex(2)).Name
121             .PlayersDisconnect = 0
13          End With
14          With .UsersTeam(2)
15              .UserIndex(1) = NameIndex(Enemy_Name)
16              .UserIndex(2) = NameIndex(Team_Enemy)
17              .TmpNick(1) = UserList(.UserIndex(1)).Name
18              .TmpNick(2) = UserList(.UserIndex(2)).Name
19              .PlayersDisconnect = 0
20          End With
21          .Drop = Drop
22          .gold = gold
23          .NoValeResu = Resu
        End With
    End With
    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Set_Reto_Struct en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Public Function Can_Send_Reto(ByVal UserIndex As Integer, ByRef fError As String) As Boolean
    On Error GoTo Errhandler

    If ESTADO_RETOS_2VS2 = 0 Then
        fError = "Los retos 2VS2 están deshabilitados temporalmente por el Servidor."
        Exit Function
    End If

    With UserList(UserIndex)

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            fError = "Debes estar en tu hogar para retar."
            Exit Function
        End If

        If (.flags.Muerto <> 0) Then
            fError = "¡Estás muerto!"
            Exit Function
        End If

        If (.Counters.Pena <> 0) Then
            fError = "Estás en la cárcel"
            Exit Function
        End If

        If (.Stats.GLD < COSTO_RETOS_2VS2) Then
            fError = "No tienes el oro suficiente. Recuerda que el costo para retar es de " & COSTO_RETOS_2VS2 & " monedas de oro."
            Exit Function
        End If

        If (.sReto.TempStruct.gold < MIN_GOLD) Then
            fError = "El mínimo de oro para retar es de " & MIN_GOLD & " monedas de oro y necesitas " & COSTO_RETOS_2VS2 & " monedas de oro extra para pagar el reto."
            Exit Function
        End If

        If (.sReto.TempStruct.gold > MAX_GOLD) Then
            fError = "El máximo de oro para retar es de " & MAX_GOLD & " monedas de oro."
            Exit Function
        End If

        If (.Stats.GLD < (.sReto.TempStruct.gold)) Then
            fError = "No tienes el oro suficiente, te faltan " & ((.sReto.TempStruct.gold + COSTO_RETOS_2VS2) - .Stats.GLD) & " monedas de oro."
            Exit Function
        End If

        If (.Stats.GLD < (.sReto.TempStruct.gold + COSTO_RETOS_2VS2)) Then
            fError = "No tienes el oro suficiente, te faltan " & ((.sReto.TempStruct.gold + COSTO_RETOS_2VS2) - .Stats.GLD) & " monedas de oro. Recuerda que el costo para retar es de " & COSTO_RETOS_2VS2 & " monedas de oro."
            Exit Function
        End If

        If (.mReto.Reto_Index <> 0) Then
            fError = "Ya estás en reto."
            Exit Function
        End If

        If (.Stats.ELV < 20) Then
            fError = "Debes ser mayor o igual a nivel 20!"
            Exit Function
        End If

        With .sReto.TempStruct

            Can_Send_Reto = Check_User(.UsersTeam(1).UserIndex(2), fError, .gold, UserIndex)

            If Can_Send_Reto Then
                Can_Send_Reto = Check_User(.UsersTeam(2).UserIndex(1), fError, .gold, UserIndex)
            Else
                Exit Function
            End If

            If Can_Send_Reto Then
                Can_Send_Reto = Check_User(.UsersTeam(2).UserIndex(2), fError, .gold, UserIndex)
            Else
                Exit Function
            End If

        End With

    End With

    Exit Function
Errhandler:
    Call LogError("Retos2vs2 - Error en Can_Send_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Private Function Check_AcceptUser(ByVal UserIndex As Integer, ByVal nGold As Long, ByRef fError As String) As Boolean
    On Error GoTo Errhandler
    With UserList(UserIndex)

        If .flags.Muerto <> 0 Then
            fError = "Estás muerto."
            Exit Function
        End If

        If MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk Then
            fError = "Debes estar en tu hogar para participar en un reto."
            Exit Function
        End If

        If .Stats.GLD < nGold + COSTO_RETOS_2VS2 Then
            fError = "No tienes el oro suficiente para aceptar el reto (" & nGold + COSTO_RETOS_2VS2 & "). Recuerda que todos deben tener " & COSTO_RETOS_2VS2 & " monedas de oro para pagar el costo del Reto."
            Exit Function
        End If

        If (.mReto.Reto_Index <> 0) Then
            fError = "Ya estás en reto."
            Exit Function
        End If

        If .sReto.AcceptedOK Then
            fError = "¡Ya has aceptado!"
            Exit Function
        End If

        If UserIndex = .sReto.IndexRecieve Then
            Call WriteConsoleMsg(UserIndex, "No te puedes aceptar a ti mismo.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

    End With

    Check_AcceptUser = True

    Exit Function
Errhandler:
    Call LogError("Retos2vs2 - Error en Check_AcceptUser en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Private Function Check_User(ByVal UserIndex As Integer, _
                            ByRef fError As String, _
                            ByVal goldGamble As Long, _
                            ByVal Send_Index As Integer) As Boolean
    On Error GoTo Errhandler
    If (UserIndex = 0) Then
        fError = "Algún usuario está offline."
        Exit Function
    End If

    With UserList(UserIndex)

        If .sReto.IndexRecieve = Send_Index Then
            fError = "Ya le mandase solicitud de reto a " & .Name & "."
            Exit Function
        End If

        If (.flags.Muerto <> 0) Then
            fError = .Name & " ¡Está muerto!"
            Exit Function
        End If

        If (.Counters.Pena <> 0) Then
            fError = .Name & " Está en la cárcel"
            Exit Function
        End If

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            fError = .Name & " está fuera de su hogar."
            Exit Function
        End If

        If (.mReto.Reto_Index <> 0) Then
            fError = .Name & " ya está en reto."
            Exit Function
        End If

        'If (.Stats.GLD < goldGamble) Then
        '    fError = .Name & " no tiene el oro necesario"
        '    Exit Function
        'End If

        If (.Stats.GLD < goldGamble + COSTO_RETOS_2VS2) Then
            fError = .Name & " no tiene el oro necesario (" & goldGamble + COSTO_RETOS_2VS2 & "), recuerda que todos deben tener " & COSTO_RETOS_2VS2 & " monedas de oro para pagar el costo del Reto."
            Exit Function
        End If

        If (.Stats.ELV < 20) Then
            fError = .Name & " debe ser mayor o igual a nivel 20!"
            Exit Function
        End If

    End With

    Check_User = True

    Exit Function
Errhandler:
    Call LogError("Retos2vs2 - Error en Check_User en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function Retos2vs2_ValeResucitar(ByVal Reto_Index As Byte) As Boolean

    Retos2vs2_ValeResucitar = (Reto_List(Reto_Index).NoValeResu = False)

End Function

Public Sub Send_Reto(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    Dim i As Long, j As Long
    Dim User(0 To 3) As String

    With UserList(UserIndex).sReto.TempStruct

        User(0) = UserList(.UsersTeam(1).UserIndex(1)).Name
        User(1) = UserList(.UsersTeam(1).UserIndex(2)).Name
        User(2) = UserList(.UsersTeam(2).UserIndex(1)).Name
        User(3) = UserList(.UsersTeam(2).UserIndex(2)).Name

        For i = 1 To 2
            For j = 1 To 2
                If (.UsersTeam(i).UserIndex(j) <> UserIndex) Then

                    UserList(.UsersTeam(i).UserIndex(j)).sReto.IndexRecieve = UserIndex
                    UserList(.UsersTeam(i).UserIndex(j)).sReto.Nick_Sender = UserList(UserIndex).Name

10                  If (.UsersTeam(i).UserIndex(j) <> UserIndex) Then
                        Call WriteConsoleMsg(.UsersTeam(i).UserIndex(j), UserList(UserIndex).Name & " te invita a participar del reto " & UserList(.UsersTeam(1).UserIndex(1)).Name & "(" & UserList(.UsersTeam(1).UserIndex(1)).Stats.ELV & ") y " & UserList(.UsersTeam(1).UserIndex(2)).Name & "(" & UserList(.UsersTeam(1).UserIndex(2)).Stats.ELV & ") Vs " & UserList(.UsersTeam(2).UserIndex(1)).Name & "(" & UserList(.UsersTeam(2).UserIndex(1)).Stats.ELV & ") y " & UserList(.UsersTeam(2).UserIndex(2)).Name & "(" & UserList(.UsersTeam(2).UserIndex(2)).Stats.ELV & "). Apuesta " & .gold & " monedas de oro" & IIf(.Drop, " y por los items.", ".") & IIf(.NoValeResu = True, " NO VALE RESUCITAR. ", "") & " Para aceptar escribe /RETAR " & UserList(UserIndex).Name & " o /RECHAZAR " & UserList(UserIndex).Name & " para negarselo.", FontTypeNames.FONTTYPE_GUILD)
                    End If
                End If
            Next j
        Next i

        Call WriteConsoleMsg(UserIndex, "Se han enviado las solicitudes.", FontTypeNames.FONTTYPE_GUILD)

        UserList(UserIndex).sReto.AcceptLimitCount = 30
        UserList(UserIndex).sReto.IndexSender = UserIndex

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Send_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub DisconnectUserReto2vs2(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Reto_Index = UserList(UserIndex).sReto.Reto_Index

    If Reto_Index > 0 Then
        Dim Team_Index As Byte
        Team_Index = UserList(UserIndex).sReto.Team_Index

        If Reto_List(Reto_Index).Drop Then
            Call TirarTodosLosItems(UserIndex, RETO_MAP_2_DROP, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y)
        End If

        Reto_List(Reto_Index).UsersTeam(Team_Index).PlayersDisconnect = Reto_List(Reto_Index).UsersTeam(Team_Index).PlayersDisconnect + 1

        Dim Compa_Index As Integer
        Compa_Index = IIf(Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(1) = UserIndex, 2, 1)

        Call WarpUserCharX(UserIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, False)
        Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(IIf(Compa_Index = 1, 2, 1)) = 0

        If Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(Compa_Index) > 0 Then

            If UserList(Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(Compa_Index)).flags.Muerto = 0 Then
                Call WriteConsoleMsg(Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(Compa_Index), "Reto> " & UserList(UserIndex).Name & " se desconectó del reto, si deslogueas vos también perderás el reto 2vs2.", FontTypeNames.FONTTYPE_GUILD)
            Else
                Call Team_Winner(Reto_Index, IIf(Team_Index = 1, 2, 1))
            End If
        Else
            Dim TeamWinner As Byte
            TeamWinner = IIf(Team_Index = 1, 2, 1)

            Reto_List(Reto_Index).UsersTeam(TeamWinner).Rounds_Win = 2
            Call Finish_Reto(Reto_Index, TeamWinner)
        End If
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en DisconnecTuserReto2vs2 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Accept_Reto(ByVal UserIndex As Integer, ByVal SendIndex As Integer)
    On Error GoTo Errhandler
    Dim s As String

    If Check_AcceptUser(UserIndex, UserList(SendIndex).sReto.TempStruct.gold, s) = False Then
        Call WriteConsoleMsg(UserIndex, s, FontTypeNames.FONTTYPE_GUILD)
        Exit Sub
    End If

    UserList(SendIndex).sReto.Accept_Count = UserList(SendIndex).sReto.Accept_Count + 1
    Call Message_Reto(UserList(SendIndex).sReto.TempStruct, UserList(UserIndex).Name & " aceptó el reto.")

    If UserList(SendIndex).sReto.Accept_Count > 2 Then
        Call Init_Reto(SendIndex)
        Call Message_Reto(UserList(SendIndex).sReto.TempStruct, "Todos los participantes han aceptado el reto.")
    End If

    UserList(UserIndex).sReto.AcceptedOK = True

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Accept_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Init_Reto(ByVal UserSendIndex As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Reto_Index = Get_Reto_Slot()

    If (Reto_Index < 1) Then
        Call Message_Reto(UserList(UserSendIndex).sReto.TempStruct, "Reto cancelado, todas las arenas están ocupadas.")
        Exit Sub
    End If

    UserList(UserSendIndex).sReto.AcceptLimitCount = 0

    Reto_List(Reto_Index) = UserList(UserSendIndex).sReto.TempStruct
    Reto_List(Reto_Index).Run = True
    Reto_List(Reto_Index).count_Down = 11

    Call Warp_Teams(Reto_Index)
    Call Retos2vs2Activos.Add(Reto_Index)

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Init_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Warp_Teams(ByVal Reto_Index As Byte, Optional ByVal RespawnUser As Boolean = False)
    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim mPosX As Byte
    Dim mPosY As Byte
    Dim nUser As Integer

    Dim RingDataTemp(0 To 1) As Position
    RingDataTemp(0) = RetoPos(Reto_Index, 1, 1)
    RetoPos(Reto_Index, 1, 1) = RetoPos(Reto_Index, 2, 1)
    RetoPos(Reto_Index, 2, 1) = RingDataTemp(0)

    RingDataTemp(1) = RetoPos(Reto_Index, 1, 2)
    RetoPos(Reto_Index, 1, 2) = RetoPos(Reto_Index, 2, 2)
    RetoPos(Reto_Index, 2, 2) = RingDataTemp(1)

    With Reto_List(Reto_Index)
        .count_Down = 11

        For LoopC = 1 To 2
            nUser = .UsersTeam(1).UserIndex(LoopC)

            If nUser <> 0 Then
                If UserList(nUser).ConnIDValida Then
                    mPosX = Get_Pos_X(Reto_Index, 1, CInt(LoopC))
                    mPosY = Get_Pos_Y(Reto_Index, 1, CInt(LoopC))

                    Call WarpUserCharX(nUser, RETO_MAP_2, mPosX, mPosY, True)
                    'Call WarpUserChar(N, RetoMap, Give_Pos_X(Reto_Index, LoopC), Give_Pos_Y(Reto_Index, LoopC), False, True)
                    Call WritePosUpdate(nUser)

                    Call WritePauseToggle(nUser)

                    Call WriteCuentaRegresiva(nUser, .count_Down)

                    If RespawnUser Then
                        If UserList(nUser).flags.Muerto Then Call RevivirUsuario(nUser)

                        UserList(nUser).Stats.MinHP = UserList(nUser).Stats.MaxHP
                        UserList(nUser).Stats.MinMAN = UserList(nUser).Stats.MaxMAN
                        UserList(nUser).Stats.minSta = UserList(nUser).Stats.MaxSta

                        Call WriteUpdateStatsNew(nUser)
                    Else

                        UserList(nUser).flags.oculto = 0
                        UserList(nUser).flags.oculto = 0
                        Call UsUaRiOs.SetInvisible(nUser, UserList(nUser).Char.CharIndex, UserList(nUser).flags.invisible = 1, UserList(nUser).flags.oculto = 1)

                        UserList(nUser).sReto.Reto_Index = Reto_Index
                        UserList(nUser).sReto.Team_Index = 1
                        UserList(nUser).flags.UserInEvent = True

                        UserList(nUser).sReto.IndexRecieve = 0
                        UserList(nUser).sReto.IndexSender = 0

                        UserList(nUser).Stats.GLD = UserList(nUser).Stats.GLD - Reto_List(Reto_Index).gold
                        Call WriteUpdateGold(nUser)
                    End If

                Else

                    UserList(nUser).sReto.AcceptedOK = False

                End If

            End If

            nUser = .UsersTeam(2).UserIndex(LoopC)

            If nUser <> 0 Then
                If UserList(nUser).ConnIDValida Then
                    mPosX = Get_Pos_X(Reto_Index, 2, CInt(LoopC))
                    mPosY = Get_Pos_Y(Reto_Index, 2, CInt(LoopC))

                    Call WritePauseToggle(nUser)
                    Call WarpUserCharX(nUser, RETO_MAP_2, mPosX, mPosY, True)

                    Call WriteCuentaRegresiva(nUser, .count_Down)

                    If RespawnUser Then
                        If UserList(nUser).flags.Muerto Then Call RevivirUsuario(nUser)

                        UserList(nUser).Stats.MinHP = UserList(nUser).Stats.MaxHP
                        UserList(nUser).Stats.MinMAN = UserList(nUser).Stats.MaxMAN
                        UserList(nUser).Stats.minSta = UserList(nUser).Stats.MaxSta

                        Call WriteUpdateStatsNew(nUser)
                    Else

                        UserList(nUser).flags.oculto = 0
                        UserList(nUser).flags.oculto = 0
                        Call UsUaRiOs.SetInvisible(nUser, UserList(nUser).Char.CharIndex, UserList(nUser).flags.invisible = 1, UserList(nUser).flags.oculto = 1)

                        UserList(nUser).sReto.Reto_Index = Reto_Index
                        UserList(nUser).sReto.Team_Index = 2
                        UserList(nUser).flags.UserInEvent = True

                        UserList(nUser).sReto.IndexRecieve = 0
                        UserList(nUser).sReto.IndexSender = 0

                        UserList(nUser).Stats.GLD = UserList(nUser).Stats.GLD - Reto_List(Reto_Index).gold
                        Call WriteUpdateGold(nUser)

                    End If

                Else

                    UserList(nUser).sReto.AcceptedOK = False

                End If

            End If

        Next LoopC

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Warp_Teams en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Message_Reto(ByRef RetoStr As RetoStruct, ByVal sMessage As String)
    On Error GoTo Errhandler
    Dim i As Long
    Dim j As Long
    Dim U As Integer

    For i = 1 To 2
        For j = 1 To 2
            U = RetoStr.UsersTeam(i).UserIndex(j)

            If U > 0 Then
                If UserList(U).ConnIDValida Then
                    Call WriteConsoleMsg(U, sMessage, FontTypeNames.FONTTYPE_GUILD)
                End If
            End If
        Next j
    Next i

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Message_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub User_Die_Reto(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Reto_Index = UserList(UserIndex).sReto.Reto_Index
    If Reto_Index < 1 Then Exit Sub

    Dim Team_Index As Integer
    Team_Index = UserList(UserIndex).sReto.Team_Index

    Dim Compa_Index As Integer

    If Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(1) = UserIndex Then
        Compa_Index = Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(2)
    Else
        Compa_Index = Reto_List(Reto_Index).UsersTeam(Team_Index).UserIndex(1)
    End If

    'Is dead?
    If Compa_Index > 0 Then
        If UserList(Compa_Index).flags.Muerto Then
            Call Team_Winner(Reto_Index, IIf(Team_Index = 1, 2, 1))
            Exit Sub
        End If
    Else
        Call Team_Winner(Reto_Index, IIf(Team_Index = 1, 2, 1))
        Exit Sub
    End If

    If Reto_List(Reto_Index).NoValeResu Then
        'warp afuera paaaa
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en User_Die_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Team_Winner(ByVal Reto_Index As Byte, ByVal Team_Winner As Byte)
    On Error GoTo Errhandler
    Reto_List(Reto_Index).UsersTeam(Team_Winner).Rounds_Win = Reto_List(Reto_Index).UsersTeam(Team_Winner).Rounds_Win + 1

    If Reto_List(Reto_Index).UsersTeam(Team_Winner).Rounds_Win >= 2 Then
        Call Finish_Reto(Reto_Index, Team_Winner)
    Else
        Call Respawn_Reto(Reto_Index, Team_Winner)
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Team_Winner en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Respawn_Reto(ByVal Reto_Index As Byte, ByVal Team_Winner As Integer)
    On Error GoTo Errhandler
    Dim LoopX As Long
    Dim LoopC As Long
    Dim mStr As String
    Dim N As Integer

    With Reto_List(Reto_Index)
        mStr = "Ganador del round equipo de " & .UsersTeam(Team_Winner).TmpNick(1) & " y " & .UsersTeam(Team_Winner).TmpNick(2) & "." & vbCrLf & _
               "Resultado parcial : " & .UsersTeam(1).TmpNick(1) & " y " & .UsersTeam(1).TmpNick(2) & " " & CStr(.UsersTeam(1).Rounds_Win) & " - " & .UsersTeam(2).TmpNick(1) & " y " & .UsersTeam(2).TmpNick(2) & " " & CStr(.UsersTeam(2).Rounds_Win)

        For LoopX = 1 To 2
            For LoopC = 1 To 2
                N = .UsersTeam(LoopX).UserIndex(LoopC)

                If N > 0 Then
                    If UserList(N).ConnIDValida Then
                        Call WriteConsoleMsg(N, mStr, FontTypeNames.FONTTYPE_GUILD)
                    End If
                End If
            Next LoopC
        Next LoopX

        Call Warp_Teams(Reto_Index, True)
        .count_Down = 11

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Respawn_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Finish_Reto(ByVal Reto_Index As Byte, ByVal Team_Winner As Byte)
    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim Team_Looser As Byte
    Dim Temp_Index As Integer

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(Get_Reto_Message(Reto_Index), FontTypeNames.FONTTYPE_INFO))
    Team_Looser = IIf(Team_Winner = 1, 2, 1)

    For LoopC = 1 To 2
        'Lossers
        Temp_Index = Reto_List(Reto_Index).UsersTeam(Team_Looser).UserIndex(LoopC)

        If Temp_Index > 0 Then
            If Reto_List(Reto_Index).Drop Then
                Call TirarTodosLosItems(Temp_Index, UserList(Temp_Index).Pos.Map, UserList(Temp_Index).Pos.X, UserList(Temp_Index).Pos.Y)
            End If

            Call WarpUserCharX(Temp_Index, Ullathorpe.Map, Ullathorpe.X + LoopC, Ullathorpe.Y, False)
            Call Reset_UserReto2vs2(Temp_Index)
        End If

        'Winners
        Temp_Index = Reto_List(Reto_Index).UsersTeam(Team_Winner).UserIndex(LoopC)

        If Temp_Index > 0 Then
            If Reto_List(Reto_Index).Drop Then
                UserList(Temp_Index).sReto.ReturnHome = 120
                Call WriteConsoleMsg(Temp_Index, "Reto> Tienes 2 minutos para recoger los items. Si terminas antes puedes escribir" & vbNewLine & "/ABANDONAR para salir del reto.", FontTypeNames.FONTTYPE_GUILD)
            Else
                Call WarpUserCharX(Temp_Index, 1, 57 + LoopC, 50, True)
                Call Reset_UserReto2vs2(Temp_Index)
            End If

            Call DarPremioEvento(Temp_Index, Reto_List(Reto_Index).gold * 2)
        End If
    Next LoopC

    If Not Reto_List(Reto_Index).Drop Then
        Call ClearMapReto(Reto_Index)
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Finish_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Function Get_Reto_Message(ByVal Reto_Index As Byte) As String
    On Error GoTo Errhandler
    Dim tempStr As String
    Dim TempUser As Integer

    Dim Disc1 As Byte
    Dim Disc2 As Byte

    With Reto_List(Reto_Index)

        With .UsersTeam(1)

            tempStr = tempStr & .TmpNick(1)
            TempUser = .UserIndex(1)

            If TempUser < 1 Then
                Disc1 = Disc1 + 1
            End If

            tempStr = tempStr & " y " & .TmpNick(2)
            TempUser = .UserIndex(2)

            If TempUser < 1 Then
                Disc1 = Disc1 + 1
            End If

        End With

        With .UsersTeam(2)

            tempStr = tempStr & " Vs " & .TmpNick(1)
            TempUser = .UserIndex(1)

            If TempUser < 1 Then
                Disc2 = Disc2 + 1
            End If

            tempStr = tempStr & " y " & .TmpNick(2)
            TempUser = .UserIndex(2)

            If TempUser < 1 Then
                Disc2 = Disc2 + 1
            End If

        End With

        Dim EquipWin As Byte

        If .UsersTeam(2).Rounds_Win > .UsersTeam(1).Rounds_Win Then
            EquipWin = 2
        Else
            EquipWin = 1
        End If

        tempStr = tempStr & ". Ganador el equipo de " & .UsersTeam(EquipWin).TmpNick(1) & " y " & .UsersTeam(EquipWin).TmpNick(2) & ". Apuesta por " & Format$(.gold, "#,###") & " monedas de oro"

        If .Drop Then
            tempStr = tempStr & " y los items del inventario"
        End If

        tempStr = tempStr & "."

        If Disc1 = 2 Or Disc2 = 2 Then
            tempStr = tempStr & " Por desconexión del team enemigo."
        End If

        Get_Reto_Message = "Retos " & tempStr

    End With

    Exit Function
Errhandler:
    Call LogError("Retos2vs2 - Error en Get_Reto_Message en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function Get_Pos_X(ByVal Ring_Index As Byte, _
                          ByVal Team_Index As Integer, _
                          ByVal UserIndex As Integer) As Integer

    Get_Pos_X = RetoPos(Ring_Index, Team_Index, UserIndex).X

End Function

Public Function Get_Pos_Y(ByVal Ring_Index As Byte, _
                          ByVal Team_Index As Integer, _
                          ByVal UserIndex As Integer) As Integer

    Get_Pos_Y = RetoPos(Ring_Index, Team_Index, UserIndex).Y

End Function

Public Sub Retos2vs2PassSecond()

    Dim LoopC As Long
    Dim RetoIndex As Byte

    For LoopC = 1 To Retos2vs2Activos.count
        RetoIndex = Retos2vs2Activos.Item(LoopC)

        If Reto_List(RetoIndex).Run Then
            Call Reto_Loop(RetoIndex)
        End If
    Next LoopC

End Sub

Private Sub Reto_Loop(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    If Reto_List(Reto_Index).count_Down > 0 Then
        Reto_List(Reto_Index).count_Down = Reto_List(Reto_Index).count_Down - 1

        If Reto_List(Reto_Index).count_Down < 1 Then
            Dim i As Long
            Dim j As Long
            Dim N As Long

            For i = 1 To 2
                For j = 1 To 2
                    N = Reto_List(Reto_Index).UsersTeam(i).UserIndex(j)

                    If N > 0 Then
                        If UserList(N).ConnIDValida Then
                            Call WritePauseToggle(N)
                        End If
                    End If
                Next j
            Next i
        End If
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Reto_Loop en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Loop_UserReto2vs2(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    With UserList(UserIndex).sReto

        If .AcceptLimitCount > 0 Then
            .AcceptLimitCount = .AcceptLimitCount - 1

            If .AcceptLimitCount < 1 Then
                Call ResetOtherUser2vs2(UserIndex)
                Call Message_Reto(.TempStruct, "El reto se ha autocancelado debido a que el tiempo para aceptar ha llegado a su límite.")
            End If
        End If

        If .ReturnHome > 0 Then
            .ReturnHome = .ReturnHome - 1

            If .ReturnHome < 1 Then
                Call AbandonUserReto2vs2(UserIndex, .Reto_Index)
            End If
        End If

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Loop_UserReto2vs2 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub AbandonUserReto2vs2(ByVal Winner_Index As Integer, ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
1   Dim Team_ID As Byte
2   Team_ID = UserList(Winner_Index).sReto.Team_Index

33  If Team_ID = 0 Then
34      Call WriteConsoleMsg(Winner_Index, "Notificar al GM - Tu reto está bug al momento de abandonar. Team_ID = 0.")
35  End If

3   Reto_List(Reto_Index).UsersTeam(Team_ID).PlayersDisconnect = Reto_List(Reto_Index).UsersTeam(Team_ID).PlayersDisconnect + 1
4   Call WarpUserCharX(Winner_Index, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)

5   If Reto_List(Reto_Index).UsersTeam(Team_ID).PlayersDisconnect > 1 Then
6       Call ClearMapReto(Reto_Index)
    End If

7   Call Reset_UserReto2vs2(Winner_Index)
8   Call WriteConsoleMsg(Winner_Index, "Vuelves a la ciudad.", FontTypeNames.FONTTYPE_GUILD)

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en AbandonUserReto2vs2 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Reset_UserReto2vs2(ByVal UserIndex As Integer)

    Dim DumpStruct As RetoStruct

    With UserList(UserIndex).sReto
        .Accept_Count = 0
        .Reto_Index = 0
        .Team_Index = 0
        .IndexSender = 0
        .IndexRecieve = 0
        .ReturnHome = 0
        .AcceptedOK = False
        .AcceptLimitCount = 0
        .TempStruct = DumpStruct
    End With

    UserList(UserIndex).flags.UserInEvent = False

End Sub

Public Sub ResetOtherUser2vs2(ByVal Send_Index As Integer)
    On Error GoTo Errhandler
    Dim j As Long
    Dim i As Long
    Dim N As Integer

    For j = 1 To 2
        For i = 1 To 2
            N = UserList(Send_Index).sReto.TempStruct.UsersTeam(j).UserIndex(i)

            If N > 0 Then
                If UserList(N).sReto.IndexRecieve = Send_Index Then
                    UserList(N).sReto.IndexRecieve = 0
                    UserList(N).sReto.AcceptedOK = False
                End If
            End If
        Next i
    Next j

    UserList(Send_Index).sReto.Accept_Count = 0
    UserList(Send_Index).sReto.IndexRecieve = 0
    UserList(Send_Index).sReto.IndexSender = 0

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en ResetOtherUser2vs2 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Erase_RetoData(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    With Reto_List(Reto_Index)
        .count_Down = 0
        .Drop = False
        .gold = 0
        .NoValeResu = False
        .Run = False

        Dim i As Long

        For i = 1 To 2
            .UsersTeam(i).UserIndex(1) = 0
            .UsersTeam(i).UserIndex(2) = 0
            .UsersTeam(i).TmpNick(1) = vbNullString
            .UsersTeam(i).TmpNick(2) = vbNullString
            .UsersTeam(i).Rounds_Win = 0

            .UsersTeam(i).PlayersDisconnect = 0
        Next i
    End With

    Call Retos2vs2Activos.Remove(Reto_Index)

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en Erase_RetoData en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub ClearMapReto(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim X As Long
    Dim Y As Long

    Dim Player1 As Byte
    Dim Player2 As Byte

    If Get_Pos_Y(Reto_Index, 2, 1) > Get_Pos_Y(Reto_Index, 1, 1) Then
        Player1 = 2
        Player2 = 1
    Else
        Player1 = 1
        Player2 = 2
    End If

    For Y = Get_Pos_Y(Reto_Index, Player1, 1) To Get_Pos_Y(Reto_Index, Player2, 1)
        For X = Get_Pos_X(Reto_Index, Player1, 1) To Get_Pos_X(Reto_Index, Player2, 1)
            If MapData(RETO_MAP_2, X, Y).ObjInfo.ObjIndex > 0 Then
                Call EraseObj(MapData(RETO_MAP_2, X, Y).ObjInfo.Amount, RETO_MAP_2, X, Y)
            End If
        Next X
    Next Y

    Call Erase_RetoData(Reto_Index)

    Exit Sub
Errhandler:
    Call LogError("Retos2vs2 - Error en ClearMapReto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub


