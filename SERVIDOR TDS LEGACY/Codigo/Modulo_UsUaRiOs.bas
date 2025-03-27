Attribute VB_Name = "UsUaRiOs"
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


Public Function EsGmChar(ByRef Name As String) As Boolean        ' 0.13.3
'***************************************************
'Author: ZaMa
'Last Modification: 10/07/2012 - ^[GS]^
'Returns true if char is administrative user.
'***************************************************

    Dim EsGM As Boolean

    ' Admin?
    EsGM = EsAdmin(Name)
    ' Dios?
    If Not EsGM Then EsGM = EsDios(Name)
    ' Semidios?
    If Not EsGM Then EsGM = EsSemiDios(Name)
    ' Consejero?
    If Not EsGM Then EsGM = EsConsejero(Name)

    EsGmChar = EsGM

End Function

'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'                        Modulo Usuarios
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'Rutinas de los usuarios
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿

Public Sub ActStats(ByVal VictimIndex As Integer, ByVal attackerIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 11/03/2010
'***************************************************

    Dim DaExp As Integer
    Dim EraCriminal As Boolean

    DaExp = CInt(UserList(VictimIndex).Stats.ELV) * 2

    With UserList(attackerIndex)
        .Stats.Exp = .Stats.Exp + DaExp
        If .Stats.Exp > MAXEXP Then .Stats.Exp = MAXEXP

        If TriggerZonaPelea(VictimIndex, attackerIndex) <> TRIGGER6_PERMITE Then

            EraCriminal = criminal(attackerIndex)

            With .Reputacion
                If Not criminal(VictimIndex) Then
                    .AsesinoRep = .AsesinoRep + vlASESINO * 2
                    If .AsesinoRep > MAXREP Then .AsesinoRep = MAXREP
                    .BurguesRep = 0
                    .NobleRep = 0
                    .PlebeRep = 0
                Else
                    .NobleRep = .NobleRep + vlNoble
                    If .NobleRep > MAXREP Then .NobleRep = MAXREP
                End If
            End With

            If criminal(attackerIndex) Then
                If Not EraCriminal Then Call RefreshCharStatus(attackerIndex)
            Else
                If EraCriminal Then Call RefreshCharStatus(attackerIndex)
            End If
        End If

        'Lo mata
        Call WriteMultiMessage(attackerIndex, eMessages.HaveKilledUser, VictimIndex, DaExp)
        Call WriteMultiMessage(VictimIndex, eMessages.UserKill, attackerIndex)

        If .flags.EnEvento = 4 Then
            If .Slot_ID > 0 Then
                Call m_TorneoJDH.SetKilled(.Slot_ID)
            End If
        End If
        If .flags.EnEvento = 5 Then
            If .Slot_ID > 0 Then
                'Call m_TorneoXVsX.SetKilled(.Slot_ID)
            End If
        End If

        Dim i As Long, N As Integer

        For i = 1 To MAXUSERQUESTS
            N = .QuestStats.Quests(i).QuestIndex
            If N > 0 Then
                If QuestList(N).RequiredKills > 0 Then
                    .QuestStats.Quests(i).UsersKilled = .QuestStats.Quests(i).UsersKilled + 1
                End If
            End If
        Next i

        'Call UserDie(VictimIndex)

        'Call Flushbuffer(victimIndex)
        'Call Flushbuffer(attackerIndex)

        'Log
        Call LogAsesinato(.Name & " asesino a " & UserList(VictimIndex).Name & " - Victim: " & UserList(VictimIndex).IP & " - Attacker:" & UserList(attackerIndex).IP)
    End With
End Sub

Public Sub RevivirUsuario(ByVal UserIndex As Integer, Optional ByVal FullHP As Boolean = False)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)


        If .XvsX.Slot_ID > 0 Then
            If .flags.Muerto > 0 Then
                Call ResuciteinxVsX(.XvsX.Team_ID)
            End If
        End If

        .flags.Muerto = 0
        '.Stats.MinHP = .Stats.UserAtributos(eAtributos.Constitucion)

        If .flags.Envenenado = 1 Then
            .flags.Envenenado = 0
        End If

        Call WriteUpdateEnvenenado(UserIndex)

        If .Stats.MinHP > .Stats.MaxHP Then
            .Stats.MinHP = .Stats.MaxHP
        End If

        If FullHP Then
            .Stats.MinHP = .Stats.MaxHP
        Else
            .Stats.MinHP = 10
        End If

        If .flags.Navegando = 1 Then
            Call ToogleBoatBody(UserIndex)
        Else
            Call DarCuerpoDesnudo(UserIndex)

            .Char.Head = .OrigChar.Head
        End If

        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
        Call WriteUpdateUserStats(UserIndex)
    End With
End Sub

Public Sub ToogleBoatBody(ByVal UserIndex As Integer)
'***************************************************
'Author: ZaMa
'Last Modification: 13/01/2010
'Gives boat body depending on user alignment.
'***************************************************

    With UserList(UserIndex)


        .Char.Head = 0

        ' Barco de armada
        'If .Faccion.ArmadaReal = 1 Then
        'Char.body = iFragataReal

        ' Barco de caos
        'ElseIf .Faccion.FuerzasCaos = 1 Then
        'Char.body = iFragataCaos

        'Barcos neutrales

        Select Case .Invent.BarcoObjIndex
        Case 474
            .Char.body = 84

        Case 475
            .Char.body = 85

        Case 476
            .Char.body = 86
        End Select


        .Char.ShieldAnim = NingunEscudo
        .Char.WeaponAnim = NingunArma
        .Char.CascoAnim = NingunCasco
    End With

End Sub

Public Sub ChangeUserBody(ByVal sndRoute As SendTarget, ByVal UserIndex As Integer, ByVal body As Integer)

'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 18/09/20
'***************************************************

    With UserList(UserIndex)
        .Char.body = body
        'If .Char.BodyTempEvent > 0 Then
        '    If .flags.Muerto < 1 Then
        '        Body = .Char.BodyTempEvent
        '    End If
        'End If
        Call SendData(sndRoute, UserIndex, PrepareMessageCharacterChangeBody(.Char.CharIndex, body))
    End With

End Sub

Public Sub ChangeUserWeapon(ByVal sndRoute As SendTarget, ByVal UserIndex As Integer, ByVal Weapon As Byte)

'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 18/09/20
'***************************************************

    With UserList(UserIndex).Char
        .WeaponAnim = Weapon

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            Call SendData(ToIndex, UserIndex, PrepareMessageCharacterChangeWeapon(.CharIndex, Weapon))
        Else
            Call SendData(sndRoute, UserIndex, PrepareMessageCharacterChangeWeapon(.CharIndex, Weapon))
        End If
    End With

End Sub

Public Sub ChangeUserShield(ByVal sndRoute As SendTarget, ByVal UserIndex As Integer, ByVal Shield As Byte)

'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 18/09/20
'***************************************************

    With UserList(UserIndex).Char
        .ShieldAnim = Shield

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            Call SendData(ToIndex, UserIndex, PrepareMessageCharacterChangeShield(.CharIndex, Shield))
        Else
            Call SendData(sndRoute, UserIndex, PrepareMessageCharacterChangeShield(.CharIndex, Shield))
        End If
    End With

End Sub

Public Sub ChangeUserHelmet(ByVal sndRoute As SendTarget, ByVal UserIndex As Integer, ByVal Helmet As Byte)

'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 18/09/20
'***************************************************

    With UserList(UserIndex).Char
        .CascoAnim = Helmet

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            Call SendData(ToIndex, UserIndex, PrepareMessageCharacterChangeHelmet(.CharIndex, Helmet))
        Else
            Call SendData(sndRoute, UserIndex, PrepareMessageCharacterChangeHelmet(.CharIndex, Helmet))
        End If
    End With

End Sub

Public Sub ChangeUserSpecial(ByVal sndRoute As SendTarget, ByVal UserIndex As Integer, ByVal Special As Byte)

'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 18/09/20
'***************************************************

    With UserList(UserIndex).Char
        '.Body = Body

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            Call SendData(ToIndex, UserIndex, PrepareMessageCharacterChangeSpecial(.CharIndex, Special))
        Else
            Call SendData(sndRoute, UserIndex, PrepareMessageCharacterChangeSpecial(.CharIndex, Special))
        End If

    End With

End Sub

Public Sub ChangeUserChar(ByVal UserIndex As Integer, ByVal body As Integer, ByVal Head As Integer, ByVal Heading As Byte, _
                          ByVal Arma As Integer, ByVal Escudo As Integer, ByVal casco As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    If UserList(UserIndex).flags.EnEvento = 3 And UserList(UserIndex).flags.Privilegios = PlayerType.User Then Exit Sub

    With UserList(UserIndex).Char

        .body = body
        .Head = Head
        .Heading = Heading
        .WeaponAnim = Arma
        .ShieldAnim = Escudo
        .CascoAnim = casco

        If UserList(UserIndex).flags.Muerto <> 0 Then
            If UserList(UserIndex).flags.Navegando = 0 Then
                If (UserList(UserIndex).faccion.FuerzasCaos > 0) Or (UserList(UserIndex).faccion.Status = FaccionType.ChaosCouncil) Then
                    .body = 145
                    .Head = 501
                Else
                    .body = 8
                    .Head = 500
                End If
                .ShieldAnim = NingunEscudo
                .WeaponAnim = NingunArma
                .CascoAnim = NingunCasco
            Else
                .body = 87
            End If
        End If

        If UserList(UserIndex).flags.AdminInvisible = 1 Then
            UserList(UserIndex).OrigChar.body = body
            UserList(UserIndex).OrigChar.Heading = Heading
            UserList(UserIndex).flags.OldBody = body
            UserList(UserIndex).flags.OldHead = Head
            UserList(UserIndex).OrigChar.Heading = Heading
            UserList(UserIndex).OrigChar.WeaponAnim = Arma
            UserList(UserIndex).OrigChar.ShieldAnim = Escudo
            UserList(UserIndex).OrigChar.CascoAnim = casco
        End If

        If UserList(UserIndex).flags.AdminInvisible = 0 Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterChange(body, Head, Heading, .CharIndex, Arma, Escudo, .FX, .loops, casco))
        Else
            Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageCharacterChange(body, Head, Heading, .CharIndex, Arma, Escudo, .FX, .loops, casco))
        End If
    End With
End Sub

Public Function GetWeaponAnim(ByVal UserIndex As Integer, ByVal ObjIndex As Integer) As Integer
'***************************************************
'Author: Torres Patricio (Pato)
'Last Modification: 03/29/10
'
'***************************************************
    On Error GoTo Errhandler

    Dim Tmp As Integer

    If ObjIndex = 0 Then Exit Function

2   With UserList(UserIndex)
1       Tmp = ObjData(ObjIndex).WeaponRazaEnanaAnim

3       If Tmp > 0 Then
4           If .raza = eRaza.Enano Or .raza = eRaza.Gnomo Then
5               GetWeaponAnim = Tmp
                Exit Function
            End If
        End If

        GetWeaponAnim = ObjData(ObjIndex).WeaponAnim
    End With
    Exit Function
Errhandler:
    Call LogError("Error en GetWeaponAnim en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Sub EnviarFama(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim L As Long

    With UserList(UserIndex).Reputacion
        L = (-.AsesinoRep) + _
            (-.BandidoRep) + _
            .BurguesRep + _
            (-.LadronesRep) + _
            .NobleRep + _
            .PlebeRep
        L = Round(L / 6)

        .Promedio = L
    End With

    Call WriteFame(UserIndex)
End Sub

Public Sub EraseUserChar(ByVal UserIndex As Integer, ByVal IsAdminInvisible As Boolean)
'*************************************************
'Author: Unknown
'Last modified: 08/01/2009
'08/01/2009: ZaMa - No se borra el char de un admin invisible en todos los clientes excepto en su mismo cliente.
'*************************************************

    On Error GoTo ErrorHandler

1   With UserList(UserIndex)
        Dim tmpn As String
        tmpn = .Name

        If .Char.CharIndex = 0 Then
            Debug.Print Now, .Name & " no tiene char.": Exit Sub
        End If

2       CharList(.Char.CharIndex) = 0

3       If .Char.CharIndex = LastChar Then
4           Do Until CharList(LastChar) > 0
5               LastChar = LastChar - 1
                If LastChar <= 1 Then Exit Do
            Loop
        End If

        ' Si esta invisible, solo el sabe de su propia existencia, es innecesario borrarlo en los demas clientes
6       If IsAdminInvisible Then
7           Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageCharacterRemove(.Char.CharIndex))
        Else
            'Le mandamos el mensaje para que borre el personaje a los clientes que estén cerca
8           Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterRemove(.Char.CharIndex))
        End If

9       Call QuitarUser(UserIndex, .Pos.Map)

10      MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = 0
11      .Char.CharIndex = 0
    End With

12  NumChars = NumChars - 1
    Exit Sub

ErrorHandler:
    Call LogError("Error en EraseUserchar en " & Erl & " - " & tmpn & ". " & Err.Number & ": " & Err.Description)
End Sub

Public Sub RefreshCharStatus(ByVal UserIndex As Integer)
'*************************************************
'Author: Tararira
'Last modified: 04/07/2009
'Refreshes the status and tag of UserIndex.
'04/07/2009: ZaMa - Ahora mantenes la fragata fantasmal si estas muerto.
'*************************************************
    Dim addStr As String
    Dim NickColor As Byte

    With UserList(UserIndex)
        If .GuildIndex > 0 Then
            addStr = modGuilds.GuildName(.GuildIndex)
            addStr = " <" & addStr & ">"
        End If

        If .faccion.Status = FaccionType.ChaosCouncil Then
            addStr = addStr & "*"
        ElseIf .faccion.Status = FaccionType.RoyalCouncil Then
            addStr = addStr & "/"
        End If

        NickColor = GetNickColor(UserIndex)

        If .showName Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageUpdateTagAndStatus(UserIndex, NickColor, .Name & addStr))
        Else
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageUpdateTagAndStatus(UserIndex, NickColor, vbNullString))
        End If

        'Si esta navengando, se cambia la barca.
        If .flags.Navegando Then
            If .flags.Muerto = 1 Then
                .Char.body = iFragataFantasmal
            Else
                Call ToogleBoatBody(UserIndex)
            End If

            Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
        End If
        'ustedes se preguntaran que hace esto aca?
        'bueno la respuesta es simple: el codigo de AO es una mierda y encontrar
        'todos los puntos en los cuales la alineacion puede cambiar es un dolor de
        'huevos, asi que lo controlo aca, cada 6 segundos, lo cual es razonable

        Dim NuevaA As Boolean
        Dim GI As Integer
        Dim tStr As String

        GI = .GuildIndex

        If GI > 0 Then
            NuevaA = False

            If Not modGuilds.m_ValidarPermanencia(UserIndex, True, NuevaA) Then
                Call WriteMensajes(UserIndex, Mensaje_405)
            End If

            If NuevaA Then
                Call SendData(SendTarget.ToGuildMembers, GI, PrepareMessageConsoleMsg("¡El clan ha pasado a tener alineación " & modGuilds.GuildAlignment(GI) & "!", FontTypeNames.FONTTYPE_GUILD))
                tStr = modGuilds.GuildName(GI)
                Call LogClanes("¡El clan " & tStr & " cambio de alineación!")
            End If

        End If
    End With
