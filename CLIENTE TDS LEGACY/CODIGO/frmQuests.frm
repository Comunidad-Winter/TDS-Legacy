VERSION 5.00
Begin VB.Form frmQuests 
   BackColor       =   &H00404040&
   BorderStyle     =   0  'None
   Caption         =   "Misiones"
   ClientHeight    =   7635
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   10050
   Icon            =   "frmQuests.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   509
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   670
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtInfo 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   5895
      Left            =   3480
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   720
      Width           =   6135
   End
   Begin VB.ListBox lstQuests 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H00FFFFFF&
      Height          =   5880
      Left            =   360
      TabIndex        =   0
      Top             =   720
      Width           =   2955
   End
   Begin VB.Label cAbandonar 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Abandonar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000B&
      Height          =   495
      Left            =   480
      TabIndex        =   4
      Top             =   6960
      Width           =   1815
   End
   Begin VB.Label cVolver 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Volver"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000B&
      Height          =   495
      Left            =   7680
      TabIndex        =   3
      Top             =   6960
      Width           =   1815
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Quests"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   360
      TabIndex        =   2
      Top             =   360
      Width           =   810
   End
End
Attribute VB_Name = "frmQuests"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Private Sub cAbandonar_Click()

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    If lstQuests.ListCount = 0 Then
        MsgBox "¡No tienes ninguna misión!", vbOKOnly + vbExclamation
        Exit Sub
    End If

    If lstQuests.ListIndex < 0 Then
        MsgBox "¡Primero debes seleccionar una misión!", vbOKOnly + vbExclamation
        Exit Sub
    End If

    If MsgBox("¿Estás seguro que deseas abandonar la misión?", vbYesNo + vbExclamation) = vbYes Then
        Call WriteQuestAbandon(lstQuests.ListIndex + 1)
    End If

End Sub

Private Sub cVolver_Click()

    Call modEngine_Audio.PlayInterface(SND_CLICK)
    Unload Me

End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    'Me.Picture = LoadPicture(DirGUI & "frmCargando.jpg")    ' TODO: Falta una ventana para esto

End Sub

Private Sub lstQuests_Click()

    If lstQuests.ListIndex < 0 Then Exit Sub

    Call WriteQuestDetailsRequest(lstQuests.ListIndex + 1)

End Sub
