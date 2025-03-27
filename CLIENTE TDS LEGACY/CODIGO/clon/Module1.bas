Attribute VB_Name = "mod_CharManagement"
Option Explicit

Public Function Char_Check(ByVal CharIndex As Integer) As Boolean
    If CharIndex > 0 Then
        If CharIndex <= LastChar Then
            Char_Check = charlist(CharIndex).Active
        End If
    End If
End Function

Public Sub Char_SetBody(ByVal CharIndex As Integer, ByVal BodyIndex As Integer)
    If BodyIndex < LBound(BodyData()) Or BodyIndex > UBound(BodyData()) Then
        charlist(CharIndex).Body = BodyData(0)
        charlist(CharIndex).iBody = 0
        Exit Sub
    End If
    If Char_Check(CharIndex) Then
        If UserCharIndex = CharIndex Then
            charlist(CharIndex).Body = BodyData(BodyIndex)
        End If
        With charlist(CharIndex)
            .Body = BodyData(BodyIndex)
            .iBody = BodyIndex
            Exit Sub
        End With
    End If
End Sub


Public Sub Char_ChangeHeading(ByVal Heading As Byte)

    If Char_Check(UserCharIndex) Then
        If charlist(UserCharIndex).Heading <> Heading Then
            charlist(UserCharIndex).Heading = Heading
            Call WriteChangeHeading(Heading)
        End If
    End If

End Sub
Public Sub Convert_Heading_to_Direction(ByVal Heading As E_Heading, _
                                        ByRef direction_x As Integer, _
                                        ByRef direction_y As Integer)

    Dim addY As Integer
    Dim addX As Integer

    'Figure out which way to move
    Select Case Heading

    Case E_Heading.NORTH
        addY = -1

    Case E_Heading.EAST
        addX = 1

    Case E_Heading.SOUTH
        addY = 1

    Case E_Heading.WEST
        addX = -1

    End Select

    direction_x = direction_x + addX
    direction_y = direction_y + addY

End Sub



Public Function Char_Find(ByVal ID As Integer) As Integer

    On Error GoTo errorhandler:

    If ID < 1 Or LastChar < 1 Then Exit Function

    Char_Find = charlist(ID).ID

    Exit Function

errorhandler:

End Function

Public Sub Char_SetHead(ByVal CharIndex As Integer, ByVal HeadIndex As Integer)
    If HeadIndex < LBound(HeadData()) Or HeadIndex > UBound(HeadData()) Then
        charlist(CharIndex).Head = HeadData(0)
        charlist(CharIndex).iHead = 0
        Exit Sub
    End If
    If Char_Check(CharIndex) Then
        With charlist(CharIndex)
            .Head = HeadData(HeadIndex)
            .iHead = HeadIndex
            If HeadIndex > 499 And HeadIndex < 502 Then
                .muerto = 1
            Else
                .muerto = 0
            End If
        End With
    End If
End Sub

Public Sub Char_SetHeading(ByVal CharIndex As Integer, ByVal Heading As Byte)
    If Char_Check(CharIndex) Then
        'If charlist(CharIndex).Heading <> Heading Then
        charlist(CharIndex).Heading = Heading
        'End If
    End If
End Sub

Public Sub Char_SetWeapon(ByVal CharIndex As Integer, ByVal WeaponIndex As Integer)
    If WeaponIndex > UBound(WeaponAnimData()) Or WeaponIndex < LBound(WeaponAnimData()) Then Exit Sub
    If Char_Check(CharIndex) Then
        charlist(CharIndex).Arma = WeaponAnimData(WeaponIndex)
    End If
End Sub

Public Sub Char_SetShield(ByVal CharIndex As Integer, ByVal ShieldIndex As Integer)

    If ShieldIndex > UBound(ShieldAnimData()) Or ShieldIndex < LBound(ShieldAnimData()) Then
        Exit Sub
    End If

    If Char_Check(CharIndex) Then
        charlist(CharIndex).Escudo = ShieldAnimData(ShieldIndex)
    End If

End Sub

Public Sub Char_SetSpecial(ByVal CharIndex As Integer, ByVal Special As Byte)

    If Char_Check(CharIndex) Then
        Select Case Special
        Case 1
            'charlist(CharIndex).Pelota = 1
        Case 2
            'charlist(CharIndex).BanderaGrh = 15891
            'charlist(CharIndex).BanderaType = 1
        Case 3
            'charlist(CharIndex).BanderaGrh = 15889
            'charlist(CharIndex).BanderaType = 1
        Case Else
            'charlist(CharIndex).Pelota = 0
            'charlist(CharIndex).BanderaGrh = 0
            'charlist(CharIndex).BanderaType = 0
        End Select
    End If

End Sub

Public Sub Char_SetCasco(ByVal CharIndex As Integer, ByVal CascoIndex As Integer)

    If CascoIndex > UBound(CascoAnimData()) Or CascoIndex < LBound(CascoAnimData()) Then
        Exit Sub
    End If

    If Char_Check(CharIndex) Then
        charlist(CharIndex).Casco = CascoAnimData(CascoIndex)
    End If

End Sub

Public Sub Char_SetFx(ByVal CharIndex As Integer, _
                      ByVal fX As Integer, _
                      ByVal Loops As Integer)

    If fX < 0 Then Exit Sub

    If Char_Check(CharIndex) Then

        With charlist(CharIndex)
            .FxIndex = fX

            If .FxIndex > 0 Then
                Call InitGrh(.fX, FxData(fX).Animacion)
                .fX.Loops = Loops
            End If
        End With
    End If

End Sub

Public Sub Char_SetTmp(ByVal CharIndex As Integer, ByVal TmpIndex As Byte)

    If Char_Check(CharIndex) Then
        'charlist(CharIndex).BanderaType = TmpIndex
    End If

End Sub


