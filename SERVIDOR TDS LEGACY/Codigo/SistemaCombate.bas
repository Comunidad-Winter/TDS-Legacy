Attribute VB_Name = "SistemaCombate"
Option Explicit

Public Const MAXDISTANCIAARCO As Byte = 18
Public Const MAXDISTANCIAMAGIA As Byte = 18

Public Function MinimoInt(ByVal a As Integer, ByVal b As Integer) As Integer
    If a > b Then
        MinimoInt = b
    Else
        MinimoInt = a
    End If
End Function

Public Function MaximoInt(ByVal a As Integer, ByVal b As Integer) As Integer
    If a > b Then
        MaximoInt = a
    Else
        MaximoInt = b
    End If
End Function

Public Function PoderEvasionEscudo(ByVal UserIndex As Integer) As Long
    PoderEvasionEscudo = (UserList(UserIndex).Stats.UserSkills(eSkill.Defensa) * ModClase(UserList(UserIndex).Clase).Escudo) / 2
End Function

Public Function PoderEvasion(ByVal UserIndex As Integer) As Long

    Dim lTemp As Long
    With UserList(UserIndex)
        lTemp = (.Stats.UserSkills(eSkill.Tacticas) + _
                 .Stats.UserSkills(eSkill.Tacticas) / 33 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).Evasion

        PoderEvasion = (lTemp + (2.5 * MaximoInt(.Stats.ELV - 12, 0)))
    End With
End Function

Public Function PoderAtaqueArma(ByVal UserIndex As Integer) As Long

    Dim PoderAtaqueTemp As Long

    With UserList(UserIndex)
        If .Stats.UserSkills(eSkill.Armas) < 31 Then
            PoderAtaqueTemp = .Stats.UserSkills(eSkill.Armas) * ModClase(.Clase).AtaqueArmas
        ElseIf .Stats.UserSkills(eSkill.Armas) < 61 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Armas) + .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueArmas
        ElseIf .Stats.UserSkills(eSkill.Armas) < 91 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Armas) + 2 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueArmas
        Else
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Armas) + 3 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueArmas
        End If

        PoderAtaqueArma = (PoderAtaqueTemp + (2.5 * MaximoInt(.Stats.ELV - 12, 0)))
    End With
End Function

Public Function PoderAtaqueProyectil(ByVal UserIndex As Integer) As Long

    Dim PoderAtaqueTemp As Long

    With UserList(UserIndex)
        If .Stats.UserSkills(eSkill.proyectiles) < 31 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.proyectiles) + 0.5) * ModClase(.Clase).AtaqueProyectiles
        ElseIf .Stats.UserSkills(eSkill.proyectiles) < 61 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.proyectiles) + .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueProyectiles
        ElseIf .Stats.UserSkills(eSkill.proyectiles) < 91 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.proyectiles) + 1.5 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueProyectiles
        ElseIf .Stats.UserSkills(eSkill.proyectiles) < 99 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.proyectiles) + 1.5 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueProyectiles
        Else
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.proyectiles) + 3 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueProyectiles
        End If

        PoderAtaqueProyectil = (PoderAtaqueTemp + (2.5 * MaximoInt(.Stats.ELV - 12, 0)))
    End With

End Function

Public Function PoderAtaqueWrestling(ByVal UserIndex As Integer) As Long

    Dim PoderAtaqueTemp As Long

    With UserList(UserIndex)
        If .Stats.UserSkills(eSkill.Wrestling) < 31 Then
            PoderAtaqueTemp = .Stats.UserSkills(eSkill.Wrestling) * ModClase(.Clase).AtaqueWrestling
        ElseIf .Stats.UserSkills(eSkill.Wrestling) < 61 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Wrestling) + .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueWrestling
        ElseIf .Stats.UserSkills(eSkill.Wrestling) < 91 Then
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Wrestling) + 2 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueWrestling
        Else
            PoderAtaqueTemp = (.Stats.UserSkills(eSkill.Wrestling) + 3 * .Stats.UserAtributos(eAtributos.Agilidad)) * ModClase(.Clase).AtaqueWrestling
        End If

        PoderAtaqueWrestling = (PoderAtaqueTemp + (2.5 * MaximoInt(.Stats.ELV - 12, 0)))
    End With
End Function

Public Function UserImpactoNpc(ByVal UserIndex As Integer, ByVal NpcIndex As Integer) As Boolean

    Dim PoderAtaque As Long
    Dim Arma As Integer
    Dim Skill As eSkill
    Dim ProbExito As Long

    Arma = UserList(UserIndex).Invent.WeaponEqpObjIndex

    If Arma > 0 Then        'Usando un arma
        If ObjData(Arma).proyectil = 1 Then
            PoderAtaque = PoderAtaqueProyectil(UserIndex)
            Skill = eSkill.proyectiles
        Else
            PoderAtaque = PoderAtaqueArma(UserIndex)
            Skill = eSkill.Armas
        End If
    Else        'Peleando con puños
        PoderAtaque = PoderAtaqueWrestling(UserIndex)
        Skill = eSkill.Wrestling
    End If

    ' Chances are rounded
    ProbExito = MaximoInt(10, MinimoInt(90, 50 + ((PoderAtaque - Npclist(NpcIndex).PoderEvasion) * 0.4)))

    UserImpactoNpc = (RandomNumber(1, 100) <= ProbExito)

    If UserImpactoNpc Then

        If Arma > 0 Then
            If ObjData(Arma).proyectil = 1 And UserList(UserIndex).flags.oculto = 0 Then
                Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCreateProjectile(UserList(UserIndex).Char.CharIndex, Npclist(NpcIndex).Char.CharIndex, ObjData(UserList(UserIndex).Invent.MunicionEqpObjIndex).GrhIndex))
            End If
        End If

        Call SubirSkill(UserIndex, Skill, True)
    Else
        Call SubirSkill(UserIndex, Skill, False)
    End If
End Function

Public Function NpcImpacto(ByVal NpcIndex As Integer, ByVal UserIndex As Integer) As Boolean

    Dim Rechazo As Boolean
    Dim ProbRechazo As Long
    Dim ProbExito As Long
    Dim UserEvasion As Long
    Dim NpcPoderAtaque As Long
    Dim PoderEvasioEscudo As Long
    Dim SkillTacticas As Long
    Dim SkillDefensa As Long

    UserEvasion = PoderEvasion(UserIndex)
    NpcPoderAtaque = Npclist(NpcIndex).PoderAtaque
    PoderEvasioEscudo = PoderEvasionEscudo(UserIndex)

    SkillTacticas = UserList(UserIndex).Stats.UserSkills(eSkill.Tacticas)
    SkillDefensa = UserList(UserIndex).Stats.UserSkills(eSkill.Defensa)

    'Esta usando un escudo ???
    If UserList(UserIndex).Invent.EscudoEqpObjIndex > 0 Then UserEvasion = UserEvasion + PoderEvasioEscudo

    ' Chances are rounded
    ProbExito = MaximoInt(10, MinimoInt(90, 50 + ((NpcPoderAtaque - UserEvasion) * 0.4)))

    NpcImpacto = (RandomNumber(1, 100) <= ProbExito)

    ' el usuario esta usando un escudo ???
    If UserList(UserIndex).Invent.EscudoEqpObjIndex > 0 Then
        If Not NpcImpacto Then
            If SkillDefensa + SkillTacticas > 0 Then        'Evitamos división por cero
                ' Chances are rounded
                ProbRechazo = MaximoInt(10, MinimoInt(90, 100 * SkillDefensa / (SkillDefensa + SkillTacticas)))
                Rechazo = (RandomNumber(1, 100) <= ProbRechazo)

                If Rechazo Then
                    'Se rechazo el ataque con el escudo
                    SendData SendTarget.ToPCArea, UserIndex, PrepareMessageMovimientSW(UserList(UserIndex).Char.CharIndex, 2)
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_ESCUDO, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
                    Call WriteMultiMessage(UserIndex, eMessages.BlockedWithShieldUser)        'Call WriteBlockedWithShieldUser(UserIndex)
                    Call SubirSkill(UserIndex, eSkill.Defensa, True)
                Else
                    Call SubirSkill(UserIndex, eSkill.Defensa, False)
                End If
            End If
        End If
    End If
End Function

Public Function CalcularDaño(ByVal UserIndex As Integer, Optional ByVal NpcIndex As Integer = 0) As Long

    Dim DañoArma As Long
    Dim DañoUsuario As Long
    Dim Arma As ObjData
    Dim ModifClase As Single
    Dim proyectil As ObjData
    Dim DañoMaxArma As Long
    Dim DañoMinArma As Long
    Dim ObjIndex As Integer

    ''sacar esto si no queremos q la matadracos mate el Dragon si o si
    Dim matoDragon As Boolean
    matoDragon = False

    With UserList(UserIndex)
        If .Invent.WeaponEqpObjIndex > 0 Then
            Arma = ObjData(.Invent.WeaponEqpObjIndex)

            ' Ataca a un npc?
            If NpcIndex > 0 Then
                If Arma.proyectil = 1 Then
                    ModifClase = ModClase(.Clase).DañoProyectiles
                    DañoArma = RandomNumber(Arma.MinHIT, Arma.MaxHIT)
                    DañoMaxArma = Arma.MaxHIT

                    If Arma.Municion = 1 Then
                        proyectil = ObjData(.Invent.MunicionEqpObjIndex)
                        DañoArma = DañoArma + RandomNumber(proyectil.MinHIT, proyectil.MaxHIT)
                        ' For some reason this isn't done...
                        'DañoMaxArma = DañoMaxArma + proyectil.MaxHIT
                    End If
                Else
                    ModifClase = ModClase(.Clase).DañoArmas

                    If .Invent.WeaponEqpObjIndex = EspadaMataDragonesIndex Then        ' Usa la mata Dragones?
                        If Npclist(NpcIndex).NPCtype = DRAGON Then        'Ataca Dragon?
                            DañoArma = RandomNumber(Arma.MinHIT, Arma.MaxHIT)
                            DañoMaxArma = Arma.MaxHIT
                            matoDragon = True        ''sacar esto si no queremos q la matadracos mate el Dragon si o si

                            Call LogDesarrollo(UserList(UserIndex).Name & " quemó una matadragones")
                        Else        ' Sino es Dragon daño es 1
                            DañoArma = 1
                            DañoMaxArma = 1
                        End If
                    Else
                        DañoArma = RandomNumber(Arma.MinHIT, Arma.MaxHIT)
                        DañoMaxArma = Arma.MaxHIT
                    End If
                End If
            Else        ' Ataca usuario
                If Arma.proyectil = 1 Then
                    ModifClase = ModClase(.Clase).DañoProyectiles
                    DañoArma = RandomNumber(Arma.MinHIT, Arma.MaxHIT)
                    DañoMaxArma = Arma.MaxHIT

                    If Arma.Municion = 1 Then
                        proyectil = ObjData(.Invent.MunicionEqpObjIndex)
                        DañoArma = DañoArma + RandomNumber(proyectil.MinHIT, proyectil.MaxHIT)
                        ' For some reason this isn't done...
                        'DañoMaxArma = DañoMaxArma + proyectil.MaxHIT
                    End If
                Else
                    ModifClase = ModClase(.Clase).DañoArmas

                    If .Invent.WeaponEqpObjIndex = EspadaMataDragonesIndex Then
                        ModifClase = ModClase(.Clase).DañoArmas
                        DañoArma = 1        ' Si usa la espada mataDragones daño es 1
                        DañoMaxArma = 1
                    Else
                        DañoArma = RandomNumber(Arma.MinHIT, Arma.MaxHIT)
                        DañoMaxArma = Arma.MaxHIT
                    End If
                End If
            End If
        Else
            ModifClase = ModClase(.Clase).DañoWrestling

            ' Daño sin guantes
            DañoMinArma = 4
            DañoMaxArma = 9

            ' Plus de guantes (en slot de anillo)
            ObjIndex = .Invent.AnilloEqpObjIndex
            If ObjIndex > 0 Then
                If ObjData(ObjIndex).Guante = 1 Then
                    DañoMinArma = DañoMinArma + ObjData(ObjIndex).MinHIT
                    DañoMaxArma = DañoMaxArma + ObjData(ObjIndex).MaxHIT
                End If
            End If

            DañoArma = RandomNumber(DañoMinArma, DañoMaxArma)

        End If

        DañoUsuario = RandomNumber(.Stats.MinHIT, .Stats.MaxHIT)

        ''sacar esto si no queremos q la matadracos mate el Dragon si o si
        If matoDragon Then
            CalcularDaño = Npclist(NpcIndex).Stats.MinHP + Npclist(NpcIndex).Stats.def
        Else
            If .Invent.WeaponEqpObjIndex <> EspadaMataDragonesIndex Then
                CalcularDaño = (3 * DañoArma + ((DañoMaxArma / 5) * MaximoInt(0, .Stats.UserAtributos(eAtributos.Fuerza) - 15)) + DañoUsuario) * ModifClase
            Else
                CalcularDaño = 1
            End If
        End If
    End With
End Function

Public Sub UserDañoNpc(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)

    Dim Daño As Long
    Dim DañoBase As Long
    Dim isCritic As Byte

1   On Error GoTo UserDañoNpc_Error

    DañoBase = CalcularDaño(UserIndex, NpcIndex)

    'esta navegando? si es asi le sumamos el daño del barco
    If UserList(UserIndex).flags.Navegando = 1 Then
        If UserList(UserIndex).Invent.BarcoObjIndex > 0 Then
            DañoBase = DañoBase + RandomNumber(ObjData(UserList(UserIndex).Invent.BarcoObjIndex).MinHIT, _
                                               ObjData(UserList(UserIndex).Invent.BarcoObjIndex).MaxHIT)
        End If
    End If

    If UserList(UserIndex).Clase = eClass.Hunter Then
        If UserList(UserIndex).Invent.WeaponEqpObjIndex > 0 Then
            Select Case UserList(UserIndex).Invent.WeaponEqpObjIndex
            Case 479
                DañoBase = DañoBase + Int(UserList(UserIndex).Stats.ELV / 2)
                isCritic = 1
            Case 628, 627
                DañoBase = DañoBase + UserList(UserIndex).Stats.ELV
                isCritic = 2
            End Select
        End If
    End If

    With Npclist(NpcIndex)
        Daño = DañoBase - .Stats.def

        If Daño <= 0 Then Daño = 1

        'Call WriteUserHitNPC(UserIndex, daño)
        Call WriteMultiMessage(UserIndex, eMessages.UserHitNPC, Daño)

        .Stats.MinHP = .Stats.MinHP - Daño

        Dim Apuñalo As Boolean

        If .Stats.MinHP > 0 Then
            'Trata de apuñalar por la espalda al enemigo
            If PuedeApuñalar(UserIndex) Then
17              If UserList(UserIndex).Clase <> eClass.Assasin Then        ' 0.13.3
18                  DañoBase = Daño
19              End If

                Call DoApuñalar(UserIndex, NpcIndex, 0, DañoBase, Apuñalo)
                If Apuñalo Then
                    Daño = DañoBase + Daño
                End If
            End If

            If PuedeAcuchillar(UserIndex) Then
                Call DoAcuchillar(UserIndex, NpcIndex, 0, Daño)
            End If
        End If

        If Not Apuñalo Then
            If Daño < 32000 Then
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateDamage(.Char.CharIndex, Daño, 255, 0, 0))
            Else
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateDamage(.Char.CharIndex, 9999, 255, 0, 0))
            End If
        End If

        If isCritic Then
            Call WriteConsoleMsg(UserIndex, "¡¡Le has pegado un golpe crítico por " & IIf(isCritic = 1, Int(UserList(UserIndex).Stats.ELV / 2), UserList(UserIndex).Stats.ELV) & " a la criatura!!", FontTypeNames.FONTTYPE_FIGHT)
        End If

14      Call CalcularDarExp(UserIndex, NpcIndex, Daño)

        If .Stats.MinHP <= 0 Then
            ' Si era un Dragon perdemos la espada mataDragones
            If .NPCtype = DRAGON Then
                'Si tiene equipada la matadracos se la sacamos
                If UserList(UserIndex).Invent.WeaponEqpObjIndex = EspadaMataDragonesIndex Then
                    Call QuitarObjetos(EspadaMataDragonesIndex, 1, UserIndex)
                End If
                If .Stats.MaxHP > 100000 Then Call LogDesarrollo(UserList(UserIndex).Name & " mató un dragón")
            End If

            ' Para que las mascotas no sigan intentando luchar y
            ' comiencen a seguir al amo
            Dim j As Long
            For j = 1 To MAXMASCOTAS
                If UserList(UserIndex).MascotasIndex(j) > 0 Then
                    If Npclist(UserList(UserIndex).MascotasIndex(j)).TargetNPC = NpcIndex Then
                        Npclist(UserList(UserIndex).MascotasIndex(j)).TargetNPC = 0
                        Npclist(UserList(UserIndex).MascotasIndex(j)).Movement = TipoAI.SigueAmo
                    End If
                End If
            Next j

            Call MuereNpc(NpcIndex, UserIndex)
        End If
    End With

59  Exit Sub

UserDañoNpc_Error:

60  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure UserDañoNpc of Módulo modSistemaCombate " & Erl & ".")
End Sub

Public Sub NpcDaño(ByVal NpcIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Daño As Integer
    Dim Lugar As Integer
    Dim absorbido As Integer
    Dim defbarco As Integer
    Dim Obj As ObjData

    Daño = RandomNumber(Npclist(NpcIndex).Stats.MinHIT, Npclist(NpcIndex).Stats.MaxHIT)

    With UserList(UserIndex)
        If .flags.Navegando = 1 And .Invent.BarcoObjIndex > 0 Then
            Obj = ObjData(.Invent.BarcoObjIndex)
            defbarco = RandomNumber(Obj.MinDef, Obj.MaxDef)
        End If

        Lugar = RandomNumber(PartesCuerpo.bCabeza, PartesCuerpo.bTorso)

        Select Case Lugar
        Case PartesCuerpo.bCabeza
            'Si tiene casco absorbe el golpe
            If .Invent.CascoEqpObjIndex > 0 Then
                Obj = ObjData(.Invent.CascoEqpObjIndex)
                absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
            End If
        Case Else
            'Si tiene armadura absorbe el golpe
            If .Invent.ArmourEqpObjIndex > 0 Then
                Dim Obj2 As ObjData
                Obj = ObjData(.Invent.ArmourEqpObjIndex)
                If .Invent.EscudoEqpObjIndex Then
                    Obj2 = ObjData(.Invent.EscudoEqpObjIndex)
                    absorbido = RandomNumber(Obj.MinDef + Obj2.MinDef, Obj.MaxDef + Obj2.MaxDef)
                Else
                    absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
                End If
            End If
        End Select

        absorbido = absorbido + defbarco
        Daño = Daño - absorbido
        If Daño < 1 Then Daño = 1

        Call WriteMultiMessage(UserIndex, eMessages.NPCHitUser, Lugar, Daño)
        'Call WriteNPCHitUser(UserIndex, Lugar, daño)

        If Not EsGM(UserIndex) Or (EsGM(UserIndex) And .flags.AdminPerseguible = True) Then
            .Stats.MinHP = .Stats.MinHP - Daño
        End If

        SendData SendTarget.ToPCArea, UserIndex, PrepareMessageCreateDamage(UserList(UserIndex).Char.CharIndex, Daño, 255, 0, 0)

        If .flags.MenuCliente <> eVentanas.vInventario Then
            .Counters.TickReactionInv = GetTickCount() And &H7FFFFFFF
        End If

        If .flags.Meditando Then
            'If daño > Fix(.Stats.MinHp / 100 * .Stats.UserAtributos(eAtributos.Inteligencia) * .Stats.UserSkills(eSkill.Meditar) / 100 * 12 / (RandomNumber(0, 5) + 7)) Then
            .flags.Meditando = False
            Call WriteMeditateToggle(UserIndex)
            WriteMensajes UserIndex, e_Mensajes.Mensaje_216

            .Char.FX = 0
            .Char.loops = 0
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
            'End If
        End If

        'Muere el usuario
        If .Stats.MinHP <= 0 Then
            Call WriteMultiMessage(UserIndex, eMessages.NPCKillUser)        'Call WriteNPCKillUser(UserIndex) ' Le informamos que ha muerto ;)

            'Si lo mato un guardia
            If criminal(UserIndex) And Npclist(NpcIndex).NPCtype = eNPCType.GuardiaReal Then
                Call RestarCriminalidad(UserIndex)
                If Not criminal(UserIndex) And .faccion.FuerzasCaos = 1 Then Call ExpulsarFaccionCaos(UserIndex)
            End If

            If Npclist(NpcIndex).MaestroUser > 0 Then
                Call AllFollowAmo(Npclist(NpcIndex).MaestroUser)
            Else
                'Al matarlo no lo sigue mas
                If Npclist(NpcIndex).Stats.Alineacion = 0 Then
                    Npclist(NpcIndex).Movement = Npclist(NpcIndex).flags.OldMovement
                    Npclist(NpcIndex).Hostile = Npclist(NpcIndex).flags.OldHostil
                    Npclist(NpcIndex).flags.AttackedBy = vbNullString
                End If
            End If

            Call UserDie(UserIndex, Not EsGM(UserIndex))
        End If
    End With
End Sub

Public Sub RestarCriminalidad(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim EraCriminal As Boolean
    EraCriminal = criminal(UserIndex)

    With UserList(UserIndex).Reputacion
        If .BandidoRep > 0 Then
            .BandidoRep = .BandidoRep - vlASALTO
            If .BandidoRep < 0 Then .BandidoRep = 0
        ElseIf .LadronesRep > 0 Then
            .LadronesRep = .LadronesRep - (vlCAZADOR * 10)
            If .LadronesRep < 0 Then .LadronesRep = 0
        End If
    End With

    If EraCriminal And Not criminal(UserIndex) Then
        Call RefreshCharStatus(UserIndex)
    End If
End Sub

Public Sub CheckPets(ByVal NpcIndex As Integer, ByVal UserIndex As Integer, Optional ByVal CheckElementales As Boolean = True)
'***************************************************
'Author: Unknown
'Last Modification: 15/04/2010
'15/04/2010: ZaMa - Las mascotas no se apropian de npcs.
'***************************************************

' Si no tengo mascotas, para que cheaquear lo demas?
    If UserList(UserIndex).nroMascotas = 0 Then Exit Sub
    If Not PuedeAtacarNPC(UserIndex, NpcIndex, , True) Then Exit Sub

    Dim j As Long

    With UserList(UserIndex)
        For j = 1 To MAXMASCOTAS
            If .MascotasIndex(j) > 0 Then
                If .MascotasIndex(j) <> NpcIndex Then
                    If CheckElementales Or (Npclist(.MascotasIndex(j)).Numero <> ELEMENTALFUEGO And Npclist(.MascotasIndex(j)).Numero <> ELEMENTALTIERRA) Then

                        If Npclist(.MascotasIndex(j)).TargetNPC = 0 Then Npclist(.MascotasIndex(j)).TargetNPC = NpcIndex
                        Npclist(.MascotasIndex(j)).Movement = TipoAI.NpcAtacaNpc
                    End If
                End If
            End If
        Next j
    End With
End Sub

Public Sub AllFollowAmo(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim j As Long

    For j = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(j) > 0 Then
            Call FollowAmo(UserList(UserIndex).MascotasIndex(j))
        End If
    Next j

End Sub

Public Function NpcAtacaUser(ByVal NpcIndex As Integer, ByVal UserIndex As Integer) As Boolean
'*************************************************
'Author: Unknown
'Last modified: -
'
'*************************************************

    With UserList(UserIndex)
        If .flags.AdminInvisible = 1 Then Exit Function
        If Not EsGM(UserIndex) And Not .flags.AdminPerseguible Then Exit Function
    End With

    With Npclist(NpcIndex)
        ' El npc puede atacar ???
        If NpcIntervaloGolpe(NpcIndex) Then
            NpcAtacaUser = True
            Call CheckPets(NpcIndex, UserIndex, False)

            If .Target = 0 Then .Target = UserIndex

            If UserList(UserIndex).flags.AtacadoPorNpc = 0 And UserList(UserIndex).flags.AtacadoPorUser = 0 Then
                UserList(UserIndex).flags.AtacadoPorNpc = NpcIndex
            End If
        Else
            NpcAtacaUser = False
            Exit Function
        End If

        If .flags.Snd1 > 0 Then
            Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessagePlayWave(.flags.Snd1, .Pos.X, .Pos.Y))
        End If
    End With

    If NpcImpacto(NpcIndex, UserIndex) Then
        With UserList(UserIndex)
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_IMPACTO, .Pos.X, .Pos.Y))

            If .flags.Meditando = False Then
                If .flags.Navegando = 0 Then
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, FXSANGRE, 0))
                End If
            End If

            Call NpcDaño(NpcIndex, UserIndex)
            Call WriteUpdateHP(UserIndex)

            '¿Puede envenenar?
            If Npclist(NpcIndex).Veneno = 1 Then Call NpcEnvenenarUser(UserIndex)
        End With

        Call SubirSkill(UserIndex, eSkill.Tacticas, False)
    Else
        Call WriteMultiMessage(UserIndex, eMessages.NPCSwing)
        Call SubirSkill(UserIndex, eSkill.Tacticas, True)
    End If

    'Controla el nivel del usuario
    Call CheckUserLevel(UserIndex)
End Function

Private Function NpcImpactoNpc(ByVal Atacante As Integer, ByVal Victima As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim PoderAtt As Long
    Dim PoderEva As Long
    Dim ProbExito As Long

    PoderAtt = Npclist(Atacante).PoderAtaque
    PoderEva = Npclist(Victima).PoderEvasion

    ' Chances are rounded
    ProbExito = MaximoInt(10, MinimoInt(90, 50 + (PoderAtt - PoderEva) * 0.4))
    NpcImpactoNpc = (RandomNumber(1, 100) <= ProbExito)
End Function

Public Sub NpcDañoNpc(ByVal Atacante As Integer, ByVal Victima As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Daño As Integer

    With Npclist(Atacante)

        Daño = RandomNumber(.Stats.MinHIT, .Stats.MaxHIT)

        If Not Npclist(Atacante).Stats.MaxHITInvocable = 0 Then
            Daño = RandomNumber(MinimoInt(.Stats.MinHIT * 1.15, Npclist(Atacante).Stats.MaxHITInvocable), Npclist(Atacante).Stats.MaxHITInvocable)
        End If

        Npclist(Victima).Stats.MinHP = Npclist(Victima).Stats.MinHP - Daño

        Call CalcularDarExp(.MaestroUser, Victima, Daño)

        If Npclist(Victima).Stats.MinHP < 1 Then
            .Movement = .flags.OldMovement

            If LenB(.flags.AttackedBy) <> 0 Then
                .Hostile = .flags.OldHostil
            End If

            If .MaestroUser > 0 Then
                Call FollowAmo(Atacante)
            End If

            If Npclist(Victima).MaestroUser > 0 Then
                Dim i As Long
                For i = 1 To MAXMASCOTAS
                    If UserList(Npclist(Victima).MaestroUser).MascotasIndex(i) = Victima Then
                        'UserList(Npclist(Victima).MaestroUser).MascotasIndex(i) = 0
                        UserList(Npclist(Victima).MaestroUser).MascotasType(i) = 0
                        '                        UserList(Npclist(Victima).MaestroUser).nroMascotas = UserList(Npclist(Victima).MaestroUser).nroMascotas - 1

                    End If
                Next i
            End If
            Call MuereNpc(Victima, .MaestroUser)
        End If
    End With
End Sub

Public Sub NpcAtacaNpc(ByVal Atacante As Integer, ByVal Victima As Integer, Optional ByVal cambiarMOvimiento As Boolean = True)
'*************************************************
'Author: Unknown
'Last modified: 01/03/2009
'01/03/2009: ZaMa - Las mascotas no pueden atacar al rey si quedan pretorianos vivos.
'*************************************************

    With Npclist(Atacante)

        'Es el Rey Preatoriano?
        If Npclist(Victima).Numero = PRKING_NPC Then
            If pretorianosVivos > 0 Then
                Call WriteConsoleMsg(.MaestroUser, "Debes matar al resto del ejército antes de atacar al rey!", FontTypeNames.FONTTYPE_FIGHT)
                .TargetNPC = 0
                Exit Sub
            End If
        End If

        ' El npc puede atacar ???
        If NpcIntervaloGolpe(Atacante) Then
            If cambiarMOvimiento Then
                Npclist(Victima).TargetNPC = Atacante
                Npclist(Victima).Movement = TipoAI.NpcAtacaNpc
            End If
        Else
            Exit Sub
        End If

        If .flags.Snd1 > 0 Then
            Call SendData(SendTarget.ToNPCArea, Atacante, PrepareMessagePlayWave(.flags.Snd1, .Pos.X, .Pos.Y))
        End If

        If NpcImpactoNpc(Atacante, Victima) Then
            If Npclist(Victima).flags.Snd2 > 0 Then
                Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(Npclist(Victima).flags.Snd2, Npclist(Victima).Pos.X, Npclist(Victima).Pos.Y))
            Else
                Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(SND_IMPACTO2, Npclist(Victima).Pos.X, Npclist(Victima).Pos.Y))
            End If

            If .MaestroUser > 0 Then
                Call SendData(SendTarget.ToNPCArea, Atacante, PrepareMessagePlayWave(SND_IMPACTO, .Pos.X, .Pos.Y))
            Else
                Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(SND_IMPACTO, Npclist(Victima).Pos.X, Npclist(Victima).Pos.Y))
            End If

            Call NpcDañoNpc(Atacante, Victima)
        Else
            If .MaestroUser > 0 Then
                Call SendData(SendTarget.ToNPCArea, Atacante, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
            Else
                Call SendData(SendTarget.ToNPCArea, Victima, PrepareMessagePlayWave(SND_SWING, Npclist(Victima).Pos.X, Npclist(Victima).Pos.Y))
            End If
        End If
    End With
End Sub

Public Function UsuarioAtacaNpc(ByVal UserIndex As Integer, ByVal NpcIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 14/01/2010 (ZaMa)
'12/01/2010: ZaMa - Los druidas pierden la inmunidad de ser atacados por npcs cuando los atacan.
'14/01/2010: ZaMa - Lo transformo en función, para que no se pierdan municiones al atacar targets inválidos.
'***************************************************

    On Error GoTo Errhandler

    If Not PuedeAtacarNPC(UserIndex, NpcIndex) Then Exit Function

    Call NPCAtacado(NpcIndex, UserIndex)

    If UserList(UserIndex).flags.oculto > 0 Then
        If UserList(UserIndex).Clase <> eClass.Hunter And UserList(UserIndex).Clase <> eClass.Thief Then
            UserList(UserIndex).flags.oculto = 0
            Call UsUaRiOs.SetInvisible(UserIndex, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.invisible = 1, UserList(UserIndex).flags.oculto = 1)

            WriteMensajes UserIndex, e_Mensajes.Mensaje_23
        End If
    End If

1   If UserImpactoNpc(UserIndex, NpcIndex) Then
2       If Npclist(NpcIndex).flags.Snd2 > 0 Then
3           Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessagePlayWave(Npclist(NpcIndex).flags.Snd2, Npclist(NpcIndex).Pos.X, Npclist(NpcIndex).Pos.Y))
45      Else
5           Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_IMPACTO2, Npclist(NpcIndex).Pos.X, Npclist(NpcIndex).Pos.Y))
        End If

4       Call UserDañoNpc(UserIndex, NpcIndex)
    Else

        If UserList(UserIndex).flags.oculto = 0 Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_SWING, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
        End If

8       Call WriteMultiMessage(UserIndex, eMessages.UserSwing)
    End If


6   SendData SendTarget.ToPCArea, UserIndex, PrepareMessageMovimientSW(UserList(UserIndex).Char.CharIndex, 1)

    ' Reveló su condición de usuario al atacar, los npcs lo van a atacar
9   UserList(UserIndex).flags.Ignorado = False

    UsuarioAtacaNpc = True

    Exit Function

Errhandler:
    Call LogError("Error en UsuarioAtacaNpc en " & Erl & ". Error " & Err.Number & " : " & Err.Description)

End Function

Public Sub UsuarioAtaca(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Index As Integer
    Dim AttackPos As WorldPos

    'Check bow's interval
    If Not IntervaloPermiteUsarArcos(UserIndex, False) Then Exit Sub

    'Check Spell-Magic interval
    If Not IntervaloPermiteMagiaGolpe(UserIndex) Then
        'Check Attack interval
        If Not IntervaloPermiteAtacar(UserIndex) Then
            Exit Sub
        End If
    End If

    With UserList(UserIndex)
        If Not modAntiCheat.PuedeIntervalo(UserIndex, IntControl.Golpe) Then Exit Sub
        'Quitamos stamina
        Dim minSta As Integer

        minSta = RandomNumber(1, 10)

        If .Invent.WeaponEqpSlot > 0 Then
            If ObjData(.Invent.WeaponEqpObjIndex).QuitaEnergia > 0 Then
                minSta = ObjData(.Invent.WeaponEqpObjIndex).QuitaEnergia
            End If
        End If

        If .Stats.minSta >= minSta Then
            Call QuitarSta(UserIndex, minSta)
        Else
            If .Genero = eGenero.Hombre Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_11
            Else
                WriteMensajes UserIndex, e_Mensajes.Mensaje_11

            End If
            Exit Sub
        End If

        AttackPos = .Pos
        Call HeadtoPos(.Char.Heading, AttackPos)

        'Exit if not legal
        If AttackPos.X < XMinMapSize Or AttackPos.X > XMaxMapSize Or AttackPos.Y <= YMinMapSize Or AttackPos.Y > YMaxMapSize Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
            Exit Sub
        End If

        ' @@ Está el bot?
        Dim Bot_Index As Byte
        Bot_Index = MapData(AttackPos.map, AttackPos.X, AttackPos.Y).BotIndex

        If Bot_Index > 0 Then
            If IA_Bot(Bot_Index).Summoned Then
                Call IA_DamageHit(Bot_Index)
            End If
        End If

        Index = MapData(AttackPos.map, AttackPos.X, AttackPos.Y).UserIndex

        'Look for user
        If Index > 0 Then
            If UserList(Index).flags.UserLogged Then
                Call UsuarioAtacaUsuario(UserIndex, Index)
                Call WriteUpdateUserStats(UserIndex)
                Call WriteUpdateUserStats(Index)
                Exit Sub
            Else
                Debug.Print Now, "UsuarioAtaca: " & UserList(UserIndex).Pos.map & "-" & UserList(UserIndex).Pos.X & "-" & UserList(UserIndex).Pos.Y & " --- Ataca y encontró UI:" & Index & "-" & UserList(Index).IP
            End If
        End If

        Index = MapData(AttackPos.map, AttackPos.X, AttackPos.Y).NpcIndex

        'Look for NPC
        If Index > 0 Then
            If Npclist(Index).Attackable Then
                If Npclist(Index).MaestroUser > 0 And MapInfo(Npclist(Index).Pos.map).pk = False Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_173
                    Exit Sub
                End If

                Call UsuarioAtacaNpc(UserIndex, Index)
            Else
                WriteMensajes UserIndex, e_Mensajes.Mensaje_144

            End If

            Call WriteUpdateUserStats(UserIndex)

            Exit Sub
        End If

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageMovimientSW(UserList(UserIndex).Char.CharIndex, 1))
            Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
        Else
            If UserList(UserIndex).flags.oculto = 0 Then
                SendData SendTarget.ToPCArea, UserIndex, PrepareMessageMovimientSW(UserList(UserIndex).Char.CharIndex, 1)
            End If
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
        End If

        Call WriteUpdateUserStats(UserIndex)

        If .Counters.Trabajando Then .Counters.Trabajando = .Counters.Trabajando - 1

        If .Counters.Ocultando Then .Counters.Ocultando = .Counters.Ocultando - 1
    End With
End Sub

Public Function UsuarioImpacto(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim ProbRechazo As Long
    Dim Rechazo As Boolean
    Dim ProbExito As Long
    Dim PoderAtaque As Long
    Dim UserPoderEvasion As Long
    Dim UserPoderEvasionEscudo As Long
    Dim Arma As Integer
    Dim SkillTacticas As Long
    Dim SkillDefensa As Long
    Dim ProbEvadir As Long
    Dim Skill As eSkill

1   SkillTacticas = UserList(VictimaIndex).Stats.UserSkills(eSkill.Tacticas)
2   SkillDefensa = UserList(VictimaIndex).Stats.UserSkills(eSkill.Defensa)

3   Arma = UserList(AtacanteIndex).Invent.WeaponEqpObjIndex

    'Calculamos el poder de evasion...
    UserPoderEvasion = PoderEvasion(VictimaIndex)

4   If UserList(VictimaIndex).Invent.EscudoEqpObjIndex > 0 Then

        UserPoderEvasionEscudo = PoderEvasionEscudo(VictimaIndex)

        If UserList(AtacanteIndex).Clase = eClass.Assasin Then
            UserPoderEvasionEscudo = (UserPoderEvasionEscudo / 2.5) + 1
        End If


        UserPoderEvasion = UserPoderEvasion + UserPoderEvasionEscudo
    Else
        UserPoderEvasionEscudo = 0
    End If

    'Esta usando un arma ???
5   If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex > 0 Then
6       If ObjData(Arma).proyectil = 1 Then
7           PoderAtaque = PoderAtaqueProyectil(AtacanteIndex)
            Skill = eSkill.proyectiles
        Else
8           PoderAtaque = PoderAtaqueArma(AtacanteIndex)
            Skill = eSkill.Armas
        End If
    Else
9       PoderAtaque = PoderAtaqueWrestling(AtacanteIndex)
10      Skill = eSkill.Wrestling
    End If

    ' Chances are rounded
11  ProbExito = MaximoInt(10, MinimoInt(90, 50 + (PoderAtaque - UserPoderEvasion) * 0.4))

    ' Se reduce la evasion un 25%
12  If UserList(VictimaIndex).flags.Meditando = True Then
13      ProbEvadir = (100 - ProbExito) * 0.75
14      ProbExito = MinimoInt(90, 100 - ProbEvadir)
    End If

15  UsuarioImpacto = (RandomNumber(1, 100) <= ProbExito)

    ' el usuario esta usando un escudo ???
16  If UserList(VictimaIndex).Invent.EscudoEqpObjIndex > 0 Then
        'Fallo ???
17      If Not UsuarioImpacto Then
            ' Chances are rounded

            If (SkillDefensa + SkillTacticas) > 0 Then
18              ProbRechazo = MaximoInt(10, MinimoInt(90, 100 * SkillDefensa / (SkillDefensa + SkillTacticas)))
            End If
19          Rechazo = (RandomNumber(1, 100) <= ProbRechazo)
20
            If Rechazo Then
                'Se rechazo el ataque con el escudo
                SendData SendTarget.ToPCArea, VictimaIndex, PrepareMessageMovimientSW(UserList(VictimaIndex).Char.CharIndex, 2)
21              Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessagePlayWave(SND_ESCUDO, UserList(VictimaIndex).Pos.X, UserList(VictimaIndex).Pos.Y))
                Call WriteMultiMessage(AtacanteIndex, eMessages.BlockedWithShieldother)
                Call WriteMultiMessage(VictimaIndex, eMessages.BlockedWithShieldUser)

22              Call SubirSkill(VictimaIndex, eSkill.Defensa, True)
            Else
23              Call SubirSkill(VictimaIndex, eSkill.Defensa, False)
            End If
        End If
    End If

24  If Not UsuarioImpacto Then
25      Call SubirSkill(AtacanteIndex, Skill, False)
    End If

26  'Call Flushbuffer(VictimaIndex)

    Exit Function

Errhandler:
    Dim AtacanteNick As String
    Dim VictimaNick As String

    If AtacanteIndex > 0 Then AtacanteNick = UserList(AtacanteIndex).Name
    If VictimaIndex > 0 Then VictimaNick = UserList(VictimaIndex).Name

    Call LogError("Error en UsuarioImpacto en " & Erl & ". Error " & Err.Number & " : " & Err.Description & " AtacanteIndex: " & _
                  AtacanteIndex & " Nick: " & AtacanteNick & " VictimaIndex: " & VictimaIndex & " Nick: " & VictimaNick)
End Function

Public Function UsuarioAtacaUsuario(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer) As Boolean

    On Error GoTo UsuarioAtacaUsuario_Err
    Dim sendto As SendTarget

    If Not PuedeAtacar(AtacanteIndex, VictimaIndex) Then Exit Function

    With UserList(AtacanteIndex)
        If distancia(.Pos, UserList(VictimaIndex).Pos) > MAXDISTANCIAARCO Then
            Call WriteMensajes(AtacanteIndex, e_Mensajes.Mensaje_6)
            Exit Function
        End If

        Call UsuarioAtacadoPorUsuario(AtacanteIndex, VictimaIndex)

        If UsuarioImpacto(AtacanteIndex, VictimaIndex) Then
            Call SendData(SendTarget.ToPCArea, AtacanteIndex, PrepareMessagePlayWave(SND_IMPACTO, .Pos.X, .Pos.Y))

            If UserList(VictimaIndex).flags.Navegando = 0 Then
                Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateFX(UserList(VictimaIndex).Char.CharIndex, FXSANGRE, 0))
            End If

            If .Clase = eClass.Thief Then
                Call DoDesequipar(AtacanteIndex, VictimaIndex)
            End If

            Call SubirSkill(VictimaIndex, eSkill.Tacticas, False)
            Call UserDañoUser(AtacanteIndex, VictimaIndex)
        Else
            ' Invisible admins doesn't make sound to other clients except itself

118         If UserList(AtacanteIndex).flags.invisible Or UserList(AtacanteIndex).flags.oculto Or .flags.AdminInvisible = 1 Then
120             sendto = SendTarget.ToIndex
            Else
122             sendto = SendTarget.ToPCArea
            End If

            'If .flags.AdminInvisible = 1 Then
            '    Call EnviarDatosASlot(AtacanteIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
            'Else
            Call SendData(sendto, AtacanteIndex, PrepareMessagePlayWave(SND_SWING, .Pos.X, .Pos.Y))
            'End If

            Call WriteMultiMessage(AtacanteIndex, eMessages.UserSwing)

            If .flags.EnEvento = 3 Then
                WriteConsoleMsg VictimaIndex, "Un jugador ha fallado.", FontTypeNames.FONTTYPE_INFO
            Else
                Call WriteMultiMessage(VictimaIndex, eMessages.UserAttackedSwing, AtacanteIndex)
            End If

            Call SubirSkill(VictimaIndex, eSkill.Tacticas, True)
        End If

        If .Clase = eClass.Thief Then Call Desarmar(AtacanteIndex, VictimaIndex)
    End With

    SendData sendto, AtacanteIndex, PrepareMessageMovimientSW(UserList(AtacanteIndex).Char.CharIndex, 1)
    UsuarioAtacaUsuario = True

    Exit Function
UsuarioAtacaUsuario_Err:
126 Call LogError("SistemaCombate.UsuarioAtacaUsuario en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Public Sub UserDañoUser(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010 (ZaMa)
'12/01/2010: ZaMa - Implemento armas arrojadizas y probabilidad de acuchillar
'***************************************************

    On Error GoTo Errhandler

    Dim Daño As Long
    Dim Lugar As Integer
    Dim absorbido As Long
    Dim defbarco As Integer
    Dim Obj As ObjData

    Dim BoatDefense As Integer
    Dim BodyDefense As Integer
    Dim HeadDefense As Integer
    Dim WeaponBoost As Integer

    Dim BoatIndex As Integer
    Dim WeaponIndex As Integer
    Dim HelmetIndex As Integer
    Dim ArmourIndex As Integer
    Dim ShieldIndex As Integer

1   Daño = CalcularDaño(AtacanteIndex)

2   Call UserEnvenena(AtacanteIndex, VictimaIndex)

3   With UserList(AtacanteIndex)

4       If .flags.Navegando = 1 Then
            BoatIndex = .Invent.BarcoObjIndex
            If BoatIndex > 0 Then
                Obj = ObjData(BoatIndex)
                Daño = Daño + RandomNumber(Obj.MinHIT, Obj.MaxHIT)
            End If
7       End If

8       If UserList(VictimaIndex).flags.Navegando = 1 Then
            BoatIndex = UserList(VictimaIndex).Invent.BarcoObjIndex
            If BoatIndex > 0 Then
                Obj = ObjData(BoatIndex)
                BoatDefense = RandomNumber(Obj.MinDef, Obj.MaxDef)
            End If
        End If

        WeaponIndex = .Invent.WeaponEqpObjIndex
        If WeaponIndex > 0 Then
            WeaponBoost = ObjData(WeaponIndex).Refuerzo
        End If

13      Lugar = RandomNumber(PartesCuerpo.bCabeza, PartesCuerpo.bTorso)

14      Select Case Lugar
        Case PartesCuerpo.bCabeza
            'Si tiene casco absorbe el golpe
            HelmetIndex = UserList(VictimaIndex).Invent.CascoEqpObjIndex
            If HelmetIndex > 0 Then
                Obj = ObjData(HelmetIndex)
                HeadDefense = RandomNumber(Obj.MinDef, Obj.MaxDef)
            End If
        Case Else
            Dim MinDef As Integer
            Dim MaxDef As Integer

            'Si tiene armadura absorbe el golpe
            ArmourIndex = UserList(VictimaIndex).Invent.ArmourEqpObjIndex
            If ArmourIndex > 0 Then
                Obj = ObjData(ArmourIndex)
                MinDef = Obj.MinDef
                MaxDef = Obj.MaxDef
            End If

            ' Si tiene escudo, tambien absorbe el golpe
            ShieldIndex = UserList(VictimaIndex).Invent.EscudoEqpObjIndex
            If ShieldIndex > 0 Then
                Obj = ObjData(ShieldIndex)
                MinDef = MinDef + Obj.MinDef
                MaxDef = MaxDef + Obj.MaxDef
            End If

            BodyDefense = RandomNumber(MinDef, MaxDef)

        End Select

        Daño = Daño + WeaponBoost - HeadDefense - BodyDefense - BoatDefense

        If Daño < 0 Then Daño = 1

40      If .flags.EnEvento = 3 Then
41          WriteConsoleMsg AtacanteIndex, "Le has quitado a participante " & CStr(Daño) & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT
42          WriteConsoleMsg VictimaIndex, "Un participante te ha golpeado y te ha quitado " & CStr(Daño) & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT
        Else
43          Call WriteMultiMessage(AtacanteIndex, eMessages.UserHittedUser, UserList(VictimaIndex).Char.CharIndex, Lugar, Daño)
44          Call WriteMultiMessage(VictimaIndex, eMessages.UserHittedByUser, .Char.CharIndex, Lugar, Daño)
        End If

45      UserList(VictimaIndex).Stats.MinHP = UserList(VictimaIndex).Stats.MinHP - Daño

46      Call SubirSkill(VictimaIndex, Tacticas, True)

47      If .flags.Hambre = 0 And .flags.Sed = 0 Then
            'Si usa un arma quizas suba "Combate con armas"
48          If .Invent.WeaponEqpObjIndex > 0 Then
49              If ObjData(.Invent.WeaponEqpObjIndex).proyectil Then
                    'es un Arco. Sube Armas a Distancia
50                  Call SubirSkill(AtacanteIndex, eSkill.proyectiles, True)

                    ' Si es arma arrojadiza..
                    If ObjData(.Invent.WeaponEqpObjIndex).Municion = 0 Then
                        ' Si acuchilla
51                      If ObjData(.Invent.WeaponEqpObjIndex).Acuchilla = 1 Then
52                          Call DoAcuchillar(AtacanteIndex, 0, VictimaIndex, Daño)
                        End If
                    End If
                Else
                    'Sube combate con armas.
53                  Call SubirSkill(AtacanteIndex, eSkill.Armas, True)
                End If
            Else
                'sino tal vez lucha libre
54              Call SubirSkill(AtacanteIndex, eSkill.Wrestling, True)
            End If

            Dim Apuñalo As Boolean

            'Trata de apuñalar por la espalda al enemigo
55          If PuedeApuñalar(AtacanteIndex) Then
56              Call DoApuñalar(AtacanteIndex, 0, VictimaIndex, Daño, Apuñalo, Lugar)
            Else
57              Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateDamage(UserList(VictimaIndex).Char.CharIndex, Daño, 255, 0, 0))
            End If

        End If

58      If Not Apuñalo Then
59          Call SendData(SendTarget.ToPCArea, VictimaIndex, PrepareMessageCreateDamage(UserList(VictimaIndex).Char.CharIndex, Daño, 255, 0, 0))
        End If

60      If UserList(VictimaIndex).Stats.MinHP <= 0 Then

            'Store it!
61          Call Statistics.StoreFrag(AtacanteIndex, VictimaIndex)

62          Call ContarMuerte(VictimaIndex, AtacanteIndex)

            ' Para que las mascotas no sigan intentando luchar y
            ' comiencen a seguir al amo
            Dim j As Long
63          For j = 1 To MAXMASCOTAS
                If UserList(AtacanteIndex).MascotasIndex(j) > 0 Then
                    If Npclist(UserList(AtacanteIndex).MascotasIndex(j)).Target = VictimaIndex Then Npclist(UserList(AtacanteIndex).MascotasIndex(j)).Target = 0
                    Call FollowAmo(UserList(AtacanteIndex).MascotasIndex(j))
                End If
            Next j

64          Call ActStats(VictimaIndex, AtacanteIndex)
65          Call UserDie(VictimaIndex, Not EsGM(VictimaIndex))
        Else
            'Está vivo - Actualizamos el HP
66          Call WriteUpdateHP(VictimaIndex)
        End If
    End With

    'Controla el nivel del usuario
67  Call CheckUserLevel(AtacanteIndex)

    'Call Flushbuffer(VictimaIndex)

    Exit Sub

Errhandler:
    Dim AtacanteNick As String
    Dim VictimaNick As String

    If AtacanteIndex > 0 Then AtacanteNick = UserList(AtacanteIndex).Name
    If VictimaIndex > 0 Then VictimaNick = UserList(VictimaIndex).Name

    Call LogError("Error en UserDañoUser en " & Erl & ". Error " & Err.Number & " : " & Err.Description & " AtacanteIndex: " & _
                  AtacanteIndex & " Nick: " & AtacanteNick & " VictimaIndex: " & VictimaIndex & " Nick: " & VictimaNick)
End Sub

