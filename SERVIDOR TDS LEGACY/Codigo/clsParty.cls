VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsParty"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit

Private p_members(1 To PARTY_MAXMEMBERS) As tPartyMember
Private p_Requests(1 To PARTY_MAXREQUESTS) As Integer

Private p_expTotal As Double
Private p_Founder As Integer
Private p_CantMembers As Integer
Private p_CantRequests As Integer

Private PARTY_MAXDISTANCIA As Byte

'Constructor de clase
Public Sub Class_Initialize()

    p_expTotal = 0
    p_CantMembers = 0
    p_CantRequests = 0

    PARTY_MAXDISTANCIA = 18

    Erase p_Requests()

End Sub

Public Function MyExperience(ByVal Party_ID As Byte) As Long
    MyExperience = Fix(p_members(Party_ID).Experience)
End Function

Public Sub ObtenerExito(ByVal ExpGanada As Long, ByVal mapa As Integer, X As Integer, Y As Integer, ByVal AttackerUI As Integer, Optional ByVal npcDie As Boolean = False)

    Dim i As Integer
    Dim UI As Integer
    Dim expThisUser As Double
    Dim expRemaining As Double
    Dim tmpPorc As Byte

    p_expTotal = p_expTotal + ExpGanada

    ' Calcular el total de porcentajes para usuarios en el área
    Dim totalPorcentajeEnArea As Double
    For i = 1 To PARTY_MAXMEMBERS
        UI = p_members(i).UserIndex
        If UI > 0 Then
            If mapa = UserList(UI).Pos.map And UserList(UI).flags.Muerto = 0 And (Distance(UserList(UI).Pos.X, UserList(UI).Pos.Y, X, Y) <= PARTY_MAXDISTANCIA Or AttackerUI = UI) Then
                totalPorcentajeEnArea = totalPorcentajeEnArea + p_members(i).Porc
            End If
        End If
    Next i

    ' Distribuir la experiencia en función de los porcentajes
    If totalPorcentajeEnArea > 0 Then
        For i = 1 To PARTY_MAXMEMBERS
            UI = p_members(i).UserIndex
            If UI > 0 Then
                If mapa = UserList(UI).Pos.map And UserList(UI).flags.Muerto = 0 And (Distance(UserList(UI).Pos.X, UserList(UI).Pos.Y, X, Y) <= PARTY_MAXDISTANCIA Or AttackerUI = UI) Then

                    tmpPorc = p_members(i).Porc * 100 / totalPorcentajeEnArea  ' Calcular el porcentaje real

                    If tmpPorc <> 100 Then
                        expThisUser = CDbl(Porcentaje(ExpGanada, tmpPorc))
                    Else
                        expThisUser = CDbl(ExpGanada)
                    End If

                    If npcDie Then
                        UserList(UI).Stats.NPCsMuertos = UserList(UI).Stats.NPCsMuertos + 1
                    End If

                    p_members(i).Experience = p_members(i).Experience + expThisUser
                    If p_members(i).Experience < 0 Then
                        p_members(i).Experience = 0
                    End If

                    'UserList(UI).Stats.Exp = UserList(UI).Stats.Exp + Fix(expThisUser)
                    'If UserList(UI).Stats.Exp > MAXEXP Then
                    '   UserList(UI).Stats.Exp = MAXEXP
                    'End If
                    'Call CheckUserLevel(UI)
                    'Call WriteUpdateUserStats(UI)
                End If
            End If
        Next i
    Else
        ' Si no hay miembros en el área, todo va para el primer miembro
        UI = p_members(1).UserIndex
        If UI > 0 Then
            If npcDie Then
                UserList(UI).Stats.NPCsMuertos = UserList(UI).Stats.NPCsMuertos + 1
            End If

            p_members(1).Experience = p_members(1).Experience + ExpGanada
            If p_members(1).Experience < 0 Then
                p_members(1).Experience = 0
            End If

            ' UserList(UI).Stats.Exp = UserList(UI).Stats.Exp + Fix(ExpGanada)
            ' If UserList(UI).Stats.Exp > MAXEXP Then
            '    UserList(UI).Stats.Exp = MAXEXP
            ' End If
            ' Call CheckUserLevel(UI)
            ' Call WriteUpdateUserStats(UI)
        End If
    End If

