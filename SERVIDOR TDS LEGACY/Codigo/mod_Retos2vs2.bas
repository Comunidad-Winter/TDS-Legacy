Attribute VB_Name = "mod_Retos2vs2"
Option Explicit
 
Public Const RETO_COLOR As String = "~255~128~64~1"
 
Public Type ruleStruct
 
        drop_inv        As Boolean
        gold_gamble     As Long
 
End Type
 
Public Type teamStruct
 
        user_Index(1)   As Integer
        round_count     As Byte
        return_city     As Byte
 
End Type
 
Public Type retoStruct
 
        team_array(1)   As teamStruct
        general_rules   As ruleStruct
        Count_Down      As Byte
        used_ring       As Boolean
 
        nextRoundCount  As Integer
 
End Type
 
Public Type userStruct
 
        tempStruct      As retoStruct
        accept_count    As Byte
        reto_Index      As Integer
        nick_sender     As String
        reto_used       As Boolean
        return_city     As Byte
        acceptedOK      As Boolean
        acceptLimit     As Integer
 
End Type
 
Private Type tempPos
 
        x As Integer
        Y As Integer
 
End Type
 
Public reto_2Map      As Integer
Public reto_List()    As retoStruct
Public reto_RingPos() As tempPos
 
Public Sub initRetoData2()
 
        '
        ' @ amishar
   
        Dim bRead As New clsIniReader
 
        Dim nRing As Integer
   
        Set bRead = New clsIniReader
   
        Call bRead.Initialize(App.path & "\Reto2vs2.ini")
   
        nRing = val(bRead.GetValue("INIT", "Arenas"))
   
        If (nRing = 0) Then Exit Sub
   
        ReDim reto_List(0 To nRing - 1) As retoStruct
        ReDim reto_RingPos(1 To nRing, 1 To 2, 1 To 2) As tempPos
   
        reto_2Map = val(bRead.GetValue("INIT", "MapaArenas"))
   
        Dim i As Long
        Dim j As Long
        Dim p As Long
        Dim S As String
   
        For i = 1 To nRing
                For j = 1 To 2
                        For p = 1 To 2
                                S = bRead.GetValue("ARENA" & CStr(i), "Equipo" & CStr(j) & "Jugador" & CStr(p))
               
                                reto_RingPos(i, j, p).x = val(ReadField(1, S, Asc("-")))
                                reto_RingPos(i, j, p).Y = val(ReadField(2, S, Asc("-")))
 
                        Next p
                Next j
        Next i
   
        Set bRead = Nothing
 
End Sub
 
Public Sub loop_reto()
 
        '
        ' @ amishar
   
        Dim LoopC As Long
   
        For LoopC = 0 To UBound(reto_List())
 
                If (reto_List(LoopC).used_ring) Then
                        Call loop_reto_index(LoopC)
                End If
 
        Next LoopC
 
End Sub
 
Private Function check_player_List(ByVal UserIndex As Integer) As Boolean
 
        '
        ' @ amishar
   
        With UserList(UserIndex).reto2Data
 
                Dim tmp(2) As Integer
         
                With .tempStruct
             
                        check_player_List = False
             
                        tmp(0) = .team_array(0).user_Index(1)
                        tmp(1) = .team_array(1).user_Index(0)
                        tmp(2) = .team_array(1).user_Index(1)
             
                        If UserIndex = tmp(0) Or UserIndex = tmp(1) Or UserIndex = tmp(2) Then Exit Function
             
                        If tmp(0) = tmp(1) Or tmp(0) = tmp(2) Then Exit Function
             
                        If tmp(1) = tmp(2) Then Exit Function
             
                        check_player_List = True
                End With
        End With
 
End Function
 
