VERSION 5.00
Begin VB.Form frmBuscar 
   BackColor       =   &H80000012&
   BorderStyle     =   0  'None
   ClientHeight    =   4770
   ClientLeft      =   15
   ClientTop       =   60
   ClientWidth     =   4605
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4770
   ScaleWidth      =   4605
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox PicItem 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   480
      Left            =   150
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   10
      Top             =   540
      Width           =   480
   End
   Begin VB.TextBox txtCantidad 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   285
      Left            =   1680
      TabIndex        =   5
      Text            =   "1"
      Top             =   960
      Width           =   735
   End
   Begin VB.ListBox ListNombres 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H80000005&
      Height          =   3150
      ItemData        =   "frmBuscar.frx":0000
      Left            =   240
      List            =   "frmBuscar.frx":0002
      TabIndex        =   1
      Top             =   1440
      Width           =   4155
   End
   Begin VB.TextBox Buscar 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000005&
      Height          =   285
      Left            =   1680
      TabIndex        =   0
      Top             =   600
      Width           =   2415
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "  X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   4320
      TabIndex        =   9
      Top             =   0
      Width           =   375
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   840
      TabIndex        =   8
      Top             =   600
      Width           =   660
   End
   Begin VB.Label BuscarNpc 
      BackStyle       =   0  'Transparent
      Caption         =   "Buscar Npcs"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   2760
      TabIndex        =   7
      Top             =   150
      Width           =   1455
   End
   Begin VB.Label BuscarObj 
      BackStyle       =   0  'Transparent
      Caption         =   "Buscar Objetos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   375
      Left            =   480
      TabIndex        =   6
      Top             =   150
      Width           =   1695
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Cantidad:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   720
      TabIndex        =   4
      Top             =   1000
      Width           =   900
   End
   Begin VB.Label CrearObjetos 
      Alignment       =   2  'Center
      Caption         =   "Objetos"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   7920
      TabIndex        =   3
      Top             =   -240
      Width           =   735
   End
   Begin VB.Label CrearNPCs 
      Alignment       =   2  'Center
      Caption         =   "NPCS"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   8760
      TabIndex        =   2
      Top             =   -240
      Width           =   735
   End
   Begin VB.Menu mnuCrearO 
      Caption         =   "Crear Objeto"
      Visible         =   0   'False
      Begin VB.Menu mnuCrearObj 
         Caption         =   "¿Crear Objeto?"
      End
   End
   Begin VB.Menu mnuCrearN 
      Caption         =   "Crear NPC"
      Visible         =   0   'False
      Begin VB.Menu mnuCrearNPC 
         Caption         =   "¿Crear NPC?"
      End
   End
End
Attribute VB_Name = "frmBuscar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Private BuscarType As Boolean

Private NumObj As String
Private NumNpc As String

Private Sub txtCantidad_Change()

    On Error GoTo ErrHandler

    If Val(txtCantidad.Text) < 0 Then
        txtCantidad.Text = "1"
    End If

    If Val(txtCantidad.Text) > MAX_INVENTORY_OBJS Then
        txtCantidad.Text = "10000"
    End If

    Exit Sub

ErrHandler:
    'If we got here the user may have pasted (Shift + Insert) a REALLY large number, causing an overflow, so we set amount back to 1
    txtCantidad.Text = "1"
End Sub

Private Sub txtCantidad_KeyPress(KeyAscii As Integer)

    If (KeyAscii <> 8) Then
        If (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
    End If

End Sub

Private Sub BuscarObj_Click()

    If Len(Buscar.Text) > 1 Then
        Call BuscarWea(Buscar.Text, True)
        NumNpc = vbNullString
        BuscarType = True
    End If

End Sub

Private Sub BuscarNpc_Click()

    If Len(Buscar.Text) > 1 Then
        Call BuscarWea(Buscar.Text, False)
        NumObj = vbNullString
        BuscarType = False
    End If

End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
End Sub

Private Sub Label_Click()
    Unload Me
End Sub

Private Sub ListNombres_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

    If Button = vbRightButton Then

        If ListNombres.ListIndex <> -1 Then

            Dim Name As String
            Name = ListNombres.List(ListNombres.ListIndex)

            If LenB(Name) < 1 Then Exit Sub

            If BuscarType Then
                If Name <> "No se ha encontrado ningun objeto!" Then
                    NumObj = (mid$(Name, InStr(Name, "[") + 1))
                    NumObj = (Left$(NumObj, Len(NumObj) - 1))
                    If LenB(NumObj) > 0 Then
                        Call PopupMenu(mnuCrearO)
                        NumNpc = vbNullString
                    End If
                End If
            Else
                If Name <> "No se ha encontrado ningun npc!" Then
                    NumNpc = (mid$(Name, InStr(Name, "[") + 1))
                    NumNpc = (Left$(NumNpc, Len(NumNpc) - 1))
                    If LenB(NumNpc) > 0 Then
                        Call PopupMenu(mnuCrearN)
                        NumObj = vbNullString
                    End If
                End If
            End If


        End If

    Else

        Name = ListNombres.List(ListNombres.ListIndex)

        If LenB(Name) < 1 Then Exit Sub

        If Name <> "No se ha encontrado ningun objeto!" Then
            NumObj = (mid$(Name, InStr(Name, "[") + 1))
            NumObj = (Left$(NumObj, Len(NumObj) - 1))
        End If

    End If

End Sub

Private Sub mnuCrearObj_Click()
    If ListNombres.visible Then
        Call WriteCreateItem(Val(NumObj), txtCantidad.Text)
    End If
End Sub

Private Sub mnuCrearNPC_Click()

    Dim LoopC As Long

    If ListNombres.visible Then
        For LoopC = 1 To txtCantidad.Text
            Call WriteCreateNPC(Val(NumNpc))
        Next LoopC
    End If

End Sub

Private Sub BuscarWea(ByVal NombreStr As String, Optional ByVal ObjNpc As Boolean = False)

    Dim LoopC As Long
    Dim Found As Byte

    ListNombres.Clear

    If ObjNpc Then

        NombreStr = Tilde(NombreStr)

        For LoopC = 1 To NumObjs
            If InStr(1, Tilde(DataObj(LoopC).nombre), NombreStr) Then
                Call ListNombres.AddItem(DataObj(LoopC).nombre & " [" & (LoopC) & "]")
                Found = 1
            End If
        Next LoopC

        If Found < 1 Then
            Call ListNombres.AddItem("No se ha encontrado ningun objeto!")
            Exit Sub
        End If

    Else

        NombreStr = Tilde(NombreStr)

        For LoopC = 1 To NumNpcs
            If InStr(1, Tilde(DataNpcs(LoopC).nombre), NombreStr) Then
                Call ListNombres.AddItem(DataNpcs(LoopC).nombre & " [" & (LoopC) & "]")
                Found = 1
            End If
        Next LoopC

        If Found < 1 Then
            Call ListNombres.AddItem("No se ha encontrado ningun npc!")
            Exit Sub
        End If

    End If

End Sub
