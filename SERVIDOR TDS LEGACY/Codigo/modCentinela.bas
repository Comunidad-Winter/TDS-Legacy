Attribute VB_Name = "modCentinela"
Option Explicit

Public CentinelaNPCIndex As Integer        'Índice del NPC en el servidor

Private Const TIEMPO_INICIAL As Byte = 3        'Tiempo inicial en minutos. No reducir sin antes revisar el timer que maneja estos datos.

Private Type tCentinela
    RevisandoUserIndex As Integer        '¿Qué índice revisamos?
    TiempoRestante As Integer        '¿Cuántos minutos le quedan al usuario?
    clave As String        'Clave que debe escribir
    Frase As String
    spawnTime As Long
End Type

Public centinelaActivado As Boolean

Public Centinela As tCentinela

Private Palabras() As String
Private NumPalabras As Integer


Public Sub LoadDictionary()

    Dim rutaArchivo As String

    rutaArchivo = App.path & "/palabras.txt"

    Erase Palabras()
    NumPalabras = 0

    Dim archivo As Integer
    Dim Linea As String

    archivo = FreeFile
    Open rutaArchivo For Input As archivo
    Do While Not EOF(archivo)
        Line Input #archivo, Linea
        If Trim(Linea) <> "" Then
            NumPalabras = NumPalabras + 1
        End If
    Loop
    Close archivo

    ' Redimensionar el array
    ReDim Palabras(1 To NumPalabras)

    ' Volver a abrir el archivo y guardar las palabras en el array
    NumPalabras = 1
    Open rutaArchivo For Input As archivo
    Do While Not EOF(archivo)
        Line Input #archivo, Linea
        If Trim(Linea) <> "" Then
            Palabras(NumPalabras) = Trim(Linea)
            NumPalabras = NumPalabras + 1
        End If
    Loop
    Close archivo



End Sub

Private Function ObtenerPalabraAleatoria() As String
    Randomize
    ObtenerPalabraAleatoria = Palabras(RandomNumber(1, NumPalabras))
End Function

Public Sub CallUserAttention()

    If (GetTickCount()) - Centinela.spawnTime >= 5000 Then
        If Centinela.RevisandoUserIndex <> 0 And centinelaActivado Then
            If Not UserList(Centinela.RevisandoUserIndex).flags.CentinelaOK Then
                Call WritePlayWave(Centinela.RevisandoUserIndex, SND_WARP, Npclist(CentinelaNPCIndex).Pos.X, Npclist(CentinelaNPCIndex).Pos.Y)
                Call WriteCreateFX(Centinela.RevisandoUserIndex, Npclist(CentinelaNPCIndex).Char.CharIndex, FXIDs.FXWARP, 0)

                'Resend the key
                Call CentinelaSendClave(Centinela.RevisandoUserIndex)

                'Call Flushbuffer(Centinela.RevisandoUserIndex)
            End If
        End If
    End If
End Sub

Private Function GenerarFrase() As String

    Dim Frases(1 To 25) As String

    Frases(1) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes un minuto más para responder. Debes escribir /CENTINELA y la clave es " & Centinela.clave & "."
    Frases(2) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes un minuto más para responder! La frase que dirás va a ser " & Centinela.clave & ", así que escribe /CENTINELA y el código recientemente dicho para continuar."
    Frases(3) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes 60 segundos para escribir /CENTINELA.. Tu clave entonces es " & Centinela.clave & " ¡Apresúrate!"
    Frases(4) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", tu desafío es escribir /CENTINELA " & Centinela.clave & " antes de que se acabe el tiempo."
    Frases(5) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la clave para continuar es " & Centinela.clave & ". Escribe /CENTINELA y el código!"
    Frases(6) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", no olvides que debes escribir /CENTINELA, seguido de " & Centinela.clave & ", para seguir adelante!"
    Frases(7) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", ¿puedes recordar la palabra clave? ¡Escribe /CENTINELA y quiero que digas " & Centinela.clave & "!"
    Frases(8) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", para avanzar, necesitas escribir /CENTINELA y la palabra clave que dirás será " & Centinela.clave & " antes de que sea tarde!"
    Frases(9) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tu próximo paso es escribir /CENTINELA con tu clave que es " & Centinela.clave & "!"
    Frases(10) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", ¿puedes adivinar la palabra clave? ¡Escribe /CENTINELA y la clave es " & Centinela.clave & " para que yo te deje en paz!"
    Frases(11) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", el desafío es escribir /CENTINELA y la palabra clave es, " & Centinela.clave & " en los próximos segundos!"
    Frases(12) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la palabra clave que buscas es " & Centinela.clave & ". Escribe /CENTINELA y la clave para continuar."
    Frases(13) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", demuéstrame que sabes la palabra clave! Escribe /CENTINELA y la clave es " & Centinela.clave & " ahora mismo."
    Frases(14) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", tu tarea es escribir /CENTINELA y la palabra clave es " & Centinela.clave & " antes de que se agote el tiempo."
    Frases(15) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la clave para seguir adelante es " & Centinela.clave & ". Escribe /CENTINELA y la clave es " & Centinela.clave & " para continuar tu trabajo."
    Frases(16) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la palabra secreta que necesitas es " & Centinela.clave & ". Escribe /CENTINELA y la clave es " & Centinela.clave & " ahora mismo."
    Frases(17) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", no te pierdas la oportunidad de avanzar! Escribe /CENTINELA y la palabra es " & Centinela.clave & " para continuar."
    Frases(18) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", ¿puedes adivinar cuál es la palabra clave? ¡Escribe /CENTINELA y la clave es " & Centinela.clave & " y me retiro!"
    Frases(19) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", necesito que escribas /CENTINELA y la palabra clave es " & Centinela.clave & " para avanzar. ¡Hazlo ahora!"
    Frases(20) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la palabra clave que necesitas es " & Centinela.clave & ". Escribe /CENTINELA y la clave es " & Centinela.clave & "."
    Frases(21) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", demuéstrame que estás listo! Usa el comando /CENTINELA, pero debes decir esto seguido de ese comando " & Centinela.clave & " para continuar."
    Frases(22) = "" & UserList(Centinela.RevisandoUserIndex).Name & ", tu objetivo es escribir /CENTINELA y la palabra es " & Centinela.clave & ". ¡Rápido, antes de que se agote el tiempo!"
    Frases(23) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la clave para el siguiente paso es " & Centinela.clave & ". Escribe /CENTINELA y la clave es " & Centinela.clave & "."
    Frases(24) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", recuerda que debes escribir /CENTINELA diciendo este code: " & Centinela.clave & "."
    Frases(25) = "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", la palabra secreta que necesitas es " & Centinela.clave & ". ¡No te olvides de escribirla con el comando /CENTINELA!"

    GenerarFrase = Frases(RandomNumber(1, 25))

End Function


Private Sub GoToNextWorkingChar()

    On Error GoTo Errhandler

    Dim LoopC As Long

1   For LoopC = 1 To LastUser
2       If UserList(LoopC).flags.UserLogged And UserList(LoopC).Counters.Trabajando > 0 And (UserList(LoopC).flags.Privilegios = PlayerType.User Or (Not UserList(LoopC).flags.Privilegios = PlayerType.User And UserList(LoopC).flags.AdminPerseguible = True)) Then
3           If Not UserList(LoopC).flags.CentinelaOK Then
                'Inicializamos
4               Centinela.RevisandoUserIndex = LoopC
5               Centinela.TiempoRestante = TIEMPO_INICIAL

6               If NumPalabras = 0 Then
7                   Centinela.clave = RandomNumber(1, 32000)
8               Else
9                   Centinela.clave = ObtenerPalabraAleatoria
                End If

10              Centinela.Frase = GenerarFrase

11              Centinela.spawnTime = GetTickCount()

12              UserList(LoopC).flags.CentinelaReaction = Centinela.spawnTime

13              UserList(LoopC).Counters.CooldownCentinela = RandomNumber(60 * 9, 60 * 25)  'De 1 a 5 minutos de libertad

                'Ponemos al centinela en posición
14              Call WarpCentinela(LoopC)

15              If CentinelaNPCIndex Then
                    'Call WriteChatOverHead(LoopC, "Saludos " & UserList(LoopC).Name & ", soy el Centinela de estas tierras. Me gustaría que escribas /CENTINELA " & Centinela.clave & " en no más de dos minutos.", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbGreen)
