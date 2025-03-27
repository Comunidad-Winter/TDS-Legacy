VERSION 5.00
Begin VB.Form frmEvents 
   BackColor       =   &H00000000&
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Eventos automaticos"
   ClientHeight    =   4875
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   5265
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4875
   ScaleWidth      =   5265
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame frameClases 
      BackColor       =   &H00000000&
      Caption         =   "Clases NO permitidas:"
      ForeColor       =   &H0000FF00&
      Height          =   1095
      Left            =   120
      TabIndex        =   24
      Top             =   3000
      Visible         =   0   'False
      Width           =   4935
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Pirata"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   11
         Left            =   3600
         TabIndex        =   36
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Trabajador"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   10
         Left            =   3600
         TabIndex        =   35
         Top             =   480
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Cazador"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   9
         Left            =   3600
         TabIndex        =   34
         Top             =   240
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Paladin"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   8
         Left            =   2520
         TabIndex        =   33
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Bandido"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   7
         Left            =   2520
         TabIndex        =   32
         Top             =   480
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Druida"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   6
         Left            =   2520
         TabIndex        =   31
         Top             =   240
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Bardo"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   5
         Left            =   1440
         TabIndex        =   30
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Ladrón"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   4
         Left            =   1440
         TabIndex        =   29
         Top             =   480
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Asesino"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   3
         Left            =   1440
         TabIndex        =   28
         Top             =   240
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Guerrero"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   27
         Top             =   720
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Clerigo"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   26
         Top             =   480
         Width           =   1215
      End
      Begin VB.CheckBox cp 
         BackColor       =   &H00000000&
         Caption         =   "Mago"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   25
         Top             =   240
         Width           =   1215
      End
   End
   Begin VB.CommandButton cmdCancelEvent 
      BackColor       =   &H000000FF&
      Caption         =   "CANCELAR Torneo"
      Height          =   615
      Left            =   120
      MaskColor       =   &H000000FF&
      TabIndex        =   23
      Top             =   4200
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CommandButton cmdCreateEvent 
      Caption         =   "CREAR Torneo"
      Height          =   615
      Left            =   2040
      TabIndex        =   22
      Top             =   4200
      Visible         =   0   'False
      Width           =   3015
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   5
      Left            =   3480
      TabIndex        =   21
      Top             =   2640
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   4
      Left            =   3480
      TabIndex        =   20
      Top             =   2280
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   3
      Left            =   3480
      TabIndex        =   19
      Top             =   1920
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   2
      Left            =   3480
      TabIndex        =   18
      Top             =   1560
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   1
      Left            =   3480
      TabIndex        =   17
      Top             =   1200
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CheckBox chkOption 
      BackColor       =   &H00000000&
      Caption         =   "chkOption0"
      ForeColor       =   &H000080FF&
      Height          =   255
      Index           =   0
      Left            =   3480
      TabIndex        =   16
      Top             =   840
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   5
      Left            =   1920
      TabIndex        =   14
      Top             =   2640
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   4
      Left            =   1920
      TabIndex        =   13
      Top             =   2280
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   3
      Left            =   1920
      TabIndex        =   12
      Top             =   1920
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   2
      Left            =   1920
      TabIndex        =   11
      Top             =   1560
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   1
      Left            =   1920
      TabIndex        =   10
      Top             =   1200
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Index           =   0
      Left            =   1920
      TabIndex        =   4
      Top             =   840
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton cmdSelectEvent 
      Caption         =   "Juegos del Hambre"
      Height          =   375
      Index           =   3
      Left            =   3960
      TabIndex        =   3
      Top             =   0
      Width           =   1335
   End
   Begin VB.CommandButton cmdSelectEvent 
      Caption         =   "Death"
      Height          =   375
      Index           =   2
      Left            =   2640
      TabIndex        =   2
      Top             =   0
      Width           =   1335
   End
   Begin VB.CommandButton cmdSelectEvent 
      Caption         =   "Torneo 2vs2"
      Height          =   375
      Index           =   1
      Left            =   1320
      TabIndex        =   1
      Top             =   0
      Width           =   1335
   End
   Begin VB.CommandButton cmdSelectEvent 
      Caption         =   "Torneo 1vs1"
      Height          =   375
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1335
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "lbInfo5"
      ForeColor       =   &H0000FF00&
      Height          =   375
      Index           =   5
      Left            =   120
      TabIndex        =   15
      Top             =   2640
      Visible         =   0   'False
      Width           =   2415
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "lblInfo4"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   9
      Top             =   2280
      Visible         =   0   'False
      Width           =   3015
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "lblInfo3"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   8
      Top             =   1920
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "lblInfo2"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   7
      Top             =   1560
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "lblInfo1"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   6
      Top             =   1200
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Label lblInfo 
      BackStyle       =   0  'Transparent
      Caption         =   "LblInfo0"
      ForeColor       =   &H0000FF00&
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   5
      Top             =   840
      Visible         =   0   'False
      Width           =   1935
   End
