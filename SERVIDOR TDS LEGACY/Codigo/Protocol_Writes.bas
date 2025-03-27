Attribute VB_Name = "Protocol_Writes"
Option Explicit

Private MovePacketID(eHeading.NORTH To eHeading.WEST) As Byte

Public Sub Load_Array_Movements()
    MovePacketID(eHeading.NORTH) = CharacterMove_NORTH
    MovePacketID(eHeading.EAST) = CharacterMove_EAST
    MovePacketID(eHeading.SOUTH) = CharacterMove_SOUTH
    MovePacketID(eHeading.WEST) = CharacterMove_WEST
End Sub


Public Function PrepareMessageMensaje(ByVal string_id As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.MensajeShort)

    Call Writer_.WriteInt(string_id)

    Set PrepareMessageMensaje = Writer_
End Function

Public Function PrepareMessageCreateProjectile(ByVal CharIndex As Integer, ByVal VictimIndex As Integer, ByVal GrhIndex As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CreateProjectile)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(VictimIndex)
    Call Writer_.WriteInt(GrhIndex)

    Set PrepareMessageCreateProjectile = Writer_
End Function

Public Function PrepareMessageMovimientSW(ByVal Char As Integer, ByVal MovimientClass As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.MovimientSW)

    Call Writer_.WriteInt(Char)
    Call Writer_.WriteInt(MovimientClass)

    Set PrepareMessageMovimientSW = Writer_
End Function

Public Function PrepareMessageSetInvisible(ByVal CharIndex As Integer, ByVal invisible As Boolean, Optional ByVal isOcu As Boolean = False) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.SetInvisible)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteBool(invisible)
    Call Writer_.WriteBool(isOcu)

    Set PrepareMessageSetInvisible = Writer_
End Function

Public Function PrepareMessageCharacterChangeNick(ByVal CharIndex As Integer, ByVal newNick As String) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChangeNick)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteString16(newNick)

    Set PrepareMessageCharacterChangeNick = Writer_
End Function

Public Function PrepareMessageChatOverHead(ByVal Chat As String, ByVal CharIndex As Integer, ByVal color As Long) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ChatOverHead)

    Call Writer_.WriteString16(Chat)
    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt32(color)

    Set PrepareMessageChatOverHead = Writer_
End Function

Public Function PrepareMessageConsoleMsg(ByVal Chat As String, ByVal FontIndex As FontTypeNames, Optional ByVal SaltoLinea As Boolean = True) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ConsoleMsg)

    Call Writer_.WriteString16(Chat)
    Call Writer_.WriteInt(FontIndex)
    Call Writer_.WriteInt(IIf(SaltoLinea, 1, 0))

    Set PrepareMessageConsoleMsg = Writer_
End Function

Public Function PrepareMessageConsoleMsgDelete(ByVal Mensaje As String, ByVal tipo As Byte, ByVal Reemplazo As String) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.BorrarMensajeConsola)

    Call Writer_.WriteInt8(tipo)
    Call Writer_.WriteString16(Mensaje)
    If tipo = 1 Then
        Call Writer_.WriteString16(Reemplazo)
    End If

    Set PrepareMessageConsoleMsgDelete = Writer_
End Function

Public Function PrepareCommerceConsoleMsg(ByRef Chat As String, ByVal FontIndex As FontTypeNames) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CommerceChat)

    Call Writer_.WriteString16(Chat)
    Call Writer_.WriteInt(FontIndex)

    Set PrepareCommerceConsoleMsg = Writer_
End Function

Public Function PrepareMessageCreateFX(ByVal CharIndex As Integer, ByVal FX As Integer, Optional ByVal FXLoops As Integer = 0) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CreateFX)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(FX)
    Call Writer_.WriteInt(FXLoops)

    Set PrepareMessageCreateFX = Writer_
End Function

Public Function PrepareMessagePlayWave(ByVal wave As Byte, ByVal X As Byte, ByVal Y As Byte, Optional ByVal CancelLastWave As Boolean = False) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.PlayWave)

    Call Writer_.WriteInt(wave)
    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)

    Set PrepareMessagePlayWave = Writer_
End Function

Public Function PrepareMessageGuildChat(ByVal Chat As String) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.GuildChat)

    Call Writer_.WriteString16(Chat)

    Set PrepareMessageGuildChat = Writer_
End Function

Public Function PrepareMessageShowMessageBox(ByVal Chat As String) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ShowMessageBox)

    Call Writer_.WriteString16(Chat)

    Set PrepareMessageShowMessageBox = Writer_
End Function

Public Function PrepareMessagePlayMidi(ByVal midi As Byte, Optional ByVal loops As Integer = -1) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.PlayMIDI)

    Call Writer_.WriteInt(midi)
    Call Writer_.WriteInt(loops)

    Set PrepareMessagePlayMidi = Writer_
End Function

Public Function PrepareMessagePauseToggle()

    Call Writer_.WriteInt(ServerPacketID.PauseToggle)

    Set PrepareMessagePauseToggle = Writer_
End Function

Public Function PrepareMessageRainToggle(ByVal Estado As Boolean) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.RainToggle)

    Call Writer_.WriteBool(Estado)

    Set PrepareMessageRainToggle = Writer_
End Function

Public Function PrepareMessageObjectDelete(ByVal X As Byte, ByVal Y As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ObjectDelete)

    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)

    Set PrepareMessageObjectDelete = Writer_
End Function

Public Function PrepareMessageBlockPosition(ByVal X As Byte, ByVal Y As Byte, ByVal Blocked As Boolean) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.BlockPosition)

    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)
    Call Writer_.WriteBool(Blocked)

    Set PrepareMessageBlockPosition = Writer_
End Function

Public Function PrepareMessageObjectCreate(ByVal GrhIndex As Integer, ByVal X As Byte, ByVal Y As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ObjectCreate)

    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)
    Call Writer_.WriteInt(GrhIndex)

    Set PrepareMessageObjectCreate = Writer_
End Function

Public Function PrepareMessageCharacterRemove(ByVal CharIndex As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterRemove)

    Call Writer_.WriteInt(CharIndex)
    Set PrepareMessageCharacterRemove = Writer_
End Function

Public Function PrepareMessageSetChangeNPCInventorySlot(ByVal Slot As Byte, ByRef Obj As Obj, ByVal price As Single) As BinaryWriter

    Dim ObjInfo As ObjData

    If Obj.ObjIndex >= 1 And Obj.ObjIndex <= UBound(ObjData()) Then
        ObjInfo = ObjData(Obj.ObjIndex)
    End If

    Call Writer_.WriteInt(ServerPacketID.ChangeNPCInventorySlot)

    Call Writer_.WriteInt(Slot)
    Call Writer_.WriteString16(ObjInfo.Name)
    Call Writer_.WriteInt(Obj.Amount)
    Call Writer_.WriteReal32(price)
    Call Writer_.WriteInt(ObjInfo.GrhIndex)
    Call Writer_.WriteInt(Obj.ObjIndex)
    Call Writer_.WriteInt(ObjInfo.OBJType)
    Call Writer_.WriteInt(ObjInfo.MaxHIT)
    Call Writer_.WriteInt(ObjInfo.MinHIT)
    Call Writer_.WriteInt(ObjInfo.MaxDef)
    Call Writer_.WriteInt(ObjInfo.MinDef)
    Set PrepareMessageSetChangeNPCInventorySlot = Writer_

End Function

Public Function PrepareMessageRemoveCharDialog(ByVal CharIndex As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.RemoveCharDialog)

    Call Writer_.WriteInt(CharIndex)

    Set PrepareMessageRemoveCharDialog = Writer_
