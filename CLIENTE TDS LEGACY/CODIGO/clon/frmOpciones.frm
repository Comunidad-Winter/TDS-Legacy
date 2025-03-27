VERSION 5.00
Begin VB.Form frmOpciones 
   Appearance      =   0  'Flat
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   4395
   ClientLeft      =   3780
   ClientTop       =   0
   ClientWidth     =   5055
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmOpciones.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   293
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   337
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CheckBox chkScroll 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3120
      TabIndex        =   48
      Top             =   3120
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox chkNoMoverseAlHablar 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   46
      Top             =   510
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox chkLockWindow 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   44
      Top             =   840
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox chkTerrain 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3120
      TabIndex        =   41
      Top             =   2685
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox news 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   34
      Top             =   2415
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox Rpassword 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   33
      Top             =   2130
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox cursoresnuevos 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   31
      Top             =   1800
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00004080&
      BorderStyle     =   0  'None
      Caption         =   "Frame2"
      Height          =   840
      Left            =   4800
      TabIndex        =   22
      Top             =   3600
      Visible         =   0   'False
      Width           =   2895
      Begin VB.Label cpmensaje 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00004080&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Estamos buscando la mejor configuracion para su pc. Aguarde..."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   735
         Left            =   30
         TabIndex        =   23
         Top             =   45
         Visible         =   0   'False
         Width           =   2895
         WordWrap        =   -1  'True
      End
   End
   Begin VB.CheckBox musi 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   6
      Top             =   1350
      Width           =   225
   End
   Begin VB.CheckBox son3d 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   4
      Top             =   1635
      Width           =   255
   End
   Begin VB.CheckBox efectos 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3090
      TabIndex        =   5
      Top             =   1110
      Width           =   225
   End
   Begin VB.CheckBox efectcomb 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   210
      Left            =   3135
      TabIndex        =   28
      Top             =   2430
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox oNoRes 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "Check1"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3135
      TabIndex        =   26
      Top             =   2190
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CheckBox noche 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3135
      TabIndex        =   20
      Top             =   1920
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox alfa 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3135
      TabIndex        =   0
      Top             =   1710
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox limitar 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3135
      TabIndex        =   1
      Top             =   1470
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox invertir3d 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3120
      TabIndex        =   3
      Top             =   1170
      Visible         =   0   'False
      Width           =   225
   End
   Begin VB.CheckBox arbolest 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      ForeColor       =   &H80000008&
      Height          =   255
      Left            =   3135
      TabIndex        =   2
      Top             =   1200
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.PictureBox SliderSound 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1245
      Left            =   4005
      Picture         =   "frmOpciones.frx":0152
      ScaleHeight     =   1245
      ScaleWidth      =   255
      TabIndex        =   38
      Top             =   2040
      Width           =   255
      Begin VB.PictureBox Pic2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   270
         Index           =   1
         Left            =   -8
         Picture         =   "frmOpciones.frx":0352
         ScaleHeight     =   270
         ScaleWidth      =   285
         TabIndex        =   39
         Top             =   300
         Width           =   285
      End
   End
   Begin VB.PictureBox SliderMusic 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1245
      Left            =   3300
      Picture         =   "frmOpciones.frx":04C3
      ScaleHeight     =   1245
      ScaleWidth      =   255
      TabIndex        =   36
      Top             =   2040
      Width           =   255
      Begin VB.PictureBox Pic2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   270
         Index           =   0
         Left            =   -8
         Picture         =   "frmOpciones.frx":06C3
         ScaleHeight     =   270
         ScaleWidth      =   285
         TabIndex        =   37
         Top             =   300
         Width           =   285
      End
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "Desactivar Scroll de Hechizos"
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
      Height          =   360
      Left            =   3360
      TabIndex        =   49
      Top             =   3015
      Visible         =   0   'False
      Width           =   1620
   End
   Begin VB.Label lblNoMoverseAlHablar 
      BackStyle       =   0  'Transparent
      Caption         =   "No moverse al hablar"
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
      Height          =   375
      Left            =   3390
      TabIndex        =   47
      Top             =   420
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label lblLockWindow 
      BackStyle       =   0  'Transparent
      Caption         =   "Trabar Ventana"
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
      Height          =   255
      Left            =   3390
      TabIndex        =   45
      Top             =   840
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.Label lblManual 
      BackStyle       =   0  'Transparent
      Caption         =   "> Abrir manual"
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
      Height          =   270
      Left            =   3120
      TabIndex        =   43
      Top             =   1500
      Visible         =   0   'False
      Width           =   1590
   End
   Begin VB.Label lblTerrain 
      BackStyle       =   0  'Transparent
      Caption         =   "Efecto lava y agua"
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
      Height          =   255
      Left            =   3345
      TabIndex        =   42
      Top             =   2700
      Visible         =   0   'False
      Width           =   1620
   End
   Begin VB.Label Label8 
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   4560
      TabIndex        =   40
      Top             =   3960
      Width           =   495
   End
   Begin VB.Label lblCambiarTeclas 
      BackStyle       =   0  'Transparent
      Caption         =   "> Cambiar teclas"
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
      Height          =   225
      Left            =   3120
      TabIndex        =   35
      Top             =   1275
      Visible         =   0   'False
      Width           =   1680
   End
   Begin VB.Label lblNews 
      BackStyle       =   0  'Transparent
      Caption         =   "Noticias de clan"
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
      Height          =   420
      Left            =   3390
      TabIndex        =   32
      Top             =   2430
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.Label OAudio 
      BackStyle       =   0  'Transparent
      Height          =   930
      Left            =   210
      TabIndex        =   30
      Top             =   600
      Width           =   2115
   End
   Begin VB.Label Label16 
      BackStyle       =   0  'Transparent
      Caption         =   "AutoConfigurar"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   360
      TabIndex        =   24
      ToolTipText     =   "Al hacer click aquí el juego buscara la mejor configuración para tu pc."
      Top             =   3960
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.Label Label14 
      BackStyle       =   0  'Transparent
      Caption         =   "Efectos"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3810
      TabIndex        =   19
      Top             =   3360
      Width           =   615
   End
   Begin VB.Label Label13 
      BackStyle       =   0  'Transparent
      Caption         =   "Musica"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3105
      TabIndex        =   18
      Top             =   3345
      Width           =   585
   End
   Begin VB.Label OAceptar 
      BackStyle       =   0  'Transparent
      Height          =   525
      Left            =   3225
      TabIndex        =   17
      Top             =   3690
      Width           =   1350
   End
   Begin VB.Label Ovideo 
      BackStyle       =   0  'Transparent
      Height          =   720
      Left            =   240
      TabIndex        =   16
      Top             =   1800
      Width           =   1950
   End
   Begin VB.Label Ogeneral 
      BackStyle       =   0  'Transparent
      Height          =   780
      Left            =   240
      TabIndex        =   15
      Top             =   2880
      Width           =   2040
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Efectos"
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
      Height          =   255
      Left            =   3390
      TabIndex        =   14
      Top             =   1110
      Width           =   975
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Musica"
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
      Height          =   255
      Left            =   3390
      TabIndex        =   13
      Top             =   1350
      Width           =   975
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Sonido 3D"
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
      Height          =   255
      Left            =   3345
      TabIndex        =   12
      Top             =   1620
      Width           =   975
   End
   Begin VB.Label Label11 
      BackStyle       =   0  'Transparent
      Caption         =   "Cursores TDS"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3390
      TabIndex        =   7
      Top             =   1830
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.Label Label4 
      BackStyle       =   0  'Transparent
      Caption         =   "Invertir 3D"
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
      Height          =   255
      Left            =   3450
      TabIndex        =   11
      Top             =   1215
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label17 
      BackStyle       =   0  'Transparent
      Caption         =   "Recordar Clave"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3390
      TabIndex        =   25
      Top             =   2115
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.Label Label18 
      BackStyle       =   0  'Transparent
      Caption         =   "Efectos de pelea"
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
      Height          =   255
      Left            =   3360
      TabIndex        =   29
      Top             =   2430
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.Label cNores 
      BackStyle       =   0  'Transparent
      Caption         =   "Pantalla chica"
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
      Height          =   255
      Left            =   3375
      TabIndex        =   27
      Top             =   2190
      Visible         =   0   'False
      Width           =   1350
   End
   Begin VB.Label Label15 
      BackStyle       =   0  'Transparent
      Caption         =   "Noche"
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
      Height          =   255
      Left            =   3375
      TabIndex        =   21
      Top             =   1950
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "AlphaBlending"
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
      Height          =   255
      Left            =   3420
      TabIndex        =   9
      Top             =   1710
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Limitar FPS"
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
      Height          =   255
      Left            =   3375
      TabIndex        =   10
      Top             =   1470
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Label Label7 
      BackStyle       =   0  'Transparent
      Caption         =   "Arboles c/t"
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
      Height          =   255
      Left            =   3375
      TabIndex        =   8
      Top             =   1230
      Visible         =   0   'False
      Width           =   1095
   End
