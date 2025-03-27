Attribute VB_Name = "mod_Limpieza"
Option Explicit

Public Sub LimpiarMapa(ByVal map As Integer)        'nice func
    On Error GoTo ERRH
1   Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Limpiando mapa " & map, FontTypeNames.FONTTYPE_SERVER))

    Dim bIsExit As Boolean
    Dim Y As Long
    Dim X As Long

2   For Y = YMinMapSize To YMaxMapSize
3       For X = XMinMapSize To XMaxMapSize
4           If MapData(map, X, Y).ObjInfo.ObjIndex > 0 And MapData(map, X, Y).Blocked = 0 Then
5               bIsExit = MapData(map, X, Y).TileExit.map > 0
6               If ItemNoEsDeMapa(MapData(map, X, Y).ObjInfo.ObjIndex, bIsExit) Then Call EraseObj(MapData(map, X, Y).ObjInfo.Amount, map, X, Y)
7           End If
8       Next X
9   Next Y

16  Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Limpieza finalizada", FontTypeNames.FONTTYPE_SERVER))
    Exit Sub
ERRH:
    Call LogError("Error en 'LimpiarMapa' en mod_Limpieza.bas en linea " & Err.Line & " -  PARAM: map=" & map)
End Sub

Public Sub LimpiarMundo()
    On Error GoTo ERRH

1   'Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Limpiando mundo", FontTypeNames.FONTTYPE_SERVER))

    Dim MapaActual As Long
    Dim bIsExit As Boolean
    Dim Y As Long
    Dim X As Long

    Dim SaveMap As Boolean

2   For MapaActual = 1 To NumMaps
        SaveMap = False
        If MapInfo(MapaActual).pk Then
            If MapaActual <> RETO_MAP_2 And MapaActual <> RETO_MAP_2_DROP And MapaActual <> RETO_MAP And MapaActual <> RETO_MAP_DROP And MapaActual <> PLANTE_MAP And MapaActual <> PLANTE_MAP_DROP Then
3               For Y = YMinMapSize To YMaxMapSize
4                   For X = XMinMapSize To XMaxMapSize
5                       If MapData(MapaActual, X, Y).ObjInfo.ObjIndex > 0 And MapData(MapaActual, X, Y).Blocked = 0 Then

                            If MapData(MapaActual, X, Y).ObjInfo.ObjIndex <> iORO Then
                                If MapData(MapaActual, X, Y).NpcIndex > 0 Then
                                    If Npclist(MapData(MapaActual, X, Y).NpcIndex).Movement <> ESTATICO Then
                                        bIsExit = MapData(MapaActual, X, Y).TileExit.map > 0
7                                       If ItemNoEsDeMapa(MapData(MapaActual, X, Y).ObjInfo.ObjIndex, bIsExit) Then

                                            If ObjData(MapData(MapaActual, X, Y).ObjInfo.ObjIndex).Valor * MapData(MapaActual, X, Y).ObjInfo.Amount < 100 Then    '500 Si es TDSF sería asi
                                                Call EraseObj(MapData(MapaActual, X, Y).ObjInfo.Amount, MapaActual, X, Y)
                                                SaveMap = True
                                            End If

                                        End If
                                    End If
                                Else
                                    bIsExit = MapData(MapaActual, X, Y).TileExit.map > 0
                                    If ItemNoEsDeMapa(MapData(MapaActual, X, Y).ObjInfo.ObjIndex, bIsExit) Then
                                        If ObjData(MapData(MapaActual, X, Y).ObjInfo.ObjIndex).Valor * MapData(MapaActual, X, Y).ObjInfo.Amount < 100 Then    '500 Si es TDSF sería asi
                                            Call EraseObj(MapData(MapaActual, X, Y).ObjInfo.Amount, MapaActual, X, Y)
                                            SaveMap = True
                                        End If
                                    End If
                                End If
                            End If

8                       End If
9                   Next X
10              Next Y
            End If
        End If
        If SaveMap Then
            'Call GrabarMapa(MapaActual, App.path & "\WorldBackUp\Mapa" & MapaActual)
        End If
11  Next MapaActual

16  Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Limpieza del mundo finalizada", FontTypeNames.FONTTYPE_SERVER))
    Exit Sub
ERRH:
    Call LogError("Error en 'LimpiarMundo' en mod_Limpieza.bas en linea " & Err.Line)
End Sub

