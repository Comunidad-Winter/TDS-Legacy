VERSION 5.00
Begin VB.Form frmUserRequest 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   3015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
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
   ScaleHeight     =   201
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   320
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text1 
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
      Height          =   1575
      Left            =   240
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   600
      Width           =   4335
   End
   Begin VB.Image imgCerrar 
      Height          =   615
      Left            =   1800
      Tag             =   "1"
      Top             =   2280
      Width           =   1200
   End
End
Attribute VB_Name = "frmUserRequest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public LastPressed As clsGraphicalButton

Public Sub recievePeticion(ByVal p As String)

    Text1 = Replace$(p, "º", vbCrLf)
    Me.Show vbModeless, frmMain

End Sub

Private Sub Form_Load()
    Call forms_load_pic(Me, "996.bmp", False)
End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

