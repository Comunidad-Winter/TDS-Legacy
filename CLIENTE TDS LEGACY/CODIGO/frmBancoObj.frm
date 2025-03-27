VERSION 5.00
Begin VB.Form frmBancoObj 
   Appearance      =   0  'Flat
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Banco"
   ClientHeight    =   5670
   ClientLeft      =   3765
   ClientTop       =   0
   ClientWidth     =   6165
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   378
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   411
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Timer aInv 
      Interval        =   100
      Left            =   5400
      Top             =   4560
   End
   Begin VB.TextBox cantidad 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000004&
      Height          =   285
      Left            =   5520
      TabIndex        =   10
      Text            =   "1"
      Top             =   3000
      Width           =   525
   End
   Begin VB.PictureBox picUser 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
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
      Height          =   2415
      Left            =   1800
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   192
      TabIndex        =   9
      Top             =   2880
      Width           =   2910
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      FillStyle       =   0  'Solid
      Height          =   600
      Left            =   11640
      ScaleHeight     =   540
      ScaleWidth      =   495
      TabIndex        =   2
      Top             =   1080
      Width           =   555
   End
   Begin VB.ListBox List1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3960
      Index           =   1
      Left            =   12120
      TabIndex        =   1
      Top             =   1800
      Width           =   2490
   End
   Begin VB.ListBox List1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3960
      Index           =   0
      Left            =   9600
      TabIndex        =   0
      Top             =   1800
      Width           =   2490
   End
   Begin VB.PictureBox picBoveda 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      FillColor       =   &H00000040&
      ForeColor       =   &H80000008&
      Height          =   2415
      Left            =   225
      ScaleHeight     =   159
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   256
      TabIndex        =   8
      Top             =   300
      Width           =   3870
   End
   Begin VB.Label Bovedalbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   3
      Left            =   4080
      TabIndex        =   18
      Top             =   2160
      Width           =   1500
   End
   Begin VB.Label Bovedalbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   2
      Left            =   4080
      TabIndex        =   17
      Top             =   1560
      Width           =   1500
   End
   Begin VB.Label Bovedalbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   1
      Left            =   4080
      TabIndex        =   16
      Top             =   1080
      Width           =   1620
   End
   Begin VB.Label Bovedalbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Height          =   225
      Index           =   0
      Left            =   4080
      TabIndex        =   15
      Top             =   600
      Width           =   1620
   End
   Begin VB.Label Inventariolbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   3
      Left            =   150
      TabIndex        =   14
      Top             =   5040
      Width           =   1500
   End
   Begin VB.Label Inventariolbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   2
      Left            =   150
      TabIndex        =   13
      Top             =   4560
      Width           =   1500
   End
   Begin VB.Label Inventariolbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   1
      Left            =   150
      TabIndex        =   12
      Top             =   4080
      Width           =   1500
   End
   Begin VB.Label Inventariolbl 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
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
      Index           =   0
      Left            =   105
      TabIndex        =   11
      Top             =   3600
      Width           =   1770
   End
   Begin VB.Image Command2 
      Height          =   480
      Left            =   4920
      Top             =   5070
      Width           =   1110
   End
   Begin VB.Image CmdMoverBov 
      Height          =   375
      Index           =   1
      Left            =   10080
      Top             =   960
      Width           =   570
   End
   Begin VB.Image CmdMoverBov 
      Height          =   375
      Index           =   0
      Left            =   10080
      Top             =   1320
      Width           =   570
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cantidad"
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
      Left            =   8310
      TabIndex        =   7
      Top             =   150
      Width           =   645
   End
   Begin VB.Image Image1 
      Height          =   735
      Index           =   1
      Left            =   5520
      MousePointer    =   99  'Custom
      Tag             =   "1"
      Top             =   3300
      Width           =   435
   End
   Begin VB.Image Image1 
      Height          =   765
      Index           =   0
      Left            =   5535
      MousePointer    =   99  'Custom
      Tag             =   "1"
      Top             =   2205
      Width           =   435
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   3
      Left            =   8310
      TabIndex        =   6
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
      Left            =   8550
      TabIndex        =   5
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
      Left            =   8490
      TabIndex        =   4
      Top             =   1170
      Width           =   45
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   0
      Left            =   7245
      TabIndex        =   3
      Top             =   450
      Width           =   45
   End
End
Attribute VB_Name = "frmBancoObj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public LasActionBuy As Boolean
Public LastIndex1 As Integer
Public LastIndex2 As Integer
Public NoPuedeMover As Boolean
Private last_i As Long
Private drag_modo As Byte

