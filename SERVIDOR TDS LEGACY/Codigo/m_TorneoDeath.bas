Attribute VB_Name = "m_TorneoDeath"
Option Explicit

Type DeathUser
    UserIndex As Integer
    LastPosition As WorldPos
    Esperando As Byte
End Type

Private TiempodeEspera As Integer

Private Type tDeath
    Cupos As Byte
    Ingresaron As Byte
    UsUaRiOs() As DeathUser
    ClasesValidas(1 To NUMCLASES) As eClass
    Cuenta As Byte
    Activo As Boolean

    AutoCancelTime As Byte
    Ganador As DeathUser
    EventStarted As Boolean

    Puntos As Byte
    Inscripcion As Long
    Oro As Long

    MinLevel As Byte
    Maxlevel As Byte
    CaenItems As Boolean

End Type

Private Const CUENTA_NUM As Byte = 5
Private ARENA_MAP As Integer
Private ARENAWATER_MAP As Integer
Private ARENA_X As Byte
Private ARENA_Y As Byte
Private BANCO_X As Byte
Private BANCO_Y As Byte
Private TIEMPO_PARAVOLVER As Integer

Public DeathMatch As tDeath

Public Sub TorneoDeath_CargarPos()

    On Error GoTo Errhandler

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(App.path & "\Dat\Torneo_Death.dat")

3   ARENA_MAP = CInt(Leer.GetValue("INIT", "Mapa"))
   ARENAWATER_MAP = CInt(Leer.GetValue("INIT", "MapaAcuatico"))
4   ARENA_X = CInt(Leer.GetValue("INIT", "ARENA_X"))
5   ARENA_Y = CInt(Leer.GetValue("INIT", "ARENA_Y"))
6   BANCO_X = CInt(Leer.GetValue("INIT", "BANCO_X"))
7   BANCO_Y = CInt(Leer.GetValue("INIT", "BANCO_Y"))
8   TIEMPO_PARAVOLVER = CInt(Leer.GetValue("INIT", "Tiempo_ParaVolver"))

    'Oro = CInt(Leer.GetValue("INIT", "Tiempo_ParaVolver"))
    'Puntos = CInt(Leer.GetValue("INIT", "PuntosDeCanje"))
    'Inscripcion = CInt(Leer.GetValue("INIT", "Tiempo_ParaVolver"))

19  Set Leer = Nothing
    Exit Sub

Errhandler:
    Call LogError("Error en TorneoDeath_CargarPos en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Sub DesconectaUser(ByVal UserIndex As Integer, Optional ByVal Avisa As Boolean = True)

    On Error GoTo Errhandler

    Dim i As Long
    For i = 1 To UBound(DeathMatch.UsUaRiOs())
        If DeathMatch.UsUaRiOs(i).UserIndex = UserIndex Then
            DeathMatch.UsUaRiOs(i).UserIndex = -1
            Exit For
        End If
    Next i
    Call MuereUser(UserIndex, False)

    If (Avisa) Then
        Call SendData(SendTarget.toMap, ARENA_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UserIndex).Name & " abandonó el deathmatch.", FontTypeNames.FONTTYPE_EVENTOS))
    End If

    Exit Sub
Errhandler:
    LogError "Error Death -Desconect: " & Err.Number & "  " & Err.Description & " __ Linea: " & Erl

End Sub

