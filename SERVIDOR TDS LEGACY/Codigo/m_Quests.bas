Attribute VB_Name = "m_Quests"
Option Explicit
Public Const MAXUSERQUESTS As Integer = 15

Public Function TieneQuest(ByVal UserIndex As Integer, ByVal QuestNumber As Integer) As Byte
    Dim i As Long
    For i = 1 To MAXUSERQUESTS
        If UserList(UserIndex).QuestStats.Quests(i).QuestIndex = QuestNumber Then
            TieneQuest = i
            Exit Function
        End If
    Next i
    TieneQuest = 0
End Function

Public Function FreeQuestSlot(ByVal UserIndex As Integer) As Byte
    Dim i As Long
    For i = 1 To MAXUSERQUESTS
        If UserList(UserIndex).QuestStats.Quests(i).QuestIndex = 0 Then
            FreeQuestSlot = i
            Exit Function
        End If
    Next i
    FreeQuestSlot = 0
End Function

Public Sub FinishQuest(ByVal UserIndex As Integer, ByVal QuestIndex As Integer, ByVal QuestSlot As Byte)
    Dim i As Long
    Dim InvSlotsLibres As Byte
    Dim NpcIndex As Integer
    NpcIndex = UserList(UserIndex).flags.TargetNPC
    With QuestList(QuestIndex)
        If .RequiredOBJs > 0 Then
            For i = 1 To .RequiredOBJs
                If Not TieneObjetos(.RequiredOBJ(i).ObjIndex, .RequiredOBJ(i).Amount, UserIndex) Then
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No has conseguido todos los objetos que te he pedido.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
                    Exit Sub
                End If
            Next i
        End If
        If .RequiredNPCs > 0 Then
            For i = 1 To .RequiredNPCs
                If .RequiredNPC(i).Amount > UserList(UserIndex).QuestStats.Quests(QuestSlot).NPCsKilled(i) Then
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No has matado todas las criaturas que te he pedido.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
                    Exit Sub
                End If
            Next i
        End If
        If .RewardOBJs > 0 Then
            For i = 1 To MAX_INVENTORY_SLOTS
                If UserList(UserIndex).Invent.Object(i).ObjIndex = 0 Then InvSlotsLibres = InvSlotsLibres + 1
            Next i
            If InvSlotsLibres < .RewardOBJs Then
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No tienes suficiente espacio en el inventario para recibir la recompensa. Vuelve cuando hayas hecho mas espacio.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
                Exit Sub
            End If
        End If
        Call WriteConsoleMsg(UserIndex, "Has completado la mision " & Chr(34) & QuestList(QuestIndex).Nombre & Chr(34) & "!", FontTypeNames.FONTTYPE_INFO)
        If .RequiredOBJs Then
            For i = 1 To .RequiredOBJs
                Call QuitarObjetos(.RequiredOBJ(i).ObjIndex, .RequiredOBJ(i).Amount, UserIndex)
            Next i
        End If
        If .RewardEXP Then
            UserList(UserIndex).Stats.Exp = UserList(UserIndex).Stats.Exp + .RewardEXP
            Call WriteConsoleMsg(UserIndex, "Has ganado " & .RewardEXP & " puntos de experiencia como recompensa.", FontTypeNames.FONTTYPE_INFO)
        End If
        If .RewardGLD Then
            UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD + .RewardGLD
            Call WriteConsoleMsg(UserIndex, "Has ganado " & .RewardGLD & " monedas de oro como recompensa.", FontTypeNames.FONTTYPE_INFO)
        End If
        If .RewardOBJs > 0 Then
            For i = 1 To .RewardOBJs
                If .RewardOBJ(i).Amount Then
                    Call MeterItemEnInventario(UserIndex, .RewardOBJ(i))
                    Call WriteConsoleMsg(UserIndex, "Has recibido " & QuestList(QuestIndex).RewardOBJ(i).Amount & " " & ObjData(QuestList(QuestIndex).RewardOBJ(i).ObjIndex).Name & " como recompensa.", FontTypeNames.FONTTYPE_INFO)
                End If
            Next i
        End If

        Call CheckUserLevel(UserIndex)
        Call UpdateUserInv(True, UserIndex, 0)
        Call CleanQuestSlot(UserIndex, QuestSlot)
        Call ArrangeUserQuests(UserIndex)
        Call AddDoneQuest(UserIndex, QuestIndex)

        Call LogQuest(UserList(UserIndex).Name & " terminó la quest " & QuestIndex & " - ganó puntos: " & .RewardPoints)

    End With
End Sub

