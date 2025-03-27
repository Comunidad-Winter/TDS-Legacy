VERSION 5.00
Begin VB.Form frmParty 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   ClientHeight    =   4200
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4905
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "Partym.frx":0000
   ScaleHeight     =   280
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   327
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Enabled         =   0   'False
      Height          =   2175
      ItemData        =   "Partym.frx":1D2E9
      Left            =   2520
      List            =   "Partym.frx":1D2EB
      TabIndex        =   0
      Top             =   840
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.ListBox List2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Height          =   2175
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00004080&
      BorderStyle     =   0  'None
      Height          =   2535
      Left            =   120
      TabIndex        =   5
      Top             =   600
      Width           =   4575
      Begin VB.Label Label13 
         BackStyle       =   0  'Transparent
         Caption         =   "Experiencia total:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Left            =   1440
         TabIndex        =   26
         Top             =   2280
         Width           =   1575
      End
      Begin VB.Label Label11 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Left            =   3000
         TabIndex        =   24
         Top             =   2280
         Width           =   2055
      End
      Begin VB.Line Line5 
         BorderColor     =   &H00E0E0E0&
         X1              =   120
         X2              =   4560
         Y1              =   2160
         Y2              =   2160
      End
      Begin VB.Line Line4 
         BorderColor     =   &H00E0E0E0&
         X1              =   120
         X2              =   4560
         Y1              =   1800
         Y2              =   1800
      End
      Begin VB.Line Line3 
         BorderColor     =   &H00E0E0E0&
         X1              =   120
         X2              =   4560
         Y1              =   1440
         Y2              =   1440
      End
      Begin VB.Line Line2 
         BorderColor     =   &H00E0E0E0&
         X1              =   120
         X2              =   4560
         Y1              =   1080
         Y2              =   1080
      End
      Begin VB.Line Line1 
         BorderColor     =   &H00E0E0E0&
         X1              =   120
         X2              =   4560
         Y1              =   720
         Y2              =   720
      End
      Begin VB.Label Label10 
         BackStyle       =   0  'Transparent
         Caption         =   "Porcentaje"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Left            =   2880
         TabIndex        =   23
         Top             =   120
         Width           =   975
      End
      Begin VB.Label Label9 
         BackStyle       =   0  'Transparent
         Caption         =   "Experiencia"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Left            =   1560
         TabIndex        =   22
         Top             =   120
         Width           =   1095
      End
      Begin VB.Label Label4 
         BackStyle       =   0  'Transparent
         Caption         =   "Personaje"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Left            =   240
         TabIndex        =   21
         Top             =   120
         Width           =   1095
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   4
         Left            =   3120
         TabIndex        =   20
         Top             =   1920
         Width           =   45
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   3
         Left            =   3120
         TabIndex        =   19
         Top             =   1560
         Width           =   45
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   2
         Left            =   3120
         TabIndex        =   18
         Top             =   1200
         Width           =   45
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   1
         Left            =   3120
         TabIndex        =   17
         Top             =   840
         Width           =   45
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   4
         Left            =   1560
         TabIndex        =   16
         Top             =   1920
         Width           =   45
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   3
         Left            =   1560
         TabIndex        =   15
         Top             =   1560
         Width           =   45
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   2
         Left            =   1560
         TabIndex        =   14
         Top             =   1200
         Width           =   45
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   1
         Left            =   1560
         TabIndex        =   13
         Top             =   840
         Width           =   45
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   12
         Top             =   1920
         Width           =   855
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   11
         Top             =   1560
         Width           =   855
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   10
         Top             =   1200
         Width           =   855
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         Caption         =   "Personaje1"
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Width           =   855
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Experiencia"
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   0
         Left            =   1560
         TabIndex        =   8
         Top             =   480
         Width           =   825
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "%"
         ForeColor       =   &H00C0C0C0&
         Height          =   195
         Index           =   0
         Left            =   3120
         TabIndex        =   7
         Top             =   480
         Width           =   120
      End
      Begin VB.Label Label5 
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00C0C0C0&
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   6
         Top             =   840
         Width           =   855
      End
   End
   Begin VB.Image boton 
      Height          =   255
      Index           =   0
      Left            =   3720
      Top             =   7500
      Visible         =   0   'False
      Width           =   15
   End
   Begin VB.Image boton 
      Height          =   420
      Index           =   3
      Left            =   3690
      Picture         =   "Partym.frx":1D2ED
      Top             =   3120
      Width           =   1155
   End
   Begin VB.Image boton 
      Height          =   420
      Index           =   7
      Left            =   2535
      Picture         =   "Partym.frx":200BC
      Top             =   3165
      Width           =   1125
   End
   Begin VB.Image boton 
      Height          =   480
      Index           =   6
      Left            =   120
      Picture         =   "Partym.frx":22E3A
      Top             =   3165
      Width           =   2250
   End
   Begin VB.Image boton 
      Height          =   480
      Index           =   5
      Left            =   2520
      Picture         =   "Partym.frx":263C8
      Top             =   3600
      Width           =   2325
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "X"
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
      Left            =   4560
      TabIndex        =   25
      Top             =   120
      Width           =   255
   End
   Begin VB.Label Label6 
      BackStyle       =   0  'Transparent
      Caption         =   ">>"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4350
      TabIndex        =   4
      Top             =   330
      Width           =   255
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Solicitudes:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   2520
      TabIndex        =   3
      Top             =   600
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.Label Label2 
      BackStyle       =   0  'Transparent
      Caption         =   "Integrantes:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   600
      Visible         =   0   'False
      Width           =   2175
   End
   Begin VB.Image boton 
      Height          =   480
      Index           =   2
      Left            =   120
      Picture         =   "Partym.frx":29C8C
      Top             =   3615
      Width           =   2265
   End
   Begin VB.Image boton 
      Height          =   480
      Index           =   1
      Left            =   120
      Picture         =   "Partym.frx":2D301
      Top             =   3615
      Width           =   2235
   End
