VERSION 5.00
Begin VB.Form frmYesOrNo 
   BackColor       =   &H000000FF&
   BorderStyle     =   0  'None
   Caption         =   "Mensaje"
   ClientHeight    =   2190
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4455
   ClipControls    =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmYesOrNo.frx":0000
   ScaleHeight     =   146
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   297
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Image imgNo 
      Height          =   375
      Left            =   2640
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Image imgYes 
      Height          =   375
      Left            =   480
      Top             =   1320
      Width           =   1335
   End
   Begin VB.Label msg 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Estás seguro de realizar ésta accion?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   675
      Left            =   -2835
      TabIndex        =   0
      Top             =   600
      Width           =   9960
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "frmYesOrNo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private clsFormulario As clsFrmMovMan

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyReturn Then Unload Me
End Sub

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    MakeFormTransparent Me, vbRed

End Sub

Private Sub imgNo_Click()
    Call modEngine_Audio.PlayInterface(SND_CLICK)
    
    Select Case AccionYesOrNo
        Case 4
            Call WriteCVC(mCVC_Accion.cvc_RechazarSolicitud, CVC_GuildRequest)
    End Select
    
    AccionYesOrNo = 0

    Unload Me
End Sub

Private Sub imgYes_Click()
    Call modEngine_Audio.PlayInterface(SND_CLICK)

    Select Case AccionYesOrNo

    Case 1
        Call WriteResetChar
    Case 2
        If UserEstado = 1 Then
            With FontTypes(FontTypeNames.FONTTYPE_INFO)
                Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
            End With
        Else
            If (Inventario.SelectedItem > 0 And Inventario.SelectedItem < MAX_INVENTORY_SLOTS + 1) Then
                If Inventario.amount(Inventario.SelectedItem) = 1 Then
                    Call WriteDrop(Inventario.SelectedItem, 1)
                Else
                    If Inventario.amount(Inventario.SelectedItem) > 1 Then
                        frmCantidad.IsDrop = False
                        If Not Comerciando Then frmCantidad.Show , frmMain
                    End If
                End If
            End If
        End If
    Case 3
        Call WriteDragToPos(DragX, DragY, Inventario.SelectedItem, CANTDRAG)
    Case 4
        Call WriteCVC(mCVC_Accion.cvc_AceptarSolicitud, CVC_GuildRequest)
    End Select

    AccionYesOrNo = 0

    Unload Me
End Sub

