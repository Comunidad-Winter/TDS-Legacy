VERSION 5.00
Begin VB.Form frmCambioRostro 
   BackColor       =   &H000000FF&
   BorderStyle     =   0  'None
   ClientHeight    =   3015
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3525
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmCambioRostro.frx":0000
   ScaleHeight     =   201
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   235
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox picTemp 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      Height          =   975
      Left            =   3720
      ScaleHeight     =   61
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   37
      TabIndex        =   1
      Top             =   960
      Width           =   615
   End
   Begin VB.PictureBox picPJ 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   975
      Left            =   1530
      ScaleHeight     =   65
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   41
      TabIndex        =   0
      Top             =   1125
      Width           =   615
   End
   Begin VB.Timer tAnimacion 
      Left            =   3000
      Top             =   1320
   End
   Begin VB.Image imgCerrar 
      Height          =   420
      Left            =   1920
      Top             =   2280
      Width           =   975
   End
   Begin VB.Image DirPJ 
      Height          =   345
      Index           =   0
      Left            =   960
      Top             =   1320
      Width           =   360
   End
   Begin VB.Image DirPJ 
      Height          =   345
      Index           =   1
      Left            =   2280
      Top             =   1320
      Width           =   240
   End
   Begin VB.Line Line1 
      BorderColor     =   &H000000FF&
      BorderStyle     =   3  'Dot
      Index           =   2
      Visible         =   0   'False
      X1              =   71
      X2              =   96
      Y1              =   143
      Y2              =   143
   End
   Begin VB.Image ImgCambiarHead 
      Height          =   420
      Left            =   720
      Top             =   2280
      Width           =   975
   End
End
Attribute VB_Name = "frmCambioRostro"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private UserHeadActual As Integer

Private clsFormulario As clsFrmMovMan
Private NextFrame As Byte

Private CurrentGrh As Long
Private Dir As E_Heading


Private Sub Form_Activate()
    Call UpdatePicturesAnim
End Sub

Private Sub Form_Load()

    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "12177.bmp", False)

    Call DrawImageInPicture(picPJ, Me.Picture, 0, 0, , , picPJ.Left, picPJ.Top)
    Dir = SOUTH

    UserHeadActual = charlist(UserCharIndex).iHead

End Sub

Private Sub DirPJ_Click(index As Integer)

    Dim Counter As Integer
    Dim Head As Integer

    Head = UserHeadActual

    If index > 0 Then
        Head = CheckCabeza(Head, True)
    Else
        Head = CheckCabeza(Head, False)
    End If

    UserHeadActual = Head

End Sub

Private Sub ImgCambiarHead_Click()

    If UserEstado = 1 Then
        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call ShowConsoleMsg("¡¡Estás muerto!!", .red, .green, .blue, .bold, .italic)
        End With
        Unload Me
    Else
        If MsgBox("¿Estas seguro que deseas cambiar el rostro?", vbYesNo, "Atencion!") = vbYes Then
            Call WriteCambiarCara(UserHeadActual)
            Unload Me
        End If

    End If

End Sub

Private Sub imgCerrar_Click()
    Unload Me
End Sub

Private Sub tAnimacion_Timer()

    If CurrentGrh < 1 Then Exit Sub

    Dim SR As RECT
    Dim DR As RECT
    Dim Grh As Long

    If tAnimacion.Enabled Then
        If NextFrame < GrhData(CurrentGrh).NumFrames Then
            NextFrame = NextFrame + 1
        Else
            NextFrame = 1
        End If
    Else
        NextFrame = 1
    End If

    Call DrawImageInPicture(picPJ, Me.Picture, 0, 0, , , picPJ.Left, picPJ.Top)

    Grh = GrhData(CurrentGrh).Frames(NextFrame)

    With GrhData(Grh)
        SR.Left = .sX
        SR.Top = .sY
        SR.Right = SR.Left + .pixelWidth
        SR.Bottom = SR.Top + .pixelHeight

        DR.Left = (picPJ.Width - .pixelWidth) \ 2 - 2
        DR.Top = (picPJ.Height - .pixelHeight) \ 2 - 2
        DR.Right = DR.Left + .pixelWidth
        DR.Bottom = DR.Top + .pixelHeight
    End With

    picTemp.BackColor = picTemp.BackColor

    Call DrawGrhtoHdc(picTemp.hdc, Grh, DR, DR)
    Call DrawTransparentGrhtoHdc(picPJ.hdc, picTemp.hdc, DR, DR, vbBlack)

    'UserHead = CheckCabeza(UserHead)
    Grh = HeadData(UserHeadActual).Head(Dir).GrhIndex
    If Grh < 1 Then Exit Sub

    With GrhData(Grh)
        SR.Left = .sX
        SR.Top = .sY
        SR.Right = SR.Left + .pixelWidth
        SR.Bottom = SR.Top + .pixelHeight

        DR.Left = (picPJ.Width - .pixelWidth) \ 2 - 1
        DR.Top = DR.Bottom + BodyData(charlist(UserCharIndex).iBody).HeadOffset.Y - .pixelHeight + 1
        DR.Right = DR.Left + .pixelWidth
        DR.Bottom = DR.Top + .pixelHeight
    End With

    picTemp.BackColor = picTemp.BackColor

    Call DrawGrhtoHdc(picTemp.hdc, Grh, DR, DR)
    Call DrawTransparentGrhtoHdc(picPJ.hdc, picTemp.hdc, DR, DR, vbBlack)

