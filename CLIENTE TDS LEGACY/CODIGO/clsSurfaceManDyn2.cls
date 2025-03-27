VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSurfaceManDyn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'Inherit from the surface manager
Implements clsSurfaceManager

Private Const BYTES_PER_MB As Long = 1048576        '1Mb = 1024 Kb = 1024 * 1024 bytes = 1048576 bytes
Private Const MIN_MEMORY_TO_USE As Long = 4 * BYTES_PER_MB        '4 Mb
Private Const DEFAULT_MEMORY_TO_USE As Long = 16 * BYTES_PER_MB        '16 Mb

'Number of buckets in our hash table. Must be a nice prime number.
Const HASH_TABLE_SIZE As Long = 337

Private Type SURFACE_ENTRY_DYN
    FileIndex As Long
    lastAccess As Long
    Surface As Direct3DTexture8
End Type

Private Type HashNode
    surfaceCount As Integer
    SurfaceEntry() As SURFACE_ENTRY_DYN
End Type

Private surfaceList(HASH_TABLE_SIZE - 1) As HashNode

Private DirectD3D As D3DX8

Private maxBytesToUse As Long
Private usedBytes As Long

Private useVideoMemory As Boolean

Private ResourcePath As String

Private Declare Function GetTickCount Lib "kernel32" () As Long

Private Sub Class_Initialize()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 3/06/2006
'
'**************************************************************
    usedBytes = 0
    maxBytesToUse = MIN_MEMORY_TO_USE
End Sub

Private Sub Class_Terminate()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 3/06/2006
'Clean up
'**************************************************************
    Dim I As Long
    Dim j As Long

    'Destroy every surface in memory
    For I = 0 To HASH_TABLE_SIZE - 1
        With surfaceList(I)
            For j = 1 To .surfaceCount
                Set .SurfaceEntry(j).Surface = Nothing
            Next j

            'Destroy the arrays
            Erase .SurfaceEntry
        End With
    Next I
End Sub

Private Sub clsSurfaceManager_Initialize(ByRef DD As D3DX8, ByVal graphicPath As String, Optional ByVal maxMemoryUsageInMb As Long = -1)
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 29/07/2012 - ^[GS]^
'Initializes the manager
'**************************************************************
    Set DirectD3D = DD

    ResourcePath = graphicPath

    If maxMemoryUsageInMb = -1 Then
        maxBytesToUse = DEFAULT_MEMORY_TO_USE        ' 16 Mb by default
    ElseIf maxMemoryUsageInMb * BYTES_PER_MB < MIN_MEMORY_TO_USE Then
        maxBytesToUse = MIN_MEMORY_TO_USE        ' 4 Mb is the minimum allowed
    Else
        maxBytesToUse = maxMemoryUsageInMb * BYTES_PER_MB
    End If
End Sub

Private Property Get clsSurfaceManager_Surface(ByVal FileIndex As Long) As Direct3DTexture8
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 3/06/2006
'Retrieves the requested texture
'**************************************************************
    Dim I As Long

    ' Search the index on the list
    With surfaceList(FileIndex Mod HASH_TABLE_SIZE)
        For I = 1 To .surfaceCount
            If .SurfaceEntry(I).FileIndex = FileIndex Then
                .SurfaceEntry(I).lastAccess = GetTickCount
                Set clsSurfaceManager_Surface = .SurfaceEntry(I).Surface
                Exit Property
            End If
        Next I
    End With

    'Not in memory, load it!
    Set clsSurfaceManager_Surface = LoadSurface(FileIndex)
End Property

