VERSION 5.00
Begin VB.Form frmComerciar 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   3570
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6660
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   238
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   444
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox picComerciar 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      FillColor       =   &H00000040&
      ForeColor       =   &H80000008&
      Height          =   2535
      Left            =   315
      ScaleHeight     =   169
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   194
      TabIndex        =   9
      Top             =   360
      Width           =   2910
   End
   Begin VB.PictureBox picUsuario 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      FillColor       =   &H00000040&
      ForeColor       =   &H80000008&
      Height          =   2535
      Left            =   3435
      ScaleHeight     =   169
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   194
      TabIndex        =   8
      Top             =   375
      Width           =   2910
   End
   Begin VB.TextBox cantidad 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   2880
      TabIndex        =   5
      Text            =   "1"
      Top             =   3120
      Width           =   720
   End
   Begin VB.Image Image1 
      Height          =   420
      Index           =   2
      Left            =   5670
      Top             =   3030
      Width           =   735
   End
   Begin VB.Label lblData 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Haz click en un item para mas información."
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
      Height          =   195
      Left            =   360
      TabIndex        =   7
      Top             =   75
      Width           =   3675
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cantidad:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   195
      Left            =   2880
      TabIndex        =   6
      Top             =   2925
      Width           =   705
   End
   Begin VB.Image Image1 
      Height          =   420
      Index           =   1
      Left            =   4245
      MouseIcon       =   "frmComerciar.frx":0000
      Tag             =   "1"
      Top             =   3030
      Width           =   1170
   End
   Begin VB.Image Image1 
      Height          =   420
      Index           =   0
      Left            =   1125
      MouseIcon       =   "frmComerciar.frx":0152
      Tag             =   "1"
      Top             =   3030
      Width           =   1170
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   3
      Left            =   3990
      TabIndex        =   4
      Top             =   975
      Visible         =   0   'False
      Width           =   45
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   4
      Left            =   3990
      TabIndex        =   3
      Top             =   630
      Visible         =   0   'False
      Width           =   45
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   2
      Left            =   2730
      TabIndex        =   2
      Top             =   1170
      Width           =   45
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   1
      Left            =   1800
      TabIndex        =   1
      Top             =   750
      Width           =   45
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   0
      Left            =   1125
      TabIndex        =   0
      Top             =   450
      Width           =   45
   End
End
Attribute VB_Name = "frmComerciar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private objdrag As Byte
Private drag_modo As Byte
Private last_i As Long
Private sell As Boolean


Private Sub cantidad_Change()
    If Val(cantidad.Text) < 1 Then
        cantidad.Text = 1
    End If

    If Val(cantidad.Text) > MAX_INVENTORY_OBJS Then
        cantidad.Text = 1
    End If
    Dim v As Double

    If Not sell Then
        With InvComNpc
            If .SelectedItem <> 0 Then

                If sell Then
                    If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                        v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
                    Else
                        v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
                    End If
                    v = v * Val(cantidad.Text)

                Else
                    If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                        v = Int(.Valor(.SelectedItem)) + 1
                    Else
                        v = Int(.Valor(.SelectedItem))
                    End If
                    v = v * Val(cantidad.Text)
                End If

                Select Case .ObjType(.SelectedItem)

                Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                    lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
                Case eObjType.otWeapon
                    lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
                Case eObjType.otAnillo, eObjType.otAnillo2
                    lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinDefMagic(.SelectedItem) & "/" & .MaxDefMagic(.SelectedItem) & " Valor: " & v
                Case Else
                    lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
                End Select
            End If
        End With
    Else
        With InvComUsu
            If .SelectedItem <> 0 Then

                If sell Then
                    If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                        v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
                    Else
                        v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
                    End If
                    v = v * Val(cantidad.Text)

                Else
                    If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                        v = Int(.Valor(.SelectedItem)) + 1
                    Else
                        v = Int(.Valor(.SelectedItem))
                    End If
                    v = v * Val(cantidad.Text)
                End If

                Select Case .ObjType(.SelectedItem)

                Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                    lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
                Case eObjType.otWeapon
                    lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
                Case eObjType.otAnillo, eObjType.otAnillo2
                    lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinDefMagic(.SelectedItem) & "/" & .MaxDefMagic(.SelectedItem) & " Valor: " & v
                Case Else
                    lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
                End Select
            End If
        End With
    End If
End Sub

