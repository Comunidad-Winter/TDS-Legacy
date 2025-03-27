Attribute VB_Name = "Protocol_Writes"
Option Explicit

Private Const SEPARATOR As String * 1 = vbNullChar

Public LastKeyUseItem As Byte
Public LastKeyDropObj As Byte

Private Type tFont
    red As Byte
    green As Byte
    blue As Byte
    bold As Boolean
    italic As Boolean
End Type

Private Writer_ As BinaryWriter

Public Sub Initialize()

    Set Writer_ = New BinaryWriter
    
End Sub

Public Sub WriteLoginExistingChar()

    Call Writer_.WriteInt(ClientPacketID.LoginExistingChar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(UserPassword)
    Call Writer_.WriteString16(GetSerialHD)

    Call Writer_.WriteInt(App.Major)
    Call Writer_.WriteInt(App.Minor)
    Call Writer_.WriteInt(App.Revision)

120 Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteThrowDices()

    Call Writer_.WriteInt(ClientPacketID.ThrowDices)

130 Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteLoginNewChar()


    Call Writer_.WriteInt(ClientPacketID.LoginNewChar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(UserPassword)
    Call Writer_.WriteString16(GetSerialHD)
    Call Writer_.WriteInt(App.Major)
    Call Writer_.WriteInt(App.Minor)
    Call Writer_.WriteInt(App.Revision)
    Call Writer_.WriteInt(UserRaza)
    Call Writer_.WriteInt(UserSexo)
    Call Writer_.WriteInt(UserClase)
    Call Writer_.WriteString16(UserEmail)
    Call Writer_.WriteInt(UserHogar)
    Call Writer_.WriteString16(UserPin)
    Call Writer_.WriteString16(SKAssigned)

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTalk(ByVal chat As String)

    Call Writer_.WriteInt(ClientPacketID.Talk)
    Call Writer_.WriteString16(chat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyTalk(ByVal chat As String)

    Call Writer_.WriteInt(ClientPacketID.PartyTalk)
    Call Writer_.WriteString16(chat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteYell(ByVal chat As String)

    Call Writer_.WriteInt(ClientPacketID.Yell)
    Call Writer_.WriteString16(chat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWhisper(ByVal CharIndex As Integer, ByVal chat As String)

    Call Writer_.WriteInt(ClientPacketID.Whisper)
    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteString16(chat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWalk(ByVal Heading As E_Heading)

    Call Writer_.WriteInt(ClientPacketID.Walk)
    Call Writer_.WriteInt(Heading)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestPositionUpdate()

    Call Writer_.WriteInt(ClientPacketID.RequestPositionUpdate)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAttack()

    Call Writer_.WriteInt(ClientPacketID.Attack)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePickUp()

    Call Writer_.WriteInt(ClientPacketID.PickUp)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSafeToggle()

    Call Writer_.WriteInt(ClientPacketID.SafeToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDragToggle()

    Call Writer_.WriteInt(ClientPacketID.DragToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteResuscitationToggle()

    Call Writer_.WriteInt(ClientPacketID.ResuscitationSafeToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestGuildLeaderInfo()

    Call Writer_.WriteInt(ClientPacketID.RequestGuildLeaderInfo)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestAtributes()

    Call Writer_.WriteInt(ClientPacketID.RequestAtributes)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestFame()

    Call Writer_.WriteInt(ClientPacketID.RequestFame)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestSkills()

    Call Writer_.WriteInt(ClientPacketID.RequestSkills)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestMiniStats()

    Call Writer_.WriteInt(ClientPacketID.RequestMiniStats)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCommerceEnd()

    Call Writer_.WriteInt(ClientPacketID.CommerceEnd)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUserCommerceEnd()

    Call Writer_.WriteInt(ClientPacketID.UserCommerceEnd)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUserCommerceConfirm()

    Call Writer_.WriteInt(ClientPacketID.UserCommerceConfirm)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankEnd()

    Call Writer_.WriteInt(ClientPacketID.BankEnd)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUserCommerceOk()

    Call Writer_.WriteInt(ClientPacketID.UserCommerceOk)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUserCommerceReject()

    Call Writer_.WriteInt(ClientPacketID.UserCommerceReject)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDrop(ByVal Slot As Byte, ByVal amount As Long)

    Call Writer_.WriteInt(ClientPacketID.Drop)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt32(amount)

    Dim KeyNew As Byte

    KeyNew = IIf(LastKeyDropObj > 1, 1, 2)

    Call Writer_.WriteInt8(KeyNew)

    LastKeyDropObj = KeyNew

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCastSpell(ByVal Slot As Byte)

    Call Writer_.WriteInt(ClientPacketID.CastSpell)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteLeftClick(ByVal X As Byte, ByVal Y As Byte)

    Call Writer_.WriteInt(ClientPacketID.LeftClick)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDoubleClick(ByVal X As Byte, ByVal Y As Byte)

    Call Writer_.WriteInt(ClientPacketID.DoubleClick)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWork(ByVal Skill As eSkill)

    Call Writer_.WriteInt(ClientPacketID.Work)
    Call Writer_.WriteInt8(Skill)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUseSpellMacro(Optional ByVal tipo As Byte = 0)

    Call Writer_.WriteInt(ClientPacketID.UseSpellMacro)
    Call Writer_.WriteInt8(tipo)
    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub WriteUseItem(ByVal Slot As Byte)

    Call Writer_.WriteInt(ClientPacketID.UseItem)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteLastUsePotions(ByVal Modo As Byte)

    Dim KeyNew As Byte
    KeyNew = IIf(LastKeyUseItem > 1, 1, 2)

    If Modo <> 0 Then
        Call Writer_.WriteInt(ClientPacketID.UsePotionsLastU)
    Else
        Call Writer_.WriteInt(ClientPacketID.UsePotionsLastClick)
    End If

    LastKeyUseItem = KeyNew
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUsePotions(ByVal Slot As Byte, ByVal Modo As Byte)

    Dim KeyNew As Byte
    KeyNew = IIf(LastKeyUseItem > 1, 1, 2)

    If Modo <> 0 Then
        Call Writer_.WriteInt(ClientPacketID.UsePotionsU)
    Else
        Call Writer_.WriteInt(ClientPacketID.UsePotionsClick)
    End If

    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt8(KeyNew)

    LastKeyUseItem = KeyNew
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCraftBlacksmith(ByVal Item As Integer)

    Call Writer_.WriteInt(ClientPacketID.CraftBlacksmith)
    Call Writer_.WriteInt(Item)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCraftCarpenter(ByVal Item As Integer)

    Call Writer_.WriteInt(ClientPacketID.CraftCarpenter)
    Call Writer_.WriteInt(Item)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteShowGuildNews()

    Call Writer_.WriteInt(ClientPacketID.ShowGuildNews)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWorkLeftClick(ByVal X As Byte, ByVal Y As Byte, ByVal Skill As eSkill)

    Call Writer_.WriteInt(ClientPacketID.WorkLeftClick)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call Writer_.WriteInt8(Skill)
    Call Writer_.WriteInt32(GetTickCount)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteWorkMagiaClick(ByVal X As Byte, ByVal Y As Byte, ByVal ErrSpell As Byte)

    Call Writer_.WriteInt(ClientPacketID.WorkMagiaClick)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)

    If ErrSpell > 0 Then
        Call Writer_.WriteInt8(RandomNumber(126, 255))
    Else
        Call Writer_.WriteInt8(RandomNumber(0, 125))
    End If

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCobrarCheque(ByVal ID As String)

    Call Writer_.WriteInt(ClientPacketID.CobrarCheque)
    Call Writer_.WriteString16(ID)

    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub WriteCreateNewGuild(ByVal Desc As String, ByVal Name As String, ByVal Site As String, ByRef Codex() As String)

    Dim Temp As String

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.CreateNewGuild)

    Call Writer_.WriteString16(Desc)
    Call Writer_.WriteString16(Name)
    Call Writer_.WriteString16(Site)

    For i = LBound(Codex()) To UBound(Codex())
        Temp = Temp & Codex(i) & SEPARATOR
    Next i

    If Len(Temp) Then Temp = Left$(Temp, Len(Temp) - 1)

    Call Writer_.WriteString16(Temp)
    Call modNetwork.NetWrite(Writer_)


End Sub

Public Sub WriteEquipItem(ByVal Slot As Byte)

    Call Writer_.WriteInt(ClientPacketID.EquipItem)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeHeading(ByVal Heading As E_Heading)

    Call Writer_.WriteInt(ClientPacketID.ChangeHeading)
    Call Writer_.WriteInt(Heading)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteModifySkills(ByRef skillEdt() As Byte)

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.ModifySkills)

    For i = 1 To NUMSKILLS
        Call Writer_.WriteInt8(skillEdt(i))
    Next i

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTrain(ByVal creature As Byte)

    Call Writer_.WriteInt(ClientPacketID.Train)
    Call Writer_.WriteInt8(creature)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCommerceBuy(ByVal Slot As Byte, ByVal amount As Integer, ByVal ToSlot As Byte)

    Call Writer_.WriteInt(ClientPacketID.CommerceBuy)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt(amount)
    Call Writer_.WriteInt8(ToSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankExtractItem(ByVal Slot As Byte, ByVal amount As Integer)

    Call Writer_.WriteInt(ClientPacketID.BankExtractItem)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCommerceSell(ByVal Slot As Byte, ByVal amount As Integer)

    Call Writer_.WriteInt(ClientPacketID.CommerceSell)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankDeposit(ByVal Slot As Byte, ByVal amount As Integer)

    Call Writer_.WriteInt(ClientPacketID.BankDeposit)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMoveSpell(ByVal upwards As Boolean, ByVal Slot As Byte)

    Call Writer_.WriteInt(ClientPacketID.MoveSpell)
    Call Writer_.WriteBool(upwards)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMoveBank(ByVal upwards As Boolean, ByVal Slot As Byte)

    Call Writer_.WriteInt(ClientPacketID.MoveBank)
    Call Writer_.WriteBool(upwards)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteClanCodexUpdate(ByVal Desc As String, ByRef Codex() As String)

    Dim Temp As String

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.ClanCodexUpdate)

    Call Writer_.WriteString16(Desc)

    For i = LBound(Codex()) To UBound(Codex())
        Temp = Temp & Codex(i) & SEPARATOR
    Next i

    If Len(Temp) Then Temp = Left$(Temp, Len(Temp) - 1)

    Call Writer_.WriteString16(Temp)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUserCommerceOffer(ByVal Slot As Byte, ByVal amount As Long, ByVal OfferSlot As Byte)

    Call Writer_.WriteInt(ClientPacketID.UserCommerceOffer)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt32(amount)
    Call Writer_.WriteInt8(OfferSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCommerceChat(ByVal chat As String)

    Call Writer_.WriteInt(ClientPacketID.CommerceChat)
    Call Writer_.WriteString16(chat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildAcceptPeace(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildAcceptPeace)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRejectAlliance(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildRejectAlliance)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRejectPeace(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildRejectPeace)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteGuildAcceptAlliance(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildAcceptAlliance)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildOfferPeace(ByVal ClanIndex As Integer, ByVal proposal As String)

    Call Writer_.WriteInt(ClientPacketID.GuildOfferPeace)
    Call Writer_.WriteInt(ClanIndex)
    Call Writer_.WriteString16(proposal)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildOfferAlliance(ByVal ClanIndex As Integer, ByVal proposal As String)

    Call Writer_.WriteInt(ClientPacketID.GuildOfferAlliance)
    Call Writer_.WriteInt(ClanIndex)
    Call Writer_.WriteString16(proposal)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildAllianceDetails(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildAllianceDetails)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildPeaceDetails(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildPeaceDetails)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRequestJoinerInfo(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GuildRequestJoinerInfo)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildAlliancePropList()

    Call Writer_.WriteInt(ClientPacketID.GuildAlliancePropList)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildPeacePropList()

    Call Writer_.WriteInt(ClientPacketID.GuildPeacePropList)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildDeclareWar(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildDeclareWar)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildNewWebsite(ByVal URL As String)

    Call Writer_.WriteInt(ClientPacketID.GuildNewWebsite)
    Call Writer_.WriteString16(URL)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildAcceptNewMember(ByVal UserName As String)


    Call Writer_.WriteInt(ClientPacketID.GuildAcceptNewMember)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRejectNewMember(ByVal UserName As String, ByVal reason As String)

    Call Writer_.WriteInt(ClientPacketID.GuildRejectNewMember)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(reason)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildKickMember(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GuildKickMember)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildUpdateNews(ByVal news As String)

    Call Writer_.WriteInt(ClientPacketID.GuildUpdateNews)
    Call Writer_.WriteString16(news)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildMemberInfo(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GuildMemberInfo)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildOpenElections()

    Call Writer_.WriteInt(ClientPacketID.GuildOpenElections)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRequestMembership(ByVal GuildIndex As Integer, ByVal Application As String)

    Call Writer_.WriteInt(ClientPacketID.GuildRequestMembership)
    Call Writer_.WriteInt(GuildIndex)
    Call Writer_.WriteString16(Application)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildRequestDetails(ByVal GuildIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.GuildRequestDetails)
    Call Writer_.WriteInt(GuildIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOnline()

    Call Writer_.WriteInt(ClientPacketID.Online)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteQuit()

    Call Writer_.WriteInt(ClientPacketID.Quit)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildLeave()

    Call Writer_.WriteInt(ClientPacketID.GuildLeave)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestAccountState()

    Call Writer_.WriteInt(ClientPacketID.RequestAccountState)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePetStand()

    Call Writer_.WriteInt(ClientPacketID.PetStand)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePetFollow()

    Call Writer_.WriteInt(ClientPacketID.PetFollow)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReleasePet()

    Call Writer_.WriteInt(ClientPacketID.ReleasePet)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTrainList()

    Call Writer_.WriteInt(ClientPacketID.TrainList)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteRest()

    Call Writer_.WriteInt(ClientPacketID.Rest)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMeditate()

    Call Writer_.WriteInt(ClientPacketID.Meditate)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteResucitate()

    Call Writer_.WriteInt(ClientPacketID.Resucitate)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteConsulta()

    Call Writer_.WriteInt(ClientPacketID.Consulta)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteHeal()

    Call Writer_.WriteInt(ClientPacketID.Heal)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteHelp()

    Call Writer_.WriteInt(ClientPacketID.Help)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestStats()

    Call Writer_.WriteInt(ClientPacketID.RequestStats)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCommerceStart()

    Call Writer_.WriteInt(ClientPacketID.CommerceStart)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankStart()

    Call Writer_.WriteInt(ClientPacketID.BankStart)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteEnlist()

    Call Writer_.WriteInt(ClientPacketID.Enlist)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteInformation()

    Call Writer_.WriteInt(ClientPacketID.Information)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReward()

    Call Writer_.WriteInt(ClientPacketID.Reward)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUpTime()

    Call Writer_.WriteInt(ClientPacketID.UpTime)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.GuildMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCentinelReport(ByVal code As String)

    Call Writer_.WriteInt(ClientPacketID.CentinelReport)
    Call Writer_.WriteString16(code)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildOnline()

    Call Writer_.WriteInt(ClientPacketID.GuildOnline)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCouncilMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.CouncilMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRoleMasterRequest(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.RoleMasterRequest)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGMRequest()

    Call Writer_.WriteInt(ClientPacketID.GMRequest)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeDescription(ByVal Desc As String)

    Call Writer_.WriteInt(ClientPacketID.ChangeDescription)
    Call Writer_.WriteString16(Desc)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildVote(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GuildVote)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePunishments(Optional ByVal nick As String = "")

    Call Writer_.WriteInt(ClientPacketID.Punishments)
    Call Writer_.WriteString16(nick)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangePassword(ByRef oldPass As String, ByRef NewPass As String)

    Call Writer_.WriteInt(ClientPacketID.ChangePassword)
    Call Writer_.WriteString16(oldPass)
    Call Writer_.WriteString16(NewPass)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGamble(ByVal amount As Integer)

    Call Writer_.WriteInt(ClientPacketID.Gamble)
    Call Writer_.WriteInt(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteLeaveFaction()

    Call Writer_.WriteInt(ClientPacketID.LeaveFaction)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankExtractGold(ByVal amount As Long)

    Call Writer_.WriteInt(ClientPacketID.BankExtractGold)
    Call Writer_.WriteInt32(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankDepositGold(ByVal amount As Long)

    Call Writer_.WriteInt(ClientPacketID.BankDepositGold)
    Call Writer_.WriteInt32(amount)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDenounce(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.Denounce)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildFundate()

    Call Writer_.WriteInt(ClientPacketID.GuildFundate)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildFundation(ByVal clanType As eClanType)

    Call Writer_.WriteInt(ClientPacketID.GuildFundation)
    Call Writer_.WriteInt(clanType)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildMemberList(ByVal guild As String)

    Call Writer_.WriteInt(ClientPacketID.GuildMemberList)
    Call Writer_.WriteString16(guild)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteInitCrafting(ByVal cantidad As Long)

    Call Writer_.WriteInt(ClientPacketID.InitCrafting)
    Call Writer_.WriteInt32(cantidad)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePing()

    Call Writer_.WriteInt(ClientPacketID.Ping)
    Call Writer_.WriteInt(GetTickCount())
    Call modNetwork.NetWrite(Writer_, True)

End Sub

Public Sub WriteShareNpc()

    Call Writer_.WriteInt(ClientPacketID.ShareNpc)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteStopSharingNpc()

    Call Writer_.WriteInt(ClientPacketID.StopSharingNpc)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteToggleCombatMode()

    Call Writer_.WriteInt(ClientPacketID.ToggleCombatMode)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteDisolverClan()

    Call Writer_.WriteInt(ClientPacketID.DisolverClan)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTickAntiCuelgue()

    Call Writer_.WriteInt(ClientPacketID.TickAntiCuelgue)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReanudarclan(ByVal ClanName As String)

    Call Writer_.WriteInt(ClientPacketID.ReanudarClan)
    Call Writer_.WriteString16(ClanName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankDespositAllGold()

    Call Writer_.WriteInt(ClientPacketID.DepositarTodo)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBankExtractAllGold()

    Call Writer_.WriteInt(ClientPacketID.RetirarTodo)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDragInventory(ByVal OriginalSlot As Byte, ByVal TargetSlot As Byte)

    Call Writer_.WriteInt(ClientPacketID.DragInventario)
    Call Writer_.WriteInt8(OriginalSlot)
    Call Writer_.WriteInt8(TargetSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDragToPos(ByVal X As Byte, ByVal Y As Byte, ByVal Slot As Byte, ByVal amount As Integer)

    Call Writer_.WriteInt(ClientPacketID.DragToPos)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call Writer_.WriteInt8(Slot)
    Call Writer_.WriteInt(amount)
    Call modNetwork.NetWrite(Writer_)
    CANTDRAG = 0

End Sub

Sub WriteRequestPartyForm()

    Call Writer_.WriteInt(ClientPacketID.RequestPartyForm)
    Call modNetwork.NetWrite(Writer_)

End Sub

Sub WriteFianza(ByVal Monto As Long)

    Call Writer_.WriteInt(ClientPacketID.Fianza)
    Call Writer_.WriteInt32(Abs(Monto))
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCheater()

    Call Writer_.WriteInt(ClientPacketID.Cheat)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyKick(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.PartyKick)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyAcceptMember(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.PartyAcceptMember)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartySetLeader(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.PartySetLeader)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSetPartyPorcentajes(ByRef Porcentajes() As Byte)

    Dim LoopC As Long

    Call Writer_.WriteInt(ClientPacketID.SetPartyPorcentajes)

    For LoopC = 0 To 4
        Call Writer_.WriteInt8(Porcentajes(LoopC))
    Next LoopC

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyJoin()

    Call Writer_.WriteInt(ClientPacketID.PartyJoin)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyCreate()

    Call Writer_.WriteInt(ClientPacketID.PartyCreate)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePartyLeave()

    Call Writer_.WriteInt(ClientPacketID.PartyLeave)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteActivarGlobalUser()

    Call Writer_.WriteInt(ClientPacketID.ActivarGlobal)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOtherSendReto(ByVal Oponnent As String, ByVal Gold As Long, ByVal Drop As Byte, ByVal PotionsLimit As Integer, ByVal Plantados As Byte, ByVal CascoEscu As Byte)

    Call Writer_.WriteInt(ClientPacketID.OtherSendReto)
    Call Writer_.WriteString16(Oponnent)
    Call Writer_.WriteInt32(Gold)
    Call Writer_.WriteInt8(Drop)
    Call Writer_.WriteInt(PotionsLimit)
    Call Writer_.WriteInt8(Plantados)
    Call Writer_.WriteInt8(CascoEscu)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSendReto(ByVal MyTeam As String, ByVal enemy As String, ByVal TeamEnemy As String, ByVal Drop As Boolean, ByVal Gold As Long, ByVal PotionsLimit As Long, ByVal sinResu As Boolean)

    Call Writer_.WriteInt(ClientPacketID.SendReto)
    Call Writer_.WriteString16(MyTeam)
    Call Writer_.WriteString16(enemy)
    Call Writer_.WriteString16(TeamEnemy)
    Call Writer_.WriteBool(Drop)
    Call Writer_.WriteInt32(Gold)
    Call Writer_.WriteInt(PotionsLimit)
    Call Writer_.WriteBool(sinResu)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAcceptReto(ByVal SendName As String)

    Call Writer_.WriteInt(ClientPacketID.AcceptReto)
    Call Writer_.WriteString16(SendName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCancelarSolicitudReto(ByVal SendName As String)

    Call Writer_.WriteInt(ClientPacketID.CancelReto)
    Call Writer_.WriteString16(SendName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDragBov(ByVal OriginalSlot As Byte, ByVal TargetSlot As Byte)

    Call Writer_.WriteInt(ClientPacketID.DragBov)
    Call Writer_.WriteInt8(OriginalSlot)
    Call Writer_.WriteInt8(TargetSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGlobalMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.SendMsjGlobal)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAbandonarReto()

    Call Writer_.WriteInt(ClientPacketID.AbandonarReto)
    Call modNetwork.NetWrite(Writer_)

End Sub

' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS
' @@ GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS -  GM COMMANDS

Public Sub WriteGMMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.GMMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)
    
End Sub

Public Sub WriteShowName()

    Call Writer_.WriteInt(ClientPacketID.ShowName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOnlineRoyalArmy()

    Call Writer_.WriteInt(ClientPacketID.OnlineRoyalArmy)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOnlineChaosLegion()

    Call Writer_.WriteInt(ClientPacketID.OnlineChaosLegion)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGoNearby(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GoNearby)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteServerTime()

    Call Writer_.WriteInt(ClientPacketID.serverTime)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWhere(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.Where)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCreaturesInMap(ByVal Map As Integer)

    Call Writer_.WriteInt(ClientPacketID.CreaturesInMap)
    Call Writer_.WriteInt(Map)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWarpMeToTarget()

    Call Writer_.WriteInt(ClientPacketID.WarpMeToTarget)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWarpChar(ByVal UserName As String, ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte)

    Call Writer_.WriteInt(ClientPacketID.WarpChar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteInt(Map)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSilence(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.Silence)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSOSShowList()

    Call Writer_.WriteInt(ClientPacketID.SOSShowList)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSOSRemove(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.SOSRemove)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGoToChar(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.GoToChar)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteInvisible()

    Call Writer_.WriteInt(ClientPacketID.Invisible)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGMPanel()
    Call Writer_.WriteInt(ClientPacketID.GMPanel)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestUserList()

    Call Writer_.WriteInt(ClientPacketID.RequestUserList)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWorking()

    Call Writer_.WriteInt(ClientPacketID.Working)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteKillNPC()

    Call Writer_.WriteInt(ClientPacketID.KillNPC)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WritePenar(ByVal UserName As String, ByVal reason As String)

    Call Writer_.WriteInt(ClientPacketID.Penar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(reason)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteEditChar(ByVal UserName As String, ByVal EditOption As eEditOptions, ByVal arg1 As String, ByVal arg2 As String)

    Call Writer_.WriteInt(ClientPacketID.EditChar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteInt(EditOption)
    Call Writer_.WriteString16(arg1)
    Call Writer_.WriteString16(arg2)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharInfo(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharInfo)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharStats(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharStats)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharGold(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharGold)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharInventory(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharInventory)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharBank(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharBank)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharSkills(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharSkills)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReviveChar(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.ReviveChar)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOnlineGM()

    Call Writer_.WriteInt(ClientPacketID.OnlineGM)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteOnlineMap(ByVal Map As Integer)

    Call Writer_.WriteInt(ClientPacketID.OnlineMap)
    Call Writer_.WriteInt(Map)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteForgive(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.Forgive)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteKick(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.Kick)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteExecute(ByVal UserName As String, ByVal Drop As Byte)

    Call Writer_.WriteInt(ClientPacketID.Execute)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteInt8(Drop)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBanChar(ByVal UserName As String, ByVal reason As String)

    Call Writer_.WriteInt(ClientPacketID.banChar)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(reason)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUnbanChar(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.UnbanChar)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteNPCFollow()

    Call Writer_.WriteInt(ClientPacketID.NPCFollow)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSummonChar(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.SummonChar)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSpawnListRequest()

    Call Writer_.WriteInt(ClientPacketID.SpawnListRequest)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSpawnCreature(ByVal creatureIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.SpawnCreature)
    Call Writer_.WriteInt(creatureIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteResetNPCInventory()

    Call Writer_.WriteInt(ClientPacketID.ResetNPCInventory)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCleanWorld(Optional ByVal Map As Integer = 0)

    Call Writer_.WriteInt(ClientPacketID.CleanWorld)
    Call Writer_.WriteInt(Map)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteServerMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.ServerMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteNickToIP(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.nickToIP)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteIPToNick(ByRef IP() As Byte)

    If UBound(IP()) - LBound(IP()) + 1 <> 4 Then Exit Sub        'Invalid IP

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.IPToNick)

    For i = LBound(IP()) To UBound(IP())
        Call Writer_.WriteInt8(IP(i))
    Next i

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildOnlineMembers(ByVal guild As String)

    Call Writer_.WriteInt(ClientPacketID.GuildOnlineMembers)
    Call Writer_.WriteString16(guild)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTeleportCreate(ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte, Optional ByVal Radio As Byte = 0)

    Call Writer_.WriteInt(ClientPacketID.TeleportCreate)
    Call Writer_.WriteInt(Map)
    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call Writer_.WriteInt8(Radio)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTeleportDestroy()

    Call Writer_.WriteInt(ClientPacketID.TeleportDestroy)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRainToggle()

    Call Writer_.WriteInt(ClientPacketID.RainToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSetCharDescription(ByVal Desc As String, Optional ByVal isDesc As Boolean = False)

    Call Writer_.WriteInt(ClientPacketID.SetCharDescription)
    Call Writer_.WriteString16(Desc)
    Call Writer_.WriteBool(isDesc)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteForceMIDIToMap(ByVal midiID As Byte, ByVal Map As Integer)

    Call Writer_.WriteInt(ClientPacketID.ForceMIDIToMap)
    Call Writer_.WriteInt(midiID)

    Call Writer_.WriteInt(Map)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteForceWAVEToMap(ByVal waveID As Byte, ByVal Map As Integer, ByVal X As Byte, ByVal Y As Byte)

    Call Writer_.WriteInt(ClientPacketID.ForceWAVEToMap)
    Call Writer_.WriteInt(waveID)

    Call Writer_.WriteInt(Map)

    Call Writer_.WriteInt8(X)
    Call Writer_.WriteInt8(Y)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRoyalArmyMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.RoyalArmyMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChaosLegionMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.ChaosLegionMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCitizenMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.CitizenMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCriminalMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.CriminalMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTalkAsNPC(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.TalkAsNPC)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDestroyAllItemsInArea()

    Call Writer_.WriteInt(ClientPacketID.DestroyAllItemsInArea)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAcceptRoyalCouncilMember(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.AcceptRoyalCouncilMember)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAcceptChaosCouncilMember(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.AcceptChaosCouncilMember)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteItemsInTheFloor()

    Call Writer_.WriteInt(ClientPacketID.ItemsInTheFloor)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMakeDumb(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.MakeDumb)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMakeDumbNoMore(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.MakeDumbNoMore)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCouncilKick(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.CouncilKick)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSetTrigger(ByVal Trigger As eTrigger)

    Call Writer_.WriteInt(ClientPacketID.SetTrigger)
    Call Writer_.WriteInt8(Trigger)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAskTrigger()

    Call Writer_.WriteInt(ClientPacketID.AskTrigger)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBannedIPList()

    Call Writer_.WriteInt(ClientPacketID.BannedIPList)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBannedIPReload()

    Call Writer_.WriteInt(ClientPacketID.BannedIPReload)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteGuildBan(ByVal guild As String)

    Call Writer_.WriteInt(ClientPacketID.GuildBan)
    Call Writer_.WriteString16(guild)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBanIP(ByVal NickOrIP As String, ByVal reason As String)

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.BanIP)
    Call Writer_.WriteString16(NickOrIP)

    Call Writer_.WriteString16(reason)

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteUnbanIP(ByRef IP() As Byte)

    If UBound(IP()) - LBound(IP()) + 1 <> 4 Then Exit Sub        'Invalid IP

    Dim i As Long

    Call Writer_.WriteInt(ClientPacketID.UnbanIP)

    For i = LBound(IP()) To UBound(IP())
        Call Writer_.WriteInt8(IP(i))
    Next i

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCreateItem(ByVal ItemIndex As Long, ByVal cantidad As Integer)

100 Call Writer_.WriteInt(ClientPacketID.CreateItem)
102 Call Writer_.WriteInt(ItemIndex)
104 Call Writer_.WriteInt(cantidad)

106 Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDestroyItems()

    Call Writer_.WriteInt(ClientPacketID.DestroyItems)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChaosLegionKick(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.ChaosLegionKick)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteRoyalArmyKick(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RoyalArmyKick)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteForceMIDIAll(ByVal midiID As Byte)

    Call Writer_.WriteInt(ClientPacketID.ForceMIDIAll)
    Call Writer_.WriteInt(midiID)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteForceWAVEAll(ByVal waveID As Byte)

    Call Writer_.WriteInt(ClientPacketID.ForceWAVEAll)
    Call Writer_.WriteInt(waveID)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRemovePunishment(ByVal UserName As String, ByVal punishment As Byte, ByVal newText As String)

    Call Writer_.WriteInt(ClientPacketID.RemovePunishment)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteInt8(punishment)
    Call Writer_.WriteString16(newText)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTileBlockedToggle()

    Call Writer_.WriteInt(ClientPacketID.TileBlockedToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteKillNPCNoRespawn()

    Call Writer_.WriteInt(ClientPacketID.KillNPCNoRespawn)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteKillAllNearbyNPCs()

    Call Writer_.WriteInt(ClientPacketID.KillAllNearbyNPCs)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteLastIP(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.LastIP)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSystemMessage(ByVal Message As String)

    Call Writer_.WriteInt(ClientPacketID.SystemMessage)
    Call Writer_.WriteString16(Message)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCreateNPC(ByVal NPCIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.CreateNPC)
    Call Writer_.WriteInt(NPCIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCreateNPCWithRespawn(ByVal NPCIndex As Integer)

    Call Writer_.WriteInt(ClientPacketID.CreateNPCWithRespawn)
    Call Writer_.WriteInt(NPCIndex)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteServerOpenToUsersToggle()

    Call Writer_.WriteInt(ClientPacketID.ServerOpenToUsersToggle)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteTurnCriminal(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.TurnCriminal)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteResetFactions(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.ResetFactions)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRemoveCharFromGuild(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RemoveCharFromGuild)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRequestCharMail(ByVal UserName As String)

    Call Writer_.WriteInt(ClientPacketID.RequestCharMail)
    Call Writer_.WriteString16(UserName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAlterPassword(ByVal UserName As String, ByVal CopyFrom As String)

    Call Writer_.WriteInt(ClientPacketID.AlterPassword)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(CopyFrom)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAlterMail(ByVal UserName As String, ByVal newMail As String)

    Call Writer_.WriteInt(ClientPacketID.AlterMail)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(newMail)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteAlterName(ByVal UserName As String, ByVal newName As String)

    Call Writer_.WriteInt(ClientPacketID.AlterName)
    Call Writer_.WriteString16(UserName)
    Call Writer_.WriteString16(newName)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteToggleCentinelActivated()

    Call Writer_.WriteInt(ClientPacketID.ToggleCentinelActivated)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteDoBackup()

    Call Writer_.WriteInt(ClientPacketID.DoBackUp)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteShowGuildMessages(ByVal guild As String)

    Call Writer_.WriteInt(ClientPacketID.ShowGuildMessages)
    Call Writer_.WriteString16(guild)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSaveMap()

    Call Writer_.WriteInt(ClientPacketID.SaveMap)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoPK(ByVal isPK As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoPK)
    Call Writer_.WriteBool(isPK)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoBackup(ByVal backup As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoBackup)
    Call Writer_.WriteBool(backup)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoRestricted(ByVal restrict As String)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoRestricted)
    Call Writer_.WriteString16(restrict)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoNoMagic(ByVal nomagic As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoNoMagic)
    Call Writer_.WriteBool(nomagic)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoNoInvi(ByVal noinvi As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoNoInvi)
    Call Writer_.WriteBool(noinvi)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoNoResu(ByVal noresu As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoNoResu)
    Call Writer_.WriteBool(noresu)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoNoInvocar(ByVal noinvocar As Boolean)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoNoInvocar)
    Call Writer_.WriteBool(noinvocar)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoMusic(ByVal music As Integer)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoMusic)
    Call Writer_.WriteInt(music)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteFUN_PjFull()

    Call Writer_.WriteInt(ClientPacketID.FUN_PjFull)
    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub WriteFUN_GMFull()

    Call Writer_.WriteInt(ClientPacketID.FUN_GMFull)
    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub WriteBorrarMensajeConsola(ByVal tipo As Byte, ByVal Mensaje As String, Optional ByVal Reemplazo As String = vbNullString)

    Call Writer_.WriteInt(ClientPacketID.BorrarMensajeConsola)
    Call Writer_.WriteInt8(tipo)
    Call Writer_.WriteString16(Mensaje)
    If tipo = 1 Then Call Writer_.WriteString16(Reemplazo)

    Call modNetwork.NetWrite(Writer_)
End Sub
Public Sub WriteChangeMapInfoLand(ByVal land As String)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoLand)
    Call Writer_.WriteString16(land)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChangeMapInfoZone(ByVal zone As String)

    Call Writer_.WriteInt(ClientPacketID.ChangeMapInfoZone)
    Call Writer_.WriteString16(zone)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSaveChars()

    Call Writer_.WriteInt(ClientPacketID.SaveChars)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCleanSOS()

    Call Writer_.WriteInt(ClientPacketID.CleanSOS)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteShowServerForm()

    Call Writer_.WriteInt(ClientPacketID.ShowServerForm)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteKickAllChars()

    Call Writer_.WriteInt(ClientPacketID.KickAllChars)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReloadNPCs()

    Call Writer_.WriteInt(ClientPacketID.ReloadNPCs)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReloadServerIni()

    Call Writer_.WriteInt(ClientPacketID.ReloadServerIni)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReloadSpells()

    Call Writer_.WriteInt(ClientPacketID.ReloadSpells)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteReloadObjects()

    Call Writer_.WriteInt(ClientPacketID.ReloadObjects)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteChatColor(ByVal r As Byte, ByVal g As Byte, ByVal b As Byte)

    Call Writer_.WriteInt(ClientPacketID.ChatColor)
    Call Writer_.WriteInt8(r)
    Call Writer_.WriteInt8(g)
    Call Writer_.WriteInt8(b)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteIgnored()

    Call Writer_.WriteInt(ClientPacketID.Ignored)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteConteo(ByVal Num As Byte)

    Call Writer_.WriteInt(ClientPacketID.Conteo)
    Call Writer_.WriteInt8(Num)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub writeCancelarTorneo()

    Call Writer_.WriteInt(ClientPacketID.CancelarTorneo)
    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub writeIngresarTorneo()

    Call Writer_.WriteInt(ClientPacketID.IngresarTorneo)
    Call modNetwork.NetWrite(Writer_)

End Sub
Public Sub writeSalirTorneo()

    Call Writer_.WriteInt(ClientPacketID.SalirTorneo)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCrearTorneo(ByVal Cupos As Byte, ByVal Inscripciom As Long, ByVal CaenItems As Byte, ByVal PremioCanje As Long, ByVal PremioOro As Long, Optional ByVal Minlvl As Byte = 1, Optional ByVal maxlvl As Byte = 47, Optional ByVal cp0 As Byte = 0, Optional ByVal cp1 As Byte = 0, Optional ByVal cp2 As Byte = 0, Optional ByVal cp3 As Byte = 0, Optional ByVal cp4 As Byte = 0, Optional ByVal cp5 As Byte = 0, Optional ByVal cp6 As Byte = 0, Optional ByVal cp7 As Byte = 0, Optional ByVal cp8 As Byte = 0, Optional ByVal cp9 As Byte = 0, Optional ByVal cp10 As Byte = 0, Optional ByVal cp11 As Byte = 0)

    Call Writer_.WriteInt(ClientPacketID.CrearTorneo)
    Call Writer_.WriteInt8(selEvent)
    Call Writer_.WriteInt8(Cupos)
    Call Writer_.WriteInt32(Inscripciom)
    Call Writer_.WriteInt8(CaenItems)
    Call Writer_.WriteInt32(PremioCanje)
    Call Writer_.WriteInt32(PremioOro)
    Call Writer_.WriteInt8(Minlvl)
    Call Writer_.WriteInt8(maxlvl)

    Call Writer_.WriteInt8(cp0)
    Call Writer_.WriteInt8(cp1)
    Call Writer_.WriteInt8(cp2)
    Call Writer_.WriteInt8(cp3)
    Call Writer_.WriteInt8(cp4)
    Call Writer_.WriteInt8(cp5)
    Call Writer_.WriteInt8(cp6)
    Call Writer_.WriteInt8(cp7)
    Call Writer_.WriteInt8(cp8)
    Call Writer_.WriteInt8(cp9)
    Call Writer_.WriteInt8(cp10)
    Call Writer_.WriteInt8(cp11)

    Select Case selEvent

    Case 1
        '1vs1
    Case 2
        '2vs2
    Case 3
        'death
    Case 4
        'jdh
    End Select

    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteResetChar()

    Call Writer_.WriteInt(ClientPacketID.ResetChar)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteSendReto3vs3(ByVal Team1 As String, _
                             ByVal Team2 As String, _
                             ByVal TeamEnemy1 As String, _
                             ByVal TeamEnemy2 As String, _
                             ByVal TeamEnemy3 As String, _
                             ByVal Drop As Boolean, _
                             ByVal Gold As Long, _
                             ByVal PotionsLimit As Long, _
                             ByVal sinResu As Boolean)

    Call Writer_.WriteInt(ClientPacketID.SendReto3vs3)
    Call Writer_.WriteString16(Team1)
    Call Writer_.WriteString16(Team2)
    Call Writer_.WriteString16(TeamEnemy1)
    Call Writer_.WriteString16(TeamEnemy2)
    Call Writer_.WriteString16(TeamEnemy3)
    Call Writer_.WriteBool(Drop)
    Call Writer_.WriteInt32(Gold)
    Call Writer_.WriteInt(PotionsLimit)
    Call Writer_.WriteBool(sinResu)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteBorrarPersonaje(ByVal nick As String, ByVal pass As String, ByVal pin As String, ByVal email As String)

    Call Writer_.WriteInt(ClientPacketID.BorrarPj)
    Call Writer_.WriteString16(nick)
    Call Writer_.WriteString16(pass)
    Call Writer_.WriteString16(pin)
    Call Writer_.WriteString16(email)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteMenuCliente(ByVal Slot As Byte)

    If SegActive Then Exit Sub

    Call Writer_.WriteInt(ClientPacketID.MenuClient)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteWorkMagia(ByVal Slot As Byte)

    If SegActive Then Exit Sub

    Call Writer_.WriteInt(ClientPacketID.WorkMagia)
    Call Writer_.WriteInt8(Slot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCambiarCara(ByVal Cara As Integer)

    Call Writer_.WriteInt(ClientPacketID.CambiarCara)
    Call Writer_.WriteInt(Cara)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCambiarNick(ByVal newName As String)

    Call Writer_.WriteInt(ClientPacketID.CambiarNick)
    Call Writer_.WriteString16(newName)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCambiarNickClan(ByVal newName As String)

    Call Writer_.WriteInt(ClientPacketID.CambiarNickClan)
    Call Writer_.WriteString16(newName)
    Call modNetwork.NetWrite(Writer_)

End Sub


Public Sub WriteQuest()

    Call Writer_.WriteInt(ClientPacketID.Quest)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteQuestDetailsRequest(ByVal QuestSlot As Integer)

    Call Writer_.WriteInt(ClientPacketID.QuestDetailsRequest)
    Call Writer_.WriteInt(QuestSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteQuestAccept()
    Call Writer_.WriteInt(ClientPacketID.QuestAccept)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteQuestListRequest()
    Call Writer_.WriteInt(ClientPacketID.QuestListRequest)
    Call modNetwork.NetWrite(Writer_)
End Sub

Public Sub WriteQuestAbandon(ByVal QuestSlot As Integer)

    Call Writer_.WriteInt(ClientPacketID.QuestAbandon)
    Call Writer_.WriteInt(QuestSlot)
    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteCVC(ByVal Accion As Byte, ParamArray Args() As Variant)

    Call Writer_.WriteInt(ClientPacketID.CVC_Accion)
    Call Writer_.WriteInt8(Accion)

    Select Case Accion
    Case 1
        Call Writer_.WriteString16(CStr(Args(0)))
        Call Writer_.WriteInt8(CByte(Args(1)))
    Case 2
        Call Writer_.WriteString16(CStr(Args(0)))
    Case 3
        Call Writer_.WriteString16(CStr(Args(0)))
    Case 4
        Call Writer_.WriteString16(CStr(Args(0)))

    End Select

    Call modNetwork.NetWrite(Writer_)

End Sub

Public Sub WriteRetoBOT(ByVal Dificultad As Byte, ByVal Clase As Byte)

    Call Writer_.WriteInt(ClientPacketID.RetoBOT)
    Call Writer_.WriteInt8(Dificultad)
    Call Writer_.WriteInt8(Clase)

    Call modNetwork.NetWrite(Writer_)

End Sub
