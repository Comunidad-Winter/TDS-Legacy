Attribute VB_Name = "m_Ranking"
Option Explicit

Public Const MAX_TOP As Byte = 50        '10
Public Const MAX_RANKINGS As Byte = 2

Public Type tRanking
    value(1 To MAX_TOP) As Long
    Nombre(1 To MAX_TOP) As String
End Type

Public Ranking(1 To MAX_RANKINGS) As tRanking

Public Enum eRanking
    TopNivel = 1
    TopRetos = 2
    'TopFrags_Crimis
    'TopFrags_Ciudas
    'TopFrags_Total
    'TopClanes
    'TopTorneos
End Enum

Public Function RenameRanking(ByVal Ranking As eRanking) As String

'@ Devolvemos el nombre del TAG [] del archivo .DAT
    Select Case Ranking
    Case eRanking.TopNivel
        RenameRanking = "Nivel"
    Case eRanking.TopRetos
        RenameRanking = "Retos"
        'Case eRanking.TopFrags_Crimis
        '    RenameRanking = "Criminales matados"
        'Case eRanking.TopFrags_Ciudas
        '    RenameRanking = "Ciudadanos matados"
        'Case eRanking.TopFrags_Total
        '    RenameRanking = "Frags"
        'Case eRanking.TopClanes
        '    RenameRanking = "Clanes"
        'Case eRanking.TopTorneos
        '    RenameRanking = "Torneos"
    Case Else
        RenameRanking = "Err"
    End Select
End Function

Public Function RenameValue(ByVal UserIndex As Integer, ByVal Ranking As eRanking) As Long
    Select Case Ranking
    Case eRanking.TopNivel
        RenameValue = UserList(UserIndex).Stats.ELV
    Case eRanking.TopRetos
        RenameValue = (UserList(UserIndex).Stats.RetosGanados - UserList(UserIndex).Stats.RetosPerdidos)
        'Case eRanking.TopFrags_Crimis
        '    RenameValue = UserList(UserIndex).Faccion.CriminalesMatados
        'Case eRanking.TopFrags_Ciudas
        '    RenameValue = UserList(UserIndex).Faccion.CiudadanosMatados
        'Case eRanking.TopFrags_Total
        '    RenameValue = UserList(UserIndex).Faccion.CiudadanosMatados + UserList(UserIndex).Faccion.CriminalesMatados
        'Case eRanking.TopClanes
        '    RenameValue = guilds(UserIndex).GetGuildHorasConquistadas
        'Case eRanking.TopTorneos
        '    RenameValue = UserList(UserIndex).flags.CopasOro
    End Select

End Function

Public Sub CambiaNick_Ranking(ByVal nick As String, ByVal NewName As String)

    On Error Resume Next

    Dim LoopI As Long
    Dim LoopX As Long

    For LoopX = 1 To MAX_RANKINGS
        For LoopI = 1 To MAX_TOP
            If Ranking(LoopX).Nombre(LoopI) = UCase$(nick) Then
                Ranking(LoopX).Nombre(LoopI) = NewName
                Call WriteVar(DatPath & "Ranking.Dat", RenameRanking(LoopX), _
                              "Top" & LoopI, Ranking(LoopX).Nombre(LoopI) & "-" & Ranking(LoopX).value(LoopI))
            End If
        Next LoopI
    Next LoopX

End Sub

