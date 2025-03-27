Attribute VB_Name = "modSistemaComercio"
'*****************************************************
'Sistema de Comercio para Argentum Online
'Programado por Nacho (Integer)
'integer-x@hotmail.com
'*****************************************************

'**************************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the GNU General Public License as published by
'the Free Software Foundation; either version 2 of the License, or
'(at your option) any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'GNU General Public License for more details.
'
'You should have received a copy of the GNU General Public License
'along with this program; if not, write to the Free Software
'Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
'**************************************************************************

Option Explicit

Enum eModoComercio
    Compra = 1
    Venta = 2
End Enum

Public Const REDUCTOR_PRECIOVENTA As Byte = 3

''
' Makes a trade. (Buy or Sell)
'
' @param Modo The trade type (sell or buy)
' @param UserIndex Specifies the index of the user
' @param NpcIndex specifies the index of the npc
' @param Slot Specifies which slot are you trying to sell / buy
' @param Cantidad Specifies how many items in that slot are you trying to sell / buy
Public Sub Comercio(ByVal modo As eModoComercio, ByVal UserIndex As Integer, ByVal NpcIndex As Integer, ByVal Slot As Integer, ByVal cantidad As Integer, Optional ByVal toSlot As Byte = 0, Optional ByVal NotDrag As Boolean = True)
'*************************************************
'Author: Nacho (Integer)
'Last modified: 27/07/08 (MarKoxX) | New changes in the way of trading (now when you buy it rounds to ceil and when you sell it rounds to floor)
'  - 06/13/08 (NicoNZ)
'*************************************************
    Dim precio As Long
    Dim objeto As Obj

    If cantidad < 1 Or Slot < 1 Then Exit Sub

    If modo = eModoComercio.Compra Then
        If Slot > MAX_INVENTORY_SLOTS Then
            Exit Sub
        ElseIf cantidad > MAX_INVENTORY_OBJS Then
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " ha sido baneado por el sistema anti-cheats.", FontTypeNames.FONTTYPE_FIGHT))
            Call Ban(UserList(UserIndex).Name, "Sistema Anti Cheats", "Intentar hackear el sistema de comercio. Quiso comprar demasiados ítems:" & cantidad)
            UserList(UserIndex).flags.Ban = 1
            Call WriteVar(CharPath & UserList(UserIndex).Name & ".chr", "PENAS", "BanMotivo", "SERVIDOR: BAN POR HACK COMERCIO " & Date & " " & Time)
            Call WriteErrorMsg(UserIndex, "Has sido baneado por el Sistema AntiCheat.")

            'Call Flushbuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Sub
        ElseIf Not Npclist(NpcIndex).Invent.Object(Slot).Amount > 0 Then
            Exit Sub
        End If

        If cantidad > Npclist(NpcIndex).Invent.Object(Slot).Amount Then cantidad = Npclist(UserList(UserIndex).flags.TargetNPC).Invent.Object(Slot).Amount

        objeto.Amount = cantidad
        objeto.ObjIndex = Npclist(NpcIndex).Invent.Object(Slot).ObjIndex

        precio = CLng((ObjData(Npclist(NpcIndex).Invent.Object(Slot).ObjIndex).Valor / Descuento(UserIndex) * cantidad) + 0.5)

        If UserList(UserIndex).Stats.GLD < precio Then
            WriteMensajes UserIndex, e_Mensajes.Mensaje_37
            Exit Sub
        End If

        Dim loMetio As Boolean
        If toSlot <> 0 Then
            If (UserList(UserIndex).Invent.Object(toSlot).ObjIndex = objeto.ObjIndex And _
                UserList(UserIndex).Invent.Object(toSlot).Amount + objeto.Amount <= MAX_INVENTORY_OBJS) Then
                loMetio = True
                UserList(UserIndex).Invent.Object(toSlot).Amount = UserList(UserIndex).Invent.Object(toSlot).Amount + objeto.Amount
            ElseIf (UserList(UserIndex).Invent.Object(toSlot).ObjIndex = 0) Then
                UserList(UserIndex).Invent.Object(toSlot).ObjIndex = objeto.ObjIndex
                UserList(UserIndex).Invent.Object(toSlot).Amount = objeto.Amount
                loMetio = True
            End If
        End If
        If Not loMetio Then
            If MeterItemEnInventario(UserIndex, objeto) = False Then

                If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, Slot)
                Call WriteTradeOK(UserIndex)
                Exit Sub
            End If
        End If

        UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD - precio

        Call QuitarNpcInvItem(UserList(UserIndex).flags.TargetNPC, CByte(Slot), cantidad)

        'Bien, ahora logueo de ser necesario. Pablo (ToxicWaste) 07/09/07
        'Es un Objeto que tenemos que loguear?
        If ObjData(objeto.ObjIndex).Log = 1 Then
            Call LogDesarrollo(UserList(UserIndex).Name & " -Buy- " & objeto.Amount & " " & ObjData(objeto.ObjIndex).Name)
        ElseIf objeto.Amount > 1000 Then        'Es mucha cantidad?
            'Si no es de los prohibidos de loguear, lo logueamos.
            If ObjData(objeto.ObjIndex).NoLog <> 1 Then
                Call LogDesarrollo(UserList(UserIndex).Name & " -Buy- " & objeto.Amount & " " & ObjData(objeto.ObjIndex).Name)
            End If
        End If

        'Agregado para que no se vuelvan a vender las llaves si se recargan los .dat.
        If ObjData(objeto.ObjIndex).OBJType = otLlaves Then
            Call WriteVar(DatPath & "NPCs.dat", "NPC" & Npclist(NpcIndex).Numero, "obj" & Slot, objeto.ObjIndex & "-0")
            NpcInfo(Npclist(NpcIndex).Numero).Invent.Object(Slot).Amount = 0
            Call logVentaCasa(UserList(UserIndex).Name & " compró " & ObjData(objeto.ObjIndex).Name)
        End If
        If NotDrag Then Call EnviarNpcInv(UserIndex, NpcIndex, Slot)
    ElseIf modo = eModoComercio.Venta Then

        If cantidad > UserList(UserIndex).Invent.Object(Slot).Amount Then cantidad = UserList(UserIndex).Invent.Object(Slot).Amount

        objeto.Amount = cantidad
        objeto.ObjIndex = UserList(UserIndex).Invent.Object(Slot).ObjIndex

        If objeto.ObjIndex = 0 Then
            Exit Sub
        ElseIf (Npclist(NpcIndex).TipoItems <> ObjData(objeto.ObjIndex).OBJType And Npclist(NpcIndex).TipoItems <> eOBJType.otCualquiera) Or objeto.ObjIndex = iORO Then
            Call WriteMensajes(UserIndex, Mensaje_35)
            If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
            Call WriteTradeOK(UserIndex)
            Exit Sub
        ElseIf ObjData(objeto.ObjIndex).Real = 1 Then
            If Npclist(NpcIndex).Name <> "SR" Then
                Call WriteMensajes(UserIndex, Mensaje_395)
                If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
                Call WriteTradeOK(UserIndex)
                Exit Sub
            End If
        ElseIf ObjData(objeto.ObjIndex).NoSeSaca = 1 Then
            Call WriteConsoleMsg(UserIndex, "Éste item no se puede comercializar!")
            'If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
            'Call WriteTradeOK(UserIndex)
            Exit Sub
        ElseIf ObjData(objeto.ObjIndex).Caos = 1 Then
            If Npclist(NpcIndex).Name <> "SC" Then

                Call WriteMensajes(UserIndex, Mensaje_396)
                If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
                Call WriteTradeOK(UserIndex)
                Exit Sub
            End If
        ElseIf UserList(UserIndex).Invent.Object(Slot).Amount < 0 Or cantidad = 0 Then
            Exit Sub
        ElseIf Slot < LBound(UserList(UserIndex).Invent.Object()) Or Slot > UBound(UserList(UserIndex).Invent.Object()) Then
            If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC)
            Exit Sub
        ElseIf UserList(UserIndex).flags.Privilegios = PlayerType.Consejero Then

            Call WriteMensajes(UserIndex, Mensaje_397)
            If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
            Call WriteTradeOK(UserIndex)
            Exit Sub
        ElseIf UserList(UserIndex).Invent.Object(Slot).Equipped = 1 Then

            Call WriteMensajes(UserIndex, Mensaje_440)
            If NotDrag Then Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
            Call WriteTradeOK(UserIndex)
            Exit Sub
        End If

        Call QuitarUserInvItem(UserIndex, Slot, cantidad)

        If ObjData(objeto.ObjIndex).Newbie = 0 Then

            precio = Fix(SalePrice(objeto.ObjIndex) * cantidad)
            UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD + precio

            If UserList(UserIndex).Stats.GLD > MAXORO Then _
               UserList(UserIndex).Stats.GLD = MAXORO

            Dim NpcSlot As Integer
            NpcSlot = SlotEnNPCInv(NpcIndex, objeto.ObjIndex, objeto.Amount)

            If NpcSlot <= MAX_INVENTORY_SLOTS Then        'Slot valido
                'Mete el obj en el slot
                Npclist(NpcIndex).Invent.Object(NpcSlot).ObjIndex = objeto.ObjIndex
                Npclist(NpcIndex).Invent.Object(NpcSlot).Amount = Npclist(NpcIndex).Invent.Object(NpcSlot).Amount + objeto.Amount
                If Npclist(NpcIndex).Invent.Object(NpcSlot).Amount > MAX_INVENTORY_OBJS Then
                    Npclist(NpcIndex).Invent.Object(NpcSlot).Amount = MAX_INVENTORY_OBJS
                End If
            End If

            If ObjData(objeto.ObjIndex).Log = 1 Then
                Call LogDesarrollo(UserList(UserIndex).Name & " -SellObj- " & objeto.Amount & " " & ObjData(objeto.ObjIndex).Name)
            ElseIf objeto.Amount = 1000 Then        'Es mucha cantidad?
                'Si no es de los prohibidos de loguear, lo logueamos.
                If ObjData(objeto.ObjIndex).NoLog <> 1 Then
                    Call LogDesarrollo(UserList(UserIndex).Name & " -SellObj- " & objeto.Amount & " " & ObjData(objeto.ObjIndex).Name)
                End If
            End If
            If NotDrag And NpcSlot <= MAX_INVENTORY_SLOTS Then Call EnviarNpcInv(UserIndex, NpcIndex, NpcSlot)
        End If
    End If

    Call UpdateUserInv(False, UserIndex, Slot)
    Call WriteUpdateGold(UserIndex)

    Call WriteTradeOK(UserIndex)

    Call SubirSkill(UserIndex, eSkill.Comerciar, True)

