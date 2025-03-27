Attribute VB_Name = "Carteles"
Option Explicit

Private XPosCartel As Integer
Private YPosCartel As Integer
Const MAXLONG = 40

'Carteles
Public Cartel As Boolean
Public Leyenda As String
Public LeyendaFormateada() As String
Public textura As Integer


Sub InitCartel(Ley As String, Grh As Integer, qX As Byte, qY As Byte)
    If Not Cartel Then
        Leyenda = Ley
        textura = Grh
        Cartel = True

        XPosCartel = Engine_TPtoSPX(qX)
        YPosCartel = Engine_TPtoSPY(qY)

        ReDim LeyendaFormateada(0 To (Len(Ley) \ (MAXLONG \ 2)))

        Dim I As Integer, k As Integer, anti As Integer
        anti = 1
        k = 0
        I = 0
        Call DarFormato(Leyenda, I, k, anti)
        I = 0
        Do While LeyendaFormateada(I) <> "" And I < UBound(LeyendaFormateada)

            I = I + 1
        Loop
        ReDim Preserve LeyendaFormateada(0 To I)
    Else
        Exit Sub
    End If
End Sub

Private Function DarFormato(s As String, I As Integer, k As Integer, anti As Integer)
    If anti + I <= Len(s) + 1 Then
        If ((I >= MAXLONG) And mid$(s, anti + I, 1) = " ") Or (anti + I = Len(s)) Then
            LeyendaFormateada(k) = mid(s, anti, I + 1)
            k = k + 1
            anti = anti + I + 1
            I = 0
        Else
            I = I + 1
        End If
        Call DarFormato(s, I, k, anti)
    End If
End Function

Sub DibujarCartel()
    If Not Cartel Then Exit Sub
    Dim X As Integer, Y As Integer, xx As Integer, yy As Integer
    X = XPosCartel - 115
    Y = YPosCartel - 100

    Dim lighthandle(3) As Long

    lighthandle(0) = D3DColorXRGB(AlphaB, AlphaB, AlphaB): lighthandle(1) = lighthandle(0): lighthandle(2) = lighthandle(0): lighthandle(3) = lighthandle(0)
    If textura = 501 Then
        xx = 20
        yy = 30
    ElseIf textura = 514 Then
        xx = 20
        yy = 77
    End If

    Call DDrawTransGrhIndextoSurface(textura, X - xx, Y - yy, 0, lvalue)
    'Call DDrawTransGrhIndextoSurface(426, 500, 500, 0, False, False, lighthandle)
    Dim j As Integer, desp As Integer

    For j = 0 To UBound(LeyendaFormateada)
        drawText X, Y + desp, LeyendaFormateada(j), -1
        desp = desp + (frmMain.Font.Size) + 5
    Next
End Sub

