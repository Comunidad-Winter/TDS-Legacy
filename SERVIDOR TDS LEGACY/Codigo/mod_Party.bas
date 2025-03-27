Attribute VB_Name = "mod_Party"
Option Explicit

Public Const MAX_PARTIES As Byte = 255
Public Const PARTY_MAXMEMBERS As Byte = 5
Public Const PARTY_MAXREQUESTS As Byte = 4
Public Const MAXPARTYENTRYDISTANCE As Byte = 7

Public Type tPartyMember
    UserIndex As Integer
    Experience As Double
    Porc As Byte
End Type

Public Function NextParty() As Byte

    Dim LoopC As Long

    For LoopC = 1 To MAX_PARTIES
        If Parties(LoopC) Is Nothing Then
            NextParty = LoopC
            Exit Function
        End If
    Next LoopC

    NextParty = 0

End Function

Private Function CanCreateParty(ByVal UI As Integer) As Boolean

    If Not EsAdmin(UserList(UI).Name) Then
        If EsGM(UI) Then
            '"¡Los miembros del staff no pueden unirse a partys!"
            Exit Function
        End If
    End If

    If CInt(UserList(UI).Stats.UserAtributos(eAtributos.Carisma)) * UserList(UI).Stats.UserSkills(eSkill.Liderazgo) < 75 Then        'CInt(UserList(UI).Stats.UserAtributos(eAtributos.Carisma)) * UserList(UI).Stats.UserSkills(eSkill.Liderazgo) < 90
        Call WriteMensajes(UI, Mensaje_308, FontTypeNames.FONTTYPE_PARTY)        '"Tu carisma y liderazgo no son suficientes para liderar una party."
        Exit Function
    End If

    If UserList(UI).PartyIndex > 0 Then
        Call WriteMensajes(UI, Mensaje_309, FontTypeNames.FONTTYPE_PARTY)        '"Ya perteneces a una party."
        Exit Function
    End If

    If UserList(UI).flags.Muerto = 1 Then
        Exit Function
    End If

    If UserList(UI).Stats.UserSkills(eSkill.Liderazgo) < 5 Then
        Call WriteMensajes(UI, Mensaje_308, FontTypeNames.FONTTYPE_PARTY)        '"No tienes suficientes puntos de liderazgo para liderar una party."
        Exit Function
    End If

    CanCreateParty = True

End Function

Public Sub CreateParty(ByVal UI As Integer)

    If Not mod_Party.CanCreateParty(UI) Then Exit Sub

    Dim Freeslot As Byte
    Freeslot = NextParty

    If Freeslot < 1 Then
        Call WriteMensajes(UI, Mensaje_303, FontTypeNames.FONTTYPE_PARTY)        '"Por el momento no se pueden crear más parties."
        Exit Sub
    End If

    Set Parties(Freeslot) = New clsParty

    If Not Parties(Freeslot).NewMember(UI) Then
        Call WriteMensajes(UI, Mensaje_304, FontTypeNames.FONTTYPE_PARTY)        '"La party está llena, no puedes entrar."
        Set Parties(Freeslot) = Nothing
        Exit Sub
    End If

    Call WriteMensajes(UI, Mensaje_305, FontTypeNames.FONTTYPE_PARTY)        '"¡Has formado una party!"

    UserList(UI).PartyIndex = Freeslot
    Call mod_Party.ResetPartyRequest(UI)

    If Parties(Freeslot).MakeLeader(UI) Then
        Call WriteMensajes(UI, Mensaje_307, FontTypeNames.FONTTYPE_PARTY)        '"¡Te has convertido en líder de la party!"
    Else
        Call WriteMensajes(UI, Mensaje_306, FontTypeNames.FONTTYPE_PARTY)        '"No puedes hacerte líder."
    End If

    Call WritePartyDetails(UI)

End Sub

Public Sub RequestPartyEntry(ByVal UI As Integer)

    Dim TargetUserIndex As Integer
    Dim PartyIndex As Byte

    With UserList(UI)

        If Not .ConnIDValida Then Exit Sub

        'staff members except admins aren't allowed to party anyone
        If Not EsAdmin(.Name) Then
            If (EsGM(UI)) Then
                '"¡Los miembros del staff no pueden unirse a partys!"
                Call LogGM(.Name, "¡Intenta entrar a un party!")
                Exit Sub
            End If
        End If

        If .PartyIndex > 0 Then
            'si ya esta en una party
            Call WriteMensajes(UI, Mensaje_310, FontTypeNames.FONTTYPE_PARTY)        '"Ya perteneces a una party, escribe /SALIRPARTY para abandonarla"
            Call mod_Party.ResetPartyRequest(UI)
            Exit Sub
        End If

        ' Muerto?
        If .flags.Muerto = 1 Then
            Call mod_Party.ResetPartyRequest(UI)
            Exit Sub
        End If

        TargetUserIndex = .flags.TargetUser

        ' Target valido?
        If TargetUserIndex < 1 Then
            Call WriteMensajes(UI, Mensaje_312, FontTypeNames.FONTTYPE_PARTY)        '"Para ingresar a una party debes hacer click sobre el fundador y apretar F3."
            Call mod_Party.ResetPartyRequest(UI)
            Exit Sub
        End If

        PartyIndex = UserList(TargetUserIndex).PartyIndex

        ' Tiene party?
        If PartyIndex < 1 Then
            Call WriteConsoleMsg(UI, UserList(TargetUserIndex).Name & " no es fundador de ninguna party.", FontTypeNames.FONTTYPE_INFO)
            Call mod_Party.ResetPartyRequest(UI)
            Exit Sub
        End If

        ' Es lider?
        If Not Parties(PartyIndex).EsPartyLeader(TargetUserIndex) Then
            Call WriteConsoleMsg(UI, UserList(TargetUserIndex).Name & " no es lider de la party.", FontTypeNames.FONTTYPE_PARTY)
            Exit Sub
        End If

        If Not Parties(PartyIndex).NewRequest(UI) Then Exit Sub

        .PartyRequest = PartyIndex

        Call WriteMensajes(UI, Mensaje_311, FontTypeNames.FONTTYPE_PARTY)        '"El fundador decidirá si te acepta en la party."
        Call WriteConsoleMsg(TargetUserIndex, .Name & " solicita ingresar a tu party.", FontTypeNames.FONTTYPE_PARTY)

    End With

End Sub

Public Sub ExitParty(ByVal UI As Integer)

    Dim PI As Byte
    PI = UserList(UI).PartyIndex

    If PI < 1 Then
        Call WriteMensajes(UI, Mensaje_313, FontTypeNames.FONTTYPE_PARTY)        '"No eres miembro de ninguna party."
        Exit Sub
    End If

    '++ Sale el lider?
    If Parties(PI).SaleMember(UI) Then

        Dim i As Long

        For i = 1 To NumUsers
            If UserList(i).PartyRequest = PI Then
                UserList(i).PartyRequest = 0
            End If
        Next i

        Set Parties(PI) = Nothing
        Exit Sub
    End If

    UserList(UI).PartyIndex = 0
    Call UpdatePartyAllMembers(PI)

    'If Parties(PI).CantMembers = 0 Then
    '    Set Parties(PI) = Nothing
    '    Exit Sub
    'End If

End Sub
Public Sub ResetPartyRequest(ByVal UI As Integer)

    Dim PI As Byte
    PI = UserList(UI).PartyRequest
    If PI < 1 Then Exit Sub
    On Error Resume Next

    If Parties(PI) Is Nothing Then Exit Sub

    If Parties(PI).EraseRequest(UI) Then
        Call WriteConsoleMsg(UI, "Se ha rechazado tu solicitud a la party.", FontTypeNames.FONTTYPE_PARTY)
    End If
    Err.Clear

End Sub

