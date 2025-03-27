Attribute VB_Name = "ES"
Option Explicit
Public ExpMulti As Integer
Public OroMulti As Integer

Public Sub CargarSpawnList()


    Dim N As Integer, LoopC As Long
    N = val(GetVar(DatPath & "Invokar.dat", "INIT", "NumNPCs"))

    ReDim Declaraciones.SpawnList(N) As tCriaturasEntrenador

    For LoopC = 1 To N
        Declaraciones.SpawnList(LoopC).NpcIndex = val(GetVar(DatPath & "Invokar.dat", "LIST", "NI" & LoopC))
        Declaraciones.SpawnList(LoopC).NpcName = GetVar(DatPath & "Invokar.dat", "LIST", "NN" & LoopC)
    Next LoopC

End Sub


Function EsAdmin(ByRef Name As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 27/03/2011
'27/03/2011 - ZaMa: Utilizo la clase para saber los datos.
'***************************************************

    On Error GoTo EsAdmin_Err

100 EsAdmin = (val(Administradores.GetValue("Admin", Name)) = 1)

    Exit Function

EsAdmin_Err:
102 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.EsAdmin")


End Function

Function EsDios(ByRef Name As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: 27/03/2011
'27/03/2011 - ZaMa: Utilizo la clase para saber los datos.
'***************************************************

    On Error GoTo EsDios_Err

100 EsDios = (val(Administradores.GetValue("Dios", Name)) = 1)


    Exit Function

EsDios_Err:
102 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.EsDios")


End Function

Function EsSemiDios(ByRef Name As String) As Boolean
    On Error GoTo EsSemiDios_Err
100 EsSemiDios = (val(Administradores.GetValue("SemiDios", Name)) = 1)
    Exit Function
EsSemiDios_Err:
102 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.EsSemiDios")
End Function

Function EsConsejero(ByRef Name As String) As Boolean
    On Error GoTo EsConsejero_Err
100 EsConsejero = (val(Administradores.GetValue("Consejero", Name)) = 1)
    Exit Function
EsConsejero_Err:
102 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.EsConsejero")
End Function

Function EsRolesMaster(ByRef Name As String) As Boolean
    On Error GoTo EsRolesMaster_Err
100 EsRolesMaster = (val(Administradores.GetValue("RM", Name)) = 1)
    Exit Function
EsRolesMaster_Err:
102 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.EsRolesMaster")
End Function

Public Sub loadNPCS()
    On Error GoTo loadNPCS_Err

104 Set NPCS_Dat = New clsIniManager
106 Call NPCS_Dat.Initialize(DatPath & "npcs.dat")
    Dim i As Long
    Exit Sub
loadNPCS_Err:
190 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.loadNPCS")
End Sub

Public Sub loadAdministrativeUsers()

    On Error GoTo loadAdministrativeUsers_Err

    Dim buf As Integer
    Dim i As Long
    Dim Name As String

    Dim TempName() As String

102 Set Administradores = New clsIniManager

    Dim ServerIni As clsIniManager
104 Set ServerIni = New clsIniManager
106 Call ServerIni.Initialize(IniPath & "Server.ini")

108 buf = val(ServerIni.GetValue("INIT", "Admines"))

110 For i = 1 To buf
112     Name = UCase$(ServerIni.GetValue("Admines", "Admin" & i))
114     TempName = Split(Name, "|", , vbTextCompare)

120     Call Administradores.ChangeValue("Admin", TempName(0), "1")
        '            End If

122 Next i

    ' Dioses
124 buf = val(ServerIni.GetValue("INIT", "Dioses"))

126 For i = 1 To buf
128     Name = UCase$(ServerIni.GetValue("Dioses", "Dios" & i))
130     TempName = Split(Name, "|", , vbTextCompare)

136     Call Administradores.ChangeValue("Dios", TempName(0), "1")


138 Next i

    ' SemiDioses
140 buf = val(ServerIni.GetValue("INIT", "SemiDioses"))

142 For i = 1 To buf
144     Name = UCase$(ServerIni.GetValue("SemiDioses", "SemiDios" & i))
146     TempName = Split(Name, "|", , vbTextCompare)


        ' Add key
152     Call Administradores.ChangeValue("SemiDios", TempName(0), "1")
        '

154 Next i

    ' Consejeros
156 buf = val(ServerIni.GetValue("INIT", "Consejeros"))

158 For i = 1 To buf
160     Name = UCase$(ServerIni.GetValue("Consejeros", "Consejero" & i))
162     TempName = Split(Name, "|", , vbTextCompare)

        ' Add key
168     Call Administradores.ChangeValue("Consejero", TempName(0), "1")
        '            End If

170 Next i

    ' RolesMasters
172 buf = val(ServerIni.GetValue("INIT", "RolesMasters"))

174 For i = 1 To buf
176     Name = UCase$(ServerIni.GetValue("RolesMasters", "RM" & i))
178     TempName = Split(Name, "|", , vbTextCompare)

        ' Add key
184     Call Administradores.ChangeValue("RM", TempName(0), "1")
        '            End If

186 Next i

188 Set ServerIni = Nothing

    'If frmMain.Visible Then frmMain.txtStatus.Text = Date & " " & Time & " - Los Administradores/Dioses/Gms se han cargado correctamente."

    Exit Sub

loadAdministrativeUsers_Err:
190 Call LogError("Error en " & Erl & " Err: " & Err.Number & " " & Err.Description & " " & "ES.loadAdministrativeUsers")


End Sub


Public Function TxtDimension(ByVal Name As String) As Long
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim N As Integer, cad As String, Tam As Long
    N = FreeFile(1)
    Open Name For Input As #N
    Tam = 0
    Do While Not EOF(N)
        Tam = Tam + 1
        Line Input #N, cad
    Loop
    Close N
    TxtDimension = Tam
End Function

Public Sub CargarForbidenWords()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    ReDim ForbidenNames(1 To TxtDimension(DatPath & "NombresInvalidos.txt"))
    Dim N As Integer, i As Integer
    N = FreeFile(1)
    Open DatPath & "NombresInvalidos.txt" For Input As #N

    For i = 1 To UBound(ForbidenNames)
        Line Input #N, ForbidenNames(i)
    Next i

    Close N

End Sub

Public Sub CargarHechizos()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

'###################################################
'#               ATENCION PELIGRO                  #
'###################################################
'
'  ¡¡¡¡ NO USAR GetVar PARA LEER Hechizos.dat !!!!
'
'El que ose desafiar esta LEY, se las tendrá que ver
'con migo. Para leer Hechizos.dat se deberá usar
'la nueva clase clsLeerInis.
'
'Alejo
'
'###################################################

    On Error GoTo Errhandler

    Dim Hechizo As Long
    Dim Leer As New clsIniManager

    Call Leer.Initialize(DatPath & "Hechizos.dat")

    'obtiene el numero de hechizos
    NumeroHechizos = val(Leer.GetValue("INIT", "NumeroHechizos"))

    ReDim Hechizos(1 To NumeroHechizos) As tHechizo

    'Llena la lista
    For Hechizo = 1 To NumeroHechizos
        With Hechizos(Hechizo)
            .Nombre = Leer.GetValue("Hechizo" & Hechizo, "Nombre")
            .Desc = Leer.GetValue("Hechizo" & Hechizo, "Desc")
            .PalabrasMagicas = Leer.GetValue("Hechizo" & Hechizo, "PalabrasMagicas")

            .HechizeroMsg = Leer.GetValue("Hechizo" & Hechizo, "HechizeroMsg")
            .TargetMsg = Leer.GetValue("Hechizo" & Hechizo, "TargetMsg")
            .PropioMsg = Leer.GetValue("Hechizo" & Hechizo, "PropioMsg")

            .tipo = val(Leer.GetValue("Hechizo" & Hechizo, "Tipo"))
            .WAV = val(Leer.GetValue("Hechizo" & Hechizo, "WAV"))
            .FXgrh = val(Leer.GetValue("Hechizo" & Hechizo, "Fxgrh"))
            .GrhTravel = val(Leer.GetValue("Hechizo" & Hechizo, "GrhTravel"))

            .loops = val(Leer.GetValue("Hechizo" & Hechizo, "Loops"))

            '    .Resis = val(Leer.GetValue("Hechizo" & Hechizo, "Resis"))

            .SubeHP = val(Leer.GetValue("Hechizo" & Hechizo, "SubeHP"))
            .MinHP = val(Leer.GetValue("Hechizo" & Hechizo, "MinHP"))
            .MaxHP = val(Leer.GetValue("Hechizo" & Hechizo, "MaxHP"))

            .SubeMana = val(Leer.GetValue("Hechizo" & Hechizo, "SubeMana"))
            .MiMana = val(Leer.GetValue("Hechizo" & Hechizo, "MinMana"))
            .MaMana = val(Leer.GetValue("Hechizo" & Hechizo, "MaxMana"))

            .SubeSta = val(Leer.GetValue("Hechizo" & Hechizo, "SubeSta"))
            .minSta = val(Leer.GetValue("Hechizo" & Hechizo, "MinSta"))
            .MaxSta = val(Leer.GetValue("Hechizo" & Hechizo, "MaxSta"))

            .SubeHam = val(Leer.GetValue("Hechizo" & Hechizo, "SubeHam"))
            .MinHam = val(Leer.GetValue("Hechizo" & Hechizo, "MinHam"))
            .MaxHam = val(Leer.GetValue("Hechizo" & Hechizo, "MaxHam"))

            .SubeSed = val(Leer.GetValue("Hechizo" & Hechizo, "SubeSed"))
            .MinSed = val(Leer.GetValue("Hechizo" & Hechizo, "MinSed"))
            .MaxSed = val(Leer.GetValue("Hechizo" & Hechizo, "MaxSed"))

            .SubeAgilidad = val(Leer.GetValue("Hechizo" & Hechizo, "SubeAG"))
            .MinAgilidad = val(Leer.GetValue("Hechizo" & Hechizo, "MinAG"))
            .MaxAgilidad = val(Leer.GetValue("Hechizo" & Hechizo, "MaxAG"))

            .SubeFuerza = val(Leer.GetValue("Hechizo" & Hechizo, "SubeFU"))
            .MinFuerza = val(Leer.GetValue("Hechizo" & Hechizo, "MinFU"))
            .MaxFuerza = val(Leer.GetValue("Hechizo" & Hechizo, "MaxFU"))

            .SubeCarisma = val(Leer.GetValue("Hechizo" & Hechizo, "SubeCA"))
            .MinCarisma = val(Leer.GetValue("Hechizo" & Hechizo, "MinCA"))
            .MaxCarisma = val(Leer.GetValue("Hechizo" & Hechizo, "MaxCA"))


            .Invisibilidad = val(Leer.GetValue("Hechizo" & Hechizo, "Invisibilidad"))
            .Paraliza = val(Leer.GetValue("Hechizo" & Hechizo, "Paraliza"))
            .Inmoviliza = val(Leer.GetValue("Hechizo" & Hechizo, "Inmoviliza"))
            .RemoverParalisis = val(Leer.GetValue("Hechizo" & Hechizo, "RemoverParalisis"))
            .RemoverEstupidez = val(Leer.GetValue("Hechizo" & Hechizo, "RemoverEstupidez"))
            .RemueveInvisibilidadParcial = val(Leer.GetValue("Hechizo" & Hechizo, "RemueveInvisibilidadParcial"))


            .CuraVeneno = val(Leer.GetValue("Hechizo" & Hechizo, "CuraVeneno"))
            .Envenena = val(Leer.GetValue("Hechizo" & Hechizo, "Envenena"))
            .Revivir = val(Leer.GetValue("Hechizo" & Hechizo, "Revivir"))

            .Ceguera = val(Leer.GetValue("Hechizo" & Hechizo, "Ceguera"))
            .Estupidez = val(Leer.GetValue("Hechizo" & Hechizo, "Estupidez"))

            .Warp = val(Leer.GetValue("Hechizo" & Hechizo, "Warp"))

            .Invoca = val(Leer.GetValue("Hechizo" & Hechizo, "Invoca"))
            .NumNpc = val(Leer.GetValue("Hechizo" & Hechizo, "NumNpc"))
            .Cant = val(Leer.GetValue("Hechizo" & Hechizo, "Cant"))
            .Mimetiza = val(Leer.GetValue("hechizo" & Hechizo, "Mimetiza"))

            '    .Materializa = val(Leer.GetValue("Hechizo" & Hechizo, "Materializa"))
            '    .ItemIndex = val(Leer.GetValue("Hechizo" & Hechizo, "ItemIndex"))

            .MinSkill = val(Leer.GetValue("Hechizo" & Hechizo, "MinSkill"))
            .ManaRequerido = val(Leer.GetValue("Hechizo" & Hechizo, "ManaRequerido"))

            'Barrin 30/9/03
            .StaRequerido = val(Leer.GetValue("Hechizo" & Hechizo, "StaRequerido"))

            .Target = val(Leer.GetValue("Hechizo" & Hechizo, "Target"))

            .NeedStaff = val(Leer.GetValue("Hechizo" & Hechizo, "NeedStaff"))
            .StaffAffected = CBool(val(Leer.GetValue("Hechizo" & Hechizo, "StaffAffected")))
        End With
    Next Hechizo

    Set Leer = Nothing

    Exit Sub

Errhandler:
    MsgBox "Error cargando hechizos.dat " & Err.Number & ": " & Err.Description

End Sub

Public Sub DoBackUp()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    haciendoBK = True

    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle())


    Call LimpiarMundo
    Call WorldSave
    Call modGuilds.v_RutinaElecciones
    Call ResetCentinelaInfo
    Call GuardarUsuarios

    Call SendData(SendTarget.ToAll, 0, PrepareMessagePauseToggle())

    'Call EstadisticasWeb.Informar(EVENTO_NUEVO_CLAN, 0)

    haciendoBK = False

End Sub

Public Sub GrabarMapa(ByVal Map As Long, ByVal MAPFILE As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next
    Dim FreeFileMap As Long
    Dim FreeFileInf As Long
    Dim Y As Long
    Dim X As Long
    Dim ByFlags As Byte
    Dim TempInt As Integer
    Dim LoopC As Long

    If FileExist(MAPFILE & ".map", vbNormal) Then
        Kill MAPFILE & ".map"
    End If

    If FileExist(MAPFILE & ".inf", vbNormal) Then
        Kill MAPFILE & ".inf"
    End If

    'Open .map file
    FreeFileMap = FreeFile
    Open MAPFILE & ".Map" For Binary As FreeFileMap
    Seek FreeFileMap, 1

    'Open .inf file
    FreeFileInf = FreeFile
    Open MAPFILE & ".Inf" For Binary As FreeFileInf
    Seek FreeFileInf, 1
    'map Header

    Put FreeFileMap, , MapInfo(Map).MapVersion
    Put FreeFileMap, , MiCabecera
    Put FreeFileMap, , TempInt
    Put FreeFileMap, , TempInt
    Put FreeFileMap, , TempInt
    Put FreeFileMap, , TempInt

    'inf Header
    Put FreeFileInf, , TempInt
    Put FreeFileInf, , TempInt
    Put FreeFileInf, , TempInt
    Put FreeFileInf, , TempInt
    Put FreeFileInf, , TempInt

    'Write .map file
    For Y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize
            With MapData(Map, X, Y)
                ByFlags = 0

                If .Blocked Then ByFlags = ByFlags Or 1
                If .Graphic(2) Then ByFlags = ByFlags Or 2
                If .Graphic(3) Then ByFlags = ByFlags Or 4
                If .Graphic(4) Then ByFlags = ByFlags Or 8
                If .trigger Then ByFlags = ByFlags Or 16

                Put FreeFileMap, , ByFlags

                Put FreeFileMap, , .Graphic(1)

                For LoopC = 2 To 4
                    If .Graphic(LoopC) Then _
                       Put FreeFileMap, , .Graphic(LoopC)
                Next LoopC

                If .trigger Then _
                   Put FreeFileMap, , CInt(.trigger)

                '.inf file

                ByFlags = 0

                If .ObjInfo.ObjIndex > 0 Then
                    If ObjData(.ObjInfo.ObjIndex).OBJType = eOBJType.otFogata Then
                        .ObjInfo.ObjIndex = 0
                        .ObjInfo.Amount = 0
                    End If
                End If

                If .TileExit.Map Then ByFlags = ByFlags Or 1
                If .NpcIndex Then ByFlags = ByFlags Or 2
                If .ObjInfo.ObjIndex Then ByFlags = ByFlags Or 4

                Put FreeFileInf, , ByFlags

                If .TileExit.Map Then
                    Put FreeFileInf, , .TileExit.Map
                    Put FreeFileInf, , .TileExit.X
                    Put FreeFileInf, , .TileExit.Y
                    Put FreeFileInf, , .TileExit.Radio
                End If

                If .NpcIndex > 0 Then
                    If Npclist(.NpcIndex).Contadores.TiempoExistencia = 0 And Npclist(.NpcIndex).MaestroUser = 0 Then
                        Put FreeFileInf, , Npclist(.NpcIndex).Numero
                    End If
                End If

                If .ObjInfo.ObjIndex Then
                    Put FreeFileInf, , .ObjInfo.ObjIndex
                    Put FreeFileInf, , .ObjInfo.Amount
                End If
            End With
        Next X
    Next Y

    'Close .map file
    Close FreeFileMap

    'Close .inf file
    Close FreeFileInf

    Dim Writer As clsIniManager

    Set Writer = New clsIniManager

    With MapInfo(Map)

        'write .dat file
        Call Writer.ChangeValue("Mapa" & Map, "Name", .Name)
        Call Writer.ChangeValue("Mapa" & Map, "MusicNum", .music)
        Call Writer.ChangeValue("Mapa" & Map, "MagiaSinefecto", .MagiaSinEfecto)
        Call Writer.ChangeValue("Mapa" & Map, "InviSinEfecto", .InviSinEfecto)
        Call Writer.ChangeValue("Mapa" & Map, "ResuSinEfecto", .ResuSinEfecto)
        Call Writer.ChangeValue("Mapa" & Map, "InvocarSinEfecto", .InvocarSinEfecto)

        Call Writer.ChangeValue("Mapa" & Map, "RoboNpcsPermitido", .RoboNpcsPermitido)

        Call Writer.ChangeValue("Mapa" & Map, "StartPos", .StartPos.Map & "-" & .StartPos.X & "-" & .StartPos.Y)

        Call Writer.ChangeValue("Mapa" & Map, "Terreno", .Terreno)
        Call Writer.ChangeValue("Mapa" & Map, "Zona", .Zona)
        Call Writer.ChangeValue("Mapa" & Map, "Restringir", .Restringir)
        Call Writer.ChangeValue("Mapa" & Map, "BackUp", Str(.backup))

        If .pk Then
            Call Writer.ChangeValue("Mapa" & Map, "Pk", "1")
        Else
            Call Writer.ChangeValue("Mapa" & Map, "Pk", "0")
        End If

        Call Writer.DumpFile(MAPFILE & ".dat")
    End With
    Set Writer = Nothing
End Sub
Sub LoadArmasHerreria()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim N As Integer, lc As Integer

    N = val(GetVar(DatPath & "ArmasHerrero.dat", "INIT", "NumArmas"))

    ReDim Preserve ArmasHerrero(1 To N) As Integer

    For lc = 1 To N
        ArmasHerrero(lc) = val(GetVar(DatPath & "ArmasHerrero.dat", "Arma" & lc, "Index"))
    Next lc

End Sub

Sub LoadArmadurasHerreria()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim N As Integer, lc As Integer

    N = val(GetVar(DatPath & "ArmadurasHerrero.dat", "INIT", "NumArmaduras"))

    ReDim Preserve ArmadurasHerrero(1 To N) As Integer

    For lc = 1 To N
        ArmadurasHerrero(lc) = val(GetVar(DatPath & "ArmadurasHerrero.dat", "Armadura" & lc, "Index"))
    Next lc

End Sub

Sub LoadBalance()
'***************************************************
'Author: Unknown
'Last Modification: 15/04/2010
'15/04/2010: ZaMa - Agrego recompensas faccionarias.
'***************************************************

    Dim i As Long

    'Modificadores de Clase
    For i = 1 To NUMCLASES
        With ModClase(i)
            .Evasion = val(GetVar(DatPath & "Balance.dat", "MODEVASION", ListaClases(i)))
            .AtaqueArmas = val(GetVar(DatPath & "Balance.dat", "MODATAQUEARMAS", ListaClases(i)))
            .AtaqueProyectiles = val(GetVar(DatPath & "Balance.dat", "MODATAQUEPROYECTILES", ListaClases(i)))
            .AtaqueWrestling = val(GetVar(DatPath & "Balance.dat", "MODATAQUEWRESTLING", ListaClases(i)))
            .DañoArmas = val(GetVar(DatPath & "Balance.dat", "MODDAÑOARMAS", ListaClases(i)))
            .DañoProyectiles = val(GetVar(DatPath & "Balance.dat", "MODDAÑOPROYECTILES", ListaClases(i)))
            .DañoWrestling = val(GetVar(DatPath & "Balance.dat", "MODDAÑOWRESTLING", ListaClases(i)))
            .Escudo = val(GetVar(DatPath & "Balance.dat", "MODESCUDO", ListaClases(i)))
            .Magia = val(GetVar(DatPath & "Balance.dat", "MODDAÑOHECHIZOS", ListaClases(i)))
        End With
    Next i

    'Modificadores de Raza
    For i = 1 To NUMRAZAS
        With ModRaza(i)
            .Fuerza = val(GetVar(DatPath & "Balance.dat", "MODRAZA", ListaRazas(i) + "Fuerza"))
            .Agilidad = val(GetVar(DatPath & "Balance.dat", "MODRAZA", ListaRazas(i) + "Agilidad"))
            .Inteligencia = val(GetVar(DatPath & "Balance.dat", "MODRAZA", ListaRazas(i) + "Inteligencia"))
            .Carisma = val(GetVar(DatPath & "Balance.dat", "MODRAZA", ListaRazas(i) + "Carisma"))
            .Constitucion = val(GetVar(DatPath & "Balance.dat", "MODRAZA", ListaRazas(i) + "Constitucion"))
        End With
    Next i

    'Modificadores de Vida
    For i = 1 To NUMCLASES
        ModVida(i) = val(GetVar(DatPath & "Balance.dat", "MODVIDA", ListaClases(i)))
    Next i

    '  Dim stra As String
    '   stra = "  switch ($clase) {"
    '   'Modificadores de Vida
    '   For i = 1 To NUMCLASES
    '       ModVida(i) = val(GetVar(DatPath & "Balance.dat", "MODVIDA", ListaClases(i)))
    '       stra = stra & vbNewLine & "case " & i & ":"
    '           stra = stra & vbNewLine & "switch ($raza) {"
    '               stra = stra & vbNewLine & "case 1: $prom =" & ModVida(i) + 0 & ";break;"
    '               stra = stra & vbNewLine & "case 2: $prom =" & ModVida(i) - 0.5 & ";break;"
    '               stra = stra & vbNewLine & "case 3: $prom =" & ModVida(i) - 0.5 & ";break;"
    '               stra = stra & vbNewLine & "case 4: $prom =" & ModVida(i) - 1 & ";break;"
    '               stra = stra & vbNewLine & "case 5: $prom =" & ModVida(i) + 0.5 & ";break;"
    '           stra = stra & vbNewLine & "}break;"
    '   Next i
    '   stra = stra & vbNewLine & "default: $prom = 7;break;}"
    '  Call LogGM("stri", stra)
    '  End



    'Distribución de Vida
    For i = 1 To 5
        DistribucionEnteraVida(i) = val(GetVar(DatPath & "Balance.dat", "DISTRIBUCION", "E" + CStr(i)))
    Next i
    For i = 1 To 4
        DistribucionSemienteraVida(i) = val(GetVar(DatPath & "Balance.dat", "DISTRIBUCION", "S" + CStr(i)))
    Next i

    ' Recompensas faccionarias
    For i = 1 To NUM_RANGOS_FACCION
        RecompensaFacciones(i - 1) = val(GetVar(DatPath & "Balance.dat", "RECOMPENSAFACCION", "Rango" & i))
    Next i

End Sub

Sub LoadObjCarpintero()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim N As Integer, lc As Integer

    N = val(GetVar(DatPath & "ObjCarpintero.dat", "INIT", "NumObjs"))

    ReDim Preserve ObjCarpintero(1 To N) As Integer

    For lc = 1 To N
        ObjCarpintero(lc) = val(GetVar(DatPath & "ObjCarpintero.dat", "Obj" & lc, "Index"))
    Next lc

End Sub

Sub LoadOBJData()

'*****************************************************************
'Carga la lista de objetos
'*****************************************************************
    Dim Object As Long
    Dim Leer As New clsIniManager

    Call Leer.Initialize(DatPath & "Obj.dat")

    'obtiene el numero de obj
    NumObjDatas = val(Leer.GetValue("INIT", "NumObjs"))

    Dim i As Long

    ReDim Preserve ObjData(0 To NumObjDatas) As ObjData

    'Llena la lista
    For Object = 1 To NumObjDatas

        ObjData(Object).Numero = Object

        ObjData(Object).Name = Leer.GetValue("OBJ" & Object, "Name")

        'Pablo (ToxicWaste) Log de Objetos.
        ObjData(Object).Log = val(Leer.GetValue("OBJ" & Object, "Log"))
        ObjData(Object).NoLog = val(Leer.GetValue("OBJ" & Object, "NoLog"))
        '07/09/07

        ObjData(Object).GrhIndex = val(Leer.GetValue("OBJ" & Object, "GrhIndex"))
        If ObjData(Object).GrhIndex = 0 Then
            ObjData(Object).GrhIndex = ObjData(Object).GrhIndex
        End If

        ObjData(Object).OBJType = val(Leer.GetValue("OBJ" & Object, "ObjType"))

        ObjData(Object).Newbie = val(Leer.GetValue("OBJ" & Object, "Newbie"))
        ObjData(Object).Alineacion = val(Leer.GetValue("OBJ" & Object, "Alineacion"))

        ObjData(Object).Real = val(Leer.GetValue("OBJ" & Object, "Real"))
        ObjData(Object).Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))

        Select Case ObjData(Object).OBJType

        Case eOBJType.otArmadura

            ObjData(Object).Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))
            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))

        Case eOBJType.otEscudo
            ObjData(Object).ShieldAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
        Case eOBJType.otCASCO
            ObjData(Object).CascoAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))

        Case eOBJType.otWeapon
            ObjData(Object).WeaponAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
            ObjData(Object).Apuñala = val(Leer.GetValue("OBJ" & Object, "Apuñala"))
            ObjData(Object).Envenena = val(Leer.GetValue("OBJ" & Object, "Envenena"))
            ObjData(Object).MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
            ObjData(Object).MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))
            ObjData(Object).proyectil = val(Leer.GetValue("OBJ" & Object, "Proyectil"))
            ObjData(Object).Municion = val(Leer.GetValue("OBJ" & Object, "Municiones"))
            ObjData(Object).StaffPower = val(Leer.GetValue("OBJ" & Object, "StaffPower"))
            ObjData(Object).StaffDamageBonus = val(Leer.GetValue("OBJ" & Object, "StaffDamageBonus"))
            ObjData(Object).Refuerzo = val(Leer.GetValue("OBJ" & Object, "Refuerzo"))

            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))

        Case eOBJType.otInstrumentos
            ObjData(Object).Snd1 = val(Leer.GetValue("OBJ" & Object, "SND1"))
            ObjData(Object).Snd2 = val(Leer.GetValue("OBJ" & Object, "SND2"))
            ObjData(Object).Snd3 = val(Leer.GetValue("OBJ" & Object, "SND3"))

        Case eOBJType.otMinerales
            ObjData(Object).MinSkill = val(Leer.GetValue("OBJ" & Object, "MinSkill"))

        Case eOBJType.otPuertas, eOBJType.otBotellaVacia, eOBJType.otBotellaLlena
            ObjData(Object).IndexAbierta = val(Leer.GetValue("OBJ" & Object, "IndexAbierta"))
            ObjData(Object).IndexCerrada = val(Leer.GetValue("OBJ" & Object, "IndexCerrada"))
            ObjData(Object).IndexCerradaLlave = val(Leer.GetValue("OBJ" & Object, "IndexCerradaLlave"))

        Case otPociones
            ObjData(Object).TipoPocion = val(Leer.GetValue("OBJ" & Object, "TipoPocion"))
            ObjData(Object).MaxModificador = val(Leer.GetValue("OBJ" & Object, "MaxModificador"))
            ObjData(Object).MinModificador = val(Leer.GetValue("OBJ" & Object, "MinModificador"))
            ObjData(Object).DuracionEfecto = val(Leer.GetValue("OBJ" & Object, "DuracionEfecto"))

        Case eOBJType.otBarcos
            ObjData(Object).MinSkill = val(Leer.GetValue("OBJ" & Object, "MinSkill"))
            ObjData(Object).MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
            ObjData(Object).MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))

        Case eOBJType.otFlechas
            ObjData(Object).MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
            ObjData(Object).MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))
            ObjData(Object).Envenena = val(Leer.GetValue("OBJ" & Object, "Envenena"))
            ObjData(Object).Paraliza = val(Leer.GetValue("OBJ" & Object, "Paraliza"))
        Case eOBJType.otAnillo        'Pablo (ToxicWaste)
            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
            ObjData(Object).StaffPower = val(Leer.GetValue("OBJ" & Object, "StaffPower"))
            ObjData(Object).DefensaMagicaMax = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMax"))
            ObjData(Object).DefensaMagicaMin = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMin"))
        Case eOBJType.otAnillo2
            ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
            ObjData(Object).DefensaMagicaMax = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMax"))
            ObjData(Object).DefensaMagicaMin = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMin"))
            'TDS Legacy Clon
            'Case eOBJType.otHerramientas
            '    ObjData(Object).LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
            '    ObjData(Object).LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
            '    ObjData(Object).LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
            '    ObjData(Object).SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
            '    ObjData(Object).DefensaMagicaMax = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMax"))
            '    ObjData(Object).DefensaMagicaMin = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMin"))

        End Select

        ObjData(Object).Ropaje = val(Leer.GetValue("OBJ" & Object, "NumRopaje"))
        ObjData(Object).HechizoIndex = val(Leer.GetValue("OBJ" & Object, "HechizoIndex"))
        ObjData(Object).MinSkill = val(Leer.GetValue("OBJ" & Object, "MinSkill"))

        ' @@ Nuevo sistema de requerimiento de skills
        ObjData(Object).MagiaSkill = val(Leer.GetValue("OBJ" & Object, "MagiaSkill"))
        ObjData(Object).RMSkill = val(Leer.GetValue("OBJ" & Object, "RMSkill"))
        ObjData(Object).ArmaSkill = val(Leer.GetValue("OBJ" & Object, "WeaponSkill"))
        ObjData(Object).EscudoSkill = val(Leer.GetValue("OBJ" & Object, "EscudoSkill"))
        ObjData(Object).ArmaduraSkill = val(Leer.GetValue("OBJ" & Object, "ArmaduraSkill"))
        ObjData(Object).DagaSkill = val(Leer.GetValue("OBJ" & Object, "DagaSkill"))
        ObjData(Object).ArcoSkill = val(Leer.GetValue("OBJ" & Object, "ArcoSkill"))

        ObjData(Object).LingoteIndex = val(Leer.GetValue("OBJ" & Object, "LingoteIndex"))
        ObjData(Object).QuitaEnergia = val(Leer.GetValue("OBJ" & Object, "MinSta"))

        ObjData(Object).isDosManos = val(Leer.GetValue("OBJ" & Object, "isDosManos"))

        ObjData(Object).MineralIndex = val(Leer.GetValue("OBJ" & Object, "MineralIndex"))

        ObjData(Object).MaxHP = val(Leer.GetValue("OBJ" & Object, "MaxHP"))
        ObjData(Object).MinHP = val(Leer.GetValue("OBJ" & Object, "MinHP"))

        ObjData(Object).Mujer = val(Leer.GetValue("OBJ" & Object, "Mujer"))
        ObjData(Object).Hombre = val(Leer.GetValue("OBJ" & Object, "Hombre"))

        ObjData(Object).MinHam = val(Leer.GetValue("OBJ" & Object, "MinHam"))
        ObjData(Object).MinSed = val(Leer.GetValue("OBJ" & Object, "MinAgu"))

        ObjData(Object).MinDef = val(Leer.GetValue("OBJ" & Object, "MINDEF"))
        ObjData(Object).MaxDef = val(Leer.GetValue("OBJ" & Object, "MAXDEF"))
        ObjData(Object).def = (ObjData(Object).MinDef + ObjData(Object).MaxDef) / 2

        ObjData(Object).RazaEnana = val(Leer.GetValue("OBJ" & Object, "RazaEnana"))
        ObjData(Object).RazaDrow = val(Leer.GetValue("OBJ" & Object, "RazaDrow"))
        ObjData(Object).RazaElfa = val(Leer.GetValue("OBJ" & Object, "RazaElfa"))
        ObjData(Object).RazaGnoma = val(Leer.GetValue("OBJ" & Object, "RazaGnoma"))
        ObjData(Object).RazaHumana = val(Leer.GetValue("OBJ" & Object, "RazaHumana"))

        ObjData(Object).Valor = val(Leer.GetValue("OBJ" & Object, "Valor"))

        ObjData(Object).Crucial = val(Leer.GetValue("OBJ" & Object, "Crucial"))

        'ObjData(Object).RequiredLevel = val(Leer.GetValue("OBJ" & Object, "RequiredLevel"))
        'ObjData(Object).RequiredMagic = val(Leer.GetValue("OBJ" & Object, "RequiredMagic"))
        'ObjData(Object).RequiredCombat = val(Leer.GetValue("OBJ" & Object, "RequiredCombat"))
        'ObjData(Object).RequiredTactics = val(Leer.GetValue("OBJ" & Object, "RequiredTactics"))
        'ObjData(Object).RequiredStamina = val(Leer.GetValue("OBJ" & Object, "RequiredStamina"))
        'ObjData(Object).SkillTacticass = val(Leer.GetValue("OBJ" & Object, "SkillT"))
        'ObjData(Object).SkillM = val(Leer.GetValue("OBJ" & Object, "SkillM"))
        'ObjData(Object).SkillDefe = val(Leer.GetValue("OBJ" & Object, "SkillD"))
        'ObjData(Object).SkillTacticassT = val(Leer.GetValue("OBJ" & Object, "SkillTT"))
        'ObjData(Object).SkillCombate = val(Leer.GetValue("OBJ" & Object, "SkillC"))
        ObjData(Object).QuitaEnergia = val(Leer.GetValue("OBJ" & Object, "MinSta"))
        ObjData(Object).isDosManos = val(Leer.GetValue("OBJ" & Object, "isDosManos"))

        ObjData(Object).Cerrada = val(Leer.GetValue("OBJ" & Object, "abierta"))
        If ObjData(Object).Cerrada = 1 Then
            ObjData(Object).Llave = val(Leer.GetValue("OBJ" & Object, "Llave"))
            ObjData(Object).clave = val(Leer.GetValue("OBJ" & Object, "Clave"))
        End If

        'Puertas y llaves
        ObjData(Object).clave = val(Leer.GetValue("OBJ" & Object, "Clave"))

        ObjData(Object).texto = Leer.GetValue("OBJ" & Object, "Texto")
        ObjData(Object).GrhSecundario = val(Leer.GetValue("OBJ" & Object, "VGrande"))

        ObjData(Object).LeñaIndex = val(Leer.GetValue("OBJ" & Object, "LeñaIndex"))

        ObjData(Object).Agarrable = val(Leer.GetValue("OBJ" & Object, "Agarrable"))


        'CHECK: !!! Esto es provisorio hasta que los de Dateo cambien los valores de string a numerico
        Dim N As Integer
        Dim s As String
        Dim SalirLoop As Boolean
        For i = 1 To NUMCLASES
            s = UCase$(Leer.GetValue("OBJ" & Object, "CP" & i))
            N = 1
            SalirLoop = False
            Do While (LenB(s) > 0 And UCase$(ListaClases(N)) <> s) And (SalirLoop = False)
                N = N + 1
                If N > UBound(ListaClases) Then
                    SalirLoop = True
                    N = N - 1
                End If
            Loop
            ObjData(Object).ClaseProhibida(i) = IIf(LenB(s) > 0, N, 0)
        Next i

        ObjData(Object).DefensaMagicaMax = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMax"))
        ObjData(Object).DefensaMagicaMin = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMin"))

        ObjData(Object).SkCarpinteria = val(Leer.GetValue("OBJ" & Object, "SkCarpinteria"))

        If ObjData(Object).SkCarpinteria > 0 Then _
           ObjData(Object).Madera = val(Leer.GetValue("OBJ" & Object, "Madera")): _
           ObjData(Object).MaderaDeTejo = val(Leer.GetValue("OBJ" & Object, "MaderaElfica"))
        'Bebidas
        ObjData(Object).minSta = val(Leer.GetValue("OBJ" & Object, "MinST"))

        ObjData(Object).NoSeCae = val(Leer.GetValue("OBJ" & Object, "NoSeCae"))
        ObjData(Object).NoSeSaca = val(Leer.GetValue("OBJ" & Object, "NoSeSaca"))
        ObjData(Object).abriga = val(Leer.GetValue("OBJ" & Object, "Abriga"))


        ObjData(Object).WavAlCrear = val(Leer.GetValue("OBJ" & Object, "WavAlCrear"))

    Next Object

    Set Leer = Nothing

    Exit Sub

