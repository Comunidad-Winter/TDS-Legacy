Attribute VB_Name = "Mod_General"
Option Explicit

Private Declare Function timeBeginPeriod Lib "winmm.dll" (ByVal uPeriod As Long) As Long
Private Declare Function timeEndPeriod Lib "winmm.dll" (ByVal uPeriod As Long) As Long

Private Declare Function GetQueueStatus Lib "user32.dll" (ByVal Flags As Long) As Long

Public ShowBonusExpTimeleft As Boolean
Public LeveleandoTick As Byte
Public tBonif As Integer
Public guild_Name As String
Public char_Name As String
Public LogAlpha As Byte
Public IP As String, Port As Integer
Attribute Port.VB_VarUserMemId = 1073741830

Public bFogata As Boolean
Attribute bFogata.VB_VarUserMemId = 1073741832

Private Type tMapsInMemory
    Data() As Byte
    dLen As Long
End Type

Public bLluvia() As Byte

Private lFrameTimer As Long
Attribute lFrameTimer.VB_VarUserMemId = 1073741834
Public FrameTimerGlobal As Long
Public LastMovement As Long
Public MapsInMemory(1 To NumMapas) As tMapsInMemory

Public Function DirGraficos() As String
    DirGraficos = App.Path & "\GRAFICOS\"
End Function

Public Function DirSound() As String
    DirSound = App.Path & "\Wav\"
End Function

Public Function DirMidi() As String
    DirMidi = App.Path & "\Midi\"
End Function

Public Function DirMapas() As String
    DirMapas = App.Path & "\Mapas\"
End Function

Public Function RandomNumber(ByVal LowerBound As Long, ByVal UpperBound As Long) As Long
    Randomize Timer
    RandomNumber = (UpperBound - LowerBound) * Rnd + LowerBound
End Function

Public Function GetRawName(ByRef sName As String) As String
    Dim Pos As Integer
    Pos = InStr(1, sName, "<")
    If Pos > 0 Then
        GetRawName = Trim(Left(sName, Pos - 1))
    Else
        GetRawName = sName
    End If
End Function

Sub AddtoRichTextBox2(ByVal Text As String, ByVal color As OLE_COLOR, Optional ByVal bold As Boolean = False, Optional ByVal italics As Boolean = False, Optional ByVal bCrLf As Boolean = True)
' @@ ésto permite ir agregando colores.
    If Len(frmMain.RecTxt.Text) > 1000 Then
        frmMain.RecTxt.SelStart = InStr(1, frmMain.RecTxt.Text, vbCrLf) + 1
        frmMain.RecTxt.SelLength = Len(frmMain.RecTxt.Text) - frmMain.RecTxt.SelStart + 2
        frmMain.RecTxt.TextRTF = frmMain.RecTxt.SelRTF
    End If
    frmMain.RecTxt.SelStart = Len(frmMain.RecTxt.Text)
    frmMain.RecTxt.SelLength = 0
    frmMain.RecTxt.SelBold = bold
    frmMain.RecTxt.SelItalic = italics
    frmMain.RecTxt.SelColor = color
    If bCrLf And Len(frmMain.RecTxt.Text) > 0 Then Text = vbCrLf & Text
    frmMain.RecTxt.SelText = Text
End Sub

Sub AddtoRichTextBox(ByRef RichTextBox As RichTextBox, ByVal Text As String, Optional ByVal red As Integer = -1, Optional ByVal green As Integer, Optional ByVal blue As Integer, Optional ByVal bold As Boolean = False, Optional ByVal italic As Boolean = False, Optional ByVal bCrLf As Boolean = True)
    With RichTextBox
        If Len(.Text) > 1000 Then
            .SelStart = InStr(1, .Text, vbCrLf) + 1
            .SelLength = Len(.Text) - .SelStart + 2
            .TextRTF = .SelRTF
        End If
        .SelStart = Len(.Text)
        .SelLength = 0
        .SelBold = bold
        .SelItalic = italic
        If Not red = -1 Then .SelColor = RGB(red, green, blue)
        If bCrLf And Len(.Text) > 0 Then Text = vbCrLf & Text
        .SelText = Text
        RichTextBox.Refresh
    End With
End Sub
Public Sub RefreshAllChars()
    Dim LoopC As Long

    For LoopC = 1 To LastChar
        If charlist(LoopC).Active = 1 Then
            MapData(charlist(LoopC).Pos.X, charlist(LoopC).Pos.Y).CharIndex = LoopC
        End If
    Next LoopC
End Sub
Public Function AsciiValidos(ByVal cad As String) As Boolean
    Dim car As Byte
    Dim i As Long
    cad = LCase$(cad)
    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))
        If ((car < 97 Or car > 122) Or car = Asc("º")) And (car <> 255) And (car <> 32) Then
            Exit Function
        End If
    Next i
    AsciiValidos = True
