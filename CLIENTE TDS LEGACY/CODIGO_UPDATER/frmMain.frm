VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form frmMain 
   BackColor       =   &H000040C0&
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "AutoUpdater TDSL 2.0"
   ClientHeight    =   3675
   ClientLeft      =   -15
   ClientTop       =   225
   ClientWidth     =   6105
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmMain.frx":27A2
   ScaleHeight     =   3675
   ScaleWidth      =   6105
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox Picture1 
      BorderStyle     =   0  'None
      Height          =   255
      Left            =   720
      Picture         =   "frmMain.frx":4C4DC
      ScaleHeight     =   255
      ScaleWidth      =   3135
      TabIndex        =   5
      Top             =   3110
      Width           =   3135
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   1200
      Left            =   2565
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   3765
      Width           =   6720
      _ExtentX        =   11853
      _ExtentY        =   2117
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      ReadOnly        =   -1  'True
      ScrollBars      =   1
      Appearance      =   0
      TextRTF         =   $"frmMain.frx":4EED2
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   3855
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      RequestTimeout  =   240
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Buscando actualizaciones"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   900
      TabIndex        =   3
      Top             =   2715
      Visible         =   0   'False
      Width           =   3015
   End
   Begin VB.Label LSize 
      BackStyle       =   0  'Transparent
      Caption         =   "0 MBs de 0 MBs"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   900
      TabIndex        =   1
      Top             =   2550
      Visible         =   0   'False
      Width           =   3015
   End
   Begin VB.Label LSize_Sombra 
      BackStyle       =   0  'Transparent
      Caption         =   "0 MBs de 0 MBs"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   255
      Left            =   915
      TabIndex        =   2
      Top             =   2565
      Visible         =   0   'False
      Width           =   3015
   End
   Begin VB.Label Label1_Sombra 
      BackStyle       =   0  'Transparent
      Caption         =   "Buscando actualizaciones"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00404040&
      Height          =   255
      Left            =   915
      TabIndex        =   4
      Top             =   2730
      Visible         =   0   'False
      Width           =   3015
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const GWL_EXSTYLE = -20
Private Const WS_EX_LAYERED = &H80000
Private Const WS_EX_TRANSPARENT As Long = &H20&
Dim Directorio As String, bDone As Boolean, dError As Boolean, F As Variant
Attribute bDone.VB_VarUserMemId = 1073938432
Attribute dError.VB_VarUserMemId = 1073938432
Attribute F.VB_VarUserMemId = 1073938432
Private VALOR As Variant
Attribute VALOR.VB_VarUserMemId = 1073938436
Private MAX As Variant
Attribute MAX.VB_VarUserMemId = 1073938437
Private clientMd5 As String
Attribute clientMd5.VB_VarUserMemId = 1073938438
Private clientMd5F As String
Attribute clientMd5F.VB_VarUserMemId = 1073938439
Private webMD5 As String
Attribute webMD5.VB_VarUserMemId = 1073938440
Private webMD5F As String
Attribute webMD5F.VB_VarUserMemId = 1073938441

Private Sub AnalizarEXE()

    Dim MD5 As New clsMD5
    Call addConsole("Verificando si hay cliente nuevo", 255, 255, 255, True, False)

    webMD5 = Inet1.OpenURL("http://tdslegacy.store/updater/verexe_cliente.txt")

    Label1.Caption = "Verificando ejecutable.."
    Label1_Sombra.Caption = Label1.Caption

    If Not FileExist(App.Path & "/TDSL.exe", vbArchive) Then
        GoTo DownloadClient
    End If

    clientMd5 = GetFileMD5(App.Path & "/TDSL.exe")
    Debug.Print clientMd5

    If webMD5 = vbNullString Or Len(webMD5) > 33 Or Len(webMD5) < 20 Then
        Call addConsole("ERROR: No se pudo revisar si hay cliente nuevo!.", 255, 2, 2, True, False)
        GoTo Finish
    ElseIf Len(clientMd5) <> 32 Then
        Call addConsole("ERROR: No se pudo verificar la integridad del cliente!.", 255, 2, 2, True, False)
        GoTo Finish
    Else

        webMD5 = Left(webMD5, 32)
        clientMd5 = Left(clientMd5, 32)

        Call addConsole("Comprobando integridad del cliente.", 255, 255, 0, True, False, 1)

        If StrComp(webMD5, clientMd5) <> 0 Then
            Call addConsole(" -> Listo", 1, 255, 1, True, False)
            GoTo DownloadClient
        Else
            Call addConsole(" -> Listo", 1, 255, 1, True, False)
            GoTo Finish
        End If

    End If

