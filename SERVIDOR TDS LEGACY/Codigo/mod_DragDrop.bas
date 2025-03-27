Attribute VB_Name = "mod_DragDrop"
Option Explicit

Public Sub DragToUser(ByVal UserIndex As Integer, _
                      ByVal tIndex As Integer, _
                      ByVal Slot As Byte, _
                      ByVal Amount As Integer)

    On Error GoTo Errhandler

    Dim tObj As Obj
    Dim tString As String
    Dim Espacio As Boolean

    If UserList(UserIndex).Invent.Object(Slot).Amount < Amount Then
        Amount = UserList(UserIndex).Invent.Object(Slot).Amount
        WriteMensajes UserIndex, e_Mensajes.Mensaje_210
        Exit Sub
    End If

    'Dim errorFound As String
    'If Not CanDragObj(UserList(UserIndex).Invent.Object(Slot).ObjIndex, (UserList(tindex).flags.Navegando = 1), errorFound, UserIndex) Then
    '   WriteConsoleMsg UserIndex, errorFound, FontTypeNames.FONTTYPE_INFO
    '    Exit Sub
    'End If

    If UserIndex = tIndex Then Exit Sub

    'Preparo el objeto.
    tObj.Amount = Amount
    tObj.ObjIndex = UserList(UserIndex).Invent.Object(Slot).ObjIndex

    If tObj.ObjIndex = 0 Then Exit Sub

    If ObjData(tObj.ObjIndex).Real = 1 Or ObjData(tObj.ObjIndex).Caos = 1 Or (Not ObjData(tObj.ObjIndex).Alineacion = 0) Or ObjData(tObj.ObjIndex).NoSeSaca = 1 Then
        Call WriteConsoleMsg(UserIndex, "Éste item no se puede lanzar.", FontTypeNames.FONTTYPE_INFO)

        Exit Sub
    End If

    If ObjData(tObj.ObjIndex).Newbie = 1 Then
        Call WriteConsoleMsg(UserIndex, "Éste item no se puede lanzar.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    Espacio = MeterItemEnInventario(tIndex, tObj)

    'No tiene espacio.

    If Not Espacio Then
        WriteConsoleMsg UserIndex, "El usuario no tiene espacio en su inventario.", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If

    'Quito el objeto.
    QuitarUserInvItem UserIndex, Slot, Amount

    'Hago un update de su inventario.
    UpdateUserInv False, UserIndex, Slot

    'Preparo el mensaje para userINdex (quien dragea)

    tString = "Le has arrojado"

    If tObj.Amount <> 1 Then
        tString = tString & " " & tObj.Amount & " - " & ObjData(tObj.ObjIndex).Name
    Else
        tString = tString & " tu " & ObjData(tObj.ObjIndex).Name
    End If

    tString = tString & " a " & UserList(tIndex).Name

    'Envio el mensaje
    WriteConsoleMsg UserIndex, tString, FontTypeNames.FONTTYPE_INFO

    'Preparo el mensaje para el otro usuario (quien recibe)
    tString = UserList(UserIndex).Name & " te ha arrojado"

    If tObj.Amount <> 1 Then
        tString = tString & " " & tObj.Amount & " - " & ObjData(tObj.ObjIndex).Name
    Else
        tString = tString & " su " & ObjData(tObj.ObjIndex).Name
    End If

    Call LogDesarrollo(UserList(UserIndex).Name & " -DragTo: " & UserList(tIndex).Name & "- " & tObj.Amount & " - " & ObjData(tObj.ObjIndex).Name & " - Pos:" & UserList(UserIndex).Pos.map & "-" & UserList(UserIndex).Pos.X & "-" & UserList(UserIndex).Pos.Y)

    'Envio el mensaje al otro usuario
    WriteConsoleMsg tIndex, tString, FontTypeNames.FONTTYPE_INFO

    Exit Sub

Errhandler:
    LogError "Error en DragToUser en " & Erl & ". Err: " & Err.Number & " " & Err.Description
End Sub

Public Sub DragToNPC(ByVal UserIndex As Integer, _
                     ByVal tNPC As Integer, _
                     ByVal Slot As Byte, _
                     ByVal Amount As Integer)

    On Error GoTo Errhandler

    Dim TeniaOro As Long
    Dim teniaObj As Integer
    Dim TmpIndex As Integer

    If UserList(UserIndex).Invent.Object(Slot).Amount < Amount Then
        Amount = UserList(UserIndex).Invent.Object(Slot).Amount
        'Exit Sub
    End If

    TmpIndex = UserList(UserIndex).Invent.Object(Slot).ObjIndex
    TeniaOro = UserList(UserIndex).Stats.GLD
    teniaObj = UserList(UserIndex).Invent.Object(Slot).Amount

    'Es un banquero?
    If Npclist(tNPC).NPCtype = eNPCType.Banquero Then
        Call UserDejaObj(UserIndex, Slot, Amount)
        'No tiene más el mismo amount que antes? entonces depositó.

        If teniaObj <> UserList(UserIndex).Invent.Object(Slot).Amount Then
            WriteMensajes UserIndex, Mensaje_383        ' & Amount & " - " & ObjData(tmpIndex).name,
            UpdateUserInv False, UserIndex, Slot
            Call LogDesarrollo(UserList(UserIndex).Name & " -DepoDrag- " & Amount & " - " & ObjData(TmpIndex).Name & " - Pos:" & UserList(UserIndex).Pos.map & "-" & Npclist(tNPC).Pos.X & "-" & Npclist(tNPC).Pos.Y)
        End If

        'Es un npc comerciante?
    ElseIf Npclist(tNPC).Comercia = 1 Then
        'El npc compra cualquier tipo de items?

        If Not Npclist(tNPC).TipoItems <> eOBJType.otCualquiera Or Npclist(tNPC).TipoItems = ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).OBJType Then
            Call Comercio(eModoComercio.Venta, UserIndex, tNPC, Slot, Amount, , False)
            'Ganó oro? si es así es porque lo vendió.

            If TeniaOro <> UserList(UserIndex).Stats.GLD Then
                WriteConsoleMsg UserIndex, "Le has vendido " & Amount & " - " & ObjData(TmpIndex).Name & " a " & Npclist(tNPC).Name, FontTypeNames.FONTTYPE_INFO
                Call LogDesarrollo(UserList(UserIndex).Name & " -SellDrag- " & Amount & " - " & ObjData(TmpIndex).Name & " - Pos:" & UserList(UserIndex).Pos.map & "-" & Npclist(tNPC).Pos.X & "-" & Npclist(tNPC).Pos.Y)
            End If

        Else
            WriteMensajes UserIndex, e_Mensajes.Mensaje_35

        End If
    ElseIf Npclist(tNPC).Comercia = 0 And Npclist(tNPC).NPCtype <> eNPCType.Banquero Then
        WriteMensajes UserIndex, Mensaje_384
    End If

    Exit Sub