Sub Limpiar()

    Dim DumpPos As WorldPos
    Dim LoopX As Long
    Dim LoopY As Long
    Dim esSalida As Boolean
    NOMBRE_TORNEO_ACTUAL = ""
    TOURNAMENT_ACTIVE = 0
    With DeathMatch
        .Cuenta = 0
        .Cupos = 0
        .Ingresaron = 0
        .Activo = False
        .EventStarted = False

        With .Ganador
            .UserIndex = 0
            .LastPosition = DumpPos
            .Esperando = 0
        End With

        For LoopX = 1 To 100
            For LoopY = 1 To 100
                With MapData(ARENA_MAP, LoopX, LoopY)
                    If .ObjInfo.ObjIndex <> 0 Then
                        esSalida = (.TileExit.Map <> 0)
                        If Not ItemNoEsDeMapa(.ObjInfo.ObjIndex, esSalida) Then
                            Call EraseObj(.ObjInfo.Amount, ARENA_MAP, LoopX, LoopY)
                        End If
                    End If
                End With
            Next LoopY
        Next LoopX

        For LoopX = 1 To 100
            For LoopY = 1 To 100
                With MapData(TORNEO_Drop.Map, LoopX, LoopY)
                    If .ObjInfo.ObjIndex <> 0 Then
                        esSalida = (.TileExit.Map <> 0)
                        If Not ItemNoEsDeMapa(.ObjInfo.ObjIndex, esSalida) Then
                            Call EraseObj(.ObjInfo.Amount, ARENA_MAP, LoopX, LoopY)
                        End If
                    End If
                End With
            Next LoopY
        Next LoopX

    End With

End Sub

Sub Cancelar()
    Dim LoopX As Long
    Dim uIndex As Integer
    Dim UPos As WorldPos
    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        uIndex = DeathMatch.UsUaRiOs(LoopX).UserIndex
        If uIndex <> -1 Then
            If UserList(uIndex).ConnIDValida Then
                If UserList(uIndex).flags.EnEvento = 3 Then
                    UserList(uIndex).flags.EnEvento = 0
                    Call AnteriorPos(uIndex, UPos)
                    WarpUserCharX uIndex, UserList(uIndex).flags.lastPos.Map, UserList(uIndex).flags.lastPos.X, UserList(uIndex).flags.lastPos.Y, True
                End If
            End If
        End If
    Next LoopX
    Call Limpiar
    TOURNAMENT_ACTIVE = 0
End Sub

Sub ActivarNuevo(ByRef OrganizatedBy As String, ByVal Puntos As Byte, ByVal Inscripcion As Long, ByVal Oro As Long, ByVal Cupos As Byte, ByVal MinLevel As Byte, ByVal Maxlevel As Byte, ByVal cMago As Byte, ByVal cClerigo As Byte, ByVal cGuerrero As Byte, ByVal cAsesino As Byte, ByVal cLadron As Byte, ByVal cBardo As Byte, ByVal cDruida As Byte, ByVal cBandido As Byte, ByVal cPaladin As Byte, ByVal cCazador As Byte, ByVal cTrabajador As Byte, ByVal cPirata As Byte, ByVal CaenItems As Boolean)

    On Error GoTo Errhandler

    Dim LoopX As Long

    Call Limpiar

    With DeathMatch
        NOMBRE_TORNEO_ACTUAL = "Torneo Deathmatch> "
        TOURNAMENT_ACTIVE = 3

        If Cupos < 2 Then Cupos = 2
        If Cupos > 32 Then Cupos = 32

        .Cupos = Cupos
        .Activo = True
        .Maxlevel = Maxlevel
        .MinLevel = MinLevel
        .EventStarted = False

        .Puntos = Puntos
        .CaenItems = CaenItems
        .Inscripcion = Inscripcion
        .Oro = Oro

        If .Cupos = 1 Then .Cupos = 2
        If .Cupos > 64 Then .Cupos = 64

        Dim T As Boolean
        .ClasesValidas(eClass.Mage) = cMago: If T = False Then T = (cMago > 0)
        .ClasesValidas(eClass.Cleric) = cClerigo: If T = False Then T = (cClerigo > 0)
        .ClasesValidas(eClass.Bard) = cBardo: If T = False Then T = (cBardo > 0)
        .ClasesValidas(eClass.Paladin) = cPaladin: If T = False Then T = (cPaladin > 0)
        .ClasesValidas(eClass.Assasin) = cAsesino: If T = False Then T = (cAsesino > 0)
        .ClasesValidas(eClass.Hunter) = cCazador: If T = False Then T = (cCazador > 0)
        .ClasesValidas(eClass.Warrior) = cGuerrero: If T = False Then T = (cGuerrero > 0)
        .ClasesValidas(eClass.Druid) = cDruida: If T = False Then T = (cDruida > 0)
        .ClasesValidas(eClass.Thief) = cLadron: If T = False Then T = (cLadron > 0)
        .ClasesValidas(eClass.Blacksmith) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Carpenter) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Fisherman) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Miner) = cTrabajador: If T = False Then T = (cTrabajador > 0)
        .ClasesValidas(eClass.Woodcutter) = cTrabajador: If T = False Then T = (cBandido > 0)
        .ClasesValidas(eClass.Pirat) = cPirata: If T = False Then T = (cPirata > 0)

        ReDim .UsUaRiOs(1 To Cupos) As DeathUser

        For LoopX = 1 To Cupos
            .UsUaRiOs(LoopX).UserIndex = -1
        Next LoopX

        Call AvisarConsola

        If T Then SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Clases prohibidas: " & IIf(cMago > 0, " MAGO ", "") & IIf(cClerigo > 0, " CLERIGO ", "") & IIf(cBardo > 0, " BARDO ", "") & IIf(cPaladin > 0, " PALADIN ", "") & IIf(cAsesino > 0, " ASESINO ", "") & IIf(cCazador > 0, " CAZADOR ", "") & IIf(cGuerrero > 0, " GUERRERO ", "") & IIf(cDruida > 0, " DRUIDA ", "") & IIf(cLadron > 0, " LADRON ", "") & IIf(cBandido > 0, " BANDIDO ", "") & IIf(cTrabajador > 0, " TRABAJADOR ", "") & IIf(cPirata > 0, " PIRATA ", ""), FontTypeNames.FONTTYPE_INFOBOLD)

        .AutoCancelTime = 122

    End With

    Exit Sub
Errhandler:
    LogError "ActivarNuevo error. " & Err.Number & " " & Err.Description

End Sub

Sub Ingresar(ByVal UserIndex As Integer)

    Dim LibreSlot As Byte
    Dim SumarCount As Boolean

    LibreSlot = ProximoSlot(SumarCount)

    If Not LibreSlot <> 0 Then Exit Sub

    With DeathMatch

        If SumarCount Then .Ingresaron = .Ingresaron + 1

        .UsUaRiOs(LibreSlot).LastPosition = UserList(UserIndex).Pos
        .UsUaRiOs(LibreSlot).UserIndex = UserIndex
        
        UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD - DeathMatch.Inscripcion
        
        UserList(UserIndex).flags.EnEvento = 3
        UserList(UserIndex).flags.lastPos = UserList(UserIndex).Pos

        Call WarpUserCharX(UserIndex, ARENA_MAP, ARENA_X, ARENA_Y, True)

        Call WriteUpdateGold(UserIndex)

        Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Has ingresado al deathmatch!", FontTypeNames.FONTTYPE_EVENTOS)

        UserList(UserIndex).flags.EnEvento = 3

        If .Ingresaron >= .Cupos Then
            .AutoCancelTime = 0
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El cupo ha sido completado!", FontTypeNames.FONTTYPE_EVENTOS))
            Call Iniciar
        End If

    End With

End Sub

Sub Death_PasaMinuto()

' TiempodeEspera = TiempodeEspera + 1

'If TiempodeEspera = 60 * 4 And LastEvent = eEvents.Torneo1v1 Then

' @@ Cancelamos el evento si es que está activo.
'   If DeathMatch.Activo Then
'       m_TorneoDeath.Cancelar "Servidor"
'   End If

'        Dim Cantidad As Byte
'        Dim i  As Long

'       For i = 1 To LastUser
'           If UserList(i).ConnIDValida Then
'               Cantidad = Cantidad + 1
'           End If
'       Next i

' @@ Iniciamos
'      Call m_TorneoDeath.ActivarNuevo("Servidor", Cantidad, 1, 47, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0)

'     TiempodeEspera = 0

'End If

End Sub


