Attribute VB_Name = "m_ArenaBots"
Option Explicit

Public MAX_BOTS As Byte

Private Const IA_CHAR As Integer = (MAXNPCS - 9)
Private Const IA_M_SPELL As Byte = 3

Private Const IA_SINT As Integer = 200    ' 400         'Intervalo entre hechizo-hechizo.
Private Const IA_SREMO As Byte = 7    ' 14        '(300 / 11)
Private Const IA_MOVINT As Byte = 2    '3        '(250 / 40)
Private Const IA_USEOBJ As Integer = 50    '100
Private Const IA_HITINT As Integer = 6
Private Const IA_PROINT As Integer = 125    '350

Private Type ia_Interval
    SpellCount As Byte
    UseItemCount As Byte
    MoveCharCount As Byte
    ParalizisCount As Byte
    HitCount As Byte
    ArrowCount As Byte
    'ChatCount As Byte
End Type

Private Type IA_Spells
    DamageMin As Byte
    DamageMax As Byte
    SpellIndex As Byte
End Type

Public Enum eIAClase
    Clerigo = 1
    Mago = 2
    Cazador = 3
End Enum

Private Enum eIAactions
    ePaste = 1
    eMagic = 2
End Enum

Private Enum eIAMoviments
    FollowVictim = 1
    MoveRandom = 2
End Enum

Private Type Bot
    iA_MinDef As Byte
    iA_MaxDef As Byte

    'Probabilidades de que te pegue
    iA_Cast As Byte
    iA_Probex As Byte
    iA_ProbExFlecha As Byte

    TargetIndex As Integer
    Difficulty As Byte
    Pos As WorldPos

    MaxHP As Integer
    MaxMAN As Integer
    HP As Integer
    MAN As Integer

    Class As eIAClase
    TAG As String

    Char As Char
    Summoned As Byte
    Paralyzed As Byte

    Intervals As ia_Interval
    LastAction As eIAactions
    LastMovement As eIAMoviments

    UserSpawnPos As Position
    BotSpawnPos As Position
End Type

Public IA_Bot() As Bot
Private IA_Spell(1 To IA_M_SPELL) As IA_Spells
'Public ia_Chats(1 To IA_NUMCHAT)      As String

'Cantidad de bots invocados.
Public NumInvocados As Byte
Public ArenaMap As Integer

Private Function ByteToStringClass(ByVal NumClase As Long) As String

    Select Case NumClase
    Case eIAClase.Clerigo
        ByteToStringClass = "Clérigo"
    Case eIAClase.Cazador
        ByteToStringClass = "Cazador"
    Case eIAClase.Mago
        ByteToStringClass = "Mago"
    End Select

End Function

Public Sub LoadBotArenasPos()

    Dim Leer As New clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(DatPath & "ArenaBots.ini")

    MAX_BOTS = val(Leer.GetValue("INIT", "Arenas"))

    If MAX_BOTS > 0 Then
        ReDim IA_Bot(1 To MAX_BOTS) As Bot
        ArenaMap = val(Leer.GetValue("INIT", "Map"))

        If MapaValido(ArenaMap) Then
            Dim LoopC As Long

            For LoopC = 1 To MAX_BOTS
                IA_Bot(LoopC).BotSpawnPos.X = val(Leer.GetValue(LoopC, "X1"))
                IA_Bot(LoopC).BotSpawnPos.Y = val(Leer.GetValue(LoopC, "Y1"))

                IA_Bot(LoopC).UserSpawnPos.X = val(Leer.GetValue(LoopC, "X2"))
                IA_Bot(LoopC).UserSpawnPos.Y = val(Leer.GetValue(LoopC, "Y2"))
            Next LoopC
        End If
    End If

    Set Leer = Nothing

End Sub

Public Function IA_Spawn(ByVal UI As Integer, ByVal iaClase As eIAClase, ByVal iaDificultad As Byte) As Byte

10  On Error GoTo ia_Spawn_Error

    Dim ProximoBot As Byte
20  ProximoBot = IA_GetNextSlot

30  If ProximoBot < 1 Then Exit Function

40  With IA_Bot(ProximoBot)

50      .Summoned = 1
        .Difficulty = iaDificultad
60      .Class = iaClase

90      Call IA_StatsByClaseAndDificulty(ProximoBot, UserList(UI).Stats.ELV)

100     .MaxMAN = .MAN
110     .MaxHP = .HP

140     .TAG = "BOT"
141     .TargetIndex = UI
150     .Paralyzed = 0

160     .Pos.Map = ArenaMap
170     .Pos.X = .BotSpawnPos.X
180     .Pos.Y = .BotSpawnPos.Y

190     Bot_CreateChar ProximoBot

200     IA_Action ProximoBot

210     .Intervals.SpellCount = 200

230     MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = ProximoBot

250 End With

240 IA_Spawn = ProximoBot

220 NumInvocados = NumInvocados + 1

260 Exit Function

ia_Spawn_Error:

270 Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure ia_Spawn of Módulo m_ArenaBots" & Erl & ".")

End Function

