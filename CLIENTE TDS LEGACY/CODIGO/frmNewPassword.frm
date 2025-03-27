VERSION 5.00
Begin VB.Form frmNewPassword 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   " Password nuevo"
   ClientHeight    =   2985
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2955
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   199
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   197
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text3 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      IMEMode         =   3  'DISABLE
      Left            =   375
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   2055
      Width           =   2160
   End
   Begin VB.TextBox Text2 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      IMEMode         =   3  'DISABLE
      Left            =   375
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   1455
      Width           =   2160
   End
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      IMEMode         =   3  'DISABLE
      Left            =   360
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   855
      Width           =   2160
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Re ingrese su password nuevo"
      ForeColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   1800
      Width           =   2295
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   " Password nuevo"
      ForeColor       =   &H00C0C0C0&
      Height          =   210
      Left            =   360
      TabIndex        =   5
      Top             =   1200
      Width           =   2175
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   " Password viejo"
      ForeColor       =   &H00C0C0C0&
      Height          =   210
      Left            =   360
      TabIndex        =   4
      Top             =   600
      Width           =   2175
   End
   Begin VB.Label ImgCancelar 
      BackStyle       =   0  'Transparent
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   2400
      Width           =   1215
   End
   Begin VB.Image imgAceptar 
      Height          =   495
      Left            =   1680
      Tag             =   "1"
      Top             =   2400
      Width           =   1095
   End
End
Attribute VB_Name = "frmNewPassword"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Public LastPressed As clsGraphicalButton

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    Call forms_load_pic(Me, "976.bmp", False)

End Sub

Private Sub imgAceptar_Click()
    If Text2.Text <> Text3.Text Then
        Call MsgBox("Las contraseñas no coinciden", vbCritical Or vbOKOnly Or vbApplicationModal Or vbDefaultButton1, "Cambiar Contraseña")
        Exit Sub
    End If

    Call WriteChangePassword(Text1.Text, Text2.Text)
    Unload Me
End Sub

Private Sub ImgCancelar_Click()
    Unload Me
End Sub