Sub CuentaDeath()

    Dim PacketToSend As String
    Dim CanSendPackage As Boolean

    With DeathMatch
        If .Activo = False Then Exit Sub

        If .Ganador.UserIndex <> 0 Then
            If .Ganador.Esperando <> 0 Then
                .Ganador.Esperando = .Ganador.Esperando - 1
                If Not .Ganador.Esperando <> 0 Then
                    Call WarpUserChar(.Ganador.UserIndex, .Ganador.LastPosition.Map, .Ganador.LastPosition.X, .Ganador.LastPosition.Y, True)
                    Call WriteConsoleMsg(.Ganador.UserIndex, NOMBRE_TORNEO_ACTUAL & "El tiempo ha llegado a su fin, fuiste devuelto a tu posición anterior", FontTypeNames.FONTTYPE_EVENTOS)
                    Call Limpiar
                End If
            End If
        End If

        If .Cuenta <> 0 Then

            .Cuenta = .Cuenta - 1

            If .Cuenta > 1 Then
                Call SendData(SendTarget.toMap, ARENA_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El death iniciará en " & .Cuenta & " segundos.", FontTypeNames.FONTTYPE_EVENTOS))
            ElseIf .Cuenta = 1 Then
                Call SendData(SendTarget.toMap, ARENA_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El death iniciará en 1 segundo!", FontTypeNames.FONTTYPE_EVENTOS))
            ElseIf .Cuenta <= 0 Then
                Call SendData(SendTarget.toMap, ARENA_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El death inició! PELEEN!", FontTypeNames.FONTTYPE_EVENTOS))
                MapInfo(ARENA_MAP).pk = True
                .EventStarted = True
            End If
        End If

        If .AutoCancelTime <> 0 Then

            If .AutoCancelTime <> 0 Then
                .AutoCancelTime = .AutoCancelTime - 1
            End If

            Select Case .AutoCancelTime
            Case 120
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 2 minutos con los cupos actuales"
            Case 90
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 1:30 minutos con los cupos actuales"
            Case 60
                CanSendPackage = True
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 1 minuto con los cupos actuales"
            Case 30
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 30 segundos con los cupos actuales"
            Case 15
                CanSendPackage = True
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 15 segundos con los cupos actuales"
            Case 10
                CanSendPackage = True
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 10 segundos con los cupos actuales"
            Case 5
                CanSendPackage = True
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en 5 segundos con los cupos actuales"
            Case 1, 2, 3
                CanSendPackage = True
                PacketToSend = NOMBRE_TORNEO_ACTUAL & "Iniciará en " & .AutoCancelTime & " segundo/s con los cupos actuales"
            Case 0
                CanSendPackage = False
                If QuedanVivos > 2 Then
                    SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El cupo ha sido completado!", FontTypeNames.FONTTYPE_EVENTOS)
                    .Cupos = QuedanVivos
                    .EventStarted = True
                    .Ingresaron = .Cupos
                    Iniciar
                Else
                    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ha sido cancelado por falta de participantes.", FontTypeNames.FONTTYPE_EVENTOS))
                    Call Cancelar
                    TOURNAMENT_ACTIVE = 0
                End If

            End Select

            If CanSendPackage Then
                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(PacketToSend, FontTypeNames.FONTTYPE_EVENTOS))
                CanSendPackage = False
            End If

        End If

    End With

End Sub

Sub Iniciar()

    Dim LoopX As Long

    With DeathMatch
        .Cuenta = CUENTA_NUM
        For LoopX = 1 To UBound(.UsUaRiOs())
            If .UsUaRiOs(LoopX).UserIndex <> -1 Then
                If UserList(.UsUaRiOs(LoopX).UserIndex).ConnIDValida Then
                    Call WarpUserChar(.UsUaRiOs(LoopX).UserIndex, UserList(.UsUaRiOs(LoopX).UserIndex).Pos.Map, UserList(.UsUaRiOs(LoopX).UserIndex).Pos.X, UserList(.UsUaRiOs(LoopX).UserIndex).Pos.Y, 0, 0)
                    Call WriteConsoleMsg(.UsUaRiOs(LoopX).UserIndex, NOMBRE_TORNEO_ACTUAL & "Llenó el cupo! El deathmatch iniciará en " & .Cuenta & " segundos!.", FontTypeNames.FONTTYPE_EVENTOS)
                Else
                    .UsUaRiOs(LoopX).UserIndex = -1
                End If
            End If
        Next LoopX
        MapInfo(ARENA_MAP).pk = False

    End With

End Sub

Sub MuereUser(ByVal MuertoIndex As Integer, Optional ByVal sMessage As Boolean = True)

    On Error GoTo Errhandler

    Dim MuertoPos As WorldPos
    Dim NuevaPos As WorldPos
    Dim QuedanEnDeath As Byte

    Call AnteriorPos(MuertoIndex, MuertoPos)

    UserList(MuertoIndex).flags.EnEvento = 0

    If DeathMatch.CaenItems Then
        Call ClosestLegalPos(TORNEO_Drop, NuevaPos)
        Call WarpUserChar(MuertoIndex, NuevaPos.Map, NuevaPos.X, NuevaPos.Y, True)
        Call TirarTodosLosItems(MuertoIndex, NuevaPos.Map, NuevaPos.X, NuevaPos.Y)
    End If

    Call WarpUserCharX(MuertoIndex, MuertoPos.Map, MuertoPos.X, MuertoPos.Y, True)

    If sMessage Then
        Call WriteConsoleMsg(MuertoIndex, NOMBRE_TORNEO_ACTUAL & "Has caido en el deathMatch, has sido revivido y llevado a tu posición anterior (Mapa : " & MapInfo(MuertoPos.Map).Name & ")", FontTypeNames.FONTTYPE_EVENTOS)
        Call SendData(SendTarget.toMap, ARENA_MAP, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(MuertoIndex).Name & " Ha sido derrotado.", FontTypeNames.FONTTYPE_EVENTOS))
    End If

    If Not DeathMatch.EventStarted Then Exit Sub

    QuedanEnDeath = QuedanVivos()

    If Not QuedanEnDeath <> 1 Then
        Call Terminar
    End If


    Exit Sub
Errhandler:
    LogError "ActivarNuevo error. " & Err.Number & " " & Err.Description

End Sub

Sub Terminar()

    On Error GoTo Errhandler

    Dim WinnerIndex As Integer
    Dim GoldPremio As Long

    WinnerIndex = GanadorIndex

    If Not WinnerIndex <> -1 Then
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "TRAGEDIA EN DEATHMATCHS!! WINNERINDEX = -1!!!!", FontTypeNames.FONTTYPE_EVENTOS))
        Call Limpiar
        Exit Sub
    End If

    Call LogDesarrollo("Ganador DeathMatch: " & UserList(WinnerIndex).Name & " - pt:" & DeathMatch.Puntos & " - Oro: " & DeathMatch.Oro)
    UserList(WinnerIndex).Stats.GLD = UserList(WinnerIndex).Stats.GLD + DeathMatch.Oro: If UserList(WinnerIndex).Stats.GLD > MAXORO Then UserList(WinnerIndex).Stats.GLD = MAXORO
    Call WriteUpdateGold(WinnerIndex)

    Call WriteConsoleMsg(WinnerIndex, "Has ganado el DeathMatch! Felicitaciones, aquí tienes tu premio.", FontTypeNames.FONTTYPE_EVENTOS)

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganador del DeathMatch: " & UserList(WinnerIndex).Name, FontTypeNames.FONTTYPE_EVENTOS))

    UserList(WinnerIndex).flags.EnEvento = 0

    If DeathMatch.CaenItems Then
        Call WarpUserCharX(WinnerIndex, TORNEO_Drop.Map, TORNEO_Drop.X, TORNEO_Drop.Y, True)
        UserList(WinnerIndex).Counters.lastPos = TIEMPO_PARAVOLVER
        Call WriteConsoleMsg(WinnerIndex, "Tienes " & Int(TIEMPO_PARAVOLVER / 60) & " minutos para recoger los items y luego volverás a la posición donde estabas.", FontTypeNames.FONTTYPE_SERVER)
    Else
        Call WarpUserCharX(WinnerIndex, UserList(WinnerIndex).flags.lastPos.Map, UserList(WinnerIndex).flags.lastPos.X, UserList(WinnerIndex).flags.lastPos.Y, True)
    End If

    Limpiar

    Exit Sub
