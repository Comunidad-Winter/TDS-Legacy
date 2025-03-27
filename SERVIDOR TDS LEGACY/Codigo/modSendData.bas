Attribute VB_Name = "modSendData"
Option Explicit

Public Enum SendTarget
    ToAll = 1
    ToIndex
    toMap
    ToPCArea
    ToAllButIndex
    ToMapButIndex
    ToGM
    ToNPCArea
    ToGuildMembers
    ToAdmins
    ToPCAreaButIndex
    ToAdminsAreaButConsejeros
    ToDiosesYclan
    ToConsejo
    ToClanArea
    ToConsejoCaos
    ToRolesMasters
    ToDeadArea
    ToCiudadanos
    ToCriminales
    ToPartyArea
    ToReal
    ToCaos
    ToCiudadanosYRMs
    ToCriminalesYRMs
    ToRealYRMs
    ToCaosYRMs
    ToHigherAdmins
    ToGMsAreaButRmsOrCounselors
    ToUsersAreaButGMs
    ToUsersAndRmsAndCounselorsAreaButGMs
    ToNPCCommerceArray
    ToAllButDungeon
    ToGlobal
End Enum

Public Sub SendData(ByVal sndRoute As SendTarget, ByVal sndIndex As Integer, ByVal sndData As BinaryWriter)

    On Error GoTo Errhandler
    Dim LoopC As Long
    Dim Map As Integer

    Select Case sndRoute
    Case SendTarget.ToIndex
1       If Not sndIndex = 0 Then
2           If UserList(sndIndex).ConnIDValida Then
3               Call UserList(sndIndex).Connection.Write(sndData, eChannelReliable)
                'Call Server.send(sndIndex, False, Writer)
            End If
        End If

    Case SendTarget.ToPCArea
4       Call SendToUserArea(sndIndex, sndData)

    Case SendTarget.ToAdmins
        For LoopC = 1 To LastUser
            If UserList(LoopC).ConnIDValida Then
122             If Not UserList(LoopC).flags.Privilegios = PlayerType.User Then
124                 Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToGlobal
        For LoopC = 1 To LastUser
            If UserList(LoopC).ConnIDValida Then
                If UserList(LoopC).flags.GlobalOn Or Not UserList(LoopC).flags.Privilegios = PlayerType.User Then
                    Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToAll
5       For LoopC = 1 To LastUser
6           If UserList(LoopC).ConnIDValida Then
7               If UserList(LoopC).flags.UserLogged Then        'Esta logeado como usuario?
8                   Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToAllButIndex
9       For LoopC = 1 To LastUser
10          If (UserList(LoopC).ConnIDValida) And (LoopC <> sndIndex) Then
11              If UserList(LoopC).flags.UserLogged Then        'Esta logeado como usuario?
12                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)   '
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC


    Case SendTarget.ToAllButDungeon
        For LoopC = 1 To LastUser
            If (UserList(LoopC).ConnIDValida) Then
                If UserList(LoopC).flags.UserLogged Then        'Esta logeado como usuario?
                    If Not MapInfo(UserList(LoopC).Pos.Map).Terreno = "DUNGEON" And Not MapInfo(UserList(LoopC).Pos.Map).Terreno = "RETOS" And Not MapInfo(UserList(LoopC).Pos.Map).Zona = "RETOS" And Not MapInfo(UserList(LoopC).Pos.Map).Zona = "EVENTOS" And Not MapInfo(UserList(LoopC).Pos.Map).Zona = "DUNGEON" Then
                        Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                        'Call Server.send(LoopC, False, Writer)
                    End If
                End If
            End If
        Next LoopC

    Case SendTarget.toMap
13      Call SendToMap(sndIndex, sndData)

    Case SendTarget.ToMapButIndex
14      Call SendToMapButIndex(sndIndex, sndData)

    Case SendTarget.ToGuildMembers
15      LoopC = modGuilds.m_Iterador_ProximoUserIndex(sndIndex)
16      While LoopC > 0
17          If (UserList(LoopC).ConnIDValida) Then
18              Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                'Call Server.send(LoopC, False, Writer)
19          End If
20          LoopC = modGuilds.m_Iterador_ProximoUserIndex(sndIndex)
        Wend

    Case SendTarget.ToDeadArea
21      Call SendToDeadUserArea(sndIndex, sndData)

    Case SendTarget.ToPCAreaButIndex
22      Call SendToUserAreaButindex(sndIndex, sndData)

    Case SendTarget.ToClanArea
23      Call SendToUserGuildArea(sndIndex, sndData)

    Case SendTarget.ToPartyArea
