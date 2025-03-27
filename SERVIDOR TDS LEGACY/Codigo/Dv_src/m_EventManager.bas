Attribute VB_Name = "m_EventManager"
Option Explicit

Private Type tCounters
    TiempoRestante As Integer
    CuentaRegresiva As Byte
    TiempoEspera As Integer
End Type

Private Type tTorneoUser
    Libre As Boolean
    Cupos As Byte
    Jugadores() As Integer
    Pozo As Long
    Counters As tCounters
    SpawnPos As WorldPos
    MapaDesignado As Integer
End Type

Private MAX_TORNEOS As Byte

Private TorneosUser() As tTorneoUser

Private Const COSTO_TORNEO As Long = 350        '1 dolar bue.

Private Sub Load_Torneo_Configs_And_Arena()
    On Error GoTo Errhandler

    MAX_TORNEOS = 2

    Exit Sub
Errhandler:
    Call LogError("Error en Load_Torneo_Configs_And_Arena en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub DarPremioEvento(ByVal UserIndex As Integer, ByVal Oro As Long)

    If UserIndex = 0 Then Call LogError("DarPremioEvento, UI=0" & " oro: " & Oro): Exit Sub

    On Error GoTo Errhandler
1   With UserList(UserIndex)
2       If Oro > 0 Then
3           .Stats.GLD = .Stats.GLD + Oro
4           If .Stats.GLD > MAXORO Then .Stats.GLD = MAXORO
5           Call WriteUpdateGold(UserIndex)
            'Call WriteConsoleMsg(UserIndex, "Has ganado " & Format$(Oro, "###,###,###") & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en DarPremioEvento en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Function UsuarioEnEvento(ByVal UserIndex As Integer) As Boolean
    UsuarioEnEvento = True
    If UserList(UserIndex).mReto.Reto_Index <> 0 Then Exit Function
    If UserList(UserIndex).sReto.Reto_Index <> 0 Then Exit Function
    If UserList(UserIndex).EnEvento <> 0 Then Exit Function
    If UserList(UserIndex).InBotID <> 0 Then Exit Function
    UsuarioEnEvento = False
End Function

Private Function UsuarioPuedeCrearTorneo(ByVal UserIndex As Integer, ByVal Cupos As Byte, ByRef ErrMsg As String, ByRef slotTorneo As Long)
    On Error GoTo Errhandler

    ' @@ Validaciones
1   If UserList(UserIndex).Account = "" Then ErrMsg = "Para crear un torneo debes estar adherido a una cuenta premium desde la web!": Exit Function
3   If val(GetVar(AccPath & UserList(UserIndex).Account & ".acc", "INIT", "TDSPESOS")) < COSTO_TORNEO Then ErrMsg = "Necesitas " & COSTO_TORNEO & " TD$L PESOS": Exit Function
4   If val(GetVar(AccPath & UserList(UserIndex).Account & ".acc", "INIT", "BANNED")) <> 0 Then ErrMsg = "You're banned.": Exit Function
5   If Cupos = 0 Or Not (Cupos Mod 2 = 0) Or Cupos > 32 Then ErrMsg = "Los cupos tienen que ser par y hasta un limite de 32 cupos.)": Exit Function
    ' @@

    Dim i As Long, found As Boolean
    For i = 1 To MAX_TORNEOS
        If TorneosUser(i).Libre Then found = True: Exit For
    Next i
    If Not found Then ErrMsg = "No hay cupos libres para crear un torneo, aguarde a que finalice otro.": Exit Function

7   UsuarioPuedeCrearTorneo = True
    Exit Function
Errhandler:
    Call LogError("Error en UsuarioPuedeCrearTorneo en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Private Function UsuarioCreaTorneo(ByVal UserIndex As Integer, ByVal Cupos As Byte)
    On Error GoTo Errhandler
    Dim ErrMsg As String
    Dim slotTorneo As Long

    If Not UsuarioPuedeCrearTorneo(UserIndex, Cupos, ErrMsg, slotTorneo) Then
        Call WriteConsoleMsg(UserIndex, ErrMsg): Exit Function
    End If

    TorneosUser(slotTorneo).Cupos = Cupos
    TorneosUser(slotTorneo).Pozo = COSTO_TORNEO * 10000
    ReDim TorneosUser(slotTorneo).Jugadores(1 To Cupos)

    TorneosUser(slotTorneo).Counters.TiempoEspera = 180        ' 2 minutos

    Exit Function
Errhandler:
    Call LogError("Error en UsuarioCreaTorneo en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function
