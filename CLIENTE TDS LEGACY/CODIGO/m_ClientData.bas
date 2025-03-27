Attribute VB_Name = "m_GameInfo"
Option Explicit

Public DataNpcs() As tNpcData, NumNpcs As Integer
Attribute NumNpcs.VB_VarUserMemId = 1073741824
Public DataSpells() As tSpellsData, NumSpells As Integer
Attribute DataSpells.VB_VarUserMemId = 1073741826
Attribute NumSpells.VB_VarUserMemId = 1073741826
Public DataObj() As tOBJData, NumObjs As Integer
Attribute DataObj.VB_VarUserMemId = 1073741828
Attribute NumObjs.VB_VarUserMemId = 1073741828

Public Type tOBJData
    nombre As String
    GrhIndex As Integer
    ObjType As Integer

    ' @@ Nuevos
    MagiaSkill As Byte
    RMSkill As Byte
    ArmaSkill As Byte
    EscudoSkill As Byte
    ArmaduraSkill As Byte
    ArcoSkill As Byte
    DagaSkill As Byte
    ' @@ Nuevos

    MinHit As Integer
    MaxHit As Integer
    MinDef As Integer
    MaxDef As Integer

    MinDefMagic As Integer
    MaxDefMagic As Integer

    ' @@ Usados para el mercado XD
    NumRopaje As Integer
    HechizoIndex As Byte
    Anim As Byte
    AnimRazaEnana As Byte

    RazaEnana As Byte

    Hombre As Byte
    Mujer As Byte

    Caos As Byte
    Real As Byte

    LinH As Integer
    LinP As Integer
    LinO As Integer

    Madera As Integer
    MaderaElfica As Integer

    Valor As Single
    ClaseProhibida(1 To NUMCLASES) As eClass
End Type

Public Type tNpcData
    nombre As String
    Desc As String
    NroExpresiones As Byte
    Expresiones() As String

    ' ++ Optimizacion te envia la info de los npcs.
    Body As Integer
    NpcType As eNPCType
    Head As Integer
    Heading As E_Heading
    Weapon As Integer
    Shield As Integer
    Helmet As Integer
    exp As Long

    Movement As Byte
End Type

Public Type tSpellsData
    nombre As String
    Desc As String
    PalabrasMagicas As String
    ManaRequerida As Integer
    SkillRequerido As Byte
    EnergiaRequerida As Integer

    '//Mensajes
    HechiceroMsg As String
    PropioMsg As String
    TargetMsg As String

    WAV As Integer
    FxGrh As Integer
    Loops As Byte
End Type

' Tipos de NPC's
Public Enum eNPCType
    Comun = 0
    Revividor = 1
    GuardiaReal = 2
    Entrenador = 3
    BANQUERO = 4
    Noble = 5
    DRAGON = 6
    Timbero = 7
    GuardiasCaos = 8
    ResucitadorNewbie = 9
    Pretoriano = 10
    Gobernador = 11
    GuardiasEspeciales = 12
End Enum

