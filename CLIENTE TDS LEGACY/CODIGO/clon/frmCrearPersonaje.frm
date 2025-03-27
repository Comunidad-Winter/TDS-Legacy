VERSION 5.00
Begin VB.Form frmCrearPersonaje 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "CrearPersonaje"
   ClientHeight    =   9000
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12000
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox lstAlienacion 
      BackColor       =   &H00000000&
      Enabled         =   0   'False
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
      Height          =   315
      Left            =   12720
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   9120
      Visible         =   0   'False
      Width           =   2625
   End
   Begin VB.PictureBox MainViewPic 
      BackColor       =   &H00404040&
      BorderStyle     =   0  'None
      Height          =   9000
      Left            =   0
      ScaleHeight     =   600
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   800
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   12000
      Begin VB.Timer Timer1 
         Interval        =   1500
         Left            =   0
         Top             =   0
      End
      Begin VB.Image imgCambiaSexo 
         Height          =   525
         Index           =   1
         Left            =   3720
         Top             =   3615
         Width           =   1575
      End
      Begin VB.Image imgCambiaSexo 
         Height          =   405
         Index           =   0
         Left            =   3720
         Top             =   3210
         Width           =   1575
      End
      Begin VB.Image imgCambiaClase 
         Height          =   495
         Index           =   1
         Left            =   1920
         Top             =   4200
         Width           =   1335
      End
      Begin VB.Image imgCambiaClase 
         Height          =   495
         Index           =   0
         Left            =   600
         Top             =   4200
         Width           =   1335
      End
      Begin VB.Image imgCambiaRaza 
         Height          =   495
         Index           =   1
         Left            =   4500
         Top             =   2640
         Width           =   495
      End
      Begin VB.Image imgCambiaRaza 
         Height          =   495
         Index           =   0
         Left            =   4005
         Top             =   2640
         Width           =   495
      End
      Begin VB.Label lblAtributos 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "18"
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
         Height          =   195
         Index           =   1
         Left            =   8400
         TabIndex        =   34
         Top             =   600
         Width           =   225
      End
      Begin VB.Label lblAtributos 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "18"
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
         Height          =   195
         Index           =   2
         Left            =   8400
         TabIndex        =   33
         Top             =   960
         Width           =   225
      End
      Begin VB.Label lblAtributos 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "18"
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
         Height          =   195
         Index           =   3
         Left            =   8400
         TabIndex        =   32
         Top             =   1320
         Width           =   225
      End
      Begin VB.Label lblAtributos 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "18"
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
         Height          =   195
         Index           =   4
         Left            =   8400
         TabIndex        =   31
         Top             =   1680
         Width           =   225
      End
      Begin VB.Label lblAtributos 
         Alignment       =   1  'Right Justify
         BackStyle       =   0  'Transparent
         Caption         =   "18"
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
         Height          =   195
         Index           =   5
         Left            =   8400
         TabIndex        =   30
         Top             =   2040
         Width           =   225
      End
      Begin VB.Image imgTirarDados 
         Height          =   1125
         Left            =   9360
         MousePointer    =   99  'Custom
         Top             =   840
         Width           =   1560
      End
      Begin VB.Image imgCrear 
         Height          =   675
         Left            =   8280
         Top             =   8400
         Width           =   2145
      End
      Begin VB.Image imgVolver 
         Height          =   675
         Left            =   960
         Top             =   8400
         Width           =   1875
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   3
         Left            =   10065
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   5
         Left            =   10065
         MousePointer    =   99  'Custom
         Top             =   7290
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   7
         Left            =   2580
         MousePointer    =   99  'Custom
         Top             =   7245
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   9
         Left            =   7350
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   11
         Left            =   2580
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   13
         Left            =   7350
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   15
         Left            =   10065
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   17
         Left            =   10065
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   19
         Left            =   5460
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   21
         Left            =   5460
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   23
         Left            =   10065
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   25
         Left            =   7350
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   27
         Left            =   2580
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   1
         Left            =   7350
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   0
         Left            =   7830
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   2
         Left            =   10500
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   4
         Left            =   10500
         MousePointer    =   99  'Custom
         Top             =   7305
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   6
         Left            =   3075
         MousePointer    =   99  'Custom
         Top             =   7275
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   8
         Left            =   7830
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   10
         Left            =   3075
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   390
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   12
         Left            =   7830
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   14
         Left            =   10500
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   16
         Left            =   10500
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   255
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   18
         Left            =   5940
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   20
         Left            =   5940
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   22
         Left            =   10500
         MousePointer    =   99  'Custom
         Top             =   5760
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   24
         Left            =   7830
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   26
         Left            =   3075
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   28
         Left            =   5940
         MousePointer    =   99  'Custom
         Top             =   7365
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   29
         Left            =   5460
         MousePointer    =   99  'Custom
         Top             =   7350
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   30
         Left            =   5940
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   31
         Left            =   5460
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   32
         Left            =   5940
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   33
         Left            =   5460
         MousePointer    =   99  'Custom
         Top             =   6810
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   34
         Left            =   3075
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   35
         Left            =   2580
         MousePointer    =   99  'Custom
         Top             =   6285
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   36
         Left            =   3075
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   37
         Left            =   2580
         MousePointer    =   99  'Custom
         Top             =   7800
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   38
         Left            =   7830
         MousePointer    =   99  'Custom
         Top             =   7380
         Width           =   270
      End
      Begin VB.Image command1 
         Height          =   315
         Index           =   39
         Left            =   7350
         MousePointer    =   99  'Custom
         Top             =   7335
         Width           =   270
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   20
         Left            =   7650
         TabIndex        =   29
         Top             =   7365
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   19
         Left            =   2925
         TabIndex        =   28
         Top             =   7875
         Width           =   270
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   210
         Index           =   18
         Left            =   2925
         TabIndex        =   27
         Top             =   6315
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Index           =   17
         Left            =   5775
         TabIndex        =   26
         Top             =   6870
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   225
         Index           =   16
         Left            =   5775
         TabIndex        =   25
         Top             =   7875
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   240
         Index           =   15
         Left            =   5775
         TabIndex        =   24
         Top             =   7395
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   240
         Index           =   14
         Left            =   2925
         TabIndex        =   23
         Top             =   6870
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   180
         Index           =   13
         Left            =   7650
         TabIndex        =   22
         Top             =   6885
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   210
         Index           =   12
         Left            =   10350
         TabIndex        =   21
         Top             =   5835
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   240
         Index           =   11
         Left            =   5775
         TabIndex        =   20
         Top             =   6345
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   10
         Left            =   5775
         TabIndex        =   19
         Top             =   5880
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   9
         Left            =   10350
         TabIndex        =   18
         Top             =   7875
         Width           =   270
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Index           =   8
         Left            =   10350
         TabIndex        =   17
         Top             =   6900
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   7
         Left            =   7650
         TabIndex        =   16
         Top             =   7920
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   240
         Index           =   6
         Left            =   2925
         TabIndex        =   15
         Top             =   5850
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   240
         Index           =   5
         Left            =   7650
         TabIndex        =   14
         Top             =   6375
         Width           =   150
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   180
         Index           =   4
         Left            =   2925
         TabIndex        =   13
         Top             =   7365
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   210
         Index           =   3
         Left            =   10350
         TabIndex        =   12
         Top             =   7395
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   1
         Left            =   7650
         TabIndex        =   11
         Top             =   5850
         Width           =   135
      End
      Begin VB.Label Skill 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   2
         Left            =   10350
         TabIndex        =   10
         Top             =   6360
         Width           =   135
      End
      Begin VB.Label Puntos 
         BackStyle       =   0  'Transparent
         Caption         =   "Skills disponibles:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Left            =   3720
         TabIndex        =   9
         Top             =   8520
         Width           =   2655
      End
   End
   Begin VB.Label Skill 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   22
      Left            =   14220
      TabIndex        =   8
      Top             =   4800
      Width           =   270
   End
   Begin VB.Image command1 
      Height          =   135
      Index           =   43
      Left            =   14040
      MousePointer    =   99  'Custom
      Top             =   4845
      Width           =   135
   End
   Begin VB.Image command1 
      Height          =   135
      Index           =   42
      Left            =   14595
      MousePointer    =   99  'Custom
      Top             =   4875
      Width           =   165
   End
   Begin VB.Label Skill 
      BackStyle       =   0  'Transparent
      Caption         =   "0"
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   21
      Left            =   14280
      TabIndex        =   7
      Top             =   4515
      Width           =   270
   End
   Begin VB.Image command1 
      Height          =   135
      Index           =   41
      Left            =   14100
      MousePointer    =   99  'Custom
      Top             =   4560
      Width           =   135
   End
   Begin VB.Image command1 
      Height          =   135
      Index           =   40
      Left            =   14655
      MousePointer    =   99  'Custom
      Top             =   4590
      Width           =   165
   End
   Begin VB.Label lblModRaza 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "+0"
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
      Height          =   195
      Index           =   5
      Left            =   14430
      TabIndex        =   6
      Top             =   8670
      Width           =   225
   End
   Begin VB.Label lblModRaza 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "+0"
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
      Height          =   195
      Index           =   4
      Left            =   14430
      TabIndex        =   5
      Top             =   8310
      Width           =   225
   End
   Begin VB.Label lblModRaza 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "+0"
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
      Height          =   195
      Index           =   3
      Left            =   14430
      TabIndex        =   4
      Top             =   7965
      Width           =   225
   End
   Begin VB.Label lblModRaza 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "+0"
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
      Height          =   195
      Index           =   2
      Left            =   14430
      TabIndex        =   3
      Top             =   7620
      Width           =   225
   End
   Begin VB.Label lblModRaza 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "+0"
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
      Height          =   195
      Index           =   1
      Left            =   14430
      TabIndex        =   2
      Top             =   7290
      Width           =   225
   End
   Begin VB.Image imgConstitucion 
      Height          =   255
      Left            =   14325
      Top             =   8385
      Width           =   1080
   End
   Begin VB.Image imgCarisma 
      Height          =   240
      Left            =   14475
      Top             =   8040
      Width           =   765
   End
   Begin VB.Image imgInteligencia 
      Height          =   240
      Left            =   14370
      Top             =   7710
      Width           =   1005
   End
   Begin VB.Image imgAgilidad 
      Height          =   240
      Left            =   14460
      Top             =   7365
      Width           =   735
   End
   Begin VB.Image imgFuerza 
      Height          =   240
      Left            =   14490
      Top             =   7020
      Width           =   675
   End
   Begin VB.Image imgF 
      Height          =   270
      Left            =   14895
      Top             =   6915
      Width           =   270
   End
   Begin VB.Image imgM 
      Height          =   270
      Left            =   14430
      Top             =   6915
      Width           =   270
   End
   Begin VB.Image imgD 
      Height          =   270
      Left            =   14640
      Top             =   7560
      Width           =   270
   End
   Begin VB.Image Image1 
      Height          =   3120
      Left            =   8880
      Stretch         =   -1  'True
      Top             =   9120
      Visible         =   0   'False
      Width           =   2475
   End
   Begin VB.Image imgHogar 
      Height          =   2850
      Left            =   5640
      Top             =   9120
      Visible         =   0   'False
      Width           =   2985
   End
