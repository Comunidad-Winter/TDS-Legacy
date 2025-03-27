VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVCMap"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Clase CVCMap
Option Explicit

Private p_MapID As Integer
Private p_SpawnPointsTeam1 As String
Private p_SpawnPointsTeam2 As String
Private p_Available As Boolean

' Propiedades
Public Property Get available() As Boolean
    available = p_Available
End Property

Public Property Let available(ByVal value As Boolean)
    p_Available = value
End Property

Public Property Get mapID() As Integer
    mapID = p_MapID
End Property

Public Property Let mapID(ByVal value As Integer)
    p_MapID = value
End Property

Public Property Get SpawnPointsTeam1() As String
    SpawnPointsTeam1 = p_SpawnPointsTeam1
End Property

Public Property Let SpawnPointsTeam1(ByVal value As String)
    p_SpawnPointsTeam1 = value
End Property

Public Property Get SpawnPointsTeam2() As String
    SpawnPointsTeam2 = p_SpawnPointsTeam2
End Property

Public Property Let SpawnPointsTeam2(ByVal value As String)
    p_SpawnPointsTeam2 = value
End Property

' Inicializa los spawn points para cada equipo
Public Sub InitializeMap(ByVal mapID As Integer, ByVal spawnsTeam1 As String, ByVal spawnsTeam2 As String, ByVal isAvailable As Byte)
    p_SpawnPointsTeam1 = spawnsTeam1
    p_SpawnPointsTeam2 = spawnsTeam2
    p_Available = (isAvailable = 1)
    p_MapID = mapID
End Sub

