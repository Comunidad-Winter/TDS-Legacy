VERSION 5.00
Begin VB.Form frmServidor 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Acciones"
   ClientHeight    =   4860
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4755
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   324
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   317
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdReloadQuests 
      Caption         =   "Recargar Quest"
      Height          =   255
      Left            =   360
      TabIndex        =   26
      Top             =   0
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "CargarRates"
      Height          =   315
      Left            =   3600
      TabIndex        =   23
      Top             =   2520
      Width           =   1095
   End
   Begin VB.CommandButton cmdSpawnList 
      Caption         =   "SpawnList"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   420
      Left            =   2160
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   1200
      Width           =   1125
   End
   Begin VB.CommandButton Command26 
      Caption         =   "Reset Listen"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3480
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   3840
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton Command23 
      Caption         =   "Apagar seguro"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   3960
      Width           =   1605
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Load Backup"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   3480
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   3480
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.CommandButton Command18 
      Caption         =   "Save all Users"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Left            =   240
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   3360
      Width           =   1680
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Do Backup"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   3480
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   3120
      Width           =   1245
   End
   Begin VB.CommandButton Command2 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   2280
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   4320
      Width           =   2385
   End
   Begin VB.CommandButton Command20 
      Caption         =   "Reset sockets"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   0
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   4560
      Width           =   1575
   End
   Begin VB.PictureBox picCont 
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      Height          =   2940
      Left            =   120
      ScaleHeight     =   196
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   305
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   240
      Width           =   4575
      Begin VB.CommandButton cmdActualizarSonidos 
         Caption         =   "SONIDOS AMBIENTALES"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   2040
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   1560
         Width           =   2325
      End
      Begin VB.CommandButton Command9 
         Caption         =   "Actualizar oro y exp"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   3240
         TabIndex        =   24
         TabStop         =   0   'False
         Top             =   1080
         Width           =   1125
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   4080
         TabIndex        =   20
         Text            =   "0.3"
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   2880
         TabIndex        =   19
         Text            =   "0.3"
         Top             =   2160
         Width           =   375
      End
      Begin VB.CommandButton Command1 
         Caption         =   "OBJ.DAT"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   17
         Top             =   120
         Width           =   1785
      End
      Begin VB.CommandButton Command6 
         Caption         =   "ReSpawn Guardias en posiciones originales"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2160
         TabIndex        =   16
         Top             =   45
         Width           =   2175
      End
      Begin VB.CommandButton Command7 
         Caption         =   "INTERVALOS"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   420
         Left            =   3240
         TabIndex        =   15
         Top             =   480
         Width           =   1170
      End
      Begin VB.CommandButton Command8 
         Caption         =   "HECHIZOS.DAT"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   180
         TabIndex        =   14
         Top             =   405
         Width           =   1785
      End
      Begin VB.CommandButton Command11 
         Caption         =   ".ConnID"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   300
         TabIndex        =   13
         Top             =   1455
         Width           =   1605
      End
      Begin VB.CommandButton Command28 
         Caption         =   "BALANCE.DAT"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   195
         TabIndex        =   12
         Top             =   705
         Width           =   1770
      End
      Begin VB.CommandButton Command16 
         Caption         =   "SERVER.INI"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   2040
         TabIndex        =   11
         Top             =   480
         Width           =   1140
      End
      Begin VB.CommandButton Command17 
         Caption         =   "NPCS.DAT"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   195
         TabIndex        =   10
         Top             =   1020
         Width           =   1740
      End
      Begin VB.CommandButton Command22 
         Caption         =   "Kickear a alguien"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   480
         Left            =   120
         TabIndex        =   9
         Top             =   2400
         Width           =   1650
      End
      Begin VB.CommandButton Command27 
         Caption         =   "UserList"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   390
         Left            =   300
         TabIndex        =   8
         Top             =   1935
         Width           =   1620
      End
      Begin VB.Label Label2 
         Caption         =   "Tala"
         Height          =   255
         Left            =   3600
         TabIndex        =   22
         Top             =   2160
         Width           =   495
      End
      Begin VB.Label Label1 
         Caption         =   "Pesca"
         Height          =   255
         Left            =   2400
         TabIndex        =   21
         Top             =   2160
         Width           =   495
      End
   End
End
Attribute VB_Name = "frmServidor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmdActualizarSonidos_Click()
    Call SonidosMapas.LoadSoundMapInfo
    Dim i As Long

    For i = 1 To NumMaps
        MapInfo(i).music = GetVar(App.path & "/Maps/Mapa" & i, "Mapa" & i, "MusicNum")
    Next i
End Sub

Private Sub cmdReloadQuests_Click()
    Call LoadQuests
End Sub

Private Sub cmdSpawnList_Click()
    Call CargarSpawnList
End Sub

Private Sub Command1_Click()
    Call LoadOBJData
End Sub

Private Sub Command11_Click()
    frmConID.Show
End Sub


Private Sub Command12_Click()

End Sub

