VERSION 5.00
Begin VB.Form frmCharInfo 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   6615
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5370
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
   ScaleHeight     =   441
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   358
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Label status 
      BackStyle       =   0  'Transparent
      Caption         =   "Status:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   2520
      Width           =   4695
   End
   Begin VB.Label Banco 
      BackStyle       =   0  'Transparent
      Caption         =   "Banco:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   14
      Top             =   2280
      Width           =   4695
   End
   Begin VB.Label Oro 
      BackStyle       =   0  'Transparent
      Caption         =   "Oro:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   13
      Top             =   2040
      Width           =   4695
   End
   Begin VB.Label Genero 
      BackStyle       =   0  'Transparent
      Caption         =   "Genero:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   12
      Top             =   1560
      Width           =   4695
   End
   Begin VB.Label Raza 
      BackStyle       =   0  'Transparent
      Caption         =   "Raza:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   11
      Top             =   1080
      Width           =   4695
   End
   Begin VB.Label Clase 
      BackStyle       =   0  'Transparent
      Caption         =   "Clase:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   10
      Top             =   1320
      Width           =   4695
   End
   Begin VB.Label Nivel 
      BackStyle       =   0  'Transparent
      Caption         =   "Nivel:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   9
      Top             =   1800
      Width           =   4695
   End
   Begin VB.Label Nombre 
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   840
      Width           =   4695
   End
   Begin VB.Label faccion 
      BackStyle       =   0  'Transparent
      Caption         =   "Faccion:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   4320
      Width           =   4695
   End
   Begin VB.Label integro 
      BackStyle       =   0  'Transparent
      Caption         =   "Clanes que integro:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   4080
      Width           =   4695
   End
   Begin VB.Label lider 
      BackStyle       =   0  'Transparent
      Caption         =   "Veces fue lider de clan:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   3840
      Width           =   4695
   End
   Begin VB.Label fundo 
      BackStyle       =   0  'Transparent
      Caption         =   "Fundo el clan:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   3600
      Width           =   4695
   End
   Begin VB.Label Solicitudes 
      BackStyle       =   0  'Transparent
      Caption         =   "Solicitudes para ingresar a clanes:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   3360
      Width           =   4695
   End
   Begin VB.Label reputacion 
      BackStyle       =   0  'Transparent
      Caption         =   "Reputacion:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   5760
      Width           =   4695
   End
   Begin VB.Label criminales 
      BackStyle       =   0  'Transparent
      Caption         =   "Criminales asesinados:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   5520
      Width           =   4695
   End
   Begin VB.Label Ciudadanos 
      BackStyle       =   0  'Transparent
      Caption         =   "Ciudadanos asesinados:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   5280
      Width           =   4695
   End
   Begin VB.Image imgEchar 
      Height          =   345
      Left            =   1155
      Picture         =   "frmCharInfo.frx":0000
      Tag             =   "1"
      Top             =   6135
      Width           =   870
   End
   Begin VB.Image imgAceptar 
      Height          =   345
      Left            =   4050
      Picture         =   "frmCharInfo.frx":0722
      Tag             =   "1"
      Top             =   6150
      Width           =   1020
   End
   Begin VB.Image imgRechazar 
      Height          =   345
      Left            =   3075
      Picture         =   "frmCharInfo.frx":0F79
      Tag             =   "1"
      Top             =   6150
      Width           =   1005
   End
   Begin VB.Image imgPeticion 
      Height          =   360
      Left            =   2040
      Picture         =   "frmCharInfo.frx":17CA
      Tag             =   "1"
      Top             =   6150
      Width           =   1005
   End
   Begin VB.Image imgCerrar 
      Height          =   435
      Left            =   210
      Picture         =   "frmCharInfo.frx":201B
      Tag             =   "1"
      Top             =   6075
      Width           =   915
   End
End
Attribute VB_Name = "frmCharInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Public Enum CharInfoFrmType
    frmMembers
    frmMembershipRequests
End Enum

Public frmType As CharInfoFrmType

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "986.bmp", False)

End Sub

Private Sub imgAceptar_Click()
    Dim TmpStr As String
    TmpStr = Replace$(nombre.Caption, "Nombre: ", "")

    Call WriteGuildAcceptNewMember(TmpStr)
    Unload frmGuildLeader
    Call WriteRequestGuildLeaderInfo
    Unload Me
End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgEchar_Click()

    Dim TmpStr As String
    TmpStr = Replace$(nombre.Caption, "Nombre: ", "")

    If UserCharIndex > 0 Then
        If UCase$(charlist(UserCharIndex).nombre) = UCase$(TmpStr) And charlist(UserCharIndex).Mimetizado = False Then
            ' @@ Me estoy echando a mi mismo, disuelvo el clan padre.
            Call WriteDisolverClan
            Exit Sub
            Unload frmGuildLeader
            Unload Me
        End If
    End If

    Call WriteGuildKickMember(TmpStr)
    Unload frmGuildLeader
    Call WriteRequestGuildLeaderInfo
    Unload Me

End Sub

Private Sub imgPeticion_Click()

    Dim TmpStr As String
    TmpStr = Replace$(nombre.Caption, "Nombre: ", "")

    Call WriteGuildRequestJoinerInfo(TmpStr)
End Sub

Private Sub imgRechazar_Click()
    Dim TmpStr As String
    TmpStr = Replace$(nombre.Caption, "Nombre: ", "")

    frmCommet.T = RECHAZOPJ
    frmCommet.nombre = TmpStr
    frmCommet.Show vbModeless, frmCharInfo
End Sub

