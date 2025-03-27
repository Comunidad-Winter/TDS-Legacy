Attribute VB_Name = "modAuras"
Option Explicit
Public Enum UpdateAuras
    Arma
    Armadura
    Escudo
    Casco
    Anillo
End Enum
 
Public Type tAuras
    r As Byte
    g As Byte
    b As Byte
    AuraGrh As Integer
    Giratoria As Boolean
    Color As Long
    OffSetX As Integer
    OffSetY As Integer
End Type
 
Public MaxAuras As Byte
Public Auras() As tAuras
 
Public Sub CargarAuras()
 
    Dim AuraPath As String, LoopC As Long, Gira As Byte
    AuraPath = App.path & "\INIT\Auras.ini"
    MaxAuras = Val(GetVar(AuraPath, "INIT", "MaxAuras"))
 
    If MaxAuras > 0 Then
        ReDim Auras(1 To MaxAuras) As tAuras
     
        For LoopC = 1 To MaxAuras
            With Auras(LoopC)
                .r = Val(GetVar(AuraPath, "AURA" & LoopC, "R"))
                .g = Val(GetVar(AuraPath, "AURA" & LoopC, "G"))
                .b = Val(GetVar(AuraPath, "AURA" & LoopC, "B"))
             
                .AuraGrh = Val(GetVar(AuraPath, "AURA" & LoopC, "GRH"))
             
                .OffSetX = Val(GetVar(AuraPath, "AURA" & LoopC, "OffSetX"))
                .OffSetY = Val(GetVar(AuraPath, "AURA" & LoopC, "OffSetY"))
             
                Gira = Val(GetVar(AuraPath, "AURA" & LoopC, "GIRATORIA"))
                If Gira <> 0 Then
                    .Giratoria = True
                Else
                    .Giratoria = False
                End If
            End With
        Next LoopC
    End If 'Maxauras > 0
End Sub