24      Call SendToUserPartyArea(sndIndex, sndData)

    Case SendTarget.ToAdminsAreaButConsejeros
25      Call SendToAdminsButConsejerosArea(sndIndex, sndData)

    Case SendTarget.ToNPCArea
26      Call SendToNpcArea(sndIndex, sndData)

    Case SendTarget.ToDiosesYclan
27      LoopC = modGuilds.m_Iterador_ProximoUserIndex(sndIndex)
28      While LoopC > 0
29          If (UserList(LoopC).ConnIDValida) Then
30              Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                'Call Server.send(LoopC, False, Writer)
            End If
31          LoopC = modGuilds.m_Iterador_ProximoUserIndex(sndIndex)
        Wend

32      LoopC = modGuilds.Iterador_ProximoGM(sndIndex)
33      While LoopC > 0
34          If (UserList(LoopC).ConnIDValida) Then
35              Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                'Call Server.send(LoopC, False, Writer)
            End If
36          LoopC = modGuilds.Iterador_ProximoGM(sndIndex)
        Wend

    Case SendTarget.ToConsejo
37      For LoopC = 1 To LastUser
38          If (UserList(LoopC).ConnIDValida) Then
39              If UserList(LoopC).faccion.Status = FaccionType.RoyalCouncil Or EsGM(LoopC) Then
40                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToConsejoCaos
41      For LoopC = 1 To LastUser
42          If (UserList(LoopC).ConnIDValida) Then
43              If UserList(LoopC).faccion.Status = FaccionType.ChaosCouncil Or EsGM(LoopC) Then
44                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToRolesMasters
        For LoopC = 1 To LastUser
45          If (UserList(LoopC).ConnIDValida) Then
46              If UserList(LoopC).flags.Privilegios = PlayerType.RoleMaster Then
47                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCiudadanos
        For LoopC = 1 To LastUser
48          If (UserList(LoopC).ConnIDValida) Then
49              If Not criminal(LoopC) Then
50                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCriminales
        For LoopC = 1 To LastUser
51          If (UserList(LoopC).ConnIDValida) Then
52              If criminal(LoopC) Then
53                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToReal
        For LoopC = 1 To LastUser
54          If (UserList(LoopC).ConnIDValida) Then
55              If UserList(LoopC).faccion.ArmadaReal = 1 Then
56                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCaos
        For LoopC = 1 To LastUser
57          If (UserList(LoopC).ConnIDValida) Then
58              If UserList(LoopC).faccion.FuerzasCaos = 1 Then
59                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCiudadanosYRMs
        For LoopC = 1 To LastUser
60          If (UserList(LoopC).ConnIDValida) Then
61              If Not criminal(LoopC) Or (UserList(LoopC).flags.Privilegios = PlayerType.RoleMaster) Then
62                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCriminalesYRMs
        For LoopC = 1 To LastUser
63          If (UserList(LoopC).ConnIDValida) Then
64              If criminal(LoopC) Or (UserList(LoopC).flags.Privilegios = PlayerType.RoleMaster) Then
65                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToRealYRMs
        For LoopC = 1 To LastUser
66          If (UserList(LoopC).ConnIDValida) Then
67              If UserList(LoopC).faccion.ArmadaReal = 1 Or (UserList(LoopC).flags.Privilegios = PlayerType.RoleMaster) Then
68                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToCaosYRMs
        For LoopC = 1 To LastUser
69          If (UserList(LoopC).ConnIDValida) Then
70              If UserList(LoopC).faccion.FuerzasCaos = 1 Or (UserList(LoopC).flags.Privilegios = PlayerType.RoleMaster) Then
71                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToHigherAdmins
        For LoopC = 1 To LastUser
72          If UserList(LoopC).ConnIDValida Then
73              If UserList(LoopC).flags.Privilegios >= PlayerType.Dios Then
74                  Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                    'Call Server.send(LoopC, False, Writer)
                End If
            End If
        Next LoopC

    Case SendTarget.ToGMsAreaButRmsOrCounselors
75      Call SendToGMsAreaButRmsOrCounselors(sndIndex, sndData)

    Case SendTarget.ToUsersAreaButGMs
76      Call SendToUsersAreaButGMs(sndIndex, sndData)

    Case SendTarget.ToUsersAndRmsAndCounselorsAreaButGMs
77      Call SendToUsersAndRmsAndCounselorsAreaButGMs(sndIndex, sndData)

    Case SendTarget.ToNPCCommerceArray
        Dim otro As Long
        If Not sndIndex = 0 Then
            If Not UserList(sndIndex).flags.commerce_npc_npcindex = 0 Then
                If Npclist(UserList(sndIndex).flags.commerce_npc_npcindex).HasUserInCommerce Then
