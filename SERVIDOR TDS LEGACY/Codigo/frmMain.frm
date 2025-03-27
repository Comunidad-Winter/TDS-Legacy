VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "mswinsck.ocx"
Begin VB.Form frmMain 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "TDSL Server"
   ClientHeight    =   4560
   ClientLeft      =   1950
   ClientTop       =   1815
   ClientWidth     =   6750
   ControlBox      =   0   'False
   FillColor       =   &H00C0C0C0&
   BeginProperty Font 
      Name            =   "Arial"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000004&
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4560
   ScaleWidth      =   6750
   StartUpPosition =   2  'CenterScreen
   WindowState     =   1  'Minimized
   Begin VB.Timer BOT_Interval 
      Interval        =   160
      Left            =   2160
      Top             =   4080
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Reiniciar socket"
      Height          =   255
      Left            =   120
      TabIndex        =   19
      Top             =   3840
      Width           =   1935
   End
   Begin VB.CommandButton Command6 
      Caption         =   "resetear _post"
      Height          =   375
      Left            =   4800
      TabIndex        =   18
      Top             =   3240
      Width           =   1815
   End
   Begin VB.CheckBox chkDebug2 
      Caption         =   "Debug/SALIR"
      Height          =   255
      Left            =   4800
      TabIndex        =   17
      Top             =   4320
      Width           =   1935
   End
   Begin VB.CheckBox chkDebug 
      Caption         =   "DebugConnection"
      Height          =   255
      Left            =   4800
      TabIndex        =   16
      Top             =   4080
      Width           =   1935
   End
   Begin VB.CheckBox chkwebSystem 
      Caption         =   "Enlazar web"
      Height          =   255
      Left            =   4800
      TabIndex        =   15
      Top             =   3600
      Value           =   1  'Checked
      Width           =   1815
   End
   Begin VB.Timer Timer2 
      Interval        =   1000
      Left            =   1080
      Top             =   2880
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   6480
      TabIndex        =   14
      Text            =   "5"
      Top             =   0
      Width           =   495
   End
   Begin VB.Timer NewGameTimer 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   240
      Top             =   2520
   End
   Begin VB.CommandButton Command7 
      Caption         =   "mapNames.txt"
      Height          =   375
      Left            =   5640
      TabIndex        =   12
      Top             =   2520
      Width           =   1215
   End
   Begin MSWinsockLib.Winsock sck_PostWEB 
      Left            =   4440
      Top             =   3240
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemoteHost      =   "127.0.0.1"
      RemotePort      =   6667
      LocalPort       =   6665
   End
   Begin VB.Timer Timer1 
      Interval        =   700
      Left            =   120
      Top             =   1800
   End
   Begin VB.CommandButton Command4 
      Caption         =   "find items"
      Height          =   375
      Left            =   6000
      TabIndex        =   8
      Top             =   1680
      Width           =   960
   End
   Begin VB.CommandButton Command5 
      Caption         =   "objNames"
      Height          =   270
      Left            =   5640
      TabIndex        =   7
      Top             =   2160
      Width           =   1515
   End
   Begin VB.CommandButton Command3 
      Caption         =   "optimizar hechi.dat"
      Height          =   255
      Left            =   6240
      TabIndex        =   6
      Top             =   2880
      Visible         =   0   'False
      Width           =   1740
   End
   Begin VB.Timer packetResend 
      Interval        =   10
      Left            =   3900
      Top             =   180
   End
   Begin VB.Timer tPiqueteC 
      Enabled         =   0   'False
      Interval        =   6000
      Left            =   4110
      Top             =   165
   End
   Begin VB.Timer AutoSave 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   4320
      Top             =   165
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00808080&
      Caption         =   "Mensaje al mundo"
      ForeColor       =   &H00FFFFFF&
      Height          =   1095
      Left            =   -15
      TabIndex        =   1
      Top             =   600
      Width           =   6705
      Begin VB.Timer tmrPingWEB 
         Interval        =   10000
         Left            =   120
         Top             =   600
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Enviar a la consola"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3480
         TabIndex        =   5
         Top             =   675
         Width           =   2295
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Enviar en caja de texto"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   840
         TabIndex        =   4
         Top             =   690
         Width           =   2295
      End
      Begin VB.TextBox BroadMsg 
         Height          =   315
         Left            =   780
         TabIndex        =   3
         Top             =   240
         Width           =   5100
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Texto:"
         ForeColor       =   &H00FFFFFF&
         Height          =   255
         Index           =   0
         Left            =   255
         TabIndex        =   2
         Top             =   270
         Width           =   585
      End
   End
   Begin VB.Timer tLluviaEvent 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   4515
      Top             =   165
   End
   Begin VB.Timer KillLog 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   4695
      Top             =   165
   End
   Begin VB.Timer securityTimer 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   4845
      Top             =   165
   End
   Begin VB.Timer GameTimer 
      Interval        =   40
      Left            =   3240
      Top             =   0
   End
   Begin VB.Timer TIMER_AI 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   5190
      Top             =   195
   End
   Begin VB.Timer npcataca 
      Enabled         =   0   'False
      Interval        =   4000
      Left            =   5355
      Top             =   165
   End
   Begin VB.Timer FX 
      Enabled         =   0   'False
      Interval        =   4000
      Left            =   5580
      Top             =   210
   End
   Begin VB.Timer Auditoria 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   5805
      Top             =   225
   End
   Begin MSWinsockLib.Winsock sck_SendMail 
      Left            =   945
      Top             =   180
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
      RemoteHost      =   "127.0.0.1"
      RemotePort      =   6778
      LocalPort       =   3999
   End
   Begin VB.Label lblMenos 
      Alignment       =   2  'Center
      Caption         =   "-"
      Height          =   255
      Left            =   480
      TabIndex        =   21
      Top             =   360
      Width           =   255
   End
   Begin VB.Label lblMas 
      Alignment       =   2  'Center
      Caption         =   "+"
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   360
      Width           =   255
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   "NewGameTimer"
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   13
      Top             =   2280
      Width           =   1335
   End
   Begin VB.Label lblSocketWEB 
      BackStyle       =   0  'Transparent
      Caption         =   ".."
      Height          =   375
      Left            =   0
      TabIndex        =   11
      Top             =   4200
      Width           =   6735
   End
   Begin VB.Label lblSock 
      BackStyle       =   0  'Transparent
      Caption         =   ".."
      Height          =   495
      Left            =   0
      TabIndex        =   10
      Top             =   3600
      Width           =   6855
   End
   Begin VB.Label lblBytesEntrada 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "sqsqsqsq"
      ForeColor       =   &H000040C0&
      Height          =   210
      Left            =   5160
      TabIndex        =   9
      Top             =   0
      Width           =   1560
   End
   Begin VB.Label CantUsuarios 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "ON: 0"
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
      Height          =   195
      Left            =   45
      TabIndex        =   0
      Top             =   30
      Width           =   420
   End
   Begin VB.Menu mnuControles 
      Caption         =   "Acciones"
      Begin VB.Menu mnuServidor 
         Caption         =   "Configuraciones"
      End
      Begin VB.Menu mnuSystray 
         Caption         =   "Minimizar a la bandeja"
      End
      Begin VB.Menu mnuCerrar 
         Caption         =   "Apagar"
      End
   End
   Begin VB.Menu mnuPopUp 
      Caption         =   "PopUpMenu"
      Visible         =   0   'False
      Begin VB.Menu mnuMostrar 
         Caption         =   "&Mostrar"
      End
      Begin VB.Menu mnuSalir 
         Caption         =   "&Salir"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public ESCUCHADAS As Long