End Sub

Public Function GetNickColor(ByVal UserIndex As Integer) As Byte
'*************************************************
'Author: ZaMa
'Last modified: 15/01/2010
'
'*************************************************

    With UserList(UserIndex)

        If criminal(UserIndex) Then
            GetNickColor = eNickColor.ieCriminal
        Else
            GetNickColor = eNickColor.ieCiudadano
        End If

        If .flags.EnEvento = 3 Then GetNickColor = eNickColor.ieCiudadano
    End With

End Function

Public Sub MakeUserChar(ByVal toMap As Boolean, ByVal sndIndex As Integer, ByVal UserIndex As Integer, _
                        ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ButIndex As Boolean = False)
'*************************************************
'Author: Unknown
'Last modified: 15/01/2010
'23/07/2009: Budi - Ahora se envía el nick
'15/01/2010: ZaMa - Ahora se envia el color del nick.
'*************************************************

    On Error GoTo Errhandler

    Dim CharIndex As Integer
    Dim ClanTag As String
    Dim NickColor As Byte
    Dim UserName As String
    Dim Privileges As Byte

    With UserList(UserIndex)

        If InMapBounds(Map, X, Y) Then
            'If needed make a new character in list
            If .Char.CharIndex = 0 Then
                CharIndex = NextOpenCharIndex
                .Char.CharIndex = CharIndex
                CharList(CharIndex) = UserIndex
            End If

            'Place character on map if needed
            If toMap Then MapData(Map, X, Y).UserIndex = UserIndex

            'Send make character command to clients
            If Not toMap Then
                If .GuildIndex > 0 Then
                    ClanTag = modGuilds.GuildName(.GuildIndex)
                End If

                NickColor = GetNickColor(UserIndex)
                Privileges = .flags.Privilegios

                'Preparo el nick
                If .showName Then
                    UserName = .Name

                    If .flags.EnConsulta Then
                        UserName = UserName & " " & TAG_CONSULT_MODE
                    Else
                        'If UserList(sndIndex).flags.Privilegios <= PlayerType.Consejero Then
                        '    If LenB(ClanTag) <> 0 Then UserName = UserName & " <" & ClanTag & ">"
                        'Else
                        If LenB(ClanTag) <> 0 Then UserName = UserName & " <" & ClanTag & ">"

                        If (.flags.oculto) And (Not .flags.AdminInvisible = 1) Then
                            UserName = UserName & " " & TAG_USER_OCULTO
                        ElseIf (.flags.invisible) And (Not .flags.AdminInvisible = 1) Then
                            UserName = UserName & " " & TAG_USER_INVISIBLE
                        ElseIf .flags.AdminInvisible = 1 Then
                            UserName = UserName & "1"
                        End If

                        If .flags.Envenenado = 1 Then
                            UserName = UserName & "_"
                        End If

                        'End If
                    End If
                    If .faccion.Status = FaccionType.ChaosCouncil Then
                        UserName = UserName & "*"
                    ElseIf .faccion.Status = FaccionType.RoyalCouncil Then
                        UserName = UserName & "/"
                    End If

                End If

                If .flags.Muerto <> 0 Then
                    If .flags.Navegando = 0 Then
                        If (.faccion.FuerzasCaos > 0) Or (.faccion.Status = FaccionType.ChaosCouncil) Then
                            .Char.body = 145
                            .Char.Head = 501
                        Else
                            .Char.body = 8
                            .Char.Head = 500
                        End If
                        .Char.ShieldAnim = NingunEscudo
                        .Char.WeaponAnim = NingunArma
                        .Char.CascoAnim = NingunCasco
                    Else
                        .Char.body = 87
                    End If
                End If

                If .flags.oculto Then

                End If

                If .flags.Mimetizado <> 0 Then
                    UserName = .flags.Mimetizado_Nick    '""
                    NickColor = .flags.Mimetizado_Color
                End If

                If .flags.EnEvento = 3 Then
                    Call WriteCharacterCreate(sndIndex, 1, 1, .Char.Heading, .Char.CharIndex, X, Y, .Char.WeaponAnim, .Char.ShieldAnim, .Char.FX, 999, .Char.CascoAnim, "Participante", NickColor, 0)
                Else
                    Call WriteCharacterCreate(sndIndex, .Char.body, .Char.Head, .Char.Heading, .Char.CharIndex, X, Y, .Char.WeaponAnim, .Char.ShieldAnim, .Char.FX, 999, .Char.CascoAnim, UserName, NickColor, Privileges)
                End If
            Else
                'Hide the name and clan - set privs as normal user
                Call AgregarUser(UserIndex, .Pos.Map, ButIndex)
            End If
        End If
    End With
    Exit Sub

Errhandler:
    LogError ("MakeUserChar: num: " & Err.Number & " desc: " & Err.Description)
    'Resume Next
    Call CloseSocket(UserIndex)
End Sub

''
' Checks if the user gets the next level.
'
' @param UserIndex Specifies reference to user

Public Sub CheckUserLevel(ByVal UserIndex As Integer)

    Dim Pts As Integer
    Dim AumentoHIT As Integer
    Dim AumentoMANA As Integer
    Dim AumentoSTA As Integer
    Dim AumentoHP As Integer
    Dim WasNewbie As Boolean
    Dim GI As Integer        'Guild Index

    Dim MinHP As Integer
    Dim MaxHP As Integer
    Dim IsLevelUP As Boolean
    Dim promup As Integer

    On Error GoTo Errhandler

    WasNewbie = EsNewbie(UserIndex)

    With UserList(UserIndex)

        Do While (.Stats.Exp >= .Stats.elu)

            'Checkea otra vez, esto sucede si tiene mas EXP y puede saltarse el maximo nivel
            If .Stats.ELV >= STAT_MAXELV Then
                .Stats.Exp = 0
                .Stats.elu = 0
                GoTo PasoNivel
                Exit Sub
            End If

            'Store it!
            'Call Statistics.UserLevelUp(UserIndex)

            IsLevelUP = True

            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_NIVEL, .Pos.X, .Pos.Y))
            WriteMensajes UserIndex, e_Mensajes.Mensaje_47

            If .Stats.ELV = 1 Then
                Pts = 10
            Else
                'For multiple levels being rised at once
                Pts = Pts + 5
            End If

            .Stats.ELV = .Stats.ELV + 1

            .Stats.Exp = .Stats.Exp - .Stats.elu

            'Nueva subida de exp x lvl. Pablo (ToxicWaste)
            If .Stats.ELV = 2 Then
                .Stats.elu = 450
            ElseIf .Stats.ELV = 3 Then
                .Stats.elu = 675
            ElseIf .Stats.ELV = 4 Then
                .Stats.elu = 1012
            ElseIf .Stats.ELV = 5 Then
                .Stats.elu = 1518
            ElseIf .Stats.ELV = 6 Then
                .Stats.elu = 2277
            ElseIf .Stats.ELV = 7 Then
                .Stats.elu = 3416
            ElseIf .Stats.ELV = 8 Then
                .Stats.elu = 5124
            ElseIf .Stats.ELV = 9 Then
                .Stats.elu = 7886
            ElseIf .Stats.ELV = 10 Then
                .Stats.elu = 11529
            ElseIf .Stats.ELV = 11 Then
                .Stats.elu = 14988
            ElseIf .Stats.ELV = 12 Then
                .Stats.elu = 19484
            ElseIf .Stats.ELV = 13 Then
                .Stats.elu = 25329
            ElseIf .Stats.ELV = 14 Then
                .Stats.elu = 32928
            ElseIf .Stats.ELV = 15 Then
                .Stats.elu = 42806
            ElseIf .Stats.ELV = 16 Then
                .Stats.elu = 55648
            ElseIf .Stats.ELV = 17 Then
                .Stats.elu = 72342
            ElseIf .Stats.ELV = 18 Then
                .Stats.elu = 94045
            ElseIf .Stats.ELV = 19 Then
                .Stats.elu = 122259
            ElseIf .Stats.ELV = 20 Then
                .Stats.elu = 158937
            ElseIf .Stats.ELV = 21 Then
                .Stats.elu = 206618
            ElseIf .Stats.ELV = 22 Then
                .Stats.elu = 268603
            ElseIf .Stats.ELV = 23 Then
                .Stats.elu = 349184
            ElseIf .Stats.ELV = 24 Then
                .Stats.elu = 453939
            ElseIf .Stats.ELV = 25 Then
                .Stats.elu = 544727
            ElseIf .Stats.ELV = 26 Then
                .Stats.elu = 667632
            ElseIf .Stats.ELV = 27 Then
                .Stats.elu = 784406
            ElseIf .Stats.ELV = 28 Then
                .Stats.elu = 941287
            ElseIf .Stats.ELV = 29 Then
                .Stats.elu = 1129544
            ElseIf .Stats.ELV = 30 Then
                .Stats.elu = 1355453
            ElseIf .Stats.ELV = 31 Then
                .Stats.elu = 1626544
            ElseIf .Stats.ELV = 32 Then
                .Stats.elu = 1951853
            ElseIf .Stats.ELV = 33 Then
                .Stats.elu = 2342224
            ElseIf .Stats.ELV = 34 Then
                .Stats.elu = 3372803
            ElseIf .Stats.ELV = 35 Then
                .Stats.elu = 4047364
            ElseIf .Stats.ELV = 36 Then
                .Stats.elu = 5828204
            ElseIf .Stats.ELV = 37 Then
                .Stats.elu = 6993845
            ElseIf .Stats.ELV = 38 Then
                .Stats.elu = 8392614
            ElseIf .Stats.ELV = 39 Then
                .Stats.elu = 10071137
            ElseIf .Stats.ELV = 40 Then
                .Stats.elu = 120853640
            ElseIf .Stats.ELV = 41 Then
                .Stats.elu = 145024370
            ElseIf .Stats.ELV = 42 Then
                .Stats.elu = 174029240
            ElseIf .Stats.ELV = 43 Then
                .Stats.elu = 208835090
            ElseIf .Stats.ELV = 44 Then
                .Stats.elu = 417670180
            ElseIf .Stats.ELV = 45 Then
                .Stats.elu = 835340360
            ElseIf .Stats.ELV = 46 Then
                .Stats.elu = 1670680720
            Else
                .Stats.elu = 0
            End If

            Select Case .Clase

            Case eClass.Warrior
                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21    'enano
                    MinHP = 9
                    MaxHP = 12
                Case 20
                    MinHP = 8
                    MaxHP = 12
                Case 19
                    MinHP = 8
                    MaxHP = 11
                Case Else
                    MinHP = 7
                    MaxHP = 11
                End Select

                AumentoHIT = IIf(.Stats.ELV > 35, 2, 3)
                AumentoSTA = AumentoSTDef

            Case eClass.Hunter

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 9
                    MaxHP = 11
                Case 20
                    MinHP = 8
                    MaxHP = 11
                Case 19
                    MinHP = 6
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 10
                End Select

                AumentoHIT = IIf(.Stats.ELV > 35, 2, 3)
                AumentoSTA = AumentoSTDef

            Case eClass.Pirat

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 9
                    MaxHP = 11
                Case 20
                    MinHP = 8
                    MaxHP = 11
                Case 19
                    MinHP = 7
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 11
                End Select

                AumentoHIT = 2
                AumentoSTA = AumentoSTDef

            Case eClass.Paladin

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 9
                    MaxHP = 11
                Case 20
                    MinHP = 8
                    MaxHP = 11
                Case 19
                    MinHP = 7
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 11
                End Select

                AumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoSTA = AumentoSTDef

            Case eClass.Thief

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 6
                    MaxHP = 9
                Case 20
                    MinHP = 5
                    MaxHP = 9
                Case 19
                    MinHP = 4
                    MaxHP = 9
                Case Else
                    MinHP = 4
                    MaxHP = 8
                End Select

                AumentoHIT = 2
                AumentoSTA = AumentoSTLadron

            Case eClass.Mage

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 6
                    MaxHP = 9
                Case 20
                    MinHP = 5
                    MaxHP = 8
                Case 19
                    MinHP = 4
                    MaxHP = 8
                Case Else
                    MinHP = 3
                    MaxHP = 8
                End Select

                AumentoHIT = 1
                AumentoSTA = AumentoSTMago

                If (.Stats.MaxMAN >= 2000) Then
                    AumentoMANA = (3 * .Stats.UserAtributos(eAtributos.Inteligencia)) / 2
                Else
                    AumentoMANA = 3 * .Stats.UserAtributos(eAtributos.Inteligencia)
                End If

            Case eClass.Miner, eClass.Carpenter, eClass.Woodcutter, eClass.Fisherman

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 9
                    MaxHP = 12
                Case 20
                    MinHP = 8
                    MaxHP = 12
                Case 19
                    MinHP = 7
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 11
                End Select

                AumentoHIT = 2
                AumentoSTA = AumentoSTTrabajador

            Case eClass.Cleric

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 7
                    MaxHP = 10
                Case 20
                    MinHP = 6
                    MaxHP = 10
                Case 19
                    MinHP = 6
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoSTA = AumentoSTDef

            Case eClass.Druid

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 7
                    MaxHP = 10
                Case 20
                    MinHP = 6
                    MaxHP = 10
                Case 19
                    MinHP = 6
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoSTA = AumentoSTDef

            Case eClass.Assasin

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 7
                    MaxHP = 10
                Case 20
                    MinHP = 6
                    MaxHP = 10
                Case 19
                    MinHP = 6
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoSTA = AumentoSTDef

            Case eClass.Bard

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 7
                    MaxHP = 10
                Case 20
                    MinHP = 6
                    MaxHP = 10
                Case 19
                    MinHP = 6
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoSTA = AumentoSTDef

            Case Else

                Select Case .Stats.UserAtributos(eAtributos.Constitucion)
                Case 21
                    MinHP = 6
                    MaxHP = 8
                Case 20
                    MinHP = 5
                    MaxHP = 8
                Case 19
                    MinHP = 4
                    MaxHP = 8
                Case Else
                    MinHP = 3
                    MaxHP = 8
                End Select

                AumentoHIT = 2
                AumentoSTA = AumentoSTDef

            End Select

            'Actualizamos HitPoints
            promup = RandomNumber(MinHP, MaxHP)

            If promup < MaxHP Then
                If (.Stats.MaxHP - (((MinHP + MaxHP) / 2) * (.Stats.ELV - 1) + 20)) < 8 Then
                    promup = promup + IIf(RandomNumber(1, 11) = 1, 1, 0)
                End If
                If promup > MaxHP Then promup = MaxHP
            End If
            AumentoHP = promup

            .Stats.MaxHP = .Stats.MaxHP + AumentoHP

            If .Stats.MaxHP > STAT_MAXHP Then .Stats.MaxHP = STAT_MAXHP

            'Actualizamos Stamina
            .Stats.MaxSta = .Stats.MaxSta + AumentoSTA
            If .Stats.MaxSta > STAT_MAXSTA Then .Stats.MaxSta = STAT_MAXSTA

            'Actualizamos Mana
            .Stats.MaxMAN = .Stats.MaxMAN + AumentoMANA
            If .Stats.MaxMAN > STAT_MAXMAN Then .Stats.MaxMAN = STAT_MAXMAN

            'Actualizamos Golpe Máximo
            .Stats.MaxHIT = .Stats.MaxHIT + AumentoHIT

            'Actualizamos Golpe Mínimo
            .Stats.MinHIT = .Stats.MinHIT + AumentoHIT

            'Notificamos al user
            If AumentoHP > 0 Then
                Call WriteConsoleMsg(UserIndex, "Has ganado " & AumentoHP & " puntos de vida.", FontTypeNames.FONTTYPE_INFO)
            End If

            If AumentoSTA > 0 Then
                Call WriteConsoleMsg(UserIndex, "Has ganado " & AumentoSTA & " puntos de energía.", FontTypeNames.FONTTYPE_INFO)
            End If

            If AumentoMANA > 0 Then
                Call WriteConsoleMsg(UserIndex, "Has ganado " & AumentoMANA & " puntos de maná.", FontTypeNames.FONTTYPE_INFO)
            End If

            If AumentoHIT > 0 Then
                Call WriteConsoleMsg(UserIndex, "Tu golpe máximo aumentó en " & AumentoHIT & " puntos.", FontTypeNames.FONTTYPE_INFO)
                Call WriteConsoleMsg(UserIndex, "Tu golpe mínimo aumentó en " & AumentoHIT & " puntos.", FontTypeNames.FONTTYPE_INFO)
            End If

            If .Stats.ELV > 10 Then
                Dim partystr As String

                If .PartyIndex Then
                    partystr = "En party con: " & GetPartyString(UserIndex)
                End If

                Call LogDesarrolloNiveles(.Name & " subió a " & .Stats.ELV & " AumentoHP: " & AumentoHP & " - De:" & .Stats.MaxHP & " a " & .Stats.MaxHP + AumentoHP & " - " & partystr)
            End If

            .Stats.MinHP = .Stats.MaxHP

            If .Stats.ELV = 25 Then
                GI = .GuildIndex
                If GI > 0 Then
                    If modGuilds.GuildAlignment(GI) = "Del Mal" Or modGuilds.GuildAlignment(GI) = "Real" Then
                        'We get here, so guild has factionary alignment, we have to expulse the user
                        Call modGuilds.m_EcharMiembroDeClan(-1, .Name)
                        Call SendData(SendTarget.ToGuildMembers, GI, PrepareMessageConsoleMsg(.Name & " deja el clan.", FontTypeNames.FONTTYPE_GUILD))
                        Call WriteConsoleMsg(UserIndex, "¡Ya tienes la madurez suficiente como para decidir bajo que estandarte pelearás! Por esta razón, hasta tanto no te enlistes en la facción bajo la cual tu clan está alineado, estarás excluído del mismo.", FontTypeNames.FONTTYPE_GUILD)
                    End If
                End If
            End If

            'Call Flushbuffer(UserIndex)

        Loop

