Attribute VB_Name = "mod_Torneos1vs1EXPERIMENTAL"
Option Explicit
'Tierras del Sur AO

'Torneos 1vs1

'Programado por El_Santo


Public Torneo1 As tTorneos

Public Sub NuevoTorneo(ByVal UserIndex As Integer, Cupos As Byte, ByVal MaxRojas As Byte, ClaseProhibida() As Boolean)
    With Torneo1
        Dim ProhibidasStr As String, LoopC As Long, Count As Byte
        .Activo = True
        .EmpezoPelea = False
        .ActualCupos = 0
        .Cupos = Cupos
        For LoopC = 1 To NUMCLASES
            .ClaseProhibida(LoopC) = ClaseProhibida(LoopC)
        Next LoopC
        .MaxRojas = MaxRojas
        ReDim .ListaUsers(1 To Cupos)
        For LoopC = 1 To NUMCLASES
            If .ClaseProhibida(LoopC) = True Then
                Count = Count + 1
                ProhibidasStr = ProhibidasStr & ", "
            End If
        Next LoopC
        If Count > 0 Then
            ProhibidasStr = Left$(ProhibidasStr, Len(ProhibidasStr) - 2) 'Le sacamos el ", "
        End If
        .NumProhibidas = Count
        Call MensajeTorneo(UserList(UserIndex).Name & _
                            " está organizando un [Torneo 1vs1] para " & Cupos & _
                            " participantes. Clases prohibidas: " & Count & _
                            "(" & ProhibidasStr & ")" & _
                            IIf(.MaxRojas > 0, "Maximo de pociones rojas: " & .MaxRojas _
                            & ".", "."), FontTypeNames.FONTTYPE_GUILD)
    End With
End Sub

Public Sub IngresarUsuario(ByVal UserIndex As Integer)
    With Torneo1
        Dim LoopC As Long, encontroLugar As Byte

        'Esta permitida su clase?
        If .NumProhibidas > 0 Then
            If .ClaseProhibida(UserList(UserIndex).clase) Then
                Call WriteConsoleMsg(UserIndex, "Tu clase esta prohibida en este torneo.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        End If
        
        'Si todavia no empezo la pelea, podriamos conseguirle un cupo de alguien que deslogio.
        If .Cupos = .ActualCupos And .EmpezoPelea = False Then
            Call WriteConsoleMsg(UserIndex, "Los cupos ya fueron completados. Si se libera un cupo, sera notificado por consola.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf .EmpezoPelea = True Then 'Nos fijamos si algun gil deslogio, y sino lo mandamos al chori
            For LoopC = 1 To .Cupos
                If .ListaUsers(LoopC) <= 0 Then 'Le encontramos un lugar
                    encontroLugar = LoopC
                    Exit For
                End If
            Next LoopC
            If encontroLugar Then   'Si no encontro, bye bye baby
                .ListaUsers(encontroLugar) = UserIndex
                UserList(UserIndex).Torneo1.EnTorneo = True
                'Warp a la sala de espera.
            Else
                Call WriteConsoleMsg(UserIndex, "Los cupos ya fueron completados. Si se libera un cupo, sera notificado por consola.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
            
        'Todo tranquilo, hay cupos y no empezo todavia.
        ElseIf .Cupos > .ActualCupos And .EmpezoPelea = False Then
            For LoopC = 1 To .Cupos
                If .ListaUsers(LoopC) <= 0 Then 'Le encontramos un lugar
                    encontroLugar = LoopC
                End If
            Next LoopC
            .ListaUsers(LoopC) = UserIndex
            UserList(UserIndex).Torneo1.EnTorneo = True
            MensajeTorneo "Torneo 1vs1> " & UserList(UserIndex).Name & " ha ingresado al torneo"
        End If
        
    End With
End Sub

Public Function CuposValidos(ByVal Cupos As Byte) As Boolean
    If (Cupos = 2 Or Cupos = 4 Or Cupos = 8 Or Cupos = 16 Or Cupos = 32 Or Cupos = 64 Or Cupos = 128) Then
        CuposValidos = True
    Else
        CuposValidos = False
    End If
End Function

Public Sub LimpiarDatos()
    With Torneo1
        .Activo = False
        .Cupos = 0
        .ActualCupos = 0
        .CuentaRegresiva = 0
        .MaxRojas = 0
        Dim x As Long
        For x = 1 To NUMCLASES
            .ClaseProhibida(x) = False
        Next x
    End With
End Sub


Public Sub MensajeTorneo(ByVal Texto As String, Optional ByVal ft As FontTypeNames = FontTypeNames.FONTTYPE_GUILD)
    Dim data As String
    data = PrepareMessageConsoleMsg(Texto, ft)
    Call modSendData.SendData(SendTarget.ToAll, 0, data)
End Sub



















