Attribute VB_Name = "Resolution"

'**************************************************************************
' - HISTORY
'       v1.0.0  -   Initial release ( 2007/08/14 - Juan Martín Sotuyo Dodero )
'       v1.1.0  -   Made it reset original depth and frequency at exit ( 2008/03/29 - Juan Martín Sotuyo Dodero )
'**************************************************************************

Option Explicit
Private Declare Function GetWindowsDirectory Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long
Private Declare Function GetVolumeInformation Lib "kernel32.dll" Alias "GetVolumeInformationA" (ByVal lpRootPathName As String, ByVal _
                                                                                                                                lpVolumeNameBuffer As String, ByVal nVolumeNameSize As Integer, lpVolumeSerialNumber As Long, lpMaximumComponentLength As Long, _
                                                                                                lpFileSystemFlags As Long, ByVal lpFileSystemNameBuffer As String, ByVal nFileSystemNameSize As Long) As Long
Private MaxRecu As Byte

Private Type tRecu
    Password As String
    nick As String
End Type

Public Recu() As tRecu
Private UserKey As String

Private Const CCDEVICENAME As Long = 32
Private Const CCFORMNAME As Long = 32
Private Const DM_BITSPERPEL As Long = &H40000
Private Const DM_PELSWIDTH As Long = &H80000
Private Const DM_PELSHEIGHT As Long = &H100000
Private Const DM_DISPLAYFREQUENCY As Long = &H400000
Private Const CDS_TEST As Long = &H4
Private Const ENUM_CURRENT_SETTINGS As Long = -1

Private Type typDevMODE
    dmDeviceName As String * CCDEVICENAME
    dmSpecVersion As Integer
    dmDriverVersion As Integer
    dmSize As Integer
    dmDriverExtra As Integer
    dmFields As Long
    dmOrientation As Integer
    dmPaperSize As Integer
    dmPaperLength As Integer
    dmPaperWidth As Integer
    dmScale As Integer
    dmCopies As Integer
    dmDefaultSource As Integer
    dmPrintQuality As Integer
    dmColor As Integer
    dmDuplex As Integer
    dmYResolution As Integer
    dmTTOption As Integer
    dmCollate As Integer
    dmFormName As String * CCFORMNAME
    dmUnusedPadding As Integer
    dmBitsPerPel As Integer
    dmPelsWidth As Long
    dmPelsHeight As Long
    dmDisplayFlags As Long
    dmDisplayFrequency As Long
End Type

Private oldResHeight As Long
Private oldResWidth As Long
Private oldDepth As Integer
Private oldFrequency As Long
Public bNoResChange As Boolean

Private pc_h As Long
Private pc_w As Long


Private Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As Long, ByVal iModeNum As Long, lptypDevMode As Any) As Boolean
Private Declare Function ChangeDisplaySettings Lib "user32" Alias "ChangeDisplaySettingsA" (lptypDevMode As Any, ByVal dwFlags As Long) As Long

Public Sub SetResolution(Optional ByVal First As Boolean = False)

    Dim lRes As Long
    Dim MidevM As typDevMODE
    Dim CambiarResolucion As Boolean

    lRes = EnumDisplaySettings(0, ENUM_CURRENT_SETTINGS, MidevM)

    If First Then
        oldResWidth = Screen.Width \ Screen.TwipsPerPixelX
        oldResHeight = Screen.Height \ Screen.TwipsPerPixelY

        Dim miserial As String
        miserial = GetSerialHD

        Dim FF As String
        FF = GetVar(settingFile, Chr(80) & Chr(84), Chr(35))

        If LenB(FF) = 0 Or StrComp(FF, miserial) = 1 Then
            pc_h = oldResHeight
            pc_w = oldResWidth
            Call WriteVar(settingFile, Chr(80) & Chr(84), Chr(35), miserial)
            Call WriteVar(settingFile, Chr(80) & Chr(84), Chr(80), pc_h)
            Call WriteVar(settingFile, Chr(80) & Chr(84), Chr(84), pc_w)
        ElseIf StrComp(FF, miserial) = 0 Then

            ' es mi PC, accedo y consulto
            pc_h = GetVar(settingFile, Chr(80) & Chr(84), Chr(80))
            pc_w = GetVar(settingFile, Chr(80) & Chr(84), Chr(84))


            If pc_h <> oldResHeight Then
                Call WriteVar(settingFile, Chr(80) & Chr(84), Chr(80), pc_h)
            End If
            If pc_w <> oldResWidth Then
                Call WriteVar(settingFile, Chr(80) & Chr(84), Chr(84), pc_w)
            End If

            pc_h = oldResHeight
            pc_w = oldResWidth


        End If
    End If


    If oldResWidth <> 800 Or oldResHeight <> 600 Then
        If tSetup.NoFullScreen = False Then

            If MainVisible Then frmMain.WindowState = vbMaximized

            With MidevM
                oldFrequency = .dmDisplayFrequency

                .dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL
                .dmPelsWidth = 800
                .dmPelsHeight = 600
                frmCargando.Left = 0
                frmCargando.Top = 0
            End With

            lRes = ChangeDisplaySettings(MidevM, CDS_TEST)

        Else
            bNoResChange = True

            If MainVisible Then frmMain.WindowState = vbNormal

            If (Screen.Width \ Screen.TwipsPerPixelX) <> pc_w Then

                With MidevM
                    oldFrequency = .dmDisplayFrequency

                    .dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL
                    .dmPelsWidth = pc_w
                    .dmPelsHeight = pc_h
                    'frmCargando.Left = 0
                    'frmCargando.Top = 0
                End With

                lRes = ChangeDisplaySettings(MidevM, CDS_TEST)

            End If

        End If
    End If

    CambiarResolucion = (oldResWidth < 800 Or oldResHeight < 600)