Errhandler:
    LogError "Error en Terminar de Death." & Err.Number & " - " & Err.Description
    Limpiar

End Sub

Sub AnteriorPos(ByVal UserIndex As Integer, ByRef MuertoPosition As WorldPos)

    Dim LoopX As Long

    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        If DeathMatch.UsUaRiOs(LoopX).UserIndex = UserIndex Then
            MuertoPosition = DeathMatch.UsUaRiOs(LoopX).LastPosition
            Exit Sub
        End If
    Next LoopX

    MuertoPosition = Ullathorpe

End Sub

Function AprobarIngreso(ByVal UserIndex As Integer, ByRef MensajeError As String) As Boolean

    Dim DumpBoolean As Boolean, i As Long

    AprobarIngreso = False

    If Not DeathMatch.Activo Then
        MensajeError = "El evento no está en curso.": Exit Function
    End If

    If Not ProximoSlot(DumpBoolean) <> 0 Then
        MensajeError = "Hay un deathmatch, pero las inscripciones están cerradas": Exit Function
    End If

    If YaInscripto(UserIndex) Then
        MensajeError = "Ya estás en el death!": Exit Function
    End If

    If UserList(UserIndex).flags.EnEvento > 0 Then
        MensajeError = "Ya estás en un evento!": Exit Function
    End If

    If UserList(UserIndex).flags.Muerto <> 0 Then
        MensajeError = NOMBRE_TORNEO_ACTUAL & "Muerto no puedes ingresar a un deathmatch, lo siento..": Exit Function
    End If

    If UserList(UserIndex).Counters.Pena <> 0 Then
        MensajeError = "No puedes ingresar si estás preso.": Exit Function
    End If

    If UserList(UserIndex).Stats.GLD < DeathMatch.Inscripcion Then
        MensajeError = "No tenes el oro suficiente.": Exit Function
    End If

    If MapInfo(UserList(UserIndex).Pos.Map).Zona <> Ciudad Or MapInfo(UserList(UserIndex).Pos.Map).pk Then
        MensajeError = "No puedes ingresar si estás fuera de una ciudad.": Exit Function
    End If

    If DeathMatch.MinLevel > UserList(UserIndex).Stats.ELV Then
        MensajeError = "El mínimo nivel para entrar es de " & DeathMatch.MinLevel: Exit Function
    End If

    If DeathMatch.Maxlevel < UserList(UserIndex).Stats.ELV Then
        MensajeError = "El máximo nivel para entrar es de " & DeathMatch.Maxlevel: Exit Function
    End If

    For i = 1 To NUMCLASES
        If DeathMatch.ClasesValidas(i) = 1 And UserList(UserIndex).Clase = i Then
            MensajeError = "Tu clase no esta permitida en este evento.": Exit Function
        End If
    Next i

    AprobarIngreso = True
    Exit Function