Public Sub LoadRanking()

    On Error Resume Next

    Dim LoopI As Long
    Dim LoopX As Long
    Dim ln As String

    For LoopX = 1 To MAX_RANKINGS
        For LoopI = 1 To MAX_TOP
            ln = GetVar(App.path & "\Dat\" & "Ranking.dat", RenameRanking(LoopX), "Top" & LoopI)
            Ranking(LoopX).Nombre(LoopI) = ReadField(1, ln, 45)
            Ranking(LoopX).value(LoopI) = val(ReadField(2, ln, 45))
        Next LoopI
    Next LoopX

End Sub

Public Sub SaveRanking(ByVal Rank As eRanking)

    Dim LoopI As Long

    For LoopI = 1 To MAX_TOP
        Call WriteVar(DatPath & "Ranking.Dat", RenameRanking(Rank), _
                      "Top" & LoopI, Ranking(Rank).Nombre(LoopI) & "-" & Ranking(Rank).value(LoopI))
    Next LoopI

End Sub

Public Sub ActualizarPosRanking(ByVal Top As Byte, ByVal Rank As eRanking, ByVal value As Long)
    Ranking(Rank).value(Top) = value
End Sub

Public Sub ActualizarRanking(ByVal Top As Byte, ByVal Rank As eRanking, ByVal UserName As String, ByVal value As Long)

'@ Actualizamos la lista de ranking

    Dim LoopC As Long

    Dim Valor(1 To MAX_TOP) As Long
    Dim Nombre(1 To MAX_TOP) As String

    ' @ Copia necesaria para evitar que se dupliquen repetidamente
    For LoopC = 1 To MAX_TOP
        Valor(LoopC) = Ranking(Rank).value(LoopC)
        Nombre(LoopC) = Ranking(Rank).Nombre(LoopC)
    Next LoopC

    ' @ Corremos las pos, desde el "Top" que es la primera
    For LoopC = Top To MAX_TOP - 1
        Ranking(Rank).value(LoopC + 1) = Valor(LoopC)
        Ranking(Rank).Nombre(LoopC + 1) = Nombre(LoopC)
    Next LoopC

    Ranking(Rank).Nombre(Top) = UCase$(UserName)
    Ranking(Rank).value(Top) = value
    Call SaveRanking(Rank)
    'Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Ranking de " & RenameRanking(Rank) & "> " & UserName & " ha subido al TOP " & Top & ".", FontTypeNames.FONTTYPE_GUILD))

End Sub

Public Sub CheckRankingUser(ByVal UserIndex As Integer, ByVal Rank As eRanking)
' @ Desde aca nos hacemos la siguientes preguntas
' @ El personaje está en el ranking?
' @ El personaje puede ingresar al ranking?

    Dim LoopX As Long
    Dim LoopY As Long
    Dim loopZ As Long
    Dim i As Long
    Dim value As Long
    Dim Actualizacion As Byte
    Dim Auxiliar As String
    Dim PosRanking As Byte

    With UserList(UserIndex)

        ' @ Not gms
        If EsGM(UserIndex) Then Exit Sub

        value = RenameValue(UserIndex, Rank)

        ' @ Buscamos al personaje en el ranking
        For i = 1 To MAX_TOP
            If UCase$(Ranking(Rank).Nombre(i)) = UCase$(.Name) Then
                PosRanking = i
                Exit For
            End If
        Next i

        ' @ Si el personaje esta en el ranking actualizamos los valores.
        If PosRanking <> 0 Then
            ' ¿Si está actualizado pa que?
            If value <> Ranking(Rank).value(PosRanking) Then
                Call ActualizarPosRanking(PosRanking, Rank, value)

                ' ¿Es la pos 1? No hace falta ordenarlos
                'If Not PosRanking = 1 Then
                ' @ Chequeamos los datos para actualizar el ranking
                For LoopY = 1 To MAX_TOP
                    For loopZ = 1 To MAX_TOP - LoopY

                        If Ranking(Rank).value(loopZ) < Ranking(Rank).value(loopZ + 1) Then

                            ' Actualizamos el valor
                            Auxiliar = Ranking(Rank).value(loopZ)
                            Ranking(Rank).value(loopZ) = Ranking(Rank).value(loopZ + 1)
                            Ranking(Rank).value(loopZ + 1) = Auxiliar

                            ' Actualizamos el nombre
                            Auxiliar = Ranking(Rank).Nombre(loopZ)
                            Ranking(Rank).Nombre(loopZ) = Ranking(Rank).Nombre(loopZ + 1)
                            Ranking(Rank).Nombre(loopZ + 1) = Auxiliar
                            Actualizacion = 1
                        End If
                    Next loopZ
                Next LoopY
                'End If

                If Actualizacion <> 0 Then
                    Call SaveRanking(Rank)
                End If
            End If

            Exit Sub
        Else

        End If

        ' @ Nos fijamos si podemos ingresar al ranking
        For LoopX = 1 To MAX_TOP
            If value > Ranking(Rank).value(LoopX) Then
                Call ActualizarRanking(LoopX, Rank, .Name, value)
                Exit For
            End If
        Next LoopX

    End With
End Sub





