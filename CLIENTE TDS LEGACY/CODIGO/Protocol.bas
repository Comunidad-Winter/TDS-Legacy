Attribute VB_Name = "Protocol"

Option Explicit

Private Const SEPARATOR As String * 1 = vbNullChar

Private LastPacket As Integer

Private IterationsHID As Integer

Private Const MAX_ITERATIONS_HID = 200

Private Enum ServerPacketID
    SetCuentaRegresiva = 0
    AddSlots = 1
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
    CharacterMove
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
    ErrorMsg
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
    setEfectoNick
    UpdateCharData
    InitWorking
    ShowSpecialForm

    QuestDetails
    QuestListSend

    CVCListSend
    
    PalabrasMagicas
    
    ShowCVCInvitation
    
    [PacketCount]

End Enum

Public Enum ClientPacketID

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
    RequestGuildLeaderInfo
    RequestAtributes
    RequestFame
    RequestSkills
    RequestMiniStats
    CommerceEnd
    UserCommerceEnd
    UserCommerceConfirm
    CommerceChat
    BankEnd
    UserCommerceOk
    UserCommerceReject
    Drop
    CastSpell
    LeftClick
    DoubleClick
    Work
    UseSpellMacro
    UseItem
    CraftBlacksmith
    CraftCarpenter
    WorkLeftClick
    CreateNewGuild
    EquipItem
    ChangeHeading
    ModifySkills
    Train
    CommerceBuy
    BankExtractItem
    CommerceSell
    BankDeposit
    MoveSpell
    MoveBank
    ClanCodexUpdate
    UserCommerceOffer
    GuildAcceptPeace
    GuildRejectAlliance
    GuildRejectPeace
    GuildAcceptAlliance
    GuildOfferPeace
    GuildOfferAlliance
    GuildAllianceDetails
    GuildPeaceDetails
    GuildRequestJoinerInfo
    GuildAlliancePropList
    GuildPeacePropList
    GuildDeclareWar
    GuildNewWebsite
    GuildAcceptNewMember
    GuildRejectNewMember
    GuildKickMember
    GuildUpdateNews
    GuildMemberInfo
    GuildOpenElections
    GuildRequestMembership
    GuildRequestDetails
    Online
    Quit
    GuildLeave
    RequestAccountState
    PetStand
    PetFollow
    ReleasePet
    TrainList
    Rest
    Meditate
    Resucitate
    Heal
    Help
    RequestStats
    CommerceStart
    BankStart
    Enlist
    Information
    Reward
    UpTime
    GuildMessage
    CentinelReport
    GuildOnline
    CouncilMessage
    RoleMasterRequest
    GMRequest
    ChangeDescription
    GuildVote
    Punishments
    ChangePassword
    Gamble
    LeaveFaction
    BankExtractGold
    BankDepositGold
    Denounce
    GuildFundate
    GuildFundation
    Ping
    InitCrafting
    ShowGuildNews
    ShareNpc
    StopSharingNpc
    Consulta
    Cheat
    ToggleCombatMode
    PartyLeave
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
    Fianza

    GMMessage
    ShowName
    OnlineRoyalArmy
    OnlineChaosLegion
    GoNearby
    serverTime
    Where
    CreaturesInMap
    WarpMeToTarget
    WarpChar
    Silence
    SOSShowList
    SOSRemove
    GoToChar
    Invisible
    GMPanel
    RequestUserList
    Working
    KillNPC
    Penar
    EditChar
    RequestCharInfo
    RequestCharStats
    RequestCharGold
    RequestCharInventory
    RequestCharBank
    RequestCharSkills
    ReviveChar
    OnlineGM
    OnlineMap
    Forgive
    Kick
    Execute
    banChar
    UnbanChar
    NPCFollow
    SummonChar
    SpawnListRequest
    SpawnCreature
    ResetNPCInventory
    CleanWorld
    ServerMessage
    nickToIP
    IPToNick
    GuildOnlineMembers
    TeleportCreate
    TeleportDestroy
    RainToggle
    SetCharDescription
    ForceMIDIToMap
    ForceWAVEToMap
    RoyalArmyMessage
    ChaosLegionMessage
    CitizenMessage
    CriminalMessage
    TalkAsNPC
    DestroyAllItemsInArea
    AcceptRoyalCouncilMember
    AcceptChaosCouncilMember
    ItemsInTheFloor
    MakeDumb
    MakeDumbNoMore
    CouncilKick
    SetTrigger
    AskTrigger
    BannedIPList
    BannedIPReload
    GuildMemberList
    GuildBan
    BanIP
    UnbanIP
    CreateItem
    DestroyItems
    ChaosLegionKick
    RoyalArmyKick
    ForceMIDIAll
    ForceWAVEAll
    RemovePunishment
    TileBlockedToggle
    KillNPCNoRespawn
    KillAllNearbyNPCs
    LastIP
    SystemMessage
    CreateNPC
    CreateNPCWithRespawn
    ServerOpenToUsersToggle
    TurnCriminal
    ResetFactions
    RemoveCharFromGuild
    RequestCharMail
    AlterPassword
    AlterMail
    AlterName
    ToggleCentinelActivated
    DoBackUp
    ShowGuildMessages
    SaveMap
    ChangeMapInfoPK
    ChangeMapInfoBackup
    ChangeMapInfoRestricted
    ChangeMapInfoNoMagic
    ChangeMapInfoNoInvi
    ChangeMapInfoNoResu
    ChangeMapInfoLand
    ChangeMapInfoZone
    SaveChars
    CleanSOS
    ShowServerForm
    KickAllChars
    ReloadNPCs
    ReloadServerIni
    ReloadSpells
    ReloadObjects
    ChatColor
    Ignored
    Conteo
    CrearTorneo
    SalirTorneo
    IngresarTorneo
    CancelarTorneo
    VerHD
    BanHD
    UnbanHD
    PartyTalk
    ChangeMapInfoNoInvocar
    FUN_PjFull
    FUN_GMFull
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
    CobrarCheque
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


Public Sub Encode(ByVal Message As BinaryReader)

    ' Here goes encode function
    
End Sub

Public Sub Decode(ByVal Message As BinaryReader)

    ' Here goes decode function
    
End Sub

''
' Handles incoming data.
Public Sub handle(ByVal Message As BinaryReader)    '(ByVal Message As Network.Reader) As Boolean

    While (Message.GetAvailable() > 0)

        Dim PacketID As Long

20      PacketID = Message.ReadInt

        If Not PacketID = LastPacket Then
            'Debug.Print Now, PacketID
        End If

        LastPacket = PacketID

        Select Case PacketID

        Case ServerPacketID.ShowCVCInvitation
            Call HandleShowCVCInvitation(Message)

        Case ServerPacketID.BonifStatus
            Call HandleBonifStatus(Message)

        Case ServerPacketID.SetCuentaRegresiva
            Call HandleSetCuentaRegresiva(Message)

        Case ServerPacketID.Intervalos
            Call HandleIntervalos(Message)

        Case ServerPacketID.UpdateFaccion
            Call HandleUpdateFaccion(Message)

        Case ServerPacketID.CharacterChangeBody
            Call HandleCharacterChangeBody(Message)

        Case ServerPacketID.CharacterChangeWeapon
            Call HandleCharacterChangeWeapon(Message)

        Case ServerPacketID.CharacterChangeHelmet
            Call HandleCharacterChangeHelmet(Message)

        Case ServerPacketID.CharacterChangeShield
            Call HandleCharacterChangeShield(Message)

        Case ServerPacketID.CharacterChangeSpecial
            Call HandleCharacterChangeSpecial(Message)

        Case ServerPacketID.UpdateStatsNew
            Call HandleUpdateStatsNew(Message)

        Case ServerPacketID.SendPartyData
            Call HandleSendPartyData(Message)

        Case ServerPacketID.PartyDetail
            Call HandlePartyDetails(Message)

        Case ServerPacketID.PartyExit
            Call HandlePartyExit(Message)

        Case ServerPacketID.MensajeShort
            Call HandleMensajeshort(Message)

        Case ServerPacketID.SetCombatMode
            Call HandleSetCombatMode(Message)

        Case ServerPacketID.logged        ' LOGGED
            Call HandleLogged(Message)

        Case ServerPacketID.CreateDamage        ' CDMG
            Call HandleCreateDamage(Message)

        Case ServerPacketID.Connected
            Call HandleConnected(Message)

        Case ServerPacketID.CreateProjectile
            Call HandleCreateProjectile(Message)

        Case ServerPacketID.RemoveDialogs        ' QTDL
            Call HandleRemoveDialogs(Message)

        Case ServerPacketID.RemoveCharDialog        ' QDL
            Call HandleRemoveCharDialog(Message)

        Case ServerPacketID.NavigateToggle        ' NAVEG
            Call HandleNavigateToggle(Message)

        Case ServerPacketID.Disconnect        ' FINOK
            Call HandleDisconnect

        Case ServerPacketID.CommerceEnd        ' FINCOMOK
            Call HandleCommerceEnd(Message)

        Case ServerPacketID.CommerceChat
            Call HandleCommerceChat(Message)

        Case ServerPacketID.BankEnd        ' FINBANOK
            Call HandleBankEnd(Message)

        Case ServerPacketID.CommerceInit        ' INITCOM
            Call HandleCommerceInit(Message)

        Case ServerPacketID.BankInit        ' INITBANCO
            Call HandleBankInit(Message)

        Case ServerPacketID.UserCommerceInit        ' INITCOMUSU
            Call HandleUserCommerceInit(Message)

        Case ServerPacketID.UserCommerceEnd        ' FINCOMUSUOK
            Call HandleUserCommerceEnd(Message)

        Case ServerPacketID.UserOfferConfirm
            Call HandleUserOfferConfirm(Message)

        Case ServerPacketID.ShowBlacksmithForm        ' SFH
            Call HandleShowBlacksmithForm(Message)

        Case ServerPacketID.ShowCarpenterForm        ' SFC
            Call HandleShowCarpenterForm(Message)

        Case ServerPacketID.UpdateSta        ' ASS
            Call HandleUpdateSta(Message)

        Case ServerPacketID.UpdateMana        ' ASM
            Call HandleUpdateMana(Message)

        Case ServerPacketID.UpdateHP        ' ASH
            Call HandleUpdateHP(Message)

        Case ServerPacketID.UpdateGold        ' ASG
            Call HandleUpdateGold(Message)

        Case ServerPacketID.UpdateBankGold
            Call HandleUpdateBankGold(Message)

        Case ServerPacketID.UpdateExp        ' ASE
            Call HandleUpdateExp(Message)

        Case ServerPacketID.ChangeMap        ' CM
            Call HandleChangeMap(Message)

        Case ServerPacketID.PosUpdate        ' PU
            Call HandlePosUpdate(Message)

        Case ServerPacketID.ChatOverHead        ' ||
            Call HandleChatOverHead(Message)

        Case ServerPacketID.ConsoleMsg        ' || - Beware!! its the same as above, but it was properly splitted
            Call HandleConsoleMessage(Message)

        Case ServerPacketID.GuildChat        ' |+
            Call HandleGuildChat(Message)

        Case ServerPacketID.ShowMessageBox        ' !!
            Call HandleShowMessageBox(Message)

        Case ServerPacketID.UserIndexInServer        ' IU
            Call HandleUserIndexInServer(Message)

        Case ServerPacketID.UserCharIndexInServer        ' IP
            Call HandleUserCharIndexInServer(Message)

        Case ServerPacketID.CharacterCreate        ' CC
            Call HandleCharacterCreate(Message)

        Case ServerPacketID.CharacterRemove        ' BP
            Call HandleCharacterRemove(Message)

        Case ServerPacketID.CharacterChangeNick
            Call HandleCharacterChangeNick(Message)

        Case ServerPacketID.CharacterMove        ' MP, +, * and _ '
            Call HandleCharacterMove(Message)

        Case ServerPacketID.ForceCharMove
            Call HandleForceCharMove(Message)

        Case ServerPacketID.CharacterChange        ' CP
            Call HandleCharacterChange(Message)

        Case ServerPacketID.ObjectCreate        ' HO
            Call HandleObjectCreate(Message)

        Case ServerPacketID.ObjectDelete        ' BO
            Call HandleObjectDelete(Message)

        Case ServerPacketID.BlockPosition        ' BQ
            Call HandleBlockPosition(Message)

        Case ServerPacketID.PlayMIDI        ' TM
            Call HandlePlayMIDI(Message)

        Case ServerPacketID.PlayWave        ' TW
            Call HandlePlayWave(Message)

        Case ServerPacketID.guildList        ' GL
            Call HandleGuildList(Message)

        Case ServerPacketID.AreaChanged        ' CA
            Call HandleAreaChanged(Message)

        Case ServerPacketID.PauseToggle        ' BKW
            Call HandlePauseToggle(Message)

        Case ServerPacketID.RainToggle        ' LLU
            Call HandleRainToggle(Message)

        Case ServerPacketID.CreateFX        ' CFX
            Call HandleCreateFX(Message)

        Case ServerPacketID.UpdateUserStats        ' EST
            Call HandleUpdateUserStats(Message)

        Case ServerPacketID.WorkRequestTarget        ' T01
            Call HandleWorkRequestTarget(Message)

        Case ServerPacketID.ChangeInventorySlot        ' CSI
            Call HandleChangeInventorySlot(Message)

        Case ServerPacketID.ChangeBankSlot        ' SBO
            Call HandleChangeBankSlot(Message)

        Case ServerPacketID.ChangeSpellSlot        ' SHS
            Call HandleChangeSpellSlot(Message)

        Case ServerPacketID.Atributes        ' ATR
            Call HandleAtributes(Message)

        Case ServerPacketID.BlacksmithWeapons        ' LAH
            Call HandleBlacksmithWeapons(Message)

        Case ServerPacketID.BlacksmithArmors        ' LAR
            Call HandleBlacksmithArmors(Message)

        Case ServerPacketID.CarpenterObjects        ' OBR
            Call HandleCarpenterObjects(Message)

        Case ServerPacketID.RestOK        ' DOK
            Call HandleRestOK(Message)

        Case ServerPacketID.ErrorMsg        ' ERR
            Call HandleErrorMessage(Message)

        Case ServerPacketID.Blind        ' CEGU
            Call HandleBlind(Message)

        Case ServerPacketID.Dumb        ' DUMB
            Call HandleDumb(Message)

        Case ServerPacketID.ShowSignal        ' MCAR
            Call HandleShowSignal(Message)

        Case ServerPacketID.ChangeNPCInventorySlot        ' NPCI
            Call HandleChangeNPCInventorySlot(Message)

        Case ServerPacketID.UpdateHungerAndThirst        ' EHYS
            Call HandleUpdateHungerAndThirst(Message)

        Case ServerPacketID.Fame        ' FAMA
            Call HandleFame(Message)

        Case ServerPacketID.MiniStats        ' MEST
            Call HandleMiniStats(Message)

        Case ServerPacketID.LevelUp        ' SUNI
            Call HandleLevelUp(Message)

        Case ServerPacketID.SetInvisible        ' NOVER
            Call HandleSetInvisible(Message)

        Case ServerPacketID.DiceRoll        ' DADOS
            Call HandleDiceRoll(Message)

        Case ServerPacketID.MeditateToggle        ' MEDOK
            Call HandleMeditateToggle(Message)

        Case ServerPacketID.BlindNoMore        ' NSEGUE
            Call HandleBlindNoMore(Message)

        Case ServerPacketID.DumbNoMore        ' NESTUP
            Call HandleDumbNoMore(Message)

        Case ServerPacketID.SendSkills        ' SKILLS
            Call HandleSendSkills(Message)

        Case ServerPacketID.TrainerCreatureList        ' LSTCRI
            Call HandleTrainerCreatureList(Message)

        Case ServerPacketID.guildNews        ' GUILDNE
            Call HandleGuildNews(Message)

        Case ServerPacketID.OfferDetails        ' PEACEDE and ALLIEDE
            Call HandleOfferDetails(Message)

        Case ServerPacketID.AlianceProposalsList        ' ALLIEPR
            Call HandleAlianceProposalsList(Message)

        Case ServerPacketID.PeaceProposalsList        ' PEACEPR
            Call HandlePeaceProposalsList(Message)

        Case ServerPacketID.CharacterInfo        ' CHRINFO
            Call HandleCharacterInfo(Message)

        Case ServerPacketID.GuildLeaderInfo        ' LEADERI
            Call HandleGuildLeaderInfo(Message)

        Case ServerPacketID.GuildDetails        ' CLANDET
            Call HandleGuildDetails(Message)

        Case ServerPacketID.ShowGuildFundationForm        ' SHOWFUN
            Call HandleShowGuildFundationForm(Message)

        Case ServerPacketID.ParalizeOK        ' PARADOK
            Call HandleParalizeOK(Message)

        Case ServerPacketID.ShowUserRequest        ' PETICIO
            Call HandleShowUserRequest(Message)

        Case ServerPacketID.TradeOK        ' TRANSOK
            Call HandleTradeOK(Message)

        Case ServerPacketID.BankOK        ' BANCOOK
            Call HandleBankOK(Message)

        Case ServerPacketID.ChangeUserTradeSlot        ' COMUSUINV
            Call HandleChangeUserTradeSlot(Message)

        Case ServerPacketID.Pong
            Call HandlePong(Message)

        Case ServerPacketID.UpdateTagAndStatus
            Call HandleUpdateTagAndStatus(Message)

        Case ServerPacketID.SpawnList        ' SPL
            Call HandleSpawnList(Message)

        Case ServerPacketID.ShowSOSForm        ' RSOS and MSOS
            Call HandleShowSOSForm(Message)

        Case ServerPacketID.ShowGMPanelForm        ' ABPANEL
            Call HandleShowGMPanelForm(Message)

        Case ServerPacketID.UserNameList        ' LISTUSU
            Call HandleUserNameList(Message)

        Case ServerPacketID.UpdateStrenghtAndDexterity
            Call HandleUpdateStrenghtAndDexterity(Message)

        Case ServerPacketID.UpdateStrenght
            Call HandleUpdateStrenght(Message)

        Case ServerPacketID.UpdateDexterity
            Call HandleUpdateDexterity(Message)

        Case ServerPacketID.UpdateEnvenenado
            Call HandleUpdateEnvenenado(Message)

        Case ServerPacketID.AddSlots
            Call HandleAddSlots(Message)

        Case ServerPacketID.MultiMessage
            Call HandleMultiMessage(Message)

        Case ServerPacketID.StopWorking
            Call HandleStopWorking(Message)

        Case ServerPacketID.CancelOfferItem
            Call HandleCancelOfferItem(Message)

        Case ServerPacketID.MovimientSW
            Call HandleMovimientSW(Message)

        Case ServerPacketID.CloseClient
            Call HandleCloseClient(Message)