End Function

Public Function PrepareMessageCharacterCreate(ByVal body As Integer, _
                                              ByVal Head As Integer, _
                                              ByVal Heading As eHeading, _
                                              ByVal CharIndex As Integer, _
                                              ByVal X As Byte, _
                                              ByVal Y As Byte, _
                                              ByVal Weapon As Integer, _
                                              ByVal Shield As Integer, _
                                              ByVal FX As Integer, _
                                              ByVal FXLoops As Integer, _
                                              ByVal Helmet As Integer, _
                                              ByVal Name As String, _
                                              ByVal NickColor As Byte, _
                                              ByVal Privileges As Byte, _
                                              ByVal isNPC As Boolean) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterCreate)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(body)
    Call Writer_.WriteInt(Head)
    Call Writer_.WriteInt(Heading)
    Call Writer_.WriteBool(isNPC)
    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)
    Call Writer_.WriteInt(Weapon)
    Call Writer_.WriteInt(Shield)
    Call Writer_.WriteInt(Helmet)
    Call Writer_.WriteInt(FX)
    Call Writer_.WriteInt(FXLoops)
    Call Writer_.WriteString16(Name)
    Call Writer_.WriteInt(NickColor)
    Call Writer_.WriteInt(Privileges)
    Set PrepareMessageCharacterCreate = Writer_
End Function

Public Function PrepareMessageCharacterChange(ByVal body As Integer, _
                                              ByVal Head As Integer, _
                                              ByVal Heading As eHeading, _
                                              ByVal CharIndex As Integer, _
                                              ByVal Weapon As Integer, _
                                              ByVal Shield As Integer, _
                                              ByVal FX As Integer, _
                                              ByVal FXLoops As Integer, _
                                              ByVal Helmet As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChange)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(body)
    Call Writer_.WriteInt(Head)
    Call Writer_.WriteInt(Heading)
    Call Writer_.WriteInt(Weapon)
    Call Writer_.WriteInt(Shield)
    Call Writer_.WriteInt(Helmet)
    Call Writer_.WriteInt(FX)
    Call Writer_.WriteInt(FXLoops)
    Set PrepareMessageCharacterChange = Writer_
End Function

Public Function PrepareMessageCuentaRegresiva(ByVal segundos As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.SendCuentaRegresiva)

    Call Writer_.WriteInt(segundos)

    Set PrepareMessageCuentaRegresiva = Writer_
End Function

Public Function PrepareMessageCharacterMove(ByVal CharIndex As Integer, ByVal X As Byte, ByVal Y As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterMove)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)

    Set PrepareMessageCharacterMove = Writer_
End Function

Public Function PrepareMessageForceCharMove(ByVal Direccion As eHeading) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ForceCharMove)

    Call Writer_.WriteInt(Direccion)

    Set PrepareMessageForceCharMove = Writer_
End Function

Public Function PrepareMessageCharacterChangeBody(ByVal CharIndex As Integer, ByVal body As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChangeBody)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(body)

    Set PrepareMessageCharacterChangeBody = Writer_
End Function

Public Function PrepareMessageCharacterChangeSpecial(ByVal CharIndex As Integer, ByVal Special As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChangeSpecial)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(Special)

    Set PrepareMessageCharacterChangeSpecial = Writer_
End Function

Public Function PrepareMessageCharacterChangeWeapon(ByVal CharIndex As Integer, ByVal Weapon As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChangeWeapon)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(Weapon)

    Set PrepareMessageCharacterChangeWeapon = Writer_
End Function

Public Function PrepareMessageCharacterChangeHelmet(ByVal CharIndex As Integer, ByVal Helmet As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CharacterChangeHelmet)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(Helmet)

    Set PrepareMessageCharacterChangeHelmet = Writer_
End Function

Public Function PrepareMessageCharacterChangeShield(ByVal CharIndex As Integer, ByVal Shield As Byte) As BinaryWriter


    Call Writer_.WriteInt(ServerPacketID.CharacterChangeShield)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(Shield)

    Set PrepareMessageCharacterChangeShield = Writer_
End Function

Public Function PrepareMessageUpdateTagAndStatus(ByVal UserIndex As Integer, _
                                                 ByVal NickColor As Byte, _
                                                 ByRef TAG As String) As BinaryWriter


    Call Writer_.WriteInt(ServerPacketID.UpdateTagAndStatus)

    Call Writer_.WriteInt(UserList(UserIndex).Char.CharIndex)
    Call Writer_.WriteInt(NickColor)
    Call Writer_.WriteString16(TAG)

    Set PrepareMessageUpdateTagAndStatus = Writer_
End Function

Public Function PrepareMessageUpdateCharData(ByVal UserIndex As Integer) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.UpdateCharData)

    Call Writer_.WriteInt(UserList(UserIndex).Char.CharIndex)
    Call Writer_.WriteInt8(UserList(UserIndex).flags.Mimetizado)
    Call Writer_.WriteInt8(UserList(UserIndex).flags.Paralizado)
    Call Writer_.WriteInt8(UserList(UserIndex).flags.Inmovilizado)
    Call Writer_.WriteInt8(UserList(UserIndex).flags.Envenenado)
    Call Writer_.WriteInt(UserList(UserIndex).Counters.Trabajando)
    Call Writer_.WriteInt(UserList(UserIndex).Counters.IdleCount)

    Set PrepareMessageUpdateCharData = Writer_
End Function

Public Function PrepareMessageErrorMsg(ByVal Message As String) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.errorMsg)

    Call Writer_.WriteString16(Message)

    Set PrepareMessageErrorMsg = Writer_
End Function

Public Function PrepareMessageCreateDamage(ByVal CharIndex As Integer, _
                                           ByVal Message As Integer, _
                                           ByVal r As Byte, _
                                           ByVal G As Byte, _
                                           ByVal b As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.CreateDamage)

    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt(Message)
    Call Writer_.WriteInt(r)
    Call Writer_.WriteInt(G)
    Call Writer_.WriteInt(b)

    Set PrepareMessageCreateDamage = Writer_

End Function

Public Sub WriteLoggedMessage(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.logged)

    If IntClickU < 1 Then IntClickU = 5
    Call Writer_.WriteInt(IntClickU)

    Call Writer_.WriteString16(IIf(UserList(UserIndex).GuildIndex <> 0, modGuilds.GuildName(UserList(UserIndex).GuildIndex), ""))
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteRemoveAllDialogs(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.RemoveDialogs)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteNavigateToggle(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.NavigateToggle)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteDisconnect(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.Disconnect)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUserOfferConfirm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UserOfferConfirm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCommerceEnd(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.CommerceEnd)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteBankEnd(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.BankEnd)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCommerceInit(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.CommerceInit)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteBankInit(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.BankInit)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.Banco)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUserCommerceInit(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UserCommerceInit)
    Call Writer_.WriteString16(UserList(UserIndex).ComUsu.DestNick)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUserCommerceEnd(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UserCommerceEnd)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowBlacksmithForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowBlacksmithForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowCarpenterForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowCarpenterForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUpdateSta(ByVal UserIndex As Integer)

    If UserList(UserIndex).Stats.minSta = UserList(UserIndex).LastSTA Then Exit Sub
    UserList(UserIndex).LastSTA = UserList(UserIndex).Stats.minSta

    Call Writer_.WriteInt(ServerPacketID.UpdateSta)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.minSta)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUpdateMana(ByVal UserIndex As Integer)

    If UserList(UserIndex).Stats.MinMAN = UserList(UserIndex).LastMAN Then Exit Sub
    UserList(UserIndex).LastMAN = UserList(UserIndex).Stats.MinMAN

    Call Writer_.WriteInt(ServerPacketID.UpdateMana)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MinMAN)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUpdateHP(ByVal UserIndex As Integer)

        If UserList(UserIndex).Stats.MinHP = UserList(UserIndex).LastHP Then Exit Sub
        UserList(UserIndex).LastHP = UserList(UserIndex).Stats.MinHP

        Call Writer_.WriteInt(ServerPacketID.UpdateHP)
        Call Writer_.WriteInt(UserList(UserIndex).Stats.MinHP)
        Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCloseClient(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.CloseClient)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteUpdateGold(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateGold)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.GLD)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteUpdateBankGold(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateBankGold)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.Banco)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
  
