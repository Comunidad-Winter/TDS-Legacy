VERSION 5.00
Begin VB.Form frmCantidadEx 
   BackColor       =   &H00000000&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1500
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   3240
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1500
   ScaleWidth      =   3240
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      MaxLength       =   5
      TabIndex        =   0
      Top             =   480
      Width           =   2625
   End
   Begin VB.CommandButton Command1 
      Caption         =   "A&ceptar"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   360
      MouseIcon       =   "frmCantidadEx.frx":0000
      MousePointer    =   99  'Custom
      TabIndex        =   1
      Top             =   990
      Width           =   1680
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Todo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   2055
      MouseIcon       =   "frmCantidadEx.frx":0152
      MousePointer    =   99  'Custom
      TabIndex        =   2
      Top             =   990
      Width           =   930
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Escriba la cantidad:"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   375
      Left            =   615
      TabIndex        =   3
      Top             =   120
      Width           =   2415
   End
End
Attribute VB_Name = "frmCantidadEx"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()

    If IsNumeric(Text1.Text) Then
        CANTDRAG = Val(Text1.Text)
        Text1.Text = ""
        Unload Me
    Else
        CANTDRAG = 0
        Unload Me
    End If
End Sub

Private Sub Command2_Click()
    CANTDRAG = 10000
    Unload Me
End Sub

Private Sub Text1_Change()
    On Error GoTo ErrHandler
    If Val(Text1.Text) < 0 Then
        Text1.Text = "1"
    End If

    If Val(Text1.Text) > MAX_INVENTORY_OBJS Then
        Text1.Text = "10000"
    End If

    Exit Sub

ErrHandler:
    'If we got here the user may have pasted (Shift + Insert) a REALLY large number, causing an overflow, so we set amount back to 1
    Text1.Text = "1"
End Sub


Private Sub Text1_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) Then
        If (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
    End If
End Sub
