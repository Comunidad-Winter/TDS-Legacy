VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "SoundMapInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'**************************************************************
' SoundMapInfo.cls
'
'**************************************************************

'**************************************************************************
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'**************************************************************************

Option Explicit

Private Type p_tSoundMapInfo
    cantidad As Integer
    SoundIndex() As Integer
    flags() As Long
    Probabilidad() As Single
    DesdeHorario() As Integer
    HastaHorario() As Integer
End Type

Private Enum p_eSoundFlags
    ninguna = 0
    Lluvia = 1
End Enum

Private p_Mapas() As p_tSoundMapInfo

'sonidos conocidos, pasados a enum para intelisense
Public Enum e_SoundIndex
    MUERTE_HOMBRE = 11
    MUERTE_MUJER = 74
    FLECHA_IMPACTO = 65
    CONVERSION_BARCO = 55
    MORFAR_MANZANA = 82
    SOUND_COMIDA = 7
End Enum

Private Sub Class_Initialize()
'armar el array
    ReDim p_Mapas(1 To NumMaps) As p_tSoundMapInfo
    Call LoadSoundMapInfo
End Sub

Public Sub LoadSoundMapInfo()

    On Error GoTo Errhandler

    Dim i As Long
    Dim j As Long
    Dim Leer As clsIniManager

    Dim Temps As String

2   For i = 1 To UBound(p_Mapas)
3       Set Leer = New clsIniManager
4       Call Leer.Initialize(App.path & MapPath & "MAPA" & i & ".dat")
5       Temps = val(Leer.GetValue("SONIDOS", "Cantidad"))
6       If p_Mapas(i).cantidad Then
7           p_Mapas(i).cantidad = val(Temps)
8           ReDim p_Mapas(i).flags(1 To p_Mapas(i).cantidad) As Long
9           ReDim p_Mapas(i).Probabilidad(1 To p_Mapas(i).cantidad) As Single
10          ReDim p_Mapas(i).SoundIndex(1 To p_Mapas(i).cantidad) As Integer
11          ReDim p_Mapas(i).DesdeHorario(1 To p_Mapas(i).cantidad) As Integer
12          ReDim p_Mapas(i).HastaHorario(1 To p_Mapas(i).cantidad) As Integer
13          For j = 1 To p_Mapas(i).cantidad
14              p_Mapas(i).flags(j) = val(Leer.GetValue("SONIDO" & j, "Flags"))
15              p_Mapas(i).Probabilidad(j) = val(Leer.GetValue("SONIDO" & j, "Probabilidad"))
16              p_Mapas(i).SoundIndex(j) = val(Leer.GetValue("SONIDO" & j, "Sonido"))
17              p_Mapas(i).DesdeHorario(j) = val(Leer.GetValue("SONIDO" & j, "Sonido"))
18              p_Mapas(i).HastaHorario(j) = val(Leer.GetValue("SONIDO" & j, "Sonido"))
19          Next j
20          Set Leer = Nothing
        Else
21          p_Mapas(i).cantidad = 0
        End If
    Next i

    Exit Sub

Errhandler:
    Call LogError("Error en LoadSoundMapInfo en la linea:" & Erl & ". Mapa: " & i & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub ReproducirSonidosDeMapas()

    On Error GoTo Errhandler

    Dim i As Long
    Dim j As Long
    Dim SonidoMapa As Byte
    Dim posX As Byte
    Dim posY As Byte

    'Sounds are played at a random position
1   posX = RandomNumber(XMinMapSize, XMaxMapSize)
2   posY = RandomNumber(YMinMapSize, YMaxMapSize)
    Dim HoraActual As Byte

3   For i = 1 To UBound(p_Mapas)
4       If p_Mapas(i).cantidad > 0 Then
5           SonidoMapa = RandomNumber(1, p_Mapas(i).cantidad)
6           If RandomNumber(1, 100) <= p_Mapas(i).Probabilidad(SonidoMapa) Then
7               If p_Mapas(i).DesdeHorario(1) <> -1 And p_Mapas(i).HastaHorario(j) <> -1 Then
8                   HoraActual = Hour(Time)
9                   If HoraActual >= p_Mapas(i).DesdeHorario(1) And HoraActual <= p_Mapas(i).HastaHorario(j) Then
10                      If Lloviendo Then
11                          If p_Mapas(i).flags(SonidoMapa) Xor p_eSoundFlags.Lluvia Then
12                              Call SendData(SendTarget.toMap, i, PrepareMessagePlayWave(p_Mapas(i).SoundIndex(SonidoMapa), posX, posY))
13                          End If
14                      Else
15                          If p_Mapas(i).flags(SonidoMapa) Xor p_eSoundFlags.ninguna Then
16                              Call SendData(SendTarget.toMap, i, PrepareMessagePlayWave(p_Mapas(i).SoundIndex(SonidoMapa), posX, posY))
17                          End If
18                      End If
19                  End If
20              Else
21                  If Lloviendo Then
22                      If p_Mapas(i).flags(SonidoMapa) Xor p_eSoundFlags.Lluvia Then
23                          Call SendData(SendTarget.toMap, i, PrepareMessagePlayWave(p_Mapas(i).SoundIndex(SonidoMapa), posX, posY))
24                      End If
25                  Else
26                      If p_Mapas(i).flags(SonidoMapa) Xor p_eSoundFlags.ninguna Then
27                          Call SendData(SendTarget.toMap, i, PrepareMessagePlayWave(p_Mapas(i).SoundIndex(SonidoMapa), posX, posY))
28                      End If
29                  End If
30              End If
31          End If
32      End If
    Next i

    Exit Sub

Errhandler:
    Call LogError("Error en ReproducirSonidosDeMapas en " & Erl & ". Mapa " & i & ". Err: " & Err.Number & " " & Err.Description)
End Sub

Public Sub ReproducirSonido(ByVal Destino As SendTarget, ByVal Index As Integer, ByVal SoundIndex As Integer)
    Call SendData(Destino, Index, PrepareMessagePlayWave(SoundIndex, UserList(Index).Pos.X, UserList(Index).Pos.Y))
End Sub