Sub NuevoReto(ByVal UI As Integer, ByVal BOT_Dificultad As Byte, ByVal BOT_Clase As eIAClase)

    With UserList(UI)

        If .Pos.Map <> Ullathorpe.Map Then
            Call WriteConsoleMsg(UI, "Debes estar en ullathorpe.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If .flags.Muerto <> 0 Then
            Call WriteConsoleMsg(UI, "Estás muerto!!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If .Stats.ELV < 30 Then
            Call WriteConsoleMsg(UI, "Debes ser mayor al nivel 30 para duelear contra el bot.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If .flags.Comerciando Then
            Call WriteConsoleMsg(UI, "Debes dejar de comerciar", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        .InBotID = IA_Spawn(UI, BOT_Clase, BOT_Dificultad)

        If .InBotID > 0 Then
            Call WriteConsoleMsg(UI, "Sistema de entrenamiento contra bots Dificultad: " & BOT_Dificultad & " - Clase: " & ByteToStringClass(BOT_Clase) & vbNewLine & "Vida: " & IA_Bot(.InBotID).HP & " | Mana: " & IA_Bot(.InBotID).MAN, FontTypeNames.FONTTYPE_AMARILLO)
            Call WarpUserCharX(UI, ArenaMap, IA_Bot(.InBotID).UserSpawnPos.X, IA_Bot(.InBotID).UserSpawnPos.Y, True)
        Else
            Call WriteConsoleMsg(UI, "Sistema de entrenamiento contra bots No se pudo crear el BOT, todas las salas están llenas.", FontTypeNames.FONTTYPE_AMARILLO)
        End If

    End With

End Sub

Private Function ia_CascoByClase(ByVal Class As Byte) As Integer

    Select Case Class
    Case eIAClase.Clerigo
        ia_CascoByClase = 131        'Completo
    Case eIAClase.Mago
        ia_CascoByClase = 622        'Vara
    Case eIAClase.Cazador
        ia_CascoByClase = 405        'de plata
    End Select

End Function

Private Function ia_EscudoByClase(ByVal Class As Byte) As Integer

    Select Case Class
    Case eIAClase.Clerigo
        ia_EscudoByClase = 130        'De plata
    Case eIAClase.Mago
        ia_EscudoByClase = NingunEscudo        'Nada
    Case eIAClase.Cazador
        ia_EscudoByClase = 404        'Escudo d tortu
    End Select

End Function

Private Function IA_ArmaByClase(ByVal Class As Byte) As Integer

    Select Case Class
    Case eIAClase.Clerigo
        IA_ArmaByClase = 129        'Dos filos
    Case eIAClase.Mago
        IA_ArmaByClase = 400        'Vara
    Case eIAClase.Cazador
        IA_ArmaByClase = 628        'arko de kza
    End Select

End Function

Private Function IA_StatsByClaseAndDificulty(ByVal BotIndex As Byte, ByVal ELV As Byte) As Integer

    Dim lvlByDificulty As Byte
    Dim i As Long

    With IA_Bot(BotIndex)
        .MaxHP = 0
        .MaxMAN = 0

        Select Case .Difficulty

        Case 1
            If ELV + 1 < 47 Then
                lvlByDificulty = ELV + 1
            Else
                lvlByDificulty = ELV
            End If

            .iA_Cast = 33
            .iA_Probex = 90
            .iA_MinDef = 8
            .iA_MaxDef = 10
            .iA_ProbExFlecha = 30

        Case 2
            If ELV + 3 < 47 Then
                lvlByDificulty = ELV + 3
            Else
                lvlByDificulty = ELV
            End If

            .iA_Cast = 44
            .iA_Probex = 130
            .iA_MinDef = 9
            .iA_MaxDef = 11
            .iA_ProbExFlecha = 35

        Case 3
            If ELV + 4 < 47 Then
                lvlByDificulty = ELV + 4
            Else
                lvlByDificulty = ELV
            End If

            .iA_Cast = 55
            .iA_Probex = 170
            .iA_MinDef = 12
            .iA_MaxDef = 15
            .iA_ProbExFlecha = 45

        Case 4
            If ELV + 5 < 47 Then
                lvlByDificulty = ELV + 5
            Else
                lvlByDificulty = ELV
            End If

            .iA_Cast = 67
            .iA_Probex = 195
            .iA_MinDef = 15
            .iA_MaxDef = 17
            .iA_ProbExFlecha = 55

        Case 5

            If ELV + 6 < 47 Then
                lvlByDificulty = ELV + 6
            Else
                lvlByDificulty = ELV
            End If

            .iA_Cast = 77
            .iA_Probex = 220
            .iA_MinDef = 15
            .iA_MaxDef = 20
            .iA_ProbExFlecha = 67

        End Select

        Select Case .Class

        Case eIAClase.Clerigo

            For i = 1 To lvlByDificulty
                .MaxHP = .MaxHP + RandomNumber(7, 9)
            Next i

            .MaxMAN = 36 * lvlByDificulty

        Case eIAClase.Mago

            .MaxMAN = RandomNumber(100, 105)

            For i = 2 To lvlByDificulty
                .MaxHP = .MaxHP + RandomNumber(6, 8)

                If ((.MaxMAN) >= 2000) Then
                    .MaxMAN = .MaxMAN + 27
                Else
                    .MaxMAN = .MaxMAN + 54
                End If
            Next i

        Case eIAClase.Cazador
            .MaxHP = RandomNumber(7, 10) * lvlByDificulty
            .MaxMAN = 0
        End Select

        .HP = .MaxHP
        .MAN = .MaxMAN

    End With

End Function

Private Function IA_CalcularGolpe(ByVal VictimIndex As Integer) As Integer

    IA_CalcularGolpe = RandomNumber(160, 180)

    If RandomNumber(PartesCuerpo.bCabeza, PartesCuerpo.bTorso) <> PartesCuerpo.bCabeza Then
        If UserList(VictimIndex).Invent.ArmourEqpObjIndex <> 0 Then
            IA_CalcularGolpe = IA_CalcularGolpe - RandomNumber(ObjData(UserList(VictimIndex).Invent.ArmourEqpObjIndex).MinDef, ObjData(UserList(VictimIndex).Invent.ArmourEqpObjIndex).MaxDef)
        End If
    Else
        If UserList(VictimIndex).Invent.CascoEqpObjIndex <> 0 Then
            IA_CalcularGolpe = IA_CalcularGolpe - RandomNumber(ObjData(UserList(VictimIndex).Invent.CascoEqpObjIndex).MinDef, ObjData(UserList(VictimIndex).Invent.CascoEqpObjIndex).MaxDef)
        End If
    End If

    IA_CalcularGolpe = IA_CalcularGolpe + (IA_Bot(1).Difficulty * 8)

End Function

Private Function IA_AciertaGolpe(ByVal VictimIndex As Integer, ByVal BotIndex As Byte) As Boolean

    Dim TempEvasion As Long
    Dim TempEvasionEsc As Long
    Dim TempResultado As Long

    'Evasión del usuario.
    TempEvasion = PoderEvasion(VictimIndex)

    'Tiene escudo?
    If UserList(VictimIndex).Invent.EscudoEqpObjIndex <> 0 Then
        TempEvasionEsc = PoderEvasionEscudo(VictimIndex)
        TempEvasionEsc = TempEvasion + TempEvasionEsc
    Else
        TempEvasionEsc = 0
    End If

    'Acierta?
    TempResultado = MaximoInt(10, MinimoInt(90, 50 + (IA_Bot(BotIndex).iA_Probex - TempEvasion) * 0.4))

    'Random.
    IA_AciertaGolpe = (RandomNumber(1, 100) <= TempResultado)

End Function

Sub Bot_CreateChar(ByVal BotIndex As Byte)

    With IA_Bot(BotIndex)

        .Char.body = 130
        .Char.Head = 8
        .Char.ShieldAnim = ObjData(ia_EscudoByClase(.Class)).ShieldAnim
        .Char.CascoAnim = ObjData(ia_CascoByClase(.Class)).CascoAnim
        .Char.WeaponAnim = ObjData(IA_ArmaByClase(.Class)).WeaponAnim
        .Char.CharIndex = IA_CHAR + BotIndex

        Call IA_SendToBotArea(BotIndex, PrepareMessageCharacterCreate(.Char.body, .Char.Head, .Char.Heading, .Char.CharIndex, .Pos.X, .Pos.Y, .Char.WeaponAnim, .Char.ShieldAnim, .Char.FX, .Char.loops, .Char.CascoAnim, .TAG, 1, 0, True))

    End With

End Sub

Public Sub IA_Spells()

'Hechizo 1 : descarga.
    IA_Spell(1).DamageMin = 177
    IA_Spell(1).DamageMax = 120
    IA_Spell(1).SpellIndex = 23

    'Hechizo 2 : apoca
    IA_Spell(2).DamageMin = 190
    IA_Spell(2).DamageMax = 220
    IA_Spell(2).SpellIndex = 25

    'Paralizar.
    IA_Spell(3).DamageMax = 0
    IA_Spell(3).DamageMin = 0
    IA_Spell(3).SpellIndex = 9

End Sub

Private Function IA_LegalPos(ByVal X As Byte, ByVal Y As Byte, Optional ByVal SiguiendoUser As Integer = 0) As Boolean

    If (X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder) Then Exit Function

    With MapData(ArenaMap, X, Y)

        If .Blocked <> 0 Then Exit Function

        If .UserIndex > 0 Then
            'Si no es un adminInvisible entonces nos vamos.
            If UserList(.UserIndex).flags.AdminInvisible <> 1 Then Exit Function
        End If

        If .NpcIndex <> 0 Then Exit Function

        If .BotIndex <> 0 Then Exit Function

    End With

    If SiguiendoUser <> 0 Then
        'Válido para evitar el rango Y pero no su eje X.
        If Abs(Y - UserList(SiguiendoUser).Pos.Y) > RANGO_VISION_Y Then Exit Function
        If Abs(X - UserList(SiguiendoUser).Pos.X) > RANGO_VISION_X Then Exit Function
    End If

    IA_LegalPos = True

End Function

Private Function IA_MoveToHeading(ByVal BotIndex As Byte, ByVal ToHeading As eHeading) As Byte

    Select Case ToHeading

    Case eHeading.NORTH

        If Not IA_LegalPos(IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y - 1) Then Exit Function

        MapData(IA_Bot(BotIndex).Pos.Map, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y).BotIndex = 0

        IA_Bot(BotIndex).Pos.Y = IA_Bot(BotIndex).Pos.Y - 1
        IA_MoveToHeading = ToHeading

    Case eHeading.EAST

        If Not IA_LegalPos(IA_Bot(BotIndex).Pos.X + 1, IA_Bot(BotIndex).Pos.Y) Then Exit Function

        MapData(IA_Bot(BotIndex).Pos.Map, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y).BotIndex = 0

        IA_Bot(BotIndex).Pos.X = IA_Bot(BotIndex).Pos.X + 1
        IA_MoveToHeading = ToHeading

    Case eHeading.SOUTH

        If Not IA_LegalPos(IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y + 1) Then Exit Function

        MapData(IA_Bot(BotIndex).Pos.Map, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y).BotIndex = 0

        IA_Bot(BotIndex).Pos.Y = IA_Bot(BotIndex).Pos.Y + 1
        IA_MoveToHeading = ToHeading

    Case eHeading.WEST

        If Not IA_LegalPos(IA_Bot(BotIndex).Pos.X - 1, IA_Bot(BotIndex).Pos.Y) Then Exit Function

        MapData(IA_Bot(BotIndex).Pos.Map, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y).BotIndex = 0

        IA_Bot(BotIndex).Pos.X = IA_Bot(BotIndex).Pos.X - 1
        IA_MoveToHeading = ToHeading

    End Select


End Function

Sub IA_Action(ByVal BotIndex As Byte)

    Dim pIndex As Integer
    Dim sRandom As Integer
    Dim MoveHeading As Byte

    On Error GoTo ia_Action_Error

    If EnPausa Then Exit Sub

    With IA_Bot(BotIndex)

        pIndex = .TargetIndex
        If pIndex < 1 Then Exit Sub

        If UserList(pIndex).ConnIDValida Then
            If UserList(pIndex).Pos.Map <> .Pos.Map Then
                'Terminar Duelo bot
                Exit Sub
            Else
                If Abs(.Pos.Y - UserList(pIndex).Pos.Y) > RANGO_VISION_Y Then Exit Sub
                If Abs(.Pos.X - UserList(pIndex).Pos.X) > RANGO_VISION_X Then Exit Sub
            End If
        End If

        Call IA_CheckInts(BotIndex)

        'EL bot boquea XD
        'If Not .Intervals.ChatCount <> 0 Then
        '.Intervals.ChatCount = (IA_TALKIN / 40)

        'Envia msj random
        'IA_SendToBotArea BotIndex, PrepareMessageChatOverHead("JEJOX", .Char.CharIndex, vbWhite)
        '.Intervals.SpellCount = (IA_SINT / 100)
        'End If

        'Si se puede mover AND no está inmo se mueve al azar.
        If .Intervals.MoveCharCount = 0 And .Paralyzed < 1 Then

            If pIndex > 0 Then
                MoveHeading = FindDirection(IA_Bot(BotIndex).Pos, UserList(pIndex).Pos)
            End If

            Select Case .Class

            Case eIAClase.Clerigo

                'Si tiene la vida llena lo persigue.
                If .HP = .MaxHP Then
                    MoveHeading = IA_MoveToHeading(BotIndex, MoveHeading)
                Else
                    MoveHeading = IA_RandomMoveChar(BotIndex, pIndex)
                End If

            Case eIAClase.Mago, eIAClase.Cazador

                'Si no tiene la vida llena se mueve al azar. o tiene un 70% de moverse random
                If .HP <> .MaxHP Or RandomNumber(1, 10) < 4 Then
                    MoveHeading = IA_RandomMoveChar(BotIndex, pIndex)
                Else
                    If .LastMovement = eIAMoviments.FollowVictim Then
                        MoveHeading = IA_RandomMoveChar(BotIndex, pIndex)
                        .LastMovement = eIAMoviments.MoveRandom
                    Else
                        MoveHeading = IA_MoveToHeading(BotIndex, MoveHeading)
                        .LastMovement = eIAMoviments.FollowVictim
                    End If
                End If

            End Select

            'Se movio.
            If MoveHeading > 0 Then
                MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = BotIndex

                .Char.Heading = MoveHeading
                
                Call IA_SendToBotArea(BotIndex, PrepareMessageCharacterMoves(.Char.CharIndex, MoveHeading))

                .Intervals.MoveCharCount = IA_MOVINT
            End If

        End If

        'Prioriza la vida ante todo
        If .HP < .MaxHP Then

            If .Intervals.UseItemCount > 0 Then Exit Sub

            .HP = .HP + 25        'Recupera 25 cada 200 ms.

            If .HP > .MaxHP Then
                .HP = .MaxHP
            End If

            .Intervals.UseItemCount = (IA_USEOBJ / 40)

            If RandomNumber(1, 100) <= .Difficulty * 11 Then
                Exit Sub
            Else
                GoTo TryCast
            End If

        End If

        'Si tenia la vida llena usa azules.
        If .MAN < .MaxMAN Then
            If .Intervals.UseItemCount = 0 Then
                If .Class <> eIAClase.Mago Then
                    .MAN = .MAN + Porcentaje(.MaxMAN, 5)
                Else
                    .MAN = .MAN + Porcentaje(.MaxMAN, 3)
                End If

                If .MAN > .MaxMAN Then
                    .MAN = .MaxMAN
                End If

                Select Case .Difficulty
                Case 1
                    .Intervals.UseItemCount = (IA_USEOBJ + 75) / 40
                Case 2
                    .Intervals.UseItemCount = (IA_USEOBJ + 65) / 40
                Case 3
                    .Intervals.UseItemCount = (IA_USEOBJ + 50) / 40
                Case 4
                    .Intervals.UseItemCount = (IA_USEOBJ + 35) / 40
                Case 5
                    .Intervals.UseItemCount = (IA_USEOBJ + 15) / 40
                End Select
            End If

            'Hacer una constante después, con esto hacemos un random
            'Para que azulee y combee a la ves.
            If RandomNumber(1, 4) < 4 Then Exit Sub
        End If

        'Bueno si está acá es por que tenia la vida y mana llenas.
        'Es cazador??
        If .Class = eIAClase.Cazador Then
            If .Intervals.ArrowCount > 0 Then Exit Sub
            If RandomNumber(1, 100) > .iA_ProbExFlecha Then Exit Sub

            If RandomNumber(1, 130) <= MaximoInt(10, MinimoInt(90, 50 + ((220 - PoderEvasion(pIndex)) * 0.4))) Then
                .Intervals.ArrowCount = (IA_PROINT / 25)
                Call WriteConsoleMsg(pIndex, .TAG & " te lanzó un flechazo, pero falló!", FontTypeNames.FONTTYPE_FIGHT)
                Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))

                If UserList(pIndex).flags.oculto = 0 Then
                    '552 es flecha +2
                    Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessageCreateProjectile(IA_Bot(BotIndex).Char.CharIndex, UserList(pIndex).Char.CharIndex, ObjData(552).GrhIndex))
                End If
            Else
                Dim ArrowDamage As Integer
                ArrowDamage = IA_CalcularGolpe(pIndex)

                UserList(pIndex).Stats.MinHP = UserList(pIndex).Stats.MinHP - ArrowDamage
                Call WriteConsoleMsg(pIndex, .TAG & " te ha pegado un flechazo por " & ArrowDamage, FontTypeNames.FONTTYPE_FIGHT)

                'Call PrepareMessageCreateArrow(.Char.CharIndex, UserList(pIndex).Char.CharIndex, 753)
                'Call SendData(SendTarget.ToPCArea, pIndex)
                If UserList(pIndex).flags.oculto = 0 Then
                    '552 es flecha +2
                    Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessageCreateProjectile(IA_Bot(BotIndex).Char.CharIndex, UserList(pIndex).Char.CharIndex, ObjData(552).GrhIndex))
                End If
                Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessagePlayWave(SND_IMPACTO, UserList(pIndex).Pos.X, UserList(pIndex).Pos.Y))

                If UserList(pIndex).Stats.MinHP < 1 Then
                    Call WriteMultiMessage(pIndex, eMessages.UserKill, .Char.CharIndex)
                    Call IA_EraseChar(BotIndex)
                    Call UserDie(pIndex)

                    Call WarpUserCharX(pIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)
                    UserList(pIndex).InBotID = 0
                    Exit Sub
                End If

                .Intervals.ArrowCount = (IA_PROINT / 10)
                Call WriteUpdateHP(pIndex)
            End If

            Exit Sub
        End If

