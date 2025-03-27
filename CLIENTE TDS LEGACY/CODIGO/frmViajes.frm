VERSION 5.00
Begin VB.Form frmViajes 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Viajero"
   ClientHeight    =   4320
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   3030
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4320
   ScaleWidth      =   3030
   StartUpPosition =   1  'CenterOwner
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   3120
      Width           =   2775
      _ExtentX        =   4895
      _ExtentY        =   873
      Caption         =   "Viajar"
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
   Begin VB.ListBox lstPlace 
      Height          =   2595
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2775
   End
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   3720
      Width           =   2775
      _ExtentX        =   4895
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
   Begin VB.Label Label1 
      Caption         =   "Precio: 5000 monedas"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   2760
      Width           =   2775
   End
End
Attribute VB_Name = "frmViajes"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Dim LoopC As Long
    For LoopC = 1 To NumPasajes
        lstPlace.AddItem Pasajes(LoopC).Nombre
    Next LoopC
    lstPlace.ListIndex = 0
    
End Sub

Private Sub lstPlace_Click()
    Label1.Caption = "Precio: " & Pasajes(lstPlace.ListIndex + 1).precio & " monedas de oro."
End Sub

Private Sub lstPlace_DblClick()
    lvButtons_H1_Click
End Sub

Private Sub lvButtons_H1_Click()
    WriteViajar lstPlace.ListIndex + 1
    Unload Me
    
End Sub

Private Sub lvButtons_H2_Click()
    Unload Me
End Sub
