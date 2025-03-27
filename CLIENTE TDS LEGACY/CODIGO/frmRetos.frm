VERSION 5.00
Begin VB.Form frmRetos 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Retos"
   ClientHeight    =   5910
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   3015
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmRetos.frx":0000
   ScaleHeight     =   5910
   ScaleWidth      =   3015
   StartUpPosition =   2  'CenterScreen
   Begin VB.OptionButton Option3 
      Caption         =   "3vs3"
      Enabled         =   0   'False
      Height          =   255
      Left            =   2160
      TabIndex        =   28
      Top             =   120
      Width           =   735
   End
   Begin VB.OptionButton Option1 
      Caption         =   "1vs1"
      Height          =   255
      Left            =   120
      TabIndex        =   27
      Top             =   120
      Width           =   735
   End
   Begin VB.OptionButton Option2 
      Caption         =   "2vs2"
      Height          =   255
      Left            =   1080
      TabIndex        =   26
      Top             =   120
      Width           =   735
   End
   Begin TdsClient.lvButtons_H lvButtons_H1 
      Height          =   495
      Left            =   120
      TabIndex        =   24
      Top             =   5280
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   873
      Caption         =   "Retar"
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
   Begin TdsClient.lvButtons_H lvButtons_H2 
      Height          =   495
      Left            =   1560
      TabIndex        =   25
      Top             =   5280
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
   Begin VB.Frame Frame1 
      Caption         =   "Retos"
      Height          =   4695
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   2775
      Begin VB.CheckBox Check10 
         Caption         =   "AIM"
         Height          =   255
         Left            =   1440
         TabIndex        =   44
         Top             =   960
         Width           =   735
      End
      Begin VB.CheckBox Check9 
         Caption         =   "Personaje"
         Height          =   255
         Left            =   240
         TabIndex        =   43
         Top             =   960
         Width           =   1215
      End
      Begin VB.CheckBox Check8 
         Caption         =   "No usar escudos y cascos"
         Height          =   255
         Left            =   240
         TabIndex        =   42
         Top             =   1320
         Width           =   2415
      End
      Begin VB.CheckBox Check7 
         Caption         =   "Plantes"
         Enabled         =   0   'False
         Height          =   255
         Left            =   1440
         TabIndex        =   41
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox potas 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         CausesValidation=   0   'False
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1440
         TabIndex        =   7
         Text            =   "0"
         Top             =   600
         Width           =   735
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Pociones"
         Height          =   255
         Left            =   240
         TabIndex        =   6
         Top             =   600
         Width           =   975
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Por items"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox Text2 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   3
         Top             =   1920
         Width           =   2295
      End
      Begin VB.TextBox Text1 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   1
         Top             =   2640
         Width           =   2295
      End
      Begin VB.Label Label2 
         Caption         =   "Oro"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   1680
         Width           =   2295
      End
      Begin VB.Label Label1 
         Caption         =   "Oponente"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   2400
         Width           =   2295
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Retos"
      Height          =   4695
      Left            =   120
      TabIndex        =   8
      Top             =   480
      Visible         =   0   'False
      Width           =   2775
      Begin VB.TextBox Text11 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   23
         Top             =   1200
         Width           =   2295
      End
      Begin VB.TextBox Text10 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   21
         Top             =   4200
         Width           =   2295
      End
      Begin VB.TextBox Text9 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   19
         Top             =   3600
         Width           =   2295
      End
      Begin VB.TextBox Text8 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   17
         Top             =   3000
         Width           =   2295
      End
      Begin VB.TextBox Text7 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   15
         Top             =   2400
         Width           =   2295
      End
      Begin VB.TextBox Text6 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   12
         Top             =   1800
         Width           =   2295
      End
      Begin VB.CheckBox Check4 
         Caption         =   "Por items"
         Height          =   255
         Left            =   240
         TabIndex        =   11
         Top             =   240
         Width           =   975
      End
      Begin VB.CheckBox Check3 
         Caption         =   "Pociones"
         Height          =   255
         Left            =   240
         TabIndex        =   10
         Top             =   600
         Width           =   975
      End
      Begin VB.TextBox Text4 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   9
         Top             =   600
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.Label Label10 
         Caption         =   "Pareja 2"
         Height          =   255
         Left            =   240
         TabIndex        =   22
         Top             =   3960
         Width           =   2295
      End
      Begin VB.Label Label9 
         Caption         =   "Pareja 1"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   3360
         Width           =   2295
      End
      Begin VB.Label Label8 
         Caption         =   "Oponente 3"
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   2760
         Width           =   2295
      End
      Begin VB.Label Label7 
         Caption         =   "Oponente 2"
         Height          =   255
         Left            =   240
         TabIndex        =   16
         Top             =   2160
         Width           =   2295
      End
      Begin VB.Label Label6 
         Caption         =   "Oponente 1"
         Height          =   255
         Left            =   240
         TabIndex        =   14
         Top             =   1560
         Width           =   2295
      End
      Begin VB.Label Label5 
         Caption         =   "Oro"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   960
         Width           =   2295
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Retos"
      Height          =   4695
      Left            =   120
      TabIndex        =   29
      Top             =   480
      Visible         =   0   'False
      Width           =   2775
      Begin VB.TextBox Text17 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   36
         Top             =   600
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.CheckBox Check6 
         Caption         =   "Pociones"
         Height          =   255
         Left            =   240
         TabIndex        =   35
         Top             =   600
         Visible         =   0   'False
         Width           =   975
      End
      Begin VB.CheckBox Check5 
         Caption         =   "Por items"
         Height          =   255
         Left            =   240
         TabIndex        =   34
         Top             =   240
         Width           =   975
      End
      Begin VB.TextBox Text16 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   33
         Top             =   1440
         Width           =   2295
      End
      Begin VB.TextBox Text15 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   32
         Top             =   2040
         Width           =   2295
      End
      Begin VB.TextBox Text12 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   31
         Top             =   2640
         Width           =   2295
      End
      Begin VB.TextBox Text5 
         Appearance      =   0  'Flat
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   240
         TabIndex        =   30
         Top             =   840
         Width           =   2295
      End
      Begin VB.Label Label14 
         Caption         =   "Oro"
         Height          =   255
         Left            =   240
         TabIndex        =   40
         Top             =   600
         Width           =   2295
      End
      Begin VB.Label Label13 
         Caption         =   "Oponente 1"
         Height          =   255
         Left            =   240
         TabIndex        =   39
         Top             =   1200
         Width           =   2295
      End
      Begin VB.Label Label12 
         Caption         =   "Oponente 2"
         Height          =   255
         Left            =   240
         TabIndex        =   38
         Top             =   1800
         Width           =   2295
      End
      Begin VB.Label Label3 
         Caption         =   "Pareja"
         Height          =   255
         Left            =   240
         TabIndex        =   37
         Top             =   2400
         Width           =   2295
      End
   End
