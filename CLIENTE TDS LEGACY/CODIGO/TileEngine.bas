Attribute VB_Name = "Mod_TileEngine"
Option Explicit

Private Declare Function GetKeyboardState Lib "user32" (pbKeyState As Byte) As Long
Private Const VK_CAPITAL = &H14
Private keys(0 To 255) As Byte

Public BackgroundColor As Long

Public GrhWeather As Byte
Public LastTickWeather As Long

Private ScreenminY As Integer        'Start Y pos on current screen
Private ScreenminX As Integer        'Start X pos on current screen

Private Projection As D3DMATRIX
Private View As D3DMATRIX

Public Angle As Single

Public CurrentGrhIndex As Integer

Private tInvLast As Long

Public ConsolaFlotante As Boolean

Private Declare Function CreateIconFromResourceEx Lib "user32.dll" (ByRef presbits As Any, ByVal dwResSize As Long, ByVal fIcon As Long, ByVal dwVer As Long, ByVal cxDesired As Long, ByVal cyDesired As Long, ByVal Flags As Long) As Long
Private Declare Function OleCreatePictureIndirect Lib "oleaut32.dll" (lpPictDesc As Any, riid As Any, ByVal fPictureOwnsHandle As Long, iPic As IPicture) As Long
Private Declare Function DestroyIcon Lib "user32.dll" (ByVal hIcon As Long) As Long
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal uFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalLock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalUnlock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function OleLoadPicture Lib "olepro32" (pStream As Any, ByVal lSize As Long, ByVal fRunmode As Long, riid As Any, ppvObj As Any) As Long
Private Declare Function CreateStreamOnHGlobal Lib "ole32" (ByVal hGlobal As Long, ByVal fDeleteOnRelease As Long, ppstm As Any) As Long
Public Shapes(1 To 3) As Boolean

Public AlphaTecho As Byte
Private ColorTechos(3) As Long


Public PixelOffsetXTemp As Integer        'For centering grhs
Public PixelOffsetYTemp As Integer        'For centering grhs

Public ScreenWidth As Long
Public ScreenHeight As Long

Private ColorFx(3) As Long

Private SRDesc As D3DSURFACE_DESC

Public lvalue(3) As Long
Public lArboles(3) As Long
Public lvalueDeath(3) As Long


' @@
Private OffsetCounterX As Single
Private OffsetCounterY As Single
Private minY As Integer        'Start Y pos on current map
Private maxY As Integer        'End Y pos on current map
Private minX As Integer        'Start X pos on current map
Private maxX As Integer        'End X pos on current map
Public Movement_Speed As Single

Declare Sub CopyMemory Lib "kernel32" _
                       Alias "RtlMoveMemory" (lpvDest As Any, _
                                              lpvSource As Any, ByVal cbCopy As Long)
'Describes the return from a texture init
Private Type D3DXIMAGE_INFO_A
    Width As Long
    Height As Long
    Depth As Long
    MipLevels As Long
    format As CONST_D3DFORMAT
    ResourceType As CONST_D3DRESOURCETYPE
    ImageFileFormat As Long
End Type

Private Type POINTAPI
    X As Long
    Y As Long
End Type

Public cfonts(1 To 2) As CustomFont        ' _Default2 As CustomFont

'Map sizes in tiles
Public Const XMaxMapSize As Byte = 100
Public Const XMinMapSize As Byte = 1
Public Const YMaxMapSize As Byte = 100
Public Const YMinMapSize As Byte = 1

Private Const GrhFogata As Integer = 1521

''
'Sets a Grh animation to loop indefinitely.
Private Const INFINITE_LOOPS As Integer = -1


'Encabezado bmp
Type BITMAPFILEHEADER
    bfType As Integer
    bfSize As Long
    bfReserved1 As Integer
    bfReserved2 As Integer
    bfOffBits As Long
End Type

'Info del encabezado del bmp
Type BITMAPINFOHEADER
    biSize As Long
    biWidth As Long
    biHeight As Long
    biPlanes As Integer
    biBitCount As Integer
    biCompression As Long
    biSizeImage As Long
    biXPelsPerMeter As Long
    biYPelsPerMeter As Long
    biClrUsed As Long
    biClrImportant As Long
End Type

'Posicion en un mapa
Public Type Position
    X As Long
    Y As Long
End Type

'Posicion en el Mundo
Public Type WorldPos
    Map As Integer
    X As Integer
    Y As Integer
End Type

'Contiene info acerca de donde se puede encontrar un grh tamaño y animacion
Public Type GrhData
    sX As Integer
    sY As Integer

    FileNum As Long

    pixelWidth As Integer
    pixelHeight As Integer

    TileWidth As Single
    TileHeight As Single

    NumFrames As Integer
    Frames() As Long

    Speed As Single
End Type

'apunta a una estructura grhdata y mantiene la animacion
Public Type Grh
    GrhIndex As Integer
    FrameCounter As Single
    Speed As Single
    Started As Byte
    Loops As Integer
End Type

Public FxGrh() As Grh
'Lista de cuerpos
Public Type BodyData
    Walk(E_Heading.NORTH To E_Heading.WEST) As Grh
    HeadOffset As Position
End Type

'Lista de cabezas
Public Type HeadData
    Head(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type

'Lista de las animaciones de las armas
Type WeaponAnimData
    WeaponWalk(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type

'Lista de las animaciones de los escudos
Type ShieldAnimData
    ShieldWalk(E_Heading.NORTH To E_Heading.WEST) As Grh
End Type


'Apariencia del personaje
Public Type Char
    ID As Integer

    Mimetizado As Boolean
    color As Long

    CounterInvi As Integer
    'LastMov As Long


    Movimient As Boolean
    'Proyectil(1 To 4) As tProyectil

    Active As Byte
    Heading As E_Heading
    Pos As Position

    iCasco As Integer
    iHead As Integer
    iBody As Integer
    Body As BodyData
    Head As HeadData
    Casco As HeadData
    Arma As WeaponAnimData
    Escudo As ShieldAnimData

    fX As Grh
    FxIndex As Integer

    Criminal As Byte


    Atacable As Boolean

    nombre As String

    clan As String

    isNPC As Boolean
    
    scrollDirectionX As Integer
    scrollDirectionY As Integer

    Moving As Byte
    MoveOffsetX As Single
    MoveOffsetY As Single

    pie As Boolean
    muerto As Boolean

    ' @@ Con esto hacemos magia.
    Invisible As Boolean
    Oculto As Boolean
    Paralizado As Boolean
    Inmovilizado As Boolean
    Envenenado As Boolean
    IdleCount As Integer
    Trabajando As Integer
    Premium As Boolean

    priv As PlayerType
    isFaccion As FaccionType
    
    Emitter As Audio_Emitter
    Node As Partitioner_Item ' What?
End Type

'Info de un objeto
Public Type obj
    ObjIndex As Integer
    amount As Integer
    
    Node As Partitioner_Item
    
End Type

'Tipo de las celdas del mapa
Public Type MapBlock
    Nodes(1 To 4)   As Partitioner_Item
    'Damage(8) As tDamage
    Graphic(1 To 4) As Grh
    CharIndex As Integer
    ObjGrh As Grh

    NPCIndex As Integer
    OBJInfo As obj
    TileExit As WorldPos
    Blocked As Byte

    Trigger As Integer
End Type

'Info de cada mapa
Public Type MapInfo
    music As String
    Name As String
    startPos As WorldPos
    MapVersion As Integer
End Type

'DX8 Objects
Public DirectX As New DirectX8
Public DirectD3D8 As D3DX8
Public DirectD3D As Direct3D8
Public DirectDevice As Direct3DDevice8

' Directx8 Fonts
Private Type FontInfo
    MainFont As DxVBLibA.D3DXFont
    MainFontDesc As IFont
    MainFontFormat As New StdFont
    color As Long
End Type

Private Type CharVA
    X As Integer
    Y As Integer
    w As Integer
    h As Integer

    Tx1 As Single
    Tx2 As Single
    Ty1 As Single
    Ty2 As Single
End Type

Private Type VFH
    BitmapWidth As Long        'Size of the bitmap itself
    BitmapHeight As Long
    CellWidth As Long        'Size of the cells (area for each character)
    CellHeight As Long
    BaseCharOffset As Byte        'The character we start from
    CharWidth(0 To 255) As Byte        'The actual factual width of each character
    CharVA(0 To 255) As CharVA
End Type

Private Type CustomFont
    HeaderInfo As VFH        'Holds the header information
    Texture As Direct3DTexture8        'Holds the texture of the text
    RowPitch As Integer        'Number of characters per row
    RowFactor As Single        'Percentage of the texture width each character takes
    ColFactor As Single        'Percentage of the texture height each character takes
    CharHeight As Byte        'Height to use for the text - easiest to start with CellHeight value, and keep lowering until you get a good value
    TextureSize As POINTAPI        'Size of the texture
End Type
Public IniPath As String
Public MapPath As String


'Bordes del mapa
Public MinXBorder As Byte
Public MaxXBorder As Byte
Public MinYBorder As Byte
Public MaxYBorder As Byte

'Status del user
Public CurMap As Integer        'Mapa actual
Public UserIndex As Integer
Public UserMoving As Byte
Public UserBody As Integer
Public UserPos As Position        'Posicion
Public AddtoUserPos As Position        'Si se mueve
Public UserCharIndex As Integer

Public EngineRun As Boolean

Public fps As Long
Public FramesPerSecCounter As Long
Public fpsLastCheck As Long

'Tamaño del la vista en Tiles
Public WindowTileWidth As Integer
Public WindowTileHeight As Integer

Public HalfWindowTileWidth As Integer
Public HalfWindowTileHeight As Integer

'Offset del desde 0,0 del main view
Private MainViewTop As Integer
Private MainViewLeft As Integer

'Cuantos tiles el engine mete en el BUFFER cuando
'dibuja el mapa. Ojo un tamaño muy grande puede
'volver el engine muy lento
Public TileBufferSize As Integer

Private TileBufferPixelOffsetX As Integer
Private TileBufferPixelOffsetY As Integer

'Tamaño de los tiles en pixels
Public Const TilePixelHeight As Integer = 32
Public Const TilePixelWidth As Integer = 32

'Number of pixels the engine scrolls per frame. MUST divide evenly into pixels per tile
Public ScrollPixelsPerFrameX As Integer
Public ScrollPixelsPerFrameY As Integer

Public timerElapsedTime As Single
Dim timerTicksPerFrame As Single

Public engineBaseSpeed As Single


Public NumBodies As Integer
Public Numheads As Integer
Public NumFxs As Integer

Public NumChars As Integer
Public LastChar As Integer
Public NumWeaponAnims As Integer
Public NumShieldAnims As Integer

Public MainViewRect As D3DRECT

Private MainViewWidth As Integer
Private MainViewHeight As Integer

Private MouseTileX As Byte
Private MouseTileY As Byte




'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿Graficos¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?
Public GrhData() As GrhData        'Guarda todos los grh
Public BodyData() As BodyData
Public HeadData() As HeadData
Public FxData() As tIndiceFx
Public WeaponAnimData() As WeaponAnimData
Public ShieldAnimData() As ShieldAnimData
Public CascoAnimData() As HeadData
'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?

'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿Mapa?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?
Public MapData() As MapBlock        ' Mapa
Public MapInfo As MapInfo        ' Info acerca del mapa en uso
'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?

Public bRain As Boolean        'está raineando?
Public bTecho As Boolean        'hay techo?
Public brstTick As Long

Private RLluvia(7) As RECT        'RECT de la lluvia
Private LTLluvia(4) As Integer

Public charlist(1 To 10000) As Char

' Used by GetTextExtentPoint32
Private Type Size
    cx As Long
    cy As Long
End Type

'[CODE 001]:MatuX
Public Enum PlayLoop
    plNone = 0
    plLluviain = 1
    plLluviaout
End Enum


Public Partitioner_ As Partitioner


'Very percise counter 64bit system counter
Private Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As Currency) As Long
Private Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As Currency) As Long

'Text width computation. Needed to center text.
Private Declare Function GetTextExtentPoint32 Lib "gdi32" Alias "GetTextExtentPoint32A" (ByVal hdc As Long, ByVal lpsz As String, ByVal cbString As Long, lpSize As Size) As Long

Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long


Sub ConvertCPtoTP(ByVal viewPortX As Integer, ByVal viewPortY As Integer, ByRef tX As Byte, ByRef tY As Byte)
'******************************************
'Converts where the mouse is in the main window to a tile position. MUST be called eveytime the mouse moves.
'******************************************
    On Error Resume Next
    If UserPos.Y = 0 Then Exit Sub
    If UserPos.X = 0 Then Exit Sub
    tX = UserPos.X + viewPortX \ TilePixelWidth - WindowTileWidth \ 2
    tY = UserPos.Y + viewPortY \ TilePixelHeight - WindowTileHeight \ 2
End Sub

Sub MakeChar(ByVal Char_IndexArray As Integer, ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, ByVal X As Integer, ByVal Y As Integer, ByVal Arma As Integer, ByVal Escudo As Integer, ByVal Casco As Integer)

    On Error GoTo hErr

    'Apuntamos al ultimo Char
    If Char_IndexArray > LastChar Then
        LastChar = Char_IndexArray
        'ReDim Preserve CharList(1 To LastChar)
    End If

    With charlist(Char_IndexArray)
        'If the char wasn't allready active (we are rewritting it) don't increase char count
        If .Active = 0 Then _
           NumChars = NumChars + 1

        If Arma = 0 Then Arma = 2
        If Escudo = 0 Then Escudo = 2
        If Casco = 0 Then Casco = 2

        .iHead = Head
        .iBody = Body
        .Head = HeadData(Head)
        .Body = BodyData(Body)

        .Arma = WeaponAnimData(Arma)

        .Escudo = ShieldAnimData(Escudo)
        .Casco = CascoAnimData(Casco)
        .iCasco = Casco
        .Heading = Heading

        .ID = Char_IndexArray


        'Reset moving stats
        .Moving = 0
        .MoveOffsetX = 0
        .MoveOffsetY = 0

        'Update position
        .Pos.X = X
        .Pos.Y = Y

        'Make active
        .Active = 1
        
        Set .Emitter = modEngine_Audio.CreateEmitter(X, Y)
        
        'Call UpdateSceneCharacter(CharIndex)
        'Call Partitioner_.Insert(.Node)
        
        'Dim loopC As Long
        'For loopC = 1 To 4
        '    .Proyectil(loopC).Usado = False
        'Next loopC

    End With

    'Plot on map
    MapData(X, Y).CharIndex = Char_IndexArray

    Exit Sub
hErr:
    Char_Remove Char_IndexArray
End Sub

Public Sub Char_Remove(ByVal CharIndex As Integer)

'Make sure it's a legal index
    If Char_Check(CharIndex) Then
        Call Char_Destroy(CharIndex)

        If CharIndex = UserCharIndex Then
            UserCharIndex = 0
        End If
    End If

End Sub
Private Sub Char_Destroy(ByVal CharIndex As Integer)

    Dim Temp As Char

    If InMapBounds(charlist(CharIndex).Pos.X, charlist(CharIndex).Pos.Y) Then
        MapData(charlist(CharIndex).Pos.X, charlist(CharIndex).Pos.Y).CharIndex = 0
    End If


    Dim LastID As Integer
    LastID = charlist(CharIndex).ID

    charlist(CharIndex) = Temp
    charlist(CharIndex).ID = LastID

    'Update array size
    If CharIndex = LastChar Then

        Do Until charlist(LastChar).Active = 1
            LastChar = LastChar - 1
            If LastChar < 1 Then Exit Sub
        Loop

        'ReDim Preserve CharList(1 To LastChar)

    End If

    'Remove char's dialog
    Call Dialogos.RemoveDialog(CharIndex)

