VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.1#0"; "MSCOMCTL.OCX"
Begin VB.Form frmOpcionesDx8 
   Caption         =   "Más opciones"
   ClientHeight    =   4380
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   4260
   LinkTopic       =   "Form2"
   Picture         =   "frmOpcionesDx8.frx":0000
   ScaleHeight     =   4380
   ScaleWidth      =   4260
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check8 
      Caption         =   "Movimiento al hablar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   2760
      Width           =   3975
   End
   Begin MSComctlLib.Slider Slider1 
      Height          =   495
      Left            =   1560
      TabIndex        =   8
      Top             =   3120
      Width           =   2655
      _ExtentX        =   4683
      _ExtentY        =   873
      _Version        =   393216
      Min             =   1
      SelStart        =   10
      Value           =   10
   End
   Begin VB.CheckBox Check7 
      Caption         =   "Sincronización Vertical(Puede funcionar mal en algunas PC's)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   2280
      Width           =   3975
   End
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   495
      Left            =   120
      TabIndex        =   6
      Top             =   3720
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   873
      Caption         =   "Aceptar"
      CapAlign        =   2
      BackStyle       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Mode            =   0
      Value           =   0   'False
      cBack           =   -2147483633
   End
   Begin VB.CheckBox Check1 
      Caption         =   "No FullScreen"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   1575
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Árboles con transparencia"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   480
      Width           =   2655
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Efectos de combate"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   2055
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Limitar fps"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   1200
      Width           =   1335
   End
   Begin VB.CheckBox Check5 
      Caption         =   "Efecto noche"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   1560
      Width           =   1575
   End
   Begin VB.CheckBox Check6 
      Caption         =   "AlphaBlending(Hechizos, meditaciones,etc)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   1920
      Width           =   4095
   End
   Begin VB.Label Label1 
      Caption         =   "Brillo del juego"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   3240
      Width           =   1335
   End
End
Attribute VB_Name = "frmOpcionesDx8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim settingFile As String
Private Sub Check1_Click()
    Call WriteVar(settingFile, "Init", "NoFullScreen", Check1.Value)
End Sub

Private Sub Check2_Click()
    Call WriteVar(settingFile, "Init", "TreeTransparence", Check2.Value)
    
End Sub

Private Sub Check3_Click()
    Call WriteVar(settingFile, "Init", "FightingEfects", Check3.Value)
End Sub

Private Sub Check4_Click()
    Call WriteVar(settingFile, "Init", "FpsLimit", Check4.Value)
End Sub

Private Sub Check5_Click()
    Call WriteVar(settingFile, "Init", "Night", Check5.Value)
    Call LoadIni
End Sub

Private Sub Check6_Click()
    Call WriteVar(settingFile, "Init", "AlphaBlending", Check6.Value)
End Sub

Private Sub Check7_Click()
Call WriteVar(settingFile, "Init", "VSync", Check7.Value)
End Sub


Private Sub Check8_Click()
    MovimientoHablar = (Check8.Value = 1)
End Sub

Private Sub Form_Load()
    settingFile = App.path & "/init/Settings.ini"
    Check1.Value = Val(GetVar(settingFile, "Init", "NoFullScreen"))
    Check2.Value = Val(GetVar(settingFile, "Init", "TreeTransparence"))
    Check3.Value = Val(GetVar(settingFile, "Init", "FightingEfects"))
    Check4.Value = Val(GetVar(settingFile, "Init", "FpsLimit"))
    Check5.Value = Val(GetVar(settingFile, "Init", "Night"))
    Check6.Value = Val(GetVar(settingFile, "Init", "AlphaBlending"))
    Check7.Value = Val(GetVar(settingFile, "Init", "VSync"))
    Set Me.Picture = Nothing
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Call LoadIni
End Sub

Private Sub lvButtons_H1_Click()
    Unload Me
End Sub

Private Sub Form_Activate()
        Slider1.Value = MaxAlpha / 25#
    Check8.Value = IIf(MovimientoHablar = True, 1, 0)
End Sub


Private Sub Slider1_Change()
MaxAlpha = Slider1.Value * 25.5
End Sub

Private Sub Slider1_Click()
    MaxAlpha = Slider1.Value * 25.5
End Sub

Private Sub Slider1_Scroll()
MaxAlpha = Slider1.Value * 25.5
End Sub
