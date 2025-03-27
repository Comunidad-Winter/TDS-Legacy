Attribute VB_Name = "GameIni"
Option Explicit

Private Type NMHDR
    hWndFrom As Long
    idFrom As Long
    code As Long
End Type

Private Type CHARRANGE
    cpMin As Long
    cpMax As Long
End Type

Private Type ENLINK
    hdr As NMHDR
    msg As Long
    wParam As Long
    lParam As Long
    chrg As CHARRANGE
End Type

Private Type TEXTRANGE
    chrg As CHARRANGE
    lpstrText As String
End Type

Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" _
                                       (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" _
                                        (ByVal lpPrevWndFunc As Long, ByVal hwnd As Long, ByVal msg As Long, _
                                         ByVal wParam As Long, ByVal lParam As Long) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
                                    (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" _
                               (destination As Any, source As Any, ByVal Length As Long)
Private Declare Function ShellExecute Lib "shell32" Alias "ShellExecuteA" _
                                      (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, _
                                       ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Private Const WM_NOTIFY = &H4E
Private Const EM_SETEVENTMASK = &H445
Private Const EM_GETEVENTMASK = &H43B
Private Const EM_GETTEXTRANGE = &H44B
Private Const EM_AUTOURLDETECT = &H45B
Private Const EN_LINK = &H70B
Private Const WM_LBUTTONDOWN = &H201

Private Const ENM_LINK = &H4000000
Private Const GWL_WNDPROC = (-4)
Private Const SW_SHOW = 5

Private lOldProc As Long
Private hWndRTB As Long
Private hWndParent As Long

Public Type tCabecera        'Cabecera de los con
    Desc As String * 255
    CRC As Long
    MagicWord As Long
End Type


Public Type tSetupMods
    bDinamic As Boolean
    byMemory As Byte
    bUseVideo As Boolean
    bNoMusic As Boolean
    bNoSound As Boolean
    bNoRes As Boolean        ' 24/06/2006 - ^[GS]^
    bNoSoundEffects As Boolean
    sGraficos As String * 13
    bGuildNews As Boolean
    bGldMsgConsole As Boolean
    bCantMsgs As Byte

    NotHablaMovement As Byte
End Type

Public ClientSetup As tSetupMods

Public MiCabecera As tCabecera

Private File As String


Public Enum FontTypeNames
    FONTTYPE_TALK
    FONTTYPE_FIGHT
    FONTTYPE_WARNING
    FONTTYPE_INFO
    FONTTYPE_INFOBOLD
    FONTTYPE_EJECUCION
    FONTTYPE_PARTY
    FONTTYPE_VENENO
    FONTTYPE_GUILD
    FONTTYPE_SERVER
    FONTTYPE_GUILDMSG
    FONTTYPE_CONSEJO
    FONTTYPE_CONSEJOCAOS
    FONTTYPE_CONSEJOVesA
    FONTTYPE_CONSEJOCAOSVesA
    FONTTYPE_CENTINELA
    FONTTYPE_GMMSG
    FONTTYPE_GM
    FONTTYPE_CITIZEN
    FONTTYPE_CONSE
    FONTTYPE_DIOS
    FONTTYPE_ADMIN
    FONTTYPE_GLOBAL
    FONTTYPE_APU

    FONTTYPE_EVENTOS
    FONTTYPE_NARANJA
    FONTTYPE_VERDE
    FONTTYPE_BORDO
    FONTTYPE_MARRON
    FONTTYPE_AMARILLO
    FONTTYPE_VIOLETA
End Enum

Private Type tFont
    red As Byte
    green As Byte
    blue As Byte
    bold As Boolean
    italic As Boolean
End Type

Public FontTypes(30) As tFont

Public Sub InitFonts()

    With FontTypes(FontTypeNames.FONTTYPE_ADMIN)
        .red = 255
        .green = 150
        .blue = 15
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_APU)
        .red = 230
        .green = 225
        .blue = 150
        .bold = 1
    End With
    
    With FontTypes(FontTypeNames.FONTTYPE_EVENTOS)
        .red = 255
        .green = 128
        .blue = 0
        .bold = 1
    End With
    
    With FontTypes(FontTypeNames.FONTTYPE_GLOBAL)
        .red = 126
        .green = 126
        .blue = 126
        .bold = 0
    End With

    With FontTypes(FontTypeNames.FONTTYPE_TALK)
        .red = 255
        .green = 255
        .blue = 255
    End With

    With FontTypes(FontTypeNames.FONTTYPE_FIGHT)
        .red = 255
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_WARNING)
        .red = 32
        .green = 51
        .blue = 223
        .bold = 1
        .italic = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_INFO)
        .red = 65
        .green = 190
        .blue = 156
    End With

    With FontTypes(FontTypeNames.FONTTYPE_INFOBOLD)
        .red = 65
        .green = 190
        .blue = 156
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_EJECUCION)
        .red = 185
        .green = 185
        .blue = 185
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_PARTY)
        .red = 255
        .green = 180
        .blue = 250
    End With

    FontTypes(FontTypeNames.FONTTYPE_VENENO).green = 255

    With FontTypes(FontTypeNames.FONTTYPE_GUILD)
        .red = 255
        .green = 255
        .blue = 255
        .bold = 1
    End With

    FontTypes(FontTypeNames.FONTTYPE_SERVER).green = 185

    With FontTypes(FontTypeNames.FONTTYPE_GUILDMSG)
        .red = 228
        .green = 199
        .blue = 27
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CONSEJO)
        .red = 130
        .green = 130
        .blue = 255
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CONSEJOCAOS)
        .red = 255
        .green = 60
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CONSEJOVesA)
        .green = 200
        .blue = 255
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CONSEJOCAOSVesA)
        .red = 255
        .green = 50
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CENTINELA)
        .green = 255
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_GMMSG)
        .red = 255
        .green = 255
        .blue = 255
        .italic = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_GM)
        .red = 30
        .green = 255
        .blue = 30
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CITIZEN)
        .blue = 200

        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_CONSE)
        .red = 30
        .green = 150
        .blue = 30
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_DIOS)
        .red = 250
        .green = 250
        .blue = 150
        .bold = 1
    End With


    With FontTypes(FontTypeNames.FONTTYPE_NARANJA)
        .red = 255
        .green = 128
        .blue = 0
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_VERDE)
        .red = 0
        .green = 255
        .blue = 0
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_BORDO)
        .red = 95
        .green = 2
        .blue = 31
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_MARRON)
        .red = 183
        .green = 117
        .blue = 81
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_AMARILLO)
        .red = 245
        .green = 245
        .blue = 1
        .bold = 1
    End With

    With FontTypes(FontTypeNames.FONTTYPE_VIOLETA)
        .red = 213
        .green = 14
        .blue = 241
        .bold = 1
    End With
