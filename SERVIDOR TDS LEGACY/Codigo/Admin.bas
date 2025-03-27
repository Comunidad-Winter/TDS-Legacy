Attribute VB_Name = "Admin"
Option Explicit

Public Type tAPuestas
    Ganancias As Long
    Perdidas As Long
    Jugadas As Long
End Type
Public Apuestas As tAPuestas

Public tInicioServer As Long

'INTERVALOS
Public SanaIntervaloSinDescansar As Integer
Public StaminaIntervaloSinDescansar As Integer
Public SanaIntervaloDescansar As Integer
Public StaminaIntervaloDescansar As Integer
Public IntervaloSed As Integer
Public IntervaloHambre As Integer
Public IntervaloVeneno As Integer
Public IntervaloParalizado As Integer
Public IntervaloInvisible As Integer
Public IntervaloFrio As Integer
Public IntervaloWavFx As Integer

Public IntervaloNPCPuedeAtacar As Integer
Public IntervaloNPCAI As Integer
Public IntervaloInvocacion As Long

Public IntervaloInvocacionFuego As Long
Public IntervaloInvocacionTierra As Long
Public IntervaloInvocacionAgua As Long

Public IntervaloOculto As Long        '[Nacho]

Public IntervaloParaConexion As Long
Public IntervaloCerrarConexion As Long        '[Gonzalo]

Public IntervaloPuedeSerAtacado As Long
Public IntervaloOwnedNpc As Long

Public Const IntervaloParalizadoReducido As Byte = 5

Public MinutosWs As Long
Public Puerto As Integer
Public PuertoWEB As Integer

Public BootDelBackUp As Byte
Public Lloviendo As Boolean
Public DeNoche As Boolean

Public IP_Blacklist As New Dictionary

Public Sub LoadRates()
    ratePesca = val(GetVar(IniPath & "Server.ini", "RATES", "Pesca"))
    rateTala = val(GetVar(IniPath & "Server.ini", "RATES", "Tala"))
    rateConstruccion = val(GetVar(IniPath & "Server.ini", "RATES", "Construccion"))

End Sub

Public Sub CargarListaNegraUsuarios()

    On Error GoTo CargarListaNegraUsuarios_Err

    Dim File As clsIniManager
    Dim i As Long
    Dim iKey As String
    Dim iValue As String

100 If Not FileExist(App.path & "/Dat/Baneos.dat") Then Exit Sub

102 Set File = New clsIniManager
104 Call File.Initialize(App.path & "/Dat/Baneos.dat")

    Call IP_Blacklist.RemoveAll
    ' IP's
108 For i = 0 To File.EntriesCount("IP") - 1
110     Call File.GetPair("IP", i, iKey, iValue)
        If Not IP_Blacklist.Exists(iKey) Then
112         Call IP_Blacklist.Add(iKey, iValue)
        End If
    Next

    Exit Sub

