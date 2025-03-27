VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGraphInv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False


Option Explicit

Private InventoryOffset As Long        'Number of lines we scrolled down from topmost
Private InvSelectedItem As Long        'Currently selected item

Private ownTilePixelWidth As Integer
Private ownTilePixelHeight As Integer
Private startdX As Integer
Private startdY As Integer

Private OrigSize As Single

Private ShowValue As Boolean
Private ImgContainer As Boolean

Private LastSelectedItem As Long
Private InventoryRect As D3DRECT
Private InventoryHwnd As Long

'Private InvSurface As DirectD3DSurface7            'DD Surface used to render everything

Private Inventory() As Inventory        'User's inventory

Private Initialized As Boolean

Private WithEvents InventoryWindow As PictureBox        'Placeholder where to render the inventory
Attribute InventoryWindow.VB_VarHelpID = -1


Private Sub Class_Initialize()
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'
'***************************************************
End Sub

Private Sub Class_Terminate()
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'
'***************************************************
End Sub

Public Sub ScrollInventory(ByVal Up As Boolean)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 14/01/2010
'Scrolls the graphical inventory up / down
'14/01/2010: ZaMa - Now redraws inventory only if needed
'***************************************************

'Only move if there is something to show up /down
    If CanScroll(Up) Then
        InventoryOffset = InventoryOffset + IIf(Up, 1, -1)

        'Redraw the inventory if needed

    End If

End Sub

Public Function CanScroll(ByVal Up As Boolean)
'***************************************************
'Author: ZaMa
'Last Modify Date: 14/01/2010
'Determines wether inventory can be scrolled up / down
'***************************************************
    If Up Then
        CanScroll = (InventoryOffset + (InventoryWindow.ScaleHeight \ ownTilePixelHeight)) * _
                    (InventoryWindow.ScaleWidth \ ownTilePixelWidth) < UBound(Inventory)
    Else
        CanScroll = InventoryOffset > 0
    End If

End Function

Public Property Get MaxItems()
    MaxItems = UBound(Inventory)

End Property


Public Sub SelectGold()
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Sets the gold as the currently selected item
'***************************************************
    Dim prevSelectedItem As Long

    'Store preivously selected item
    prevSelectedItem = InvSelectedItem

    'Select the gold
    InvSelectedItem = FLAGORO

    'Redraw old item to deselect it
    If prevSelectedItem <> FLAGORO Then

    End If
End Sub

Public Sub DeselectItem()
'***************************************************
'Author: ZaMa
'Last Modify Date: 30/11/2009
'Deselect the currently selected item
'***************************************************
    If InvSelectedItem = 0 Then Exit Sub

    Dim ClearSlot As Byte

    ClearSlot = InvSelectedItem

    'Select nothing
    InvSelectedItem = 0

    'Redraw old item to deselect it

End Sub

Public Sub ChangeSlotItemAmount(ByVal Slot As Byte, ByVal amount As Long)
'***************************************************
'Author: ZaMa
'Created Date: 30/11/2009
'Last Modify Date: 09/12/2009 (Budi)
'Change the amount of the required item, and update the slot.
'***************************************************

    Inventory(Slot).amount = amount

    'Update Amount

End Sub




Public Property Get SelectedItem() As Long

'SelectedItem = InvSelectedItem


' @@ DevelopedAO Extraction
    SelectedItem = InvSelectedItem
    If SelectedItem < 1 Then Exit Sub

    If InventoryHwnd <> InventoryMainHwnd Then Exit Sub
    If eVentanas.vInventario <> LastPanel Then Exit Sub

    If SelectedItem <> FLAGORO Then
        If SelectedItem <> LastSelectedItem Then
            If Inventory(SelectedItem).ObjIndex > 0 Then
                'frmMain.LblObjeto.Caption = Inventory(SelectedItem).Name
            Else
                'frmMain.LblObjeto.Caption = "(Vacio)"
            End If

            LastSelectedItem = SelectedItem
        End If
    End If
End Property

