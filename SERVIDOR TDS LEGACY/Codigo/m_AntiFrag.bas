Attribute VB_Name = "m_AntiFrag"
Option Explicit

Public Const MAX_CONTROL_FRAGS As Byte = 4

Public Type tAntiFrags
    serialHD As Long
    Time As Byte
End Type

Public Sub LoadUserAntiFrags(ByVal UI As Integer, ByRef UserFile As clsIniManager)

    Dim LoopC As Long
    Dim temp As String

    For LoopC = 0 To MAX_CONTROL_FRAGS
        temp = UserFile.GetValue("ANTIFRAGS", "FRAG" & LoopC)

        If Len(temp) > 0 Then
            With UserList(UI).AntiFrags(LoopC)
                .serialHD = val(ReadField(1, temp, Asc("@")))
                .Time = val(ReadField(2, temp, Asc("@")))
            End With
        End If
    Next LoopC

    UserList(UI).IP_LastKill = UserFile.GetValue("ANTIFRAGS", "IP_LastKill")

End Sub

Public Sub SaveUserAntiFrags(ByVal UI As Integer, ByRef Manager As clsIniManager)

    Dim LoopC As Long

    For LoopC = 0 To MAX_CONTROL_FRAGS
        With UserList(UI).AntiFrags(LoopC)
            Call Manager.ChangeValue("ANTIFRAGS", "FRAG" & LoopC, .serialHD & "@" & .Time)
        End With
    Next LoopC

    Call Manager.ChangeValue("ANTIFRAGS", "IP_LastKill", UserList(UI).IP_LastKill)

End Sub

Public Sub ResetAntiFrags(ByVal UI As Integer)

    Dim LoopC As Long

    For LoopC = 0 To MAX_CONTROL_FRAGS
        With UserList(UI).AntiFrags(LoopC)
            .Time = 0
            .serialHD = 0
        End With
    Next LoopC

    UserList(UI).IP_LastKill = vbNullString

End Sub

Private Function RepeatAntiFrags(ByVal UI As Integer, ByVal VictimHD As Long) As Byte

    Dim LoopC As Long

    For LoopC = 0 To MAX_CONTROL_FRAGS
        With UserList(UI).AntiFrags(LoopC)
            If .serialHD = VictimHD Then
                RepeatAntiFrags = LoopC
                Exit Function
            End If

            If RepeatAntiFrags < 1 Then
                If .Time < 1 Then
                    RepeatAntiFrags = LoopC
                End If
            End If
        End With
    Next LoopC

End Function

Public Function CheckAntiFrags(ByVal UI As Integer, ByVal VictimHD As Long) As Byte

    Dim Slot As Byte
    Slot = RepeatAntiFrags(UI, VictimHD)

    If Slot < 1 Then Exit Function

    With UserList(UI).AntiFrags(Slot)
        If .serialHD = VictimHD Then Exit Function

        .Time = 8
        .serialHD = VictimHD
    End With

    CheckAntiFrags = 1

End Function

Public Sub PassMinuteAntiFrags(ByVal UI As Integer)

    Dim LoopC As Long

    For LoopC = 0 To MAX_CONTROL_FRAGS
        With UserList(UI).AntiFrags(LoopC)
            If .Time > 0 Then
                .Time = .Time - 1

                If .Time < 1 Then
                    .Time = 0
                    .serialHD = 0
                End If
            End If
        End With
    Next LoopC

End Sub


