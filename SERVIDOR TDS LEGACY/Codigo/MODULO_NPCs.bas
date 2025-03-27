Attribute VB_Name = "NPCs"
Option Explicit

Sub AddToNpcTradingArray(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)
' @@ Cuicui
    If NpcIndex > 0 Then
        ' @@ me falta asignar alguna variable ,la veo desp
        If Npclist(NpcIndex).HasUserInCommerce Then
            ReDim Preserve Npclist(NpcIndex).npcTradingArray(UBound(Npclist(NpcIndex).npcTradingArray) + 1)
        Else
            ReDim Npclist(NpcIndex).npcTradingArray(0)
            Npclist(NpcIndex).HasUserInCommerce = True
        End If

        UserList(UserIndex).flags.commerce_npc_slot_index = UBound(Npclist(NpcIndex).npcTradingArray)
        UserList(UserIndex).flags.commerce_npc_npcindex = NpcIndex
        Npclist(NpcIndex).npcTradingArray(UserList(UserIndex).flags.commerce_npc_slot_index) = UserIndex
    End If
    Exit Sub
Errhandler:
    Call LogError("Err en AddToNpcTradingArray en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Sub RemoveToNpcTradingArray(ByVal UserIndex As Integer)
' @@ Cuicui
    Dim size As Long, NpcIndex As Integer
    NpcIndex = UserList(UserIndex).flags.commerce_npc_npcindex
    UserList(UserIndex).flags.commerce_npc_npcindex = 0


    If Npclist(NpcIndex).HasUserInCommerce Then
        size = UBound(Npclist(NpcIndex).npcTradingArray)
    Else
        size = 0
    End If

    If UserList(UserIndex).flags.commerce_npc_slot_index < size Then
        UserList(Npclist(NpcIndex).npcTradingArray(UBound(Npclist(NpcIndex).npcTradingArray))).flags.commerce_npc_slot_index = UserList(UserIndex).flags.commerce_npc_slot_index
        Npclist(NpcIndex).npcTradingArray(UserList(UserIndex).flags.commerce_npc_slot_index) = Npclist(NpcIndex).npcTradingArray(UBound(Npclist(NpcIndex).npcTradingArray))
    End If

    If size = 0 Then
        Npclist(NpcIndex).HasUserInCommerce = False
        Erase Npclist(NpcIndex).npcTradingArray
    Else
        ReDim Preserve Npclist(NpcIndex).npcTradingArray(size - 1)
    End If

    UserList(UserIndex).flags.commerce_npc_slot_index = 0

    Exit Sub
Errhandler:
    Call LogError("Err en RemoveToNpcTradingArray en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Sub QuitarMascota(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)

    Dim i As Long

    For i = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(i) = NpcIndex Then
            If Npclist(UserList(UserIndex).MascotasIndex(i)).flags.Domable > 0 Then
                UserList(UserIndex).MascotasType(i) = 0
            End If

            UserList(UserIndex).MascotasIndex(i) = 0

            If UserList(UserIndex).nroMascotas > 0 Then
                UserList(UserIndex).nroMascotas = UserList(UserIndex).nroMascotas - 1
            End If
            Exit For
        End If
    Next i
End Sub

Sub QuitarMascotaNpc(ByVal Maestro As Integer)
    Npclist(Maestro).Mascotas = Npclist(Maestro).Mascotas - 1
End Sub

Sub MuereNpc(ByVal NpcIndex As Integer, ByVal UserIndex As Integer)

    On Error GoTo Errhandler
    Dim MiNPC As npc
    Dim j As Long
    Dim UI As Integer
    Dim i As Long

1   MiNPC = Npclist(NpcIndex)

    ' @@ PRETORIANO, DEBERIA ESTAR ACA????
    Dim EraCriminal As Boolean
    Dim IsPretoriano As Boolean
    If (esPretoriano(NpcIndex) = 4) Then
        'Solo nos importa si fue matado en el mapa pretoriano.
        IsPretoriano = True
        If Npclist(NpcIndex).Pos.Map = MAPA_PRETORIANO Then    'seteamos todos estos 'flags' acorde para que cambien solos de alcoba
            Dim NPCI As Integer
            For i = 8 To 90
                For j = 8 To 90

2                   NPCI = MapData(Npclist(NpcIndex).Pos.Map, i, j).NpcIndex
                    If NPCI > 0 Then
3                       If esPretoriano(NPCI) > 0 And NPCI <> NpcIndex Then
4                           If Npclist(NpcIndex).Pos.X > 50 Then
5                               If Npclist(NPCI).Pos.X > 50 Then Npclist(NPCI).Invent.ArmourEqpSlot = 1
6                           Else
7                               If Npclist(NPCI).Pos.X <= 50 Then Npclist(NPCI).Invent.ArmourEqpSlot = 5
                            End If
                        End If
                    End If
                Next j
            Next i
8           Call CrearClanPretoriano(Npclist(NpcIndex).Pos.X)
        End If
    ElseIf esPretoriano(NpcIndex) > 0 Then
        IsPretoriano = True
9       If Npclist(NpcIndex).Pos.Map = MAPA_PRETORIANO Then
            Npclist(NpcIndex).Invent.ArmourEqpSlot = 0
            pretorianosVivos = pretorianosVivos - 1
        End If
    End If

    'Quitamos el npc
10  Call QuitarNPC(NpcIndex)

    If UserIndex > 0 Then        ' Lo mato un usuario?
        With UserList(UserIndex)

11          If MiNPC.flags.Snd3 > 0 Then
12              Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(MiNPC.flags.Snd3, MiNPC.Pos.X, MiNPC.Pos.Y))
            End If
            .flags.TargetNPC = 0
            .flags.TargetNpcTipo = eNPCType.Comun

            'El user que lo mato tiene mascotas?
14          If .nroMascotas > 0 Then
                Dim T As Long
15              For T = 1 To MAXMASCOTAS
16                  If .MascotasIndex(T) > 0 Then
17                      If Npclist(.MascotasIndex(T)).TargetNPC = NpcIndex Then
18                          Call FollowAmo(.MascotasIndex(T))
19                      End If
20                  End If
21              Next T
22          End If
            If .Counters.LeveleandoTick = 0 Then
                '.Counters.LeveleandoTick = 10    ' Debería ser 0 si ya maté a la criatura?
                'Call Protocol_Writes.WriteBonifStatus(UserIndex)
            End If

            'PARTY 9010
            If MiNPC.flags.ExpCount > 0 Then
                If .PartyIndex > 0 Then
                    'Call mod_Party.GetSuccess(.PartyIndex, MiNPC.flags.ExpCount, UserList(UserIndex).Pos.map, True)      'MiNPC.flags.ExpCount, MiNPC.Pos.map, MiNPC.Pos.X, MiNPC.Pos.Y)
