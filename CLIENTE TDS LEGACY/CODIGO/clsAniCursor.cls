VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAniCursor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private Const GCL_HCURSOR = -12

Private Declare Function DestroyCursor Lib "user32" (ByVal hCursor As Any) As Long
Private Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpfilename As String) As Long
Private Declare Function SetClassLong Lib "user32" Alias "SetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function GetClassLong Lib "user32" Alias "GetClassLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Dim m_AniFile As String
Dim mhBaseCursor As Long
Dim mhAniCursor As Long
Dim State As Integer
Private mHwndControl As Long
Public Property Get AniFile() As String
    AniFile = m_AniFile
End Property
Public Property Let AniFile(ByVal New_AniFile As String)
    If New_AniFile = "" Then Exit Property
    mhAniCursor = LoadCursorFromFile(New_AniFile)
    m_AniFile = New_AniFile
End Property
Public Sub CursorOn(HwndControl As Long)
    mHwndControl = HwndControl
    mhBaseCursor = GetClassLong((HwndControl), GCL_HCURSOR)
    Call SetClassLong((HwndControl), GCL_HCURSOR, mhAniCursor)
    State = 1
End Sub
Public Sub CursorOff(HwndControl As Long)
    Call DestroyCursor(HwndControl)
    Call SetClassLong((HwndControl), GCL_HCURSOR, mhBaseCursor)
    State = 2
End Sub
Private Sub Class_Terminate()
    CursorOff mHwndControl
End Sub

