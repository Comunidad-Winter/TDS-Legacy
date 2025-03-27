VERSION 5.00
Begin VB.Form frmCustomInput 
   Caption         =   "Escribe el mensaje"
   ClientHeight    =   3720
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   5355
   LinkTopic       =   "Form2"
   ScaleHeight     =   3720
   ScaleWidth      =   5355
   StartUpPosition =   1  'CenterOwner
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   615
      Left            =   120
      TabIndex        =   1
      Top             =   3000
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   1085
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
   Begin VB.TextBox Text1 
      Height          =   2775
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   120
      Width           =   5175
   End
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   615
      Left            =   2760
      TabIndex        =   2
      Top             =   3000
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   1085
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
End
Attribute VB_Name = "frmCustomInput"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub lvButtons_H1_Click()
    vWrite = Text1.Text
    Unload Me
End Sub

Private Sub lvButtons_H2_Click()
    vWrite = inputCancel
    Unload Me
End Sub