NoHayClases:
    AprobarIngreso = True
End Function

Function ProximoSlot(ByRef Sumar As Boolean) As Byte
    Dim LoopX As Long
    Sumar = False

    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        If Not DeathMatch.UsUaRiOs(LoopX).UserIndex <> -1 Then
            ProximoSlot = LoopX
            If DeathMatch.Ingresaron < ProximoSlot Then Sumar = True
            Exit Function
        End If
    Next LoopX
    ProximoSlot = 0

End Function

Function QuedanVivos() As Byte
    Dim LoopX As Long
    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        If DeathMatch.UsUaRiOs(LoopX).UserIndex <> -1 Then
            If UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).ConnIDValida Then
                If UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).Pos.Map = ARENA_MAP Then
                    QuedanVivos = QuedanVivos + 1
                End If
            End If
        End If
    Next LoopX

End Function

Function GanadorIndex() As Integer

    On Error GoTo Errhandler
    Dim LoopX As Long

    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        If DeathMatch.UsUaRiOs(LoopX).UserIndex <> -1 Then

            If UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).ConnIDValida Then
                If Not UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).Pos.Map <> ARENA_MAP Then

                    If Not UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).flags.Muerto <> 0 Then
                        GanadorIndex = DeathMatch.UsUaRiOs(LoopX).UserIndex
                        Exit Function
                    End If

                End If
            End If

        End If
    Next LoopX

    GanadorIndex = -1
