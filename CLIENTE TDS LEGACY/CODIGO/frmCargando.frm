VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "msinet.ocx"
Begin VB.Form frmCargando 
   AutoRedraw      =   -1  'True
   BorderStyle     =   0  'None
   Caption         =   "Cargando TDS Legacy"
   ClientHeight    =   7995
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7995
   ScaleWidth      =   12000
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   11055
      Top             =   6225
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      RequestTimeout  =   20
   End
   Begin VB.Timer tmrReload 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   1905
      Top             =   6405
   End
   Begin VB.Image BarraCargando 
      Appearance      =   0  'Flat
      Height          =   405
      Left            =   810
      Picture         =   "frmCargando.frx":0000
      Top             =   4290
      Width           =   9960
   End
End
Attribute VB_Name = "frmCargando"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private NextWidth As Integer
Public ActualWidth As Integer

Public Sub NewPercentage(ByVal Porc As Byte)
    ActualWidth = Round(Porc / 100 * 9960)        ' @@ Cuicui: quien hizo ésta negrada asjdjasjdasjdas
    SetBarWidth

    If Porc = 100 Then
        Sleep 200
        Unload Me
    End If

End Sub

Private Sub SetBarWidth()
    BarraCargando.Width = ActualWidth
End Sub

Private Sub SubirWidth()
    If NextWidth > ActualWidth Then
        ActualWidth = ActualWidth + Round(35 / 100 * 9960)
        SetBarWidth
    End If

    NextWidth = ActualWidth + Round(35 / 100 * 9960)
    If ActualWidth >= 9960 Then
        tmrReload.Enabled = False

        If UserCharIndex = 0 Then frmConnect.Show

        CambiandoRes = False
        Unload Me
    End If
End Sub

Private Sub Form_Load()

    Call forms_load_pic(Me, "12176.bmp")

    BarraCargando.Width = 10

    port = 7666

    IP = "127.0.0.1" '"tdslegacy.ddns.net"

End Sub

Private Sub Inet1_StateChanged(ByVal State As Integer)
    On Error GoTo ErrHandler

    Select Case State
    Case icError
        MsgBox "Error en la conexión, descarga abortada."    '
        mod_updater.bDone = True
        dError = True
    Case icResponseCompleted
        Dim vtData As Variant
        Dim tempArray() As Byte
        Dim FileSize As Long

        FileSize = Inet1.GetHeader("Content-length")

        Open directorio For Binary Access Write As #1
        vtData = frmCargando.Inet1.GetChunk(1024, icByteArray)
        DoEvents

        Do While Not Len(vtData) = 0
            tempArray = vtData
            Put #1, , tempArray

            vtData = frmCargando.Inet1.GetChunk(1024, icByteArray)

            DoEvents
        Loop
        Close #1

        bDone = True
    End Select
    Exit Sub
ErrHandler:
    bDone = False
End Sub

Private Sub tmrReload_Timer()
    SubirWidth
End Sub