End
Attribute VB_Name = "frmCrearPersonaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Mx As Integer
Public mY As Integer
Public mb As Integer

Public Gs As Integer
Public SkillPoints As Byte

Private Type tModRaza
    Fuerza As Single
    Agilidad As Single
    Inteligencia As Single
    Carisma As Single
    Constitucion As Single
End Type

Private Type tModClase
    Evasion As Double
    AtaqueArmas As Double
    AtaqueProyectiles As Double
    DañoArmas As Double
    DañoProyectiles As Double
    Escudo As Double
    Magia As Double
    Vida As Double
    Hit As Double
End Type

Private Cargando As Boolean

Private Const GUI_ID As Byte = 5

Private Sub Command1_Click(index As Integer)
    If PanelCrearPJVisible Then GUI_Click: Exit Sub

    Call modEngine_Audio.PlayInterface(SND_CLICK)
    Dim PT As Single
    PT = index / 2 + 1
    PT = Fix(PT)

    If (index And &H1) = 0 Then
        If SkillPoints > 0 Then
            SumarSkillPoint PT
        End If
    Else
        If SkillPoints < 10 Then
            RestarSkillPoint PT
        End If
    End If
End Sub

Private Sub command1_DblClick(index As Integer)
    If PanelCrearPJVisible Then GUI_Click (True): Exit Sub
