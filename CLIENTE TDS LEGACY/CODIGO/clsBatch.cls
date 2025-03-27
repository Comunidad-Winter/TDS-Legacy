VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBatch"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private m_VBuffer As Direct3DVertexBuffer8
Private m_IBuffer As Direct3DIndexBuffer8
Private m_Texture As Direct3DTexture8
Private m_Alpha As Boolean
Private m_AlphaByte As Byte

Private Type TYPE_VERTEX
    X As Single
    Y As Single
    Z As Single

    Colour As Long

    tX As Single
    tY As Single
End Type

Private Const PI As Single = 3.14159265358979

Private Const WATER_WAVE_SIZE_X As Byte = 12
Private Const WATER_WAVE_SIZE_Y As Byte = 12
Private Const WATER_WAVE_HEIGHT As Byte = 1
Private Const WATER_WAVE_FACTOR_X As Single = (2 * PI) / (WATER_WAVE_SIZE_X * TilePixelWidth)
Private Const WATER_WAVE_FACTOR_Y As Single = (2 * PI) / (WATER_WAVE_SIZE_Y * TilePixelHeight)
Private Const WATER_TILE_FACTOR_X As Single = TilePixelWidth * WATER_WAVE_FACTOR_X
Private Const WATER_TILE_FACTOR_Y As Single = TilePixelHeight * WATER_WAVE_FACTOR_Y

'
' Represent the dynamic data of the batch
'
Private m_Data() As TYPE_VERTEX
Private m_Position As Long

Public Sub begin()
'
' Re-initialise the states of the batch
'
    Call DirectDevice.SetTexture(0, m_Texture)
    Call DirectDevice.SetStreamSource(0, m_VBuffer, 24)
    Call DirectDevice.SetIndices(m_IBuffer, 0)

    'If m_Alpha Then
    'DirectDevice.SetRenderState D3DRS_SRCBLEND, D3DBLEND_ONE
    'DirectDevice.SetRenderState D3DRS_DESTBLEND, D3DBLEND_ONE
    'Else
    'DirectDevice.SetRenderState D3DRS_SRCBLEND, D3DBLEND_SRCALPHA
    'DirectDevice.SetRenderState D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA
    'End If

    If m_AlphaByte > 0 Then
        Call DirectDevice.SetRenderState(D3DRS_TEXTUREFACTOR, D3DColorARGB(m_AlphaByte, 0, 0, 0))
        'Else
        'Call DirectDevice.SetRenderState(D3DRS_TEXTUREFACTOR, D3DColorARGB(255, 0, 0, 0))
    End If

End Sub

Public Sub SetAlpha(ByVal IsAlpha As Boolean)

    If IsAlpha <> m_Alpha Then
        '
        ' Flush the batch since we're using a diferent state
        '
        Call Flush

        '
        ' Update the new state of the batch
        '
        m_Alpha = IsAlpha

        If IsAlpha Then
            DirectDevice.SetRenderState D3DRS_SRCBLEND, D3DBLEND_ONE
            DirectDevice.SetRenderState D3DRS_DESTBLEND, D3DBLEND_ONE
        Else        '
            DirectDevice.SetRenderState D3DRS_SRCBLEND, D3DBLEND_SRCALPHA
            DirectDevice.SetRenderState D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA
        End If

    End If

End Sub

Public Sub SetAlphaByte(ByVal IsAlpha As Byte)

    If IsAlpha <> m_AlphaByte Then
        '
        ' Flush the batch since we're using a diferent state
        '
        Call Flush

        '
        ' Update the new state of the batch
        '
        m_AlphaByte = IsAlpha

        If m_AlphaByte > 0 Then
            Call DirectDevice.SetRenderState(D3DRS_TEXTUREFACTOR, D3DColorARGB(m_AlphaByte, 0, 0, 0))
            'Else
            'Call DirectDevice.SetRenderState(D3DRS_TEXTUREFACTOR, D3DColorARGB(255, 0, 0, 0))
        End If

    End If

