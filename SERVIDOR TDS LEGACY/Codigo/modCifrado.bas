Attribute VB_Name = "modCifrado"
Option Explicit

'//For Action parameter in EncryptString
Const ENCRYPT = 1
Const DECRYPT = 2

'---------------------------------------------------------------------
' EncryptString
' Modificado por Harvey T.
'---------------------------------------------------------------------

Public Function EncryptString( _
       UserKey As String, Text As String, Action As Single _
                                        ) As String
    Dim temp As Integer
    Dim i As Integer
    Dim j As Integer
    Dim N As Integer
    Dim rtn As String

    '//Get UserKey characters
    N = Len(UserKey)
    ReDim UserKeyASCIIS(1 To N)
    For i = 1 To N
        UserKeyASCIIS(i) = Asc(mid$(UserKey, i, 1))
    Next

    '//Get Text characters
    ReDim TextASCIIS(Len(Text)) As Integer
    For i = 1 To Len(Text)
        TextASCIIS(i) = Asc(mid$(Text, i, 1))
    Next

    '//Encryption/Decryption
    If Action = ENCRYPT Then
        For i = 1 To Len(Text)
            j = IIf(j + 1 >= N, 1, j + 1)
            temp = TextASCIIS(i) + UserKeyASCIIS(j)
            If temp > 255 Then
                temp = temp - 255
            End If
            rtn = rtn + Chr$(temp)
        Next
    ElseIf Action = DECRYPT Then
        For i = 1 To Len(Text)
            j = IIf(j + 1 >= N, 1, j + 1)
            temp = TextASCIIS(i) - UserKeyASCIIS(j)
            If temp < 0 Then
                temp = temp + 255
            End If
            rtn = rtn + Chr$(temp)
        Next
    End If

    '//Return
    EncryptString = rtn
End Function