Sub UsuarioAtacadoPorUsuario(ByVal attackerIndex As Integer, ByVal VictimIndex As Integer)
'***************************************************
'Autor: Unknown
'Last Modification: 05/05/2010
'Last Modified By: Lucas Tavolaro Ortiz (Tavo)
'10/01/2008: Tavo - Se cancela la salida del juego si el user esta saliendo
'***************************************************

    If TriggerZonaPelea(attackerIndex, VictimIndex) = TRIGGER6_PERMITE Then Exit Sub

    Dim EraCriminal As Boolean

    If Not criminal(attackerIndex) Then
        If Not criminal(VictimIndex) Then
            Call VolverCriminal(attackerIndex)
        End If
    End If

    With UserList(VictimIndex)
        If .flags.Meditando Then
            .flags.Meditando = False
            Call WriteMeditateToggle(VictimIndex)
            WriteMensajes VictimIndex, e_Mensajes.Mensaje_216

            .Char.FX = 0
            .Char.loops = 0
            Call SendData(SendTarget.ToPCArea, VictimIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
        End If

        If .flags.MenuCliente <> eVentanas.vInventario Then
            .Counters.TickReactionInv = GetTickCount()
        End If

    End With

    EraCriminal = criminal(attackerIndex)

    With UserList(attackerIndex).Reputacion
        If Not criminal(VictimIndex) Then
            .BandidoRep = .BandidoRep + vlASALTO
            If .BandidoRep > MAXREP Then .BandidoRep = MAXREP

            .NobleRep = .NobleRep * 0.5
            If .NobleRep < 0 Then .NobleRep = 0
        Else
            .NobleRep = .NobleRep + vlNoble
            If .NobleRep > MAXREP Then .NobleRep = MAXREP
        End If
    End With

    If criminal(attackerIndex) Then
        If UserList(attackerIndex).faccion.ArmadaReal = 1 Then Call ExpulsarFaccionReal(attackerIndex)

        If Not EraCriminal Then Call RefreshCharStatus(attackerIndex)
    ElseIf EraCriminal Then
        Call RefreshCharStatus(attackerIndex)
    End If

    Call AllMascotasAtacanUser(attackerIndex, VictimIndex)
    Call AllMascotasAtacanUser(VictimIndex, attackerIndex)

    'Si la victima esta saliendo se cancela la salida
    Call CancelExit(VictimIndex)
    'Call Flushbuffer(victimIndex)
End Sub

Sub AllMascotasAtacanUser(ByVal victim As Integer, ByVal Maestro As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'f
'***************************************************
'Reaccion de las mascotas
    Dim iCount As Long

    For iCount = 1 To MAXMASCOTAS
        If UserList(Maestro).MascotasIndex(iCount) > 0 Then
            Npclist(UserList(Maestro).MascotasIndex(iCount)).Target = victim    'UserList(victim).ID
            Npclist(UserList(Maestro).MascotasIndex(iCount)).Movement = TipoAI.NPCDEFENSA
            Npclist(UserList(Maestro).MascotasIndex(iCount)).Hostile = 1
            Npclist(UserList(Maestro).MascotasIndex(iCount)).flags.AttackedBy = UserList(victim).Name

        End If
    Next iCount
End Sub

Public Function PuedeAtacar(ByVal attackerIndex As Integer, ByVal VictimIndex As Integer) As Boolean
'***************************************************
'Autor: Unknown
'Last Modification: 02/04/2010
'Returns true if the AttackerIndex is allowed to attack the VictimIndex.
'24/01/2007 Pablo (ToxicWaste) - Ordeno todo y agrego situacion de Defensa en ciudad Armada y Caos.
'24/02/2009: ZaMa - Los usuarios pueden atacarse entre si.
'02/04/2010: ZaMa - Los armadas no pueden atacar nunca a los ciudas, salvo que esten atacables.
'***************************************************
    On Error GoTo Errhandler

    'MUY importante el orden de estos "IF"...

    'Estas muerto no podes atacar
    If UserList(attackerIndex).flags.Muerto = 1 Then
        Call WriteMensajes(attackerIndex, e_Mensajes.Mensaje_3)
        PuedeAtacar = False
        Exit Function
    End If

    'No podes atacar a alguien muerto
    If UserList(VictimIndex).flags.Muerto = 1 Then
        WriteMensajes attackerIndex, e_Mensajes.Mensaje_175
        PuedeAtacar = False
        Exit Function
    End If


    If UserList(attackerIndex).flags.EnEvento = 3 Then
        If DeathMatch.EventStarted = False Then
            Call WriteConsoleMsg(attackerIndex, NOMBRE_TORNEO_ACTUAL & "¡¡Debes esperar la cuenta regresiva!!", FontTypeNames.FONTTYPE_INFO)
            PuedeAtacar = False
            Exit Function
        End If
        PuedeAtacar = True: Exit Function
    End If
    If UserList(attackerIndex).flags.EnEvento = 1 Then
        Dim valido As Boolean
        If iTorneo1vs1.Peleando(1) = UserList(attackerIndex).Name Then
            valido = True
        End If
        If iTorneo1vs1.Peleando(2) = UserList(attackerIndex).Name Then
            valido = True
        End If
        If Not valido Then
            Call WriteConsoleMsg(attackerIndex, NOMBRE_TORNEO_ACTUAL & "No podes atacar si no estás en la arena, espera tu turno.", FontTypeNames.FONTTYPE_INFO)
            PuedeAtacar = False
            Exit Function
        End If
    ElseIf UserList(attackerIndex).flags.EnEvento = 2 Then
        '2vs2
        ' puedo atacar a mi pana?
    End If

    If BlockEventAttack(VictimIndex) Then
        Call WriteConsoleMsg(attackerIndex, "No puedes atacar antes del conteo.", FontTypeNames.FONTTYPE_FIGHT)
        PuedeAtacar = False
        Exit Function
    End If
    If UserList(VictimIndex).mReto.Reto_Index > 0 Then
        If RetoList(UserList(VictimIndex).mReto.Reto_Index).count_Down > 0 Then
            PuedeAtacar = False
            Exit Function
        End If
    End If

    ' No podes atacar si estas en consulta
    If UserList(attackerIndex).flags.EnConsulta Then
        Call WriteConsoleMsg(attackerIndex, "No puedes atacar usuarios mientras estas en consulta.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    ' No podes atacar si esta en consulta
    If UserList(VictimIndex).flags.EnConsulta Then
        Call WriteConsoleMsg(attackerIndex, "No puedes atacar usuarios mientras estan en consulta.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    If UserList(attackerIndex).mReto.Reto_Index > 0 Then
        If m_Retos1vs1.CheckAttackPlayer(UserList(attackerIndex).mReto.Reto_Index) = False Then
            Call WriteConsoleMsg(attackerIndex, "No puedes atacar aún!!", FontTypeNames.FONTTYPE_FIGHT)
            PuedeAtacar = False
            Exit Function
        End If
    End If

    'Estamos en una Arena? o un trigger zona segura?
    Select Case TriggerZonaPelea(attackerIndex, VictimIndex)
    Case eTrigger6.TRIGGER6_PERMITE
        PuedeAtacar = (UserList(VictimIndex).flags.AdminInvisible = 0)
        Exit Function

    Case eTrigger6.TRIGGER6_PROHIBE
        PuedeAtacar = False
        Exit Function

    Case eTrigger6.TRIGGER6_AUSENTE
        'Si no estamos en el Trigger 6 entonces es imposible atacar un gm
        If EsGM(VictimIndex) And Not EsGM(attackerIndex) Then
            If UserList(VictimIndex).flags.AdminInvisible = 0 Then WriteMensajes attackerIndex, e_Mensajes.Mensaje_181
            PuedeAtacar = False
            Exit Function
        End If
    End Select

    'Ataca un ciudadano?
    If Not criminal(VictimIndex) Then
        ' El atacante es ciuda?
        If Not criminal(attackerIndex) Then
            ' El atacante es armada?
            If EsArmada(attackerIndex) Then
                ' La victima es armada?
                If EsArmada(VictimIndex) Then
                    ' No puede
                    WriteMensajes attackerIndex, e_Mensajes.Mensaje_178
                    Exit Function
                End If
            End If
        End If
        ' Ataca a un criminal
    Else
        'Sos un Caos atacando otro caos?
        If EsCaos(VictimIndex) Then
            If EsCaos(attackerIndex) Then
                WriteMensajes attackerIndex, e_Mensajes.Mensaje_180
                Exit Function
            End If
        End If
    End If

    'Tenes puesto el seguro?
    If UserList(attackerIndex).flags.Seguro Then
        If Not criminal(VictimIndex) Then
            WriteMensajes attackerIndex, e_Mensajes.Mensaje_12
            PuedeAtacar = False
            Exit Function
        End If
    Else

        ' Un ciuda es atacado
        If Not criminal(VictimIndex) Then
            ' Por un armada sin seguro
            If EsArmada(attackerIndex) Then
                ' No puede
                WriteMensajes attackerIndex, e_Mensajes.Mensaje_178
                PuedeAtacar = False
                Exit Function
            End If
        End If
    End If

    'Estas en un Mapa Seguro?
    If MapInfo(UserList(VictimIndex).Pos.map).pk = False Then
        If EsArmada(attackerIndex) Then
            If UserList(attackerIndex).faccion.RecompensasReal > 11 Then
                If UserList(VictimIndex).Pos.map = 58 Or UserList(VictimIndex).Pos.map = 59 Or UserList(VictimIndex).Pos.map = 60 Then
                    Call WriteConsoleMsg(VictimIndex, "¡Huye de la ciudad! Estás siendo atacado y no podrás defenderte.", FontTypeNames.FONTTYPE_WARNING)
                    PuedeAtacar = True        'Beneficio de Armadas que atacan en su ciudad.
                    Exit Function
                End If
            End If
        End If
        If EsCaos(attackerIndex) Then
            If UserList(attackerIndex).faccion.RecompensasCaos > 11 Then
                If UserList(VictimIndex).Pos.map = 151 Or UserList(VictimIndex).Pos.map = 156 Then
                    Call WriteConsoleMsg(VictimIndex, "¡Huye de la ciudad! Estás siendo atacado y no podrás defenderte.", FontTypeNames.FONTTYPE_WARNING)
                    PuedeAtacar = True        'Beneficio de Caos que atacan en su ciudad.
                    Exit Function
                End If
            End If
        End If
        WriteMensajes attackerIndex, e_Mensajes.Mensaje_176
        PuedeAtacar = False
        Exit Function
    End If

    'Estas atacando desde un trigger seguro? o tu victima esta en uno asi?
    If MapData(UserList(VictimIndex).Pos.map, UserList(VictimIndex).Pos.X, UserList(VictimIndex).Pos.Y).trigger = eTrigger.ZONASEGURA Or _
       MapData(UserList(attackerIndex).Pos.map, UserList(attackerIndex).Pos.X, UserList(attackerIndex).Pos.Y).trigger = eTrigger.ZONASEGURA Then
        WriteMensajes attackerIndex, e_Mensajes.Mensaje_177
        PuedeAtacar = False
        Exit Function
    End If

    PuedeAtacar = True
    Exit Function

Errhandler:
    Call LogError("Error en PuedeAtacar. Error " & Err.Number & " : " & Err.Description)
End Function

Public Function PuedeAtacarNPC(ByVal attackerIndex As Integer, ByVal NpcIndex As Integer, Optional ByVal Paraliza As Boolean = False, Optional ByVal IsPet As Boolean = False) As Boolean

    Dim OwnerUserIndex As Integer

    'Sos consejero?
    If UserList(attackerIndex).flags.Privilegios = PlayerType.Consejero Then
        Call WriteConsoleMsg(attackerIndex, "No pueden atacar NPC los Consejeros.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    ' No podes atacar si estas en consulta
    If UserList(attackerIndex).flags.EnConsulta Then
        Call WriteConsoleMsg(attackerIndex, "No puedes atacar npcs mientras estas en consulta.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    'Es una criatura atacable?
    If Npclist(NpcIndex).Attackable = 0 Then
        WriteMensajes attackerIndex, e_Mensajes.Mensaje_144
        Exit Function
    End If

    'Es valida la distancia a la cual estamos atacando?
    If distancia(UserList(attackerIndex).Pos, Npclist(NpcIndex).Pos) >= MAXDISTANCIAARCO Then
        Call WriteMensajes(attackerIndex, e_Mensajes.Mensaje_6)
        Exit Function
    End If

    'Estas en modo Combate?
    If Not UserList(attackerIndex).flags.ModoCombate Then
        Call WriteConsoleMsg(attackerIndex, "Debes estar en modo de combate poder atacar al NPC.", FontTypeNames.FONTTYPE_INFO)
        Exit Function
    End If

    If UserList(attackerIndex).flags.Muerto = 1 Then
        Call WriteMensajes(attackerIndex, e_Mensajes.Mensaje_3)
        Exit Function
    End If

    'Es una criatura No-Hostil?
    If Npclist(NpcIndex).Hostile = 0 Then
        'Es Guardia del Caos?
        If Npclist(NpcIndex).NPCtype = eNPCType.Guardiascaos Then
            'Lo quiere atacar un caos?
            If EsCaos(attackerIndex) Then
                Call WriteConsoleMsg(attackerIndex, "No puedes atacar Guardias del Caos siendo de la legión oscura.", FontTypeNames.FONTTYPE_INFO)
                Exit Function
            End If
            'Es guardia Real?
        ElseIf Npclist(NpcIndex).NPCtype = eNPCType.GuardiaReal Then
            'Lo quiere atacar un Armada?
            If EsArmada(attackerIndex) Then
                Call WriteConsoleMsg(attackerIndex, "No puedes atacar Guardias Reales siendo del ejército real.", FontTypeNames.FONTTYPE_INFO)
                Exit Function
            End If
            'Tienes el seguro puesto?
            If UserList(attackerIndex).flags.Seguro Then
                Call WriteConsoleMsg(attackerIndex, "Para poder atacar Guardias Reales debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                Exit Function
            Else
                Call WriteConsoleMsg(attackerIndex, "¡Atacaste un Guardia Real! Eres un criminal.", FontTypeNames.FONTTYPE_INFO)
                Call VolverCriminal(attackerIndex)
                PuedeAtacarNPC = True
                Exit Function
            End If

            'No era un Guardia, asi que es una criatura No-Hostil común.
            'Para asegurarnos que no sea una Mascota:
        ElseIf Npclist(NpcIndex).MaestroUser = 0 Then
            'Si sos ciudadano tenes que quitar el seguro para atacarla.
            If Not criminal(attackerIndex) Then

                ' Si sos armada no podes atacarlo directamente
                If EsArmada(attackerIndex) Then
                    Call WriteConsoleMsg(attackerIndex, "Los miembros del ejército real no pueden atacar npcs no hostiles.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If

                'Sos ciudadano, tenes el seguro puesto?
                If UserList(attackerIndex).flags.Seguro Then
                    Call WriteConsoleMsg(attackerIndex, "Para atacar a este NPC debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                Else
                    'No tiene seguro puesto. Puede atacar pero es penalizado.
                    Call WriteConsoleMsg(attackerIndex, "Atacaste un NPC no-hostil. Continúa haciéndolo y te podrás convertir en criminal.", FontTypeNames.FONTTYPE_INFO)
                    'NicoNZ: Cambio para que al atacar npcs no hostiles no bajen puntos de nobleza
                    Call DisNobAuBan(attackerIndex, 0, 1000)
                    PuedeAtacarNPC = True
                    Exit Function
                End If
            End If
        End If
    End If

    'Es el NPC mascota de alguien?
    If Npclist(NpcIndex).MaestroUser > 0 Then

        If MapInfo(UserList(attackerIndex).Pos.map).pk = False Then
            Call WriteConsoleMsg(attackerIndex, "No puedes atacar mascotas en zonas seguras.")
            Exit Function
        End If

        If Not criminal(Npclist(NpcIndex).MaestroUser) Then

            'Es mascota de un Ciudadano.
            If EsArmada(attackerIndex) Then
                'El atacante es Armada y esta intentando atacar mascota de un Ciudadano
                WriteMensajes attackerIndex, e_Mensajes.Mensaje_178
                Exit Function
            End If

            If Not criminal(attackerIndex) Then

                'El atacante es Ciudadano y esta intentando atacar mascota de un Ciudadano.
                If UserList(attackerIndex).flags.Seguro Then
                    'El atacante tiene el seguro puesto. No puede atacar.
                    Call WriteConsoleMsg(attackerIndex, "Para atacar mascotas de ciudadanos debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                Else
                    'El atacante no tiene el seguro puesto. Recibe penalización.
                    Call WriteConsoleMsg(attackerIndex, "Has atacado la Mascota de un ciudadano. Eres un criminal.", FontTypeNames.FONTTYPE_INFO)
                    Call VolverCriminal(attackerIndex)
                    PuedeAtacarNPC = True
                    Exit Function
                End If
            Else
                'El atacante es criminal y quiere atacar un elemental ciuda, pero tiene el seguro puesto (NicoNZ)
                If UserList(attackerIndex).flags.Seguro Then
                    Call WriteConsoleMsg(attackerIndex, "Para atacar mascotas de ciudadanos debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If
            End If
        Else
            'Es mascota de un Criminal.
            If EsCaos(Npclist(NpcIndex).MaestroUser) Then
                'Es Caos el Dueño.
                If EsCaos(attackerIndex) Then
                    'Un Caos intenta atacar una criatura de un Caos. No puede atacar.
                    Call WriteConsoleMsg(attackerIndex, "Los miembros de la legión oscura no pueden atacar mascotas de otros legionarios. ", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If
            End If
        End If
    End If

    With Npclist(NpcIndex)
        ' El npc le pertenece a alguien?
        OwnerUserIndex = .Owner

        If OwnerUserIndex > 0 Then

            ' Puede atacar a su propia criatura!
            If OwnerUserIndex = attackerIndex Then
                PuedeAtacarNPC = True
                Call IntervaloPerdioNpc(OwnerUserIndex, True)        ' Renuevo el timer
                Exit Function
            End If

            ' Esta compartiendo el npc con el atacante? => Puede atacar!
            If UserList(OwnerUserIndex).flags.ShareNpcWith = attackerIndex Then
                PuedeAtacarNPC = True
                Exit Function
            End If

            ' Si son del mismo clan o party, pueden atacar (No renueva el timer)
            If Not SameClan(OwnerUserIndex, attackerIndex) And Not SameParty(OwnerUserIndex, attackerIndex) Then

                ' Si se le agoto el tiempo
                If IntervaloPerdioNpc(OwnerUserIndex) Then        ' Se lo roba :P
                    Call PerdioNpc(OwnerUserIndex)
                    Call ApropioNpc(attackerIndex, NpcIndex)
                    PuedeAtacarNPC = True
                    Exit Function

                    ' Si lanzo un hechizo de para o inmo
                ElseIf Paraliza Then

                    ' Si ya esta paralizado o inmobilizado, no puedo inmobilizarlo de nuevo
                    If .flags.Inmovilizado = 1 Or .flags.Paralizado = 1 Then

                        'TODO_ZAMA: Si dejo esto asi, los pks con seguro peusto van a poder inmobilizar criaturas con dueño
                        ' Si es pk neutral, puede hacer lo que quiera :P.
                        If Not criminal(attackerIndex) And Not criminal(OwnerUserIndex) Then

                            'El atacante es Armada
                            If EsArmada(attackerIndex) Then

                                'Intententa paralizar un npc de un armada?
                                If EsArmada(OwnerUserIndex) Then
                                    'El atacante es Armada y esta intentando paralizar un npc de un armada: No puede
                                    Call WriteConsoleMsg(attackerIndex, "Los miembros del Ejército Real no pueden paralizar criaturas ya paralizadas pertenecientes a otros miembros del Ejército Real", FontTypeNames.FONTTYPE_INFO)
                                    Exit Function

                                    'El atacante es Armada y esta intentando paralizar un npc de un ciuda
                                Else
                                    Call WriteConsoleMsg(attackerIndex, "No puedes paralizar criaturas ya paralizadas pertenecientes a un ciudadano.", FontTypeNames.FONTTYPE_INFO)
                                    Exit Function
                                End If

                                ' El atacante es ciuda
                            Else
                                'El atacante tiene el seguro puesto, no puede paralizar
                                If UserList(attackerIndex).flags.Seguro Then
                                    Call WriteConsoleMsg(attackerIndex, "Para paralizar criaturas ya paralizadas pertenecientes a ciudadanos debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                                    Exit Function

                                    'El atacante no tiene el seguro puesto, ataca.
                                Else
                                    Call WriteConsoleMsg(attackerIndex, "Has paralizado la criatura de un ciudadano, te has vuelto criminal.", FontTypeNames.FONTTYPE_INFO)
                                    Call VolverCriminal(attackerIndex)
                                    PuedeAtacarNPC = True

                                    Exit Function
                                End If
                            End If

                            ' Al menos uno de los dos es criminal
                        Else
                            ' Si ambos son caos
                            If EsCaos(attackerIndex) And EsCaos(OwnerUserIndex) Then
                                'El atacante es Caos y esta intentando paralizar un npc de un Caos
                                Call WriteConsoleMsg(attackerIndex, "Los miembros de la legión oscura no pueden paralizar criaturas ya paralizadas por otros legionarios.", FontTypeNames.FONTTYPE_INFO)
                                Exit Function
                            End If
                        End If

                        ' El npc no esta inmobilizado ni paralizado
                    Else
                        ' Si no tiene dueño, puede apropiarselo
                        If OwnerUserIndex = 0 Then
                            ' Siempre que no posea uno ya (el inmo/para no cambia pertenencia de npcs).
                            If UserList(attackerIndex).flags.OwnedNpc = 0 Then
                                Call ApropioNpc(attackerIndex, NpcIndex)
                            End If
                        End If

                        ' Siempre se pueden paralizar/inmobilizar npcs con o sin dueño
                        ' que no tengan ese estado
                        PuedeAtacarNPC = True
                        Exit Function

                    End If

                    ' No lanzó hechizos inmobilizantes
                Else

                    ' El npc le pertenece a un ciudadano
                    If Not criminal(OwnerUserIndex) Then

                        'El atacante es Armada y esta intentando atacar un npc de un Ciudadano
                        If EsArmada(attackerIndex) Then

                            'Intententa atacar un npc de un armada?
                            If EsArmada(OwnerUserIndex) Then
                                'El atacante es Armada y esta intentando atacar el npc de un armada: No puede
                                Call WriteConsoleMsg(attackerIndex, "Los miembros del Ejército Real no pueden atacar criaturas pertenecientes a otros miembros del Ejército Real", FontTypeNames.FONTTYPE_INFO)
                                Exit Function

                                'El atacante es Armada y esta intentando atacar un npc de un ciuda
                            Else

                                ' Si tiene seguro no puede
                                If UserList(attackerIndex).flags.Seguro Then
                                    WriteMensajes attackerIndex, e_Mensajes.Mensaje_379

                                    Exit Function
                                Else
                                    Call WriteConsoleMsg(attackerIndex, "Has atacado a la criatura de un ciudadano, te has vuelto criminal.", FontTypeNames.FONTTYPE_INFO)
                                    PuedeAtacarNPC = True
                                    Exit Function
                                End If
                            End If

                            ' No es aramda, puede ser criminal o ciuda
                        Else

                            'El atacante es Ciudadano y esta intentando atacar un npc de un Ciudadano.
                            If Not criminal(attackerIndex) Then

                                If UserList(attackerIndex).flags.Seguro Then
                                    'El atacante tiene el seguro puesto. No puede atacar.
                                    Call WriteConsoleMsg(attackerIndex, "Para atacar criaturas pertenecientes a ciudadanos debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                                    Exit Function

                                    'El atacante no tiene el seguro puesto, ataca.
                                Else
                                    Call WriteConsoleMsg(attackerIndex, "Has atacado a la criatura de un ciudadano, te has vuelto criminal.", FontTypeNames.FONTTYPE_INFO)
                                    PuedeAtacarNPC = True
                                    Call VolverCriminal(attackerIndex)
                                    Exit Function
                                End If

                                'El atacante es criminal y esta intentando atacar un npc de un Ciudadano.
                            Else
                                ' Es criminal atacando un npc de un ciuda, con seguro puesto.
                                If UserList(attackerIndex).flags.Seguro Then
                                    Call WriteConsoleMsg(attackerIndex, "Para atacar criaturas pertenecientes a ciudadanos debes quitarte el seguro.", FontTypeNames.FONTTYPE_INFO)
                                    Exit Function
                                End If

                                PuedeAtacarNPC = True
                            End If
                        End If

                        ' Es npc de un criminal
                    Else
                        If EsCaos(OwnerUserIndex) Then
                            'Es Caos el Dueño.
                            If EsCaos(attackerIndex) Then
                                'Un Caos intenta atacar una npc de un Caos. No puede atacar.
                                Call WriteConsoleMsg(attackerIndex, "Los miembros de la Legión Oscura no pueden atacar criaturas de otros legionarios. ", FontTypeNames.FONTTYPE_INFO)
                                Exit Function
                            End If
                        End If
                    End If
                End If
            End If

            ' Si no tiene dueño el npc, se lo apropia
        Else
            ' Solo pueden apropiarse de npcs los caos, armadas o ciudas.
            If Not criminal(attackerIndex) Or EsCaos(attackerIndex) Then
                ' No puede apropiarse de los !
                If Not (esPretoriano(NpcIndex) <> 0) Then
                    ' Si es una mascota atacando, no se apropia del npc
                    If Not IsPet Then
                        ' No es dueño de ningun npc => Se lo apropia.
                        If UserList(attackerIndex).flags.OwnedNpc = 0 Then
                            Call ApropioNpc(attackerIndex, NpcIndex)
                            ' Es dueño de un npc, pero no puede ser de este porque no tiene propietario.
                        Else
                            ' Se va a adueñar del npc (y perder el otro) solo si no inmobiliza/paraliza
                            If Not Paraliza Then Call ApropioNpc(attackerIndex, NpcIndex)
                        End If
                    End If
                End If
            End If
        End If
    End With

    'Es el Rey Preatoriano?
    If esPretoriano(NpcIndex) = 4 Then
        If pretorianosVivos > 0 Then
            Call WriteConsoleMsg(attackerIndex, "Debes matar al resto del ejército antes de atacar al rey.", FontTypeNames.FONTTYPE_FIGHT)
            Exit Function
        End If
    End If

    PuedeAtacarNPC = True
End Function

Private Function SameClan(ByVal UserIndex As Integer, ByVal OtherUserIndex As Integer) As Boolean
    SameClan = (UserList(UserIndex).guildIndex = UserList(OtherUserIndex).guildIndex) And UserList(UserIndex).guildIndex <> 0
End Function

Private Function SameParty(ByVal UserIndex As Integer, ByVal OtherUserIndex As Integer) As Boolean
    SameParty = UserList(UserIndex).PartyIndex = UserList(OtherUserIndex).PartyIndex And UserList(UserIndex).PartyIndex <> 0
End Function

Sub CalcularDarExp(ByVal UserIndex As Integer, ByVal NpcIndex As Integer, ByVal ElDaño As Long)

    On Error GoTo Errhandler

    Dim ExpADar As Long

    If ElDaño <= 0 Then ElDaño = 0
1   If Npclist(NpcIndex).Stats.MaxHP <= 0 Then Exit Sub
2   If ElDaño > Npclist(NpcIndex).Stats.MinHP Then ElDaño = Npclist(NpcIndex).Stats.MinHP
3   ExpADar = CLng(ElDaño * (Npclist(NpcIndex).GiveEXP / Npclist(NpcIndex).Stats.MaxHP))
4   If ExpADar <= 0 Then Exit Sub


5   If ExpADar > Npclist(NpcIndex).flags.ExpCount Then
6       ExpADar = Npclist(NpcIndex).flags.ExpCount
7       Npclist(NpcIndex).flags.ExpCount = 0
    Else
8       Npclist(NpcIndex).flags.ExpCount = Npclist(NpcIndex).flags.ExpCount - ExpADar
    End If

    'ExpaDar = ExpaDar * ExpMulti

9   If ExpADar > 0 Then

10      If UserIndex > 0 Then

            If FUN = 1 Then
                If UserList(UserIndex).Stats.ELV < 40 Then
                    ExpADar = ExpADar + Int(ExpADar * FUN_Rates(eRate.cExp) * 2)
                ElseIf UserList(UserIndex).Stats.ELV < 40 Then
                    ExpADar = ExpADar + Int(ExpADar * FUN_Rates(eRate.cExp))
                Else
                    ExpADar = ExpADar + Int((ExpADar * FUN_Rates(eRate.cExp)) / 3)
                End If
            End If

12          If UserList(UserIndex).PartyIndex > 0 Then
                '11              Call mod_Party.GetSuccess(UserList(userindex).PartyIndex, ExpADar, UserList(userindex).Pos.map, False)
11              Call mod_Party.ObtenerExito(UserIndex, ExpADar, Npclist(NpcIndex).Pos.map, Npclist(NpcIndex).Pos.X, Npclist(NpcIndex).Pos.Y)
13          Else
1441            'Call mod_EXPBonus.CalcularExpExtra(userindex, npcIndex, ElDaño, ExpADar)
                UserList(UserIndex).Stats.Exp = UserList(UserIndex).Stats.Exp + ExpADar
14              If UserList(UserIndex).Stats.Exp > MAXEXP Then UserList(UserIndex).Stats.Exp = MAXEXP
15              Call WriteMultiMessage(UserIndex, eMessages.EarnExp, ExpADar)
16              Call CheckUserLevel(UserIndex)
            End If
        End If
    End If

    Exit Sub
Errhandler:
    Call LogError("error en calculardareexp en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Function TriggerZonaPelea(ByVal Origen As Integer, ByVal Destino As Integer) As eTrigger6

    On Error GoTo Errhandler
    Dim tOrg As eTrigger
    Dim tDst As eTrigger

    tOrg = MapData(UserList(Origen).Pos.map, UserList(Origen).Pos.X, UserList(Origen).Pos.Y).trigger
    tDst = MapData(UserList(Destino).Pos.map, UserList(Destino).Pos.X, UserList(Destino).Pos.Y).trigger

    If tOrg = eTrigger.ZONAPELEA Or tDst = eTrigger.ZONAPELEA Then
        If tOrg = tDst Then
            TriggerZonaPelea = TRIGGER6_PERMITE
        Else
            TriggerZonaPelea = TRIGGER6_PROHIBE
        End If
    Else
        TriggerZonaPelea = TRIGGER6_AUSENTE
    End If

    Exit Function
Errhandler:
    TriggerZonaPelea = TRIGGER6_AUSENTE
    LogError ("Error en TriggerZonaPelea - " & Err.Description)
End Function

Sub UserEnvenena(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)

    Dim ObjInd As Integer

    ObjInd = UserList(AtacanteIndex).Invent.WeaponEqpObjIndex

    If ObjInd > 0 Then
        If ObjData(ObjInd).proyectil = 1 Then
            ObjInd = UserList(AtacanteIndex).Invent.MunicionEqpObjIndex
        End If

        If ObjInd > 0 Then
            If ObjData(ObjInd).Envenena = 1 Then

                If RandomNumber(1, 100) < 60 Then
                    UserList(VictimaIndex).flags.Envenenado = 1
                    Call WriteUpdateEnvenenado(VictimaIndex)
                    Call WriteConsoleMsg(VictimaIndex, "¡¡" & UserList(AtacanteIndex).Name & " te ha envenenado!!", FontTypeNames.FONTTYPE_FIGHT)
                    Call WriteConsoleMsg(AtacanteIndex, "¡¡Has envenenado a " & UserList(VictimaIndex).Name & "!!", FontTypeNames.FONTTYPE_FIGHT)
                End If
            End If
        End If
    End If
End Sub