End Sub

Public Function Engine_GetAngle(ByVal CenterX As Integer, ByVal CenterY As Integer, ByVal TargetX As Integer, ByVal TargetY As Integer) As Single
'************************************************************
'Gets the angle between two points in a 2d plane
'************************************************************
    Dim SideA As Single
    Dim SideC As Single

    On Error GoTo ErrOut

    'Check for horizontal lines (90 or 270 degrees)
    If CenterY = TargetY Then

        'Check for going right (90 degrees)
        If CenterX < TargetX Then
            Engine_GetAngle = 90

            'Check for going left (270 degrees)
        Else
            Engine_GetAngle = 270
        End If

        'Exit the function
        Exit Function

    End If

    'Check for horizontal lines (360 or 180 degrees)
    If CenterX = TargetX Then

        'Check for going up (360 degrees)
        If CenterY > TargetY Then
            Engine_GetAngle = 360

            'Check for going down (180 degrees)
        Else
            Engine_GetAngle = 180
        End If

        'Exit the function
        Exit Function

    End If

    'Calculate Side C
    SideC = Sqr(Abs(TargetX - CenterX) ^ 2 + Abs(TargetY - CenterY) ^ 2)

    'Side B = CenterY

    'Calculate Side A
    SideA = Sqr(Abs(TargetX - CenterX) ^ 2 + TargetY ^ 2)

    'Calculate the angle
    Engine_GetAngle = (SideA ^ 2 - CenterY ^ 2 - SideC ^ 2) / (CenterY * SideC * -2)
    Engine_GetAngle = (Atn(-Engine_GetAngle / Sqr(-Engine_GetAngle * Engine_GetAngle + 1)) + 1.5708) * 57.29583

    'If the angle is >180, subtract from 360
    If TargetX < CenterX Then Engine_GetAngle = 360 - Engine_GetAngle

    Exit Function

    'Check for error
ErrOut:

    'Return a 0 saying there was an error
    Engine_GetAngle = 0
    Exit Function

End Function

Sub ResetCharInfo(ByVal CharIndex As Integer)
    With charlist(CharIndex)
        .Active = 0
        .Criminal = 0
        .Atacable = False
        .FxIndex = 0
        .Invisible = False
        .Oculto = False

        .Moving = 0
        .muerto = False
        .nombre = ""
        .Mimetizado = False
        .isFaccion = 0
        .clan = ""
        .pie = False
        .Pos.X = 0
        .Pos.Y = 0
        .color = 0
    End With
End Sub

Sub EraseChar(ByVal CharIndex As Integer)
'*****************************************************************
'Erases a character from CharList and map
'*****************************************************************
    On Error Resume Next
    charlist(CharIndex).Active = 0

    'Update lastchar
    If CharIndex = LastChar Then
        Do Until charlist(LastChar).Active = 1
            LastChar = LastChar - 1
            If LastChar = 0 Then Exit Do
        Loop
    End If
    
    'Call Partitioner_.Remove(charlist(CharIndex).Node)

    If Not (charlist(CharIndex).Pos.X = 0 Or charlist(CharIndex).Pos.Y = 0) Then
        MapData(charlist(CharIndex).Pos.X, charlist(CharIndex).Pos.Y).CharIndex = 0
    End If

    'Remove char's dialog
    Call Dialogos.RemoveDialog(CharIndex)
    
    Call ResetCharInfo(CharIndex)
    
    Call modEngine_Audio.DeleteEmitter(charlist(CharIndex).Emitter, False)
    
    'Update NumChars
    NumChars = NumChars - 1
End Sub

Public Sub InitGrh(ByRef Grh As Grh, ByVal GrhIndex As Integer, Optional ByVal Started As Byte = 2)
'*****************************************************************
'Sets up a grh. MUST be done before rendering
'*****************************************************************
    Grh.GrhIndex = GrhIndex
    If GrhIndex > UBound(GrhData) Then Exit Sub
    If Started = 2 Then
        If GrhData(Grh.GrhIndex).NumFrames > 1 Then
            Grh.Started = 1
        Else
            Grh.Started = 0
        End If
    Else
        'Make sure the graphic can be started
        If GrhData(Grh.GrhIndex).NumFrames = 1 Then Started = 0
        Grh.Started = Started
    End If


    If Grh.Started Then
        Grh.Loops = INFINITE_LOOPS
    Else
        Grh.Loops = 0
    End If

    Grh.FrameCounter = 1
    Grh.Speed = GrhData(Grh.GrhIndex).Speed
End Sub

Sub MoveCharbyHead(ByVal CharIndex As Integer, ByVal nHeading As E_Heading)
'*****************************************************************
'Starts the movement of a character in nHeading direction
'*****************************************************************
    Dim addX As Integer
    Dim addY As Integer
    Dim X As Integer
    Dim Y As Integer
    Dim nX As Integer
    Dim nY As Integer
    On Error Resume Next
    With charlist(CharIndex)
        X = .Pos.X
        Y = .Pos.Y

        'Figure out which way to move
        Select Case nHeading
        Case E_Heading.NORTH
            addY = -1

        Case E_Heading.EAST
            addX = 1

        Case E_Heading.SOUTH
            addY = 1

        Case E_Heading.WEST
            addX = -1
        End Select

        nX = X + addX
        nY = Y + addY
        If Not (nX <= 1 Or nY <= 1) Then
            MapData(nX, nY).CharIndex = CharIndex
        Else
            Exit Sub
        End If
        .Pos.X = nX
        .Pos.Y = nY
        MapData(X, Y).CharIndex = 0
        
        Call modEngine_Audio.UpdateEmitter(.Emitter, nX, nY)
        'Call UpdateSceneCharacter(CharIndex)
        'Call Partitioner_.Update(.Node)

        .MoveOffsetX = -1 * (TilePixelWidth * addX)
        .MoveOffsetY = -1 * (TilePixelHeight * addY)

        .Moving = 1
        .Heading = nHeading

        .scrollDirectionX = addX
        .scrollDirectionY = addY
    End With
    
    If UserEstado <> 1 Then Call DoPasosFx(CharIndex)
    
    'areas viejos
    If (nY < MinLimiteY) Or (nY > MaxLimiteY) Or (nX < MinLimiteX) Or (nX > MaxLimiteX) Then
        If CharIndex <> UserCharIndex Then
            Call EraseChar(CharIndex)
        End If
    End If
End Sub

Public Sub DoFogataFx()
    Dim location As Audio_Emitter
    
    
    If bFogata Then
        bFogata = HayFogata(location)
        If Not bFogata Then
           ' Call Audio.StopWave(FogataBufferIndex)
           RainBufferIndex = modEngine_Audio.PlayEffect("lluviain.wav")
            FogataBufferIndex = 0
        End If
    Else
        bFogata = HayFogata(location)
        If bFogata And FogataBufferIndex = 0 Then
            FogataBufferIndex = modEngine_Audio.PlayEffect("fuego.wav", location) 'modEngine_Audio.PlayEffect("fuego.wav", location.X, location.Y, LoopStyle.Enabled)
        End If
    End If
End Sub

Private Function EstaPCarea(ByVal CharIndex As Integer) As Boolean
    With charlist(CharIndex).Pos
        EstaPCarea = .X > UserPos.X - MinXBorder And .X < UserPos.X + MinXBorder And .Y > UserPos.Y - MinYBorder And .Y < UserPos.Y + MinYBorder
    End With
End Function

Sub DoPasosFx(ByVal CharIndex As Integer)

    If CharIndex = UserCharIndex Then
        If SoyGM Then
            If charlist(CharIndex).Invisible Then Exit Sub
        End If
    End If

    If charlist(CharIndex).muerto Then Exit Sub

    If Not UserNavegando Then
        With charlist(CharIndex)
            If Not esGM(CharIndex) Or CharIndex = UserCharIndex Then
                If Not .muerto And EstaPCarea(CharIndex) Then
                    .pie = Not .pie
                    If .pie Then
                        Call modEngine_Audio.PlayEffect(SND_PASOS1, .Emitter)
                    Else
                        Call modEngine_Audio.PlayEffect(SND_PASOS2, .Emitter)
                    End If
                End If
            End If
        End With
    Else
        ' TODO : Actually we would have to check if the CharIndex char is in the water or not....
        Call modEngine_Audio.PlayEffect(SND_NAVEGANDO, charlist(CharIndex).Emitter)
    End If

End Sub
Sub MoveCharbyPos(ByVal CharIndex As Integer, ByVal nX As Integer, ByVal nY As Integer)
    On Error Resume Next
    Dim X As Integer
    Dim Y As Integer
    Dim addX As Integer
    Dim addY As Integer
    Dim nHeading As E_Heading

    With charlist(CharIndex)
        X = .Pos.X
        Y = .Pos.Y

        MapData(X, Y).CharIndex = 0

        addX = nX - X
        addY = nY - Y

        If Sgn(addX) = 1 Then
            nHeading = E_Heading.EAST
        ElseIf Sgn(addX) = -1 Then
            nHeading = E_Heading.WEST
        ElseIf Sgn(addY) = -1 Then
            nHeading = E_Heading.NORTH
        ElseIf Sgn(addY) = 1 Then
            nHeading = E_Heading.SOUTH
        End If

        MapData(nX, nY).CharIndex = CharIndex

        .Pos.X = nX
        .Pos.Y = nY

        .MoveOffsetX = -1 * (TilePixelWidth * addX)
        .MoveOffsetY = -1 * (TilePixelHeight * addY)

        .Moving = 1
        .Heading = nHeading

        .scrollDirectionX = Sgn(addX)
        .scrollDirectionY = Sgn(addY)

        'parche para que no medite cuando camina
        If .FxIndex = FxMeditar.CHICO Or .FxIndex = FxMeditar.GRANDE Or .FxIndex = FxMeditar.MEDIANO Or .FxIndex = FxMeditar.XGRANDE Or .FxIndex = FxMeditar.XXGRANDE Then
            .FxIndex = 0
        End If
    
        Call modEngine_Audio.UpdateEmitter(.Emitter, nX, nY)
        'Call UpdateSceneCharacter(CharIndex)
        'Call Partitioner_.Update(.Node)
        
        'Call DoPasosFx(CharIndex)
        
    End With

    If Not EstaPCarea(CharIndex) Then Call Dialogos.RemoveDialog(CharIndex)

    If (nY < MinLimiteY) Or (nY > MaxLimiteY) Or (nX < MinLimiteX) Or (nX > MaxLimiteX) Then
        Call EraseChar(CharIndex)
    End If
End Sub

Sub MoveScreen(ByVal nHeading As E_Heading)
'******************************************
'Starts the screen moving in a direction
'******************************************
    Dim X As Integer
    Dim Y As Integer
    Dim tX As Integer
    Dim tY As Integer

    'Figure out which way to move
    Select Case nHeading
    Case E_Heading.NORTH
        Y = -1

    Case E_Heading.EAST
        X = 1

    Case E_Heading.SOUTH
        Y = 1

    Case E_Heading.WEST
        X = -1
    End Select

    'Fill temp pos
    tX = UserPos.X + X
    tY = UserPos.Y + Y

    'Check to see if its out of bounds
    If tX < MinXBorder Or tX > MaxXBorder Or tY < MinYBorder Or tY > MaxYBorder Then
        Exit Sub
    Else
        'Start moving... MainLoop does the rest
        AddtoUserPos.X = X
        UserPos.X = tX
        AddtoUserPos.Y = Y
        UserPos.Y = tY
        UserMoving = 1

        bTecho = IIf(MapData(UserPos.X, UserPos.Y).Trigger = 1 Or _
                     MapData(UserPos.X, UserPos.Y).Trigger = 2 Or _
                     MapData(UserPos.X, UserPos.Y).Trigger = 4, True, False)
        bTecho = bTecho Or MapData(UserPos.X, UserPos.Y).Trigger = 8

        ' Debug.Print Now, UserPos.X, UserPos.Y, "Layer1:" & MapData(UserPos.X, UserPos.Y).Graphic(1).GrhIndex, "Layer2:" & MapData(UserPos.X, UserPos.Y).Graphic(2).GrhIndex, "Layer3:" & MapData(UserPos.X, UserPos.Y).Graphic(3).GrhIndex, "Object:" & MapData(UserPos.X, UserPos.Y).ObjGrh.GrhIndex

    End If
End Sub

Private Function HayFogata(ByRef location As Audio_Emitter) As Boolean
    Dim j As Long
    Dim k As Long

    For j = UserPos.X - 8 To UserPos.X + 8
        For k = UserPos.Y - 6 To UserPos.Y + 6
            If InMapBounds(j, k) Then
                If MapData(j, k).ObjGrh.GrhIndex = GrhFogata Then
                    'location.X = j
                    'location.Y = k
                    HayFogata = True
                    Exit Function
                End If
            End If
        Next k
    Next j
End Function

Function NextOpenChar() As Integer
'*****************************************************************
'Finds next open char slot in CharList
'*****************************************************************
    Dim LoopC As Long
    Dim Dale As Boolean

    LoopC = 1
    Do While charlist(LoopC).Active And Dale
        LoopC = LoopC + 1
        Dale = (LoopC <= UBound(charlist))
    Loop

    NextOpenChar = LoopC
End Function

''
' Loads grh data using the new file format.
'
' @return   True if the load was successfull, False otherwise.

Private Function LoadGrhData() As Boolean
    On Error GoTo errorhandler
    Dim Grh As Long
    Dim Frame As Long
    Dim grhCount As Long
    Dim handle As Integer
    Dim fileVersion As Long
    Dim File As String

    File = Get_FileFrom(Scripts, "graficos.ind")

    'Open files
    handle = FreeFile()

    Open File For Binary Access Read As handle
    Seek #1, 1

    'Get file version
    Get handle, , fileVersion

    'Get number of grhs
    Get handle, , grhCount

    'Resize arrays
    ReDim GrhData(0 To grhCount) As GrhData

    While Not EOF(handle)
        Get handle, , Grh

        With GrhData(Grh)
            'Get number of frames
            Get handle, , .NumFrames
            If .NumFrames <= 0 Then
                GoTo errorhandler
            End If

            ReDim .Frames(1 To GrhData(Grh).NumFrames)

            If .NumFrames > 1 Then
                'Read a animation GRH set
                For Frame = 1 To .NumFrames
                    Get handle, , .Frames(Frame)
                    If .Frames(Frame) <= 0 Or .Frames(Frame) > grhCount Then
                        GoTo errorhandler
                    End If
                Next Frame

                Get handle, , .Speed

                If .Speed <= 0 Then
                    GoTo errorhandler
                End If

                'Compute width and height
                .pixelHeight = GrhData(.Frames(1)).pixelHeight
                If .pixelHeight <= 0 Then
                    GoTo errorhandler
                End If
                .pixelWidth = GrhData(.Frames(1)).pixelWidth
                If .pixelWidth <= 0 Then
                    GoTo errorhandler
                End If

                .TileWidth = GrhData(.Frames(1)).TileWidth
                If .TileWidth <= 0 Then
                    GoTo errorhandler
                End If

                .TileHeight = GrhData(.Frames(1)).TileHeight
                If .TileHeight <= 0 Then
                    GoTo errorhandler
                End If

            Else
                'Read in normal GRH data
                Get handle, , .FileNum
                If .FileNum <= 0 Then
                    GoTo errorhandler
                End If

                Get handle, , GrhData(Grh).sX
                If .sX < 0 Then
                    GoTo errorhandler
                End If

                Get handle, , .sY
                If .sY < 0 Then
                    GoTo errorhandler
                End If

                Get handle, , .pixelWidth
                If .pixelWidth <= 0 Then
                    GoTo errorhandler
                End If

                Get handle, , .pixelHeight
                If .pixelHeight <= 0 Then
                    GoTo errorhandler
                End If

                'Compute width and height
                .TileWidth = .pixelWidth / TilePixelHeight
                .TileHeight = .pixelHeight / TilePixelWidth

                .Frames(1) = Grh
            End If

        End With
    Wend

    Close handle

    Delete_File (File)

    LoadGrhData = True
    Exit Function

