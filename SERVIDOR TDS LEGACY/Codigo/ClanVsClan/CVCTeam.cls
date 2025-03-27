VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVCTeam"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Type tUser
    UI As Integer
    Muerto As Boolean
End Type

Private p_GuildIndex As Integer
Private p_NumUsers As Byte
Private p_users() As tUser
Private p_cantusers As Integer

Private p_SelectedPlayers As String
Private p_RoundsWon As Byte
Private p_SelectionConfirmed As Boolean
Private p_CanStart As Boolean
Private p_usersReady() As Boolean

Public Sub SetUserReady(ByVal UserIndex As Integer, ByVal isReady As Boolean)
    p_usersReady(UserIndex) = isReady
End Sub

Public Function IsUserReady(ByVal UserIndex As Integer) As Boolean
    IsUserReady = p_usersReady(UserIndex)
End Function

Public Function GetUser(ByVal ID As Integer) As Integer
    GetUser = p_users(ID).UI
End Function

Public Property Get GuildIndex() As Integer
    GuildIndex = p_GuildIndex
End Property

Public Property Let GuildIndex(ByVal value As Integer)
    p_GuildIndex = value
End Property

Public Property Get NumUsers() As Byte
    NumUsers = p_cantusers
End Property

Public Property Let NumUsers(ByVal value As Byte)
    p_cantusers = value
End Property

Public Property Get RoundsWon() As Byte
    RoundsWon = p_RoundsWon
End Property

Public Property Let RoundsWon(ByVal value As Byte)
    p_RoundsWon = value
End Property

Public Property Get SelectionConfirmed() As Boolean
    SelectionConfirmed = p_SelectionConfirmed
End Property

Public Property Let SelectionConfirmed(ByVal value As Boolean)
    p_SelectionConfirmed = value
End Property

Public Property Get CanStart() As Boolean
    CanStart = p_CanStart
End Property

Public Property Let CanStart(ByVal value As Boolean)
    p_CanStart = value
End Property

Public Function SelectPlayers(ByVal LeaderIndex As Integer, ByVal Players As String, ByVal maxUsers As Byte, ByRef Response As String) As Boolean
    
    If Players = p_SelectedPlayers Then Exit Function
    
    Dim arrPlayers() As String, arrPlayersIndex() As Integer
    arrPlayers = Split(Players, ",")
    
    If UBound(arrPlayers) = -1 Then
        Response = "Se ha actualizado la lista."
        SelectPlayers = True
        p_SelectedPlayers = ""
        Exit Function
    End If
    
    ReDim arrPlayersIndex(UBound(arrPlayers))
    
    If UBound(arrPlayers) + 1 <= maxUsers Then
        p_SelectedPlayers = Players
                
        Dim i As Long, invalidPlayer As Boolean
        
        For i = LBound(arrPlayers) To UBound(arrPlayers)
            arrPlayersIndex(i) = NameIndex(arrPlayers(i))
            
            invalidPlayer = True
            
            If arrPlayersIndex(i) Then
                If UserList(arrPlayersIndex(i)).GuildIndex = p_GuildIndex Then
                    If (UserList(arrPlayersIndex(i)).InCVCID = 0 Or arrPlayersIndex(i) = LeaderIndex) And UserList(arrPlayersIndex(i)).EnEvento = False And UserList(arrPlayersIndex(i)).InBotID = 0 And UserList(arrPlayersIndex(i)).mReto.Reto_Index = 0 And UserList(arrPlayersIndex(i)).sReto.Reto_Index = 0 And UserList(arrPlayersIndex(i)).Counters.Pena = 0 Then
                        If UserList(arrPlayersIndex(i)).flags.Comerciando = False And UserList(arrPlayersIndex(i)).flags.Muerto = False Then
                            invalidPlayer = False
                        Else
                            Response = Response & arrPlayers(i) & " está comerciando o está muerto!" & vbCrLf
                        End If
                    Else
                        Response = Response & arrPlayers(i) & " se encuentra en un evento, reto o está en cárcel!" & vbCrLf
                    End If
                Else
                    Response = Response & arrPlayers(i) & " no pertenece a tu clan." & vbCrLf
                End If
            Else
                Response = Response & arrPlayers(i) & " se encuentra desconectado." & vbCrLf
            End If
        Next i
        
        ' @@ Todo ok, let's go!
        If invalidPlayer = False Then
        
            For i = LBound(arrPlayers) To UBound(arrPlayers)
                Call AddUser(arrPlayersIndex(i))
                UserList(arrPlayersIndex(i)).InCVCID = UserList(LeaderIndex).InCVCID
            Next i
            
            SelectPlayers = True
            Response = "Miembros seleccionados: " & Players
        End If
    Else
        Response = "El máximo de miembros en éste reto Clan vs Clan es de " & maxUsers
        If Len(p_SelectedPlayers) Then
            'p_SelectedPlayers = ""
        End If
        
    End If
End Function

Public Property Get selectedPlayers() As String
    selectedPlayers = p_SelectedPlayers
End Property

Public Sub ConfirmSelection()
    p_SelectionConfirmed = True
End Sub

Public Sub AddUser(ByVal UserIndex As Integer)
    Dim i As Long
    
    If p_cantusers = 0 Then
        p_cantusers = 1
        ReDim p_users(1 To 5)
        p_users(1).UI = UserIndex
    Else
        For i = LBound(p_users) To UBound(p_users)
        
            If p_users(i).UI = UserIndex Then Exit Sub
            
            If p_users(i).UI = 0 Then
                p_users(i).UI = UserIndex
                p_cantusers = p_cantusers + 1
                Exit Sub
            End If
        Next i
        
        p_cantusers = p_cantusers + 1
        ReDim Preserve p_users(1 To UBound(p_users) + 5)
        p_users(UBound(p_users)).UI = UserIndex
    End If
    
    
End Sub

Public Sub MuereUser(ByVal UserIndex As Integer)
    Dim i As Long
    For i = LBound(p_users) To UBound(p_users)
        If p_users(i).UI = UserIndex Then
            p_users(i).Muerto = True
            Exit For
        End If
    Next i
End Sub

Public Sub ReviveUser(ByVal UserIndex As Integer)
    Dim i As Long
    For i = LBound(p_users) To UBound(p_users)
        If p_users(i).UI = UserIndex Then
            p_users(i).Muerto = False
            Exit For
        End If
    Next i
End Sub

Public Sub DeleteUser(ByVal UserIndex As Integer)
    Dim i As Long
    For i = LBound(p_users) To UBound(p_users)
        If p_users(i).UI = UserIndex Then
            p_users(i).UI = 0
            p_cantusers = p_cantusers - 1
            Exit Sub
        End If
    Next i
    CompactUsers
End Sub

Public Sub CompactUsers()
    Dim tempUsers() As tUser
    Dim i As Long, j As Long
    ReDim tempUsers(1 To p_cantusers)
    j = 1
    For i = LBound(p_users) To UBound(p_users)
        If p_users(i).UI <> 0 Then
            tempUsers(j) = p_users(i)
            j = j + 1
        End If
    Next i
    ReDim p_users(1 To p_cantusers)
    For i = 1 To p_cantusers
        p_users(i) = tempUsers(i)
    Next i
End Sub

Public Function GetNumDeadUsers() As Integer
    Dim i As Long
    Dim countDead As Integer
    countDead = 0
    
    For i = LBound(p_users) To UBound(p_users)
        If Not p_users(i).UI = 0 Then
            If p_users(i).Muerto Then
                countDead = countDead + 1
            End If
        End If
    Next i
    GetNumDeadUsers = countDead
End Function

Public Sub InitializeUsers(ByVal maxUsers As Byte)
    ReDim p_users(1 To maxUsers)
    ReDim p_usersReady(1 To maxUsers)
End Sub