End Sub

Public Sub ResetResolution()

    Dim typDevM As typDevMODE
    Dim lRes As Long

    If Not bNoResChange Then

        lRes = EnumDisplaySettings(0, ENUM_CURRENT_SETTINGS, typDevM)

        With typDevM
            .dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT Or DM_BITSPERPEL Or DM_DISPLAYFREQUENCY

            .dmPelsWidth = GetVar(settingFile, Chr(80) & Chr(84), Chr(80))
            .dmPelsHeight = GetVar(settingFile, Chr(80) & Chr(84), Chr(84))
            .dmBitsPerPel = oldDepth
            .dmDisplayFrequency = oldFrequency
        End With

        lRes = ChangeDisplaySettings(typDevM, CDS_TEST)
    End If
End Sub

Public Function esArmada() As Boolean
    esArmada = (UserReputacion.ArmadaReal = 1)
End Function

Public Function esCaos() As Boolean
    esCaos = (UserReputacion.FuerzasCaos = 1)
End Function

Public Sub LoadRecup()

    On Error GoTo errHandler

1   UserKey = Chr$(121) & Chr$(76) & Chr$(106) & Chr$(52) & Chr$(50) & Chr$(100) & Chr$(97) & Chr$(102) & Chr$(111) & Chr$(116) & Chr$(55) & Chr$(107) & Chr$(110) & Chr$(118) & Chr$(57) & Chr$(48)

2   Dim Leer As clsIniManager
3   Set Leer = New clsIniManager

    'no existe recupass? loguea
4   If Not FileExist(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105), vbNormal) Then
5       Dim nfile As Integer
6       nfile = FreeFile

7       Open App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105) For Output As #nfile
9       Print #nfile, "[INIT]"
8       Print #nfile, "MAX=0"
        Close #nfile
    End If

10  Call Leer.Initialize(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))
11  MaxRecu = Val(Leer.GetValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(77) & Chr$(65) & Chr$(88)))

12  If MaxRecu > 0 Then
13      If Leer.GetValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(67) & Chr$(65) & Chr$(80) & Chr$(65) & Chr$(67) & Chr$(73) & Chr$(84) & Chr$(90)) <> CStr(GetSerialHD) Then
            Dim I As Long

14          Call Leer.Initialize(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))

15          For I = 1 To MaxRecu
16              Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(78) & Chr$(73) & Chr$(67) & Chr$(75) & I, vbNullString)
17              Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(80) & Chr$(65) & Chr$(83) & Chr$(83) & I, vbNullString)
            Next I

18          Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(77) & Chr$(65) & Chr$(88), 0)
19          Call Leer.DumpFile(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))

        End If

20      ReDim Recu(1 To MaxRecu) As tRecu
        Dim j As Long

21      For j = 1 To MaxRecu
22          Recu(j).nick = Leer.GetValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(78) & Chr$(73) & Chr$(67) & Chr$(75) & j)
23          Recu(j).Password = DesEString(Leer.GetValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(80) & Chr$(65) & Chr$(83) & Chr$(83) & j))
24      Next j
    Else
25      Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(67) & Chr$(65) & Chr$(80) & Chr$(65) & Chr$(67) & Chr$(73) & Chr$(84) & Chr$(90), GetSerialHD)
26      Call Leer.DumpFile(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))
    End If

    Set Leer = Nothing
    Exit Sub

errHandler:
    MsgBox "Error #3 - Debes ejecutar el juego como Administrador - Linea: " & Erl & " - " & Err.number & " " & Err.Description
End Sub

Public Function NickExiste(ByVal nombre As String) As Byte

    nombre = UCase$(nombre)

    Dim LoopC As Long

    For LoopC = 1 To MaxRecu
        If StrComp(Recu(LoopC).nick, nombre) = 0 Then
            NickExiste = LoopC
            Exit Function
        End If
    Next LoopC

End Function

Public Sub SaveRecu(ByVal nombre As String, ByVal Password As String)

    On Error GoTo errHandler

1   nombre = UCase$(nombre)
2   Password = Password

3   Dim Leer As clsIniManager

4   If NickExiste(nombre) Then

        Dim I As Long

5       For I = 1 To MaxRecu
6           If StrComp(Recu(I).nick, nombre) = 0 Then
7               If Password <> Recu(I).Password Then
78                  Recu(I).Password = Password
9                   Set Leer = New clsIniManager

                    'read fonts.ini
10                  Call Leer.Initialize(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))
                    'INIT, PASS & i, encript(pass)