End
Attribute VB_Name = "frmParty"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private fotosON(1 To 7) As Picture
Private fotosS(1 To 7) As Picture
Private fotosOFF(1 To 7) As Picture

Public Sub PrepararForm(ByVal IsLeader As Boolean, ByRef SourceString As String)

    Dim LoopC As Long
    Dim Temp() As String
    Dim nUser As Byte
    Dim TmpName As String

    Temp() = Split(SourceString, ",")
    List2.Clear

    For LoopC = 0 To UBound(Temp())
        If Not Temp(LoopC) = vbNullString Then
            TmpName = ReadField(1, Temp(LoopC), Asc("*"))

            If TmpName <> vbNullString Then
                Label5(nUser).Caption = TmpName
                Call List2.AddItem(TmpName)

                Label7(nUser).Caption = ReadField(2, Temp(LoopC), Asc("*"))
                Label8(nUser).Caption = ReadField(3, Temp(LoopC), Asc("*"))

                nUser = nUser + 1
            End If
        End If
    Next LoopC

    If IsLeader Then
        Label6.visible = True
        boton(3).visible = True
        boton(5).visible = True
        boton(6).visible = True
        boton(7).visible = True
    Else
        Label6.visible = False
        boton(3).visible = False
        boton(5).visible = False
        boton(6).visible = False
        boton(7).visible = False
    End If

End Sub

Private Sub Boton_Click(index As Integer)
    Call modEngine_Audio.PlayInterface(SND_CLICK)

    Dim i As Long

    Select Case index

    Case 1

        Me.boton(1).visible = False
        Me.boton(2).visible = True
        Me.boton(3).Enabled = False
        Me.boton(5).Enabled = False
        Me.boton(6).Enabled = False
        Me.boton(7).Enabled = False

    Case 2

        Call WritePartyLeave
        Unload Me

    Case 3

        If List1.ListIndex < 0 Then Exit Sub

        Call WritePartyKick(List1.List(List1.ListIndex))
        Call List1.RemoveItem(List1.ListIndex)
        Unload Me

    Case 5

        frmPartyPorc.Show , frmParty

    Case 6

        If List2.ListIndex < 0 Then Exit Sub

        Call WritePartyKick(List2.List(List2.ListIndex))
        If UCase$(List2.List(List2.ListIndex)) = UCase$(charlist(UserCharIndex).nombre) Then
            If charlist(UserCharIndex).Mimetizado = False Then
                Call List2.RemoveItem(List2.ListIndex)
                Unload Me
            End If
        End If

    Case 7

        If List1.ListIndex < 0 Then Exit Sub

        For i = 0 To (List1.ListCount - 1)
            If i = List1.ListIndex Then
                If LenB(List1.List(i)) > 0 Then
                    Call WritePartyAcceptMember(List1.List(i))
                    Exit For
                End If
            End If
        Next i

    End Select