2970    Case ServerPacketID.ChangeHeading
2980        Call HandleChangeHeading(Message)

3170    Case ServerPacketID.CharacterMove_NORTH
3180        Call HandleCharacterMoves(Message, E_Heading.NORTH)

3190    Case ServerPacketID.CharacterMove_EAST
3200        Call HandleCharacterMoves(Message, E_Heading.EAST)

3210    Case ServerPacketID.CharacterMove_SOUTH
3220        Call HandleCharacterMoves(Message, E_Heading.SOUTH)

3230    Case ServerPacketID.CharacterMove_WEST
3240        Call HandleCharacterMoves(Message, E_Heading.WEST)

        Case ServerPacketID.ShowBorrarPjForm
            Call HandleShowBorrarPjForm(Message)

        Case ServerPacketID.BorrarMensajeConsola
            Call HandleBorrarMensajeConsola(Message)

        Case ServerPacketID.ShowResetearPjForm
            Call HandleShowResetearPjForm(Message)

        Case ServerPacketID.setEfectoNick
            Call HandleSetEfectoNick(Message)

        Case ServerPacketID.UpdateCharData
            Call HandleUpdateCharData(Message)

        Case ServerPacketID.InitWorking
            Call HandleInitWorking(Message)

        Case ServerPacketID.ShowSpecialForm
            Call HandleShowSpecialForm(Message)

2270    Case ServerPacketID.QuestDetails
2280        Call HandleQuestDetails(Message)

2290    Case ServerPacketID.QuestListSend
2300        Call HandleQuestListSend(Message)

        Case ServerPacketID.CVCListSend
            Call HandleCVCListSend(Message)

        Case ServerPacketID.PalabrasMagicas
3020        Call HandleDecirPalabrasMagicas(Message)

        Case Else
            Exit Sub
        End Select
    Wend

End Sub

Public Sub HandleMultiMessage(ByVal Message As BinaryReader)

    On Error GoTo HandleMultiMessage_Err

    Dim BodyPart As Integer

    Dim Daño As Integer

    Dim SpellIndex As Integer

    Dim nombre As String

    Select Case Message.ReadInt

    Case eMessages.Hechizo_HechiceroMSG_NOMBRE

        nombre = Message.ReadString16

        If LastSpell > 0 Then
            SpellIndex = UserHechizos(LastSpell)
        End If

        If SpellIndex < 1 Or SpellIndex > NumSpells Then Exit Sub

        Call ShowConsoleMsg(Trim$(DataSpells(SpellIndex).HechiceroMsg) & " " & nombre & ".", 255, 0, 0, True)

    Case eMessages.Hechizo_HechiceroMSG_ALGUIEN

        SpellIndex = UserHechizos(LastSpell)

        If SpellIndex < 1 Or SpellIndex > NumSpells Then Exit Sub

        Call ShowConsoleMsg(DataSpells(SpellIndex).HechiceroMsg & " alguien.", 255, 0, 0, True)

    Case eMessages.Hechizo_HechiceroMSG_CRIATURA

        If Not SegActive Then
            If LastSpell < 1 Then Exit Sub
            SpellIndex = UserHechizos(LastSpell)
        Else
            SpellIndex = UserHechizos(hlst.ListIndex + 1)
        End If

        If SpellIndex < 1 Or SpellIndex > NumSpells Then Exit Sub

        If SpellIndex > 25 And SpellIndex < 29 Then
            Call ShowConsoleMsg(DataSpells(SpellIndex).HechiceroMsg, 255, 0, 0, True)
        Else
            Call ShowConsoleMsg(Trim$(DataSpells(SpellIndex).HechiceroMsg) & " la criatura.", 255, 0, 0, True)
        End If

    Case eMessages.Hechizo_PropioMSG

        SpellIndex = UserHechizos(LastSpell)

        If SpellIndex < 1 Or SpellIndex > NumSpells Then Exit Sub

        If SpellIndex = 1 Then Envenenado = 0

        Call ShowConsoleMsg(DataSpells(SpellIndex).PropioMsg, 255, 0, 0, True)


    Case eMessages.Hechizo_TargetMSG

        SpellIndex = Message.ReadInt8
        nombre = Message.ReadString16

        If SpellIndex < 1 Or SpellIndex > NumSpells Then Exit Sub

        If SpellIndex = 1 Then Envenenado = 0

        Call ShowConsoleMsg(nombre & " " & DataSpells(SpellIndex).TargetMsg, 255, 0, 0, True)

    Case eMessages.DontSeeAnything
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_NO_VES_NADA_INTERESANTE, 65, 190, 156, False, False, True)

    Case eMessages.NPCSwing
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_CRIATURA_FALLA_GOLPE, 255, 0, 0, True, False, True)

    Case eMessages.NPCKillUser
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_CRIATURA_MATADO, 255, 0, 0, True, False, True)

    Case eMessages.BlockedWithShieldUser
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_RECHAZO_ATAQUE_ESCUDO, 255, 0, 0, True, False, True)

    Case eMessages.BlockedWithShieldOther
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_USUARIO_RECHAZO_ATAQUE_ESCUDO, 255, 0, 0, True, False, True)

    Case eMessages.UserSwing
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_FALLADO_GOLPE, 255, 0, 0, True, False, True)

    Case eMessages.SafeModeOn
        Call frmMain.ControlSM(eSMType.sSafemode, True)

    Case eMessages.SafeModeOff
        Call frmMain.ControlSM(eSMType.sSafemode, False)

    Case eMessages.SafeDragModeOn
        Call frmMain.ControlSM(eSMType.sDSafemode, True)

    Case eMessages.SafeDragModeOff
        Call frmMain.ControlSM(eSMType.sDSafemode, False)

    Case eMessages.ResuscitationSafeOff
        Call frmMain.ControlSM(eSMType.sResucitation, False)

    Case eMessages.ResuscitationSafeOn
        Call frmMain.ControlSM(eSMType.sResucitation, True)

    Case eMessages.NobilityLost
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PIERDE_NOBLEZA, 255, 0, 0, False, False, True)

    Case eMessages.CantUseWhileMeditating
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_USAR_MEDITANDO, 255, 0, 0, False, False, True)

    Case eMessages.NPCHitUser

        Select Case Message.ReadInt

        Case bCabeza
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_CABEZA & CStr(Message.ReadInt()) & "!!", 255, 0, 0, True, False, True)

        Case bBrazoIzquierdo
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_BRAZO_IZQ & CStr(Message.ReadInt()) & "!!", 255, 0, 0, True, False, True)

        Case bBrazoDerecho
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_BRAZO_DER & CStr(Message.ReadInt()) & "!!", 255, 0, 0, True, False, True)

        Case bPiernaIzquierda
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_PIERNA_IZQ & CStr(Message.ReadInt()) & "!!", 255, 0, 0, True, False, True)

        Case bPiernaDerecha
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_PIERNA_DER & CStr(Message.ReadInt()) & "!!", 255, 0, 0, True, False, True)

        Case bTorso
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_TORSO & CStr(Message.ReadInt() & "!!"), 255, 0, 0, True, False, True)

        End Select

    Case eMessages.UserHitNPC
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_GOLPE_CRIATURA_1 & CStr(Message.ReadInt32()) & MENSAJE_2, 255, 0, 0, True, False, True)

    Case eMessages.UserAttackedSwing
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & charlist(Message.ReadInt()).nombre & MENSAJE_ATAQUE_FALLO, 255, 0, 0, True, False, True)

    Case eMessages.UserHittedByUser

        Dim AttackerName As String

        AttackerName = GetRawName(charlist(Message.ReadInt()).nombre)
        BodyPart = Message.ReadInt()
        Daño = Message.ReadInt()

        Select Case BodyPart

        Case bCabeza
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_CABEZA & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bBrazoIzquierdo
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_BRAZO_IZQ & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bBrazoDerecho
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_BRAZO_DER & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bPiernaIzquierda
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_PIERNA_IZQ & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bPiernaDerecha
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_PIERNA_DER & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bTorso
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_1 & AttackerName & MENSAJE_RECIVE_IMPACTO_TORSO & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        End Select

    Case eMessages.UserHittedUser

        Dim VictimName As String

        VictimName = GetRawName(charlist(Message.ReadInt()).nombre)
        BodyPart = Message.ReadInt()
        Daño = Message.ReadInt()

        Select Case BodyPart

        Case bCabeza
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_CABEZA & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bBrazoIzquierdo
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_BRAZO_IZQ & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bBrazoDerecho
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_BRAZO_DER & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bPiernaIzquierda
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_PIERNA_IZQ & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bPiernaDerecha
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_PIERNA_DER & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        Case bTorso
            Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_PRODUCE_IMPACTO_1 & VictimName & MENSAJE_PRODUCE_IMPACTO_TORSO & Daño & MENSAJE_2, 255, 0, 0, True, False, True)

        End Select

    Case eMessages.WorkRequestTarget
        UsingSkill = Message.ReadInt()

        frmMain.MousePointer = 2
        If Not frmMain.macrotrabajo.Enabled Then


            Select Case UsingSkill

            Case Magia
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_MAGIA, 100, 100, 120, 0, 0)

            Case Pesca
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_PESCA, 100, 100, 120, 0, 0)

            Case Robar
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_ROBAR, 100, 100, 120, 0, 0)

            Case Talar
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_TALAR, 100, 100, 120, 0, 0)

            Case Mineria
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_MINERIA, 100, 100, 120, 0, 0)

            Case FundirMetal
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_FUNDIRMETAL, 100, 100, 120, 0, 0)

            Case Proyectiles
                Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_PROYECTILES, 100, 100, 120, 0, 0)

            End Select
        End If

    Case eMessages.HaveKilledUser

        Call ShowConsoleMsg(MENSAJE_HAS_MATADO_A & charlist(Message.ReadInt).nombre & MENSAJE_22, 255, 0, 0, True)
        Dim qExp As Double
        qExp = Message.ReadInt32
        If qExp Then
            Call ShowConsoleMsg(MENSAJE_HAS_GANADO_EXPE_1 & qExp & MENSAJE_HAS_GANADO_EXPE_2, 255, 0, 0, True)
        End If
        
    Case eMessages.UserKill
        Call ShowConsoleMsg(charlist(Message.ReadInt).nombre & MENSAJE_TE_HA_MATADO, 255, 0, 0, True)

    Case eMessages.EarnExp
        Call ShowConsoleMsg(MENSAJE_HAS_GANADO_EXPE_1 & Message.ReadInt32 & MENSAJE_HAS_GANADO_EXPE_2, 255, 0, 0, True)

    End Select

    Exit Sub
HandleMultiMessage_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleMultiMessage", Erl)

End Sub

''
' Handles the Logged message.
Public Sub HandleLogged(ByVal Message As BinaryReader)

    On Error GoTo HandleLogged_Err

    Dim clan As String

    IntClickU = Message.ReadInt

    clan = Message.ReadString16

    Dim X As Long

    For X = 0 To 8
        frmMain.lblName(X).Caption = UserName & IIf(Len(clan) <> 0, vbNewLine & "<" & clan & ">", "")
    Next X

    ' Variable initialization
    EngineRun = True
    Nombres = True

    MainWindowState = 0

    Call Inventario.UpdateAllSlots

    Call SetConnected
    
    'Call Audio.StopMidi

    AlphaTecho = 255
    LogAlpha = 255
    Unload frmCrearPersonaje

    Exit Sub
HandleLogged_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleLogged", Erl)

End Sub

Public Sub HandleIntervalos(ByVal Message As BinaryReader)

    On Error GoTo HandleIntervalos_Err

    INT_ATTACK = Message.ReadInt + 1
    INT_ARROWS = Message.ReadInt + 1
    INT_CAST_SPELL = Message.ReadInt + 1
    INT_CAST_ATTACK = Message.ReadInt + 1
    INT_ATTACK_CAST = Message.ReadInt + 1

    INT_WORK = Message.ReadInt
    INT_USEITEMU = Message.ReadInt + 1
    INT_MACRO_TRABAJO = INT_WORK + CLng(INT_WORK / 100)
    INT_SENTRPU = INT_MACRO_TRABAJO

    INT_USEITEMDCK = Message.ReadInt + 1    '175

    Call MainTimer.SetInterval(TimersIndex.Attack, INT_ATTACK)
    Call MainTimer.SetInterval(TimersIndex.Work, INT_WORK)
    Call MainTimer.SetInterval(TimersIndex.UseItemWithU, INT_USEITEMU)
    Call MainTimer.SetInterval(TimersIndex.UseItemWithDblClick, INT_USEITEMDCK)
    Call MainTimer.SetInterval(TimersIndex.SendRPU, INT_SENTRPU)
    Call MainTimer.SetInterval(TimersIndex.CastSpell, INT_CAST_SPELL)
    Call MainTimer.SetInterval(TimersIndex.Arrows, INT_ARROWS)
    Call MainTimer.SetInterval(TimersIndex.CastAttack, INT_CAST_ATTACK)
    Call MainTimer.SetInterval(TimersIndex.ChangeHeading, INT_CHANGE_HEADING)
    Call MainTimer.SetInterval(TimersIndex.AttackCast, INT_ATTACK_CAST)

    frmMain.macrotrabajo.interval = INT_MACRO_TRABAJO
    frmMain.macrotrabajo.Enabled = False

    'Init timers
    Call MainTimer.Start(TimersIndex.Attack)
    Call MainTimer.Start(TimersIndex.Work)
    Call MainTimer.Start(TimersIndex.UseItemWithU)
    Call MainTimer.Start(TimersIndex.UseItemWithDblClick)
    Call MainTimer.Start(TimersIndex.SendRPU)
    Call MainTimer.Start(TimersIndex.CastSpell)

    Call MainTimer.Start(TimersIndex.Arrows)
    Call MainTimer.Start(TimersIndex.CastAttack)
    Call MainTimer.Start(TimersIndex.AttackCast)
    Call MainTimer.Start(TimersIndex.ChangeHeading)

    Exit Sub
HandleIntervalos_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleIntervalos", Erl)

End Sub

Public Sub HandleBonifStatus(ByVal Message As BinaryReader)

    On Error GoTo HandleBonifStatus_Err

    LeveleandoTick = Message.ReadInt
    tBonif = Message.ReadInt

    If Not ShowBonusExpTimeleft Then
        If RandomNumber(1, 30) = 1 Then
            Call ShowConsoleMsg("Recordatorio: Para activar/desactivar y ver el tiempo de exp bonus escribe /BONUS")

        End If

    End If

    Exit Sub
HandleBonifStatus_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBonifStatus", Erl)

End Sub

''
' Handles the RemoveDialogs message.
Public Sub HandleRemoveDialogs(ByVal Message As BinaryReader)

    On Error GoTo HandleRemoveDialogs_Err

    Call Dialogos.RemoveAllDialogs
    Exit Sub
HandleRemoveDialogs_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleRemoveDialogs", Erl)

End Sub

''
' Handles the RemoveCharDialog message.
Public Sub HandleRemoveCharDialog(ByVal Message As BinaryReader)

    On Error GoTo HandleRemoveCharDialog_Err

    Call Dialogos.RemoveDialog(Message.ReadInt())
    Exit Sub
HandleRemoveCharDialog_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleRemoveCharDialog", Erl)

End Sub

''
' Handles the NavigateToggle message.
Public Sub HandleNavigateToggle(ByVal Message As BinaryReader)

    On Error GoTo HandleNavigateToggle_Err

    UserNavegando = Not UserNavegando
    Exit Sub
HandleNavigateToggle_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleNavigateToggle", Erl)

End Sub

''
' Handles the Disconnect message.
Public Sub HandleDisconnect()

    On Error GoTo HandleDisconnect_Err

    Dim i As Long


    'Close connection
    frmMain.timerAntiCuelgue.Enabled = False

    'Hide main form
    frmMain.visible = False
    
    'Stop audio
    Call modEngine_Audio.Halt
    frmMain.IsPlaying = PlayLoop.plNone

    PanelQuitVisible = False
    PanelCrearPJVisible = False

    'Show connection form
    frmConnect.visible = True
    frmConnect.QuieroCrearPj = False

    Call Engine_Long_To_RGB_List(lvalue(), Engine_Change_Alpha(lvalue(), 255))

    Mod_Declaraciones.Connected = False
    Call modConectarCaida.IniciarCaida(0)

    FramesPerSecCounter = 0
    fpsLastCheck = 0

    'Reset global vars
    UserDescansar = False
    UserParalizado = False
    pausa = False
    Envenenado = False
    CountTime = 0

    CountFinish = 0

    UserCiego = False
    UserMeditar = False
    UserNavegando = False
    bRain = False
    bFogata = False
    SkillPoints = 0
    Comerciando = False
    RAYOS_X = False

    LastKeyUseItem = 0
    LastKeyDropObj = 0


    'Delete all kind of dialogs
    Call CleanDialogs

    'Reset some char variables...
    For i = 1 To LastChar
        charlist(i).Invisible = False
        charlist(i).Oculto = False
    Next i

    '''''
    'On Local Error GoTo 0

    If frmOldPersonaje.visible Then
        frmOldPersonaje.Label1.visible = False

    End If

    If Not frmCrearPersonaje.visible Then
        If frmConnect.visible = False Then
            frmConnect.Show

            FramesPerSecCounter = 0
            fpsLastCheck = 0

            PanelQuitVisible = False
            PanelCrearPJVisible = False
            ModoCaida = 0
            Caida = 0

        End If

    End If

    SKAssigned = ""
    Call resetGuiData

    frmMain.visible = False

    pausa = False
    UserMeditar = False

    UserEmail = "@"
    UserClase = eClass.Assasin
    UserSexo = eGenero.Hombre
    UserRaza = eRaza.Humano
    UserHogar = cUllathorpe

    For i = 1 To NUMSKILLS
        UserSkills(i) = 0
    Next i

    For i = 1 To NUMATRIBUTOS
        UserAtributos(i) = 0
    Next i

    'aca
    frmMain.macrotrabajo.Enabled = False
    MainVisible = False

    SegActive = False
    CharSeg = 0


    SkillPoints = 0
    Alocados = 0

    LastPotion = 0

    ''''


    'Unload all forms except frmMain and frmConnect
    Dim frm As Form

    For Each frm In Forms

        If frm.Name <> frmMain.Name And frm.Name <> frmConnect.Name And frm.Name <> frmMensaje.Name Then
            Unload frm

        End If

    Next

    For i = 1 To MAX_INVENTORY_SLOTS
        Call Inventario.SetItem(i, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "")
    Next i

    
    Call modEngine_Audio.PlayMusic("78.MID") 'Call Audio.PlayMIDI("78.MID")

    UserCharIndex = 0

    Exit Sub
HandleDisconnect_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleDisconnect", Erl)

End Sub

''
' Handles the CommerceEnd message.
Public Sub HandleCommerceEnd(ByVal Message As BinaryReader)

    On Error GoTo HandleCommerceEnd_Err

    'Reset vars
    Comerciando = False

    'Hide form

    Unload frmComerciar

    Exit Sub
HandleCommerceEnd_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCommerceEnd", Erl)

End Sub

''
' Handles the BankEnd message.
Public Sub HandleBankEnd(ByVal Message As BinaryReader)

    On Error GoTo HandleBankEnd_Err

    Set InvBanco(0) = Nothing
    Set InvBanco(1) = Nothing

    Unload frmBancoObj
    Comerciando = False
    Exit Sub
HandleBankEnd_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBankEnd", Erl)

End Sub

''
' Handles the CommerceInit message.
Public Sub HandleCommerceInit(ByVal Message As BinaryReader)

    On Error GoTo HandleCommerceInit_Err

    Dim i As Long

    ' Initialize commerce inventories
    Call InvComUsu.Initialize(DirectD3D8, frmComerciar.picUsuario, Inventario.MaxObjs)
    Call InvComNpc.Initialize(DirectD3D8, frmComerciar.picComerciar, MAX_NPC_INVENTORY_SLOTS)

    'Fill user inventory
    For i = 1 To MAX_INVENTORY_SLOTS

        If Inventario.ObjIndex(i) <> 0 Then

            With Inventario
                Call InvComUsu.SetItem(i, .ObjIndex(i), .amount(i), .Equipped(i), .GrhIndex(i), .ObjType(i), .MaxHit(i), .MinHit(i), .MaxDef(i), .MinDef(i), .Valor(i), .ItemName(i))

            End With

        End If

    Next i

    ' Fill Npc inventory
    For i = 1 To 50

        If NPCInventory(i).ObjIndex <> 0 Then

            With NPCInventory(i)
                Call InvComNpc.SetItem(i, .ObjIndex, .amount, 0, .GrhIndex, .ObjType, .MaxHit, .MinHit, .MaxDef, .MinDef, .Valor, .Name)

            End With

        End If

    Next i

    'Set state and show form

    Comerciando = True
    frmComerciar.Show , frmMain
    Exit Sub
HandleCommerceInit_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCommerceInit", Erl)

End Sub

''
' Handles the BankInit message.

Public Sub HandleBankInit(ByVal Message As BinaryReader)

    On Error GoTo HandleBankInit_Err

    Dim i As Long

    Dim BankGold As Long

    BankGold = Message.ReadInt32
    Call InvBanco(0).Initialize(DirectD3D8, frmBancoObj.picBoveda, MAX_BANCOINVENTORY_SLOTS)
    Call InvBanco(1).Initialize(DirectD3D8, frmBancoObj.picUser, Inventario.MaxObjs)

    For i = 1 To Inventario.MaxObjs

        With Inventario
            Call InvBanco(1).SetItem(i, .ObjIndex(i), .amount(i), .Equipped(i), .GrhIndex(i), .ObjType(i), .MaxHit(i), .MinHit(i), .MaxDef(i), .MinDef(i), .Valor(i), .ItemName(i))

        End With

    Next i

    For i = 1 To MAX_BANCOINVENTORY_SLOTS

        With UserBancoInventory(i)
            Call InvBanco(0).SetItem(i, .ObjIndex, .amount, .Equipped, .GrhIndex, .ObjType, .MaxHit, .MinHit, .MaxDef, .MinDef, .Valor, .Name)

        End With

    Next i

    'Set state and show form
    Comerciando = True

    'frmBancoObj.Label2.Caption = BankGold

    frmBancoObj.Show , frmMain
    Exit Sub
HandleBankInit_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBankInit", Erl)

End Sub

''
' Handles the UserCommerceInit message.

Public Sub HandleUserCommerceInit(ByVal Message As BinaryReader)

    On Error GoTo HandleUserCommerceInit_Err

    Dim i As Long

    TradingUserName = Message.ReadString16

    frmComerciarUsu.OroActual = UserGLD
    frmComerciarUsu.lblOroCurrent = IIf(frmComerciarUsu.OroActual = 0, "0", format$(frmComerciarUsu.OroActual, "###,###,###"))

    ' Initialize commerce inventories
    Call InvComUsu.Initialize(DirectD3D8, frmComerciarUsu.picInvComercio, Inventario.MaxObjs)


    Call InvOfferComUsu(0).Initialize(DirectD3D8, frmComerciarUsu.picInvOfertaProp, INV_OFFER_SLOTS)
    Call InvOfferComUsu(1).Initialize(DirectD3D8, frmComerciarUsu.picInvOfertaOtro, INV_OFFER_SLOTS)

    'Fill user inventory
    For i = 1 To MAX_INVENTORY_SLOTS

        If Inventario.ObjIndex(i) <> 0 Then

            With Inventario
                Call InvComUsu.SetItem(i, .ObjIndex(i), .amount(i), .Equipped(i), .GrhIndex(i), .ObjType(i), .MaxHit(i), .MinHit(i), .MaxDef(i), .MinDef(i), .Valor(i), .ItemName(i))

            End With

        End If

    Next i

    'Set state and show form
    Comerciando = True

    Call frmComerciarUsu.Show(vbModeless, frmMain)

    Exit Sub
HandleUserCommerceInit_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserCommerceInit", Erl)

End Sub

''
' Handles the UserCommerceEnd message.

Public Sub HandleUserCommerceEnd(ByVal Message As BinaryReader)

    On Error GoTo HandleUserCommerceEnd_Err

    Set InvComUsu = Nothing
    Set InvOfferComUsu(0) = Nothing
    Set InvOfferComUsu(1) = Nothing

    'Destroy the form and reset the state

    Unload frmComerciarUsu
    Comerciando = False
    Exit Sub
HandleUserCommerceEnd_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserCommerceEnd", Erl)

End Sub

''
' Handles the UserOfferConfirm message.
Public Sub HandleUserOfferConfirm(ByVal Message As BinaryReader)

    On Error GoTo HandleUserOfferConfirm_Err

    With frmComerciarUsu
        ' Now he can accept the offer or reject it
        .HabilitarAceptarRechazar True
        ' .lblOroOtro.Visible = False

        .PrintCommerceMsg TradingUserName & " ha confirmado su oferta!", FontTypeNames.FONTTYPE_CONSE

    End With

    Exit Sub
HandleUserOfferConfirm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserOfferConfirm", Erl)

End Sub

''
' Handles the ShowBlacksmithForm message.
Public Sub HandleShowBlacksmithForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowBlacksmithForm_Err

    If frmMain.macrotrabajo.Enabled And (MacroBltIndex > 0) Then
        Call WriteCraftBlacksmith(MacroBltIndex)
    Else

        frmHerrero.Show , frmMain

    End If

    Exit Sub
HandleShowBlacksmithForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowBlacksmithForm", Erl)

End Sub

''
' Handles the ShowCarpenterForm message.
Public Sub HandleShowCarpenterForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowCarpenterForm_Err

    If frmMain.macrotrabajo.Enabled And (MacroBltIndex > 0) Then
        Call WriteCraftCarpenter(MacroBltIndex)
    Else

        frmCarp.Show , frmMain

    End If

    Exit Sub
HandleShowCarpenterForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowCarpenterForm", Erl)

End Sub

''
' Handles the UserSwing message.

Public Sub HandleUserSwing(ByVal Message As BinaryReader)

    On Error GoTo HandleUserSwing_Err

    Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_FALLADO_GOLPE, 255, 0, 0, True, False, True)
    Exit Sub
HandleUserSwing_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserSwing", Erl)

End Sub

''
' Handles the UpdateSta message.

Public Sub HandleUpdateSta(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateSta_Err

    UserMinSTA = Message.ReadInt()

    Dim X As Long

    For X = 0 To 8
        frmMain.lblEnergia(X).Caption = UserMinSTA & "/" & UserMaxSTA
    Next X

    If UserMinSTA > 0 Then
        frmMain.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 97)
    Else
        frmMain.STAShp.Width = 0
    End If

    Exit Sub
HandleUpdateSta_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateSta", Erl)

End Sub