End Sub

Private Sub imgCambiaClase_Click(index As Integer)
    If PanelCrearPJVisible Then Exit Sub
    If index = 0 Then
        UserClase = UserClase - 1

        If UserClase < 1 Then
            UserClase = NUMCLASES
        End If
    Else
        UserClase = UserClase + 1

        If UserClase > NUMCLASES Then
            UserClase = 1
        End If
    End If

End Sub

Private Sub imgCambiaRaza_Click(index As Integer)
    If PanelCrearPJVisible Then Exit Sub
    If index = 0 Then
        UserRaza = UserRaza - 1
        If UserRaza < 1 Then
            UserRaza = NUMRAZAS
        End If
    Else
        UserRaza = UserRaza + 1
        If UserRaza > NUMRAZAS Then
            UserRaza = 1
        End If
    End If

    CPJ_UpdateBodyAndHead

End Sub

Private Sub imgCambiaSexo_Click(index As Integer)
    If PanelCrearPJVisible Then Exit Sub
    If index = 1 Then
        UserSexo = eGenero.Hombre
    Else
        UserSexo = eGenero.Mujer
    End If
    CPJ_UpdateBodyAndHead

End Sub

Private Sub MainViewPic_Click()
    Call mod_Gui.GUI_Click
End Sub

Private Sub MainViewPic_KeyPress(KeyAscii As Integer)
    Form_KeyPress KeyAscii
