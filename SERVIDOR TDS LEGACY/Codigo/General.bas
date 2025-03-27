Attribute VB_Name = "General"
Option Explicit

Public CR As Byte

Public F_ONLINES As Integer


Private Declare Function GetQueueStatus Lib "user32.dll" (ByVal flags As Long) As Long

Private Declare Function SafeArrayGetDim Lib "oleaut32.dll" (ByRef pArray() As Any) As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Public Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As Currency) As Long
Public Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As Currency) As Long
Public Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)
Public Declare Sub OutputDebugString Lib "kernel32" Alias "OutputDebugStringA" (ByVal lpOutputString As String)

Global LeerNPCs As New clsIniManager

Sub ActivarGlobal(Optional ByVal Avisar As Boolean = True)
    If Avisar Then Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Global activado.", FontTypeNames.FONTTYPE_SERVER))
    GlobalActivo = True
End Sub
Sub DesctivarGlobal(Optional ByVal Avisar As Boolean = True)
    If Avisar Then Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Servidor> Global desactivado.", FontTypeNames.FONTTYPE_SERVER))
    GlobalActivo = False
End Sub
Sub DarCuerpoDesnudo(ByVal UserIndex As Integer, Optional ByVal Mimetizado As Boolean = False)
'***************************************************
'Autor: Nacho (Integer)
'Last Modification: 03/14/07
'Da cuerpo desnudo a un usuario
'23/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************

    Dim cuerpoDesnudo As Integer

    With UserList(UserIndex)
        Select Case .Genero
        Case eGenero.Hombre
            Select Case .raza
            Case eRaza.Humano
                cuerpoDesnudo = 21
            Case eRaza.Drow
                cuerpoDesnudo = 32
            Case eRaza.Elfo
                cuerpoDesnudo = 21
            Case eRaza.Gnomo
                cuerpoDesnudo = 53
            Case eRaza.Enano
                cuerpoDesnudo = 53
            End Select
        Case Else
            Select Case .raza
            Case eRaza.Humano
                cuerpoDesnudo = 39
            Case eRaza.Drow
                cuerpoDesnudo = 40
            Case eRaza.Elfo
                cuerpoDesnudo = 39
            Case eRaza.Gnomo
                cuerpoDesnudo = 60
            Case eRaza.Enano
                cuerpoDesnudo = 60
            End Select
        End Select

        If Mimetizado Then
            .CharMimetizado.body = cuerpoDesnudo
        Else
            .Char.body = cuerpoDesnudo
        End If

        .flags.Desnudo = 1
    End With

End Sub
Public Sub KillCharINFO(ByVal UserName As String)

    UserName = UCase$(UserName)
    Dim User As Integer

    Dim c As String, D As String, f As String, G As String, h As Byte, i As String, j As String

    c = GetVar(CharPath & UserName & ".chr", "GUILD", "GUILDINDEX")
    D = GetVar(GUILDINFOFILE, "GUILD" & c, "Founder")
    f = GetVar(GUILDINFOFILE, "GUILD" & c, "GuildName")
    G = GetVar(GUILDPATH & f & "-members.mem", "INIT", "NroMembers")
    j = GetVar(GUILDPATH & f & "-members.mem", "Members", "Member" & G)

    If LenB(c) > 1 Then
        If val(c) <> 0 Then
            If D <> User Then
                Call modGuilds.guilds(c).ExpulsarMiembro(UserName)
            Else

                For h = 1 To G
                    i = GetVar(GUILDPATH & f & "-members.mem", "Members", "Member" & h)

                    If i = User Then
                        Call WriteVar(GUILDPATH & f & "-members.mem", "Members", "Member" & h, j)
                        Call WriteVar(GUILDPATH & f & "-members.mem", "INIT", "NroMembers", G - 1)
                    End If

                    Call WriteVar(GUILDINFOFILE, "GUILD" & c, "EleccionesAbiertas", "1")
                    Call WriteVar(GUILDINFOFILE, "GUILD" & c, "EleccionesFinalizan", DateAdd("d", 1, Now))
                    Call WriteVar(GUILDPATH & f & "-votaciones.vot", "INIT", "NumVotos", "0")
                Next h

            End If
        End If
    End If

    'Call FileCopy(CharPath & UserName & ".chr", CharPathDeleted & UserName & ".chr")
    'Call Kill(CharPath & UserName & ".chr")

End Sub

Sub Bloquear(ByVal toMap As Boolean, ByVal sndIndex As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal b As Boolean)
'***************************************************
'Author: Unknown
'Last Modification: -
'b ahora es boolean,
'b=true bloquea el tile en (x,y)
'b=false desbloquea el tile en (x,y)
'toMap = true -> Envia los datos a todo el mapa
'toMap = false -> Envia los datos al user
'Unifique los tres parametros (sndIndex,sndMap y map) en sndIndex... pero de todas formas, el mapa jamas se indica.. eso esta bien asi?
'Puede llegar a ser, que se quiera mandar el mapa, habria que agregar un nuevo parametro y modificar.. lo quite porque no se usaba ni aca ni en el cliente :s
'***************************************************

    If toMap Then
        Call SendData(SendTarget.toMap, sndIndex, PrepareMessageBlockPosition(X, Y, b))
    Else
        Call WriteBlockPosition(sndIndex, X, Y, b)
    End If

End Sub

