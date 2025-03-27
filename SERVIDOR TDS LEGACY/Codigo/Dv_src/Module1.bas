Attribute VB_Name = "aaaa_ModFUN"
Option Explicit

Public Sub hp_full(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        .Stats.ELV = 1

        .Stats.MaxHIT = 2
        .Stats.MinHIT = 1

        .Stats.UserAtributos(eAtributos.Fuerza) = 18 + ModRaza(.raza).Fuerza
        .Stats.UserAtributos(eAtributos.Agilidad) = 18 + ModRaza(.raza).Agilidad
        .Stats.UserAtributos(eAtributos.Inteligencia) = 18 + ModRaza(.raza).Inteligencia
        .Stats.UserAtributos(eAtributos.Carisma) = 18 + ModRaza(.raza).Carisma
        .Stats.UserAtributos(eAtributos.Constitucion) = 18 + ModRaza(.raza).Constitucion

        .Stats.UserAtributosBackUP(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza)
        .Stats.UserAtributosBackUP(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad)
        .Stats.UserAtributosBackUP(eAtributos.Inteligencia) = .Stats.UserAtributos(eAtributos.Inteligencia)
        .Stats.UserAtributosBackUP(eAtributos.Carisma) = .Stats.UserAtributos(eAtributos.Carisma)
        .Stats.UserAtributosBackUP(eAtributos.Constitucion) = .Stats.UserAtributos(eAtributos.Constitucion)

        Call WriteUpdateStrenghtAndDexterity(UserIndex)

        Dim LoopC As Long
        For LoopC = 1 To NUMATRIBUTOS
            Call WriteVar(App.path & "/CHARFILE/" & UCase$(.Name) & ".CHR", "ATRIBUTOS", "AT" & LoopC, .Stats.UserAtributos(LoopC))
        Next LoopC

        .Stats.MaxSta = 999
        .Stats.GLD = 5000000

        Dim MinHP As Integer, MaxHP As Integer, AumentoMANA As Integer, AumentoHIT As Integer

        If .Clase = eClass.Warrior And .raza = eRaza.Enano Then
            .Stats.MaxHP = RandomNumber(19, 22)
        Else
            .Stats.MaxHP = RandomNumber(19, 21)
        End If

        .Stats.MinHP = .Stats.MaxHP

        If .Clase = eClass.Mage Then
            .Stats.MaxMAN = RandomNumber(100, 105)
            .Stats.MinMAN = .Stats.MaxMAN
        ElseIf .Clase = eClass.Cleric Or .Clase = eClass.Druid _
               Or .Clase = eClass.Bard Or .Clase = eClass.Assasin Then
            .Stats.MaxMAN = 50
            .Stats.MinMAN = 50
        Else
            .Stats.MaxMAN = 0
            .Stats.MinMAN = 0
        End If
        Dim promup As Byte

        Do While (.Stats.ELV < 47)

            .Stats.ELV = .Stats.ELV + 1

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
                Case 18
                    MinHP = 7
                    MaxHP = 11
                Case Else
                    MinHP = 7
                    MaxHP = 11
                End Select
                AumentoHIT = IIf(.Stats.ELV > 35, 2, 3)

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
                Case 18
                    MinHP = 6
                    MaxHP = 10
                Case Else
                    MinHP = 6
                    MaxHP = 10
                End Select
                AumentoHIT = IIf(.Stats.ELV > 35, 2, 3)

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
                Case 18
                    MinHP = 6
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 11
                End Select

                AumentoHIT = 2

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
                Case 18
                    MinHP = 6
                    MaxHP = 11
                Case Else
                    MinHP = 6
                    MaxHP = 11
                End Select

                AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)
                AumentoHIT = IIf(.Stats.ELV > 35, 1, 3)

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
                Case 18
                    MinHP = 4
                    MaxHP = 8
                Case Else
                    MinHP = 4
                    MaxHP = 8
                End Select
                AumentoHIT = 2

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
                Case 18
                    MinHP = 3
                    MaxHP = 8
                Case Else
                    MinHP = 3
                    MaxHP = 8
                End Select

                AumentoHIT = 1
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
                Case 18
                    MinHP = 6
                    MaxHP = 11
                Case Else
                    MinHP = 7
                    MaxHP = 11
                End Select
                AumentoHIT = 2

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
                Case 18
                    MinHP = 5
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)

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
                Case 18
                    MinHP = 5
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)

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
                Case 18
                    MinHP = 5
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = IIf(.Stats.ELV > 35, 1, 3)
                AumentoMANA = .Stats.UserAtributos(eAtributos.Inteligencia)

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
                Case 18
                    MinHP = 5
                    MaxHP = 9
                Case Else
                    MinHP = 5
                    MaxHP = 9
                End Select

                AumentoHIT = 2
                AumentoMANA = 2 * .Stats.UserAtributos(eAtributos.Inteligencia)

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
                Case 18
                    MinHP = 3
                    MaxHP = 8
                Case Else
                    MinHP = 3
                    MaxHP = 8
                End Select
                AumentoHIT = 2

            End Select

            'Actualizamos HitPoints
            promup = RandomNumber(MinHP, MaxHP)

            If promup < MaxHP Then
                If (.Stats.MaxHP - (((MinHP + MaxHP) / 2) * (.Stats.ELV - 1) + 20)) < 7 Then
                    promup = promup + IIf(RandomNumber(1, 8) = 1, 1, 0)
                End If
                If promup > MaxHP Then promup = MaxHP
            End If

            .Stats.MaxHP = .Stats.MaxHP + promup

            If .Stats.ELV = 47 Then
                Call WriteConsoleMsg(UserIndex, "Resultado final de vidas: " & (.Stats.MaxHP) - (((MinHP + MaxHP) / 2) * (.Stats.ELV - 1) + 20))
            End If

            .Stats.MaxHIT = .Stats.MaxHIT + AumentoHIT
            .Stats.MinHIT = .Stats.MinHIT + AumentoHIT

            If .Stats.MaxHP > STAT_MAXHP Then .Stats.MaxHP = STAT_MAXHP

            'Actualizamos Mana
            .Stats.MaxMAN = .Stats.MaxMAN + AumentoMANA
            If .Stats.MaxMAN > STAT_MAXMAN Then .Stats.MaxMAN = STAT_MAXMAN

            .Stats.MinHP = .Stats.MaxHP

        Loop

        Dim i As Long
        For i = 1 To NUMSKILLS
            .Stats.UserSkills(i) = 100
        Next i

        .Stats.MinMAN = .Stats.MaxMAN
        .Stats.minSta = .Stats.MaxSta

        Call WriteUpdateUserStats(UserIndex)
        
        Call PJFull(UserIndex)

        Call logPromedios(.Name & " usó el /NIVEL!")

    End With

