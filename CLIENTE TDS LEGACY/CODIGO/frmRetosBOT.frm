VERSION 5.00
Begin VB.Form frmRetosBOT 
   BorderStyle     =   0  'None
   ClientHeight    =   4485
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3750
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4485
   ScaleWidth      =   3750
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.HScrollBar HScroll 
      Height          =   375
      Left            =   810
      Max             =   5
      Min             =   1
      TabIndex        =   4
      Top             =   1530
      Value           =   1
      Width           =   2325
   End
   Begin VB.ListBox lstBotClass 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H000000FF&
      Height          =   1395
      Left            =   1320
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label lblDificultad 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "(1)"
      BeginProperty Font 
         Name            =   "Lucida Console"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   2640
      TabIndex        =   3
      Top             =   1170
      Width           =   615
   End
   Begin VB.Label cmdUnload 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   1920
      TabIndex        =   1
      Top             =   3960
      Width           =   1695
   End
   Begin VB.Label cmdSend 
      BackStyle       =   0  'Transparent
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   3840
      Width           =   1695
   End
End
Attribute VB_Name = "frmRetosBOT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As New clsFrmMovMan

Private Sub cmdSend_Click()

    Call WriteRetoBOT(HScroll.Value, lstBotClass.ListIndex + 1)

    Unload Me
    frmMain.SetFocus

End Sub

Private Sub cmdUnload_Click()

    Unload Me
    frmMain.SetFocus

End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    Call clsFormulario.Initialize(Me)

    'Call forms_load_pic(Me, "12176.bmp")
    
    lstBotClass.Clear

    lstBotClass.AddItem "Clérigo"
    lstBotClass.AddItem "Mago"
    lstBotClass.AddItem "Cazador"

    lstBotClass.ListIndex = 1

End Sub

Private Sub Form_Unload(Cancel As Integer)

    Set clsFormulario = Nothing

End Sub

Private Sub HScroll_Change()
    lblDificultad.Caption = "(" & HScroll.Value & ")"
End Sub

Private Sub HScroll_Scroll()
    lblDificultad.Caption = "(" & HScroll.Value & ")"
End Sub
