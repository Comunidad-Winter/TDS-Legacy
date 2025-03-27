Attribute VB_Name = "mod_Gui"
Option Explicit

Private Declare Function CallWindowProc Lib "user32.dll" Alias "CallWindowProcA" ( _
                                        ByVal lpPrevWndFunc As Long, _
                                        ByVal hwnd As Long, _
                                        ByVal msg As Long, _
                                        ByVal wParam As Long, _
                                        ByVal lParam As Long) As Long

Const GWL_EXSTYLE = (-20)
Const WS_EX_TRANSPARENT = &H20&

Public GuiColor As Long
Public GuiColor1 As Long
Public TitilaCounter As Long
Public Titila As Boolean
Public FpsCounter As Integer
Public LastFpsCount As Long
Public FpsShow As Integer

Type tGuiObject
    ID As Byte
    StartX As Integer
    StartY As Integer
    EndX As Integer
    EndY As Integer
    tipo As eGuiType
    Texto As String
    ActualColor As Byte
    Evento As Long
    CallEventWithEnter As Boolean
    HasFocus As Boolean
    IsPassWd As Boolean
    MaxLenght As Byte
    Width As Integer
    TieneBarrita As Boolean
    PassTmp As String
    Centered As Boolean
    Sombreado As Boolean
    SetFocusOn As Byte
End Type

Enum eGuiType
    Cmd = 1
    TxtBox = 2
    Label = 3
End Enum

Enum eGuiMode
    nada = 1
    Over = 2
    MouseDown = 3
End Enum

Public GuiTxt() As tGuiObject
Public GuiTexto(30) As tGuiObject

Public MaxGuiObj As Byte

Public Const TxtBox_H As Integer = 22
Public loopGui As Long
Public Const PassWord_GuiIndex As Byte = 2
Public Const Nombre_GuiIndex As Byte = 1

Private Type tGUIInMemory
    data() As Byte
    dLen As Long
    ID As String
End Type

Private GUIInMemory() As tGUIInMemory
Private GUIInMemory_Cant As Byte

Public Sub InitGui()
    MaxGuiObj = 7
    Dim I As Long

    ReDim GuiTxt(1 To MaxGuiObj)

    ' @@ Crear PJ
    InitializeTxtBox GuiTxt(3), 3, 284, 360, 245, False, , True, , "", False
    InitializeTxtBox GuiTxt(4), 4, 284, 360, 281, False, 40, False, True, "", False
    InitializeTxtBox GuiTxt(5), 5, 284, 360, 317, True, , False, True, "", False
    InitializeTxtBox GuiTxt(6), 6, 284, 360, 353, True, , False, True, "", False
    InitializeTxtBox GuiTxt(7), 7, 284, 360, 387, True, , False, True, "", False

    For I = 1 To NUMATRIBUTOS
        InitializeLabel "18", GuiTexto(I), 562, 21 + (23 * I), False, False
    Next I

    For I = 1 To 22    'frmCrearPersonaje.Skill().Count
        InitializeLabel "0", GuiTexto(5 + I), frmCrearPersonaje.Skill(I).Left, frmCrearPersonaje.Skill(I).Top, False, False
    Next I

    'skills libres
    InitializeLabel "Skills disponibles: 10", GuiTexto(28), frmCrearPersonaje.Puntos.Left, frmCrearPersonaje.Puntos.Top, False, False
    ' @@ Crear PJ

    InitializeLabel "Atención! Ten cuidado, estás con las mayúsculas activadas!!", GuiTexto(30), frmCrearPersonaje.Puntos.Left, frmCrearPersonaje.Puntos.Top, False, False

End Sub

Public Function forms_load_pic(Optional ByVal what As Variant = Nothing, Optional ByVal file_id As String = "", Optional ByVal ISPNG As Boolean = False) As Variant
    On Error GoTo errHandler

    Dim handle As Integer
    Dim dData() As Byte
    Dim dLen As Long
    Dim I As Long
    Dim dirGUI As String
    Dim Num As Long
    Dim Iter1 As Long
    Dim totit As Long
1   If GUIInMemory_Cant = 0 Then
        ReDim GUIInMemory(1 To 1) As tGUIInMemory
        GUIInMemory_Cant = 1
        dirGUI = Get_FileFrom(resource_file_type.gui, file_id)
        dLen = FileLen(dirGUI)
        ReDim dData(dLen - 1)
        handle = FreeFile()
        Open dirGUI For Binary As handle
        Seek handle, 1
        Get handle, , dData
        Close handle
        DoEvents
        ReDim GUIInMemory(GUIInMemory_Cant).data(1 To dLen - 1) As Byte
        GUIInMemory(GUIInMemory_Cant).data = dData
        GUIInMemory(GUIInMemory_Cant).dLen = dLen
        GUIInMemory(GUIInMemory_Cant).ID = file_id