End Sub

Public Sub WriteUpdateExp(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateExp)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.Exp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteUpdateStrenghtAndDexterity(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateStrenghtAndDexterity)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Fuerza))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Agilidad))
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteUpdateDexterity(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateDexterity)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Agilidad))
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteUpdateStrenght(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateStrenght)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Fuerza))
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteChangeMap(ByVal UserIndex As Integer, ByVal Map As Integer)

    Call Writer_.WriteInt(ServerPacketID.ChangeMap)
    Call Writer_.WriteInt(Map)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WritePosUpdate(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.PosUpdate)
    Call Writer_.WriteInt(UserList(UserIndex).Pos.X)
    Call Writer_.WriteInt(UserList(UserIndex).Pos.Y)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteChatOverHead(ByVal UserIndex As Integer, ByVal Chat As String, ByVal CharIndex As Integer, ByVal color As Long)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageChatOverHead(Chat, CharIndex, color))
    
End Sub

Public Sub WriteConsoleMsg(ByVal UserIndex As Integer, ByVal Chat As String, Optional ByVal FontIndex As FontTypeNames = FontTypeNames.FONTTYPE_INFO, Optional ByVal SaltoLinea As Boolean = True)

    If Len(Chat) = 0 Then
        Debug.Print
    End If

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageConsoleMsg(Chat, FontIndex, SaltoLinea))

End Sub

Public Sub WriteCommerceChat(ByVal UserIndex As Integer, ByVal Chat As String, ByVal FontIndex As FontTypeNames)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareCommerceConsoleMsg(Chat, FontIndex))
    
End Sub

Public Sub WriteGuildChat(ByVal UserIndex As Integer, ByVal Chat As String)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageGuildChat(Chat))
   
End Sub

Public Sub WriteShowMessageBox(ByVal UserIndex As Integer, ByVal Message As String)

    Call Writer_.WriteInt(ServerPacketID.ShowMessageBox)
    Call Writer_.WriteString16(Message)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUserIndexInServer(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UserIndexInServer)
    Call Writer_.WriteInt(UserIndex)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUserCharIndexInServer(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UserCharIndexInServer)
    Call Writer_.WriteInt(UserList(UserIndex).Char.CharIndex)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCharacterCreate(ByVal UserIndex As Integer, _
                                ByVal body As Integer, _
                                ByVal Head As Integer, _
                                ByVal Heading As eHeading, _
                                ByVal CharIndex As Integer, _
                                ByVal X As Byte, _
                                ByVal Y As Byte, _
                                ByVal Weapon As Integer, _
                                ByVal Shield As Integer, _
                                ByVal FX As Integer, _
                                ByVal FXLoops As Integer, _
                                ByVal Helmet As Integer, _
                                ByVal Name As String, _
                                ByVal NickColor As Byte, _
                                ByVal Privileges As Byte, _
                                Optional ByVal isNPC As Boolean)


    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageCharacterCreate(body, Head, Heading, CharIndex, X, Y, Weapon, Shield, FX, FXLoops, Helmet, Name, NickColor, Privileges, isNPC))
    
End Sub

Public Sub WriteCharacterRemove(ByVal UserIndex As Integer, ByVal CharIndex As Integer)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageCharacterRemove(CharIndex))

End Sub

Public Sub WriteCharacterMove(ByVal UserIndex As Integer, ByVal CharIndex As Integer, ByVal X As Byte, ByVal Y As Byte)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageCharacterMove(CharIndex, X, Y))
End Sub

Public Sub WriteForceCharMove(ByVal UserIndex, ByVal Direccion As eHeading)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageForceCharMove(Direccion))
   
End Sub

Public Sub WriteCharacterChange(ByVal UserIndex As Integer, _
                                ByVal body As Integer, _
                                ByVal Head As Integer, _
                                ByVal Heading As eHeading, _
                                ByVal CharIndex As Integer, _
                                ByVal Weapon As Integer, _
                                ByVal Shield As Integer, _
                                ByVal FX As Integer, _
                                ByVal FXLoops As Integer, _
                                ByVal Helmet As Integer)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageCharacterChange(body, Head, Heading, CharIndex, Weapon, Shield, FX, FXLoops, Helmet))

End Sub

Public Sub WriteObjectCreate(ByVal UserIndex As Integer, _
                             ByVal GrhIndex As Integer, _
                             ByVal X As Byte, _
                             ByVal Y As Byte)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageObjectCreate(GrhIndex, X, Y))
    
End Sub

Public Sub WriteObjectDelete(ByVal UserIndex As Integer, ByVal X As Byte, ByVal Y As Byte)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageObjectDelete(X, Y))
    

End Sub

Public Sub WriteBlockPosition(ByVal UserIndex As Integer, ByVal X As Byte, ByVal Y As Byte, ByVal Blocked As Boolean)

    Call Writer_.WriteInt(ServerPacketID.BlockPosition)
    
    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)
    Call Writer_.WriteBool(Blocked)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WritePlayMidi(ByVal UserIndex As Integer, ByVal midi As Byte, Optional ByVal loops As Integer = -1)


    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessagePlayMidi(midi, loops))

End Sub

Public Sub WritePlayWave(ByVal UserIndex As Integer, _
                         ByVal wave As Byte, _
                         ByVal X As Byte, _
                         ByVal Y As Byte, _
                         Optional ByVal CancelLastWave As Boolean)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessagePlayWave(wave, X, Y, CancelLastWave))
  
End Sub

Public Sub WriteGuildList(ByVal UserIndex As Integer, ByRef guildList() As String)

    Dim Tmp As String

    Dim i As Long

    Call Writer_.WriteInt(ServerPacketID.guildList)

    ' Prepare guild name's list
    For i = LBound(guildList()) To UBound(guildList())
        Tmp = Tmp & guildList(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCuentaRegresiva(ByVal UserIndex As Integer, ByVal segundos As Byte)

    Call Writer_.WriteInt(ServerPacketID.SendCuentaRegresiva)
    Call Writer_.WriteInt8(segundos)

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteAreaChanged(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.AreaChanged)
    Call Writer_.WriteInt(UserList(UserIndex).Pos.X)
    Call Writer_.WriteInt(UserList(UserIndex).Pos.Y)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WritePauseToggle(ByVal UserIndex As Integer)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessagePauseToggle())

End Sub

Public Sub WriteCreateFX(ByVal UserIndex As Integer, _
                         ByVal CharIndex As Integer, _
                         ByVal FX As Integer, _
                         ByVal FXLoops As Integer)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageCreateFX(CharIndex, FX, FXLoops))

End Sub

