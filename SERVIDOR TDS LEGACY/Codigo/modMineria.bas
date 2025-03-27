Attribute VB_Name = "modMineria"
Option Explicit

Public Sub DoMineria_v2(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    Dim suerte As Integer
    Dim res As Integer
    Dim CantidadItems As Integer
    Dim min As Byte
    Dim max As Byte

    With UserList(UserIndex)
        If .Clase = eClass.Miner Then
            Call QuitarSta(UserIndex, EsfuerzoExcavarMinero)
        Else
            Call QuitarSta(UserIndex, EsfuerzoExcavarGeneral)
        End If

        Dim Skill As Integer
        Skill = .Stats.UserSkills(eSkill.Mineria)
        suerte = Int(-0.00125 * Skill * Skill - 0.3 * Skill + 49)

        res = RandomNumber(1, suerte)

        If res <= 10 Then
            Dim MiObj As Obj

            If .flags.TargetObj = 0 Then Exit Sub

            MiObj.ObjIndex = ObjData(.flags.TargetObj).MineralIndex

            If UserList(UserIndex).Clase = eClass.Miner Then
                CantidadItems = RandomNumber(1, 5)

                MiObj.Amount = RandomNumber(1, CantidadItems)
            Else

                Select Case .Stats.UserSkills(eSkill.Mineria)
                Case 0:
                    min = 0
                    max = 0
                Case 1 To 99:
                    min = 0
                    max = 1
                Case 100:
                    min = 1
                    max = 1
                End Select

                MiObj.Amount = RandomNumber(min, max)
            End If

            If MiObj.Amount Then
                If Not MeterItemEnInventario(UserIndex, MiObj) Then _
                   Call TirarItemAlPiso(.Pos, MiObj)


                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(15, .Pos.X, .Pos.Y))

                WriteMensajes UserIndex, e_Mensajes.Mensaje_126
            End If

            Call SubirSkill(UserIndex, eSkill.Mineria, True)
        Else
            '[CDT 17-02-2004]
            If Not .flags.UltimoMensaje = 9 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_127
                .flags.UltimoMensaje = 9
            End If
            '[/CDT]
            Call SubirSkill(UserIndex, eSkill.Mineria, False)
        End If


        .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlProleta
        If .Reputacion.PlebeRep > MAXREP Then _
           .Reputacion.PlebeRep = MAXREP

        .Counters.Trabajando = UserList(UserIndex).Counters.Trabajando + 1
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en Sub DoMineria_v2")

End Sub

Public Sub DoMineria(UserIndex As Integer)
    On Error GoTo Errhandler

    Dim suerte As Integer
    Dim res As Integer
    Dim CantidadItems As Integer

    With UserList(UserIndex)
        If .Clase = eClass.Miner Then
            Call QuitarSta(UserIndex, EsfuerzoExcavarMinero)
        Else
            Call QuitarSta(UserIndex, EsfuerzoExcavarGeneral)
        End If

        Dim Skill As Integer
        Skill = .Stats.UserSkills(eSkill.Mineria)
        suerte = Int(-0.00125 * Skill * Skill - 0.3 * Skill + 49)

        res = RandomNumber(1, suerte)

        If res <= 10 Then
            Dim MiObj As Obj

            If .flags.TargetObj = 0 Then Exit Sub

            MiObj.ObjIndex = ObjData(.flags.TargetObj).MineralIndex

            If UserList(UserIndex).Clase = eClass.Miner Then
                CantidadItems = RandomNumber(1, 5)    '1 + MaximoInt(1, Skill / 2)

                MiObj.Amount = RandomNumber(1, CantidadItems)
            Else
                MiObj.Amount = 1
            End If

            If Not MeterItemEnInventario(UserIndex, MiObj) Then _
               Call TirarItemAlPiso(.Pos, MiObj)
            WriteMensajes UserIndex, e_Mensajes.Mensaje_126
            Call quitarHamYSed(UserIndex)

            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(15, .Pos.X, .Pos.Y))


            Call SubirSkill(UserIndex, eSkill.Mineria, True)
        Else
            '[CDT 17-02-2004]
            If Not .flags.UltimoMensaje = 9 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_127
                .flags.UltimoMensaje = 9
            End If
            '[/CDT]
            Call SubirSkill(UserIndex, eSkill.Mineria, False)
        End If

        .Reputacion.PlebeRep = .Reputacion.PlebeRep + vlProleta
        If .Reputacion.PlebeRep > MAXREP Then _
           .Reputacion.PlebeRep = MAXREP

        .Counters.Trabajando = UserList(UserIndex).Counters.Trabajando + 1
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en Sub DoMineria")

End Sub
