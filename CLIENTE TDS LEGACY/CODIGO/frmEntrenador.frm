VERSION 5.00
Begin VB.Form frmEntrenador 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Entrenador"
   ClientHeight    =   4110
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4305
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
   ScaleHeight     =   274
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   287
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox lstCriaturas 
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
      Height          =   2370
      Left            =   720
      TabIndex        =   0
      Top             =   960
      Width           =   2970
   End
   Begin VB.Image Boton 
      Height          =   375
      Index           =   0
      Left            =   2235
      Top             =   3405
      Width           =   1095
   End
   Begin VB.Image Boton 
      Height          =   375
      Index           =   1
      Left            =   840
      Top             =   3405
      Width           =   1095
   End
End
Attribute VB_Name = "frmEntrenador"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Boton_Click(index As Integer)
    Select Case index
    Case 0
        Unload Me
    Case 1
        Call WriteTrain(lstCriaturas.ListIndex + 1)
        Unload Me
    End Select
End Sub

Private Sub Form_Load()
    Call forms_load_pic(Me, "987.bmp", False)
End Sub