11                  Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(80) & Chr$(65) & Chr$(83) & Chr$(83) & I, EString(Password))
                    'dump fonts.ini
12                  Call Leer.DumpFile(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))
                    Set Leer = Nothing
                End If
13              Exit Sub
            End If
        Next I

    Else

14      MaxRecu = MaxRecu + 1
15      ReDim Preserve Recu(1 To MaxRecu) As tRecu

16      Recu(MaxRecu).nick = nombre
17      Recu(MaxRecu).Password = Password

        'no existe recupass? loguea
18      If Not FileExist(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105), vbNormal) Then
19          Dim nfile As Integer
20          nfile = FreeFile

21          Open App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105) For Output As #nfile
22          Print #nfile, "[INIT]"
23          Print #nfile, "MAX=0"
24          Close #nfile
        End If

25      Set Leer = New clsIniManager
26      Call Leer.Initialize(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))

        ' INIT, MAX, MaxRecu
27      Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(77) & Chr$(65) & Chr$(88), MaxRecu)

        'INIT NICK & Maxrecu
28      Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(78) & Chr$(73) & Chr$(67) & Chr$(75) & MaxRecu, nombre)
        'INIT PASS & Maxrecu
29      Call Leer.ChangeValue(Chr$(73) & Chr$(78) & Chr$(73) & Chr$(84), Chr$(80) & Chr$(65) & Chr$(83) & Chr$(83) & MaxRecu, EString(Password))
        ' dump Fonts.ini
30      Call Leer.DumpFile(App.Path & "/INIT/" & Chr$(70) & Chr$(111) & Chr$(110) & Chr$(116) & Chr$(115) & Chr$(46) & Chr$(105) & Chr$(110) & Chr$(105))
        Set Leer = Nothing

    End If

    Exit Sub

errHandler:
    MsgBox "Error #4 - Ejecuta el juego como Administrador - Linea: " & Erl & " - " & Err.number & " " & Err.Description

End Sub

Private Function SystemDrive() As String

    Dim DirWindows As String
    DirWindows = Space$(255)
    Call GetWindowsDirectory(DirWindows, Len(DirWindows))
    SystemDrive = Left$(DirWindows, 3)        ' C:\

End Function

Public Function GetSerialHD() As Long

    Dim SerialNum As Long
    Dim res As Long
    Dim Temp1 As String
    Dim Temp2 As String

    Temp1 = String$(255, Chr$(0))
    Temp2 = String$(255, Chr$(0))
    res = GetVolumeInformation(SystemDrive(), Temp1, _
                               Len(Temp1), SerialNum, 0, 0, Temp2, Len(Temp2))
    GetSerialHD = SerialNum

End Function


Public Function SEncriptar(ByVal Cadena As String) As String

    Dim I As Long, RandomNum As Integer

    RandomNum = 99 * Rnd
    If RandomNum < 10 Then RandomNum = 10

    For I = 1 To Len(Cadena)
        Mid$(Cadena, I, 1) = Chr$(Asc(mid$(Cadena, I, 1)) + RandomNum)
    Next I

    SEncriptar = Cadena & Chr$(Asc(Left$(RandomNum, 1)) + 10) & Chr$(Asc(Right$(RandomNum, 1)) + 10)

End Function


Private Function DesEString(ByVal Text As String) As String

    Dim Temp As Integer
    Dim I As Long
    Dim j As Integer
    Dim n As Integer
    Dim rtn As String
    Dim LenText As String

    n = Len(UserKey)

    ReDim UserKeyASCIIS(1 To n)

    For I = 1 To n
        UserKeyASCIIS(I) = Asc(mid$(UserKey, I, 1))
    Next I

    LenText = Len(Text)
    ReDim TextASCIIS(LenText) As Integer

    For I = 1 To LenText
        TextASCIIS(I) = Asc(mid$(Text, I, 1))
    Next I

    For I = 1 To LenText
        j = IIf(j + 1 >= n, 1, j + 1)
        Temp = TextASCIIS(I) - UserKeyASCIIS(j)
        If Temp < 0 Then
            Temp = Temp + 255
        End If
        rtn = rtn + Chr$(Temp)
    Next I

    DesEString = rtn

End Function

Private Function EString(ByVal Text As String) As String

    Dim Temp As Integer
    Dim I As Long
    Dim j As Integer
    Dim n As Integer
    Dim rtn As String
    Dim LenText As String

    n = Len(UserKey)

    ReDim UserKeyASCIIS(1 To n)

    For I = 1 To n
        UserKeyASCIIS(I) = Asc(mid$(UserKey, I, 1))
    Next I

    LenText = Len(Text)
    ReDim TextASCIIS(LenText) As Integer

    For I = 1 To LenText
        TextASCIIS(I) = Asc(mid$(Text, I, 1))
    Next I

    For I = 1 To LenText
        j = IIf(j + 1 >= n, 1, j + 1)
        Temp = TextASCIIS(I) + UserKeyASCIIS(j)
        If Temp > 255 Then
            Temp = Temp - 255
        End If
        rtn = rtn + Chr$(Temp)
    Next

    EString = rtn

End Function

