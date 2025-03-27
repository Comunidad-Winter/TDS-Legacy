Attribute VB_Name = "mod_Retos3vs3"
Option Explicit
 
'*********************************
'                                *
'@@ Retos 3vs3.                  *
'@@ Autor: G Toyz - Luciano      *
'@@ Fecha: 06/10                 *
'@@ Creación: 23:17              *
'                                *
'*********************************
 
Private Const MAX_ARENAS        As Byte = 3
Private Const INDEX_POTION_RED  As Integer = 1
Private Const MAX_GOLD          As Long = 20000000
Private Const MIN_GOLD          As Integer = 20000
Private Const MIN_LEVEL         As Byte = 40
Private Const MAP_ITEMS_RETO    As Integer = 1
Private Const INDEX_BANKER      As Byte = 24

Private Type uRetos 'Usuarios
    ID              As Integer
    Pos             As WorldPos
    x               As Byte
    Y               As Byte
    DeathX          As Byte
    DeathY          As Byte
End Type
 
Private Type tRetos 'Teams
    Rounds          As Byte
    Users(1 To 3)   As uRetos
    Deaths          As Byte
End Type
 
Private Type Retos  'Retos
    Teams(1 To 2)   As tRetos
    MAP_Arena       As Byte
    Count           As Integer
    Occupied        As Boolean
    Gold            As Long
    Items           As Boolean
    X_Items         As Byte
    Y_Items         As Byte
    Time            As Integer
End Type

Private Retos(1 To MAX_ARENAS) As Retos
'_

Private Sub Start_Arenas(ByVal N_Arena As Integer, _
                         ByVal MAP_Arena As Byte, _
                         ByVal Team1_X As Byte, _
                         ByVal Team1_Y As Byte, _
                         ByVal Team2_X As Byte, _
                         ByVal Team2_Y As Byte, _
                         ByVal Team1_Death_X As Byte, _
                         ByVal Team1_Death_Y As Byte, _
                         ByVal Team2_Death_X As Byte, _
                         ByVal Team2_Death_Y As Byte)
 
    '@@ Cargar las X y Y de cada usuario en cada arena
    '@@ El cálculo es para posicionar uno abajo del otro o viceversa.
    '@@ Death es para guardar la posición en la que va quedar si es _
        que muere dentro del reto. Más que nada es para que no quede _
        ahí en el medio del agite.
   
    Dim LoopC As Long
 
    With Retos(N_Arena)
        For LoopC = 1 To 3
            .Teams(1).Users(LoopC).x = Team1_X
            .Teams(1).Users(LoopC).Y = Team1_Y - 1 + LoopC
            .Teams(1).Users(LoopC).DeathX = Team1_Death_X
            .Teams(1).Users(LoopC).DeathY = Team1_Death_Y + 1 - LoopC
            .Teams(2).Users(LoopC).x = Team2_X
            .Teams(2).Users(LoopC).Y = Team2_Y + 1 - LoopC
            .Teams(2).Users(LoopC).DeathX = Team2_Death_X
            .Teams(2).Users(LoopC).DeathY = Team2_Death_Y - 2 + LoopC
        Next LoopC
        
        .MAP_Arena = MAP_Arena
        
        '@@ Cálculos para sacar el medio de la arena.
        .X_Items = Team1_Death_X + 5
        .Y_Items = Team1_Death_Y - 5
    End With
   
End Sub
'
''
Public Sub Load_Arenas()
 
    '@@ Pongan sus mapas y coordenadas.
    '@@ Llamadas: Main.
   
    Call Start_Arenas(1, 176, 13, 18, 27, 28, 13, 18, 27, 28)
    'Call Start_Arenas(2, 1, 50, 50, 60, 60, 52, 52, 62, 62)
    'Call Start_Arenas(3, 1, 50, 50, 60, 60, 52, 52, 62, 50)
    
    '1, 13, 18, 27, 28
    
    '@@ Agregan las que quieran.
    '@@ Si agregan más, cambien la constante.
    
End Sub


