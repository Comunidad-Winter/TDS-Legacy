Attribute VB_Name = "InvNpc"
Option Explicit
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'                        Modulo Inv & Obj
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'Modulo para controlar los objetos y los inventarios.
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
'?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿
Public Function TirarItemAlPiso(Pos As WorldPos, Obj As Obj, Optional NotPirata As Boolean = True, Optional ByVal BloqValido As Boolean = False) As WorldPos
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim NuevaPos As WorldPos
    NuevaPos.X = 0
    NuevaPos.Y = 0

    Tilelibre Pos, NuevaPos, Obj, NotPirata, True
    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
        Call MakeObj(Obj, Pos.Map, NuevaPos.X, NuevaPos.Y)


    End If

    TirarItemAlPiso = NuevaPos

    Exit Function
Errhandler:

End Function

Public Sub NPC_TIRAR_ITEMS(ByRef npc As npc, ByVal IsPretoriano As Boolean, ByVal UserIndex As Integer)

    On Error Resume Next

    With npc

        Dim i As Byte
        Dim MiObj As Obj
        Dim NroDrop As Integer
        Dim Random As Integer
        Dim ObjIndex As Integer
        Dim auxPos As WorldPos

        ' Tira todo el inventario
        If IsPretoriano Then
            For i = 1 To MAX_INVENTORY_SLOTS
                If .Invent.Object(i).ObjIndex > 0 Then
                    MiObj.Amount = .Invent.Object(i).Amount
                    MiObj.ObjIndex = .Invent.Object(i).ObjIndex
                    auxPos = TirarItemAlPiso(.Pos, MiObj)
                End If
            Next i
        End If

        If .GiveGLD > 0 Then

            ' @@ Es solo acuatico, da el oro directo.
            If .flags.AguaValida = 1 And .flags.TierraInvalida = 1 Then
                If UserIndex = 0 Then
                    Call TirarOroNpc(.GiveGLD, npc.Pos)
                Else
                    If Not TirarOroNpc(.GiveGLD, npc.Pos) Then
                        UserList(UserIndex).Stats.GLD = UserList(UserIndex).Stats.GLD + .GiveGLD
                        Call WriteConsoleMsg(UserIndex, "La criatura te ha dejado " & .GiveGLD & " monedas de oro", FontTypeNames.FONTTYPE_INFO)
                        Call WriteUpdateGold(UserIndex)
                        If UserList(UserIndex).Stats.GLD > MAXORO Then UserList(UserIndex).Stats.GLD = MAXORO
                    End If
                End If
            Else
                Call TirarOroNpc(.GiveGLD, npc.Pos)
            End If

        End If

        Random = RandomNumber(1, 100)

        For NroDrop = 1 To .Invent.NroItems        '5
            ObjIndex = .Invent.Object(NroDrop).ObjIndex        '.DROP(NroDrop).ObjIndex
            If ObjIndex > 0 Then

                If ObjIndex = iORO Then
                    Call TirarOroNpc(.Invent.Object(NroDrop).Amount * OroMulti, npc.Pos)
                Else
                    If .Invent.Object(NroDrop).RareDrop = 0 Then
                        MiObj.Amount = .Invent.Object(NroDrop).Amount
                        MiObj.ObjIndex = .Invent.Object(NroDrop).ObjIndex

                        auxPos = TirarItemAlPiso(.Pos, MiObj, False)

                    ElseIf RandomNumber(1, IIf(.Invent.Object(NroDrop).RareDrop = 1, 15, 100)) > 10 Then
                        MiObj.Amount = .Invent.Object(NroDrop).Amount
                        MiObj.ObjIndex = .Invent.Object(NroDrop).ObjIndex

                        auxPos = TirarItemAlPiso(.Pos, MiObj, False)
                    End If
                End If
            End If
        Next NroDrop


    End With

End Sub

Function QuedanItems(ByVal NpcIndex As Integer, ByVal ObjIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next

    Dim i As Integer
    If Npclist(NpcIndex).Invent.NroItems > 0 Then
        For i = 1 To MAX_INVENTORY_SLOTS
            If Npclist(NpcIndex).Invent.Object(i).ObjIndex = ObjIndex Then
                QuedanItems = True
                Exit Function
            End If
        Next
    End If
    QuedanItems = False
End Function

''
' Gets the amount of a certain item that an npc has.
'
' @param npcIndex Specifies reference to npcmerchant
' @param ObjIndex Specifies reference to object
' @return   The amount of the item that the npc has
' @remarks This function reads the Npc.dat file
Function EncontrarCant(ByVal NpcIndex As Integer, ByVal ObjIndex As Integer) As Integer
'***************************************************
'Author: Unknown
'Last Modification: 25/09/2023
'Last Modification By: Gastón Montenegro Raczkoski (Cuicui)
' - 03/09/08 EncontrarCant now returns 0 if the npc doesn't have it (Marco)
' - 25/09/23 Ahora no busca en el file.
'***************************************************
    On Error Resume Next
    'Devuelve la cantidad original del obj de un npc
    Dim i As Long

    For i = 1 To MAX_INVENTORY_SLOTS
        If ObjIndex = NpcInfo(Npclist(NpcIndex).Numero).Invent.Object(i).ObjIndex Then
            EncontrarCant = NpcInfo(Npclist(NpcIndex).Numero).Invent.Object(i).Amount
            Exit Function
        End If
    Next

    EncontrarCant = 0

End Function

Sub ResetNpcInv(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error Resume Next

    Dim i As Integer

    With Npclist(NpcIndex)
        .Invent.NroItems = 0

        For i = 1 To MAX_INVENTORY_SLOTS
            .Invent.Object(i).ObjIndex = 0
            .Invent.Object(i).Amount = 0
        Next i

        .InvReSpawn = 0
    End With

End Sub

''
' Removes a certain amount of items from a slot of an npc's inventory
'
' @param npcIndex Specifies reference to npcmerchant
' @param Slot Specifies reference to npc's inventory's slot
' @param antidad Specifies amount of items that will be removed
Sub QuitarNpcInvItem(ByVal NpcIndex As Integer, ByVal Slot As Byte, ByVal cantidad As Long)
'***************************************************
'Author: Unknown
'Last Modification: 23/11/2009
'Last Modification By: Marco Vanotti (Marco)
' - 03/09/08 Now this sub checks that te npc has an item before respawning it (Marco)
'23/11/2009: ZaMa - Optimizacion de codigo.
'***************************************************
    Dim ObjIndex As Integer
    Dim iCant As Long

    With Npclist(NpcIndex)
        ObjIndex = .Invent.Object(Slot).ObjIndex

        'Quita un Obj
        If ObjData(.Invent.Object(Slot).ObjIndex).Crucial = 0 Then
            .Invent.Object(Slot).Amount = .Invent.Object(Slot).Amount - cantidad

            If .Invent.Object(Slot).Amount <= 0 Then

                .Invent.NroItems = .Invent.NroItems - 1
                .Invent.Object(Slot).ObjIndex = 0
                .Invent.Object(Slot).Amount = 0

                If .InvReSpawn = 1 Then    ' @@ Cuicui - para el tema de cuando vendes items y quedan en 0 y no se reponen
                    If Not QuedanItems(NpcIndex, ObjIndex) Then
                        'Check if the item is in the npc's dat.
                        iCant = EncontrarCant(NpcIndex, ObjIndex)
                        If iCant Then
                            .Invent.Object(Slot).ObjIndex = ObjIndex
                            .Invent.Object(Slot).Amount = iCant
                            .Invent.NroItems = .Invent.NroItems + 1
                        End If
                    End If
                ElseIf .Invent.NroItems = 0 And .InvReSpawn <> 1 Then
                    Call CargarInvent(NpcIndex)
                End If

            End If
        Else
            .Invent.Object(Slot).Amount = .Invent.Object(Slot).Amount - cantidad

            If .Invent.Object(Slot).Amount <= 0 Then
                .Invent.NroItems = .Invent.NroItems - 1
                .Invent.Object(Slot).ObjIndex = 0
                .Invent.Object(Slot).Amount = 0

                If Not QuedanItems(NpcIndex, ObjIndex) Then
                    'Check if the item is in the npc's dat.
                    iCant = EncontrarCant(NpcIndex, ObjIndex)
                    If iCant Then
                        .Invent.Object(Slot).ObjIndex = ObjIndex
                        .Invent.Object(Slot).Amount = iCant
                        .Invent.NroItems = .Invent.NroItems + 1
                    End If
                End If

                If .Invent.NroItems = 0 And .InvReSpawn <> 1 Then
                    Call CargarInvent(NpcIndex)        'Reponemos el inventario
                End If
            End If
        End If
    End With
End Sub

Sub CargarInvent(ByVal NpcIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: 25/09/2023 Gastón Montenegro Raczkoski (Cuicui)
' 25/09/2023 - La info se lee desde memoria y no desde un archivo
'***************************************************

'Vuelve a cargar el inventario del npc NpcIndex

'Dim LoopC As Long

    With Npclist(NpcIndex)
        .Invent = NpcInfo(.Numero).Invent
        '.Invent.NroItems = val(GetVar(npcfile, "NPC" & .Numero, "NROITEMS"))
        'For LoopC = 1 To .Invent.NroItems
        '    ln = GetVar(npcfile, "NPC" & .Numero, "Obj" & LoopC)
        '    .Invent.Object(LoopC).ObjIndex = val(ReadField(1, ln, 45))
        '    .Invent.Object(LoopC).Amount = val(ReadField(2, ln, 45))
        'Next LoopC
    End With

End Sub


Public Function TirarOroNpc(ByVal cantidad As Long, ByRef Pos As WorldPos)
'***************************************************
'Autor: ZaMa
'Last Modification: 13/02/2010
'***************************************************
    On Error GoTo Errhandler

    Dim NuevaPos As WorldPos
    Dim RecoverAmount As Long
    Dim Iter As Byte

    TirarOroNpc = False
    If cantidad > 0 Then

        Dim MiObj As Obj
        MiObj.ObjIndex = iORO

        Dim RemainingGold As Long

        RemainingGold = cantidad

        While (RemainingGold > 0)

            ' Tira pilon de 10k
            If RemainingGold > MAX_INVENTORY_OBJS Then
                MiObj.Amount = MAX_INVENTORY_OBJS
                RemainingGold = RemainingGold - MAX_INVENTORY_OBJS
                RecoverAmount = MAX_INVENTORY_OBJS

                ' Tira lo que quede
            Else
                MiObj.Amount = RemainingGold
                RecoverAmount = RemainingGold
                RemainingGold = 0
            End If

            'Call TirarItemAlPiso(Pos, MiObj, False, False)

            NuevaPos.X = 0
            NuevaPos.Y = 0

            Tilelibre Pos, NuevaPos, MiObj, False, True
            If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then
                Call MakeObj(MiObj, Pos.Map, NuevaPos.X, NuevaPos.Y)
                TirarOroNpc = True
            End If


        Wend
    End If

    Exit Function

Errhandler:
    Call LogError("Error en TirarOro. Error " & Err.Number & " : " & Err.Description)
End Function

