VERSION 5.00
Begin VB.Form frmCarp 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   ClientHeight    =   4365
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4770
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   291
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   318
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox lstObjetos 
      Appearance      =   0  'Flat
      Height          =   1980
      Left            =   360
      TabIndex        =   1
      Top             =   840
      Width           =   4080
   End
   Begin VB.TextBox txtCantItems 
      Appearance      =   0  'Flat
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Text            =   "1"
      Top             =   3285
      Width           =   4095
   End
   Begin VB.Label lblAlert 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "No eres profesional de la carpintería, tu conocimiento está limitado para construir objetos."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   495
      Left            =   0
      TabIndex        =   2
      Top             =   420
      Width           =   4815
   End
   Begin VB.Image imgCerrar 
      Height          =   480
      Left            =   240
      Top             =   3720
      Width           =   1215
   End
   Begin VB.Image imgConstruir 
      Height          =   495
      Left            =   3120
      Top             =   3720
      Width           =   1455
   End
End
Attribute VB_Name = "frmCarp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private firstTime As Boolean
Private clsFormulario As clsFrmMovMan

Private Sub Form_Load()
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    firstTime = True
    Call forms_load_pic(Me, "999.bmp", False)

    If UserClase = eClass.Carpenter Then
        lblAlert.visible = False
    Else
        lblAlert.visible = True
    End If
End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub imgConstruir_Click()

    If ModoCombate Then
        With FontTypes(FontTypeNames.FONTTYPE_FIGHT)
            Call ShowConsoleMsg("No puedes trabajar en modo combate", .red, .green, .blue, .bold, .italic)
        End With
        Exit Sub
    End If

    If firstTime Then
        Call WriteInitCrafting(Val(txtCantItems.Text))
        firstTime = False
    End If

    Call Protocol_Writes.WriteCraftCarpenter(ObjCarpintero(lstObjetos.ListIndex + 1).ObjIndex)

    If Val(txtCantItems.Text) - 1 > 1 Then
        frmMain.macrotrabajo.Enabled = True
        MacroBltIndex = ObjCarpintero(lstObjetos.ListIndex + 1).ObjIndex
        MacroCant = Val(txtCantItems.Text) - 1
    End If

    Unload Me

End Sub

Private Sub txtCantItems_Change()
    On Error GoTo errHandler
    If Val(txtCantItems.Text) < 0 Then
        txtCantItems.Text = 1
    End If

    If Val(txtCantItems.Text) > 10000 Then
        txtCantItems.Text = 10000
    End If

    Call WriteInitCrafting(Val(txtCantItems.Text))
    Exit Sub

errHandler:
    txtCantItems.Text = 10000
End Sub

Private Sub txtCantItems_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) Then
        If (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
    End If
End Sub