23                  Call mod_Party.ObtenerExito(UserIndex, MiNPC.flags.ExpCount, MiNPC.Pos.Map, MiNPC.Pos.X, MiNPC.Pos.Y, True)
                Else

24                  If .Stats.NPCsMuertos < 32000 Then
                        .Stats.NPCsMuertos = .Stats.NPCsMuertos + 1
                    End If
                    'Call WriteBonifStatus(UserIndex)
25                  .Stats.Exp = .Stats.Exp + MiNPC.flags.ExpCount
26                  If .Stats.Exp > MAXEXP Then _
                       .Stats.Exp = MAXEXP
27                  Call WriteMultiMessage(UserIndex, eMessages.EarnExp, MiNPC.flags.ExpCount)
28                  Call WriteUpdateExp(UserIndex)
                    'Call WriteConsoleMsg(UserIndex, "Has ganado " & MiNPC.flags.ExpCount & " puntos de experiencia.", FontTypeNames.FONTTYPE_FIGHT)
                End If
                MiNPC.flags.ExpCount = 0
            End If

            '[/KEVIN]
            WriteMensajes UserIndex, e_Mensajes.Mensaje_25


29          EraCriminal = criminal(UserIndex)

            If MiNPC.Stats.Alineacion = 0 Then

                If MiNPC.Numero = Guardias Then
                    .Reputacion.NobleRep = 0
                    .Reputacion.PlebeRep = 0
                    .Reputacion.AsesinoRep = .Reputacion.AsesinoRep + 500
                    If .Reputacion.AsesinoRep > MAXREP Then .Reputacion.AsesinoRep = MAXREP
                End If

                If MiNPC.MaestroUser = 0 Then
                    .Reputacion.AsesinoRep = .Reputacion.AsesinoRep + vlASESINO
                    If .Reputacion.AsesinoRep > MAXREP Then .Reputacion.AsesinoRep = MAXREP
                End If
            ElseIf MiNPC.Stats.Alineacion = 1 Then
                .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlCAZADOR
                If .Reputacion.PlebeRep > MAXREP Then .Reputacion.PlebeRep = MAXREP
            ElseIf MiNPC.Stats.Alineacion = 2 Then
                .Reputacion.NobleRep = .Reputacion.NobleRep + 200    'vlASESINO / 2
                If .Reputacion.NobleRep > MAXREP Then .Reputacion.NobleRep = MAXREP
            ElseIf MiNPC.Stats.Alineacion = 4 Then
                .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlCAZADOR
                If .Reputacion.PlebeRep > MAXREP Then .Reputacion.PlebeRep = MAXREP
            End If

30          If criminal(UserIndex) And EsArmada(UserIndex) Then Call ExpulsarFaccionReal(UserIndex)
31          If Not criminal(UserIndex) And EsCaos(UserIndex) Then Call ExpulsarFaccionCaos(UserIndex)
32
            If EraCriminal And Not criminal(UserIndex) Then
33              Call RefreshCharStatus(UserIndex)
            ElseIf Not EraCriminal And criminal(UserIndex) Then
34              Call RefreshCharStatus(UserIndex)
            End If

35          Call CheckUserLevel(UserIndex)

71          If NpcIndex = .flags.ParalizedByNpcIndex Then
72              Call RemoveParalisis(UserIndex)        ' 0.13.3
73          End If

            ' ++ Si el npc lo mata un elemental Userindex 0 y japish
44          For i = 1 To MAXUSERQUESTS
45              With UserList(UserIndex).QuestStats.Quests(i)
46                  If .QuestIndex Then
47                      If QuestList(.QuestIndex).RequiredNPCs Then
48                          For j = 1 To QuestList(.QuestIndex).RequiredNPCs
49                              If QuestList(.QuestIndex).RequiredNPC(j).NpcIndex = MiNPC.Numero Then
50                                  If QuestList(.QuestIndex).RequiredNPC(j).Amount > .NPCsKilled(j) Then
51                                      .NPCsKilled(j) = .NPCsKilled(j) + 1
                                    End If
                                End If
                            Next j
                        End If
                    End If
                End With
            Next i

        End With
    End If        ' Userindex > 0

    If MiNPC.MaestroUser = 0 Then
        'Tiramos el oro
        ' Call NPCTirarOro(MiNPC)
        'Tiramos el inventario
37      Call NPC_TIRAR_ITEMS(MiNPC, IsPretoriano, UserIndex)
        'ReSpawn o no
