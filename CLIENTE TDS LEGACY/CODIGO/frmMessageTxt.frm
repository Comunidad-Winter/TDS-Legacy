VERSION 5.00
Begin VB.Form frmMessageTxt 
   BackColor       =   &H8000000A&
   BorderStyle     =   0  'None
   Caption         =   "Mensajes Personalizados"
   ClientHeight    =   5025
   ClientLeft      =   0
   ClientTop       =   -105
   ClientWidth     =   4830
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   335
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   322
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   9
      Left            =   1230
      TabIndex        =   9
      Top             =   4095
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   8
      Left            =   1230
      TabIndex        =   8
      Top             =   3690
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   7
      Left            =   1230
      TabIndex        =   7
      Top             =   3285
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   6
      Left            =   1230
      TabIndex        =   6
      Top             =   2880
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   5
      Left            =   1230
      TabIndex        =   5
      Top             =   2475
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   4
      Left            =   1230
      TabIndex        =   4
      Top             =   2070
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   3
      Left            =   1230
      TabIndex        =   3
      Top             =   1665
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   1
      Left            =   1230
      TabIndex        =   2
      Top             =   855
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   0
      Left            =   1230
      TabIndex        =   1
      Top             =   435
      Width           =   3330
   End
   Begin VB.TextBox messageTxt 
      BackColor       =   &H00000000&
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
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Index           =   2
      Left            =   1230
      TabIndex        =   0
      Top             =   1260
      Width           =   3330
   End
   Begin VB.Image imgGuardar 
      Height          =   420
      Left            =   3360
      Tag             =   "1"
      Top             =   4485
      Width           =   975
   End
   Begin VB.Image imgCancelar 
      Height          =   420
      Left            =   480
      Tag             =   "1"
      Top             =   4485
      Width           =   975
   End
End
Attribute VB_Name = "frmMessageTxt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFormMovementManager

Public LastPressed As clsGraphicalButton

Private Sub Form_Load()
    Dim i As Long

    ' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFormMovementManager
    clsFormulario.Initialize Me

    For i = 0 To 9
        messageTxt(i) = CustomMessages.Message(i)
    Next i

    Call forms_load_pic(Me, "984.bmp", False)

End Sub

Private Sub ImgCancelar_Click()
    Unload Me
End Sub

Private Sub imgGuardar_Click()
    On Error GoTo errHandler
    Dim i As Long

    For i = 0 To 9
        CustomMessages.Message(i) = messageTxt(i)
    Next i

    Unload Me
    Exit Sub

errHandler:
    'Did detected an invalid message??
    If Err.number = CustomMessages.InvalidMessageErrCode Then
        Call MsgBox("El Mensaje " & CStr(i + 1) & " es inválido. Modifiquelo por favor.")
    End If

End Sub