PasoNivel:

        If Not IsLevelUP Then Exit Sub

        'If it ceased to be a newbie, remove newbie items and get char away from newbie dungeon
        If Not EsNewbie(UserIndex) And WasNewbie Then
            Call QuitarNewbieObj(UserIndex)
            If UCase$(MapInfo(.Pos.Map).Restringir) = "NEWBIE" Then
                Call WarpUserCharX(UserIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y, True)
                Call WriteConsoleMsg(UserIndex, "Has abandonado el Dungeon Newbie.", FontTypeNames.FONTTYPE_INFO)
            End If
        End If

        'Send all gained skill points at once (if any)
        If Pts > 0 Then
            .Stats.SkillPts = .Stats.SkillPts + Pts
            Call WriteLevelUp(UserIndex, .Stats.SkillPts)
            Call WriteIntervalos(UserIndex)
            Call WriteConsoleMsg(UserIndex, "Has ganado un total de " & Pts & " skillpoints.", FontTypeNames.FONTTYPE_INFO)
        End If

    End With

    Call CheckRankingUser(UserIndex, TopNivel)

    Call WriteUpdateUserStats(UserIndex)

    ' ++ Por si las putas jejox
    Call SaveUser(UserIndex, CharPath & UCase$(UserList(UserIndex).Name) & ".chr")

    Exit Sub

Errhandler:
    Call LogError("Error en la subrutina CheckUserLevel - Error : " & Err.Number & " - Description : " & Err.Description)
End Sub
Public Function gethp(ByVal Promedio As Double) As Double
    Dim X As Integer
    X = RandomNumber(1, 1000)
    If Int(Promedio) <> Promedio Then
        Select Case X
        Case 1 To 250
            gethp = 0.5
        Case 251 To 500
            gethp = -0.5
        Case 501 To 750
            gethp = 0.5
        Case 751 To 1000
            gethp = -0.5
        End Select
    Else
        Select Case X
        Case 1 To 250
            gethp = 1
        Case 251 To 500
            gethp = -1
        Case 501 To 750
            gethp = 1
        Case 751 To 1000
            gethp = -1
        End Select
    End If
End Function

Public Function PuedeAtravesarAgua(ByVal UserIndex As Integer) As Boolean
    PuedeAtravesarAgua = UserList(UserIndex).flags.Navegando = 1
    If EsGM(UserIndex) Then
        PuedeAtravesarAgua = True
    End If
End Function

Sub MoveUserChar(ByVal UserIndex As Integer, ByVal nHeading As eHeading)
'*************************************************
'Author: Unknown
'Last modified: 13/07/2009
'Moves the char, sending the message to everyone in range.
'30/03/2009: ZaMa - Now it's legal to move where a casper is, changing its pos to where the moving char was.
'28/05/2009: ZaMa - When you are moved out of an Arena, the resurrection safe is activated.
'13/07/2009: ZaMa - Now all the clients don't know when an invisible admin moves, they force the admin to move.
'13/07/2009: ZaMa - Invisible admins aren't allowed to force dead characater to move
'*************************************************
    Dim nPos As WorldPos
    Dim sailing As Boolean
    Dim CasperIndex As Integer
    Dim CasperHeading As eHeading
    Dim isAdminInvi As Boolean

    sailing = PuedeAtravesarAgua(UserIndex)
    nPos = UserList(UserIndex).Pos

    Call HeadtoPos(nHeading, nPos)

    isAdminInvi = (UserList(UserIndex).flags.AdminInvisible = 1)

    If MoveToLegalPos(UserList(UserIndex).Pos.Map, nPos.X, nPos.Y, sailing, Not sailing, UserIndex) Then
        'si no estoy solo en el mapa...
        If MapInfo(UserList(UserIndex).Pos.Map).NumUsers > 1 Then

            CasperIndex = MapData(UserList(UserIndex).Pos.Map, nPos.X, nPos.Y).UserIndex
            'Si hay un usuario, y paso la validacion, entonces es un casper
            If CasperIndex > 0 Then
                ' Los admins invisibles no pueden patear caspers
                If Not isAdminInvi Then

                    With UserList(CasperIndex)
                        CasperHeading = InvertHeading(nHeading)
                        Call HeadtoPos(CasperHeading, .Pos)

                        ' Si es un admin invisible, no se avisa a los demas clientes
                        If .flags.AdminInvisible < 1 Then
                            Call SendData(SendTarget.ToPCAreaButIndex, CasperIndex, PrepareMessageCharacterMoves(.Char.CharIndex, CasperHeading))
                        End If

                        Call WriteForceCharMove(CasperIndex, CasperHeading)

                        'Update map and char
                        .Char.Heading = CasperHeading
                        MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = CasperIndex

                    End With

                    'Actualizamos las áreas de ser necesario
                    Call ModAreas.CheckUpdateNeededUser(CasperIndex, CasperHeading)
                End If
            End If

            ' Si es un admin invisible, no se avisa a los demas clientes
            If Not isAdminInvi Then
                Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageCharacterMoves(UserList(UserIndex).Char.CharIndex, nHeading))
            End If

        End If

        ' Los admins invisibles no pueden patear caspers
        If (Not isAdminInvi) Or (CasperIndex = 0) Then

            With UserList(UserIndex)

                If CasperIndex = 0 Then
                    MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = 0
                End If

                .Pos = nPos
                .Char.Heading = nHeading
                MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex = UserIndex

                If MapData(nPos.Map, nPos.X, nPos.Y).trigger = eTrigger.AutoResu Then
                    Call Extra.AutoCurar(UserIndex)
                End If

                Call DoTileEvents(UserIndex, .Pos.Map, .Pos.X, .Pos.Y)
            End With

            Call ModAreas.CheckUpdateNeededUser(UserIndex, nHeading)
        Else
            Call WritePosUpdate(UserIndex)
        End If

    Else

        Dim RestarX As Integer, RestarY As Integer

        Select Case nHeading
        Case eHeading.NORTH
            RestarY = 1
        Case eHeading.SOUTH
            RestarY = -1
        Case eHeading.EAST
            RestarX = -1
        Case eHeading.WEST
            RestarX = 1
        End Select

        With UserList(UserIndex)

            'Validate heading (VB won't say invalid cast if not a valid index like .Net languages would do... *sigh*)
            If nHeading > 0 And nHeading < 5 Then
                If .Char.Heading <> nHeading Then
                    .Char.Heading = nHeading
 
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChangeHeading(.Char.CharIndex, nHeading))
                End If
            End If

            ' ++ Evitamos que el personaje rebote.
            If MapData(.Pos.Map, nPos.X, nPos.Y).Blocked <> 0 Then
                Call Bloquear(False, UserIndex, nPos.X, nPos.Y, True)
            End If

            Call WritePosUpdate(UserIndex)

        End With

    End If

    If UserList(UserIndex).Counters.Trabajando Then UserList(UserIndex).Counters.Trabajando = UserList(UserIndex).Counters.Trabajando - 1
    If UserList(UserIndex).Counters.Ocultando Then UserList(UserIndex).Counters.Ocultando = UserList(UserIndex).Counters.Ocultando - 1

End Sub

Public Function InvertHeading(ByVal nHeading As eHeading) As eHeading
'*************************************************
'Author: ZaMa
'Last modified: 30/03/2009
'Returns the heading opposite to the one passed by val.
'*************************************************
    Select Case nHeading
    Case eHeading.EAST
        InvertHeading = WEST
    Case eHeading.WEST
        InvertHeading = EAST
    Case eHeading.SOUTH
        InvertHeading = NORTH
    Case eHeading.NORTH
        InvertHeading = SOUTH
    End Select
End Function

Sub ChangeUserInv(ByVal UserIndex As Integer, ByVal Slot As Byte, ByRef Object As UserOBJ)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    UserList(UserIndex).Invent.Object(Slot) = Object
    Call WriteChangeInventorySlot(UserIndex, Slot)
End Sub

Function NextOpenCharIndex() As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    For LoopC = 1 To MAXCHARS
        If CharList(LoopC) = 0 Then
            NextOpenCharIndex = LoopC
            NumChars = NumChars + 1

            If LoopC > LastChar Then _
               LastChar = LoopC

            Exit Function
        End If
    Next LoopC
End Function

Function NextOpenUser() As Integer
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    On Error GoTo Errhandler

    Dim LoopC As Long

1   For LoopC = 1 To maxUsers + 1
2       If LoopC > maxUsers Then Exit For
3       If (UserList(LoopC).ConnIDValida = False And UserList(LoopC).flags.UserLogged = False) Then Exit For
4   Next LoopC

5   NextOpenUser = LoopC
    Exit Function
