VERSION 5.00
Begin VB.Form frmPrepareCVC 
   BackColor       =   &H00404040&
   BorderStyle     =   0  'None
   Caption         =   "Clan vs Clan"
   ClientHeight    =   4920
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9300
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4920
   ScaleWidth      =   9300
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdConfirmarSel 
      Caption         =   "CONFIRMAR SELECCION"
      Height          =   495
      Left            =   2160
      TabIndex        =   11
      Top             =   4320
      Width           =   1575
   End
   Begin VB.CommandButton cmdStart 
      Caption         =   "Jugar!"
      Enabled         =   0   'False
      Height          =   495
      Left            =   3840
      TabIndex        =   10
      Top             =   4320
      Width           =   1815
   End
   Begin VB.CommandButton cmdActualizarSel 
      Caption         =   "Actualizar seleccion"
      Height          =   495
      Left            =   240
      TabIndex        =   9
      Top             =   4320
      Width           =   1695
   End
   Begin VB.CommandButton cmdCancelar 
      Caption         =   "Cancelar reto"
      Height          =   495
      Left            =   7440
      TabIndex        =   7
      Top             =   4320
      Width           =   1815
   End
   Begin VB.ListBox lstParticipantesE 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      Enabled         =   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   2955
      Left            =   5040
      Style           =   1  'Checkbox
      TabIndex        =   6
      Top             =   960
      Width           =   4095
   End
   Begin VB.ListBox lstParticipantes 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H000000FF&
      Height          =   2955
      Left            =   120
      Style           =   1  'Checkbox
      TabIndex        =   0
      Top             =   960
      Width           =   4095
   End
   Begin VB.Label lblInfo 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "0/0 jugadores seleccionados"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   240
      Index           =   1
      Left            =   6105
      TabIndex        =   12
      Top             =   3960
      Width           =   3030
   End
   Begin VB.Label lblInfo 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "0/0 jugadores seleccionados"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   240
      Index           =   0
      Left            =   1185
      TabIndex        =   8
      Top             =   3960
      Width           =   3030
   End
   Begin VB.Label lblHonorEnemigo 
      AutoSize        =   -1  'True
      BackColor       =   &H00404040&
      Caption         =   "Honor:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   5520
      TabIndex        =   5
      Top             =   240
      Width           =   705
   End
   Begin VB.Label lblClanEnemigo 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00404040&
      Caption         =   "-Nombre de clan test-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   300
      Left            =   5835
      TabIndex        =   4
      Top             =   0
      Width           =   2625
   End
   Begin VB.Label lblHonor 
      AutoSize        =   -1  'True
      BackColor       =   &H00404040&
      Caption         =   "Honor:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   840
      TabIndex        =   3
      Top             =   240
      Width           =   705
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H00404040&
      Caption         =   "VS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   15
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   375
      Left            =   4365
      TabIndex        =   2
      Top             =   2280
      Width           =   465
   End
   Begin VB.Label lblClan 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00404040&
      Caption         =   "-Nombre de clan test-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   300
      Left            =   795
      TabIndex        =   1
      Top             =   0
      Width           =   2625
   End
End
Attribute VB_Name = "frmPrepareCVC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan
Public LastPressed As clsGraphicalButton

Private Sub cmdActualizarSel_Click()
    Dim i As Long
    Dim totSel As Byte
    Dim tmpStr As String
    For i = 0 To lstParticipantes.ListCount
        If Len(lstParticipantes.List(i)) Then
            If lstParticipantes.Selected(i) Then
                tmpStr = lstParticipantes.List(i) & Chr(44)
                totSel = totSel + 1
            End If
        End If
        'If totSel > CVC_maxSel Then Call MsgBox("Debes seleccionar como máximo " & CVC_maxSel & " jugadores!"): Exit Sub
    Next i
    
    If Len(tmpStr) Then
        tmpStr = Left$(tmpStr, Len(tmpStr) - 1)
    End If
    
    Call WriteCVC(mCVC_Accion.cvc_CambiarSeleccion, tmpStr)
