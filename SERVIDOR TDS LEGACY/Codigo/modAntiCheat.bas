Attribute VB_Name = "modAntiCheat"
Option Explicit


Public INT_USEITEM As Integer

Public INT_USEITEMU As Integer
Public INT_USEITEMDCK As Integer
Public INT_ATTACK_USEITEM As Integer

Public INT_CAST_SPELL As Integer
Public INT_CAST_ATTACK As Integer
Public INT_ATTACK_CAST As Integer
Public INT_ATTACK As Integer
Public INT_ARROWS As Integer
Public INT_ARROWSW As Integer

Public INT_WORK As Integer


Private Type tSeguimiento
    lstChk As Long
    Fails As Integer
    Counter As Byte        'para eliminar 1 cada 2 segundos.
End Type

Public Type tAnticheat
    Usar As tSeguimiento
    UsarDck As tSeguimiento
    Lanzar As tSeguimiento
    Golpe As tSeguimiento
End Type

Public Enum IntControl
    Usar
    UsarDck
    Lanzar
    Golpe
End Enum

Public Function PuedeIntervalo(ByVal UI As Integer, ByVal tipo As IntControl) As Boolean
    Dim actual As Long
    actual = GetTickCount()
    With UserList(UI).ACht
        Select Case tipo
        Case IntControl.UsarDck
            With .UsarDck
                If Abs(actual - .lstChk) < INT_USEITEMDCK Then
                    .Fails = .Fails + 1
                    If .Fails >= 10 Then
                        Call SobrePasaIntervalo(UI, IntControl.UsarDck)

                    End If
                    PuedeIntervalo = False
                    Exit Function
                Else
                    .lstChk = actual
                    PuedeIntervalo = True
                    Exit Function
                End If
            End With

        Case IntControl.Usar

            With .Usar
                If Abs(actual - .lstChk) < INT_USEITEMU Then
                    .Fails = .Fails + 1
                    If .Fails >= 10 Then
                        Call SobrePasaIntervalo(UI, IntControl.Usar)
                    End If
                    PuedeIntervalo = False
                    Exit Function
                Else
                    .lstChk = actual
                    PuedeIntervalo = True
                    Exit Function
                End If
            End With

        Case IntControl.Lanzar
            With .Lanzar
                If Abs(actual - .lstChk) < INT_CAST_SPELL Then
                    .Fails = .Fails + 1
                    If .Fails >= 10 Then
                        Call SobrePasaIntervalo(UI, IntControl.Lanzar)
                    End If
                    PuedeIntervalo = False
                    Exit Function
                Else
                    .lstChk = actual
                    PuedeIntervalo = True
                    Exit Function
                End If
            End With

        Case IntControl.Golpe
            With .Golpe
                If Abs(actual - .lstChk) < INT_ATTACK Then
                    .Fails = .Fails + 1
                    If .Fails >= 10 Then
                        Call SobrePasaIntervalo(UI, IntControl.Golpe)
                    End If
                    PuedeIntervalo = False
                    Exit Function
                Else
                    .lstChk = actual
                    PuedeIntervalo = True
                    Exit Function
                End If
            End With
        End Select
    End With
End Function

Private Sub SobrePasaIntervalo(ByVal UserIndex As Integer, ByVal tipo As IntControl)
    Dim msg As String
    Select Case tipo
    Case IntControl.Usar
        msg = "AntiCheat> Deteccion cheat poteo de "

    Case IntControl.UsarDck
        msg = "AntiCheat> Deteccion cheat poteo doble click de "

    Case IntControl.Lanzar
        msg = "AntiCheat> Deteccion cheat lanzar de "

    Case IntControl.Golpe
        msg = "AntiCheat> Deteccion cheat lanzar de "
    End Select
    
    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(msg & UserList(UserIndex).Name, FontTypeNames.FONTTYPE_GUILD))
    Call LogAntiCheat(msg & UserList(UserIndex).Name)

End Sub

Public Sub actualizarAntiCheat(ByVal UI As Integer)
    With UserList(UI).ACht
        If .Usar.Fails > 0 Then .Usar.Fails = .Usar.Fails - 1

        If .UsarDck.Fails > 0 Then .UsarDck.Fails = .Lanzar.Fails - 1

        If .Lanzar.Fails > 0 Then .Lanzar.Fails = .Lanzar.Fails - 1

        If .Golpe.Fails > 0 Then .Golpe.Fails = .Lanzar.Fails - 1
    End With
End Sub

