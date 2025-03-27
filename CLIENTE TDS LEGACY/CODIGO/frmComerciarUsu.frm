VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form frmComerciarUsu 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   8880
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9975
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   592
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   665
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtAgregar 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Left            =   4440
      TabIndex        =   4
      Top             =   2370
      Width           =   1035
   End
   Begin VB.PictureBox picInvOfertaOtro 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      CausesValidation=   0   'False
      ClipControls    =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2880
      Left            =   6885
      ScaleHeight     =   192
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   160
      TabIndex        =   3
      Top             =   5070
      Width           =   2400
   End
   Begin VB.PictureBox picInvOfertaProp 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      CausesValidation=   0   'False
      ClipControls    =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2880
      Left            =   6885
      ScaleHeight     =   192
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   160
      TabIndex        =   2
      Top             =   945
      Width           =   2400
   End
   Begin VB.TextBox SendTxt 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   300
      Left            =   540
      MaxLength       =   160
      MultiLine       =   -1  'True
      TabIndex        =   1
      TabStop         =   0   'False
      ToolTipText     =   "Chat"
      Top             =   7650
      Width           =   6060
   End
   Begin VB.PictureBox picInvComercio 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      CausesValidation=   0   'False
      ClipControls    =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   2880
      Left            =   645
      ScaleHeight     =   192
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   160
      TabIndex        =   0
      Top             =   945
      Width           =   2400
   End
   Begin RichTextLib.RichTextBox CommerceConsole 
      Height          =   1620
      Left            =   495
      TabIndex        =   5
      TabStop         =   0   'False
      ToolTipText     =   "Mensajes del comercio"
      Top             =   5760
      Width           =   6120
      _ExtentX        =   10795
      _ExtentY        =   2858
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      DisableNoScroll =   -1  'True
      TextRTF         =   $"frmComerciarUsu.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Image picInvOroProp 
      Height          =   495
      Left            =   3360
      Top             =   960
      Width           =   1575
   End
   Begin VB.Image picInvOroOfertaProp 
      Height          =   495
      Left            =   5040
      Top             =   960
      Width           =   1575
   End
   Begin VB.Label lblOroOffered 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   5355
      TabIndex        =   9
      Top             =   1110
      Width           =   1335
   End
   Begin VB.Label lblOroCurrent 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   3630
      TabIndex        =   8
      Top             =   1110
      Width           =   1335
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Esperando respuesta..."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   255
      Left            =   7080
      TabIndex        =   7
      Top             =   4395
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Label lblOroOtro 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   5340
      TabIndex        =   6
      Top             =   5325
      Width           =   1335
   End
   Begin VB.Image imgCancelar 
      Height          =   465
      Left            =   135
      Tag             =   "1"
      Top             =   8250
      Width           =   1365
   End
   Begin VB.Image imgRechazar 
      Height          =   360
      Left            =   8220
      Tag             =   "2"
      Top             =   8160
      Width           =   1080
   End
   Begin VB.Image imgConfirmar 
      Height          =   360
      Left            =   7470
      Top             =   3960
      Width           =   1215
   End
   Begin VB.Image imgAceptar 
      Height          =   360
      Left            =   6840
      Tag             =   "2"
      Top             =   8160
      Width           =   1185
   End
   Begin VB.Image imgAgregar 
      Height          =   450
      Left            =   4380
      Top             =   1725
      Width           =   1170
   End
   Begin VB.Image imgQuitar 
      Height          =   450
      Left            =   4380
      Top             =   2925
      Width           =   1170
   End
End
Attribute VB_Name = "frmComerciarUsu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'**************************************************************
' frmComerciarUsu.frm
'
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

Private clsFormulario As New clsFrmMovMan


Private Const GOLD_OFFER_SLOT As Byte = INV_OFFER_SLOTS + 1

Private sCommerceChat As String
Private AceptarRechazar As Boolean
Private Confirmar As Boolean

Private OroOfrecido As Long
Public OroActual As Long


Private Sub CommerceConsole_Change()
    CommerceConsole.SelStart = Len(CommerceConsole.Text)
    CommerceConsole.Refresh
End Sub

Private Sub imgAceptar_Click()

    If Not AceptarRechazar Then Exit Sub        ' Deshabilitado

    Call WriteUserCommerceOk
    HabilitarAceptarRechazar False

End Sub

Private Sub imgAgregar_Click()