End Function
Function CheckUserData(ByVal checkemail As Boolean) As Boolean
    Dim LoopC As Long
    Dim CharAscii As Integer
    If checkemail And UserEmail = "" Then MsgBox ("Dirección de email invalida"): Exit Function
    If UserPassword = "" Then MsgBox ("Ingrese un password."): Exit Function

    UserName = Trim$(UserName)
    UserName = Replace$(UserName, "|", "")

    UserPassword = Trim$(Replace$(UserPassword, vbNewLine, vbNullString))
    UserPassword = Trim$(Replace$(UserPassword, vbTab, vbNullString))

    'For LoopC = 1 To Len(UserPassword)
    '    CharAscii = Asc(mid$(UserPassword, LoopC, 1))
    '    If Not LegalCharacter(CharAscii) Then MsgBox ("Password inválido. El caractér " & Chr$(CharAscii) & " no está permitido."): Exit Function
    'Next LoopC

    If UserName = "" Then MsgBox ("Ingrese un nombre de personaje."): Exit Function
    If Len(UserName) > 30 Then MsgBox ("El nombre debe tener menos de 30 letras."): Exit Function

    For LoopC = 1 To Len(UserName)
        CharAscii = Asc(mid$(UserName, LoopC, 1))
        If Not LegalCharacter(CharAscii) Then MsgBox ("Nombre inválido. El caractér " & Chr$(CharAscii) & " no está permitido."): Exit Function
    Next LoopC

    CheckUserData = True
End Function

Sub UnloadAllForms()
    On Error Resume Next

    Dim mifrm As Form

    For Each mifrm In Forms
        Unload mifrm
    Next

    Call timeEndPeriod(1)

End Sub

Function LegalCharacter(ByVal KeyAscii As Integer) As Boolean
    If KeyAscii = 8 Then LegalCharacter = True: Exit Function
    If KeyAscii < 32 Or KeyAscii = 44 Then Exit Function
    If KeyAscii > 126 Then Exit Function
    If KeyAscii = 34 Or KeyAscii = 42 Or KeyAscii = 47 Or KeyAscii = 58 Or KeyAscii = 60 Or KeyAscii = 62 Or KeyAscii = 63 Or KeyAscii = 92 Or KeyAscii = 124 Then Exit Function
    LegalCharacter = True
End Function

Sub SetConnected()

    On Error GoTo SetConnected_Err

    ShowBonusExpTimeleft = False
    Connected = True
    ModoCombate = False
    MostrarMapa = False

    SkillPoints = 10
    GuiTexto(28).Texto = "Skillpoints libres: " & SkillPoints

    FramesPerSecCounter = 0
    fpsLastCheck = 0

    'Unload the connect form
    Unload frmCrearPersonaje
    Unload frmOldPersonaje
    Unload frmConnect


    'If LoginNormal Then
    If GuardarContra Then
        Call SaveRecu(UserName, UserPassword)
    End If
    'End If

    Call frmMain.ControlSM(eSMType.mSpells, False)
    Call frmMain.ControlSM(eSMType.mWork, False)

    frmMain.SendTxt.visible = False

    frmMain.timerAntiCuelgue.Enabled = True

    Typing = False

    'Load main form
    frmMain.visible = True

    Call frmMain.Label4_Click
    Call frmMain.SetInventory

    Exit Sub

SetConnected_Err:
    Call RegistrarError(Err.Number, Err.Description, "Mod_General.SetConnected", Erl)
    Resume Next

End Sub

Sub MoveTo(ByVal Direccion As E_Heading)

    Dim LegalOk As Boolean

    If Cartel Then Cartel = False

    Select Case Direccion
    Case E_Heading.NORTH
        LegalOk = MoveToLegalPos(UserPos.X, UserPos.Y - 1)
    Case E_Heading.EAST
        LegalOk = MoveToLegalPos(UserPos.X + 1, UserPos.Y)
    Case E_Heading.SOUTH
        LegalOk = MoveToLegalPos(UserPos.X, UserPos.Y + 1)
    Case E_Heading.WEST
        LegalOk = MoveToLegalPos(UserPos.X - 1, UserPos.Y)
    End Select

    If LegalOk And Not UserParalizado Then
        If Not UserDescansar And Not UserMeditar Then
            MoveCharbyHead UserCharIndex, Direccion
            MoveScreen Direccion
            Call WriteWalk(Direccion)
        End If
    Else
        If MainTimer.Check(TimersIndex.ChangeHeading) Then
            Call Char_ChangeHeading(Direccion)
        End If
    End If

    If frmMain.macrotrabajo.Enabled Then Call frmMain.DesactivarMacroTrabajo

End Sub

Sub RandomMove()
    Randomize Timer
    Call MoveTo(RandomNumber(NORTH, WEST))
End Sub

Public Sub CheckKeys()