Private Function LoadSurface(ByVal FileIndex As Long, Optional ByVal PNG As Boolean) As Direct3DTexture8

    On Error GoTo errHandler
    Dim newSurface As SURFACE_ENTRY_DYN
    Dim surface_desc As D3DSURFACE_DESC
    Dim InfoHead As INFOHEADER
    Dim data() As Byte

    InfoHead = File_Find(App.Path & "\GRAFICOS\Graphics.TDSL", CStr(FileIndex) & ".bmp")

    With newSurface

        'Si no existe usamos PNG
        If InfoHead.lngFileSize > 0 Then
            Extract_File_Memory graphics, App.Path & "\GRAFICOS\", LCase$(CStr(FileIndex) & ".bmp"), data()
        Else
            InfoHead = File_Find(App.Path & "\GRAFICOS\Graphics.TDSL", CStr(FileIndex) & ".png")

            If InfoHead.lngFileSize < 1 Then
                Exit Function
            End If

            Extract_File_Memory graphics, App.Path & "\GRAFICOS\", LCase$(CStr(FileIndex) & ".png"), data()
        End If


        Set .Surface = DirectD3D.CreateTextureFromFileInMemoryEx( _
                       DirectDevice, data(0), UBound(data) + 1, _
                       D3DX_DEFAULT, D3DX_DEFAULT, 0, 0, D3DFMT_A8R8G8B8, D3DPOOL_MANAGED, D3DX_FILTER_NONE, _
                       D3DX_FILTER_NONE, &HFF000000, ByVal 0, ByVal 0)

        Erase data

        .FileIndex = FileIndex

        'Set last access time (if we didn't we would reckon this texture as the one lru)
        .lastAccess = GetTickCount

        newSurface.Surface.GetLevelDesc 0, surface_desc

    End With

    'Insert surface to the list
    With surfaceList(FileIndex Mod HASH_TABLE_SIZE)
        .surfaceCount = .surfaceCount + 1

        ReDim Preserve .SurfaceEntry(1 To .surfaceCount) As SURFACE_ENTRY_DYN

        .SurfaceEntry(.surfaceCount) = newSurface

        Set LoadSurface = newSurface.Surface
    End With

    'Update used bytes
    usedBytes = usedBytes + surface_desc.Size

    'Check if we have exceeded our allowed share of memory usage
    Do While usedBytes > maxBytesToUse
        'Remove a file. If no file could be removed we continue, if the file was previous to our surface we update the index
        If Not RemoveLRU() Then
            Exit Do
        End If
    Loop
    Exit Function

errHandler:
    MsgBox "Ha ocurrido un error critico para el funcionamiento del juego, por favor informa a los administradores sobre el error, enviando el archivo errores.log de la carpeta del juego."
    MsgBox "Error en LoadSurface, grafico: " & FileIndex & IIf(PNG = True, ".png", ".bmp")
    'End
End Function

Private Function RemoveLRU() As Boolean
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 3/06/2006
'Removes the Least Recently Used surface to make some room for new ones
'**************************************************************
    Dim LRUi As Long
    Dim LRUj As Long
    Dim LRUtime As Long
    Dim I As Long
    Dim j As Long
    Dim ddsd As D3DSURFACE_DESC

    LRUtime = GetTickCount

    'Check out through the whole list for the least recently used
    For I = 0 To HASH_TABLE_SIZE - 1
        With surfaceList(I)
            For j = 1 To .surfaceCount
                If LRUtime > .SurfaceEntry(j).lastAccess Then
                    LRUi = I
                    LRUj = j
                    LRUtime = .SurfaceEntry(j).lastAccess
                End If
            Next j
        End With
    Next I

    If LRUj Then
        RemoveLRU = True
        'Retrieve the surface desc
        Call surfaceList(LRUi).SurfaceEntry(LRUj).Surface.GetLevelDesc(0, ddsd)

        'Remove it
        Set surfaceList(LRUi).SurfaceEntry(LRUj).Surface = Nothing
        surfaceList(LRUi).SurfaceEntry(LRUj).FileIndex = 0

        'Move back the list (if necessary)
        With surfaceList(LRUi)
            For j = LRUj To .surfaceCount - 1
                .SurfaceEntry(j) = .SurfaceEntry(j + 1)
            Next j

            .surfaceCount = .surfaceCount - 1
            If .surfaceCount Then
                ReDim Preserve .SurfaceEntry(1 To .surfaceCount) As SURFACE_ENTRY_DYN
            Else
                Erase .SurfaceEntry
            End If
        End With

        'Update the used bytes
        usedBytes = usedBytes - ddsd.Size
    End If
End Function