16                  Call WriteChatOverHead(LoopC, Centinela.Frase, CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbWhite)
17                  Call WriteMensajes(LoopC, Mensaje_426, FontTypeNames.FONTTYPE_CENTINELA)
                End If
                Exit Sub
            End If
        End If
    Next LoopC

    'No hay chars trabajando, eliminamos el NPC si todavía estaba en algún lado y esperamos otro minuto
18  If CentinelaNPCIndex Then
19      Call QuitarNPC(CentinelaNPCIndex)
20      CentinelaNPCIndex = 0
    End If

    'No estamos revisando a nadie
    Centinela.RevisandoUserIndex = 0
    Exit Sub
Errhandler:
    Call LogError("Error en GoTonextWok en " & Erl & ". err " & Err.Number & " " & Err.Description)
End Sub

Private Sub CentinelaFinalCheck()
'############################################################
'Al finalizar el tiempo, se retira y realiza la acción
'pertinente dependiendo del caso
'############################################################
    On Error GoTo Error_Handler
    Dim Name As String
    Dim Index As Integer
    If Not UserList(Centinela.RevisandoUserIndex).flags.CentinelaOK Then
        'Logueamos el evento
        Call LogCentinela("Centinela kickeó a " & UserList(Centinela.RevisandoUserIndex).Name & " por uso de macro inasistido.")

        Index = Centinela.RevisandoUserIndex
        If Index Then
            Call CloseSocket(Index)
        End If
        Centinela.RevisandoUserIndex = 0
        GoTo keep

        Name = UserList(Centinela.RevisandoUserIndex).Name

        'Avisamos a los admins
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> El centinela ha penalizado a " & Name, FontTypeNames.FONTTYPE_SERVER))

        With UserList(Centinela.RevisandoUserIndex)

            Call WriteConsoleMsg(Centinela.RevisandoUserIndex, "Has sido penado.", FontTypeNames.FONTTYPE_INFO)
            .Stats.CantPenas = .Stats.CantPenas + 1
            Call WarpUserCharX(Centinela.RevisandoUserIndex, Prision.map, Prision.X, Prision.Y, True)
            Dim pena_string As String

            Select Case .Stats.CantPenas
            Case 1 To 2
                pena_string = "MUERTE Y CARCEL x 30m POR MACRO INASISTIDO"
                Call SetPenalty(Name, pena_string, 30)
            Case 3 To 4
                pena_string = "MUERTE Y CARCEL x 60m POR MACRO INASISTIDO"
                Call SetPenalty(Name, pena_string, 60)
            Case 5 To 7
                pena_string = "MUERTE, CARCEL x 10m Y BAN x " & (.Stats.CantPenas - 4) * 15 & " días POR MACRO INASISTIDO"
                Call SetPenalty(Name, pena_string, 10, .Stats.CantPenas - 4)
            Case Else
                pena_string = "Ban permanente del personaje por acumulación de penas. Razón: MACRO INASISTIDO (GM: -CENTINELA-) " & Now
                .flags.Ban = 1
                Index = Centinela.RevisandoUserIndex
                Centinela.RevisandoUserIndex = 0
                Call CloseSocket(Index)
                Call WriteVar(CharPath & Name & ".chr", "FLAGS", "Ban", "1")
                Call WriteVar(CharPath & Name & ".chr", "PENAS", "Cant", 8)
                Call WriteVar(CharPath & Name & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
                GoTo keep
                Exit Sub
            End Select

            Call WriteVar(CharPath & Name & ".chr", "PENAS", "Cant", CStr(.Stats.CantPenas))
            Call WriteVar(CharPath & Name & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
            .Stats.Penas(.Stats.CantPenas) = pena_string
        End With

        'Evitamos loguear el logout


        Index = Centinela.RevisandoUserIndex
        Centinela.RevisandoUserIndex = 0
        Call CloseSocket(Index)
    End If

keep:
    Centinela.clave = 0
    Centinela.TiempoRestante = 0
    Centinela.RevisandoUserIndex = 0

    If CentinelaNPCIndex Then
        Call QuitarNPC(CentinelaNPCIndex)
        CentinelaNPCIndex = 0
    End If

    Exit Sub

Error_Handler:
    Centinela.clave = 0
    Centinela.TiempoRestante = 0
    Centinela.RevisandoUserIndex = 0

    If CentinelaNPCIndex Then
        Call QuitarNPC(CentinelaNPCIndex)
        CentinelaNPCIndex = 0
    End If

    Call LogError("Error en el checkeo del centinela: " & Err.Description)
End Sub

Public Sub SetPenalty(ByVal UserName As String, penaltyDescription As String, penaltyMinutes As Integer, Optional banDays As Variant, Optional banReason As Variant)

    Dim tIndex As Integer

    tIndex = NameIndex(UserName)

    If tIndex = 0 Then
        If Not FileExist(CharPath & UserName & ".chr") Then
            Exit Sub
        End If
        Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", penaltyMinutes)
    Else
        UserList(tIndex).Counters.Pena = penaltyMinutes
    End If

    If Not IsMissing(banDays) Then
        If tIndex > 0 Then
            UserList(tIndex).flags.Ban = 1
            Call CloseSocket(tIndex)
        End If
        Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
        Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + banDays * 15)
    End If

    If Not IsMissing(banReason) Then
        Call WriteVar(CharPath & UserName & ".chr", "PENAS", "BanMotivo", banReason)
    End If

End Sub

Public Sub CentinelaCheckClave(ByVal UserIndex As Integer, ByVal clave As String)
'############################################################
'Corrobora la clave que le envia el usuario
'############################################################
    If UCase$(clave) = UCase$(Centinela.clave) And UserIndex = Centinela.RevisandoUserIndex Or UserList(UserIndex).flags.Privilegios >= PlayerType.Dios Then
        UserList(Centinela.RevisandoUserIndex).flags.CentinelaOK = True

        Dim Tick As Long
        Tick = GetTickCount
        If Tick - UserList(Centinela.RevisandoUserIndex).flags.CentinelaReaction < 500 Then
            Call LogAntiCheat(UserList(UserIndex).Name & " respondió rapidito el centinela, ojo con éste.. " & Tick - UserList(Centinela.RevisandoUserIndex).flags.CentinelaReaction & " ms de respuesta")
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor - " & UserList(UserIndex).Name & " respondió rapidito el centinela, ojo con éste.. " & Tick - UserList(Centinela.RevisandoUserIndex).flags.CentinelaReaction & " ms de respuesta", FontTypeNames.FONTTYPE_SERVER))
        End If

        Call WriteChatOverHead(UserIndex, "¡Muchas gracias " & UserList(Centinela.RevisandoUserIndex).Name & "! Espero no haber sido una molestia.", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbWhite)
        UserList(Centinela.RevisandoUserIndex).Counters.Trabajando = 0
        Centinela.RevisandoUserIndex = 0
        'Call Flushbuffer(UserIndex)
    Else
        Call CentinelaSendClave(UserIndex)

        'Logueamos el evento
        If UserIndex = Centinela.RevisandoUserIndex Then
            Call LogCentinela(UserList(UserIndex).Name & " respondió una clave incorrecta: " & clave)
        End If
    End If
End Sub

Public Sub ResetCentinelaInfo()
'############################################################
'Cada determinada cantidad de tiempo, volvemos a revisar
'############################################################
    Dim LoopC As Long

    For LoopC = 1 To LastUser
        If (LenB(UserList(LoopC).Name) <> 0 And LoopC <> Centinela.RevisandoUserIndex) Then
            UserList(LoopC).flags.CentinelaOK = False
            UserList(LoopC).flags.CentinelaReaction = 0
        End If
    Next LoopC
End Sub

Public Sub CentinelaSendClave(ByVal UserIndex As Integer)
'############################################################
'Enviamos al usuario la clave vía el personaje centinela
'############################################################
    If CentinelaNPCIndex = 0 Then Exit Sub

    If UserIndex = Centinela.RevisandoUserIndex Then

        If distancia(Npclist(CentinelaNPCIndex).Pos, UserList(Centinela.RevisandoUserIndex).Pos) > 8 Then
            Call WarpCentinela(Centinela.RevisandoUserIndex)
        End If

        If Not UserList(UserIndex).flags.CentinelaOK Then
            'Call WriteChatOverHead(userindex, "¡La clave que te he dicho es /CENTINELA " & Centinela.clave & ", escríbelo rápido!", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbGreen)
            Call WriteChatOverHead(UserIndex, "¡No me hagas perder el tiempo! " & Centinela.Frase, CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbWhite)
            Call WriteMensajes(UserIndex, Mensaje_426, FontTypeNames.FONTTYPE_CENTINELA)
        Else
            'Logueamos el evento
            Call LogCentinela("El usuario " & UserList(Centinela.RevisandoUserIndex).Name & " respondió más de una vez la contraseña correcta.")
            Call WriteChatOverHead(UserIndex, "Te agradezco, pero ya me has respondido. Me retiraré pronto.", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbGreen)
        End If
    Else
        Call WriteChatOverHead(UserIndex, "No es a ti a quien estoy hablando, ¿No ves?", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbWhite)
    End If
End Sub

Public Sub PasarMinutoCentinela()
'############################################################
'Control del timer. Llamado cada un minuto.
'############################################################
    On Error GoTo Errhandler

1   If Not centinelaActivado Then Exit Sub

    If CentinelaNPCIndex = 0 Then
        Centinela.RevisandoUserIndex = 0
    End If

2   If Centinela.RevisandoUserIndex = 0 Then
3       Call GoToNextWorkingChar
4   Else
5       Centinela.TiempoRestante = Centinela.TiempoRestante - 1

6       If Centinela.TiempoRestante = 0 Then
7           Call CentinelaFinalCheck
8           Call GoToNextWorkingChar
        Else
            'Recordamos al user que debe escribir
9           If distancia(Npclist(CentinelaNPCIndex).Pos, UserList(Centinela.RevisandoUserIndex).Pos) > 5 Then
10              Call WarpCentinela(Centinela.RevisandoUserIndex)
11          End If

            'El centinela habla y se manda a consola para que no quepan dudas
            '12            Call WriteChatOverHead(Centinela.RevisandoUserIndex, "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes un minuto más para responder! Debes escribir /CENTINELA " & Centinela.clave & ".", CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbRed)
12          Call WriteChatOverHead(Centinela.RevisandoUserIndex, "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes un minuto más para responder! " & Centinela.Frase, CStr(Npclist(CentinelaNPCIndex).Char.CharIndex), vbRed)
13          Call WriteConsoleMsg(Centinela.RevisandoUserIndex, "¡" & UserList(Centinela.RevisandoUserIndex).Name & ", tienes un minuto más para responder!", FontTypeNames.FONTTYPE_CENTINELA)
            'Call Flushbuffer(Centinela.RevisandoUserIndex)
        End If
    End If
    Exit Sub
Errhandler:
    Call LogError("Error en PasarMinutoCentinela en " & Erl & ". ERr: " & Err.Number & " " & Err.Description)
End Sub

Private Sub WarpCentinela(ByVal UserIndex As Integer)
'############################################################
'Inciamos la revisión del usuario UserIndex
'############################################################
'Evitamos conflictos de índices
    If CentinelaNPCIndex Then
        Call QuitarNPC(CentinelaNPCIndex)
        CentinelaNPCIndex = 0
    End If

    'If HayAgua(UserList(UserIndex).Pos.map, UserList(UserIndex).Pos.X, UserList(UserIndex).Pos.Y) Then
    CentinelaNPCIndex = SpawnNpc(NPC_CENTINELA, UserList(UserIndex).Pos, True, False)
    'End If

    'Si no pudimos crear el NPC, seguimos esperando a poder hacerlo
    If CentinelaNPCIndex = 0 Then _
       Centinela.RevisandoUserIndex = 0
End Sub

Public Sub CentinelaUserLogout()
'############################################################
'El usuario al que revisabamos se desconectó
'############################################################
    If Centinela.RevisandoUserIndex Then
        ' 'Logueamos el evento
        'Call LogCentinela("El usuario " & UserList(Centinela.RevisandoUserIndex).Name & " disconnected.")

        'Reseteamos y esperamos a otro PasarMinuto para ir al siguiente user
        Centinela.clave = ""
        Centinela.TiempoRestante = 0
        Centinela.RevisandoUserIndex = 0

        If CentinelaNPCIndex Then
            Call QuitarNPC(CentinelaNPCIndex)
            CentinelaNPCIndex = 0
        End If
    End If
End Sub

Private Sub LogCentinela(ByVal texto As String)
'*************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last modified: 03/15/2006
'Loguea un evento del centinela
'*************************************************
    On Error GoTo Errhandler

    Dim nFile As Integer
    nFile = FreeFile        ' obtenemos un canal

    Open App.path & "\logs\Centinela.log" For Append Shared As #nFile
    Print #nFile, Date & " " & Time & " " & texto
    Close #nFile
    Exit Sub

Errhandler:
End Sub
