Attribute VB_Name = "m_TorneoGestion"
Option Explicit

Public TORNEO_Espera As WorldPos
Public TORNEO_Drop As WorldPos

Public Sub LoadTorneosGestion()

    On Error GoTo Errhandler

    Dim Leer As clsIniManager
    Set Leer = New clsIniManager
    Call Leer.Initialize(App.path & "\Dat\TorneosGestion.dat")

1   With TORNEO_Espera
2       .Map = CInt(Leer.GetValue("MAPA_DE_ESPERA", "Mapa"))
3       .X = CInt(Leer.GetValue("MAPA_DE_ESPERA", "X"))
4       .Y = CInt(Leer.GetValue("MAPA_DE_ESPERA", "Y"))
    End With

11  With TORNEO_Drop
21      .Map = CInt(Leer.GetValue("MAPA_DE_DROP", "Mapa"))
31      .X = CInt(Leer.GetValue("MAPA_DE_DROP", "X"))
41      .Y = CInt(Leer.GetValue("MAPA_DE_DROP", "Y"))
    End With

19  Set Leer = Nothing
    Exit Sub
Errhandler:
    Call LogError("Error en LoadTorneosGestion en " & Erl & ". err: " & Err.Number & " " & Err.Description)

End Sub