Public Function can_Attack(ByVal attackerIndex As Integer, _
                           ByVal victimIndex As Integer) As Boolean
 
        '
        ' @ amishar
   
        Dim RetoIndex As Integer
        Dim teamIndex As Integer
        Dim tempIndex As Integer
        Dim teamLoop  As Long
   
        can_Attack = True
   
        RetoIndex = UserList(attackerIndex).reto2Data.reto_Index
   
        teamIndex = -1
   
        If reto_List(RetoIndex).used_ring Then
 
                For teamLoop = 0 To 1
 
                        If reto_List(RetoIndex).team_array(teamLoop).user_Index(0) = attackerIndex Or reto_List(RetoIndex).team_array(teamLoop).user_Index(1) = attackerIndex Then
                                teamIndex = teamLoop
 
                                Exit For
 
                        End If
 
                Next teamLoop
       
                If teamIndex <> -1 Then
                        tempIndex = IIf(reto_List(RetoIndex).team_array(teamIndex).user_Index(0) = attackerIndex, 1, 0)
 
                        If reto_List(RetoIndex).team_array(teamIndex).user_Index(tempIndex) = victimIndex Then
                                can_Attack = False
                        End If
                End If
        End If
 
End Function
 
Private Sub loop_reto_index(ByVal reto_Index As Integer)
 
        '
        ' @ amishar
   
        Dim i As Long
        Dim j As Long
        Dim h As Integer
        Dim m As String
   
        With reto_List(reto_Index)
       
                If (.nextRoundCount <> 0) Then
                        .nextRoundCount = .nextRoundCount - 1
           
                        If (.nextRoundCount = 0) Then
                                Call warp_Teams(reto_Index, True)
                 
                                .Count_Down = 10
                        End If
                End If
       
                If (.Count_Down <> 0) Then
                        .Count_Down = (.Count_Down - 1)
           
                        If (.Count_Down > 0) Then
                                m = "Reto> " & CStr(.Count_Down)
                        Else
                                m = "Reto> ¡Ya!"
                        End If
           
                        For i = 0 To 1
                                For j = 0 To 1
                                        h = .team_array(i).user_Index(j)
                   
                                        If (h <> 0) Then
                                                If UserList(h).ConnID <> -1 Then
                                                        Call Protocol.WriteConsoleMsg(h, m, FontTypeNames.FONTTYPE_TALK)
                           
                                                        If (.Count_Down = 0) Then Call Protocol.WritePauseToggle(h)
                                                End If
                                        End If
 
                                Next j
                        Next i
 
                End If
 
        End With
   
End Sub
 
Public Function get_reto_index() As Integer
 
        '
        ' @ amishar
   
        Dim LoopC As Long
   
        For LoopC = 0 To UBound(reto_List())
 
                If (reto_List(LoopC).used_ring = False) Then
                        get_reto_index = CInt(LoopC)
 
                        Exit Function
 
                End If
 
        Next LoopC
   
        get_reto_index = -1
 
End Function
 
Public Sub set_reto_struct(ByVal user_Index As Integer, _
                           ByVal my_team As String, _
                           ByRef enemy_name As String, _
                           ByRef team_enemy As String, _
                           ByVal invDrop As Boolean, _
                           ByVal goldAmount As Long)
 
        '
        ' @ amishar
   
        With UserList(user_Index).reto2Data
                .accept_count = 0
         
                With .tempStruct
                        .Count_Down = 0
                        .used_ring = False
             
                        With .team_array(0)
                                .user_Index(0) = user_Index
                                .user_Index(1) = NameIndex(my_team)
                        End With
             
                        With .team_array(1)
                                .user_Index(0) = NameIndex(enemy_name)
                                .user_Index(1) = NameIndex(team_enemy)
                        End With
             
                        With .general_rules
                                .drop_inv = invDrop
                                .gold_gamble = goldAmount
                        End With
             
                End With
         
        End With
 
End Sub
 