Errhandler:
    MsgBox "error cargando objetos " & Err.Number & ": " & Err.Description


End Sub


Sub LoadOBJData1()
    Dim Object As Long
    Dim Leer As New clsIniManager

    Call Leer.Initialize(DatPath & "Obj.dat")

    'obtiene el numero de obj
    NumObjDatas = val(Leer.GetValue("INIT", "NumObjs"))

    ReDim Preserve ObjData(1 To NumObjDatas) As ObjData


    'Llena la lista
    For Object = 1 To NumObjDatas
        With ObjData(Object)
            .Name = Leer.GetValue("OBJ" & Object, "Name")

            'Pablo (ToxicWaste) Log de Objetos.
            .Log = val(Leer.GetValue("OBJ" & Object, "Log"))
            .NoLog = val(Leer.GetValue("OBJ" & Object, "NoLog"))

            '07/09/07

            .GrhIndex = val(Leer.GetValue("OBJ" & Object, "GrhIndex"))
            If .GrhIndex = 0 Then
                .GrhIndex = .GrhIndex
            End If

            .OBJType = val(Leer.GetValue("OBJ" & Object, "ObjType"))

            .Newbie = val(Leer.GetValue("OBJ" & Object, "Newbie"))

            Select Case .OBJType
            Case eOBJType.otArmadura
                .Real = val(Leer.GetValue("OBJ" & Object, "Real"))
                .Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))
                .LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
                .LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
                .LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
                .SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))

            Case eOBJType.otEscudo
                .ShieldAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
                .LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
                .LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
                .LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
                .SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
                .Real = val(Leer.GetValue("OBJ" & Object, "Real"))
                .Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))

            Case eOBJType.otCASCO
                .CascoAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
                .LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
                .LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
                .LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
                .SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
                .Real = val(Leer.GetValue("OBJ" & Object, "Real"))
                .Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))

            Case eOBJType.otWeapon
                .WeaponAnim = val(Leer.GetValue("OBJ" & Object, "Anim"))
                .Apuñala = val(Leer.GetValue("OBJ" & Object, "Apuñala"))
                .Envenena = val(Leer.GetValue("OBJ" & Object, "Envenena"))
                .MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
                .MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))
                .proyectil = val(Leer.GetValue("OBJ" & Object, "Proyectil"))
                .Municion = val(Leer.GetValue("OBJ" & Object, "Municiones"))
                .StaffPower = val(Leer.GetValue("OBJ" & Object, "StaffPower"))
                .StaffDamageBonus = val(Leer.GetValue("OBJ" & Object, "StaffDamageBonus"))
                .Refuerzo = val(Leer.GetValue("OBJ" & Object, "Refuerzo"))

                .LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
                .LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
                .LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
                .SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
                .Real = val(Leer.GetValue("OBJ" & Object, "Real"))
                .Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))

                .WeaponRazaEnanaAnim = val(Leer.GetValue("OBJ" & Object, "RazaEnanaAnim"))

            Case eOBJType.otInstrumentos
                .Snd1 = val(Leer.GetValue("OBJ" & Object, "SND1"))
                .Snd2 = val(Leer.GetValue("OBJ" & Object, "SND2"))
                .Snd3 = val(Leer.GetValue("OBJ" & Object, "SND3"))
                'Pablo (ToxicWaste)
                .Real = val(Leer.GetValue("OBJ" & Object, "Real"))
                .Caos = val(Leer.GetValue("OBJ" & Object, "Caos"))

            Case eOBJType.otMinerales
                .MinSkill = val(Leer.GetValue("OBJ" & Object, "MinSkill"))

            Case eOBJType.otPuertas, eOBJType.otBotellaVacia, eOBJType.otBotellaLlena
                .IndexAbierta = val(Leer.GetValue("OBJ" & Object, "IndexAbierta"))
                .IndexCerrada = val(Leer.GetValue("OBJ" & Object, "IndexCerrada"))
                .IndexCerradaLlave = val(Leer.GetValue("OBJ" & Object, "IndexCerradaLlave"))

            Case otPociones
                .TipoPocion = val(Leer.GetValue("OBJ" & Object, "TipoPocion"))
                .MaxModificador = val(Leer.GetValue("OBJ" & Object, "MaxModificador"))
                .MinModificador = val(Leer.GetValue("OBJ" & Object, "MinModificador"))
                .DuracionEfecto = val(Leer.GetValue("OBJ" & Object, "DuracionEfecto"))

            Case eOBJType.otBarcos
                .MinSkill = val(Leer.GetValue("OBJ" & Object, "MinSkill"))
                .MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
                .MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))

            Case eOBJType.otFlechas
                .MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
                .MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))
                .Envenena = val(Leer.GetValue("OBJ" & Object, "Envenena"))
                .Paraliza = val(Leer.GetValue("OBJ" & Object, "Paraliza"))

            Case eOBJType.otAnillo        'Pablo (ToxicWaste)
                .LingH = val(Leer.GetValue("OBJ" & Object, "LingH"))
                .LingP = val(Leer.GetValue("OBJ" & Object, "LingP"))
                .LingO = val(Leer.GetValue("OBJ" & Object, "LingO"))
                .SkHerreria = val(Leer.GetValue("OBJ" & Object, "SkHerreria"))
                .MaxHIT = val(Leer.GetValue("OBJ" & Object, "MaxHIT"))
                .MinHIT = val(Leer.GetValue("OBJ" & Object, "MinHIT"))

            Case eOBJType.otTeleport
                .Radio = val(Leer.GetValue("OBJ" & Object, "Radio"))

            End Select

            .Ropaje = val(Leer.GetValue("OBJ" & Object, "NumRopaje"))
            .HechizoIndex = val(Leer.GetValue("OBJ" & Object, "HechizoIndex"))

            .LingoteIndex = val(Leer.GetValue("OBJ" & Object, "LingoteIndex"))

            .MineralIndex = val(Leer.GetValue("OBJ" & Object, "MineralIndex"))


            ' @@ Nuevo sistema de requerimiento de skills
            .MagiaSkill = val(Leer.GetValue("OBJ" & Object, "MagiaSkill"))
            .RMSkill = val(Leer.GetValue("OBJ" & Object, "RMSkill"))
            .ArmaSkill = val(Leer.GetValue("OBJ" & Object, "WeaponSkill"))
            .ArcoSkill = val(Leer.GetValue("OBJ" & Object, "ArcoSkill"))
            .EscudoSkill = val(Leer.GetValue("OBJ" & Object, "EscudoSkill"))
            .ArmaduraSkill = val(Leer.GetValue("OBJ" & Object, "ArmaduraSkill"))
            .DagaSkill = val(Leer.GetValue("OBJ" & Object, "DagaSkill"))
            .QuitaEnergia = val(Leer.GetValue("OBJ" & Object, "MinSta"))

            .MaxHP = val(Leer.GetValue("OBJ" & Object, "MaxHP"))
            .MinHP = val(Leer.GetValue("OBJ" & Object, "MinHP"))

            .Mujer = val(Leer.GetValue("OBJ" & Object, "Mujer"))
            .Hombre = val(Leer.GetValue("OBJ" & Object, "Hombre"))

            .MinHam = val(Leer.GetValue("OBJ" & Object, "MinHam"))
            .MinSed = val(Leer.GetValue("OBJ" & Object, "MinAgu"))

            .MinDef = val(Leer.GetValue("OBJ" & Object, "MINDEF"))
            .MaxDef = val(Leer.GetValue("OBJ" & Object, "MAXDEF"))
            .def = (.MinDef + .MaxDef) / 2

            .RazaEnana = val(Leer.GetValue("OBJ" & Object, "RazaEnana"))
            .RazaDrow = val(Leer.GetValue("OBJ" & Object, "RazaDrow"))
            .RazaElfa = val(Leer.GetValue("OBJ" & Object, "RazaElfa"))
            .RazaGnoma = val(Leer.GetValue("OBJ" & Object, "RazaGnoma"))
            .RazaHumana = val(Leer.GetValue("OBJ" & Object, "RazaHumana"))

            .Valor = val(Leer.GetValue("OBJ" & Object, "Valor"))

            .Crucial = val(Leer.GetValue("OBJ" & Object, "Crucial"))

            .Cerrada = val(Leer.GetValue("OBJ" & Object, "abierta"))
            If .Cerrada = 1 Then
                .Llave = val(Leer.GetValue("OBJ" & Object, "Llave"))
                .clave = val(Leer.GetValue("OBJ" & Object, "Clave"))
            End If

            'Puertas y llaves
            .clave = val(Leer.GetValue("OBJ" & Object, "Clave"))

            .texto = Leer.GetValue("OBJ" & Object, "Texto")
            .GrhSecundario = val(Leer.GetValue("OBJ" & Object, "VGrande"))

            .LeñaIndex = val(Leer.GetValue("OBJ" & Object, "LeñaIndex"))

            .Agarrable = val(Leer.GetValue("OBJ" & Object, "Agarrable"))

            .Acuchilla = val(Leer.GetValue("OBJ" & Object, "Acuchilla"))

            .Guante = val(Leer.GetValue("OBJ" & Object, "Guante"))

            'CHECK: !!! Esto es provisorio hasta que los de Dateo cambien los valores de string a numerico
            Dim i As Integer
            Dim N As Integer
            Dim s As String
            For i = 1 To NUMCLASES
                s = UCase$(Leer.GetValue("OBJ" & Object, "CP" & i))
                N = 1
                Do While LenB(s) > 0 And UCase$(ListaClases(N)) <> s
                    N = N + 1
                Loop
                .ClaseProhibida(i) = IIf(LenB(s) > 0, N, 0)
            Next i

            .DefensaMagicaMax = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMax"))
            .DefensaMagicaMin = val(Leer.GetValue("OBJ" & Object, "DefensaMagicaMin"))

            .SkCarpinteria = val(Leer.GetValue("OBJ" & Object, "SkCarpinteria"))

            If .SkCarpinteria > 0 Then _
               .Madera = val(Leer.GetValue("OBJ" & Object, "Madera"))
            .MaderaDeTejo = val(Leer.GetValue("OBJ" & Object, "MaderaDeTejo"))

            'Bebidas
            .minSta = val(Leer.GetValue("OBJ" & Object, "MinST"))

            .NoSeCae = val(Leer.GetValue("OBJ" & Object, "NoSeCae"))
            .NoSeSaca = val(Leer.GetValue("OBJ" & Object, "NoSeSaca"))

            .Upgrade = val(Leer.GetValue("OBJ" & Object, "Upgrade"))
        End With
    Next Object


    Set Leer = Nothing

    Exit Sub

Errhandler:
    MsgBox "error cargando objetos " & Err.Number & ": " & Err.Description


End Sub

Sub LoadUserStats(ByVal UserIndex As Integer, ByRef UserFile As clsIniManager)
'*************************************************
'Author: Unknown
'Last modified: 11/19/2009
'11/19/2009: Pato - Load the EluSkills and ExpSkills
'*************************************************
    Dim LoopC As Long
    On Error Resume Next
    With UserList(UserIndex)
        With .Stats
            For LoopC = 1 To NUMATRIBUTOS
                .UserAtributos(LoopC) = CInt(UserFile.GetValue("ATRIBUTOS", "AT" & LoopC))
                .UserAtributosBackUP(LoopC) = .UserAtributos(LoopC)
            Next LoopC

            For LoopC = 1 To NUMSKILLS
                .UserSkills(LoopC) = CInt(UserFile.GetValue("SKILLS", "SK" & LoopC))
                .EluSkills(LoopC) = CInt(UserFile.GetValue("SKILLS", "ELUSK" & LoopC))
                .ExpSkills(LoopC) = CInt(UserFile.GetValue("SKILLS", "EXPSK" & LoopC))
            Next LoopC

            For LoopC = 1 To MAXUSERHECHIZOS
                .UserHechizos(LoopC) = CInt(UserFile.GetValue("Hechizos", "H" & LoopC))
            Next LoopC

            .GLD = CLng(UserFile.GetValue("STATS", "GLD"))
            .Banco = CLng(UserFile.GetValue("STATS", "BANCO"))

            For LoopC = 1 To MAXPENAS
                .Penas(LoopC) = UserFile.GetValue("PENAS", "P" & LoopC)
            Next LoopC
            .CantPenas = val(UserFile.GetValue("PENAS", "Cant"))

            .RetosGanados = CLng(UserFile.GetValue("RETOS", "GANADOS"))
            .RetosPerdidos = CLng(UserFile.GetValue("RETOS", "PERDIDOS"))


            .PuntosFotodenuncia = val(UserFile.GetValue("PENAS", "PuntosFotodenuncia"))
            .ParticipoClanes = CLng(UserFile.GetValue("GUILD", "ParticipoClanes"))
            .FundoClan = CLng(UserFile.GetValue("GUILD", "FundoClan"))
            .DisolvioClan = CLng(UserFile.GetValue("GUILD", "DisolvioClan"))

            .OroGanado = CLng(UserFile.GetValue("RETOS", "ORO_GANADO"))
            .OroPerdido = CLng(UserFile.GetValue("RETOS", "ORO_PERDIDO"))

            .MaxHP = CInt(UserFile.GetValue("STATS", "MaxHP"))
            .MinHP = CInt(UserFile.GetValue("STATS", "MinHP"))

            .minSta = CInt(UserFile.GetValue("STATS", "MinSTA"))
            .MaxSta = CInt(UserFile.GetValue("STATS", "MaxSTA"))

            .MaxMAN = CInt(UserFile.GetValue("STATS", "MaxMAN"))
            .MinMAN = CInt(UserFile.GetValue("STATS", "MinMAN"))

            .MaxHIT = CInt(UserFile.GetValue("STATS", "MaxHIT"))
            .MinHIT = CInt(UserFile.GetValue("STATS", "MinHIT"))

            .MaxAGU = CByte(UserFile.GetValue("STATS", "MaxAGU"))
            .MinAGU = CByte(UserFile.GetValue("STATS", "MinAGU"))

            .MaxHam = CByte(UserFile.GetValue("STATS", "MaxHAM"))
            .MinHam = CByte(UserFile.GetValue("STATS", "MinHAM"))

            .SkillPts = CInt(UserFile.GetValue("STATS", "SkillPtsLibres"))

            .AsignoSkills = CInt(val(UserFile.GetValue("STATS", "AsignoSkills")))

            .Exp = CDbl(UserFile.GetValue("STATS", "EXP"))
            .elu = CLng(UserFile.GetValue("STATS", "ELU"))
            .ELV = CByte(UserFile.GetValue("STATS", "ELV"))


            .UsuariosMatados = CLng(UserFile.GetValue("MUERTES", "UserMuertes"))
            .NPCsMuertos = CInt(UserFile.GetValue("MUERTES", "NpcsMuertes"))
        End With

        .faccion.Status = val(UserFile.GetValue("FACCION", "Status"))

    End With
End Sub

Sub LoadUserReputacion(ByVal UserIndex As Integer, ByRef UserFile As clsIniManager)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex).Reputacion
        .AsesinoRep = val(UserFile.GetValue("REP", "Asesino"))
        .BandidoRep = val(UserFile.GetValue("REP", "Bandido"))
        .BurguesRep = val(UserFile.GetValue("REP", "Burguesia"))
        .LadronesRep = val(UserFile.GetValue("REP", "Ladrones"))
        .NobleRep = val(UserFile.GetValue("REP", "Nobles"))
        .PlebeRep = val(UserFile.GetValue("REP", "Plebe"))
        .Promedio = val(UserFile.GetValue("REP", "Promedio"))
    End With

End Sub

Sub LoadUserInit(ByVal UserIndex As Integer, ByRef UserFile As clsIniManager)
'*************************************************
'Author: Unknown
'Last modified: 19/11/2006
'Loads the Users records
'23/01/2007 Pablo (ToxicWaste) - Agrego NivelIngreso, FechaIngreso, MatadosIngreso y NextRecompensa.
'23/01/2007 Pablo (ToxicWaste) - Quito CriminalesMatados de Stats porque era redundante.
'*************************************************
    On Error Resume Next
    Dim LoopC As Long
    Dim ln As String

    With UserList(UserIndex)
        With .faccion
            .ArmadaReal = val(UserFile.GetValue("FACCIONES", "EjercitoReal"))
            .FuerzasCaos = val(UserFile.GetValue("FACCIONES", "EjercitoCaos"))
            .CiudadanosMatados = val(UserFile.GetValue("FACCIONES", "CiudMatados"))
            .CriminalesMatados = val(UserFile.GetValue("FACCIONES", "CrimMatados"))
            .RecibioArmaduraCaos = val(UserFile.GetValue("FACCIONES", "rArCaos"))
            .RecibioArmaduraReal = val(UserFile.GetValue("FACCIONES", "rArReal"))
            .RecibioExpInicialCaos = val(UserFile.GetValue("FACCIONES", "rExCaos"))
            .RecibioExpInicialReal = val(UserFile.GetValue("FACCIONES", "rExReal"))
            .RecompensasCaos = val(UserFile.GetValue("FACCIONES", "recCaos"))
            .RecompensasReal = val(UserFile.GetValue("FACCIONES", "recReal"))
            .Reenlistadas = val(UserFile.GetValue("FACCIONES", "Reenlistadas"))
            .NivelIngreso = val(UserFile.GetValue("FACCIONES", "NivelIngreso"))
            .FechaIngreso = UserFile.GetValue("FACCIONES", "FechaIngreso")
            .MatadosIngreso = val(UserFile.GetValue("FACCIONES", "MatadosIngreso"))

        End With

        With .flags
            .mao_index = val(UserFile.GetValue("MAO", "MAO_Index"))
            .Muerto = CByte(UserFile.GetValue("FLAGS", "Muerto"))
            .ExClan = val(UserFile.GetValue("FLAGS", "ExClan"))
            .Escondido = CByte(UserFile.GetValue("FLAGS", "Escondido"))
            .char_locked_in_mao = val(UserFile.GetValue("FLAGS", "char_locked_in_mao"))

            .Hambre = CByte(UserFile.GetValue("FLAGS", "Hambre"))
            .Sed = CByte(UserFile.GetValue("FLAGS", "Sed"))
            .Desnudo = CByte(UserFile.GetValue("FLAGS", "Desnudo"))
            .Navegando = CByte(UserFile.GetValue("FLAGS", "Navegando"))
            .Envenenado = CByte(UserFile.GetValue("FLAGS", "Envenenado"))
            .Paralizado = CByte(UserFile.GetValue("FLAGS", "Paralizado"))
            .BlockDragItems = CBool(UserFile.GetValue("FLAGS", "SeguroDrag"))

            'Matrix
            .lastMap = CInt(UserFile.GetValue("FLAGS", "LastMap"))
        End With

        If .flags.Paralizado = 1 Then
            .Counters.Paralisis = IntervaloParalizado
        End If

        .Counters.Pena = CLng(UserFile.GetValue("COUNTERS", "Pena"))
        .Counters.AsignedSkills = CByte(val(UserFile.GetValue("COUNTERS", "SkillsAsignados")))
        .Counters.tBonif = CInt(val(UserFile.GetValue("COUNTERS", "tBonif")))

        .Pin = UserFile.GetValue("INIT", "Pin")
        .Pass = UserFile.GetValue("INIT", "Password")

        .Email = UserFile.GetValue("CONTACTO", "Email")

        .Account = UserFile.GetValue("INIT", "ACCOUNT")

        .Genero = UserFile.GetValue("INIT", "Genero")
        .Clase = UserFile.GetValue("INIT", "Clase")
        .raza = UserFile.GetValue("INIT", "Raza")
        .Hogar = UserFile.GetValue("INIT", "Hogar")
        .Char.Heading = CInt(UserFile.GetValue("INIT", "Heading"))


        With .OrigChar
            .Head = CInt(UserFile.GetValue("INIT", "Head"))
            .body = CInt(UserFile.GetValue("INIT", "Body"))
            .WeaponAnim = CInt(UserFile.GetValue("INIT", "Arma"))
            .ShieldAnim = CInt(UserFile.GetValue("INIT", "Escudo"))
            .CascoAnim = CInt(UserFile.GetValue("INIT", "Casco"))

            .Heading = eHeading.SOUTH
        End With

        #If ConUpTime Then
            .UpTime = CLng(UserFile.GetValue("INIT", "UpTime"))
        #End If

        If .flags.Muerto = 0 Then
            .Char = .OrigChar
        Else
            .Char.body = iCuerpoMuerto
            .Char.Head = iCabezaMuerto
            .Char.WeaponAnim = NingunArma
            .Char.ShieldAnim = NingunEscudo
            .Char.CascoAnim = NingunCasco
        End If


        .Desc = UserFile.GetValue("INIT", "Desc")

        .Pos.Map = CInt(ReadField(1, UserFile.GetValue("INIT", "Position"), 45))
        .Pos.X = CInt(ReadField(2, UserFile.GetValue("INIT", "Position"), 45))
        .Pos.Y = CInt(ReadField(3, UserFile.GetValue("INIT", "Position"), 45))

        '.Invent.NroItems = CInt(UserFile.GetValue("Inventory", "CantidadItems"))

        '[KEVIN]--------------------------------------------------------------------
        '***********************************************************************************
        '.BancoInvent.NroItems = CInt(UserFile.GetValue("BancoInventory", "CantidadItems"))
        'Lista de objetos del banco
        For LoopC = 1 To MAX_BANCOINVENTORY_SLOTS
            ln = UserFile.GetValue("BancoInventory", "Obj" & LoopC)
            .BancoInvent.Object(LoopC).ObjIndex = CInt(ReadField(1, ln, 45))
            .BancoInvent.Object(LoopC).Amount = CInt(ReadField(2, ln, 45))
        Next LoopC
        '------------------------------------------------------------------------------------
        '[/KEVIN]*****************************************************************************


        'Lista de objetos
        For LoopC = 1 To MAX_INVENTORY_SLOTS
            ln = UserFile.GetValue("Inventory", "Obj" & LoopC)
            .Invent.Object(LoopC).ObjIndex = CInt(ReadField(1, ln, 45))
            .Invent.Object(LoopC).Amount = CInt(ReadField(2, ln, 45))
            .Invent.Object(LoopC).Equipped = CByte(ReadField(3, ln, 45))
        Next LoopC

        'Obtiene el indice-objeto del arma
        .Invent.WeaponEqpSlot = CByte(UserFile.GetValue("Inventory", "WeaponEqpSlot"))
        If .Invent.WeaponEqpSlot > 0 Then
            .Invent.WeaponEqpObjIndex = .Invent.Object(.Invent.WeaponEqpSlot).ObjIndex
        End If

        'Obtiene el indice-objeto del armadura
        .Invent.ArmourEqpSlot = CByte(UserFile.GetValue("Inventory", "ArmourEqpSlot"))
        If .Invent.ArmourEqpSlot > 0 Then
            .Invent.ArmourEqpObjIndex = .Invent.Object(.Invent.ArmourEqpSlot).ObjIndex
            .flags.Desnudo = 0
        Else
            .flags.Desnudo = 1
        End If

        'Obtiene el indice-objeto del escudo
        .Invent.EscudoEqpSlot = CByte(UserFile.GetValue("Inventory", "EscudoEqpSlot"))
        If .Invent.EscudoEqpSlot > 0 Then
            .Invent.EscudoEqpObjIndex = .Invent.Object(.Invent.EscudoEqpSlot).ObjIndex
        End If

        'Obtiene el indice-objeto del casco
        .Invent.CascoEqpSlot = CByte(UserFile.GetValue("Inventory", "CascoEqpSlot"))
        If .Invent.CascoEqpSlot > 0 Then
            .Invent.CascoEqpObjIndex = .Invent.Object(.Invent.CascoEqpSlot).ObjIndex
        End If

        'Obtiene el indice-objeto barco
        .Invent.BarcoSlot = CByte(UserFile.GetValue("Inventory", "BarcoSlot"))
        If .Invent.BarcoSlot > 0 Then
            .Invent.BarcoObjIndex = .Invent.Object(.Invent.BarcoSlot).ObjIndex
        End If

        'Obtiene el indice-objeto municion
        .Invent.MunicionEqpSlot = CByte(UserFile.GetValue("Inventory", "MunicionSlot"))
        If .Invent.MunicionEqpSlot > 0 Then
            .Invent.MunicionEqpObjIndex = .Invent.Object(.Invent.MunicionEqpSlot).ObjIndex
        End If

        '[Alejo]
        'Obtiene el indice-objeto anilo
        .Invent.AnilloEqpSlot = CByte(UserFile.GetValue("Inventory", "AnilloSlot"))
        If .Invent.AnilloEqpSlot > 0 Then
            .Invent.AnilloEqpObjIndex = .Invent.Object(.Invent.AnilloEqpSlot).ObjIndex
        End If

        .Invent.AnilloEqpSlot2 = CByte(UserFile.GetValue("Inventory", "AnilloSlot2"))
        If .Invent.AnilloEqpSlot2 > 0 Then
            .Invent.AnilloEqpObjIndex2 = .Invent.Object(.Invent.AnilloEqpSlot2).ObjIndex
        End If

        For LoopC = 1 To MAXMASCOTAS
            .MascotasType(LoopC) = val(UserFile.GetValue("MASCOTAS", "MAS" & LoopC))
        Next LoopC

        ln = UserFile.GetValue("Guild", "GUILDINDEX")
        If IsNumeric(ln) Then
            .GuildIndex = CInt(ln)
        Else
            .GuildIndex = 0
        End If
    End With

