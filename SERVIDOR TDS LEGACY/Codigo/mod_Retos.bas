Attribute VB_Name = "mod_Retos1vs1"
Option Explicit

Private Type tUretos
    UserIndex As Integer
    Rondas As Byte
    x As Byte
    Y As Byte
End Type

Private Type tRetos
    Player(1) As tUretos
    ocupada As Boolean
    Oro As Long
    Items As Boolean
    CuentaRegresiva As Integer
End Type

Public Arena(1 To 6) As tRetos
Public ArenaPlantes(1 To 4) As tRetos

Public Const Mapa_Retos As Integer = 176
Public Const Mapa_Retos_Items As Integer = 191
Public Const Mapa_Retos_Plantes As Integer = 1
''FALTA RESETIAR FLAGS

Private Sub InicializarArena(ByVal ArenaN As Byte, ByVal X1 As Byte, ByVal Y1 As Byte, ByVal X2 As Byte, ByVal Y2 As Byte)
    With Arena(ArenaN)
        .Player(0).x = X1
        .Player(0).Y = Y1
        .Player(1).x = X2
        .Player(1).Y = Y2
    End With
End Sub
Private Sub InicializarArenaPlante(ByVal ArenaN As Byte, ByVal X1 As Byte, ByVal Y1 As Byte, ByVal X2 As Byte, ByVal Y2 As Byte)
    With ArenaPlantes(ArenaN)
        .Player(0).x = X1
        .Player(0).Y = Y1
        .Player(1).x = X2
        .Player(1).Y = Y2
    End With
End Sub
Public Sub InitRetos()
    InicializarArena 1, 13, 18, 27, 28
    InicializarArena 2, 44, 18, 58, 28
    InicializarArena 3, 74, 18, 88, 28
    InicializarArena 4, 13, 46, 27, 56
    InicializarArena 5, 44, 46, 58, 56
    InicializarArena 6, 74, 46, 88, 56
    InicializarArenaPlante 1, 50, 50, 49, 50
    InicializarArenaPlante 2, 0, 0, 0, 0
    InicializarArenaPlante 3, 0, 0, 0, 0 ''NO USES NULL PARA ESO BOBO, USA 0
    InicializarArenaPlante 4, 0, 0, 0, 0
End Sub

Public Sub MandarReto(ByVal UserIndex As Integer, ByVal tIndex As Integer, ByVal Oro As Long, ByVal Items As Boolean, ByVal Plantes As Boolean, ByVal Pociones As Integer, ByVal Cascos_Escudos As Boolean, ByVal Personaje As Boolean, ByVal AIM As Boolean)
    Dim nArena As Byte
    nArena = NuevaArena(Plantes)
    If nArena = 0 Then
        WriteConsoleMsg UserIndex, "No hay arenas disponibles", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If
    
    If Not PuedeReto(UserIndex, Oro, tIndex) Then Exit Sub
    
    With UserList(UserIndex).UserReto.MandoReto
        .tIndex = tIndex
        .Oro = Oro
        .Items = Items
        .Pociones = Pociones
        .Personaje = Personaje
        .AIM = AIM
    End With
    
    UserList(UserIndex).UserReto.Plantes = Plantes
    UserList(UserIndex).UserReto.Escudos_Cascos = Cascos_Escudos
    
    WriteConsoleMsg tIndex, UserList(UserIndex).Name & "(" & UserList(UserIndex).Stats.ELV & _
                            ") te ha invitado a participar en un reto" & IIf(Plantes = True, " de plantes ", " ") & "por " & Oro & " monedas de oro." & IIf(Pociones > 0, " Límite de pociones " & Pociones, vbNullString) _
                            & IIf(Cascos_Escudos = True, " Se juega sin cascos y escudos.", vbNullString) & IIf(AIM = True, " Se juega al AIM.", vbNullString) & IIf(Items = True, " y los items del inventario.", vbNullString) & _
                             IIf(Personaje = True, " ATENCIÓN: Se juega por el personaje.", vbNullString) & " Escribe /RETAR " & UserList(UserIndex).Name & " para aceptar.", FontTypeNames.FONTTYPE_GUILD

    WriteConsoleMsg UserIndex, "Solicitud enviada satisfactoriamente", FontTypeNames.FONTTYPE_INFO
    
End Sub