End
Attribute VB_Name = "frmOpciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Y2 As Single
Public NewY As Single

Private clsFormulario As clsFrmMovMan

Private loading As Boolean
Public CambioRes As Boolean

Private men As Byte

Private Sub arbolest_Click()
    If loading Then Exit Sub
    tSetup.transArboles = Not tSetup.transArboles
End Sub

Private Sub chkDopa_Click()
' If loading Then Exit Sub
' If tSetup.EfectoDopa = 0 Then
'     tSetup.EfectoDopa = 1
' Else
'     tSetup.EfectoDopa = 0
' End If
End Sub

Private Sub chkLockWindow_Click()
    If loading Then Exit Sub
    If Not MainVisible Then Exit Sub

    If tSetup.LockWindow = 0 Then
        tSetup.LockWindow = 1
    Else
        tSetup.LockWindow = 0
    End If

    Call frmMain.setLockedWindow

End Sub

Private Sub chkNoMoverseAlHablar_Click()
    If loading Then Exit Sub
    If Not MainVisible Then Exit Sub

    If tSetup.NoMoverseAlHablar = 0 Then
        tSetup.NoMoverseAlHablar = 1
    Else
        tSetup.NoMoverseAlHablar = 0
    End If

End Sub

Private Sub chkScroll_Click()

    If loading Then Exit Sub
    If tSetup.ScrollHechi = 0 Then
        tSetup.ScrollHechi = 1

    Else
        tSetup.ScrollHechi = 0
    End If

