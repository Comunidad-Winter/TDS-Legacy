Attribute VB_Name = "mod_ImgByteArray"
Option Explicit

Public Sub ByteArrayToFile(ByRef MatrizDeBytes() As Byte, Optional FormatoDeLaImagen As String)
    Dim Fichero As String
    Dim numFichero As Integer
    Dim NumCapturas As Integer
    Dim dirFile As String


    dirFile = "\FotoDenuncias"

    If Not FileExist(App.path & dirFile, vbDirectory) Then MkDir (App.path & dirFile)

    NumCapturas = Val(GetVar(App.path & "\FotoDenuncias\Capturas.ini", "INIT", "NumCapturas"))

    NumCapturas = NumCapturas + 1
    Fichero = App.path & "\FotoDenuncias\FotoDenuncia" & NumCapturas & ".bmp"
    numFichero = FreeFile

    Open Fichero For Output As #numFichero
    Print #numFichero, MatrizDeBytes()
    Close #numFichero
End Sub
Public Sub GuardarCapturas(ByRef MatrizDeBytes() As Byte, Optional ByVal FormatoDeImagen As String)

    Call ByteArrayToFile(MatrizDeBytes, FormatoDeImagen)

End Sub