errorhandler:
    LoadGrhData = False

    Close handle

    Delete_File (File)

End Function

Function LegalPos(ByVal X As Integer, ByVal Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is legal
'*****************************************************************
'Limites del mapa
    If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
        Exit Function
    End If

    'Tile Bloqueado?
    If MapData(X, Y).Blocked = 1 Then
        Exit Function
    End If

    '¿Hay un personaje?
    If MapData(X, Y).CharIndex > 0 Then
        Exit Function
    End If

    If UserNavegando <> HayAgua(X, Y) Then
        Exit Function
    End If

    LegalPos = True
End Function

Function MoveToLegalPos(ByVal X As Integer, ByVal Y As Integer) As Boolean
'*****************************************************************
'Author: ZaMa
'Last Modify Date: 01/08/2009
'Checks to see if a tile position is legal, including if there is a casper in the tile
'10/05/2009: ZaMa - Now you can't change position with a casper which is in the shore.
'01/08/2009: ZaMa - Now invisible admins can't change position with caspers.
'*****************************************************************
    Dim CharIndex As Integer

    'Limites del mapa
    If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
        Exit Function
    End If

    'Tile Bloqueado?
    If MapData(X, Y).Blocked = 1 Then
        Exit Function
    End If

    CharIndex = MapData(X, Y).CharIndex
    '¿Hay un personaje?
    If CharIndex > 0 Then

        If MapData(UserPos.X, UserPos.Y).Blocked = 1 Then
            Exit Function
        End If

        With charlist(CharIndex)
            ' Si no es casper, no puede pasar
            If (.iHead <> CASPER_HEAD_CIUDA And .iHead <> CASPER_HEAD_PK And .iBody <> FRAGATA_FANTASMAL) Or .iHead = 99 Then
                Exit Function
            Else
                ' No puedo intercambiar con un casper que este en la orilla (Lado tierra)
                If HayAgua(UserPos.X, UserPos.Y) Then
                    If Not HayAgua(X, Y) Then Exit Function
                Else
                    ' No puedo intercambiar con un casper que este en la orilla (Lado agua)
                    If HayAgua(X, Y) Then Exit Function
                End If

                ' Los admins no pueden intercambiar pos con caspers cuando estan invisibles
                If esGM(UserCharIndex) Then
                    Exit Function
                    If charlist(UserCharIndex).Invisible = True Then Exit Function
                    If charlist(UserCharIndex).Oculto = True Then Exit Function
                End If
            End If
        End With
    End If

    If Not esGM(UserCharIndex) Then
        If UserNavegando <> HayAgua(X, Y) Then
            Exit Function
        End If
    End If

    MoveToLegalPos = True
End Function

Function InMapBounds(ByVal X As Integer, ByVal Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is in the maps bounds
'*****************************************************************
    If X < XMinMapSize Or X > XMaxMapSize Or Y < YMinMapSize Or Y > YMaxMapSize Then
        Exit Function
    End If

    InMapBounds = True
End Function

Sub DDrawGrhtoSurface(ByRef Grh As Grh, ByVal X As Integer, ByVal Y As Integer, ByVal Center As Byte, ByRef Color_List() As Long, ByVal Animate As Byte, Optional Alpha As Boolean = False)

    Dim CurrentGrhIndex As Integer

    If Grh.GrhIndex = 0 Then Exit Sub

    On Error GoTo Error

    If Animate And GrhData(Grh.GrhIndex).NumFrames > 0 Then
        If Grh.Started = 1 Then
            Grh.FrameCounter = Grh.FrameCounter + (timerElapsedTime * GrhData(Grh.GrhIndex).NumFrames / Grh.Speed) * Movement_Speed

            If Grh.FrameCounter > GrhData(Grh.GrhIndex).NumFrames Then
                Grh.FrameCounter = (Grh.FrameCounter Mod GrhData(Grh.GrhIndex).NumFrames) + 1

                If Grh.Loops <> INFINITE_LOOPS Then
                    If Grh.Loops > 0 Then
                        Grh.Loops = Grh.Loops - 1
                    Else
                        Grh.Started = 0
                    End If
                End If

            End If
        End If
    End If

    'Figure out what frame to draw (always 1 if not animated)
    'If Grh.GrhIndex = 1525 Or Grh.GrhIndex = 1523 Or Grh.GrhIndex = 1524 Or Grh.GrhIndex = 591 Or Grh.GrhIndex = 538 Or Grh.GrhIndex = 539 Then
    'Grh.GrhIndex = 1
    'Grh.FrameCounter = 1
    'End If

    If Grh.GrhIndex < UBound(GrhData()) Then
        If Grh.FrameCounter = 0 Then Grh.FrameCounter = 1
        CurrentGrhIndex = GrhData(Grh.GrhIndex).Frames(Grh.FrameCounter)

        With GrhData(CurrentGrhIndex)
            'Center Grh over X,Y pos
            If Center Then
                If .TileWidth <> 1 Then
                    X = X - Int(.TileWidth * TilePixelWidth / 2) + TilePixelWidth \ 2
                End If

                If .TileHeight <> 1 Then
                    Y = Y - Int(.TileHeight * TilePixelHeight) + TilePixelHeight
                End If
            End If

            Call Directx_Render_Texture(.FileNum, X, Y, .pixelHeight, .pixelWidth, .sX, .sY, Color_List(), 0, False, Alpha)
        End With
    End If
    Exit Sub

Error:
    If Err.Number = 9 And Grh.FrameCounter < 1 Then
        Grh.FrameCounter = 1
        Resume
    Else
        'Call MsgBox("Error en el Engine Gráfico, Por favor contacte a los adminsitradores enviandoles el archivo Errores.Log que se encuentra el la carpeta del cliente.", vbCritical)
        'Call CloseClient
    End If
End Sub

Sub DDrawTransGrhIndextoSurface(ByVal GrhIndex As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal Center As Byte, ByRef Color_List() As Long, Optional ByVal Angle As Single = 0, Optional ByVal Alpha As Boolean = False)

    If GrhIndex > UBound(GrhData) Then Exit Sub

    With GrhData(GrhIndex)

        'Center Grh over X,Y pos
        If Center Then
            If .TileWidth <> 1 Then
                X = X - Int(.TileWidth * TilePixelWidth / 2) + TilePixelWidth \ 2
            End If

            If .TileHeight <> 1 Then
                Y = Y - Int(.TileHeight * TilePixelHeight) + TilePixelHeight
            End If
        End If

        Call SpriteBatch.SetAlpha(True)

        'Draw
        Call Directx_Render_Texture(.FileNum, X, Y, .pixelHeight, .pixelWidth, .sX, .sY, Color_List(), Angle, Alpha)

    End With

End Sub

Public Function ArrayToPicturePNG(pngData() As Byte) As IPicture

    Dim hIcon As Long
    Dim lpPictDesc(0 To 3) As Long, aGUID(0 To 3) As Long

    hIcon = CreateIconFromResourceEx(pngData(0), UBound(pngData) + 1&, 1&, &H30000, 0&, 0&, 0&)

    If hIcon Then
        lpPictDesc(0) = 16&
        lpPictDesc(1) = vbPicTypeIcon
        lpPictDesc(2) = hIcon
        ' IPicture GUID {7BF80980-BF32-101A-8BBB-00AA00300CAB}
        aGUID(0) = &H7BF80980
        aGUID(1) = &H101ABF32
        aGUID(2) = &HAA00BB8B
        aGUID(3) = &HAB0C3000

        ' create stdPicture
        If OleCreatePictureIndirect(lpPictDesc(0), aGUID(0), True, ArrayToPicturePNG) Then
            DestroyIcon hIcon
        End If
    End If

End Function

Public Function ArrayToPictureBMP(bmpData() As Byte, Size As Long) As IPicture

    Dim o_hMem As Long
    Dim o_lpMem As Long
    Dim aGUID(0 To 3) As Long
    Dim IIStream As IUnknown

    o_hMem = GlobalAlloc(&H2&, Size)
    If Not o_hMem = 0& Then
        o_lpMem = GlobalLock(o_hMem)
        If Not o_lpMem = 0& Then
            CopyMemory ByVal o_lpMem, bmpData(0), Size
            Call GlobalUnlock(o_hMem)
            If CreateStreamOnHGlobal(o_hMem, 1&, IIStream) = 0& Then
                aGUID(0) = &H7BF80980
                aGUID(1) = &H101ABF32
                aGUID(2) = &HAA00BB8B
                aGUID(3) = &HAB0C3000

                Call OleLoadPicture(ByVal ObjPtr(IIStream), 0&, 0&, aGUID(0), ArrayToPictureBMP)
            End If
        End If
    End If
End Function

Sub DrawGrhtoHdc(ByVal DesthDC As Long, ByVal grh_index As Integer, ByRef SourceRect As RECT, ByRef destRect As RECT)

    Dim file_path As String
    Dim src_x As Integer
    Dim src_y As Integer
    Dim src_width As Integer
    Dim src_height As Integer
    Dim HdcSrc As Long
    Dim PrevObj As Long
    Dim screen_x As Integer
    Dim screen_y As Integer

    Dim InfoHead As INFOHEADER

    InfoHead = File_Find(App.Path & "\GRAFICOS\Graphics.TDSL", CStr(GrhData(grh_index).FileNum) & ".bmp")


    If grh_index <= 0 Then Exit Sub

    If GrhData(grh_index).NumFrames <> 1 Then
        grh_index = GrhData(grh_index).Frames(1)
    End If

    file_path = Get_FileFrom(Graphics, CStr(GrhData(grh_index).FileNum) & ".bmp")

    screen_x = destRect.Left
    screen_y = destRect.Top

    src_x = GrhData(grh_index).sX
    src_y = GrhData(grh_index).sY
    src_width = GrhData(grh_index).pixelWidth
    src_height = GrhData(grh_index).pixelHeight

    HdcSrc = CreateCompatibleDC(DesthDC)

    PrevObj = SelectObject(HdcSrc, LoadPicture(file_path))

    BitBlt DesthDC, screen_x, screen_y, src_width, src_height, HdcSrc, src_x, src_y, vbSrcCopy

    DeleteDC HdcSrc
    Delete_File file_path

End Sub

Public Sub DrawTransparentGrhtoHdc(ByVal dsthdc As Long, ByVal srchDC As Long, ByRef SourceRect As RECT, ByRef destRect As RECT, ByVal TransparentColor)
    Dim color As Long
    Dim X As Long
    Dim Y As Long

    For X = SourceRect.Left To SourceRect.Right
        For Y = SourceRect.Top To SourceRect.Bottom
            color = GetPixel(srchDC, X, Y)

            If color <> TransparentColor Then
                Call SetPixel(dsthdc, destRect.Left + (X - SourceRect.Left), destRect.Top + (Y - SourceRect.Top), color)
            End If
        Next Y
    Next X
End Sub

Public Sub DrawImageInPicture(ByRef PictureBox As PictureBox, ByRef Picture As StdPicture, ByVal X1 As Single, ByVal Y1 As Single, Optional Width1, Optional Height1, Optional X2, Optional Y2, Optional Width2, Optional Height2)
    Call PictureBox.PaintPicture(Picture, X1, Y1, Width1, Height1, X2, Y2, Width2, Height2)
End Sub

Sub RenderScreen(ByVal tilex As Integer, ByVal tiley As Integer, ByVal PixelOffsetX As Integer, ByVal PixelOffsetY As Integer)

    Dim Y As Long        'Keeps track of where on map we are
    Dim X As Long        'Keeps track of where on map we are
    Dim j As Long

    Dim ScreenmaxY As Integer        'End Y pos on current screen
    Dim ScreenmaxX As Integer        'End X pos on current screen
    Dim ScreenX As Integer        'Keeps track of where to place tile on screen
    Dim ScreenY As Integer        'Keeps track of where to place tile on screen
    Dim minXOffset As Integer
    Dim minYOffset As Integer

    'Figure out Ends and Starts of screen
    ScreenminY = tiley - HalfWindowTileHeight
    ScreenmaxY = tiley + HalfWindowTileHeight
    ScreenminX = tilex - HalfWindowTileWidth
    ScreenmaxX = tilex + HalfWindowTileWidth

    minY = ScreenminY - TileBufferSize
    maxY = ScreenmaxY + TileBufferSize
    minX = ScreenminX - TileBufferSize
    maxX = ScreenmaxX + TileBufferSize

    If tSetup.NightMode = True And esDeNoche = True Then
        If LogAlpha > 155 Then LogAlpha = validbyte(LogAlpha - 3)
        If LogAlpha < 153 Then LogAlpha = validbyte(LogAlpha + 3)
        lvalue(0) = D3DColorXRGB(LogAlpha, LogAlpha, LogAlpha + IIf(LogAlpha > 180, 0, LogAlpha / 5))
    Else
        If LogAlpha < 255 Then LogAlpha = validbyte(LogAlpha + 3)
        If 255 < LogAlpha Then LogAlpha = validbyte(LogAlpha - 3)
        lvalue(0) = D3DColorXRGB(LogAlpha, LogAlpha, LogAlpha)
    End If
    lvalue(1) = lvalue(0)
    lvalue(2) = lvalue(0)
    lvalue(3) = lvalue(0)

    'Make sure mins and maxs are allways in map bounds
    If minY < XMinMapSize Then
        minYOffset = YMinMapSize - minY
        minY = YMinMapSize
    End If

    If maxY > YMaxMapSize Then maxY = YMaxMapSize

    If minX < XMinMapSize Then
        minXOffset = XMinMapSize - minX
        minX = XMinMapSize
    End If

    If maxX > XMaxMapSize Then maxX = XMaxMapSize

    'If we can, we render around the view area to make it smoother
    If ScreenminY > YMinMapSize Then
        ScreenminY = ScreenminY - 1
    Else
        ScreenminY = 1
        ScreenY = 1
    End If

    If ScreenmaxY < YMaxMapSize Then ScreenmaxY = ScreenmaxY + 1

    If ScreenminX > XMinMapSize Then
        ScreenminX = ScreenminX - 1
    Else
        ScreenminX = 1
        ScreenX = 1
    End If

    If ScreenmaxX < XMaxMapSize Then ScreenmaxX = ScreenmaxX + 1

    'Draw floor layer
    For Y = ScreenminY To ScreenmaxY
        PixelOffsetYTemp = (ScreenY - 1) * TilePixelHeight + PixelOffsetY
        For X = ScreenminX To ScreenmaxX
            PixelOffsetXTemp = (ScreenX - 1) * TilePixelWidth + PixelOffsetX

            'Layer 1 **********************************

            If MapData(X, Y).Graphic(1).GrhIndex > 1 Then
                Call DDrawGrhtoSurface(MapData(X, Y).Graphic(1), _
                                       PixelOffsetXTemp, _
                                       PixelOffsetYTemp, _
                                       0, lvalue(), IIf(tSetup.TerrainAnim > 0, 1, 0))
            End If
            '******************************************

            'Layer 2 **********************************
            If MapData(X, Y).Graphic(2).GrhIndex <> 0 Then

                Call DDrawGrhtoSurface(MapData(X, Y).Graphic(2), _
                                       PixelOffsetXTemp, _
                                       PixelOffsetYTemp, _
                                       1, lvalue(), 1)
            End If
            '******************************************
            ScreenX = ScreenX + 1
        Next X

        'Reset ScreenX to original value and increment ScreenY
        ScreenX = ScreenX - X + ScreenminX
        ScreenY = ScreenY + 1
    Next Y
    
    
    Dim Results() As Partitioner_Item
    
    ' Get the entities from the quadtree.
    'Call Partitioner_.Query(minX - 1, minY - 1, maxX + 1, maxY + 1, Results)

    'Draw Transparent Layers
    ScreenY = minYOffset - TileBufferSize
    For Y = minY To maxY
        ScreenX = minXOffset - TileBufferSize
        PixelOffsetYTemp = ScreenY * TilePixelHeight + PixelOffsetY
        For X = minX To maxX
            PixelOffsetXTemp = ScreenX * TilePixelWidth + PixelOffsetX

            With MapData(X, Y)
                'Object Layer **********************************

                If .ObjGrh.GrhIndex <> 0 Or SoyGM Then
                    Call DDrawGrhtoSurface(.ObjGrh, PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                End If
                '***********************************************

                'Char layer ************************************
                If .CharIndex <> 0 Then
                    Call CharRender(.CharIndex, PixelOffsetXTemp, PixelOffsetYTemp)
                End If

                '*************************************************

                'Layer 3 *****************************************
                If EsArbol(.Graphic(3).GrhIndex) And tSetup.transArboles Or SoyGM Then
                    If (Y > (UserPos.Y - 2) And Y < (UserPos.Y + 7)) And (X > (UserPos.X - 4) And X < (UserPos.X + 4)) Then
                        If .Graphic(3).GrhIndex <> 0 Then
                            'Draw
                            If tSetup.AlphaBlending Then
                                Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lArboles, 1)
                            Else
                                Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                            End If
                        End If
                    Else
                        If (Y > (UserPos.Y - 8) And Y < (UserPos.Y + 14)) And (X > (UserPos.X - 12) And X < (UserPos.X + 12)) Then
                            If .Graphic(3).GrhIndex <> 0 Then
                                'Draw
                                Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                            End If
                        End If
                    End If
                Else
                    '1-39
                    If .Graphic(3).GrhIndex <> 0 Then

                        Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                        .Graphic(3).Speed = 666
                    End If

                End If

            End With

            ScreenX = ScreenX + 1
        Next X
        ScreenY = ScreenY + 1
    Next Y

    If tSetup.EfectosPelea Then

        ' ************** Projectiles **************
        If LastProjectile > 0 Then
            For j = 1 To LastProjectile
                If ProjectileList(j).Grh.GrhIndex Then
                    Dim Angle As Single
                    Angle = DegreeToRadian * Engine_GetAngle(ProjectileList(j).X, ProjectileList(j).Y, ProjectileList(j).tX, ProjectileList(j).tY)
                    ProjectileList(j).X = ProjectileList(j).X + (Sin(Angle) * timerElapsedTime * 0.63)
                    ProjectileList(j).Y = ProjectileList(j).Y - (Cos(Angle) * timerElapsedTime * 0.63)
                    Dim UserPosScreen As Position
                    UserPosScreen.X = UserPos.X - HalfWindowTileWidth
                    UserPosScreen.Y = UserPos.Y - HalfWindowTileHeight
                    X = -(UserPosScreen.X - 7) * 32 + ProjectileList(j).X + PixelOffsetX - 224
                    Y = -(UserPosScreen.Y - 7) * 32 + ProjectileList(j).Y + PixelOffsetY - 240
                    If Y >= -32 Then
                        If Y <= (ScreenHeight + 32) Then
                            If X >= -32 Then
                                If X <= (ScreenWidth + 32) Then
                                    Call DDrawTransGrhIndextoSurface(ProjectileList(j).Grh.GrhIndex, X, Y, 0, lvalue, ProjectileList(j).Rotate + 130)
                                End If
                            End If
                        End If
                    End If
                End If
            Next j
            For j = 1 To LastProjectile    'Check if it is close enough to the target to remove
                If ProjectileList(j).Grh.GrhIndex Then
                    If Abs(ProjectileList(j).X - ProjectileList(j).tX) < 20 Then
                        If Abs(ProjectileList(j).Y - ProjectileList(j).tY) < 20 Then
                            EraseProjectile j
                        End If
                    End If
                End If
            Next j
        End If
    End If

    If bRain Then
        If LastTickWeather < GetTickCount Then
            If GrhWeather <> 3 Then
                GrhWeather = GrhWeather + 1
            Else
                GrhWeather = 0
            End If

            LastTickWeather = GetTickCount + 100
        End If

        Dim valpha As Byte
        valpha = 150
        Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), valpha))

        Call SpriteBatch.SetTexture(SurfaceDB.Surface(12165 + GrhWeather))
        Call SpriteBatch.Draw(MainViewRect.X1, MainViewRect.Y1, MainViewRect.X2, MainViewRect.Y2, lvalue(), 0, 0, 1, 1)
    End If

    If tSetup.EfectosPelea Then
        For j = 1 To LastDamage
            If DamageList(j).Counter > 0 Then

                If tSetup.EfectosPelea Then
                    DamageList(j).Counter = DamageList(j).Counter - timerElapsedTime * 2

                    X = Engine_TPtoSPX(DamageList(j).Pos.X) - 7
                    Y = Engine_TPtoSPY(DamageList(j).Pos.Y) + (DamageList(j).Counter * 0.01) - 45

                    If DamageList(j).Counter <= 0 Then DamageList(j).Counter = 0
                    Call RenderTextureText(X, Y, DamageList(j).Value, D3DColorXRGB(DamageList(j).r, DamageList(j).g, DamageList(j).b), 70 + (DamageList(j).Counter * 0.08), False)
                End If
            Else
                EraseDamage j
            End If
        Next j

    End If

    If AlphaTecho < 1 Then Exit Sub

    If bTecho Then
        If Not tSetup.AlphaBlending Then Exit Sub
    End If

    ColorTechos(0) = Engine_Change_Alpha(lvalue(), AlphaTecho)
    ColorTechos(1) = ColorTechos(0)
    ColorTechos(2) = ColorTechos(0)
    ColorTechos(3) = ColorTechos(0)

    ScreenY = minYOffset - TileBufferSize

    For Y = minY To maxY
        ScreenX = minXOffset - TileBufferSize
        For X = minX To maxX
            'Layer 4 **********************************7
            If MapData(X, Y).Graphic(4).GrhIndex Then

                If SoyGM Then

                    If tSetup.AlphaBlending Then
                        Call DDrawGrhtoSurface(MapData(X, Y).Graphic(4), ScreenX * TilePixelWidth + PixelOffsetX, ScreenY * TilePixelHeight + PixelOffsetY, 1, lArboles, 1)
                    Else
                        Call DDrawGrhtoSurface(MapData(X, Y).Graphic(4), ScreenX * TilePixelWidth + PixelOffsetX, ScreenY * TilePixelHeight + PixelOffsetY, 1, lvalue, 1)
                    End If

                Else
                    Call DDrawGrhtoSurface(MapData(X, Y).Graphic(4), ScreenX * TilePixelWidth + PixelOffsetX, ScreenY * TilePixelHeight + PixelOffsetY, 1, ColorTechos, 1)
                End If


            End If
            '**********************************

            ScreenX = ScreenX + 1
        Next X
        ScreenY = ScreenY + 1
    Next Y

