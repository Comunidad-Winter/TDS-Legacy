VERSION 5.00
Begin VB.Form frmRetos 
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   5385
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2865
   LinkTopic       =   "Form1"
   Picture         =   "FrmRetos.frx":0000
   ScaleHeight     =   5385
   ScaleWidth      =   2865
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtClanMaxUsers 
      BorderStyle     =   0  'None
      Height          =   250
      Left            =   360
      TabIndex        =   32
      Top             =   2400
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.TextBox txtClan 
      BorderStyle     =   0  'None
      Height          =   250
      Left            =   360
      TabIndex        =   31
      Top             =   1920
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.OptionButton optclanVsClan 
      BackColor       =   &H00004080&
      Caption         =   "Clan    vs   Clan"
      ForeColor       =   &H00E0E0E0&
      Height          =   615
      Left            =   1920
      TabIndex        =   30
      TabStop         =   0   'False
      Top             =   70
      Width           =   855
   End
   Begin VB.ListBox lstBotClass 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      ForeColor       =   &H000000FF&
      Height          =   1395
      Left            =   840
      TabIndex        =   28
      TabStop         =   0   'False
      Top             =   2040
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.HScrollBar HScroll 
      Height          =   375
      Left            =   240
      Max             =   5
      Min             =   1
      TabIndex        =   27
      Top             =   1200
      Value           =   1
      Visible         =   0   'False
      Width           =   2325
   End
   Begin VB.OptionButton boto 
      BackColor       =   &H00004080&
      Caption         =   "BOT"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   2100
      TabIndex        =   26
      TabStop         =   0   'False
      Top             =   720
      Width           =   630
   End
   Begin VB.CheckBox chkResu 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "No vale Resucitar"
      ForeColor       =   &H00E0E0E0&
      Height          =   375
      Left            =   375
      TabIndex        =   25
      TabStop         =   0   'False
      Top             =   3825
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.CheckBox chkCascoEscu 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "No permitir el uso de Cascos y Escudos"
      ForeColor       =   &H00E0E0E0&
      Height          =   375
      Left            =   360
      TabIndex        =   24
      TabStop         =   0   'False
      Top             =   3600
      Width           =   1935
   End
   Begin VB.CheckBox chkPlante 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "Plantados"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   360
      TabIndex        =   23
      TabStop         =   0   'False
      Top             =   3240
      Width           =   1455
   End
   Begin VB.TextBox txtNick 
      BorderStyle     =   0  'None
      Height          =   285
      Index           =   4
      Left            =   360
      TabIndex        =   6
      Top             =   4450
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.TextBox txtNick 
      BorderStyle     =   0  'None
      Height          =   285
      Index           =   3
      Left            =   360
      TabIndex        =   5
      Top             =   3910
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.TextBox txtNick 
      BorderStyle     =   0  'None
      Height          =   285
      Index           =   2
      Left            =   360
      TabIndex        =   4
      Top             =   3410
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.TextBox txtNick 
      BorderStyle     =   0  'None
      Height          =   285
      Index           =   1
      Left            =   360
      TabIndex        =   3
      Top             =   2910
      Visible         =   0   'False
      Width           =   2115
   End
   Begin VB.TextBox txtNick 
      BorderStyle     =   0  'None
      Height          =   285
      Index           =   0
      Left            =   360
      TabIndex        =   2
      Top             =   2400
      Width           =   2115
   End
   Begin VB.CommandButton cmdRestarPotas 
      Appearance      =   0  'Flat
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   2300
      TabIndex        =   19
      TabStop         =   0   'False
      Top             =   1490
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.CommandButton cmdSumarPotas 
      Appearance      =   0  'Flat
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   2300
      TabIndex        =   18
      TabStop         =   0   'False
      Top             =   1300
      Visible         =   0   'False
      Width           =   377
   End
   Begin VB.TextBox txtPotas 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      Height          =   360
      Left            =   1800
      TabIndex        =   17
      TabStop         =   0   'False
      Text            =   "0"
      Top             =   1300
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.CheckBox chkRojas 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "Pociones rojas:"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   360
      TabIndex        =   16
      TabStop         =   0   'False
      Top             =   1400
      Width           =   1455
   End
   Begin VB.OptionButton treco 
      BackColor       =   &H00004080&
      Caption         =   "3vs3"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   1460
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   720
      Width           =   640
   End
   Begin VB.OptionButton doco 
      BackColor       =   &H00004080&
      Caption         =   "2vs2"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   830
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   720
      Width           =   640
   End
   Begin VB.OptionButton ucu 
      BackColor       =   &H00004080&
      Caption         =   "1vs1"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   190
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   720
      Value           =   -1  'True
      Width           =   640
   End
   Begin VB.CheckBox chkDrop 
      Appearance      =   0  'Flat
      BackColor       =   &H00004080&
      Caption         =   "Por los items"
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   360
      TabIndex        =   8
      TabStop         =   0   'False
      Top             =   1145
      Width           =   1455
   End
   Begin VB.TextBox amount 
      BorderStyle     =   0  'None
      Height          =   250
      Left            =   360
      TabIndex        =   1
      Top             =   1890
      Width           =   2115
   End
   Begin VB.Label lblClan 
      BackStyle       =   0  'Transparent
      Caption         =   "Clan enemigo"
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
      Left            =   350
      TabIndex        =   34
      Top             =   1650
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label lblClanMaxUsers 
      BackStyle       =   0  'Transparent
      Caption         =   "Máx. cant. de jugadores"
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
      Left            =   360
      TabIndex        =   33
      Top             =   2190
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Label lblDificultad 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "(1)"
      BeginProperty Font 
         Name            =   "Lucida Console"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0C0&
      Height          =   255
      Left            =   2070
      TabIndex        =   29
      Top             =   1680
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.Label lblMasOpciones 
      BackStyle       =   0  'Transparent
      Caption         =   "Más opciones:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   360
      TabIndex        =   22
      Top             =   2880
      Width           =   1335
   End
   Begin VB.Label lblCinco 
      BackStyle       =   0  'Transparent
      Caption         =   "lblCinco"
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
      Left            =   360
      TabIndex        =   21
      Top             =   4245
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Label lblCuatro 
      BackStyle       =   0  'Transparent
      Caption         =   "lblCuatro"
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
      Left            =   360
      TabIndex        =   20
      Top             =   3710
      Width           =   2295
   End
   Begin VB.Label lblCancelar 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   1440
      TabIndex        =   14
      Top             =   4920
      Width           =   1215
   End
   Begin VB.Label lblRetar 
      BackStyle       =   0  'Transparent
      Height          =   375
      Left            =   120
      TabIndex        =   13
      Top             =   4920
      Width           =   1215
   End
   Begin VB.Label lblTres 
      BackStyle       =   0  'Transparent
      Caption         =   "lblTres"
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
      Left            =   360
      TabIndex        =   10
      Top             =   3210
      Width           =   2295
   End
   Begin VB.Label lblDos 
      BackStyle       =   0  'Transparent
      Caption         =   "lblDos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000F&
      Height          =   255
      Left            =   360
      TabIndex        =   9
      Top             =   2715
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Cantidad de oro en juego:"
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
      Left            =   350
      TabIndex        =   7
      Top             =   1650
      Width           =   2295
   End
   Begin VB.Label lblUno 
      BackStyle       =   0  'Transparent
      Caption         =   "Personaje enemigo:"
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
      Left            =   360
      TabIndex        =   0
      Top             =   2190
      Width           =   2175
   End