Public Sub WriteUpdateUserStats(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateUserStats)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MaxHP)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MinHP)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MaxMAN)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MinMAN)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MaxSta)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.minSta)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.GLD)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.ELV)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.elu)
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.Exp)

    UserList(UserIndex).LastHP = UserList(UserIndex).Stats.MinHP
    UserList(UserIndex).LastMAN = UserList(UserIndex).Stats.MinMAN
    UserList(UserIndex).LastSTA = UserList(UserIndex).Stats.minSta
    UserList(UserIndex).LastGLD = UserList(UserIndex).Stats.GLD
    UserList(UserIndex).LastEXP = UserList(UserIndex).Stats.Exp
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteWorkRequestTarget(ByVal UserIndex As Integer, ByVal Skill As eSkill)

    Call Writer_.WriteInt(ServerPacketID.WorkRequestTarget)
    Call Writer_.WriteInt(Skill)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteChangeInventorySlot(ByVal UserIndex As Integer, ByVal Slot As Byte)

1   Call Writer_.WriteInt(ServerPacketID.ChangeInventorySlot)
2   Call Writer_.WriteInt(Slot)

    Dim ObjIndex As Integer

    Dim obData As ObjData

3   ObjIndex = UserList(UserIndex).Invent.Object(Slot).ObjIndex

4   If ObjIndex > 0 Then
5       obData = ObjData(ObjIndex)
    End If

6   Call Writer_.WriteInt(ObjIndex)
7   Call Writer_.WriteString16(obData.Name)
8   Call Writer_.WriteInt(UserList(UserIndex).Invent.Object(Slot).Amount)
9   Call Writer_.WriteBool(UserList(UserIndex).Invent.Object(Slot).Equipped)
10  Call Writer_.WriteInt(obData.GrhIndex)
11  Call Writer_.WriteInt(obData.OBJType)
    Call Writer_.WriteInt(obData.MaxHIT)
    Call Writer_.WriteInt(obData.MinHIT)
    Call Writer_.WriteInt(obData.MaxDef)
14  Call Writer_.WriteInt(obData.MinDef)
12  Call Writer_.WriteReal32(SalePrice(ObjIndex))

13  Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteAddSlots(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.AddSlots)
    Call Writer_.WriteInt(UserList(UserIndex).CurrentInventorySlots)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteChangeBankSlot(ByVal UserIndex As Integer, ByVal Slot As Byte)

    Call Writer_.WriteInt(ServerPacketID.ChangeBankSlot)
    
    Call Writer_.WriteInt(Slot)

    Dim ObjIndex As Integer

    Dim obData As ObjData

    ObjIndex = UserList(UserIndex).BancoInvent.Object(Slot).ObjIndex

    Call Writer_.WriteInt(ObjIndex)

    If ObjIndex > 0 Then
        obData = ObjData(ObjIndex)

    End If

    Call Writer_.WriteString16(obData.Name)
    Call Writer_.WriteInt(UserList(UserIndex).BancoInvent.Object(Slot).Amount)
    Call Writer_.WriteInt(obData.GrhIndex)
    Call Writer_.WriteInt(obData.OBJType)
    Call Writer_.WriteInt(obData.MaxHIT)
    Call Writer_.WriteInt(obData.MinHIT)
    Call Writer_.WriteInt(obData.MaxDef)
    Call Writer_.WriteInt(obData.MinDef)
    Call Writer_.WriteInt32(obData.Valor)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteChangeSpellSlot(ByVal UserIndex As Integer, ByVal Slot As Integer)

    Call Writer_.WriteInt(ServerPacketID.ChangeSpellSlot)
    Call Writer_.WriteInt(Slot)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserHechizos(Slot))
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteAttributes(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.Atributes)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Fuerza))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Agilidad))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Inteligencia))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Carisma))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Constitucion))
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteBlacksmithWeapons(ByVal UserIndex As Integer)

    Dim i As Long

    Dim Obj As ObjData

    Dim validIndexes() As Integer

    Dim count As Integer

    ReDim validIndexes(1 To UBound(ArmasHerrero()))

    Call Writer_.WriteInt(ServerPacketID.BlacksmithWeapons)

    For i = 1 To UBound(ArmasHerrero())

        ' Can the user create this object? If so add it to the list....
        If ObjData(ArmasHerrero(i)).SkHerreria <= Round(UserList(UserIndex).Stats.UserSkills(eSkill.Herreria) / ModHerreriA(UserList(UserIndex).Clase), 0) Then
            count = count + 1
            validIndexes(count) = i

        End If

    Next i

    ' Write the number of objects in the list
    Call Writer_.WriteInt(count)

    ' Write the needed data of each object
    For i = 1 To count
        Obj = ObjData(ArmasHerrero(validIndexes(i)))
        Call Writer_.WriteInt(ArmasHerrero(validIndexes(i)))
    Next i

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteBlacksmithArmors(ByVal UserIndex As Integer)

    Dim i As Long

    Dim validIndexes() As Integer

    Dim count As Integer

    ReDim validIndexes(1 To UBound(ArmadurasHerrero()))

    Call Writer_.WriteInt(ServerPacketID.BlacksmithArmors)

    For i = 1 To UBound(ArmadurasHerrero())

        ' Can the user create this object? If so add it to the list....
        If ObjData(ArmadurasHerrero(i)).SkHerreria <= Round(UserList(UserIndex).Stats.UserSkills(eSkill.Herreria) / ModHerreriA(UserList(UserIndex).Clase), 0) Then
            count = count + 1
            validIndexes(count) = i

        End If

    Next i

    ' Write the number of objects in the list
    Call Writer_.WriteInt(count)

    ' Write the needed data of each object
    For i = 1 To count
        Call Writer_.WriteInt(ArmadurasHerrero(validIndexes(i)))
    Next i

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCarpenterObjects(ByVal UserIndex As Integer)
    
    Dim i As Long

    Dim validIndexes() As Integer

    Dim count As Integer

    ReDim validIndexes(1 To UBound(ObjCarpintero()))

    Call Writer_.WriteInt(ServerPacketID.CarpenterObjects)

    For i = 1 To UBound(ObjCarpintero())

        ' Can the user create this object? If so add it to the list....
        If ObjData(ObjCarpintero(i)).SkCarpinteria <= UserList(UserIndex).Stats.UserSkills(eSkill.Carpinteria) \ ModCarpinteria(UserList(UserIndex).Clase) Then
            count = count + 1
            validIndexes(count) = i

        End If

    Next i

    ' Write the number of objects in the list
    Call Writer_.WriteInt(count)

    ' Write the needed data of each object
    For i = 1 To count
        Call Writer_.WriteInt(ObjCarpintero(validIndexes(i)))
    Next i

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteRestOK(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.RestOK)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteErrorMsg(ByVal UserIndex As Integer, ByVal Message As String)

    Call modSendData.SendData(ToIndex, UserIndex, PrepareMessageErrorMsg(Message))
    
End Sub

