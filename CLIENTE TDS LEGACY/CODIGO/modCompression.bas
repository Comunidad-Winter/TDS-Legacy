Attribute VB_Name = "modCompression"
Option Explicit


'BitMaps Strucures
Public Type BITMAPFILEHEADER
    bfType As Integer
    bfSize As Long
    bfReserved1 As Integer
    bfReserved2 As Integer
    bfOffBits As Long
End Type
Public Type BITMAPINFOHEADER
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
Public Type RGBQUAD
    rgbBlue As Byte
    rgbGreen As Byte
    rgbRed As Byte
    rgbReserved As Byte
End Type
Public Type BITMAPINFO
    bmiHeader As BITMAPINFOHEADER
    bmiColors(255) As RGBQUAD
End Type

'To get free bytes in drive
Private Declare Function GetDiskFreeSpace Lib "kernel32" Alias "GetDiskFreeSpaceExA" (ByVal lpRootPathName As String, FreeBytesToCaller As Currency, bytesTotal As Currency, FreeBytesTotal As Currency) As Long

'This structure will describe our binary file's
'size and number of contained files
Public Type FILEHEADER
    lngFileSize As Long        'How big is this file? (Used to check integrity)
    intNumFiles As Integer        'How many files are inside?
End Type

'This structure will describe each file contained
'in our binary file
Public Type INFOHEADER
    lngFileStart As Long        'Where does the chunk start?
    lngFileSize As Long        'How big is this chunk of stored data?
    strFileName As String * 16        'What's the name of the file this data came from?
    lngFileSizeUncompressed As Long        'How big is the file compressed
End Type

Public Enum resource_file_type
    graphics
    MP3
    WAV
    Scripts
    gui
    Map
End Enum

Private Const BI_RGB As Long = 0
Private Const BI_RLE8 As Long = 1
Private Const BI_RLE4 As Long = 2
Private Const BI_BITFIELDS As Long = 3
Private Const BI_JPG As Long = 4
Private Const BI_PNG As Long = 5


Private Declare Function UnCompress Lib "zlib.dll" Alias "uncompress" (dest As Any, destLen As Any, src As Any, ByVal srcLen As Long) As Long

Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Private Const MAX_LENGTH = 512

Public Sub Decompress_Data(ByRef data() As Byte, ByVal OrigSize As Long)
    Dim BufTemp() As Byte

    ReDim BufTemp(OrigSize - 1)
    data(0) = data(0) Xor 166
    UnCompress BufTemp(0), OrigSize, data(0), UBound(data) + 1

    ReDim data(OrigSize - 1)
    data = BufTemp
    Erase BufTemp
End Sub

Public Function Extract_File(ByVal file_type As resource_file_type, ByVal resource_path As String, ByVal File_Name As String, ByVal OutputFilePath As String, Optional ByVal UseOutputFolder As Boolean = False) As Boolean
'*****************************************************************
'Author: Juan Martín Dotuyo Dodero
'Last Modify Date: 10/13/2004
'Extracts all files from a resource file
'*****************************************************************
    Dim SourceFilePath As String
    Dim SourceData() As Byte
    Dim InfoHead As INFOHEADER
    Dim handle As Integer

    'Set up the error handler
    On Local Error GoTo errHandler

    Select Case file_type
    Case graphics
        SourceFilePath = resource_path & "\Graphics.TDSL"

    Case MP3
        SourceFilePath = resource_path & "\Musics.TDSL"

    Case WAV
        SourceFilePath = resource_path & "\Sounds.TDSL"

    Case Scripts
        SourceFilePath = resource_path & "\INITs.TDSL"

    Case gui
        SourceFilePath = resource_path & "\Interface.TDSL"

    Case Map
        SourceFilePath = resource_path & "\MapsTDS.TDSL"

    Case Else
        Exit Function
    End Select

    'Find the Info Head of the desired file
    InfoHead = File_Find(SourceFilePath, File_Name)

    If InfoHead.strFileName = "" Or InfoHead.lngFileSize = 0 Then Exit Function

    'Open the binary file
    handle = FreeFile
    Open SourceFilePath For Binary Access Read Lock Write As handle

    'Make sure there is enough space in the HD
    If InfoHead.lngFileSizeUncompressed > General_Drive_Get_Free_Bytes(Left$(App.Path, 3)) Then
        Close handle
        MsgBox "There is not enough drive space to extract the compressed file.", , "Error"
        Exit Function
    End If

    'Extract file from the binary file

    'Resize the byte data array
    ReDim SourceData(InfoHead.lngFileSize - 1)

    'Get the data
    Get handle, InfoHead.lngFileStart, SourceData

    'Decompress all data
    Decompress_Data SourceData, InfoHead.lngFileSizeUncompressed

    'Close the binary file
    Close handle

    'Get a free handler
    handle = FreeFile

    Open OutputFilePath & InfoHead.strFileName For Binary As handle

    Put handle, 1, SourceData

    Close handle

    Erase SourceData

    Extract_File = True
    Exit Function

errHandler:
    Close handle
    Erase SourceData
    'Display an error message if it didn't work
    'MsgBox "Unable to decode binary file. Reason: " & Err.number & " : " & Err.Description, vbOKOnly, "Error"
End Function

Public Sub Delete_File(ByVal file_path As String)
'*****************************************************************
'Author: Juan Martín Dotuyo Dodero
'Last Modify Date: 3/03/2005
'Deletes a resource files
'**************************

    Dim handle As Integer
    Dim data() As Byte

    On Error GoTo Error_Handler

    'We open the file to delete
    handle = FreeFile
    Open file_path For Binary Access Write Lock Read As handle
    'We replace all the bytes in it with 0s

    ReDim data(LOF(handle) - 1)
    Put handle, 1, data

    'We close the file
    Close handle

    'Now we delete it, knowing that if they retrieve it (some antivirus may create backup copies of deleted files), it will be useless
    Kill file_path

    Exit Sub

Error_Handler:

    On Error Resume Next
    Kill file_path
End Sub

Private Function AlignScan(ByVal inWidth As Long, ByVal inDepth As Integer) As Long
'*****************************************************************
'Author: Unknown
'Last Modify Date: Unknown
'*****************************************************************
    AlignScan = (((inWidth * inDepth) + &H1F) And Not &H1F&) \ &H8
End Function

Public Function Get_Bitmap(ByRef ResourcePath As String, ByRef FileName As String, ByRef bmpInfo As BITMAPINFO, ByRef data() As Byte) As Boolean
'*****************************************************************
'Author: Nicolas Matias Gonzalez (NIGO)
'Last Modify Date: 11/30/2007
'Retrieves bitmap file data
'*****************************************************************
    Dim InfoHead As INFOHEADER
    Dim rawData() As Byte
    Dim offBits As Long
    Dim bitmapSize As Long
    Dim colorCount As Long

    'If Get_InfoHeader(ResourcePath, FileName, InfoHead) Then
    'Extract the file and create the bitmap data from it.

    If Extract_File_Memory(graphics, ResourcePath, FileName, rawData) Then
        'If Extract_File(ResourcePath, InfoHead, rawData) Then
        Call CopyMemory(offBits, rawData(10), 4)
        Call CopyMemory(bmpInfo.bmiHeader, rawData(14), 40)

        With bmpInfo.bmiHeader
            bitmapSize = AlignScan(.biWidth, .biBitCount) * Abs(.biHeight)

            If .biBitCount < 24 Or .biCompression = BI_BITFIELDS Or (.biCompression <> BI_RGB And .biBitCount = 32) Then
                If .biClrUsed < 1 Then
                    colorCount = 2 ^ .biBitCount
                Else
                    colorCount = .biClrUsed
                End If

                ' When using bitfields on 16 or 32 bits images, bmiColors has a 3-longs mask.
                If .biBitCount >= 16 And .biCompression = BI_BITFIELDS Then colorCount = 3

                Call CopyMemory(bmpInfo.bmiColors(0), rawData(54), colorCount * 4)
            End If
        End With

        ReDim data(bitmapSize - 1) As Byte
        Call CopyMemory(data(0), rawData(offBits), bitmapSize)

        Get_Bitmap = True
    End If
    'Else
    '    Call MsgBox("No se encontro el recurso " & FileName)
    'End If
End Function

Public Function Extract_File_Memory(ByVal file_type As resource_file_type, ByVal resource_path As String, ByVal File_Name As String, ByRef SourceData() As Byte) As Boolean
'******************************************************************************************
'Lorwik> Con este sub podemos descomprimir los graficos en la memoria en vez de en el disco
'******************************************************************************************

    Dim SourceFilePath As String
    Dim InfoHead As INFOHEADER
    Dim handle As Integer

    On Local Error GoTo errHandler

    Select Case file_type
    Case graphics
        SourceFilePath = resource_path & "\Graphics.TDSL"

    Case MP3
        SourceFilePath = resource_path & "\Musics.TDSL"

    Case WAV
        SourceFilePath = resource_path & "\Sounds.TDSL"

    Case Scripts
        SourceFilePath = resource_path & "\INITs.TDSL"

    Case gui
        SourceFilePath = resource_path & "\Interface.TDSL"

    Case Map
        SourceFilePath = resource_path & "\MapsTDS.TDSL"

    Case Else
        Exit Function
    End Select

    InfoHead = File_Find(SourceFilePath, File_Name)

    If InfoHead.strFileName = "" Or InfoHead.lngFileSize = 0 Then Exit Function

    handle = FreeFile
    Open SourceFilePath For Binary Access Read Lock Write As handle

    If InfoHead.lngFileSizeUncompressed > General_Drive_Get_Free_Bytes(Left$(App.Path, 3)) Then
        Close handle
        MsgBox "There is not enough drive space to extract the compressed file.", , "Error"
        Exit Function
    End If


    ReDim SourceData(InfoHead.lngFileSize - 1)

    Get handle, InfoHead.lngFileStart, SourceData
    Decompress_Data SourceData, InfoHead.lngFileSizeUncompressed
    Close handle

    Extract_File_Memory = True
    Exit Function

errHandler:
    Close handle
    Erase SourceData
End Function

Public Function File_Find(ByVal resource_file_path As String, ByVal File_Name As String, Optional ByVal PNG As Boolean = False) As INFOHEADER
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 5/04/2005
'Looks for a compressed file in a resource file. Uses binary search ;)
'**************************************************************
    On Error GoTo errHandler
    Dim max As Integer        'Max index
    Dim min As Integer        'Min index
    Dim mid As Integer        'Middle index
    Dim file_handler As Integer
    Dim file_head As FILEHEADER
    Dim info_head As INFOHEADER

    'Fill file name with spaces for compatibility
    If Len(File_Name) < Len(info_head.strFileName) Then _
       File_Name = File_Name & Space$(Len(info_head.strFileName) - Len(File_Name))

    'Open resource file
    file_handler = FreeFile
    Open resource_file_path For Binary Access Read Lock Write As file_handler

    'Get file head
    Get file_handler, 1, file_head

    min = 1
    max = file_head.intNumFiles

    Do While min <= max
        mid = (min + max) / 2

        'Get the info header of the appropiate compressed file
        Get file_handler, CLng(Len(file_head) + CLng(Len(info_head)) * CLng((mid - 1)) + 1), info_head


        If File_Name < info_head.strFileName Then
            If max = mid Then
                max = max - 1
            Else
                max = mid
            End If
        ElseIf File_Name > info_head.strFileName Then
            If min = mid Then
                min = min + 1
            Else
                min = mid
            End If
        Else
            'Copy info head
            File_Find = info_head

            'Close file and exit
            Close file_handler
            Exit Function
        End If
    Loop

errHandler:
    'Close file
    Close file_handler
    File_Find.strFileName = ""
    File_Find.lngFileSize = 0
End Function

Public Function General_Get_Temp_Dir() As String
'**************************************************************
'Author: Augusto José Rando
'Last Modify Date: 6/11/2005
'Gets windows temporary directory
'**************************************************************
    Dim s As String
    Dim c As Long
    s = Space$(MAX_LENGTH)
    c = GetTempPath(MAX_LENGTH, s)
    If c > 0 Then
        If c > Len(s) Then
            s = Space$(c + 1)
            c = GetTempPath(MAX_LENGTH, s)
        End If
    End If
    General_Get_Temp_Dir = IIf(c > 0, Left$(s, c), "")
End Function


Public Sub General_Quick_Sort(ByRef SortArray As Variant, ByVal First As Long, ByVal Last As Long)
'**************************************************************
'Author: juan Martín Sotuyo Dodero
'Last Modify Date: 3/03/2005
'Good old QuickSort algorithm :)
'**************************************************************
    Dim Low As Long, High As Long
    Dim Temp As Variant
    Dim List_Separator As Variant

    Low = First
    High = Last
    List_Separator = SortArray((First + Last) / 2)
    Do While (Low <= High)
        Do While SortArray(Low) < List_Separator
            Low = Low + 1
        Loop
        Do While SortArray(High) > List_Separator
            High = High - 1
        Loop
        If Low <= High Then
            Temp = SortArray(Low)
            SortArray(Low) = SortArray(High)
            SortArray(High) = Temp
            Low = Low + 1
            High = High - 1
        End If
    Loop
    If First < High Then General_Quick_Sort SortArray, First, High
    If Low < Last Then General_Quick_Sort SortArray, Low, Last
End Sub

Public Function General_Drive_Get_Free_Bytes(ByVal DriveName As String) As Currency
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 6/07/2004
'
'**************************************************************
    Dim RetVal As Long
    Dim FB As Currency
    Dim BT As Currency
    Dim FBT As Currency

    RetVal = GetDiskFreeSpace(Left(DriveName, 2), FB, BT, FBT)

    General_Drive_Get_Free_Bytes = FB * 10000        'convert result to actual size in bytes
End Function

Public Function Get_FileFrom(ByVal file_type As resource_file_type, ByVal File_Name As String) As String

    Extract_File file_type, App.Path & IIf(file_type = Map, "\Mapas\", "\GRAFICOS"), LCase$(File_Name), Windows_Temp_Dir, False
    Get_FileFrom = Windows_Temp_Dir & LCase$(File_Name)
End Function

Public Function General_Load_Picture_From_Resource(ByVal picture_file_name As String) As IPicture
    If Extract_File(gui, App.Path & "\GRAFICOS\", picture_file_name, Windows_Temp_Dir, False) Then
        Set General_Load_Picture_From_Resource = LoadPicture(Windows_Temp_Dir & picture_file_name)
        Call Delete_File(Windows_Temp_Dir & picture_file_name)
    Else
        Set General_Load_Picture_From_Resource = Nothing
    End If

    Exit Function

errorhandler:
    If FileExist(Windows_Temp_Dir & picture_file_name, vbNormal) Then
        Call Delete_File(Windows_Temp_Dir & picture_file_name)
    End If

End Function