Public Sub EjectParty(ByVal Leader As Integer, ByVal OldMember As Integer)

    Dim PI As Byte
    PI = UserList(Leader).PartyIndex

    If PI <> UserList(OldMember).PartyIndex And PI <> UserList(OldMember).PartyRequest Then
        Call WriteConsoleMsg(Leader, LCase$(UserList(OldMember).Name) & " no pertenece a tu party.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    '++ Sale el lider?
    If Parties(PI).SaleMember(OldMember) Then

        Dim i As Long

        For i = 1 To NumUsers
            If UserList(i).PartyRequest = PI Then
                UserList(i).PartyRequest = 0
            End If
        Next i

        Set Parties(PI) = Nothing
        Exit Sub
    End If

    UserList(OldMember).PartyIndex = 0

    If Not UserList(OldMember).PartyRequest = 0 Then
        Call ResetPartyRequest(OldMember)
    End If

    Call UpdatePartyAllMembers(PI)

End Sub

Public Function GetPartyString(ByVal UI As Integer)

    Dim PI As Byte
    PI = UserList(UI).PartyIndex

    If PI < 1 Then Exit Function

    GetPartyString = Parties(PI).PreparePercentageString()

End Function

Public Sub ValidateNewPercentages(ByVal UI As Integer, ByRef Percentages() As Integer)

    Dim LoopC As Long
    Dim CountPorc As Long
    Dim SkillLeader As Integer

    SkillLeader = UserList(UI).Stats.UserSkills(eSkill.Liderazgo)
    If SkillLeader > 90 Then SkillLeader = 90

    For LoopC = 1 To PARTY_MAXMEMBERS
        If Percentages(LoopC) > 0 Then
            CountPorc = CountPorc + Percentages(LoopC)

            If Percentages(LoopC) < 10 Then
                Call WriteMensajes(UI, Mensaje_251, FontTypeNames.FONTTYPE_PARTY)
                Exit Sub
            End If

            If Percentages(LoopC) > SkillLeader Then
                Call WriteMensajes(UI, Mensaje_250, FontTypeNames.FONTTYPE_PARTY)
                Exit Sub
            End If
        End If
    Next LoopC

    If CountPorc <> 100 Then
        Call WriteMensajes(UI, Mensaje_382)
        Exit Sub
    End If

    Call Parties(UserList(UI).PartyIndex).SetPercentages(Percentages())

End Sub

Public Function UserCanExecuteCommands(ByVal UI As Integer) As Boolean

    Dim PI As Byte
    PI = UserList(UI).PartyIndex

    If PI < 1 Then
        Call WriteMensajes(UI, Mensaje_313, FontTypeNames.FONTTYPE_PARTY)        '"No eres miembro de ninguna party."
        Exit Function
    End If

    If Not Parties(PI).EsPartyLeader(UI) Then
        Call WriteMensajes(UI, Mensaje_363, FontTypeNames.FONTTYPE_PARTY)        '"¡No eres el líder de tu party!"
        Exit Function
    End If

    UserCanExecuteCommands = True

End Function

Public Sub ApproveLoginParty(ByVal Leader As Integer, ByVal NewMember As Integer)

    Dim PI As Byte
    PI = UserList(Leader).PartyIndex

    If UserList(NewMember).PartyRequest <> PI Then
        Call WriteConsoleMsg(Leader, LCase$(UserList(NewMember).Name) & " no ha solicitado ingresar a tu party.", FontTypeNames.FONTTYPE_PARTY)
        Exit Sub
    End If

    If UserList(NewMember).flags.Muerto > 0 Then
        Call WriteMensajes(Leader, Mensaje_362, FontTypeNames.FONTTYPE_PARTY)        '"¡Está muerto, no puedes aceptar miembros en ese estado!"
        Exit Sub
    End If

    If UserList(NewMember).PartyIndex > 0 Then
        Call WriteConsoleMsg(Leader, UserList(NewMember).Name & " ya es miembro de otra party.", FontTypeNames.FONTTYPE_PARTY)
        Exit Sub
    End If

    If NewbiesCanDoPartyWithNoNewbies = 0 Then
        ' @@ Soy newbie y el otro no
        If EsNewbie(Leader) And Not EsNewbie(NewMember) Then
            Call WriteConsoleMsg(Leader, "Siendo Newbie sólo puedes aceptar a otros newbies en tu party.", FontTypeNames.FONTTYPE_PARTY)
            Exit Sub
        End If
    End If

    If Not Parties(PI).CanEnter(NewMember, Leader) Then Exit Sub

    If Parties(PI).NewMember(NewMember) Then
        Call WriteSendPartyData(Leader)
        Call Parties(PI).SendMessageToConsole(UserList(Leader).Name & " ha aceptado a " & UserList(NewMember).Name & " en la party.", "Servidor")

        UserList(NewMember).PartyIndex = PI
        Call mod_Party.ResetPartyRequest(NewMember)

        Call UpdatePartyAllMembers(PI)

    End If

End Sub

Public Sub BroadCastParty(ByVal UI As Integer, ByVal Text As String)

    Dim PI As Byte
    PI = UserList(UI).PartyIndex

    If PI < 1 Then Exit Sub
    Call Parties(PI).SendMessageToConsole(Text, UserList(UI).Name)

End Sub

Public Sub OnlineParty(ByVal UI As Integer)

    Dim PI As Byte
    PI = UserList(UI).PartyIndex

    If PI < 1 Then Exit Sub
    Call Parties(PI).PartyOnlines(UI)

End Sub

Public Sub TransformInLider(ByVal OldLeader As Integer, ByVal NewLeader As Integer)

    Dim PI As Byte
    PI = UserList(OldLeader).PartyIndex

    If PI <> UserList(NewLeader).PartyIndex Then
        Call WriteConsoleMsg(OldLeader, LCase$(UserList(NewLeader).Name) & " no pertenece a tu party.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    If UserList(NewLeader).flags.Muerto > 0 Then
        Call WriteMensajes(OldLeader, Mensaje_362, FontTypeNames.FONTTYPE_PARTY)        '"¡Está muerto!"
        Exit Sub
    End If

    If Parties(PI).MakeLeader(NewLeader) Then
        Call Parties(PI).SendMessageToConsole("El nuevo líder de la party es " & UserList(NewLeader).Name, UserList(OldLeader).Name)
        Exit Sub
    End If

    Call WriteMensajes(OldLeader, Mensaje_364, FontTypeNames.FONTTYPE_PARTY)        '"¡No se ha hecho el cambio de mando!"

End Sub

Public Sub UpdateExperiences()

    haciendoBK = True

    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle)

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Distribuyendo experiencia en parties.", FontTypeNames.FONTTYPE_SERVER))

    Dim LoopC As Long

    For LoopC = 1 To MAX_PARTIES
        If Not Parties(LoopC) Is Nothing Then
            Call Parties(LoopC).FlushExperience
            Call UpdatePartyAllMembers(LoopC)
        End If
    Next LoopC
    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle)

    haciendoBK = False

