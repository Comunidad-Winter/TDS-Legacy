Attribute VB_Name = "InvUsuario"
Option Explicit

Public Function TieneObjetosRobables(ByVal UserIndex As Integer) As Boolean

'17/09/02
'Agregue que la función se asegure que el objeto no es un barco

    On Error GoTo Errhandler

    Dim i As Long
    Dim ObjIndex As Integer

1   For i = 1 To UserList(UserIndex).CurrentInventorySlots
2       ObjIndex = UserList(UserIndex).Invent.Object(i).ObjIndex
3       If ObjIndex > 0 Then
4           If (ObjData(ObjIndex).OBJType <> eOBJType.otLlaves And _
                ObjData(ObjIndex).OBJType <> eOBJType.otBarcos) Then
5               TieneObjetosRobables = True
                Exit Function
            End If

        End If
    Next i
    Exit Function
Errhandler:
    Call LogError("Error en TieneObjetosRobables en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Function

Function ClasePuedeUsarItem(ByVal UserIndex As Integer, ByVal ObjIndex As Integer) As Boolean

    On Error GoTo manejador

    'Admins can use ANYTHING!
    If UserList(UserIndex).flags.Privilegios = PlayerType.User Then
        If ObjData(ObjIndex).ClaseProhibida(1) <> 0 Then
            Dim i As Long
            For i = 1 To NUMCLASES
                If ObjData(ObjIndex).ClaseProhibida(i) = UserList(UserIndex).Clase Then
                    ClasePuedeUsarItem = False
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_157
                    Exit Function
                End If
            Next i
        End If
    End If

    ClasePuedeUsarItem = True

    Exit Function

manejador:
    LogError ("Error en ClasePuedeUsarItem")
End Function

Sub QuitarFULLItem(ByVal UserIndex As Integer, ByVal ItemIndex As Integer)

    On Error GoTo Errhandler

    Dim j As Long

1   With UserList(UserIndex)
2       For j = 1 To UserList(UserIndex).CurrentInventorySlots
3           If .Invent.Object(j).ObjIndex > 0 Then

4               If .Invent.Object(j).ObjIndex = ItemIndex Then
5                   Call QuitarUserInvItem(UserIndex, j, MAX_INVENTORY_OBJS)
6               End If
7               Call UpdateUserInv(False, UserIndex, j)
8
            End If
        Next j

9       For j = 1 To MAX_BANCOINVENTORY_SLOTS
            If .BancoInvent.Object(j).ObjIndex = ItemIndex Then
13              Call QuitarObjetosBove(ItemIndex, .BancoInvent.Object(j).Amount, UserIndex)
            End If
        Next j
    End With

    Exit Sub
Errhandler:
    Call LogError("Al QuitarFULLItem en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub
Sub QuitarNewbieObj(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim j As Long

    With UserList(UserIndex)
        For j = 1 To UserList(UserIndex).CurrentInventorySlots
            If .Invent.Object(j).ObjIndex > 0 Then

                If ObjData(.Invent.Object(j).ObjIndex).Newbie = 1 Then _
                   Call QuitarUserInvItem(UserIndex, j, MAX_INVENTORY_OBJS)
                Call UpdateUserInv(False, UserIndex, j)

            End If
        Next j

        If UCase$(MapInfo(.Pos.Map).Restringir) = "NEWBIE" Then
            Dim DeDonde As WorldPos
            Select Case .Hogar
            Case eCiudad.cLindos
                DeDonde = Lindos
            Case eCiudad.cUllathorpe
                DeDonde = Ullathorpe
            Case eCiudad.cBanderbill
                DeDonde = Banderbill
            Case Else
                DeDonde = Nix
            End Select
            Call WarpUserChar(UserIndex, DeDonde.Map, DeDonde.X, DeDonde.Y, True)
        End If

    End With

End Sub

Sub LimpiarInventario(ByVal UserIndex As Integer)

    Dim j As Long

    With UserList(UserIndex)
        For j = 1 To .CurrentInventorySlots
            .Invent.Object(j).ObjIndex = 0
            .Invent.Object(j).Amount = 0
            .Invent.Object(j).Equipped = 0
        Next j

        .Invent.ArmourEqpObjIndex = 0
        .Invent.ArmourEqpSlot = 0

        .Invent.WeaponEqpObjIndex = 0
        .Invent.WeaponEqpSlot = 0

        .Invent.CascoEqpObjIndex = 0
        .Invent.CascoEqpSlot = 0

        .Invent.EscudoEqpObjIndex = 0
        .Invent.EscudoEqpSlot = 0

        .Invent.AnilloEqpObjIndex = 0
        .Invent.AnilloEqpSlot = 0

        .Invent.AnilloEqpObjIndex2 = 0
        .Invent.AnilloEqpSlot2 = 0

        .Invent.MunicionEqpObjIndex = 0
        .Invent.MunicionEqpSlot = 0

        .Invent.BarcoObjIndex = 0
        .Invent.BarcoSlot = 0

    End With

End Sub

Sub TirarOro(ByVal cantidad As Long, ByVal UserIndex As Integer)
    On Error GoTo Errhandler

    'If Cantidad > 100000 Then Exit Sub

    With UserList(UserIndex)

        If cantidad > .Stats.GLD Then cantidad = .Stats.GLD
        If (cantidad > 0) And (cantidad <= .Stats.GLD) Then
            Dim MiObj As Obj

            Dim loops As Long


            Dim Extra As Long
            Dim TeniaOro As Long
            TeniaOro = .Stats.GLD
            If cantidad > 500000 Then        'Para evitar explotar demasiado
                Extra = cantidad - 500000
                cantidad = 500000
            End If

            Do While (cantidad > 0)

                If cantidad > MAX_INVENTORY_OBJS And .Stats.GLD > MAX_INVENTORY_OBJS Then
                    MiObj.Amount = MAX_INVENTORY_OBJS
                    cantidad = cantidad - MiObj.Amount
                Else
                    MiObj.Amount = cantidad
                    cantidad = cantidad - MiObj.Amount
                End If


                MiObj.ObjIndex = iORO

                If EsGM(UserIndex) Then Call LogGM(.Name, "Tiró cantidad:" & MiObj.Amount & " Objeto:" & ObjData(MiObj.ObjIndex).Name)
                Dim auxPos As WorldPos

                If .Clase = eClass.Pirat And .Invent.BarcoObjIndex = 476 Then
                    auxPos = TirarItemAlPiso(.Pos, MiObj, False)
                    If auxPos.X <> 0 And auxPos.Y <> 0 Then
                        .Stats.GLD = .Stats.GLD - MiObj.Amount
                    End If
                Else
                    auxPos = TirarItemAlPiso(.Pos, MiObj, True)
                    If auxPos.X <> 0 And auxPos.Y <> 0 Then
                        .Stats.GLD = .Stats.GLD - MiObj.Amount
                    End If
                End If

                loops = loops + 1
                If loops > 100 Then
                    LogError ("Error en tiraroro")
                    Exit Sub
                End If

            Loop
            If TeniaOro = .Stats.GLD Then Extra = 0
            If Extra > 0 Then
                .Stats.GLD = .Stats.GLD - Extra
            End If

        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en TirarOro. Error " & Err.Number & " : " & Err.Description)
End Sub

Sub QuitarUserInvItem(ByVal UserIndex As Integer, ByVal Slot As Byte, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub    'UserList(userIndex).CurrentInventorySlots Then Exit Sub

    With UserList(UserIndex).Invent.Object(Slot)
        If .Amount <= cantidad And .Equipped = 1 Then
            Call Desequipar(UserIndex, Slot, True)
        End If

        .Amount = .Amount - cantidad
        If .Amount <= 0 Then
            .ObjIndex = 0
            .Amount = 0
        End If
    End With

    Exit Sub

Errhandler:
    Call LogError("Error en QuitarUserInvItem. Error " & Err.Number & " : " & Err.Description)

End Sub

Sub UpdateUserInv(ByVal UpdateAll As Boolean, ByVal UserIndex As Integer, ByVal Slot As Byte)

    On Error GoTo Errhandler

    Dim NullObj As UserOBJ
    Dim LoopC As Long

    With UserList(UserIndex)
        'Actualiza un solo slot
        If Not UpdateAll Then
            'Actualiza el inventario
            If .Invent.Object(Slot).ObjIndex > 0 Then
                Call ChangeUserInv(UserIndex, Slot, .Invent.Object(Slot))
            Else
                Call ChangeUserInv(UserIndex, Slot, NullObj)
            End If
        Else
            'Actualiza todos los slots
            For LoopC = 1 To .CurrentInventorySlots
                'Actualiza el inventario
                If .Invent.Object(LoopC).ObjIndex > 0 Then
                    Call ChangeUserInv(UserIndex, LoopC, .Invent.Object(LoopC))
                Else
                    Call ChangeUserInv(UserIndex, LoopC, NullObj)
                End If
            Next LoopC
        End If

        Exit Sub
    End With

Errhandler:
    Call LogError("Error en UpdateUserInv. Error " & Err.Number & " : " & Err.Description)

End Sub

Sub UpdateUserInvSlot(ByVal UserIndex As Integer, ByVal Slot As Byte)

'Actualiza un solo slot
    With UserList(UserIndex)
        If .Invent.Object(Slot).ObjIndex > 0 Then
            Call ChangeUserInv(UserIndex, Slot, .Invent.Object(Slot))
            Exit Sub
        End If
    End With

    Dim NullObj As UserOBJ
    Call ChangeUserInv(UserIndex, Slot, NullObj)

End Sub

Sub UpdateUserInvAll(ByVal UserIndex As Integer)

    Dim NullObj As UserOBJ
    Dim LoopC As Long

    With UserList(UserIndex)

        'Actualiza todos los slots
        For LoopC = 1 To .CurrentInventorySlots
            'Actualiza el inventario
            If .Invent.Object(LoopC).ObjIndex > 0 Then
                Call ChangeUserInv(UserIndex, LoopC, .Invent.Object(LoopC))
            Else
                Call ChangeUserInv(UserIndex, LoopC, NullObj)
            End If
        Next LoopC

    End With

End Sub

Sub DropObj(ByVal UserIndex As Integer, ByVal Slot As Byte, ByVal num As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    On Error GoTo Errhandler

    Dim Obj As Obj

1   With UserList(UserIndex)
2       If num > 0 Then

3           If num > .Invent.Object(Slot).Amount Then num = .Invent.Object(Slot).Amount

4           Obj.ObjIndex = .Invent.Object(Slot).ObjIndex
5           Obj.Amount = num

6           If (ItemNewbie(Obj.ObjIndex) And Not EsGM(UserIndex)) Then
7               If .flags.Muerto = 0 Then
8                   Call WriteConsoleMsg(UserIndex, "No puedes tirar objetos newbie.", FontTypeNames.FONTTYPE_INFO)
9               End If
                Exit Sub
            End If

            'Check objeto en el suelo
10          If MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex = 0 Or (MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex = Obj.ObjIndex And MapData(.Pos.Map, X, Y).ObjInfo.Amount + Obj.Amount < MAX_INVENTORY_OBJS) Then
11              If num + MapData(.Pos.Map, X, Y).ObjInfo.Amount > MAX_INVENTORY_OBJS Then
12                  num = MAX_INVENTORY_OBJS - MapData(.Pos.Map, X, Y).ObjInfo.Amount
13              End If

14              Call MakeObj(Obj, Map, X, Y)
15              Call QuitarUserInvItem(UserIndex, Slot, num)
16              Call UpdateUserInv(False, UserIndex, Slot)

17              If ObjData(Obj.ObjIndex).OBJType = eOBJType.otBarcos Then
18                  WriteMensajes UserIndex, e_Mensajes.Mensaje_150
                End If

19              If ObjData(Obj.ObjIndex).Caos > 0 Or ObjData(Obj.ObjIndex).Real > 0 Then
20                  WriteMensajes UserIndex, e_Mensajes.Mensaje_151
                End If

21              If Obj.ObjIndex = 406 Then        'hardcoded
22                  Call SendData(ToAll, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " ha tirado una Gema Lunar. Se encuentra en el mapa " & UserList(UserIndex).Pos.Map & ", " & .Pos.X & ", " & .Pos.Y, FontTypeNames.FONTTYPE_GUILD))
                End If

23              If EsGM(UserIndex) Then Call LogGM(.Name, "Tiró cantidad:" & num & " Objeto:" & ObjData(Obj.ObjIndex).Name & " - Pos:" & Map & "-" & X & "-" & Y)

                'Log de Objetos que se tiran al piso. Pablo (ToxicWaste) 07/09/07
                'Es un Objeto que tenemos que loguear?
24              If ObjData(Obj.ObjIndex).Log = 1 Then
25                  Call LogDesarrollo(.Name & " -DropT- " & Obj.Amount & " " & ObjData(Obj.ObjIndex).Name & " Pos:" & Map & "-" & X & "-" & Y)
                ElseIf Obj.Amount > 5000 Then        'Es mucha cantidad? > Subí a 5000 el minimo porque si no se llenaba el log de cosas al pedo. (NicoNZ)
                    'Si no es de los prohibidos de loguear, lo logueamos.
                    If ObjData(Obj.ObjIndex).NoLog <> 1 Then
26                      Call LogDesarrollo(.Name & " -DropT- " & Obj.Amount & " " & ObjData(Obj.ObjIndex).Name & " Pos:" & Map & "-" & X & "-" & Y)
                    End If
                End If
            Else
27              WriteMensajes UserIndex, e_Mensajes.Mensaje_152

            End If
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en DropObj en " & Erl & ". Err:" & Err.Number & " " & Err.Description)
End Sub

Sub EraseObj(ByVal num As Integer, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With MapData(Map, X, Y)
        If num > .ObjInfo.Amount Then num = .ObjInfo.Amount

        .ObjInfo.Amount = .ObjInfo.Amount - num

        If .ObjInfo.Amount <= 0 Then
            .ObjInfo.ObjIndex = 0
            .ObjInfo.Amount = 0
            Call modSendData.SendToAreaByPos(Map, X, Y, PrepareMessageObjectDelete(X, Y))
        End If
    End With

End Sub

Sub MakeObj(ByRef Obj As Obj, ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************
    On Error GoTo Errhandler

1   If Obj.ObjIndex > 0 And Obj.ObjIndex <= UBound(ObjData) Then
2       With MapData(Map, X, Y)
3           If .ObjInfo.ObjIndex = Obj.ObjIndex Then
4               .ObjInfo.Amount = .ObjInfo.Amount + Obj.Amount
5           Else
6               .ObjInfo = Obj
                 
7               Call modSendData.SendToAreaByPos(Map, X, Y, PrepareMessageObjectCreate(ObjData(Obj.ObjIndex).GrhIndex, X, Y))

                If .ObjInfo.ObjIndex Then
                    If ObjData(.ObjInfo.ObjIndex).WavAlCrear <> 0 Then
                        Call modSendData.SendToAreaByPos(Map, X, Y, PrepareMessagePlayWave(ObjData(.ObjInfo.ObjIndex).WavAlCrear, X, Y))
                    End If
                End If
8           End If
9       End With
10  End If
    Exit Sub
Errhandler:
    Call LogError("Error en MakeObj (Obj:" & Obj.ObjIndex & " - Cant: " & Obj.Amount & ") en posición: " & X & "-" & Y & ". Linea: " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub


Public Function tieneLugar(Usuario As User, objeto As Obj) As Boolean

    Dim Slot As Byte

    '¿El user ya tiene un objeto del mismo tipo?
    Slot = 1

    Do Until Usuario.Invent.Object(Slot).ObjIndex = objeto.ObjIndex And _
       Usuario.Invent.Object(Slot).Amount + objeto.Amount <= MAX_INVENTORY_OBJS

        Slot = Slot + 1

        If Slot > Usuario.CurrentInventorySlots Then Exit Do
    Loop

    'Sino busca un slot vacio
    If Slot > Usuario.CurrentInventorySlots Then

        Slot = 1

        Do Until Usuario.Invent.Object(Slot).ObjIndex = 0

            Slot = Slot + 1

            If Slot > Usuario.CurrentInventorySlots Then Exit Do
        Loop

    End If

    ' ¿Encontre?
    If Slot > Usuario.CurrentInventorySlots Then
        tieneLugar = False
    Else
        tieneLugar = True
    End If

End Function

Public Function tieneLugarBoveda(Usuario As User, objeto As Obj) As Boolean

    Dim Slot As Byte

    '¿El user ya tiene un objeto del mismo tipo?
    Slot = 1

    Do Until Usuario.BancoInvent.Object(Slot).ObjIndex = objeto.ObjIndex And _
       Usuario.BancoInvent.Object(Slot).Amount + objeto.Amount <= MAX_INVENTORY_OBJS

        Slot = Slot + 1

        If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
    Loop

    'Sino busca un slot vacio
    If Slot > MAX_BANCOINVENTORY_SLOTS Then

        Slot = 1

        Do Until Usuario.BancoInvent.Object(Slot).ObjIndex = 0

            Slot = Slot + 1

            If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
        Loop

    End If

    ' ¿Encontre?
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        tieneLugarBoveda = False
    Else
        tieneLugarBoveda = True
    End If

End Function

Public Function tieneLugarBovedaOff(Usuario As User, objeto As Obj) As Boolean

    Dim Slot As Byte

    '¿El user ya tiene un objeto del mismo tipo?
    Slot = 1

    Do Until Usuario.BancoInvent.Object(Slot).ObjIndex = objeto.ObjIndex And _
       Usuario.BancoInvent.Object(Slot).Amount + objeto.Amount <= MAX_INVENTORY_OBJS

        Slot = Slot + 1
        If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
    Loop

    'Sino busca un slot vacio
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        Slot = 1
        Do Until Usuario.BancoInvent.Object(Slot).ObjIndex = 0
            Slot = Slot + 1
            If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
        Loop
    End If

    ' ¿Encontre?
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        tieneLugarBovedaOff = False
    Else
        tieneLugarBovedaOff = True
    End If

End Function

Function MeterItemEnInventarioOFF(ByVal UserName As String, ByRef MiObj As Obj) As Boolean

    On Error GoTo Errhandler

    Dim UserFile As clsIniManager
    Set UserFile = New clsIniManager

    Call UserFile.Initialize(CharPath & UserName & ".chr")

    Dim Slot As Byte, ln As String
    Slot = 1
    ln = UserFile.GetValue("Inventory", "Obj" & Slot)

    Do Until val(ReadField(1, ln, 45)) = MiObj.ObjIndex And val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS
        Slot = Slot + 1
        ln = UserFile.GetValue("Inventory", "Obj" & Slot)

        If Slot > MAX_INVENTORY_SLOTS Then
            Exit Do
        End If
    Loop

    'Sino busca un slot vacio
    If Slot > MAX_INVENTORY_SLOTS Then
        Slot = 1
        ln = UserFile.GetValue("Inventory", "Obj" & Slot)

        Do Until val(ReadField(1, ln, 45)) = 0
            Slot = Slot + 1
            ln = UserFile.GetValue("Inventory", "Obj" & Slot)

            If Slot > MAX_INVENTORY_SLOTS Then
                MeterItemEnInventarioOFF = False
                Set UserFile = Nothing
                Exit Function
            End If
        Loop

        Dim NroItems As Integer
        NroItems = val(UserFile.GetValue("Inventory", "CantidadItems")) + 1

        Call UserFile.ChangeValue("Inventory", "CantidadItems", NroItems)
    End If

    'Mete el objeto
    ln = UserFile.GetValue("Inventory", "Obj" & Slot)

    If val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS Then
        'Menor que MAX_INV_OBJS
        Call UserFile.ChangeValue("Inventory", "Obj" & Slot, MiObj.ObjIndex & "-" & val(ReadField(2, ln, 45)) + MiObj.Amount & "-" & val(ReadField(3, ln, 45)))
    Else
        Call UserFile.ChangeValue("Inventory", "Obj" & Slot, MiObj.ObjIndex & "-" & MAX_INVENTORY_OBJS & "-" & val(ReadField(3, ln, 45)))
    End If

    Call UserFile.DumpFile(CharPath & UserName & ".chr")
    Set UserFile = Nothing

    MeterItemEnInventarioOFF = True

    Exit Function

Errhandler:

    Set UserFile = Nothing
    Call LogError("Error en MeterItemEnInventarioOFF. Error " & Err.Number & " : " & Err.Description)

End Function

Function MeterItemEnInventario(ByVal UserIndex As Integer, ByRef MiObj As Obj) As Boolean

1   On Error GoTo Errhandler
2   Dim Slot As Byte
3   With UserList(UserIndex)
4       Slot = 1
5       Do Until .Invent.Object(Slot).ObjIndex = MiObj.ObjIndex And _
           .Invent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS
6           Slot = Slot + 1
7           If Slot > .CurrentInventorySlots Then
8               Exit Do
9           End If
10      Loop
        'Sino busca un slot vacio
11      If Slot > .CurrentInventorySlots Then
12          Slot = 1
13          Do Until .Invent.Object(Slot).ObjIndex = 0
14              Slot = Slot + 1
15              If Slot > .CurrentInventorySlots Then
16                  WriteMensajes UserIndex, e_Mensajes.Mensaje_153
17                  MeterItemEnInventario = False
                    Exit Function
                End If
            Loop
            '.Invent.NroItems = .Invent.NroItems + 1
        End If

        'If Slot > MAX_NORMAL_INVENTORY_SLOTS And Slot < MAX_INVENTORY_SLOTS Then
        '    If Not ItemSeCae(MiObj.ObjIndex) Then
        '        Call WriteConsoleMsg(UserIndex, "No puedes contener objetos especiales en tu " & ObjData(.Invent.MochilaEqpObjIndex).Name & ".", FontTypeNames.FONTTYPE_FIGHT)
        '        MeterItemEnInventario = False
        '        Exit Function
        '    End If
        'End If


        'Mete el objeto
18      If .Invent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS Then
            'Menor que MAX_INV_OBJS
19          .Invent.Object(Slot).ObjIndex = MiObj.ObjIndex
20          .Invent.Object(Slot).Amount = .Invent.Object(Slot).Amount + MiObj.Amount
21      Else
22          .Invent.Object(Slot).Amount = MAX_INVENTORY_OBJS
23      End If
    End With

24  MeterItemEnInventario = True

25  Call UpdateUserInv(False, UserIndex, Slot)


    Exit Function
Errhandler:
    Call LogError("Error en MeterItemEnInventario en " & Erl & ". Slot: " & Slot & " - ObjIndex: " & MiObj.ObjIndex & "(" & MiObj.Amount & ") Nick: " & UserList(UserIndex).Name & ". Error " & Err.Number & " : " & Err.Description)
End Function

Sub GetObj(ByVal UserIndex As Integer)
'***************************************************
'Autor: Unknown (orginal version)
'Last Modification: 18/12/2009
'18/12/2009: ZaMa - Oro directo a la billetera.
'***************************************************

    Dim Obj As ObjData
    Dim MiObj As Obj
    Dim objPos As String

    With UserList(UserIndex)
        '¿Hay algun obj?
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex > 0 Then
            '¿Esta permitido agarrar este obj?
            If ObjData(MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex).Agarrable <> 1 Or .flags.Privilegios = PlayerType.Admin Then
                Dim X As Integer
                Dim Y As Integer

                X = .Pos.X
                Y = .Pos.Y

                Obj = ObjData(MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex)
                MiObj.Amount = MapData(.Pos.Map, X, Y).ObjInfo.Amount
                MiObj.ObjIndex = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex

                'AGARRAR ORO VA DIRECTO A BILLE? DESCOMENTAR
                If CONFIG_INI_OROABILLE <> 0 Then
                    If (CONFIG_INI_OROABILLE_Only10k <> 0 And MiObj.Amount = 10000) Or CONFIG_INI_OROABILLE_Only10k = 0 Then
                        If ObjData(MiObj.ObjIndex).OBJType = eOBJType.otGuita Then
                            .Stats.GLD = .Stats.GLD + MiObj.Amount
                            Call WriteUpdateGold(UserIndex)
                            Call EraseObj(MapData(.Pos.Map, X, Y).ObjInfo.Amount, .Pos.Map, .Pos.X, .Pos.Y)
                            Exit Sub
                        End If
                    End If
                End If

                If MeterItemEnInventario(UserIndex, MiObj) Then
                    If MiObj.ObjIndex = 406 Then
                        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.Name & " tiene la gema lunar, se encuentra en el mapa " & .Pos.Map & ", " & .Pos.X & ", " & .Pos.Y, FontTypeNames.FONTTYPE_GUILD))
                    End If
                    'Quitamos el objeto
                    Call EraseObj(MapData(.Pos.Map, X, Y).ObjInfo.Amount, .Pos.Map, .Pos.X, .Pos.Y)
                    If EsGM(UserIndex) Then Call LogGM(.Name, "Agarro:" & MiObj.Amount & " Objeto:" & ObjData(MiObj.ObjIndex).Name)

                    'Log de Objetos que se agarran del piso. Pablo (ToxicWaste) 07/09/07
                    'Es un Objeto que tenemos que loguear?
                    If ObjData(MiObj.ObjIndex).Log = 1 Then
                        objPos = " Pos:" & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y
                        Call LogDesarrollo(.Name & " -GetObj- " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name & objPos)
                    ElseIf MiObj.Amount > MAX_INVENTORY_OBJS - 1000 Then        'Es mucha cantidad?
                        'Si no es de los prohibidos de loguear, lo logueamos.
                        If ObjData(MiObj.ObjIndex).NoLog <> 1 Then
                            objPos = " Pos:" & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y
                            Call LogDesarrollo(.Name & " -GetObj- " & MiObj.Amount & " " & ObjData(MiObj.ObjIndex).Name & objPos)
                        End If
                    End If
                End If

            End If
        Else
            WriteMensajes UserIndex, e_Mensajes.Mensaje_155
        End If
    End With

End Sub

Public Sub Desequipar(ByVal UserIndex As Integer, ByVal Slot As Byte, ByVal RefreshChar As Boolean)

    On Error GoTo Errhandler

    'Desequipa el item slot del inventario
    Dim Obj As ObjData

    With UserList(UserIndex)
        With .Invent
            If (Slot < LBound(.Object)) Or (Slot > UBound(.Object)) Then
                Exit Sub
            ElseIf .Object(Slot).ObjIndex = 0 Then
                Exit Sub
            End If

            Obj = ObjData(.Object(Slot).ObjIndex)
        End With

        Select Case Obj.OBJType

        Case eOBJType.otWeapon
            With .Invent
                .Object(Slot).Equipped = 0
                .WeaponEqpObjIndex = 0
                .WeaponEqpSlot = 0
            End With

            If .flags.Mimetizado <> 1 Then
                With .Char
                    .WeaponAnim = NingunArma

                    If RefreshChar And UserList(UserIndex).flags.Navegando <> 1 Then        ' 0.13.5
                        Call ChangeUserWeapon(SendTarget.ToPCArea, UserIndex, .WeaponAnim)
                    End If
                End With
            End If

        Case eOBJType.otFlechas
            With .Invent
                .Object(Slot).Equipped = 0
                .MunicionEqpObjIndex = 0
                .MunicionEqpSlot = 0
            End With


        Case eOBJType.otBarcos
            With .Invent
                .Object(Slot).Equipped = 0
                .BarcoSlot = 0
                .BarcoObjIndex = 0
            End With

        Case eOBJType.otAnillo
            With .Invent
                .Object(Slot).Equipped = 0
                .AnilloEqpObjIndex = 0
                .AnilloEqpSlot = 0
            End With
        Case eOBJType.otAnillo2
            With .Invent
                .Object(Slot).Equipped = 0
                .AnilloEqpObjIndex2 = 0
                .AnilloEqpSlot2 = 0
            End With
        Case eOBJType.otArmadura
            With .Invent
                .Object(Slot).Equipped = 0
                .ArmourEqpObjIndex = 0
                .ArmourEqpSlot = 0
            End With

            If .flags.Navegando <> 1 Then
                Call DarCuerpoDesnudo(UserIndex, .flags.Mimetizado = 1)
            End If

            If RefreshChar Then        ' 0.13.5
                With .Char
                    Call ChangeUserBody(SendTarget.ToPCArea, UserIndex, .body)
                End With
            End If

        Case eOBJType.otCASCO

            If .mReto.Reto_Index <> 0 Then
                If RetoList(.mReto.Reto_Index).CascoEscu Then Exit Sub
            End If

            With .Invent
                .Object(Slot).Equipped = 0
                .CascoEqpObjIndex = 0
                .CascoEqpSlot = 0
            End With

            If .flags.Mimetizado <> 1 Then
                With .Char
                    .CascoAnim = NingunCasco

                    If RefreshChar Then        ' 0.13.5
                        Call ChangeUserHelmet(SendTarget.ToPCArea, UserIndex, .CascoAnim)
                    End If

                End With
            End If

        Case eOBJType.otEscudo

            'If .mReto.Reto_Index <> 0 Then
            '    If RetoList(.mReto.Reto_Index).CascoEscu Then Exit Sub
            'End If

            With .Invent
                .Object(Slot).Equipped = 0
                .EscudoEqpObjIndex = 0
                .EscudoEqpSlot = 0
            End With

            If .flags.Mimetizado <> 1 Then
                With .Char
                    .ShieldAnim = NingunEscudo

                    If RefreshChar Then        ' 0.13.5
                        Call ChangeUserShield(SendTarget.ToPCArea, UserIndex, .ShieldAnim)
                    End If
                End With
            End If

        End Select
    End With

    Call WriteUpdateUserStats(UserIndex)
    Call UpdateUserInv(False, UserIndex, Slot)

    Exit Sub

Errhandler:
    Call LogError("Error en Desquipar. Error " & Err.Number & " : " & Err.Description)

End Sub

Function hasItemAndEquipped(ByVal UserIndex As Integer, ByVal ItemIndex As Integer) As Boolean
    Dim i As Long
    For i = 1 To MAX_INVENTORY_SLOTS
        If UserList(UserIndex).Invent.Object(i).ObjIndex = ItemIndex And Not UserList(UserIndex).Invent.Object(i).Amount = 0 Then  'And UserList(UserIndex).Invent.Object(i).Equipped = 1
            hasItemAndEquipped = True
            Exit Function
        End If
    Next i
End Function

Function SexoPuedeUsarItem(ByVal UserIndex As Integer, ByVal ObjIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 14/01/2010 (ZaMa)
'14/01/2010: ZaMa - Agrego el motivo por el que no puede equipar/usar el item.
'***************************************************

    If EsGM(UserIndex) Then SexoPuedeUsarItem = True: Exit Function

    On Error GoTo Errhandler
    If ObjData(ObjIndex).Mujer = 1 Then
        SexoPuedeUsarItem = UserList(UserIndex).Genero <> eGenero.Hombre
    ElseIf ObjData(ObjIndex).Hombre = 1 Then
        SexoPuedeUsarItem = UserList(UserIndex).Genero <> eGenero.Mujer
    Else
        SexoPuedeUsarItem = True
    End If

    If EsGM(UserIndex) Then
        SexoPuedeUsarItem = True
    End If

    If Not SexoPuedeUsarItem Then WriteConsoleMsg UserIndex, "Tu género no puede usar este objeto."

    Exit Function
Errhandler:
    Call LogError("SexoPuedeUsarItem")
End Function


Function FaccionPuedeUsarItem(ByVal UserIndex As Integer, ByVal ObjIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 14/01/2010 (ZaMa)
'14/01/2010: ZaMa - Agrego el motivo por el que no puede equipar/usar el item.
'***************************************************
    If EsGM(UserIndex) Then FaccionPuedeUsarItem = True: Exit Function

    If ObjData(ObjIndex).Real = 1 Then
        If Not criminal(UserIndex) Then
            FaccionPuedeUsarItem = EsArmada(UserIndex)
        Else
            FaccionPuedeUsarItem = False
        End If
    ElseIf ObjData(ObjIndex).Caos = 1 Then
        If criminal(UserIndex) Then
            FaccionPuedeUsarItem = EsCaos(UserIndex)
        Else
            FaccionPuedeUsarItem = False
        End If
    Else
        FaccionPuedeUsarItem = True
    End If

    If EsGM(UserIndex) Then
        FaccionPuedeUsarItem = True
    End If

    If Not FaccionPuedeUsarItem Then WriteConsoleMsg UserIndex, "Tu alineación no puede usar este objeto."

End Function

Private Function CheckSkillNeeded(ByVal UserIndex As Integer, ByRef Obj As ObjData) As Boolean

    If EsGM(UserIndex) Then CheckSkillNeeded = True: Exit Function

    With UserList(UserIndex)
        ' @@ Si el objeto requiere skills en magia
554     If Obj.MagiaSkill > 0 Then
555         If Obj.MagiaSkill > .Stats.UserSkills(eSkill.Magia) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.MagiaSkill & " puntos en " & SkillsNames(eSkill.Magia) & ".")
                Exit Function
            End If
        End If
556     If Obj.ArmaduraSkill > 0 Then
            If Obj.ArmaduraSkill > .Stats.UserSkills(eSkill.Tacticas) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.ArmaduraSkill & " puntos en " & SkillsNames(eSkill.Tacticas) & ".")
                Exit Function
            End If
        End If
557     If Obj.EscudoSkill > 0 Then
            If Obj.EscudoSkill > .Stats.UserSkills(eSkill.Defensa) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.EscudoSkill & " puntos en " & SkillsNames(eSkill.Defensa) & ".")
                Exit Function
            End If
        End If
558     If Obj.RMSkill > 0 Then
            If Obj.RMSkill > .Stats.UserSkills(eSkill.ResistenciaMagica) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.RMSkill & " puntos en " & SkillsNames(eSkill.ResistenciaMagica) & ".")
                Exit Function
            End If
        End If

559     If Obj.ArmaSkill > 0 Then
            If Obj.ArmaSkill > .Stats.UserSkills(eSkill.Armas) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.ArmaSkill & " puntos en " & SkillsNames(eSkill.Armas) & ".")
                Exit Function
            End If
        End If

560     If Obj.ArcoSkill > 0 Then
            If Obj.ArcoSkill > .Stats.UserSkills(eSkill.proyectiles) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.ArcoSkill & " puntos en " & SkillsNames(eSkill.proyectiles) & ".")
                Exit Function
            End If
        End If

561     If Obj.DagaSkill > 0 Then
            If Obj.DagaSkill > .Stats.UserSkills(eSkill.Apuñalar) Then
                Call WriteConsoleMsg(UserIndex, "Para usar éste objeto necesitas " & Obj.DagaSkill & " puntos en " & SkillsNames(eSkill.Apuñalar) & ".")
                Exit Function
            End If
        End If

        CheckSkillNeeded = True
    End With

End Function
Sub EquiparInvItem(ByVal UserIndex As Integer, ByVal Slot As Byte)
'*************************************************
'Author: Unknown
'Last modified: 14/01/2010 (ZaMa)
'01/08/2009: ZaMa - Now it's not sent any sound made by an invisible admin
'14/01/2010: ZaMa - Agrego el motivo especifico por el que no puede equipar/usar el item.
'*************************************************

    On Error GoTo Errhandler

    'Equipa un item del inventario
    Dim Obj As ObjData
    Dim ObjIndex As Integer

    With UserList(UserIndex)
878     ObjIndex = .Invent.Object(Slot).ObjIndex
696     Obj = ObjData(ObjIndex)

595     If Not EsGM(UserIndex) Then
939         If CONFIG_INI_ITEMS_SKILL_REQUIRED = 1 Then
929             If Obj.Newbie = 1 And Not EsNewbie(UserIndex) Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_287)        '"Sólo los newbies pueden usar este objeto."
                    Exit Sub
                End If

                '562             If .flags.Navegando And Obj.OBJType <> eOBJType.otBarcos Then
                '                    If ObjIndex <> 573 And ObjIndex <> 138 And ObjIndex <> 543 Then
                '                        Call WriteConsoleMsg(UserIndex, "Para usar éste objeto debes bajarte de la barca!")
                '                        Exit Sub
                '                    End If
                '                End If
            End If
        End If

1       Select Case Obj.OBJType

        Case eOBJType.otBarcos

            'Si esta equipado lo quita
563         If .Invent.Object(Slot).Equipped Then
                'Quitamos del inv el item
                Call Desequipar(UserIndex, Slot, False)
                Exit Sub
            End If

            If .Invent.BarcoSlot > 0 Then
                Call Desequipar(UserIndex, .Invent.BarcoSlot, False)
            End If

            If Not EsGM(UserIndex) Then
                If (ObjData(ObjIndex).Ropaje = iGaleon Or ObjData(ObjIndex).Ropaje = iGalera) Then
                    If Not (.Clase = eClass.Pirat Or .Clase = eClass.Fisherman) Then
                        Call WriteConsoleMsg(UserIndex, "Tu clase no puede equipar éste barco!")
                        Exit Sub
                    End If
                End If
            End If

            If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

            .Invent.Object(Slot).Equipped = 1
            .Invent.BarcoObjIndex = ObjIndex
            .Invent.BarcoSlot = Slot


        Case eOBJType.otWeapon

            If Not EsGM(UserIndex) Then

564             If ObjData(ObjIndex).isDosManos = 1 Then
                    If .Invent.EscudoEqpSlot > 0 Then
                        Call WriteConsoleMsg(UserIndex, "Para usar ésta arma necesitas desequipar el escudo!")
                        Exit Sub
                    End If
                End If

                If .Clase = eClass.Warrior Then
                    If .Invent.EscudoEqpSlot > 0 Then
                        If ObjIndex = ESPADADEPLATA Then
                            Call WriteConsoleMsg(UserIndex, "Para usar ésta arma necesitas desequipar el escudo!")
                            Exit Sub
                        End If
                    End If
                ElseIf .Clase = eClass.Paladin Then
                    If .Invent.EscudoEqpSlot > 0 Then
                        If ObjIndex = SABLE Then
                            Call WriteConsoleMsg(UserIndex, "Para usar ésta arma necesitas desequipar el escudo!")
                            Exit Sub
                        End If
                    End If
                ElseIf .Clase = eClass.Assasin Then
                    If .Invent.EscudoEqpSlot > 0 Then
                        If ObjIndex = KATANA Then
                            Call WriteConsoleMsg(UserIndex, "Para usar ésta arma necesitas desequipar el escudo!")
                            Exit Sub
                        End If
                    End If
                End If

                If ObjData(ObjIndex).Ropaje = iGalera Or ObjData(ObjIndex).Ropaje = iGaleon Then
                    If Not .Clase = eClass.Fisherman And Not .Clase = eClass.Pirat Then
                        Call WriteConsoleMsg(UserIndex, "Tu clase no puede usar éste barco!")
                        Exit Sub
                    End If
                End If

                If ObjIndex = HACHA_DORADA Then
                    If ObjData(ObjIndex).MinSkill > .Stats.UserSkills(eSkill.Talar) Then
                        Call WriteConsoleMsg(UserIndex, "Para usar ésta herramienta necesitas " & ObjData(ObjIndex).MinSkill & " skills en Talar!")
                        Exit Sub
                    End If
                End If

                If ObjIndex = RED_PESCA Then
                    If Not .Clase = eClass.Fisherman Then
                        Call WriteConsoleMsg(UserIndex, "No puedes usar red de pesca si no eres Pescador!")
                        Exit Sub
                    End If

                    If Not hasItemAndEquipped(UserIndex, 475) Then    'If .Invent.BarcoSlot = 0 Or Not .Invent.BarcoObjIndex = 475 Then
                        Call WriteConsoleMsg(UserIndex, "Para equipar la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
                        Exit Sub
                    End If

                    If .flags.Navegando = 0 Then
                        Call WriteConsoleMsg(UserIndex, "Para equipar la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
                        Exit Sub
                    End If

                    If Not ObjData(.Invent.BarcoObjIndex).Ropaje = iGalera Then
                        Call WriteConsoleMsg(UserIndex, "Para equipar la red de pesca debes tener 100 skills en pesca y estar dentro de una galera.")
                        Exit Sub
                    End If

                    If .Stats.UserSkills(eSkill.Supervivencia) < 50 Then
                        Call WriteConsoleMsg(UserIndex, "Para usar la red de pesca necesitas al menos 50 skills en Supervivencia!")
                        Exit Sub
                    End If

                    If ObjData(ObjIndex).MinSkill > .Stats.UserSkills(eSkill.Pesca) Then
                        Call WriteConsoleMsg(UserIndex, "Para usar ésta arma necesitas desequipar el escudo!")
                        Exit Sub
                    End If
                End If
            End If

2           If ClasePuedeUsarItem(UserIndex, ObjIndex) And FaccionPuedeUsarItem(UserIndex, ObjIndex) Then

                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

                'Si esta equipado lo quita
3               If .Invent.Object(Slot).Equipped Then
                    'Quitamos del inv el item
4                   Call Desequipar(UserIndex, Slot, False)
                    'Animacion por defecto
5                   If .flags.Mimetizado = 1 Then
                        .CharMimetizado.WeaponAnim = NingunArma
6                   Else
7                       .Char.WeaponAnim = NingunArma
8                       'If .flags.AdminInvisible <> 1 Then
9                       Call ChangeUserWeapon(SendTarget.ToPCArea, UserIndex, NingunArma)
                        ' End If
                    End If
                    Exit Sub
                End If

                'Quitamos el elemento anterior
                If .Invent.WeaponEqpObjIndex > 0 Then
11                  Call Desequipar(UserIndex, .Invent.WeaponEqpSlot, False)
                End If

                .Invent.Object(Slot).Equipped = 1
12              .Invent.WeaponEqpObjIndex = ObjIndex
                .Invent.WeaponEqpSlot = Slot

                'El sonido solo se envia si no lo produce un admin invisible
                If .flags.AdminInvisible <> 1 Then
13                  Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_SACARARMA, .Pos.X, .Pos.Y))
                End If