Public Sub Send_Reto(ByRef players() As Integer, _
                ByVal Gold As Long, _
                ByVal Items As Boolean, _
                ByVal Potions_Red As Integer)
    
    '@@ Método para enviar retos.
    
    Dim LoopC As Long
    ''ReDim Preserve UserList(Players(1)).Retos3vs3.Players(1 To 6) As Integer
    If Not Can_Reto(players(), Gold, Potions_Red, True) Then Exit Sub
        
    Dim x As Long
    For x = 1 To 6
    UserList(players(1)).Retos3vs3.players(x) = 0
    Next x
    With UserList(players(1)).Retos3vs3
        ''ReDim .Players(1 To 6) As Integer
        .Gold = Gold
        .Items = Items
        .players(1) = players(1)
        .Accepts = 1
        .ID_Send = 1
        .ID_User_Send = players(1)
        
    End With
 
    For LoopC = 2 To UBound(players())
    
        Call WriteConsoleMsg(players(LoopC), UserList(players(1)).Name & _
 _
                                            " te ha invitado a participar en un reto 3vs3. [" _
                                            & UserList(players(1)).Name _
                                            & ", " & UserList(players(2)).Name _
                                            & ", " & UserList(players(3)).Name _
                                            & "] vs [" & UserList(players(4)).Name _
                                            & ", " & UserList(players(5)).Name _
                                            & ", " & UserList(players(6)).Name _
                                            & "] por " & Gold & " monedas de oro " _
                                            & IIf(Items = True, " y los items del inventario.", ".") _
                                            & "MÁXIMO POCIONES ROJAS: " & Potions_Red _
                                            & ". Para aceptar el reto escriba /SIRETO " _
                                            & UserList(players(1)).Name, _
                                            FontTypeNames.FONTTYPE_INFOBOLD)
                                           
        UserList(players(1)).Retos3vs3.players(LoopC) = players(LoopC)
        UserList(players(LoopC)).Retos3vs3.ID_Send = LoopC
        UserList(players(LoopC)).Retos3vs3.ID_User_Send = players(1)
        
    Next LoopC
   
        Call WriteConsoleMsg(players(1), "Solicitud enviada correctamente", FontTypeNames.FONTTYPE_INFOBOLD)
   
End Sub
 
Public Sub Accept_Reto(ByVal Player_ID As Integer, ByVal Send_ID As Integer)
   
   '@@ Método para aceptar retos.
   
    Dim Arena As Byte
    Dim LoopC As Long
    Dim loopX As Long
    
    If Send_ID > 0 Then
         If UserList(Send_ID).Retos3vs3.players(UserList(Player_ID).Retos3vs3.ID_Send) <> Player_ID Then
             Call WriteConsoleMsg(Player_ID, "El usuario " & UserList(Send_ID).Name & " no te ha invitado a ningún reto.", FontTypeNames.FONTTYPE_INFOBOLD)
             Exit Sub
         End If
    Else
        Call WriteConsoleMsg(Player_ID, "El usuario no se encuentra online.", FontTypeNames.FONTTYPE_INFOBOLD)
        Exit Sub
    End If
     
    With UserList(Send_ID).Retos3vs3
        
        If Can_Reto(.players(), .Gold, .Potions, False, Player_ID) = False Then Exit Sub
        
        .Accepts = .Accepts + 1
        .Time = .Time + 5
        UserList(Player_ID).Retos3vs3.accept = True
        
        Call WriteConsoleMsg(Player_ID, "Aceptaste el reto correctamente, esperá a que los demás también lo hagan.", FontTypeNames.FONTTYPE_INFOBOLD)
        Call WriteConsoleMsg(Send_ID, UserList(Player_ID).Name & " aceptó el reto.", FontTypeNames.FONTTYPE_INFOBOLD)
        
        If .Accepts = 6 Then
            
            Arena = There_Arena()
            
            If Arena = 0 Then
                Call WriteConsoleMsg(Send_ID, "No hay arenas", FontTypeNames.FONTTYPE_INFOBOLD)
                Call Cancel_Send(Send_ID, , False)
                Exit Sub
            End If
           
            If Can_Reto(.players(), .Gold, .Potions) = False Then
                Call Cancel_Send(.players(1), False)
                Exit Sub
            End If
           
            .accept = False
            .ID_Send = 0
           
            With Retos(Arena)
           
                .Count = 10
                .Gold = UserList(Send_ID).Retos3vs3.Gold
                .Items = UserList(Send_ID).Retos3vs3.Items
                .Occupied = True
               
                .Teams(1).Users(1).ID = UserList(Send_ID).Retos3vs3.players(1)
                .Teams(1).Users(2).ID = UserList(Send_ID).Retos3vs3.players(2)
                .Teams(1).Users(3).ID = UserList(Send_ID).Retos3vs3.players(3)
               
                .Teams(2).Users(1).ID = UserList(Send_ID).Retos3vs3.players(4)
                .Teams(2).Users(2).ID = UserList(Send_ID).Retos3vs3.players(5)
                .Teams(2).Users(3).ID = UserList(Send_ID).Retos3vs3.players(6)
               
                For LoopC = 1 To 2
                    For loopX = 1 To 3
                        .Teams(LoopC).Users(loopX).Pos = UserList(.Teams(LoopC).Users(loopX).ID).Pos
                        WarpUserChar .Teams(LoopC).Users(loopX).ID, .MAP_Arena, .Teams(LoopC).Users(loopX).x, .Teams(LoopC).Users(loopX).Y, False
                        WritePauseToggle .Teams(LoopC).Users(loopX).ID
                        UserList(.Teams(LoopC).Users(loopX).ID).Stats.GLD = UserList(.Teams(LoopC).Users(loopX).ID).Stats.GLD - .Gold
                        WriteUpdateGold (.Teams(LoopC).Users(loopX).ID)
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.ID_Send = 0
                        Assign_Remove_Flags (.Teams(LoopC).Users(loopX).ID)
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.ID_Team = LoopC
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.ID_User = loopX
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.Arena = Arena
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.accept = False
                        UserList(.Teams(LoopC).Users(loopX).ID).Retos3vs3.ID_User_Send = 0
                    Next loopX
                Next LoopC
               
            End With
                         
            Call Reset_Sender(Send_ID)
            
        End If
        
    End With
   
End Sub
Private Sub Assign_Remove_Flags(ByVal ID As Integer)

    '@@ Método para actualizar la vida, mana, sacarle el paralizado, revivir al usuario, etc.

    Call RevivirUsuario(ID)

    With UserList(ID).flags
        .Paralizado = 0
        .Envenenado = 0
        .Escondido = 0
        .invisible = 0
        .Inmovilizado = 0
    End With
    
    With UserList(ID).Stats
        .MinMAN = .MaxMAN
        .MinSta = .MaxSta
    End With

    Call WriteUpdateUserStats(ID)
    Call WriteUpdateEnvenenado(ID)
    
End Sub