TryCast:

        'Puede castear?
        'Si el usuario no tiene la vida llena ataca
        Dim TmpHP As Long
        TmpHP = UserList(pIndex).Stats.MinHP

        'obtengo el % de vida del user
        TmpHP = (TmpHP * 100) / (UserList(pIndex).Stats.MaxHP)

        If .Intervals.SpellCount < 20 Then

            'Es clérigo y puede pegar??
            If (.Class = eIAClase.Clerigo) And .Intervals.HitCount = 0 And .LastAction <> eIAactions.ePaste Then
                'Está al alcance de la víctima para un gole meele?
                Dim NewBotHeading As Byte
                NewBotHeading = IA_PuedeMeele(.Pos, UserList(pIndex).Pos)

                If NewBotHeading <> 0 Then
                    'Acierta el golpe?
                    If IA_AciertaGolpe(pIndex, BotIndex) Then

                        'Antes que nada cambiamos el heading, si es válido.
                        If NewBotHeading <> .Char.Heading Then
                            Call IA_SendToBotArea(BotIndex, PrepareMessageChangeHeading(.Char.CharIndex, NewBotHeading))

                            .Char.Heading = NewBotHeading
                        End If

                        Dim GolpeVal As Integer
                        GolpeVal = IA_CalcularGolpe(pIndex)

                        UserList(pIndex).Stats.MinHP = UserList(pIndex).Stats.MinHP - GolpeVal

                        Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessageCreateFX(UserList(pIndex).Char.CharIndex, FXSANGRE, 0))
                        Call WriteConsoleMsg(pIndex, .TAG & " te ha pegado por " & CStr(GolpeVal) & ".", FontTypeNames.FONTTYPE_FIGHT)

                        If UserList(pIndex).Stats.MinHP < 1 Then
                            Call WriteMultiMessage(pIndex, eMessages.UserKill, .Char.CharIndex)
                            Call IA_EraseChar(BotIndex)
                            Call UserDie(pIndex)

                            UserList(pIndex).InBotID = 0
                            Call WarpUserCharX(pIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)
                            Exit Sub
                        End If

                        Call WriteUpdateHP(pIndex)

                        .Intervals.HitCount = IA_HITINT

                        'Intervalo de hechizo.
                        '.Intervals.SpellCount = (IA_SINT / 20)

                        'Intervalo de golpe+pociones.
                        '.Intervals.UseItemCount = (IA_USEOBJ / 60)

                        Select Case .Difficulty
                        Case 1
                            .Intervals.SpellCount = ((IA_SINT + 65) / 10)        'Se chekea cada 40 ms.
                            .Intervals.UseItemCount = ((IA_USEOBJ + 100) / 60)
                        Case 2
                            .Intervals.SpellCount = ((IA_SINT + 55) / 10)        'Se chekea cada 40 ms.
                            .Intervals.UseItemCount = ((IA_USEOBJ + 85) / 60)
                        Case 3
                            .Intervals.SpellCount = ((IA_SINT + 50) / 15)        'Se chekea cada 40 ms.
                            .Intervals.UseItemCount = ((IA_USEOBJ + 65) / 60)
                        Case 4
                            .Intervals.SpellCount = ((IA_SINT + 25) / 15)        'Se chekea cada 40 ms.
                            .Intervals.UseItemCount = ((IA_USEOBJ + 50) / 60)
                        Case 5
                            .Intervals.SpellCount = (IA_SINT / 20)        'Se chekea cada 40 ms.
                            .Intervals.UseItemCount = ((IA_USEOBJ + 30) / 60)
                        End Select

                        .LastAction = eIAactions.ePaste
                        Exit Sub
                    End If
                End If
            End If

            'Feo, aunque digamos que solo hace apoca desc remo
            'Así que va a andar bien.

            'Si la mana es < a 300 [gasto del remo] no hacemos nada.
            If .MAN < 300 Then Exit Sub

            'Si está paralizado AND el usuario no tiene poka vida prioriza removerse.
            If .Paralyzed Then

                If .Intervals.ParalizisCount > 0 Then Exit Sub

                Call IA_SendToBotArea(BotIndex, PrepareMessagePalabrasMagicas(10, .Char.CharIndex))

                .Paralyzed = 0

                Select Case .Difficulty
                Case 1
                    .Intervals.SpellCount = ((IA_SINT + 65) / 10)        'Se chekea cada 40 ms.
                Case 2
                    .Intervals.SpellCount = ((IA_SINT + 55) / 10)        'Se chekea cada 40 ms.
                Case 3
                    .Intervals.SpellCount = ((IA_SINT + 50) / 15)        'Se chekea cada 40 ms.
                Case 4
                    .Intervals.SpellCount = ((IA_SINT + 25) / 15)        'Se chekea cada 40 ms.
                Case 5
                    .Intervals.SpellCount = (IA_SINT / 20)        'Se chekea cada 40 ms.
                End Select


                Exit Sub

            End If

            'No está paralizado entonces castea un hechizo random.
            If RandomNumber(1, 100) > .iA_Cast Then Exit Sub

            'Si soy mago y el usuario es mago también no paraliza.
            If UserList(pIndex).Clase = eClass.Mage And .Class = eIAClase.Mago Then
                sRandom = RandomNumber(1, IA_M_SPELL - 1)
            Else
                If UserList(pIndex).flags.Paralizado < 1 Then
                    sRandom = RandomNumber(1, IA_M_SPELL)
                Else
                    sRandom = RandomNumber(1, IA_M_SPELL - 1)
                End If
            End If

            'Si el usuario tiene menos del 75% de vida juega al ataque.
            If TmpHP < 75 Then
                sRandom = RandomNumber(1, IA_M_SPELL - 1)
            End If

            'Si no llega con la mana del hechizo AND la del otro
            'tampoco entonces no hacemos nada

            If sRandom = 1 Then

                'Si no llega para la desca no hacemos nada.
                If Hechizos(IA_Spell(sRandom).SpellIndex).ManaRequerido > .MAN Then Exit Sub

            ElseIf sRandom = 2 Then

                'Pero si es spell 2 (apoca) AND llegamos
                'con la mana para descarga, entonces
                'Seteamos sRandom como 1 y casteamos
                'descarga.

                If Hechizos(IA_Spell(sRandom).SpellIndex).ManaRequerido > .MAN Then
                    'Modifico la formula y hago un random
                    'Dado a que una ves que queda en -1000 de mana
                    'Nunca más tira apoca y castea puras descargas.

                    If .MAN > 460 And RandomNumber(1, 100) < 30 Then
                        sRandom = 1
                    Else
                        Exit Sub
                    End If
                End If
            End If

            .MAN = .MAN - Hechizos(IA_Spell(sRandom).SpellIndex).ManaRequerido
            .LastAction = eIAactions.eMagic

            Select Case .Difficulty
            Case 1
                .Intervals.SpellCount = ((IA_SINT + 65) / 10)        'Se chekea cada 40 ms.
            Case 2
                .Intervals.SpellCount = ((IA_SINT + 55) / 10)        'Se chekea cada 40 ms.
            Case 3
                .Intervals.SpellCount = ((IA_SINT + 50) / 15)        'Se chekea cada 40 ms.
            Case 4
                .Intervals.SpellCount = ((IA_SINT + 25) / 15)        'Se chekea cada 40 ms.
            Case 5
                .Intervals.SpellCount = (IA_SINT / 20)        'Se chekea cada 40 ms.
            End Select

            Call IA_SendToBotArea(BotIndex, PrepareMessagePalabrasMagicas(IA_Spell(sRandom).SpellIndex, .Char.CharIndex))

            Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessageCreateFX(UserList(pIndex).Char.CharIndex, Hechizos(IA_Spell(sRandom).SpellIndex).FXgrh, Hechizos(IA_Spell(sRandom).SpellIndex).loops))
            Call SendData(SendTarget.ToPCArea, pIndex, PrepareMessagePlayWave(Hechizos(IA_Spell(sRandom).SpellIndex).WAV, UserList(pIndex).Pos.X, UserList(pIndex).Pos.Y))

            Call WriteMultiMessage(pIndex, eMessages.Hechizo_TargetMSG, IA_Spell(sRandom).SpellIndex, , , .TAG)

            If sRandom = 3 Then
                UserList(pIndex).flags.Paralizado = 1
                UserList(pIndex).Counters.Paralisis = IntervaloParalizado
                Call WriteParalizeOK(pIndex)
                Exit Sub
            End If

            sRandom = RandomNumber(IA_Spell(sRandom).DamageMin, IA_Spell(sRandom).DamageMax)

            If UserList(pIndex).Invent.AnilloEqpObjIndex <> 0 Then
                sRandom = sRandom - RandomNumber(ObjData(UserList(pIndex).Invent.AnilloEqpObjIndex).DefensaMagicaMin, ObjData(UserList(pIndex).Invent.AnilloEqpObjIndex).DefensaMagicaMax)
            End If

            If sRandom < 0 Then sRandom = 0

            UserList(pIndex).Stats.MinHP = UserList(pIndex).Stats.MinHP - sRandom
            Call WriteConsoleMsg(pIndex, .TAG & " te ha quitado " & sRandom & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)

            If UserList(pIndex).Stats.MinHP < 1 Then
                Call WriteMultiMessage(pIndex, eMessages.UserKill, .Char.CharIndex)
                Call IA_EraseChar(BotIndex)
                Call UserDie(pIndex)

                UserList(pIndex).InBotID = 0
                Call WarpUserCharX(pIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)
            End If

            Call WriteUpdateHP(pIndex)

        End If

    End With

    Exit Sub