DownloadClient:
    Label1.Visible = True

    Call addConsole("Descargando ejecutable", 200, 200, 200, True, False)
    Inet1.AccessType = icUseDefault
    Inet1.URL = "http://tdslegacy.store/updater/TDSL.zip"

    Directorio = App.Path & "\TDSL.zip"

    If FileExist(Directorio, vbArchive) Then Kill Directorio

    bDone = False
    dError = False
    frmMain.Inet1.Execute , "GET"
    Do While bDone = False
        DoEvents
    Loop
    If dError Then Exit Sub

    Call BuscarTDSL
    UnZip Directorio, App.Path & "\"
    Kill Directorio

Finish:
    Call addConsole("Proceso de comprobación del cliente terminado.", 255, 255, 0, True, False)
    Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", Chr(109) & Chr(100) & Chr(53) & "f", clientMd5)
    VALOR = 0

End Sub

Private Sub AnalizarEXE_FACIL()

    Dim MD5 As New clsMD5
    Call addConsole("Verificando si hay cliente nuevo", 255, 255, 255, True, False)

    webMD5F = Inet1.OpenURL("http://tdslegacy.store/updater/verexe_cliente_facil.txt")

    Label1.Caption = "Verificando ejecutable facil.."
    Label1_Sombra.Caption = Label1.Caption

    If Not FileExist(App.Path & "/TDSLF.exe", vbArchive) Then
        GoTo DownloadClient
    End If

    clientMd5 = GetFileMD5(App.Path & "/TDSLF.exe")
    Debug.Print clientMd5F

    If webMD5F = vbNullString Or Len(webMD5F) > 33 Or Len(webMD5F) < 20 Then
        Call addConsole("ERROR: No se pudo revisar si hay cliente facil nuevo!.", 255, 2, 2, True, False)
        GoTo Finish
    ElseIf Len(clientMd5F) <> 32 Then
        Call addConsole("ERROR: No se pudo verificar la integridad del cliente facil!.", 255, 2, 2, True, False)
        GoTo Finish
    Else

        webMD5F = Left(webMD5F, 32)
        clientMd5F = Left(clientMd5F, 32)

        Call addConsole("Comprobando integridad del cliente facil.", 255, 255, 0, True, False, 1)

        If StrComp(webMD5F, clientMd5F) <> 0 Then
            Call addConsole(" -> Listo", 1, 255, 1, True, False)
            GoTo DownloadClient
        Else
            Call addConsole(" -> Listo", 1, 255, 1, True, False)
            GoTo Finish
        End If

    End If

DownloadClient:
    Label1.Visible = True

    Call addConsole("Descargando ejecutable", 200, 200, 200, True, False)
    Inet1.AccessType = icUseDefault
    Inet1.URL = "http://tdslegacy.store/updater/TDSLF.zip"

    Directorio = App.Path & "\TDSLF.zip"

    If FileExist(Directorio, vbArchive) Then Kill Directorio

    bDone = False
    dError = False
    frmMain.Inet1.Execute , "GET"
    Do While bDone = False
        DoEvents
    Loop
    If dError Then Exit Sub

    Call BuscarTDSL
    UnZip Directorio, App.Path & "\"
    Kill Directorio