End Sub

Public Sub PJFull(ByVal UserIndex As Integer)

'If val(GetVar(IniPath & "server.ini", "INIT", "FUN")) = 0 Then Exit Sub

    Dim i As Long

    With UserList(UserIndex)

        For i = 1 To NUMATRIBUTOS
            .Stats.UserAtributos(i) = 18
        Next i

        For i = 1 To NUMSKILLS
            .Stats.UserSkills(i) = 100
        Next i

        .Stats.UserHechizos(1) = 2        'DARDO
        .Stats.UserHechizos(33) = 25        'APOCA
        .Stats.UserHechizos(32) = 23        'DESCARGA
        .Stats.UserHechizos(35) = 10        'REMO
        .Stats.UserHechizos(31) = 15        'TORMENTA
        .Stats.UserHechizos(26) = 11        'RESU
        .Stats.UserHechizos(34) = 24        'INMO
        .Stats.UserHechizos(30) = 14        'INVI
        .Stats.UserHechizos(23) = 42        'MIMENTISMO [SOLO SI ES DRUIDA SE MUESTRA]
        .Stats.UserHechizos(25) = 27        'ELE DE AGUA
        .Stats.UserHechizos(24) = 28        'ELE DE TIERRA
        .Stats.UserHechizos(28) = 18        'CELE
        .Stats.UserHechizos(27) = 20        'FZZZ
        .Stats.UserHechizos(22) = 29        'IMPLORAR AYUDA [SOLO SI ES DRUIDA SE MUESTRA]

        Dim modif As Double
        Select Case .raza

        Case eRaza.Elfo, eRaza.Drow
            modif = -0.5
        Case eRaza.Enano
            modif = 0.5
        Case eRaza.Gnomo
            modif = -1
        End Select

        .Stats.MaxHP = Fix(47 * (ModVida(.Clase) + modif)) + 15

        .Stats.MinHP = .Stats.MaxHP
        WriteUpdateHP UserIndex

        .Stats.ELV = 47
        .Stats.elu = 0
        Select Case .Clase
        Case eClass.Paladin
            .Stats.MaxMAN = Round(.Stats.UserAtributos(eAtributos.Inteligencia) * 47)
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 644        'rm


        Case eClass.Mage
            .Stats.MaxMAN = Round(2.8 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 622
            .Invent.Object(6).Amount = 1
            .Invent.Object(6).ObjIndex = 623

        Case eClass.Cleric
            .Stats.MaxMAN = (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 646


        Case eClass.Druid
            .Stats.MaxMAN = 0.5 + (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 646
            .Invent.Object(6).Amount = 1
            .Invent.Object(6).ObjIndex = 648

        Case eClass.Assasin
            .Stats.MaxMAN = (.Stats.UserAtributos(eAtributos.Inteligencia)) * 47
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 646


        Case eClass.Bard
            .Stats.MaxMAN = (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
            .Invent.Object(5).Amount = 1
            .Invent.Object(5).ObjIndex = 643        'laud

        End Select

        Call UpdateUserInv(True, UserIndex, 0)
        Call UpdateUserHechizos(True, UserIndex, 0)

        .Stats.MaxSta = 1000
        .Stats.minSta = 1000
        .Stats.MaxHIT = 47 * 2
        .Stats.MinHIT = 47

        .Stats.GLD = 10000000

    End With

End Sub

Private Sub BALANCE_TopHP_TopMAN()
    With UserList(1)
        Dim loopClase As Long
        Dim loopRaza As Long

        For loopClase = 1 To NUMCLASES

            .Clase = loopClase

            For loopRaza = 1 To NUMRAZAS
                .raza = loopRaza

                .Stats.UserAtributos(eAtributos.Fuerza) = 18 + ModRaza(loopRaza).Fuerza
                .Stats.UserAtributos(eAtributos.Agilidad) = 18 + ModRaza(loopRaza).Agilidad
                .Stats.UserAtributos(eAtributos.Inteligencia) = 18 + ModRaza(loopRaza).Inteligencia
                .Stats.UserAtributos(eAtributos.Carisma) = 18 + ModRaza(loopRaza).Carisma
                .Stats.UserAtributos(eAtributos.Constitucion) = 18 + ModRaza(loopRaza).Constitucion

                If .Clase = eClass.Mage Then
                    .Stats.MaxMAN = 100 + .Stats.UserAtributos(eAtributos.Inteligencia) / 3
                    .Stats.MinMAN = 100 + .Stats.UserAtributos(eAtributos.Inteligencia) / 3
                ElseIf .Clase = eClass.Cleric Or .Clase = eClass.Druid _
                       Or .Clase = eClass.Bard Or .Clase = eClass.Assasin Then
                    .Stats.MaxMAN = 50
                    .Stats.MinMAN = 50
                Else
                    .Stats.MaxMAN = 0
                    .Stats.MinMAN = 0
                End If

                .Stats.MaxHP = 47 * ((ModVida(.Clase) - (21 - .Stats.UserAtributos(eAtributos.Constitucion)) * 0.5))
                .Stats.MinHP = .Stats.MaxHP
                .Stats.ELV = 47
                .Stats.elu = 0
                Select Case .Clase
                Case eClass.Paladin
                    .Stats.MaxMAN = (.Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                Case eClass.Mage
                    .Stats.MaxMAN = (2.8 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                Case eClass.Cleric
                    .Stats.MaxMAN = (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                Case eClass.Druid
                    .Stats.MaxMAN = (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                Case eClass.Assasin
                    .Stats.MaxMAN = (.Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                Case eClass.Bard
                    .Stats.MaxMAN = (2 * .Stats.UserAtributos(eAtributos.Inteligencia)) * 47
                End Select
                .Stats.MinMAN = .Stats.MaxMAN
                Call WriteVar(App.path & "/resultados.txt", ListaClases(loopClase), ListaRazas(loopRaza), .Stats.MaxHP & "-" & .Stats.MaxMAN)
            Next loopRaza
        Next loopClase

        Call WriteUpdateUserStats(1)

    End With
End Sub