Public Sub AceptarReto(ByVal UserIndex As Integer, tIndex As Integer)
    
    If UserList(tIndex).UserReto.MandoReto.tIndex <> UserIndex Then
        WriteConsoleMsg UserIndex, "Este usuario no te envio ninguna solicitud de reto", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If
    
    Dim nArena As Byte
    nArena = NuevaArena(UserList(tIndex).UserReto.Plantes)
    If nArena = 0 Then
        WriteConsoleMsg UserIndex, "No hay arenas disponibles", FontTypeNames.FONTTYPE_INFO
        Exit Sub
    End If
    
    If (Not PuedeReto(UserIndex, UserList(tIndex).UserReto.MandoReto.Oro, tIndex, UserList(tIndex).UserReto.MandoReto.Pociones)) Or (Not PuedeReto(tIndex, UserList(tIndex).UserReto.MandoReto.Oro, UserIndex, UserList(tIndex).UserReto.MandoReto.Pociones)) Then Exit Sub
    
    UserList(UserIndex).UserReto.Escudos_Cascos = UserList(tIndex).UserReto.Escudos_Cascos
    
    If UserList(tIndex).UserReto.Escudos_Cascos = True Then
        With UserList(tIndex)
            If .Invent.CascoEqpObjIndex > 0 Then
                Call Desequipar(tIndex, .Invent.CascoEqpSlot)
            End If
            If .Invent.EscudoEqpObjIndex > 0 Then
                Call Desequipar(tIndex, .Invent.EscudoEqpSlot)
            End If
        End With
        With UserList(UserIndex)
            If .Invent.CascoEqpObjIndex > 0 Then
                Call Desequipar(UserIndex, .Invent.CascoEqpSlot)
            End If
            If .Invent.EscudoEqpObjIndex > 0 Then
                Call Desequipar(UserIndex, .Invent.EscudoEqpSlot)
            End If
        End With
    End If
    
    If UserList(tIndex).UserReto.Plantes = False Then
        
        With Arena(nArena)
            .Player(0).UserIndex = tIndex
            .Player(1).UserIndex = UserIndex
            .Items = UserList(tIndex).UserReto.MandoReto.Items
            .Oro = UserList(tIndex).UserReto.MandoReto.Oro
            .ocupada = True
            .CuentaRegresiva = 10
            UserList(.Player(0).UserIndex).UserReto.lastPos = UserList(.Player(0).UserIndex).Pos
            UserList(.Player(1).UserIndex).UserReto.lastPos = UserList(.Player(1).UserIndex).Pos
            WarpUserChar tIndex, Mapa_Retos, .Player(0).x, .Player(0).Y, False
            WarpUserChar UserIndex, Mapa_Retos, .Player(1).x, .Player(1).Y, False
            WritePauseToggle tIndex
            WritePauseToggle UserIndex
            UserList(.Player(0).UserIndex).UserReto.Arena = nArena
            UserList(.Player(1).UserIndex).UserReto.Arena = nArena
            UserList(.Player(0).UserIndex).UserReto.EnReto = True
            UserList(.Player(1).UserIndex).UserReto.EnReto = True
            UserList(.Player(0).UserIndex).UserReto.MandoReto.tIndex = 0
            UserList(.Player(1).UserIndex).UserReto.MandoReto.tIndex = 0
            UserList(.Player(0).UserIndex).UserReto.MandoReto.Pociones = 0
            UserList(.Player(1).UserIndex).UserReto.MandoReto.Pociones = 0
            UserList(.Player(0).UserIndex).Stats.GLD = UserList(.Player(0).UserIndex).Stats.GLD - .Oro
            UserList(.Player(1).UserIndex).Stats.GLD = UserList(.Player(1).UserIndex).Stats.GLD - .Oro
            WriteUpdateGold .Player(0).UserIndex
            WriteUpdateGold .Player(1).UserIndex
            
        End With
    Else
        With ArenaPlantes(nArena)
            .Player(0).UserIndex = tIndex
            .Player(1).UserIndex = UserIndex
            UserList(UserIndex).UserReto.Plantes = True
            .Items = UserList(tIndex).UserReto.MandoReto.Items
            .Oro = UserList(tIndex).UserReto.MandoReto.Oro
            .ocupada = True
            .CuentaRegresiva = 10
            UserList(.Player(0).UserIndex).UserReto.lastPos = UserList(.Player(0).UserIndex).Pos
            UserList(.Player(1).UserIndex).UserReto.lastPos = UserList(.Player(1).UserIndex).Pos
            WarpUserChar tIndex, 1, .Player(0).x, .Player(0).Y, False
            WarpUserChar UserIndex, 1, .Player(1).x, .Player(1).Y, False
            WritePauseToggle tIndex
            WritePauseToggle UserIndex
            UserList(.Player(0).UserIndex).UserReto.Arena = nArena
            UserList(.Player(1).UserIndex).UserReto.Arena = nArena
            UserList(.Player(0).UserIndex).UserReto.EnReto = True
            UserList(.Player(1).UserIndex).UserReto.EnReto = True
            UserList(.Player(0).UserIndex).UserReto.MandoReto.tIndex = 0
            UserList(.Player(1).UserIndex).UserReto.MandoReto.tIndex = 0
            UserList(.Player(0).UserIndex).Stats.GLD = UserList(.Player(0).UserIndex).Stats.GLD - .Oro
            UserList(.Player(1).UserIndex).Stats.GLD = UserList(.Player(1).UserIndex).Stats.GLD - .Oro
            WriteUpdateGold .Player(0).UserIndex
            WriteUpdateGold .Player(1).UserIndex
        End With
    End If
    
End Sub

Public Sub MuereReto(ByVal UserIndex As Integer)
    Dim iRet As Byte
    With UserList(UserIndex).UserReto
        If .Arena <= 0 Then Exit Sub
        If .Arena > 6 Then Exit Sub
        Dim sdata As String
        If .Plantes = False Then
            With Arena(.Arena)
                RevivirUsuario UserIndex
                With UserList(UserIndex)
                    .Stats.MinHp = .Stats.MaxHp
                    .Stats.MinMAN = .Stats.MaxMAN
                    .Stats.MinSta = .Stats.MaxSta
                    Call WriteUpdateUserStats(UserIndex)
                End With
                If UserIndex = .Player(0).UserIndex Then iRet = 1 Else iRet = 0
                
                If .Player(iRet).Rondas = 1 Then
                    Call TerminarReto(.Player(iRet).UserIndex, UserIndex)
                Else
                    .CuentaRegresiva = 10
                    WarpUserChar .Player(0).UserIndex, Mapa_Retos, .Player(0).x, .Player(0).Y, False
                    WarpUserChar .Player(1).UserIndex, Mapa_Retos, .Player(1).x, .Player(1).Y, False
                    WritePauseToggle .Player(0).UserIndex
                    WritePauseToggle .Player(1).UserIndex
                    .Player(iRet).Rondas = 1
                    sdata = PrepareMessageConsoleMsg("Resultado Parcial:" & vbCrLf & UserList(.Player(0).UserIndex).Name & ": " & .Player(0).Rondas & vbCrLf & UserList(.Player(1).UserIndex).Name & ": " & .Player(1).Rondas, FontTypeNames.FONTTYPE_GUILD)
                    Call SendData(SendTarget.ToReto, UserList(UserIndex).UserReto.Arena, sdata)
                    
                End If
            End With
        Else
            With ArenaPlantes(.Arena)
                RevivirUsuario UserIndex
                With UserList(UserIndex)
                    .Stats.MinHp = .Stats.MaxHp
                    .Stats.MinMAN = .Stats.MaxMAN
                    .Stats.MinSta = .Stats.MaxSta
                    Call WriteUpdateUserStats(UserIndex)
                End With
                If UserIndex = .Player(0).UserIndex Then iRet = 1 Else iRet = 0
                
                If .Player(iRet).Rondas = 1 Then
                    Call TerminarReto(.Player(iRet).UserIndex, UserIndex)
                Else
                    .CuentaRegresiva = 10
                    WarpUserChar .Player(0).UserIndex, Mapa_Retos_Plantes, .Player(0).x, .Player(0).Y, False
                    WarpUserChar .Player(1).UserIndex, Mapa_Retos_Plantes, .Player(1).x, .Player(1).Y, False
                    WritePauseToggle .Player(0).UserIndex
                    WritePauseToggle .Player(1).UserIndex
                    .Player(iRet).Rondas = 1
                    sdata = PrepareMessageConsoleMsg("Resultado Parcial:" & vbCrLf & UserList(.Player(0).UserIndex).Name & ": " & .Player(0).Rondas & vbCrLf & UserList(.Player(1).UserIndex).Name & ": " & .Player(1).Rondas, FontTypeNames.FONTTYPE_GUILD)
                    Call SendData(SendTarget.ToRetoPlantes, UserList(UserIndex).UserReto.Arena, sdata)
                End If
            End With
        End If
    End With
