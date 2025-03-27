VERSION 5.00
Begin VB.Form frmLibrerias 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   ClientHeight    =   4425
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4950
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   4950
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer 
      Interval        =   100
      Left            =   3120
      Top             =   2430
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "MSSTDFMTD.DLL"
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
      Height          =   255
      Index           =   10
      Left            =   660
      TabIndex        =   11
      Top             =   2895
      Width           =   1950
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "MSWINSCK.OCX"
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
      Height          =   255
      Index           =   9
      Left            =   750
      TabIndex        =   10
      Top             =   2670
      Width           =   1950
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "VBALPROGBAR6.OCX"
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
      Height          =   255
      Index           =   8
      Left            =   585
      TabIndex        =   9
      Top             =   2430
      Width           =   1950
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "CSWSK32.OCX"
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
      Height          =   255
      Index           =   7
      Left            =   795
      TabIndex        =   8
      Top             =   2250
      Width           =   1410
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "MSINET.OCX"
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
      Height          =   255
      Index           =   6
      Left            =   915
      TabIndex        =   7
      Top             =   2025
      Width           =   1125
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "DAO350.dll"
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
      Height          =   255
      Index           =   5
      Left            =   1035
      TabIndex        =   6
      Top             =   1800
      Width           =   1125
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "DX8VB.DLL"
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
      Height          =   255
      Index           =   0
      Left            =   1050
      TabIndex        =   5
      Top             =   630
      Width           =   1005
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "RICHTX32.OCX"
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
      Height          =   255
      Index           =   1
      Left            =   870
      TabIndex        =   1
      Top             =   885
      Width           =   1365
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "MSCOMCTL.OCX"
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
      Height          =   255
      Index           =   2
      Left            =   840
      TabIndex        =   4
      Top             =   1155
      Width           =   1515
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "COMDLG32.OCX"
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
      Height          =   255
      Index           =   3
      Left            =   825
      TabIndex        =   3
      Top             =   1380
      Width           =   1425
   End
   Begin VB.Label LblName 
      Alignment       =   2  'Center
      BackColor       =   &H80000007&
      Caption         =   "Registrador"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   345
      Left            =   60
      TabIndex        =   2
      Top             =   90
      Width           =   2835
   End
   Begin VB.Label Label 
      BackStyle       =   0  'Transparent
      Caption         =   "MSINET.OCX"
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
      Height          =   255
      Index           =   4
      Left            =   975
      TabIndex        =   0
      Top             =   1605
      Width           =   1125
   End
End
Attribute VB_Name = "frmLibrerias"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Timer_Timer()

    Dim LoopC As Long, Count As Byte, StrFailed As String

    For LoopC = 0 To Label.UBound
        If RegisterDLLorOCX(Label(LoopC).Caption) Then
            Label(LoopC).ForeColor = vbGreen
            Count = Count + 1
        Else
            Label(LoopC).ForeColor = vbRed
            StrFailed = StrFailed & Label(LoopC).Caption & ", "
        End If

        DoEvents
    Next LoopC

    Timer.Enabled = False

    If Count > Label.UBound Then
        MsgBox "Liberias registradas."
        Unload Me

    Else
        Call MsgBox("Falto registrar la libreria " & StrFailed & vbNewLine & "Porfavor ejecuta este programa como administrador.")
    End If

    End

End Sub