End Sub

Public Sub GetSuccess(ByVal ExpEarned As Double, ByVal map As Integer, Optional ByVal npcDie As Boolean = False)

    On Error GoTo Errhandler

    Dim LoopC As Long
    Dim N As Integer
    Dim nexp As Double

1   p_expTotal = p_expTotal + ExpEarned

2   For LoopC = 1 To PARTY_MAXMEMBERS
3       N = p_members(LoopC).UserIndex

4       If N > 0 Then
5           If map = UserList(N).Pos.map Then
6               If UserList(N).flags.Muerto = 0 Then

7                   If p_members(LoopC).Porc <> 100 Then
8                       nexp = Porcentaje(ExpEarned, p_members(LoopC).Porc)
                    Else
10                      nexp = ExpEarned
                    End If
                    UserList(p_members(LoopC).UserIndex).Counters.LeveleandoTick = 10
                    'Call WriteBonifStatus(p_members(LoopC).UserIndex)
                    If UserList(p_members(LoopC).UserIndex).Counters.tBonif > 0 Then nexp = nexp * 1 + (0.5 * ExpMulti)
                    p_members(LoopC).Experience = p_members(LoopC).Experience + nexp

                    If npcDie Then
                        UserList(p_members(LoopC).UserIndex).Stats.NPCsMuertos = UserList(p_members(LoopC).UserIndex).Stats.NPCsMuertos + 1
                    End If

                End If
            End If
        End If
    Next LoopC
    Exit Sub