End
Attribute VB_Name = "frmRetos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private clsFormulario As clsFrmMovMan

Private Sub amount_Change()
    If Val(amount.Text) > 2000000 Then
        amount.Text = 2000000
    End If

    If Val(amount.Text) < 0 Then
        amount.Text = 0
    End If

End Sub

Private Sub boto_Click()

    lblDificultad.visible = True
    lstBotClass.visible = True
    HScroll.visible = True

    Label2.visible = False
    amount.visible = False
    lblUno.visible = False
    txtNick(0).visible = False
    txtPotas.visible = False
    cmdSumarPotas.visible = False
    cmdRestarPotas.visible = False
    ucu.Value = False
    doco.Value = False
    chkCascoEscu.visible = False
    chkPlante.visible = False
    chkDrop.visible = False
    chkRojas.visible = False
    lblUno.visible = False
    lblDos.visible = False
    lblTres.visible = False
    lblCuatro.visible = False
    lblCinco.visible = False
    lblMasOpciones.visible = False
    chkResu.visible = False
    txtNick(1).visible = False
    txtNick(2).visible = False
    txtNick(3).visible = False
    txtNick(4).visible = False

    lblUno.Caption = ""
    lblDos.Caption = ""
    lblTres.Caption = ""
    lblCuatro.Caption = ""
    lblCinco.Caption = ":"
    txtNick(4).Text = ""
    txtNick(3).Text = ""
    txtNick(2).Text = ""
    txtNick(1).Text = ""