Finish:
    Call addConsole("Proceso de comprobación del cliente facil terminado.", 255, 255, 0, True, False)
    Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", Chr(109) & Chr(100) & Chr(53) & "f", clientMd5F)
    VALOR = 0

End Sub


Public Function GetFileMD5(ByVal FileName As String) As String
    Dim MD5 As New clsMD5, FF As Integer, Buff() As Byte
    Const BuffSize As Long = 65536    ' (64 KBytes)

    On Error GoTo ErrExit
    FF = FreeFile
    Open FileName For Binary Access Read As FF
    MD5.MD5Init

    Do Until Loc(FF) >= LOF(FF)
        If Loc(FF) + BuffSize > LOF(FF) Then
            ReDim Buff(LOF(FF) - Loc(FF) - 1)
        Else
            ReDim Buff(BuffSize - 1)
        End If

        Get FF, , Buff
        MD5.MD5Update UBound(Buff) + 1, Buff
    Loop

    MD5.MD5Final
    GetFileMD5 = MD5.GetValues
    Close FF

    Exit Function
ErrExit:
    Err.Clear
    GetFileMD5 = ""
End Function

Private Sub Analizar()

    Dim update As Boolean

    Dim i As Integer, iX As String, tx As Integer, DifX As Integer, dNum As String

    Call addConsole("Accediendo a: Update.ini de la carpeta INIT", 255, 255, 255, True, False, 1)

    tx = LeerInt(App.Path & "\INIT\Update.ini")

    Call addConsole(" -> Listo", 1, 255, 1, True, False)

    On Error GoTo StStS

    Call addConsole("Verificando si hay parches nuevos", 255, 255, 255, True, False, 1)

    iX = Inet1.OpenURL("http://tdslegacy.store/updater/verexe.txt")

    If iX = vbNullString Then
        Call addConsole("ERROR: No se pudo revisar si hay parches nuevos!.", 255, 2, 2, True, False)

        If MsgBox("No se pudo acceder a la web, desea jugar de todos modos?", vbYesNo) = vbYes Then
            If FileExist(App.Path & "/TDSL.exe", vbArchive) Then
                Call ShellExecute(Me.hwnd, "open", App.Path & "/TDSL.exe", "", "", 0)
            End If

            End
        Else
            End
        End If
    End If

    Call addConsole(" -> Listo", 1, 255, 1, True, False)

    DifX = iX - tx

    iX = Val(iX)

    If iX < tx Then
        Call GuardarInt(App.Path & "/INIT/Update.ini", "0")
        iX = 0
        tx = 0
        Call addConsole("Se encontró una incoherencia, se ha reseteado las actualizaciones...", 255, 255, 255, True, False)
        Call Analizar
        Exit Sub
    End If