End Sub

Sub RenderScreen_GM(ByVal tilex As Integer, ByVal tiley As Integer, ByVal PixelOffsetX As Integer, ByVal PixelOffsetY As Integer)

    Dim Y As Long
    Dim X As Long
    Dim j As Long

    Dim ScreenmaxY As Integer
    Dim ScreenmaxX As Integer
    Dim ScreenX As Integer
    Dim ScreenY As Integer
    Dim minXOffset As Integer
    Dim minYOffset As Integer

    'Figure out Ends and Starts of screen
    ScreenminY = tiley - HalfWindowTileHeight
    ScreenmaxY = tiley + HalfWindowTileHeight
    ScreenminX = tilex - HalfWindowTileWidth
    ScreenmaxX = tilex + HalfWindowTileWidth

    minY = ScreenminY - TileBufferSize
    maxY = ScreenmaxY + TileBufferSize
    minX = ScreenminX - TileBufferSize
    maxX = ScreenmaxX + TileBufferSize

    If tSetup.NightMode = True And esDeNoche = True Then
        If LogAlpha > 155 Then LogAlpha = validbyte(LogAlpha - 3)
        If LogAlpha < 153 Then LogAlpha = validbyte(LogAlpha + 3)
        lvalue(0) = D3DColorXRGB(LogAlpha, LogAlpha, LogAlpha + IIf(LogAlpha > 180, 0, LogAlpha / 5))
    Else
        If LogAlpha < 255 Then LogAlpha = validbyte(LogAlpha + 3)
        If 255 < LogAlpha Then LogAlpha = validbyte(LogAlpha - 3)
        lvalue(0) = D3DColorXRGB(LogAlpha, LogAlpha, LogAlpha)
    End If
    lvalue(1) = lvalue(0)
    lvalue(2) = lvalue(0)
    lvalue(3) = lvalue(0)

    'Make sure mins and maxs are allways in map bounds
    If minY < XMinMapSize Then
        minYOffset = YMinMapSize - minY
        minY = YMinMapSize
    End If

    If maxY > YMaxMapSize Then maxY = YMaxMapSize

    If minX < XMinMapSize Then
        minXOffset = XMinMapSize - minX
        minX = XMinMapSize
    End If

    If maxX > XMaxMapSize Then maxX = XMaxMapSize

    'If we can, we render around the view area to make it smoother
    If ScreenminY > YMinMapSize Then
        ScreenminY = ScreenminY - 1
    Else
        ScreenminY = 1
        ScreenY = 1
    End If

    If ScreenmaxY < YMaxMapSize Then ScreenmaxY = ScreenmaxY + 1

    If ScreenminX > XMinMapSize Then
        ScreenminX = ScreenminX - 1
    Else
        ScreenminX = 1
        ScreenX = 1
    End If

    If ScreenmaxX < XMaxMapSize Then ScreenmaxX = ScreenmaxX + 1

    'Draw floor layer
    For Y = ScreenminY To ScreenmaxY
        PixelOffsetYTemp = (ScreenY - 1) * TilePixelHeight + PixelOffsetY
        For X = ScreenminX To ScreenmaxX
            PixelOffsetXTemp = (ScreenX - 1) * TilePixelWidth + PixelOffsetX

            'Layer 1 **********************************

            If MapData(X, Y).Graphic(1).GrhIndex > 1 Then
                Call DDrawGrhtoSurface(MapData(X, Y).Graphic(1), _
                                       PixelOffsetXTemp, _
                                       PixelOffsetYTemp, _
                                       0, lvalue(), 0)
            End If
            '******************************************

            'Layer 2 **********************************
            If MapData(X, Y).Graphic(2).GrhIndex <> 0 Then
                Call DDrawGrhtoSurface(MapData(X, Y).Graphic(2), _
                                       PixelOffsetXTemp, _
                                       PixelOffsetYTemp, _
                                       1, lvalue(), 1)
            End If
            '******************************************
            ScreenX = ScreenX + 1
        Next X

        'Reset ScreenX to original value and increment ScreenY
        ScreenX = ScreenX - X + ScreenminX
        ScreenY = ScreenY + 1
    Next Y

    'Draw Transparent Layers
    ScreenY = minYOffset - TileBufferSize
    For Y = minY To maxY
        ScreenX = minXOffset - TileBufferSize
        PixelOffsetYTemp = ScreenY * TilePixelHeight + PixelOffsetY
        For X = minX To maxX
            PixelOffsetXTemp = ScreenX * TilePixelWidth + PixelOffsetX

            With MapData(X, Y)
                'Object Layer **********************************

                If .ObjGrh.GrhIndex <> 0 Then
                    If EsRayosX(X, Y) Then
                        Call DDrawGrhtoSurface(.ObjGrh, PixelOffsetXTemp, PixelOffsetYTemp, 1, lArboles, 1)
                    Else
                        Call DDrawGrhtoSurface(.ObjGrh, PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                    End If
                End If
                '***********************************************

                'Char layer ************************************
                If .CharIndex <> 0 Then
                    Call CharRender(.CharIndex, PixelOffsetXTemp, PixelOffsetYTemp)
                End If

                '*************************************************

                'Layer 3 *****************************************
                If EsArbol(.Graphic(3).GrhIndex) Or EsRayosX(X, Y) Then    '
                    Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lArboles, 1)
                Else
                    If .Graphic(3).GrhIndex <> 0 Then
                        Call DDrawGrhtoSurface(.Graphic(3), PixelOffsetXTemp, PixelOffsetYTemp, 1, lvalue, 1)
                        .Graphic(3).Speed = 666
                    End If
                End If

            End With

            ScreenX = ScreenX + 1
        Next X
        ScreenY = ScreenY + 1
    Next Y

    If tSetup.EfectosPelea Then

        ' ************** Projectiles **************
        If LastProjectile > 0 Then
            For j = 1 To LastProjectile
                If ProjectileList(j).Grh.GrhIndex Then
                    Dim Angle As Single
                    Angle = DegreeToRadian * Engine_GetAngle(ProjectileList(j).X, ProjectileList(j).Y, ProjectileList(j).tX, ProjectileList(j).tY)
                    ProjectileList(j).X = ProjectileList(j).X + (Sin(Angle) * timerElapsedTime * 0.63)
                    ProjectileList(j).Y = ProjectileList(j).Y - (Cos(Angle) * timerElapsedTime * 0.63)
                    Dim UserPosScreen As Position
                    UserPosScreen.X = UserPos.X - HalfWindowTileWidth
                    UserPosScreen.Y = UserPos.Y - HalfWindowTileHeight
                    X = -(UserPosScreen.X - 7) * 32 + ProjectileList(j).X + PixelOffsetX - 224
                    Y = -(UserPosScreen.Y - 7) * 32 + ProjectileList(j).Y + PixelOffsetY - 240
                    If Y >= -32 Then
                        If Y <= (ScreenHeight + 32) Then
                            If X >= -32 Then
                                If X <= (ScreenWidth + 32) Then
                                    Call DDrawTransGrhIndextoSurface(ProjectileList(j).Grh.GrhIndex, X, Y, 0, lvalue, ProjectileList(j).Rotate + 130)
                                End If
                            End If
                        End If
                    End If
                End If
            Next j
            For j = 1 To LastProjectile    'Check if it is close enough to the target to remove
                If ProjectileList(j).Grh.GrhIndex Then
                    If Abs(ProjectileList(j).X - ProjectileList(j).tX) < 20 Then
                        If Abs(ProjectileList(j).Y - ProjectileList(j).tY) < 20 Then
                            EraseProjectile j
                        End If
                    End If
                End If
            Next j
        End If
    End If

    If bRain Then
        If LastTickWeather < GetTickCount Then
            If GrhWeather <> 3 Then
                GrhWeather = GrhWeather + 1
            Else
                GrhWeather = 0
            End If

            LastTickWeather = GetTickCount + 100
        End If

        Dim valpha As Byte
        valpha = 150
        Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), valpha))

        Call SpriteBatch.SetTexture(SurfaceDB.Surface(12165 + GrhWeather))
        Call SpriteBatch.Draw(MainViewRect.X1, MainViewRect.Y1, MainViewRect.X2, MainViewRect.Y2, lvalue(), 0, 0, 1, 1)
    End If

    If tSetup.EfectosPelea Then
        For j = 1 To LastDamage
            If DamageList(j).Counter > 0 Then

                If tSetup.EfectosPelea Then
                    DamageList(j).Counter = DamageList(j).Counter - timerElapsedTime * 2

                    X = Engine_TPtoSPX(DamageList(j).Pos.X) - 7
                    Y = Engine_TPtoSPY(DamageList(j).Pos.Y) + (DamageList(j).Counter * 0.01) - 45

                    If DamageList(j).Counter <= 0 Then DamageList(j).Counter = 0
                    Call RenderTextureText(X, Y, DamageList(j).Value, D3DColorXRGB(DamageList(j).r, DamageList(j).g, DamageList(j).b), 70 + (DamageList(j).Counter * 0.08), False)
                End If
            Else
                EraseDamage j
            End If
        Next j

    End If

