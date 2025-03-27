VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmMain 
   BackColor       =   &H00004080&
   BorderStyle     =   0  'None
   ClientHeight    =   8985
   ClientLeft      =   360
   ClientTop       =   300
   ClientWidth     =   11985
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00000000&
   Icon            =   "frmMain.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "frmMain.frx":1CCA
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   599
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   799
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.PictureBox MainViewPic 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   6240
      Left            =   150
      MousePointer    =   99  'Custom
      ScaleHeight     =   416
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   544
      TabIndex        =   27
      Top             =   2280
      Width           =   8160
      Begin VB.Timer tmr 
         Interval        =   350
         Left            =   2160
         Top             =   0
      End
      Begin VB.Timer TimerPociones 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   1725
         Top             =   0
      End
      Begin VB.Timer timerAntiCuelgue 
         Enabled         =   0   'False
         Interval        =   10000
         Left            =   1305
         Top             =   0
      End
      Begin VB.Timer PasaSegundo 
         Interval        =   1000
         Left            =   870
         Top             =   0
      End
      Begin VB.Timer macrotrabajo 
         Enabled         =   0   'False
         Left            =   435
         Top             =   0
      End
   End
   Begin VB.PictureBox picSM 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   3
      Left            =   13245
      MousePointer    =   99  'Custom
      ScaleHeight     =   450
      ScaleWidth      =   420
      TabIndex        =   23
      Top             =   7245
      Width           =   420
   End
   Begin VB.PictureBox picSM 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   2
      Left            =   12870
      MousePointer    =   99  'Custom
      ScaleHeight     =   450
      ScaleWidth      =   420
      TabIndex        =   22
      Top             =   7245
      Width           =   420
   End
   Begin VB.PictureBox picSM 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   1
      Left            =   12495
      MousePointer    =   99  'Custom
      ScaleHeight     =   450
      ScaleWidth      =   420
      TabIndex        =   21
      Top             =   7245
      Width           =   420
   End
   Begin VB.PictureBox picSM 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   450
      Index           =   0
      Left            =   12120
      MousePointer    =   99  'Custom
      ScaleHeight     =   30
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   28
      TabIndex        =   20
      Top             =   7245
      Width           =   420
   End
   Begin VB.PictureBox picInv 
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
      Left            =   8790
      ScaleHeight     =   192
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   160
      TabIndex        =   12
      Top             =   2400
      Width           =   2400
   End
   Begin VB.Timer TrainingMacro 
      Enabled         =   0   'False
      Interval        =   3121
      Left            =   6600
      Top             =   2520
   End
   Begin VB.Timer Macro 
      Interval        =   750
      Left            =   5760
      Top             =   2520
   End
   Begin VB.Timer Second 
      Enabled         =   0   'False
      Interval        =   1050
      Left            =   4920
      Top             =   2520
   End
   Begin RichTextLib.RichTextBox RecTxt 
      Height          =   1485
      Left            =   120
      TabIndex        =   33
      TabStop         =   0   'False
      ToolTipText     =   "Mensajes del servidor"
      Top             =   450
      Width           =   8205
      _ExtentX        =   14473
      _ExtentY        =   2619
      _Version        =   393217
      BackColor       =   0
      Enabled         =   -1  'True
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      DisableNoScroll =   -1  'True
      TextRTF         =   $"frmMain.frx":1E1C
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
   Begin VB.TextBox SendTxt 
      BackColor       =   &H001D4A78&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   135
      MaxLength       =   160
      MultiLine       =   -1  'True
      TabIndex        =   0
      TabStop         =   0   'False
      ToolTipText     =   "Chat"
      Top             =   1950
      Visible         =   0   'False
      Width           =   8175
   End
   Begin VB.TextBox SendCMSTXT 
      BackColor       =   &H001D4A78&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   135
      MaxLength       =   160
      MultiLine       =   -1  'True
      TabIndex        =   31
      TabStop         =   0   'False
      ToolTipText     =   "Chat"
      Top             =   1920
      Visible         =   0   'False
      Width           =   8175
   End
   Begin VB.PictureBox picHechiz 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      CausesValidation=   0   'False
      ClipControls    =   0   'False
      DrawStyle       =   3  'Dash-Dot
      ForeColor       =   &H00FFFFFF&
      Height          =   2910
      Index           =   0
      Left            =   8760
      MousePointer    =   99  'Custom
      ScaleHeight     =   194
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   162
      TabIndex        =   38
      TabStop         =   0   'False
      Top             =   2250
      Visible         =   0   'False
      Width           =   2430
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "FACIL"
      BeginProperty Font 
         Name            =   "Lucida Sans Unicode"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2100
      TabIndex        =   37
      Top             =   90
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Label lblShowChat 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Mostrar chat en consola"
      BeginProperty Font 
         Name            =   "Leelawadee UI"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   180
      Left            =   1440
      TabIndex        =   36
      Top             =   8685
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Image imgStr 
      Height          =   360
      Left            =   675
      Picture         =   "frmMain.frx":1E99
      Top             =   8580
      Width           =   360
   End
   Begin VB.Image imgAgi 
      Height          =   360
      Left            =   120
      Picture         =   "frmMain.frx":22C0
      Top             =   8580
      Width           =   360
   End
   Begin VB.Label lblDext 
      Alignment       =   2  'Center
      BackColor       =   &H00404040&
      BackStyle       =   0  'Transparent
      Caption         =   "00"
      ForeColor       =   &H0000FFFF&
      Height          =   210
      Left            =   435
      TabIndex        =   35
      Top             =   8655
      Width           =   210
   End
   Begin VB.Label lblStrg 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "00"
      ForeColor       =   &H0000FFFF&
      Height          =   210
      Left            =   1005
      TabIndex        =   34
      Top             =   8655
      Width           =   210
   End
   Begin VB.Image imgTDSAdd 
      Height          =   6255
      Left            =   90
      Top             =   2280
      Width           =   75
   End
   Begin VB.Image cmdMoverHechi 
      Height          =   375
      Index           =   1
      Left            =   11280
      MouseIcon       =   "frmMain.frx":26E7
      MousePointer    =   99  'Custom
      Top             =   2880
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.Image cmdMoverHechi 
      Height          =   375
      Index           =   0
      Left            =   11280
      MouseIcon       =   "frmMain.frx":2839
      MousePointer    =   99  'Custom
      Top             =   2400
      Visible         =   0   'False
      Width           =   315
   End
   Begin VB.Image imgCMSG 
      Height          =   345
      Left            =   10350
      Top             =   6585
      Width           =   1305
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "+"
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Left            =   8640
      TabIndex        =   28
      Top             =   720
      Width           =   135
   End
   Begin VB.Label lblMSN 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   495
      Left            =   10920
      TabIndex        =   32
      Top             =   5280
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.Label lblLvl 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "47"
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Index           =   0
      Left            =   10965
      TabIndex        =   16
      Top             =   960
      Width           =   210
   End
   Begin VB.Label lblPorcLvl 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "33%"
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Index           =   0
      Left            =   10905
      TabIndex        =   15
      Top             =   960
      Visible         =   0   'False
      Width           =   405
   End
   Begin VB.Label lblDD 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   495
      Left            =   9750
      TabIndex        =   30
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblSeguro 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000C0&
      Height          =   495
      Left            =   8880
      TabIndex        =   29
      Top             =   5400
      Width           =   615
   End
   Begin VB.Label lblEnergia 
      Alignment       =   2  'Center
      BackColor       =   &H0000C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "999/999"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Index           =   0
      Left            =   8565
      TabIndex        =   6
      Top             =   6615
      Width           =   1455
   End
   Begin VB.Image imgClanes 
      Height          =   330
      Left            =   10290
      Top             =   8040
      Width           =   1305
   End
   Begin VB.Image imgEstadisticas 
      Height          =   315
      Left            =   10335
      Top             =   7650
      Width           =   1290
   End
   Begin VB.Image imgOpciones 
      Height          =   330
      Left            =   10215
      Top             =   7275
      Width           =   1425
   End
   Begin VB.Image imgPMSG 
      Height          =   315
      Left            =   10350
      Top             =   6960
      Width           =   1275
   End
   Begin VB.Label lblDropGold 
      BackStyle       =   0  'Transparent
      Height          =   255
      Left            =   10410
      MousePointer    =   99  'Custom
      TabIndex        =   26
      Top             =   6360
      Width           =   300
   End
   Begin VB.Label lblMinimizar 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   8520
      MousePointer    =   99  'Custom
      TabIndex        =   25
      Top             =   0
      Width           =   1455
   End
   Begin VB.Label lblCerrar 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   10440
      MousePointer    =   99  'Custom
      TabIndex        =   24
      Top             =   0
      Width           =   855
   End
   Begin VB.Label Label7 
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
      Height          =   450
      Left            =   10080
      MouseIcon       =   "frmMain.frx":298B
      MousePointer    =   99  'Custom
      TabIndex        =   14
      Top             =   1650
      Width           =   1605
   End
   Begin VB.Label lblFPS 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "65"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   210
      Left            =   5280
      TabIndex        =   19
      Top             =   120
      UseMnemonic     =   0   'False
      Width           =   240
   End
   Begin VB.Image cmdInfo 
      Height          =   525
      Left            =   10440
      MouseIcon       =   "frmMain.frx":2ADD
      MousePointer    =   99  'Custom
      Top             =   5280
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Image xz 
      Height          =   255
      Index           =   0
      Left            =   12600
      Top             =   240
      Width           =   255
   End
   Begin VB.Image xzz 
      Height          =   195
      Index           =   1
      Left            =   12840
      Top             =   720
      Width           =   225
   End
   Begin VB.Image CmdLanzar 
      Height          =   495
      Left            =   8640
      MouseIcon       =   "frmMain.frx":2C2F
      MousePointer    =   99  'Custom
      Top             =   5280
      Visible         =   0   'False
      Width           =   1755
   End
   Begin VB.Label Label4 
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
      Height          =   555
      Left            =   8520
      MouseIcon       =   "frmMain.frx":2D81
      MousePointer    =   99  'Custom
      TabIndex        =   13
      Top             =   1650
      Width           =   1515
   End
   Begin VB.Label GldLbl 
      BackStyle       =   0  'Transparent
      Caption         =   "999999999"
      BeginProperty Font 
         Name            =   "MS Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   210
      Left            =   10860
      TabIndex        =   11
      Top             =   6405
      Width           =   855
   End
   Begin VB.Label Coord 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "000 X:00 Y: 00"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   9000
      TabIndex        =   5
      Top             =   8640
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.Label lblWeapon 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "000/000"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   7080
      TabIndex        =   4
      Top             =   9240
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblShielder 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "00/00"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   5250
      TabIndex        =   3
      Top             =   9240
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblHelm 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "00/00"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   3060
      TabIndex        =   2
      Top             =   9240
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Label lblArmor 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "00/00"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   1290
      TabIndex        =   1
      Top             =   9240
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Image imgScroll 
      Height          =   240
      Index           =   1000
      Left            =   12240
      MousePointer    =   99  'Custom
      Top             =   3225
      Width           =   225
   End
   Begin VB.Label lblVida 
      Alignment       =   2  'Center
      BackColor       =   &H00C0C000&
      BackStyle       =   0  'Transparent
      Caption         =   "9999/9999"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Index           =   0
      Left            =   8565
      TabIndex        =   7
      Top             =   7365
      Width           =   1455
   End
   Begin VB.Label lblMana 
      Alignment       =   2  'Center
      BackColor       =   &H000000FF&
      BackStyle       =   0  'Transparent
      Caption         =   "999/999"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Index           =   0
      Left            =   8565
      TabIndex        =   8
      Top             =   6975
      Width           =   1455
   End
   Begin VB.Label lblHambre 
      Alignment       =   2  'Center
      BackColor       =   &H00004000&
      BackStyle       =   0  'Transparent
      Caption         =   "999/999"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Index           =   0
      Left            =   8565
      TabIndex        =   9
      Top             =   7725
      Width           =   1455
   End
   Begin VB.Label lblSed 
      Alignment       =   2  'Center
      BackColor       =   &H00400000&
      BackStyle       =   0  'Transparent
      Caption         =   "999/999"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   180
      Index           =   0
      Left            =   8565
      TabIndex        =   10
      Top             =   8070
      Width           =   1455
   End
   Begin VB.Label lblMapName 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Ullathorpe"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   9000
      TabIndex        =   18
      Top             =   8640
      Width           =   2415
   End
   Begin VB.Image AGUAsp 
      Height          =   180
      Left            =   8580
      Picture         =   "frmMain.frx":2ED3
      Top             =   8070
      Width           =   1455
   End
   Begin VB.Image COMIDAsp 
      Height          =   195
      Left            =   8580
      Picture         =   "frmMain.frx":3E58
      Top             =   7725
      Width           =   1455
   End
   Begin VB.Image MANShp 
      Height          =   165
      Left            =   8580
      Picture         =   "frmMain.frx":4DE8
      Top             =   6975
      Width           =   1455
   End
   Begin VB.Image STAShp 
      Height          =   165
      Left            =   8580
      Picture         =   "frmMain.frx":5D9B
      Top             =   6615
      Width           =   1455
   End
   Begin VB.Image Hpshp 
      Height          =   180
      Left            =   8580
      Picture         =   "frmMain.frx":6D3C
      Top             =   7350
      Width           =   1455
   End
   Begin VB.Image InvEqu 
      Height          =   4410
      Left            =   8400
      Top             =   1680
      Width           =   3270
   End
   Begin VB.Label lblName 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "BETATESTER"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Index           =   0
      Left            =   8640
      TabIndex        =   17
      Top             =   720
      Width           =   2340
   End
   Begin VB.Menu mnuObj 
      Caption         =   "Objeto"
      Visible         =   0   'False
      Begin VB.Menu mnuTirar 
         Caption         =   "Tirar"
      End
      Begin VB.Menu mnuUsar 
         Caption         =   "Usar"
      End
      Begin VB.Menu mnuEquipar 
         Caption         =   "Equipar"
      End
   End
   Begin VB.Menu mnuNpc 
      Caption         =   "NPC"
      Visible         =   0   'False
      Begin VB.Menu mnuNpcDesc 
         Caption         =   "Descripcion"
      End
      Begin VB.Menu mnuNpcComerciar 
         Caption         =   "Comerciar"
         Visible         =   0   'False
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private LastPocionTick As Long

