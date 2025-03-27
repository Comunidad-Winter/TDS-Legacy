Attribute VB_Name = "mod_EXPBonus"
Option Explicit


Public Sub EXP_BONUS_CheckTime(ByVal UserIndex As Integer)

    If UserList(UserIndex).Stats.ELV < CONFIG_INI_BONUSELVMIN Then Exit Sub

    If UserList(UserIndex).Clase = eClass.Blacksmith Or _
       UserList(UserIndex).Clase = eClass.Carpenter Or _
       UserList(UserIndex).Clase = eClass.Fisherman Or _
       UserList(UserIndex).Clase = eClass.Miner Or _
       UserList(UserIndex).Clase = eClass.Woodcutter _
       And CONFIG_INI_BONUSALLOWWORKERS > 0 Then Exit Sub
    UserList(UserIndex).Counters.tBonif = 3600

End Sub

Public Sub EXP_BONUS_Tick(ByVal UserIndex As Integer)
    
    Exit Sub
    
    If CONFIG_INI_BONUSNEEDACCOUNT <> 0 And UserList(UserIndex).account_id = 0 Then Exit Sub
    If UserList(UserIndex).Counters.tBonif = 0 Then Exit Sub

    If UserList(UserIndex).Counters.LeveleandoTick > 0 Then
        UserList(UserIndex).Counters.LeveleandoTick = UserList(UserIndex).Counters.LeveleandoTick - 1
        If UserList(UserIndex).Counters.LeveleandoTick = 0 Then
            Call WriteBonifStatus(UserIndex)
        End If
    Else
        Exit Sub
    End If

    ' Reviso si estoy en zona segura, vivo y ganando experiencia
    If MapInfo(UserList(UserIndex).Pos.map).pk And UserList(UserIndex).flags.Muerto = 0 And UserList(UserIndex).Counters.tBonif > 0 Then
        UserList(UserIndex).Counters.tBonif = UserList(UserIndex).Counters.tBonif - 1
        If UserList(UserIndex).Counters.tBonif = 0 Then
            Call WriteBonifStatus(UserIndex)
            Exit Sub
        End If
    End If

    Exit Sub
ErrHandler:
    Call LogError("Error en EXP_BONUS_Tick en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Public Sub EXP_BONUS_PASSMINUTE(ByVal UserIndex As Integer)
    On Error GoTo ErrHandler
    ' @@ Check if is a new day for reset variables bue
ErrHandler:
    Call LogError("Error en EXP_BONUS_PASSMINUTE en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub CalcularExpExtra(ByVal UserIndex As Integer, ByVal npcIndex As Integer, ByVal ElDaño As Long, ByRef ExpADar As Long)
    On Error GoTo ErrHandler
    ' @@ Aplicaria si no está en party, si está en parte lo calcula en el modParty
    If UserList(UserIndex).Counters.tBonif > 0 And UserList(UserIndex).Counters.LeveleandoTick > 0 Then
        ExpADar = CLng(ElDaño * ((Npclist(npcIndex).GiveEXP_Orig * (ExpMulti + CONFIG_INI_MULTIEXP)) / Npclist(npcIndex).Stats.MaxHP))
    End If
    Exit Sub
ErrHandler:
    Call LogError("Error en CalcularExpExtra en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub
