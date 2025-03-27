Attribute VB_Name = "mod_MercadoUsers"
Option Explicit

'modulo del comercio de usuarios
'programado por el_santo43 el 25/02/2016

Private Type tUserPublicado
    precio          As Long 'Valor del pj
    Nivel           As Byte 'Level del pj
    Porcentaje      As Byte 'Porcentaje del pj
    Nick            As String 'Nick
    Vida            As Integer 'Vida
    clase           As eClass 'Clase
    raza            As eRaza 'Raza
    Ocupado         As Boolean 'Esta libre el slot?
    Depositario     As String
    VentaPrivada    As String
End Type
Public Const MaxUsersMercado As Byte = 50 ''Si se cambia esta constante hay que actualizar el cliente _
                                            ya que esta hardcodeado
Public UserMercado(1 To MaxUsersMercado) As tUserPublicado
Public MercadoFile As String


Private Function FindSlot() As Byte
    Dim X As Long
    For X = 1 To UBound(UserMercado)
        With UserMercado(X)
            If .Ocupado = False Then 'Esta ocupado?
                FindSlot = X 'Si esta libre, usamos ese slot
                Exit Function
            End If
        End With
    Next X
    FindSlot = 0
End Function

Public Sub PublicarUser(ByVal UserIndex As Integer, precio As Long, ByVal Pj As String, ByVal Privado As String) '', Subasta As Boolean)
    
    'Dim Cambio As Boolean
    
    With UserList(UserIndex)
        If .EnEvento Then Exit Sub
        
        If .Stats.ELV <= 30 Then
            Call WriteConsoleMsg(UserIndex, "No puedes vender personajes menor a nivel 30.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
                
        If Not precio = 0 And Pj = "" And Privado = "" Then
            If precio < 100000 Or precio > 200000000 Then
                Call WriteConsoleMsg(UserIndex, "El precio minimo es 100.000 y el maximo es 200.000.000", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        
            If FileExist(CharPath & UCase$(Pj) & ".chr", vbNormal) = False Then
                Call WriteConsoleMsg(UserIndex, "El personaje donde deseas recibir el oro no existe.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        End If
        
        Dim fSlot As Byte
        fSlot = FindSlot() 'Buscamos un slot libre
        If fSlot = 0 Then
            Call WriteConsoleMsg(UserIndex, "Hay demasiados personajes en el mercado, intenta en otro momento.", FontTypeNames.FONTTYPE_GUILD)
            Exit Sub
        End If
    
        Dim dChar As String
        dChar = CharPath & UCase$(.Name) & ".chr"
        Call WriteVar(dChar, "MERCADO", "EnMercado", "1")
    End With
    
    
    With UserMercado(fSlot)
        .clase = UserList(UserIndex).clase
        .Nick = UserList(UserIndex).Name
        .Nivel = UserList(UserIndex).Stats.ELV
        .Porcentaje = Round((UserList(UserIndex).Stats.Exp / (UserList(UserIndex).Stats.ELU + 1)) * 100)
        .precio = precio
        .raza = UserList(UserIndex).raza
        .Vida = UserList(UserIndex).Stats.MaxHp
        .Ocupado = True
        .Depositario = Pj
        .VentaPrivada = Privado
    End With
    Call Guardarpj(fSlot)
    Call WriteErrorMsg(UserIndex, "Recuerda que puedes quitar este personaje del mercado desde otro personaje.")
    FlushBuffer UserIndex
    Call CloseSocket(UserIndex)
    Call MensajeGlobal("Mercado de Usuarios> El personaje " & UserMercado(fSlot).Nick & " ha sido publicado." & IIf(Len(UserMercado(fSlot).VentaPrivada) > 0, " En modo privado", vbNullString), FontTypeNames.FONTTYPE_GUILD)
End Sub

Public Sub ComprarUser(ByVal UserIndex As Integer, ByVal mSlot As Byte, ByVal NewPin As String, ByVal Privado As String)
    With UserList(UserIndex)
        If mSlot <= 0 Or mSlot > MaxUsersMercado Then Exit Sub
        If UserMercado(mSlot).Ocupado = False Then
            Call WriteConsoleMsg(UserIndex, "Ese slot esta vacío", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        
        If UCase$(UserMercado(mSlot).VentaPrivada) <> UCase$(Privado) Then
            Call WriteConsoleMsg(UserIndex, "La clave de la venta privada es incorrecta", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        
        If .Stats.GLD < UserMercado(mSlot).precio Then
            Call WriteConsoleMsg(UserIndex, "No tenes suficiente oro para comprar este personaje", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If
        
        
        .Stats.GLD = .Stats.GLD - UserMercado(mSlot).precio
        Call WriteUpdateGold(UserIndex)
        Dim tIndex As Integer
        tIndex = NameIndex(UserMercado(mSlot).Depositario)
        If tIndex > 0 Then ''el pj donde recibe el oro esta online
            UserList(tIndex).Stats.GLD = UserList(tIndex).Stats.GLD + UserMercado(mSlot).precio
            Call WriteUpdateGold(tIndex)
            Call WriteConsoleMsg(tIndex, "Has recibido " & UserMercado(mSlot).precio & " monedas de oro por la venta de " & UserMercado(mSlot).Nick, FontTypeNames.FONTTYPE_INFO)
        Else
            Dim cOro As Long
            cOro = val(GetVar(CharPath & UCase$(UserMercado(mSlot).Depositario) & ".chr", "STATS", "GLD"))
            cOro = cOro + UserMercado(mSlot).precio
            Call WriteVar(CharPath & UCase$(UserMercado(mSlot).Depositario) & ".chr", "STATS", "GLD", CStr(cOro))
        End If
        Dim dChar As String
        dChar = CharPath & UCase$(UserMercado(mSlot).Nick) & ".chr"
        Call WriteVar(dChar, "INIT", "Password", GetVar(CharPath & UCase$(.Name) & ".chr", "INIT", "Password"))
        Call WriteVar(dChar, "INIT", "Pin", NewPin)
        Call WriteVar(dChar, "MERCADO", "EnMercado", "0")
        Call WriteConsoleMsg(UserIndex, "Mercado de Usuarios> Ahora la contraseña de " & UserMercado(mSlot).Nick & " es la misma que la del personaje que estás usando. Y su pin es <" & NewPin & ">", FontTypeNames.FONTTYPE_INFO)
        Call MensajeGlobal("Mercado de Usuarios> El personaje " & UserMercado(mSlot).Nick & " ha sido vendido por " & UserMercado(mSlot).precio & " monedas de oro al usuario " & .Name, FontTypeNames.FONTTYPE_GUILD)
        Call LimpiarSlot(mSlot)
    End With
End Sub
Private Sub LimpiarSlot(ByVal mSlot As Byte)
    Call WriteVar(MercadoFile, "USER" & mSlot, "Nick", vbNullString)
    
    With UserMercado(mSlot)
        .clase = 0
        .Nick = vbNullString
        .Nivel = 0
        .Ocupado = False
        .Porcentaje = 0
        .precio = 0
        .Vida = 0
        .raza = 0
        .Depositario = vbNullString
        .VentaPrivada = vbNullString
    End With
End Sub

Public Sub QuitarPJ(ByVal UserIndex As Integer, Nick As String, ByVal Password As String, ByVal pin As String)
        
    Dim X As Long, fSlot As Byte, lError As String
    If FileExist(CharPath & UCase$(Nick) & ".chr", vbNormal) Then
        For X = 1 To UBound(UserMercado)
            If UCase$(UserMercado(X).Nick) = UCase$(Nick) Then
                fSlot = X
                Exit For
            End If
        Next X
        
        If UCase$(GetVar(CharPath & UCase$(Nick) & ".chr", "INIT", "PASSWORD")) <> UCase$(Password) Then
            lError = "Pin o contraseña incorrectos."
        End If
        If GetVar(CharPath & UCase$(Nick) & ".chr", "INIT", "Pin") <> pin Then
            lError = "Pin o contraseña incorrectos."
        End If
        If fSlot = 0 Then
            lError = "Este personaje no se encuentra a la venta"
        End If
    Else
        lError = "Personaje inexistente."
    End If
    If LenB(lError) > 0 Then
        Call WriteConsoleMsg(UserIndex, "Mercado de usuarios> " & lError, FontTypeNames.FONTTYPE_INFO)
    Else
        Call WriteVar(CharPath & UCase$(Nick) & ".chr", "MERCADO", "EnMercado", "0")
        Call LimpiarSlot(fSlot)
        Call MensajeGlobal("Mercado de Usuarios> El personaje " & UserMercado(fSlot).Nick & " ha sido quitado del mercado.", FontTypeNames.FONTTYPE_GUILD)
    End If
End Sub

Private Sub Guardarpj(ByVal mSlot As Byte)
    With UserMercado(mSlot)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Nick", .Nick)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Precio", .precio)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Clase", .clase)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Nivel", .Nivel)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Raza", .raza)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Vida", .Vida)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Porcentaje", .Porcentaje)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Depositario", .Depositario)
        Call WriteVar(MercadoFile, "USER" & mSlot, "Privado", .VentaPrivada)
    End With
End Sub


Public Sub InitMercado()
    On Error GoTo Errhandler
    
    Dim X As Long
    MercadoFile = App.path & "\Dat\MercadoAO.ini"
    
    For X = 1 To UBound(UserMercado)
        With UserMercado(X)
            .Nick = GetVar(MercadoFile, "USER" & X, "Nick")
            If LenB(.Nick) > 0 Then
                .precio = val(GetVar(MercadoFile, "USER" & X, "Precio"))
                .clase = val(GetVar(MercadoFile, "USER" & X, "Clase"))
                .Nivel = val(GetVar(MercadoFile, "USER" & X, "Nivel"))
                .raza = val(GetVar(MercadoFile, "USER" & X, "Raza"))
                .Vida = val(GetVar(MercadoFile, "USER" & X, "Vida"))
                .Porcentaje = val(GetVar(MercadoFile, "USER" & X, "Porcentaje"))
                .Depositario = GetVar(MercadoFile, "USER" & X, "Depositario")
                .VentaPrivada = GetVar(MercadoFile, "USER" & X, "Privado")
                .Ocupado = True
            Else
                .Ocupado = False 'Por las dudas
            End If
        End With
    Next X
    
    Exit Sub
    
Errhandler:
Call LogError("Error cargando MercadoAO")
End Sub
