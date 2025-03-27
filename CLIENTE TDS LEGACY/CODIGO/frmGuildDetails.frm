VERSION 5.00
Begin VB.Form frmGuildDetails 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Detalles del Clan"
   ClientHeight    =   7050
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6945
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   470
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   463
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtDesc 
      Appearance      =   0  'Flat
      Height          =   1245
      Left            =   360
      MaxLength       =   250
      MultiLine       =   -1  'True
      TabIndex        =   9
      Top             =   790
      Width           =   6135
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   600
      MaxLength       =   50
      TabIndex        =   8
      Top             =   6000
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   600
      MaxLength       =   50
      TabIndex        =   7
      Top             =   5655
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   600
      MaxLength       =   50
      TabIndex        =   6
      Top             =   5280
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   600
      MaxLength       =   50
      TabIndex        =   5
      Top             =   4920
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   600
      MaxLength       =   50
      TabIndex        =   4
      Top             =   4560
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   600
      MaxLength       =   50
      TabIndex        =   3
      Top             =   4200
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   600
      MaxLength       =   50
      TabIndex        =   2
      Top             =   3840
      Width           =   5655
   End
   Begin VB.TextBox txtCodex1 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   600
      MaxLength       =   50
      TabIndex        =   1
      Top             =   3480
      Width           =   5655
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   $"frmGuildDetails.frx":0000
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   855
      Left            =   360
      TabIndex        =   0
      Top             =   2640
      Width           =   6255
   End
   Begin VB.Image imgConfirmar 
      Height          =   480
      Left            =   5640
      Tag             =   "1"
      Top             =   6480
      Width           =   1215
   End
   Begin VB.Image imgSalir 
      Height          =   600
      Left            =   0
      Tag             =   "1"
      Top             =   6480
      Width           =   1455
   End
End
Attribute VB_Name = "frmGuildDetails"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const MAX_DESC_LENGTH As Integer = 520
Private Const MAX_CODEX_LENGTH As Integer = 100

Private Sub Form_Load()

    Call forms_load_pic(Me, "969.bmp", False)

End Sub

Private Sub imgConfirmar_Click()
    Dim fdesc As String
    Dim Codex() As String
    Dim k As Byte
    Dim Cont As Byte

    fdesc = Replace(txtDesc, vbCrLf, "º", , , vbBinaryCompare)

    Cont = 0
    For k = 0 To txtCodex1.UBound
        If LenB(txtCodex1(k).Text) <> 0 Then Cont = Cont + 1
    Next k

    If Cont < 4 Then
        MsgBox "Debes definir al menos cuatro mandamientos."
        Exit Sub
    End If

    ReDim Codex(txtCodex1.UBound) As String
    For k = 0 To txtCodex1.UBound
        Codex(k) = txtCodex1(k)
    Next k

    If CreandoClan Then
        Call WriteCreateNewGuild(fdesc, ClanName, Site, Codex)
    Else
        Call WriteClanCodexUpdate(fdesc, Codex)
    End If

    CreandoClan = False
    Unload Me
End Sub

Private Sub imgSalir_Click()
    Unload Me
End Sub

Private Sub txtCodex1_Change(index As Integer)
    If Len(txtCodex1.Item(index).Text) > MAX_CODEX_LENGTH Then _
       txtCodex1.Item(index).Text = Left$(txtCodex1.Item(index).Text, MAX_CODEX_LENGTH)
End Sub

Private Sub txtDesc_Change()
    If Len(txtDesc.Text) > MAX_DESC_LENGTH Then _
       txtDesc.Text = Left$(txtDesc.Text, MAX_DESC_LENGTH)
End Sub
