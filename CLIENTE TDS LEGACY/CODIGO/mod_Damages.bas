Attribute VB_Name = "mod_Damages"
Option Explicit

Type tDamage
    Label As String
    Alpha As Byte
    r As Byte
    g As Byte
    b As Byte
    Using As Boolean
    Wait As Byte
    OffSetY As Integer
    d3dColor As Long
End Type

'Public Damages(250) As tDamage

Public Sub CreateDamage(ByVal Label As String, r As Byte, g As Byte, b As Byte, tX As Byte, tY As Byte)
    Dim nDmg As Byte
    nDmg = NewDamageIndex(tX, tY)
    If nDmg = 9 Then Exit Sub

    MapData(tX, tY).Damage(nDmg).Label = Abs(Label)
    MapData(tX, tY).Damage(nDmg).r = r
    MapData(tX, tY).Damage(nDmg).g = g
    MapData(tX, tY).Damage(nDmg).b = b
    MapData(tX, tY).Damage(nDmg).Alpha = 255
    MapData(tX, tY).Damage(nDmg).Using = True
    MapData(tX, tY).Damage(nDmg).Wait = 5
    MapData(tX, tY).Damage(nDmg).OffSetY = 0
    MapData(tX, tY).Damage(nDmg).d3dColor = D3DColorXRGB(MapData(tX, tY).Damage(nDmg).r, MapData(tX, tY).Damage(nDmg).g, MapData(tX, tY).Damage(nDmg).b)

End Sub

Public Sub DeleteDamages()

    Dim j As Long
    Dim k As Long
    Dim LoopC As Long
    Dim tmpDmg As Long

    If frmMain.Visible Then
        If UserCharIndex > 0 Then
            For j = UserPos.X - 9 To UserPos.X + 9
                For k = UserPos.Y - 7 To UserPos.Y + 7
                    If InMapBounds(j, k) Then
                        For tmpDmg = 0 To 8
                            MapData(j, k).Damage(tmpDmg).Using = False    '""cleaning
                        Next tmpDmg
                    End If
                Next k
            Next j
        End If
    End If

End Sub

Private Function NewDamageIndex(ByVal tX As Byte, ByVal tY As Byte) As Byte
    Dim X As Long
    For X = 0 To 8
        If MapData(tX, tY).Damage(X).Using = False Then
            NewDamageIndex = X
            Exit Function
        End If
    Next X
    NewDamageIndex = 9
End Function