End Sub

Private Sub UpdatePicturesAnim()

    CurrentGrh = BodyData(charlist(UserCharIndex).iBody).Walk(Dir).GrhIndex

    If CurrentGrh > 0 Then
        tAnimacion.interval = Round(GrhData(CurrentGrh).Speed / GrhData(CurrentGrh).NumFrames)
    End If

End Sub

Private Function CheckCabeza(ByVal Head As Integer, Add As Boolean) As Integer

    If Add Then
        Head = Head + 1
    Else
        Head = Head - 1
    End If

    Select Case UserSexo
    Case eGenero.Hombre
        Select Case UserRaza
        Case eRaza.Humano
            If Head > HUMANO_H_ULTIMA_CABEZA Then
                CheckCabeza = HUMANO_H_PRIMER_CABEZA
            ElseIf Head < HUMANO_H_PRIMER_CABEZA Then
                CheckCabeza = HUMANO_H_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Elfo
            If Head > ELFO_H_ULTIMA_CABEZA Then
                CheckCabeza = ELFO_H_PRIMER_CABEZA
            ElseIf Head < ELFO_H_PRIMER_CABEZA Then
                CheckCabeza = ELFO_H_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.ElfoOscuro
            If Head > DROW_H_ULTIMA_CABEZA Then
                CheckCabeza = DROW_H_PRIMER_CABEZA
            ElseIf Head < DROW_H_PRIMER_CABEZA Then
                CheckCabeza = DROW_H_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Enano
            If Head > ENANO_H_ULTIMA_CABEZA Then
                CheckCabeza = ENANO_H_PRIMER_CABEZA
            ElseIf Head < ENANO_H_PRIMER_CABEZA Then
                CheckCabeza = ENANO_H_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Gnomo
            If Head > GNOMO_H_ULTIMA_CABEZA Then
                CheckCabeza = GNOMO_H_PRIMER_CABEZA
            ElseIf Head < GNOMO_H_PRIMER_CABEZA Then
                CheckCabeza = GNOMO_H_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case Else

            Exit Function
        End Select

    Case eGenero.Mujer
        Select Case UserRaza
        Case eRaza.Humano
            If Head > HUMANO_M_ULTIMA_CABEZA Then
                CheckCabeza = HUMANO_M_PRIMER_CABEZA
            ElseIf Head < HUMANO_M_PRIMER_CABEZA Then
                CheckCabeza = HUMANO_M_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Elfo
            If Head > ELFO_M_ULTIMA_CABEZA Then
                CheckCabeza = ELFO_M_PRIMER_CABEZA
            ElseIf Head < ELFO_M_PRIMER_CABEZA Then
                CheckCabeza = ELFO_M_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.ElfoOscuro
            If Head > DROW_M_ULTIMA_CABEZA Then
                CheckCabeza = DROW_M_PRIMER_CABEZA
            ElseIf Head < DROW_M_PRIMER_CABEZA Then
                CheckCabeza = DROW_M_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Enano
            If Head > ENANO_M_ULTIMA_CABEZA Then
                CheckCabeza = ENANO_M_PRIMER_CABEZA
            ElseIf Head < ENANO_M_PRIMER_CABEZA Then
                CheckCabeza = ENANO_M_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        Case eRaza.Gnomo
            If Head > GNOMO_M_ULTIMA_CABEZA Then
                CheckCabeza = GNOMO_M_PRIMER_CABEZA
            ElseIf Head < GNOMO_M_PRIMER_CABEZA Then
                CheckCabeza = GNOMO_M_ULTIMA_CABEZA
            Else
                CheckCabeza = Head
            End If

        End Select

    End Select

End Function

Private Function CheckDir(ByRef Dir As E_Heading) As E_Heading

    If Dir > E_Heading.WEST Then
        Dir = E_Heading.NORTH
    End If

    If Dir < E_Heading.NORTH Then
        Dir = E_Heading.WEST
    End If

    CheckDir = Dir
    CurrentGrh = BodyData(charlist(UserCharIndex).iBody).Walk(Dir).GrhIndex

    If CurrentGrh > 0 Then
        tAnimacion.interval = (Round(GrhData(CurrentGrh).Speed / GrhData(CurrentGrh).NumFrames)) * 0.9

        If Not tAnimacion.interval Then
            tAnimacion.interval = 1
        End If

    End If

End Function
