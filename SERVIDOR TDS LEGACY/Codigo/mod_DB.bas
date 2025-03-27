Attribute VB_Name = "mod_DB"
Option Explicit

Public totInet As Long


Public Sub Update_DataBase_UserIndex(ByVal UserIndex As Integer, ByVal Pin As String, ByVal Password As String)

    On Error GoTo Errhandler

    If frmMain.chkwebSystem.value = 0 Then Exit Sub

    Dim i As Long

    If totPjsAUpdatear = 0 Then
        ReDim PjsAUpdatear(1 To 1)
        PjsAUpdatear(1) = UserList(UserIndex)
        totPjsAUpdatear = 1
        Exit Sub
    Else
        For i = LBound(PjsAUpdatear) To UBound(PjsAUpdatear)
            If UCase$(PjsAUpdatear(i).Name) = UCase$(UserList(UserIndex).Name) Then
                PjsAUpdatear(i) = UserList(UserIndex)
                Exit Sub
            End If
        Next i
    End If

    totPjsAUpdatear = totPjsAUpdatear + 1
    ReDim Preserve PjsAUpdatear(1 To totPjsAUpdatear)
    PjsAUpdatear(totPjsAUpdatear) = UserList(UserIndex)
    Exit Sub

Errhandler:
    Call LogError("Error en Update_DB_UI en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub WEB_Tick()
    On Error Resume Next

    If frmMain.sck_PostWEB.State = 7 Then

        frmMain.sck_PostWEB.SendData ("|2" & "ons=" & NumUsers + F_ONLINES & "&oro=" & OroMulti & "&exp=" & ExpMulti)
        ' frmMain.lblSock.Caption = "Sending ping.."
    Else
        If frmMain.sck_PostWEB.State <> 0 Then frmMain.sck_PostWEB.Close
        frmMain.sck_PostWEB.connect        ' conectamos y esperamos al siguiente
        ' frmMain.lblSock.Caption = "Connecting in WEB_Update_onlines.."
    End If
End Sub

Public Sub WEB_Update_UserName(ByVal UserName As String)

    On Error GoTo Errhandler

    If frmMain.chkwebSystem.value = 0 Then Exit Sub


    Dim LoopC As Long
    Dim ln As String
    Dim UserFile As clsIniManager
    Set UserFile = New clsIniManager
    Dim found As Boolean

    Dim i As Long

    If totPjsAUpdatear = 0 Then
        totPjsAUpdatear = 1
        ReDim PjsAUpdatear(1 To totPjsAUpdatear)
    End If

    For i = LBound(PjsAUpdatear) To UBound(PjsAUpdatear)
        If LCase$(PjsAUpdatear(i).Name) = LCase$(UserName) Then totPjsAUpdatear = i: found = True: Exit For
    Next i

    If Not found Then
        totPjsAUpdatear = totPjsAUpdatear + 1
        ReDim Preserve PjsAUpdatear(1 To totPjsAUpdatear)
    End If

    On Error Resume Next

    Call UserFile.Initialize(CharPath & UserName & ".chr")

    With PjsAUpdatear(totPjsAUpdatear)

        PjsAUpdatear(totPjsAUpdatear).Pin = UserFile.GetValue("INIT", "Pin")
        PjsAUpdatear(totPjsAUpdatear).Pass = UserFile.GetValue("INIT", "Password")

        If EsAdmin(UserName) Then
            .flags.Privilegios = PlayerType.Admin
        ElseIf EsDios(UserName) Then
            .flags.Privilegios = PlayerType.Dios
        ElseIf EsSemiDios(UserName) Then
            .flags.Privilegios = PlayerType.SemiDios
        ElseIf EsConsejero(UserName) Then
            .flags.Privilegios = PlayerType.Consejero
        ElseIf EsRolesMaster(UserName) Then
            .flags.Privilegios = PlayerType.RoleMaster
        Else
            .flags.Privilegios = PlayerType.User
        End If

        With .faccion
            .ArmadaReal = CByte(UserFile.GetValue("FACCIONES", "EjercitoReal"))
            .FuerzasCaos = CByte(UserFile.GetValue("FACCIONES", "EjercitoCaos"))
            .CiudadanosMatados = CLng(UserFile.GetValue("FACCIONES", "CiudMatados"))
            .CriminalesMatados = CLng(UserFile.GetValue("FACCIONES", "CrimMatados"))
            .NivelIngreso = CInt(UserFile.GetValue("FACCIONES", "NivelIngreso"))
            .FechaIngreso = UserFile.GetValue("FACCIONES", "FechaIngreso")
        End With
        .flags.mao_index = val(UserFile.GetValue("MAO", "MAO_Index"))
        .Counters.Pena = val(UserFile.GetValue("COUNTERS", "Pena"))
        .Counters.tBonif = val(UserFile.GetValue("COUNTERS", "tBonif"))
        .Counters.AsignedSkills = CByte(val(UserFile.GetValue("COUNTERS", "SkillsAsignados")))
        .Email = UserFile.GetValue("CONTACTO", "Email")
        .Account = UserFile.GetValue("INIT", "ACCOUNT")
        .Genero = UserFile.GetValue("INIT", "Genero")
        .Clase = UserFile.GetValue("INIT", "Clase")
        .raza = UserFile.GetValue("INIT", "Raza")
        .Hogar = UserFile.GetValue("INIT", "Hogar")
        .Char.Heading = CInt(UserFile.GetValue("INIT", "Heading"))

        #If ConUpTime Then
            .UpTime = CLng(UserFile.GetValue("INIT", "UpTime"))
        #End If

        .Pos.Map = CInt(ReadField(1, UserFile.GetValue("INIT", "Position"), 45))
        .Pos.X = CInt(ReadField(2, UserFile.GetValue("INIT", "Position"), 45))
        .Pos.Y = CInt(ReadField(3, UserFile.GetValue("INIT", "Position"), 45))
        '.Invent.NroItems = CInt(UserFile.GetValue("Inventory", "CantidadItems"))
        '.BancoInvent.NroItems = CInt(UserFile.GetValue("BancoInventory", "CantidadItems"))
        For LoopC = 1 To MAX_BANCOINVENTORY_SLOTS
            ln = UserFile.GetValue("BancoInventory", "Obj" & LoopC)
            .BancoInvent.Object(LoopC).ObjIndex = CInt(ReadField(1, ln, 45))
            .BancoInvent.Object(LoopC).Amount = CInt(ReadField(2, ln, 45))
        Next LoopC
        For LoopC = 1 To MAX_INVENTORY_SLOTS
            ln = UserFile.GetValue("Inventory", "Obj" & LoopC)
            .Invent.Object(LoopC).ObjIndex = CInt(ReadField(1, ln, 45))
            .Invent.Object(LoopC).Amount = CInt(ReadField(2, ln, 45))
            .Invent.Object(LoopC).Equipped = CByte(ReadField(3, ln, 45))
        Next LoopC

        ln = UserFile.GetValue("Guild", "GUILDINDEX")
        If IsNumeric(ln) Then
            .GuildIndex = CInt(ln)
        Else
            .GuildIndex = 0
        End If
        With .Stats
            For LoopC = 1 To NUMATRIBUTOS
                .UserAtributos(LoopC) = CInt(UserFile.GetValue("ATRIBUTOS", "AT" & LoopC))
            Next LoopC

            For LoopC = 1 To NUMSKILLS
                .UserSkills(LoopC) = CInt(UserFile.GetValue("SKILLS", "SK" & LoopC))
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

            .SkillPts = CInt(UserFile.GetValue("STATS", "SkillPtsLibres"))

            .Exp = CDbl(UserFile.GetValue("STATS", "EXP"))
            .elu = CLng(UserFile.GetValue("STATS", "ELU"))
            .ELV = CByte(UserFile.GetValue("STATS", "ELV"))

            .UsuariosMatados = CLng(UserFile.GetValue("MUERTES", "UserMuertes"))
            .NPCsMuertos = CInt(UserFile.GetValue("MUERTES", "NpcsMuertes"))
        End With

        .faccion.Status = val(UserFile.GetValue("FACCION", "Status"))

        With .Reputacion
            .AsesinoRep = val(UserFile.GetValue("REP", "Asesino"))
            .BandidoRep = val(UserFile.GetValue("REP", "Bandido"))
            .BurguesRep = val(UserFile.GetValue("REP", "Burguesia"))
            .LadronesRep = val(UserFile.GetValue("REP", "Ladrones"))
            .NobleRep = val(UserFile.GetValue("REP", "Nobles"))
            .PlebeRep = val(UserFile.GetValue("REP", "Plebe"))
            .Promedio = val(UserFile.GetValue("REP", "Promedio"))
        End With

    End With
    Exit Sub

Errhandler:
    Call LogError("Error en WEB_Update_UserName en " & Erl & ". Err: " & Err.Number & " " & Err.Description)
End Sub
