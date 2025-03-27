Attribute VB_Name = "modTalar"
Option Explicit

Public Const EsfuerzoTalarGeneral = 4
Public Const EsfuerzoTalarLeñador = 2

Public Function calcularRangoExtraccionTalar(personaje As User) As tRango

    If personaje.Clase = eClass.Woodcutter Then

        Select Case personaje.Stats.UserSkills(eSkill.Talar)
        Case 0:
            calcularRangoExtraccionTalar.minimo = 0
            calcularRangoExtraccionTalar.maximo = 0
        Case 1 To 30:
            calcularRangoExtraccionTalar.minimo = 0
            calcularRangoExtraccionTalar.maximo = 1
        Case 31 To 60:
            calcularRangoExtraccionTalar.minimo = 0
            calcularRangoExtraccionTalar.maximo = 2
        Case 61 To 90:
            calcularRangoExtraccionTalar.minimo = 1
            calcularRangoExtraccionTalar.maximo = 2
        Case 91 To 99:
            calcularRangoExtraccionTalar.minimo = 1
            calcularRangoExtraccionTalar.maximo = 3
        Case 100:
            calcularRangoExtraccionTalar.minimo = 2
            calcularRangoExtraccionTalar.maximo = 4
        End Select

    Else

        Select Case personaje.Stats.UserSkills(eSkill.Talar)
        Case 0:
            calcularRangoExtraccionTalar.minimo = 0
            calcularRangoExtraccionTalar.maximo = 0
        Case 1 To 99:
            calcularRangoExtraccionTalar.minimo = 0
            calcularRangoExtraccionTalar.maximo = 1
        Case 100:
            calcularRangoExtraccionTalar.minimo = 1
            calcularRangoExtraccionTalar.maximo = 1
        End Select

    End If


End Function


Public Sub DoTalar(ByVal UserIndex As Integer, Optional ByVal DarMaderaDeTejo As Boolean = False)

    On Error GoTo Errhandler

    Dim suerte As Integer
    Dim res As Integer
    Dim CantidadItems As Integer

    If UserList(UserIndex).Clase = eClass.Woodcutter Then
        Call QuitarSta(UserIndex, EsfuerzoTalarLeñador)
    Else
        Call QuitarSta(UserIndex, EsfuerzoTalarGeneral)
    End If

    Dim Skill As Integer
    Skill = UserList(UserIndex).Stats.UserSkills(eSkill.Talar)
    suerte = Int(-0.00125 * Skill * Skill - 0.3 * Skill + 49)

    res = RandomNumber(1, suerte)

    If res <= 10 Then
        Dim MiObj As Obj
        MiObj.ObjIndex = IIf(DarMaderaDeTejo, LeñaTejo, Leña)

        Dim factProb As Single
        Select Case UserList(UserIndex).Stats.UserSkills(eSkill.Talar)
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

        factProb = factProb + rateTala


        res = RandomNumber(1, 100)

        If res <= RandomNumber(1, (100 * factProb)) Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_124)

            If UserList(UserIndex).Clase = eClass.Woodcutter Then
                MiObj.Amount = RandomNumber(1, 5)
            Else
                MiObj.Amount = 1
            End If

            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_TALAR, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y))
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(UserList(UserIndex).Pos, MiObj)
            End If
            Call quitarHamYSed(UserIndex)

        Else
            'If Not UserList(UserIndex).flags.UltimoMensaje = 8 Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_125
            UserList(UserIndex).flags.UltimoMensaje = 8
            'End If
            Call SubirSkill(UserIndex, eSkill.Talar, False)
        End If

    Else
        '[CDT 17-02-2004]
        'If Not UserList(UserIndex).flags.UltimoMensaje = 8 Then
        WriteMensajes UserIndex, e_Mensajes.Mensaje_125
        UserList(UserIndex).flags.UltimoMensaje = 8
        'End If
        '[/CDT]
        Call SubirSkill(UserIndex, eSkill.Talar, False)
    End If

    UserList(UserIndex).Reputacion.PlebeRep = UserList(UserIndex).Reputacion.PlebeRep + vlProleta
    If UserList(UserIndex).Reputacion.PlebeRep > MAXREP Then _
       UserList(UserIndex).Reputacion.PlebeRep = MAXREP

    UserList(UserIndex).Counters.Trabajando = UserList(UserIndex).Counters.Trabajando + 1

    Exit Sub

Errhandler:
    Call LogError("Error en DoTalar")

End Sub
