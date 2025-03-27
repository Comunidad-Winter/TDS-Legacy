Attribute VB_Name = "modBanco"
'**************************************************************
' modBanco.bas - Handles the character's bank accounts.
'
' Implemented by Kevin Birmingham (NEB)
' kbneb@hotmail.com
'**************************************************************

'**************************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'**************************************************************************

Option Explicit

Sub IniciarDeposito(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    'Hacemos un Update del inventario del usuario
    Call UpdateBanUserInv(True, UserIndex, 0)
    'Actualizamos el dinero
    Call WriteUpdateUserStats(UserIndex)
    'Mostramos la ventana pa' comerciar y ver ladear la osamenta. jajaja
    Call WriteBankInit(UserIndex)
    UserList(UserIndex).flags.Comerciando = True

Errhandler:

End Sub

Sub SendBanObj(UserIndex As Integer, Slot As Byte, Object As UserOBJ)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    UserList(UserIndex).BancoInvent.Object(Slot) = Object

    Call WriteChangeBankSlot(UserIndex, Slot)

End Sub

Sub UpdateBanUserInv(ByVal UpdateAll As Boolean, ByVal UserIndex As Integer, ByVal Slot As Byte)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim NullObj As UserOBJ
    Dim LoopC As Byte

    With UserList(UserIndex)
        'Actualiza un solo slot
        If Not UpdateAll Then
            'Actualiza el inventario
            If .BancoInvent.Object(Slot).ObjIndex > 0 Then
                Call SendBanObj(UserIndex, Slot, .BancoInvent.Object(Slot))
            Else
                Call SendBanObj(UserIndex, Slot, NullObj)
            End If
        Else
            'Actualiza todos los slots
            For LoopC = 1 To MAX_BANCOINVENTORY_SLOTS
                'Actualiza el inventario
                If .BancoInvent.Object(LoopC).ObjIndex > 0 Then
                    Call SendBanObj(UserIndex, LoopC, .BancoInvent.Object(LoopC))
                Else
                    Call SendBanObj(UserIndex, LoopC, NullObj)
                End If
            Next LoopC
        End If
    End With

End Sub

Sub UserRetiraItem(ByVal UserIndex As Integer, ByVal i As Integer, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler


    If cantidad < 1 Then cantidad = 1

    'Call WriteUpdateUserStats(UserIndex) 'why the fuck está esto acá

    If UserList(UserIndex).BancoInvent.Object(i).Amount > 0 Then
        If cantidad > UserList(UserIndex).BancoInvent.Object(i).Amount Then cantidad = UserList(UserIndex).BancoInvent.Object(i).Amount
        'Agregamos el obj que compro al inventario
        Call UserReciveObj(UserIndex, CInt(i), cantidad)
        'Actualizamos el inventario del usuario
        Call UpdateUserInv(True, UserIndex, 0)
        'Actualizamos el banco
        Call UpdateBanUserInv(True, UserIndex, 0)
    End If

    'Actualizamos la ventana de comercio
    Call UpdateVentanaBanco(UserIndex)

Errhandler:

End Sub

Sub UserReciveObj(ByVal UserIndex As Integer, ByVal ObjIndex As Integer, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Slot As Integer
    Dim obji As Integer

    With UserList(UserIndex)
        If .BancoInvent.Object(ObjIndex).Amount <= 0 Then Exit Sub

        obji = .BancoInvent.Object(ObjIndex).ObjIndex


        '¿Ya tiene un objeto de este tipo?
        Slot = 1
        Do Until .Invent.Object(Slot).ObjIndex = obji And _
           .Invent.Object(Slot).Amount + cantidad <= MAX_INVENTORY_OBJS

            Slot = Slot + 1
            If Slot > .CurrentInventorySlots Then
                Exit Do
            End If
        Loop

        'Sino se fija por un slot vacio
        If Slot > .CurrentInventorySlots Then
            Slot = 1
            Do Until .Invent.Object(Slot).ObjIndex = 0
                Slot = Slot + 1

                If Slot > .CurrentInventorySlots Then
                    Call WriteConsoleMsg(UserIndex, "No podés tener mas objetos.", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If
            Loop
            '.Invent.NroItems = .Invent.NroItems + 1
        End If

        'Mete el obj en el slot
        If .Invent.Object(Slot).Amount + cantidad <= MAX_INVENTORY_OBJS Then
            'Menor que MAX_INV_OBJS
            .Invent.Object(Slot).ObjIndex = obji

            .Invent.Object(Slot).Amount = .Invent.Object(Slot).Amount + cantidad


            Call QuitarBancoInvItem(UserIndex, CByte(ObjIndex), cantidad)
        Else
            Call WriteConsoleMsg(UserIndex, "No podés tener mas objetos.", FontTypeNames.FONTTYPE_INFO)
        End If
    End With

End Sub

Sub QuitarBancoInvItem(ByVal UserIndex As Integer, ByVal Slot As Byte, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim ObjIndex As Integer

    With UserList(UserIndex)
        ObjIndex = .BancoInvent.Object(Slot).ObjIndex

        'Quita un Obj

        .BancoInvent.Object(Slot).Amount = .BancoInvent.Object(Slot).Amount - cantidad

        If .BancoInvent.Object(Slot).Amount <= 0 Then
            '.BancoInvent.NroItems = .BancoInvent.NroItems - 1
            .BancoInvent.Object(Slot).ObjIndex = 0
            .BancoInvent.Object(Slot).Amount = 0
        End If
    End With

End Sub

Sub UpdateVentanaBanco(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Call WriteBankOK(UserIndex)
End Sub

Sub UserDepositaItem(ByVal UserIndex As Integer, ByVal Item As Integer, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler
    If UserList(UserIndex).Invent.Object(Item).Amount > 0 And cantidad > 0 Then
        If cantidad > UserList(UserIndex).Invent.Object(Item).Amount Then cantidad = UserList(UserIndex).Invent.Object(Item).Amount

        'Agregamos el obj que deposita al banco
        Call UserDejaObj(UserIndex, CInt(Item), cantidad)

        'Actualizamos el inventario del usuario
        Call UpdateUserInv(True, UserIndex, 0)

        'Actualizamos el inventario del banco
        Call UpdateBanUserInv(True, UserIndex, 0)
    End If

    'Actualizamos la ventana del banco
    Call UpdateVentanaBanco(UserIndex)
Errhandler:
End Sub

Sub UserDejaObj(ByVal UserIndex As Integer, ByVal ObjIndex As Integer, ByVal cantidad As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Slot As Integer
    Dim obji As Integer

    If cantidad < 1 Then Exit Sub

    With UserList(UserIndex)
        obji = .Invent.Object(ObjIndex).ObjIndex

        '¿Ya tiene un objeto de este tipo?
        Slot = 1
        Do Until .BancoInvent.Object(Slot).ObjIndex = obji And _
           .BancoInvent.Object(Slot).Amount + cantidad <= MAX_INVENTORY_OBJS
            Slot = Slot + 1

            If Slot > MAX_BANCOINVENTORY_SLOTS Then
                Exit Do
            End If
        Loop

        'Sino se fija por un slot vacio antes del slot devuelto
        If Slot > MAX_BANCOINVENTORY_SLOTS Then
            Slot = 1
            Do Until .BancoInvent.Object(Slot).ObjIndex = 0
                Slot = Slot + 1

                If Slot > MAX_BANCOINVENTORY_SLOTS Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_211
                    Exit Sub
                End If
            Loop

            '.BancoInvent.NroItems = .BancoInvent.NroItems + 1
        End If

        If Slot <= MAX_BANCOINVENTORY_SLOTS Then        'Slot valido
            'Mete el obj en el slot
            If .BancoInvent.Object(Slot).Amount + cantidad <= MAX_INVENTORY_OBJS Then

                'Menor que MAX_INV_OBJS
                .BancoInvent.Object(Slot).ObjIndex = obji
                .BancoInvent.Object(Slot).Amount = .BancoInvent.Object(Slot).Amount + cantidad

                Call QuitarUserInvItem(UserIndex, CByte(ObjIndex), cantidad)
            Else
                WriteMensajes UserIndex, e_Mensajes.Mensaje_212
            End If
        End If
    End With
End Sub

Sub SendUserBovedaTxt(ByVal SendIndex As Integer, ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim j As Long

1   Call WriteConsoleMsg(SendIndex, UserList(UserIndex).Name, FontTypeNames.FONTTYPE_INFO)
    'Call WriteConsoleMsg(SendIndex, "Tiene " & UserList(UserIndex).BancoInvent.NroItems & " objetos.", FontTypeNames.FONTTYPE_INFO)

2   For j = 1 To MAX_BANCOINVENTORY_SLOTS
3       If UserList(UserIndex).BancoInvent.Object(j).ObjIndex > 0 Then
4           Call WriteConsoleMsg(SendIndex, "Objeto " & j & " " & ObjData(UserList(UserIndex).BancoInvent.Object(j).ObjIndex).Name & " Cantidad:" & UserList(UserIndex).BancoInvent.Object(j).Amount, FontTypeNames.FONTTYPE_INFO)
5       End If
    Next j

    Exit Sub
Errhandler:
    Call LogError("Error en SendUserBovedaTxt en  " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Sub SendUserBovedaTxtFromChar(ByVal SendIndex As Integer, ByVal charName As String)

    On Error GoTo Errhandler
    Dim j As Long
    Dim CharFile As String, Tmp As String
    Dim ObjInd As Long, ObjCant As Long

1   CharFile = CharPath & charName & ".chr"

2   If FileExist(CharFile, vbNormal) Then
3       Call WriteConsoleMsg(SendIndex, charName, FontTypeNames.FONTTYPE_INFO)
4       Call WriteConsoleMsg(SendIndex, "Tiene " & GetVar(CharFile, "BancoInventory", "CantidadItems") & " objetos.", FontTypeNames.FONTTYPE_INFO)
5       For j = 1 To MAX_BANCOINVENTORY_SLOTS
6           Tmp = GetVar(CharFile, "BancoInventory", "Obj" & j)
76          ObjInd = ReadField(1, Tmp, Asc("-"))
8           ObjCant = ReadField(2, Tmp, Asc("-"))
9           If ObjInd > 0 Then
10              Call WriteConsoleMsg(SendIndex, "Objeto " & j & " " & ObjData(ObjInd).Name & " Cantidad:" & ObjCant, FontTypeNames.FONTTYPE_INFO)
11          End If
        Next j
    Else
        Call WriteMensajes(SendIndex, Mensaje_50)
    End If

    Exit Sub
Errhandler:
    Call LogError("Error en SendUserBovedaTxtFromChar en  " & Erl & ". Err :" & Err.Number & " " & Err.Description)

End Sub