14              If .flags.Mimetizado = 1 Then
                    .CharMimetizado.WeaponAnim = GetWeaponAnim(UserIndex, ObjIndex)
                Else
                    .Char.WeaponAnim = GetWeaponAnim(UserIndex, ObjIndex)
                    'If .flags.AdminInvisible <> 1 Then
15                  Call ChangeUserWeapon(SendTarget.ToPCArea, UserIndex, .Char.WeaponAnim)
                    'End If
                End If
            End If

        Case eOBJType.otAnillo
16          If ClasePuedeUsarItem(UserIndex, ObjIndex) And _
               FaccionPuedeUsarItem(UserIndex, ObjIndex) Then
                'Si esta equipado lo quita
17              If .Invent.Object(Slot).Equipped Then
                    'Quitamos del inv el item
18                  Call Desequipar(UserIndex, Slot, True)
                    Exit Sub
                End If

                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub
                'Quitamos el elemento anterior
19              If .Invent.AnilloEqpObjIndex > 0 Then
20                  Call Desequipar(UserIndex, .Invent.AnilloEqpSlot, True)
                End If


                .Invent.Object(Slot).Equipped = 1
                .Invent.AnilloEqpObjIndex = ObjIndex
                .Invent.AnilloEqpSlot = Slot
            End If


        Case eOBJType.otAnillo2