End Sub
Private Sub MainViewPic_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Mx = X
    mY = Y
    mb = Button
End Sub

Private Sub MainViewPic_DblClick()
    Call mod_Gui.GUI_Click(True)
End Sub

Private Sub MainViewPic_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyEscape Then
        If PanelCrearPJVisible Then
            Call IniciarCaida(1)
        End If
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

    If PanelCrearPJVisible = False Then Exit Sub

    mod_Gui.CrearPJ_KeyPress KeyAscii

    Dim i As Long

    If KeyAscii = vbKeyTab Then
        If GuiTxt(7).HasFocus Then
            GuiTxt(7).HasFocus = False
            GuiTxt(3).HasFocus = True
            KeyAscii = 0
            Exit Sub
        Else
            For i = 3 To 6
                If GuiTxt(i).HasFocus Then
                    GuiTxt(i + 1).HasFocus = True
                    GuiTxt(i).HasFocus = False
                    KeyAscii = 0
                    Exit Sub
                End If
            Next i
        End If
    End If

End Sub

Private Sub Form_Load()

    If UserCharIndex > 0 Then Exit Sub
    Me.visible = False

    Call forms_load_pic(Me.MainViewPic, "10007.bmp")
    'Me.Visible = True

    SkillPoints = 10
    GuiTexto(28).Texto = "Skillpoints libres: " & SkillPoints

    GuiTxt(7).Texto = ""
    UserPin = ""
    UserPassword = ""
    GuiTxt(6).Texto = ""
    GuiTxt(5).Texto = ""
    GuiTxt(5).PassTmp = ""
    GuiTxt(6).PassTmp = ""
    GuiTxt(7).PassTmp = ""

    resetGuiData
    Cargando = True
    PanelCrearPJVisible = False

    If frmCrearPersonaje.visible Then
        Call TirarDados
    End If

    Cargando = False

    UserEmail = "@"
    UserClase = eClass.Assasin
    UserSexo = eGenero.Hombre
    UserRaza = eRaza.Humano
    UserHogar = cUllathorpe

    CPJ_UpdateBodyAndHead
    CPJ_heading = E_Heading.SOUTH

    Set MainViewPic.Picture = Nothing

