Attribute VB_Name = "modPesca"
Option Explicit

Public Sub DoPescar_Cana(personaje As User)

    Dim tieneEnergia As Boolean
    Dim numeroPez As Byte
    Dim suerte As Integer
    Dim MiObj As Obj

    'Energia
    If personaje.Clase = eClass.Fisherman Then
        tieneEnergia = QuitarSta(personaje.UserIndex, EsfuerzoPescarPescador)
    Else
        tieneEnergia = QuitarSta(personaje.UserIndex, EsfuerzoPescarGeneral)
    End If

    If Not tieneEnergia Then
        ' Le avisamos que esta cansado
        Call WriteConsoleMsg(personaje.UserIndex, "Estás demasiado cansado. Esperá un poco antes de seguir trabajando.")
        ' Dejamos de trabajar
        Call WriteStopWorking(personaje.UserIndex)
        Exit Sub
    End If

    ' Siempre sube Skill
    Call SubirSkill(personaje.UserIndex, eSkill.Pesca)
    personaje.Trabajo.tipo = 1

    Call CalcularModificador(personaje)

    ' Tiramos la suerte
    suerte = RandomNumber(1, personaje.Trabajo.modificador)

    If suerte > 57 Then

        WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_117
        personaje.flags.UltimoMensaje = e_Mensajes.Mensaje_117
        Exit Sub    ' No ha tenido suerte
    End If

    ' Cuantos peces saca?
    If personaje.Clase = eClass.Fisherman Then
        If suerte < 3 And personaje.flags.Navegando = 1 And (hasItemAndEquipped(personaje.UserIndex, 475) Or hasItemAndEquipped(personaje.UserIndex, 476)) Then    'personaje.Invent.BarcoObjIndex = 475 Then
            numeroPez = 4
        ElseIf suerte < 13 And personaje.flags.Navegando = 1 Then
            numeroPez = 3
        ElseIf suerte < 19 Then
            numeroPez = 2
        Else
            numeroPez = 1
        End If
    Else
        numeroPez = 1
    End If

    ' Creamos los peces
    Do While numeroPez > 0

        MiObj.Amount = 1    ' Siempre saca 1

        ' ¿Qué pez le toca?
        If numeroPez = 1 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO1
        ElseIf numeroPez = 2 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO2
        ElseIf numeroPez = 3 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO3
        Else
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO4
        End If

        ' Lo agregamos
        If Not InvUsuario.tieneLugar(personaje, MiObj) Then
            ' Avisamos
            Call WriteConsoleMsg(personaje.UserIndex, "No tienes más lugar para guardar más pesces.")
            ' Dejamos de trabajar
            Call WriteStopWorking(personaje.UserIndex)
            ' Salimos
            Exit Sub
        Else
            ' Agregamos
            Call InvUsuario.MeterItemEnInventario(personaje.UserIndex, MiObj)
        End If

        ' Siguiente pez
        numeroPez = numeroPez - 1
    Loop

    ' Efectos y Mensaje
    Call SendData(SendTarget.ToPCArea, personaje.UserIndex, PrepareMessagePlayWave(SND_PESCAR, UserList(personaje.UserIndex).Pos.X, UserList(personaje.UserIndex).Pos.Y))

    ' Energia
    Call WriteUpdateSta(personaje.UserIndex)

    Call quitarHamYSed(personaje.UserIndex)


    '  If Not personaje.flags.UltimoMensaje = 6 Then
    WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_118
    personaje.flags.UltimoMensaje = 6
    ' End If

End Sub

Public Sub DoPescar_Red(personaje As User)
    Dim tieneEnergia As Boolean
    Dim MiObj As Obj
    Dim numeroPez As Byte
    Dim suerte As Single

    'Energia
    If personaje.Clase = eClass.Fisherman Then
        tieneEnergia = QuitarSta(personaje.UserIndex, EsfuerzoPescarPescador)
    Else
        tieneEnergia = QuitarSta(personaje.UserIndex, EsfuerzoPescarGeneral)
    End If

    If Not tieneEnergia Then
        ' Le avisamos que esta cansado
        Call WriteConsoleMsg(personaje.UserIndex, "Estás demasiado cansado. Esperá un poco antes de seguir trabajando.")
        ' Dejamos de trabajar
        Call WriteStopWorking(personaje.UserIndex)
        Exit Sub
    End If

    ' Siempre sube Skill
    Call SubirSkill(personaje.UserIndex, eSkill.Pesca)

    suerte = RandomNumber(1, 100)

    If suerte > 58.33 Then
        WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_117
        personaje.flags.UltimoMensaje = e_Mensajes.Mensaje_117
        Exit Sub    ' Nada!
    End If

    ' ¿Cuantos peces saca?
    If suerte < 2 Then
        numeroPez = 5
    ElseIf suerte < 3.22 Then
        numeroPez = 4
    ElseIf suerte < 13.31 Then
        numeroPez = 3
    ElseIf suerte < 19.44 Then
        numeroPez = 2
    Else
        numeroPez = 1
    End If

    ' Creamos los peces
    Do While numeroPez > 0

        MiObj.Amount = 1    ' Siempre saca 1

        ' ¿Qué pez le toca?
        If numeroPez = 1 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO1
        ElseIf numeroPez = 2 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO2
        ElseIf numeroPez = 3 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO3
        ElseIf numeroPez = 4 Then
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO4
        Else
            MiObj.ObjIndex = PECES_POSIBLES.PESCADO5
        End If

        ' Lo agregamos
        If Not InvUsuario.tieneLugar(personaje, MiObj) Then
            ' Avisamos
            Call WriteConsoleMsg(personaje.UserIndex, "No tienes más lugar para guardar más pesces.")
            ' Dejamos de trabajar
            Call WriteStopWorking(personaje.UserIndex)
            ' Salimos
            Exit Sub
        Else
            ' Agregamos
            Call InvUsuario.MeterItemEnInventario(personaje.UserIndex, MiObj)
        End If

        ' Siguiente pez
        numeroPez = numeroPez - 1
    Loop

    ' Efectos y Mensaje
    Call SendData(SendTarget.ToPCArea, personaje.UserIndex, PrepareMessagePlayWave(SND_PESCAR, UserList(personaje.UserIndex).Pos.X, UserList(personaje.UserIndex).Pos.Y))

    ' Energia
    Call WriteUpdateSta(personaje.UserIndex)
    Call quitarHamYSed(personaje.UserIndex)

    If Not personaje.flags.UltimoMensaje = 6 Then
        WriteMensajes personaje.UserIndex, e_Mensajes.Mensaje_118
        personaje.flags.UltimoMensaje = 6
    End If


End Sub

