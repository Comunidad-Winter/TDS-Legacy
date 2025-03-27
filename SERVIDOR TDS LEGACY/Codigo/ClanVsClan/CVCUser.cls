VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CVCUser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Clase CVCUser
Option Explicit

Private enCVC As Boolean
Private cvcTargetIndex As Integer
Private cvcMaxUsers As Byte
Private cvcID As Byte
Private cvcSeleccionados As String
Private cvcSeleccionConfirmada As Boolean
Private cvcReadyToPlay As Boolean

Public Property Get IsInCVC() As Boolean
    IsInCVC = enCVC
End Property

Public Property Let IsInCVC(ByVal value As Boolean)
    enCVC = value
End Property

Public Property Get TargetIndex() As Integer
    TargetIndex = cvcTargetIndex
End Property

Public Property Let TargetIndex(ByVal value As Integer)
    cvcTargetIndex = value
End Property

Public Property Get maxUsers() As Byte
    maxUsers = cvcMaxUsers
End Property

Public Property Let maxUsers(ByVal value As Byte)
    cvcMaxUsers = value
End Property

Public Property Get Selection() As String
    Selection = cvcSeleccionados
End Property

Public Property Let Selection(ByVal value As String)
    cvcSeleccionados = value
End Property

Public Property Get IsSelectionConfirmed() As Boolean
    IsSelectionConfirmed = cvcSeleccionConfirmada
End Property

Public Property Let IsSelectionConfirmed(ByVal value As Boolean)
    cvcSeleccionConfirmada = value
End Property

Public Property Get ReadyToPlay() As Boolean
    ReadyToPlay = cvcReadyToPlay
End Property

Public Property Let ReadyToPlay(ByVal value As Boolean)
    cvcReadyToPlay = value
End Property