Function HayAgua(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean
    If Map > 0 And Map < NumMaps + 1 And X > 0 And X < 101 And Y > 0 And Y < 101 Then
        With MapData(Map, X, Y)
            ''HayAgua = ((.Graphic(1) >= 1505 And .Graphic(1) <= 1520) Or _
             (.Graphic(1) >= 5665 And .Graphic(1) <= 5680) Or _
             (.Graphic(1) >= 13547 And .Graphic(1) <= 13562)) '' And _

             HayAgua = (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)

        End With
    Else
        HayAgua = False
    End If
End Function

Function HayAguaAlrededor(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean
    If Map > 0 And Map < NumMaps + 1 And X > 0 And X < 101 And Y > 0 And Y < 101 Then
        With MapData(Map, X, Y)
            HayAguaAlrededor = (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)
        End With
    Else
        HayAguaAlrededor = False
    End If

    If Map > 0 And Map < NumMaps + 1 And (X + 1) > 0 And (X + 1) < 101 And Y > 0 And Y < 101 Then
        With MapData(Map, X + 1, Y)
            HayAguaAlrededor = HayAguaAlrededor Or (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)
        End With
    Else
        HayAguaAlrededor = HayAguaAlrededor Or False
    End If


    If Map > 0 And Map < NumMaps + 1 And (X - 1) > 0 And (X - 1) < 101 And Y > 0 And Y < 101 Then
        With MapData(Map, X - 1, Y)
            HayAguaAlrededor = HayAguaAlrededor Or (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)
        End With
    Else
        HayAguaAlrededor = HayAguaAlrededor Or False
    End If

    If Map > 0 And Map < NumMaps + 1 And X > 0 And X < 101 And (Y + 1) > 0 And (Y + 1) < 101 Then
        With MapData(Map, X, Y + 1)
            HayAguaAlrededor = HayAguaAlrededor Or (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)
        End With
    Else
        HayAguaAlrededor = HayAguaAlrededor Or False
    End If

    If Map > 0 And Map < NumMaps + 1 And X > 0 And X < 101 And (Y - 1) > 0 And (Y - 1) < 101 Then
        With MapData(Map, X, Y - 1)
            HayAguaAlrededor = HayAguaAlrededor Or (.Graphic(1) >= 1505 And .Graphic(1) <= 1520 And .Graphic(2) = 0)
        End With
    Else
        HayAguaAlrededor = HayAguaAlrededor Or False
    End If

End Function

Private Function HayLava(ByVal Map As Integer, ByVal X As Integer, ByVal Y As Integer) As Boolean
End Function

Sub EnviarSpawnList(ByVal UserIndex As Integer)
    On Error GoTo Errhandler

1   Dim k As Long
2   Dim npcNames() As String
3   ReDim npcNames(1 To UBound(Declaraciones.SpawnList)) As String
4   For k = 1 To UBound(Declaraciones.SpawnList)
5       npcNames(k) = Declaraciones.SpawnList(k).NpcName
6   Next k
7   Call WriteSpawnList(UserIndex, npcNames())
    Exit Sub
Errhandler:
    Call LogError("Error en EnviarSpawnList en " & Erl & " . Err :" & Err.Number & " " & Err.Description)
End Sub

Private Function GetProcess(ByVal processName As String) As Byte
    On Error Resume Next
    Dim oService As Object
    Dim servicename As String
    Dim processCount As Byte
100 Dim oWMI As Object: Set oWMI = GetObject("winmgmts:")
102 Dim oServices As Object: Set oServices = oWMI.InstancesOf("win32_process")
104 For Each oService In oServices
106     servicename = LCase$(Trim$(CStr(oService.Name)))
108     If InStrB(1, servicename, LCase$(processName), vbBinaryCompare) > 0 Then
            ' Para matar un proceso adentro de este loop usar.
            'oService.Terminate
110         processCount = processCount + 1
        End If
    Next
112 GetProcess = processCount
End Function

Sub Main()
    
    If App.PrevInstance Then
        MsgBox "Este programa ya está corriendo.", vbInformation, "Tirras Del Sur"
        End
    End If
    
    Call modEngine.Initialize

    IntClickU = 5

    On Error GoTo Handler
    Dim LoopC As Long
    'Call LogThis(0, "Starting the server " & Now, vbLogEventTypeInformation)

    If GetProcess(App.EXEName & ".exe") > 1 Then
102     If MsgBox("Se ha encontrado mas de 1 instancia abierta de esta aplicación, ¿Desea continuar?", vbYesNo) = vbNo Then
104         End
        End If
    End If


    On Error Resume Next
    Dim f As Date

    ChDir App.path
    ChDrive App.path
    Call CargarListaNegraUsuarios

    Prision.Map = 66
    Libertad.Map = 66

    Prision.X = 75
    Prision.Y = 47
    Libertad.X = 75
    Libertad.Y = 65

    LastBackup = Format(Now, "Short Time")
    Minutos = Format(Now, "Short Time")

    IniPath = App.path & "\"
    DatPath = App.path & "\Dat\"
    AccPath = App.path & "\Cuentas\"

    LogUserPath = App.path & "\logs\User\"

    If Not FileExist(IniPath, vbDirectory) Then MkDir (IniPath)
    If Not FileExist(DatPath, vbDirectory) Then MkDir (DatPath)
    If Not FileExist(AccPath, vbDirectory) Then MkDir (AccPath)
    If Not FileExist(App.path & "\logs\", vbDirectory) Then MkDir (App.path & "\logs\")
    If Not FileExist(LogUserPath, vbDirectory) Then MkDir (LogUserPath)

    CharPathDeleted = App.path & "\Charfile_Deleted\"

    LevelSkill(1).LevelValue = 3
    LevelSkill(2).LevelValue = 5
    LevelSkill(3).LevelValue = 7
    LevelSkill(4).LevelValue = 10
    LevelSkill(5).LevelValue = 13
    LevelSkill(6).LevelValue = 15
    LevelSkill(7).LevelValue = 17
    LevelSkill(8).LevelValue = 20
    LevelSkill(9).LevelValue = 23
    LevelSkill(10).LevelValue = 25
    LevelSkill(11).LevelValue = 27
    LevelSkill(12).LevelValue = 30
    LevelSkill(13).LevelValue = 33
    LevelSkill(14).LevelValue = 35
    LevelSkill(15).LevelValue = 37
    LevelSkill(16).LevelValue = 40
    LevelSkill(17).LevelValue = 43
    LevelSkill(18).LevelValue = 45
    LevelSkill(19).LevelValue = 47
    LevelSkill(20).LevelValue = 50
    LevelSkill(21).LevelValue = 53
    LevelSkill(22).LevelValue = 55
    LevelSkill(23).LevelValue = 57
    LevelSkill(24).LevelValue = 60
    LevelSkill(25).LevelValue = 63
    LevelSkill(26).LevelValue = 65
    LevelSkill(27).LevelValue = 67
    LevelSkill(28).LevelValue = 70
    LevelSkill(29).LevelValue = 73
    LevelSkill(30).LevelValue = 75
    LevelSkill(31).LevelValue = 77
    LevelSkill(32).LevelValue = 80
    LevelSkill(33).LevelValue = 83
    LevelSkill(34).LevelValue = 85
    LevelSkill(35).LevelValue = 87
    LevelSkill(36).LevelValue = 90
    LevelSkill(37).LevelValue = 93
    LevelSkill(38).LevelValue = 95
    LevelSkill(39).LevelValue = 97
    LevelSkill(40).LevelValue = 100
    LevelSkill(41).LevelValue = 100
    LevelSkill(42).LevelValue = 100
    LevelSkill(43).LevelValue = 100
    LevelSkill(44).LevelValue = 100
    LevelSkill(45).LevelValue = 100
    LevelSkill(46).LevelValue = 100
    LevelSkill(47).LevelValue = 100
    LevelSkill(48).LevelValue = 100
    LevelSkill(49).LevelValue = 100
    LevelSkill(50).LevelValue = 100


    ListaRazas(eRaza.Humano) = "Humano"
    ListaRazas(eRaza.Elfo) = "Elfo"
    ListaRazas(eRaza.Drow) = "Drow"
    ListaRazas(eRaza.Gnomo) = "Gnomo"
    ListaRazas(eRaza.Enano) = "Enano"

    ListaClases(eClass.Assasin) = "Asesino"
    ListaClases(eClass.Bard) = "Bardo"
    ListaClases(eClass.Cleric) = "Clerigo"
    ListaClases(eClass.Paladin) = "Paladin"
    ListaClases(eClass.Carpenter) = "Carpintero"
    ListaClases(eClass.Woodcutter) = "Leñador"
    ListaClases(eClass.Miner) = "Minero"
    ListaClases(eClass.Warrior) = "Guerrero"
    ListaClases(eClass.Mage) = "Mago"
    ListaClases(eClass.Druid) = "Druida"
    ListaClases(eClass.Hunter) = "Cazador"
    ListaClases(eClass.Thief) = "Ladron"
    ListaClases(eClass.Fisherman) = "Pescador"
    ListaClases(eClass.Pirat) = "Pirata"
    ListaClases(eClass.Blacksmith) = "Herrero"

    SkillsNames(eSkill.Magia) = "Magia"
    SkillsNames(eSkill.Robar) = "Robar"
    SkillsNames(eSkill.Tacticas) = "Tacticas de combate"
    SkillsNames(eSkill.Armas) = "Combate con armas"
    SkillsNames(eSkill.Meditar) = "Meditar"
    SkillsNames(eSkill.Apuñalar) = "Apuñalar"
    SkillsNames(eSkill.Ocultarse) = "Ocultarse"
    SkillsNames(eSkill.Supervivencia) = "Supervivencia"
    SkillsNames(eSkill.Talar) = "Talar arboles"
    SkillsNames(eSkill.Comerciar) = "Comercio"
    SkillsNames(eSkill.Defensa) = "Defensa con escudos"
    SkillsNames(eSkill.Pesca) = "Pesca"
    SkillsNames(eSkill.Mineria) = "Mineria"
    SkillsNames(eSkill.Carpinteria) = "Carpinteria"
    SkillsNames(eSkill.Herreria) = "Herreria"
    SkillsNames(eSkill.Liderazgo) = "Liderazgo"
    SkillsNames(eSkill.Domar) = "Domar animales"
    SkillsNames(eSkill.proyectiles) = "Armas de proyectiles"
    SkillsNames(eSkill.Wrestling) = "Combate sin armas"
    SkillsNames(eSkill.Navegacion) = "Navegacion"
    SkillsNames(eSkill.ResistenciaMagica) = "Resistencia Magica"

    ListaAtributos(eAtributos.Fuerza) = "Fuerza"
    ListaAtributos(eAtributos.Agilidad) = "Agilidad"
    ListaAtributos(eAtributos.Inteligencia) = "Inteligencia"
    ListaAtributos(eAtributos.Carisma) = "Carisma"
    ListaAtributos(eAtributos.Constitucion) = "Constitucion"

    ArrayMascotas(1, eHeading.NORTH).X = -1
    ArrayMascotas(1, eHeading.NORTH).Y = 0
    ArrayMascotas(2, eHeading.NORTH).X = 1
    ArrayMascotas(2, eHeading.NORTH).Y = 0
    ArrayMascotas(3, eHeading.NORTH).X = 2
    ArrayMascotas(3, eHeading.NORTH).Y = 0

    ArrayMascotas(1, eHeading.EAST).X = 0
    ArrayMascotas(1, eHeading.EAST).Y = -1
    ArrayMascotas(2, eHeading.EAST).X = 0
    ArrayMascotas(2, eHeading.EAST).Y = 1
    ArrayMascotas(3, eHeading.EAST).X = 0
    ArrayMascotas(3, eHeading.EAST).Y = 2

    ArrayMascotas(1, eHeading.SOUTH).X = -1
    ArrayMascotas(1, eHeading.SOUTH).Y = 0
    ArrayMascotas(2, eHeading.SOUTH).X = 1
    ArrayMascotas(2, eHeading.SOUTH).Y = 0
    ArrayMascotas(3, eHeading.SOUTH).X = 2
    ArrayMascotas(3, eHeading.SOUTH).Y = 0

    ArrayMascotas(1, eHeading.WEST).X = 0
    ArrayMascotas(1, eHeading.WEST).Y = -1
    ArrayMascotas(2, eHeading.WEST).X = 0
    ArrayMascotas(2, eHeading.WEST).Y = 1
    ArrayMascotas(3, eHeading.WEST).X = 0
    ArrayMascotas(3, eHeading.WEST).Y = 2

    Load_Array_Movements

    'Call PlayWaveAPI(App.Path & "\wav\harp3.wav")
    frmCargando.Show
    frmMain.Caption = frmMain.Caption & " V." & App.Major & "." & App.Minor & "." & App.Revision
    IniPath = App.path & "\"
    CharPath = App.path & "\Charfile\"

    If Not FileExist(CharPath, vbDirectory) Then MkDir (CharPath)

    'Bordes del mapa
    MinXBorder = XMinMapSize + (XWindow \ 2)
    MaxXBorder = XMaxMapSize - (XWindow \ 2)
    MinYBorder = YMinMapSize + (YWindow \ 2)
    MaxYBorder = YMaxMapSize - (YWindow \ 2)

    Call seguridad_clones_construir

    DoEventsEx


    Call LoadGuildsDB
    Call loadAdministrativeUsers

    'Call m_Cuentas.LoadCuentas

    Call LoadQuests

    Call CargarForbidenWords

    maxUsers = 0
    Call LoadSini

    Call CargaApuestas
    Call CargaNpcsDat
    Call LoadOBJData
    Call CargarHechizos
    Call LoadArmasHerreria
    Call LoadArmadurasHerreria
    Call LoadObjCarpintero
    Call LoadBalance

    ' @@ Torneos
    Call LoadTorneosGestion
    Call Torneo1vs1_CargarPos
    Call TorneoDeath_CargarPos
    Call LoadJDH
    Call LoadTorneo2vs2Arena

    ' @@ Retos
    Call m_Retos1vs1.Retos1vs1Load
    Call m_Retos2vs2.Retos2vs2Load
    Call loadNPCS
    
    ' @@ :)
    Set cvcManager = New cvcManager

    If BootDelBackUp Then
        Call CargarBackUp
    Else
        Call LoadMapData
    End If

    Call SonidosMapas.LoadSoundMapInfo
    Call CargarSpawnList

    Call generateMatrix(MATRIX_INITIAL_MAP)
    Call m_ArenaBots.IA_Spells
    Call m_ArenaBots.LoadBotArenasPos

    For LoopC = 1 To maxUsers + 1
        UserList(LoopC).ConnID = -1
        UserList(LoopC).ConnIDValida = False
        UserList(LoopC).UserIndex = LoopC
    Next LoopC

    'Call m_MercadoAO.MAO_CargarMercado

    frmMain.AutoSave.Enabled = True
    frmMain.tPiqueteC.Enabled = True
    frmMain.tLluviaEvent.Enabled = True
    frmMain.FX.Enabled = True
    frmMain.Auditoria.Enabled = True
    frmMain.KillLog.Enabled = True
    frmMain.TIMER_AI.Enabled = True
    frmMain.npcataca.Enabled = True

    Call SecurityIp.InitIpTables(1000)

116 For LoopC = 1 To maxUsers
118     Call CloseSocket(LoopC)
    Next

    frmMain.NewGameTimer.Enabled = True

    Call modEngine.NetListen("0.0.0.0", Puerto)
    
    Call LoadRanking

    Call SocketConfig

    Unload frmCargando

    If HideMe = 1 Then
        Call frmMain.InitMain(1)
    Else
        Call frmMain.InitMain(0)
    End If

332 tInicioServer = GetTickCount()

    Call mod_DB.WEB_Tick

    While (True)
        Call modEngine.Tick
        DoEventsEx
    Wend

    Call LogThis(0, "Closing the server " & Now, vbLogEventTypeInformation)

    Exit Sub

Handler:
334 Call LogError("General.Main en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Function DoEventsEx() As Integer
    If GetQueueStatus(&H4FF&) And &HFFFF0000 Then
        DoEventsEx = DoEvents
    End If
End Function

Public Sub SocketConfig()

    On Error Resume Next

    Call SecurityIp.InitIpTables(1000)

    If LastSockListen >= 0 Then Call apiclosesocket(LastSockListen)

    Call IniciaWsApi(frmMain.hWnd)
    SockListen = ListenForConnect(PuertoWEB, hWndMsg, "")

    If SockListen <> -1 Then
        Call WriteVar(IniPath & "Server.ini", "INIT", "LastSockListen", SockListen)    ' Guarda el socket escuchando
        frmMain.lblSocketWEB.Caption = "Escuchando conexiones entrantes en el puerto " & PuertoWEB & " - SockListen: " & SockListen
    Else
        frmMain.lblSocketWEB.Caption = "Ha ocurrido un error al iniciar el socket del ServidorWEB en el puerto " & PuertoWEB
    End If


End Sub


Function FileExist(ByVal File As String, Optional FileType As VbFileAttribute = vbNormal) As Boolean
'*****************************************************************
'Se fija si existe el archivo
'*****************************************************************

    FileExist = LenB(dir$(File, FileType)) <> 0
End Function

Function ReadField(ByVal Pos As Integer, ByRef Text As String, ByVal SepASCII As Byte) As String
'*****************************************************************
'Gets a field from a string
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 11/15/2004
'Gets a field from a delimited string
'*****************************************************************

    Dim i As Long
    Dim lastPos As Long
    Dim CurrentPos As Long
    Dim delimiter As String * 1

    delimiter = Chr$(SepASCII)

    For i = 1 To Pos
        lastPos = CurrentPos
        CurrentPos = InStr(lastPos + 1, Text, delimiter, vbBinaryCompare)
    Next i

    If CurrentPos = 0 Then
        ReadField = mid$(Text, lastPos + 1, Len(Text) - lastPos)
    Else
        ReadField = mid$(Text, lastPos + 1, CurrentPos - lastPos - 1)
    End If
End Function

Function MapaValido(ByVal Map As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    MapaValido = Map >= 1 And Map <= NumMaps
End Function

Sub MostrarNumUsers()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    frmMain.CantUsuarios.Caption = "ON: " & NumUsers & "-" & F_ONLINES

End Sub



Public Sub LogIndex(ByVal Index As Integer, ByVal Desc As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\" & Index & ".log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub

Errhandler:

End Sub

Public Sub LogEditPacket(Desc As String)

    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile
    Open App.path & "\logs\paquetes.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & Desc
    Close #nFile

    Exit Sub

Errhandler:

End Sub



Public Sub LogAsesinato(texto As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Call LogInPython("B", texto)
    Exit Sub

    On Error GoTo Errhandler
    Dim nFile As Integer

    nFile = FreeFile        ' obtenemos un canal

    Open App.path & "\logs\asesinatos.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub

Errhandler:

End Sub

Public Sub LogHackAttemp(texto As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\HackAttemps.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub

Errhandler:

End Sub

Public Sub LogCriticalHackAttemp(texto As String)

    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile        ' obtenemos un canal
    Open App.path & "\logs\CriticalHackAttemps.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile

    Exit Sub

Errhandler:

End Sub

Public Sub LogAntiCheat(texto As String)
    On Error GoTo Errhandler

    Call LogInPython("C", texto)

    Exit Sub

1   If frmMain.sck_PostWEB.State = 7 Then        ' connected
2       frmMain.sck_PostWEB.SendData ("|9" & texto)
3   Else        'not connected or something, try again.
4       If frmMain.sck_PostWEB.State <> 0 Then frmMain.sck_PostWEB.Close
5       frmMain.sck_PostWEB.connect
6
7       If frmMain.sck_PostWEB.State = 7 Then        ' connected
8           frmMain.sck_PostWEB.SendData ("|9" & texto)
9       End If
10  End If
    Exit Sub
Errhandler:
End Sub

Public Sub LogInPython(tipo As String, ByVal texto As String)
    On Error GoTo Errhandler

1   If frmMain.sck_PostWEB.State = 7 Then        ' connected
2       frmMain.sck_PostWEB.SendData ("|" & tipo & Now & " - " & texto & vbNewLine)
3   Else        'not connected or something, try again.
4       If frmMain.sck_PostWEB.State <> 0 Then frmMain.sck_PostWEB.Close
5       frmMain.sck_PostWEB.connect
6
7       If frmMain.sck_PostWEB.State = 7 Then        ' connected
8           frmMain.sck_PostWEB.SendData ("|" & tipo & Now & " - " & texto & vbNewLine)
9       End If
10  End If
    Exit Sub
Errhandler:
End Sub

Function ValidInputNP(ByVal cad As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim Arg As String
    Dim i As Integer


    For i = 1 To 33

        Arg = ReadField(i, cad, 44)

        If LenB(Arg) = 0 Then Exit Function

    Next i

    ValidInputNP = True

End Function

Public Sub GenerateOnlineString()
    Dim i As Long
    Dim count As Long
    Dim tStr As String
    For i = 1 To LastUser
        If LenB(UserList(i).Name) <> 0 Then
            If Not EsGM(i) Then
                count = count + 1
                tStr = tStr & UserList(i).Name & ", "
            End If
        End If
    Next i
    If Len(tStr) > 3 Then
        tStr = Left$(tStr, Len(tStr) - 2) & vbCrLf
    Else
        tStr = vbNullString
    End If
    OnlineString = tStr
    OnlineNum = count
End Sub

Public Function Intemperie(ByVal UserIndex As Integer) As Boolean
'**************************************************************
'Author: Unknown
'Last Modify Date: 15/11/2009
'15/11/2009: ZaMa - La lluvia no quita stamina en las arenas.
'23/11/2009: ZaMa - Optimizacion de codigo.
'**************************************************************

    With UserList(UserIndex)
        If MapInfo(.Pos.Map).Zona <> "DUNGEON" Then
            If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger <> 1 And _
               MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger <> 2 And _
               MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger <> 4 Then Intemperie = True
        Else
            Intemperie = False
        End If
    End With

    'En las arenas no te afecta la lluvia
    If IsArena(UserIndex) Then Intemperie = False
End Function

Public Sub TiempoInvocacion(ByVal UserIndex As Integer, tiempoTranscurrido As Long)

    Dim i As Long
    Dim Index As Integer

1   On Error GoTo TiempoInvocacion_Error

    ' @@ TDS Extraction
    For i = 1 To MAXMASCOTAS
        Index = UserList(UserIndex).MascotasIndex(i)
2       If Index > 0 Then
3           If Npclist(Index).Contadores.TiempoExistencia > 0 Then
4               Npclist(Index).Contadores.TiempoExistencia = Npclist(Index).Contadores.TiempoExistencia - tiempoTranscurrido
5               If Npclist(Index).Contadores.TiempoExistencia <= 0 Then
                    Call MuereNpc(Index, 0)
7               End If
8           End If
9       End If
10  Next i

    '2   For i = 1 To MAXMASCOTAS
    '3       With UserList(UserIndex)
    '4           If .MascotasIndex(i) > 0 Then
    '5               If Npclist(.MascotasIndex(i)).Contadores.TiempoExistencia > 0 Then
    '6                   Npclist(.MascotasIndex(i)).Contadores.TiempoExistencia = Npclist(.MascotasIndex(i)).Contadores.TiempoExistencia - 1
    '7                   If Npclist(.MascotasIndex(i)).Contadores.TiempoExistencia = 0 Then Call MuereNpc(.MascotasIndex(i), 0)
    '8               End If
    '9           End If
    '10      End With
    '11  Next i

12  Exit Sub

TiempoInvocacion_Error:

13  Call LogError("Error " & Err.Number & " (" & Err.Description & ") in procedure TiempoInvocacion of Módulo General " & Erl & ".")
End Sub

Private Function EstaAbrigado(ByVal UserIndex As Integer) As Boolean

    EstaAbrigado = False
    With UserList(UserIndex).Invent
        If .ArmourEqpObjIndex <> 0 Then
            If ObjData(.ArmourEqpObjIndex).abriga = 1 Then
                EstaAbrigado = True
            Else

                If UserList(UserIndex).Pos.Map = 175 Or UserList(UserIndex).Pos.Map = 188 Then
                    EstaAbrigado = True
                End If

            End If
        Else
            EstaAbrigado = False
        End If
    End With
End Function

Public Sub EfectoFrio1(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        If .sReto.Reto_Index Or .mReto.Reto_Index Then Exit Sub

        If Not (((.Pos.Map = 169 Or .Pos.Map = 170 Or .Pos.Map = 171) And Not EstaAbrigado(UserIndex))) Then
            Exit Sub
        End If

        If .Counters.Frio < IntervaloFrio Then
            .Counters.Frio = .Counters.Frio + 1
        Else
            If ((.Pos.Map = 169 Or .Pos.Map = 170 Or .Pos.Map = 171) And Not EstaAbrigado(UserIndex)) Then

                WriteMensajes UserIndex, e_Mensajes.Mensaje_10
                .Stats.MinHP = .Stats.MinHP - Porcentaje(.Stats.MaxHP, 5)

                If .Stats.MinHP < 1 Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_22
                    .Stats.MinHP = 0
                    Call UserDie(UserIndex, Not EsGM(UserIndex))
                End If

                Call WriteUpdateHP(UserIndex)
            End If

            .Counters.Frio = 0
        End If
    End With
End Sub

Public Sub EfectoFrio(ByVal UserIndex As Integer)
'***************************************************
'Autor: Unkonwn
'Last Modification: 23/11/2009
'If user is naked and it's in a cold map, take health points from him
'23/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************

    On Error GoTo Errhandler

    With UserList(UserIndex)

1       If .flags.Desnudo = 0 Then Exit Sub

        If .sReto.Reto_Index Or .mReto.Reto_Index Then Exit Sub

        If .Pos.Map = 175 Or .Pos.Map = 188 Then
            Exit Sub
        End If
        
        If .flags.EnEvento Then Exit Sub

        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 4 Then
            Exit Sub
        End If

2       If .Counters.Frio < IntervaloFrio Then
            .Counters.Frio = .Counters.Frio + 1
        Else
3           If MapInfo(.Pos.Map).Zona = Dungeon Or MapInfo(.Pos.Map).Terreno = Nieve Or MapInfo(.Pos.Map).Restringir = "VEINTICINCO" Or MapInfo(.Pos.Map).Restringir = "CUARENTA" Or ((.Pos.Map = 169 Or .Pos.Map = 170 Or .Pos.Map = 171) And Not EstaAbrigado(UserIndex)) Then
4               WriteMensajes UserIndex, e_Mensajes.Mensaje_10

                .Stats.MinHP = .Stats.MinHP - Porcentaje(.Stats.MaxHP, 5)

                If .Stats.MinHP < 1 Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_22
                    .Stats.MinHP = 0
7                   Call UserDie(UserIndex, Not EsGM(UserIndex))
                Else

9                   Call WriteUpdateHP(UserIndex)
8               End If

            Else
                Call QuitarSta(UserIndex, Porcentaje(.Stats.MaxSta, 5))
12              Call WriteUpdateSta(UserIndex)
            End If

13          .Counters.Frio = 0
        End If

    End With
    Exit Sub
Errhandler:
    Call LogError("error en efectofrio en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub EfectoLava(ByVal UserIndex As Integer)
'***************************************************
'Autor: Nacho (Integer)
'Last Modification: 23/11/2009
'If user is standing on lava, take health points from him
'23/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************
    With UserList(UserIndex)
        If .Counters.Lava < IntervaloFrio Then        'Usamos el mismo intervalo que el del frio
            .Counters.Lava = .Counters.Lava + 1
        Else
            If HayLava(.Pos.Map, .Pos.X, .Pos.Y) Then
                Call WriteMensajes(UserIndex, Mensaje_402)
                .Stats.MinHP = .Stats.MinHP - Porcentaje(.Stats.MaxHP, 5)

                If .Stats.MinHP < 1 Then
                    Call WriteMensajes(UserIndex, Mensaje_403)
                    .Stats.MinHP = 0
                    Call UserDie(UserIndex, Not EsGM(UserIndex))
                End If

                Call WriteUpdateHP(UserIndex)

            End If

            .Counters.Lava = 0
        End If
    End With
End Sub

''
' Maneja el tiempo y el efecto del mimetismo
'
' @param UserIndex  El index del usuario a ser afectado por el mimetismo
'

Public Sub EfectoMimetismo(ByVal UserIndex As Integer)
'******************************************************
'Author: Unknown
'Last Update: 12/01/2010 (ZaMa)
'12/01/2010: ZaMa - Los druidas pierden la inmunidad de ser atacados cuando pierden el efecto del mimetismo.
'******************************************************
    Dim Barco As ObjData

    With UserList(UserIndex)
        If .Counters.Mimetismo < IntervaloInvisible Then
            .Counters.Mimetismo = .Counters.Mimetismo + 1
        Else
            'restore old char
            Call WriteMensajes(UserIndex, Mensaje_404)

            If .flags.Navegando Then
                If .flags.Muerto = 0 Then
                    If .faccion.ArmadaReal = 1 Then
                        .Char.body = iFragataReal
                    ElseIf .faccion.FuerzasCaos = 1 Then
                        .Char.body = iFragataCaos
                    Else
                        Barco = ObjData(UserList(UserIndex).Invent.BarcoObjIndex)
                        If criminal(UserIndex) Then
                            If Barco.Ropaje = iBarca Then .Char.body = iBarcaPk
                            If Barco.Ropaje = iGalera Then .Char.body = iGaleraPk
                            If Barco.Ropaje = iGaleon Then .Char.body = iGaleonPk
                        Else
                            If Barco.Ropaje = iBarca Then .Char.body = iBarcaCiuda
                            If Barco.Ropaje = iGalera Then .Char.body = iGaleraCiuda
                            If Barco.Ropaje = iGaleon Then .Char.body = iGaleonCiuda
                        End If
                    End If
                Else
                    .Char.body = iFragataFantasmal
                End If

                .Char.ShieldAnim = NingunEscudo
                .Char.WeaponAnim = NingunArma
                .Char.CascoAnim = NingunCasco
            Else
                .Char.body = .CharMimetizado.body
                .Char.Head = .CharMimetizado.Head
                .Char.CascoAnim = .CharMimetizado.CascoAnim
                .Char.ShieldAnim = .CharMimetizado.ShieldAnim
                .Char.WeaponAnim = .CharMimetizado.WeaponAnim
            End If

            With .Char
                Call ChangeUserChar(UserIndex, .body, .Head, .Heading, .WeaponAnim, .ShieldAnim, .CascoAnim)
            End With

            Dim sndNick As String

            sndNick = .Name

            If .flags.invisible = 1 Then
                sndNick = sndNick & " " & TAG_USER_INVISIBLE
            Else
                If .GuildIndex > 0 Then
                    sndNick = sndNick & " <" & modGuilds.GuildName(.GuildIndex) & ">"
                End If
            End If
            If Not EsGM(UserIndex) Then
                If .faccion.Status = FaccionType.ChaosCouncil Then
                    sndNick = sndNick & " *"
                ElseIf .faccion.Status = FaccionType.RoyalCouncil Then
                    sndNick = sndNick & " /"
                End If
            End If

            .Counters.Mimetismo = 0
            .flags.Mimetizado_Nick = "-"

            'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCharacterChangeNick(.Char.CharIndex, sndNick))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageUpdateTagAndStatus(UserIndex, GetNickColor(UserIndex), sndNick))

            .flags.Mimetizado = 0
            ' Se fue el efecto del mimetismo, puede ser atacado por npcs
            .flags.Ignorado = False
        End If
    End With
End Sub

Public Sub EfectoInvisibilidad(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)

        If .sReto.Reto_Index Or .mReto.Reto_Index Then .Counters.Invisibilidad = IntervaloInvisible: Exit Sub    ' @@ Le sacamos el invi :P

        If .Counters.Invisibilidad < IntervaloInvisible Then
            .Counters.Invisibilidad = .Counters.Invisibilidad + 1
        Else
            .Counters.Invisibilidad = RandomNumber(-100, 100)        ' Invi variable :D
            .flags.invisible = 0
            If .flags.oculto = 0 Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_23
                Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                'Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageSetInvisible(.Char.CharIndex, False))
            End If
        End If
    End With

End Sub

Public Sub EfectoParalisisNpc(ByVal NpcIndex As Integer)

    With Npclist(NpcIndex)
        If .Contadores.Paralisis > 0 Then
            .Contadores.Paralisis = .Contadores.Paralisis - 1
        Else
            .flags.Paralizado = 0
            .flags.Inmovilizado = 0
        End If
    End With

End Sub

Public Sub EfectoCegueEstu(ByVal UserIndex As Integer)

    With UserList(UserIndex)
        If .Counters.Ceguera > 0 Then
            .Counters.Ceguera = .Counters.Ceguera - 1
        Else
            If .flags.Ceguera = 1 Then
                .flags.Ceguera = 0
                Call WriteBlindNoMore(UserIndex)
            End If
            If .flags.Estupidez = 1 Then
                .flags.Estupidez = 0
                Call WriteDumbNoMore(UserIndex)
            End If

        End If
    End With

End Sub


Public Sub EfectoParalisisUser(ByVal UserIndex As Integer)

    With UserList(UserIndex)

        If .Counters.Paralisis > 0 Then

            Dim CasterIndex As Integer
            CasterIndex = .flags.ParalizedByIndex

            ' Only aplies to non-magic clases
            If .Stats.MaxMAN = 0 Then
                ' Paralized by user?
                If CasterIndex <> 0 Then

                    ' Close? => Remove Paralisis
                    If UserList(CasterIndex).Name <> .flags.ParalizedBy Then
                        Call RemoveParalisis(UserIndex)
                        Exit Sub
                    ElseIf UserList(CasterIndex).flags.Muerto = 1 Then    ' Caster dead? => Remove Paralisis
                        Call RemoveParalisis(UserIndex)
                        Exit Sub
                    ElseIf .Counters.Paralisis > IntervaloParalizadoReducido Then
                        If Not InVisionRangeAndMap(UserIndex, UserList(CasterIndex).Pos) Then    ' Out of vision range? => Reduce paralisis counter
                            '    .Counters.Paralisis = IntervaloParalizadoReducido ' Aprox. 1500 ms
                            '    Exit Sub
                        End If
                    End If

                    ' Npc?
                Else
                    CasterIndex = .flags.ParalizedByNpcIndex

                    ' Paralized by npc?
                    If CasterIndex <> 0 Then

                        If .Counters.Paralisis > IntervaloParalizadoReducido Then
                            ' Out of vision range? => Reduce paralisis counter
                            If Not InVisionRangeAndMap(UserIndex, Npclist(CasterIndex).Pos) Then
                                Call RemoveParalisis(UserIndex)
                                Exit Sub
                            End If
                        End If
                    End If

                End If
            End If

            .Counters.Paralisis = .Counters.Paralisis - 1

        Else
            Call RemoveParalisis(UserIndex)
        End If
    End With

End Sub

Public Sub RecStamina(ByVal UserIndex As Integer, ByRef EnviarStats As Boolean, ByVal Intervalo As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 2 And _
           MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 4 Then Exit Sub

        Dim Porc As Byte

        If .Stats.MinHam = 0 Or .Stats.MinAGU = 0 Then Exit Sub
        Porc = 5

        If CONFIG_INI_STAREDUCTION = 1 Then
            Select Case (.Stats.MinHam + .Stats.MinAGU)
            Case Is < 60
                Porc = 1
            Case Is < 110
                Porc = 2
            Case Is < 140
                Porc = 3
            Case Is < 170
                Porc = 4
            Case Else
                Porc = 5
            End Select
        End If

        Dim massta As Integer
        If .Stats.minSta < .Stats.MaxSta Then
            If .Counters.STACounter < Intervalo Then
                .Counters.STACounter = .Counters.STACounter + 1
            Else
                EnviarStats = True
                .Counters.STACounter = 0
                If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger <> BajoTecho And MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger <> eTrigger.trigger_2 Then
                    If .flags.Desnudo = 1 Then
                        Exit Sub          'Desnudo no sube energía. (ToxicWaste)
                    End If

                    'If Lloviendo And Intemperie(UserIndex) Then Exit Sub
                End If

                massta = RandomNumber(1, Porcentaje(.Stats.MaxSta, Porc))
                .Stats.minSta = .Stats.minSta + massta
                If .Stats.minSta > .Stats.MaxSta Then
                    .Stats.minSta = .Stats.MaxSta
                End If
            End If
        End If
    End With

End Sub

Public Sub EfectoVeneno(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)
        If .flags.Envenenado = 0 Then Exit Sub

        If .Counters.Veneno < IntervaloVeneno Then
            .Counters.Veneno = .Counters.Veneno + 1
        Else
            WriteMensajes UserIndex, e_Mensajes.Mensaje_39
            .Counters.Veneno = 0
            .Stats.MinHP = .Stats.MinHP - Porcentaje(.Stats.MaxHP, RandomNumber(1, 3))
            If .Stats.MinHP < 1 Then Call UserDie(UserIndex, Not EsGM(UserIndex))
            Call WriteUpdateHP(UserIndex)
        End If
    End With

End Sub

Public Sub DuracionPociones(ByVal UserIndex As Integer)
'***************************************************
'Author: ??????
'Last Modification: 11/27/09 (Budi)
'Cuando se pierde el efecto de la poción updatea fz y agi (No me gusta que ambos atributos aunque se haya modificado solo uno, pero bueno :p)
'***************************************************
    With UserList(UserIndex)
        'Controla la duracion de las pociones
        If .flags.DuracionEfecto > 0 Then
            .flags.DuracionEfecto = .flags.DuracionEfecto - 1
            If .flags.DuracionEfecto = 0 Then
                .flags.TomoPocion = False
                .flags.TipoPocion = 0
                'volvemos los atributos al estado normal
                Dim LoopX As Integer

                For LoopX = 1 To NUMATRIBUTOS
                    .Stats.UserAtributos(LoopX) = .Stats.UserAtributosBackUP(LoopX)
                Next LoopX

                Call WriteUpdateStrenghtAndDexterity(UserIndex)
            End If
        End If
    End With

End Sub

Public Sub HambreYSed(ByVal UserIndex As Integer, ByRef fenviarAyS As Boolean)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)
        If EsGM(UserIndex) Then Exit Sub

        'Sed
        If .Stats.MinAGU > 0 Then
            If .Counters.AGUACounter < IntervaloSed Then
                .Counters.AGUACounter = .Counters.AGUACounter + 1
            Else
                .Counters.AGUACounter = 0
                .Stats.MinAGU = .Stats.MinAGU - 10

                If .Stats.MinAGU <= 0 Then
                    .Stats.MinAGU = 0
                    .flags.Sed = 1
                End If

                fenviarAyS = True
            End If
        End If

        'hambre
        If .Stats.MinHam > 0 Then
            If .Counters.COMCounter < IntervaloHambre Then
                .Counters.COMCounter = .Counters.COMCounter + 1
            Else
                .Counters.COMCounter = 0
                .Stats.MinHam = .Stats.MinHam - 10
                If .Stats.MinHam <= 0 Then
                    .Stats.MinHam = 0
                    .flags.Hambre = 1
                End If
                fenviarAyS = True
            End If
        End If
    End With

End Sub

Public Sub Sanar(ByVal UserIndex As Integer, ByRef EnviarStats As Boolean, ByVal Intervalo As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 1 And _
           MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 2 And _
           MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 4 Then Exit Sub

        Dim mashit As Integer
        'con el paso del tiempo va sanando....pero muy lentamente ;-)
        If .Stats.MinHP < .Stats.MaxHP Then
            If .Counters.HPCounter < Intervalo Then
                .Counters.HPCounter = .Counters.HPCounter + 1
            Else
                mashit = RandomNumber(2, Porcentaje(.Stats.MaxSta, 5))

                .Counters.HPCounter = 0
                .Stats.MinHP = .Stats.MinHP + mashit
                If .Stats.MinHP > .Stats.MaxHP Then .Stats.MinHP = .Stats.MaxHP
                'WriteMensajes UserIndex, e_Mensajes.Mensaje_40
                EnviarStats = True
            End If
        End If
    End With

End Sub

Public Sub CargaNpcsDat()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim npcfile As String

    npcfile = DatPath & "NPCs.dat"
    Call LeerNPCs.Initialize(npcfile)
End Sub
Public Sub CuentaRegresiva()
    If CR > 0 Then
        If CR > 1 Then
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Conteo> " & CR - 1, FontTypeNames.FONTTYPE_CONSEJO))
        Else

            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Conteo> ¡Ya!", FontTypeNames.FONTTYPE_CONSEJO))
        End If
        CR = CR - 1
    End If
End Sub

Sub PasarSegundo()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler
    Dim i As Long
    Static ResetCrearPj As Long

    ResetCrearPj = ResetCrearPj + 1

    If ResetCrearPj >= 300 Then
        Call seguridad_clones_limpiar

        ResetCrearPj = 0
    End If

    ' @@ Torneos
    Call m_Torneo1vs1.Tick_AutoCancel_1vs1
    Call m_TorneoJDH.EventPassSecond
    Call m_TorneoXvsX.PassSecondXvsX
    Call m_TorneoDeath.CuentaDeath
    Call m_Torneo2vs2.Loop2vs2

    ' @@ Retos
    Call General.CuentaRegresiva
    Call m_Retos2vs2.Retos2vs2PassSecond
    Call m_Retos1vs1.Retos1vs1PassSecond

    For i = 1 To LastUser
        If UserList(i).flags.UserLogged Then

            If UserList(i).Counters.CooldownCentinela > 0 Then
                UserList(i).Counters.CooldownCentinela = UserList(i).Counters.CooldownCentinela - 1

                If UserList(i).Counters.CooldownCentinela < 1 Then
                    UserList(i).flags.CentinelaOK = False
                End If
            End If


            If UserList(i).CountDetectionErr > 0 Then
                UserList(i).CountDetectionErr = UserList(i).CountDetectionErr - 1

                If UserList(i).CountDetectionErr < 1 Then
                    UserList(i).CantErr = 0
                End If
            End If

            Call m_Retos2vs2.Loop_UserReto2vs2(i)
            Call m_Retos1vs1.Loop_UserReto1vs1(i)

            ' 2vs2
            If UserList(i).XvsX.Slot_ID > 0 Then
                If UserList(i).XvsX.Respawn_Time > 0 Then
                    UserList(i).XvsX.Respawn_Time = UserList(i).XvsX.Respawn_Time - 1
                    If UserList(i).XvsX.Respawn_Time < 1 Then
                        Call m_TorneoXvsX.RestoreCharAndRevive(i)
                    End If
                End If
            End If
            If UserList(i).Counters.lastPos > 0 Then    ' @@ que vuelva a su casita
                UserList(i).Counters.lastPos = UserList(i).Counters.lastPos - 1
                If UserList(i).Counters.lastPos <= 0 Then Call WriteConsoleMsg(i, "Has vuelto a tu posición anterior", FontTypeNames.FONTTYPE_INFO): Call WarpUserCharX(i, UserList(i).flags.lastPos.Map, UserList(i).flags.lastPos.X, UserList(i).flags.lastPos.Y, True)
            End If

            Call actualizarAntiCheat(i)
            'Call EXP_BONUS_Tick(i)

            If UserList(i).ConnIDValida Then
                If EnPausa = False And UserList(i).Counters.IdleCount > CONFIG_INI_IDLEKICKTOLERANCE Then    '@@PATCH
                    UserList(i).flags.CuentaPq = UserList(i).flags.CuentaPq + 1
                    If UserList(i).flags.CuentaPq > 20 Then
                        If frmMain.chkDebug.value = 1 Then
                            Debug.Print Now, "UI: " & i & ", CuentaPq:" & UserList(i).flags.CuentaPq, UserList(i).Name
                        End If
                        Call WriteDisconnect(i)
                        'Call Flushbuffer(i)
                        Call CloseSocket(i)
                        UserList(i).flags.CuentaPq = 0
                    End If
                End If
            End If

            'Cerrar usuario
            If UserList(i).Counters.Saliendo Then
                UserList(i).Counters.Salir = UserList(i).Counters.Salir - 1
                If UserList(i).Counters.Salir = 10 Then Call WriteConsoleMsg(i, "Cerrando...Se cerrará el juego en " & UserList(i).Counters.Salir & " segundos...", FontTypeNames.FONTTYPE_INFO)

                If UserList(i).Counters.Salir <= 0 Then

                    If frmMain.chkDebug2.value = 1 Then
                        Debug.Print Now, "/SALIR: " & i & ", CuentaPq:" & UserList(i).flags.CuentaPq, UserList(i).Name
                    End If

                    WriteMensajes i, e_Mensajes.Mensaje_41
                    Call WriteDisconnect(i)
                    'Call Flushbuffer(i)
                    Call CloseSocket(i)
                End If
            Else
                If UserList(i).Counters.ForceDeslog Then
                    UserList(i).Counters.ForceDeslog = UserList(i).Counters.ForceDeslog - 1
                    If UserList(i).Counters.ForceDeslog <= 0 Then
                        WriteMensajes i, e_Mensajes.Mensaje_41
                        Call WriteDisconnect(i)
                        Call CloseSocket(i)
                    End If
                End If
            End If
        Else
            If UserList(i).ConnIDValida Then
                UserList(i).Counters.IdleCount = UserList(i).Counters.IdleCount + 1

                If frmMain.chkDebug.value = 1 Then
                    Debug.Print Now, "UI: " & i & ",IdleKckToler:" & UserList(i).Counters.IdleCount, UserList(i).Name
                End If

                If UserList(i).Counters.IdleCount > CONFIG_INI_IDLECREATEKICKTOLERANCE Then    '@@PATCH
                    UserList(i).Counters.IdleCount = 0
                    Call WriteErrorMsg(i, "Demasiado tiempo inactivo.")
                    Call CloseSocket(i)
                End If
            End If
        End If
    Next i

    Call modPutOutBytes.PutInfoBytes

    '    frmMain.sck_PostWEB.Close

    Exit Sub

Errhandler:
    Call LogError("Error en PasarSegundo. Err: " & Err.Description & " - " & Err.Number & " - UserIndex: " & i)
    Resume Next
End Sub

Public Function ReiniciarAutoUpdate() As Double
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    ReiniciarAutoUpdate = Shell(App.path & "\autoupdater\aoau.exe", vbMinimizedNoFocus)

End Function

Public Sub ReiniciarServidor(Optional ByVal EjecutarLauncher As Boolean = True)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'WorldSave
    Call ES.DoBackUp

    'PARTY 9010
    'Guardar Pjs
    Call GuardarUsuarios

    If EjecutarLauncher Then Shell (App.path & "\launcher.exe")

    'Chauuu
    Unload frmMain

End Sub


Sub GuardarUsuarios()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next

    haciendoBK = True

    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle())
    Call SendData(SendTarget.ToAll, 0, PrepareMessageMensaje(e_Mensajes.Mensaje_43))

    Dim i As Long

114 For i = 1 To LastUser
116     If UserList(i).flags.UserLogged Then
118         Call SaveUser(i, CharPath & UCase$(UserList(i).Name) & ".chr")
        End If
120 Next i

    For i = 1 To LastUser
        If UserList(i).flags.UserLogged And UserList(i).ConnIDValida Then
            If Len(UserList(i).Name) Then
                Call mod_DB.Update_DataBase_UserIndex(i, UserList(i).Pin, UserList(i).Pass)
            End If
        End If
    Next i

    Call SendData(SendTarget.ToAll, 0, PrepareMessageMensaje(e_Mensajes.Mensaje_44))
    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle())


    haciendoBK = False

End Sub

Public Sub FreeNPCs()
'***************************************************
'Autor: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 05/17/06
'Releases all NPC Indexes
'***************************************************
    Dim LoopC As Long

    ' Free all NPC indexes
    For LoopC = 1 To MAXNPCS
        Npclist(LoopC).flags.NPCActive = False
    Next LoopC
End Sub

Public Sub FreeCharIndexes()
'***************************************************
'Autor: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 05/17/06
'Releases all char indexes
'***************************************************
' Free all char indexes (set them all to 0)
    Call ZeroMemory(CharList(1), MAXCHARS * Len(CharList(1)))
End Sub

Public Function EsMascota_And_Elemental(ByVal NpcIndex As Integer) As Boolean
    With Npclist(NpcIndex)
        If .Numero = 92 Or _
           .Numero = 93 Or _
           .Numero = 94 Or _
           .Numero = 512 Or _
           .Numero = 546 Or (.flags.Domable > 0) Then

            EsMascota_And_Elemental = True

        Else
            EsMascota_And_Elemental = False
        End If
    End With
End Function

Public Function IsValidIPAddress(ByVal IP As String) As Boolean

    On Error GoTo Handler

    Dim varAddress As Variant, N As Long, lCount As Long
100 varAddress = Split(IP, ".", 4, vbTextCompare)

102 If IsArray(varAddress) Then

104     For N = LBound(varAddress) To UBound(varAddress)
106         lCount = lCount + 1
108         varAddress(N) = CByte(varAddress(N))
        Next

110     IsValidIPAddress = (lCount = 4)

    End If

Handler:

End Function

Function Ceil(X As Variant) As Variant

    On Error GoTo Ceil_Err

100 Ceil = IIf(Fix(X) = X, X, Fix(X) + 1)

    Exit Function

Ceil_Err:
102 Call LogError("Ceil_Err en " & Erl & ". err: " & Err.Number & " " & Err.Description)


End Function

Function Clamp(X As Variant, a As Variant, b As Variant) As Variant

    On Error GoTo Clamp_Err

100 Clamp = IIf(X < a, a, IIf(X > b, b, X))

    Exit Function

Clamp_Err:
102 Call LogError("Clamp_Err en " & Erl & ". err: " & Err.Number & " " & Err.Description)


End Function

Private Function GetElapsed() As Single
    Static sTime1 As Currency
    Static sTime2 As Currency
    Static sFrequency As Currency

    'Get the timer frequency
    If sFrequency = 0 Then
        Call QueryPerformanceFrequency(sFrequency)
    End If

    'Get current time
    Call QueryPerformanceCounter(sTime1)

    'Calculate elapsed time
    GetElapsed = ((sTime1 - sTime2) / sFrequency * 1000)

    'Get next end time
    Call QueryPerformanceCounter(sTime2)
End Function

Public Sub SetTriggerIlegalNPC(ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte)
    Exit Sub
    Dim LoopX As Long, LoopY As Long

    For LoopX = X - 2 To X + 2
        For LoopY = Y - 2 To Y + 2
            If InMapBounds(Map, LoopX, LoopY) Then
                If MapData(Map, LoopX, LoopY).trigger <> eTrigger.ZONAPELEA Then
                    MapData(Map, LoopX, LoopY).trigger = eTrigger.POSINVALIDA
                End If
            End If
        Next LoopY
    Next LoopX

End Sub

Public Sub RemoveTriggerIlegalNPC(ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte)
    Exit Sub
    Dim LoopX As Long, LoopY As Long

    For LoopX = X - 2 To X + 2
        For LoopY = Y - 2 To Y + 2
            If InMapBounds(Map, LoopX, LoopY) Then
                If MapData(Map, LoopX, LoopY).trigger = eTrigger.POSINVALIDA Then
                    MapData(Map, LoopX, LoopY).trigger = 0
                End If
            End If
        Next LoopY
    Next LoopX

End Sub

Public Sub BorrarPersonaje(ByVal UserIndex As Integer, ByVal Name As String, ByVal Password As String, ByVal Pin As String, ByVal Email As String)

    On Error GoTo Errhandler

6   If Len(Name) = 0 Then Call WriteConsoleMsg(UserIndex, "El personaje no existe"): Exit Sub
7   If Not AsciiValidos(Name) Then Call WriteConsoleMsg(UserIndex, "El personaje no existe"): Exit Sub
8   If Not PersonajeExiste(Name) Then Call WriteConsoleMsg(UserIndex, "El personaje no existe"): Exit Sub

    If EsGM(UserIndex) Then
        If UCase$(Name) = UCase$(UserList(UserIndex).Name) Then
            Exit Sub
        End If
    End If
12  If Password <> GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password") Then
13      Call WriteConsoleMsg(UserIndex, "Password incorrecto.")
        Exit Sub
    End If

14  If Email <> GetVar(CharPath & UCase$(Name) & ".chr", "CONTACTO", "Email") Then
15      Call WriteConsoleMsg(UserIndex, "Email incorrecto.")
        Exit Sub
    End If

16  If Pin <> GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Pin") Then
17      Call WriteConsoleMsg(UserIndex, "Pin incorrecto.")
        Exit Sub
    End If

9   If Not (Name = UCase$(UserList(UserIndex).Name)) Then    ' @@ Si es otro nick
10      If Not NameIndex(Name) = 0 Then Call WriteConsoleMsg(UserIndex, "El personaje " & Name & " se encuentra conectado!"): Exit Sub    ' @@ Si está logueado no lo podemos borrar.
11  End If

    With UserList(UserIndex)

        If Not EsGM(UserIndex) Then
            If val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes")) = 0 Then
                Call WriteConsoleMsg(UserIndex, "Comando deshabilitado por los Administradores!")
                Exit Sub
            End If
            Dim limite As Byte

            limite = val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax"))
            If limite = 0 Then limite = 13

            If .flags.Comerciando Then Call WriteConsoleMsg(UserIndex, "Debes dejar de comerciar!"): Exit Sub
            If .GuildIndex > 0 Then Call WriteConsoleMsg(UserIndex, "Debes salir del clan!"): Exit Sub
        End If

    End With

    ''
18  If Name = UCase$(UserList(UserIndex).Name) Then
        If UserList(UserIndex).Stats.ELV > val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax")) Then Call WriteConsoleMsg(UserIndex, "Tu nivel no permite realizar el borrado de personaje. Nivel máximo permitido: " & val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax"))): Exit Sub
19      Call CloseSocket(UserIndex)
    Else
        If val(GetVar(CharPath & UCase$(Name) & ".chr", "STATS", "ELV")) > val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax")) Then Call WriteConsoleMsg(UserIndex, "El nivel del personaje no está permitido para realizar reset. Nivel máximo permitido: " & val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax"))): Exit Sub
        If val(GetVar(CharPath & UCase$(Name) & ".chr", "GUILD", "GuildIndex")) > 0 Then Call WriteConsoleMsg(UserIndex, "El usuario se encuentra en un clan! Debe salir primero del clan para borrar ese personaje!"): Exit Sub

        Call WriteConsoleMsg(UserIndex, "Servidor> El personaje " & Chr(34) & Name & Chr(34) & " ha sido borrado correctamente!!")
    End If

20  Call KillCharINFO(Name)    ' @@ le borramos de los clanes

    Dim fso As Object
21  Set fso = CreateObject("Scripting.FileSystemObject")

22  If Not fso.FolderExists(CharPathDeleted) Then
23      fso.CreateFolder CharPathDeleted
    End If

    Dim count As Integer, nickFinal As String
24  count = 1
25  nickFinal = CharPathDeleted & Name & ".chr"

26  Do While fso.FileExists(nickFinal)
27      nickFinal = CharPathDeleted & Left(Name & ".chr", Len(Name & ".chr") - 4) & "_" & count & ".chr"
28      count = count + 1
    Loop

29  fso.MoveFile CharPath & Name & ".chr", nickFinal

30  Set fso = Nothing

    If val(GetVar(nickFinal, "STATS", "ELV")) < val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_MinLevelToSave")) Then
        Kill nickFinal
    End If

    If frmMain.sck_PostWEB.State = 7 Then        ' está conectado?
        frmMain.sck_PostWEB.SendData ("|4" & "BORRAR_PJ_WEB=" & 12345 & "&nick=" & Name)
    End If

    Exit Sub

Errhandler:
    Call LogError("BorrarPersonaje en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Function BorrarPersonajeWeb(ByRef ErrMsg As String, ByVal Name As String, ByVal Password As String, ByVal Pin As String) As Boolean

    On Error GoTo Errhandler

    If val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes")) = 0 Then
        ErrMsg = "Comando deshabilitado por los Administradores!": Exit Function
    End If

6   If Len(Name) = 0 Then ErrMsg = "El personaje no existe": Exit Function
7   If Not AsciiValidos(Name) Then ErrMsg = "El personaje no existe": Exit Function
8   If Not PersonajeExiste(Name) Then ErrMsg = "El personaje no existe": Exit Function

12  If Password <> GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password") Then
13      ErrMsg = "Password incorrecto."
        Exit Function
    End If

    '14  If Email <> GetVar(CharPath & UCase$(Name) & ".chr", "CONTACTO", "Email") Then
    '15      ErrMsg = "Email incorrecto."
    '        Exit Function
    '    End If

16  If Pin <> GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Pin") Then
17      ErrMsg = "Pin incorrecto."
        Exit Function
    End If

10  If Not NameIndex(Name) = 0 Then ErrMsg = "El personaje " & Name & " se encuentra conectado!": Exit Function    ' @@ Si está logueado no lo podemos borrar.

    Dim limite As Byte

    limite = val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax"))
    If limite = 0 Then limite = 13

    If val(GetVar(CharPath & UCase$(Name) & ".chr", "STATS", "ELV")) > val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax")) Then ErrMsg = "El nivel del personaje no está permitido para realizar reset. Nivel máximo permitido: " & val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_NivelMax")): Exit Function
    If val(GetVar(CharPath & UCase$(Name) & ".chr", "GUILD", "GuildIndex")) > 0 Then ErrMsg = "El usuario se encuentra en un clan! Debe salir primero del clan para borrar ese personaje!": Exit Function

    BorrarPersonajeWeb = True
    ErrMsg = 0

20  Call KillCharINFO(Name)    ' @@ le borramos de los clanes

    Dim fso As Object
21  Set fso = CreateObject("Scripting.FileSystemObject")

22  If Not fso.FolderExists(CharPathDeleted) Then
23      fso.CreateFolder CharPathDeleted
    End If

    Dim count As Integer, nickFinal As String
24  count = 1
25  nickFinal = CharPathDeleted & Name & ".chr"

26  Do While fso.FileExists(nickFinal)
27      nickFinal = CharPathDeleted & Left(Name & ".chr", Len(Name & ".chr") - 4) & "_" & count & ".chr"
28      count = count + 1
    Loop

29  fso.MoveFile CharPath & Name & ".chr", nickFinal

30  Set fso = Nothing

    If val(GetVar(nickFinal, "STATS", "ELV")) < val(GetVar(IniPath & "server.ini", "INIT", "BorrarPersonajes_MinLevelToSave")) Then
        Kill nickFinal
    End If

    Exit Function

Errhandler:
    Call LogError("BorrarPersonajeWeb en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Public Sub ResetearPersonaje(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    Dim i As Long
    Dim limite As Byte
    Dim Slot As Byte

    With UserList(UserIndex)
        If Not EsGM(UserIndex) Then
            If val(GetVar(IniPath & "server.ini", "INIT", "ResetearPersonajes")) = 0 Then
                Call WriteConsoleMsg(UserIndex, "Comando deshabilitado por los Administradores!")
                Exit Sub
            End If

            limite = val(GetVar(IniPath & "server.ini", "INIT", "ResetearPersonajes_NivelMax"))
            If limite = 0 Then limite = 13

            If .Stats.ELV > val(GetVar(IniPath & "server.ini", "INIT", "ResetearPersonajes_NivelMax")) Then Call WriteConsoleMsg(UserIndex, "Tu nivel no permite realizar el reset."): Exit Sub
            If .flags.Comerciando Then
                Call WriteConsoleMsg(UserIndex, "Debes dejar de comerciar!")
                Exit Sub
            End If
            If .PartyIndex > 0 Then
                Call WriteConsoleMsg(UserIndex, "Debes salir de la party!")
                Exit Sub
            End If
            If .GuildIndex > 0 Then
                Call WriteConsoleMsg(UserIndex, "Debes salir del clan!")
                Exit Sub
            End If

            If .flags.mao_index > 0 Then
                Call WriteConsoleMsg(UserIndex, "Debes salir del mercado!")
                Exit Sub
            End If
        End If

        If .Stats.ELV > 5 Then
            Call LogReset(.Name & " reseteó su personaje siendo nivel " & .Stats.ELV & ". Pos: " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y)
        End If

        .Stats.ELV = 1

        .Stats.MaxHIT = 2
        .Stats.MinHIT = 1

        .Stats.UserAtributos(eAtributos.Fuerza) = 18 + ModRaza(.raza).Fuerza
        .Stats.UserAtributos(eAtributos.Agilidad) = 18 + ModRaza(.raza).Agilidad
        .Stats.UserAtributos(eAtributos.Inteligencia) = 18 + ModRaza(.raza).Inteligencia
        .Stats.UserAtributos(eAtributos.Carisma) = 18 + ModRaza(.raza).Carisma
        .Stats.UserAtributos(eAtributos.Constitucion) = 18 + ModRaza(.raza).Constitucion

        If .Invent.ArmourEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.ArmourEqpSlot, False)
        End If
        If .Invent.WeaponEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.WeaponEqpSlot, False)
        End If
        If .Invent.CascoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.CascoEqpSlot, False)
        End If
        If .Invent.AnilloEqpSlot > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot, False)
        End If
        If .Invent.AnilloEqpSlot2 > 0 Then
            Call Desequipar(UserIndex, .Invent.AnilloEqpSlot2, False)
        End If
        If .Invent.MunicionEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.MunicionEqpSlot, False)
        End If
        If .Invent.EscudoEqpObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.EscudoEqpSlot, False)
        End If
        If .Invent.BarcoObjIndex > 0 Then
            Call Desequipar(UserIndex, .Invent.BarcoSlot, False)
        End If

        If .Char.loops = INFINITE_LOOPS Then
            .Char.FX = 0
            .Char.loops = 0
        End If

        For i = 1 To NUMATRIBUTOS
            Call WriteVar(App.path & "/CHARFILE/" & UCase$(.Name) & ".CHR", "ATRIBUTOS", "AT" & i, .Stats.UserAtributos(i))
        Next i

        .Stats.MaxSta = 40
        .Stats.minSta = 40

        If .Clase = eClass.Mage Then         'Cambio en mana inicial (ToxicWaste)

            .Stats.MaxMAN = 100    'RandomNumber(100, 105)
            .Stats.MinMAN = .Stats.MinMAN
        ElseIf .Clase = eClass.Cleric Or .Clase = eClass.Druid Or .Clase = eClass.Bard Or .Clase = eClass.Assasin Then
            .Stats.MaxMAN = 50
            .Stats.MinMAN = 50
        Else
            .Stats.MaxMAN = 0
            .Stats.MinMAN = 0
        End If


        If .Clase = eClass.Warrior And .raza = eRaza.Enano Then
            .Stats.MaxHP = RandomNumber(19, 22)
        Else
            .Stats.MaxHP = RandomNumber(19, 21)
        End If

        .Stats.MinHP = .Stats.MaxHP
        .Stats.MinHP = .Stats.MaxHP
        .Stats.MinMAN = .Stats.MaxMAN

        'For i = 1 To MAXUSERHECHIZOS
        '    .Stats.UserHechizos(i) = 0
        'Next i
        'If .Clase = eClass.Mage Or .Clase = eClass.Cleric Or .Clase = eClass.Druid Or .Clase = eClass.Bard Or .Clase = eClass.Assasin Then
        '    .Stats.UserHechizos(1) = 2
        'End If
        'Call UpdateUserHechizos(True, userindex, 0)

        .Stats.CriminalesMatados = 0
        .Stats.NPCsMuertos = 0
        .Stats.OroGanado = 0
        .Stats.OroPerdido = 0
        .flags.TargetNPC = 0
        .flags.TargetNPC = 0
        .flags.TargetNpcTipo = 0
        .flags.Desnudo = 0
        .flags.Envenenado = 0

        Call WriteUpdateEnvenenado(UserIndex)

        .Stats.Exp = 0
        .Stats.elu = 300

        .Stats.MinAGU = 100: .Stats.MaxAGU = 100
        .Stats.MinHam = 100: .Stats.MaxHam = 100

        If .Invent.EscudoEqpSlot = 0 Then .Char.ShieldAnim = NingunEscudo
        If .Invent.CascoEqpSlot = 0 Then .Char.CascoAnim = NingunCasco
        If .Invent.WeaponEqpSlot = 0 Then .Char.WeaponAnim = NingunArma

        .Stats.NPCsMuertos = 0
        .Stats.OroGanado = 0
        .Stats.OroPerdido = 0
        .Stats.ParticipoClanes = 0
        .Stats.PuntosFotodenuncia = 0
        .Stats.RetosGanados = 0
        .Stats.RetosPerdidos = 0
        .Stats.UsuariosMatados = 0