' No tiene seleccionado ningun item
    If InvComUsu.SelectedItem = 0 Then
        Call PrintCommerceMsg("¡No tienes ningún item seleccionado!", FontTypeNames.FONTTYPE_FIGHT)
        Exit Sub
    End If

    ' Numero invalido
    If Not IsNumeric(txtAgregar.Text) Then Exit Sub

    HabilitarConfirmar True

    Dim OfferSlot As Byte
    Dim amount As Long
    Dim InvSlot As Byte

    With InvComUsu
        If .SelectedItem = FLAGORO Then

            amount = Val(txtAgregar.Text)

            If OroActual <= 0 Then Exit Sub

            If amount > OroActual Then
                amount = OroActual
            End If

            If amount <= 0 Then _
               Exit Sub

            OroActual = OroActual - amount
            OroOfrecido = OroOfrecido + amount

            ' Le aviso al otro de mi cambio de oferta
            Call WriteUserCommerceOffer(FLAGORO, amount, GOLD_OFFER_SLOT)

            ' Actualizo los inventarios
            lblOroCurrent.Caption = IIf(OroActual = 0, "0", format$(OroActual, "###,###,###"))
            lblOroOffered.Caption = IIf(OroOfrecido = 0, "0", format$(OroOfrecido, "###,###,###"))

            Call PrintCommerceMsg("¡Agregaste " & amount & " moneda" & IIf(amount = 1, "", "s") & " de oro a tu oferta!!", FontTypeNames.FONTTYPE_GUILD)

        ElseIf .SelectedItem > 0 Then
            If Val(txtAgregar.Text) > .amount(.SelectedItem) Then
                Call PrintCommerceMsg("¡No tienes esa cantidad!", FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub
            End If

            OfferSlot = CheckAvailableSlot(.SelectedItem, Val(txtAgregar.Text))

            ' Hay espacio o lugar donde sumarlo?
            If OfferSlot > 0 Then

                Call PrintCommerceMsg("¡Agregaste " & Val(txtAgregar.Text) & " " & .ItemName(.SelectedItem) & " a tu oferta!!", FontTypeNames.FONTTYPE_GUILD)

                ' Le aviso al otro de mi cambio de oferta
                Call WriteUserCommerceOffer(.SelectedItem, Val(txtAgregar.Text), OfferSlot)

                ' Actualizo el inventario general de comercio
                Call .ChangeSlotItemAmount(.SelectedItem, .amount(.SelectedItem) - Val(txtAgregar.Text))

                amount = InvOfferComUsu(0).amount(OfferSlot) + Val(txtAgregar.Text)

                ' Actualizo los inventarios
                If InvOfferComUsu(0).ObjIndex(OfferSlot) > 0 Then
                    ' Si ya esta el item, solo actualizo su cantidad en el invenatario
                    Call InvOfferComUsu(0).ChangeSlotItemAmount(OfferSlot, amount)
                Else
                    InvSlot = .SelectedItem
                    ' Si no agrego todo
                    Call InvOfferComUsu(0).SetItem(OfferSlot, .ObjIndex(InvSlot), _
                                                   amount, 0, .GrhIndex(InvSlot), .ObjType(InvSlot), _
                                                   .MaxHit(InvSlot), .MinHit(InvSlot), .MaxDef(InvSlot), .MinDef(InvSlot), _
                                                   .Valor(InvSlot), .ItemName(InvSlot))
                End If
            End If
        End If
    End With
End Sub

Private Sub ImgCancelar_Click()
    Call WriteUserCommerceEnd
End Sub

Private Sub imgConfirmar_Click()

    If Not Confirmar Then Exit Sub

    HabilitarConfirmar False
    imgAgregar.visible = False
    imgQuitar.visible = False
    txtAgregar.Enabled = False
    Label2.visible = True

    Call PrintCommerceMsg("¡Has confirmado tu oferta! Ya no puedes cambiarla.", FontTypeNames.FONTTYPE_CONSE)
    Call WriteUserCommerceConfirm

End Sub

Private Sub imgQuitar_Click()
    Dim amount As Long
    Dim InvComSlot As Byte

    ' No tiene seleccionado ningun item
    If InvOfferComUsu(0).SelectedItem = 0 Then
        Call PrintCommerceMsg("¡No tienes ningún ítem seleccionado!", FontTypeNames.FONTTYPE_FIGHT)
        Exit Sub
    End If

    ' Numero invalido
    If Not IsNumeric(txtAgregar.Text) Then Exit Sub

    ' Comparar con el inventario para distribuir los items
    If InvOfferComUsu(0).SelectedItem = FLAGORO Then

        amount = Val(txtAgregar.Text) * (-1)

        If Val(txtAgregar.Text) > OroOfrecido Then
            amount = OroOfrecido * (-1)
        End If

        If Val(txtAgregar.Text) <= 0 Then _
           Exit Sub

        OroActual = OroActual - amount
        OroOfrecido = OroOfrecido + amount

        ' No tiene sentido que se quiten 0 unidades
        If amount <> 0 Then
            ' Le aviso al otro de mi cambio de oferta
            Call WriteUserCommerceOffer(FLAGORO, amount, GOLD_OFFER_SLOT)

            ' Actualizo los inventarios
            lblOroCurrent.Caption = IIf(OroActual = 0, "0", format$(OroActual, "###,###,###"))
            lblOroOffered.Caption = IIf(OroOfrecido = 0, "0", format$(OroOfrecido, "###,###,###"))

            Call PrintCommerceMsg("¡¡Quitaste " & amount * (-1) & " moneda" & IIf(amount = 1, "", "s") & " de oro de tu oferta!!", FontTypeNames.FONTTYPE_GUILD)
        End If
    Else
        amount = IIf(Val(txtAgregar.Text) > InvOfferComUsu(0).amount(InvOfferComUsu(0).SelectedItem), _
                     InvOfferComUsu(0).amount(InvOfferComUsu(0).SelectedItem), Val(txtAgregar.Text))
        ' Estoy quitando, paso un valor negativo
        amount = amount * (-1)

        ' No tiene sentido que se quiten 0 unidades
        If amount <> 0 Then
            With InvOfferComUsu(0)

                Call PrintCommerceMsg("¡¡Quitaste " & amount * (-1) & " " & .ItemName(.SelectedItem) & " de tu oferta!!", FontTypeNames.FONTTYPE_GUILD)

                ' Le aviso al otro de mi cambio de oferta
                Call WriteUserCommerceOffer(0, amount, .SelectedItem)

                ' Actualizo el inventario general
                Call UpdateInvCom(.ObjIndex(.SelectedItem), Abs(amount))

                ' Actualizo el inventario de oferta
                If .amount(.SelectedItem) + amount = 0 Then
                    ' Borro el item
                    Call .SetItem(.SelectedItem, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "")
                Else
                    ' Le resto la cantidad deseada
                    Call .ChangeSlotItemAmount(.SelectedItem, .amount(.SelectedItem) + amount)
                End If
            End With
        End If
    End If

    If Not HasAnyItem(InvOfferComUsu(0)) Then        ' And Not HasAnyItem(InvOroComUsu(1)) Then
        HabilitarConfirmar (False)
    End If

End Sub

Private Sub imgRechazar_Click()

    If AceptarRechazar Then
        Call WriteUserCommerceReject
    End If

End Sub

Private Sub Form_Load()

' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "977.png", True)

    Call PrintCommerceMsg(" Una vez termines de formar tu oferta, debes presionar en ""Confirmar"", tras lo cual ya no podrás modificarla.", FontTypeNames.FONTTYPE_GUILDMSG)
    Call PrintCommerceMsg(" Luego que el otro usuario confirme su oferta, podrás aceptarla o rechazarla. Si la rechazas, se terminará el comercio.", FontTypeNames.FONTTYPE_GUILDMSG)
    Call PrintCommerceMsg(" Cuando ambos acepten la oferta del otro, se realizará el intercambio.", FontTypeNames.FONTTYPE_GUILDMSG)
    Call PrintCommerceMsg(" Si se intercambian más ítems de los que pueden entrar en tu inventario, es probable que caigan al suelo, así que presta mucha atencón a esto.", FontTypeNames.FONTTYPE_GUILDMSG)


    OroOfrecido = 0
    lblOroCurrent = IIf(OroActual = 0, "0", format$(OroActual, "###,###,###"))

End Sub

Private Sub Form_LostFocus()
    Me.SetFocus
End Sub

Private Sub picInvComercio_Click()
    lblOroCurrent.ForeColor = &H8000000F

End Sub

Private Sub txtAgregar_Change()
    If Val(txtAgregar.Text) < 1 Then txtAgregar.Text = "1"
    If Val(txtAgregar.Text) > 2000000000 Then txtAgregar.Text = "2000000000"
End Sub

Private Sub lblOroCurrent_Click()
    picInvOroProp_Click
    lblOroCurrent.ForeColor = vbRed

End Sub

Private Sub lblOroOffered_Click()
    picInvOroOfertaProp_Click
End Sub

Private Sub picInvOroOfertaProp_Click()
    InvOfferComUsu(0).SelectGold
End Sub

Private Sub picInvOroProp_Click()
    InvComUsu.SelectGold
    lblOroCurrent.ForeColor = vbYellow

End Sub

Private Sub SendTxt_Change()
    If Len(SendTxt.Text) > 160 Then
        sCommerceChat = "Soy un cheater, avisenle a un gm"
    Else
        Dim I As Long
        Dim tempstr As String
        Dim CharAscii As Integer
        For I = 1 To Len(SendTxt.Text)
            CharAscii = Asc(mid$(SendTxt.Text, I, 1))
            If CharAscii >= vbKeySpace And CharAscii <= 250 Then
                tempstr = tempstr & Chr$(CharAscii)
            End If
        Next I
        If tempstr <> SendTxt.Text Then
            SendTxt.Text = tempstr
        End If
        sCommerceChat = SendTxt.Text
    End If
End Sub

Private Sub SendTxt_KeyPress(KeyAscii As Integer)
    If Not (KeyAscii = vbKeyBack) And _
       Not (KeyAscii >= vbKeySpace And KeyAscii <= 250) Then _
       KeyAscii = 0
End Sub

Private Sub SendTxt_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then
        If LenB(sCommerceChat) <> 0 Then Call WriteCommerceChat(sCommerceChat)

        sCommerceChat = ""
        SendTxt.Text = ""
        KeyCode = 0
    End If
End Sub

Private Sub txtAgregar_KeyDown(KeyCode As Integer, Shift As Integer)
    If Not ((KeyCode >= 48 And KeyCode <= 57) Or KeyCode = vbKeyBack Or _
            KeyCode = vbKeyDelete Or (KeyCode >= 37 And KeyCode <= 40)) Then
        KeyCode = 0
    End If
End Sub

Private Sub txtAgregar_KeyPress(KeyAscii As Integer)
    If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = vbKeyBack Or _
            KeyAscii = vbKeyDelete Or (KeyAscii >= 37 And KeyAscii <= 40)) Then
        KeyAscii = 0
    End If
