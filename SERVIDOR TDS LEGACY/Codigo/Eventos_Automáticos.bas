Attribute VB_Name = "Eventos_Automaticos"
Option Explicit
 
'********************************
'                               *
'                               *
'@@ ROUND-ROBIN                 *
'@@ AUTOR: G Toyz - Luciano     *
'@@ FECHA: 10/10/2016           *
'@@ HORA: 02:04                 *
'                               *
'                               *
'********************************
 
Private Const MAX_ARENAS       As Byte = 9  'Máxima cantidad de arenas.
Private Const MAX_WAITROOM     As Byte = 18 'Máxima cantidad de salas de espera.
Private Const MAX_SEND         As Byte = 50 'Máximo de personas que pueden enviar solicitud al evento.
Private Const INDEX_POTION_RED As Byte = 1  'Número de la poción roja.
Private Const MIN_LEVEL        As Byte = 1  'Nivel mínimo para entrar al evento.
 
 
Private Type tUsers 'Usuarios
    ID              As Integer  'ID del usuario.
    Pos             As WorldPos 'Posiciones del usuario.
End Type
 
Private Type Teams  'Equipos
    Users()         As tUsers  'Usuarios del equipo.
    Current_Deaths  As Integer 'Muertes actuales.
    Current_Rounds  As Byte    'Rondas actuales.
    Rounds_Earned   As Integer 'Rondas ganadas.
    Points_Earned   As Byte    'Puntos ganados.
    Rounds_Defeated As Integer 'Rondas perdidas.
    Deaths          As Byte    'Muertes.
    Killed          As Byte    'Matados.
    Arena           As Byte    'Arena en la que está.
    Wait_Room       As Byte    'Sala de espera en la que está.
    Played()        As Integer 'Contra quienes jugó.
    Played_Amount   As Byte    'Cantidad contra quienes jugó.
    Team_Arena      As Byte    'ID Del equipo contra quien está jugando.
    K€D             As Integer 'Promedio de Killed/Deaths
    Rounds          As Integer 'Promedio de Rounds.
End Type
 
Private Type pArenas
    X_Corner      As Byte    'Esquina
    Y_Corner      As Byte
    X_Death       As Byte    'Posiciones al morir.
    Y_Death       As Byte
End Type
 
Private Type eArenas
    Indexs(1 To 2)  As Byte
    Pos(1 To 2)     As pArenas
    Count           As Integer 'Conteo.
    Occupied        As Boolean '¿Arena ocupada?
End Type
 
Private Type eWaiting
    X_Wait          As Byte    'Coordenadas de la sala de espera.
    Y_Wait          As Byte
    Occupied        As Boolean '¿Sala de espera ocupada?
End Type
 
Private Type eEvent
    Arenas(1 To MAX_ARENAS)        As eArenas       ' Arenas.
    Waiting(1 To MAX_WAITROOM)     As eWaiting      ' Salas de espera.
    Teams()                        As Teams         ' Equipos.
    MAP_Arena                      As Byte          ' Mapa de las arenas.
    MAP_Waiting                    As Byte          ' Mapa de las Salas de espera.
    Active_Send                    As Boolean       ' ¿Activada la búsqueda de equipos?
    Event_Course                   As Boolean       ' ¿Evento en curso?
    Drop                           As Boolean       ' ¿Caen items?
    Teams_Event                    As Byte          ' Equipos en evento.
    Time_Cancel                    As Integer       ' Tiempo para el autocancelamiento.
    Rounds                         As Byte          ' Rondas de enfretamientos.
    message                        As String        ' Mensaje de evento: Ejemplo: 2vs2
    Sends(1 To MAX_SEND)           As Integer       ' Usuarios que mandaron al evento.
    Drop_Items                     As WorldPos      ' Lugar donde van a caer los items.
    Team_PointLeader               As Byte          ' El número de puntos más alto.
    Max_Potions                    As Integer       ' Máximo de pociones.
    Prize                          As Long          ' Premio.
    Inscription                    As Long          ' Inscripción.
    Team_Win                       As Byte          ' Equipo ganador.
    Best_K€D                       As Integer       ' Mejor número de rounds.
    Best_Rounds                    As Integer       ' Mejor número de muertes/matados.
    Time_Items                     As Integer       ' Tiempo que tienen para recoger los items.
End Type
 
Private Events(2 To 10) As eEvent ' Eventos
'_
 
Private Sub Load_Messages()
 
    '@@ AVISO: hacerlo vía .dat
 
    '@@ Cargamos los mensajes.
    '@@ Mensajes: 2vs2, 3vs3, etc
 
    Events(2).message = "2vs2"
    Events(3).message = "3vs3"
    Events(4).message = "4vs4"
    Events(5).message = "5vs5"
    Events(6).message = "6vs6"
    Events(7).message = "7vs7"
    Events(8).message = "8vs8"
    Events(9).message = "9vs9"
    Events(10).message = "10vs10"
 
End Sub
 