End Sub
Private Sub TirarDados()
' Call WriteThrowDices
'Call FlushBuffer
End Sub

Function CheckData() As Boolean

    GuiTxt(7).Texto = Trim$(GuiTxt(7).Texto)
    GuiTxt(5).Texto = Trim$(GuiTxt(5).Texto)
    GuiTxt(6).Texto = Trim$(GuiTxt(6).Texto)
    GuiTxt(3).Texto = Trim$(GuiTxt(3).Texto)
    GuiTxt(4).Texto = Trim$(GuiTxt(4).Texto)

    If GuiTxt(5).Texto <> GuiTxt(6).Texto Then
        MsgBox "Los passwords que tipeo no coinciden, por favor vuelva a ingresarlos."
        Exit Function
    End If

    If Not CheckMailString(GuiTxt(4).Texto) Then
        MsgBox "Direccion de mail invalida."
        Exit Function
    End If
    If Len(GuiTxt(7).Texto) < 3 Then
        MsgBox "Pin inválido"
        Exit Function
    End If


    If UserRaza = 0 Then
        MsgBox "Seleccione la raza del personaje."
        Exit Function
    End If

    If SkillPoints > 0 Then
        MsgBox "Te quedaron " & SkillPoints & " skillpoints libres, asignalos."
        Exit Function
    End If

    If UserSexo = 0 Then
        MsgBox "Seleccione el sexo del personaje."
        Exit Function
    End If

    If UserClase = 0 Then
        MsgBox "Seleccione la clase del personaje."
        Exit Function
    End If

    If UserHogar = 0 Then
        MsgBox "Seleccione el hogar del personaje."
        Exit Function
    End If

    Dim i As Integer
    For i = 1 To NUMATRIBUTOS
        If UserAtributos(i) = 0 Then
            'MsgBox "Los atributos del personaje son invalidos."
            PanelCrearPJVisible = False
            imgVolver_Click
            DoEvents
            frmMensaje.msg.Caption = "Has sido desconectado del servidor, intente nuevamente."
            frmMensaje.Show , frmConnect
            Exit Function
        End If
    Next i

    If Len(GuiTxt(3).Texto) > 15 Then
        MsgBox ("El nombre debe tener menos de 15 letras.")
        Exit Function
    End If

    If Len(GuiTxt(3).Texto) < 3 Then
        MsgBox ("El nombre debe tener más de 2 letras.")
        Exit Function
    End If

    If Len(GuiTxt(5).Texto) > 40 Then
        MsgBox ("La contraseña debe tener menos de 40 letras.")
        Exit Function
    End If

    If Len(GuiTxt(5).Texto) < 4 Then
        MsgBox ("La contraseña debe tener más de 3 letras.")
        Exit Function
    End If

    CheckData = True

End Function