End Sub

Public Sub TerminarReto(ByVal Winner As Integer, ByVal Perdedor As Integer)
    Dim nArena As Byte
    Dim dChar As String
    
    nArena = UserList(Winner).UserReto.Arena
    If nArena <= 0 Or nArena > 6 Then Exit Sub
    If Winner <= 0 Then Exit Sub
    If Perdedor <= 0 Then Exit Sub
    Dim x As Byte, Y As Byte, cUser As Byte
    Dim sdata As String
    If UserList(Winner).UserReto.Plantes = False Then
        With Arena(nArena)
            If .Items = False Then
                WarpUserChar Winner, UserList(Winner).UserReto.lastPos.map, UserList(Winner).UserReto.lastPos.x, UserList(Winner).UserReto.lastPos.Y, True, True
                WarpUserChar Perdedor, UserList(Perdedor).UserReto.lastPos.map, UserList(Perdedor).UserReto.lastPos.x, UserList(Perdedor).UserReto.lastPos.Y, True, True
            Else
                WarpUserChar Perdedor, Mapa_Retos_Items, .Player(0).x + 6, .Player(0).Y + 3, False, , True
                TirarTodosLosItems Perdedor
                WarpUserChar Perdedor, UserList(Perdedor).UserReto.lastPos.map, UserList(Perdedor).UserReto.lastPos.x, UserList(Perdedor).UserReto.lastPos.Y, True, True
                DoEvents
                WarpUserChar Winner, Mapa_Retos_Items, .Player(0).x + 6, .Player(0).Y + 3, True, , True
            End If
            sdata = PrepareMessageConsoleMsg("Reto> " & UserList(Winner).Name & " Vs " & UserList(Perdedor).Name & ". Ganador " & UserList(Winner).Name & ". Apuesta por " & .Oro & " monedas de oro" & IIf(.Items, " y los items del inventario.", "."), FontTypeNames.FONTTYPE_INFO)
            Call SendData(SendTarget.ToAll, 0, sdata)
            UserList(Winner).Stats.GLD = UserList(Winner).Stats.GLD + (.Oro * 1.5)
            WriteUpdateGold Winner
            .ocupada = False
            .Player(0).UserIndex = 0
            .Player(1).UserIndex = 0
            .Player(0).Rondas = 0
            .Player(1).Rondas = 0
             With UserList(Winner)
                .UserReto.Arena = 0
                .UserReto.EnReto = False
                .EnEvento = False
                .UserReto.Escudos_Cascos = False
                .UserReto.MandoReto.AIM = False
             End With
             With UserList(Perdedor)
                .UserReto.Arena = 0
                .UserReto.EnReto = False
                .EnEvento = False
                .UserReto.Escudos_Cascos = False
                .UserReto.MandoReto.AIM = False
             End With
             If UserList(Winner).UserReto.MandoReto.Personaje = True Or UserList(Perdedor).UserReto.MandoReto.Personaje = True Then
                Call WriteConsoleMsg(Winner, "¡Has ganado el personaje " & UserList(Perdedor).Name & ", los datos del personaje ahora son los mismos que el tuyo. ", FontTypeNames.FONTTYPE_GUILD)
                dChar = CharPath & UCase$(UserList(Perdedor).Name) & ".chr"
                UserList(Perdedor).UserReto.MandoReto.Personaje = False
                UserList(Winner).UserReto.MandoReto.Personaje = False
                Call CloseSocket(Perdedor)
                Call WriteVar(dChar, "INIT", "Password", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "INIT", "Password"))
                Call WriteVar(dChar, "INIT", "Pin", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "INIT", "Pin"))
                Call WriteVar(dChar, "CONTACTO", "Email", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "CONTACTO", "Email"))
             End If
        End With
    Else
        With ArenaPlantes(nArena)
            If .Items = False Then
                WarpUserChar Winner, UserList(Winner).UserReto.lastPos.map, UserList(Winner).UserReto.lastPos.x, UserList(Winner).UserReto.lastPos.Y, True, True
                WarpUserChar Perdedor, UserList(Perdedor).UserReto.lastPos.map, UserList(Perdedor).UserReto.lastPos.x, UserList(Perdedor).UserReto.lastPos.Y, True, True
            Else
                WarpUserChar Perdedor, Mapa_Retos_Items, .Player(0).x + 6, .Player(0).Y + 3, False, , True
                TirarTodosLosItems Perdedor
                WarpUserChar Perdedor, UserList(Perdedor).UserReto.lastPos.map, UserList(Perdedor).UserReto.lastPos.x, UserList(Perdedor).UserReto.lastPos.Y, True, True
                DoEvents
                WarpUserChar Winner, Mapa_Retos_Items, .Player(0).x + 6, .Player(0).Y + 3, True, , True
            End If
        
            sdata = PrepareMessageConsoleMsg("Reto> " & UserList(Winner).Name & " Vs " & UserList(Perdedor).Name & ". Ganador " & UserList(Winner).Name & ". Apuesta por " & .Oro & " monedas de oro" & IIf(.Items, " y los items del inventario.", "."), FontTypeNames.FONTTYPE_INFO)
            Call SendData(SendTarget.ToAll, 0, sdata)
            UserList(Winner).Stats.GLD = UserList(Winner).Stats.GLD + (.Oro * 1.5)
            WriteUpdateGold Winner
            .ocupada = False
            .Player(0).UserIndex = 0
            .Player(1).UserIndex = 0
            .Player(0).Rondas = 0
            .Player(1).Rondas = 0
             With UserList(Winner)
                .UserReto.Arena = 0
                .UserReto.EnReto = False
                .EnEvento = False
                .UserReto.Plantes = False
                .UserReto.Escudos_Cascos = False
                .UserReto.MandoReto.AIM = False
             End With
             With UserList(Perdedor)
                .UserReto.Arena = 0
                .UserReto.EnReto = False
                .EnEvento = False
                .UserReto.Plantes = False
                .UserReto.Escudos_Cascos = False
                .UserReto.MandoReto.AIM = False
             End With
             If UserList(Winner).UserReto.MandoReto.Personaje = True Or UserList(Perdedor).UserReto.MandoReto.Personaje = True Then
                Call WriteConsoleMsg(Winner, "¡Has ganado el personaje " & UserList(Perdedor).Name & ", los datos del personaje ahora son los mismos que el tuyo. ", FontTypeNames.FONTTYPE_GUILD)
                dChar = CharPath & UCase$(UserList(Perdedor).Name) & ".chr"
                UserList(Perdedor).UserReto.MandoReto.Personaje = False
                UserList(Winner).UserReto.MandoReto.Personaje = False
                Call CloseSocket(Perdedor)
                Call WriteVar(dChar, "INIT", "Password", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "INIT", "Password"))
                Call WriteVar(dChar, "INIT", "Pin", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "INIT", "Pin"))
                Call WriteVar(dChar, "CONTACTO", "Email", GetVar(CharPath & UCase$(UserList(Winner).Name) & ".chr", "CONTACTO", "Email"))
             End If
        End With
    End If
