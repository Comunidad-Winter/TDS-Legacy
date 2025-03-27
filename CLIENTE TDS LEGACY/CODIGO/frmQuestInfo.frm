VERSION 5.00
Begin VB.Form frmQuestInfo 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Información de la misión"
   ClientHeight    =   2895
   ClientLeft      =   0
   ClientTop       =   -45
   ClientWidth     =   5055
   Icon            =   "frmQuestInfo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2895
   ScaleWidth      =   5055
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtInfo 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   1935
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   120
      Width           =   4815
   End
   Begin VB.Label cRechazar 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Rechazar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000B&
      Height          =   495
      Left            =   2760
      TabIndex        =   2
      Top             =   2280
      Width           =   1815
   End
   Begin VB.Label cAceptar 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   " Aceptar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000B&
      Height          =   495
      Left            =   480
      TabIndex        =   1
      Top             =   2280
      Width           =   1815
   End
End
Attribute VB_Name = "frmQuestInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Private Sub cAceptar_Click()

    Call modEngine_Audio.PlayInterface(SND_CLICK)
    Call WriteQuestAccept
    Unload Me

End Sub

Private Sub cRechazar_Click()

    Call modEngine_Audio.PlayInterface(SND_CLICK)
    Unload Me

End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    'Me.Picture = LoadPicture(DirGUI & "frmFormYesNo.jpg")
End Sub

