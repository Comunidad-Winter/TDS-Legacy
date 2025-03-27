VERSION 5.00
Begin VB.Form frmConsultas 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta"
   ClientHeight    =   3885
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3135
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3885
   ScaleWidth      =   3135
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   2295
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   840
      Width           =   2895
   End
   Begin VB.OptionButton Option4 
      Caption         =   "Sugerencia"
      Height          =   255
      Left            =   1680
      TabIndex        =   3
      Top             =   480
      Width           =   1215
   End
   Begin VB.OptionButton Option3 
      Caption         =   "Denuncia"
      Height          =   255
      Left            =   1800
      TabIndex        =   2
      Top             =   120
      Width           =   1095
   End
   Begin VB.OptionButton Option2 
      Caption         =   "Consulta"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   1215
   End
   Begin VB.OptionButton Option1 
      Caption         =   "Reporte de bug"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1575
   End
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   495
      Left            =   120
      TabIndex        =   5
      Top             =   3240
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   873
      Caption         =   "Enviar"
      CapAlign        =   2
      BackStyle       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      cGradient       =   0
      Mode            =   0
      Value           =   0   'False
      cBack           =   -2147483633
   End
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   495
      Left            =   1680
      TabIndex        =   6
      Top             =   3240
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   873
      Caption         =   "Cancelar"
      CapAlign        =   2
      BackStyle       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
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
Attribute VB_Name = "frmConsultas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub lvButtons_H1_Click()
    Unload Me
End Sub