Errhandler:
    LogError "Error en DragToNPC en " & Erl & ". Err: " & Err.Number & " " & Err.Description
End Sub

Public Sub DragToPos(ByVal UserIndex As Integer, _
                     ByVal X As Byte, _
                     ByVal Y As Byte, _
                     ByVal Slot As Byte, _
                     ByVal Amount As Integer)


    On Error GoTo Errhandler

    Dim errorFound As String
    Dim tObj As Obj
    Dim tString As String

    On Error GoTo Errhandler

    'No puede dragear en esa pos?

1   If Not CanDragToPos(UserList(UserIndex).Pos.map, X, Y, UserList(UserIndex).Invent.Object(Slot).ObjIndex, Amount, errorFound) Then
2       WriteConsoleMsg UserIndex, errorFound, FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If

3   If Not CanDragObj(UserList(UserIndex).Invent.Object(Slot).ObjIndex, (UserList(UserIndex).flags.Navegando = 1), errorFound, UserIndex) Then
4       WriteConsoleMsg UserIndex, errorFound, FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If

5   If UserList(UserIndex).Invent.Object(Slot).Amount < Amount Then
6       WriteMensajes UserIndex, e_Mensajes.Mensaje_210
        Exit Sub
    End If

7   If UserList(UserIndex).flags.Comerciando Then Exit Sub

    If (Not ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).Alineacion = 0) Or (ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).Caos = 1) Or (ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).Real = 1) Or (ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).NoSeSaca = 1) Then
        WriteConsoleMsg UserIndex, "No se puede arrojar éste item", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If

    If ObjData(UserList(UserIndex).Invent.Object(Slot).ObjIndex).Newbie = 1 Then
        WriteConsoleMsg UserIndex, "No se puede arrojar éste item", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If


    'Creo el objeto.
8   tObj.ObjIndex = UserList(UserIndex).Invent.Object(Slot).ObjIndex
9   tObj.Amount = Amount

    Dim tmpPos As WorldPos
10  tmpPos.map = UserList(UserIndex).Pos.map
11  tmpPos.X = X
12  tmpPos.Y = Y

13  If distancia(UserList(UserIndex).Pos, tmpPos) > 7 Then
        Call WriteMensajes(UserIndex, Mensaje_385)

14      X = RandomNumber(X - 2, X + 2)
16      Y = RandomNumber(Y - 2, Y + 2)


        If X = 0 Then X = MinXBorder + 1
        If Y = 0 Then Y = MinYBorder + 1
        If Y > MaxYBorder Then Y = MaxYBorder - 1
        If X > MaxXBorder Then X = MaxXBorder - 1
        If (Y < UserList(UserIndex).Pos.Y - RANGO_VISION_Y) Then
            Y = UserList(UserIndex).Pos.Y - RANGO_VISION_Y
        End If
        If (X < UserList(UserIndex).Pos.X - RANGO_VISION_X) Then
            X = UserList(UserIndex).Pos.X - RANGO_VISION_X
        End If

        If (X > UserList(UserIndex).Pos.X + RANGO_VISION_X) Then
            X = UserList(UserIndex).Pos.X + RANGO_VISION_X
        End If

        If (Y > (UserList(UserIndex).Pos.Y + RANGO_VISION_Y)) Then
            Y = UserList(UserIndex).Pos.Y + RANGO_VISION_Y
        End If

        If (UserList(UserIndex).Pos.X - X > RANGO_VISION_X) Then
            X = UserList(UserIndex).Pos.X + RANGO_VISION_X
        End If

        Do While (Not MapData(tmpPos.map, X, Y).TileExit.map = 0) Or (Not InMapBounds(tmpPos.map, X, Y)) Or (CanDragToPos(UserList(UserIndex).Pos.map, X, Y, UserList(UserIndex).Invent.Object(Slot).ObjIndex, Amount, Err) = False)
            If X = 0 Then X = MinXBorder
            If Y = 0 Then Y = MinYBorder
            If Y > MaxYBorder Then Y = MaxYBorder
            If X > MaxXBorder Then X = MaxXBorder