End Sub

Private Sub chkTerrain_Click()

    If loading Then Exit Sub
    If tSetup.TerrainAnim = 0 Then
        tSetup.TerrainAnim = 1
    Else
        tSetup.TerrainAnim = 0
    End If
End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "12175.png", True)
    MakeFormTransparent Me, vbRed

    SliderMusic.ScaleMode = vbPixels
    SliderMusic.AutoSize = True

    Pic2(0).ScaleMode = vbPixels
    Pic2(0).AutoSize = True

    SliderSound.ScaleMode = vbPixels
    SliderSound.AutoSize = True

    Pic2(1).ScaleMode = vbPixels
    Pic2(1).AutoSize = True

    loading = True
    LoadUserConfig
    men = 1
    loading = False
    CambioRes = tSetup.NoFullScreen

End Sub

Private Sub Label16_Click()
    Frame2.visible = True
End Sub

Private Sub Label9_Click()
    Call chkScroll_Click
End Sub

Private Sub lblCambiarTeclas_Click()
    frmCambiarTeclas.Show vbModeless, frmOpciones
End Sub

Private Sub lblManual_Click()
    Call ShellExecute(0, "Open", "http://tdslegacy.com.ar/manual.php", "VerManual", App.Path, SW_SHOWNORMAL)
End Sub

Private Sub news_Click()
    If loading Then Exit Sub
    ClientSetup.bGuildNews = Not ClientSetup.bGuildNews
End Sub

Private Sub noche_Click()
    If loading Then Exit Sub
    tSetup.NightMode = Not tSetup.NightMode
End Sub

Private Sub limitar_Click()
    If loading Then Exit Sub
    tSetup.LimitFps = Not tSetup.LimitFps
    fpsLastCheck = 0
End Sub

Private Sub alfa_Click()

    If loading Then Exit Sub
    tSetup.AlphaBlending = Not tSetup.AlphaBlending

    If bTecho And tSetup.AlphaBlending Then
        AlphaTecho = 0
    End If

End Sub

Private Sub efectcomb_Click()
    If loading Then Exit Sub
    tSetup.EfectosPelea = Not tSetup.EfectosPelea
End Sub

Private Sub cursoresnuevos_Click()
    If loading Then Exit Sub

    tSetup.tdsCursors = Not tSetup.tdsCursors

    If tSetup.tdsCursors Then

        Set Cursor = New clsAniCursor
        Cursor.AniFile = App.Path & "\GRAFICOS\cur.ani"

        Call Cursor.CursorOn(frmMain.hwnd)
        Call Cursor.CursorOn(frmMain.MainViewPic.hwnd)
        Call Cursor.CursorOn(frmMain.RecTxt.hwnd)
        'Call Cursor.CursorOn(frmMain.hlst.hwnd)
    Else
        ' no está funcionando, que pedo?
        Cursor.AniFile = ""
        Call Cursor.CursorOff(frmMain.hwnd)
        Call Cursor.CursorOff(frmMain.MainViewPic.hwnd)
        Call Cursor.CursorOff(frmMain.RecTxt.hwnd)
        'Call Cursor.CursorOff(frmMain.hlst.hwnd)
        Set Cursor = Nothing        'no funca
    End If
End Sub

Private Sub Rpassword_Click()
    If loading Then Exit Sub
    Call modEngine_Audio.PlayInterface(SND_CLICK)
    GuardarContra = Not GuardarContra
End Sub

Private Sub musi_Click()
    If loading Then Exit Sub
    Call modEngine_Audio.PlayInterface(SND_CLICK)


    modEngine_Audio.MusicEnabled = Not modEngine_Audio.MusicEnabled
    If modEngine_Audio.MusicEnabled Then

        'SliderMusic.Enabled = True
        Pic2(0).Top = Round(modEngine_Audio.MusicVolume * ((SliderMusic.ScaleHeight - (Pic2(0).ScaleHeight * 1.1)) / 99))
        'Pic2(0).Enabled = True

    End If
End Sub

Private Sub oNoRes_Click()
    If loading Then Exit Sub
    Call modEngine_Audio.PlayInterface(SND_CLICK)
    tSetup.NoFullScreen = Not tSetup.NoFullScreen

End Sub

Private Sub efectos_Click()

    If loading Then Exit Sub

    Call modEngine_Audio.PlayInterface(SND_CLICK)
    modEngine_Audio.EffectEnabled = Not modEngine_Audio.EffectEnabled

    If Not modEngine_Audio.EffectEnabled Then
        RainBufferIndex = 0
        frmMain.IsPlaying = PlayLoop.plNone
        'SliderSound.Enabled = False
    Else
        'SliderSound.Enabled = True
        Pic2(1).Top = Round(modEngine_Audio.EffectVolume * ((SliderSound.ScaleHeight - (Pic2(1).ScaleHeight * 1.1)) / 99))
    End If
End Sub


' //
'
'
'
'
' @@ Labels click

Private Sub Label17_Click()
    Call Rpassword_Click
    If Rpassword.Value = 1 Then
        Rpassword.Value = 0
    Else
        Rpassword.Value = 1
    End If
End Sub
Private Sub Label11_Click()
    Call cursoresnuevos_Click
    If cursoresnuevos.Value = 1 Then
        cursoresnuevos.Value = 0
    Else
        cursoresnuevos.Value = 1
    End If
End Sub
'Private Sub Label3_Click()
'    Call son3d_Click
'    If son3d.Value = 1 Then
'        son3d.Value = 0
'    Else
'        son3d.Value = 1
'    End If
'End Sub
Private Sub Label2_Click()
    Call musi_Click
    If musi.Value = 1 Then
        musi.Value = 0
    Else
        musi.Value = 1
    End If
End Sub
Private Sub Label6_Click()
    Call alfa_Click
    If alfa.Value = 1 Then
        alfa.Value = 0
    Else
        alfa.Value = 1
    End If
End Sub
Private Sub lblNews_Click()
    Call news_Click
    If news.Value = 1 Then
        news.Value = 0
    Else
        news.Value = 1
    End If
End Sub
Private Sub cNores_Click()
    Call oNoRes_Click
    If oNoRes.Value = 1 Then
        oNoRes.Value = 0
    Else
        oNoRes.Value = 1
    End If
End Sub
Private Sub Label5_Click()
    Call limitar_Click
    If limitar.Value = 1 Then
        limitar.Value = 0
    Else
        limitar.Value = 1
    End If
End Sub
Private Sub Label1_Click()
    Call efectos_Click
    DoEvents
    If efectos.Value = 1 Then
        efectos.Value = 0
    Else
        efectos.Value = 1
    End If
End Sub
Private Sub Label18_Click()
    Call efectcomb_Click
    If efectcomb.Value = 1 Then
        efectcomb.Value = 0
    Else
        efectcomb.Value = 1
    End If
End Sub
Private Sub Label7_Click()
    Call arbolest_Click
    If arbolest.Value = 1 Then
        arbolest.Value = 0
    Else
        arbolest.Value = 1
    End If
End Sub
Private Sub Label15_Click()
    Call noche_Click
    If noche.Value = 1 Then
        noche.Value = 0
    Else
        noche.Value = 1
    End If
End Sub

