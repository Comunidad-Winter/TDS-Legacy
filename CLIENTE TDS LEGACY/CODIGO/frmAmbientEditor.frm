VERSION 5.00
Begin VB.Form frmAmbientEditor 
   Caption         =   "Editor de Ambiente"
   ClientHeight    =   5250
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7515
   LinkTopic       =   "Form1"
   ScaleHeight     =   5250
   ScaleWidth      =   7515
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame2 
      Caption         =   "Meteo"
      Height          =   1575
      Left            =   3960
      TabIndex        =   10
      Top             =   240
      Visible         =   0   'False
      Width           =   3255
      Begin VB.CheckBox Check3 
         Caption         =   "Llueve (No funca pa todos)"
         Height          =   255
         Left            =   240
         TabIndex        =   25
         Top             =   1920
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Nieve (No funca pa todos)"
         Height          =   255
         Left            =   240
         TabIndex        =   24
         Top             =   1680
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.CommandButton Command9 
         Caption         =   "Aplicar"
         Height          =   255
         Left            =   720
         TabIndex        =   21
         Top             =   1200
         Width           =   2055
      End
      Begin VB.HScrollBar HScroll1 
         Enabled         =   0   'False
         Height          =   255
         Left            =   240
         Max             =   150
         TabIndex        =   12
         Top             =   840
         Value           =   30
         Width           =   2775
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Usar Niebla en el Mapa"
         Height          =   255
         Left            =   720
         TabIndex        =   11
         Top             =   240
         Width           =   2055
      End
      Begin VB.Label Label2 
         Caption         =   "Grado de Niebla"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   600
         Width           =   2415
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Luz Ambiente"
      Height          =   1335
      Left            =   360
      TabIndex        =   2
      Top             =   240
      Width           =   3255
      Begin VB.TextBox posY_Ambiente 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   3840
         TabIndex        =   29
         Text            =   "50"
         Top             =   480
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.TextBox posX_Ambiente 
         Alignment       =   2  'Center
         Height          =   285
         Left            =   3240
         TabIndex        =   28
         Text            =   "50"
         Top             =   480
         Visible         =   0   'False
         Width           =   495
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Aplicar en este mapa A TODOS"
         Height          =   255
         Left            =   220
         TabIndex        =   9
         Top             =   960
         Width           =   2775
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Index           =   2
         Left            =   2400
         TabIndex        =   8
         Text            =   "255"
         Top             =   600
         Width           =   495
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Index           =   1
         Left            =   1560
         TabIndex        =   7
         Text            =   "255"
         Top             =   600
         Width           =   495
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Index           =   0
         Left            =   600
         TabIndex        =   6
         Text            =   "255"
         Top             =   600
         Width           =   495
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Luz artificial"
         Height          =   255
         Index           =   1
         Left            =   1800
         TabIndex        =   4
         Top             =   240
         Width           =   1335
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Luz natural"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   3
         Top             =   240
         Width           =   1575
      End
      Begin VB.Label lblPos 
         Alignment       =   2  'Center
         Caption         =   "Posición"
         Height          =   255
         Left            =   3240
         TabIndex        =   30
         Top             =   240
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "R:           G:           B:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   360
         TabIndex        =   5
         Top             =   600
         Width           =   2535
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Guardar ambiente (Requiere AutoUpdate)"
      Height          =   375
      Left            =   2280
      TabIndex        =   1
      Top             =   4320
      Width           =   3375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Recargar Ambiente (Requiere AutoUpdate)"
      Height          =   375
      Left            =   2280
      TabIndex        =   0
      Top             =   4800
      Width           =   3375
   End
   Begin VB.Frame Frame3 
      Caption         =   "Luces"
      Height          =   2295
      Left            =   360
      TabIndex        =   14
      Top             =   1920
      Width           =   5175
      Begin VB.PictureBox Picture1 
         AutoSize        =   -1  'True
         Height          =   1515
         Left            =   3360
         Picture         =   "frmAmbientEditor.frx":0000
         ScaleHeight     =   1455
         ScaleWidth      =   1455
         TabIndex        =   31
         Top             =   450
         Width           =   1515
      End
      Begin VB.CheckBox chkLuzRedonda 
         Caption         =   "Luz Redonda"
         Height          =   255
         Left            =   1680
         TabIndex        =   27
         Top             =   1080
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.CheckBox ChkLuzCuadrada 
         Caption         =   "Luz Cuadrada"
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   1080
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.HScrollBar HScroll2 
         Height          =   255
         Left            =   840
         Max             =   10
         Min             =   1
         TabIndex        =   23
         Top             =   720
         Value           =   1
         Width           =   2055
      End
      Begin VB.CommandButton Command10 
         Caption         =   "Borrar luz"
         Height          =   375
         Left            =   200
         TabIndex        =   22
         Top             =   1800
         Width           =   2895
      End
      Begin VB.TextBox Text4 
         Height          =   285
         Left            =   2340
         TabIndex        =   19
         Text            =   "255"
         Top             =   375
         Width           =   495
      End
      Begin VB.TextBox Text3 
         Height          =   285
         Left            =   1455
         TabIndex        =   18
         Text            =   "255"
         Top             =   375
         Width           =   495
      End
      Begin VB.TextBox Text2 
         Height          =   285
         Left            =   585
         TabIndex        =   17
         Text            =   "255"
         Top             =   375
         Width           =   495
      End
      Begin VB.CommandButton Command8 
         Caption         =   "Crear luz"
         Height          =   375
         Left            =   200
         TabIndex        =   15
         Top             =   1440
         Width           =   2895
      End
      Begin VB.Label Label4 
         Caption         =   "Rango:"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   720
         Width           =   615
      End
      Begin VB.Label Label3 
         Caption         =   "R:           G:           B:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         TabIndex        =   16
         Top             =   360
         Width           =   2535
      End
   End