Private Type NOTIFYICONDATA
    cbSize As Long
    hWnd As Long
    uID As Long
    uFlags As Long
    uCallbackMessage As Long
    hIcon As Long
    szTip As String * 64
End Type

Const NIM_ADD = 0
Const NIM_DELETE = 2
Const NIF_MESSAGE = 1
Const NIF_ICON = 2
Const NIF_TIP = 4

Const WM_MOUSEMOVE = &H200
Const WM_LBUTTONDBLCLK = &H203
Const WM_RBUTTONUP = &H205

Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hWnd As Long, lpdwProcessId As Long) As Long
Private Declare Function Shell_NotifyIconA Lib "SHELL32" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Integer

Private Function setNOTIFYICONDATA(hWnd As Long, ID As Long, flags As Long, CallbackMessage As Long, Icon As Long, Tip As String) As NOTIFYICONDATA
    Dim nidTemp As NOTIFYICONDATA

    nidTemp.cbSize = Len(nidTemp)
    nidTemp.hWnd = hWnd
    nidTemp.uID = ID
    nidTemp.uFlags = flags
    nidTemp.uCallbackMessage = CallbackMessage
    nidTemp.hIcon = Icon
    nidTemp.szTip = Tip & Chr$(0)

    setNOTIFYICONDATA = nidTemp
End Function

Sub CheckIdleUser()
    Dim iUserIndex As Long

    For iUserIndex = 1 To maxUsers
        With UserList(iUserIndex)
            'Conexion activa? y es un usuario loggeado?
            If .ConnIDValida And .flags.UserLogged Then

                Call PassMinuteAntiFrags(iUserIndex)

                If Not EsGM(iUserIndex) And .flags.EnEvento = 0 Then

                    .Counters.IdleCount = .Counters.IdleCount + 1

                    Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, iUserIndex, PrepareMessageUpdateCharData(iUserIndex))

                    If .Counters.IdleCount >= IdleLimit Then
                        Call WriteShowMessageBox(iUserIndex, "Demasiado tiempo inactivo. Has sido desconectado.")
                        If .ComUsu.DestUsu > 0 Then    'mato los comercios seguros
                            If UserList(.ComUsu.DestUsu).flags.UserLogged Then
                                If UserList(.ComUsu.DestUsu).ComUsu.DestUsu = iUserIndex Then
                                    WriteMensajes .ComUsu.DestUsu, e_Mensajes.Mensaje_129
                                    Call FinComerciarUsu(.ComUsu.DestUsu)
                                End If
                            End If
                            Call FinComerciarUsu(iUserIndex)
                        End If
                        Call Cerrar_Usuario(iUserIndex)
                    End If

                End If
            End If
        End With
    Next iUserIndex
End Sub

Private Sub Auditoria_Timer()
    On Error GoTo errhand
    Static centinelSecs As Byte

    centinelSecs = centinelSecs + 1

1   If centinelSecs = 5 Then
        'Every 5 seconds, we try to call the player's attention so it will report the code.
2       Call modCentinela.CallUserAttention

3       centinelSecs = 0
    End If

4   Call PasarSegundo        'sistema de desconexion de 10 segs

    'Call ActualizaEstadisticasWeb

    Exit Sub

errhand:

    Call LogError("Error en Timer Auditoria. " & Erl & " Err: " & Err.Description & " - " & Err.Number)
    Resume Next

End Sub

Private Sub AutoSave_Timer()

    On Error GoTo Errhandler
    'fired every minute
    Static Minutos As Long
    Static MinutosLatsClean As Long

    Minutos = Minutos + 1

    '¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
    Call ModAreas.AreasOptimizacion
    '¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿

    'Actualizamos el centinela
    Call modCentinela.PasarMinutoCentinela

    If Minutos = MinutosWs - 1 Then
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Worldsave en 1 minuto ...", FontTypeNames.FONTTYPE_VENENO))
    End If

    If Minutos = MinutosWs - 3 Then
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Worldsave en 3 minutos ...", FontTypeNames.FONTTYPE_VENENO))
    End If

    If Minutos = MinutosWs - 10 Then
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Worldsave en 10 minutos ...", FontTypeNames.FONTTYPE_VENENO))
    End If

    If Minutos = MinutosWs - 15 Then
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Worldsave en 15 minutos ...", FontTypeNames.FONTTYPE_VENENO))
    End If

    If Minutos >= MinutosWs Then
        Call ES.DoBackUp
        Call aClon.VaciarColeccion
        Minutos = 0
    End If

    If MinutosLatsClean >= 360 Then
        MinutosLatsClean = 0
        Call ReSpawnOrigPosNpcs        'respawn de los guardias en las pos originales
        Call LimpiarMundo
    Else
        MinutosLatsClean = MinutosLatsClean + 1
    End If

    Call PurgarPenas
    Call CheckIdleUser

    Exit Sub
Errhandler:
    Call LogError("Error en TimerAutoSave " & Err.Number & ": " & Err.Description)
    Resume Next
End Sub

Private Sub BOT_Interval_Timer()
    Dim iUserIndex As Integer

    If m_ArenaBots.NumInvocados > 0 Then
        For iUserIndex = 1 To m_ArenaBots.MAX_BOTS
            If IA_Bot(iUserIndex).Summoned Then
                If IA_Bot(iUserIndex).TargetIndex > 0 Then
                    If UserList(IA_Bot(iUserIndex).TargetIndex).ConnIDValida Then
                        Call IA_Action(iUserIndex)
                    End If
                End If
            End If
        Next iUserIndex
    End If

End Sub

Private Sub Command1_Click()
    Call SendData(SendTarget.ToAll, 0, PrepareMessageShowMessageBox(BroadMsg.Text))

    'txtChat.Text = txtChat.Text & vbNewLine & "Servidor> " & BroadMsg.Text
End Sub

Public Sub InitMain(ByVal f As Byte)

    If f = 1 Then
        Call mnuSystray_Click
    Else
        frmMain.Show
    End If

End Sub

Private Sub Command2_Click()
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> " & BroadMsg.Text, FontTypeNames.FONTTYPE_SERVER))

    'txtChat.Text = txtChat.Text & vbNewLine & "Servidor> " & BroadMsg.Text
End Sub

Private Sub Command3_Click()
' @ cui
    Dim Str As String
    Str = "[INIT]" & vbCrLf & "NumeroHechizos=" & NumeroHechizos & vbCrLf
    Dim Hechizo As Long

    For Hechizo = 1 To NumeroHechizos
        With Hechizos(Hechizo)

            Str = Str & vbCrLf & "[HECHIZO" & Hechizo & "]"
            If Len(.Nombre) > 0 Then Str = Str & vbCrLf & "Nombre=" & .Nombre
            If Len(.Desc) > 0 Then Str = Str & vbCrLf & "Desc=" & .Desc
            If Len(.PalabrasMagicas) > 0 Then Str = Str & vbCrLf & "PalabrasMagicas=" & .PalabrasMagicas
            If Len(.HechizeroMsg) > 0 Then Str = Str & vbCrLf & "HechizeroMsg=" & .HechizeroMsg
            If Len(.TargetMsg) > 0 Then Str = Str & vbCrLf & "TargetMsg=" & .TargetMsg
            If Len(.PropioMsg) > 0 Then Str = Str & vbCrLf & "PropioMsg=" & .PropioMsg
            If .tipo > 0 Then Str = Str & vbCrLf & "Tipo=" & .tipo
            If .WAV > 0 Then Str = Str & vbCrLf & "WAV=" & .WAV
            If .FXgrh > 0 Then Str = Str & vbCrLf & "FXgrh=" & .FXgrh
            If .GrhTravel > 0 Then Str = Str & vbCrLf & "GrhTravel=" & .GrhTravel
            If .loops > 0 Then Str = Str & vbCrLf & "Loops=" & .loops
            If .SubeHP > 0 Then Str = Str & vbCrLf & "SubeHP=" & .SubeHP
            If .MinHP > 0 Then Str = Str & vbCrLf & "MinHp=" & .MinHP
            If .MaxHP > 0 Then Str = Str & vbCrLf & "MaxHp=" & .MaxHP


            If .SubeMana > 0 Then Str = Str & vbCrLf & "SubeMana=" & .SubeMana
            If .MiMana > 0 Then Str = Str & vbCrLf & "MinMana=" & .MiMana
            If .MaMana > 0 Then Str = Str & vbCrLf & "MaxMana=" & .MaMana
            If .SubeSta > 0 Then Str = Str & vbCrLf & "SubeSta=" & .SubeSta
            If .minSta > 0 Then Str = Str & vbCrLf & "MinSta=" & .minSta
            If .MaxSta > 0 Then Str = Str & vbCrLf & "MaxSta=" & .MaxSta
            If .SubeHam > 0 Then Str = Str & vbCrLf & "SubeHam=" & .SubeHam
            If .MinHam > 0 Then Str = Str & vbCrLf & "MinHam=" & .MinHam
            If .MaxHam > 0 Then Str = Str & vbCrLf & "MaxHam=" & .MaxHam
            If .SubeSed > 0 Then Str = Str & vbCrLf & "SubeSed=" & .SubeSed
            If .MinSed > 0 Then Str = Str & vbCrLf & "MinSed=" & .MinSed
            If .MaxSed > 0 Then Str = Str & vbCrLf & "MaxSed=" & .MaxSed


            If .SubeAgilidad > 0 Then Str = Str & vbCrLf & "SubeAG=" & .SubeAgilidad
            If .MinAgilidad > 0 Then Str = Str & vbCrLf & "MinAG=" & .MinAgilidad
            If .MaxAgilidad > 0 Then Str = Str & vbCrLf & "MaxAG=" & .MaxAgilidad
            If .SubeFuerza > 0 Then Str = Str & vbCrLf & "SubeFU=" & .SubeFuerza
            If .MinFuerza > 0 Then Str = Str & vbCrLf & "MinFU=" & .MinFuerza
            If .MaxFuerza > 0 Then Str = Str & vbCrLf & "MaxFU=" & .MaxFuerza
            If .SubeCarisma > 0 Then Str = Str & vbCrLf & "SubeCA=" & .SubeCarisma
            If .MinCarisma > 0 Then Str = Str & vbCrLf & "MinCA=" & .MinCarisma
            If .MaxCarisma > 0 Then Str = Str & vbCrLf & "MaxCA=" & .MaxCarisma
            If .Invisibilidad > 0 Then Str = Str & vbCrLf & "Invisibilidad=" & .Invisibilidad
            If .Paraliza > 0 Then Str = Str & vbCrLf & "Paraliza=" & .Paraliza
            If .Inmoviliza > 0 Then Str = Str & vbCrLf & "Inmoviliza=" & .Inmoviliza
            If .RemoverParalisis > 0 Then Str = Str & vbCrLf & "RemoverParalisis=" & .RemoverParalisis
            If .RemoverEstupidez > 0 Then Str = Str & vbCrLf & "RemoverEstupidez=" & .RemoverEstupidez
            If .RemueveInvisibilidadParcial > 0 Then Str = Str & vbCrLf & "RemueveInvisibilidadParcial=" & .RemueveInvisibilidadParcial
            If .CuraVeneno > 0 Then Str = Str & vbCrLf & "CuraVeneno=" & .CuraVeneno
            If .Envenena > 0 Then Str = Str & vbCrLf & "Envenena=" & .Envenena
            If .Revivir > 0 Then Str = Str & vbCrLf & "Revivir=" & .Revivir
            If .Ceguera > 0 Then Str = Str & vbCrLf & "Ceguera=" & .Ceguera
            If .Estupidez > 0 Then Str = Str & vbCrLf & "Estupidez=" & .Estupidez
            If .Warp > 0 Then Str = Str & vbCrLf & "Warp=" & .Warp
            If .Invoca > 0 Then Str = Str & vbCrLf & "Invoca=" & .Invoca
            If .NumNpc > 0 Then Str = Str & vbCrLf & "NumNpc=" & .NumNpc
            If .Cant > 0 Then Str = Str & vbCrLf & "cant=" & .Cant
            If .Mimetiza > 0 Then Str = Str & vbCrLf & "Mimetiza=" & .Mimetiza
            If .MinSkill > 0 Then Str = Str & vbCrLf & "MinSkill=" & .MinSkill
            If .ManaRequerido > 0 Then Str = Str & vbCrLf & "ManaRequerido=" & .ManaRequerido
            If .StaRequerido > 0 Then Str = Str & vbCrLf & "StaRequerido=" & .StaRequerido
            If .Target > 0 Then Str = Str & vbCrLf & "Target=" & .Target
            If .NeedStaff > 0 Then Str = Str & vbCrLf & "NeedStaff=" & .NeedStaff
            If .StaffAffected > 0 Then Str = Str & vbCrLf & "StaffAffected=" & CBool(.StaffAffected)

        End With

        Str = Str & vbCrLf
    Next Hechizo
    Exit Sub

    Dim nFile As Integer
    nFile = FreeFile

    Open "C:\Users\Usuario\Desktop\aca.txt" For Append Shared As #nFile
    Print #nFile, Str
    Close #nFile
End Sub

Private Sub Command4_Click()
    Dim Map As Long
    Dim X As Byte
    Dim Y As Byte

    For Map = 1 To NumMaps
        'If MapInfo(map).pk = False Then
        For X = 1 To 99
            For Y = 1 To 99
                With MapData(Map, X, Y)

                    If Not .TileExit.Map = 0 And .ObjInfo.ObjIndex Then
                        If ObjData(.ObjInfo.ObjIndex).OBJType = eOBJType.otTeleport Then
                            Debug.Print Map, X, Y, "Warp a: " & .TileExit.Map & "-" & .TileExit.X & "-" & .TileExit.Y
                        End If
                    End If

                    'If .npcIndex Then
                    '    If Not Npclist(.npcIndex).GiveEXP = 0 Then
                    '        Debug.Print map, x, y, Npclist(.npcIndex).Name
                    '    End If
                    'End If

                    'If .ObjInfo.ObjIndex = 7 Or .ObjInfo.ObjIndex = 16 Or .ObjInfo.ObjIndex = 51 Or .ObjInfo.ObjIndex = 55 Or .ObjInfo.ObjIndex = 66 Or .ObjInfo.ObjIndex = 70 Or .ObjInfo.ObjIndex = 74 Or .ObjInfo.ObjIndex = 88 Or .ObjInfo.ObjIndex = 92 Or .ObjInfo.ObjIndex = 96 Or .ObjInfo.ObjIndex = 100 Or .ObjInfo.ObjIndex = 104 Or .ObjInfo.ObjIndex = 108 & _
                     112 Or .ObjInfo.ObjIndex = 116 Or .ObjInfo.ObjIndex = 120 Or .ObjInfo.ObjIndex = 141 Or .ObjInfo.ObjIndex = 171 Or .ObjInfo.ObjIndex = 175 Or .ObjInfo.ObjIndex = 184 Or .ObjInfo.ObjIndex = 179 Or .ObjInfo.ObjIndex = 241 Or .ObjInfo.ObjIndex = 244 Or .ObjInfo.ObjIndex = 246 Or .ObjInfo.ObjIndex = 248 Or .ObjInfo.ObjIndex = 250 Or .ObjInfo.ObjIndex = 252 Or .ObjInfo.ObjIndex = 254 Or .ObjInfo.ObjIndex = 263 Or .ObjInfo.ObjIndex = 267 Or .ObjInfo.ObjIndex = 271 Or .ObjInfo.ObjIndex = 275 Or .ObjInfo.ObjIndex = 279 & _
                     283 Or .ObjInfo.ObjIndex = 287 Or .ObjInfo.ObjIndex = 291 Or .ObjInfo.ObjIndex = 295 Or .ObjInfo.ObjIndex = 299 Or .ObjInfo.ObjIndex = 303 Or .ObjInfo.ObjIndex = 307 Or .ObjInfo.ObjIndex = 311 Or .ObjInfo.ObjIndex = 320 Or .ObjInfo.ObjIndex = 324 Or .ObjInfo.ObjIndex = 328 Or .ObjInfo.ObjIndex = 332 Or .ObjInfo.ObjIndex = 336 Or .ObjInfo.ObjIndex = 340 Or .ObjInfo.ObjIndex = 344 Or .ObjInfo.ObjIndex = 348 Or .ObjInfo.ObjIndex = 352 Or .ObjInfo.ObjIndex = 373 Or .ObjInfo.ObjIndex = 417 Or .ObjInfo.ObjIndex = 421 Or .ObjInfo.ObjIndex = 425 & _
                     429 Or .ObjInfo.ObjIndex = 433 Or .ObjInfo.ObjIndex = 437 Or .ObjInfo.ObjIndex = 441 Or .ObjInfo.ObjIndex = 445 Or .ObjInfo.ObjIndex = 449 Or .ObjInfo.ObjIndex = 580 Or .ObjInfo.ObjIndex = 584 Or .ObjInfo.ObjIndex = 588 Or .ObjInfo.ObjIndex = 592 Or .ObjInfo.ObjIndex = 596 Or .ObjInfo.ObjIndex = 600 Or .ObjInfo.ObjIndex = 604 Or .ObjInfo.ObjIndex = 608 Or .ObjInfo.ObjIndex = 687 Or .ObjInfo.ObjIndex = 691 Or .ObjInfo.ObjIndex = 695 Or .ObjInfo.ObjIndex = 699 Or .ObjInfo.ObjIndex = 703 Or .ObjInfo.ObjIndex = 707 Then

                    '.ObjInfo.ObjIndex = ObjData(.ObjInfo.ObjIndex).IndexCerrada

                    'End If
                End With
            Next Y
        Next X
        'End If
    Next Map

End Sub

Private Sub Command5_Click()
    Dim i As Long
    Dim Str As String
    Dim nFile As Integer

    Str = "insert into object(number, name) values (?,?)"

    For i = 1 To NumObjDatas
        '(?,?)
        Str = Str & vbNewLine & "(" & i & ",'" & ObjData(i).Name & "'), "
    Next i


    nFile = FreeFile        ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\query_objetcs.log" For Append Shared As #nFile
    Print #nFile, Str
    Close #nFile

End Sub

Private Sub Command6_Click()

    frmMain.sck_PostWEB.Close

    DoEvents

    sck_PostWEB.connect

    DoEvents

    Debug.Print Now, sck_PostWEB.State


End Sub

Private Sub Command7_Click()
    Dim i As Long
    Dim Str As String
    Dim nFile As Integer

    For i = 1 To NumMaps

        'Mapa( ) = " "
        Str = Str & vbNewLine & "Mapa(" & i & ") = " & Chr(34) & MapInfo(i).Name & Chr(34)
    Next i
    nFile = FreeFile        ' obtenemos un canal
    'Guardamos todo en el mismo lugar. Pablo (ToxicWaste) 18/05/07
    Open App.path & "\logs\mapas.log" For Append Shared As #nFile
    Print #nFile, Str
    Close #nFile
End Sub

Private Sub Command8_Click()

    Call SocketConfig

End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next

    If Not Visible Then
        Select Case X \ Screen.TwipsPerPixelX

        Case WM_LBUTTONDBLCLK
            WindowState = vbNormal
            Visible = True
            Dim hProcess As Long
            GetWindowThreadProcessId hWnd, hProcess
            AppActivate hProcess
        Case WM_RBUTTONUP
            hHook = SetWindowsHookEx(WH_CALLWNDPROC, AddressOf AppHook, App.hInstance, App.ThreadID)
            PopupMenu mnuPopUp
            If hHook Then UnhookWindowsHookEx hHook: hHook = 0
        End Select
    End If

End Sub

Private Sub cmdloadBotArenasPos_Click()
    Call LoadBotArenasPos
End Sub

Private Sub QuitarIconoSystray()
    On Error Resume Next

    'Borramos el icono del systray
    Dim i As Long
    Dim nid As NOTIFYICONDATA

    nid = setNOTIFYICONDATA(frmMain.hWnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, vbNull, frmMain.Icon, "")

    i = Shell_NotifyIconA(NIM_DELETE, nid)


End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next

    Call QuitarIconoSystray

    Dim LoopC As Integer

    For LoopC = 1 To maxUsers
        If UserList(LoopC).ConnIDValida Then Call CloseSocket(LoopC)
    Next

    Call LimpiaWsApi

    'Log
    'Dim N As Integer
    'N = FreeFile
    'Open App.path & "\logs\Main.log" For Append Shared As #N
    'Print #N, Date & " " & Time & " server cerrado."
    'Close #N
    Call seguridad_clones_destruir
    Set SonidosMapas = Nothing
    End
End Sub

Private Sub FX_Timer()
    On Error GoTo hayerror

    Call SonidosMapas.ReproducirSonidosDeMapas

    Exit Sub
hayerror:

End Sub

Public Sub GameTimer_Timer()
'********************************************************
'Author: Unknown
'Last Modify Date: -
'********************************************************
    Dim iUserIndex As Long
    Dim bEnviarStats As Boolean
    Dim bEnviarAyS As Boolean

    On Error GoTo hayerror

    '<<<<<< Procesa eventos de los usuarios >>>>>>
    For iUserIndex = 1 To maxUsers        'LastUser
        With UserList(iUserIndex)
            'Conexion activa?
            If .ConnIDValida Then

                If .flags.UserLogged Then

                    bEnviarStats = False
                    bEnviarAyS = False

                    If .flags.Paralizado = 1 Then Call EfectoParalisisUser(iUserIndex)
                    If .flags.Ceguera = 1 Or .flags.Estupidez Then Call EfectoCegueEstu(iUserIndex)

                    If .flags.Muerto = 0 Then

                        '[Consejeros]
                        If Not EsGM(iUserIndex) Or (EsGM(iUserIndex) And .flags.AdminPerseguible) Then
                            Call EfectoFrio(iUserIndex)
                            Call EfectoFrio1(iUserIndex)
                            Call EfectoVeneno(iUserIndex)
                        End If

                        If .flags.Meditando Then
                            Call DoMeditar(iUserIndex)
                        End If

                        If .flags.AdminInvisible <> 1 Then
                            If .flags.invisible = 1 Then Call EfectoInvisibilidad(iUserIndex)
                            'If .flags.oculto = 1 Then Call DoPermanecerOculto(iUserIndex)
                        End If

                        If .flags.Mimetizado = 1 Then Call EfectoMimetismo(iUserIndex)

                        Call DuracionPociones(iUserIndex)

                        Call HambreYSed(iUserIndex, bEnviarAyS)


                        If .flags.Hambre = 0 And .flags.Sed = 0 Then

                            If Not .flags.Descansar Then
                                'No esta descansando

                                Call Sanar(iUserIndex, bEnviarStats, SanaIntervaloSinDescansar)
                                If bEnviarStats Then
                                    Call WriteUpdateHP(iUserIndex)
                                    bEnviarStats = False
                                End If
                                Call RecStamina(iUserIndex, bEnviarStats, IIf(UserList(iUserIndex).flags.Desnudo, StaminaIntervaloSinDescansar, 10))
                                If bEnviarStats Then
                                    Call WriteUpdateSta(iUserIndex)
                                    bEnviarStats = False
                                End If

                            Else
                                'esta descansando

                                Call Sanar(iUserIndex, bEnviarStats, SanaIntervaloDescansar)
                                If bEnviarStats Then
                                    Call WriteUpdateHP(iUserIndex)
                                    bEnviarStats = False
                                End If
                                Call RecStamina(iUserIndex, bEnviarStats, StaminaIntervaloDescansar)
                                If bEnviarStats Then
                                    Call WriteUpdateSta(iUserIndex)
                                    bEnviarStats = False
                                End If
                                'termina de descansar automaticamente
                                If .Stats.MaxHP = .Stats.MinHP And .Stats.MaxSta = .Stats.minSta Then
                                    Call WriteRestOK(iUserIndex)

                                    WriteMensajes iUserIndex, e_Mensajes.Mensaje_130
                                    .flags.Descansar = False
                                End If

                            End If

                        End If

                        If bEnviarAyS Then Call WriteUpdateHungerAndThirst(iUserIndex)

                        'Added to NowGameTimer - If .NroMascotas > 0 Then Call TiempoInvocacion(iUserIndex)

                    End If        'Muerto
                End If        'UserLogged

                'If there is anything to be sent, we send it
                'TODO Call modNetwork.Flush(iUserIndex)
            End If
        End With

    Next iUserIndex

    Exit Sub

hayerror:
    LogError ("Error en GameTimer: " & Err.Description & " UserIndex = " & iUserIndex)
End Sub

Private Sub lblMas_Click()
    F_ONLINES = F_ONLINES + 1
    MostrarNumUsers
End Sub

Private Sub lblMenos_Click()
    If F_ONLINES Then
        F_ONLINES = F_ONLINES - 1
    End If
    MostrarNumUsers
End Sub

Private Sub mnuCerrar_Click()

' Limpieza del socket del servidor.
104 Call modEngine.NetClose

    Dim LoopC As Long
106 For LoopC = 1 To maxUsers
108     If UserList(LoopC).ConnIDValida Then
110         Call CloseSocket(LoopC)
        End If
    Next LoopC

    If MsgBox("¡¡Atencion!! Si cierra el servidor puede provocar la perdida de datos. ¿Desea hacerlo de todas maneras?", vbYesNo) = vbYes Then
        Dim f
        For Each f In Forms
            Unload f
        Next
    End If
    End
End Sub

Private Sub mnusalir_Click()
    Call mnuCerrar_Click
End Sub

Public Sub mnuMostrar_Click()
    On Error Resume Next
    WindowState = vbNormal
    Form_MouseMove 0, 0, 7725, 0
End Sub

Private Sub mnuServidor_Click()
    frmServidor.Visible = True
End Sub

Private Sub mnuSystray_Click()

    Dim i As Long
    Dim s As String
    Dim nid As NOTIFYICONDATA

    s = "LEGACY-TDS"
    nid = setNOTIFYICONDATA(frmMain.hWnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, WM_MOUSEMOVE, frmMain.Icon, s)
    i = Shell_NotifyIconA(NIM_ADD, nid)

    If WindowState <> vbMinimized Then WindowState = vbMinimized
    Visible = False