End Sub

Public Sub PasaSegundo()
    Dim x As Long
    For x = 1 To 6
        With Arena(x)
            If .CuentaRegresiva = 0 Then
                .CuentaRegresiva = -1
                If .Player(0).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(0).UserIndex, "Reto> ¡Ya!", FontTypeNames.FONTTYPE_TALK
                    WritePauseToggle .Player(0).UserIndex
                End If
                If .Player(1).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(1).UserIndex, "Reto> ¡Ya!", FontTypeNames.FONTTYPE_TALK
                    WritePauseToggle .Player(1).UserIndex
                End If
            End If
            If .CuentaRegresiva >= 1 Then
                If .Player(0).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(0).UserIndex, "Reto> " & .CuentaRegresiva, FontTypeNames.FONTTYPE_TALK
                End If
                If .Player(1).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(1).UserIndex, "Reto> " & .CuentaRegresiva, FontTypeNames.FONTTYPE_TALK
                End If
                .CuentaRegresiva = .CuentaRegresiva - 1
            End If
        End With
    Next x
    For x = 1 To 4
        With ArenaPlantes(x)
            If .CuentaRegresiva = 0 Then
                .CuentaRegresiva = -1
                If .Player(0).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(0).UserIndex, "Reto> ¡Ya!", FontTypeNames.FONTTYPE_TALK
                    WritePauseToggle .Player(0).UserIndex
                End If
                If .Player(1).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(1).UserIndex, "Reto> ¡Ya!", FontTypeNames.FONTTYPE_TALK
                    WritePauseToggle .Player(1).UserIndex
                End If
            End If
            If .CuentaRegresiva >= 1 Then
                If .Player(0).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(0).UserIndex, "Reto> " & .CuentaRegresiva, FontTypeNames.FONTTYPE_TALK
                End If
                If .Player(1).UserIndex <> 0 Then
                    WriteConsoleMsg .Player(1).UserIndex, "Reto> " & .CuentaRegresiva, FontTypeNames.FONTTYPE_TALK
                End If
                .CuentaRegresiva = .CuentaRegresiva - 1
            End If
        End With
    Next x