End Sub

Private Sub chkRojas_Click()
    txtPotas.visible = Not txtPotas.visible
    txtPotas.Text = "1"
    cmdSumarPotas.visible = Not cmdSumarPotas.visible
    cmdRestarPotas.visible = Not cmdRestarPotas.visible
End Sub

Private Sub cmdRestarPotas_Click()

    txtPotas.Text = Val(txtPotas.Text) - 1
    If Val(txtPotas.Text) <= 1 Then
        txtPotas.Text = 1
    End If

End Sub

Private Sub cmdSumarPotas_Click()

    txtPotas.Text = Val(txtPotas.Text) + 1

    If Val(txtPotas.Text) > 50000 Then
        txtPotas.Text = 50000
    End If

End Sub

Private Sub doco_Click()
    
    lblClan.visible = False
    txtClan.visible = False
    lblClanMaxUsers.visible = False
    txtClanMaxUsers.visible = False
    
    lblDificultad.visible = False
    lstBotClass.visible = False
    HScroll.visible = False
    Label2.visible = True
    amount.visible = True
    lblUno.visible = True
    txtNick(0).visible = True
    txtPotas.visible = True
    cmdSumarPotas.visible = True
    cmdRestarPotas.visible = True
    chkDrop.visible = True
    chkRojas.visible = True
    ucu.Value = False
    treco.Value = False
    lblMasOpciones.visible = False
    chkCascoEscu.visible = False
    chkPlante.visible = False

    lblUno.Caption = "Tu compañero:"
    lblDos.visible = True
    lblDos.Caption = "Personaje enemigo:"
    lblTres.Caption = "Personaje enemigo 2:"
    lblTres.visible = True
    lblCuatro.visible = False
    lblCinco.visible = False
    txtNick(1).visible = True
    txtNick(2).visible = True
    txtNick(3).visible = False
    txtNick(4).visible = False
    chkResu.visible = True

    txtNick(4).Text = ""
    txtNick(3).Text = ""
    txtNick(2).Text = ""
    txtNick(1).Text = ""
End Sub

Private Sub Form_Load()
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me
    
    lstBotClass.Clear

    lstBotClass.AddItem "Clérigo"
    lstBotClass.AddItem "Mago"
    lstBotClass.AddItem "Cazador"

    lstBotClass.ListIndex = 1

End Sub

Private Sub lblCancelar_Click()
    Unload Me
End Sub

