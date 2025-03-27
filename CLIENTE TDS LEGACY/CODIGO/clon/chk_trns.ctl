VERSION 5.00
Begin VB.UserControl CkBx 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FF24FF&
   BackStyle       =   0  'Transparent
   ClientHeight    =   1200
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2700
   MaskColor       =   &H00FF24FF&
   ScaleHeight     =   1200
   ScaleWidth      =   2700
   ToolboxBitmap   =   "chk_trns.ctx":0000
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Height          =   615
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2775
   End
   Begin VB.Image imgBlankCheck 
      Height          =   255
      Left            =   600
      Picture         =   "chk_trns.ctx":0312
      Top             =   2400
      Width           =   135
   End
   Begin VB.Image imgChecked 
      Height          =   255
      Left            =   360
      Picture         =   "chk_trns.ctx":05E0
      Top             =   2400
      Width           =   135
   End
End
Attribute VB_Name = "CkBx"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Declare Function DrawTextEx Lib "user32" Alias "DrawTextExA" (ByVal hdc As Long, _
                                                                      ByVal lpsz As String, ByVal n As Long, lpRect As RECT, ByVal un As Long, _
                                                                      ByVal lpDrawTextParams As Any) As Long
Private Declare Function Rectangle Lib "gdi32" (ByVal hdc As Long, ByVal X1 As Long, _
                                                ByVal Y1 As Long, ByVal X2 As Long, ByVal Y2 As Long) As Long

Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Const m_def_Caption = "CkBox"
Const m_def_CheckColor = 0
Const m_def_Enabled = True
Const m_def_Value = 0

Private m_CaptionRect As RECT
Private m_Flag As Long
Private m_Caption As String
Private m_Enabled As Boolean
Private m_Value As Integer
Event Click()

Private Sub UserControl_InitProperties()
    Caption = Extender.Name
    UserControl.FontSize = 10
    UserControl.FontBold = True
    Enabled = True
    m_Value = 1
End Sub

Private Sub UserControl_Click()
    If Enabled = False Then Exit Sub
    If Value = 1 Then
        Value = 0
    Else
        Value = 1
    End If

    RaiseEvent Click
    DrawCaption
End Sub

Public Property Get Caption() As String
Attribute Caption.VB_Description = "Enter text to describe action."
    Caption = m_Caption
End Property

Public Property Let Caption(NewCaption As String)
    m_Caption = NewCaption
    PropertyChanged "Caption"
    DrawCaption
End Property


Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Makes checkbox active or inactive"
    Enabled = m_Enabled
End Property

Public Property Let Enabled(NewEnabled As Boolean)
    m_Enabled = NewEnabled
    Value = m_Value

    If Value = 0 Then
        If Enabled = True Then UserControl.Picture = imgBlankCheck.Picture
    Else
        If Enabled = True Then UserControl.Picture = imgBlankCheck.Picture
    End If

    PropertyChanged "Enabled"
    DrawCaption
End Property
Public Property Get Font() As Font
Attribute Font.VB_Description = "Selects font to display text"
    Set Font = UserControl.Font
End Property

Public Property Set Font(ByVal NewFont As Font)
    Set UserControl.Font = NewFont
    PropertyChanged "Font"
    DrawCaption
End Property

Public Property Get ForeColor() As OLE_COLOR
Attribute ForeColor.VB_Description = "Sets color of font"
    ForeColor = UserControl.ForeColor
End Property

Public Property Let ForeColor(NewForeColor As OLE_COLOR)
    UserControl.ForeColor() = NewForeColor
    PropertyChanged "ForeColor"
    DrawCaption
End Property

Public Property Get Value() As Byte
Attribute Value.VB_Description = "Sets state of checkbox to checked or unchecked."
    Value = m_Value
End Property

Public Property Let Value(NewValue As Byte)
    m_Value = NewValue

    If Value = 0 Then UserControl.Picture = imgBlankCheck.Picture
    If Value = 1 Then UserControl.Picture = imgChecked.Picture

    PropertyChanged "Value"
    DrawCaption
End Property

Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    With PropBag
        Caption = .ReadProperty("Caption", Extender.Name)

        Enabled = .ReadProperty("Enabled", m_def_Enabled)
        Value = .ReadProperty("Value", m_def_Value)
        Set UserControl.Font = PropBag.ReadProperty("Font", Ambient.Font)
        UserControl.ForeColor = .ReadProperty("ForeColor", Ambient.ForeColor)
    End With
    DrawCaption
End Sub

Private Sub UserControl_Resize()
    UserControl.Picture = imgBlankCheck.Picture

    DrawCaption
End Sub

Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    With PropBag
        Call .WriteProperty("Caption", m_Caption, Extender.Name)
        Call .WriteProperty("Enabled", m_Enabled, m_def_Enabled)
        Call .WriteProperty("Value", m_Value, m_def_Value)
        Call .WriteProperty("Font", UserControl.Font, Ambient.Font)
        Call .WriteProperty("ForeColor", UserControl.ForeColor, Ambient.ForeColor)
    End With
End Sub
Private Sub DrawCaption()
    Dim lRtn As Long

    Cls
    UserControl.Font = Font
    m_CaptionRect.Left = 15
    m_CaptionRect.Top = 2
    m_CaptionRect.Right = UserControl.ScaleWidth
    m_CaptionRect.Bottom = UserControl.ScaleHeight
    lRtn = DrawTextEx(UserControl.hdc, m_Caption, Len(m_Caption), m_CaptionRect, _
                      m_Flag, ByVal 0&)
    UserControl.MaskPicture = UserControl.Image
End Sub