End Sub

Public Function isCity(ByVal mapa As Integer) As Boolean
    Dim x As Long
    For x = 1 To NUMCIUDADES
        If mapa = Ciudades(x).map Then
            isCity = True
            Exit Function
        End If
    Next x
    isCity = False
End Function
Private Function PuedeReto(ByVal UserIndex As Integer, ByVal Oro As Long, tIndex As Integer, _
                           Optional Pociones As Integer) As Boolean
    PuedeReto = False
    
    If UserIndex = tIndex Then
        WriteConsoleMsg UserIndex, "No puedes retarte a vos mismo", FontTypeNames.FONTTYPE_INFO
        Exit Function
    End If
    
    If Oro < 5000 Then
        WriteConsoleMsg UserIndex, "La cantidad minima a retar es de 5.000 monedas de oro", FontTypeNames.FONTTYPE_INFO
        Exit Function
    End If
    
    If Pociones > 0 Then
        If Potion_Red(UserIndex) > Pociones Then
            WriteConsoleMsg UserIndex, "Tenés mas de " & Pociones & " pociones.", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If Potion_Red(tIndex) > Pociones Then
            WriteConsoleMsg UserIndex, "Tiene mas de " & Pociones & " pociones.", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
    End If
    
    With UserList(UserIndex)
        If .EnEvento = True Then '' <> 0 Then
            WriteConsoleMsg UserIndex, "Estás en otro evento", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If MapInfo(.Pos.map).Pk = True Then
            WriteConsoleMsg UserIndex, "Estás en una zona insegura", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .flags.Muerto <> 0 Then
            WriteConsoleMsg UserIndex, "Estás muerto", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If (.Counters.Pena <> 0) Then
            WriteConsoleMsg UserIndex, "Estás en la cárcel", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .Stats.GLD < Oro Then
            WriteConsoleMsg UserIndex, "No tenés suficiente oro", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
    End With
    
    With UserList(tIndex)
        If .EnEvento = True Then '' <> 0 Then
            WriteConsoleMsg UserIndex, "Está en otro evento", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If MapInfo(.Pos.map).Pk = True Then
            WriteConsoleMsg UserIndex, "Está en una zona insegura", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If (.Counters.Pena <> 0) Then
            WriteConsoleMsg UserIndex, "Está en la cárcel", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .flags.Muerto <> 0 Then
            WriteConsoleMsg UserIndex, "Está muerto", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
        
        If .Stats.GLD < Oro Then
            WriteConsoleMsg UserIndex, "No tiene suficiente oro", FontTypeNames.FONTTYPE_INFO
            Exit Function
        End If
    End With
    PuedeReto = True
End Function

Private Function NuevaArena(ByVal Plantes As Boolean) As Byte
    Dim x As Long
    If Plantes = False Then
        For x = 1 To 6
            If Arena(x).ocupada = False Then
                NuevaArena = x
                Exit Function
            End If
        Next x
    Else
        For x = 1 To 4
            If ArenaPlantes(x).ocupada = False Then
                NuevaArena = x
                Exit Function
            End If
        Next x
    End If
    NuevaArena = 0
End Function

Private Function Potion_Red(ByVal ID As Integer) As Long
 
    '@@ Función que devuelve las pociones rojas del usuario.
 
    Dim LoopC As Long
    Dim Total As Long
 
    With UserList(ID)
 
        For LoopC = 1 To .CurrentInventorySlots
            If .Invent.Object(LoopC).ObjIndex = 38 Then
                Total = Total + .Invent.Object(LoopC).Amount
            End If
        Next LoopC
 
        Potion_Red = Total
 
    End With
 
End Function
