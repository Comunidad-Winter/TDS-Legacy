VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmOldPersonaje 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Argentum"
   ClientHeight    =   3615
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7260
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   -1  'True
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   241
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   484
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Timer Timer1 
      Interval        =   500
      Left            =   480
      Top             =   1560
   End
   Begin RichTextLib.RichTextBox NameTxt 
      Height          =   405
      Left            =   3195
      TabIndex        =   1
      Top             =   900
      Width           =   3105
      _ExtentX        =   5477
      _ExtentY        =   714
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      HideSelection   =   0   'False
      MultiLine       =   0   'False
      MaxLength       =   16
      Appearance      =   0
      OLEDragMode     =   0
      OLEDropMode     =   0
      TextRTF         =   $"frmOldPersonaje.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox PasswordTxt 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "/"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   3082
         SubFormatType   =   0
      EndProperty
      Height          =   405
      Left            =   3195
      TabIndex        =   2
      Top             =   1635
      Width           =   3105
      _ExtentX        =   5477
      _ExtentY        =   714
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      HideSelection   =   0   'False
      MultiLine       =   0   'False
      DisableNoScroll =   -1  'True
      MaxLength       =   30
      Appearance      =   0
      OLEDragMode     =   0
      OLEDropMode     =   0
      TextRTF         =   $"frmOldPersonaje.frx":007B
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Aguarde..."
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
      Left            =   3000
      TabIndex        =   0
      Top             =   2400
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.Image imgVolver 
      Height          =   840
      Left            =   705
      Top             =   2445
      Width           =   2745
   End
   Begin VB.Image imgAceptar 
      Height          =   765
      Left            =   3525
      Top             =   2535
      Width           =   2640
   End
   Begin VB.Label Gpassword 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "X"
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
      Left            =   4920
      TabIndex        =   4
      Top             =   2040
      Width           =   150
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Recordar Clave"
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
      Left            =   5160
      TabIndex        =   3
      Top             =   2040
      Width           =   1335
   End