'No input allowed while Argentum is not the active window
'
    If LockedWalk Then

        If GetTickCount - LastMovement > 250 Then
            LastMovement = GetTickCount
            Call MoveTo(LastKeyPress)
            frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
        End If

        Exit Sub
    End If

    'End If

    'No walking when in commerce or banking.
    If Comerciando Then Exit Sub

    If frmNewPassword.visible Then Exit Sub

    'If game is paused, abort movement.
    If pausa Then Exit Sub

    If Typing Then
        If ClientSetup.NotHablaMovement Then
            'Exit Sub
        End If
    End If

    'Control movement interval (this enforces the 1 step loss when meditating / resting client-side)
    If GetTickCount - LastMovement > 20 Then
        LastMovement = GetTickCount
    Else
        Exit Sub
    End If

    If ((frmMain.SendTxt.visible) Or (frmMain.SendCMSTXT.visible)) And tSetup.NoMoverseAlHablar = 1 Then Exit Sub

    'Don't allow any these keys during movement..
    If UserMoving = 0 Then
        If Not UserEstupido Then
            'Move Up
            If GetKeyState(Teclas.BindedKey(eKeyType.mKeyUp)) < 0 Then
                If frmMain.TrainingMacro.Enabled Then frmMain.DesactivarMacroHechizos
                Call MoveTo(NORTH)
                LastKeyPress = NORTH

                frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
                Exit Sub
            End If

            'Move Right
            If GetKeyState(Teclas.BindedKey(eKeyType.mKeyRight)) < 0 Then
                If frmMain.TrainingMacro.Enabled Then frmMain.DesactivarMacroHechizos
                Call MoveTo(EAST)

                LastKeyPress = EAST

                'frmMain.Coord.Caption = "(" & UserMap & "," & UserPos.x & "," & UserPos.y & ")"
                frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
                Exit Sub
            End If

            'Move down
            If GetKeyState(Teclas.BindedKey(eKeyType.mKeyDown)) < 0 Then
                If frmMain.TrainingMacro.Enabled Then frmMain.DesactivarMacroHechizos
                Call MoveTo(SOUTH)

                LastKeyPress = SOUTH

                frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
                Exit Sub
            End If

            'Move left
            If GetKeyState(Teclas.BindedKey(eKeyType.mKeyLeft)) < 0 Then
                If frmMain.TrainingMacro.Enabled Then frmMain.DesactivarMacroHechizos
                Call MoveTo(WEST)

                LastKeyPress = WEST

                frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
                Exit Sub
            End If

        Else
            Dim kp As Boolean
            kp = (GetKeyState(Teclas.BindedKey(eKeyType.mKeyUp)) < 0) Or _
                 GetKeyState(Teclas.BindedKey(eKeyType.mKeyRight)) < 0 Or _
                 GetKeyState(Teclas.BindedKey(eKeyType.mKeyDown)) < 0 Or _
                 GetKeyState(Teclas.BindedKey(eKeyType.mKeyLeft)) < 0

            If kp Then
                Call RandomMove
            End If

            If frmMain.TrainingMacro.Enabled Then frmMain.DesactivarMacroHechizos
            'frmMain.Coord.Caption = "(" & UserPos.x & "," & UserPos.y & ")"
            frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
        End If
    End If
End Sub

