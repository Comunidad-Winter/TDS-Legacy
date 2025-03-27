Attribute VB_Name = "ModFacciones"
Option Explicit

Private Type Armaduras
    BarDruiCazAseH As Integer
    BarDruiCazAseG As Integer
    ClerigoH As Integer
    ClerigoG As Integer
    PalGueH As Integer
    PalGueG As Integer
    MagDruiHM As Integer
    MagDruiHH As Integer
    MagDrioG As Integer
End Type

Private Type info
    Matados As Integer
    Oro As Long
    Nivel As Byte
    Armadura As Armaduras
End Type

Public RequisitosReal(1 To 5) As info
Public RequisitosCaos(1 To 5) As info

Public Const NUM_RANGOS_FACCION As Integer = 5        '15

' Contiene la cantidad de exp otorgada cada vez que aumenta el rango
Public RecompensaFacciones(NUM_RANGOS_FACCION) As Long

Private Function GiveFactionArmours(ByVal UserIndex As Integer, ByVal IsCaos As Boolean) As Boolean

    Dim Rango As Integer
    Dim MiObj As Obj

    With UserList(UserIndex)

        Rango = val(IIf(IsCaos, .faccion.RecompensasCaos, .faccion.RecompensasReal)) + 1

        If IsCaos Then

            If .faccion.RecibioArmaduraCaos = 0 Then

                'CAOS
                Select Case .raza

                Case eRaza.Humano, eRaza.Elfo, eRaza.Drow

                    Select Case .Clase

                    Case eClass.Bard, eClass.Druid, eClass.Hunter, eClass.Assasin
                        MiObj.ObjIndex = 734

                    Case eClass.Cleric
                        MiObj.ObjIndex = 736

                    Case eClass.Paladin, eClass.Warrior
                        MiObj.ObjIndex = 738

                    Case eClass.Mage
                        MiObj.ObjIndex = IIf(.Genero = eGenero.Hombre, 741, 740)

                    End Select

                Case eRaza.Gnomo, eRaza.Enano

                    Select Case .Clase

                    Case eClass.Bard, eClass.Druid, eClass.Hunter, eClass.Assasin
                        MiObj.ObjIndex = 735

                    Case eClass.Cleric
                        MiObj.ObjIndex = 737

                    Case eClass.Paladin, eClass.Warrior
                        MiObj.ObjIndex = 739

                    Case eClass.Mage
                        MiObj.ObjIndex = 742

                    End Select

                End Select

                MiObj.Amount = 1

                If Not MeterItemEnInventario(UserIndex, MiObj) Then
                    Exit Function
                    'Call TirarItemAlPiso(.Pos, MiObj)
                End If
                GiveFactionArmours = True

            End If

            .faccion.RecibioArmaduraCaos = 1
            .faccion.NivelIngreso = .Stats.ELV
            .faccion.FechaIngreso = Date

        Else

            If .faccion.RecibioArmaduraReal = 0 Then

                'ARMADA
                Select Case .raza

                Case eRaza.Humano, eRaza.Elfo, eRaza.Drow

                    Select Case .Clase

                    Case eClass.Bard, eClass.Druid, eClass.Hunter, eClass.Assasin
                        MiObj.ObjIndex = 779

                    Case eClass.Cleric
                        MiObj.ObjIndex = 781

                    Case eClass.Paladin, eClass.Warrior
                        MiObj.ObjIndex = 783

                    Case eClass.Mage
                        MiObj.ObjIndex = IIf(.Genero = eGenero.Hombre, 786, 785)

                    End Select

                Case eRaza.Gnomo, eRaza.Enano

                    Select Case .Clase

                    Case eClass.Bard, eClass.Druid, eClass.Hunter, eClass.Assasin
                        MiObj.ObjIndex = 780

                    Case eClass.Cleric
                        MiObj.ObjIndex = 782

                    Case eClass.Paladin, eClass.Warrior
                        MiObj.ObjIndex = 784

                    Case eClass.Mage
                        MiObj.ObjIndex = 787

                    End Select

                End Select

                MiObj.Amount = 1

                If Not MeterItemEnInventario(UserIndex, MiObj) Then
                    Exit Function    'Call TirarItemAlPiso(.Pos, MiObj)
                End If
                GiveFactionArmours = True

            End If

            .faccion.RecibioArmaduraReal = 1
            .faccion.NivelIngreso = .Stats.ELV
            .faccion.FechaIngreso = Date

            ' ++ Esto por ahora es inútil, siempre va a ser cero, pero bueno, despues va a servir.
            .faccion.MatadosIngreso = .faccion.CiudadanosMatados

        End If

    End With