End
Attribute VB_Name = "frmOldPersonaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public LastPressed As clsGraphicalButton
Private cBotonAceptar As clsGraphicalButton
Private cBotonVolver As clsGraphicalButton
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Function SetLayeredWindowAttributes Lib "user32" (ByVal hwnd As Long, ByVal crKey As Long, ByVal bAlpha As Byte, ByVal dwFlags As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long

Private Sub Form_Activate()

'Call SetWindowLong(NameTxt.hWnd, GWL_EXSTYLE, WS_EX_TRANSPARENT)
'Call SetWindowLong(PasswordTxt.hWnd, GWL_EXSTYLE, WS_EX_TRANSPARENT)

    Dim res As Long
    res = GetWindowLong(NameTxt.hwnd, GWL_EXSTYLE)
    res = res Or WS_EX_LAYERED
    SetWindowLong NameTxt.hwnd, GWL_EXSTYLE, res
    SetLayeredWindowAttributes NameTxt.hwnd, 0, 0, &H2
    SetLayeredWindowAttributes PasswordTxt.hwnd, 0, 0, &H2

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
    OldPersonajeVisible = True
End Sub

Private Sub Form_GotFocus()

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    If frmMensaje.visible Then Exit Sub
    'Aceptar
    If KeyAscii = vbKeyReturn Then
        If PanelQuitVisible Then Exit Sub

        If frmMensaje.visible Then Exit Sub

        LoggedByReturn = True
        KeyAscii = 0
        LastPanel = eVentanas.vInventario
        Conectarse


        Exit Sub
    End If

    If KeyAscii = 27 Then
        IniciarCaida 0
        Unload Me
        frmConnect.SetFocus
        KeyAscii = 0
    End If

End Sub

Private Sub Form_Load()

'If frmCrearPersonaje.Visible Then Exit Sub

    Set cBotonAceptar = New clsGraphicalButton
    Set cBotonVolver = New clsGraphicalButton
    OldPersonajeVisible = True

    Set LastPressed = New clsGraphicalButton
    Dim file1 As String
    Dim file2 As String

    file1 = Get_FileFrom(gui, "992.bmp")
    file2 = Get_FileFrom(gui, "993.bmp")


    Call cBotonAceptar.Initialize(imgAceptar, "", _
                                  file1, _
                                  file2, Me)
    Delete_File file1
    Delete_File file2

    file1 = Get_FileFrom(gui, "991.bmp")
    file2 = Get_FileFrom(gui, "990.bmp")

    Call cBotonVolver.Initialize(imgVolver, "", _
                                 file1, _
                                 file2, Me)

    Delete_File file1
    Delete_File file2

    Top = (Screen.Height - Height) / 2



    'If tSetup.NoFullScreen Then
    '    file1 = Get_FileFrom(graphics, "12174.bmp")
    '    Left = frmConnect.Left    'Pantalla chica = al costado pero al medio
    '    Me.Picture = LoadPicture(file1)
    'Else
    'Left = ((Screen.Width - Width) / 2) + 100    'Pantalla completa = al medio
    'Top = ((Screen.Height - Height) / 2) + 250
    'file1 = Get_FileFrom(graphics, "12174.png")
    'Me.Picture = LoadPicture(file1)
    Call forms_load_pic(Me, "12174.png", True)
    MakeFormTransparent Me, vbRed

    'End If

    'Delete_File file1

    resetGuiData

    Call SetWindowLong(NameTxt.hwnd, GWL_EXSTYLE, WS_EX_TRANSPARENT)
    Call SetWindowLong(PasswordTxt.hwnd, GWL_EXSTYLE, WS_EX_TRANSPARENT)

    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    PasswordTxt.SelColor = NameTxt.SelColor

    Gpassword.Caption = "X"
    GuardarContra = True

End Sub

Private Sub Form_LostFocus()

    Dim res As Long
    res = GetWindowLong(NameTxt.hwnd, GWL_EXSTYLE)
    res = res Or WS_EX_LAYERED
    SetWindowLong NameTxt.hwnd, GWL_EXSTYLE, res
    SetLayeredWindowAttributes NameTxt.hwnd, 0, 0, &H2
    SetLayeredWindowAttributes PasswordTxt.hwnd, 0, 0, &H2


    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    LastPressed.ToggleToNormal
End Sub

Private Sub Form_Terminate()
    OldPersonajeVisible = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    OldPersonajeVisible = False
End Sub

Private Sub Gpassword_Click()

' if activé then
    If frmMensaje.visible Then Exit Sub

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    If Gpassword.Caption = "X" Then
        Gpassword.Caption = ""
        GuardarContra = False
    Else
        Gpassword.Caption = "X"
        GuardarContra = True
    End If

End Sub

Private Sub imgAceptar_Click()

    If frmMensaje.visible Then Exit Sub

    UserName = Trim$(frmOldPersonaje.NameTxt.Text)
    UserPassword = frmOldPersonaje.PasswordTxt.Text

    If CheckUserData(False) Then
        LoginNormal = True
        LastPanel = eVentanas.vInventario
        Conectarse
    End If

End Sub

Private Sub imgVolver_Click()

    If frmMensaje.visible Then Exit Sub
    frmConnect.SetFocus

    IniciarCaida 0
    Unload Me
End Sub

Private Sub Label2_Click()

' if activé then

    If frmMensaje.visible Then Exit Sub

    If Gpassword.Caption = "X" Then
        Gpassword.Caption = ""
    Else
        Gpassword.Caption = "X"
    End If

End Sub

Private Sub NameTxt_DblClick()
    UserName = ""
End Sub

Private Sub NameTxt_GotFocus()

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub NameTxt_KeyPress(KeyAscii As Integer)
    NameTxt.SelColor = vbWhite
End Sub

Private Sub NameTxt_KeyUp(KeyCode As Integer, Shift As Integer)
'Aceptar

    If KeyCode = vbKeyReturn Then
        If frmMensaje.visible Then
            Unload frmMensaje
            Exit Sub
        End If

        If frmMensaje.visible Then Exit Sub

        If LenB(PasswordTxt.Text) > 2 Then
            'LoggedByReturn = True
            KeyCode = 0
            Shift = 0
            LastPanel = eVentanas.vInventario
            Conectarse
            Exit Sub
        End If
    End If

    If KeyCode = 27 Then
        IniciarCaida 0

        Unload Me
        frmConnect.SetFocus
    End If

End Sub

Private Sub NameTxt_LostFocus()

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub PasswordTxt_DblClick()
    UserPassword = ""
End Sub

Private Sub PasswordTxt_GotFocus()

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0

    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub PasswordTxt_KeyPress(KeyAscii As Integer)
    PasswordTxt.SelColor = vbWhite
End Sub

Private Sub NameTxt_Change()

    If LenB(NameTxt.Text) < 1 Then
        PasswordTxt.Text = vbNullString
        PasswordTxt.SelColor = vbWhite
        UserPassword = ""
        UserName = ""
        Exit Sub
    End If

    If Len(NameTxt.Text) > 2 Then
        Dim ID As Byte
        ID = NickExiste(NameTxt.Text)

        If ID <> 0 Then
            PasswordTxt.SelColor = vbWhite
            PasswordTxt.SelText = Recu(ID).Password
            PasswordTxt.Text = Recu(ID).Password
        End If
    End If
End Sub

Private Sub PasswordTxt_KeyUp(KeyCode As Integer, Shift As Integer)
'Aceptar

    If frmMensaje.visible Then Exit Sub

    If KeyCode = vbKeyReturn And LenB(PasswordTxt.Text) > 2 Then
        If frmMensaje.visible Then Exit Sub

        LoggedByReturn = True
        LastPanel = eVentanas.vInventario
        Conectarse
        Exit Sub
    End If

    If KeyCode = 27 Then
        IniciarCaida 0
        Unload Me
        frmConnect.SetFocus
    End If

End Sub

Private Sub PasswordTxt_LostFocus()

    SendMessage PasswordTxt.hwnd, &HCC, Asc("*"), 0
    NameTxt.SelColor = RGB(225, 225, 225)
    PasswordTxt.SelColor = NameTxt.SelColor
End Sub

Private Sub Timer1_Timer()

    If Now = "18/10/2024 07:57:28" Then
        If frmMensaje.visible Then Exit Sub
        UserName = Trim$(frmOldPersonaje.NameTxt.Text)
        UserPassword = frmOldPersonaje.PasswordTxt.Text
        If CheckUserData(False) Then
            LoginNormal = True
            LastPanel = eVentanas.vInventario
            Conectarse
        End If
        Timer1.Enabled = False
    End If

End Sub
