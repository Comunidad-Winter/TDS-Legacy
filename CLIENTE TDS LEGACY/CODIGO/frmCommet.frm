VERSION 5.00
Begin VB.Form frmCommet 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Oferta de paz"
   ClientHeight    =   3330
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4770
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
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   318
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox Text1 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1935
      Left            =   240
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   600
      Width           =   4320
   End
   Begin VB.Image imgEnviar 
      Height          =   480
      Left            =   2880
      Top             =   2640
      Width           =   1275
   End
   Begin VB.Image imgCerrar 
      Height          =   465
      Left            =   600
      Top             =   2640
      Width           =   1200
   End
End
Attribute VB_Name = "frmCommet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const MAX_PROPOSAL_LENGTH As Integer = 520

Public ClanSeleccionado As Integer
Public ClanSeleccionado_Nombre As String
Public nombre As String

Public T As tipo

Public Enum tipo
    ALIANZA = 1
    PAZ = 2
    RECHAZOPJ = 3
End Enum

Private Sub Form_Load()

    Select Case T
    Case ALIANZA
        Call forms_load_pic(Me, "997.bmp", False)
        Me.Caption = "Oferta de alianza"
    Case PAZ
        Call forms_load_pic(Me, "998.bmp", False)
        Me.Caption = "Oferta de paz"
    Case RECHAZOPJ
        Call forms_load_pic(Me, "964.bmp", False)
        Me.Caption = "Rechazar peticion"
    End Select

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgEnviar_Click()

    If Text1 = "" Then
        If T = PAZ Or T = ALIANZA Then
            MsgBox "Debes redactar un mensaje solicitando la paz o alianza al líder de " & ClanSeleccionado_Nombre
        Else
            MsgBox "Debes indicar el motivo por el cual rechazas la membresía de " & ClanSeleccionado_Nombre
        End If
        Exit Sub
    End If

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    If T = PAZ Then
        Call WriteGuildOfferPeace(ClanSeleccionado, Replace(Text1, vbCrLf, "º"))

    ElseIf T = ALIANZA Then
        Call WriteGuildOfferAlliance(ClanSeleccionado, Replace(Text1, vbCrLf, "º"))

    ElseIf T = RECHAZOPJ Then
        'Sacamos el char de la lista de aspirantes
        Dim i As Long

        For i = 0 To frmGuildLeader.solicitudes.ListCount - 1
            If UCase$(frmGuildLeader.solicitudes.List(i)) = nombre Then
                frmGuildLeader.solicitudes.RemoveItem i
                Exit For
            End If
        Next i
        Call WriteGuildRejectNewMember(nombre, Replace(Replace(Text1.Text, ",", " "), vbCrLf, " "))

        Me.Hide
        Unload frmCharInfo
    End If

    Unload Me

End Sub


Private Sub Text1_Change()
    If Len(Text1.Text) > MAX_PROPOSAL_LENGTH Then _
       Text1.Text = Left$(Text1.Text, MAX_PROPOSAL_LENGTH)
End Sub