End Sub

Public Function RenderSounds()

    If bLluvia(UserMap) = 1 Then
        If bRain Then
            If bTecho Then
                If frmMain.IsPlaying <> PlayLoop.plLluviain Then
                    If RainBufferIndex Then
                        Call modEngine_Audio.Cancel(RainBufferIndex) 'Call Audio.StopWave(RainBufferIndex)
                    End If
                    RainBufferIndex = modEngine_Audio.PlayEffect("lluviain.wav")
                    frmMain.IsPlaying = PlayLoop.plLluviain
                End If
            Else
                If frmMain.IsPlaying <> PlayLoop.plLluviaout Then
                    If RainBufferIndex Then
                        Call modEngine_Audio.Cancel(RainBufferIndex) 'Call Audio.StopWave(RainBufferIndex)
                    End If
                    RainBufferIndex = modEngine_Audio.PlayEffect("lluviaout.wav")    'modEngine_Audio.PlayEffect("lluviaout.wav", 0, 0, LoopStyle.Enabled)

                    frmMain.IsPlaying = PlayLoop.plLluviaout
                End If
            End If
        End If
    End If

    DoFogataFx
    
End Function

Function HayUserAbajo(ByVal X As Integer, ByVal Y As Integer, ByVal GrhIndex As Integer) As Boolean
    If GrhIndex > 0 Then
        HayUserAbajo = _
        charlist(UserCharIndex).Pos.X >= X - (GrhData(GrhIndex).TileWidth \ 2) _
                       And charlist(UserCharIndex).Pos.X <= X + (GrhData(GrhIndex).TileWidth \ 2) _
                       And charlist(UserCharIndex).Pos.Y >= Y - (GrhData(GrhIndex).TileHeight - 1) _
                       And charlist(UserCharIndex).Pos.Y <= Y
    End If
End Function

Sub LoadGraphics()

    RLluvia(0).Top = 0: RLluvia(1).Top = 0: RLluvia(2).Top = 0: RLluvia(3).Top = 0
    RLluvia(0).Left = 0: RLluvia(1).Left = 128: RLluvia(2).Left = 256: RLluvia(3).Left = 384
    RLluvia(0).Right = 128: RLluvia(1).Right = 256: RLluvia(2).Right = 384: RLluvia(3).Right = 512
    RLluvia(0).Bottom = 128: RLluvia(1).Bottom = 128: RLluvia(2).Bottom = 128: RLluvia(3).Bottom = 128

    RLluvia(4).Top = 128: RLluvia(5).Top = 128: RLluvia(6).Top = 128: RLluvia(7).Top = 128
    RLluvia(4).Left = 0: RLluvia(5).Left = 128: RLluvia(6).Left = 256: RLluvia(7).Left = 384
    RLluvia(4).Right = 128: RLluvia(5).Right = 256: RLluvia(6).Right = 384: RLluvia(7).Right = 512
    RLluvia(4).Bottom = 256: RLluvia(5).Bottom = 256: RLluvia(6).Bottom = 256: RLluvia(7).Bottom = 256
End Sub

Public Function InitTileEngine(ByVal setDisplayFormhWnd As Long, ByVal setMainViewTop As Integer, ByVal setMainViewLeft As Integer, ByVal setWindowTileHeight As Integer, ByVal setWindowTileWidth As Integer, ByVal setTileBufferSize As Integer, ByVal pixelsToScrollPerFrameX As Integer, pixelsToScrollPerFrameY As Integer, ByVal engineSpeed As Single) As Boolean

    IniPath = App.Path & "\Init\"

    'Fill startup variables
    MainViewTop = setMainViewTop
    MainViewLeft = setMainViewLeft
    WindowTileHeight = setWindowTileHeight
    WindowTileWidth = setWindowTileWidth
    TileBufferSize = setTileBufferSize

    HalfWindowTileHeight = setWindowTileHeight \ 2
    HalfWindowTileWidth = setWindowTileWidth \ 2

    'Compute offset in pixels when rendering tile buffer.
    'We diminish by one to get the top-left corner of the tile for rendering.
    TileBufferPixelOffsetX = ((TileBufferSize - 1) * TilePixelWidth)
    TileBufferPixelOffsetY = ((TileBufferSize - 1) * TilePixelHeight)

    engineBaseSpeed = engineSpeed

    'Set FPS value to 60 for startup
    fps = 101
    FramesPerSecCounter = 100

    MinXBorder = XMinMapSize + (WindowTileWidth \ 2)
    MaxXBorder = XMaxMapSize - (WindowTileWidth \ 2)
    MinYBorder = YMinMapSize + (WindowTileHeight \ 2)
    MaxYBorder = YMaxMapSize - (WindowTileHeight \ 2)

    MainViewWidth = TilePixelWidth * WindowTileWidth
    MainViewHeight = TilePixelHeight * WindowTileHeight

    'Resize mapdata array
    ReDim MapData(XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock

    'Set intial user position
    UserPos.X = MinXBorder
    UserPos.Y = MinYBorder

    'Set scroll pixels per frame
    ScrollPixelsPerFrameX = pixelsToScrollPerFrameX
    ScrollPixelsPerFrameY = pixelsToScrollPerFrameY

    On Error GoTo 0

    Call LoadGrhData
    Call CargarCuerpos
    Call CargarCabezas
    Call CargarCascos
    Call CargarFxs

    LTLluvia(0) = 224
    LTLluvia(1) = 352
    LTLluvia(2) = 480
    LTLluvia(3) = 608
    LTLluvia(4) = 736

    lArboles(0) = D3DColorARGB(150, 255, 255, 255)
    lArboles(1) = lArboles(0)
    lArboles(2) = lArboles(0)
    lArboles(3) = lArboles(0)


    Call LoadGraphics

    Movement_Speed = 1

    InitTileEngine = True
End Function

Public Sub DirectXInit()

    On Error Resume Next


767 Dim DispMode As D3DDISPLAYMODE
878 Dim D3DWindow As D3DPRESENT_PARAMETERS

33  Set DirectX = New DirectX8
44  Set DirectD3D = DirectX.Direct3DCreate
55  Set DirectD3D8 = New D3DX8

66  DirectD3D.GetAdapterDisplayMode D3DADAPTER_DEFAULT, DispMode

1   ScreenWidth = frmMain.MainViewPic.ScaleWidth
2   ScreenHeight = frmMain.MainViewPic.ScaleHeight

3   With D3DWindow
4       .Windowed = True

        'If Not tSetup.VSync Then
5       .SwapEffect = D3DSWAPEFFECT_DISCARD

        'Else
        '.SwapEffect = D3DSWAPEFFECT_COPY_VSYNC
        'End If

78      .BackBufferFormat = DispMode.format

79      .BackBufferWidth = 800
80      .BackBufferHeight = 600
        '.EnableAutoDepthStencil = 1

        '.AutoDepthStencilFormat = D3DFMT_D16
91      .hDeviceWindow = frmMain.MainViewPic.hwnd
    End With

6   Set DirectDevice = DirectD3D.CreateDevice( _
                       D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, _
                       frmMain.MainViewPic.hwnd, _
                       D3DCREATE_SOFTWARE_VERTEXPROCESSING, _
                       D3DWindow)


7   Call D3DXMatrixOrthoOffCenterLH(Projection, 0, 800, 600, 0, -1#, 1#)
8   Call D3DXMatrixIdentity(View)

9   Call DirectDevice.SetTransform(D3DTS_PROJECTION, Projection)
10  Call DirectDevice.SetTransform(D3DTS_VIEW, View)

11  Call Engine_Init_RenderStates

    With MainViewRect
        .X2 = ScreenWidth
        .Y2 = ScreenHeight
    End With

    If Err Then
    
        Debug.Print "Weird error: " & Err.Number & " " & Err.Description
        MsgBox Erl & "No se puede iniciar DirectX. Por favor asegurese de tener la ultima version correctamente instalada." & Err.Number & " " & Err.Description
        End
        Exit Sub
    End If

    If DirectDevice Is Nothing Then
        MsgBox "No se puede inicializar DirectDevice. Por favor asegurese de tener la ultima version correctamente instalada."
        End
        Exit Sub
    End If

    Exit Sub
ErrHandler:
    MsgBox Erl & "No se puede iniciar DirectX. Por favor asegurese de tener la ultima version correctamente instalada." & Err.Number & " " & Err.Description
    End

End Sub

Public Sub Engine_Init_RenderStates()

    With DirectDevice

        'Set the shader to be used
        DirectDevice.SetVertexShader D3DFVF_XYZ Or D3DFVF_TEX1 Or D3DFVF_DIFFUSE

        'Set the render states
        .SetRenderState D3DRS_LIGHTING, 0
        .SetRenderState D3DRS_SRCBLEND, D3DBLEND_SRCALPHA
        .SetRenderState D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA
        .SetRenderState D3DRS_ALPHABLENDENABLE, 1
        .SetRenderState D3DRS_FILLMODE, D3DFILL_SOLID
        .SetRenderState D3DRS_CULLMODE, D3DCULL_NONE
        .SetRenderState D3DRS_ZENABLE, 1
        .SetRenderState D3DRS_ZWRITEENABLE, 1
        .SetTextureStageState 0, D3DTSS_ALPHAOP, D3DTOP_MODULATE

        'Particle engine settings
        .SetRenderState D3DRS_POINTSPRITE_ENABLE, 1
        .SetRenderState D3DRS_POINTSCALE_ENABLE, 0

        'Set the texture stage stats (filters)
        .SetTextureStageState 0, D3DTSS_MAGFILTER, D3DTEXF_POINT
        .SetTextureStageState 0, D3DTSS_MINFILTER, D3DTEXF_POINT

    End With

End Sub


Public Sub DeinitTileEngine()

    On Error Resume Next

    Set DirectD3D = Nothing

    Set DirectX = Nothing
End Sub

Sub ShowNextFrame(ByVal MouseViewX As Integer, ByVal MouseViewY As Integer)
    On Error Resume Next

    Dim Valor As Byte
    If EngineRun Then

        DirectDevice.Clear 0, ByVal 0, D3DCLEAR_TARGET, BackgroundColor, 1#, 0
        DirectDevice.BeginScene
        Call SpriteBatch.begin
        
        If UserMoving Then
            '****** Move screen Left and Right if needed ******
            If AddtoUserPos.X <> 0 Then
                OffsetCounterX = OffsetCounterX - ScrollPixelsPerFrameX * AddtoUserPos.X * timerTicksPerFrame

                If Abs(OffsetCounterX) >= Abs(TilePixelWidth * AddtoUserPos.X) Then
                    OffsetCounterX = 0
                    AddtoUserPos.X = 0
                    UserMoving = False
                End If
            End If
            '****** Move screen Up and Down if needed ******
            If AddtoUserPos.Y <> 0 Then
                OffsetCounterY = OffsetCounterY - ScrollPixelsPerFrameY * AddtoUserPos.Y * timerTicksPerFrame
                If Abs(OffsetCounterY) >= Abs(TilePixelHeight * AddtoUserPos.Y) Then
                    OffsetCounterY = 0
                    AddtoUserPos.Y = 0
                    UserMoving = False
                End If
            End If
        End If

        'Update mouse position within view area
        Call ConvertCPtoTP(MouseViewX, MouseViewY, MouseTileX, MouseTileY)
        '****** Update screen ******
        If Not UserCiego Then
            'Call RenderScreen(UserPos.X - AddtoUserPos.X, UserPos.Y - AddtoUserPos.Y, OffsetCounterX, OffsetCounterY)

            If RAYOS_X Then
                Call RenderScreen_GM(UserPos.X - AddtoUserPos.X, UserPos.Y - AddtoUserPos.Y, OffsetCounterX, OffsetCounterY)
            Else
                Call RenderScreen(UserPos.X - AddtoUserPos.X, UserPos.Y - AddtoUserPos.Y, OffsetCounterX, OffsetCounterY)
            End If

        End If
        If ModoCombate Then Call drawText(5, 3, "Modo Combate", -65536)

        If frmMain.macrotrabajo.Enabled Then
            If ModoCombate Then
                Call drawText(5, 15, "Trabajando", -1)
            Else
                Call drawText(5, 5, "Trabajando", -1)
            End If
        End If

        If Envenenado <> 0 And UserEstado = 0 Then
            Call drawText(461, 5, "(Envenenado)", -16711936)

            If LockedWalk Then
                Call drawText(365, 15, "Caminata automática activada", -1)
            End If
        Else
            If LockedWalk Then
                Call drawText(365, 5, "Caminata automática activada", -1)
            End If
        End If

        '   Dim colorbonus As Long
        '            If ShowBonusExpTimeleft And tBonif > 0 Then
        '                If LeveleandoTick > 0 Then
        '                    Call DrawText(455, 15, ((tBonif Mod 86400) Mod 3600) \ 60 & " min " & (((tBonif Mod 86400) Mod 3600) Mod 60) & " seg", -1)
        '                End If
        '            ElseIf ShowBonusExpTimeleft Then
        '                Call ShowConsoleMsg("Se acabó tu bonificación diaria de experiencia.")
        '                ShowBonusExpTimeleft = False
        '            End If
        '        Else
        '            If ShowBonusExpTimeleft And tBonif > 0 Then
        '                If LeveleandoTick > 0 Then
        '                    colorbonus = 1
        '                Else
        '                    colorbonus = RGB(255, 1, 10)
        '                End If
        '                Call DrawText(455, 5, ((tBonif Mod 86400) Mod 3600) \ 60 & " min " & (((tBonif Mod 86400) Mod 3600) Mod 60) & " seg", -colorbonus)
        '            ElseIf ShowBonusExpTimeleft Then
        '                Call ShowConsoleMsg("Se acabó tu bonificación diaria de experiencia.")
        '                ShowBonusExpTimeleft = False
        '            End If
        '        End If

        Call Dialogos.Render
        Call DibujarCartel
        Call DialogosClanes.Draw
        If tSetup.AlphaBlending Then
            Valor = IIf(FramesPerSecCounter < 100, 10, 2)
            If bTecho Then
                If AlphaTecho > 0 Then
                    If (Val(AlphaTecho) - Val(Valor)) < 0 Then
                        AlphaTecho = AlphaTecho - 1
                    Else
                        AlphaTecho = AlphaTecho - Valor
                    End If
                End If
            Else
                If AlphaTecho <> 255 Then
                    If (Val(AlphaTecho) + Val(Valor)) > 255 Then
                        AlphaTecho = AlphaTecho + 1
                    Else
                        AlphaTecho = AlphaTecho + Valor
                    End If
                End If
            End If
        End If

        If MostrarMapa Then
            Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), 150))
            Call Directx_Render_Texture(12176, 30, 7, 399, 469, 0, 0, lvalue)
            Call drawText(467, 282, "Ciudad", -1)
            Call drawText(467, 299, "Muelle/Isla", -1)
            Call drawText(467, 315, "Catacumba", -1)
            Call drawText(467, 333, "Desierto", -1)
            Call drawText(467, 351, "Dungeon", -1)
            Call drawText(467, 369, "Polo", -1)
        End If

        Call SpriteBatch.Flush

        Call DirectDevice.EndScene
        Call DirectDevice.Present(MainViewRect, ByVal 0, frmMain.MainViewPic.hwnd, ByVal 0)

        Dim TActual As Long
        TActual = GetTickCount
        If TActual - tInvLast >= 100 Then
            tInvLast = TActual

            Call Inventario.DrawInv

            If frmBancoObj.visible Then
                Call InvBanco(0).DrawInv
                Call InvBanco(1).DrawInv
            End If

            If frmComerciar.visible Then
                Call InvComNpc.DrawInv
                Call InvComUsu.DrawInv
            End If

            If frmComerciarUsu.visible Then
                Call InvComUsu.DrawInv
                Call InvOfferComUsu(0).DrawInv
                Call InvOfferComUsu(1).DrawInv
            End If
        End If

        If Not fpsLastCheck = 0 Then
            If tSetup.LimitFps Then
                While (GetTickCount - fpsLastCheck) / 15.5 < FramesPerSecCounter
                    Sleep 1
                Wend
            Else
                If Not MAXFPS Then
                    While (GetTickCount - fpsLastCheck) * 2 < FramesPerSecCounter
                        Sleep 1
                    Wend
                End If
            End If
        End If
        'FPS update
        If fpsLastCheck + 1000 < GetTickCount Then
            fps = FramesPerSecCounter
            FramesPerSecCounter = 1
            fpsLastCheck = GetTickCount
        Else
            FramesPerSecCounter = FramesPerSecCounter + 1
        End If

        'Get timing info
        timerElapsedTime = GetElapsedTime()
        timerTicksPerFrame = timerElapsedTime * engineBaseSpeed

    End If