38      Call ReSpawnNpc(MiNPC)
    Else
39      If UserList(MiNPC.MaestroUser).ConnIDValida Then
40          For i = 1 To MAXMASCOTAS
41              If UserList(MiNPC.MaestroUser).MascotasIndex(i) = NpcIndex Then
42                  UserList(MiNPC.MaestroUser).MascotasIndex(i) = 0
43                  UserList(MiNPC.MaestroUser).MascotasType(i) = 0
                End If
            Next i
        End If
    End If

    Exit Sub

Errhandler:
    Call LogError("Error en MuereNpc en " & Erl & " - Error: " & Err.Number & " - Desc: " & Err.Description)
End Sub

Private Sub ResetNpcFlags(ByVal NpcIndex As Integer)

    With Npclist(NpcIndex).flags
        .AfectaParalisis = 0
        .AguaValida = 0

        .backup = 0
        .Domable = 0
        .Envenenado = 0
        .faccion = 0
        .Follow = False
        .LanzaSpells = 0
        .invisible = 0
        .OldHostil = 0
        .OldMovement = 0
        .Paralizado = 0
        .Inmovilizado = 0
        .Respawn = 0
        .RespawnOrigPos = 0
        .Snd1 = 0
        .Snd2 = 0
        .Snd3 = 0
        .TierraInvalida = 0
        .OscuroInvalido = 0

    End With
End Sub

Private Sub ResetNpcCounters(ByVal NpcIndex As Integer)

    With Npclist(NpcIndex).Contadores
        .Paralisis = 0
        .TiempoExistencia = 0
    End With
End Sub

Private Sub ResetNpcCharInfo(ByVal NpcIndex As Integer)

    With Npclist(NpcIndex).Char
        .body = 0
        .CascoAnim = 0
        .CharIndex = 0
        .FX = 0
        .Head = 0
        .Heading = 0
        .loops = 0
        .ShieldAnim = 0
        .WeaponAnim = 0
    End With
End Sub

Private Sub ResetNpcCriatures(ByVal NpcIndex As Integer)

    Dim j As Long

    With Npclist(NpcIndex)
        For j = 1 To .NroCriaturas
            .Criaturas(j).NpcIndex = 0
            .Criaturas(j).NpcName = vbNullString
        Next j

        .NroCriaturas = 0
    End With
End Sub