Private Sub Command15_Click()
    On Error Resume Next

    Dim Fn As String
    Dim cad$
    Dim N As Integer, k As Integer

    Dim sENtrada As String

    sENtrada = InputBox("Escribe ""estoy DE acuerdo"" entre comillas y con distinción de mayúsculas minúsculas para desbanear a todos los personajes.", "UnBan", "hola")
    If sENtrada = "estoy DE acuerdo" Then

        Fn = App.path & "\logs\GenteBanned.log"

        If FileExist(Fn, vbNormal) Then
            N = FreeFile
            Open Fn For Input Shared As #N
            Do While Not EOF(N)
                k = k + 1
                Input #N, cad$
                Call UnBan(cad$)

            Loop
            Close #N
            MsgBox "Se han habilitado " & k & " personajes."
            Kill Fn
        End If
    End If

End Sub

Private Sub Command16_Click()
    Call LoadSini
    Call loadAdministrativeUsers
    Call seguridad_clones_limpiar

End Sub

Private Sub Command17_Click()
    Call CargaNpcsDat
End Sub

Private Sub Command18_Click()
'Me.MousePointer = 11

    Call GuardarUsuarios
    ' Me.MousePointer = 0
End Sub

Private Sub Command19_Click()
    On Error GoTo Command19_Click_Err
    Dim i As Long, N As Long

    Dim sENtrada As String

100 sENtrada = InputBox("Escribe ""estoy DE acuerdo"" sin comillas y con distición de mayusculas minusculas para desbanear a todos los personajes", "UnBan", "hola")

102 If sENtrada = "estoy DE acuerdo" Then

104     N = IP_Blacklist.count

106     For i = 1 To N
108         IP_Blacklist.Remove (0)
110     Next i

112     MsgBox "Se han habilitado " & N & " ipes"

    End If


    Exit Sub

Command19_Click_Err:
114 Call LogError("frmServidor.Command19_Click en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub Command2_Click()
    frmServidor.Visible = False
End Sub

Private Sub Command20_Click()
    Dim LoopC As Long
    If MsgBox("Esta seguro que desea reiniciar los sockets ? Se cerrarán todas las conexiones activas.", vbYesNo, "Reiniciar Sockets") = vbYes Then
102     Call modEngine.NetClose

104     For LoopC = 1 To maxUsers
106         Call CloseSocket(LoopC)
        Next
        
        Call modEngine.NetListen("0.0.0.0", Puerto)
    
    End If

End Sub

Private Sub Command22_Click()
    Me.Visible = False
    frmAdmin.Show
End Sub

Private Sub Command23_Click()
    If MsgBox("¿Está seguro que desea hacer WorldSave, guardar pjs y cerrar?", vbYesNo, "Apagar Magicamente") = vbYes Then
        Me.MousePointer = 11

        FrmStat.Show

        'WorldSave
        Call ES.DoBackUp

        'Guardar Pjs
        Call GuardarUsuarios

        'Chauuu
        Unload frmMain
    End If
End Sub

Private Sub Command26_Click()
    Call modEngine.NetClose
    Call modEngine.NetListen("0.0.0.0", Puerto)
End Sub

Private Sub Command27_Click()
    frmUserList.Show
End Sub

Private Sub Command28_Click()
    Call LoadBalance
End Sub

Private Sub Command3_Click()
    LoadRates
End Sub

Private Sub Command4_Click()
    On Error GoTo eh
    Me.MousePointer = 11
    FrmStat.Show
    Call ES.DoBackUp
    Me.MousePointer = 0
    'MsgBox "WORLDSAVE OK!!"
    FrmStat.Hide

    Exit Sub
eh:
    Call LogError("Error en WORLDSAVE")
End Sub

Private Sub Command5_Click()

    On Error Resume Next

    FrmStat.Show

   Call modEngine.NetClose
   
    Dim LoopC As Integer

    For LoopC = 1 To maxUsers
        Call CloseSocket(LoopC)
    Next

    LastUser = 0
    NumUsers = 0

    Call FreeNPCs
    Call FreeCharIndexes

    Call LoadSini
    Call CargarBackUp
    Call LoadOBJData
    
    Call modEngine.NetListen("0.0.0.0", Puerto)

End Sub

Private Sub Command6_Click()
    Call ReSpawnOrigPosNpcs
End Sub

Private Sub Command7_Click()
    FrmInterv.Show
End Sub

Private Sub Command8_Click()
    Call CargarHechizos
End Sub

Private Sub Command9_Click()
    Dim i As Long

    For i = LBound(Npclist) To UBound(Npclist)
        Npclist(i).Stats.MinHP = Npclist(i).Stats.MaxHP
        Npclist(i).GiveEXP = Npclist(i).GiveEXP_Orig * ExpMulti
        Npclist(i).GiveGLD = Npclist(i).GiveGLD_Orig * OroMulti
    Next i

    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> La experiencia de los NPC ha sido actualizada: x" & ExpMulti, FontTypeNames.FONTTYPE_SERVER))
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> El oro de los NPC ha sido actualizada: x" & OroMulti, FontTypeNames.FONTTYPE_SERVER))

End Sub

Private Sub Form_Deactivate()
    frmServidor.Visible = False
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then frmServidor.Visible = False
End Sub

Private Sub Form_Load()

    Command20.Visible = True
    Command26.Visible = True

End Sub