'TODO : Si bien nunca estuvo allí, el mapa es algo independiente o a lo sumo dependiente del engine, no va acá!!!
Sub SwitchMap(ByVal Map As Integer)
'**************************************************************
'Formato de mapas optimizado para reducir el espacio que ocupan.
'Diseñado y creado por Juan Martín Sotuyo Dodero (Maraxus) (juansotuyo@hotmail.com)
'**************************************************************

    Dim Y As Long
    Dim X As Long
    Dim ByFlags As Byte
    Dim handle As Integer
    Dim fileBuff As clsByteBuffer
    Dim dData() As Byte
    Dim dLen As Long

    Set fileBuff = New clsByteBuffer
    Dim dir_map As String

    'Dim lngStart As Long
    'Dim lngfinish As Long
    'lngStart = GetTickCount

    'If CurMap <> Map Then
    '    Call DeleteDamages
    'End If

    If MapsInMemory(Map).dLen = 0 Then
        dir_map = Get_FileFrom(resource_file_type.Map, "Mapa" & Map & ".map")
        dLen = FileLen(dir_map)
        ReDim dData(dLen - 1)
        handle = FreeFile()
        Open dir_map For Binary As handle
        Seek handle, 1
        Get handle, , dData
        Close handle

        MapsInMemory(Map).Data = dData
        MapsInMemory(Map).dLen = dLen
    Else
        'ya está en mapa
        dData = MapsInMemory(Map).Data
    End If

    fileBuff.initializeReader dData

    MapInfo.MapVersion = fileBuff.getInteger
    MiCabecera.Desc = fileBuff.getString(Len(MiCabecera.Desc))
    MiCabecera.CRC = fileBuff.getLong
    MiCabecera.MagicWord = fileBuff.getLong
    fileBuff.getDouble

    For Y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize

            'Get handle, , ByFlags
            ByFlags = fileBuff.getByte()

            MapData(X, Y).Blocked = (ByFlags And 1)

            'Get handle, , MapData(X, Y).Graphic(1).GrhIndex
            MapData(X, Y).Graphic(1).GrhIndex = fileBuff.getInteger()
            InitGrh MapData(X, Y).Graphic(1), MapData(X, Y).Graphic(1).GrhIndex

            'Layer 2 used?
            If ByFlags And 2 Then
                'Get handle, , MapData(X, Y).Graphic(2).GrhIndex
                MapData(X, Y).Graphic(2).GrhIndex = fileBuff.getInteger()
                If X = 100 And Y = 100 Then
                    If MapData(X, Y).Graphic(2).GrhIndex = 162 Then
                        MapData(X, Y).Graphic(2).GrhIndex = 0
                    Else
                        InitGrh MapData(X, Y).Graphic(2), MapData(X, Y).Graphic(2).GrhIndex
                    End If
                End If
            Else
                MapData(X, Y).Graphic(2).GrhIndex = 0
            End If

            'Layer 3 used?
            If ByFlags And 4 Then
                'Get handle, , MapData(X, Y).Graphic(3).GrhIndex
                MapData(X, Y).Graphic(3).GrhIndex = fileBuff.getInteger()
                InitGrh MapData(X, Y).Graphic(3), MapData(X, Y).Graphic(3).GrhIndex
            Else
                MapData(X, Y).Graphic(3).GrhIndex = 0
            End If

            'Layer 4 used?
            If ByFlags And 8 Then
                'Get handle, , MapData(X, Y).Graphic(4).GrhIndex
                MapData(X, Y).Graphic(4).GrhIndex = fileBuff.getInteger()
                InitGrh MapData(X, Y).Graphic(4), MapData(X, Y).Graphic(4).GrhIndex
            Else
                MapData(X, Y).Graphic(4).GrhIndex = 0
            End If

            'Trigger used?
            If ByFlags And 16 Then
                'Get handle, , MapData(X, Y).Trigger
                MapData(X, Y).Trigger = fileBuff.getInteger()
            Else
                MapData(X, Y).Trigger = 0
            End If

            'Erase NPCs
            If MapData(X, Y).CharIndex > 0 Then
                Call EraseChar(MapData(X, Y).CharIndex)
            End If

            'Erase OBJs
            MapData(X, Y).ObjGrh.GrhIndex = 0

            'Erase Damages!
            'For j = 0 To 8
            '    MapData(X, Y).Damage(j).Using = False
            'Next j

        Next X
    Next Y

    Set fileBuff = Nothing        ' @@ Tanto te costaba Destruir el buff una ves que se termino de usar?

    If Len(dir_map) > 0 Then
        If FileExist(dir_map, vbArchive) Then
            Delete_File (dir_map)
        End If
    End If

    MapInfo.Name = vbNullString
    MapInfo.music = vbNullString
    CurMap = Map

End Sub

Function ReadField(ByVal Pos As Integer, ByRef Text As String, ByVal SepASCII As Byte) As String
    Dim i As Long
    Dim lastPos As Long
    Dim CurrentPos As Long
    Dim delimiter As String * 1

    delimiter = Chr$(SepASCII)

    For i = 1 To Pos
        lastPos = CurrentPos
        CurrentPos = InStr(lastPos + 1, Text, delimiter, vbBinaryCompare)
    Next i

    If CurrentPos = 0 Then
        ReadField = mid$(Text, lastPos + 1, Len(Text) - lastPos)
    Else
        ReadField = mid$(Text, lastPos + 1, CurrentPos - lastPos - 1)
    End If
End Function

Function FieldCount(ByRef Text As String, ByVal SepASCII As Byte) As Long
    Dim Count As Long
    Dim curPos As Long
    Dim delimiter As String * 1
    If LenB(Text) = 0 Then Exit Function
    delimiter = Chr$(SepASCII)
    curPos = 0
    Do
        curPos = InStr(curPos + 1, Text, delimiter)
        Count = Count + 1
    Loop While curPos <> 0
    FieldCount = Count
End Function

Function FileExist(ByVal File As String, ByVal FileType As VbFileAttribute) As Boolean
    FileExist = (Dir$(File, FileType) <> "")
End Function

