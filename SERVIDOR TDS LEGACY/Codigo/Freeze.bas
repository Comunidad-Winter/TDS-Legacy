Attribute VB_Name = "Freeze"
Option Explicit

Private Type tUser
    ID As Integer
    lastPos As WorldPos
End Type

Private Type tTeam
    Freezing_Index As Integer
    Defrosting_Index As Integer
    User(1 To 8) As tUser
    Rounds_Win As Byte
    Frozen_Users As Byte
End Type

Private Type tPos
    y As Byte
    x As Byte
End Type

Private Type tEvent
    Active As Boolean
    Drop_Items As Boolean
    Rounds As Byte
    Teams(1 To 2) As tTeam
    Pos(1 To 2) As tPos
    MAP_Event As Byte
    Map_RoomWait As Byte
    X_Wait As Byte
    Y_Wait As Byte
    Users As Byte
    Inscription As Long
    Gold As Long
    Slot_Full As Boolean
    Count_Down As Integer
End Type

Private Freeze As tEvent

Public Sub Load()
    With Freeze
        .Pos(1).x = 50
        .Pos(1).y = 50
        .Pos(2).x = 60
        .Pos(2).y = 60
        .MAP_Event = 1
        .Map_RoomWait = 1
        .Y_Wait = 30
        .X_Wait = 30
    End With
End Sub

Public Sub Do_Event(ByVal Rounds As Byte, _
                    ByVal Drop_Items As Boolean, _
                    ByVal Gold As Long, _
                    ByVal Inscription As Long)
    With Freeze
        .Active = True
        .Rounds = Rounds
        .Drop_Items = Drop_Items
        .Users = 0
        .Gold = Gold
        .Inscription = Inscription
    End With
End Sub

Public Sub Enter_Event(ByVal ID As Integer)

    'If Can_Enter(ID) '----> Comprobaciones
    Dim ID_User As Byte  '#LosIDsInvasores
    Dim ID_Team As Byte  '#LosIDsInvasores
    ID_User = Slot_User
    ID_Team = Slot_Team
    With Freeze
        .Teams(ID_Team).User(ID_User).ID = ID
        .Teams(ID_Team).User(ID_User).lastPos = UserList(ID).Pos
        Call WarpUserChar(ID, .Map_RoomWait, .X_Wait, .Y_Wait, True)
        UserList(ID).Stats.GLD = UserList(ID).Stats.GLD - .Gold
        Call WriteUpdateGold(ID)
        If ID_Team = 2 And ID_User = 8 Then
            .Slot_Full = True
            Call Start_Event
        End If
    End With
End Sub

Private Sub Start_Event()
    With Freeze
        Call Choose_Representatives
        .Count_Down = 25
        Call GO_Arena
    End With
End Sub

Private Sub Choose_Representatives()
    With Freeze
        Dim LoopC As Long
        Dim loopX As Long
        Dim ID As Long
        For LoopC = 1 To 2
            .Teams(LoopC).Defrosting_Index = RandomNumber(1, 8)
            .Teams(LoopC).Freezing_Index = RandomNumber(1, 8)
            If .Teams(LoopC).Freezing_Index = .Teams(LoopC).Defrosting_Index Then
                .Teams(LoopC).Freezing_Index = .Teams(LoopC).Defrosting_Index + 1
                If .Teams(LoopC).Freezing_Index > 8 Then .Teams(LoopC).Freezing_Index = .Teams(LoopC).Defrosting_Index - 2
                If .Teams(LoopC).Freezing_Index < 1 Then .Teams(LoopC).Freezing_Index = .Teams(LoopC).Defrosting_Index + 2
            End If
        Next LoopC
    End With
End Sub

Public Sub Touch(ByVal ID As Integer, ByVal Touch_Index As Integer)
    
    Dim Other_Team As Byte
    
    With UserList(ID)
        If .Freeze.ID_Team_Array > 0 Then 'Está en evento?
            Other_Team = fOther_Team(.Freeze.ID_Team_Array)
            If Freeze.Teams(.Freeze.ID_Team_Array).Freezing_Index = ID Then  'Si es el que congela
                If .Freeze.ID_Team_Array = UserList(Touch_Index).Freeze.ID_Team_Array Then Exit Sub 'Mismo equipo
                If Freeze.Teams(Other_Team).Defrosting_Index = Touch_Index Then Exit Sub 'Si es el descongelador del otro equipo no lo puede congelar
                If UserList(Touch_Index).Freeze.Freezing = True Then Exit Sub
                UserList(Touch_Index).Freeze.Freezing = True
                Freeze.Teams(.Freeze.ID_Team_Array).Frozen_Users = Freeze.Teams(.Freeze.ID_Team_Array).Frozen_Users + 1
                If Freeze.Teams(.Freeze.ID_Team_Array).Frozen_Users = 7 Then _
                    Call Win_Round(.Freeze.ID_Team_Array)
            End If
            If Freeze.Teams(.Freeze.ID_Team_Array).Defrosting_Index = ID Then
                If Not .Freeze.ID_Team_Array = UserList(Touch_Index).Freeze.ID_Team_Array Then Exit Sub 'No Mismo equipo
                If UserList(Touch_Index).Freeze.Freezing = False Then Exit Sub
                UserList(Touch_Index).Freeze.Freezing = False
                Freeze.Teams(.Freeze.ID_Team_Array).Frozen_Users = Freeze.Teams(.Freeze.ID_Team_Array).Frozen_Users - 1
            End If
        End If
     End With