End Sub

Private Sub Boton_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim i As Long

    For i = 1 To 7
        If i <> 4 And i <> 6 Then
            boton(i).Picture = fotosON(i)
        End If
    Next i

    Select Case index
    Case 1
        boton(index).Picture = fotosS(1)
    Case 2
        boton(index).Picture = fotosS(2)
    Case 3
        If boton(index).Enabled = True Then
            boton(index).Picture = fotosS(3)
        End If
    Case 5
        If boton(index).Enabled = True Then
            boton(index).Picture = fotosS(5)
        End If
    Case 6

        If boton(index).Enabled = True Then
            boton(index).Picture = fotosS(6)
        End If

    Case 7
        If boton(index).Enabled = True Then
            boton(index).Picture = fotosS(7)
        End If
    End Select
End Sub

Private Sub Form_Load()


    Set fotosON(1) = LoadPicture(App.Path & "\Graficos\Button\Party\bCreateParty.jpg")
    Set fotosON(2) = LoadPicture(App.Path & "\Graficos\Button\Party\bQuitParty.jpg")
    Set fotosON(3) = LoadPicture(App.Path & "\Graficos\Button\Party\bRejectParty.jpg")
    Set fotosON(5) = LoadPicture(App.Path & "\Graficos\Button\Party\bChangePorc.jpg")
    Set fotosON(6) = LoadPicture(App.Path & "\Graficos\Button\Party\bRemoveParty.jpg")
    Set fotosON(7) = LoadPicture(App.Path & "\Graficos\Button\Party\bAcceptParty.jpg")


    Set fotosS(1) = LoadPicture(App.Path & "\Graficos\Button\Party\bCreatePartyS.jpg")
    Set fotosS(2) = LoadPicture(App.Path & "\Graficos\Button\Party\bQuitPartyS.jpg")
    Set fotosS(3) = LoadPicture(App.Path & "\Graficos\Button\Party\bRejectPartyS.jpg")
    Set fotosS(5) = LoadPicture(App.Path & "\Graficos\Button\Party\bChangePorcS.jpg")
    Set fotosS(6) = LoadPicture(App.Path & "\Graficos\Button\Party\bRemovePartyS.jpg")
    Set fotosS(7) = LoadPicture(App.Path & "\Graficos\Button\Party\bAcceptPartyS.jpg")


    Set fotosOFF(1) = LoadPicture(App.Path & "\Graficos\Button\Party\bCreateParty.jpg")
    Set fotosOFF(2) = LoadPicture(App.Path & "\Graficos\Button\Party\bQuitParty.jpg")
    Set fotosOFF(3) = LoadPicture(App.Path & "\Graficos\Button\Party\bRejectPartyN.jpg")
    Set fotosOFF(5) = LoadPicture(App.Path & "\Graficos\Button\Party\bChangePorcN.jpg")
    Set fotosOFF(6) = LoadPicture(App.Path & "\Graficos\Button\Party\bRemovePartyN.jpg")
    Set fotosOFF(7) = LoadPicture(App.Path & "\Graficos\Button\Party\bAcceptPartyN.jpg")

End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    boton(1).Picture = fotosON(1)
    boton(2).Picture = fotosON(2)
    If boton(3).Enabled = True Then
        boton(3).Picture = fotosON(3)
    Else
        boton(3).Picture = fotosOFF(3)
    End If
    If boton(5).Enabled = True Then
        boton(5).Picture = fotosON(5)
    Else
        boton(5).Picture = fotosOFF(5)
    End If
    If boton(6).Enabled = True Then
        boton(6).Picture = fotosOFF(6)
    Else
        boton(6).Picture = fotosOFF(6)
    End If
    If boton(7).Enabled = True Then
        boton(7).Picture = fotosON(7)
    Else
        boton(7).Picture = fotosOFF(7)
    End If
End Sub

Private Sub Label1_Click()

    Call Unload(Me)

    Call frmMain.SetFocus

End Sub


Private Sub Label6_Click()

    If (Label6.Caption = ">>") Then
        Label6.Caption = "<<"
        List1.visible = True
        List2.visible = True
        Label2.visible = True
        Label3.visible = True
        Frame1.visible = False
    Else
        Label6.Caption = ">>"
        List1.visible = False
        List2.visible = False
        Label2.visible = False
        Label3.visible = False
        Frame1.visible = True
    End If

End Sub

