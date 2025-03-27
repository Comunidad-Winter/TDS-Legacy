VERSION 5.00
Begin VB.Form frmGuildFoundation 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Creación de un Clan"
   ClientHeight    =   5160
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4155
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   344
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   277
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.OptionButton Option3 
      BackColor       =   &H00004080&
      Caption         =   "Legión Oscura"
      ForeColor       =   &H00E0E0E0&
      Height          =   420
      Left            =   2880
      TabIndex        =   4
      Top             =   4080
      Width           =   990
   End
   Begin VB.OptionButton Option2 
      BackColor       =   &H00004080&
      Caption         =   "Neutral"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   1560
      TabIndex        =   3
      Top             =   4200
      Width           =   975
   End
   Begin VB.OptionButton Option1 
      BackColor       =   &H00004080&
      Caption         =   "ArmadaReal"
      ForeColor       =   &H00E0E0E0&
      Height          =   420
      Left            =   240
      TabIndex        =   2
      Top             =   4080
      Width           =   990
   End
   Begin VB.TextBox txtClanName 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   360
      TabIndex        =   0
      Top             =   2040
      Width           =   3465
   End
   Begin VB.TextBox txtWeb 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   360
      TabIndex        =   1
      Top             =   3120
      Width           =   3465
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   $"frmGuildFoundation.frx":0000
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   975
      Left            =   360
      TabIndex        =   5
      Top             =   960
      Width           =   3495
   End
   Begin VB.Image imgSiguiente 
      Height          =   375
      Left            =   2640
      Tag             =   "1"
      Top             =   4680
      Width           =   1335
   End
   Begin VB.Image imgCancelar 
      Height          =   375
      Left            =   120
      Tag             =   "1"
      Top             =   4680
      Width           =   1335
   End
End
Attribute VB_Name = "frmGuildFoundation"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Enum eAlineacion
    ieREAL = 0
    ieCAOS = 1
    ieNeutral = 2
    ieLegal = 4
    ieCriminal = 5
End Enum
Private clsFormulario As clsFrmMovMan

Public LastPressed As clsGraphicalButton

Private Sub Form_Deactivate()
    Me.SetFocus
End Sub

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    Call forms_load_pic(Me, "973.bmp", False)

End Sub

Private Sub ImgCancelar_Click()
    Unload Me
End Sub

Private Sub imgSiguiente_Click()
    If Len(txtClanName.Text) <= 0 And Len(txtWeb.Text) <= 0 Then
        MsgBox "Debe rellenar todos los datos"
        Exit Sub
    End If
    If Option1.Value = 0 And Option2.Value = 0 And Option3.Value = 0 Then
        MsgBox "Debes elegir alguna alineación"
        Exit Sub
    End If

    If Len(txtClanName.Text) <= 20 Then
        If Not AsciiValidos(txtClanName) Then
            MsgBox "Nombre invalido."
            Exit Sub
        End If
    Else
        MsgBox "Nombre demasiado extenso."
        Exit Sub
    End If
    ClanName = txtClanName.Text
    Site = txtWeb.Text
    Unload Me
    frmGuildDetails.Show , frmMain
End Sub

Private Sub Option1_Click()
    If Option3.Value = 1 Then Option3.Value = 0
    If Option2.Value = 1 Then Option2.Value = 0
    WriteGuildFundation eAlineacion.ieREAL
End Sub

Private Sub Option2_Click()
'PAJ ALSJFLASJKFASFASFASF
    If Option3.Value = 1 Then Option3.Value = 0
    If Option1.Value = 1 Then Option1.Value = 0
    Call WriteGuildFundation(eAlineacion.ieNeutral)
End Sub

Private Sub Option3_Click()
    If Option1.Value = 1 Then Option1.Value = 0
    If Option2.Value = 1 Then Option2.Value = 0
    WriteGuildFundation eAlineacion.ieCAOS
End Sub