Private Sub imgCrear_Click()
    Dim i As Long

    If Not PanelCrearPJVisible Then

        mod_Gui.resetGuiFocus
        GuiTxt(3).HasFocus = True
        PanelCrearPJVisible = True
        Call IniciarCaida(0)
    Else
        If Caida < TOP_CAIDA_CREARPJ Then Exit Sub

        SKAssigned = ""
        Dim TotSkills As Integer

        For i = 1 To NUMSKILLS
            UserSkills(i) = CByte(GuiTexto(GUI_ID + i).Texto)

            If UserSkills(i) > 0 Then
                TotSkills = TotSkills + CByte(GuiTexto(GUI_ID + i).Texto)
                SKAssigned = SKAssigned & i & "-" & CByte(GuiTexto(GUI_ID + i).Texto) & "|"
            End If
        Next i

        If Len(SKAssigned) > 0 Then
            SKAssigned = Left$(SKAssigned, Len(SKAssigned) - 1)
        End If

        ' pre-no
        If TotSkills <> 10 Then
            MsgBox "Debes asignar los 10 skills iniciales."
            Exit Sub
        End If

        UserName = GuiTxt(3).Texto
        UserName = Trim$(UserName)

        UserPassword = GuiTxt(5).Texto
        UserPin = GuiTxt(7).Texto
        UserEmail = GuiTxt(4).Texto

        If GuiTxt(7).Texto = "" Then MsgBox "Debes escribir un Pin válido": Exit Sub

        If Not CheckData Then Exit Sub

        EstadoLogin = E_MODO.CrearNuevoPj
        LoginNormal = False

        Call LoginOrConnect(CrearNuevoPj)

    End If
End Sub

Private Sub imgTirarDados_Click()
    If PanelCrearPJVisible Then Exit Sub

    Call modEngine_Audio.PlayEffect(SND_DICE)
    
End Sub

Private Sub imgVolver_Click()
'Call Audio.PlayMIDI("78.MID")
    If PanelCrearPJVisible Then
        Call IniciarCaida(1)
    Else
        Call IniciarCaida(0)

        frmConnect.Show
        frmConnect.QuieroCrearPj = False
        PanelCrearPJVisible = False
        modNetwork.NetClose
        Unload Me
    End If


    GuiTxt(7).Texto = ""
    UserPin = ""
    UserPassword = ""
    GuiTxt(6).Texto = ""
    GuiTxt(5).Texto = ""
    GuiTxt(5).PassTmp = ""
    GuiTxt(6).PassTmp = ""
    GuiTxt(7).PassTmp = ""

End Sub

Private Sub SumarSkillPoint(ByVal SkillIndex As Integer)
    If SkillPoints > 0 Then

        If Val(GuiTexto(GUI_ID + SkillIndex).Texto) < MAXSKILLPOINTS Then
            GuiTexto(GUI_ID + SkillIndex).Texto = Val(GuiTexto(GUI_ID + SkillIndex).Texto) + 1
            SkillPoints = SkillPoints - 1
        End If

    End If
    GuiTexto(28).Texto = "Skillpoints libres: " & SkillPoints

End Sub

Private Sub RestarSkillPoint(ByVal SkillIndex As Integer)
    If SkillPoints < 10 Then

        If Val(GuiTexto(GUI_ID + SkillIndex).Texto) > 0 And SkillPoints >= 0 Then
            GuiTexto(GUI_ID + SkillIndex).Texto = Val(GuiTexto(GUI_ID + SkillIndex).Texto) - 1
            SkillPoints = SkillPoints + 1
        End If
    End If
    GuiTexto(28).Texto = "Skillpoints libres: " & SkillPoints

End Sub

Private Sub Timer1_Timer()

    If CPJ_heading = E_Heading.SOUTH Then
        CPJ_heading = E_Heading.EAST
    ElseIf CPJ_heading = E_Heading.EAST Then
        CPJ_heading = E_Heading.NORTH
    ElseIf CPJ_heading = E_Heading.NORTH Then
        CPJ_heading = E_Heading.WEST
    ElseIf CPJ_heading = E_Heading.WEST Then
        CPJ_heading = E_Heading.SOUTH
    End If

End Sub
