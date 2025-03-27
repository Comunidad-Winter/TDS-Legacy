VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTeam"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

''AUTHOR: SANTIAGO (NHELK)
''DATE: 13/11/16
''Class module for teams manage. Each team should be declared as this module.

Private Type tUsers
    UI As Integer
    lastPos As WorldPos
End Type

Private Usuarios() As tUsers
Private NumUsers As Byte
Private UsersOn As Byte
Private Points As Byte
 
Public Property Get Usuario(ByVal Index As Byte) As Integer
    If Index <= 0 Or Index > NumUsers Then Exit Property
    Usuario = Usuarios(Index).UI
End Property

Public Property Get GetPoints() As Byte
    GetPoints = Points
End Property

Public Property Get UsersOnline() As Byte
    UsersOnline = UsersOn
End Property

Public Property Get maxTeam() As Byte
    maxTeam = NumUsers
End Property

Public Sub AddPoint()
    Points = Points + 1
End Sub

Public Sub MinusPoint()
    Points = Points - 1
End Sub

Public Sub PauseToggleTeam()
    Dim X As Long
    For X = 1 To NumUsers
        If Usuarios(X).UI <> 0 Then
            Call WritePauseToggle(Usuarios(X).UI)
        End If
    Next X
End Sub

Public Sub MessageTeam(ByVal Msg As String, ByVal ft As FontTypeNames)
    Dim X As Long
    For X = 1 To NumUsers
        If Usuarios(X).UI <> 0 Then
            Call WriteConsoleMsg(Usuarios(X).UI, Msg, ft)
        End If
    Next X
End Sub

Public Sub WarpTeam(ByVal map As Integer, ByVal X As Byte, ByVal Y As Byte, Optional ByVal toLastPos As Boolean = False)
    Dim z As Long
    For z = 1 To NumUsers
        If Usuarios(z).UI <> 0 Then
            If toLastPos = True Then
                Call WarpUserChar(Usuarios(z).UI, Usuarios(z).lastPos.map, Usuarios(z).lastPos.X, Usuarios(z).lastPos.Y, True)
            Else
                Call WarpUserChar(Usuarios(z).UI, map, X, Y, True)
            End If
        End If
    Next z
End Sub

Public Sub Initialize(ByVal TeamUsers As Byte)
    ReDim Usuarios(1 To TeamUsers) As tUsers
    UsersOn = 0
    NumUsers = TeamUsers
End Sub

Public Sub DeleteTeam(Optional ByVal WarpToLastPos As Boolean = True)
    Dim z As Long
    For z = 1 To NumUsers
        If Usuarios(z).UI <> 0 Then
            If WarpToLastPos = True Then
                Call WarpUserChar(Usuarios(z).UI, Usuarios(z).lastPos.map, Usuarios(z).lastPos.X, Usuarios(z).lastPos.Y, True)
            End If
            Usuarios(z).UI = 0
        End If
    Next z
End Sub

Public Sub DeleteUser(ByVal UI As Integer, Optional ByVal WarpToInitialPos As Boolean = True)
    Dim eIndex As Byte
    eIndex = UiToIndex(UI)
    If eIndex = 0 Then Exit Sub
    If WarpToInitialPos = True Then
        Call WarpUserChar(UI, Usuarios(eIndex).lastPos.map, Usuarios(eIndex).lastPos.X, Usuarios(eIndex).lastPos.Y, True)
    End If
    Usuarios(eIndex).UI = 0
    UsersOn = UsersOn - 1
End Sub

Public Function AddUser(ByVal UI As Integer) As Boolean
    ''Checks must be done before the call of this routine
    Dim nSlot As Byte
    nSlot = fSlot
    If nSlot = 0 Then
        AddUser = False
        Exit Function
    End If
    With Usuarios(nSlot)
        .UI = UI
        .lastPos = UserList(UI).Pos
    End With
    UsersOn = UsersOn + 1
End Function

Private Function UiToIndex(ByVal UI As Integer) As Byte
    Dim X As Long
    For X = 1 To NumUsers
        If Usuarios(X).UI = UI Then
            UiToIndex = X
            Exit Function
        End If
    Next X
End Function

Private Function fSlot() As Byte
    Dim X As Long
    If UsersOn = NumUsers Then
        fSlot = 0
        Exit Function
    End If
    For X = 1 To NumUsers
        With Usuarios(X)
            If .UI = 0 Then fSlot = X: Exit Function
        End With
    Next X
End Function