Public Sub user_retoLoop(ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        With UserList(user_Index).reto2Data
 
                If (.acceptLimit <> 0) Then
                        .acceptLimit = .acceptLimit - 1
             
                        If (.acceptLimit <= 0) Then
                                Call message_reto(.tempStruct, "El reto se ha autocancelado debido a que el tiempo para aceptar ha llegado a su límite.")
                 
                                Dim j As Long
                                Dim i As Long
                                Dim n As Integer
                                Dim b As userStruct
                 
                                For j = 0 To 1
                                        For i = 0 To 1
                                                n = .tempStruct.team_array(j).user_Index(i)
                         
                                                If n > 0 Then
                                                        If UCase$(UserList(n).reto2Data.nick_sender) = UCase$(UserList(user_Index).Name) Then
                                                                UserList(n).reto2Data.nick_sender = vbNullString
                                                                UserList(n).reto2Data.acceptedOK = False
                                                        End If
                                                End If
 
                                        Next i
                                Next j
                 
                                UserList(user_Index).reto2Data = b
                        End If
                End If
         
                If (.return_city <> 0) Then
                        .return_city = .return_city - 1
             
                        If (.return_city = 0) Then
 
                                Dim p As WorldPos
                 
                                p = Ullathorpe
                 
                                Call FindLegalPos(user_Index, p.map, p.x, p.Y)
                                Call WarpUserChar(user_Index, p.map, p.x, p.Y, True)
                 
                                'Call Protocol.WriteConsoleMsg(user_Index, "Regresas a la ciudad." & RETO_COLOR, FontTypeNames.FONTTYPE_GUILD)
                        End If
             
                End If
 
        End With
 
End Sub
 
Public Sub erase_userData(ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        With UserList(user_Index).reto2Data
   
                Dim dumpStruct As retoStruct
   
                .accept_count = 0
                .nick_sender = vbNullString
                .reto_Index = 0
                .reto_used = False
                .tempStruct = dumpStruct
   
        End With
 
End Sub
 
Public Function can_send_reto(ByVal user_Index As Integer, _
                              ByRef fERROR As String) As Boolean
 
        '
        ' @ amishar
   
        can_send_reto = False
   
        With UserList(user_Index)
 
                If (.flags.Muerto <> 0) Then
                        fERROR = "¡Estás muerto!"
 
                        Exit Function
 
                End If
         
                If (.Counters.Pena <> 0) Then
                        fERROR = "Estás en la cárcel"
 
                        Exit Function
 
                End If
         
                If (.reto2Data.reto_Index <> 0) Or (reto_List(.reto2Data.reto_Index).used_ring) Or (.UserReto.EnReto = True) Then
                        fERROR = "Ya estás en reto"
 
                        Exit Function
 
                End If
                
                
         
                If (.Stats.GLD < .reto2Data.tempStruct.general_rules.gold_gamble) Then
                        fERROR = "No tienes el oro necesario"
 
                        Exit Function
 
                End If
         
                If (.Stats.ELV < 35) Then
                        fERROR = "Debes ser mayor a nivel 35!"
 
                        Exit Function
 
                End If
         
                With .reto2Data.tempStruct
                        can_send_reto = check_User(.team_array(0).user_Index(1), fERROR)
             
                        If (can_send_reto) Then
                                can_send_reto = check_User(.team_array(1).user_Index(0), fERROR)
                        Else
 
                                Exit Function
 
                        End If
             
                        If (can_send_reto) Then
                                can_send_reto = check_User(.team_array(1).user_Index(1), fERROR)
                        Else
 
                                Exit Function
 
                        End If
             
                        If (can_send_reto) Then
                                can_send_reto = check_player_List(user_Index)
                 
                                If Not can_send_reto Then fERROR = "No puedes repetir el nombre de un usuario!"
                        Else
 
                                Exit Function
 
                        End If
             
                End With
        End With
 
End Function
 
Private Function check_User(ByVal user_Index As Integer, _
                            ByRef fERROR As String) As Boolean
 
        '
        ' @ amishar
   
        check_User = False
   
        If (user_Index = 0) Then
                fERROR = "No se ha enviado la solicitud del reto debido a que uno de los usuarios se encuentra desconectado."
 
                Exit Function
 
        End If
   
        With UserList(user_Index)
 
                If (.flags.Muerto <> 0) Then
                        fERROR = .Name & " ¡Está muerto!"
 
                        Exit Function
 
                End If
         
                If (.Counters.Pena <> 0) Then
                        fERROR = .Name & " Está en la cárcel"
 
                        Exit Function
 
                End If
         
                If (.reto2Data.reto_Index <> 0) Then
                        fERROR = .Name & " Ya está en reto"
 
                        Exit Function
 
                End If
         
                If (.Stats.GLD < .reto2Data.tempStruct.general_rules.gold_gamble) Then
                        fERROR = .Name & " No tiene el oro necesario"
 
                        Exit Function
 
                End If
         
                If (.Pos.map <> 1) Then
                        fERROR = .Name & " debe estar en su hogar para retar."
 
                        Exit Function
 
                End If
         
                If (.Stats.ELV < 35) Then
                        fERROR = .Name & " debe ser mayor a nivel 35!"
 
                        Exit Function
 
                End If
         
                check_User = True
        End With
 
End Function
 
Public Sub Send_Reto(ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        With UserList(user_Index).reto2Data
 
                Dim i          As Long
                Dim j          As Long
         
                Dim team_str   As String
                Dim gamble_str As String
         
                team_str = UserList(.tempStruct.team_array(0).user_Index(0)).Name & " y " & UserList(.tempStruct.team_array(0).user_Index(1)).Name & " vs " & UserList(.tempStruct.team_array(1).user_Index(0)).Name & " y " & UserList(.tempStruct.team_array(1).user_Index(1)).Name
         
                gamble_str = " apostando " & Format$(.tempStruct.general_rules.gold_gamble, "#,###") & " monedas de oro"
         
                If (.tempStruct.general_rules.drop_inv) Then
                        gamble_str = " y los items del inventario"
                End If
         
                For i = 0 To 1
                        For j = 0 To 1
                                UserList(.tempStruct.team_array(i).user_Index(j)).reto2Data.nick_sender = UCase$(UserList(user_Index).Name)
                 
                                If (.tempStruct.team_array(i).user_Index(j) <> user_Index) Then
                                        Call Protocol.WriteConsoleMsg(.tempStruct.team_array(i).user_Index(j), UserList(user_Index).Name & " te invita a participar en el reto entre: " & team_str & " " & gamble_str & " para aceptar tipea /ACEPTAR " & UCase$(UserList(user_Index).Name) & "." & vbNewLine & "El tiempo límite para que todos los participantes acepten es de un minuto." & RETO_COLOR, FontTypeNames.FONTTYPE_GUILD)
                                End If
 
                        Next j
                Next i
         
                Call Protocol.WriteConsoleMsg(user_Index, "Se han enviado las solicitudes.", FontTypeNames.FONTTYPE_GUILD)
         
                .acceptLimit = 60
        End With
 
End Sub
 
Public Sub disconnect_Reto(ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        Dim team_Index  As Integer
        Dim team_winner As Byte
        Dim reto_Index  As Integer
   
        reto_Index = UserList(user_Index).reto2Data.reto_Index
   
        team_Index = find_Team(user_Index, reto_Index)
 
        If (team_Index <> -1) Then
                team_winner = IIf(team_Index = 1, 0, 1)
                Call finish_reto(UserList(user_Index).reto2Data.reto_Index, team_winner, True)
        End If
   
End Sub
 
Public Sub Accept_Reto(ByVal user_Index As Integer, ByVal requestName As String)
 
        '
        ' @ amishar
   
        Dim sendIndex As Integer
   
        sendIndex = NameIndex(requestName)
        
        If (sendIndex = 0) Or (UCase$(requestName) <> UserList(user_Index).reto2Data.nick_sender) Then
                Call Protocol.WriteConsoleMsg(user_Index, requestName & " no te está retando!!" & RETO_COLOR, FontTypeNames.FONTTYPE_GUILD)
 
                Exit Sub
 
        End If
        If sendIndex = user_Index Then Exit Sub
   
        If (sendIndex = 0) Then Exit Sub
   
        If UserList(user_Index).reto2Data.acceptedOK Then
                Call Protocol.WriteConsoleMsg(user_Index, "¡Ya has aceptado!" & RETO_COLOR, 1)
 
                Exit Sub
 
        End If
   
        UserList(sendIndex).reto2Data.accept_count = (UserList(sendIndex).reto2Data.accept_count + 1)
   
        Call message_reto(UserList(sendIndex).reto2Data.tempStruct, UserList(user_Index).Name & " aceptó el reto.")
   
        If (UserList(sendIndex).reto2Data.accept_count = 3) Then
                Call message_reto(UserList(sendIndex).reto2Data.tempStruct, "Todos los participantes han aceptado el reto.")
                Call init_reto(sendIndex)
        End If
   
        UserList(user_Index).reto2Data.acceptedOK = True
   
End Sub
 
Private Sub init_reto(ByVal userSendIndex As Integer)
 
        '
        ' @ amishar
   
        Dim reto_Index As Integer
   
        reto_Index = get_reto_index()
   
        If (reto_Index = -1) Then
                Call message_reto(UserList(userSendIndex).reto2Data.tempStruct, "Reto cancelado, todas las arenas están ocupadas.")
 
                Exit Sub
 
        End If
        
        With reto_List(reto_Index)
            Dim lError As String
            Dim x As Long, Y As Long
            For x = 0 To 1
                For Y = 0 To 1
                    If UserList(.team_array(x).user_Index(Y)).Stats.GLD < .general_rules.gold_gamble Then
                        lError = "Uno de los usuarios no tiene suficiente oro"
                    End If
                    ''Call check_User(.team_array(X).user_Index(Y), lError)
                Next Y
            Next x
        
            If LenB(lError) > 0 Then
                For x = 0 To 1
                    For Y = 0 To 1
                        Call WriteConsoleMsg(.team_array(x).user_Index(Y), lError, FontTypeNames.FONTTYPE_INFO)
                    Next Y
                Next x
                Exit Sub
            End If
            For x = 0 To 1
                For Y = 0 To 1
                   UserList(.team_array(x).user_Index(Y)).Stats.GLD = UserList(.team_array(x).user_Index(Y)).Stats.GLD - .general_rules.gold_gamble
                Next Y
            Next x
        End With
        UserList(userSendIndex).reto2Data.acceptLimit = 0
        reto_List(reto_Index) = UserList(userSendIndex).reto2Data.tempStruct
        reto_List(reto_Index).used_ring = True
        reto_List(reto_Index).Count_Down = 10
        
        Call warp_Teams(reto_Index)
        
End Sub
 
Private Sub warp_Teams(ByVal reto_Index As Integer, _
                       Optional ByVal respawnUser As Boolean = False)
 
        '
        ' @ amishar
   
        With reto_List(reto_Index)
 
                Dim LoopC As Long
                Dim mPosX As Byte
                Dim mPosY As Byte
                Dim nUser As Integer
         
                .Count_Down = 10
         
                For LoopC = 0 To 1
                        nUser = .team_array(0).user_Index(LoopC)
             
                        If (nUser <> 0) Then
                                If (UserList(nUser).ConnID <> -1) Then
                                        mPosX = get_pos_x(reto_Index + 1, 1, LoopC + 1)
                                        mPosY = get_pos_y(reto_Index + 1, 1, LoopC + 1)
                     
                                        UserList(nUser).reto2Data.reto_used = True
                     
                                        Call WarpUserChar(nUser, reto_2Map, mPosX, mPosY, True)
                                        Call Protocol.WritePauseToggle(nUser)
                     
                                        If (respawnUser) Then
                                                If (UserList(nUser).flags.Muerto) Then
                                                        Call RevivirUsuario(nUser)
                                                End If
                         
                                                UserList(nUser).Stats.MinHp = UserList(nUser).Stats.MaxHp
                                                UserList(nUser).Stats.MinMAN = UserList(nUser).Stats.MaxMAN
                                                UserList(nUser).Stats.MinHam = 100
                                                UserList(nUser).Stats.MinAGU = 100
                                                UserList(nUser).Stats.MinSta = UserList(nUser).Stats.MaxSta
                         
                                                Call Protocol.WriteUpdateUserStats(nUser)
                                        End If
 
                                Else
                                        UserList(nUser).reto2Data.acceptedOK = False
                                End If
                        End If
 
                Next LoopC
         
                For LoopC = 0 To 1
                        nUser = .team_array(1).user_Index(LoopC)
             
                        If (nUser <> 0) Then
                                If (UserList(nUser).ConnID <> -1) Then
                                        mPosX = get_pos_x(reto_Index + 1, 2, LoopC + 1)
                                        mPosY = get_pos_y(reto_Index + 1, 2, LoopC + 1)
                   
                                        UserList(nUser).reto2Data.reto_used = True
                   
                                        Call WarpUserChar(nUser, reto_2Map, mPosX, mPosY, True)
                                        Call Protocol.WritePauseToggle(nUser)
                     
                                        If (respawnUser) Then
                                                If (UserList(nUser).flags.Muerto) Then
                                                        Call RevivirUsuario(nUser)
                                                End If
                         
                                                UserList(nUser).Stats.MinHp = UserList(nUser).Stats.MaxHp
                                                UserList(nUser).Stats.MinMAN = UserList(nUser).Stats.MaxMAN
                                                UserList(nUser).Stats.MinHam = 100
                                                UserList(nUser).Stats.MinAGU = 100
                                                UserList(nUser).Stats.MinSta = UserList(nUser).Stats.MaxSta
                         
                                                Call Protocol.WriteUpdateUserStats(nUser)
                                        Else
                                                UserList(nUser).reto2Data.acceptedOK = False
                                        End If
                                End If
                        End If
 
                Next LoopC
 
        End With
 
End Sub
 
Private Sub message_reto(ByRef retoStr As retoStruct, ByRef sMessage As String)
 
        '
        ' @ amishar
   
        With retoStr
 
                Dim i As Long
                Dim j As Long
                Dim u As Integer
         
                For i = 0 To 1
                        For j = 0 To 1
                                u = .team_array(i).user_Index(j)
                 
                                If (u <> 0) Then
                                        If (UserList(u).ConnID <> -1) Then
                                                Call Protocol.WriteConsoleMsg(u, sMessage, FontTypeNames.FONTTYPE_GUILD)
                                        End If
                                End If
 
                        Next j
                Next i
 
        End With
   
End Sub
 
Public Sub user_die_reto(ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        Dim team_Index As Integer
        Dim user_slot  As Integer
        Dim other_user As Integer
        Dim reto_Index As Integer
   
        reto_Index = UserList(user_Index).reto2Data.reto_Index
   
        team_Index = find_Team(user_Index, reto_Index)
 
        If (team_Index <> -1) Then
                user_slot = find_user(team_Index, user_Index, reto_Index)
        Else
 
                Exit Sub
 
        End If
 
        If (user_slot = -1) Then Exit Sub
   
        other_user = IIf(user_slot = 0, 1, 0)
        other_user = reto_List(reto_Index).team_array(team_Index).user_Index(other_user)
   
        'is dead?
 
        If (other_user) Then
                If UserList(other_user).flags.Muerto Then
                        Call team_winner(reto_Index, IIf(team_Index = 0, 1, 0))
                End If
 
        Else
                Call team_winner(reto_Index, IIf(team_Index = 0, 1, 0))
        End If
   
End Sub
 
Private Function find_Team(ByVal user_Index As Integer, _
                           ByVal reto_Index As Integer) As Integer
 
        '
        ' @ amishar
   
        Dim i As Long
        Dim j As Long
   
        For i = 0 To 1
                For j = 0 To 1
 
                        If reto_List(reto_Index).team_array(i).user_Index(j) = user_Index Then
                                find_Team = i
 
                                Exit Function
 
                        End If
 
                Next j
        Next i
 
        find_Team = -1
End Function
 
Private Function find_user(ByVal team_Index As Integer, _
                           ByVal user_Index As Integer, _
                           ByVal reto_Index As Integer) As Integer
 
        '
        ' @ amishar
   
        Dim i As Long
   
        For i = 0 To 1
 
                If reto_List(reto_Index).team_array(team_Index).user_Index(i) = user_Index Then
                        find_user = i
 
                        Exit Function
 
                End If
 
        Next i
   
        find_user = -1
 
End Function
 
Private Sub team_winner(ByVal reto_Index As Integer, ByVal team_winner As Byte)
 
        '
        ' @ amishar
   
        With reto_List(reto_Index)
                .team_array(team_winner).round_count = (.team_array(team_winner).round_count + 1)
         
                If (.team_array(team_winner).round_count = 2) Then
                        Call finish_reto(reto_Index, team_winner)
                Else
                        Call respawn_reto(reto_Index, team_winner)
                End If
         
        End With
 
End Sub
 
Private Sub respawn_reto(ByVal reto_Index As Integer, ByVal team_winner As Integer)
 
        '
        ' @ amishar
   
        'Call warp_Teams(reto_Index, True)
   
        Dim loopX As Long
        Dim LoopC As Long
        Dim mStr  As String
        Dim Index As Integer
   
        With reto_List(reto_Index)
   
                mStr = "El equipo " & CStr(team_winner + 1) & " gana este duelo." & vbNewLine & "Resultado parcial : " & CStr(.team_array(0).round_count) & "-" & CStr(.team_array(1).round_count)
       
                For loopX = 0 To 1
                        For LoopC = 0 To 1
                                Index = .team_array(loopX).user_Index(LoopC)
               
                                If (Index <> 0) Then
                                        If UserList(Index).ConnID <> -1 Then
                                                Call Protocol.WriteConsoleMsg(Index, mStr, FontTypeNames.FONTTYPE_GUILD)
                                                ''Call Protocol.WriteConsoleMsg(index, "El siguiente round iniciará en 2 segundos." & RETO_COLOR, FontTypeNames.FONTTYPE_GUILD)
                                        End If
                                End If
 
                        Next LoopC
                Next loopX
       
                .nextRoundCount = 2
       
        End With
   
End Sub
 
Private Sub finish_reto(ByVal reto_Index As Integer, _
                        ByVal team_winner As Byte, _
                        Optional ByVal bClose As Boolean = False)
 
        '
        ' @ amishar
   
        With reto_List(reto_Index)
         
                Dim retoMessage As String
                Dim team_looser As Byte
                Dim temp_index  As Integer
         
                retoMessage = get_reto_message(reto_Index)
         
                retoMessage = retoMessage & ".Ganador equipo " & CStr(team_winner + 1) & IIf(bClose, " por desconexión de un oponente.", ".")
         
                Call SendData(SendTarget.ToAll, 0, Protocol.PrepareMessageConsoleMsg(retoMessage, FontTypeNames.FONTTYPE_INFO))
         
                team_looser = IIf(team_winner = 0, 1, 0)
         
                Dim LoopC  As Long
                Dim byDrop As Boolean
                Dim byGold As Long
         
                byDrop = (.general_rules.drop_inv = True)
                byGold = .general_rules.gold_gamble
         
                With .team_array(team_looser)
 
                        For LoopC = 0 To 1
                                temp_index = .user_Index(LoopC)
                 
                                UserList(temp_index).reto2Data.reto_used = False
                                UserList(temp_index).reto2Data.acceptedOK = False
                 
                                If (byDrop) Then
                                        Call TirarTodosLosItems(temp_index)
                                End If
                                   
                                Call WarpUserChar(temp_index, Ullathorpe.map, Ullathorpe.x + LoopC, Ullathorpe.Y, True)
                                   
                                ''UserList(temp_index).Stats.GLD = (UserList(temp_index).Stats.GLD - byGold)
                 
                                UserList(temp_index).reto2Data.nick_sender = vbNullString
                                UserList(temp_index).reto2Data.reto_Index = 0
                 
                                Call Protocol.WriteUpdateGold(temp_index)
                 
                        Next LoopC
 
                End With
         
                With .team_array(team_winner)
 
                        For LoopC = 0 To 1
                                temp_index = .user_Index(LoopC)
                 
                                UserList(temp_index).reto2Data.reto_used = False
                                UserList(temp_index).reto2Data.acceptedOK = False
                 
                                If (byDrop) Then
                                        UserList(temp_index).reto2Data.return_city = 15
                     
                                        Call Protocol.WriteConsoleMsg(temp_index, "Regresarás a tu hogar en 15 segundos." & RETO_COLOR, FontTypeNames.FONTTYPE_GUILD)
                                Else
                                        Call WarpUserChar(temp_index, 1, 57 + LoopC, 50, True)
                                End If
                 
                                UserList(temp_index).Stats.GLD = (UserList(temp_index).Stats.GLD + (byGold * 1.5))
                                
                                UserList(temp_index).reto2Data.nick_sender = vbNullString
                                UserList(temp_index).reto2Data.reto_Index = 0
                 
                                Call Protocol.WriteUpdateGold(temp_index)
                 
                        Next LoopC
 
                End With
         
                Call clear_data(reto_Index)
         
        End With
 
End Sub
 
Private Sub clear_data(ByVal reto_Index As Integer)
 
        '
        ' @ amishar
   
        With reto_List(reto_Index)
                .Count_Down = 0
         
                With .general_rules
                        .drop_inv = False
                        .gold_gamble = 0
                End With
         
                .used_ring = False
         
                Dim i As Long
         
                For i = 0 To 1
       
                        .team_array(i).user_Index(0) = 0
                        .team_array(i).user_Index(1) = 0
                        .team_array(i).round_count = 0
 
                Next i
         
        End With
 
End Sub
 
Private Function get_reto_message(ByVal reto_Index As Integer) As String
 
        '
        ' @ amishar
   
        Dim tempStr  As String
        Dim tempUser As Integer
   
        With reto_List(reto_Index)
         
                tempStr = "Retos> "
         
                With .team_array(0)
                        tempUser = .user_Index(0)
             
                        If (tempUser <> 0) Then
                                If UserList(tempUser).ConnID <> -1 Then
                                        tempStr = tempStr & UserList(tempUser).Name
                                End If
                        End If
             
                        tempUser = .user_Index(1)
             
                        If (tempUser <> 0) Then
                                If UserList(tempUser).ConnID <> -1 Then
                                        tempStr = tempStr & " y " & UserList(tempUser).Name
                                End If
                        End If
             
                End With
         
                With .team_array(1)
                        tempUser = .user_Index(0)
             
                        If (tempUser <> 0) Then
                                If UserList(tempUser).ConnID <> -1 Then
                                        tempStr = tempStr & " vs " & UserList(tempUser).Name
                                End If
                        End If
             
                        tempUser = .user_Index(1)
             
                        If (tempUser <> 0) Then
                                If UserList(tempUser).ConnID <> -1 Then
                                        tempStr = tempStr & " y " & UserList(tempUser).Name
                                End If
                        End If
             
                End With
         
                With .general_rules
                        tempStr = tempStr & " apuesta " & Format$(.gold_gamble, "#,###") & " monedas de oro"
             
                        If (.drop_inv) Then
                                tempStr = tempStr & " y los items del inventario"
                        End If
 
                End With
         
        End With
   
        get_reto_message = tempStr
 
End Function
 
Public Function get_pos_x(ByVal ring_index As Integer, _
                          ByVal team_Index As Integer, _
                          ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        get_pos_x = reto_RingPos(ring_index, team_Index, user_Index).x
 
End Function
 
Public Function get_pos_y(ByVal ring_index As Integer, _
                          ByVal team_Index As Integer, _
                          ByVal user_Index As Integer)
 
        '
        ' @ amishar
   
        get_pos_y = reto_RingPos(ring_index, team_Index, user_Index).Y
   
End Function

