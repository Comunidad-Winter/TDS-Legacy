Attribute VB_Name = "m_DragAndDrop"
Option Explicit
Public CANTDRAG As Integer

Public DragX As Byte
Public DragY As Byte

Public Sub General_Drop_X_Y()
    On Error GoTo Err
    If (Inventario.SelectedItem > 0 And Inventario.SelectedItem <= Inventario.MaxObjs) Then
        If MapData(DragX, DragY).Blocked = 1 And MapData(DragX, DragY).CharIndex <= 0 Then
            Call ShowConsoleMsg("Elige una posición válida para tirar tus objetos.")
            Exit Sub
        End If
        If HayAgua(DragX, DragY) = True Then
            Call ShowConsoleMsg("No está permitido tirar objetos en el agua.")
            Exit Sub
        End If
        If MapData(DragX, DragY).CharIndex <> 0 And DragToUser Then
            Call ShowConsoleMsg("Debes desactivar el seguro de transferencia de items(Click en la manito debajo del inventario)")
            Exit Sub
        End If
        If GetKeyState(vbKeyShift) < 0 Then
            frmCantidad.IsDrop = True
            frmCantidad.Show vbModal, frmMain
            If CANTDRAG <= 0 Then Exit Sub

            If Inventario.ObjType(Inventario.SelectedItem) = eObjType.otBarcos And Not AccionYesOrNo = 3 Then
                AccionYesOrNo = 3

                frmYesOrNo.Show , frmMain
                Exit Sub
            End If

            Call WriteDragToPos(DragX, DragY, Inventario.SelectedItem, CANTDRAG)
        Else
            If Inventario.ObjType(Inventario.SelectedItem) = eObjType.otBarcos And Not AccionYesOrNo = 3 Then
                AccionYesOrNo = 3
                CANTDRAG = 1
                frmYesOrNo.Show , frmMain
                Exit Sub
            End If
            Call WriteDragToPos(DragX, DragY, Inventario.SelectedItem, 1)
        End If
    End If
Err:
End Sub