End Function

Public Sub EnlistarArmadaReal(ByVal UserIndex As Integer)

    With UserList(UserIndex)
        If .faccion.ArmadaReal = 1 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Ya perteneces a las tropas reales!!! Ve a combatir criminales.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.FuerzasCaos = 1 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Maldito insolente!!! Vete de aquí seguidor de las sombras.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If criminal(UserIndex) Then
            Call WriteChatOverHead(UserIndex, "¡¡¡No se permiten criminales en el ejército real!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.CriminalesMatados < 50 Then
            Call WriteChatOverHead(UserIndex, "Para unirte a nuestras fuerzas debes matar al menos 50 criminales, sólo has matado " & .faccion.CriminalesMatados & ".", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .Stats.ELV < 25 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Para unirte a nuestras fuerzas debes ser al menos de nivel 25!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.CiudadanosMatados > 0 Then
            Call WriteChatOverHead(UserIndex, "¡Has asesinado gente inocente, no aceptamos asesinos en las tropas reales!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.Reenlistadas > 4 Then
            Call WriteChatOverHead(UserIndex, "¡Has sido expulsado de las fuerzas reales demasiadas veces!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .Reputacion.NobleRep < 0 Then
            Call WriteChatOverHead(UserIndex, "Necesitas ser aún más noble para integrar el ejército real, sólo tienes " & .Reputacion.NobleRep & "/20.000 puntos de nobleza", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .guildIndex > 0 Then
            If Not UCase$(modGuilds.GuildLeader(.guildIndex)) = UCase$(.Name) Then

            End If
            If guilds(.guildIndex).Alineacion = ALINEACION_GUILD.ALINEACION_NEUTRO Then
                Call WriteChatOverHead(UserIndex, "¡¡¡Perteneces a un clan neutro, sal de él si quieres unirte a nuestras fuerzas!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
                Exit Sub
            End If
        End If

        'If .account_id <= 0 Then
        '    Call WriteChatOverHead(UserIndex, "Tu personaje debe estar adherido a una Cuenta PREMIUM!", Str(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
        '    Exit Sub
        'End If

        If .faccion.RecibioArmaduraReal = 0 Then

            If Not GiveFactionArmours(UserIndex, False) Then
                Call WriteConsoleMsg(UserIndex, "No tienes espacio en el inventario para recibir la armadura faccionaria. Debes hacer lugar para ella."): Exit Sub
            End If

            .faccion.RecibioExpInicialReal = 1
            .faccion.RecompensasReal = 1

        End If


        .faccion.ArmadaReal = 1
        .faccion.Reenlistadas = .faccion.Reenlistadas + 1

        Call WriteChatOverHead(UserIndex, "¡¡¡Bienvenido al ejército real!!! Aquí tienes tus vestimentas. Cumple bien tu labor exterminando criminales y me encargaré de recompensarte.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Rey de Banderbill> Ahora le ofreceré estas vestimentas a " & .Name & " por haberse enlistado a la Armada Real. Espero grandes logros de este noble guerrero.", FontTypeNames.FONTTYPE_CONSEJOVesA))
        Call WriteUpdateFaccion(UserIndex)

        If .flags.Navegando Then Call RefreshCharStatus(UserIndex)
        Call LogEjercitoReal(.Name & " ingresó el " & Date & " cuando era nivel " & .Stats.ELV)

    End With

End Sub

Public Sub RecompensaArmadaReal(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        Dim rec As Byte
        Dim MiObj As Obj

        rec = .faccion.RecompensasReal + 1


        If .faccion.RecompensasReal >= 5 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Bien hecho, ya no tengo más recompensas para ti. Sigue así!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If


        If .faccion.CriminalesMatados < RequisitosReal(rec).Matados Then
            Call WriteChatOverHead(UserIndex, "Has matado  " & .faccion.CriminalesMatados & " ciudadanos, quiero que mates al menos " & RequisitosReal(rec).Matados & " criminales  para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        If .Stats.ELV < RequisitosReal(rec).Nivel Then
            Call WriteChatOverHead(UserIndex, "Mataste suficientes ciudadanos, pero te faltan " & RequisitosReal(rec).Nivel - .Stats.ELV & " niveles para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        If .Stats.GLD < RequisitosReal(rec).Oro Then
            Call WriteChatOverHead(UserIndex, "Necesitas " & Format$("###,###,###", RequisitosReal(rec).Oro) & " monedas de oro para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        .faccion.RecompensasReal = rec
        .Stats.GLD = .Stats.GLD - RequisitosReal(rec).Oro

        Dim Slot As Byte

        For Slot = 1 To .CurrentInventorySlots
            If .Invent.Object(Slot).ObjIndex > 0 Then
                If (ObjData(.Invent.Object(Slot).ObjIndex).Real = 1) Then
                    Call QuitarUserInvItem(UserIndex, Slot, .Invent.Object(Slot).Amount)
                    Call UpdateUserInvSlot(UserIndex, Slot)
                End If
            End If
        Next Slot

        Call PerderItemsFaccionarios(UserIndex)
        MiObj.Amount = 1

        Select Case .raza

        Case eRaza.Drow, eRaza.Elfo, eRaza.Humano

            If .Clase = eClass.Bard Or .Clase = eClass.Druid Or .Clase = eClass.Hunter Or .Clase = eClass.Assasin Then
                MiObj.ObjIndex = 779
            ElseIf .Clase = eClass.Cleric Then
                MiObj.ObjIndex = 781
            ElseIf .Clase = eClass.Paladin Or .Clase = eClass.Warrior Then
                MiObj.ObjIndex = 783
            ElseIf .Clase = eClass.Mage Or .Clase = eClass.Druid Then
                If .Genero = eGenero.Hombre Then
                    MiObj.ObjIndex = 786
                Else
                    MiObj.ObjIndex = 785
                End If
            End If

        Case eRaza.Gnomo, eRaza.Enano

            If .Clase = eClass.Bard Or .Clase = eClass.Druid Or .Clase = eClass.Hunter Or .Clase = eClass.Assasin Then
                MiObj.ObjIndex = 780
            ElseIf .Clase = eClass.Cleric Then
                MiObj.ObjIndex = 782
            ElseIf .Clase = eClass.Paladin Or .Clase = eClass.Warrior Then
                MiObj.ObjIndex = 784
            ElseIf .Clase = eClass.Mage Or .Clase = eClass.Druid Then
                If .Genero = eGenero.Hombre Then
                    MiObj.ObjIndex = 787
                Else
                    MiObj.ObjIndex = 787
                End If
            End If

        End Select

        'Tengo que darle una armadura?
        If MiObj.ObjIndex > 0 Then
            Call MeterItemEnInventario(UserIndex, MiObj)
        End If

        Call WriteChatOverHead(UserIndex, "¡¡¡Aquí tienes tu recompensa " & TituloReal(.faccion.RecompensasReal) & "!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)

    End With

End Sub

Public Sub ExpulsarFaccionReal(ByVal UserIndex As Integer, Optional Expulsado As Boolean = True)
'***************************************************
'Author: Unknownn
'Last Modification: 27/07/2012 - ^[GS]^
'***************************************************

    If Expulsado Then
        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_182)        '"¡¡¡Has sido expulsado del ejército real!!!"
    Else
        Call WriteConsoleMsg(UserIndex, "¡¡¡Te has retirado del ejército real!!!")
    End If

    With UserList(UserIndex)
        .faccion.ArmadaReal = 0

        If .Invent.ArmourEqpObjIndex <> 0 Then
            'Desequipamos la armadura real si está equipada
            If ObjData(.Invent.ArmourEqpObjIndex).Real = 1 Then
                Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, True)
            End If
        End If

        If .Invent.EscudoEqpObjIndex <> 0 Then
            'Desequipamos el escudo de caos si está equipado
            If ObjData(.Invent.EscudoEqpObjIndex).Real = 1 Then
                Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, True)
            End If
        End If

        If .flags.Navegando Then
            Call RefreshCharStatus(UserIndex)        'Actualizamos la barca si esta navegando (NicoNZ)
        End If
    End With

    Call WriteUpdateFaccion(UserIndex)
    Call PerderItemsFaccionarios(UserIndex)

End Sub

Public Sub ExpulsarFaccionCaos(ByVal UserIndex As Integer, Optional Expulsado As Boolean = True)
'***************************************************
'Author: Unknownn
'Last Modification: 27/07/2012 - ^[GS]^
'***************************************************

    If Expulsado Then
        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_183)        '"¡¡¡Has sido expulsado de la Legión Oscura!!!"
    Else
        Call WriteConsoleMsg(UserIndex, "¡¡¡Te has retirado de la Legión Oscura!!!")
    End If

    With UserList(UserIndex)
        .faccion.FuerzasCaos = 0

        If .Invent.ArmourEqpObjIndex <> 0 Then
            'Desequipamos la armadura de caos si está equipada
            If ObjData(.Invent.ArmourEqpObjIndex).Caos = 1 Then
                Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, True)
            End If
        End If

        If .Invent.EscudoEqpObjIndex <> 0 Then
            'Desequipamos el escudo de caos si está equipado
            If ObjData(.Invent.EscudoEqpObjIndex).Caos = 1 Then
                Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, True)
            End If
        End If

        If .flags.Navegando Then
            Call RefreshCharStatus(UserIndex)        'Actualizamos la barca si esta navegando (NicoNZ)
        End If
    End With

    Call WriteUpdateFaccion(UserIndex)
    Call PerderItemsFaccionarios(UserIndex)

End Sub

Public Function TituloReal(ByVal RecompensasReal As Long) As String

    Select Case RecompensasReal
    Case 1
        TituloReal = "Aprendiz"
    Case 2
        TituloReal = "Caballero"
    Case 3
        TituloReal = "Capitán"
    Case 4
        TituloReal = "Guardián"
    Case 5
        TituloReal = "Campeón de la Luz"
    End Select

End Function

Public Sub EnlistarCaos(ByVal UserIndex As Integer)
'***************************************************
'Autor: Pablo (ToxicWaste) & Unknown (orginal version)
'Last Modification: 27/11/2009
'15/03/2009: ZaMa - No se puede enlistar el fundador de un clan con alineación neutral.
'27/11/2009: ZaMa - Ahora no se puede enlistar un miembro de un clan neutro, por ende saque la antifaccion.
'Handles the entrance of users to the "Legión Oscura"
'***************************************************

    With UserList(UserIndex)
        If Not criminal(UserIndex) Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Lárgate de aquí, bufón!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.FuerzasCaos = 1 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Ya perteneces a la legión oscura!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.ArmadaReal = 1 Then
            Call WriteChatOverHead(UserIndex, "Las sombras reinarán en Argentum. ¡¡¡Fuera de aquí insecto real!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        '[Barrin 17-12-03] Si era miembro de la Armada Real no se puede enlistar
        If .faccion.RecibioExpInicialReal = 1 Then        'Tomamos el valor de ahí: ¿Recibio la experiencia para entrar?
            Call WriteChatOverHead(UserIndex, "No permitiré que ningún insecto real ingrese a mis tropas.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If
        '[/Barrin]

        If Not criminal(UserIndex) Then
            Call WriteChatOverHead(UserIndex, "¡¡Ja ja ja!! Tú no eres bienvenido aquí asqueroso ciudadano.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .faccion.CiudadanosMatados < 50 Then
            Call WriteChatOverHead(UserIndex, "Para unirte a nuestras fuerzas debes matar al menos 50 ciudadanos, sólo has matado " & .faccion.CiudadanosMatados & ".", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .Stats.ELV < 25 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Para unirte a nuestras fuerzas debes ser al menos nivel 25!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Exit Sub
        End If

        If .guildIndex > 0 Then
            If guilds(.guildIndex).Alineacion = ALINEACION_GUILD.ALINEACION_NEUTRO Then
                Call WriteChatOverHead(UserIndex, "¡¡¡Perteneces a un clan neutro, sal de él si quieres unirte a nuestras fuerzas!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
                Exit Sub
            End If
        End If

        If .faccion.Reenlistadas > 4 Then
            If .faccion.Reenlistadas = 200 Then
                Call WriteChatOverHead(UserIndex, "Has sido expulsado de las fuerzas oscuras y durante tu rebeldía has atacado a mi ejército. ¡Vete de aquí!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            Else
                Call WriteChatOverHead(UserIndex, "¡Has sido expulsado de las fuerzas oscuras demasiadas veces!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
            End If
            Exit Sub
        End If

        'If .account_id <= 0 Then
        '    Call WriteChatOverHead(UserIndex, "Tu personaje debe estar adherido a una Cuenta PREMIUM!", Str(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
        '    Exit Sub
        'End If


        If .faccion.RecibioArmaduraCaos = 0 Then
            If Not GiveFactionArmours(UserIndex, True) Then
                Call WriteConsoleMsg(UserIndex, "No tienes espacio en el inventario para recibir la armadura faccionaria. Debes hacer lugar para ella."): Exit Sub
            End If

            .faccion.RecibioExpInicialCaos = 1
            .faccion.RecompensasCaos = 1
        End If

        .faccion.Reenlistadas = .faccion.Reenlistadas + 1
        .faccion.FuerzasCaos = 1

        Call WriteChatOverHead(UserIndex, "¡¡¡Bienvenido al lado oscuro!!! Aquí tienes tus armaduras. Derrama sangre ciudadana y real, y serás recompensado, lo prometo.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Señor del Miedo> Es un gusto anunciar que " & .Name & " se ha enlistado en la Legión Oscura. Su alma me pertenece y su equipamiento es la recompensa para sembrar el miedo en estas tierras.", FontTypeNames.FONTTYPE_CONSEJOCAOSVesA))
        Call WriteUpdateFaccion(UserIndex)


        If .flags.Navegando Then
            Call RefreshCharStatus(UserIndex)        'Actualizamos la barca si esta navegando (NicoNZ)
        End If

        Call LogEjercitoCaos(.Name & " ingresó el " & Date & " cuando era nivel " & .Stats.ELV)
    End With

End Sub

Public Sub CargarRequisitos()
'ARMADA
    RequisitosReal(1).Oro = 0
    RequisitosReal(1).Matados = 100
    RequisitosReal(1).Nivel = 30

    RequisitosReal(2).Oro = 50000
    RequisitosReal(2).Matados = 250
    RequisitosReal(2).Nivel = 32

    RequisitosReal(3).Oro = 100000
    RequisitosReal(3).Matados = 450
    RequisitosReal(3).Nivel = 36

    RequisitosReal(4).Oro = 250000
    RequisitosReal(4).Matados = 650
    RequisitosReal(4).Nivel = 38

    RequisitosReal(5).Oro = 750000
    RequisitosReal(5).Matados = 850
    RequisitosReal(5).Nivel = 40

    'CAOS
    RequisitosCaos(1).Oro = 0
    RequisitosCaos(1).Matados = 150
    RequisitosCaos(1).Nivel = 25

    RequisitosCaos(2).Oro = 50000
    RequisitosCaos(2).Matados = 250
    RequisitosCaos(2).Nivel = 27

    RequisitosCaos(3).Oro = 100000
    RequisitosCaos(3).Matados = 450
    RequisitosCaos(3).Nivel = 30

    RequisitosCaos(4).Oro = 250000
    RequisitosCaos(4).Matados = 650
    RequisitosCaos(4).Nivel = 34

    RequisitosCaos(5).Oro = 750000
    RequisitosCaos(5).Matados = 850
    RequisitosCaos(5).Nivel = 37


    'Armaduras caos
    RequisitosCaos(2).Armadura.BarDruiCazAseH = 743
    RequisitosCaos(2).Armadura.BarDruiCazAseG = 744
    RequisitosCaos(2).Armadura.ClerigoH = 745
    RequisitosCaos(2).Armadura.ClerigoG = 746
    RequisitosCaos(2).Armadura.PalGueH = 747
    RequisitosCaos(2).Armadura.PalGueG = 748
    RequisitosCaos(2).Armadura.MagDruiHM = 749
    RequisitosCaos(2).Armadura.MagDruiHH = 750
    RequisitosCaos(2).Armadura.MagDrioG = 751

    RequisitosCaos(3).Armadura.BarDruiCazAseH = 752
    RequisitosCaos(3).Armadura.BarDruiCazAseG = 753
    RequisitosCaos(3).Armadura.ClerigoH = 754
    RequisitosCaos(3).Armadura.ClerigoG = 755
    RequisitosCaos(3).Armadura.PalGueH = 756
    RequisitosCaos(3).Armadura.PalGueG = 757
    RequisitosCaos(3).Armadura.MagDruiHM = 758
    RequisitosCaos(3).Armadura.MagDruiHH = 759
    RequisitosCaos(3).Armadura.MagDrioG = 760

    RequisitosCaos(4).Armadura.BarDruiCazAseH = 761
    RequisitosCaos(4).Armadura.BarDruiCazAseG = 762
    RequisitosCaos(4).Armadura.ClerigoH = 763
    RequisitosCaos(4).Armadura.ClerigoG = 764
    RequisitosCaos(4).Armadura.PalGueH = 765
    RequisitosCaos(4).Armadura.PalGueG = 766
    RequisitosCaos(4).Armadura.MagDruiHM = 767
    RequisitosCaos(4).Armadura.MagDruiHH = 768
    RequisitosCaos(4).Armadura.MagDrioG = 769

    RequisitosCaos(5).Armadura.BarDruiCazAseH = 770
    RequisitosCaos(5).Armadura.BarDruiCazAseG = 771
    RequisitosCaos(5).Armadura.ClerigoH = 772
    RequisitosCaos(5).Armadura.ClerigoG = 773
    RequisitosCaos(5).Armadura.PalGueH = 774
    RequisitosCaos(5).Armadura.PalGueG = 775
    RequisitosCaos(5).Armadura.MagDruiHM = 776
    RequisitosCaos(5).Armadura.MagDruiHH = 777
    RequisitosCaos(5).Armadura.MagDrioG = 778

    'Armaduras Real
    RequisitosReal(2).Armadura.BarDruiCazAseH = 788
    RequisitosReal(2).Armadura.BarDruiCazAseG = 789
    RequisitosReal(2).Armadura.ClerigoH = 790
    RequisitosReal(2).Armadura.ClerigoG = 791
    RequisitosReal(2).Armadura.PalGueH = 792
    RequisitosReal(2).Armadura.PalGueG = 793
    RequisitosReal(2).Armadura.MagDruiHM = 794
    RequisitosReal(2).Armadura.MagDruiHH = 795
    RequisitosReal(2).Armadura.MagDrioG = 796

    RequisitosReal(3).Armadura.BarDruiCazAseH = 797
    RequisitosReal(3).Armadura.BarDruiCazAseG = 798
    RequisitosReal(3).Armadura.ClerigoH = 799
    RequisitosReal(3).Armadura.ClerigoG = 800
    RequisitosReal(3).Armadura.PalGueH = 801
    RequisitosReal(3).Armadura.PalGueG = 802
    RequisitosReal(3).Armadura.MagDruiHM = 803
    RequisitosReal(3).Armadura.MagDruiHH = 804
    RequisitosReal(3).Armadura.MagDrioG = 805

    RequisitosReal(4).Armadura.BarDruiCazAseH = 806
    RequisitosReal(4).Armadura.BarDruiCazAseG = 807
    RequisitosReal(4).Armadura.ClerigoH = 808
    RequisitosReal(4).Armadura.ClerigoG = 809
    RequisitosReal(4).Armadura.PalGueH = 810
    RequisitosReal(4).Armadura.PalGueG = 811
    RequisitosReal(4).Armadura.MagDruiHM = 812
    RequisitosReal(4).Armadura.MagDruiHH = 813
    RequisitosReal(4).Armadura.MagDrioG = 814

    RequisitosReal(5).Armadura.BarDruiCazAseH = 815
    RequisitosReal(5).Armadura.BarDruiCazAseG = 816
    RequisitosReal(5).Armadura.ClerigoH = 817
    RequisitosReal(5).Armadura.ClerigoG = 818
    RequisitosReal(5).Armadura.PalGueH = 819
    RequisitosReal(5).Armadura.PalGueG = 820
    RequisitosReal(5).Armadura.MagDruiHM = 821
    RequisitosReal(5).Armadura.MagDruiHH = 822
    RequisitosReal(5).Armadura.MagDrioG = 823

End Sub


Public Sub RecompensaCaos(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        Dim rec As Byte
        Dim MiObj As Obj

        rec = .faccion.RecompensasCaos + 1


        If .faccion.RecompensasCaos >= 5 Then
            Call WriteChatOverHead(UserIndex, "¡¡¡Bien hecho, ya no tengo más recompensas para ti. Sigue así!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        If .faccion.CiudadanosMatados < RequisitosCaos(rec).Matados Then
            Call WriteChatOverHead(UserIndex, "Has matado  " & .faccion.CiudadanosMatados & " ciudadanos, quiero que mates al menos " & RequisitosCaos(rec).Matados & " ciudadanos  para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        If .Stats.ELV < RequisitosCaos(rec).Nivel Then
            Call WriteChatOverHead(UserIndex, "Mataste suficientes ciudadanos, pero te faltan " & RequisitosCaos(rec).Nivel - .Stats.ELV & " niveles para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        If .Stats.GLD < RequisitosCaos(rec).Oro Then
            Call WriteChatOverHead(UserIndex, "Necesitas " & Format$("###,###,###", RequisitosCaos(rec).Oro) & " monedas de oro para poder recibir la próxima recompensa.", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite): Exit Sub
        End If

        ' @@ End validations.

        .faccion.RecompensasCaos = rec
        .Stats.GLD = .Stats.GLD - RequisitosCaos(rec).Oro

        Dim Slot As Byte

        For Slot = 1 To .CurrentInventorySlots
            If .Invent.Object(Slot).ObjIndex > 0 Then
                If (ObjData(.Invent.Object(Slot).ObjIndex).Caos = 1) Then
                    Call QuitarUserInvItem(UserIndex, Slot, .Invent.Object(Slot).Amount)
                    Call UpdateUserInvSlot(UserIndex, Slot)
                End If
            End If
        Next Slot

        Call PerderItemsFaccionarios(UserIndex)

        MiObj.Amount = 1

        Select Case .raza

        Case eRaza.Humano, eRaza.Elfo, eRaza.Drow

            If .Clase = eClass.Bard Or .Clase = eClass.Druid Or .Clase = eClass.Hunter Or .Clase = eClass.Assasin Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.BarDruiCazAseH
            ElseIf .Clase = eClass.Cleric Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.ClerigoH
            ElseIf .Clase = eClass.Paladin Or .Clase = eClass.Warrior Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.PalGueH
            ElseIf .Clase = eClass.Mage Or .Clase = eClass.Druid Then
                If .Genero = eGenero.Hombre Then
                    MiObj.ObjIndex = RequisitosCaos(rec).Armadura.MagDruiHH
                Else
                    MiObj.ObjIndex = RequisitosCaos(rec).Armadura.MagDruiHM
                End If
            End If

        Case eRaza.Gnomo, eRaza.Enano

            If .Clase = eClass.Bard Or .Clase = eClass.Druid Or .Clase = eClass.Hunter Or .Clase = eClass.Assasin Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.BarDruiCazAseG
            ElseIf .Clase = eClass.Cleric Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.ClerigoG
            ElseIf .Clase = eClass.Paladin Or .Clase = eClass.Warrior Then
                MiObj.ObjIndex = RequisitosCaos(rec).Armadura.PalGueG
            ElseIf .Clase = eClass.Mage Or .Clase = eClass.Druid Then
                If .Genero = eGenero.Hombre Then
                    MiObj.ObjIndex = RequisitosCaos(rec).Armadura.MagDrioG
                End If
            End If

        End Select

        MiObj.Amount = 1

        If Not MeterItemEnInventario(UserIndex, MiObj) Then
            Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
        End If

        Call WriteChatOverHead(UserIndex, "¡¡¡Bien hecho " & TituloCaos(.faccion.RecompensasCaos) & ", aquí tienes tu recompensa!!!", Str$(Npclist(.flags.TargetNPC).Char.CharIndex), vbWhite)

    End With

End Sub

Public Function TituloCaos(ByVal RecompensasCaos As Long) As String

    Select Case RecompensasCaos
    Case 1
        TituloCaos = "Esbirro"
    Case 2
        TituloCaos = "Sanguinario"
    Case 3
        TituloCaos = "Condenado"
    Case 4
        TituloCaos = "Caballero de la Oscuridad"
    Case 5
        TituloCaos = "Devorador de Almas"
    End Select

End Function

Sub PerderItemsFaccionarios(ByVal UserIndex As Integer)

' ++ Mejore esta poronga de sub xd

    Dim i As Long, ItemIndex As Integer

    With UserList(UserIndex)

        ' ++ Revisamos en el inventario
        For i = 1 To MAX_INVENTORY_SLOTS

            ItemIndex = .Invent.Object(i).ObjIndex

            If ItemIndex > 0 Then

                If ObjData(ItemIndex).Real = 1 Or ObjData(ItemIndex).Caos = 1 Then
                    Call QuitarUserInvItem(UserIndex, i, .Invent.Object(i).Amount)
                    Call UpdateUserInvSlot(UserIndex, i)

                    If ObjData(ItemIndex).OBJType = otArmadura Or ObjData(ItemIndex).OBJType = otEscudo Then
                        If ObjData(ItemIndex).Real = 1 Then .faccion.RecibioArmaduraReal = 0
                        If ObjData(ItemIndex).Caos = 1 Then .faccion.RecibioArmaduraCaos = 0
                    Else
                        .faccion.RecibioArmaduraCaos = 0
                        .faccion.RecibioArmaduraReal = 0
                    End If
                End If

            End If

        Next i

        ' ++ Revisamos en la boveda
        For i = 1 To MAX_BANCOINVENTORY_SLOTS

            ItemIndex = .BancoInvent.Object(i).ObjIndex

            If ItemIndex > 0 Then

                If ObjData(ItemIndex).Real = 1 Or ObjData(ItemIndex).Caos = 1 Then
                    Call QuitarObjetosBove(ItemIndex, .BancoInvent.Object(i).Amount, UserIndex)

                    If ObjData(ItemIndex).OBJType = otArmadura Or ObjData(ItemIndex).OBJType = otEscudo Then
                        If ObjData(ItemIndex).Real = 1 Then .faccion.RecibioArmaduraReal = 0
                        If ObjData(ItemIndex).Caos = 1 Then .faccion.RecibioArmaduraCaos = 0
                    Else
                        .faccion.RecibioArmaduraCaos = 0
                        .faccion.RecibioArmaduraReal = 0
                    End If
                End If

            End If

        Next i

    End With

End Sub

