VERSION 5.00
Begin VB.Form frmMensaje 
   BackColor       =   &H000000FF&
   BorderStyle     =   0  'None
   Caption         =   "Mensaje"
   ClientHeight    =   2205
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4455
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMensaje.frx":0000
   ScaleHeight     =   147
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   297
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Image imgAceptar 
      Height          =   615
      Left            =   1320
      Top             =   1200
      Width           =   1695
   End
   Begin VB.Label msg 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "%m"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   915
      Left            =   720
      TabIndex        =   0
      Top             =   480
      Width           =   2970
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmMensaje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private clsFormulario As clsFrmMovMan

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then Unload Me
End Sub

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    MakeFormTransparent Me, vbRed

End Sub

Private Sub imgAceptar_Click()

    If OldPersonajeVisible Then
        ' frmOldPersonaje.SetFocus
    ElseIf ConnectVisible Then
        'frmConnect.SetFocus
    End If

    If msg.Caption = "Ejecuta el updater" Or msg.Caption = "Esta versión del juego es obsoleta." Then
        If MsgBox("Deseas actualizar el cliente?", vbYesNo, "TDS Legacy") = vbYes Then
            Call ShellExecute(0, "Open", App.Path & "\updater.exe", App.EXEName & ".exe", App.Path, SW_SHOWNORMAL)
            Call Mod_General.CloseClient    'End
        End If
    End If

    Unload Me
End Sub
