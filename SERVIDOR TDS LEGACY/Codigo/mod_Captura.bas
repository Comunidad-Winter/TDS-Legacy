Attribute VB_Name = "mod_Captura"
Option Explicit

Private Type tCapture
    Active As Boolean
    Team(1 To 2) As clsTeam
    CountDown As Integer
    Started As Boolean
End Type

Public Type tUserCapture
    EnCaptura As Boolean
    Team As Byte
End Type

Public Capture As tCapture

Public Sub DisconnectCapture(ByVal UI As Integer)
    With UserList(UI)
        If .Captura.EnCaptura = False Then Exit Sub
        Call Capture.Team(.Captura.Team).DeleteUser(UI)
        ''El cls ya lo warpea automaticamente a su pos anterior.
        If Capture.Active = True Then
            Call MensajeGlobal("Captura la bandera> " & UserList(UI).Name & " se ha desconectado. Se ha liberado un cupo.", FontTypeNames.FONTTYPE_GUILD)
        End If
        If Capture.Team(.Captura.Team).UsersOnline = 0 Then
            Call EndCapture(IIf(.Captura.Team = 1, 2, 1), False)
            Call MensajeGlobal("Captura la bandera> El evento ha sido suspendido debido a que el equipo " & .Captura.Team & " se ha quedado sin usuarios.", FontTypeNames.FONTTYPE_GUILD)
        End If
    End With
End Sub

Private Sub EndCapture(ByVal Winner As Byte, Optional ByVal GiveOrito As Boolean = True)
    Dim Loser As Byte, x As Long, z As Long, UI As Integer
    Loser = IIf(Winner = 1, 2, 1)
    For z = 1 To 2
        For x = 1 To Capture.Team(z).maxTeam
            UI = Capture.Team(z).Usuario(x)
            If UI <> 0 Then
                Call Capture.Team(z).DeleteUser(UI)
                If Winner = z And GiveOrito = True Then
                    Debug.Print "agregar orito?..."
                End If
            End If
        Next x
    Next z
End Sub

Public Sub EnterCapture(ByVal UI As Integer)
    ''checkeos
    Dim cError As String
    cError = CanEnter(UI)
    If LenB(cError) <> 0 Then
        Call WriteConsoleMsg(UI, "Captura la bandera> " & cError, FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If
    
    With Capture
        Dim nTeam As Byte
        If .Team(1).UsersOnline > .Team(2).UsersOnline Then
            nTeam = 2
        ElseIf .Team(2).UsersOnline > .Team(1).UsersOnline Then
            nTeam = 1
        ElseIf .Team(2).UsersOnline = .Team(1).UsersOnline Then
            If .Team(2).UsersOnline = .Team(2).maxTeam Then
                Call WriteConsoleMsg(UI, "Captura la bandera> Los cupos se encuentran llenos.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            Else
                nTeam = RandomNumber(1, 2)
            End If
        End If
        
        If .Team(nTeam).AddUser(UI) = False Then
            Call WriteConsoleMsg(UI, "Captura la bandera> Ha ocurrido un error inesperado. Avisar a un adminsitrador.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        UserList(UI).Captura.EnCaptura = True
        UserList(UI).Captura.Team = nTeam
        UserList(UI).EnEvento = True
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Captura la bandera> " & UserList(UI).Name & " ingresó al evento.", FontTypeNames.FONTTYPE_GUILD))
        Call .Team(nTeam).MessageTeam("Captura la bandera> " & UserList(UI).Name & " ha ingresado al equipo.", FontTypeNames.FONTTYPE_DIOS)
    End With
    
    
End Sub

Private Function CanEnter(ByVal UI As Integer) As String
    With UserList(UI)
        If Capture.Active = False Then
            CanEnter = "Este evento no se está realizando."
            Exit Function
        End If
        
        ''If Capture.Started = True Then
        ''    CanEnter = "Las inscripciones para este evento ya han sido cerradas."
        ''    Exit Function
        ''End If
            
        If .Captura.EnCaptura = True Then
            CanEnter = "Ya estás inscripto en el evento."
            Exit Function
        End If
        
        If .flags.Muerto > 0 Then
            CanEnter = "Estás muerto."
            Exit Function
        End If
            
        If .Counters.Pena > 0 Then
            CanEnter = "Estás en la carcel."
            Exit Function
        End If
        
        If .EnEvento = True Then
            CanEnter = "Ya estás en un evento."
            Exit Function
        End If
        
        If MapInfo(.Pos.map).Pk = True Then
            CanEnter = "Estás en zona insegura"
            Exit Function
        End If
    End With
End Function

Public Sub CreateCapture(ByVal UI As Integer, ByVal Cupos As Byte)
    With Capture
        If .Active = True Then
            Call WriteConsoleMsg(UI, "Captura la bandera> Ya se esta realizando", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        Set .Team(1) = New clsTeam
        Set .Team(2) = New clsTeam
        Call .Team(1).Initialize(Cupos / 2)
        Call .Team(2).Initialize(Cupos / 2)
        .Active = True
        .CountDown = 11
        .Started = False
    End With
End Sub

Public Sub CaptureTimer()
    With Capture
        If .Active = True And .Started = True Then
            If .CountDown > 1 Then
                Call .Team(1).MessageTeam("Captura la bandera> Conteo> " & .CountDown - 1, FontTypeNames.FONTTYPE_GUILD)
                Call .Team(2).MessageTeam("Captura la bandera> Conteo> " & .CountDown - 1, FontTypeNames.FONTTYPE_GUILD)
            ElseIf .CountDown = 1 Then
                Call .Team(1).MessageTeam("Captura la bandera> Conteo> ¡Ya!", FontTypeNames.FONTTYPE_GUILD)
                Call .Team(2).MessageTeam("Captura la bandera> Conteo> ¡Ya!", FontTypeNames.FONTTYPE_GUILD)
                Call .Team(1).PauseToggleTeam
                Call .Team(2).PauseToggleTeam
            End If
            If .CountDown > 0 Then .CountDown = .CountDown - 1
        End If
    End With
End Sub








