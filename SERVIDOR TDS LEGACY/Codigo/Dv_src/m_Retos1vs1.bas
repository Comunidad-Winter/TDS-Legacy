Attribute VB_Name = "m_Retos1vs1"
Option Explicit

Public Const RETO_MAP As Byte = 192
Public Const RETO_MAP_DROP As Byte = 191

Public Const PLANTE_MAP As Byte = 228
Public Const PLANTE_MAP_DROP As Byte = 229

Public COSTO_RETOS_1VS1 As Long
Public ESTADO_RETOS_1VS1 As Byte

Private Const MIN_GOLD As Long = 10000
Private Const MAX_GOLD As Long = 2000000

Private Type tRetoUser
    UserIndex As Integer
    Rounds_Win As Byte

    LastPosition As WorldPos
End Type

Private Type Reto_Struct
    Run As Boolean
    users(0 To 1) As tRetoUser
    count_Down As Byte
    UpdateStats As Byte

    gold As Long
    Planted As Byte
    Drop As Byte
    Potions As Integer
    AIM As Byte
    CascoEscu As Byte
    Rounds As Byte
End Type

Public Retos1vs1Activos As New Collection
Public RetoList(1 To 8) As Reto_Struct

Public Sub Retos1vs1Load()
    On Error GoTo Errhandler
    Dim NumRoom As Integer
    Dim LoopC As Long
    Dim LoopX As Long
    Dim tempStr As String

    Dim Leer As New clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "Retos1vs1.ini")

    NumRoom = val(Leer.GetValue("INIT", "Arenas"))

    If NumRoom Then

        ReDim RingData(1 To NumRoom, 0 To 1) As Position
        ReDim PlantedData(1 To NumRoom) As Position
        ReDim RingCenter(1 To NumRoom) As Position

        For LoopC = 1 To NumRoom

            tempStr = Leer.GetValue("ARENA" & CStr(LoopC), "PJugador1")

            With PlantedData(LoopC)
                .X = val(ReadField(1, tempStr, 45))
                .Y = val(ReadField(2, tempStr, 45))

            End With

            For LoopX = 0 To 1

                tempStr = Leer.GetValue("ARENA" & CStr(LoopC), "Jugador" & CStr(LoopX + 1))

                With RingData(LoopC, LoopX)
                    .X = val(ReadField(1, tempStr, 45))
                    .Y = val(ReadField(2, tempStr, 45))
                End With

            Next LoopX

            RingCenter(LoopC).X = RingData(LoopC, 0).X + (RANGO_VISION_X - 1)
            RingCenter(LoopC).Y = RingData(LoopC, 0).Y + (RANGO_VISION_Y - 1)

        Next LoopC

    End If

    Set Leer = Nothing

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Retos1vs1Load en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Function CheckAttackPlayer(ByVal rIndex As Byte) As Boolean
    CheckAttackPlayer = RetoList(rIndex).count_Down < 1
End Function

Private Function Get_Reto_Slot() As Byte
    On Error GoTo Errhandler
    Dim LoopC As Long

    For LoopC = 1 To 8
        If Not RetoList(LoopC).Run Then
            Get_Reto_Slot = LoopC
            Exit Function
        End If
    Next LoopC

    Get_Reto_Slot = 0

    Exit Function
