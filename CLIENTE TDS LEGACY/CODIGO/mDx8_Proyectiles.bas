Attribute VB_Name = "mDx8_Proyectiles"
Option Explicit

Public Type Projectile
    X As Single
    Y As Single
    tX As Single
    tY As Single
    RotateSpeed As Byte
    Rotate As Single
    Grh As Grh
End Type

Public ProjectileList() As Projectile
Public LastProjectile As Integer

Public Sub RenderProjectile(ByVal AttackerIndex As Integer, ByVal TargetIndex As Integer, ByVal GrhIndex As Long, ByVal Rotation As Byte)
'**************************************************************
'Author: Dunkan
'Last Modify Date: 17/06/2012
'Render Projectile User -> Victim
'**************************************************************
    Dim ProjectileIndex As Integer

    If AttackerIndex = 0 Then Exit Sub
    If TargetIndex = 0 Then Exit Sub
    If AttackerIndex > UBound(charlist) Then Exit Sub
    If TargetIndex > UBound(charlist) Then Exit Sub

    'Get the next open projectile slot
    Do
        ProjectileIndex = ProjectileIndex + 1

        'Update LastProjectile if we go over the size of the current array
        If ProjectileIndex > LastProjectile Then
            LastProjectile = ProjectileIndex
            ReDim Preserve ProjectileList(1 To LastProjectile)
            Exit Do
        End If

    Loop While ProjectileList(ProjectileIndex).Grh.GrhIndex > 0

    'Figure out the initial rotation value
    ProjectileList(ProjectileIndex).Rotate = Engine_GetAngle(charlist(AttackerIndex).Pos.X, charlist(AttackerIndex).Pos.Y, charlist(TargetIndex).Pos.X, charlist(TargetIndex).Pos.Y)

    'Fill in the values
    ProjectileList(ProjectileIndex).tX = charlist(TargetIndex).Pos.X * 32
    ProjectileList(ProjectileIndex).tY = charlist(TargetIndex).Pos.Y * 32
    ProjectileList(ProjectileIndex).RotateSpeed = 0
    ProjectileList(ProjectileIndex).X = (charlist(AttackerIndex).Pos.X) * 32
    ProjectileList(ProjectileIndex).Y = (charlist(AttackerIndex).Pos.Y) * 32 - 10

    ' FIXEAR CUANDO EL USUARIO SE MUEVE SE RECALCULA PARA EL ORTO

    InitGrh ProjectileList(ProjectileIndex).Grh, GrhIndex

End Sub

Public Sub EraseProjectile(ByVal ProjectileIndex As Integer)
'**************************************************************
'Author: Dunkan
'Last Modify Date: 17/06/2012
'Clear projectile screen.
'**************************************************************

'Clear the selected index
    ProjectileList(ProjectileIndex).Grh.FrameCounter = 0
    ProjectileList(ProjectileIndex).Grh.GrhIndex = 0
    ProjectileList(ProjectileIndex).X = 0
    ProjectileList(ProjectileIndex).Y = 0
    ProjectileList(ProjectileIndex).tX = 0
    ProjectileList(ProjectileIndex).tY = 0
    ProjectileList(ProjectileIndex).Rotate = 0
    ProjectileList(ProjectileIndex).RotateSpeed = 0

    'Update LastProjectile
    If ProjectileIndex = LastProjectile Then
        Do Until ProjectileList(ProjectileIndex).Grh.GrhIndex > 1
            'Move down one projectile
            LastProjectile = LastProjectile - 1
            If LastProjectile = 0 Then Exit Do
        Loop
        If ProjectileIndex <> LastProjectile Then
            'We still have projectiles, resize the array to end at the last used slot
            If LastProjectile > 0 Then
                ReDim Preserve ProjectileList(1 To LastProjectile)
            Else
                Erase ProjectileList
            End If
        End If
    End If

End Sub