End
Attribute VB_Name = "frmRetos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Check2_Click()
    potas.Enabled = (Check2.Value = 1)
    Label3.Visible = Option1.Value
End Sub

Private Sub Check3_Click()
    Text4.Visible = Not Text4.Visible
End Sub

Private Sub Form_Load()
    Set Me.Picture = Nothing
    Option1.Value = True
End Sub

Private Sub lvButtons_H1_Click()
    If Val(potas.Text) > 10000 Then potas.Text = 10000
    
    If Frame1.Visible = True Then _
        WriteRetar Replace(Text1.Text, " ", "+"), Val(Text2.Text), (Check1.Value = 1), (Check7.Value = 1), Val(potas.Text), (Check8.Value = 1), (Check9.Value = 1), (Check10.Value = 1)
        
    If Frame2.Visible = True Then
        '@@ write del reto 2vs2
        Dim sText As String
        Dim i     As Long

        sText = sText & Text12.Text & "*" & Text15.Text & "*" & Text16.Text

        Call Protocol.WriteSendReto(sText, Val(Text5.Text), (Check5.Value = 1))
    End If
    If Frame3.Visible = True Then _
        WriteSendReto3 Text9.Text, Text10.Text, Text6.Text, Text7.Text, Text8.Text, Val(Text11.Text), (Check4.Value), Val(Text4.Text)

    Unload Me
End Sub

Private Sub lvButtons_H2_Click()
    Unload Me
End Sub
Sub updateFrames()
    If Option1.Value = True Then
        Frame1.Visible = True
        Frame2.Visible = False
        Frame3.Visible = False
    End If
    If Option2.Value = True Then
        Frame1.Visible = False
        Frame2.Visible = True
        Frame3.Visible = False
    End If
    If Option3.Value = True Then
        Frame1.Visible = False
        Frame2.Visible = False
        Frame3.Visible = True
    End If
End Sub

Private Sub Option1_Click()
updateFrames
End Sub

Private Sub Option2_Click()
updateFrames
End Sub

Private Sub Option3_Click()
'updateFrames
End Sub

Private Sub potas_Change()
    If Text2.Text = "" Then Exit Sub
    Text2.Text = Val(Text2.Text)
End Sub

Private Sub Text2_Change()
    If Text2.Text = "" Then Exit Sub
    Text2.Text = Val(Text2.Text)
End Sub

Private Sub Text4_Change()
    Text4.Text = Val(Text4.Text)
    If Text4.Text > 1500 Then Text4.Text = 1500
End Sub

Private Sub Text5_Change()
    If Text5.Text = "" Then Exit Sub
    Text5.Text = Val(Text5.Text)

End Sub
