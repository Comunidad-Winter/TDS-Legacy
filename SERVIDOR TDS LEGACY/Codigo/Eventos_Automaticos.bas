Attribute VB_Name = "Eventos_Automaticos"
Option Explicit


'********************************
'                               *
'@@ ROUND-ROBIN                 *
'@@ AUTOR: G Toyz - Luciano     *
'@@ FECHA: 10/10/2016           *
'@@ HORA: 02:04                 *
'                               *
'********************************

Private Const MAX_ARENAS As Byte = 10
Private Const MAX_TEAMS  As Byte = MAX_ARENAS * 2

Private Enum Enum_Events
    Event_2vs2 = 2
    Event_3vs3
    Event_4vs4
    Event_5vs5
    Event_6vs6
    Event_8vs8
    Event_9vs9
    Event_10vs10
End Enum

Private Type tUsers
    ID              As Integer
    Pos             As WorldPos
End Type

Private Type Teams
    Users()         As tUsers
    Rounds          As Byte
    Points          As Byte
End Type

Private Type eArenas
    Teams()         As Teams
    Count           As Integer
    Occupied        As Boolean
    X               As Byte
    Y               As Byte
    X_Death         As Byte
    Y_Death         As Byte
End Type

Private Type eWaiting
    Teams()         As Teams
    X_Wait          As Byte
    Y_Wait          As Byte
    Occupied        As Boolean
End Type

Private Type eEvent
    Arenas(1 To MAX_ARENAS)        As eArenas
    Waiting(1 To MAX_ARENAS)       As eWaiting
    Active                         As Boolean
    Map                            As Integer
    Gold                           As Long
    Drop                           As Boolean
End Type

Private Events(2 To 10) As eEvent
'_