ia_Action_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure ia_Action of Módulo m_ArenaBots " & Erl & ".")

End Sub

Sub IA_EnviarChar(ByVal UI As Integer, ByVal BotIndex As Byte)

    With IA_Bot(BotIndex)
        Call SendToAreaByPos(.Pos.Map, .Pos.X, .Pos.Y, PrepareMessageCharacterCreate(.Char.body, .Char.Head, eHeading.SOUTH, .Char.CharIndex, .Pos.X, .Pos.Y, .Char.WeaponAnim, .Char.ShieldAnim, 0, 0, .Char.CascoAnim, .TAG, 2, 0, True))
        Call WriteCharacterCreate(UI, .Char.body, .Char.Head, eHeading.SOUTH, .Char.CharIndex, .Pos.X, .Pos.Y, .Char.WeaponAnim, .Char.ShieldAnim, 0, 0, .Char.CascoAnim, .TAG, 2, 0, True)
    End With

End Sub

Sub ChallengeBotsUserDisconnect(ByVal BotIndex As Byte)

    If IA_Bot(BotIndex).Pos.Map > 0 Then
        Call IA_EraseChar(BotIndex)
    End If

End Sub

Sub IA_UserDamage(ByVal Spell As Byte, ByVal BotIndex As Byte, ByVal UserIndex As Integer)

    If Spell < 1 Then Exit Sub

    Dim rEner As Integer
    Dim rMan As Integer
    Dim Damage As Long

    With UserList(UserIndex)

        rEner = Hechizos(Spell).StaRequerido

        '++ TDN se debe acordar de mi jssjsjsjk
        If rEner > .Stats.minSta Then
            Call WriteConsoleMsg(UserIndex, IIf(.Genero = eGenero.Hombre, "Estás muy cansado para lanzar este hechizo.", "Estás muy cansada para lanzar este hechizo."))
            Exit Sub
        End If

        rMan = Hechizos(Spell).ManaRequerido

        If rMan > .Stats.MinMAN Then
            Call WriteConsoleMsg(UserIndex, "No tienes suficiente maná.")
            Exit Sub
        End If

        If Hechizos(Spell).MinSkill > .Stats.UserSkills(eSkill.Magia) Then
            Call WriteConsoleMsg(UserIndex, "No tienes suficientes skills.")
            Exit Sub
        End If

        If Hechizos(Spell).Inmoviliza Or Hechizos(Spell).Paraliza Then

            Call DecirPalabrasMagicas(Hechizos(Spell).PalabrasMagicas, UserIndex)
            Call IA_SendToBotArea(BotIndex, PrepareMessageCreateFX(IA_Bot(BotIndex).Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))
            Call IA_SendToBotArea(BotIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y))

            Call WriteMultiMessage(UserIndex, eMessages.Hechizo_HechiceroMSG_NOMBRE, Spell, , , IA_Bot(BotIndex).TAG)

            IA_Bot(BotIndex).Paralyzed = 1
            IA_Bot(BotIndex).Intervals.ParalizisCount = IA_SREMO

            .Stats.MinMAN = .Stats.MinMAN - rMan
            Call WriteUpdateMana(UserIndex)
            Exit Sub
        End If

        Damage = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)
        Damage = Damage + Porcentaje(Damage, 3 * .Stats.ELV)

        If Damage < 1 Then Exit Sub

        If Hechizos(Spell).StaffAffected Then
            If UserList(UserIndex).Clase = eClass.Mage Then
                If UserList(UserIndex).Invent.WeaponEqpObjIndex > 0 Then
                    Damage = (Damage * (ObjData(UserList(UserIndex).Invent.WeaponEqpObjIndex).StaffDamageBonus + 70)) / 100
                Else
                    Damage = Damage * 0.7        'Baja damage a 70% del original
                End If
            End If
        End If

        'If UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLO_BARDO_DONA Or UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLO_DRUIDA_DONA Then
        '    Damage = Damage * 1.08
        'ElseIf UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLO_BARDO_CANJE Or UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLO_DRUIDA_CANJE Then
        '    Damage = Damage * 1.06
        If UserList(UserIndex).Invent.MunicionEqpObjIndex = LAUDMAGICO Or UserList(UserIndex).Invent.MunicionEqpObjIndex = ANILLOMAGICO Then
            Damage = Damage * 1.04        'laud magico de los bardos
        End If

        'No está paralizado.
        If IA_Bot(BotIndex).Paralyzed < 1 Then
            Dim RandomMoves As Byte
            ' RandomMoves = IA_RandomMoveChar(BotIndex, UserIndex)

            If RandomMoves > 0 Then
                MapData(IA_Bot(BotIndex).Pos.Map, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y).BotIndex = BotIndex

                Call IA_SendToBotArea(BotIndex, PrepareMessageCharacterMoves(IA_Bot(BotIndex).Char.CharIndex, RandomMoves))

                IA_Bot(BotIndex).Intervals.MoveCharCount = IA_MOVINT
            End If
        End If

        Call DecirPalabrasMagicas(Hechizos(Spell).PalabrasMagicas, UserIndex)
        Call IA_SendToBotArea(BotIndex, PrepareMessageCreateFX(IA_Bot(BotIndex).Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))
        Call IA_SendToBotArea(BotIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, IA_Bot(BotIndex).Pos.X, IA_Bot(BotIndex).Pos.Y))

        Call WriteMultiMessage(UserIndex, eMessages.Hechizo_HechiceroMSG_NOMBRE, Spell, , , IA_Bot(BotIndex).TAG)

        .Stats.minSta = .Stats.minSta - rEner
        .Stats.MinMAN = .Stats.MinMAN - rMan

        Call WriteUpdateSta(UserIndex)
        Call WriteUpdateMana(UserIndex)
    End With

    If Damage > IA_Bot(BotIndex).HP Then
        IA_Bot(BotIndex).HP = 0
    Else
        IA_Bot(BotIndex).HP = IA_Bot(BotIndex).HP - Damage
    End If

    Call WriteConsoleMsg(UserIndex, "Le has quitado " & Damage & " puntos de vida a " & IA_Bot(BotIndex).TAG & ".", FontTypeNames.FONTTYPE_FIGHT)

    If IA_Bot(BotIndex).HP < 1 Then
        Call UserDieBot(BotIndex, UserIndex)
    End If

