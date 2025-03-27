Attribute VB_Name = "mod_StringSampleEncryption"
Option Explicit

Const asci As Byte = 47

Public Function Encrypt(ByVal Cadena As String) As String
    Dim X As Long, tLen As Integer, newString As String
    tLen = Len(Cadena)
    For X = 1 To tLen
        newString = newString & Chr$(Asc(mid(Cadena, X, 1)) + asci)
    Next X
    Encrypt = newString
End Function

Public Function Decrypt(ByVal Cadena As String) As String
    Dim X As Long, tLen As Integer, newString As String
    tLen = Len(Cadena)
    For X = 1 To tLen
        newString = newString & Chr$(Asc(mid(Cadena, X, 1)) - asci)
    Next X
    Decrypt = newString
End Function
