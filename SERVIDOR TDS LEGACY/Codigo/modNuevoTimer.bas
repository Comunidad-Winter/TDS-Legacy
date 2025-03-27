Attribute VB_Name = "modNuevoTimer"
Option Explicit


' CASTING DE HECHIZOS
Public Function IntervaloPermiteLanzarSpell(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()

    If Abs(TActual - UserList(UserIndex).Counters.TimerLanzarSpell) >= INT_CAST_SPELL Then
        If Actualizar Then
            UserList(UserIndex).Counters.TimerLanzarSpell = TActual

        End If
        IntervaloPermiteLanzarSpell = True
    Else
        IntervaloPermiteLanzarSpell = False
    End If

End Function

Public Function IntervaloPermiteAtacar(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()

    If Abs(TActual - UserList(UserIndex).Counters.TimerPuedeAtacar) >= INT_ATTACK Then
        If Actualizar Then
            UserList(UserIndex).Counters.TimerPuedeAtacar = TActual
            UserList(UserIndex).Counters.TimerGolpeUsar = TActual
        End If
        IntervaloPermiteAtacar = True
    Else
        IntervaloPermiteAtacar = False
    End If
End Function

Public Function IntervaloPermiteGolpeUsar(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: ZaMa
'Checks if the time that passed from the last hit is enough for the user to use a potion.
'Last Modification: 06/04/2009
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()

    If Abs(TActual - UserList(UserIndex).Counters.TimerGolpeUsar) >= INT_ATTACK_USEITEM Then
        If Actualizar Then
            UserList(UserIndex).Counters.TimerGolpeUsar = TActual
        End If
        IntervaloPermiteGolpeUsar = True
    Else
        IntervaloPermiteGolpeUsar = False
    End If
End Function

Public Function IntervaloPermiteMagiaGolpe(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    Dim TActual As Long

    With UserList(UserIndex)
        If Abs(.Counters.TimerMagiaGolpe) > .Counters.TimerLanzarSpell Then
            Exit Function
        End If

        TActual = GetTickCount()

        If Abs(TActual - .Counters.TimerLanzarSpell) >= INT_CAST_ATTACK Then
            If Actualizar Then
                .Counters.TimerMagiaGolpe = TActual
                .Counters.TimerPuedeAtacar = TActual
                .Counters.TimerGolpeUsar = TActual
            End If
            IntervaloPermiteMagiaGolpe = True
        Else
            IntervaloPermiteMagiaGolpe = False
        End If
    End With
End Function

Public Function IntervaloPermiteGolpeMagia(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim TActual As Long

    If UserList(UserIndex).Counters.TimerGolpeMagia > UserList(UserIndex).Counters.TimerPuedeAtacar Then
        Exit Function
    End If

    TActual = GetTickCount()

    If Abs(TActual - UserList(UserIndex).Counters.TimerPuedeAtacar) >= INT_ATTACK_CAST Then
        If Actualizar Then
            UserList(UserIndex).Counters.TimerGolpeMagia = TActual
            UserList(UserIndex).Counters.TimerLanzarSpell = TActual
        End If
        IntervaloPermiteGolpeMagia = True
    Else
        IntervaloPermiteGolpeMagia = False
    End If
End Function

' ATAQUE CUERPO A CUERPO
'Public Function IntervaloPermiteAtacar(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'Dim TActual As Long
'
'TActual = GetTickCount()''
'
'If TActual - UserList(UserIndex).Counters.TimerPuedeAtacar >= IntervaloUserPuedeAtacar Then
'    If Actualizar Then UserList(UserIndex).Counters.TimerPuedeAtacar = TActual
'    IntervaloPermiteAtacar = True
'Else
'    IntervaloPermiteAtacar = False
'End If
'End Function

' TRABAJO
Public Function IntervaloPermiteTrabajar(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()
    Dim curint As Long

    Select Case UserList(UserIndex).Stats.ELV
    Case Is <= 5
        curint = 1075
    Case Is < 14
        curint = 1050
    Case Is < 24
        curint = 1020
    Case Is >= 24
        curint = 970
    End Select

    If TActual - UserList(UserIndex).Counters.TimerPuedeTrabajar >= curint Then
        If Actualizar Then UserList(UserIndex).Counters.TimerPuedeTrabajar = TActual
        IntervaloPermiteTrabajar = True
    Else
        IntervaloPermiteTrabajar = False
    End If

End Function

' USAR OBJETOS
Public Function IntervaloPermiteUsar(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 25/01/2010 (ZaMa)
'25/01/2010: ZaMa - General adjustments.
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()

    If TActual - UserList(UserIndex).Counters.TimerUsar >= INT_USEITEM Then
        If Actualizar Then
            UserList(UserIndex).Counters.TimerUsar = TActual
            'UserList(UserIndex).Counters.failedUsageAttempts = 0
        End If
        IntervaloPermiteUsar = True
    Else
        IntervaloPermiteUsar = False

        'UserList(UserIndex).Counters.failedUsageAttempts = UserList(UserIndex).Counters.failedUsageAttempts + 1

        'Tolerancia arbitraria - 20 es MUY alta, la está chiteando zarpado
        'If UserList(UserIndex).Counters.failedUsageAttempts = 20 Then
        'Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(UserList(UserIndex).name & " kicked by the server por posible modificación de intervalos.", FontTypeNames.FONTTYPE_FIGHT))
        'Call CloseSocket(UserIndex)
        'End If
    End If

End Function

Public Function IntervaloPermiteUsarClick(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean

    If haciendoBK Then Exit Function

    Dim TActual As Long
    TActual = GetTickCount And &H7FFFFFFF

    With UserList(UserIndex)

        If getInterval(TActual, .Counters.TimerUsarClick) >= INT_USEITEMDCK Then        ' 0.13.5

            If Actualizar Then
                '.Counters.TimerUsar = TActual
                .Counters.TimerUsarClick = TActual
            Else
                ' "USAR CLIC! " & TActual - .Counters.TimerUsarClick & "ms"
            End If

            IntervaloPermiteUsarClick = True

        Else

            '"NO USAR CLIC! " & TActual - .Counters.TimerUsarClick & "ms"
            IntervaloPermiteUsarClick = False

        End If

    End With

End Function
Public Function IntervaloPermiteUsarArcos(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = True) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim TActual As Long

    TActual = GetTickCount()

    If Abs(TActual - UserList(UserIndex).Counters.TimerPuedeUsarArco) >= IIf(UserList(UserIndex).Clase = eClass.Warrior, INT_ARROWSW, INT_ARROWS) Then

        If Actualizar Then
            UserList(UserIndex).Counters.TimerPuedeAtacar = TActual
            UserList(UserIndex).Counters.TimerPuedeUsarArco = TActual
        End If

        IntervaloPermiteUsarArcos = True
    Else
        IntervaloPermiteUsarArcos = False
    End If

End Function

Public Function IntervaloPermiteSerAtacado(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = False) As Boolean
'**************************************************************
'Author: ZaMa
'Last Modify by: ZaMa
'Last Modify Date: 13/11/2009
'13/11/2009: ZaMa - Add the Timer which determines wether the user can be atacked by a NPc or not
'**************************************************************
    Dim TActual As Long

    TActual = GetTickCount()

    With UserList(UserIndex)
        ' Inicializa el timer
        If Actualizar Then
            .Counters.TimerPuedeSerAtacado = TActual
            .flags.NoPuedeSerAtacado = True
            IntervaloPermiteSerAtacado = False
        Else
            If Abs(TActual - .Counters.TimerPuedeSerAtacado) >= IntervaloPuedeSerAtacado Then
                .flags.NoPuedeSerAtacado = False
                IntervaloPermiteSerAtacado = True
            Else
                IntervaloPermiteSerAtacado = False
            End If
        End If
    End With

End Function

Public Function IntervaloPerdioNpc(ByVal UserIndex As Integer, Optional ByVal Actualizar As Boolean = False) As Boolean
'**************************************************************
'Author: ZaMa
'Last Modify by: ZaMa
'Last Modify Date: 13/11/2009
'13/11/2009: ZaMa - Add the Timer which determines wether the user still owns a Npc or not
'**************************************************************
    Dim TActual As Long

    TActual = GetTickCount()

    With UserList(UserIndex)
        ' Inicializa el timer
        If Actualizar Then
            .Counters.TimerPerteneceNpc = TActual
            IntervaloPerdioNpc = False
        Else
            If Abs(TActual - .Counters.TimerPerteneceNpc) >= IntervaloOwnedNpc Then
                IntervaloPerdioNpc = True
            Else
                IntervaloPerdioNpc = False
            End If
        End If
    End With

End Function

Public Function NpcIntervaloGolpe(ByVal NpcIndex As Integer, _
                                  Optional ByVal Actualizar As Boolean = True) As Boolean
    Dim TActual As Long

    TActual = GetTickCount()

    If Abs(TActual - Npclist(NpcIndex).Contadores.Ataque) >= 1800 Then
        If Actualizar Then
            Npclist(NpcIndex).Contadores.Ataque = TActual

        End If

        NpcIntervaloGolpe = True

    Else
        NpcIntervaloGolpe = False
        Exit Function

    End If

End Function

Public Function checkInterval(ByRef StartTime As Long, _
                              ByVal TimeNow As Long, _
                              ByVal Interval As Long) As Boolean

    Dim lInterval As Long

    If TimeNow < StartTime Then
        lInterval = &H7FFFFFFF - StartTime + TimeNow + 1
    Else
        lInterval = TimeNow - StartTime

    End If

    If lInterval >= Interval Then
        StartTime = TimeNow
        checkInterval = True
    Else
        checkInterval = False

    End If

End Function


Public Function getInterval(ByVal TimeNow As Long, _
                            ByVal StartTime As Long) As Long        ' 0.13.5

    If TimeNow < StartTime Then
        getInterval = &H7FFFFFFF - StartTime + TimeNow + 1
    Else
        getInterval = TimeNow - StartTime

    End If

End Function