Errhandler:
    Call LogError("Error en NextOpenUser en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Function

Public Sub SendUserStatsTxt(ByVal SendIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim GuildI As Integer

    With UserList(UserIndex)
        Call WriteConsoleMsg(SendIndex, "Estadísticas de: " & .Name & " (NIVEL: " & .Stats.ELV & "  EXP: " & .Stats.Exp & "/" & .Stats.elu & ") " & Round(CDbl(.Stats.Exp) * CDbl(100) / CDbl(.Stats.elu)) & "%", FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Clase: " & ListaClases(.Clase) & " " & ListaRazas(.raza) & " " & IIf(.Genero = Hombre, "Hombre.", "Mujer."), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Salud: " & .Stats.MinHP & "/" & .Stats.MaxHP & "  Maná: " & .Stats.MinMAN & "/" & .Stats.MaxMAN & "  Energía: " & .Stats.minSta & "/" & .Stats.MaxSta, FontTypeNames.FONTTYPE_INFO)

        If .Invent.WeaponEqpObjIndex > 0 Then
            Call WriteConsoleMsg(SendIndex, "Menor Golpe/Mayor Golpe: " & .Stats.MinHIT & "/" & .Stats.MaxHIT & " (" & ObjData(.Invent.WeaponEqpObjIndex).MinHIT & "/" & ObjData(.Invent.WeaponEqpObjIndex).MaxHIT & ")", FontTypeNames.FONTTYPE_INFO)
        Else
            Call WriteConsoleMsg(SendIndex, "Menor Golpe/Mayor Golpe: " & .Stats.MinHIT & "/" & .Stats.MaxHIT, FontTypeNames.FONTTYPE_INFO)
        End If

        If .Invent.ArmourEqpObjIndex > 0 Then
            If .Invent.EscudoEqpObjIndex > 0 Then
                Call WriteConsoleMsg(SendIndex, "(CUERPO) Mín Def/Máx Def: " & ObjData(.Invent.ArmourEqpObjIndex).MinDef + ObjData(.Invent.EscudoEqpObjIndex).MinDef & "/" & ObjData(.Invent.ArmourEqpObjIndex).MaxDef + ObjData(.Invent.EscudoEqpObjIndex).MaxDef, FontTypeNames.FONTTYPE_INFO)
            Else
                Call WriteConsoleMsg(SendIndex, "(CUERPO) Mín Def/Máx Def: " & ObjData(.Invent.ArmourEqpObjIndex).MinDef & "/" & ObjData(.Invent.ArmourEqpObjIndex).MaxDef, FontTypeNames.FONTTYPE_INFO)
            End If
        Else
            Call WriteConsoleMsg(SendIndex, "(CUERPO) Mín Def/Máx Def: 0", FontTypeNames.FONTTYPE_INFO)
        End If

        If .Invent.CascoEqpObjIndex > 0 Then
            Call WriteConsoleMsg(SendIndex, "(CABEZA) Mín Def/Máx Def: " & ObjData(.Invent.CascoEqpObjIndex).MinDef & "/" & ObjData(.Invent.CascoEqpObjIndex).MaxDef, FontTypeNames.FONTTYPE_INFO)
        Else
            Call WriteConsoleMsg(SendIndex, "(CABEZA) Mín Def/Máx Def: 0", FontTypeNames.FONTTYPE_INFO)
        End If

        GuildI = .GuildIndex
        If GuildI > 0 Then
            Call WriteConsoleMsg(SendIndex, "Clan: " & modGuilds.GuildName(GuildI), FontTypeNames.FONTTYPE_INFO)
            If UCase$(modGuilds.GuildLeader(GuildI)) = UCase$(.Name) Then
                Call WriteConsoleMsg(SendIndex, "Status: Líder", FontTypeNames.FONTTYPE_INFO)
            End If
            'guildpts no tienen objeto
        End If

        #If ConUpTime Then
            Dim TempDate As Date
            Dim TempSecs As Long
            Dim tempStr As String
            TempDate = Now - .LogOnTime
            TempSecs = (.UpTime + (Abs(Day(TempDate) - 30) * 24 * 3600) + (Hour(TempDate) * 3600) + (Minute(TempDate) * 60) + Second(TempDate))
            tempStr = (TempSecs \ 86400) & " Dias, " & ((TempSecs Mod 86400) \ 3600) & " Horas, " & ((TempSecs Mod 86400) Mod 3600) \ 60 & " Minutos, " & (((TempSecs Mod 86400) Mod 3600) Mod 60) & " Segundos."
            Call WriteConsoleMsg(SendIndex, "Logeado hace: " & Hour(TempDate) & ":" & Minute(TempDate) & ":" & Second(TempDate), FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Total: " & tempStr, FontTypeNames.FONTTYPE_INFO)
        #End If

        Call WriteConsoleMsg(SendIndex, "Oro: " & .Stats.GLD & "  Posición: " & .Pos.X & "," & .Pos.Y & " en mapa " & .Pos.Map, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Dados: " & .Stats.UserAtributos(eAtributos.Fuerza) & ", " & .Stats.UserAtributos(eAtributos.Agilidad) & ", " & .Stats.UserAtributos(eAtributos.Inteligencia) & ", " & .Stats.UserAtributos(eAtributos.Carisma) & ", " & .Stats.UserAtributos(eAtributos.Constitucion), FontTypeNames.FONTTYPE_INFO)


        Dim MinHP As Integer, MaxHP As Integer

        Select Case .Clase

        Case eClass.Warrior
            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 9
                MaxHP = 12
            Case 20
                MinHP = 8
                MaxHP = 12
            Case 19
                MinHP = 8
                MaxHP = 11
            Case Else
                MinHP = 7
                MaxHP = 11
            End Select

        Case eClass.Hunter

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 9
                MaxHP = 11
            Case 20
                MinHP = 8
                MaxHP = 11
            Case 19
                MinHP = 6
                MaxHP = 11
            Case Else
                MinHP = 6
                MaxHP = 10
            End Select

        Case eClass.Pirat

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 9
                MaxHP = 11
            Case 20
                MinHP = 8
                MaxHP = 11
            Case 19
                MinHP = 7
                MaxHP = 11
            Case Else
                MinHP = 6
                MaxHP = 11
            End Select

        Case eClass.Paladin

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 9
                MaxHP = 11
            Case 20
                MinHP = 8
                MaxHP = 11
            Case 19
                MinHP = 7
                MaxHP = 11
            Case Else
                MinHP = 6
                MaxHP = 11
            End Select

        Case eClass.Thief

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 6
                MaxHP = 9
            Case 20
                MinHP = 5
                MaxHP = 9
            Case 19
                MinHP = 4
                MaxHP = 9
            Case Else
                MinHP = 4
                MaxHP = 8
            End Select

        Case eClass.Mage

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 6
                MaxHP = 9
            Case 20
                MinHP = 5
                MaxHP = 8
            Case 19
                MinHP = 4
                MaxHP = 8
            Case Else
                MinHP = 3
                MaxHP = 8
            End Select

        Case eClass.Miner, eClass.Carpenter, eClass.Woodcutter, eClass.Fisherman

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 9
                MaxHP = 12
            Case 20
                MinHP = 8
                MaxHP = 12
            Case 19
                MinHP = 7
                MaxHP = 11
            Case Else
                MinHP = 6
                MaxHP = 11
            End Select

        Case eClass.Cleric

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 7
                MaxHP = 10
            Case 20
                MinHP = 6
                MaxHP = 10
            Case 19
                MinHP = 6
                MaxHP = 9
            Case Else
                MinHP = 5
                MaxHP = 9
            End Select

        Case eClass.Druid

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 7
                MaxHP = 10
            Case 20
                MinHP = 6
                MaxHP = 10
            Case 19
                MinHP = 6
                MaxHP = 9
            Case Else
                MinHP = 5
                MaxHP = 9
            End Select

        Case eClass.Assasin

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 7
                MaxHP = 10
            Case 20
                MinHP = 6
                MaxHP = 10
            Case 19
                MinHP = 6
                MaxHP = 9
            Case Else
                MinHP = 5
                MaxHP = 9
            End Select

        Case eClass.Bard

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 7
                MaxHP = 10
            Case 20
                MinHP = 6
                MaxHP = 10
            Case 19
                MinHP = 6
                MaxHP = 9
            Case Else
                MinHP = 5
                MaxHP = 9
            End Select

        Case Else

            Select Case .Stats.UserAtributos(eAtributos.Constitucion)
            Case 21
                MinHP = 6
                MaxHP = 8
            Case 20
                MinHP = 5
                MaxHP = 8
            Case 19
                MinHP = 4
                MaxHP = 8
            Case Else
                MinHP = 3
                MaxHP = 8
            End Select

        End Select

        Dim ups As Single
        ups = .Stats.MaxHP - (((MinHP + MaxHP) / 2) * (.Stats.ELV - 1) + 20)
        If ups > 0 Then
            Call WriteConsoleMsg(SendIndex, "Felicidades!! Estás " & ups & " puntos por encima del promedio!")
        Else
            Call WriteConsoleMsg(SendIndex, "No te desanimes!! Estás " & ups & " puntos por debajo del promedio.")

        End If

    End With
End Sub

Sub SendUserMiniStatsTxt(ByVal SendIndex As Integer, ByVal UserIndex As Integer)
'*************************************************
'Author: Unknown
'Last modified: 23/01/2007
'Shows the users Stats when the user is online.
'23/01/2007 Pablo (ToxicWaste) - Agrego de funciones y mejora de distribución de parámetros.
'*************************************************
    With UserList(UserIndex)
        Call WriteConsoleMsg(SendIndex, "Pj: " & .Name, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Ciudadanos matados: " & .faccion.CiudadanosMatados & " Criminales matados: " & .faccion.CriminalesMatados & " usuarios matados: " & .Stats.UsuariosMatados, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "NPCs muertos: " & .Stats.NPCsMuertos, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Clase: " & ListaClases(.Clase), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Pena: " & .Counters.Pena, FontTypeNames.FONTTYPE_INFO)

        If .faccion.ArmadaReal = 1 Then
            Call WriteConsoleMsg(SendIndex, "Ejército real desde: " & .faccion.FechaIngreso, FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Ingresó en nivel: " & .faccion.NivelIngreso & " con " & .faccion.MatadosIngreso & " ciudadanos matados.", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & .faccion.Reenlistadas, FontTypeNames.FONTTYPE_INFO)

        ElseIf .faccion.FuerzasCaos = 1 Then
            Call WriteConsoleMsg(SendIndex, "Legión oscura desde: " & .faccion.FechaIngreso, FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Ingresó en nivel: " & .faccion.NivelIngreso, FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & .faccion.Reenlistadas, FontTypeNames.FONTTYPE_INFO)

        ElseIf .faccion.RecibioExpInicialReal = 1 Then
            Call WriteConsoleMsg(SendIndex, "Fue ejército real", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & .faccion.Reenlistadas, FontTypeNames.FONTTYPE_INFO)

        ElseIf .faccion.RecibioExpInicialCaos = 1 Then
            Call WriteConsoleMsg(SendIndex, "Fue legión oscura", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & .faccion.Reenlistadas, FontTypeNames.FONTTYPE_INFO)
        End If

        Call WriteConsoleMsg(SendIndex, "Asesino: " & .Reputacion.AsesinoRep, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Noble: " & .Reputacion.NobleRep, FontTypeNames.FONTTYPE_INFO)

        If .GuildIndex > 0 Then
            Call WriteConsoleMsg(SendIndex, "Clan: " & GuildName(.GuildIndex), FontTypeNames.FONTTYPE_INFO)
        End If
    End With
End Sub

Sub SendUserMiniStatsTxtFromChar(ByVal SendIndex As Integer, ByVal charName As String)
'*************************************************
'Author: Unknown
'Last modified: 23/01/2007
'Shows the users Stats when the user is offline.
'23/01/2007 Pablo (ToxicWaste) - Agrego de funciones y mejora de distribución de parámetros.
'*************************************************
    Dim CharFile As String
    Dim Ban As String
    Dim BanDetailPath As String

    BanDetailPath = App.path & "\logs\" & "BanDetail.dat"
    CharFile = CharPath & charName & ".chr"

    If FileExist(CharFile) Then
        Call WriteConsoleMsg(SendIndex, "Pj: " & charName, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Ciudadanos matados: " & GetVar(CharFile, "FACCIONES", "CiudMatados") & " CriminalesMatados: " & GetVar(CharFile, "FACCIONES", "CrimMatados") & " usuarios matados: " & GetVar(CharFile, "MUERTES", "UserMuertes"), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "NPCs muertos: " & GetVar(CharFile, "MUERTES", "NpcsMuertes"), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Clase: " & ListaClases(GetVar(CharFile, "INIT", "Clase")), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Pena: " & GetVar(CharFile, "COUNTERS", "PENA"), FontTypeNames.FONTTYPE_INFO)

        If CByte(GetVar(CharFile, "FACCIONES", "EjercitoReal")) = 1 Then
            Call WriteConsoleMsg(SendIndex, "Ejército real desde: " & GetVar(CharFile, "FACCIONES", "FechaIngreso"), FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Ingresó en nivel: " & CInt(GetVar(CharFile, "FACCIONES", "NivelIngreso")) & " con " & CInt(GetVar(CharFile, "FACCIONES", "MatadosIngreso")) & " ciudadanos matados.", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & CByte(GetVar(CharFile, "FACCIONES", "Reenlistadas")), FontTypeNames.FONTTYPE_INFO)

        ElseIf CByte(GetVar(CharFile, "FACCIONES", "EjercitoCaos")) = 1 Then
            Call WriteConsoleMsg(SendIndex, "Legión oscura desde: " & GetVar(CharFile, "FACCIONES", "FechaIngreso"), FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Ingresó en nivel: " & CInt(GetVar(CharFile, "FACCIONES", "NivelIngreso")), FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & CByte(GetVar(CharFile, "FACCIONES", "Reenlistadas")), FontTypeNames.FONTTYPE_INFO)

        ElseIf CByte(GetVar(CharFile, "FACCIONES", "rExReal")) = 1 Then
            Call WriteConsoleMsg(SendIndex, "Fue ejército real", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & CByte(GetVar(CharFile, "FACCIONES", "Reenlistadas")), FontTypeNames.FONTTYPE_INFO)

        ElseIf CByte(GetVar(CharFile, "FACCIONES", "rExCaos")) = 1 Then
            Call WriteConsoleMsg(SendIndex, "Fue legión oscura", FontTypeNames.FONTTYPE_INFO)
            Call WriteConsoleMsg(SendIndex, "Veces que ingresó: " & CByte(GetVar(CharFile, "FACCIONES", "Reenlistadas")), FontTypeNames.FONTTYPE_INFO)
        End If


        Call WriteConsoleMsg(SendIndex, "Asesino: " & CLng(GetVar(CharFile, "REP", "Asesino")), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Noble: " & CLng(GetVar(CharFile, "REP", "Nobles")), FontTypeNames.FONTTYPE_INFO)

        If IsNumeric(GetVar(CharFile, "Guild", "GUILDINDEX")) Then
            Call WriteConsoleMsg(SendIndex, "Clan: " & modGuilds.GuildName(CInt(GetVar(CharFile, "Guild", "GUILDINDEX"))), FontTypeNames.FONTTYPE_INFO)
        End If

        Ban = GetVar(CharFile, "FLAGS", "Ban")
        Call WriteConsoleMsg(SendIndex, "Ban: " & Ban, FontTypeNames.FONTTYPE_INFO)

        If Ban = "1" Then
            Call WriteConsoleMsg(SendIndex, "Ban por: " & GetVar(CharFile, charName, "BannedBy") & " Motivo: " & GetVar(BanDetailPath, charName, "Reason"), FontTypeNames.FONTTYPE_INFO)
        End If
    Else
        Call WriteConsoleMsg(SendIndex, "El pj no existe: " & charName, FontTypeNames.FONTTYPE_INFO)
    End If
End Sub

Sub SendUserInvTxt(ByVal SendIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next

    Dim j As Long

    With UserList(UserIndex)
        Call WriteConsoleMsg(SendIndex, .Name, FontTypeNames.FONTTYPE_INFO)
        'Call WriteConsoleMsg(SendIndex, "Tiene " & .Invent.NroItems & " objetos.", FontTypeNames.FONTTYPE_INFO)

        For j = 1 To .CurrentInventorySlots
            If .Invent.Object(j).ObjIndex > 0 Then
                Call WriteConsoleMsg(SendIndex, "Objeto " & j & " " & ObjData(.Invent.Object(j).ObjIndex).Name & " Cantidad:" & .Invent.Object(j).Amount, FontTypeNames.FONTTYPE_INFO)
            End If
        Next j
    End With
End Sub

Sub SendUserInvTxtFromChar(ByVal SendIndex As Integer, ByVal charName As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next

    Dim j As Long
    Dim CharFile As String, Tmp As String
    Dim ObjInd As Long, ObjCant As Long

    CharFile = CharPath & charName & ".chr"

    If FileExist(CharFile, vbNormal) Then
        Call WriteConsoleMsg(SendIndex, charName, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Tiene " & GetVar(CharFile, "Inventory", "CantidadItems") & " objetos.", FontTypeNames.FONTTYPE_INFO)

        For j = 1 To MAX_INVENTORY_SLOTS
            Tmp = GetVar(CharFile, "Inventory", "Obj" & j)
            ObjInd = ReadField(1, Tmp, Asc("-"))
            ObjCant = ReadField(2, Tmp, Asc("-"))
            If ObjInd > 0 Then
                Call WriteConsoleMsg(SendIndex, "Objeto " & j & " " & ObjData(ObjInd).Name & " Cantidad:" & ObjCant, FontTypeNames.FONTTYPE_INFO)
            End If
        Next j
    Else
        Call WriteMensajes(SendIndex, Mensaje_50)
    End If
End Sub

Sub SendUserSkillsTxt(ByVal SendIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next
    Dim j As Integer

    Call WriteConsoleMsg(SendIndex, UserList(UserIndex).Name, FontTypeNames.FONTTYPE_INFO)

    For j = 1 To NUMSKILLS
        Call WriteConsoleMsg(SendIndex, SkillsNames(j) & " = " & UserList(UserIndex).Stats.UserSkills(j), FontTypeNames.FONTTYPE_INFO)
    Next j

    Call WriteConsoleMsg(SendIndex, "SkillLibres:" & UserList(UserIndex).Stats.SkillPts, FontTypeNames.FONTTYPE_INFO)
End Sub

Private Function EsMascotaCiudadano(ByVal NpcIndex As Integer, ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If Npclist(NpcIndex).MaestroUser > 0 Then
        EsMascotaCiudadano = Not criminal(Npclist(NpcIndex).MaestroUser)
        If EsMascotaCiudadano Then
            Call WriteConsoleMsg(Npclist(NpcIndex).MaestroUser, "¡¡" & UserList(UserIndex).Name & " esta atacando tu mascota!!", FontTypeNames.FONTTYPE_INFO)
        End If
    End If
End Function

Sub NPCAtacado(ByVal NpcIndex As Integer, ByVal UserIndex As Integer)
'**********************************************
'Author: Unknown
'Last Modification: 02/04/2010
'24/01/2007 -> Pablo (ToxicWaste): Agrego para que se actualize el tag si corresponde.
'24/07/2007 -> Pablo (ToxicWaste): Guardar primero que ataca NPC y el que atacas ahora.
'06/28/2008 -> NicoNZ: Los elementales al atacarlos por su amo no se paran más al lado de él sin hacer nada.
'02/04/2010: ZaMa: Un ciuda no se vuelve mas criminal al atacar un npc no hostil.
'**********************************************
    Dim EraCriminal As Boolean
    Dim MascotaDomada As Boolean

    On Error GoTo Errhandler

    If Npclist(NpcIndex).MaestroUser > 0 Then
        Call AllMascotasAtacanUser(UserIndex, Npclist(NpcIndex).MaestroUser)
    End If

    'Guardamos el usuario que ataco el npc.

    If Npclist(NpcIndex).Contadores.TiempoExistencia <> 0 Then

        Dim LastNpcHit As Integer
2       LastNpcHit = UserList(UserIndex).flags.NPCAtacado
3       UserList(UserIndex).flags.NPCAtacado = NpcIndex

4       If Npclist(NpcIndex).flags.AttackedFirstBy = vbNullString Then
5           If LastNpcHit <> 0 Then
6               If Npclist(LastNpcHit).flags.AttackedFirstBy = UserList(UserIndex).Name Then
7                   Npclist(LastNpcHit).flags.AttackedFirstBy = vbNullString
8               End If
            End If
9           Npclist(NpcIndex).flags.AttackedFirstBy = UserList(UserIndex).Name
10      ElseIf Npclist(NpcIndex).flags.AttackedFirstBy <> UserList(UserIndex).Name Then
11          If LastNpcHit <> 0 Then
12              If Npclist(LastNpcHit).flags.AttackedFirstBy = UserList(UserIndex).Name Then
13                  Npclist(LastNpcHit).flags.AttackedFirstBy = vbNullString
                End If
            End If
        End If
    End If

14  If Npclist(NpcIndex).MaestroUser > 0 Then
15      If Npclist(NpcIndex).MaestroUser <> UserIndex And Npclist(NpcIndex).Contadores.TiempoExistencia > 0 Then
16          Call AllMascotasAtacanUser(UserIndex, Npclist(NpcIndex).MaestroUser)
        Else
            If LastNpcHit Then
17              Npclist(LastNpcHit).flags.AttackedFirstBy = vbNullString
            End If
18          MascotaDomada = True
        End If
    End If

19  If EsMascotaCiudadano(NpcIndex, UserIndex) Then
20      Call VolverCriminal(UserIndex)
21      If MascotaDomada = False Then
22          Npclist(NpcIndex).Movement = TipoAI.NPCDEFENSA
            Npclist(NpcIndex).Hostile = 1
        End If
    Else
23      EraCriminal = criminal(UserIndex)


31      If Npclist(NpcIndex).MaestroUser <> UserIndex Then
            'hacemos que el npc se defienda
32          Npclist(NpcIndex).Movement = TipoAI.NPCDEFENSA
            Npclist(NpcIndex).Hostile = 1

        End If

        'Reputacion
24      If Npclist(NpcIndex).Stats.Alineacion = 0 Then
25          If Npclist(NpcIndex).NPCtype = eNPCType.GuardiaReal Then
26              Call VolverCriminal(UserIndex)
27          End If

28      ElseIf Npclist(NpcIndex).Stats.Alineacion = 1 Then
29          UserList(UserIndex).Reputacion.PlebeRep = UserList(UserIndex).Reputacion.PlebeRep + vlCAZADOR / 2
30          If UserList(UserIndex).Reputacion.PlebeRep > MAXREP Then _
               UserList(UserIndex).Reputacion.PlebeRep = MAXREP
        End If

33      If EraCriminal And Not criminal(UserIndex) Then
34          Call VolverCiudadano(UserIndex)
        End If
    End If
    Exit Sub

Errhandler:
    Call LogError("Error en NPCAtacado en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub
Public Function PuedeApuñalar(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If UserList(UserIndex).Invent.WeaponEqpObjIndex > 0 Then
        If ObjData(UserList(UserIndex).Invent.WeaponEqpObjIndex).Apuñala = 1 Then
            PuedeApuñalar = UserList(UserIndex).Stats.UserSkills(eSkill.Apuñalar) >= MIN_APUÑALAR _
                            Or UserList(UserIndex).Clase = eClass.Assasin
        End If
    End If
End Function

Public Function PuedeAcuchillar(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: ZaMa
'Last Modification: 25/01/2010 (ZaMa)
'
'***************************************************

    With UserList(UserIndex)
        If .Clase = eClass.Pirat Then
            If .Invent.WeaponEqpObjIndex > 0 Then
                PuedeAcuchillar = (ObjData(.Invent.WeaponEqpObjIndex).Acuchilla = 1)
            End If
        End If
    End With

End Function

Sub SubirSkill(ByVal UserIndex As Integer, ByVal Skill As Integer, Optional ByVal Acerto As Boolean = True)

    If UserList(UserIndex).Stats.AsignoSkills < 10 Then
        Call WriteConsoleMsg(UserIndex, "Debes asignar los 10 primeros skills para poder subir de skills naturalmente!!")
        Exit Sub
    End If

    ' @@ TDS Extraction
    If UserList(UserIndex).Stats.UserSkills(Skill) = MAXSKILLPOINTS Then Exit Sub
    If UserList(UserIndex).Stats.UserSkills(Skill) >= LevelSkill(UserList(UserIndex).Stats.ELV).LevelValue Then Exit Sub
    If Skill = 50 Then Skill = eSkill.proyectiles    ' @@ y este fix ???

    'Restricciones
    If Skill = eSkill.Apuñalar And UserList(UserIndex).Stats.UserSkills(eSkill.Apuñalar) < 10 And Not (UserList(UserIndex).Clase = eClass.Assasin) Then
        Exit Sub
    End If

    If UserList(UserIndex).flags.Hambre = 1 Or UserList(UserIndex).flags.Sed = 1 Or UserList(UserIndex).Stats.ELV > UBound(LevelSkill) Then
        Exit Sub
    End If

    Dim Aumenta As Integer
    Dim prob As Integer
    Dim lvl As Integer

    If Skill = eSkill.Ocultarse And Skill = eSkill.Apuñalar Then
        If UserList(UserIndex).Stats.ELV <= 3 Then
            prob = 7  '15%
        ElseIf UserList(UserIndex).Stats.ELV <= 6 Then
            prob = 10    '10%
        ElseIf UserList(UserIndex).Stats.ELV <= 10 Then
            prob = 20    '5%
        ElseIf UserList(UserIndex).Stats.ELV <= 20 Then
            prob = 25    '4%
        Else
            prob = 29    '3.5%
        End If
    Else
        If UserList(UserIndex).Stats.ELV <= 3 Then
            prob = 7
        ElseIf UserList(UserIndex).Stats.ELV > 3 And UserList(UserIndex).Stats.ELV < 6 Then
            prob = 10
        ElseIf UserList(UserIndex).Stats.ELV >= 6 And UserList(UserIndex).Stats.ELV < 10 Then
            prob = 20
        ElseIf UserList(UserIndex).Stats.ELV >= 10 And UserList(UserIndex).Stats.ELV < 20 Then
            prob = 25
        Else
            prob = 28
        End If
    End If

    Dim SubeSkill As Boolean
    If Acerto Then
112     If RandomNumber(1, 100) <= 50 Then SubeSkill = True
    Else

114     If RandomNumber(1, 100) <= 20 Then SubeSkill = True
    End If

    Aumenta = Int(RandomNumber(1, prob))
    lvl = UserList(UserIndex).Stats.ELV

    If SubeSkill Then    'Aumenta = 2 And UserList(userindex).Stats.UserSkills(Skill) < LevelSkill(lvl).LevelValue Then
        Call AddtoVar(UserList(UserIndex).Stats.UserSkills(Skill), 1, MAXSKILLPOINTS)
        Call AddtoVar(UserList(UserIndex).Stats.Exp, 50, MAXEXP)

        Call WriteUpdateExp(UserIndex)
        Call CheckUserLevel(UserIndex)

        Call WriteConsoleMsg(UserIndex, "¡Has mejorado tu skill " & SkillsNames(Skill) & " en un punto!. Ahora tienes " & UserList(UserIndex).Stats.UserSkills(Skill) & " pts.", FontTypeNames.FONTTYPE_INFO)
        WriteMensajes UserIndex, e_Mensajes.Mensaje_48

        'Si esta trabajando le actualizo las probabilidades
        If UserList(UserIndex).Trabajo.tipo > 0 Then
            ' Call Trabajo.CalcularModificador(UserList(userindex))
            'Si esta comerciando le actualizo el inventario con los nuevos precios
        ElseIf UserList(UserIndex).flags.Comerciando = True Then
            Call UpdateUserInv(True, UserIndex, 0)
        End If

    End If



End Sub

''
' Muere un usuario
'
' @param UserIndex  Indice del usuario que muere
'

Sub UserDie(ByVal UserIndex As Integer, Optional ByVal Drop As Boolean = True)
'************************************************
'Author: Uknown
'Last Modified: 12/01/2010 (ZaMa)
'04/15/2008: NicoNZ - Ahora se resetea el counter del invi
'13/02/2009: ZaMa - Ahora se borran las mascotas cuando moris en agua.
'27/05/2009: ZaMa - El seguro de resu no se activa si estas en una arena.
'21/07/2009: Marco - Al morir se desactiva el comercio seguro.
'16/11/2009: ZaMa - Al morir perdes la criatura que te pertenecia.
'27/11/2009: Budi - Al morir envia los atributos originales.
'12/01/2010: ZaMa - Los druidas pierden la inmunidad de ser atacados cuando mueren.
'************************************************
    On Error GoTo ErrorHandler
    Dim i As Long
    Dim aN As Integer

    With UserList(UserIndex)
        'Sonido

        If .sReto.Reto_Index = 0 And .mReto.Reto_Index = 0 Then
            If .Genero = eGenero.Hombre Then
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.MUERTE_HOMBRE)
            Else
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.MUERTE_MUJER)
            End If
        End If

        'Quitar el dialogo del user muerto
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageRemoveCharDialog(.Char.CharIndex))

        If Not .GuildIndex = 0 Or Not .GuildIndex > CANTIDADDECLANES Then
            '      Call SendData(SendTarget.ToDiosesYclan, .GuildIndex, PrepareMessageConsoleMsg("Clan> " & .Name & " ha muerto en el mapa " & .Pos.map & " X: " & .Pos.X & " Y: " & .Pos.Y, FontTypeNames.FONTTYPE_VENENO))
        End If

        .Stats.MinHP = 0
        .Stats.minSta = 0
        .flags.AtacadoPorUser = 0
        .flags.Envenenado = 0
        Call WriteUpdateEnvenenado(UserIndex)
        .flags.Muerto = 1
        ' No se activa en arenas
        '  If TriggerZonaPelea(UserIndex, UserIndex) <> TRIGGER6_PERMITE Then
        '      .flags.SeguroResu = True
        '      Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOn)        'Call WriteResuscitationSafeOn(UserIndex)
        '  Else
        '      .flags.SeguroResu = False
        '      Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOff)        'Call WriteResuscitationSafeOff(UserIndex)
        '  End If

        aN = .flags.AtacadoPorNpc
        If aN > 0 Then
            Npclist(aN).Movement = Npclist(aN).flags.OldMovement
            Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
            Npclist(aN).flags.AttackedBy = vbNullString
        End If

        aN = .flags.NPCAtacado
        If aN > 0 Then
            If Npclist(aN).flags.AttackedFirstBy = .Name Then
                Npclist(aN).flags.AttackedFirstBy = vbNullString
            End If
        End If
        .flags.AtacadoPorNpc = 0
        .flags.NPCAtacado = 0
        Call PerdioNpc(UserIndex)


        '<<<< Paralisis >>>>
        If .flags.Paralizado = 1 Or .flags.Inmovilizado = 1 Then
            .flags.Paralizado = 0
            .flags.Inmovilizado = 0
            Call WriteParalizeOK(UserIndex)
        End If

        '<<< Estupidez >>>
        If .flags.Estupidez = 1 Then
            .flags.Estupidez = 0
            Call WriteDumbNoMore(UserIndex)
        End If

        '<<<< Descansando >>>>
        If .flags.Descansar Then
            .flags.Descansar = False
            Call WriteRestOK(UserIndex)
        End If

        '<<<< Meditando >>>>
        If .flags.Meditando Then
            .flags.Meditando = False
            Call WriteMeditateToggle(UserIndex)
        End If

        '<<<< Invisible >>>>
        If .flags.invisible = 1 Or .flags.oculto = 1 Then
            .flags.oculto = 0
            .flags.invisible = 0
            .Counters.TiempoOculto = 0
            .Counters.Invisibilidad = 0

            'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, False))
            Call SetInvisible(UserIndex, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.invisible = 1, UserList(UserIndex).flags.oculto = 1)
        End If

        If Drop Then
            If TriggerZonaPelea(UserIndex, UserIndex) <> eTrigger6.TRIGGER6_PERMITE Then
                ' << Si es newbie no pierde el inventario >>
                'If Not EsGM(UserIndex) Then
                If Not EsNewbie(UserIndex) And UserList(UserIndex).flags.EnEvento = 0 Then
                    Call TirarTodo(UserIndex)
                Else
                    If UserList(UserIndex).flags.EnEvento = 0 Then Call TirarTodosLosItemsNoNewbies(UserIndex)
                End If
                'End If
            End If
        End If

        If .XvsX.Slot_ID > 0 Then
            Call SaveCharXvsX(UserIndex)
        End If

        ' DESEQUIPA TODOS LOS OBJETOS
        'desequipar armadura
        If .Invent.ArmourEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, False)
        End If

        'desequipar arma
        If .Invent.WeaponEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.WeaponEqpSlot, False)
        End If

        'desequipar casco
        If .Invent.CascoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.CascoEqpSlot, False)
        End If

        'desequipar herramienta
        If .Invent.AnilloEqpSlot > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot, False)
        End If

        'desequipar herramienta
        If .Invent.AnilloEqpSlot2 > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot2, False)
        End If
        'desequipar municiones
        If .Invent.MunicionEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.MunicionEqpSlot, False)
        End If

        'desequipar escudo
        If .Invent.EscudoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, False)
        End If

        ' << Reseteamos los posibles FX sobre el personaje >>
        If .Char.loops = INFINITE_LOOPS Then
            .Char.FX = 0
            .Char.loops = 0
        End If

        ' << Restauramos el mimetismo
        If .flags.Mimetizado = 1 Then
            .Char.body = .CharMimetizado.body
            .Char.Head = .CharMimetizado.Head
            .Char.CascoAnim = .CharMimetizado.CascoAnim
            .Char.ShieldAnim = .CharMimetizado.ShieldAnim
            .Char.WeaponAnim = .CharMimetizado.WeaponAnim
            .Counters.Mimetismo = 0
            .flags.Mimetizado = 0
            .flags.Mimetizado_Nick = "-"
            .flags.Mimetizado_Color = 0

            ' Puede ser atacado por npcs (cuando resucite)
            .flags.Ignorado = False
        End If

        ' << Restauramos los atributos >>
        If .flags.TomoPocion Then
            For i = 1 To 5
                .Stats.UserAtributos(i) = .Stats.UserAtributosBackUP(i)
            Next i
        End If

        '<< Cambiamos la apariencia del char >>

        If .flags.Navegando = 0 Then
            If (.faccion.FuerzasCaos > 0) Or (.faccion.Status = FaccionType.ChaosCouncil) Then
                .Char.body = 145
                .Char.Head = 501
            Else
                .Char.body = 8
                .Char.Head = 500
            End If
            .Char.ShieldAnim = NingunEscudo
            .Char.WeaponAnim = NingunArma
            .Char.CascoAnim = NingunCasco
        Else
            .Char.body = 87
        End If

        For i = 1 To MAXMASCOTAS
            If .MascotasIndex(i) > 0 Then
                Call MuereNpc(.MascotasIndex(i), 0)
            End If
        Next i

        .nroMascotas = 0

3       If (.mReto.Reto_Index <> 0) Then
            Call m_Retos1vs1.UserDie_Reto(UserIndex)
        End If

4       If (.sReto.Reto_Index <> 0) Then
5           If (m_Retos2vs2.Reto_List(.sReto.Reto_Index).Run) Then
6               Call m_Retos2vs2.User_Die_Reto(UserIndex)
7           End If
8       End If

        If .flags.EnEvento = 1 Then
            '1vs1
            Call m_Torneo1vs1.Rondas_UsuarioMuere(UserIndex)
        ElseIf .flags.EnEvento = 2 Then
            '2vs2
            Call Muere2vs2(UserIndex)
        ElseIf .flags.EnEvento = 3 Then
            'DEATH
            Call m_TorneoDeath.MuereUser(UserIndex)
        ElseIf .flags.EnEvento = 4 Then
            'JDH
            Call m_TorneoJDH.EventDie(.Slot_ID)
        ElseIf .flags.EnEvento = 5 And .XvsX.Slot_ID > 0 Then
            Call MuereUserInxVsX(UserIndex)
        ElseIf .InCVCID Then
            Call cvcManager.HandleDeath(UserIndex)
        End If

        '<< Actualizamos clientes >>
        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
        Call WriteUpdateUserStats(UserIndex)
        Call WriteUpdateStrenghtAndDexterity(UserIndex)

        '<<Cerramos comercio seguro>>
        Call LimpiarComercioSeguro(UserIndex)

        ' @@ RE NAZI
        For i = 1 To MAXUSERQUESTS
            If .QuestStats.Quests(i).QuestIndex > 0 Then
                If QuestList(.QuestStats.Quests(i).QuestIndex).RequiredKills > 0 Then
                    .QuestStats.Quests(i).UsersKilled = 0
                End If
            End If
        Next i

        ' @@ ToDo: ver que mapa es magma y cual vespar etc etc
        Exit Sub
        'Si estaba en dungeon magma, lo saco a la isla
        If .Pos.Map = 175 Or .Pos.Map = 188 Then
            Call WarpUserCharX(UserIndex, 138, 49, 49, True)
        End If

        'Si estaba en dungeon vespar, lo saco a la isla
        If .Pos.Map = 77 Then
            Call WarpUserCharX(UserIndex, 183, 55, 44, True)
        End If

    End With
    Exit Sub

ErrorHandler:
    Call LogError("Error en SUB USERDIE. Error: " & Err.Number & " Descripción: " & Err.Description)
End Sub

Sub UserDieExecution(ByVal UserIndex As Integer)

    On Error GoTo ErrorHandler
    Dim i As Long
    Dim aN As Integer

    With UserList(UserIndex)
        'Sonido

        If .sReto.Reto_Index = 0 And .mReto.Reto_Index = 0 Then
            If .Genero = eGenero.Hombre Then
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.MUERTE_HOMBRE)
            Else
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.MUERTE_MUJER)
            End If
        End If

        'Quitar el dialogo del user muerto
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageRemoveCharDialog(.Char.CharIndex))

        .Stats.MinHP = 0
        .Stats.minSta = 0
        .flags.AtacadoPorUser = 0
        .flags.Envenenado = 0
        Call WriteUpdateEnvenenado(UserIndex)
        .flags.Muerto = 1

        aN = .flags.AtacadoPorNpc
        If aN > 0 Then
            Npclist(aN).Movement = Npclist(aN).flags.OldMovement
            Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
            Npclist(aN).flags.AttackedBy = vbNullString
        End If

        aN = .flags.NPCAtacado
        If aN > 0 Then
            If Npclist(aN).flags.AttackedFirstBy = .Name Then
                Npclist(aN).flags.AttackedFirstBy = vbNullString
            End If
        End If
        .flags.AtacadoPorNpc = 0
        .flags.NPCAtacado = 0
        Call PerdioNpc(UserIndex)


        '<<<< Paralisis >>>>
        If .flags.Paralizado = 1 Or .flags.Inmovilizado = 1 Then
            .flags.Paralizado = 0
            .flags.Inmovilizado = 0
            Call WriteParalizeOK(UserIndex)
        End If

        '<<< Estupidez >>>
        If .flags.Estupidez = 1 Then
            .flags.Estupidez = 0
            Call WriteDumbNoMore(UserIndex)
        End If

        '<<<< Descansando >>>>
        If .flags.Descansar Then
            .flags.Descansar = False
            Call WriteRestOK(UserIndex)
        End If

        '<<<< Meditando >>>>
        If .flags.Meditando Then
            .flags.Meditando = False
            Call WriteMeditateToggle(UserIndex)
        End If

        '<<<< Invisible >>>>
        If .flags.invisible = 1 Or .flags.oculto = 1 Then
            .flags.oculto = 0
            .flags.invisible = 0
            .Counters.TiempoOculto = 0
            .Counters.Invisibilidad = 0

            'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, False))
            Call SetInvisible(UserIndex, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.invisible = 1, UserList(UserIndex).flags.oculto = 1)
        End If

        If .Invent.ArmourEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, False)
        End If

        'desequipar arma
        If .Invent.WeaponEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.WeaponEqpSlot, False)
        End If

        'desequipar casco
        If .Invent.CascoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.CascoEqpSlot, False)
        End If

        'desequipar herramienta
        If .Invent.AnilloEqpSlot > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot, False)
        End If

        'desequipar herramienta
        If .Invent.AnilloEqpSlot2 > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot2, False)
        End If
        'desequipar municiones
        If .Invent.MunicionEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.MunicionEqpSlot, False)
        End If

        'desequipar escudo
        If .Invent.EscudoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, False)
        End If

        ' << Reseteamos los posibles FX sobre el personaje >>
        If .Char.loops = INFINITE_LOOPS Then
            .Char.FX = 0
            .Char.loops = 0
        End If

        ' << Restauramos el mimetismo
        If .flags.Mimetizado = 1 Then
            .Char.body = .CharMimetizado.body
            .Char.Head = .CharMimetizado.Head
            .Char.CascoAnim = .CharMimetizado.CascoAnim
            .Char.ShieldAnim = .CharMimetizado.ShieldAnim
            .Char.WeaponAnim = .CharMimetizado.WeaponAnim
            .Counters.Mimetismo = 0
            .flags.Mimetizado = 0
            .flags.Mimetizado_Nick = "-"
            .flags.Mimetizado_Color = 0

            ' Puede ser atacado por npcs (cuando resucite)
            .flags.Ignorado = False
        End If

        ' << Restauramos los atributos >>
        If .flags.TomoPocion Then
            For i = 1 To 5
                .Stats.UserAtributos(i) = .Stats.UserAtributosBackUP(i)
            Next i
        End If

        '<< Cambiamos la apariencia del char >>

        If .flags.Navegando = 0 Then
            If (.faccion.FuerzasCaos > 0) Or (.faccion.Status = FaccionType.ChaosCouncil) Then
                .Char.body = 145
                .Char.Head = 501
            Else
                .Char.body = 8
                .Char.Head = 500
            End If
            .Char.ShieldAnim = NingunEscudo
            .Char.WeaponAnim = NingunArma
            .Char.CascoAnim = NingunCasco
        Else
            .Char.body = 87
        End If

        For i = 1 To MAXMASCOTAS
            If .MascotasIndex(i) > 0 Then
                Call MuereNpc(.MascotasIndex(i), 0)
            End If
        Next i

        .nroMascotas = 0

3       If (.mReto.Reto_Index <> 0) Then
            Call m_Retos1vs1.UserDie_Reto(UserIndex)
        End If

4       If (.sReto.Reto_Index <> 0) Then
5           If (m_Retos2vs2.Reto_List(.sReto.Reto_Index).Run) Then
6               Call m_Retos2vs2.User_Die_Reto(UserIndex)
7           End If
8       End If

        If .flags.EnEvento = 1 Then
            '1vs1
            Call m_Torneo1vs1.Rondas_UsuarioMuere(UserIndex)
        ElseIf .flags.EnEvento = 2 Then
            '2vs2
            Call Muere2vs2(UserIndex)
        ElseIf .flags.EnEvento = 3 Then
            'DEATH
            Call m_TorneoDeath.MuereUser(UserIndex)
        ElseIf .flags.EnEvento = 4 Then
            'JDH
            Call m_TorneoJDH.EventDie(.Slot_ID)
        ElseIf .flags.EnEvento = 5 And .XvsX.Slot_ID > 0 Then
            Call MuereUserInxVsX(UserIndex)
        End If

        '<< Actualizamos clientes >>
        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
        Call WriteUpdateUserStats(UserIndex)
        Call WriteUpdateStrenghtAndDexterity(UserIndex)

        '<<Cerramos comercio seguro>>
        Call LimpiarComercioSeguro(UserIndex)

    End With
    Exit Sub

ErrorHandler:
    Call LogError("Error en SUB USERDIE. Error: " & Err.Number & " Descripción: " & Err.Description)
End Sub

Public Sub ContarMuerte(ByVal Muerto As Integer, ByVal Atacante As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If EsNewbie(Muerto) Then Exit Sub
    If TriggerZonaPelea(Muerto, Atacante) = TRIGGER6_PERMITE Then Exit Sub

    With UserList(Atacante)

        If .IP <> UserList(Muerto).IP Then
            If .IP_LastKill = UserList(Muerto).IP Then
                ' Exit Sub
            End If

            If CheckAntiFrags(Atacante, UserList(Muerto).flags.serialHD) < 1 Then
                Exit Sub
            End If

            UserList(Atacante).IP_LastKill = UserList(Muerto).IP

            If criminal(Muerto) Then
                ' If .flags.LastCrimMatado <> UserList(Muerto).Name Then
                .flags.LastCrimMatado = UserList(Muerto).Name
                If .faccion.CriminalesMatados < MAXUSERMATADOS Then
                    .faccion.CriminalesMatados = .faccion.CriminalesMatados + 1
                End If
                ' End If

                If .faccion.RecibioExpInicialCaos = 1 And UserList(Muerto).faccion.FuerzasCaos = 1 Then
                    .faccion.Reenlistadas = 200        'jaja que trucho

                    'con esto evitamos que se vuelva a reenlistar
                End If
            Else
                '  If .flags.LastCiudMatado <> UserList(Muerto).Name Then
                .flags.LastCiudMatado = UserList(Muerto).Name
                If .faccion.CiudadanosMatados < MAXUSERMATADOS Then
                    .faccion.CiudadanosMatados = .faccion.CiudadanosMatados + 1
                End If
                ' End If
            End If

            If .Stats.UsuariosMatados < MAXUSERMATADOS Then
                .Stats.UsuariosMatados = .Stats.UsuariosMatados + 1
            End If
        End If
    End With

End Sub

Sub Tilelibre(ByRef Pos As WorldPos, ByRef nPos As WorldPos, ByRef Obj As Obj, ByRef Agua As Boolean, ByRef Tierra As Boolean)
'**************************************************************
'Author: Unknown
'Last Modify Date: 23/01/2007
'23/01/2007 -> Pablo (ToxicWaste): El agua es ahora un TileLibre agregando las condiciones necesarias.
'**************************************************************
    Dim LoopC As Integer
    Dim tX As Long
    Dim tY As Long
    Dim hayobj As Boolean

    hayobj = False
    nPos.Map = Pos.Map
    nPos.X = 0
    nPos.Y = 0

    Do While Not LegalPos(Pos.Map, nPos.X, nPos.Y, Agua, Tierra) Or hayobj

        If LoopC > 17 Then
            Exit Do
        End If

        For tY = Pos.Y - LoopC To Pos.Y + LoopC
            For tX = Pos.X - LoopC To Pos.X + LoopC

                If LegalPos(nPos.Map, tX, tY, Agua, Tierra) Then
                    'We continue if: a - the item is different from 0 and the dropped item or b - the amount dropped + amount in map exceeds MAX_INVENTORY_OBJS
                    hayobj = (MapData(nPos.Map, tX, tY).ObjInfo.ObjIndex > 0 And MapData(nPos.Map, tX, tY).ObjInfo.ObjIndex <> Obj.ObjIndex)
                    If Not hayobj Then _
                       hayobj = (MapData(nPos.Map, tX, tY).ObjInfo.Amount + Obj.Amount > MAX_INVENTORY_OBJS)
                    If Not hayobj And MapData(nPos.Map, tX, tY).TileExit.Map = 0 Then
                        nPos.X = tX
                        nPos.Y = tY

                        'break both fors
                        tX = Pos.X + LoopC
                        tY = Pos.Y + LoopC
                    End If
                End If

            Next tX
        Next tY

        LoopC = LoopC + 1
    Loop
End Sub

Public Sub WarpUserCharX(ByVal UI As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, Optional ByVal FX As Boolean = False)

    If Not InMapBounds(Map, X, Y) Then Exit Sub

    If MapData(Map, X, Y).UserIndex = UI Then
        Exit Sub
    End If

    Dim NuevaPos As WorldPos
    Dim FuturePos As WorldPos

    FuturePos.Map = Map
    FuturePos.X = X
    FuturePos.Y = Y

    Call ClosestLegalPos(FuturePos, NuevaPos, True)

    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
        Call WarpUserChar(UI, NuevaPos.Map, NuevaPos.X, NuevaPos.Y, FX)
    End If

End Sub


Sub WarpUserChar(ByVal UserIndex As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal FX As Boolean, Optional ByVal Teletransported As Boolean, Optional ByVal StablePos As Boolean = True)
'**************************************************************
'Author: Unknown
'Last Modify Date: 13/11/2009
'15/07/2009 - ZaMa: Automatic toogle navigate after warping to water.
'13/11/2009 - ZaMa: Now it's activated the timer which determines if the npc can atacak the user.
'**************************************************************
    Dim OldMap As Integer
    Dim OldX As Integer
    Dim OldY As Integer

1   On Error GoTo WarpUserChar_Error

    With UserList(UserIndex)

        'Quitar el dialogo
3       If Not EsGM(UserIndex) Then
4           Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageRemoveCharDialog(.Char.CharIndex))
5       End If

        OldMap = .Pos.Map
        OldX = .Pos.X
        OldY = .Pos.Y
        .flags.UltimoMensaje = 0