Private Sub lblRetar_Click()

    If boto.Value = True Then
        Call WriteRetoBOT(CByte(HScroll.Value), CByte(lstBotClass.ListIndex + 1)): Unload Me: Exit Sub
    End If
    
    If optclanVsClan.Value = True Then
        Call WriteCVC(mCVC_Accion.cvc_EnviarSolicitud, txtClan.Text, GetByteVal(txtClanMaxUsers.Text)): Unload Me: Exit Sub
    End If
    
    Dim Oro As Long
    Dim nicks(0 To 4) As String
    Dim amountRed As Long
    Dim i As Long
    Dim sinResu As Boolean

    'sanitizamos el nick bue
    For i = 0 To 4
        nicks(i) = txtNick(i).Text
        nicks(i) = Trim$(nicks(i))
        If txtNick(i).visible Then
            If Len(nicks(i)) < 3 Or Len(nicks(i)) > 15 Or Not AsciiValidos(nicks(i)) Then
                ShowConsoleMsg "El nick " & Chr(34) & nicks(i) & Chr(34) & " es inválido.", 65, 190, 156, False, False
                Exit Sub
            End If
        End If
    Next i

    Oro = Abs(Val(amount.Text))

    If Oro > 2000000 Then
        ShowConsoleMsg "La apuesta máxima es de 2.000.000 monedas de oro.", 65, 190, 156, False, False
        Exit Sub
    End If

    If Oro < 1000 Then
        ShowConsoleMsg "La apuesta mínima es de 1.000 monedas de oro.", 65, 190, 156, False, False
        Exit Sub
    End If

    If chkRojas.Value = 1 Then
        amountRed = Abs(Val(txtPotas.Text))
        If amountRed <= 0 Then        '????
            ShowConsoleMsg "La cantidad de pociones rojas mínima es de 1 poción roja.", 65, 190, 156, False, False
            Exit Sub
        End If
        If amountRed > 10000 Then        '????
            ShowConsoleMsg "La cantidad de pociones rojas máxima es de 10.000 pociones rojas.", 65, 190, 156, False, False
            Exit Sub
        End If
    End If

    sinResu = (chkResu.Value = 1)

    If ucu.Value = True Then
        WriteOtherSendReto nicks(0), Oro, CByte(chkDrop.Value), amountRed, CByte(chkPlante.Value), CByte(chkCascoEscu.Value)
    ElseIf doco.Value = True Then
        WriteSendReto nicks(0), nicks(1), nicks(2), CByte(chkDrop.Value), Oro, amountRed, sinResu
    ElseIf treco.Value = True Then

        sinResu = (MsgBox("Vale resucitar?", vbYesNo, "Reto 3vs3") = vbYes)

        WriteSendReto3vs3 nicks(0), nicks(1), nicks(2), nicks(3), nicks(4), CByte(chkDrop.Value), Oro, amountRed, sinResu
    End If

    Unload Me
End Sub

Private Sub optclanVsClan_Click()

    lblClan.visible = True
    
    txtClan.Text = ""
    txtClan.visible = True
    
    lblClanMaxUsers.visible = True
    txtClanMaxUsers.Text = ""
    txtClanMaxUsers.visible = True
        
    
    
    lblDificultad.visible = False
    lstBotClass.visible = False
    HScroll.visible = False

    Label2.visible = False
    amount.visible = False
    lblUno.visible = False
    txtNick(0).visible = False
    txtPotas.visible = False
    cmdSumarPotas.visible = False
    cmdRestarPotas.visible = False
    ucu.Value = False
    doco.Value = False
    chkCascoEscu.visible = False
    chkPlante.visible = False
    chkDrop.visible = False
    chkRojas.visible = False
    lblUno.visible = False
    lblDos.visible = False
    lblTres.visible = False
    lblCuatro.visible = False
    lblCinco.visible = False
    lblMasOpciones.visible = False
    chkResu.visible = False
    txtNick(1).visible = False
    txtNick(2).visible = False
    txtNick(3).visible = False
    txtNick(4).visible = False

    lblUno.Caption = ""
    lblDos.Caption = ""
    lblTres.Caption = ""
    lblCuatro.Caption = ""
    lblCinco.Caption = ":"
    txtNick(4).Text = ""
    txtNick(3).Text = ""
    txtNick(2).Text = ""
    txtNick(1).Text = ""
    
End Sub

Private Sub treco_Click()
    
    lblClan.visible = False
    txtClan.visible = False
    lblClanMaxUsers.visible = False
    txtClanMaxUsers.visible = False
    
    lblDificultad.visible = False
    lstBotClass.visible = False
    HScroll.visible = False

    Label2.visible = True
    amount.visible = True
    lblUno.visible = True
    txtNick(0).visible = True
    txtPotas.visible = True
    cmdSumarPotas.visible = True
    cmdRestarPotas.visible = True

    chkDrop.visible = True
    chkRojas.visible = True
    ucu.Value = False
    doco.Value = False
    chkCascoEscu.visible = False
    chkPlante.visible = False

    lblUno.visible = True
    lblDos.visible = True
    lblTres.visible = True
    lblCuatro.visible = True
    lblCinco.visible = True
    lblMasOpciones.visible = False

    lblUno.Caption = "Tu compañero:"
    lblDos.Caption = "Tu compañero 2:"
    lblTres.Caption = "Personaje enemigo:"


    chkResu.visible = False
    lblCuatro.Caption = "Personaje enemigo 2:"
    lblCinco.Caption = "Personaje enemigo 3:"
    txtNick(1).visible = True
    txtNick(2).visible = True
    txtNick(3).visible = True
    txtNick(4).visible = True
    txtNick(4).Text = ""
    txtNick(3).Text = ""
    txtNick(2).Text = ""
    txtNick(1).Text = ""

End Sub

Private Sub txtPotas_Change()


    If Val(txtPotas.Text) > 10000 Then
        txtPotas.Text = "10000"
    End If

    If Val(txtPotas.Text) < 1 Then
        txtPotas.Text = "1"
    End If

    If Not ValidAsciiNumber(txtPotas.Text) Then
        txtPotas.Text = "1"
    End If

End Sub


Private Function ValidAsciiNumber(ByVal cad As String)

    Dim car As Byte
    Dim i As Long

    cad = LCase$(cad)

    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))

        If (car < 48 Or car > 57) Then
            Exit Function
        End If
    Next i

    ValidAsciiNumber = True

End Function
Private Sub ucu_Click()

    lblClan.visible = False
    txtClan.visible = False
    lblClanMaxUsers.visible = False
    txtClanMaxUsers.visible = False
    
    lblDificultad.visible = False
    lstBotClass.visible = False
    HScroll.visible = False
    Label2.visible = True
    amount.visible = True
    lblUno.visible = True
    txtNick(0).visible = True
    txtPotas.visible = True
    cmdSumarPotas.visible = True
    cmdRestarPotas.visible = True
    chkDrop.visible = True
    chkRojas.visible = True
    doco.Value = False
    treco.Value = False
    lblMasOpciones.visible = True
    chkCascoEscu.visible = True
    chkPlante.visible = True

    chkResu.visible = False
    lblUno.Caption = "Personaje enemigo:"
    lblDos.visible = False
    lblTres.visible = False
    lblCuatro.visible = False
    lblCinco.visible = False
    txtNick(1).visible = False
    txtNick(2).visible = False
    txtNick(3).visible = False
    txtNick(4).visible = False
    txtNick(4).Text = ""
    txtNick(3).Text = ""
    txtNick(2).Text = ""
    txtNick(1).Text = ""

End Sub

Private Sub HScroll_Change()
    lblDificultad.Caption = "(" & HScroll.Value & ")"
End Sub

Private Sub HScroll_Scroll()
    lblDificultad.Caption = "(" & HScroll.Value & ")"
End Sub
