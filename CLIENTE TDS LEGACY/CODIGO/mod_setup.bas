Attribute VB_Name = "mod_GameLoad"
Option Explicit
Public CONALFAB As Boolean
Type tSetings
    transArboles As Boolean
    AlphaBlending As Boolean
    EfectosPelea As Boolean
    LimitFps As Boolean
    NoFullScreen As Boolean
    videoMemory As Boolean
    rememberPass As Boolean
    tdsCursors As Boolean
    VSync As Boolean
    ConsolaFlotante As Boolean
    NightMode As Boolean
    
    
    AudioEffectsActivated As Byte
    AudioActivated As Byte
    AudioValue As Byte
    
    MusicActivated As Byte
    MusicValue As Byte
    
    InterfaceActivated As Byte
    InterfaceValue As Byte
    
    TerrainAnim As Byte
    EfectoDopa As Byte
    EfectoCaida As Byte
    LockWindow As Byte
    NoMoverseAlHablar As Byte
    ScrollHechi As Byte
End Type

Public settingFile As String
Public tSetup As tSetings
Public Sub SaveIni()
    With tSetup
        Call WriteVar(settingFile, "Init", "UsarAlpha", IIf(.AlphaBlending = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "Arboles", IIf(.transArboles = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "EfectComb", IIf(.EfectosPelea = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "Limitar", IIf(.LimitFps = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "NoRes", IIf(.NoFullScreen = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "UserMemvideo", IIf(.videoMemory = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "Rpassword", IIf(.rememberPass = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "Cursors", IIf(.tdsCursors = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "VSync", IIf(.VSync = True, "1", "0"))
        Call WriteVar(settingFile, "Init", "ConsolaFlotante", IIf(.ConsolaFlotante = True, "1", "0"))

        Call WriteVar(settingFile, "Init", "TerrainAnim", .TerrainAnim)
        Call WriteVar(settingFile, "Init", "EfectoDopa", .EfectoDopa)
        Call WriteVar(settingFile, "Init", "EfectoCaida", .EfectoCaida)
        Call WriteVar(settingFile, "Init", "LockWindow", .LockWindow)
        Call WriteVar(settingFile, "Init", "NoMoverseAlHablar", .NoMoverseAlHablar)
        Call WriteVar(settingFile, "Init", "ScrollHechi", .ScrollHechi)
        
        Call WriteVar(App.Path & "/Configuration.toml", "Audio", "EffectVolume", .AudioValue)
        Call WriteVar(App.Path & "/Configuration.toml", "Audio", "MusicVolume", .MusicValue)
        
    End With
End Sub

Public Sub LoadIni()
    On Error Resume Next
    settingFile = App.Path & "/init/Configs.ini"
    Dim Leer As clsIniManager
    Set Leer = New clsIniManager

    tSetup.EfectoCaida = 1    ' @@ Super preventivo

    If FileExist(settingFile, vbArchive) Then
        With tSetup
            .AlphaBlending = IIf(GetVar(settingFile, "Init", "UsarAlpha") = "1", True, False)
            .transArboles = IIf(GetVar(settingFile, "Init", "Arboles") = "1", True, False)
            .EfectosPelea = IIf(GetVar(settingFile, "Init", "EfectComb") = "1", True, False)
            .LimitFps = IIf(GetVar(settingFile, "Init", "Limitar") = "1", True, False)
            .NoFullScreen = IIf(GetVar(settingFile, "Init", "NoRes") = "1", True, False)
            .videoMemory = IIf(GetVar(settingFile, "Init", "UserMemvideo") = "1", True, False)
            .rememberPass = IIf(GetVar(settingFile, "Init", "Rpassword") = "1", True, False)
            .tdsCursors = IIf(GetVar(settingFile, "Init", "Cursors") = "1", True, False)
            .VSync = IIf(GetVar(settingFile, "Init", "VSync") = "1", True, False)
            .ConsolaFlotante = IIf(GetVar(settingFile, "Init", "ConsolaFlotante") = "1", True, False)
            
            .TerrainAnim = Val(GetVar(settingFile, "Init", "TerrainAnim"))
            .EfectoDopa = Val(GetVar(settingFile, "Init", "EfectoDopa"))

            .LockWindow = Val(GetVar(settingFile, "Init", "LockWindow"))

            .NoMoverseAlHablar = Val(GetVar(settingFile, "Init", "NoMoverseAlHablar"))
            .ScrollHechi = Val(GetVar(settingFile, "Init", "ScrollHechi"))

            Select Case Val(GetVar(settingFile, "Init", "EfectoCaida"))
            Case 1
                .EfectoCaida = 1
            Case 2
                .EfectoCaida = 2
            Case 3
                .EfectoCaida = 3
            Case Else
                .EfectoCaida = 1
            End Select
            
            .AudioValue = Val(GetVar(App.Path & "/Configuration.toml", "Audio", "EffectVolume"))
            .MusicValue = Val(GetVar(App.Path & "/Configuration.toml", "Audio", "MusicVolume"))
        
        End With
    End If
End Sub
