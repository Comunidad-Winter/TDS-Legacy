VERSION 5.00
Begin VB.Form frmGuildURL 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Oficial Web Site"
   ClientHeight    =   1530
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6270
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
   ScaleHeight     =   102
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   418
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtUrl 
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
      Height          =   270
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   5865
   End
   Begin VB.Image imgAceptar 
      Height          =   375
      Left            =   2520
      Tag             =   "1"
      Top             =   1140
      Width           =   1080
   End
End
Attribute VB_Name = "frmGuildURL"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    Call forms_load_pic(Me, "971.bmp", False)
End Sub
Private Sub imgAceptar_Click()
    If txtUrl.Text <> "" Then _
       Call WriteGuildNewWebsite(txtUrl.Text)
    Unload Me
End Sub
