VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ClsDialogsGuild"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private LAST_DIALOG As Byte
Private Const p_SEGUNDOS As Byte = 7

Private p_CANTIDADDIALOGOS As Byte

Private Type t_GuildDlg
    Texto As String
    Segundos As Byte
End Type

Private p_Dialogos() As t_GuildDlg
Private p_Activo As Boolean

Public Property Let CantidadDialogos(ByVal v As Byte)
    If v > 0 Then
        ReDim Preserve p_Dialogos(1 To v) As t_GuildDlg
        p_CANTIDADDIALOGOS = v
    End If
End Property

''
' Removes all dialogs from screen.

Public Sub RemoveDialogs()
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 04/02/07
'Removes all dialogs
'***************************************************
    Dim I As Long

    For I = 1 To p_CANTIDADDIALOGOS
        p_Dialogos(I).Texto = vbNullString
    Next I
End Sub

''
' Retrieves the number of dialogs to be displayed on screen.
'
' @return   The number of dialogs to be displayed on screen.

Public Property Get CantidadDialogos() As Byte
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 04/01/07
'Retrieves the number of dialogs to be displayed on screen
'***************************************************
    CantidadDialogos = p_CANTIDADDIALOGOS
End Property

Public Property Let Activo(ByVal v As Boolean)
    p_Activo = v
End Property

Public Property Get Activo() As Boolean
    Activo = p_Activo
End Property

Private Sub Class_Initialize()
    p_CANTIDADDIALOGOS = 5
    ReDim p_Dialogos(1 To p_CANTIDADDIALOGOS) As t_GuildDlg
    p_Activo = True
End Sub

Public Sub Draw()

    If Not p_Activo Then Exit Sub

    Dim LoopC As Long

    For LoopC = LAST_DIALOG To 1 Step -1
        If p_Dialogos(LoopC).Segundos > 0 Then
            If Left$(p_Dialogos(LoopC).Texto, 1) = Chr$(3) Then
                Call drawText(7, 347 + (LoopC * 10), mid$(p_Dialogos(LoopC).Texto, 2), D3DColorXRGB(1, 255, 1))
            Else
                Call drawText(7, 347 + (LoopC * 10), p_Dialogos(LoopC).Texto, D3DColorXRGB(1, 255, 1))
            End If
        End If
    Next LoopC

End Sub

Public Sub PassTimer()

    Dim LoopC As Long

    For LoopC = 1 To LAST_DIALOG
        If p_Dialogos(LoopC).Segundos > 0 Then
            p_Dialogos(LoopC).Segundos = p_Dialogos(LoopC).Segundos - 1

            If p_Dialogos(LoopC).Segundos < 1 Then
                If LoopC <> p_CANTIDADDIALOGOS Then
                    Dim LoopX As Long

                    For LoopX = LoopC To p_CANTIDADDIALOGOS - 1
                        p_Dialogos(LoopX) = p_Dialogos(LoopX + 1)
                    Next LoopX

                    p_Dialogos(p_CANTIDADDIALOGOS).Texto = vbNullString
                    p_Dialogos(p_CANTIDADDIALOGOS).Segundos = 0
                Else
                    p_Dialogos(LoopC).Texto = vbNullString
                End If

                If LAST_DIALOG > 0 Then
                    LAST_DIALOG = LAST_DIALOG - 1
                End If
            End If
        End If
    Next LoopC

End Sub

''
' Splits dialogs into lines fitting properly the render area and inserts them

Public Sub PushBackText(ByVal s As String)
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modification: 07/04/2009
'Splits dialogs into lines fitting properly the render area and inserts them
'07/04/2009: Now cuts the string properly in spite of not fitting in the screen. This avoids an infite loop.
'***************************************************
    Dim str As String
    Dim tmp As Integer

    str = s

    ' If it's too long to fit, split it
    Do While frmMain.TextWidth(str) > 500
        tmp = InStrRev(str, " ")

        If tmp = 0 Then Exit Do

        str = Left$(str, tmp - 1)
    Loop

    'Show message and continue with the rest
    Call RealPushBackText(Trim$(str))

    If LenB(str) <> LenB(s) Then
        Call PushBackText(Right$(s, Len(s) - Len(str) - 1))
    End If
End Sub

Private Sub RealPushBackText(ByVal str As String)

    If p_CANTIDADDIALOGOS > 0 Then

        Dim LoopC As Long

        If p_Dialogos(p_CANTIDADDIALOGOS).Segundos < 1 Then
            'Buscamos un slot vacio
            For LoopC = 1 To p_CANTIDADDIALOGOS
                If p_Dialogos(LoopC).Segundos < 1 Then
                    p_Dialogos(LoopC).Texto = str
                    p_Dialogos(LoopC).Segundos = p_SEGUNDOS

                    LAST_DIALOG = LAST_DIALOG + 1
                    Exit Sub
                End If
            Next LoopC
        Else
            ' Reordenamos la lista
            For LoopC = 1 To p_CANTIDADDIALOGOS - 1
                p_Dialogos(LoopC) = p_Dialogos(LoopC + 1)
            Next LoopC

            p_Dialogos(p_CANTIDADDIALOGOS).Texto = str
            p_Dialogos(p_CANTIDADDIALOGOS).Segundos = p_SEGUNDOS
        End If

    End If

End Sub