655     Call EraseUserChar(UserIndex, .flags.AdminInvisible = 1)

484     If OldMap <> Map Then
282         Call WriteChangeMap(UserIndex, Map)        ', MapInfo(.Pos.map).MapVersion, MapInfo(map).Name)

2829        Call WritePlayMidi(UserIndex, val(ReadField(1, MapInfo(Map).music, 45)))

            'Update new Map Users
123         MapInfo(Map).NumUsers = MapInfo(Map).NumUsers + 1

            'Update old Map Users
124         MapInfo(OldMap).NumUsers = MapInfo(OldMap).NumUsers - 1
125         If MapInfo(OldMap).NumUsers < 0 Then
                MapInfo(OldMap).NumUsers = 0
            End If

            'Si el mapa al que entro NO ES superficial AND en el que estaba TAMPOCO ES superficial, ENTONCES
            Dim nextMap, previousMap As Boolean
126         nextMap = IIf(distanceToCities(Map).distanceToCity(.Hogar) >= 0, True, False)
127         previousMap = IIf(distanceToCities(.Pos.Map).distanceToCity(.Hogar) >= 0, True, False)

            If previousMap And nextMap Then        '138 => 139 (Ambos superficiales, no tiene que pasar nada)
                'NO PASA NADA PORQUE NO ENTRO A UN DUNGEON.
            ElseIf previousMap And Not nextMap Then        '139 => 140 (139 es superficial, 140 no. Por lo tanto 139 es el ultimo mapa superficial)
                .flags.lastMap = .Pos.Map
            ElseIf Not previousMap And nextMap Then        '140 => 139 (140 es no es superficial, 139 si. Por lo tanto, el último mapa es 0 ya que no esta en un dungeon)
                .flags.lastMap = 0
            ElseIf Not previousMap And Not nextMap Then        '140 => 141 (Ninguno es superficial, el ultimo mapa es el mismo de antes)
                .flags.lastMap = .flags.lastMap
            End If

128         Call WriteRemoveAllDialogs(UserIndex)

1209        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageRainToggle(Lloviendo And Not MapInfo(Map).Zona = "DUNGEON" And Not MapInfo(Map).Zona = "EVENTOS" And Not MapInfo(Map).Zona = "RETOS" And Not MapInfo(Map).Terreno = "RETOS" And Not MapInfo(Map).Terreno = "DUNGEON"))


        End If

999     .Pos.X = X
9898    .Pos.Y = Y
979     .Pos.Map = Map

        'If Not HayAgua(.Pos.map, .Pos.X, .Pos.Y) Then
        '    If .flags.Navegando = 1 Then
        '        .flags.Navegando = 0
        '        Call WriteNavigateToggle(UserIndex)
        '    End If
        'End If

796     Call MakeUserChar(True, Map, UserIndex, Map, X, Y)
696     Call WriteUserCharIndexInServer(UserIndex)
595     Call DoTileEvents(UserIndex, Map, X, Y)
        'Force a flush, so user index is in there before it's destroyed for teleporting
        'Call Flushbuffer(UserIndex)

        'Seguis invisible al pasar de mapa
494     If (.flags.invisible = 1 Or .flags.oculto = 1) And (Not .flags.AdminInvisible = 1) Then
939         Call SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
            'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, True))
        End If

        If FX And .flags.AdminInvisible = 0 Then        'FX
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_WARP, X, Y))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, FXIDs.FXWARP, 0))
        End If

        If .flags.Meditando Then
            Call WriteMeditateToggle(UserIndex)
            WriteMensajes UserIndex, e_Mensajes.Mensaje_216
            .flags.Meditando = False
            .Char.FX = 0
            .Char.loops = 0
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))
        End If

94      If .nroMascotas Then Call WarpMascotas(UserIndex)

        ' No puede ser atacado cuando cambia de mapa, por cierto tiempo
989     Call IntervaloPermiteSerAtacado(UserIndex, True)

        ' Perdes el npc al cambiar de mapa
9696    Call PerdioNpc(UserIndex)

        Dim Obj As ObjData


        ' Automatic toogle navigate
97      If .flags.Privilegios = PlayerType.User Then
98          If HayAgua(.Pos.Map, .Pos.X, .Pos.Y) Or (HayAguaAlrededor(.Pos.Map, .Pos.X, .Pos.Y) And HayAgua(.Pos.Map, .Pos.X, .Pos.Y)) Then
99              If .flags.Navegando = 0 Then

                    If .Invent.BarcoObjIndex And .Invent.BarcoSlot Then
                        Obj = ObjData(.Invent.Object(.Invent.BarcoSlot).ObjIndex)
                        Call DoNavega(UserIndex, Obj, .Invent.BarcoSlot)
                        '.flags.Navegando = 1
101                     'Call WriteNavigateToggle(UserIndex)
                    End If
102             End If
103         Else
104             If .flags.Navegando = 1 And HayAgua(.Pos.Map, .Pos.X, .Pos.Y) Then
105                 .flags.Navegando = 0
106                 Call WriteNavigateToggle(UserIndex)
                    If .flags.Muerto = 0 Then
                        .Char.Head = .OrigChar.Head
                        If .Clase = eClass.Pirat Then
                            If .flags.oculto = 1 Then    ' Al desequipar barca, perdió el ocultar
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
                    Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
107             End If
108         End If
109     End If

    End With
111 Exit Sub

WarpUserChar_Error:

112 Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure WarpUserChar of Módulo modUsuarios " & Erl & ".")

End Sub

Public Sub WarpMascotas(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    Dim i As Long
    Dim InvocadosMatados As Integer
    Dim CanWarp As Boolean
    Dim Index As Integer

1   CanWarp = (MapInfo(UserList(UserIndex).Pos.Map).pk = True)

    Dim CountMascotas As Byte
    Dim SpawnPosMascot As WorldPos
    Dim nDonde As WorldPos

    '2   If UserList(UserIndex).NroMascotas = 1 Then
    '3       CountMascotas = 2
    '    End If

4   For i = 1 To MAXMASCOTAS
5       Index = UserList(UserIndex).MascotasIndex(i)

6       If Index > 0 Then
            ' si la mascota tiene tiempo de vida > 0 significa q fue invocada => we kill it
7           If Npclist(Index).Contadores.TiempoExistencia > 0 Then
8               Call QuitarNPC(Index)
9               InvocadosMatados = InvocadosMatados + 1
            Else
10              If UserList(UserIndex).MascotasType(i) > 0 And CanWarp Then
11                  CountMascotas = CountMascotas + 1

12                  If CountMascotas > MAXMASCOTAS Then
13                      CountMascotas = MAXMASCOTAS
                    End If

14                  Npclist(Index).Char.Heading = UserList(UserIndex).Char.Heading

15                  SpawnPosMascot.Map = UserList(UserIndex).Pos.Map
16                  SpawnPosMascot.X = UserList(UserIndex).Pos.X + ArrayMascotas(CountMascotas, Npclist(Index).Char.Heading).X
17                  SpawnPosMascot.Y = UserList(UserIndex).Pos.Y + ArrayMascotas(CountMascotas, Npclist(Index).Char.Heading).Y

18                  Call ClosestLegalPos(SpawnPosMascot, nDonde, False, , True)

19                  If nDonde.Map > 0 And nDonde.X > 0 And nDonde.Y > 0 Then
20                      Call EraseNPCChar(Index)
212                     Call MakeNPCChar(True, nDonde.Map, Index, nDonde.Map, nDonde.X, nDonde.Y)
                        Npclist(Index).MaestroUser = UserIndex
22                      Call FollowAmo(Index)
                    Else    ' Si no encontro una posicion válida, lo siento. Se queda sin el npc.

23                      Call QuitarNPC(Index)
99                      InvocadosMatados = InvocadosMatados + 1

                    End If
                Else
25                  If CanWarp Then Call QuitarNPC(Index)
                End If
            End If
        End If
    Next i

26  If InvocadosMatados > 0 Then
        Call WriteConsoleMsg(UserIndex, "Pierdes el control de tus mascotas invocadas.", FontTypeNames.FONTTYPE_INFO)
    ElseIf Not CanWarp Then
        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_438)
    End If

    Exit Sub

Errhandler:

    Call LogError("Error en warpmascotas en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub WarpMascota(ByVal UserIndex As Integer, ByVal PetIndex As Integer)

    Dim petType As Integer
    Dim NpcIndex As Integer
    Dim iMinHP As Integer
    Dim TargetPos As WorldPos

    With UserList(UserIndex)

        TargetPos.Map = .flags.TargetMap
        TargetPos.X = .flags.TargetX
        TargetPos.Y = .flags.TargetY

        NpcIndex = .MascotasIndex(PetIndex)

        'Store data and remove NPC to recreate it after warp
        petType = .MascotasType(PetIndex)

        ' Guardamos el hp, para restaurarlo cuando se cree el npc
        iMinHP = Npclist(NpcIndex).Stats.MinHP

        Call QuitarNPC(NpcIndex)

        ' Restauramos el valor de la variable
        .MascotasType(PetIndex) = petType
        .nroMascotas = .nroMascotas + 1
        NpcIndex = SpawnNpc(petType, TargetPos, False, False)

        'Controlamos que se sumoneo OK - should never happen. Continue to allow removal of other pets if not alone
        ' Exception: Pets don't spawn in water if they can't swim
        If NpcIndex = 0 Then
            Call WriteConsoleMsg(UserIndex, "Tu mascota no pueden transitar este sector del mapa, intenta invocarla en otra parte.", FontTypeNames.FONTTYPE_INFO)
        Else
            .MascotasIndex(PetIndex) = NpcIndex

            With Npclist(NpcIndex)
                ' Nos aseguramos de que conserve el hp, si estaba dañado
                .Stats.MinHP = IIf(iMinHP = 0, .Stats.MinHP, iMinHP)

                .MaestroUser = UserIndex
                .Movement = TipoAI.SigueAmo
                .Target = 0
                .TargetNPC = 0
            End With

            Call FollowAmo(NpcIndex)
        End If
    End With
End Sub

Sub Cerrar_Usuario(ByVal UserIndex As Integer, Optional ByVal forceClose As Boolean = False)

    Dim isNotVisible As Boolean
    Dim HiddenPirat As Boolean

    With UserList(UserIndex)
        If .flags.UserLogged And Not .Counters.Saliendo Then
            .Counters.Saliendo = True

            .Counters.Salir = IIf(.flags.Privilegios < PlayerType.Consejero And MapInfo(.Pos.Map).pk, IntervaloCerrarConexion, 0)

            isNotVisible = (.flags.invisible)
            If isNotVisible Then

                .flags.invisible = 0

                If .flags.oculto Then
                    If .flags.Navegando = 1 Then
                        If .Clase = eClass.Pirat Then
                            Call ToogleBoatBody(UserIndex)
                            Call WriteMensajes(UserIndex, Mensaje_407)
                            Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
                            HiddenPirat = True
                        End If
                    End If
                End If

                '.flags.Oculto = 0
                WriteMensajes UserIndex, e_Mensajes.Mensaje_23

                Call SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)

            End If

            Call WriteConsoleMsg(UserIndex, "Cerrando...Se cerrará el juego en " & .Counters.Salir & " segundos...", FontTypeNames.FONTTYPE_INFO)

        End If
    End With
End Sub

''
' Cancels the exit of a user. If it's disconnected it's reset.
'
' @param    UserIndex   The index of the user whose exit is being reset.

Public Sub CancelExit(ByVal UserIndex As Integer)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 04/02/08
'
'***************************************************
    If UserList(UserIndex).Counters.Saliendo Then
        ' Is the user still connected?
        If UserList(UserIndex).ConnIDValida Then
            UserList(UserIndex).Counters.Saliendo = False
            UserList(UserIndex).Counters.Salir = 0
            Call WriteMensajes(UserIndex, Mensaje_407)

        Else
            'Simply reset
            UserList(UserIndex).Counters.Salir = IIf((UserList(UserIndex).flags.Privilegios < PlayerType.Consejero) And MapInfo(UserList(UserIndex).Pos.Map).pk, IntervaloCerrarConexion, 0)
        End If
    End If
End Sub

