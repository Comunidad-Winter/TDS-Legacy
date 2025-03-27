Attribute VB_Name = "mdlCOmercioConUsuario"
'**************************************************************
' mdlComercioConUsuarios.bas - Allows players to commerce between themselves.
'
' Designed and implemented by Alejandro Santos (AlejoLP)
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

'[Alejo]
Option Explicit

Private Const MAX_ORO_LOGUEABLE As Long = 1000
Private Const MAX_OBJ_LOGUEABLE As Long = 500

Public Const MAX_OFFER_SLOTS As Integer = 20        '20
Public Const GOLD_OFFER_SLOT As Integer = MAX_OFFER_SLOTS + 1

Public Type tCOmercioUsuario
    DestUsu As Integer        'El otro Usuario
    DestNick As String
    objeto(1 To MAX_OFFER_SLOTS) As Integer        'Indice de los objetos que se desea dar
    goldAmount As Long

    Cant(1 To MAX_OFFER_SLOTS) As Long        'Cuantos objetos desea dar
    Acepto As Boolean
    Confirmo As Boolean
End Type
Private Type tOfferItem
    ObjIndex As Integer
    Amount As Long
End Type

'origen: origen de la transaccion, originador del comando
'destino: receptor de la transaccion
Public Sub IniciarComercioConUsuario(ByVal Origen As Integer, ByVal Destino As Integer)
'***************************************************
'Autor: Unkown
'Last Modification: 25/11/2009
'
'***************************************************
    On Error GoTo Errhandler

    'Si ambos pusieron /comerciar entonces
    If UserList(Origen).ComUsu.DestUsu = Destino And _
       UserList(Destino).ComUsu.DestUsu = Origen Then
        If UserList(Origen).flags.Comerciando Or UserList(Destino).flags.Comerciando Then
            Call WriteConsoleMsg(Origen, "No puedes comerciar en este momento", FontTypeNames.FONTTYPE_TALK)
            Call WriteConsoleMsg(Destino, "No puedes comerciar en este momento", FontTypeNames.FONTTYPE_TALK)
            Exit Sub
        End If
        'Actualiza el inventario del usuario
        Call UpdateUserInv(True, Origen, 0)
        'Decirle al origen que abra la ventanita.
        Call WriteUserCommerceInit(Origen)
        UserList(Origen).flags.Comerciando = True

        'Actualiza el inventario del usuario
        Call UpdateUserInv(True, Destino, 0)
        'Decirle al origen que abra la ventanita.
        Call WriteUserCommerceInit(Destino)
        UserList(Destino).flags.Comerciando = True

        'Call EnviarObjetoTransaccion(Origen)
    Else
        'Es el primero que comercia ?
        Call WriteConsoleMsg(Destino, UserList(Origen).Name & " desea comerciar. Si deseas aceptar, escribe /COMERCIAR.", FontTypeNames.FONTTYPE_TALK)
        Call WriteConsoleMsg(Origen, "Le has solicitado comerciar a " & UserList(Destino).Name & ".", FontTypeNames.FONTTYPE_TALK)
        UserList(Destino).flags.TargetUser = Origen

    End If

    'Call Flushbuffer(Destino)

    Exit Sub
Errhandler:
    Call LogError("Error en IniciarComercioConUsuario: " & Err.Description)
End Sub

Public Sub EnviarOferta(ByVal UserIndex As Integer, ByVal OfferSlot As Byte)
'***************************************************
'Autor: Unkown
'Last Modification: 25/11/2009
'Sends the offer change to the other trading user
'25/11/2009: ZaMa - Implementado nuevo sistema de comercio con ofertas variables.
'***************************************************
    On Error GoTo Errhandler

    Dim ObjIndex As Integer
    Dim ObjAmount As Long

1   With UserList(UserIndex)
2       If OfferSlot = GOLD_OFFER_SLOT Then
3           ObjIndex = iORO
4           ObjAmount = UserList(.ComUsu.DestUsu).ComUsu.goldAmount
5       Else
6           ObjIndex = UserList(.ComUsu.DestUsu).ComUsu.objeto(OfferSlot)
7           ObjAmount = UserList(.ComUsu.DestUsu).ComUsu.Cant(OfferSlot)
8       End If
    End With

9   Call WriteChangeUserTradeSlot(UserIndex, OfferSlot, ObjIndex, ObjAmount)
    'Call Flushbuffer(UserIndex)

    Exit Sub
Errhandler:
    Call LogError("error ne EnviarOferta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub FinComerciarUsu(ByVal UserIndex As Integer)
'***************************************************
'Autor: Unkown
'Last Modification: 25/11/2009
'25/11/2009: ZaMa - Limpio los arrays (por el nuevo sistema)
'***************************************************
    Dim i As Long
    On Error GoTo Errhandler

1   With UserList(UserIndex)
2       If .ComUsu.DestUsu > 0 Then
3           Call WriteUserCommerceEnd(UserIndex)
4       End If

5       .ComUsu.Acepto = False
6       .ComUsu.Confirmo = False
7       .ComUsu.DestUsu = 0

8       For i = 1 To MAX_OFFER_SLOTS
9           .ComUsu.Cant(i) = 0
10          .ComUsu.objeto(i) = 0
        Next i

11      .ComUsu.goldAmount = 0
12      .ComUsu.DestNick = vbNullString
13      .flags.Comerciando = False

14  End With
    Exit Sub
Errhandler:
    Call LogError("Error en FinComerciarUsu en " & Erl & ". UI: " & UserIndex & " Err:" & Err.Number & " " & Err.Description)
End Sub

Public Sub AceptarComercioUsu(ByVal UserIndex As Integer)
'***************************************************
'Autor: Unkown
'Last Modification: 25/11/2009
'25/11/2009: ZaMa - Ahora se traspasan hasta 5 items + oro al comerciar
'***************************************************

    On Error GoTo Errhandler

    Dim TradingObj As Obj
    Dim OtroUserIndex As Integer
    Dim OfferSlot As Integer

1   UserList(UserIndex).ComUsu.Acepto = True

2   OtroUserIndex = UserList(UserIndex).ComUsu.DestUsu

    ' Acepto el otro?
3   If UserList(OtroUserIndex).ComUsu.Acepto = False Then
4       Exit Sub
    End If

    ' User valido?
5   If OtroUserIndex <= 0 Or OtroUserIndex > MaxUsers Then
6       Call FinComerciarUsu(UserIndex)
        Exit Sub
    End If

435 If Not UserList(OtroUserIndex).ConnIDValida Then
645     Call FinComerciarUsu(UserIndex)
        Exit Sub
    End If

    ' Aceptaron ambos, chequeo que tengan los items que ofertaron
7   If Not HasOfferedItems(UserIndex) Then

8       Call WriteConsoleMsg(UserIndex, "¡¡¡El comercio se canceló porque no posees los ítems que ofertaste!!!", FontTypeNames.FONTTYPE_FIGHT)
9       Call WriteConsoleMsg(OtroUserIndex, "¡¡¡El comercio se canceló porque " & UserList(UserIndex).Name & " no posee los ítems que ofertó!!!", FontTypeNames.FONTTYPE_FIGHT)

10      Call FinComerciarUsu(UserIndex)
11      Call FinComerciarUsu(OtroUserIndex)
        'Call Protocol.FlushBuffer(OtroUserIndex)

        Exit Sub

12  ElseIf Not HasOfferedItems(OtroUserIndex) Then

13      Call WriteConsoleMsg(UserIndex, "¡¡¡El comercio se canceló porque " & UserList(OtroUserIndex).Name & " no posee los ítems que ofertó!!!", FontTypeNames.FONTTYPE_FIGHT)
14      Call WriteConsoleMsg(OtroUserIndex, "¡¡¡El comercio se canceló porque no posees los ítems que ofertaste!!!", FontTypeNames.FONTTYPE_FIGHT)

15      Call FinComerciarUsu(UserIndex)
16      Call FinComerciarUsu(OtroUserIndex)
        'Call Protocol.FlushBuffer(OtroUserIndex)

        Exit Sub

    End If

    ' Envio los items a quien corresponde
17  For OfferSlot = 1 To MAX_OFFER_SLOTS + 1

        ' Items del 1er usuario
18      With UserList(UserIndex)
            ' Le pasa el oro
19          If OfferSlot = GOLD_OFFER_SLOT Then
20              If .Stats.GLD >= .ComUsu.goldAmount Then
                    ' Quito la cantidad de oro ofrecida
21                  .Stats.GLD = .Stats.GLD - .ComUsu.goldAmount
                    ' Log
22                  Call LogDesarrollo(.Name & " soltó oro en comercio seguro con " & UserList(OtroUserIndex).Name & ". Cantidad: " & .ComUsu.goldAmount)
                    ' Update Usuario
23                  Call WriteUpdateUserStats(UserIndex)
                    ' Se la doy al otro
24                  UserList(OtroUserIndex).Stats.GLD = UserList(OtroUserIndex).Stats.GLD + .ComUsu.goldAmount
                    ' Update Otro Usuario
25                  Call WriteUpdateUserStats(OtroUserIndex)
                End If
                ' Le pasa lo ofertado de los slots con items
26          ElseIf .ComUsu.objeto(OfferSlot) > 0 Then
27              TradingObj.ObjIndex = .ComUsu.objeto(OfferSlot)
28              TradingObj.Amount = .ComUsu.Cant(OfferSlot)
29              If TieneObjetos(TradingObj.ObjIndex, TradingObj.Amount, UserIndex) = True Then
30                  Call QuitarObjetos(TradingObj.ObjIndex, TradingObj.Amount, UserIndex)
                    'Quita el objeto y se lo da al otro
31                  If Not MeterItemEnInventario(OtroUserIndex, TradingObj) Then
32                      Call TirarItemAlPiso(UserList(OtroUserIndex).Pos, TradingObj)
                    End If


                End If
                'Es un Objeto que tenemos que loguear? Pablo (ToxicWaste) 07/09/07
33              If ObjData(TradingObj.ObjIndex).Log = 1 Then
34                  Call LogDesarrollo(.Name & " le pasó en comercio seguro a " & UserList(OtroUserIndex).Name & " " & TradingObj.Amount & " " & ObjData(TradingObj.ObjIndex).Name)
                End If

                'Es mucha cantidad?
                'If TradingObj.Amount > MAX_OBJ_LOGUEABLE Then
                'Si no es de los prohibidos de loguear, lo logueamos.
                If ObjData(TradingObj.ObjIndex).NoLog <> 1 Then
35                  Call LogDesarrollo(UserList(OtroUserIndex).Name & " le pasó en comercio seguro a " & .Name & " " & TradingObj.Amount & " " & ObjData(TradingObj.ObjIndex).Name)
                End If
                'End If
            End If
        End With

        ' Items del 2do usuario
36      With UserList(OtroUserIndex)
            ' Le pasa el oro
37          If OfferSlot = GOLD_OFFER_SLOT Then
38              If .Stats.GLD >= .ComUsu.goldAmount Then
                    ' Quito la cantidad de oro ofrecida
39                  .Stats.GLD = .Stats.GLD - .ComUsu.goldAmount
                    ' Log
40                  If .ComUsu.goldAmount > MAX_ORO_LOGUEABLE Then Call LogDesarrollo(.Name & " soltó oro en comercio seguro con " & UserList(UserIndex).Name & ". Cantidad: " & .ComUsu.goldAmount)
                    ' Update Usuario
41                  Call WriteUpdateUserStats(OtroUserIndex)
                    'y se la doy al otro
42                  UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD + .ComUsu.goldAmount
43                  Call LogDesarrollo(UserList(UserIndex).Name & " recibió oro en comercio seguro con " & .Name & ". Cantidad: " & .ComUsu.goldAmount)
                    ' Update Otro Usuario
44                  Call WriteUpdateUserStats(UserIndex)
                End If
                ' Le pasa la oferta de los slots con items
            ElseIf .ComUsu.objeto(OfferSlot) > 0 Then
45              TradingObj.ObjIndex = .ComUsu.objeto(OfferSlot)
46              TradingObj.Amount = .ComUsu.Cant(OfferSlot)

47              If TieneObjetos(TradingObj.ObjIndex, TradingObj.Amount, OtroUserIndex) Then
48                  Call QuitarObjetos(TradingObj.ObjIndex, TradingObj.Amount, OtroUserIndex)
                    'Quita el objeto y se lo da al otro
49                  If Not MeterItemEnInventario(UserIndex, TradingObj) Then
50                      Call TirarItemAlPiso(UserList(UserIndex).Pos, TradingObj)
                    End If


                End If
                'Es un Objeto que tenemos que loguear? Pablo (ToxicWaste) 07/09/07
51              If ObjData(TradingObj.ObjIndex).Log = 1 Then
52                  Call LogDesarrollo(.Name & " le pasó en comercio seguro a " & UserList(UserIndex).Name & " " & TradingObj.Amount & " " & ObjData(TradingObj.ObjIndex).Name)
                End If

                'Es mucha cantidad?
                'If TradingObj.Amount > MAX_OBJ_LOGUEABLE Then
                'Si no es de los prohibidos de loguear, lo logueamos.
                If ObjData(TradingObj.ObjIndex).NoLog <> 1 Then
53                  Call LogDesarrollo(.Name & " le pasó en comercio seguro a " & UserList(UserIndex).Name & " " & TradingObj.Amount & " " & ObjData(TradingObj.ObjIndex).Name)
                End If
                'End If
            End If
        End With

    Next OfferSlot

    ' End Trade
54  Call FinComerciarUsu(UserIndex)
55  Call FinComerciarUsu(OtroUserIndex)

56  Call SaveUser(UserIndex, CharPath & UCase$(UserList(UserIndex).Name) & ".chr")
57  Call SaveUser(OtroUserIndex, CharPath & UCase$(UserList(OtroUserIndex).Name) & ".chr")

    Exit Sub
Errhandler:
    Call LogError("error en aceptarcomerciousu en " & Erl & " Nick1: " & UCase$(UserList(UserIndex).Name) & " y " & UCase$(UserList(OtroUserIndex).Name) & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub AgregarOferta(ByVal UserIndex As Integer, ByVal OfferSlot As Byte, ByVal ObjIndex As Integer, ByVal Amount As Long, ByVal IsGold As Boolean)
'***************************************************
'Autor: ZaMa
'Last Modification: 24/11/2009
'Adds gold or items to the user's offer
'***************************************************

    If PuedeSeguirComerciando(UserIndex) Then
        With UserList(UserIndex).ComUsu
            ' Si ya confirmo su oferta, no puede cambiarla!
            If Not .Confirmo Then
                If IsGold Then
                    ' Agregamos (o quitamos) mas oro a la oferta
                    .goldAmount = .goldAmount + Amount

                    ' Imposible que pase, pero por las dudas..
                    If .goldAmount < 0 Then .goldAmount = 0
                Else
                    ' Agreamos (o quitamos) el item y su cantidad en el slot correspondiente
                    ' Si es 0 estoy modificando la cantidad, no agregando
                    If ObjIndex > 0 Then .objeto(OfferSlot) = ObjIndex
                    .Cant(OfferSlot) = .Cant(OfferSlot) + Amount

                    'Quitó todos los items de ese tipo
                    If .Cant(OfferSlot) <= 0 Then
                        ' Removemos el objeto para evitar conflictos
                        .objeto(OfferSlot) = 0
                        .Cant(OfferSlot) = 0
                    End If
                End If
            End If
        End With
    End If

End Sub

Public Function PuedeSeguirComerciando(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: ZaMa
'Last Modification: 24/11/2009
'Validates wether the conditions for the commerce to keep going are satisfied
'***************************************************
    On Error GoTo Errhandler

    Dim OtroUserIndex As Integer
    Dim ComercioInvalido As Boolean

1   With UserList(UserIndex)
        ' Usuario valido?
2       If .ComUsu.DestUsu <= 0 Or .ComUsu.DestUsu > MaxUsers Then
3           ComercioInvalido = True
        End If

4       OtroUserIndex = .ComUsu.DestUsu

5       If Not ComercioInvalido Then
            ' Estan logueados?
6           If UserList(OtroUserIndex).flags.UserLogged = False Or .flags.UserLogged = False Then
7               ComercioInvalido = True
            End If
        End If

8       If Not ComercioInvalido Then
            ' Se estan comerciando el uno al otro?
9           If UserList(OtroUserIndex).ComUsu.DestUsu <> UserIndex Then
10              ComercioInvalido = True
            End If
        End If

11      If Not ComercioInvalido Then
            ' El nombre del otro es el mismo que al que le comercio?
12          If UserList(OtroUserIndex).Name <> .ComUsu.DestNick Then
13              ComercioInvalido = True
            End If
        End If

        If Not ComercioInvalido Then
            ' Mi nombre  es el mismo que al que el le comercia?
14          If .Name <> UserList(OtroUserIndex).ComUsu.DestNick Then
                ComercioInvalido = True
            End If
        End If

        If Not ComercioInvalido Then
            ' Esta vivo?
16          If UserList(OtroUserIndex).flags.Muerto = 1 Then
17              ComercioInvalido = True
            End If
        End If

        ' Fin del comercio
        If ComercioInvalido = True Then
18          Call FinComerciarUsu(UserIndex)

19          If OtroUserIndex <= 0 Or OtroUserIndex > MaxUsers Then
20              Call FinComerciarUsu(OtroUserIndex)
                'Call Protocol.FlushBuffer(OtroUserIndex)
            End If

            Exit Function
        End If
    End With

    PuedeSeguirComerciando = True

    Exit Function
Errhandler:
    Call LogError("Error en PuedeSeguirComerciando en " & Erl & ". Err: " & Err.Description & UserIndex)

End Function

Private Function HasOfferedItems(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Autor: ZaMa
'Last Modification: 05/06/2010
'Checks whether the user has the offered items in his inventory or not.
'***************************************************

    Dim OfferedItems(MAX_OFFER_SLOTS - 1) As tOfferItem
    Dim Slot As Long
    Dim SlotAux As Long
    Dim SlotCount As Long

    Dim ObjIndex As Integer

    With UserList(UserIndex).ComUsu

        ' Agrupo los items que son iguales
        For Slot = 1 To MAX_OFFER_SLOTS

            ObjIndex = .objeto(Slot)

            If ObjIndex > 0 Then

                For SlotAux = 0 To SlotCount - 1

                    If ObjIndex = OfferedItems(SlotAux).ObjIndex Then
                        ' Son iguales, aumento la cantidad
                        OfferedItems(SlotAux).Amount = OfferedItems(SlotAux).Amount + .Cant(Slot)
                        Exit For
                    End If

                Next SlotAux

                ' No encontro otro igual, lo agrego
                If SlotAux = SlotCount Then
                    OfferedItems(SlotCount).ObjIndex = ObjIndex
                    OfferedItems(SlotCount).Amount = .Cant(Slot)

                    SlotCount = SlotCount + 1
                End If

            End If

        Next Slot

        ' Chequeo que tengan la cantidad en el inventario
        For Slot = 0 To SlotCount - 1
            If Not HasEnoughItems(UserIndex, OfferedItems(Slot).ObjIndex, OfferedItems(Slot).Amount) Then Exit Function
        Next Slot

        ' Compruebo que tenga el oro que oferta
        If UserList(UserIndex).Stats.GLD < .goldAmount Then Exit Function

    End With

    HasOfferedItems = True

End Function