Private Sub Load_POS(ByVal nEvent As Byte, _
                       ByVal X_Items As Byte, _
                       ByVal Y_Items As Byte, _
                       ByVal MAP_Items As Byte, _
                       ByVal Map_Arenas As Byte, _
                       ByVal Map_RoomWait As Byte)
 
    '@@ Cargamos mapas, coordenadas de items.
 
    With Events(nEvent)
        .Drop_Items.map = MAP_Items
        .Drop_Items.X = X_Items
        .Drop_Items.Y = Y_Items
        .MAP_Arena = Map_Arenas
        .MAP_Waiting = Map_RoomWait
    End With
 
End Sub
 
Private Sub Start_Arenas(ByVal nEvent As Byte, _
                         ByVal nArena As Byte, _
                         ByVal X_Arenas_Team1 As Byte, _
                         ByVal Y_Arenas_Team1 As Byte, _
                         ByVal X_Arenas_Team2 As Byte, _
                         ByVal Y_Arenas_Team2 As Byte, _
                         ByVal X_Death_Team1 As Byte, _
                         ByVal Y_Death_Team1 As Byte, _
                         ByVal X_Death_Team2 As Byte, _
                         ByVal Y_Death_Team2 As Byte)
 
    '@@ Cargamos las arenas.
    '@@ Hacerlo vía .dat
 
    With Events(nEvent).Arenas(nArena)
        .Pos(1).X_Corner = X_Arenas_Team1
        .Pos(1).Y_Corner = Y_Arenas_Team1
        .Pos(1).X_Death = X_Death_Team1
        .Pos(1).Y_Death = Y_Death_Team1
        .Pos(2).X_Corner = Y_Arenas_Team2
        .Pos(2).Y_Corner = Y_Arenas_Team2
        .Pos(2).X_Death = X_Death_Team2
        .Pos(2).Y_Death = Y_Death_Team2
    End With
 
End Sub
 
Private Sub Start_RoomWait(ByVal nEvent As Byte, _
                           ByVal nRoom As Byte, _
                           ByVal X As Byte, _
                           ByVal Y As Byte)
                     
    '@@ Cargamos las salas de espera.
         
    With Events(nEvent)
        .Waiting(nRoom).X_Wait = X
        .Waiting(nRoom).Y_Wait = Y
    End With
 
End Sub
 
Public Sub Load_Events()
 
    '@@ START_ARENAS NÚMMERO DE EVENTO, NÚMERO DE ARENA, COORDENADAS.
    '@@ START_ROOMWAIT NÚMERO DE EVENTO, NÚMERO DE SALA, COORDENADAS.
    '@@ LOAD_POS NÚMERO DE EVENTO, COORDENADAS DONDE VAN A CAER LOS ITEMS, MAPAS.
    '@@@@ AVISO!: _
          YO SÓLO CARGUÉ 3 ARENAS Y 3 SALAS. _
          HACERLO VÍA .DAT
   
    Call Load_Messages
    Call Load_POS(2, 49, 65, 2, 3, 2)
    Call Start_RoomWait(2, 1, 11, 13)
    Call Start_RoomWait(2, 2, 17, 13)
    Call Start_RoomWait(2, 3, 23, 13)
    Call Start_Arenas(2, 1, 11, 26, 27, 11, 30, 17, 30, 20)
    Call Start_Arenas(2, 2, 37, 26, 53, 11, 57, 17, 57, 20)
    Call Start_Arenas(2, 3, 65, 26, 82, 11, 86, 17, 86, 20)
 
End Sub
 
Public Sub Do_Event(ByVal ID As Integer, _
                    ByVal nEvent As Byte, _
                    ByVal Teams As Byte, _
                    ByVal Drop As Boolean, _
                    ByVal Inscription_Prize As Boolean, _
                    ByVal Max_Potions As Integer, _
                    ByVal Gold_Inscription As Integer, _
                    ByVal Gold_Prize As Integer)
 
    '@@ Método para armar el evento y ponerlo en curso.
 
    Dim LoopC As Long
    Dim loopX As Long
 
    If Can_DoEvent(nEvent, Teams, ID) = False Then Exit Sub
 
    With Events(nEvent)
 
        ReDim .Teams(1 To Teams)
 
        .Active_Send = True
        '.Inscription = Inscription
        .Drop = Drop
        '.Prize_Gold = Prize
        .Inscription = Gold_Inscription
        If Inscription_Prize = True Then
            .Prize = (Gold_Prize + (Gold_Inscription * (Teams * nEvent)) / 5)
        Else
            .Prize = Gold_Prize
        End If
 
        For LoopC = 1 To UBound(.Teams())
            ReDim .Teams(LoopC).Users(1 To nEvent)
            ReDim .Teams(LoopC).Played(1 To (UBound(.Teams()) - 1))
        Next LoopC
 
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.message & " Automático> Cupos: " & Teams & " equipos" & IIf(Drop = True, ", caen items.", vbNullString) & ", máxima cantidad de pociones: " & Max_Potions & ", inscripción: " & .Inscription & ". Para participar tipeá /PARTICIPAR", FontTypeNames.FONTTYPE_GUILD))
 
    End With
 