End Sub

Function GetVar(ByVal File As String, ByVal Main As String, ByVal var As String, Optional EmptySpaces As Long = 1024) As String
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim sSpaces As String        ' This will hold the input that the program will retrieve
    Dim szReturn As String        ' This will be the defaul value if the string is not found

    szReturn = vbNullString

    sSpaces = Space$(EmptySpaces)        ' This tells the computer how long the longest string can be


    GetPrivateProfileString Main, var, szReturn, sSpaces, EmptySpaces, File

    GetVar = RTrim$(sSpaces)
    GetVar = Left$(GetVar, Len(GetVar) - 1)

End Function


Sub CargarBackUp()

    Dim Map As Integer
    Dim tFileName As String

    On Error GoTo MAN

    MapPath = "\Maps\"
    Dim MapDirName As String
    NumMaps = 0
    MapDirName = dir(App.path & MapPath & "*.map")
    Do While MapDirName <> ""
        NumMaps = NumMaps + 1
        MapDirName = dir
    Loop

    Call InitAreas


    ReDim MapData(1 To NumMaps, XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
    ReDim MapInfo(1 To NumMaps) As MapInfo

    For Map = 1 To NumMaps
        If val(GetVar(App.path & MapPath & "Mapa" & Map & ".Dat", "Mapa" & Map, "BackUp")) <> 0 Then
            tFileName = App.path & "\WorldBackUp\Mapa" & Map

            If Not FileExist(tFileName & ".*") Then        'Miramos que exista al menos uno de los 3 archivos, sino lo cargamos de la carpeta de los mapas
                tFileName = App.path & MapPath & "Mapa" & Map
            End If
        Else
            tFileName = App.path & MapPath & "Mapa" & Map
        End If

        Call CargarMapa(Map, tFileName)
        DoEventsEx
    Next Map

    Exit Sub

MAN:
    MsgBox ("Error durante la carga de mapas, el mapa " & Map & " contiene errores")
    Call LogError(Date & " " & Err.Description & " " & Err.HelpContext & " " & Err.HelpFile & " " & Err.source)

End Sub

Sub LoadMapData()


    Dim Map As Integer
    Dim tFileName As String

    On Error GoTo MAN

    MapPath = "\Maps\"
    Dim MapDirName As String
    NumMaps = 0
    MapDirName = dir(App.path & MapPath & "*.map")
    Do While MapDirName <> ""
        NumMaps = NumMaps + 1
        MapDirName = dir
    Loop

    Call InitAreas

    ReDim MapData(1 To NumMaps, XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
    ReDim MapInfo(1 To NumMaps) As MapInfo

    For Map = 1 To NumMaps

        tFileName = App.path & MapPath & "Mapa" & Map
        Call CargarMapa(Map, tFileName)
        DoEventsEx
    Next Map

    Exit Sub

MAN:
    MsgBox ("Error durante la carga de mapas, el mapa " & Map & " contiene errores")
    Call LogError(Date & " " & Err.Description & " " & Err.HelpContext & " " & Err.HelpFile & " " & Err.source)

End Sub
Sub SwitchMap(ByVal Map As Integer)
'**************************************************************
'Formato de mapas optimizado para reducir el espacio que ocupan.
'Diseñado y creado por Juan Martín Sotuyo Dodero (Maraxus) (juansotuyo@hotmail.com)
'**************************************************************

' @@ Modificacion realizada por Facundo (GodKer), robada por Marcos.. ?
' @@ 06/11/2014
' @@ Facu cabe aporte (?)

    Dim Y As Long
    Dim X As Long
    Dim ByFlags As Byte
    Dim handle As Integer
    Dim fileBuff As clsByteBuffer

    Dim dData() As Byte
    Dim dLen As Long

    Dim lngstart As Long

    Set fileBuff = New clsByteBuffer

    dLen = FileLen(App.path & "\Maps\" & "Mapa" & Map & ".map")
    ReDim dData(dLen - 1)

    lngstart = GetTickCount()
    handle = FreeFile()

    Open App.path & "\Maps\" & "Mapa" & Map & ".map" For Binary As handle
    'Seek handle, 1
    Get handle, , dData
    Close handle

    fileBuff.initializeReader dData

    'map Header
    'Get handle, , MapInfo.MapVersion
    MapInfo(Map).MapVersion = fileBuff.getInteger

    MiCabecera.Desc = fileBuff.getString(Len(MiCabecera.Desc))
    MiCabecera.crc = fileBuff.getLong
    MiCabecera.MagicWord = fileBuff.getLong

    'Get handle, , MiCabecera
    'Get handle, , tempint
    'Get handle, , tempint
    'Get handle, , tempint
    'Get handle, , tempint

    fileBuff.getDouble

    'Load arrays

    For Y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize
            'Get handle, , ByFlags
            ByFlags = fileBuff.getByte()

            MapData(Map, X, Y).Blocked = (ByFlags And 1)

            'Get handle, , MapData(X, Y).Graphic(1).GrhIndex
            MapData(Map, X, Y).Graphic(1) = fileBuff.getInteger()

            ''InitGrh MapData(x, Y).Graphic(1), MapData(x, Y).Graphic(1).GrhIndex

            'Layer 2 used?

            If ByFlags And 2 Then
                'Get handle, , MapData(X, Y).Graphic(2).GrhIndex
                MapData(Map, X, Y).Graphic(2) = fileBuff.getInteger()
                ''InitGrh MapData(x, Y).Graphic(2), MapData(x, Y).Graphic(2).GrhIndex
            Else
                MapData(Map, X, Y).Graphic(2) = 0
            End If

            'Layer 3 used?

            If ByFlags And 4 Then
                'Get handle, , MapData(X, Y).Graphic(3).GrhIndex
                MapData(Map, X, Y).Graphic(3) = fileBuff.getInteger()
            Else
                MapData(Map, X, Y).Graphic(3) = 0
            End If

            'Layer 4 used?

            If ByFlags And 8 Then
                'Get handle, , MapData(X, Y).Graphic(4).GrhIndex
                MapData(Map, X, Y).Graphic(4) = fileBuff.getInteger()
            Else
                MapData(Map, X, Y).Graphic(4) = 0
            End If

            'Trigger used?

            If ByFlags And 16 Then
                'Get handle, , MapData(X, Y).Trigger
                MapData(Map, X, Y).trigger = fileBuff.getInteger()
            Else
                MapData(Map, X, Y).trigger = 0
            End If

            'Erase NPCs

            'Erase OBJs
            ''MapData(Map, x, Y).ObjGrh.GrhIndex = 0

        Next X
    Next Y

    'Close handle

    Set fileBuff = Nothing        ' @@ Tanto te costaba Destruir el buff una ves que se termino de usar?


    MapInfo(Map).Name = vbNullString
    MapInfo(Map).music = vbNullString

End Sub
Public Sub CargarMapa(ByVal Map As Long, ByRef MAPFl As String)
'***************************************************
'Author: Unknown
'Last Modification: 10/08/2010
'10/08/2010 - Pato: Implemento el clsByteBuffer y el clsIniManager para la carga de mapa
'***************************************************

    On Error GoTo ERRH
    Dim hFile As Integer
    Dim X As Long
    Dim Y As Long
    Dim ByFlags As Byte
    Dim npcfile As String
    Dim Leer As clsIniManager
    Dim InfReader As clsByteBuffer
    Dim Buff() As Byte
    Dim ln As String

    Set InfReader = New clsByteBuffer
    Set Leer = New clsIniManager

    npcfile = DatPath & "NPCs.dat"

    hFile = FreeFile

    'inf
    Open MAPFl & ".inf" For Binary As #hFile
    Seek hFile, 1

    ReDim Buff(LOF(hFile) - 1) As Byte

    Get #hFile, , Buff
    Close hFile

    Call InfReader.initializeReader(Buff)

    Call SwitchMap(Map)
    'inf Header
    Call InfReader.getDouble
    Call InfReader.getInteger

    For Y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize
            With MapData(Map, X, Y)

                '.inf file
                ByFlags = InfReader.getByte

                If ByFlags And 1 Then
                    .TileExit.Map = InfReader.getInteger
                    .TileExit.X = InfReader.getInteger
                    .TileExit.Y = InfReader.getInteger
                    .TileExit.Radio = InfReader.getInteger
                End If

                If ByFlags And 2 Then
                    'Get and make NPC
                    .NpcIndex = InfReader.getInteger

                    If .NpcIndex > 0 Then
                        'Si el npc debe hacer respawn en la pos
                        'original la guardamos
                        If val(GetVar(npcfile, "NPC" & .NpcIndex, "PosOrig")) = 1 Then
                            .NpcIndex = OpenNPC(.NpcIndex)
                            Npclist(.NpcIndex).Orig.Map = Map
                            Npclist(.NpcIndex).Orig.X = X
                            Npclist(.NpcIndex).Orig.Y = Y
                        Else
                            .NpcIndex = OpenNPC(.NpcIndex)
                        End If

                        Npclist(.NpcIndex).Pos.Map = Map
                        Npclist(.NpcIndex).Pos.X = X
                        Npclist(.NpcIndex).Pos.Y = Y

                        Call MakeNPCChar(True, 0, .NpcIndex, Map, X, Y)
                    End If
                End If

                If ByFlags And 4 Then
                    'Get and make Object
                    .ObjInfo.ObjIndex = InfReader.getInteger
                    .ObjInfo.Amount = InfReader.getInteger

                    If .ObjInfo.ObjIndex > UBound(ObjData) Then
                        .ObjInfo.ObjIndex = 0
                        .ObjInfo.Amount = 0
                    End If
                    If .ObjInfo.ObjIndex > 0 Then
                        If ObjData(.ObjInfo.ObjIndex).OBJType = eOBJType.otTeleport Then
                            Call SetTriggerIlegalNPC(Map, X, Y)
                        End If
                    End If

                End If
            End With
        Next X
    Next Y

    Call Leer.Initialize(MAPFl & ".dat")

    With MapInfo(Map)
        .Name = Leer.GetValue("Mapa" & Map, "Name")
        .music = Leer.GetValue("Mapa" & Map, "MusicNum")
        .StartPos.Map = val(ReadField(1, Leer.GetValue("Mapa" & Map, "StartPos"), Asc("-")))
        .StartPos.X = val(ReadField(2, Leer.GetValue("Mapa" & Map, "StartPos"), Asc("-")))
        .StartPos.Y = val(ReadField(3, Leer.GetValue("Mapa" & Map, "StartPos"), Asc("-")))

        .MagiaSinEfecto = val(Leer.GetValue("Mapa" & Map, "MagiaSinEfecto"))
        .InviSinEfecto = val(Leer.GetValue("Mapa" & Map, "InviSinEfecto"))
        .ResuSinEfecto = val(Leer.GetValue("Mapa" & Map, "ResuSinEfecto"))
        .InvocarSinEfecto = val(Leer.GetValue("Mapa" & Map, "InvocarSinEfecto"))
        .NoEncriptarMP = val(Leer.GetValue("Mapa" & Map, "NoEncriptarMP"))
        .RoboNpcsPermitido = val(Leer.GetValue("Mapa" & Map, "RoboNpcsPermitido"))

        ln = Leer.GetValue("Mapa" & Map, "WarpOnDisconnect")
        If Len(ln) Then
            .WarpOnDisconnect.Map = val(ReadField(1, ln, Asc("-")))
            If .WarpOnDisconnect.Map = 0 Then
                .WarpOnDisconnect = Ullathorpe
            Else
                .WarpOnDisconnect.X = val(ReadField(2, ln, Asc("-")))
                .WarpOnDisconnect.Y = val(ReadField(3, ln, Asc("-")))
                If Not InMapBounds(.WarpOnDisconnect.Map, .WarpOnDisconnect.X, .WarpOnDisconnect.Y) Then
                    .WarpOnDisconnect = Ullathorpe
                End If
            End If
        End If

        If val(Leer.GetValue("Mapa" & Map, "Pk")) = 0 Then
            .pk = False
        Else
            .pk = True        '??????????????????
        End If

        .Terreno = Leer.GetValue("Mapa" & Map, "Terreno")
        .Zona = Leer.GetValue("Mapa" & Map, "Zona")
        .Restringir = Leer.GetValue("Mapa" & Map, "Restringir")
        .backup = val(Leer.GetValue("Mapa" & Map, "BACKUP"))
    End With

    Set InfReader = Nothing
    Set Leer = Nothing

    Erase Buff
    Exit Sub

ERRH:
    Call LogError("Error cargando mapa: " & Map & " - Pos: " & X & "," & Y & "." & Err.Description)

    Set InfReader = Nothing
    Set Leer = Nothing
End Sub

Sub LoadSini()

    Call BanHD_load

    Dim Temporal As Long
    Dim lTemp As Long
    Dim sTemp As String

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(IniPath & "server.ini")

    MaxClientPerSerial = val(Leer.GetValue("CONEXION", "MaxClientPerSerial"))
    MaxWorkersPerIP = val(Leer.GetValue("CONEXION", "MaxWorkersPerIP"))
    MaxWorkersPerPC = val(Leer.GetValue("CONEXION", "MaxWorkersPerPC"))

    NewbiesCanDoPartyWithNoNewbies = val(Leer.GetValue("INIT", "NewbiesCanDoPartyWithNoNewbies"))
    CONFIG_INI_BONUSELVMIN = val(Leer.GetValue("INIT", "BonusExp_MinLvl"))
    CONFIG_INI_BONUSNEEDACCOUNT = val(Leer.GetValue("INIT", "BonusExp_NeedAccount"))
    CONFIG_INI_MULTIEXP = val(Leer.GetValue("INIT", "BonusExp_Multi"))
    CONFIG_INI_BONUSALLOWWORKERS = val(Leer.GetValue("INIT", "BonusExp_AllowWorkers"))
    CONFIG_INI_ITEMS_SKILL_REQUIRED = val(Leer.GetValue("INIT", "RequiereSkillParaEquipar"))
    CONFIG_INI_ALLOWMULTIWORKERS = val(Leer.GetValue("INIT", "PermitirMultiTrabajadores"))
    CONFIG_INI_ALLOWMULTIWORKERS_STRICT = val(Leer.GetValue("INIT", "PermitirMultiTrabajadores_CheckHD"))

    CONFIG_INI_IDLECREATEKICKTOLERANCE = val(Leer.GetValue("INIT", "IdleKickTolerance_CrearPj"))    '@@PATCH

    CONFIG_INI_IDLEKICKTOLERANCE = val(Leer.GetValue("INIT", "IdleKickTolerance"))
    CONFIG_INI_OROABILLE = val(Leer.GetValue("INIT", "OroABilletera"))
    CONFIG_INI_OROABILLE_Only10k = val(Leer.GetValue("INIT", "OroABilletera_Only10k"))
    CONFIG_INI_INTMEDITAR = val(Leer.GetValue("INIT", "Intervalo_InicioMeditar"))
    CONFIG_INI_DRUIDADMGMULTIPLIER = val(Leer.GetValue("INIT", "Multiplicador_Dano_Druida"))
    CONFIG_INI_BARDODMGMULTIPLIER = val(Leer.GetValue("INIT", "Multiplicador_Dano_Bardo"))
    CONFIG_INI_SHOWONLINENAME = val(Leer.GetValue("INIT", "MostrarNicksEnOnline"))
    CONFIG_INI_RANDOMDICES = val(Leer.GetValue("INIT", "DadosAleatorios"))
    CONFIG_INI_HABILITARTORNEOS = val(Leer.GetValue("INIT", "HabilitarCrearTorneos"))

    CONFIG_INI_MULTIFIANZA = val(Leer.GetValue("INIT", "MultiplicadorFianza"))

    COSTO_RETOS_1VS1 = val(Leer.GetValue("RETOS", "Retos1vs1_CostoReto"))
    ESTADO_RETOS_1VS1 = val(Leer.GetValue("RETOS", "Retos1vs1_Activo"))

    COSTO_RETOS_2VS2 = val(Leer.GetValue("RETOS", "Retos2vs2_CostoReto"))
    ESTADO_RETOS_2VS2 = val(Leer.GetValue("RETOS", "Retos2vs2_Activo"))

    CONFIG_INI_RNDAPUCOMUN = val(Leer.GetValue("INIT", "Apu_Comun"))
    If CONFIG_INI_RNDAPUCOMUN = 0 Then CONFIG_INI_RNDAPUCOMUN = 100
    CONFIG_INI_RNDAPUASE = val(Leer.GetValue("INIT", "Apu_Ase"))
    If CONFIG_INI_RNDAPUASE = 0 Then CONFIG_INI_RNDAPUASE = 100
    CONFIG_INI_RNDAPUNPC = val(Leer.GetValue("INIT", "Apu_Npc"))
    If CONFIG_INI_RNDAPUNPC = 0 Then CONFIG_INI_RNDAPUNPC = 100

    CONFIG_INI_DMGAPUNPC = val(Leer.GetValue("INIT", "DañoApu_Npc"))
    If CONFIG_INI_DMGAPUNPC = 0 Then CONFIG_INI_DMGAPUNPC = 1.5
    CONFIG_INI_DMGAPUNPCASE = val(Leer.GetValue("INIT", "DañoApu_NpcAse"))
    If CONFIG_INI_DMGAPUNPCASE = 0 Then CONFIG_INI_DMGAPUNPCASE = 1.5

    CONFIG_INI_DMGAPUCOMUN = val(Leer.GetValue("INIT", "DañoApu_Comun"))
    CONFIG_INI_DMGAPUASE = val(Leer.GetValue("INIT", "DañoApu_Ase"))

    If CONFIG_INI_MULTIFIANZA = 0 Then CONFIG_INI_MULTIFIANZA = 1

    CONFIG_INI_BORRARPJ = val(Leer.GetValue("INIT", "BorrarPersonajes"))

    CONFIG_INI_RNDQUITAHAM = val(Leer.GetValue("INIT", "Trabajar_QuitaHambreProb"))
    CONFIG_INI_RNDQUITASED = val(Leer.GetValue("INIT", "Trabajar_QuitaSedProb"))

    CONFIG_INI_SHOWRESETMESSAGE = val(Leer.GetValue("INIT", "AvisarANewbieReset"))

    CONFIG_INI_ESTRELLAENNICK = val(Leer.GetValue("INIT", "Mostrar_Estrellas_En_Nick"))
    CONFIG_INI_STAREDUCTION = val(Leer.GetValue("INIT", "Reduccion_Stamina"))
    LluviaActiva = val(Leer.GetValue("INIT", "Lluvia"))
    centinelaActivado = val(Leer.GetValue("INIT", "Centinela"))
    BootDelBackUp = val(Leer.GetValue("INIT", "IniciarDesdeBackUp"))
    ExpMulti = val(Leer.GetValue("INIT", "Exp"))
    OroMulti = val(Leer.GetValue("INIT", "Oro"))

    GlobalActivo = (val(Leer.GetValue("INIT", "GlobalActivado")) > 0)

    FUN = (val(Leer.GetValue("INIT", "TDS_FACIL")) > 0)

    FUN_Rates(eRate.cOro) = val(Leer.GetValue("INIT", "TDS_FACIL_ORO"))
    FUN_Rates(eRate.cExp) = val(Leer.GetValue("INIT", "TDS_FACIL_EXP"))

    Puerto = val(Leer.GetValue("INIT", "StartPort"))

    PuertoWEB = val(Leer.GetValue("INIT", "StartPortWEB"))

    HideMe = val(Leer.GetValue("INIT", "Hide"))
    AllowMultiLogins = val(Leer.GetValue("INIT", "AllowMultiLogins"))
    IdleLimit = val(Leer.GetValue("INIT", "IdleLimit"))
    'Lee la version correcta del cliente
    ULTIMAVERSION = Leer.GetValue("INIT", "Version")

    frmMain.Caption = "Servidor TDS Legacy - " & ULTIMAVERSION

    PuedeCrearPersonajes = val(Leer.GetValue("INIT", "PuedeCrearPersonajes"))
    ServerSoloGMs = val(Leer.GetValue("init", "ServerSoloGMs"))


    MAPA_PRETORIANO = 163

    'Intervalos
    SanaIntervaloSinDescansar = val(Leer.GetValue("INTERVALOS", "SanaIntervaloSinDescansar"))
    FrmInterv.txtSanaIntervaloSinDescansar.Text = SanaIntervaloSinDescansar

    StaminaIntervaloSinDescansar = val(Leer.GetValue("INTERVALOS", "StaminaIntervaloSinDescansar"))
    FrmInterv.txtStaminaIntervaloSinDescansar.Text = StaminaIntervaloSinDescansar

    SanaIntervaloDescansar = val(Leer.GetValue("INTERVALOS", "SanaIntervaloDescansar"))
    FrmInterv.txtSanaIntervaloDescansar.Text = SanaIntervaloDescansar

    StaminaIntervaloDescansar = val(Leer.GetValue("INTERVALOS", "StaminaIntervaloDescansar"))
    FrmInterv.txtStaminaIntervaloDescansar.Text = StaminaIntervaloDescansar

    IntervaloSed = val(Leer.GetValue("INTERVALOS", "IntervaloSed"))
    FrmInterv.txtIntervaloSed.Text = IntervaloSed

    IntervaloHambre = val(Leer.GetValue("INTERVALOS", "IntervaloHambre"))
    FrmInterv.txtIntervaloHambre.Text = IntervaloHambre

    IntervaloVeneno = val(Leer.GetValue("INTERVALOS", "IntervaloVeneno"))
    FrmInterv.txtIntervaloVeneno.Text = IntervaloVeneno

    IntervaloParalizado = val(Leer.GetValue("INTERVALOS", "IntervaloParalizado"))
    FrmInterv.txtIntervaloParalizado.Text = IntervaloParalizado

    IntervaloInvisible = val(Leer.GetValue("INTERVALOS", "IntervaloInvisible"))
    FrmInterv.txtIntervaloInvisible.Text = IntervaloInvisible

    IntervaloFrio = val(Leer.GetValue("INTERVALOS", "IntervaloFrio"))
    FrmInterv.txtIntervaloFrio.Text = IntervaloFrio

    IntervaloWavFx = val(Leer.GetValue("INTERVALOS", "IntervaloWAVFX"))
    FrmInterv.txtIntervaloWAVFX.Text = IntervaloWavFx

    IntervaloInvocacion = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacion"))
    FrmInterv.txtInvocacion.Text = IntervaloInvocacion

    IntervaloInvocacionFuego = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionFuego"))
    FrmInterv.txtInvocacionFuego.Text = IntervaloInvocacion

    IntervaloInvocacionAgua = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionAgua"))
    FrmInterv.txtInvocacionAgua.Text = IntervaloInvocacion

    IntervaloInvocacionTierra = val(Leer.GetValue("INTERVALOS", "IntervaloInvocacionTierra"))
    FrmInterv.txtInvocacionTierra.Text = IntervaloInvocacion

    IntervaloParaConexion = val(Leer.GetValue("INTERVALOS", "IntervaloParaConexion"))
    FrmInterv.txtIntervaloParaConexion.Text = IntervaloParaConexion

    '&&&&&&&&&&&&&&&&&&&&& TIMERS &&&&&&&&&&&&&&&&&&&&&&&

    IntervaloPuedeSerAtacado = 5000        ' Cargar desde balance.dat
    IntervaloOwnedNpc = 18000        ' Cargar desde balance.dat

    frmMain.TIMER_AI.Interval = val(Leer.GetValue("INTERVALOS", "IntervaloNpcAI"))
    FrmInterv.txtAI.Text = frmMain.TIMER_AI.Interval

    frmMain.npcataca.Interval = val(Leer.GetValue("INTERVALOS", "IntervaloNpcPuedeAtacar"))
    FrmInterv.txtNPCPuedeAtacar.Text = frmMain.npcataca.Interval



    MinutosWs = val(Leer.GetValue("INTERVALOS", "IntervaloWS"))
    If MinutosWs < 60 Then MinutosWs = 180

    IntervaloCerrarConexion = val(Leer.GetValue("INTERVALOS", "IntervaloCerrarConexion"))

    INT_USEITEM = val(Leer.GetValue("INTERVALOS", "INT_USEITEM"))

    INT_USEITEMU = val(Leer.GetValue("INTERVALOS", "INT_USEITEMU"))
    INT_USEITEMDCK = val(Leer.GetValue("INTERVALOS", "INT_USEITEMDCK"))
    INT_ATTACK_USEITEM = val(Leer.GetValue("INTERVALOS", "INT_ATTACK_USEITEM"))

    INT_CAST_SPELL = val(Leer.GetValue("INTERVALOS", "INT_CAST_SPELL"))
    INT_ATTACK_CAST = val(Leer.GetValue("INTERVALOS", "INT_ATTACK_CAST"))
    INT_CAST_ATTACK = val(Leer.GetValue("INTERVALOS", "INT_CAST_ATTACK"))
    INT_ATTACK = val(Leer.GetValue("INTERVALOS", "INT_ATTACK"))
    INT_ARROWS = val(Leer.GetValue("INTERVALOS", "INT_ARROWS"))

    INT_WORK = val(Leer.GetValue("INTERVALOS", "INT_WORK"))

    useAntiCheatblock = val(Leer.GetValue("INIT", "useAntiCheatblock"))

    IntervaloOculto = val(Leer.GetValue("INTERVALOS", "IntervaloOculto"))

    '&&&&&&&&&&&&&&&&&&&&& FIN TIMERS &&&&&&&&&&&&&&&&&&&&&&&

    RecordUsuarios = val(Leer.GetValue("INIT", "Record"))

    'Max users
    Temporal = val(Leer.GetValue("INIT", "MaxUsers"))
    If maxUsers = 0 Then
        maxUsers = Temporal
        ReDim UserList(1 To maxUsers + 1) As User
    End If

    ''&&&&&&&&&&&&&&&&&&&&& FIN BALANCE &&&&&&&&&&&&&&&&&&&&&&&
    Call Statistics.Initialize

    Ullathorpe.Map = 1        'GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "Mapa")
    Ullathorpe.X = 58        'GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "X")
    Ullathorpe.Y = 45        'GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "Y")

    Nix.Map = 34        'GetVar(DatPath & "Ciudades.dat", "Nix", "Mapa")
    Nix.X = 44        'GetVar(DatPath & "Ciudades.dat", "Nix", "X")
    Nix.Y = 88        'GetVar(DatPath & "Ciudades.dat", "Nix", "Y")

    Banderbill.Map = 59        'GetVar(DatPath & "Ciudades.dat", "Banderbill", "Mapa")
    Banderbill.X = 50        'GetVar(DatPath & "Ciudades.dat", "Banderbill", "X")
    Banderbill.Y = 50        'GetVar(DatPath & "Ciudades.dat", "Banderbill", "Y")

    Lindos.Map = 62        'GetVar(DatPath & "Ciudades.dat", "Lindos", "Mapa")
    Lindos.X = 72        'GetVar(DatPath & "Ciudades.dat", "Lindos", "X")
    Lindos.Y = 41        'GetVar(DatPath & "Ciudades.dat", "Lindos", "Y")

    Arghal.Map = 151        'GetVar(DatPath & "Ciudades.dat", "Arghal", "Mapa")
    Arghal.X = 36        'GetVar(DatPath & "Ciudades.dat", "Arghal", "X")
    Arghal.Y = 68        'GetVar(DatPath & "Ciudades.dat", "Arghal", "Y")

    Ciudades(eCiudad.cUllathorpe) = Ullathorpe
    Ciudades(eCiudad.cNix) = Nix
    Ciudades(eCiudad.cBanderbill) = Banderbill
    Ciudades(eCiudad.cLindos) = Lindos
    Ciudades(eCiudad.cArghal) = Arghal

    Call MD5sCarga

    Set Leer = Nothing

    Call LoadRates

    Call ModFacciones.CargarRequisitos

    Call LoadDictionary

End Sub

Sub WriteVar(ByVal File As String, ByVal Main As String, ByVal var As String, ByVal value As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'Escribe VAR en un archivo
'***************************************************

    writeprivateprofilestring Main, var, value, File

End Sub

Sub SaveUser(ByVal UserIndex As Integer, ByVal UserFile As String)
'*************************************************
'Author: Unknown
'Last modified: 12/01/2010 (ZaMa)
'Saves the Users records
'23/01/2007 Pablo (ToxicWaste) - Agrego NivelIngreso, FechaIngreso, MatadosIngreso y NextRecompensa.
'11/19/2009: Pato - Save the EluSkills and ExpSkills
'12/01/2010: ZaMa - Los druidas pierden la inmunidad de ser atacados cuando pierden el efecto del mimetismo.
'*************************************************

    On Error GoTo Errhandler

    Dim Manager As clsIniManager
    Dim Existe As Boolean

    Dim OldUserHead As Long

    With UserList(UserIndex)

        'ESTO TIENE QUE EVITAR ESE BUGAZO QUE NO SE POR QUE GRABA USUARIOS NULOS
        'clase=0 es el error, porq el enum empieza de 1!!
        If .Clase = 0 Or .Stats.ELV = 0 Then
            Call LogCriticEvent("Estoy intentantdo guardar un usuario nulo de nombre: " & .Name)
            Exit Sub
        End If

        Set Manager = New clsIniManager

        If FileExist(UserFile) Then
            Call Manager.Initialize(UserFile)

            'If FileExist(UserFile & ".bk") Then
            'Call Kill(UserFile & ".bk")
            'End If

            'Name UserFile As UserFile & ".bk"

            Existe = True
        End If

        If .flags.Mimetizado = 1 Then
            .Char.body = .CharMimetizado.body
            .Char.Head = .CharMimetizado.Head
            .Char.CascoAnim = .CharMimetizado.CascoAnim
            .Char.ShieldAnim = .CharMimetizado.ShieldAnim
            .Char.WeaponAnim = .CharMimetizado.WeaponAnim
            .Counters.Mimetismo = 0
            .flags.Mimetizado = 0
            .flags.Mimetizado_Nick = ""
            .flags.Mimetizado_Color = 0
            ' Se fue el efecto del mimetismo, puede ser atacado por npcs
            .flags.Ignorado = False
        End If

        If FileExist(UserFile, vbNormal) Then
            If .flags.Muerto = 1 Then
                OldUserHead = .Char.Head
                .Char.Head = GetVar(UserFile, "INIT", "Head")
            End If
            '       Kill UserFile
        End If

        Dim LoopC As Long

        Call Manager.ChangeValue("INIT", "ACCOUNT", CStr(.Account))

        Call Manager.ChangeValue("FLAGS", "ExClan", CStr(.flags.ExClan))
        Call Manager.ChangeValue("FLAGS", "Muerto", CStr(.flags.Muerto))
        Call Manager.ChangeValue("FLAGS", "Escondido", CStr(.flags.Escondido))
        Call Manager.ChangeValue("FLAGS", "Hambre", CStr(.flags.Hambre))
        Call Manager.ChangeValue("FLAGS", "Sed", CStr(.flags.Sed))
        Call Manager.ChangeValue("FLAGS", "Desnudo", CStr(.flags.Desnudo))
        Call Manager.ChangeValue("FLAGS", "Ban", CStr(.flags.Ban))
        Call Manager.ChangeValue("FLAGS", "Navegando", CStr(.flags.Navegando))
        Call Manager.ChangeValue("FLAGS", "Envenenado", CStr(.flags.Envenenado))
        Call Manager.ChangeValue("FLAGS", "Paralizado", CStr(.flags.Paralizado))
        Call Manager.ChangeValue("FLAGS", "SeguroDrag", CStr(.flags.BlockDragItems))

        Call Manager.ChangeValue("ACCOUNT", "HD_Last", CStr(.HD_Last))

        'Matrix
        Call Manager.ChangeValue("FLAGS", "LastMap", CStr(.flags.lastMap))

        Call Manager.ChangeValue("FACCION", "Status", CStr(.faccion.Status))

        Call Manager.ChangeValue("COUNTERS", "Pena", CStr(.Counters.Pena))
        Call Manager.ChangeValue("COUNTERS", "SkillsAsignados", CStr(.Counters.AsignedSkills))
        Call Manager.ChangeValue("COUNTERS", "tBonif", CStr(.Counters.tBonif))

        Call Manager.ChangeValue("FACCIONES", "EjercitoReal", CStr(.faccion.ArmadaReal))
        Call Manager.ChangeValue("FACCIONES", "EjercitoCaos", CStr(.faccion.FuerzasCaos))
        Call Manager.ChangeValue("FACCIONES", "CiudMatados", CStr(.faccion.CiudadanosMatados))
        Call Manager.ChangeValue("FACCIONES", "CrimMatados", CStr(.faccion.CriminalesMatados))
        Call Manager.ChangeValue("FACCIONES", "rArCaos", CStr(.faccion.RecibioArmaduraCaos))
        Call Manager.ChangeValue("FACCIONES", "rArReal", CStr(.faccion.RecibioArmaduraReal))
        Call Manager.ChangeValue("FACCIONES", "rExCaos", CStr(.faccion.RecibioExpInicialCaos))
        Call Manager.ChangeValue("FACCIONES", "rExReal", CStr(.faccion.RecibioExpInicialReal))
        Call Manager.ChangeValue("FACCIONES", "recCaos", CStr(.faccion.RecompensasCaos))
        Call Manager.ChangeValue("FACCIONES", "recReal", CStr(.faccion.RecompensasReal))
        Call Manager.ChangeValue("FACCIONES", "Reenlistadas", CStr(.faccion.Reenlistadas))
        Call Manager.ChangeValue("FACCIONES", "NivelIngreso", CStr(.faccion.NivelIngreso))
        Call Manager.ChangeValue("FACCIONES", "FechaIngreso", .faccion.FechaIngreso)
        Call Manager.ChangeValue("FACCIONES", "MatadosIngreso", CStr(.faccion.MatadosIngreso))

        '¿Fueron modificados los atributos del usuario?
        If Not .flags.TomoPocion Then
            For LoopC = 1 To UBound(.Stats.UserAtributos)
                Call Manager.ChangeValue("ATRIBUTOS", "AT" & LoopC, CStr(.Stats.UserAtributos(LoopC)))
            Next LoopC
        Else
            For LoopC = 1 To UBound(.Stats.UserAtributos)
                '.Stats.UserAtributos(LoopC) = .Stats.UserAtributosBackUP(LoopC)
                Call Manager.ChangeValue("ATRIBUTOS", "AT" & LoopC, CStr(.Stats.UserAtributosBackUP(LoopC)))
            Next LoopC
        End If

        For LoopC = 1 To UBound(.Stats.UserSkills)
            Call Manager.ChangeValue("SKILLS", "SK" & LoopC, CStr(.Stats.UserSkills(LoopC)))
            Call Manager.ChangeValue("SKILLS", "ELUSK" & LoopC, CStr(.Stats.EluSkills(LoopC)))
            Call Manager.ChangeValue("SKILLS", "EXPSK" & LoopC, CStr(.Stats.ExpSkills(LoopC)))
        Next LoopC

        Call Manager.ChangeValue("CONTACTO", "Email", .Email)

        Call Manager.ChangeValue("INIT", "Genero", .Genero)
        Call Manager.ChangeValue("INIT", "Raza", .raza)
        Call Manager.ChangeValue("INIT", "Hogar", .Hogar)
        Call Manager.ChangeValue("INIT", "Clase", .Clase)
        Call Manager.ChangeValue("INIT", "Desc", .Desc)

        Call Manager.ChangeValue("INIT", "Heading", CStr(.Char.Heading))

        Call Manager.ChangeValue("INIT", "Head", CStr(.OrigChar.Head))

        If .flags.Muerto = 0 Then
            Call Manager.ChangeValue("INIT", "Body", CStr(.Char.body))
        End If

        Call Manager.ChangeValue("INIT", "Arma", CStr(.Char.WeaponAnim))
        Call Manager.ChangeValue("INIT", "Escudo", CStr(.Char.ShieldAnim))
        Call Manager.ChangeValue("INIT", "Casco", CStr(.Char.CascoAnim))

        #If ConUpTime Then
            Dim TempDate As Date
            TempDate = Now - .LogOnTime
            .LogOnTime = Now
            .UpTime = .UpTime + (Abs(Day(TempDate) - 30) * 24 * 3600) + Hour(TempDate) * 3600 + Minute(TempDate) * 60 + Second(TempDate)
            .UpTime = .UpTime
            Call Manager.ChangeValue("INIT", "UpTime", .UpTime)
        #End If

        'First time around?
        If GetVar(UserFile, "INIT", "LastIP1") = vbNullString Then
            Call Manager.ChangeValue("INIT", "LastIP1", .IP & " - " & Date & ":" & Time)
            'Is it a different ip from last time?
        ElseIf .IP <> Left$(GetVar(UserFile, "INIT", "LastIP1"), InStr(1, GetVar(UserFile, "INIT", "LastIP1"), " ") - 1) Then
            Dim i As Integer
            For i = 5 To 2 Step -1
                Call Manager.ChangeValue("INIT", "LastIP" & i, GetVar(UserFile, "INIT", "LastIP" & CStr(i - 1)))
            Next i
            Call Manager.ChangeValue("INIT", "LastIP1", .IP & " - " & Date & ":" & Time)
            'Same ip, just update the date
        Else
            Call Manager.ChangeValue("INIT", "LastIP1", .IP & " - " & Date & ":" & Time)
        End If

        Call Manager.ChangeValue("INIT", "Position", .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y)

        Call Manager.ChangeValue("STATS", "GLD", CStr(.Stats.GLD))
        Call Manager.ChangeValue("STATS", "BANCO", CStr(.Stats.Banco))

        Call Manager.ChangeValue("RETOS", "GANADOS", CStr(.Stats.RetosGanados))
        Call Manager.ChangeValue("RETOS", "PERDIDOS", CStr(.Stats.RetosPerdidos))

        Call Manager.ChangeValue("RETOS", "ORO_GANADO", CStr(.Stats.OroGanado))
        Call Manager.ChangeValue("RETOS", "ORO_PERDIDO", CStr(.Stats.OroPerdido))

        Call Manager.ChangeValue("PENAS", "PuntosFotodenuncia", CStr(.Stats.PuntosFotodenuncia))
        Call Manager.ChangeValue("GUILD", "ParticipoClanes", CStr(.Stats.ParticipoClanes))
        Call Manager.ChangeValue("GUILD", "FundoClan", CStr(.Stats.FundoClan))
        Call Manager.ChangeValue("GUILD", "DisolvioClan", CStr(.Stats.DisolvioClan))

        For LoopC = 1 To MAXPENAS
            Call Manager.ChangeValue("PENAS", "P" & LoopC, CStr(.Stats.Penas(LoopC)))
        Next LoopC

        Call Manager.ChangeValue("PENAS", "Cant", CStr(.Stats.CantPenas))

        Call Manager.ChangeValue("STATS", "MaxHP", CStr(.Stats.MaxHP))
        Call Manager.ChangeValue("STATS", "MinHP", CStr(.Stats.MinHP))

        Call Manager.ChangeValue("STATS", "MaxSTA", CStr(.Stats.MaxSta))
        Call Manager.ChangeValue("STATS", "MinSTA", CStr(.Stats.minSta))

        Call Manager.ChangeValue("STATS", "MaxMAN", CStr(.Stats.MaxMAN))
        Call Manager.ChangeValue("STATS", "MinMAN", CStr(.Stats.MinMAN))

        Call Manager.ChangeValue("STATS", "MaxHIT", CStr(.Stats.MaxHIT))
        Call Manager.ChangeValue("STATS", "MinHIT", CStr(.Stats.MinHIT))

        Call Manager.ChangeValue("STATS", "MaxAGU", CStr(.Stats.MaxAGU))
        Call Manager.ChangeValue("STATS", "MinAGU", CStr(.Stats.MinAGU))

        Call Manager.ChangeValue("STATS", "MaxHAM", CStr(.Stats.MaxHam))
        Call Manager.ChangeValue("STATS", "MinHAM", CStr(.Stats.MinHam))

        Call Manager.ChangeValue("STATS", "SkillPtsLibres", CStr(.Stats.SkillPts))
        Call Manager.ChangeValue("STATS", "AsignoSkills", CStr(.Stats.AsignoSkills))

        Call Manager.ChangeValue("STATS", "EXP", CStr(.Stats.Exp))
        Call Manager.ChangeValue("STATS", "ELV", CStr(.Stats.ELV))


        Call Manager.ChangeValue("STATS", "ELU", CStr(.Stats.elu))
        Call Manager.ChangeValue("MUERTES", "UserMuertes", CStr(.Stats.UsuariosMatados))
        'Call Manager.ChangeValue( "MUERTES", "CrimMuertes", CStr(.Stats.CriminalesMatados))
        Call Manager.ChangeValue("MUERTES", "NpcsMuertes", CStr(.Stats.NPCsMuertos))

        '[KEVIN]----------------------------------------------------------------------------
        '*******************************************************************************************
        'Call Manager.ChangeValue("BancoInventory", "CantidadItems", val(.BancoInvent.NroItems))
        Dim loopd As Integer
        For loopd = 1 To MAX_BANCOINVENTORY_SLOTS
            Call Manager.ChangeValue("BancoInventory", "Obj" & loopd, .BancoInvent.Object(loopd).ObjIndex & "-" & .BancoInvent.Object(loopd).Amount)
        Next loopd
        '*******************************************************************************************
        '[/KEVIN]-----------

        'Save Inv
        'Call Manager.ChangeValue("Inventory", "CantidadItems", val(.Invent.NroItems))

        For LoopC = 1 To MAX_INVENTORY_SLOTS
            Call Manager.ChangeValue("Inventory", "Obj" & LoopC, .Invent.Object(LoopC).ObjIndex & "-" & .Invent.Object(LoopC).Amount & "-" & .Invent.Object(LoopC).Equipped)
        Next LoopC

        Call Manager.ChangeValue("Inventory", "WeaponEqpSlot", CStr(.Invent.WeaponEqpSlot))
        Call Manager.ChangeValue("Inventory", "ArmourEqpSlot", CStr(.Invent.ArmourEqpSlot))
        Call Manager.ChangeValue("Inventory", "CascoEqpSlot", CStr(.Invent.CascoEqpSlot))
        Call Manager.ChangeValue("Inventory", "EscudoEqpSlot", CStr(.Invent.EscudoEqpSlot))
        Call Manager.ChangeValue("Inventory", "BarcoSlot", CStr(.Invent.BarcoSlot))
        Call Manager.ChangeValue("Inventory", "MunicionSlot", CStr(.Invent.MunicionEqpSlot))
        '/Nacho

        Call Manager.ChangeValue("Inventory", "AnilloSlot", CStr(.Invent.AnilloEqpSlot))
        Call Manager.ChangeValue("Inventory", "AnilloSlot2", CStr(.Invent.AnilloEqpSlot2))

        'Reputacion
        Call Manager.ChangeValue("REP", "Asesino", CStr(.Reputacion.AsesinoRep))
        Call Manager.ChangeValue("REP", "Bandido", CStr(.Reputacion.BandidoRep))
        Call Manager.ChangeValue("REP", "Burguesia", CStr(.Reputacion.BurguesRep))
        Call Manager.ChangeValue("REP", "Ladrones", CStr(.Reputacion.LadronesRep))
        Call Manager.ChangeValue("REP", "Nobles", CStr(.Reputacion.NobleRep))
        Call Manager.ChangeValue("REP", "Plebe", CStr(.Reputacion.PlebeRep))

        Dim L As Long
        L = (-.Reputacion.AsesinoRep) + _
            (-.Reputacion.BandidoRep) + _
            .Reputacion.BurguesRep + _
            (-.Reputacion.LadronesRep) + _
            .Reputacion.NobleRep + _
            .Reputacion.PlebeRep
        L = L / 6
        Call Manager.ChangeValue("REP", "Promedio", CStr(L))

        Dim cad As String

        For LoopC = 1 To MAXUSERHECHIZOS
            cad = .Stats.UserHechizos(LoopC)
            Call Manager.ChangeValue("HECHIZOS", "H" & LoopC, cad)
        Next

        For LoopC = 1 To MAXMASCOTAS
            ' Mascota valida?
            If .MascotasType(LoopC) > 0 Then
                If .MascotasIndex(LoopC) < 1 Then
                    Call Manager.ChangeValue("MASCOTAS", "MAS" & LoopC, .MascotasType(LoopC))
                Else
                    If Npclist(.MascotasIndex(LoopC)).flags.Domable > 0 Then
                        Call Manager.ChangeValue("MASCOTAS", "MAS" & LoopC, "0")
                    End If
                End If
            End If
        Next LoopC

        'Devuelve el head de muerto
        If .flags.Muerto = 1 Then
            .Char.Head = iCabezaMuerto
        End If

        Call SaveUserAntiFrags(UserIndex, Manager)

        Call SaveQuestStats(UserIndex, Manager)
    End With

    Call Manager.DumpFile(UserFile)
    Set Manager = Nothing

    Exit Sub

Errhandler:

    Call LogError("Error en SaveUser. Error: " & Err.Number & " - " & Err.Description & " - Charfile: " & UserFile)
    Set Manager = Nothing

End Sub

Function criminal(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim L As Long

    With UserList(UserIndex).Reputacion
        L = (-.AsesinoRep) + _
            (-.BandidoRep) + _
            .BurguesRep + _
            (-.LadronesRep) + _
            .NobleRep + _
            .PlebeRep
        L = L / 6
        criminal = (L < 0)
    End With

End Function

Sub LogBanFromName(ByVal BannedName As String, ByVal UserIndex As Integer, ByVal Motivo As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", BannedName, "BannedBy", UserList(UserIndex).Name)
    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", BannedName, "Reason", Motivo)

    'Log interno del servidor, lo usa para hacer un UNBAN general de toda la gente banned
    Dim mifile As Integer
    mifile = FreeFile
    Open App.path & "\logs\GenteBanned.log" For Append Shared As #mifile
    Print #mifile, BannedName
    Close #mifile

End Sub


Sub Ban(ByVal BannedName As String, ByVal Baneador As String, ByVal Motivo As String)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", BannedName, "BannedBy", Baneador)
    Call WriteVar(App.path & "\logs\" & "BanDetail.dat", BannedName, "Reason", Motivo)


    'Log interno del servidor, lo usa para hacer un UNBAN general de toda la gente banned
    Dim mifile As Integer
    mifile = FreeFile
    Open App.path & "\logs\GenteBanned.log" For Append Shared As #mifile
    Print #mifile, BannedName
    Close #mifile

End Sub

Public Sub CargaApuestas()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Apuestas.Ganancias = val(GetVar(DatPath & "apuestas.dat", "Main", "Ganancias"))
    Apuestas.Perdidas = val(GetVar(DatPath & "apuestas.dat", "Main", "Perdidas"))
    Apuestas.Jugadas = val(GetVar(DatPath & "apuestas.dat", "Main", "Jugadas"))

End Sub

Public Sub generateMatrix(ByVal mapa As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim i As Integer
    Dim j As Integer

    ReDim distanceToCities(1 To NumMaps) As HomeDistance

    For j = 1 To NUMCIUDADES
        For i = 1 To NumMaps
            distanceToCities(i).distanceToCity(j) = -1
        Next i
    Next j

    For j = 1 To NUMCIUDADES
        For i = 1 To 4
            Select Case i
            Case eHeading.NORTH
                Call setDistance(getLimit(Ciudades(j).Map, eHeading.NORTH), j, i, 0, 1)
            Case eHeading.EAST
                Call setDistance(getLimit(Ciudades(j).Map, eHeading.EAST), j, i, 1, 0)
            Case eHeading.SOUTH
                Call setDistance(getLimit(Ciudades(j).Map, eHeading.SOUTH), j, i, 0, 1)
            Case eHeading.WEST
                Call setDistance(getLimit(Ciudades(j).Map, eHeading.WEST), j, i, -1, 0)
            End Select
        Next i
    Next j

End Sub

Public Sub setDistance(ByVal mapa As Integer, ByVal City As Byte, ByVal side As Integer, Optional ByVal X As Integer = 0, Optional ByVal Y As Integer = 0)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim i As Integer
    Dim lim As Integer

    If mapa <= 0 Or mapa > NumMaps Then Exit Sub

    If distanceToCities(mapa).distanceToCity(City) >= 0 Then Exit Sub

    If mapa = Ciudades(City).Map Then
        distanceToCities(mapa).distanceToCity(City) = 0
    Else
        distanceToCities(mapa).distanceToCity(City) = Abs(X) + Abs(Y)
    End If

    For i = 1 To 4
        lim = getLimit(mapa, i)
        If lim > 0 Then
            Select Case i
            Case eHeading.NORTH
                Call setDistance(lim, City, i, X, Y + 1)
            Case eHeading.EAST
                Call setDistance(lim, City, i, X + 1, Y)
            Case eHeading.SOUTH
                Call setDistance(lim, City, i, X, Y - 1)
            Case eHeading.WEST
                Call setDistance(lim, City, i, X - 1, Y)
            End Select
        End If
    Next i
End Sub

Public Function getLimit(ByVal mapa As Integer, ByVal side As Byte) As Integer
'***************************************************
'Author: Budi
'Last Modification: 31/01/2010
'Retrieves the limit in the given side in the given map.
'TODO: This should be set in the .inf map file.
'***************************************************
    Dim X, Y As Integer

    If mapa <= 0 Then Exit Function

    For X = 15 To 87
        For Y = 0 To 3
            Select Case side
            Case eHeading.NORTH
                getLimit = MapData(mapa, X, 7 + Y).TileExit.Map
            Case eHeading.EAST
                getLimit = MapData(mapa, 92 - Y, X).TileExit.Map
            Case eHeading.SOUTH
                getLimit = MapData(mapa, X, 94 - Y).TileExit.Map
            Case eHeading.WEST
                getLimit = MapData(mapa, 9 + Y, X).TileExit.Map
            End Select
            If getLimit > 0 Then Exit Function
        Next Y
    Next X
End Function
