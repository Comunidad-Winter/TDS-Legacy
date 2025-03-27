VERSION 5.00
Begin VB.Form frmBorrarPj 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Borrar personaje"
   ClientHeight    =   2910
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2910
   ScaleWidth      =   3615
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtNewPass 
      Alignment       =   2  'Center
      Height          =   285
      IMEMode         =   3  'DISABLE
      Left            =   120
      MaxLength       =   30
      PasswordChar    =   "*"
      TabIndex        =   3
      Top             =   1800
      Width           =   3375
   End
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   2280
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   873
      Caption         =   "Aceptar"
      CapAlign        =   2
      BackStyle       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      cGradient       =   0
      Mode            =   0
      Value           =   0   'False
      cBack           =   -2147483633
   End
   Begin VB.TextBox txtPin 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   120
      MaxLength       =   8
      TabIndex        =   2
      Top             =   1080
      Width           =   3375
   End
   Begin VB.TextBox txtNick 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   120
      MaxLength       =   25
      TabIndex        =   1
      Top             =   360
      Width           =   3375
   End
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   495
      Left            =   1920
      TabIndex        =   5
      Top             =   2280
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   873
      Caption         =   "Cancelar"
      CapAlign        =   2
      BackStyle       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      cGradient       =   0
      Mode            =   0
      Value           =   0   'False
      cBack           =   -2147483633
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "Contraseña"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1560
      Width           =   3375
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Pin"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   840
      Width           =   3375
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Nick"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "frmBorrarPj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub lvButtons_H1_Click()
    Call BorroPj(txtNick.Text, txtNewPass.Text, txtPin.Text)
    Unload Me
End Sub

Private Sub lvButtons_H2_Click()
    Unload Me
End Sub

