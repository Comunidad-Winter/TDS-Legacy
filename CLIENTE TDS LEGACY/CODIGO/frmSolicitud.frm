VERSION 5.00
Begin VB.Form frmGuildSol 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Ingreso"
   ClientHeight    =   4035
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4875
   ClipControls    =   0   'False
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
   ScaleHeight     =   269
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   325
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text1 
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
      Height          =   1515
      Left            =   360
      MaxLength       =   400
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   1800
      Width           =   4095
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   $"frmSolicitud.frx":0000
      ForeColor       =   &H00E0E0E0&
      Height          =   1215
      Left            =   360
      TabIndex        =   1
      Top             =   480
      Width           =   3975
   End
   Begin VB.Image imgEnviar 
      Height          =   405
      Left            =   480
      Tag             =   "1"
      Top             =   3360
      Width           =   1065
   End
   Begin VB.Image imgCerrar 
      Height          =   405
      Left            =   3360
      Tag             =   "1"
      Top             =   3360
      Width           =   1065
   End
End
Attribute VB_Name = "frmGuildSol"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private clsFormulario As clsFrmMovMan

Public LastPressed As clsGraphicalButton

Dim cIndex As Integer

Public Sub RecieveSolicitud(ByVal GuildIndex As Integer)
    cIndex = GuildIndex
End Sub

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "966.bmp", False)

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgEnviar_Click()
    Call WriteGuildRequestMembership(cIndex, Replace(Replace(Text1.Text, ",", ";"), vbCrLf, "º"))
    Unload Me
End Sub

