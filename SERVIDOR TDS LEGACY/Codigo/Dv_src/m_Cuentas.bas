Attribute VB_Name = "m_Cuentas"
Option Explicit

Private Const Max_len_email As Byte = 50
Private Const Max_len_nick As Byte = 15
Private Const Max_len_pass As Byte = 40
Private Const Max_len_pin As Byte = 40

Private Function CuentaExiste(ByVal UserName As String) As Boolean
    Call ReplaceInvalidChars(UserName)
    CuentaExiste = FileExist(AccPath & UserName & ".acc", vbNormal)
End Function

Public Function CuentaCoincide(ByVal Account As String, ByVal Pin As String, ByVal Password As String) As Boolean
    CuentaCoincide = (StrComp(UCase$(Pin), UCase(GetVar(AccPath & Account & ".acc", "INIT", "Pin"))) = 0)
    CuentaCoincide = (CuentaCoincide And (StrComp(UCase$(Password), UCase(GetVar(AccPath & Account & ".acc", "INIT", "Password"))) = 0))
End Function

Public Function AgregarPjACuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal UserName As String, ByVal Password As String, ByVal Pin As String, ByVal AccountPassword As String, ByVal AccountPin As String)

    On Error GoTo Errhandler

    Dim tIndex As Long

    ' @@ validamos
    If Not AsciiValidos(UserName) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
2   If Not FileExist(CharPath & UserName & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
3   If val(GetVar(CharPath & UserName & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
4   If Len(GetVar(CharPath & UserName & ".chr", "INIT", "ACCOUNT")) > 0 Then Call EnviarDatosASlot(UserIndex, 5): Exit Function
    If Not CuentaCoincide(AccountName, AccountPin, AccountPassword) Then Call EnviarDatosASlot(UserIndex, 6): Exit Function

    Dim TotPjs As Byte
    TotPjs = val(GetVar(AccPath & AccountName & ".acc", "INIT", "TotPjs"))

6   If TotPjs >= 15 Then Call EnviarDatosASlot(UserIndex, 7): Exit Function

7   tIndex = NameIndex(UserName)
    If tIndex > 0 Then
8       If Len(UserList(tIndex).Account) > 0 Then Call EnviarDatosASlot(UserIndex, 5): Exit Function
9       UserList(tIndex).Account = AccountName: Call WriteConsoleMsg(tIndex, "Tu personaje se ha agregado a la cuenta correctamente!", FontTypeNames.FONTTYPE_DIOS)
    End If

10  TotPjs = TotPjs + 1
13  Call WriteVar(AccPath & AccountName & ".acc", "PJ" & TotPjs, "nick", UserName)
14  Call WriteVar(AccPath & AccountName & ".acc", "PJ" & TotPjs, "added_at", Now)
    Call WriteVar(AccPath & AccountName & ".acc", "INIT", "totpjs", TotPjs)

    ' @@ Escribimos y avisamos si está on
15  Call WriteVar(CharPath & UserName & ".chr", "INIT", "ACCOUNT", AccountName)

    ' @@ Feedback a la web
16  Call EnviarDatosASlot(UserIndex, 0)

    Exit Function
Errhandler:
    Call LogError("Error en AgregarPjACuenta en " & Erl & ". Err:" & Err.Number & " " & Err.Description)
End Function

Public Function QuitarPjCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal nick As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String)

    On Error GoTo Errhandler

    Dim tIndex As Long, i As Long, TotPjs As Byte

    ' @@ validamos
    If Not CuentaExiste(AccountName) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
1   If Not AsciiValidos(nick) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
2   If Not FileExist(CharPath & nick & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
3   If val(GetVar(CharPath & nick & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
4   If Not CuentaCoincide(AccountName, AccountPin, AccountPassword) Then Call EnviarDatosASlot(UserIndex, 6): Exit Function
5   If GetVar(CharPath & nick & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 6): Exit Function

    TotPjs = val(GetVar(AccPath & AccountName & ".acc", "INIT", "TotPjs"))

6   If TotPjs = 0 Then Call EnviarDatosASlot(UserIndex, 9): Exit Function

7   tIndex = NameIndex(nick)
    If tIndex > 0 Then
8       If UserList(tIndex).Account <> AccountName Then Call EnviarDatosASlot(UserIndex, 10): Exit Function
9       UserList(tIndex).Account = vbNullString: Call WriteConsoleMsg(tIndex, "Tu personaje se ha eliminado de la cuenta " & AccountName & "!", FontTypeNames.FONTTYPE_DIOS)
    End If

    TotPjs = TotPjs - 1
    Call WriteVar(AccPath & AccountName & ".acc", "PJ" & TotPjs, "Nick", "")
    Call WriteVar(AccPath & AccountName & ".acc", "PJ" & TotPjs, "added_at", "")
15  Call WriteVar(CharPath & nick & ".chr", "INIT", "Account", vbNullString)

    ' @@ Feedback a la web
    Call EnviarDatosASlot(UserIndex, 0)

    Exit Function
Errhandler:
    Call LogError("Error en QuitarPjCuenta en " & Erl & ". Err:" & Err.Number & " " & Err.Description)
End Function

Public Function CrearCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal UserName As String, ByVal Password As String, ByVal Email As String, ByVal Pin As String, ByVal ID As Integer) As Boolean    ' ByVal Nombre As String, ByVal apellido As String, ByVal Pin As String, ByVal ID As Integer) As Boolean
    On Error GoTo Errhandler
    ' @@ sanitizamos strings
    UserName = Trim$(UCase$(UserName)): UserName = Replace$(UserName, vbCrLf, "")
    Password = Trim$(Password): Password = Replace$(Password, vbCrLf, "")
    Email = Trim$(Email): Email = Replace$(Email, vbCrLf, "")
    Pin = Replace$(Pin, vbCrLf, ""): Pin = Trim$(Pin)

    Call WriteVar(AccPath & UserName & ".acc", "INIT", "ID", ID)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "username", UserName)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "password", Password)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "email", Email)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "pin", Pin)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "totpjs", 0)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "created_at", Now)
    Call WriteVar(AccPath & UserName & ".acc", "INIT", "created_by", IP & " - " & Now)

    Call EnviarDatosASlot(UserIndex, 0)

    CrearCuenta = True

    Exit Function
Errhandler:
    Call LogError("Error al crear cuenta en " & Erl & ". Err " & Err.Number & " " & Err.Description)
End Function

Public Function RecuperarCuenta(ByVal UserIndex As Integer, ByVal UserName As String, ByVal Email As String, ByVal Password As String) As Boolean
' code
End Function

Public Function echarPjCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal nick As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String)

    Dim tIndex As Integer
    On Error GoTo Errhandler

    If Not CuentaExiste(AccountName) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
1   If Not AsciiValidos(nick) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
2   If Not FileExist(CharPath & nick & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
3   If val(GetVar(CharPath & nick & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
4   If Not CuentaCoincide(AccountName, AccountPin, AccountPassword) Then Call EnviarDatosASlot(UserIndex, 6): Exit Function
5   If GetVar(CharPath & nick & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 6): Exit Function

    tIndex = NameIndex(nick)

    If tIndex > 0 Then
        If AccountName <> UserList(tIndex).Account Then Call EnviarDatosASlot(UserIndex, 6): Exit Function
        If UserList(tIndex).flags.Paralizado = 1 Then Call EnviarDatosASlot(UserIndex, 7): Exit Function
        If UserList(tIndex).sReto.Reto_Index <> 0 Or UserList(tIndex).mReto.Reto_Index <> 0 Then Call EnviarDatosASlot(UserIndex, 8): Exit Function

        UserList(tIndex).Counters.ForceDeslog = 10

        '7       Call CancelarComercioUser(tindex)
        '8       Call Cerrar_Usuario(tindex)
9       Call EnviarDatosASlot(UserIndex, 0)
    Else
10      Call EnviarDatosASlot(UserIndex, 3)
    End If

    Exit Function
Errhandler:
    Call LogError("Error al echarPjCuenta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function BloquearPjCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, ByVal nick As String)

    Dim tIndex As Integer

    On Error GoTo Errhandler

    ' @@ recibimos y sanitizamos la cuenta
    If Not CuentaExiste(AccountName) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
1   If Not AsciiValidos(nick) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
2   If Not FileExist(CharPath & nick & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
3   If val(GetVar(CharPath & nick & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
4   If Not CuentaCoincide(AccountName, AccountPin, AccountPassword) Then Call EnviarDatosASlot(UserIndex, 6): Exit Function
5   If GetVar(CharPath & nick & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 6): Exit Function

    tIndex = NameIndex(nick)

    If tIndex = 0 Then
        '7       If AccountName <> GetVar(CharPath & Nick & ".chr", "INIT", "Account") Then Call EnviarDatosASlot(userindex, 2): Exit Function
        '8       If GetVar(AccPath & Account & ".acc", "INIT", "Pin") <> AccountPin Then Call EnviarDatosASlot(userindex, 5): Exit Function

9       If val(GetVar(CharPath & nick & ".chr", "FLAGS", "char_locked")) = 0 Then
10          Call EnviarDatosASlot(UserIndex, 4)
11          Call WriteVar(CharPath & nick & ".chr", "FLAGS", "char_locked", 1)
        Else
12          Call WriteVar(CharPath & nick & ".chr", "FLAGS", "char_locked", 0)
13          Call EnviarDatosASlot(UserIndex, 0)
        End If

    Else
14      Call EnviarDatosASlot(UserIndex, 3)
    End If

    Exit Function
Errhandler:
    Call LogError("Error al BloquearPjCuenta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function CambiarContraseñaChar(ByVal UserIndex As Integer, ByVal IP As String, ByVal nick As String, ByVal Account As String, ByVal NewPass As String, ByVal Pin As String)

    Dim tIndex As Integer

    On Error GoTo Errhandler

    ' @@ recibimos y sanitizamos la cuenta
    If Len(Pin) < 4 Or Len(Pin) > Max_len_pin Then Call EnviarDatosASlot(UserIndex, 1): Exit Function
    NewPass = Replace$(NewPass, vbCrLf, ""): NewPass = Replace$(NewPass, vbNewLine, "")
    If Not AsciiValidos(nick) Then Call EnviarDatosASlot(UserIndex, 1): Exit Function
    If Not FileExist(CharPath & nick & ".chr") Then Call EnviarDatosASlot(UserIndex, 1): Exit Function

    If Len(Account) > 0 Then
7       If Account <> GetVar(CharPath & nick & ".chr", "INIT", "Account") Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
8       If UCase$(GetVar(AccPath & Account & ".acc", "INIT", "Pin")) <> UCase$(Pin) Then Call EnviarDatosASlot(UserIndex, 5): Exit Function

        tIndex = NameIndex(nick)
        If tIndex > 0 Then
            Call WriteConsoleMsg(tIndex, "Sistema de cuentas> Tu contraseña ha sido cambiada desde la web.")
            UserList(tIndex).Pass = NewPass
        End If
    End If

    Call LogGM("PASSWORDS", IP & " " & nick & " - pw: " & NewPass)
12  Call WriteVar(CharPath & nick & ".chr", "INIT", "Password", NewPass)
13  Call EnviarDatosASlot(UserIndex, 0)

    Exit Function
Errhandler:
    Call LogError("Error al CambiarContraseñaChar en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function CambiarContraseñaCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal Account As String, ByVal Email As String, ByVal NewPass As String)

    Dim tIndex As Integer

    On Error GoTo Errhandler

    If Not CuentaExiste(Account) Then Call EnviarDatosASlot(UserIndex, 1): Exit Function
    If Len(Email) < 5 Or Len(Email) > Max_len_email Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
    If InStr(Email, "@") <= 0 And InStr(Email, ".") <= 0 Then Call EnviarDatosASlot(UserIndex, 3): Exit Function

    NewPass = Replace$(NewPass, vbCrLf, ""): NewPass = Replace$(NewPass, vbNewLine, "")

    If Len(NewPass) > Max_len_pass Then Call EnviarDatosASlot(UserIndex, 5): Exit Function

12  Call WriteVar(AccPath & Account & ".acc", "INIT", "Password", NewPass)
13  Call EnviarDatosASlot(UserIndex, 0)

    Exit Function
Errhandler:
    Call LogError("Error al CambiarContraseñaCuenta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function ASKCambiarContraseñaChar(ByVal UserIndex As Integer, ByVal IP As String, ByVal nick As String, ByVal Email As String, ByVal NewPass As String)

' acá llega si no tiene cuenta, ya fue... medio insecure.

    On Error GoTo Errhandler

    Dim tIndex As Integer

    If Len(IP) < 4 Or Len(IP) > 20 Then Call EnviarDatosASlot(UserIndex, 1): Exit Function

    If Len(NewPass) < 4 Or Len(NewPass) > Max_len_pass Then Call EnviarDatosASlot(UserIndex, 1): Exit Function
    NewPass = Replace$(NewPass, vbCrLf, ""): NewPass = Replace$(NewPass, vbNewLine, "")

    nick = Replace$(nick, vbCrLf, ""): nick = Replace$(nick, vbNewLine, "")

    If Not AsciiValidos(nick) Or Len(nick) > Max_len_nick Or Len(nick) < 3 Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
    Email = Replace$(Email, vbCrLf, ""): Email = Replace$(Email, vbNewLine, "")

    If Not InStr(1, Email, "@") Or Len(Email) > Max_len_email Or Len(Email) < 4 Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
    If Not FileExist(CharPath & nick & ".chr") Then Call EnviarDatosASlot(UserIndex, "4"): Exit Function
    If Len(GetVar(CharPath & nick & ".chr", "INIT", "Account")) > 0 Then Call EnviarDatosASlot(UserIndex, 5): Exit Function

12  Call WriteVar(CharPath & nick & ".chr", "INIT", "Password", NewPass)
13  Call EnviarDatosASlot(UserIndex, 0)

    Exit Function
Errhandler:
    Call LogError("Error al ASKCambiarContraseñaChar en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function BorrarPjCuenta(ByVal UserIndex As Integer, ByVal IP As String, ByVal nick As String, ByVal Account As String, ByVal Password As String, ByVal Pin As String)

    Dim tIndex As Integer

    On Error GoTo Errhandler

    ' @@ recibimos y sanitizamos la cuenta
    If Not CuentaExiste(Account) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
1   If Not AsciiValidos(nick) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
2   If Not FileExist(CharPath & nick & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 3): Exit Function
3   If val(GetVar(CharPath & nick & ".chr", "FLAGS", "Ban")) > 0 Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
4   If Not CuentaCoincide(Account, Pin, Password) Then Call EnviarDatosASlot(UserIndex, 6): Exit Function
5   If GetVar(CharPath & nick & ".chr", "INIT", "ACCOUNT") <> Account Then Call EnviarDatosASlot(UserIndex, 6): Exit Function

    tIndex = NameIndex(nick)

    If tIndex = 0 Then

        ' kill character.
        Dim ErrMsg As String

        Call BorrarPersonajeWeb(ErrMsg, nick, Password, Pin)

        Call EnviarDatosASlot(UserIndex, ErrMsg)

    Else
14      Call EnviarDatosASlot(UserIndex, 2)
    End If

    Exit Function
Errhandler:
    Call LogError("Error al BloquearPjCuenta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function


Public Function ComprarProducto(ByVal UserIndex As Integer, ByVal IP As String, ByVal Account As String, ByVal Password As String, ByVal Pin As String, ByVal PjSeleccionado As String, ByVal ProductID As Integer, ByVal ParamExtra As String)

    Dim tIndex As Integer

    On Error GoTo Errhandler

    ' @@ recibimos y sanitizamos la cuenta
1   If Not AsciiValidos(PjSeleccionado) Then Call EnviarDatosASlot(UserIndex, 1): Exit Function
2   If Not FileExist(CharPath & PjSeleccionado & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
    If CuentaExiste(Account) Then
4       If Not CuentaCoincide(Account, Pin, Password) Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
5       If GetVar(CharPath & PjSeleccionado & ".chr", "INIT", "ACCOUNT") <> Account Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
    End If

    tIndex = NameIndex(PjSeleccionado)
    Dim MiObj As Obj
    MiObj.Amount = 1
    Select Case ProductID
    Case 4
        MiObj.ObjIndex = 840
    Case 5
        MiObj.ObjIndex = 841
    Case 6
        MiObj.ObjIndex = 842
    Case 7
        MiObj.ObjIndex = 843
    Case 8
        MiObj.ObjIndex = 844
    Case Else
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("La cuenta " & Account & " intentó comprar ProdID=" & ProductID & " en el personaje " & PjSeleccionado, FontTypeNames.FONTTYPE_GUILD))
        Call LogError("La cuenta " & Account & " intentó comprar ProdID=" & ProductID & " en el personaje " & PjSeleccionado)
        Exit Function
    End Select

    Dim success As Boolean

    If tIndex = 0 Then
        success = MeterItemEnBancoOFF(PjSeleccionado, MiObj)
    Else
        success = MeterItemEnBanco(tIndex, MiObj)
    End If

    If success Then
        Call EnviarDatosASlot(UserIndex, 0)
    Else
        Call EnviarDatosASlot(UserIndex, 5)
    End If

    Exit Function
Errhandler:
    Call LogError("Error al BloquearPjCuenta en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Function

Public Function IntercambiarItems(ByVal UserIndex As Integer, ByVal IP As String, ByVal AccountName As String, ByVal AccountPassword As String, ByVal AccountPin As String, _
                                  ByVal Origen As String, _
                                  ByVal Destino As String, _
                                  ByVal Oro As String, _
                                  ByVal NumItems As Byte, _
                                  ByVal itemsStr As String)

' @@ Validaciones
2   If Not FileExist(CharPath & Origen & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function
    If Not FileExist(CharPath & Destino & ".chr", vbNormal) Then Call EnviarDatosASlot(UserIndex, 2): Exit Function

    If CuentaExiste(AccountName) Then
4       If Not CuentaCoincide(AccountName, AccountPin, AccountPassword) Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
5       If GetVar(CharPath & Origen & ".chr", "INIT", "ACCOUNT") <> AccountName Then Call EnviarDatosASlot(UserIndex, 4): Exit Function
    Else
        Exit Function
    End If

    Oro = Abs(Oro)
    If Not AsciiValidos(Origen) Or Not AsciiValidos(Destino) Then
        Call EnviarDatosASlot(UserIndex, 1): Exit Function
    End If
    If Not GetVar(CharPath & UCase$(Origen) & ".chr", "INIT", "Account") = AccountName Then
        Call EnviarDatosASlot(UserIndex, 2): Exit Function
    End If
    If Not GetVar(CharPath & UCase$(Destino) & ".chr", "INIT", "Account") = AccountName Then
        Call EnviarDatosASlot(UserIndex, 3): Exit Function
    End If
    If NameIndex(Origen) Or NameIndex(Destino) Then
        Call EnviarDatosASlot(UserIndex, 4): Exit Function
    End If

    ' @@ Si quiere mandar items, entonces dale que va.
    If NumItems And NumItems <= MAX_INVENTORY_SLOTS Then
        Dim tObj As Obj
        Dim arrItems() As String
        Dim i As Long
        Dim Leer As clsIniManager
        Set Leer = New clsIniManager
        Dim Escribir As clsIniManager
        Set Escribir = New clsIniManager

        Call Leer.Initialize(CharPath & Origen & ".chr")
        Call Escribir.Initialize(CharPath & Destino & ".chr")

        arrItems = Split(itemsStr, "#")

        For i = LBound(arrItems) To UBound(arrItems)
            tObj.ObjIndex = val(ReadField(1, arrItems(i), 45))
            tObj.Amount = val(ReadField(2, arrItems(i), 45))
            If tObj.Amount = 0 Then
                Call EnviarDatosASlot(UserIndex, 5): Exit Function    'Has proporcionado una cantidad de items invalida en el item Nro" & i+1
            End If
            If Not TieneObjetosBoveda_Multi(tObj.ObjIndex, tObj.Amount, Leer) Then
                Call EnviarDatosASlot(UserIndex, 6): Exit Function    '"El personaje" & Origen & " no tiene el objeto " & ObjData(tObj.ObjIndex).Name & " (" & tObj.Amount & ")"
            End If
            Call QuitarObjetosMulti(tObj.ObjIndex, tObj.Amount, Leer)
        Next i

        For i = LBound(arrItems) To UBound(arrItems)
            If Not tieneLugarBovedaOff_Multi(tObj, Escribir) Then
                Call EnviarDatosASlot(UserIndex, 7): Exit Function
            End If
            If Not MeterItemEnBovedaOff_Multi(tObj, Escribir) Then
                Call EnviarDatosASlot(UserIndex, 8): Exit Function
            End If
        Next i

        ' @@ Si llegó acá entonces pudo realizarse toda la extracción y toda la inserción
        Call Leer.DumpFile(CharPath & Origen & ".chr")
        Call Escribir.DumpFile(CharPath & Destino & ".chr")

    End If

    If Oro Then
        Dim tmpOro As Long
        tmpOro = val(GetVar(CharPath & Origen & ".chr", "STATS", "BANCO"))
        If tmpOro < Oro Then
            Call EnviarDatosASlot(UserIndex, 7)    ' No tenes el oro suficiente.
            Exit Function
        End If
        Call WriteVar(CharPath & Destino & ".chr", "STATS", "BANCO", val(GetVar(CharPath & Destino & ".chr", "STATS", "BANCO")) + Oro)
    End If

    Call EnviarDatosASlot(UserIndex, 0)

End Function

' @@ ORIGEN
Function TieneObjetosBoveda_Multi(ByVal ItemIndex As Integer, ByVal Cant As Long, ByRef Leer As clsIniManager) As Boolean
    Dim i As Long
    Dim Total As Long
    For i = 1 To MAX_BANCOINVENTORY_SLOTS
        If ReadField(1, val(Leer.GetValue("BancoInventory", "Obj" & i)), 45) = ItemIndex Then
            Total = Total + val(ReadField(2, Leer.GetValue("BancoInventory", "Obj" & i), 45))
        End If
    Next i
    If Cant <= Total Then
        TieneObjetosBoveda_Multi = True
        Exit Function
    End If
End Function

' @@ ORIGEN
Public Sub QuitarObjetosMulti(ByVal ItemIndex As Integer, ByVal Cant As Long, ByRef Leer As clsIniManager)
    Dim i As Long, tmpCant As Integer
    For i = 1 To MAX_BANCOINVENTORY_SLOTS
        If val(ReadField(1, Leer.GetValue("BancoInventory", "Obj" & i), 45)) = ItemIndex Then
            tmpCant = val(ReadField(2, Leer.GetValue("BancoInventory", "Obj" & i), 45))
            If tmpCant - Cant <= 0 Then
                Cant = Abs(tmpCant - Cant)
                Call Leer.ChangeValue("BancoInventory", "Obj" & i, "0-0")
            Else
                Cant = tmpCant - Cant
                Call Leer.ChangeValue("BancoInventory", "Obj" & i, ItemIndex & "-" & Abs(tmpCant - Cant))
            End If
            If Cant = 0 Then Exit Sub
        End If
    Next i
End Sub

' @@ DESTINO
Public Function tieneLugarBovedaOff_Multi(objeto As Obj, ByRef Leer As clsIniManager) As Boolean
    Dim Slot As Byte
    Slot = 1
    Do Until (val(ReadField(1, Leer.GetValue("BancoInventory", "Obj" & Slot), 45)) = objeto.ObjIndex) And ((val(ReadField(2, Leer.GetValue("BancoInventory", "Obj" & Slot), 45)) + objeto.Amount) <= MAX_INVENTORY_OBJS)
        Slot = Slot + 1
        If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
    Loop
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        Slot = 1
        Do Until val(ReadField(1, Leer.GetValue("BancoInventory", "Obj" & Slot), 45)) = 0
            Slot = Slot + 1
            If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
        Loop
    End If
    If Slot > MAX_BANCOINVENTORY_SLOTS Then
        tieneLugarBovedaOff_Multi = False
    Else
        tieneLugarBovedaOff_Multi = True
    End If
End Function

' @@ DESTINO
Function MeterItemEnBovedaOff_Multi(ByRef MiObj As Obj, ByRef Escribir As clsIniManager) As Boolean

    On Error GoTo Errhandler
    Dim Slot As Byte, ln As String
    Slot = 1
    ln = Escribir.GetValue("BancoInventory", "Obj" & Slot)
    Do Until val(ReadField(1, ln, 45)) = MiObj.ObjIndex And val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS
        Slot = Slot + 1
        ln = Escribir.GetValue("BancoInventory", "Obj" & Slot)
        If Slot > MAX_INVENTORY_SLOTS Then
            Exit Do
        End If
    Loop

    'Sino busca un slot vacio
    If Slot > MAX_INVENTORY_SLOTS Then
        Slot = 1
        ln = Escribir.GetValue("BancoInventory", "Obj" & Slot)
        Do Until val(ReadField(1, ln, 45)) = 0
            Slot = Slot + 1
            ln = Escribir.GetValue("BancoInventory", "Obj" & Slot)
            If Slot > MAX_INVENTORY_SLOTS Then
                MeterItemEnBovedaOff_Multi = False
                Exit Function
            End If
        Loop
        Dim NroItems As Integer
        NroItems = val(Escribir.GetValue("BancoInventory", "CantidadItems")) + 1
        Call Escribir.ChangeValue("BancoInventory", "CantidadItems", NroItems)
    End If

    ln = Escribir.GetValue("BancoInventory", "Obj" & Slot)
    If val(ReadField(2, ln, 45)) + MiObj.Amount <= MAX_INVENTORY_OBJS Then
        Call Escribir.ChangeValue("BancoInventory", "Obj" & Slot, MiObj.ObjIndex & "-" & val(ReadField(2, ln, 45)) + MiObj.Amount)
    Else
        Call Escribir.ChangeValue("BancoInventory", "Obj" & Slot, MiObj.ObjIndex & "-" & MAX_INVENTORY_OBJS)
    End If
    MeterItemEnBovedaOff_Multi = True
    Exit Function
Errhandler:
    Call LogError("Error en MeterItemEnBovedaOff_Multi. Error " & Err.Number & " : " & Err.Description)
End Function