15      For i = 1 To NUMSKILLS
            .Stats.UserSkills(i) = 0
16          Call CheckEluSkill(UserIndex, i, True)
        Next i

        .Stats.MaxAGU = 100
        .Stats.MinAGU = 100

        .Stats.MaxHam = 100
        .Stats.MinHam = 100

        .Reputacion.AsesinoRep = 0
        .Reputacion.BandidoRep = 0
        .Reputacion.BurguesRep = 0
        .Reputacion.LadronesRep = 0
        .Reputacion.NobleRep = 1000
        .Reputacion.PlebeRep = 30


        For i = 1 To MAX_INVENTORY_SLOTS
            .Invent.Object(i).Amount = 0
            .Invent.Object(i).Equipped = 0
            .Invent.Object(i).ObjIndex = 0
            .Invent.Object(i).RareDrop = 0
        Next i

        Slot = 1    'Pociones Rojas (Newbie)
        .Invent.Object(Slot).ObjIndex = 461
        .Invent.Object(Slot).Amount = 200

        'Pociones azules (Newbie)
        If .Stats.MaxMAN > 0 Or .Clase = eClass.Paladin Then
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 462
            .Invent.Object(Slot).Amount = 200
        Else
            'Pociones amarillas (Newbie)
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 650
            .Invent.Object(Slot).Amount = 100
            'Pociones verdes (Newbie)
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 651
            .Invent.Object(Slot).Amount = 50
        End If

        ' Ropa (Newbie)
        Slot = Slot + 1
        Select Case .raza
        Case eRaza.Humano
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Elfo
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Drow
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Enano
            .Invent.Object(Slot).ObjIndex = 466
        Case eRaza.Gnomo
            .Invent.Object(Slot).ObjIndex = 466
        End Select

        ' Equipo ropa
        .Invent.Object(Slot).Amount = 1
        .Invent.Object(Slot).Equipped = 1

        .Invent.ArmourEqpSlot = Slot
        .Invent.ArmourEqpObjIndex = .Invent.Object(Slot).ObjIndex
        .Char.body = ObjData(.Invent.Object(Slot).ObjIndex).Ropaje

        Slot = Slot + 1
        Select Case .Clase
        Case eClass.Hunter
            ' Arco (Newbie)
            .Invent.Object(Slot).ObjIndex = 839
        Case Else
            ' Daga (Newbie)
            .Invent.Object(Slot).ObjIndex = 460
        End Select

        .Invent.Object(Slot).Amount = 1
        .Invent.Object(Slot).Equipped = 1

        .Invent.WeaponEqpObjIndex = .Invent.Object(Slot).ObjIndex
        .Invent.WeaponEqpSlot = Slot

        .Char.WeaponAnim = GetWeaponAnim(UserIndex, .Invent.WeaponEqpObjIndex)

        ' Municiones (Newbie)
41      If .Clase = eClass.Hunter Then
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 838
            .Invent.Object(Slot).Amount = 150

            ' Equipo flechas
            .Invent.Object(Slot).Equipped = 1
            .Invent.MunicionEqpSlot = Slot
            .Invent.MunicionEqpObjIndex = 838
        End If

        ' Manzanas (Newbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 467
        .Invent.Object(Slot).Amount = 100

        ' Jugos (Nwbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 468
        .Invent.Object(Slot).Amount = 100

        'Valores Default de facciones al Activar nuevo usuario
        Call ResetFacciones(UserIndex)

        .Stats.SkillPts = 10
        .Stats.AsignoSkills = 0

21      Call UpdateUserInv(True, UserIndex, 0)

94      Call CheckUserLevel(UserIndex)
95      Call WriteUpdateUserStats(UserIndex)

96      Call WriteUpdateHungerAndThirst(UserIndex)
97      Call WriteUpdateStrenghtAndDexterity(UserIndex)

        Call WriteUpdateUserStats(UserIndex)

        If .Stats.SkillPts > 0 Then
            Call WriteSendSkills(UserIndex)
        End If

118     Call WriteLevelUp(UserIndex, .Stats.SkillPts)

        Call WriteConsoleMsg(UserIndex, "Personaje reseteado. Debes asignar tus 10 skills iniciales.")
        Call WarpUserChar(UserIndex, .Pos.Map, .Pos.X, .Pos.Y, False)

    End With

    Exit Sub
Errhandler:
    Call LogError("Error al resetear personaje en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub RemoveParalisis(ByVal UserIndex As Integer)

    With UserList(UserIndex)
        .flags.Paralizado = 0
        .flags.Inmovilizado = 0
        .flags.ParalizedBy = vbNullString
        .flags.ParalizedByIndex = 0
        .flags.ParalizedByNpcIndex = 0
        .Counters.Paralisis = 0
        Call WriteParalizeOK(UserIndex)

        If .Counters.TickReactionRemoInv > 0 Then
            Dim TActual As Long
            TActual = GetTickCount() And &H7FFFFFFF

            If TActual - .Counters.TickReactionRemoInv < 100 Then    ' getInterval(TActual, .Counters.TickReactionRemoInv) < 100 Then
                Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - posible uso de macro auto remo - Tiempo Reaccion: " & .Counters.TickReactionRemoInv - TActual, FontTypeNames.FONTTYPE_SERVER))
            End If

            .Counters.TickReactionRemoInv = 0
        End If
    End With

End Sub
