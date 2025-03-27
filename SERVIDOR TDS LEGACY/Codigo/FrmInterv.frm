VERSION 5.00
Begin VB.Form FrmInterv 
   Caption         =   "Intervalos"
   ClientHeight    =   4710
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14025
   LinkTopic       =   "Form1"
   ScaleHeight     =   4710
   ScaleWidth      =   14025
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame13 
      Caption         =   "Intervalos"
      Height          =   4680
      Left            =   7920
      TabIndex        =   44
      Top             =   0
      Width           =   5175
      Begin VB.TextBox Text11 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   3240
         TabIndex        =   72
         Text            =   "1100"
         Top             =   2880
         Width           =   735
      End
      Begin VB.TextBox Text9 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   1905
         TabIndex        =   64
         Text            =   "750"
         Top             =   3600
         Width           =   735
      End
      Begin VB.TextBox Text8 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   1920
         TabIndex        =   62
         Text            =   "100"
         Top             =   360
         Width           =   735
      End
      Begin VB.TextBox Text10 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   1920
         TabIndex        =   60
         Text            =   "850"
         Top             =   3240
         Width           =   735
      End
      Begin VB.CommandButton Command4 
         Caption         =   "Actualizar a todos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   690
         Left            =   195
         TabIndex        =   59
         Top             =   3960
         Width           =   2490
      End
      Begin VB.TextBox Text1 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   1920
         TabIndex        =   51
         Text            =   "350"
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox Text2 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   1920
         TabIndex        =   50
         Text            =   "300"
         Top             =   1080
         Width           =   735
      End
      Begin VB.TextBox Text3 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   1920
         TabIndex        =   49
         Text            =   "950"
         Top             =   1440
         Width           =   735
      End
      Begin VB.TextBox Text4 
         Alignment       =   2  'Center
         Height          =   330
         Left            =   1920
         TabIndex        =   48
         Text            =   "950"
         Top             =   1800
         Width           =   735
      End
      Begin VB.TextBox Text5 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   1920
         TabIndex        =   47
         Text            =   "950"
         Top             =   2160
         Width           =   735
      End
      Begin VB.TextBox Text6 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   1920
         TabIndex        =   46
         Text            =   "1000"
         Top             =   2520
         Width           =   735
      End
      Begin VB.TextBox Text7 
         Alignment       =   2  'Center
         Height          =   315
         Left            =   1920
         TabIndex        =   45
         Text            =   "1100"
         Top             =   2880
         Width           =   735
      End
      Begin VB.Label Label21 
         Caption         =   "WAR:"
         Height          =   210
         Index           =   2
         Left            =   2760
         TabIndex        =   73
         Top             =   2900
         Width           =   405
      End
      Begin VB.Label Label21 
         Caption         =   "TRABAJAR"
         Height          =   210
         Index           =   1
         Left            =   240
         TabIndex        =   65
         Top             =   3600
         Width           =   1470
      End
      Begin VB.Label Label28 
         Caption         =   "USAR"
         Height          =   195
         Left            =   240
         TabIndex        =   63
         Top             =   360
         Width           =   1245
      End
      Begin VB.Label Label21 
         Caption         =   "GOLPE USAR"
         Height          =   210
         Index           =   3
         Left            =   255
         TabIndex        =   61
         Top             =   3240
         Width           =   1470
      End
      Begin VB.Label Label27 
         Caption         =   "USAR U"
         Height          =   315
         Left            =   240
         TabIndex        =   58
         Top             =   720
         Width           =   1245
      End
      Begin VB.Label Label26 
         Caption         =   "USAR CLICK"
         Height          =   195
         Left            =   255
         TabIndex        =   57
         Top             =   1080
         Width           =   1635
      End
      Begin VB.Label Label25 
         Caption         =   "MAGIA MAGIA"
         Height          =   180
         Left            =   255
         TabIndex        =   56
         Top             =   1440
         Width           =   1560
      End
      Begin VB.Label Label24 
         Caption         =   "GOLPE MAGIA"
         Height          =   210
         Left            =   240
         TabIndex        =   55
         Top             =   1800
         Width           =   1545
      End
      Begin VB.Label Label23 
         Caption         =   "MAGIA GOLPE"
         Height          =   255
         Left            =   240
         TabIndex        =   54
         Top             =   2160
         Width           =   1335
      End
      Begin VB.Label Label22 
         Caption         =   "GOLPE GOLPE"
         Height          =   240
         Left            =   255
         TabIndex        =   53
         Top             =   2520
         Width           =   1440
      End
      Begin VB.Label Label21 
         Caption         =   "FLECHA FLECHA"
         Height          =   210
         Index           =   0
         Left            =   240
         TabIndex        =   52
         Top             =   2880
         Width           =   1365
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Guardar Intervalos en .INI"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4200
      TabIndex        =   29
      Top             =   4320
      Width           =   3255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Aplicar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2160
      TabIndex        =   0
      Top             =   4320
      Width           =   2055
   End
   Begin VB.Frame Frame11 
      Caption         =   "NPCs"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   4200
      TabIndex        =   38
      Top             =   2160
      Width           =   1695
      Begin VB.Frame Frame4 
         Caption         =   "A.I"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1575
         Left            =   150
         TabIndex        =   39
         Top             =   240
         Width           =   1365
         Begin VB.TextBox txtAI 
            Height          =   285
            Left            =   150
            TabIndex        =   41
            Text            =   "0"
            Top             =   1080
            Width           =   1050
         End
         Begin VB.TextBox txtNPCPuedeAtacar 
            Height          =   285
            Left            =   135
            TabIndex        =   40
            Text            =   "0"
            Top             =   510
            Width           =   1050
         End
         Begin VB.Label Label7 
            AutoSize        =   -1  'True
            Caption         =   "AI"
            Height          =   195
            Left            =   165
            TabIndex        =   43
            Top             =   840
            Width           =   150
         End
         Begin VB.Label Label9 
            AutoSize        =   -1  'True
            Caption         =   "Puede atacar"
            Height          =   195
            Left            =   150
            TabIndex        =   42
            Top             =   255
            Width           =   960
         End
      End
   End
   Begin VB.Frame Frame12 
      Caption         =   "Clima && Amb"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   6000
      TabIndex        =   32
      Top             =   2160
      Width           =   1785
      Begin VB.Frame Frame7 
         Caption         =   "Frio y Fx"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1650
         Left            =   120
         TabIndex        =   33
         Top             =   240
         Width           =   1185
         Begin VB.TextBox txtIntervaloWAVFX 
            Height          =   300
            Left            =   150
            TabIndex        =   35
            Text            =   "0"
            Top             =   480
            Width           =   930
         End
         Begin VB.TextBox txtIntervaloFrio 
            Height          =   285
            Left            =   180
            TabIndex        =   34
            Text            =   "0"
            Top             =   1080
            Width           =   915
         End
         Begin VB.Label Label13 
            AutoSize        =   -1  'True
            Caption         =   "FxS amb"
            Height          =   195
            Left            =   180
            TabIndex        =   37
            Top             =   270
            Width           =   615
         End
         Begin VB.Label Label12 
            AutoSize        =   -1  'True
            Caption         =   "Frio amb"
            Height          =   195
            Left            =   195
            TabIndex        =   36
            Top             =   810
            Width           =   600
         End
      End
   End
   Begin VB.Frame Frame6 
      Caption         =   "Usuarios"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   120
      TabIndex        =   3
      Top             =   0
      Width           =   7695
      Begin VB.Frame Frame9 
         Caption         =   "Otros"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1710
         Left            =   90
         TabIndex        =   19
         Top             =   210
         Width           =   1890
         Begin VB.TextBox txtIntervaloParaConexion 
            Height          =   300
            Left            =   360
            TabIndex        =   20
            Text            =   "0"
            Top             =   495
            Width           =   930
         End
         Begin VB.Label Label14 
            AutoSize        =   -1  'True
            Caption         =   "IntervaloParaConexion"
            Height          =   195
            Left            =   120
            TabIndex        =   21
            Top             =   270
            Width           =   1605
         End
      End
      Begin VB.Frame Frame3 
         Caption         =   "Hambre y sed"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1710
         Left            =   6240
         TabIndex        =   14
         Top             =   240
         Width           =   1290
         Begin VB.TextBox txtIntervaloHambre 
            Height          =   285
            Left            =   120
            TabIndex        =   16
            Text            =   "0"
            Top             =   480
            Width           =   930
         End
         Begin VB.TextBox txtIntervaloSed 
            Height          =   285
            Left            =   120
            TabIndex        =   15
            Text            =   "0"
            Top             =   1200
            Width           =   930
         End
         Begin VB.Label Label5 
            AutoSize        =   -1  'True
            Caption         =   "Hambre"
            Height          =   195
            Left            =   120
            TabIndex        =   18
            Top             =   255
            Width           =   555
         End
         Begin VB.Label Label6 
            AutoSize        =   -1  'True
            Caption         =   "Sed"
            Height          =   195
            Left            =   120
            TabIndex        =   17
            Top             =   930
            Width           =   285
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "Sanar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1710
         Left            =   4800
         TabIndex        =   9
         Top             =   210
         Width           =   1410
         Begin VB.TextBox txtSanaIntervaloDescansar 
            Height          =   285
            Left            =   150
            TabIndex        =   11
            Text            =   "0"
            Top             =   510
            Width           =   1050
         End
         Begin VB.TextBox txtSanaIntervaloSinDescansar 
            Height          =   285
            Left            =   150
            TabIndex        =   10
            Text            =   "0"
            Top             =   1185
            Width           =   1050
         End
         Begin VB.Label Label3 
            AutoSize        =   -1  'True
            Caption         =   "Descansando"
            Height          =   195
            Left            =   180
            TabIndex        =   13
            Top             =   255
            Width           =   990
         End
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            Caption         =   "Sin descansar"
            Height          =   195
            Left            =   165
            TabIndex        =   12
            Top             =   930
            Width           =   1005
         End
      End
      Begin VB.Frame Frame2 
         Caption         =   "Stamina"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1710
         Left            =   3360
         TabIndex        =   4
         Top             =   210
         Width           =   1410
         Begin VB.TextBox txtStaminaIntervaloSinDescansar 
            Height          =   285
            Left            =   150
            TabIndex        =   6
            Text            =   "0"
            Top             =   1185
            Width           =   1050
         End
         Begin VB.TextBox txtStaminaIntervaloDescansar 
            Height          =   285
            Left            =   165
            TabIndex        =   5
            Text            =   "0"
            Top             =   510
            Width           =   1050
         End
         Begin VB.Label Label2 
            AutoSize        =   -1  'True
            Caption         =   "Sin descansar"
            Height          =   195
            Left            =   165
            TabIndex        =   8
            Top             =   930
            Width           =   1005
         End
         Begin VB.Label Label4 
            AutoSize        =   -1  'True
            Caption         =   "Descansando"
            Height          =   195
            Left            =   180
            TabIndex        =   7
            Top             =   255
            Width           =   990
         End
      End
   End
   Begin VB.Frame Frame5 
      Caption         =   "Magia"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   120
      TabIndex        =   2
      Top             =   2160
      Width           =   3975
      Begin VB.Frame Frame10 
         Caption         =   "Duracion Spells"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1650
         Left            =   135
         TabIndex        =   22
         Top             =   270
         Width           =   3720
         Begin VB.TextBox txtInvocacionAgua 
            Height          =   300
            Left            =   3000
            TabIndex        =   70
            Text            =   "0"
            Top             =   810
            Width           =   585
         End
         Begin VB.TextBox txtInvocacionTierra 
            Height          =   300
            Left            =   2160
            TabIndex        =   68
            Text            =   "0"
            Top             =   1170
            Width           =   825
         End
         Begin VB.TextBox txtInvocacionFuego 
            Height          =   300
            Left            =   2160
            TabIndex        =   66
            Text            =   "0"
            Top             =   450
            Width           =   825
         End
         Begin VB.TextBox txtInvocacion 
            Height          =   300
            Left            =   1170
            TabIndex        =   30
            Text            =   "0"
            Top             =   1170
            Width           =   765
         End
         Begin VB.TextBox txtIntervaloInvisible 
            Height          =   300
            Left            =   1170
            TabIndex        =   27
            Text            =   "0"
            Top             =   495
            Width           =   765
         End
         Begin VB.TextBox txtIntervaloParalizado 
            Height          =   300
            Left            =   195
            TabIndex        =   24
            Text            =   "0"
            Top             =   1170
            Width           =   660
         End
         Begin VB.TextBox txtIntervaloVeneno 
            Height          =   300
            Left            =   195
            TabIndex        =   23
            Text            =   "0"
            Top             =   510
            Width           =   660
         End
         Begin VB.Label Label17 
            AutoSize        =   -1  'True
            Caption         =   "EleAgua"
            Height          =   195
            Left            =   3000
            TabIndex        =   71
            Top             =   600
            Width           =   600
         End
         Begin VB.Label Label16 
            AutoSize        =   -1  'True
            Caption         =   "EleTierra"
            Height          =   195
            Left            =   2160
            TabIndex        =   69
            Top             =   960
            Width           =   630
         End
         Begin VB.Label Label15 
            AutoSize        =   -1  'True
            Caption         =   "EleFuego"
            Height          =   195
            Left            =   2160
            TabIndex        =   67
            Top             =   240
            Width           =   675
         End
         Begin VB.Label Label18 
            AutoSize        =   -1  'True
            Caption         =   "Invocacion"
            Height          =   195
            Left            =   1170
            TabIndex        =   31
            Top             =   960
            Width           =   795
         End
         Begin VB.Label Label11 
            AutoSize        =   -1  'True
            Caption         =   "Invisible"
            Height          =   195
            Left            =   1170
            TabIndex        =   28
            Top             =   285
            Width           =   570
         End
         Begin VB.Label Label10 
            AutoSize        =   -1  'True
            Caption         =   "Paralizado"
            Height          =   195
            Left            =   225
            TabIndex        =   26
            Top             =   960
            Width           =   735
         End
         Begin VB.Label Label8 
            AutoSize        =   -1  'True
            Caption         =   "Veneno"
            Height          =   180
            Left            =   225
            TabIndex        =   25
            Top             =   300
            Width           =   555
         End
      End
   End
   Begin VB.CommandButton ok 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   4320
      Width           =   2055
   End
