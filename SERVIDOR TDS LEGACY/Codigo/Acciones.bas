Attribute VB_Name = "Acciones"
Option Explicit

Sub Accion(ByVal UserIndex As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)

    Dim tempIndex As Integer

    On Error Resume Next
    '¿Rango Visión? (ToxicWaste)
    If (Abs(UserList(UserIndex).Pos.Y - Y) > RANGO_VISION_Y) Or (Abs(UserList(UserIndex).Pos.X - X) > RANGO_VISION_X) Then
        Exit Sub
    End If

    '¿Posicion valida?
    If InMapBounds(Map, X, Y) Then
        With UserList(UserIndex)
            If MapData(Map, X, Y).NpcIndex > 0 Then        'Acciones NPCs
                tempIndex = MapData(Map, X, Y).NpcIndex

                'Set the target NPC
                .flags.TargetNPC = tempIndex

                If Npclist(tempIndex).NPCtype = eNPCType.BorradorDePersonaje Then
                    If distancia(Npclist(tempIndex).Pos, .Pos) > 3 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_5
                        Exit Sub
                    End If
                    Call WriteShowBorrarPjForm(UserIndex)

                ElseIf Npclist(tempIndex).NPCtype = eNPCType.ReseteadorDePersonaje Then
                    If distancia(Npclist(tempIndex).Pos, .Pos) > 3 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_5
                        Exit Sub
                    End If
                    Call WriteShowResetearPjForm(UserIndex)    'Call ResetearPersonaje(UserIndex)

                ElseIf Npclist(tempIndex).Comercia = 1 Then
                    '¿Esta el user muerto? Si es asi no puede comerciar
                    If .flags.Muerto = 1 Then
                        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
                        Exit Sub
                    End If

                    'Is it already in commerce mode??
                    If .flags.Comerciando Then
                        Exit Sub
                    End If

                    If distancia(Npclist(tempIndex).Pos, .Pos) > 3 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_7
                        Exit Sub
                    End If

                    'Iniciamos la rutina pa' comerciar.
                    Call IniciarComercioNPC(UserIndex)
                    Call NPCs.AddToNpcTradingArray(UserIndex, UserList(UserIndex).flags.TargetNPC)

                ElseIf Npclist(tempIndex).NPCtype = eNPCType.Banquero Then
                    '¿Esta el user muerto? Si es asi no puede comerciar
                    If .flags.Muerto = 1 Then
                        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
                        'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
                        Exit Sub
                    End If

                    'Is it already in commerce mode??
                    If .flags.Comerciando Then
                        Exit Sub
                    End If

                    If distancia(Npclist(tempIndex).Pos, .Pos) > 3 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_7
                        Exit Sub
                    End If

                    'A depositar de una
                    Call IniciarDeposito(UserIndex)

                ElseIf Npclist(tempIndex).NPCtype = eNPCType.Revividor Or Npclist(tempIndex).NPCtype = eNPCType.ResucitadorNewbie Then
                    If distancia(.Pos, Npclist(tempIndex).Pos) > 10 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_8
                        Exit Sub
                    End If

                    'Revivimos si es necesario
                    If .flags.Muerto = 1 And (Npclist(tempIndex).NPCtype = eNPCType.Revividor Or EsNewbie(UserIndex)) Then
                        Call RevivirUsuario(UserIndex, True)
                    End If

                    If Npclist(tempIndex).NPCtype = eNPCType.Revividor Or EsNewbie(UserIndex) Then
                        'curamos totalmente
                        .Stats.MinHP = .Stats.MaxHP

                        Call WriteUpdateUserStats(UserIndex)
                    End If
                End If

                '¿Es un obj?
            ElseIf MapData(Map, X, Y).ObjInfo.ObjIndex > 0 Then
                tempIndex = MapData(Map, X, Y).ObjInfo.ObjIndex

                .flags.TargetObj = tempIndex

                Select Case ObjData(tempIndex).OBJType
                Case eOBJType.otPuertas        'Es una puerta
                    Call AccionParaPuerta(Map, X, Y, UserIndex)
                Case eOBJType.otCarteles        'Es un cartel
                    Call AccionParaCartel(Map, X, Y, UserIndex)
                Case eOBJType.otLeña        'Leña
                    If tempIndex = FOGATA_APAG And .flags.Muerto = 0 Then
                        Call AccionParaRamita(Map, X, Y, UserIndex)
                    End If
                End Select
                '>>>>>>>>>>>OBJETOS QUE OCUPAM MAS DE UN TILE<<<<<<<<<<<<<
            ElseIf MapData(Map, X + 1, Y).ObjInfo.ObjIndex > 0 Then
                tempIndex = MapData(Map, X + 1, Y).ObjInfo.ObjIndex
                .flags.TargetObj = tempIndex

                Select Case ObjData(tempIndex).OBJType

                Case eOBJType.otPuertas        'Es una puerta
                    Call AccionParaPuerta(Map, X + 1, Y, UserIndex)

                End Select

            ElseIf MapData(Map, X + 1, Y + 1).ObjInfo.ObjIndex > 0 Then
                tempIndex = MapData(Map, X + 1, Y + 1).ObjInfo.ObjIndex
                .flags.TargetObj = tempIndex

                Select Case ObjData(tempIndex).OBJType
                Case eOBJType.otPuertas        'Es una puerta
                    Call AccionParaPuerta(Map, X + 1, Y + 1, UserIndex)
                End Select

            ElseIf MapData(Map, X, Y + 1).ObjInfo.ObjIndex > 0 Then
                tempIndex = MapData(Map, X, Y + 1).ObjInfo.ObjIndex
                .flags.TargetObj = tempIndex

                Select Case ObjData(tempIndex).OBJType
                Case eOBJType.otPuertas        'Es una puerta
                    Call AccionParaPuerta(Map, X, Y + 1, UserIndex)
                End Select
            Else
                'If HayAgua(map, x, y) Then
                '     Debug.Print
                'End If
            End If
        End With
    End If
