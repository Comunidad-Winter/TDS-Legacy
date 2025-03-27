VERSION 5.00
Begin VB.Form frmPartyPorc 
   BackColor       =   &H00004080&
   BorderStyle     =   0  'None
   Caption         =   "Acomodar Porcentajes"
   ClientHeight    =   2985
   ClientLeft      =   4305
   ClientTop       =   0
   ClientWidth     =   3000
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmPartyPorc.frx":0000
   ScaleHeight     =   199
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   200
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Porc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2280
      MaxLength       =   3
      TabIndex        =   4
      Text            =   "0"
      Top             =   1320
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox Porc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2280
      MaxLength       =   3
      TabIndex        =   3
      Text            =   "0"
      Top             =   600
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox Porc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2280
      MaxLength       =   3
      TabIndex        =   2
      Text            =   "0"
      Top             =   960
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox Porc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   2280
      MaxLength       =   3
      TabIndex        =   1
      Text            =   "0"
      Top             =   1650
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox Porc 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   2280
      MaxLength       =   3
      TabIndex        =   0
      Text            =   "0"
      Top             =   2010
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Label Pj 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Pj1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   11
      Top             =   600
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.Label Pj 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Pj1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   10
      Top             =   960
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.Label Pj 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Pj1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   9
      Top             =   1320
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.Label Pj 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Pj1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   8
      Top             =   1680
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.Label Pj 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Pj1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   7
      Top             =   2040
      Visible         =   0   'False
      Width           =   285
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Personaje"
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
      Height          =   195
      Left            =   120
      TabIndex        =   6
      Top             =   315
      Width           =   855
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "%"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0C0&
      Height          =   195
      Left            =   2400
      TabIndex        =   5
      Top             =   315
      Width           =   150
   End
   Begin VB.Image Boton 
      Height          =   375
      Index           =   0
      Left            =   1800
      Top             =   2520
      Width           =   1095
   End
   Begin VB.Image Boton 
      Height          =   375
      Index           =   1
      Left            =   150
      Top             =   2490
      Width           =   1215
   End
   Begin VB.Line Lin 
      BorderColor     =   &H00E0E0E0&
      Index           =   5
      Visible         =   0   'False
      X1              =   120
      X2              =   3120
      Y1              =   2280
      Y2              =   2280
   End
   Begin VB.Line Lin 
      BorderColor     =   &H00E0E0E0&
      Index           =   4
      Visible         =   0   'False
      X1              =   120
      X2              =   3120
      Y1              =   1920
      Y2              =   1920
   End
   Begin VB.Line Lin 
      BorderColor     =   &H00E0E0E0&
      Index           =   3
      Visible         =   0   'False
      X1              =   120
      X2              =   3120
      Y1              =   1560
      Y2              =   1560
   End
   Begin VB.Line Lin 
      BorderColor     =   &H00E0E0E0&
      Index           =   2
      Visible         =   0   'False
      X1              =   120
      X2              =   3120
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Line Lin 
      BorderColor     =   &H00E0E0E0&
      Index           =   1
      Visible         =   0   'False
      X1              =   120
      X2              =   3120
      Y1              =   840
      Y2              =   840
   End
End
Attribute VB_Name = "frmPartyPorc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Porcentajes(0 To 4) As Byte

Private Sub Boton_Click(index As Integer)

    If index > 0 Then
        Call WriteSetPartyPorcentajes(Porcentajes())
    End If

    Erase Porcentajes()
    Unload Me

End Sub

Private Sub Form_Load()

    Dim LoopC As Long

    For LoopC = 0 To 4
        Pj(LoopC).Caption = frmParty.Label5(LoopC).Caption

        If LenB(Pj(LoopC).Caption) > 0 Then
            Porcentajes(LoopC) = Val(frmParty.Label8(LoopC).Caption)
            Porc(LoopC).Text = Porcentajes(LoopC)

            Pj(LoopC).visible = True
            Porc(LoopC).visible = True
        End If
    Next LoopC

End Sub

Private Sub Porc_Change(index As Integer)

'If Val(Porc(Index).Text) > 90 Then
'    Porc(Index).Text = 90
'End If

'If Val(Porc(Index).Text) < 10 Then
'    Porc(Index).Text = 10
'End If
    Dim tmpval As Long
    tmpval = Val(Porc(index).Text)

    If tmpval > 255 Then
        tmpval = 100
    End If
    If tmpval = 0 Then tmpval = 1

    Porcentajes(index) = tmpval    'Val(Porc(Index).Text)
    Porc(index).Text = tmpval

End Sub
