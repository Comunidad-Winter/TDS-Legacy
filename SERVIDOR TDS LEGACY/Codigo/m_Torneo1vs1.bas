Attribute VB_Name = "m_Torneo1vs1"
Option Explicit

Private Type tMapPos
    MapaTorneo As Integer
    Esquina1x As Byte
    Esquina2x As Byte
    Esquina1y As Byte
    Esquina2y As Byte
    x1 As Byte
    y1 As Byte
    x2 As Byte
    y2 As Byte
    EsperaX As Byte
    EsperaY As Byte
End Type

Private Type tTorneo1vs1
    AutoCancelTime As Byte
    Cupos As Byte
    Rondas As Integer
    Activo As Boolean
    CountDown As Integer
    Ingresaron As Boolean
    Premio As Long

    CaenItems As Byte
    Peleando(1 To 2) As String
    PeleandoUI(1 To 2) As Integer

    Torneo_Luchadores() As Integer

    ArrayNombres() As String
    ClasesValidas(1 To NUMCLASES) As eClass
    Puntos As Byte
    PuntosFijos As Byte

    OroFijo As Long
    Oro As Long

    Inscripcion As Long
    InscripcionFija As Long

    MinLevel As Byte
    Maxlevel As Byte

End Type

Private EventoMapPos As tMapPos
Public iTorneo1vs1 As tTorneo1vs1

Public Sub Torneo1vs1_CargarPos()

    On Error GoTo Errhandler

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(App.path & "\Dat\Torneo_1vs1.dat")

1   With EventoMapPos
2       .MapaTorneo = CInt(Leer.GetValue("INIT", "Mapa"))
3       .Esquina2x = CInt(Leer.GetValue("INIT", "Esquina2x"))
4       .Esquina2y = CInt(Leer.GetValue("INIT", "Esquina2y"))
5       .Esquina1x = CInt(Leer.GetValue("INIT", "Esquina1x"))
6       .Esquina1y = CInt(Leer.GetValue("INIT", "Esquina1y"))
98      .x1 = CInt(Leer.GetValue("INIT", "X1"))
9       .x2 = CInt(Leer.GetValue("INIT", "X2"))
10      .y1 = CInt(Leer.GetValue("INIT", "Y1"))
11      .y2 = CInt(Leer.GetValue("INIT", "Y2"))
        .EsperaX = CInt(Leer.GetValue("INIT", "EsperaX"))
        .EsperaY = CInt(Leer.GetValue("INIT", "EsperaY"))
    End With

16  iTorneo1vs1.PuntosFijos = CLng(val(Leer.GetValue("INIT", "PuntosDeCanje")))

18  iTorneo1vs1.OroFijo = CLng(val(Leer.GetValue("INIT", "OroFijo")))

53  iTorneo1vs1.InscripcionFija = CLng(val(Leer.GetValue("INIT", "InscripcionFija")))

19  Set Leer = Nothing
    Exit Sub