End Sub

Sub AccionParaPuerta(ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte, ByVal UserIndex As Integer, Optional ByVal SinDistancia As Boolean)

    On Error GoTo Handler

    If Not (Distance(UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y, X, Y) > 2) And Not SinDistancia Then
        If ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).Llave = 0 Then
            If ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).Cerrada = 1 Then
                'Abre la puerta
                If ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).Llave = 0 Then

                    MapData(Map, X, Y).ObjInfo.ObjIndex = ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).IndexAbierta

                    'Desbloquea
                    MapData(Map, X, Y).Blocked = 0
                    MapData(Map, X - 1, Y).Blocked = 0

                    'Bloquea todos los mapas
                    Call Bloquear(True, Map, X, Y, 0)
                    Call Bloquear(True, Map, X - 1, Y, 0)

                    Call modSendData.SendToAreaByPos(Map, X, Y, PrepareMessageObjectCreate(ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).GrhIndex, X, Y))

                    'Sonido
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_PUERTA, X, Y))

                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_20
                End If
            Else
                'Cierra puerta
                MapData(Map, X, Y).ObjInfo.ObjIndex = ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).IndexCerrada

                MapData(Map, X, Y).Blocked = 1
                MapData(Map, X - 1, Y).Blocked = 1

                Call Bloquear(True, Map, X - 1, Y, 1)
                Call Bloquear(True, Map, X, Y, 1)

                Call modSendData.SendToAreaByPos(Map, X, Y, PrepareMessageObjectCreate(ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).GrhIndex, X, Y))

                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_PUERTA, X, Y))
            End If

            UserList(UserIndex).flags.TargetObj = MapData(Map, X, Y).ObjInfo.ObjIndex
        Else
            Call WriteMensajes(UserIndex, Mensaje_20)
        End If
    Else
        Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
    End If

    Exit Sub

Handler:
136 Call LogError("Acciones.AccionParaPuerta en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Sub AccionParaCartel(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal UserIndex As Integer)

    On Error GoTo Handler

    If ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).OBJType = 8 Then

        If Len(ObjData(MapData(Map, X, Y).ObjInfo.ObjIndex).texto) > 0 Then
            Call WriteShowSignal(UserIndex, MapData(Map, X, Y).ObjInfo.ObjIndex, X, Y)
        End If

    End If

    Exit Sub

Handler:
106 Call LogError("Acciones.AccionParaCartelen " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Sub AccionParaRamita(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Handler

    Dim suerte As Byte
    Dim exito As Byte
    Dim Obj As Obj

    Dim Pos As WorldPos
    Pos.Map = Map
    Pos.X = X
    Pos.Y = Y

    With UserList(UserIndex)
        If distancia(Pos, .Pos) > 2 Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub
        End If

        If MapData(Map, X, Y).trigger = eTrigger.ZONASEGURA Or MapInfo(Map).pk = False Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_341
            Exit Sub
        End If

        If .Stats.UserSkills(Supervivencia) > 1 And .Stats.UserSkills(Supervivencia) < 6 Then
            suerte = 3
        ElseIf .Stats.UserSkills(Supervivencia) >= 6 And .Stats.UserSkills(Supervivencia) <= 10 Then
            suerte = 2
        ElseIf .Stats.UserSkills(Supervivencia) >= 10 And .Stats.UserSkills(Supervivencia) Then
            suerte = 1
        End If

        exito = RandomNumber(1, suerte)

        If exito = 1 Then
            If MapInfo(.Pos.Map).Zona <> Ciudad Or MapInfo(.Pos.Map).pk Then
                Obj.ObjIndex = FOGATA
                Obj.Amount = 1


                WriteMensajes UserIndex, e_Mensajes.Mensaje_28

                Call MakeObj(Obj, Map, X, Y)

                Call SubirSkill(UserIndex, eSkill.Supervivencia, True)
            Else
                Call WriteMensajes(UserIndex, Mensaje_341)
                Exit Sub
            End If
        Else

            WriteMensajes UserIndex, e_Mensajes.Mensaje_29
            Call SubirSkill(UserIndex, eSkill.Supervivencia, False)
        End If

    End With

    Exit Sub

Handler:
106 Call LogError("Acciones.AccionParaRamita en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub
