VERSION 5.00
Begin VB.Form frmBorrarPersonaje 
   BackColor       =   &H00E0E0E0&
   BorderStyle     =   0  'None
   Caption         =   "Elimina tu personaje"
   ClientHeight    =   4980
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4785
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmBorrarPersonaje.frx":0000
   ScaleHeight     =   332
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   319
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtEmail 
      Height          =   285
      Left            =   240
      TabIndex        =   3
      Top             =   1920
      Width           =   4335
   End
   Begin VB.TextBox txtPin 
      Height          =   285
      IMEMode         =   3  'DISABLE
      Left            =   240
      PasswordChar    =   "*"
      TabIndex        =   2
      Top             =   3720
      Width           =   4335
   End
   Begin VB.TextBox txtPass 
      Height          =   285
      IMEMode         =   3  'DISABLE
      Left            =   240
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   2880
      Width           =   4335
   End
   Begin VB.TextBox txtNick 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Top             =   1080
      Width           =   4335
   End
   Begin VB.Image imgCerrar 
      Height          =   495
      Left            =   360
      Top             =   4440
      Width           =   1215
   End
   Begin VB.Image imgAceptar 
      Height          =   495
      Left            =   3240
      Top             =   4440
      Width           =   1215
   End
End
Attribute VB_Name = "frmBorrarPersonaje"
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
    'Call forms_load_pic(Me, "XXXX.bmp", False)

End Sub

Private Sub imgAceptar_Click()

    Dim nick As String, pass As String, pin As String, email As String

    nick = Trim$(txtNick.Text)
    pass = Trim$(txtPass.Text)
    pin = Trim$(txtPin.Text)
    email = Trim$(txtEmail.Text)

    If Len(nick) < 3 Then
        ShowConsoleMsg "Nick demasiado corto."
        Exit Sub
    End If
    If Len(email) < 5 Then
        ShowConsoleMsg "Nick demasiado corto."
        Exit Sub
    End If
    If pass = vbNullString Then
        ShowConsoleMsg "Contraseña demasiada corta."
        Exit Sub
    End If
    If pin = vbNullString Then
        ShowConsoleMsg "Nick demasiado corto."
        Exit Sub
    End If

    frmBorrarPersonaje.SetFocus

    If MsgBox("Estás seguro de borrar a " & Chr(34) & txtNick.Text & Chr(34) & "?", vbYesNo, "Borrar personaje") = vbYes Then
        Call WriteBorrarPersonaje(nick, pass, pin, email)
    End If

    Unload Me

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub
