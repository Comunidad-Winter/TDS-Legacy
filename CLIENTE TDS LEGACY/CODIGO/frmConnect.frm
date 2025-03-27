VERSION 5.00
Begin VB.Form frmConnect 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "ConectarSrvrTds"
   ClientHeight    =   9000
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12000
   ClipControls    =   0   'False
   FillColor       =   &H00000040&
   Icon            =   "frmConnect.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MouseIcon       =   "frmConnect.frx":000C
   Moveable        =   0   'False
   Picture         =   "frmConnect.frx":015E
   ScaleHeight     =   600
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   800
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.PictureBox MainViewPic 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   9000
      Left            =   0
      ScaleHeight     =   600
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   800
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   0
      Width           =   12000
      Begin VB.Timer Timer1 
         Interval        =   450
         Left            =   0
         Top             =   0
      End
      Begin VB.Shape Shape1 
         BackColor       =   &H00FF8080&
         BackStyle       =   1  'Opaque
         Height          =   60
         Left            =   5340
         Shape           =   3  'Circle
         Top             =   2640
         Visible         =   0   'False
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackColor       =   &H00FF8080&
         BackStyle       =   1  'Opaque
         Height          =   60
         Left            =   6000
         Shape           =   3  'Circle
         Top             =   2520
         Visible         =   0   'False
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackColor       =   &H00FF8080&
         BackStyle       =   1  'Opaque
         Height          =   60
         Left            =   6720
         Shape           =   1  'Square
         Top             =   2880
         Visible         =   0   'False
         Width           =   135
      End
      Begin VB.Image imgAceptar 
         Height          =   735
         Left            =   3840
         Top             =   5520
         Visible         =   0   'False
         Width           =   2175
      End
      Begin VB.Image imgSalirNo 
         Height          =   615
         Left            =   6720
         Top             =   4680
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Image imgSalirSi 
         Height          =   615
         Left            =   4560
         Top             =   4680
         Visible         =   0   'False
         Width           =   1455
      End
      Begin VB.Image imgOpciones 
         Height          =   735
         Left            =   5040
         Top             =   6315
         Visible         =   0   'False
         Width           =   2535
      End
      Begin VB.Image imgConectarse 
         Height          =   1215
         Left            =   4560
         Top             =   3720
         Visible         =   0   'False
         Width           =   3135
      End
      Begin VB.Image imgSalir 
         Height          =   735
         Left            =   5280
         Top             =   7080
         Visible         =   0   'False
         Width           =   2055
      End
      Begin VB.Image imgCrearPj 
         Appearance      =   0  'Flat
         Height          =   1095
         Left            =   4920
         Top             =   5160
         Visible         =   0   'False
         Width           =   2775
      End
   End
   Begin VB.Image imgServArgentina 
      Height          =   795
      Left            =   360
      MousePointer    =   99  'Custom
      Top             =   9240
      Visible         =   0   'False
      Width           =   2595
   End
End
Attribute VB_Name = "frmConnect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public Mx As Integer
Public mY As Integer
Public mb As Integer
Public QuieroCrearPj As Boolean

Private Sub Form_KeyPress(KeyAscii As Integer)

    If frmMensaje.visible Then Exit Sub

    'Aceptar
    If KeyAscii = vbKeyReturn Then
        If PanelQuitVisible Then Exit Sub
        LoggedByReturn = True
        Conectarse
        Exit Sub
    End If

    If KeyAscii = 27 Then
        If Caida = TOP_CAIDA_CONECTAR Then
            Call IniciarCaida(0)
        End If
        If PanelQuitVisible Then
            Call IniciarCaida(0)
            PanelQuitVisible = False
            Exit Sub
        End If

        ' @@ Cui: con ESC salgo o no? mm.. pienso
        End

    End If

    ' presionó: "C" o "c"
    If (KeyAscii = 99 Or KeyAscii = 67) And Not PanelQuitVisible And Not frmOldPersonaje.visible Then
        'If Not PanelQuitVisible Then
        frmOldPersonaje.Show vbModeless, frmConnect
        Call IniciarCaida(1)
        Exit Sub
        'End If
    End If

End Sub

Private Sub Form_Load()

    If Not frmMain.visible Then        'por frmMensaje que hace el call ese choto tengo que sacarlo jjsd
        EngineRun = False
        Set MainViewPic.Picture = Nothing
    End If

    ConnectVisible = True

End Sub

Private Sub Form_Terminate()
    ConnectVisible = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    ConnectVisible = False
End Sub

Private Sub MainViewPic_Click()

    If frmMensaje.visible Then frmMensaje.SetFocus: Exit Sub

    Dim found As Boolean
    If ModoCaida = 0 Then
        If Caida <> 0 And Caida <> TOP_CAIDA_CONECTAR Then
            Exit Sub
        End If
    End If
    QuieroCrearPj = False

    'Conectarse
    If frmConnect.Mx > frmConnect.imgConectarse.Left And frmConnect.Mx < (frmConnect.imgConectarse.Left + frmConnect.imgConectarse.Width) Then
        If frmConnect.mY > frmConnect.imgConectarse.Top And frmConnect.mY < (frmConnect.imgConectarse.Top + frmConnect.imgConectarse.Height) Then
            If Not (PanelQuitVisible) Then
                If Not Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
                'Call mod_updater.CheckIfUpdateNeeded
                frmOldPersonaje.Show vbModeless, frmConnect
                Call IniciarCaida(1)
                found = True
            End If
        End If
    End If

    'Crear Personaje
    If frmConnect.Mx > frmConnect.imgCrearPj.Left And frmConnect.Mx < (frmConnect.imgCrearPj.Left + frmConnect.imgCrearPj.Width) Then
        If frmConnect.mY > frmConnect.imgCrearPj.Top And frmConnect.mY < (frmConnect.imgCrearPj.Top + frmConnect.imgCrearPj.Height) Then

            If Not (PanelQuitVisible) Then
                If Not Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
                'Call mod_updater.CheckIfUpdateNeeded
                Call IniciarCaida(1)
                LastPanel = eVentanas.vInventario
                QuieroCrearPj = True
                found = True
            End If
        End If
    End If

    'Opciones
    If frmConnect.Mx > frmConnect.imgOpciones.Left And frmConnect.Mx < (frmConnect.imgOpciones.Left + frmConnect.imgOpciones.Width) Then
        If frmConnect.mY > frmConnect.imgOpciones.Top And frmConnect.mY < (frmConnect.imgOpciones.Top + frmConnect.imgOpciones.Height) Then
            If Not (PanelQuitVisible) Then
                If Not Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
                found = True
                frmOpciones.Show , frmConnect

            End If
        End If
    End If

    'Salir
    If frmConnect.Mx > frmConnect.imgSalir.Left And frmConnect.Mx < (frmConnect.imgSalir.Left + frmConnect.imgSalir.Width) Then
        If frmConnect.mY > frmConnect.imgSalir.Top And frmConnect.mY < (frmConnect.imgSalir.Top + frmConnect.imgSalir.Height) Then
            If Not (PanelQuitVisible) Then
                'If Not Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
                'IniciarCaida 1
                'found = True
                If Not Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
                found = True
                PanelQuitVisible = True
                Caida = 0
                ModoCaida = 1
            End If
        End If
    End If

    'Aceptar
    If frmConnect.Mx > frmConnect.imgAceptar.Left And frmConnect.Mx < (frmConnect.imgAceptar.Left + frmConnect.imgAceptar.Width) Then
        If frmConnect.mY > frmConnect.imgAceptar.Top And frmConnect.mY < (frmConnect.imgAceptar.Top + frmConnect.imgAceptar.Height) Then
            If Val(Caida) = Val(TOP_CAIDA_CONECTAR) Then Exit Sub
            If Not PanelQuitVisible Then

                found = True
            End If
        End If
    End If

    'SalirSi
    If frmConnect.Mx > frmConnect.imgSalirSi.Left And frmConnect.Mx < (frmConnect.imgSalirSi.Left + frmConnect.imgSalirSi.Width) Then
        If frmConnect.mY > frmConnect.imgSalirSi.Top And frmConnect.mY < (frmConnect.imgSalirSi.Top + frmConnect.imgSalirSi.Height) Then
            If Val(Caida) = 0 Then
                If Not frmOldPersonaje.visible Then
                    prgRun = False
                    found = True
                End If
            End If
        End If
    End If

    'SalirNo
    If frmConnect.Mx > frmConnect.imgSalirNo.Left And frmConnect.Mx < (frmConnect.imgSalirNo.Left + frmConnect.imgSalirNo.Width) Then
        If frmConnect.mY > frmConnect.imgSalirNo.Top And frmConnect.mY < (frmConnect.imgSalirNo.Top + frmConnect.imgSalirNo.Height) Then

            If Not frmOldPersonaje.visible Then
                IniciarCaida 0
                PanelQuitVisible = False
                found = True
            End If
        End If
    End If

    If Not found Then
        Call mod_Gui.GUI_Click
    End If

End Sub

Private Sub MainViewPic_DblClick()
' Call mod_Gui.GUI_Click(True)
End Sub

Private Sub MainViewPic_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF4 Then
        If PanelQuitVisible Or ModoCaida = 1 Then
            If ModoCaida = 1 And PanelQuitVisible = False Then
                PanelQuitVisible = True
            Else
                If frmOldPersonaje.visible = False Then
                    If Caida < 152 Then
                        prgRun = False
                    End If
                End If
            End If
        Else
            Call IniciarCaida(1)
        End If
    End If
End Sub

Private Sub MainViewPic_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Mx = X
    mY = Y
    mb = Button
End Sub

Private Sub Timer1_Timer()
    Randomize Timer
    If RandomNumber(1, 3) = 1 Then
        Shapes(1) = Not Shapes(1)
    End If
    If RandomNumber(1, 3) = 1 Then
        Shapes(2) = Not Shapes(2)
    End If
    If RandomNumber(1, 3) = (1 Or 2) Then
        Shapes(3) = Not Shapes(3)
    End If
End Sub