21          If ClasePuedeUsarItem(UserIndex, ObjIndex) And _
               FaccionPuedeUsarItem(UserIndex, ObjIndex) Then
                'Si esta equipado lo quita
22              If .Invent.Object(Slot).Equipped Then
                    'Quitamos del inv el item
23                  Call Desequipar(UserIndex, Slot, False)
                    Exit Sub
                End If

                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub
                'Quitamos el elemento anterior
24              If .Invent.AnilloEqpObjIndex2 > 0 Then
25                  Call Desequipar(UserIndex, .Invent.AnilloEqpSlot2, True)
                End If


                .Invent.Object(Slot).Equipped = 1
                .Invent.AnilloEqpObjIndex2 = ObjIndex
                .Invent.AnilloEqpSlot2 = Slot
            End If
        Case eOBJType.otFlechas
26          If ClasePuedeUsarItem(UserIndex, ObjIndex) And _
               FaccionPuedeUsarItem(UserIndex, ObjIndex) Then

                'Si esta equipado lo quita
29              If .Invent.Object(Slot).Equipped Then
                    'Quitamos del inv el item
27                  Call Desequipar(UserIndex, Slot, True)
                    Exit Sub
                End If
                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

                'Quitamos el elemento anterior
                If .Invent.MunicionEqpObjIndex > 0 Then
28                  Call Desequipar(UserIndex, .Invent.MunicionEqpSlot, True)
                End If


30              .Invent.Object(Slot).Equipped = 1
                .Invent.MunicionEqpObjIndex = ObjIndex
                .Invent.MunicionEqpSlot = Slot
            End If

        Case eOBJType.otArmadura
31          If .flags.Navegando = 1 Then Exit Sub

            'Nos aseguramos que puede usarla