Private Sub cantidad_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) Then
        If (KeyAscii <> 6) And (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
    End If
End Sub

Private Sub Form_Load()
'Cargamos la interfase
    Call forms_load_pic(Me, "968.bmp", False)


End Sub

''
' Calculates the selling price of an item (The price that a merchant will sell you the item)
'
' @param objValue Specifies value of the item.
' @param objAmount Specifies amount of items that you want to buy
' @return   The price of the item.

Private Function CalculateSellPrice(ByRef objValue As Single, ByVal objAmount As Long) As Double
'*************************************************
'Author: Marco Vanotti (MarKoxX)
'Last modified: 19/08/2008
'Last modify by: Franco Zeoli (Noich)
'*************************************************
    On Error GoTo Error
    'We get a Single value from the server, when vb uses it, by approaching, it can diff with the server value, so we do (Value * 100000) and get the entire part, to discard the unwanted floating values.
    CalculateSellPrice = Fix(Fix(objValue / 3) * cantidad)        'CCur(objValue * 1000000) / 1000000 * objAmount + 0.5

    Exit Function
Error:
    'MsgBox Err.Description, vbExclamation, "Error: " & Err.number
    CalculateSellPrice = objValue
End Function
''
' Calculates the buying price of an item (The price that a merchant will buy you the item)
'
' @param objValue Specifies value of the item.
' @param objAmount Specifies amount of items that you want to buy
' @return   The price of the item.
Private Function CalculateBuyPrice(ByRef objValue As Single, ByVal objAmount As Long) As Long
'*************************************************
'Author: Marco Vanotti (MarKoxX)
'Last modified: 19/08/2008
'Last modify by: Franco Zeoli (Noich)
'*************************************************
    On Error GoTo Error
    'We get a Single value from the server, when vb uses it, by approaching, it can diff with the server value, so we do (Value * 100000) and get the entire part, to discard the unwanted floating values.
    CalculateBuyPrice = Fix(CCur(objValue * 1000000) / 1000000 * objAmount)

    Exit Function
Error:
    MsgBox Err.Description, vbExclamation, "Error: " & Err.Number
    CalculateBuyPrice = 1
End Function

Private Sub Image1_Click(index As Integer)

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    If Not IsNumeric(cantidad.Text) Or cantidad.Text = 0 Then Exit Sub

    Select Case index
    Case 0
        If Not InvComNpc.SelectedItem <> 0 Then Exit Sub

        If UserGLD >= CalculateSellPrice(NPCInventory(InvComNpc.SelectedItem).Valor, Val(cantidad.Text)) Then
            Call WriteCommerceBuy(InvComNpc.SelectedItem, cantidad.Text, 0)
        Else
            AddtoRichTextBox frmMain.RecTxt, "No tenés suficiente oro.", 2, 51, 223, 1, 1
            Exit Sub
        End If

    Case 1
        If Not InvComUsu.SelectedItem <> 0 Then Exit Sub
        Call WriteCommerceSell(InvComUsu.SelectedItem, cantidad.Text)

    Case 2
        Call WriteCommerceEnd

    End Select

End Sub

Private Sub picComerciar_Click()
    With InvComNpc
        If .SelectedItem <> 0 Then
            Dim v As Double

            sell = False

            If sell Then
                If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                    v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
                Else
                    v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
                End If
                v = v * Val(cantidad.Text)

            Else
                If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                    v = Int(.Valor(.SelectedItem)) + 1
                Else
                    v = Int(.Valor(.SelectedItem))
                End If
                v = v * Val(cantidad.Text)
            End If

            Select Case .ObjType(.SelectedItem)

            Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
            Case eObjType.otWeapon
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
            Case eObjType.otAnillo, eObjType.otAnillo2
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinDefMagic(.SelectedItem) & "/" & .MaxDefMagic(.SelectedItem) & " Valor: " & v
            Case Else
                lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
            End Select

        End If

    End With
End Sub

Private Sub picUsuario_Click()

    With InvComUsu

        If .SelectedItem <> 0 Then

            sell = True

            Dim v As Double
            If sell Then
                If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                    v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
                Else
                    v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
                End If
                'v = v * Val(cantidad.Text)

            Else
                If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                    v = Int(.Valor(.SelectedItem)) + 1
                Else
                    v = Int(.Valor(.SelectedItem))
                End If
                v = v * Val(cantidad.Text)
            End If

            Select Case .ObjType(.SelectedItem)

            Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
            Case eObjType.otWeapon
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
            Case eObjType.otAnillo, eObjType.otAnillo2
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinDefMagic(.SelectedItem) & "/" & .MaxDefMagic(.SelectedItem) & " Valor: " & v
            Case Else
                lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
            End Select
        End If

    End With
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        If sell Then
            Call WriteCommerceSell(InvComUsu.SelectedItem, cantidad.Text)
        Else
            Call WriteCommerceBuy(InvComNpc.SelectedItem, cantidad.Text, 0)
        End If

    End If

End Sub

Private Sub picComerciar_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo = 2 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        Call WriteCommerceSell(InvComUsu.SelectedItem, cantidad.Text)
    End If

    If drag_modo = 1 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    End If

End Sub


Private Sub picUsuario_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If drag_modo = 1 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        Call WriteCommerceBuy(InvComNpc.SelectedItem, cantidad.Text, 0)

    End If
    If drag_modo = 2 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        WriteDragInventory objdrag, InvComUsu.ClickItem(X, Y)
    End If
End Sub

Private Sub picUsuario_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim i As Integer

    If InvComUsu.SelectedItem < 1 Then Exit Sub
    If InvComUsu.SelectedItem > InvComUsu.MaxItems Then Exit Sub

    With InvComUsu

        Dim v As Double
        sell = True

        If sell Then
            If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
            Else
                v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
            End If


        Else
            If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                v = Int(.Valor(.SelectedItem)) + 1
            Else
                v = Int(.Valor(.SelectedItem))
            End If
            v = v * Val(cantidad.Text)
        End If

        'If .SelectedItem <> 0 Then _
         lblData.Caption = .ItemName(.SelectedItem) & " Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & CalculateSellPrice(.Valor(.SelectedItem), 1)
        If .SelectedItem <> 0 Then
            Select Case .ObjType(.SelectedItem)

            Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
            Case eObjType.otWeapon
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
            Case eObjType.otAnillo, eObjType.otAnillo2
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinDefMagic(.SelectedItem) & "/" & .MaxDefMagic(.SelectedItem) & " Valor: " & v
            Case Else
                lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
            End Select



        End If
    End With

    If drag_modo <> 0 Then Exit Sub

    If Button = vbRightButton Then

        If InvComUsu.GrhIndex(InvComUsu.SelectedItem) > 0 Then
            objdrag = InvComUsu.SelectedItem
            last_i = InvComUsu.SelectedItem
            drag_modo = 2        '1 = de npc a inventario
            i = GrhData(InvComUsu.GrhIndex(InvComUsu.SelectedItem)).FileNum

            Dim Buffer As Long
            Dim bmpInfo As BITMAPINFO
            Dim BufferBMP As Long
            Dim Data() As Byte

            'get Bitmap
            Call Get_Bitmap(App.Path & "\GRAFICOS\", CStr(LCase$(i) & ".bmp"), bmpInfo, Data)

            BufferBMP = CreateCompatibleDC(picUsuario.hdc)
            Buffer = CreateCompatibleBitmap(picUsuario.hdc, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight)
            SelectObject BufferBMP, Buffer

            Call SetDIBitsToDevice(BufferBMP, 0, 0, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight, 0, 0, 0, bmpInfo.bmiHeader.biHeight, Data(0), bmpInfo, DIB_RGB_COLORS)

            Set Me.MouseIcon = GetIcon(BufferBMP, 0, 0, Halftone, True, vbBlack)
            Me.MousePointer = vbCustom

        End If
    End If
End Sub

Private Sub picComerciar_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim i As Integer

    If InvComNpc.SelectedItem < 1 Then Exit Sub
    If InvComNpc.SelectedItem > InvComNpc.MaxItems Then Exit Sub

    With InvComNpc

        Dim v As Double
        sell = False

        If sell Then
            If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                v = CalculateSellPrice(Int(.Valor(.SelectedItem)) + 1, Val(cantidad.Text))
            Else
                v = CalculateSellPrice(Int(.Valor(.SelectedItem)), Val(cantidad.Text))
            End If
            v = v * Val(cantidad.Text)

        Else
            If Int(.Valor(.SelectedItem)) <> .Valor(.SelectedItem) Then
                v = Int(.Valor(.SelectedItem)) + 1
            Else
                v = Int(.Valor(.SelectedItem))
            End If
            v = v * Val(cantidad.Text)
        End If

        If .SelectedItem <> 0 Then

            Select Case .ObjType(.SelectedItem)

            Case eObjType.otArmadura, eObjType.otescudo, eObjType.otcasco, eObjType.otBarcos
                lblData.Caption = .ItemName(.SelectedItem) & " - Def: " & .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem) & " Valor: " & v
            Case eObjType.otWeapon
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
            Case eObjType.otAnillo, eObjType.otAnillo2
                lblData.Caption = .ItemName(.SelectedItem) & " - Daño: " & .MinHit(.SelectedItem) & "/" & .MaxHit(.SelectedItem) & " Valor: " & v
            Case Else
                lblData.Caption = .ItemName(.SelectedItem) & " - Valor: " & v
            End Select

        End If

    End With

    If drag_modo <> 0 Then Exit Sub

    If Button = vbRightButton Then

        If (InvComNpc.GrhIndex(InvComNpc.SelectedItem) > 0) Then
            last_i = InvComNpc.SelectedItem
            drag_modo = 1
            i = GrhData(InvComNpc.GrhIndex(InvComNpc.SelectedItem)).FileNum

            Dim Buffer As Long
            Dim bmpInfo As BITMAPINFO
            Dim BufferBMP As Long
            Dim Data() As Byte

            'get Bitmap
            Call Get_Bitmap(App.Path & "\GRAFICOS\", CStr(LCase$(i) & ".bmp"), bmpInfo, Data)

            BufferBMP = CreateCompatibleDC(picComerciar.hdc)
            Buffer = CreateCompatibleBitmap(picComerciar.hdc, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight)
            SelectObject BufferBMP, Buffer

            Call SetDIBitsToDevice(BufferBMP, 0, 0, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight, 0, 0, 0, bmpInfo.bmiHeader.biHeight, Data(0), bmpInfo, DIB_RGB_COLORS)

            Set Me.MouseIcon = GetIcon(BufferBMP, 0, 0, Halftone, True, vbBlack)
            Me.MousePointer = vbCustom
        End If

    End If

End Sub

