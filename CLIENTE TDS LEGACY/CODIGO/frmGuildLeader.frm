VERSION 5.00
Begin VB.Form frmGuildLeader 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Administración del Clan"
   ClientHeight    =   6675
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6000
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
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   445
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   400
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtguildnews 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
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
      Height          =   690
      Left            =   225
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   2640
      Width           =   5475
   End
   Begin VB.ListBox solicitudes 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
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
      Height          =   1200
      ItemData        =   "frmGuildLeader.frx":0000
      Left            =   225
      List            =   "frmGuildLeader.frx":0002
      TabIndex        =   2
      Top             =   4290
      Width           =   2580
   End
   Begin VB.ListBox members 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
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
      Height          =   1395
      ItemData        =   "frmGuildLeader.frx":0004
      Left            =   3105
      List            =   "frmGuildLeader.frx":0006
      TabIndex        =   1
      Top             =   480
      Width           =   2595
   End
   Begin VB.ListBox guildslist 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
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
      Height          =   1395
      ItemData        =   "frmGuildLeader.frx":0008
      Left            =   180
      List            =   "frmGuildLeader.frx":000A
      TabIndex        =   0
      Top             =   480
      Width           =   2595
   End
   Begin VB.Image imgAbrirElecciones 
      Height          =   375
      Left            =   3120
      Top             =   3960
      Width           =   2655
   End
   Begin VB.Label Miembros 
      BackStyle       =   0  'Transparent
      Caption         =   "El clan cuenta con x miembros"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   6120
      Width           =   2535
   End
   Begin VB.Image imgCerrar 
      Height          =   465
      Left            =   3930
      Tag             =   "1"
      Top             =   5925
      Width           =   1095
   End
   Begin VB.Image imgPropuestasPaz 
      Height          =   375
      Left            =   3075
      Tag             =   "1"
      Top             =   5400
      Width           =   2775
   End
   Begin VB.Image imgEditarURL 
      Height          =   375
      Left            =   3075
      Tag             =   "1"
      Top             =   4920
      Width           =   2775
   End
   Begin VB.Image imgEditarCodex 
      Height          =   375
      Left            =   3075
      Tag             =   "1"
      Top             =   4440
      Width           =   2775
   End
   Begin VB.Image imgActualizar 
      Height          =   390
      Left            =   2400
      Tag             =   "1"
      Top             =   3405
      Width           =   1095
   End
   Begin VB.Image imgDetallesSolicitudes 
      Height          =   465
      Left            =   930
      Tag             =   "1"
      Top             =   5535
      Width           =   1095
   End
   Begin VB.Image imgDetallesMiembros 
      Height          =   465
      Left            =   3930
      Tag             =   "1"
      Top             =   1920
      Width           =   1095
   End
   Begin VB.Image imgDetallesClan 
      Height          =   465
      Left            =   930
      Tag             =   "1"
      Top             =   1920
      Width           =   1095
   End
End
Attribute VB_Name = "frmGuildLeader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const MAX_NEWS_LENGTH As Integer = 512
Private clsFormulario As clsFrmMovMan

Public LastPressed As clsGraphicalButton

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    Call forms_load_pic(Me, "974.bmp", False)

End Sub

Private Sub imgAbrirElecciones_Click()
' @@ Por las dudas por si no manquea
    If MsgBox("¿¡Estás seguro que deseas abrir las elecciones!?", vbYesNo, "TDS Legacy") = vbYes Then
        Call WriteGuildOpenElections
        Unload Me
    End If
End Sub

Private Sub imgActualizar_Click()
    Dim k As String

    k = Replace(txtguildnews, vbCrLf, "|")

    Call WriteGuildUpdateNews(k)
End Sub

Private Sub imgCerrar_Click()
    Unload Me
    frmMain.SetFocus
End Sub

Private Sub imgDetallesClan_Click()

    If guildslist.ListIndex = -1 Then Exit Sub

    frmGuildBrief.EsLeader = True

    frmGuildBrief.ClanSeleccionado = guildslist.ListIndex + 1

    frmGuildBrief.ClanSeleccionado_Nombre = guildslist.List(guildslist.ListIndex)

    Call WriteGuildRequestDetails(guildslist.ListIndex + 1)
End Sub

Private Sub imgDetallesMiembros_Click()
    If members.ListIndex = -1 Then Exit Sub

    frmCharInfo.frmType = CharInfoFrmType.frmMembers
    Call WriteGuildMemberInfo(members.List(members.ListIndex))
End Sub

Private Sub imgDetallesSolicitudes_Click()
    If solicitudes.ListIndex = -1 Then Exit Sub

    frmCharInfo.frmType = CharInfoFrmType.frmMembershipRequests
    Call WriteGuildMemberInfo(solicitudes.List(solicitudes.ListIndex))
End Sub

Private Sub imgEditarCodex_Click()
    Call frmGuildDetails.Show(vbModal, frmGuildLeader)
End Sub

Private Sub imgEditarURL_Click()
    Call frmGuildURL.Show(vbModeless, frmGuildLeader)
End Sub

Private Sub imgPropuestasPaz_Click()
    Call WriteGuildPeacePropList
End Sub

Private Sub txtguildnews_Change()
    If Len(txtguildnews.Text) > MAX_NEWS_LENGTH Then _
       txtguildnews.Text = Left$(txtguildnews.Text, MAX_NEWS_LENGTH)
End Sub