Public Property Get MaxHit(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the max hit of the selected item
'***************************************************
    If Slot <= 0 Then Exit Sub
    MaxHit = Inventory(Slot).MaxHit
End Property

Public Property Get MinHit(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the min hit of the selected item
'***************************************************
    If Slot <= 0 Then Exit Sub
    MinHit = Inventory(Slot).MinHit
End Property

Public Property Get MaxDef(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the defense of the selected item
'***************************************************
    If Slot <= 0 Then Exit Sub
    MaxDef = Inventory(Slot).MaxDef
End Property

Public Property Get MinDef(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Budi
'Last Modify Date: 02/1209
'Retrieves the defense of the selected item
'***************************************************
    If Slot <= 0 Then Exit Sub
    MinDef = Inventory(Slot).MinDef
End Property

Public Property Get GrhIndex(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the grh index of the selected item
'***************************************************
    GrhIndex = Inventory(Slot).GrhIndex
End Property

Public Property Get Valor(ByVal Slot As Byte) As Single
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the value of the selected item
'***************************************************
    Valor = Inventory(Slot).Valor
End Property

Public Property Get amount(ByVal Slot As Byte) As Long
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the selected item's amount
'***************************************************
    If Slot = FLAGORO Then
        amount = UserGLD
    ElseIf Slot >= LBound(Inventory) And Slot <= UBound(Inventory) Then
        amount = Inventory(Slot).amount
    End If
End Property

Public Property Get ObjIndex(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the selected item's object index
'***************************************************
    ObjIndex = Inventory(Slot).ObjIndex
End Property

Public Property Get ObjType(ByVal Slot As Byte) As Integer
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the selected item's object type
'***************************************************

    ObjType = Inventory(Slot).ObjType
End Property

Public Property Get ItemName(ByVal Slot As Byte) As String
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves the selected item's name
'***************************************************
    If Slot <= 0 Then Exit Sub
    ItemName = Inventory(Slot).Name
End Property

Public Property Get MinDefMagic(ByVal Slot As Byte) As Integer
    If Slot <= 0 Then Exit Property
    MinDefMagic = Inventory(Slot).MinDefMagic
End Property

Public Property Get MaxDefMagic(ByVal Slot As Byte) As Integer
    If Slot <= 0 Then Exit Property
    MaxDefMagic = Inventory(Slot).MaxDefMagic
End Property

Public Property Get Equipped(ByVal Slot As Byte) As Boolean
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Retrieves True if the item at the given pos is eqiupped
'***************************************************
    Equipped = Inventory(Slot).Equipped
End Property

Public Property Get MaxObjs() As Byte
'***************************************************
'Author: Torres Patricio (Pato)
'Last Modify Date: 09/16/09
'Retrieves the capacity of the Inventory
'***************************************************
    MaxObjs = UBound(Inventory)
End Property

Public Sub SetMaxObjs(ByVal MaxObjs As Byte)
'***************************************************
'Author: Torres Patricio (Pato)
'Last Modify Date: 09/16/09
'Set the capacity of the Inventary
'***************************************************
    If UBound(Inventory) = MaxObjs Then Exit Sub

    ReDim Preserve Inventory(1 To MaxObjs) As Inventory
End Sub

Public Sub ToggleShowValue(ByVal bShow As Boolean)
'***************************************************
'Author: ZaMa
'Last Modify Date: 11/12
'Indicates if the amount of the items in the inventory is shown
'***************************************************
    ShowValue = bShow

    Dim Slot As Integer
    ' Update Inventory
    For Slot = 1 To Me.MaxObjs

    Next Slot
End Sub

Public Sub SetItem(ByVal Slot As Byte, ByVal eOBJIndex As Integer, ByVal eAmount As Long, ByVal eEquipped As Byte, _
                   ByVal eGrhIndex As Integer, ByVal eObjType As Integer, ByVal eMaxHit As Integer, ByVal eMinHit As Integer, _
                   ByVal MaxDef As Integer, ByVal MinDef As Integer, ByVal eValor As Single, ByVal eName As String)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 12/04/06
'Sets all data for a given inventory slot
'***************************************************
    If Slot < 1 Or Slot > UBound(Inventory) Then Exit Sub

    On Error Resume Next


    With Inventory(Slot)
        .amount = eAmount
        .MaxDef = MaxDef
        .MinDef = MinDef
        .Equipped = eEquipped
        .GrhIndex = eGrhIndex
        .MaxHit = eMaxHit
        .MinHit = eMinHit
        .Name = eName
        .ObjIndex = eOBJIndex
        .ObjType = eObjType
        .Valor = eValor
        If eOBJIndex Then
            .MinDefMagic = DataObj(eOBJIndex).MinDefMagic
            .MaxDefMagic = DataObj(eOBJIndex).MaxDefMagic
        Else
            .MinDefMagic = 0
            .MaxDefMagic = 0
        End If

    End With

    'If InventoryWindow.Visible = False Then InventoryWindow.Visible = True

    'Render inventory slot (we don't need to render the whole inventory)

End Sub

Public Function ClickItem(ByVal X As Long, ByVal Y As Long) As Long
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Selects the item clicked if it's valid and return's it's index
'***************************************************
    Dim TempItem As Long
    Dim temp_x As Long
    Dim temp_y As Long

    temp_x = X \ TilePixelWidth
    temp_y = Y \ TilePixelHeight

    TempItem = temp_x + (temp_y + InventoryOffset) * (InventoryWindow.ScaleWidth \ TilePixelWidth) + 1
    If TempItem < 0 Then TempItem = 0

    'Make sure it's within limits
    If TempItem <= UBound(Inventory) Then
        'Make sure slot isn't empty
        'If Inventory(TempItem).GrhIndex Then
        ClickItem = TempItem
        'Else
        'ClickItem = 0
        'End If
    End If

    'Make sure it's within limits
    If TempItem <= MAX_INVENTORY_SLOTS Then
        ClickItem = TempItem
    End If
End Function

Private Sub DrawInventory(Optional ByVal StepValid As Byte = 0)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Renders the inventory to the given PictureBox
'***************************************************

    If StepValid < 1 Then
        If InventoryHwnd = InventoryMainHwnd Then
            If eVentanas.vInventario <> LastPanel Then Exit Sub
        End If
    End If

    Dim LoopC As Long
    Dim SrcRect As RECT
    Dim destRect As RECT

    With destRect
        .Bottom = InventoryWindow.Height
        .Right = InventoryWindow.Width
    End With

    Dim lvalue(3) As Long

    lvalue(0) = -1
    lvalue(1) = lvalue(0)
    lvalue(2) = lvalue(0)
    lvalue(3) = lvalue(0)

    Call Engine_BeginScene

    For LoopC = InventoryOffset * (InventoryWindow.ScaleWidth \ ownTilePixelWidth) + 1 To UBound(Inventory)

        startdX = ((LoopC - 1) Mod (InventoryWindow.Width / 32)) * 32
        startdY = ((LoopC - 1) \ (InventoryWindow.Width / 32)) * 32

        If Inventory(LoopC).GrhIndex Then

            'Get source rect|
            With SrcRect
                .Left = GrhData(Inventory(LoopC).GrhIndex).sX
                .Top = GrhData(Inventory(LoopC).GrhIndex).sY
                .Right = .Left + ownTilePixelWidth
                .Bottom = .Top + ownTilePixelHeight

                Call Directx_Render_Texture(GrhData(Inventory(LoopC).GrhIndex).FileNum, startdX, startdY, .Right, .Bottom, .Left, .Top, lvalue)
            End With

            'Render a box around the selected item
            If InvSelectedItem = LoopC Then
                If ImgContainer Then
                    With SrcRect
                        Call Directx_Render_Texture(9995, startdX, startdY, .Right, .Bottom, .Left, .Top, lvalue)
                    End With
                End If
            End If

            'If equipped we render "+"
            If Inventory(LoopC).Equipped Then
                drawText startdX + 20, startdY + 20, "+", -256, , , 0
            End If

            'Render the item grh and the amount
            If Inventory(LoopC).amount = 10000 Then

                drawText startdX, startdY, Inventory(LoopC).amount, lvalue(0), , , 0
            Else
                drawText startdX + 2, startdY, Inventory(LoopC).amount, lvalue(0), , , 0
            End If


        End If
    Next LoopC

    Call Engine_EndScene(destRect, InventoryWindow.hwnd)

End Sub

Public Sub UpdateAllSlots()

    If UserClase > 0 Then

        'Dim Slot As Long
        'For Slot = 1 To InventorySize
        '    Call CheckEquipabledObj(Slot)
        'Next Slot

        Call DrawInventory(1)

    End If

End Sub

Public Sub DrawInv()
    DrawInventory
End Sub


Public Sub Initialize(ByRef DirectD3D As D3DX8, ByRef InvPic As PictureBox, ByVal MaxObjs As Byte, _
                      Optional ByVal FontSize As Integer = 7, Optional ByVal TileWidth As Integer = 32, _
                      Optional ByVal TileHeight As Integer = 32, Optional ByVal StartX As Integer = 0, _
                      Optional ByVal StartY As Integer = 0, Optional ByVal bImgContainer As Boolean = True, _
                      Optional ByVal bShowText As Boolean = True)

'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 03/12/09
'Sets the reference to the picture box on which to render the inventory
'03/12/09: I added the optionals args FontSize, TileWidth, TileHeight, startX and startY. (Budi)
'***************************************************
    Set InventoryWindow = InvPic

    'Make sure auto-redraw is set to true
    InventoryWindow.AutoRedraw = True

    'Set apropiate scale (pixel)
    InventoryWindow.ScaleMode = 3

    ReDim Inventory(1 To MaxObjs) As Inventory

    'initialize DX stuff
    'Dim SurfaceDesc As DDSURFACEDESC2

    'Make sure DirectD3D was correctly initialized
    If DirectD3D Is Nothing Then Exit Sub

    ownTilePixelHeight = TileHeight
    ownTilePixelWidth = TileWidth
    startdX = StartX
    startdY = StartY

    ImgContainer = bImgContainer
    ShowValue = bShowText

    'TODO : Fonts should be in a separate class / collection
    Dim Font As New StdFont
    Dim Ifnt As IFont

    Font.Name = "Verdana"
    Font.bold = True
    Font.italic = False
    Font.Size = FontSize
    Font.Underline = False
    Font.Strikethrough = False
    OrigSize = FontSize

    Set Ifnt = Font

    '\TODO

    If ImgContainer Then _
       InvSelectedItem = ClickItem(1, 1)        'If there is anything there we select the top left item
    Initialized = True

End Sub

Private Sub InventoryWindow_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Implements the mouse move event of the inventory picture box
'Displays a ToolTip of the item under the mouse
'***************************************************
    Dim temp_x As Integer
    Dim temp_y As Integer
    Dim TempItem As Integer

    'Exit if it got outside the control's area
    If X < 0 Or Y < 0 Or X > InventoryWindow.Width Or Y > InventoryWindow.Height Then _
       Exit Sub

    temp_x = X \ ownTilePixelWidth
    temp_y = Y \ ownTilePixelHeight

    TempItem = temp_x + (temp_y + InventoryOffset) * (InventoryWindow.ScaleWidth \ ownTilePixelWidth) + 1

    If TempItem <= UBound(Inventory) Then
        InventoryWindow.ToolTipText = Inventory(TempItem).Name
    End If
End Sub

Public Function isInitialized() As Boolean
    isInitialized = Initialized
End Function

Private Sub InventoryWindow_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 27/07/04
'Implements the mouse up event of the inventory picture box
'Check outs which item was clicked
'***************************************************
'Store previously selected item
    Dim prevSelItem As Long

    'Exit if it got outside the control's area
    If X < 0 Or Y < 0 Or X > InventoryWindow.Width Or Y > InventoryWindow.Height Then _
       Exit Sub

    prevSelItem = InvSelectedItem

    'Get the currently clickced item
    InvSelectedItem = ClickItem(CInt(X), CInt(Y))

    'Update needed inventory slots
    If prevSelItem <> InvSelectedItem Then
        'If prevSelItem <> 0 And prevSelItem <> FLAGORO Or InvSelectedItem Then Call DrawInventory
    End If

End Sub