Public Sub Cancel_Send(ByVal Send_ID As Integer, Optional ByVal Cancel_ID As Integer, Optional ByVal Cancel_Arenas As Boolean)

    '@@ Método para cancelar el envío de reto.

    Dim LoopC As Long

    If Cancel_ID > 0 Then
        If UserList(Send_ID).Retos3vs3.players(UserList(Cancel_ID).Retos3vs3.ID_Send) <> Cancel_ID Then
            Call WriteConsoleMsg(Cancel_ID, "El usuario " & UserList(Send_ID).Name & " no te ha invitado a ningún reto.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Sub
        End If
    End If
    
    For LoopC = 1 To 6
    
        UserList(UserList(Send_ID).Retos3vs3.players(LoopC)).Retos3vs3.ID_Send = 0
        UserList(UserList(Send_ID).Retos3vs3.players(LoopC)).Retos3vs3.ID_User_Send = 0
        UserList(UserList(Send_ID).Retos3vs3.players(LoopC)).Retos3vs3.accept = False
        
        If Cancel_ID > 0 Then
            WriteConsoleMsg UserList(Send_ID).Retos3vs3.players(LoopC), UserList(Cancel_ID).Name & " Rechazó el reto.", FontTypeNames.FONTTYPE_INFOBOLD
            GoTo 1
        End If
        
        If Cancel_Arenas = True Then _
            WriteConsoleMsg UserList(Send_ID).Retos3vs3.players(LoopC), "El reto se autocanceló por falta de arenas.", FontTypeNames.FONTTYPE_INFOBOLD
    
1    Next LoopC
    
    If Cancel_ID > 0 Then _
        WriteConsoleMsg Cancel_ID, "Rechazaste el reto, ya puedes buscar otro.", FontTypeNames.FONTTYPE_INFOBOLD
    
    Reset_Sender Send_ID

End Sub
Private Sub Reset_Sender(ByVal ID As Integer)
    
    '@@ Método para resetear las variables del que envía el reto.
    
    Dim LoopC As Long

    With UserList(ID).Retos3vs3
        .Accepts = 0
        .Gold = 0
        .Items = False
        
        For LoopC = 1 To 6
            .players(LoopC) = 0
        Next LoopC
        
        .Potions = 0
    End With
    
End Sub

Private Function There_Arena() As Byte
 
    '@@ Función que devuelve una arena libre.
 
    Dim LoopC As Long
   
    For LoopC = 1 To MAX_ARENAS
        If Retos(LoopC).Occupied = False Then
            There_Arena = LoopC
            Exit Function
        End If
    Next LoopC
    
    There_Arena = 0
 
End Function
 
Private Function Can_Reto(ByRef players() As Integer, ByVal Gold As Long, ByVal Potions_Red As Integer, Optional ByVal Sender As Boolean, Optional ByVal ID As Integer) As Boolean
    
    '@@ Función para comprobar si puede retar.
    
    '@@ Comprobaciones.
    
    '@@ Agregan si es que piensan que falta una o _
        si simplemente quieren agregar otras restricciones.
    
    Dim LoopC As Long
    Dim LoopZ As Long
    
    Can_Reto = False
        
    With UserList(players(1))
    
        For LoopZ = 2 To 6
            If players(1) = players(LoopZ) Then
                Call WriteConsoleMsg(players(1), "No puedes enviarte una solicitud a vos mismo.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
        Next LoopZ
        
        If .Retos3vs3.players(1) = players(1) And Sender = True Then
            Call WriteConsoleMsg(players(1), "Ya has enviado una solicitud.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If .Retos3vs3.ID_Send > 0 And Sender = True Then
            Call WriteConsoleMsg(players(1), "Estás respondiendo a una solicitud.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If .Stats.GLD < Gold Then
            Call WriteConsoleMsg(players(1), "No tienes suficiente oro.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
    
        If Not Potions_Red = 0 Then
            If Potion_Red(players(1)) > Potions_Red Then
                Call WriteConsoleMsg(players(1), "Tienes demasiadas pociones.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
        End If
        
        If Gold < MIN_GOLD Then
            Call WriteConsoleMsg(players(1), "La cantidad mínima para retar es de " & MIN_GOLD & " monedas de oro.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If Gold > MAX_GOLD Then
            Call WriteConsoleMsg(players(1), "La cantidad máxima para retar es de " & MAX_GOLD & " monedas de oro.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If Not Is_City(.Pos.map) Then
            Call WriteConsoleMsg(players(1), "Para mandar un reto debes estar en una ciudad.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If .Retos3vs3.Arena > 0 Then
            Call WriteConsoleMsg(players(1), "Ya estás en un reto!", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
        If .Stats.ELV < MIN_LEVEL Then
            Call WriteConsoleMsg(players(1), "No tienes suficiente nivel como para retar.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
        
    End With
    
    For LoopC = 2 To 6
    
        If ID > 0 Then _
            LoopC = UserList(ID).Retos3vs3.ID_Send
        
        If players(LoopC) = 0 Then
            Call WriteConsoleMsg(players(1), "Uno de los usuarios no se encuentra online.", FontTypeNames.FONTTYPE_INFOBOLD)
            Exit Function
        End If
    
        With UserList(players(LoopC))
            
            If .flags.Muerto = 1 Then
                Call WriteConsoleMsg(players(1), "El usuario " & .Name & " está muerto", FontTypeNames.FONTTYPE_INFOBOLD)
                If Not Sender Then _
                    Call WriteConsoleMsg(players(LoopC), "¡Estás muerto!", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
            
            If .Retos3vs3.accept = True Then
                Call WriteConsoleMsg(players(LoopC), "Ya aceptaste el reto.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
         
            If Not Potions_Red = 0 Then
                If Potion_Red(players(LoopC)) > Potions_Red Then
                    Call WriteConsoleMsg(players(1), "El usuario " & .Name & " tiene demasiadas pociones.", FontTypeNames.FONTTYPE_INFOBOLD)
                    If Not Sender Then _
                        Call WriteConsoleMsg(players(LoopC), "Tienes demasiadas pociones", FontTypeNames.FONTTYPE_INFOBOLD)
                    Exit Function
                End If
            End If
            
            If .Stats.GLD < Gold Then
                Call WriteConsoleMsg(players(1), "El usuario " & .Name & " no tiene suficiente oro para retar.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Not Sender Then _
                    Call WriteConsoleMsg(players(LoopC), "No tienes suficiente oro.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
            
            If Not Is_City(.Pos.map) Then
                Call WriteConsoleMsg(players(1), "El usuario " & .Name & " no esta en una ciudad.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Not Sender Then _
                    Call WriteConsoleMsg(players(LoopC), "Debes estar en una ciudad.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
    
            If .Stats.ELV < MIN_LEVEL Then
                Call WriteConsoleMsg(players(1), "El usuario " & .Name & " no tiene un nivel adecuado.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Not Sender Then _
                    Call WriteConsoleMsg(players(LoopC), "Tienes que ser nivel mayor a 40 para poder retar.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
            
            If .Retos3vs3.Arena > 0 Then
                Call WriteConsoleMsg(players(1), "El usuario " & .Name & " está en un reto.", FontTypeNames.FONTTYPE_INFOBOLD)
                If Not Sender Then _
                    Call WriteConsoleMsg(players(LoopC), "Para aceptar un reto no debes estar en uno.", FontTypeNames.FONTTYPE_INFOBOLD)
                Exit Function
            End If
        
        End With
        
        If ID > 0 Then _
            Exit For
        
    Next LoopC
        
        Can_Reto = True
    
End Function

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
Public Sub Count_Reto()

    '@@ Método para contar los tiempos del envío del reto y de cada arena para que _
        empiece la batalla.

    Dim LoopC As Long
    Dim loopX As Long
    Dim LoopZ As Long
    Dim LoopV As Long

    For LoopC = 1 To MAX_ARENAS
        With Retos(LoopC)
        
            If .Time = -1 Then
                Call Clean_Teams(LoopC)
                For LoopV = 1 To 3
                    Call WarpUserChar(.Teams(1).Users(LoopV).ID, .Teams(1).Users(LoopV).Pos.map, .Teams(1).Users(LoopV).Pos.x, .Teams(1).Users(LoopV).Pos.Y, True)
                    Call Reset_All(.Teams(1).Users(LoopV).ID)
                    Call Reset_All(.Teams(2).Users(LoopV).ID)
                    Call Assign_Remove_Flags(.Teams(1).Users(LoopV).ID)
                    Call Assign_Remove_Flags(.Teams(2).Users(LoopV).ID)
                Next LoopV
                Call QuitarNPC(INDEX_BANKER)
            End If
            
            If .Time > 0 Then
                .Time = .Time - 1
            End If
        
            If .Count = 0 Then
                .Count = -1
                
                For loopX = 1 To 3
                    If .Teams(1).Users(loopX).ID > 0 Then
                        Call WriteConsoleMsg(.Teams(1).Users(loopX).ID, "Reto> Ya!", FontTypeNames.FONTTYPE_FIGHT)
                        Call WritePauseToggle(.Teams(1).Users(loopX).ID)
                    End If
                    
                    If .Teams(2).Users(loopX).ID > 0 Then
                        Call WriteConsoleMsg(.Teams(2).Users(loopX).ID, "Reto> Ya!", FontTypeNames.FONTTYPE_FIGHT)
                        Call WritePauseToggle(.Teams(2).Users(loopX).ID)
                    End If
                Next loopX

            End If
            
            If .Count >= 1 Then
                For LoopZ = 1 To 3
                    If .Teams(1).Users(LoopZ).ID > 0 Then _
                        Call WriteConsoleMsg(.Teams(1).Users(LoopZ).ID, "Reto> " & .Count, FontTypeNames.FONTTYPE_INFOBOLD)
                    If .Teams(2).Users(LoopZ).ID > 0 Then _
                        Call WriteConsoleMsg(.Teams(2).Users(LoopZ).ID, "Reto> " & .Count, FontTypeNames.FONTTYPE_INFOBOLD)
                Next LoopZ
                .Count = .Count - 1
            End If
            
        End With
    Next LoopC

End Sub

Public Sub Death(ByVal ID As Integer)

    'Método para saber quién muere y si ya murieron todos que gane un round el equipo ganador.

    Dim LoopC As Long
    Dim Team_Win As Byte
    
    If UserList(ID).Retos3vs3.Arena = 0 Then Exit Sub
    
    With Retos(UserList(ID).Retos3vs3.Arena)
    
        If UserList(ID).Retos3vs3.ID_Team = 1 Then
            Team_Win = 2
        Else
            Team_Win = 1
        End If
        
        .Teams(UserList(ID).Retos3vs3.ID_Team).Deaths = .Teams(UserList(ID).Retos3vs3.ID_Team).Deaths + 1
        
        Call WarpUserChar(ID, .MAP_Arena, .Teams(UserList(ID).Retos3vs3.ID_Team).Users(UserList(ID).Retos3vs3.ID_User).DeathX, .Teams(UserList(ID).Retos3vs3.ID_Team).Users(UserList(ID).Retos3vs3.ID_User).DeathY, False)
    
        If .Teams(UserList(ID).Retos3vs3.ID_Team).Deaths = 3 Then _
            Call Round_Reto(Team_Win, UserList(ID).Retos3vs3.Arena)
            
    End With

End Sub

Public Sub Round_Reto(ByVal ID_Team As Byte, ByVal Arena As Byte)

    '@@ Método que contabiliza los rounds ganados, los lleva a las _
        esquinas y verifica si ganó o no el reto.

    Dim LoopC As Long
    Dim Team_Loser As Byte
    
    If ID_Team = 1 Then
        Team_Loser = 2
    Else
        Team_Loser = 1
    End If
    
    With Retos(Arena)
        
        .Teams(ID_Team).Rounds = .Teams(ID_Team).Rounds + 1
        
        If .Teams(ID_Team).Rounds = 2 Then _
            Call Finish(ID_Team, Team_Loser, Arena)
        
        .Count = 10
        
        For LoopC = 1 To 3
            Call Assign_Remove_Flags(.Teams(1).Users(LoopC).ID)
            Call Assign_Remove_Flags(.Teams(2).Users(LoopC).ID)
            Call WarpUserChar(.Teams(1).Users(LoopC).ID, .MAP_Arena, .Teams(1).Users(LoopC).x, .Teams(1).Users(LoopC).Y, False)
            Call WarpUserChar(.Teams(2).Users(LoopC).ID, .MAP_Arena, .Teams(2).Users(LoopC).x, .Teams(2).Users(LoopC).Y, False)
            Call WritePauseToggle(.Teams(1).Users(LoopC).ID)
            Call WritePauseToggle(.Teams(2).Users(LoopC).ID)
            .Teams(1).Deaths = 0
            .Teams(2).Deaths = 0
        Next LoopC

    End With

End Sub

Public Sub Reset_All(ByVal ID As Integer)

    '@@ Método para resetear todos los flags de reto del usuario.

    Dim LoopC As Long

    With UserList(ID).Retos3vs3
        .Accepts = 0
        .Arena = 0
        .Gold = 0
        .ID_Send = 0
        .ID_Team = 0
        .ID_User = 0
        .Items = False
        
        For LoopC = 1 To 6
            .players(LoopC) = 0
        Next LoopC
        
        .Potions = 0
        .Time = 0
    End With

End Sub

Public Sub Finish(ByVal ID_Winner As Byte, ByVal ID_Loser As Byte, ByVal Arena As Byte, Optional Cancel As Boolean)

    '@@ Método para finalizar el reto.

    Dim LoopC As Long

    With Retos(Arena)
    
        For LoopC = 1 To 3
            UserList(.Teams(ID_Winner).Users(LoopC).ID).Stats.GLD = UserList(.Teams(ID_Winner).Users(LoopC).ID).Stats.GLD + (.Gold * 2)
            Call WriteConsoleMsg(.Teams(ID_Winner).Users(LoopC).ID, "Has ganado el reto, felicidades!", FontTypeNames.FONTTYPE_INFOBOLD)
            Call WriteConsoleMsg(.Teams(ID_Loser).Users(LoopC).ID, "Has perdido el reto, siga practicando!", FontTypeNames.FONTTYPE_INFOBOLD)
            Call Assign_Remove_Flags(.Teams(1).Users(LoopC).ID)
            Call Assign_Remove_Flags(.Teams(2).Users(LoopC).ID)
            Call WriteUpdateGold(.Teams(ID_Winner).Users(LoopC).ID)
            If Cancel = False Then
                Call WritePauseToggle(.Teams(ID_Winner).Users(LoopC).ID)
                Call WritePauseToggle(.Teams(ID_Loser).Users(LoopC).ID)
            End If
            If .Items = False Then
                Call WarpUserChar(.Teams(1).Users(LoopC).ID, .Teams(1).Users(LoopC).Pos.map, .Teams(1).Users(LoopC).Pos.x, .Teams(1).Users(LoopC).Pos.Y, True)
                Call WarpUserChar(.Teams(2).Users(LoopC).ID, .Teams(2).Users(LoopC).Pos.map, .Teams(2).Users(LoopC).Pos.x, .Teams(2).Users(LoopC).Pos.Y, True)
                Call Reset_All(.Teams(1).Users(LoopC).ID)
                Call Reset_All(.Teams(2).Users(LoopC).ID)
            Else
                Call WarpUserChar(.Teams(1).Users(LoopC).ID, .MAP_Arena, .X_Items, .Y_Items, False)
                Call WarpUserChar(.Teams(2).Users(LoopC).ID, .MAP_Arena, .X_Items, .Y_Items, False)
                Call WarpUserChar(.Teams(ID_Loser).Users(LoopC).ID, .Teams(ID_Loser).Users(LoopC).Pos.map, .Teams(ID_Loser).Users(LoopC).Pos.x, .Teams(ID_Loser).Users(LoopC).Pos.Y, True)
                Call TirarTodosLosItems(.Teams(ID_Loser).Users(LoopC).ID)
                Call WriteConsoleMsg(.Teams(ID_Winner).Users(LoopC).ID, "Tienen " & .Time & " segundos para recojer los ítems.", FontTypeNames.FONTTYPE_INFOBOLD)
                Call Assign_Remove_Flags(.Teams(ID_Winner).Users(LoopC).ID)
                ''Call SpawnNpc(INDEX_BANKER, Pos, False, False) TOYZERROR
            End If
        Next LoopC
        
        If .Items = False Then _
            Call Clean_Teams(Arena)
        
    End With

End Sub


Public Sub Clean_Teams(ByVal Arena As Byte)
    
    '@@ Método que limpia las arenas y los teams.
    
    Dim LoopC As Long
    
    With Retos(Arena)
        .Count = 0
        .Gold = 0
        .Items = 0
        .Occupied = False
        For LoopC = 1 To 3
            .Teams(1).Users(LoopC).ID = 0
            .Teams(2).Users(LoopC).ID = 0
        Next LoopC
        .Teams(1).Rounds = 0: .Teams(2).Rounds = 0
        .Teams(1).Deaths = 0: .Teams(2).Deaths = 0
    End With

End Sub

Public Sub Cancel_Reto(ByVal ID As Integer)

    '@@ Método para cuando un usuario se desconecta o abandona el reto.

    Dim Team_Win As Byte
    
    If UserList(ID).Retos3vs3.ID_Team = 1 Then Team_Win = 2
    If UserList(ID).Retos3vs3.ID_Team = 2 Then Team_Win = 1

    Call Finish(Team_Win, UserList(ID).Retos3vs3.ID_Team, UserList(ID).Retos3vs3.Arena)
    
End Sub