End Sub

Public Sub SetTexture(ByRef Texture As Direct3DTexture8)

    If ObjPtr(m_Texture) <> ObjPtr(Texture) Then        'te cabe vb6
'
' Flush the batch since we're using a diferent texture
'
        Call Flush

        Set m_Texture = Texture

        '
        ' Update the new texture of the batch
        '
        Call DirectDevice.SetTexture(0, Texture)

    End If

End Sub

Friend Sub Draw(ByVal X As Long, _
                ByVal Y As Long, _
                ByVal Width As Long, _
                ByVal Height As Long, _
                ByRef color() As Long, _
                Optional ByVal Tx1 As Single = 0, _
                Optional ByVal Ty1 As Single = 0, _
                Optional ByVal Tx2 As Single = 1, _
                Optional ByVal Ty2 As Single = 1, _
                Optional ByVal Angle As Single = 0)

    If Angle <> 0 And Angle <> 360 Then

        Dim NewX As Single
        Dim NewY As Single
        Dim SinRad As Single
        Dim CosRad As Single
        Dim RadAngle As Single
        Dim CenterX As Single
        Dim CenterY As Single

        RadAngle = Angle * DegreeToRadian

        CenterX = X + (Width * 0.5)
        CenterY = Y + (Height * 0.5)

        SinRad = Sin(RadAngle)
        CosRad = Cos(RadAngle)

    End If

    m_Data(m_Position).X = X
    m_Data(m_Position).Y = Y + Height
    m_Data(m_Position).Z = 0
    m_Data(m_Position).Colour = color(0)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty2

    If Angle <> 0 And Angle <> 360 Then

        NewX = CenterX + (m_Data(m_Position).X - CenterX) * -CosRad - (m_Data(m_Position).Y - CenterY) * -SinRad
        NewY = CenterY + (m_Data(m_Position).Y - CenterY) * -CosRad + (m_Data(m_Position).X - CenterX) * -SinRad

        m_Data(m_Position).X = NewX
        m_Data(m_Position).Y = NewY

    End If

    m_Position = m_Position + 1

    m_Data(m_Position).X = X
    m_Data(m_Position).Y = Y
    m_Data(m_Position).Z = 0
    m_Data(m_Position).Colour = color(1)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty1

    If Angle <> 0 And Angle <> 360 Then

        NewX = CenterX + (m_Data(m_Position).X - CenterX) * -CosRad - (m_Data(m_Position).Y - CenterY) * -SinRad
        NewY = CenterY + (m_Data(m_Position).Y - CenterY) * -CosRad + (m_Data(m_Position).X - CenterX) * -SinRad

        m_Data(m_Position).X = NewX
        m_Data(m_Position).Y = NewY

    End If

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width
    m_Data(m_Position).Y = Y + Height
    m_Data(m_Position).Z = 0
    m_Data(m_Position).Colour = color(2)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty2

    If Angle <> 0 And Angle <> 360 Then

        NewX = CenterX + (m_Data(m_Position).X - CenterX) * -CosRad - (m_Data(m_Position).Y - CenterY) * -SinRad
        NewY = CenterY + (m_Data(m_Position).Y - CenterY) * -CosRad + (m_Data(m_Position).X - CenterX) * -SinRad

        m_Data(m_Position).X = NewX
        m_Data(m_Position).Y = NewY

    End If

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width
    m_Data(m_Position).Y = Y
    m_Data(m_Position).Z = 0
    m_Data(m_Position).Colour = color(3)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty1

    If Angle <> 0 And Angle <> 360 Then

        NewX = CenterX + (m_Data(m_Position).X - CenterX) * -CosRad - (m_Data(m_Position).Y - CenterY) * -SinRad
        NewY = CenterY + (m_Data(m_Position).Y - CenterY) * -CosRad + (m_Data(m_Position).X - CenterX) * -SinRad

        m_Data(m_Position).X = NewX
        m_Data(m_Position).Y = NewY

    End If

    m_Position = m_Position + 1

    If m_Position >= UBound(m_Data) Then
        Call Flush
    End If