End Sub

Private Sub NewGameTimer_Timer()

    Dim iUserIndex As Integer
    Dim bEnviarStats As Boolean
    Dim bEnviarAyS As Boolean
    Dim bEnviarEnergias As Boolean
    Dim afectaLluvia As Boolean
    Dim tiempo As Long
    Dim ahora As Long

    Static UltimoLoop As Long

    '<<<<<< Procesa eventos de los usuarios >>>>>>
    If UltimoLoop = 0 Then UltimoLoop = 30000

    ahora = GetTickCount
    tiempo = ahora - UltimoLoop

    For iUserIndex = 1 To LastUser
        'Conexion activa?j

        With UserList(iUserIndex)

            ' Los Timers son validos solo para personajes activos
            If .ConnIDValida Then

                '¿User valido?
                If .flags.UserLogged Then

                    bEnviarStats = False
                    bEnviarAyS = False
                    bEnviarEnergias = False

                    If .flags.Muerto = 0 Then    'And UserList(iUserIndex).flags.Privilegios = 0 Then
                        '                    If .flags.Paralizado = 1 Then Call EfectoParalisisUser(UserList(iUserIndex), tiempo)
                        '                   If .flags.Meditando Then Call DoMeditar(UserList(iUserIndex), tiempo)
                        '                    If .flags.Envenenado = 1 Then Call EfectoVeneno(UserList(iUserIndex), bEnviarStats, tiempo)
                        '                    If .flags.invisible = 1 And .flags.oculto = 0 Then Call EfectoInvisibilidad(UserList(iUserIndex), tiempo)
                        '                    If .flags.Mimetizado = 1 Then Call EfectoMimetismo(UserList(iUserIndex), tiempo)
                        '                    If .flags.DuracionEfecto > 0 Then Call DuracionPociones(iUserIndex, tiempo)
                        If .flags.oculto = 1 Then Call DoPermanecerOculto(UserList(iUserIndex), tiempo)
                        If .nroMascotas > 0 Then Call TiempoInvocacion(iUserIndex, tiempo)
                        '                    If .controlCheat.VecesAtack > Me.Sensibilidad Then
                        '                        EnviarPaquete Paquetes.mensajeinfo, .Name & " posible speed para pegar/magia. Gravedad: " & .controlCheat.VecesAtack, 0, ToAdmins
                        '                        .controlCheat.VecesAtack = 0
                        '                    Else
                        '                        .controlCheat.VecesAtack = 0
                        '                    End If
                        '                    If MapInfo(.Pos.map).Frio = 1 Then Call EfectoFrio(iUserIndex, tiempo, bEnviarStats)
                        '                    If MapInfo(.Pos.map).Calor = 1 Then
                        '                        Call EfectoCalor(UserList(iUserIndex), tiempo, bEnviarStats)
                        '                    End If
                        '                    Call HambreYSed(iUserIndex, bEnviarAyS, tiempo)
                        '                    ' ¿Esta lloviendo?
                        '                    ' Si esta lloviendo...
                        '                    '   Si el personaje NO está a la intemperie, o sea se esta mojando.
                        '                    '       Si no está descansando... recupera tipo 4
                        '                    '       Si el personaje está descansnsado... recupera tipo 3
                        '                    '   Si  está a la intemperie
                        '                    '       Si no está desnudo... recupera 4
                        '                    '       Si está desnudo o tiene hambre... recupera tipo 5
                        '                    ' Si NO está lloviendo
                        '                    '   Si NO está descansando, no tiene hambre/sed y no está desnudo.. recupera 2
                        '                    '   Si está descansando... recupera 1
                        '                    '   Si está desnudo... recupera 5
                        '                    If Lloviendo Then
                        '                        '   ¿Le pega el agua?
                        '                        afectaLluvia = modPersonaje.estaALaIntemperie(UserList(iUserIndex))
                        '                    Else
                        '                        afectaLluvia = False
                        '                    End If
                        '                    If afectaLluvia Then
                        '                        If .flags.Desnudo Then
                        '                            ' Pierde energia
                        '                            Call RecStamina(UserList(iUserIndex), 5, bEnviarEnergias)
                        '                        ElseIf .flags.Hambre = 0 And .flags.Sed = 0 Then    ' No tiene ni hambre ni sed
                        '                            ' Gana vida
                        '                            Call Sanar(iUserIndex, bEnviarStats, SanaIntervaloSinDescansar)
                        '                            ' Gana energia
                        '                            Call RecStamina(UserList(iUserIndex), 4, bEnviarEnergias)
                        '                        End If
                        '                    Else
                        '                        ' ¿Esta desnudo?
                        '                        If .flags.Desnudo = 1 Then
                        '                            ' Pierde energia
                        '                            Call RecStamina(UserList(iUserIndex), 5, bEnviarEnergias)
                        '                        ElseIf .flags.Descansar = True And (.flags.Hambre = 0 And .flags.Sed = 0) Then
                        '                            ' Recupera vida
                        '                            Call Sanar(iUserIndex, bEnviarStats, SanaIntervaloDescansar)
                        '                            ' Recupera energia
                        '                            Call RecStamina(UserList(iUserIndex), 1, bEnviarEnergias)
                        '                        ElseIf .flags.Hambre = 0 And .flags.Sed = 0 Then
                        '                            ' Recupera energia
                        '                            Call Sanar(iUserIndex, bEnviarStats, SanaIntervaloSinDescansar)
                        '                            Call RecStamina(UserList(iUserIndex), 2, bEnviarEnergias)
                        '                        End If
                        '                        ' Termina de descansar automaticamente
                        '                        If .flags.Descansar Then
                        '                            If .Stats.MaxHP = .Stats.MinHP And .Stats.MaxSta = .Stats.minSta Then
                        '                                .flags.Descansar = False
                        '                                EnviarPaquete Paquetes.MDescansar, "", iUserIndex
                        '                            End If
                        '                        End If
                        '                    End If
                        '                    If bEnviarStats Then Call SendUserStatsBoxBasicas(iUserIndex)
                        '                    If Not bEnviarStats And (.flags.Trabajando Or bEnviarEnergias) Then EnviarPaquete Paquetes.EnviarST, Codify(.Stats.minSta), iUserIndex, ToIndex
                        '                    If bEnviarAyS Then Call EnviarHambreYsed(iUserIndex)
                    End If    ' Cierra user muerto
                End If    'con idd
            End If
        End With
    Next iUserIndex
    UltimoLoop = GetTickCount
End Sub

