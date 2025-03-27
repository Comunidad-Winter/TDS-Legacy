VERSION 5.00
Begin VB.Form frmCargando 
   BackColor       =   &H00000040&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Servidor TDS Legacy - 0.9.86"
   ClientHeight    =   525
   ClientLeft      =   1455
   ClientTop       =   3390
   ClientWidth     =   6120
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   44.161
   ScaleMode       =   0  'User
   ScaleWidth      =   408
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Cargando servidor"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   330
      Left            =   1785
      TabIndex        =   0
      Top             =   60
      Width           =   3195
   End
End
Attribute VB_Name = "frmCargando"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Me.Caption = "Servidor TDS Legacy - " & ULTIMAVERSION
End Sub