End Sub

Friend Sub DrawNormal(ByVal X As Single, _
                      ByVal Y As Single, _
                      ByVal Width As Long, _
                      ByVal Height As Long, _
                      ByVal color As Long, _
                      Optional ByVal Tx1 As Single = 0, _
                      Optional ByVal Ty1 As Single = 0, _
                      Optional ByVal Tx2 As Single = 1, _
                      Optional ByVal Ty2 As Single = 1)

    m_Data(m_Position).X = X
    m_Data(m_Position).Y = Y
    m_Data(m_Position).Colour = color
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    m_Data(m_Position).X = X
    m_Data(m_Position).Y = Y + Height
    m_Data(m_Position).Colour = color
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width
    m_Data(m_Position).Y = Y + Height
    m_Data(m_Position).Colour = color
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width
    m_Data(m_Position).Y = Y
    m_Data(m_Position).Colour = color
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    If m_Position >= UBound(m_Data) Then
        Call Flush
    End If

End Sub

Friend Sub DrawReflection(ByVal X As Long, _
                          ByVal Y As Long, _
                          ByVal Width As Long, _
                          ByVal Height As Long, _
                          ByRef ColorLight() As Long, _
                          Optional ByVal Tx1 As Single = 0, _
                          Optional ByVal Ty1 As Single = 0, _
                          Optional ByVal Tx2 As Single = 1, _
                          Optional ByVal Ty2 As Single = 1)


' Dim i As Long

' For i = 0 To 3
' Color(i).a = ColorLight(i).a * 0.5
'Color(i).R = ColorLight(i).R * 0.2
'Color(i).g = ColorLight(i).g * 0.5
' Color(i).b = ColorLight(i).b
'  Next

    Dim dt As Single, dX As Long, dy As Long
    dt = (GetTickCount Mod 10000) * 0.0006283
    dX = Sin(dt) * 8
    dy = Sin(dt * 2 + 1) * 5

    m_Data(m_Position).X = X + dX
    m_Data(m_Position).Y = Y + Height * 1.75 - dy
    m_Data(m_Position).Z = 0.5
    m_Data(m_Position).Colour = ColorLight(0)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    m_Data(m_Position).X = X
    m_Data(m_Position).Y = Y + Height - 5
    m_Data(m_Position).Z = 0.5
    m_Data(m_Position).Colour = ColorLight(1)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width + dX
    m_Data(m_Position).Y = Y + Height * 1.75 - dy
    m_Data(m_Position).Z = 0.5
    m_Data(m_Position).Colour = ColorLight(2)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width
    m_Data(m_Position).Y = Y + Height - 5
    m_Data(m_Position).Z = 0.5
    m_Data(m_Position).Colour = ColorLight(3)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    If m_Position >= UBound(m_Data) Then
        Call Flush
    End If

End Sub

Friend Sub DrawWater(ByVal X As Single, _
                     ByVal Y As Single, _
                     ByVal Width As Long, _
                     ByVal Height As Long, _
                     ByRef color() As Long, _
                     ByVal Tx1 As Single, _
                     ByVal Ty1 As Single, _
                     ByVal Tx2 As Single, _
                     ByVal Ty2 As Single, _
                     ByVal MapX As Integer, _
                     ByVal MapY As Integer, _
                     ByVal Top As Byte, _
                     ByVal Right As Byte, _
                     ByVal Bottom As Byte, _
                     ByVal Left As Byte)

    Dim T As Single
    T = (FrameTimerGlobal Mod 62831) * 0.004

    Dim tX As Single, tY As Single
    tX = X * WATER_WAVE_FACTOR_X
    tY = Y * WATER_WAVE_FACTOR_Y

    m_Data(m_Position).X = X + Cos(T + tX + tY + WATER_TILE_FACTOR_Y) * WATER_WAVE_HEIGHT * Left
    m_Data(m_Position).Y = Y + Height + Sin(T + tX + tY + WATER_TILE_FACTOR_Y) * WATER_WAVE_HEIGHT * Bottom
    m_Data(m_Position).Z = 1
    m_Data(m_Position).Colour = color(0)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Cos(T + tX + tY) * WATER_WAVE_HEIGHT * Left
    m_Data(m_Position).Y = Y + Sin(T + tX + tY) * WATER_WAVE_HEIGHT * Top
    m_Data(m_Position).Z = 1
    m_Data(m_Position).Colour = color(1)
    m_Data(m_Position).tX = Tx1
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width + Cos(T + tX + tY + WATER_TILE_FACTOR_X + WATER_TILE_FACTOR_Y) * WATER_WAVE_HEIGHT * Right
    m_Data(m_Position).Y = Y + Height + Sin(T + tX + tY + WATER_TILE_FACTOR_X + WATER_TILE_FACTOR_Y) * WATER_WAVE_HEIGHT * Bottom
    m_Data(m_Position).Z = 1
    m_Data(m_Position).Colour = color(2)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty2

    m_Position = m_Position + 1

    m_Data(m_Position).X = X + Width + Cos(T + tX + tY + WATER_TILE_FACTOR_X) * WATER_WAVE_HEIGHT * Right
    m_Data(m_Position).Y = Y + Sin(T + tX + tY + WATER_TILE_FACTOR_X) * WATER_WAVE_HEIGHT * Top
    m_Data(m_Position).Z = 1
    m_Data(m_Position).Colour = color(3)
    m_Data(m_Position).tX = Tx2
    m_Data(m_Position).tY = Ty1

    m_Position = m_Position + 1

    If m_Position >= UBound(m_Data) Then
        Call Flush
    End If

End Sub

Public Sub Finish()
'
' Flush the batch since we're finished
'
    Call Flush

End Sub

Public Sub Flush()

'
' Only draw if there is any data in the buffer
'
    If m_Position > 0 Then

        '
        ' Set the new data of the vertex buffer
        '
        Call D3DVertexBuffer8SetData(m_VBuffer, 0, m_Position * LenB(m_Data(0)), D3DLOCK_DISCARD, m_Data(0))
        Call DirectDevice.DrawIndexedPrimitive(D3DPT_TRIANGLELIST, 0, (m_Position / 2) * 3, 0, m_Position / 2)

        '
        ' We start all over again
        '
        m_Position = 0

    End If

End Sub

Public Sub Initialize(ByVal Capacity As Long)

    ReDim m_Data(Capacity - 1) As TYPE_VERTEX

    '
    '  Create the vertice buffer
    '
    Set m_VBuffer = DirectDevice.CreateVertexBuffer(24 * Capacity, D3DUSAGE_DYNAMIC, D3DFVF_XYZ Or D3DFVF_DIFFUSE Or D3DFVF_TEX1, D3DPOOL_DEFAULT)

    '
    '  Create the indice buffer, fill it with pre-baked indices
    '
    Set m_IBuffer = DirectDevice.CreateIndexBuffer(3 * Capacity, D3DUSAGE_WRITEONLY, D3DFMT_INDEX16, D3DPOOL_DEFAULT)

    Dim lpIndices() As Integer

    ReDim lpIndices(Capacity * 3 / 2 - 1) As Integer

    Dim I As Long, j As Integer

    For I = 0 To UBound(lpIndices) Step 6
        lpIndices(I) = j
        lpIndices(I + 1) = j + 1
        lpIndices(I + 2) = j + 2
        lpIndices(I + 3) = j + 2
        lpIndices(I + 4) = j + 3
        lpIndices(I + 5) = j + 1

        j = j + 4
    Next

    Call D3DIndexBuffer8SetData(m_IBuffer, 0, 3 * Capacity, 0, lpIndices(0))

End Sub