End Sub

Private Sub cmdCancelar_Click()
    Call WriteCVC(mCVC_Accion.cvc_Cancelar)  'Cancelar!
    Unload Me
End Sub

Private Sub cmdConfirmarSel_Click()
    Call WriteCVC(mCVC_Accion.cvc_ConfirmarSeleccion)
End Sub

Private Sub cmdStart_Click()
    Call WriteCVC(mCVC_Accion.cvc_EstoyListo)   'Retar!
End Sub

Private Sub Form_Load()
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    'Call forms_load_pic(Me, "972.bmp", False)
End Sub

Public Sub CVC_UpdateSeleccion(ByVal Jugadores As String, ByVal Seleccionados As String, ByVal Cual As Byte, ByVal maxUsers As Byte)

    Dim lstActual As Object, lblActual As Object
    If Cual = 1 Then
        lstParticipantes.Clear
        Set lstActual = lstParticipantes
        Set lblActual = lblInfo(0)
    Else
        lstParticipantesE.Clear
        Set lstActual = lstParticipantesE
        Set lblActual = lblInfo(1)
        cmdActualizarSel.Enabled = True ' @@ Me permite cambiar a mi también jeje
        lblInfo(0).ForeColor = vbGreen
    End If

    Dim Data() As String
    Dim SelArray() As String
    Data = Split(Jugadores, Chr(44))
    SelArray = Split(Seleccionados, Chr(44))

    Dim i As Long
    Dim Seleccionado As Boolean, totSel As Byte
    Dim j As Long

    For i = LBound(SelArray) To UBound(SelArray)
        For j = LBound(Data) To UBound(Data)
            If Replace$(Data(j), Chr(42), "") = SelArray(i) Then
                lstActual.AddItem SelArray(i)
                lstActual.Selected(lstActual.ListCount - 1) = True
                totSel = totSel + 1
                Exit For
            End If
        Next j
    Next i

    lblActual.Caption = totSel & "/" & maxUsers & " jugadores seleccionados"

    For i = LBound(Data) To UBound(Data)
        Seleccionado = False
        For j = LBound(SelArray) To UBound(SelArray)
            If Replace$(Data(i), Chr(42), "") = SelArray(j) Then
                Seleccionado = True
                Exit For
            End If
        Next j

        If Not Seleccionado Then
            lstActual.AddItem Replace$(Data(i), Chr(42), "")
            lstActual.Selected(lstActual.ListCount - 1) = False
        End If
    Next i
    
    cmdConfirmarSel.Enabled = True
    cmdStart.Enabled = False
    
End Sub

Private Sub lstParticipantes_Click()

    CVC_totSel = 0
    Dim i As Long

    For i = 0 To lstParticipantes.ListCount - 1
        If lstParticipantes.Selected(i) = True Then
            CVC_totSel = CVC_totSel + 1
        End If
    Next i

    ' Actualiza lblInfo(1).Caption con el número de seleccionados y el máximo permitido
    lblInfo(0).Caption = CVC_totSel & "/" & CVC_maxSel & " jugadores seleccionados"
End Sub

Public Sub CVC_HandleAceptarSolicitud(ParamArray Args() As Variant)

'Args0 Int16_Honor ' en este caso es maxplayers
'Args1 Int16_Players_Team1
'Args2 Int16_Players_Team2
'Args3 Int_Honor_Team_1
'Args4 String8_Name_Team_1
'Args5 String8_Miembros_Team_1
'Args6 String8_Seleccionados_Team_1
'Args7 Int_Honor_Team_2
'Args8 String8_Name_Team_2
'Args9 String8_Miembros_Team_2
'Args10 String8_Seleccionados_Team_2
    
    CVC_maxSel = Args(0)
    
' @@ Propio
    lblHonor.Caption = format$(Args(3), "###,###,###")
    lblClan.Caption = Args(4)
    Call CVC_UpdateSeleccion(Args(5), Args(6), 1, Args(0))