eIter1:         Iter1 = 1
11      Delete_File (dirGUI)
12      Num = 1
    Else
        For I = 1 To GUIInMemory_Cant
            If GUIInMemory(I).ID = file_id Then
                Num = I
                Exit For
            End If
        Next I
    End If
    If Num = 0 Then
        GUIInMemory_Cant = GUIInMemory_Cant + 1
        ReDim Preserve GUIInMemory(1 To GUIInMemory_Cant) As tGUIInMemory
        dirGUI = Get_FileFrom(resource_file_type.gui, file_id)
        dLen = FileLen(dirGUI)
        ReDim dData(dLen - 1)
        handle = FreeFile()
        Open dirGUI For Binary As handle
        Seek handle, 1
        Get handle, , dData
        Close handle
        ReDim GUIInMemory(GUIInMemory_Cant).data(1 To dLen - 1) As Byte
        GUIInMemory(GUIInMemory_Cant).data = dData
        GUIInMemory(GUIInMemory_Cant).dLen = dLen
        GUIInMemory(GUIInMemory_Cant).ID = file_id
13      Num = GUIInMemory_Cant
eIter2:         Iter1 = 2
        Delete_File (dirGUI)
    End If
    If Num = 0 Then
        MsgBox "No se pudo cargar el file: " & file_id
    Else
        If ISPNG Then
            Set what.Picture = ArrayToPicturePNG(GUIInMemory(Num).data)
        Else
            Set what.Picture = ArrayToPictureBMP(GUIInMemory(Num).data, GUIInMemory(Num).dLen)
        End If
    End If
    Exit Function
errHandler:
    totit = totit + 1
    If totit < 5 Then
        Err.Clear
        If Iter1 = 1 Then
            GoTo eIter1
        Else
            GoTo eIter2
        End If
    Else
        forms_load_pic = -1
    End If
End Function

Public Function resetGuiFocus()
    Dim I As Long
    For I = 1 To MaxGuiObj
        GuiTxt(I).HasFocus = False
    Next I
End Function

Public Function resetGuiData()
    Dim I As Long
    For I = 1 To MaxGuiObj
        GuiTxt(I).HasFocus = False
    Next I
    For I = 3 To 7
        GuiTxt(I).Texto = ""
        GuiTxt(I).PassTmp = ""
    Next I
    UserPin = ""
    UserPassword = ""
    GuiTxt(3).Texto = ""        ' @@ Crear PJ
    For I = 1 To frmCrearPersonaje.Skill().Count
        GuiTexto(5 + I).Texto = "0"
        GuiTexto(5 + I).PassTmp = ""
    Next I
End Function

Public Sub guimod(ByVal ID As Integer, ByVal X As Integer, ByVal Y As Integer)
    With GuiTxt(ID)
        .StartY = Y
        .EndY = .StartY + TxtBox_H
        .StartX = X - IIf(GuiTxt(ID).Centered, Round(.Width / 2), 0)
        .EndX = X + IIf(GuiTxt(ID).Centered, Round(.Width / 2), .Width)
    End With
End Sub

Private Sub InitializeLabel(ByRef Caption As String, ByRef Objeto As tGuiObject, ByVal X As Integer, _
                            ByVal Y As Integer, ByVal SetFocusOn As Byte, Optional ByVal Sombreado As Boolean = True)
    With Objeto
        .tipo = Label
        .Width = Engine_GetTextWidth(cfonts(1), Caption)
        .StartY = Y
        .EndY = .StartY + 25
        .StartX = X - Round(.Width / 2)
        .EndX = X + Round(.Width / 2)
        .Texto = Caption
        .SetFocusOn = SetFocusOn
        .Sombreado = Sombreado
    End With
End Sub
Private Function PassChar(ByVal Lengh As Integer) As String
    Dim LoopC As Long
    If Lengh <= 0 Then PassChar = vbNullString: Exit Function
    For LoopC = 1 To Lengh
        PassChar = PassChar & "*"
    Next LoopC
End Function

Private Sub InitializeTxtBox(ByRef Objeto As tGuiObject, ByVal ID As Byte, ByVal Width As Integer, ByVal X As Integer, _
                             ByVal Y As Integer, Optional ByVal Password As Boolean = False, _
                             Optional ByVal MaxLenght As Byte = 40, _
                             Optional ByVal StartWithFocus As Boolean = False, _
                             Optional ByVal EventWithEnter As Boolean = False, _
                             Optional ByVal InitText As String = vbNullString, _
                             Optional ByVal Centered As Boolean = False)
    With Objeto
        .ID = ID
        .Centered = Centered
        .tipo = TxtBox
        .CallEventWithEnter = EventWithEnter
        .Width = Width
        .StartY = Y
        .EndY = .StartY + TxtBox_H
        .StartX = X - IIf(Centered, Round(.Width / 2), 0)
        .EndX = X + IIf(Centered, Round(.Width / 2), .Width)

        .CallEventWithEnter = EventWithEnter
        .HasFocus = StartWithFocus
        .IsPassWd = Password
        .MaxLenght = MaxLenght
        .Texto = InitText
        .PassTmp = PassChar(Len(InitText))
        .Sombreado = True
    End With

End Sub

Public Sub CrearPJ_KeyPress(KeyAscii As Integer)
    For loopGui = 1 To MaxGuiObj
        With GuiTxt(loopGui)
            If .tipo = TxtBox And .HasFocus Then
                If ((KeyAscii = vbKeyBack)) And Len(.Texto) > 0 Then
                    .Texto = Left(.Texto, Len(.Texto) - 1)
                    .PassTmp = PassChar(Len(.Texto))
                    Exit Sub
                End If
                If KeyAscii = vbKeyReturn Then
                    If .CallEventWithEnter Then
                        CallWindowProc .Evento, 0&, 0&, 0&, 0&
                        Exit Sub
                    End If
                    Exit Sub
                End If
                If KeyAscii >= vbKeySpace And KeyAscii <= 250 And Len(.Texto) < .MaxLenght Then
                    If loopGui = 3 Then
                        .Texto = .Texto + UCase$(Chr$(KeyAscii))        'nick
                    Else
                        .Texto = .Texto + Chr$(KeyAscii)
                    End If

                    .PassTmp = PassChar(Len(.Texto))
                End If
            End If
        End With
    Next loopGui
End Sub

Public Sub GUI_Click(Optional ByVal DblClick As Boolean = False)

    If PanelCrearPJVisible = False Then Exit Sub
    Dim lastfocus As Byte, cambiofocus As Boolean, forcefocus As Byte
    Dim Start As Byte
    Dim fin As Byte
    Dim qX As Integer
    Dim qY As Integer

    If frmCrearPersonaje.visible Then
        Start = 3
        fin = 7
        qX = frmCrearPersonaje.Mx
        qY = frmCrearPersonaje.mY
    Else
        Start = 1
        fin = 2

        qX = frmConnect.Mx
        qY = frmConnect.mY
    End If

    For loopGui = Start To fin
        With GuiTxt(loopGui)
            If GuiEvent(GuiTxt(loopGui), qX, qY) = Over Then
                If .tipo = Cmd Then

                    CallWindowProc .Evento, 0&, 0&, 0&, 0&

                ElseIf .tipo = TxtBox Then
                    If DblClick Then
                        .Texto = vbNullString
                        .PassTmp = vbNullString
                    End If
                    .HasFocus = True
                    cambiofocus = True

                    If loopGui = 3 And DblClick = False Then
                        'nombre
                        'MsgBox "Sea cuidadoso al seleccionar el nombre de su personaje, Argentum es un juego de rol, un mundo magico y fantastico, si selecciona un nombre obsceno o con connotación politica los administradores borrarán su personaje y no habrá ninguna posibilidad de recuperarlo."
                    End If

                ElseIf .tipo = Label Then
                    forcefocus = .SetFocusOn
                    Exit For
                End If
            Else
                If .tipo = TxtBox Then
                    If .HasFocus = True Then
                        lastfocus = loopGui
                    End If
                    .HasFocus = False        'Le sacamos el foco
                End If
            End If
        End With
    Next loopGui

    If forcefocus <> 0 Then
        For loopGui = Start To fin
            With GuiTxt(loopGui)
                If .tipo = TxtBox Then
                    If loopGui = forcefocus Then
                        .HasFocus = True
                    Else
                        .HasFocus = False
                    End If
                End If
            End With
        Next loopGui
        Exit Sub
    End If

    If cambiofocus = False Then        'el focus no se fue a otro textbox.
        If lastfocus > 0 And lastfocus <= MaxGuiObj Then
            GuiTxt(lastfocus).HasFocus = True
        End If
    End If

End Sub

Public Function GuiEvent(obj As tGuiObject, X As Integer, Y As Integer) As eGuiMode
    GuiEvent = eGuiMode.nada

    With obj

        If .ID = 3 Or .ID = 7 Then

            If .ID = 3 Then
                If Y > (.StartY - 20) And Y < (.EndY) Then
                    If X > (.StartX - 300) And X < (.EndX + 3) Then
                        GuiEvent = eGuiMode.Over
                    Else
                        GuiEvent = nada
                    End If
                Else
                    GuiEvent = nada
                End If
            ElseIf .ID = 7 Then
                If Y < (.EndY + 20) And Y > (.StartY - 9) Then
                    If X > (.StartX - 300) And X < (.EndX + 3) Then
                        GuiEvent = eGuiMode.Over
                    Else
                        GuiEvent = nada
                    End If
                Else
                    GuiEvent = nada
                End If
            End If

        Else


            If Y > (.StartY - 9) And Y < (.EndY + 3) Then        'Esta en el rango horizontal del objeto
                If X > (.StartX - 300) And X < (.EndX + 3) Then        'Tambien en el vertical, ejecutamos accion

                    ' fix al crear pj
                    If Abs(.EndY - Y) < Abs(GuiTxt(.ID + 1).StartY - Y) Then
                        GuiEvent = Over
                    Else
                        GuiEvent = nada
                    End If

                Else
                    GuiEvent = nada
                End If

            Else
                GuiEvent = nada

            End If

        End If

    End With

End Function

Sub DrawGuiConnect()

    Dim HayOver As Boolean, Modo As eGuiMode

    If GetTickCount - TitilaCounter > 700 Then
        Titila = Not Titila
        TitilaCounter = GetTickCount
    End If

    Dim CALCULO As Integer
    For loopGui = 1 To 2
        With GuiTxt(loopGui)
            Modo = GuiEvent(GuiTxt(loopGui), frmConnect.Mx, frmConnect.mY)
            If .tipo = Cmd Then
                If HayOver = False Then        ' asi no lo pone en false aunque haya un over
                    HayOver = (Modo = Over)
                End If
                If Modo = Over Then
                    If frmConnect.mb = vbLeftButton Then
                        Modo = MouseDown
                    End If
                End If

            ElseIf .tipo = TxtBox Then
                If HayOver = False Then        ' asi no lo pone en false aunque haya un over
                    HayOver = (Modo = Over)
                End If

                If .Centered Then
                    CALCULO = (Round(Engine_GetTextWidth(cfonts(2), IIf(.IsPassWd, .PassTmp, .Texto)) / 2))
                    drawText .StartX + (.Width / 2) - CALCULO, .StartY, IIf(.IsPassWd, .PassTmp, .Texto), D3DColorXRGB(224, 224, 224), AlphaB, , 0, 2        ' 4, AlphaB
                    If .HasFocus = True And Titila = True Then
                        drawText .StartX + (.Width / 2) + CALCULO + IIf(Len(.Texto) > 0, 0, 0), .StartY, Chr$(124), D3DColorXRGB(224, 224, 224), AlphaB, , 0
                    End If
                Else
                    CALCULO = (Engine_GetTextWidth(cfonts(2), IIf(.IsPassWd, .PassTmp, .Texto)))
                    drawText .StartX, .StartY, IIf(.IsPassWd, .PassTmp, .Texto), D3DColorXRGB(224, 224, 224), AlphaB, , 0, 2        ' 4, AlphaB
                    If .HasFocus = True And Titila = True Then
                        drawText .StartX + CALCULO + IIf(Len(.Texto) > 0, 0, 0), .StartY, Chr$(124), D3DColorXRGB(224, 224, 224), AlphaB, , 0
                    End If
                End If

            ElseIf .tipo = Label Then
                drawText .StartX, .StartY, .Texto, IIf(Modo = Over, D3DColorXRGB(150, 150, 150), -1), AlphaB, False
            End If
        End With
    Next loopGui

    If frmConnect.visible And Not frmConnect.MousePointer = 11 Then
        If HayOver Then
            frmConnect.MousePointer = vbCustom
            frmConnect.MouseIcon = picMouseIcon
        Else
            frmConnect.MousePointer = vbNormal
        End If
    End If

End Sub

'*****************Render Connect************** De aca para abajo es la parte del engine del render connect.
Sub DrawGuiTexto()

    Dim HayOver As Boolean, Modo As eGuiMode

    If GetTickCount - TitilaCounter > 700 Then
        Titila = Not Titila
        TitilaCounter = GetTickCount
    End If

    Dim CALCULO As Integer

    For loopGui = 3 To MaxGuiObj        'hardcodeando, habría que hacer como codeé arriba pff.

        With GuiTxt(loopGui)
            '.HasFocus = False

            Modo = GuiEvent(GuiTxt(loopGui), frmCrearPersonaje.Mx, frmCrearPersonaje.mY)
            If .tipo = Cmd Then
                If HayOver = False Then        ' asi no lo pone en false aunque haya un over
                    HayOver = (Modo = Over)
                End If
                If Modo = Over Then
                    If frmCrearPersonaje.mb = vbLeftButton Then
                        Modo = MouseDown
                    End If
                End If

            ElseIf .tipo = TxtBox Then
                If HayOver = False Then
                    HayOver = (Modo = Over)        'And .HasFocus
                End If

                If .Centered Then
                    CALCULO = (Round(Engine_GetTextWidth(cfonts(2), IIf(.IsPassWd, .PassTmp, .Texto)) / 2))
                    drawText .StartX + (.Width / 2) - CALCULO, .StartY, IIf(.IsPassWd, .PassTmp, .Texto), D3DColorXRGB(224, 224, 224), AlphaB, , 0, 2        ' 4, AlphaB
                    If .HasFocus = True And Titila = True Then
                        drawText .StartX + (.Width / 2) + CALCULO + IIf(Len(.Texto) > 0, 0, 0), .StartY, Chr$(124), D3DColorXRGB(224, 224, 224), AlphaB, , 0
                    End If
                Else
                    CALCULO = (Engine_GetTextWidth(cfonts(2), IIf(.IsPassWd, .PassTmp, .Texto)))
                    drawText .StartX, .StartY - (TOP_CAIDA_CONECTAR - Caida), IIf(.IsPassWd, .PassTmp, .Texto), D3DColorXRGB(224, 224, 224), AlphaB, , 0, 2        ' 4, AlphaB
                    If .HasFocus = True And Titila = True Then
                        drawText .StartX + CALCULO + IIf(Len(.Texto) > 0, 0, 0), .StartY - 2 - (TOP_CAIDA_CONECTAR - Caida), Chr$(124), D3DColorXRGB(224, 224, 224), AlphaB, , 0
                    End If
                End If

            ElseIf .tipo = Label Then
                'DrawText .StartX, .StartY, .Texto, IIf(Modo = Over, D3DColorXRGB(150, 150, 150), -1), AlphaB, False
            End If
        End With
    Next loopGui

    If frmCrearPersonaje.Mx > frmCrearPersonaje.imgCrear.Left And frmCrearPersonaje.Mx < (frmCrearPersonaje.imgCrear.Left + frmCrearPersonaje.imgCrear.Width) Then
        If frmCrearPersonaje.mY > frmCrearPersonaje.imgCrear.Top And frmCrearPersonaje.mY < (frmCrearPersonaje.imgCrear.Top + frmCrearPersonaje.imgCrear.Height) Then
            'DrawText frmCrearPersonaje.imgOlvidePass.Left, 424 - (TOP_CAIDA_CONECTAR - Caida), "Olvidé mi contraseña", D3DColorXRGB(255, 255, 255), AlphaB, False, 0
            If Not frmCrearPersonaje.MousePointer = 11 Then
                HayOver = True
            End If
        End If
    End If
    If frmCrearPersonaje.visible And Not frmCrearPersonaje.MousePointer = 11 Then
        If HayOver Then
            frmCrearPersonaje.MousePointer = vbCustom
            frmCrearPersonaje.MouseIcon = picMouseIcon
        Else
            frmCrearPersonaje.MousePointer = vbNormal
        End If
    End If
End Sub

Public Sub Conectarse()

    UserName = Trim$(frmOldPersonaje.NameTxt.Text)
    UserPassword = frmOldPersonaje.PasswordTxt.Text
    If CheckUserData(False) = True Then
        frmOldPersonaje.Label1.visible = True
        Call LoginOrConnect(E_MODO.LoginChar)
    Else
        frmOldPersonaje.Label1.visible = False
    End If
End Sub