32          If ClasePuedeUsarItem(UserIndex, ObjIndex) And _
               SexoPuedeUsarItem(UserIndex, ObjIndex) And _
               CheckRazaUsaRopa(UserIndex, ObjIndex) And _
               FaccionPuedeUsarItem(UserIndex, ObjIndex) Then

                'Si esta equipado lo quita
33              If .Invent.Object(Slot).Equipped Then
34                  Call Desequipar(UserIndex, Slot, False)
35                  Call DarCuerpoDesnudo(UserIndex, .flags.Mimetizado = 1)
36                  If .flags.Mimetizado = 0 And .flags.Navegando = 0 Then
                        'If .flags.AdminInvisible <> 1 Then
37                      Call ChangeUserBody(SendTarget.ToPCArea, UserIndex, .Char.body)
                        'End If
                    End If
                    Exit Sub
                End If
                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

                'Quita el anterior
                If .Invent.ArmourEqpObjIndex > 0 Then
                    If .flags.AdminInvisible <> 1 Then

                        If .flags.Navegando = 1 Then Exit Sub

                        Dim SlotBody As Byte

                        With .Invent
38                          SlotBody = .ArmourEqpSlot
39                          .Object(SlotBody).Equipped = 0
                            .ArmourEqpObjIndex = 0
                            .ArmourEqpSlot = 0
                        End With

                        If .flags.Navegando <> 1 Then
40                          Call DarCuerpoDesnudo(UserIndex, .flags.Mimetizado = 1)
                        End If

41                      Call ChangeUserBody(SendTarget.ToPCArea, UserIndex, .Char.body)
42                      Call UpdateUserInvSlot(UserIndex, SlotBody)
                    End If
                End If

                'Lo equipa
                .Invent.Object(Slot).Equipped = 1
                .Invent.ArmourEqpObjIndex = ObjIndex
43              .Invent.ArmourEqpSlot = Slot

                If .flags.Mimetizado = 1 Then
                    .CharMimetizado.body = Obj.Ropaje
                Else
                    .Char.body = Obj.Ropaje
44                  'If .flags.AdminInvisible <> 1 Then
45                  Call ChangeUserBody(SendTarget.ToPCArea, UserIndex, .Char.body)
                    'End If
                End If
                .flags.Desnudo = 0
            End If

        Case eOBJType.otCASCO

46          If .flags.Navegando = 1 Then Exit Sub
47          If ClasePuedeUsarItem(UserIndex, ObjIndex) Then
                'Si esta equipado lo quita
48              If .Invent.Object(Slot).Equipped Then
49                  Call Desequipar(UserIndex, Slot, False)
500                 If .flags.Mimetizado = 1 Then
                        .CharMimetizado.CascoAnim = NingunCasco
                    Else
                        .Char.CascoAnim = NingunCasco
50                      ' If .flags.AdminInvisible <> 1 Then
51                      Call ChangeUserHelmet(SendTarget.ToPCArea, UserIndex, NingunCasco)
                        ' End If
                    End If
                    Exit Sub
                End If
                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

                'Quita el anterior
52              If .Invent.CascoEqpObjIndex > 0 Then
                    If .flags.AdminInvisible <> 1 Then
                        Call Desequipar(UserIndex, .Invent.CascoEqpSlot, False)
                    End If
                End If

                If .mReto.Reto_Index <> 0 Then
                    If RetoList(.mReto.Reto_Index).CascoEscu Then
                        Call WriteConsoleMsg(UserIndex, "No puedes equiparte cascos debido a la configuración del reto.")
                        Exit Sub
                    End If
                End If

                'Lo equipa
53              .Invent.Object(Slot).Equipped = 1
                .Invent.CascoEqpObjIndex = ObjIndex
                .Invent.CascoEqpSlot = Slot

                If .flags.Mimetizado = 1 Then
                    .CharMimetizado.CascoAnim = Obj.CascoAnim
                ElseIf .flags.Navegando = 0 Then
                    .Char.CascoAnim = Obj.CascoAnim

                    'If .flags.AdminInvisible <> 1 Then
54                  Call ChangeUserHelmet(SendTarget.ToPCArea, UserIndex, .Char.CascoAnim)
                    'End If
                End If
            End If

        Case eOBJType.otEscudo

            If .Invent.WeaponEqpSlot > 0 Then
                If ObjData(.Invent.WeaponEqpObjIndex).isDosManos = 1 Then
                    Call WriteConsoleMsg(UserIndex, "Para usar éste escudo necesitas desequipar el arma que tienes!")
                    Exit Sub
                End If

                If .Clase = eClass.Warrior Then
                    If .Invent.WeaponEqpObjIndex = ESPADADEPLATA Then
                        Call WriteConsoleMsg(UserIndex, "Para usar éste escudo necesitas desequipar el arma que tienes!")
                        Exit Sub
                    End If
                ElseIf .Clase = eClass.Paladin Then
                    If .Invent.WeaponEqpObjIndex = SABLE Then
                        Call WriteConsoleMsg(UserIndex, "Para usar ésta escudo necesitas desequipar el arma que tienes!")
                        Exit Sub
                    End If
                ElseIf .Clase = eClass.Assasin Then
                    If .Invent.WeaponEqpObjIndex = KATANA Then
                        Call WriteConsoleMsg(UserIndex, "Para usar ésta escudo necesitas desequipar el arma que tienes!")
                        Exit Sub
                    End If
                End If

            End If

55          If ClasePuedeUsarItem(UserIndex, ObjIndex) And FaccionPuedeUsarItem(UserIndex, ObjIndex) Then

                'Si esta equipado lo quita
56              If .Invent.Object(Slot).Equipped Then
57                  Call Desequipar(UserIndex, Slot, False)
                    If .flags.Mimetizado = 1 Then
58                      .CharMimetizado.ShieldAnim = NingunEscudo
                    ElseIf .flags.Navegando = 0 Then
                        .Char.ShieldAnim = NingunEscudo
                        ' If .flags.AdminInvisible <> 1 Then
59                      Call ChangeUserShield(SendTarget.ToPCArea, UserIndex, NingunEscudo)
                        ' End If
                    End If

                    'Call WriteUpdateUserStats(UserIndex)    ' 0.13.5
                    Exit Sub
                End If

                If .mReto.Reto_Index <> 0 Then
                    If RetoList(.mReto.Reto_Index).CascoEscu Then
                        Call WriteConsoleMsg(UserIndex, "No puedes equiparte escudos debido a la configuración del reto.")
                        Exit Sub
                    End If
                End If

                If Not CheckSkillNeeded(UserIndex, Obj) Then Exit Sub

                'Quita el anterior
                If .Invent.EscudoEqpObjIndex > 0 Then
                    If .flags.AdminInvisible <> 1 Then
70                      Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, False)
71                  End If
                End If

                'Lo equipa
                .Invent.Object(Slot).Equipped = 1
                .Invent.EscudoEqpObjIndex = ObjIndex
                .Invent.EscudoEqpSlot = Slot

72              If .flags.Mimetizado = 1 Then
73                  .CharMimetizado.ShieldAnim = Obj.ShieldAnim
                ElseIf .flags.Navegando = 0 Then
                    .Char.ShieldAnim = Obj.ShieldAnim
                    'If .flags.AdminInvisible <> 1 Then
74                  Call ChangeUserShield(SendTarget.ToPCArea, UserIndex, .Char.ShieldAnim)
                    'End If
                End If
                'Call WriteUpdateUserStats(UserIndex)    ' 0.13.5
            End If

76      End Select
    End With

77  Call UpdateUserInv(False, UserIndex, Slot)

    Exit Sub

Errhandler:
    Call LogError("EquiparInvItem ERL:" & Erl & " - Error: " & Err.Number & " - Error Description : " & Err.Description)
End Sub

Private Function CheckRazaUsaRopa(ByVal UserIndex As Integer, ItemIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 14/01/2010 (ZaMa)
'14/01/2010: ZaMa - Agrego el motivo por el que no puede equipar/usar el item.
'***************************************************

    On Error GoTo Errhandler

    With UserList(UserIndex)
        'Verifica si la raza puede usar la ropa
        If .raza = eRaza.Humano Or _
           .raza = eRaza.Elfo Or _
           .raza = eRaza.Drow Then
            CheckRazaUsaRopa = (ObjData(ItemIndex).RazaEnana = 0)
        Else
            CheckRazaUsaRopa = (ObjData(ItemIndex).RazaEnana = 1)
        End If

        'Solo se habilita la ropa exclusiva para Drows por ahora. Pablo (ToxicWaste)
        If (.raza <> eRaza.Drow) And ObjData(ItemIndex).RazaDrow Then
            CheckRazaUsaRopa = False
        End If

        If EsGM(UserIndex) Then
            CheckRazaUsaRopa = True
        End If

    End With

    If Not CheckRazaUsaRopa Then WriteMensajes UserIndex, e_Mensajes.Mensaje_158

    Exit Function

Errhandler:
    Call LogError("Error CheckRazaUsaRopa ItemIndex:" & ItemIndex)

End Function

Sub UseInvItem(ByVal UserIndex As Integer, ByVal Slot As Byte)
'*************************************************
'Author: Unknown
'Last modified: 10/12/2009
'Handels the usage of items from inventory box.
'24/01/2007 Pablo (ToxicWaste) - Agrego el Cuerno de la Armada y la Legión.
'24/01/2007 Pablo (ToxicWaste) - Utilización nueva de Barco en lvl 20 por clase Pirata y Pescador.
'01/08/2009: ZaMa - Now it's not sent any sound made by an invisible admin, except to its own client
'17/11/2009: ZaMa - Ahora se envia una orientacion de la posicion hacia donde esta el que uso el cuerno.
'27/11/2009: Budi - Se envia indivualmente cuando se modifica a la Agilidad o la Fuerza del personaje.
'08/12/2009: ZaMa - Agrego el uso de hacha de madera de tejo.
'10/12/2009: ZaMa - Arreglos y validaciones en todos las herramientas de trabajo.
'*************************************************

    Dim Obj As ObjData
    Dim ObjIndex As Integer
    Dim TargObj As ObjData
    Dim MiObj As Obj

    With UserList(UserIndex)

        If .Invent.Object(Slot).Amount < 1 Then Exit Sub

        Obj = ObjData(.Invent.Object(Slot).ObjIndex)

        If Not EsGM(UserIndex) Then

            If Obj.Newbie = 1 And Not EsNewbie(UserIndex) Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_156
                Exit Sub
            End If

            If Obj.OBJType = eOBJType.otWeapon Then
                If Obj.proyectil = 1 Then

                    'valido para evitar el flood pero no bloqueo. El bloqueo se hace en WLC con proyectiles.
                    If Not IntervaloPermiteUsar(UserIndex, False) Then Exit Sub
                Else
                    'dagas
                    If Not IntervaloPermiteUsar(UserIndex) Then Exit Sub
                End If
            End If

        End If

        ObjIndex = .Invent.Object(Slot).ObjIndex
        .flags.TargetObjInvIndex = ObjIndex
        .flags.TargetObjInvSlot = Slot

        Select Case Obj.OBJType

        Case 95    ' Hay que darle un ObjType

            If .flags.Muerto = 1 Then
                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                Exit Sub
            End If

            If .flags.Comerciando Then
                Call WriteConsoleMsg(UserIndex, "Estás comerciando!")
                Exit Sub
            End If

            Dim Head As Integer

            Select Case .Invent.Object(Slot).ObjIndex

            Case 840
                'random head
                Head = DarCabeza(.raza, .Genero)
                If Head = 0 Then
                    Call WriteErrorMsg(UserIndex, "Intente nuevamente.")
                    Exit Sub
                End If

                .OrigChar.Head = Head
                .Char.Head = Head

                Call ChangeUserChar(UserIndex, .Char.body, UserList(UserIndex).Char.Head, UserList(UserIndex).Char.Heading, UserList(UserIndex).Char.WeaponAnim, UserList(UserIndex).Char.ShieldAnim, UserList(UserIndex).Char.CascoAnim)

                Call WriteVar(CharPath & .Name & ".chr", "INIT", "Head", Head)

                Call WriteConsoleMsg(UserIndex, "El objeto ha modificado tu apariencia!! Disfruta de tu nuevo rostro!", FontTypeNames.FONTTYPE_NARANJA)

            Case 841
                'switch gender
                If .Genero = eGenero.Hombre Then
                    .Genero = eGenero.Mujer
                Else
                    .Genero = eGenero.Hombre
                End If
                Call WriteVar(CharPath & .Name & ".chr", "INIT", "GENERO", .Genero)
                Call WriteConsoleMsg(UserIndex, "El objeto ha modificado tu apariencia!! Te has convertido en " & IIf(.Genero = eGenero.Hombre, "Hombre", "Mujer") & "!", FontTypeNames.FONTTYPE_NARANJA)

                Head = DarCabeza(.raza, .Genero)
                If Head = 0 Then
                    Call WriteErrorMsg(UserIndex, "Intente nuevamente.")
                    Exit Sub
                End If

                .OrigChar.Head = Head
                .Char.Head = Head

                If .Invent.ArmourEqpObjIndex <> 0 Then
                    Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, True)
                End If

                If .flags.Desnudo = 1 Then
                    Call DarCuerpoDesnudo(UserIndex)
                End If

                Call ChangeUserChar(UserIndex, .Char.body, .OrigChar.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)

            Case 842
                'head choose
                'Call WriteConsoleMsg(userindex, "Contacta con un GM para poder realizar el cambio de rostro a elección!", FontTypeNames.FONTTYPE_NARANJA)
                Call WriteShowSpecialForm(UserIndex, 1)

                Exit Sub
            Case 843
                'cambio de nick
                Call WriteShowSpecialForm(UserIndex, 2)
                'Call WriteConsoleMsg(userindex, "Contacta con un GM para poder realizar el cambio de nick!", FontTypeNames.FONTTYPE_NARANJA)
                Exit Sub
            Case 844
                'cambio nombre clan
                Call WriteShowSpecialForm(UserIndex, 3)
                'Call WriteConsoleMsg(userindex, "Contacta con un GM para poder realizar el cambio de nombre del clan!", FontTypeNames.FONTTYPE_NARANJA)
                Exit Sub
            Case Else
                Exit Sub
            End Select

            Call QuitarUserInvItem(UserIndex, Slot, 1)
            Call UpdateUserInv(False, UserIndex, Slot)

        Case eOBJType.otUseOnce

            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            'Usa el item
            .Stats.MinHam = .Stats.MinHam + Obj.MinHam
            If .Stats.MinHam > .Stats.MaxHam Then _
               .Stats.MinHam = .Stats.MaxHam
            .flags.Hambre = 0
            Call WriteUpdateHungerAndThirst(UserIndex)
            'Sonido

            If ObjIndex = e_ObjetosCriticos.Manzana Or ObjIndex = e_ObjetosCriticos.Manzana2 Or ObjIndex = e_ObjetosCriticos.ManzanaNewbie Then
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.MORFAR_MANZANA)
            Else
                Call SonidosMapas.ReproducirSonido(SendTarget.ToPCArea, UserIndex, e_SoundIndex.SOUND_COMIDA)
            End If

            'Quitamos del inv el item
            Call QuitarUserInvItem(UserIndex, Slot, 1)

            Call UpdateUserInv(False, UserIndex, Slot)

        Case eOBJType.otGuita

            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            .Stats.GLD = .Stats.GLD + .Invent.Object(Slot).Amount
            .Invent.Object(Slot).Amount = 0
            .Invent.Object(Slot).ObjIndex = 0
            '.Invent.NroItems = .Invent.NroItems - 1

            Call UpdateUserInv(False, UserIndex, Slot)
            Call WriteUpdateGold(UserIndex)

        Case eOBJType.otWeapon
            If Not EsGM(UserIndex) Then

                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If

                If Not .Stats.minSta > 0 Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_11
                    Exit Sub
                End If
            End If

            If Obj.Snd1 > 1 Then
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
            End If

            If ObjData(ObjIndex).proyectil = 1 Then
                If .Invent.Object(Slot).Equipped = 0 Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    Exit Sub
                End If
                Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.proyectiles)        'Call WriteWorkRequestTarget(UserIndex, Proyectiles)
            ElseIf .flags.TargetObj = Leña Then
                If .Invent.Object(Slot).ObjIndex = DAGA Or .Invent.Object(Slot).ObjIndex = 165 Then    'daga y daga +1
                    If .Invent.Object(Slot).Equipped = 0 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                        Exit Sub
                    End If

                    Call TratarDeHacerFogata(.flags.TargetObjMap, _
                                             .flags.TargetObjX, .flags.TargetObjY, UserIndex)
                End If
            Else

                Select Case ObjIndex
                Case CAÑA_PESCA, RED_PESCA
                    If .Invent.WeaponEqpObjIndex = CAÑA_PESCA Or .Invent.WeaponEqpObjIndex = RED_PESCA Then
                        Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.Pesca)        'Call WriteWorkRequestTarget(UserIndex, eSkill.Pesca)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case HACHA_LEÑADOR, HACHA_DORADA
                    If .Invent.WeaponEqpObjIndex = HACHA_LEÑADOR Or .Invent.WeaponEqpObjIndex = HACHA_DORADA Then
                        Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.Talar)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case PIQUETE_MINERO
                    If .Invent.WeaponEqpObjIndex = PIQUETE_MINERO Then
                        Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.Mineria)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case PIQUETE_MINERO_ORO
                    If .Invent.WeaponEqpObjIndex = PIQUETE_MINERO_ORO Then
                        Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.Mineria)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case MARTILLO_HERRERO
                    If .Invent.WeaponEqpObjIndex = MARTILLO_HERRERO Then
                        Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, eSkill.Herreria)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case SERRUCHO_CARPINTERO
                    If .Invent.WeaponEqpObjIndex = SERRUCHO_CARPINTERO Then
                        Call EnivarObjConstruibles(UserIndex)
                        Call WriteShowCarpenterForm(UserIndex)
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_168
                    End If

                Case Else        ' Las herramientas no se pueden fundir
                    Exit Sub
                    'If ObjData(ObjIndex).SkHerreria > 0 Then
                    '    Call WriteMultiMessage(userIndex, eMessages.WorkRequestTarget, FundirMetal)        'Call WriteWorkRequestTarget(UserIndex, FundirMetal)
                    'End If
                End Select
            End If

        Case eOBJType.otBebidas
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            .Stats.MinAGU = .Stats.MinAGU + Obj.MinSed
            If .Stats.MinAGU > .Stats.MaxAGU Then _
               .Stats.MinAGU = .Stats.MaxAGU
            .flags.Sed = 0
            Call WriteUpdateHungerAndThirst(UserIndex)

            'Quitamos del inv el item
            Call QuitarUserInvItem(UserIndex, Slot, 1)

            ' Los admin invisibles solo producen sonidos a si mismos
            If .flags.AdminInvisible = 1 Then
                Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
            Else
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
            End If

            Call UpdateUserInv(False, UserIndex, Slot)

        Case eOBJType.otLlaves
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            If .flags.TargetObj = 0 Then Exit Sub
            TargObj = ObjData(.flags.TargetObj)
            '¿El objeto clickeado es una puerta?
            If TargObj.OBJType = eOBJType.otPuertas Then
                '¿Esta cerrada?
                If TargObj.Cerrada = 1 Then
                    '¿Cerrada con llave?
                    If TargObj.Llave > 0 Then
                        If TargObj.clave = Obj.clave Then

                            MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex _
                                  = ObjData(MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex).IndexCerrada
                            .flags.TargetObj = MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_162

                            Exit Sub
                        Else
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_163
                            Exit Sub
                        End If
                    Else
                        If TargObj.clave = Obj.clave Then
                            MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex _
                                  = ObjData(MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex).IndexCerradaLlave
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_164
                            .flags.TargetObj = MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex
                            Exit Sub
                        Else
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_163
                            Exit Sub
                        End If
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_165

                    Exit Sub
                End If
            End If

        Case eOBJType.otBotellaVacia
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If
            If Not HayAgua(.Pos.Map, .flags.TargetX, .flags.TargetY) Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_166
                Exit Sub
            End If
            MiObj.Amount = 1
            MiObj.ObjIndex = ObjData(.Invent.Object(Slot).ObjIndex).IndexAbierta
            Call QuitarUserInvItem(UserIndex, Slot, 1)
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(.Pos, MiObj)
            End If

            Call UpdateUserInv(False, UserIndex, Slot)

        Case eOBJType.otBotellaLlena
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If
            .Stats.MinAGU = .Stats.MinAGU + Obj.MinSed
            If .Stats.MinAGU > .Stats.MaxAGU Then _
               .Stats.MinAGU = .Stats.MaxAGU
            .flags.Sed = 0
            Call WriteUpdateHungerAndThirst(UserIndex)
            MiObj.Amount = 1
            MiObj.ObjIndex = ObjData(.Invent.Object(Slot).ObjIndex).IndexCerrada
            Call QuitarUserInvItem(UserIndex, Slot, 1)
            If Not MeterItemEnInventario(UserIndex, MiObj) Then
                Call TirarItemAlPiso(.Pos, MiObj)
            End If

            Call UpdateUserInv(False, UserIndex, Slot)

        Case eOBJType.otPergaminos
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            If .Stats.MaxMAN > 0 Then
                If .flags.Hambre = 0 And _
                   .flags.Sed = 0 Then
                    Call AgregarHechizo(UserIndex, Slot)
                    Call UpdateUserInv(False, UserIndex, Slot)
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_169
                End If
            Else
                Call WriteConsoleMsg(UserIndex, "No tienes conocimientos de las Artes Arcanas.", FontTypeNames.FONTTYPE_INFO)
            End If
        Case eOBJType.otMinerales
            If .flags.Muerto = 1 Then
                Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                Exit Sub
            End If
            Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, FundirMetal)        'Call WriteWorkRequestTarget(UserIndex, FundirMetal)

        Case eOBJType.otInstrumentos
            If Not EsGM(UserIndex) Then
                If .flags.Muerto = 1 Then
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_26)
                    Exit Sub
                End If
            End If

            If Obj.Real Then        '¿Es el Cuerno Real?
                If FaccionPuedeUsarItem(UserIndex, ObjIndex) Then
                    If MapInfo(.Pos.Map).pk = False Then
                        Call WriteConsoleMsg(UserIndex, "No hay peligro aquí. Es zona segura.", FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If

                    ' Los admin invisibles solo producen sonidos a si mismos
                    If .flags.AdminInvisible = 1 Then
                        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
                    Else
                        Call AlertarFaccionarios(UserIndex)
                        Call SendData(SendTarget.toMap, .Pos.Map, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
                    End If

                    Exit Sub
                Else
                    Call WriteConsoleMsg(UserIndex, "Sólo miembros del ejército real pueden usar este cuerno.", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
            ElseIf Obj.Caos Then        '¿Es el Cuerno Legión?
                If FaccionPuedeUsarItem(UserIndex, ObjIndex) Then
                    If MapInfo(.Pos.Map).pk = False Then
                        Call WriteConsoleMsg(UserIndex, "No hay peligro aquí. Es zona segura.", FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If

                    ' Los admin invisibles solo producen sonidos a si mismos
                    If .flags.AdminInvisible = 1 Then
                        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
                    Else
                        Call AlertarFaccionarios(UserIndex)
                        Call SendData(SendTarget.toMap, .Pos.Map, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
                    End If

                    Exit Sub
                Else
                    Call WriteConsoleMsg(UserIndex, "Sólo miembros de la legión oscura pueden usar este cuerno.", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
            End If
            'Si llega aca es porque es o Laud o Tambor o Flauta
            ' Los admin invisibles solo producen sonidos a si mismos
            If .flags.AdminInvisible = 1 Then
                Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
            Else
                Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(Obj.Snd1, .Pos.X, .Pos.Y))
            End If

        Case eOBJType.otBarcos
            'Verifica si esta aproximado al agua antes de permitirle navegar

            If Not EsGM(UserIndex) Then
                If .Stats.ELV < 25 Then
                    If .Clase <> eClass.Fisherman And .Clase <> eClass.Pirat Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_33
                        Exit Sub
                    End If
                End If

                If ObjData(.Invent.Object(Slot).ObjIndex).Ropaje = iGalera Or ObjData(.Invent.Object(Slot).ObjIndex).Ropaje = iGaleon Then
                    If Not .Clase = eClass.Fisherman And Not .Clase = eClass.Pirat Then
                        Call WriteConsoleMsg(UserIndex, "Tu clase no puede usar éste barco!")
                        Exit Sub
                    End If
                End If
            End If
            If ((LegalPos(.Pos.Map, .Pos.X - 1, .Pos.Y, True, False) _
                 Or LegalPos(.Pos.Map, .Pos.X, .Pos.Y - 1, True, False) _
                 Or LegalPos(.Pos.Map, .Pos.X + 1, .Pos.Y, True, False) _
                 Or LegalPos(.Pos.Map, .Pos.X, .Pos.Y + 1, True, False)) _
                 And .flags.Navegando = 0) _
                 Or .flags.Navegando = 1 Then
                Call DoNavega(UserIndex, Obj, Slot)
            Else
                If EsGM(UserIndex) Then
                    Call DoNavega(UserIndex, Obj, Slot)
                Else
                    Call WriteMensajes(UserIndex, Mensaje_410)
                End If
            End If

        End Select

    End With

End Sub

Sub UseInvPotion(ByVal UserIndex As Integer, ByVal Slot As Byte)

    On Error GoTo Errhandler

1   Dim Obj As ObjData

2   With UserList(UserIndex)

3       If Slot = 0 Then Slot = 1

4       If .Invent.Object(Slot).Amount < 1 Then Exit Sub

5       Obj = ObjData(.Invent.Object(Slot).ObjIndex)

6       If Obj.OBJType <> eOBJType.otPociones Then Exit Sub

7       If Obj.Newbie = 1 And Not EsNewbie(UserIndex) Then
8           Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_287)        'Sólo los newbies pueden usar estos objetos.
9           Exit Sub
        End If

        If .flags.Muerto = 1 Then Exit Sub

10      If Not IntervaloPermiteGolpeUsar(UserIndex, False) Then Exit Sub

        Dim TActual As Long
        TActual = GetTickCount()

11      If getInterval(TActual, .Counters.LastPoteo) > IntClickU Then

12          .Counters.LastPoteo = TActual
            .Counters.failedUsageAttempts = 0

            .flags.TomoPocion = True
13          .flags.TipoPocion = Obj.TipoPocion

            Select Case .flags.TipoPocion

            Case 1        'Modif la agilidad
14              .flags.DuracionEfecto = Obj.DuracionEfecto

                'Usa el item
15              .Stats.UserAtributos(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad) + RandomNumber(Obj.MinModificador, Obj.MaxModificador)
                If .Stats.UserAtributos(eAtributos.Agilidad) > MAXATRIBUTOS Then _
                   .Stats.UserAtributos(eAtributos.Agilidad) = MAXATRIBUTOS
                If .Stats.UserAtributos(eAtributos.Agilidad) > 2 * .Stats.UserAtributosBackUP(Agilidad) Then .Stats.UserAtributos(eAtributos.Agilidad) = 2 * .Stats.UserAtributosBackUP(Agilidad)

                'Quitamos del inv el item
18              Call QuitarUserInvItem(UserIndex, Slot, 1)

17              If .Counters.TickSoundPotions < TActual Then
                    .Counters.TickSoundPotions = TActual + 370
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                End If

                Call WriteUpdateDexterity(UserIndex)

            Case 2        'Modif la fuerza
19              .flags.DuracionEfecto = Obj.DuracionEfecto

                'Usa el item
22              .Stats.UserAtributos(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza) + RandomNumber(Obj.MinModificador, Obj.MaxModificador)
                If .Stats.UserAtributos(eAtributos.Fuerza) > MAXATRIBUTOS Then _
                   .Stats.UserAtributos(eAtributos.Fuerza) = MAXATRIBUTOS
                If .Stats.UserAtributos(eAtributos.Fuerza) > 2 * .Stats.UserAtributosBackUP(Fuerza) Then .Stats.UserAtributos(eAtributos.Fuerza) = 2 * .Stats.UserAtributosBackUP(Fuerza)

                'Quitamos del inv el item
23              Call QuitarUserInvItem(UserIndex, Slot, 1)

333             If .Counters.TickSoundPotions < TActual Then
253                 .Counters.TickSoundPotions = TActual + 370
263                 Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                End If

                Call WriteUpdateStrenght(UserIndex)

            Case 3        'Pocion roja, restaura HP

273             .Stats.MinHP = .Stats.MinHP + RandomNumber(Obj.MinModificador, Obj.MaxModificador)        'Semi magicos

283             If .Stats.MinHP > .Stats.MaxHP Then
                    .Stats.MinHP = .Stats.MaxHP

293                 If .IsFull_HP > 1 Then
303                     .IsFull_HP = 1
313                     .CountAutoRed = .CountAutoRed + 1

332                     If .CountAutoRed > 10 Then
553                         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - posible uso de macro auto reds.", FontTypeNames.FONTTYPE_SERVER))
                            .CountAutoRed = 0
                        End If
                    Else
343                     .IsFull_HP = 0
335                     .CountAutoRed = 0
                    End If
                Else
336                 .IsFull_HP = 2
                End If

                'Quitamos del inv el item
327             Call QuitarUserInvItem(UserIndex, Slot, 1)

                If .Counters.TickSoundPotions < TActual Then
                    .Counters.TickSoundPotions = TActual + 370
                    If .flags.AdminInvisible = 1 Then
                        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    Else
                        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    End If
                End If

                'Call WriteUpdateHP(UserIndex)

            Case 4        'Pocion azul, restaura MANA

3434            .Stats.MinMAN = .Stats.MinMAN + Porcentaje(.Stats.MaxMAN, 5)

239             If .Stats.MinMAN > .Stats.MaxMAN Then
3340                .Stats.MinMAN = .Stats.MaxMAN

3341                If .IsFull_MANA > 1 Then
342                     .IsFull_MANA = 1
353                     .CountAutoBlues = .CountAutoBlues + 1

346                     If .CountAutoBlues > 10 Then
356                         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - posible uso de macro auto blues.", FontTypeNames.FONTTYPE_SERVER))
                            .CountAutoBlues = 0
                        End If
                    Else
376                     .IsFull_MANA = 0
                        .CountAutoBlues = 0
                    End If
                Else
                    .IsFull_MANA = 2
                End If

387             .LastMAN = .Stats.MinMAN

                'Quitamos del inv el item
397             Call QuitarUserInvItem(UserIndex, Slot, 1)

407             If .Counters.TickSoundPotions < TActual Then
427                 .Counters.TickSoundPotions = TActual + 370
437                 If .flags.AdminInvisible = 1 Then
447                     Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    Else
475                     Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    End If
                End If

                'Call WriteUpdateMana(UserIndex)

            Case 5        ' Pocion violeta
                If .flags.Envenenado = 1 Then
                    .flags.Envenenado = 0

                    Call WriteUpdateEnvenenado(UserIndex)
                    Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_160)        'Te has curado del envenenamiento.
                End If

                'Quitamos del inv el item
                Call QuitarUserInvItem(UserIndex, Slot, 1)
                If .flags.AdminInvisible = 1 Then
                    Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                Else
                    Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                End If

            Case 6        ' Poción Negra

                Call QuitarUserInvItem(UserIndex, Slot, 1)

                If Not EsGM(UserIndex) Then
                    Call UserDie(UserIndex, Not EsNewbie(UserIndex))
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_161
                End If

            Case 7        'Poción Energia

                If .Stats.minSta = .Stats.MaxSta Then Exit Sub

                .Stats.minSta = .Stats.minSta + (.Stats.MaxSta * 0.1)

                If .Stats.minSta > .Stats.MaxSta Then .Stats.minSta = .Stats.MaxSta

                Call QuitarUserInvItem(UserIndex, Slot, 1)

                If .Counters.TickSoundPotions < TActual Then
                    .Counters.TickSoundPotions = TActual + 370
                    If .flags.AdminInvisible = 1 Then
                        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    Else
                        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_BEBER, .Pos.X, .Pos.Y))
                    End If
                End If

                'Call WriteUpdateSta(UserIndex)
            End Select

        Else
            .Counters.failedUsageAttempts = .Counters.failedUsageAttempts + 1

            If .Counters.failedUsageAttempts = 3 Then        'Tolerancia_FailIntervalo Then                     ' @@ Avisamos por consola posible chitero
                Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Posible alteracion de intervalos por parte de : " & .Name & " Hora: " & Time$, FontTypeNames.FONTTYPE_EJECUCION))
                .Counters.failedUsageAttempts = 0
                Exit Sub
            End If

        End If

    End With

46  Call WriteUpdateUserStats(UserIndex)
47  Call UpdateUserInv(False, UserIndex, Slot)
    Exit Sub
Errhandler:
    Call LogError("error en useinvpotion en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Sub EnivarArmasConstruibles(ByVal UserIndex As Integer)

    Call WriteBlacksmithWeapons(UserIndex)
End Sub

Sub EnivarObjConstruibles(ByVal UserIndex As Integer)
    Call WriteCarpenterObjects(UserIndex)
End Sub

Sub EnivarArmadurasConstruibles(ByVal UserIndex As Integer)
    Call WriteBlacksmithArmors(UserIndex)
End Sub

Sub TirarTodo(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    With UserList(UserIndex)
1       If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 6 Then Exit Sub

2       Call TirarTodosLosItems(UserIndex, .Pos.Map, .Pos.X, .Pos.Y)

        Dim cantidad As Long
3       cantidad = .Stats.GLD

4       If cantidad < 100000 Then
5           Call TirarOro(cantidad, UserIndex)
        End If
    End With
    Exit Sub
Errhandler:
    Call LogError("Error en TirarTodo en " & Erl & ". Err :" & Err.Number & " " & Err.Description)

End Sub

Public Function ItemSeCae(ByVal Index As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With ObjData(Index)
        ItemSeCae = (.Real <> 1 Or .NoSeCae = 0) And (.Caos <> 1 Or .NoSeCae = 0) And .OBJType <> eOBJType.otLlaves And .OBJType <> eOBJType.otBarcos And .NoSeCae = 0
        ItemSeCae = (ItemSeCae And .Alineacion = 0)
        If .Alineacion <> 0 Or .Real = 1 Or .Caos = 1 Then
            ItemSeCae = False
        End If

        If .NoSeSaca <> 0 Then
            ItemSeCae = False
        End If


    End With

End Function

Sub TirarTodosLosItems(ByVal UserIndex As Integer, ByVal Map As Integer, ByVal qX As Byte, ByVal qY As Byte)
'***************************************************
'Author: Unknown
'Last Modification: 12/01/2010 (ZaMa)
'12/01/2010: ZaMa - Ahora los piratas no explotan items solo si estan entre 20 y 25
'***************************************************

    Dim i As Byte
    Dim NuevaPos As WorldPos
    Dim MiObj As Obj
    Dim ItemIndex As Integer
    Dim DropAgua As Boolean
    Dim CurPos As WorldPos

    CurPos.Map = Map
    CurPos.Y = qY
    CurPos.X = qX
    Dim Cant As Long


    With UserList(UserIndex)

        If Not (.Clase = eClass.Pirat Or EsGM(UserIndex)) Then
            Cant = MAX_NORMAL_INVENTORY_SLOTS
        Else
            Cant = MAX_INVENTORY_SLOTS
            If Not EsGM(UserIndex) Then
                If .Invent.BarcoSlot > 0 Then    'And .Invent.BarcoObjIndex > 0 Then
                    If .Invent.Object(.Invent.BarcoSlot).Equipped > 0 Then
                        If (TieneObjetos(476, 1, UserIndex) And .Stats.UserSkills(eSkill.Navegacion) >= 65) Or EsNewbie(UserIndex) Then
                            Cant = Cant - 10
                        ElseIf TieneObjetos(475, 1, UserIndex) And .Stats.UserSkills(eSkill.Navegacion) >= 65 Then
                            Cant = Cant - 5
                        End If
                    End If
                End If
            End If
        End If

        For i = 1 To Cant
            ItemIndex = .Invent.Object(i).ObjIndex
            If ItemIndex > 0 Then
                If ItemSeCae(ItemIndex) Then
                    NuevaPos.X = 0
                    NuevaPos.Y = 0

                    'Creo el Obj
                    MiObj.Amount = .Invent.Object(i).Amount
                    MiObj.ObjIndex = ItemIndex

                    DropAgua = True
                    ' Es pirata?
                    If .Clase = eClass.Pirat Then
                        ' Si tiene galeon equipado
                        If hasItemAndEquipped(UserIndex, 476) Then    '.Invent.BarcoObjIndex = 476 Then
                            ' Limitación por nivel, después dropea normalmente
                            If .Stats.ELV >= 20 And .Stats.ELV <= 25 Then
                                ' No dropea en agua
                                DropAgua = False
                            End If
                        End If
                    End If

                    Call Tilelibre(CurPos, NuevaPos, MiObj, False, True)

                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
                        Call DropObj(UserIndex, i, MAX_INVENTORY_OBJS, NuevaPos.Map, NuevaPos.X, NuevaPos.Y)
                    End If
                End If
            End If
        Next i
    End With
End Sub

Function ItemNewbie(ByVal ItemIndex As Integer) As Boolean

    If ItemIndex < 1 Or ItemIndex > UBound(ObjData) Then Exit Function

    ItemNewbie = ObjData(ItemIndex).Newbie = 1
End Function

Sub TirarTodosLosItemsNoNewbies(ByVal UserIndex As Integer)
    Dim i As Byte
    Dim NuevaPos As WorldPos
    Dim MiObj As Obj
    Dim ItemIndex As Integer

    With UserList(UserIndex)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 6 Then Exit Sub

        Dim cantidad As Long
        cantidad = .Stats.GLD

        If cantidad < 100000 Then
            Call TirarOro(cantidad, UserIndex)
        End If

        Dim Cant As Long

        If Not (.Clase = eClass.Pirat Or EsGM(UserIndex)) Then
            Cant = MAX_NORMAL_INVENTORY_SLOTS
        Else
            Cant = MAX_INVENTORY_SLOTS
            If Not EsGM(UserIndex) Then
                If .Invent.BarcoSlot > 0 Then    'And .Invent.BarcoObjIndex > 0 Then
                    If .Invent.Object(.Invent.BarcoSlot).Equipped > 0 Then
                        If (TieneObjetos(476, 1, UserIndex) And .Stats.UserSkills(eSkill.Navegacion) >= 65) Or EsNewbie(UserIndex) Then
                            Cant = Cant - 10
                        ElseIf TieneObjetos(475, 1, UserIndex) And .Stats.UserSkills(eSkill.Navegacion) >= 65 Then
                            Cant = Cant - 5
                        End If
                    End If
                End If
            End If
        End If

        For i = 1 To Cant    'UserList(userindex).CurrentInventorySlots
            ItemIndex = .Invent.Object(i).ObjIndex
            If ItemIndex > 0 Then
                If ItemSeCae(ItemIndex) And Not ItemNewbie(ItemIndex) Then

                    NuevaPos.X = 0
                    NuevaPos.Y = 0

                    MiObj.Amount = .Invent.Object(i).Amount
                    MiObj.ObjIndex = ItemIndex

                    'Tira los Items no newbies en todos lados.
                    Tilelibre .Pos, NuevaPos, MiObj, False, True
                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
                        Call DropObj(UserIndex, i, MAX_INVENTORY_OBJS, NuevaPos.Map, NuevaPos.X, NuevaPos.Y)
                    End If
                End If
            End If
        Next i
    End With

End Sub

Sub TirarTodosLosItemsFull(ByVal UserIndex As Integer)

    Dim i As Byte
    Dim NuevaPos As WorldPos
    Dim MiObj As Obj
    Dim ItemIndex As Integer

    With UserList(UserIndex)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 6 Then Exit Sub

        For i = 1 To MAX_INVENTORY_SLOTS
            ItemIndex = .Invent.Object(i).ObjIndex
            If ItemIndex > 0 Then
                If ItemSeCae(ItemIndex) Then
                    NuevaPos.X = 0
                    NuevaPos.Y = 0

                    'Creo MiObj
                    MiObj.Amount = .Invent.Object(i).Amount
                    MiObj.ObjIndex = ItemIndex
                    Tilelibre .Pos, NuevaPos, MiObj, False, True
                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
                        Call DropObj(UserIndex, i, MAX_INVENTORY_OBJS, NuevaPos.Map, NuevaPos.X, NuevaPos.Y)
                    End If
                End If
            End If
        Next i
    End With

End Sub

Public Function getObjType(ByVal ObjIndex As Integer) As eOBJType

    If ObjIndex > 0 Then
        getObjType = ObjData(ObjIndex).OBJType
    End If

End Function

Function MeterItemEnBancoOFF(ByVal UserName As String, ByRef MiObj As Obj) As Boolean

    On Error GoTo Errhandler

    Dim UserFile As clsIniManager
    Set UserFile = New clsIniManager

    Call UserFile.Initialize(CharPath & UserName & ".chr")

    Dim Slot As Byte, ln As String
    Slot = 1
    ln = UserFile.GetValue("BancoInventory", "Obj" & Slot)

    Do Until val(ReadField(1, ln, 45)) = MiObj.ObjIndex And val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS
        Slot = Slot + 1
        ln = UserFile.GetValue("BancoInventory", "Obj" & Slot)

        If Slot > MAX_BANCOINVENTORY_SLOTS Then
            Exit Do
        End If
    Loop

    'Sino busca un slot vacio
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        Slot = 1
        ln = UserFile.GetValue("BancoInventory", "Obj" & Slot)

        Do Until val(ReadField(1, ln, 45)) = 0
            Slot = Slot + 1
            ln = UserFile.GetValue("BancoInventory", "Obj" & Slot)

            If Slot > MAX_BANCOINVENTORY_SLOTS Then
                MeterItemEnBancoOFF = False
                Set UserFile = Nothing
                Exit Function
            End If
        Loop

        Dim NroItems As Integer
        NroItems = val(UserFile.GetValue("BancoInventory", "CantidadItems")) + 1

        Call UserFile.ChangeValue("BancoInventory", "CantidadItems", NroItems)
    End If

    'Mete el objeto
    ln = UserFile.GetValue("BancoInventory", "Obj" & Slot)

    If val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS Then
        'Menor que MAX_INV_OBJS
        Call UserFile.ChangeValue("BancoInventory", "Obj" & Slot, MiObj.ObjIndex & "-" & val(ReadField(2, ln, 45)) + MiObj.Amount & "-" & val(ReadField(3, ln, 45)))
    Else
        Call UserFile.ChangeValue("BancoInventory", "Obj" & Slot, MiObj.ObjIndex & "-" & MAX_INVENTORY_OBJS & "-" & val(ReadField(3, ln, 45)))
    End If

    Call UserFile.DumpFile(CharPath & UserName & ".chr")
    Set UserFile = Nothing

    MeterItemEnBancoOFF = True

    Exit Function

Errhandler:

    Set UserFile = Nothing
    Call LogError("Error en MeterItemEnBancoOFF. Error " & Err.Number & " : " & Err.Description)

End Function

Function MeterItemEnBanco(ByVal UserIndex As Integer, ByRef MiObj As Obj) As Boolean

1   On Error GoTo Errhandler
2   Dim Slot As Byte
3   With UserList(UserIndex)
4       Slot = 1
5       Do Until .BancoInvent.Object(Slot).ObjIndex = MiObj.ObjIndex And _
           .BancoInvent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS
6           Slot = Slot + 1
7           If Slot > MAX_BANCOINVENTORY_SLOTS Then
8               Exit Do
9           End If
10      Loop
        'Sino busca un slot vacio
11      If Slot > MAX_BANCOINVENTORY_SLOTS Then
12          Slot = 1
13          Do Until .BancoInvent.Object(Slot).ObjIndex = 0
14              Slot = Slot + 1
15              If Slot > MAX_BANCOINVENTORY_SLOTS Then
16                  WriteMensajes UserIndex, e_Mensajes.Mensaje_153
17                  MeterItemEnBanco = False
                    Exit Function
                End If
            Loop
        End If

        'Mete el objeto
18      If .BancoInvent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS Then
            'Menor que MAX_INV_OBJS
19          .BancoInvent.Object(Slot).ObjIndex = MiObj.ObjIndex
20          .BancoInvent.Object(Slot).Amount = .BancoInvent.Object(Slot).Amount + MiObj.Amount
21      Else
22          .BancoInvent.Object(Slot).Amount = MAX_INVENTORY_OBJS
23      End If
    End With

24  MeterItemEnBanco = True

25  Call UpdateUserInv(False, UserIndex, Slot)


    Exit Function
Errhandler:
    Call LogError("Error en MeterItemEnBanco en " & Erl & ". Slot: " & Slot & " - ObjIndex: " & MiObj.ObjIndex & "(" & MiObj.Amount & ") Nick: " & UserList(UserIndex).Name & ". Error " & Err.Number & " : " & Err.Description)
End Function