Public Sub WriteBlind(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.Blind)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteDumb(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.Dumb)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowSignal(ByVal UserIndex As Integer, ByVal ObjIndex As Integer, ByVal X As Byte, ByVal Y As Byte)


    Call Writer_.WriteInt(ServerPacketID.ShowSignal)
    Call Writer_.WriteString16(ObjData(ObjIndex).texto)
    Call Writer_.WriteInt(ObjData(ObjIndex).GrhSecundario)
    Call Writer_.WriteInt(X)
    Call Writer_.WriteInt(Y)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteChangeNPCInventorySlot(ByVal UserIndex As Integer, ByVal Slot As Byte, ByRef Obj As Obj, ByVal price As Single)

    Dim ObjInfo As ObjData

    If Obj.ObjIndex >= 1 And Obj.ObjIndex <= UBound(ObjData()) Then
        ObjInfo = ObjData(Obj.ObjIndex)

    End If

    Call Writer_.WriteInt(ServerPacketID.ChangeNPCInventorySlot)
    Call Writer_.WriteInt(Slot)
    Call Writer_.WriteString16(ObjInfo.Name)
    Call Writer_.WriteInt(Obj.Amount)
    Call Writer_.WriteReal32(price)
    Call Writer_.WriteInt(ObjInfo.GrhIndex)
    Call Writer_.WriteInt(Obj.ObjIndex)
    Call Writer_.WriteInt(ObjInfo.OBJType)
    Call Writer_.WriteInt(ObjInfo.MaxHIT)
    Call Writer_.WriteInt(ObjInfo.MinHIT)
    Call Writer_.WriteInt(ObjInfo.MaxDef)
    Call Writer_.WriteInt(ObjInfo.MinDef)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteUpdateHungerAndThirst(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateHungerAndThirst)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MaxAGU)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MinAGU)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MaxHam)
    Call Writer_.WriteInt(UserList(UserIndex).Stats.MinHam)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
End Sub

Public Sub WriteFame(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.Fame)

    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.AsesinoRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.BandidoRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.BurguesRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.LadronesRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.NobleRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.PlebeRep)
    Call Writer_.WriteInt32(UserList(UserIndex).Reputacion.Promedio)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteMiniStats(ByVal UserIndex As Integer)


    Call Writer_.WriteInt(ServerPacketID.MiniStats)

    Call Writer_.WriteInt32(UserList(UserIndex).faccion.CiudadanosMatados)
    Call Writer_.WriteInt32(UserList(UserIndex).faccion.CriminalesMatados)

    'TODO : Este valor es calculable, no debería NI EXISTIR, ya sea en el server ni en el cliente!!!
    Call Writer_.WriteInt32(UserList(UserIndex).Stats.UsuariosMatados)

    Call Writer_.WriteInt(UserList(UserIndex).Stats.NPCsMuertos)

    Call Writer_.WriteInt(UserList(UserIndex).Clase)
    Call Writer_.WriteInt32(UserList(UserIndex).Counters.Pena)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteLevelUp(ByVal UserIndex As Integer, ByVal skillPoints As Integer)

    Call Writer_.WriteInt(ServerPacketID.LevelUp)
    Call Writer_.WriteInt(skillPoints)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteSetInvisible(ByVal UserIndex As Integer, _
                             ByVal CharIndex As Integer, _
                             ByVal invisible As Boolean, _
                             ByVal oculto As Boolean)

    Call Writer_.WriteInt(ServerPacketID.SetInvisible)
    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteBool(invisible)
    Call Writer_.WriteBool(oculto)

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
End Sub

Public Sub WriteDiceRoll(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.DiceRoll)

    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Fuerza))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Agilidad))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Inteligencia))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Carisma))
    Call Writer_.WriteInt(UserList(UserIndex).Stats.UserAtributos(eAtributos.Constitucion))
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteMeditateToggle(ByVal UserIndex As Integer)

    ''Call writer_.WriteInt(ServerPacketID.MeditateToggle)
    ''Call WritePosUpdate(UserIndex)

End Sub

Public Sub WriteBlindNoMore(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.BlindNoMore)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteDumbNoMore(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.DumbNoMore)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteSendSkills(ByVal UserIndex As Integer)

    Dim i As Long
1   With UserList(UserIndex)
2       Call Writer_.WriteInt(ServerPacketID.SendSkills)
3       Call Writer_.WriteInt(.Clase)
4       For i = 1 To NUMSKILLS
5           Call Writer_.WriteInt(UserList(UserIndex).Stats.UserSkills(i))
6           If .Stats.UserSkills(i) < MAXSKILLPOINTS Then


                If .Stats.EluSkills(i) = 0 Then
                    Call CheckEluSkill(UserIndex, i, True)
                End If


7               Call Writer_.WriteInt(Int(.Stats.ExpSkills(i) * 100 / .Stats.EluSkills(i)))
8           Else
9               Call Writer_.WriteInt(0)
10          End If
11      Next i
12      Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    End With
    
End Sub

