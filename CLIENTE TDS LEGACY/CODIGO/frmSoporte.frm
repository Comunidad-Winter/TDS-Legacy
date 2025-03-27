VERSION 5.00
Begin VB.Form frmSoporte 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Soporte"
   ClientHeight    =   3030
   ClientLeft      =   105
   ClientTop       =   435
   ClientWidth     =   3705
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3030
   ScaleWidth      =   3705
   StartUpPosition =   3  'Windows Default
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   615
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   1085
      Caption         =   "Enviar una consulta"
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
   Begin TdsClient.lvButtons_H lvButtons_H3 
      Height          =   615
      Left            =   120
      TabIndex        =   1
      Top             =   1560
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   1085
      Caption         =   "Reportar un Bug"
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
   Begin TdsClient.lvButtons_H lvButtons_H4 
      Height          =   615
      Left            =   120
      TabIndex        =   2
      Top             =   2280
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   1085
      Caption         =   "Proponer una idea"
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
   Begin TdsClient.lvButtons_H lvButtons_H5 
      Height          =   615
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   3495
      _ExtentX        =   6165
      _ExtentY        =   1085
      Caption         =   "Reportar un cheater"
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
Attribute VB_Name = "frmSoporte"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub lvButtons_H1_Click()
    Call WriteGMRequest
    Unload Me
End Sub

Private Sub BackOff()
    
End Sub

Private Sub lvButtons_H2_Click()
    Dim msg As String
    msg = CustomInput("Escribe tu consulta")
    If msg = inputCancel Then Unload Me: Exit Sub
    Call ParseUserCommand("/DENUNCIAR {[CONSULTA]}" & msg)
    Unload Me
End Sub

Private Sub lvButtons_H3_Click()
    Dim msg As String
    msg = CustomInput("Escribe el bug")
    If msg = inputCancel Then Unload Me: Exit Sub
    Call ParseUserCommand("/REPORTAR " & msg)
    With FontTypes(FontTypeNames.FONTTYPE_INFO)
        Call AddtoRichTextBox(frmMain.RecTxt, "Gracias por reportar el bug, será solucionado en tanto un administrador esté disponible.", .red, .green, .blue)
    End With
    Unload Me
End Sub

Private Sub lvButtons_H5_Click()
    Dim msg As String
    msg = CustomInput("Escribe el nombre del usuario junto con tus sospechas")
    If msg = inputCancel Then Unload Me: Exit Sub
    Call ParseUserCommand("/DENUNCIAR {[REPORTE CHITERO]}" & msg)
    Unload Me
End Sub
