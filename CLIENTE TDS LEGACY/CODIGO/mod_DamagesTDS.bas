Attribute VB_Name = "mod_RenderDamages"
Option Explicit
Public Type structDamage
    Pos As Position
    Value As String
    Counter As Long
    Width As Integer
    r As Byte
    g As Byte
    b As Byte
End Type
Public DamageList() As structDamage
Public LastDamage As Integer
Public Sub RenderFontMap(ByVal X As Integer, ByVal Y As Integer, ByVal Value As Integer, ByVal r As Byte, ByVal g As Byte, ByVal b As Byte)
    Dim DamageIndex As Integer
    Do
        DamageIndex = DamageIndex + 1
        If DamageIndex > LastDamage Then
            LastDamage = DamageIndex
            ReDim Preserve DamageList(1 To LastDamage)
            Exit Do
        End If
    Loop While DamageList(DamageIndex).Counter > 0
    DamageList(DamageIndex).Value = Value
    DamageList(DamageIndex).Counter = 2000
    DamageList(DamageIndex).Width = Engine_GetTextWidth(cfonts(1), CStr(DamageList(DamageIndex).Value))
    DamageList(DamageIndex).Pos.X = X
    DamageList(DamageIndex).Pos.Y = Y
    DamageList(DamageIndex).r = r
    DamageList(DamageIndex).g = g
    DamageList(DamageIndex).b = b
End Sub
Public Sub EraseDamage(ByVal DamageIndex As Integer)
    DamageList(DamageIndex).Counter = 0
    DamageList(DamageIndex).Value = vbNullString
    DamageList(DamageIndex).Width = 0
    If DamageIndex = LastDamage Then
        Do Until DamageList(LastDamage).Counter > 0
            LastDamage = LastDamage - 1
            If LastDamage = 0 Then
                Erase DamageList
                Exit Sub
            Else
                ReDim Preserve DamageList(1 To LastDamage)    'We still have damage text, resize the array to end at the last used slot
            End If
        Loop
    End If
End Sub


