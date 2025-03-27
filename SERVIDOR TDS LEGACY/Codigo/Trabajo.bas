Attribute VB_Name = "Trabajo"


Option Explicit
Public Const TIEMPO_INICIOMEDITAR As Integer = 680
Private Const GASTO_ENERGIA_TRABAJADOR As Byte = 2
Private Const GASTO_ENERGIA_NO_TRABAJADOR As Byte = 6

Private Function isDebePermanencerOculto(ByRef personaje As User, tiempoActual As Long)

    isDebePermanencerOculto = True

    If personaje.flags.AdminInvisible = 1 Then
        Exit Function
    End If

    ' Hay un tiempo minimo de ocultacion
    If personaje.Counters.TiempoOculto < 3000 Then
        Exit Function
    End If

    Dim maximoTiempo As Long, minimoTiempo As Long, azar As Integer

    If personaje.Clase = eClass.Warrior Then
        maximoTiempo = (personaje.Stats.ELV \ 4) * 1000

        If maximoTiempo <= personaje.Counters.TiempoOculto Then
            isDebePermanencerOculto = False
            Exit Function
        End If
    ElseIf personaje.Clase = eClass.Hunter Then
        If tieneArmaduraCazador(personaje) Then
            Exit Function
        Else
            maximoTiempo = (personaje.Stats.ELV \ 3) * 1000

            If maximoTiempo <= personaje.Counters.TiempoOculto Then
                isDebePermanencerOculto = False
                Exit Function
            End If
        End If
    ElseIf personaje.Clase = eClass.Thief Then
        'personaje.Counters.TiempoOculto = 0
        Dim uSkill As Long

        uSkill = personaje.Stats.UserSkills(eSkill.Ocultarse)

        minimoTiempo = 5000 + uSkill * 370

        If personaje.Counters.TiempoOculto >= minimoTiempo Then

            azar = RandomNumberInt(1, 150)

            If azar > personaje.Stats.UserSkills(eSkill.Ocultarse) Then
                isDebePermanencerOculto = False
            End If

            'If maximoTiempo <= personaje.Counters.TiempoOculto Then
            '    isDebePermanencerOculto = False
            '    Exit Function
            'End If
        End If


    Else
        If personaje.Counters.TiempoOculto >= 5000 Then
            isDebePermanencerOculto = False
        Else


            azar = RandomNumberInt(1, 101)

            If azar > personaje.Stats.UserSkills(eSkill.Ocultarse) Then
                isDebePermanencerOculto = False
            End If
        End If
    End If

End Function

Public Sub DoPermanecerOculto(ByRef personaje As User, tiempo As Long)

    On Error GoTo Errhandler

    ' Tiempo oculto
    personaje.Counters.TiempoOculto = personaje.Counters.TiempoOculto + tiempo

    If isDebePermanencerOculto(personaje, tiempo) = False Then
        If personaje.flags.Navegando = 1 Then
            If personaje.Clase = eClass.Pirat Then
                Call ToogleBoatBody(personaje.UserIndex)    ' Pierde la apariencia de fragata fantasmal
                Call WriteMensajes(personaje.UserIndex, Mensaje_404)
                Call ChangeUserChar(personaje.UserIndex, personaje.Char.body, personaje.Char.Head, personaje.Char.Heading, NingunArma, NingunEscudo, NingunCasco)
            Else
                If personaje.flags.invisible = 0 Then
                    personaje.flags.oculto = 0
                    personaje.Counters.TiempoOculto = 0
                    personaje.Counters.Ocultando = 0
                    WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_23
                    Call UsUaRiOs.SetInvisible(personaje.UserIndex, personaje.Char.CharIndex, personaje.flags.invisible = 1, personaje.flags.oculto = 1)
                End If
            End If

        Else
            personaje.flags.oculto = 0
            personaje.Counters.TiempoOculto = 0
            personaje.Counters.Ocultando = 0
            WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_23
            Call UsUaRiOs.SetInvisible(personaje.UserIndex, personaje.Char.CharIndex, personaje.flags.invisible = 1, personaje.flags.oculto = 1)
        End If
    End If

    Exit Sub

Errhandler:
    Call LogError("Error en Sub DoPermanecerOculto")


End Sub

Public Sub DoOcultarse(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 13/01/2010 (ZaMa)
'Pablo (ToxicWaste): No olvidar agregar IntervaloOculto=500 al Server.ini.
'Modifique la fórmula y ahora anda bien.
'13/01/2010: ZaMa - El pirata se transforma en galeon fantasmal cuando se oculta en agua.
'***************************************************

    On Error GoTo Errhandler

    Dim suerte As Double
    Dim res As Integer
    Dim Skill As Integer

    With UserList(UserIndex)

        Dim ahora As Long
        ahora = GetTickCount

        If .Counters.ultimoIntentoOcultar + 250 > ahora Then
            Exit Sub
        End If

        .Counters.ultimoIntentoOcultar = ahora
        Skill = .Stats.UserSkills(eSkill.Ocultarse)

        suerte = (((0.000002 * Skill - 0.0002) * Skill + 0.0064) * Skill + 0.1124) * 100

        res = RandomNumber(1, 125)

        If res <= suerte Then

            .flags.oculto = 1
            suerte = (-0.000001 * (100 - Skill) ^ 3)
            suerte = suerte + (0.00009229 * (100 - Skill) ^ 2)
            suerte = suerte + (-0.0088 * (100 - Skill))
            suerte = suerte + (0.9571)
            suerte = suerte * IntervaloOculto
            .Counters.TiempoOculto = suerte

            ' No es pirata o es uno sin barca
            If .flags.Navegando = 0 Then
                Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                WriteMensajes UserIndex, e_Mensajes.Mensaje_93

                ' Es un pirata navegando
            Else
                ' Le cambiamos el body a galeon fantasmal
                .Char.body = iFragataFantasmal
                ' Actualizamos clientes
                Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, _
                                    NingunEscudo, NingunCasco)
            End If

            Call SubirSkill(UserIndex, eSkill.Ocultarse, True)
        Else
            '[CDT 17-02-2004]
            If Not .flags.UltimoMensaje = 4 Then
                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_1)
                .flags.UltimoMensaje = 4
            End If
            '[/CDT]

            Call SubirSkill(UserIndex, eSkill.Ocultarse, False)
        End If

        .Counters.Ocultando = .Counters.Ocultando + 1
        .Counters.TiempoOculto = 0
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en Sub DoOcultarse")

End Sub