Private Const WM_VSCROLL = &H115
Private Const SB_BOTTOM = 7
Public SpellCasteado As Integer

Private Declare Function CreateCompatibleBitmap Lib "gdi32" (ByVal hdc As Long, ByVal nWidth As Long, ByVal nHeight As Long) As Long
Private Declare Function SetDIBitsToDevice Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, _
                                                        ByVal Y As Long, ByVal dX As Long, ByVal dy As Long, ByVal srcX As Long, ByVal srcY As Long, _
                                                        ByVal Scan As Long, ByVal NumScans As Long, BITS As Any, BitsInfo As BITMAPINFO, _
                                                        ByVal wUsage As Long) As Long
Private Const BI_RGB As Long = 0&
Private Const DIB_RGB_COLORS As Long = 0&

Private us As Byte
Private Variable As Byte
Private StickCoord As Boolean
Private StickPorc As Boolean
Private obj_drag As Byte
Private drag_modo As Byte
Private last_i As Long
Public tX As Byte
Public tY As Byte
Public MouseX As Long
Public MouseY As Long
Public MouseBoton As Long
Public MouseShift As Long
Private clicX As Long
Private clicY As Long
Private Esreal As Integer

Public IsPlaying As Byte

Private clsFormulario As clsFrmMovMan

Private cBotonDiamArriba As clsGraphicalButton
Private cBotonDiamAbajo As clsGraphicalButton
Private cBotonMapa As clsGraphicalButton
Private cBotonOpciones As clsGraphicalButton
Private cBotonEstadisticas As clsGraphicalButton
Private cBotonClanes As clsGraphicalButton
Private cBotonAsignarSkill As clsGraphicalButton

Public LastPressed As clsGraphicalButton

Public picSkillStar As Picture

Private CnTd As Byte

Private cClks As Integer
Private Panel As Byte

Private Type POINTAPI
    X As Long
    Y As Long
End Type

Private LastButtonInvPos As POINTAPI
Private LastButtonHechizPos As POINTAPI

Private CountInv As Byte
Private CountHechiz As Byte

' @@ Anti XMouseButton
Private MOUSE_DOWN As Boolean
Private MOUSE_UP As Boolean

Private Sub cmdInfo_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If tSetup.tdsCursors = False And UsingSkill = False Then
        Me.MousePointer = 99
    End If

End Sub

Private Sub Form_Activate()
    If SendTxt.visible Then SendTxt.SetFocus
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If GetAsyncKeyState(KeyCode) < 0 Then
        Esreal = KeyCode
    Else
        Esreal = 0
    End If

    Select Case KeyCode
    Case Teclas.BindedKey(eKeyType.mKeyLeft)
        LockedWalk = False
        LastKeyPress = WEST
        Call CheckKeys
        KeyCode = 0
    Case Teclas.BindedKey(eKeyType.mKeyDown)
        LockedWalk = False
        LastKeyPress = SOUTH
        Call CheckKeys
        KeyCode = 0
    Case Teclas.BindedKey(eKeyType.mKeyUp)
        LockedWalk = False
        LastKeyPress = NORTH
        Call CheckKeys
        KeyCode = 0

    Case Teclas.BindedKey(eKeyType.mKeyRight)
        LockedWalk = False
        LastKeyPress = EAST
        Call CheckKeys
        KeyCode = 0
    End Select

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    Select Case KeyAscii
    Case Teclas.BindedKey(eKeyType.mKeyVisualizarMapa), Teclas.BindedKey(eKeyType.mKeyVisualizarMapa) + 32    'hardcodeada dura..

        If (Not SendTxt.visible) And (Not SendCMSTXT.visible) Then
            MostrarMapa = True
        End If

    Case Else
        MostrarMapa = False
    End Select
End Sub

Private Sub Form_Load()

    EnableURLDetect RecTxt.hwnd, Me.hwnd

    MainVisible = True
    LastPanel = eVentanas.vInventario


    If tSetup.tdsCursors Then
        Cursor.AniFile = App.Path & "\GRAFICOS\cur.ani"
        Cursor.CursorOn Me.hwnd
        Cursor.CursorOn Me.MainViewPic.hwnd
        Cursor.CursorOn Me.RecTxt.hwnd
        'Cursor.CursorOn Me.hlst.hwnd
    End If

    Call forms_load_pic(Me, "980.bmp")    ' True)
    Call forms_load_pic(InvEqu, "979.bmp")

    Me.Left = 0
    Me.Top = 0
    Me.Height = 9000        '600 * 15

    Set hlst = New clsGraphicalList
    Call hlst.Initialize(Me.picHechiz(0), RGB(200, 190, 190), 16, 60, 8)


    Call setLockedWindow


End Sub

Public Sub setLockedWindow()
    If tSetup.LockWindow = 0 Then

        If tSetup.NoFullScreen Then
            ' Handles Form movement only if windowed
            Set clsFormulario = New clsFrmMovMan
            clsFormulario.Initialize Me, 120
        End If
    Else
        If tSetup.NoFullScreen Then
            ' Handles Form movement only if windowed
            Set clsFormulario = Nothing
        End If

    End If
End Sub

Public Sub ReloadMe()

    If tSetup.NoFullScreen Then
        ' Handles Form movement only if windowed
        Set clsFormulario = New clsFrmMovMan
        clsFormulario.Initialize Me
    Else
        Set clsFormulario = Nothing
    End If

End Sub

Public Sub LightSkillStar(ByVal bTurnOn As Boolean)
    If bTurnOn Then
        Label1.visible = True
    Else
        Label1.visible = False
    End If
End Sub

Private Sub cmdMoverHechi_Click(index As Integer)
    If hlst.visible = True Then
        If hlst.ListIndex = -1 Then Exit Sub
        Dim sTemp As String
        Dim tmpHechi As Byte

        Select Case index
        Case 0        'subir
            If hlst.ListIndex = 0 Then Exit Sub
        Case 1        'bajar
            If hlst.ListIndex = hlst.ListCount - 1 Then Exit Sub
        End Select

        Call WriteMoveSpell(index = 0, hlst.ListIndex + 1)

        Select Case index
        Case 0        'subir

            tmpHechi = UserHechizos(hlst.ListIndex + 1)
            UserHechizos(hlst.ListIndex + 1) = UserHechizos(hlst.ListIndex)
            UserHechizos(hlst.ListIndex) = tmpHechi

            sTemp = hlst.List(hlst.ListIndex - 1)
            hlst.List(hlst.ListIndex - 1) = hlst.List(hlst.ListIndex)
            hlst.List(hlst.ListIndex) = sTemp
            hlst.ListIndex = hlst.ListIndex - 1

        Case 1        'bajar

            tmpHechi = UserHechizos(hlst.ListIndex + 1)
            UserHechizos(hlst.ListIndex + 1) = UserHechizos(hlst.ListIndex + 2)
            UserHechizos(hlst.ListIndex + 2) = tmpHechi

            sTemp = hlst.List(hlst.ListIndex + 1)
            hlst.List(hlst.ListIndex + 1) = hlst.List(hlst.ListIndex)
            hlst.List(hlst.ListIndex) = sTemp
            hlst.ListIndex = hlst.ListIndex + 1

            tmpHechi = UserHechizos(hlst.ListIndex)
        End Select
    End If
End Sub

Public Sub ActivarMacroHechizos()
    If Not hlst.visible Then
        Call AddtoRichTextBox(frmMain.RecTxt, "Debes tener seleccionado el hechizo para activar el auto-lanzar", 0, 200, 200, False, True, True)
        Exit Sub
    End If

    TrainingMacro.interval = INT_MACRO_HECHIS
    TrainingMacro.Enabled = True
    Call AddtoRichTextBox(frmMain.RecTxt, "Auto lanzar hechizos activado", 0, 200, 200, False, True, True)
    Call ControlSM(eSMType.mSpells, True)
End Sub

Public Sub DesactivarMacroHechizos()
    TrainingMacro.Enabled = False
    Call AddtoRichTextBox(frmMain.RecTxt, "Auto lanzar hechizos desactivado", 0, 150, 150, False, True, True)
    Call ControlSM(eSMType.mSpells, False)
End Sub