Errhandler:
    Call LogError("Error en Torneo1vs1_CargarPos en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub RestaurarPersonaje(ByVal UI As Integer)

    With UserList(UI)

        If .flags.Navegando = 1 Then
            Call WriteNavigateToggle(UI)
            .flags.Navegando = 0
        End If

        .Char.body = .OrigChar.body
        .Char.Head = .OrigChar.Head
        .Char.CascoAnim = .OrigChar.CascoAnim
        .Char.ShieldAnim = .OrigChar.ShieldAnim
        .Char.WeaponAnim = .OrigChar.WeaponAnim

    End With

End Sub

Sub Rondas_Cancela()

    On Error GoTo Rondas_Cancela_Error

    With iTorneo1vs1

        TOURNAMENT_ACTIVE = 0

        If (Not .Activo And Not .Ingresaron) Then Exit Sub
        .Activo = False
        .Ingresaron = False

        Dim i As Long, N As Integer, NuevaPos As WorldPos

        For i = LBound(.Torneo_Luchadores) To UBound(.Torneo_Luchadores)
            N = .Torneo_Luchadores(i)
            If (N > 0) Then
                Call ClosestLegalPos(UserList(N).flags.lastPos, NuevaPos)
                Call WarpUserCharX(N, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
                UserList(N).flags.EnEvento = 0
                If .Inscripcion <> 0 Then
                    UserList(N).Stats.GLD = UserList(N).Stats.GLD + .Inscripcion
                    Call WriteUpdateGold(N)
                    Call WriteConsoleMsg(N, NOMBRE_TORNEO_ACTUAL & "Se te ha devuelto el costo de la inscripción.", FontTypeNames.FONTTYPE_EVENTOS)
                End If
            End If
        Next i
    End With
    Exit Sub

Rondas_Cancela_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure Rondas_Cancela of Módulo m_Torneo1vs1" & Erl & ".")

End Sub

Sub Rondas_UsuarioMuere(ByVal UserIndex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False, Optional AvisoConsola As Boolean = True, Optional DESCONEXION As Boolean = False)

    On Error GoTo Rondas_UsuarioMuere_Error

    With iTorneo1vs1

        Dim i As Long
        Dim Pos As Integer
        Dim combate As Integer
        Dim LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer

        Dim NuevaPos As WorldPos, FuturePos As WorldPos

        If (Not iTorneo1vs1.Activo) Then
            Exit Sub
        ElseIf (.Activo And .Ingresaron) Then

            For i = LBound(.Torneo_Luchadores) To UBound(.Torneo_Luchadores)

                If (.Torneo_Luchadores(i) = UserIndex) Then
                    .Torneo_Luchadores(i) = -1
                    .ArrayNombres(i) = vbNullString
                    Call ClosestLegalPos(Ullathorpe, NuevaPos)
                    Call WarpUserCharX(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
                    UserList(UserIndex).flags.EnEvento = 0
                    Exit Sub
                End If
            Next i
            Exit Sub
        End If

        For Pos = LBound(.Torneo_Luchadores) To UBound(.Torneo_Luchadores)
            If (.Torneo_Luchadores(Pos) = UserIndex) Then Exit For
        Next Pos

        If (.Torneo_Luchadores(Pos) <> UserIndex) Then Exit Sub

        If DESCONEXION Or UserList(UserIndex).Pos.map <> EventoMapPos.MapaTorneo And UserList(UserIndex).Pos.X >= EventoMapPos.x1 And UserList(UserIndex).Pos.X <= EventoMapPos.x2 And UserList(UserIndex).Pos.Y >= EventoMapPos.y1 And UserList(UserIndex).Pos.Y <= EventoMapPos.y2 Then

            If (AvisoConsola) Then
                Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UserIndex).Name & " se desconectó del torneo!", FontTypeNames.FONTTYPE_EVENTOS))
            End If
            UserList(UserIndex).flags.EnEvento = 0
            .Torneo_Luchadores(Pos) = -1
            If Not (.PeleandoUI(1) = UserIndex Or .PeleandoUI(2) = UserIndex) Then
                Exit Sub
            End If
        End If
        combate = 1 + (Pos - 1) \ 2
        LI1 = 2 * (combate - 1) + 1
        LI2 = LI1 + 1

        If (AvisoConsola) Then
            If (Real) Then
                Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UserIndex).Name & " pierde el combate!", FontTypeNames.FONTTYPE_EVENTOS))
            Else
                Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UserIndex).Name & " se fue del combate!", FontTypeNames.FONTTYPE_EVENTOS))
            End If
        End If
        Dim LoopC As Long
        For LoopC = 1 To UBound(.ArrayNombres())
            If .ArrayNombres(LoopC) = UCase$(UserList(UserIndex).Name) Then
                .ArrayNombres(LoopC) = .ArrayNombres(LoopC) & "#"
                Exit For
            End If
        Next LoopC


        If UserList(UserIndex).flags.Muerto <> 0 Then Call RevivirUsuario(UserIndex)
        UserList(UserIndex).Stats.MinHP = UserList(UserIndex).Stats.MaxHP
        UserList(UserIndex).Stats.MinMAN = UserList(UserIndex).Stats.MaxMAN
        UserList(UserIndex).Stats.minSta = UserList(UserIndex).Stats.MaxSta
        UserList(UserIndex).Stats.MinAGU = UserList(UserIndex).Stats.MaxAGU
        UserList(UserIndex).Stats.MinHam = UserList(UserIndex).Stats.MaxHam

        Call WriteUpdateUserStats(UserIndex)
        If (Real) Then
            UserList(UserIndex).flags.EnEvento = 0
            If .CaenItems Then
                Call ClosestLegalPos(TORNEO_Drop, NuevaPos)
                Call WarpUserCharX(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
                Call TirarTodosLosItems(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y)
            End If

            Call ClosestLegalPos(Ullathorpe, NuevaPos)
            Call WarpUserCharX(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)

        ElseIf (Not CambioMapa) Then

            UserList(UserIndex).flags.EnEvento = 0

            If .CaenItems Then
                Call ClosestLegalPos(TORNEO_Drop, NuevaPos)
                Call WarpUserCharX(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
                Call TirarTodosLosItems(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y)
            End If
            Call ClosestLegalPos(Ullathorpe, NuevaPos)
            Call WarpUserCharX(UserIndex, NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)


        End If

        If (.Torneo_Luchadores(LI1) = UserIndex) Then
            .Torneo_Luchadores(LI1) = .Torneo_Luchadores(LI2)      'cambiamos slot
            .Torneo_Luchadores(LI2) = -1
        Else
            .Torneo_Luchadores(LI2) = -1
        End If


        If (.Rondas = 1) Then    'si es la ultima ronda

            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Ganador del torneo: " & UserList(.Torneo_Luchadores(LI1)).Name, FontTypeNames.FONTTYPE_EVENTOS))
            Call DarPremio(.Torneo_Luchadores(LI1))
            If .CaenItems Then
                Call ClosestLegalPos(TORNEO_Drop, NuevaPos)
                Call WarpUserCharX(.Torneo_Luchadores(LI1), NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
                UserList(.Torneo_Luchadores(LI1)).Counters.lastPos = 120
                WriteConsoleMsg .Torneo_Luchadores(LI1), "Tienes 2 minutos para recoger los items y luego volverás a la posición donde estabas.", FontTypeNames.FONTTYPE_SERVER
            Else
                Call ClosestLegalPos(UserList(.Torneo_Luchadores(LI1)).flags.lastPos, NuevaPos)
                Call WarpUserCharX(.Torneo_Luchadores(LI1), NuevaPos.map, NuevaPos.X, NuevaPos.Y, True)
            End If
            Call LogDesarrollo(UserList(.Torneo_Luchadores(LI1)).Name & " ganó de torneo 1vs1 de " & .Cupos & " cupos")
            UserList(.Torneo_Luchadores(LI1)).flags.EnEvento = 0

            .Activo = False
            TOURNAMENT_ACTIVE = 0
            NOMBRE_TORNEO_ACTUAL = ""
            Erase .Torneo_Luchadores()
            Exit Sub
        Else
            Call WarpUserCharX(.Torneo_Luchadores(LI1), EventoMapPos.MapaTorneo, EventoMapPos.EsperaX, EventoMapPos.EsperaY, True)
        End If

        If (2 ^ .Rondas = 2 * combate) Then
            Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Siguiente ronda", FontTypeNames.FONTTYPE_EVENTOS))
            .Rondas = .Rondas - 1
            For i = 1 To 2 ^ .Rondas
                UI1 = .Torneo_Luchadores(2 * (i - 1) + 1)
                UI2 = .Torneo_Luchadores(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                .Torneo_Luchadores(i) = UI1
            Next i
            ReDim Preserve .Torneo_Luchadores(1 To 2 ^ .Rondas) As Integer
            Call Rondas_Combate(1)
            Exit Sub
        End If

        Call Rondas_Combate(combate + 1)

    End With
    Exit Sub

Rondas_UsuarioMuere_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure Rondas_UsuarioMuere, line " & Erl & ".")

End Sub

Sub Rondas_UsuarioDesconecta(ByVal UserIndex As Integer)

    On Error GoTo Rondas_UsuarioDesconecta_Error

    If UserIndex = 0 Then Exit Sub

    Call WarpUserCharX(UserIndex, Ullathorpe.map, Ullathorpe.X, Ullathorpe.Y, True)
    Call Rondas_UsuarioMuere(UserIndex, True, True, True, True)

    Exit Sub

Rondas_UsuarioDesconecta_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure Rondas_UsuarioDesconecta, line " & Erl & ".")

End Sub

Sub Rondas_UsuarioCambiamapa(ByVal UserIndex As Integer)

    If UserIndex = 0 Then Exit Sub

    Call Rondas_UsuarioMuere(UserIndex, False, True)

End Sub

Sub Torneos_Inicia(ByVal UserIndex As Integer, ByVal Rondas As Integer, ByVal Inscripcion As Long, ByVal CaenItems As Byte, ByVal Oro As Long, ByVal Puntos As Byte, ByVal MinLevel As Byte, ByVal Maxlevel As Byte, ByVal cMago As Byte, ByVal cClerigo As Byte, ByVal cGuerrero As Byte, ByVal cAsesino As Byte, ByVal cLadron As Byte, ByVal cBardo As Byte, ByVal cDruida As Byte, ByVal cBandido As Byte, ByVal cPaladin As Byte, ByVal cCazador As Byte, ByVal cTrabajador As Byte, ByVal cPirata As Byte)

    If Inscripcion < 0 Then Inscripcion = 0

    With iTorneo1vs1
        TOURNAMENT_ACTIVE = 1
        Dim i As Long

        If (.Activo) Then Call WriteConsoleMsg(UserIndex, "Ya hay un torneo en curso", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub

        .Cupos = val(2 ^ Rondas)

        .Rondas = Rondas
        .Activo = True
        .Ingresaron = True

        .Inscripcion = Inscripcion
        .Puntos = Puntos
        .Oro = Oro
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel

        .CaenItems = CaenItems

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
        .MinLevel = MinLevel
        .Maxlevel = Maxlevel

        ReDim .Torneo_Luchadores(1 To 2 ^ Rondas) As Integer

        For i = LBound(.Torneo_Luchadores) To UBound(.Torneo_Luchadores)
            .Torneo_Luchadores(i) = -1
        Next i

        ReDim .ArrayNombres(1 To 2 ^ Rondas) As String

        For i = LBound(.ArrayNombres) To UBound(.ArrayNombres)
            .ArrayNombres(i) = vbNullString
        Next i

        NOMBRE_TORNEO_ACTUAL = "Torneos 1vs1> "

        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & val(2 ^ Rondas) & " Cupos, Inscripción" & IIf(.Inscripcion > 0, " de: " & .Inscripcion & " Monedas de oro, ", " Gratis, ") & "Nivel mínimo: " & .MinLevel & ", Nivel máximo: " & .Maxlevel & vbNewLine & "PREMIOS: " & vbNewLine & IIf(.Puntos > 0, " " & .Puntos & " puntos de Canje" & vbNewLine, "") & IIf(.Oro > 0, " " & .Oro & " monedas de oro" & vbNewLine, "") & "Manden /PARTICIPAR si desean participar.", FontTypeNames.FONTTYPE_EVENTOS))

        If T Then SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Clases prohibidas: " & IIf(cMago > 0, " MAGO ", "") & IIf(cClerigo > 0, " CLERIGO ", "") & IIf(cBardo > 0, " BARDO ", "") & IIf(cPaladin > 0, " PALADIN ", "") & IIf(cAsesino > 0, " ASESINO ", "") & IIf(cCazador > 0, " CAZADOR ", "") & IIf(cGuerrero > 0, " GUERRERO ", "") & IIf(cDruida > 0, " DRUIDA ", "") & IIf(cLadron > 0, " LADRON ", "") & IIf(cBandido > 0, " BANDIDO ", "") & IIf(cTrabajador > 0, " TRABAJADOR ", "") & IIf(cPirata > 0, " PIRATA ", ""), FontTypeNames.FONTTYPE_INFOBOLD)

        If CaenItems Then SendData SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "ATENCION!! CAEN ITEMS", FontTypeNames.FONTTYPE_FIGHT)

    End With

End Sub

Sub Torneos_Inicia2(ByVal Rondas As Integer)
    With iTorneo1vs1
        Dim i As Long
        .Cupos = val(2 ^ Rondas)
        .Rondas = Rondas
        .Activo = True
        .Ingresaron = True
        .Inscripcion = .InscripcionFija
        .Puntos = .PuntosFijos
        .Oro = .OroFijo
        ReDim .Torneo_Luchadores(1 To 2 ^ Rondas) As Integer
        For i = LBound(.Torneo_Luchadores) To UBound(.Torneo_Luchadores)
            .Torneo_Luchadores(i) = -1
        Next i
        ReDim .ArrayNombres(1 To 2 ^ Rondas) As String
        For i = LBound(.ArrayNombres) To UBound(.ArrayNombres)
            .ArrayNombres(i) = vbNullString
        Next i
        NOMBRE_TORNEO_ACTUAL = "TorneosAuto 1vs1> "
        Call AvisarConsola
        .AutoCancelTime = 254
    End With
End Sub

Sub Ingresar1vs1(ByVal UserIndex As Integer)

    Dim i As Long

    On Error GoTo Torneos_Entra_Error

    If (Not iTorneo1vs1.Activo) Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "El evento no está en curso.", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub
    If (Not iTorneo1vs1.Ingresaron) Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Cupos llenos.", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub

    With UserList(UserIndex)

        For i = 1 To NUMCLASES
            If iTorneo1vs1.ClasesValidas(i) = 1 And .Clase = i Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Tu clase no esta permitida en este evento.", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub
        Next i

        If .Stats.GLD < iTorneo1vs1.Inscripcion Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "No tienes el oro suficiente.", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub

        If .Stats.ELV < iTorneo1vs1.MinLevel Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Torneo solo para gente nivel mayor a " & iTorneo1vs1.MinLevel & ".", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub
        If .Stats.ELV > iTorneo1vs1.Maxlevel Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Torneo solo para gente nivel menor a " & iTorneo1vs1.Maxlevel & ".", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub

        If MapInfo(.Pos.map).Zona <> Ciudad Or MapInfo(.Pos.map).pk Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Debes estar en una ciudad", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub

        If .flags.Muerto <> 0 Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Debes estar vivo para ingresar al evento.", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub
        If .flags.Comerciando <> 0 Then Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "¡Estas comerciando!", FontTypeNames.FONTTYPE_EVENTOS): Exit Sub
        If .flags.EnEvento = 1 Then Exit Sub

    End With

    For i = LBound(iTorneo1vs1.Torneo_Luchadores) To UBound(iTorneo1vs1.Torneo_Luchadores)
        If iTorneo1vs1.Torneo_Luchadores(i) > 0 Then
            If (iTorneo1vs1.Torneo_Luchadores(i) = UserIndex) Then
                Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Ya estás dentro del torneo", FontTypeNames.FONTTYPE_EVENTOS)
                Exit Sub
            End If
        End If
    Next i

    Dim N As Integer, NuevaPos As WorldPos, FuturePos As WorldPos

    FuturePos.map = EventoMapPos.MapaTorneo
    FuturePos.X = EventoMapPos.EsperaX
    FuturePos.Y = EventoMapPos.EsperaY

    For i = LBound(iTorneo1vs1.Torneo_Luchadores) To UBound(iTorneo1vs1.Torneo_Luchadores)

        If (iTorneo1vs1.Torneo_Luchadores(i) = -1) Then

            iTorneo1vs1.Torneo_Luchadores(i) = UserIndex
            iTorneo1vs1.ArrayNombres(i) = UCase$(UserList(UserIndex).Name)

            Call ClosestLegalPos(FuturePos, NuevaPos)

            UserList(iTorneo1vs1.Torneo_Luchadores(i)).flags.lastPos = UserList(iTorneo1vs1.Torneo_Luchadores(i)).Pos

            Call WarpUserCharX(iTorneo1vs1.Torneo_Luchadores(i), NuevaPos.map, NuevaPos.X, NuevaPos.Y, False)

            UserList(iTorneo1vs1.Torneo_Luchadores(i)).flags.EnEvento = 1

            Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Ingresaste al Torneo!", FontTypeNames.FONTTYPE_EVENTOS)


            If iTorneo1vs1.Inscripcion <> 0 Then
                UserList(iTorneo1vs1.Torneo_Luchadores(i)).Stats.GLD = UserList(iTorneo1vs1.Torneo_Luchadores(i)).Stats.GLD - iTorneo1vs1.Inscripcion
                Call WriteUpdateGold(iTorneo1vs1.Torneo_Luchadores(i))
            End If

            Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El personaje " & UserList(UserIndex).Name & " ingresó al Torneo.", FontTypeNames.FONTTYPE_INFO))

            If (i = UBound(iTorneo1vs1.Torneo_Luchadores)) Then

                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Comienza el torneo", FontTypeNames.FONTTYPE_EVENTOS))

                iTorneo1vs1.Ingresaron = False

                Call Rondas_Combate(1)
                iTorneo1vs1.AutoCancelTime = 0

            End If

            Exit Sub

        End If

    Next i

    Exit Sub

Torneos_Entra_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure Torneos_Entra of Módulo m_Torneo1vs1" & Erl & ".")

End Sub

Sub Rondas_Combate(combate As Integer)

    On Error GoTo Rondas_Combate_Error

    With iTorneo1vs1

        Dim UI1 As Integer, UI2 As Integer, N As WorldPos

        UI1 = .Torneo_Luchadores(2 * (combate - 1) + 1)
        UI2 = .Torneo_Luchadores(2 * combate)

        If (UI2 = -1) Then
            UI2 = .Torneo_Luchadores(2 * (combate - 1) + 1)
            UI1 = .Torneo_Luchadores(2 * combate)
        End If

        If (UI1 = -1) Then

            Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Combate anulado por la desconexión de uno de los dos participantes.", FontTypeNames.FONTTYPE_EVENTOS))

            If (.Rondas = 1) Then

                If (UI2 > 0) Then

                    Call ClosestLegalPos(Ullathorpe, N)
                    Call WarpUserCharX(UI2, N.map, N.X, N.Y, True)

                    Call DarPremio(.Torneo_Luchadores(UI2))

                    UserList(UI2).flags.EnEvento = 0

                    .Activo = False

                    Erase .Torneo_Luchadores()

                    Exit Sub

                End If

                Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "No hay ganador del evento por la desconexión de todos sus participantes.", FontTypeNames.FONTTYPE_EVENTOS))

                Exit Sub

            End If

            If (UI2 <> -1) Then Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "El usuario " & UserList(UI2).Name & " pasó a la siguiente ronda.", FontTypeNames.FONTTYPE_EVENTOS))

            If (2 ^ .Rondas = 2 * combate) Then

                Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & "Siguiente ronda.", FontTypeNames.FONTTYPE_EVENTOS))

                .Rondas = .Rondas - 1

                Dim i As Long

                For i = 1 To 2 ^ .Rondas
                    UI1 = .Torneo_Luchadores(2 * (i - 1) + 1)
                    UI2 = .Torneo_Luchadores(2 * i)
                    If (UI1 = -1) Then UI1 = UI2
                    .Torneo_Luchadores(i) = UI1
                Next i

                ReDim Preserve .Torneo_Luchadores(1 To 2 ^ .Rondas) As Integer
                Call Rondas_Combate(1)
                Exit Sub
            End If
            Call Rondas_Combate(combate + 1)
            Exit Sub
        End If

        Call SendData(SendTarget.toMap, EventoMapPos.MapaTorneo, PrepareMessageConsoleMsg(NOMBRE_TORNEO_ACTUAL & UserList(UI1).Name & " vs. " & UserList(UI2).Name & ".", FontTypeNames.FONTTYPE_EVENTOS))

        iTorneo1vs1.CountDown = 5

        WritePauseToggle UI1
        WritePauseToggle UI2

        Call FullStats(UI1)
        Call FullStats(UI2)
        
        .Peleando(1) = UserList(UI1).Name
        .Peleando(2) = UserList(UI2).Name
        .PeleandoUI(1) = UI1
        .PeleandoUI(2) = UI2

        Call WarpUserCharX(UI1, EventoMapPos.MapaTorneo, EventoMapPos.Esquina1x, EventoMapPos.Esquina1y, True)
        Call WarpUserCharX(UI2, EventoMapPos.MapaTorneo, EventoMapPos.Esquina2x, EventoMapPos.Esquina2y, True)

    End With

    Exit Sub