End Sub

Sub CargarCabezas()
    Dim n As Integer
    Dim i As Long
    Dim Numheads As Integer
    Dim Miscabezas() As tIndiceCabeza


    File = Get_FileFrom(Scripts, "Cabezas.ind")


    n = FreeFile()
    Open File For Binary Access Read As #n

    'cabecera
    Get #n, , MiCabecera

    'num de cabezas
    Get #n, , Numheads

    'Resize array
    ReDim HeadData(0 To Numheads) As HeadData
    ReDim Miscabezas(0 To Numheads) As tIndiceCabeza

    For i = 1 To Numheads
        Get #n, , Miscabezas(i)

        If Miscabezas(i).Head(1) Then
            Call InitGrh(HeadData(i).Head(1), Miscabezas(i).Head(1), 0)
            Call InitGrh(HeadData(i).Head(2), Miscabezas(i).Head(2), 0)
            Call InitGrh(HeadData(i).Head(3), Miscabezas(i).Head(3), 0)
            If i = 501 Then        ' @@ Cuicui : NO SE POR QUE NO SE ACTUALIZA DIOSSSSS
                Call InitGrh(HeadData(i).Head(4), 12002, 0)
            Else
                Call InitGrh(HeadData(i).Head(4), Miscabezas(i).Head(4), 0)
            End If
        End If
    Next i

    Close #n
    Delete_File File



End Sub

Sub CargarCascos()
    Dim n As Integer
    Dim i As Long
    Dim NumCascos As Integer

    Dim Miscabezas() As tIndiceCabeza

    n = FreeFile()
    File = Get_FileFrom(Scripts, "Cascos.ind")

    Open File For Binary Access Read As #n
    'cabecera
    Get #n, , MiCabecera

    'num de cabezas
    Get #n, , NumCascos

    'Resize array
    ReDim CascoAnimData(0 To NumCascos) As HeadData
    ReDim Miscabezas(0 To NumCascos) As tIndiceCabeza

    For i = 1 To NumCascos
        Get #n, , Miscabezas(i)

        If Miscabezas(i).Head(1) Then
            Call InitGrh(CascoAnimData(i).Head(1), Miscabezas(i).Head(1), 0)
            Call InitGrh(CascoAnimData(i).Head(2), Miscabezas(i).Head(2), 0)
            Call InitGrh(CascoAnimData(i).Head(3), Miscabezas(i).Head(3), 0)
            Call InitGrh(CascoAnimData(i).Head(4), Miscabezas(i).Head(4), 0)
        End If
    Next i

    Close #n

    Delete_File (File)