'CambiarNick: Cambia el Nick de un slot.
'
'UserIndex: Quien ejecutó la orden
'UserIndexDestino: SLot del usuario destino, a quien cambiarle el nick
'NuevoNick: Nuevo nick de UserIndexDestino
Public Sub CambiarNick(ByVal UserIndex As Integer, ByVal UserIndexDestino As Integer, ByVal NuevoNick As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim ViejoNick As String
    Dim ViejoCharBackup As String

    If UserList(UserIndexDestino).flags.UserLogged = False Then Exit Sub
    ViejoNick = UserList(UserIndexDestino).Name

    If FileExist(CharPath & ViejoNick & ".chr", vbNormal) Then
        'hace un backup del char
        ViejoCharBackup = CharPath & ViejoNick & ".chr.old-"
        Name CharPath & ViejoNick & ".chr" As ViejoCharBackup
    End If
End Sub

Sub SendUserStatsTxtOFF(ByVal SendIndex As Integer, ByVal Nombre As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If FileExist(CharPath & Nombre & ".chr", vbArchive) = False Then
        Call WriteMensajes(SendIndex, Mensaje_50)
    Else
        Call WriteConsoleMsg(SendIndex, "Estadísticas de: " & Nombre, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Nivel: " & GetVar(CharPath & Nombre & ".chr", "stats", "elv") & "  EXP: " & GetVar(CharPath & Nombre & ".chr", "stats", "Exp") & "/" & GetVar(CharPath & Nombre & ".chr", "stats", "elu"), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Energía: " & GetVar(CharPath & Nombre & ".chr", "stats", "minsta") & "/" & GetVar(CharPath & Nombre & ".chr", "stats", "maxSta"), FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Salud: " & GetVar(CharPath & Nombre & ".chr", "stats", "MinHP") & "/" & GetVar(CharPath & Nombre & ".chr", "Stats", "MaxHP") & "  Maná: " & GetVar(CharPath & Nombre & ".chr", "Stats", "MinMAN") & "/" & GetVar(CharPath & Nombre & ".chr", "Stats", "MaxMAN"), FontTypeNames.FONTTYPE_INFO)

        Call WriteConsoleMsg(SendIndex, "Menor Golpe/Mayor Golpe: " & GetVar(CharPath & Nombre & ".chr", "stats", "MaxHIT"), FontTypeNames.FONTTYPE_INFO)

        Call WriteConsoleMsg(SendIndex, "Oro: " & GetVar(CharPath & Nombre & ".chr", "stats", "GLD"), FontTypeNames.FONTTYPE_INFO)

        #If ConUpTime Then
            Dim TempSecs As Long
            Dim tempStr As String
            TempSecs = GetVar(CharPath & Nombre & ".chr", "INIT", "UpTime")
            tempStr = (TempSecs \ 86400) & " Días, " & ((TempSecs Mod 86400) \ 3600) & " Horas, " & ((TempSecs Mod 86400) Mod 3600) \ 60 & " Minutos, " & (((TempSecs Mod 86400) Mod 3600) Mod 60) & " Segundos."
            Call WriteConsoleMsg(SendIndex, "Tiempo Logeado: " & tempStr, FontTypeNames.FONTTYPE_INFO)
        #End If

    End If
End Sub

Sub SendUserOROTxtFromChar(ByVal SendIndex As Integer, ByVal charName As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim CharFile As String

    On Error Resume Next
    CharFile = CharPath & charName & ".chr"

    If FileExist(CharFile, vbNormal) Then
        Call WriteConsoleMsg(SendIndex, charName, FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(SendIndex, "Tiene " & GetVar(CharFile, "STATS", "BANCO") & " en el banco.", FontTypeNames.FONTTYPE_INFO)
    Else
        Call WriteMensajes(SendIndex, Mensaje_50)
    End If
End Sub

Sub VolverCriminal(ByVal UserIndex As Integer)
'**************************************************************
'Author: Unknown
'Last Modify Date: 21/02/2010
'Nacho: Actualiza el tag al cliente
'21/02/2010: ZaMa - Ahora deja de ser atacable si se hace criminal.
'**************************************************************
    On Error GoTo Errhandler

1   With UserList(UserIndex)
2       If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = eTrigger.ZONAPELEA Then Exit Sub

3       If Not EsGM(UserIndex) Then
4           .Reputacion.BurguesRep = 0
5           .Reputacion.NobleRep = 0
6           .Reputacion.PlebeRep = 0
7           .Reputacion.BandidoRep = .Reputacion.BandidoRep + vlASALTO

8           Dim L As Long
9           L = (-.Reputacion.AsesinoRep) + (-.Reputacion.BandidoRep) + .Reputacion.BurguesRep + (-.Reputacion.LadronesRep) + .Reputacion.NobleRep + .Reputacion.PlebeRep
10          L = L / 6
11          .Reputacion.Promedio = L
12          ' Call EnviarFama(UserIndex)

13          If .Reputacion.BandidoRep > MAXREP Then .Reputacion.BandidoRep = MAXREP
14          If .faccion.ArmadaReal = 1 Then Call ExpulsarFaccionReal(UserIndex)
15          Call RefreshCharStatus(UserIndex)
        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en VolverCriminal en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Sub VolverCiudadano(ByVal UserIndex As Integer)
'**************************************************************
'Author: Unknown
'Last Modify Date: 21/06/2006
'Nacho: Actualiza el tag al cliente.
'**************************************************************
    With UserList(UserIndex)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 6 Then Exit Sub

        .Reputacion.LadronesRep = 0
        .Reputacion.BandidoRep = 0
        .Reputacion.AsesinoRep = 0
        .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlASALTO
        If .Reputacion.PlebeRep > MAXREP Then .Reputacion.PlebeRep = MAXREP
    End With

    Call RefreshCharStatus(UserIndex)
End Sub

Public Function BodyIsBoat(ByVal body As Integer) As Boolean

    If body = iFragataReal Or body = iFragataCaos Or body = iBarcaPk Or _
       body = iGaleraPk Or body = iGaleonPk Or body = iBarcaCiuda Or _
       body = iGaleraCiuda Or body = iGaleonCiuda Or body = iFragataFantasmal Or body = 84 Then
        BodyIsBoat = True
    End If
End Function

Public Sub SetInvisible(ByVal UserIndex As Integer, ByVal userCharIndex As Integer, ByVal invisible As Boolean, Optional ByVal isOcu As Boolean = False)

    Dim sndNick As String

    With UserList(UserIndex)
        Call SendData(SendTarget.ToUsersAndRmsAndCounselorsAreaButGMs, UserIndex, PrepareMessageSetInvisible(userCharIndex, invisible, isOcu))

        sndNick = .Name

        If invisible Or isOcu Then
            If isOcu Then
                sndNick = sndNick & " " & TAG_USER_OCULTO
            Else
                sndNick = sndNick & " " & TAG_USER_INVISIBLE
            End If

        End If    'Else
        If .GuildIndex > 0 Then
            sndNick = sndNick & "<" & modGuilds.GuildName(.GuildIndex) & ">"
        End If
        '        End If
        If Not EsGM(UserIndex) Then
            If .faccion.Status = FaccionType.ChaosCouncil Then
                sndNick = sndNick & " *"
            ElseIf .faccion.Status = FaccionType.RoyalCouncil Then
                sndNick = sndNick & " /"
            End If
        End If

        If .flags.Mimetizado = 1 Then
            sndNick = sndNick & "-"
        End If

        Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, UserIndex, PrepareMessageCharacterChangeNick(userCharIndex, sndNick))
    End With
End Sub

Public Sub SetConsulatMode(ByVal UserIndex As Integer)

    Dim sndNick As String

    With UserList(UserIndex)
        sndNick = .Name

        If .flags.EnConsulta Then
            sndNick = sndNick & " " & TAG_CONSULT_MODE
        Else
            If .GuildIndex > 0 Then
                sndNick = sndNick & " <" & modGuilds.GuildName(.GuildIndex) & ">"
            End If
        End If

        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterChangeNick(.Char.CharIndex, sndNick))
    End With
End Sub

Public Function IsArena(ByVal UserIndex As Integer) As Boolean
    IsArena = (TriggerZonaPelea(UserIndex, UserIndex) = TRIGGER6_PERMITE)
End Function

Public Sub PerdioNpc(ByVal UserIndex As Integer, Optional ByVal CheckPets As Boolean = True)
'**************************************************************
'Author: ZaMa
'Last Modification: 10/08/2011 - ^[GS]^
'The user loses his owned npc
'18/01/2010: ZaMa - Las mascotas dejan de atacar al npc que se perdió.
'11/07/2010: ZaMa - Coloco el indice correcto de las mascotas y ahora siguen al amo si existen.
'13/07/2010: ZaMa - Ahora solo dejan de atacar las mascotas si estan atacando al npc que pierde su amo.
'**************************************************************

    Dim PetCounter As Long
    Dim PetIndex As Integer
    Dim NpcIndex As Integer

    With UserList(UserIndex)

        NpcIndex = .flags.OwnedNpc
        If NpcIndex > 0 Then

            If CheckPets Then
                ' Dejan de atacar las mascotas
                If .nroMascotas > 0 Then
                    For PetCounter = 1 To MAXMASCOTAS

                        PetIndex = .MascotasIndex(PetCounter)

                        If PetIndex > 0 Then
                            ' Si esta atacando al npc deja de hacerlo
                            If Npclist(PetIndex).TargetNPC = NpcIndex Then
                                Call FollowAmo(PetIndex)
                            End If
                        End If

                    Next PetCounter
                End If
            End If

            ' Reset flags
            Npclist(NpcIndex).Owner = 0
            .flags.OwnedNpc = 0

        End If
    End With

End Sub

Public Sub ApropioNpc(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)
'**************************************************************
'Author: ZaMa
'Last Modify Date: 18/01/2010 (zaMa)
'The user owns a new npc
'18/01/2010: ZaMa - El sistema no aplica a zonas seguras.
'19/04/2010: ZaMa - Ahora los admins no se pueden apropiar de npcs.
'**************************************************************

    With UserList(UserIndex)
        ' Los admins no se pueden apropiar de npcs
        If EsGM(UserIndex) Then Exit Sub

        'No aplica a zonas seguras
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = eTrigger.ZONASEGURA Then Exit Sub
        If .Pos.Map = 175 Then Exit Sub

        If MapInfo(.Pos.Map).pk = False Then Exit Sub

        ' No aplica a algunos mapas que permiten el robo de npcs
        If MapInfo(.Pos.Map).RoboNpcsPermitido = 1 Then Exit Sub

        ' Pierde el npc anterior
        If .flags.OwnedNpc > 0 Then Npclist(.flags.OwnedNpc).Owner = 0

        ' Si tenia otro dueño, lo perdio aca
        Npclist(NpcIndex).Owner = UserIndex
        .flags.OwnedNpc = NpcIndex
    End With

    ' Inicializo o actualizo el timer de pertenencia
    Call IntervaloPerdioNpc(UserIndex, True)
End Sub

Public Function GetDireccion(ByVal UserIndex As Integer, ByVal OtherUserIndex As Integer) As String
'**************************************************************
'Author: ZaMa
'Last Modify Date: 17/11/2009
'Devuelve la direccion hacia donde esta el usuario
'**************************************************************
    Dim X As Integer
    Dim Y As Integer

    X = UserList(UserIndex).Pos.X - UserList(OtherUserIndex).Pos.X
    Y = UserList(UserIndex).Pos.Y - UserList(OtherUserIndex).Pos.Y

    If X = 0 And Y > 0 Then
        GetDireccion = "Sur"
    ElseIf X = 0 And Y < 0 Then
        GetDireccion = "Norte"
    ElseIf X > 0 And Y = 0 Then
        GetDireccion = "Este"
    ElseIf X < 0 And Y = 0 Then
        GetDireccion = "Oeste"
    ElseIf X > 0 And Y < 0 Then
        GetDireccion = "NorEste"
    ElseIf X < 0 And Y < 0 Then
        GetDireccion = "NorOeste"
    ElseIf X > 0 And Y > 0 Then
        GetDireccion = "SurEste"
    ElseIf X < 0 And Y > 0 Then
        GetDireccion = "SurOeste"
    End If

End Function

Public Function SameFaccion(ByVal UserIndex As Integer, ByVal OtherUserIndex As Integer) As Boolean
'**************************************************************
'Author: ZaMa
'Last Modify Date: 17/11/2009
'Devuelve True si son de la misma faccion
'**************************************************************
    SameFaccion = (EsCaos(UserIndex) And EsCaos(OtherUserIndex)) Or _
                  (EsArmada(UserIndex) And EsArmada(OtherUserIndex))
End Function

Public Function FarthestPet(ByVal UserIndex As Integer) As Integer
'**************************************************************
'Author: ZaMa
'Last Modify Date: 18/11/2009
'Devuelve el indice de la mascota mas lejana.
'**************************************************************
    On Error GoTo Errhandler

    Dim PetIndex As Integer
    Dim distancia As Integer
    Dim OtraDistancia As Integer

    With UserList(UserIndex)
        If .nroMascotas = 0 Then Exit Function

        For PetIndex = 1 To MAXMASCOTAS
            ' Solo pos invocar criaturas que exitan!
            If .MascotasIndex(PetIndex) > 0 Then
                ' Solo aplica a mascota, nada de elementales..
                If Npclist(.MascotasIndex(PetIndex)).Contadores.TiempoExistencia = 0 Then
                    If FarthestPet = 0 Then
                        ' Por si tiene 1 sola mascota
                        FarthestPet = PetIndex
                        distancia = Abs(.Pos.X - Npclist(.MascotasIndex(PetIndex)).Pos.X) + _
                                    Abs(.Pos.Y - Npclist(.MascotasIndex(PetIndex)).Pos.Y)
                    Else
                        ' La distancia de la proxima mascota
                        OtraDistancia = Abs(.Pos.X - Npclist(.MascotasIndex(PetIndex)).Pos.X) + _
                                        Abs(.Pos.Y - Npclist(.MascotasIndex(PetIndex)).Pos.Y)
                        ' Esta mas lejos?
                        If OtraDistancia > distancia Then
                            distancia = OtraDistancia
                            FarthestPet = PetIndex
                        End If
                    End If
                End If
            End If
        Next PetIndex
    End With

    Exit Function

Errhandler:
    Call LogError("Error en FarthestPet")
End Function

''
' Set the EluSkill value at the skill.
'
' @param UserIndex  Specifies reference to user
' @param Skill      Number of the skill to check
' @param Allocation True If the motive of the modification is the allocation, False if the skill increase by training

Public Sub CheckEluSkill(ByVal UserIndex As Integer, ByVal Skill As Byte, ByVal Allocation As Boolean)
'*************************************************
'Author: Torres Patricio (Pato)
'Last modified: 11/20/2009
'
'*************************************************

    With UserList(UserIndex).Stats
        If .UserSkills(Skill) < MAXSKILLPOINTS Then
            If Allocation Then
                .ExpSkills(Skill) = 0
            Else
                .ExpSkills(Skill) = .ExpSkills(Skill) - .EluSkills(Skill)
            End If

            .EluSkills(Skill) = ELU_SKILL_INICIAL * 1.05 ^ .UserSkills(Skill)
        Else
            .ExpSkills(Skill) = 0
            .EluSkills(Skill) = 0
        End If
    End With

End Sub

Public Function HasEnoughItems(ByVal UserIndex As Integer, ByVal ObjIndex As Integer, ByVal Amount As Long) As Boolean
'**************************************************************
'Author: ZaMa
'Last Modify Date: 25/11/2009
'Cheks Wether the user has the required amount of items in the inventory or not
'**************************************************************

    Dim Slot As Long
    Dim ItemInvAmount As Long

    For Slot = 1 To UserList(UserIndex).CurrentInventorySlots
        ' Si es el item que busco
        If UserList(UserIndex).Invent.Object(Slot).ObjIndex = ObjIndex Then
            ' Lo sumo a la cantidad total
            ItemInvAmount = ItemInvAmount + UserList(UserIndex).Invent.Object(Slot).Amount
        End If
    Next Slot

    HasEnoughItems = Amount <= ItemInvAmount
End Function

Public Function TotalOfferItems(ByVal ObjIndex As Integer, ByVal UserIndex As Integer) As Long
'**************************************************************
'Author: ZaMa
'Last Modify Date: 25/11/2009
'Cheks the amount of items the user has in offerSlots.
'**************************************************************
    Dim Slot As Byte

    For Slot = 1 To MAX_OFFER_SLOTS
        ' Si es el item que busco
        If UserList(UserIndex).ComUsu.objeto(Slot) = ObjIndex Then
            ' Lo sumo a la cantidad total
            TotalOfferItems = TotalOfferItems + UserList(UserIndex).ComUsu.Cant(Slot)
        End If
    Next Slot

End Function

Public Function getMaxInventorySlots(ByVal UserIndex As Integer) As Byte

    If UserList(UserIndex).Clase = eClass.Pirat Then
        getMaxInventorySlots = MAX_NORMAL_INVENTORY_SLOTS + 10
    Else
        getMaxInventorySlots = MAX_NORMAL_INVENTORY_SLOTS
    End If
End Function

Public Sub Freeslot(ByVal UserIndex As Integer)

    UserList(UserIndex).ConnIDValida = False

    If UserIndex = LastUser Then
        Do While (LastUser > 0) And UserList(LastUser).flags.UserLogged
            LastUser = LastUser - 1
            If LastUser < 1 Then Exit Do
        Loop
    End If

End Sub