''
' Handles the UpdateMana message.
Public Sub HandleUpdateMana(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateMana_Err

    'Get data and update form
    UserMinMAN = Message.ReadInt()

    Dim X As Long

    For X = 0 To 8
        frmMain.lblMana(X) = UserMinMAN & "/" & UserMaxMAN        'Cap
    Next X

    If UserMaxMAN > 0 Then
        frmMain.MANShp.Width = (((UserMinMAN / 100) / (UserMaxMAN / 100)) * 97)
    Else
        frmMain.MANShp.Width = 0
    End If

    Exit Sub
HandleUpdateMana_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateMana", Erl)

End Sub

''
' Handles the UpdateHP message.
Public Sub HandleUpdateHP(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateHP_Err

    Dim X As Long

    UserMinHP = Message.ReadInt()

    For X = 0 To 8
        frmMain.lblVida(X).Caption = UserMinHP & "/" & UserMaxHP        'Cap
    Next X

    If UserMinHP > 0 Then
        frmMain.Hpshp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 97)
        UserEstado = 0
    Else
        UserEstado = 1
        frmMain.Hpshp.Width = 0
        If frmMain.TrainingMacro Then Call frmMain.DesactivarMacroHechizos
        If frmMain.macrotrabajo Then Call frmMain.DesactivarMacroTrabajo
    End If

    Exit Sub
HandleUpdateHP_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateHP", Erl)

End Sub

''
' Handles the UpdateGold message.

Public Sub HandleUpdateGold(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateGold_Err

    'Get data and update form
    UserGLD = Message.ReadInt32()

    If UserGLD >= 100000 Then
        'Changes color
        frmMain.GldLbl.ForeColor = &HFF&        'Red
    Else
        'Changes color
        frmMain.GldLbl.ForeColor = &HFFFF&        'Yellow
    End If
    'frmMain.GldLbl.ForeColor = &HFF&

    frmMain.GldLbl.Caption = UserGLD
    Exit Sub
HandleUpdateGold_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateGold", Erl)

End Sub

''
' Handles the UpdateBankGold message.
Public Sub HandleUpdateBankGold(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateBankGold_Err

    BankGLD = Message.ReadInt32()

    Exit Sub
HandleUpdateBankGold_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateBankGold", Erl)

End Sub

''
' Handles the UpdateExp message.
Public Sub HandleUpdateExp(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateExp_Err

    Dim X As Long

    'Get data and update form
    UserExp = Message.ReadInt32()

    'frmMain.lblExp.Caption = "Exp: " & UserExp & "/" & UserPasarNivel
    If UserLvl = 47 Then

        For X = 0 To 8
            frmMain.lblPorcLvl(X).Caption = "0%"
        Next X

        Exit Sub

    End If


    For X = 0 To 8
        frmMain.lblPorcLvl(X).Caption = Round(CDbl(UserExp) * CDbl(100) / CDbl(UserPasarNivel), 2) & "%"
    Next X

    Exit Sub
HandleUpdateExp_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateExp", Erl)

End Sub

''
' Handles the UpdateStrenghtAndDexterity message.
Public Sub HandleUpdateStrenghtAndDexterity(ByVal Message As BinaryReader)

' On Error GoTo HandleUpdateStrenghtAndDexterity_Err

'Get data and update form
    UserFuerza = Message.ReadInt
    UserAgilidad = Message.ReadInt

    DuracionPociones = 0
    frmMain.TimerPociones.Enabled = False


    frmMain.lblStrg.Caption = UserFuerza
    frmMain.lblDext.Caption = UserAgilidad

    frmMain.lblStrg.ForeColor = getStrenghtColor(UserFuerza)
    frmMain.lblDext.ForeColor = getDexterityColor(UserAgilidad)

    Exit Sub
HandleUpdateStrenghtAndDexterity_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateStrenghtAndDexterity", Erl)

End Sub

' Handles the UpdateStrenghtAndDexterity message.
Public Sub HandleUpdateStrenght(ByVal Message As BinaryReader)

'On Error GoTo HandleUpdateStrenght_Err

'Get data and update form
    UserFuerza = Message.ReadInt

    DuracionPociones = 90
    frmMain.TimerPociones.Enabled = True

    frmMain.lblStrg.Caption = UserFuerza

    frmMain.lblStrg.ForeColor = getStrenghtColor(UserFuerza)
    frmMain.lblDext.ForeColor = getDexterityColor(UserAgilidad)

    Exit Sub
HandleUpdateStrenght_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateStrenght", Erl)

End Sub

' Handles the UpdateStrenghtAndDexterity message.
Public Sub HandleUpdateDexterity(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateDexterity_Err

    'Get data and update form
    UserAgilidad = Message.ReadInt

    DuracionPociones = 90
    frmMain.TimerPociones.Enabled = True
    frmMain.lblDext.Caption = UserAgilidad
    frmMain.lblDext.ForeColor = getDexterityColor(UserAgilidad)
    frmMain.lblStrg.ForeColor = getStrenghtColor(UserFuerza)

    Exit Sub
HandleUpdateDexterity_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateDexterity", Erl)

End Sub

''
' Handles the ChangeMap message.
Public Sub HandleChangeMap(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeMap_Err

    UserMap = Message.ReadInt()

    'file = Get_FileFrom(Map, "Mapa" & UserMap & ".map")

    'If FileExist(file, vbNormal) Then
    Call SwitchMap(UserMap)

    If InStr(1, UCase$(Mapa(UserMap)), "RETO") > 0 Or InStr(1, UCase$(Mapa(UserMap)), "TORNEO") > 0 Then
        BackgroundColor = RGB(15, 15, 15)
    Else
        BackgroundColor = 0

    End If

    If UserMap > UBound(Mapa) Then
        frmMain.lblMapName.Caption = "Nombre desconocido"
    Else
        frmMain.lblMapName.Caption = Mapa(UserMap)
    End If
    
    If bLluvia(UserMap) = 0 Then
        If bRain Then
            Call modEngine_Audio.Cancel(RainBufferIndex)
            RainBufferIndex = 0
            frmMain.IsPlaying = PlayLoop.plNone
        End If
    End If
        
    Exit Sub
HandleChangeMap_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeMap", Erl)

End Sub

''
' Handles the PosUpdate message.
Public Sub HandlePosUpdate(ByVal Message As BinaryReader)

    On Error GoTo HandlePosUpdate_Err

    'Remove char from old position
    If MapData(UserPos.X, UserPos.Y).CharIndex = UserCharIndex Then
        MapData(UserPos.X, UserPos.Y).CharIndex = 0

    End If

    'Set new pos
    UserPos.X = Message.ReadInt()
    UserPos.Y = Message.ReadInt()

    'Set char
    MapData(UserPos.X, UserPos.Y).CharIndex = UserCharIndex
    
    Debug.Print Now, UserCharIndex
    'If UserCharIndex Then
    charlist(UserCharIndex).Pos = UserPos
    'End If
    
    'Are we under a roof?
    bTecho = IIf(MapData(UserPos.X, UserPos.Y).Trigger = 1 Or MapData(UserPos.X, UserPos.Y).Trigger = 2 Or MapData(UserPos.X, UserPos.Y).Trigger = 4, True, False)

    ' Debug.Print Now, UserPos.X, UserPos.Y, "Layer1:" & MapData(UserPos.X, UserPos.Y).Graphic(1).GrhIndex, "Layer2:" & MapData(UserPos.X, UserPos.Y).Graphic(2).GrhIndex, "Layer3:" & MapData(UserPos.X, UserPos.Y).Graphic(3).GrhIndex, "Object:" & MapData(UserPos.X, UserPos.Y).ObjGrh.GrhIndex

    bTecho = bTecho Or MapData(UserPos.X, UserPos.Y).Trigger = 8

    'Update pos label
    frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
    Exit Sub
HandlePosUpdate_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePosUpdate", Erl)

End Sub

''
' Handles the ChatOverHead message.
Public Sub HandleChatOverHead(ByVal Message As BinaryReader)

    On Error GoTo HandleChatOverHead_Err

    Dim chat As String

    Dim CharIndex As Integer

    Dim color As Long

    chat = Message.ReadString16()
    CharIndex = Message.ReadInt()
    color = Message.ReadInt32

    If Len(charlist(CharIndex).nombre) <= 1 And charlist(CharIndex).Mimetizado = False Then
        Dialogos.RemoveDialogsNPCArea
    End If

    'Only add the chat if the character exists (a CharacterRemove may have been sent to the PC / NPC area before the buffer was flushed)
    If charlist(CharIndex).Active Then
        If esGM(UserCharIndex) Then
            If (Len(charlist(CharIndex).nombre) Or charlist(CharIndex).Mimetizado) And Not color = 16776960 And Not Len(Trim$(chat)) = 0 And ShowChatInConsole Then

                With FontTypes(FontTypeNames.FONTTYPE_INFO)
                    Call AddtoRichTextBox(frmMain.RecTxt, Now & " " & charlist(CharIndex).nombre & ": " & chat, .red, .green, .blue, .bold, .italic)
                End With

            End If
        End If
        Call Dialogos.CreateDialog(Trim$(chat), CharIndex, color)
    End If

    Exit Sub
HandleChatOverHead_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChatOverHead", Erl)

End Sub

''
' Handles the ConsoleMessage message.
Public Sub HandleConsoleMessage(ByVal Message As BinaryReader)

    On Error GoTo HandleConsoleMessage_Err

    Dim chat As String

    Dim FontIndex As Integer

    Dim str As String

    Dim r As Byte

    Dim g As Byte

    Dim b As Byte

    Dim SaltoLinea As Integer

    chat = Message.ReadString16()
    FontIndex = Message.ReadInt()
    SaltoLinea = Message.ReadInt()

    'Si hacemos la villeriada para no usar packets id:
    If Left$(chat, 1) = "|" Then
        Call HandleDataSTR(chat)
    Else

        If InStr(1, chat, "~") Then
            str = ReadField(2, chat, 126)

            If Val(str) > 255 Then
                r = 255
            Else
                r = Val(str)

            End If

            str = ReadField(3, chat, 126)

            If Val(str) > 255 Then
                g = 255
            Else
                g = Val(str)

            End If

            str = ReadField(4, chat, 126)

            If Val(str) > 255 Then
                b = 255
            Else
                b = Val(str)

            End If

            Call AddtoRichTextBox(frmMain.RecTxt, Left$(chat, InStr(1, chat, "~") - 1), r, g, b, Val(ReadField(5, chat, 126)) <> 0, Val(ReadField(6, chat, 126)) <> 0, IIf(SaltoLinea <> 0, True, False))
        Else

            With FontTypes(FontIndex)
                Call AddtoRichTextBox(frmMain.RecTxt, chat, .red, .green, .blue, .bold, .italic, IIf(SaltoLinea <> 0, True, False))

            End With

        End If

    End If

    Exit Sub
HandleConsoleMessage_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleConsoleMessage", Erl)

End Sub

''
' Handles the GuildChat message.
Public Sub HandleGuildChat(ByVal Message As BinaryReader)

    On Error GoTo HandleGuildChat_Err

    Dim chat As String

    Dim str As String

    Dim r As Byte

    Dim g As Byte

    Dim b As Byte

    chat = Message.ReadString16()

    If Not DialogosClanes.Activo Then
        If InStr(1, chat, "~") Then
            str = ReadField(2, chat, 126)

            If Val(str) > 255 Then
                r = 255
            Else
                r = Val(str)

            End If

            str = ReadField(3, chat, 126)

            If Val(str) > 255 Then
                g = 255
            Else
                g = Val(str)

            End If

            str = ReadField(4, chat, 126)

            If Val(str) > 255 Then
                b = 255
            Else
                b = Val(str)

            End If

            Call AddtoRichTextBox(frmMain.RecTxt, Left$(chat, InStr(1, chat, "~") - 1), r, g, b, Val(ReadField(5, chat, 126)) <> 0, Val(ReadField(6, chat, 126)) <> 0)
        Else

            With FontTypes(FontTypeNames.FONTTYPE_GUILDMSG)
                Call AddtoRichTextBox(frmMain.RecTxt, chat, .red, .green, .blue, .bold, .italic)

            End With

        End If

    Else
        Call DialogosClanes.PushBackText(ReadField(1, chat, 126))

    End If

    Exit Sub
HandleGuildChat_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleGuildChat", Erl)

End Sub

''
' Handles the ConsoleMessage message.
Public Sub HandleCommerceChat(ByVal Message As BinaryReader)

    On Error GoTo HandleCommerceChat_Err

    Dim chat As String

    Dim FontIndex As Integer

    Dim str As String

    Dim r As Byte

    Dim g As Byte

    Dim b As Byte

    chat = Message.ReadString16()
    FontIndex = Message.ReadInt()

    If InStr(1, chat, "~") Then
        str = ReadField(2, chat, 126)

        If Val(str) > 255 Then
            r = 255
        Else
            r = Val(str)

        End If

        str = ReadField(3, chat, 126)

        If Val(str) > 255 Then
            g = 255
        Else
            g = Val(str)

        End If

        str = ReadField(4, chat, 126)

        If Val(str) > 255 Then
            b = 255
        Else
            b = Val(str)

        End If

        Call AddtoRichTextBox(frmComerciarUsu.CommerceConsole, Left$(chat, InStr(1, chat, "~") - 1), r, g, b, Val(ReadField(5, chat, 126)) <> 0, Val(ReadField(6, chat, 126)) <> 0)
    Else

        With FontTypes(FontIndex)
            Call AddtoRichTextBox(frmComerciarUsu.CommerceConsole, chat, .red, .green, .blue, .bold, .italic)

        End With

    End If

    Exit Sub
HandleCommerceChat_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCommerceChat", Erl)

End Sub

''
' Handles the ShowMessageBox message.
Public Sub HandleShowMessageBox(ByVal Message As BinaryReader)

    On Error GoTo HandleShowMessageBox_Err

    frmMensaje.msg.Caption = Message.ReadString16

    If frmMain.visible Then
        frmMensaje.Show , frmMain
    ElseIf frmCrearPersonaje.visible Then
        frmMensaje.Show , frmCrearPersonaje
    ElseIf frmConnect.visible Then
        If frmOldPersonaje.visible Then
            frmMensaje.Show , frmOldPersonaje
            frmOldPersonaje.Label1.visible = False
        Else
            frmMensaje.Show , frmConnect
        End If
    End If

    Exit Sub
HandleShowMessageBox_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowMessageBox", Erl)

End Sub

''
' Handles the UserIndexInServer message.
Public Sub HandleUserIndexInServer(ByVal Message As BinaryReader)

    On Error GoTo HandleUserIndexInServer_Err

    UserIndex = Message.ReadInt()
    Exit Sub
HandleUserIndexInServer_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserIndexInServer", Erl)

End Sub

''
' Handles the UserCharIndexInServer message.
Public Sub HandleUserCharIndexInServer(ByVal Message As BinaryReader)

    On Error GoTo HandleUserCharIndexInServer_Err

    UserCharIndex = Message.ReadInt()

    If UserCharIndex = 0 Then Exit Sub

    UserPos = charlist(UserCharIndex).Pos

    SoyGM = Not charlist(UserCharIndex).priv = PlayerType.User

    frmMain.lblShowChat.visible = SoyGM

    If UserPos.X = 0 Or UserPos.Y = 0 Then Exit Sub

    'Are we under a roof?
    bTecho = IIf(MapData(UserPos.X, UserPos.Y).Trigger = 1 Or MapData(UserPos.X, UserPos.Y).Trigger = 2 Or MapData(UserPos.X, UserPos.Y).Trigger = 4, True, False)
    bTecho = bTecho Or MapData(UserPos.X, UserPos.Y).Trigger = 8

    ' Debug.Print Now, UserPos.X, UserPos.Y, "Layer1:" & MapData(UserPos.X, UserPos.Y).Graphic(1).GrhIndex, "Layer2:" & MapData(UserPos.X, UserPos.Y).Graphic(2).GrhIndex, "Layer3:" & MapData(UserPos.X, UserPos.Y).Graphic(3).GrhIndex, "Object:" & MapData(UserPos.X, UserPos.Y).ObjGrh.GrhIndex

    frmMain.Coord.Caption = "Mapa " & UserMap & " [" & UserPos.X & "," & UserPos.Y & "]"
    Exit Sub
HandleUserCharIndexInServer_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserCharIndexInServer", Erl)

End Sub

''
' Handles the CharacterCreate message.
Public Sub HandleCharacterCreate(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterCreate_Err

    Dim CharIndex As Integer
    Dim Body As Integer
    Dim Head As Integer
    Dim Heading As E_Heading
    Dim X As Integer
    Dim Y As Integer
    Dim Weapon As Integer
    Dim Shield As Integer
    Dim Helmet As Integer
    Dim NickColor As Integer
    Dim clanPos As String
    Dim tmpStr As String
    Dim LoopC As Long
    Dim strpos As Long
    Dim isNPC As Boolean
    Dim charSpeed As Single

    CharIndex = Message.ReadInt()
    Body = Message.ReadInt()
    Head = Message.ReadInt()
    Heading = Message.ReadInt()
    isNPC = Message.ReadBool()
    X = Message.ReadInt()
    Y = Message.ReadInt()
    Weapon = Message.ReadInt()
    Shield = Message.ReadInt()
    Helmet = Message.ReadInt()

    With charlist(CharIndex)
        Call SetCharacterFx(CharIndex, Message.ReadInt(), Message.ReadInt())

        tmpStr = Message.ReadString16
        .isNPC = isNPC
        
        .Mimetizado = (InStr(1, tmpStr, Chr$(45)) > 0)    '-
        If .Mimetizado Then tmpStr = Trim$(Replace$(tmpStr, Chr$(45), ""))    '-

        charlist(CharIndex).Oculto = IIf(InStr(1, tmpStr, Chr(35)) > 0, 1, 0)
        tmpStr = Trim$(Replace$(tmpStr, Chr(35), ""))

        charlist(CharIndex).Envenenado = IIf(InStr(1, tmpStr, Chr(95)) > 0, 1, 0)
        tmpStr = Trim$(Replace$(tmpStr, Chr(95), ""))

        charlist(CharIndex).Mimetizado = (InStr(1, tmpStr, Chr$(45)) > 0)
        tmpStr = Trim$(Replace$(tmpStr, Chr$(45), ""))

        clanPos = InStr(1, tmpStr, Chr$(60))    '<

        'If SoyGM Then
        charlist(CharIndex).Invisible = IIf(InStr(1, tmpStr, 1) > 0, 1, 0)
        tmpStr = Trim$(Replace$(tmpStr, 1, vbNullString))

        If Not charlist(CharIndex).Invisible Then
            charlist(CharIndex).Invisible = IIf(InStr(1, tmpStr, Chr$(124)) > 0, 1, 0)
            tmpStr = Trim$(Replace$(tmpStr, Chr$(124), vbNullString))
        End If
        'End If

        NickColor = Message.ReadInt()

        If (NickColor And eNickColor.ieCriminal) <> 0 Then
            .Criminal = 1
        Else
            .Criminal = 0
        End If

        .Atacable = (NickColor And eNickColor.ieAtacable) <> 0
        .priv = Message.ReadInt()

        'If InStr(1, tmpStr, 1, vbTextCompare) <> 0 Then
        'tmpStr = Replace$(tmpStr, 1, vbNullString)
        'UserCharIndex = CharIndex
        'End If

        .muerto = (Head = CASPER_HEAD_CIUDA And Body = CASPER_BODY_CIUDA) Or (Head = CASPER_HEAD_PK And Body = CASPER_HEAD_PK)

        If Not esGM(CharIndex) Or .Mimetizado Then
            If .Atacable Then
                .color = D3DColorXRGB(ColoresPJ(1).r, ColoresPJ(1).g, ColoresPJ(1).b)
            Else

                If .Criminal Then
                    .color = D3DColorXRGB(ColoresPJ(7).r, ColoresPJ(7).g, ColoresPJ(7).b)
                Else
                    .color = D3DColorXRGB(ColoresPJ(8).r, ColoresPJ(8).g, ColoresPJ(8).b)

                End If

                .isFaccion = 0

                If InStr(1, tmpStr, Chr(47)) > 0 Then
                    .isFaccion = FaccionType.RoyalCouncil
                    ColoresPJ(10).r = 40
                    ColoresPJ(10).g = 190
                    ColoresPJ(10).b = 220
                    .color = D3DColorXRGB(ColoresPJ(10).r, ColoresPJ(10).g, ColoresPJ(10).b)
                    .clan = Trim$(Replace$(.clan, Chr(47), vbNullString))
                ElseIf InStr(1, tmpStr, Chr(42)) > 0 Then
                    .isFaccion = FaccionType.ChaosCouncil
                    .color = D3DColorXRGB(ColoresPJ(9).r, ColoresPJ(9).g, ColoresPJ(9).b)
                    .clan = Trim$(Replace$(.clan, Chr(42), vbNullString))
                End If

            End If
        Else
            If .priv > 0 Then
                .color = D3DColorXRGB(ColoresPJ(.priv).r, ColoresPJ(.priv).g, ColoresPJ(.priv).b)
            End If
            .isFaccion = 0
        End If

        tmpStr = Replace(tmpStr, Chr(42), vbNullString)
        tmpStr = Trim$(Replace(tmpStr, Chr(47), vbNullString))

        If .Invisible Then
            .CounterInvi = RandomNumber(1, 5)
        End If

        If clanPos = 0 Then
            clanPos = InStr(1, tmpStr, "[")

        End If

        'ocultar?
        If clanPos > 0 Then
            .clan = mid$(tmpStr, clanPos)
            .nombre = (Left$(tmpStr, clanPos - 2))

            If CharIndex = UserCharIndex And Len(.nombre) > 0 And .Mimetizado = False Then

                For LoopC = 0 To frmMain.lblName().Count - 1
                    frmMain.lblName(LoopC).Caption = .nombre & vbCrLf & .clan
                Next LoopC

            End If

        Else
            .nombre = tmpStr
            .clan = vbNullString

            If CharIndex = UserCharIndex And Len(.nombre) > 0 And .Mimetizado = False Then

                For LoopC = 0 To frmMain.lblName().Count - 1
                    frmMain.lblName(LoopC).Caption = .nombre
                Next LoopC

            End If

        End If

    End With

    Call MakeChar(CharIndex, Body, Head, Heading, X, Y, Weapon, Shield, Helmet)

    Call RefreshAllChars

    Exit Sub
HandleCharacterCreate_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterCreate", Erl)

End Sub

Public Sub HandleCharacterChangeNick(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeNick_Err

    Dim CharIndex As Integer

    CharIndex = Message.ReadInt

    Dim tmpStr As String

    tmpStr = Message.ReadString16

    Dim strpos As Long

    Dim clanPos As Long

    charlist(CharIndex).Oculto = IIf(InStr(1, tmpStr, Chr(35)) > 0, 1, 0)
    tmpStr = Trim$(Replace$(tmpStr, Chr(35), ""))

    charlist(CharIndex).Mimetizado = (InStr(1, tmpStr, Chr$(45)) > 0)
    tmpStr = Trim$(Replace$(tmpStr, Chr$(45), ""))

    charlist(CharIndex).Envenenado = IIf(InStr(1, tmpStr, Chr(95)) > 0, 1, 0)
    tmpStr = Trim$(Replace$(tmpStr, Chr(95), ""))

    'If esGM(UserCharIndex) Then
    charlist(CharIndex).Invisible = (InStr(1, tmpStr, Chr$(124)) > 0)
    tmpStr = Trim$(Replace$(tmpStr, Chr$(124), ""))
    'End If

    charlist(CharIndex).isFaccion = 0

    If InStr(1, tmpStr, Chr(47)) > 0 Then
        tmpStr = Replace$(tmpStr, Chr(47), vbNullString)
        charlist(CharIndex).isFaccion = FaccionType.RoyalCouncil
        ColoresPJ(10).r = 40
        ColoresPJ(10).g = 190
        ColoresPJ(10).b = 220
        charlist(CharIndex).color = D3DColorXRGB(ColoresPJ(10).r, ColoresPJ(10).g, ColoresPJ(10).b)
        tmpStr = Replace$(tmpStr, Chr(47), vbNullString)
    ElseIf InStr(1, tmpStr, Chr(42)) > 0 Then
        tmpStr = Replace$(tmpStr, Chr(42), vbNullString)
        charlist(CharIndex).isFaccion = FaccionType.ChaosCouncil
        charlist(CharIndex).color = D3DColorXRGB(ColoresPJ(9).r, ColoresPJ(9).g, ColoresPJ(9).b)
    End If
    tmpStr = Trim$(tmpStr)

    clanPos = InStr(1, tmpStr, "<")

    If clanPos = 0 Then
        clanPos = InStr(1, tmpStr, "[")
    End If

    If clanPos > 0 Then
        charlist(CharIndex).clan = mid$(tmpStr, clanPos)
        charlist(CharIndex).nombre = (Left$(tmpStr, clanPos - 2))
    Else
        charlist(CharIndex).nombre = tmpStr
        charlist(CharIndex).clan = ""
    End If

    Exit Sub
HandleCharacterChangeNick_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeNick", Erl)

End Sub

''
' Handles the CharacterRemove message.
Public Sub HandleCharacterRemove(ByVal Message As BinaryReader)

    Dim CharIndex As Integer

    CharIndex = Char_Find(Message.ReadInt)

    If Char_Check(CharIndex) Then
        Call Char_Remove(CharIndex)
    End If

End Sub

''
' Handles the CharacterMove message.
Public Sub HandleCharacterMove(ByVal Message As BinaryReader)

    Dim CharIndex As Integer

    Dim X As Byte

    Dim Y As Byte

    CharIndex = Char_Find(Message.ReadInt)
    X = Message.ReadInt8
    Y = Message.ReadInt8

    If Char_Check(CharIndex) Then


        If charlist(CharIndex).FxIndex >= 40 And charlist(CharIndex).FxIndex <= 49 Then        'If it's meditating, we remove the FX
            charlist(CharIndex).FxIndex = 0
        End If

        If Not esGM(CharIndex) Then Call DoPasosFx(CharIndex)

        Call MoveCharbyPos(CharIndex, X, Y)

        ' Soy un fenomeno xd
        'If Char_Check(UserCharIndex) Then
        'MapData(CharList(UserCharIndex).Pos.X, CharList(UserCharIndex).Pos.Y).CharIndex = UserCharIndex
        'End If
    End If

    Call RefreshAllChars

End Sub

''
' Handles the ForceCharMove message.
Public Sub HandleForceCharMove(ByVal Message As BinaryReader)

    Dim Direccion As Byte

    Direccion = Message.ReadInt8

    If Char_Check(UserCharIndex) Then
        Call MoveCharbyHead(UserCharIndex, Direccion)
    End If

    Call MoveScreen(Direccion)


    Call RefreshAllChars

End Sub

''
' Handles the CharacterChange message.
Public Sub HandleCharacterChange(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChange_Err

    Dim CharIndex As Integer

    Dim TempInt As Integer
    Dim Body As Integer

    Dim HeadIndex As Integer

    CharIndex = Char_Find(Message.ReadInt)        '3

    With charlist(CharIndex)
        TempInt = Message.ReadInt()

        If TempInt < LBound(BodyData()) Or TempInt > UBound(BodyData()) Then
            .Body = BodyData(0)
            .iBody = 0
        Else
            .Body = BodyData(TempInt)
            .iBody = TempInt

        End If

        HeadIndex = Message.ReadInt()

        If HeadIndex < LBound(HeadData()) Or HeadIndex > UBound(HeadData()) Then
            .Head = HeadData(0)
            .iHead = 0
        Else
            .Head = HeadData(HeadIndex)
            .iHead = HeadIndex

        End If

        .muerto = (.iHead = CASPER_HEAD_CIUDA And .iBody = CASPER_BODY_CIUDA) Or (.iHead = CASPER_HEAD_PK And .iBody = CASPER_HEAD_PK)

        .Heading = Message.ReadInt()

        TempInt = Message.ReadInt()

        If TempInt <> 0 Then
            .Arma = WeaponAnimData(TempInt)

        End If

        TempInt = Message.ReadInt()

        If TempInt <> 0 Then
            .Escudo = ShieldAnimData(TempInt)

        End If

        TempInt = Message.ReadInt()

        If TempInt <> 0 Then
            .Casco = CascoAnimData(TempInt)

        End If

        .iCasco = TempInt

        Dim fX As Integer

        Dim FxLoops As Integer

        fX = Message.ReadInt()
        FxLoops = Message.ReadInt()

        If fX > 0 Then
            Call SetCharacterFx(CharIndex, fX, FxLoops)
        End If

    End With

    Call RefreshAllChars

    Exit Sub
HandleCharacterChange_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChange", Erl)

End Sub

''
' Handles the ObjectCreate message.
Public Sub HandleObjectCreate(ByVal Message As BinaryReader)

    On Error GoTo HandleObjectCreate_Err

    Dim X As Integer

    Dim Y As Integer

    X = Message.ReadInt()
    Y = Message.ReadInt()

    MapData(X, Y).ObjGrh.GrhIndex = Message.ReadInt()


    Call InitGrh(MapData(X, Y).ObjGrh, MapData(X, Y).ObjGrh.GrhIndex)
    Exit Sub
HandleObjectCreate_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleObjectCreate", Erl)

End Sub

''
' Handles the ObjectDelete message.
Public Sub HandleObjectDelete(ByVal Message As BinaryReader)

    On Error GoTo HandleObjectDelete_Err

    Dim X As Integer

    Dim Y As Integer

    X = Message.ReadInt()

    Y = Message.ReadInt()
    MapData(X, Y).ObjGrh.GrhIndex = 0
    Exit Sub
HandleObjectDelete_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleObjectDelete", Erl)

End Sub

''
' Handles the BlockPosition message.

Public Sub HandleBlockPosition(ByVal Message As BinaryReader)

    On Error GoTo HandleBlockPosition_Err

    Dim X As Integer

    Dim Y As Integer

    Dim Blocked As Boolean

    X = Message.ReadInt()
    Y = Message.ReadInt()
    Blocked = Message.ReadBool()

    If Blocked Then
        MapData(X, Y).Blocked = 1
    Else

        MapData(X, Y).Blocked = 0

    End If

    Exit Sub
HandleBlockPosition_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBlockPosition", Erl)

End Sub

''
' Handles the PlayMIDI message.
Public Sub HandlePlayMIDI(ByVal Message As BinaryReader)

    On Error GoTo HandlePlayMIDI_Err

    Dim currentMidi As Integer

    currentMidi = Message.ReadInt()

    If currentMidi Then
        Call modEngine_Audio.PlayMusic(CStr(currentMidi) & ".mid", Message.ReadInt)
    Else
        'Remove the bytes to prevent errors
        Call Message.ReadInt
        
        Call modEngine_Audio.Halt
        
        'Call Audio.StopMidi
        'Call Audio.ResetMidi

    End If

    Exit Sub
HandlePlayMIDI_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePlayMIDI", Erl)

End Sub

''
' Handles the PlayWave message.
Public Sub HandlePlayWave(ByVal Message As BinaryReader)

    Dim wave        As Byte
    Dim srcX        As Byte
    Dim srcY        As Byte
    
    wave = Message.ReadInt()
    srcX = Message.ReadInt()
    srcY = Message.ReadInt()
    
    If (MapData(srcX, srcY).CharIndex > 0) Then
        Call modEngine_Audio.PlayEffect(CStr(wave) & ".wav", charlist(MapData(srcX, srcY).CharIndex).Emitter)
    Else
        Call modEngine_Audio.PlayEffect(CStr(wave) & ".wav", Nothing)
    End If

End Sub

''
' Handles the GuildList message.
Public Sub HandleGuildList(ByVal Message As BinaryReader)

    On Error GoTo HandleGuildList_Err

    With frmGuildAdm
        'Clear guild's list
        .guildslist.Clear

        GuildNames = Split(Message.ReadString16(), SEPARATOR)

        Dim i As Long

        For i = 0 To UBound(GuildNames())
            Call .guildslist.AddItem(GuildNames(i))
        Next i

        .Show vbModeless, frmMain

    End With

    Exit Sub
HandleGuildList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleGuildList", Erl)

End Sub

''
' Handles the AreaChanged message.
Public Sub HandleAreaChanged(ByVal Message As BinaryReader)

    On Error GoTo HandleAreaChanged_Err

    Dim X As Integer

    Dim Y As Integer

    X = Message.ReadInt()
    Y = Message.ReadInt()

    Call CambioDeArea(X, Y)
    Exit Sub
HandleAreaChanged_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleAreaChanged", Erl)

End Sub

''
' Handles the PauseToggle message.

Public Sub HandlePauseToggle(ByVal Message As BinaryReader)

    On Error GoTo HandlePauseToggle_Err

    pausa = Not pausa
    Exit Sub
HandlePauseToggle_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePauseToggle", Erl)

End Sub

''
' Handles the RainToggle message.
Public Sub HandleRainToggle(ByVal Message As BinaryReader)

    On Error GoTo HandleRainToggle_Err

    Dim oldBrain As Boolean

    oldBrain = bRain

    bRain = Message.ReadBool

    If Not InMapBounds(UserPos.X, UserPos.Y) Then Exit Sub

    bTecho = (MapData(UserPos.X, UserPos.Y).Trigger = 1 Or MapData(UserPos.X, UserPos.Y).Trigger = 2 Or MapData(UserPos.X, UserPos.Y).Trigger = 4)

    ' Debug.Print Now, UserPos.X, UserPos.Y, "Layer1:" & MapData(UserPos.X, UserPos.Y).Graphic(1).GrhIndex, "Layer2:" & MapData(UserPos.X, UserPos.Y).Graphic(2).GrhIndex, "Layer3:" & MapData(UserPos.X, UserPos.Y).Graphic(3).GrhIndex, "Object:" & MapData(UserPos.X, UserPos.Y).ObjGrh.GrhIndex

    If bRain Then
        If bLluvia(UserMap) Then
            'Stop playing the rain sound
            Call modEngine_Audio.Cancel(RainBufferIndex)
            RainBufferIndex = 0
            

            If bTecho Then
                Call modEngine_Audio.PlayEffect(SND_LLUVIAINEND)
            Else
                Call modEngine_Audio.PlayEffect(SND_LLUVIAOUTEND)
            End If
            frmMain.IsPlaying = PlayLoop.plNone
        End If
    Else
        If Not oldBrain = bRain Then
            Call modEngine_Audio.Cancel(RainBufferIndex)
            RainBufferIndex = 0
            If bTecho Then
                Call modEngine_Audio.PlayEffect(SND_LLUVIAINEND)
            Else
                Call modEngine_Audio.PlayEffect(SND_LLUVIAOUTEND)
            End If
            frmMain.IsPlaying = PlayLoop.plNone
        End If
    End If

    Exit Sub
HandleRainToggle_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleRainToggle", Erl)

End Sub

''
' Handles the CreateFX message.
Public Sub HandleCreateFX(ByVal Message As BinaryReader)

    On Error GoTo HandleCreateFX_Err

    Dim CharIndex As Integer

    Dim fX As Integer

    Dim Loops As Integer

    CharIndex = Message.ReadInt()
    fX = Message.ReadInt()
    Loops = Message.ReadInt()

    Call SetCharacterFx(CharIndex, fX, Loops)
    Exit Sub
HandleCreateFX_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCreateFX", Erl)

End Sub

''
' Handles the UpdateUserStats message.
Public Sub HandleUpdateUserStats(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateUserStats_Err

    UserMaxHP = Message.ReadInt()
    UserMinHP = Message.ReadInt()
    UserMaxMAN = Message.ReadInt()
    UserMinMAN = Message.ReadInt()
    UserMaxSTA = Message.ReadInt()
    UserMinSTA = Message.ReadInt()
    UserGLD = Message.ReadInt32()
    UserLvl = Message.ReadInt()
    UserPasarNivel = Message.ReadInt32()
    UserExp = Message.ReadInt32()

    Dim X As Long

    frmMain.GldLbl.Caption = UserGLD

    'Stats
    For X = 0 To 8

        If UserPasarNivel > 0 And UserLvl < 47 Then
            frmMain.lblPorcLvl(X).Caption = Round(CDbl(UserExp) * CDbl(100) / CDbl(UserPasarNivel), 2) & "%"
        Else
            frmMain.lblPorcLvl(X).Caption = "0%"

        End If

        frmMain.lblLvl(X).Caption = UserLvl
        frmMain.lblMana(X) = UserMinMAN & "/" & UserMaxMAN
        frmMain.lblVida(X) = UserMinHP & "/" & UserMaxHP
        frmMain.lblEnergia(X) = UserMinSTA & "/" & UserMaxSTA
    Next X

    If UserMaxMAN > 0 Then
        frmMain.MANShp.Width = (((UserMinMAN / 100) / (UserMaxMAN / 100)) * 97)
    Else
        frmMain.MANShp.Width = 0
    End If

    If UserMinHP > 0 Then
        frmMain.Hpshp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 97)
    Else
        frmMain.Hpshp.Width = 0
    End If

    If UserMinSTA > 0 Then
        frmMain.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 97)
    Else
        frmMain.STAShp.Width = 0
    End If

    If UserMinHP = 0 Then
        UserEstado = 1
        Envenenado = 0
        If frmMain.TrainingMacro Then Call frmMain.DesactivarMacroHechizos
        If frmMain.macrotrabajo Then Call frmMain.DesactivarMacroTrabajo
    Else
        UserEstado = 0
    End If

    If UserGLD >= 100000 Then
        frmMain.GldLbl.ForeColor = &HFF&
    Else
        frmMain.GldLbl.ForeColor = &HFFFF&
    End If

    Exit Sub
HandleUpdateUserStats_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateUserStats", Erl)

End Sub

''
' Handles the WorkRequestTarget message.
Public Sub HandleWorkRequestTarget(ByVal Message As BinaryReader)

    On Error GoTo HandleWorkRequestTarget_Err

    UsingSkill = Message.ReadInt()

    frmMain.MousePointer = 2

    Call modEngine_Audio.PlayInterface(SND_CLICK)

    Select Case UsingSkill

    Case Magia

        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_MAGIA, 100, 100, 120, 0, 0)

    Case Pesca
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_PESCA, 100, 100, 120, 0, 0)

    Case Robar
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_ROBAR, 100, 100, 120, 0, 0)

    Case Talar
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_TALAR, 100, 100, 120, 0, 0)

    Case Mineria
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_MINERIA, 100, 100, 120, 0, 0)

    Case FundirMetal
        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_FUNDIRMETAL, 100, 100, 120, 0, 0)

    Case Proyectiles

        Call AddtoRichTextBox(frmMain.RecTxt, MENSAJE_TRABAJO_PROYECTILES, 100, 100, 120, 0, 0)

    End Select

    Exit Sub
HandleWorkRequestTarget_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleWorkRequestTarget", Erl)

End Sub

''
' Handles the ChangeInventorySlot message.
Public Sub HandleChangeInventorySlot(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeInventorySlot_Err

    Dim Slot As Integer

    Dim ObjIndex As Integer

    Dim Name As String

    Dim amount As Integer

    Dim Equipped As Boolean

    Dim GrhIndex As Integer

    Dim ObjType As Integer

    Dim MaxHit As Integer

    Dim MinHit As Integer

    Dim MaxDef As Integer

    Dim MinDef As Integer

    Dim Value As Single

    Slot = Message.ReadInt()
    ObjIndex = Message.ReadInt()
    Name = Message.ReadString16()
    amount = Message.ReadInt()
    Equipped = Message.ReadBool()
    GrhIndex = Message.ReadInt()
    ObjType = Message.ReadInt()
    MaxHit = Message.ReadInt()
    MinHit = Message.ReadInt()
    MaxDef = Message.ReadInt()
    MinDef = Message.ReadInt
    Value = Message.ReadReal32()

    If Equipped Then

        Select Case ObjType

        Case eObjType.otWeapon
            frmMain.lblWeapon = MinHit & "/" & MaxHit
            UserWeaponEqpSlot = Slot

        Case eObjType.otArmadura
            frmMain.lblArmor = MinDef & "/" & MaxDef
            UserArmourEqpSlot = Slot

        Case eObjType.otescudo
            frmMain.lblShielder = MinDef & "/" & MaxDef
            UserHelmEqpSlot = Slot

        Case eObjType.otcasco
            frmMain.lblHelm = MinDef & "/" & MaxDef
            UserShieldEqpSlot = Slot

        End Select

    Else

        Select Case Slot

        Case UserWeaponEqpSlot
            frmMain.lblWeapon = "0/0"
            UserWeaponEqpSlot = 0

        Case UserArmourEqpSlot
            frmMain.lblArmor = "0/0"
            UserArmourEqpSlot = 0

        Case UserHelmEqpSlot
            frmMain.lblShielder = "0/0"
            UserHelmEqpSlot = 0

        Case UserShieldEqpSlot
            frmMain.lblHelm = "0/0"
            UserShieldEqpSlot = 0

        End Select

    End If

    Call Inventario.SetItem(Slot, ObjIndex, amount, Equipped, GrhIndex, ObjType, MaxHit, MinHit, MaxDef, MinDef, Value, Name)

    Exit Sub
HandleChangeInventorySlot_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeInventorySlot", Erl)

End Sub

' Handles the AddSlots message.
Public Sub HandleAddSlots(ByVal Message As BinaryReader)

    On Error GoTo HandleAddSlots_Err

    MaxInventorySlots = Message.ReadInt
    Exit Sub
HandleAddSlots_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleAddSlots", Erl)

End Sub

' Handles the StopWorking message.
Public Sub HandleStopWorking(ByVal Message As BinaryReader)

    On Error GoTo HandleStopWorking_Err

    With FontTypes(FontTypeNames.FONTTYPE_INFO)
        Call ShowConsoleMsg("¡Has terminado de trabajar!", .red, .green, .blue, .bold, .italic)

    End With

    If frmMain.macrotrabajo.Enabled Then Call frmMain.DesactivarMacroTrabajo
    Exit Sub
HandleStopWorking_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleStopWorking", Erl)

End Sub

' Handles the CancelOfferItem message.

Public Sub HandleCancelOfferItem(ByVal Message As BinaryReader)

    On Error GoTo HandleCancelOfferItem_Err

    Dim Slot As Integer

    Dim amount As Long

    Slot = Message.ReadInt

    With InvOfferComUsu(0)
        amount = .amount(Slot)

        ' No tiene sentido que se quiten 0 unidades
        If amount <> 0 Then
            ' Actualizo el inventario general
            Call frmComerciarUsu.UpdateInvCom(.ObjIndex(Slot), amount)

            ' Borro el item
            Call .SetItem(Slot, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "")

        End If

    End With

    ' Si era el único ítem de la oferta, no puede confirmarla
    If Not frmComerciarUsu.HasAnyItem(InvOfferComUsu(0)) Then        'And Not frmComerciarUsu.HasAnyItem(InvOroComUsu(1)) Then
        Call frmComerciarUsu.HabilitarConfirmar(False)

    End If

    With FontTypes(FontTypeNames.FONTTYPE_INFO)

        Call frmComerciarUsu.PrintCommerceMsg("¡No puedes comerciar ese objeto!", FontTypeNames.FONTTYPE_INFO)

    End With

    Exit Sub
HandleCancelOfferItem_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCancelOfferItem", Erl)

End Sub

''
' Handles the ChangeBankSlot message.
Public Sub HandleChangeBankSlot(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeBankSlot_Err

    Dim Slot As Integer

    Slot = Message.ReadInt()

    With UserBancoInventory(Slot)
        .ObjIndex = Message.ReadInt()
        .Name = Message.ReadString16()
        .amount = Message.ReadInt()
        .GrhIndex = Message.ReadInt()
        .ObjType = Message.ReadInt()
        .MaxHit = Message.ReadInt()
        .MinHit = Message.ReadInt()
        .MaxDef = Message.ReadInt()
        .MinDef = Message.ReadInt
        .Valor = Message.ReadInt32()

        If Comerciando Then
            Call InvBanco(0).SetItem(Slot, .ObjIndex, .amount, .Equipped, .GrhIndex, .ObjType, .MaxHit, .MinHit, .MaxDef, .MinDef, .Valor, .Name)

        End If

    End With

    Exit Sub
HandleChangeBankSlot_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeBankSlot", Erl)

End Sub

''
' Handles the ChangeSpellSlot message.

Public Sub HandleChangeSpellSlot(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeSpellSlot_Err

    Dim Slot As Integer

    Dim Spellname As String

    Slot = Message.ReadInt()

    UserHechizos(Slot) = Message.ReadInt()

    Spellname = GetNameHechizo(UserHechizos(Slot))

    If Slot <= hlst.ListCount Then
        hlst.List(Slot - 1) = Spellname
    Else
        Call hlst.AddItem(Spellname)
        hlst.Scroll = LastScroll
    End If

    Exit Sub
HandleChangeSpellSlot_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeSpellSlot", Erl)

End Sub

''
' Handles the Attributes message.
Public Sub HandleAtributes(ByVal Message As BinaryReader)

    On Error GoTo HandleAtributes_Err

    Dim i As Long

    For i = 1 To NUMATRIBUTES
        UserAtributos(i) = Message.ReadInt()
    Next i

    'Show them in character creation
    If EstadoLogin = E_MODO.Dados Then

        With frmCrearPersonaje

            If .visible Then

                For i = 1 To NUMATRIBUTES
                    .lblAtributos(i).Caption = UserAtributos(i)
                Next i

            End If

        End With

    Else

        LlegaronAtrib = True

    End If

    Exit Sub
HandleAtributes_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleAtributes", Erl)

End Sub

''
' Handles the BlacksmithWeapons message.

Public Sub HandleBlacksmithWeapons(ByVal Message As BinaryReader)

    On Error GoTo HandleBlacksmithWeapons_Err

    Dim Count As Integer

    Dim i As Long

    Count = Message.ReadInt()

    ReDim ArmasHerrero(Count) As tItemsConstruibles
    ReDim HerreroMejorar(0) As tItemsConstruibles

    For i = 1 To Count

        With ArmasHerrero(i)
            .ObjIndex = Message.ReadInt()

        End With

    Next i

    With frmHerrero
        .lstArmas.Clear

        For i = 1 To Count
            .lstArmas.AddItem DataObj(ArmasHerrero(i).ObjIndex).nombre & " (" & DataObj(ArmasHerrero(i).ObjIndex).MinHit & "/" & DataObj(ArmasHerrero(i).ObjIndex).MaxHit & ")"
        Next i

        If .lstArmas.ListCount > 0 Then .lstArmas.Selected(0) = True

    End With

    Exit Sub
HandleBlacksmithWeapons_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBlacksmithWeapons", Erl)

End Sub

''
' Handles the BlacksmithArmors message.
Public Sub HandleBlacksmithArmors(ByVal Message As BinaryReader)

    On Error GoTo HandleBlacksmithArmors_Err

    Dim Count As Integer

    Dim i As Long

    Count = Message.ReadInt()

    ReDim ArmadurasHerrero(Count) As tItemsConstruibles

    For i = 1 To Count

        With ArmadurasHerrero(i)
            .ObjIndex = Message.ReadInt()

        End With

    Next i

    'está mal, tendria que ponerlo arriba, pero fue..
    With frmHerrero
        .lstArmaduras.Clear

        For i = 1 To Count
            .lstArmaduras.AddItem DataObj(ArmadurasHerrero(i).ObjIndex).nombre & " (" & DataObj(ArmadurasHerrero(i).ObjIndex).MinDef & "/" & DataObj(ArmadurasHerrero(i).ObjIndex).MaxDef & ")"
        Next i

    End With

    Exit Sub
HandleBlacksmithArmors_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBlacksmithArmors", Erl)

End Sub

''
' Handles the CarpenterObjects message.
Public Sub HandleCarpenterObjects(ByVal Message As BinaryReader)

    On Error GoTo HandleCarpenterObjects_Err

    Dim Count As Integer

    Dim i As Long

    Count = Message.ReadInt()

    ReDim ObjCarpintero(Count) As tItemsConstruibles

    For i = 1 To Count

        With ObjCarpintero(i)
            .ObjIndex = Message.ReadInt()

        End With

    Next i

    With frmCarp
        .lstObjetos.Clear

        For i = 1 To Count
            .lstObjetos.AddItem DataObj(ObjCarpintero(i).ObjIndex).nombre
        Next i

        'add to list

    End With

    Exit Sub
HandleCarpenterObjects_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCarpenterObjects", Erl)

End Sub

''
' Handles the RestOK message.
Public Sub HandleRestOK(ByVal Message As BinaryReader)

    On Error GoTo HandleRestOK_Err

    UserDescansar = Not UserDescansar
    Exit Sub
HandleRestOK_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleRestOK", Erl)

End Sub

''
' Handles the ErrorMessage message.
Public Sub HandleErrorMessage(ByVal Message As BinaryReader)

    On Error GoTo HandleErrorMessage_Err

    Dim auxbuff As String

    auxbuff = Message.ReadString16

    frmMensaje.msg.Caption = auxbuff

    If frmMain.visible Then
        frmMensaje.Show , frmMain
    ElseIf frmCrearPersonaje.visible Then

        Caida = 0

        If auxbuff = "Ejecuta el updater" Or auxbuff = "Esta versión del juego es obsoleta." Then
            Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", Chr(109) & Chr(100) & Chr(53), "")
            If MsgBox(auxbuff & vbNewLine & "Deseas actualizar el cliente?", vbYesNo, "TDS Legacy") = vbYes Then
                Call ShellExecute(0, "Open", App.Path & "\updater.exe", App.EXEName & ".exe", App.Path, SW_SHOWNORMAL)
                Call Mod_General.CloseClient    'End
            Else
                End

            End If

        Else
            MsgBox auxbuff

        End If

    ElseIf frmConnect.visible Then

        If frmOldPersonaje.visible Then
            frmOldPersonaje.Label1.visible = False
            IniciarCaida 0
            PanelQuitVisible = False
            Unload frmOldPersonaje

            frmMensaje.Show vbModal, frmConnect
        Else

            frmMensaje.Show vbModal, frmConnect

        End If

    End If

    UserCharIndex = 0
    'MsgBox "Aviso: " & auxbuff

    Exit Sub
HandleErrorMessage_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleErrorMessage", Erl)

End Sub

''
' Handles the Blind message.
Public Sub HandleBlind(ByVal Message As BinaryReader)

    On Error GoTo HandleBlind_Err

    UserCiego = True
    Exit Sub
HandleBlind_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBlind", Erl)

End Sub

''
' Handles the Dumb message.
Public Sub HandleDumb(ByVal Message As BinaryReader)

    On Error GoTo HandleDumb_Err

    UserEstupido = True
    Exit Sub
HandleDumb_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleDumb", Erl)

End Sub

''
' Handles the ShowSignal message.
Public Sub HandleShowSignal(ByVal Message As BinaryReader)

    On Error GoTo HandleShowSignal_Err

    Dim tmp As String

    tmp = Message.ReadString16()

    Dim tmpInt As Integer

    tmpInt = Message.ReadInt()
    Call InitCartel(tmp, tmpInt, Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleShowSignal_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowSignal", Erl)

End Sub

''
' Handles the ChangeNPCInventorySlot message.
Public Sub HandleChangeNPCInventorySlot(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeNPCInventorySlot_Err

    Dim Slot As Integer

    Slot = Message.ReadInt()

    With NPCInventory(Slot)
        .Name = Message.ReadString16()
        .amount = Message.ReadInt()
        .Valor = Message.ReadReal32()
        .GrhIndex = Message.ReadInt()
        .ObjIndex = Message.ReadInt()
        .ObjType = Message.ReadInt()
        .MaxHit = Message.ReadInt()
        .MinHit = Message.ReadInt()
        .MaxDef = Message.ReadInt()
        .MinDef = Message.ReadInt

        If InvComNpc.isInitialized Then
            Call InvComNpc.SetItem(Slot, .ObjIndex, .amount, 0, .GrhIndex, .ObjType, .MaxHit, .MinHit, .MaxDef, .MinDef, .Valor, .Name)

        End If

    End With

    Exit Sub
HandleChangeNPCInventorySlot_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeNPCInventorySlot", Erl)

End Sub

''
' Handles the UpdateHungerAndThirst message.

Public Sub HandleUpdateHungerAndThirst(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateHungerAndThirst_Err

    UserMaxAGU = Message.ReadInt()
    UserMinAGU = Message.ReadInt()
    UserMaxHAM = Message.ReadInt()
    UserMinHAM = Message.ReadInt()

    Dim X As Long

    For X = 0 To 8
        frmMain.lblHambre(X) = UserMinHAM & "/" & UserMaxHAM
        frmMain.lblSed(X) = UserMinAGU & "/" & UserMaxAGU
    Next X

    If UserMinHAM > 0 Then
        frmMain.COMIDAsp.Width = (((UserMinHAM / 100) / (UserMaxHAM / 100)) * 97)
    Else
        frmMain.COMIDAsp.Width = 0
    End If

    If UserMinAGU > 0 Then
        frmMain.AGUAsp.Width = (((UserMinAGU / 100) / (UserMaxAGU / 100)) * 97)
    Else
        frmMain.AGUAsp.Width = 0
    End If

    Exit Sub
HandleUpdateHungerAndThirst_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateHungerAndThirst", Erl)

End Sub

''
' Handles the Fame message.
Public Sub HandleFame(ByVal Message As BinaryReader)

    On Error GoTo HandleFame_Err

    With UserReputacion
        .AsesinoRep = Message.ReadInt32()
        .BandidoRep = Message.ReadInt32()
        .BurguesRep = Message.ReadInt32()
        .LadronesRep = Message.ReadInt32()
        .NobleRep = Message.ReadInt32()
        .PlebeRep = Message.ReadInt32()
        .Promedio = Message.ReadInt32()

    End With

    LlegoFama = True
    Exit Sub
HandleFame_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleFame", Erl)

End Sub

''
' Handles the MiniStats message.
Public Sub HandleMiniStats(ByVal Message As BinaryReader)

    On Error GoTo HandleMiniStats_Err

    With UserEstadisticas
        .CiudadanosMatados = Message.ReadInt32()
        .CriminalesMatados = Message.ReadInt32()
        .UsuariosMatados = Message.ReadInt32()
        .NpcsMatados = Message.ReadInt()
        .Clase = ListaClases(Message.ReadInt())

        .PenaCarcel = Message.ReadInt32()

    End With

    Exit Sub
HandleMiniStats_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleMiniStats", Erl)

End Sub

''
' Handles the LevelUp message.
Public Sub HandleLevelUp(ByVal Message As BinaryReader)

    On Error GoTo HandleLevelUp_Err

    SkillPoints = Message.ReadInt()

    If SkillPoints > 0 Then
        Call frmMain.LightSkillStar(True)

    End If

    Exit Sub
HandleLevelUp_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleLevelUp", Erl)

End Sub

''
' Handles the SetInvisible message.
Public Sub HandleSetInvisible(ByVal Message As BinaryReader)

    On Error GoTo HandleSetInvisible_Err

    Dim CharIndex As Integer

    CharIndex = Message.ReadInt()

    'Debug.Print charlist(CharIndex).nombre

    If CharIndex = 0 Then Exit Sub

    charlist(CharIndex).Invisible = Message.ReadBool()

    charlist(CharIndex).Oculto = Message.ReadBool()

    'If CharIndex = UserCharIndex Then
    '    If SoyGM And charlist(CharIndex).Invisible Then
    '        charlist(CharIndex).iHead = 0
    '        charlist(CharIndex).iBody = 0
    '        charlist(CharIndex).Head = HeadData(charlist(CharIndex).iHead)
    '        charlist(CharIndex).body = BodyData(charlist(CharIndex).iBody)
    '        Call RefreshAllChars
    '    End If
    'End If

    If charlist(CharIndex).Invisible Then

        If charlist(CharIndex).CounterInvi = 0 Then
            charlist(CharIndex).CounterInvi = RandomNumber(1, 5)
            'charlist(CharIndex).CounterInvi = 1
        End If

    Else
        charlist(CharIndex).CounterInvi = 0
    End If

    Exit Sub
HandleSetInvisible_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleSetInvisible", Erl)

End Sub

''
' Handles the DiceRoll message.
Public Sub HandleDiceRoll(ByVal Message As BinaryReader)

    On Error GoTo HandleDiceRoll_Err

    UserAtributos(eAtributos.Fuerza) = Message.ReadInt()
    UserAtributos(eAtributos.Agilidad) = Message.ReadInt()
    UserAtributos(eAtributos.Inteligencia) = Message.ReadInt()
    UserAtributos(eAtributos.Carisma) = Message.ReadInt()
    UserAtributos(eAtributos.Constitucion) = Message.ReadInt()

    If Not frmCrearPersonaje.visible = True Then
        Call frmCrearPersonaje.Show

46      If modEngine_Audio.MusicEnabled Then
47          Call modEngine_Audio.PlayMusic("2.MID")
        End If

        Unload frmConnect    '@@PATCH
    End If

    With frmCrearPersonaje
        GuiTexto(eAtributos.Fuerza).Texto = UserAtributos(eAtributos.Fuerza)
        GuiTexto(eAtributos.Agilidad).Texto = UserAtributos(eAtributos.Agilidad)
        GuiTexto(eAtributos.Inteligencia).Texto = UserAtributos(eAtributos.Inteligencia)
        GuiTexto(eAtributos.Carisma).Texto = UserAtributos(eAtributos.Carisma)

        GuiTexto(eAtributos.Constitucion).Texto = UserAtributos(eAtributos.Constitucion)

    End With

    Exit Sub
HandleDiceRoll_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleDiceRoll", Erl)

End Sub

''
' Handles the MeditateToggle message.
Public Sub HandleMeditateToggle(ByVal Message As BinaryReader)

    On Error GoTo HandleMeditateToggle_Err

    UserMeditar = Not UserMeditar
    Exit Sub
HandleMeditateToggle_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleMeditateToggle", Erl)

End Sub

''
' Handles the BlindNoMore message.
Public Sub HandleBlindNoMore(ByVal Message As BinaryReader)

    On Error GoTo HandleBlindNoMore_Err

    UserCiego = False
    Exit Sub
HandleBlindNoMore_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBlindNoMore", Erl)

End Sub

''
' Handles the DumbNoMore message.
Public Sub HandleDumbNoMore(ByVal Message As BinaryReader)

    On Error GoTo HandleDumbNoMore_Err

    UserEstupido = False
    Exit Sub
HandleDumbNoMore_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleDumbNoMore", Erl)

End Sub

''
' Handles the SendSkills message.
Public Sub HandleSendSkills(ByVal Message As BinaryReader)

    On Error GoTo HandleSendSkills_Err

    UserClase = Message.ReadInt

    Dim i As Long

    For i = 1 To NUMSKILLS
        UserSkills(i) = Message.ReadInt()
        PorcentajeSkills(i) = Message.ReadInt()

    Next i

    LlegaronSkills = True
    Exit Sub
HandleSendSkills_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleSendSkills", Erl)

End Sub

''
' Handles the TrainerCreatureList message.
Public Sub HandleTrainerCreatureList(ByVal Message As BinaryReader)

    On Error GoTo HandleTrainerCreatureList_Err

    Dim creatures() As String

    Dim i As Long

    creatures = Split(Message.ReadString16(), SEPARATOR)

    For i = 0 To UBound(creatures())
        Call frmEntrenador.lstCriaturas.AddItem(creatures(i))
    Next i

    frmEntrenador.Show , frmMain

    Exit Sub
HandleTrainerCreatureList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleTrainerCreatureList", Erl)

End Sub

''
' Handles the GuildNews message.
Public Sub HandleGuildNews(ByVal Message As BinaryReader)

    On Error GoTo HandleGuildNews_Err

    Dim guildList() As String

    Dim i As Long

    Dim sTemp As String

    'Get news' string
    frmGuildNews.news = Message.ReadString16()

    'Get Enemy guilds list
    guildList = Split(Message.ReadString16(), SEPARATOR)

    For i = 0 To UBound(guildList)
        sTemp = frmGuildNews.txtClanesGuerra.Text
        frmGuildNews.txtClanesGuerra.Text = sTemp & guildList(i) & vbCrLf
    Next i

    'Get Allied guilds list
    guildList = Split(Message.ReadString16(), SEPARATOR)

    For i = 0 To UBound(guildList)
        sTemp = frmGuildNews.txtClanesAliados.Text
        frmGuildNews.txtClanesAliados.Text = sTemp & guildList(i) & vbCrLf
    Next i

    If ClientSetup.bGuildNews Then
        frmGuildNews.Show , frmMain

    End If

    Exit Sub
HandleGuildNews_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleGuildNews", Erl)

End Sub

''
' Handles the OfferDetails message.
Public Sub HandleOfferDetails(ByVal Message As BinaryReader)

    On Error GoTo HandleOfferDetails_Err

    Call frmUserRequest.recievePeticion(Message.ReadString16())
    Exit Sub
HandleOfferDetails_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleOfferDetails", Erl)

End Sub

''
' Handles the AlianceProposalsList message.
Public Sub HandleAlianceProposalsList(ByVal Message As BinaryReader)

    On Error GoTo HandleAlianceProposalsList_Err

    Dim vsGuildList() As String

    Dim i As Long

    vsGuildList = Split(Message.ReadString16(), SEPARATOR)

    Call frmPeaceProp.lista.Clear

    For i = 0 To UBound(vsGuildList())
        Call frmPeaceProp.lista.AddItem(vsGuildList(i))
    Next i

    frmPeaceProp.ProposalType = TIPO_PROPUESTA.ALIANZA

    frmPeaceProp.Show , frmMain

    Exit Sub
HandleAlianceProposalsList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleAlianceProposalsList", Erl)

End Sub

''
' Handles the PeaceProposalsList message.
Public Sub HandlePeaceProposalsList(ByVal Message As BinaryReader)

    On Error GoTo HandlePeaceProposalsList_Err

    Dim guildList() As String

    Dim i As Long

    guildList = Split(Message.ReadString16(), SEPARATOR)

    Call frmPeaceProp.lista.Clear

    For i = 0 To UBound(guildList())
        Call frmPeaceProp.lista.AddItem(guildList(i))
    Next i

    frmPeaceProp.ProposalType = TIPO_PROPUESTA.PAZ

    frmPeaceProp.Show , frmMain

    Exit Sub
HandlePeaceProposalsList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePeaceProposalsList", Erl)

End Sub

''
' Handles the CharacterInfo message.
Public Sub HandleCharacterInfo(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterInfo_Err

    With frmCharInfo

        If .frmType = CharInfoFrmType.frmMembers Then
            .imgRechazar.visible = False
            .imgAceptar.visible = False
            .imgEchar.visible = True
            .imgPeticion.visible = False
        Else
            .imgRechazar.visible = True
            .imgAceptar.visible = True
            .imgEchar.visible = False
            .imgPeticion.visible = True

        End If

        .nombre.Caption = .nombre.Caption & " " & Message.ReadString16()
        .Raza.Caption = .Raza.Caption & " " & ListaRazas(Message.ReadInt())
        .Clase.Caption = .Clase.Caption & " " & ListaClases(Message.ReadInt())

        If Message.ReadInt() = 1 Then
            .Genero.Caption = .Genero.Caption & " " & "Hombre"
        Else
            .Genero.Caption = .Genero.Caption & " " & "Mujer"

        End If

        .Nivel.Caption = .Nivel.Caption & " " & Message.ReadInt()
        .Oro.Caption = .Oro.Caption & " " & Message.ReadInt32()
        .Banco.Caption = .Banco.Caption & " " & Message.ReadInt32()

        If Message.ReadInt = 1 Then        'es criminal
            .status.Caption = .status.Caption & " Criminal"
            .status.ForeColor = vbRed
        Else
            .status.Caption = .status.Caption & " Ciudadano"
            .status.ForeColor = vbBlue

        End If

        .solicitudes.Caption = .solicitudes.Caption & " " & Message.ReadString16
        .fundo.Caption = "Fundó el clan: "

        Dim qclan As String

        qclan = Message.ReadString16
        qclan = Replace$(qclan, "<", "")
        qclan = Replace$(qclan, "", "")

        .fundo.Caption = "Fundó el clan: " & UCase$(qclan)
        .lider.Caption = .lider.Caption & " " & Message.ReadString16

        Dim TmpByte As Integer

        TmpByte = Message.ReadInt

        If TmpByte = 1 Then
            .faccion.Caption = .faccion.Caption & " Armada Real"
        ElseIf TmpByte = 2 Then
            .faccion.Caption = .faccion.Caption & " Legión Oscura"
        Else
            .faccion.Caption = .faccion.Caption & " Neutral"

        End If

        .Ciudadanos.Caption = .Ciudadanos.Caption & " " & CStr(Message.ReadInt32())
        .criminales.Caption = .criminales.Caption & " " & CStr(Message.ReadInt32())

        .reputacion.Caption = .reputacion.Caption & " " & Message.ReadInt32()

        Call .Show(vbModeless, frmMain)

    End With

    Exit Sub
HandleCharacterInfo_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterInfo", Erl)

End Sub

''
' Handles the GuildLeaderInfo message.
Public Sub HandleGuildLeaderInfo(ByVal Message As BinaryReader)

    On Error GoTo HandleGuildLeaderInfo_Err

    Dim i As Long

    Dim List() As String

    With frmGuildLeader
        'Get list of existing guilds
        GuildNames = Split(Message.ReadString16(), SEPARATOR)

        'Empty the list
        Call .guildslist.Clear

        For i = 0 To UBound(GuildNames())
            Call .guildslist.AddItem(GuildNames(i))
        Next i

        Dim tmpStr As String

        tmpStr = Message.ReadString16()

        'Get list of guild's members
        GuildMembers = Split(tmpStr, SEPARATOR)
        .Miembros.Caption = "El clan cuenta con " & CStr(UBound(GuildMembers()) + 1) & " miembros."

        'Empty the list
        Call .members.Clear

        For i = 0 To UBound(GuildMembers())
            Call .members.AddItem(GuildMembers(i))
        Next i

        tmpStr = Message.ReadString16
        .txtguildnews = Replace$(tmpStr, "|", vbCrLf)

        'Get list of join requests
        List = Split(Message.ReadString16(), SEPARATOR)

        'Empty the list
        Call .solicitudes.Clear

        For i = 0 To UBound(List())
            Call .solicitudes.AddItem(List(i))
        Next i

        .Show , frmMain

    End With

    Exit Sub
HandleGuildLeaderInfo_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleGuildLeaderInfo", Erl)

End Sub

''
' Handles the GuildDetails message.
Public Sub HandleGuildDetails(ByVal Message As BinaryReader)

    On Error GoTo HandleGuildDetails_Err

    With frmGuildBrief
        .nombre.Caption = "Nombre: " & Message.ReadString16()
        .fundador.Caption = "Fundador: " & Message.ReadString16()
        .creacion.Caption = "Fecha de creación: " & Message.ReadString16()
        .lider.Caption = "Lider: " & Message.ReadString16()
        .web.Caption = "Web Site: " & Message.ReadString16()
        .Miembros.Caption = "Miembros: " & Message.ReadInt()

        If Message.ReadBool() Then
            .eleccion.Caption = "Elecciones: ABIERTAS"
        Else
            .eleccion.Caption = "Elecciones: CERRADAS"

        End If

        .lblAlineacion.Caption = "Alineación: " & Message.ReadString16()
        .Enemigos.Caption = "Clanes enemigos: " & Message.ReadInt()
        .Aliados.Caption = "clanes aliados: " & Message.ReadInt()
        .Antifaccion.Caption = "Puntos de antifacción: " & Message.ReadString16()

        Dim codexStr() As String

        Dim i As Long

        codexStr = Split(Message.ReadString16(), SEPARATOR)

        For i = 0 To 7
            .Codex(i).Caption = codexStr(i)
        Next i

        .Desc.Text = Message.ReadString16()

    End With

    frmGuildBrief.Show vbModeless, frmMain

    Exit Sub
HandleGuildDetails_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleGuildDetails", Erl)

End Sub

''
' Handles the ShowGuildFundationForm message.
Public Sub HandleShowGuildFundationForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowGuildFundationForm_Err

    CreandoClan = True
    frmGuildFoundation.Show , frmMain
    Exit Sub
HandleShowGuildFundationForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowGuildFundationForm", Erl)

End Sub

''
' Handles the ParalizeOK message.
Public Sub HandleParalizeOK(ByVal Message As BinaryReader)

    On Error GoTo HandleParalizeOK_Err

    UserParalizado = Not UserParalizado
    Exit Sub
HandleParalizeOK_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleParalizeOK", Erl)

End Sub

''
' Handles the ShowUserRequest message.

Public Sub HandleShowUserRequest(ByVal Message As BinaryReader)

    On Error GoTo HandleShowUserRequest_Err

    Call frmUserRequest.recievePeticion(Message.ReadString16())

    Call frmUserRequest.Show(vbModeless, frmMain)

    Exit Sub
HandleShowUserRequest_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowUserRequest", Erl)

End Sub

''
' Handles the TradeOK message.
Public Sub HandleTradeOK(ByVal Message As BinaryReader)

    On Error GoTo HandleTradeOK_Err

    If frmComerciar.visible Then

        Dim i As Long

        'Update user inventory
        For i = 1 To MAX_INVENTORY_SLOTS

            ' Agrego o quito un item en su totalidad
            If Inventario.ObjIndex(i) <> InvComUsu.ObjIndex(i) Then

                With Inventario
                    Call InvComUsu.SetItem(i, .ObjIndex(i), .amount(i), .Equipped(i), .GrhIndex(i), .ObjType(i), .MaxHit(i), .MinHit(i), .MaxDef(i), .MinDef(i), .Valor(i), .ItemName(i))

                End With

                ' Vendio o compro cierta cantidad de un item que ya tenia
            ElseIf Inventario.amount(i) <> InvComUsu.amount(i) Then
                Call InvComUsu.ChangeSlotItemAmount(i, Inventario.amount(i))

            End If

        Next i

        ' Fill Npc inventory
        For i = 1 To 20

            ' Compraron la totalidad de un item, o vendieron un item que el npc no tenia
            If NPCInventory(i).ObjIndex <> InvComNpc.ObjIndex(i) Then

                With NPCInventory(i)
                    Call InvComNpc.SetItem(i, .ObjIndex, .amount, 0, .GrhIndex, .ObjType, .MaxHit, .MinHit, .MaxDef, .MinDef, .Valor, .Name)

                End With

                ' Compraron o vendieron cierta cantidad (no su totalidad)
            ElseIf NPCInventory(i).amount <> InvComNpc.amount(i) Then
                Call InvComNpc.ChangeSlotItemAmount(i, NPCInventory(i).amount)

            End If

        Next i

    End If

    Exit Sub
HandleTradeOK_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleTradeOK", Erl)

End Sub

''
' Handles the BankOK message.
Public Sub HandleBankOK(ByVal Message As BinaryReader)

    On Error GoTo HandleBankOK_Err

    Dim i As Long

    If frmBancoObj.visible Then

        For i = 1 To Inventario.MaxObjs

            With Inventario
                Call InvBanco(1).SetItem(i, .ObjIndex(i), .amount(i), .Equipped(i), .GrhIndex(i), .ObjType(i), .MaxHit(i), .MinHit(i), .MaxDef(i), .MinDef(i), .Valor(i), .ItemName(i))

            End With

        Next i

        'Alter order according to if we bought or sold so the labels and grh remain the same
        If frmBancoObj.LasActionBuy Then
            'frmBancoObj.List1(1).ListIndex = frmBancoObj.LastIndex2
            'frmBancoObj.List1(0).ListIndex = frmBancoObj.LastIndex1
        Else

            'frmBancoObj.List1(0).ListIndex = frmBancoObj.LastIndex1
            'frmBancoObj.List1(1).ListIndex = frmBancoObj.LastIndex2
        End If

        frmBancoObj.NoPuedeMover = False

    End If

    Exit Sub
HandleBankOK_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBankOK", Erl)

End Sub

''
' Handles the ChangeUserTradeSlot message.
Public Sub HandleChangeUserTradeSlot(ByVal Message As BinaryReader)

    On Error GoTo HandleChangeUserTradeSlot_Err

    Dim OfferSlot As Integer

    OfferSlot = Message.ReadInt

    Dim cant As Long

    Dim ObjIndex As Integer

    cant = Message.ReadInt32

    If cant > 0 Then
        ObjIndex = Message.ReadInt

        If OfferSlot = GOLD_OFFER_SLOT Then
            frmComerciarUsu.lblOroOtro.Caption = format$(cant, "###,###,###")
        Else
            Call InvOfferComUsu(1).SetItem(OfferSlot, ObjIndex, cant, 0, DataObj(ObjIndex).GrhIndex, DataObj(ObjIndex).ObjType, DataObj(ObjIndex).MaxHit, DataObj(ObjIndex).MinHit, DataObj(ObjIndex).MaxDef, DataObj(ObjIndex).MinDef, SalePrice(ObjIndex), DataObj(ObjIndex).nombre)

        End If

    End If

    frmComerciarUsu.Label2.visible = False

    Call frmComerciarUsu.PrintCommerceMsg(TradingUserName & " ha modificado su oferta (" & IIf(OfferSlot = GOLD_OFFER_SLOT, "ORO", "ITEMS") & ").", FontTypeNames.FONTTYPE_VENENO)

    Exit Sub
HandleChangeUserTradeSlot_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleChangeUserTradeSlot", Erl)

End Sub

''
' Handles the SpawnList message.

Public Sub HandleSpawnList(ByVal Message As BinaryReader)

    On Error GoTo HandleSpawnList_Err

    Dim creatureList() As String

    Dim i As Long

    creatureList = Split(Message.ReadString16(), SEPARATOR)

    For i = 0 To UBound(creatureList())
        Call frmSpawnList.lstCriaturas.AddItem(creatureList(i))
    Next i

    frmSpawnList.Show , frmMain

    Exit Sub
HandleSpawnList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleSpawnList", Erl)

End Sub

''
' Handles the ShowSOSForm message.
Public Sub HandleShowSOSForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowSOSForm_Err

    Dim sosList() As String

    sosList = Split(Message.ReadString16(), SEPARATOR)
    Dim j As Long

    For j = LBound(sosList) To UBound(sosList)
        Call ShowConsoleMsg(sosList(j))
    Next j
    Exit Sub
HandleShowSOSForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowSOSForm", Erl)

End Sub

''
' Handles the ShowGMPanelForm message.
Public Sub HandleShowGMPanelForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowGMPanelForm_Err

    frmPanelGm.Show vbModeless, frmMain
    Exit Sub
HandleShowGMPanelForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowGMPanelForm", Erl)

End Sub

''
' Handles the UserNameList message.
Public Sub HandleUserNameList(ByVal Message As BinaryReader)

    On Error GoTo HandleUserNameList_Err

    Dim userList() As String

    Dim i As Long

    userList = Split(Message.ReadString16(), SEPARATOR)

    If frmPanelGm.visible Then
        frmPanelGm.cboListaUsus.Clear

        For i = 0 To UBound(userList())
            Call frmPanelGm.cboListaUsus.AddItem(userList(i))
        Next i

        If frmPanelGm.cboListaUsus.ListCount > 0 Then frmPanelGm.cboListaUsus.ListIndex = 0

    End If

    Exit Sub
HandleUserNameList_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUserNameList", Erl)

End Sub

''
' Handles the Pong message.

Public Sub HandlePong(ByVal Message As BinaryReader)

    On Error GoTo HandlePong_Err

    Dim lag As Long

    lag = timeGetTime() - PingTick

    Call AddtoRichTextBox(frmMain.RecTxt, "El ping es " & (lag) & " ms.", 255, 0, 0, True, False, True)

    Exit Sub
HandlePong_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePong", Erl)

End Sub

''
' Handles the UpdateTag message.
Public Sub HandleUpdateTagAndStatus(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateTagAndStatus_Err

    Dim CharIndex As Integer

    Dim NickColor As Integer

    Dim tmpStr As String

    Dim clanPos As Byte

    Dim LoopC As Long


1   CharIndex = Message.ReadInt()
2   NickColor = Message.ReadInt()
3   tmpStr = Message.ReadString16

    'Update char status adn tag!
    With charlist(CharIndex)

4       If (NickColor And eNickColor.ieCriminal) <> 0 Then
5           .Criminal = 1
6       Else
            .Criminal = 0
        End If

7       .Atacable = (NickColor And eNickColor.ieAtacable) <> 0

8       .Mimetizado = (InStr(1, tmpStr, Chr$(45)) > 0)
9       If .Mimetizado Then tmpStr = Replace$(tmpStr, Chr$(45), "")

12      clanPos = InStr(1, tmpStr, "<")

        If esGM(UserCharIndex) Then
            .Invisible = (InStr(1, tmpStr, Chr$(124)) > 0)
            tmpStr = Replace$(tmpStr, Chr$(124), "")
        End If

13      If Not esGM(CharIndex) Or .Mimetizado Then
14          If .Atacable Then
15              .color = D3DColorXRGB(ColoresPJ(1).r, ColoresPJ(1).g, ColoresPJ(1).b)
            Else

16              If .Criminal Then
17                  .color = D3DColorXRGB(ColoresPJ(7).r, ColoresPJ(7).g, ColoresPJ(7).b)
                Else
18                  .color = D3DColorXRGB(ColoresPJ(8).r, ColoresPJ(8).g, ColoresPJ(8).b)
                End If

19              charlist(CharIndex).isFaccion = 0

20              If InStr(1, tmpStr, Chr(47)) > 0 Then
21                  tmpStr = Replace$(tmpStr, Chr(47), vbNullString)
22                  charlist(CharIndex).isFaccion = FaccionType.RoyalCouncil
                    ColoresPJ(10).r = 40
                    ColoresPJ(10).g = 190
                    ColoresPJ(10).b = 220
27                  charlist(CharIndex).color = D3DColorXRGB(ColoresPJ(10).r, ColoresPJ(10).g, ColoresPJ(10).b)

23              ElseIf InStr(1, tmpStr, Chr(42)) > 0 Then
24                  tmpStr = Replace$(tmpStr, Chr(42), vbNullString)
25                  charlist(CharIndex).isFaccion = FaccionType.ChaosCouncil
26                  charlist(CharIndex).color = D3DColorXRGB(ColoresPJ(9).r, ColoresPJ(9).g, ColoresPJ(9).b)

                End If

            End If
        Else
28          .color = D3DColorXRGB(ColoresPJ(.priv).r, ColoresPJ(.priv).g, ColoresPJ(.priv).b)
        End If


        'ocultar?
29      If clanPos > 0 Then
30          .clan = mid$(tmpStr, clanPos)

31          .nombre = (Left$(tmpStr, clanPos - 2))

32          If CharIndex = UserCharIndex And .Mimetizado = False Then

33              For LoopC = 0 To 8
34                  frmMain.lblName(LoopC).Caption = .nombre & vbCrLf & .clan
                Next LoopC

                'frmMain.LblName(0).Caption = .nombre & vbCrLf & .clan
            End If

        Else
35          .nombre = tmpStr
            .clan = ""

36          If CharIndex = UserCharIndex And .Mimetizado = False Then

                For LoopC = 0 To 8
37                  frmMain.lblName(LoopC).Caption = .nombre
                Next LoopC

                'frmMain.LblName(0).Caption = .nombre
            End If

        End If

38      .clan = Replace$(.clan, Chr(42), vbNullString)
39      .clan = Replace$(.clan, Chr(47), vbNullString)

    End With

    Exit Sub
HandleUpdateTagAndStatus_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateTagAndStatus", Erl)

End Sub

Private Sub HandleConnected(ByVal Message As BinaryReader)
    Call Login
End Sub

Public Sub HandleCreateDamage(ByVal Message As BinaryReader)

    On Error GoTo HandleCreateDamage_Err

    Dim CharIndex As Integer

    Dim Value As Integer

    Dim r As Integer, g As Integer, b As Integer

    CharIndex = Message.ReadInt
    Value = Message.ReadInt
    r = Message.ReadInt
    g = Message.ReadInt
    b = Message.ReadInt
    Call RenderFontMap(charlist(CharIndex).Pos.X, charlist(CharIndex).Pos.Y, Value, r, g, b)

    ' Deprecated!

    'Call mod_Damages.CreateDamage(.readstring16, .Readint, .Readint, .Readint, .Readint, .Readint)

    Exit Sub
HandleCreateDamage_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCreateDamage", Erl)

End Sub

Public Sub HandleSetCombatMode(ByVal Message As BinaryReader)

    On Error GoTo HandleSetCombatMode_Err

    ModoCombate = Message.ReadBool

    ' TDS Style

    If UsingSkill = Magia Then UsingSkill = 0: frmMain.MousePointer = 0

    Exit Sub
HandleSetCombatMode_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleSetCombatMode", Erl)

End Sub

Sub HandleSendPartyData(ByVal Message As BinaryReader)

    On Error GoTo HandleSendPartyData_Err

    Dim IsLeader As Boolean

    IsLeader = Message.ReadBool()

    Dim LoopC As Long

    Dim Temp() As String

    If IsLeader Then
        ' ++ Solicitudes
        Temp() = Split(Message.ReadString16, ",")

        frmParty.List1.Enabled = True
        frmParty.List1.Clear

        For LoopC = 0 To UBound(Temp())

            If LenB(Temp(LoopC)) > 0 Then frmParty.List1.AddItem Temp(LoopC)
        Next LoopC

    End If

    Dim r_String As String

    r_String = Message.ReadString16

    frmParty.Label11.Caption = vbNullString & format$(CStr(Message.ReadReal64), "#,###")

    If frmParty.Label11.Caption = vbNullString Then frmParty.Label11.Caption = "0"

    Call frmParty.PrepararForm(IsLeader, r_String)
    frmParty.Show , frmMain

    Exit Sub
HandleSendPartyData_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleSendPartyData", Erl)

End Sub

Public Sub HandleCreateProjectile(ByVal Message As BinaryReader)

    On Error GoTo HandleCreateProjectile_Err

    Dim UserIndex As Integer

    Dim VictimIndex As Integer

    Dim GrhIndex As Integer

        UserIndex = Message.ReadInt
        VictimIndex = Message.ReadInt
        GrhIndex = Message.ReadInt
        Call RenderProjectile(UserIndex, VictimIndex, GrhIndex, 1)

        'Deprecated
        'Engine_Projectile_Create UserIndex, VictimIndex, GrhIndex


    Exit Sub
HandleCreateProjectile_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCreateProjectile", Erl)

End Sub

Public Sub HandleMovimientSW(ByVal Message As BinaryReader)

    On Error GoTo HandleMovimientSW_Err

    Dim Char As Integer
    Dim MovimientClass As Integer

    Char = Message.ReadInt()
    MovimientClass = Message.ReadInt()

    With charlist(Char)

        If tSetup.EfectosPelea = False Then Exit Sub
        .Arma.WeaponWalk(.Heading).Started = 1
        .Escudo.ShieldWalk(.Heading).Started = 1
        .Movimient = True

    End With

    Exit Sub
HandleMovimientSW_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleMovimientSW", Erl)

End Sub

Public Sub HandleDataSTR(ByVal Data As String)

    On Error GoTo HandleDataSTR_Err

    Select Case UCase$(Right$(Data, Len(Data) - 1))

    Case "RESETUPD"
        MsgBox "Hay una nueva actualización, se reiniciará el cliente para instalarla."
        Call ShellExecute(0, "Open", App.Path & "\TDS Legacy.exe", App.EXEName & ".exe", App.Path, SW_SHOWNORMAL)
        Call Mod_General.CloseClient    'End

    End Select

    Exit Sub
HandleDataSTR_Err:
    Call RegistrarError(Err.Number, Err.Description, "String)", Erl)

End Sub

Public Sub HandleCloseClient(ByVal Message As BinaryReader)

    On Error GoTo HandleCloseClient_Err

    Call Mod_General.CloseClient
    Exit Sub
HandleCloseClient_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCloseClient", Erl)

End Sub

Public Sub HandleUpdateEnvenenado(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateEnvenenado_Err

    'Get data and update form
    Envenenado = Message.ReadInt
    Exit Sub
HandleUpdateEnvenenado_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateEnvenenado", Erl)

End Sub

Public Sub HandleMensajeshort(ByVal Message As BinaryReader)

    On Error GoTo HandleMensajeshort_Err

    Dim MensajeId As Integer

    MensajeId = Message.ReadInt

    Dim chat As String
    Dim str As String
    Dim r As Byte
    Dim g As Byte
    Dim b As Byte

    chat = "!! Mensaje_ID: " & MensajeId

    If MensajeId <= UBound(Mensaje) Then
        chat = Mensaje(MensajeId)

    End If

    If InStr(1, chat, "~") Then
        str = ReadField(2, chat, 126)

        If Val(str) > 255 Then
            r = 255
        Else
            r = Val(str)

        End If

        str = ReadField(3, chat, 126)

        If Val(str) > 255 Then
            g = 255
        Else
            g = Val(str)

        End If

        str = ReadField(4, chat, 126)

        If Val(str) > 255 Then
            b = 255
        Else
            b = Val(str)

        End If

        If frmMain.visible Then
            Call AddtoRichTextBox(frmMain.RecTxt, Left$(chat, InStr(1, chat, "~") - 1), r, g, b, Val(ReadField(5, chat, 126)) <> 0, Val(ReadField(6, chat, 126)) <> 0)

        End If

    Else

        With FontTypes(FontTypeNames.FONTTYPE_INFO)
            Call AddtoRichTextBox(frmMain.RecTxt, chat, .red, .green, .blue, .bold, .italic)

        End With

    End If

    Exit Sub
HandleMensajeshort_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleMensajeshort", Erl)

End Sub

Public Sub HandlePartyDetails(ByVal Message As BinaryReader)

    On Error GoTo HandlePartyDetails_Err

    Dim nMem As Integer, CharName As String, i As Long

    nMem = Message.ReadInt

    For i = 1 To nMem
        CharName = Message.ReadString16

        If Len(CharName) > 0 Then
            Call Set_PartyMember(i, CharName, Message.ReadReal64)
        Else
            Call Kick_PartyMember(i)

        End If

    Next i

    Exit Sub
HandlePartyDetails_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePartyDetails", Erl)

End Sub

Public Sub HandlePartyExit(ByVal Message As BinaryReader)

    On Error GoTo HandlePartyExit_Err

    Dim i As Long

    For i = 1 To 5
        Call Kick_PartyMember(CLng(i))
    Next i

    Unload frmParty
    Unload frmPartyPorc

    Exit Sub
HandlePartyExit_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandlePartyExit", Erl)

End Sub

Public Sub HandleUpdateStatsNew(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateStatsNew_Err

    Dim X As Long

    UserMinHP = Message.ReadInt
    UserMinMAN = Message.ReadInt
    UserMinSTA = Message.ReadInt

    For X = 0 To 8
        frmMain.lblMana(X) = UserMinMAN & "/" & UserMaxMAN
        frmMain.lblVida(X) = UserMinHP & "/" & UserMaxHP
        frmMain.lblEnergia(X) = UserMinSTA & "/" & UserMaxSTA
    Next X

    If UserMinMAN > 0 Then
        frmMain.MANShp.Width = (((UserMinMAN / 100) / (UserMaxMAN / 100)) * 97)
    Else
        frmMain.MANShp.Width = 0
    End If

    If UserMinHP > 0 Then
        frmMain.Hpshp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 97)
    Else
        frmMain.Hpshp.Width = 0
    End If

    If UserMinSTA > 0 Then
        frmMain.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 97)
    Else
        frmMain.STAShp.Width = 0
    End If

    If UserMinHP > 0 Then
        UserEstado = 0
    Else
        UserEstado = 1
        If frmMain.TrainingMacro Then Call frmMain.DesactivarMacroHechizos
        If frmMain.macrotrabajo Then Call frmMain.DesactivarMacroTrabajo
        Envenenado = 0
    End If

    If UserGLD >= 100000 Then
        frmMain.GldLbl.ForeColor = &HFF&
    Else
        frmMain.GldLbl.ForeColor = &HFFFF&
    End If

    Exit Sub
HandleUpdateStatsNew_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateStatsNew", Erl)

End Sub

Public Sub HandleUpdateFaccion(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateFaccion_Err

    Select Case Message.ReadInt

    Case 1
        UserReputacion.ArmadaReal = 1
        UserReputacion.FuerzasCaos = 0

    Case 2
        UserReputacion.ArmadaReal = 0
        UserReputacion.FuerzasCaos = 1

    Case Else
        UserReputacion.ArmadaReal = 0

        UserReputacion.FuerzasCaos = 0

    End Select

    Exit Sub
HandleUpdateFaccion_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleUpdateFaccion", Erl)

End Sub

Public Sub HandleCharacterChangeBody(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeBody_Err

    Call Char_SetBody(Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleCharacterChangeBody_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeBody", Erl)

End Sub

Public Sub HandleCharacterChangeWeapon(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeWeapon_Err

    Call Char_SetWeapon(Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleCharacterChangeWeapon_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeWeapon", Erl)

End Sub

Public Sub HandleCharacterChangeHelmet(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeHelmet_Err

    Call Char_SetCasco(Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleCharacterChangeHelmet_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeHelmet", Erl)

End Sub

Public Sub HandleCharacterChangeShield(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeShield_Err

    Call Char_SetShield(Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleCharacterChangeShield_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeShield", Erl)

End Sub

Public Sub HandleCharacterChangeSpecial(ByVal Message As BinaryReader)

    On Error GoTo HandleCharacterChangeSpecial_Err

    Call Char_SetSpecial(Message.ReadInt, Message.ReadInt)

    Exit Sub
HandleCharacterChangeSpecial_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleCharacterChangeSpecial", Erl)

End Sub


Private Sub HandleCharacterMoves(ByVal Message As BinaryReader, ByVal Heading As Long)
'***************************************************
'Author: Juan Mazotti (Lherkiev)
'Last Modification: 06/06/19
'***************************************************

    Dim CharIndex As Integer

    CharIndex = Char_Find(Message.ReadInt)

    If Char_Check(CharIndex) Then
        Call MoveCharbyHead(CharIndex, Heading)

    End If

    Call RefreshAllChars

End Sub

Private Sub HandleChangeHeading(ByVal Message As BinaryReader)

    Dim CharIndex As Integer

    Dim Heading As Byte

    CharIndex = Char_Find(Message.ReadInt)
    Heading = Message.ReadInt8

    Call Char_SetHeading(CharIndex, Heading)

End Sub

Private Sub HandleSetCuentaRegresiva(ByVal Message As BinaryReader)

    CountTime = Message.ReadInt8

    If CountTime > 0 Then
        CountFinish = 0
    End If

End Sub

Public Sub HandleShowBorrarPjForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowBorrarPjForm_Err

    frmBorrarPersonaje.Show , frmMain

    Exit Sub
HandleShowBorrarPjForm_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleShowBorrarPjForm", Erl)

End Sub

Public Sub HandleBorrarMensajeConsola(ByVal Message As BinaryReader)

    On Error GoTo HandleBorrarMensajeConsola_Err

    If Message.ReadInt8 = 1 Then
        Call ReemplazarMensaje(Message.ReadString16, Message.ReadString16)
    Else
        Call BorrarMensaje(Message.ReadString16)
    End If

    frmMain.RecTxt.Locked = True

    Exit Sub
HandleBorrarMensajeConsola_Err:
    Call RegistrarError(Err.Number, Err.Description, "HandleBorrarMensajeConsola", Erl)

End Sub

Public Sub HandleShowResetearPjForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowResetearPjForm_Err

    frmYesOrNo.msg.Caption = "Estás seguro de resetear tu personaje?"

    AccionYesOrNo = 1

    frmYesOrNo.Show , frmMain

    Exit Sub
HandleShowResetearPjForm_Err:
    Call RegistrarError(Err.Number, Err.Description, 3, Erl)

End Sub

Public Sub HandleSetEfectoNick(ByVal Message As BinaryReader)

    On Error GoTo HandleSetEfectoNick_Err

    EfectoEspecialNick = Message.ReadInt = 1

    Exit Sub
HandleSetEfectoNick_Err:
    Call RegistrarError(Err.Number, Err.Description, 2, Erl)

End Sub

Public Sub HandleUpdateCharData(ByVal Message As BinaryReader)

    On Error GoTo HandleUpdateCharData_Err

    Dim CharIndex As Integer

    CharIndex = Char_Find(Message.ReadInt)

    Dim Mimetizado As Byte
    Dim Paralizado As Byte
    Dim Inmovilizado As Byte
    Dim Envenenado As Byte
    Dim Trabajando As Integer
    Dim IdleCount As Integer

    Mimetizado = Message.ReadInt8
    Paralizado = Message.ReadInt8
    Inmovilizado = Message.ReadInt8
    Envenenado = Message.ReadInt8
    Trabajando = Message.ReadInt
    IdleCount = Message.ReadInt

    If Char_Check(CharIndex) Then
        With charlist(CharIndex)
            .Mimetizado = Mimetizado
            .Paralizado = Paralizado
            .Inmovilizado = Inmovilizado
            .Envenenado = Envenenado
            .Trabajando = Trabajando
            .IdleCount = IdleCount
        End With
    End If

    Exit Sub
HandleUpdateCharData_Err:
    Call RegistrarError(Err.Number, "u " & Err.Description, 1, Erl)

End Sub

Public Sub HandleInitWorking(ByVal Message As BinaryReader)

    On Error GoTo HandleInitWorking_Err

    frmMain.macrotrabajo.Enabled = Message.ReadInt8

    Exit Sub
HandleInitWorking_Err:
    Call RegistrarError(Err.Number, "IW:" & Err.Description, 1, Erl)

End Sub

Public Sub HandleShowSpecialForm(ByVal Message As BinaryReader)

    On Error GoTo HandleShowSpecialForm_Err

    Dim newNick As String

    Select Case Message.ReadInt
    Case 1
        ' Cambio de rostro
        UserSexo = Message.ReadInt8
        UserRaza = Message.ReadInt8

        frmCambioRostro.Show , frmMain
    Case 2
        ' Cambio de nick
        newNick = Trim$(InputBox("Ingrese el nuevo nombre que deseas tener", "Cambio de nick"))

        If Len(newNick) Then
            Call WriteCambiarNick(newNick)
        End If

    Case 3
        ' Cambio de clan
        newNick = Trim$(InputBox("Ingrese el nuevo nombre del clan que deseas tener", "Cambio de nombre de clan"))

        If Len(newNick) Then
            Call WriteCambiarNickClan(newNick)
        End If

    End Select
    Exit Sub
HandleShowSpecialForm_Err:
    Call RegistrarError(Err.Number, "HandleShowSpecialForm:" & Err.Description, 1, Erl)

End Sub

Private Sub HandleQuestDetails(ByVal Message As BinaryReader)
    Dim tmpStr As String
    Dim TmpByte As Byte
    Dim TmpLong As Long
    Dim QuestEmpezada As Boolean
    Dim i As Long

    QuestEmpezada = IIf(Message.ReadInt8, True, False)

    tmpStr = "Misión: " & Message.ReadString16 & vbCrLf
    tmpStr = tmpStr & "Detalles: " & Message.ReadString16 & vbCrLf
    tmpStr = tmpStr & "Nivel requerido: " & Message.ReadInt8 & vbCrLf

    tmpStr = tmpStr & vbCrLf & "OBJETIVOS" & vbCrLf

    TmpByte = Message.ReadInt8

    If TmpByte Then        'Hay NPCs
        For i = 1 To TmpByte
            tmpStr = tmpStr & "*) Matar " & format$(Message.ReadInt, "#,###,###,###") & " " & DataNpcs(Message.ReadInt).nombre & "."

            If QuestEmpezada Then
                tmpStr = tmpStr & " (Has matado " & format$(Message.ReadInt, "#,###,###,###") & ")" & vbCrLf
            Else
                tmpStr = tmpStr & vbCrLf
            End If
        Next i
    End If

    TmpByte = Message.ReadInt8

    If TmpByte Then        'Hay OBJs
        For i = 1 To TmpByte
            tmpStr = tmpStr & "*) Conseguir " & format$(Message.ReadInt, "#,###,###,###") & " " & DataObj(Message.ReadInt).nombre & "." & vbCrLf
        Next i
    End If

    tmpStr = tmpStr & vbCrLf & "RECOMPENSAS" & vbCrLf

    TmpLong = Message.ReadInt32

    If TmpLong > 0 Then
        tmpStr = tmpStr & "*) Oro: " & format$(TmpLong, "#,###,###,###") & " monedas de oro." & vbCrLf
    End If

    TmpLong = Message.ReadInt32

    If TmpLong > 0 Then
        tmpStr = tmpStr & "*) Canjes: " & format$(TmpLong, "#,###,###,###") & " puntos de canje." & vbCrLf
    End If

    TmpLong = Message.ReadInt32

    If TmpLong > 0 Then
        tmpStr = tmpStr & "*) Experiencia: " & format$(TmpLong, "#,###,###,###") & " puntos de experiencia." & vbCrLf
    End If

    TmpByte = Message.ReadInt8

    If TmpByte Then
        For i = 1 To TmpByte
            tmpStr = tmpStr & "*) " & format$(Message.ReadInt16, "#,###,###,###") & " " & DataObj(Message.ReadInt16).nombre & vbCrLf
        Next i
    End If


    'Determinamos que formulario se muestra, según si recibimos la información y la quest está empezada o no.
    If QuestEmpezada Then
        frmQuests.txtInfo.Text = tmpStr
    Else
        frmQuestInfo.txtInfo.Text = tmpStr
        frmQuestInfo.Show vbModeless, frmMain
    End If

End Sub

Private Sub HandleQuestListSend(ByVal Message As BinaryReader)

    Dim i As Long
    Dim cantQuests As Byte
    Dim tmpStr As String

    'Leemos la cantidad de quests que tiene el usuario
    cantQuests = Message.ReadInt

    'Limpiamos el ListBox y el TextBox del formulario
    frmQuests.lstQuests.Clear
    frmQuests.txtInfo.Text = vbNullString

    If cantQuests Then
        tmpStr = Message.ReadString16
        For i = 1 To cantQuests
            frmQuests.lstQuests.AddItem ReadField(i, tmpStr, 45)
        Next i
    End If

    If cantQuests <> 0 Then
        frmQuests.Show vbModeless, frmMain
    Else
        Unload frmQuests
    End If

    'Pedimos la información de la primer quest (si la hay)
    If cantQuests Then Call WriteQuestDetailsRequest(1)

End Sub

Private Sub HandleCVCListSend(ByVal Message As BinaryReader)

    Select Case Message.ReadInt16
    
        Case mCVC_Accion.cvc_EnviarSolicitud    ' @@ Recibe solicitud de CVC
            Dim maxUsers As Byte
            maxUsers = Message.ReadInt16
            CVC_GuildRequest = Message.ReadString16
            frmYesOrNo.msg.Caption = "El clan " & Chr(34) & CVC_GuildRequest & Chr(34) & vbNewLine & "Te desafia en un reto Clan vs Clan" & vbNewLine & "Jugadores máximos permitidos: " & maxUsers
            AccionYesOrNo = 4
            frmYesOrNo.Show , frmMain
    
        Case mCVC_Accion.cvc_AceptarSolicitud    ' @@ Le aceptaron la solicitud de CVC
            Call frmPrepareCVC.CVC_HandleAceptarSolicitud(Message.ReadInt16, Message.ReadInt16, Message.ReadInt16, Message.ReadInt32, Message.ReadString16, Message.ReadString16, Message.ReadString16, Message.ReadInt32, Message.ReadString16, Message.ReadString16, Message.ReadString16)
            
        Case mCVC_Accion.cvc_RechazarSolicitud, mCVC_Accion.cvc_Cancelar
            Unload frmPrepareCVC
            
        Case mCVC_Accion.cvc_CambiarSeleccion    ' @@ Cambió la selección de jugadores
            Call frmPrepareCVC.CVC_HandleCambiarSeleccion(Message.ReadBool, Message.ReadString16, Message.ReadString16)
    
        Case mCVC_Accion.cvc_ConfirmarSeleccion    ' @@ Le confirmaron la selección de jugadores
            Call frmPrepareCVC.cvc_HandleConfirmarSeleccion(Message.ReadBool, Message.ReadInt16)
    
        Case mCVC_Accion.cvc_EstoyListo    ' @@ Uno de los jugadores está listo para empezar
            Dim tipo As Byte, NickName As String
            tipo = Message.ReadInt16
            If tipo = 3 Then NickName = Message.ReadString16
            Call frmPrepareCVC.CVC_HandleEstoyListo(tipo, NickName)
                
        Case mCVC_Accion.cvc_Iniciar
            Call frmPrepareCVC.CVC_HandleIniciar(Message.ReadBool)
    End Select

End Sub

Public Sub HandleShowCVCInvitation(ByVal Message As BinaryReader)

    On Error GoTo HandleShowResetearPjForm_Err
    
    CVC_GuildRequest = Message.ReadString16
    
    frmYesOrNo.msg.Caption = "El clan " & Chr(34) & CVC_GuildRequest & Chr(34) & vbNewLine & "Te desafia en un reto Clan vs Clan" & vbNewLine & "Jugadores máximos permitidos: " & Message.ReadInt8

    AccionYesOrNo = 4

    frmYesOrNo.Show , frmMain

    Exit Sub
HandleShowResetearPjForm_Err:
    Call RegistrarError(Err.Number, Err.Description, 3, Erl)

End Sub

Private Sub HandleDecirPalabrasMagicas(ByVal Message As BinaryReader)

    Dim Spell As Byte

    Dim CharIndex As Integer

    Spell = Message.ReadInt8
    CharIndex = Char_Find(Message.ReadInt16)

    If Spell < 1 Or Spell > NumSpells Then Exit Sub

    'Only add the chat if the character exists (a CharacterRemove may have been sent to the PC / NPC area before the buffer was flushed)
    If Char_Check(CharIndex) Then
        Call Dialogos.CreateDialog(DataSpells(Spell).PalabrasMagicas, CharIndex, vbCyan, 1)
    End If

End Sub