End Sub

Public Function validbyte(ByVal param As Long) As Byte
    If param < 0 Then param = 0
    If param > 255 Then param = 255
    validbyte = param
End Function

Public Function SetElapsedTime(ByVal Start As Boolean) As Single
    Dim Start_Time As Currency
    Static End_Time As Currency
    Static Timer_Freq As Currency
    'Get the timer frequency
    If Timer_Freq = 0 Then
        QueryPerformanceFrequency Timer_Freq
    End If

    'Get current time
    Call QueryPerformanceCounter(Start_Time)

    If Not Start Then
        'Calculate elapsed time
        SetElapsedTime = (Start_Time - End_Time) / Timer_Freq * 1000

        'Get next end time
    Else
        Call QueryPerformanceCounter(End_Time)
    End If
End Function

Private Function GetElapsedTime() As Single
    Dim Start_Time As Currency
    Static End_Time As Currency
    Static Timer_Freq As Currency

    'Get the timer frequency
    If Timer_Freq = 0 Then
        QueryPerformanceFrequency Timer_Freq
    End If

    'Get current time
    Call QueryPerformanceCounter(Start_Time)

    'Calculate elapsed time
    GetElapsedTime = (Start_Time - End_Time) / Timer_Freq * 1000

    'Get next end time
    Call QueryPerformanceCounter(End_Time)
End Function

Public Function Engine_Get_2_Points_Angle(ByVal X1 As Long, ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Double

    Engine_Get_2_Points_Angle = Engine_Get_X_Y_Angle((X2 - X1), (Y2 - Y1))

End Function
Public Function Engine_Get_X_Y_Angle(ByVal X As Double, ByVal Y As Double) As Double

    Dim dblres As Double

    dblres = 0

    If (Y <> 0) Then
        dblres = Engine_Convert_Radians_To_Degrees(Atn(X / Y))
        If (X <= 0 And Y < 0) Then
            dblres = dblres + 180
        ElseIf (X > 0 And Y < 0) Then
            dblres = dblres + 180
        ElseIf (X < 0 And Y > 0) Then
            dblres = dblres + 360
        End If
    Else
        If (X > 0) Then
            dblres = 90
        ElseIf (X < 0) Then
            dblres = 270
        End If
    End If

    Engine_Get_X_Y_Angle = dblres

End Function

Public Function Engine_Convert_Radians_To_Degrees(ByVal s_radians As Double) As Integer
    Engine_Convert_Radians_To_Degrees = (s_radians * 180) / 3.14159265358979
End Function
Private Sub CharRender(ByVal CharIndex As Long, ByVal PixelOffsetX As Integer, ByVal PixelOffsetY As Integer)

    Dim moved As Boolean
    Dim Pos As Integer
    Dim color As Long
    Dim valpha As Byte
    Dim toffx As Integer
    Dim toffy As Integer

    With charlist(CharIndex)

        If .Moving Then
            If .scrollDirectionX <> 0 Then
                .MoveOffsetX = .MoveOffsetX + ScrollPixelsPerFrameX * Sgn(.scrollDirectionX) * timerTicksPerFrame

                If .Body.Walk(.Heading).Speed > 0 Then _
                   .Body.Walk(.Heading).Started = 1
                .Arma.WeaponWalk(.Heading).Started = 1
                .Escudo.ShieldWalk(.Heading).Started = 1

                'Char moved
                moved = True
                '.LastMov = GetTickCount
                'Check if we already got there
                If (Sgn(.scrollDirectionX) = 1 And .MoveOffsetX >= 0) Or _
                   (Sgn(.scrollDirectionX) = -1 And .MoveOffsetX <= 0) Then
                    .MoveOffsetX = 0
                    .scrollDirectionX = 0
                End If
            End If

            'If needed, move up and down
            If .scrollDirectionY <> 0 Then
                .MoveOffsetY = .MoveOffsetY + ScrollPixelsPerFrameY * Sgn(.scrollDirectionY) * timerTicksPerFrame

                'Start animations
                'TODO : Este parche es para evita los uncornos exploten al moverse!! REVER!!!
                If .Body.Walk(.Heading).Speed > 0 Then _
                   .Body.Walk(.Heading).Started = 1
                .Arma.WeaponWalk(.Heading).Started = 1
                .Escudo.ShieldWalk(.Heading).Started = 1

                'Char moved
                moved = True
                If (Sgn(.scrollDirectionY) = 1 And .MoveOffsetY >= 0) Or _
                   (Sgn(.scrollDirectionY) = -1 And .MoveOffsetY <= 0) Then
                    .MoveOffsetY = 0
                    .scrollDirectionY = 0
                End If
            End If
        End If

        If .Heading = 0 Then .Heading = SOUTH    'If done moving stop animation

        If Not moved Then    'Stop animations
            .Body.Walk(.Heading).Started = 0
            .Body.Walk(.Heading).FrameCounter = 1
            If Not .Movimient Then
                .Arma.WeaponWalk(.Heading).Started = 0
                .Arma.WeaponWalk(.Heading).FrameCounter = 1
                .Escudo.ShieldWalk(.Heading).Started = 0
                .Escudo.ShieldWalk(.Heading).FrameCounter = 1
            End If
            .Moving = False
        End If

        PixelOffsetX = PixelOffsetX + .MoveOffsetX
        PixelOffsetY = PixelOffsetY + .MoveOffsetY

        valpha = 255

        If .Invisible Then    'And Not (.iBody > 83 And .iBody < 87) Then ' @@ Estoy invisible?
            Select Case .CounterInvi
            Case 6
                valpha = 100
            Case 7
                valpha = 110
            Case Else
                valpha = 0
            End Select

            'If CharIndex = UserCharIndex Then
            '    valpha = 110
            'End If

        ElseIf .Oculto And Not (.iBody > 83 And .iBody < 87) Then
            valpha = 0
        End If

        If .iBody = 84 Or .iBody = 85 Or .iBody = 86 Then
            valpha = 255
        End If

        If SoyGM Or CharIndex = UserCharIndex Then
            valpha = 255

            If .Oculto Or .Invisible Then
                valpha = 110
            End If
        End If

        Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), valpha))

        If (.Head.Head(.Heading).GrhIndex) Or SoyGM Or valpha Then    'added Or valpha para que se vean las barcas, totalmente horrible!!!!

            If (((Not .Oculto And Not .Invisible) Or (.iBody > 83 And .iBody < 87)) Or (valpha > 0)) Or SoyGM Then
                Movement_Speed = 0.7

                'Draw Body
                If .Body.Walk(.Heading).GrhIndex Then
                    If Not .muerto Then

                        Call DDrawGrhtoSurface(.Body.Walk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalue, 1)
                    Else
                        Call Engine_Long_To_RGB_List(lvalueDeath(), Engine_Change_Alpha(lvalue(), 130))
                        Call DDrawGrhtoSurface(.Body.Walk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalueDeath, 1)
                    End If
                End If
                'Draw Head
                If .Head.Head(.Heading).GrhIndex Or esGM(UserCharIndex) Then
                    If Not .muerto Then
                        If Not (.iHead = 500 Or .iHead = 514) Then
                            Call DDrawGrhtoSurface(.Head.Head(.Heading), PixelOffsetX + .Body.HeadOffset.X, PixelOffsetY + .Body.HeadOffset.Y, 1, lvalue, 1)
                        Else
                            Call DDrawGrhtoSurface(.Head.Head(.Heading), PixelOffsetX + .Body.HeadOffset.X, PixelOffsetY + .Body.HeadOffset.Y, 1, lvalue, 1)
                        End If
                    Else
                        Call Engine_Long_To_RGB_List(lvalueDeath(), Engine_Change_Alpha(lvalue(), 130))
                        Call DDrawGrhtoSurface(.Head.Head(.Heading), PixelOffsetX + .Body.HeadOffset.X, PixelOffsetY + .Body.HeadOffset.Y, 1, lvalueDeath, 0)
                    End If



                    If .iCasco = 7 Or .iCasco = 8 Then
                        Select Case .Heading
                        Case E_Heading.NORTH
                            toffx = 0
                        Case E_Heading.SOUTH
                            toffx = -2
                        Case E_Heading.EAST
                            toffx = 0
                        Case E_Heading.WEST
                            toffx = -2
                        End Select
                        toffy = -1
                    Else
                        toffx = 0
                    End If

                    If .Head.Head(.Heading).GrhIndex Then    ' Si tiene head muestro su cuerpo y demás.
                        'Helmet
                        If .Casco.Head(.Heading).GrhIndex Then Call DDrawGrhtoSurface(.Casco.Head(.Heading), toffx + PixelOffsetX + .Body.HeadOffset.X, toffy + PixelOffsetY + .Body.HeadOffset.Y, 1, lvalue, 0)

                        'Weapon
                        If .Arma.WeaponWalk(.Heading).GrhIndex Then Call DDrawGrhtoSurface(.Arma.WeaponWalk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalue, 1)

                        'Shield
                        If .Escudo.ShieldWalk(.Heading).GrhIndex Then Call DDrawGrhtoSurface(.Escudo.ShieldWalk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalue, 1)
                    End If

                    'Draw name over head
                    If ((LenB(.nombre) > 0) And Not .Invisible And Not .Oculto) Or SoyGM Or (CharIndex = UserCharIndex And tSetup.AlphaBlending) Then
                        If Nombres Then
                            Pos = getTagPosition(.nombre)
                            color = .color

                            If valpha = 155 Then color = D3DColorXRGB(255, 255, 255)

                            'Nick
                            Call drawText(PixelOffsetX + 17, PixelOffsetY + 30, .nombre, color, 255, True)
                            If EfectoEspecialNick And .Premium Then
                                Call Directx_Render_Texture(12177, PixelOffsetX - (Engine_GetTextWidth(cfonts(1), .nombre) * 0.55), PixelOffsetY + 31, 12, 12, 0, 0, lvalue)
                            End If

                            If SoyGM Then    'And Not charIndex = UserCharIndex Then 'quiero verle el nick a todos!!!
                                If GetKeyState(vbKeyX) Then
                                    If .Invisible Then
                                        Call drawText(PixelOffsetX - 3, PixelOffsetY - 15, Chr(73), -1, , False, 1, 1)
                                    End If
                                    If .Oculto Then
                                        Call drawText(PixelOffsetX - 3, PixelOffsetY - 15, Chr(79), -1, , False, 1, 1)
                                    End If

                                    If .Paralizado Then
                                        Call drawText(PixelOffsetX - 3, PixelOffsetY - 5, Chr(80), D3DColorXRGB(0, 255, 0), , False, 1, 1)
                                    ElseIf .Inmovilizado Then
                                        Call drawText(PixelOffsetX - 3, PixelOffsetY + 5, Chr(73), D3DColorXRGB(0, 255, 0), , False, 1, 1)
                                    End If

                                    If .Envenenado Then
                                        Call drawText(PixelOffsetX - 3, PixelOffsetY + 15, Chr(69), -1, , False, 1, 1)
                                    End If
                                    If Not .Trabajando = 0 Then
                                        Call drawText(PixelOffsetX + 27, PixelOffsetY + 5, Chr(84) & Chr(58) & Chr(32) & .Trabajando, -1, , False, 0, 1)
                                    End If
                                    If .IdleCount > 1 Then
                                        Call drawText(PixelOffsetX + 27, PixelOffsetY + 15, Chr(65) & Chr(70) & Chr(75) & Chr(58) & Chr(32) & .IdleCount, D3DColorXRGB(255, 1, 1), , False, 1, 1)
                                    End If
                                End If
                            End If

                            'Clan
                            If Len(.clan) > 0 Then
                                Call drawText(PixelOffsetX + 17, PixelOffsetY + 45, .clan, color, , True)
                            End If
                        End If
                    Else
                        '                        Debug.Print
                    End If
                End If
            End If
        Else
            'Draw Body
            If ((Not .Invisible And Not .Oculto) Or valpha = 155) Or (.iBody = 84 Or .iBody = 85 Or .iBody = 86 Or .iBody = 87) Then
                If (valpha = 155 And tSetup.AlphaBlending And .Invisible) Or (Not .Invisible) Or valpha = 255 Then
                    If .Body.Walk(.Heading).GrhIndex Then
                        If .muerto Then
                            Call Engine_Long_To_RGB_List(lvalueDeath(), Engine_Change_Alpha(lvalue(), 130))
                            Call DDrawGrhtoSurface(.Body.Walk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalueDeath, 1)
                        Else
                            Call DDrawGrhtoSurface(.Body.Walk(.Heading), PixelOffsetX, PixelOffsetY, 1, lvalue, 1)
                        End If
                    End If
                End If

                If LenB(.nombre) > 0 And (Not .Invisible) And Not .iBody = 84 And Not .iBody = 85 And Not .iBody = 86 And Not .iBody = 87 Then
                    If Nombres Then
                        color = .color
                        If valpha = 155 Then color = D3DColorXRGB(255, 255, 255)

                        'Nick
                        Call drawText(PixelOffsetX + 17, PixelOffsetY + 30, .nombre, color, , True)

                        If .Invisible <> 0 Then
                            Call drawText(PixelOffsetX + 17, PixelOffsetY, Chr(91) & Chr(91) & Chr(73) & Chr(78) & Chr(86) & Chr(73) & Chr(93), color, , True)
                        End If

                        'Clan
                        If Len(.clan) > 0 Then
                            Call drawText(PixelOffsetX + 17, PixelOffsetY + 45, .clan, color, , True)
                        End If

                    End If
                End If

            End If

        End If


        Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), 255))

        If .Invisible And CharIndex = UserCharIndex And SoyGM Then
            Call Directx_Render_Texture(12178, PixelOffsetX + 4, PixelOffsetY - 37, 16, 20, 0, 0, lvalue)
        End If

        'Update dialogs
        If .Mimetizado Then
            Call Dialogos.UpdateDialogPos(PixelOffsetX + .Body.HeadOffset.X, PixelOffsetY - 34, CharIndex)       '34 son los pixeles del grh de la cabeza que quedan superpuestos al cuerpo
        Else
            Call Dialogos.UpdateDialogPos(PixelOffsetX + .Body.HeadOffset.X, PixelOffsetY + .Body.HeadOffset.Y, CharIndex)        '34 son los pixeles del grh de la cabeza que quedan superpuestos al cuerpo
        End If
        Movement_Speed = 1

        'Draw FX
        If .FxIndex <> 0 Then

            Dim XDATAFX As Integer, YDATAFX As Integer

            '@Nota de Dunkan: Arreglar desde el INDICE.
            If .FxIndex = 1 Then
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 25
            ElseIf .FxIndex = 18 Then
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY - 15
            ElseIf .FxIndex = 17 Then
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY - 15
            ElseIf .FxIndex = 19 Then
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 25
            ElseIf .FxIndex = 7 Then        'TORMENTA DE FUEGO
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 30
            ElseIf .FxIndex = 8 Then        'PARALIZAR
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 35
            ElseIf .FxIndex = 9 Then        'CURAR GRAVES
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 25
            ElseIf .FxIndex = 12 Then        'INMO
                XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                YDATAFX = PixelOffsetY + 20
            Else
                If .FxIndex <> 26 Then
                    XDATAFX = (PixelOffsetX + FxData(.FxIndex).OffSetX)
                    YDATAFX = PixelOffsetY
                End If
            End If

            If .FxIndex <> 16 Then
                ColorFx(0) = Engine_Change_Alpha(lvalue(), 127)
                ColorFx(1) = ColorFx(0)
                ColorFx(2) = ColorFx(0)
                ColorFx(3) = ColorFx(0)
            Else
                If tSetup.AlphaBlending Then
                    ColorFx(0) = Engine_Change_Alpha(lvalue(), 185)
                Else
                    ColorFx(0) = Engine_Change_Alpha(lvalue(), 255)
                End If
                ColorFx(1) = ColorFx(0)
                ColorFx(2) = ColorFx(0)
                ColorFx(3) = ColorFx(0)
            End If

            If .FxIndex <> 26 Then
                Call DDrawGrhtoSurface(FxGrh(.FxIndex), XDATAFX, YDATAFX, 1, ColorFx(), 1)

                'Check if animation is over
                If FxGrh(.FxIndex).Started = 0 Then .FxIndex = 0
            End If

        End If

    End With