Rondas_Combate_Error:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure Rondas_Combate, line " & Erl & ".")

End Sub

Private Function FullStats(ByVal UI As Integer)

        With UserList(UI)
            .Stats.MinHP = .Stats.MaxHP
            .Stats.MinMAN = .Stats.MaxMAN
            .Stats.minSta = .Stats.MaxSta
            .Stats.MinAGU = 100
            .Stats.MinHam = 100
            Call WriteUpdateUserStats(UI)
        End With
End Function
Function AvisarConsola()

    On Error GoTo Errhandler
    Dim msg As String

    If iTorneo1vs1.Activo = False Then
        LogError "Torneo1vs1 off?"
        Exit Function
    End If

    If iTorneo1vs1.Ingresaron = False Then Exit Function

    msg = "[TORNEO 1VS1]:" & vbNewLine
    msg = msg & "Costo de inscripción: " & iTorneo1vs1.Inscripcion & vbNewLine
    msg = msg & "Cupos: " & iTorneo1vs1.Cupos & vbNewLine
    msg = msg & "Nivel mínimo: " & iTorneo1vs1.MinLevel & ", Nivel máximo: " & iTorneo1vs1.Maxlevel & vbNewLine

    msg = msg & "PREMIOS: " & IIf(iTorneo1vs1.Puntos, vbNewLine & iTorneo1vs1.Puntos & " puntos de canje.", "") & IIf(iTorneo1vs1.Oro, vbNewLine & iTorneo1vs1.Oro & " monedas de oro.", "") & vbNewLine
    msg = msg & "Inscripciones " & IIf(iTorneo1vs1.Ingresaron = False, "Cerradas.", "Abiertas.") & vbNewLine
    msg = msg & "Para ingresar tipea /PARTICIPAR"

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(msg, FontTypeNames.FONTTYPE_EVENTOS))

    Exit Function

Errhandler:

    Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure AvisarConsola, line " & Erl & ".")

End Function

Public Function Tick_AutoCancel_1vs1()

    On Error GoTo Errhandler

    With iTorneo1vs1

        If .Activo = False Then Exit Function

        If .AutoCancelTime > 0 Then
            .AutoCancelTime = .AutoCancelTime - 1

            If .AutoCancelTime = 0 Then
                Call Rondas_Cancela
            End If

        End If

        If .CountDown > 0 Then
            Dim i As Long
            .CountDown = .CountDown - 1

            If .CountDown = 0 Then
                For i = 1 To UBound(.PeleandoUI)
                    WritePauseToggle .PeleandoUI(i)
                    WriteConsoleMsg .PeleandoUI(i), "Ya!!", FontTypeNames.FONTTYPE_FIGHT
                Next i
            Else
                For i = 1 To UBound(.PeleandoUI())
                    WriteConsoleMsg .PeleandoUI(i), .CountDown, FontTypeNames.FONTTYPE_TALK
                Next i
            End If

        End If

    End With

Errhandler:

End Function

Private Sub DarPremio(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    With UserList(UserIndex)

        Call LogDesarrollo("Ganador torneo1vs1: " & .Name & " - pt:" & iTorneo1vs1.Puntos & " - Oro: " & iTorneo1vs1.Oro)

        .Stats.GLD = .Stats.GLD + iTorneo1vs1.Oro: If .Stats.GLD > MAXORO Then .Stats.GLD = MAXORO
        WriteUpdateGold UserIndex
        WriteConsoleMsg UserIndex, "Has ganado el torneo! Felicitaciones, aquí tienes tu premio.", FontTypeNames.FONTTYPE_EVENTOS

    End With

    Exit Sub
Errhandler:
    LogError "Error en DarPremio en linea " & Erl & ". Err " & Err.Number & " " & Err.Description

End Sub

