Attribute VB_Name = "mod_Loteria"
Option Explicit

Public Type tUserLoteria
    numApostado As Byte
    vApuesta As Long
    id_Loteria As Integer
End Type

Private Type tLoteria
    numSorteado As Byte
    id_Loteria As Integer
End Type
Public Loteria As tLoteria
Private Const LoteriaMaxNum As Byte = 200

Public Sub ComprarBoleto(ByVal UserIndex As Integer, ByVal Apuesta As Long, ByVal Numero As Byte)
    With UserList(UserIndex)
        If .Stats.GLD < Apuesta Then
            Call WriteConsoleMsg(UserIndex, "No tienes suficiente oro.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        .Stats.GLD = .Stats.GLD - Apuesta
        .userLoteria.id_Loteria = Loteria.id_Loteria + 1
        .userLoteria.numApostado = Numero
        .userLoteria.vApuesta = Apuesta
        Call WriteUpdateGold(UserIndex)
        Call WriteConsoleMsg(UserIndex, "La apuesta ha sido realizada correctamente.", FontTypeNames.FONTTYPE_INFO)
        
    End With
End Sub
Public Sub LoteriaPasarSegundo()
    If Hour(Time) = 20 And Minute(Time) = 0 And Second(Time) = 0 Then
        Call HacerLoteria
    End If
End Sub
Public Sub LogearLoteria(ByVal UserIndex As Integer)
    With UserList(UserIndex)
        If .userLoteria.id_Loteria = Loteria.id_Loteria Then
            If .userLoteria.numApostado = Loteria.numSorteado Then
                Call GanoLoteria(UserIndex)
            End If
            .userLoteria.numApostado = 0
            .userLoteria.id_Loteria = 0
            .userLoteria.vApuesta = 0
        End If
    End With
End Sub

Public Sub HacerLoteria()
    Loteria.numSorteado = RandomNumber(1, LoteriaMaxNum)
    Loteria.id_Loteria = Loteria.id_Loteria + 1
    Dim X As Long
    For X = 1 To LastUser
        With UserList(X)
             If .flags.UserLogged Then
                If .userLoteria.id_Loteria = Loteria.id_Loteria Then
                    If .userLoteria.numApostado = Loteria.numSorteado Then
                        Call GanoLoteria(X)
                    End If
                    .userLoteria.numApostado = 0
                    .userLoteria.id_Loteria = 0
                    .userLoteria.vApuesta = 0
                End If
             End If
        End With
    Next X
End Sub

Private Sub GanoLoteria(ByVal UserIndex As Integer)
    With UserList(UserIndex)
        .Stats.GLD = .Stats.GLD + (.userLoteria.vApuesta * 20)
        Call WriteUpdateGold(UserIndex)
        Call WriteConsoleMsg(UserIndex, "Has ganado la lotería, te llevas un premio de " & (.userLoteria.vApuesta * 20) & " monedas de oro.", FontTypeNames.FONTTYPE_GUILD)
    End With
End Sub

