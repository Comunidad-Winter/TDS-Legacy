Attribute VB_Name = "modInvisibles"
Option Explicit

Public Sub PonerInvisible(ByVal UserIndex As Integer, ByVal Estado As Boolean)

    UserList(UserIndex).flags.invisible = IIf(Estado, 1, 0)
    UserList(UserIndex).flags.oculto = IIf(Estado, 1, 0)
    UserList(UserIndex).Counters.Invisibilidad = 0

    Call UsUaRiOs.SetInvisible(UserIndex, UserList(UserIndex).Char.CharIndex, Not Estado, UserList(UserIndex).flags.oculto = 1)

End Sub

