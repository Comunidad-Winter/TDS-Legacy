VERSION 5.00
Begin VB.Form frmPeaceProp 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Ofertas de paz"
   ClientHeight    =   3330
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4785
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
   ScaleHeight     =   222
   ScaleMode       =   0  'User
   ScaleWidth      =   326.55
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox lista 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1980
      Left            =   240
      TabIndex        =   0
      Top             =   600
      Width           =   4335
   End
   Begin VB.Image imgRechazar 
      Height          =   480
      Left            =   3600
      Top             =   2760
      Width           =   1080
   End
   Begin VB.Image imgAceptar 
      Height          =   480
      Left            =   2400
      Top             =   2760
      Width           =   1080
   End
   Begin VB.Image imgDetalle 
      Height          =   480
      Left            =   1200
      Top             =   2760
      Width           =   1080
   End
   Begin VB.Image imgCerrar 
      Height          =   480
      Left            =   240
      Top             =   2760
      Width           =   840
   End
End
Attribute VB_Name = "frmPeaceProp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public LastPressed As clsGraphicalButton
Private TipoProp As TIPO_PROPUESTA

Public Enum TIPO_PROPUESTA
    ALIANZA = 1
    PAZ = 2
End Enum

Private Sub Form_Load()
    Call LoadBackGround

    'On Error Resume Next
    ' @@ seleccionamos al primero, total siempre hay un clan, sino no abre éste form
    'lista.Selected(0) = True

End Sub

Private Sub LoadBackGround()

    If TipoProp = TIPO_PROPUESTA.ALIANZA Then
        Call forms_load_pic(Me, "982.bmp", False)
    Else
        Call forms_load_pic(Me, "995.bmp", False)
    End If

End Sub

Public Property Let ProposalType(ByVal nValue As TIPO_PROPUESTA)
    TipoProp = nValue
End Property

Private Sub imgAceptar_Click()

    If lista.ListIndex = -1 Then Exit Sub

    If TipoProp = PAZ Then
        Call WriteGuildAcceptPeace(lista.ListIndex + 1)
    Else
        Call WriteGuildAcceptAlliance(lista.ListIndex + 1)
    End If

    Me.Hide
    Unload Me

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgDetalle_Click()
    If lista.ListIndex = -1 Then Exit Sub
    If TipoProp = PAZ Then
        Call WriteGuildPeaceDetails(lista.ListIndex + 1)
    Else
        Call WriteGuildAllianceDetails(lista.ListIndex + 1)
    End If
End Sub

Private Sub imgRechazar_Click()

    If lista.ListIndex = -1 Then Exit Sub

    If TipoProp = PAZ Then
        Call WriteGuildRejectPeace(lista.ListIndex + 1)
    Else
        Call WriteGuildRejectAlliance(lista.ListIndex + 1)
    End If

    Me.Hide
    Unload Me
End Sub