78                  For LoopC = 0 To UBound(Npclist(UserList(sndIndex).flags.commerce_npc_npcindex).npcTradingArray)
79                      otro = Npclist(UserList(sndIndex).flags.commerce_npc_npcindex).npcTradingArray(LoopC)

90                      If UserList(otro).ConnIDValida Then
91                          If otro <> sndIndex Then
92                              Call UserList(LoopC).Connection.Write(sndData, eChannelReliable)
                                'Call Server.send(otro, False, Writer)
                            End If
                        End If
                    Next LoopC
                End If
            End If
        Else
            LogError ("SndData sndIndex=0")
        End If

    End Select

Errhandler:

    Call sndData.Clear

    'Call sndData.Clear
    If Err.Number <> 0 Then
        Call LogError("Error" & Err.Number & "(" & Err.Description & ") en Sub SendData de modSendData.bas en la linea " & Erl)
    End If

End Sub

Private Sub SendToUserArea(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                End If
            End If
        End If
    Next LoopC

    Call sndData.Clear
End Sub

Private Sub SendToUserAreaButindex(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToUserAreaButindex_Err
    Dim LoopC As Long
    Dim TempInt As Integer
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        TempInt = UserList(tempIndex).AreasInfo.AreaReciveX And AreaX
        If TempInt Then        'Esta en el area?
            TempInt = UserList(tempIndex).AreasInfo.AreaReciveY And AreaY
            If TempInt Then
                If tempIndex <> UserIndex Then
                    If UserList(tempIndex).ConnIDValida Then
                        Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                        
                    End If
                End If
            End If
        End If
    Next LoopC

SendToUserAreaButindex_Err:

    Call sndData.Clear
    If (Err.Number <> 0) Then
366     Call LogError("modSendData.SendData en " & Erl & ". err: " & Err.Number & " " & Err.Description)
    End If
End Sub

Private Sub SendToDeadUserArea(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToDeadUserArea_Err

    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                'Dead and admins read
                If UserList(tempIndex).ConnIDValida And (UserList(tempIndex).flags.Muerto = 1 Or EsGM(tempIndex)) Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    
                End If
            End If
        End If
    Next LoopC

SendToDeadUserArea_Err:
    Call sndData.Clear
End Sub

Private Sub SendToUserGuildArea(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToUserGuildArea_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    If UserList(UserIndex).GuildIndex = 0 Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida And (UserList(tempIndex).GuildIndex = UserList(UserIndex).GuildIndex Or EsGM(tempIndex)) Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    
                End If
            End If
        End If
    Next LoopC
    
SendToUserGuildArea_Err:
    Call sndData.Clear
End Sub

Private Sub SendToUserPartyArea(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToUserPartyArea_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    If UserList(UserIndex).PartyIndex = 0 Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida And UserList(tempIndex).PartyIndex = UserList(UserIndex).PartyIndex Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    
                End If
            End If
        End If
    Next LoopC
    
SendToUserPartyArea_Err:
    Call sndData.Clear
End Sub

Private Sub SendToAdminsButConsejerosArea(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToAdminsButConsejerosArea_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida Then
                    If UserList(tempIndex).flags.Privilegios > PlayerType.Consejero Then
                        Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                        
                    End If
                End If
            End If
        End If
    Next LoopC

SendToAdminsButConsejerosArea_Err:
    Call sndData.Clear
    
End Sub

Private Sub SendToNpcArea(ByVal NpcIndex As Long, ByVal sndData As BinaryWriter)
    On Error GoTo SendToNpcArea_Err
    Dim LoopC As Long
    Dim TempInt As Integer
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = Npclist(NpcIndex).Pos.Map
    AreaX = Npclist(NpcIndex).AreasInfo.AreaPerteneceX
    AreaY = Npclist(NpcIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        TempInt = UserList(tempIndex).AreasInfo.AreaReciveX And AreaX
        If TempInt Then        'Esta en el area?
            TempInt = UserList(tempIndex).AreasInfo.AreaReciveY And AreaY
            If TempInt Then
                If UserList(tempIndex).ConnIDValida Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    
                End If
            End If
        End If
    Next LoopC

SendToNpcArea_Err:
    Call sndData.Clear
End Sub

Public Sub SendToAreaByPos(ByVal Map As Integer, ByVal AreaX As Integer, ByVal AreaY As Integer, ByVal sndData As BinaryWriter)

    On Error GoTo SendToAreaByPos_Err

    Dim LoopC As Long
    Dim TempInt As Integer
    Dim tempIndex As Integer

    AreaX = 2 ^ (AreaX \ 9)
    AreaY = 2 ^ (AreaY \ 9)

    If Not MapaValido(Map) Then Exit Sub
    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)
        TempInt = UserList(tempIndex).AreasInfo.AreaReciveX And AreaX
        If TempInt Then        'Esta en el area?
            TempInt = UserList(tempIndex).AreasInfo.AreaReciveY And AreaY
            If TempInt Then
                If UserList(tempIndex).ConnIDValida Then
                    Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    
                End If
            End If
        End If
    Next LoopC

SendToAreaByPos_Err:

    Call sndData.Clear
    
End Sub

Public Sub SendToMap(ByVal Map As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToMap_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).ConnIDValida Then
            Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
            
        End If
    Next LoopC
    
SendToMap_Err:

    Call sndData.Clear
    
End Sub

Public Sub SendToMapButIndex(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToMapButIndex_Err
    Dim LoopC As Long
    Dim Map As Integer
    Dim tempIndex As Integer

    Map = UserList(UserIndex).Pos.Map

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If tempIndex <> UserIndex And UserList(tempIndex).ConnIDValida Then
            Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
            
        End If
    Next LoopC
    

SendToMapButIndex_Err:
    Call sndData.Clear
End Sub

Private Sub SendToGMsAreaButRmsOrCounselors(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToGMsAreaButRmsOrCounselors_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        With UserList(tempIndex)
            If .AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
                If .AreasInfo.AreaReciveY And AreaY Then
                    If .ConnIDValida Then
                        If .flags.Privilegios > PlayerType.Consejero Then
                            Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                            
                        End If
                    End If
                End If
            End If
        End With
    Next LoopC
    
SendToGMsAreaButRmsOrCounselors_Err:
    Call sndData.Clear
End Sub

Private Sub SendToUsersAreaButGMs(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToUsersAreaButGMs_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida Then
                    If UserList(tempIndex).flags.Privilegios <= PlayerType.Consejero Then
                        Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                        
                    End If
                End If
            End If
        End If
    Next LoopC
    
SendToUsersAreaButGMs_Err:
    Call sndData.Clear
End Sub

Private Sub SendToUsersAndRmsAndCounselorsAreaButGMs(ByVal UserIndex As Integer, ByVal sndData As BinaryWriter)
    On Error GoTo SendToUsersAndRmsAndCounselorsAreaButGMs_Err
    Dim LoopC As Long
    Dim tempIndex As Integer

    Dim Map As Integer
    Dim AreaX As Integer
    Dim AreaY As Integer

    Map = UserList(UserIndex).Pos.Map
    AreaX = UserList(UserIndex).AreasInfo.AreaPerteneceX
    AreaY = UserList(UserIndex).AreasInfo.AreaPerteneceY

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).AreasInfo.AreaReciveX And AreaX Then        'Esta en el area?
            If UserList(tempIndex).AreasInfo.AreaReciveY And AreaY Then
                If UserList(tempIndex).ConnIDValida Then
                    If UserList(tempIndex).flags.Privilegios <= PlayerType.Consejero Then
                        Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                        
                    End If
                End If
            End If
        End If
    Next LoopC
    
SendToUsersAndRmsAndCounselorsAreaButGMs_Err:
    Call sndData.Clear
End Sub

Public Sub AlertarFaccionarios(ByVal UserIndex As Integer)

    Dim LoopC As Long
    Dim tempIndex As Integer
    Dim Map As Integer
    Dim Font As FontTypeNames

    If EsCaos(UserIndex) Then
        Font = FontTypeNames.FONTTYPE_CONSEJOCAOS
    Else
        Font = FontTypeNames.FONTTYPE_CONSEJO
    End If

    Map = UserList(UserIndex).Pos.Map

    If Not MapaValido(Map) Then Exit Sub

    For LoopC = 1 To ConnGroups(Map).CountEntrys
        tempIndex = ConnGroups(Map).UserEntrys(LoopC)

        If UserList(tempIndex).ConnIDValida Then
            If tempIndex <> UserIndex Then
                ' Solo se envia a los de la misma faccion
                If SameFaccion(UserIndex, tempIndex) Then
                    
                    'Call UserList(tempIndex).Connection.Write(sndData, eChannelReliable)
                    Call SendData(SendTarget.ToIndex, tempIndex, PrepareMessageConsoleMsg("Escuchas el llamado de un compañero que proviene del " & GetDireccion(UserIndex, tempIndex), Font))

                End If
            End If
        End If
    Next LoopC



End Sub