End Sub
 
Public Sub Send_Event(ByRef Players() As Integer, ByVal nEvent As Byte)
 
    '@@ Método para enviar solicitud a compareños para unirse al evento.
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim Names As String
    Dim Slot  As Byte
 
    If Can_EnterEventAll(Players(), nEvent, True) = False Then Exit Sub
 
    Slot = Slot_Send(nEvent)
 
    For loopX = 1 To nEvent
        If Names = "" Then
            Names = UserList(Players(loopX)).name
        Else
            Names = Names & "," & UserList(Players(loopX)).name
        End If
    Next loopX
 
    With UserList(Players(1)).Events
        .accept = True
        .Accepts = 1
        'UserList(Players(1)).flags.ID_Event = nEvent
        Events(nEvent).Sends(Slot) = Players(1)
        .ID_ArraySend = Slot
        ReDim .Players(1 To nEvent) As Integer
        For LoopC = 1 To nEvent
            .Players(LoopC) = Players(LoopC)
            Call WriteConsoleMsg(Players(LoopC), "El usuario " & UserList(Players(1)).name & " los ha invitado a jugar el evento automático " & Events(nEvent).message & "EQUIPO: [" & Names & "]", FontTypeNames.FONTTYPE_INFOBOLD)
        Next LoopC
    End With
End Sub
 
Private Function Slot_Send(ByVal nEvent As Byte) As Byte
 
    '@@ Función que busca una posición libre en el array de Send().
 
    Dim LoopC As Long
 
    Slot_Send = 0
 
    With Events(nEvent)
        For LoopC = 1 To UBound(.Sends())
            If .Sends(LoopC) = 0 Then
                Slot_Send = LoopC
                Exit For
            End If
        Next LoopC
    End With
 
End Function
 