End
Attribute VB_Name = "FrmInterv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Public Sub AplicarIntervalos()

'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿ Intervalos del main loop ¿?¿?¿?¿?¿?¿?¿?¿?¿
    SanaIntervaloSinDescansar = val(txtSanaIntervaloSinDescansar.Text)
    StaminaIntervaloSinDescansar = val(txtStaminaIntervaloSinDescansar.Text)
    SanaIntervaloDescansar = val(txtSanaIntervaloDescansar.Text)
    StaminaIntervaloDescansar = val(txtStaminaIntervaloDescansar.Text)
    IntervaloSed = val(txtIntervaloSed.Text)
    IntervaloHambre = val(txtIntervaloHambre.Text)
    IntervaloVeneno = val(txtIntervaloVeneno.Text)
    IntervaloParalizado = val(txtIntervaloParalizado.Text)
    IntervaloInvisible = val(txtIntervaloInvisible.Text)
    IntervaloFrio = val(txtIntervaloFrio.Text)
    IntervaloWavFx = val(txtIntervaloWAVFX.Text)
    IntervaloInvocacion = val(txtInvocacion.Text)

    IntervaloInvocacionFuego = val(txtInvocacionFuego.Text)
    IntervaloInvocacionAgua = val(txtInvocacionAgua.Text)
    IntervaloInvocacionTierra = val(txtInvocacionTierra.Text)

    IntervaloParaConexion = val(txtIntervaloParaConexion.Text)

    '///////////////// TIMERS \\\\\\\\\\\\\\\\\\\

    frmMain.npcataca.Interval = val(txtNPCPuedeAtacar.Text)
    frmMain.TIMER_AI.Interval = val(txtAI.Text)



    INT_USEITEM = val(Text8.Text)

    INT_USEITEMU = val(Text1.Text)
    INT_USEITEMDCK = val(Text2.Text)
    INT_ATTACK_USEITEM = val(Text10.Text)


    INT_CAST_SPELL = val(Text3.Text)
    INT_ATTACK_CAST = val(Text4.Text)
    INT_CAST_ATTACK = val(Text5.Text)
    INT_ATTACK = val(Text6.Text)
    INT_ARROWS = val(Text7.Text)

    INT_WORK = val(Text9.Text)