Errhandler:
    Call LogError("error en getSucess en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub InitPercentages()

    If p_CantMembers < 1 Then Exit Sub

    Dim Porc As Byte
    Porc = GetPercentage

    Dim LoopC As Long

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex > 0 Then
            p_members(LoopC).Porc = Porc
            Call WriteConsoleMsg(p_members(LoopC).UserIndex, "Party> Porcentajes actualizados." & vbNewLine & "Porcentaje de experiencia por usuario: " & Porc & ".", FontTypeNames.FONTTYPE_PARTY)
        End If
    Next LoopC

End Sub

Public Function PreparePercentageString() As String

    Dim LoopC As Long
    Dim N As Integer
    Dim Str As String

    For LoopC = 1 To PARTY_MAXMEMBERS
        N = p_members(LoopC).UserIndex

        If N > 0 Then
            If LenB(Str) > 0 Then
                Str = Str & "," & UserList(N).Name & "*" & Int(p_members(LoopC).Experience) & "*" & p_members(LoopC).Porc
            Else
                Str = UserList(N).Name & "*" & Int(p_members(LoopC).Experience) & "*" & p_members(LoopC).Porc
            End If
        End If
    Next LoopC

    PreparePercentageString = Str

End Function

Public Sub SetPercentages(ByRef Percentages() As Integer)

    Dim LoopC As Long
    Dim N As Integer
    Dim Str As String

    p_members(1).Porc = Percentages(1)
    N = p_members(1).UserIndex

    If N < 1 Then Exit Sub
    Str = UserList(N).Name & " [" & p_members(1).Porc & "%] "

    For LoopC = 2 To PARTY_MAXMEMBERS
        p_members(LoopC).Porc = Percentages(LoopC)

        N = p_members(LoopC).UserIndex

        If N > 0 Then
            Str = Str & UserList(N).Name & " [" & p_members(LoopC).Porc & "%] "
        End If
    Next LoopC

    Call SendMessageToConsole("Porcentajes de la party actualizados." & vbNewLine & Str & ".", "PARTY")

End Sub

Private Function GetPercentage() As Byte

    Select Case p_CantMembers
    Case 1
        GetPercentage = 100
    Case 2
        GetPercentage = 50
    Case 3
        GetPercentage = 33
    Case 4
        GetPercentage = 25
    Case 5
        GetPercentage = 20
    End Select

End Function

Public Sub SendMessageToConsole(ByVal Text As String, ByVal Sender As String)

    Dim LoopC As Long

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex > 0 Then
            Call WriteConsoleMsg(p_members(LoopC).UserIndex, "[" & Sender & "] " & Text, FontTypeNames.FONTTYPE_PARTY)
        End If
    Next LoopC

End Sub

Public Sub PartyOnlines(ByVal UI As Integer)

    Dim Text As String
    Dim LoopC As Long

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex > 0 Then
            Text = Text & " - " & UserList(p_members(LoopC).UserIndex).Name & " (" & p_members(LoopC).Experience & ")"
        End If
    Next LoopC

    Call WriteConsoleMsg(UI, "Nombre(Exp): " & Text & ". Experiencia total: " & p_expTotal, FontTypeNames.FONTTYPE_PARTY)

End Sub

Public Function EsPartyLeader(ByVal UI As Integer) As Boolean
    EsPartyLeader = (UI = p_Founder)
End Function

Public Function NewMember(ByVal UI As Integer) As Boolean

    Dim LoopC As Long, Freeslot As Byte

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex < 1 Then
            Freeslot = LoopC
            Exit For
        End If
    Next LoopC

    If Freeslot < 1 Then Exit Function

    p_members(Freeslot).UserIndex = UI
    p_members(Freeslot).Experience = 0
    p_CantMembers = p_CantMembers + 1

    If p_CantRequests > 0 Then
        p_CantRequests = p_CantRequests - 1
    End If

    For LoopC = 1 To PARTY_MAXREQUESTS
        If p_Requests(LoopC) = UI Then
            p_Requests(LoopC) = 0
            Exit For
        End If
    Next LoopC

    Call InitPercentages
    NewMember = True

End Function

Public Function EraseRequest(ByVal UI As Integer) As Boolean

    Dim LoopC As Long, Freeslot As Byte

    ' ++ No hay una solicitud de el?
    For LoopC = 1 To PARTY_MAXREQUESTS
        If p_Requests(LoopC) = UI Then
            p_Requests(LoopC) = 0
            p_CantRequests = p_CantRequests - 1
            EraseRequest = True
            Exit Function
        End If
    Next LoopC

End Function
Public Function NewRequest(ByVal UI As Integer) As Boolean

    Dim LoopC As Long, Freeslot As Byte

    ' ++ No hay una solicitud de el?
    For LoopC = 1 To PARTY_MAXREQUESTS
        If p_Requests(LoopC) = UI Then
            Call WriteMensajes(UI, Mensaje_388)
            Exit Function
        End If

        If Freeslot < 1 Then
            ' ++ Hay slot libre?
            If p_Requests(LoopC) = 0 Then
                Freeslot = LoopC
            End If
        End If
    Next LoopC

    ' ++ La party esta llena o al maximo de solicitudes?
    If Freeslot > 0 Then
        If p_CantRequests <= PARTY_MAXREQUESTS Then
            p_CantRequests = p_CantRequests + 1
            p_Requests(Freeslot) = UI
            NewRequest = True
        Else
            Call WriteMensajes(UI, Mensaje_389)
        End If
    Else
        Call WriteMensajes(UI, Mensaje_304)
    End If

End Function

Public Function SaleMember(ByVal UI As Integer) As Boolean

    Dim LoopC As Long
    Dim PartyID As Byte

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex = UI Then
            PartyID = LoopC
            Exit For
        End If
    Next LoopC

    If PartyID < 1 Then Exit Function

    Dim j As Long
    Dim N As Integer
    Dim LastLevel As Byte

    If PartyID <> 1 Then

        N = p_members(PartyID).UserIndex

        If p_members(PartyID).Experience > 0 Then
            Call WriteConsoleMsg(N, " Durante la misma has conseguido " & Format$(CStr(Fix(p_members(PartyID).Experience)), "#,###,###,###") & " puntos de experiencia!", FontTypeNames.FONTTYPE_PARTY)

            UserList(N).Stats.Exp = UserList(N).Stats.Exp + Fix(p_members(PartyID).Experience)

            If UserList(N).Stats.Exp > MAXEXP Then
                UserList(N).Stats.Exp = MAXEXP
            End If

            LastLevel = UserList(N).Stats.ELV
            Call CheckUserLevel(N)

            If UserList(N).Stats.ELV = LastLevel Then
                Call WriteUpdateExp(N)
            End If
        Else
            Call WriteMensajes(N, Mensaje_390)
        End If

        Call WritePartyExit(N)
        Call SendMessageToConsole(UserList(N).Name & " abandona la party.", "Servidor")

        p_CantMembers = p_CantMembers - 1
        p_members(PartyID).UserIndex = 0
        p_members(PartyID).Experience = 0

        Call CompactMemberList
        Call InitPercentages

    Else

        'Sale el dueño de la party?
        SaleMember = True
        Call SendMessageToConsole("El lider disuelve la party.", "Servidor")

        For j = PARTY_MAXMEMBERS To 1 Step -1
            N = p_members(j).UserIndex

            If N > 0 Then

                Call WriteConsoleMsg(N, "Abandonas la party liderada por " & UserList(p_members(1).UserIndex).Name, FontTypeNames.FONTTYPE_PARTY)

                If p_members(j).Experience > 0 Then
                    Call WriteConsoleMsg(N, " Durante la misma has conseguido " & Format$(CStr(Fix(p_members(j).Experience)), "#,###,###,###") & " puntos de experiencia!", FontTypeNames.FONTTYPE_PARTY)

                    UserList(N).Stats.Exp = UserList(N).Stats.Exp + Fix(p_members(j).Experience)

                    If UserList(N).Stats.Exp > MAXEXP Then
                        UserList(N).Stats.Exp = MAXEXP
                    End If

                    LastLevel = UserList(N).Stats.ELV
                    Call CheckUserLevel(N)

                    If UserList(N).Stats.ELV = LastLevel Then
                        Call WriteUpdateExp(N)
                    End If
                Else

                    Call WriteMensajes(N, Mensaje_390)

                End If

                Call WritePartyExit(N)
                Call SendMessageToConsole(UserList(N).Name & " abandona la party.", "Servidor")

                UserList(N).PartyIndex = 0

                p_CantMembers = p_CantMembers - 1
                p_members(j).UserIndex = 0
                p_members(j).Experience = 0
            End If

        Next j

    End If

End Function

Public Function MakeLeader(ByVal UI As Integer) As Boolean

    Dim i As Long
    Dim OldLeader As Integer
    Dim oldExp As Double
    Dim UserIndexIndex As Integer

    UserIndexIndex = 0
    MakeLeader = True

    For i = 1 To PARTY_MAXMEMBERS
        If p_members(i).UserIndex > 0 Then
            If p_members(i).UserIndex = UI Then
                UserIndexIndex = i
            End If
        End If
    Next i

    If Not MakeLeader Then Exit Function

    If UserIndexIndex = 0 Then
        'catastrofe! esto no deberia pasar nunca! pero como es AO.... :p
        Call LogError("INCONSISTENCIA DE PARTIES")
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(" Inconsistencia de parties en HACERLEADER (UI = 0), AVISE A UN PROGRAMADOR ESTO ES UNA CATASTROFE!!!!", FontTypeNames.FONTTYPE_GUILD))
        MakeLeader = False
        Exit Function
    End If

    'aca esta todo bien y doy vuelta las collections
    OldLeader = p_members(1).UserIndex
    oldExp = p_members(1).Experience

    p_members(1).UserIndex = p_members(UserIndexIndex).UserIndex        'que en realdiad es el userindex, pero no quiero inconsistencias moviendo experiencias
    p_members(1).Experience = p_members(UserIndexIndex).Experience

    p_members(UserIndexIndex).UserIndex = OldLeader
    p_members(UserIndexIndex).Experience = oldExp

    p_Founder = p_members(1).UserIndex

    'no need to compact
End Function

Public Sub GetMembersOnline(ByRef MemberList() As Integer)

    Dim LoopC As Long

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex > 0 Then
            MemberList(LoopC) = p_members(LoopC).UserIndex
        End If
    Next LoopC

End Sub

Public Sub GetRequests(ByRef MemberList() As Integer)

    Dim LoopC As Long, N As Integer

    For LoopC = 1 To PARTY_MAXREQUESTS
        N = p_Requests(LoopC)

        If N > 0 Then
            If UserList(N).ConnIDValida Then
                MemberList(LoopC) = N
            Else
                If p_CantRequests > 0 Then
                    p_CantRequests = p_CantRequests - 1
                End If

                p_Requests(LoopC) = 0
            End If
        End If
    Next LoopC

End Sub

Public Function GetTotalExperience() As Double
    GetTotalExperience = p_expTotal
End Function

Public Function CanEnter(ByVal UI As Integer, ByRef Leader As Integer) As Boolean

    If distancia(UserList(Leader).Pos, UserList(UI).Pos) > MAXPARTYENTRYDISTANCE Then
        Call WriteConsoleMsg(Leader, "El usuario " & UserList(UI).Name & " se encuentra muy lejos.", FontTypeNames.FONTTYPE_PARTY)
        Exit Function
    End If

    If p_members(PARTY_MAXMEMBERS).UserIndex > 0 Then
        Call WriteConsoleMsg(Leader, "La cantidad maxima de miembros es " & PARTY_MAXMEMBERS, FontTypeNames.FONTTYPE_PARTY)
        Exit Function
    End If

    Dim EsArmada As Boolean
    Dim EsCaos As Boolean
    Dim LoopC As Long
    Dim N As Integer

    EsArmada = (UserList(UI).faccion.ArmadaReal = 1)
    EsCaos = (UserList(UI).faccion.FuerzasCaos = 1)

    For LoopC = 1 To PARTY_MAXMEMBERS
        N = p_members(LoopC).UserIndex

        If N > 0 Then

            'aspirante armada en party crimi
            If EsArmada And criminal(N) Then
                Call WriteMensajes(Leader, Mensaje_391)
                Exit Function
            End If

            'aspirante caos en party ciuda
            If EsCaos And Not criminal(N) Then

                Call WriteMensajes(Leader, Mensaje_392)
                Exit Function
            End If

            'aspirante crimi en party armada
            If UserList(N).faccion.ArmadaReal = 1 And criminal(UI) Then
                Call WriteMensajes(Leader, Mensaje_393)
                Exit Function
            End If

            'aspirante ciuda en party caos
            If UserList(N).faccion.FuerzasCaos = 1 And Not criminal(UI) Then
                Call WriteMensajes(Leader, Mensaje_394)
                Exit Function
            End If

        End If

    Next LoopC

    CanEnter = True

