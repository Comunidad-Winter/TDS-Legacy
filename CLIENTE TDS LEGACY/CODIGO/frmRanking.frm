VERSION 5.00
Begin VB.Form frmRanking 
   BackColor       =   &H00004080&
   BorderStyle     =   1  'Fixed Single
   Caption         =   " Rankings"
   ClientHeight    =   4740
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4350
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   316
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   290
   StartUpPosition =   1  'CenterOwner
   Begin VB.OptionButton optRank 
      BackColor       =   &H00004080&
      Caption         =   "Usuarios matados"
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
      Left            =   2040
      TabIndex        =   4
      Top             =   480
      Width           =   2055
   End
   Begin VB.OptionButton optRank 
      BackColor       =   &H00004080&
      Caption         =   "Retos 3vs3"
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
      Left            =   600
      TabIndex        =   3
      Top             =   480
      Width           =   1335
   End
   Begin VB.OptionButton optRank 
      BackColor       =   &H00004080&
      Caption         =   "Retos 2vs2"
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
      Left            =   2640
      TabIndex        =   2
      Top             =   240
      Width           =   1335
   End
   Begin VB.OptionButton optRank 
      BackColor       =   &H00004080&
      Caption         =   "Retos 1vs1"
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
      Left            =   1200
      TabIndex        =   1
      Top             =   240
      Width           =   1335
   End
   Begin VB.OptionButton optRank 
      BackColor       =   &H00004080&
      Caption         =   "Nivel"
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
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Value           =   -1  'True
      Width           =   855
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Index           =   10
      Left            =   2280
      TabIndex        =   24
      Top             =   4200
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   23
      Top             =   3840
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   22
      Top             =   3480
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   21
      Top             =   3120
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   20
      Top             =   2760
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   19
      Top             =   2400
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   18
      Top             =   2040
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   17
      Top             =   1680
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   16
      Top             =   1320
      Width           =   1935
   End
   Begin VB.Label lblValue 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "47"
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
      Left            =   2280
      TabIndex        =   15
      Top             =   960
      Width           =   1935
   End
   Begin VB.Line Line6 
      BorderWidth     =   2
      X1              =   152
      X2              =   152
      Y1              =   56
      Y2              =   304
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "10 - Nhelk"
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
      Index           =   10
      Left            =   240
      TabIndex        =   14
      Top             =   4200
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "9 - Nhelk"
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
      Left            =   240
      TabIndex        =   13
      Top             =   3840
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "8 - Nhelk"
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
      Left            =   240
      TabIndex        =   12
      Top             =   3480
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "7 - Nhelk"
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
      Left            =   240
      TabIndex        =   11
      Top             =   3120
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "6 - Nhelk"
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
      Left            =   240
      TabIndex        =   10
      Top             =   2760
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "5 - Nhelk"
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
      Left            =   240
      TabIndex        =   9
      Top             =   2400
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "4 - Nhelk"
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
      Left            =   240
      TabIndex        =   8
      Top             =   2040
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "3 - Nhelk"
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
      Left            =   240
      TabIndex        =   7
      Top             =   1680
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "2 - Nhelk"
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
      Left            =   240
      TabIndex        =   6
      Top             =   1320
      Width           =   1935
   End
   Begin VB.Label lblNick 
      BackStyle       =   0  'Transparent
      Caption         =   "1 - Nhelk"
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
      Left            =   240
      TabIndex        =   5
      Top             =   960
      Width           =   1935
   End
   Begin VB.Line Line5 
      BorderWidth     =   2
      X1              =   8
      X2              =   280
      Y1              =   56
      Y2              =   56
   End
   Begin VB.Line Line4 
      BorderWidth     =   2
      X1              =   8
      X2              =   280
      Y1              =   304
      Y2              =   304
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   8
      X2              =   280
      Y1              =   8
      Y2              =   8
   End
   Begin VB.Line Line2 
      BorderWidth     =   2
      X1              =   280
      X2              =   280
      Y1              =   8
      Y2              =   304
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      X1              =   8
      X2              =   8
      Y1              =   7
      Y2              =   304
   End
End
Attribute VB_Name = "frmRanking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Option2_Click()

End Sub

Private Sub optRank_Click(Index As Integer)
    Call CargarRank(Index + 1)
End Sub

Public Sub CargarRank(ByVal Tipo As Byte)
    With Rankings(Tipo)
        Dim x As Long
        For x = 1 To 10
            If LenB(.user(x).Nick) > 0 Then
                lblNick(x).Caption = .user(x).Nick
                lblValue(x).Caption = .user(x).Value
            Else
                lblNick(x).Caption = "Vacio"
                lblValue(x).Caption = "-"
            End If
        Next x
    End With
End Sub