End Sub

Public Sub GetSuccess(ByVal PartyIndex As Byte, ByVal Exp As Double, ByVal map As Integer, ByVal npcDie As Boolean)
    On Error GoTo Errhandler
1   If PartyIndex < 1 Then Exit Sub
2   Call Parties(PartyIndex).GetSuccess(Exp, map, npcDie)
    Exit Sub
Errhandler:
    Call LogError("error en pgetsucess en " & Erl & " .err: " & Err.Number)
End Sub

Public Sub ObtenerExito(ByVal UserIndex As Integer, ByVal Exp As Long, mapa As Integer, X As Integer, Y As Integer, Optional ByVal npcDie As Boolean = False)
    If Exp <= 0 Then Exit Sub

    Call Parties(UserList(UserIndex).PartyIndex).ObtenerExito(Exp, mapa, X, Y, UserIndex, npcDie)
End Sub



Public Function CantMembers(ByVal PartyIndex As Byte) As Integer

    If PartyIndex < 1 Then Exit Function
    CantMembers = Parties(PartyIndex).CantMembers

End Function

Public Sub UpdatePartyAllMembers(ByVal PartyIndex As Byte)

    If PartyIndex < 1 Then Exit Sub
    Call Parties(PartyIndex).UpdatePartyDetails

End Sub

