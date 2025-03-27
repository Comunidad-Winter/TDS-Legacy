Attribute VB_Name = "mod_Rankings"
'Author: Nhelk(Santiago)
'Date: 21/11/2014

Option Explicit

Public Type tDatosRanking '' Ranks en el type user.
    Retos1vs1Ganados As Integer
    Retos2vs2Ganados As Integer
    Retos3vs3Ganados As Integer
End Type
 
Public Type tUserRanking '' Estructura de datos para cada puesto del ranking
    Nick As String
    Value As Long
End Type
 
Private Type tRanking '' Estructura de 10 usuarios, cada tipo de ranking esta declarado con esta estructura
    User(1 To 10) As tUserRanking
End Type
 
Public Enum eRankings '' Cada ranking tiene un identificador.
    Retos1vs1 = 1
    Retos2vs2 = 2
    Retos3vs3 = 3
    Nivel = 4
    Matados = 5
End Enum
 
Public Const NumRanks As Byte = 5 ''Cuantos tipos de rankings existen (r1vs1, r2vs2, nivel, etc)

Public RankingFile As String

Public Rankings(1 To NumRanks) As tRanking ''Array con todos los tipos de ranking, _
                                            para identificar cada uno se usa el enum eRankings

Public Sub CheckRanking(ByVal Tipo As eRankings, ByVal UserIndex As Integer, ByVal Value As Long)
    ''CheckRanking
    ''Cada vez que se cambia algun valor de cualquier usuario, se verifica si puede ingresar al ranking, _
                                                    cambiar de posicion o solamente actualizar el valor.
                                                    
    Dim FindPos As Byte, LoopC As Long, InRank As Byte, backup As tUserRanking
    If EsGM(UserIndex) Then Exit Sub
    
    InRank = isRank(UserList(UserIndex).Name, Tipo) ''Verificamos si esta en el ranking y si esta, en que posicion.
    With Rankings(Tipo)
        If InRank > 1 Then  ''Si no es el primero del ranking
            .User(InRank).Value = Value ''Actualizamos el valor ANTES de reordenarlo
            Do While .User(InRank - 1).Value < Value ''Mientras que el usuario que esta arriba en el ranking tenga _
                                                        menos puntos, va a seguir subiendo de posiciones.
                backup = .User(InRank) ''Guardamos el personaje en cuestion ya que vamos a cambiar los datos
                .User(InRank) = .User(InRank - 1) ''Reemplazamos al personaje, por el que estaba un puesto arriba
                .User(InRank - 1) = backup ''En ese puesto, ponemos el personaje que ascendio un puesto
                InRank = InRank - 1 ''Actualizamos la variable temporal que esta guardando la posicion _
                                        de el pj que esta actualizando su posicion
                If InRank = 1 Then ''Si llego al primer puesto
                    Exit Do ''Salimos, ya no puede seguir subiendo.
                End If
            Loop
            Call SaveWholeRanking(Tipo)
        ElseIf InRank = 1 Then ''Si es el primero del ranking
            .User(InRank).Value = Value ''Actualizamos el valor.
            Call WriteVar(RankingFile, "RANKING" & CByte(Tipo), "VALUE" & InRank, Value)
        ElseIf InRank = 0 Then ''Si no esta en el ranking
            If .User(10).Value < Value Then
                ''If FindPos > 0 Then ''Encontro alguna posicion?
                    .User(10).Value = Value
                    .User(10).Nick = UserList(UserIndex).Name
                    InRank = 10
                    Do While .User(InRank - 1).Value < Value ''Mientras que el usuario que esta arriba en el ranking tenga _
                                                        menos puntos, va a seguir subiendo de posiciones.
                        backup = .User(InRank) ''Guardamos el personaje en cuestion ya que vamos a cambiar los datos
                        
                        .User(InRank) = .User(InRank - 1) ''Reemplazamos al personaje, por el que estaba un puesto arriba
                        .User(InRank - 1) = backup ''En ese puesto, ponemos el personaje que ascendio un puesto
                        InRank = InRank - 1 ''Actualizamos la variable temporal que esta guardando la posicion _
                                              de el pj que esta actualizando su posicion
                        If InRank = 1 Then ''Si llego al primer puesto
                            Exit Do ''Salimos, ya no puede seguir subiendo.
                        End If
                    Loop
                    Call SaveWholeRanking(Tipo)
                ''End If
            End If
        End If
    End With
End Sub

Private Function isRank(ByVal Nick As String, ByVal Tipo As eRankings) As Byte
    'Funcion que devuelve el puesto del ranking si es que esta en el mismo, devuelve 0 si no esta en el ranking.
    Dim X As Long
    For X = 1 To 10 ''Recorremos el ranking
        If UCase$(Nick) = UCase$(Rankings(Tipo).User(X).Nick) Then ''Esta en este puesto?
            isRank = CByte(X) ''Devolvemos el valor que encontramos
            Exit Function ''Salimos, ya no hay nada mas que hacer.
        End If
        ''No esta en este puesto, seguimos buscando
    Next X
    ''No esta en el ranking, devolvemos 0 como valor.
    isRank = 0
End Function

Private Sub SaveWholeRanking(ByVal Tipo As Byte)
    Dim X As Long
    For X = 1 To 10
        With Rankings(Tipo)
            Call WriteVar(RankingFile, "RANKING" & Tipo, "USER" & X, .User(X).Nick)
            Call WriteVar(RankingFile, "RANKING" & Tipo, "VALUE" & X, .User(X).Value)
        End With
    Next X
End Sub

Public Sub GuardarRanking()
    Dim X As Long
    Dim z As Long
    For z = 1 To NumRanks
        For X = 1 To 10
            With Rankings(z)
                Call WriteVar(RankingFile, "RANKING" & z, "USER" & X, .User(X).Nick)
                Call WriteVar(RankingFile, "RANKING" & z, "VALUE" & X, .User(X).Value)
            End With
        Next X
    Next z
End Sub

Public Sub CargarRanking()
    RankingFile = App.path & "\Dat\Ranking.dat"
    Dim X As Long
    Dim z As Long
    For z = 1 To NumRanks
        For X = 1 To 10
            With Rankings(z)
                .User(X).Nick = GetVar(RankingFile, "RANKING" & z, "USER" & X)
                If LenB(.User(X).Nick) > 0 Then _
                    .User(X).Value = val(GetVar(RankingFile, "RANKING" & z, "VALUE" & X))
            End With
        Next X
    Next z
End Sub