'Public Sub packetResend_Timer()
'    On Error GoTo errHandler:
'    Dim i As Long
'    For i = 1 To MaxUsers
'        If UserList(i).ConnIDValida Then
'            If UserList(i).outgoingData.length > 0 Then
'                Call EnviarDatosASlot(i, UserList(i).outgoingData.ReadASCIIStringFixed(UserList(i).outgoingData.length))
'            End If
'        End If
'    Next i
'    Exit Sub
'errHandler:
'    LogError ("Error en packetResend - Error: " & Err.Number & " - Desc: " & Err.Description)
'    Resume Next
'End Sub

Private Sub sck_PostWEB_DataArrival(ByVal bytesTotal As Long)
    Dim sData As String
    sck_PostWEB.GetData sData, vbString
    Debug.Print Now, "sck_PostWEB_Response", sData
End Sub

Private Sub sck_PostWEB_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
    If Number = 10061 Then
        'frmMain.Caption = Now & " sck_PostWEB_Error: Falta ejecutar el script servidor_postWEB"
    Else
        frmMain.lblSock.Caption = Now & " sck_PostWEB_Error:" & Number & " " & Description
    End If
End Sub

Private Sub sck_SendMail_DataArrival(ByVal bytesTotal As Long)
    Dim sData As String
    sck_SendMail.GetData sData, vbString
    'frmMain.lblSock.Caption = Now & " sck_SendMail_Response " & sData
End Sub

Private Sub sck_SendMail_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)
    If Number = 10061 Then
        '  frmMain.Caption = Now & " sck_SendMail_Error: Falta ejecutar el script de send_mail"
    Else
        frmMain.lblSock.Caption = Now & " sck_SendMail_Error:" & Number & " " & Description
    End If
End Sub

Private Sub Text1_Change()
    IntClickU = Abs(val(Text1.Text))
End Sub

Private Sub TIMER_AI_Timer()

    On Error GoTo ErrorHandler
    Dim NpcIndex As Long
    Dim mapa As Integer
    Dim e_p As Integer

    'Barrin 29/9/03
    If Not haciendoBK And Not EnPausa Then
        'Update NPCs
        For NpcIndex = 1 To LastNPC

            With Npclist(NpcIndex)
                If .flags.NPCActive Then        'Nos aseguramos que sea INTELIGENTE!

                    ' Chequea si contiua teniendo dueño
                    If .Owner > 0 Then Call ValidarPermanenciaNpc(NpcIndex)

                    If .flags.Paralizado = 1 Then
                        Call EfectoParalisisNpc(NpcIndex)
                    Else
                        e_p = esPretoriano(NpcIndex)
                        If e_p > 0 Then
                            Select Case e_p
                            Case 1        ''clerigo
                                Call PRCLER_AI(NpcIndex)
                            Case 2        ''mago
                                Call PRMAGO_AI(NpcIndex)
                            Case 3        ''cazador
                                Call PRCAZA_AI(NpcIndex)
                            Case 4        ''rey
                                Call PRREY_AI(NpcIndex)
                            Case 5        ''guerre
                                Call PRGUER_AI(NpcIndex)
                            End Select
                        Else
                            'Usamos AI si hay algun user en el mapa
                            If .flags.Inmovilizado = 1 Then
                                Call EfectoParalisisNpc(NpcIndex)
                            End If

                            mapa = .Pos.Map

                            If mapa > 0 Then
                                If MapInfo(mapa).NumUsers > 0 Then
                                    If .Movement <> TipoAI.ESTATICO Then
                                        Call NPCAI(NpcIndex)
                                    End If
                                End If
                            End If
                        End If
                    End If
                End If
            End With
        Next NpcIndex
    End If

    Exit Sub

ErrorHandler:
    Call LogError("Error en TIMER_AI_Timer " & Npclist(NpcIndex).Name & " mapa:" & Npclist(NpcIndex).Pos.Map)
    Call MuereNpc(NpcIndex, 0)
End Sub

