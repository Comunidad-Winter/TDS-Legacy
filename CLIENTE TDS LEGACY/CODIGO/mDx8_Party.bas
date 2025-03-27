Attribute VB_Name = "mDx8_Party"
Option Explicit
Private Type c_PartyMember
    Name As String
    ExpParty As Long
End Type
Private Const MAX_MEMBERS_PARTY As Byte = 5
Public CountMembers As Byte
Public PartyMembers(1 To MAX_MEMBERS_PARTY) As c_PartyMember
Public Sub Reset_Party()
    Dim I As Long
    For I = 1 To MAX_MEMBERS_PARTY
        PartyMembers(I).ExpParty = 0
        PartyMembers(I).Name = vbNullString
    Next I
End Sub
Public Sub Set_PartyMember(ByVal Member As Byte, ByVal Name As String, ByVal ExpParty As Long)
    If Member < 1 Or Member > MAX_MEMBERS_PARTY Then Exit Sub
    PartyMembers(Member).Name = Name
    PartyMembers(Member).ExpParty = ExpParty
End Sub
Public Sub Kick_PartyMember(ByVal Member As Byte)
    If Member < 1 Or Member > MAX_MEMBERS_PARTY Then Exit Sub
    PartyMembers(Member).Name = vbNullString
    PartyMembers(Member).ExpParty = 0
    Member = Member - 1
    frmParty.Label5(Member).Caption = vbNullString
    frmParty.Label7(Member).Caption = vbNullString
    frmParty.Label8(Member).Caption = vbNullString
End Sub