CargarListaNegraUsuarios_Err:
    Set File = Nothing
    Call LogError("Admin.CargarListaNegraUsuarios en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub BanearIP(ByVal BannerIndex As Integer, ByVal UserName As String, ByVal IP As String)
    On Error GoTo BanearIP_Err

    #If STRESSER = 1 Then
        Exit Sub
    #End If
    ' Lo guardo en Baneos.dat
100 Call WriteVar(DatPath & "Baneos.dat", "IP", IP, UserName)

    If LenB(UserName) > 0 Then

        Dim tIndex As Integer
        tIndex = NameIndex(UserName)

        If tIndex > 0 Then
            UserList(tIndex).flags.Ban = 1
            Call WriteErrorMsg(tIndex, "Has sido baneado por el Sistema #.")
            Call CloseSocket(tIndex)
        End If

        Call WriteVar(CharPath & UserList(tIndex).Name & ".chr", "PENAS", "BanMotivo", "SERVIDOR: BAN POR IP " & Date & " " & Time)

    End If

    ' Lo guardo en memoria.
102 Call IP_Blacklist.Add(IP, UserName)


    Exit Sub

BanearIP_Err:
    Call LogError("Admin.BanearIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub DesbanearIP(ByVal IP As String, ByVal UnbannerIndex As Integer)
    On Error GoTo DesbanearIP_Err

    ' Lo saco de la memoria.
100 If IP_Blacklist.Exists(IP) Then Call IP_Blacklist.Remove(IP)

    ' Lo saco del archivo.
102 Call WriteVar(DatPath & "Baneos.dat", "IP", IP, vbNullString)

    ' Registramos el des-baneo en los logs.

    Exit Sub

DesbanearIP_Err:
    Call LogError("Admin.DesbanearIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub
Private Function GlobalChecks(ByVal BannerIndex As Integer, ByRef UserName As String) As Integer

    On Error GoTo GlobalChecks_Err

    Dim TargetIndex As Integer

100 GlobalChecks = False

102 If Not EsGM(BannerIndex) Then Exit Function

    ' Parseo los espacios en el Nick
104 If InStrB(UserName, "+") Then
106     UserName = Replace(UserName, "+", " ")
    End If

108 TargetIndex = NameIndex(UserName)

110 If TargetIndex Then

112     If TargetIndex = BannerIndex Then
114         Call WriteConsoleMsg(BannerIndex, "No podes banearte a vos mismo.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

        ' Estas tratando de banear a alguien con mas privilegios que vos, no va a pasar bro.
116     If CompararUserPrivilegios(TargetIndex, BannerIndex) >= 0 Then
118         Call WriteConsoleMsg(BannerIndex, "No podes banear a al alguien de igual o mayor jerarquia.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

    Else

120     If CompararPrivilegios(UserDarPrivilegioLevel(UserName), UserList(BannerIndex).flags.Privilegios) >= 0 Then
122         Call WriteConsoleMsg(BannerIndex, "No podes banear a al alguien de igual o mayor jerarquia.", FontTypeNames.FONTTYPE_INFO)
            Exit Function
        End If

    End If

    ' Se llegó hasta acá, todo bien!
124 GlobalChecks = True


    Exit Function

GlobalChecks_Err:
    Call LogError("Admin.GlobalChecks en " & Erl & ". err: " & Err.Number & " " & Err.Description)


End Function

Public Function UserDarPrivilegioLevel(ByVal Name As String) As PlayerType
    On Error GoTo UserDarPrivilegioLevel_Err

100 If EsAdmin(Name) Then
102     UserDarPrivilegioLevel = PlayerType.Admin
104 ElseIf EsDios(Name) Then
106     UserDarPrivilegioLevel = PlayerType.Dios
108 ElseIf EsSemiDios(Name) Then
110     UserDarPrivilegioLevel = PlayerType.SemiDios
112 ElseIf EsConsejero(Name) Then
114     UserDarPrivilegioLevel = PlayerType.Consejero
    Else
116     UserDarPrivilegioLevel = PlayerType.User

    End If

    Exit Function

UserDarPrivilegioLevel_Err:
118 Call LogError("Admin.UserDarPrivilegioLevel en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Public Function CompararUserPrivilegios(ByVal Personaje_1 As Integer, ByVal Personaje_2 As Integer) As Integer

100 CompararUserPrivilegios = CompararPrivilegios(UserList(Personaje_1).flags.Privilegios, UserList(Personaje_2).flags.Privilegios)

End Function

Public Function CompararPrivilegiosUser(ByVal Personaje_1 As Integer, ByVal Personaje_2 As Integer) As Integer
    On Error GoTo CompararPrivilegiosUser_Err
100 CompararPrivilegiosUser = CompararPrivilegios(UserList(Personaje_1).flags.Privilegios, UserList(Personaje_2).flags.Privilegios)
    Exit Function
CompararPrivilegiosUser_Err:
102 Call LogError("Admin.CompararPrivilegiosUser en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Public Function CompararPrivilegios(ByVal Izquierda As PlayerType, ByVal Derecha As PlayerType) As Integer
    On Error GoTo CompararPrivilegios_Err

    Dim PrivilegiosGM As PlayerType
100 PrivilegiosGM = PlayerType.Admin Or PlayerType.Dios Or PlayerType.SemiDios Or PlayerType.Consejero Or PlayerType.RoleMaster

    ' Obtenemos el rango de los 2 personajes.
102 Izquierda = (Izquierda And PrivilegiosGM)
104 Derecha = (Derecha And PrivilegiosGM)

106 Select Case Izquierda

    Case Is > Derecha
108     CompararPrivilegios = 1

110 Case Is = Derecha
112     CompararPrivilegios = 0

114 Case Is < Derecha
116     CompararPrivilegios = -1

    End Select


    Exit Function

CompararPrivilegios_Err:
118 Call LogError("Admin.CompararPrivilegios en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Function VersionOK(ByVal Ver As String) As Boolean
    VersionOK = (Ver = ULTIMAVERSION)
End Function

Sub ReSpawnOrigPosNpcs()

    On Error Resume Next

    Dim i As Integer
    Dim MiNPC As npc

    For i = 1 To LastNPC
        'OJO
        If Npclist(i).flags.NPCActive Then

            If InMapBounds(Npclist(i).Orig.map, Npclist(i).Orig.X, Npclist(i).Orig.Y) And Npclist(i).Numero = Guardias Then
                MiNPC = Npclist(i)
                Call QuitarNPC(i)
                Call ReSpawnNpc(MiNPC)
            End If

            'tildada por sugerencia de yind
            'If Npclist(i).Contadores.TiempoExistencia > 0 Then
            '        Call MuereNpc(i, 0)
            'End If
        End If

    Next i

End Sub

Sub WorldSave()
    On Error Resume Next

    Call SendData(SendTarget.ToAll, 0, PrepareMessageMensaje(e_Mensajes.Mensaje_30))

    Call ReSpawnOrigPosNpcs

    Call SendData(SendTarget.ToAll, 0, PrepareMessageMensaje(e_Mensajes.Mensaje_31))

End Sub

Public Sub PurgarPenas()
    Dim i As Long

    For i = 1 To LastUser
        If UserList(i).flags.UserLogged Then
            If UserList(i).Counters.Pena > 0 Then
                UserList(i).Counters.Pena = UserList(i).Counters.Pena - 1

                If UserList(i).Counters.Pena < 1 Then
                    UserList(i).Counters.Pena = 0
                    Call WarpUserCharX(i, Libertad.map, Libertad.X, Libertad.Y, True)
                    Call WriteMensajes(i, e_Mensajes.Mensaje_32)
                End If
            End If
        End If
    Next i
End Sub


Public Sub Encarcelar(ByVal UserIndex As Integer, ByVal Minutos As Long, Optional ByVal GmName As String = vbNullString)
    UserList(UserIndex).Counters.Pena = Minutos
    Call WarpUserCharX(UserIndex, Prision.map, Prision.X, Prision.Y, True)

    If LenB(GmName) = 0 Then
        Call WriteConsoleMsg(UserIndex, "Has sido encarcelado, deberás permanecer en la cárcel " & Minutos & " minutos.", FontTypeNames.FONTTYPE_INFO)
    Else
        Call WriteConsoleMsg(UserIndex, GmName & " te ha encarcelado, deberás permanecer en la cárcel " & Minutos & " minutos.", FontTypeNames.FONTTYPE_INFO)
    End If
End Sub


'Public Sub BorrarUsuario(ByVal UserName As String)
'    On Error Resume Next
'    If FileExist(CharPath & UCase$(UserName) & ".chr", vbNormal) Then
'        Kill CharPath & UCase$(UserName) & ".chr"
'    End If
'End Sub

Public Function BANCheck(ByVal Name As String) As Boolean
    On Error GoTo BANCheck_Err

    BANCheck = (val(GetVar(App.path & "\charfile\" & Name & ".chr", "FLAGS", "Ban")) = 1)
    'BANCheck = BANCheckDatabase(name)
    Exit Function

BANCheck_Err:
106 Call LogError("Admin.BANCheck " & Err.Number & " en linea " & Erl & " " & Err.Description)
End Function

Public Function PersonajeExiste(ByVal Name As String) As Boolean
    On Error GoTo PersonajeExiste_Err

    If InStr(1, Name, "*") Or Not AsciiValidos(Name) Then
        Call LogError("Admin.PersonajeExiste - NICK INVALIDO: " & Name)
        Exit Function
    End If

    PersonajeExiste = FileExist(CharPath & UCase$(Name) & ".chr", vbNormal)
    'PersonajeExiste = GetUserValue(LCase$(name), "COUNT(*)") > 0

    Exit Function

PersonajeExiste_Err:
106 Call LogError("Admin.PersonajeExiste " & Err.Number & " en linea " & Erl & " " & Err.Description)
End Function

Public Function UnBan(ByVal Name As String, Optional ByVal from As String = "NOBODY") As Boolean
    On Error GoTo UnBan_Err
    Call WriteVar(App.path & "\charfile\" & Name & ".chr", "FLAGS", "Ban", "0")
    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", Name, "BannedBy", from)
    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", Name, "Reason", "-unbanned-")
    Call WEB_Update_UserName(Name)
    Exit Function

UnBan_Err:
106 Call LogError("Admin.PersonajeExiste " & Err.Number & " en linea " & Erl & " " & Err.Description)
End Function

Public Function MD5ok(ByVal md5formateado As String) As Boolean
    Dim i As Integer

    If MD5ClientesActivado = 1 Then
        For i = 0 To UBound(MD5s)
            If (md5formateado = MD5s(i)) Then
                MD5ok = True
                Exit Function
            End If
        Next i
        MD5ok = False
    Else
        MD5ok = True
    End If

End Function

Public Sub MD5sCarga()

    Dim LoopC As Integer

    MD5ClientesActivado = val(GetVar(IniPath & "Server.ini", "MD5Hush", "Activado"))

    If MD5ClientesActivado = 1 Then
        ReDim MD5s(val(GetVar(IniPath & "Server.ini", "MD5Hush", "MD5Aceptados")))
        For LoopC = 0 To UBound(MD5s)
            MD5s(LoopC) = GetVar(IniPath & "Server.ini", "MD5Hush", "MD5Aceptado" & (LoopC + 1))
            MD5s(LoopC) = txtOffset(hexMd52Asc(MD5s(LoopC)), 55)
        Next LoopC
    End If

End Sub

Public Function PrivilegioNickName(ByVal Name As String) As PlayerType

    If EsAdmin(Name) Then
        PrivilegioNickName = PlayerType.Admin
    ElseIf EsDios(Name) Then
        PrivilegioNickName = PlayerType.Dios
    ElseIf EsSemiDios(Name) Then
        PrivilegioNickName = PlayerType.SemiDios
    ElseIf EsConsejero(Name) Then
        PrivilegioNickName = PlayerType.Consejero
    Else
        PrivilegioNickName = PlayerType.User
    End If
End Function

Public Sub BanCharacter(ByVal bannerUserIndex As Integer, ByVal UserName As String, ByVal Reason As String)

    Dim tUser As Integer
    Dim userPriv As Byte
    Dim CantPenas As Byte

    If InStrB(UserName, "+") Then
        UserName = Replace(UserName, "+", " ")
    End If

    tUser = NameIndex(UserName)

    With UserList(bannerUserIndex)
        If tUser <= 0 Then
            'WriteMensajes bannerUserIndex, e_Mensajes.Mensaje_59

            If FileExist(CharPath & UserName & ".chr", vbNormal) Then
                userPriv = PrivilegioNickName(UserName)

                If userPriv > .flags.Privilegios Then
                    WriteMensajes bannerUserIndex, e_Mensajes.Mensaje_71
                Else
                    If GetVar(CharPath & UserName & ".chr", "FLAGS", "Ban") <> "0" Then
                        WriteMensajes bannerUserIndex, e_Mensajes.Mensaje_72
                    Else

                        If LCase$(UserName) = LCase(.Name) Then Exit Sub

                        Call LogBanFromName(UserName, bannerUserIndex, Reason)
                        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & .Name & " ha baneado a " & UserName & ".", FontTypeNames.FONTTYPE_SERVER))

                        'ponemos el flag de ban a 1
                        Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
                        'ponemos la pena
                        CantPenas = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))
                        Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CantPenas + 1)
                        Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & CantPenas + 1, LCase$(.Name) & ": BAN POR " & LCase$(Reason) & " " & Date & " " & Time)

                        If (userPriv) = (.flags.Privilegios) Then
                            .flags.Ban = 1
                            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "BanMotivo", LCase$(Reason) & "(GM: " & LCase$(.Name) & ") " & Date & " " & Time)

                            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " banned by the server por bannear un Administrador.", FontTypeNames.FONTTYPE_FIGHT))
                            Call CloseSocket(bannerUserIndex)
                        End If
                        Call LogGM(.Name, "BAN a " & UserName)
                    End If
                End If
            Else
                Call WriteConsoleMsg(bannerUserIndex, "El pj " & UserName & " no existe.", FontTypeNames.FONTTYPE_INFO)
            End If
        Else
            If UserList(tUser).flags.Privilegios > .flags.Privilegios Then
                WriteMensajes bannerUserIndex, e_Mensajes.Mensaje_71
            End If

            If LCase$(UserName) = LCase(.Name) Then Exit Sub

            Call LogBan(tUser, bannerUserIndex, Reason)
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & .Name & " ha baneado a " & UserList(tUser).Name & ".", FontTypeNames.FONTTYPE_SERVER))

            'Ponemos el flag de ban a 1
            UserList(tUser).flags.Ban = 1
            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "BanMotivo", LCase$(Reason) & " (GM: " & LCase$(.Name) & ") " & Date & " " & Time)

            If UserList(tUser).flags.Privilegios = .flags.Privilegios Then
                .flags.Ban = 1
                Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " banned by the server por banear un Administrador.", FontTypeNames.FONTTYPE_FIGHT))
                Call CloseSocket(bannerUserIndex)
            End If

            Call LogGM(.Name, "BAN a " & UserName)
            Call CloseSocket(tUser)

            'ponemos el flag de ban a 1
            Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
            'ponemos la pena
            CantPenas = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))
            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CantPenas + 1)
            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & CantPenas + 1, LCase$(.Name) & ": BAN POR " & LCase$(Reason) & " " & Date & " " & Time)

        End If
    End With

    Call WEB_Update_UserName(UserName)

End Sub

Public Function CleanString(s As String) As String
    Dim i As Integer
    Dim newString As String
    newString = ""
    Dim firstIndex As Integer
    firstIndex = InStr(s, "~")
    Dim lastIndex As Integer
    lastIndex = InStrRev(s, "~")
    If firstIndex > 0 And lastIndex > 0 Then
        newString = mid(s, 1, firstIndex - 1) + mid(s, lastIndex + 1)
    Else
        newString = s
    End If
    CleanString = newString
End Function


Public Function BanHD_Rem(ByVal HD As Long) As Boolean

    On Error Resume Next

    Dim N As Long
    N = BanHD_Find(HD)

    If N > 0 Then
        BanHDs.Remove N        ' quitar
        BanHD_save        ' guardar los cambios
        BanHD_Rem = True
    Else
        BanHD_Rem = False
    End If

End Function

Public Sub BanHD_Add(ByVal HD As Long)

    Dim N As Long
    N = BanHD_Find(HD)        ' buscar

    If N < 1 Then
        BanHDs.Add HD        ' agregar
        Call BanHD_save        ' guardar los cambios
    End If

End Sub

Public Function BanHD_Find(ByVal HD As Long) As Long

    Dim Dale As Boolean
    Dim LoopC As Long

    Dale = True
    LoopC = 1

    Do While LoopC <= BanHDs.count And Dale
        Dale = (BanHDs.Item(LoopC) <> HD)
        LoopC = LoopC + 1
    Loop

    If Dale Then
        BanHD_Find = 0
    Else
        BanHD_Find = LoopC - 1
    End If

End Function

Public Sub BanHD_save()

    On Error Resume Next

    Dim ArchN As Long
    Dim LoopC As Long

    ArchN = FreeFile()
    Open DatPath & "BanHDs.dat" For Output As #ArchN

    For LoopC = 1 To BanHDs.count
        Print #ArchN, BanHDs.Item(LoopC)
    Next LoopC

    Close #ArchN

End Sub

Public Sub BanHD_load()

    On Error Resume Next

    Dim ArchN As Long
    Dim Tmp As String

    Set BanHDs = New Collection

    ArchN = FreeFile()
    Open DatPath & "BanHDs.dat" For Input As #ArchN

    Do While Not EOF(ArchN)
        Line Input #ArchN, Tmp
        BanHDs.Add Tmp
    Loop

    Close #ArchN

End Sub