StStS:

    If LenB(Inet1.OpenURL("http://tdslegacy.store/updater/verexe.txt")) > 4 Then
        Call addConsole("ERROR: No se encontró el archivo para el updater", 255, 2, 2, True, False)
        DifX = 0

        If MsgBox("No se pudo actualizar el cliente, desea jugar de todos modos?", vbYesNo) = vbYes Then
            Call ShellExecute(Me.hwnd, "open", App.Path & "/TDSL.exe", "", "", 1)
            End
        Else
            End
        End If
    End If

    If Not (DifX = 0) Then
        update = True
        Label1.Visible = True

        Call addConsole("Iniciando, se descargarán " & DifX & " actualizaciones.", 200, 200, 200, True, False)   '>> Informacion
        For i = 1 To DifX
            Inet1.AccessType = icUseDefault
            dNum = i + tx

            #If BuscarLinks Then    'Buscamos el link en el host (1)
                Inet1.URL = Inet1.OpenURL("http://tdslegacy.store/updater/" & dNum & ".txt")    'Host
            #Else                'Generamos Link por defecto (0)
                Inet1.URL = "http://tdslegacy.store/updater/" & dNum & ".zip"    'Host
            #End If


            Directorio = App.Path & "\INIT\" & dNum & ".zip"

            If FileExist(Directorio, vbArchive) Then
                Kill Directorio
            End If

            bDone = False
            dError = False
            frmMain.Inet1.Execute , "GET"
            Do While bDone = False
                DoEvents
            Loop
            If dError Then Exit Sub
            UnZip Directorio, App.Path & "\"
            Kill Directorio
            Call GuardarInt(App.Path & "\INIT\Update.ini", dNum)

        Next i

        If Err.Number = 0 Then
            Call GuardarInt(App.Path & "\INIT\Update.ini", iX)
            Call addConsole("Se han descargado y aplicado todas las actualizaciones.", 255, 255, 0, True, False)
        End If
    End If

    Call addConsole("Proceso de actualización terminado correctamente.", 255, 255, 0, True, False)

    VALOR = 0

    Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", Chr(109) & Chr(100) & Chr(53), webMD5)
    Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", Chr(109) & Chr(100) & Chr(53) & "f", webMD5F)

    If webMD5 = "" Or webMD5F = "" Then
        MsgBox ("Reportar al admin, no se pudo obtener la información de TDSL.exe")
    End If

    If MsgBox("La descarga se realizó exitosamente. ¿Desea ejecutar TDS Legacy ahora mismo?", vbYesNo, "TDSLegacy 07 - AutoUpdater") = vbYes Then
        Call ShellExecute(Me.hwnd, "open", App.Path & "/TDSL.exe", "", "", 1)
        End
    Else
        End
    End If

End Sub

Private Sub Form_Activate()

    RichTextBox1.Text = ""

    Call AnalizarEXE
    Call AnalizarEXE_FACIL
    Call Analizar

End Sub

Private Sub Form_Load()
    VALOR = 0
End Sub

Private Sub Inet1_StateChanged(ByVal State As Integer)
    On Error GoTo errHandler

    Select Case State
    Case icError
        Call addConsole(" Error en la conexión, descarga abortada.", 255, 0, 0, True, False)
        bDone = True
        dError = True
    Case icResponseCompleted
        Dim vtData As Variant
        Dim tempArray() As Byte
        Dim FileSize As Long

        FileSize = Inet1.GetHeader("Content-length")
        MAX = FileSize

        Call addConsole("Descarga iniciada.", 0, 255, 0, True, False)

        Open Directorio For Binary Access Write As #1
        vtData = Inet1.GetChunk(1024, icByteArray)
        DoEvents

        Do While Not Len(vtData) = 0
            tempArray = vtData
            Put #1, , tempArray

            vtData = Inet1.GetChunk(1024, icByteArray)

            VALOR = VALOR + Len(vtData) * 2
            LSize.Caption = (VALOR + Len(vtData) * 2) / 1000000 & "MBs de " & (FileSize / 1000000) & "MBs"

            If MAX > 0 Then
                Label1.Caption = "[" & CLng((VALOR * 100) / MAX) & "% Completado.]"
                Picture1.Width = CLng(((VALOR / 100) / (MAX / 100)) * 3135)
            End If

            DoEvents
        Loop
        Close #1

        Call addConsole("Descarga finalizada", 0, 255, 0, True, False)
        LSize.Caption = FileSize & " bytes"
        VALOR = 0

        bDone = True
    End Select
    Exit Sub
errHandler:
    bDone = False

    Call addConsole("Actualizacion cancelada, no se encontró el parche, notifique a un Administrador.", 255, 1, 0, True, False)
    LSize.Caption = 0 & " bytes"
    VALOR = 0

End Sub

Private Function LeerInt(ByVal Ruta As String) As Integer
    F = FreeFile
    Open Ruta For Input As F
    LeerInt = Input$(LOF(F), #F)
    Close #F
End Function

Private Sub GuardarInt(ByVal Ruta As String, ByVal data As Integer)
    F = FreeFile
    Open Ruta For Output As F
    Print #F, data
    Close #F
End Sub