End Sub

Sub CargarCuerpos()
    Dim n As Integer
    Dim i As Long
    Dim NumCuerpos As Integer
    Dim MisCuerpos() As tIndiceCuerpo

    n = FreeFile()
    File = Get_FileFrom(Scripts, "Personajes.ind")

    Open File For Binary Access Read As #n
    'cabecera
    Get #n, , MiCabecera

    'num de cabezas
    Get #n, , NumCuerpos

    'Resize array
    ReDim BodyData(0 To NumCuerpos) As BodyData
    ReDim MisCuerpos(0 To NumCuerpos) As tIndiceCuerpo

    For i = 1 To NumCuerpos
        Get #n, , MisCuerpos(i)

        If MisCuerpos(i).Body(1) Then
            InitGrh BodyData(i).Walk(1), MisCuerpos(i).Body(1), 0
            InitGrh BodyData(i).Walk(2), MisCuerpos(i).Body(2), 0
            InitGrh BodyData(i).Walk(3), MisCuerpos(i).Body(3), 0
            InitGrh BodyData(i).Walk(4), MisCuerpos(i).Body(4), 0

            BodyData(i).HeadOffset.X = MisCuerpos(i).HeadOffsetX
            BodyData(i).HeadOffset.Y = MisCuerpos(i).HeadOffsetY
        End If
    Next i

    Close #n
    Delete_File File
End Sub

Sub CargarFxs()
    Dim n As Integer
    Dim i As Long
    Dim NumFxs As Integer

    n = FreeFile()
    File = Get_FileFrom(Scripts, "Fxs.ind")
    Open File For Binary Access Read As #n

    'cabecera
    Get #n, , MiCabecera

    'num de cabezas
    Get #n, , NumFxs

    'Resize array
    ReDim FxData(1 To NumFxs) As tIndiceFx
    ReDim FxGrh(1 To NumFxs) As Grh
    For i = 1 To NumFxs
        Get #n, , FxData(i)
    Next i

    Close #n
    Delete_File File
End Sub

Sub CargarArrayLluvia()
    Dim n As Integer
    Dim i As Long
    Dim Nu As Integer

    n = FreeFile()
    File = Get_FileFrom(Scripts, "fk.ind")
    Open File For Binary Access Read As #n

    'cabecera
    Get #n, , MiCabecera

    'num de cabezas
    Get #n, , Nu

    'Resize array
    ReDim bLluvia(1 To Nu) As Byte

    For i = 1 To Nu
        Get #n, , bLluvia(i)
    Next i

    Close #n
    Delete_File File
End Sub

Sub CargarAnimArmas()
    On Error Resume Next

    Dim LoopC As Long
    Dim Archivo As String
    Dim Leer As New clsIniReader

    File = Get_FileFrom(Scripts, "Armas.dat")
    Archivo = File
    Leer.Initialize Archivo
    NumWeaponAnims = Val(GetVar(Archivo, "INIT", "NumArmas"))

    ReDim WeaponAnimData(1 To NumWeaponAnims) As WeaponAnimData

    For LoopC = 1 To NumWeaponAnims
        InitGrh WeaponAnimData(LoopC).WeaponWalk(1), Val(GetVar(Archivo, "ARMA" & LoopC, "Dir1")), 0
        InitGrh WeaponAnimData(LoopC).WeaponWalk(2), Val(GetVar(Archivo, "ARMA" & LoopC, "Dir2")), 0
        InitGrh WeaponAnimData(LoopC).WeaponWalk(3), Val(GetVar(Archivo, "ARMA" & LoopC, "Dir3")), 0
        InitGrh WeaponAnimData(LoopC).WeaponWalk(4), Val(GetVar(Archivo, "ARMA" & LoopC, "Dir4")), 0
    Next LoopC

    Delete_File File
End Sub