Sub ResetExpresiones(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim j As Long

    With Npclist(NpcIndex)
        For j = 1 To .NroExpresiones
            .Expresiones(j) = vbNullString
        Next j

        .NroExpresiones = 0
    End With
End Sub

Private Sub ResetNpcMainInfo(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With Npclist(NpcIndex)
        .Contadores.Ataque = 0
        .Attackable = 0
        .Comercia = 0
        .Contadores.Ataque = 0
        .GiveEXP = 0
        .GiveGLD = 0
        .Hostile = 0
        .InvReSpawn = 0
        .QuestNumber = 0

        If .MaestroUser > 0 Then Call QuitarMascota(.MaestroUser, NpcIndex)
        If .MaestroNpc > 0 Then Call QuitarMascotaNpc(.MaestroNpc)
        If .Owner > 0 Then Call PerdioNpc(.Owner)

        .MaestroUser = 0
        .MaestroNpc = 0

        .Mascotas = 0
        .Movement = 0
        .Name = vbNullString
        .NPCtype = 0
        .Numero = 0
        .Orig.Map = 0
        .Orig.X = 0
        .Orig.Y = 0
        .PoderAtaque = 0
        .PoderEvasion = 0
        .Pos.Map = 0
        .Pos.X = 0
        .Pos.Y = 0
        .SkillDomar = 0
        .Target = 0
        .TargetNPC = 0
        .TipoItems = 0
        .Veneno = 0
        .Desc = vbNullString

        Dim j As Long
        For j = 1 To .NroSpells
            .Spells(j).Probability = 0
            .Spells(j).SpellID = 0
        Next j

    End With

    Call ResetNpcCharInfo(NpcIndex)
    Call ResetNpcCriatures(NpcIndex)
    Call ResetExpresiones(NpcIndex)
End Sub

Public Sub QuitarNPC(ByVal NpcIndex As Integer)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Now npcs lose their owner
'***************************************************
    On Error GoTo Errhandler

    With Npclist(NpcIndex)
        .flags.NPCActive = False

        .Owner = 0        ' Murio, no necesita mas dueños :P.

        If InMapBounds(.Pos.Map, .Pos.X, .Pos.Y) Then
            Call EraseNPCChar(NpcIndex)
        End If
    End With

    'Nos aseguramos de que el inventario sea removido...
    'asi los lobos no volveran a tirar armaduras ;))
    Call ResetNpcInv(NpcIndex)
    Call ResetNpcFlags(NpcIndex)
    Call ResetNpcCounters(NpcIndex)

    Call ResetNpcMainInfo(NpcIndex)

    If NpcIndex = LastNPC Then
        Do Until Npclist(LastNPC).flags.NPCActive
            LastNPC = LastNPC - 1
            If LastNPC < 1 Then Exit Do
        Loop
    End If


    If NumNPCs <> 0 Then
        NumNPCs = NumNPCs - 1
    End If
    Exit Sub

Errhandler:
    Call LogError("Error en QuitarNPC")
End Sub

Public Sub QuitarPet(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)
'***************************************************
'Autor: ZaMa
'Last Modification: 18/11/2009
'Kills a pet
'***************************************************
    On Error GoTo Errhandler

    Dim i As Long
    Dim PetIndex As Integer

    With UserList(UserIndex)

        ' Busco el indice de la mascota
        For i = 1 To MAXMASCOTAS
            If .MascotasIndex(i) = NpcIndex Then
                PetIndex = i
                Exit For
            End If
        Next i

        ' Poco probable que pase, pero por las dudas..
        If PetIndex < 1 Then Exit Sub

        If Npclist(.MascotasIndex(PetIndex)).flags.Domable > 0 Then
            .MascotasType(PetIndex) = 0
        End If

        ' Limpio el slot de la mascota
        .nroMascotas = .nroMascotas - 1
        .MascotasIndex(PetIndex) = 0

        ' Elimino la mascota
        Call QuitarNPC(NpcIndex)
    End With

    Exit Sub

Errhandler:

    Call LogError("Error en QuitarPet. Error: " & Err.Number & " Desc: " & Err.Description & " NpcIndex: " & NpcIndex & " UserIndex: " & UserIndex & " PetIndex: " & PetIndex)

End Sub

Private Function TestSpawnTrigger(Pos As WorldPos, Optional PuedeAgua As Boolean = False) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If LegalPos(Pos.Map, Pos.X, Pos.Y, PuedeAgua) Then
        TestSpawnTrigger = _
        MapData(Pos.Map, Pos.X, Pos.Y).trigger <> 3 And _
                           MapData(Pos.Map, Pos.X, Pos.Y).trigger <> 2 And _
                           MapData(Pos.Map, Pos.X, Pos.Y).trigger <> 1
    End If

End Function

Function CrearNPC(NroNPC As Integer, mapa As Integer, OrigPos As WorldPos, Optional ByVal enOrigen As Boolean = True) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'Crea un NPC del tipo NRONPC

    Dim Pos As WorldPos
    Dim newpos As WorldPos
    Dim altpos As WorldPos
    Dim nIndex As Integer
    Dim PosicionValida As Boolean
    Dim Iteraciones As Long
    Dim PuedeAgua As Boolean
    Dim PuedeTierra As Boolean


    Dim Map As Integer
    Dim X As Integer
    Dim Y As Integer

    nIndex = OpenNPC(NroNPC)        'Conseguimos un indice

    If nIndex > MAXNPCS Then Exit Function
    PuedeAgua = Npclist(nIndex).flags.AguaValida
    PuedeTierra = IIf(Npclist(nIndex).flags.TierraInvalida = 1, False, True)

    'Necesita ser respawned en un lugar especifico
    If InMapBounds(OrigPos.Map, OrigPos.X, OrigPos.Y) And enOrigen Then

        Map = OrigPos.Map
        X = OrigPos.X
        Y = OrigPos.Y
        Npclist(nIndex).Orig = OrigPos
        Npclist(nIndex).Pos = OrigPos

    Else

        Pos.Map = mapa        'mapa
        altpos.Map = mapa

        Do While Not PosicionValida
            Pos.X = RandomNumber(MinXBorder + 1, MaxXBorder - 1)    'Obtenemos posicion al azar en x
            Pos.Y = RandomNumber(MinYBorder + 1, MaxYBorder - 1)    'Obtenemos posicion al azar en y

            Call ClosestLegalPos(Pos, newpos, PuedeAgua, PuedeTierra, True)       'Nos devuelve la posicion valida mas cercana
            If newpos.X <> 0 And newpos.Y <> 0 Then
                altpos.X = newpos.X
                altpos.Y = newpos.Y        'posicion alternativa (para evitar el anti respawn, pero intentando qeu si tenía que ser en el agua, sea en el agua.)
            Else
                Call ClosestLegalPos(Pos, newpos, PuedeAgua, PuedeTierra)
                If newpos.X <> 0 And newpos.Y <> 0 Then
                    altpos.X = newpos.X
                    altpos.Y = newpos.Y        'posicion alternativa (para evitar el anti respawn)
                End If
            End If
            'Si X e Y son iguales a 0 significa que no se encontro posicion valida
            If LegalPosNPC(newpos.Map, newpos.X, newpos.Y, PuedeAgua) And _
               Not HayPCarea(newpos) And TestSpawnTrigger(newpos, PuedeAgua) Then
                'Asignamos las nuevas coordenas solo si son validas
                Npclist(nIndex).Pos.Map = newpos.Map
                Npclist(nIndex).Pos.X = newpos.X
                Npclist(nIndex).Pos.Y = newpos.Y
                PosicionValida = True
            Else
                newpos.X = 0
                newpos.Y = 0

            End If

            'for debug
            Iteraciones = Iteraciones + 1
            If Iteraciones > MAXSPAWNATTEMPS Then
                If altpos.X <> 0 And altpos.Y <> 0 Then
                    Map = altpos.Map
                    X = altpos.X
                    Y = altpos.Y
                    Npclist(nIndex).Pos.Map = Map
                    Npclist(nIndex).Pos.X = X
                    Npclist(nIndex).Pos.Y = Y
                    Call MakeNPCChar(True, Map, nIndex, Map, X, Y)
                    Exit Function
                Else
                    altpos.X = 50
                    altpos.Y = 50
                    Call ClosestLegalPos(altpos, newpos)
                    If newpos.X <> 0 And newpos.Y <> 0 Then
                        Npclist(nIndex).Pos.Map = newpos.Map
                        Npclist(nIndex).Pos.X = newpos.X
                        Npclist(nIndex).Pos.Y = newpos.Y
                        Call MakeNPCChar(True, newpos.Map, nIndex, newpos.Map, newpos.X, newpos.Y)
                        Exit Function
                    Else
                        Call QuitarNPC(nIndex)
                        Call LogError(MAXSPAWNATTEMPS & " iteraciones en CrearNpc Mapa:" & mapa & " NroNpc:" & NroNPC)
                        Exit Function
                    End If
                End If
            End If
        Loop

        'asignamos las nuevas coordenas
        Map = newpos.Map
        X = Npclist(nIndex).Pos.X
        Y = Npclist(nIndex).Pos.Y
    End If

    'Crea el NPC
    Call MakeNPCChar(True, Map, nIndex, Map, X, Y)

    CrearNPC = nIndex

End Function

Public Sub MakeNPCChar(ByVal toMap As Boolean, sndIndex As Integer, NpcIndex As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim CharIndex As Integer

    If NpcIndex > UBound(Npclist) Then
        MapData(Map, X, Y).NpcIndex = 0
        Exit Sub
    End If

    If Npclist(NpcIndex).Char.CharIndex = 0 Then
        CharIndex = NextOpenCharIndex
        Npclist(NpcIndex).Char.CharIndex = CharIndex
        CharList(CharIndex) = NpcIndex
    End If

    Npclist(NpcIndex).Pos.Map = Map
    Npclist(NpcIndex).Pos.X = X
    Npclist(NpcIndex).Pos.Y = Y

    MapData(Map, X, Y).NpcIndex = NpcIndex


    If Not toMap Then
        Call WriteCharacterCreate(sndIndex, Npclist(NpcIndex).Char.body, Npclist(NpcIndex).Char.Head, Npclist(NpcIndex).Char.Heading, Npclist(NpcIndex).Char.CharIndex, X, Y, 0, 0, 0, 0, 0, vbNullString, 0, 0, True)
        'Call Flushbuffer(sndIndex)
    Else
        Call AgregarNpc(NpcIndex)
    End If
End Sub

Public Sub ChangeNPCChar(ByVal NpcIndex As Integer, ByVal body As Integer, ByVal Head As Integer, ByVal Heading As eHeading)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If NpcIndex > 0 Then
        With Npclist(NpcIndex).Char
            .body = body
            .Head = Head
            .Heading = Heading

            Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCharacterChange(body, Head, Heading, .CharIndex, 0, 0, 0, 0, 0))
        End With
    End If
End Sub

Public Sub EraseNPCChar(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If Npclist(NpcIndex).Char.CharIndex <> 0 Then CharList(Npclist(NpcIndex).Char.CharIndex) = 0

    If Npclist(NpcIndex).Char.CharIndex = LastChar Then
        Do Until CharList(LastChar) > 0
            LastChar = LastChar - 1
            If LastChar <= 1 Then Exit Do
        Loop
    End If


    'Quitamos del mapa
    MapData(Npclist(NpcIndex).Pos.Map, Npclist(NpcIndex).Pos.X, Npclist(NpcIndex).Pos.Y).NpcIndex = 0

    'Actualizamos los clientes
    Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCharacterRemove(Npclist(NpcIndex).Char.CharIndex))

    'Update la lista npc
    Npclist(NpcIndex).Char.CharIndex = 0

    'update NumChars
    NumChars = NumChars - 1

End Sub

Public Sub MoveNPCChar(ByVal NpcIndex As Integer, ByVal nHeading As Byte)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 06/04/2009
'06/04/2009: ZaMa - Now npcs can force to change position with dead character
'01/08/2009: ZaMa - Now npcs can't force to chance position with a dead character if that means to change the terrain the character is in
'***************************************************

    On Error GoTo ERRH
    Dim nPos As WorldPos
    Dim UserIndex As Integer

    With Npclist(NpcIndex)
        nPos = .Pos

        Call HeadtoPos(nHeading, nPos)

        ' es una posicion legal
        If LegalPosNPC(.Pos.Map, nPos.X, nPos.Y, .flags.AguaValida = 1, .MaestroUser <> 0) Then

            If .flags.AguaValida = 0 And HayAgua(.Pos.Map, nPos.X, nPos.Y) Then Exit Sub
            If .flags.TierraInvalida = 1 And Not HayAgua(.Pos.Map, nPos.X, nPos.Y) Then Exit Sub
            If .flags.OscuroInvalido = 1 And Not MapData(.Pos.Map, nPos.X, nPos.Y).Graphic(4) = 0 Then Exit Sub
            If .MaestroUser <> 0 And Not MapData(.Pos.Map, nPos.X, nPos.Y).Graphic(4) = 0 Then Exit Sub
            If (MapData(.Pos.Map, nPos.X, nPos.Y).TileExit.Map > 0) Then Exit Sub

            UserIndex = MapData(.Pos.Map, nPos.X, nPos.Y).UserIndex
            ' Si hay un usuario a donde se mueve el npc, entonces esta muerto
            If UserIndex > 0 Then

                ' No se traslada caspers de agua a tierra
                If HayAgua(.Pos.Map, nPos.X, nPos.Y) And Not HayAgua(.Pos.Map, .Pos.X, .Pos.Y) Then Exit Sub
                ' No se traslada caspers de tierra a agua
                If Not HayAgua(.Pos.Map, nPos.X, nPos.Y) And HayAgua(.Pos.Map, .Pos.X, .Pos.Y) Then Exit Sub

                With UserList(UserIndex)
                    ' Actualizamos posicion y mapa
                    MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = 0
                    .Pos.X = Npclist(NpcIndex).Pos.X
                    .Pos.Y = Npclist(NpcIndex).Pos.Y
                    MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = UserIndex

                    ' Avisamos a los usuarios del area, y al propio usuario lo forzamos a moverse
                    Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageCharacterMove(UserList(UserIndex).Char.CharIndex, .Pos.X, .Pos.Y))
                    Call WriteForceCharMove(UserIndex, InvertHeading(nHeading))
                End With
            End If

            Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCharacterMove(.Char.CharIndex, nPos.X, nPos.Y))

            'Update map and user pos
            MapData(.Pos.Map, .Pos.X, .Pos.Y).NpcIndex = 0
            .Pos = nPos
            .Char.Heading = nHeading
            MapData(.Pos.Map, nPos.X, nPos.Y).NpcIndex = NpcIndex
            Call CheckUpdateNeededNpc(NpcIndex, nHeading)

        ElseIf .MaestroUser = 0 Then
            If .Movement = TipoAI.NpcPathfinding Then
                'Someone has blocked the npc's way, we must to seek a new path!
                .PFINFO.PathLenght = 0
            End If
        End If
    End With
    Exit Sub