17          X = RandomNumber(X - 1, X + 1)
18          Y = RandomNumber(Y - 1, Y + 1)
            If X = 0 Then X = MinXBorder + 1
            If Y = 0 Then Y = MinYBorder + 1
            If Y > MaxYBorder Then Y = MaxYBorder - 1
            If X > MaxXBorder Then X = MaxXBorder - 1
        Loop

19  End If
    'Agrego el objeto a la posición.
20  MakeObj tObj, UserList(UserIndex).Pos.map, CInt(X), CInt(Y)

    'Quito el objeto.
21  QuitarUserInvItem UserIndex, Slot, Amount

    'Actualizo el inventario
22  UpdateUserInv False, UserIndex, Slot

    'Preparo el mensaje.
    tString = "Has arrojado "

23  tString = tString & tObj.Amount & " - " & ObjData(tObj.ObjIndex).Name

    Call LogDesarrollo(UserList(UserIndex).Name & " -DropDrag- " & tObj.Amount & " - " & ObjData(tObj.ObjIndex).Name & " - Pos:" & UserList(UserIndex).Pos.map & "-" & CInt(X) & "-" & CInt(Y))

    'ENvio.
24  WriteConsoleMsg UserIndex, tString, FontTypeNames.FONTTYPE_INFO

    Exit Sub
Errhandler:
    Call LogError("Error en DragtoPos en " & Erl & " " & Err.Number & " " & Err.Description)
End Sub

Private Function CanDragToPos(ByVal map As Integer, _
                              ByVal X As Byte, _
                              ByVal Y As Byte, _
                              ByVal ObjIndex As Integer, _
                              ByVal Amount As Integer, _
                              ByRef error As String) As Boolean

'Zona segura?

    If Not MapInfo(map).pk Then
        error = "No está permitido arrojar objetos al suelo en zonas seguras."
        Exit Function
    End If

    If Not InMapBounds(map, X, Y) Then
        error = "¡Rango erroneo!"
        Exit Function
    End If

    'Ya hay objeto?
    If MapData(map, X, Y).ObjInfo.ObjIndex > 0 Then
        If MapData(map, X, Y).ObjInfo.ObjIndex <> ObjIndex Then
            error = "¡Hay un objeto en esa posición!"
            Exit Function
        End If

        If (Amount + MapData(map, X, Y).ObjInfo.Amount) > 10000 Then
            error = "¡Aquí no cabe más de éste item!"
            Exit Function
        End If
    End If

    'Tile bloqueado?

    If Not MapData(map, X, Y).Blocked = 0 Then
        error = "No puedes arrojar objetos en esa posición"
        Exit Function
    End If

    If HayAgua(map, X, Y) Then
        error = "No puedes arrojar objetos al agua"
        Exit Function
    End If

    CanDragToPos = True

End Function

Private Function CanDragObj(ByVal ObjIndex As Integer, _
                            ByVal Navegando As Boolean, _
                            ByRef error As String, ByVal UserIndex As Integer) As Boolean
    CanDragObj = False

    If ObjIndex < 1 Or ObjIndex > UBound(ObjData()) Then Exit Function

    'Objeto newbie?
    If ObjData(ObjIndex).Newbie <> 0 Then
        error = "No puedes arrojar objetos newbies!"
        Exit Function
    End If

    If ObjData(ObjIndex).NoSeSaca <> 0 Then
        error = "No puedes arrojar objetos especiales!"
        Exit Function
    End If

    If ObjData(ObjIndex).Real <> 0 Or ObjData(ObjIndex).Caos <> 0 Or ObjData(ObjIndex).Alineacion <> 0 Then
        error = "No puedes arrojar objetos faccionarios!"
        Exit Function
    End If

    'Está navgeando?
    If Navegando And UserList(UserIndex).Invent.BarcoObjIndex = ObjIndex Then
        error = "No puedes arrojar un barco si estás navegando!"
        Exit Function
    End If

    If UserList(UserIndex).sReto.Reto_Index > 0 Or UserList(UserIndex).mReto.Reto_Index > 0 Then
        error = "No puedes arrojar objetos si estás retando!"
        Exit Function
    End If

    CanDragObj = True

End Function