End
Attribute VB_Name = "frmAmbientEditor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Check1_Click()

    HScroll1.Enabled = IIf(Check1.value, True, False)

End Sub

Private Sub ChkLuzCuadrada_Click()

    chkLuzRedonda.value = 0

End Sub

Private Sub chkLuzRedonda_Click()

    ChkLuzCuadrada.value = 0

End Sub

Private Sub Command1_Click()

    Call Light_Remove_All
    Call Init_Ambient(UserMap, 1)

End Sub

Private Sub Command10_Click()

    If CurMapAmbient.MapBlocks(UserPos.X, UserPos.Y).Light.ID > 0 Then
        Call WriteSetLight(1, UserPos.X, UserPos.Y, 0, 0, 0, 0, 0)
    End If

End Sub

Private Sub Command2_Click()

    Call Save_Ambient(UserMap)
    DoEventsEx

    Call Light_Remove_All
    Call Init_Ambient(UserMap)

End Sub

Private Sub Command7_Click()

    If Option1(0).value Then
        Call WriteSetAmbient(1, 0, 0, 0)
        Exit Sub
    End If

    If Text1(0).Text < 0 Or Text1(0).Text > 255 Then Text1(0).Text = 255
    If Text1(1).Text < 0 Or Text1(1).Text > 255 Then Text1(1).Text = 255
    If Text1(2).Text < 0 Or Text1(2).Text > 255 Then Text1(2).Text = 255

    Call WriteSetAmbient(0, Val(Text1(0).Text), Val(Text1(1).Text), Val(Text1(2).Text))

End Sub

Private Sub Command8_Click()

    Dim ID As Byte

    'If ChkLuzCuadrada.value > 0 Then
    '    ID = 1
    'ElseIf chkLuzRedonda.value > 0 Then
    '    ID = 2
    'Else
    '    MsgBox "No elegiste el tipo de luz culiado."
    '    Exit Sub
    'End If
    ID = 2

    If Val(Text2.Text) < 0 Or Val(Text2.Text) > 255 Then Text2.Text = 255
    If Val(Text3.Text) < 0 Or Val(Text3.Text) > 255 Then Text3.Text = 255
    If Val(Text4.Text) < 0 Or Val(Text4.Text) > 255 Then Text4.Text = 255

    If CurMapAmbient.MapBlocks(UserPos.X, UserPos.Y).Light.ID < 1 Then
        Call WriteSetLight(0, UserPos.X, UserPos.Y, Val(Text2.Text), Val(Text3.Text), Val(Text4.Text), Val(HScroll2.value), ID)
        
    End If

End Sub

Private Sub Command9_Click()

    If Check1.value = Unchecked Then HScroll1.value = 0

    If Val(HScroll1.value) > 0 Then
        Call WriteSetFog(1, Val(HScroll1.value))
    Else
        Call WriteSetFog(0, -1)
    End If

End Sub

Private Sub Form_Load()

    If CurMapAmbient.UseDayAmbient Then
        Option1(0).value = True
        Text1(0).Enabled = False
        Text1(1).Enabled = False
        Text1(2).Enabled = False
    Else
        Option1(1).value = True
        Text1(0).Enabled = True
        Text1(1).Enabled = True
        Text1(2).Enabled = True
    End If

    Text1(0).Text = Estado_Actual.R
    Text1(1).Text = Estado_Actual.G
    Text1(2).Text = Estado_Actual.B

    If CurMapAmbient.Fog <> -1 Then
        Check1.value = Checked
        HScroll1.value = CurMapAmbient.Fog
    Else
        Check1.value = Unchecked
    End If

    If CurMapAmbient.Rain Then Check3.value = Checked
    If CurMapAmbient.Snow Then Check2.value = Checked

End Sub

Private Sub Option1_Click(Index As Integer)

    If Index = 0 Then
        Text1(0).Enabled = False
        Text1(1).Enabled = False
        Text1(2).Enabled = False
    Else
        Text1(0).Enabled = True
        Text1(1).Enabled = True
        Text1(2).Enabled = True
    End If

End Sub

Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If Button <> 0 Then

        Picture1.Cls

        Dim Color As Long
        Color = Picture1.Point(X, Y)

        Text2.Text = Color And 255
        Text3.Text = (Color And 65280) / 256
        Text4.Text = (Color And 16711680) / 65536

        Picture1.Line (X, Y)-(X + 50, Y + 50), vbWhite, B

    End If

End Sub

Private Sub Text2_Change()

    If MapData(UserPos.X, UserPos.Y).LightID > 0 Then
        Call ChangeColorLuzPosition(MapData(UserPos.X, UserPos.Y).LightID, Val(Text2.Text), Val(Text3.Text), Val(Text4.Text))
    End If

End Sub

Private Sub Text3_Change()

    If MapData(UserPos.X, UserPos.Y).LightID > 0 Then
        Call ChangeColorLuzPosition(MapData(UserPos.X, UserPos.Y).LightID, Val(Text2.Text), Val(Text3.Text), Val(Text4.Text))
    End If

End Sub

Private Sub Text4_Change()

    If MapData(UserPos.X, UserPos.Y).LightID > 0 Then
        Call ChangeColorLuzPosition(MapData(UserPos.X, UserPos.Y).LightID, Val(Text2.Text), Val(Text3.Text), Val(Text4.Text))
    End If

End Sub
