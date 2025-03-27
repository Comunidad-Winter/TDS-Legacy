Attribute VB_Name = "Statistics"
'**************************************************************
' modStatistics.bas - Takes statistics on the game for later study.
'
' Implemented by Juan Martín Sotuyo Dodero (Maraxus)
' (juansotuyo@gmail.com)
'**************************************************************

'**************************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'**************************************************************************

Option Explicit

Private Type trainningData
    startTick As Long
    trainningTime As Long
End Type

Private Type fragLvlRace
    matrix(1 To 50, 1 To 5) As Long
End Type

Private Type fragLvlLvl
    matrix(1 To 50, 1 To 50) As Long
End Type

Private trainningInfo() As trainningData

Private fragLvlRaceData(1 To 7) As fragLvlRace
Private fragLvlLvlData(1 To 7) As fragLvlLvl
Private fragAlignmentLvlData(1 To 50, 1 To 4) As Long

'Currency just in case.... chats are way TOO often...
Private keyOcurrencies(255) As Currency

Public Sub Initialize()
    ReDim trainningInfo(1 To MaxUsers) As trainningData
End Sub

Public Sub UserConnected(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'A new user connected, load it's trainning time count
    trainningInfo(UserIndex).trainningTime = val(GetVar(CharPath & UCase$(UserList(UserIndex).Name) & ".chr", "RESEARCH", "TrainningTime", 30))

    trainningInfo(UserIndex).startTick = (GetTickCount())
End Sub

Public Sub UserDisconnected(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    On Error GoTo Errhandler

1   With trainningInfo(UserIndex)
        'Update trainning time
2       .trainningTime = .trainningTime + ((GetTickCount()) - .startTick) / 1000

3       .startTick = (GetTickCount())

        'Store info in char file
4       Call WriteVar(CharPath & UCase$(UserList(UserIndex).Name) & ".chr", "RESEARCH", "TrainningTime", CStr(.trainningTime))
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en UserDisconnected en " & Erl & ". Err " & Err.Number & " " & Err.Description)
End Sub

Public Sub UserLevelUp(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim handle As Integer
    handle = FreeFile()

    With trainningInfo(UserIndex)
        'Log the data
        Open App.path & "\logs\niveles.log" For Append Shared As handle

        Print #handle, UCase$(UserList(UserIndex).Name) & " completó el nivel " & CStr(UserList(UserIndex).Stats.ELV) & " en " & CStr(.trainningTime + ((GetTickCount()) - .startTick) / 1000) & " segundos."

        Close handle

        'Reset data
        .trainningTime = 0
        .startTick = (GetTickCount())
    End With
End Sub

Public Sub StoreFrag(ByVal killer As Integer, ByVal victim As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Clase As Integer
    Dim raza As Integer
    Dim alignment As Integer

    If UserList(victim).Stats.ELV > 50 Or UserList(killer).Stats.ELV > 50 Then Exit Sub

    Select Case UserList(killer).Clase
    Case eClass.Assasin
        Clase = 1

    Case eClass.Bard
        Clase = 2

    Case eClass.Mage
        Clase = 3

    Case eClass.Paladin
        Clase = 4

    Case eClass.Warrior
        Clase = 5

    Case eClass.Cleric
        Clase = 6

    Case eClass.Hunter
        Clase = 7

    Case Else
        Exit Sub
    End Select

    Select Case UserList(killer).raza
    Case eRaza.Elfo
        raza = 1

    Case eRaza.Drow
        raza = 2

    Case eRaza.Enano
        raza = 3

    Case eRaza.Gnomo
        raza = 4

    Case eRaza.Humano
        raza = 5

    Case Else
        Exit Sub
    End Select

    If UserList(killer).faccion.ArmadaReal Then
        alignment = 1
    ElseIf UserList(killer).faccion.FuerzasCaos Then
        alignment = 2
    ElseIf criminal(killer) Then
        alignment = 3
    Else
        alignment = 4
    End If

    fragLvlRaceData(Clase).matrix(UserList(killer).Stats.ELV, raza) = fragLvlRaceData(Clase).matrix(UserList(killer).Stats.ELV, raza) + 1

    fragLvlLvlData(Clase).matrix(UserList(killer).Stats.ELV, UserList(victim).Stats.ELV) = fragLvlLvlData(Clase).matrix(UserList(killer).Stats.ELV, UserList(victim).Stats.ELV) + 1

    fragAlignmentLvlData(UserList(killer).Stats.ELV, alignment) = fragAlignmentLvlData(UserList(killer).Stats.ELV, alignment) + 1
End Sub

Public Sub ParseChat(ByRef s As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim i As Long
    Dim key As Integer

    For i = 1 To Len(s)
        key = Asc(mid$(s, i, 1))

        keyOcurrencies(key) = keyOcurrencies(key) + 1
    Next i

    'Add a NULL-terminated to consider that possibility too....
    keyOcurrencies(0) = keyOcurrencies(0) + 1
End Sub