Errhandler:
    Call LogError("Err en GandorIndex Death. " & GanadorIndex & " - " & Err.Number & " " & Err.Description)
    GanadorIndex = -1

End Function

Function YaInscripto(ByVal UserIndex As Integer) As Boolean
    On Error GoTo Errhandler
    Dim LoopX As Long

    For LoopX = 1 To UBound(DeathMatch.UsUaRiOs())
        If DeathMatch.UsUaRiOs(LoopX).UserIndex = UserIndex Then
            YaInscripto = True
            Exit Function
        End If

        If DeathMatch.UsUaRiOs(LoopX).UserIndex > 0 Then
            If UserList(DeathMatch.UsUaRiOs(LoopX).UserIndex).IP = UserList(UserIndex).IP Then
                'YaInscripto = True:Exit Function
            End If
        End If
    Next LoopX

    YaInscripto = False

    Exit Function

Errhandler:
    LogError "Error en YaInscripto en " & Erl & ". Err " & Err.Number & " " & Err.Description
End Function

Function GetBanqueroPos() As WorldPos

    If Not MapData(ARENA_MAP, BANCO_X, BANCO_Y).ObjInfo.ObjIndex <> 0 Then
        If Not MapData(ARENA_MAP, BANCO_X, BANCO_Y).UserIndex <> 0 Then
            GetBanqueroPos.Map = ARENA_MAP
            GetBanqueroPos.X = BANCO_X
            GetBanqueroPos.Y = BANCO_Y
            Exit Function
        End If
    End If

    Dim LoopX As Long
    Dim LoopY As Long
    For LoopX = (BANCO_X - 5) To (BANCO_X + 5)
        For LoopY = (BANCO_Y - 5) To (BANCO_Y + 5)
            With MapData(ARENA_MAP, LoopX, LoopY)
                If Not .ObjInfo.ObjIndex <> 0 Then
                    If Not .UserIndex <> 0 Then
                        GetBanqueroPos.Map = ARENA_MAP
                        GetBanqueroPos.X = LoopX
                        GetBanqueroPos.Y = LoopY
                        Exit Function
                    End If
                End If
            End With
        Next LoopY
    Next LoopX

    GetBanqueroPos.Map = ARENA_MAP
    GetBanqueroPos.X = BANCO_X
    GetBanqueroPos.Y = BANCO_Y

End Function

Function AvisarConsola()

    On Error GoTo Errhandler
    Dim Msg As String

    If DeathMatch.Activo = False Then
        LogError "Deathmatch off?WTF"
        Exit Function
    End If

    If DeathMatch.EventStarted = True Then Exit Function

    Msg = "[TORNEO DEATHMATCH]:" & vbNewLine
    Msg = Msg & "Cupos: " & DeathMatch.Cupos & vbNewLine
    Msg = Msg & "Costo de Inscripción: " & DeathMatch.Inscripcion & vbTab & "Min Level: " & DeathMatch.MinLevel & " - Max Level: " & DeathMatch.Maxlevel & vbNewLine
    Msg = Msg & "PREMIOS: " & IIf(DeathMatch.Puntos, vbNewLine & " " & DeathMatch.Puntos & " puntos de canje.", "") & IIf(DeathMatch.Oro, vbNewLine & " " & DeathMatch.Oro & " monedas de oro.", "") & vbNewLine
    Msg = Msg & IIf(DeathMatch.CaenItems, "Atención!! CAEN ITEMS" & vbNewLine, "")

    Msg = Msg & "Para ingresar tipea /PARTICIPAR"

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(Msg, FontTypeNames.FONTTYPE_EVENTOS))

    Exit Function

Errhandler:
    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure AvisarConsola, line " & Erl & ".")

End Function