End Sub
Private Function InviConAlpha(ByVal CharIndex As Integer) As Boolean
    With charlist(CharIndex)

        If .iHead = 0 Then Exit Function

        If esGM(UserCharIndex) Then
            If CharIndex = UserCharIndex Then
                InviConAlpha = True
                Exit Function
            End If
        End If

        If LenB(.clan) <= 0 Then Exit Function

        If (.clan) = charlist(UserCharIndex).clan Then
            'InviConAlpha = True
            Exit Function
        End If

        InviConAlpha = False
    End With
End Function

Public Sub SetCharacterFx(ByVal CharIndex As Integer, ByVal fX As Integer, ByVal Loops As Integer)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 12/03/04
'Sets an FX to the character.
'***************************************************
    On Error GoTo ErrHandler

    With charlist(CharIndex)
        .FxIndex = fX

        If fX = 26 Then
            Exit Sub
        End If

        If .FxIndex > 0 Then
            Call InitGrh(FxGrh(fX), FxData(fX).Animacion)
            FxGrh(fX).Loops = Loops
        End If
    End With
    Exit Sub
ErrHandler:
    Call RegistrarError(Err.Number, Err.Description, "SetCharacterFx", Erl)
    Resume Next
End Sub

Public Sub Directx_Render_Texture(ByVal FileIndex As Long, _
                                  ByVal X As Integer, _
                                  ByVal Y As Integer, _
                                  ByVal Height As Integer, _
                                  ByVal Width As Integer, _
                                  ByVal sX As Integer, _
                                  ByVal sY As Integer, _
                                  ByRef color() As Long, _
                                  Optional ByVal Angle As Single = 0, _
                                  Optional ByVal Alpha As Boolean = False, _
                                  Optional ByVal AlphaByte As Byte = 0)

    On Error Resume Next

    Dim TexSurface As Direct3DTexture8
    Dim TexWidth As Long, TexHeight As Long

    Set TexSurface = SurfaceDB.Surface(FileIndex)        ', TexWidth, TexHeight)
    TexSurface.GetLevelDesc 0, SRDesc

    TexWidth = SRDesc.Width
    TexHeight = SRDesc.Height

    ' Seteamos el Alpha
    Call SpriteBatch.SetAlpha(Alpha)
    Call SpriteBatch.SetAlphaByte(AlphaByte)

    ' Seteamos la textura
    Call SpriteBatch.SetTexture(TexSurface)

    If TexWidth <> 0 And TexHeight <> 0 Then
        Call SpriteBatch.Draw(X, Y, Width, Height, color, sX / TexWidth, sY / TexHeight, (sX + Width + 1) / TexWidth, (sY + Height) / TexHeight, Angle)
    Else
        Call SpriteBatch.Draw(X, Y, TexWidth, TexHeight, color, , , , , Angle)
    End If

End Sub

Public Sub Draw_FillBox(ByVal X As Integer, ByVal Y As Integer, ByVal Width As Integer, ByVal Height As Integer, ByVal color As Long, ByVal OutlineColor As Long)

    Dim b_Color(3) As Long
    Dim b_Color2(3) As Long

    b_Color(0) = color
    b_Color(1) = color
    b_Color(2) = color
    b_Color(3) = color

    b_Color2(0) = OutlineColor
    b_Color2(1) = OutlineColor
    b_Color2(2) = OutlineColor
    b_Color2(3) = OutlineColor

    Call SpriteBatch.SetTexture(Nothing)
    Call SpriteBatch.Draw(X - 1, Y - 1, Width + 1, Height + 1, b_Color2())
    Call SpriteBatch.Draw(X, Y, Width, Height, b_Color())

End Sub

Public Sub drawText(ByVal Left As Long, ByVal Top As Long, ByVal Text As String, ByVal color As Long, Optional ByVal Alpha As Byte = 255, Optional ByVal Center As Boolean = False, Optional ByVal Shadow As Byte = 1, Optional ByVal fontt As Byte = 2)

    If Shadow = 1 Then
        Engine_Render_Text cfonts(fontt), Text, Left - 2, Top - 1, -16711424, Center, Alpha
    End If

    Engine_Render_Text cfonts(fontt), Text, Left, Top, color, Center, Alpha

End Sub

Public Sub RenderTextureText(ByVal Left As Long, ByVal Top As Long, ByVal Text As String, ByVal color As Long, Optional ByVal Alpha As Byte = 255, Optional ByVal Center As Boolean = False)

    If Alpha <> 255 Then
        Dim newRGB As D3DCOLORVALUE
        ARGBtoD3DCOLORVALUE color, newRGB
        color = D3DColorARGB(Alpha, newRGB.r, newRGB.g, newRGB.b)
    End If

    Engine_Render_Text cfonts(2), Text, Left, Top, color, Center

    'If Shadow Then _
     'Engine_Render_Text cfonts(1), Text, Left - 2, Top - 1, D3DColorARGB(Alpha, 0, 0, 0), Center, Alpha
    'Engine_Render_Text cfonts(1), Text, Left, Top, Color, Center, Alpha

End Sub


Public Function GetR(ByVal lColor As Long)
    GetR = lColor And RGB(255, 0, 0)
End Function

Public Function GetG(ByVal lColor As Long)
    GetG = (lColor And RGB(0, 255, 0)) / 256
End Function

Public Function GetB(ByVal lColor As Long)
    GetB = (lColor And RGB(0, 0, 255)) / 65536
End Function

Public Sub Engine_Render_Text(ByRef UseFont As CustomFont, ByVal Text As String, _
                              ByVal X As Long, _
                              ByVal Y As Long, _
                              ByVal color As Long, Optional ByVal Center As Boolean = False, Optional ByVal Alpha As Byte = False)

    Dim TempVA As CharVA
    Dim tempstr() As String
    Dim Count As Integer
    Dim ascii() As Byte
    Dim i As Long
    Dim j As Long
    Dim yOffset As Single
    Dim Colour(3) As Long
    Colour(0) = color
    Colour(1) = color
    Colour(2) = color
    Colour(3) = color
    If DirectDevice.TestCooperativeLevel <> D3D_OK Then Exit Sub
    If LenB(Text) = 0 Then Exit Sub
    tempstr = Split(Text, vbCrLf)
    SpriteBatch.SetTexture UseFont.Texture
    If Center Then
        X = X - Engine_GetTextWidth(UseFont, Text) * 0.5
    End If
    For i = 0 To UBound(tempstr)
        If Len(tempstr(i)) > 0 Then
            yOffset = i * UseFont.CharHeight
            Count = 0
            ascii() = StrConv(tempstr(i), vbFromUnicode)
            For j = 1 To Len(tempstr(i))
                CopyMemory TempVA, UseFont.HeaderInfo.CharVA(ascii(j - 1)), 24
                TempVA.X = X + Count
                TempVA.Y = Y + yOffset
                Call SpriteBatch.Draw(TempVA.X, TempVA.Y, TempVA.w, TempVA.h, Colour(), TempVA.Tx1, TempVA.Ty1, TempVA.Tx2, TempVA.Ty2)
                Count = Count + UseFont.HeaderInfo.CharWidth(ascii(j - 1))
            Next j
        End If
    Next i
End Sub

Public Function Engine_GetTextWidth(ByRef UseFont As CustomFont, ByVal Text As String) As Integer
'***************************************************
'Returns the width of text
'More info: [url=http://www.vbgore.com/GameClient.TileEngine.Engine_GetTextWidth]http://www.vbgore.com/GameClient.TileEn ... tTextWidth[/url]
'***************************************************
    Dim i As Integer

    'Make sure we have text
    If LenB(Text) = 0 Then Exit Function

    'Loop through the text
    For i = 1 To Len(Text)

        'Add up the stored character widths
        Engine_GetTextWidth = Engine_GetTextWidth + UseFont.HeaderInfo.CharWidth(Asc(mid$(Text, i, 1)))

    Next i

End Function

Sub Init_FontRender()
    Engine_Init_FontTextures
    Engine_Init_FontSettings
End Sub

Sub Engine_Init_FontTextures()

    On Error GoTo eDebug:
'*****************************************************************
'Init the custom font textures
'More info: [url=http://www.vbgore.com/GameClient.TileEngine.Engine_Init_FontTextures]http://www.vbgore.com/GameClient.TileEn ... ntTextures[/url]
'*****************************************************************
    Dim TexInfo As D3DXIMAGE_INFO_A

    'Check if we have the device
    If DirectDevice.TestCooperativeLevel <> D3D_OK Then Exit Sub

    '*** Default font ***

    'Set the texture
    Dim File As String

    File = Get_FileFrom(gui, "f.bmp")

    Set cfonts(1).Texture = DirectD3D8.CreateTextureFromFileEx(DirectDevice, File, D3DX_DEFAULT, D3DX_DEFAULT, D3DX_DEFAULT, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_FILTER_POINT, D3DX_FILTER_POINT, &HFF000000, ByVal 0, ByVal 0)

    'Store the size of the texture
    cfonts(1).TextureSize.X = TexInfo.Width
    cfonts(1).TextureSize.Y = TexInfo.Height

    Delete_File File
    File = Get_FileFrom(gui, "f_b.bmp")
    Set cfonts(2).Texture = DirectD3D8.CreateTextureFromFileEx(DirectDevice, File, D3DX_DEFAULT, D3DX_DEFAULT, D3DX_DEFAULT, 0, D3DFMT_UNKNOWN, D3DPOOL_MANAGED, D3DX_FILTER_POINT, D3DX_FILTER_POINT, &HFF000000, ByVal 0, ByVal 0)

    'Store the size of the texture
    cfonts(2).TextureSize.X = TexInfo.Width
    cfonts(2).TextureSize.Y = TexInfo.Height
    Delete_File File
    Exit Sub

eDebug:

    If Err.Number = "-2005529767" Then
        MsgBox "Error en la textura utilizada de DirectX 8", vbCritical
        'End
    End If

    'End

End Sub

Sub Engine_Init_FontSettings2()
'*********************************************************
'****** Coded by Dunkan ([email=emanuel.m@dunkancorp.com]emanuel.m@dunkancorp.com[/email]) *******
'*********************************************************
    Dim FileNum As Byte
    Dim LoopChar As Long
    Dim Row As Single
    Dim u As Single
    Dim v As Single

    '*** Default font ***

    'Load the header information
    FileNum = FreeFile
    Dim File As String

    File = Get_FileFrom(Scripts, "f_b_d.dat")
    Open File For Binary As #FileNum
    Get #FileNum, , cfonts(2).HeaderInfo
    Close #FileNum

    Delete_File File

    'Calculate some common values
    cfonts(2).CharHeight = cfonts(2).HeaderInfo.CellHeight - 4
    cfonts(2).RowPitch = cfonts(2).HeaderInfo.BitmapWidth \ cfonts(2).HeaderInfo.CellWidth
    cfonts(2).ColFactor = cfonts(2).HeaderInfo.CellWidth / cfonts(2).HeaderInfo.BitmapWidth
    cfonts(2).RowFactor = cfonts(2).HeaderInfo.CellHeight / cfonts(2).HeaderInfo.BitmapHeight

    'Cache the verticies used to draw the character (only requires setting the color and adding to the X/Y values)
    For LoopChar = 0 To 255

        'tU and tV value (basically tU = BitmapXPosition / BitmapWidth, and height for tV)
        Row = (LoopChar - cfonts(2).HeaderInfo.BaseCharOffset) \ cfonts(2).RowPitch
        u = ((LoopChar - cfonts(2).HeaderInfo.BaseCharOffset) - (Row * cfonts(2).RowPitch)) * cfonts(2).ColFactor
        v = Row * cfonts(2).RowFactor

        'Set the verticies
        With cfonts(2).HeaderInfo.CharVA(LoopChar)
            .X = 0
            .Y = 0
            .w = cfonts(2).HeaderInfo.CellWidth
            .h = cfonts(2).HeaderInfo.CellHeight
            .Tx1 = u
            .Ty1 = v
            .Tx2 = u + cfonts(2).ColFactor
            .Ty2 = v + cfonts(2).RowFactor
        End With

    Next LoopChar

End Sub

Sub Engine_Init_FontSettings()
'*********************************************************
'****** Coded by Dunkan ([email=emanuel.m@dunkancorp.com]emanuel.m@dunkancorp.com[/email]) *******
'*********************************************************
    Dim FileNum As Byte
    Dim LoopChar As Long
    Dim Row As Single
    Dim u As Single
    Dim v As Single

    '*** Default font ***
    Engine_Init_FontSettings2
    'Load the header information
    FileNum = FreeFile
    Dim File As String

    File = Get_FileFrom(Scripts, "f_d.dat")

    Open File For Binary As #FileNum
    Get #FileNum, , cfonts(1).HeaderInfo
    Close #FileNum

    Delete_File File

    'Calculate some common values
    cfonts(1).CharHeight = cfonts(1).HeaderInfo.CellHeight - 4
    cfonts(1).RowPitch = cfonts(1).HeaderInfo.BitmapWidth \ cfonts(1).HeaderInfo.CellWidth
    cfonts(1).ColFactor = cfonts(1).HeaderInfo.CellWidth / cfonts(1).HeaderInfo.BitmapWidth
    cfonts(1).RowFactor = cfonts(1).HeaderInfo.CellHeight / cfonts(1).HeaderInfo.BitmapHeight

    'Cache the verticies used to draw the character (only requires setting the color and adding to the X/Y values)
    For LoopChar = 0 To 255

        'tU and tV value (basically tU = BitmapXPosition / BitmapWidth, and height for tV)
        Row = (LoopChar - cfonts(1).HeaderInfo.BaseCharOffset) \ cfonts(1).RowPitch
        u = ((LoopChar - cfonts(1).HeaderInfo.BaseCharOffset) - (Row * cfonts(1).RowPitch)) * cfonts(1).ColFactor
        v = Row * cfonts(1).RowFactor

        'Set the verticies
        With cfonts(1).HeaderInfo.CharVA(LoopChar)
            .X = 0
            .Y = 0
            .w = cfonts(1).HeaderInfo.CellWidth
            .h = cfonts(1).HeaderInfo.CellHeight
            .Tx1 = u
            .Ty1 = v
            .Tx2 = u + cfonts(1).ColFactor
            .Ty2 = v + cfonts(1).RowFactor
        End With

    Next LoopChar