Public Sub LoadNameSource()

    Dim Leer As clsIniManager
    Dim LoopC As Long
    Dim File As String

    Set Leer = New clsIniManager

    File = Get_FileFrom(Scripts, "obj.dat")

    Leer.Initialize File

    NumObjs = Leer.GetValue("INIT", "NumOBJs")

    ReDim DataObj(1 To NumObjs) As tOBJData

    Dim I As Long
    Dim n As Integer
    Dim s As String

    For LoopC = 1 To NumObjs

        With DataObj(LoopC)
            .nombre = Leer.GetValue("OBJ" & LoopC, "Name")
            .GrhIndex = Val(Leer.GetValue("OBJ" & LoopC, "GrhIndex"))
            .ObjType = Val(Leer.GetValue("OBJ" & LoopC, "ObjType"))

            .MagiaSkill = Val(Leer.GetValue("OBJ" & LoopC, "MagiaSkill"))
            .RMSkill = Val(Leer.GetValue("OBJ" & LoopC, "RMSkill"))
            .ArmaSkill = Val(Leer.GetValue("OBJ" & LoopC, "WeaponSkill"))
            .EscudoSkill = Val(Leer.GetValue("OBJ" & LoopC, "EscudoSkill"))
            .ArmaduraSkill = Val(Leer.GetValue("OBJ" & LoopC, "ArmaduraSkill"))
            .ArcoSkill = Val(Leer.GetValue("OBJ" & LoopC, "ArcoSkill"))
            .DagaSkill = Val(Leer.GetValue("OBJ" & LoopC, "DagaSkill"))

            .MinHit = Val(Leer.GetValue("OBJ" & LoopC, "MinHit"))
            .MaxHit = Val(Leer.GetValue("OBJ" & LoopC, "MaxHit"))
            .MinDef = Val(Leer.GetValue("OBJ" & LoopC, "MinDef"))
            .MaxDef = Val(Leer.GetValue("OBJ" & LoopC, "MaxDef"))

            .MinDefMagic = Val(Leer.GetValue("OBJ" & LoopC, "DefensaMagicaMin"))
            .MaxDefMagic = Val(Leer.GetValue("OBJ" & LoopC, "DefensaMagicaMax"))

            ' @@ Usado para el mercado xd
            .NumRopaje = Val(Leer.GetValue("OBJ" & LoopC, "NumRopaje"))
            .HechizoIndex = Val(Leer.GetValue("OBJ" & LoopC, "HechizoIndex"))

            .Anim = Val(Leer.GetValue("OBJ" & LoopC, "Anim"))
            .AnimRazaEnana = Val(Leer.GetValue("OBJ" & LoopC, "AnimRazaEnana"))

            .RazaEnana = Val(Leer.GetValue("OBJ" & LoopC, "RazaEnana"))

            .Hombre = Val(Leer.GetValue("OBJ" & LoopC, "Hombre"))
            .Mujer = Val(Leer.GetValue("OBJ" & LoopC, "Mujer"))

            .Caos = Val(Leer.GetValue("OBJ" & LoopC, "Caos"))
            .Real = Val(Leer.GetValue("OBJ" & LoopC, "Real"))

            .LinH = Val(Leer.GetValue("OBJ" & LoopC, "LingH"))
            .LinP = Val(Leer.GetValue("OBJ" & LoopC, "LingP"))
            .LinO = Val(Leer.GetValue("OBJ" & LoopC, "LingO"))

            .Madera = Val(Leer.GetValue("OBJ" & LoopC, "Madera"))
            .MaderaElfica = Val(Leer.GetValue("OBJ" & LoopC, "MaderaElfica"))

            .Valor = Val(Leer.GetValue("OBJ" & LoopC, "Valor"))

            For I = 1 To NUMCLASES
                s = UCase$(Leer.GetValue("OBJ" & LoopC, "CP" & I))
                n = 1

                Do While LenB(s) > 0 And UCase$(ListaClases(n)) <> s And n < NUMCLASES
                    n = n + 1
                Loop

                If LenB(s) > 0 Then
                    .ClaseProhibida(n) = 1
                End If
            Next I

        End With

    Next LoopC

    Delete_File (File)

    Set Leer = Nothing

    ' @@ Hechizos
    Set Leer = New clsIniManager

    File = Get_FileFrom(Scripts, "Hechizos.dat")

    Leer.Initialize File

    NumSpells = Leer.GetValue("INIT", "NumeroHechizos")
    ReDim DataSpells(1 To NumSpells) As tSpellsData

    For LoopC = 1 To NumSpells

        With DataSpells(LoopC)
            .Desc = Leer.GetValue("HECHIZO" & LoopC, "Desc")
            .PalabrasMagicas = Leer.GetValue("HECHIZO" & LoopC, "PalabrasMagicas")
            .nombre = Leer.GetValue("HECHIZO" & LoopC, "Nombre")
            .SkillRequerido = Val(Leer.GetValue("HECHIZO" & LoopC, "MinSkill"))

            If LoopC <> 38 And LoopC <> 39 Then
                .EnergiaRequerida = Val(Leer.GetValue("HECHIZO" & LoopC, "StaRequerido"))
                .HechiceroMsg = Leer.GetValue("HECHIZO" & LoopC, "HechizeroMsg")
                .ManaRequerida = Val(Leer.GetValue("HECHIZO" & LoopC, "ManaRequerido"))
                .PropioMsg = Leer.GetValue("HECHIZO" & LoopC, "PropioMsg")
                .TargetMsg = Leer.GetValue("HECHIZO" & LoopC, "TargetMsg")
            End If

            .WAV = Val(Leer.GetValue("HECHIZO" & LoopC, "WAV"))
            .FxGrh = Val(Leer.GetValue("HECHIZO" & LoopC, "Fxgrh"))
            .Loops = Val(Leer.GetValue("HECHIZO" & LoopC, "Loops"))
        End With

    Next LoopC

    Set Leer = Nothing

    Delete_File (File)

    ' @@ Npc's
    Set Leer = New clsIniManager

    File = Get_FileFrom(Scripts, "Npcs.dat")

    Leer.Initialize File

    NumNpcs = Leer.GetValue("INIT", "NumNpcs")
    ReDim DataNpcs(1 To NumNpcs) As tNpcData

    Dim X As Long

    For LoopC = 1 To NumNpcs

        With DataNpcs(LoopC)
            .nombre = Leer.GetValue("NPC" & LoopC, "Name")
            .Desc = Leer.GetValue("NPC" & LoopC, "Desc")

            .NroExpresiones = Val(Leer.GetValue("NPC" & LoopC, "NROEXP"))

            If .NroExpresiones > 0 Then
                ReDim .Expresiones(1 To .NroExpresiones) As String

                For X = 1 To .NroExpresiones
                    .Expresiones(X) = Leer.GetValue("NPC" & LoopC, "EXP" & X)
                Next X
            End If

            .NpcType = Val(Leer.GetValue("NPC" & LoopC, "NpcType"))

            .Body = Val(Leer.GetValue("NPC" & LoopC, "Body"))
            .Head = Val(Leer.GetValue("NPC" & LoopC, "Head"))
            .Heading = Val(Leer.GetValue("NPC" & LoopC, "Heading"))

            .Weapon = Val(Leer.GetValue("NPC" & LoopC, "Weapon"))
            .Shield = Val(Leer.GetValue("NPC" & LoopC, "Shield"))
            .Helmet = Val(Leer.GetValue("NPC" & LoopC, "Helmet"))
            .exp = Val(Leer.GetValue("NPC" & LoopC, "GiveEXP"))

            .Movement = Val(Leer.GetValue("NPC" & LoopC, "Movement"))
        End With

    Next LoopC

    Delete_File (File)

    Set Leer = Nothing

    Exit Sub

    ' borrar snippet
    Dim str As String
    Dim ID As Long
    Dim exp As Long

    Dim ll(0 To 51) As Long

    str = "$npcexp = array("
    For LoopC = 1 To NumNpcs
        Select Case LCase$(DataNpcs(LoopC).nombre)
        Case "acechador invisible"
            exp = DataNpcs(LoopC).exp
            ID = 0
        Case "aguila"
            exp = DataNpcs(LoopC).exp
            ID = 1
        Case "araña gigante"
            exp = DataNpcs(LoopC).exp
            ID = 2
        Case "arbol de jungla"
            exp = DataNpcs(LoopC).exp
            ID = 3
        Case "asesino"
            exp = DataNpcs(LoopC).exp
            ID = 4
        Case "bandido"
            exp = DataNpcs(LoopC).exp
            ID = 5
        Case "beholder"
            exp = DataNpcs(LoopC).exp
            ID = 6
        Case "bruja"
            exp = DataNpcs(LoopC).exp
            ID = 7
        Case "calamar gigante"
            exp = DataNpcs(LoopC).exp
            ID = 8
        Case "cthulu"
            exp = DataNpcs(LoopC).exp
            ID = 9
        Case "cuervo"
            exp = DataNpcs(LoopC).exp
            ID = 10
        Case "demonio"
            exp = DataNpcs(LoopC).exp
            ID = 11
        Case "dragón rojo"
            exp = DataNpcs(LoopC).exp
            ID = 12
        Case "duende"
            exp = DataNpcs(LoopC).exp
            ID = 13
        Case "duende molesto"
            exp = DataNpcs(LoopC).exp
            ID = 14
        Case "escorpion"
            exp = DataNpcs(LoopC).exp
            ID = 15
        Case "esqueleto"
            exp = DataNpcs(LoopC).exp
            ID = 16
        Case "esqueleto guerrero"
            exp = DataNpcs(LoopC).exp
            ID = 17
        Case "galeón fantasmal"
            exp = DataNpcs(LoopC).exp
            ID = 18
        Case "gallo salvaje"
            exp = DataNpcs(LoopC).exp
            ID = 19
        Case "goblin"
            exp = DataNpcs(LoopC).exp
            ID = 20
        Case "golem"
            exp = DataNpcs(LoopC).exp
            ID = 21
        Case "golem de hielo"
            exp = DataNpcs(LoopC).exp
            ID = 22
        Case "gran dragón rojo"
            exp = DataNpcs(LoopC).exp
            ID = 23
        Case "hormiga"
            exp = DataNpcs(LoopC).exp
            ID = 24
        Case "hormiga gigante"
            exp = DataNpcs(LoopC).exp
            ID = 25
        Case "jabalí salvaje"
            exp = DataNpcs(LoopC).exp
            ID = 26
        Case "leviatán"
            exp = DataNpcs(LoopC).exp
            ID = 27
        Case "liche"
            exp = DataNpcs(LoopC).exp
            ID = 28
        Case "lobo"
            exp = DataNpcs(LoopC).exp
            ID = 29
        Case "lobo invernal"
            exp = DataNpcs(LoopC).exp
            ID = 30
        Case "lord orco"
            exp = DataNpcs(LoopC).exp
            ID = 31
        Case "lord zombie"
            exp = DataNpcs(LoopC).exp
            ID = 32
        Case "mago malvado"
            exp = DataNpcs(LoopC).exp
            ID = 33
        Case "medusa"
            exp = DataNpcs(LoopC).exp
            ID = 34
        Case "murcielago"
            exp = DataNpcs(LoopC).exp
            ID = 35
        Case "ogro"
            exp = DataNpcs(LoopC).exp
            ID = 36
        Case "orco"
            exp = DataNpcs(LoopC).exp
            ID = 37
        Case "orco brujo"
            exp = DataNpcs(LoopC).exp
            ID = 38
        Case "oso pardo"
            exp = DataNpcs(LoopC).exp
            ID = 39
        Case "oso polar"
            exp = DataNpcs(LoopC).exp
            ID = 40
        Case "pequeño dragón rojo"
            exp = DataNpcs(LoopC).exp
            ID = 41
        Case "pingüino"
            exp = DataNpcs(LoopC).exp
            ID = 42
        Case "quarck mágico"
            exp = DataNpcs(LoopC).exp
            ID = 43
        Case "rata"
            exp = DataNpcs(LoopC).exp
            ID = 44
        Case "serpiente"
            exp = DataNpcs(LoopC).exp
            ID = 45
        Case "servidor del mal"
            exp = DataNpcs(LoopC).exp
            ID = 46
        Case "tigre salvaje"
            exp = DataNpcs(LoopC).exp
            ID = 47
        Case "tortuga gigante"
            exp = DataNpcs(LoopC).exp
            ID = 48
        Case "ucorno"
            exp = DataNpcs(LoopC).exp
            ID = 49
        Case "viuda negra"
            exp = DataNpcs(LoopC).exp
            ID = 50
        Case "zombie"
            exp = DataNpcs(LoopC).exp
            ID = 51
        Case Else
            exp = 0
            ID = 52
        End Select

        If exp > 0 Then
            'str = str & vbNewLine & "'" & ID & "' => " & exp & ","
            ll(ID) = exp
        End If

    Next LoopC

    For LoopC = 0 To 51
        If ll(LoopC) > 0 Then
            str = str & vbNewLine & ll(LoopC) & ","
        End If
    Next LoopC

    str = str & ");}"

    Exit Sub
errHandler:
    End
End Sub

Public Function GetNameHechizo(ByVal SpellIndex As Integer) As String

    If SpellIndex < 1 Or SpellIndex > NumSpells Then GetNameHechizo = "(Vacio)": Exit Function
    GetNameHechizo = DataSpells(SpellIndex).nombre

End Function

Public Function Tilde(data As String) As String

    Tilde = ReplaceB(ReplaceB(ReplaceB(ReplaceB(ReplaceB(UCase$(data), "Á", "A"), "É", "E"), "Í", "I"), "Ó", "O"), "Ú", "U")

End Function

Function ReplaceB(stExpression As String, stFind As String, stReplace As String) As String

' ++ Mas rapida esta funcion que la de visual basic xd

    Dim lnStart As Long, lnCount As Long

    lnStart = Len(stFind)
    ReplaceB = stExpression

    Do
        lnCount = InStr(1, ReplaceB, stFind)

        If lnCount = 0 Then Exit Function

        If lnStart = Len(stReplace) Then
            Mid$(ReplaceB, lnCount, lnStart) = stReplace
        Else
            ReplaceB = Left$(ReplaceB, lnCount - 1) & stReplace & mid$(ReplaceB, lnCount + lnStart)
        End If

    Loop

End Function