Private Sub LoadUserConfig()

    Rpassword.Value = IIf(GuardarContra, 1, 0)

    With tSetup
        cursoresnuevos.Value = IIf(.tdsCursors, 1, 0)
        oNoRes.Value = IIf(.NoFullScreen, 1, 0)
        efectcomb.Value = IIf(.EfectosPelea, 1, 0)
        limitar.Value = IIf(.LimitFps, 1, 0)
        arbolest.Value = IIf(.transArboles, 1, 0)
        alfa.Enabled = True    ' @@ why I disabled this?
        alfa.Value = IIf(.AlphaBlending, 1, 0)    ' @@ Falta codear!
        noche.Enabled = False: noche.Value = IIf(tSetup.NightMode, 1, 0)    ' @@ Falta codear!
        ' Audio.SetMusic (.MusicValue)
        ' Audio.SetSound (.AudioValue)
        'chkDopa.Value = .EfectoDopa
        chkTerrain.Value = .TerrainAnim
        chkLockWindow.Value = .LockWindow
        chkNoMoverseAlHablar.Value = .NoMoverseAlHablar
        chkScroll.Value = .ScrollHechi
    End With

    'bMusicActivated = Audio.MusicActivated
    'SliderMusic.Enabled = bMusicActivated

    If modEngine_Audio.MusicEnabled Then
        Pic2(0).Top = Round(Audio.MusicVolume * ((SliderMusic.ScaleHeight - (Pic2(0).ScaleHeight * 1.1)) / 99))
        musi.Value = 1
        If Audio.MusicVolume >= 55 Then
            Pic2(0).Top = Round(100 * ((SliderSound.ScaleHeight - (Pic2(1).ScaleHeight * 1.1)) / 99))
        End If
    End If

    If modEngine_Audio.EffectEnabled Then
        Pic2(1).Top = Round(modEngine_Audio.EffectVolume * ((SliderSound.ScaleHeight - (Pic2(1).ScaleHeight * 1.1)) / 99))

        efectos.Value = 1
    End If


    news.Value = IIf(ClientSetup.bGuildNews, 1, 0)

End Sub

Private Sub OAceptar_Click()
'deberia guardarlo en el file? yess
    loading = True
    SaveIni
    Unload Me
    If frmMain.visible = True Then
        frmMain.SetFocus
    ElseIf frmConnect.visible = True Then
        frmConnect.SetFocus
    End If

    If tSetup.NoFullScreen <> CambioRes And Not UserCharIndex > 0 Then
        MsgBox "Reinicia el cliente para efectuar los cambios"
        Exit Sub
        bNoResChange = False

        Call Resolution.SetResolution

        EngineRun = False
        CambiandoRes = True

        If frmConnect.visible Then
            Unload frmConnect
        End If
        If frmOldPersonaje.visible Then
            Unload frmOldPersonaje
        End If
        If frmMain.visible Then
            frmMain.Hide
        End If

        frmCargando.Show
        frmCargando.tmrReload.Enabled = True
        frmCargando.ActualWidth = 0

        'Stop tile engine
        Call DeinitTileEngine

        DirectXInit

        Set SurfaceDB = New clsSurfaceManDyn

        If Not InitTileEngine(frmMain.hwnd, 149, 7, 13, 17, 8, 7, 7, 0.02) Then
            Call Mod_General.CloseClient
        End If

        'Call Audio.Initialize(DirectX, frmMain.hwnd, App.Path & "\WAV\", App.Path & "\MIDI\")

        Call Inventario.Initialize(DirectD3D8, frmMain.picInv, MAX_INVENTORY_SLOTS)

        InitGui
        Init_FontRender

        Call Unload(frmScreenshots)
        Call Load(frmScreenshots)

    End If

End Sub

Private Sub OAudio_Click()
    If men = 1 Then Exit Sub
    Call setaudio(True, True)
End Sub

Private Sub Ogeneral_Click()
    If men = 3 Then Exit Sub
    Call setgeneral(True, True)
End Sub

Private Sub Ovideo_Click()
    If men = 2 Then Exit Sub
    Call setvideo(True, True)
End Sub

Private Function turnoff()
    If men = 1 Then
        Call setaudio(False)
    ElseIf men = 2 Then
        Call setvideo(False)
    ElseIf men = 3 Then
        Call setgeneral(False)
    End If
End Function

Private Function setaudio(ByVal tipo As Boolean, Optional ByVal bTurnoff As Boolean = False)

    If bTurnoff Then Call turnoff

    Label1.visible = tipo
    efectos.visible = tipo
    Label2.visible = tipo
    musi.visible = tipo

    Label3.visible = tipo
    son3d.visible = tipo
    SliderSound.visible = tipo
    SliderMusic.visible = tipo

    'invertir3d.Visible = Tipo
    'Label4.Visible = Tipo
    Label13.visible = tipo
    Label14.visible = tipo
    Pic2(0).visible = tipo
    Pic2(1).visible = tipo
    Label8.visible = tipo

    men = 1

End Function

Private Function setvideo(ByVal tipo As Boolean, Optional ByVal bTurnoff As Boolean = False)

    If bTurnoff Then Call turnoff

    cNores.visible = tipo
    Label15.visible = tipo
    Label18.visible = tipo
    efectcomb.visible = tipo
    Label7.visible = tipo
    arbolest.visible = tipo
    Label5.visible = tipo
    limitar.visible = tipo
    Label6.visible = tipo
    alfa.visible = tipo
    noche.visible = tipo
    oNoRes.visible = tipo
    lblTerrain.visible = tipo
    chkTerrain.visible = tipo
    'lblDopa.Visible = tipo
    'chkDopa.Visible = tipo
    chkLockWindow.visible = tipo
    lblLockWindow.visible = tipo
    chkNoMoverseAlHablar.visible = tipo
    lblNoMoverseAlHablar.visible = tipo

    men = 2

End Function

Private Function setgeneral(ByVal tipo As Boolean, Optional ByVal bTurnoff As Boolean = False)

    If bTurnoff Then Call turnoff
    lblCambiarTeclas.visible = tipo
    Label11.visible = tipo
    cursoresnuevos.visible = tipo
    Label17.visible = tipo
    Rpassword.visible = tipo
    lblNews.visible = tipo
    news.visible = tipo
    lblManual.visible = tipo

    chkScroll.visible = tipo
    Label9.visible = tipo

    men = 3

End Function

Private Sub Pic2_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

    If Button <> 1 Then Exit Sub
    Y2 = Y

End Sub

Private Sub Pic2_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)

    If loading Then Exit Sub

    If Button = 1 Then
        With Pic2(index)
            NewY = .Top - (Y2 - Y)

            Dim Heigth As Long

            If index > 0 Then
                Heigth = SliderMusic.ScaleHeight
            Else
                Heigth = SliderSound.ScaleHeight
            End If

            If NewY > 0 And NewY < (Heigth - .ScaleHeight) Then

                .Move 0, NewY

                Dim Valor As Byte
                Valor = Int(NewY / ((Heigth - (.ScaleHeight * 1.1)) / 99))


                If index = 0 Then
                    Label8.Top = SliderMusic.Top + .Top - (Y2 - Y)
                    Label8.Left = SliderMusic.Left + 20

                Else
                    Label8.Top = SliderSound.Top + .Top - (Y2 - Y)
                    Label8.Left = SliderSound.Left + 20

                End If
                Label8.Caption = Valor & "%"

                If Valor > 100 Then Valor = 100

                Select Case index
                Case 0
                    modEngine_Audio.MusicVolume = Valor
                    tSetup.MusicValue = Valor

                Case 1
                    modEngine_Audio.EffectVolume = Valor
                    tSetup.AudioValue = Valor
                End Select

            Else

                If Not (NewY > 0) Then

                    .Move 0, 0    'es el minimo

                    If index = 0 Then
                        Label8.Top = SliderMusic.Top + .Top
                        Label8.Left = SliderMusic.Left + 20
                    Else
                        Label8.Top = SliderSound.Top + .Top
                        Label8.Left = SliderSound.Left + 20
                    End If
                    Label8.Caption = "0%"
                    Select Case index
                    Case 0
                        modEngine_Audio.MusicVolume = 0
                        tSetup.MusicValue = 0

                    Case 1
                        modEngine_Audio.EffectVolume = 0
                        tSetup.AudioValue = 0
                    End Select
                Else
                    .Move 0, 66    ' es el máximo
                    If index = 0 Then
                        Label8.Top = SliderMusic.Top + .Top
                        Label8.Left = SliderMusic.Left + 20
                    Else
                        Label8.Top = SliderSound.Top + .Top
                        Label8.Left = SliderSound.Left + 20
                    End If
                    Label8.Caption = "100%"
                    Select Case index
                    Case 0
                        modEngine_Audio.MusicVolume = 100
                        tSetup.MusicValue = 100
                    Case 1
                        modEngine_Audio.EffectVolume = 100
                        tSetup.AudioValue = 100
                    End Select
                End If

            End If
        End With
    End If

End Sub