Errhandler:
    Call LogError("Retos1vs1 - Error en Get_Reto_Slot en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function Can_Send_Reto(ByVal Send_Index As Integer, ByRef Other_Index As Integer, ByVal gold As Long) As Boolean

    If ESTADO_RETOS_1VS1 = 0 Then
        Call WriteConsoleMsg(Send_Index, "Los retos 1VS1 están deshabilitados temporalmente por el Servidor.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If


    On Error GoTo Errhandler
    If Other_Index = Send_Index Then
        Call WriteConsoleMsg(Send_Index, "No puedes retarte a ti mismo.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    'Si al que le mando tiene una solicitud
    If UserList(Other_Index).mReto.IndexSender > 0 Then
        ' Y esa solicitud es mia entonces no le dejo
        If UserList(Other_Index).mReto.IndexSender = Send_Index Then
            Call WriteConsoleMsg(Send_Index, "Ya le mandaste solicitud de reto a " & UserList(Other_Index).Name & ".", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If
    Else
        'Al que le mando no tenia solicitud, pero me habia enviado solicitud
        If UserList(Other_Index).mReto.IndexRecieve = Send_Index Then
            Call WriteConsoleMsg(Send_Index, "Tienes la solicitud de reto " & UserList(Other_Index).Name & " pendiente.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If
    End If

    If UserList(Send_Index).Stats.GLD < COSTO_RETOS_1VS1 Then
        Call WriteConsoleMsg(Send_Index, "No tienes el oro suficiente. Recuerda que el costo para retar es de " & COSTO_RETOS_1VS1 & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    If gold < MIN_GOLD Then
        Call WriteConsoleMsg(Send_Index, "La apuesta mínima de oro es de " & MIN_GOLD & " monedas de oro. Recuerda que el costo extra para retar es de " & COSTO_RETOS_1VS1 & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    If gold > MAX_GOLD Then
        Call WriteConsoleMsg(Send_Index, "La apuesta maxima de oro es de " & MAX_GOLD & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    With UserList(Send_Index)

        If (.flags.Muerto <> 0) Then
            Call WriteConsoleMsg(Send_Index, "Estás muerto.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            Call WriteConsoleMsg(Send_Index, "Estás fuera de una zona segura.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.flags.Comerciando <> 0) Then
            Call WriteConsoleMsg(Send_Index, "Estás comerciando.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.Stats.ELV < 20) Then
            Call WriteConsoleMsg(Send_Index, "Tienes que ser mayor o igual al nivel 20.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.mReto.Reto_Index <> 0) Then
            Call WriteConsoleMsg(Send_Index, "Estás en reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        'If (.Stats.GLD < gold) Then
        '    Call WriteConsoleMsg(Send_Index, "No tienes el oro suficiente.", FontTypeNames.FONTTYPE_INFO)
        '    Exit Function
        'End If

        If (.Stats.GLD < gold + COSTO_RETOS_1VS1) Then
            Call WriteConsoleMsg(Send_Index, "No tienes el oro suficiente (" & gold + COSTO_RETOS_1VS1 & "). Recuerda que el costo para retar es de " & COSTO_RETOS_1VS1 & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

    End With

    With UserList(Other_Index)

        If (.flags.Muerto <> 0) Then
            Call WriteConsoleMsg(Send_Index, .Name & " está muerto.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.flags.Comerciando <> 0) Then
            Call WriteConsoleMsg(Send_Index, .Name & " está comerciando.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.Stats.ELV < 20) Then
            Call WriteConsoleMsg(Send_Index, .Name & " tiene que ser mayor o igual al nivel 20.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.mReto.Reto_Index <> 0) Then
            Call WriteConsoleMsg(Send_Index, .Name & " está en reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        'If (.Stats.GLD < gold) Then
        '    Call WriteConsoleMsg(Send_Index, .Name & " no tiene el oro suficiente.", FontTypeNames.FONTTYPE_INFO)
        '    Exit Function
        'End If

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            Call WriteConsoleMsg(Send_Index, .Name & " debe estar en una ciudad.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        If (.Stats.GLD < gold + COSTO_RETOS_1VS1) Then
            Call WriteConsoleMsg(Send_Index, .Name & " no tiene el oro suficiente (" & gold + COSTO_RETOS_1VS1 & "). Recuerda que el costo para retar es de " & COSTO_RETOS_1VS1 & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

    End With

    Can_Send_Reto = True

    Exit Function
Errhandler:
    Call LogError("Retos1vs1 - Error en Can_Send_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Sub Send_Reto(ByVal Send_Index As Integer, ByVal Other_Index As Integer, ByVal cGold As Long, ByVal cDrop As Byte, ByVal cPlanted As Byte, ByVal cPotions As Integer, ByVal cAIM As Byte, ByVal CascoEscu As Byte, ByVal cRounds As Byte)
    On Error GoTo Errhandler
    With UserList(Send_Index).mReto
        .Tmp_Gold = cGold
        .Tmp_Planted = cPlanted
        .Tmp_Drop = cDrop
        .Tmp_Potions = cPotions
        .Tmp_Aim = cAIM
        .Tmp_CascoEscu = CascoEscu
        .Tmp_Rounds = cRounds

        .IndexRecieve = Other_Index
    End With

    UserList(Other_Index).mReto.IndexSender = Send_Index
    UserList(Other_Index).mReto.AcceptLimitCount = 30

    Call WriteConsoleMsg(Send_Index, "Ahora debes esperar que " & UserList(Other_Index).Name & " acepte el reto.", FontTypeNames.FONTTYPE_INFO)

    Call WriteConsoleMsg(Other_Index, UserList(Send_Index).Name & " te invita a participar del reto " & IIf(cPlanted <> 0, "tipo **PLANTES** ", "") & UserList(Send_Index).Name & "(" & UserList(Send_Index).Stats.ELV & "). Apuesta " & cGold & " monedas de oro" & IIf(cDrop, " y por los items.", ".") & _
                                      IIf(cPotions > 0, vbNewLine & "LIMITE DE POCIONES ROJAS: " & Format$(cPotions, "###,###"), "") & _
                                      vbNewLine & "Para aceptar escribe /RETAR " & UserList(Send_Index).Name & " o /RECHAZAR " & UserList(Send_Index).Name & " para negarselo.", FontTypeNames.FONTTYPE_GUILD)

    If cPotions > 0 Then
        Call WriteConsoleMsg(Other_Index, "Reto> Con limitación de pociones rojas: " & cPotions, FontTypeNames.FONTTYPE_GUILD)
    End If

    If cDrop > 0 Then
        Call WriteConsoleMsg(Other_Index, "Reto> ES POR LOS ITEMS!!", FontTypeNames.FONTTYPE_GUILD)
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Send_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Can_AcceptReto1vs1(ByVal userAccept As Integer, ByVal userSend As Integer)
    On Error GoTo Errhandler
    Dim gold As Long
    Dim PotionsLimit As Long
    Dim CountPotions As Long

    gold = UserList(userSend).mReto.Tmp_Gold
    PotionsLimit = UserList(userSend).mReto.Tmp_Potions

    With UserList(userAccept)

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            Call WriteConsoleMsg(userAccept, "Debes estar en una ciudad segura para participar en un reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.flags.Muerto <> 0) Then
            Call WriteConsoleMsg(userAccept, "No puedes retar en ese estado!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.flags.Comerciando <> 0) Then
            Call WriteConsoleMsg(userAccept, "Debes dejar de comerciar.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.Stats.ELV < 20) Then
            Call WriteConsoleMsg(userAccept, "Debes ser mayor o igual al nivel 20 aceptar un reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If gold < 0 Then
            Call WriteConsoleMsg(userAccept, "El oro solicitado es inválido.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.Stats.GLD < gold + COSTO_RETOS_1VS1) Then
            Call WriteConsoleMsg(userAccept, "No tienes el oro suficiente (" & gold + COSTO_RETOS_1VS1 & "). Recuerda que los dos deben tener " & COSTO_RETOS_1VS1 & " monedas de oro para pagar el Reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If .mReto.Reto_Index <> 0 Then
            Call WriteConsoleMsg(userAccept, "Ya estás en reto!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

    End With

    If PotionsLimit > 0 Then
        CountPotions = Potion_Red(userAccept)

        If CountPotions > PotionsLimit Then
            Call WriteConsoleMsg(userAccept, "Tienes " & CountPotions & " pociones rojas y el límite en el reto es de " & PotionsLimit & " pociones. Depositá " & (CountPotions - PotionsLimit) & " pociones rojas.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
    End If

    ' @@ El enviador esta en condiciones?
    With UserList(userSend)

        If (MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk) Then
            Call WriteConsoleMsg(userAccept, "El oponente está fuera de su hogar.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.flags.Muerto <> 0) Then
            Call WriteConsoleMsg(userAccept, "Está muerto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.flags.Comerciando <> 0) Then
            Call WriteConsoleMsg(userAccept, "El oponente está comerciando.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.Stats.ELV < 20) Then
            Call WriteConsoleMsg(userAccept, "El oponente es menor al nivel 20.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If gold < 0 Then
            Call WriteConsoleMsg(userAccept, "Solicitud de reto inválida.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.Stats.GLD < gold + COSTO_RETOS_1VS1) Then
            Call WriteConsoleMsg(userAccept, "El oponente no tiene el oro suficiente (" & gold + COSTO_RETOS_1VS1 & "). Recuerda que los dos deben tener " & COSTO_RETOS_1VS1 & " monedas de oro para pagar el Reto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If (.mReto.Reto_Index <> 0) Then
            Call WriteConsoleMsg(userAccept, "El oponente ya está en reto!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

    End With

    If PotionsLimit > 0 Then
        CountPotions = Potion_Red(userSend)

        If CountPotions > PotionsLimit Then
            Call WriteConsoleMsg(userSend, "Tienes " & CountPotions & " pociones rojas y el limite que estableciste en el reto es de " & PotionsLimit & " pociones. Depositá " & (CountPotions - PotionsLimit) & " pociones rojas.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
    End If

    Call Init_Reto(userSend, userAccept)

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Can_AcceptReto1vs1 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Function Potion_Red(ByVal ID As Integer) As Long
    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim Total As Long

    With UserList(ID)

        For LoopC = 1 To .CurrentInventorySlots
            If .Invent.Object(LoopC).ObjIndex = 38 Then
                Total = Total + .Invent.Object(LoopC).Amount
            End If
        Next LoopC

        Potion_Red = Total

    End With

    Exit Function
Errhandler:
    Call LogError("Retos1vs1 - Error en Potion_Red en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Private Sub DesequiparUser(ByVal UI As Integer)
    On Error GoTo Errhandler
    With UserList(UI).Invent

        If .CascoEqpObjIndex > 0 Then
            Call Desequipar(UI, .CascoEqpSlot, True)
        End If

        If .EscudoEqpObjIndex > 0 Then
            Call Desequipar(UI, .EscudoEqpSlot, True)
        End If

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en DesequiparUser en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Init_Reto(ByVal Send_Index As Integer, ByVal Other_Index As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Reto_Index = Get_Reto_Slot()

    If Reto_Index > 0 Then

        With RetoList(Reto_Index)

            .Run = True
            .count_Down = 11
            .UpdateStats = 0

            .users(0).UserIndex = Send_Index
            .users(0).Rounds_Win = 0

            .users(1).UserIndex = Other_Index
            .users(1).Rounds_Win = 0

            .gold = UserList(Send_Index).mReto.Tmp_Gold
            .Planted = UserList(Send_Index).mReto.Tmp_Planted
            .Drop = UserList(Send_Index).mReto.Tmp_Drop
            .Potions = UserList(Send_Index).mReto.Tmp_Potions
            .AIM = UserList(Send_Index).mReto.Tmp_Aim
            .CascoEscu = UserList(Send_Index).mReto.Tmp_CascoEscu
            .Rounds = UserList(Send_Index).mReto.Tmp_Rounds
        End With

        UserList(Send_Index).flags.oculto = 0
        UserList(Other_Index).flags.oculto = 0
        UserList(Send_Index).flags.invisible = 0
        UserList(Other_Index).flags.invisible = 0
        Call UsUaRiOs.SetInvisible(Send_Index, UserList(Send_Index).Char.CharIndex, UserList(Send_Index).flags.invisible = 1, UserList(Send_Index).flags.oculto = 1)
        Call UsUaRiOs.SetInvisible(Other_Index, UserList(Other_Index).Char.CharIndex, UserList(Other_Index).flags.invisible = 1, UserList(Other_Index).flags.oculto = 1)

        Call Warp_Players(Reto_Index)

        Call WriteConsoleMsg(Send_Index, "Reto> " & UserList(Send_Index).Name & " Vs " & UserList(Other_Index).Name & ".", FontTypeNames.FONTTYPE_GUILD)
        Call WriteConsoleMsg(Other_Index, "Reto> " & UserList(Send_Index).Name & " Vs " & UserList(Other_Index).Name & ".", FontTypeNames.FONTTYPE_GUILD)

    Else

        Call WriteConsoleMsg(Send_Index, "Retos> El reto no ha podido iniciarse porque todas las salas están siendo ocupadas.", FontTypeNames.FONTTYPE_GUILD)
        Call WriteConsoleMsg(Other_Index, "Retos> El reto no ha podido iniciarse porque todas las salas están siendo ocupadas.", FontTypeNames.FONTTYPE_GUILD)

    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Init_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub UserDie_Reto(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Reto_Index = UserList(UserIndex).mReto.Reto_Index

    If Reto_Index < 1 Then Exit Sub
    If Not RetoList(Reto_Index).Run Then Exit Sub

    Dim Other_User As Integer
    Other_User = IIf(RetoList(Reto_Index).users(0).UserIndex = UserIndex, 1, 0)
    Other_User = RetoList(Reto_Index).users(Other_User).UserIndex

    If (Other_User <> 0) Then
        If UserList(Other_User).ConnIDValida Then
            Call Winner_Reto(UserIndex)
        End If
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en UserDie_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Winner_Reto(ByVal Die_Index As Integer)
    On Error GoTo Errhandler
    Dim Reto_Index As Byte
    Dim Winner_ID As Byte

    Reto_Index = UserList(Die_Index).mReto.Reto_Index
    Winner_ID = IIf(RetoList(Reto_Index).users(0).UserIndex = Die_Index, 1, 0)

    RetoList(Reto_Index).users(Winner_ID).Rounds_Win = (RetoList(Reto_Index).users(Winner_ID).Rounds_Win + 1)

    If (RetoList(Reto_Index).users(Winner_ID).Rounds_Win) >= RetoList(Reto_Index).Rounds Then
        Call End_Reto(Reto_Index, Winner_ID)
    Else
        Call Respawn_Reto(Reto_Index, Winner_ID)
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Winner_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub DisconnectUserReto1vs1(ByVal UserIndex As Integer)
    Call End_Reto(UserList(UserIndex).mReto.Reto_Index, IIf(RetoList(UserList(UserIndex).mReto.Reto_Index).users(0).UserIndex = UserIndex, 1, 0), True)
End Sub

Private Sub Respawn_Reto(ByVal Reto_Index As Byte, ByVal Winner_Index As Byte)
    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim N As Integer
    Dim Str As String
    Dim RetoMap As Integer

    With RetoList(Reto_Index)
        Str = "Reto> Ganador del round " & UserList(.users(Winner_Index).UserIndex).Name & "." & vbNewLine & _
              "Reto> Resultado parcial: " & .users(0).Rounds_Win & "-" & .users(1).Rounds_Win & "."


        Dim RingDataTemp As Position
        RingDataTemp = RingData(Reto_Index, 0)
        RingData(Reto_Index, 0) = RingData(Reto_Index, 1)
        RingData(Reto_Index, 1) = RingDataTemp

        If .Planted < 1 Then
            RetoMap = RETO_MAP
        Else
            RetoMap = PLANTE_MAP
        End If
        Dim origCountDown As Byte
        origCountDown = .count_Down
        .count_Down = 11
        .UpdateStats = 1

        For LoopC = 0 To 1
            N = .users(LoopC).UserIndex

            If (N > 0) Then
                If UserList(N).ConnIDValida Then
                    If UserList(N).flags.Muerto > 0 Then
                        UserList(N).flags.Muerto = 0
                        Call DarCuerpoDesnudo(N)
                        UserList(N).Char.Head = UserList(N).OrigChar.Head
                    Else
                        If UserList(N).flags.Paralizado = 1 Or UserList(N).flags.Inmovilizado = 1 Then
                            UserList(N).flags.Paralizado = 0
                            UserList(N).flags.Inmovilizado = 0
                            UserList(N).Counters.Paralisis = 0
                            Call WriteParalizeOK(N)
                        End If
                    End If
                    UserList(N).Stats.MinHP = UserList(N).Stats.MaxHP
                    WriteUpdateHP N

                    UserList(N).Stats.minSta = UserList(N).Stats.MaxSta
                    WriteUpdateSta N

                    If .Planted < 1 Then
                        If origCountDown = 0 Then
                            Call WritePauseToggle(N)
                        End If
                        Call WarpUserChar(N, RetoMap, Give_Pos_X(Reto_Index, LoopC), Give_Pos_Y(Reto_Index, LoopC), False, True)
                        Call WritePosUpdate(N)
                    Else
                        Call WarpUserCharX(N, RetoMap, GivePlanted_Pos_X(Reto_Index, LoopC), GivePlanted_Pos_Y(Reto_Index))
                    End If

                    Call WriteCuentaRegresiva(N, .count_Down)
                    Call WriteConsoleMsg(N, Str, FontTypeNames.FONTTYPE_GUILD)
                End If
            End If
        Next LoopC

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Respawn_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub UpdateStats_Reto(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    RetoList(Reto_Index).UpdateStats = 0

    Dim LoopC As Long, N As Integer

    For LoopC = 0 To 1
        N = RetoList(Reto_Index).users(LoopC).UserIndex

        If (N > 0) Then
            If UserList(N).ConnIDValida Then
                UserList(N).Stats.MinHP = UserList(N).Stats.MaxHP
                UserList(N).Stats.MinMAN = UserList(N).Stats.MaxMAN
                UserList(N).Stats.minSta = UserList(N).Stats.MaxSta
            End If
        End If
    Next LoopC

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en UpdateStats_Reto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub End_Reto(ByVal Reto_Index As Byte, ByVal Winner As Byte, Optional ByVal DESCONEXION As Boolean = False)

10  On Error GoTo End_Reto_Error

    Dim Winner_Index As Integer
    Dim Looser_Index As Integer

    Dim Losser As Byte
20  Losser = IIf(Winner = 0, 1, 0)

30  With RetoList(Reto_Index)

40      Winner_Index = .users(Winner).UserIndex
50      Looser_Index = .users(Losser).UserIndex

60      If .Drop Then

            Dim PosDrop As WorldPos
            If .Planted Then
80              PosDrop.Map = PLANTE_MAP_DROP
            Else
                PosDrop.Map = RETO_MAP_DROP
            End If

90          PosDrop.X = RingCenter(Reto_Index).X - 2
100         PosDrop.Y = RingCenter(Reto_Index).Y - 1

110         Call TirarTodosLosItems(Looser_Index, PosDrop.Map, PosDrop.X, PosDrop.Y)

160     End If
        If UserList(Looser_Index).flags.Paralizado = 1 Or UserList(Looser_Index).flags.Inmovilizado = 1 Then
            UserList(Looser_Index).flags.Paralizado = 0
            UserList(Looser_Index).flags.Inmovilizado = 0
            UserList(Looser_Index).Counters.Paralisis = 0
            Call WriteParalizeOK(Looser_Index)
        End If
        If UserList(Winner_Index).flags.Paralizado = 1 Or UserList(Winner_Index).flags.Inmovilizado = 1 Then
            UserList(Winner_Index).flags.Paralizado = 0
            UserList(Winner_Index).flags.Inmovilizado = 0
            UserList(Winner_Index).Counters.Paralisis = 0
            Call WriteParalizeOK(Winner_Index)
        End If

        'Retos 1vs1 Ranking
170     UserList(Looser_Index).Stats.RetosPerdidos = UserList(Looser_Index).Stats.RetosPerdidos + 1
180     Call WarpUserCharX(Looser_Index, .users(Losser).LastPosition.Map, .users(Losser).LastPosition.X, .users(Losser).LastPosition.Y)

190     If .Drop Then
200         UserList(Winner_Index).mReto.ReturnHome = 120
210         Call WriteConsoleMsg(Winner_Index, "Reto> Tienes 2 minutos para recoger los items. Si terminas antes puedes escribir" & vbNewLine & "/ABANDONAR para salir del reto.", FontTypeNames.FONTTYPE_GUILD)
220         'Call SpawnBankers(Reto_Index)

230         If .Planted Then
240             Call WarpUserCharX(Winner_Index, PosDrop.Map, UserList(Winner_Index).Pos.X, UserList(Winner_Index).Pos.Y + 2, True)
250         Else
260             Call WarpUserCharX(Winner_Index, PosDrop.Map, RingCenter(Reto_Index).X, RingCenter(Reto_Index).Y, True)
270         End If
280     Else
            If .Drop = 0 Then
290             Call WarpUserCharX(Winner_Index, .users(Winner).LastPosition.Map, .users(Winner).LastPosition.X, .users(Winner).LastPosition.Y, True)
            End If
300         Call Reset_UserReto1vs1(Winner_Index)
310     End If

320     If .count_Down > 0 Then
330         If .Planted < 1 Then
340             Call WritePauseToggle(Winner_Index)
350         End If
            Call WriteCuentaRegresiva(Winner_Index, 0)
            Call WriteCuentaRegresiva(Looser_Index, 0)
360     End If

370     Call DarPremioEvento(Winner_Index, .gold * 2)

        'Retos 1vs1 Ranking
380     UserList(Winner_Index).Stats.RetosGanados = UserList(Winner_Index).Stats.RetosGanados + 1

400     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Retos> " & UserList(Winner_Index).Name & " vs " & UserList(Looser_Index).Name & ". Ganador " & UserList(Winner_Index).Name & ". Apuesta por " & .gold & " monedas de oro" & IIf(.Drop, " y los items", "") & IIf(DESCONEXION, " por desconexión del oponente.", "."), FontTypeNames.FONTTYPE_INFO))

440     If .Drop < 1 Then
450         Call ClearMapReto(Reto_Index)
470     End If

480     Call Reset_UserReto1vs1(Looser_Index)

490 End With

500 Exit Sub

End_Reto_Error:

510 Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure End_Reto of Módulo m_Retos1vs1 " & Erl & ".")

End Sub

Private Sub Erase_RetoData(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim LoopC As Long

    With RetoList(Reto_Index)

        .gold = 0
        .Planted = 0
        .Drop = 0
        .Potions = 0
        .AIM = 0
        .CascoEscu = 0
        .Rounds = 0
        .UpdateStats = 0

        .count_Down = 0
        .Run = False

        For LoopC = 0 To 1
            .users(LoopC).UserIndex = 0
            .users(LoopC).Rounds_Win = 0
        Next LoopC

    End With

    For LoopC = 1 To Retos1vs1Activos.count
        If Retos1vs1Activos.Item(LoopC) = Reto_Index Then
            Call Retos1vs1Activos.Remove(LoopC)
            Exit For
        End If
    Next LoopC

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Erase_RetoData en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Function GivePlanted_Pos_X(ByVal RoomID As Byte, ByVal nPlayer As Byte)
    If nPlayer <> 1 Then
        GivePlanted_Pos_X = PlantedData(RoomID).X + 1
    Else
        GivePlanted_Pos_X = PlantedData(RoomID).X
    End If
End Function

Public Function GivePlanted_Pos_Y(ByVal RoomID As Byte)
    GivePlanted_Pos_Y = PlantedData(RoomID).Y
End Function

Public Function Give_Pos_X(ByVal RoomID As Byte, ByVal nPlayer As Byte)
    Give_Pos_X = RingData(RoomID, nPlayer).X
End Function

Public Function Give_Pos_Y(ByVal RoomID As Byte, ByVal nPlayer As Byte)
    Give_Pos_Y = RingData(RoomID, nPlayer).Y
End Function

Private Sub Warp_Players(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim RetoMap As Integer

    If RetoList(Reto_Index).Planted < 1 Then
        RetoMap = RETO_MAP
    Else
        RetoMap = PLANTE_MAP
    End If

    Dim LoopC As Long
    Dim N As Integer

    For LoopC = 0 To 1
        N = RetoList(Reto_Index).users(LoopC).UserIndex

        If (N > 0) Then

            If UserList(N).ConnIDValida Then
                UserList(N).mReto.Reto_Index = Reto_Index
                UserList(N).flags.UserInEvent = True
                UserList(N).mReto.AcceptLimitCount = 0
                UserList(N).mReto.IndexSender = 0
                UserList(N).mReto.IndexRecieve = 0

                UserList(N).Stats.GLD = (UserList(N).Stats.GLD - Abs(RetoList(Reto_Index).gold))

                UserList(N).Stats.GLD = (UserList(N).Stats.GLD - Abs(COSTO_RETOS_1VS1))

                Call WriteUpdateGold(N)

                RetoList(Reto_Index).users(LoopC).LastPosition = UserList(N).Pos

                If RetoList(Reto_Index).CascoEscu Then
                    Call DesequiparUser(N)
                End If

                If RetoList(Reto_Index).Planted < 1 Then
                    Call WritePauseToggle(N)
                    Call WarpUserCharX(N, RetoMap, Give_Pos_X(Reto_Index, LoopC), Give_Pos_Y(Reto_Index, LoopC))
                Else
                    Call WarpUserCharX(N, RetoMap, GivePlanted_Pos_X(Reto_Index, LoopC), GivePlanted_Pos_Y(Reto_Index))
                End If

                UserList(N).Stats.MinHP = UserList(N).Stats.MaxHP
                UserList(N).Stats.MinMAN = UserList(N).Stats.MaxMAN
                UserList(N).Stats.minSta = UserList(N).Stats.MaxSta

                Call WriteUpdateStatsNew(N)
                Call WriteCuentaRegresiva(N, RetoList(Reto_Index).count_Down)
            End If

        End If

    Next LoopC

    Call Retos1vs1Activos.Add(Reto_Index)

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Warp_Players en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Retos1vs1PassSecond()
    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim RetoIndex As Byte

    For LoopC = 1 To Retos1vs1Activos.count
        RetoIndex = Retos1vs1Activos.Item(LoopC)

        If RetoList(RetoIndex).Run Then
            Call Reto_Loop(RetoIndex)
        End If
    Next LoopC

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Retos1vs1PassSecond en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Reto_Loop(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    If RetoList(Reto_Index).count_Down > 0 Then
        RetoList(Reto_Index).count_Down = RetoList(Reto_Index).count_Down - 1

        If RetoList(Reto_Index).count_Down < 1 Then
            If RetoList(Reto_Index).Planted < 1 Then
                Dim LoopC As Long, N As Integer

                For LoopC = 0 To 1
                    N = RetoList(Reto_Index).users(LoopC).UserIndex

                    If N > 0 Then
                        If UserList(N).ConnIDValida Then
                            Call WritePauseToggle(N)
                        End If
                    End If
                Next LoopC
            End If
        End If
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Reto_Loop en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Loop_UserReto1vs1(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    With UserList(UserIndex).mReto

        If .AcceptLimitCount > 0 Then
            .AcceptLimitCount = .AcceptLimitCount - 1

            If .AcceptLimitCount < 1 Then
                Dim TmpInt As Integer
                TmpInt = .IndexSender

                If TmpInt > 0 Then
                    If UserList(TmpInt).mReto.IndexRecieve = UserIndex Then
                        Call ResetOtherUser1vs1(TmpInt)
                    End If
                End If

                Call ResetOtherUser1vs1(UserIndex)
            End If
        End If

        If .ReturnHome > 0 Then
            .ReturnHome = .ReturnHome - 1

            If .ReturnHome < 1 Then
                Call AbandonUserReto1vs1(UserIndex, .Reto_Index)
            End If
        End If

    End With

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Loop_UserReto1vs1 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub AbandonUserReto1vs1(ByVal Winner_Index As Integer, ByVal Reto_Index As Byte)
1   On Error GoTo Errhandler
2   Dim ID As Byte
    If Reto_Index = 0 Then
        Call WriteConsoleMsg(Winner_Index, "No estás en retos.", FontTypeNames.FONTTYPE_GUILD)
        Exit Sub
    End If
3   ID = IIf(RetoList(Reto_Index).users(0).UserIndex = Winner_Index, 1, 0)

4   With RetoList(Reto_Index).users(ID).LastPosition
5       Call WarpUserCharX(Winner_Index, .Map, .X, .X, True)
    End With

6   Call ClearMapReto(Reto_Index)
    'Call EraseBankers(Reto_Index)

7   Call Reset_UserReto1vs1(Winner_Index)
8   Call WriteConsoleMsg(Winner_Index, "Vuelves a la ciudad.", FontTypeNames.FONTTYPE_GUILD)

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en AbandonUserReto1vs1 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub Reset_UserReto1vs1(ByVal Send_Index As Integer)
    On Error GoTo Errhandler
    With UserList(Send_Index).mReto

        .Tmp_Gold = 0
        .Tmp_Planted = 0
        .Tmp_Drop = 0
        .Tmp_Potions = 0
        .Tmp_Aim = 0
        .Tmp_CascoEscu = 0
        .Tmp_Rounds = 0

        .IndexRecieve = 0
        .IndexSender = 0

        .ReturnHome = 0
        .Reto_Index = 0
        .AcceptLimitCount = 0

    End With

    UserList(Send_Index).flags.UserInEvent = False

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en Reset_UserReto1vs1 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub ResetOtherUser1vs1(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    UserList(UserIndex).mReto.IndexRecieve = 0
    UserList(UserIndex).mReto.IndexSender = 0
    UserList(UserIndex).mReto.AcceptLimitCount = 0

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en ResetOtherUser1vs1 en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub SpawnBankers(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim SpawnPos As WorldPos

    If RetoList(Reto_Index).Planted < 1 Then
        SpawnPos.Map = RETO_MAP
    Else
        SpawnPos.Map = PLANTE_MAP
    End If

    Dim CenterPos As Position
    CenterPos = RingCenter(Reto_Index)

    'ARRIBA
    SpawnPos.X = CenterPos.X
    SpawnPos.Y = CenterPos.Y - RANGO_VISION_Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 0
    Call SpawnNpc(24, SpawnPos, False, False)
    'ARRIBA

    'ABAJO
    SpawnPos.X = CenterPos.X
    SpawnPos.Y = CenterPos.Y + RANGO_VISION_Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 0
    Call SpawnNpc(24, SpawnPos, False, False)
    'ABAJO

    'IZQ
    SpawnPos.X = CenterPos.X - RANGO_VISION_X
    SpawnPos.Y = CenterPos.Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 0
    Call SpawnNpc(24, SpawnPos, False, False)
    'IZQ

    'DER
    SpawnPos.X = CenterPos.X + (RANGO_VISION_X - 1)
    SpawnPos.Y = CenterPos.Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 0
    Call SpawnNpc(24, SpawnPos, False, False)
    'DER

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en SpawnBankers en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub EraseBankers(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim SpawnPos As WorldPos

    If RetoList(Reto_Index).Planted < 1 Then
        SpawnPos.Map = RETO_MAP
    Else
        SpawnPos.Map = PLANTE_MAP
    End If

    Dim CenterPos As Position
    CenterPos = RingCenter(Reto_Index)

    'ARRIBA
    SpawnPos.X = CenterPos.X
    SpawnPos.Y = CenterPos.Y - RANGO_VISION_Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 1

    If MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex > 0 Then
        Call QuitarNPC(MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex)
    End If

    'ABAJO
    SpawnPos.X = CenterPos.X
    SpawnPos.Y = CenterPos.Y + RANGO_VISION_Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 1

    If MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex > 0 Then
        Call QuitarNPC(MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex)
    End If

    'IZQ
    SpawnPos.X = CenterPos.X - RANGO_VISION_X
    SpawnPos.Y = CenterPos.Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 1

    If MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex > 0 Then
        Call QuitarNPC(MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex)
    End If

    'DER
    SpawnPos.X = CenterPos.X + (RANGO_VISION_X - 1)
    SpawnPos.Y = CenterPos.Y

    MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).Blocked = 1

    If MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex > 0 Then
        Call QuitarNPC(MapData(SpawnPos.Map, SpawnPos.X, SpawnPos.Y).NpcIndex)
    End If

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en EraseBankers en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub ClearMapReto(ByVal Reto_Index As Byte)
    On Error GoTo Errhandler
    Dim Map As Integer
    Dim X As Long
    Dim Y As Long

    If RetoList(Reto_Index).Planted < 1 Then
        Map = RETO_MAP
    Else
        Map = PLANTE_MAP
    End If

    Dim Player0 As Byte
    Dim Player1 As Byte

    If Give_Pos_Y(Reto_Index, 0) > Give_Pos_Y(Reto_Index, 1) Then
        Player0 = 1
        Player1 = 0
    Else
        Player0 = 0
        Player1 = 1
    End If

    For Y = Give_Pos_Y(Reto_Index, Player0) To Give_Pos_Y(Reto_Index, Player1)
        For X = Give_Pos_X(Reto_Index, Player0) To Give_Pos_X(Reto_Index, Player1)
            If MapData(Map, X, Y).ObjInfo.ObjIndex > 0 Then
                Call EraseObj(MapData(Map, X, Y).ObjInfo.Amount, Map, X, Y)
            End If
        Next X
    Next Y

    If RetoList(Reto_Index).Drop Then

        If RetoList(Reto_Index).Planted < 1 Then
            Map = RETO_MAP_DROP
        Else
            Map = PLANTE_MAP_DROP
        End If

        If Give_Pos_Y(Reto_Index, 0) > Give_Pos_Y(Reto_Index, 1) Then
            Player0 = 1
            Player1 = 0
        Else
            Player0 = 0
            Player1 = 1
        End If

        For Y = Give_Pos_Y(Reto_Index, Player0) To Give_Pos_Y(Reto_Index, Player1)
            For X = Give_Pos_X(Reto_Index, Player0) To Give_Pos_X(Reto_Index, Player1)
                If MapData(Map, X, Y).ObjInfo.ObjIndex > 0 Then
                    Call EraseObj(MapData(Map, X, Y).ObjInfo.Amount, Map, X, Y)
                End If
            Next X
        Next Y
    End If

    Call Erase_RetoData(Reto_Index)

    Exit Sub
Errhandler:
    Call LogError("Retos1vs1 - Error en ClearMapReto en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub



