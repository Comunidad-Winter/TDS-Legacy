Attribute VB_Name = "modPersonaje"
Public Function tieneArmaduraCazador(ByRef personaje As User) As Boolean

    If personaje.Invent.ArmourEqpObjIndex > 0 Then
        If (personaje.Invent.ArmourEqpObjIndex = 360 Or _
            personaje.Invent.ArmourEqpObjIndex = 671 Or _
            personaje.Invent.ArmourEqpObjIndex = 612 Or _
            personaje.Invent.ArmourEqpObjIndex = 665 Or _
            personaje.Invent.ArmourEqpObjIndex = 833 Or _
            personaje.Invent.ArmourEqpObjIndex = 834 Or _
            personaje.Invent.ArmourEqpObjIndex = 835 Or _
            personaje.Invent.ArmourEqpObjIndex = 666 Or _
            personaje.Invent.ArmourEqpObjIndex = 667) Then

            tieneArmaduraCazador = True
            Exit Function
        End If
    End If

    tieneArmaduraCazador = False
End Function
Private Sub dejarDeOcultarseAlMoverse(ByRef personaje As User)

' Regla
    If personaje.Clase = eClass.Hunter Then
        If personaje.Invent.ArmourEqpObjIndex > 0 Then
            If tieneArmaduraCazador(personaje) Then
                If personaje.flags.oculto > 0 Then
                    'If Distance(personaje.Pos.x, personaje.Pos.y, personaje.eventoOcultar.Posicion.x, personaje.eventoOcultar.Posicion.y) < 2 Then
                    '    Exit Sub
                    'End If
                End If
            End If
        End If
    End If

    'Call quitarOcultamiento(personaje)

    If personaje.flags.AdminInvisible = 0 Then
        personaje.flags.oculto = 0
        personaje.Counters.Ocultando = 0
        WriteMensajes UserIndex, e_Mensajes.Mensaje_23
        Call UsUaRiOs.SetInvisible(personaje.UserIndex, personaje.Char.CharIndex, personaje.flags.invisible = 1, personaje.flags.oculto = 1)
    End If

End Sub