Private Sub Timer1_Timer()

    If frmMain.chkwebSystem.value = 0 Then Exit Sub

    On Error GoTo Errhandler

    Dim i As Long
    Dim PjIndex As Long
    Dim PostData As String

    Dim Valor(1 To 257) As String
    Dim Nombre(1 To 257) As String

    If totPjsAUpdatear = 0 Then Exit Sub
    PjIndex = UBound(PjsAUpdatear)        'update the latest

    With PjsAUpdatear(PjIndex)
        Nombre(1) = "nick"
        Valor(1) = .Name
        Nombre(2) = "pass"
        Valor(2) = .Pass
        Nombre(3) = "pin"
        Valor(3) = .Pin
        Nombre(4) = "acc"
        Valor(4) = .Account
        Nombre(5) = "nivel"
        Valor(5) = .Stats.ELV
        Nombre(6) = "email"
        Valor(6) = .Email
        Nombre(7) = "exp"
        Valor(7) = .Stats.Exp
        Nombre(8) = "clase"
        Valor(8) = .Clase
        Nombre(9) = "raza"
        Valor(9) = .raza
        Nombre(10) = "genero"
        Valor(10) = .Genero
        Nombre(11) = "logged"
        Valor(11) = IIf(.flags.UserLogged, 1, 0)
        Nombre(12) = "min_hp"
        Valor(12) = .Stats.MinHP
        Nombre(13) = "max_hp"
        Valor(13) = .Stats.MaxHP
        Nombre(14) = "min_man"
        Valor(14) = .Stats.MinMAN
        Nombre(15) = "max_man"
        Valor(15) = .Stats.MaxMAN
        Nombre(16) = "elu"
        Valor(16) = .Stats.elu
        Nombre(17) = "cium"
        Valor(17) = .faccion.CiudadanosMatados
        Nombre(18) = "crim"
        Valor(18) = .faccion.CriminalesMatados
        Nombre(19) = "cm"
        Valor(19) = .Stats.NPCsMuertos
        Nombre(20) = "privs"
        Valor(20) = .flags.Privilegios
        Nombre(21) = "jail"
        Valor(21) = .Counters.Pena
        Nombre(22) = "clan"
        Valor(22) = IIf(.GuildIndex > 0, GuildName(.GuildIndex), "")
        Nombre(23) = "tm"
        Valor(23) = .Stats.UsuariosMatados
        Nombre(24) = "oro"
        Valor(24) = .Stats.GLD
        Nombre(25) = "bov"
        Valor(25) = .Stats.Banco
        Nombre(26) = "pos"
        Valor(26) = .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y
        Nombre(27) = "ip"
        Valor(27) = .IP
        Nombre(28) = "ase"
        Valor(28) = .Reputacion.AsesinoRep
        Nombre(29) = "nob"
        Valor(29) = .Reputacion.NobleRep
        Nombre(30) = "bur"
        Valor(30) = .Reputacion.BurguesRep
        Nombre(31) = "band"
        Valor(31) = .Reputacion.PlebeRep
        Nombre(32) = "ple"
        Valor(32) = .Reputacion.PlebeRep
        Nombre(33) = "lad"
        Valor(33) = .Reputacion.LadronesRep
        Nombre(34) = "rg"
        Valor(34) = .Stats.RetosGanados
        Nombre(35) = "rp"
        Valor(35) = .Stats.RetosPerdidos
        Nombre(36) = "rop"
        Valor(36) = .Stats.OroGanado
        Nombre(37) = "rog"
        Valor(37) = .Stats.OroPerdido
        Nombre(38) = "ilim"
        Valor(38) = .flags.char_locked_in_mao
        Nombre(39) = "skl"
        Valor(39) = .Stats.SkillPts
        Nombre(40) = "ban"
        Valor(40) = .flags.Ban

        For i = 1 To NUMSKILLS
            Nombre(40 + i) = "sk" & i
            Valor(40 + i) = .Stats.UserSkills(i)
        Next i
        For i = 1 To 5
            Nombre(61 + i) = "at" & i
            Valor(61 + i) = .Stats.UserAtributos(i)
        Next i
        For i = 1 To 20
            Nombre(66 + i) = "inv" & i
            Valor(66 + i) = .Invent.Object(i).ObjIndex
        Next i
        For i = 1 To 20
            Nombre(86 + i) = "ia" & i
            Valor(86 + i) = .Invent.Object(i).Amount
        Next i
        For i = 1 To 20
            Nombre(106 + i) = "ie" & i
            Valor(106 + i) = .Invent.Object(i).Equipped
        Next i
        For i = 1 To 40
            Nombre(126 + i) = "b" & i
            Valor(126 + i) = .BancoInvent.Object(i).ObjIndex
        Next i
        For i = 1 To 40
            Nombre(166 + i) = "ba" & i
            Valor(166 + i) = .BancoInvent.Object(i).Amount
        Next i
        For i = 1 To 35
            Nombre(206 + i) = "s" & i
            Valor(206 + i) = .Stats.UserHechizos(i)
        Next i

        Valor(242) = .Stats.CantPenas
        Nombre(242) = "totpenas"

        For i = 1 To 8
            Nombre(242 + i) = "p" & i
            Valor(242 + i) = .Stats.Penas(i)
        Next i

        Valor(250) = .Stats.PuntosFotodenuncia
        Nombre(250) = "pft"
        Valor(251) = .Stats.ParticipoClanes
        Nombre(251) = "pcl"

        Nombre(252) = "fcl"
        If (.Stats.FundoClan) > 0 Then
            Valor(252) = GuildName(.Stats.FundoClan)
        Else
            Valor(252) = ""
        End If

        Valor(253) = .Stats.DisolvioClan
        Nombre(253) = "dcl"

        Valor(254) = GetVar(CharPath & .Name & ".chr", "PENAS", "UNBAN_DATE")
        Nombre(254) = "ubd"

        Valor(255) = .flags.mao_index
        Nombre(255) = "mao"

        Valor(256) = val(GetVar(CharPath & .Name & ".chr", "FLAGS", "char_locked"))
        Nombre(256) = "lck"

        Valor(257) = .faccion.Status
        Nombre(257) = "sss"

    End With

    For i = LBound(Nombre) To UBound(Nombre)
        PostData = PostData & Nombre(i) & "=" & Valor(i) & "&"
    Next i

    If Len(PostData) > 0 Then PostData = Left$(PostData, Len(PostData) - 1)

    If sck_PostWEB.State = 7 Then        ' connected
        Debug.Print Now, Valor(1), Valor(6)
        sck_PostWEB.SendData ("|0" & "AgregarPj=1&" & PostData)

        totPjsAUpdatear = totPjsAUpdatear - 1
        frmMain.lblSock.Caption = "Agrego pj: " & Valor(1)
        If totPjsAUpdatear > 0 Then ReDim Preserve PjsAUpdatear(1 To totPjsAUpdatear)
    Else        'not connected or something, try again.
        If sck_PostWEB.State <> 0 Then sck_PostWEB.Close
        sck_PostWEB.connect
        ' frmMain.lblSock.Caption = "Connecting in AddPJ " & .Name
    End If

Errhandler:

End Sub

Private Sub Timer2_Timer()
    Static tiempo As Long
    tiempo = tiempo + 1

    If tiempo = 60 * 10 Then
        tiempo = 0
        Call UpdateExperiences
    End If

End Sub

Private Sub tLluviaEvent_Timer()

    On Error GoTo ErrorHandler

    If LluviaActiva = 0 Then Exit Sub

    If Not Lloviendo Then
        MinutosSinLluvia = MinutosSinLluvia + 1
        If MinutosSinLluvia >= 15 And MinutosSinLluvia < 1440 Then
            If RandomNumber(1, 100) <= 2 Then
                Lloviendo = True
                MinutosSinLluvia = 0
                Call SendData(SendTarget.ToAllButDungeon, 0, PrepareMessageRainToggle(Lloviendo))
            End If
        ElseIf MinutosSinLluvia >= 1440 Then
            Lloviendo = True
            MinutosSinLluvia = 0
            Call SendData(SendTarget.ToAllButDungeon, 0, PrepareMessageRainToggle(Lloviendo))
        End If
    Else
        MinutosLloviendo = MinutosLloviendo + 1
        If MinutosLloviendo >= 5 Then
            Lloviendo = False
            Call SendData(SendTarget.ToAllButDungeon, 0, PrepareMessageRainToggle(Lloviendo))
            MinutosLloviendo = 0
        Else
            If RandomNumber(1, 100) <= 2 Then
                Lloviendo = False
                MinutosLloviendo = 0
                Call SendData(SendTarget.ToAllButDungeon, 0, PrepareMessageRainToggle(Lloviendo))
            End If
        End If
    End If

    Exit Sub
ErrorHandler:
    Call LogError("Error tLluviaTimer")
End Sub

Private Sub tmrPingWEB_Timer()
    Call mod_DB.WEB_Tick
End Sub

Private Sub tPiqueteC_Timer()

    Dim i As Long

    On Error GoTo Errhandler
    For i = 1 To LastUser
        With UserList(i)
            If .flags.UserLogged Then
                If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = eTrigger.ANTIPIQUETE And .flags.Privilegios = PlayerType.User Then
                    .Counters.PiqueteC = .Counters.PiqueteC + 1

                    WriteMensajes i, e_Mensajes.Mensaje_131

                    If .Counters.PiqueteC > 23 Then
                        .Counters.PiqueteC = 0
                        Call Encarcelar(i, TIEMPO_CARCEL_PIQUETE)
                    End If
                Else
                    .Counters.PiqueteC = 0
                End If

                'Call Flushbuffer(i)
            End If
        End With
    Next i
    Exit Sub

Errhandler:
    Call LogError("Error en tPiqueteC_Timer " & Err.Number & ": " & Err.Description)
End Sub

