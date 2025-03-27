Attribute VB_Name = "ReproducirSonido"
Public Const SND_FILENAME = &H20000
Private Declare Function PlaySound Lib "winmm.dll" Alias "PlaySoundA" ( _
    ByVal lpszName As String, _
    ByVal hModule As Long, _
    ByVal dwFlags As Long) As Long
 
' Reproduce el archivo de sonido wav
Public Sub Reproducir_WAV(Archivo As String, Flags As Long)
    
    Dim ret As Long
    ' Le pasa el path y los flags al api
    ret = PlaySound(Archivo, ByVal 0&, Flags)
End Sub

Public Function ReadField(ByVal Pos As Integer, ByRef Text As String, ByVal SepASCII As Byte) As String
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
        ReadField = Mid$(Text, lastPos + 1, Len(Text) - lastPos)
    Else
        ReadField = Mid$(Text, lastPos + 1, CurrentPos - lastPos - 1)
    End If
End Function

Public Function FileExist(ByVal File As String, ByVal FileType As VbFileAttribute) As Boolean
    FileExist = (Dir$(File, FileType) <> "")
End Function