Public Sub WriteTrainerCreatureList(ByVal UserIndex As Integer, ByVal NpcIndex As Integer)

    Dim i As Long

    Dim Str As String

    Call Writer_.WriteInt(ServerPacketID.TrainerCreatureList)

    For i = 1 To Npclist(NpcIndex).NroCriaturas
        Str = Str & Npclist(NpcIndex).Criaturas(i).NpcName & SEPARATOR
    Next i

    If LenB(Str) > 0 Then Str = Left$(Str, Len(Str) - 1)

    Call Writer_.WriteString16(Str)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteGuildNews(ByVal UserIndex As Integer, _
                          ByVal guildNews As String, _
                          ByRef enemies() As String, _
                          ByRef allies() As String)

    Dim i As Long

    Dim Tmp As String

    Call Writer_.WriteInt(ServerPacketID.guildNews)

    Call Writer_.WriteString16(guildNews)

    'Prepare enemies' list
    For i = LBound(enemies()) To UBound(enemies())
        Tmp = Tmp & enemies(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)

    Tmp = vbNullString

    'Prepare allies' list
    For i = LBound(allies()) To UBound(allies())
        Tmp = Tmp & allies(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteOfferDetails(ByVal UserIndex As Integer, ByVal details As String)

    Call Writer_.WriteInt(ServerPacketID.OfferDetails)
    Call Writer_.WriteString16(details)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteAlianceProposalsList(ByVal UserIndex As Integer, ByRef guilds() As String)

    Dim i As Long

    Dim Tmp As String

    ' Prepare guild's list
    For i = LBound(guilds()) To UBound(guilds())
        Tmp = Tmp & guilds(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    If Len(Tmp) = 0 Then
        WriteConsoleMsg UserIndex, "GUILDS> No tienes propuestas de alianza.", FontTypeNames.FONTTYPE_GUILD
        Exit Sub

    End If

    Call Writer_.WriteInt(ServerPacketID.AlianceProposalsList)
    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WritePeaceProposalsList(ByVal UserIndex As Integer, ByRef guilds() As String)

    Dim i As Long

    Dim Tmp As String

    ' Prepare guilds' list
    For i = LBound(guilds()) To UBound(guilds())
        Tmp = Tmp & guilds(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    If Len(Tmp) = 0 Then
        WriteConsoleMsg UserIndex, "GUILDS> No tienes propuestas de paz.", FontTypeNames.FONTTYPE_GUILD
        Exit Sub

    End If

    Call Writer_.WriteInt(ServerPacketID.PeaceProposalsList)
    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCharacterInfo(ByVal UserIndex As Integer, ByVal charName As String, ByVal race As eRaza, ByVal Class As eClass, ByVal gender As eGenero, ByVal level As Byte, ByVal gold As Long, ByVal bank As Long, ByVal reputation As Long, ByVal previousPetitions As String, ByVal currentGuild As String, ByVal previousGuilds As String, ByVal RoyalArmy As Boolean, ByVal CaosLegion As Boolean, ByVal citicensKilled As Long, ByVal criminalsKilled As Long)

    Call Writer_.WriteInt(ServerPacketID.CharacterInfo)

    Call Writer_.WriteString16(charName)
    Call Writer_.WriteInt(race)
    Call Writer_.WriteInt(Class)
    Call Writer_.WriteInt(gender)
    Call Writer_.WriteInt(level)
    Call Writer_.WriteInt32(gold)
    Call Writer_.WriteInt32(bank)
    Call Writer_.WriteInt(IIf(criminal(UserIndex), 1, 2))        '1 Crimi - 2 ciuda

    Call Writer_.WriteString16(previousPetitions)
    Call Writer_.WriteString16(currentGuild)

    Call Writer_.WriteString16(previousGuilds)

    If RoyalArmy Then
        Call Writer_.WriteInt(1)
    ElseIf CaosLegion Then
        Call Writer_.WriteInt(2)
    Else
        Call Writer_.WriteInt(0)

    End If

    Call Writer_.WriteInt32(citicensKilled)
    Call Writer_.WriteInt32(criminalsKilled)
    Call Writer_.WriteInt32(reputation)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteGuildLeaderInfo(ByVal UserIndex As Integer, _
                                ByRef guildList() As String, _
                                ByRef MemberList() As String, _
                                ByVal guildNews As String, _
                                ByRef joinRequests() As String)

    Dim i As Long

    Dim Tmp As String

    Call Writer_.WriteInt(ServerPacketID.GuildLeaderInfo)

    ' Prepare guild name's list
    For i = LBound(guildList()) To UBound(guildList())
        Tmp = Tmp & guildList(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)

    ' Prepare guild member's list
    Tmp = vbNullString

    For i = LBound(MemberList()) To UBound(MemberList())
        Tmp = Tmp & MemberList(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)

    ' Store guild news
    Call Writer_.WriteString16(guildNews)

    ' Prepare the join request's list
    Tmp = vbNullString

    For i = LBound(joinRequests()) To UBound(joinRequests())
        Tmp = Tmp & joinRequests(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteGuildDetails(ByVal UserIndex As Integer, _
                             ByVal GuildName As String, _
                             ByVal founder As String, _
                             ByVal foundationDate As String, _
                             ByVal Leader As String, _
                             ByVal url As String, _
                             ByVal memberCount As Integer, _
                             ByVal electionsOpen As Boolean, _
                             ByVal alignment As String, _
                             ByVal enemiesCount As Integer, _
                             ByVal AlliesCount As Integer, _
                             ByVal antifactionPoints As String, _
                             ByRef codex() As String, _
                             ByVal guildDesc As String)

    Dim i As Long

    Dim temp As String

    Call Writer_.WriteInt(ServerPacketID.GuildDetails)

    Call Writer_.WriteString16(GuildName)
    Call Writer_.WriteString16(founder)
    Call Writer_.WriteString16(foundationDate)
    Call Writer_.WriteString16(Leader)
    Call Writer_.WriteString16(url)

    Call Writer_.WriteInt(memberCount)
    Call Writer_.WriteBool(electionsOpen)

    Call Writer_.WriteString16(alignment)

    Call Writer_.WriteInt(enemiesCount)
    Call Writer_.WriteInt(AlliesCount)

    Call Writer_.WriteString16(antifactionPoints)

    For i = LBound(codex()) To UBound(codex())
        temp = temp & codex(i) & SEPARATOR
    Next i

    If Len(temp) > 1 Then temp = Left$(temp, Len(temp) - 1)

    Call Writer_.WriteString16(temp)

    Call Writer_.WriteString16(guildDesc)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowGuildFundationForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowGuildFundationForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteParalizeOK(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ParalizeOK)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

    Call WritePosUpdate(UserIndex)
    Call SendData(SendTarget.ToGMsAreaButRmsOrCounselors, UserIndex, PrepareMessageUpdateCharData(UserIndex))

End Sub

Public Sub WriteShowUserRequest(ByVal UserIndex As Integer, ByVal details As String)

    Call Writer_.WriteInt(ServerPacketID.ShowUserRequest)
    Call Writer_.WriteString16(details)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteTradeOK(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.TradeOK)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
  
End Sub

Public Sub WriteBankOK(ByVal UserIndex As Integer)

     Call Writer_.WriteInt(ServerPacketID.BankOK)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteChangeUserTradeSlot(ByVal UserIndex As Integer, _
                                    ByVal OfferSlot As Byte, _
                                    ByVal ObjIndex As Integer, _
                                    ByVal Amount As Long)

    Call Writer_.WriteInt(ServerPacketID.ChangeUserTradeSlot)
    Call Writer_.WriteInt(OfferSlot)
    Call Writer_.WriteInt32(Amount)

    If Amount > 0 Then Call Writer_.WriteInt(ObjIndex)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteSpawnList(ByVal UserIndex As Integer, ByRef npcNames() As String)

    Dim i As Long

    Dim Tmp As String

    Call Writer_.WriteInt(ServerPacketID.SpawnList)

    For i = LBound(npcNames()) To UBound(npcNames())
        Tmp = Tmp & npcNames(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowSOSForm(ByVal UserIndex As Integer)

    Dim i As Long

    Dim Tmp As String

    Call Writer_.WriteInt(ServerPacketID.ShowSOSForm)

    For i = 1 To Ayuda.Longitud
        Tmp = Tmp & Ayuda.VerElemento(i) & SEPARATOR
    Next i

    If LenB(Tmp) <> 0 Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteShowGMPanelForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowGMPanelForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteUserNameList(ByVal UserIndex As Integer, _
                             ByRef userNamesList() As String, _
                             ByVal Cant As Integer)


    Dim i As Long

    Dim Tmp As String

    Call Writer_.WriteInt(ServerPacketID.UserNameList)

    ' Prepare user's names list
    For i = 1 To Cant
        Tmp = Tmp & userNamesList(i) & SEPARATOR
    Next i

    If Len(Tmp) Then Tmp = Left$(Tmp, Len(Tmp) - 1)

    Call Writer_.WriteString16(Tmp)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WritePong(ByVal UserIndex As Integer, ByVal Time As Long)
    Call Writer_.WriteInt(ServerPacketID.Pong)
    Call Writer_.WriteInt(Time)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
End Sub

Public Sub WritePartyDetails(ByVal UserIndex As Integer)


    With UserList(UserIndex)

        If .PartyIndex < 1 Then Exit Sub

        Call Writer_.WriteInt(ServerPacketID.PartyDetail)
        Call Writer_.WriteInt(PARTY_MAXMEMBERS)

        Dim MembersOnline(1 To PARTY_MAXMEMBERS) As Integer, LoopC As Long, N As Integer

        Call Parties(.PartyIndex).GetMembersOnline(MembersOnline())

        For LoopC = 1 To PARTY_MAXMEMBERS
            N = MembersOnline(LoopC)

            If N > 0 Then
                Call Writer_.WriteString16(UserList(N).Name)
                Call Writer_.WriteReal64(Parties(.PartyIndex).MyExperience(LoopC))
            Else
                Call Writer_.WriteString16("")

            End If

        Next LoopC

        Call modSendData.SendData(ToIndex, UserIndex, Writer_)

    End With
    
End Sub

Public Function PrepareMessagePalabrasMagicas(ByVal SpellIndex As Byte, ByVal CharIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.PalabrasMagicas)
    Call Writer_.WriteInt8(SpellIndex)
    Call Writer_.WriteInt16(CharIndex)

End Function

Public Sub WritePartyExit(ByVal UserIndex As Integer)


    Call Writer_.WriteInt(ServerPacketID.PartyExit)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteSendPartyData(ByVal UserIndex As Integer)


    Dim PI As Byte, i As Long, Tmp As String

2   PI = UserList(UserIndex).PartyIndex

33  Dim Members(PARTY_MAXMEMBERS) As Integer

    Dim EsLeader As Boolean

44  EsLeader = Parties(PI).EsPartyLeader(UserIndex)

3   Call Writer_.WriteInt(ServerPacketID.SendPartyData)
4   Call Writer_.WriteBool(EsLeader)

6   If PI > 0 Then

        If EsLeader Then
7           Call Parties(PI).GetRequests(Members())

8           For i = 1 To PARTY_MAXREQUESTS

9               If Members(i) > 0 Then
10                  Tmp = Tmp & UserList(Members(i)).Name & ","

11              End If

12          Next i

13          If LenB(Tmp) <> 0 Then Tmp = Left$(Tmp, Len(Tmp) - 1)
14          Call Writer_.WriteString16(Tmp)

        End If

        Call Writer_.WriteString16(GetPartyString(UserIndex))
25      Call Writer_.WriteReal64(Parties(PI).GetTotalExperience)
        Call modSendData.SendData(ToIndex, UserIndex, Writer_)

26  End If

End Sub

Public Sub WriteUpdateStatsNew(ByVal UserIndex As Integer)

    With UserList(UserIndex)
        Call Writer_.WriteInt(ServerPacketID.UpdateStatsNew)
        Call Writer_.WriteInt(.Stats.MinHP)
        Call Writer_.WriteInt(.Stats.MinMAN)
        Call Writer_.WriteInt(.Stats.minSta)

        .LastHP = .Stats.MinHP
        .LastMAN = .Stats.MinMAN
        .LastSTA = .Stats.minSta
        Call modSendData.SendData(ToIndex, UserIndex, Writer_)

    End With
    
End Sub

Public Sub WriteUpdateFaccion(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateFaccion)

    If UserList(UserIndex).faccion.ArmadaReal > 0 Then
        Call Writer_.WriteInt(1)
    ElseIf UserList(UserIndex).faccion.FuerzasCaos > 0 Then
        Call Writer_.WriteInt(2)
    Else
        Call Writer_.WriteInt(0)

    End If

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteBonifStatus(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.BonifStatus)
    Call Writer_.WriteInt(UserList(UserIndex).Counters.LeveleandoTick)
    Call Writer_.WriteInt(UserList(UserIndex).Counters.tBonif)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteMultiMessage(ByVal UserIndex As Integer, _
                             ByVal MessageIndex As Integer, _
                             Optional ByVal Arg1 As Long, _
                             Optional ByVal Arg2 As Long, _
                             Optional ByVal Arg3 As Long, _
                             Optional ByVal StringArg1 As String)

   
    Call Writer_.WriteInt(ServerPacketID.MultiMessage)
    Call Writer_.WriteInt(MessageIndex)

    Select Case MessageIndex

    Case eMessages.Hechizo_HechiceroMSG_NOMBRE
        Call Writer_.WriteString16(StringArg1)

    Case eMessages.DontSeeAnything, eMessages.NPCSwing, eMessages.NPCKillUser, eMessages.BlockedWithShieldUser, eMessages.BlockedWithShieldother, eMessages.UserSwing, eMessages.SafeModeOn, eMessages.SafeModeOff, eMessages.ResuscitationSafeOff, eMessages.ResuscitationSafeOn, eMessages.NobilityLost, eMessages.CantUseWhileMeditating, eMessages.SafeDragModeOff, eMessages.SafeDragModeOn

    Case eMessages.NPCHitUser
        Call Writer_.WriteInt(Arg1)        'Target
        Call Writer_.WriteInt(Arg2)        'damage

    Case eMessages.UserHitNPC
        Call Writer_.WriteInt32(Arg1)        'damage

    Case eMessages.UserAttackedSwing
        Call Writer_.WriteInt(UserList(Arg1).Char.CharIndex)

    Case eMessages.UserHittedByUser
        Call Writer_.WriteInt(Arg1)        'AttackerIndex
        Call Writer_.WriteInt(Arg2)        'Target
        Call Writer_.WriteInt(Arg3)        'damage

    Case eMessages.UserHittedUser
        Call Writer_.WriteInt(Arg1)        'AttackerIndex
        Call Writer_.WriteInt(Arg2)        'Target
        Call Writer_.WriteInt(Arg3)        'damage

    Case eMessages.WorkRequestTarget
        Call Writer_.WriteInt(Arg1)        'skill

    Case eMessages.HaveKilledUser        '"Has matado a " & UserList(VictimIndex).name & "!" "Has ganado " & DaExp & " puntos de experiencia."
        If Arg1 > UBound(UserList) Then
            Call Writer_.WriteInt(Arg1)    'VictimIndex
        Else
            Call Writer_.WriteInt(UserList(Arg1).Char.CharIndex)    'VictimIndex
        End If
        Call Writer_.WriteInt32(Arg2)        'Expe

    Case eMessages.UserKill        '"¡" & .name & " te ha matado!"
        Call Writer_.WriteInt(UserList(Arg1).Char.CharIndex)        'AttackerIndex

    Case eMessages.EarnExp
        Call Writer_.WriteInt32(Arg1)

    End Select

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteStopWorking(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.StopWorking)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteCancelOfferItem(ByVal UserIndex As Integer, ByVal Slot As Byte)

    Call Writer_.WriteInt(ServerPacketID.CancelOfferItem)
    Call Writer_.WriteInt(Slot)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteUpdateEnvenenado(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.UpdateEnvenenado)
    Call Writer_.WriteInt(UserList(UserIndex).flags.Envenenado)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteIntervalos(ByVal UserIndex As Integer)


    Call Writer_.WriteInt(ServerPacketID.Intervalos)
    Call Writer_.WriteInt(INT_ATTACK)

    If UserList(UserIndex).Clase = eClass.Warrior Then
        Call Writer_.WriteInt(INT_ARROWS)
    Else
        Call Writer_.WriteInt(INT_ARROWSW)
    End If

    Call Writer_.WriteInt(INT_CAST_SPELL)
    Call Writer_.WriteInt(INT_CAST_ATTACK)
    Call Writer_.WriteInt(INT_ATTACK_CAST)

    Dim curint As Long

    Select Case UserList(UserIndex).Stats.ELV
    Case Is <= 5
        curint = 1075
    Case Is < 14
        curint = 1050
    Case Is < 24
        curint = 1020
    Case Is >= 24
        curint = 970
    End Select

    Call Writer_.WriteInt(curint)

    Call Writer_.WriteInt(INT_USEITEMU)
    Call Writer_.WriteInt(INT_USEITEMDCK)

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Function PrepareConnected(ByVal Connection As Long)
    Call Writer_.WriteInt(ServerPacketID.Connected)
    Call Writer_.WriteInt32(Connection)
End Function

Public Sub WriteConnected(ByVal UserIndex As Integer)

100 Call Writer_.WriteInt(ServerPacketID.Connected)
102 Call modSendData.SendData(ToIndex, UserIndex, Writer_)
  
End Sub

Public Sub WriteMensajes(ByVal UserIndex As Integer, _
                         ByVal string_id As Integer, _
                         Optional ByVal ft As FontTypeNames)


    Call Writer_.WriteInt(ServerPacketID.MensajeShort)
    Call Writer_.WriteInt(string_id)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteSetWorking(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.InitWorking)
    Call Writer_.WriteInt8(UserList(UserIndex).flags.Trabajando)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
End Sub

Public Sub WriteCombatMode(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.SetCombatMode)
    Call Writer_.WriteBool(UserList(UserIndex).flags.ModoCombate)
    
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Function PrepareMessageCharacterMoves(ByVal CharIndex As Integer, ByVal Heading As Byte) As BinaryWriter
    Call Writer_.WriteInt(MovePacketID(Heading))
    Call Writer_.WriteInt(CharIndex)
End Function

Public Function PrepareMessageChangeHeading(ByVal CharIndex As Integer, ByVal Heading As Byte) As BinaryWriter

    Call Writer_.WriteInt(ServerPacketID.ChangeHeading)
    Call Writer_.WriteInt(CharIndex)
    Call Writer_.WriteInt8(Heading)

End Function

Public Sub WriteShowBorrarPjForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowBorrarPjForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteShowResetearPjForm(ByVal UserIndex As Integer)

    Call Writer_.WriteInt(ServerPacketID.ShowResetearPjForm)
    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteSetEfectoNick(ByVal UserIndex As Integer, ByVal Estado As Byte)

    Call Writer_.WriteInt(ServerPacketID.SetEfectoNick)
    Call Writer_.WriteInt(Estado)

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
   
End Sub

Public Sub WriteShowSpecialForm(ByVal UserIndex As Integer, ByVal tipo As Byte)

    Call Writer_.WriteInt(ServerPacketID.ShowSpecialForm)
    Call Writer_.WriteInt(tipo)

    Select Case tipo

    Case 1
        Call Writer_.WriteInt(UserList(UserIndex).Genero)
        Call Writer_.WriteInt(UserList(UserIndex).raza)
    Case 2

    Case 3

    End Select

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteQuestDetails(ByVal UserIndex As Integer, ByVal QuestIndex As Integer, Optional QuestSlot As Integer = 0)

    Dim i As Long
    
    With UserList(UserIndex)

        Call Writer_.WriteInt(ServerPacketID.QuestDetails)

        '1 = empezada // 0 = solo ver info.
        Call Writer_.WriteInt8(IIf(QuestSlot, 1, 0))

        Call Writer_.WriteString16(QuestList(QuestIndex).Nombre)
        Call Writer_.WriteString16(QuestList(QuestIndex).Desc)
        Call Writer_.WriteInt8(QuestList(QuestIndex).RequiredLevel)
        Call Writer_.WriteInt8(QuestList(QuestIndex).RequiredNPCs)

        If QuestList(QuestIndex).RequiredNPCs Then
            For i = 1 To QuestList(QuestIndex).RequiredNPCs
                Call Writer_.WriteInt(QuestList(QuestIndex).RequiredNPC(i).Amount)
                Call Writer_.WriteInt(QuestList(QuestIndex).RequiredNPC(i).NpcIndex)
                If QuestSlot Then
                    Call Writer_.WriteInt(UserList(UserIndex).QuestStats.Quests(QuestSlot).NPCsKilled(i))
                End If
            Next i
        End If

        Call Writer_.WriteInt8(QuestList(QuestIndex).RequiredOBJs)
        If QuestList(QuestIndex).RequiredOBJs Then
            For i = 1 To QuestList(QuestIndex).RequiredOBJs
                Call Writer_.WriteInt(QuestList(QuestIndex).RequiredOBJ(i).Amount)
                Call Writer_.WriteString16(ObjData(QuestList(QuestIndex).RequiredOBJ(i).ObjIndex).Name)
            Next i
        End If

        Call Writer_.WriteInt32(QuestList(QuestIndex).RewardGLD)
        Call Writer_.WriteInt32(QuestList(QuestIndex).RewardEXP)

        Call Writer_.WriteInt8(QuestList(QuestIndex).RewardOBJs)
        If QuestList(QuestIndex).RewardOBJs Then
            For i = 1 To QuestList(QuestIndex).RewardOBJs
                Call Writer_.WriteInt(QuestList(QuestIndex).RewardOBJ(i).Amount)
                Call Writer_.WriteString16(ObjData(QuestList(QuestIndex).RewardOBJ(i).ObjIndex).Name)
            Next i
        End If
    End With

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)

End Sub

Public Sub WriteQuestListSend(ByVal UserIndex As Integer, ByVal QuestAbandona As Byte)

    Dim i As Long
    Dim TmpStr As String
    Dim cantQuests As Integer

    With UserList(UserIndex)

        If QuestAbandona <> 1 Then
            If .QuestStats.Quests(1).QuestIndex = 0 Then
                Call WriteConsoleMsg(UserIndex, "No tienes ninguna misión..", FontTypeNames.FONTTYPE_INFO)
                Exit Sub
            End If
        End If

        Call Writer_.WriteInt(ServerPacketID.QuestListSend)
        For i = 1 To MAXUSERQUESTS
            If .QuestStats.Quests(i).QuestIndex Then
                cantQuests = cantQuests + 1
                TmpStr = TmpStr & QuestList(.QuestStats.Quests(i).QuestIndex).Nombre & "-"
            End If
        Next i
        Call Writer_.WriteInt(cantQuests)
        If cantQuests Then
            Call Writer_.WriteString16(Left$(TmpStr, Len(TmpStr) - 1))
        End If

    End With

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub

Public Sub WriteCVCListSend(ByVal UserIndex As Integer, Accion As Byte, ParamArray Args() As Variant)

    Dim GI As Integer, cvcID As Byte

    With UserList(UserIndex)

        GI = .GuildIndex
        If GI Then cvcID = cvcManager.IsGuildInCVC(.GuildIndex)

        Call Writer_.WriteInt(ServerPacketID.CVCListSend)
        Call Writer_.WriteInt16(Accion)

        Select Case Accion

        Case mCVC_Accion.cvc_EnviarSolicitud
            Call Writer_.WriteInt16(Args(0))
            Call Writer_.WriteString16(GuildName(Args(1)))

        Case mCVC_Accion.cvc_AceptarSolicitud
            cvcID = cvcManager.IsGuildInCVC(.GuildIndex)

            Call Writer_.WriteInt16(cvcManager.GetDataFromCVC(cvcID, GI, 4))    'Honor

            Call Writer_.WriteInt16(cvcManager.GetDataFromCVC(cvcID, GI, 1))    'Obtengo jugadores
            Call Writer_.WriteInt16(cvcManager.GetDataFromCVC(cvcID, GI, 2))    'Obtengo jugadores

            Call Writer_.WriteInt32(GuildHonor(.GuildIndex))
            Call Writer_.WriteString16(GuildName(.GuildIndex))
            Call Writer_.WriteString16(m_ListaDeMiembrosOnlineCVC(GI))
            Call Writer_.WriteString16(cvcManager.GetDataFromCVC(cvcID, GI, 3))

            Call Writer_.WriteInt32(GuildHonor(Args(0)))
            Call Writer_.WriteString16(GuildName(Args(0)))
            Call Writer_.WriteString16(m_ListaDeMiembrosOnlineCVC(Args(0)))
            Call Writer_.WriteString16(cvcManager.GetDataFromCVC(cvcID, Args(0), 3))

        Case mCVC_Accion.cvc_RechazarSolicitud, mCVC_Accion.cvc_Cancelar

        Case mCVC_Accion.cvc_CambiarSeleccion
            Call Writer_.WriteBool(Args(0))
            Call Writer_.WriteString16(m_ListaDeMiembrosOnlineCVC(Args(1)))
            Call Writer_.WriteString16(cvcManager.GetDataFromCVC(cvcID, Args(1), 3))

        Case mCVC_Accion.cvc_EstoyListo
            Call Writer_.WriteInt16(Args(0))
            Call Writer_.WriteString16(Args(1))

        Case mCVC_Accion.cvc_ConfirmarSeleccion
            Call Writer_.WriteBool(Args(0))
            If UBound(Args) = 1 Then Call Writer_.WriteInt16(Args(1))

        End Select

    End With

    Call modSendData.SendData(ToIndex, UserIndex, Writer_)
    
End Sub