End Function

Public Sub FlushExperience()

    Dim LoopC As Long, N As Integer, LastLevel As Byte

    For LoopC = 1 To PARTY_MAXMEMBERS
        N = p_members(LoopC).UserIndex

        If N > 0 Then
            If p_members(LoopC).Experience > 0 Then
                UserList(N).Stats.Exp = UserList(N).Stats.Exp + Fix(p_members(LoopC).Experience)

                If UserList(N).Stats.Exp > MAXEXP Then
                    UserList(N).Stats.Exp = MAXEXP
                End If

                LastLevel = UserList(N).Stats.ELV
                Call CheckUserLevel(N)

                If UserList(N).Stats.ELV = LastLevel Then
                    Call WriteUpdateExp(N)
                End If

                p_members(LoopC).Experience = 0
                Call WritePartyDetails(N)
            End If
        End If
    Next LoopC

End Sub

Private Sub CompactMemberList()
    Dim i As Integer
    Dim freeIndex As Integer
    i = 1
    While i <= PARTY_MAXMEMBERS
        If p_members(i).UserIndex = 0 And freeIndex = 0 Then
            freeIndex = i
        ElseIf p_members(i).UserIndex > 0 And freeIndex > 0 Then
            p_members(freeIndex).Experience = p_members(i).Experience
            p_members(freeIndex).UserIndex = p_members(i).UserIndex
            p_members(i).UserIndex = 0
            p_members(i).Experience = 0
            'muevo el de la pos i a freeindex
            i = freeIndex
            freeIndex = 0
        End If
        i = i + 1
    Wend

End Sub

Public Function CantMembers() As Integer
    CantMembers = p_CantMembers
End Function

Public Sub UpdatePartyDetails()

    Dim LoopC As Long

    For LoopC = 1 To PARTY_MAXMEMBERS
        If p_members(LoopC).UserIndex > 0 Then
            Call WritePartyDetails(p_members(LoopC).UserIndex)
        End If
    Next LoopC

End Sub

