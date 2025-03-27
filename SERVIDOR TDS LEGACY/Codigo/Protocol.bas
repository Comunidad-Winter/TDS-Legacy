Attribute VB_Name = "Protocol"
Option Explicit

Public Const SEPARATOR As String * 1 = vbNullChar

Public Enum ServerPacketID
    SendCuentaRegresiva = 0
    AddSlots
    AlianceProposalsList
    AreaChanged
    Atributes
    BankEnd
    BankInit
    BankOK
    BlacksmithArmors
    BlacksmithWeapons
    Blind
    BlindNoMore
    BlockPosition
    BonifStatus
    CancelOfferItem
    CarpenterObjects
    ChangeBankSlot
    ChangeInventorySlot
    ChangeMap
    ChangeNPCInventorySlot
    ChangeSpellSlot
    ChangeUserTradeSlot
    CharacterChange
    CharacterChangeBody
    CharacterChangeHelmet
    CharacterChangeNick
    CharacterChangeShield
    CharacterChangeSpecial
    CharacterChangeWeapon
    CharacterCreate
    CharacterInfo
    CharacterMove    'REMOVE THIS!
    CharacterRemove
    ChatOverHead
    CloseClient
    CommerceChat
    CommerceEnd
    CommerceInit
    Connected
    ConsoleMsg
    CreateDamage
    CreateFX
    CreateProjectile
    DiceRoll
    Disconnect
    Dumb
    DumbNoMore
    errorMsg
    Fame
    ForceCharMove
    GuildChat
    GuildDetails
    GuildLeaderInfo
    guildList
    guildNews
    Intervalos
    LevelUp
    logged
    MeditateToggle
    MensajeShort
    MiniStats
    MovimientSW
    MultiMessage
    NavigateToggle
    ObjectCreate
    ObjectDelete
    OfferDetails
    ParalizeOK
    PartyDetail
    PartyExit
    PauseToggle
    PeaceProposalsList
    PlayMIDI
    PlayWave
    Pong
    PosUpdate
    RainToggle
    RemoveCharDialog
    RemoveDialogs
    RestOK
    SendPartyData
    SendSkills
    SetCombatMode
    SetInvisible
    ShowBlacksmithForm
    ShowCarpenterForm
    ShowGMPanelForm
    ShowGuildFundationForm
    ShowMessageBox
    ShowSignal
    ShowSOSForm
    ShowUserRequest
    SpawnList
    StopWorking
    TradeOK
    TrainerCreatureList
    UpdateBankGold
    UpdateDexterity
    UpdateEnvenenado
    UpdateExp
    UpdateFaccion
    UpdateGold
    UpdateHP
    UpdateHungerAndThirst
    UpdateMana
    UpdateSta
    UpdateStatsNew
    UpdateStrenght
    UpdateStrenghtAndDexterity
    UpdateTagAndStatus
    UpdateUserStats
    UserCharIndexInServer
    UserCommerceEnd
    UserCommerceInit
    UserIndexInServer
    UserNameList
    UserOfferConfirm
    WorkRequestTarget
    CharacterMove_NORTH
    CharacterMove_EAST
    CharacterMove_SOUTH
    CharacterMove_WEST
    ChangeHeading
    ShowBorrarPjForm
    BorrarMensajeConsola
    ShowResetearPjForm
    SetEfectoNick
    UpdateCharData
    InitWorking
    ShowSpecialForm

    QuestDetails
    QuestListSend

    CVCListSend

    PalabrasMagicas    ' ToDo!
    ShowCVCInvitation
    
    [PacketCount]

End Enum

Private Enum ClientPacketID

    TickAntiCuelgue
    DragBov
    DragToPos
    DragInventario
    DepositarTodo
    RetirarTodo
    DisolverClan
    ReanudarClan
    LoginExistingChar
    ThrowDices
    LoginNewChar
    Talk
    Yell
    Whisper
    Walk
    RequestPositionUpdate
    Attack
    PickUp
    SafeToggle
    DragToggle
    ResuscitationSafeToggle
    RequestGuildLeaderInfo        'GLINFO
    RequestAtributes        'ATR
    RequestFame        'FAMA
    RequestSkills        'ESKI
    RequestMiniStats        'FEST
    CommerceEnd        'FINCOM
    UserCommerceEnd        'FINCOMUSU
    UserCommerceConfirm
    CommerceChat
    BankEnd        'FINBAN
    UserCommerceOk        'COMUSUOK
    UserCommerceReject        'COMUSUNO
    Drop        'TI
    CastSpell        'LH
    LeftClick        'LC
    DoubleClick        'RC
    Work        'UK
    UseSpellMacro        'UMH
    UseItem        'USA
    CraftBlacksmith        'CNS
    CraftCarpenter        'CNC
    WorkLeftClick        'WLC
    CreateNewGuild        'CIG
    EquipItem        'EQUI
    ChangeHeading        'CHEA
    ModifySkills        'SKSE
    Train        'ENTR
    CommerceBuy        'COMP
    BankExtractItem        'RETI
    CommerceSell        'VEND
    BankDeposit        'DEPO
    MoveSpell        'DESPHE
    MoveBank
    ClanCodexUpdate        'DESCOD
    UserCommerceOffer        'OFRECER
    GuildAcceptPeace        'ACEPPEAT
    GuildRejectAlliance        'RECPALIA
    GuildRejectPeace        'RECPPEAT
    GuildAcceptAlliance        'ACEPALIA
    GuildOfferPeace        'PEACEOFF
    GuildOfferAlliance        'ALLIEOFF
    GuildAllianceDetails        'ALLIEDET
    GuildPeaceDetails        'PEACEDET
    GuildRequestJoinerInfo        'ENVCOMEN
    GuildAlliancePropList        'ENVALPRO
    GuildPeacePropList        'ENVPROPP
    GuildDeclareWar        'DECGUERR
    GuildNewWebsite        'NEWWEBSI
    GuildAcceptNewMember        'ACEPTARI
    GuildRejectNewMember        'RECHAZAR
    GuildKickMember        'ECHARCLA
    GuildUpdateNews        'ACTGNEWS
    GuildMemberInfo        '1HRINFO<
    GuildOpenElections        'ABREELEC
    GuildRequestMembership        'SOLICITUD
    GuildRequestDetails        'CLANDETAILS
    Online        '/ONLINE
    Quit        '/SALIR
    GuildLeave        '/SALIRCLAN
    RequestAccountState        '/BALANCE
    PetStand        '/QUIETO
    PetFollow        '/ACOMPAÑAR
    ReleasePet        '/LIBERAR
    TrainList        '/ENTRENAR
    Rest        '/DESCANSAR
    Meditate        '/MEDITAR
    Resucitate        '/RESUCITAR
    Heal        '/CURAR
    Help        '/AYUDA
    RequestStats        '/EST
    CommerceStart        '/COMERCIAR
    BankStart        '/BOVEDA
    Enlist        '/ENLISTAR
    Information        '/INFORMACION
    Reward        '/RECOMPENSA
    UpTime        '/UPTIME
    GuildMessage        '/CMSG
    CentinelReport        '/CENTINELA
    GuildOnline        '/ONLINECLAN
    CouncilMessage        '/BMSG
    RoleMasterRequest        '/ROL
    GMRequest        '/GM
    ChangeDescription        '/DESC
    GuildVote        '/VOTO
    Punishments        '/PENAS
    ChangePassword        '/CONTRASEÑA
    Gamble        '/APOSTAR
    LeaveFaction        '/RETIRAR ( with no arguments )
    BankExtractGold        '/RETIRAR ( with arguments )
    BankDepositGold        '/DEPOSITAR
    Denounce        '/DENUNCIAR
    GuildFundate        '/FUNDARCLAN
    GuildFundation
    Ping        '/PING
    InitCrafting
    ShowGuildNews
    ShareNpc        '/COMPARTIR
    StopSharingNpc
    Consultation
    Cheat
    ToggleCombatMode
    PartyLeave        ' Salgo party
    PartyKick
    PartyCreate
    PartyJoin
    PartySetLeader
    PartyAcceptMember
    SetPartyPorcentajes
    RequestPartyForm
    CancelReto
    AcceptReto
    SendReto
    OtherSendReto
    ActivarGlobal
    SendMsjGlobal
    AbandonarReto
    Fianza        'NEW

    '''''''''''''''''
    GMMessage         '/GMSG
    showName        '/SHOWNAME
    OnlineRoyalArmy        '/ONLINEREAL
    OnlineChaosLegion        '/ONLINECAOS
    GoNearby        '/IRCERCA
    serverTime        '/HORA
    Where        '/DONDE
    CreaturesInMap        '/NENE
    WarpMeToTarget        '/TELEPLOC
    WarpChar        '/TELEP
    Silence        '/SILENCIAR
    SOSShowList        '/SHOW SOS
    SOSRemove        'SOSDONE
    GoToChar        '/IRA
    invisible        '/INVISIBLE
    GMPanel        '/PANELGM
    RequestUserList        'LISTUSU
    Working        '/TRABAJANDO

    KillNPC        '/RMATA
    Penar        '/PENAR
    EditChar        '/MOD
    RequestCharInfo        '/INFO
    RequestCharStats        '/STAT
    RequestCharGold        '/BAL
    RequestCharInventory        '/INV
    RequestCharBank        '/BOV
    RequestCharSkills        '/SKILLS
    ReviveChar        '/REVIVIR
    OnlineGM        '/ONLINEGM
    OnlineMap        '/ONLINEMAP
    Forgive        '/PERDON
    Kick        '/ECHAR
    Execute        '/EJECUTAR
    BanChar        '/BAN
    UnbanChar        '/UNBAN
    NPCFollow        '/SEGUIR
    SummonChar        '/SUM
    SpawnListRequest        '/CC
    SpawnCreature        'SPA
    ResetNPCInventory        '/RESETINV
    CleanWorld        '/LIMPIAR
    ServerMessage        '/RMSG
    NickToIP        '/NICK2IP
    IPToNick        '/IP2NICK
    GuildOnlineMembers        '/ONCLAN
    TeleportCreate        '/CT
    TeleportDestroy        '/DT
    RainToggle        '/LLUVIA
    SetCharDescription        '/SETDESC
    ForceMIDIToMap        '/FORCEMIDIMAP
    ForceWAVEToMap        '/FORCEWAVMAP
    RoyalArmyMessage        '/REALMSG
    ChaosLegionMessage        '/CAOSMSG
    CitizenMessage        '/CIUMSG
    CriminalMessage        '/CRIMSG
    TalkAsNPC        '/TALKAS
    DestroyAllItemsInArea        '/MASSDEST
    AcceptRoyalCouncilMember        '/ACEPTCONSE
    AcceptChaosCouncilMember        '/ACEPTCONSECAOS
    ItemsInTheFloor        '/PISO
    MakeDumb        '/ESTUPIDO
    MakeDumbNoMore        '/NOESTUPIDO
    CouncilKick        '/KICKCONSE
    SetTrigger        '/TRIGGER
    AskTrigger        '/TRIGGER with no args
    BannedIPList        '/BANIPLIST
    BannedIPReload        '/BANIPRELOAD
    GuildMemberList        '/MIEMBROSCLAN
    GuildBan        '/BANCLAN
    BANIP        '/BANIP
    UnbanIP        '/UNBANIP
    CreateItem        '/CI
    DestroyItems        '/DEST
    ChaosLegionKick        '/NOCAOS
    RoyalArmyKick        '/NOREAL
    ForceMIDIAll        '/FORCEMIDI
    ForceWAVEAll        '/FORCEWAV
    RemovePunishment        '/BORRARPENA
    TileBlockedToggle        '/BLOQ
    KillNPCNoRespawn        '/MATA
    KillAllNearbyNPCs        '/MASSKILL
    LastIP        '/LASTIP
    SystemMessage        '/SMSG
    CreateNPC        '/ACC
    CreateNPCWithRespawn        '/RACC
    ServerOpenToUsersToggle        '/HABILITAR
    TurnCriminal        '/CONDEN
    ResetFactions        '/RAJAR
    RemoveCharFromGuild        '/RAJARCLAN
    RequestCharMail        '/LASTEMAIL
    AlterPassword        '/APASS
    AlterMail        '/AEMAIL
    AlterName        '/ANAME
    ToggleCentinelActivated        '/CENTINELAACTIVADO
    DoBackUp        '/DOBACKUP
    ShowGuildMessages        '/SHOWCMSG
    SaveMap        '/GUARDAMAPA
    ChangeMapInfoPK        '/MODMAPINFO PK
    ChangeMapInfoBackup        '/MODMAPINFO BACKUP
    ChangeMapInfoRestricted        '/MODMAPINFO RESTRINGIR
    ChangeMapInfoNoMagic        '/MODMAPINFO MAGIASINEFECTO
    ChangeMapInfoNoInvi        '/MODMAPINFO INVISINEFECTO
    ChangeMapInfoNoResu        '/MODMAPINFO RESUSINEFECTO
    ChangeMapInfoLand        '/MODMAPINFO TERRENO
    ChangeMapInfoZone        '/MODMAPINFO ZONA
    SaveChars        '/GRABAR
    CleanSOS        '/BORRAR SOS
    ShowServerForm        '/SHOW INT
    KickAllChars        '/ECHARTODOSPJS
    ReloadNPCs        '/RELOADNPCS
    ReloadServerIni        '/RELOADSINI
    ReloadSpells        '/RELOADHECHIZOS
    ReloadObjects        '/RELOADOBJ
    ChatColor        '/CHATCOLOR
    Ignored        '/IGNORADO
    Conteo        '/CONTEO NUM
    CrearTorneo
    SalirTorneo
    IngresarTorneo
    CancelarTorneo
    VerHD
    BanHD
    UnbanHD
    PartyTalk
    ChangeMapInfoNoInvocar
    FUN_PjFUll
    FUN_GMFUll
    ResetChar
    SendReto3vs3
    BorrarPj
    BorrarMensajeConsola
    ChangeMapInfoMusic
    MenuClient
    UsePotionsU
    UsePotionsClick
    UsePotionsLastU
    UsePotionsLastClick
    WorkMagia
    WorkMagiaClick
    ChequeMAO
    CambiarCara
    CambiarNick
    CambiarNickClan

    Quest
    QuestAccept
    QuestListRequest
    QuestDetailsRequest
    QuestAbandon

    CVC_Accion
    RetoBOT

    [PacketCount]

End Enum

Public Enum FontTypeNames

    FONTTYPE_TALK = 0
    FONTTYPE_FIGHT = 1
    FONTTYPE_WARNING
    FONTTYPE_INFO
    FONTTYPE_INFOBOLD
    FONTTYPE_EJECUCION
    FONTTYPE_PARTY
    FONTTYPE_VENENO
    FONTTYPE_GUILD
    FONTTYPE_SERVER
    FONTTYPE_GUILDMSG
    FONTTYPE_CONSEJO
    FONTTYPE_CONSEJOCAOS
    FONTTYPE_CONSEJOVesA
    FONTTYPE_CONSEJOCAOSVesA
    FONTTYPE_CENTINELA
    FONTTYPE_GMMSG
    FONTTYPE_GM
    FONTTYPE_CITIZEN
    FONTTYPE_CONSE
    FONTTYPE_DIOS
    FONTTYPE_ADMIN
    FONTTYPE_GLOBAL
    FONTTYPE_APU

    FONTTYPE_EVENTOS


    FONTTYPE_NARANJA
    FONTTYPE_VERDE
    FONTTYPE_BORDO
    FONTTYPE_MARRON
    FONTTYPE_AMARILLO
    FONTTYPE_VIOLETA

End Enum

Public Enum eEditOptions

    eo_Gold = 1
    eo_Experience
    eo_Body
    eo_Head
    eo_CiticensKilled
    eo_CriminalsKilled
    eo_Level
    eo_Class
    eo_Skills
    eo_SkillPointsLeft
    eo_Nobleza
    eo_Asesino
    eo_Sex
    eo_Raza
    eo_addGold

End Enum

Public Writer_ As BinaryWriter

Public Sub Initialize()

    Set Writer_ = New BinaryWriter
    
End Sub

Public Sub OnConnect(ByVal Connection As Network_Client)


'==========================================================
'USO DE LA API DE WINSOCK
'========================
    
    Dim NewIndex As Integer
    Dim i As Long
  
    Dim Address As String
    Address = "127.0.0.1"
    'Address = Connection.GetStatistics().Address
    
    If Not SecurityIp.IpSecurityAceptarNuevaConexion(GetLongIp(Address)) Then
        Call Connection.Close(True)
        Exit Sub
    End If

    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '   BIENVENIDO AL SERVIDOR!!!!!!!!
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    'Mariano: Baje la busqueda de slot abajo de CondicionSocket y limite x ip
    NewIndex = NextOpenUser ' Nuevo indice
    
    If NewIndex <= maxUsers Then
        Call Connection.SetAttachment(NewIndex)
        
        UserList(NewIndex).IP = Address
        
       ' For i = 1 To BanIps.count
       '     If BanIps.Item(i) = UserList(NewIndex).IP Then
       '         'Call apiclosesocket(NuevoSock)
       '         Call WriteErrorMsg(NewIndex, "Su IP se encuentra bloqueada en este servidor.")
       '         Call Connection.Close(False)
       '         Exit Sub
       '     End If
       ' Next i
        
        If NewIndex > LastUser Then LastUser = NewIndex
        
        Set UserList(NewIndex).Connection = Connection
        UserList(NewIndex).ConnIDValida = True
        UserList(NewIndex).ConnID = NewIndex
    Else
    
        Call Connection.Write(PrepareMessageErrorMsg("El server se encuentra lleno en este momento. Disculpe las molestias ocasionadas."), eChannelReliable)
        Call Writer_.Clear
        Call Connection.Close(False)
        
    End If
    
End Sub

Public Sub OnClose(ByVal Connection As Network_Client)
    Dim UserIndex As Long
    UserIndex = Connection.GetAttachment()
    
    If (UserIndex > 0) Then

        UserList(UserIndex).ConnID = -1
        UserList(UserIndex).ConnIDValida = False

            
        If UserList(UserIndex).flags.UserLogged Then
            Call Cerrar_Usuario(UserIndex)
        Else
            Call CloseSocket(UserIndex)
        End If

        Set UserList(UserIndex).Connection = Nothing
        
    End If
    
End Sub


Public Sub Encode(ByVal Connection As Network_Client, ByVal Message As BinaryReader)

    ' Here goes encode function
    
End Sub

Public Sub Decode(ByVal Connection As Network_Client, ByVal Message As BinaryReader)

    ' Here goes decode function
    
End Sub

Public Sub Handle(ByVal Connection As Network_Client, ByVal Message As BinaryReader)

    Dim UserIndex As Long
    UserIndex = Connection.GetAttachment()

    If (UserIndex <= 0) Then
        Exit Sub
    End If

    On Error Resume Next

    Dim PacketID As Long
    PacketID = Message.ReadInt

    If Not (PacketID = ClientPacketID.ThrowDices Or PacketID = ClientPacketID.LoginExistingChar Or PacketID = ClientPacketID.LoginNewChar) Then

        If Not UserList(UserIndex).flags.UserLogged Then
            Call CloseSocket(UserIndex)
            Exit Sub
        Else
            'He is logged. Reset idle counter if id is valid.
            UserList(UserIndex).Counters.IdleCount = 0
            UserList(UserIndex).flags.NoPuedeSerAtacado = False
        End If
    Else
        'He is logged. Reset idle counter if id is valid.
        UserList(UserIndex).Counters.IdleCount = 0
    End If

    Select Case PacketID

    Case ClientPacketID.RetoBOT
        Call HandleRetoBOT(Message, UserIndex)

    Case ClientPacketID.CVC_Accion
        Call HandleCVC_Accion(Message, UserIndex)

    Case ClientPacketID.Quest
        Call HandleQuest(Message, UserIndex)

    Case ClientPacketID.QuestAccept
        Call HandleQuestAccept(Message, UserIndex)

    Case ClientPacketID.QuestListRequest
        Call HandleQuestListRequest(Message, UserIndex)

    Case ClientPacketID.QuestDetailsRequest
        Call HandleQuestDetailsRequest(Message, UserIndex)

    Case ClientPacketID.QuestAbandon
        Call HandleQuestAbandon(Message, UserIndex)

    Case ClientPacketID.LoginExistingChar
        Call HandleLoginExistingChar(Message, UserIndex)

    Case ClientPacketID.ThrowDices
        Call HandleThrowDices(Message, UserIndex)

    Case ClientPacketID.LoginNewChar
        Call HandleLoginNewChar(Message, UserIndex)

    Case ClientPacketID.VerHD        '/VERHD NICKUSUARIO
        Call HandleVerHD(Message, UserIndex)

    Case ClientPacketID.Fianza
        Call HandleFianza(Message, UserIndex)

    Case ClientPacketID.BanHD        '/BANHD NICKUSUARIO
        Call HandleBanHD(Message, UserIndex)

    Case ClientPacketID.PartyTalk
        Call HandlePartyTalk(Message, UserIndex)

    Case ClientPacketID.UnbanHD        '/UNBANHD NICKUSUARIO
        Call HandleUnbanHD(Message, UserIndex)

    Case ClientPacketID.CrearTorneo
        Call HandleCrearTorneo(Message, UserIndex)

    Case ClientPacketID.SalirTorneo
        Call HandleSalirTorneo(Message, UserIndex)

    Case ClientPacketID.IngresarTorneo
        Call HandleIngresarTorneo(Message, UserIndex)

    Case ClientPacketID.CancelarTorneo
        Call HandleCancelarTorneo(Message, UserIndex)

    Case ClientPacketID.AbandonarReto
136     Call HandleAbandonarReto(Message, UserIndex)

138 Case ClientPacketID.TickAntiCuelgue
140     Call HandleTickAntiCuelgue(Message, UserIndex)

142 Case ClientPacketID.AcceptReto
144     Call HandleAcceptReto(Message, UserIndex)

146 Case ClientPacketID.CancelReto
148     Call HandleCancelarSolicitudReto(Message, UserIndex)

150 Case ClientPacketID.SendReto
152     Call HandleSendReto(Message, UserIndex)

154 Case ClientPacketID.OtherSendReto
156     Call HandleOtherSendReto(Message, UserIndex)

158 Case ClientPacketID.ActivarGlobal
160     Call HandleActivarGlobal(Message, UserIndex)

162 Case ClientPacketID.SendMsjGlobal
164     Call HandleGlobalMessage(Message, UserIndex)

166 Case ClientPacketID.Cheat
168     Call HandleCheater(Message, UserIndex)

170 Case ClientPacketID.DragInventario
172     Call HandleDragInventory(Message, UserIndex)

174 Case ClientPacketID.DragToPos
176     Call HandleDragToPos(Message, UserIndex)

178 Case ClientPacketID.DragBov
180     Call HandleDragBov(Message, UserIndex)

182 Case ClientPacketID.DepositarTodo
184     Call handleDepositarTodo(Message, UserIndex)

186 Case ClientPacketID.RetirarTodo
188     Call handleRetirarTodo(Message, UserIndex)

190 Case ClientPacketID.DisolverClan
192     Call HandleDisolverClan(Message, UserIndex)

194 Case ClientPacketID.ReanudarClan
196     Call HandleReanudarClan(Message, UserIndex)

210 Case ClientPacketID.Talk
212     Call HandleTalk(Message, UserIndex)

214 Case ClientPacketID.Yell
216     Call HandleYell(Message, UserIndex)

218 Case ClientPacketID.Whisper
220     Call HandleWhisper(Message, UserIndex)

222 Case ClientPacketID.Walk
224     Call HandleWalk(Message, UserIndex)

226 Case ClientPacketID.RequestPositionUpdate
228     Call HandleRequestPositionUpdate(Message, UserIndex)

230 Case ClientPacketID.Attack
232     Call HandleAttack(Message, UserIndex)

234 Case ClientPacketID.PickUp
236     Call HandlePickUp(Message, UserIndex)

238 Case ClientPacketID.SafeToggle
240     Call HandleSafeToggle(Message, UserIndex)

242 Case ClientPacketID.DragToggle
244     Call HandleDragToggle(Message, UserIndex)

246 Case ClientPacketID.ResuscitationSafeToggle
248     Call HandleResuscitationToggle(Message, UserIndex)

250 Case ClientPacketID.RequestGuildLeaderInfo
252     Call HandleRequestGuildLeaderInfo(Message, UserIndex)

254 Case ClientPacketID.RequestAtributes
256     Call HandleRequestAtributes(Message, UserIndex)

258 Case ClientPacketID.RequestFame
260     Call HandleRequestFame(Message, UserIndex)

262 Case ClientPacketID.RequestSkills
264     Call HandleRequestSkills(Message, UserIndex)

266 Case ClientPacketID.RequestMiniStats
268     Call HandleRequestMiniStats(Message, UserIndex)

270 Case ClientPacketID.CommerceEnd
272     Call HandleCommerceEnd(Message, UserIndex)

274 Case ClientPacketID.CommerceChat
276     Call HandleCommerceChat(Message, UserIndex)

278 Case ClientPacketID.UserCommerceEnd
280     Call HandleUserCommerceEnd(Message, UserIndex)

282 Case ClientPacketID.UserCommerceConfirm
284     Call HandleUserCommerceConfirm(Message, UserIndex)

286 Case ClientPacketID.BankEnd
288     Call HandleBankEnd(Message, UserIndex)

290 Case ClientPacketID.UserCommerceOk
292     Call HandleUserCommerceOk(Message, UserIndex)

294 Case ClientPacketID.UserCommerceReject
296     Call HandleUserCommerceReject(Message, UserIndex)

298 Case ClientPacketID.Drop
300     Call HandleDrop(Message, UserIndex)

302 Case ClientPacketID.CastSpell
304     Call HandleCastSpell(Message, UserIndex)

306 Case ClientPacketID.LeftClick
308     Call HandleLeftClick(Message, UserIndex)

310 Case ClientPacketID.DoubleClick
312     Call HandleDoubleClick(Message, UserIndex)

314 Case ClientPacketID.Work
316     Call HandleWork(Message, UserIndex)

    Case ClientPacketID.UseSpellMacro
        Call HandleUseSpellMacro(Message, UserIndex)

322 Case ClientPacketID.UseItem
324     Call HandleUseItem(Message, UserIndex)

1130 Case ClientPacketID.UsePotionsU
1140    Call HandleUsePotionsU(Message, UserIndex, 0)

14141 Case ClientPacketID.WorkMagia
1412    Call HandleWorkMagia(Message, UserIndex)

6456 Case ClientPacketID.WorkMagiaClick
65445   Call HandleWorkMagiaClick(Message, UserIndex)

    Case ClientPacketID.ChequeMAO
        Call HandleChequeMAO(Message, UserIndex)

    Case ClientPacketID.CambiarCara
        Call HandleCambiarCara(Message, UserIndex)

    Case ClientPacketID.CambiarNick
        Call HandleCambiarNick(Message, UserIndex)

    Case ClientPacketID.CambiarNickClan
        Call HandleCambiarNickClan(Message, UserIndex)

1425 Case ClientPacketID.UsePotionsLastU
1647    Call HandleUsePotionsU(Message, UserIndex, 1)

1954 Case ClientPacketID.UsePotionsLastClick
1738    Call HandleUsePotionsClick(Message, UserIndex, 1)

1150 Case ClientPacketID.UsePotionsClick
1160    Call HandleUsePotionsClick(Message, UserIndex, 0)

326 Case ClientPacketID.CraftBlacksmith
328     Call HandleCraftBlacksmith(Message, UserIndex)

330 Case ClientPacketID.CraftCarpenter
332     Call HandleCraftCarpenter(Message, UserIndex)

334 Case ClientPacketID.WorkLeftClick
336     Call HandleWorkLeftClick(Message, UserIndex)

338 Case ClientPacketID.CreateNewGuild
340     Call HandleCreateNewGuild(Message, UserIndex)

342 Case ClientPacketID.EquipItem
344     Call HandleEquipItem(Message, UserIndex)

346 Case ClientPacketID.ChangeHeading
348     Call HandleChangeHeading(Message, UserIndex)

350 Case ClientPacketID.ModifySkills
352     Call HandleModifySkills(Message, UserIndex)

354 Case ClientPacketID.Train
356     Call HandleTrain(Message, UserIndex)

358 Case ClientPacketID.CommerceBuy
360     Call HandleCommerceBuy(Message, UserIndex)

362 Case ClientPacketID.BankExtractItem
364     Call HandleBankExtractItem(Message, UserIndex)

366 Case ClientPacketID.CommerceSell
368     Call HandleCommerceSell(Message, UserIndex)

370 Case ClientPacketID.BankDeposit
372     Call HandleBankDeposit(Message, UserIndex)

374 Case ClientPacketID.MoveSpell
376     Call HandleMoveSpell(Message, UserIndex)

378 Case ClientPacketID.MoveBank
380     Call HandleMoveBank(Message, UserIndex)

382 Case ClientPacketID.ClanCodexUpdate
384     Call HandleClanCodexUpdate(Message, UserIndex)

386 Case ClientPacketID.UserCommerceOffer
388     Call HandleUserCommerceOffer(Message, UserIndex)

390 Case ClientPacketID.GuildAcceptPeace
392     Call HandleGuildAcceptPeace(Message, UserIndex)

394 Case ClientPacketID.GuildRejectAlliance
396     Call HandleGuildRejectAlliance(Message, UserIndex)

398 Case ClientPacketID.GuildRejectPeace
400     Call HandleGuildRejectPeace(Message, UserIndex)

402 Case ClientPacketID.GuildAcceptAlliance
404     Call HandleGuildAcceptAlliance(Message, UserIndex)

406 Case ClientPacketID.GuildOfferPeace
408     Call HandleGuildOfferPeace(Message, UserIndex)

410 Case ClientPacketID.GuildOfferAlliance
412     Call HandleGuildOfferAlliance(Message, UserIndex)

414 Case ClientPacketID.GuildAllianceDetails
416     Call HandleGuildAllianceDetails(Message, UserIndex)

418 Case ClientPacketID.GuildPeaceDetails
420     Call HandleGuildPeaceDetails(Message, UserIndex)

422 Case ClientPacketID.GuildRequestJoinerInfo
424     Call HandleGuildRequestJoinerInfo(Message, UserIndex)

426 Case ClientPacketID.GuildAlliancePropList
428     Call HandleGuildAlliancePropList(Message, UserIndex)

430 Case ClientPacketID.GuildPeacePropList
432     Call HandleGuildPeacePropList(Message, UserIndex)

434 Case ClientPacketID.GuildDeclareWar
436     Call HandleGuildDeclareWar(Message, UserIndex)

438 Case ClientPacketID.GuildNewWebsite
440     Call HandleGuildNewWebsite(Message, UserIndex)

442 Case ClientPacketID.GuildAcceptNewMember
444     Call HandleGuildAcceptNewMember(Message, UserIndex)

446 Case ClientPacketID.GuildRejectNewMember
448     Call HandleGuildRejectNewMember(Message, UserIndex)

450 Case ClientPacketID.GuildKickMember
452     Call HandleGuildKickMember(Message, UserIndex)

454 Case ClientPacketID.GuildUpdateNews
456     Call HandleGuildUpdateNews(Message, UserIndex)

458 Case ClientPacketID.GuildMemberInfo
460     Call HandleGuildMemberInfo(Message, UserIndex)

462 Case ClientPacketID.GuildOpenElections
464     Call HandleGuildOpenElections(Message, UserIndex)

466 Case ClientPacketID.GuildRequestMembership
468     Call HandleGuildRequestMembership(Message, UserIndex)

470 Case ClientPacketID.GuildRequestDetails
472     Call HandleGuildRequestDetails(Message, UserIndex)

474 Case ClientPacketID.Online
476     Call HandleOnline(Message, UserIndex)

478 Case ClientPacketID.Quit
480     Call HandleQuit(Message, UserIndex)

482 Case ClientPacketID.GuildLeave
484     Call HandleGuildLeave(Message, UserIndex)

486 Case ClientPacketID.RequestAccountState
488     Call HandleRequestAccountState(Message, UserIndex)

490 Case ClientPacketID.PetStand
492     Call HandlePetStand(Message, UserIndex)

494 Case ClientPacketID.PetFollow
496     Call HandlePetFollow(Message, UserIndex)

498 Case ClientPacketID.ReleasePet
500     Call HandleReleasePet(Message, UserIndex)

502 Case ClientPacketID.TrainList
504     Call HandleTrainList(Message, UserIndex)

506 Case ClientPacketID.Rest
508     Call HandleRest(Message, UserIndex)

510 Case ClientPacketID.Meditate
512     Call HandleMeditate(Message, UserIndex)

514 Case ClientPacketID.Resucitate
516     Call HandleResucitate(Message, UserIndex)

518 Case ClientPacketID.Heal
520     Call HandleHeal(Message, UserIndex)

522 Case ClientPacketID.Help
524     Call HandleHelp(Message, UserIndex)

526 Case ClientPacketID.RequestStats
528     Call HandleRequestStats(Message, UserIndex)

530 Case ClientPacketID.CommerceStart
532     Call HandleCommerceStart(Message, UserIndex)

534 Case ClientPacketID.BankStart
536     Call HandleBankStart(Message, UserIndex)

538 Case ClientPacketID.Enlist
540     Call HandleEnlist(Message, UserIndex)

542 Case ClientPacketID.Information
544     Call HandleInformation(Message, UserIndex)

546 Case ClientPacketID.Reward
548     Call HandleReward(Message, UserIndex)

550 Case ClientPacketID.UpTime
552     Call HandleUpTime(Message, UserIndex)

554 Case ClientPacketID.GuildMessage
556     Call HandleGuildMessage(Message, UserIndex)

558 Case ClientPacketID.CentinelReport
560     Call HandleCentinelReport(Message, UserIndex)

562 Case ClientPacketID.GuildOnline
564     Call HandleGuildOnline(Message, UserIndex)

566 Case ClientPacketID.CouncilMessage
568     Call HandleCouncilMessage(Message, UserIndex)

570 Case ClientPacketID.RoleMasterRequest
572     Call HandleRoleMasterRequest(Message, UserIndex)

574 Case ClientPacketID.GMRequest
576     Call HandleGMRequest(Message, UserIndex)

578 Case ClientPacketID.ChangeDescription
580     Call HandleChangeDescription(Message, UserIndex)

582 Case ClientPacketID.GuildVote
584     Call HandleGuildVote(Message, UserIndex)

586 Case ClientPacketID.Punishments        '/PENAS
588     Call HandlePunishments(Message, UserIndex)

590 Case ClientPacketID.ChangePassword        '/CONTRASEÑA
592     Call HandleChangePassword(Message, UserIndex)

594 Case ClientPacketID.Gamble        '/APOSTAR
596     Call HandleGamble(Message, UserIndex)

598 Case ClientPacketID.LeaveFaction        '/RETIRAR (Message,  with no arguments )
600     Call HandleLeaveFaction(Message, UserIndex)

602 Case ClientPacketID.BankExtractGold        '/RETIRAR (Message,  with arguments )
604     Call HandleBankExtractGold(Message, UserIndex)

606 Case ClientPacketID.BankDepositGold        '/DEPOSITAR
608     Call HandleBankDepositGold(Message, UserIndex)

610 Case ClientPacketID.Denounce        '/DENUNCIAR
612     Call HandleDenounce(Message, UserIndex)

614 Case ClientPacketID.GuildFundate        '/FUNDARCLAN
616     Call HandleGuildFundate(Message, UserIndex)

618 Case ClientPacketID.GuildFundation
620     Call HandleGuildFundation(Message, UserIndex)

622 Case ClientPacketID.Ping        '/PING
624     Call HandlePing(Message, UserIndex)

626 Case ClientPacketID.InitCrafting
628     Call HandleInitCrafting(Message, UserIndex)

630 Case ClientPacketID.ShowGuildNews
632     Call HandleShowGuildNews(Message, UserIndex)

634 Case ClientPacketID.ShareNpc
636     Call HandleShareNpc(Message, UserIndex)

638 Case ClientPacketID.StopSharingNpc
640     Call HandleStopSharingNpc(Message, UserIndex)

642 Case ClientPacketID.Consultation
644     Call HandleConsultation(Message, UserIndex)

646 Case ClientPacketID.ToggleCombatMode
648     Call HandleToggleCombatMode(Message, UserIndex)

650 Case ClientPacketID.PartyLeave        '/SALIRPARTY
652     Call HandlePartyLeave(Message, UserIndex)

654 Case ClientPacketID.PartyCreate        '/CREARPARTY
656     Call HandlePartyCreate(Message, UserIndex)

658 Case ClientPacketID.PartyJoin        '/PARTY
660     Call HandlePartyJoin(Message, UserIndex)

662 Case ClientPacketID.SetPartyPorcentajes
664     Call HandleSetPartyPorcentajes(Message, UserIndex)

666 Case ClientPacketID.PartyKick        '/ECHARPARTY
668     Call HandlePartyKick(Message, UserIndex)

670 Case ClientPacketID.PartySetLeader        '/PARTYLIDER
672     Call HandlePartySetLeader(Message, UserIndex)

674 Case ClientPacketID.PartyAcceptMember        '/ACCEPTPARTY
676     Call HandlePartyAcceptMember(Message, UserIndex)

678 Case ClientPacketID.RequestPartyForm        '205
680     Call HandleRequestPartyForm(Message, UserIndex)

682 Case ClientPacketID.GMMessage        '/GMSG
684     Call HandleGMMessage(Message, UserIndex)

686 Case ClientPacketID.showName        '/SHOWNAME
688     Call HandleShowName(Message, UserIndex)

690 Case ClientPacketID.OnlineRoyalArmy
692     Call HandleOnlineRoyalArmy(Message, UserIndex)

694 Case ClientPacketID.OnlineChaosLegion        '/ONLINECAOS
696     Call HandleOnlineChaosLegion(Message, UserIndex)

698 Case ClientPacketID.GoNearby        '/IRCERCA
700     Call HandleGoNearby(Message, UserIndex)

702 Case ClientPacketID.serverTime        '/HORA
704     Call HandleServerTime(Message, UserIndex)

706 Case ClientPacketID.Where        '/DONDE
708     Call HandleWhere(Message, UserIndex)

710 Case ClientPacketID.CreaturesInMap        '/NENE
712     Call HandleCreaturesInMap(Message, UserIndex)

714 Case ClientPacketID.WarpMeToTarget        '/TELEPLOC
716     Call HandleWarpMeToTarget(Message, UserIndex)

718 Case ClientPacketID.WarpChar        '/TELEP
720     Call HandleWarpChar(Message, UserIndex)

722 Case ClientPacketID.Silence        '/SILENCIAR
724     Call HandleSilence(Message, UserIndex)

726 Case ClientPacketID.SOSShowList        '/SHOW SOS
728     Call HandleSOSShowList(Message, UserIndex)

730 Case ClientPacketID.SOSRemove        'SOSDONE
732     Call HandleSOSRemove(Message, UserIndex)

734 Case ClientPacketID.GoToChar        '/IRA
736     Call HandleGoToChar(Message, UserIndex)

738 Case ClientPacketID.invisible        '/INVISIBLE
740     Call HandleInvisible(Message, UserIndex)

742 Case ClientPacketID.GMPanel        '/PANELGM
744     Call HandleGMPanel(Message, UserIndex)

746 Case ClientPacketID.RequestUserList        'LISTUSU
748     Call HandleRequestUserList(Message, UserIndex)

750 Case ClientPacketID.Working        '/TRABAJANDO
752     Call HandleWorking(Message, UserIndex)

754 Case ClientPacketID.KillNPC        '/RMATA
756     Call HandleKillNPC(Message, UserIndex)

758 Case ClientPacketID.Penar        '/PENAR
760     Call HandlePenar(Message, UserIndex)

762 Case ClientPacketID.EditChar        '/MOD
764     Call HandleEditChar(Message, UserIndex)

766 Case ClientPacketID.RequestCharInfo        '/INFO
768     Call HandleRequestCharInfo(Message, UserIndex)

770 Case ClientPacketID.RequestCharStats        '/STAT
772     Call HandleRequestCharStats(Message, UserIndex)

774 Case ClientPacketID.RequestCharGold        '/BAL
776     Call HandleRequestCharGold(Message, UserIndex)

778 Case ClientPacketID.RequestCharInventory        '/INV
780     Call HandleRequestCharInventory(Message, UserIndex)

782 Case ClientPacketID.RequestCharBank        '/BOV
784     Call HandleRequestCharBank(Message, UserIndex)

786 Case ClientPacketID.RequestCharSkills        '/SKILLS
788     Call HandleRequestCharSkills(Message, UserIndex)

790 Case ClientPacketID.ReviveChar        '/REVIVIR
792     Call HandleReviveChar(Message, UserIndex)

794 Case ClientPacketID.OnlineGM        '/ONLINEGM
796     Call HandleOnlineGM(Message, UserIndex)

798 Case ClientPacketID.OnlineMap        '/ONLINEMAP
800     Call HandleOnlineMap(Message, UserIndex)

802 Case ClientPacketID.Forgive        '/PERDON
804     Call HandleForgive(Message, UserIndex)

806 Case ClientPacketID.Kick        '/ECHAR
808     Call HandleKick(Message, UserIndex)

810 Case ClientPacketID.Execute        '/EJECUTAR
812     Call HandleExecute(Message, UserIndex)

814 Case ClientPacketID.BanChar        '/BAN
816     Call HandleBanChar(Message, UserIndex)

818 Case ClientPacketID.UnbanChar        '/UNBAN
820     Call HandleUnbanChar(Message, UserIndex)

822 Case ClientPacketID.NPCFollow        '/SEGUIR
824     Call HandleNPCFollow(Message, UserIndex)

826 Case ClientPacketID.SummonChar        '/SUM
828     Call HandleSummonChar(Message, UserIndex)

830 Case ClientPacketID.SpawnListRequest        '/CC
832     Call HandleSpawnListRequest(Message, UserIndex)

834 Case ClientPacketID.SpawnCreature        'SPA
836     Call HandleSpawnCreature(Message, UserIndex)

838 Case ClientPacketID.ResetNPCInventory        '/RESETINV
840     Call HandleResetNPCInventory(Message, UserIndex)

842 Case ClientPacketID.CleanWorld        '/LIMPIAR
844     Call HandleCleanWorld(Message, UserIndex)

846 Case ClientPacketID.ServerMessage        '/RMSG
848     Call HandleServerMessage(Message, UserIndex)

850 Case ClientPacketID.NickToIP        '/NICK2IP
852     Call HandleNickToIP(Message, UserIndex)

854 Case ClientPacketID.IPToNick        '/IP2NICK
856     Call HandleIPToNick(Message, UserIndex)

858 Case ClientPacketID.GuildOnlineMembers        '/ONCLAN
860     Call HandleGuildOnlineMembers(Message, UserIndex)

862 Case ClientPacketID.TeleportCreate        '/CT
864     Call HandleTeleportCreate(Message, UserIndex)

866 Case ClientPacketID.TeleportDestroy        '/DT
868     Call HandleTeleportDestroy(Message, UserIndex)

870 Case ClientPacketID.RainToggle        '/LLUVIA
872     Call HandleRainToggle(Message, UserIndex)

874 Case ClientPacketID.SetCharDescription        '/SETDESC
876     Call HandleSetCharDescription(Message, UserIndex)

878 Case ClientPacketID.ForceMIDIToMap        '/FORCEMIDIMAP
880     Call HanldeForceMIDIToMap(Message, UserIndex)

882 Case ClientPacketID.ForceWAVEToMap        '/FORCEWAVMAP
884     Call HandleForceWAVEToMap(Message, UserIndex)

886 Case ClientPacketID.RoyalArmyMessage        '/REALMSG
888     Call HandleRoyalArmyMessage(Message, UserIndex)

890 Case ClientPacketID.ChaosLegionMessage        '/CAOSMSG
892     Call HandleChaosLegionMessage(Message, UserIndex)

894 Case ClientPacketID.CitizenMessage        '/CIUMSG
896     Call HandleCitizenMessage(Message, UserIndex)

898 Case ClientPacketID.CriminalMessage        '/CRIMSG
900     Call HandleCriminalMessage(Message, UserIndex)

902 Case ClientPacketID.TalkAsNPC        '/TALKAS
904     Call HandleTalkAsNPC(Message, UserIndex)

906 Case ClientPacketID.DestroyAllItemsInArea        '/MASSDEST
908     Call HandleDestroyAllItemsInArea(Message, UserIndex)

910 Case ClientPacketID.AcceptRoyalCouncilMember        '/ACEPTCONSE
912     Call HandleAcceptRoyalCouncilMember(Message, UserIndex)

914 Case ClientPacketID.AcceptChaosCouncilMember        '/ACEPTCONSECAOS
916     Call HandleAcceptChaosCouncilMember(Message, UserIndex)

918 Case ClientPacketID.ItemsInTheFloor        '/PISO
920     Call HandleItemsInTheFloor(Message, UserIndex)

922 Case ClientPacketID.MakeDumb        '/ESTUPIDO
924     Call HandleMakeDumb(Message, UserIndex)

926 Case ClientPacketID.MakeDumbNoMore        '/NOESTUPIDO
928     Call HandleMakeDumbNoMore(Message, UserIndex)

930 Case ClientPacketID.CouncilKick        '/KICKCONSE
932     Call HandleCouncilKick(Message, UserIndex)

934 Case ClientPacketID.SetTrigger        '/TRIGGER
936     Call HandleSetTrigger(Message, UserIndex)

938 Case ClientPacketID.AskTrigger        '/TRIGGER with no args
940     Call HandleAskTrigger(Message, UserIndex)

942 Case ClientPacketID.BannedIPList        '/BANIPLIST
944     Call HandleBannedIPList(Message, UserIndex)

946 Case ClientPacketID.BannedIPReload        '/BANIPRELOAD
948     Call HandleBannedIPReload(Message, UserIndex)

950 Case ClientPacketID.GuildMemberList        '/MIEMBROSCLAN
952     Call HandleGuildMemberList(Message, UserIndex)

954 Case ClientPacketID.GuildBan        '/BANCLAN
956     Call HandleGuildBan(Message, UserIndex)

958 Case ClientPacketID.BANIP        '/BANIP
960     Call HandleBanIP(Message, UserIndex)

962 Case ClientPacketID.UnbanIP        '/UNBANIP
964     Call HandleUnbanIP(Message, UserIndex)

966 Case ClientPacketID.CreateItem        '/CI
968     Call HandleCreateItem(Message, UserIndex)

970 Case ClientPacketID.DestroyItems        '/DEST
972     Call HandleDestroyItems(Message, UserIndex)

974 Case ClientPacketID.ChaosLegionKick        '/NOCAOS
976     Call HandleChaosLegionKick(Message, UserIndex)

978 Case ClientPacketID.RoyalArmyKick        '/NOREAL
980     Call HandleRoyalArmyKick(Message, UserIndex)

982 Case ClientPacketID.ForceMIDIAll        '/FORCEMIDI
984     Call HandleForceMIDIAll(Message, UserIndex)

986 Case ClientPacketID.ForceWAVEAll        '/FORCEWAV
988     Call HandleForceWAVEAll(Message, UserIndex)

990 Case ClientPacketID.RemovePunishment        '/BORRARPENA
992     Call HandleRemovePunishment(Message, UserIndex)

994 Case ClientPacketID.TileBlockedToggle        '/BLOQ
996     Call HandleTileBlockedToggle(Message, UserIndex)

998 Case ClientPacketID.KillNPCNoRespawn        '/MATA
1000    Call HandleKillNPCNoRespawn(Message, UserIndex)

1002 Case ClientPacketID.KillAllNearbyNPCs        '/MASSKILL
1004    Call HandleKillAllNearbyNPCs(Message, UserIndex)

1006 Case ClientPacketID.LastIP        '/LASTIP
1008    Call HandleLastIP(Message, UserIndex)

1010 Case ClientPacketID.SystemMessage        '/SMSG
1012    Call HandleSystemMessage(Message, UserIndex)

1014 Case ClientPacketID.CreateNPC        '/ACC
1016    Call HandleCreateNPC(Message, UserIndex)

1018 Case ClientPacketID.CreateNPCWithRespawn        '/RACC
1020    Call HandleCreateNPCWithRespawn(Message, UserIndex)

1022 Case ClientPacketID.ServerOpenToUsersToggle        '/HABILITAR
1024    Call HandleServerOpenToUsersToggle(Message, UserIndex)

1026 Case ClientPacketID.TurnCriminal        '/CONDEN
1028    Call HandleTurnCriminal(Message, UserIndex)

1030 Case ClientPacketID.ResetFactions        '/RAJAR
1032    Call HandleResetFactions(Message, UserIndex)

1034 Case ClientPacketID.RemoveCharFromGuild        '/RAJARCLAN
1036    Call HandleRemoveCharFromGuild(Message, UserIndex)

1038 Case ClientPacketID.RequestCharMail        '/LASTEMAIL
1040    Call HandleRequestCharMail(Message, UserIndex)

1042 Case ClientPacketID.AlterPassword        '/APASS
1044    Call HandleAlterPassword(Message, UserIndex)

1046 Case ClientPacketID.AlterMail        '/AEMAIL
1048    Call HandleAlterMail(Message, UserIndex)

1050 Case ClientPacketID.AlterName        '/ANAME
1052    Call HandleAlterName(Message, UserIndex)

1054 Case ClientPacketID.ToggleCentinelActivated        '/CENTINELAACTIVADO
1056    Call HandleToggleCentinelActivated(Message, UserIndex)

1058 Case ClientPacketID.DoBackUp        '/DOBACKUP
1060    Call HandleDoBackUp(Message, UserIndex)

1062 Case ClientPacketID.ShowGuildMessages        '/SHOWCMSG
1064    Call HandleShowGuildMessages(Message, UserIndex)

1066 Case ClientPacketID.SaveMap        '/GUARDAMAPA
1068    Call HandleSaveMap(Message, UserIndex)

1070 Case ClientPacketID.ChangeMapInfoPK        '/MODMAPINFO PK
1072    Call HandleChangeMapInfoPK(Message, UserIndex)

1074 Case ClientPacketID.ChangeMapInfoBackup        '/MODMAPINFO BACKUP
1076    Call HandleChangeMapInfoBackup(Message, UserIndex)

1078 Case ClientPacketID.ChangeMapInfoRestricted        '/MODMAPINFO RESTRINGIR
1080    Call HandleChangeMapInfoRestricted(Message, UserIndex)

1082 Case ClientPacketID.ChangeMapInfoNoMagic        '/MODMAPINFO MAGIASINEFECTO
1084    Call HandleChangeMapInfoNoMagic(Message, UserIndex)

1086 Case ClientPacketID.ChangeMapInfoNoInvi        '/MODMAPINFO INVISINEFECTO
1088    Call HandleChangeMapInfoNoInvi(Message, UserIndex)

1090 Case ClientPacketID.ChangeMapInfoNoResu        '/MODMAPINFO RESUSINEFECTO
1092    Call HandleChangeMapInfoNoResu(Message, UserIndex)

    Case ClientPacketID.ChangeMapInfoNoInvocar        '/MODMAPINFO INVOCARSINEFECTO
        Call HandleChangeMapInfoNoInvocar(Message, UserIndex)

1094 Case ClientPacketID.ChangeMapInfoLand        '/MODMAPINFO TERRENO
1096    Call HandleChangeMapInfoLand(Message, UserIndex)

1098 Case ClientPacketID.ChangeMapInfoZone        '/MODMAPINFO ZONA
1100    Call HandleChangeMapInfoZone(Message, UserIndex)

1102 Case ClientPacketID.SaveChars        '/GRABAR
1104    Call HandleSaveChars(Message, UserIndex)

1106 Case ClientPacketID.CleanSOS        '/BORRAR SOS
1108    Call HandleCleanSOS(Message, UserIndex)

1110 Case ClientPacketID.ShowServerForm        '/SHOW INT
1112    Call HandleShowServerForm(Message, UserIndex)

1114 Case ClientPacketID.KickAllChars        '/ECHARTODOSPJS
1116    Call HandleKickAllChars(Message, UserIndex)

1118 Case ClientPacketID.ReloadNPCs        '/RELOADNPCS
1120    Call HandleReloadNPCs(Message, UserIndex)

1122 Case ClientPacketID.ReloadServerIni        '/RELOADSINI
1124    Call HandleReloadServerIni(Message, UserIndex)

1126 Case ClientPacketID.ReloadSpells        '/RELOADHECHIZOS
1128    Call HandleReloadSpells(Message, UserIndex)

11301 Case ClientPacketID.ReloadObjects        '/RELOADOBJ
11132   Call HandleReloadObjects(Message, UserIndex)

1134 Case ClientPacketID.ChatColor        '/CHATCOLOR
1136    Call HandleChatColor(Message, UserIndex)

11368 Case ClientPacketID.Ignored        '/IGNORADO
11450   Call HandleIgnored(Message, UserIndex)

1142 Case ClientPacketID.Conteo
1144    Call HandleConteo(Message, UserIndex)

    Case ClientPacketID.FUN_PjFUll
        Call HandleFUN_PjFull(Message, UserIndex)

    Case ClientPacketID.FUN_GMFUll
        Call HandleFUN_GMFull(Message, UserIndex)

    Case ClientPacketID.ResetChar
        Call HandleResetChar(Message, UserIndex)

    Case ClientPacketID.SendReto3vs3
        Call HandleSendReto3vs3(Message, UserIndex)

    Case ClientPacketID.BorrarPj
        Call HandleBorrarPj(Message, UserIndex)

    Case ClientPacketID.BorrarMensajeConsola
        Call HandleBorrarMensajeConsola(Message, UserIndex)

    Case ClientPacketID.ChangeMapInfoMusic
        Call HandleChangeMapInfoMusic(Message, UserIndex)

3730 Case ClientPacketID.MenuClient
3740    Call HandleMenuClient(Message, UserIndex)


1146 Case Else
        'ERROR : Abort!
1148    Call LogError("IncomingData Else - PacketID " & PacketID & ". " & UserList(UserIndex).Name & " (" & UserList(UserIndex).IP & ")")
        Call CloseSocket(UserIndex)    'Err.Raise -1, "Invalid Message"

    End Select

    ' If (Message.GetAvailable() > 0) Then
    '     'Call LogError("HandleIncomingData PacketError ID '" & PacketId & "' - Extra bytes:'" & message.GetAvailable() & "' - Usuario: '" & UserList(UserIndex).Name & "' - ID:" & UserList(UserIndex).ID & " - IP: " & UserList(UserIndex).IP & " - IdleCount:" & UserList(UserIndex).Counters.IdleCount)
    '     Err.Raise &HDEADBEEF, "HandleIncomingData", "PacketError ID '" & PacketId & "' - Extra bytes:'" & Message.GetAvailable() & "' - Usuario: '" & UserList(userindex).Name & "' - ID:" & UserList(userindex).ID & " - IP: " & UserList(userindex).IP & " - IdleCount:" & UserList(userindex).Counters.IdleCount
    'End If


    If Err.Number <> 0 Then
        'An error ocurred, log it and kick player.
        Call LogError("Error: " & Err.Number & " [" & Err.Description & "] " & " Source: " & Err.source & vbTab & " HelpFile: " & Err.HelpFile & vbTab & " HelpContext: " & Err.HelpContext & vbTab & " LastDllError: " & Err.LastDllError & vbTab & " - UserIndex: " & UserIndex & "(" & UserList(UserIndex).Name & ") - producido al manejar el paquete: " & CStr(PacketID))
        Call CloseSocket(UserIndex)

        Err.Clear
    End If

    'HandleIncomingData_Err:

    '1156 Set Reader = Nothing

    '1158 If Err.Number <> 0 Then
    '11690   Call LogError("Error HandleIncomingData - PackedID: " & PacketId & " - " & IIf(UserList(userindex).flags.UserLogged, "UserName: " & UserList(userindex).Name, "UserIndex: " & userindex) & ", en " & Erl & ". err: " & Err.Number & " " & Err.Description & ". Extra bytes:'" & Message.GetAvailable())

    '11064   Call CloseSocket(userindex)
    '1166    HandleIncomingData = False

    '   End If

End Sub

Public Sub HandleWebData(ByVal UserIndex As Integer, ByVal Alldata As String)
7656
7787 On Error GoTo Errhandler

666 Dim Data() As String

667 Dim Data_incompleta As Boolean

100 Data = Split(Alldata, "|")

102 Data_incompleta = True

    If frmMain.chkwebSystem.value = 0 Then
        Call EnviarDatosASlot(UserIndex, "Web desactivada")
        Call FlushBuffer(UserIndex)

        Call WSApiCloseSocket(WebUserList(UserIndex).ConnectionID, UserIndex)
        WebUserList(UserIndex).ConnectionIDValida = False
        WebUserList(UserIndex).ConnectionID = -1
        Exit Sub
    End If

    If UBound(Data) <= 1 Then Exit Sub

104 Select Case val(Data(1))

    Case 1

106     If UBound(Data) = 6 Then        'finished.
108         Call m_Cuentas.echarPjCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))
110         Data_incompleta = False

        End If

112 Case 2

114     If UBound(Data) = 8 Then        'finished.
116         Call m_Cuentas.AgregarPjACuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(8))
118         Data_incompleta = False

        End If

120 Case 3

122     If UBound(Data) = 9 Then       'finished.
124         Call m_MercadoAO.MAO_ComprarPjPorOro(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(8), Data(9))  ' por Monedas de oro
            Data_incompleta = False
        End If

126 Case 4
        If UBound(Data) = 9 Then
            Call m_MercadoAO.MAO_CambiarPj(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(8), Data(9))
            Data_incompleta = False
        End If
132 Case 5

134     If UBound(Data) = 4 Then    ' que manda esto?
136         Call m_Cuentas.CambiarContraseñaCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5))
138         Data_incompleta = False
        End If

140 Case 6

142     If UBound(Data) = 6 Then        'finished.
144         Call m_Cuentas.QuitarPjCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))
146         Data_incompleta = False
        End If

148 Case 7
        'Intento chequear pin

150 Case 8

152     If UBound(Data) = 7 Then        'finished.
154         Call m_Cuentas.CrearCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7))
156         Data_incompleta = False
        End If

158 Case 9

160     If UBound(Data) = 6 Then
162         Call m_Cuentas.BloquearPjCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))
164         Data_incompleta = False
        End If

166 Case 10

168     If UBound(Data) = 9 Then
170         Call m_MercadoAO.MAO_CrearPublicacion(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(8), Data(9))   'Crear MAO web
172         Data_incompleta = False
        End If

174 Case 11
        If UBound(Data) = 10 Then
            Call m_Cuentas.IntercambiarItems(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(8), Data(9), Data(10))
            Data_incompleta = False
        End If

182 Case 12



190 Case 13


198 Case 14

200     If UBound(Data) = 6 Then
202         Call m_MercadoAO.MAO_EliminarPublicacion(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))
204         Data_incompleta = False
        End If

206 Case 15

208     If UBound(Data) = 6 Then
210         Call m_Cuentas.CambiarContraseñaChar(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))        'Cambio pass - forzado!!!
212         Data_incompleta = False
        End If

213 Case 16

214     If UBound(Data) = 5 Then
215         Call m_Cuentas.ASKCambiarContraseñaChar(UserIndex, Data(2), Data(3), Data(4), Data(5))        'Cambio pass - forzado!!!
216         Data_incompleta = False
        End If

2177 Case 17

2147    If UBound(Data) = 6 Then
2157        Call m_Cuentas.BorrarPjCuenta(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6))       'Cambio pass - forzado!!!
2167        Data_incompleta = False
        End If

2178 Case 18

2149    If UBound(Data) = 7 Then
2158        Call m_Cuentas.ComprarProducto(UserIndex, Data(2), Data(3), Data(4), Data(5), Data(6), Data(7), Data(7))      'Cambio pass - forzado!!!
2168        Data_incompleta = False
        End If


    End Select

217 If Data_incompleta Then
218     Debug.Print Now, "HandleWebData:", " agregar numerito", Alldata

    End If

668 Call FlushBuffer(UserIndex)

669 Call WSApiCloseSocket(WebUserList(UserIndex).ConnectionID, UserIndex)
898 WebUserList(UserIndex).ConnectionIDValida = False
909 WebUserList(UserIndex).ConnectionID = -1

    'Call CloseSocket(userindex)

Errhandler:

    Dim Error As Long

    Error = Err.Number

    If Error <> 0 Then
        Call LogError("error en HandleWebData en " & Erl & ". " & Err.Number & " " & Err.Description)
        Err.Raise Error
    End If

End Sub

Private Sub HandleLoginExistingChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleLoginExistingChar_Err

    Dim UserName As String
    Dim Password As String
    Dim version As String
    Dim serialHD As Long

100 UserName = Message.ReadString16()

102 Password = Message.ReadString16()

103 serialHD = val(Message.ReadString16)

    'Convert version number to string
104 version = CStr(Message.ReadInt()) & "." & CStr(Message.ReadInt()) & "." & CStr(Message.ReadInt())

106 UserName = Trim$(UserName)
108 Password = Trim$(Password)

110 If Not AsciiValidos(UserName) Then
112     Call WriteErrorMsg(UserIndex, "Nombre inválido.")
        'Call Flushbuffer(UserIndex)
        '114     Call CloseSocket(UserIndex)
        Exit Sub
    End If

116 If LenB(Password) < 3 Then
118     Call WriteErrorMsg(UserIndex, "Contraseña inválida.")
        'Call Flushbuffer(UserIndex)
        '120     Call CloseSocket(UserIndex)
        Exit Sub
    End If

122 If Not PersonajeExiste(UserName) Then
124     Call WriteErrorMsg(UserIndex, "El personaje no existe.")
        'Call Flushbuffer(UserIndex)
        '126     Call CloseSocket(UserIndex)
        Exit Sub
    End If

128 If val(GetVar(CharPath & UserName & ".chr", "FLAGS", "char_locked_in_mao")) > 0 Then
130     Call WriteErrorMsg(UserIndex, "Tu personaje está modo candado.")
        'Call Flushbuffer(UserIndex)
        '132     Call CloseSocket(UserIndex)
        Exit Sub
    End If

134 If val(GetVar(CharPath & UserName & ".chr", "FLAGS", "char_locked")) > 0 Then
136     Call WriteErrorMsg(UserIndex, "El personaje se encuentra bloqueado. Debes desbloquearlo entrando a tu cuenta premium.")
        'Call Flushbuffer(UserIndex)
        '138     Call CloseSocket(UserIndex)
        Exit Sub
    End If

140 If BANCheck(UserName) Or BanHD_Find(serialHD) > 0 Then
Debug.Print "TODO"
        Dim UNBAN_DATE As String

142     UNBAN_DATE = GetVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE")

144     If Len(UNBAN_DATE) > 0 Then
146         If DateDiff("d", Now, UNBAN_DATE) > 0 Then
148             Call WriteErrorMsg(UserIndex, "Tu personaje se encuentra baneado hasta la fecha" & vbNewLine & UNBAN_DATE & vbNewLine & "Faltan: " & DateDiff("d", Now, UNBAN_DATE) & " día/s")
            Else
150             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", "")
152             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "BAN", 0)
154             Call ConnectUser(UserIndex, UserName, Password, serialHD)

            End If

        Else
156         Call WriteErrorMsg(UserIndex, "Se te ha prohibido la entrada a TDS Legacy." & vbNewLine & "Motivo:" & GetVar(CharPath & UserName & ".chr", "PENAS", "BanMotivo"))

        End If

158 ElseIf Not VersionOK(version) Then
    Debug.Print "TODO"
160     Call WriteErrorMsg(UserIndex, "Ejecuta el updater")
    Else
        
162     Call ConnectUser(UserIndex, UserName, Password, serialHD)

    End If

    Exit Sub
HandleLoginExistingChar_Err:
164 Call LogError("TDSLegacy.Protocol.HandleLoginExistingChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleThrowDices(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleThrowDices_Err

    With UserList(UserIndex).Stats
        If CONFIG_INI_RANDOMDICES = 1 Then
            .UserAtributos(eAtributos.Fuerza) = RandomNumber(16, 18)
            .UserAtributos(eAtributos.Agilidad) = RandomNumber(16, 18)
            .UserAtributos(eAtributos.Inteligencia) = RandomNumber(16, 18)
            .UserAtributos(eAtributos.Carisma) = RandomNumber(16, 18)
            .UserAtributos(eAtributos.Constitucion) = RandomNumber(16, 18)
        Else
            .UserAtributos(eAtributos.Fuerza) = 18
            .UserAtributos(eAtributos.Agilidad) = 18
            .UserAtributos(eAtributos.Inteligencia) = 18
            .UserAtributos(eAtributos.Carisma) = 18
            .UserAtributos(eAtributos.Constitucion) = 18
        End If
    End With

112 Call WriteDiceRoll(UserIndex)

    Exit Sub
HandleThrowDices_Err:
114 Call LogError("TDSLegacy.Protocol.HandleThrowDices en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleLoginNewChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleLoginNewChar_Err

    Dim UserName As String
    Dim Password As String
    Dim version As String
    Dim race As eRaza
    Dim gender As eGenero
    Dim Class As eClass
    Dim mail As String
    Dim Pin As String
    Dim Homeland As Integer
    Dim skillsasignados As String
    Dim CierraConexion As Boolean
    Dim serialHD As Long

118 UserName = Message.ReadString16

120 Password = Message.ReadString16

121 serialHD = val(Message.ReadString16)

    'Convert version number to string
122 version = CStr(Message.ReadInt) & "." & CStr(Message.ReadInt) & "." & CStr(Message.ReadInt)

124 race = Message.ReadInt
126 gender = Message.ReadInt
128 Class = Message.ReadInt
130 mail = Message.ReadString16
132 Homeland = Message.ReadInt
134 Pin = Message.ReadString16
136 skillsasignados = Message.ReadString16


100 If PuedeCrearPersonajes = 0 Then
102     Call WriteErrorMsg(UserIndex, "La creación de personajes en este server se ha deshabilitado.")
        'Call Flushbuffer(UserIndex)
104     Call CloseSocket(UserIndex)
        Exit Sub
    End If

106 If ServerSoloGMs <> 0 Then
108     Call WriteErrorMsg(UserIndex, "Servidor restringido a administradores. Consulte la página oficial o el foro oficial para más información.")
        'Call Flushbuffer(UserIndex)
110     Call CloseSocket(UserIndex)
        Exit Sub
    End If

112 If aClon.MaxPersonajes(UserList(UserIndex).IP) Then
114     Call WriteErrorMsg(UserIndex, "Has creado demasiados personajes.")
        'Call Flushbuffer(UserIndex)
116     Call CloseSocket(UserIndex)
        Exit Sub
    End If


138 If Not NombrePermitido(UserName) Then
140     Call WriteErrorMsg(UserIndex, "Los nombres de los personajes deben pertencer a la fantasia, el nombre indicado es invalido")
        'Call Flushbuffer(UserIndex)
142     Call CloseSocket(UserIndex)
    ElseIf BanHD_Find(serialHD) > 0 Then
        Call CloseSocket(UserIndex)
144 ElseIf Not VersionOK(version) Then
146     Call WriteErrorMsg(UserIndex, "Esta versión del juego es obsoleta.")
        'Call Flushbuffer(UserIndex)
148     Call CloseSocket(UserIndex)
    Else
150     If Not ConnectNewUser(UserIndex, UserName, Password, race, gender, Class, mail, Pin, Homeland, skillsasignados, CierraConexion, serialHD) Then
            If CierraConexion Then
                Call CloseSocket(UserIndex)
            End If
        End If

    End If

    Exit Sub

HandleLoginNewChar_Err:
152 Call LogError("TDSLegacy.Protocol.HandleLoginNewChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTalk(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTalk_Err

    Dim Chat As String

102 Chat = Message.ReadString16()


104 If UserList(UserIndex).flags.Privilegios = PlayerType.SemiDios Or UserList(UserIndex).flags.Privilegios = PlayerType.Consejero Or UserList(UserIndex).flags.Privilegios = PlayerType.RoleMaster Then
106     Call LogGM(UserList(UserIndex).Name, "Dijo: " & Chat)
    End If

    'I see you....
108 If UserList(UserIndex).flags.oculto > 0 Then
110     UserList(UserIndex).flags.oculto = 0
112     UserList(UserIndex).Counters.TiempoOculto = 0

114     If UserList(UserIndex).flags.Navegando = 1 Then
116         If UserList(UserIndex).Clase = eClass.Pirat Then
                ' Pierde la apariencia de fragata fantasmal
118             Call ToogleBoatBody(UserIndex)
120             Call WriteMensajes(UserIndex, Mensaje_408)
122             Call ChangeUserChar(UserIndex, UserList(UserIndex).Char.body, UserList(UserIndex).Char.Head, UserList(UserIndex).Char.Heading, NingunArma, NingunEscudo, NingunCasco)

            End If

        Else

124         If UserList(UserIndex).flags.invisible = 0 Then
126             Call UsUaRiOs.SetInvisible(UserIndex, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.invisible = 1, UserList(UserIndex).flags.oculto = 1)
128             WriteMensajes UserIndex, e_Mensajes.Mensaje_23

            End If

        End If

    End If

130 If LenB(Chat) <> 0 Then
        'Analize chat...
132     Call Statistics.ParseChat(Chat)
134     Call CleanString(Chat)

        If UserList(UserIndex).flags.EnEvento = 3 Then
            Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead(Chat, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.ChatColor))
            Exit Sub
        End If

136     If Not (UserList(UserIndex).flags.AdminInvisible = 1) Then
138         If UserList(UserIndex).flags.Muerto = 1 Then
140             Call SendData(SendTarget.ToDeadArea, UserIndex, PrepareMessageChatOverHead(Chat, UserList(UserIndex).Char.CharIndex, CHAT_COLOR_DEAD_CHAR))
            Else
142             Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(Chat, UserList(UserIndex).Char.CharIndex, UserList(UserIndex).flags.ChatColor))

            End If

        Else

144         If RTrim(Chat) <> "" Then
146             Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageConsoleMsg("Gm> " & Chat, FontTypeNames.FONTTYPE_GM))

            End If

        End If

    End If


    Exit Sub
HandleTalk_Err:
148 Call LogError("TDSLegacy.Protocol.HandleTalk en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleYell(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleYell_Err

100 With UserList(UserIndex)

        Dim Chat As String

102     Chat = Message.ReadString16()

        '[Consejeros & GMs]
104     If .flags.Privilegios = PlayerType.Consejero Or .flags.Privilegios = PlayerType.SemiDios Then
106         Call LogGM(.Name, "Grito: " & Chat)

        End If

        'I see you....
108     If .flags.oculto > 0 Then
110         .flags.oculto = 0
112         .Counters.TiempoOculto = 0

114         If .flags.Navegando = 1 Then
116             If .Clase = eClass.Pirat Then
                    ' Pierde la apariencia de fragata fantasmal
118                 Call ToogleBoatBody(UserIndex)
120                 Call WriteMensajes(UserIndex, Mensaje_408)
122                 Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)

                End If

            Else

124             If .flags.invisible = 0 Then
126                 Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
128                 WriteMensajes UserIndex, e_Mensajes.Mensaje_23

                End If

            End If

        End If

130     If LenB(Chat) <> 0 Then

            'Analize chat...
132         Call Statistics.ParseChat(Chat)
134         Call CleanString(Chat)

            If .flags.EnEvento = 3 Then
                Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead(Chat, .Char.CharIndex, CHAT_COLOR_GM_YELL))
                Exit Sub
            End If

136         If .flags.Privilegios < PlayerType.Consejero Then
138             If UserList(UserIndex).flags.Muerto = 1 Then
140                 Call SendData(SendTarget.ToDeadArea, UserIndex, PrepareMessageChatOverHead(Chat, .Char.CharIndex, CHAT_COLOR_DEAD_CHAR))
                Else
142                 Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(Chat, .Char.CharIndex, vbRed))

                End If

            Else

144             If Not (.flags.AdminInvisible = 1) Then
146                 Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead(Chat, .Char.CharIndex, CHAT_COLOR_GM_YELL))
                Else
148                 Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageConsoleMsg("Gm> " & Chat, FontTypeNames.FONTTYPE_GM))

                End If

            End If

        End If

    End With

    Exit Sub
HandleYell_Err:
150 Call LogError("TDSLegacy.Protocol.HandleYell en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Function CharIndexToUserIndex(ByVal CharIndex As Integer) As Integer
100 CharIndexToUserIndex = CharList(CharIndex)

102 If CharIndexToUserIndex < 1 Or CharIndexToUserIndex > maxUsers Then
104     CharIndexToUserIndex = 0
        Exit Function

    End If

106 If UserList(CharIndexToUserIndex).Char.CharIndex <> CharIndex Then
108     CharIndexToUserIndex = 0
        Exit Function

    End If

End Function

Private Sub HandleWhisper(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWhisper_Err

100 With UserList(UserIndex)

        Dim Chat As String

        Dim targetCharIndex As Integer

        Dim TargetUserIndex As Integer

102     targetCharIndex = Message.ReadInt()
104     Chat = Message.ReadString16()

106     TargetUserIndex = CharIndexToUserIndex(targetCharIndex)

108     If .flags.Muerto Then
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_289)
        Else

112         If TargetUserIndex = 0 Then
114             Call WriteMensajes(UserIndex, Mensaje_50)
            Else

                'A los dioses y admins no vale susurrarles si no sos uno vos mismo (así no pueden ver si están conectados o no)
116             If UserList(TargetUserIndex).flags.Privilegios > .flags.Privilegios Then

                    ' Controlamos que no este invisible
118                 If UserList(TargetUserIndex).flags.AdminInvisible <> 1 Then
120                     WriteMensajes UserIndex, e_Mensajes.Mensaje_213

                    End If

122             ElseIf Not EstaPCarea(UserIndex, TargetUserIndex) Then
124                 WriteMensajes UserIndex, e_Mensajes.Mensaje_214
                Else

                    '[Consejeros & GMs]
126                 If .flags.Privilegios = PlayerType.Consejero Or .flags.Privilegios = PlayerType.SemiDios Then
128                     Call LogGM(.Name, "Le dijo a '" & UserList(TargetUserIndex).Name & "' " & Chat)

                    End If

130                 If LenB(Chat) <> 0 Then
                        'Analize chat...
132                     Call Statistics.ParseChat(Chat)
134                     Call CleanString(Chat)

                        If .flags.EnEvento = 3 Then
                            Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead("A " & UserList(TargetUserIndex).Name & "> " & Chat, .Char.CharIndex, vbYellow))
                            Exit Sub
                        End If

136                     If Not (.flags.AdminInvisible = 1) Then
138                         Call WriteChatOverHead(UserIndex, Chat, .Char.CharIndex, vbYellow)
140                         Call WriteChatOverHead(TargetUserIndex, Chat, .Char.CharIndex, vbYellow)
                            'Call Flushbuffer(TargetUserIndex)

                            '[CDT 17-02-2004]
142                         If .flags.Privilegios < PlayerType.Consejero Then
144                             Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead("A " & UserList(TargetUserIndex).Name & "> " & Chat, .Char.CharIndex, vbYellow))

                            End If

                        Else
146                         Call WriteConsoleMsg(UserIndex, "Susurraste> " & Chat, FontTypeNames.FONTTYPE_GM)

148                         If UserIndex <> TargetUserIndex Then Call WriteConsoleMsg(TargetUserIndex, "Gm susurra> " & Chat, FontTypeNames.FONTTYPE_GM)

150                         If .flags.Privilegios < PlayerType.Consejero Then
152                             Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageConsoleMsg("Gm dijo a " & UserList(TargetUserIndex).Name & "> " & Chat, FontTypeNames.FONTTYPE_GM))

                            End If

                        End If

                    End If

                End If

            End If

        End If

    End With

    Exit Sub
HandleWhisper_Err:
154 Call LogError("TDSLegacy.Protocol.HandleWhisper en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWalk(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWalk_Err

    Dim dummy As Long

    Dim TempTick As Long

    Dim Heading As eHeading

100 With UserList(UserIndex)

102     Heading = Message.ReadInt()

        If .flags.EnEvento = 2 Then
            If .flags.T2vs2.CurrentGroup <> 0 Then
                If iTorneo2vs2.Groups(.flags.T2vs2.CurrentGroup).CountDown <> 0 Then
                    Exit Sub
                End If
            End If
        End If

        If Centinela.RevisandoUserIndex = UserIndex Then
            Exit Sub
        End If

        Dim TiempoDeWalk As Byte

        If .flags.Muerto = 1 Then
            TiempoDeWalk = 36
        Else
            TiempoDeWalk = 30
        End If

        'Prevent SpeedHack
104     If .flags.TimesWalk >= TiempoDeWalk Then
106         TempTick = GetTickCount
108         dummy = (TempTick - .flags.StartWalk)

            ' 5800 is actually less than what would be needed in perfect conditions to take 30 steps
            '(it's about 193 ms per step against the over 200 needed in perfect conditions)
110         If dummy < 5800 Then
112             If TempTick - .flags.CountSH > 30000 Then
114                 .flags.CountSH = 0
                End If

116             If Not .flags.CountSH = 0 Then
118                 If dummy <> 0 Then dummy = 126000 \ dummy

120                 'Call LogHackAttemp("Tramposo SH: " & .Name & " , Dummy: " & dummy & ", UserTick: " & (TempTick - .flags.CountSH))
122                 Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("server> " & .Name & " ha sido echado por el server por posible uso de SH.", FontTypeNames.FONTTYPE_SERVER))
                    '124                 Call CloseSocket(userindex)
                    'Exit Sub
                Else
126                 .flags.CountSH = TempTick
                End If
            End If

128         .flags.StartWalk = TempTick
130         .flags.TimesWalk = 0

        End If

132     .flags.TimesWalk = .flags.TimesWalk + 1

        'If exiting, cancel
134     Call CancelExit(UserIndex)

136     If .flags.Meditando = True Then
138         WriteMensajes UserIndex, e_Mensajes.Mensaje_128

140         Call WriteMeditateToggle(UserIndex)
142         .flags.Meditando = False
144         .Char.FX = 0
146         .Char.loops = 0
148         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))

        End If

150     If .flags.Paralizado = 0 Then
152         If Not .flags.Meditando Then
                'Move user
154             Call MoveUserChar(UserIndex, Heading)

                'Stop resting if needed
156             If .flags.Descansar Then
158                 .flags.Descansar = False

160                 Call WriteRestOK(UserIndex)
162                 WriteMensajes UserIndex, e_Mensajes.Mensaje_215

                End If

            End If

        Else        'paralized

164         If Not .flags.UltimoMensaje = 1 Then
166             .flags.UltimoMensaje = 1
168             WriteMensajes UserIndex, e_Mensajes.Mensaje_217

            End If

170         .flags.CountSH = 0

        End If

        'Can't move while hidden except he is a thief
172     If .flags.oculto = 1 And .flags.AdminInvisible = 0 Then
174         If .Clase <> eClass.Thief Then
176             .flags.oculto = 0
178             .Counters.TiempoOculto = 0

180             If .flags.Navegando = 1 Then
182                 If .Clase = eClass.Pirat Then

184                     Call ToogleBoatBody(UserIndex)    ' Pierde la apariencia de fragata fantasmal
186                     Call WriteMensajes(UserIndex, Mensaje_404)
188                     Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
                    Else

                        If .flags.invisible = 0 Then
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_23
                            Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                        End If

                    End If

                Else
                    'If not under a spell effect, show char

                    ' Dim has_kz_armour As Boolean
                    ' If .Invent.ArmourEqpSlot > 0 Then
                    '     If .Invent.ArmourEqpObjIndex = 360 Or .Invent.ArmourEqpObjIndex = 612 Or .Invent.ArmourEqpObjIndex = 671 Then
                    '         has_kz_armour = True
                    '     End If
                    ' End If

                    ' If (.clase <> eClass.Hunter) Or (.clase = eClass.Hunter And Not has_kz_armour) Then
190                 If .flags.invisible = 0 Then
192                     WriteMensajes UserIndex, e_Mensajes.Mensaje_23
194                     Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)

                    End If

                    ' End If
                End If

            End If

        End If

    End With

    Exit Sub
HandleWalk_Err:
196 Call LogError("TDSLegacy.Protocol.HandleWalk en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestPositionUpdate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestPositionUpdate_Err

100 Call WritePosUpdate(UserIndex)

    Exit Sub
HandleRequestPositionUpdate_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestPositionUpdate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAttack(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleAttack_Err

100 With UserList(UserIndex)

        'If dead, can't attack
102     If .flags.Muerto = 1 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_292)
            Exit Sub

        End If

        'If user meditates, can't attack
106     If .flags.Meditando Then
            Exit Sub

        End If

108     If Not UserList(UserIndex).flags.ModoCombate Then
110         WriteMensajes UserIndex, e_Mensajes.Mensaje_218
            Exit Sub

        End If

        'If equiped weapon is ranged, can't attack this way
112     If .Invent.WeaponEqpObjIndex > 0 Then
114         If ObjData(.Invent.WeaponEqpObjIndex).proyectil = 1 Then

116             WriteMensajes UserIndex, e_Mensajes.Mensaje_219

                Exit Sub

            End If

        End If

        'If exiting, cancel
118     Call CancelExit(UserIndex)

        'Attack!
120     Call UsuarioAtaca(UserIndex)

        'Now you can be atacked
122     .flags.NoPuedeSerAtacado = False

        'I see you...
124     If .flags.oculto > 0 And .flags.AdminInvisible = 0 Then
126         .flags.oculto = 0
128         .Counters.TiempoOculto = 0

130         If .flags.Navegando = 1 Then
132             If .Clase = eClass.Pirat Then
                    ' Pierde la apariencia de fragata fantasmal
134                 Call ToogleBoatBody(UserIndex)
136                 Call WriteMensajes(UserIndex, Mensaje_407)

138                 Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, NingunArma, NingunEscudo, NingunCasco)
                Else
                    If .flags.invisible = 0 Then
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_23
                        Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
                    End If
                End If

            Else

140             If .flags.invisible = 0 Then
142                 Call UsUaRiOs.SetInvisible(UserIndex, .Char.CharIndex, .flags.invisible = 1, .flags.oculto = 1)
144                 WriteMensajes UserIndex, e_Mensajes.Mensaje_23

                End If

            End If

        End If

    End With

    Exit Sub
HandleAttack_Err:
146 Call LogError("TDSLegacy.Protocol.HandleAttack en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePickUp(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePickUp_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios < PlayerType.Admin Then

            'If dead, it can't pick up objects
104         If .flags.Muerto = 1 Then
106             WriteMensajes UserIndex, e_Mensajes.Mensaje_293
                Exit Sub

            End If

            'If user is trading items and attempts to pickup an item, he's cheating, so we kick him.
108         If .flags.Comerciando Then Exit Sub

            'Lower rank administrators can't pick up items
110         If .flags.Privilegios = PlayerType.Consejero Then
112             If Not .flags.Privilegios = PlayerType.RoleMaster Then
114                 WriteMensajes UserIndex, e_Mensajes.Mensaje_220
                    Exit Sub

                End If

            End If

        End If

116     Call GetObj(UserIndex)

    End With

    Exit Sub
HandlePickUp_Err:
118 Call LogError("TDSLegacy.Protocol.HandlePickUp en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSafeToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSafeToggle_Err

100 With UserList(UserIndex)

102     If .flags.Seguro Then
104         Call WriteMultiMessage(UserIndex, eMessages.SafeModeOff)        'Call WriteSafeModeOff(UserIndex)
        Else
106         Call WriteMultiMessage(UserIndex, eMessages.SafeModeOn)        'Call WriteSafeModeOn(UserIndex)

        End If

108     .flags.Seguro = Not .flags.Seguro

    End With

    Exit Sub
HandleSafeToggle_Err:
110 Call LogError("TDSLegacy.Protocol.HandleSafeToggle en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDragToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDragToggle_Err

100 With UserList(UserIndex)

102     If .flags.BlockDragItems Then
104         Call WriteMultiMessage(UserIndex, eMessages.SafeDragModeOff)
        Else
106         Call WriteMultiMessage(UserIndex, eMessages.SafeDragModeOn)

        End If

108     .flags.BlockDragItems = Not .flags.BlockDragItems

    End With

    Exit Sub
HandleDragToggle_Err:
110 Call LogError("TDSLegacy.Protocol.HandleDragToggle en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub HandlePing(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim Time As Long
    Time = Message.ReadInt
    
102 Call WritePong(UserIndex, Time)

End Sub

Private Sub HandleResuscitationToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleResuscitationToggle_Err

100 With UserList(UserIndex)

102     .flags.SeguroResu = Not .flags.SeguroResu

104     If .flags.SeguroResu Then
            '106         Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOn)        'Call WriteResuscitationSafeOn(UserIndex)
        Else
            '108         Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOff)        'Call WriteResuscitationSafeOff(UserIndex)

        End If

    End With

    Exit Sub
HandleResuscitationToggle_Err:
110 Call LogError("TDSLegacy.Protocol.HandleResuscitationToggle en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestGuildLeaderInfo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestGuildLeaderInfo_Err

100 Call modGuilds.SendGuildLeaderInfo(UserIndex)

    Exit Sub
HandleRequestGuildLeaderInfo_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestGuildLeaderInfo en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestAtributes(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestAtributes_Err

100 Call WriteAttributes(UserIndex)

    Exit Sub
HandleRequestAtributes_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestAtributes en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestFame(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestFame_Err

100 Call EnviarFama(UserIndex)

    Exit Sub
HandleRequestFame_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestFame en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestSkills(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestSkills_Err

100 Call WriteSendSkills(UserIndex)

    Exit Sub
HandleRequestSkills_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestSkills en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestMiniStats(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestMiniStats_Err

100 Call WriteMiniStats(UserIndex)

    Exit Sub
HandleRequestMiniStats_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestMiniStats en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCommerceEnd(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCommerceEnd_Err

    'User quits commerce mode
100 UserList(UserIndex).flags.Comerciando = False

102 If UserList(UserIndex).flags.commerce_npc_npcindex > 0 Then
104     Call NPCs.RemoveToNpcTradingArray(UserIndex)

    End If

106 Call WriteCommerceEnd(UserIndex)

    Exit Sub
HandleCommerceEnd_Err:
108 Call LogError("TDSLegacy.Protocol.HandleCommerceEnd en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUserCommerceEnd(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUserCommerceEnd_Err

100 With UserList(UserIndex)

        'Quits commerce mode with user
102     If .ComUsu.DestUsu > 0 Then
104         If UserList(.ComUsu.DestUsu).ComUsu.DestUsu = UserIndex Then
106             Call WriteConsoleMsg(.ComUsu.DestUsu, .Name & " ha dejado de comerciar con vos.", FontTypeNames.FONTTYPE_TALK)
108             Call FinComerciarUsu(.ComUsu.DestUsu)

                'Send data in the outgoing buffer of the other user
                'Call Flushbuffer(.ComUsu.DestUsu)
            End If

        End If

110     Call FinComerciarUsu(UserIndex)
112     Call WriteMensajes(UserIndex, Mensaje_420)

    End With

    Exit Sub
HandleUserCommerceEnd_Err:
114 Call LogError("TDSLegacy.Protocol.HandleUserCommerceEnd en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

''
' Handles the "UserCommerceConfirm" message.
'
' @param    userIndex The index of the user sending the message.
Private Sub HandleUserCommerceConfirm(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUserCommerceConfirm_Err

    'Validate the commerce
100 If PuedeSeguirComerciando(UserIndex) Then
        'Tell the other user the confirmation of the offer
102     Call WriteUserOfferConfirm(UserList(UserIndex).ComUsu.DestUsu)
104     UserList(UserIndex).ComUsu.Confirmo = True

    End If

    Exit Sub
HandleUserCommerceConfirm_Err:
106 Call LogError("TDSLegacy.Protocol.HandleUserCommerceConfirm en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCommerceChat(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCommerceChat_Err

100 With UserList(UserIndex)

        Dim Chat As String

102     Chat = Message.ReadString16()

104     If LenB(Chat) <> 0 Then
106         If PuedeSeguirComerciando(UserIndex) Then
                'Analize chat...
108             Call Statistics.ParseChat(Chat)
110             Call CleanString(Chat)
112             Chat = UserList(UserIndex).Name & "> " & Replace$(Chat, "~", "")
114             Call WriteCommerceChat(UserIndex, Chat, FontTypeNames.FONTTYPE_PARTY)
116             Call WriteCommerceChat(UserList(UserIndex).ComUsu.DestUsu, Chat, FontTypeNames.FONTTYPE_PARTY)

            End If

        End If

    End With

    Exit Sub
HandleCommerceChat_Err:
118 Call LogError("TDSLegacy.Protocol.HandleCommerceChat en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankEnd(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankEnd_Err

100 With UserList(UserIndex)
102     .flags.Comerciando = False
104     Call WriteBankEnd(UserIndex)

    End With

    Exit Sub
HandleBankEnd_Err:
106 Call LogError("TDSLegacy.Protocol.HandleBankEnd en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUserCommerceOk(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUserCommerceOk_Err

100 Call AceptarComercioUsu(UserIndex)

    Exit Sub
HandleUserCommerceOk_Err:
102 Call LogError("TDSLegacy.Protocol.HandleUserCommerceOk en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUserCommerceReject(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUserCommerceReject_Err

    Dim OtherUser As Integer

100 With UserList(UserIndex)
102     OtherUser = .ComUsu.DestUsu

        'Offer rejected
104     If OtherUser > 0 Then
106         If UserList(OtherUser).flags.UserLogged Then
108             Call WriteConsoleMsg(OtherUser, .Name & " ha rechazado tu oferta.", FontTypeNames.FONTTYPE_TALK)
110             Call FinComerciarUsu(OtherUser)

                'Send data in the outgoing buffer of the other user
                'Call Flushbuffer(otherUser)
            End If

        End If

112     WriteMensajes UserIndex, e_Mensajes.Mensaje_226

114     Call FinComerciarUsu(UserIndex)

    End With

    Exit Sub
HandleUserCommerceReject_Err:
116 Call LogError("TDSLegacy.Protocol.HandleUserCommerceReject en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDrop(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDrop_Err

    Dim Slot As Integer

    Dim Amount As Long

    Dim RandomKey As Integer

100 With UserList(UserIndex)

102     Slot = Message.ReadInt8
104     Amount = Message.ReadInt32
106     RandomKey = Message.ReadInt8

        If RandomKey = .mLastKeyDrop And .mLastKeyDrop > 0 And .mLastKeyDrop < 3 Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - uso de editor de paquetes - Tirar oro o item.", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " - Editor de paquetes - Drop oro o item.")
            Call CloseSocket(UserIndex)
            Exit Sub
        End If

        .mLastKeyDrop = RandomKey

        If .flags.EnEvento = 3 Then
            Call WriteConsoleMsg(UserIndex, "No puedes tirar objetos estando en éste evento.")
            Exit Sub
        End If

        If .mReto.Reto_Index > 0 Or .sReto.Reto_Index > 0 Then
            Call WriteConsoleMsg(UserIndex, "No puedes tirar objetos estando en retos.")
            Exit Sub
        End If

110     .Counters.Seguridad.Tirar = GetTickCount

        'low rank admins can't drop item. Neither can the dead nor those sailing.
112     If .flags.Navegando = 1 Or .flags.Muerto = 1 Or ((.flags.Privilegios = PlayerType.Consejero) <> 0 And (Not .flags.Privilegios = PlayerType.RoleMaster) <> 0) Then Exit Sub

        'If the user is trading, he can't drop items => He's cheating, we kick him.
114     If .flags.Comerciando Then Exit Sub

        'Are we dropping gold or other items??
116     If Slot = FLAGORO Then
118         If Amount > 100000 Then
120             Call TirarOro(100000, UserIndex)
            Else
122             TirarOro Amount, UserIndex

            End If

124         Call WriteUpdateGold(UserIndex)
        Else

            'Only drop valid slots
126         If Slot <= MAX_INVENTORY_SLOTS And Slot > 0 Then
128             If .Invent.Object(Slot).ObjIndex = 0 Then
                    Exit Sub

                End If

177             If EsGM(UserIndex) Then
156                 Call DropObj(UserIndex, Slot, Amount, .Pos.Map, .Pos.X, .Pos.Y)
                Else
                    If ObjData(.Invent.Object(Slot).ObjIndex).Real = 0 And ObjData(.Invent.Object(Slot).ObjIndex).Caos = 0 And ObjData(.Invent.Object(Slot).ObjIndex).Alineacion = 0 And ObjData(.Invent.Object(Slot).ObjIndex).NoSeSaca = 0 Then
130                     Call DropObj(UserIndex, Slot, Amount, .Pos.Map, .Pos.X, .Pos.Y)
                    Else
133                     Call WriteConsoleMsg(UserIndex, "No puedes tirar este objeto!")
                    End If
                End If

            End If

        End If

    End With

    Exit Sub
HandleDrop_Err:
132 Call LogError("TDSLegacy.Protocol.HandleDrop en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCastSpell(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCastSpell_Err

100 With UserList(UserIndex)

        Dim Spell As Integer

102     Spell = Message.ReadInt()

104     If .flags.Muerto = 1 Then
106         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Now you can be atacked
108     .flags.NoPuedeSerAtacado = False

110     If Spell < 1 Then
112         .flags.Hechizo = 0
            Exit Sub
114     ElseIf Spell > MAXUSERHECHIZOS Then
116         .flags.Hechizo = 0
            Exit Sub

        End If

118     .flags.Hechizo = .Stats.UserHechizos(Spell)

    End With

    Exit Sub
HandleCastSpell_Err:
120 Call LogError("TDSLegacy.Protocol.HandleCastSpell en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleLeftClick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleLeftClick_Err

    Dim X As Byte

    Dim Y As Byte

100 X = Message.ReadInt8()
102 Y = Message.ReadInt8()

104 Call LookatTile(UserIndex, UserList(UserIndex).Pos.Map, X, Y)

    Exit Sub
HandleLeftClick_Err:
106 Call LogError("TDSLegacy.Protocol.HandleLeftClick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDoubleClick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDoubleClick_Err

    Dim X As Byte

    Dim Y As Byte

100 X = Message.ReadInt8()
102 Y = Message.ReadInt8()

104 Call Accion(UserIndex, UserList(UserIndex).Pos.Map, X, Y)
    If UserList(UserIndex).Slot_ID > 0 Then
        If MapData(UserList(UserIndex).Pos.Map, X, Y).ObjInfo.ObjIndex > 0 Then
            Dim Pos As WorldPos
            Pos.Map = UserList(UserIndex).Pos.Map
            Pos.X = X
            Pos.Y = Y
            Call DoubleClickCofre(Pos, UserList(UserIndex).Slot_ID)
        End If
    End If

    Exit Sub
HandleDoubleClick_Err:
106 Call LogError("TDSLegacy.Protocol.HandleDoubleClick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWork(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWork_Err

100 With UserList(UserIndex)

        Dim Skill As eSkill

102     Skill = Message.ReadInt8()

104     If UserList(UserIndex).flags.Muerto = 1 Then Exit Sub

106     If .flags.Privilegios = User Then
108         If Skill = eSkill.Ocultarse Or Skill = eSkill.Domar Or Skill = eSkill.Robar Then
110             If Not MapInfo(UserList(UserIndex).Pos.Map).pk And MapInfo(UserList(UserIndex).Pos.Map).Terreno = "CIUDAD" Then
112                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_433)
                    Exit Sub
                End If
            End If
        End If

114     If UserList(UserIndex).flags.ModoCombate = False Then
116         WriteConsoleMsg UserIndex, "Para realizar esta acción debes estar en modo combate!!", FontTypeNames.FONTTYPE_INFO
            Exit Sub

        End If

        'If exiting, cancel
118     Call CancelExit(UserIndex)

120     Select Case Skill

        Case Robar, Magia, Domar
122         Call WriteMultiMessage(UserIndex, eMessages.WorkRequestTarget, Skill)        'Call WriteWorkRequestTarget(UserIndex, Skill)

124     Case Ocultarse
            If .flags.Privilegios = PlayerType.User Then
126             If .flags.EnConsulta Then Exit Sub
                If .sReto.Reto_Index > 0 Or .mReto.Reto_Index > 0 Then Exit Sub
                If (MapInfo(.Pos.Map).Terreno = Ciudad Or MapInfo(.Pos.Map).Zona = Ciudad) And Not MapInfo(.Pos.Map).pk Then
                    If Not .flags.UltimoMensaje = 45 Then
                        WriteConsoleMsg UserIndex, "Para realizar esta acción debes estar en zona insegura o fuera de una ciudad!", FontTypeNames.FONTTYPE_INFO
                        .flags.UltimoMensaje = 45
                    End If
                    Exit Sub
                End If
            End If
128         If .flags.Navegando = 1 Then
130             If .Clase <> eClass.Pirat Then

                    '[CDT 17-02-2004]
132                 If Not .flags.UltimoMensaje = 3 Then

134                     WriteMensajes UserIndex, e_Mensajes.Mensaje_229
136                     .flags.UltimoMensaje = 3

                    End If

                    '[/CDT]
                    Exit Sub

                End If

            End If

138         If .flags.oculto = 1 Then

                '[CDT 17-02-2004]
140             If Not .flags.UltimoMensaje = 2 Then

142                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_2)
144                 .flags.UltimoMensaje = 2

                End If

                '[/CDT]
                Exit Sub

            End If

146         Call DoOcultarse(UserIndex)

        End Select

    End With

    Exit Sub
HandleWork_Err:
148 Call LogError("TDSLegacy.Protocol.HandleWork en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleInitCrafting(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleInitCrafting_Err

    Dim TotalItems As Long

100 With UserList(UserIndex)
102     TotalItems = Message.ReadInt32

104     If TotalItems > 30000 Then TotalItems = 30000

106     If TotalItems > 0 Then
108         .Construir.cantidad = TotalItems
110         .Construir.PorCiclo = IIf(TotalItems = 1, 1, MaxItemsConstruibles(UserIndex))

        End If

    End With

    Exit Sub
HandleInitCrafting_Err:
112 Call LogError("TDSLegacy.Protocol.HandleInitCrafting en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUseSpellMacro(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUseSpellMacro_Err
    Dim tipo As Byte

    tipo = Message.ReadInt8

    Select Case tipo
    Case 0
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " posible uso de macro auto-lanzar.", FontTypeNames.FONTTYPE_VENENO))
    Case 1
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " posible uso de macro-inventario(F8)", FontTypeNames.FONTTYPE_VENENO))
    Case 2
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " posible uso de macro-hechizos(F8)", FontTypeNames.FONTTYPE_VENENO))
    Case Else
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & " Case Else: " & tipo & " In HandleUseSpellMacro!", FontTypeNames.FONTTYPE_VENENO))
    End Select

    Exit Sub
HandleUseSpellMacro_Err:
108 Call LogError("TDSLegacy.Protocol.HandleUseSpellMacro en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUseItem(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 05/17/06
'
'***************************************************

    Dim Slot As Byte
    Slot = Message.ReadInt8

    With UserList(UserIndex)

        ' @@ Anti cheat cambiar de slot en hechizos
        If .flags.MenuCliente <> eVentanas.vInventario Then
            If .flags.LastSlotClient <> 255 Then
                If Slot <> .flags.LastSlotClient Then
                    'uso de editor de paquetes. (Intento cambiar de slot estando en hechizos)
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 1", FontTypeNames.FONTTYPE_SERVER))
                    Call LogAntiCheat(.Name & " intentó cambiar de slot estando en la ventana de hechizos.")
                    'Exit Sub
                End If
            End If
        End If

        .flags.LastSlotClient = Slot

        If Slot <= .CurrentInventorySlots And Slot > 0 Then
            If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub
        End If

        If .flags.Meditando Then Exit Sub

        If .flags.Comerciando Then
            'intentó tomar pociones estando comerciando.
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 2", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Tomar pociones comerciando.")
            'Exit sub
        End If

        Call UseInvItem(UserIndex, Slot)
    End With

End Sub

Private Sub HandleUsePotionsU(ByVal Message As BinaryReader, ByVal UserIndex As Integer, ByVal AgainLast As Byte)

    Dim Slot As Byte
    Dim RandomKey As Byte

    On Error GoTo Errhandler

1   With UserList(UserIndex)

2       If AgainLast > 0 Then
3           Slot = .flags.LastSlotPotion        'LastSlotClient
4           RandomKey = IIf(.mLastKeyUseItem > 1, 1, 2)
5       Else
6           Slot = Message.ReadInt8
7           RandomKey = Message.ReadInt8

8           .flags.LastSlotPotion = Slot
9       End If

        ' @@ Anti cheat cambiar de slot en hechizos
10      If .flags.MenuCliente <> 1 Then        ' @@ Si no esta en inventario
11          If .flags.LastSlotClient <> 255 Then        ' @@ Si no es la primera vez que poteo
12              If Slot <> .flags.LastSlotClient Then        ' @@ Si el slot es distinto
13                  Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 3", FontTypeNames.FONTTYPE_SERVER))
14                  Call LogAntiCheat(.Name & " intentó cambiar de slot estando en la ventana de hechizos.")
                    'Exit Sub
                End If
            End If
        End If

        ' @@ Anti editor de paquetes poteo
15      If RandomKey > 0 And RandomKey < 3 Then
16          If RandomKey = .mLastKeyUseItem Then
17              Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad Poteo U» " & .Name & " Alerta code: 4", FontTypeNames.FONTTYPE_SERVER))
18              Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Poteo U.")
                'Exit Sub
            End If
        Else
19          Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad Poteo U» " & .Name & " - Alerta code: 5", FontTypeNames.FONTTYPE_SERVER))
20          Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Poteo U.")
            'Exit Sub
        End If

21      .mLastKeyUseItem = RandomKey

        ' ++ Si es distinto actualizamos jejeje
22      If Slot <> .flags.LastSlotClient Then
23          .flags.LastSlotClient = Slot
        End If

        If Slot < 1 Then Exit Sub
        If Slot > .CurrentInventorySlots Then Exit Sub

24      If .Invent.Object(Slot).ObjIndex < 1 Then Exit Sub

25      If .flags.Meditando Then Exit Sub
        '26            .flags.Meditando = False
        '            Call WriteMeditateToggle(userindex)
        '            Call PrepareMessageCreateFX(.Char.CharIndex, 0, 0)
        '            Call SendData(SendTarget.ToPCArea, userindex)
        '        End If

        '++ Calate esta misery jsjsjsjs
27      If .flags.Comerciando Then    'uso de editor de paquetes. (Intento tomar pociones estando comerciando)
82          Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 6", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Tomar pociones comerciando.")
            'Exit sub
        End If

29      If Not IntervaloPermiteUsar(UserIndex) Then
299         Exit Sub
        End If

30      Call UseInvPotion(UserIndex, Slot)

    End With

    Exit Sub
Errhandler:
    Call LogError("Error en HandleUsPotionsU en " & Erl & ". Err :" & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleCraftBlacksmith(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCraftBlacksmith_Err

    Dim Item As Integer

100 Item = Message.ReadInt()

    'No
102 If Item < 1 Then Exit Sub

104 If ObjData(Item).SkHerreria = 0 Then Exit Sub

106 Call HerreroConstruirItem(UserIndex, Item)

    Exit Sub
HandleCraftBlacksmith_Err:
108 Call LogError("TDSLegacy.Protocol.HandleCraftBlacksmith en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCraftCarpenter(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCraftCarpenter_Err

    Dim Item As Integer

100 Item = Message.ReadInt()

102 If Item < 1 Then Exit Sub

104 If ObjData(Item).SkCarpinteria = 0 Then Exit Sub

106 Call CarpinteroConstruirItem(UserIndex, Item)

    Exit Sub
HandleCraftCarpenter_Err:
108 Call LogError("TDSLegacy.Protocol.HandleCraftCarpenter en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWorkLeftClick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWorkLeftClick_Err

100 With UserList(UserIndex)

        Dim X As Byte

        Dim Y As Byte

        Dim Skill As eSkill

        Dim DummyInt As Integer

        Dim tU As Integer  'Target user

        Dim tN As Integer  'Target NPC

        Dim check As Long

102     X = Message.ReadInt8()
104     Y = Message.ReadInt8()

106     Skill = Message.ReadInt8()
108     check = Message.ReadInt32()

110     If check = .Counters.Seguridad.Lanzar Then
112         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("AntiCheat> Deteccion cheat al lanzar de " & UserList(UserIndex).Name, FontTypeNames.FONTTYPE_GUILD))
            Exit Sub

        End If

114     .Counters.Seguridad.Lanzar = check

116     If .flags.Muerto = 1 Or .flags.Descansar Or .flags.Meditando Or Not InMapBounds(.Pos.Map, X, Y) Then Exit Sub

118     If Not InRangoVision(UserIndex, X, Y) Then
120         Call WritePosUpdate(UserIndex)
            Exit Sub

        End If

        'If exiting, cancel
122     Call CancelExit(UserIndex)

124     Select Case Skill

        Case eSkill.proyectiles

            'Check attack interval
126         If Not IntervaloPermiteAtacar(UserIndex, False) Then Exit Sub

            'Check Magic interval
128         If Not IntervaloPermiteLanzarSpell(UserIndex, False) Then Exit Sub

            'Check bow's interval
130         If Not IntervaloPermiteUsarArcos(UserIndex) Then Exit Sub


            'Check Spell-Hit interval
270         If Not IntervaloPermiteGolpeMagia(UserIndex) Then

                'Check Magic interval
272             If Not modAntiCheat.PuedeIntervalo(UserIndex, IntControl.Lanzar) Then
                    Exit Sub

                End If

            End If

            If Not UserList(UserIndex).flags.ModoCombate Then
                WriteMensajes UserIndex, e_Mensajes.Mensaje_218
                Exit Sub
            End If

            Dim Atacked As Boolean

132         Atacked = True

            'Make sure the item is valid and there is ammo equipped.
134         With .Invent

                ' Tiene arma equipada?
136             If .WeaponEqpObjIndex = 0 Then
138                 DummyInt = 1
                    ' En un slot válido?
140             ElseIf .WeaponEqpSlot < 1 Or .WeaponEqpSlot > UserList(UserIndex).CurrentInventorySlots Then
142                 DummyInt = 1
                    ' Usa munición? (Si no la usa, puede ser un arma arrojadiza)
144             ElseIf ObjData(.WeaponEqpObjIndex).Municion = 1 Then

                    ' La municion esta equipada en un slot valido?
146                 If .MunicionEqpSlot < 1 Or .MunicionEqpSlot > UserList(UserIndex).CurrentInventorySlots Then
148                     DummyInt = 1
                        ' Tiene munición?
150                 ElseIf .MunicionEqpObjIndex = 0 Then
152                     DummyInt = 1
                        ' Son flechas?
154                 ElseIf ObjData(.MunicionEqpObjIndex).OBJType <> eOBJType.otFlechas Then
156                     DummyInt = 1
                        ' Tiene suficientes?
158                 ElseIf .Object(.MunicionEqpSlot).Amount < 1 Then
160                     DummyInt = 1

                    End If

                    ' Es un arma de proyectiles?
162             ElseIf ObjData(.WeaponEqpObjIndex).proyectil <> 1 Then
164                 DummyInt = 2

                End If

166             If DummyInt <> 0 Then
168                 If DummyInt = 1 Then
170                     WriteMensajes UserIndex, e_Mensajes.Mensaje_230

172                     Call Desequipar(UserIndex, .WeaponEqpSlot, False)

                    End If

174                 Call Desequipar(UserIndex, .MunicionEqpSlot, True)
                    Exit Sub

                End If

            End With

            'Quitamos stamina
176         If .Stats.minSta >= ObjData(.Invent.WeaponEqpObjIndex).QuitaEnergia Then
178             Call QuitarSta(UserIndex, ObjData(.Invent.WeaponEqpObjIndex).QuitaEnergia)        'RandomNumber(1, 10))
            Else
180             WriteMensajes UserIndex, e_Mensajes.Mensaje_11
                Exit Sub

            End If

182         Call LookatTile(UserIndex, .Pos.Map, X, Y)

184         tU = .flags.TargetUser
186         tN = .flags.TargetNPC

            If .flags.TargetBot <> 0 And tN = .flags.TargetBot Then
                Call IA_DamageHit(.flags.TargetBot)
                .flags.TargetBot = 0
                Exit Sub
            End If

            'Validate target
188         If tU > 0 Then

                'Only allow to atack if the other one can retaliate (can see us)
190             If Abs(UserList(tU).Pos.Y - .Pos.Y) > RANGO_VISION_Y Then
192                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
                    Exit Sub

                End If

                'Prevent from hitting self
194             If tU = UserIndex Then

196                 WriteMensajes UserIndex, e_Mensajes.Mensaje_145
                    Exit Sub

                End If

                'Attack!
198             Atacked = UsuarioAtacaUsuario(UserIndex, tU)

200         ElseIf tN > 0 Then

                'Only allow to atack if the other one can retaliate (can see us)
202             If Abs(Npclist(tN).Pos.Y - .Pos.Y) > RANGO_VISION_Y And Abs(Npclist(tN).Pos.X - .Pos.X) > RANGO_VISION_X Then

204                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
                    Exit Sub

                End If

                'Is it attackable???
206             If Npclist(tN).Attackable <> 0 Then

                    'Attack!
208                 Atacked = UsuarioAtacaNpc(UserIndex, tN)

                End If

            End If

            ' Solo pierde la munición si pudo atacar al target, o tiro al aire
210         If Atacked Then

212             With .Invent

                    ' Tiene equipado arco y flecha?
214                 If .WeaponEqpObjIndex > 0 Then
216                     If ObjData(.WeaponEqpObjIndex).Municion = 1 Then
218                         DummyInt = .MunicionEqpSlot

220                         If DummyInt = 0 Then
222                             Call WriteConsoleMsg(UserIndex, "No tienes una municion equipada o da error.")
                                Exit Sub

                            End If

                            'Take 1 arrow away - we do it AFTER hitting, since if Ammo Slot is 0 it gives a rt9 and kicks players
224                         Call QuitarUserInvItem(UserIndex, DummyInt, 1)

226                         If .Object(DummyInt).Amount > 0 Then
                                'QuitarUserInvItem unequips the ammo, so we equip it again
228                             .MunicionEqpSlot = DummyInt
230                             .MunicionEqpObjIndex = .Object(DummyInt).ObjIndex
232                             .Object(DummyInt).Equipped = 1
                            Else
234                             .MunicionEqpSlot = 0
236                             .MunicionEqpObjIndex = 0

                            End If

                            ' Tiene equipado un arma arrojadiza
                        Else
238                         DummyInt = .WeaponEqpSlot

                            'Take 1 knife away
240                         Call QuitarUserInvItem(UserIndex, DummyInt, 1)

242                         If .Object(DummyInt).Amount > 0 Then
                                'QuitarUserInvItem unequips the weapon, so we equip it again
244                             .WeaponEqpSlot = DummyInt
246                             .WeaponEqpObjIndex = .Object(DummyInt).ObjIndex
248                             .Object(DummyInt).Equipped = 1
                            Else
250                             .WeaponEqpSlot = 0
252                             .WeaponEqpObjIndex = 0

                            End If

                        End If

254                     Call UpdateUserInv(False, UserIndex, DummyInt)

                    End If

                End With

            End If

256     Case eSkill.Magia

            'Check the map allows spells to be casted.
258         If MapInfo(.Pos.Map).MagiaSinEfecto > 0 Then
260             Call WriteMensajes(UserIndex, Mensaje_421, FontTypeNames.FONTTYPE_FIGHT)
                Exit Sub
            End If

            'Target whatever is in that tile
262         Call LookatTile(UserIndex, .Pos.Map, X, Y)

            'If it's outside range log it and exit
264         If Abs(.Pos.X - X) > RANGO_VISION_X Or Abs(.Pos.Y - Y) > RANGO_VISION_Y Then
266             Call LogCriticEvent("Ataque fuera de rango de " & .Name & "(" & .Pos.Map & "/" & .Pos.X & "/" & .Pos.Y & ") ip: " & .IP & " a la posición (" & .Pos.Map & "/" & X & "/" & Y & ")")
                Exit Sub

            End If

            'Check bow's interval
268         If Not IntervaloPermiteUsarArcos(UserIndex, False) Then Exit Sub

            'Check Spell-Hit interval
            If Not IntervaloPermiteGolpeMagia(UserIndex) Then

                'Check Magic interval
                If Not modAntiCheat.PuedeIntervalo(UserIndex, IntControl.Lanzar) Then
                    Exit Sub

                End If

            End If

            ' If .flags.MenuCliente <> eVentanas.vHechizos Then
            '     Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " uso de editor de paquetes. (Intento apretar lanzar estando en inventario)", FontTypeNames.FONTTYPE_SERVER))
            '     Call LogAntiCheat(.Name & " intentó apretar lanzar estando en la ventana de inventario.")
            '     'Exit Sub
            ' End If

            'Check intervals and cast
274         If .flags.Hechizo > 0 Then
276             Call LanzarHechizo(.flags.Hechizo, UserIndex)
278             .flags.Hechizo = 0
            Else
280             WriteMensajes UserIndex, e_Mensajes.Mensaje_233

            End If

282     Case eSkill.Pesca
284         DummyInt = .Invent.WeaponEqpObjIndex

286         If DummyInt = 0 Then Exit Sub

            'Check interval
288         If Not IntervaloPermiteTrabajar(UserIndex) Then Exit Sub

            'Basado en la idea de Barrin
            'Comentario por Barrin: jah, "basado", caradura ! ^^
290         If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = 1 Then
292             WriteMensajes UserIndex, e_Mensajes.Mensaje_234

                Exit Sub

            End If

294         If HayAgua(.Pos.Map, X, Y) Then

296             Select Case DummyInt

                Case CAÑA_PESCA
                    Call DoPescar_Cana(UserList(UserIndex))

                Case RED_PESCA
                    Call DoPescar_Red(UserList(UserIndex))
308             Case Else

                    Exit Sub        'Invalid item!

                End Select

            Else
312             WriteMensajes UserIndex, e_Mensajes.Mensaje_235

            End If

314     Case eSkill.Robar

            'Does the map allow us to steal here?
316         If MapInfo(.Pos.Map).pk Then

                'Check interval
318             If Not IntervaloPermiteAtacar(UserIndex) Then Exit Sub

                'Target whatever is in that tile
320             Call LookatTile(UserIndex, UserList(UserIndex).Pos.Map, X, Y)

322             tU = .flags.TargetUser

324             If tU > 0 And tU <> UserIndex Then
326                 If UserList(tU).flags.Privilegios < PlayerType.Consejero Then
328                     If UserList(tU).flags.Muerto = 1 Then Exit Sub

334                     If Not UserList(UserIndex).flags.ModoCombate Then
336                         WriteMensajes UserIndex, e_Mensajes.Mensaje_218
                            Exit Sub
                        End If

338                     If MapData(UserList(tU).Pos.Map, X, Y).trigger = eTrigger.ZONASEGURA Then
340                         WriteMensajes UserIndex, e_Mensajes.Mensaje_236
                            Exit Sub
                        End If

342                     If MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = eTrigger.ZONASEGURA Then
344                         WriteMensajes UserIndex, e_Mensajes.Mensaje_236
                            Exit Sub
                        End If

346                     Call DoRobar(UserList(UserIndex), UserList(tU), X, Y)

                    End If


                Else
348                 WriteMensajes UserIndex, e_Mensajes.Mensaje_237

                End If

            Else
350             WriteMensajes UserIndex, e_Mensajes.Mensaje_238

            End If

352     Case eSkill.Talar

            'Check interval
354         If Not IntervaloPermiteTrabajar(UserIndex) Then Exit Sub

356         If .Invent.WeaponEqpObjIndex = 0 Then
358             WriteMensajes UserIndex, e_Mensajes.Mensaje_239
                Exit Sub

            End If

360         If .Invent.WeaponEqpObjIndex <> HACHA_LEÑADOR And .Invent.WeaponEqpObjIndex <> HACHA_DORADA Then
                ' Podemos llegar acá si el user equipó el anillo dsp de la U y antes del click
                Exit Sub

            End If

362         DummyInt = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex

364         If DummyInt > 0 Then
366             If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 1 Then
368                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
                    Exit Sub

                End If

                'Barrin 29/9/03
370             If .Pos.X = X And .Pos.Y = Y Then
372                 WriteMensajes UserIndex, e_Mensajes.Mensaje_240
                    Exit Sub

                End If

                '¿Hay un arbol donde clickeo?
374             If ObjData(DummyInt).OBJType = eOBJType.otArboles Then
                    If .Invent.WeaponEqpObjIndex = HACHA_LEÑADOR Then
378                     Call DoTalar(UserIndex)
                    ElseIf .Invent.WeaponEqpObjIndex = HACHA_DORADA Then
                        Call WriteConsoleMsg(UserIndex, "Ésta hacha sólo funciona con un árbol de tejo")
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_279
                    End If
380             ElseIf ObjData(DummyInt).OBJType = eOBJType.otArbolElfico Then
                    If .Invent.WeaponEqpObjIndex = HACHA_DORADA Then
386                     Call DoTalar(UserIndex, True)

                    ElseIf .Invent.WeaponEqpObjIndex = HACHA_LEÑADOR Then
                        Call WriteConsoleMsg(UserIndex, "Ésta hacha sólo funciona con un árbol común")
                    Else
                        WriteMensajes UserIndex, e_Mensajes.Mensaje_278
                    End If
                Else
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_279
                End If

            Else
390             WriteMensajes UserIndex, e_Mensajes.Mensaje_241
            End If

392     Case eSkill.Mineria

394         If Not IntervaloPermiteTrabajar(UserIndex) Then Exit Sub

396         If .Invent.WeaponEqpObjIndex = 0 Then Exit Sub

398         If .Invent.WeaponEqpObjIndex <> PIQUETE_MINERO And .Invent.WeaponEqpObjIndex <> PIQUETE_MINERO_ORO Then
                ' Podemos llegar acá si el user equipó el anillo dsp de la U y antes del click
                Exit Sub

            End If

            'Target whatever is in the tile
400         Call LookatTile(UserIndex, .Pos.Map, X, Y)

402         DummyInt = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex

404         If DummyInt > 0 Then

                'Check distance
406             If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 2 Then
408                 Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
                    Exit Sub

                End If

410             DummyInt = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex        'CHECK

                '¿Hay un yacimiento donde clickeo?
412             If ObjData(DummyInt).OBJType = eOBJType.otYacimiento Then

                    If ObjData(DummyInt).MineralIndex = 194 Then   ' ORO!
                        If Not .Invent.WeaponEqpObjIndex = PIQUETE_MINERO_ORO Then
                            WriteMensajes UserIndex, e_Mensajes.Mensaje_439
                        Else
                            Call DoMineria_v2(UserIndex)
                        End If
                        Exit Sub
                    End If

414                 Call DoMineria(UserIndex)

                Else
416                 WriteMensajes UserIndex, e_Mensajes.Mensaje_242

                End If

            Else
418             WriteMensajes UserIndex, e_Mensajes.Mensaje_242

            End If

420     Case eSkill.Domar


            If Not EsGM(UserIndex) Then
                If Not UserList(UserIndex).Clase = eClass.Druid Then
                    WriteMensajes UserIndex, e_Mensajes.Mensaje_434
                    Exit Sub
                End If
            End If

            'Target whatever is that tile
422         Call LookatTile(UserIndex, .Pos.Map, X, Y)
424         tN = .flags.TargetNPC

426         If tN > 0 Then
428             If Npclist(tN).flags.Domable > 0 Then
430                 If Abs(.Pos.X - X) + Abs(.Pos.Y - Y) > 2 Then
432                     Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
                        Exit Sub
                    End If

434                 If LenB(Npclist(tN).flags.AttackedBy) <> 0 Then
436                     WriteMensajes UserIndex, e_Mensajes.Mensaje_243
                        Exit Sub
                    End If

438                 Call DoDomar(UserIndex, tN)
                Else
440                 WriteMensajes UserIndex, e_Mensajes.Mensaje_244
                End If
            Else
442             WriteMensajes UserIndex, e_Mensajes.Mensaje_245
            End If

444     Case FundirMetal

            'Check interval
446         If Not IntervaloPermiteTrabajar(UserIndex) Then Exit Sub

            'Check there is a proper item there
448         If .flags.TargetObj > 0 Then
450             If ObjData(.flags.TargetObj).OBJType = eOBJType.otFragua Then

                    'Validate other items
452                 If .flags.TargetObjInvSlot < 1 Or .flags.TargetObjInvSlot > .CurrentInventorySlots Then
                        Exit Sub

                    End If

                    ''chequeamos que no se zarpe duplicando oro
454                 If .Invent.Object(.flags.TargetObjInvSlot).ObjIndex <> .flags.TargetObjInvIndex Then
456                     If .Invent.Object(.flags.TargetObjInvSlot).ObjIndex = 0 Or .Invent.Object(.flags.TargetObjInvSlot).Amount = 0 Then
458                         WriteMensajes UserIndex, e_Mensajes.Mensaje_246
                            Exit Sub

                        End If

                        ''FUISTE
460                     Call WriteErrorMsg(UserIndex, "Has sido expulsado por el sistema anti cheats.")
                        'Call Flushbuffer(UserIndex)
462                     Call CloseSocket(UserIndex)
                        Exit Sub

                    End If

464                 If ObjData(.flags.TargetObjInvIndex).OBJType = eOBJType.otMinerales Then
466                     Call FundirMineral(UserIndex)
                    End If

                Else
472                 WriteMensajes UserIndex, e_Mensajes.Mensaje_247

                End If

            Else
474             WriteMensajes UserIndex, e_Mensajes.Mensaje_247

            End If

476     Case eSkill.Herreria
            'Target wehatever is in that tile
478         Call LookatTile(UserIndex, .Pos.Map, X, Y)

480         If .flags.TargetObj > 0 Then
482             If ObjData(.flags.TargetObj).OBJType = eOBJType.otYunque Then
484                 Call EnivarArmasConstruibles(UserIndex)
486                 Call EnivarArmadurasConstruibles(UserIndex)
488                 Call WriteShowBlacksmithForm(UserIndex)
                Else
490                 WriteMensajes UserIndex, e_Mensajes.Mensaje_248

                End If

            Else
492             WriteMensajes UserIndex, e_Mensajes.Mensaje_248

            End If

        End Select

    End With

    Exit Sub
HandleWorkLeftClick_Err:
494 Call LogError("TDSLegacy.Protocol.HandleWorkLeftClick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCreateNewGuild(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCreateNewGuild_Err

100 With UserList(UserIndex)

        Dim Desc As String

        Dim GuildName As String

        Dim site As String

        Dim codex() As String

102     Desc = Message.ReadString16()
104     GuildName = Trim$(Message.ReadString16())
106     site = Message.ReadString16()
108     codex = Split(Message.ReadString16(), SEPARATOR)

        If Not .flags.ExClan = 0 Then
            Call WriteConsoleMsg(UserIndex, "AntiCheat - Has salteado una seguridad, tu registro se ha guardado. No puedes crear un clan ya que tienes uno disuelto: " & modGuilds.GuildName(.flags.ExClan), FontTypeNames.FONTTYPE_GUILD)
            Call LogAntiCheat(.Name & " intentó crear clan teniendo ya otro: " & modGuilds.GuildName(.flags.ExClan) & "(" & .flags.ExClan & ") - Quiere crear: " & GuildName)
            Exit Sub
        End If

110     If modGuilds.CrearNuevoClan(UserIndex, Desc, GuildName, site, codex, .FundandoGuildAlineacion) Then
112         Call SendData(SendTarget.ToAll, UserIndex, PrepareMessageConsoleMsg("¡¡¡" & .Name & " fundó el clan " & Chr(39) & GuildName & "'!!!.", FontTypeNames.FONTTYPE_GUILD))
114         Call WriteConsoleMsg(UserIndex, "¡Has fundado el clan numero " & .GuildIndex & " de TDS Legacy!.", FontTypeNames.FONTTYPE_GUILD)

116         Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(44, NO_3D_SOUND, NO_3D_SOUND))
            'Update tag
118         Call RefreshCharStatus(UserIndex)

        End If

    End With

    Exit Sub
HandleCreateNewGuild_Err:
120 Call LogError("TDSLegacy.Protocol.HandleCreateNewGuild en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleEquipItem(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleEquipItem_Err

100 With UserList(UserIndex)

        Dim itemSlot As Integer

102     itemSlot = Message.ReadInt8()

        'Dead users can't equip items
104     If .flags.Muerto = 1 Then Exit Sub

        'Validate item slot
106     If itemSlot > .CurrentInventorySlots Or itemSlot < 1 Then Exit Sub

108     If .Invent.Object(itemSlot).ObjIndex = 0 Then Exit Sub

110     Call EquiparInvItem(UserIndex, itemSlot)

    End With

    Exit Sub
HandleEquipItem_Err:
112 Call LogError("TDSLegacy.Protocol.HandleEquipItem en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleChangeHeading(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleChangeHeading_Err

100 With UserList(UserIndex)

        Dim Heading As eHeading

        Dim posX As Integer

        Dim posY As Integer

102     Heading = Message.ReadInt()

104     If .flags.Paralizado = 1 And .flags.Inmovilizado = 0 Then

106         Select Case Heading

            Case eHeading.NORTH
108             posY = -1

110         Case eHeading.EAST
112             posX = 1

114         Case eHeading.SOUTH
116             posY = 1

118         Case eHeading.WEST
120             posX = -1

            End Select

122         If LegalPos(.Pos.Map, .Pos.X + posX, .Pos.Y + posY, CBool(.flags.Navegando), Not CBool(.flags.Navegando)) Then
                Exit Sub

            End If

        End If

        'Validate heading (VB won't say invalid cast if not a valid index like .Net languages would do... *sigh*)
124     If Heading > 0 And Heading < 5 Then
126         If .Char.Heading <> Heading Then
128             .Char.Heading = Heading
                Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageChangeHeading(.Char.CharIndex, .Char.Heading))
            End If

        End If

    End With

    Exit Sub
HandleChangeHeading_Err:
132 Call LogError("TDSLegacy.Protocol.HandleChangeHeading en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleModifySkills(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleModifySkills_Err

100 With UserList(UserIndex)

        Dim i As Long

        Dim count As Integer

        Dim Points(1 To NUMSKILLS) As Byte

        'Codigo para prevenir el hackeo de los skills
        '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
102     For i = 1 To NUMSKILLS
104         Points(i) = Message.ReadInt8()

106         If Points(i) < 0 Then
108             Call LogHackAttemp(.Name & " IP:" & .IP & " trató de hackear los skills.")
110             .Stats.SkillPts = 0
112             Call CloseSocket(UserIndex)
                Exit Sub

            End If

114         count = count + Points(i)
116     Next i

118     If count > .Stats.SkillPts Then
120         Call LogHackAttemp(.Name & " IP:" & .IP & " trató de hackear los skills.")
122         Call CloseSocket(UserIndex)
            Exit Sub

        End If

        '<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

        Dim SkAssigned As String, found As Boolean


124     .Counters.AsignedSkills = MinimoInt(10, .Counters.AsignedSkills + count)

126     With .Stats

128         For i = 1 To NUMSKILLS

130             If Points(i) > 0 Then
                    found = True
132                 .SkillPts = .SkillPts - Points(i)
134                 .UserSkills(i) = .UserSkills(i) + Points(i)
                    .AsignoSkills = .AsignoSkills + Points(i)

                    'Client should prevent this, but just in case...
136                 If .UserSkills(i) > 100 Then
138                     .SkillPts = .SkillPts + .UserSkills(i) - 100
140                     .UserSkills(i) = 100
                    End If

                    If i = 1 Then
                        SkAssigned = SkillsNames(i) & "=" & Points(i)
                    Else
                        SkAssigned = SkAssigned & "," & SkillsNames(i) & "=" & Points(i)
                    End If

142                 Call CheckEluSkill(UserIndex, i, True)

                End If

144         Next i

        End With

        If found Then
            Call LogUserAction(.Name, "Asignó skills: " & SkAssigned)
        End If

    End With

    Exit Sub
HandleModifySkills_Err:
146 Call LogError("TDSLegacy.Protocol.HandleModifySkills en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTrain(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTrain_Err

100 With UserList(UserIndex)

        Dim SpawnedNpc As Integer

        Dim PetIndex As Byte

102     PetIndex = Message.ReadInt8()

104     If .flags.TargetNPC = 0 Then Exit Sub

106     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Entrenador Then Exit Sub

108     If Npclist(.flags.TargetNPC).Mascotas < MAXMASCOTASENTRENADOR Then
110         If PetIndex > 0 And PetIndex < Npclist(.flags.TargetNPC).NroCriaturas + 1 Then
                'Create the creature
112             SpawnedNpc = SpawnNpc(Npclist(.flags.TargetNPC).Criaturas(PetIndex).NpcIndex, Npclist(.flags.TargetNPC).Pos, True, False)

114             If SpawnedNpc > 0 Then
116                 Npclist(SpawnedNpc).MaestroNpc = .flags.TargetNPC
118                 Npclist(.flags.TargetNPC).Mascotas = Npclist(.flags.TargetNPC).Mascotas + 1

                End If

            End If

        Else
120         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No puedo traer más criaturas, mata las existentes.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite))

        End If

    End With

    Exit Sub
HandleTrain_Err:
122 Call LogError("TDSLegacy.Protocol.HandleTrain en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCommerceBuy(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCommerceBuy_Err

100 With UserList(UserIndex)

        Dim Slot As Integer

        Dim Amount As Integer

        Dim toSlot As Integer

102     Slot = Message.ReadInt8()
104     Amount = Message.ReadInt()
106     toSlot = Message.ReadInt8()

        'Dead people can't commerce...
108     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        '¿El target es un NPC valido?
112     If .flags.TargetNPC < 1 Then Exit Sub

        '¿El NPC puede comerciar?
114     If Npclist(.flags.TargetNPC).Comercia = 0 Then
116         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No tengo ningún interés en comerciar.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite))
            Exit Sub

        End If

        'Only if in commerce mode....
118     If Not .flags.Comerciando Then
120         WriteMensajes UserIndex, e_Mensajes.Mensaje_253
            Exit Sub

        End If

        'User compra el item
122     If DelayBuy(UserIndex) Then
124         Call Comercio(eModoComercio.Compra, UserIndex, .flags.TargetNPC, Slot, Amount, toSlot)

        End If

    End With

    Exit Sub
HandleCommerceBuy_Err:
126 Call LogError("TDSLegacy.Protocol.HandleCommerceBuy en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankExtractItem(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankExtractItem_Err

100 With UserList(UserIndex)

        Dim Slot As Integer

        Dim Amount As Integer

102     Slot = Message.ReadInt8()
104     Amount = Message.ReadInt()

        'Dead people can't commerce
106     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        '¿El target es un NPC valido?
110     If .flags.TargetNPC < 1 Then Exit Sub

        '¿Es el banquero?
112     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then
            Exit Sub
        End If

        If (Slot < 1) Or (Slot > MAX_BANCOINVENTORY_SLOTS) Then
            Slot = 1
            'Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Anti Cheat > El usuario " & .Name & " está intentado retirar un item (Slot: " & Slot & ").", FontTypeNames.FONTTYPE_SERVER))
            'Call LogAntiCheat(.Name & " intentó dupear items usando Drag and Drop Boveda (Slot: " & Slot & ").")
            Exit Sub
        End If

        'User retira el item del slot
114     Call UserRetiraItem(UserIndex, Slot, Amount)

    End With

    Exit Sub
HandleBankExtractItem_Err:
116 Call LogError("TDSLegacy.Protocol.HandleBankExtractItem en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCommerceSell(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCommerceSell_Err

100 With UserList(UserIndex)

        Dim Slot As Integer

        Dim Amount As Integer

102     Slot = Message.ReadInt8()
104     Amount = Message.ReadInt()

        'Dead people can't commerce...
106     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        '¿El target es un NPC valido?
110     If .flags.TargetNPC < 1 Then Exit Sub

        '¿El NPC puede comerciar?
112     If Npclist(.flags.TargetNPC).Comercia = 0 Then
114         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No tengo ningún interés en comerciar.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite))
            Exit Sub
        End If

        ' @@ Fix del slot
        If (Slot < 1) Or (Slot > .CurrentInventorySlots) Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Anti Cheat > El usuario " & .Name & " está intentado depositar un item (Slot: " & Slot & ").", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " intentó dupear items usando Drag and Drop Boveda (Slot: " & Slot & ").")
            Exit Sub
        End If


        'User compra el item del slot
116     If DelayBuy(UserIndex) Then
118         Call Comercio(eModoComercio.Venta, UserIndex, .flags.TargetNPC, Slot, Amount)
        End If

    End With

    Exit Sub
HandleCommerceSell_Err:
120 Call LogError("TDSLegacy.Protocol.HandleCommerceSell en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankDeposit(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankDeposit_Err

100 With UserList(UserIndex)

        Dim Slot As Integer

        Dim Amount As Integer

102     Slot = Message.ReadInt8()
104     Amount = Message.ReadInt()

        'Dead people can't commerce...
106     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        '¿El target es un NPC valido?
110     If .flags.TargetNPC < 1 Then Exit Sub

        '¿El NPC puede comerciar?
112     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then
            Exit Sub

        End If

        'User deposita el item del slot rdata
114     Call UserDepositaItem(UserIndex, Slot, Amount)

    End With

    Exit Sub
HandleBankDeposit_Err:
116 Call LogError("TDSLegacy.Protocol.HandleBankDeposit en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleMoveSpell(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleMoveSpell_Err

    Dim dir As Integer

100 If Message.ReadBool() Then
102     dir = 1
    Else
104     dir = -1

    End If

106 Call DesplazarHechizo(UserIndex, dir, Message.ReadInt8())

    Exit Sub
HandleMoveSpell_Err:
108 Call LogError("TDSLegacy.Protocol.HandleMoveSpell en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleMoveBank(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleMoveBank_Err

    Dim dir As Integer

    Dim Slot As Integer

    Dim TempItem As Obj

100 If Message.ReadBool() Then
102     dir = 1
    Else
104     dir = -1

    End If

106 Slot = Message.ReadInt8()

108 With UserList(UserIndex)
110     TempItem.ObjIndex = .BancoInvent.Object(Slot).ObjIndex
112     TempItem.Amount = .BancoInvent.Object(Slot).Amount

114     If dir = 1 Then        'Mover arriba
116         .BancoInvent.Object(Slot) = .BancoInvent.Object(Slot - 1)
118         .BancoInvent.Object(Slot - 1).ObjIndex = TempItem.ObjIndex
120         .BancoInvent.Object(Slot - 1).Amount = TempItem.Amount
        Else        'mover abajo
122         .BancoInvent.Object(Slot) = .BancoInvent.Object(Slot + 1)
124         .BancoInvent.Object(Slot + 1).ObjIndex = TempItem.ObjIndex
126         .BancoInvent.Object(Slot + 1).Amount = TempItem.Amount

        End If

    End With

128 Call UpdateBanUserInv(True, UserIndex, 0)
130 Call UpdateVentanaBanco(UserIndex)

    Exit Sub
HandleMoveBank_Err:
132 Call LogError("TDSLegacy.Protocol.HandleMoveBank en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleClanCodexUpdate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleClanCodexUpdate_Err

100 With UserList(UserIndex)

        Dim Desc As String

        Dim codex() As String

102     Desc = Message.ReadString16()
104     codex = Split(Message.ReadString16(), SEPARATOR)

106     Call modGuilds.ChangeCodexAndDesc(Desc, codex, .GuildIndex)

    End With

    Exit Sub
HandleClanCodexUpdate_Err:
108 Call LogError("TDSLegacy.Protocol.HandleClanCodexUpdate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUserCommerceOffer(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUserCommerceOffer_Err

100 With UserList(UserIndex)

        Dim Amount As Long

        Dim Slot As Byte

        Dim tUser As Integer

        Dim OfferSlot As Byte

        Dim ObjIndex As Integer

102     Slot = Message.ReadInt8()
104     Amount = Message.ReadInt32()
106     OfferSlot = Message.ReadInt8()

        'Get the other player
108     tUser = .ComUsu.DestUsu

        ' If he's already confirmed his offer, but now tries to change it, then he's cheating
110     If UserList(UserIndex).ComUsu.Confirmo = True Then

            ' Finish the trade
112         Call FinComerciarUsu(UserIndex)

114         If tUser <= 0 Or tUser > maxUsers Then Call FinComerciarUsu(tUser)
            Exit Sub

        End If

1114    If tUser <= 0 Or tUser > maxUsers Then
1130        If Not UserList(tUser).flags.UserLogged Then
1134            WriteMensajes UserIndex, e_Mensajes.Mensaje_129
1136            Call FinComerciarUsu(UserIndex)
                Exit Sub
            End If
        End If

        'If slot is invalid and it's not gold or it's not 0 (Substracting), then ignore it.
116     If ((Slot < 0 Or Slot > UserList(UserIndex).CurrentInventorySlots) And Slot <> FLAGORO) Then Exit Sub

        'If OfferSlot is invalid, then ignore it.
118     If OfferSlot < 1 Or OfferSlot > MAX_OFFER_SLOTS + 1 Then Exit Sub

        ' Can be negative if substracted from the offer, but never 0.
120     If Amount = 0 Then Exit Sub

        'Has he got enough??
122     If Slot = FLAGORO Then

            ' Can't offer more than he has
124         If Amount > .Stats.GLD - .ComUsu.goldAmount Then
126             Call WriteCommerceChat(UserIndex, "No tienes esa cantidad de oro para agregar a la oferta.", FontTypeNames.FONTTYPE_TALK)
                Exit Sub

            End If

128         If Amount < 0 Then
130             If Abs(Amount) > .ComUsu.goldAmount Then
132                 Amount = .ComUsu.goldAmount * (-1)

                End If

            End If

        Else

            'If modifing a filled offerSlot, we already got the objIndex, then we don't need to know it
134         If Slot <> 0 Then ObjIndex = .Invent.Object(Slot).ObjIndex

            ' Can't offer more than he has
136         If Not HasEnoughItems(UserIndex, ObjIndex, TotalOfferItems(ObjIndex, UserIndex) + Amount) Then

138             Call WriteCommerceChat(UserIndex, "No tienes esa cantidad.", FontTypeNames.FONTTYPE_TALK)

                Exit Sub

            End If

140         If Amount < 0 Then
142             If Abs(Amount) > .ComUsu.Cant(OfferSlot) Then
144                 Amount = .ComUsu.Cant(OfferSlot) * (-1)

                End If

            End If

146         If ItemNewbie(ObjIndex) Then
148             Call WriteCancelOfferItem(UserIndex, OfferSlot)
                Exit Sub
            End If

            If ObjData(ObjIndex).NoSeSaca = 1 Then
                Call WriteCancelOfferItem(UserIndex, OfferSlot)
                Exit Sub
            End If

            If ObjData(ObjIndex).NoSeSaca = 1 Then
                Call WriteCommerceChat(UserIndex, "No puedes vender ese objeto.", FontTypeNames.FONTTYPE_TALK)
                Call WriteCancelOfferItem(UserIndex, OfferSlot)
                Exit Sub
            End If

            If ObjData(ObjIndex).Caos = 1 Or ObjData(ObjIndex).Real = 1 Then
                Call WriteCommerceChat(UserIndex, "No puedes vender items faccionarios.", FontTypeNames.FONTTYPE_TALK)
                Call WriteCancelOfferItem(UserIndex, OfferSlot)
                Exit Sub
            End If

            'Don't allow to sell boats if they are equipped (you can't take them off in the water and causes trouble)
150         If .flags.Navegando = 1 Then
152             If .Invent.BarcoSlot = Slot Then
154                 Call WriteCommerceChat(UserIndex, "No puedes vender tu barco mientras lo estés usando.", FontTypeNames.FONTTYPE_TALK)
                    Exit Sub

                End If

            End If

        End If

162     Call AgregarOferta(UserIndex, OfferSlot, ObjIndex, Amount, Slot = FLAGORO)

164     Call EnviarOferta(tUser, OfferSlot)

    End With

    Exit Sub
HandleUserCommerceOffer_Err:
166 Call LogError("TDSLegacy.Protocol.HandleUserCommerceOffer en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildAcceptPeace(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildAcceptPeace_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim otherClanIndex As String

102     guild = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

106     If guild > 0 And guild <= CANTIDADDECLANES Then
108         otherClanIndex = modGuilds.r_AceptarPropuestaDePaz(UserIndex, guild, ErrorStr)

110         If otherClanIndex = 0 Then
112             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
114             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con el clan: " & guilds(guild).GuildName & ".", FontTypeNames.FONTTYPE_GUILD))
116             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con el clan: " & modGuilds.GuildName(.GuildIndex) & ".", FontTypeNames.FONTTYPE_GUILD))

            End If

        End If

    End With

    Exit Sub
HandleGuildAcceptPeace_Err:
118 Call LogError("TDSLegacy.Protocol.HandleGuildAcceptPeace en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRejectAlliance(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRejectAlliance_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim otherClanIndex As String

102     guild = Message.ReadInt

104     If guild > 0 And guild <= CANTIDADDECLANES Then
106         otherClanIndex = modGuilds.r_RechazarPropuestaDeAlianza(UserIndex, guild, ErrorStr)

108         If otherClanIndex = 0 Then
110             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
112             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan rechazado la propuesta de alianza de " & guild, FontTypeNames.FONTTYPE_GUILD))
114             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " ha rechazado nuestra propuesta de alianza con su clan.", FontTypeNames.FONTTYPE_GUILD))

            End If

        End If

    End With

    Exit Sub
HandleGuildRejectAlliance_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildRejectAlliance en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRejectPeace(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRejectPeace_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim otherClanIndex As String

102     guild = Message.ReadInt

104     If guild > 0 And guild <= CANTIDADDECLANES Then
106         otherClanIndex = modGuilds.r_RechazarPropuestaDePaz(UserIndex, guild, ErrorStr)

108         If otherClanIndex = 0 Then
110             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
112             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan rechazado la propuesta de paz de " & guilds(guild).GuildName & ".", FontTypeNames.FONTTYPE_GUILD))
114             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " ha rechazado nuestra propuesta de paz con su clan.", FontTypeNames.FONTTYPE_GUILD))

            End If

        End If

    End With

    Exit Sub
HandleGuildRejectPeace_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildRejectPeace en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildAcceptAlliance(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildAcceptAlliance_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim otherClanIndex As String

102     guild = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

106     If guild > 0 And guild <= CANTIDADDECLANES Then

108         otherClanIndex = modGuilds.r_AceptarPropuestaDeAlianza(UserIndex, guild, ErrorStr)

110         If otherClanIndex = 0 Then
112             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
114             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la alianza con " & guilds(guild).GuildName & ".", FontTypeNames.FONTTYPE_GUILD))
116             Call SendData(SendTarget.ToGuildMembers, otherClanIndex, PrepareMessageConsoleMsg("Tu clan ha firmado la paz con " & modGuilds.GuildName(.GuildIndex) & ".", FontTypeNames.FONTTYPE_GUILD))

            End If

        End If

    End With

    Exit Sub
HandleGuildAcceptAlliance_Err:
118 Call LogError("TDSLegacy.Protocol.HandleGuildAcceptAlliance en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildOfferPeace(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildOfferPeace_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim proposal As String

        Dim ErrorStr As String

102     guild = Message.ReadInt()
104     proposal = Message.ReadString16()

106     If CANTIDADDECLANES > 0 Then
108         If guild > 0 And guild <= CANTIDADDECLANES Then
110             If modGuilds.r_ClanGeneraPropuesta(UserIndex, guild, RELACIONES_GUILD.paz, proposal, ErrorStr) Then
112                 Call WriteConsoleMsg(UserIndex, "Propuesta de paz enviada.", FontTypeNames.FONTTYPE_GUILD)
                Else
114                 Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)

                End If

            End If

        End If

    End With

    Exit Sub
HandleGuildOfferPeace_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildOfferPeace en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildOfferAlliance(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildOfferAlliance_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim proposal As String

        Dim ErrorStr As String

102     guild = Message.ReadInt()
104     proposal = Message.ReadString16()

106     If CANTIDADDECLANES > 0 Then

108         If guild > 0 And guild <= CANTIDADDECLANES Then
110             If modGuilds.r_ClanGeneraPropuesta(UserIndex, guild, RELACIONES_GUILD.ALIADOS, proposal, ErrorStr) Then
112                 Call WriteConsoleMsg(UserIndex, "Propuesta de alianza enviada.", FontTypeNames.FONTTYPE_GUILD)
                Else
114                 Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)

                End If

            End If

        End If

    End With

    Exit Sub
HandleGuildOfferAlliance_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildOfferAlliance en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildAllianceDetails(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildAllianceDetails_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim details As String

102     guild = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

106     If guild > 0 And guild <= CANTIDADDECLANES Then
108         details = modGuilds.r_VerPropuesta(UserIndex, guild, RELACIONES_GUILD.ALIADOS, ErrorStr)

110         If LenB(details) = 0 Then
112             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
114             Call WriteOfferDetails(UserIndex, details)

            End If

        End If

    End With

    Exit Sub
HandleGuildAllianceDetails_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildAllianceDetails en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildPeaceDetails(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildPeaceDetails_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim details As String

102     guild = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

106     If guild > 0 And guild <= CANTIDADDECLANES Then

108         details = modGuilds.r_VerPropuesta(UserIndex, guild, RELACIONES_GUILD.paz, ErrorStr)

110         If LenB(details) = 0 Then
112             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
114             Call WriteOfferDetails(UserIndex, details)

            End If

        End If

    End With

    Exit Sub
HandleGuildPeaceDetails_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildPeaceDetails en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRequestJoinerInfo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRequestJoinerInfo_Err

100 With UserList(UserIndex)

        Dim User As String

        Dim details As String

102     User = Message.ReadString16()

104     details = modGuilds.a_DetallesAspirante(UserIndex, User)

106     If LenB(details) = 0 Then
108         Call WriteConsoleMsg(UserIndex, "El personaje no ha mandado solicitud, o no estás habilitado para verla.", FontTypeNames.FONTTYPE_GUILD)
        Else
110         Call WriteShowUserRequest(UserIndex, details)

        End If

    End With

    Exit Sub
HandleGuildRequestJoinerInfo_Err:
112 Call LogError("TDSLegacy.Protocol.HandleGuildRequestJoinerInfo en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildAlliancePropList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildAlliancePropList_Err

100 Call WriteAlianceProposalsList(UserIndex, r_ListaDePropuestas(UserIndex, RELACIONES_GUILD.ALIADOS))

    Exit Sub
HandleGuildAlliancePropList_Err:
102 Call LogError("TDSLegacy.Protocol.HandleGuildAlliancePropList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildPeacePropList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildPeacePropList_Err

100 Call WritePeaceProposalsList(UserIndex, r_ListaDePropuestas(UserIndex, RELACIONES_GUILD.paz))

    Exit Sub
HandleGuildPeacePropList_Err:
102 Call LogError("TDSLegacy.Protocol.HandleGuildPeacePropList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildDeclareWar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildDeclareWar_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim ErrorStr As String

        Dim otherGuildIndex As Integer

102     guild = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

106     If guild > 0 And guild <= CANTIDADDECLANES Then
108         otherGuildIndex = modGuilds.r_DeclararGuerra(UserIndex, guild, ErrorStr)

110         If otherGuildIndex = 0 Then
112             Call WriteConsoleMsg(UserIndex, ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
114             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("TU CLAN HA ENTRADO EN GUERRA CON " & guilds(guild).GuildName & ".", FontTypeNames.FONTTYPE_GUILD))
116             Call SendData(SendTarget.ToGuildMembers, otherGuildIndex, PrepareMessageConsoleMsg(modGuilds.GuildName(.GuildIndex) & " LE DECLARA LA GUERRA A TU CLAN.", FontTypeNames.FONTTYPE_GUILD))
118             Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))
120             Call SendData(SendTarget.ToGuildMembers, otherGuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))

            End If

        End If

    End With

    Exit Sub
HandleGuildDeclareWar_Err:
122 Call LogError("TDSLegacy.Protocol.HandleGuildDeclareWar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildNewWebsite(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildNewWebsite_Err

100 With UserList(UserIndex)
102     Call modGuilds.ActualizarWebSite(UserIndex, Message.ReadString16())

    End With

    Exit Sub
HandleGuildNewWebsite_Err:
104 Call LogError("TDSLegacy.Protocol.HandleGuildNewWebsite en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildAcceptNewMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildAcceptNewMember_Err

100 With UserList(UserIndex)

        Dim ErrorStr As String

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If Not modGuilds.a_AceptarAspirante(UserIndex, UserName, ErrorStr) Then
106         Call WriteConsoleMsg(UserIndex, "Guilds> " & ErrorStr, FontTypeNames.FONTTYPE_GUILD)
        Else
108         tUser = NameIndex(UserName)

110         If tUser > 0 Then
112             Call modGuilds.m_ConectarMiembroAClan(tUser, .GuildIndex)
114             Call RefreshCharStatus(tUser)

            End If

116         Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Guilds> " & UserName & " ha sido aceptado como miembro del clan.", FontTypeNames.FONTTYPE_GUILD))
118         Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessagePlayWave(43, NO_3D_SOUND, NO_3D_SOUND))

        End If

    End With

    Exit Sub
HandleGuildAcceptNewMember_Err:
120 Call LogError("TDSLegacy.Protocol.HandleGuildAcceptNewMember en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRejectNewMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRejectNewMember_Err

100 With UserList(UserIndex)

        Dim ErrorStr As String

        Dim UserName As String

        Dim Reason As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()
104     Reason = Message.ReadString16()

106     If Not modGuilds.a_RechazarAspirante(UserIndex, UserName, ErrorStr) Then
108         Call WriteConsoleMsg(UserIndex, "Guilds> " & ErrorStr, FontTypeNames.FONTTYPE_GUILD)
        Else
110         tUser = NameIndex(UserName)

112         If tUser > 0 Then
114             Call WriteConsoleMsg(tUser, "Guilds> " & ErrorStr & " : " & Reason, FontTypeNames.FONTTYPE_GUILD)
            Else
                'hay que grabar en el char su rechazo
116             Call modGuilds.a_RechazarAspiranteChar(UserName, .GuildIndex, Reason)

            End If

        End If

    End With

    Exit Sub
HandleGuildRejectNewMember_Err:
118 Call LogError("TDSLegacy.Protocol.HandleGuildRejectNewMember en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildKickMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildKickMember_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim GuildIndex As Integer

102     UserName = Message.ReadString16()

104     GuildIndex = modGuilds.m_EcharMiembroDeClan(UserIndex, UserName)

106     If GuildIndex > 0 Then
108         Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg("Guilds> " & UserName & " fue expulsado del clan.", FontTypeNames.FONTTYPE_GUILD))
110         Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessagePlayWave(45, NO_3D_SOUND, NO_3D_SOUND))

            'Else
            '    Call WriteConsoleMsg(UserIndex, "No puedes expulsar ese personaje del clan.", FontTypeNames.FONTTYPE_GUILD)
        End If

    End With

    Exit Sub
HandleGuildKickMember_Err:
112 Call LogError("TDSLegacy.Protocol.HandleGuildKickMember en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildUpdateNews(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildUpdateNews_Err

100 With UserList(UserIndex)
102     Call modGuilds.ActualizarNoticias(UserIndex, Message.ReadString16())

    End With

    Exit Sub
HandleGuildUpdateNews_Err:
104 Call LogError("TDSLegacy.Protocol.HandleGuildUpdateNews en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildOpenElections(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildOpenElections_Err

100 With UserList(UserIndex)

        Dim Error As String

102     If Not modGuilds.v_AbrirElecciones(UserIndex, Error) Then
104         Call WriteConsoleMsg(UserIndex, Error, FontTypeNames.FONTTYPE_GUILD)
        Else
106         Call SendData(SendTarget.ToGuildMembers, .GuildIndex, PrepareMessageConsoleMsg("Guilds> " & "¡Han comenzado las elecciones del clan! Puedes votar escribiendo /VOTO seguido del nombre del personaje, por ejemplo: /VOTO " & .Name, FontTypeNames.FONTTYPE_GUILD))

        End If

    End With

    Exit Sub
HandleGuildOpenElections_Err:
108 Call LogError("TDSLegacy.Protocol.HandleGuildOpenElections en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildMemberInfo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildMemberInfo_Err

100 With UserList(UserIndex)
102     Call modGuilds.SendDetallesPersonaje(UserIndex, Message.ReadString16())

    End With

    Exit Sub
HandleGuildMemberInfo_Err:
104 Call LogError("TDSLegacy.Protocol.HandleGuildMemberInfo en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRequestMembership(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRequestMembership_Err

100 With UserList(UserIndex)

        Dim guild As Integer

        Dim application As String

        Dim ErrorStr As String

102     guild = Message.ReadInt()
104     application = Message.ReadString16()

        Dim Clanes() As Integer
        Dim i As Long
        Dim count As Integer
        If CANTIDADDECLANES = 0 Then
            ReDim Clanes(0 To 0) As Integer
        Else
            count = 0
            For i = 1 To CANTIDADDECLANES
                If guilds(i).GetDisuelto = 0 Then
                    ReDim Preserve Clanes(0 To count) As Integer
                    Clanes(count) = i
                    count = count + 1
                End If
            Next i
        End If
        If count > 0 Then
            ReDim Preserve Clanes(0 To count - 1) As Integer
        Else
            ReDim Clanes(0 To -1) As Integer
        End If

106     If Clanes(guild - 1) > 0 And Clanes(guild - 1) <= CANTIDADDECLANES Then
108         If Not modGuilds.a_NuevoAspirante(UserIndex, Clanes(guild - 1), application, ErrorStr) Then
110             Call WriteConsoleMsg(UserIndex, "Guilds> " & ErrorStr, FontTypeNames.FONTTYPE_GUILD)
            Else
112             WriteMensajes UserIndex, e_Mensajes.Mensaje_196

            End If

        End If

    End With

    Exit Sub
HandleGuildRequestMembership_Err:
114 Call LogError("TDSLegacy.Protocol.HandleGuildRequestMembership en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildRequestDetails(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildRequestDetails_Err

100 With UserList(UserIndex)

        Dim GIndex As Integer

102     GIndex = Message.ReadInt

104     If CANTIDADDECLANES = 0 Then Exit Sub

        Dim Clanes() As Integer
        Dim i As Long
        Dim count As Integer
        If CANTIDADDECLANES = 0 Then
            ReDim Clanes(0 To 0) As Integer
        Else
            count = 0
            For i = 1 To CANTIDADDECLANES
                If guilds(i).GetDisuelto = 0 Then
                    ReDim Preserve Clanes(0 To count) As Integer
                    Clanes(count) = i
                    count = count + 1
                End If
            Next i
        End If
        If count > 0 Then
            ReDim Preserve Clanes(0 To count - 1) As Integer
        Else
            ReDim Clanes(0 To -1) As Integer
        End If


106     If Clanes(GIndex - 1) > 0 And Clanes(GIndex - 1) <= CANTIDADDECLANES Then
108         Call modGuilds.SendGuildDetails(UserIndex, Clanes(GIndex - 1))
        Else
110         Call WriteConsoleMsg(UserIndex, "Guilds> " & "Ese clan no existe.", FontTypeNames.FONTTYPE_GUILD)

        End If

    End With

    Exit Sub
HandleGuildRequestDetails_Err:
112 Call LogError("TDSLegacy.Protocol.HandleGuildRequestDetails en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleOnline(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleOnline_Err

100 With UserList(UserIndex)

        Dim SB As cStringBuilder

102     Set SB = New cStringBuilder

        Dim i As Long

        Dim isGM As Boolean
        isGM = EsGM(UserIndex)
        Dim count As Long

104     For i = 1 To LastUser

106         If Len(UserList(i).Name) > 0 Then

108             count = count + 1

110             If Not isGM And (UserList(i).flags.Privilegios >= PlayerType.Consejero Or UserList(i).Clase = eClass.Woodcutter Or UserList(i).Clase = eClass.Blacksmith Or UserList(i).Clase = eClass.Fisherman Or UserList(i).Clase = eClass.Miner) Then
112                 'privado = privado + 1
                Else
114                 Call SB.Append(UserList(i).Name)

116                 If i <> LastUser Then Call SB.Append(", ")

                End If

            End If

118     Next i

        Dim strin As String

120     strin = SB.toString

122     If count > 0 And Len(strin) > 2 Then
124         If Right(strin, 2) = ", " Then
126             strin = Left(strin, Len(strin) - 2)

            End If

128         strin = strin & vbNewLine

        End If

130     Set SB = Nothing

        ' @@ OLD STYLE?
132     If CONFIG_INI_SHOWONLINENAME = 0 And Not isGM Then
134         Call WriteConsoleMsg(UserIndex, "Numero de usuarios: " & CStr(count) + F_ONLINES & ".", FontTypeNames.FONTTYPE_INFO)
        Else
136         Call WriteConsoleMsg(UserIndex, strin & "Numero de usuarios: " & CStr(count) + F_ONLINES & "." & IIf(Not isGM, vbNewLine & "Por razones de privacidad y comodidad, los nombres de los trabajadores y staff no son visbles.", ""), FontTypeNames.FONTTYPE_INFO)
        End If

    End With

    Exit Sub
HandleOnline_Err:
138 Call LogError("TDSLegacy.Protocol.HandleOnline en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleQuit(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleQuit_Err

    Dim tUser As Integer

100 With UserList(UserIndex)

102     If .flags.Paralizado = 1 Then
104         WriteMensajes UserIndex, e_Mensajes.Mensaje_255
            Exit Sub

        End If

        'exit secure commerce
106     If .ComUsu.DestUsu > 0 Then
108         tUser = .ComUsu.DestUsu

110         If UserList(tUser).flags.UserLogged Then
112             If UserList(tUser).ComUsu.DestUsu = UserIndex Then

114                 WriteMensajes tUser, e_Mensajes.Mensaje_129
116                 Call FinComerciarUsu(tUser)

                End If

            End If

118         WriteMensajes UserIndex, e_Mensajes.Mensaje_256
120         Call FinComerciarUsu(UserIndex)

        End If

122     Call Cerrar_Usuario(UserIndex)

    End With

    Exit Sub
HandleQuit_Err:
124 Call LogError("TDSLegacy.Protocol.HandleQuit en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildLeave(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildLeave_Err

    Dim GuildIndex As Integer

100 With UserList(UserIndex)

        'obtengo el guildindex
102     GuildIndex = m_EcharMiembroDeClan(UserIndex, .Name)

104     If GuildIndex > 0 Then
106         Call WriteConsoleMsg(UserIndex, "Dejas el clan.", FontTypeNames.FONTTYPE_GUILD)
108         Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg(.Name & " deja el clan.", FontTypeNames.FONTTYPE_GUILD))
        Else
110         Call WriteConsoleMsg(UserIndex, "Tú no puedes salir de este clan.", FontTypeNames.FONTTYPE_GUILD)

        End If

    End With

    Exit Sub
HandleGuildLeave_Err:
112 Call LogError("TDSLegacy.Protocol.HandleGuildLeave en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestAccountState(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestAccountState_Err

    Dim earnings As Integer

    Dim Percentage As Integer

100 With UserList(UserIndex)

        'Dead people can't check their accounts
102     If .flags.Muerto = 1 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

110     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 3 Then
112         Call WriteConsoleMsg(UserIndex, "Estás demasiado lejos del banquero.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

114     Select Case Npclist(.flags.TargetNPC).NPCtype

        Case eNPCType.Banquero
116         Call WriteChatOverHead(UserIndex, "Tienes " & .Stats.Banco & " monedas de oro en tu cuenta.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

118     Case eNPCType.Timbero

120         If Not .flags.Privilegios < PlayerType.Consejero Then
122             earnings = Apuestas.Ganancias - Apuestas.Perdidas

124             If earnings >= 0 And Apuestas.Ganancias <> 0 Then
126                 Percentage = Int(earnings * 100 / Apuestas.Ganancias)

                End If

128             If earnings < 0 And Apuestas.Perdidas <> 0 Then
130                 Percentage = Int(earnings * 100 / Apuestas.Perdidas)

                End If

132             Call WriteConsoleMsg(UserIndex, "Entradas: " & Apuestas.Ganancias & " Salida: " & Apuestas.Perdidas & " Ganancia Neta: " & earnings & " (" & Percentage & "%) Jugadas: " & Apuestas.Jugadas, FontTypeNames.FONTTYPE_INFO)

            End If

        End Select

    End With

    Exit Sub
HandleRequestAccountState_Err:
134 Call LogError("TDSLegacy.Protocol.HandleRequestAccountState en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePetStand(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePetStand_Err

100 With UserList(UserIndex)

        'Dead people can't use pets
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        'Make sure it's close enough
110     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
112         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

        'Make sure it's his pet
114     If Npclist(.flags.TargetNPC).MaestroUser <> UserIndex Then Exit Sub

        'Do it!
116     Npclist(.flags.TargetNPC).Movement = TipoAI.ESTATICO

118     Call Expresar(.flags.TargetNPC, UserIndex)

    End With

    Exit Sub
HandlePetStand_Err:
120 Call LogError("TDSLegacy.Protocol.HandlePetStand en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePetFollow(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePetFollow_Err

100 With UserList(UserIndex)

        'Dead users can't use pets
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        'Make sure it's close enough
110     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
112         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

        'Make usre it's the user's pet
114     If Npclist(.flags.TargetNPC).MaestroUser <> UserIndex Then Exit Sub

        'Do it
116     Call FollowAmo(.flags.TargetNPC)

118     Call Expresar(.flags.TargetNPC, UserIndex)

    End With

    Exit Sub
HandlePetFollow_Err:
120 Call LogError("TDSLegacy.Protocol.HandlePetFollow en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleReleasePet(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleReleasePet_Err

100 With UserList(UserIndex)

        'Dead users can't use pets
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        'Make sure it's close enough
110     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
112         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

        'Make usre it's the user's pet
114     If Npclist(.flags.TargetNPC).MaestroUser <> UserIndex Then Exit Sub

        'Do it
116     Call QuitarPet(UserIndex, .flags.TargetNPC)

    End With

    Exit Sub
HandleReleasePet_Err:
118 Call LogError("TDSLegacy.Protocol.HandleReleasePet en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTrainList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTrainList_Err

100 With UserList(UserIndex)

        'Dead users can't use pets
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        'Make sure it's close enough
110     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
112         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

        'Make sure it's the trainer
114     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Entrenador Then Exit Sub

116     Call WriteTrainerCreatureList(UserIndex, .flags.TargetNPC)

    End With

    Exit Sub
HandleTrainList_Err:
118 Call LogError("TDSLegacy.Protocol.HandleTrainList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRest_Err

100 With UserList(UserIndex)

        'Dead users can't use pets
102     If .flags.Muerto = 1 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

106     If HayOBJarea(.Pos, FOGATA) Then
108         Call WriteRestOK(UserIndex)

110         If Not .flags.Descansar Then
112             WriteMensajes UserIndex, e_Mensajes.Mensaje_259
            Else
114             WriteMensajes UserIndex, e_Mensajes.Mensaje_260

            End If

116         .flags.Descansar = Not .flags.Descansar
        Else

118         If .flags.Descansar Then
120             Call WriteRestOK(UserIndex)
122             WriteMensajes UserIndex, e_Mensajes.Mensaje_260

124             .flags.Descansar = False
                Exit Sub

            End If

126         WriteMensajes UserIndex, e_Mensajes.Mensaje_261

        End If

    End With

    Exit Sub
HandleRest_Err:
128 Call LogError("TDSLegacy.Protocol.HandleRest en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleMeditate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleMeditate_Err

100 With UserList(UserIndex)

        'Dead users can't use pets
102     If .flags.Muerto = 1 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Can he meditate?
106     If .Stats.MaxMAN = 0 Then
108         WriteMensajes UserIndex, e_Mensajes.Mensaje_45
            Exit Sub

        End If

110     Call WriteMeditateToggle(UserIndex)

        'FlushBuffer UserIndex
112     If .flags.Meditando Then WriteMensajes UserIndex, e_Mensajes.Mensaje_216

114     .flags.Meditando = Not .flags.Meditando

        'Barrin 3/10/03 Tiempo de inicio al meditar
116     If .flags.Meditando Then

118         .Char.loops = INFINITE_LOOPS

            'Show proper FX according to level
120         If .Stats.ELV < 15 Then
122             .Char.FX = FXIDs.FXMEDITARCHICO

                'ElseIf .Stats.ELV < 25 Then
                '     .Char.FX = FXIDs.FXMEDITARMEDIANO

124         ElseIf .Stats.ELV < 30 Then
126             .Char.FX = FXIDs.FXMEDITARMEDIANO

128         ElseIf .Stats.ELV < 45 Then
130             .Char.FX = FXIDs.FXMEDITARGRANDE

            Else
132             .Char.FX = FXIDs.FXMEDITARXXGRANDE

            End If

134         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, .Char.FX, INFINITE_LOOPS))

136         If .Counters.tInicioMeditar = 0 Then .Counters.tInicioMeditar = TIEMPO_INICIOMEDITAR
138         WriteMensajes UserIndex, e_Mensajes.Mensaje_262

        Else
140         .Counters.bPuedeMeditar = False

142         .Char.FX = 0
144         .Char.loops = 0
146         Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, 0, 0))

        End If

    End With

    Exit Sub
HandleMeditate_Err:
148 Call LogError("TDSLegacy.Protocol.HandleMeditate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleResucitate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleResucitate_Err

100 With UserList(UserIndex)

        'Se asegura que el target es un npc
102     If .flags.TargetNPC = 0 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        'Validate NPC and make sure player is dead
106     If (Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Revividor And (Npclist(.flags.TargetNPC).NPCtype <> eNPCType.ResucitadorNewbie Or Not EsNewbie(UserIndex))) Or .flags.Muerto = 0 Then Exit Sub

        'Make sure it's close enough
108     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 10 Then
110         WriteMensajes UserIndex, e_Mensajes.Mensaje_9
            Exit Sub

        End If

112     Call RevivirUsuario(UserIndex, True)
114     WriteMensajes UserIndex, e_Mensajes.Mensaje_296

    End With

    Exit Sub
HandleResucitate_Err:
116 Call LogError("TDSLegacy.Protocol.HandleResucitate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleConsultation(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleConsultation_Err

    Dim UserConsulta As Integer

100 With UserList(UserIndex)

        ' Comando exclusivo para gms
102     If Not EsGM(UserIndex) Then Exit Sub

104     UserConsulta = .flags.TargetUser

        'Se asegura que el target es un usuario
106     If UserConsulta = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

        ' No podes ponerte a vos mismo en modo consulta.
110     If UserConsulta = UserIndex Then Exit Sub

        ' No podes estra en consulta con otro gm
112     If EsGM(UserConsulta) Then
114         Call WriteConsoleMsg(UserIndex, "No puedes iniciar el modo consulta con otro administrador.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

        Dim UserName As String

116     UserName = UserList(UserConsulta).Name

        ' Si ya estaba en consulta, termina la consulta
118     If UserList(UserConsulta).flags.EnConsulta Then
120         Call WriteConsoleMsg(UserIndex, "Has terminado el modo consulta con " & UserName & ".", FontTypeNames.FONTTYPE_INFOBOLD)
122         Call WriteConsoleMsg(UserConsulta, "Has terminado el modo consulta.", FontTypeNames.FONTTYPE_INFOBOLD)
124         Call LogGM(.Name, "Termino consulta con " & UserName)

126         UserList(UserConsulta).flags.EnConsulta = False

            ' Sino la inicia
        Else
128         Call WriteConsoleMsg(UserIndex, "Has iniciado el modo consulta con " & UserName & ".", FontTypeNames.FONTTYPE_INFOBOLD)
130         Call WriteConsoleMsg(UserConsulta, "Has iniciado el modo consulta.", FontTypeNames.FONTTYPE_INFOBOLD)
132         Call LogGM(.Name, "Inicio consulta con " & UserName)

134         With UserList(UserConsulta)
136             .flags.EnConsulta = True

                ' Pierde invi u ocu
138             If .flags.invisible = 1 Or .flags.oculto = 1 Then
140                 .flags.oculto = 0
142                 .flags.invisible = 0
144                 .Counters.TiempoOculto = 0
146                 .Counters.Invisibilidad = 0

148                 Call UsUaRiOs.SetInvisible(UserConsulta, UserList(UserConsulta).Char.CharIndex, UserList(UserConsulta).flags.invisible = 1, UserList(UserConsulta).flags.oculto = 1)

                End If

            End With

        End If

150     Call UsUaRiOs.SetConsulatMode(UserConsulta)

    End With

    Exit Sub
HandleConsultation_Err:
152 Call LogError("TDSLegacy.Protocol.HandleConsultation en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleHeal(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleHeal_Err

100 With UserList(UserIndex)

        'Se asegura que el target es un npc
102     If .flags.TargetNPC = 0 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

106     If (Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Revividor And Npclist(.flags.TargetNPC).NPCtype <> eNPCType.ResucitadorNewbie) Or .flags.Muerto <> 0 Then Exit Sub

108     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 10 Then
110         WriteMensajes UserIndex, e_Mensajes.Mensaje_8
            Exit Sub

        End If

112     .Stats.MinHP = .Stats.MaxHP

114     Call WriteUpdateHP(UserIndex)

116     WriteMensajes UserIndex, e_Mensajes.Mensaje_17

    End With

    Exit Sub
HandleHeal_Err:
118 Call LogError("TDSLegacy.Protocol.HandleHeal en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestStats(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestStats_Err

100 Call SendUserStatsTxt(UserIndex, UserIndex)

    Exit Sub
HandleRequestStats_Err:
102 Call LogError("TDSLegacy.Protocol.HandleRequestStats en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleHelp(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleHelp_Err

100 Call SendHelp(UserIndex)

    Exit Sub
HandleHelp_Err:
102 Call LogError("TDSLegacy.Protocol.HandleHelp en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCommerceStart(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCommerceStart_Err

    Dim i As Integer

100 With UserList(UserIndex)

        'Dead people can't commerce
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Is it already in commerce mode??
106     If .flags.Comerciando Then

108         WriteMensajes UserIndex, e_Mensajes.Mensaje_27
            Exit Sub

        End If

        'Validate target NPC
110     If .flags.TargetNPC > 0 Then

            'Does the NPC want to trade??
112         If Npclist(.flags.TargetNPC).Comercia = 0 Then
114             If LenB(Npclist(.flags.TargetNPC).Desc) <> 0 Then
116                 Call WriteChatOverHead(UserIndex, "No tengo ningún interés en comerciar.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

                End If

                Exit Sub

            End If

118         If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 3 Then
120             Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_7)
                Exit Sub

            End If

            'Start commerce....
122         Call IniciarComercioNPC(UserIndex)
124         Call NPCs.AddToNpcTradingArray(UserIndex, UserList(UserIndex).flags.TargetNPC)
            '[Alejo]
126     ElseIf .flags.TargetUser > 0 Then

            'User commerce...
            'Can he commerce??
128         If .flags.Privilegios = PlayerType.Consejero Then
130             Call WriteConsoleMsg(UserIndex, "No puedes vender ítems.", FontTypeNames.FONTTYPE_WARNING)
                Exit Sub

            End If

            'Is the other one dead??
132         If UserList(.flags.TargetUser).flags.Muerto = 1 Then
134             WriteMensajes UserIndex, e_Mensajes.Mensaje_264
                Exit Sub

            End If

            'Is it me??
136         If .flags.TargetUser = UserIndex Then
138             WriteMensajes UserIndex, e_Mensajes.Mensaje_265
                Exit Sub

            End If

            'Check distance
140         If distancia(UserList(.flags.TargetUser).Pos, .Pos) > 3 Then
142             WriteMensajes UserIndex, e_Mensajes.Mensaje_5
                Exit Sub

            End If

            'Is he already trading?? is it with me or someone else??
144         If UserList(.flags.TargetUser).flags.Comerciando = True And UserList(.flags.TargetUser).ComUsu.DestUsu <> UserIndex Then
146             WriteMensajes UserIndex, e_Mensajes.Mensaje_266
                Exit Sub

            End If

            'Check if EL está retando
148         If UserList(.flags.TargetUser).sReto.Reto_Index > 0 Or UserList(.flags.TargetUser).mReto.Reto_Index > 0 Then
150             WriteMensajes UserIndex, e_Mensajes.Mensaje_431
                Exit Sub

            End If

            'Check if YO estoy retando
152         If UserList(UserIndex).sReto.Reto_Index > 0 Or UserList(UserIndex).mReto.Reto_Index > 0 Then
154             WriteMensajes UserIndex, e_Mensajes.Mensaje_431
                Exit Sub

            End If

            'Initialize some variables...
156         .ComUsu.DestUsu = .flags.TargetUser
158         .ComUsu.DestNick = UserList(.flags.TargetUser).Name

160         For i = 1 To MAX_OFFER_SLOTS
162             .ComUsu.Cant(i) = 0
164             .ComUsu.objeto(i) = 0
166         Next i

168         .ComUsu.goldAmount = 0

170         .ComUsu.Acepto = False
172         .ComUsu.Confirmo = False

            'Rutina para comerciar con otro usuario
174         Call IniciarComercioConUsuario(UserIndex, .flags.TargetUser)
        Else
176         WriteMensajes UserIndex, e_Mensajes.Mensaje_4

        End If

    End With

    Exit Sub
HandleCommerceStart_Err:
178 Call LogError("TDSLegacy.Protocol.HandleCommerceStart en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankStart(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankStart_Err

100 With UserList(UserIndex)

        'Dead people can't commerce
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

106     If .flags.Comerciando Then
108         WriteMensajes UserIndex, e_Mensajes.Mensaje_27
            Exit Sub

        End If

        'Validate target NPC
110     If .flags.TargetNPC > 0 Then
112         If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 3 Then
114             WriteMensajes UserIndex, e_Mensajes.Mensaje_7
                Exit Sub

            End If

            'If it's the banker....
116         If Npclist(.flags.TargetNPC).NPCtype = eNPCType.Banquero Then
118             Call IniciarDeposito(UserIndex)

            End If

        Else
120         WriteMensajes UserIndex, e_Mensajes.Mensaje_299

        End If

    End With

    Exit Sub
HandleBankStart_Err:
122 Call LogError("TDSLegacy.Protocol.HandleBankStart en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleEnlist(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleEnlist_Err

100 With UserList(UserIndex)

        'Validate target NPC
102     If .flags.TargetNPC = 0 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

106     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Noble Or .flags.Muerto <> 0 Then Exit Sub

108     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 4 Then
110         Call WriteConsoleMsg(UserIndex, "Debes acercarte más.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

112     If Npclist(.flags.TargetNPC).flags.faccion = 0 Then
114         Call EnlistarArmadaReal(UserIndex)
        Else
116         Call EnlistarCaos(UserIndex)

        End If

    End With

    Exit Sub
HandleEnlist_Err:
118 Call LogError("TDSLegacy.Protocol.HandleEnlist en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleInformation(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleInformation_Err

    Dim Matados As Integer

    Dim Diferencia As Integer

100 With UserList(UserIndex)

        'Validate target NPC
102     If .flags.TargetNPC = 0 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

106     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Noble Or .flags.Muerto <> 0 Then Exit Sub

108     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 4 Then
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

114     If Npclist(.flags.TargetNPC).flags.faccion = 0 Then
116         If .faccion.ArmadaReal = 0 Then
118             Call WriteChatOverHead(UserIndex, "¡¡No perteneces a las tropas reales!!", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

120         Matados = .faccion.CriminalesMatados
122         Diferencia = RequisitosReal(.faccion.RecompensasReal).Matados - Matados

124         If Diferencia > 0 Then
126             Call WriteChatOverHead(UserIndex, "Tu deber es combatir criminales, mata " & Diferencia & " criminales más y te daré una recompensa.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
            Else
128             Call WriteChatOverHead(UserIndex, "Tu deber es combatir criminales, y ya has matado los suficientes como para merecerte una recompensa.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

            End If

        Else

130         If .faccion.FuerzasCaos = 0 Then
132             Call WriteChatOverHead(UserIndex, "¡¡No perteneces a la legión oscura!!", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

134         Matados = .faccion.CiudadanosMatados
136         Diferencia = RequisitosReal(.faccion.RecompensasCaos).Matados - Matados

138         If Diferencia > 0 Then
140             Call WriteChatOverHead(UserIndex, "Tu deber es sembrar el caos y la desesperanza, mata " & Diferencia & " ciudadanos más y te daré una recompensa.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
            Else
142             Call WriteChatOverHead(UserIndex, "Tu deber es sembrar el caos y la desesperanza, y creo que estás en condiciones de merecer una recompensa.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

            End If

        End If

    End With

    Exit Sub
HandleInformation_Err:
144 Call LogError("TDSLegacy.Protocol.HandleInformation en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleReward(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleReward_Err

100 With UserList(UserIndex)

        'Validate target NPC
102     If .flags.TargetNPC = 0 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

106     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Noble Or .flags.Muerto <> 0 Then Exit Sub

108     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 4 Then
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

112     If Npclist(.flags.TargetNPC).flags.faccion = 0 Then
114         If .faccion.ArmadaReal = 0 Then
116             Call WriteChatOverHead(UserIndex, "¡¡No perteneces a las tropas reales!!", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

118         Call RecompensaArmadaReal(UserIndex)
        Else

120         If .faccion.FuerzasCaos = 0 Then
122             Call WriteChatOverHead(UserIndex, "¡¡No perteneces a la legión oscura!!", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
                Exit Sub

            End If

124         Call RecompensaCaos(UserIndex)

        End If

    End With

    Exit Sub
HandleReward_Err:
126 Call LogError("TDSLegacy.Protocol.HandleReward en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUpTime(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUpTime_Err

    Dim Time As Long

    Dim UpTimeStr As String

    'Get total time in seconds
100 Time = ((GetTickCount()) - tInicioServer) \ 1000

    'Get times in dd:hh:mm:ss format
102 UpTimeStr = (Time Mod 60) & " segundos."
104 Time = Time \ 60

106 UpTimeStr = (Time Mod 60) & " minutos, " & UpTimeStr
108 Time = Time \ 60

110 UpTimeStr = (Time Mod 24) & " horas, " & UpTimeStr
112 Time = Time \ 24

114 If Time = 1 Then
116     UpTimeStr = Time & " día, " & UpTimeStr
    Else
118     UpTimeStr = Time & " días, " & UpTimeStr

    End If

120 Call WriteConsoleMsg(UserIndex, "Server Online: " & UpTimeStr, FontTypeNames.FONTTYPE_INFO)

    Exit Sub
HandleUpTime_Err:
122 Call LogError("TDSLegacy.Protocol.HandleUpTime en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleShareNpc(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleShareNpc_Err

    Dim TargetUserIndex As Integer

    Dim SharingUserIndex As Integer

100 With UserList(UserIndex)

        ' Didn't target any user
102     TargetUserIndex = .flags.TargetUser

104     If TargetUserIndex = 0 Then Exit Sub

        ' Can't share with admins
106     If EsGM(TargetUserIndex) Then
108         Call WriteConsoleMsg(UserIndex, "No puedes compartir npcs con administradores!!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

        ' Pk or Caos?
110     If criminal(UserIndex) Then

            ' Caos can only share with other caos
112         If EsCaos(UserIndex) Then
114             If Not EsCaos(TargetUserIndex) Then
116                 Call WriteConsoleMsg(UserIndex, "Solo puedes compartir npcs con miembros de tu misma facción!!", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub

                End If

                ' Pks don't need to share with anyone
            Else
                Exit Sub

            End If

            ' Ciuda or Army?
        Else

            ' Can't share
118         If criminal(TargetUserIndex) Then
120             Call WriteConsoleMsg(UserIndex, "No puedes compartir npcs con criminales!!", FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

        End If

        ' Already sharing with target
122     SharingUserIndex = .flags.ShareNpcWith

124     If SharingUserIndex = TargetUserIndex Then Exit Sub

        ' Aviso al usuario anterior que dejo de compartir
126     If SharingUserIndex <> 0 Then
128         Call WriteConsoleMsg(SharingUserIndex, .Name & " ha dejado de compartir sus npcs contigo.", FontTypeNames.FONTTYPE_INFO)
130         Call WriteConsoleMsg(UserIndex, "Has dejado de compartir tus npcs con " & UserList(SharingUserIndex).Name & ".", FontTypeNames.FONTTYPE_INFO)

        End If

132     .flags.ShareNpcWith = TargetUserIndex

134     Call WriteConsoleMsg(TargetUserIndex, .Name & " ahora comparte sus npcs contigo.", FontTypeNames.FONTTYPE_INFO)
136     Call WriteConsoleMsg(UserIndex, "Ahora compartes tus npcs con " & UserList(TargetUserIndex).Name & ".", FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleShareNpc_Err:
138 Call LogError("TDSLegacy.Protocol.HandleShareNpc en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleStopSharingNpc(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleStopSharingNpc_Err

    Dim SharingUserIndex As Integer

100 With UserList(UserIndex)

102     SharingUserIndex = .flags.ShareNpcWith

104     If SharingUserIndex <> 0 Then
            ' Aviso al que compartia y al que le compartia.
106         Call WriteConsoleMsg(SharingUserIndex, .Name & " ha dejado de compartir sus npcs contigo.", FontTypeNames.FONTTYPE_INFO)
108         Call WriteConsoleMsg(SharingUserIndex, "Has dejado de compartir tus npcs con " & UserList(SharingUserIndex).Name & ".", FontTypeNames.FONTTYPE_INFO)

110         .flags.ShareNpcWith = 0

        End If

    End With

    Exit Sub
HandleStopSharingNpc_Err:
112 Call LogError("TDSLegacy.Protocol.HandleStopSharingNpc en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleToggleCombatMode(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleToggleCombatMode_Err

100 With UserList(UserIndex)
102     .flags.ModoCombate = Not .flags.ModoCombate

104     If .flags.ModoCombate Then
106         WriteMensajes UserIndex, e_Mensajes.Mensaje_222
        Else
108         WriteMensajes UserIndex, e_Mensajes.Mensaje_221

        End If

110     Call WriteCombatMode(UserIndex)

    End With

    Exit Sub
HandleToggleCombatMode_Err:
112 Call LogError("TDSLegacy.Protocol.HandleToggleCombatMode en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildMessage_Err

100 With UserList(UserIndex)

        Dim Chat As String

102     Chat = Message.ReadString16()

104     If LenB(Chat) <> 0 Then
            'Analize chat...
106         Call Statistics.ParseChat(Chat)
108         Call CleanString(Chat)

110         If .GuildIndex > 0 Then

                If .flags.EnEvento = 3 Then
                    Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead("Guild> " & Chat, .Char.CharIndex, vbYellow))
                    Exit Sub
                End If

112             Call SendData(SendTarget.ToDiosesYclan, .GuildIndex, PrepareMessageGuildChat(.Name & "> " & Chat))

114             If Not (.flags.AdminInvisible = 1) Then
116                 Call SendData(SendTarget.ToClanArea, UserIndex, PrepareMessageChatOverHead(Chat, .Char.CharIndex, vbYellow))

                End If

            End If

        End If

    End With

    Exit Sub
HandleGuildMessage_Err:
118 Call LogError("TDSLegacy.Protocol.HandleGuildMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCentinelReport(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCentinelReport_Err

100 With UserList(UserIndex)
102     Call CentinelaCheckClave(UserIndex, Message.ReadString16())

    End With

    Exit Sub
HandleCentinelReport_Err:
104 Call LogError("TDSLegacy.Protocol.HandleCentinelReport en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildOnline(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildOnline_Err

100 With UserList(UserIndex)

        Dim onlineList As String

102     onlineList = modGuilds.m_ListaDeMiembrosOnline(UserIndex, .GuildIndex)

104     If .GuildIndex <> 0 Then
106         Call WriteConsoleMsg(UserIndex, "Compañeros de tu clan conectados: " & onlineList, FontTypeNames.FONTTYPE_GUILDMSG)
        Else
108         Call WriteConsoleMsg(UserIndex, "No pertences a ningún clan.", FontTypeNames.FONTTYPE_GUILDMSG)

        End If

    End With

    Exit Sub
HandleGuildOnline_Err:
110 Call LogError("TDSLegacy.Protocol.HandleGuildOnline en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCouncilMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCouncilMessage_Err

100 With UserList(UserIndex)

        Dim Chat As String

102     Chat = Message.ReadString16()

104     If LenB(Chat) <> 0 Then
            'Analize chat...
106         Call Statistics.ParseChat(Chat)
108         Call CleanString(Chat)

110         If .faccion.Status = FaccionType.RoyalCouncil Then
112             Call SendData(SendTarget.ToConsejo, UserIndex, PrepareMessageConsoleMsg("(Consejero) " & .Name & "> " & Chat, FontTypeNames.FONTTYPE_CONSEJO))
114         ElseIf .faccion.Status = FaccionType.ChaosCouncil Then
116             Call SendData(SendTarget.ToConsejoCaos, UserIndex, PrepareMessageConsoleMsg("(Consejero) " & .Name & "> " & Chat, FontTypeNames.FONTTYPE_CONSEJOCAOS))

            End If

        End If

    End With

    Exit Sub
HandleCouncilMessage_Err:
118 Call LogError("TDSLegacy.Protocol.HandleCouncilMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRoleMasterRequest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRoleMasterRequest_Err

100 With UserList(UserIndex)

        Dim request As String

102     request = Message.ReadString16()

104     If LenB(request) <> 0 Then
106         Call WriteConsoleMsg(UserIndex, "Su solicitud ha sido enviada.", FontTypeNames.FONTTYPE_INFO)
108         Call SendData(SendTarget.ToRolesMasters, 0, PrepareMessageConsoleMsg(.Name & " PREGUNTA ROL: " & request, FontTypeNames.FONTTYPE_GUILDMSG))

        End If

    End With

    Exit Sub
HandleRoleMasterRequest_Err:
110 Call LogError("TDSLegacy.Protocol.HandleRoleMasterRequest en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGMRequest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGMRequest_Err

100 With UserList(UserIndex)

102     If Not Ayuda.Existe(.Name) Then
104         WriteMensajes UserIndex, e_Mensajes.Mensaje_268
106         Call Ayuda.Push(.Name)
        Else
108         Call Ayuda.Quitar(.Name)
110         Call Ayuda.Push(.Name)
112         WriteMensajes UserIndex, e_Mensajes.Mensaje_269

        End If

    End With

    Exit Sub
HandleGMRequest_Err:
114 Call LogError("TDSLegacy.Protocol.HandleGMRequest en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleChangeDescription(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleChangeDescription_Err

100 With UserList(UserIndex)

        Dim Description As String

102     Description = Message.ReadString16()

104     If .flags.Muerto = 1 Then
106         WriteMensajes UserIndex, e_Mensajes.Mensaje_300
        Else

108         If Not AsciiValidos(Description) And (Not .flags.Privilegios = PlayerType.Admin) Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_270
            Else
112             .Desc = Trim$(Description)
114             WriteMensajes UserIndex, e_Mensajes.Mensaje_271
            End If

        End If

    End With

    Exit Sub
HandleChangeDescription_Err:
116 Call LogError("TDSLegacy.Protocol.HandleChangeDescription en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildVote(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildVote_Err

100 With UserList(UserIndex)

        Dim vote As String

        Dim ErrorStr As String

102     vote = Message.ReadString16()

104     If LenB(vote) > 0 Then
106         If AsciiValidos(vote) Then
108             If Not modGuilds.v_UsuarioVota(UserIndex, vote, ErrorStr) Then
110                 Call WriteConsoleMsg(UserIndex, "Voto NO contabilizado: " & ErrorStr, FontTypeNames.FONTTYPE_GUILD)
                Else
112                 Call WriteConsoleMsg(UserIndex, "Voto contabilizado.", FontTypeNames.FONTTYPE_GUILD)

                End If

            End If

        End If

    End With

    Exit Sub
HandleGuildVote_Err:
114 Call LogError("TDSLegacy.Protocol.HandleGuildVote en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleShowGuildNews(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleShowGuildNews_Err

100 With UserList(UserIndex)
102     Call modGuilds.SendGuildNews(UserIndex)

    End With

    Exit Sub
HandleShowGuildNews_Err:
104 Call LogError("TDSLegacy.Protocol.HandleShowGuildNews en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePunishments(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePunishments_Err

100 With UserList(UserIndex)

        Dim Name As String
        Dim tStr As String
        Dim count As Long

        Dim i As Long

102     Name = Trim$(Message.ReadString16())

104     If EsGM(UserIndex) Then
106         If Len(Name) = 0 Then
                If .Stats.CantPenas = 0 Then
                    Call WriteConsoleMsg(UserIndex, "No tienes penas.", FontTypeNames.FONTTYPE_INFO)
                    Exit Sub
                End If

112             Call WriteConsoleMsg(UserIndex, "Penas:", FontTypeNames.FONTTYPE_INFO)

114             For i = 1 To .Stats.CantPenas
116                 Call WriteConsoleMsg(UserIndex, i & ") " & .Stats.Penas(i), FontTypeNames.FONTTYPE_INFO)
118             Next i

            Else

120             If Not AsciiValidos(Name) Then Exit Sub

                Dim tIndex As Integer

122             tIndex = NameIndex(Name)

124             If tIndex > 0 Then
126                 If UserList(tIndex).Stats.CantPenas = 0 Then
128                     Call WriteConsoleMsg(UserIndex, Name & " no tiene penas.", FontTypeNames.FONTTYPE_INFO)
                        Exit Sub
                    End If

130                 Call WriteConsoleMsg(UserIndex, "Penas de: " & Name, FontTypeNames.FONTTYPE_INFO)

132                 For i = 1 To UserList(tIndex).Stats.CantPenas
134                     Call WriteConsoleMsg(UserIndex, i & ") " & UserList(tIndex).Stats.Penas(i), FontTypeNames.FONTTYPE_INFO)
136                 Next i

                Else

138                 If FileExist(CharPath & Name & ".chr", vbNormal) Then
140                     count = val(GetVar(CharPath & Name & ".chr", "PENAS", "Cant"))

142                     If count = 0 Then
144                         Call WriteConsoleMsg(UserIndex, Name & " no tiene penas.", FontTypeNames.FONTTYPE_INFO)
                            Exit Sub

                        End If

146                     Call WriteConsoleMsg(UserIndex, "Penas de: " & Name, FontTypeNames.FONTTYPE_INFO)

148                     For i = 1 To count
150                         Call WriteConsoleMsg(UserIndex, i & ") " & GetVar(CharPath & Name & ".chr", "PENAS", "P" & i), FontTypeNames.FONTTYPE_INFO)
152                     Next i

                    Else
154                     Call WriteMensajes(UserIndex, Mensaje_50)

                    End If

                End If

            End If

        Else

            If .Stats.CantPenas = 0 Then
                Call WriteConsoleMsg(UserIndex, "No tienes penas.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

156         Call WriteConsoleMsg(UserIndex, "Penas:", FontTypeNames.FONTTYPE_INFO)

158         For i = 1 To .Stats.CantPenas
160             Call WriteConsoleMsg(UserIndex, i & ") " & .Stats.Penas(i), FontTypeNames.FONTTYPE_INFO)
162         Next i

        End If

    End With

    Exit Sub
HandlePunishments_Err:
164 Call LogError("TDSLegacy.Protocol.HandlePunishments en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleChangePassword(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleChangePassword_Err

100 With UserList(UserIndex)

        Dim oldPass As String

        Dim NewPass As String

        Dim oldPass2 As String

102     oldPass = Message.ReadString16()
104     NewPass = Message.ReadString16()

106     If Len(NewPass) < 5 Then
108         WriteMensajes UserIndex, e_Mensajes.Mensaje_272
        ElseIf Len(NewPass) > 30 Then
            Call WriteConsoleMsg(UserIndex, "Contraseña muy larga.")
        Else
110         oldPass2 = GetVar(CharPath & UserList(UserIndex).Name & ".chr", "INIT", "Password")

112         If oldPass2 <> oldPass Then
114             WriteMensajes UserIndex, e_Mensajes.Mensaje_252
            Else
116             Call WriteVar(CharPath & UserList(UserIndex).Name & ".chr", "INIT", "Password", NewPass)
118             WriteMensajes UserIndex, e_Mensajes.Mensaje_273

            End If

        End If

    End With

    Exit Sub
HandleChangePassword_Err:
120 Call LogError("TDSLegacy.Protocol.HandleChangePassword en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGamble(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGamble_Err

100 With UserList(UserIndex)

        Dim Amount As Integer

102     Amount = Message.ReadInt()

104     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
106         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
108     ElseIf .flags.TargetNPC = 0 Then
            'Validate target NPC
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
112     ElseIf distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
114         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
116     ElseIf Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Timbero Then
118         Call WriteChatOverHead(UserIndex, "No tengo ningún interés en apostar.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
120     ElseIf Amount < 1 Then
122         Call WriteChatOverHead(UserIndex, "El mínimo de apuesta es 1 moneda.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
124     ElseIf Amount > 5000 Then
126         Call WriteChatOverHead(UserIndex, "El máximo de apuesta es 5000 monedas.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
128     ElseIf .Stats.GLD < Amount Then
130         Call WriteChatOverHead(UserIndex, "No tienes esa cantidad.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
        Else

132         If RandomNumber(1, 100) <= 47 Then
134             .Stats.GLD = .Stats.GLD + Amount
136             Call WriteChatOverHead(UserIndex, "¡Felicidades! Has ganado " & CStr(Amount) & " monedas de oro.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

138             Apuestas.Perdidas = Apuestas.Perdidas + Amount
140             Call WriteVar(DatPath & "apuestas.dat", "Main", "Perdidas", CStr(Apuestas.Perdidas))
            Else
142             .Stats.GLD = .Stats.GLD - Amount
144             Call WriteChatOverHead(UserIndex, "Lo siento, has perdido " & CStr(Amount) & " monedas de oro.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

146             Apuestas.Ganancias = Apuestas.Ganancias + Amount
148             Call WriteVar(DatPath & "apuestas.dat", "Main", "Ganancias", CStr(Apuestas.Ganancias))

            End If

150         Apuestas.Jugadas = Apuestas.Jugadas + 1

152         Call WriteVar(DatPath & "apuestas.dat", "Main", "Jugadas", CStr(Apuestas.Jugadas))

154         Call WriteUpdateGold(UserIndex)

        End If

    End With

    Exit Sub
HandleGamble_Err:
156 Call LogError("TDSLegacy.Protocol.HandleGamble en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankExtractGold(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankExtractGold_Err

100 With UserList(UserIndex)

        Dim Amount As Long

102     Amount = Message.ReadInt32()

        'Dead people can't leave a faction.. they can't talk...
104     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
106         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
108     If .flags.TargetNPC = 0 Then
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

112     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then Exit Sub

114     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 10 Then
116         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

118     If Amount > .Stats.Banco Then
120         Amount = .Stats.Banco

        End If

122     If Amount > 0 And Amount <= .Stats.Banco Then
124         .Stats.Banco = .Stats.Banco - Amount
126         .Stats.GLD = .Stats.GLD + Amount
128         Call WriteChatOverHead(UserIndex, "Tenés " & .Stats.Banco & " monedas de oro en tu cuenta.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
        Else
130         Call WriteChatOverHead(UserIndex, "No tienes esa cantidad.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

        End If

132     Call WriteUpdateGold(UserIndex)
134     Call WriteUpdateBankGold(UserIndex)

    End With

    Exit Sub
HandleBankExtractGold_Err:
136 Call LogError("TDSLegacy.Protocol.HandleBankExtractGold en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleLeaveFaction(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleLeaveFaction_Err

    Dim TalkToKing As Boolean

    Dim TalkToDemon As Boolean

    Dim NpcIndex As Integer

100 With UserList(UserIndex)

        'Dead people can't leave a faction.. they can't talk...
102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        ' Chequea si habla con el rey o el demonio. Puede salir sin hacerlo, pero si lo hace le reponden los npcs
106     NpcIndex = .flags.TargetNPC

108     If NpcIndex <> 0 Then

            ' Es rey o domonio?
110         If Npclist(NpcIndex).NPCtype = eNPCType.Noble Then

                'Rey?
112             If Npclist(NpcIndex).flags.faccion = 0 Then
114                 TalkToKing = True
                    ' Demonio
                Else
116                 TalkToDemon = True

                End If

            End If

        End If

        'Quit the Royal Army?
118     If .faccion.ArmadaReal = 1 Then

            ' Si le pidio al demonio salir de la armada, este le responde.
120         If TalkToDemon Then
122             Call WriteChatOverHead(UserIndex, "¡¡¡Sal de aquí bufón!!!", Npclist(NpcIndex).Char.CharIndex, vbWhite)

            Else

                ' Si le pidio al rey salir de la armada, le responde.
124             If TalkToKing Then
126                 Call WriteChatOverHead(UserIndex, "Serás bienvenido a las fuerzas imperiales si deseas regresar.", Npclist(NpcIndex).Char.CharIndex, vbWhite)

                End If

128             Call ExpulsarFaccionReal(UserIndex, False)

            End If

            'Quit the Chaos Legion?
130     ElseIf .faccion.FuerzasCaos = 1 Then

            ' Si le pidio al rey salir del caos, le responde.
132         If TalkToKing Then
134             Call WriteChatOverHead(UserIndex, "¡¡¡Sal de aquí maldito criminal!!!", Npclist(NpcIndex).Char.CharIndex, vbWhite)
            Else

                ' Si le pidio al demonio salir del caos, este le responde.
136             If TalkToDemon Then
138                 Call WriteChatOverHead(UserIndex, "Ya volverás arrastrandote.", Npclist(NpcIndex).Char.CharIndex, vbWhite)

                End If

140             Call ExpulsarFaccionCaos(UserIndex, False)

            End If

            ' No es faccionario
        Else

            ' Si le hablaba al rey o demonio, le repsonden ellos
142         If NpcIndex > 0 Then
144             Call WriteChatOverHead(UserIndex, "¡No perteneces a ninguna facción!", Npclist(NpcIndex).Char.CharIndex, vbWhite)
            Else
146             Call WriteConsoleMsg(UserIndex, "¡No perteneces a ninguna facción!", FontTypeNames.FONTTYPE_FIGHT)

            End If

        End If

    End With

    Exit Sub
HandleLeaveFaction_Err:
148 Call LogError("TDSLegacy.Protocol.HandleLeaveFaction en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBankDepositGold(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBankDepositGold_Err

100 With UserList(UserIndex)

        Dim Amount As Long

102     Amount = Message.ReadInt32()

        'Dead people can't leave a faction.. they can't talk...
104     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
106         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

        'Validate target NPC
108     If .flags.TargetNPC = 0 Then
110         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

112     If distancia(Npclist(.flags.TargetNPC).Pos, .Pos) > 10 Then
114         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

116     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then Exit Sub

118     If Amount > 0 And Amount <= .Stats.GLD Then
120         .Stats.Banco = .Stats.Banco + Amount
122         .Stats.GLD = .Stats.GLD - Amount
124         Call WriteChatOverHead(UserIndex, "Tenés " & .Stats.Banco & " monedas de oro en tu cuenta.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

126         Call WriteUpdateGold(UserIndex)
128         Call WriteUpdateBankGold(UserIndex)
        Else
130         Call WriteChatOverHead(UserIndex, "No tenés esa cantidad.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

        End If

    End With

    Exit Sub
HandleBankDepositGold_Err:
132 Call LogError("TDSLegacy.Protocol.HandleBankDepositGold en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDenounce(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDenounce_Err

100 With UserList(UserIndex)

        Dim Text As String

102     Text = Message.ReadString16()

104     If .flags.Silenciado = 0 Then
            'Analize chat...
106         Call Statistics.ParseChat(Text)



108         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(Now & " - " & LCase$(.Name) & " DENUNCIA: " & Text, FontTypeNames.FONTTYPE_GUILDMSG))
110         WriteMensajes UserIndex, e_Mensajes.Mensaje_301
112         Call logDenuncias(LCase$(.Name) & " DENUNCIA: " & Text)

        End If

    End With

    Exit Sub
HandleDenounce_Err:
114 Call LogError("TDSLegacy.Protocol.HandleDenounce en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildFundate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildFundate_Err


    If Not UserList(UserIndex).flags.ExClan = 0 Then
        Call WriteConsoleMsg(UserIndex, "No puedes crear un clan ya que tienes uno disuelto: " & modGuilds.GuildName(UserList(UserIndex).flags.ExClan), FontTypeNames.FONTTYPE_GUILD)
        Exit Sub
    End If

100 Call WriteShowGuildFundationForm(UserIndex)

    Exit Sub
HandleGuildFundate_Err:
102 Call LogError("TDSLegacy.Protocol.HandleGuildFundate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildFundation(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildFundation_Err

100 With UserList(UserIndex)

        Dim clanType As eClanType

102     clanType = Message.ReadInt()

104     Select Case UCase$(Trim(clanType))

        Case eClanType.ct_RoyalArmy
106         .FundandoGuildAlineacion = ALINEACION_ARMADA

108     Case eClanType.ct_Evil
110         .FundandoGuildAlineacion = ALINEACION_LEGION

112     Case eClanType.ct_Neutral
114         .FundandoGuildAlineacion = ALINEACION_NEUTRO

116     Case eClanType.ct_GM
118         .FundandoGuildAlineacion = ALINEACION_MASTER

120     Case eClanType.ct_Legal
122         .FundandoGuildAlineacion = ALINEACION_CIUDA

124     Case eClanType.ct_Criminal
126         .FundandoGuildAlineacion = ALINEACION_CRIMINAL

128     Case Else
130         Call WriteConsoleMsg(UserIndex, "Alineación inválida.", FontTypeNames.FONTTYPE_GUILD)
            Exit Sub

        End Select

132     If modGuilds.PuedeFundarUnClan(UserIndex, .FundandoGuildAlineacion) Then
134         Call WriteShowGuildFundationForm(UserIndex)
        Else
136         .FundandoGuildAlineacion = 0

        End If

    End With

    Exit Sub
HandleGuildFundation_Err:
138 Call LogError("TDSLegacy.Protocol.HandleGuildFundation en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildMemberList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildMemberList_Err

100 With UserList(UserIndex)

        Dim guild As String

        Dim memberCount As Integer

        Dim i As Long

        Dim UserName As String

102     guild = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If (InStrB(guild, "\") <> 0) Then
108             guild = Replace(guild, "\", "")

            End If

110         If (InStrB(guild, "/") <> 0) Then
112             guild = Replace(guild, "/", "")

            End If

114         If Not FileExist(App.path & "\guilds\" & guild & "-members.mem") Then
116             Call WriteConsoleMsg(UserIndex, "No existe el clan: " & guild, FontTypeNames.FONTTYPE_INFO)
            Else
118             memberCount = val(GetVar(App.path & "\Guilds\" & guild & "-Members" & ".mem", "INIT", "NroMembers"))

120             For i = 1 To memberCount
122                 UserName = GetVar(App.path & "\Guilds\" & guild & "-Members" & ".mem", "Members", "Member" & i)

124                 Call WriteConsoleMsg(UserIndex, UserName & "<" & guild & ">", FontTypeNames.FONTTYPE_INFO)
126             Next i

            End If

        End If

    End With

    Exit Sub
HandleGuildMemberList_Err:
128 Call LogError("TDSLegacy.Protocol.HandleGuildMemberList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGMMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGMMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.RoleMaster Then
106         Call LogGM(.Name, "/GMSG " & Msg)

108         If LenB(Msg) <> 0 Then
                'Analize chat...
110             Call Statistics.ParseChat(Msg)

112             Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & "> " & Msg, FontTypeNames.FONTTYPE_GMMSG))

            End If

        End If

    End With

    Exit Sub
HandleGMMessage_Err:
114 Call LogError("TDSLegacy.Protocol.HandleGMMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleShowName(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleShowName_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios = PlayerType.Dios Or .flags.Privilegios = PlayerType.Admin Or .flags.Privilegios = PlayerType.RoleMaster Then
104         .showName = Not .showName        'Show / Hide the name

106         Call RefreshCharStatus(UserIndex)

        End If

    End With

    Exit Sub
HandleShowName_Err:
108 Call LogError("TDSLegacy.Protocol.HandleShowName en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleOnlineRoyalArmy(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleOnlineRoyalArmy_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios = PlayerType.User And .faccion.Status <> FaccionType.ChaosCouncil Then Exit Sub

        Dim i As Long

        Dim list As String

104     For i = 1 To LastUser

106         If UserList(i).ConnIDValida Then
108             If UserList(i).faccion.ArmadaReal = 1 Then
                    'If UserList(i).flags.Privilegios = ( Or PlayerType.Consejero Or PlayerType.SemiDios) Or _
                     .flags.Privilegios s (PlayerType.Dios Or PlayerType.Admin) Then
110                 list = list & UserList(i).Name & ", "

                    'End If
                End If

            End If

112     Next i

    End With

114 If Len(list) > 0 Then
116     Call WriteConsoleMsg(UserIndex, "Reales conectados: " & Left$(list, Len(list) - 2), FontTypeNames.FONTTYPE_INFO)
    Else
118     Call WriteConsoleMsg(UserIndex, "No hay reales conectados.", FontTypeNames.FONTTYPE_INFO)

    End If

    Exit Sub
HandleOnlineRoyalArmy_Err:
120 Call LogError("TDSLegacy.Protocol.HandleOnlineRoyalArmy en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleOnlineChaosLegion(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleOnlineChaosLegion_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios = PlayerType.User And .flags.Privilegios <> FaccionType.ChaosCouncil Then Exit Sub

        Dim i As Long

        Dim list As String

104     For i = 1 To LastUser

106         If UserList(i).ConnIDValida Then
108             If UserList(i).faccion.FuerzasCaos = 1 Then
                    'If UserList(i).flags.Privilegios = (PlayerType.User Or PlayerType.Consejero Or PlayerType.SemiDios) Or _
                     .flags.Privilegios = (PlayerType.Dios Or PlayerType.Admin) Then
110                 list = list & UserList(i).Name & ", "

                    'End If
                End If

            End If

112     Next i

    End With

114 If Len(list) > 0 Then
116     Call WriteConsoleMsg(UserIndex, "Caos conectados: " & Left$(list, Len(list) - 2), FontTypeNames.FONTTYPE_INFO)
    Else
118     Call WriteConsoleMsg(UserIndex, "No hay Caos conectados.", FontTypeNames.FONTTYPE_INFO)

    End If

    Exit Sub
HandleOnlineChaosLegion_Err:
120 Call LogError("TDSLegacy.Protocol.HandleOnlineChaosLegion en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGoNearby(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGoNearby_Err

100 With UserList(UserIndex)

        Dim UserName As String

102     UserName = Message.ReadString16()

        Dim tIndex As Integer

        Dim X As Long

        Dim Y As Long

        Dim i As Long

        Dim found As Boolean

104     tIndex = NameIndex(UserName)

        'Check the user has enough powers
106     If EsGM(UserIndex) Then

            'Si es dios o Admins no podemos salvo que nosotros también lo seamos
108         If Not (EsDios(UserName) Or EsAdmin(UserName)) Or .flags.Privilegios >= PlayerType.Dios Then
110             If tIndex <= 0 Then        'existe el usuario destino?
112                 WriteMensajes UserIndex, e_Mensajes.Mensaje_56
                Else

114                 For i = 2 To 5        'esto for sirve ir cambiando la distancia destino
116                     For X = UserList(tIndex).Pos.X - i To UserList(tIndex).Pos.X + i
118                         For Y = UserList(tIndex).Pos.Y - i To UserList(tIndex).Pos.Y + i

120                             If MapData(UserList(tIndex).Pos.Map, X, Y).UserIndex = 0 Then
122                                 If LegalPos(UserList(tIndex).Pos.Map, X, Y, True, True) Then
124                                     Call WarpUserChar(UserIndex, UserList(tIndex).Pos.Map, X, Y, True)
126                                     Call LogGM(.Name, "/IRCERCA " & UserName & " Mapa:" & UserList(tIndex).Pos.Map & " X:" & UserList(tIndex).Pos.X & " Y:" & UserList(tIndex).Pos.Y)
128                                     found = True
                                        Exit For

                                    End If

                                End If

130                         Next Y

132                         If found Then Exit For        ' Feo, pero hay que abortar 3 fors sin usar GoTo
134                     Next X

136                     If found Then Exit For        ' Feo, pero hay que abortar 3 fors sin usar GoTo
138                 Next i

                    'No space found??
140                 If Not found Then
142                     Call WriteConsoleMsg(UserIndex, "Todos los lugares están ocupados.", FontTypeNames.FONTTYPE_INFO)

                    End If

                End If

            End If

        End If

    End With

    Exit Sub
HandleGoNearby_Err:
144 Call LogError("TDSLegacy.Protocol.HandleGoNearby en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleServerTime(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleServerTime_Err

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub

104     Call LogGM(.Name, "Hora.")
        
        Call TEST_CVC
        
        'Dim map As Integer
        'Dim x As Byte, y As Byte
        'For map = 1 To NumMaps
        '        For x = MinXBorder + 1 To MaxXBorder - 1
        '            For y = MinYBorder + 1 To MaxYBorder - 1
        '                If MapData(map, x, y).Blocked = 0 Then
        '                    If MapData(map, x, y).ObjInfo.ObjIndex Then
        '                        If Not ObjData(MapData(map, x, y).ObjInfo.ObjIndex).Valor = 0 Then
        '                        Debug.Print map, x, y, MapData(map, x, y).ObjInfo.Amount & " " & ObjData(MapData(map, x, y).ObjInfo.ObjIndex).Name
        '                        End If
        '                    End If
        '                End If
        '            Next y
        '        Next x
        'Next map

        'Dim miArray(0 To 65) As Integer
        'miArray(0) = 10
        'miArray(1) = 76
        'miArray(2) = 75
        'miArray(3) = 9
        'miArray(4) = 38
        'miArray(5) = 46
        'miArray(6) = 65
        'miArray(7) = 67
        'miArray(8) = 68
        'miArray(9) = 69
        'miArray(10) = 70
        'miArray(11) = 71
        'miArray(12) = 72
        'miArray(13) = 73
        'miArray(14) = 84
        'miArray(15) = 8
        'miArray(16) = 39
        'miArray(17) = 36
        'miArray(18) = 35
        'miArray(19) = 58
        'miArray(20) = 57
        'miArray(21) = 56
        'miArray(22) = 55
        'miArray(23) = 54
        'miArray(24) = 53
        'miArray(25) = 7
        'miArray(26) = 6
        'miArray(27) = 5
        'miArray(28) = 2
        'miArray(29) = 3
        'miArray(30) = 4
        'miArray(31) = 32
        'miArray(32) = 31
        'miArray(33) = 158
        'miArray(34) = 159
        'miArray(35) = 160
        'miArray(36) = 161
        'miArray(37) = 11
        'miArray(38) = 14
        'miArray(39) = 25
        'miArray(40) = 22
        'miArray(41) = 29
        'miArray(42) = 30
        'miArray(43) = 12
        'miArray(44) = 18
        'miArray(45) = 26
        'miArray(46) = 23
        'miArray(47) = 28
        'miArray(48) = 13
        'miArray(49) = 19
        'miArray(50) = 27
        'miArray(51) = 24
        'miArray(52) = 98
        'miArray(53) = 15
        'miArray(54) = 21
        'miArray(55) = 16
        'miArray(56) = 17
        'miArray(57) = 20
        'miArray(58) = 169
        'miArray(59) = 170
        'miArray(60) = 171
        'miArray(61) = 173
        'miArray(62) = 114
        'miArray(63) = 113
        'miArray(64) = 112
        'miArray(65) = 111
        'Dim i As Long
        'For i = LBound(miArray) To UBound(miArray)
        '    Call WriteVar(App.path & "/Maps/Mapa" & miArray(i) & ".dat", "MAPA" & miArray(i), "MUSICNUM", "3-1")
        'Next i

    End With

110 Call modSendData.SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Hora: " & Time & " " & Date, FontTypeNames.FONTTYPE_INFO))

    Exit Sub
HandleServerTime_Err:
112 Call LogError("TDSLegacy.Protocol.HandleServerTime en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWhere(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWhere_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then

                If PersonajeExiste(UserName) Then

                    Call WriteConsoleMsg(UserIndex, "Ubicación  " & UserName & ": " & GetVar(CharPath & UCase$(UserName) & ".chr", "INIT", "Position"))
                End If
            Else

112             If UserList(UserIndex).flags.Privilegios >= UserList(tUser).flags.Privilegios Then
114                 Call WriteConsoleMsg(UserIndex, "Ubicación  " & UserName & ": " & UserList(tUser).Pos.Map & ", " & UserList(tUser).Pos.X & ", " & UserList(tUser).Pos.Y & ".", FontTypeNames.FONTTYPE_INFO)
116                 Call LogGM(.Name, "/Donde " & UserName)

                End If

            End If

        End If

    End With

    Exit Sub
HandleWhere_Err:
118 Call LogError("TDSLegacy.Protocol.HandleWhere en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCreaturesInMap(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCreaturesInMap_Err

100 With UserList(UserIndex)

        Dim Map As Integer

        Dim i, j As Long

        Dim NPCcount1, NPCcount2 As Integer

        Dim NPCcant1() As Integer

        Dim NPCcant2() As Integer

        Dim List1() As String

        Dim List2() As String

102     Map = Message.ReadInt()

104     If Not EsGM(UserIndex) Then Exit Sub

106     If MapaValido(Map) Then

108         For i = 1 To LastNPC

                'VB isn't lazzy, so we put more restrictive condition first to speed up the process
110             If Npclist(i).Pos.Map = Map Then

                    '¿esta vivo?
112                 If Npclist(i).flags.NPCActive And Npclist(i).Hostile = 1 And Npclist(i).Stats.Alineacion = 2 Then
114                     If NPCcount1 = 0 Then
116                         ReDim List1(0) As String
118                         ReDim NPCcant1(0) As Integer
120                         NPCcount1 = 1
122                         List1(0) = Npclist(i).Name & ": (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
124                         NPCcant1(0) = 1
                        Else

126                         For j = 0 To NPCcount1 - 1

128                             If Left$(List1(j), Len(Npclist(i).Name)) = Npclist(i).Name Then
130                                 List1(j) = List1(j) & ", (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
132                                 NPCcant1(j) = NPCcant1(j) + 1
                                    Exit For

                                End If

134                         Next j

136                         If j = NPCcount1 Then
138                             ReDim Preserve List1(0 To NPCcount1) As String
140                             ReDim Preserve NPCcant1(0 To NPCcount1) As Integer
142                             NPCcount1 = NPCcount1 + 1
144                             List1(j) = Npclist(i).Name & ": (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
146                             NPCcant1(j) = 1

                            End If

                        End If

                    Else

148                     If NPCcount2 = 0 Then
150                         ReDim List2(0) As String
152                         ReDim NPCcant2(0) As Integer
154                         NPCcount2 = 1
156                         List2(0) = Npclist(i).Name & ": (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
158                         NPCcant2(0) = 1
                        Else

160                         For j = 0 To NPCcount2 - 1

162                             If Left$(List2(j), Len(Npclist(i).Name)) = Npclist(i).Name Then
164                                 List2(j) = List2(j) & ", (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
166                                 NPCcant2(j) = NPCcant2(j) + 1
                                    Exit For

                                End If

168                         Next j

170                         If j = NPCcount2 Then
172                             ReDim Preserve List2(0 To NPCcount2) As String
174                             ReDim Preserve NPCcant2(0 To NPCcount2) As Integer
176                             NPCcount2 = NPCcount2 + 1
178                             List2(j) = Npclist(i).Name & ": (" & Npclist(i).Pos.X & "," & Npclist(i).Pos.Y & ")"
180                             NPCcant2(j) = 1

                            End If

                        End If

                    End If

                End If

182         Next i

184         Call WriteConsoleMsg(UserIndex, "Npcs Hostiles en mapa: ", FontTypeNames.FONTTYPE_WARNING)

186         If NPCcount1 = 0 Then
188             Call WriteConsoleMsg(UserIndex, "No hay NPCS Hostiles.", FontTypeNames.FONTTYPE_INFO)
            Else

190             For j = 0 To NPCcount1 - 1
192                 Call WriteConsoleMsg(UserIndex, NPCcant1(j) & " " & List1(j), FontTypeNames.FONTTYPE_INFO)
194             Next j

            End If

196         Call WriteConsoleMsg(UserIndex, "Otros Npcs en mapa: ", FontTypeNames.FONTTYPE_WARNING)

198         If NPCcount2 = 0 Then
200             Call WriteConsoleMsg(UserIndex, "No hay más NPCS.", FontTypeNames.FONTTYPE_INFO)
            Else

202             For j = 0 To NPCcount2 - 1
204                 Call WriteConsoleMsg(UserIndex, NPCcant2(j) & " " & List2(j), FontTypeNames.FONTTYPE_INFO)
206             Next j

            End If

208         Call LogGM(.Name, "Numero enemigos en mapa " & Map)

        End If

    End With

    Exit Sub
HandleCreaturesInMap_Err:
210 Call LogError("TDSLegacy.Protocol.HandleCreaturesInMap en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWarpMeToTarget(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWarpMeToTarget_Err

100 With UserList(UserIndex)

        Dim X As Integer

        Dim Y As Integer

102     If Not EsGM(UserIndex) Then Exit Sub

104     X = .flags.TargetX
106     Y = .flags.TargetY

108     Call FindLegalPos(UserIndex, .flags.TargetMap, X, Y)
110     Call WarpUserChar(UserIndex, .flags.TargetMap, X, Y, True)
112     Call LogGM(.Name, "/TELEPLOC a x:" & .flags.TargetX & " Y:" & .flags.TargetY & " Map:" & .Pos.Map)

    End With

    Exit Sub
HandleWarpMeToTarget_Err:
114 Call LogError("TDSLegacy.Protocol.HandleWarpMeToTarget en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWarpChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWarpChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim Map As Integer

        Dim X As Integer

        Dim Y As Integer
        Dim valid As Boolean
        Dim tUser As Integer

102     UserName = Message.ReadString16()
104     Map = Message.ReadInt()
106     X = Message.ReadInt8()
108     Y = Message.ReadInt8()

        UserName = Trim$(Replace$(UserName, "+", " "))

116     If Not MapaValido(Map) Or Not InMapBounds(Map, X, Y) Then

            Call InMapBounds_Force(X, Y)

            If Not MapaValido(Map) Or Not InMapBounds(Map, X, Y) Then
                Call WriteConsoleMsg(UserIndex, "Estás queriendo llevar a " & UserName & " a un mapa inválido: " & Map & "-" & X & "-" & Y)
                Exit Sub
            End If
        End If
        If UserName = "YO" Or UserName = "yo" Then UserName = .Name

110     If EsGM(UserIndex) And PersonajeExiste(UserName) Then
112         If MapaValido(Map) And LenB(UserName) <> 0 Then
114             If UCase$(UserName) <> "YO" Then
                    If .flags.Privilegios > PlayerType.Consejero Then
118                     tUser = NameIndex(UserName)

                    End If

                Else
120                 tUser = UserIndex

                End If

122             If tUser <= 0 Then

                    Dim tUserLevel As Byte
                    tUserLevel = val(GetVar(CharPath & UCase$(UserName) & ".chr", "STATS", "ELV"))

                    If .flags.Privilegios < PlayerType.Admin Then
                        If UCase$(MapInfo(Map).Restringir) = "QUINCE" And Not tUserLevel >= 15 Then
                        ElseIf UCase$(MapInfo(Map).Restringir) = "VEINTE" And Not tUserLevel >= 20 Then
                        ElseIf UCase$(MapInfo(Map).Restringir) = "VEINTICINCO" And Not tUserLevel >= 25 Then
                        ElseIf UCase$(MapInfo(Map).Restringir) = "CUARENTA" And Not tUserLevel >= 40 Then
                        Else
                            valid = True
                        End If

                        If Not tUserLevel >= 25 Then
                            Select Case Map
                            Case 47, 111, 114, 173, 113, 112, 169, 170, 171
                                valid = False
                            End Select
                        End If

                        If Not valid Then
                            Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserName & " porque éste mapa requiere nivel " & UCase$(MapInfo(Map).Restringir))
                            Call LogGM(.Name, "INTENTÓ SUMONEAR A " & UserName & " Map:" & Map & " X:" & X & " Y:" & Y & ". Siendo " & UserName & " nivel " & tUserLevel)
                            Exit Sub
                        End If
                    End If

                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & UserName & "(OFFLINE) fue transportado a: " & Map & "-" & X & "-" & Y & " por el GM: " & .Name, FontTypeNames.FONTTYPE_SERVER))

                    Call WriteVar(CharPath & UCase$(UserName) & ".chr", "INIT", "Position", Map & "-" & X & "-" & Y)
                    Call WriteConsoleMsg(UserIndex, UserName & " (offline) transportado al mapa " & Map & "-" & X & "-" & Y, FontTypeNames.FONTTYPE_INFO)
                    Call LogGM(.Name, "/TELEP " & UserName & "(offline) hacia " & "Mapa" & Map & " X:" & X & " Y:" & Y)

126             ElseIf InMapBounds(Map, X, Y) Then


132                 If tUser <> UserIndex Then

                        If .flags.Privilegios < PlayerType.Admin Then
                            If UCase$(MapInfo(.Pos.Map).Restringir) = "QUINCE" And Not UserList(tUser).Stats.ELV >= 15 Then
                            ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "VEINTE" And Not UserList(tUser).Stats.ELV >= 20 Then
                            ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "VEINTICINCO" And Not UserList(tUser).Stats.ELV >= 25 Then
                            ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "CUARENTA" And Not UserList(tUser).Stats.ELV >= 40 Then
                            Else
                                valid = True
                            End If

                            If Not valid Then
                                Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel " & UCase$(MapInfo(.Pos.Map).Restringir))
                                Call LogGM(.Name, "INTENTÓ SUMONEAR A " & UserName & " Map:" & .Pos.Map & " X:" & .Pos.X & " Y:" & .Pos.Y & ". Siendo " & UserName & " nivel " & UserList(tUser).Stats.ELV)
                                Exit Sub
                            End If
                        End If

                        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & UserList(tUser).Name & " fue transportado a: " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y & " por el GM: " & .Name, FontTypeNames.FONTTYPE_SERVER))

128                     Call FindLegalPos(tUser, Map, X, Y, EsGM(tUser))
130                     Call WarpUserChar(tUser, Map, X, Y, True, True)

134                     Call WriteConsoleMsg(UserIndex, UserList(tUser).Name & " transportado al mapa " & Map & "-" & X & "-" & Y, FontTypeNames.FONTTYPE_INFO)
136                     Call LogGM(.Name, "/TELEP " & UserList(tUser).Name & " hacia " & "Mapa" & Map & " X:" & X & " Y:" & Y)
                    Else
1288                    Call FindLegalPos(tUser, Map, X, Y)
1308                    Call WarpUserChar(tUser, Map, X, Y, True, True)
                    End If

                End If

            End If

        End If

    End With

    Exit Sub
HandleWarpChar_Err:
138 Call LogError("TDSLegacy.Protocol.HandleWarpChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSilence(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSilence_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else

112             If UserList(tUser).flags.Silenciado = 0 Then
114                 UserList(tUser).flags.Silenciado = 1
116                 Call WriteConsoleMsg(UserIndex, "Usuario silenciado.", FontTypeNames.FONTTYPE_INFO)
118                 Call WriteShowMessageBox(tUser, "Estimado usuario, ud. ha sido silenciado por los administradores. Sus denuncias serán ignoradas por el server de aquí en más. Utilice /GM para contactar un administrador.")
120                 Call LogGM(.Name, "/silenciar " & UserList(tUser).Name)

                    'Flush the other user's buffer
                    'Call Flushbuffer(tUser)
                Else
122                 UserList(tUser).flags.Silenciado = 0
124                 Call WriteConsoleMsg(UserIndex, "Usuario des silenciado.", FontTypeNames.FONTTYPE_INFO)
126                 Call LogGM(.Name, "/DESsilenciar " & UserList(tUser).Name)

                End If

            End If

        End If

    End With

    Exit Sub
HandleSilence_Err:
128 Call LogError("TDSLegacy.Protocol.HandleSilence en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSOSShowList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSOSShowList_Err

100 If Not EsGM(UserIndex) Then Exit Sub
102 Call WriteShowSOSForm(UserIndex)

    Exit Sub
HandleSOSShowList_Err:
104 Call LogError("TDSLegacy.Protocol.HandleSOSShowList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSOSRemove(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSOSRemove_Err

    Dim UserName As String

100 UserName = Message.ReadString16()

102 If EsGM(UserIndex) Then Call Ayuda.Quitar(UserName)

    Exit Sub
HandleSOSRemove_Err:
104 Call LogError("TDSLegacy.Protocol.HandleSOSRemove en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGoToChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGoToChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim X As Integer

        Dim Y As Integer

102     UserName = Message.ReadString16()
104     tUser = NameIndex(UserName)

106     If EsGM(UserIndex) Then

            'Si es dios o Admins no podemos salvo que nosotros también lo seamos
108         If Not (EsDios(UserName) Or EsAdmin(UserName)) Or .flags.Privilegios >= PlayerType.Dios Then
110             If tUser <= 0 Then
112                 ' WriteMensajes UserIndex, e_Mensajes.Mensaje_56

                    Dim ln As String
                    If PersonajeExiste(UserName) Then
                        ln = GetVar(CharPath & UCase$(UserName) & ".chr", "INIT", "Position")
                        Call WriteConsoleMsg(UserIndex, "Mira capo, el chabón está offline pero te llevo igual a las coordenadas: " & ln)
                        If Len(ln) Then
                            X = val(ReadField(2, ln, 45))
                            Y = val(ReadField(3, ln, 45)) + 1
                            Call FindLegalPos(UserIndex, val(ReadField(1, ln, 45)), X, Y)
                            Call WarpUserChar(UserIndex, val(ReadField(1, ln, 45)), X, Y, True)
                        End If
                    End If

                Else
114                 X = UserList(tUser).Pos.X
116                 Y = UserList(tUser).Pos.Y + 1
118                 Call FindLegalPos(UserIndex, UserList(tUser).Pos.Map, X, Y)

120                 Call WarpUserChar(UserIndex, UserList(tUser).Pos.Map, X, Y, True)

122                 If .flags.AdminInvisible = 0 Then
124                     Call WriteConsoleMsg(tUser, .Name & " se ha trasportado hacia donde te encuentras.", FontTypeNames.FONTTYPE_INFO)

                        'Call Flushbuffer(tUser)
                    End If
                    If Not .flags.Privilegios = PlayerType.Admin Then
126                     Call LogGM(.Name, "/IRA " & UserName & " Mapa:" & UserList(tUser).Pos.Map & " X:" & UserList(tUser).Pos.X & " Y:" & UserList(tUser).Pos.Y)
                    End If
                End If

            End If

        End If

    End With

    Exit Sub
HandleGoToChar_Err:
128 Call LogError("TDSLegacy.Protocol.HandleGoToChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleInvisible(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleInvisible_Err

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub
104     Call DoAdminInvisible(UserIndex)

    End With

    Exit Sub
HandleInvisible_Err:
106 Call LogError("TDSLegacy.Protocol.HandleInvisible en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGMPanel(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGMPanel_Err

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub
104     Call WriteShowGMPanelForm(UserIndex)

    End With

    Exit Sub
HandleGMPanel_Err:
106 Call LogError("TDSLegacy.Protocol.HandleGMPanel en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestUserList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestUserList_Err

    Dim i As Long

    Dim Names() As String

    Dim count As Long

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub

104     ReDim Names(1 To LastUser) As String
106     count = 1

108     For i = 1 To LastUser

110         If (LenB(UserList(i).Name) <> 0) Then
112             If UserList(i).flags.Privilegios < PlayerType.Consejero Then
114                 Names(count) = UserList(i).Name
116                 count = count + 1

                End If

            End If

118     Next i

120     If count > 1 Then Call WriteUserNameList(UserIndex, Names(), count - 1)

    End With

    Exit Sub
HandleRequestUserList_Err:
122 Call LogError("TDSLegacy.Protocol.HandleRequestUserList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleWorking(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleWorking_Err

    Dim i As Long

    Dim users As String

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub

104     For i = 1 To LastUser

106         If UserList(i).flags.UserLogged And UserList(i).Counters.Trabajando Then
108             users = users & ", " & UserList(i).Name

                ' Display the user being checked by the centinel
110             If modCentinela.Centinela.RevisandoUserIndex = i Then users = users & " (*)"

            End If

112     Next i

114     If LenB(users) <> 0 Then
116         users = Right$(users, Len(users) - 2)
118         Call WriteConsoleMsg(UserIndex, "Usuarios trabajando: " & users, FontTypeNames.FONTTYPE_INFO)
        Else
120         Call WriteConsoleMsg(UserIndex, "No hay usuarios trabajando.", FontTypeNames.FONTTYPE_INFO)

        End If

    End With

    Exit Sub
HandleWorking_Err:
122 Call LogError("TDSLegacy.Protocol.HandleWorking en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleKillNPC(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleKillNPC_Err

100 With UserList(UserIndex)

102     If Not EsGM(UserIndex) Then Exit Sub

        Dim tNPC As Integer

        Dim auxNPC As npc

        'Los consejeros no pueden RMATAr a nada en el mapa pretoriano
104     If .flags.Privilegios = PlayerType.Consejero Then
106         If .Pos.Map = MAPA_PRETORIANO Then
108             Call WriteConsoleMsg(UserIndex, "Los consejeros no pueden usar este comando en el mapa pretoriano.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

        End If

110     tNPC = .flags.TargetNPC

112     If tNPC > 0 Then
114         Call WriteConsoleMsg(UserIndex, "RMatas (con posible respawn) a: " & Npclist(tNPC).Name, FontTypeNames.FONTTYPE_INFO)

116         auxNPC = Npclist(tNPC)
118         Call QuitarNPC(tNPC)
120         Call ReSpawnNpc(auxNPC)

122         .flags.TargetNPC = 0
        Else
124         Call WriteConsoleMsg(UserIndex, "Antes debes hacer click sobre el NPC.", FontTypeNames.FONTTYPE_INFO)

        End If

    End With

    Exit Sub
HandleKillNPC_Err:
126 Call LogError("TDSLegacy.Protocol.HandleKillNPC en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePenar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePenar_Err

    '***************************************************
    'Author:  Gastón Montenegro Raczkoski (Cuicui)
    'Last Modification: 03/10/22
    '
    '***********************************************
100 With UserList(UserIndex)

        Dim UserName As String

        Dim tIndex As Integer

        Dim Reason As String

        Dim privs As PlayerType

        Dim pena_string As String

        Dim count As Integer

102     UserName = Message.ReadString16()
104     Reason = Message.ReadString16()

106     If EsGM(UserIndex) Then
108         If LenB(UserName) = 0 Or LenB(Reason) = 0 Then
110             Call WriteConsoleMsg(UserIndex, "Utilice /penar nick@motivo", FontTypeNames.FONTTYPE_INFO)
            Else
112             privs = PrivilegioNickName(UserName)

114             If .flags.Privilegios < privs Then
116                 Call WriteConsoleMsg(UserIndex, "No puedes penar a un superior.", FontTypeNames.FONTTYPE_INFO)
                Else

118                 If (InStrB(UserName, "\") <> 0) Then UserName = Replace(UserName, "\", "")
120                 If (InStrB(UserName, "/") <> 0) Then UserName = Replace(UserName, "/", "")

122                 tIndex = NameIndex(UserName)

124                 If tIndex > 0 Then

126                     Call WriteConsoleMsg(tIndex, "Has sido penado.", FontTypeNames.FONTTYPE_INFO)
128                     UserList(tIndex).Stats.CantPenas = UserList(tIndex).Stats.CantPenas + 1
130                     Call WarpUserCharX(tIndex, Prision.Map, Prision.X, Prision.Y, True)

132                     If UserList(tIndex).Stats.CantPenas >= 8 Then
134                         pena_string = "Ban permanente del personaje por acumulación de penas. Razón: " & Reason & " (GM: " & .Name & ") " & Now
136                         UserList(tIndex).flags.Ban = 1
138                         Call WriteVar(CharPath & UserName & ".chr", "PENAS", "BanMotivo", pena_string)

140                         UserList(tIndex).Counters.Pena = 10

142                         Call CloseSocket(tIndex)
144                         Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
146                         Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", "8")
148                         Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P8", pena_string)
                        Else

150                         Select Case UserList(tIndex).Stats.CantPenas

                            Case 1
152                             pena_string = "Encarcelado 30m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
154                             UserList(tIndex).Counters.Pena = 30

156                         Case 2
158                             pena_string = "Encarcelado 30m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
160                             UserList(tIndex).Counters.Pena = 30

162                         Case 3
164                             pena_string = "Encarcelado 60m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
166                             UserList(tIndex).Counters.Pena = 60

168                         Case 4
170                             pena_string = "Encarcelado 60m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
172                             UserList(tIndex).Counters.Pena = 60

174                         Case 5
176                             pena_string = "Ban por 15 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
178                             UserList(tIndex).flags.Ban = 1
180                             UserList(tIndex).Counters.Pena = 10
184                             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
186                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 15)

188                         Case 6
190                             pena_string = "Ban por 30 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
192                             UserList(tIndex).flags.Ban = 1
194                             UserList(tIndex).Counters.Pena = 10
198                             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
200                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 30)

202                         Case 7
204                             pena_string = "Ban por 60 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
206                             UserList(tIndex).flags.Ban = 1
208                             UserList(tIndex).Counters.Pena = 10
212                             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
214                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 60)

                            End Select

                        End If

216                     UserList(tIndex).Stats.Penas(UserList(tIndex).Stats.CantPenas) = pena_string
218                     Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(UserList(tIndex).Stats.CantPenas))
220                     Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & UserList(tIndex).Stats.CantPenas, pena_string)
222                     Call SaveUser(tIndex, CharPath & UserName & ".chr")

                        If UserList(tIndex).Stats.CantPenas > 4 Then Call CloseSocket(tIndex)

224                     Call WEB_Update_UserName(UserName)

                    Else

226                     If FileExist(CharPath & UserName & ".chr", vbNormal) Then
228                         count = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))

230                         count = count + 1

232                         Call WriteVar(CharPath & UserName & ".chr", "INIT", "Position", Prision.Map & "-" & Prision.X & "-" & Prision.Y)

234                         If count >= 8 Then
236                             pena_string = "Ban permanente del personaje. Razón: " & Reason & " - Gm: " & .Name & " " & Now
238                             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
240                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(.Stats.CantPenas))
242                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
                            Else

244                             Select Case count

                                Case 1
246                                 pena_string = "Encarcelado 30m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
248                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 30)

250                             Case 2
252                                 pena_string = "Encarcelado 30m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
254                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 30)

256                             Case 3
258                                 pena_string = "Encarcelado 60m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
260                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 60)

262                             Case 4
264                                 pena_string = "Encarcelado 60m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
266                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 60)

268                             Case 5
270                                 pena_string = "Ban por 15 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
272                                 Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
274                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 10)
276                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(.Stats.CantPenas))
278                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
280                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 15)

282                             Case 6
284                                 pena_string = "Ban por 30 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
286                                 Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
288                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 10)
290                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(.Stats.CantPenas))
292                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
294                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 30)

296                             Case 7
298                                 pena_string = "Ban por 60 días y encarcelado por 10m. Razón: " & Reason & " - Gm: " & .Name & " " & Now
300                                 Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")
302                                 Call WriteVar(CharPath & UserName & ".chr", "COUNTERS", "Pena", 10)
304                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(.Stats.CantPenas))
306                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & .Stats.CantPenas, pena_string)
308                                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "UNBAN_DATE", Now + 60)

                                End Select

                            End If

310                         Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", count)
312                         Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & count, pena_string)
314                         Call WriteConsoleMsg(UserIndex, "Has penado a " & UCase$(UserName) & ".", FontTypeNames.FONTTYPE_INFO)
316                         Call LogGM(.Name, " penó a " & UserName & " - Motivo: " & Reason)
318                         Call WEB_Update_UserName(UserName)

                        End If

                    End If

                End If

            End If

        End If

    End With

    Exit Sub
HandlePenar_Err:
320 Call LogError("TDSLegacy.Protocol.HandlePenar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleEditChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleEditChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim opcion As Integer

        Dim Arg1 As String

        Dim Arg2 As String

        Dim valido As Boolean

        Dim LoopC As Integer

        Dim CommandString As String

        Dim UserCharPath As String

        Dim var As Long

102     UserName = Replace(Message.ReadString16(), "+", " ")

104     If UCase$(UserName) = "YO" Then
106         tUser = UserIndex
        Else
108         tUser = NameIndex(UserName)

        End If

110     opcion = Message.ReadInt()
112     Arg1 = Message.ReadString16()
114     Arg2 = Message.ReadString16()

116     If .flags.Privilegios = PlayerType.RoleMaster Then

118         Select Case .flags.Privilegios        '>= PlayerType.Consejero

            Case PlayerType.Consejero
                ' Los RMs consejeros sólo se pueden editar su head, body y level
120             valido = tUser = UserIndex And (opcion = eEditOptions.eo_Body Or opcion = eEditOptions.eo_Head Or opcion = eEditOptions.eo_Level)

122         Case PlayerType.SemiDios
                ' Los RMs sólo se pueden editar su level y el head y body de cualquiera
124             valido = (opcion = eEditOptions.eo_Level And tUser = UserIndex) Or opcion = eEditOptions.eo_Body Or opcion = eEditOptions.eo_Head

126         Case PlayerType.Dios
                ' Los DRMs pueden aplicar los siguientes comandos sobre cualquiera
                ' pero si quiere modificar el level sólo lo puede hacer sobre sí mismo
128             valido = (opcion = eEditOptions.eo_Level And tUser = UserIndex) Or opcion = eEditOptions.eo_Body Or opcion = eEditOptions.eo_Head Or opcion = eEditOptions.eo_CiticensKilled Or opcion = eEditOptions.eo_CriminalsKilled Or opcion = eEditOptions.eo_Class Or opcion = eEditOptions.eo_Skills Or opcion = eEditOptions.eo_addGold

            End Select

130     ElseIf .flags.Privilegios >= PlayerType.Dios Then        'Si no es RM debe ser dios para poder usar este comando
132         valido = True

        End If

134     If valido Then
136         UserCharPath = CharPath & UserName & ".chr"

138         If tUser <= 0 And Not FileExist(UserCharPath) Then
140             Call WriteMensajes(UserIndex, Mensaje_50)
142             Call LogGM(.Name, "Intentó editar a un usuario que no existe: " & UserName)

            Else
                'For making the Log
144             CommandString = "/MOD "

146             Select Case opcion

                Case eEditOptions.eo_Gold

148                 If val(Arg1) <= MAX_ORO_EDIT Then
150                     If tUser <= 0 Then        ' Esta offline?
152                         Call WriteVar(UserCharPath, "STATS", "GLD", val(Arg1))
154                         Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                        Else        ' Online
156                         UserList(tUser).Stats.GLD = val(Arg1)
158                         Call WriteUpdateGold(tUser)

                        End If

                    Else
160                     WriteMensajes UserIndex, e_Mensajes.Mensaje_89

                    End If

                    ' Log it
162                 CommandString = CommandString & "ORO "

164             Case eEditOptions.eo_Experience

166                 If val(Arg1) > 90000000 Then
168                     Arg1 = 90000000
                    End If

170                 If tUser <= 0 Then        ' Offline
172                     var = GetVar(UserCharPath, "STATS", "EXP")
174                     Call WriteVar(UserCharPath, "STATS", "EXP", var + val(Arg1))
176                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
178                     UserList(tUser).Stats.Exp = UserList(tUser).Stats.Exp + val(Arg1)
180                     Call CheckUserLevel(tUser)
182                     Call WriteUpdateExp(tUser)

                    End If

                    ' Log it
184                 CommandString = CommandString & "EXP "

186             Case eEditOptions.eo_Body

190                 Call WriteVar(UserCharPath, "INIT", "Body", Arg1)

188                 If tUser <= 0 Then
192                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else
194                     Call ChangeUserChar(tUser, val(Arg1), UserList(tUser).Char.Head, UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, UserList(tUser).Char.CascoAnim)

                    End If

                    ' Log it
196                 CommandString = CommandString & "BODY "

198             Case eEditOptions.eo_Head

                    Call WriteVar(UserCharPath, "INIT", "Head", Arg1)

200                 If tUser <= 0 Then
204                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else
206                     Call ChangeUserChar(tUser, UserList(tUser).Char.body, val(Arg1), UserList(tUser).Char.Heading, UserList(tUser).Char.WeaponAnim, UserList(tUser).Char.ShieldAnim, UserList(tUser).Char.CascoAnim)
                    End If

                    ' Log it
208                 CommandString = CommandString & "HEAD "

210             Case eEditOptions.eo_CriminalsKilled
212                 var = IIf(val(Arg1) > MAXUSERMATADOS, MAXUSERMATADOS, val(Arg1))

214                 If tUser <= 0 Then        ' Offline
216                     Call WriteVar(UserCharPath, "FACCIONES", "CrimMatados", var)
218                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
220                     UserList(tUser).faccion.CriminalesMatados = var
                    End If

                    ' Log it
222                 CommandString = CommandString & "CRI "

224             Case eEditOptions.eo_CiticensKilled
226                 var = IIf(val(Arg1) > MAXUSERMATADOS, MAXUSERMATADOS, val(Arg1))

228                 If tUser <= 0 Then        ' Offline
230                     Call WriteVar(UserCharPath, "FACCIONES", "CiudMatados", var)
232                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
234                     UserList(tUser).faccion.CiudadanosMatados = var

                    End If

                    ' Log it
236                 CommandString = CommandString & "CIU "

238             Case eEditOptions.eo_Level

240                 If val(Arg1) > STAT_MAXELV Then
242                     Arg1 = CStr(STAT_MAXELV)
244                     Call WriteConsoleMsg(UserIndex, "No puedes tener un nivel superior a " & STAT_MAXELV & ".", FONTTYPE_INFO)

                    End If

                    ' Chequeamos si puede permanecer en el clan
246                 If val(Arg1) >= 25 Then

                        Dim GI As Integer

248                     If tUser <= 0 Then
250                         GI = GetVar(UserCharPath, "GUILD", "GUILDINDEX")
                        Else
252                         GI = UserList(tUser).GuildIndex

                        End If

254                     If GI > 0 Then
256                         If modGuilds.GuildAlignment(GI) = "Del Mal" Or modGuilds.GuildAlignment(GI) = "Real" Then
                                'We get here, so guild has factionary alignment, we have to expulse the user
258                             Call modGuilds.m_EcharMiembroDeClan(-1, UserName)

260                             Call SendData(SendTarget.ToGuildMembers, GI, PrepareMessageConsoleMsg(UserName & " deja el clan.", FontTypeNames.FONTTYPE_GUILD))

                                ' Si esta online le avisamos
262                             If tUser > 0 Then Call WriteConsoleMsg(tUser, "¡Ya tienes la madurez suficiente como para decidir bajo que estandarte pelearás! Por esta razón, hasta tanto no te enlistes en la facción bajo la cual tu clan está alineado, estarás excluído del mismo.", FontTypeNames.FONTTYPE_GUILD)

                            End If

                        End If

                    End If

                    Dim elu As Long

                    Dim qlvl As Long

264                 qlvl = val(Arg1)

                    'Nueva subida de exp x lvl. Pablo (ToxicWaste)
266                 If qlvl = 2 Then
268                     elu = 450
270                 ElseIf qlvl = 3 Then
272                     elu = 675
274                 ElseIf qlvl = 4 Then
276                     elu = 1012
278                 ElseIf qlvl = 5 Then
280                     elu = 1518
282                 ElseIf qlvl = 6 Then
284                     elu = 2277
286                 ElseIf qlvl = 7 Then
288                     elu = 3416
290                 ElseIf qlvl = 8 Then
292                     elu = 5124
294                 ElseIf qlvl = 9 Then
296                     elu = 7886
298                 ElseIf qlvl = 10 Then
300                     elu = 11529
302                 ElseIf qlvl = 11 Then
304                     elu = 14988
306                 ElseIf qlvl = 12 Then
308                     elu = 19484
310                 ElseIf qlvl = 13 Then
312                     elu = 25329
314                 ElseIf qlvl = 14 Then
316                     elu = 32928
318                 ElseIf qlvl = 15 Then
320                     elu = 42806
322                 ElseIf qlvl = 16 Then
324                     elu = 55648
326                 ElseIf qlvl = 17 Then
328                     elu = 72342
330                 ElseIf qlvl = 18 Then
332                     elu = 94045
334                 ElseIf qlvl = 19 Then
336                     elu = 122259
338                 ElseIf qlvl = 20 Then
340                     elu = 158937
342                 ElseIf qlvl = 21 Then
344                     elu = 206618
346                 ElseIf qlvl = 22 Then
348                     elu = 268603
350                 ElseIf qlvl = 23 Then
352                     elu = 349184
354                 ElseIf qlvl = 24 Then
356                     elu = 453939
358                 ElseIf qlvl = 25 Then
360                     elu = 544727
362                 ElseIf qlvl = 26 Then
364                     elu = 667632
366                 ElseIf qlvl = 27 Then
368                     elu = 784406
370                 ElseIf qlvl = 28 Then
372                     elu = 941287
374                 ElseIf qlvl = 29 Then
376                     elu = 1129544
378                 ElseIf qlvl = 30 Then
380                     elu = 1355453
382                 ElseIf qlvl = 31 Then
384                     elu = 1626544
386                 ElseIf qlvl = 32 Then
388                     elu = 1951853
390                 ElseIf qlvl = 33 Then
392                     elu = 2342224
394                 ElseIf qlvl = 34 Then
396                     elu = 3372803
398                 ElseIf qlvl = 35 Then
400                     elu = 4047364
402                 ElseIf qlvl = 36 Then
404                     elu = 5828204
406                 ElseIf qlvl = 37 Then
408                     elu = 6993845
410                 ElseIf qlvl = 38 Then
412                     elu = 8392614
414                 ElseIf qlvl = 39 Then
416                     elu = 10071137
418                 ElseIf qlvl = 40 Then
420                     elu = 120853640
422                 ElseIf qlvl = 41 Then
424                     elu = 145024370
426                 ElseIf qlvl = 42 Then
428                     elu = 174029240
430                 ElseIf qlvl = 43 Then
432                     elu = 208835090
434                 ElseIf qlvl = 44 Then
436                     elu = 417670180
438                 ElseIf qlvl = 45 Then
440                     elu = 835340360
442                 ElseIf qlvl = 46 Then
444                     elu = 1670680720
                    Else
446                     elu = 0
                    End If

448                 If tUser <= 0 Then        ' Offline
450                     Call WriteVar(UserCharPath, "STATS", "ELV", qlvl)
452                     Call WriteVar(UserCharPath, "STATS", "ELU", elu)
454                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
456                     UserList(tUser).Stats.ELV = qlvl
458                     UserList(tUser).Stats.elu = elu
460                     Call WriteUpdateUserStats(tUser)

                    End If

                    ' Log it
462                 CommandString = CommandString & "LEVEL "

464             Case eEditOptions.eo_Class

466                 For LoopC = 1 To NUMCLASES

468                     If UCase$(ListaClases(LoopC)) = UCase$(Arg1) Then Exit For
470                 Next LoopC

472                 If LoopC > NUMCLASES Then
474                     Call WriteConsoleMsg(UserIndex, "Clase desconocida. Intente nuevamente.", FontTypeNames.FONTTYPE_INFO)
                    Else

476                     If tUser <= 0 Then        ' Offline
478                         Call WriteVar(UserCharPath, "INIT", "Clase", LoopC)
480                         Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                        Else        ' Online
482                         UserList(tUser).Clase = LoopC

                        End If

                    End If

                    ' Log it
484                 CommandString = CommandString & "CLASE "

486             Case eEditOptions.eo_Skills

488                 For LoopC = 1 To NUMSKILLS

490                     If UCase$(Replace$(SkillsNames(LoopC), " ", "+")) = UCase$(Arg1) Then Exit For
492                 Next LoopC

494                 If LoopC > NUMSKILLS Then
496                     Call WriteConsoleMsg(UserIndex, "Skill Inexistente!", FontTypeNames.FONTTYPE_INFO)
                    Else

498                     If tUser <= 0 Then        ' Offline
500                         Call WriteVar(UserCharPath, "Skills", "SK" & LoopC, Arg2)
502                         Call WriteVar(UserCharPath, "Skills", "EXPSK" & LoopC, 0)

504                         If Arg2 < MAXSKILLPOINTS Then
506                             Call WriteVar(UserCharPath, "Skills", "ELUSK" & LoopC, ELU_SKILL_INICIAL * 1.05 ^ Arg2)
                            Else
508                             Call WriteVar(UserCharPath, "Skills", "ELUSK" & LoopC, 0)

                            End If

510                         Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                        Else        ' Online
512                         UserList(tUser).Stats.UserSkills(LoopC) = val(Arg2)
514                         Call CheckEluSkill(tUser, LoopC, True)

                        End If

                    End If

                    ' Log it
516                 CommandString = CommandString & "SKILLS "

518             Case eEditOptions.eo_SkillPointsLeft

520                 If tUser <= 0 Then        ' Offline
522                     Call WriteVar(UserCharPath, "STATS", "SkillPtsLibres", Arg1)
524                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
526                     UserList(tUser).Stats.SkillPts = val(Arg1)
                        Call WriteSendSkills(UserIndex)

                    End If

                    ' Log it
528                 CommandString = CommandString & "SKILLSLIBRES "

530             Case eEditOptions.eo_Nobleza
532                 var = IIf(val(Arg1) > MAXREP, MAXREP, val(Arg1))

534                 If tUser <= 0 Then        ' Offline
536                     Call WriteVar(UserCharPath, "REP", "Nobles", var)
538                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
540                     UserList(tUser).Reputacion.NobleRep = var

                    End If

                    ' Log it
542                 CommandString = CommandString & "NOB "

544             Case eEditOptions.eo_Asesino
546                 var = IIf(val(Arg1) > MAXREP, MAXREP, val(Arg1))

548                 If tUser <= 0 Then        ' Offline
550                     Call WriteVar(UserCharPath, "REP", "Asesino", var)
552                     Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                    Else        ' Online
554                     UserList(tUser).Reputacion.AsesinoRep = var

                    End If

                    ' Log it
556                 CommandString = CommandString & "ASE "

558             Case eEditOptions.eo_Sex

                    Dim Sex As Integer

560                 Sex = IIf(UCase(Arg1) = "MUJER", eGenero.Mujer, 0)        ' Mujer?
562                 Sex = IIf(UCase(Arg1) = "HOMBRE", eGenero.Hombre, Sex)        ' Hombre?

564                 If Sex <> 0 Then        ' Es Hombre o mujer?
566                     If tUser <= 0 Then        ' OffLine
568                         Call WriteVar(UserCharPath, "INIT", "Genero", Sex)
570                         Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                        Else        ' Online
572                         UserList(tUser).Genero = Sex

                        End If

                    Else
574                     Call WriteConsoleMsg(UserIndex, "Genero desconocido. Intente nuevamente.", FontTypeNames.FONTTYPE_INFO)

                    End If

                    ' Log it
576                 CommandString = CommandString & "SEX "

578             Case eEditOptions.eo_Raza

                    Dim raza As Integer

580                 Arg1 = UCase$(Arg1)

582                 Select Case Arg1

                    Case "HUMANO"
584                     raza = eRaza.Humano

586                 Case "ELFO"
588                     raza = eRaza.Elfo

590                 Case "DROW"
592                     raza = eRaza.Drow

594                 Case "ENANO"
596                     raza = eRaza.Enano

598                 Case "GNOMO"
600                     raza = eRaza.Gnomo

602                 Case Else
604                     raza = 0

                    End Select

606                 If raza = 0 Then
608                     Call WriteConsoleMsg(UserIndex, "Raza desconocida. Intente nuevamente.", FontTypeNames.FONTTYPE_INFO)
                    Else

610                     If tUser <= 0 Then
612                         Call WriteVar(UserCharPath, "INIT", "Raza", raza)
614                         Call WriteConsoleMsg(UserIndex, "Charfile Alterado: " & UserName, FontTypeNames.FONTTYPE_INFO)
                        Else
616                         UserList(tUser).raza = raza

                        End If

                    End If

                    ' Log it
618                 CommandString = CommandString & "RAZA "

620             Case eEditOptions.eo_addGold

                    Dim bankGold As Long

622                 If Abs(Arg1) > MAX_ORO_EDIT Then
624                     WriteMensajes UserIndex, e_Mensajes.Mensaje_89

                    Else

626                     If tUser <= 0 Then
628                         bankGold = GetVar(CharPath & UserName & ".chr", "STATS", "BANCO")
630                         Call WriteVar(UserCharPath, "STATS", "BANCO", IIf(bankGold + val(Arg1) <= 0, 0, bankGold + val(Arg1)))
632                         Call WriteConsoleMsg(UserIndex, "Se le ha agregado " & Arg1 & " monedas de oro a " & UserName & ".", FONTTYPE_TALK)
                        Else
634                         UserList(tUser).Stats.Banco = IIf(UserList(tUser).Stats.Banco + val(Arg1) <= 0, 0, UserList(tUser).Stats.Banco + val(Arg1))
636                         Call WriteConsoleMsg(tUser, STANDARD_BOUNTY_HUNTER_MESSAGE, FONTTYPE_TALK)

                        End If

                    End If

                    ' Log it
638                 CommandString = CommandString & "AGREGAR "

640             Case Else
642                 WriteMensajes UserIndex, e_Mensajes.Mensaje_91
644                 CommandString = CommandString & "UNKOWN "

                End Select

646             CommandString = CommandString & " " & UserName & " " & Arg1 & " " & Arg2
648             Call LogGM(.Name, CommandString & " " & UserName)

            End If

            If Len(CommandString) Then
                Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & .Name & " utilizó el comando: " & CommandString, FontTypeNames.FONTTYPE_SERVER))
            End If


        End If

    End With

    Exit Sub
HandleEditChar_Err:
650 Call LogError("TDSLegacy.Protocol.HandleEditChar en " & Erl & ". err: " & Err.Number & " " & Err.Description & " - " & CommandString)

End Sub

Private Sub HandleRequestCharInfo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharInfo_Err

100 With UserList(UserIndex)

        Dim TargetName As String

        Dim TargetIndex As Integer

102     TargetName = Replace$(Message.ReadString16(), "+", " ")
104     TargetIndex = NameIndex(TargetName)

106     If .flags.Privilegios >= PlayerType.SemiDios Then

108         If TargetIndex <= 0 Then

                'don't allow to retrieve administrator's info
110             If Not (EsDios(TargetName) Or EsAdmin(TargetName)) Then
112                 WriteMensajes UserIndex, e_Mensajes.Mensaje_62
114                 Call SendUserStatsTxtOFF(UserIndex, TargetName)

                End If

            Else

                'don't allow to retrieve administrator's info
116             If UserList(TargetIndex).flags.Privilegios <= PlayerType.SemiDios Or .flags.Privilegios = PlayerType.Admin Then
118                 Call SendUserStatsTxt(UserIndex, TargetIndex)

                End If

            End If

        End If

    End With

    Exit Sub
HandleRequestCharInfo_Err:
120 Call LogError("TDSLegacy.Protocol.HandleRequestCharInfo en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestCharStats(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharStats_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then

106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_63

112             Call SendUserMiniStatsTxtFromChar(UserIndex, UserName)
            Else
114             Call SendUserMiniStatsTxt(UserIndex, tUser)

            End If

        End If

    End With

    Exit Sub
HandleRequestCharStats_Err:
116 Call LogError("TDSLegacy.Protocol.HandleRequestCharStats en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestCharGold(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharGold_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()
104     tUser = NameIndex(UserName)

106     If EsGM(UserIndex) Then

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_63

112             Call SendUserOROTxtFromChar(UserIndex, UserName)
            Else
114             Call WriteConsoleMsg(UserIndex, "El usuario " & UserName & " tiene " & UserList(tUser).Stats.Banco & " en el banco.", FontTypeNames.FONTTYPE_TALK)

            End If

        End If

    End With

    Exit Sub
HandleRequestCharGold_Err:
116 Call LogError("TDSLegacy.Protocol.HandleRequestCharGold en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestCharInventory(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharInventory_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()
104     tUser = NameIndex(UserName)

106     If EsGM(UserIndex) Then
108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_63

112             Call SendUserInvTxtFromChar(UserIndex, UserName)
            Else
114             Call SendUserInvTxt(UserIndex, tUser)

            End If

        End If

    End With

    Exit Sub
HandleRequestCharInventory_Err:
116 Call LogError("TDSLegacy.Protocol.HandleRequestCharInventory en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestCharBank(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharBank_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()
104     tUser = NameIndex(UserName)

106     If EsGM(UserIndex) Then

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_63

112             Call SendUserBovedaTxtFromChar(UserIndex, UserName)
            Else
114             Call SendUserBovedaTxt(UserIndex, tUser)

            End If

        End If

    End With

    Exit Sub
HandleRequestCharBank_Err:
116 Call LogError("TDSLegacy.Protocol.HandleRequestCharBank en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestCharSkills(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRequestCharSkills_Err

100 With UserList(UserIndex)

        Dim UserName As String
        Dim tUser As Integer
        Dim LoopC As Long
        Dim Msg As String

102     UserName = Message.ReadString16()
104     tUser = NameIndex(UserName)

106     If EsGM(UserIndex) Then
108         If tUser <= 0 Then
110             If (InStrB(UserName, "\") <> 0) Then
112                 UserName = Replace(UserName, "\", "")
                End If

114             If (InStrB(UserName, "/") <> 0) Then
116                 UserName = Replace(UserName, "/", "")
                End If

118             For LoopC = 1 To NUMSKILLS
120                 Msg = Msg & "CHAR>" & SkillsNames(LoopC) & " = " & GetVar(CharPath & UserName & ".chr", "SKILLS", "SK" & LoopC) & vbCrLf
122             Next LoopC

124             Call WriteConsoleMsg(UserIndex, Msg & "CHAR> Libres:" & GetVar(CharPath & UserName & ".chr", "STATS", "SKILLPTSLIBRES"), FontTypeNames.FONTTYPE_INFO)
            Else
126             Call SendUserSkillsTxt(UserIndex, tUser)

            End If

        End If

    End With

    Exit Sub
HandleRequestCharSkills_Err:
128 Call LogError("TDSLegacy.Protocol.HandleRequestCharSkills en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleReviveChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleReviveChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         If UCase$(UserName) <> "YO" Then
108             tUser = NameIndex(UserName)
            Else
110             tUser = UserIndex

            End If

112         If tUser <= 0 Then
114             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else

116             With UserList(tUser)

                    'If dead, show him alive (naked).
118                 If .flags.Muerto = 1 Then
120                     .flags.Muerto = 0

122                     If .flags.Navegando = 1 Then
124                         Call ToogleBoatBody(UserIndex)
                            Call ChangeUserChar(tUser, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
                        Else
126                         Call DarCuerpoDesnudo(tUser)
                            Call ChangeUserChar(tUser, .Char.body, .OrigChar.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
                        End If

130                     Call WriteConsoleMsg(tUser, UserList(UserIndex).Name & " te ha resucitado.", FontTypeNames.FONTTYPE_INFO)
                    Else
132                     Call WriteConsoleMsg(tUser, UserList(UserIndex).Name & " te ha curado.", FontTypeNames.FONTTYPE_INFO)

                    End If

134                 .Stats.MinHP = .Stats.MaxHP


                End With

136             Call WriteUpdateHP(tUser)

                'Call Flushbuffer(tUser)

138             Call LogGM(.Name, "Resucito a " & UserName)

            End If

        End If

    End With

    Exit Sub
HandleReviveChar_Err:
140 Call LogError("TDSLegacy.Protocol.HandleReviveChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleOnlineGM(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleOnlineGM_Err

    Dim i As Long

    Dim list As String

100 With UserList(UserIndex)

102     If .flags.Privilegios = PlayerType.User Then Exit Sub

104     For i = 1 To LastUser
106         If UserList(i).flags.UserLogged And Not UserList(i).flags.Privilegios = PlayerType.User Then
108             If .flags.Privilegios >= UserList(i).flags.Privilegios Then list = list & UserList(i).Name & ", "
            End If
110     Next i

112     If LenB(list) <> 0 Then
114         list = Left$(list, Len(list) - 2)
116         Call WriteConsoleMsg(UserIndex, list & ".", FontTypeNames.FONTTYPE_INFO)
        Else
118         WriteMensajes UserIndex, e_Mensajes.Mensaje_65

        End If

    End With

    Exit Sub
HandleOnlineGM_Err:
120 Call LogError("TDSLegacy.Protocol.HandleOnlineGM en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleOnlineMap(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleOnlineMap_Err

100 With UserList(UserIndex)

        Dim Map As Integer

102     Map = Message.ReadInt

        If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub

        Dim LoopC As Long

        Dim list As String

106     For LoopC = 1 To LastUser

108         If LenB(UserList(LoopC).Name) <> 0 And UserList(LoopC).Pos.Map = Map Then
110             If UserList(LoopC).flags.Privilegios <= .flags.Privilegios Then list = list & UserList(LoopC).Name & ", "

            End If

112     Next LoopC

114     If Len(list) > 2 Then list = Left$(list, Len(list) - 2)

116     Call WriteConsoleMsg(UserIndex, "Usuarios en el mapa: " & list, FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleOnlineMap_Err:
118 Call LogError("TDSLegacy.Protocol.HandleOnlineMap en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleForgive(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleForgive_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)

108         If tUser > 0 Then
110             If EsNewbie(tUser) Then
112                 Call VolverCiudadano(tUser)
                Else
114                 Call LogGM(.Name, "Intento perdonar un personaje de nivel avanzado.")
116                 WriteMensajes UserIndex, e_Mensajes.Mensaje_66

                End If

            End If

        End If

    End With

    Exit Sub
HandleForgive_Err:
118 Call LogError("TDSLegacy.Protocol.HandleForgive en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleKick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleKick_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim Rank As Integer

102     Rank = PlayerType.Admin Or PlayerType.Dios Or PlayerType.SemiDios Or PlayerType.Consejero

104     UserName = Message.ReadString16()

106     If EsGM(UserIndex) Then
108         tUser = NameIndex(UserName)

110         If tUser <= 0 Then
112             WriteMensajes UserIndex, e_Mensajes.Mensaje_59
            Else

114             If UserList(tUser).flags.Privilegios > .flags.Privilegios Then
116                 WriteMensajes UserIndex, e_Mensajes.Mensaje_67
                Else
118                 Call LogGM(.Name, "Echó a " & UserName)
120                 Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.Name & " echó a " & UserName & ".", FontTypeNames.FONTTYPE_INFO))
122                 Call CloseSocket(tUser)

                End If

            End If

        End If

    End With

    Exit Sub
HandleKick_Err:
124 Call LogError("TDSLegacy.Protocol.HandleKick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleExecute(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleExecute_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

        Dim Drop As Byte

        Drop = Message.ReadInt8

        UserName = Replace$(UserName, "+", " ")

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)

108         If tUser > 0 Then
110             If UserList(tUser).flags.Privilegios > .flags.Privilegios Then
112                 Call WriteConsoleMsg(UserIndex, "¿¿Estás loco?? ¿¿Cómo vas a piñatear un gm?? :@", FontTypeNames.FONTTYPE_INFO)
                Else

                    Call UserDieExecution(tUser)
                    If Drop > 0 Then
                        Call TirarTodosLosItemsFull(tUser)
                    End If
                    Call UserDie(tUser)

                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " ha ejecutado a " & UserName & ".", FontTypeNames.FONTTYPE_EJECUCION))
                    Call LogGM(.Name, "/EJECUTAR " & UserName & IIf(Drop > 0, " - LE HIZO TIRAR TODOS LOS ITEMS!", ""))
                End If
            Else
120             WriteMensajes UserIndex, e_Mensajes.Mensaje_69

            End If

        End If

    End With

    Exit Sub
HandleExecute_Err:
122 Call LogError("TDSLegacy.Protocol.HandleExecute en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBanChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBanChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim Reason As String

102     UserName = Message.ReadString16()
104     Reason = Message.ReadString16()

106     If EsGM(UserIndex) Then
108         Call BanCharacter(UserIndex, UserName, Reason)

        End If

    End With

    Exit Sub
HandleBanChar_Err:
110 Call LogError("TDSLegacy.Protocol.HandleBanChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUnbanChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUnbanChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim CantPenas As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         If (InStrB(UserName, "\") <> 0) Then
108             UserName = Replace(UserName, "\", "")

            End If

110         If (InStrB(UserName, "/") <> 0) Then
112             UserName = Replace(UserName, "/", "")

            End If

114         If Not FileExist(CharPath & UserName & ".chr", vbNormal) Then

116             WriteMensajes UserIndex, e_Mensajes.Mensaje_73
            Else

118             If (val(GetVar(CharPath & UserName & ".chr", "FLAGS", "Ban")) = 1) Then
120                 Call UnBan(UserName)

                    'penas
122                 CantPenas = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))
124                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CantPenas + 1)
126                 Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & CantPenas + 1, LCase$(.Name) & ": UNBAN. " & Date & " " & Time)

128                 Call LogGM(.Name, "/UNBAN a " & UserName)
130                 Call WriteConsoleMsg(UserIndex, UserName & " unbanned.", FontTypeNames.FONTTYPE_INFO)
                Else
132                 Call WriteConsoleMsg(UserIndex, UserName & " no está baneado. Imposible unbanear.", FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End If

    End With

    Exit Sub
HandleUnbanChar_Err:
134 Call LogError("TDSLegacy.Protocol.HandleUnbanChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleNPCFollow(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleNPCFollow_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub

104     If .flags.TargetNPC > 0 Then
106         Call DoFollow(.flags.TargetNPC, .Name)
108         Npclist(.flags.TargetNPC).flags.Inmovilizado = 0
110         Npclist(.flags.TargetNPC).flags.Paralizado = 0
112         Npclist(.flags.TargetNPC).Contadores.Paralisis = 0

        End If

    End With

    Exit Sub
HandleNPCFollow_Err:
114 Call LogError("TDSLegacy.Protocol.HandleNPCFollow en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSummonChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSummonChar_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim X As Integer

        Dim Y As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_70
            Else
112             If .flags.Privilegios >= UserList(tUser).flags.Privilegios Then

                    If .flags.Privilegios < PlayerType.Admin Then

                        Dim valid As Boolean

                        If UCase$(MapInfo(.Pos.Map).Restringir) = "QUINCE" And Not UserList(tUser).Stats.ELV >= 15 Then
                            'Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel 15!")
                        ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "VEINTE" And Not UserList(tUser).Stats.ELV >= 20 Then
                            'Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel 20!")
                        ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "VEINTICINCO" And Not UserList(tUser).Stats.ELV >= 25 Then
                            'Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel 25!")
                        ElseIf UCase$(MapInfo(.Pos.Map).Restringir) = "CUARENTA" And Not UserList(tUser).Stats.ELV >= 40 Then
                            'Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel 40!")
                        Else
                            valid = True
                        End If

                        If Not UserList(tUser).Stats.ELV >= 25 Then
                            Select Case .Pos.Map

                            Case 47, 111, 114, 173, 113, 112, 169, 170, 171
                                valid = False

                            End Select
                        End If

                        If Not valid Then
                            Call WriteConsoleMsg(UserIndex, "No puedes sumonear a " & UserList(tUser).Name & " porque éste mapa requiere nivel " & UCase$(MapInfo(.Pos.Map).Restringir))
                            Call LogGM(.Name, "INTENTÓ SUMONEAR A " & UserName & " Map:" & .Pos.Map & " X:" & .Pos.X & " Y:" & .Pos.Y & ". Siendo " & UserName & " nivel " & UserList(tUser).Stats.ELV)
                            Exit Sub
                        End If
                    End If

                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor> " & UserList(tUser).Name & " fue transportado a: " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y & " por el GM: " & .Name, FontTypeNames.FONTTYPE_SERVER))

114                 Call WriteConsoleMsg(tUser, .Name & " te ha trasportado.", FontTypeNames.FONTTYPE_INFO)
116                 X = .Pos.X
118                 Y = .Pos.Y + 1
120                 Call FindLegalPos(tUser, .Pos.Map, X, Y, EsGM(tUser))
122                 Call WarpUserChar(tUser, .Pos.Map, X, Y, True)
124                 Call LogGM(.Name, "/SUM " & UserName & " Map:" & .Pos.Map & " X:" & .Pos.X & " Y:" & .Pos.Y)
                Else
126                 Call WriteConsoleMsg(UserIndex, "No puedes invocar a dioses y admins.", FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End If

    End With

    Exit Sub
HandleSummonChar_Err:
128 Call LogError("TDSLegacy.Protocol.HandleSummonChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSpawnListRequest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSpawnListRequest_Err

    If UserIndex = 0 Then Exit Sub

100 If UserList(UserIndex).flags.Privilegios <= PlayerType.Consejero Then Exit Sub
102 Call EnviarSpawnList(UserIndex)

    Exit Sub
HandleSpawnListRequest_Err:
104 Call LogError("TDSLegacy.Protocol.HandleSpawnListRequest en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSpawnCreature(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSpawnCreature_Err

100 With UserList(UserIndex)

        Dim npc As Integer
        Dim NpcIndex As Integer

102     npc = Message.ReadInt()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If npc > 0 And npc <= UBound(Declaraciones.SpawnList()) Then
                NpcIndex = SpawnNpc(Declaraciones.SpawnList(npc).NpcIndex, .Pos, True, False)

                If NpcIndex = 0 Then
                    Call WriteConsoleMsg(UserIndex, "No se pudo spawnear el NPC debido a que no encontró una posición válida.")
                Else

                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " ha spawneado un " & Npclist(NpcIndex).Name & " spawneado en las coordenadas " & Npclist(NpcIndex).Pos.Map & " " & Npclist(NpcIndex).Pos.X & " " & Npclist(NpcIndex).Pos.Y, FontTypeNames.FONTTYPE_SERVER))

                    Call LogGM(.Name, "Sumoneo " & Declaraciones.SpawnList(npc).NpcName & " - Pos: " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y)
                End If
            End If
        End If

    End With

    Exit Sub
HandleSpawnCreature_Err:
110 Call LogError("TDSLegacy.Protocol.HandleSpawnCreature en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleResetNPCInventory(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleResetNPCInventory_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub
104     If .flags.TargetNPC = 0 Then Exit Sub

106     Call ResetNpcInv(.flags.TargetNPC)

    End With

    Exit Sub
HandleResetNPCInventory_Err:
108 Call LogError("TDSLegacy.Protocol.HandleResetNPCInventory en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCleanWorld(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCleanWorld_Err

100 With UserList(UserIndex)

        Dim SpecificMap As Integer

102     SpecificMap = Message.ReadInt



104     If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub

106     If SpecificMap = 0 Then
108         Call LimpiarMundo
        Else
110         Call LimpiarMapa(SpecificMap)

        End If

112     Call LogGM(.Name, "/LIMPIAR " & IIf(SpecificMap > 0, SpecificMap, ""))

    End With

    Exit Sub
HandleCleanWorld_Err:
114 Call LogError("TDSLegacy.Protocol.HandleCleanWorld en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleServerMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleServerMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         If LenB(Msg) <> 0 Then
108             Call LogGM(.Name, "Mensaje Broadcast:" & Msg)
110             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & "> " & Msg, FontTypeNames.FONTTYPE_GUILD))
                ''''''''''''''''SOLO PARA EL TESTEO'''''''
                ''''''''''SE USA PARA COMUNICARSE CON EL SERVER'''''''''''
112             'frmMain.txtChat.Text = 'frmMain.txtChat.Text & vbNewLine & UserList(UserIndex).Name & " > " & message

            End If

        End If

    End With

    Exit Sub
HandleServerMessage_Err:
114 Call LogError("TDSLegacy.Protocol.HandleServerMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleNickToIP(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleNickToIP_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then
106         tUser = NameIndex(UserName)
108         Call LogGM(.Name, "NICK2IP Solicito la IP de " & UserName)

110         If tUser > 0 Then
112             If UserList(tUser).flags.Privilegios <= .flags.Privilegios Then
114                 Call WriteConsoleMsg(UserIndex, "El ip de " & UserName & " es " & UserList(tUser).IP, FontTypeNames.FONTTYPE_INFO)

                    Dim IP As String

                    Dim lista As String

                    Dim LoopC As Long

116                 IP = UserList(tUser).IP

118                 For LoopC = 1 To LastUser

120                     If UserList(LoopC).IP = IP Then
122                         If LenB(UserList(LoopC).Name) <> 0 And UserList(LoopC).flags.UserLogged Then
124                             If UserList(LoopC).flags.Privilegios <= .flags.Privilegios Then
126                                 lista = lista & UserList(LoopC).Name & ", "

                                End If

                            End If

                        End If

128                 Next LoopC

130                 If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)
132                 Call WriteConsoleMsg(UserIndex, "Los personajes con ip " & IP & " son: " & lista, FontTypeNames.FONTTYPE_INFO)

                End If

            Else
134             WriteMensajes UserIndex, e_Mensajes.Mensaje_75

            End If

        End If

    End With

    Exit Sub
HandleNickToIP_Err:
136 Call LogError("TDSLegacy.Protocol.HandleNickToIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleIPToNick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleIPToNick_Err

100 With UserList(UserIndex)

        Dim IP As String

        Dim LoopC As Long

        Dim lista As String

102     IP = Message.ReadInt8() & "."
104     IP = IP & Message.ReadInt8() & "."
106     IP = IP & Message.ReadInt8() & "."
108     IP = IP & Message.ReadInt8()

110     If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub

112     Call LogGM(.Name, "IP2NICK Solicito los Nicks de IP " & IP)

114     For LoopC = 1 To LastUser

116         If UserList(LoopC).IP = IP Then
118             If LenB(UserList(LoopC).Name) <> 0 And UserList(LoopC).flags.UserLogged Then
120                 If UserList(LoopC).flags.Privilegios <= .flags.Privilegios Then
122                     lista = lista & UserList(LoopC).Name & ", "

                    End If

                End If

            End If

124     Next LoopC

126     If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)
128     Call WriteConsoleMsg(UserIndex, "Los personajes con ip " & IP & " son: " & lista, FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleIPToNick_Err:
130 Call LogError("TDSLegacy.Protocol.HandleIPToNick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildOnlineMembers(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildOnlineMembers_Err

100 With UserList(UserIndex)

        Dim GuildName As String

        Dim tGuild As Integer

102     GuildName = Message.ReadString16()

104     If (InStrB(GuildName, "+") <> 0) Then
106         GuildName = Replace(GuildName, "+", " ")

        End If

108     If EsGM(UserIndex) Then
110         tGuild = GuildIndex(GuildName)

112         If tGuild > 0 Then
114             Call WriteConsoleMsg(UserIndex, "Clan " & UCase(GuildName) & ": " & modGuilds.m_ListaDeMiembrosOnline(UserIndex, tGuild), FontTypeNames.FONTTYPE_GUILDMSG)

            End If

        End If

    End With

    Exit Sub
HandleGuildOnlineMembers_Err:
116 Call LogError("TDSLegacy.Protocol.HandleGuildOnlineMembers en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTeleportCreate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTeleportCreate_Err

100 With UserList(UserIndex)

        Dim mapa As Integer

        Dim X As Byte

        Dim Y As Byte

        Dim Radio As Byte

102     mapa = Message.ReadInt()
104     X = Message.ReadInt8()
106     Y = Message.ReadInt8()
108     Radio = Message.ReadInt8()

110     Radio = MinimoInt(Radio, 6)

112     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

114     Call LogGM(.Name, "/CT " & mapa & "," & X & "," & Y & "," & Radio)

116     If Not MapaValido(mapa) Or Not InMapBounds(mapa, X, Y) Then Exit Sub

118     If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).ObjInfo.ObjIndex > 0 Then Exit Sub

120     If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).TileExit.Map > 0 Then Exit Sub

122     If MapData(mapa, X, Y).ObjInfo.ObjIndex > 0 Then
124         WriteMensajes UserIndex, e_Mensajes.Mensaje_78
            Exit Sub

        End If

126     If MapData(mapa, X, Y).TileExit.Map > 0 Then
128         Call WriteConsoleMsg(UserIndex, "No puedes crear un teleport que apunte a la entrada de otro.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

        Dim ET As Obj

130     ET.Amount = 1
        ' Es el numero en el dat. El indice es el comienzo + el radio, todo harcodeado :(.
132     ET.ObjIndex = TELEP_OBJ_INDEX

134     With MapData(.Pos.Map, .Pos.X, .Pos.Y - 1)
136         .TileExit.Map = mapa
138         .TileExit.X = X
140         .TileExit.Y = Y
            .TileExit.Radio = Radio
        End With


        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " ha creado un TP en: " & .Pos.Map & " " & .Pos.X & " " & .Pos.Y - 1 & " que va a: " & mapa & " " & X & " " & Y, FontTypeNames.FONTTYPE_VENENO))

        If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).UserIndex <> 0 Then
            Call DoTileEvents(MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).UserIndex, .Pos.Map, .Pos.X, .Pos.Y - 1)
        End If

        Call SetTriggerIlegalNPC(.Pos.Map, .Pos.X, .Pos.Y - 1)

142     Call MakeObj(ET, .Pos.Map, .Pos.X, .Pos.Y - 1)

    End With

    Exit Sub
HandleTeleportCreate_Err:
144 Call LogError("TDSLegacy.Protocol.HandleTeleportCreate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTeleportDestroy(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTeleportDestroy_Err

100 With UserList(UserIndex)

        Dim mapa As Integer

        Dim X As Integer

        Dim Y As Integer

        '/dt
102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     mapa = .flags.TargetMap
106     X = .flags.TargetX
108     Y = .flags.TargetY

110     If Not InMapBounds(mapa, X, Y) Then Exit Sub

112     With MapData(mapa, X, Y)

114         If .ObjInfo.ObjIndex = 0 Then Exit Sub

116         If ObjData(.ObjInfo.ObjIndex).OBJType = eOBJType.otTeleport And .TileExit.Map > 0 Then
118             Call LogGM(UserList(UserIndex).Name, "/DT: " & mapa & "," & X & "," & Y)

120             Call EraseObj(.ObjInfo.Amount, mapa, X, Y)

122             If MapData(.TileExit.Map, .TileExit.X, .TileExit.Y).ObjInfo.ObjIndex = 651 Then
124                 Call EraseObj(1, .TileExit.Map, .TileExit.X, .TileExit.Y)
                End If

126             .TileExit.Map = 0
128             .TileExit.X = 0
130             .TileExit.Y = 0
                Call RemoveTriggerIlegalNPC(mapa, X, Y)

            End If

        End With

    End With

    Exit Sub
HandleTeleportDestroy_Err:
132 Call LogError("TDSLegacy.Protocol.HandleTeleportDestroy en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRainToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRainToggle_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Consejero Then Exit Sub

        If LluviaActiva = 0 Then Exit Sub

        MinutosSinLluvia = 0
        MinutosLloviendo = 0

104     Call LogGM(.Name, "/LLUVIA")
106     Lloviendo = Not Lloviendo

108     Call SendData(SendTarget.ToAllButDungeon, 0, PrepareMessageRainToggle(Lloviendo))

    End With

    Exit Sub
HandleRainToggle_Err:
110 Call LogError("TDSLegacy.Protocol.HandleRainToggle en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSetCharDescription(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSetCharDescription_Err

100 With UserList(UserIndex)

        Dim tUser As Integer

        Dim Desc As String

102     Desc = Message.ReadString16()

        Dim isDesc As Boolean

        isDesc = Message.ReadBool()


104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         tUser = .flags.TargetUser

108         If tUser > 0 Then

                If isDesc And .flags.Privilegios = PlayerType.Admin Then
110                 UserList(tUser).Desc = Desc
                Else
111                 UserList(tUser).DescRM = Desc

                End If

            Else
112             Call WriteConsoleMsg(UserIndex, "Haz click sobre un personaje antes.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

    Exit Sub
HandleSetCharDescription_Err:
114 Call LogError("TDSLegacy.Protocol.HandleSetCharDescription en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HanldeForceMIDIToMap(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HanldeForceMIDIToMap_Err

100 With UserList(UserIndex)

        Dim midiID As Integer

        Dim mapa As Integer

102     midiID = Message.ReadInt
104     mapa = Message.ReadInt

        'Solo dioses, admins y RMS
106     If .flags.Privilegios <= PlayerType.Admin Or .flags.Privilegios = PlayerType.RoleMaster Then

            'Si el mapa no fue enviado tomo el actual
108         If Not InMapBounds(mapa, 50, 50) Then
110             mapa = .Pos.Map

            End If

112         If midiID = 0 Then
                'Ponemos el default del mapa
114             Call SendData(SendTarget.toMap, mapa, PrepareMessagePlayMidi(MapInfo(.Pos.Map).music))
            Else
                'Ponemos el pedido por el GM
116             Call SendData(SendTarget.toMap, mapa, PrepareMessagePlayMidi(midiID))

            End If

        End If

    End With

    Exit Sub
HanldeForceMIDIToMap_Err:
118 Call LogError("TDSLegacy.Protocol.HanldeForceMIDIToMap en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleForceWAVEToMap(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleForceWAVEToMap_Err

100 With UserList(UserIndex)

        Dim waveID As Integer

        Dim mapa As Integer

        Dim X As Byte

        Dim Y As Byte

102     waveID = Message.ReadInt()
104     mapa = Message.ReadInt()
106     X = Message.ReadInt8()
108     Y = Message.ReadInt8()

        'Solo dioses, admins y RMS
110     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then

            'Si el mapa no fue enviado tomo el actual
112         If Not InMapBounds(mapa, X, Y) Then
114             mapa = .Pos.Map
116             X = .Pos.X
118             Y = .Pos.Y

            End If

            'Ponemos el pedido por el GM
120         Call SendData(SendTarget.toMap, mapa, PrepareMessagePlayWave(waveID, X, Y))

        End If

    End With

    Exit Sub
HandleForceWAVEToMap_Err:
122 Call LogError("TDSLegacy.Protocol.HandleForceWAVEToMap en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRoyalArmyMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRoyalArmyMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

        'Solo dioses, admins y RMS
104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         Call SendData(SendTarget.ToRealYRMs, 0, PrepareMessageConsoleMsg("EJÉRCITO REAL> " & Msg, FontTypeNames.FONTTYPE_TALK))

        End If

    End With

    Exit Sub
HandleRoyalArmyMessage_Err:
108 Call LogError("TDSLegacy.Protocol.HandleRoyalArmyMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

''
' Handles the "ChaosLegionMessage" message.
'
' @param    userIndex The index of the user sending the message.

Private Sub HandleChaosLegionMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleChaosLegionMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

        'Solo dioses, admins y RMS
104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         Call SendData(SendTarget.ToCaosYRMs, 0, PrepareMessageConsoleMsg("FUERZAS DEL CAOS> " & Msg, FontTypeNames.FONTTYPE_TALK))

        End If

    End With

    Exit Sub
HandleChaosLegionMessage_Err:
108 Call LogError("TDSLegacy.Protocol.HandleChaosLegionMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCitizenMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCitizenMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

        'Solo dioses, admins y RMS
104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         Call SendData(SendTarget.ToCiudadanosYRMs, 0, PrepareMessageConsoleMsg("CIUDADANOS> " & Msg, FontTypeNames.FONTTYPE_TALK))

        End If

    End With

    Exit Sub
HandleCitizenMessage_Err:
108 Call LogError("TDSLegacy.Protocol.HandleCitizenMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCriminalMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCriminalMessage_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

        'Solo dioses, admins y RMS
104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         Call SendData(SendTarget.ToCriminalesYRMs, 0, PrepareMessageConsoleMsg("CRIMINALES> " & Msg, FontTypeNames.FONTTYPE_TALK))

        End If

    End With

    Exit Sub
HandleCriminalMessage_Err:
108 Call LogError("TDSLegacy.Protocol.HandleCriminalMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTalkAsNPC(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTalkAsNPC_Err

100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

        'Solo dioses, admins y RMS
104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then

            'Asegurarse haya un NPC seleccionado
106         If .flags.TargetNPC > 0 Then
108             Call SendData(SendTarget.ToNPCArea, .flags.TargetNPC, PrepareMessageChatOverHead(Msg, Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite))
            Else
110             Call WriteConsoleMsg(UserIndex, "Debes seleccionar el NPC por el que quieres hablar antes de usar este comando.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

    Exit Sub
HandleTalkAsNPC_Err:
112 Call LogError("TDSLegacy.Protocol.HandleTalkAsNPC en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDestroyAllItemsInArea(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDestroyAllItemsInArea_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

        Dim X As Long

        Dim Y As Long

        Dim bIsExit As Boolean

104     For Y = .Pos.Y - MinYBorder + 1 To .Pos.Y + MinYBorder - 1
106         For X = .Pos.X - MinXBorder + 1 To .Pos.X + MinXBorder - 1

108             If X > 0 And Y > 0 And X < 101 And Y < 101 Then
110                 If MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex > 0 Then
112                     bIsExit = MapData(.Pos.Map, X, Y).TileExit.Map > 0

114                     If ItemNoEsDeMapa(MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex, bIsExit) Then
116                         Call EraseObj(MAX_INVENTORY_OBJS, .Pos.Map, X, Y)

                        End If

                    End If

                End If

118         Next X
120     Next Y

122     Call LogGM(UserList(UserIndex).Name, "/MASSDEST en " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y)

    End With

    Exit Sub
HandleDestroyAllItemsInArea_Err:
124 Call LogError("TDSLegacy.Protocol.HandleDestroyAllItemsInArea en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAcceptRoyalCouncilMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleAcceptRoyalCouncilMember_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim LoopC As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else

112             With UserList(tUser)

114                 If .faccion.Status = 0 Then
116                     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue aceptado en el honorable Consejo Real de Banderbill.", FontTypeNames.FONTTYPE_CONSEJO))
118                     .faccion.Status = FaccionType.RoyalCouncil
120                     .flags.ChatColor = RGB(0, 255, 255)
122                     Call RefreshCharStatus(tUser)
124                     Call ChangeUserChar(tUser, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
                    Else
126                     Call WriteConsoleMsg(UserIndex, UserName & " pertenece a una facción!")

                    End If

                End With

            End If

        End If

    End With

    Exit Sub
HandleAcceptRoyalCouncilMember_Err:
128 Call LogError("TDSLegacy.Protocol.HandleAcceptRoyalCouncilMember en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAcceptChaosCouncilMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleAcceptChaosCouncilMember_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else

112             With UserList(tUser)

114                 If .faccion.Status = 0 Then
116                     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue aceptado en el Concilio de las Sombras.", FontTypeNames.FONTTYPE_CONSEJO))
118                     .faccion.Status = FaccionType.ChaosCouncil
120                     .flags.ChatColor = RGB(126, 126, 126)
122                     Call RefreshCharStatus(tUser)
124                     Call ChangeUserChar(tUser, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)
                    Else
126                     Call WriteConsoleMsg(UserIndex, UserName & " pertenece a una facción!")

                    End If

                    'Call WarpUserChar(tUser, .Pos.Map, .Pos.X, .Pos.Y, False)
                End With

            End If

        End If

    End With

    Exit Sub
HandleAcceptChaosCouncilMember_Err:
128 Call LogError("TDSLegacy.Protocol.HandleAcceptChaosCouncilMember en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleItemsInTheFloor(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleItemsInTheFloor_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

        Dim tObj As Integer

        Dim X As Long

        Dim Y As Long

104     For X = 5 To 95
106         For Y = 5 To 95
108             tObj = MapData(.Pos.Map, X, Y).ObjInfo.ObjIndex

110             If tObj > 0 Then
112                 If ObjData(tObj).OBJType <> eOBJType.otArboles Then
114                     Call WriteConsoleMsg(UserIndex, "(" & X & "," & Y & ") " & ObjData(tObj).Name, FontTypeNames.FONTTYPE_INFO)

                    End If

                End If

116         Next Y
118     Next X

    End With

    Exit Sub
HandleItemsInTheFloor_Err:
120 Call LogError("TDSLegacy.Protocol.HandleItemsInTheFloor en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleMakeDumb(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleMakeDumb_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.SemiDios Then
106         tUser = NameIndex(UserName)

            'para deteccion de aoice
108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else
112             Call WriteDumb(tUser)

            End If

        End If

    End With

    Exit Sub
HandleMakeDumb_Err:
114 Call LogError("TDSLegacy.Protocol.HandleMakeDumb en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleMakeDumbNoMore(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleMakeDumbNoMore_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.SemiDios Then
106         tUser = NameIndex(UserName)

            'para deteccion de aoice
108         If tUser <= 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_56
            Else
112             Call WriteDumbNoMore(tUser)

                'Call Flushbuffer(tUser)
            End If

        End If

    End With

    Exit Sub
HandleMakeDumbNoMore_Err:
114 Call LogError("TDSLegacy.Protocol.HandleMakeDumbNoMore en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCouncilKick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCouncilKick_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         tUser = NameIndex(UserName)

108         If tUser <= 0 Then
110             If FileExist(CharPath & UserName & ".chr") Then
112                 WriteMensajes UserIndex, e_Mensajes.Mensaje_77
114                 Call WriteVar(CharPath & UserName & ".chr", "FACCION", "Status", 0)
                Else
116                 Call WriteConsoleMsg(UserIndex, "No se encuentra el charfile " & CharPath & UserName & ".chr", FontTypeNames.FONTTYPE_INFO)

                End If

            Else

118             With UserList(tUser)

                    Dim Msg As String

120                 If .faccion.Status = FaccionType.RoyalCouncil Then
122                     Msg = "Has sido echado del consejo de Banderbill."
124                 ElseIf .faccion.Status = FaccionType.ChaosCouncil Then
126                     Msg = "Has sido echado del Concilio de las Sombras."

                    End If

128                 If Msg <> "" Then
130                     Call WriteConsoleMsg(tUser, Msg, FontTypeNames.FONTTYPE_TALK)
132                     .faccion.Status = 0
134                     Call ChangeUserChar(tUser, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)

136                     Call RefreshCharStatus(tUser)
138                     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(UserName & " fue expulsado del Concilio de las Sombras.", FontTypeNames.FONTTYPE_CONSEJO))

                    End If

                End With

            End If

        End If

    End With

    Exit Sub
HandleCouncilKick_Err:
140 Call LogError("TDSLegacy.Protocol.HandleCouncilKick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSetTrigger(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSetTrigger_Err

100 With UserList(UserIndex)

        Dim tTrigger As Byte

        Dim tLog As String

102     tTrigger = Message.ReadInt8()

104     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

106     If tTrigger >= 0 Then
108         MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger = tTrigger
110         tLog = "Trigger " & tTrigger & " en mapa " & .Pos.Map & " " & .Pos.X & "," & .Pos.Y

112         Call LogGM(.Name, tLog)
114         Call WriteConsoleMsg(UserIndex, tLog, FontTypeNames.FONTTYPE_INFO)

        End If

    End With

    Exit Sub
HandleSetTrigger_Err:
116 Call LogError("TDSLegacy.Protocol.HandleSetTrigger en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAskTrigger(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleAskTrigger_Err

    Dim tTrigger As Integer

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     tTrigger = MapData(.Pos.Map, .Pos.X, .Pos.Y).trigger

106     Call WriteConsoleMsg(UserIndex, "Trigger " & tTrigger & " en mapa " & .Pos.Map & " " & .Pos.X & ", " & .Pos.Y, FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleAskTrigger_Err:
108 Call LogError("TDSLegacy.Protocol.HandleAskTrigger en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBannedIPList(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBannedIPList_Err

100 With UserList(UserIndex)

102     If (.flags.Privilegios <= PlayerType.SemiDios) Then Exit Sub

        Dim lista As String

        Dim LoopC As Long

104     Call LogGM(.Name, "/BANIPLIST")

106     For LoopC = 1 To IP_Blacklist.count
108         lista = lista & IP_Blacklist.Item(LoopC) & ", "
110     Next LoopC

112     If LenB(lista) <> 0 Then lista = Left$(lista, Len(lista) - 2)

114     Call WriteConsoleMsg(UserIndex, lista, FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleBannedIPList_Err:
116 Call LogError("TDSLegacy.Protocol.HandleBannedIPList en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBannedIPReload(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBannedIPReload_Err

100 With UserList(UserIndex)

102     If (.flags.Privilegios <= PlayerType.SemiDios) Then Exit Sub

104     Call CargarListaNegraUsuarios

106     Call WriteConsoleMsg(UserIndex, "Lista de IPs recargada.", FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleBannedIPReload_Err:
108 Call LogError("TDSLegacy.Protocol.HandleBannedIPReload en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGuildBan(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGuildBan_Err

100 With UserList(UserIndex)

        Dim GuildName As String

        Dim CantMembers As Integer

        Dim LoopC As Long

        Dim member As String

        Dim count As Integer

        Dim tIndex As Integer

        Dim tFile As String

102     GuildName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Admin Then
106         tFile = App.path & "\guilds\" & GuildName & "-members.mem"

108         If Not FileExist(tFile) Then
110             Call WriteConsoleMsg(UserIndex, "No existe el clan: " & GuildName, FontTypeNames.FONTTYPE_INFO)
            Else
112             Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.Name & " baneó al clan " & UCase$(GuildName), FontTypeNames.FONTTYPE_FIGHT))

                'baneamos a los miembros
114             Call LogGM(.Name, "BANCLAN a " & UCase$(GuildName))

116             CantMembers = val(GetVar(tFile, "INIT", "NroMembers"))

118             For LoopC = 1 To CantMembers
120                 member = GetVar(tFile, "Members", "Member" & LoopC)
                    'member es la victima
122                 Call Ban(member, "Administracion del server", "Clan Banned")

124                 Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("   " & member & "<" & GuildName & "> ha sido expulsado del server.", FontTypeNames.FONTTYPE_FIGHT))

126                 tIndex = NameIndex(member)

128                 If tIndex > 0 Then
                        'esta online
130                     UserList(tIndex).flags.Ban = 1
132                     Call CloseSocket(tIndex)

                    End If

                    'ponemos el flag de ban a 1
134                 Call WriteVar(CharPath & member & ".chr", "FLAGS", "Ban", "1")
                    'ponemos la pena
136                 count = val(GetVar(CharPath & member & ".chr", "PENAS", "Cant"))
138                 Call WriteVar(CharPath & member & ".chr", "PENAS", "Cant", count + 1)
140                 Call WriteVar(CharPath & member & ".chr", "PENAS", "P" & count + 1, LCase$(.Name) & ": BAN AL CLAN: " & GuildName & " " & Date & " " & Time)
142             Next LoopC

            End If

        End If

    End With

    Exit Sub
HandleGuildBan_Err:
144 Call LogError("TDSLegacy.Protocol.HandleGuildBan en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleBanIP(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBanIP_Err

    Dim tUser As Integer

    Dim bannedip As String

100 With UserList(UserIndex)

102     Dim NickOrIP As String: NickOrIP = Message.ReadString16()

104     Dim Reason As String: Reason = Message.ReadString16()

        ' Si el 4to caracter es un ".", de "XXX.XXX.XXX.XXX", entonces es IP.
106     If mid$(NickOrIP, 4, 1) = "." Then

            ' Me fijo que tenga formato valido
108         If IsValidIPAddress(NickOrIP) Then
110             bannedip = NickOrIP
            Else
112             Call WriteConsoleMsg(UserIndex, "La IP " & NickOrIP & " no tiene un formato válido.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub

            End If

        Else    ' Es un Nick

114         tUser = NameIndex(NickOrIP)

116         If tUser <= 0 Then
118             Call WriteConsoleMsg(UserIndex, "El personaje no está online.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            Else
120             bannedip = UserList(tUser).IP

            End If

        End If

122     If LenB(bannedip) = 0 Then Exit Sub

124     If (.flags.Privilegios < PlayerType.Dios) = 0 Then
126         Call WriteConsoleMsg(UserIndex, "Servidor » Comando deshabilitado para tu cargo.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

128     If IP_Blacklist.Exists(bannedip) Then
130         Call WriteConsoleMsg(UserIndex, "La IP " & bannedip & " ya se encuentra en la lista negra de IPs.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

132     Call BanearIP(UserIndex, NickOrIP, bannedip)    ', UserList(UserIndex).Cuenta)

134     Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg(.Name & " baneó la IP " & bannedip & " por " & Reason, FontTypeNames.FONTTYPE_FIGHT))

        'Find every player with that ip and ban him!
        Dim i As Long

136     For i = 1 To LastUser

138         If UserList(i).ConnIDValida Then
140             If UserList(i).IP = bannedip Then
                    '142                     Call WriteCerrarleCliente(i)
142                 Call CloseSocket(i)

                End If

            End If

144     Next i

    End With

    Exit Sub
HandleBanIP_Err:
146 Call LogError("TDSLegacy.Protocol.HandleBanIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleUnbanIP(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleUnbanIP_Err

100 With UserList(UserIndex)

        Dim bannedip As String

102     bannedip = Message.ReadInt8() & "."
104     bannedip = bannedip & Message.ReadInt8() & "."
106     bannedip = bannedip & Message.ReadInt8() & "."
108     bannedip = bannedip & Message.ReadInt8()

110     If (.flags.Privilegios < PlayerType.Dios) Then Exit Sub

112     If IP_Blacklist.Exists(bannedip) Then
114         Call DesbanearIP(bannedip, UserIndex)
116         Call WriteConsoleMsg(UserIndex, "La IP """ & bannedip & """ se ha quitado de la lista de bans.", FontTypeNames.FONTTYPE_INFO)
        Else
118         Call WriteConsoleMsg(UserIndex, "La IP """ & bannedip & """ NO se encuentra en la lista de bans.", FontTypeNames.FONTTYPE_INFO)

        End If

    End With

    Exit Sub
HandleUnbanIP_Err:
120 Call LogError("TDSLegacy.Protocol.HandleUnbanIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleCreateItem(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCreateItem_Err

100 With UserList(UserIndex)

        Dim tObj As Integer, Cuantos As Integer

102     tObj = Message.ReadInt()
104     Cuantos = Message.ReadInt()

106     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub
108     If Cuantos <= 0 Then Cuantos = 1: If Cuantos > 10000 Then Cuantos = 10000

114     If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).ObjInfo.ObjIndex > 0 Then Exit Sub

116     If MapData(.Pos.Map, .Pos.X, .Pos.Y - 1).TileExit.Map > 0 Then Exit Sub

118     If tObj < 1 Or tObj > NumObjDatas Then Exit Sub

        'Is the object not null?
120     If LenB(ObjData(tObj).Name) = 0 Then Exit Sub

110     If .flags.Privilegios < PlayerType.Dios Then
            If ObjData(tObj).Agarrable = 1 Then
                Exit Sub
            End If
        End If

112     Call LogGM(.Name, "/CI: " & Cuantos & ObjData(tObj).Name & "(" & tObj & ")")

        Dim objeto As Obj

122     Call WriteConsoleMsg(UserIndex, "Item creado", FontTypeNames.FONTTYPE_GUILD)

124     objeto.Amount = Cuantos
126     objeto.ObjIndex = tObj

        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Servidor - " & .Name & " creó " & objeto.Amount & " " & ObjData(tObj).Name & " en la posición " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y, FontTypeNames.FONTTYPE_SERVER))

128     Call MakeObj(objeto, .Pos.Map, .Pos.X, .Pos.Y)

    End With

    Exit Sub
HandleCreateItem_Err:
130 Call LogError("TDSLegacy.Protocol.HandleCreateItem en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleDestroyItems(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDestroyItems_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     If MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex = 0 Then
106         If .flags.TargetObjMap > 0 And .flags.TargetObjX > 0 And .flags.TargetObjY > 0 Then
108             If MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex > 0 Then

110                 Call LogGM(.Name, "/DEST Num: " & ObjData(MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.ObjIndex).Name & " - Cantidad: " & MapData(.flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY).ObjInfo.Amount & " (" & .flags.TargetObjMap & "-" & .flags.TargetObjX & "-" & .flags.TargetObjY & ")")
112                 Call EraseObj(10000, .flags.TargetObjMap, .flags.TargetObjX, .flags.TargetObjY)
114                 .flags.TargetMap = 0
116                 .flags.TargetObjX = 0
118                 .flags.TargetObjY = 0

                End If

            End If

            Exit Sub

        End If

120     Call LogGM(.Name, "/DEST Num: " & ObjData(MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex).Name & " - Cantidad: " & MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.Amount & " (" & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y & ")")

122     If ObjData(MapData(.Pos.Map, .Pos.X, .Pos.Y).ObjInfo.ObjIndex).OBJType = eOBJType.otTeleport And MapData(.Pos.Map, .Pos.X, .Pos.Y).TileExit.Map > 0 Then

124         Call WriteConsoleMsg(UserIndex, "No puede destruir teleports así. Utilice /DT.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub

        End If

126     Call EraseObj(10000, .Pos.Map, .Pos.X, .Pos.Y)

    End With

    Exit Sub
Errhandler:
128 Call LogError("Error en HandleDestroyItems en " & Erl & ". Err: " & Err.Number & " " & Err.Description)

    Exit Sub
HandleDestroyItems_Err:
130 Call LogError("TDSLegacy.Protocol.HandleDestroyItems en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleChaosLegionKick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleChaosLegionKick_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If (InStrB(UserName, "\") <> 0) Then
108             UserName = Replace(UserName, "\", "")

            End If

110         If (InStrB(UserName, "/") <> 0) Then
112             UserName = Replace(UserName, "/", "")

            End If

114         tUser = NameIndex(UserName)

116         Call LogGM(.Name, "ECHO DEL CAOS A: " & UserName)

118         If tUser > 0 Then
120             Call ExpulsarFaccionCaos(tUser, True)
122             UserList(tUser).faccion.Reenlistadas = 200
124             Call WriteConsoleMsg(UserIndex, UserName & " expulsado de las fuerzas del caos y prohibida la reenlistada.", FontTypeNames.FONTTYPE_INFO)
126             WriteMensajes tUser, e_Mensajes.Mensaje_183

                'Call Flushbuffer(tUser)
            Else

128             If FileExist(CharPath & UserName & ".chr") Then
130                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "EjercitoCaos", 0)
132                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "Reenlistadas", 200)
134                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "Extra", "Expulsado por " & .Name)
136                 Call WriteConsoleMsg(UserIndex, UserName & " expulsado de las fuerzas del caos y prohibida la reenlistada.", FontTypeNames.FONTTYPE_INFO)
                Else
138                 Call WriteMensajes(UserIndex, Mensaje_50)

                End If

            End If

        End If

    End With

    Exit Sub
HandleChaosLegionKick_Err:
140 Call LogError("TDSLegacy.Protocol.HandleChaosLegionKick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRoyalArmyKick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRoyalArmyKick_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If (InStrB(UserName, "\") <> 0) Then
108             UserName = Replace(UserName, "\", "")

            End If

110         If (InStrB(UserName, "/") <> 0) Then
112             UserName = Replace(UserName, "/", "")

            End If

114         tUser = NameIndex(UserName)

116         Call LogGM(.Name, "ECHÓ DE LA REAL A: " & UserName)

118         If tUser > 0 Then
120             Call ExpulsarFaccionReal(tUser, True)
122             UserList(tUser).faccion.Reenlistadas = 200
124             Call WriteConsoleMsg(UserIndex, UserName & " expulsado de las fuerzas reales y prohibida la reenlistada.", FontTypeNames.FONTTYPE_INFO)
126             WriteMensajes UserIndex, e_Mensajes.Mensaje_182
                'Call Flushbuffer(tUser)
            Else

128             If FileExist(CharPath & UserName & ".chr") Then
130                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "EjercitoReal", 0)
132                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "Reenlistadas", 200)
134                 Call WriteVar(CharPath & UserName & ".chr", "FACCIONES", "Extra", "Expulsado por " & .Name)
136                 Call WriteConsoleMsg(UserIndex, UserName & " expulsado de las fuerzas reales y prohibida la reenlistada.", FontTypeNames.FONTTYPE_INFO)
                Else
138                 Call WriteMensajes(UserIndex, Mensaje_50)

                End If

            End If

        End If

    End With

    Exit Sub
HandleRoyalArmyKick_Err:
140 Call LogError("TDSLegacy.Protocol.HandleRoyalArmyKick en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleForceMIDIAll(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleForceMIDIAll_Err

100 With UserList(UserIndex)

        Dim midiID As Integer

102     midiID = Message.ReadInt()

104     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

106     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(.Name & " broadcast música: " & midiID, FontTypeNames.FONTTYPE_SERVER))

108     Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayMidi(midiID))

    End With

    Exit Sub
HandleForceMIDIAll_Err:
110 Call LogError("TDSLegacy.Protocol.HandleForceMIDIAll en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleForceWAVEAll(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleForceWAVEAll_Err

100 With UserList(UserIndex)

        Dim waveID As Integer

102     waveID = Message.ReadInt()

104     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

106     Call SendData(SendTarget.ToAll, 0, PrepareMessagePlayWave(waveID, NO_3D_SOUND, NO_3D_SOUND))

    End With

    Exit Sub
HandleForceWAVEAll_Err:
108 Call LogError("TDSLegacy.Protocol.HandleForceWAVEAll en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRemovePunishment(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleRemovePunishment_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim punishmentID As Byte
        Dim i As Long
        Dim tIndex As Integer
        Dim NewText As String
        Dim bBorrarPena As Boolean

102     UserName = Message.ReadString16
104     punishmentID = Message.ReadInt8
106     NewText = Message.ReadString16

        bBorrarPena = (Len(NewText) > 0)
        NewText = Trim$(Replace$(NewText, vbCrLf, vbNullString))
        NewText = Replace$(NewText, vbNewLine, vbNullString)

108     If Not EsAdmin(.Name) Then        ' Only Admins!
110         If LenB(UserName) = 0 Then
112             Call WriteConsoleMsg(UserIndex, "Utilice /borrarpena Nick@n@str", FontTypeNames.FONTTYPE_INFO)
            Else

114             If (InStrB(UserName, "\") <> 0) Then UserName = Replace(UserName, "\", "")
116             If (InStrB(UserName, "/") <> 0) Then UserName = Replace(UserName, "/", "")
118             If Not AsciiValidos(UserName) Then Exit Sub

120             If FileExist(CharPath & UserName & ".chr", vbNormal) Then

                    Dim totPenas As Byte
                    totPenas = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))

                    ' @@ Offline user
                    If totPenas > 0 Then
                        If bBorrarPena Then
                            Call LogGM(.Name, "Pena " & punishmentID & " ELIMINADA -" & GetVar(CharPath & UserName & ".chr", "PENAS", "P" & punishmentID) & " de " & UserName)
                            If totPenas < punishmentID Then
                                For i = punishmentID To totPenas - 1
                                    Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & i, GetVar(CharPath & UserName & ".chr", "PENAS", "P" & (i + 1)))
                                Next i
                            End If
                            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & totPenas, "")
                            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant" & (totPenas - 1), "")
                            Call WriteConsoleMsg(UserIndex, "Pena eliminada.", FontTypeNames.FONTTYPE_INFO)
                        Else
                            Call LogGM(.Name, "Pena " & punishmentID & " modificada -" & GetVar(CharPath & UserName & ".chr", "PENAS", "P" & punishmentID) & " de " & UserName & " y la cambió por: " & NewText)
                            Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & punishmentID, LCase$(.Name) & ": <" & NewText & "> " & Date & " " & Time)
                            Call WriteConsoleMsg(UserIndex, "Pena alterada.", FontTypeNames.FONTTYPE_INFO)
                        End If
                    End If

                    ' @@ Online user
                    tIndex = NameIndex(UserName)
                    If tIndex > 0 Then
                        If punishmentID > UserList(tIndex).Stats.CantPenas Then
                            Call WriteConsoleMsg(UserIndex, "Pena inexistente.")
                            Exit Sub
                        End If
                        If bBorrarPena Then
                            If punishmentID = UserList(tIndex).Stats.CantPenas Then
                                UserList(tIndex).Stats.Penas(punishmentID) = ""
                            Else
                                UserList(tIndex).Stats.Penas(punishmentID) = UserList(tIndex).Stats.Penas(UserList(tIndex).Stats.CantPenas)
                                For i = punishmentID To UserList(tIndex).Stats.CantPenas - 1
                                    UserList(tIndex).Stats.Penas(i) = UserList(tIndex).Stats.Penas(i + 1)
                                Next i
                            End If
                            UserList(tIndex).Stats.CantPenas = UserList(tIndex).Stats.CantPenas - 1
                        Else
                            UserList(tIndex).Stats.Penas(punishmentID) = NewText
                        End If
                    End If
                End If
            End If
        End If

    End With

    Exit Sub
HandleRemovePunishment_Err:
128 Call LogError("TDSLegacy.Protocol.HandleRemovePunishment en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleTileBlockedToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleTileBlockedToggle_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     Call LogGM(.Name, "/BLOQ en" & .Pos.Map & " " & .Pos.X & " " & .Pos.Y)

106     If MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = 0 Then
108         MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = 1
        Else
110         MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked = 0

        End If

        'If .flags.Privilegios = PlayerType.Admin Then
        Call Bloquear(True, .Pos.Map, .Pos.X, .Pos.Y, MapData(.Pos.Map, .Pos.X, .Pos.Y).Blocked)
        'End If

    End With

    Exit Sub
HandleTileBlockedToggle_Err:
112 Call LogError("TDSLegacy.Protocol.HandleTileBlockedToggle en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleKillNPCNoRespawn(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleKillNPCNoRespawn_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     If .flags.TargetNPC = 0 Then Exit Sub

108     Call LogGM(.Name, "/MATA " & Npclist(.flags.TargetNPC).Name & " - Pos: " & Npclist(.flags.TargetNPC).Pos.Map & "-" & Npclist(.flags.TargetNPC).Pos.X & "-" & Npclist(.flags.TargetNPC).Pos.Y)

106     Call QuitarNPC(.flags.TargetNPC)

    End With

    Exit Sub
HandleKillNPCNoRespawn_Err:
110 Call LogError("TDSLegacy.Protocol.HandleKillNPCNoRespawn en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleKillAllNearbyNPCs(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleKillAllNearbyNPCs_Err

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

        Dim X As Long

        Dim Y As Long

104     For Y = .Pos.Y - MinYBorder + 1 To .Pos.Y + MinYBorder - 1
106         For X = .Pos.X - MinXBorder + 1 To .Pos.X + MinXBorder - 1

108             If X > 0 And Y > 0 And X < 101 And Y < 101 Then
110                 If MapData(.Pos.Map, X, Y).NpcIndex > 0 Then
                        '112                     If Npclist(MapData(.Pos.map, X, Y).npcIndex).GiveEXP > 1000 Then
114                     Call QuitarNPC(MapData(.Pos.Map, X, Y).NpcIndex)
                        '                        End If
                    End If
                End If
116         Next X
118     Next Y

120     Call LogGM(.Name, "/MASSKILL")

    End With

    Exit Sub
HandleKillAllNearbyNPCs_Err:
122 Call LogError("TDSLegacy.Protocol.HandleKillAllNearbyNPCs en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleLastIP(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleLastIP_Err

100 With UserList(UserIndex)

        Dim UserName As String

        Dim lista As String

        Dim LoopC As Integer

        Dim validCheck As Boolean

102     UserName = Message.ReadString16()

104     If EsGM(UserIndex) Then

            'Handle special chars
106         If (InStrB(UserName, "\") <> 0) Then
108             UserName = Replace(UserName, "\", "")

            End If

110         If (InStrB(UserName, "\") <> 0) Then
112             UserName = Replace(UserName, "/", "")

            End If

114         If (InStrB(UserName, "+") <> 0) Then
116             UserName = Replace(UserName, "+", " ")

            End If

118         validCheck = PrivilegioNickName(UserName) <= .flags.Privilegios

120         If validCheck Then
122             Call LogGM(.Name, "/LASTIP " & UserName)

124             If FileExist(CharPath & UserName & ".chr", vbNormal) Then
126                 lista = "Las ultimas IPs con las que " & UserName & " se conectó son:"

128                 For LoopC = 1 To 5
130                     lista = lista & vbCrLf & LoopC & " - " & GetVar(CharPath & UserName & ".chr", "INIT", "LastIP" & LoopC)
132                 Next LoopC

134                 Call WriteConsoleMsg(UserIndex, lista, FontTypeNames.FONTTYPE_INFO)
                Else
136                 Call WriteMensajes(UserIndex, Mensaje_50)

                End If

            Else
138             Call WriteConsoleMsg(UserIndex, UserName & " es de mayor jerarquía que vos.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

    Exit Sub
HandleLastIP_Err:
140 Call LogError("TDSLegacy.Protocol.HandleLastIP en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub HandleChatColor(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim color As Long

102     color = RGB(Message.ReadInt8(), Message.ReadInt8(), Message.ReadInt8())

104     If .flags.Privilegios >= PlayerType.Dios Or .flags.Privilegios = PlayerType.RoleMaster Then
106         .flags.ChatColor = color

        End If

    End With

End Sub

Public Sub HandleIgnored(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If EsGM(UserIndex) Then
104         .flags.AdminPerseguible = Not .flags.AdminPerseguible

        End If

    End With

End Sub

Public Sub HandleReloadObjects(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub
104     WriteMensajes UserIndex, e_Mensajes.Mensaje_339

106     Call LogGM(.Name, "/RELOADOBJS")

108     Call LoadOBJData

    End With

End Sub

Public Sub HandleReloadSpells(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     WriteMensajes UserIndex, e_Mensajes.Mensaje_338

106     Call LogGM(.Name, "/RELOADSPELLS")

108     Call CargarHechizos

    End With

End Sub

Public Sub HandleReloadServerIni(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     WriteMensajes UserIndex, e_Mensajes.Mensaje_338

106     Call LogGM(.Name, .Name & " ha recargado los INITs.")

108     Call LoadSini

    End With

End Sub

Public Sub HandleReloadNPCs(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     Call LogGM(.Name, .Name & " ha recargado los NPCs.")

106     Call CargaNpcsDat

108     Call loadNPCS

110     WriteMensajes UserIndex, e_Mensajes.Mensaje_338

    End With

End Sub

Public Sub HandleKickAllChars(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     Call LogGM(.Name, .Name & " ha echado a todos los personajes.")

106     Call EcharPjsNoPrivilegiados

    End With

End Sub

Public Sub HandleShowServerForm(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Dios Then Exit Sub
104     Call LogGM(.Name, .Name & " ha solicitado mostrar el formulario del server.")
106     Call frmMain.mnuMostrar_Click

    End With

End Sub

Public Sub HandleCleanSOS(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub
104     Call LogGM(.Name, .Name & " ha borrado los SOS.")
106     Call Ayuda.Reset

    End With

End Sub

Public Sub HandleSaveChars(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Dios Then Exit Sub
104     Call LogGM(.Name, .Name & " ha guardado todos los chars.")
106     Call GuardarUsuarios
        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " usó /grabar", FontTypeNames.FONTTYPE_SERVER))

    End With

End Sub

Public Sub HandleChangeMapInfoBackup(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim doTheBackUp As Boolean

102     doTheBackUp = Message.ReadBool()

104     If Not .flags.Privilegios >= PlayerType.Dios Then Exit Sub

106     Call LogGM(.Name, .Name & " ha cambiado la información sobre el BackUp.")

        'Change the boolean to byte in a fast way
108     If doTheBackUp Then
110         MapInfo(.Pos.Map).backup = 1
        Else
112         MapInfo(.Pos.Map).backup = 0

        End If

        'Change the boolean to string in a fast way
114     Call WriteVar(App.path & MapPath & "mapa" & .Pos.Map & ".dat", "Mapa" & .Pos.Map, "backup", MapInfo(.Pos.Map).backup)

116     Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " Backup: " & MapInfo(.Pos.Map).backup, FontTypeNames.FONTTYPE_INFO)
        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " realizó cambios en el mapa " & .Pos.Map, FontTypeNames.FONTTYPE_SERVER))

    End With

End Sub

Public Sub HandleChangeMapInfoPK(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim isMapPk As Boolean

102     isMapPk = Message.ReadBool()

104     If Not .flags.Privilegios >= PlayerType.Dios Then Exit Sub

106     Call LogGM(.Name, .Name & " - Mapa: " & .Pos.Map & " " & IIf(isMapPk, "INSEGURO", "SEGURO"))

108     MapInfo(.Pos.Map).pk = isMapPk

        'Change the boolean to string in a fast way
110     Call WriteVar(App.path & MapPath & "mapa" & .Pos.Map & ".dat", "Mapa" & .Pos.Map, "Pk", IIf(isMapPk, "1", "0"))

112     Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " PK: " & MapInfo(.Pos.Map).pk, FontTypeNames.FONTTYPE_INFO)
        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " realizó cambios en el mapa " & .Pos.Map, FontTypeNames.FONTTYPE_SERVER))

    End With

End Sub

''
' Handle the "ChangeMapInfoRestricted" message
'
' @param userIndex The index of the user sending the message

Public Sub HandleChangeMapInfoRestricted(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim tStr As String

100 With UserList(UserIndex)

102     tStr = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If tStr = "NEWBIE" Or tStr = "NO" Or tStr = "ARMADA" Or tStr = "CAOS" Or tStr = "FACCION" Or tStr = "VEINTE" Or tStr = "QUINCE" Or tStr = "VEINTICINCO" Or tStr = "CUARENTA" Then
108             Call LogGM(.Name, .Name & " ha cambiado la información sobre si es restringido el mapa.")
110             MapInfo(UserList(UserIndex).Pos.Map).Restringir = tStr
112             Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "Restringir", tStr)
114             Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " Restringido: " & MapInfo(.Pos.Map).Restringir, FontTypeNames.FONTTYPE_INFO)
            Else
116             Call WriteConsoleMsg(UserIndex, "Opciones para restringir: 'NEWBIE', 'NO', 'ARMADA', 'CAOS', 'FACCION'", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

End Sub

Public Sub HandleChangeMapInfoNoMagic(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim nomagic As Boolean

100 With UserList(UserIndex)

102     nomagic = Message.ReadBool

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, .Name & " ha cambiado la información sobre si está permitido usar la magia el mapa.")
108         MapInfo(UserList(UserIndex).Pos.Map).MagiaSinEfecto = nomagic
110         Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "MagiaSinEfecto", nomagic)
112         Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " MagiaSinEfecto: " & MapInfo(.Pos.Map).MagiaSinEfecto, FontTypeNames.FONTTYPE_INFO)

        End If

    End With

End Sub

Public Sub HandleChangeMapInfoNoInvi(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim noinvi As Boolean

100 With UserList(UserIndex)

102     noinvi = Message.ReadBool()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, .Name & " ha cambiado la información sobre si está permitido usar la invisibilidad en el mapa.")
108         MapInfo(UserList(UserIndex).Pos.Map).InviSinEfecto = noinvi
110         Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "InviSinEfecto", noinvi)
112         Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " InviSinEfecto: " & MapInfo(.Pos.Map).InviSinEfecto, FontTypeNames.FONTTYPE_INFO)

        End If

    End With

End Sub

Public Sub HandleChangeMapInfoNoResu(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim noresu As Boolean

100 With UserList(UserIndex)

102     noresu = Message.ReadBool()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, .Name & " ha cambiado la información sobre si está permitido usar el resucitar en el mapa.")
108         MapInfo(UserList(UserIndex).Pos.Map).ResuSinEfecto = noresu
110         Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "ResuSinEfecto", noresu)
112         Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " ResuSinEfecto: " & MapInfo(.Pos.Map).ResuSinEfecto, FontTypeNames.FONTTYPE_INFO)

        End If

    End With

End Sub

Public Sub HandleChangeMapInfoNoInvocar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim noinvocar As Boolean

100 With UserList(UserIndex)

102     noinvocar = Message.ReadBool()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, .Name & " ha cambiado la información sobre si está permitido usar la invocación de NPCS en el mapa.")
108         MapInfo(UserList(UserIndex).Pos.Map).InvocarSinEfecto = noinvocar
110         Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "InvocarSinEfecto", noinvocar)
112         Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " InvocarSinEfecto: " & MapInfo(.Pos.Map).InvocarSinEfecto, FontTypeNames.FONTTYPE_INFO)
        End If

    End With

End Sub

Public Sub HandleChangeMapInfoLand(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim tStr As String

100 With UserList(UserIndex)

102     tStr = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If tStr = "BOSQUE" Or tStr = "NIEVE" Or tStr = "DESIERTO" Or tStr = "CIUDAD" Or tStr = "CAMPO" Or tStr = "DUNGEON" Or tStr = "RETOS" Then
108             Call LogGM(.Name, .Name & " ha cambiado la información del terreno del mapa.")
110             MapInfo(UserList(UserIndex).Pos.Map).Terreno = tStr
112             Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "Terreno", tStr)
114             Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " Terreno: " & MapInfo(.Pos.Map).Terreno, FontTypeNames.FONTTYPE_INFO)
            Else
116             Call WriteConsoleMsg(UserIndex, "Opciones para terreno: 'BOSQUE', 'NIEVE', 'DESIERTO', 'CIUDAD', 'CAMPO', 'DUNGEON'", FontTypeNames.FONTTYPE_INFO)
118             Call WriteConsoleMsg(UserIndex, "Igualmente, el único útil es 'NIEVE' ya que al ingresarlo, la gente muere de frío en el mapa.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

End Sub

Public Sub HandleChangeMapInfoZone(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim tStr As String

100 With UserList(UserIndex)

102     tStr = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If tStr = "BOSQUE" Or tStr = "NIEVE" Or tStr = "DESIERTO" Or tStr = "CIUDAD" Or tStr = "CAMPO" Or tStr = "DUNGEON" Or tStr = "EVENTOS" Then
108             Call LogGM(.Name, .Name & " ha cambiado la información de la zona del mapa.")
110             MapInfo(UserList(UserIndex).Pos.Map).Zona = tStr
112             Call WriteVar(App.path & MapPath & "mapa" & UserList(UserIndex).Pos.Map & ".dat", "Mapa" & UserList(UserIndex).Pos.Map, "Zona", tStr)
114             Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " Zona: " & MapInfo(.Pos.Map).Zona, FontTypeNames.FONTTYPE_INFO)
            Else
116             Call WriteConsoleMsg(UserIndex, "Opciones para terreno: 'BOSQUE', 'NIEVE', 'DESIERTO', 'CIUDAD', 'CAMPO', 'DUNGEON'", FontTypeNames.FONTTYPE_INFO)
118             Call WriteConsoleMsg(UserIndex, "Igualmente, el único útil es 'DUNGEON' ya que al ingresarlo, NO se sentirá el efecto de la lluvia en este mapa.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With

End Sub

Public Sub HandleSaveMap(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

104     Call LogGM(.Name, .Name & " REALIZÓ UN GUARDADO DE MAPA EN EL MAPA: " & CStr(.Pos.Map))

106     Call GrabarMapa(.Pos.Map, App.path & "\WorldBackUp\Mapa" & .Pos.Map)

108     Call WriteConsoleMsg(UserIndex, "Mapa Guardado.", FontTypeNames.FONTTYPE_INFO)

        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " guardó el mapa " & .Pos.Map, FontTypeNames.FONTTYPE_SERVER))

    End With

End Sub

Public Sub HandleShowGuildMessages(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim guild As String

102     guild = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call modGuilds.GMEscuchaClan(UserIndex, guild)

        End If

    End With

End Sub

Public Sub HandleDoBackUp(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Dios Then Exit Sub

104     Call LogGM(.Name, .Name & " ha hecho un backup.")

106     Call ES.DoBackUp

    End With

End Sub

Public Sub HandleToggleCentinelActivated(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Dios Then Exit Sub

104     centinelaActivado = Not centinelaActivado

106     With Centinela
108         .RevisandoUserIndex = 0
110         .clave = ""
112         .TiempoRestante = 0

        End With

114     If CentinelaNPCIndex Then
116         Call QuitarNPC(CentinelaNPCIndex)
118         CentinelaNPCIndex = 0

        End If

120     If centinelaActivado Then
122         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("El centinela ha sido activado.", FontTypeNames.FONTTYPE_SERVER))
        Else
124         Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("El centinela ha sido desactivado.", FontTypeNames.FONTTYPE_SERVER))

        End If

    End With

End Sub

Public Sub HandleAlterName(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        'Reads the userName and newUser Packets
        Dim UserName As String

        Dim NewName As String

        Dim changeNameUI As Integer

        Dim GuildIndex As Integer

102     UserName = Message.ReadString16()
104     NewName = Message.ReadString16()

106     If .flags.Privilegios >= PlayerType.Admin Then
108         If LenB(UserName) = 0 Or LenB(NewName) = 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_85
            Else
112             changeNameUI = NameIndex(UserName)

114             If changeNameUI > 0 Then
116                 Call WriteConsoleMsg(UserIndex, "El Pj está online, debe salir para hacer el cambio.", FontTypeNames.FONTTYPE_WARNING)
                Else

118                 If Not FileExist(CharPath & UserName & ".chr") Then
120                     Call WriteMensajes(UserIndex, Mensaje_50)
                    Else
122                     GuildIndex = val(GetVar(CharPath & UserName & ".chr", "GUILD", "GUILDINDEX"))

124                     If GuildIndex > 0 Then
126                         Call WriteConsoleMsg(UserIndex, "El pj " & UserName & " pertenece a un clan, debe salir del mismo con /salirclan para ser transferido.", FontTypeNames.FONTTYPE_INFO)
                        Else

128                         If Not FileExist(CharPath & NewName & ".chr") Then
130                             Call FileCopy(CharPath & UserName & ".chr", CharPath & UCase$(NewName) & ".chr")

132                             WriteMensajes UserIndex, e_Mensajes.Mensaje_87

134                             Call WriteVar(CharPath & UserName & ".chr", "FLAGS", "Ban", "1")

                                Dim CantPenas As Integer

136                             CantPenas = val(GetVar(CharPath & UserName & ".chr", "PENAS", "Cant"))

138                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "Cant", CStr(CantPenas + 1))

140                             Call WriteVar(CharPath & UserName & ".chr", "PENAS", "P" & CStr(CantPenas + 1), LCase$(.Name) & ": BAN POR Cambio de nick a " & UCase$(NewName) & " " & Date & " " & Time)

142                             Call LogGM(.Name, "Ha cambiado de nombre al usuario " & UserName & ". Ahora se llama " & NewName)
                            Else
144                             WriteMensajes UserIndex, e_Mensajes.Mensaje_88

                            End If

                        End If

                    End If

                End If

            End If

        End If

    End With

End Sub

Public Sub HandleAlterMail(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim UserName As String

        Dim newMail As String

102     UserName = Message.ReadString16()
104     newMail = Message.ReadString16()

106     If .flags.Privilegios >= PlayerType.Admin Then
108         If LenB(UserName) = 0 Or LenB(newMail) = 0 Then
110             WriteMensajes UserIndex, e_Mensajes.Mensaje_83
            Else

112             If Not FileExist(CharPath & UserName & ".chr") Then
114                 Call WriteConsoleMsg(UserIndex, "No existe el charfile " & UserName & ".chr", FontTypeNames.FONTTYPE_INFO)
                Else
116                 Call WriteVar(CharPath & UserName & ".chr", "CONTACTO", "Email", newMail)
118                 Call WriteConsoleMsg(UserIndex, "Email de " & UserName & " cambiado a: " & newMail, FontTypeNames.FONTTYPE_INFO)

                End If

120             Call LogGM(.Name, "Le ha cambiado el mail a " & UserName)

            End If

        End If

    End With

End Sub

Public Sub HandleAlterPassword(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim UserName As String

        Dim copyFrom As String

        Dim Password As String

102     UserName = Replace(Message.ReadString16(), "+", " ")
104     copyFrom = Replace(Message.ReadString16(), "+", " ")

106     If .flags.Privilegios >= PlayerType.Admin Then
108         Call LogGM(.Name, "Ha alterado la contraseña de " & UserName)

110         If LenB(UserName) = 0 Or LenB(copyFrom) = 0 Then

112             WriteMensajes UserIndex, e_Mensajes.Mensaje_81
            Else

114             If Not FileExist(CharPath & UserName & ".chr") Or Not FileExist(CharPath & copyFrom & ".chr") Then
116                 Call WriteConsoleMsg(UserIndex, "Alguno de los PJs no existe " & UserName & "@" & copyFrom, FontTypeNames.FONTTYPE_INFO)
                Else
118                 Password = GetVar(CharPath & copyFrom & ".chr", "INIT", "Password")
120                 Call WriteVar(CharPath & UserName & ".chr", "INIT", "Password", Password)

122                 Call WriteConsoleMsg(UserIndex, "Password de " & UserName & " ha cambiado por la de " & copyFrom, FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End If

    End With

End Sub

Public Sub HandleCreateNPC(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim NpcIndex As Integer

102     NpcIndex = Message.ReadInt()

104     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

106     NpcIndex = SpawnNpc(NpcIndex, .Pos, True, False)

108     If NpcIndex <> 0 Then
110         Call LogGM(.Name, "/CC " & Npclist(NpcIndex).Name & " en mapa " & .Pos.Map)

        End If

    End With

End Sub

Public Sub HandleCreateNPCWithRespawn(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim NpcIndex As Integer

102     NpcIndex = Message.ReadInt()

104     If .flags.Privilegios <= PlayerType.SemiDios Then Exit Sub

106     NpcIndex = SpawnNpc(NpcIndex, .Pos, True, True)

108     If NpcIndex <> 0 Then
110         Call LogGM(.Name, "Sumoneó con respawn " & Npclist(NpcIndex).Name & " en mapa " & .Pos.Map)

        End If

    End With

End Sub

Public Sub HandleServerOpenToUsersToggle(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

102     If .flags.Privilegios <= PlayerType.Dios Then Exit Sub

104     If ServerSoloGMs > 0 Then
106         Call WriteConsoleMsg(UserIndex, "ESTADO - HABILITADO PARA TODOS.", FontTypeNames.FONTTYPE_INFO)
108         ServerSoloGMs = 0
        Else
110         Call WriteConsoleMsg(UserIndex, "ESTADO - RESTRINGIDO A GAME MASTERS.", FontTypeNames.FONTTYPE_INFO)
112         ServerSoloGMs = 1

        End If

    End With

End Sub

Public Sub HandleTurnCriminal(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, "/CONDEN " & UserName)

108         tUser = NameIndex(UserName)

110         If tUser > 0 Then Call VolverCriminal(tUser)

        End If

    End With

End Sub

Public Sub HandleResetFactions(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim Char As String

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, "/RAJAR " & UserName)

108         tUser = NameIndex(UserName)

110         If tUser > 0 Then
112             Call ResetFacciones(tUser)
            Else
114             Char = CharPath & UserName & ".chr"

116             If FileExist(Char, vbNormal) Then
118                 Call WriteVar(Char, "FACCIONES", "EjercitoReal", 0)
120                 Call WriteVar(Char, "FACCIONES", "CiudMatados", 0)
122                 Call WriteVar(Char, "FACCIONES", "CrimMatados", 0)
124                 Call WriteVar(Char, "FACCIONES", "EjercitoCaos", 0)
126                 Call WriteVar(Char, "FACCIONES", "FechaIngreso", "No ingresó a ninguna Facción")
128                 Call WriteVar(Char, "FACCIONES", "rArCaos", 0)
130                 Call WriteVar(Char, "FACCIONES", "rArReal", 0)
132                 Call WriteVar(Char, "FACCIONES", "rExCaos", 0)
134                 Call WriteVar(Char, "FACCIONES", "rExReal", 0)
136                 Call WriteVar(Char, "FACCIONES", "recCaos", 0)
138                 Call WriteVar(Char, "FACCIONES", "recReal", 0)
140                 Call WriteVar(Char, "FACCIONES", "Reenlistadas", 0)
142                 Call WriteVar(Char, "FACCIONES", "NivelIngreso", 0)
144                 Call WriteVar(Char, "FACCIONES", "MatadosIngreso", 0)
146                 Call WriteVar(Char, "FACCIONES", "NextRecompensa", 0)
                Else
148                 Call WriteConsoleMsg(UserIndex, "El personaje " & UserName & " no existe.", FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End If

    End With

End Sub

Public Sub HandleRemoveCharFromGuild(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim UserName As String

        Dim GuildIndex As Integer

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, "/RAJARCLAN " & UserName)

108         GuildIndex = modGuilds.m_EcharMiembroDeClan(UserIndex, UserName)

110         If GuildIndex = 0 Then
112             Call WriteConsoleMsg(UserIndex, "No pertenece a ningún clan o es fundador.", FontTypeNames.FONTTYPE_INFO)
            Else
114             Call WriteConsoleMsg(UserIndex, "Expulsado.", FontTypeNames.FONTTYPE_INFO)
116             Call SendData(SendTarget.ToGuildMembers, GuildIndex, PrepareMessageConsoleMsg(UserName & " ha sido expulsado del clan por los administradores del server.", FontTypeNames.FONTTYPE_GUILD))

            End If

        End If

    End With
End Sub

Public Sub HandleRequestCharMail(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim UserName As String

        Dim mail As String

102     UserName = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         If FileExist(CharPath & UserName & ".chr") Then
108             mail = GetVar(CharPath & UserName & ".chr", "CONTACTO", "email")

110             Call WriteConsoleMsg(UserIndex, "Last email de " & UserName & ":" & mail, FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With
End Sub

Public Sub HandleSystemMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim Msg As String

102     Msg = Message.ReadString16()

104     If .flags.Privilegios >= PlayerType.Dios Then
106         Call LogGM(.Name, "Mensaje de sistema:" & Msg)

108         Call SendData(SendTarget.ToAllButIndex, UserIndex, PrepareMessageShowMessageBox(Msg))

        End If

    End With
End Sub

Public Sub HandleDisolverClan(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim NombreClan As String, LiderClan As String

102     If .GuildIndex <> 0 Then

104         NombreClan = modGuilds.GuildName(.GuildIndex)
106         LiderClan = modGuilds.GuildLeader(.GuildIndex)

108         If UCase$(LiderClan) <> UCase$(.Name) Then Exit Sub

110         Call modGuilds.m_EcharATodos(UserIndex, .GuildIndex)

112         Call modGuilds.m_SetDisuelto(UserIndex, .GuildIndex, 1)

114         Call WriteConsoleMsg(UserIndex, "Has disuelto el clan. Para reanudarlo tipea /REANUDARCLAN " & Chr(34) & NombreClan & Chr(34), FontTypeNames.FONTTYPE_INFO)

116         .flags.ExClan = .GuildIndex
118         .GuildIndex = 0

120         Call WriteVar(CharPath & .Name & ".chr", "GUILD", "GUILDINDEX", 0)

122         Call RefreshCharStatus(UserIndex)
            'Call WriteConsoleMsg(UserIndex, "Vuelve a ingresar al juego para ver los cambios.")
            'FlushBuffer UserIndex

        Else
124         WriteMensajes UserIndex, e_Mensajes.Mensaje_267

        End If

    End With
End Sub

Public Sub HandleReanudarClan(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
'@@TDS Logic:
'   /REANUDARCLAN Nombre del clan que se desea reanudar. En caso de que se omita el nombre del clan se reanudará el ultimo que disolvió el usuario
'       Se explicitaron dos comportamiento al momento de disolver y reanudar un clan:
'       Cuando se disuelve un clan de manera manual, la fecha en la cual el clan entro en infracción se elimina
'       (anteriormente si se disolvía un clan que se encontraba en infracción, menos de 3 integrantes, y se volvía a reanudar, rápidamente debía conseguir 3 integrantes)
'       Cuando se reanuda un clan la fecha de eleccion nueva es el día actual más los días que faltaban para la eleccion antes de que se disolviese

100 With UserList(UserIndex)

        Dim Lider As String

        Dim ClanName As String

102     ClanName = Message.ReadString16

104     If .GuildIndex <> 0 Then Exit Sub        ' YA ESTAS EN UN CLAN
106     If .flags.ExClan = 0 Then Exit Sub        'NO DISOLVIO
108     If .flags.Comerciando Then Exit Sub        'COMERCIANDO
110     If .flags.Muerto Then Exit Sub        'MUERTO
112     If .flags.Paralizado Then Exit Sub        'PARA

114     If Len(ClanName) > 0 Then
116         Lider = modGuilds.GuildLeader(.GuildIndex)

            Dim i As Long, found As Boolean

118         For i = 1 To CANTIDADDECLANES

120             If LCase$(guilds(i).GuildName) = LCase$(Trim$(ClanName)) Then
122                 found = True
                    Exit For

                End If

124         Next i

126         If Not found Then
128             Call WriteConsoleMsg(UserIndex, "El clan " & Chr(34) & ClanName & Chr(34) & " no existe.")
                Exit Sub

            End If

130         .GuildIndex = i
        Else
132         .GuildIndex = .flags.ExClan

        End If

        Dim fecha_disuelto As String

134     fecha_disuelto = guilds(.GuildIndex).GetDisueltoDate

136     If DateDiff("s", Now, fecha_disuelto) > 0 Then

138         Call WriteConsoleMsg(UserIndex, "Podrás reanudar tu clan el día: " & vbNewLine & fecha_disuelto)
140         .GuildIndex = 0
            Exit Sub

        End If

142     .flags.ExClan = 0

144     Call modGuilds.m_SetDisuelto(UserIndex, .GuildIndex, 0)

146     Call WriteVar(CharPath & .Name & ".chr", "GUILD", "GUILDINDEX", .GuildIndex)

148     If .faccion.ArmadaReal > 0 Then
150         Call guilds(.GuildIndex).CambiarAlineacion(ALINEACION_ARMADA)
152     ElseIf .faccion.FuerzasCaos > 0 Then
154         Call guilds(.GuildIndex).CambiarAlineacion(ALINEACION_LEGION)
        Else
156         Call guilds(.GuildIndex).CambiarAlineacion(ALINEACION_NEUTRO)

        End If

158     Call RefreshCharStatus(UserIndex)
160     Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Se ha reanudado el clan " & modGuilds.GuildName(.GuildIndex) & ".", FontTypeNames.FONTTYPE_GUILD))

    End With
End Sub

Private Sub handleRetirarTodo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Dim Amount As Long

100 With UserList(UserIndex)

102     If .flags.Muerto = 1 Then
            'Call writeMensajes(UserIndex, e_mensajes.Mensaje_3)
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

110     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then Exit Sub

112     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 10 Then
114         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

116     Amount = .Stats.Banco

118     If Amount > 0 Then
120         .Stats.Banco = 0
122         .Stats.GLD = .Stats.GLD + Amount
124         Call WriteChatOverHead(UserIndex, "Tenés " & .Stats.Banco & " monedas de oro en tu cuenta.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)
        Else
126         Call WriteChatOverHead(UserIndex, "No tienes oro en el banco.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

        End If

128     Call WriteUpdateGold(UserIndex)

    End With
End Sub

Private Sub handleDepositarTodo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

102     If .flags.Muerto = 1 Then
104         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub

        End If

106     If .flags.TargetNPC = 0 Then
108         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_4)
            Exit Sub

        End If

110     If Npclist(.flags.TargetNPC).NPCtype <> eNPCType.Banquero Then Exit Sub

112     If distancia(.Pos, Npclist(.flags.TargetNPC).Pos) > 10 Then
114         Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_5)
            Exit Sub

        End If

116     If .Stats.GLD > 0 Then
118         .Stats.Banco = .Stats.Banco + .Stats.GLD
120         .Stats.GLD = 0
122         Call WriteChatOverHead(UserIndex, "Tenés " & .Stats.Banco & " monedas de oro en tu cuenta.", Npclist(.flags.TargetNPC).Char.CharIndex, vbWhite)

        End If

124     Call WriteUpdateGold(UserIndex)

    End With

End Sub

Public Sub HandleConteo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim num As Byte

102     num = Message.ReadInt8

104     If EsGM(UserIndex) Then
106         CR = num + 1

        End If

    End With

End Sub

Private Sub HandleCheater(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCheater_Err

100 With UserList(UserIndex)
102     Call WriteCloseClient(UserIndex)
104     Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("server> " & .Name & " ha sido echado por el server por posible uso de programas externos.", FontTypeNames.FONTTYPE_SERVER))

    End With

    Exit Sub
HandleCheater_Err:
106 Call LogError("TDSLegacy.Protocol.HandleCheater en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub HandleDragInventory(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Dim ObjSlot1 As Byte

    Dim ObjSlot2 As Byte

    Dim tmpUserObj As UserOBJ

100 With UserList(UserIndex)

102     ObjSlot1 = Message.ReadInt8
104     ObjSlot2 = Message.ReadInt8

106     If ObjSlot2 > .CurrentInventorySlots Or ObjSlot1 > .CurrentInventorySlots Or ObjSlot1 <= 0 Or ObjSlot2 <= 0 Then
            Exit Sub
        End If

        If .flags.Comerciando Then
            Exit Sub
        End If

        ' ++ Fix logica mistica xd
        If .flags.MenuCliente <> eVentanas.vInventario Then
            'uso de editor de paquetes. (Intento cambiar de slot un item estando en hechizos)
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 7", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " intentó cambiar de slot un item estando en la ventana de hechizos.")
            'Exit Sub
        End If

108     If UserList(UserIndex).flags.Comerciando Then Exit Sub

        ''If UserList(UserIndex).flags.Comerciando Then Exit Sub
        'Cambiamos si alguno es un anillo
110     If .Invent.AnilloEqpSlot = ObjSlot1 Then
112         .Invent.AnilloEqpSlot = ObjSlot2
114     ElseIf .Invent.AnilloEqpSlot = ObjSlot2 Then
116         .Invent.AnilloEqpSlot = ObjSlot1

        End If

118     If .Invent.AnilloEqpSlot2 = ObjSlot1 Then
120         .Invent.AnilloEqpSlot2 = ObjSlot2
122     ElseIf .Invent.AnilloEqpSlot2 = ObjSlot2 Then
124         .Invent.AnilloEqpSlot2 = ObjSlot1

        End If

        'Cambiamos si alguno es un armor
126     If .Invent.ArmourEqpSlot = ObjSlot1 Then
128         .Invent.ArmourEqpSlot = ObjSlot2
130     ElseIf .Invent.ArmourEqpSlot = ObjSlot2 Then
132         .Invent.ArmourEqpSlot = ObjSlot1

        End If

        'Cambiamos si alguno es un barco
134     If .Invent.BarcoSlot = ObjSlot1 Then
136         .Invent.BarcoSlot = ObjSlot2
138     ElseIf .Invent.BarcoSlot = ObjSlot2 Then
140         .Invent.BarcoSlot = ObjSlot1
        End If

        'Cambiamos si alguno es un casco
142     If .Invent.CascoEqpSlot = ObjSlot1 Then
144         .Invent.CascoEqpSlot = ObjSlot2
146     ElseIf .Invent.CascoEqpSlot = ObjSlot2 Then
148         .Invent.CascoEqpSlot = ObjSlot1

        End If

        'Cambiamos si alguno es un escudo
150     If .Invent.EscudoEqpSlot = ObjSlot1 Then
152         .Invent.EscudoEqpSlot = ObjSlot2
154     ElseIf .Invent.EscudoEqpSlot = ObjSlot2 Then
156         .Invent.EscudoEqpSlot = ObjSlot1

        End If

        'Cambiamos si alguno es munición
158     If .Invent.MunicionEqpSlot = ObjSlot1 Then
160         .Invent.MunicionEqpSlot = ObjSlot2
162     ElseIf .Invent.MunicionEqpSlot = ObjSlot2 Then
164         .Invent.MunicionEqpSlot = ObjSlot1

        End If

        'Cambiamos si alguno es un arma
166     If .Invent.WeaponEqpSlot = ObjSlot1 Then
168         .Invent.WeaponEqpSlot = ObjSlot2
170     ElseIf .Invent.WeaponEqpSlot = ObjSlot2 Then
172         .Invent.WeaponEqpSlot = ObjSlot1

        End If

        'Hacemos el intercambio propiamente dicho
174     tmpUserObj = .Invent.Object(ObjSlot1)
176     .Invent.Object(ObjSlot1) = .Invent.Object(ObjSlot2)
178     .Invent.Object(ObjSlot2) = tmpUserObj

        'Actualizamos los 2 slots que cambiamos solamente
180     Call UpdateUserInv(False, UserIndex, ObjSlot1)
182     Call UpdateUserInv(False, UserIndex, ObjSlot2)

184     If UserList(UserIndex).flags.Comerciando = True Then
186         Call WriteTradeOK(UserIndex)
188         Call UpdateVentanaBanco(UserIndex)

        End If

    End With
End Sub

Public Sub HandleDragToPos(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim X As Integer

    Dim Y As Integer

    Dim Slot As Integer

    Dim Amount As Integer

100 X = Message.ReadInt8()
102 Y = Message.ReadInt8()
104 Slot = Message.ReadInt8()
106 Amount = Message.ReadInt()

108 If Slot <= 0 Then Exit Sub
    If Slot > MAX_INVENTORY_SLOTS Then Exit Sub

110 If UserList(UserIndex).Invent.Object(Slot).ObjIndex <= 0 Then Exit Sub

112 If UserList(UserIndex).Invent.Object(Slot).Amount < Amount Then
114     Amount = UserList(UserIndex).Invent.Object(Slot).Amount
    End If

116 If Amount <= 0 Then
118     Call WriteMensajes(UserIndex, Mensaje_386)
        Exit Sub
    End If

    If UserList(UserIndex).mReto.Reto_Index > 0 Or UserList(UserIndex).sReto.Reto_Index > 0 Then
        Call WriteConsoleMsg(UserIndex, "No puedes tirar objetos estando en retos.")
        Exit Sub
    End If

    If UserList(UserIndex).mReto.Reto_Index > 0 Or UserList(UserIndex).sReto.Reto_Index > 0 Then
        Call WriteConsoleMsg(UserIndex, "No puedes tirar objetos estando en retos.")
        Exit Sub
    End If


    ' ++ Ahora chupate unas pijas con el auto pots jejeje (Shakeño se la come doblada)
    If UserList(UserIndex).flags.MenuCliente <> eVentanas.vInventario Then
        'uso de editor de paquetes. (Intentó arrojar items en la ventana de hechizos)
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & UserList(UserIndex).Name & " - Alerta code: 8", FontTypeNames.FONTTYPE_SERVER))
        Call LogAntiCheat(UserList(UserIndex).Name & " intentó arrojar items usando Drag and Drop en la ventana de hechizos.")
        'Exit Sub
    End If

    ' @@ Fix del slot
    If (Slot < 1) Or (Slot > UserList(UserIndex).CurrentInventorySlots) Then
        'está intentado tirar un item
        Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Anti Cheat > El usuario " & UserList(UserIndex).Name & " Alerta code: 9 (Slot: " & Slot & ").", FontTypeNames.FONTTYPE_SERVER))
        Call LogAntiCheat(UserList(UserIndex).Name & " intentó dupear items usando Drag and Drop (Slot: " & Slot & ").")
        Exit Sub
    End If

    Dim OtroUserIndex As Integer

120 If UserList(UserIndex).flags.Comerciando Then
122     OtroUserIndex = UserList(UserIndex).ComUsu.DestUsu

124     If OtroUserIndex > 0 And OtroUserIndex <= maxUsers Then
126         Call WriteMensajes(UserIndex, Mensaje_387)
128         WriteMensajes OtroUserIndex, e_Mensajes.Mensaje_129

130         Call LimpiarComercioSeguro(UserIndex)

        End If

    End If

132 With MapData(UserList(UserIndex).Pos.Map, X, Y)


134     If .NpcIndex <> 0 Then
136         mod_DragDrop.DragToNPC UserIndex, .NpcIndex, Slot, Amount
138     ElseIf .UserIndex <> 0 Then

140         If UserList(.UserIndex).flags.BlockDragItems = False Then
142             Call WriteMensajes(UserIndex, Mensaje_432)
                Exit Sub
            End If


            If (UserList(.UserIndex).flags.Muerto <> 0) Then
                Call WriteConsoleMsg(.UserIndex, "Está muerto.", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If

144         mod_DragDrop.DragToUser UserIndex, .UserIndex, Slot, Amount
        Else
146         mod_DragDrop.DragToPos UserIndex, X, Y, Slot, Amount

        End If

    End With

End Sub

Private Sub HandlePartyLeave(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePartyLeave_Err

100 Call mod_Party.ExitParty(UserIndex)

    Exit Sub
HandlePartyLeave_Err:
102 Call LogError("TDSLegacy.Protocol.HandlePartyLeave en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePartyCreate(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePartyCreate_Err

100 Call mod_Party.CreateParty(UserIndex)

    Exit Sub
HandlePartyCreate_Err:
102 Call LogError("TDSLegacy.Protocol.HandlePartyCreate en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePartyJoin(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePartyJoin_Err

100 Call mod_Party.RequestPartyEntry(UserIndex)

    Exit Sub
HandlePartyJoin_Err:
102 Call LogError("TDSLegacy.Protocol.HandlePartyJoin en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleRequestPartyForm(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

102     If .flags.Muerto = 1 Then Exit Sub

104     If .PartyIndex = 0 Then
106         Call mod_Party.CreateParty(UserIndex)

        End If

108     If .PartyIndex > 0 Then
110         Call WriteSendPartyData(UserIndex)

        End If

    End With
End Sub

Private Sub HandleSetPartyPorcentajes(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Dim LoopC As Long, Porc As Integer, Porcentajes(1 To PARTY_MAXMEMBERS) As Integer

100 With UserList(UserIndex)

102     For LoopC = 1 To PARTY_MAXMEMBERS
104         Porc = Message.ReadInt8

106         If Porc > 100 Then Porc = 100
108         Porcentajes(LoopC) = Porc
110     Next LoopC

112     If .PartyIndex < 1 Then
114         Call WriteConsoleMsg(UserIndex, "No eres miembro de ninguna party", FontTypeNames.FONTTYPE_PARTY)
            Exit Sub

        End If

116     If Not Parties(.PartyIndex).EsPartyLeader(UserIndex) Then
118         Call WriteConsoleMsg(UserIndex, "No eres el lider de tu party.", FontTypeNames.FONTTYPE_PARTY)
            Exit Sub

        End If

120     If Parties(.PartyIndex).CantMembers < 2 Then
122         Call WriteConsoleMsg(UserIndex, "Estás solo en la party.", FontTypeNames.FONTTYPE_PARTY)
            Exit Sub

        End If

    End With

124 Call ValidateNewPercentages(UserIndex, Porcentajes())

End Sub

Private Sub HandlePartyKick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim UserName As String

102     UserName = Message.ReadString16

104     If UserCanExecuteCommands(UserIndex) Then

            Dim tUser As Integer

106         tUser = NameIndex(UserName)

108         If tUser > 0 Then
110             Call mod_Party.EjectParty(UserIndex, tUser)
            Else

112             If InStr(UserName, "+") Then
114                 UserName = Replace(UserName, "+", " ")

                End If

116             Call WriteConsoleMsg(UserIndex, UCase$(UserName) & " no pertenece a tu party.", FontTypeNames.FONTTYPE_INFO)

            End If

        End If

    End With
End Sub

Private Sub HandlePartySetLeader(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
100 With UserList(UserIndex)

        Dim UserName As String

102     UserName = Message.ReadString16

104     With UserList(UserIndex)

106         If UserCanExecuteCommands(UserIndex) Then

                Dim tUser As Integer

108             tUser = NameIndex(UserName)

110             If tUser > 0 Then

                    'Don't allow users to spoof online GMs
112                 If PrivilegioNickName(UserName) <= .flags.Privilegios Then
114                     If UserIndex <> tUser Then
116                         Call mod_Party.TransformInLider(UserIndex, tUser)

                        End If

                    Else
118                     Call WriteConsoleMsg(UserIndex, UCase$(UserList(tUser).Name) & " no pertenece a tu party.", FontTypeNames.FONTTYPE_INFO)

                    End If

                Else

120                 If InStr(UserName, "+") Then
122                     UserName = Replace(UserName, "+", " ")

                    End If

124                 Call WriteConsoleMsg(UserIndex, UCase$(UserName) & " no pertenece a tu party.", FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End With

    End With

    Exit Sub
HandlePartySetLeader_Err:
126 Call LogError("TDSLegacy.Protocol.HandlePartySetLeader en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandlePartyAcceptMember(ByVal Message As BinaryReader, ByVal UserIndex As Integer)



100 With UserList(UserIndex)

        Dim UserName As String

        Dim tUser As Integer

        Dim bUserVivo As Boolean

102     UserName = Message.ReadString16

104     If UserList(UserIndex).flags.Muerto Then
106         Call WriteMensajes(UserIndex, Mensaje_3)        '"¡¡Estás muerto!!"
        Else
108         bUserVivo = True

        End If

110     If mod_Party.UserCanExecuteCommands(UserIndex) And bUserVivo Then
112         tUser = NameIndex(UserName)

114         If tUser > 0 Then

                'Validate administrative ranks - don't allow users to spoof online GMs
116             If UserList(tUser).flags.Privilegios <= UserList(UserIndex).flags.Privilegios Then
118                 Call mod_Party.ApproveLoginParty(UserIndex, tUser)
                Else
120                 Call WriteMensajes(UserIndex, Mensaje_427, FontTypeNames.FONTTYPE_PARTY)        'FAKE!"No puedes incorporar a tu party a personajes de mayor jerarquía."

                End If

            Else

122             Call WriteConsoleMsg(UserIndex, UCase$(UserName) & " no ha solicitado ingresar a tu party.", FontTypeNames.FONTTYPE_PARTY)

            End If

        End If

    End With
End Sub

Private Sub HandleSendReto(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSendReto_Err

100 With UserList(UserIndex)

        Dim MyTeam As String

        Dim Enemy As String

        Dim tEnemy As String

        Dim ByDrop As Boolean

        Dim ByGold As Long

        Dim snResu As Boolean

        Dim PotionsLimit As Integer

        Dim sError As String

102     MyTeam = Message.ReadString16
104     Enemy = Message.ReadString16
106     tEnemy = Message.ReadString16

108     ByDrop = Message.ReadBool
110     ByGold = Message.ReadInt32
112     PotionsLimit = Message.ReadInt
114     snResu = Message.ReadBool

        ' 'Si mi team es igual a mi enemigo' Si mi team es igual al team enemigo ' Si enemigo es igual a enemigo team
        ' Si mi team es igual a SendIndex ' Si mi enemigo es igual a SendIndex ' Si mi enemigo team es igual a SendIndex
116     If Not (UCase$(MyTeam) = UCase$(Enemy) Or UCase$(MyTeam) = UCase$(tEnemy) Or UCase$(Enemy) = UCase$(tEnemy) Or UCase$(MyTeam) = UCase$(.Name) Or UCase$(Enemy) = UCase$(.Name) Or UCase$(tEnemy) = UCase$(.Name)) Then

            ' @@ new func que pase ArrParam o algo asi
118         If Not EsGM(UserIndex) Then
120             If EsGmChar(MyTeam) Then
                    Exit Sub
122             ElseIf EsGmChar(Enemy) Then
                    Exit Sub
124             ElseIf EsGmChar(tEnemy) Then
                    Exit Sub
                End If
            End If

            If NameIndex(MyTeam) = 0 Or NameIndex(Enemy) = 0 Or NameIndex(tEnemy) = 0 Then
                Call WriteConsoleMsg(UserIndex, "Alguno de los jugadores no está online o no se encuentra en un estado válido para retar, intente nuevamente.")
                Exit Sub
            End If

126         Call m_Retos2vs2.Set_Reto_Struct(UserIndex, MyTeam, Enemy, tEnemy, ByDrop, ByGold, PotionsLimit, snResu)

128         If m_Retos2vs2.Can_Send_Reto(UserIndex, sError) Then
130             Call m_Retos2vs2.Send_Reto(UserIndex)
            Else

132             If LenB(sError) > 0 Then
134                 Call WriteConsoleMsg(UserIndex, sError, FontTypeNames.FONTTYPE_INFO)

                End If

            End If

        End If

    End With

    Exit Sub
HandleSendReto_Err:
136 Call LogError("TDSLegacy.Protocol.HandleSendReto en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAcceptReto(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim cName As String
    Dim tUser As Integer
    Dim Es1vs1 As Boolean, Es2vs2 As Boolean

    cName = Message.ReadString16
    tUser = NameIndex(cName)

    With UserList(UserIndex)

        If tUser > 0 Then
            If tUser = .mReto.IndexSender Then
                Es1vs1 = True
            End If

            If tUser = .sReto.IndexRecieve Then
                Es2vs2 = True
            End If

            If Es1vs1 And Es2vs2 Then
                If .mReto.AcceptLimitCount > .sReto.AcceptLimitCount Then
                    Es2vs2 = False
                Else
                    Es1vs1 = False
                End If
            End If

            If Es1vs1 Then
                Call m_Retos1vs1.Can_AcceptReto1vs1(UserIndex, tUser)
            End If

            If Es2vs2 Then
                Call m_Retos2vs2.Accept_Reto(UserIndex, tUser)
            End If
        End If

    End With

End Sub

Private Sub HandleOtherSendReto(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim eName As String
    Dim gold As Long
    Dim Drop As Byte
    Dim Planted As Byte
    Dim Potions As Integer
    Dim AIM As Byte
    Dim CascoEscu As Byte
    Dim Rounds As Byte

    eName = Message.ReadString16
    gold = Message.ReadInt32
    Drop = Message.ReadInt8
    Potions = Message.ReadInt
    Planted = Message.ReadInt8
    AIM = Message.ReadInt8
    CascoEscu = Message.ReadInt8
    Rounds = 2    'Message.ReadInt8

    If Not EsGM(UserIndex) Then
        If EsGmChar(eName) Then
            ' Exit Sub
        End If
    End If

    If Potions = 1 Then
        Potions = 0
    End If

    With UserList(UserIndex)

        ' @@ No te dejamos putito
        If gold < 1 Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad» El usuario " & .Name & " está queriendo mandar retos por cantidad de monedas de oro inválidas.", FontTypeNames.FONTTYPE_SERVER))
            Exit Sub
        End If

        If Potions < 0 Or Potions > 10000 Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad» El usuario " & .Name & " está queriendo mandar retos por cantidad de pociones rojas inválidas.", FontTypeNames.FONTTYPE_SERVER))
            Exit Sub
        End If

        If Rounds < 1 Or Rounds > 5 Then
            Rounds = 2
            'Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad» El usuario " & .Name & " está queriendo mandar retos por cantidad de rounds inválida.", FontTypeNames.FONTTYPE_SERVER))
            'Exit Sub
        End If

        Dim otherIndex As Integer
        otherIndex = NameIndex(eName)

        If otherIndex > 0 Then
            If m_Retos1vs1.Can_Send_Reto(UserIndex, otherIndex, gold) Then
                Call m_Retos1vs1.Send_Reto(UserIndex, otherIndex, gold, Drop, Planted, Potions, AIM, CascoEscu, Rounds)
            End If
        End If

    End With

End Sub

Private Sub HandleCancelarSolicitudReto(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCancelarSolicitudReto_Err

100 With UserList(UserIndex)

        Dim RetadorIndex As Integer

        Dim RetadorName As String

102     RetadorName = Message.ReadString16
104     RetadorName = Trim$(RetadorName)
106     RetadorIndex = NameIndex(RetadorName)

108     If RetadorIndex > 0 Then
110         If .mReto.IndexSender > 0 Then
112             If RetadorIndex = .mReto.IndexSender Then
114                 Call WriteConsoleMsg(RetadorIndex, .Name & " canceló tu solicitud de reto.", FontTypeNames.FONTTYPE_INFO)
116                 Call Reset_UserReto1vs1(RetadorIndex)
118                 Call Reset_UserReto1vs1(UserIndex)

                End If

120         ElseIf LenB(.sReto.Nick_Sender) > 0 Then

122             If UCase$(.sReto.Nick_Sender) = UCase$(RetadorName) Then
124                 RetadorIndex = NameIndex(.sReto.Nick_Sender)

126                 If RetadorIndex > 0 Then
128                     Call WriteConsoleMsg(RetadorIndex, .Name & " canceló tu solicitud de reto.", FontTypeNames.FONTTYPE_INFO)
130                     Call Reset_UserReto2vs2(RetadorIndex)

                    End If

                End If

            End If

        End If

    End With

    Exit Sub
HandleCancelarSolicitudReto_Err:
132 Call LogError("TDSLegacy.Protocol.HandleCancelarSolicitudReto en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleActivarGlobal(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleActivarGlobal_Err

100 With UserList(UserIndex)

102     If .flags.Muerto = 1 Then Exit Sub

104     .flags.GlobalOn = Not .flags.GlobalOn

106     If .flags.GlobalOn Then
108         Call WriteConsoleMsg(UserIndex, "Comienzas a leer el chat global.")
        Else
110         Call WriteConsoleMsg(UserIndex, "Dejas de leer el chat global.")

        End If

    End With

    Exit Sub
HandleActivarGlobal_Err:
112 Call LogError("TDSLegacy.Protocol.HandleActivarGlobal en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleGlobalMessage(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleGlobalMessage_Err

100 With UserList(UserIndex)

        Dim tmpTick As Long

        Dim Msg As String

102     Msg = Message.ReadString16()

104     tmpTick = GetTickCount()

        If Not EsGM(UserIndex) Then
            If .Counters.Pena Then
                Call WriteConsoleMsg(UserIndex, "No puedes hablar por global desde la Cárcel.")
                Exit Sub
            End If

            If EsNewbie(UserIndex) Then
                Call WriteConsoleMsg(UserIndex, "No puedes hablar por global siendo Newbie.")
                Exit Sub
            End If

            If .flags.Silenciado = 1 Then
                Call WriteConsoleMsg(UserIndex, "Estás silenciado debido a tu mala conducta.")
                Exit Sub
            End If

        End If

        If Not GlobalActivo Then
            Call WriteConsoleMsg(UserIndex, "El mensaje global se encuentra desactivado.")
            Exit Sub
        End If

106     If (tmpTick - .flags.GlobalTick) > 3000 Or .flags.GlobalTick = 0 Or EsGM(UserIndex) Then
108         If .flags.GlobalOn Then
110             If LenB(Msg) <> 0 Then
112                 Call LogGlobal(.Name & ": " & Msg)
114                 Call SendData(SendTarget.ToGlobal, 0, PrepareMessageConsoleMsg(UserList(UserIndex).Name & "> " & Replace$(Msg, "~", ""), FontTypeNames.FONTTYPE_GLOBAL))

                End If

116             .flags.GlobalTick = tmpTick
            Else
                Call WriteConsoleMsg(UserIndex, "Debes activar el global con el comando /activar para empezar a escribir y leer mensajes globales.")
            End If

        End If

    End With

    Exit Sub
HandleGlobalMessage_Err:
118 Call LogError("TDSLegacy.Protocol.HandleGlobalMessage en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Public Sub HandleTickAntiCuelgue(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    On Error GoTo HandleTickAntiCuelgue_Err
100 UserList(UserIndex).flags.CuentaPq = 0
    Exit Sub
HandleTickAntiCuelgue_Err:
130 Call LogError("TDSLegacy.Protocol.HandleTickAntiCuelgue en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleDragBov(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleDragBov_Err

    Dim TmpObj As UserOBJ, OriginalSlot As Byte, NewSlot As Byte

100 OriginalSlot = Message.ReadInt8
102 NewSlot = Message.ReadInt8

104 If OriginalSlot < 1 Then Exit Sub
106 If NewSlot < 1 Then Exit Sub
108 If OriginalSlot = NewSlot Then Exit Sub
110 If OriginalSlot > MAX_BANCOINVENTORY_SLOTS Then Exit Sub
112 If NewSlot > MAX_BANCOINVENTORY_SLOTS Then Exit Sub

114 With UserList(UserIndex)

116     If .flags.Muerto = 1 Then Exit Sub
118     If Not .flags.Comerciando Then Exit Sub

120     TmpObj = .BancoInvent.Object(OriginalSlot)
122     .BancoInvent.Object(OriginalSlot) = .BancoInvent.Object(NewSlot)
124     .BancoInvent.Object(NewSlot) = TmpObj

126     Call UpdateBanUserInv(False, UserIndex, OriginalSlot)
128     Call UpdateBanUserInv(False, UserIndex, NewSlot)

    End With

    Exit Sub
HandleDragBov_Err:
130 Call LogError("TDSLegacy.Protocol.HandleDragBov en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleAbandonarReto(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleAbandonarReto_Err

100 With UserList(UserIndex)

102     If .mReto.Reto_Index > 0 Then
104         If .mReto.ReturnHome > 1 Then
106             .mReto.ReturnHome = 1
            Else
108             Call m_Retos1vs1.AbandonUserReto1vs1(UserIndex, False)

            End If

110     ElseIf .sReto.Reto_Index > 0 Then

112         If .sReto.ReturnHome > 1 Then
114             .sReto.ReturnHome = 1
            Else
116             Call m_Retos2vs2.AbandonUserReto2vs2(UserIndex, False)

            End If

        End If

    End With

    Exit Sub
HandleAbandonarReto_Err:
118 Call LogError("TDSLegacy.Protocol.HandleAbandonarReto en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleFianza(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim Fianza As Long
    Dim AmountF As Long

    Fianza = Abs(Message.ReadInt32)

    With UserList(UserIndex)

        '@@ Esta muerto?
        If .flags.Muerto <> 0 Then
            Exit Sub
        End If

        '@@ Solo segura
        If MapInfo(.Pos.Map).pk Then
            Call WriteConsoleMsg(UserIndex, "Debes estar en zona segura.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        '@@ No gasto alp2
        If Not criminal(UserIndex) Then
            Call WriteConsoleMsg(UserIndex, "Eres ciudadano, no podrás realizar la fianza.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        '@@ Si es legion no
        If .faccion.FuerzasCaos Then
            Call WriteConsoleMsg(UserIndex, "Los miembros de la legion oscura no pueden realizar fianza..", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If .faccion.Status = ChaosCouncil Then
            Call WriteConsoleMsg(UserIndex, "Los miembros de la legion oscura no pueden realizar fianza..", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        If Fianza < 1 Then Fianza = 1

        AmountF = Fianza * CONFIG_INI_MULTIFIANZA

        If .Stats.GLD < AmountF Then
            Call WriteConsoleMsg(UserIndex, "Necesitas " & AmountF - .Stats.GLD & " monedas de oro para pagar la fianza.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        .Reputacion.NobleRep = .Reputacion.NobleRep + Fianza

        'Actualizamos el tag y activamos seguro anti boludos
        If Not criminal(UserIndex) Then
            Call RefreshCharStatus(UserIndex)

            If Not .flags.Seguro Then
                .flags.Seguro = True
                Call WriteMultiMessage(UserIndex, eMessages.SafeModeOn)
            End If
        End If

        .Stats.GLD = .Stats.GLD - AmountF
        Call WriteUpdateGold(UserIndex)

        Call WriteConsoleMsg(UserIndex, "Has ganado " & Fianza & " puntos de noble." & vbNewLine & "Se te han descontado " & AmountF & " monedas de oro.", FontTypeNames.FONTTYPE_INFO)
        Call LogDesarrollo(.Name & " usó /FIANZA por " & Fianza)

    End With

End Sub

Private Sub HandleCrearTorneo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCrearTorneo_Err

    Dim Cupos As Byte, Inscripcion As Long, CaenItems As Byte, Oro As Long, PuntosDeCanje As Long

    Dim selEvent As Byte, MinLvl As Byte, MaxLvl As Byte

    selEvent = Message.ReadInt8

108 Cupos = Message.ReadInt8
110 Inscripcion = Message.ReadInt32
112 CaenItems = Message.ReadInt8
    PuntosDeCanje = Message.ReadInt32
    Oro = Message.ReadInt32
    MinLvl = Message.ReadInt8
    MaxLvl = Message.ReadInt8
    Dim cp(11) As Byte
    Dim i As Long

    For i = 0 To 11
        cp(i) = Message.ReadInt8
    Next i

    If MinLvl < 1 Then MinLvl = 1
    If MaxLvl > STAT_MAXELV Then MaxLvl = STAT_MAXELV

    If MinLvl > MaxLvl Then MaxLvl = MinLvl

114 If Not EsGM(UserIndex) Then Exit Sub

    If UserList(UserIndex).flags.Privilegios = PlayerType.Consejero Then
        Exit Sub
    End If

116 If TOURNAMENT_ACTIVE <> 0 Then Call WriteConsoleMsg(UserIndex, "Ya hay un Torneo activo:" & NOMBRE_TORNEO_ACTUAL, FontTypeNames.FONTTYPE_FIGHT): Exit Sub

    NOMBRE_TORNEO_ACTUAL = "NINGUNO"

    If CONFIG_INI_HABILITARTORNEOS = 0 Then
        Call WriteConsoleMsg(UserIndex, "El sistema está desactivado por el servidor")
        Exit Sub
    End If

    Select Case selEvent

    Case 1
        '1v1
        If (Cupos > 0 And Cupos < 6) Then
            Call Torneos_Inicia(UserIndex, Cupos, Inscripcion, CaenItems, Oro, PuntosDeCanje, MinLvl, MaxLvl, cp(0), cp(1), cp(2), cp(3), cp(4), cp(5), cp(6), cp(7), cp(8), cp(9), cp(10), cp(11))
        Else
            Call WriteConsoleMsg(UserIndex, "Los cupos son entre 1 y 5 (si pones 1 es para 2 personas, si pones 2 es para 4, etc")
        End If
    Case 2
        '2v2
        Call m_Torneo2vs2.Crea2vs2(UserIndex, Cupos, Inscripcion, (CaenItems = 1), True, Oro, PuntosDeCanje, MinLvl, MaxLvl, cp(0), cp(1), cp(2), cp(3), cp(4), cp(5), cp(6), cp(7), cp(8), cp(9), cp(10), cp(11))
    Case 3
        'death
        If (Cupos > 0 And Cupos < 33) Then
            Call m_TorneoDeath.ActivarNuevo(UserList(UserIndex).Name, PuntosDeCanje, Inscripcion, Oro, Cupos, MinLvl, MaxLvl, cp(0), cp(1), cp(2), cp(3), cp(4), cp(5), cp(6), cp(7), cp(8), cp(9), cp(10), cp(11), CaenItems)
        Else
            Call WriteConsoleMsg(UserIndex, "MINIMO 2 CUPOS - MAXIMO 32")
        End If

    Case 4
        'jdh
        Call m_TorneoJDH.CreateEvent(UserIndex, Cupos, Inscripcion, Oro, PuntosDeCanje, MinLvl, MaxLvl, cp(0), cp(1), cp(2), cp(3), cp(4), cp(5), cp(6), cp(7), cp(8), cp(9), cp(10), cp(11))
    Case 5
        Dim ValeResu As Boolean
        ValeResu = True
        Call CreateXvsX(Cupos, Inscripcion, Oro, PuntosDeCanje, CaenItems, 3, 1, ValeResu, MinLvl, MaxLvl, cp(0), cp(1), cp(2), cp(3), cp(4), cp(5), cp(6), cp(7), cp(8), cp(9), cp(10), cp(11))

    End Select

120 Call LogGM(UserList(UserIndex).Name, UserList(UserIndex).Name & " ha arrancado un torneo: " & NOMBRE_TORNEO_ACTUAL)

    Exit Sub
HandleCrearTorneo_Err:
102 Call LogError("TDSLegacy.Protocol.HandleCrearTorneo en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleCancelarTorneo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleCancelarTorneo_Err

    Dim LAST_TOURNAMENT_ACTIVE As Byte
    LAST_TOURNAMENT_ACTIVE = TOURNAMENT_ACTIVE

    Dim tmpn As String
    tmpn = NOMBRE_TORNEO_ACTUAL

108 If Not EsGM(UserIndex) Then Exit Sub

    Select Case TOURNAMENT_ACTIVE

    Case 1
        '1cvs1
        If iTorneo1vs1.Activo <> 0 Then Call m_Torneo1vs1.Rondas_Cancela
    Case 2
        '2vs2
        If CancelarTorneo2vs2(UserIndex) Then
            tmpn = NOMBRE_TORNEO_ACTUAL
        End If

    Case 3
        'death
        If DeathMatch.Activo <> 0 Then Call m_TorneoDeath.Cancelar
    Case 4
        'jdh
        Call m_TorneoJDH.CancelEvent
    Case 5
        'XVX
        If Evento.Active Then Call CancelXvsX
    End Select

    If Not TOURNAMENT_ACTIVE = LAST_TOURNAMENT_ACTIVE Then
        Call LogGM(UserList(UserIndex).Name, UserList(UserIndex).Name & " ha cancelado un torneo: " & tmpn)
        Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg(tmpn & "Ha sido cancelado.", FontTypeNames.FONTTYPE_EVENTOS))
    End If

    TOURNAMENT_ACTIVE = 0

    Exit Sub

HandleCancelarTorneo_Err:
102 Call LogError("TDSLegacy.Protocol.HandleCancelarTorneo en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleIngresarTorneo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleIngresarTorneo_Err

    Dim ft As FontTypeNames
    Dim MsgErr As String
104 ft = FontTypeNames.FONTTYPE_EVENTOS

    Select Case TOURNAMENT_ACTIVE

    Case 1
122     Call m_Torneo1vs1.Ingresar1vs1(UserIndex)

    Case 2
        Call m_Torneo2vs2.Ingreso2vs2(UserIndex)

    Case 3
        'DEATH
        If m_TorneoDeath.AprobarIngreso(UserIndex, MsgErr) Then
110         Call m_TorneoDeath.Ingresar(UserIndex)
        Else
112         Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & MsgErr, ft)
        End If

    Case 4
        Call m_TorneoJDH.EnterEvent(UserIndex)

    Case 5
        'XVX
        If CanEnterXvsX(UserIndex, MsgErr) Then
            Call EnterXvsX(UserIndex)
        Else
            Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & MsgErr, ft)
        End If

    Case 6
        '2vs2

    End Select

    Exit Sub
HandleIngresarTorneo_Err:
102 Call LogError("TDSLegacy.Protocol.HandleIngresarTorneo en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleSalirTorneo(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSalirTorneo_Err

    Dim lastStatus As Byte
    lastStatus = UserList(UserIndex).flags.EnEvento

    Select Case lastStatus
    Case 1
        Call m_Torneo1vs1.Rondas_UsuarioMuere(UserIndex, False, False, False)
    Case 2
        Call m_Torneo2vs2.Desconexion2vs2(UserIndex)
    Case 3
        Call m_TorneoDeath.DesconectaUser(UserIndex, False)
    Case 4
        Call m_TorneoJDH.EventDie(UserList(UserIndex).Slot_ID)
    End Select


    If Not lastStatus = UserList(UserIndex).flags.EnEvento Then    ' salió?
114     LogDesarrollo UserList(UserIndex).Name & " USO COMANDO PARA SALIR DEL EVENTO: " & NOMBRE_TORNEO_ACTUAL
        Call WriteConsoleMsg(UserIndex, NOMBRE_TORNEO_ACTUAL & "Has salido del evento!", FontTypeNames.FONTTYPE_EVENTOS)
    End If


    Exit Sub

HandleSalirTorneo_Err:
102 Call LogError("TDSLegacy.Protocol.HandleSalirTorneo en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub


''
' Handles the "VerHD" message.
'
' @param    userIndex The index of the user sending the message.
Private Sub HandleVerHD(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
'***************************************************
'Author: ArzenaTh
'Last Modification:  08/06/2012 - ^[GS]^
'Verifica el HD del usuario.
'***************************************************

    Dim UserName As String
    UserName = Message.ReadString16

    If UserList(UserIndex).flags.Privilegios >= PlayerType.Dios Then

        Dim tUser As Integer
        tUser = NameIndex(UserName)

        If tUser < 1 Then

            If AsciiValidos(UserName) Then
                If PersonajeExiste(UserName) Then
                    Dim serialHD As String
                    serialHD = GetVar(CharPath & UserName & ".chr", "ACCOUNT", "HD_Last")
                    Call WriteConsoleMsg(UserIndex, "El usuario " & UserName & " tenía un disco con el Serial " & serialHD, FONTTYPE_INFOBOLD)
                End If
            End If
        Else
            Call WriteConsoleMsg(UserIndex, "El usuario " & UserList(tUser).Name & " tiene un disco con el Serial " & UserList(tUser).flags.serialHD, FONTTYPE_INFOBOLD)
        End If

    End If

End Sub

''
' Handles the "UnBanHD" message.
'
' @param    userIndex The index of the user sending the message.
Private Sub HandleUnbanHD(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
'***************************************************
'Author: ArzenaTh
'Last Modification:  08/06/2012 - ^[GS]^
'Maneja el unbaneo del serial del HD de un usuario.
'***************************************************

    Dim serialHD As String
    serialHD = Message.ReadString16

    If UserList(UserIndex).flags.Privilegios >= PlayerType.Dios Then

        If BanHD_Rem(serialHD) Then
            Call WriteConsoleMsg(UserIndex, "El disco con el Serial " & serialHD & " se ha quitado de la lista de baneados.", FONTTYPE_INFOBOLD)
        Else
            Call WriteConsoleMsg(UserIndex, "El disco con el Serial " & serialHD & " no se encuentra en la lista de baneados.", FONTTYPE_INFO)
        End If

    End If

End Sub

''
' Handles the "BanHD" message.
'
' @param    userIndex The index of the user sending the message.
Private Sub HandleBanHD(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
'***************************************************
'Author: ArzenaTh
'Last Modification: 08/06/2012 - ^[GS]^
'Maneja el baneo del serial del HD de un usuario.
'***************************************************

    Dim UserName As String

    Dim tUser As Integer

    UserName = Message.ReadString16

    With UserList(UserIndex)

        If .flags.Privilegios = PlayerType.Admin Or .flags.Privilegios = PlayerType.Dios Then
            tUser = NameIndex(UserName)

            If tUser > 0 Then

                Dim BannedHD As Long
                BannedHD = UserList(tUser).flags.serialHD

                If BannedHD < 1 Then Exit Sub

                If BanHD_Find(BannedHD) = 0 Then
                    Call BanHD_Add(BannedHD)
                    Call WriteConsoleMsg(UserIndex, "Has baneado el disco duro " & BannedHD & " del usuario " & UserList(tUser).Name, FontTypeNames.FONTTYPE_INFO)

                    Dim i As Long

                    For i = 1 To LastUser

                        If UserList(i).ConnIDValida Then
                            If UserList(i).flags.serialHD = BannedHD Then
                                Call BanCharacter(UserIndex, UserList(i).Name, "Ban de serial de disco duro.")
                            End If
                        End If

                    Next i

                End If

            Else
                Call WriteConsoleMsg(UserIndex, "El personaje no está online.")
            End If
        End If

    End With

End Sub

Private Sub HandlePartyTalk(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandlePartyTalk_Err

    Dim Chat As String

102 Chat = Message.ReadString16()

    'Call SendData(SendTarget.ToAdminsAreaButConsejeros, UserIndex, PrepareMessageChatOverHead(Chat, UserList(UserIndex).Char.CharIndex, vbYellow))

    Call mod_Party.BroadCastParty(UserIndex, Chat)


    Exit Sub
HandlePartyTalk_Err:
150 Call LogError("TDSLegacy.Protocol.HandlePartyTalk en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleFUN_PjFull(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleFUN_PjFull_Err

    If Not EsGM(UserIndex) Then
        If val(GetVar(IniPath & "server.ini", "INIT", "FUN")) = 0 Then
            Call WriteConsoleMsg(UserIndex, "Comando deshabilitado por los Administradores!")
            Exit Sub
        End If
    End If

    Call hp_full(UserIndex)

    Exit Sub
HandleFUN_PjFull_Err:
112 Call LogError("TDSLegacy.Protocol.HandleFUN_PjFull en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleFUN_GMFull(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleFUN_GMFull_Err

    If UserList(UserIndex).flags.Privilegios = PlayerType.Admin Or UserList(UserIndex).flags.Privilegios = PlayerType.Dios Then

        UserList(UserIndex).Stats.MaxHP = 32000
        UserList(UserIndex).Stats.MaxMAN = 32000
        UserList(UserIndex).Stats.MaxSta = 32000
        UserList(UserIndex).Stats.MinHP = 32000
        UserList(UserIndex).Stats.MinMAN = 32000
        UserList(UserIndex).Stats.minSta = 32000

        Dim AumentoHIT As Integer, i As Long

        For i = 1 To UserList(UserIndex).Stats.ELV
            Select Case UserList(UserIndex).Clase

            Case eClass.Warrior
                AumentoHIT = AumentoHIT + IIf(i > 35, 2, 3)

            Case eClass.Hunter
                AumentoHIT = AumentoHIT + IIf(i > 35, 2, 3)

            Case eClass.Paladin
                AumentoHIT = AumentoHIT + IIf(i > 35, 1, 3)

            Case eClass.Mage
                AumentoHIT = AumentoHIT + 1

            Case eClass.Assasin
                AumentoHIT = AumentoHIT + IIf(i > 35, 1, 3)
            Case Else
                AumentoHIT = AumentoHIT + 2
            End Select
        Next i

        UserList(UserIndex).Stats.MinHIT = 1 + AumentoHIT
        UserList(UserIndex).Stats.MaxHIT = 2 + AumentoHIT

        UserList(UserIndex).Stats.MinHP = UserList(UserIndex).Stats.MaxHP
        UserList(UserIndex).Stats.MinMAN = UserList(UserIndex).Stats.MaxMAN
        UserList(UserIndex).Stats.minSta = UserList(UserIndex).Stats.MaxSta

        Call WriteUpdateUserStats(UserIndex)
    End If


    Exit Sub
HandleFUN_GMFull_Err:
112 Call LogError("TDSLegacy.Protocol.HandleFUN_GMFull en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleResetChar(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleResetChar_Err

    With UserList(UserIndex)

        If .flags.TargetNPC = 0 Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el NPC que está en Ullathorpe para resetear tu personaje!")
        ElseIf Not Npclist(.flags.TargetNPC).NPCtype = eNPCType.ReseteadorDePersonaje Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el NPC que está en Ullathorpe para resetear tu personaje!")
        ElseIf distancia(UserList(UserIndex).Pos, Npclist(.flags.TargetNPC).Pos) > 3 Or Not .Pos.Map = Npclist(.flags.TargetNPC).Pos.Map Then
            Call WriteMensajes(UserIndex, Mensaje_5)
        Else
            .flags.TargetNPC = 0
            Call ResetearPersonaje(UserIndex)
        End If

    End With

    Exit Sub
HandleResetChar_Err:
112 Call LogError("TDSLegacy.Protocol.HandleResetChar en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

Private Sub HandleSendReto3vs3(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleSendReto3vs3_Err

    Dim i As Long

    Dim Team1(1 To 2) As String
    Dim Team1_Index(1 To 2) As String

    Dim Team2(1 To 3) As String
    Dim Team2_Index(1 To 3) As String

    Dim ValeResu As Boolean
    Dim CaenItems As Boolean
    Dim LimiteDePociones As Integer
    Dim Oro As Long

    For i = 1 To 2
        Team1(i) = Message.ReadString16
        Team1_Index(i) = NameIndex(Team1(i))
    Next i

    For i = 1 To 3
        Team2(i) = Message.ReadString16
        Team2_Index(i) = NameIndex(Team2(i))
    Next i

    CaenItems = Message.ReadBool
    Oro = Message.ReadInt32
    LimiteDePociones = Message.ReadInt
    ValeResu = Message.ReadBool

    Call WriteConsoleMsg(UserIndex, "El sistema está en revisión.")

    Exit Sub

HandleSendReto3vs3_Err:
    Call LogError("TDSLegacy.Protocol.HandleSendReto3vs3 en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleBorrarPj(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBorrarPj_Err

    Dim Name As String
    Dim Password As String
    Dim Pin As String
    Dim Email As String
    Dim tIndex As Integer

1   Name = UCase$(Trim$(Replace$(Message.ReadString16, "+", " ")))
2   Password = Trim$(Message.ReadString16)
3   Pin = Trim$(Message.ReadString16)
4   Email = LCase$(Trim$(Message.ReadString16))

    If CONFIG_INI_BORRARPJ = 0 Then Call WriteConsoleMsg(UserIndex, "Comando deshabilitado por el Servidor."): Exit Sub

    With UserList(UserIndex)
        If .flags.TargetNPC = 0 Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el NPC que está en Ullathorpe para borrar un personaje!")
        ElseIf Not Npclist(.flags.TargetNPC).NPCtype = eNPCType.BorradorDePersonaje Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el NPC que está en Ullathorpe para borrar un personaje!")
        ElseIf distancia(UserList(UserIndex).Pos, Npclist(.flags.TargetNPC).Pos) > 3 Or Not .Pos.Map = Npclist(.flags.TargetNPC).Pos.Map Then
            Call WriteMensajes(UserIndex, Mensaje_5)
        Else
            .flags.TargetNPC = 0
            Call BorrarPersonaje(UserIndex, Name, Password, Pin, Email)
        End If
    End With

    Exit Sub

HandleBorrarPj_Err:
    Call LogError("TDSLegacy.Protocol.HandleBorrarPj en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Private Sub HandleBorrarMensajeConsola(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    On Error GoTo HandleBorrarMensajeConsola_Err

    Dim Mensaje As String, Reemplazo As String, tipo As Byte

    tipo = Message.ReadInt8

2   Mensaje = Message.ReadString16

    If tipo = 1 Then    ' o sea, reemplaza.
        Reemplazo = Message.ReadString16

        If UCase$(Trim$(Reemplazo)) = UCase$(Trim$(Mensaje)) Then
            Call WriteConsoleMsg(UserIndex, "Texto inválido.")
            Exit Sub
        End If

    End If

    If UserList(UserIndex).flags.Privilegios >= PlayerType.Dios Then
        If Len(Mensaje) > 0 Then
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsgDelete(Mensaje, tipo, Reemplazo))
        Else
            Call WriteConsoleMsg(UserIndex, "Texto inválido.")
        End If
    End If

    Exit Sub

HandleBorrarMensajeConsola_Err:
    Call LogError("TDSLegacy.Protocol.HandleBorrarMensajeConsola en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub HandleChangeMapInfoMusic(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

100 With UserList(UserIndex)

        Dim music As Integer

102     music = Message.ReadInt()

104     If Not .flags.Privilegios >= PlayerType.Dios Then Exit Sub

106     Call LogGM(.Name, .Name & " ha cambiado la información sobre el tema, canción:" & music)

        Call LogGM(.Name, "Cambió la música del mapa de " & MapInfo(.Pos.Map).music & " a: " & music & " en el mapa: " & .Pos.Map)

112     MapInfo(.Pos.Map).music = music    '& "-1"

114     Call WriteVar(App.path & MapPath & "mapa" & .Pos.Map & ".dat", "Mapa" & .Pos.Map, "backup", MapInfo(.Pos.Map).music)

116     Call WriteConsoleMsg(UserIndex, "Mapa " & .Pos.Map & " - musica: " & MapInfo(.Pos.Map).music, FontTypeNames.FONTTYPE_INFO)

        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " realizó cambios musicales en el mapa " & .Pos.Map, FontTypeNames.FONTTYPE_SERVER))

        Call SendData(SendTarget.ToHigherAdmins, 0, PrepareMessageConsoleMsg("Servidor:" & .Name & " realizó cambios musicales en el mapa " & .Pos.Map, FontTypeNames.FONTTYPE_SERVER))

        Call modSendData.SendData(toMap, .Pos.Map, PrepareMessagePlayMidi(val(ReadField(1, MapInfo(.Pos.Map).music, 45))))

    End With

End Sub


Private Sub HandleMenuClient(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim MenuCliente As Byte
    Dim Slot As Byte

    With UserList(UserIndex)

        MenuCliente = IIf(.flags.MenuCliente <> eVentanas.vInventario, eVentanas.vInventario, eVentanas.vHechizos)

        '++ Asi que te gusta editar paketiyos jejeje.
        If .flags.MenuCliente <> MenuCliente Then
            .flags.MenuCliente = MenuCliente

            Slot = Message.ReadInt8

            If Slot <> FLAGORO Then
                If Slot = 0 Then Slot = 1
                If Slot > .CurrentInventorySlots Then Slot = .CurrentInventorySlots
                If Slot < 1 Or Slot > .CurrentInventorySlots Then
                    'uso de editor de paquetes. (Intento mandar un slot invalido)
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " Alerta code: 10?" & Slot, FontTypeNames.FONTTYPE_SERVER))
                    Call LogAntiCheat(.Name & " intentó enviar un slot invalido.")
                End If
            End If

            .flags.LastSlotClient = Slot

            'If UserList(UI).ElPedidorSeguimiento > 0 Then
            '    Call WriteUpdateSegInvHechiz(UI)
            'End If

            Dim TActual As Long
            TActual = GetTickCount() And &H7FFFFFFF

            If .Counters.TickReactionInv > 0 Then
                If TActual - .Counters.TickReactionInv < 77 Then
                    'posible uso de macro inventario - Tiempo Reaccion:
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 11 - React " & TActual - .Counters.TickReactionInv, FontTypeNames.FONTTYPE_SERVER))
                End If

                .Counters.TickReactionInv = 0
            End If

            If .Counters.TickVelocityMenu > 0 Then
                If TActual - .Counters.TickVelocityMenu < 100 Then
                    'posible uso de macro inv/hechi - Tiempo Inventareo:
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 12 -  " & TActual - .Counters.TickVelocityMenu, FontTypeNames.FONTTYPE_SERVER))
                End If
            End If

            .Counters.TickVelocityMenu = TActual
        Else
            '- uso de editor de paquetes - Menu-Client.
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 13", FontTypeNames.FONTTYPE_SERVER))
        End If

    End With

End Sub

Private Sub HandleUsePotionsClick(ByVal Message As BinaryReader, ByVal UserIndex As Integer, ByVal AgainLast As Byte)

    Dim Slot As Byte
    Dim RandomKey As Byte

    With UserList(UserIndex)

        If AgainLast > 0 Then
            Slot = .flags.LastSlotPotion        'LastSlotClient
            RandomKey = IIf(.mLastKeyUseItem > 1, 1, 2)
        Else
            Slot = Message.ReadInt8
            RandomKey = Message.ReadInt8

            .flags.LastSlotPotion = Slot
        End If

        ' @@ Anti cheat clickear inventario en hechizos
        If .flags.MenuCliente <> eVentanas.vInventario Then        ' @@ Y no esta en inventario
            'uso de editor de paquetes. (Intento clickear el inventario estando en hechizos)
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 14", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " intentó clickear el inventario estando en la ventana de hechizos")
            'Exit Sub
        End If

        ' @@ Anti cheat cambiar de slot en hechizos
        If .flags.MenuCliente <> 1 Then        ' @@ Si no esta en inventario
            If .flags.LastSlotClient <> 255 Then        ' @@ Si no es la primera vez que poteo
                If Slot <> .flags.LastSlotClient Then        ' @@ Si el slot es distinto
                    'uso de editor de paquetes. (Intento cambiar de slot estando en hechizos)
                    Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 15", FontTypeNames.FONTTYPE_SERVER))
                    Call LogAntiCheat(.Name & " intentó cambiar de slot estando en la ventana de hechizos.")
                    'Exit Sub
                End If
            End If
        End If

        ' @@ Anti editor de paquetes poteo
        If RandomKey > 0 And RandomKey < 3 Then
            If RandomKey = .mLastKeyUseItem Then
                'probable uso de algún editor de paquetes. POTEO
                Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad Poteo Click» " & .Name & " - Alerta code: 16 - RandomKey:" & RandomKey, FontTypeNames.FONTTYPE_SERVER))
                Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Poteo Click. RandomKey: " & RandomKey)
                'Exit Sub
            End If

        Else
            'probable uso de algún editor de paquetes. POTEO
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad Poteo Click» " & .Name & " - Alerta code: 17", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Poteo Click. RandomKey:. " & RandomKey)
            'Exit Sub
        End If

        .mLastKeyUseItem = RandomKey

        ' ++ Si es distinto actualizamos jejeje
        If Slot <> .flags.LastSlotClient Then
            .flags.LastSlotClient = Slot
        End If

        If Slot <= .CurrentInventorySlots And Slot > 0 Then
            If .Invent.Object(Slot).ObjIndex = 0 Then Exit Sub
        End If

        If .flags.Meditando Then Exit Sub
        '            .flags.Meditando = False
        '            Call WriteMeditateToggle(userindex)
        '            Call PrepareMessageCreateFX(.Char.CharIndex, 0, 0)
        '            Call SendData(SendTarget.ToPCArea, userindex)
        '        End If

        '++ Calate esta misery jsjsjsjs
        If .flags.Comerciando Then
            'uso de editor de paquetes. (Intento tomar pociones estando comerciando)
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 18", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " - Uso de editor de paquetes - Tomar pociones comerciando.")
            'Exit sub
        End If

        If Not IntervaloPermiteUsarClick(UserIndex) Then Exit Sub
        Call UseInvPotion(UserIndex, Slot)

    End With

End Sub

Private Sub HandleWorkMagia(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim Spell As Byte
    Spell = Message.ReadInt8

    With UserList(UserIndex)

        If .flags.Muerto > 0 Then Exit Sub

        If .flags.MenuCliente <> eVentanas.vHechizos Then
            'uso de editor de paquetes. (Intento apretar lanzar estando en inventario)
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Seguridad " & .Name & " - Alerta code: 19", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat(.Name & " intentó apretar lanzar estando en la ventana de inventario.")
            'Exit Sub
        End If

        'Now you can be atacked
        .flags.NoPuedeSerAtacado = False

        If Spell < 1 Or Spell > MAXUSERHECHIZOS Then
            .flags.Hechizo = 0
            Exit Sub
        End If

        .flags.Hechizo = .Stats.UserHechizos(Spell)

    End With

    'If exiting, cancel
    Call CancelExit(UserIndex)
    Call WriteWorkRequestTarget(UserIndex, eSkill.Magia)

End Sub

Private Sub HandleWorkMagiaClick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim X As Byte
    Dim Y As Byte
    Dim ErrSpell As Byte

    X = Message.ReadInt8
    Y = Message.ReadInt8
    ErrSpell = Message.ReadInt8

    With UserList(UserIndex)

        If .flags.Descansar Or .flags.Meditando Or Not InMapBounds(.Pos.Map, X, Y) Then Exit Sub

        If Not InRangoVision(UserIndex, X, Y) Then
            Call WritePosUpdate(UserIndex)
            Exit Sub
        End If

        'If exiting, cancel
        Call CancelExit(UserIndex)

        'Check the map allows spells to be casted.
        If MapInfo(.Pos.Map).MagiaSinEfecto > 0 Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_421)        '"Una fuerza oscura te impide canalizar tu energía."
            Exit Sub
        End If

        If ErrSpell > 125 Then
            If MapData(.Pos.Map, X, Y).UserIndex > 0 Or MapData(.Pos.Map, X, Y).NpcIndex > 0 Then
                If .CountDetectionErr < 1 Then
                    .CantErr = 1
                    .CountDetectionErr = 6
                Else
                    If .CantErr < 2 Then
                        .CantErr = .CantErr + 1
                    Else
                        .CantErr = 0
                        .CountDetectionErr = 0

                        Call SendData(SendTarget.ToAdmins, UserIndex, PrepareMessageConsoleMsg(.Name & " posible uso cheat (CODIGO: 5)", FontTypeNames.FONTTYPE_VENENO))
                        'Call LogMacros(5, "TRIGGER BOT", UserIndex)
                    End If
                End If
            End If
        End If

        .ErrSpell = ErrSpell

        'Target whatever is in that tile
        Call LookatTile(UserIndex, .Pos.Map, X, Y, 1)

        'If it's outside range log it and exit
        If Abs(.Pos.X - X) > RANGO_VISION_X Or Abs(.Pos.Y - Y) > RANGO_VISION_Y Then
            Call SendData(SendTarget.ToAdmins, 0, PrepareMessageConsoleMsg("Ataque fuera de rango de " & .Name & "(" & .Pos.Map & "/" & .Pos.X & "/" & .Pos.Y & ") a la posición (" & .Pos.Map & "/" & X & "/" & Y & ")", FontTypeNames.FONTTYPE_SERVER))
            Call LogAntiCheat("Ataque fuera de rango de " & .Name & "(" & .Pos.Map & "/" & .Pos.X & "/" & .Pos.Y & ") ip: " & .IP & " a la posición (" & .Pos.Map & "/" & X & "/" & Y & ")")
            Exit Sub
        End If


        'Check bow's interval
268     If Not IntervaloPermiteUsarArcos(UserIndex, False) Then Exit Sub

        'Check Spell-Hit interval
        If Not IntervaloPermiteGolpeMagia(UserIndex) Then

            'Check Magic interval
            If Not modAntiCheat.PuedeIntervalo(UserIndex, IntControl.Lanzar) Then
                Exit Sub

            End If

        End If

        'Check intervals and cast
        If .flags.Hechizo > 0 Then
            If .flags.TargetBot > 0 Then    ' @@ Sistema de clones
                Call m_ArenaBots.IA_UserDamage(.flags.Hechizo, .flags.TargetBot, UserIndex)
                .flags.TargetBot = 0
            Else
                Call LanzarHechizo(.flags.Hechizo, UserIndex)
            End If

            .flags.Hechizo = 0
        Else
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_233)        '"¡Primero selecciona el hechizo que quieres lanzar!"
        End If

    End With

End Sub

Private Sub HandleChequeMAO(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim ID As String

    ID = Message.ReadString16

    With UserList(UserIndex)

        If .flags.Comerciando Then Exit Sub

        If .flags.TargetNPC = 0 Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el banquero y clickearlo para poder cobrar el cheque!")
            Exit Sub
        ElseIf Not Npclist(.flags.TargetNPC).NPCtype = eNPCType.Banquero Then
            Call WriteConsoleMsg(UserIndex, "Debes ir con el banquero y clickearlo para poder cobrar el cheque!")
            Exit Sub
        ElseIf distancia(UserList(UserIndex).Pos, Npclist(.flags.TargetNPC).Pos) > 3 Or Not .Pos.Map = Npclist(.flags.TargetNPC).Pos.Map Then
            Call WriteMensajes(UserIndex, Mensaje_5)
            Exit Sub
        End If


        Call CancelExit(UserIndex)


        Dim totCheques As Long, i As Long

        totCheques = val(GetVar(DatPath & "Cheques.dat", "INIT", "Cheques"))

        If totCheques = 0 Then Exit Sub

        For i = 1 To totCheques
            If GetVar(DatPath & "Cheques.dat", i, "ID") = ID Then

                If val(GetVar(DatPath & "Cheques.dat", i, "USED")) = 1 Then Exit Sub

                Dim Monto As Double

                Monto = val(GetVar(DatPath & "Cheques.dat", i, "Monto"))

                Call WriteVar(DatPath & "Cheques.dat", i, "USED", 1)
                .Stats.Banco = .Stats.Banco + val(GetVar(DatPath & "Cheques.dat", i, "Monto"))

                Call WriteChatOverHead(UserIndex, "Has cobrado un cheque por el monto de " & Format$(CStr(Fix(Monto)), "#,###,###,###") & " monedas de oro.", Npclist(.flags.TargetNPC).Char.CharIndex, vbGreen)
                Call LogCheques(.Name & " cobró cheque ID: " & ID & " por el monto: " & Format$(CStr(Fix(Monto)), "#,###,###,###"))
                Exit Sub
            End If
        Next i

        .flags.TargetNPC = 0

        Call LogCheques(.Name & " intentó cheque ID: " & ID, True)

    End With

End Sub

Private Sub HandleCambiarNick(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

'WriteShowSpecialForm

    Dim UserName As String, oldUserName As String
    Dim GI As Integer, j As Long

    Dim MiObj As Obj
    MiObj.Amount = 1
    MiObj.ObjIndex = 843

    UserName = Trim$(Message.ReadString16)

    ' @@ Evitamos nicks con varios espacios
    Do While InStr(UserName, "  ") > 0
        UserName = Replace(UserName, "  ", " ")
    Loop

    With UserList(UserIndex)

        oldUserName = UCase$(.Name)

        If .flags.Comerciando Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_27)
            Exit Sub
        ElseIf .flags.Muerto = 1 Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub
        ElseIf MapInfo(.Pos.Map).pk Then
            Call WriteConsoleMsg(UserIndex, "Para realizar esta acción debes estar en zona segura o dentro de una ciudad!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not TieneObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex) Then
            Call WriteConsoleMsg(UserIndex, "Necesitas al menos " & ObjData(MiObj.ObjIndex).Name & " (" & MiObj.Amount & ") para poder realizar ésta acción!", FontTypeNames.FONTTYPE_NARANJA)
            Exit Sub
        ElseIf Len(UserName) < 3 Then
            Call WriteConsoleMsg(UserIndex, "Nombre demasiado corto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Len(UserName) > 15 Then
            Call WriteConsoleMsg(UserIndex, "Nombre demasiado largo.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not AsciiValidos(UserName) Then
            Call WriteConsoleMsg(UserIndex, "Nombre inválido!", FontTypeNames.FONTTYPE_INFO)
            Call LogCustom("CambiarNick", .Name & " quiso ponerse el nick: " & Chr(34) & UserName & Chr(34))
            Exit Sub
        ElseIf PersonajeExiste(UserName) Then
            Call WriteConsoleMsg(UserIndex, "Ese nombre ya está en uso!!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not UserDarPrivilegioLevel(UserName) = PlayerType.User Then
            Call WriteConsoleMsg(UserIndex, "Ese nombre está reservado!!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        End If

        .flags.mao_index = 0

        Call QuitarObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex)

        Call SaveUser(UserIndex, CharPath & UCase$(.Name) & ".chr")

        GI = .GuildIndex

        'Cambiar el nick dentro de los guilds
        If GI Then
            Dim CantMembers As Long
            Dim GuildName As String
            GuildName = GetVar(GUILDINFOFILE, "GUILD" & .GuildIndex, "GuildName")
            CantMembers = val(GetVar(GUILDPATH & GuildName & "-members.mem", "INIT", "NroMembers"))

            For j = 1 To CantMembers
                If UCase$(GetVar(GUILDPATH & GuildName & "-members.mem", "Members", "Member" & j)) = UCase$(.Name) Then
                    Call WriteVar(GUILDPATH & GuildName & "-members.mem", "Members", "Member" & j, UCase$(UserName))
                End If
            Next j

            'Actualizo solicitudes de ingreso a un clan
            If val(GetVar(CharPath & UserList(UserIndex).Name & ".chr", "GUILD", "ASPIRANTEA")) > 0 Then
                Dim AspiranteIndex As Integer
                AspiranteIndex = guilds(.GuildIndex).NumeroDeAspirante(.Name)
                If AspiranteIndex > 0 Then
                    Call guilds(.GuildIndex).ActualizarNombreDeAspirante(UserName, AspiranteIndex)
                End If
            End If

        End If

        ' @@ Si es lider de un clan disuelto entonces le actualizo el name para que pueda reanudarlo.
        If CANTIDADDECLANES Then
            For j = 1 To CANTIDADDECLANES
                If UCase$(GetVar(GUILDINFOFILE, "GUILD" & j, "Leader")) = UCase$(.Name) Then
                    Call WriteVar(GUILDINFOFILE, "GUILD" & j, "Leader", UCase$(UserName))
                End If
            Next j
        End If

        ' WEB Borrar requests en las que yo haya enviado algo
        ' WEB Cambiar el nick
        If frmMain.sck_PostWEB.State = 7 Then        ' está conectado?
            frmMain.sck_PostWEB.SendData ("|5" & "CAMBIARNOMBRE_PJ=" & 1 & "&nick=" & .Name & "&newNick=" & UserName & "&IP=" & .IP)
        End If

        Call LogCustom("CambiarNick", .Name & " cambió su nick por " & Chr(34) & UserName & Chr(34))

        Call WriteConsoleMsg(UserIndex, "El objeto ha modificado tu apariencia!! Disfruta de tu nuevo nombre!", FontTypeNames.FONTTYPE_NARANJA)

        FileCopy CharPath & UCase$(.Name) & ".chr", CharPath & UserName & ".chr"
        Kill CharPath & oldUserName & ".chr"

        .Name = UserName

        Call RefreshCharStatus(UserIndex)

        'Call CloseSocket(userindex)

    End With

End Sub


Private Sub HandleCambiarCara(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

'WriteShowSpecialForm

    Dim Head As Integer, OldHead As Integer
    Dim MiObj As Obj

    MiObj.Amount = 1
    MiObj.ObjIndex = 842

    Head = Message.ReadInt

    With UserList(UserIndex)

        If .flags.Mimetizado = 1 Or .flags.Navegando = 1 Then
            OldHead = .OrigChar.Head
        Else
            OldHead = .Char.Head
        End If

        If .flags.Comerciando Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_27)
            Exit Sub
        ElseIf .flags.Muerto = 1 Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub
        ElseIf MapInfo(.Pos.Map).pk Then
            Call WriteConsoleMsg(UserIndex, "Para realizar esta acción debes estar en zona segura o dentro de una ciudad!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not TieneObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex) Then
            Call WriteConsoleMsg(UserIndex, "Necesitas al menos " & ObjData(MiObj.ObjIndex).Name & " (" & MiObj.Amount & ") para poder realizar ésta acción!", FontTypeNames.FONTTYPE_NARANJA)
            Exit Sub
        ElseIf Not ValidHead(Head, .raza, .Genero) And Not EsGM(UserIndex) Then
            Call WriteConsoleMsg(UserIndex, "Debes seleccionar una cabeza válida para tu raza y genero!")
            Call LogCustom("CambiarCara", .Name & " quiso ponerse la head: " & Head)
            Exit Sub
        End If

        If Head = 0 Then Exit Sub

        'If .flags.Mimetizado = 1 Or .flags.Navegando = 1 Or .flags.AdminInvisible = 1 Or .flags.Muerto = 1 Then
        '    .OrigChar.Head = Head
        '    .Char.Head = Head
        'Else
        '    .Char.Head = Head
        'End If
        .OrigChar.Head = Head
        .Char.Head = Head
        Call ChangeUserChar(UserIndex, .Char.body, .Char.Head, .Char.Heading, .Char.WeaponAnim, .Char.ShieldAnim, .Char.CascoAnim)

        Call WriteVar(CharPath & .Name & ".chr", "INIT", "Head", val(Head))

        Call LogCustom("CambiarCara", .Name & " cambió su head " & OldHead & " por la head: " & Head)

        Call WriteConsoleMsg(UserIndex, "El objeto ha modificado tu apariencia!! Disfruta de tu nuevo rostro!", FontTypeNames.FONTTYPE_NARANJA)

        Call QuitarObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex)

    End With

End Sub

Private Sub HandleCambiarNickClan(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

'WriteShowSpecialForm

    Dim ClanName As String, oldClanName As String
    Dim j As Long

    Dim MiObj As Obj
    MiObj.Amount = 1
    MiObj.ObjIndex = 844

    ClanName = Trim$(Message.ReadString16)

    ' @@ Evitamos nicks con varios espacios
    Do While InStr(ClanName, "  ") > 0
        ClanName = Replace(ClanName, "  ", " ")
    Loop

    With UserList(UserIndex)

        If .flags.Comerciando Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_27)
            Exit Sub
        ElseIf .flags.Muerto = 1 Then
            Call WriteMensajes(UserIndex, e_Mensajes.Mensaje_3)
            Exit Sub
        ElseIf .GuildIndex = 0 Then
            Call WriteConsoleMsg(UserIndex, "No tienes clan!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf MapInfo(.Pos.Map).pk Then
            Call WriteConsoleMsg(UserIndex, "Para realizar esta acción debes estar en zona segura o dentro de una ciudad!", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not TieneObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex) Then
            Call WriteConsoleMsg(UserIndex, "Necesitas al menos " & ObjData(MiObj.ObjIndex).Name & " (" & MiObj.Amount & ") para poder realizar ésta acción!", FontTypeNames.FONTTYPE_NARANJA)
            Exit Sub
        ElseIf Len(ClanName) < 3 Then
            Call WriteConsoleMsg(UserIndex, "Nombre demasiado corto.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Len(ClanName) > 15 Then
            Call WriteConsoleMsg(UserIndex, "Nombre demasiado largo.", FontTypeNames.FONTTYPE_INFO)
            Exit Sub
        ElseIf Not AsciiValidos(ClanName) Then
            Call WriteConsoleMsg(UserIndex, "Nombre inválido!", FontTypeNames.FONTTYPE_INFO)
            Call LogCustom("CambiarNickClan", .Name & " quiso poner el nick de clan: " & Chr(34) & ClanName & Chr(34))
            Exit Sub
        End If

        For j = 1 To CANTIDADDECLANES
            If UCase$(guilds(j).GuildName) = UCase$(ClanName) Then
                Call WriteConsoleMsg(UserIndex, "Ese nombre de clan ya está en uso!!", FontTypeNames.FONTTYPE_INFO)
                Exit For
            End If
        Next j

        oldClanName = guilds(.GuildIndex).GuildName

        If modGuilds.ActualizarNombreClan(UserIndex, ClanName) Then
            Call QuitarObjetos(MiObj.ObjIndex, MiObj.Amount, UserIndex)
            Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("¡El clan " & Chr(34) & oldClanName & Chr(34) & " ha cambiado de nombre a " & Chr(34) & ClanName & Chr(34), FontTypeNames.FONTTYPE_GUILD))
        End If


    End With

End Sub

Public Sub HandleQuestAccept(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Dim NpcIndex As Integer
    Dim QuestSlot As Byte

    NpcIndex = UserList(UserIndex).flags.TargetNPC
    If NpcIndex = 0 Then Exit Sub
    If distancia(UserList(UserIndex).Pos, Npclist(NpcIndex).Pos) > 5 Then
        Call WriteConsoleMsg(UserIndex, "Estas demasiado lejos.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If
    QuestSlot = FreeQuestSlot(UserIndex)
    If QuestSlot = 0 Then
        Call WriteConsoleMsg(UserIndex, "No tienes espacio para más misiones.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    With UserList(UserIndex).QuestStats.Quests(QuestSlot)
        .QuestIndex = Npclist(NpcIndex).QuestNumber
        If QuestList(.QuestIndex).RequiredNPCs Then ReDim .NPCsKilled(1 To QuestList(.QuestIndex).RequiredNPCs)
        Call WriteConsoleMsg(UserIndex, "Has aceptado la mision " & Chr(34) & QuestList(.QuestIndex).Nombre & Chr(34) & ".", FontTypeNames.FONTTYPE_INFO)
    End With
End Sub


Public Sub HandleQuest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Dim NpcIndex As Integer
    Dim tmpByte As Byte

    NpcIndex = UserList(UserIndex).flags.TargetNPC
    If NpcIndex = 0 Then Exit Sub
    If distancia(UserList(UserIndex).Pos, Npclist(NpcIndex).Pos) > 5 Then
        Call WriteConsoleMsg(UserIndex, "Estas demasiado lejos.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If
    If Npclist(NpcIndex).QuestNumber = 0 Then
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("No tengo ninguna mision para ti.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
        Exit Sub
    End If
    If UserDoneQuest(UserIndex, Npclist(NpcIndex).QuestNumber) Then
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("Ya has hecho una mision para mi.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
        Exit Sub
    End If
    If UserList(UserIndex).Stats.ELV < QuestList(Npclist(NpcIndex).QuestNumber).RequiredLevel Then
        Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("Debes ser por lo menos nivel " & QuestList(Npclist(NpcIndex).QuestNumber).RequiredLevel & " para emprender esta mision.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
        Exit Sub
    End If

    ' Si es 2 entonces pide ser Army
    ' Si es 1 entonces pide ser Caos
    If QuestList(Npclist(NpcIndex).QuestNumber).RequiredFaccion Then
        If UserList(UserIndex).faccion.FuerzasCaos = 0 And QuestList(Npclist(NpcIndex).QuestNumber).RequiredFaccion = 1 Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("Debes pertenecer a la Legión Oscura para emprender esta mision.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
            Exit Sub
        ElseIf UserList(UserIndex).faccion.ArmadaReal = 0 And QuestList(Npclist(NpcIndex).QuestNumber).RequiredFaccion = 2 Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("Debes pertenecer al Ejército Real para emprender esta mision.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
            Exit Sub
        End If
    End If

    tmpByte = TieneQuest(UserIndex, Npclist(NpcIndex).QuestNumber)
    If tmpByte Then
        Call FinishQuest(UserIndex, Npclist(NpcIndex).QuestNumber, tmpByte)
    Else
        tmpByte = FreeQuestSlot(UserIndex)
        If tmpByte = 0 Then
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageChatOverHead("Estas haciendo demasiadas misiones. Vuelve cuando hayas completado alguna.", Npclist(NpcIndex).Char.CharIndex, vbWhite))
            Exit Sub
        End If
        Call WriteQuestDetails(UserIndex, Npclist(NpcIndex).QuestNumber)
    End If
End Sub

Public Sub HandleQuestListRequest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)
    Call WriteQuestListSend(UserIndex, 0)
End Sub

Public Sub HandleQuestDetailsRequest(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim QuestSlot As Integer
    QuestSlot = Message.ReadInt

    Call WriteQuestDetails(UserIndex, UserList(UserIndex).QuestStats.Quests(QuestSlot).QuestIndex, QuestSlot)

End Sub

Public Sub HandleQuestAbandon(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    Dim QuestSlot As Integer
    QuestSlot = Message.ReadInt

    Call CleanQuestSlot(UserIndex, QuestSlot)
    Call ArrangeUserQuests(UserIndex)
    Call WriteQuestListSend(UserIndex, 1)

End Sub

Private Sub HandleCVC_Accion(ByVal Message As BinaryReader, ByVal UserIndex As Integer)

    With UserList(UserIndex)
        
        Select Case Message.ReadInt8
        
            ' Enviar solicitud de CVC
            Case mCVC_Accion.cvc_EnviarSolicitud
                Call cvcManager.HandleRequestCVC(UserIndex, Message.ReadString16, Message.ReadInt16)
            
            ' Aceptar solicitud de CVC
            Case mCVC_Accion.cvc_AceptarSolicitud
                Call cvcManager.HandleAcceptCVCRequest(UserIndex, Message.ReadString16)
                
            Case mCVC_Accion.cvc_RechazarSolicitud
                Call cvcManager.HandleRejectCVCRequest(UserIndex, Message.ReadString16)
                
            ' Cambiar la selección de jugadores
            Case mCVC_Accion.cvc_CambiarSeleccion
                Call cvcManager.HandleSelectPlayers(UserIndex, Message.ReadString16)
                
            ' Confirmar la selección de jugadores
            Case mCVC_Accion.cvc_ConfirmarSeleccion
                Call cvcManager.HandleConfirmSelection(UserIndex)
                
            ' Cancelar la solicitud de CVC
            Case mCVC_Accion.cvc_Cancelar
                Call cvcManager.HandleCancelCVCRequest(UserIndex)
                
            ' El jugador indica que está listo para empezar
            Case mCVC_Accion.cvc_EstoyListo
                Call cvcManager.HandlePlay(UserIndex)
                
        End Select

    End With
    
End Sub


Private Sub HandleRetoBOT(ByVal Message As BinaryReader, ByVal UI As Integer)

    Dim BOT_Dificultad As Byte
    Dim BOT_Clase As Byte

    BOT_Dificultad = Message.ReadInt8
    BOT_Clase = Message.ReadInt8

    If BOT_Clase > 3 Then BOT_Clase = 1
    If BOT_Dificultad > 5 Then BOT_Dificultad = 5

    If UserList(UI).InBotID > 0 Then
        Call WriteConsoleMsg(UI, "Ya te encuentras peleando contra un bot.", FontTypeNames.FONTTYPE_INFO)
        Exit Sub
    End If

    Call m_ArenaBots.NuevoReto(UI, BOT_Dificultad, BOT_Clase)

End Sub