Public Sub AddDoneQuest(ByVal UserIndex As Integer, ByVal QuestIndex As Integer)
    With UserList(UserIndex).QuestStats
        .NumQuestsDone = .NumQuestsDone + 1
        ReDim Preserve .QuestsDone(1 To .NumQuestsDone)
        .QuestsDone(.NumQuestsDone) = QuestIndex
    End With
End Sub

Public Function UserDoneQuest(ByVal UserIndex As Integer, ByVal QuestIndex As Integer) As Boolean
    Dim i As Long
    With UserList(UserIndex).QuestStats
        If .NumQuestsDone Then
            For i = 1 To .NumQuestsDone
                If .QuestsDone(i) = QuestIndex Then
                    UserDoneQuest = True
                    Exit Function
                End If
            Next i
        End If
    End With
    UserDoneQuest = False
End Function

Public Sub CleanQuestSlot(ByVal UserIndex As Integer, ByVal QuestSlot As Integer)
    Dim i As Long
    With UserList(UserIndex).QuestStats.Quests(QuestSlot)
        If .QuestIndex Then
            If QuestList(.QuestIndex).RequiredNPCs Then
                For i = 1 To QuestList(.QuestIndex).RequiredNPCs
                    .NPCsKilled(i) = 0
                Next i
            End If

            If QuestList(.QuestIndex).RequiredKills Then
                .UsersKilled = 0
            End If

        End If
        .QuestIndex = 0
    End With
End Sub

Public Sub ResetQuestStats(ByVal UserIndex As Integer)
    Dim i As Long
    For i = 1 To MAXUSERQUESTS
        Call CleanQuestSlot(UserIndex, i)
    Next i
    With UserList(UserIndex).QuestStats
        .NumQuestsDone = 0
        Erase .QuestsDone
    End With
End Sub

Public Sub LoadQuests()

    On Error GoTo ErrorHandler

    Dim Reader As clsIniManager
    Dim NumQuests As Integer
    Dim TmpStr As String

    Set Reader = New clsIniManager
    Call Reader.Initialize(DatPath & "QUESTS.DAT")

    NumQuests = Reader.GetValue("INIT", "NumQuests")

    If NumQuests > 0 Then
        ReDim QuestList(1 To NumQuests)

        Dim i As Long
        Dim j As Long

        For i = 1 To NumQuests
            With QuestList(i)
                .Nombre = Reader.GetValue("QUEST" & i, "Nombre")
                .Desc = Reader.GetValue("QUEST" & i, "Desc")
                .RequiredLevel = val(Reader.GetValue("QUEST" & i, "RequiredLevel"))
                .RequiredKills = val(Reader.GetValue("QUEST" & i, "RequiredKills"))

                .RequiredFaccion = val(Reader.GetValue("QUEST" & i, "RequiredFaccion"))
                .RequiredFaccion_Rango = val(Reader.GetValue("QUEST" & i, "RequiredFaccion_Rango"))

                'CARGAMOS OBJETOS REQUERIDOS
                .RequiredOBJs = val(Reader.GetValue("QUEST" & i, "RequiredOBJs"))

                If .RequiredOBJs > 0 Then
                    ReDim .RequiredOBJ(1 To .RequiredOBJs)
                    For j = 1 To .RequiredOBJs
                        TmpStr = Reader.GetValue("QUEST" & i, "RequiredOBJ" & j)

                        .RequiredOBJ(j).ObjIndex = val(ReadField(1, TmpStr, 45))
                        .RequiredOBJ(j).Amount = val(ReadField(2, TmpStr, 45))
                    Next j
                End If

                'CARGAMOS NPCS REQUERIDOS
                .RequiredNPCs = val(Reader.GetValue("QUEST" & i, "RequiredNPCs"))

                If .RequiredNPCs > 0 Then
                    ReDim .RequiredNPC(1 To .RequiredNPCs)
                    For j = 1 To .RequiredNPCs
                        TmpStr = Reader.GetValue("QUEST" & i, "RequiredNPC" & j)

                        .RequiredNPC(j).NpcIndex = val(ReadField(1, TmpStr, 45))
                        .RequiredNPC(j).Amount = val(ReadField(2, TmpStr, 45))
                    Next j
                End If

                .RewardGLD = val(Reader.GetValue("QUEST" & i, "RewardGLD"))
                .RewardEXP = val(Reader.GetValue("QUEST" & i, "RewardEXP"))
                .RewardPoints = val(Reader.GetValue("QUEST" & i, "RewardPoints"))

                .AvisaConsola = val(Reader.GetValue("QUEST" & i, "AvisaConsola"))
                If .AvisaConsola > 0 Then .AvisaConsolaMsg = Reader.GetValue("QUEST" & i, "AvisaConsolaMsg")

                'CARGAMOS OBJETOS DE RECOMPENSA
                .RewardOBJs = val(Reader.GetValue("QUEST" & i, "RewardOBJs"))
                If .RewardOBJs > 0 Then
                    ReDim .RewardOBJ(1 To .RewardOBJs)
                    For j = 1 To .RewardOBJs
                        TmpStr = Reader.GetValue("QUEST" & i, "RewardOBJ" & j)

                        .RewardOBJ(j).ObjIndex = val(ReadField(1, TmpStr, 45))
                        .RewardOBJ(j).Amount = val(ReadField(2, TmpStr, 45))
                    Next j
                End If
            End With
        Next i
    End If

    Set Reader = Nothing
    Exit Sub

ErrorHandler:

    MsgBox "Error cargando el archivo QUESTS.DAT.", vbOKOnly + vbCritical

End Sub

Public Sub LoadQuestStats(ByVal UserIndex As Integer, ByRef UserFile As clsIniManager)

    Dim i As Long
    Dim j As Long
    Dim TmpStr As String

    For i = 1 To MAXUSERQUESTS
        With UserList(UserIndex).QuestStats.Quests(i)
            TmpStr = UserFile.GetValue("QUESTS", "Q" & i)
            If LenB(TmpStr) <> 0 Then
                .QuestIndex = val(ReadField(1, TmpStr, 45))
                If .QuestIndex Then
                    If QuestList(.QuestIndex).RequiredNPCs Then
                        ReDim .NPCsKilled(1 To QuestList(.QuestIndex).RequiredNPCs)
                        For j = 1 To QuestList(.QuestIndex).RequiredNPCs
                            .NPCsKilled(j) = val(ReadField(j + 1, TmpStr, 45))
                        Next j
                    End If
                End If
            End If
        End With
    Next i

    With UserList(UserIndex).QuestStats
        TmpStr = UserFile.GetValue("QUESTS", "QuestsDone")
        If LenB(TmpStr) <> 0 Then
            .NumQuestsDone = val(ReadField(1, TmpStr, 45))
            If .NumQuestsDone Then
                ReDim .QuestsDone(1 To .NumQuestsDone)
                For i = 1 To .NumQuestsDone
                    .QuestsDone(i) = val(ReadField(i + 1, TmpStr, 45))
                Next i
            End If
        End If
    End With

End Sub

Public Sub SaveQuestStats(ByVal UserIndex As Integer, ByRef UserFile As clsIniManager)
    Dim i As Long
    Dim j As Long
    Dim TmpStr As String
    For i = 1 To MAXUSERQUESTS
        With UserList(UserIndex).QuestStats.Quests(i)
            TmpStr = .QuestIndex
            If .QuestIndex Then
                If QuestList(.QuestIndex).RequiredNPCs Then
                    For j = 1 To QuestList(.QuestIndex).RequiredNPCs
                        TmpStr = TmpStr & "-" & .NPCsKilled(j)
                    Next j
                End If
            End If
            Call UserFile.ChangeValue("QUESTS", "Q" & i, TmpStr)
        End With
    Next i

    With UserList(UserIndex).QuestStats
        TmpStr = .NumQuestsDone
        If .NumQuestsDone Then
            For i = 1 To .NumQuestsDone
                TmpStr = TmpStr & "-" & .QuestsDone(i)
            Next i
        End If
        Call UserFile.ChangeValue("QUESTS", "QuestsDone", TmpStr)
    End With

    Exit Sub
Errhandler:

End Sub

Public Sub ArrangeUserQuests(ByVal UserIndex As Integer)
    On Error GoTo Errhandler
    Dim i As Long
    Dim j As Long
    With UserList(UserIndex).QuestStats
        For i = 1 To MAXUSERQUESTS - 1
            If .Quests(i).QuestIndex = 0 Then
                For j = i + 1 To MAXUSERQUESTS
                    If .Quests(j).QuestIndex Then
                        .Quests(i) = .Quests(j)
                        Call CleanQuestSlot(UserIndex, j)
                        Exit For
                    End If
                Next j
            End If
        Next i
    End With

    Exit Sub
Errhandler:
End Sub

Private Sub LogQuest(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\Quests.log" For Append Shared As #nFile
    Print #nFile, Date$ & " " & Time$ & " " & Desc
    Close #nFile

    Exit Sub

Errhandler:

End Sub
