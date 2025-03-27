Attribute VB_Name = "modHechizos"
'Argentum Online 0.12.2
'Copyright (C) 2002 Márquez Pablo Ignacio
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@
'www.geocities.com/gmorgolock
'Calle 3 número 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Código Postal 1900
'Pablo Ignacio Márquez

Option Explicit

Public Const HELEMENTAL_FUEGO As Integer = 26
Public Const HELEMENTAL_TIERRA As Integer = 28
Public Const SUPERANILLO As Integer = 700

Function NpcLanzaSpellSobreUser(ByVal NpcIndex As Integer, ByVal UserIndex As Integer, ByVal Spell As Integer) As Boolean
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 13/02/2009
'13/02/2009: ZaMa - Los npcs que tiren magias, no podran hacerlo en mapas donde no se permita usarla.
'***************************************************
'If Not NpcIntervaloGolpe(npcIndex, True) Then Exit Function
    If UserList(UserIndex).flags.invisible = 1 Or UserList(UserIndex).flags.oculto = 1 Then Exit Function

    ' Si no se peude usar magia en el mapa, no le deja hacerlo.
    If MapInfo(UserList(UserIndex).Pos.map).MagiaSinEfecto > 0 Then Exit Function

    Dim Daño As Integer

    With UserList(UserIndex)
        If Hechizos(Spell).SubeHP = 1 Then

            Daño = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)

            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, .Pos.X, .Pos.Y))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))

            .Stats.MinHP = .Stats.MinHP + Daño
            If .Stats.MinHP > .Stats.MaxHP Then .Stats.MinHP = .Stats.MaxHP

            Call WriteConsoleMsg(UserIndex, Npclist(NpcIndex).Name & " te ha sumado " & Daño & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)
            Call WriteUpdateUserStats(UserIndex)
            NpcLanzaSpellSobreUser = True

        ElseIf Hechizos(Spell).SubeHP = 2 Then

            'If Not EsGm(UserIndex) Then

            Daño = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)

            If .Invent.CascoEqpObjIndex > 0 Then
                Daño = Daño - RandomNumber(ObjData(.Invent.CascoEqpObjIndex).DefensaMagicaMin, ObjData(.Invent.CascoEqpObjIndex).DefensaMagicaMax)
            End If

            If .Invent.AnilloEqpObjIndex2 > 0 Then
                Daño = Daño - RandomNumber(ObjData(.Invent.AnilloEqpObjIndex2).DefensaMagicaMin, ObjData(.Invent.AnilloEqpObjIndex2).DefensaMagicaMax)
            End If

            If UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) > 0 Then
                Dim getResistenciaMagica As Integer
                If UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) = 0 Then
                    getResistenciaMagica = 0
                ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 31 Then
                    getResistenciaMagica = 0.01
                ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 61 Then
                    getResistenciaMagica = 0.02
                ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 91 Then
                    getResistenciaMagica = 0.03
                ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 100 Then
                    getResistenciaMagica = 0.04
                Else
                    getResistenciaMagica = 0.05
                End If
                Daño = Daño - (Daño * getResistenciaMagica)
            End If

            If Daño < 0 Then Daño = 0

            If EsGM(UserIndex) Then Daño = 0

            ' si tengo algo que me de RM, aumenta mi RM
            'If (.Invent.AnilloEqpObjIndex2 > 0) Or (.Invent.CascoEqpObjIndex > 0) Then
            'If UserList(UserIndex).Stats.UserSkills(eSkill.ResistenciaMagica) >= 5 Then
            If Npclist(NpcIndex).NPCtype <> eNPCType.Pretoriano And Daño Then
                Call SubirSkill(UserIndex, eSkill.ResistenciaMagica, True)
            End If
            'End If
            'End If


            If .flags.Meditando Then
                'If daño > Fix(.Stats.MinHp / 100 * .Stats.UserAtributos(eAtributos.Inteligencia) * .Stats.UserSkills(eSkill.Meditar) / 100 * 12 / (RandomNumber(0, 5) + 7)) Then
                .flags.Meditando = False
                Call WriteMeditateToggle(UserIndex)
                ' WriteMensajes userindex, e_Mensajes.Mensaje_216

                '.Char.FX = 0
                '.Char.loops = 0
                'Call SendData(SendTarget.ToPCArea, userindex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
                'End If
            End If

            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, .Pos.X, .Pos.Y))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))

            .Stats.MinHP = .Stats.MinHP - Daño
            SendData SendTarget.ToPCArea, UserIndex, PrepareMessageCreateDamage(UserList(UserIndex).Char.CharIndex, Daño, 255, 0, 0)
            Call WriteConsoleMsg(UserIndex, Npclist(NpcIndex).Name & " te ha quitado " & Daño & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)
            Call WriteUpdateUserStats(UserIndex)

            NpcLanzaSpellSobreUser = True

            'Muere
            If .Stats.MinHP < 1 Then
                .Stats.MinHP = 0
                If Npclist(NpcIndex).NPCtype = eNPCType.GuardiaReal Then
                    RestarCriminalidad (UserIndex)
                End If
                Call UserDie(UserIndex, Not EsGM(UserIndex))
                '[Barrin 1-12-03]
                If Npclist(NpcIndex).MaestroUser > 0 Then
                    'Store it!
                    Call Statistics.StoreFrag(Npclist(NpcIndex).MaestroUser, UserIndex)

                    Call ContarMuerte(UserIndex, Npclist(NpcIndex).MaestroUser)
                    Call ActStats(UserIndex, Npclist(NpcIndex).MaestroUser)
                End If
                '[/Barrin]
            End If

            'End If

        End If

        If Hechizos(Spell).Paraliza = 1 Or Hechizos(Spell).Inmoviliza = 1 Then
            If .flags.Paralizado = 0 Then
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, .Pos.X, .Pos.Y))
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))

                If .Invent.AnilloEqpObjIndex = SUPERANILLO Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_348
                    Exit Function
                End If

                If Hechizos(Spell).Inmoviliza = 1 Then
                    .flags.Inmovilizado = 1
                End If

                .flags.Paralizado = 1
                .Counters.Paralisis = IIf(.Clase = eClass.Warrior Or .Clase = eClass.Hunter, Int(IntervaloParalizado / 3), IntervaloParalizado)
                NpcLanzaSpellSobreUser = True

                Call WriteParalizeOK(UserIndex)

                Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, UserIndex, PrepareMessageUpdateCharData(UserIndex))

            End If
        End If

        If Hechizos(Spell).Estupidez = 1 Then        ' turbacion
            If .flags.Estupidez = 0 Then
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Hechizos(Spell).WAV, .Pos.X, .Pos.Y))
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))

                If .Invent.AnilloEqpObjIndex = SUPERANILLO Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_348
                    Exit Function
                End If

                .flags.Estupidez = 1
                .Counters.Ceguera = IntervaloInvisible
                NpcLanzaSpellSobreUser = True

                Call WriteDumb(UserIndex)
            End If
        End If
    End With

End Function

Sub NpcLanzaSpellSobreNpc(ByVal NpcIndex As Integer, ByVal TargetNPC As Integer, ByVal Spell As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'solo hechizos ofensivos!

    If Not NpcIntervaloGolpe(NpcIndex) Then Exit Sub

    Dim Daño As Integer

    If Hechizos(Spell).SubeHP = 2 Then

        Daño = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)
        Call SendData(SendTarget.ToNPCArea, TargetNPC, PrepareMessagePlayWave(Hechizos(Spell).WAV, Npclist(TargetNPC).Pos.X, Npclist(TargetNPC).Pos.Y))
        Call SendData(SendTarget.ToNPCArea, TargetNPC, PrepareMessageCreateFX(Npclist(TargetNPC).Char.CharIndex, Hechizos(Spell).FXgrh, Hechizos(Spell).loops))

        Npclist(TargetNPC).Stats.MinHP = Npclist(TargetNPC).Stats.MinHP - Daño

        'Muere
        If Npclist(TargetNPC).Stats.MinHP < 1 Then
            Npclist(TargetNPC).Stats.MinHP = 0
            If Npclist(NpcIndex).MaestroUser > 0 Then
                Call MuereNpc(TargetNPC, Npclist(NpcIndex).MaestroUser)
            Else
                Call MuereNpc(TargetNPC, 0)
            End If
        End If

    End If

End Sub

Function TieneHechizo(ByVal i As Integer, ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim j As Long
    For j = 1 To MAXUSERHECHIZOS
        If UserList(UserIndex).Stats.UserHechizos(j) = i Then
            TieneHechizo = True
            Exit Function
        End If
    Next

    Exit Function
Errhandler:

End Function

Sub AgregarHechizo(ByVal UserIndex As Integer, ByVal Slot As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim hIndex As Integer
    Dim j As Integer

    With UserList(UserIndex)
        hIndex = ObjData(.Invent.Object(Slot).ObjIndex).HechizoIndex

        If Not TieneHechizo(hIndex, UserIndex) Then
            'Buscamos un slot vacio
            For j = 1 To MAXUSERHECHIZOS
                If .Stats.UserHechizos(j) = 0 Then Exit For
            Next j

            If .Stats.UserHechizos(j) <> 0 Then

                WriteMensajes UserIndex, e_Mensajes.Mensaje_132
            Else
                .Stats.UserHechizos(j) = hIndex
                Call UpdateUserHechizos(False, UserIndex, CByte(j))
                'Quitamos del inv el item
                Call QuitarUserInvItem(UserIndex, CByte(Slot), 1)
            End If
        Else
            WriteMensajes UserIndex, e_Mensajes.Mensaje_133
        End If
    End With

End Sub

Sub DecirPalabrasMagicas(ByVal SpellWords As String, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 17/11/2009
'25/07/2009: ZaMa - Invisible admins don't say any word when casting a spell
'17/11/2009: ZaMa - Now the user become visible when casting a spell, if it is hidden
'***************************************************
    On Error GoTo Errhandler

1   With UserList(UserIndex)
2       If .flags.AdminInvisible <> 1 Then
3           Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(SpellWords, .Char.CharIndex, vbCyan))

            ' Si estaba oculto, se vuelve visible
4           If .flags.oculto = 1 Then
5               .flags.oculto = 0
                .Counters.TiempoOculto = 0

6               If .flags.invisible = 0 Then
7                   WriteMensajes UserIndex, e_Mensajes.Mensaje_23
8                   Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                End If
9           End If
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en DecirPalabrasMagicas en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

''
' Check if an user can cast a certain spell
'
' @param UserIndex Specifies reference to user
' @param HechizoIndex Specifies reference to spell
' @return   True if the user can cast the spell, otherwise returns false
Function PuedeLanzar(ByVal UserIndex As Integer, ByVal HechizoIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010
'Last Modification By: ZaMa
'06/11/09 - Corregida la bonificación de maná del mimetismo en el druida con flauta mágica equipada.
'19/11/2009: ZaMa - Validacion de mana para el Invocar Mascotas
'12/01/2010: ZaMa - Validacion de mana para hechizos lanzados por druida.
'***************************************************
    Dim DruidManaBonus As Single

    With UserList(UserIndex)
        If .flags.Muerto Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_137
            Exit Function
        End If

        If Hechizos(HechizoIndex).NeedStaff > 0 Then
            If .Clase = eClass.Mage Then
                If .Invent.WeaponEqpObjIndex > 0 Then
                    If ObjData(.Invent.WeaponEqpObjIndex).StaffPower < Hechizos(HechizoIndex).NeedStaff Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_282        'Call WriteConsoleMsg(UserIndex, "No posees un báculo lo suficientemente poderoso para poder lanzar el conjuro.", FontTypeNames.FONTTYPE_INFO)
                        Exit Function
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_282        'Call WriteConsoleMsg(UserIndex, "No puedes lanzar este conjuro sin la ayuda de un báculo.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If
            End If
        End If

        If .Stats.UserSkills(eSkill.Magia) < Hechizos(HechizoIndex).MinSkill Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_135

            Exit Function
        End If

        If .Stats.minSta < Hechizos(HechizoIndex).StaRequerido Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_134
            Exit Function
        End If

        DruidManaBonus = 1
        If .Clase = eClass.Druid Then

            '         If .Invent.AnilloEqpObjIndex2 <> ANILLOMAGICO Then
            '            ' 50% menos de mana requerido para mimetismo
            '           If Hechizos(HechizoIndex).Mimetiza = 1 Then
            '              DruidManaBonus = 0.5
            '
            '                   ' 30% menos de mana requerido para invocaciones
            '              ElseIf Hechizos(HechizoIndex).tipo = uInvocacion Then
            '                 DruidManaBonus = 0.7
            '
            '                   ' 10% menos de mana requerido para las demas magias, excepto apoca
            '              ElseIf HechizoIndex <> APOCALIPSIS_SPELL_INDEX Then
            '                 DruidManaBonus = 0.9
            '            End If
            '       End If

            ' Necesita tener la barra de mana completa para invocar una mascota
            If Hechizos(HechizoIndex).Warp = 1 Then
                If .Stats.MinMAN < 1000 Then        '.Stats.MaxMAN Then
                    Call WriteConsoleMsg(UserIndex, "Debes poseer 1000 de maná para poder lanzar este hechizo.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If
            End If
        End If

        If .Stats.MinMAN < Hechizos(HechizoIndex).ManaRequerido * DruidManaBonus Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_136
            Exit Function
        End If

    End With

    PuedeLanzar = True
End Function

Sub HechizoTerrenoEstado(ByVal UserIndex As Integer, ByRef b As Boolean)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim PosCasteadaX As Integer
    Dim PosCasteadaY As Integer
    Dim PosCasteadaM As Integer
    Dim h As Integer
    Dim TempX As Integer
    Dim TempY As Integer

    With UserList(UserIndex)
        PosCasteadaX = .flags.TargetX
        PosCasteadaY = .flags.TargetY
        PosCasteadaM = .flags.TargetMap

        h = .flags.Hechizo

        If Hechizos(h).RemueveInvisibilidadParcial = 1 Then
            b = True
            For TempX = PosCasteadaX - 8 To PosCasteadaX + 8
                For TempY = PosCasteadaY - 8 To PosCasteadaY + 8
                    If InMapBounds(PosCasteadaM, TempX, TempY) Then
                        If MapData(PosCasteadaM, TempX, TempY).UserIndex > 0 Then
                            'hay un user
                            If UserList(MapData(PosCasteadaM, TempX, TempY).UserIndex).flags.invisible = 1 And UserList(MapData(PosCasteadaM, TempX, TempY).UserIndex).flags.AdminInvisible = 0 Then
                                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(UserList(MapData(PosCasteadaM, TempX, TempY).UserIndex).Char.CharIndex, Hechizos(h).FXgrh, Hechizos(h).loops))
                            End If
                        End If
                    End If
                Next TempY
            Next TempX

            Call InfoHechizo(UserIndex)
        End If
    End With
End Sub

Sub HechizoInvocacion(ByVal UserIndex As Integer, ByRef HechizoCasteado As Boolean)
'***************************************************
'Author: Uknown
'Last Modification: 10/08/2011 - ^[GS]^
'Sale del sub si no hay una posición valida.
'18/11/2009: Optimizacion de codigo.
'18/09/2010: ZaMa - No se permite invocar en mapas con InvocarSinEfecto.
'***************************************************

    On Error GoTo error

    Dim mapa As Integer

    With UserList(UserIndex)

        mapa = .Pos.map

        'No permitimos se invoquen criaturas en zonas seguras
        If MapInfo(mapa).pk = False Or MapData(mapa, .Pos.X, .Pos.Y).trigger = eTrigger.ZONASEGURA Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_435)        '"No puedes invocar criaturas en zona segura."
            Exit Sub
        End If

        If Not EsGM(UserIndex) Then
            'No permitimos se invoquen criaturas en mapas donde esta prohibido hacerlo
4           If MapInfo(mapa).InvocarSinEfecto = 1 Or Not .mReto.Reto_Index = 0 Or Not .flags.EnEvento = 0 Or Not .sReto.Reto_Index = 0 Then
                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_435)
                Exit Sub
            End If

            If (.flags.Hechizo = IMPLORARAYUDA Or .flags.Hechizo = ESPIRITUINDOMABLE) And Not .Clase = eClass.Druid Then
                Call WriteConsoleMsg(UserIndex, "Tu clase no puede utilizar éste hechizo!")
                Exit Sub
            End If
        End If

        Dim SpellIndex As Integer, NroNpcs As Integer, NpcIndex As Integer, PetIndex As Integer
        Dim TargetPos As WorldPos

        Dim petType As Integer
        Dim found As Boolean

        TargetPos.map = .flags.TargetMap
        TargetPos.X = .flags.TargetX
        TargetPos.Y = .flags.TargetY

        SpellIndex = .flags.Hechizo

        ' Warp de mascotas
        If Hechizos(SpellIndex).Warp = 1 Then

            If .nroMascotas > 0 Then
                Dim i As Long

                For NroNpcs = 1 To MAXMASCOTAS
                    If .MascotasIndex(NroNpcs) > 0 Then
                        If Npclist(.MascotasIndex(NroNpcs)).flags.Domable > 0 Then
                            petType = .MascotasType(NroNpcs)
                            Call QuitarNPC(.MascotasIndex(NroNpcs))

                            ' Restauramos el valor de la variable
                            .MascotasType(NroNpcs) = petType
                            found = True
                        End If
                    End If
                Next NroNpcs

            Else

                ' La invoco cerca mio
                For NroNpcs = 1 To MAXMASCOTAS
                    If .MascotasType(NroNpcs) > 0 Then
                        If .MascotasIndex(NroNpcs) < 1 Then
                            .MascotasIndex(NroNpcs) = SpawnNpc(.MascotasType(NroNpcs), TargetPos, True, False)

                            If .MascotasIndex(NroNpcs) > 0 Then
                                .nroMascotas = .nroMascotas + 1

                                With Npclist(.MascotasIndex(NroNpcs))
                                    .MaestroUser = UserIndex
                                    .Movement = TipoAI.SigueAmo
                                    .Target = 0
                                    .TargetNPC = 0
                                End With

                                Call FollowAmo(.MascotasIndex(NroNpcs))
                                found = True
                            End If
                        End If
                    End If
                Next NroNpcs

            End If

            If Not found Then Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_442): Exit Sub
            ' Invocacion normal
        Else
            If .nroMascotas >= MAXMASCOTAS Then Exit Sub

            If .nroMascotas > 0 Then
                If Hechizos(SpellIndex).NumNpc = FUEGOFATUO Then Exit Sub
            End If

            'Si ya hay un fatuo
            For NroNpcs = 1 To MAXMASCOTAS
                If .MascotasIndex(NroNpcs) > 0 Then
                    If Npclist(.MascotasIndex(NroNpcs)).Numero = FUEGOFATUO Then
                        Exit Sub
                    End If
                End If
            Next NroNpcs

            If InStr(1, Hechizos(SpellIndex).Nombre, "Elemental") > 0 Then
                If Not PuedeTirarElementos(UserIndex) Then Exit Sub
            ElseIf Hechizos(SpellIndex).Nombre = "Implorar ayuda" Then
                If Not PuedeTirarImplorar(UserIndex) Then Exit Sub
            ElseIf Hechizos(SpellIndex).Nombre = "Ayuda del Espiritu Indomable" Then
                If Not PuedeTirarIndomable(UserIndex) Then Exit Sub
            End If

            For NroNpcs = 1 To Hechizos(SpellIndex).Cant

                If .nroMascotas < MAXMASCOTAS Then
                    NpcIndex = SpawnNpc(Hechizos(SpellIndex).NumNpc, TargetPos, True, False)

                    If NpcIndex > 0 Then
                        Dim j As Long

                        For j = 1 To MAXMASCOTAS
                            If UserList(UserIndex).MascotasIndex(j) < 1 Then
                                PetIndex = j
                                Exit For
                            End If
                        Next j

                        If PetIndex < 1 Then Exit Sub

                        .nroMascotas = .nroMascotas + 1
                        .MascotasIndex(PetIndex) = NpcIndex

                        With Npclist(NpcIndex)
                            .MaestroUser = UserIndex
                            .Contadores.Ataque = GetTickCount

                            Select Case Hechizos(SpellIndex).NumNpc
                            Case ELEMENTALFUEGO
                                .Contadores.TiempoExistencia = IntervaloInvocacionFuego
                            Case ELEMENTALAGUA
                                .Contadores.TiempoExistencia = IntervaloInvocacionAgua
                            Case ELEMENTALTIERRA
                                .Contadores.TiempoExistencia = IntervaloInvocacionTierra
                            Case Else
                                .Contadores.TiempoExistencia = IntervaloInvocacion
                            End Select

                            .GiveGLD = 0
                        End With

                        Call FollowAmo(NpcIndex)
                    Else
                        Exit Sub
                    End If
                Else
                    Exit For
                End If

            Next NroNpcs
        End If
    End With

    Call InfoHechizo(UserIndex)
    HechizoCasteado = True

    Exit Sub

error:
    With UserList(UserIndex)
        LogError ("[" & Err.Number & "] " & Err.Description & " por el usuario " & .Name & "(" & UserIndex & ") en (" & .Pos.map & ", " & .Pos.X & ", " & .Pos.Y & "). Tratando de tirar el hechizo " & Hechizos(SpellIndex).Nombre & "(" & SpellIndex & ") en la posicion ( " & .flags.TargetX & ", " & .flags.TargetY & ")")
    End With

End Sub

Private Function PuedeTirarIndomable(ByVal UserIndex As Integer) As Boolean

    Dim i As Long
    Dim CantidadDeFuego As Integer

    For i = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(i) > 0 Then
            If UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name) = "ESPIRITU INDOMABLE" Then Exit Function
            If UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name) = "FUEGO FATUO" Then Exit Function
            If InStr(1, Npclist(UserList(UserIndex).MascotasIndex(i)).Name, "Elemental") > 0 Then CantidadDeFuego = CantidadDeFuego + 1
        End If
    Next

    If CantidadDeFuego > 1 Then Exit Function

    PuedeTirarIndomable = True

End Function

Private Function PuedeTirarImplorar(ByVal UserIndex As Integer) As Boolean

    If UserList(UserIndex).nroMascotas < 1 Then
        PuedeTirarImplorar = True
    End If

End Function

Private Function PuedeTirarElementos(ByVal UserIndex As Integer) As Boolean

    Dim i As Long
    Dim CantidadDeFuego As Integer
    Dim TieneIndomable As Boolean

    For i = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(i) > 0 Then
            If UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name) = "ESPIRITU INDOMABLE" Then TieneIndomable = True
            If UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name) = "FUEGO FATUO" Then Exit Function
            If InStr(1, UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name), "FUEGO") > 0 Or InStr(1, UCase$(Npclist(UserList(UserIndex).MascotasIndex(i)).Name), "TIERRA") > 0 Then CantidadDeFuego = CantidadDeFuego + 1
        End If
    Next i

    If TieneIndomable And CantidadDeFuego = 1 Then Exit Function
    PuedeTirarElementos = True

End Function

Sub HandleHechizoTerreno(ByVal UserIndex As Integer, ByVal SpellIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 18/11/2009
'18/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************

    Dim HechizoCasteado As Boolean
    Dim ManaRequerida As Integer

    If UserList(UserIndex).flags.ModoCombate = False Then
        Call WriteConsoleMsg(UserIndex, "Debes estar en modo de combate para lanzar este hechizo.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    Select Case Hechizos(SpellIndex).tipo
    Case TipoHechizo.uInvocacion
        Call HechizoInvocacion(UserIndex, HechizoCasteado)

    Case TipoHechizo.uEstado
        Call HechizoTerrenoEstado(UserIndex, HechizoCasteado)
    End Select

    If HechizoCasteado Then
        With UserList(UserIndex)
            Call SubirSkill(UserIndex, eSkill.Magia, True)

            ManaRequerida = Hechizos(SpellIndex).ManaRequerido

            If Hechizos(SpellIndex).Warp = 1 Then        ' Invocó una mascota
                ManaRequerida = 1000        '.Stats.MinMAN
            Else
                '  If .clase = eClass.Druid Then ' Bonificaciones en hechizos
                '      'If .Invent.AnilloEqpObjIndex = FLAUTAELFICA Or .Invent.AnilloEqpObjIndex = ANILLOMAGICO Then
                '      If .Invent.AnilloEqpObjIndex = ANILLOMAGICO Then
                '          ManaRequerida = ManaRequerida * 0.7 ' 30% menos de mana para invocaciones
                '      End If
                '  End If
            End If

            ' Quito la mana requerida
            .Stats.MinMAN = .Stats.MinMAN - ManaRequerida
            If .Stats.MinMAN < 0 Then .Stats.MinMAN = 0

            ' Quito la estamina requerida
            .Stats.minSta = .Stats.minSta - Hechizos(SpellIndex).StaRequerido
            If .Stats.minSta < 0 Then .Stats.minSta = 0

            ' Update user stats
            Call WriteUpdateUserStats(UserIndex)
        End With
    End If

End Sub

Sub HandleHechizoUsuario(ByVal UserIndex As Integer, ByVal SpellIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010
'18/11/2009: ZaMa - Optimizacion de codigo.
'12/01/2010: ZaMa - Optimizacion y agrego bonificaciones al druida.
'***************************************************

    Dim HechizoCasteado As Boolean
    Dim ManaRequerida As Integer

    On Error GoTo Errhandler

1   If UserList(UserIndex).flags.ModoCombate = False Then
2       Call WriteConsoleMsg(UserIndex, "Debes estar en modo de combate para lanzar este hechizo.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If
    Select Case Hechizos(SpellIndex).tipo
    Case TipoHechizo.uEstado
        ' Afectan estados (por ejem : Envenenamiento)
3       Call HechizoEstadoUsuario(UserIndex, HechizoCasteado)

    Case TipoHechizo.uPropiedades
        ' Afectan HP,MANA,STAMINA,ETC
4       HechizoCasteado = HechizoPropUsuario(UserIndex)
    End Select

    If HechizoCasteado Then
        With UserList(UserIndex)
5           Call SubirSkill(UserIndex, eSkill.Magia, True)

            ManaRequerida = Hechizos(SpellIndex).ManaRequerido

            ' Quito la mana requerida
20          .Stats.MinMAN = .Stats.MinMAN - ManaRequerida
21          If .Stats.MinMAN < 0 Then .Stats.MinMAN = 0

            ' Quito la estamina requerida
22          .Stats.minSta = .Stats.minSta - Hechizos(SpellIndex).StaRequerido
23          If .Stats.minSta < 0 Then .Stats.minSta = 0

            If .mReto.Reto_Index > 0 Then
                If RetoList(.mReto.Reto_Index).UpdateStats = 1 And RetoList(.mReto.Reto_Index).count_Down = 0 Then
                    RetoList(.mReto.Reto_Index).UpdateStats = 0
                End If

                If RetoList(.mReto.Reto_Index).UpdateStats = 1 Then
                    Call m_Retos1vs1.UpdateStats_Reto(.mReto.Reto_Index)
                End If
            End If

            ' Update user stats
24          Call WriteUpdateStatsNew(UserIndex)
25          Call WriteUpdateStatsNew(.flags.TargetUser)
26          .flags.TargetUser = 0
        End With
    End If
    Exit Sub
Errhandler:
    Call LogError("Error en Handlehechizousuario en " & Erl & ". Err " & Err.Number & " " & Err.Description)
End Sub

Sub HandleHechizoNPC(ByVal UserIndex As Integer, ByVal HechizoIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010
'13/02/2009: ZaMa - Agregada 50% bonificacion en coste de mana a mimetismo para druidas
'17/11/2009: ZaMa - Optimizacion de codigo.
'12/01/2010: ZaMa - Bonificacion para druidas de 10% para todos hechizos excepto apoca y descarga.
'12/01/2010: ZaMa - Los druidas mimetizados con npcs ahora son ignorados.
'***************************************************
    On Error GoTo Errhandler

    Dim HechizoCasteado As Boolean
    Dim ManaRequerida As Long

    With UserList(UserIndex)
        Select Case Hechizos(HechizoIndex).tipo
        Case TipoHechizo.uEstado
            ' Afectan estados (por ejem : Envenenamiento)
1           Call HechizoEstadoNPC(.flags.TargetNPC, HechizoIndex, HechizoCasteado, UserIndex)

        Case TipoHechizo.uPropiedades
            ' Afectan HP,MANA,STAMINA,ETC
2           Call HechizoPropNPC(HechizoIndex, .flags.TargetNPC, UserIndex, HechizoCasteado)
        End Select


3       If HechizoCasteado Then
4           Call SubirSkill(UserIndex, eSkill.Magia, True)

5           ManaRequerida = Hechizos(HechizoIndex).ManaRequerido

            ' Bonificación para druidas.
            If .Clase = eClass.Druid Then
                ' Se mostró como usuario, puede ser atacado por npcs
                .flags.Ignorado = False

                ' Solo con flauta equipada
                'If .Invent.AnilloEqpObjIndex = FLAUTAELFICA Then
                '    If Hechizos(HechizoIndex).Mimetiza = 1 Then
                '        ' 50% menos de mana para mimetismo
                '        ManaRequerida = ManaRequerida * 0.5
                '        ' Será ignorado hasta que pierda el efecto del mimetismo o ataque un npc
                '        .flags.Ignorado = True
                '    Else
                '        ' 10% menos de mana para hechizos
                '        If HechizoIndex <> APOCALIPSIS_SPELL_INDEX Then
                '            ManaRequerida = ManaRequerida * 0.9
                '        End If
                '    End If
                'End If
            End If

            ' Quito la mana requerida
6           .Stats.MinMAN = .Stats.MinMAN - ManaRequerida
7           If .Stats.MinMAN < 0 Then .Stats.MinMAN = 0

            ' Quito la estamina requerida
8           .Stats.minSta = .Stats.minSta - Hechizos(HechizoIndex).StaRequerido
9           If .Stats.minSta < 0 Then .Stats.minSta = 0

            ' Update user stats
10          Call WriteUpdateUserStats(UserIndex)
11          .flags.TargetNPC = 0
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en HandleHechizoNPC en " & Erl & ". ERr: " & Err.Number & " " & Err.Description)
End Sub


Sub LanzarHechizo(ByVal SpellIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 02/16/2010
'24/01/2007 ZaMa - Optimizacion de codigo.
'02/16/2010: Marco - Now .flags.hechizo makes reference to global spell index instead of user's spell index
'***************************************************
    On Error GoTo Errhandler

    With UserList(UserIndex)

        If .flags.EnConsulta Then
            Call WriteConsoleMsg(UserIndex, "No puedes lanzar hechizos si estás en consulta.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If Not UserList(UserIndex).flags.ModoCombate Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_218
            Exit Sub
        End If

1       If PuedeLanzar(UserIndex, SpellIndex) Then
2           Select Case Hechizos(SpellIndex).Target
            Case TargetType.uUsuarios
4               If .flags.TargetUser > 0 Then
5                   If Abs(UserList(.flags.TargetUser).Pos.Y - .Pos.Y) <= RANGO_VISION_Y Then
6                       Call HandleHechizoUsuario(UserIndex, SpellIndex)
7                   Else
                        Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos para lanzar este hechizo.", FontTypeNames.FONTTYPE_WARNING)
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_138
                End If

            Case TargetType.uNPC
                If .flags.TargetNPC > 0 Then
8                   If Abs(Npclist(.flags.TargetNPC).Pos.Y - .Pos.Y) <= RANGO_VISION_Y Then
9                       Call HandleHechizoNPC(UserIndex, SpellIndex)
                    Else
10                      Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos para lanzar este hechizo.", FontTypeNames.FONTTYPE_WARNING)
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_139
                End If

            Case TargetType.uUsuariosYnpc
                If .flags.TargetUser > 0 Then
12                  If Abs(UserList(.flags.TargetUser).Pos.Y - .Pos.Y) <= RANGO_VISION_Y Then
11                      Call HandleHechizoUsuario(UserIndex, SpellIndex)
                    Else
                        Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos para lanzar este hechizo.", FontTypeNames.FONTTYPE_WARNING)
                    End If
                ElseIf .flags.TargetNPC > 0 Then
13                  If Abs(Npclist(.flags.TargetNPC).Pos.Y - .Pos.Y) <= RANGO_VISION_Y Then
14                      Call HandleHechizoNPC(UserIndex, SpellIndex)
                    Else
                        Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos para lanzar este hechizo.", FontTypeNames.FONTTYPE_WARNING)
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_140

                End If

            Case TargetType.uTerreno
15              Call HandleHechizoTerreno(UserIndex, SpellIndex)
            End Select

16      End If

        If .Counters.Trabajando Then _
           .Counters.Trabajando = .Counters.Trabajando - 1

        If .Counters.Ocultando Then _
           .Counters.Ocultando = .Counters.Ocultando - 1

    End With

    Exit Sub

Errhandler:
    Call LogError("Error en LanzarHechizo en " & Erl & ". Error " & Err.Number & " : " & Err.Description & _
                " Hechizo: " & Hechizos(SpellIndex).Nombre & "(" & SpellIndex & _
                  "). cast: " & UserList(UserIndex).Name)

End Sub

Sub HechizoEstadoUsuario(ByVal UserIndex As Integer, ByRef HechizoCasteado As Boolean)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 28/04/2010
'Handles the Spells that afect the Stats of an User
'24/01/2007 Pablo (ToxicWaste) - Invisibilidad no permitida en Mapas con InviSinEfecto
'26/01/2007 Pablo (ToxicWaste) - Cambios que permiten mejor manejo de ataques en los rings.
'26/01/2007 Pablo (ToxicWaste) - Revivir no permitido en Mapas con ResuSinEfecto
'02/01/2008 Marcos (ByVal) - Curar Veneno no permitido en usuarios muertos.
'06/28/2008 NicoNZ - Agregué que se le de valor al flag Inmovilizado.
'17/11/2008: NicoNZ - Agregado para quitar la penalización de vida en el ring y cambio de ecuacion.
'13/02/2009: ZaMa - Arreglada ecuacion para quitar vida tras resucitar en rings.
'23/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************

    On Error GoTo Errhandler

    Dim HechizoIndex As Integer
    Dim TargetIndex As Integer

    With UserList(UserIndex)
        HechizoIndex = .flags.Hechizo
        TargetIndex = .flags.TargetUser

        ' <-------- Agrega Invisibilidad ---------->
1       If Hechizos(HechizoIndex).Invisibilidad = 1 Then
2           If UserList(TargetIndex).flags.Muerto = 1 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_357

                HechizoCasteado = False
                Exit Sub
            End If

            If UserList(TargetIndex).Counters.Saliendo Then
                If UserIndex <> TargetIndex Then
                    Call WriteConsoleMsg(UserIndex, "¡El hechizo no tiene efecto!", FontTypeNames.FONTTYPE_INFO)
                    HechizoCasteado = False
                    Exit Sub
                Else
                    Call WriteConsoleMsg(UserIndex, "¡No puedes hacerte invisible mientras te encuentras saliendo!", FontTypeNames.FONTTYPE_WARNING)
                    HechizoCasteado = False
                    Exit Sub
                End If
            End If

            'No usar invi mapas InviSinEfecto
3           If MapInfo(UserList(TargetIndex).Pos.map).InviSinEfecto > 0 Or UserList(TargetIndex).sReto.Reto_Index > 0 Or UserList(TargetIndex).mReto.Reto_Index > 0 Then
4               Call WriteConsoleMsg(UserIndex, "¡La invisibilidad no funciona aquí!", FontTypeNames.FONTTYPE_INFO)
                HechizoCasteado = False
                Exit Sub
            End If

            ' Chequea si el status permite ayudar al otro usuario
5           HechizoCasteado = CanSupportUser(UserIndex, TargetIndex, True)
            If Not HechizoCasteado Then Exit Sub


            If UserList(TargetIndex).flags.invisible = 1 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_356
                HechizoCasteado = False
                Exit Sub
            End If

            UserList(TargetIndex).flags.invisible = 1
7           Call UsUaRiOs.SetInvisible(TargetIndex, UserList(TargetIndex).Char.CharIndex, UserList(TargetIndex).flags.invisible = 1, UserList(TargetIndex).flags.oculto = 1)
            Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, TargetIndex, PrepareMessageUpdateCharData(TargetIndex))

8           Call InfoHechizo(UserIndex)
9           HechizoCasteado = True
        End If

        ' <-------- Agrega Mimetismo ---------->
10      If Hechizos(HechizoIndex).Mimetiza = 1 Then
            If TargetIndex = 0 Then
                Call WriteConsoleMsg(UserIndex, "No has seleccionado un target valido.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            If Not UserList(UserIndex).Clase = eClass.Druid Then
                Call WriteConsoleMsg(UserIndex, "Sólo los druidas pueden mimetizarse!", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

11          If UserList(UserIndex).flags.Muerto = 1 Then
                Call WriteMensajes(UserIndex, Mensaje_3)
                Exit Sub
            End If

            If TargetIndex = UserIndex Then
                Call WriteConsoleMsg(UserIndex, "No puedes mimetizarte a ti mismo!", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

777         If UserList(TargetIndex).flags.Navegando = 1 Then
                Call WriteConsoleMsg(UserIndex, "No puedes mimetizarte si está en un barco.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
            If .flags.Navegando = 1 Then
                Call WriteConsoleMsg(UserIndex, "No puedes mimetizarte si estás en un barco.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            'Si sos user, no uses este hechizo con GMS.
778         If UserList(UserIndex).flags.Privilegios < UserList(TargetIndex).flags.Privilegios Then
                Exit Sub
            End If

            If UserList(UserIndex).mReto.Reto_Index > 0 Or UserList(UserIndex).sReto.Reto_Index > 0 Then
                Call WriteConsoleMsg(UserIndex, "No puedes mimetizarte estando en retos.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

779         If .flags.Mimetizado = 1 Then
                Call WriteConsoleMsg(UserIndex, "Ya te encuentras mimetizado. El hechizo no ha tenido efecto.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

780         If .flags.AdminInvisible = 1 Then Exit Sub

            'copio el char original al mimetizado

            .CharMimetizado.body = .Char.body
            .CharMimetizado.Head = .Char.Head
            .CharMimetizado.CascoAnim = .Char.CascoAnim
            .CharMimetizado.ShieldAnim = .Char.ShieldAnim
            .CharMimetizado.WeaponAnim = .Char.WeaponAnim

            .flags.Mimetizado = 1
            .flags.Mimetizado_Nick = "-" & UserList(TargetIndex).Name

            If UserList(TargetIndex).guildIndex > 0 Then
                .flags.Mimetizado_Nick = .flags.Mimetizado_Nick & " <" & modGuilds.GuildName(UserList(TargetIndex).guildIndex) & ">"
            End If
            .flags.Mimetizado_Color = GetNickColor(TargetIndex)

781         .Char.body = UserList(TargetIndex).Char.body
782         .Char.Head = UserList(TargetIndex).Char.Head
783         .Char.CascoAnim = UserList(TargetIndex).Char.CascoAnim
784         .Char.ShieldAnim = UserList(TargetIndex).Char.ShieldAnim
            If UserList(TargetIndex).Invent.WeaponEqpObjIndex > 0 Then
785             .Char.WeaponAnim = GetWeaponAnim(UserIndex, UserList(TargetIndex).Invent.WeaponEqpObjIndex)
            End If

786         Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)

788         Call InfoHechizo(UserIndex)

787         'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterChangeNick(.Char.CharIndex, .flags.Mimetizado_Nick))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageUpdateTagAndStatus(UserIndex, .flags.Mimetizado_Color, .flags.Mimetizado_Nick))

            Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, UserIndex, PrepareMessageUpdateCharData(UserIndex))


            HechizoCasteado = True
        End If

        ' <-------- Agrega Envenenamiento ---------->
12      If Hechizos(HechizoIndex).Envenena = 1 Then
            If Not EsGM(UserIndex) Then
13              If UserIndex = TargetIndex Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                    Exit Sub
                End If
            End If

16          If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Sub
            If UserIndex <> TargetIndex Then
17              Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If
            UserList(TargetIndex).flags.Envenenado = 1
18          Call WriteUpdateEnvenenado(TargetIndex)
            Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, TargetIndex, PrepareMessageUpdateCharData(TargetIndex))

19          Call InfoHechizo(UserIndex)
            HechizoCasteado = True
        End If

        ' <-------- Cura Envenenamiento ---------->
14      If Hechizos(HechizoIndex).CuraVeneno = 1 Then

            'Verificamos que el usuario no este muerto
15          If UserList(TargetIndex).flags.Muerto = 1 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_357

                HechizoCasteado = False
                Exit Sub
            End If

            If UserList(TargetIndex).flags.Envenenado = 0 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_358
                HechizoCasteado = False
                Exit Sub
            End If

            ' Chequea si el status permite ayudar al otro usuario
20          HechizoCasteado = CanSupportUser(UserIndex, TargetIndex)
21          If Not HechizoCasteado Then Exit Sub

            'Si sos user, no uses este hechizo con GMS.
            'If UserList(UserIndex).flags.Privilegios < UserList(TargetIndex).flags.Privilegios Then
            '    Exit Sub
            'End If

            UserList(TargetIndex).flags.Envenenado = 0
23          Call WriteUpdateEnvenenado(TargetIndex)
            Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, TargetIndex, PrepareMessageUpdateCharData(TargetIndex))

            Call InfoHechizo(UserIndex)
            HechizoCasteado = True
        End If

        ' <-------- Agrega Paralisis/Inmovilidad ---------->
28      If Hechizos(HechizoIndex).Paraliza = 1 Or Hechizos(HechizoIndex).Inmoviliza = 1 Then

            If UserIndex = TargetIndex Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                Exit Sub
            End If

29          If UserList(TargetIndex).flags.Paralizado = 0 Then
30              If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Sub

31              If UserIndex <> TargetIndex Then
32                  Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
                End If

33              Call InfoHechizo(UserIndex)
34              HechizoCasteado = True
                If UserList(TargetIndex).Invent.AnilloEqpObjIndex = SUPERANILLO Then
                    Call WriteConsoleMsg(TargetIndex, " Tu anillo rechaza los efectos del hechizo.", FontTypeNames.FONTTYPE_FIGHT)
                    Call WriteConsoleMsg(UserIndex, " ¡El hechizo no tiene efecto!", FontTypeNames.FONTTYPE_FIGHT)
                    'Call Flushbuffer(TargetIndex)
                    Exit Sub
                End If

                If Hechizos(HechizoIndex).Inmoviliza = 1 Then UserList(TargetIndex).flags.Inmovilizado = 1
                UserList(TargetIndex).flags.Paralizado = 1
                UserList(TargetIndex).Counters.Paralisis = IIf(UserList(TargetIndex).Clase = eClass.Warrior Or UserList(TargetIndex).Clase = eClass.Hunter, Int(IntervaloParalizado * 0.8), IntervaloParalizado)

                UserList(TargetIndex).flags.ParalizedByIndex = UserIndex
                UserList(TargetIndex).flags.ParalizedBy = UserList(UserIndex).Name

                If UserList(TargetIndex).flags.MenuCliente <> eVentanas.vHechizos Then
                    UserList(TargetIndex).Counters.TickReactionRemoInv = GetTickCount()
                End If

                Call WriteParalizeOK(TargetIndex)
                Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, TargetIndex, PrepareMessageUpdateCharData(TargetIndex))
                'Call Flushbuffer(TargetIndex)
            End If
        End If

        ' <-------- Remueve Paralisis/Inmobilidad ---------->
        If Hechizos(HechizoIndex).RemoverParalisis = 1 Then

            ' Remueve si esta en ese estado
            If UserList(TargetIndex).flags.Paralizado = 1 Then

                ' Chequea si el status permite ayudar al otro usuario
35              HechizoCasteado = CanSupportUser(UserIndex, TargetIndex, True)
36              If Not HechizoCasteado Then Exit Sub

                Call RemoveParalisis(TargetIndex)
                Call InfoHechizo(UserIndex)
                Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, TargetIndex, PrepareMessageUpdateCharData(TargetIndex))
            End If
        End If

        ' <-------- Remueve Estupidez (Aturdimiento) ---------->
        If Hechizos(HechizoIndex).RemoverEstupidez = 1 Then

            ' Remueve si esta en ese estado
            If UserList(TargetIndex).flags.Estupidez = 1 Then

                ' Chequea si el status permite ayudar al otro usuario
                HechizoCasteado = CanSupportUser(UserIndex, TargetIndex)
                If Not HechizoCasteado Then Exit Sub

                UserList(TargetIndex).flags.Estupidez = 0

                'no need to crypt this
37              Call WriteDumbNoMore(TargetIndex)
                'Call Flushbuffer(TargetIndex)
                Call InfoHechizo(UserIndex)

            End If
        End If

        ' <-------- Revive ---------->
        If Hechizos(HechizoIndex).Revivir = 1 Then
            If UserList(TargetIndex).flags.Muerto = 1 Then

                'Seguro de resurreccion (solo afecta a los hechizos, no al sacerdote ni al comando de GM)
                ' If UserList(TargetIndex).flags.SeguroResu Then
                '     Call WriteConsoleMsg(UserIndex, "¡El espíritu no tiene intenciones de regresar al mundo de los vivos!", FontTypeNames.FONTTYPE_INFO)
                '     Call WriteConsoleMsg(TargetIndex, UserList(UserIndex).Name & " te quiere resucitar. Saca el seguro de resurrección y del modo combate para poder ser resucitado!", FontTypeNames.FONTTYPE_INFO)
                '     HechizoCasteado = False
                '     Exit Sub
                ' End If

                If UserList(TargetIndex).flags.ModoCombate Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_371
                    HechizoCasteado = False
                    Exit Sub
                End If

                If .flags.EnEvento <> 2 Then
                    'No usar resu en mapas con ResuSinEfecto
                    If MapInfo(UserList(TargetIndex).Pos.map).ResuSinEfecto > 0 Then
                        Call WriteConsoleMsg(UserIndex, "¡Revivir no está permitido aquí! Retirate de la Zona si deseas utilizar el Hechizo.", FontTypeNames.FONTTYPE_INFO)
                        HechizoCasteado = False
                        Exit Sub
                    End If
                End If

                If UserList(UserIndex).sReto.Reto_Index > 0 Then
                    If Not Retos2vs2_ValeResucitar(UserList(UserIndex).sReto.Reto_Index) Then
                        'WriteMensajes UserIndex, e_Mensajes.Mensaje_XXX 'pasar a cliente
                        Call WriteConsoleMsg(UserIndex, "El hechizo Resucitar se encuentra deshabilitado en éste reto.", FontTypeNames.FONTTYPE_INFO)
                        HechizoCasteado = False
                        Exit Sub
                    End If
                End If

                'No usar resu en mapas con ResuSinEfecto
                If MapInfo(UserList(TargetIndex).Pos.map).ResuSinEfecto > 0 Then
                    Call WriteConsoleMsg(UserIndex, "¡Revivir no está permitido aquí! Retirate de la Zona si deseas utilizar el Hechizo.", FontTypeNames.FONTTYPE_INFO)
                    HechizoCasteado = False
                    Exit Sub
                End If

                'No podemos resucitar si nuestra barra de energía no está llena. (GD: 29/04/07)
                If .Stats.minSta < Hechizos(HechizoIndex).minSta Then    ' .Stats.MaxSta Then
                    Call WriteConsoleMsg(UserIndex, "No puedes resucitar si no tienes la suficiente energia.")    'tu barra de energía llena.", FontTypeNames.FONTTYPE_INFO)
                    HechizoCasteado = False
                    Exit Sub
                End If

                'revisamos si necesita vara
38              If .Clase = eClass.Mage Then
                    If .Invent.WeaponEqpObjIndex > 0 Then
                        If ObjData(.Invent.WeaponEqpObjIndex).StaffPower < Hechizos(HechizoIndex).NeedStaff Then
                            Call WriteConsoleMsg(UserIndex, "Necesitas un báculo mejor para lanzar este hechizo.", FontTypeNames.FONTTYPE_INFO)
                            HechizoCasteado = False
                            Exit Sub
                        End If
                    End If
                ElseIf .Clase = eClass.Bard Then
                    If .Invent.AnilloEqpObjIndex <> LAUDELFICO And .Invent.AnilloEqpObjIndex <> LAUDMAGICO Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_344
                        HechizoCasteado = False
                        Exit Sub
                    End If
                ElseIf .Clase = eClass.Druid Then
                    'If .Invent.AnilloEqpObjIndex <> FLAUTAELFICA Or .Invent.AnilloEqpObjIndex <> ANILLOMAGICO Or .Invent.AnilloEqpObjIndex <> LAUDELFICO Then
                    If .Invent.AnilloEqpObjIndex <> ANILLOMAGICO And .Invent.AnilloEqpObjIndex <> LAUDELFICO Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_344
                        HechizoCasteado = False
                        Exit Sub
                    End If
                End If

                ' Chequea si el status permite ayudar al otro usuario
39              HechizoCasteado = CanSupportUser(UserIndex, TargetIndex, True)
                If Not HechizoCasteado Then Exit Sub

                Dim EraCriminal As Boolean
40              EraCriminal = criminal(UserIndex)

41              If Not criminal(TargetIndex) Then
                    If TargetIndex <> UserIndex Then
                        .Reputacion.NobleRep = .Reputacion.NobleRep + 500
                        If .Reputacion.NobleRep > MAXREP Then _
                           .Reputacion.NobleRep = MAXREP
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_143

                    End If
                End If

                If EraCriminal And Not criminal(UserIndex) Then
                    Call RefreshCharStatus(UserIndex)
                End If

                With UserList(TargetIndex)
                    'Pablo Toxic Waste (GD: 29/04/07)
                    .Stats.MinAGU = 0
                    .flags.Sed = 1
                    .Stats.MinHam = 0
                    .flags.Hambre = 1
                    Call WriteUpdateHungerAndThirst(TargetIndex)
                    Call InfoHechizo(UserIndex)
                    .Stats.MinMAN = 0
                    .Stats.minSta = 0
                End With

                'Agregado para quitar la penalización de vida en el ring y cambio de ecuacion. (NicoNZ)
422             If (TriggerZonaPelea(UserIndex, TargetIndex) <> TRIGGER6_PERMITE) Then
                    'Solo saco vida si es User. no quiero que exploten GMs por ahi.
                    'If Not EsGM(UserIndex) Then
                    '    .Stats.MinHP = .Stats.MinHP * (1 - UserList(TargetIndex).Stats.ELV * 0.015)
                    'End If
                End If

                'If (.Stats.MinHP <= 0) Then
                '    Call UserDie(UserIndex)
                '    Call WriteConsoleMsg(UserIndex, "El esfuerzo de resucitar fue demasiado grande.", FontTypeNames.FONTTYPE_INFO)
                '    HechizoCasteado = False
                'Else
                '    Call WriteConsoleMsg(UserIndex, "El esfuerzo de resucitar te ha debilitado.", FontTypeNames.FONTTYPE_INFO)
                HechizoCasteado = True
                'End If

43              Call RevivirUsuario(TargetIndex, False)

                If UserList(TargetIndex).flags.T2vs2.CurrentID > 0 Then
                    Call Revive2vs2(TargetIndex)
                End If
            Else
44              HechizoCasteado = False
            End If

        End If

        ' <-------- Agrega Ceguera ---------->
        If Hechizos(HechizoIndex).Ceguera = 1 Then
45          If UserIndex = TargetIndex Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                Exit Sub
            End If

            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Sub
            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If
            UserList(TargetIndex).flags.Ceguera = 1
            UserList(TargetIndex).Counters.Ceguera = IntervaloParalizado / 3

46          Call WriteBlind(TargetIndex)
            'Call Flushbuffer(TargetIndex)
            Call InfoHechizo(UserIndex)
            HechizoCasteado = True
        End If

        ' <-------- Agrega Estupidez (Aturdimiento) ---------->
47      If Hechizos(HechizoIndex).Estupidez = 1 Then
48          If UserIndex = TargetIndex Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                Exit Sub
            End If
            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Sub
            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If
            If UserList(TargetIndex).flags.Estupidez = 0 Then
                UserList(TargetIndex).flags.Estupidez = 1
                UserList(TargetIndex).Counters.Ceguera = IntervaloParalizado
            End If
            Call WriteDumb(TargetIndex)
            'Call Flushbuffer(TargetIndex)

            Call InfoHechizo(UserIndex)
            HechizoCasteado = True
        End If
    End With


    Exit Sub
Errhandler:
    Call LogError("error en HechizoEstadoUsuario en " & Erl & ". err " & Err.Number & " " & Err.Description)

End Sub

Sub HechizoEstadoNPC(ByVal NpcIndex As Integer, ByVal SpellIndex As Integer, ByRef HechizoCasteado As Boolean, ByVal UserIndex As Integer)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 07/07/2008
'Handles the Spells that afect the Stats of an NPC
'04/13/2008 NicoNZ - Guardias Faccionarios pueden ser
'removidos por users de su misma faccion.
'07/07/2008: NicoNZ - Solo se puede mimetizar con npcs si es druida
'***************************************************

    With Npclist(NpcIndex)
        If Hechizos(SpellIndex).Invisibilidad = 1 Then
            Call InfoHechizo(UserIndex)
            .flags.invisible = 1
            HechizoCasteado = True
        End If

        If Hechizos(SpellIndex).Envenena = 1 Then
            If Not PuedeAtacarNPC(UserIndex, NpcIndex) Then
                HechizoCasteado = False
                Exit Sub
            End If
            Call NPCAtacado(NpcIndex, UserIndex)
            Call InfoHechizo(UserIndex)
            .flags.Envenenado = 1
            HechizoCasteado = True
        End If

        If Hechizos(SpellIndex).CuraVeneno = 1 Then
            Call InfoHechizo(UserIndex)
            .flags.Envenenado = 0
            HechizoCasteado = True
        End If

        If Hechizos(SpellIndex).Paraliza = 1 Then
            If .flags.AfectaParalisis = 0 Then
                If Not PuedeAtacarNPC(UserIndex, NpcIndex, True) Then
                    HechizoCasteado = False
                    Exit Sub
                End If

                If LegalPosMistic(.Pos.map, .Pos.X, .Pos.Y) Then
                    HechizoCasteado = False
                    Exit Sub
                End If

                'Call NPCAtacado(npcIndex, userindex)
                Call InfoHechizo(UserIndex)
                .flags.Paralizado = 1
                .flags.Inmovilizado = 0
                .Contadores.Paralisis = IntervaloParalizado
                HechizoCasteado = True
                Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, UserIndex, PrepareMessageUpdateCharData(UserIndex))
            Else
                WriteMensajes UserIndex, e_Mensajes.Mensaje_283
                HechizoCasteado = False
                Exit Sub
            End If
        End If

        If Hechizos(SpellIndex).RemoverParalisis = 1 Then
            If .flags.Paralizado = 1 Or .flags.Inmovilizado = 1 Then
                If .MaestroUser = UserIndex Or EsGM(UserIndex) Then
                    Call InfoHechizo(UserIndex)
                    .flags.Paralizado = 0
                    .Contadores.Paralisis = 0
                    HechizoCasteado = True
                Else
                    If .NPCtype = eNPCType.GuardiaReal Then
                        If EsArmada(UserIndex) Then
                            Call InfoHechizo(UserIndex)
                            .flags.Paralizado = 0
                            .Contadores.Paralisis = 0
                            HechizoCasteado = True
                            Exit Sub
                        Else
                            Call WriteConsoleMsg(UserIndex, "Sólo puedes remover la parálisis de los Guardias si perteneces a su facción.", FontTypeNames.FONTTYPE_INFO)
                            HechizoCasteado = False
                            Exit Sub
                        End If

                        Call WriteConsoleMsg(UserIndex, "Solo puedes remover la parálisis de los NPCs que te consideren su amo.", FontTypeNames.FONTTYPE_INFO)
                        HechizoCasteado = False
                        Exit Sub
                    Else
                        If .NPCtype = eNPCType.Guardiascaos Then
                            If EsCaos(UserIndex) Then
                                Call InfoHechizo(UserIndex)
                                .flags.Paralizado = 0
                                .Contadores.Paralisis = 0
                                HechizoCasteado = True
                                Exit Sub
                            Else
                                Call WriteConsoleMsg(UserIndex, "Solo puedes remover la parálisis de los Guardias si perteneces a su facción.", FontTypeNames.FONTTYPE_INFO)
                                HechizoCasteado = False
                                Exit Sub
                            End If
                        End If
                    End If
                End If
            Else
                Call WriteConsoleMsg(UserIndex, "Este NPC no está paralizado", FontTypeNames.FONTTYPE_INFO)
                HechizoCasteado = False
                Exit Sub
            End If
        End If

        If Hechizos(SpellIndex).Inmoviliza = 1 Then
            If .flags.AfectaParalisis = 0 Then
                If Not PuedeAtacarNPC(UserIndex, NpcIndex, True) Then
                    HechizoCasteado = False
                    Exit Sub
                End If

                If LegalPosMistic(.Pos.map, .Pos.X, .Pos.Y) Then
                    HechizoCasteado = False
                    Exit Sub
                End If

                'Call NPCAtacado(npcIndex, userindex)
                .flags.Inmovilizado = 1
                .flags.Paralizado = 0
                .Contadores.Paralisis = IntervaloParalizado
                Call InfoHechizo(UserIndex)
                HechizoCasteado = True
            Else
                Call WriteConsoleMsg(UserIndex, "El NPC es inmune al hechizo.", FontTypeNames.FONTTYPE_INFO)
            End If
        End If
    End With

    If Hechizos(SpellIndex).Mimetiza = 1 Then
        With UserList(UserIndex)
            If .flags.Mimetizado = 1 Then
                Call WriteConsoleMsg(UserIndex, "Ya te encuentras mimetizado. El hechizo no ha tenido efecto.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            If .flags.AdminInvisible = 1 Then Exit Sub


            If .Clase = eClass.Druid Then
                'copio el char original al mimetizado

                If .flags.Navegando = 0 Then

                    .CharMimetizado.body = .Char.body
                    .CharMimetizado.Head = .Char.Head
                    .CharMimetizado.CascoAnim = .Char.CascoAnim
                    .CharMimetizado.ShieldAnim = .Char.ShieldAnim
                    .CharMimetizado.WeaponAnim = .Char.WeaponAnim
                Else

                    If .flags.Muerto = 0 Then
                        .Char.Head = .OrigChar.Head

                        If .Clase = eClass.Pirat Then
                            If .flags.oculto = 1 Then
                                .flags.oculto = 0
                                .Counters.Ocultando = 0
                                Call WriteMensajes(UserIndex, Mensaje_404)
                            End If
                        End If

                        If .Invent.ArmourEqpObjIndex > 0 Then
                            .Char.body = ObjData(.Invent.ArmourEqpObjIndex).Ropaje
                        Else
                            Call DarCuerpoDesnudo(UserIndex)
                        End If

                        If .Invent.EscudoEqpObjIndex > 0 Then .Char.ShieldAnim = ObjData(.Invent.EscudoEqpObjIndex).ShieldAnim
                        If .Invent.WeaponEqpObjIndex > 0 Then .Char.WeaponAnim = GetWeaponAnim(UserIndex, .Invent.WeaponEqpObjIndex)
                        If .Invent.CascoEqpObjIndex > 0 Then .Char.CascoAnim = ObjData(.Invent.CascoEqpObjIndex).CascoAnim
                    Else
                        If criminal(UserIndex) Then
                            .Char.body = iCuerpoMuerto
                            .Char.Head = iCabezaMuerto
                        Else
                            .Char.body = iCuerpoMuerto
                            .Char.Head = iCabezaMuerto
                        End If
                        .Char.ShieldAnim = NingunEscudo
                        .Char.WeaponAnim = NingunArma
                        .Char.CascoAnim = NingunCasco
                    End If

                    .CharMimetizado.body = .Char.body
                    .CharMimetizado.Head = .Char.Head
                    .CharMimetizado.CascoAnim = .Char.CascoAnim
                    .CharMimetizado.ShieldAnim = .Char.ShieldAnim
                    .CharMimetizado.WeaponAnim = .Char.WeaponAnim

                End If

                .flags.Mimetizado = 1
                .flags.Mimetizado_Nick = "-"

                'ahora pongo lo del NPC.
                .Char.body = Npclist(NpcIndex).Char.body
                .Char.Head = Npclist(NpcIndex).Char.Head
                .Char.CascoAnim = NingunCasco
                .Char.ShieldAnim = NingunEscudo
                .Char.WeaponAnim = NingunArma

                Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterChangeNick(.Char.CharIndex, "-"))

            Else
                Call WriteConsoleMsg(UserIndex, "Sólo los druidas pueden mimetizarse con criaturas.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

            Call InfoHechizo(UserIndex)
            HechizoCasteado = True
        End With
    End If

End Sub

Sub HechizoPropNPC(ByVal SpellIndex As Integer, ByVal NpcIndex As Integer, ByVal UserIndex As Integer, ByRef HechizoCasteado As Boolean)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 14/08/2007
'Handles the Spells that afect the Life NPC
'14/08/2007 Pablo (ToxicWaste) - Orden general.
'***************************************************

    Dim Daño As Long
    On Error GoTo Errhandler

    With Npclist(NpcIndex)
        'Salud
        If Hechizos(SpellIndex).SubeHP = 1 Then
            If Npclist(NpcIndex).GiveEXP < 2 Then
                Call WriteConsoleMsg(UserIndex, "No puedes curar a ésta criatura")
                Exit Sub
            End If

            Daño = RandomNumber(Hechizos(SpellIndex).MinHP, Hechizos(SpellIndex).MaxHP)
            Daño = Daño + Porcentaje(Daño, 3 * UserList(UserIndex).Stats.ELV)

            Call InfoHechizo(UserIndex)
            .Stats.MinHP = .Stats.MinHP + Daño
            If .Stats.MinHP > .Stats.MaxHP Then _
               .Stats.MinHP = .Stats.MaxHP
            Call WriteConsoleMsg(UserIndex, "Has curado " & Daño & " puntos de vida a la criatura.", FontTypeNames.FONTTYPE_FIGHT)
            HechizoCasteado = True

2       ElseIf Hechizos(SpellIndex).SubeHP = 2 Then
1           If Not PuedeAtacarNPC(UserIndex, NpcIndex) Then
                HechizoCasteado = False
                Exit Sub
            End If
3           Call NPCAtacado(NpcIndex, UserIndex)
4           Daño = RandomNumber(Hechizos(SpellIndex).MinHP, Hechizos(SpellIndex).MaxHP)
5           Daño = Daño + Porcentaje(Daño, 3 * UserList(UserIndex).Stats.ELV)

6           If Hechizos(SpellIndex).StaffAffected Then
                If UserList(UserIndex).Clase = eClass.Mage Then
                    If UserList(UserIndex).Invent.WeaponEqpObjIndex > 0 Then
7                       Daño = (Daño * (ObjData(UserList(UserIndex).Invent.WeaponEqpObjIndex).StaffDamageBonus + 70)) / 100
                        'Aumenta daño segun el staff-
                        'Daño = (Daño* (70 + BonifBáculo)) / 100
                    Else
                        Daño = Daño * 0.7        'Baja daño a 70% del original
                    End If
                End If
            End If

            'Or UserList(UserIndex).Invent.AnilloEqpObjIndex = FLAUTAELFICA
8           If UserList(UserIndex).Invent.AnilloEqpObjIndex = LAUDELFICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLOMAGICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex = LAUDMAGICO Then
                Daño = Daño * 1.04
            End If

            'daño = daño * ModClase(UserList(UserIndex).Clase).Magia

9           Call InfoHechizo(UserIndex)
            HechizoCasteado = True

            If .flags.Snd2 > 0 Then
                Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessagePlayWave(.flags.Snd2, .Pos.X, .Pos.Y))
            End If

            'Quizas tenga defenza magica el NPC. Pablo (ToxicWaste)
            Daño = Daño - .Stats.defM
            If Daño < 0 Then Daño = 0

            If SpellIndex = 32 Then
                Daño = .Stats.MinHP - 1
            End If

10          .Stats.MinHP = .Stats.MinHP - Daño
11          Call SendData(SendTarget.ToNPCArea, NpcIndex, PrepareMessageCreateDamage(Npclist(NpcIndex).Char.CharIndex, Daño, 255, 0, 0))

            Call WriteConsoleMsg(UserIndex, "¡Le has quitado " & Daño & " puntos de vida a la criatura!", FontTypeNames.FONTTYPE_FIGHT)
            'If UserList(UserIndex).Counters.LeveleandoTick = 0 Then
            '    UserList(UserIndex).Counters.LeveleandoTick = 10
            '    Call WriteBonifStatus(UserIndex)
            'End If

            'Call WriteBonifStatus(UserIndex)
12          Call CalcularDarExp(UserIndex, NpcIndex, Daño)

            If .Stats.MinHP < 1 Then
13              .Stats.MinHP = 0
14              Call MuereNpc(NpcIndex, UserIndex)
            End If
        End If
    End With

    Exit Sub
Errhandler:
    Call LogError("error en NHechiPropNpc en " & Erl & ". err " & Err.Number & " " & Err.Description)
End Sub

Sub InfoHechizo(ByVal UserIndex As Integer)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 25/07/2009
'25/07/2009: ZaMa - Code improvements.
'25/07/2009: ZaMa - Now invisible admins magic sounds are not sent to anyone but themselves
'***************************************************
    On Error GoTo Errhandler

    Dim SpellIndex As Integer
    Dim tUser As Integer
    Dim tNPC As Integer

1   With UserList(UserIndex)
2       SpellIndex = .flags.Hechizo
3       tUser = .flags.TargetUser
4       tNPC = .flags.TargetNPC

5       Call DecirPalabrasMagicas(Hechizos(SpellIndex).PalabrasMagicas, UserIndex)

6       If tUser > 0 Then
            ' Los admins invisibles no producen sonidos ni fx's
7           If .flags.AdminInvisible = 1 And UserIndex = tUser Then
                If Hechizos(SpellIndex).FXgrh Then
8                   Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageCreateFX(UserList(tUser).Char.CharIndex, Hechizos(SpellIndex).FXgrh, Hechizos(SpellIndex).loops))
                End If
                If Hechizos(SpellIndex).WAV Then
9                   Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(Hechizos(SpellIndex).WAV, UserList(tUser).Pos.X, UserList(tUser).Pos.Y))
                End If
            Else
10              If Hechizos(SpellIndex).GrhTravel > 0 And tNPC > 0 Then
                    If Npclist(tNPC).Char.CharIndex > 0 Then
11                      Call SendData(SendTarget.ToNPCArea, tNPC, PrepareMessageCreateProjectile(UserList(UserIndex).Char.CharIndex, Npclist(tNPC).Char.CharIndex, Hechizos(SpellIndex).GrhTravel))
                    End If
                End If
                If Hechizos(SpellIndex).FXgrh Then
13                  Call SendData(SendTarget.ToPCArea, tUser, PrepareMessageCreateFX(UserList(tUser).Char.CharIndex, Hechizos(SpellIndex).FXgrh, Hechizos(SpellIndex).loops))
                End If
                If Hechizos(SpellIndex).WAV Then
14                  Call SendData(SendTarget.ToPCArea, tUser, PrepareMessagePlayWave(Hechizos(SpellIndex).WAV, UserList(tUser).Pos.X, UserList(tUser).Pos.Y))        'Esta linea faltaba. Pablo (ToxicWaste)
                End If
            End If
15      ElseIf tNPC > 0 Then
16          If Hechizos(SpellIndex).GrhTravel > 0 Then
17              Call SendData(SendTarget.ToNPCArea, tNPC, PrepareMessageCreateProjectile(UserList(UserIndex).Char.CharIndex, Npclist(tNPC).Char.CharIndex, Hechizos(SpellIndex).GrhTravel))
18          End If
            If Hechizos(SpellIndex).FXgrh Then
19              Call SendData(SendTarget.ToNPCArea, tNPC, PrepareMessageCreateFX(Npclist(tNPC).Char.CharIndex, Hechizos(SpellIndex).FXgrh, Hechizos(SpellIndex).loops))
            End If
            If Hechizos(SpellIndex).WAV Then
20              Call SendData(SendTarget.ToNPCArea, tNPC, PrepareMessagePlayWave(Hechizos(SpellIndex).WAV, Npclist(tNPC).Pos.X, Npclist(tNPC).Pos.Y))
            End If
        End If

        If tUser > 0 Then
            If UserIndex <> tUser Then
                If Len(Hechizos(SpellIndex).HechizeroMsg) Then
                    If .showName And .flags.EnEvento = 3 Then
                        Call WriteConsoleMsg(UserIndex, Hechizos(SpellIndex).HechizeroMsg & " alguien.", FontTypeNames.FONTTYPE_FIGHT)
                    Else
                        Call WriteConsoleMsg(UserIndex, Hechizos(SpellIndex).HechizeroMsg & " " & UserList(tUser).Name, FontTypeNames.FONTTYPE_FIGHT)
                    End If

                    Call WriteConsoleMsg(tUser, IIf(.flags.EnEvento = 3, "Alguien", .Name) & " " & Hechizos(SpellIndex).TargetMsg, FontTypeNames.FONTTYPE_FIGHT)
                End If
            Else
                If Len(Hechizos(SpellIndex).PropioMsg) Then
                    Call WriteConsoleMsg(UserIndex, Hechizos(SpellIndex).PropioMsg, FontTypeNames.FONTTYPE_FIGHT)
                End If
            End If

        ElseIf tNPC > 0 Then
            If Len(Hechizos(SpellIndex).HechizeroMsg) Then
                Call WriteConsoleMsg(UserIndex, Hechizos(SpellIndex).HechizeroMsg & " la criatura.", FontTypeNames.FONTTYPE_FIGHT)
            End If
        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en la linea " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Function HechizoPropUsuario(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 28/04/2010
'02/01/2008 Marcos (ByVal) - No permite tirar curar heridas a usuarios muertos.
'28/04/2010: ZaMa - Agrego Restricciones para ciudas respecto al estado atacable.
'***************************************************

    Dim SpellIndex As Integer
    Dim Daño As Long
    Dim TargetIndex As Integer
    On Error GoTo Errhandler

    SpellIndex = UserList(UserIndex).flags.Hechizo
    TargetIndex = UserList(UserIndex).flags.TargetUser

    With UserList(TargetIndex)
1       If .flags.Muerto Then
            Call WriteConsoleMsg(UserIndex, "No puedes lanzar este hechizo a un muerto.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        ' <-------- Aumenta Hambre ---------->
2       If Hechizos(SpellIndex).SubeHam = 1 Then

            Call InfoHechizo(UserIndex)

3           Daño = RandomNumber(Hechizos(SpellIndex).MinHam, Hechizos(SpellIndex).MaxHam)

            .Stats.MinHam = .Stats.MinHam + Daño
            If .Stats.MinHam > .Stats.MaxHam Then _
               .Stats.MinHam = .Stats.MaxHam

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has restaurado " & Daño & " puntos de hambre a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha restaurado " & Daño & " puntos de hambre.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has restaurado " & Daño & " puntos de hambre.", FontTypeNames.FONTTYPE_FIGHT)

            End If

            Call WriteUpdateHungerAndThirst(TargetIndex)

            ' <-------- Quita Hambre ---------->
        ElseIf Hechizos(SpellIndex).SubeHam = 2 Then
4           If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

5           If UserIndex <> TargetIndex Then
6               Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            Else
                Exit Function
            End If

7           Call InfoHechizo(UserIndex)

8           Daño = RandomNumber(Hechizos(SpellIndex).MinHam, Hechizos(SpellIndex).MaxHam)

9           .Stats.MinHam = .Stats.MinHam - Daño

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has quitado " & Daño & " puntos de hambre a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha quitado " & Daño & " puntos de hambre.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has quitado " & Daño & " puntos de hambre.", FontTypeNames.FONTTYPE_FIGHT)

            End If

            If .Stats.MinHam < 1 Then
                .Stats.MinHam = 0
                .flags.Hambre = 1
            End If

            Call WriteUpdateHungerAndThirst(TargetIndex)
        End If

        ' <-------- Aumenta Sed ---------->
        If Hechizos(SpellIndex).SubeSed = 1 Then

            Call InfoHechizo(UserIndex)

            Daño = RandomNumber(Hechizos(SpellIndex).MinSed, Hechizos(SpellIndex).MaxSed)

            .Stats.MinAGU = .Stats.MinAGU + Daño
            If .Stats.MinAGU > .Stats.MaxAGU Then _
               .Stats.MinAGU = .Stats.MaxAGU

            Call WriteUpdateHungerAndThirst(TargetIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has restaurado " & Daño & " puntos de sed a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha restaurado " & Daño & " puntos de sed.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has restaurado " & Daño & " puntos de sed.", FontTypeNames.FONTTYPE_FIGHT)

            End If


            ' <-------- Quita Sed ---------->
        ElseIf Hechizos(SpellIndex).SubeSed = 2 Then

            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

            Call InfoHechizo(UserIndex)

            Daño = RandomNumber(Hechizos(SpellIndex).MinSed, Hechizos(SpellIndex).MaxSed)

            .Stats.MinAGU = .Stats.MinAGU - Daño

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has quitado " & Daño & " puntos de sed a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha quitado " & Daño & " puntos de sed.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has quitado " & Daño & " puntos de sed.", FontTypeNames.FONTTYPE_FIGHT)

            End If

            If .Stats.MinAGU < 1 Then
                .Stats.MinAGU = 0
                .flags.Sed = 1
            End If

            Call WriteUpdateHungerAndThirst(TargetIndex)

        End If

        ' <-------- Aumenta Agilidad ---------->
        If Hechizos(SpellIndex).SubeAgilidad = 1 Then

            ' Chequea si el status permite ayudar al otro usuario
            If Not CanSupportUser(UserIndex, TargetIndex) Then Exit Function

            Call InfoHechizo(UserIndex)
            Daño = RandomNumber(Hechizos(SpellIndex).MinAgilidad, Hechizos(SpellIndex).MaxAgilidad)

            .flags.DuracionEfecto = 2000
            .Stats.UserAtributos(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad) + Daño
            If .Stats.UserAtributos(eAtributos.Agilidad) > MinimoInt(MAXATRIBUTOS, .Stats.UserAtributosBackUP(Agilidad) * 2) Then _
               .Stats.UserAtributos(eAtributos.Agilidad) = MinimoInt(MAXATRIBUTOS, .Stats.UserAtributosBackUP(Agilidad) * 2)

            .flags.TomoPocion = True
            Call WriteUpdateDexterity(TargetIndex)

            ' <-------- Quita Agilidad ---------->
        ElseIf Hechizos(SpellIndex).SubeAgilidad = 2 Then

            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

            Call InfoHechizo(UserIndex)

            .flags.TomoPocion = True
            Daño = RandomNumber(Hechizos(SpellIndex).MinAgilidad, Hechizos(SpellIndex).MaxAgilidad)
            .flags.DuracionEfecto = 700
            .Stats.UserAtributos(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad) - Daño
            If .Stats.UserAtributos(eAtributos.Agilidad) < MINATRIBUTOS Then .Stats.UserAtributos(eAtributos.Agilidad) = MINATRIBUTOS

            Call WriteUpdateDexterity(TargetIndex)
        End If

        ' <-------- Aumenta Fuerza ---------->
        If Hechizos(SpellIndex).SubeFuerza = 1 Then

            ' Chequea si el status permite ayudar al otro usuario
            If Not CanSupportUser(UserIndex, TargetIndex) Then Exit Function

            Call InfoHechizo(UserIndex)
            Daño = RandomNumber(Hechizos(SpellIndex).MinFuerza, Hechizos(SpellIndex).MaxFuerza)

            .flags.DuracionEfecto = 2000

            .Stats.UserAtributos(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza) + Daño
            If .Stats.UserAtributos(eAtributos.Fuerza) > MinimoInt(MAXATRIBUTOS, .Stats.UserAtributosBackUP(Fuerza) * 2) Then _
               .Stats.UserAtributos(eAtributos.Fuerza) = MinimoInt(MAXATRIBUTOS, .Stats.UserAtributosBackUP(Fuerza) * 2)

            .flags.TomoPocion = True
            Call WriteUpdateStrenght(TargetIndex)

            ' <-------- Quita Fuerza ---------->
        ElseIf Hechizos(SpellIndex).SubeFuerza = 2 Then

            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

            Call InfoHechizo(UserIndex)

            .flags.TomoPocion = True

            Daño = RandomNumber(Hechizos(SpellIndex).MinFuerza, Hechizos(SpellIndex).MaxFuerza)
            .flags.DuracionEfecto = 700
            .Stats.UserAtributos(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza) - Daño
            If .Stats.UserAtributos(eAtributos.Fuerza) < MINATRIBUTOS Then .Stats.UserAtributos(eAtributos.Fuerza) = MINATRIBUTOS

            Call WriteUpdateStrenght(TargetIndex)
        End If

        ' <-------- Cura salud ---------->
        If Hechizos(SpellIndex).SubeHP = 1 Then

            'Verifica que el usuario no este muerto
            If .flags.Muerto = 1 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_357
                Exit Function
            End If

            If UserList(TargetIndex).Stats.MaxHP = UserList(TargetIndex).Stats.MinHP Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_443
                Exit Function
            End If

            ' Chequea si el status permite ayudar al otro usuario
            If Not CanSupportUser(UserIndex, TargetIndex) Then Exit Function

            Daño = RandomNumber(Hechizos(SpellIndex).MinHP, Hechizos(SpellIndex).MaxHP)
            Daño = Daño + Porcentaje(Daño, 3 * UserList(UserIndex).Stats.ELV)

            Call InfoHechizo(UserIndex)

            .Stats.MinHP = .Stats.MinHP + Daño
            If .Stats.MinHP > .Stats.MaxHP Then _
               .Stats.MinHP = .Stats.MaxHP

            Call WriteUpdateHP(TargetIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has restaurado " & Daño & " puntos de vida a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha restaurado " & Daño & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has restaurado " & Daño & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)

            End If

            ' <-------- Quita salud (Daña) ---------->
        ElseIf Hechizos(SpellIndex).SubeHP = 2 Then

10          If UserIndex = TargetIndex Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                Exit Function
            End If

11          Daño = RandomNumber(Hechizos(SpellIndex).MinHP, Hechizos(SpellIndex).MaxHP)

12          Daño = Daño + Porcentaje(Daño, 3 * UserList(UserIndex).Stats.ELV)

            ' AUMENTOS
13          If Hechizos(SpellIndex).StaffAffected Then
14              If UserList(UserIndex).Clase = eClass.Mage Then
15                  If UserList(UserIndex).Invent.WeaponEqpObjIndex > 0 Then
                        Daño = (Daño * (ObjData(UserList(UserIndex).Invent.WeaponEqpObjIndex).StaffDamageBonus + 70)) / 100
                    Else
                        Daño = Daño * 0.7    '0.7        'Baja daño a 70% del original
                    End If
                End If
            End If

            If UserList(UserIndex).Invent.AnilloEqpObjIndex = LAUDMAGICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex = LAUDELFICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex2 = LAUDELFICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex2 = LAUDELFICO Then    'UserList(userindex).Clase = eClass.Bard Then
                Daño = Daño * CONFIG_INI_BARDODMGMULTIPLIER    '1.05
            End If

            If UserList(UserIndex).Invent.AnilloEqpObjIndex = ANILLOMAGICO Or UserList(UserIndex).Invent.AnilloEqpObjIndex2 = ANILLOMAGICO Then
17              Daño = Daño * CONFIG_INI_DRUIDADMGMULTIPLIER    '1.04
            End If


            ' DEFENSAS
            If (.Invent.CascoEqpObjIndex > 0) Then        'cascos antimagia
16              Daño = Daño - RandomNumber(ObjData(.Invent.CascoEqpObjIndex).DefensaMagicaMin, ObjData(.Invent.CascoEqpObjIndex).DefensaMagicaMax)
            End If
            If (.Invent.AnilloEqpObjIndex2 > 0) Then        'anillos
18              Daño = Daño - RandomNumber(ObjData(.Invent.AnilloEqpObjIndex2).DefensaMagicaMin, ObjData(.Invent.AnilloEqpObjIndex2).DefensaMagicaMax)
            End If
            ' / DEFENSAS

23          If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            Call SubirSkill(TargetIndex, eSkill.ResistenciaMagica, True)

            If UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) > 0 Then
                'daño = Int(daño - (Int(daño * UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica)) / 2700))
                Daño = Daño - (Daño * UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) / 2000)
                'Dim getResistenciaMagica As Integer
                'If UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) = 0 Then
                '    getResistenciaMagica = 0
                'ElseIf UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 31 Then
                '    getResistenciaMagica = 0.01
                'ElseIf UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 61 Then
                '    getResistenciaMagica = 0.02
                'ElseIf UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 91 Then
                '    getResistenciaMagica = 0.03
                'ElseIf UserList(TargetIndex).Stats.UserSkills(eSkill.ResistenciaMagica) < 100 Then
                '    getResistenciaMagica = 0.04
                'Else
                '    getResistenciaMagica = 0.05
                'End If
                'daño = daño - (daño * getResistenciaMagica)
            End If

            If Daño < 0 Then Daño = 1

            If UserIndex <> TargetIndex Then
29              Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

30          Call InfoHechizo(UserIndex)

            .Stats.MinHP = .Stats.MinHP - Daño
            Call SubirSkill(TargetIndex, eSkill.ResistenciaMagica, True)

            Call WriteUpdateHP(TargetIndex)
36          Call SendData(SendTarget.ToPCArea, TargetIndex, PrepareMessageCreateDamage(UserList(TargetIndex).Char.CharIndex, Daño, 255, 0, 0))
            Call WriteConsoleMsg(UserIndex, "Le has quitado " & Daño & " puntos de quitado a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
            Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha quitado " & Daño & " puntos de vida.", FontTypeNames.FONTTYPE_FIGHT)


            'Muere
31          If .Stats.MinHP < 1 Then

                'Store it!
                Call Statistics.StoreFrag(UserIndex, TargetIndex)
                Call ContarMuerte(TargetIndex, UserIndex)

                .Stats.MinHP = 0
32              Call ActStats(TargetIndex, UserIndex)
33              Call UserDie(TargetIndex, Not EsGM(UserIndex))
            End If

        End If

        ' <-------- Aumenta Mana ---------->
        If Hechizos(SpellIndex).SubeMana = 1 Then

            Call InfoHechizo(UserIndex)
            .Stats.MinMAN = .Stats.MinMAN + Daño
            If .Stats.MinMAN > .Stats.MaxMAN Then _
               .Stats.MinMAN = .Stats.MaxMAN

            Call WriteUpdateMana(TargetIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has restaurado " & Daño & " puntos de maná a " & .Name & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, UserList(UserIndex).Name & " te ha restaurado " & Daño & " puntos de maná.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has restaurado " & Daño & " puntos de maná.", FontTypeNames.FONTTYPE_FIGHT)
            End If


            ' <-------- Quita Mana ---------->
        ElseIf Hechizos(SpellIndex).SubeMana = 2 Then
            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

            Call InfoHechizo(UserIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has quitado " & Daño & " puntos de mana a " & IIf(.flags.EnEvento = 3, "un participante", .Name) & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, IIf(UserList(UserIndex).flags.EnEvento = 3, "un participante", UserList(UserIndex).Name) & " te ha quitado " & Daño & " puntos de mana.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has quitado " & Daño & " puntos de maná.", FontTypeNames.FONTTYPE_FIGHT)

            End If

            .Stats.MinMAN = .Stats.MinMAN - Daño
            If .Stats.MinMAN < 1 Then .Stats.MinMAN = 0

            Call WriteUpdateMana(TargetIndex)

        End If

        ' <-------- Aumenta Stamina ---------->
        If Hechizos(SpellIndex).SubeSta = 1 Then
            Call InfoHechizo(UserIndex)
            .Stats.minSta = .Stats.minSta + Daño
            If .Stats.minSta > .Stats.MaxSta Then _
               .Stats.minSta = .Stats.MaxSta

            Call WriteUpdateSta(TargetIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has restaurado " & Daño & " puntos de energía a " & .Name & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, UserList(UserIndex).Name & " te ha restaurado " & Daño & " puntos de energía.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has restaurado " & Daño & " puntos de energía.", FontTypeNames.FONTTYPE_FIGHT)
            End If

            ' <-------- Quita Stamina ---------->
        ElseIf Hechizos(SpellIndex).SubeSta = 2 Then
            If Not PuedeAtacar(UserIndex, TargetIndex) Then Exit Function

            If UserIndex <> TargetIndex Then
                Call UsuarioAtacadoPorUsuario(UserIndex, TargetIndex)
            End If

            Call InfoHechizo(UserIndex)

            If UserIndex <> TargetIndex Then
                Call WriteConsoleMsg(UserIndex, "Le has quitado " & Daño & " puntos de energía a " & .Name & ".", FontTypeNames.FONTTYPE_FIGHT)
                Call WriteConsoleMsg(TargetIndex, UserList(UserIndex).Name & " te ha quitado " & Daño & " puntos de energía.", FontTypeNames.FONTTYPE_FIGHT)
            Else
                Call WriteConsoleMsg(UserIndex, "Te has quitado " & Daño & " puntos de energía.", FontTypeNames.FONTTYPE_FIGHT)
            End If

            .Stats.minSta = .Stats.minSta - Daño

            If .Stats.minSta < 1 Then .Stats.minSta = 0

            Call WriteUpdateSta(TargetIndex)

        End If
    End With

    HechizoPropUsuario = True

    'Call Flushbuffer(TargetIndex)


    Exit Function
Errhandler:
    Call LogError("error en HechizoPropusuario en " & Erl & ". err " & Err.Number & " " & Err.Description)

End Function

Public Function CanSupportUser(ByVal CasterIndex As Integer, ByVal TargetIndex As Integer, _
                               Optional ByVal DoCriminal As Boolean = False) As Boolean
'***************************************************
'Author: ZaMa
'Last Modification: 28/04/2010
'Checks if caster can cast support magic on target user.
'***************************************************

    On Error GoTo Errhandler

    With UserList(CasterIndex)

        ' @@ Los GM, todo valido pa
        If .flags.Privilegios >= PlayerType.SemiDios Then CanSupportUser = True: Exit Function

        ' Te podes curar a vos mismo
        If CasterIndex = TargetIndex Then
            CanSupportUser = True
            Exit Function
        End If

        ' No podes ayudar si estas en consulta
        If .flags.EnConsulta Then
            Call WriteConsoleMsg(CasterIndex, "No puedes ayudar usuarios mientras estas en consulta.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        ' Si estas en la arena, esta todo permitido
        If TriggerZonaPelea(CasterIndex, TargetIndex) = TRIGGER6_PERMITE Then
            CanSupportUser = True
            Exit Function
        End If

5       If .flags.EnEvento = 3 Then
6           Call WriteConsoleMsg(CasterIndex, NOMBRE_TORNEO_ACTUAL & "Estás en un evento!", FontTypeNames.FONTTYPE_FIGHT)
            Exit Function
        End If

        If .flags.EnEvento = 2 Then
            If iTorneo2vs2.Resu = False Then
                Call WriteConsoleMsg(CasterIndex, NOMBRE_TORNEO_ACTUAL & "DESHABILITADO!", FontTypeNames.FONTTYPE_FIGHT)
                Exit Function
            End If
        End If


        ' Victima criminal?
        If criminal(TargetIndex) Then

            ' Casteador Ciuda?
            If Not criminal(CasterIndex) Then

                ' Armadas no pueden ayudar
                If EsArmada(CasterIndex) Then
                    Call WriteConsoleMsg(CasterIndex, "Los miembros del ejército real no pueden ayudar a los criminales.", FontTypeNames.FONTTYPE_INFO)
                    Exit Function
                End If

                ' Si el ciuda tiene el seguro puesto no puede ayudar
                If .flags.Seguro Then
                    WriteMensajes CasterIndex, e_Mensajes.Mensaje_277
                    Exit Function
                Else
                    ' Penalizacion
                    If DoCriminal Then
                        Call VolverCriminal(CasterIndex)
                    Else
                        Call DisNobAuBan(CasterIndex, .Reputacion.NobleRep * 0.5, 10000)
                    End If
                End If
            End If

            ' Victima ciuda o army
        Else
            ' Casteador es caos? => No Pueden ayudar ciudas
            If EsCaos(CasterIndex) Then
                Call WriteConsoleMsg(CasterIndex, "Los miembros de la legión oscura no pueden ayudar a los ciudadanos.", FontTypeNames.FONTTYPE_INFO)
                Exit Function

                ' Casteador ciuda/army?
            ElseIf Not criminal(CasterIndex) Then



            End If
        End If
    End With

    CanSupportUser = True

    Exit Function

Errhandler:
    Call LogError("Error en CanSupportUser, Error: " & Err.Number & " - " & Err.Description & _
                " CasterIndex: " & CasterIndex & ", TargetIndex: " & TargetIndex)

End Function

Sub UpdateUserHechizos(ByVal UpdateAll As Boolean, ByVal UserIndex As Integer, ByVal Slot As Byte)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Byte

    With UserList(UserIndex)
        'Actualiza un solo slot
        If Not UpdateAll Then
            'Actualiza el inventario
            If .Stats.UserHechizos(Slot) > 0 Then
                Call ChangeUserHechizo(UserIndex, Slot, .Stats.UserHechizos(Slot))
            Else
                Call ChangeUserHechizo(UserIndex, Slot, 0)
            End If
        Else
            'Actualiza todos los slots
            For LoopC = 1 To MAXUSERHECHIZOS
                'Actualiza el inventario
                If .Stats.UserHechizos(LoopC) > 0 Then
                    Call ChangeUserHechizo(UserIndex, LoopC, .Stats.UserHechizos(LoopC))
                Else
                    Call ChangeUserHechizo(UserIndex, LoopC, 0)
                End If
            Next LoopC
        End If
    End With

End Sub

Sub ChangeUserHechizo(ByVal UserIndex As Integer, ByVal Slot As Byte, ByVal Hechizo As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    UserList(UserIndex).Stats.UserHechizos(Slot) = Hechizo

    If Hechizo > 0 And Hechizo < NumeroHechizos + 1 Then
        Call WriteChangeSpellSlot(UserIndex, Slot)
    Else
        Call WriteChangeSpellSlot(UserIndex, Slot)
    End If

End Sub


Public Sub DesplazarHechizo(ByVal UserIndex As Integer, ByVal Dire As Integer, ByVal HechizoDesplazado As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If (Dire <> 1 And Dire <> -1) Then Exit Sub
    If Not (HechizoDesplazado >= 1 And HechizoDesplazado <= MAXUSERHECHIZOS) Then Exit Sub

    Dim TempHechizo As Integer

    With UserList(UserIndex)
        If Dire = 1 Then        'Mover arriba
            If HechizoDesplazado = 1 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_149
                Exit Sub
            Else
                TempHechizo = .Stats.UserHechizos(HechizoDesplazado)
                .Stats.UserHechizos(HechizoDesplazado) = .Stats.UserHechizos(HechizoDesplazado - 1)
                .Stats.UserHechizos(HechizoDesplazado - 1) = TempHechizo
            End If
        Else        'mover abajo
            If HechizoDesplazado = MAXUSERHECHIZOS Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_149
                Exit Sub
            Else
                TempHechizo = .Stats.UserHechizos(HechizoDesplazado)
                .Stats.UserHechizos(HechizoDesplazado) = .Stats.UserHechizos(HechizoDesplazado + 1)
                .Stats.UserHechizos(HechizoDesplazado + 1) = TempHechizo
            End If
        End If
    End With

End Sub

Public Sub DisNobAuBan(ByVal UserIndex As Integer, NoblePts As Long, BandidoPts As Long)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'disminuye la nobleza NoblePts puntos y aumenta el bandido BandidoPts puntos
    Dim EraCriminal As Boolean
    EraCriminal = criminal(UserIndex)

    With UserList(UserIndex)
        'Si estamos en la arena no hacemos nada
        If MapData(.Pos.map, .Pos.X, .Pos.Y).trigger = 6 Then Exit Sub

        If Not EsGM(UserIndex) Then
            'pierdo nobleza...
            .Reputacion.NobleRep = .Reputacion.NobleRep - NoblePts
            If .Reputacion.NobleRep < 0 Then
                .Reputacion.NobleRep = 0
            End If

            'gano bandido...
            .Reputacion.BandidoRep = .Reputacion.BandidoRep + BandidoPts
            If .Reputacion.BandidoRep > MAXREP Then _
               .Reputacion.BandidoRep = MAXREP
            Call WriteMultiMessage(UserIndex, eMessages.NobilityLost)        'Call WriteNobilityLost(UserIndex)
            If criminal(UserIndex) Then If .faccion.ArmadaReal = 1 Then Call ExpulsarFaccionReal(UserIndex)
        End If

        If Not EraCriminal And criminal(UserIndex) Then
            Call RefreshCharStatus(UserIndex)
        End If
    End With
End Sub