End Sub

Private Sub Command1_Click()
    On Error Resume Next
    Call AplicarIntervalos
End Sub

Private Sub Command2_Click()

    On Error GoTo Err

    'Intervalos
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "SanaIntervaloSinDescansar", Str(SanaIntervaloSinDescansar))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "StaminaIntervaloSinDescansar", Str(StaminaIntervaloSinDescansar))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "SanaIntervaloDescansar", Str(SanaIntervaloDescansar))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "StaminaIntervaloDescansar", Str(StaminaIntervaloDescansar))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloSed", Str(IntervaloSed))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloHambre", Str(IntervaloHambre))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloVeneno", Str(IntervaloVeneno))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloParalizado", Str(IntervaloParalizado))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvisible", Str(IntervaloInvisible))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloFrio", Str(IntervaloFrio))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloWAVFX", Str(IntervaloWavFx))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvocacion", Str(IntervaloInvocacion))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvocacionFuego", Str(IntervaloInvocacionFuego))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvocacionAgua", Str(IntervaloInvocacionAgua))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvocacionTierra", Str(IntervaloInvocacionTierra))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloParaConexion", Str(IntervaloParaConexion))


    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_USEITEM", Str(INT_USEITEM))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_USEITEMU", Str(INT_USEITEMU))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_USEITEMDCK", Str(INT_USEITEMDCK))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_ATTACK_USEITEM", Str(INT_ATTACK_USEITEM))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_CAST_SPELL", Str(INT_CAST_SPELL))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_CAST_ATTACK", Str(INT_CAST_ATTACK))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_ATTACK_CAST", Str(INT_ATTACK_CAST))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_ATTACK", Str(INT_ATTACK))
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_ARROWS", Str(INT_ARROWS))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_ARROWSW", Str(INT_ARROWSW))

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "INT_WORK", Str(INT_WORK))


    '&&&&&&&&&&&&&&&&&&&&& TIMERS &&&&&&&&&&&&&&&&&&&&&&&

    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloNpcAI", frmMain.TIMER_AI.Interval)
    Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloNpcPuedeAtacar", frmMain.npcataca.Interval)

    Exit Sub
