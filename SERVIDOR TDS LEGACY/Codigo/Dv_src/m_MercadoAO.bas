Attribute VB_Name = "m_MercadoAO"
Option Explicit

Public Function MAO_PuedeIngresar(ByVal UserName As String, ByRef ErrString As String) As Boolean
    Dim tUser As Long
    tUser = NameIndex(UserName)
    If PersonajeBaneado(UserName) Then ErrString = UserName & " está baneado!": Exit Function

    ' @@ validaciones
    If tUser > 0 Then
        If UserList(tUser).flags.mao_index > 0 Then ErrString = UserName & " ya está en el Mercado!": Exit Function
        If UserList(tUser).Stats.ELV < 15 Then ErrString = UserName & " es menor a nivel 15!": Exit Function
        If UserList(tUser).flags.Comerciando Then ErrString = UserName & " está comerciando!": Exit Function
        If MapInfo(UserList(tUser).Pos.Map).pk Then ErrString = UserName & " está en zona insegura!": Exit Function
        If UserList(tUser).Counters.Pena > 0 Then ErrString = UserName & " está en cárcel!": Exit Function
        If UserList(tUser).flags.Muerto <> 0 Then ErrString = UserName & " está muerto!": Exit Function
    Else
        Dim tempStr As String
        tempStr = GetVar(CharPath & UserName & ".chr", "INIT", "Position")
        If val(GetVar(CharPath & UserName & ".chr", "FLAGS", "MAO_Index")) > 0 Then ErrString = UserName & " ya está en el Mercado!": Exit Function
        If val(GetVar(CharPath & UserName & ".chr", "STATS", "ELV")) < 15 Then ErrString = UserName & " es menor a nivel 15!": Exit Function
        If val(GetVar(CharPath & UserName & ".chr", "COUNTERS", "PENA")) > 0 Then ErrString = UserName & " está en cárcel!": Exit Function
        If val(GetVar(CharPath & UserName & ".chr", "FLAGS", "MUERTO")) > 0 Then ErrString = UserName & " está muerto!": Exit Function
        If Not (val(ReadField(1, tempStr, 45)) > 0 And val(ReadField(1, tempStr, 45)) <= NumMaps) Then ErrString = UserName & " se encuentra en un mapa inválido.": Exit Function
        If MapInfo(val(ReadField(1, tempStr, 45))).pk Then ErrString = UserName & " está en zona insegura!": Exit Function
    End If

    MAO_PuedeIngresar = True

End Function

Public Sub MAO_EliminarPublicacion(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, ByVal TmpStr As String)
    On Error GoTo Errhandler

    Dim Personajes() As String
    Dim tIndex As Integer
    Dim i As Long

    If Not m_Cuentas.CuentaCoincide(AccountName, AccountPin, AccountPassword) Then
        Call EnviarDatosASlot(UserIndex, 1)
        Exit Sub
    End If

    Personajes = Split(TmpStr, "-")

    For i = LBound(Personajes) To UBound(Personajes)
        If Not AsciiValidos(Personajes(i)) Then Call EnviarDatosASlot(UserIndex, 2): Exit Sub
        If Not PersonajeExiste(Personajes(i)) Then Call EnviarDatosASlot(UserIndex, 3): Exit Sub
        If GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 4): Exit Sub
        If val(GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "MAO", "MAO_Index")) = 0 Then Call EnviarDatosASlot(UserIndex, 5): Exit Sub
        'If val(GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "FLAGS", "BAN")) > 0 Then Call EnviarDatosASlot( UserIndex, "6"): Exit Sub
    Next i

    Dim MaoID As Integer
    MaoID = val(GetVar(CharPath & UCase$(Personajes(0)) & ".chr", "MAO", "MAO_Index"))

    If MaoID = 0 Then Call EnviarDatosASlot(UserIndex, 7): Exit Sub

    For i = LBound(Personajes) To UBound(Personajes)
        tIndex = NameIndex(Personajes(i))
        If tIndex > 0 Then
            UserList(tIndex).flags.mao_index = 0
            Call WriteConsoleMsg(tIndex, "Has eliminado a éste personaje del MercadoAO de la web.")
        End If
        Call WriteVar(CharPath & UCase$(Personajes(i)) & ".chr", "MAO", "MAO_Index", 0)
    Next i

    Call EnviarDatosASlot(UserIndex, 0, True)

    Exit Sub

Errhandler:
    Call LogError("Error en MAO_EliminarPub en " & Erl & ". Err " & Err.Number & " " & Err.Description)
End Sub
Public Sub MAO_CrearPublicacion(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, ByVal Oro As Long, ByVal tipo As Byte, ByVal TmpStr As String, ByVal SlotIndex As Long)

    On Error GoTo Errhandler

    Dim TotPjs As Byte
    Dim Personajes() As String
    Dim i As Long
    Dim ErrString As String

    If Not m_Cuentas.CuentaCoincide(AccountName, AccountPin, AccountPassword) Then
        Call EnviarDatosASlot(UserIndex, 1)
        Exit Sub
    End If

    If SlotIndex = 0 Then
        Call EnviarDatosASlot(UserIndex, 2)
        Exit Sub
    End If

    Oro = val(CLng(Oro))
    tipo = Abs(tipo)

    Personajes = Split(TmpStr, "-", 4)
    TotPjs = UBound(Personajes)

    For i = 0 To TotPjs
        Personajes(i) = Trim$(UCase$(Personajes(i)))
        Personajes(i) = Replace$(Personajes(i), vbCrLf, "")
    Next i

    Dim tempStr As String

    For i = 0 To UBound(Personajes)
        If Not AsciiValidos(Personajes(i)) Then Call EnviarDatosASlot(UserIndex, 3): Exit Sub
        If Not PersonajeExiste(Personajes(i)) Then Call EnviarDatosASlot(UserIndex, 4): Exit Sub
        If NameIndex(Personajes(i)) Then Call EnviarDatosASlot(UserIndex, 4): Exit Sub

        tempStr = GetVar(CharPath & Personajes(i) & ".chr", "INIT", "Position")
        If Not (val(ReadField(1, tempStr, 45)) > 0 And val(ReadField(1, tempStr, 45)) <= NumMaps) Then Call EnviarDatosASlot(UserIndex, 10): Exit Sub
        If MapInfo(val(ReadField(1, tempStr, 45))).pk Then Call EnviarDatosASlot(UserIndex, 10): Exit Sub

        If GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 5): Exit Sub
        If val(GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "MAO", "MAO_Index")) > 0 Then Call EnviarDatosASlot(UserIndex, 7): Exit Sub
        If val(GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "FLAGS", "BAN")) > 0 Then Call EnviarDatosASlot(UserIndex, 6): Exit Sub
        If Not MAO_PuedeIngresar(Personajes(i), ErrString) Then Call EnviarDatosASlot(UserIndex, 9): Exit Sub    'ErrString
    Next i

    Oro = Abs(Oro)
    If Oro > 50000000 Then Oro = 50000000

    Select Case tipo
    Case 1
        If Oro < 10000 Then Oro = 10000
        'MAO(SlotLibre).oferta_fin = Now + 7        ' 1 semana para la oferta, deshardcodear?
    Case 2
        Oro = 0
    Case Else
        Call EnviarDatosASlot(UserIndex, 9): Exit Sub
        Exit Sub
    End Select

    For i = 0 To TotPjs
        If val(GetVar(CharPath & UCase$(Personajes(i)) & ".chr", "MAO", "MAO_Index")) > 0 Then Exit Sub
    Next i

    For i = 0 To TotPjs
        Call WriteVar(CharPath & UCase$(Personajes(i)) & ".chr", "MAO", "MAO_Index", SlotIndex)
    Next i

    Call EnviarDatosASlot(UserIndex, 0, True)

    Exit Sub
Errhandler:
    Call LogError("Error en MAO_CrearPublicacion en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Public Sub MAO_ComprarPjPorOro(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, ByVal Comprador As String, ByVal NickOfertado As String, ByVal Oro As Long, ByVal Cheque As String)
    On Error GoTo Errhandler

    Dim mao_index As Long
    Dim CompradorIndex As Integer
    Dim i As Long
    Dim tmpGold As Long
    Dim tempStr() As String
    Dim TmpStr As String
    Dim pjLogged As Integer
    Dim tIndex As Integer

    Oro = Abs(Oro)

    ' @@ Valido por las dudas
    If Oro = 0 Or Oro > 20000000 Then Call EnviarDatosASlot(UserIndex, 1): Exit Sub

    tempStr = Split(NickOfertado, "-")

    For i = LBound(tempStr) To UBound(tempStr)

        pjLogged = NameIndex(tempStr(i))
        If pjLogged > 0 Then
            mao_index = UserList(pjLogged).flags.mao_index
        Else
            If val(GetVar(CharPath & tempStr(i) & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 2): Exit Sub
            mao_index = val(GetVar(CharPath & tempStr(i) & ".chr", "MAO", "MAO_Index"))
        End If

        If mao_index = 0 Then Call EnviarDatosASlot(UserIndex, 3): Exit Sub

    Next i


    CompradorIndex = NameIndex(Comprador)
    If CompradorIndex > 0 Then
        tmpGold = UserList(CompradorIndex).Stats.Banco
        If tmpGold < Oro Then Call WriteConsoleMsg(CompradorIndex, "No tienes el oro suficiente."): Call EnviarDatosASlot(UserIndex, 4): Exit Sub
        If MapInfo(UserList(CompradorIndex).Pos.Map).pk Then Call WriteConsoleMsg(CompradorIndex, "Debes estar en zona segura para comprar un personaje desde el Mercado."): Call EnviarDatosASlot(UserIndex, 5): Exit Sub
        If UserList(CompradorIndex).Counters.Pena > 0 Then Call WriteConsoleMsg(CompradorIndex, "Estás en la cárcel!"): Call EnviarDatosASlot(UserIndex, 6): Exit Sub
    Else
        tmpGold = Abs(val(GetVar(CharPath & Comprador & ".chr", "STATS", "BANCO")))
        TmpStr = GetVar(CharPath & Comprador & ".chr", "INIT", "Position")
        If tmpGold < Oro Then Call EnviarDatosASlot(UserIndex, 4): Exit Sub
        If Not (val(ReadField(1, TmpStr, 45)) > 0 And val(ReadField(1, TmpStr, 45)) <= NumMaps) Then Call EnviarDatosASlot(UserIndex, 7): Exit Sub
        If MapInfo(val(ReadField(1, TmpStr, 45))).pk Then Call EnviarDatosASlot(UserIndex, 5): Exit Sub
        If val(GetVar(CharPath & Comprador & ".chr", "COUNTERS", "PENA")) > 0 Then Call EnviarDatosASlot(UserIndex, 6): Exit Sub
    End If

    If LCase$(NickOfertado) = LCase$(Comprador) Then
        Call EnviarDatosASlot(UserIndex, 8): Exit Sub
    End If

    If GetVar(CharPath & Comprador & ".chr", "INIT", "ACCOUNT") = GetVar(CharPath & tempStr(0) & ".chr", "INIT", "ACCOUNT") Then
        Call EnviarDatosASlot(UserIndex, 8): Exit Sub
    End If

    ' @@ Vendedor
    If pjLogged > 0 Then
        Call CancelarComercioUser(pjLogged)
        UserList(pjLogged).Account = AccountName
        Call WriteErrorMsg(tIndex, Comprador & " compró tu personaje en el MAO!!")
        'Call Flushbuffer(PJLogged)
        Call CloseSocket(pjLogged)
    End If

    ' @@ Comprador
    If CompradorIndex > 0 Then
        Call CancelarComercioUser(CompradorIndex)
        UserList(CompradorIndex).Stats.Banco = tmpGold - Oro
        Call WriteVar(CharPath & UserList(CompradorIndex).Name & ".chr", "STATS", "BANCO", UserList(CompradorIndex).Stats.Banco)
        Call WriteConsoleMsg(CompradorIndex, "Has comprado a " & Chr(34) & NickOfertado & Chr(34) & ".", FontTypeNames.FONTTYPE_GUILD)
    Else
        tmpGold = Abs(val(GetVar(CharPath & Comprador & ".chr", "STATS", "BANCO")))
        Call WriteVar(CharPath & Comprador & ".chr", "STATS", "BANCO", tmpGold - Oro)
    End If

    Dim totCheques As Long

    totCheques = val(GetVar(DatPath & "Cheques.dat", "INIT", "Cheques"))
    totCheques = totCheques + 1

    Call WriteVar(DatPath & "Cheques.dat", "INIT", "Cheques", totCheques)

    Call WriteVar(DatPath & "Cheques.dat", totCheques, "ID", Cheque)
    Call WriteVar(DatPath & "Cheques.dat", totCheques, "Monto", Oro)

    ' @@ Deposito
    'Dim DepositoIndex As Long
    'Dim DepositoGold As Long
    'DepositoIndex = NameIndex(Deposito)
    'If DepositoIndex > 0 Then
    '    UserList(DepositoIndex).Stats.Banco = UserList(DepositoIndex).Stats.Banco + Oro
    '    If UserList(DepositoIndex).flags.Comerciando Then WriteUpdateBankGold (DepositoIndex)
    '    Call WriteConsoleMsg(DepositoIndex, Comprador & " te ha comprado a tu personaje " & Chr(34) & NickOfertado & Chr(34) & " a traves del MercadoAO!!", FontTypeNames.FONTTYPE_GUILD)
    '    DepositoGold = UserList(DepositoIndex).Stats.Banco
    'Else
    '    DepositoGold = Abs(val(GetVar(CharPath & Deposito & ".chr", "STATS", "BANCO")))
    'End If

    ' @@ Vars
    'Call WriteVar(CharPath & Comprador & ".chr", "STATS", "BANCO", (tmpGold - Oro))

    For i = LBound(tempStr) To UBound(tempStr)
        Call WriteVar(CharPath & tempStr(i) & ".chr", "INIT", "ACCOUNT", AccountName)
        Call WriteVar(CharPath & tempStr(i) & ".chr", "MAO", "MAO_Index", 0)
        Call WriteVar(CharPath & tempStr(i) & ".chr", "CONTACTO", "Email", GetVar(CharPath & Comprador & ".chr", "CONTACTO", "Email"))
        Call WriteVar(CharPath & tempStr(i) & ".chr", "INIT", "Password", GetVar(CharPath & Comprador & ".chr", "INIT", "Password"))
        Call WriteVar(CharPath & tempStr(i) & ".chr", "INIT", "Pin", GetVar(CharPath & Comprador & ".chr", "INIT", "Pin"))
    Next i

    ' @@ Notifico a la Web
    Call EnviarDatosASlot(UserIndex, 0, True)

    Exit Sub
Errhandler:
    Call LogError("Error en MAO_ComprarPjPorOro en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Public Sub MAO_CambiarPj(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, ByVal PjsVendedor As String, ByVal PjsComprador As String, ByVal Param1 As String, ByVal Param2 As String)
    On Error GoTo Errhandler

    If Not m_Cuentas.CuentaCoincide(AccountName, AccountPin, AccountPassword) Then
        Call EnviarDatosASlot(UserIndex, 1)    'Datos invalidos pa.
        Exit Sub
    End If

    Dim arrPjsComprador() As String, arrPjsVendedor() As String, i As Long, pjLogged As Integer

    arrPjsComprador = Split(PjsComprador, "-")
    arrPjsVendedor = Split(PjsVendedor, "-")

    If UBound(arrPjsComprador) = 0 Or UBound(arrPjsVendedor) = 0 Then
        Call EnviarDatosASlot(UserIndex, 2)    'Hubo un error con ésta oferta.
        Exit Sub
    End If

    Dim Email(1) As String, Pin(1) As String, Pass(1) As String, Acc(1) As String


    For i = LBound(arrPjsVendedor) To UBound(arrPjsVendedor)

        If Not AsciiValidos(arrPjsVendedor(i)) Then
            Call EnviarDatosASlot(UserIndex, 3): Exit Sub    'Nick invalido.
        End If
        If Not PersonajeExiste(arrPjsVendedor(i)) Then
            Call EnviarDatosASlot(UserIndex, 3): Exit Sub    'Nick invalido.
        End If
        pjLogged = NameIndex(arrPjsVendedor(i))
        If pjLogged > 0 Then
            Call CloseSocket(pjLogged)
        End If

    Next i

    For i = LBound(arrPjsComprador) To UBound(arrPjsComprador)

        If Not AsciiValidos(arrPjsComprador(i)) Then
            Call EnviarDatosASlot(UserIndex, 3): Exit Sub    'Nick invalido.
        End If
        If Not PersonajeExiste(arrPjsComprador(i)) Then
            Call EnviarDatosASlot(UserIndex, 3): Exit Sub    'Nick invalido.
        End If
        pjLogged = NameIndex(arrPjsComprador(i))
        If pjLogged > 0 Then
            Call CloseSocket(pjLogged)
        End If

    Next i


    Dim Array_Param1() As String, Array_Param2() As String

    Array_Param1 = Split(Param1, ";;;")
    Array_Param2 = Split(Param2, ";;;")

    Email(0) = Array_Param1(3)    'GetVar(CharPath & arrPjsVendedor(0) & ".chr", "CONTACTO", "Email")
    Pin(0) = Array_Param1(1)    'GetVar(CharPath & arrPjsVendedor(0) & ".chr", "INIT", "Pin")
    Pass(0) = Array_Param1(2)    'GetVar(CharPath & arrPjsVendedor(0) & ".chr", "INIT", "Password")
    Acc(0) = Array_Param1(0)    'GetVar(CharPath & arrPjsVendedor(0) & ".chr", "INIT", "Account")

    Email(1) = Array_Param2(3)    'GetVar(CharPath & arrPjsComprador(0) & ".chr", "CONTACTO", "Email")
    Pin(1) = Array_Param2(1)    'GetVar(CharPath & arrPjsComprador(0) & ".chr", "INIT", "Pin")
    Pass(1) = Array_Param2(2)    'GetVar(CharPath & arrPjsComprador(0) & ".chr", "INIT", "Password")
    Acc(1) = Array_Param2(0)    'GetVar(CharPath & arrPjsComprador(0) & ".chr", "INIT", "Account")

    For i = LBound(arrPjsVendedor) To UBound(arrPjsVendedor)
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "CONTACTO", "Email", Email(1))
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "INIT", "Pin", Pin(1))
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "INIT", "Password", Pass(1))
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "INIT", "Account", Acc(1))
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "MAO", "MAO_Index", 0)
        Call WriteVar(CharPath & arrPjsVendedor(i) & ".chr", "FLAGS", "char_locked", 0)
    Next i

    For i = LBound(arrPjsComprador) To UBound(arrPjsComprador)
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "CONTACTO", "Email", Email(0))
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "INIT", "Pin", Pin(0))
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "INIT", "Password", Pass(0))
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "INIT", "Account", Acc(0))
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "MAO", "MAO_Index", 0)
        Call WriteVar(CharPath & arrPjsComprador(i) & ".chr", "FLAGS", "char_locked", 0)
    Next i

    'If mao_index = 0 Then Call EnviarDatosASlot(userindex, 3): Exit Sub
    'CompradorIndex = NameIndex(Comprador)
    'If CompradorIndex > 0 Then
    '    tmpGold = UserList(CompradorIndex).Stats.Banco
    '    If tmpGold < Oro Then Call WriteConsoleMsg(CompradorIndex, "No tienes el oro suficiente."): Call EnviarDatosASlot(userindex, 4): Exit Sub
    '    If MapInfo(UserList(CompradorIndex).Pos.map).pk Then Call WriteConsoleMsg(CompradorIndex, "Debes estar en zona segura para comprar un personaje desde el Mercado."): Call EnviarDatosASlot(userindex, 5): Exit Sub
    '    If UserList(CompradorIndex).Counters.Pena > 0 Then Call WriteConsoleMsg(CompradorIndex, "Estás en la cárcel!"): Call EnviarDatosASlot(userindex, 6): Exit Sub
    'Else
    '    tmpGold = Abs(val(GetVar(CharPath & Comprador & ".chr", "STATS", "BANCO")))
    '    TempStr = GetVar(CharPath & Comprador & ".chr", "INIT", "Position")
    '    If tmpGold < Oro Then Call EnviarDatosASlot(userindex, 4): Exit Sub
    '    If Not (val(ReadField(1, TempStr, 45)) > 0 And val(ReadField(1, TempStr, 45)) <= NumMaps) Then Call EnviarDatosASlot(userindex, 7): Exit Sub
    '    If MapInfo(val(ReadField(1, TempStr, 45))).pk Then Call EnviarDatosASlot(userindex, 5): Exit Sub
    '    If val(GetVar(CharPath & Comprador & ".chr", "COUNTERS", "PENA")) > 0 Then Call EnviarDatosASlot(userindex, 6): Exit Sub
    'End If
    'If LCase$(NickOfertado) = LCase$(Comprador) Then
    '    Call EnviarDatosASlot(userindex, 8): Exit Sub
    'End If
    'If val(GetVar(CharPath & Comprador & ".chr", "INIT", "ACCOUNT")) = val(GetVar(CharPath & NickOfertado & ".chr", "INIT", "ACCOUNT")) Then
    '    Call EnviarDatosASlot(userindex, 8): Exit Sub
    'End If

    ' @@ Vendedor
    '   If pjLogged > 0 Then
    '       Call CancelarComercioUser(pjLogged)
    '       UserList(pjLogged).Account = AccountName
    '       Call WriteErrorMsg(tindex, Comprador & " compró tu personaje en el MAO!!")
    '       'Call Flushbuffer(PJLogged)
    '       Call CloseSocket(pjLogged)
    '   End If

    ' @@ Comprador
    '   If CompradorIndex > 0 Then
    '       Call CancelarComercioUser(CompradorIndex)
    '       UserList(CompradorIndex).Stats.Banco = tmpGold - Oro
    '      Call WriteConsoleMsg(CompradorIndex, "Has comprado a " & Chr(34) & NickOfertado & Chr(34) & ".", FontTypeNames.FONTTYPE_GUILD)
    ''  Else
    '      tmpGold = Abs(val(GetVar(CharPath & Comprador & ".chr", "STATS", "BANCO")))
    '      Call WriteVar(CharPath & Comprador & ".chr", "STATS", "BANCO", tmpGold - Oro)
    '   End If

    ' @@ Deposito
    '    Dim DepositoIndex As Long
    '    Dim DepositoGold As Long
    '    DepositoIndex = NameIndex(Deposito)
    '    If DepositoIndex > 0 Then
    '        UserList(DepositoIndex).Stats.Banco = UserList(DepositoIndex).Stats.Banco + Oro
    '        If UserList(DepositoIndex).flags.Comerciando Then WriteUpdateBankGold (DepositoIndex)
    '        Call WriteConsoleMsg(DepositoIndex, Comprador & " te ha comprado a tu personaje " & Chr(34) & NickOfertado & Chr(34) & " a traves del MercadoAO!!", FontTypeNames.FONTTYPE_GUILD)
    '        DepositoGold = UserList(DepositoIndex).Stats.Banco
    '    Else
    '        DepositoGold = Abs(val(GetVar(CharPath & Deposito & ".chr", "STATS", "BANCO")))
    '    End If

    ' @@ Vars
    '    Call WriteVar(CharPath & Comprador & ".chr", "STATS", "BANCO", (tmpGold - Oro))
    '    Call WriteVar(CharPath & NickOfertado & ".chr", "INIT", "ACCOUNT", AccountName)
    '    Call WriteVar(CharPath & NickOfertado & ".chr", "MAO", "MAO_Index", 0)
    '    Call WriteVar(CharPath & NickOfertado & ".chr", "CONTACTO", "Email", GetVar(CharPath & Comprador & ".chr", "CONTACTO", "Email"))
    '    Call WriteVar(CharPath & NickOfertado & ".chr", "INIT", "Password", GetVar(CharPath & Comprador & ".chr", "INIT", "Password"))
    '    Call WriteVar(CharPath & NickOfertado & ".chr", "INIT", "Pin", GetVar(CharPath & Comprador & ".chr", "INIT", "Pin"))

    ' @@ Notifico a la Web
    Call EnviarDatosASlot(UserIndex, 0, True)

    Exit Sub
Errhandler:
    Call LogError("Error en MAO_ComprarPjPorOro en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