Function LeerInt(ByVal Ruta As String) As Integer
    Dim F As Integer
    F = FreeFile
    If FileExist(Ruta, vbNormal) Then
        Open Ruta For Input As F
        LeerInt = Input$(LOF(F), #F)
        Close #F
    Else
        LeerInt = 0
    End If
End Function

Public Function IsInIDE() As Boolean
    On Local Error GoTo ErrHandler
    IsInIDE = False
    'Debug.Print 1 / 0
    Exit Function
ErrHandler:
    IsInIDE = True
End Function

Sub Main()

    'On Error GoTo Start_Err
    
    Call modNetwork.Initialize
    
    ' Load Game's properties
    Call modEngine_Properties.LoadProperties

    '1   Call ValidarIP

2   Windows_Temp_Dir = General_Get_Temp_Dir

4   mod_GameLoad.LoadIni

5   frmCargando.Show
    Dim islocal As Boolean

    islocal = (IP = "127.0.0.1")

    'Inicializamos el sonido
6   Call Audio.Initialize(DirectX, frmMain.hwnd, App.Path & "\Resources\Wav\", App.Path & "\Resources\Midi\")

7   frmCargando.NewPercentage 10

8   LoadConsts

9   DoEvents

10  Call LoadClientSetup

    modEngine_Audio.MusicVolume = Configuration.Audio_MusicVolume
    modEngine_Audio.MusicEnabled = Configuration.Audio_MusicEnabled
    modEngine_Audio.EffectVolume = Configuration.Audio_EffectVolume
    modEngine_Audio.EffectEnabled = Configuration.Audio_EffectEnabled
    
        'Enable / Disable audio
    Audio.MusicActivated = Configuration.Audio_MusicEnabled
    Audio.SoundActivated = Configuration.Audio_EffectEnabled
        
    modEngine_Audio.InterfaceVolume = Configuration.Audio_InterfaceVolume
    modEngine_Audio.InterfaceEnabled = Configuration.Audio_InterfaceEnabled

12  Call Load(frmConnect)

14  Call Resolution.SetResolution(True)

15  frmCargando.NewPercentage 20
16  DirectXInit

17  Set SurfaceDB = New clsSurfaceManDyn

18  Set SpriteBatch = New clsBatch

19  Call SurfaceDB.Initialize(DirectD3D8, DirGraficos, 90)
20  Call SpriteBatch.Initialize(2000)

21  frmCargando.NewPercentage 30

22  DoEvents

    If (Not Application.IsAppDebug()) Then
        If (Application.IsAppRunning()) Then
23          If Not islocal Then
24           '   Call MsgBox("TDS Legacy ya esta corriendo! No es posible correr otra instancia del juego. Haga click en Aceptar para salir.", vbApplicationModal + vbInformation + vbOKOnly, "Error al ejecutar")
            '    End
            End If
        End If
    End If

    'usaremos esto para ayudar en los parches
25  Call SaveSetting("ArgentumOnlineCliente", "Init", "Path", App.Path & "\")

26  ChDrive App.Path
27  ChDir App.Path

28  Call InicializarNombres

    ' Initialize FONTTYPES
29  Call GameIni.InitFonts

30  frmCargando.NewPercentage 40
31  If Not InitTileEngine(frmMain.hwnd, 149, 7, 13, 17, 8, 7, 7, 0.02) Then
32      Call Mod_General.CloseClient
33  End If
34  frmCargando.NewPercentage 50

    UserMap = 1

35  Call CargarArrayLluvia
    frmCargando.NewPercentage 51
36  Call CargarAnimArmas
    frmCargando.NewPercentage 52
37  Call CargarAnimEscudos
    frmCargando.NewPercentage 53
38  Call CargarColores
    frmCargando.NewPercentage 54
39  Call LoadNameSource
    frmCargando.NewPercentage 60

    frmCargando.NewPercentage 70

    'Enable / Disable audio
'40  Audio.MusicActivated = Not ClientSetup.bNoMusic
'41  Audio.SoundActivated = Not ClientSetup.bNoSound
'42  Audio.SoundEffectsActivated = Not ClientSetup.bNoSoundEffects

    frmCargando.NewPercentage 80

    'Inicializamos el inventario gráfico

400 InventoryMainHwnd = frmMain.picInv.hwnd
43  Call Inventario.Initialize(DirectD3D8, frmMain.picInv, MAX_INVENTORY_SLOTS)

    frmCargando.NewPercentage 90

    If Not islocal Then
   '     Call mod_updater.VerificarYActualizar
    End If

44  InitGui

    frmCargando.NewPercentage 100

45  frmConnect.visible = True

    FramesPerSecCounter = 0
    fpsLastCheck = 0
        
    If modEngine_Audio.MusicEnabled Then
        Call Audio.PlayMIDI("78.MID")
    End If
    
    'Call modEngine_Audio.PlayMusic("78.MID") 'solo acepta MP3 ahora..

    'Inicialización de variables globales
48  prgRun = True
    pausa = False

49  lFrameTimer = GetTickCount
50  Init_FontRender
    ' Load the form for screenshots
51  Call Load(frmScreenshots)
52  Call SetElapsedTime(True)        'Iniciamos el tiempo
53  InitBarras

54  IniciarCaida 0

    PanelQuitVisible = False

    lvalue(0) = -1
    lvalue(1) = -1
    lvalue(2) = -1
    lvalue(3) = -1

    CountTime = 0

    MainWindowState = 1


55  LoadRecup
56  Call timeBeginPeriod(1)

    Static LastMovement As Long
57  Do While prgRun
        'Sólo dibujamos si la ventana no está minimizada
58      If CambiandoRes = False Then
59          If frmMain.visible Then
                If MainWindowState <> 1 Then

60                  Call ShowNextFrame(frmMain.MouseX, frmMain.MouseY)

                End If

                'Play ambient sounds
61              Call RenderSounds

62              If frmMain.WindowState <> 1 Then Call CheckKeys

                'FPS Counter - mostramos las FPS
63              If GetTickCount - lFrameTimer >= 1000 Then

64                  frmMain.lblFPS.Caption = Mod_TileEngine.fps

65                  lFrameTimer = GetTickCount
                End If

66          ElseIf (frmConnect.visible = True And Not frmCrearPersonaje.visible = True) Then
67              Call RenderConnect
            Else
68              Call RenderCrearPJ
                'Call Sleep(10&)
            End If
        End If

        ' If there is anything to be sent, we send it
69      DoEvents
70      Call modNetwork.Tick
        Call modEngine_Audio.Update(&H0, UserPos.X, UserPos.Y)

    Loop

71  EngineRun = False
73  Call Mod_General.CloseClient

    Exit Sub

Start_Err:
    frmMensaje.msg = "Error en el Main del cliente" & vbNewLine & "Err: " & Err.Number & " en linea: " & Erl & ". Reportar a los GM"
    frmMensaje.Show
    'End
    Call RegistrarError(Err.Number, Err.Description, "engine.Start", Erl)
    Resume Next

End Sub

Public Function SalePrice(ByVal ObjIndex As Integer) As Single

    If ObjIndex < 1 Or ObjIndex > UBound(DataObj) Then Exit Function
    'If ItemNewbie(DataObj) Then Exit Function
    SalePrice = DataObj(ObjIndex).Valor / 3

End Function

Public Function GetTickCount() As Long
    GetTickCount = GetRealTickCount() And &H7FFFFFFF
End Function

Public Function GetTime() As Long
    GetTime = timeGetTime() And &H7FFFFFFF
End Function

Public Function DoEventsEx() As Integer
    If GetQueueStatus(&H4FF&) And &HFFFF0000 Then
        DoEventsEx = DoEvents
    End If
End Function

Sub WriteVar(ByVal File As String, ByVal Main As String, ByVal var As String, ByVal Value As String)
'*****************************************************************
'Writes a var to a text file
'*****************************************************************
    writeprivateprofilestring Main, var, Value, File
End Sub

Function GetVar(ByVal File As String, ByVal Main As String, ByVal var As String) As String
'*****************************************************************
'Gets a Var from a text file
'*****************************************************************
    Dim sSpaces As String        ' This will hold the input that the program will retrieve

    sSpaces = Space$(500)        ' This tells the computer how long the longest string can be. If you want, you can change the number 100 to any number you wish

    getprivateprofilestring Main, var, vbNullString, sSpaces, Len(sSpaces), File

    GetVar = RTrim$(sSpaces)
    GetVar = Left$(GetVar, Len(GetVar) - 1)
End Function

'[CODE 002]:MatuX
'
'  Función para chequear el email
'
'  Corregida por Maraxus para que reconozca como válidas casillas con puntos antes de la arroba y evitar un chequeo innecesario
Public Function CheckMailString(ByVal sString As String) As Boolean
    On Error GoTo errHnd
    Dim lPos As Long
    Dim lX As Long
    Dim iAsc As Integer

    '1er test: Busca un simbolo @
    lPos = InStr(sString, "@")
    If (lPos <> 0) Then
        '2do test: Busca un simbolo . después de @ + 1
        If Not (InStr(lPos, sString, ".", vbBinaryCompare) > lPos + 1) Then _
           Exit Function

        '3er test: Valída el ultimo caracter
        If Not (CMSValidateChar_(Asc(Right(sString, 1)))) Then _
           Exit Function

        '4to test: Recorre todos los caracteres y los valída
        For lX = 0 To Len(sString) - 1        'el ultimo no porque ya lo probamos
            If Not (lX = (lPos - 1)) Then
                iAsc = Asc(mid(sString, (lX + 1), 1))
                If Not (iAsc = 46 And lX > (lPos - 1)) Then _
                   If Not CMSValidateChar_(iAsc) Then _
                   Exit Function
            End If
        Next lX

        'Finale
        CheckMailString = True
    End If
errHnd:
End Function

'  Corregida por Maraxus para que reconozca como válidas casillas con puntos antes de la arroba
Private Function CMSValidateChar_(ByVal iAsc As Integer) As Boolean
    CMSValidateChar_ = (iAsc >= 48 And iAsc <= 57) Or _
                       (iAsc >= 65 And iAsc <= 90) Or _
                       (iAsc >= 97 And iAsc <= 122) Or _
                       (iAsc = 95) Or (iAsc = 45) Or (iAsc = 46)
End Function

'TODO : como todo lo relativo a mapas, no tiene nada que hacer acá....
Function HayAgua(ByVal X As Integer, ByVal Y As Integer) As Boolean

    HayAgua = ((MapData(X, Y).Graphic(1).GrhIndex >= 1505 And MapData(X, Y).Graphic(1).GrhIndex <= 1520) Or _
               (MapData(X, Y).Graphic(1).GrhIndex >= 5665 And MapData(X, Y).Graphic(1).GrhIndex <= 5680) Or _
               (MapData(X, Y).Graphic(1).GrhIndex >= 13547 And MapData(X, Y).Graphic(1).GrhIndex <= 13562)) And _
               MapData(X, Y).Graphic(2).GrhIndex = 0

End Function

Public Sub ShowSendTxt()
    If Not frmCantidad.visible Then
        frmMain.SendTxt.visible = True
        frmMain.SendTxt.SetFocus
    End If
End Sub

Public Sub ShowSendCMSGTxt()
    If Not frmCantidad.visible Then
        frmMain.SendCMSTXT.visible = True
        frmMain.SendCMSTXT.SetFocus
    End If
End Sub

''
' Checks the command line parameters, if you are running Ao with /nores command and checks the AoUpdate parameters
'
'


Private Sub LoadClientSetup()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 11/19/09
'11/19/09: Pato - Is optional show the frmGuildNews form
'**************************************************************
    Dim fHandle As Integer

    If FileExist(App.Path & "\init\ao.dat", vbArchive) Then
        fHandle = FreeFile

        Open App.Path & "\init\ao.dat" For Binary Access Read Lock Write As fHandle
        Get fHandle, , ClientSetup
        Close fHandle
    Else
        'Use dynamic by default
        ClientSetup.bDinamic = True
    End If

    NoRes = ClientSetup.bNoRes

    ClientSetup.bGuildNews = Not ClientSetup.bGuildNews
    DialogosClanes.Activo = Not ClientSetup.bGldMsgConsole
    Call LoadIni
    
    
    'Audio.SetMusic (tSetup.MusicValue)
    'Audio.SetSound (tSetup.AudioValue)


End Sub

Private Sub SaveClientSetup()
'**************************************************************
'Author: Torres Patricio (Pato)
'Last Modify Date: 03/11/10
'
'**************************************************************
    Dim fHandle As Integer

    fHandle = FreeFile

    ClientSetup.bNoMusic = Not tSetup.MusicActivated ' .Audio.MusicActivated
    ClientSetup.bNoSound = Not tSetup.AudioActivated
    ClientSetup.bNoSoundEffects = Not tSetup.AudioEffectsActivated
    ClientSetup.bGuildNews = Not ClientSetup.bGuildNews
    ClientSetup.bGldMsgConsole = Not DialogosClanes.Activo
    ClientSetup.bCantMsgs = DialogosClanes.CantidadDialogos

    Open App.Path & "\init\ao.dat" For Binary As fHandle
    Put fHandle, , ClientSetup
    Close fHandle
End Sub

Private Sub InicializarNombres()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 11/27/2005
'Inicializa los nombres de razas, ciudades, clases, skills, atributos, etc.
'**************************************************************
    Ciudades(eCiudad.cUllathorpe) = "Ullathorpe"
    Ciudades(eCiudad.cNix) = "Nix"
    Ciudades(eCiudad.cBanderbill) = "Banderbill"
    Ciudades(eCiudad.cLindos) = "Lindos"
    Ciudades(eCiudad.cArghal) = "Arghâl"

    ListaRazas(eRaza.Humano) = "Humano"
    ListaRazas(eRaza.Elfo) = "Elfo"
    ListaRazas(eRaza.ElfoOscuro) = "Elfo Oscuro"
    ListaRazas(eRaza.Gnomo) = "Gnomo"
    ListaRazas(eRaza.Enano) = "Enano"

    ListaClases(eClass.Assasin) = "Asesino"
    ListaClases(eClass.Bard) = "Bardo"
    ListaClases(eClass.Cleric) = "Clerigo"
    ListaClases(eClass.Paladin) = "Paladin"
    ListaClases(eClass.Carpenter) = "Carpintero"
    ListaClases(eClass.Woodcutter) = "Leñador"
    ListaClases(eClass.Miner) = "Minero"
    ListaClases(eClass.Warrior) = "Guerrero"
    ListaClases(eClass.Mage) = "Mago"
    ListaClases(eClass.Druid) = "Druida"
    ListaClases(eClass.Hunter) = "Cazador"
    ListaClases(eClass.Thief) = "Ladron"
    ListaClases(eClass.Fisherman) = "Pescador"
    ListaClases(eClass.Pirat) = "Pirata"
    ListaClases(eClass.Blacksmith) = "Herrero"

    SkillsNames(eSkill.ResistenciaMagica) = "Resistencia Mágica"
    SkillsNames(eSkill.Magia) = "Magia"
    SkillsNames(eSkill.Robar) = "Robar"
    SkillsNames(eSkill.Tacticas) = "Tacticas de combate"
    SkillsNames(eSkill.Armas) = "Combate con armas"
    SkillsNames(eSkill.Meditar) = "Meditar"
    SkillsNames(eSkill.Apuñalar) = "Apuñalar"
    SkillsNames(eSkill.Ocultarse) = "Ocultarse"
    SkillsNames(eSkill.Supervivencia) = "Supervivencia"
    SkillsNames(eSkill.Talar) = "Talar arboles"
    SkillsNames(eSkill.Comerciar) = "Comercio"
    SkillsNames(eSkill.Defensa) = "Defensa con escudos"
    SkillsNames(eSkill.Pesca) = "Pesca"
    SkillsNames(eSkill.Mineria) = "Mineria"
    SkillsNames(eSkill.Carpinteria) = "Carpinteria"
    SkillsNames(eSkill.Herreria) = "Herreria"
    SkillsNames(eSkill.Liderazgo) = "Liderazgo"
    SkillsNames(eSkill.Domar) = "Domar animales"
    SkillsNames(eSkill.Proyectiles) = "Armas de proyectiles"
    SkillsNames(eSkill.Wrestling) = "Wresterling"
    SkillsNames(eSkill.Navegacion) = "Navegacion"

    AtributosNames(eAtributos.Fuerza) = "Fuerza"
    AtributosNames(eAtributos.Agilidad) = "Agilidad"
    AtributosNames(eAtributos.Inteligencia) = "Inteligencia"
    AtributosNames(eAtributos.Carisma) = "Carisma"
    AtributosNames(eAtributos.Constitucion) = "Constitucion"
End Sub

''
' Removes all text from the console and dialogs

Public Sub CleanDialogs()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 11/27/2005
'Removes all text from the console and dialogs
'**************************************************************
'Clean console and dialogs
    frmMain.RecTxt.Text = vbNullString

    Call DialogosClanes.RemoveDialogs

    Call Dialogos.RemoveAllDialogs
End Sub

Public Sub CloseClient()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 8/14/2007
'Frees all used resources, cleans up and leaves
'**************************************************************
    On Error Resume Next

    Call PrevInstance.ReleaseInstance

    EngineRun = False
    frmCargando.Show

    Call Resolution.ResetResolution

    'Stop tile engine
    Call DeinitTileEngine

    Call SaveClientSetup

    'Destruimos los objetos públicos creados
    Set Teclas = Nothing
    Set SurfaceDB = Nothing
    Set Dialogos = Nothing
    Set DialogosClanes = Nothing
    Set Audio = Nothing
    Set Inventario = Nothing
    Set MainTimer = Nothing

    Call UnloadAllForms

    End
End Sub

Public Function esGM(Optional ByVal CharIndex As Long = -1) As Boolean
    If CharIndex = -1 Then CharIndex = UserCharIndex
    If CharIndex = 0 Then Exit Function

    If charlist(CharIndex).priv <= PlayerType.User Then Exit Function
    esGM = True
End Function

Public Function getTagPosition(ByVal nick As String) As Integer
    Dim buf As Integer
    buf = InStr(nick, Chr(60))        '<
    If buf > 0 Then
        getTagPosition = buf
        Exit Function
    End If
    buf = InStr(nick, Chr(91))        '[
    If buf > 0 Then
        getTagPosition = buf
        Exit Function
    End If
    getTagPosition = Len(nick) + 2
End Function

Public Sub checkText(ByVal Text As String)
    If Right(Text, Len(MENSAJE_FRAGSHOOTER_TE_HA_MATADO)) = MENSAJE_FRAGSHOOTER_TE_HA_MATADO Then
        Call ScreenCapture(True)
        Exit Sub
    End If
End Sub

Public Function getStrenghtColor2() As Long
    Dim m As Long
    m = 255 / MAXATRIBUTOS
    getStrenghtColor2 = RGB(255 - (m * UserFuerza), (m * UserFuerza), 0)
End Function
Public Function getDexterityColor2() As Long
    Dim m As Long
    m = 255 / MAXATRIBUTOS
    getDexterityColor2 = RGB(255, m * UserAgilidad, 0)
End Function

Public Function getStrenghtColor(ByVal yFuerza As Byte) As Long
    Dim m As Long
    Dim n As Long
    m = 255 / MAXATRIBUTOS
    n = (m * yFuerza)
    If (n >= 255) Then n = 255    '// Miqueas : Parchesuli
    getStrenghtColor = RGB(255 - n, n, 0)
End Function

Public Function getDexterityColor(ByVal yAgilidad As Byte) As Long
    Dim m As Long
    Dim n As Long
    m = 255 / MAXATRIBUTOS
    n = (m * yAgilidad)
    If (n >= 255) Then n = 255    '// Miqueas : Parchesuli
    getDexterityColor = RGB(255, n, 0)
End Function

Public Function ColorToDX8(ByVal long_color As Long) As Long
'Dim temp_color As String
    Dim r As Integer, g As Integer, b As Integer

    r = &HFF& And long_color
    g = (&HFF00& And long_color) \ 256
    b = (&HFF0000 And long_color) \ 65536
    ColorToDX8 = D3DColorXRGB(r, g, b)

End Function

Public Function GetByteVal(ByVal inputValue As Variant) As Byte
    Dim var As Double
    On Error GoTo ErrHandler
    var = CDbl(inputValue)
    If var > 255 Then
        GetByteVal = 255
    ElseIf var < 0 Then
        GetByteVal = 255
    Else
        GetByteVal = GetByteVal(var)
    End If
    Exit Function
ErrHandler:
    GetByteVal = 255
End Function

