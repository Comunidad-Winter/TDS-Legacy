Attribute VB_Name = "mod_Torneos1vs1"
Option Explicit

Private Type tUserTorneo
    EnTorneo As Boolean
    NumTeam As Byte
    NumUser As Byte ''El index dentro de los usuarios del team
End Type

Private Type tTeam
    User() As Integer
    RoundsGanadas As Byte
    Ocupado As Boolean
End Type

Private Type tTorneo
    Activo As Boolean ''Esta activo el evento?
    Comenzado As Boolean ''Ya comenzaron las peleas?
    CountDown As Integer ''Cuenta regresiva
    Team() As tTeam ''Array de teams
    FaseActual() As Integer ''Se maneja con numero de team, no con userindex
    FaseSiguiente() As Integer ''Se maneja con numero de team, no con userindex
    NumTeams As Byte ''Numero de teams que tiene el torneo(No cambia a medida que avanza)
    UsersPorTeam As Byte ''Usuarios por equipo (2vs2, 1vs1, etc)
End Type

Public Torneo As tTorneo

Public Sub EntrarTorneo(ByVal UserIndex As Integer, ByRef tUser() As Integer)
    With Torneo
        If .UsersPorTeam > 1 Then
            Dim x As Long, lError As String
            Call CheckUsuarios(tUser, lError)
            ''Llegamos aca, esta todo joya.
            ''Dim nSlot As Byte
            ''nSlot = DameTeamSlot
            ''.Team(nSlot).Ocupado = True
            ''.Team(nSlot).RoundsGanadas = 0
            ''.Team(nSlot).User() = tUser()
            For x = 1 To .UsersPorTeam
                Call WriteConsoleMsg(UserIndex, UserList(UserIndex).Name & " quiere ser tu pareja en el torneo. Escribe /SITORNEO " & UserList(UserIndex).Name & " para confirmar la participacion en el mismo.", FontTypeNames.FONTTYPE_GUILD)
            Next x
        Else
            
        End If
    End With
End Sub

Private Sub CheckUsuarios(ByRef tUser() As Integer, ByRef lError As String)
    Dim x As Long
    If UBound(tUser) < 1 Then Exit Sub
    For x = 1 To UBound(tUser)
        If tUser(x) <> 0 Then
            With UserList(tUser(x))
                If .EnEvento = True Then
                    If x = 1 Then
                        lError = "Estás en un evento."
                    Else
                        lError = "Uno de los usuarios de tu team está en un evento."
                    End If
                    Exit Sub
                End If
                If .flags.Muerto <> 0 Then
                    If x = 1 Then
                        lError = "Estás muerto."
                    Else
                        lError = "Uno de los usuarios de tu team está muerto."
                    End If
                    Exit Sub
                End If
                If MapInfo(.Pos.map).Pk = True Then
                    If x = 1 Then
                        lError = "Estás en una zona insegura."
                    Else
                        lError = "Uno de los usuarios de tu team está en una zona inseguro."
                    End If
                    Exit Sub
                End If
            End With
        End If
    Next x
End Sub

Private Sub MensajeTeam(ByVal mensaje As String, ByVal slot As Byte)
    If Torneo.Activo = False Then Exit Sub
    With Torneo.Team(slot)
        If .Ocupado = False Then Exit Sub
        Dim x As Long
        For x = 1 To Torneo.UsersPorTeam
            If .User(x) <> 0 Then
                WriteConsoleMsg .User(x), mensaje, FontTypeNames.FONTTYPE_GUILD
            End If
        Next x
    End With
End Sub

Private Function DameTeamSlot() As Byte
    Dim x As Long
    With Torneo
        For x = 1 To .NumTeams
            If .Team(x).Ocupado = False Then
                DameTeamSlot = x
                Exit Function
            End If
        Next x
    End With
End Function

Public Sub CrearTorneo(ByVal Teams As Byte, ByVal UsersPorTeam As Byte)
    With Torneo
        If .Activo = True Then Exit Sub
        .Activo = True
        .Comenzado = False
        .CountDown = 10
        ReDim .Team(1 To Teams) As tTeam
        Dim x As Long
        For x = 1 To Teams
            ReDim .Team(x).User(1 To UsersPorTeam)
        Next x
        .NumTeams = Teams
        .UsersPorTeam = UsersPorTeam
        Dim sdata As String
        sdata = PrepareMessageConsoleMsg("Torneo " & .UsersPorTeam & "vs" & .UsersPorTeam & "> Torneo con cupo para " & Teams & IIf(UsersPorTeam = 1, " usuarios", " equipos") & ". Escribe /TORNEO para ingresar" & IIf(UsersPorTeam = 1, ".", ". Tus compañeros de equipo deben estar en la misma party que vos."), FontTypeNames.FONTTYPE_GUILD)
        Call SendData(SendTarget.ToAll, 0, sdata)
    End With
End Sub

Public Sub CancelarTorneo()
    With Torneo
        If .Activo = False Then Exit Sub
        Dim x As Long, z As Long, tUser As Integer
        For x = 1 To .NumTeams
            For z = 1 To .UsersPorTeam
                tUser = .Team(x).User(z)
                If tUser <> 0 Then
                    Call WarpUserChar(tUser, 1, 50, 50, True)
                    UserList(tUser).EnEvento = False
                End If
            Next z
        Next x
        Dim sdata As String
        sdata = PrepareMessageConsoleMsg("Torneo " & .UsersPorTeam & "vs" & .UsersPorTeam & "> El torneo ha sido cancelado.", FontTypeNames.FONTTYPE_GUILD)
        Call SendData(SendTarget.ToAll, 0, sdata)
    End With
End Sub
