' @@ Enemigo
    lblHonorEnemigo.Caption = format$(Args(7), "###,###,###")
    lblClanEnemigo.Caption = Args(8)
    Call CVC_UpdateSeleccion(Args(9), Args(10), 2, Args(0))

    If Me.visible = False Then
        Me.Show vbModeless, frmMain
    Else
        Me.SetFocus
    End If

End Sub

Public Sub CVC_HandleCambiarSeleccion(ParamArray Args() As Variant)

    If Args(0) Then Args(0) = 1
    Call CVC_UpdateSeleccion(Args(1), Args(2), CByte(Args(0)), CVC_maxSel)
    
    cmdConfirmarSel.Enabled = True
    cmdStart.Enabled = False
    
    Exit Sub
    
    Dim lstActual As Object, lblActual As Object
    If Args(0) Then
        lstParticipantes.Clear
        Set lstActual = lstParticipantes
        Set lblActual = lblInfo(0)
    Else
        lstParticipantesE.Clear
        Set lstActual = lstParticipantesE
        Set lblActual = lblInfo(1)
        cmdActualizarSel.Enabled = True ' @@ Me permite cambiar a mi también jeje
    End If

    Dim Data() As String
    Dim SelArray() As String
    Data = Split(Args(1), Chr(44))

    Dim i As Long
    Dim Seleccionado As Boolean, totSel As Byte
    totSel = 0

    For i = LBound(Data) To UBound(Data)
        lstActual.AddItem Data(i)
        lstActual.Selected(lstActual.ListCount - 1) = True
        totSel = totSel + 1
    Next i
         
    lblActual.Caption = totSel & IIf(Args(0), "/" & CVC_maxSel, "") & " jugadores seleccionados"
    
    cmdConfirmarSel.Enabled = True
    cmdStart.Enabled = False
    
End Sub

Public Sub cvc_HandleConfirmarSeleccion(ParamArray Args() As Variant)

    If Args(0) Then
    
        If Args(1) = 1 Then ' @@ Él no confirmó
        
            cmdActualizarSel.Enabled = False
            lblInfo(0).ForeColor = vbRed
            lblInfo(0).Caption = lstParticipantes.ListCount & " jugadores confirmados."
            cmdStart.Enabled = False
            
        ElseIf Args(1) = 2 Then ' @@ acá implica que ambos estamo listo
            lblInfo(1).ForeColor = vbRed
            lblInfo(1).Caption = lstParticipantesE.ListCount & " jugadores confirmados."
            lblInfo(0).ForeColor = vbRed
            lblInfo(0).Caption = lstParticipantes.ListCount & " jugadores confirmados."
            cmdStart.Enabled = True
            cmdActualizarSel.Enabled = False
            cmdConfirmarSel.Enabled = False
        End If
        
    Else
        ' @@ Confirmó el compa?
        
        If Args(1) = 1 Then ' @@ Él no confirmó
        
            lblInfo(1).ForeColor = vbRed
            lblInfo(1).Caption = lstParticipantesE.ListCount & " jugadores confirmados."
        ElseIf Args(1) = 2 Then ' @@ acá implica que ambos estamo listo
            Debug.Print "a"
        End If
        
    End If
        
End Sub

Public Sub CVC_HandleEstoyListo(ByVal tipo As Byte, NickName As String)

    If tipo Then
        ' @@ Lo busco en mi lista
        Debug.Print "Friend: " & NickName & " está listo!"
    Else
        ' @@ Lo busco en la lista enemiga
        Debug.Print "Enemy: " & NickName & " está listo!"
        lblInfo(1).Caption = ""
    End If

End Sub

Public Sub CVC_HandleIniciar(ParamArray Args() As Variant)
    If Args(0) Then
        Debug.Print "Le di a iniciar!"
        cmdConfirmarSel.Enabled = False
    Else
        Debug.Print "El otro usuario le dio a iniciar!"
    End If
End Sub


