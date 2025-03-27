VERSION 5.00
Begin VB.Form frmGuildBrief 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Detalles del Clan"
   ClientHeight    =   7755
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7605
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
   ScaleHeight     =   517
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   507
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Desc 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   900
      Left            =   360
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      TabIndex        =   18
      Top             =   6240
      Width           =   6975
   End
   Begin VB.Label Antifaccion 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   19
      Top             =   2760
      Width           =   2775
   End
   Begin VB.Image imgSolicitarIngreso 
      Height          =   360
      Left            =   5775
      Picture         =   "frmGuildBrief.frx":0000
      Tag             =   "1"
      Top             =   7290
      Width           =   1740
   End
   Begin VB.Image imgDeclararGuerra 
      Height          =   360
      Left            =   4095
      Picture         =   "frmGuildBrief.frx":6C86
      Tag             =   "1"
      Top             =   7290
      Width           =   1665
   End
   Begin VB.Image imgOfrecerAlianza 
      Height          =   315
      Left            =   2445
      Picture         =   "frmGuildBrief.frx":D7F8
      Tag             =   "1"
      Top             =   7305
      Visible         =   0   'False
      Width           =   1635
   End
   Begin VB.Image imgOfrecerPaz 
      Height          =   330
      Left            =   1155
      Picture         =   "frmGuildBrief.frx":14131
      Tag             =   "1"
      Top             =   7305
      Width           =   1260
   End
   Begin VB.Image imgCerrar 
      Height          =   405
      Left            =   150
      Picture         =   "frmGuildBrief.frx":1A749
      Tag             =   "1"
      Top             =   7260
      Width           =   975
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   0
      Left            =   360
      TabIndex        =   17
      Top             =   3840
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   1
      Left            =   360
      TabIndex        =   16
      Top             =   4065
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   2
      Left            =   360
      TabIndex        =   15
      Top             =   4320
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   3
      Left            =   360
      TabIndex        =   14
      Top             =   4560
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   4
      Left            =   360
      TabIndex        =   13
      Top             =   4800
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   5
      Left            =   360
      TabIndex        =   12
      Top             =   5040
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   6
      Left            =   360
      TabIndex        =   11
      Top             =   5280
      Width           =   6735
   End
   Begin VB.Label Codex 
      BackStyle       =   0  'Transparent
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
      Index           =   7
      Left            =   360
      TabIndex        =   10
      Top             =   5520
      Width           =   6735
   End
   Begin VB.Label nombre 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   9
      Top             =   930
      Width           =   4695
   End
   Begin VB.Label fundador 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   8
      Top             =   1230
      Width           =   2775
   End
   Begin VB.Label creacion 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   3900
      TabIndex        =   7
      Top             =   930
      Width           =   3495
   End
   Begin VB.Label lider 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   6
      Top             =   1530
      Width           =   3135
   End
   Begin VB.Label web 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdfefewfewfewfewfewfewfewfewewffewfewfewfefwqwqdwqd"
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
      Left            =   360
      TabIndex        =   5
      Top             =   1830
      Width           =   6855
   End
   Begin VB.Label Miembros 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   3900
      TabIndex        =   4
      Top             =   1530
      Width           =   3375
   End
   Begin VB.Label eleccion 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   3900
      TabIndex        =   3
      Top             =   1230
      Width           =   3375
   End
   Begin VB.Label lblAlineacion 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   2
      Top             =   3030
      Width           =   3375
   End
   Begin VB.Label Enemigos 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   1
      Top             =   2130
      Width           =   2775
   End
   Begin VB.Label Aliados 
      BackStyle       =   0  'Transparent
      Caption         =   "dwqdwqdwqdwqdwqdwqwqdwqd"
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
      Left            =   360
      TabIndex        =   0
      Top             =   2430
      Width           =   2775
   End
End
Attribute VB_Name = "frmGuildBrief"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Public EsLeader As Boolean
Public ClanSeleccionado As Integer
Public ClanSeleccionado_Nombre As String

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "989.bmp", False)


    LoadButtons

End Sub

Private Sub LoadButtons()

    imgDeclararGuerra.visible = EsLeader
    imgOfrecerPaz.visible = EsLeader
    imgOfrecerAlianza.visible = EsLeader

    If Not EsLeader Then
        imgDeclararGuerra.visible = False
        imgOfrecerPaz.visible = False
        imgOfrecerAlianza.visible = False
        If LenB(charlist(UserCharIndex).clan) > 0 Then        'por que pediria si ya estoy en uno
            imgSolicitarIngreso.visible = False
        End If
    Else
        imgSolicitarIngreso.visible = False
        If "<" & ClanSeleccionado_Nombre & "" = charlist(UserCharIndex).clan Then
            imgDeclararGuerra.visible = False
            imgOfrecerPaz.visible = False
            imgOfrecerAlianza.visible = False
        End If

    End If

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgDeclararGuerra_Click()
    If ClanSeleccionado = 0 Then
        ShowConsoleMsg "Debes seleccionar un clan para declararle la guerra"
        Exit Sub
    End If

    Call WriteGuildDeclareWar(ClanSeleccionado)
    Unload Me
End Sub

Private Sub imgOfrecerAlianza_Click()

    frmCommet.T = tipo.ALIANZA
    frmCommet.ClanSeleccionado = ClanSeleccionado

    frmCommet.ClanSeleccionado_Nombre = ClanSeleccionado_Nombre

    Call frmCommet.Show(vbModal, frmGuildBrief)
End Sub

Private Sub imgOfrecerPaz_Click()

    frmCommet.T = tipo.PAZ
    frmCommet.ClanSeleccionado = ClanSeleccionado
    frmCommet.ClanSeleccionado_Nombre = ClanSeleccionado_Nombre

    Call frmCommet.Show(vbModal, frmGuildBrief)
End Sub

Private Sub imgSolicitarIngreso_Click()

    Call frmGuildSol.RecieveSolicitud(ClanSeleccionado)
    Call frmGuildSol.Show(vbModal, frmGuildBrief)
End Sub

