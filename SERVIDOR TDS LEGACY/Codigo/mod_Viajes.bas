Attribute VB_Name = "mod_Viajes"
Option Explicit

Type tPasajes
    mapa As Integer
    X As Byte
    Y As Integer
    Precio As Long
    LvlMin As Byte
    Nombre As String
End Type

Public Pasaje() As tPasajes
Public NumPasajes As Byte
Public Sub CargarPasajes()
On Error GoTo errh
    Dim Leer As New clsIniReader
    Dim LoopC As Long
    Leer.Initialize App.Path & "/Dat/PASAJES.ini"
    
    NumPasajes = Leer.GetValue("PASAJES", "NUM")
    ReDim Pasaje(1 To NumPasajes)
    For LoopC = 1 To NumPasajes
        With Pasaje(LoopC)
            .Nombre = Leer.GetValue("PASAJE" & LoopC, "NOMBRE")
            .mapa = val(Leer.GetValue("PASAJE" & LoopC, "MAPA"))
            .X = val(Leer.GetValue("PASAJE" & LoopC, "X"))
            .Y = val(Leer.GetValue("PASAJE" & LoopC, "Y"))
            .Precio = val(Leer.GetValue("PASAJE" & LoopC, "PRECIO"))
            .LvlMin = val(Leer.GetValue("PASAJE" & LoopC, "LVLMIN"))
        End With
    Next LoopC
Set Leer = Nothing

Exit Sub
errh:
    LogError "Error al cargar pasajes.ini(" & Err.Number & " - " & Err.description & ")"
End Sub