Sub CargarColores()
    On Error Resume Next
    Dim ArchivoC As String
    Dim Leer As New clsIniReader

    File = Get_FileFrom(Scripts, "colores.dat")
    ArchivoC = File
    Leer.Initialize ArchivoC

    If Not FileExist(ArchivoC, vbArchive) Then
        Call MsgBox("ERROR: Reinstale el cliente!", vbCritical + vbOKOnly)
        Exit Sub
    End If

    Dim i As Long

    For i = LBound(ColoresPJ) To UBound(ColoresPJ)
        ColoresPJ(i).r = CByte(GetVar(ArchivoC, CStr(i), "R"))
        ColoresPJ(i).g = CByte(GetVar(ArchivoC, CStr(i), "G"))
        ColoresPJ(i).b = CByte(GetVar(ArchivoC, CStr(i), "B"))
    Next i

    Delete_File File
End Sub

Sub CargarAnimEscudos()
    Dim i As Integer
    Dim Archivo As String
    Dim Leer As New clsIniReader

    'Escudos
    File = Get_FileFrom(Scripts, "escudos.dat")
    Archivo = File

    Leer.Initialize Archivo

    NumEscudosAnims = Val(Leer.GetValue("INIT", "NumEscudos"))

    ReDim ShieldAnimData(1 To NumEscudosAnims) As ShieldAnimData
    For i = 1 To NumEscudosAnims
        InitGrh ShieldAnimData(i).ShieldWalk(1), Val(Leer.GetValue("ESC" & i, "Dir1")), 0
        InitGrh ShieldAnimData(i).ShieldWalk(2), Val(Leer.GetValue("ESC" & i, "Dir2")), 0
        InitGrh ShieldAnimData(i).ShieldWalk(3), Val(Leer.GetValue("ESC" & i, "Dir3")), 0
        InitGrh ShieldAnimData(i).ShieldWalk(4), Val(Leer.GetValue("ESC" & i, "Dir4")), 0
    Next i
    Delete_File File

End Sub

Public Sub IniciarCabecera(ByRef Cabecera As tCabecera)
    Cabecera.Desc = "Argentum Online by Noland Studios. Copyright Noland-Studios 2001, pablomarquez@noland-studios.com.ar"
    Cabecera.CRC = Rnd * 100
    Cabecera.MagicWord = Rnd * 10
End Sub

Public Sub EnableURLDetect(ByVal hWndRichTextbox As Long, ByVal hWndOwner As Long)

    SendMessage hWndRichTextbox, EM_SETEVENTMASK, 0, ByVal ENM_LINK Or SendMessage(hWndRichTextbox, EM_GETEVENTMASK, 0, 0)
    SendMessage hWndRichTextbox, EM_AUTOURLDETECT, 1, ByVal 0

    hWndParent = hWndOwner
    hWndRTB = hWndRichTextbox
End Sub

Public Sub DisableURLDetect()

    SendMessage hWndRTB, EM_AUTOURLDETECT, 0, ByVal 0
    StopCheckingLinks
End Sub

Public Sub StartCheckingLinks()

    If lOldProc = 0 Then
        lOldProc = SetWindowLong(hWndParent, GWL_WNDPROC, AddressOf WndProc)
    End If
End Sub

Public Sub StopCheckingLinks()

    If lOldProc Then
        SetWindowLong hWndParent, GWL_WNDPROC, lOldProc
        lOldProc = 0
    End If
End Sub

Public Function WndProc(ByVal hwnd As Long, ByVal uMsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long

    Dim uHead As NMHDR
    Dim eLink As ENLINK
    Dim eText As TEXTRANGE
    Dim sText As String
    Dim lLen As Long

    If uMsg = WM_NOTIFY Then
        CopyMemory uHead, ByVal lParam, Len(uHead)
        If (uHead.hWndFrom = hWndRTB) And (uHead.code = EN_LINK) Then
            CopyMemory eLink, ByVal lParam, Len(eLink)

            Select Case eLink.msg
            Case WM_LBUTTONDOWN
                eText.chrg.cpMin = eLink.chrg.cpMin
                eText.chrg.cpMax = eLink.chrg.cpMax
                eText.lpstrText = Space$(1024)

                lLen = SendMessage(hWndRTB, EM_GETTEXTRANGE, 0, eText)

                sText = Left$(eText.lpstrText, lLen)
                ShellExecute hWndParent, vbNullString, sText, vbNullString, vbNullString, SW_SHOW
            End Select
        End If
    End If

    WndProc = CallWindowProc(lOldProc, hwnd, uMsg, wParam, lParam)
End Function