ERRH:
    LogError ("Error en move npc " & NpcIndex)
End Sub

Function NextOpenNPC() As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler
    Dim LoopC As Long

    For LoopC = 1 To MAXNPCS + 1
        If LoopC > MAXNPCS Then Exit For
        If Not Npclist(LoopC).flags.NPCActive Then Exit For
    Next LoopC

    NextOpenNPC = LoopC
    Exit Function

Errhandler:
    Call LogError("Error en NextOpenNPC")
End Function

Sub NpcEnvenenarUser(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim N As Integer
    N = RandomNumber(1, 100)
    If N < 30 Then
        UserList(UserIndex).flags.Envenenado = 1
        WriteMensajes UserIndex, e_Mensajes.Mensaje_46
        Call WriteUpdateEnvenenado(UserIndex)
    End If

End Sub

Function SpawnNpc(ByVal NpcIndex As Integer, Pos As WorldPos, ByVal FX As Boolean, ByVal Respawn As Boolean, Optional ByVal Heading As eHeading = 0) As Integer
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 06/15/2008
'23/01/2007 -> Pablo (ToxicWaste): Creates an NPC of the type Npcindex
'06/15/2008 -> Optimizé el codigo. (NicoNZ)
'***************************************************
    Dim newpos As WorldPos
    Dim altpos As WorldPos
    Dim nIndex As Integer
    Dim PosicionValida As Boolean
    Dim PuedeAgua As Boolean
    Dim PuedeTierra As Boolean
    Dim PuedeOscuro As Boolean

    Dim Map As Integer
    Dim X As Integer
    Dim Y As Integer

    nIndex = OpenNPC(NpcIndex, Respawn)        'Conseguimos un indice

    If nIndex > MAXNPCS Then
        SpawnNpc = 0
        Exit Function
    End If

    If Heading > 0 Then
        Npclist(nIndex).Char.Heading = Heading
    End If

    PuedeAgua = Npclist(nIndex).flags.AguaValida
    PuedeTierra = Not Npclist(nIndex).flags.TierraInvalida = 1
    PuedeOscuro = (Not Npclist(nIndex).flags.OscuroInvalido = 1)
    PuedeOscuro = PuedeOscuro And (Npclist(nIndex).flags.Domable = 0)

    If NpcIndex = NPC_CENTINELA Then
        PuedeAgua = True
        PuedeTierra = True
    End If

    Call ClosestLegalPosNPC(Pos, newpos, PuedeAgua, PuedeTierra, PuedeOscuro)       'Nos devuelve la posicion valida mas cercana
    Call ClosestLegalPosNPC(Pos, altpos, PuedeAgua, , PuedeOscuro)
    'Si X e Y son iguales a 0 significa que no se encontro posicion valida

    If newpos.X <> 0 And newpos.Y <> 0 Then
        'Asignamos las nuevas coordenas solo si son validas
        If LegalPos(Pos.Map, newpos.X, newpos.Y, PuedeAgua, PuedeTierra, True, PuedeOscuro) Then
            Npclist(nIndex).Pos.Map = newpos.Map
            Npclist(nIndex).Pos.X = newpos.X
            Npclist(nIndex).Pos.Y = newpos.Y
            PosicionValida = True
        Else
            PosicionValida = False
        End If
    Else
        If altpos.X <> 0 And altpos.Y <> 0 Then
            If LegalPos(Pos.Map, altpos.X, altpos.Y, PuedeAgua, PuedeTierra, True, PuedeOscuro) Then
                Npclist(nIndex).Pos.Map = altpos.Map
                Npclist(nIndex).Pos.X = altpos.X
                Npclist(nIndex).Pos.Y = altpos.Y
                PosicionValida = True
            Else
                PosicionValida = False
            End If
        Else
            PosicionValida = False
        End If
    End If

    If Not PosicionValida Then
        Call QuitarNPC(nIndex)
        SpawnNpc = 0
        Exit Function
    End If

    'asignamos las nuevas coordenas
    Map = newpos.Map
    X = Npclist(nIndex).Pos.X
    Y = Npclist(nIndex).Pos.Y

    'Crea el NPC
    Call MakeNPCChar(True, Map, nIndex, Map, X, Y)

    If FX Then
        Call SendData(SendTarget.ToNPCArea, nIndex, PrepareMessagePlayWave(SND_WARP, X, Y))
        Call SendData(SendTarget.ToNPCArea, nIndex, PrepareMessageCreateFX(Npclist(nIndex).Char.CharIndex, FXIDs.FXWARP, 0))
    End If

    SpawnNpc = nIndex

End Function

Sub ReSpawnNpc(MiNPC As npc)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If (MiNPC.flags.Respawn = 0) Then Call CrearNPC(MiNPC.Numero, MiNPC.Pos.Map, MiNPC.Orig, True)

End Sub

Private Sub NPCTirarOro(ByRef MiNPC As npc)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'SI EL NPC TIENE ORO LO TIRAMOS
    If MiNPC.GiveGLD > 0 Then
        Dim MiObj As Obj
        Dim MiAux As Long
        MiAux = MiNPC.GiveGLD
        Do While MiAux > MAX_INVENTORY_OBJS
            MiObj.Amount = MAX_INVENTORY_OBJS
            MiObj.ObjIndex = iORO
            Call TirarItemAlPiso(MiNPC.Pos, MiObj)
            MiAux = MiAux - MAX_INVENTORY_OBJS
        Loop
        If MiAux > 0 Then
            MiObj.Amount = MiAux
            MiObj.ObjIndex = iORO
            Call TirarItemAlPiso(MiNPC.Pos, MiObj)
        End If
    End If
End Sub

Public Function OpenNPC(ByVal NpcNumber As Integer, Optional ByVal Respawn = True) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'###################################################
'#               ATENCION PELIGRO                  #
'###################################################
'
'    ¡¡¡¡ NO USAR GetVar PARA LEER LOS NPCS !!!!
'
'El que ose desafiar esta LEY, se las tendrá que ver
'conmigo. Para leer los NPCS se deberá usar la
'nueva clase clsIniManager.
'
'Alejo
'
'###################################################
    Dim NpcIndex As Integer
    Dim Leer As clsIniManager
    Dim LoopC As Long
    Dim ln As String

    Set Leer = LeerNPCs

    'If requested index is invalid, abort
    If Not Leer.KeyExists("NPC" & NpcNumber) Then
        OpenNPC = MAXNPCS + 1
        Exit Function
    End If

    NpcIndex = NextOpenNPC

    If NpcIndex > MAXNPCS Then        'Limite de npcs
        OpenNPC = NpcIndex
        Exit Function
    End If

    With Npclist(NpcIndex)
        .Numero = NpcNumber
        .Name = Leer.GetValue("NPC" & NpcNumber, "Name")
        .Desc = Leer.GetValue("NPC" & NpcNumber, "Desc")

        .GolpeExacto = val(Leer.GetValue("NPC" & NpcNumber, "GolpeExacto"))

        .Movement = val(Leer.GetValue("NPC" & NpcNumber, "Movement"))
        .flags.OldMovement = .Movement

        If Leer.GetValue("NPC" & NpcNumber, "Terreno") = "AGUAYTIERRA" Then
            .flags.AguaValida = 1
            .flags.TierraInvalida = 0
        ElseIf Leer.GetValue("NPC" & NpcNumber, "Terreno") = "TIERRA" Then
            .flags.AguaValida = 0
            .flags.TierraInvalida = 0
        ElseIf Leer.GetValue("NPC" & NpcNumber, "Terreno") = "AGUA" Then
            .flags.AguaValida = 1
            .flags.TierraInvalida = 1
        End If

        .flags.OscuroInvalido = val(Leer.GetValue("NPC" & NpcNumber, "OscuroInvalido"))

        ln = Leer.GetValue("NPC" & NpcNumber, "Faccion")
        If ln = "REAL" Then
            .flags.faccion = 0
        ElseIf ln = "CAOS" Then
            .flags.faccion = 1
        End If

        .NPCtype = val(Leer.GetValue("NPC" & NpcNumber, "NpcType"))

        .Char.body = val(Leer.GetValue("NPC" & NpcNumber, "Body"))

        .Char.Head = val(Leer.GetValue("NPC" & NpcNumber, "Head"))
        .Char.Heading = val(Leer.GetValue("NPC" & NpcNumber, "Heading"))

        .Attackable = val(Leer.GetValue("NPC" & NpcNumber, "Attackable"))
        .Comercia = val(Leer.GetValue("NPC" & NpcNumber, "Comercia"))
        .Hostile = val(Leer.GetValue("NPC" & NpcNumber, "Hostile"))
        .flags.OldHostil = .Hostile

        .GiveEXP_Orig = val(Leer.GetValue("NPC" & NpcNumber, "GiveEXP"))
        .GiveEXP = .GiveEXP_Orig * ExpMulti

        .HasUserInCommerce = False

        .flags.ExpCount = .GiveEXP

        .Veneno = val(Leer.GetValue("NPC" & NpcNumber, "Veneno"))

        .flags.Domable = val(Leer.GetValue("NPC" & NpcNumber, "Domable"))

        .GiveGLD_Orig = val(Leer.GetValue("NPC" & NpcNumber, "GiveGLD"))
        .GiveGLD = .GiveGLD_Orig * OroMulti

        .PoderAtaque = val(Leer.GetValue("NPC" & NpcNumber, "PoderAtaque"))
        .PoderEvasion = val(Leer.GetValue("NPC" & NpcNumber, "PoderEvasion"))

        .InvReSpawn = val(Leer.GetValue("NPC" & NpcNumber, "InvReSpawn"))

        .QuestNumber = val(Leer.GetValue("NPC" & NpcNumber, "QuestNumber"))

        With .Stats
            .MaxHP = val(Leer.GetValue("NPC" & NpcNumber, "MaxHP"))
            .MinHP = val(Leer.GetValue("NPC" & NpcNumber, "MinHP"))
            .MaxHIT = val(Leer.GetValue("NPC" & NpcNumber, "MaxHIT"))

            .MaxHITInvocable = val(Leer.GetValue("NPC" & NpcNumber, "MaxHITInvocable"))

            .MinHIT = val(Leer.GetValue("NPC" & NpcNumber, "MinHIT"))
            .def = val(Leer.GetValue("NPC" & NpcNumber, "DEF"))
            .defM = val(Leer.GetValue("NPC" & NpcNumber, "DEFm"))
            .Alineacion = val(Leer.GetValue("NPC" & NpcNumber, "Alineacion"))
        End With

        .Invent.NroItems = val(Leer.GetValue("NPC" & NpcNumber, "NROITEMS"))
        For LoopC = 1 To .Invent.NroItems
            ln = Leer.GetValue("NPC" & NpcNumber, "Obj" & LoopC)
            .Invent.Object(LoopC).ObjIndex = val(ReadField(1, ln, 45))
            .Invent.Object(LoopC).Amount = val(ReadField(2, ln, 45))
            If UBound(Split(ln, "-")) = 2 Then
                .Invent.Object(LoopC).RareDrop = val(ReadField(3, ln, 45))
            Else
                .Invent.Object(LoopC).RareDrop = 0
            End If

        Next LoopC

        For LoopC = 1 To MAX_NPC_DROPS
            ln = Leer.GetValue("NPC" & NpcNumber, "Drop" & LoopC)
            .Drop(LoopC).ObjIndex = val(ReadField(1, ln, 45))
            .Drop(LoopC).Amount = val(ReadField(2, ln, 45))
        Next LoopC

        .flags.LanzaSpells = val(Leer.GetValue("NPC" & NpcNumber, "LanzaSpells"))
        If .flags.LanzaSpells > 0 Then ReDim .Spells(1 To .flags.LanzaSpells)

        For LoopC = 1 To .flags.LanzaSpells
            ln = Leer.GetValue("NPC" & NpcNumber, "Sp" & LoopC)
            .Spells(LoopC).SpellID = val(Leer.GetValue("NPC" & NpcNumber, "Sp" & LoopC))

            If UBound(Split(ln, "-")) = 1 Then
                .Spells(LoopC).Probability = val(ReadField(2, ln, 45))
            Else
                .Spells(LoopC).Probability = 100
            End If

        Next LoopC

        If .NPCtype = eNPCType.Entrenador Then
            .NroCriaturas = val(Leer.GetValue("NPC" & NpcNumber, "NroCriaturas"))
            ReDim .Criaturas(1 To .NroCriaturas) As tCriaturasEntrenador
            For LoopC = 1 To .NroCriaturas
                .Criaturas(LoopC).NpcIndex = Leer.GetValue("NPC" & NpcNumber, "CI" & LoopC)
                .Criaturas(LoopC).NpcName = Leer.GetValue("NPC" & NpcNumber, "CN" & LoopC)
            Next LoopC
        End If

        With .flags
            .NPCActive = True


            If Respawn Then
                .Respawn = val(Leer.GetValue("NPC" & NpcNumber, "ReSpawn"))
            Else
                .Respawn = 1
            End If

            .backup = val(Leer.GetValue("NPC" & NpcNumber, "BackUp"))
            .RespawnOrigPos = val(Leer.GetValue("NPC" & NpcNumber, "OrigPos"))
            .AfectaParalisis = val(Leer.GetValue("NPC" & NpcNumber, "AfectaParalisis"))

            .Snd1 = val(Leer.GetValue("NPC" & NpcNumber, "Snd1"))
            .Snd2 = val(Leer.GetValue("NPC" & NpcNumber, "Snd2"))
            .Snd3 = val(Leer.GetValue("NPC" & NpcNumber, "Snd3"))
        End With

        '<<<<<<<<<<<<<< Expresiones >>>>>>>>>>>>>>>>
        .NroExpresiones = val(Leer.GetValue("NPC" & NpcNumber, "NROEXP"))
        If .NroExpresiones > 0 Then ReDim .Expresiones(1 To .NroExpresiones) As String
        For LoopC = 1 To .NroExpresiones
            .Expresiones(LoopC) = Leer.GetValue("NPC" & NpcNumber, "Exp" & LoopC)
        Next LoopC
        '<<<<<<<<<<<<<< Expresiones >>>>>>>>>>>>>>>>

        'Tipo de items con los que comercia
        .TipoItems = val(Leer.GetValue("NPC" & NpcNumber, "TipoItems"))

        .Ciudad = val(Leer.GetValue("NPC" & NpcNumber, "Ciudad"))

        .Invocable = val(Leer.GetValue("NPC" & NpcNumber, "Invocable"))

    End With

    NpcInfo(NpcNumber) = Npclist(NpcIndex)

    'Update contadores de NPCs
    If NpcIndex > LastNPC Then LastNPC = NpcIndex
    NumNPCs = NumNPCs + 1

    'Devuelve el nuevo Indice
    OpenNPC = NpcIndex
End Function

Public Sub DoFollow(ByVal NpcIndex As Integer, ByVal UserName As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With Npclist(NpcIndex)
        If .flags.Follow Then

            .flags.AttackedBy = vbNullString
            .flags.Follow = False
            .Movement = .flags.OldMovement
            .Hostile = .flags.OldHostil
            .Target = 0
        Else
            .flags.Follow = True
            .Movement = TipoAI.NPCDEFENSA
            .Hostile = 0
            .Target = NameIndex(UserName)
            .flags.AttackedBy = UserName
        End If
    End With
End Sub

Public Sub FollowAmo(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With Npclist(NpcIndex)
        .flags.Follow = True
        .Movement = TipoAI.SigueAmo
        .Hostile = 0
        .Target = 0
        .TargetNPC = 0
    End With
End Sub

Public Sub ValidarPermanenciaNpc(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'Chequea si el npc continua perteneciendo a algún usuario
'***************************************************

    With Npclist(NpcIndex)
        If IntervaloPerdioNpc(.Owner) Then Call PerdioNpc(.Owner)
    End With
End Sub