End
Attribute VB_Name = "frmEvents"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Sub chkOption_Click(index As Integer)

    Select Case index
    Case 0 To 3
        txtData(index).Enabled = Not txtData(index).Enabled
        txtData(index).Text = chkOption(index).Caption
    End Select
End Sub

Private Sub cmdCancelEvent_Click()
    Call writeCancelarTorneo
End Sub

Private Sub cmdCreateEvent_Click()

    If Val(txtData(0).Text) < 0 Or Val(txtData(0).Text) > 32 Then
        MsgBox "Cupos inválidos (Mínimo 1 - máximo 32)"
        Exit Sub
    ElseIf Val(txtData(1).Text) < 0 Then
        MsgBox "Inscripción invalida"
        Exit Sub
    ElseIf Val(txtData(2).Text) < 0 Then
        MsgBox "Oro invalido"
        Exit Sub
    ElseIf Val(txtData(3).Text) < 0 Then
        MsgBox "Canjes invalidos"
        Exit Sub
    End If

    Select Case selEvent
    Case 1
        If Not (Val(txtData(0).Text) > 0 And Val(txtData(0).Text) < 6) Then
            MsgBox "Elegi cupos del 1 al 5"
            Exit Sub
        End If
    Case 2
        Dim inputValue As Integer
        inputValue = Val(txtData(0).Text)

        Select Case inputValue
        Case 4, 8, 16, 32, 64
        Case Else
            MsgBox "Las opciones son: 4, 8, 16, 32, 64"
            Exit Sub
        End Select
    Case 3

    Case 4

    End Select

    Call Protocol_Writes.WriteCrearTorneo(Val(txtData(0).Text), Val(txtData(1).Text), Val(chkOption(4).Value), Val(txtData(3).Text), Val(txtData(2).Text), Val(txtData(4).Text), Val(txtData(5).Text), Val(cp(0).Value), Val(cp(1).Value), Val(cp(2).Value), Val(cp(3).Value), Val(cp(4).Value), Val(cp(5).Value), Val(cp(6).Value), Val(cp(7).Value), Val(cp(8).Value), Val(cp(9).Value), Val(cp(10).Value), Val(cp(11).Value))

    Unload Me

End Sub

Private Sub cmdSelectEvent_Click(index As Integer)

    Call setDefault

    selEvent = index + 1

    Select Case index

    Case 0
        Me.Caption = Me.Caption & " - Torneo 1vs1"
        chkOption(4).visible = True
        chkOption(4).Caption = "Caen items"

    Case 1
        Me.Caption = Me.Caption & " - Torneo 2vs2"
        chkOption(4).visible = True
        chkOption(4).Caption = "Caen items"

        lblInfo(0).Caption = "Cupos (NUMERO PAR):"

    Case 2
        Me.Caption = Me.Caption & " - Deathmatch"
        chkOption(4).visible = True
        chkOption(4).Caption = "Caen items"

    Case 3
        Me.Caption = Me.Caption & " - Juegos del hambre"

    End Select

End Sub

Private Sub setDefault()

    Dim i As Long
    cmdCreateEvent.visible = True
    cmdCancelEvent.visible = True
    frameClases.visible = True

    Me.Caption = "Eventos automáticos"


    lblInfo(0).Caption = "Cupos:"
    lblInfo(1).Caption = "Costo de inscripción:"
    lblInfo(2).Caption = "Premio - ORO:"
    lblInfo(3).Caption = "Premio - CANJES:"

    lblInfo(0).visible = True
    lblInfo(1).visible = True
    lblInfo(2).visible = True
    lblInfo(3).visible = True


    chkOption(0).visible = False


    chkOption(1).visible = True
    chkOption(1).Caption = "0"
    chkOption(1).Value = vbChecked
    txtData(1).Text = "0"

    chkOption(2).visible = True
    chkOption(2).Caption = "10000"
    chkOption(2).Value = vbChecked
    chkOption(3).visible = True
    chkOption(3).Caption = "5"
    chkOption(3).Value = vbChecked

    For i = 0 To 3
        txtData(i).visible = True
        txtData(i).Text = ""
    Next i

    txtData(0).Text = 1
    txtData(1).Text = 0
    txtData(1).Enabled = False
    txtData(2).Text = 10000
    txtData(2).Enabled = False
    txtData(3).Text = 5
    txtData(3).Enabled = False

    For i = 4 To txtData.UBound
        txtData(i).visible = False
        txtData(i).Enabled = True
        txtData(i).Text = ""
        lblInfo(i).visible = False
        lblInfo(i).Caption = ""
        chkOption(i).Value = vbUnchecked
        chkOption(i).visible = False
    Next i

    lblInfo(4).visible = True
    lblInfo(5).visible = True
    lblInfo(4).Caption = "Nivel Minimo"
    lblInfo(5).Caption = "Nivel Máximo"
    txtData(4).visible = True
    txtData(5).visible = True
    txtData(4).Text = "1"
    txtData(5).Text = "47"


End Sub

Private Sub cp_Click(index As Integer)
    If cp(index).Value = 0 Then
        cp(index).ForeColor = &HFF00&    'verde
    Else
        cp(index).ForeColor = vbRed
    End If
End Sub