Public Sub Accept_Send(ByVal ID As Integer, ByVal ID_Send As Integer, ByVal nEvent As Byte)
 
    '@@ Método para aceptar una solicitud.
 
  ' If ID_Send <> UserList(ID).Events.ID_Send Then Exit Sub
 
    Dim LoopC As Long
    Dim NoYes As Boolean
 
    NoYes = False
 
    For LoopC = 1 To nEvent
        If ID = UserList(ID_Send).Events.Players(LoopC) Then Exit For
    Next LoopC
 
    If Not LoopC = nEvent Then
        Call WriteConsoleMsg(ID, "El usuario " & UserList(ID_Send).name & " no te ha enviado ninguna invitación.", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Sub
    End If
 
    If ID = ID_Send Then
        Call WriteConsoleMsg(ID, "Ya has aceptado la solicitud", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Sub
    End If
 
    If Can_EnterEventAll(UserList(ID_Send).Events.Players(), nEvent) = False Then Exit Sub
 
    UserList(ID).Events.accept = True
 
    Call WriteConsoleMsg(ID, "Has aceptado, espera a que los demás también lo hagan", FontTypeNames.FONTTYPE_INFOBOLD)
 
    With UserList(ID_Send).Events
        .Accepts = .Accepts + 1
 
        If .Accepts = nEvent Then
            Call Enter_Event(.Players(), nEvent)
            Call Clean_Send(ID_Send, nEvent)
        End If
    End With
 
End Sub
 
Private Sub Enter_Event(ByRef Players() As Integer, ByVal nEvent As Byte)
 
    '@@ Método para entrar al evento.
 
    If Can_EnterEventAll(Players(), nEvent) = False Then Exit Sub
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim Wait_Room As Byte
 
    Wait_Room = There_RoomWait(nEvent)
 
 
    With Events(nEvent)
        .Teams_Event = .Teams_Event + 1
        For LoopC = 1 To nEvent
            WriteConsoleMsg Players(LoopC), "Tú y tu equipo han ingresado al evento! éxitos en batalla!", FontTypeNames.FONTTYPE_INFOBOLD
            .Teams(.Teams_Event).Users(LoopC).ID = Players(LoopC)
            .Teams(.Teams_Event).Users(LoopC).Pos = UserList(Players(LoopC)).Pos
            WarpUserChar .Teams(.Teams_Event).Users(LoopC).ID, .MAP_Waiting, .Waiting(Wait_Room).X_Wait, .Waiting(Wait_Room).Y_Wait - LoopC, False
            UserList(.Teams(.Teams_Event).Users(LoopC).ID).Events.ID_Enter = LoopC
            UserList(.Teams(.Teams_Event).Users(LoopC).ID).Events.ID_Team = .Teams_Event
            UserList(.Teams(.Teams_Event).Users(LoopC).ID).flags.ID_Event = nEvent
     
            If .Inscription > 0 Then
                UserList(.Teams(.Teams_Event).Users(LoopC).ID).Stats.GLD = UserList(.Teams(.Teams_Event).Users(LoopC).ID).Stats.GLD - .Inscription
                WriteUpdateGold (.Teams(.Teams_Event).Users(LoopC).ID)
            End If
        Next LoopC
        .Teams(.Teams_Event).Wait_Room = Wait_Room
 
        If .Teams_Event = UBound(.Teams()) Then _
            Call Start_Event(nEvent)
 
    End With
 
End Sub
 
Private Function Can_EnterEventAll(ByRef Players() As Integer, ByVal nEvent As Byte, Optional ByVal Send As Boolean) As Boolean
 
    '@@ Función que chequea a los usuarios para ver si pueden entrar o no al evento.
 
    '@@ Faltan algunas condicionales como:
 
    '**************************[Aportadas por MAB]**************************
    'Si esta en cárcel
    'Si es una posición inválida
    'Si esta en bóveda
    'Si esta comerciando
    '**************************[Aportadas por MAB]**************************
 
    Can_EnterEventAll = False
 
    '@@ Condicionales
    Dim LoopC As Long
 
    With Events(nEvent)
        For LoopC = 1 To nEvent
 
            If Players(LoopC) = 0 Then
                Call WriteConsoleMsg(Players(1), "Uno de los usuarios no se encuentra online", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
            If Events(nEvent).Active_Send = False Then
                Call WriteConsoleMsg(Players(1), "El evento no busca concursantes.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
            If UserList(Players(LoopC)).flags.ID_Event > 0 Then
                Call WriteConsoleMsg(Players(1), "Uno de los usuarios ya se encuentra en un evento", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
 
            If Is_City(UserList(Players(LoopC)).Pos.map) = False Then
                Call WriteConsoleMsg(Players(1), "Uno de los usuarios no se encuentra en zona segura.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Send = False Then _
                    Call WriteConsoleMsg(Players(LoopC), "Estás en zona insegura, ve a zona segura para poder aceptar la invitación", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
 
            If UserList(Players(LoopC)).flags.Muerto = 1 Then
                Call WriteConsoleMsg(Players(1), "El usuario " & UserList(Players(LoopC)).name & " está muerto.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Send = False Then _
                    Call WriteConsoleMsg(Players(LoopC), "Estás muerto", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
            If Potion_Red(Players(LoopC)) > .Max_Potions Then
                Call WriteConsoleMsg(Players(1), "El usuario " & UserList(Players(LoopC)).name & " tiene demasiadas pociones.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Send = False Then _
                    Call WriteConsoleMsg(Players(LoopC), "Tienes demasiadas pociones", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
            If UserList(Players(LoopC)).Stats.GLD < .Inscription Then
                Call WriteConsoleMsg(Players(1), "El usuario " & UserList(Players(LoopC)).name & " tiene demasiadas pociones.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Send = False Then _
                    Call WriteConsoleMsg(Players(LoopC), "Tienes demasiadas pociones", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
            If UserList(Players(LoopC)).Stats.ELV < MIN_LEVEL Then
                Call WriteConsoleMsg(Players(1), "El usuario " & UserList(Players(LoopC)).name & " no tiene suficiente nivel para ingresar al evento.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Send = False Then _
                    Call WriteConsoleMsg(Players(LoopC), "No tienes suficiente nivel para entrar al evento", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
     
        Next LoopC
    End With
 
    Can_EnterEventAll = True
 
End Function
 
Private Function Can_DoEvent(ByVal nEvent As Byte, _
                             ByVal Teams As Byte, _
                             ByVal ID As Integer) As Boolean
 
    '@@ Función que chequea si se puede hacer un evento en tales condiciones.
 
 
    Can_DoEvent = False
 
    '@@ Condicionales
 
    If EsGM(ID) = False Then
        Call WriteConsoleMsg(ID, "No tienes acceso para realizar esta acción.", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Function
    End If
 
    If Events(nEvent).Active_Send = True Or Events(nEvent).Event_Course = True Then
        Call WriteConsoleMsg(ID, "El evento se está desarrollando", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Function
    End If
 
    If nEvent < 2 Or nEvent > 10 Then
        Call WriteConsoleMsg(ID, "Tipo de evento no encontrado.", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Function
    End If
    If Teams < 2 Or Teams > MAX_WAITROOM Then
        Call WriteConsoleMsg(ID, "El máximo de equipos para el evento son de " & MAX_WAITROOM & ".", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Function
    End If
 
    Can_DoEvent = True
 
 
End Function
 
Public Sub Cancel_User(ByVal ID As Integer, ByVal nEvent As Byte)
 
    '@@ Para cuando se desconecta un usuario, ya sea cuando entra al evento o cuando están en las arenas.
 
    With Events(UserList(ID).flags.ID_Event)
        Call WarpUserChar(ID, .Teams(UserList(ID).Events.ID_Team).Users(UserList(ID).Events.ID_Enter).Pos.map, _
        .Teams(UserList(ID).Events.ID_Team).Users(UserList(ID).Events.ID_Enter).Pos.X, _
        .Teams(UserList(ID).Events.ID_Team).Users(UserList(ID).Events.ID_Enter).Pos.Y, False)
        .Teams(UserList(ID).Events.ID_Team).Users(UserList(ID).Events.ID_Enter).ID = 0
    End With
 
    With UserList(ID).Events
        .ID_Enter = 0
        UserList(ID).flags.ID_Event = 0
        .ID_Team = 0
    End With
 
End Sub
 
Private Sub Clean_Send(ByVal ID As Integer, ByVal nEvent As Byte)
 
    Dim LoopC As Long
 
    With UserList(ID).Events
        Events(UserList(ID).flags.ID_Event).Sends(.ID_ArraySend) = 0
        .accept = False
        .Accepts = 0
        .ID_ArraySend = 0
        .ID_Send = 0
        For LoopC = 1 To UserList(ID).flags.ID_Event
            With UserList(UserList(ID).Events.Players(LoopC)).Events
                .accept = False
                .ID_Send = 0
            End With
            .Players(LoopC) = 0
        Next LoopC
    End With
 
End Sub
 
Private Sub Cancel_Enter_All(ByVal ID_Event As Byte)
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim LoopZ As Long
    Dim X     As Long
 
    With Events(ID_Event)
        For X = 1 To UBound(.Sends())
            Call Clean_Send(.Sends(X), ID_Event)
        Next X
 
        .Active_Send = False
        .Drop = False
        '.Inscription = 0
        '.Prize_Gold = 0
        .Inscription = 0
        .Prize = 0
        .Time_Cancel = 0
        .Teams_Event = 0
        For LoopC = 1 To UBound(.Teams())
            .Waiting(LoopC).Occupied = False
            For LoopZ = 1 To UBound(.Teams()) * ID_Event
                Call WarpUserChar(.Teams(LoopC).Users(LoopZ).ID, .Teams(LoopC).Users(LoopZ).Pos.map, .Teams(LoopC).Users(LoopZ).Pos.X, .Teams(LoopC).Users(LoopZ).Pos.Y, False)
                Call Cancel_User(.Teams(LoopC).Users(LoopZ).ID, ID_Event)
            Next LoopZ
        Next LoopC
 
    End With
 
End Sub
 
Private Function There_RoomWait(ByVal nEvent As Byte) As Byte
 
    Dim LoopC As Long
 
    There_RoomWait = 0
 
    With Events(nEvent)
        For LoopC = 1 To MAX_WAITROOM
            If .Waiting(LoopC).Occupied = False Then
                There_RoomWait = LoopC
                Exit Function
            End If
        Next LoopC
    End With
 
End Function
 
Private Sub Start_Event(ByVal nEvent As Byte)
 
    '@@ Inciamos el evento.
 
    Dim LoopC As Long
    Dim Team  As Byte
 
    Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(Events(nEvent).message & "> Cupo completado.", FontTypeNames.FONTTYPE_SERVER))
 
    For LoopC = 1 To UBound(Events(nEvent).Teams())
        Team = Not_Played(LoopC, nEvent)
        If Team > 0 Then
            Events(nEvent).Event_Course = True
            Events(nEvent).Active_Send = False
            Call Math(LoopC, Team, nEvent)
        End If
    Next LoopC
 
End Sub
 
Private Sub Math(ByVal ID_Team As Byte, ByVal Team As Byte, ByVal nEvent As Byte)
 
    '@@ Emparejamos equipos.
 
    Dim Arena As Byte
    Dim LoopC As Long
 
    With Events(nEvent)
            If .Teams(ID_Team).Arena = 0 Then
                If Team > 0 Then
                    Arena = Slot_Arena(nEvent)
                    If Arena > 0 Then
                        .Waiting(.Teams(ID_Team).Wait_Room).Occupied = False
                        .Waiting(.Teams(Team).Wait_Room).Occupied = False
             
                        With .Teams(ID_Team)
                            .Arena = Arena
                            .Played_Amount = .Played_Amount + 1
                            .Played(.Played_Amount) = Team
                            .Wait_Room = 0
                            .Team_Arena = Team
                        End With
                 
                        With .Teams(Team)
                            .Arena = Arena
                            .Played_Amount = .Played_Amount + 1
                            .Played(.Played_Amount) = ID_Team
                            .Wait_Room = 0
                            .Team_Arena = ID_Team
                        End With
                 
                        With .Arenas(Arena)
                            .Count = 30
                            .Occupied = True
                            .Indexs(1) = ID_Team
                            .Indexs(2) = Team
                        End With
                 
                        For LoopC = 1 To nEvent
                            Call WarpUserChar(.Teams(ID_Team).Users(LoopC).ID, .MAP_Arena, .Arenas(Arena).Pos(1).X_Corner, .Arenas(Arena).Pos(1).Y_Corner, False)
                            Call WarpUserChar(.Teams(Team).Users(LoopC).ID, .MAP_Arena, .Arenas(Arena).Pos(2).X_Corner, .Arenas(Arena).Pos(2).Y_Corner, False)
                            UserList(.Teams(ID_Team).Users(LoopC).ID).Events.ID_Team_Arena = ID_Team
                            UserList(.Teams(Team).Users(LoopC).ID).Events.ID_Team_Arena = Team
                        Next LoopC
                 
                    End If
                Else
                    Finish_Event nEvent
                End If
            End If
    End With
 
End Sub
 
Private Sub Finish_Event(ByVal nEvent As Byte)
 
    '@@ Finalizamos el evento.
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim LoopZ As Long
    Dim LoopJ As Long
    Dim Max_Loop As Byte
    Dim Replaced As Byte
 
    With Events(nEvent)
        Max_Loop = UBound(.Teams())
         
        For LoopC = 1 To Max_Loop
            If .Teams(LoopC).Points_Earned = .Team_PointLeader Then
                .Teams(LoopC).Rounds = .Teams(LoopC).Rounds_Earned - .Teams(LoopC).Rounds_Defeated
                .Teams(LoopC).K€D = .Teams(LoopC).Killed - .Teams(LoopC).Deaths
                If .Teams(LoopC).Rounds > .Best_Rounds Then
                    .Best_Rounds = .Teams(LoopC).Rounds
                    .Best_K€D = .Teams(LoopC).K€D
                    Replaced = .Team_Win
                    .Team_Win = LoopC
                ElseIf .Teams(LoopC).Rounds = .Best_Rounds Then
                    If .Teams(LoopC).K€D > .Best_K€D Then
                        .Best_K€D = .Teams(LoopC).K€D
                        Replaced = .Team_Win
                        .Team_Win = LoopC
                    ElseIf .Teams(LoopC).K€D = .Best_K€D Then
                        .Team_Win = 0
                    End If
                End If
            End If
 
            For loopX = 1 To nEvent
                If LoopC <> .Team_Win Then
                    If .Drop = True Then
                        Call WarpUserChar(.Teams(LoopC).Users(loopX).ID, .Drop_Items.map, .Drop_Items.X, .Drop_Items.Y, False)
                        Call TirarTodosLosItems(.Teams(LoopC).Users(loopX).ID)
                    End If
                    Call WarpUserChar(.Teams(LoopC).Users(loopX).ID, .Teams(LoopC).Users(loopX).Pos.map, .Teams(LoopC).Users(loopX).Pos.X, .Teams(LoopC).Users(loopX).Pos.Y, False)
                    If Replaced > 0 Then
                        Call WarpUserChar(.Teams(Replaced).Users(loopX).ID, .Teams(Replaced).Users(loopX).Pos.map, .Teams(Replaced).Users(loopX).Pos.X, .Teams(Replaced).Users(loopX).Pos.Y, False)
                    End If
                Else
                    Call WarpUserChar(.Teams(LoopC).Users(loopX).ID, .Drop_Items.map, .Drop_Items.X, .Drop_Items.Y + 30, False)
                End If
            Next loopX
     
            If LoopC <> .Team_Win Then _
                Call Assign_Remove_Flags(.Teams(LoopC).Users())
     
        Next LoopC
 
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(Events(nEvent).message & "> Evento finalizado.", FontTypeNames.FONTTYPE_SERVER))
 
        For LoopZ = 1 To nEvent
            If .Teams(.Team_Win).Users(LoopZ).ID > 0 Then
                UserList(.Teams(.Team_Win).Users(LoopZ).ID).Stats.GLD = UserList(.Teams(.Team_Win).Users(LoopZ).ID).Stats.GLD + .Prize
                Call WriteUpdateGold(.Teams(.Team_Win).Users(LoopZ).ID)
                Call WarpUserChar(.Teams(.Team_Win).Users(LoopZ).ID, .Drop_Items.map, .Drop_Items.X, .Drop_Items.Y, False)
            End If
        Next LoopZ
 
 
        .Time_Items = 12 '0
        'Call Clean_Event(nEvent)
    End With
 
End Sub
 
Public Sub Clean_Event(ByVal nEvent As Byte)
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim LoopZ As Long
 
    With Events(nEvent)
        .Best_K€D = 0
        .Best_Rounds = 0
        .Drop = False
        .Event_Course = False
        .Inscription = 0
        .Max_Potions = 0
        .Rounds = 0
        .Team_PointLeader = 0
        .Team_Win = 0
        .Teams_Event = 0
        For LoopC = 1 To UBound(.Teams())
            For loopX = 1 To nEvent
                .Teams(LoopC).Users(loopX).ID = 0
            Next loopX
        Next LoopC
    End With
 
End Sub
 
Public Sub Death(ByVal ID As Integer)
 
    With Events(UserList(ID).flags.ID_Event)
        .Teams(UserList(ID).Events.ID_Team).Deaths = .Teams(UserList(ID).Events.ID_Team).Deaths + 1
        .Teams(UserList(ID).Events.ID_Team).Current_Deaths = .Teams(UserList(ID).Events.ID_Team).Current_Deaths + 1
        .Teams(.Teams(UserList(ID).Events.ID_Team).Team_Arena).Killed = .Teams(.Teams(UserList(ID).Events.ID_Team).Team_Arena).Killed + 1
        WarpUserChar ID, .MAP_Arena, .Arenas(.Teams(UserList(ID).Events.ID_Team).Arena).Pos(UserList(ID).Events.ID_Team).X_Corner, .Arenas(.Teams(UserList(ID).Events.ID_Team).Arena).Pos(UserList(ID).Events.ID_Team).Y_Corner, False
         If .Teams(UserList(ID).Events.ID_Team).Current_Deaths = UserList(ID).flags.ID_Event Then _
            Round_Win .Teams(UserList(ID).Events.ID_Team).Team_Arena, UserList(ID).Events.ID_Team, UserList(ID).flags.ID_Event
    End With
 
End Sub
 
Private Sub Round_Win(ByVal Team_Winner As Byte, ByVal Team_Loser As Byte, ByVal nEvent As Byte)
 
    Dim LoopC As Long
 
    With Events(nEvent)
        .Teams(Team_Winner).Rounds_Earned = .Teams(Team_Winner).Rounds_Earned + 1
        .Teams(Team_Winner).Current_Rounds = .Teams(Team_Winner).Current_Rounds + 1
        .Teams(Team_Loser).Rounds_Defeated = .Teams(Team_Loser).Rounds_Defeated + 1
        .Teams(Team_Winner).Current_Deaths = 0
        .Teams(Team_Loser).Current_Deaths = 0
        Call Assign_Remove_Flags(.Teams(Team_Winner).Users())
        Call Assign_Remove_Flags(.Teams(Team_Loser).Users())
 
        If .Teams(Team_Winner).Rounds_Earned = 2 Then _
            Call Point_Win(Team_Winner, Team_Loser, nEvent)
 
        .Arenas(.Teams(Team_Winner).Arena).Count = 20
 
        For LoopC = 1 To nEvent
            Call WarpUserChar(.Teams(Team_Winner).Users(LoopC).ID, .MAP_Arena, .Arenas(.Teams(Team_Winner).Arena).Pos(Team_Winner).X_Corner, .Arenas(.Teams(Team_Winner).Arena).Pos(Team_Winner).Y_Corner, False)
            Call WarpUserChar(.Teams(Team_Loser).Users(LoopC).ID, .MAP_Arena, .Arenas(.Teams(Team_Loser).Arena).Pos(Team_Loser).X_Corner, .Arenas(.Teams(Team_Loser).Arena).Pos(Team_Loser).Y_Corner, False)
            Call WritePauseToggle(.Teams(Team_Winner).Users(LoopC).ID)
            Call WritePauseToggle(.Teams(Team_Loser).Users(LoopC).ID)
        Next LoopC
    End With
 
End Sub
 
Private Sub Point_Win(ByVal Team_Winner As Byte, ByVal Team_Loser As Byte, ByVal nEvent As Byte)
 
    Dim Room_Wait As Byte
    Dim NotPlayed As Byte
 
    With Events(nEvent)
 
        .Teams(Team_Winner).Points_Earned = .Teams(Team_Winner).Points_Earned + 1
 
        If .Teams(Team_Winner).Points_Earned > .Team_PointLeader Then _
            .Team_PointLeader = .Teams(Team_Winner).Points_Earned
 
        .Arenas(.Teams(Team_Winner).Arena).Occupied = False
        .Arenas(.Teams(Team_Winner).Arena).Count = 0
 
        NotPlayed = Not_Played(Team_Winner, nEvent)
 
        If NotPlayed = 0 Then
            Room_Wait = There_RoomWait(nEvent)
            .Teams(Team_Winner).Wait_Room = Room_Wait
            .Waiting(Room_Wait).Occupied = True
            .Teams(Team_Winner).Wait_Room = Room_Wait
        Else
            Math Team_Winner, NotPlayed, nEvent
        End If
 
        NotPlayed = Not_Played(Team_Loser, nEvent)
 
        If NotPlayed = 0 Then
            Room_Wait = There_RoomWait(nEvent)
            .Teams(Team_Loser).Wait_Room = Room_Wait
            .Waiting(Team_Loser).Occupied = True
            .Teams(Team_Loser).Wait_Room = Room_Wait
        Else
            Math Team_Winner, NotPlayed, nEvent
        End If
 
    End With
End Sub
 
Private Sub Assign_Remove_Flags(ByRef Users() As tUsers)
 
    '@@ Método para actualizar la vida, mana, sacarle el paralizado, revivir al usuario, etc.
 
    Dim LoopC As Long
 
    For LoopC = 1 To UBound(Users())
 
       Call RevivirUsuario(Users(LoopC).ID)
 
       With UserList(Users(LoopC).ID).flags
           .Paralizado = 0
           .Envenenado = 0
           .Escondido = 0
           .invisible = 0
           .Inmovilizado = 0
       End With
 
       With UserList(Users(LoopC).ID).Stats
           .MinMAN = .MaxMAN
           .MinSta = .MaxSta
       End With
 
       Call WriteUpdateUserStats(Users(LoopC).ID)
 
   Next LoopC
 
End Sub
 
Private Function Potion_Red(ByVal ID As Integer) As Long
 
    '@@ Función que devuelve las pociones rojas del usuario.
 
    Dim LoopC As Long
    Dim Total As Long
 
    With UserList(ID)
 
        For LoopC = 1 To .CurrentInventorySlots
            If .Invent.Object(LoopC).ObjIndex = INDEX_POTION_RED Then
                Total = Total + .Invent.Object(LoopC).Amount
            End If
        Next LoopC
 
        Potion_Red = Total
 
    End With
 
End Function
 
Private Function Is_City(ByVal map As Integer) As Boolean
 
    '@@ Función que devuelve si el mapa es una ciudad.
 
    Dim LoopC As Long
 
    For LoopC = 1 To NUMCIUDADES
        If map = Ciudades(LoopC).map Then
            Is_City = True
            Exit Function
        End If
    Next LoopC
 
    Is_City = False
 
End Function
Private Function Slot_Arena(ByVal nEvent As Byte) As Byte
 
    Slot_Arena = 0
 
    Dim LoopC As Long
 
    With Events(nEvent)
 
        For LoopC = 1 To MAX_ARENAS
            If .Arenas(LoopC).Occupied = False Then
                Slot_Arena = LoopC
                Exit For
            End If
        Next LoopC
 
    End With
 
End Function
 
Private Function Not_Played(ByVal ID_Team As Byte, ByVal nEvent As Byte) As Byte
 
    Dim LoopC As Long
    Dim loopX As Long
 
    Not_Played = 0
 
    With Events(nEvent)
        For LoopC = 1 To UBound(.Teams())
            For loopX = 1 To UBound(.Teams())
                If .Teams(ID_Team).Played(loopX) <> LoopC Then _
                    Exit For
            Next loopX
                If ID_Team <> LoopC Then
                    If .Teams(LoopC).Played_Amount <> UBound(.Teams()) Then
                        If .Teams(LoopC).Arena = 0 Then
                            Not_Played = LoopC
                            Exit For
                        End If
                    End If
                End If
        Next LoopC
    End With
 
End Function
 
Public Sub Count_Event()
 
    '@@ Timer de un segundo.
 
    Dim LoopC As Long
    Dim loopX As Long
    Dim LoopZ As Long
    Dim LoopJ As Long
    Dim LoopT As Long
 
    For LoopC = 2 To 10
        With Events(LoopC)
     
            '@@ Tiempo para que se vayan del mapa.
            If .Time_Items = -1 Then
                .Time_Items = 0
                Clean_Event LoopC
                For LoopT = 1 To LoopC
                    Call WarpUserChar(.Teams(.Team_Win).Users(LoopT).ID, .Drop_Items.map, .Drop_Items.X, .Drop_Items.Y, False)
                Next LoopT
            End If
            If .Time_Items > -1 Then _
                .Time_Items = .Time_Items - 1
     
            '@@ Autocancelamiento.
            If .Time_Cancel = -1 Then
                .Time_Cancel = 0
                Cancel_Enter_All LoopC
            End If
            If .Time_Cancel > -1 Then _
                .Time_Cancel = .Time_Cancel - 1
     
            '@@ Esto es para todo lo que es dentro de las arenas.
            For loopX = 1 To MAX_ARENAS
                With .Arenas(loopX)
                    If .Count = -1 Then
                        .Count = 0
                        For LoopZ = 1 To LoopC
                            Call WriteConsoleMsg(Events(LoopC).Teams(.Indexs(1)).Users(LoopZ).ID, Events(LoopC).message & "> Ya!", FontTypeNames.FONTTYPE_FIGHT)
                            Call WriteConsoleMsg(Events(LoopC).Teams(.Indexs(2)).Users(LoopZ).ID, Events(LoopC).message & "> Ya!", FontTypeNames.FONTTYPE_FIGHT)
                        Next LoopZ
                    End If
                    If .Count > -1 Then
                        .Count = .Count - 1
                         For LoopJ = 1 To LoopC
                            Call WriteConsoleMsg(Events(LoopC).Teams(.Indexs(1)).Users(LoopJ).ID, Events(LoopC).message & "> " & .Count, FontTypeNames.FONTTYPE_FIGHT)
                            Call WriteConsoleMsg(Events(LoopC).Teams(.Indexs(2)).Users(LoopJ).ID, Events(LoopC).message & "> " & .Count, FontTypeNames.FONTTYPE_FIGHT)
                         Next LoopJ
                    End If
                End With
            Next loopX
        End With
    Next LoopC
 
End Sub