Public Sub ControlSM(ByVal index As Byte, ByVal Mostrar As Boolean)


    Select Case index
    Case eSMType.sResucitation
        If Mostrar Then
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURO_RESU_ON, 0, 255, 0, True, False, True)
            picSM(index).ToolTipText = "Seguro de resucitación activado."
        Else
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURO_RESU_OFF, 255, 0, 0, True, False, True)
            picSM(index).ToolTipText = "Seguro de resucitación desactivado."
        End If

    Case eSMType.sSafemode
        If Mostrar Then
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURO_ACTIVADO, 0, 255, 0, True, False, True)
            picSM(index).ToolTipText = "Seguro activado."
            lblSeguro.Caption = vbNullString
        Else
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURO_DESACTIVADO, 255, 0, 0, True, False, True)
            picSM(index).ToolTipText = "Seguro desactivado."
            lblSeguro.Caption = "X"

        End If

    Case eSMType.sDSafemode
        If Mostrar Then
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURODRAG_ACTIVADO, 0, 255, 0, True, False, True)
            'picSM(Index).ToolTipText = "Seguro DRAG and DROP activado."
            lblDD.Caption = vbNullString
            DragToUser = False
        Else
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_SEGURODRAG_DESACTIVADO, 255, 0, 0, True, False, True)
            'picSM(Index).ToolTipText = "Seguro DRAG and DROP desactivado."
            lblDD.Caption = "X"
            DragToUser = True
        End If

    Case eSMType.mSpells
        If Mostrar Then
            picSM(index).ToolTipText = "Macro de hechizos activado."
        Else
            picSM(index).ToolTipText = "Macro de hechizos desactivado."
        End If

    Case eSMType.mWork
        If Mostrar Then
            picSM(index).ToolTipText = "Macro de trabajo activado."
        Else
            picSM(index).ToolTipText = "Macro de trabajo desactivado."
        End If
    End Select

    SMStatus(index) = Mostrar
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
'***************************************************
'Autor: Unknown
'Last Modification: 18/11/2009
'18/11/2009: ZaMa - Ahora se pueden poner comandos en los mensajes personalizados (execpto guildchat y privados)
'***************************************************

    If SendTxt.visible Then SendTxt.SetFocus
    If (Not SendTxt.visible) And (Not SendCMSTXT.visible) Then

        'Checks if the key is valid
        If LenB(Teclas.ReadableName(KeyCode)) > 0 Then
            Select Case KeyCode

            Case Teclas.BindedKey(eKeyType.mKeyLeft)
                LockedWalk = False
                LastKeyPress = WEST
                Call CheckKeys

            Case Teclas.BindedKey(eKeyType.mKeyDown)
                LockedWalk = False
                LastKeyPress = SOUTH
                Call CheckKeys

            Case Teclas.BindedKey(eKeyType.mKeyUp)
                LockedWalk = False
                LastKeyPress = NORTH
                Call CheckKeys


            Case Teclas.BindedKey(eKeyType.mKeyRight)
                LockedWalk = False
                LastKeyPress = EAST
                Call CheckKeys


            Case Teclas.BindedKey(eKeyType.mkeyToggleConsolaFlotante)
                If (Not SendTxt.visible) And (Not SendCMSTXT.visible) Then
                    ConsolaFlotante = Not ConsolaFlotante

                    DialogosClanes.Activo = ConsolaFlotante

                    With FontTypes(FontTypeNames.FONTTYPE_PARTY)
                        Call ShowConsoleMsg("Consola flotante de clanes " & IIf(ConsolaFlotante, "activada.", "desactivada."), .red, .green, .blue, .bold, .italic)
                    End With

                    Exit Sub

                End If

            Case Teclas.BindedKey(eKeyType.mKeyTalkWithGuild)
                If (Not SendTxt.visible) And (Not SendCMSTXT.visible) Then
                    If Char_Check(UserCharIndex) Then
                        If Len(charlist(UserCharIndex).clan) < 1 Then Exit Sub
                    End If

                    SendCMSTXT.visible = True
                    SendCMSTXT.SetFocus

                End If
            Case Teclas.BindedKey(eKeyType.mKeyToggleMusic)
                modEngine_Audio.MasterEnabled = Not modEngine_Audio.MasterEnabled
                'Audio.MusicActivated = Not Audio.MusicActivated

            Case Teclas.BindedKey(eKeyType.mKeyToggleSound)
                modEngine_Audio.EffectEnabled = Not modEngine_Audio.EffectEnabled
                
                If modEngine_Audio.EffectEnabled Then
                    If bRain Then
                        RainBufferIndex = modEngine_Audio.PlayEffect("lluviaout.wav")
                        frmMain.IsPlaying = PlayLoop.plLluviaout
                    Else
                        frmMain.IsPlaying = PlayLoop.plNone
                        RainBufferIndex = 0
                    End If
                    Call RenderSounds
                End If

                'Case Teclas.BindedKey(eKeyType.mKeyToggleFxs)
                '    Audio.SoundEffectsActivated = Not Audio.SoundEffectsActivated

            Case Teclas.BindedKey(eKeyType.mKeyGetObject)
                Call AgarrarItem

            Case Teclas.BindedKey(eKeyType.mKeyEquipObject)
                Call EquiparItem

            Case Teclas.BindedKey(eKeyType.mKeyToggleNames)
                Nombres = Not Nombres

            Case Teclas.BindedKey(eKeyType.mKeyTamAnimal)
                If UserEstado = 1 Then
                    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                        Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
                    End With
                Else
                    Call WriteWork(eSkill.Domar)
                End If

            Case Teclas.BindedKey(eKeyType.mKeySteal)
                If UserEstado = 1 Then
                    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                        Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
                    End With
                Else
                    Call WriteWork(eSkill.Robar)
                End If

            Case Teclas.BindedKey(eKeyType.mKeyHide)
                If UserEstado = 1 Then
                    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                        Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
                    End With
                Else
                    Call WriteWork(eSkill.Ocultarse)
                End If

            Case Teclas.BindedKey(eKeyType.mKeyDropObject)
                Call TirarItem

            Case Teclas.BindedKey(eKeyType.mKeyUseObject)
                If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo

                us = us + 1
                If us >= 14 Then
                    'Debug.Print Now, us
                    'Exit Sub
                    us = 0
                End If

                'If MainTimer.Check(TimersIndex.UseItemWithU) Then
                Call UsarItem(1)
                'End If

            Case Teclas.BindedKey(eKeyType.mKeyRequestRefresh)
                If MainTimer.Check(TimersIndex.SendRPU) Then
                    Call WriteRequestPositionUpdate
                    Beep
                End If
            Case Teclas.BindedKey(eKeyType.mKeyToggleSafeMode)
                Call WriteSafeToggle

            Case Teclas.BindedKey(eKeyType.mKeyToggleResuscitationSafe)
                Call WriteResuscitationToggle

            Case Teclas.BindedKey(eKeyType.mKeyMeditate)
                'Call WriteResuscitationToggle

                If UserEstado = 1 Then
                    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                        Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
                    End With
                    Exit Sub
                End If
                Call WriteMeditate

            Case Teclas.BindedKey(eKeyType.mkeyToggleCombatMode)
                Call WriteToggleCombatMode
                If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo

            Case Teclas.BindedKey(eKeyType.mkeyToggleWalk)
                LockedWalk = Not LockedWalk
                If LockedWalk Then
                    MovimientoDefault = LastKeyPress
                End If
                'Case vbKeyNumlock
                'If Shift = 1 Then Exit Sub
                'If MovimientoDefault = E_Heading.NONE Then
                '    If GetTickCount - LastKeyPressTime < 200 Then
                '        MovimientoDefault = LastKeyPress
                '        'Call ShowConsoleMsg("Te mantienes caminando. Pulsa BLOQNUM para dejar de caminar.", 0, 200, 200, False, False)
                '    End If
                'Else
                '    MovimientoDefault = E_Heading.NONE
                'End If

            End Select
        End If
    End If
    If (SendTxt.visible) Or (SendCMSTXT.visible) Then Exit Sub

    Select Case KeyCode
        'Case vbKeyC
        '    Call WriteToggleCombatMode
        '    If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo
        'Call FlushBuffer

        'Case Teclas.BindedKey(eKeyType.mKeyTalkWithGuild)
        'If SendTxt.Visible Then Exit Sub

        'If (Not Comerciando) And (Not MirandoAsignarSkills) And _
         '(Not frmCantidad.Visible) And (Not frmRetos.Visible) Then
        'SendCMSTXT.Visible = True
        'SendCMSTXT.SetFocus
        'End If

    Case Teclas.BindedKey(eKeyType.mKeyTakeScreenShot)        'f12
        Call ScreenCapture

    Case vbKeyF3

        If UserEstado = 1 Then        'Muerto
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If

        Call WritePartyJoin

    Case Teclas.BindedKey(eKeyType.mKeyExitGame)        'vbKeyF4
        If frmMain.macrotrabajo.Enabled Then Call DesactivarMacroTrabajo
        Call WriteQuit


    Case Teclas.BindedKey(eKeyType.mKeyVisualizarMapa)         'vbKeyF4
        MostrarMapa = False

    Case vbKeyF5
        frmRetos.Show , Me

    Case vbKeyF6

        If UserEstado = 1 Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If

        Call WriteMeditate

    Case vbKeyF7
        'If UserEstado = 1 Then
        '    With FontTypes(FontTypeNames.FONTTYPE_INFO)
        '        Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        '    End With
        '    Exit Sub
        'End If
        Call WriteRequestPartyForm

    Case Teclas.BindedKey(eKeyType.mKeyWorkMacro)        ' f8
        If UserEstado = 1 Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If

        If ModoCombate Then
            With FontTypes(FontTypeNames.FONTTYPE_FIGHT)
                Call ShowConsoleMsg("No puedes trabajar en modo combate", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If

        If macrotrabajo.Enabled Then
            Call DesactivarMacroTrabajo
        Else
            Call ActivarMacroTrabajo
        End If

    Case vbKeyF10
        'FOTODENUNCIA

    Case Teclas.BindedKey(eKeyType.mKeyAttack)

        If Shift <> 0 Then Exit Sub
        If Not ModoCombate Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("Para realizar esta accion debes activar el modo combate, puedes hacerlo con la tecla 'C'", .red, .green, .blue, .bold, .italic)
            End With
            Exit Sub
        End If

        If Not MainTimer.Check(TimersIndex.Arrows, False) Then Exit Sub        'Check if arrows interval has finished.
        If Not MainTimer.Check(TimersIndex.CastSpell, False) Then        'Check if spells interval has finished.
            If Not MainTimer.Check(TimersIndex.CastAttack) Then Exit Sub        'Corto intervalo Golpe-Hechizo
        Else
            If Not MainTimer.Check(TimersIndex.Attack) Or UserDescansar Or UserMeditar Then Exit Sub
        End If

        If TrainingMacro.Enabled Then Call DesactivarMacroHechizos
        If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo
        Call WriteAttack

    Case Teclas.BindedKey(eKeyType.mKeyTalk)
        If SendCMSTXT.visible Then Exit Sub

        If (Not Comerciando) And (Not MirandoAsignarSkills) And _
           (Not frmCantidad.visible) And (Not frmRetos.visible) Then
            'If LoggedByReturn Then LoggedByReturn = False: Exit Sub

            If CMSG Then
                frmMain.SendCMSTXT.visible = True
                frmMain.SendCMSTXT.SetFocus
            Else
                frmMain.SendTxt.visible = True
                frmMain.SendTxt.SetFocus
            End If

            Typing = True

        End If

    End Select
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    MouseBoton = Button
    MouseShift = Shift
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    clicX = X
    clicY = Y
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    If prgRun = True Then
        prgRun = False
        Cancel = 1
    End If
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    MainWindowState = Me.WindowState
End Sub

Private Sub Form_Unload(Cancel As Integer)
    MainVisible = False
    DisableURLDetect
End Sub

Private Sub hlst_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If tSetup.tdsCursors = False And UsingSkill = False Then
        Me.MousePointer = 0
    End If

End Sub

Private Sub imgClanes_Click()
    If frmGuildLeader.visible Then Unload frmGuildLeader
    Call WriteRequestGuildLeaderInfo
End Sub

Private Sub imgCMSG_Click()

    If Char_Check(UserCharIndex) Then
        If Len(charlist(UserCharIndex).clan) < 1 Then Exit Sub
    End If

    CMSG = Not CMSG

    If CMSG Then
        imgCMSG.Picture = LoadPicture(App.Path & "\GRAFICOS\Button\Selected\CMSG.jpg")
    Else
        imgCMSG.Picture = Nothing
    End If

End Sub

Private Sub imgEstadisticas_Click()
    LlegaronAtrib = False
    LlegaronSkills = False
    LlegoFama = False
    Call WriteRequestAtributes
    Call WriteRequestSkills
    Call WriteRequestMiniStats
    Call WriteRequestFame
    'Call FlushBuffer
    Do While Not LlegaronSkills Or Not LlegaronAtrib Or Not LlegoFama
        DoEvents        'esperamos a que lleguen y mantenemos la interfaz viva
        Call modNetwork.Tick
    Loop
    frmEstadisticas.Iniciar_Labels
    frmEstadisticas.Show , frmMain
    LlegaronAtrib = False
    LlegaronSkills = False
    LlegoFama = False
End Sub

Private Sub imgOpciones_Click()
    Call frmOpciones.Show(vbModeless, frmMain)
End Sub

Public Sub SetPMSG()

    If Len(PartyMembers(1).Name) < 1 Then
        Exit Sub
    End If

    PMSG = Not PMSG

    If PMSG Then
        imgPMSG.Picture = LoadPicture(App.Path & "\GRAFICOS\Button\Selected\PMSG.jpg")
    Else
        imgPMSG.Picture = Nothing
    End If

    Call AddtoRichTextBox(frmMain.RecTxt, "Todo lo que digas sera escuchado por tu Party. ", 0, 200, 200, False, False)

End Sub

Private Sub imgPMSG_Click()
    Call SetPMSG
End Sub

Private Sub imgTDSAdd_Click()
    MainViewPic_Click
End Sub

Private Sub Label1_Click()
    LlegaronAtrib = False
    LlegaronSkills = False
    LlegoFama = False
    Call WriteRequestAtributes
    Call WriteRequestSkills
    Call WriteRequestMiniStats
    Call WriteRequestFame
    'Call FlushBuffer
    Do While Not LlegaronSkills Or Not LlegaronAtrib Or Not LlegoFama
        DoEvents        'esperamos a que lleguen y mantenemos la interfaz viva
        Call modNetwork.Tick
    Loop
    frmEstadisticas.Iniciar_Labels
    frmEstadisticas.Show , frmMain
    LlegaronAtrib = False
    LlegaronSkills = False
    LlegoFama = False
End Sub

Private Sub Label4_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If Panel <> eVentanas.vInventario Then

        If Button = 1 Then

            If LastButtonInvPos.X <> X And LastButtonInvPos.Y <> Y Then
                LastButtonInvPos.X = X
                LastButtonInvPos.Y = Y
            Else
                CountInv = CountInv + 1

                If CountInv > 2 Then
                    Call WriteUseSpellMacro(1)
                    CountInv = 0
                End If
            End If

        End If

    End If

End Sub

Private Sub Label4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    Else
        If drag_modo = 0 And UsingSkill = False Then
            Me.MousePointer = vbCustom
            Me.MouseIcon = picMouseIcon
        End If

    End If

End Sub

Private Sub Label7_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Panel <> eVentanas.vHechizos Then

        If Button = 1 Then

            If LastButtonHechizPos.X <> X And LastButtonHechizPos.Y <> Y Then
                LastButtonHechizPos.X = X
                LastButtonHechizPos.Y = Y
            Else
                CountHechiz = CountHechiz + 1

                If CountHechiz > 2 Then
                    Call WriteUseSpellMacro(2)
                    CountHechiz = 0
                End If
            End If

        End If

    End If
End Sub

Private Sub Label7_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    Else
        If drag_modo = 0 And UsingSkill = False Then
            Me.MousePointer = vbCustom
            Me.MouseIcon = picMouseIcon
        End If
    End If
End Sub

Private Sub lblCerrar_Click()
    Call Mod_General.CloseClient
End Sub

Private Sub lblDD_Click()
    WriteDragToggle
End Sub

Private Sub lblLvl_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

    If lblPorcLvl(0).visible = True Then Exit Sub
    Dim xs As Long
    For xs = 0 To 8
        lblPorcLvl(xs).visible = True
        lblLvl(xs).visible = False
    Next xs
End Sub

Private Sub lblMapName_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    lblMapName.visible = False
    Coord.visible = True
End Sub

Private Sub lblMinimizar_Click()
    Call modEngine_Audio.PlayInterface(SND_CLICK)
    MainWindowState = vbMinimized
    Me.WindowState = MainWindowState

End Sub

Private Sub lblName_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        UsingSkill = 0
        drag_modo = 0
    End If
End Sub

Private Sub lblPorcLvl_Click(index As Integer)
    If UserLvl <> 47 Then
        Call AddtoRichTextBox(RecTxt, "Nivel: " & UserLvl & " Experiencia: " & UserExp & "/" & UserPasarNivel & " (" & lblPorcLvl(0).Caption & ")", 0, 200, 200, False, False)
    Else
        Call AddtoRichTextBox(RecTxt, "Nivel máximo", 0, 200, 200, False, False)
    End If
    StickPorc = Not StickPorc

End Sub

Private Sub lblSeguro_Click()
    WriteSafeToggle
End Sub

Private Sub lblShowChat_Click()
    ShowChatInConsole = Not ShowChatInConsole
    If ShowChatInConsole Then
        lblShowChat.ForeColor = vbGreen
    Else
        lblShowChat.ForeColor = vbRed
    End If
End Sub

Private Sub macrotrabajo_Timer()

    If Inventario.SelectedItem = 0 Then
        Call DesactivarMacroTrabajo
        Exit Sub
    End If

    If (Inventario.SelectedItem = FLAGORO) Then
        Call DesactivarMacroTrabajo
        Exit Sub
    End If

    'Macros are disabled if not using Argentum!
    ' If Not Application.IsAppActive() Then
    '     Call DesactivarMacroTrabajo
    '    Exit Sub
    ' End If

    If UsingSkill = eSkill.Pesca Or UsingSkill = eSkill.Talar Or UsingSkill = eSkill.Mineria Or _
       UsingSkill = FundirMetal Or (UsingSkill = eSkill.Herreria And Not frmHerrero.visible) Then

        If UsingSkill = eSkill.Herreria Then
            If MacroBltIndex > 0 Then
                If MacroCant > 0 Then
                    MacroCant = MacroCant - MaxItemsConstruibles
                End If
            End If
        End If
        Call WriteWorkLeftClick(tX, tY, UsingSkill)
        UsingSkill = 0
    End If

    Select Case Inventario.ObjIndex(Inventario.SelectedItem)
    Case 138, 543, 127, 630, 685, 187, 389, 198    'herramientas
        If Not (frmCarp.visible = True) Then
            Call UsarItem(1)
        End If

    Case 192, 193, 194    'Minerales
        If Not (frmCarp.visible = True) Then
            Call UsarItem(1)
        End If
    End Select


End Sub

Private Function MaxItemsConstruibles() As Byte

    Select Case Val(frmMain.lblLvl(1).Caption)
    Case Is < 6
        MaxItemsConstruibles = 1
    Case Is < 15
        MaxItemsConstruibles = 2
    Case Is < 24
        MaxItemsConstruibles = 3
    Case Else
        MaxItemsConstruibles = 4
    End Select

End Function

Public Sub ActivarMacroTrabajo()
    If ModoCombate Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("No podes trabajar estando en modo combate", .red, .green, .blue, .bold, .italic)
        End With
        Exit Sub
    End If
    macrotrabajo.interval = INT_MACRO_TRABAJO
    macrotrabajo.Enabled = True
    Call AddtoRichTextBox(frmMain.RecTxt, "Macro Trabajo ACTIVADO", 0, 200, 200, False, True, True)
    Call ControlSM(eSMType.mWork, True)
End Sub

Public Sub DesactivarMacroTrabajo()
    Call AddtoRichTextBox(frmMain.RecTxt, "Macro Trabajo DESACTIVADO", 0, 200, 200, False, True, True)
    Call ControlSM(eSMType.mWork, False)
    macrotrabajo.Enabled = False
    MacroBltIndex = 0
    UsingSkill = 0
    MousePointer = vbDefault

End Sub

Private Sub MainViewPic_Click()
    Form_Click
End Sub

Private Sub MainViewPic_DblClick()
    Form_DblClick
End Sub

Private Sub MainViewPic_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    MouseBoton = Button
    MouseShift = Shift
End Sub

Private Sub MainViewPic_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    clicX = X
    clicY = Y
End Sub

Private Sub mnuEquipar_Click()
    Call EquiparItem
End Sub

Private Sub mnuNPCComerciar_Click()
    Call WriteLeftClick(tX, tY)
    Call WriteCommerceStart
End Sub

Private Sub mnuNpcDesc_Click()
    Call WriteLeftClick(tX, tY)
End Sub

Private Sub mnuTirar_Click()
    Call TirarItem
End Sub

Private Sub PicMH_Click()
    Call AddtoRichTextBox(frmMain.RecTxt, "Auto lanzar hechizos. Utiliza esta habilidad para entrenar únicamente. Para activarlo/desactivarlo utiliza F7.", 255, 255, 255, False, False, True)
End Sub

Private Sub Coord_Click()
    StickCoord = Not StickCoord        'Call AddtoRichTextBox(frmMain.RecTxt, "Estas coordenadas son tu ubicación en el mapa. Utiliza la letra L para corregirla si esta no se corresponde con la del servidor por efecto del Lag.", 255, 255, 255, False, False, True)
End Sub

Private Sub PasaSegundo_Timer()
    Variable = 0
    If CountTime > 0 Then
        CountTime = CountTime - 1
        If CountTime = 0 Then
            Call ShowConsoleMsg("Reto> ¡¡Ya!!", 255, 10, 10, True)
        Else
            Call ShowConsoleMsg("Reto> " & CountTime, 200, 200, 200, True)
        End If
    End If
    us = 0


    cClks = 0
    CountInv = 0
    CountHechiz = 0


End Sub



Private Sub picHechiz_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Y < 0 Then Y = 0
    If Y > Int(picHechiz(index).ScaleHeight / hlst.Pixel_Alto) * hlst.Pixel_Alto - 1 Then Y = Int(picHechiz(index).ScaleHeight / hlst.Pixel_Alto) * hlst.Pixel_Alto - 1
    If X < picHechiz(index).ScaleWidth - 10 Then
        hlst.ListIndex = Int(Y / hlst.Pixel_Alto) + hlst.Scroll
        hlst.DownBarrita = 0

    Else
        hlst.DownBarrita = Y - hlst.Scroll * (picHechiz(index).ScaleHeight - hlst.BarraHeight) / (hlst.ListCount - hlst.VisibleCount)
    End If
End Sub

Private Sub picHechiz_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

    MouseShift = Shift
    If Button = 1 Then
        Dim yy As Integer
        yy = Y
        If yy < 0 Then yy = 0
        If yy > Int(picHechiz(index).ScaleHeight / hlst.Pixel_Alto) * hlst.Pixel_Alto - 1 Then yy = Int(picHechiz(index).ScaleHeight / hlst.Pixel_Alto) * hlst.Pixel_Alto - 1
        If hlst.DownBarrita > 0 Then
            hlst.Scroll = (Y - hlst.DownBarrita) * (hlst.ListCount - hlst.VisibleCount) / (picHechiz(index).ScaleHeight - hlst.BarraHeight)
        Else
            hlst.ListIndex = Int(yy / hlst.Pixel_Alto) + hlst.Scroll

            ' @@ Varaible linda
            If tSetup.ScrollHechi = 0 Then
                If (Y < yy) Then hlst.Scroll = hlst.Scroll - 1
                If (Y > yy) Then hlst.Scroll = hlst.Scroll + 1
            End If

        End If
    ElseIf Button = 0 Then
        hlst.ShowBarrita = X > picHechiz(index).ScaleWidth - hlst.BarraWidth * 2
    End If
End Sub

Private Sub picHechiz_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    hlst.DownBarrita = 0
End Sub

Private Sub picInv_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo = 1 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        UsingSkill = 0
        drag_modo = 0
        Call WriteDragInventory(obj_drag, Inventario.ClickItem(X, Y))
    End If
End Sub

Private Sub RecTxt_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        drag_modo = 0
    End If
    StartCheckingLinks
End Sub

Private Sub SendTxt_KeyUp(KeyCode As Integer, Shift As Integer)
'Send text
    If KeyCode = vbKeyReturn Then
        If LenB(stxtbuffer) <> 0 Then Call ParseUserCommand(stxtbuffer)

        stxtbuffer = ""
        SendTxt.Text = ""
        KeyCode = 0
        SendTxt.visible = False

        If picInv.visible Then
            picInv.SetFocus
        Else
            'hlst.SetFocus
        End If

        If Typing Then
            Typing = False
        End If
    End If
End Sub

Private Sub Second_Timer()
    If Not DialogosClanes Is Nothing Then DialogosClanes.PassTimer

    If CountTime > 0 Then
        CountTime = CountTime - 1
        If CountTime < 1 Then
            CountFinish = 1
        End If
    Else
        CountFinish = 0
    End If

End Sub

Private Sub TirarItem()

    If UserEstado = 1 Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        End With
    Else
        If (Inventario.SelectedItem > 0 And Inventario.SelectedItem < MAX_INVENTORY_SLOTS + 1) Or (Inventario.SelectedItem = FLAGORO) Then
            
            If Not (Inventario.SelectedItem = FLAGORO) Then
                If Inventario.ObjType(Inventario.SelectedItem) = eObjType.otBarcos Then
                    AccionYesOrNo = 2
                    frmYesOrNo.Show , frmMain
                    Exit Sub
                End If
            End If
        

            If Inventario.amount(Inventario.SelectedItem) = 1 Then
                Call WriteDrop(Inventario.SelectedItem, 1)
            Else
                If Inventario.amount(Inventario.SelectedItem) > 1 Then
                    frmCantidad.IsDrop = False
                    If Not Comerciando Then frmCantidad.Show , frmMain
                End If
            End If
        End If
    End If
End Sub

Private Sub AgarrarItem()
    If UserEstado = 1 Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        End With
    Else
        Call WritePickUp
    End If
End Sub

Private Sub UsarItem(ByVal ByClick As Byte)

    Dim ItemIndex As Integer
    ItemIndex = Inventario.SelectedItem


    If Comerciando Then Exit Sub
    If TrainingMacro.Enabled Then DesactivarMacroHechizos
    If (ItemIndex > 0) And (ItemIndex < MAX_INVENTORY_SLOTS + 1) Then


        Dim ObjIndex As Integer
        ObjIndex = Inventario.ObjIndex(ItemIndex)

        If ObjIndex > 0 Then


            Dim ObjType As Integer
            ObjType = Inventario.ObjType(ItemIndex)

            If ByClick > 0 Then
                If Not MainTimer.Check(TimersIndex.UseItemWithU) Then
                    Exit Sub
                End If
            Else
                If Not MainTimer.Check(TimersIndex.UseItemWithDblClick) Then
                    Exit Sub
                End If
            End If

            Dim TActual As Long
            TActual = GetTime

            If (TActual - LastPocionTick) < IntClickU Then
                Exit Sub
            End If

            LastPocionTick = TActual

            Select Case ObjType
            Case eObjType.otPociones
                'If MainTimer.Check(TimersIndex, False) Then
                If LastPotion <> ItemIndex Then
                    Call WriteUsePotions(ItemIndex, ByClick)
                Else
                    Call WriteLastUsePotions(ByClick)
                End If

                LastPotion = ItemIndex
                'Else
                '    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                '        Call ShowConsoleMsg("¡¡Debes esperar unos momentos para tomar otra poción!!", .red, .green, .blue, .bold, .italic)
                '    End With
                'End If

                Exit Sub
            Case eObjType.otArmadura, eObjType.otcasco, eObjType.otescudo, eObjType.otAnillo, eObjType.otFlechas
                Exit Sub
            Case eObjType.otPergaminos
                If DecryptMAN(UserMaxMAN) < 1 Then
                    With FontTypes(FontTypeNames.FONTTYPE_INFO)
                        Call ShowConsoleMsg("No tienes conocimientos de las Artes Arcanas.", .red, .green, .blue, .bold, .italic)
                    End With
                    Exit Sub
                End If

                Dim LoopC As Long

                For LoopC = 1 To MAXHECHI
                    If UserHechizos(LoopC) = DataObj(ObjIndex).HechizoIndex Then
                        With FontTypes(FontTypeNames.FONTTYPE_INFO)
                            Call ShowConsoleMsg("Ya tienes ese hechizo.", .red, .green, .blue, .bold, .italic)
                        End With
                        Exit Sub
                    End If
                Next LoopC

                'Call SendMessage(hlst.hwnd, WM_VSCROLL, SB_BOTTOM, 0)
            Case eObjType.otMinerales
                UsingSkill = FundirMetal
            End Select

            Call WriteUseItem(ItemIndex)
            LastPotion = ItemIndex

        End If

    End If
End Sub

Private Sub EquiparItem()
    If UserEstado = 1 Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        End With
    Else
        If Comerciando Then Exit Sub

        If (Inventario.SelectedItem > 0) And (Inventario.SelectedItem < MAX_INVENTORY_SLOTS + 1) Then _
           Call WriteEquipItem(Inventario.SelectedItem)
    End If
End Sub

Private Sub timerAntiCuelgue_Timer()
    If IsInIDE = False Then
        If modNetwork.IsConnected Then
            If Not UserCharIndex = 0 Then
                Call WriteTickAntiCuelgue
            End If
            'Call FlushBuffer
        End If
    End If
End Sub

Private Sub TimerPociones_Timer()

    If DuracionPociones > 0 Then
        DuracionPociones = DuracionPociones - 1

        If DuracionPociones < 20 Then
            bLastBrightBlink = Not bLastBrightBlink

            If bLastBrightBlink Then
                frmMain.lblStrg.ForeColor = vbRed
                frmMain.lblDext.ForeColor = vbRed
            Else
                frmMain.lblStrg.ForeColor = getStrenghtColor(UserFuerza)
                frmMain.lblDext.ForeColor = getDexterityColor(UserAgilidad)
            End If

            Select Case DuracionPociones
            Case 3, 5
                With FontTypes(FontTypeNames.FONTTYPE_VIOLETA)
                    Call AddtoRichTextBox(frmMain.RecTxt, "En " & DuracionPociones & " segundos finalizará el efecto de la dopa.", .red, .green, .blue, 0, 0)
                End With
            End Select
        End If
    End If

End Sub

Private Sub tmr_Timer()

    Dim i As Long
    tmr.interval = 600

    For i = 1 To LastChar
        If charlist(i).Invisible Then
            charlist(i).CounterInvi = charlist(i).CounterInvi + 1

            If charlist(i).CounterInvi > 7 Then
                charlist(i).CounterInvi = 0
            End If
        End If
    Next i
End Sub

''''''''''''''''''''''''''''''''''''''
'     HECHIZOS CONTROL               '
''''''''''''''''''''''''''''''''''''''

Private Sub TrainingMacro_Timer()
    If Not hlst.visible Then
        DesactivarMacroHechizos
        Exit Sub
    End If

    'Macros are disabled if focus is not on Argentum!
    If Not Application.IsAppActive() Then
        DesactivarMacroHechizos
        Exit Sub
    End If

    If Comerciando Then Exit Sub

    If hlst.List(hlst.ListIndex) <> "(Vacio)" And MainTimer.Check(TimersIndex.CastSpell, False) Then
        Call WriteCastSpell(hlst.ListIndex + 1)
        Call WriteWork(eSkill.Magia)
    End If

    Call ConvertCPtoTP(MouseX, MouseY, tX, tY)

    If UsingSkill = Magia And Not MainTimer.Check(TimersIndex.CastSpell) Then Exit Sub

    If UsingSkill = Proyectiles And Not MainTimer.Check(TimersIndex.Attack) Then Exit Sub

    Call WriteWorkLeftClick(tX, tY, UsingSkill)
    UsingSkill = 0
End Sub

Private Sub cmdLanzar_Click()

    If hlst.ListIndex < 0 Then Exit Sub

    Dim index As Integer
    index = hlst.ListIndex + 1

    If UserEstado = 1 Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        End With
        Exit Sub
    End If

    If Not ModoCombate Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡No puedes lanzar hechizos si no estas en modo combate!!", .red, .green, .blue, .bold, .italic)
        End With
        Exit Sub
    End If

    If UserHechizos(index) > 0 Then
        If Not MainTimer.Check(TimersIndex.CastSpell, False) Or Not MainTimer.Check(TimersIndex.AttackCast, False) Then
            Exit Sub
        End If

        If SpellCasteado <> index Then
            SpellCasteado = index
            Call WriteWorkMagia(index)
        Else
            Call ShowConsoleMsg(MENSAJE_TRABAJO_MAGIA, 100, 100, 120)
            Call modEngine_Audio.PlayInterface(SND_CLICK)
        End If

    End If
    UsaMacro = True

    If Not MainTimer.Check(TimersIndex.CastAttack, False) Then Exit Sub
    If Not MainTimer.Check(TimersIndex.Attack, False) Then
    Else
        If Not MainTimer.Check(TimersIndex.CastSpell, False) Then
            Exit Sub
        End If
    End If

    'If hlst.List(hlst.ListIndex) <> "(Vacio)" And MainTimer.Check(TimersIndex.Work, False) Then
    '    Call WriteCastSpell(hlst.ListIndex + 1)
    '    Call WriteWork(eSkill.Magia)
    'End If
End Sub

Private Sub CmdLanzar_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    UsaMacro = False
    CnTd = 0

    If tSetup.tdsCursors = False And UsingSkill = False Then
        Me.MousePointer = vbCustom
        UsingSkill = 0
        drag_modo = 0
    End If

End Sub

Private Sub cmdINFO_Click()
    If hlst.ListIndex < 0 Then Exit Sub

    Dim index As Integer
    index = UserHechizos(hlst.ListIndex + 1)

    If index > 0 Then

        Dim ManReq As Integer
        ManReq = DataSpells(index).ManaRequerida

        If UserClase = eClass.Assasin Or UserClase = eClass.Paladin Then
            '    If Index = 10 Then ManReq = ManReq - 50
            '    If Index = 14 Then ManReq = ManReq - 150
        End If

        Dim Msj As String
        Msj = "%%%%%%%%%%%% INFO DEL HECHIZO %%%%%%%%%%%%" & vbCrLf & "Nombre: " & DataSpells(index).nombre & vbCrLf & "Descripción: " & DataSpells(index).Desc & vbCrLf & "Skill requerido: " & DataSpells(index).SkillRequerido & " de magia." & vbCrLf & "Maná necesario: " & ManReq & vbCrLf & "Energía necesaria: " & DataSpells(index).EnergiaRequerida & vbCrLf & "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"

        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg(Msj, .red, .green, .blue, .bold, .italic)
        End With

        Call modEngine_Audio.PlayInterface(SND_CLICK)
    End If
End Sub

Private Sub Form_Click()

    If SendTxt.visible Then SendTxt.SetFocus
    If MostrarMapa Then MostrarMapa = False
    If Cartel Then Cartel = False
    If Not Comerciando Then

        Call ConvertCPtoTP(MouseX, MouseY, tX, tY)

        If (Abs(UserPos.Y - tY) > 6) Or (Abs(UserPos.X - tX) > 8) Then Exit Sub

        If MouseShift = 0 Then
            If MouseBoton <> vbRightButton Then
                '[ybarra]
                If UsaMacro Then
                    CnTd = CnTd + 1
                    If CnTd = 3 Then
                        Call WriteUseSpellMacro
                        CnTd = 0
                    End If
                    UsaMacro = False
                End If

                If SpellCasteado > 0 Then
                    LastSpell = SpellCasteado
                    SpellCasteado = 0

                    LastMAN = UserMinMAN
                End If

                '[/ybarra]
                If UsingSkill = 0 Then
                    Call WriteLeftClick(tX, tY)
                Else

                    If TrainingMacro.Enabled Then Call DesactivarMacroHechizos
                    If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo

                    If UsingSkill = Proyectiles Then
                        If Not MainTimer.Check(TimersIndex.Arrows) Then
                            frmMain.MousePointer = vbDefault
                            UsingSkill = 0
                            Exit Sub
                        End If
                    End If


                    If UsingSkill = Magia Then
                        If Not MainTimer.Check(TimersIndex.CastAttack, False) Then
                            frmMain.MousePointer = vbDefault
                            UsingSkill = 0
                            Exit Sub
                        End If
                        If Not MainTimer.Check(TimersIndex.CastSpell, True) Then        'Check if spells interval has finished.
                            frmMain.MousePointer = vbDefault
                            UsingSkill = 0
                            Exit Sub
                        End If

                    End If
                    'Splitted because VB isn't lazy!
                    If (UsingSkill = Pesca Or UsingSkill = Robar Or UsingSkill = Talar Or UsingSkill = Mineria Or UsingSkill = FundirMetal) Then
                        If Not MainTimer.Check(TimersIndex.Work) Then
                            frmMain.MousePointer = vbDefault
                            UsingSkill = 0
                            Exit Sub
                        End If
                    End If

                    If frmMain.MousePointer <> 2 Then Exit Sub        'Parcheo porque a veces tira el hechizo sin tener el cursor (NicoNZ)

                    frmMain.MousePointer = vbDefault



                    ' @@ Juancito extraction
                    If UsingSkill = eSkill.Magia Then
                        If MapData(tX, tY).CharIndex < 1 And MapData(tX, tY + 1).CharIndex < 1 Then
                            Dim LoopX As Long
                            Dim LoopY As Long

                            'Comentar esto >> Trigger bot para testear
                            '     For LoopX = tX - 3 To tX + 3
                            '         For LoopY = tY - 3 To tY + 3
                            '             If MapData(LoopX, LoopY).CharIndex > 0 Then
                            '                 If Not MapData(LoopX, LoopY).CharIndex = UserCharIndex Then
                            '                     tX = LoopX
                            '                     tY = LoopY
                            '                     Exit For
                            '                 End If
                            '             End If
                            '         Next LoopY
                            '     Next LoopX

                            Call WriteWorkMagiaClick(tX, tY, 1)
                        Else
                            Call WriteWorkMagiaClick(tX, tY, 0)
                        End If
                    Else
                        Call WriteWorkLeftClick(tX, tY, UsingSkill)
                    End If

                    'Original:Call WriteWorkLeftClick(tX, tY, UsingSkill)

                    UsingSkill = 0
                End If
            End If
        ElseIf (MouseShift And 1) = 1 Then
            If Not Teclas.KeyAssigned(KeyCodeConstants.vbKeyShift) And esGM(UserCharIndex) Then
                If MouseBoton = vbLeftButton Then
                    Call WriteWarpChar("YO", UserMap, tX, tY)
                End If
            End If
        End If
    End If
End Sub

Private Sub Form_DblClick()

    If MostrarMapa Then MostrarMapa = False

    If Not Comerciando Then
        Call WriteDoubleClick(tX, tY)
    End If
End Sub

Private Sub hlst_KeyDown(KeyCode As Integer, Shift As Integer)
'KeyCode = 0
End Sub

Private Sub hlst_KeyPress(KeyAscii As Integer)
' KeyAscii = 0
End Sub

Private Sub hlst_KeyUp(KeyCode As Integer, Shift As Integer)
' KeyCode = 0
End Sub

Private Sub lblDropGold_Click()

    If UserGLD > 0 Then
        Inventario.SelectGold
        If Not Comerciando Then frmCantidad.Show , frmMain
    End If

End Sub

Public Sub Label4_Click()

    Panel = eVentanas.vInventario

    If Panel <> LastPanel Then
        LastPanel = Panel
        Call WriteMenuCliente(Inventario.SelectedItem)

        Call forms_load_pic(InvEqu, "979.bmp")

        Call modEngine_Audio.PlayInterface(SND_CLICK)

        If picInv.visible Then Exit Sub
        ' Activo controles de inventario
        picInv.visible = True

        ' Desactivo controles de hechizo
        hlst.visible = False
        cmdInfo.visible = False
        CmdLanzar.visible = False

        cmdMoverHechi(0).visible = False
        cmdMoverHechi(1).visible = False
        lblDD.visible = True
        lblSeguro.visible = True
        lblMSN.visible = True
    End If

End Sub

Public Sub SetInventory()
    Call forms_load_pic(InvEqu, "979.bmp")

    If picInv.visible Then Exit Sub
    ' Activo controles de inventario
    picInv.visible = True
    ' Desactivo controles de hechizo
    hlst.visible = False
    cmdInfo.visible = False
    CmdLanzar.visible = False
    cmdMoverHechi(0).visible = False
    cmdMoverHechi(1).visible = False
    lblDD.visible = True
    lblSeguro.visible = True
    lblMSN.visible = True
End Sub

Private Sub Label7_Click()

    Panel = eVentanas.vHechizos

    If Panel <> LastPanel Then
        'If hlst.Visible Then Exit Sub
        LastPanel = Panel

        Call modEngine_Audio.PlayInterface(SND_CLICK)
        Call WriteMenuCliente(Inventario.SelectedItem)


        Call forms_load_pic(InvEqu, "978.bmp", False)

        ' Activo controles de hechizos
        hlst.visible = True
        cmdInfo.visible = True
        CmdLanzar.visible = True

        cmdMoverHechi(0).visible = True
        cmdMoverHechi(1).visible = True

        ' Desactivo controles de inventario
        picInv.visible = False
        'imgInvScrollUp.Visible = False
        'imgInvScrollDown.Visible = False
        lblDD.visible = False
        lblMSN.visible = False
        lblSeguro.visible = False
    End If
End Sub

Private Sub picInv_DblClick()


    If (MOUSE_DOWN <> False) And MOUSE_UP Then
        Exit Sub
    End If


    Dim ValidAction As Boolean
    ValidAction = (GetAsyncKeyState(vbKeyRButton) < 0)

    If ValidAction Then
        Exit Sub
    End If






    If picInv.visible = False Then Exit Sub

    If frmCarp.visible Or frmHerrero.visible Then Exit Sub

    If macrotrabajo.Enabled Then Call DesactivarMacroTrabajo

    If Inventario.SelectedItem > 0 Then
        Dim tObj As eObjType
        If Inventario.ObjIndex(Inventario.SelectedItem) = 0 Then
            Exit Sub
        End If

        tObj = DataObj(Inventario.ObjIndex(Inventario.SelectedItem)).ObjType

        Select Case tObj
        Case eObjType.otAnillo, eObjType.otAnillo2, eObjType.otArmadura, eObjType.otcasco, eObjType.otescudo, eObjType.otFlechas    ', eObjType.otWeapon
            'Call EquiparItem
            Exit Sub
        Case eObjType.otWeapon
            If InStr(1, DataObj(Inventario.ObjIndex(Inventario.SelectedItem)).nombre, "Arco") = 0 Then
                Exit Sub
            End If

        End Select

    End If

    Call UsarItem(0)


End Sub


Private Sub RecTxt_Change()
    On Error Resume Next        'el .SetFocus causaba errores al salir y volver a entrar

    If Not Application.IsAppActive() Then Exit Sub


    If SendTxt.visible Then
        SendTxt.SetFocus
    ElseIf Me.SendCMSTXT.visible Then
        SendCMSTXT.SetFocus
    ElseIf (Not Comerciando) And (Not MirandoAsignarSkills) And (Not frmRetos.visible) And (Not frmBuscar.visible) And _
           (Not frmCantidad.visible) Then

        If picInv.visible Then
            picInv.SetFocus
        ElseIf hlst.visible Then
            ' hlst.SetFocus
        End If
    End If

    RecTxt.SelStart = Len(RecTxt.Text)

    'RecTxt.Locked = True
End Sub

Private Sub RecTxt_KeyDown(KeyCode As Integer, Shift As Integer)
    If picInv.visible Then
        picInv.SetFocus
    Else
        'hlst.SetFocus
    End If
End Sub

Private Sub SendTxt_Change()
'**************************************************************
'Author: Unknown
'Last Modify Date: 3/06/2006
'3/06/2006: Maraxus - impedí se inserten caractéres no imprimibles
'**************************************************************
    If Len(SendTxt.Text) > 160 Then
        stxtbuffer = "Soy un cheater, avisenle a un gm"
    Else
        'Make sure only valid chars are inserted (with Shift + Insert they can paste illegal chars)
        Dim i As Long
        Dim tempstr As String
        Dim CharAscii As Integer

        For i = 1 To Len(SendTxt.Text)
            CharAscii = Asc(mid$(SendTxt.Text, i, 1))
            If CharAscii >= vbKeySpace And CharAscii <= 250 Then
                tempstr = tempstr & Chr$(CharAscii)
            End If
        Next i

        If tempstr <> SendTxt.Text Then
            'We only set it if it's different, otherwise the event will be raised
            'constantly and the client will crush
            SendTxt.Text = tempstr
        End If

        stxtbuffer = SendTxt.Text
    End If
End Sub

Private Sub SendTxt_KeyPress(KeyAscii As Integer)

'    If KeyAscii <> vbKeySpace Then
'    KeyAscii = 0
'    Exit Sub
' End If

    If Not (KeyAscii = vbKeyBack) And Not (KeyAscii >= vbKeySpace And KeyAscii <= 250) Then KeyAscii = 0

    SendTxt.Text = stxtbuffer

End Sub

Private Sub SendCMSTXT_KeyUp(KeyCode As Integer, Shift As Integer)
'Send text
    If KeyCode = vbKeyReturn Then
        'Say
        If stxtbuffercmsg <> "" Then
            Call ParseUserCommand("/CMSG " & stxtbuffercmsg)
        End If

        stxtbuffercmsg = ""
        SendCMSTXT.Text = ""
        KeyCode = 0
        Me.SendCMSTXT.visible = False

        If picInv.visible Then
            picInv.SetFocus
        Else
            'hlst.SetFocus
        End If
    End If
End Sub

Private Sub SendCMSTXT_KeyPress(KeyAscii As Integer)
    If Not (KeyAscii = vbKeyBack) And _
       Not (KeyAscii >= vbKeySpace And KeyAscii <= 250) Then _
       KeyAscii = 0
End Sub

Private Sub SendCMSTXT_Change()
    If Len(SendCMSTXT.Text) > 160 Then
        stxtbuffercmsg = "Soy un cheater, avisenle a un GM"
    Else
        'Make sure only valid chars are inserted (with Shift + Insert they can paste illegal chars)
        Dim i As Long
        Dim tempstr As String
        Dim CharAscii As Integer

        For i = 1 To Len(SendCMSTXT.Text)
            CharAscii = Asc(mid$(SendCMSTXT.Text, i, 1))
            If CharAscii >= vbKeySpace And CharAscii <= 250 Then
                tempstr = tempstr & Chr$(CharAscii)
            End If
        Next i

        If tempstr <> SendCMSTXT.Text Then
            'We only set it if it's different, otherwise the event will be raised
            'constantly and the client will crush
            SendCMSTXT.Text = tempstr
        End If

        stxtbuffercmsg = SendCMSTXT.Text
    End If
End Sub

Private Sub picInv_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next

    ' @@ Mouse Button
    MOUSE_DOWN = True
    MOUSE_UP = False


    If Inventario.SelectedItem < 1 Then Exit Sub
    If Inventario.SelectedItem > Inventario.MaxItems Then Exit Sub
    If drag_modo <> 0 Then Exit Sub
    If UserEstado = 1 Then Exit Sub

    If Button = vbRightButton Then
        If (Inventario.GrhIndex(Inventario.SelectedItem) > 0) Then
            last_i = Inventario.SelectedItem
            drag_modo = 1
            obj_drag = Inventario.SelectedItem

            Dim i As Integer
            i = GrhData(Inventario.GrhIndex(obj_drag)).FileNum

            Dim Buffer As Long
            Dim bmpInfo As BITMAPINFO
            Dim BufferBMP As Long
            Dim Data() As Byte

            'get Bitmap
            Call Get_Bitmap(App.Path & "\GRAFICOS\", LCase$(CStr(i) & ".bmp"), bmpInfo, Data)

            BufferBMP = CreateCompatibleDC(picInv.hdc)
            Buffer = CreateCompatibleBitmap(picInv.hdc, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight)
            SelectObject BufferBMP, Buffer

            Call SetDIBitsToDevice(BufferBMP, 0, 0, bmpInfo.bmiHeader.biWidth, bmpInfo.bmiHeader.biHeight, 0, 0, 0, bmpInfo.bmiHeader.biHeight, Data(0), bmpInfo, DIB_RGB_COLORS)

            Set Me.MouseIcon = GetIcon(BufferBMP, 0, 0, Halftone, True, vbBlack)
            Me.MousePointer = vbCustom
        End If
    End If

End Sub

Private Sub picInv_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)


    If Not MOUSE_DOWN Then Exit Sub

    MOUSE_DOWN = False
    MOUSE_UP = True

    Call modEngine_Audio.PlayInterface(SND_CLICK)

End Sub


Private Sub MainViewPic_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    MouseX = X
    MouseY = Y


    '    LastPressed.ToggleToNormal

    If drag_modo <> 0 And Button <> vbRightButton Then
        Call ConvertCPtoTP(MouseX, MouseY, tX, tY)
        DragX = tX
        DragY = tY
        Call m_DragAndDrop.General_Drop_X_Y
        Me.MousePointer = vbDefault

        UsingSkill = 0
        drag_modo = 0
    End If
End Sub


Private Sub InvEqu_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'    LastPressed.ToggleToNormal

'If tSetup.tdsCursors = False And UsingSkill = False Then
'    Me.MousePointer = 0
'End If

    If drag_modo <> 0 And Button <> vbRightButton Then
        Me.MousePointer = vbDefault
        UsingSkill = 0
        drag_modo = 0
    End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    StopCheckingLinks

    If lblMapName.visible = False And Not StickCoord Then
        lblMapName.visible = True
        Coord.visible = False
    End If

    If lblPorcLvl(0).visible = True And Not StickPorc Then
        Dim xs As Long
        For xs = 0 To 8
            lblPorcLvl(xs).visible = False
            lblLvl(xs).visible = True
        Next xs
    End If
    If drag_modo <> 0 And Button <> vbRightButton Then
        Call ConvertCPtoTP(MouseX, MouseY, tX, tY)
        DragX = tX
        DragY = tY
        Call m_DragAndDrop.General_Drop_X_Y
        Me.MousePointer = vbDefault

        UsingSkill = 0
        drag_modo = 0
    End If

    MouseX = X - MainViewPic.Left
    MouseY = Y - MainViewPic.Top

    'Trim to fit screen
    If MouseX < 0 Then
        MouseX = 0
    ElseIf MouseX > MainViewPic.Width Then
        MouseX = MainViewPic.Width
    End If

    'Trim to fit screen
    If MouseY < 0 Then
        MouseY = 0
    ElseIf MouseY > MainViewPic.Height Then
        MouseY = MainViewPic.Height
    End If

    '    LastPressed.ToggleToNormal

End Sub


Public Sub OnClientDisconnect(ByVal Error As Long)
    On Error GoTo OnClientDisconnect_Err

    ModoCaida = 0

    If (Error = 10061) Then
        If frmCrearPersonaje.visible = True Then
            Call MsgBox("¡No se pudo conectar con el servidor! Te recomiendo verificar el estado del juego en la web.")
            Unload frmCrearPersonaje
        ElseIf frmConnect.visible = True Then
            Call MsgBox("¡No se pudo conectar con el servidor! Te recomiendo verificar el estado del juego en la web.")

            If frmOldPersonaje.visible = True Then
                frmOldPersonaje.Label1.visible = False
            End If

            If frmOldPersonaje.visible Then
                Unload frmOldPersonaje
            End If

        Else
            'Call MsgBox("Ha ocurrido un error al conectar con el servidor. Le recomendamos verificar el estado de los servidores y asegurarse de estar conectado directamente a internet", vbApplicationModal + vbInformation + vbOKOnly + vbDefaultButton1, "Error al conectar")
        End If
    Else

        frmConnect.MousePointer = 1

        If (Error <> 0 And Error <> 2) Then
            If frmConnect.visible Then
                Connected = False

            Else
                If (Connected) Then
                    Call HandleDisconnect
                End If
            End If

        Else
            If frmConnect.visible Then
                Connected = False

                If frmOldPersonaje.visible Then
                    Unload frmOldPersonaje
                End If

            Else
                If (Connected) Then
                    Call HandleDisconnect
                End If
            End If
        End If
    End If

    Exit Sub

OnClientDisconnect_Err:
    Call RegistrarError(Err.Number, Err.Description, "frmMain.OnClientDisconnect", Erl)
    Resume Next
End Sub
