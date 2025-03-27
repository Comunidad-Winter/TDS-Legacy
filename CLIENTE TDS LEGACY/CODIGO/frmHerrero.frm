VERSION 5.00
Begin VB.Form frmHerrero 
   Appearance      =   0  'Flat
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Herrero"
   ClientHeight    =   4605
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4605
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   307
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   307
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtCantItems 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   240
      TabIndex        =   1
      Text            =   "1"
      Top             =   3675
      Width           =   4095
   End
   Begin VB.ListBox lstArmas 
      Appearance      =   0  'Flat
      Height          =   1980
      Left            =   240
      TabIndex        =   0
      Top             =   1320
      Width           =   4080
   End
   Begin VB.ListBox lstArmaduras 
      Appearance      =   0  'Flat
      Height          =   1980
      Left            =   240
      TabIndex        =   2
      Top             =   1320
      Visible         =   0   'False
      Width           =   4080
   End
   Begin VB.Label lblAlert 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "No eres profesional de la herrería, tu conocimiento está limitado para construir objetos."
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
      TabIndex        =   3
      Top             =   3285
      Width           =   4575
   End
   Begin VB.Image imgConstruir 
      Height          =   495
      Left            =   2760
      Top             =   3960
      Width           =   1455
   End
   Begin VB.Image imgCerrar 
      Height          =   480
      Left            =   360
      Top             =   3960
      Width           =   1215
   End
   Begin VB.Image picPestania 
      Height          =   495
      Index           =   1
      Left            =   2640
      MousePointer    =   99  'Custom
      Top             =   600
      Width           =   1500
   End
   Begin VB.Image picPestania 
      Height          =   495
      Index           =   0
      Left            =   360
      MousePointer    =   99  'Custom
      Top             =   600
      Width           =   1275
   End
End
Attribute VB_Name = "frmHerrero"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Armas As Boolean
Private firstTime As Boolean
Private clsFormulario As clsFrmMovMan

Private Sub Form_Load()
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    Armas = True
    firstTime = True

    Call forms_load_pic(Me, "970.bmp", False)

    If UserClase = eClass.Blacksmith Then
        lblAlert.visible = False
    Else
        lblAlert.visible = True
        lblAlert.ForeColor = vbYellow
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

    Call Protocol_Writes.WriteCraftBlacksmith(IIf(Armas, ArmasHerrero(lstArmas.ListIndex + 1).ObjIndex, ArmadurasHerrero(lstArmaduras.ListIndex + 1).ObjIndex))

    If Val(txtCantItems.Text) - 1 > 1 Then
        frmMain.macrotrabajo.Enabled = True
        MacroBltIndex = IIf(Armas, ArmasHerrero(lstArmas.ListIndex + 1).ObjIndex, ArmadurasHerrero(lstArmaduras.ListIndex + 1).ObjIndex)
        MacroCant = Val(txtCantItems.Text) - 1
    End If

    Unload Me

End Sub

Private Sub picPestania_Click(index As Integer)
    Select Case index

    Case 1        'armadura?
        Armas = False
        lstArmaduras.visible = True
        If lstArmaduras.ListCount > 0 Then _
           lstArmaduras.Selected(0) = True
        lstArmas.visible = False
        lstArmaduras.SetFocus
    Case 0
        Armas = True
        lstArmas.visible = True
        If lstArmas.ListCount > 0 Then _
           lstArmas.Selected(0) = True
        lstArmaduras.visible = False
        lstArmas.SetFocus
    End Select

    Call WriteInitCrafting(Val(txtCantItems.Text))

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