End Sub

Function EsArbol(ByVal GhrNumber As Long) As Boolean

    EsArbol = (GhrNumber = 7000 Or _
               GhrNumber = 7001 Or _
               GhrNumber = 7002 Or _
               GhrNumber = 641 Or _
               GhrNumber = 643 Or _
               GhrNumber = 644 Or _
               GhrNumber = 647 Or _
               GhrNumber = 735 Or _
               GhrNumber = 6581 Or _
               GhrNumber = 6582 Or _
               GhrNumber = 6583 Or _
               GhrNumber = 7222 Or _
               GhrNumber = 7223 Or _
               GhrNumber = 7224 Or _
               GhrNumber = 7225 Or _
               GhrNumber = 7226)
End Function
Function EsRayosX(ByVal X As Integer, ByVal Y As Integer) As Boolean

    With MapData(X, Y)

        EsRayosX = (.Graphic(3).GrhIndex = 718 Or .Graphic(3).GrhIndex = 660 Or .Graphic(3).GrhIndex = 30 Or .Graphic(3).GrhIndex = 2138 Or .Graphic(3).GrhIndex = 9206 Or .Graphic(3).GrhIndex = 9205 Or .Graphic(3).GrhIndex = 7233 Or .Graphic(3).GrhIndex = 5752 Or .Graphic(3).GrhIndex = 5589 Or .Graphic(3).GrhIndex = 5590 Or .Graphic(3).GrhIndex = 624 Or .Graphic(3).GrhIndex = 641 Or .Graphic(3).GrhIndex = 643 Or .Graphic(3).GrhIndex = 644 Or .Graphic(3).GrhIndex = 2174 Or .Graphic(3).GrhIndex = 7231 Or .Graphic(3).GrhIndex = 10423 Or .Graphic(3).GrhIndex = 10421 Or .Graphic(3).GrhIndex = 10422 Or .Graphic(3).GrhIndex = 545 Or .Graphic(3).GrhIndex = 44 Or .Graphic(3).GrhIndex = 531)

        EsRayosX = EsRayosX Or (.ObjGrh.GrhIndex = 718 Or .ObjGrh.GrhIndex = 5589 Or .ObjGrh.GrhIndex = 9196 Or .ObjGrh.GrhIndex = 9205 Or .ObjGrh.GrhIndex = 9206 Or .ObjGrh.GrhIndex = 8684 Or .ObjGrh.GrhIndex = 8685 Or .ObjGrh.GrhIndex = 9195 Or .ObjGrh.GrhIndex = 5590 Or .ObjGrh.GrhIndex = 9199 Or .ObjGrh.GrhIndex = 9193 Or .ObjGrh.GrhIndex = 9201 Or .ObjGrh.GrhIndex = 9202 Or .ObjGrh.GrhIndex = 5591 Or .ObjGrh.GrhIndex = 5592 Or .ObjGrh.GrhIndex = 624 Or .ObjGrh.GrhIndex = 641 Or .ObjGrh.GrhIndex = 643 Or .ObjGrh.GrhIndex = 644 Or .ObjGrh.GrhIndex = 647 Or .ObjGrh.GrhIndex = 5593 Or .ObjGrh.GrhIndex = 5592 Or .ObjGrh.GrhIndex = 9203 Or .ObjGrh.GrhIndex = 9197)
    End With

End Function

Private Function esDeNoche() As Boolean
    If Hour(time) >= 19 Or Hour(time) <= 5 Then
        esDeNoche = True
    End If
End Function

Sub RenderConnect()

    On Error GoTo ErrHandler

1   Call Engine_BeginScene

2   Call Directx_Render_Texture(9997, 0, 0, 600, 800, 0, 0, lvalue)

3   If Shapes(1) Then
4       Call Directx_Render_Texture(12173, frmConnect.Shape1.Left, frmConnect.Shape1.Top, 2, 2, 0, 0, lvalue)
    End If

5   If Shapes(2) Then
6       Call Directx_Render_Texture(12173, frmConnect.Shape2.Left, frmConnect.Shape2.Top, 2, 2, 0, 0, lvalue)
    End If

7   If Shapes(3) Then
8       Call Directx_Render_Texture(12173, frmConnect.Shape3.Left, frmConnect.Shape3.Top, 2, 2, 0, 0, lvalue)
    End If

9   Call Directx_Render_Texture(9998, 295, -(TOP_CAIDA_CONECTAR - Caida), 511, 214, 0, 0, lvalue)

10  Call Directx_Render_Texture(9999, 0, 0, 170, 800, 0, 0, lvalue)

11  If PanelQuitVisible Then
12      Call Directx_Render_Texture(10006, 245, 229, 150, 329, 0, 0, lvalue)
    End If

13  Call EfectoCaida

    While (GetTickCount - fpsLastCheck) / 28 < FramesPerSecCounter
14      Sleep 5
    Wend

    'FPS update
15  If fpsLastCheck + 1000 < GetTickCount Then
16      fps = FramesPerSecCounter
        FramesPerSecCounter = 1
        fpsLastCheck = GetTickCount
    Else
17      FramesPerSecCounter = FramesPerSecCounter + 1
    End If

18  Call SpriteBatch.Flush
19  Call DirectDevice.EndScene
20  Call DirectDevice.Present(ByVal 0, ByVal 0, frmConnect.MainViewPic.hwnd, ByVal 0)

    Exit Sub
ErrHandler:
    MsgBox ("Error en linea: " & Erl & ". Tendrás que reiniciar el cliente debido a que hubo un cambio de resolución no esperado." & vbNewLine & "Err: " & Err.Number & " " & Err.Description)
    End
End Sub

Sub RenderCrearPJ()

    Call Engine_BeginScene

    Dim lighthandle(3) As Long

    AlphaB = 255
    lighthandle(0) = D3DColorXRGB(AlphaB, AlphaB, AlphaB)
    lighthandle(1) = lighthandle(0)
    lighthandle(2) = lighthandle(0)
    lighthandle(3) = lighthandle(0)

    If PanelCrearPJVisible Then
        lighthandle(0) = D3DColorXRGB(126, 126, 126)
        lighthandle(1) = lighthandle(0)
        lighthandle(2) = lighthandle(0)
        lighthandle(3) = lighthandle(0)
    End If

    Call Directx_Render_Texture(10007, 0, 0, 600, 800, 0, 0, lighthandle)        'connect bien
    Call Directx_Render_Texture(10011 + UserRaza, 455, 200, 108, 252, 0, 0, lighthandle)

    ' @@ Body
    Call DDrawGrhtoSurface(BodyData(CPJ_iBody).Walk(CPJ_heading), 284, 140, 1, lighthandle, 1)

    ' @@ Head
    Call DDrawGrhtoSurface(HeadData(CPJ_iHead).Head(CPJ_heading), 284, IIf(UserRaza > 3, 112, 102), 1, lighthandle, 0)

    If UserClase > 0 Then

        ' Clase Img
        Call Directx_Render_Texture(10294 + UserClase, 42, 65, 210, 168, 0, 0, lighthandle)

        ' Clase Str
        Call Directx_Render_Texture(10311 + UserClase, 50, 30, 30, 150, 0, 0, lighthandle)

        ' Raza Str
        Call Directx_Render_Texture(10328 + UserRaza, 250, 77, 31, 111, 0, 0, lighthandle)

        If UserSexo = eGenero.Hombre Then
            Call Directx_Render_Texture(10336, 255, 240, 33, 94, 0, 0, lighthandle)
            Call Directx_Render_Texture(10335, 255, 210, 33, 94, 0, 0, lighthandle)
        Else
            Call Directx_Render_Texture(10334, 255, 240, 33, 94, 0, 0, lighthandle)
            Call Directx_Render_Texture(10337, 255, 210, 33, 94, 0, 0, lighthandle)
        End If

        Dim loopGui As Long
        Dim tmpval As Long

        For loopGui = LBound(GuiTexto()) To UBound(GuiTexto()) - 1
            With GuiTexto(loopGui)
                tmpval = .StartX
                If loopGui > 4 And loopGui < 23 Then
                    If Val(.Texto) = 10 Then
                        tmpval = .StartX - 3
                    End If
                End If
                drawText tmpval, .StartY, .Texto, IIf(PanelCrearPJVisible, lighthandle(0), -1), AlphaB, False, IIf(.Sombreado, 1, 0)
            End With
        Next loopGui

        lighthandle(0) = D3DColorXRGB(AlphaB, AlphaB, AlphaB)
        lighthandle(1) = lighthandle(0)
        lighthandle(2) = lighthandle(0)
        lighthandle(3) = lighthandle(0)

        If PanelCrearPJVisible Then
            Call Directx_Render_Texture(10009, 0, -(TOP_CAIDA_CONECTAR - Caida), 600, 800, 0, 0, lighthandle)
            Call DrawGuiTexto

            Call Directx_Render_Texture(10010, 0, 557, 50, 800, 0, 0, lighthandle)
        Else
            Call Directx_Render_Texture(10011, 0, 557, 50, 800, 0, 0, lighthandle)
        End If

        If PanelCrearPJVisible And Caida = TOP_CAIDA_CREARPJ Then
            GetKeyboardState keys(0)
            If Not keys(VK_CAPITAL) = 0 Then
                With GuiTexto(30)
                    drawText 230, 221, .Texto, D3DColorXRGB(255, 255, 255), AlphaB, False, 1
                End With
            End If
        End If

    End If


    With GuiTexto(28)
        drawText .StartX, .StartY, .Texto, IIf(PanelCrearPJVisible, -8487298, -1), AlphaB, False, IIf(.Sombreado, 1, 0)
    End With

    If ModoCaida = 0 Then
        If Caida > 0 And Caida < TOP_CAIDA_CREARPJ Then
            Caida = Caida + 10 * tSetup.EfectoCaida
        End If
    Else
        If Caida > 0 Then
            Caida = Caida - 10 * tSetup.EfectoCaida
        End If
    End If

    'Call DDrawTransGrhIndextoSurface(426, 500, 500, 0, False, False, lighthandle)
    Call EfectoCaida

    While (GetTickCount - fpsLastCheck) / 28 < FramesPerSecCounter
        Sleep 5
    Wend

    'FPS update
    If fpsLastCheck + 1000 < GetTickCount Then
        fps = FramesPerSecCounter
        FramesPerSecCounter = 1
        fpsLastCheck = GetTickCount
    Else
        FramesPerSecCounter = FramesPerSecCounter + 1
    End If

    Call SpriteBatch.Flush
    Call DirectDevice.EndScene
    Call DirectDevice.Present(ByVal 0, ByVal 0, frmCrearPersonaje.MainViewPic.hwnd, ByVal 0)

End Sub

Public Function CPJ_UpdateBodyAndHead()
    Select Case UserSexo
    Case eGenero.Hombre
        Select Case UserRaza
        Case eRaza.Humano
            CPJ_iBody = 21
            CPJ_iHead = 1
        Case eRaza.Elfo
            CPJ_iBody = 21
            CPJ_iHead = 102
        Case eRaza.ElfoOscuro
            CPJ_iBody = 32
            CPJ_iHead = 201
        Case eRaza.Enano
            CPJ_iBody = 53
            CPJ_iHead = 301
        Case eRaza.Gnomo
            CPJ_iBody = 53
            CPJ_iHead = 401
        End Select
    Case eGenero.Mujer
        Select Case UserRaza
        Case eRaza.Humano
            CPJ_iBody = 39
            CPJ_iHead = 72
        Case eRaza.Elfo
            CPJ_iBody = 39
            CPJ_iHead = 170
        Case eRaza.ElfoOscuro
            CPJ_iBody = 40
            CPJ_iHead = 270
        Case eRaza.Enano
            CPJ_iBody = 60
            CPJ_iHead = 371
        Case eRaza.Gnomo
            CPJ_iBody = 60
            CPJ_iHead = 470
        End Select
    End Select

End Function

Public Function Engine_TPtoSPX(ByVal X As Byte) As Long
    Engine_TPtoSPX = X * 32 - ScreenminX * 32 + OffsetCounterX - 16
End Function

Public Function Engine_TPtoSPY(ByVal Y As Byte) As Long
    Engine_TPtoSPY = Y * 32 - ScreenminY * 32 + OffsetCounterY - 16
End Function

Public Function Engine_PixelPosX(ByVal X As Byte) As Integer
'*****************************************************************
'Converts a tile position to a screen position
'*****************************************************************
    Engine_PixelPosX = (X - 1) * 32
End Function

Public Function Engine_PixelPosY(ByVal Y As Byte) As Integer
'*****************************************************************
'Converts a tile position to a screen position
'*****************************************************************
    Engine_PixelPosY = (Y - 1) * 32
End Function

Public Sub Engine_D3DColor_To_RGB_List(RGB_List() As Long, color As D3DCOLORVALUE)
'***************************************************
'Author: Ezequiel Juárez (Standelf)
'Last Modification: 14/05/10
'Blisse-AO | Set a D3DColorValue to a RGB List
'***************************************************
    RGB_List(0) = D3DColorARGB(color.A, color.r, color.g, color.b)
    RGB_List(1) = RGB_List(0)
    RGB_List(2) = RGB_List(0)
    RGB_List(3) = RGB_List(0)
End Sub

Public Sub Engine_Long_To_RGB_List(RGB_List() As Long, long_color As Long)
'***************************************************
'Author: Ezequiel Juárez (Standelf)
'Last Modification: 16/05/10
'Blisse-AO | Set a Long Color to a RGB List
'***************************************************
    RGB_List(0) = long_color
    RGB_List(1) = RGB_List(0)
    RGB_List(2) = RGB_List(0)
    RGB_List(3) = RGB_List(0)
End Sub

Public Sub Engine_BeginScene()

    Call DirectDevice.Clear(0, ByVal 0, D3DCLEAR_TARGET, 0, 1#, 0)
    Call SpriteBatch.begin
    Call DirectDevice.BeginScene

End Sub

Public Sub Engine_EndScene(ByRef destRect As RECT, Optional ByVal hWndDest As Long = 0)

    Call SpriteBatch.Flush
    Call DirectDevice.EndScene

    If hWndDest = 0 Then
        Call DirectDevice.Present(destRect, ByVal 0, ByVal 0, ByVal 0)
    Else
        Call DirectDevice.Present(destRect, ByVal 0, hWndDest, ByVal 0)
    End If

End Sub

Public Function ARGBtoD3DCOLORVALUE(ByVal ARGB As Long, _
                                    ByRef color As D3DCOLORVALUE) As Long

    Dim dest(0 To 3) As Byte
    CopyMemory dest(0), ARGB, 4

    With color
        .A = dest(3)
        .r = dest(2)
        .g = dest(1)
        .b = dest(0)
    End With

End Function

Public Function Engine_Change_Alpha(ByRef RGB_List() As Long, ByVal Alpha As Byte) As Long
    Dim TempColor As D3DCOLORVALUE
    ARGBtoD3DCOLORVALUE RGB_List(0), TempColor

    If tSetup.AlphaBlending = False Then Alpha = 255

    Engine_Change_Alpha = D3DColorARGB(Alpha, TempColor.r, TempColor.g, TempColor.b)
End Function