End Sub

Public Sub IniciarComercioNPC(ByVal UserIndex As Integer)
'*************************************************
'Author: Nacho (Integer)
'Last modified: 2/8/06
'*************************************************
    Call EnviarNpcInv(UserIndex, UserList(UserIndex).flags.TargetNPC, 0, False)
    UserList(UserIndex).flags.Comerciando = True
    Call WriteCommerceInit(UserIndex)
End Sub

Public Sub CancelarComercioUser(ByVal UserIndex As Integer)

    With UserList(UserIndex)
        If .flags.Comerciando Then
            Dim OtroUserIndex As Long
            OtroUserIndex = .ComUsu.DestUsu
            If OtroUserIndex > 0 And OtroUserIndex <= MaxUsers Then
                Call WriteConsoleMsg(UserIndex, "¡¡Comercio cancelado por el servidor!!", FontTypeNames.FONTTYPE_TALK)
                WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129
                Call LimpiarComercioSeguro(UserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
                'Call Protocol.FlushBuffer(UserIndex)
            End If
        End If
    End With

End Sub

Private Function SlotEnNPCInv(ByVal NpcIndex As Integer, ByVal objeto As Integer, ByVal cantidad As Integer) As Integer
'*************************************************
'Author: Nacho (Integer)
'Last modified: 2/8/06
'*************************************************
    SlotEnNPCInv = 1
    Do Until Npclist(NpcIndex).Invent.Object(SlotEnNPCInv).ObjIndex = objeto _
       And Npclist(NpcIndex).Invent.Object(SlotEnNPCInv).Amount + cantidad <= MAX_INVENTORY_OBJS

        SlotEnNPCInv = SlotEnNPCInv + 1
        If SlotEnNPCInv > MAX_INVENTORY_SLOTS Then Exit Do

    Loop

    If SlotEnNPCInv > MAX_INVENTORY_SLOTS Then

        SlotEnNPCInv = 1

        Do Until Npclist(NpcIndex).Invent.Object(SlotEnNPCInv).ObjIndex = 0

            SlotEnNPCInv = SlotEnNPCInv + 1
            If SlotEnNPCInv > MAX_INVENTORY_SLOTS Then Exit Do

        Loop

        If SlotEnNPCInv <= MAX_INVENTORY_SLOTS Then Npclist(NpcIndex).Invent.NroItems = Npclist(NpcIndex).Invent.NroItems + 1

    End If

End Function

Private Function Descuento(ByVal UserIndex As Integer) As Single
'*************************************************
'Author: Nacho (Integer)
'Last modified: 2/8/06
'*************************************************
    Descuento = 1 + UserList(UserIndex).Stats.UserSkills(eSkill.Comerciar) / 100
End Function

''
' Send the inventory of the Npc to the user
'
' @param userIndex The index of the User
' @param npcIndex The index of the NPC

Private Sub EnviarNpcInv(ByVal UserIndex As Integer, ByVal NpcIndex As Integer, Optional ByVal Slot As Byte = 0, Optional ByVal ToAll As Boolean = True)
    On Error GoTo Errhandler

    Dim val As Single
    Dim thisObj As Obj
    Dim DummyObj As Obj
1   If Slot = 0 Then

2       For Slot = 1 To MAX_NORMAL_INVENTORY_SLOTS
3           If Npclist(NpcIndex).Invent.Object(Slot).ObjIndex > 0 Then

4               thisObj.ObjIndex = Npclist(NpcIndex).Invent.Object(Slot).ObjIndex
5               thisObj.Amount = Npclist(NpcIndex).Invent.Object(Slot).Amount

6               val = (ObjData(thisObj.ObjIndex).Valor) / Descuento(UserIndex)

7               Call WriteChangeNPCInventorySlot(UserIndex, Slot, thisObj, val)
8               If ToAll Then Call SendData(SendTarget.ToNPCCommerceArray, UserIndex, PrepareMessageSetChangeNPCInventorySlot(Slot, thisObj, val))
            Else

9               Call WriteChangeNPCInventorySlot(UserIndex, Slot, DummyObj, 0)
10              If ToAll Then Call SendData(SendTarget.ToNPCCommerceArray, UserIndex, PrepareMessageSetChangeNPCInventorySlot(Slot, DummyObj, 0))

            End If
        Next Slot
    Else
        If Slot Then
11          If Npclist(NpcIndex).Invent.Object(Slot).ObjIndex > 0 Then

12              thisObj.ObjIndex = Npclist(NpcIndex).Invent.Object(Slot).ObjIndex
13              thisObj.Amount = Npclist(NpcIndex).Invent.Object(Slot).Amount

14              val = (ObjData(thisObj.ObjIndex).Valor) / Descuento(UserIndex)

15              Call WriteChangeNPCInventorySlot(UserIndex, Slot, thisObj, val)
16              Call SendData(SendTarget.ToNPCCommerceArray, UserIndex, PrepareMessageSetChangeNPCInventorySlot(Slot, thisObj, val))
            Else
17              Call WriteChangeNPCInventorySlot(UserIndex, Slot, DummyObj, 0)
18              Call SendData(SendTarget.ToNPCCommerceArray, UserIndex, PrepareMessageSetChangeNPCInventorySlot(Slot, DummyObj, 0))
            End If
        End If
    End If
    Exit Sub
Errhandler:
    Call LogError("error en EnviarNPcInv en " & Erl & ". Err :" & Err.Number & " " & Err.Description & "... UserIndex:" & UserIndex & " - Slot:" & Slot)
End Sub


''
' Devuelve el valor de venta del objeto
'
' @param ObjIndex  El número de objeto al cual le calculamos el precio de venta

Public Function SalePrice(ByVal ObjIndex As Integer) As Single
'*************************************************
'Author: Nicolás (NicoNZ)
'
'*************************************************
    If ObjIndex < 1 Or ObjIndex > UBound(ObjData) Then Exit Function
    If ItemNewbie(ObjIndex) Then Exit Function

    SalePrice = ObjData(ObjIndex).Valor / REDUCTOR_PRECIOVENTA
End Function

Public Function DelayBuy(ByVal UserIndex As Integer) As Boolean

    Dim TActual As Long
    TActual = GetTickCount()

    If TActual - UserList(UserIndex).DelayBuy < 50 Then
        DelayBuy = False
    Else
        UserList(UserIndex).DelayBuy = TActual
        DelayBuy = True
    End If

End Function