End Sub

Private Function CheckAvailableSlot(ByVal InvSlot As Byte, ByVal amount As Long) As Byte
    Dim Slot As Long
    For Slot = 1 To INV_OFFER_SLOTS
        If InvComUsu.ObjIndex(InvSlot) = InvOfferComUsu(0).ObjIndex(Slot) Then
            If InvOfferComUsu(0).amount(Slot) + amount <= MAX_INVENTORY_OBJS Then
                CheckAvailableSlot = Slot
                Exit Function
            End If
        End If
    Next Slot
    For Slot = 1 To INV_OFFER_SLOTS
        If InvOfferComUsu(0).ObjIndex(Slot) = 0 Then
            ' Esta vacio, lo dejo aca
            CheckAvailableSlot = Slot
            Exit Function
        End If
    Next Slot
    Exit Function
End Function

Public Sub UpdateInvCom(ByVal ObjIndex As Integer, ByVal amount As Long)
    Dim Slot As Byte
    Dim RemainingAmount As Long
    Dim DifAmount As Long
    RemainingAmount = amount
    For Slot = 1 To MAX_INVENTORY_SLOTS

        If InvComUsu.ObjIndex(Slot) = ObjIndex Then
            DifAmount = Inventario.amount(Slot) - InvComUsu.amount(Slot)
            If DifAmount > 0 Then
                If RemainingAmount > DifAmount Then
                    RemainingAmount = RemainingAmount - DifAmount
                    Call InvComUsu.ChangeSlotItemAmount(Slot, Inventario.amount(Slot))
                Else
                    Call InvComUsu.ChangeSlotItemAmount(Slot, InvComUsu.amount(Slot) + RemainingAmount)
                    Exit Sub
                End If
            End If
        End If
    Next Slot
End Sub

Public Sub PrintCommerceMsg(ByRef msg As String, ByVal FontIndex As Integer)
    With FontTypes(FontIndex)
        Call AddtoRichTextBox(frmComerciarUsu.CommerceConsole, msg, .red, .green, .blue, .bold, .italic)
    End With
End Sub

Public Function HasAnyItem(ByRef Inventory As clsGraphInv) As Boolean
    Dim Slot As Long
    For Slot = 1 To Inventory.MaxObjs
        If Inventory.amount(Slot) > 0 Then HasAnyItem = True: Exit Function
    Next Slot
End Function

Public Sub HabilitarConfirmar(ByVal Habilitar As Boolean)
    Confirmar = Habilitar

    If AceptarRechazar Then
        'dibujarlo mas fuerte
    Else
        'dibujarlo gris
    End If

End Sub

Public Sub HabilitarAceptarRechazar(ByVal Habilitar As Boolean)
    AceptarRechazar = Habilitar

    If AceptarRechazar Then
        'dibujarlo mas fuerte
    Else
        'dibujarlo gris
    End If

End Sub
