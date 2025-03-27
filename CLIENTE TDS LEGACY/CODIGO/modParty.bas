Attribute VB_Name = "modParty"
Option Explicit

Public Type tParty
    NICK As String
    Porc As String
    expacum As Long
End Type
Public MaxUsuariosParty As Byte
Public Party() As tParty
Public SoyLider As Boolean
Public MaxPorc As Byte
Public Echadoo As String

