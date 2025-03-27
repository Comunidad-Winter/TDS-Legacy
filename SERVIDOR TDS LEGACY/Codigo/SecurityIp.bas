Attribute VB_Name = "SecurityIp"
Option Explicit

Private IpTables() As Long        'USAMOS 2 LONGS: UNO DE LA IP, SEGUIDO DE UNO DE LA INFO
Private EntrysCounter As Long
Private MaxValue As Long
Private Multiplicado As Long        'Cuantas veces multiplike el EntrysCounter para que me entren?
Private Const IntervaloEntreConexiones As Long = 750

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'Declaraciones para maximas conexiones por usuario
'Agregado por EL OSO
Private MaxConTables() As Long
Private MaxConTablesEntry As Long        'puntero a la ultima insertada

Private Const LIMITECONEXIONESxIP As Long = 10

Private Enum e_SecurityIpTabla
    IP_INTERVALOS = 1
    IP_LIMITECONEXIONES = 2
End Enum

Private Const limite_de_personajes_k As Integer = 20
Private Type jugador_t
    ip_v As String
    personajes_creados_v As Long
End Type

Private jugadores_m() As jugador_t


Public Sub InitIpTables(ByVal OptCountersValue As Long)
'*************************************************  *************
'Author: Lucio N. Tourrilhes (DuNga)
'Last Modify Date: EL OSO 21/01/06. Soporte para MaxConTables
'
'*************************************************  *************
    EntrysCounter = OptCountersValue
    Multiplicado = 1

    ReDim IpTables(EntrysCounter * 2) As Long
    MaxValue = 0

    ReDim MaxConTables(maxUsers * 2 - 1) As Long
    MaxConTablesEntry = 0

End Sub

Public Sub IpSecurityMantenimientoLista()
'*************************************************  *************
'Author: Lucio N. Tourrilhes (DuNga)
'Last Modify Date: Unknow
'
'*************************************************  *************
'Las borro todas cada 1 hora, asi se "renuevan"
    EntrysCounter = EntrysCounter \ Multiplicado
    Multiplicado = 1
    ReDim IpTables(EntrysCounter * 2) As Long
    MaxValue = 0
End Sub

Public Function IpSecurityAceptarNuevaConexion(ByVal IP As Long) As Boolean

    Dim IpTableIndex As Long

    IpTableIndex = FindTableIp(IP, IP_INTERVALOS)

    If IpTableIndex >= 0 Then
        If IpTables(IpTableIndex + 1) + IntervaloEntreConexiones <= (GetTickCount()) Then        'No está saturando de connects?
            IpTables(IpTableIndex + 1) = GetTickCount()
            IpSecurityAceptarNuevaConexion = True
            'Debug.Print Now, "CONEXION ACEPTADA"
            Exit Function
        Else
            IpSecurityAceptarNuevaConexion = False
            Exit Function
        End If
    Else
        IpTableIndex = Not IpTableIndex
        AddNewIpIntervalo IP, IpTableIndex
        IpTables(IpTableIndex + 1) = GetTickCount()
        IpSecurityAceptarNuevaConexion = True
        Exit Function
    End If

End Function


Private Sub AddNewIpIntervalo(ByVal IP As Long, ByVal Index As Long)
'*************************************************  *************
'Author: Lucio N. Tourrilhes (DuNga)
'Last Modify Date: Unknow
'
'*************************************************  *************
'2) Pruebo si hay espacio, sino agrando la lista
    If MaxValue + 1 > EntrysCounter Then
        EntrysCounter = EntrysCounter \ Multiplicado
        Multiplicado = Multiplicado + 1
        EntrysCounter = EntrysCounter * Multiplicado

        ReDim Preserve IpTables(EntrysCounter * 2) As Long
    End If

    '4) Corro todo el array para arriba
    Call CopyMemory(IpTables(Index + 2), IpTables(Index), (MaxValue - Index \ 2) * 8)        '*4 (peso del long) * 2(cantidad de elementos por c/u)
    IpTables(Index) = IP

    '3) Subo el indicador de el maximo valor almacenado y listo :)
    MaxValue = MaxValue + 1
End Sub

' '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' ''''''''''''''''''''FUNCIONES PARA LIMITES X IP''''''''''''''''''''''''''''''''
' '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Public Function IPSecuritySuperaLimiteConexiones(ByVal IP As Long) As Boolean
    Dim IpTableIndex As Long

    IpTableIndex = FindTableIp(IP, IP_LIMITECONEXIONES)

    If IpTableIndex >= 0 Then

        If MaxConTables(IpTableIndex + 1) < LIMITECONEXIONESxIP Then
            MaxConTables(IpTableIndex + 1) = MaxConTables(IpTableIndex + 1) + 1
            IPSecuritySuperaLimiteConexiones = False
        Else
            IPSecuritySuperaLimiteConexiones = True
        End If
    Else
        IPSecuritySuperaLimiteConexiones = False
        If MaxConTablesEntry < maxUsers Then        'si hay espacio..
            IpTableIndex = Not IpTableIndex
            AddNewIpLimiteConexiones IP, IpTableIndex        'iptableindex es donde lo agrego
            MaxConTables(IpTableIndex + 1) = 1
        Else
            Call LogCriticEvent("SecurityIP.IPSecuritySuperaLimiteConexiones: Se supero la disponibilidad de slots.")
        End If
    End If

End Function

Private Sub AddNewIpLimiteConexiones(ByVal IP As Long, ByVal Index As Long)
'*************************************************  *************
'Author: (EL OSO)
'Last Modify Date: Unknow
'
'*************************************************  *************
'g.Print "agrega conexion a " & ip
'g.Print "(MaxUsers - index) = " & (MaxUsers - Index)
'4) Corro todo el array para arriba
'Call CopyMemory(MaxConTables(Index + 2), MaxConTables(Index), (MaxConTablesEntry - Index \ 2) * 8)    '*4 (peso del long) * 2(cantidad de elementos por c/u)
'MaxConTables(Index) = ip

'3) Subo el indicador de el maximo valor almacenado y listo :)
'MaxConTablesEntry = MaxConTablesEntry + 1


'*************************************************    *************
'Author: (EL OSO)
'Last Modify Date: 16/2/2006
'Modified by Juan Martín Sotuyo Dodero (Maraxus)
'*************************************************    *************


'4) Corro todo el array para arriba
    Dim temp() As Long
    ReDim temp((MaxConTablesEntry - Index \ 2) * 2) As Long        'VB no deja inicializar con rangos variables...
    Call CopyMemory(temp(0), MaxConTables(Index), (MaxConTablesEntry - Index \ 2) * 8)        '*4 (peso del long) * 2(cantidad de elementos por c/u)
    Call CopyMemory(MaxConTables(Index + 2), temp(0), (MaxConTablesEntry - Index \ 2) * 8)        '*4 (peso del long) * 2(cantidad de elementos por c/u)
    MaxConTables(Index) = IP

    '3) Subo el indicador de el maximo valor almacenado y listo :)
    MaxConTablesEntry = MaxConTablesEntry + 1

End Sub

Public Sub IpRestarConexion(ByVal IP As Long)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim key As Long


    key = FindTableIp(IP, IP_LIMITECONEXIONES)

    If key >= 0 Then
        If MaxConTables(key + 1) > 0 Then
            MaxConTables(key + 1) = MaxConTables(key + 1) - 1
        End If
        If MaxConTables(key + 1) <= 0 Then
            'la limpiamos
            Call CopyMemory(MaxConTables(key), MaxConTables(key + 2), (MaxConTablesEntry - (key \ 2) + 1) * 8)
            MaxConTablesEntry = MaxConTablesEntry - 1
        End If
    End If
End Sub

Private Function FindTableIp(ByVal IP As Long, ByVal Tabla As e_SecurityIpTabla) As Long

    Dim First As Long
    Dim Last As Long
    Dim Middle As Long

    Select Case Tabla
    Case e_SecurityIpTabla.IP_INTERVALOS
        First = 0
        Last = MaxValue
        Do While First <= Last
            Middle = (First + Last) \ 2

            If (IpTables(Middle * 2) < IP) Then
                First = Middle + 1
            ElseIf (IpTables(Middle * 2) > IP) Then
                Last = Middle - 1
            Else
                FindTableIp = Middle * 2
                Exit Function
            End If
        Loop
        FindTableIp = Not (Middle * 2)

    Case e_SecurityIpTabla.IP_LIMITECONEXIONES

        First = 0
        Last = MaxConTablesEntry

        Do While First <= Last
            Middle = (First + Last) \ 2

            If MaxConTables(Middle * 2) < IP Then
                First = Middle + 1
            ElseIf MaxConTables(Middle * 2) > IP Then
                Last = Middle - 1
            Else
                FindTableIp = Middle * 2
                Exit Function
            End If
        Loop
        FindTableIp = Not (Middle * 2)
    End Select
End Function

Public Sub seguridad_clones_construir()
100 On Error GoTo seguridad_clones_construir_Err
102 ReDim jugadores_m(0)
    Exit Sub
seguridad_clones_construir_Err:
104 Call LogError("modSeguridadClones.seguridad_clones_construir_Err en " & Erl & ". err: " & Err.Number & " " & Err.Description)
106 Resume Next
End Sub

Public Sub seguridad_clones_destruir()
100 On Error GoTo seguridad_clones_destruir_Err
102 Erase jugadores_m()
    Exit Sub
seguridad_clones_destruir_Err:
104 Call LogError("modSeguridadClones.seguridad_clones_destruir_Err en " & Erl & ". err: " & Err.Number & " " & Err.Description)
106 Resume Next
End Sub

Public Function seguridad_clones_validar(ByVal ip_p As String) As Boolean
100 On Error GoTo seguridad_clones_validar_err
102 Dim iterador_v As Long
104 ip_p = UCase$(ip_p)
106 For iterador_v = LBound(jugadores_m) To UBound(jugadores_m)
108     With jugadores_m(iterador_v)
110         If .ip_v = ip_p Then
112             If .personajes_creados_v >= limite_de_personajes_k Then
114                 seguridad_clones_validar = False
116                 Exit Function
118             Else

120                 .personajes_creados_v = .personajes_creados_v + 1
122                 seguridad_clones_validar = True
124                 Exit Function
126             End If
128         End If
        End With
    Next
130 ReDim Preserve jugadores_m(LBound(jugadores_m) To UBound(jugadores_m) + 1)
132 With jugadores_m(UBound(jugadores_m))
134     .ip_v = ip_p
136     .personajes_creados_v = 1
    End With
138 seguridad_clones_validar = True
    Exit Function
seguridad_clones_validar_err:
140 Call LogError("modSeguridadClones.seguridad_clones_validar en " & Erl & ". err: " & Err.Number & " " & Err.Description)
142 Resume Next
End Function

Public Sub seguridad_clones_limpiar()
100 On Error GoTo seguridad_clones_limpiar_Err
102 Erase jugadores_m()
104 ReDim jugadores_m(0)
    Exit Sub
seguridad_clones_limpiar_Err:
106 Call LogError("modSeguridadClones.seguridad_clones_limpiar en " & Erl & ". err: " & Err.Number & " " & Err.Description)
108 Resume Next
End Sub