End Sub

Sub IA_DamageHit(ByVal BotIndex As Byte)

    Dim TargetIndex As Integer
    TargetIndex = IA_Bot(BotIndex).TargetIndex

    If TargetIndex < 1 Then Exit Sub

    Dim Daño As Integer
    Daño = CalcularDaño(TargetIndex) - RandomNumber(IA_Bot(BotIndex).iA_MinDef, IA_Bot(BotIndex).iA_MaxDef)

    Call WriteMultiMessage(TargetIndex, eMessages.UserHittedUser, IA_Bot(BotIndex).Char.CharIndex, RandomNumber(PartesCuerpo.bCabeza, PartesCuerpo.bTorso), Daño)
    IA_Bot(BotIndex).HP = IA_Bot(BotIndex).HP - Daño

    If IA_Bot(BotIndex).HP < 1 Then
        Call UserDieBot(BotIndex, TargetIndex)
    End If

End Sub

Private Sub UserDieBot(ByVal BotIndex As Byte, ByVal UserIndex As Integer)

    If UserIndex > 0 Then
        Call WriteMultiMessage(UserIndex, eMessages.HaveKilledUser, IA_Bot(BotIndex).Char.CharIndex, 0)
        Call WarpUserCharX(UserIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)
        UserList(UserIndex).InBotID = 0
    End If

    Call IA_EraseChar(BotIndex)

End Sub

Sub IA_SendToBotArea(ByVal BotIndex As Byte, ByVal sndData As BinaryWriter)
    On Error GoTo IA_SendToBotArea_Err
    With IA_Bot(BotIndex)
        Call SendToAreaByPos(.Pos.Map, .Pos.X, .Pos.Y, sndData)
    End With
    
IA_SendToBotArea_Err:
    sndData.Clear
    
End Sub

Private Sub IA_EraseChar(ByVal BotIndex As Byte)

    With IA_Bot(BotIndex)
 
        Call SendToAreaByPos(.Pos.Map, .Pos.X, .Pos.Y, PrepareMessageCharacterRemove(.Char.CharIndex))

        MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = 0

        With .Char
            .body = 0
            .CascoAnim = 0
            .FX = 0
            .loops = 0
            .Head = 0
            .Heading = 0
            .ShieldAnim = 0
            .WeaponAnim = 0
        End With

        .HP = 0
        .MAN = 0

        .MaxHP = 0
        .MaxMAN = 0
        .Class = 0

        .TargetIndex = 0
        .Difficulty = 0

        With .Pos
            .Map = 0
            .X = 0
            .Y = 0
        End With

        .Summoned = 0
        .Paralyzed = 0

        With .Intervals
            .MoveCharCount = 0
            .SpellCount = 0
            .UseItemCount = 0
            .ParalizisCount = 0
            .ArrowCount = 0
            .HitCount = 0
        End With

    End With

    If NumInvocados > 0 Then
        NumInvocados = NumInvocados - 1
    End If

End Sub

Sub IA_CheckInts(ByVal BotIndex As Byte)

    With IA_Bot(BotIndex).Intervals

        If .ArrowCount > 0 Then .ArrowCount = .ArrowCount - 1
        If .MoveCharCount > 0 Then .MoveCharCount = .MoveCharCount - 1
        If .SpellCount > 0 Then .SpellCount = .SpellCount - 1
        If .UseItemCount > 0 Then .UseItemCount = .UseItemCount - 1
        If .ParalizisCount > 0 Then .ParalizisCount = .ParalizisCount - 1
        If .HitCount > 0 Then .HitCount = .HitCount - 1
        'If .ChatCount > 0 Then .ChatCount = .ChatCount - 1

    End With

End Sub

Private Function IA_GetNextSlot() As Byte

    Dim LoopX As Long

    For LoopX = 1 To MAX_BOTS
        If IA_Bot(LoopX).Summoned < 1 Then
            IA_GetNextSlot = LoopX
            Exit Function
        End If
    Next LoopX

    IA_GetNextSlot = 0

End Function

Private Function IA_RandomMoveChar(ByVal BotIndex As Byte, ByVal SiguiendoIndex As Integer) As Byte

    With IA_Bot(BotIndex)

        Select Case RandomNumber(eHeading.NORTH, eHeading.WEST)

        Case eHeading.NORTH

            If Not IA_LegalPos(.Pos.X, .Pos.Y - 1, SiguiendoIndex) Then Exit Function

            IA_RandomMoveChar = eHeading.NORTH

            MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = 0
            .Pos.Y = .Pos.Y - 1

        Case eHeading.EAST

            If Not IA_LegalPos(.Pos.X + 1, .Pos.Y, SiguiendoIndex) Then Exit Function

            IA_RandomMoveChar = eHeading.EAST

            MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = 0
            .Pos.X = .Pos.X + 1

        Case eHeading.SOUTH

            If Not IA_LegalPos(.Pos.X, .Pos.Y + 1, SiguiendoIndex) Then Exit Function

            IA_RandomMoveChar = eHeading.SOUTH

            MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = 0
            .Pos.Y = .Pos.Y + 1

        Case eHeading.WEST

            If Not IA_LegalPos(.Pos.X - 1, .Pos.Y, SiguiendoIndex) Then Exit Function

            IA_RandomMoveChar = eHeading.WEST

            MapData(.Pos.Map, .Pos.X, .Pos.Y).BotIndex = 0
            .Pos.X = .Pos.X - 1

        End Select

    End With

End Function

Private Function IA_PuedeMeele(ByRef PosBot As WorldPos, ByRef PosVictim As WorldPos) As Byte

    With PosVictim

        'Mirando hacia la derecha lo tiene?
        If PosBot.X + 1 = .X Then
            If .Y <> PosBot.Y Then Exit Function
            IA_PuedeMeele = eHeading.EAST
        End If

        'Mirando hacia izq lo tiene?
        If PosBot.X - 1 = .X Then
            If .Y <> PosBot.Y Then Exit Function
            IA_PuedeMeele = eHeading.WEST
        End If

        'Mirando arriba lo tiene?
        If PosBot.Y - 1 = .Y Then
            If .X <> PosBot.X Then Exit Function
            IA_PuedeMeele = eHeading.NORTH
        End If

        'mirando abajo lo tiene?
        If PosBot.Y + 1 = .Y Then
            If PosBot.X <> .X Then Exit Function
            IA_PuedeMeele = eHeading.SOUTH
        End If

    End With

End Function