Err:
    LogError "Error al intentar grabar los intervalos"
End Sub

Private Sub Command4_Click()

    On Error GoTo Errhandler


    INT_USEITEMU = val(Text1.Text)
    INT_USEITEMDCK = val(Text2.Text)
    INT_CAST_SPELL = val(Text3.Text)

    INT_CAST_ATTACK = val(Text4.Text)
    INT_WORK = val(Text5.Text)
    INT_ATTACK = val(Text6.Text)
    INT_ARROWS = val(Text7.Text)

    INT_ARROWSW = val(Text11.Text)

    Dim i As Long

    For i = 1 To NumUsers
        If UserList(i).ConnIDValida Then
            Call WriteIntervalos(i)
        End If
    Next i

    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Intervalos actualizados desde  el Servidor.", FontTypeNames.FONTTYPE_ADMIN))
    Exit Sub

Errhandler:
    Call LogError("Error al actualizar int desde frmInterv. " & Err.Number & " " & Err.Description)
End Sub

Private Sub Form_Load()

    On Error Resume Next

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager

    Call Leer.Initialize(App.path & "/server.ini")

    txtIntervaloParaConexion.Text = val(Leer.GetValue("INTERVALOS", "IntervaloParaConexion"))

    txtStaminaIntervaloDescansar.Text = val(Leer.GetValue("INTERVALOS", "StaminaIntervaloDescansar"))
    txtStaminaIntervaloSinDescansar.Text = val(Leer.GetValue("INTERVALOS", "StaminaIntervaloSinDescansar"))
    txtSanaIntervaloDescansar.Text = val(Leer.GetValue("INTERVALOS", "SanaIntervaloDescansar"))
    txtSanaIntervaloSinDescansar.Text = val(Leer.GetValue("INTERVALOS", "SanaIntervaloSinDescansar"))
    txtIntervaloHambre.Text = val(Leer.GetValue("INTERVALOS", "IntervaloSed"))
    txtIntervaloSed.Text = val(Leer.GetValue("INTERVALOS", "IntervaloHambre"))

    txtIntervaloVeneno.Text = val(Leer.GetValue("INTERVALOS", "IntervaloVeneno"))
    txtIntervaloParalizado.Text = val(Leer.GetValue("INTERVALOS", "IntervaloParalizado"))
    txtIntervaloInvisible.Text = val(Leer.GetValue("INTERVALOS", "IntervaloInvisible"))
    txtInvocacion.Text = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacion"))

    txtInvocacionFuego.Text = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionFuego"))
    txtInvocacionAgua.Text = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionAgua"))
    txtInvocacionTierra.Text = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionTierra"))

    txtNPCPuedeAtacar.Text = val(Leer.GetValue("INTERVALOS", "IntervaloNpcPuedeAtacar"))
    txtAI.Text = val(Leer.GetValue("INTERVALOS", "IntervaloNpcAI"))

    txtIntervaloWAVFX.Text = val(Leer.GetValue("INTERVALOS", "IntervaloWAVFX"))
    txtIntervaloFrio.Text = val(Leer.GetValue("INTERVALOS", "IntervaloFrio"))


    Text8.Text = val(Leer.GetValue("INTERVALOS", "INT_USEITEM"))
    Text1.Text = val(Leer.GetValue("INTERVALOS", "INT_USEITEMU"))
    Text2.Text = val(Leer.GetValue("INTERVALOS", "INT_USEITEMDCK"))
    Text3.Text = val(Leer.GetValue("INTERVALOS", "INT_CAST_SPELL"))
    Text4.Text = val(Leer.GetValue("INTERVALOS", "INT_ATTACK_CAST"))
    Text5.Text = val(Leer.GetValue("INTERVALOS", "INT_CAST_ATTACK"))
    Text6.Text = val(Leer.GetValue("INTERVALOS", "INT_ATTACK"))
    Text7.Text = val(Leer.GetValue("INTERVALOS", "INT_ARROWS"))
    Text10.Text = val(Leer.GetValue("INTERVALOS", "INT_ATTACK_USEITEM"))
    Text9.Text = val(Leer.GetValue("INTERVALOS", "INT_WORK"))

    Text11.Text = val(Leer.GetValue("INTERVALOS", "INT_ARROWSW"))
    If INT_ARROWSW = 0 Then INT_ARROWSW = INT_ARROWS

    Set Leer = Nothing

End Sub

Private Sub ok_Click()
    Me.Visible = False
End Sub