Private Sub cantidad_Change()

    If Val(cantidad.Text) < 1 Then
        cantidad.Text = 1
    End If

    If Val(cantidad.Text) > MAX_INVENTORY_OBJS Then
        cantidad.Text = 1
    End If

End Sub

Private Sub cantidad_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) Then
        If (KeyAscii <> 6) And (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
    End If
End Sub

Private Sub CmdMoverBov_Click(index As Integer)
    If List1(0).ListIndex = -1 Then Exit Sub

    If NoPuedeMover Then Exit Sub

    Select Case index
    Case 1        'subir
        If List1(0).ListIndex <= 0 Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("No puedes mover el objeto en esa dirección.", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If
        LastIndex1 = List1(0).ListIndex - 1
    Case 0        'bajar
        If List1(0).ListIndex >= List1(0).ListCount - 1 Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("No puedes mover el objeto en esa dirección.", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If
        LastIndex1 = List1(0).ListIndex + 1
    End Select

    NoPuedeMover = True
    LasActionBuy = True
    LastIndex2 = List1(1).ListIndex
    Call WriteMoveBank(index, List1(0).ListIndex + 1)
End Sub

Private Sub Command2_Click()
    On Error GoTo Command2_Click_Err

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    Call WriteBankEnd

    NoPuedeMover = False

    Exit Sub

Command2_Click_Err:
    Call RegistrarError(Err.Number, Err.Description, "frmBancoObj.Command2_Click", Erl)
    Resume Next

End Sub

Private Sub Command2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Command2.Picture = LoadPicture(App.Path & "\Graficos\Button\Selected\bOkBanco.jpg")
End Sub

Private Sub Form_Load()

    Call forms_load_pic(Me, "981.bmp", False)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error GoTo Form_Unload_Err

    Call WriteBankEnd

    Exit Sub

Form_Unload_Err:
    Call RegistrarError(Err.Number, Err.Description, "frmBancoObj.Form_Unload", Erl)
    Resume Next

End Sub

Private Sub Image1_Click(index As Integer)

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    If Not IsNumeric(cantidad.Text) Then Exit Sub

    Select Case index
    Case 1
        frmBancoObj.List1(0).SetFocus
        LastIndex1 = InvBanco(0).SelectedItem
        LasActionBuy = True
        Call WriteBankExtractItem(InvBanco(0).SelectedItem, cantidad.Text)

    Case 0
        LastIndex2 = InvBanco(1).SelectedItem
        LasActionBuy = False
        Call WriteBankDeposit(InvBanco(1).SelectedItem, cantidad.Text)
    End Select

End Sub

Private Sub picBoveda_Click()

    With InvBanco(0)
        If .SelectedItem <= 0 Then Exit Sub
        Bovedalbl(0) = .ItemName(.SelectedItem)
        Bovedalbl(1) = .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem)
        Bovedalbl(2) = .MaxHit(.SelectedItem)
        Bovedalbl(3) = .MinHit(.SelectedItem)
    End With
End Sub

Private Sub picBoveda_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim MouseDownSelectedItem As Integer
    MouseDownSelectedItem = InvBanco(0).SelectedItem

    If X > 0 And X < picBoveda.ScaleWidth And Y > 0 And Y < picBoveda.ScaleHeight Then

        If drag_modo <> 0 Then
            Dim InvSelectedItem As Integer
            InvSelectedItem = InvBanco(0).ClickItem(CInt(X), CInt(Y))

            If InvSelectedItem > 0 And InvSelectedItem < MAX_BANCOINVENTORY_SLOTS + 1 Then
                If (InvSelectedItem <> MouseDownSelectedItem) And (MouseDownSelectedItem <> 0) Then
                    If UserEstado < 1 Then
                        Call WriteDragBov(MouseDownSelectedItem, InvSelectedItem)
                    End If
                End If
            End If

            drag_modo = 0
            Me.MousePointer = vbDefault

        End If

    Else

        If MouseDownSelectedItem > 0 And MouseDownSelectedItem < MAX_BANCOINVENTORY_SLOTS + 1 Then

            Dim amount As Long
            amount = InvBanco(0).amount(MouseDownSelectedItem)

            If amount < 1 Then Exit Sub

            If amount < Val(cantidad.Text) Then
                Call WriteBankExtractItem(MouseDownSelectedItem, amount)
            Else
                Call WriteBankExtractItem(MouseDownSelectedItem, Val(cantidad.Text))
            End If

        End If

    End If

    picBoveda.MousePointer = vbDefault
    Me.MousePointer = vbDefault

End Sub

Private Sub picUser_Click()
    With InvBanco(1)
        Inventariolbl(0) = .ItemName(.SelectedItem)
        Inventariolbl(1) = .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem)
        Inventariolbl(2) = .MaxHit(.SelectedItem)
        Inventariolbl(3) = .MinHit(.SelectedItem)
    End With
End Sub


Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    End If
    'End If
    Command2.Picture = LoadPicture("")
    Image1(0).Picture = LoadPicture("")
    Image1(1).Picture = LoadPicture("")
End Sub

Private Sub picBoveda_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo = 1 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0

        WriteBankDeposit InvBanco(1).SelectedItem, Val(cantidad.Text)
    End If
    If drag_modo = 2 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    End If
End Sub


Private Sub picUser_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo = 2 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        'WriteBankExtractItem InvBanco(0).SelectedItem, Val(cantidad.Text)
    End If
    If drag_modo = 1 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
        WriteDragInventory last_i, InvBanco(1).SelectedItem
    End If
End Sub

Private Sub picBoveda_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim i As Integer

    If InvBanco(0).SelectedItem < 1 Then Exit Sub
    If InvBanco(0).SelectedItem > InvBanco(0).MaxItems Then Exit Sub

    With InvBanco(0)
        Bovedalbl(0) = .ItemName(.SelectedItem)
        Bovedalbl(1) = .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem)
        Bovedalbl(2) = .MaxHit(.SelectedItem)
        Bovedalbl(3) = .MinHit(.SelectedItem)
    End With

    If drag_modo <> 0 Then Exit Sub

    If Button = vbRightButton Then

        If InvBanco(0).GrhIndex(InvBanco(0).SelectedItem) > 0 Then

            i = GrhData(InvBanco(0).GrhIndex(InvBanco(0).SelectedItem)).FileNum
            last_i = InvBanco(0).SelectedItem
            drag_modo = 2        '1 = de inventario a boveda

            Dim Buffer As Long
            Dim bmpInfo As BITMAPINFO
            Dim BufferBMP As Long
            Dim Data() As Byte

            'get Bitmap
            Call Get_Bitmap(App.Path & "\GRAFICOS\", CStr(LCase$(i) & ".bmp"), bmpInfo, Data)

            BufferBMP = CreateCompatibleDC(picBoveda.hdc)
            Buffer = CreateCompatibleBitmap(picBoveda.hdc, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight)
            SelectObject BufferBMP, Buffer

            Call SetDIBitsToDevice(BufferBMP, 0, 0, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight, 0, 0, 0, bmpInfo.bmiHeader.biHeight, Data(0), bmpInfo, DIB_RGB_COLORS)

            Set Me.MouseIcon = GetIcon(BufferBMP, 0, 0, Halftone, True, vbBlack)
            Me.MousePointer = vbCustom

        End If

    End If
End Sub

Private Sub picUser_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    Dim i As Integer

    If InvBanco(1).SelectedItem < 1 Then Exit Sub
    If InvBanco(1).SelectedItem > InvBanco(1).MaxItems Then Exit Sub

    With InvBanco(1)
        Inventariolbl(0) = .ItemName(.SelectedItem)
        Inventariolbl(1) = .MinDef(.SelectedItem) & "/" & .MaxDef(.SelectedItem)
        Inventariolbl(2) = .MaxHit(.SelectedItem)
        Inventariolbl(3) = .MinHit(.SelectedItem)
    End With

    If drag_modo <> 0 Then Exit Sub

    If Button = vbRightButton Then

        If InvBanco(1).GrhIndex(InvBanco(1).SelectedItem) > 0 Then
            i = GrhData(InvBanco(1).GrhIndex(InvBanco(1).SelectedItem)).FileNum
            last_i = InvBanco(1).SelectedItem
            drag_modo = 1        '1 = de inventario a boveda

            Dim Buffer As Long
            Dim bmpInfo As BITMAPINFO
            Dim BufferBMP As Long
            Dim Data() As Byte

            'get Bitmap
            Call Get_Bitmap(App.Path & "\GRAFICOS\", CStr(LCase$(i) & ".bmp"), bmpInfo, Data)

            BufferBMP = CreateCompatibleDC(picUser.hdc)
            Buffer = CreateCompatibleBitmap(picUser.hdc, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight)
            SelectObject BufferBMP, Buffer

            Call SetDIBitsToDevice(BufferBMP, 0, 0, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight, 0, 0, 0, bmpInfo.bmiHeader.biHeight, Data(0), bmpInfo, DIB_RGB_COLORS)

            Set Me.MouseIcon = GetIcon(BufferBMP, 0, 0, Halftone, True, vbBlack)
            Me.MousePointer = vbCustom
        End If

    End If
End Sub