End Sub

Private Sub Win_Round(ByVal Win_Team As Byte)
    Dim Loser_Team As Byte
    Call Choose_Representatives
    Call GO_Arena
    With Freeze
        If .Teams(Win_Team).Rounds_Win = .Rounds Then
            Loser_Team = fOther_Team(Win_Team)
            Call Win_Freeze(Win_Team, Loser_Team)
        End If
    End With
End Sub

Private Function fOther_Team(ByVal Team As Byte)
    If Team = 1 Then fOther_Team = 2
    If Team = 2 Then fOther_Team = 1
End Function

Private Sub Win_Freeze(ByVal Win_Team As Byte, ByVal Loser_Team As Byte)
    Dim Win_ID As Integer
    Dim Loser_ID As Integer
    Dim LoopC As Long
    With Freeze
        For LoopC = 1 To 8
            Win_ID = .Teams(Win_Team).User(LoopC).ID
            Loser_ID = .Teams(Loser_Team).User(LoopC).ID
            UserList(Win_ID).Stats.GLD = UserList(Win_ID).Stats.GLD + .Gold
            UserList(Win_ID).Freeze.Freezing = False
            UserList(Win_ID).Freeze.ID_Team_Array = 0
            UserList(Win_ID).Freeze.ID_User_Array = 0
            UserList(Loser_ID).Freeze.Freezing = False
            UserList(Loser_ID).Freeze.ID_Team_Array = 0
            UserList(Loser_ID).Freeze.ID_User_Array = 0
            Call WarpUserChar(Win_ID, .Teams(Win_Team).User(LoopC).lastPos.Map, .Teams(Win_Team).User(LoopC).lastPos.x, .Teams(Win_Team).User(LoopC).lastPos.y, True)
            Call WarpUserChar(Loser_ID, .Teams(Loser_Team).User(LoopC).lastPos.Map, .Teams(Loser_Team).User(LoopC).lastPos.x, .Teams(Loser_Team).User(LoopC).lastPos.y, True)
            Call WriteUpdateGold(Win_ID)
            .Teams(Win_ID).User(LoopC).ID = 0
            .Teams(Loser_ID).User(LoopC).ID = 0
        Next LoopC
        .Teams(Win_ID).Defrosting_Index = 0
        .Teams(Loser_ID).Defrosting_Index = 0
        .Teams(Win_ID).Freezing_Index = 0
        .Teams(Loser_ID).Freezing_Index = 0
        .Teams(Win_ID).Frozen_Users = 0
        .Teams(Loser_ID).Frozen_Users = 0
        .Teams(Win_ID).Rounds_Win = 0
        .Teams(Loser_ID).Rounds_Win = 0
        .Active = False
        .Count_Down = 0
        .Gold = 0
        .Inscription = 0
        .Rounds = 0
        .Slot_Full = False
        .Users = 0
    End With
End Sub

Private Sub GO_Arena()
    Dim LoopC As Long
    Dim loopX As Long
    
    With Freeze
        For LoopC = 1 To 2
            For loopX = 1 To 8
                Call WarpUserChar(.Teams(LoopC).User(LoopC).ID, .MAP_Event, .Pos(LoopC).x, .Pos(LoopC).y, False)
            Next loopX
        Next LoopC
    End With
End Sub

Private Function Slot_User() As Byte
     With Freeze
        Dim LoopC As Long
        Dim loopX As Long
        For LoopC = 1 To 2
            For loopX = 1 To 8
                If .Teams(LoopC).User(loopX).ID = 0 Then
                    Slot_User = loopX
                    Exit Function
                End If
            Next loopX
        Next LoopC
     End With
End Function

Private Function Slot_Team() As Byte
     With Freeze
        Dim LoopC As Long
        For LoopC = 1 To 2
            If .Teams(LoopC).User(8).ID = 0 Then
                Slot_Team = LoopC
                Exit Function
            End If
        Next LoopC
     End With
End Function

Public Sub Count()
    Dim LoopC As Long
    Dim loopX As Long
        
    With Freeze
        For LoopC = 1 To 2
            For loopX = 1 To 8
                If .Count_Down = 0 Then
                    .Count_Down = -1
                    If .Active = True Then
                        Call WriteConsoleMsg(.Teams(LoopC).User(loopX).ID, "Congelado> Conteo> Ya!!", FontTypeNames.FONTTYPE_GUILD)
                    End If
                End If
                If .Count_Down > 0 Then
                    If .Active = True Then
                        Call WriteConsoleMsg(.Teams(LoopC).User(loopX).ID, "Congelado> Conteo> " & .Count_Down, FontTypeNames.FONTTYPE_GUILD)
                    End If
                    .Count_Down = .Count_Down - 1
                End If
            Next loopX
        Next LoopC
    End With
End Sub