Public Sub DoNavega(ByVal UserIndex As Integer, ByRef Barco As ObjData, ByVal Slot As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 13/01/2010 (ZaMa)
'***************************************************

    Dim ModNave As Single, needSkills As Byte
    Dim wasInviOrOcu As Byte

    With UserList(UserIndex)
        ModNave = ModNavegacion(.Clase, UserIndex)
        needSkills = .Stats.UserSkills(eSkill.Navegacion)        ''/ ModNave

        wasInviOrOcu = .flags.oculto + .flags.invisible

        If Not EsGM(UserIndex) Then
            If Barco.MinSkill = 35 Then        'barca
                If .Clase = eClass.Fisherman Or .Clase = eClass.Pirat Then
                    If .Stats.UserSkills(eSkill.Navegacion) < Barco.MinSkill Then
                        Call WriteMensajes(UserIndex, Mensaje_408)
                        Exit Sub
                    End If
                Else
                    If .Stats.UserSkills(eSkill.Navegacion) < 70 Then
                        Call WriteMensajes(UserIndex, Mensaje_409)
                        Exit Sub
                    End If
                End If
            ElseIf Barco.MinSkill = 65 Then        'galera
                If Not (.Clase = eClass.Pirat Or .Clase = eClass.Fisherman) Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_157
                    Exit Sub
                End If

                If .Stats.UserSkills(eSkill.Navegacion) < Barco.MinSkill Then
                    Call WriteConsoleMsg(UserIndex, "Para usar este barco necesitas " & Barco.MinSkill & " puntos en navegacion.", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
            End If
        End If

        .Invent.BarcoObjIndex = .Invent.Object(Slot).ObjIndex
        .Invent.BarcoSlot = Slot

        ' No estaba navegando
        If .flags.Navegando = 0 Then

            .Char.Head = 0

            ' No esta muerto
            If .flags.Muerto = 0 Then

                Call ToogleBoatBody(UserIndex)

                If .Clase = eClass.Pirat Then
                    If .flags.oculto = 1 And ((.flags.oculto + .flags.invisible) <> wasInviOrOcu) Then
                        .flags.oculto = 0
                        Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_23
                    End If
                Else

                    If .flags.invisible = 0 And ((.flags.oculto + .flags.invisible) <> wasInviOrOcu) Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_23
                        Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                    End If
                End If

                ' Esta muerto
            Else
                .Char.body = iFragataFantasmal
                .Char.ShieldAnim = NingunEscudo
                .Char.WeaponAnim = NingunArma
                .Char.CascoAnim = NingunCasco
            End If

            ' Comienza a navegar
            .flags.Navegando = 1

            ' Estaba navegando
        Else
            If .flags.Navegando = 1 Then

                If .Invent.WeaponEqpObjIndex = RED_PESCA Then
                    If UserList(UserIndex).Invent.BarcoObjIndex Then
                        If ObjData(UserList(UserIndex).Invent.BarcoObjIndex).Ropaje = iGalera Then
                            If UserList(UserIndex).Invent.WeaponEqpObjIndex Then
                                Call Desequipar(UserIndex, UserList(UserIndex).Invent.WeaponEqpSlot, True)
                            End If
                        End If
                    End If
                End If

                If Not EsGM(UserIndex) Then
                    If (HayAgua(.Pos.map, .Pos.X + 1, .Pos.Y) = False Or HayAgua(.Pos.map, .Pos.X - 1, .Pos.Y) = False Or HayAgua(.Pos.map, .Pos.X, .Pos.Y + 1) = False Or HayAgua(.Pos.map, .Pos.X, .Pos.Y - 1) = False) Then
                        'ds
                    ElseIf (HayAgua(.Pos.map, .Pos.X + 1, .Pos.Y) = False And HayAgua(.Pos.map, .Pos.X - 1, .Pos.Y) = False And HayAgua(.Pos.map, .Pos.X, .Pos.Y + 1) = False And HayAgua(.Pos.map, .Pos.X, .Pos.Y - 1) = False) Then
                        'l
                    Else
                        Call WriteMensajes(UserIndex, Mensaje_410)
                        Exit Sub
                    End If
                End If

                If .flags.Mimetizado = 0 Then
                    ' No esta muerto
                    If .flags.Muerto = 0 Then
                        .Char.Head = .OrigChar.Head

                        If .Clase = eClass.Pirat Then
                            If .flags.oculto = 1 Then
                                ' Al desequipar barca, perdió el ocultar
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

                        If .Invent.EscudoEqpObjIndex > 0 Then _
                           .Char.ShieldAnim = ObjData(.Invent.EscudoEqpObjIndex).ShieldAnim
                        If .Invent.WeaponEqpObjIndex > 0 Then _
                           .Char.WeaponAnim = GetWeaponAnim(UserIndex, .Invent.WeaponEqpObjIndex)
                        If .Invent.CascoEqpObjIndex > 0 Then _
                           .Char.CascoAnim = ObjData(.Invent.CascoEqpObjIndex).CascoAnim

                        ' Esta muerto
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
                End If

                ' Termina de navegar
                .flags.Navegando = 0

                'Dim i As Long, npcNum As Integer, npcIndex As Integer
                'Dim auxPos As WorldPos

                'auxPos = .Pos
                'auxPos.X = auxPos.X + 1
                'auxPos.Y = auxPos.Y + 1

                'For i = 1 To MAXMASCOTAS
                'npcIndex = UserList(UserIndex).MascotasIndex(i)
                'If npcIndex > 0 Then
                'If i = 1 Or i = 2 Then auxPos.Y = auxPos.Y + 1
                'npcNum = Npclist(npcIndex).Numero
                'Call QuitarMascota(UserIndex, npcIndex)
                'Call QuitarNPC(npcIndex)

                '.MascotasIndex(i) = SpawnNpc(npcNum, auxPos, False, False, .Char.Heading)
                '.NroMascotas = .NroMascotas + 1
                'End If
                'Next i

            Else
                Call WriteMensajes(UserIndex, Mensaje_410)

                Exit Sub
            End If
        End If

        ' Actualizo clientes
        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
    End With

    Call WriteNavigateToggle(UserIndex)

End Sub

Public Sub FundirMineral(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    With UserList(UserIndex)
        If .flags.TargetObjInvIndex > 0 Then

            If ObjData(.flags.TargetObjInvIndex).OBJType = eOBJType.otMinerales And _
               ObjData(.flags.TargetObjInvIndex).MinSkill <= .Stats.UserSkills(eSkill.Mineria) / ModFundicion(.Clase) Then
                Call DoLingotes(UserIndex)
            Else
                WriteMensajes UserIndex, e_Mensajes.Mensaje_95
            End If

        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en FundirMineral. Error " & Err.Number & " : " & Err.Description)

End Sub

Public Sub FundirArmas(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    With UserList(UserIndex)
        If .flags.TargetObjInvIndex > 0 Then
            If ObjData(.flags.TargetObjInvIndex).OBJType = eOBJType.otWeapon Then
                If ObjData(.flags.TargetObjInvIndex).SkHerreria <= .Stats.UserSkills(eSkill.Herreria) / ModHerreriA(.Clase) Then
                    Call DoFundir(UserIndex)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_411)
                End If
            End If
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en FundirArmas. Error " & Err.Number & " : " & Err.Description)
End Sub

Function TieneObjetos(ByVal ItemIndex As Integer, ByVal Cant As Long, ByVal UserIndex As Integer) As Boolean

    Dim i As Long
    Dim Total As Long
    For i = 1 To UserList(UserIndex).CurrentInventorySlots
        If UserList(UserIndex).Invent.Object(i).ObjIndex = ItemIndex Then
            Total = Total + UserList(UserIndex).Invent.Object(i).Amount
        End If
    Next i

    If Cant <= Total Then
        TieneObjetos = True
        Exit Function
    End If

End Function

Public Sub QuitarObjetos(ByVal ItemIndex As Integer, ByVal Cant As Long, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 05/08/09
'05/08/09: Pato - Cambie la funcion a procedimiento ya que se usa como procedimiento siempre, y fixie el bug 2788199
'***************************************************

    Dim i As Long
    For i = 1 To UserList(UserIndex).CurrentInventorySlots
        With UserList(UserIndex).Invent.Object(i)
            If .ObjIndex = ItemIndex Then
                If .Amount <= Cant And .Equipped = 1 Then Call Desequipar(UserIndex, i, True)

                .Amount = .Amount - Cant
                If .Amount <= 0 Then
                    Cant = Abs(.Amount)
                    'UserList(UserIndex).Invent.NroItems = UserList(UserIndex).Invent.NroItems - 1
                    .Amount = 0
                    .ObjIndex = 0
                Else
                    Cant = 0
                End If

                Call UpdateUserInv(False, UserIndex, i)

                If Cant = 0 Then Exit Sub
            End If
        End With
    Next i

End Sub
Public Sub QuitarObjetosBove(ByVal ItemIndex As Integer, ByVal Cant As Long, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 27/07/2012 - ^[GS]^
'***************************************************

    Dim i As Long

    For i = 1 To MAX_BANCOINVENTORY_SLOTS

        With UserList(UserIndex).BancoInvent.Object(i)

            If .ObjIndex = ItemIndex Then

                .Amount = .Amount - Cant

                If .Amount < 1 Then
                    Cant = Abs(.Amount)
                    'UserList(UserIndex).BancoInvent.NroItems = UserList(UserIndex).BancoInvent.NroItems - 1
                    .Amount = 0
                    .ObjIndex = 0
                    .Equipped = 0
                Else
                    Cant = 0
                End If

                Call UpdateBanUserInv(False, UserIndex, i)

                If Cant = 0 Then Exit Sub
            End If
        End With
    Next i

End Sub


Sub HerreroQuitarMateriales(ByVal UserIndex As Integer, ByVal ItemIndex As Integer, ByVal CantidadItems As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Ahora considera la cantidad de items a construir
'***************************************************
    With ObjData(ItemIndex)
        If .LingH > 0 Then Call QuitarObjetos(LingoteHierro, .LingH * CantidadItems, UserIndex)
        If .LingP > 0 Then Call QuitarObjetos(LingotePlata, .LingP * CantidadItems, UserIndex)
        If .LingO > 0 Then Call QuitarObjetos(LingoteOro, .LingO * CantidadItems, UserIndex)
    End With
End Sub

Sub CarpinteroQuitarMateriales(ByVal UserIndex As Integer, ByVal ItemIndex As Integer, ByVal CantidadItems As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Ahora quita tambien madera de tejo
'***************************************************
    With ObjData(ItemIndex)
        If .Madera > 0 Then Call QuitarObjetos(Leña, .Madera * CantidadItems, UserIndex)
        If .MaderaDeTejo > 0 Then Call QuitarObjetos(LeñaTejo, .MaderaDeTejo * CantidadItems, UserIndex)
    End With
End Sub

Function CarpinteroTieneMateriales(ByVal UserIndex As Integer, ByVal ItemIndex As Integer, ByVal cantidad As Integer, Optional ByVal ShowMsg As Boolean = False) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Agregada validacion a madera de tejo.
'16/11/2009: ZaMa - Ahora considera la cantidad de items a construir
'***************************************************

    With ObjData(ItemIndex)
        If .Madera > 0 Then
            If Not TieneObjetos(Leña, .Madera * cantidad, UserIndex) Then
                If ShowMsg Then WriteMensajes UserIndex, e_Mensajes.Mensaje_96
                CarpinteroTieneMateriales = False
                Exit Function
            End If
        End If

        If .MaderaDeTejo > 0 Then
            If Not TieneObjetos(LeñaTejo, .MaderaDeTejo * cantidad, UserIndex) Then
                If ShowMsg Then Call WriteMensajes(UserIndex, Mensaje_412)
                CarpinteroTieneMateriales = False
                Exit Function
            End If
        End If

    End With
    CarpinteroTieneMateriales = True

End Function

Function HerreroTieneMateriales(ByVal UserIndex As Integer, ByVal ItemIndex As Integer, ByVal CantidadItems As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Agregada validacion a madera de tejo.
'***************************************************
    With ObjData(ItemIndex)
        If .LingH > 0 Then
            If Not TieneObjetos(LingoteHierro, .LingH * CantidadItems, UserIndex) Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_97
                HerreroTieneMateriales = False
                Exit Function
            End If
        End If
        If .LingP > 0 Then
            If Not TieneObjetos(LingotePlata, .LingP * CantidadItems, UserIndex) Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_98
                HerreroTieneMateriales = False
                Exit Function
            End If
        End If
        If .LingO > 0 Then
            If Not TieneObjetos(LingoteOro, .LingO * CantidadItems, UserIndex) Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_99
                HerreroTieneMateriales = False
                Exit Function
            End If
        End If
    End With
    HerreroTieneMateriales = True
End Function

Public Function PuedeConstruir(ByVal UserIndex As Integer, ByVal ItemIndex As Integer, ByVal CantidadItems As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 24/08/2009
'24/08/2008: ZaMa - Validates if the player has the required skill
'16/11/2009: ZaMa - Validates if the player has the required amount of materials, depending on the number of items to make
'***************************************************
    PuedeConstruir = HerreroTieneMateriales(UserIndex, ItemIndex, CantidadItems) And _
                     Round(UserList(UserIndex).Stats.UserSkills(eSkill.Herreria) / ModHerreriA(UserList(UserIndex).Clase), 0) >= ObjData(ItemIndex).SkHerreria
End Function

Public Function PuedeConstruirHerreria(ByVal ItemIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Dim i As Long

    For i = 1 To UBound(ArmasHerrero)
        If ArmasHerrero(i) = ItemIndex Then
            PuedeConstruirHerreria = True
            Exit Function
        End If
    Next i
    For i = 1 To UBound(ArmadurasHerrero)
        If ArmadurasHerrero(i) = ItemIndex Then
            PuedeConstruirHerreria = True
            Exit Function
        End If
    Next i
    PuedeConstruirHerreria = False
End Function

Public Sub HerreroConstruirItem(ByVal UserIndex As Integer, ByVal ItemIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Implementado nuevo sistema de construccion de items
'***************************************************
    Dim CantidadItems As Integer
    Dim TieneMateriales As Boolean
    Dim OtroUserIndex As Integer

    With UserList(UserIndex)
        If .flags.Comerciando Then
            OtroUserIndex = .ComUsu.DestUsu
            If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
                Call WriteMensajes(UserIndex, Mensaje_413)
                WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129
                Call LimpiarComercioSeguro(UserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
            End If
        End If

        CantidadItems = .Construir.PorCiclo

        If .Construir.cantidad < CantidadItems Then _
           CantidadItems = .Construir.cantidad

        If .Construir.cantidad > 0 Then _
           .Construir.cantidad = .Construir.cantidad - CantidadItems

        If CantidadItems = 0 Then
            Call WriteStopWorking(UserIndex)
            Exit Sub
        End If

        If PuedeConstruirHerreria(ItemIndex) Then

            While CantidadItems > 0 And Not TieneMateriales
                If PuedeConstruir(UserIndex, ItemIndex, CantidadItems) Then
                    TieneMateriales = True
                Else
                    CantidadItems = CantidadItems - 1
                End If
            Wend

            ' Chequeo si puede hacer al menos 1 item
            If Not TieneMateriales Then
                Call WriteMensajes(UserIndex, Mensaje_414)
                Call WriteStopWorking(UserIndex)
                Exit Sub
            End If

            'Sacamos energía
            If .Clase = eClass.Blacksmith Then
                'Chequeamos que tenga los puntos antes de sacarselos
                If .Stats.minSta >= GASTO_ENERGIA_TRABAJADOR Then
                    .Stats.minSta = .Stats.minSta - GASTO_ENERGIA_TRABAJADOR
                    Call WriteUpdateSta(UserIndex)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_415)
                    Exit Sub
                End If
            Else
                'Chequeamos que tenga los puntos antes de sacarselos
                If .Stats.minSta >= GASTO_ENERGIA_NO_TRABAJADOR Then
                    .Stats.minSta = .Stats.minSta - GASTO_ENERGIA_NO_TRABAJADOR
                    Call WriteUpdateSta(UserIndex)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_415)
                    Exit Sub
                End If
            End If

            Call HerreroQuitarMateriales(UserIndex, ItemIndex, CantidadItems)
            ' AGREGAR FX
            If ObjData(ItemIndex).OBJType = eOBJType.otWeapon Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_100
            ElseIf ObjData(ItemIndex).OBJType = eOBJType.otEscudo Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_101
            ElseIf ObjData(ItemIndex).OBJType = eOBJType.otCASCO Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_102
            ElseIf ObjData(ItemIndex).OBJType = eOBJType.otArmadura Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_103
            End If

            Dim MiObj As Obj

            MiObj.Amount = CantidadItems
            MiObj.ObjIndex = ItemIndex
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(.Pos, MiObj)
            End If

            'Log de construcción de Items. Pablo (ToxicWaste) 10/09/07
            'If ObjData(MiObj.ObjIndex).Log = 1 Then
            Call LogDesarrollo(.Name & " ha construído " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name)
            'End If

            Call SubirSkill(UserIndex, eSkill.Herreria, True)
            Call UpdateUserInv(True, UserIndex, 0)
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(MARTILLOHERRERO, .Pos.X, .Pos.Y))

            .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlProleta
            If .Reputacion.PlebeRep > MAXREP Then _
               .Reputacion.PlebeRep = MAXREP

            .Counters.Trabajando = .Counters.Trabajando + 1
        End If
    End With
End Sub

Public Function PuedeConstruirCarpintero(ByVal ItemIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Dim i As Long

    For i = 1 To UBound(ObjCarpintero)
        If ObjCarpintero(i) = ItemIndex Then
            PuedeConstruirCarpintero = True
            Exit Function
        End If
    Next i
    PuedeConstruirCarpintero = False

End Function

Public Sub CarpinteroConstruirItem(ByVal UserIndex As Integer, ByVal ItemIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'24/08/2008: ZaMa - Validates if the player has the required skill
'16/11/2009: ZaMa - Implementado nuevo sistema de construccion de items
'***************************************************
    Dim CantidadItems As Integer
    Dim TieneMateriales As Boolean
    Dim OtroUserIndex As Integer
    With UserList(UserIndex)
        If .flags.Comerciando Then
            OtroUserIndex = .ComUsu.DestUsu

            If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
                Call WriteConsoleMsg(UserIndex, "¡¡Comercio cancelado, no puedes comerciar mientras trabajas!!", FontTypeNames.FONTTYPE_TALK)

                WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129
                Call LimpiarComercioSeguro(UserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
            End If
        End If
        CantidadItems = .Construir.PorCiclo

        If .Construir.cantidad < CantidadItems Then _
           CantidadItems = .Construir.cantidad

        If .Construir.cantidad > 0 Then _
           .Construir.cantidad = .Construir.cantidad - CantidadItems

        If CantidadItems = 0 Then
            Call WriteStopWorking(UserIndex)
            Exit Sub
        End If

        If Round(.Stats.UserSkills(eSkill.Carpinteria) \ ModCarpinteria(.Clase), 0) >= _
           ObjData(ItemIndex).SkCarpinteria And _
           PuedeConstruirCarpintero(ItemIndex) And _
           .Invent.WeaponEqpObjIndex = SERRUCHO_CARPINTERO Then

            ' Calculo cuantos item puede construir
            While CantidadItems > 0 And Not TieneMateriales
                If CarpinteroTieneMateriales(UserIndex, ItemIndex, CantidadItems) Then
                    TieneMateriales = True
                Else
                    CantidadItems = CantidadItems - 1
                End If
            Wend

            ' No tiene los materiales ni para construir 1 item?
            If Not TieneMateriales Then
                ' Para que muestre el mensaje
                Call CarpinteroTieneMateriales(UserIndex, ItemIndex, 1, True)
                Call WriteStopWorking(UserIndex)
                Exit Sub
            End If

            'Sacamos energía
            If .Clase = eClass.Carpenter Then
                'Chequeamos que tenga los puntos antes de sacarselos
                If .Stats.minSta >= GASTO_ENERGIA_TRABAJADOR Then
                    .Stats.minSta = .Stats.minSta - GASTO_ENERGIA_TRABAJADOR
                    Call WriteUpdateSta(UserIndex)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_415)
                    Exit Sub
                End If
            Else
                'Chequeamos que tenga los puntos antes de sacarselos
                If .Stats.minSta >= GASTO_ENERGIA_NO_TRABAJADOR Then
                    .Stats.minSta = .Stats.minSta - GASTO_ENERGIA_NO_TRABAJADOR
                    Call WriteUpdateSta(UserIndex)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_415)
                    Exit Sub
                End If
            End If

            Call CarpinteroQuitarMateriales(UserIndex, ItemIndex, CantidadItems)

            WriteMensajes UserIndex, e_Mensajes.Mensaje_104

            Dim MiObj As Obj
            MiObj.Amount = CantidadItems
            MiObj.ObjIndex = ItemIndex
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(.Pos, MiObj)
            End If

            'Log de construcción de Items. Pablo (ToxicWaste) 10/09/07
            ' If ObjData(MiObj.ObjIndex).Log = 1 Then
            Call LogDesarrollo(.Name & " ha construído " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name)
            ' End If

            Call SubirSkill(UserIndex, eSkill.Carpinteria, True)
            Call UpdateUserInv(True, UserIndex, 0)
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(LABUROCARPINTERO, .Pos.X, .Pos.Y))


            .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlProleta
            If .Reputacion.PlebeRep > MAXREP Then _
               .Reputacion.PlebeRep = MAXREP

            .Counters.Trabajando = .Counters.Trabajando + 1

        ElseIf .Invent.WeaponEqpObjIndex <> SERRUCHO_CARPINTERO Then
            Call WriteConsoleMsg(UserIndex, "Debes tener equipado el serrucho para trabajar.", FontTypeNames.FONTTYPE_INFO)
        End If
    End With
End Sub

Private Function MineralesParaLingote(ByVal Lingote As iMinerales) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Select Case Lingote
    Case iMinerales.hierrocrudo
        MineralesParaLingote = 19
    Case iMinerales.platacruda
        MineralesParaLingote = 25
    Case iMinerales.orocrudo
        MineralesParaLingote = 50
    Case Else
        MineralesParaLingote = 10000
    End Select
End Function


Public Sub DoLingotes(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Implementado nuevo sistema de construccion de items
'***************************************************
'    Call LogTarea("Sub DoLingotes")
    Dim Slot As Integer
    Dim obji As Integer
    Dim CantidadItems As Integer
    Dim TieneMinerales As Boolean
    Dim OtroUserIndex As Integer
    With UserList(UserIndex)
        If .flags.Comerciando Then
            OtroUserIndex = .ComUsu.DestUsu

            If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
                Call WriteConsoleMsg(UserIndex, "¡¡Comercio cancelado, no puedes comerciar mientras trabajas!!", FontTypeNames.FONTTYPE_TALK)

                WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129
                Call LimpiarComercioSeguro(UserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
            End If
        End If

        CantidadItems = MaximoInt(1, CInt((.Stats.ELV / 2)))

        Slot = .flags.TargetObjInvSlot
        obji = .Invent.Object(Slot).ObjIndex

        While CantidadItems > 0 And Not TieneMinerales
            If .Invent.Object(Slot).Amount >= MineralesParaLingote(obji) * CantidadItems Then
                TieneMinerales = True
            Else
                CantidadItems = CantidadItems - 1
            End If
        Wend

        If Not TieneMinerales Or ObjData(obji).OBJType <> eOBJType.otMinerales Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_105

            Exit Sub
        End If

        .Invent.Object(Slot).Amount = .Invent.Object(Slot).Amount - MineralesParaLingote(obji) * CantidadItems
        If .Invent.Object(Slot).Amount < 1 Then
            .Invent.Object(Slot).Amount = 0
            .Invent.Object(Slot).ObjIndex = 0
        End If

        Dim MiObj As Obj
        MiObj.Amount = CantidadItems
        MiObj.ObjIndex = ObjData(.flags.TargetObjInvIndex).LingoteIndex
        If Not MeterItemEnInventario(UserIndex, MiObj) Then
            Call TirarItemAlPiso(.Pos, MiObj)
        End If
        Call UpdateUserInv(False, UserIndex, Slot)
        Call WriteConsoleMsg(UserIndex, "¡Has obtenido " & CantidadItems & " lingote" & _
                                        IIf(CantidadItems = 1, "", "s") & "!", FontTypeNames.FONTTYPE_INFO)

        .Counters.Trabajando = .Counters.Trabajando + 1
    End With
End Sub

Public Sub DoFundir(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 03/06/2010
'03/06/2010 - Pato: Si es el último ítem a fundir y está equipado lo desequipamos.
'11/03/2010 - ZaMa: Reemplazo división por producto para uan mejor performanse.
'***************************************************
    Dim i As Integer
    Dim num As Integer
    Dim Slot As Byte
    Dim Lingotes(2) As Integer
    Dim OtroUserIndex As Integer
    With UserList(UserIndex)
        If .flags.Comerciando Then
            OtroUserIndex = .ComUsu.DestUsu

            If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
                Call WriteConsoleMsg(UserIndex, "¡¡Comercio cancelado, no puedes comerciar mientras trabajas!!", FontTypeNames.FONTTYPE_TALK)

                WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129
                Call LimpiarComercioSeguro(UserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
            End If
        End If
        Slot = .flags.TargetObjInvSlot

        With .Invent.Object(Slot)
            .Amount = .Amount - 1

            If .Amount < 1 Then
                If .Equipped = 1 Then Call Desequipar(UserIndex, Slot, True)

                .Amount = 0
                .ObjIndex = 0
            End If
        End With

        num = RandomNumber(10, 25)

        Lingotes(0) = (ObjData(.flags.TargetObjInvIndex).LingH * num) * 0.01
        Lingotes(1) = (ObjData(.flags.TargetObjInvIndex).LingP * num) * 0.01
        Lingotes(2) = (ObjData(.flags.TargetObjInvIndex).LingO * num) * 0.01

        Dim MiObj(2) As Obj

        For i = 0 To 2
            MiObj(i).Amount = Lingotes(i)
            MiObj(i).ObjIndex = LingoteHierro + i        'Una gran negrada pero práctica
            If MiObj(i).Amount > 0 Then
                If Not MeterItemEnInventario(UserIndex, MiObj(i)) Then
                    Call TirarItemAlPiso(.Pos, MiObj(i))
                End If
                Call UpdateUserInv(True, UserIndex, Slot)
            End If
        Next i

        Call WriteConsoleMsg(UserIndex, "¡Has obtenido el " & num & "% de los lingotes utilizados para la construcción del objeto!", FontTypeNames.FONTTYPE_INFO)

        .Counters.Trabajando = .Counters.Trabajando + 1

    End With

End Sub

Function ModNavegacion(ByVal Clase As eClass, ByVal UserIndex As Integer) As Single
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 27/11/2009
'27/11/2009: ZaMa - A worker can navigate before only if it's an expert fisher
'12/04/2010: ZaMa - Arreglo modificador de pescador, para que navegue con 60 skills.
'***************************************************
    Select Case Clase
    Case eClass.Pirat
        ModNavegacion = 1
    Case eClass.Fisherman
        If UserList(UserIndex).Stats.UserSkills(eSkill.Pesca) = 100 Then
            ModNavegacion = 1
        Else
            ModNavegacion = 2
        End If
    Case Else
        ModNavegacion = 2
    End Select

End Function


Function ModFundicion(ByVal Clase As eClass) As Single
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Select Case Clase
    Case eClass.Miner
        ModFundicion = 1
    Case Else
        ModFundicion = 3
    End Select

End Function

Function ModCarpinteria(ByVal Clase As eClass) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Select Case Clase
    Case eClass.Carpenter
        ModCarpinteria = 1
    Case Else
        ModCarpinteria = 3
    End Select

End Function

Function ModHerreriA(ByVal Clase As eClass) As Single
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Select Case Clase
    Case eClass.Blacksmith
        ModHerreriA = 1
    Case Else
        ModHerreriA = 4
    End Select

End Function

Function ModDomar(ByVal Clase As eClass) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Select Case Clase
    Case eClass.Druid
        ModDomar = 6
    Case eClass.Hunter
        ModDomar = 6
    Case eClass.Cleric
        ModDomar = 7
    Case Else
        ModDomar = 10
    End Select
End Function

Function FreeMascotaType(ByVal UserIndex As Integer) As Integer

    Dim j As Long

    For j = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasType(j) < 1 Then
            FreeMascotaType = j
            Exit Function
        End If
    Next j

End Function

Function FreeMascotaIndex(ByVal UserIndex As Integer) As Integer

    Dim j As Long

    For j = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(j) < 1 Then
            FreeMascotaIndex = j
            Exit Function
        End If
    Next j

End Function

Sub DoDomar(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)
'***************************************************
'Author: Nacho (Integer)
'Last Modification: 01/05/2010
'12/15/2008: ZaMa - Limits the number of the same type of pet to 2.
'02/03/2009: ZaMa - Las criaturas domadas en zona segura, esperan afuera (desaparecen).
'01/05/2010: ZaMa - Agrego bonificacion 11% para domar con flauta magica.
'***************************************************

    On Error GoTo Errhandler

    Dim puntosDomar As Integer
    Dim puntosRequeridos As Integer
    Dim CanStay As Boolean
    Dim petType As Integer
    Dim NroPets As Integer

    If Not EsGM(UserIndex) Then
        If Not UserList(UserIndex).Clase = eClass.Druid Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_434
            Exit Sub
        End If
    End If

1   If Npclist(NpcIndex).MaestroUser = UserIndex Then
2       WriteMensajes UserIndex, e_Mensajes.Mensaje_108
        Exit Sub
    End If

    Dim nroMascotas As Byte
    Dim i As Long

    With UserList(UserIndex)

        For i = 1 To MAXMASCOTAS
            If .MascotasType(i) Then
                nroMascotas = nroMascotas + 1
            End If
        Next i

        If nroMascotas = MAXMASCOTAS Then
            Call WriteConsoleMsg(UserIndex, "Recuerda que tienes 3 mascotas y no puedes domar más criaturas.")
            Call SubirSkill(UserIndex, Domar, True)
            Exit Sub
        End If

3       If nroMascotas < MAXMASCOTAS Then

4           If Npclist(NpcIndex).MaestroNpc > 0 Or Npclist(NpcIndex).MaestroUser > 0 Then
6               WriteMensajes UserIndex, e_Mensajes.Mensaje_109
5               Exit Sub
            End If

7           If Not PuedeDomarMascota(UserIndex, NpcIndex) Then
8               Call WriteConsoleMsg(UserIndex, "No puedes domar más criaturas del mismo tipo.", FontTypeNames.FONTTYPE_INFO)
                Call SubirSkill(UserIndex, Domar, True)
                Exit Sub
            End If

            puntosDomar = CInt(.Stats.UserAtributos(eAtributos.Carisma)) * CInt(.Stats.UserSkills(eSkill.Domar))

            If .Clase = eClass.Druid Then
                puntosDomar = CInt((CInt(.Stats.UserSkills(eSkill.Domar)) * CInt(.Stats.UserAtributos(eAtributos.Carisma))) / 6)
            Else
                puntosDomar = CInt((CInt(.Stats.UserSkills(eSkill.Domar)) * CInt(.Stats.UserAtributos(eAtributos.Carisma))) / 11)
            End If

            puntosRequeridos = Npclist(NpcIndex).flags.Domable

11          If puntosRequeridos <= puntosDomar And RandomNumber(0, 3) = 2 Then

                Dim MascotaType As Integer
                MascotaType = FreeMascotaType(UserIndex)

                If MascotaType < 1 Then
                    Call WriteConsoleMsg(UserIndex, "Solo puedes domar un maximo de 3 mascotas.", FontTypeNames.FONTTYPE_INFO)
                    Call SubirSkill(UserIndex, Domar, True)
                    Exit Sub
                End If

                Dim MascotaIndex As Integer
                MascotaIndex = FreeMascotaIndex(UserIndex)

                If MascotaIndex < 1 Then Exit Sub

                UserList(UserIndex).MascotasType(MascotaType) = Npclist(NpcIndex).Numero
                UserList(UserIndex).MascotasIndex(MascotaIndex) = NpcIndex

                Npclist(NpcIndex).MaestroUser = UserIndex

                Call FollowAmo(NpcIndex)
                Call ReSpawnNpc(Npclist(NpcIndex))

                Npclist(NpcIndex).Contadores.Ataque = GetTickCount

                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_110)        '"La criatura te ha aceptado como su amo."

                '' Es zona segura?
                CanStay = (MapInfo(.Pos.map).pk = True)

                If Not CanStay Then
                    petType = Npclist(NpcIndex).Numero
                    NroPets = UserList(UserIndex).nroMascotas

                    Call QuitarNPC(NpcIndex)

                    UserList(UserIndex).MascotasType(MascotaType) = petType
                    UserList(UserIndex).nroMascotas = NroPets
                Else
                    UserList(UserIndex).nroMascotas = UserList(UserIndex).nroMascotas + 1
                End If
            Else
                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_111)       '"No has logrado domar la criatura."
                .flags.UltimoMensaje = 5
            End If

            ' ++ Es un 30% más dificil si no sos druida.
            If .Clase <> eClass.Druid Then
                If (RandomNumber(0, 3) = 2) Then
                    Call SubirSkill(UserIndex, Domar, True)
                End If
            Else
                Call SubirSkill(UserIndex, Domar, True)
            End If

        Else

            If Not .flags.UltimoMensaje = 5 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_111
                .flags.UltimoMensaje = 5
            End If

        End If

    End With

    Exit Sub

Errhandler:
    Call LogError("Error en DoDomar en " & Erl & " . Error " & Err.Number & " : " & Err.Description)

End Sub

''
' Checks if the user can tames a pet.
'
' @param integer userIndex The user id from who wants tame the pet.
' @param integer NPCindex The index of the npc to tome.
' @return boolean True if can, false if not.
Private Function PuedeDomarMascota(ByVal UserIndex As Integer, ByVal NpcIndex As Integer) As Boolean
'***************************************************
'Author: ZaMa
'This function checks how many NPCs of the same type have
'been tamed by the user.
'Returns True if that amount is less than two.
'***************************************************
    On Error GoTo Errhandler
    Dim i As Long
    Dim numMascotas As Long

1   For i = 1 To MAXMASCOTAS
2       If UserList(UserIndex).MascotasType(i) = Npclist(NpcIndex).Numero Then
3           numMascotas = numMascotas + 1
        End If
    Next i

4   If numMascotas <= 2 Then PuedeDomarMascota = True
    Exit Function
Errhandler:
    Call LogError("error en puededomarmascota en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Sub DoAdminInvisible(ByVal UserIndex As Integer, Optional ByVal update As Boolean = True)
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010 (ZaMa)
'Makes an admin invisible o visible.
'13/07/2009: ZaMa - Now invisible admins' chars are erased from all clients, except from themselves.
'12/01/2010: ZaMa - Los druidas pierden la inmunidad de ser atacados cuando pierden el efecto del mimetismo.
'***************************************************
    On Error GoTo Errhandler

    With UserList(UserIndex)
        If .flags.AdminInvisible = 0 Then
            ' Sacamos el mimetizmo
            If .flags.Mimetizado = 1 Then
                .Char.body = .CharMimetizado.body
                .Char.Head = .CharMimetizado.Head
                .Char.CascoAnim = .CharMimetizado.CascoAnim
                .Char.ShieldAnim = .CharMimetizado.ShieldAnim
                .Char.WeaponAnim = .CharMimetizado.WeaponAnim
                .Counters.Mimetismo = 0
                .flags.Mimetizado = 0
                .flags.Mimetizado_Nick = ""
                .flags.Mimetizado_Color = 0

                ' Se fue el efecto del mimetismo, puede ser atacado por npcs
                .flags.Ignorado = False
            End If

            .flags.AdminInvisible = 1
            .flags.invisible = 1
            .flags.oculto = 1
            .flags.OldBody = .Char.body
            .flags.OldHead = .Char.Head
            '.Char.body = 0
            '.Char.Head = 0

            If update Then
                ' Solo el admin sabe que se hace invi
                Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, True, False))
                'Le mandamos el mensaje para que borre el personaje a los clientes que estén cerca
                Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageCharacterRemove(.Char.CharIndex))
            End If
        Else
            .flags.AdminInvisible = 0
            .flags.invisible = 0
            .flags.oculto = 0
            .Counters.TiempoOculto = 0
            .Char.body = .flags.OldBody
            .Char.Head = .flags.OldHead

            If update Then
                ' Solo el admin sabe que se hace visible
                Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageCharacterChange(.Char.body, .Char.Head, .Char.Heading, _
                                                                                           .Char.CharIndex, .Char.WeaponAnim, .Char.ShieldAnim, .Char.FX, .Char.loops, .Char.CascoAnim))
                Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, False, False))

                'Le mandamos el mensaje para crear el personaje a los clientes que estén cerca
                Call MakeUserChar(True, .Pos.map, UserIndex, .Pos.map, .Pos.X, .Pos.Y, True)
            End If
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en DoAdminInvisible en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Sub TratarDeHacerFogata(ByVal map As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim suerte As Byte
    Dim exito As Byte
    Dim Obj As Obj
    Dim posMadera As WorldPos

    If Not LegalPos(map, X, Y) Then Exit Sub

    With posMadera
        .map = map
        .X = X
        .Y = Y
    End With

    If MapData(map, X, Y).ObjInfo.ObjIndex <> 58 Then
        Call WriteConsoleMsg(UserIndex, "Necesitas clickear sobre leña para hacer ramitas.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    If distancia(posMadera, UserList(UserIndex).Pos) > 2 Then
        WriteMensajes UserIndex, e_Mensajes.Mensaje_5
        Exit Sub
    End If

    If UserList(UserIndex).flags.Muerto = 1 Then
        WriteMensajes UserIndex, e_Mensajes.Mensaje_3
        Exit Sub
    End If

    If MapData(map, X, Y).ObjInfo.Amount < 3 Then
        WriteMensajes UserIndex, e_Mensajes.Mensaje_113
        Exit Sub
    End If

    Dim SupervivenciaSkill As Byte

    SupervivenciaSkill = UserList(UserIndex).Stats.UserSkills(eSkill.Supervivencia)

    If SupervivenciaSkill >= 0 And SupervivenciaSkill < 6 Then
        suerte = 3
    ElseIf SupervivenciaSkill >= 6 And SupervivenciaSkill <= 34 Then
        suerte = 2
    ElseIf SupervivenciaSkill >= 35 Then
        suerte = 1
    End If

    exito = RandomNumber(1, suerte)

    If exito = 1 Then
        Obj.ObjIndex = FOGATA_APAG
        Obj.Amount = MapData(map, X, Y).ObjInfo.Amount \ 3

        WriteMensajes UserIndex, e_Mensajes.Mensaje_114

        Call MakeObj(Obj, map, X, Y)

        'Seteamos la fogata como el nuevo TargetObj del user
        UserList(UserIndex).flags.TargetObj = FOGATA_APAG

        Call SubirSkill(UserIndex, eSkill.Supervivencia, True)
    Else
        '[CDT 17-02-2004]
        If Not UserList(UserIndex).flags.UltimoMensaje = 10 Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_115
            UserList(UserIndex).flags.UltimoMensaje = 10
        End If
        '[/CDT]

        Call SubirSkill(UserIndex, eSkill.Supervivencia, False)
    End If

End Sub

Public Sub DoPescar(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 16/11/2009
'16/11/2009: ZaMa - Implementado nuevo sistema de extraccion.
'***************************************************
    On Error GoTo Errhandler

    Dim suerte As Integer
    Dim res As Integer
    Dim CantidadItems As Integer

    If UserList(UserIndex).Invent.WeaponEqpObjIndex = RED_PESCA Then
        If Not UserList(UserIndex).Clase = eClass.Fisherman Then
            Call WriteConsoleMsg(UserIndex, "Necesitas ser Pescador para poder pescar con la Red de pesca!!")
            Exit Sub
        End If
        'If UserList(UserIndex).Invent.BarcoObjIndex = 0 Then
        '    Call WriteConsoleMsg(UserIndex, "Para pescar con la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
        '    Exit Sub
        'End If
        'If Not ObjData(UserList(UserIndex).Invent.BarcoObjIndex).Ropaje = iGalera Then
        '    Call WriteConsoleMsg(UserIndex, "Para pescar con la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
        '    Exit Sub
        'End If
        If Not hasItemAndEquipped(UserIndex, 475) Then
            Call WriteConsoleMsg(UserIndex, "Para pescar con la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
            Exit Sub
        End If
        If UserList(UserIndex).Stats.UserSkills(eSkill.Supervivencia) < 50 Then
            Call WriteConsoleMsg(UserIndex, "Necesitas al menos 50 puntos en Supervivencia para pescar con la Red de pesca!!")
            Exit Sub
        End If
    End If

    If UserList(UserIndex).Clase = eClass.Fisherman Then
        Call QuitarSta(UserIndex, EsfuerzoPescarPescador)
    Else
        Call QuitarSta(UserIndex, EsfuerzoPescarGeneral)
    End If

    Dim Skill As Integer, pesco As Boolean

    Skill = UserList(UserIndex).Stats.UserSkills(eSkill.Pesca)
    suerte = Int(-0.00125 * Skill * Skill - 0.3 * Skill + 49)

    res = RandomNumber(1, suerte)

    If res <= 6 Then
        Dim MiObj As Obj
        MiObj.ObjIndex = Pescado

        If UserList(UserIndex).Clase = eClass.Fisherman Then

            MiObj.Amount = 1

            Dim factProb As Single
            Select Case UserList(UserIndex).Stats.UserSkills(eSkill.Pesca)
            Case 0 To 10
                factProb = 0.05
            Case 11 To 20
                factProb = 0.1
            Case 21 To 30
                factProb = 0.15
            Case 31 To 40
                factProb = 0.2
            Case 41 To 50
                factProb = 0.25
            Case 51 To 60
                factProb = 0.3
            Case 61 To 70
                factProb = 0.35
            Case 71 To 80
                factProb = 0.4
            Case 81 To 90
                factProb = 0.45
            Case Else
                factProb = 0.5
            End Select

            factProb = factProb + ratePesca

            Dim hasGalera As Boolean
            Dim hasBarca As Boolean

            If UserList(UserIndex).flags.Navegando = 1 Then
                If UserList(UserIndex).Invent.BarcoObjIndex Then
                    If ObjData(UserList(UserIndex).Invent.BarcoObjIndex).Ropaje = iGalera Then
                        'factProb = factProb + 0.3
                        hasGalera = True
                        hasBarca = True
                    ElseIf ObjData(UserList(UserIndex).Invent.BarcoObjIndex).Ropaje = iBarca Then
                        'factProb = factProb + 0.1
                        hasBarca = True
                    End If
                End If
            End If

            If UserList(UserIndex).Invent.WeaponEqpObjIndex = RED_PESCA Then
                factProb = factProb + 0.4
            End If

            res = RandomNumber(1, 100)
            If res <= RandomNumber(1, (90 * factProb)) Then
                MiObj.ObjIndex = PESCADO1
                pesco = True
                If Not MeterItemEnInventario(UserIndex, MiObj) Then
                    Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
                End If
            End If

            res = RandomNumber(1, 100)
            If res <= RandomNumber(1, (31 * factProb)) Then
                MiObj.ObjIndex = PESCADO2
                pesco = True
                If Not MeterItemEnInventario(UserIndex, MiObj) Then
                    Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
                End If
            End If
            If hasBarca Then
                res = RandomNumber(1, 100)
                If res <= RandomNumber(1, (22 * factProb)) Then
                    MiObj.ObjIndex = PESCADO3
                    pesco = True
                    If Not MeterItemEnInventario(UserIndex, MiObj) Then
                        Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
                    End If
                End If

                If hasGalera Then
                    res = RandomNumber(1, 100)
                    If res <= RandomNumber(1, (16 * factProb)) Then
                        MiObj.ObjIndex = PESCADO4
                        pesco = True
                        If Not MeterItemEnInventario(UserIndex, MiObj) Then
                            Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
                        End If
                    End If

                    res = RandomNumber(1, 100)
                    If res <= RandomNumber(1, (4 * factProb)) And UserList(UserIndex).Invent.WeaponEqpObjIndex = RED_PESCA Then
                        MiObj.ObjIndex = PESCADO5
                        pesco = True
                        If Not MeterItemEnInventario(UserIndex, MiObj) Then
                            Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
                        End If
                    End If
                End If

            End If

            If pesco Then
                'If Not UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_118 Then '¡Has pescado algunos peces!
                WriteMensajes UserIndex, e_Mensajes.Mensaje_118
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_PESCAR, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
                UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_118
                'End If
            End If

        Else
            MiObj.Amount = 1
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
            End If

            'If Not UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_118 Then '¡Has pescado algunos peces!
            WriteMensajes UserIndex, e_Mensajes.Mensaje_118
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_PESCAR, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
            '   UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_118
            'End If

        End If

        UserList(UserIndex).Reputacion.PlebeRep = UserList(UserIndex).Reputacion.PlebeRep + vlProleta

        If UserList(UserIndex).Reputacion.PlebeRep > MAXREP Then
            UserList(UserIndex).Reputacion.PlebeRep = MAXREP
        End If

        Call SubirSkill(UserIndex, eSkill.Pesca, True)
    Else

        If Not UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_117 Then    '¡No pescaste nada!
            WriteMensajes UserIndex, e_Mensajes.Mensaje_117
            UserList(UserIndex).flags.UltimoMensaje = e_Mensajes.Mensaje_117
        End If

        Call SubirSkill(UserIndex, eSkill.Pesca, False)
    End If

    UserList(UserIndex).Counters.Trabajando = UserList(UserIndex).Counters.Trabajando + 1

    Exit Sub

Errhandler:
    Call LogError("Error en DoPescar. Error " & Err.Number & " : " & Err.Description)
End Sub

Sub quitarHamYSed(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        Dim prob As Byte
        Dim alter As Byte

        prob = RandomNumber(1, 100)

        If prob > CONFIG_INI_RNDQUITAHAM Then
            .Stats.MinHam = .Stats.MinHam - RandomNumber(1, 5)

            If .Stats.MinHam < 0 Then .Stats.MinHam = 0
            alter = 1
        End If
        prob = RandomNumber(1, 100)

        If prob > CONFIG_INI_RNDQUITASED Then
            .Stats.MinAGU = .Stats.MinAGU - RandomNumber(1, 5)
            If .Stats.MinAGU < 0 Then .Stats.MinAGU = 0
            alter = 1
        End If

        If alter = 1 Then
            WriteUpdateHungerAndThirst UserIndex
        End If

    End With
End Sub

''
' Try to steal an item / gold to another character
'
' @param LadrOnIndex Specifies reference to user that stoles
' @param VictimaIndex Specifies reference to user that is being stolen
Public Sub DoRobar(ByRef Ladron As User, ByRef Victima As User, ByVal X As Byte, ByVal Y As Byte)

    On Error GoTo Errhandler

    If Not MapInfo(Victima.Pos.map).pk Then Exit Sub

    Dim wpaux As WorldPos

    wpaux.map = Ladron.Pos.map
    wpaux.X = X
    wpaux.Y = Y

    ' ¿Puede robar tan lejos?
    If Ladron.Clase = eClass.Thief Then
        If Ladron.Stats.ELV >= 25 Then
            If distancia(wpaux, Ladron.Pos) > 5 Then
                Call WriteMensajes(Ladron.UserIndex, e_Mensajes.Mensaje_5)
                Exit Sub
            End If
        Else
            If distancia(wpaux, Ladron.Pos) > 2 Then
                Call WriteMensajes(Ladron.UserIndex, e_Mensajes.Mensaje_5)
                Exit Sub
            End If
        End If
    Else
        If distancia(wpaux, Ladron.Pos) > 2 Then
            Call WriteMensajes(Ladron.UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub
        End If
    End If

    If Ladron.flags.Seguro Then
        If Not criminal(Victima.UserIndex) Then
            Call WriteMensajes(Ladron.UserIndex, e_Mensajes.Mensaje_120)
            Exit Sub
        End If
    Else
        If Ladron.faccion.ArmadaReal = 1 Then
            Call WriteMensajes(Ladron.UserIndex, Mensaje_416)
            Exit Sub
        End If
    End If

    If Victima.Stats.minSta = 0 Then    'Or Victima.Stats.MinAGU = 0 Or Victima.Stats.MinHam = 0 Then
        Call WriteConsoleMsg(Ladron.UserIndex, "No puedes robarle a la víctima si ésta no tiene energia!")
        Exit Sub
    End If

    If TriggerZonaPelea(Ladron.UserIndex, Victima.UserIndex) <> TRIGGER6_AUSENTE Then Exit Sub

    ' Tiene energia?
    If Ladron.Stats.minSta < 25 Then
        WriteMensajes Ladron.UserIndex, e_Mensajes.Mensaje_11
        Exit Sub
    End If

    If Not Ladron.flags.Privilegios = PlayerType.Admin Then
        If EsGM(Victima.UserIndex) Then
            Exit Sub
        End If
    End If

    ' Quito energia
    Call QuitarSta(Ladron.UserIndex, 25)

    If Ladron.faccion.ArmadaReal = 1 Then
        Call ExpulsarFaccionReal(Ladron.UserIndex)
    ElseIf Victima.faccion.FuerzasCaos = 1 And Ladron.faccion.FuerzasCaos = 1 Then
        Call ExpulsarFaccionCaos(Ladron.UserIndex)
    End If

    ' @@ TDS Extraction
    Dim N As Integer

    If Ladron.flags.Comerciando Then Exit Sub

    If Victima.flags.Comerciando Then
        Dim OtroUserIndex As Integer

        OtroUserIndex = Victima.ComUsu.DestUsu
        If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
            Call WriteConsoleMsg(Victima.UserIndex, "¡¡Comercio cancelado, te están robando!!", FontTypeNames.FONTTYPE_TALK)
            Call WriteMensajes(OtroUserIndex, e_Mensajes.Mensaje_129)
            Call LimpiarComercioSeguro(Victima.UserIndex)
        End If
    End If

    Dim Robo As Boolean

    If Ladron.Clase = eClass.Thief Then

        If RandomNumber(1, 200 - Ladron.Stats.UserSkills(eSkill.Robar)) < 80 Then    'probabilida de robar

            Select Case Ladron.Stats.UserSkills(eSkill.Robar)

            Case Is <= 10
                N = RandomNumber(20, 70)
                If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
                If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                Victima.Stats.GLD = Victima.Stats.GLD - N
                Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
            Case Is <= 20
                N = RandomNumber(120, 220)
                If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
                If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                Victima.Stats.GLD = Victima.Stats.GLD - N
                Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
            Case Is <= 30
                N = RandomNumber(250, 370)
                If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
                If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                Victima.Stats.GLD = Victima.Stats.GLD - N
                Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
            Case Is <= 40
                N = RandomNumber(400, 520)
                If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
                If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                Victima.Stats.GLD = Victima.Stats.GLD - N
                Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
            Case Is <= 50
                N = RandomNumber(550, 670)
                If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
                If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                Victima.Stats.GLD = Victima.Stats.GLD - N
                Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
            Case Is <= 60
                If Victima.Stats.GLD = 0 Then
                    Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & "no posee oro.")
                Else
                    N = RandomNumber(700, 820)
                    If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                    Victima.Stats.GLD = Victima.Stats.GLD - N
                    Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
                End If

                If Int(RandomNumber(0, 10)) <= 1 Then
                    If TieneObjetosRobables(Victima.UserIndex) Then
                        Call RobarObjeto(Ladron, Victima)
                        Robo = True
                    Else
                        Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene objetos.")
                    End If
                End If
            Case Is <= 70

                If Victima.Stats.GLD = 0 Then
                    Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro.")
                Else
                    N = RandomNumber(850, 970)
                    If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                    Victima.Stats.GLD = Victima.Stats.GLD - N
                    Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
                End If
                If Int(RandomNumber(0, 10)) <= 2 Then
                    If TieneObjetosRobables(Victima.UserIndex) Then
                        Call RobarObjeto(Ladron, Victima)
                        Robo = True
                    Else
                        Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene objetos.")
                    End If
                End If

            Case Is <= 80
                If Victima.Stats.GLD = 0 Then
                    Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro.")
                Else
                    N = RandomNumber(1020, 1100)
                    If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                    Victima.Stats.GLD = Victima.Stats.GLD - N
                    Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
                End If

                If Int(RandomNumber(0, 10)) <= 3 Then
                    If TieneObjetosRobables(Victima.UserIndex) Then
                        Call RobarObjeto(Ladron, Victima)
                        Robo = True
                    Else
                        Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene objetos.")
                    End If
                End If

            Case Is <= 99

                If Victima.Stats.GLD = 0 Then
                    Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro.")
                Else
                    N = RandomNumber(1150, 1220)
                    If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                    Victima.Stats.GLD = Victima.Stats.GLD - N
                    Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
                End If

                If Int(RandomNumber(0, 10)) <= 4 Then
                    If TieneObjetosRobables(Victima.UserIndex) Then
                        Call RobarObjeto(Ladron, Victima)
                        Robo = True
                    Else
                        Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene objetos.")
                    End If
                End If

            Case 100
                If Victima.Stats.GLD = 0 Then
                    Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro.")
                Else
                    N = RandomNumber(1300, 1380)
                    If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
                    Victima.Stats.GLD = Victima.Stats.GLD - N
                    Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
                End If

                If Int(RandomNumber(0, 10)) <= 5 Then
                    If TieneObjetosRobables(Victima.UserIndex) Then
                        Call RobarObjeto(Ladron, Victima)
                        Robo = True
                    Else
                        Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene objetos.")
                    End If
                End If
            End Select
        End If
    Else    'No es clase ladron

        If RandomNumber(1, 200 - Ladron.Stats.UserSkills(eSkill.Robar)) < 20 Then
            N = RandomNumber(10, Ladron.Stats.UserSkills(eSkill.Robar) * 2)
            If Victima.Stats.GLD = 0 Then Call WriteConsoleMsg(Ladron.UserIndex, Victima.Name & " no tiene oro."): Exit Sub
            If N > Victima.Stats.GLD Then N = Victima.Stats.GLD
            Victima.Stats.GLD = Victima.Stats.GLD - N
            Call AddtoVar(Ladron.Stats.GLD, N, MAXORO)
        End If

    End If

    If N Then
        Call WriteUpdateGold(Victima.UserIndex)
        Call WriteUpdateGold(Ladron.UserIndex)
        Call WriteConsoleMsg(Ladron.UserIndex, "Le has robado " & N & " monedas de oro a " & Victima.Name & ".")
        Call WriteConsoleMsg(Victima.UserIndex, "Te han robado!")
        Call LogDesarrollo(Ladron.Name & " le robó a " & Victima.Name & " " & N & " monedas de oro")
    End If

    If Robo Then N = 1

    Call SubirSkill(Ladron.UserIndex, eSkill.Robar, (N > 0))    'N>0 = robó oro o lo que sea.

    If Not criminal(Ladron.UserIndex) Then
        If Not criminal(Victima.UserIndex) Then
            Call VolverCriminal(Ladron.UserIndex)
        End If
    End If

    ' Se pudo haber convertido si robo a un ciuda
    If criminal(Ladron.UserIndex) Then
        Ladron.Reputacion.LadronesRep = Ladron.Reputacion.LadronesRep + vlLadron
        If Ladron.Reputacion.LadronesRep > MAXREP Then _
           Ladron.Reputacion.LadronesRep = MAXREP
    End If

    Exit Sub

Errhandler:
    Call LogError("Error en DoRobar. Error " & Err.Number & " : " & Err.Description)

End Sub

Private Sub RobarObjeto(ByRef Ladron As User, Victima As User)

    Dim i As Integer
    Dim MiObj As Obj
    Dim cantidad As Integer

    Dim encontre As Boolean

    ' ¿Encontre objeto robable?
    encontre = False

    ' Vamos a buscar un objeto robable. Comenzamos por el principio o el final del inventario?
    If RandomNumber(1, 12) < 6 Then
        i = 1
        Do While Not encontre And i <= Victima.CurrentInventorySlots
            'Hay objeto en este slot?
            If Victima.Invent.Object(i).ObjIndex > 0 Then
                If Victima.Invent.Object(i).Equipped = 0 Then
                    If ObjEsRobable(ObjData(Victima.Invent.Object(i).ObjIndex)) Then
                        If RandomNumber(1, 10) < 4 Then encontre = True
                    End If
                End If
            End If
            If Not encontre Then i = i + 1
        Loop
    Else
        i = 20
        Do While Not encontre And i > 0
            'Hay objeto en este slot?
            If Victima.Invent.Object(i).ObjIndex > 0 Then
                If Victima.Invent.Object(i).Equipped = 0 Then
                    If ObjEsRobable(ObjData(Victima.Invent.Object(i).ObjIndex)) Then
                        If RandomNumber(1, 10) < 4 Then encontre = True
                    End If
                End If
            End If
            If Not encontre Then i = i - 1
        Loop
    End If

    ' ¿Encontre algo?
    If Not encontre Then
        Call WriteMensajes(Ladron.UserIndex, e_Mensajes.Mensaje_122)
        Exit Sub
    End If

    ' Creamos el objeto
    MiObj.ObjIndex = Victima.Invent.Object(i).ObjIndex

    ' obtemos la cantidad que le vamos a sacar
    Select Case Ladron.Stats.UserSkills(eSkill.Robar)
    Case Is <= 60
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 100
        Else
            cantidad = RandomNumber(5, 10)
        End If
    Case Is <= 70
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 100
        Else
            cantidad = RandomNumber(5, 10)
        End If
    Case Is <= 80
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 200
        Else
            cantidad = RandomNumber(20, 25)
        End If
    Case Is <= 90
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 200
        Else
            cantidad = RandomNumber(20, 25)
        End If
    Case Is < 100
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 250
        Else
            cantidad = RandomNumber(30, 35)
        End If
    Case 100
        If EsMineral(MiObj.ObjIndex) Then
            cantidad = 300
        Else
            cantidad = RandomNumber(35, 40)
        End If
    Case Else
        cantidad = 1
    End Select

    ' Si la cantidad es mayor a lo qeu tiene en el inventario...
    If cantidad > Victima.Invent.Object(i).Amount Then
        cantidad = Victima.Invent.Object(i).Amount
    End If

    ' Seteamos la cantidad
    MiObj.Amount = cantidad

    ' Le quitamos
    Victima.Invent.Object(i).Amount = Victima.Invent.Object(i).Amount - cantidad

    If Victima.Invent.Object(i).Amount <= 0 Then
        Call QuitarUserInvItem(Victima.UserIndex, CByte(i), 1)
    End If
    Call UpdateUserInv(False, Victima.UserIndex, CByte(i))

    ' Se lo damos al ladron
    If Not MeterItemEnInventario(Ladron.UserIndex, MiObj) Then
        Call TirarItemAlPiso(Ladron.Pos, MiObj)
    End If

    Call LogDesarrollo(Ladron.Name & " le robó a " & Victima.Name & " : " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name)
    ' Informamos
    Call WriteConsoleMsg(Ladron.UserIndex, "Has robado " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name)

End Sub


Public Sub DoApuñalar(ByVal UserIndex As Integer, ByVal VictimNpcIndex As Integer, ByVal VictimUserIndex As Integer, ByRef Daño As Long, ByRef Apuñalo As Boolean, Optional ByVal Lugar As Byte = 1)
'***************************************************
'Autor: Nacho (Integer) & Unknown (orginal version)
'Last Modification: 04/17/08 - (NicoNZ)
'Simplifique la cuenta que hacia para sacar la suerte
'y arregle la cuenta que hacia para sacar el daño
'***************************************************

    On Error GoTo Errhandler

    Dim suerte As Integer
    Dim Skill As Integer

1   Skill = UserList(UserIndex).Stats.UserSkills(eSkill.Apuñalar)

    Select Case UserList(UserIndex).Clase
    Case eClass.Assasin
        suerte = Int(((0.00002 * Skill - 0.001) * Skill + 0.098) * Skill + 4.25)
    Case eClass.Cleric, eClass.Paladin
        suerte = Int(((0.000003 * Skill + 0.0006) * Skill + 0.0107) * Skill + 4.93)
    Case eClass.Bard
        suerte = Int(((0.000002 * Skill + 0.0002) * Skill + 0.032) * Skill + 4.81)
    Case Else
        suerte = Int(0.0361 * Skill + 4.39)
    End Select


    Dim RndApu As Byte

2   If VictimUserIndex < 1 Then
3       RndApu = RandomNumber(0, CONFIG_INI_RNDAPUNPC)
    Else
        If UserList(UserIndex).Clase = eClass.Assasin Then
            RndApu = RandomNumber(0, CONFIG_INI_RNDAPUASE)
        Else
4           If UserList(VictimUserIndex).Char.Heading <> UserList(UserIndex).Char.Heading Then
5               RndApu = RandomNumber(0, CONFIG_INI_RNDAPUCOMUN + 10)
            Else
6               RndApu = RandomNumber(0, CONFIG_INI_RNDAPUCOMUN)
            End If
        End If
    End If
    Dim origDaño As Integer

7   If RndApu < suerte Then
8       Apuñalo = True
9       If VictimUserIndex <> 0 Then
10          If UserList(UserIndex).Clase = eClass.Assasin Then
11              origDaño = Round(Daño * CONFIG_INI_DMGAPUASE, 0)
12          Else
13              origDaño = Round(Daño * CONFIG_INI_DMGAPUCOMUN, 0)
            End If

14          UserList(VictimUserIndex).Stats.MinHP = UserList(VictimUserIndex).Stats.MinHP - origDaño
15          Call WriteConsoleMsg(UserIndex, "Has apuñalado a " & UserList(VictimUserIndex).Name & " por " & origDaño & ".", FontTypeNames.FONTTYPE_APU)
16          Call WriteConsoleMsg(UserIndex, "Tu golpe total es de " & (origDaño + Daño) & ".", FontTypeNames.FONTTYPE_APU)        'modificar
17          Call WriteConsoleMsg(VictimUserIndex, "Te ha apuñalado " & UserList(UserIndex).Name & " por " & origDaño & ".", FontTypeNames.FONTTYPE_APU)
18          Call WriteConsoleMsg(VictimUserIndex, "Su golpe total ha sido " & (origDaño + Daño) & ".", FontTypeNames.FONTTYPE_APU)        'modificar
19          Call SendData(SendTarget.ToPCArea, VictimUserIndex, PrepareMessageCreateDamage(UserList(VictimUserIndex).Char.CharIndex, (origDaño + Daño), 250, 250, 150))

        Else


            If UserList(UserIndex).Clase = eClass.Assasin Then
                origDaño = Round(Daño * CONFIG_INI_DMGAPUNPCASE, 0)
            Else
                origDaño = Round(Daño * CONFIG_INI_DMGAPUNPC, 0)
            End If

21          Npclist(VictimNpcIndex).Stats.MinHP = Npclist(VictimNpcIndex).Stats.MinHP - origDaño
22          Call WriteConsoleMsg(UserIndex, "Has apuñalado la criatura por " & origDaño & ".", FontTypeNames.FONTTYPE_APU)
23          Call WriteConsoleMsg(UserIndex, "Tu golpe total es de " & Int(origDaño + Daño) & ".", FontTypeNames.FONTTYPE_APU)         'modificar
24          Call SendData(SendTarget.ToNPCArea, VictimNpcIndex, PrepareMessageCreateDamage(Npclist(VictimNpcIndex).Char.CharIndex, Int(origDaño + Daño), 250, 250, 150))

        End If
        'If Skill >= 5 Then
        Call SubirSkill(UserIndex, eSkill.Apuñalar, True)
        'End If

    Else
        WriteMensajes UserIndex, e_Mensajes.Mensaje_123
        'If Skill >= 5 Then
        Call SubirSkill(UserIndex, eSkill.Apuñalar, False)
        'End If
    End If

    If Apuñalo Then Daño = origDaño
    Exit Sub
Errhandler:
    Call LogError("Error en DoApuñalar en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Public Sub DoAcuchillar(ByVal UserIndex As Integer, ByVal VictimNpcIndex As Integer, ByVal VictimUserIndex As Integer, ByRef Daño As Long)
'***************************************************
'Autor: ZaMa
'Last Modification: 12/01/2010
'***************************************************

    If UserList(UserIndex).Clase <> eClass.Pirat Then Exit Sub
    If UserList(UserIndex).Invent.WeaponEqpSlot = 0 Then Exit Sub

    If RandomNumber(0, 100) < PROB_ACUCHILLAR Then
        Daño = Int(Daño * DAÑO_ACUCHILLAR)

        If VictimUserIndex <> 0 Then
            UserList(VictimUserIndex).Stats.MinHP = UserList(VictimUserIndex).Stats.MinHP - Daño
            Call WriteConsoleMsg(UserIndex, "Has acuchillado a " & UserList(VictimUserIndex).Name & " por " & Daño, FontTypeNames.FONTTYPE_FIGHT)
            Call WriteConsoleMsg(VictimUserIndex, UserList(UserIndex).Name & " te ha acuchillado por " & Daño, FontTypeNames.FONTTYPE_FIGHT)
        Else
            Npclist(VictimNpcIndex).Stats.MinHP = Npclist(VictimNpcIndex).Stats.MinHP - Daño
            Call WriteConsoleMsg(UserIndex, "Has acuchillado a la criatura por " & Daño, FontTypeNames.FONTTYPE_FIGHT)
        End If
    End If

End Sub

Public Function QuitarSta(ByVal UserIndex As Integer, ByVal cantidad As Integer) As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    UserList(UserIndex).Stats.minSta = UserList(UserIndex).Stats.minSta - cantidad
    If UserList(UserIndex).Stats.minSta < 0 Then UserList(UserIndex).Stats.minSta = 0
    Call WriteUpdateSta(UserIndex)

    QuitarSta = UserList(UserIndex).Stats.minSta
    Exit Function

Errhandler:
    Call LogError("Error en QuitarSta. Error " & Err.Number & " : " & Err.Description)

End Function

Public Sub DoMeditar(ByVal UserIndex As Integer)
    With UserList(UserIndex)
        .Counters.IdleCount = 0
        Dim Cant As Long
        Dim MeditarSkill As Byte
        Dim Tick As Long
        Tick = GetTickCount()
        If .Stats.MinMAN >= .Stats.MaxMAN Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_128
            Call WriteMeditateToggle(UserIndex)
            .flags.Meditando = False
            .Char.FX = 0
            .Char.loops = 0
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
            Exit Sub
        End If
        'Barrin 3/10/03
        'Esperamos a que se termine de concentrar
        If .Counters.tInicioMeditar > 0 Then
            .Counters.tInicioMeditar = .Counters.tInicioMeditar - CONFIG_INI_INTMEDITAR
            Exit Sub
        End If
        If .Counters.bPuedeMeditar = False Then
            .Counters.bPuedeMeditar = True
        End If
        If .Stats.MinMAN >= .Stats.MaxMAN Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_128
            Call WriteMeditateToggle(UserIndex)
            .flags.Meditando = False
            .Char.FX = 0
            .Char.loops = 0
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
            Exit Sub
        End If

        MeditarSkill = .Stats.UserSkills(eSkill.Meditar)    '

        If (Tick - .LastMedit) < (500 + (500 - Int(.Stats.UserSkills(eSkill.Meditar) * 5))) Then
            Exit Sub
        Else
            .LastMedit = Tick
        End If
        Cant = Porcentaje(UserList(UserIndex).Stats.MaxMAN, 5)
        UserList(UserIndex).Stats.MinMAN = UserList(UserIndex).Stats.MinMAN + Cant
        If Cant <= 1 Then Cant = 1
        If UserList(UserIndex).Stats.MinMAN > UserList(UserIndex).Stats.MaxMAN Then _
           UserList(UserIndex).Stats.MinMAN = UserList(UserIndex).Stats.MaxMAN
        Call WriteConsoleMsg(UserIndex, "¡Has recuperado " & Cant & " puntos de mana!", FontTypeNames.FONTTYPE_INFO)
        Call WriteUpdateMana(UserIndex)
        Call SubirSkill(UserIndex, Meditar, True)

    End With
End Sub


Public Sub DoDesequipar(ByVal UserIndex As Integer, ByVal VictimIndex As Integer)
'***************************************************
'Author: ZaMa
'Last Modif: 15/04/2010
'Unequips either shield, weapon or helmet from target user.
'***************************************************

    Dim Probabilidad As Integer
    Dim Resultado As Integer
    Dim WrestlingSkill As Byte
    Dim AlgoEquipado As Boolean

    With UserList(UserIndex)

        ' Si no esta solo con manos, no desequipa tampoco.
        If .Invent.WeaponEqpObjIndex > 0 Then Exit Sub

        WrestlingSkill = .Stats.UserSkills(eSkill.Wrestling)

        Probabilidad = WrestlingSkill * 0.2 + .Stats.ELV * 0.66
    End With

    With UserList(VictimIndex)
        ' Si tiene escudo, intenta desequiparlo
        If .Invent.EscudoEqpObjIndex > 0 Then

            Resultado = RandomNumber(1, 100)

            If Resultado <= Probabilidad Then
                ' Se lo desequipo
                Call Desequipar(VictimIndex, .Invent.EscudoEqpSlot, True)

                Call WriteConsoleMsg(UserIndex, "Has logrado desequipar el escudo de tu oponente!", FontTypeNames.FONTTYPE_FIGHT)

                If .Stats.ELV < 20 Then
                    Call WriteConsoleMsg(VictimIndex, "¡Tu oponente te ha desequipado el escudo!", FontTypeNames.FONTTYPE_FIGHT)
                End If

                'Call Flushbuffer(victimIndex)

                Exit Sub
            End If

            AlgoEquipado = True
        End If

        ' No tiene escudo, o fallo desequiparlo, entonces trata de desequipar arma
        If .Invent.WeaponEqpObjIndex > 0 Then

            Resultado = RandomNumber(1, 100)

            If Resultado <= Probabilidad Then
                ' Se lo desequipo
                Call Desequipar(VictimIndex, .Invent.WeaponEqpSlot, True)

                WriteMensajes UserIndex, e_Mensajes.Mensaje_346

                If .Stats.ELV < 20 Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_370
                End If

                'Call Flushbuffer(victimIndex)

                Exit Sub
            End If

            AlgoEquipado = True
        End If

        ' No tiene arma, o fallo desequiparla, entonces trata de desequipar casco
        If .Invent.CascoEqpObjIndex > 0 Then

            Resultado = RandomNumber(1, 100)

            If Resultado <= Probabilidad Then
                ' Se lo desequipo
                Call Desequipar(VictimIndex, .Invent.CascoEqpSlot, True)

                Call WriteConsoleMsg(UserIndex, "Has logrado desequipar el casco de tu oponente!", FontTypeNames.FONTTYPE_FIGHT)

                If .Stats.ELV < 20 Then
                    Call WriteConsoleMsg(VictimIndex, "¡Tu oponente te ha desequipado el casco!", FontTypeNames.FONTTYPE_FIGHT)
                End If

                'Call Flushbuffer(victimIndex)

                Exit Sub
            End If

            AlgoEquipado = True
        End If

        If AlgoEquipado Then
            Call WriteConsoleMsg(UserIndex, "Tu oponente no tiene equipado items!", FontTypeNames.FONTTYPE_FIGHT)
        Else
            Call WriteConsoleMsg(UserIndex, "No has logrado desequipar ningún item a tu oponente!", FontTypeNames.FONTTYPE_FIGHT)
        End If

    End With

End Sub

Public Sub Desarmar(ByVal UserIndex As Integer, ByVal VictimIndex As Integer)

    Dim suerte As Integer
    Dim res As Integer

    If UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 10 _
       And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= -1 Then
        suerte = 35
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 20 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 11 Then
        suerte = 30
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 30 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 21 Then
        suerte = 28
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 40 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 31 Then
        suerte = 24
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 50 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 41 Then
        suerte = 22
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 60 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 51 Then
        suerte = 20
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 70 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 61 Then
        suerte = 18
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 80 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 71 Then
        suerte = 15
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 90 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 81 Then
        suerte = 10
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) <= 99 _
           And UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) >= 91 Then
        suerte = 8
    ElseIf UserList(UserIndex).Stats.UserSkills(eSkill.Wrestling) = 100 Then
        suerte = 5
    End If
    res = RandomNumber(1, suerte)

    If res <= 2 Then
        Call Desequipar(VictimIndex, UserList(VictimIndex).Invent.WeaponEqpSlot, True)
        WriteMensajes UserIndex, e_Mensajes.Mensaje_346
        If UserList(VictimIndex).Stats.ELV < 20 Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_370
        End If
    End If

End Sub

Public Function MaxItemsConstruibles(ByVal UserIndex As Integer) As Integer

    Select Case UserList(UserIndex).Stats.ELV
    Case Is < 6
        MaxItemsConstruibles = 1
    Case Is < 15
        MaxItemsConstruibles = 2
    Case Is < 24
        MaxItemsConstruibles = 3
    Case Else
        MaxItemsConstruibles = 4
    End Select

    MaxItemsConstruibles = Int(MaxItemsConstruibles * rateConstruccion)

End Function

Public Sub CalcularModificador(personaje As User)
    Dim suerte As Integer

    Select Case personaje.Trabajo.tipo

    Case eTrabajos.Pesca  'PESCAR

        Select Case personaje.Stats.UserSkills(eSkill.Pesca)
        Case 0: suerte = 200
        Case 1 To 10: suerte = 195
        Case 11 To 20: suerte = 190
        Case 21 To 30: suerte = 180
        Case 31 To 40: suerte = 170
        Case 41 To 50: suerte = 160
        Case 51 To 60: suerte = 150
        Case 61 To 70: suerte = 140
        Case 71 To 80: suerte = 130
        Case 81 To 90: suerte = 120
        Case 91 To 99: suerte = 110
        Case Else: suerte = 100
        End Select

        personaje.Trabajo.modificador = suerte

    Case eTrabajos.Carpinteria, eTrabajos.Herreria   'HERRERIA y CARPINTERIA

        If personaje.Stats.ELV <= 5 Then
            suerte = 1
        ElseIf personaje.Stats.ELV < 14 Then
            suerte = 2
        ElseIf personaje.Stats.ELV < 24 Then
            suerte = 3
        Else
            suerte = 4
        End If

        personaje.Trabajo.modificador = suerte * 2
    End Select

End Sub
