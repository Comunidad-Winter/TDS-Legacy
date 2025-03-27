Attribute VB_Name = "TCP"
'Argentum Online 0.12.2
'Copyright (C) 2002 Márquez Pablo Ignacio
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@
'www.geocities.com/gmorgolock
'Calle 3 número 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Código Postal 1900
'Pablo Ignacio Márquez

Option Explicit

Sub DarCuerpo(ByVal UserIndex As Integer)
'*************************************************
'Author: Nacho (Integer)
'Last modified: 14/03/2007
'Elije una cabeza para el usuario y le da un body
'*************************************************
    Dim cuerpoDesnudo As Integer
    Dim UserRaza As Byte
    Dim UserGenero As Byte

    UserGenero = UserList(UserIndex).Genero
    UserRaza = UserList(UserIndex).raza

    Select Case UserGenero
    Case eGenero.Hombre
        Select Case UserRaza
        Case eRaza.Humano
            cuerpoDesnudo = 21
        Case eRaza.Drow
            cuerpoDesnudo = 32
        Case eRaza.Elfo
            cuerpoDesnudo = 21
        Case eRaza.Gnomo
            cuerpoDesnudo = 53
        Case eRaza.Enano
            cuerpoDesnudo = 53
        End Select
    Case Else
        Select Case UserRaza
        Case eRaza.Humano
            cuerpoDesnudo = 39
        Case eRaza.Drow
            cuerpoDesnudo = 40
        Case eRaza.Elfo
            cuerpoDesnudo = 39
        Case eRaza.Gnomo
            cuerpoDesnudo = 60
        Case eRaza.Enano
            cuerpoDesnudo = 60
        End Select
    End Select

    UserList(UserIndex).Char.body = cuerpoDesnudo
End Sub

Public Function DarCabeza(ByVal UserRaza As Byte, ByVal UserGenero As Byte) As Integer

    Select Case UserGenero
    Case eGenero.Hombre
        Select Case UserRaza
        Case eRaza.Humano
            DarCabeza = RandomNumber(HUMANO_H_PRIMER_CABEZA, HUMANO_H_ULTIMA_CABEZA)
        Case eRaza.Elfo
            DarCabeza = RandomNumber(ELFO_H_PRIMER_CABEZA, ELFO_H_ULTIMA_CABEZA)
        Case eRaza.Drow
            DarCabeza = RandomNumber(DROW_H_PRIMER_CABEZA, DROW_H_ULTIMA_CABEZA)
        Case eRaza.Enano
            DarCabeza = RandomNumber(ENANO_H_PRIMER_CABEZA, ENANO_H_ULTIMA_CABEZA)
        Case eRaza.Gnomo
            DarCabeza = RandomNumber(GNOMO_H_PRIMER_CABEZA, GNOMO_H_ULTIMA_CABEZA)
        End Select

    Case Else
        Select Case UserRaza
        Case eRaza.Humano
            DarCabeza = RandomNumber(HUMANO_M_PRIMER_CABEZA, HUMANO_M_ULTIMA_CABEZA)
        Case eRaza.Elfo
            DarCabeza = RandomNumber(ELFO_M_PRIMER_CABEZA, ELFO_M_ULTIMA_CABEZA)
        Case eRaza.Drow
            DarCabeza = RandomNumber(DROW_M_PRIMER_CABEZA, DROW_M_ULTIMA_CABEZA)
        Case eRaza.Enano
            DarCabeza = RandomNumber(ENANO_M_PRIMER_CABEZA, ENANO_M_ULTIMA_CABEZA)
        Case eRaza.Gnomo
            DarCabeza = RandomNumber(GNOMO_M_PRIMER_CABEZA, GNOMO_M_ULTIMA_CABEZA - 1)
        End Select
    End Select

End Function

Public Function ValidHead(ByVal HeadSeleccionada As Integer, ByVal UserRaza As Byte, ByVal UserGenero As Byte) As Boolean

    Select Case UserGenero
    Case eGenero.Hombre
        Select Case UserRaza
        Case eRaza.Humano
            ValidHead = (HeadSeleccionada >= HUMANO_H_PRIMER_CABEZA And HeadSeleccionada <= HUMANO_H_ULTIMA_CABEZA)
        Case eRaza.Elfo
            ValidHead = (HeadSeleccionada >= ELFO_H_PRIMER_CABEZA And HeadSeleccionada <= ELFO_H_ULTIMA_CABEZA)
        Case eRaza.Drow
            ValidHead = (HeadSeleccionada >= DROW_H_PRIMER_CABEZA And HeadSeleccionada <= DROW_H_ULTIMA_CABEZA)
        Case eRaza.Enano
            ValidHead = (HeadSeleccionada >= ENANO_H_PRIMER_CABEZA And HeadSeleccionada <= ENANO_H_ULTIMA_CABEZA)
        Case eRaza.Gnomo
            ValidHead = (HeadSeleccionada >= GNOMO_H_PRIMER_CABEZA And HeadSeleccionada <= GNOMO_H_ULTIMA_CABEZA)
        End Select

    Case Else
        Select Case UserRaza
        Case eRaza.Humano
            ValidHead = (HeadSeleccionada >= HUMANO_M_PRIMER_CABEZA And HeadSeleccionada <= HUMANO_M_ULTIMA_CABEZA)
        Case eRaza.Elfo
            ValidHead = (HeadSeleccionada >= ELFO_M_PRIMER_CABEZA And HeadSeleccionada <= ELFO_M_ULTIMA_CABEZA)
        Case eRaza.Drow
            ValidHead = (HeadSeleccionada >= DROW_M_PRIMER_CABEZA And HeadSeleccionada <= DROW_M_ULTIMA_CABEZA)
        Case eRaza.Enano
            ValidHead = (HeadSeleccionada >= ENANO_M_PRIMER_CABEZA And HeadSeleccionada <= ENANO_M_ULTIMA_CABEZA)
        Case eRaza.Gnomo
            ValidHead = (HeadSeleccionada >= GNOMO_M_PRIMER_CABEZA And HeadSeleccionada <= GNOMO_M_ULTIMA_CABEZA - 1)
        End Select
    End Select

End Function

Function isNombreValido(Nombre As String) As Boolean

    If AsciiValidos(Nombre) = False Then
        isNombreValido = False
        Exit Function
    End If

    If DobleEspacios(Nombre) = True Then
        isNombreValido = False
        Exit Function
    End If

    isNombreValido = True

End Function

Function DobleEspacios(UserName As String) As Boolean
    Dim Antes As Boolean
    Dim i As Integer
    For i = 1 To Len(UserName)
        If mid(UserName, i, 1) = " " Then
            If Antes = True Then
                DobleEspacios = True
                Exit Function
            Else
                Antes = True
            End If
        Else
            Antes = False
        End If
    Next
    DobleEspacios = False
End Function


Function AsciiValidos(ByVal cad As String) As Boolean
    Dim car As Byte
    Dim i As Long
    cad = LCase$(cad)
    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))
        If (car < 97 Or car > 122) And (car <> 255) And (car <> 32) Then
            AsciiValidos = False
            Exit Function
        End If
    Next i
    AsciiValidos = True
End Function

Function AsciiValidosEmail(ByVal cad As String) As Boolean
    Dim car As Byte
    Dim i As Long
    Dim valido As Boolean
    cad = LCase$(cad)
    valido = True
    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))
        If Not ((car >= 97 And car <= 122) Or (car >= 48 And car <= 57) Or car = 45 Or car = 46 Or car = 95 Or car = 64) Then
            valido = False
            Exit For
        End If
    Next i

    AsciiValidosEmail = valido
End Function


Function AlphanumericValidos(ByVal cad As String) As Boolean
    Dim car As Byte
    Dim i As Long
    cad = LCase$(cad)

    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))
        If (car < 65 Or car > 90) And (car < 97 Or car > 122) And (car < 48 Or car > 57) And (car <> 255) And (car <> 32) Then
            AlphanumericValidos = False
            Exit Function
        End If
    Next i

    AlphanumericValidos = True
End Function


Function AlphanumericTildeValidos(ByVal cad As String) As Boolean
    Dim car As Byte
    Dim i As Long
    cad = LCase$(cad)

    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))
        If (car < 65 Or car > 90) And (car < 97 Or car > 122) And (car < 48 Or car > 57) And (car <> 255) And (car <> 32) And (car < 192 Or car > 197) And (car < 199 Or car > 207) And (car < 209 Or car > 214) And (car < 217 Or car > 220) Then
            AlphanumericTildeValidos = False
            Exit Function
        End If
    Next i

    AlphanumericTildeValidos = True
End Function

Function Numeric(ByVal cad As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim car As Byte
    Dim i As Long

    cad = LCase$(cad)

    For i = 1 To Len(cad)
        car = Asc(mid$(cad, i, 1))

        If (car < 48 Or car > 57) Then
            Numeric = False
            Exit Function
        End If

    Next i

    Numeric = True

End Function


Function NombrePermitido(ByVal Nombre As String) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim i As Long

    For i = 1 To UBound(ForbidenNames)
        If InStr(Nombre, ForbidenNames(i)) Then
            NombrePermitido = False
            Exit Function
        End If
    Next i

    NombrePermitido = True

End Function

Function ValidateSkills(ByVal UserIndex As Integer) As Boolean
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    For LoopC = 1 To NUMSKILLS
        If UserList(UserIndex).Stats.UserSkills(LoopC) < 0 Then
            Exit Function
            If UserList(UserIndex).Stats.UserSkills(LoopC) > 100 Then UserList(UserIndex).Stats.UserSkills(LoopC) = 100
        End If
    Next LoopC

    ValidateSkills = True

End Function

Function ConnectNewUser(ByVal UserIndex As Integer, ByRef Name As String, ByRef Password As String, ByVal UserRaza As eRaza, ByVal UserSexo As eGenero, ByVal UserClase As eClass, _
                        ByRef UserEmail As String, ByVal Pin As String, ByVal Hogar As Byte, ByRef skillsasignados As String, ByRef CierraCionexion As Boolean, ByRef serialHD As Long) As Boolean

    Dim i As Long

    On Error GoTo Errhandler

    With UserList(UserIndex)

3       Name = Trim$(Name)
4       Password = Trim$(Password)
        UserEmail = Trim$(UserEmail)
        Pin = Trim$(Pin)

1       If Not AsciiValidos(Name) Or LenB(Name) = 0 Then
2           Call WriteErrorMsg(UserIndex, "Nombre invalido.")
            Exit Function
        End If

        'sanitización de las variables
        UserEmail = Trim$(Replace$(UserEmail, vbNewLine, vbNullString))
        UserEmail = LCase$(Trim$(Replace$(UserEmail, vbTab, vbNullString)))

        Name = Trim$(Replace$(Name, vbNewLine, vbNullString))
        Name = Trim$(Replace$(Name, vbTab, vbNullString))

        If Not AsciiValidosEmail(UserEmail) Then
            Call WriteErrorMsg(UserIndex, "El Email contiene caracteres invalidos.")
            Exit Function
        End If

        If Len(Name) > 15 Then
            Call WriteErrorMsg(UserIndex, "Nombre muy largo.")
            Exit Function
        End If
        If Len(Name) < 3 Then
            Call WriteErrorMsg(UserIndex, "Nombre muy corto.")
            Exit Function
        End If

        If Len(Password) > 40 Then
            Call WriteErrorMsg(UserIndex, "Contraseña muy larga.")
            Exit Function
        End If

        If Len(Password) < 4 Then
            Call WriteErrorMsg(UserIndex, "Contraseña muy corta.")
            Exit Function
        End If

        If Len(UserEmail) > 50 Then
            Call WriteErrorMsg(UserIndex, "Email muy largo.")
            Exit Function
        End If

        If Len(UserEmail) < 5 Then
            Call WriteErrorMsg(UserIndex, "Email muy corto.")
            Exit Function
        End If

5       If UserList(UserIndex).flags.UserLogged Then
6           Call LogCriticEvent("El usuario " & UserList(UserIndex).Name & " ha intentado crear a " & Name & " desde la IP " & UserList(UserIndex).IP)
7           Call CloseSocketSL(UserIndex)
8           Call Cerrar_Usuario(UserIndex)
            CierraCionexion = True
            Exit Function
        End If

        '¿Existe el personaje?
9       If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = True Then
10          Call WriteErrorMsg(UserIndex, "Ya existe el personaje.")
            'CierraCionexion = True
            Exit Function
        End If

        'Tiró los dados antes de llegar acá??
11      If .Stats.UserAtributos(eAtributos.Fuerza) = 0 Then

            If CONFIG_INI_RANDOMDICES = 1 Then
                .Stats.UserAtributos(eAtributos.Fuerza) = RandomNumber(16, 18)
                .Stats.UserAtributos(eAtributos.Agilidad) = RandomNumber(16, 18)
                .Stats.UserAtributos(eAtributos.Inteligencia) = RandomNumber(16, 18)
                .Stats.UserAtributos(eAtributos.Carisma) = RandomNumber(16, 18)
                .Stats.UserAtributos(eAtributos.Constitucion) = RandomNumber(16, 18)
            Else
                .Stats.UserAtributos(eAtributos.Fuerza) = 18
                .Stats.UserAtributos(eAtributos.Agilidad) = 18
                .Stats.UserAtributos(eAtributos.Inteligencia) = 18
                .Stats.UserAtributos(eAtributos.Carisma) = 18
                .Stats.UserAtributos(eAtributos.Constitucion) = 18
            End If

        End If

13      If UserClase <= 0 Or UserClase > NUMCLASES Then    'Clase valida
14          Call WriteErrorMsg(UserIndex, "Seleccioná una clase válida.")
            Exit Function
        End If

        If UserRaza <= 0 Or UserRaza > NUMRAZAS Then    'Raza valida
            Call WriteErrorMsg(UserIndex, "Seleccioná una raza válida.")
            CierraCionexion = True
            Exit Function
        End If

        If Hogar <= 0 Or Hogar > eCiudad.cArghal Then    'Hogar valido
            Call WriteErrorMsg(UserIndex, "Seleccioná un hogar válido.")
            CierraCionexion = True
            Exit Function
        End If

        If seguridad_clones_validar(UserList(UserIndex).IP) = False Then
            Call WriteErrorMsg(UserIndex, "Estás intentando crear muchos personajes, intente dentro de 5 minutos.")
            CierraCionexion = True
            Exit Function
        End If

15      For i = 1 To NUMSKILLS
            .Stats.UserSkills(i) = 0
16          Call CheckEluSkill(UserIndex, i, True)
        Next i

        Dim cant_skills() As String
        Dim assigned() As String
17      cant_skills = Split(skillsasignados, "|", NUMSKILLS)

18      If UBound(cant_skills()) = 0 Then
19          assigned = Split(skillsasignados, "-", 2)
20          If val(assigned(0)) < 1 Or val(assigned(0)) > NUMSKILLS Then
21              Call WriteErrorMsg(UserIndex, "Debe asignar los 10 skills iniciales antes de poder crear un personaje.")
                Exit Function
            End If

22          If val(assigned(1)) <> 10 Then
23              Call WriteErrorMsg(UserIndex, "Debe asignar los 10 skills iniciales antes de poder crear un personaje.")
                Exit Function
            End If

            ' @@asigno en X skill los 10 skills
24          .Stats.UserSkills(val(assigned(0))) = 10

        Else
            Dim tot As Long
25          tot = 0
            For i = 0 To UBound(cant_skills())
26              assigned = Split(cant_skills(i), "-", 2)
27              If val(assigned(0)) < 1 Or val(assigned(0)) > NUMSKILLS Then
28                  Call WriteErrorMsg(UserIndex, "Debe asignar los 10 skills iniciales antes de poder crear un personaje.")
                    Exit Function
                End If
29              tot = tot + val(assigned(1))
30              .Stats.UserSkills(val(assigned(0))) = val(assigned(1))
            Next i

31          If tot <> 10 Then
                Call WriteErrorMsg(UserIndex, "Debe asignar los 10 skills iniciales antes de poder crear un personaje.")
                Exit Function
            End If
        End If

        If UserSexo <> eGenero.Hombre Then
            UserSexo = eGenero.Mujer
        End If

        Dim Head As Integer
32      Head = DarCabeza(UserRaza, UserSexo)
33      If Head = 0 Then
34          Call LogCriticEvent("El usuario " & Name & " ha seleccionado la raza " & UserRaza & " y sexo " & UserSexo & " desde la IP " & .IP)
            Call WriteErrorMsg(UserIndex, "Sexo o raza inválida, se guardará log.")
            Exit Function
        End If


        ' @@ Permitimos sólo un worker??
        If CONFIG_INI_ALLOWMULTIWORKERS <> 0 Then
            Dim tmpTot As Byte
            For i = 1 To LastUser
                If UserList(i).IP = UserList(UserIndex).IP Then
                    tmpTot = tmpTot + 1
                End If
            Next i
            If tmpTot > CONFIG_INI_ALLOWMULTIWORKERS Then
                Call WriteErrorMsg(UserIndex, "Sólo se permite un máximo de " & CONFIG_INI_ALLOWMULTIWORKERS & " trabajadores conectados a tu misma IP.")
                Exit Function
            End If
        End If

        .flags.Muerto = 0
        .flags.Escondido = 0

        .faccion.Status = 0
        .Reputacion.AsesinoRep = 0
        .Reputacion.BandidoRep = 0
        .Reputacion.BurguesRep = 0
        .Reputacion.LadronesRep = 0
        .Reputacion.NobleRep = 1000
        .Reputacion.PlebeRep = 30

        .HD_Creator = serialHD

35      .Reputacion.Promedio = 30 / 6

36      .Name = Name
        .Clase = UserClase
        .raza = UserRaza
        .Genero = UserSexo
        .Email = UserEmail
        .Hogar = Hogar

        '[Pablo (Toxic Waste) 9/01/08]
        .Stats.UserAtributos(eAtributos.Fuerza) = .Stats.UserAtributos(eAtributos.Fuerza) + ModRaza(UserRaza).Fuerza
        .Stats.UserAtributos(eAtributos.Agilidad) = .Stats.UserAtributos(eAtributos.Agilidad) + ModRaza(UserRaza).Agilidad
        .Stats.UserAtributos(eAtributos.Inteligencia) = .Stats.UserAtributos(eAtributos.Inteligencia) + ModRaza(UserRaza).Inteligencia
        .Stats.UserAtributos(eAtributos.Carisma) = .Stats.UserAtributos(eAtributos.Carisma) + ModRaza(UserRaza).Carisma
        .Stats.UserAtributos(eAtributos.Constitucion) = .Stats.UserAtributos(eAtributos.Constitucion) + ModRaza(UserRaza).Constitucion
        '[/Pablo (Toxic Waste)]

        .Char.Heading = eHeading.SOUTH

37      Call DarCuerpo(UserIndex)
38      .Char.Head = Head

        .OrigChar = .Char

        Dim MiInt As Long
39      'MiInt = RandomNumber(1, .Stats.UserAtributos(eAtributos.Constitucion) \ 3)

40      .Stats.MaxHP = RandomNumber(19, 21)        ' 15 + MiInt
        .Stats.MinHP = .Stats.MaxHP

        MiInt = RandomNumber(1, .Stats.UserAtributos(eAtributos.Agilidad) \ 6)
        If MiInt = 1 Then MiInt = 2

        .Stats.MaxSta = 20 * MiInt
        .Stats.minSta = .Stats.MaxSta

        .Stats.MaxAGU = 100
        .Stats.MinAGU = 100

        .Stats.MaxHam = 100
        .Stats.MinHam = 100

        '<-----------------MANA----------------------->
        If UserClase = eClass.Mage Then        'Cambio en mana inicial (ToxicWaste)
            MiInt = RandomNumber(100, 105)
            .Stats.MaxMAN = MiInt
            .Stats.MinMAN = MiInt
        ElseIf UserClase = eClass.Cleric Or UserClase = eClass.Druid _
               Or UserClase = eClass.Bard Or UserClase = eClass.Assasin Then
            .Stats.MaxMAN = 50
            .Stats.MinMAN = 50
        Else
            .Stats.MaxMAN = 0
            .Stats.MinMAN = 0
        End If

        If UserClase = eClass.Mage Or UserClase = eClass.Cleric Or _
           UserClase = eClass.Druid Or UserClase = eClass.Bard Or _
           UserClase = eClass.Assasin Then
            .Stats.UserHechizos(1) = 2

            'If UserClase = eClass.Druid Then .Stats.UserHechizos(2) = 46
        End If

        .Stats.MaxHIT = 2
        .Stats.MinHIT = 1

        .Stats.Exp = 0
        .Stats.elu = 300
        .Stats.ELV = 1

        '???????????????? INVENTARIO ¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿¿
        Dim Slot As Byte
        Dim IsPaladin As Boolean

        IsPaladin = UserClase = eClass.Paladin

        'Pociones Rojas (Newbie)
        Slot = 1
        .Invent.Object(Slot).ObjIndex = 461
        .Invent.Object(Slot).Amount = 400

        'Pociones azules (Newbie)
        If .Stats.MaxMAN > 0 Or IsPaladin Then
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 462
            .Invent.Object(Slot).Amount = 400

        Else
            'Pociones amarillas (Newbie)
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 650
            .Invent.Object(Slot).Amount = 250

            'Pociones verdes (Newbie)
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 651
            .Invent.Object(Slot).Amount = 250

        End If

        ' Ropa (Newbie)
        ' Ropa normal
        Slot = Slot + 1
        Select Case UserRaza
        Case eRaza.Humano
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Elfo
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Drow
            .Invent.Object(Slot).ObjIndex = 463
        Case eRaza.Enano
            .Invent.Object(Slot).ObjIndex = 466
        Case eRaza.Gnomo
            .Invent.Object(Slot).ObjIndex = 466
        End Select

        ' Equipo ropa
        .Invent.Object(Slot).Amount = 1
        .Invent.Object(Slot).Equipped = 1

        .Invent.ArmourEqpSlot = Slot
        .Invent.ArmourEqpObjIndex = .Invent.Object(Slot).ObjIndex
        .Char.body = ObjData(.Invent.Object(Slot).ObjIndex).Ropaje

        'Arma (Newbie)
        Slot = Slot + 1
        Select Case UserClase
        Case eClass.Hunter
            ' Arco (Newbie)
            .Invent.Object(Slot).ObjIndex = 839
            ' Case eClass.Blacksmith, eClass.Carpenter, eClass.Fisherman, eClass.Miner, eClass.Woodcutter
            ' Herramienta (Newbie)
            '     .Invent.Object(Slot).ObjIndex = RandomNumber(562, 565)
        Case Else
            ' Daga (Newbie)
            .Invent.Object(Slot).ObjIndex = 460
        End Select

        ' Equipo arma
        .Invent.Object(Slot).Amount = 1
        .Invent.Object(Slot).Equipped = 1

        .Invent.WeaponEqpObjIndex = .Invent.Object(Slot).ObjIndex
        .Invent.WeaponEqpSlot = Slot

        .Char.WeaponAnim = GetWeaponAnim(UserIndex, .Invent.WeaponEqpObjIndex)

        ' Municiones (Newbie)
41      If UserClase = eClass.Hunter Then
            Slot = Slot + 1
            .Invent.Object(Slot).ObjIndex = 838
            .Invent.Object(Slot).Amount = 500

            ' Equipo flechas
            .Invent.Object(Slot).Equipped = 1
            .Invent.MunicionEqpSlot = Slot
            .Invent.MunicionEqpObjIndex = 838
        End If

        ' Manzanas (Newbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 467
        .Invent.Object(Slot).Amount = 100

        ' Jugos (Nwbie)
        Slot = Slot + 1
        .Invent.Object(Slot).ObjIndex = 468
        .Invent.Object(Slot).Amount = 100

        ' Sin casco y escudo
        .Char.ShieldAnim = NingunEscudo
        .Char.CascoAnim = NingunCasco

        .Stats.GLD = 0

        #If ConUpTime Then
            .LogOnTime = Now
            .UpTime = 0
        #End If

43      .Pin = Pin
        .Pass = Password

        .Stats.AsignoSkills = 10

    End With

    'Valores Default de facciones al Activar nuevo usuario
44  Call ResetFacciones(UserIndex)

45  Call WriteVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password", Password)
    Call WriteVar(CharPath & UCase$(Name) & ".chr", "INIT", "Pin", Pin)

46  Call SaveUser(UserIndex, CharPath & UCase$(Name) & ".chr")

    'Open User
47  Call ConnectUser(UserIndex, Name, Password, serialHD)

48  Call mod_DB.Update_DataBase_UserIndex(UserIndex, Pin, Password)

    ConnectNewUser = True

    Exit Function
Errhandler:
    Call LogError("TCP.ConnectNewUser en " & Erl & ". err: " & Err.Number & " " & Err.Description)
End Function

Sub CloseSocket(ByVal UserIndex As Integer)

    On Error GoTo Errhandler

    If frmMain.chkDebug.value = 1 Then
        Debug.Print Now, "CloseSocket: " & UserList(UserIndex).Name
    End If

6   If UserList(UserIndex).ConnIDValida Then
7       Call CloseSocketSL(UserIndex)
    End If

8   If Centinela.RevisandoUserIndex = UserIndex Then
9       Call modCentinela.CentinelaUserLogout
    End If

10  If UserList(UserIndex).PartyIndex > 0 Then
11      Call mod_Party.ExitParty(UserIndex)
    End If

12  If UserList(UserIndex).PartyRequest > 0 Then
13      Call mod_Party.ResetPartyRequest(UserIndex)
    End If

14  If UserList(UserIndex).flags.commerce_npc_npcindex > 0 Then
15      Call NPCs.RemoveToNpcTradingArray(UserIndex)
    End If

    If UserList(UserIndex).InBotID > 0 Then
        Call ChallengeBotsUserDisconnect(UserList(UserIndex).InBotID)
        Call WarpUserCharX(UserIndex, Ullathorpe.Map, Ullathorpe.X, Ullathorpe.Y)
        UserList(UserIndex).InBotID = 0
    End If


16  If UserList(UserIndex).flags.AdminInvisible = 1 Then Call DoAdminInvisible(UserIndex, False)

    'mato los comercios seguros
17  If UserList(UserIndex).ComUsu.DestUsu > 0 Then
18      If UserList(UserList(UserIndex).ComUsu.DestUsu).flags.UserLogged Then
19          If UserList(UserList(UserIndex).ComUsu.DestUsu).ComUsu.DestUsu = UserIndex Then
20              WriteMensajes UserList(UserIndex).ComUsu.DestUsu, e_Mensajes.Mensaje_129
21              Call FinComerciarUsu(UserList(UserIndex).ComUsu.DestUsu)
                'Call Flushbuffer(UserList(UserIndex).ComUsu.DestUsu)
            End If
        End If
    End If

    If UserList(UserIndex).flags.OwnedNpc > 0 Then
        Npclist(UserList(UserIndex).flags.OwnedNpc).Owner = 0
        Npclist(UserList(UserIndex).flags.OwnedNpc).flags.AttackedBy = ""
        Npclist(UserList(UserIndex).flags.OwnedNpc).flags.AttackedFirstBy = ""
    End If

    Dim TmpInt As Integer

    'Retos 1vs1,2vs2 y spectador
    If UserList(UserIndex).mReto.Reto_Index > 0 Then
        If UserList(UserIndex).mReto.ReturnHome < 1 Then
            Call DisconnectUserReto1vs1(UserIndex)
        Else
            Call AbandonUserReto1vs1(UserIndex, UserList(UserIndex).mReto.Reto_Index)
        End If
    Else
        TmpInt = UserList(UserIndex).mReto.IndexSender

        If TmpInt > 0 Then
            If UserList(TmpInt).mReto.IndexRecieve = UserIndex Then
                Call ResetOtherUser1vs1(TmpInt)
                Call WriteConsoleMsg(TmpInt, "La solicitud de reto 1vs1 de " & UserList(UserIndex).Name & " se ha cancelado por desconexion.", FontTypeNames.FONTTYPE_TALK)
            End If
        End If
    End If

    If UserList(UserIndex).sReto.Reto_Index > 0 Then
        If UserList(UserIndex).sReto.ReturnHome < 1 Then
            Call DisconnectUserReto2vs2(UserIndex)
        Else
            Call AbandonUserReto2vs2(UserIndex, UserList(UserIndex).sReto.Reto_Index)
        End If
    Else
        TmpInt = UserList(UserIndex).sReto.IndexSender

        If TmpInt > 0 Then
            Call ResetOtherUser2vs2(TmpInt)
        End If
    End If

26  If UserList(UserIndex).flags.EnEvento = 1 Then
        Call m_Torneo1vs1.Rondas_UsuarioDesconecta(UserIndex)
    ElseIf UserList(UserIndex).flags.EnEvento = 2 Then
        Call Desconexion2vs2(UserIndex)
    ElseIf UserList(UserIndex).flags.EnEvento = 3 Then
        Call m_TorneoDeath.DesconectaUser(UserIndex)
    ElseIf UserList(UserIndex).flags.EnEvento = 4 Then
        m_TorneoJDH.EventDisconnect (UserList(UserIndex).Slot_ID)
    ElseIf UserList(UserIndex).flags.EnEvento = 5 And UserList(UserIndex).XvsX.Slot_ID > 0 Then
        Call DisconnectXvsX(UserIndex)
    ElseIf UserList(UserIndex).InCVCID Then
        Call cvcManager.HandleDisconnect(UserIndex)
    End If

31  If UserList(UserIndex).Pos.Map = TORNEO_Drop.Map Then Call WarpUserCharX(UserIndex, 1, 50, 50, False)

    If UserList(UserIndex).Pos.Map Then
37      If MapInfo(UserList(UserIndex).Pos.Map).WarpOnDisconnect.Map Then
38          Call WarpUserCharX(UserIndex, MapInfo(UserList(UserIndex).Pos.Map).WarpOnDisconnect.Map, MapInfo(UserList(UserIndex).Pos.Map).WarpOnDisconnect.X, MapInfo(UserList(UserIndex).Pos.Map).WarpOnDisconnect.Y, False)
        End If
    End If

    If UserList(UserIndex).flags.UserLogged Then

        If NumUsers > 0 Then NumUsers = NumUsers - 1
        If NumUsers > 100 Then
            ActivarGlobal
        End If

39      Call CloseUser(UserIndex)

        'Call EstadisticasWeb.Informar(CANTIDAD_ONLINE, NumUsers)

    Else
40      Call ResetUserSlot(UserIndex)
    End If

    Call Freeslot(UserIndex)

    Exit Sub

Errhandler:

    UserList(UserIndex).ConnIDValida = False
    UserList(UserIndex).ConnID = -1
    
    Call ResetUserSlot(UserIndex)
    Call Freeslot(UserIndex)
    Call LogError("CloseSocket - Error = " & Err.Number & " - Descripción = " & Err.Description & " - UserIndex = " & UserIndex)

End Sub

Sub CloseSocketSL(ByVal UserIndex As Integer)

    If UserList(UserIndex).ConnIDValida Then
        Call UserList(UserIndex).Connection.Close(False)
        UserList(UserIndex).ConnIDValida = False
    End If

End Sub

Function EstaPCarea(Index As Integer, Index2 As Integer) As Boolean
    Dim X As Integer, Y As Integer
    For Y = UserList(Index).Pos.Y - MinYBorder + 1 To UserList(Index).Pos.Y + MinYBorder - 1
        For X = UserList(Index).Pos.X - MinXBorder + 1 To UserList(Index).Pos.X + MinXBorder - 1

            If MapData(UserList(Index).Pos.Map, X, Y).UserIndex = Index2 Then
                EstaPCarea = True
                Exit Function
            End If

        Next X
    Next Y
    EstaPCarea = False
End Function

Function HayPCarea(Pos As WorldPos) As Boolean
    Dim X As Integer, Y As Integer
    For Y = Pos.Y - MinYBorder + 1 To Pos.Y + MinYBorder - 1
        For X = Pos.X - MinXBorder + 1 To Pos.X + MinXBorder - 1
            If X > 0 And Y > 0 And X < 101 And Y < 101 Then
                If MapData(Pos.Map, X, Y).UserIndex > 0 Then
                    HayPCarea = True
                    Exit Function
                End If
            End If
        Next X
    Next Y
    HayPCarea = False
End Function

Function HayOBJarea(Pos As WorldPos, ObjIndex As Integer) As Boolean
    Dim X As Integer, Y As Integer
    For Y = Pos.Y - MinYBorder + 1 To Pos.Y + MinYBorder - 1
        For X = Pos.X - MinXBorder + 1 To Pos.X + MinXBorder - 1
            If MapData(Pos.Map, X, Y).ObjInfo.ObjIndex = ObjIndex Then
                HayOBJarea = True
                Exit Function
            End If

        Next X
    Next Y
    HayOBJarea = False
End Function
Function ValidateChr(ByVal UserIndex As Integer) As Boolean
    ValidateChr = UserList(UserIndex).Char.Head <> 0 And UserList(UserIndex).Char.body <> 0 And ValidateSkills(UserIndex)
End Function

Function ConnectUser(ByVal UserIndex As Integer, ByRef Name As String, ByRef Password As String, ByRef serialHD As Long)
    Dim tStr As String
        
    On Error GoTo Errhandler

1   With UserList(UserIndex)

2       If .flags.UserLogged Then
            Call LogCriticEvent("El usuario " & .Name & " ha intentado loguear a " & Name & " desde la IP " & .IP)
            'Kick player ( and leave character inside :D )!
4           Call CloseSocketSL(UserIndex)
5           Call Cerrar_Usuario(UserIndex)
            Exit Function
        End If

        'Reseteamos los FLAGS
6       .flags.Escondido = 0
        .flags.TargetNPC = 0
        .flags.TargetNpcTipo = eNPCType.Comun
        .flags.TargetObj = 0
        .flags.TargetUser = 0
        .flags.TargetGuildIndex = 0
        .Char.FX = 0
        .flags.serialHD = serialHD
        .flags.MenuCliente = eVentanas.vInventario
314     .flags.LastSlotClient = 255
        .flags.LastSlotPotion = 0

        .Counters.CooldownCentinela = RandomNumber(60 * 1, 60 * 3)

        .flags.GlobalOn = True

        'Controlamos no pasar el maximo de usuarios
        If NumUsers >= maxUsers Then
            Call WriteErrorMsg(UserIndex, "El servidor ha alcanzado el máximo de usuarios soportado, por favor vuelva a intertarlo más tarde.")
            'Call Flushbuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If

        '¿Este IP ya esta conectado?
36      If AllowMultiLogins = 0 Then
37          If .IP <> "127.0.0.1" Then
38              If Not CheckMaxClients(UserIndex, Name) Then
                    Call CloseSocket(UserIndex)
                    Exit Function
                End If
            End If
        End If

        '¿Este IP ya esta conectado?
        If AllowMultiLogins = 0 Then
            If CheckForSameIP(UserIndex, .IP) = True Then
                Call WriteErrorMsg(UserIndex, "No es posible usar más de un personaje al mismo tiempo.")
                Call CloseSocket(UserIndex)
                Exit Function
            End If
        End If

        '¿Existe el personaje?
        If Not PersonajeExiste(Name) Then
            Call WriteErrorMsg(UserIndex, "El personaje no existe.")
            'Call Flushbuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If

        '¿Es el passwd valido?
        If Password <> GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password") Then
            Call WriteErrorMsg(UserIndex, "Password incorrecto.")
            'Call Flushbuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If

        '¿Ya esta conectado el personaje?
7       If CheckForSameName(Name) Then
8           If UserList(NameIndex(Name)).Counters.Saliendo Then
9               Call WriteErrorMsg(UserIndex, "El usuario está saliendo.")
            Else
10              Call WriteErrorMsg(UserIndex, "Perdón, un usuario con el mismo nombre se ha logueado.")
            End If
            'Call Flushbuffer(UserIndex)
            Call CloseSocket(UserIndex)
            Exit Function
        End If

        'Reseteamos los privilegios
        .flags.Privilegios = 0

        'Vemos que clase de user es (se lo usa para setear los privilegios al loguear el PJ)
        If EsAdmin(Name) Then
            .flags.Privilegios = PlayerType.Admin
            Call LogGM(Name, "Se conecto con ip:" & .IP)
        ElseIf EsDios(Name) Then
            .flags.Privilegios = PlayerType.Dios
            Call LogGM(Name, "Se conecto con ip:" & .IP)
        ElseIf EsSemiDios(Name) Then
            .flags.Privilegios = PlayerType.SemiDios
            Call LogGM(Name, "Se conecto con ip:" & .IP)
        ElseIf EsConsejero(Name) Then
            .flags.Privilegios = PlayerType.Consejero
            Call LogGM(Name, "Se conecto con ip:" & .IP)
        Else
            .flags.Privilegios = PlayerType.User
            .flags.AdminPerseguible = True
        End If

        'Add RM flag if needed
11      If EsRolesMaster(Name) Then
12          .flags.Privilegios = PlayerType.RoleMaster
        End If

13      If ServerSoloGMs > 0 Then
            If .flags.Privilegios < PlayerType.Consejero Then
                Call WriteErrorMsg(UserIndex, "Servidor restringido a administradores. Por favor reintente en unos momentos.")
                'Call Flushbuffer(UserIndex)
                Call CloseSocket(UserIndex)
                Exit Function
            End If
        End If

        'Cargamos el personaje
        Dim Leer As New clsIniManager
        Dim LoopC As Long

14      Call Leer.Initialize(CharPath & UCase$(Name) & ".chr")

        .StaticHD(1) = val(Leer.GetValue("INIT", "StaticHD1"))

        If .StaticHD(1) > 0 Then

            If .flags.serialHD <> .StaticHD(1) Then

                Dim CanLogged As Boolean

                For LoopC = 2 To 5
                    .StaticHD(LoopC) = val(Leer.GetValue("INIT", "StaticHD" & LoopC))

                    If .StaticHD(LoopC) > 0 Then
                        If .flags.serialHD = .StaticHD(LoopC) Then
                            CanLogged = True
                            Exit For
                        End If
                    End If
                Next LoopC

                If Not CanLogged Then
                    Call WriteErrorMsg(UserIndex, "Personaje protegido.")
                    Call LogProtegidos("HD: " & .flags.serialHD & " intenta logear a " & Name & ". " & .IP)
                    Call CloseSocket(UserIndex)
                End If

            End If

        End If

        'Cargamos los datos del personaje
115     Call LoadUserInit(UserIndex, Leer)

15      Call LoadUserStats(UserIndex, Leer)
        Call LoadQuestStats(UserIndex, Leer)

16      If Not ValidateChr(UserIndex) Then
17          Call WriteErrorMsg(UserIndex, "Error en el personaje.")
            Call CloseSocket(UserIndex)
            Exit Function
        End If

18      Call LoadUserReputacion(UserIndex, Leer)

        Call LoadUserAntiFrags(UserIndex, Leer)


        Dim p As Long
        Dim c As Long
        For p = 1 To NUMSKILLS
            c = c + UserList(UserIndex).Stats.UserSkills(p)
        Next p
        .Stats.AsignoSkills = c


        .HD_Check = val(GetVar(CharPath & UCase$(Name) & ".chr", "ACCOUNT", "HD_Check"))


        If .HD_Check Then
            .HD_Creator = CLng(GetVar(CharPath & UCase$(Name) & ".chr", "ACCOUNT", "HD_Creator"))
            If .HD_Creator <> serialHD Then

                If GetVar(CharPath & UCase$(Name) & ".chr", "ACCOUNT", "LOGINFAILED") > 2 Then
                    Call WriteErrorMsg(UserIndex, "Has superado el limite de 3 intentos fallidos.")
                    Call CloseSocket(UserIndex)
                    Exit Function
                End If

                If CLng(GetVar(CharPath & UCase$(Name) & ".chr", "ACCOUNT", "HD_Last")) <> serialHD Then
                    .HD_TmpName = Name
                    'Call WriteAskPin(userindex)
                    Exit Function
                End If
            End If
        End If

        .HD_Last = serialHD


        Set Leer = Nothing

        If .Invent.EscudoEqpSlot = 0 Then .Char.ShieldAnim = NingunEscudo
        If .Invent.CascoEqpSlot = 0 Then .Char.CascoAnim = NingunCasco
        If .Invent.WeaponEqpSlot = 0 Then .Char.WeaponAnim = NingunArma

        If .Clase = eClass.Pirat Or EsGM(UserIndex) Then
19          .CurrentInventorySlots = MAX_INVENTORY_SLOTS
            Call WriteAddSlots(UserIndex)

        Else
20          .CurrentInventorySlots = MAX_NORMAL_INVENTORY_SLOTS
        End If

        '      If (.flags.Muerto = 0) Then
        '          .flags.SeguroResu = False
        '          Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOff)        'Call WriteResuscitationSafeOff(UserIndex)
        '      Else
        '          .flags.SeguroResu = True
        '          Call WriteMultiMessage(UserIndex, eMessages.ResuscitationSafeOn)        'Call WriteResuscitationSafeOn(UserIndex)
        '      End If

21      Call UpdateUserInv(True, UserIndex, 0)
22      Call UpdateUserHechizos(True, UserIndex, 0)

        If .flags.Paralizado Then
            Call WriteParalizeOK(UserIndex)
        End If

        ''
        'TODO : Feo, esto tiene que ser parche cliente
        If .flags.Estupidez = 0 Then
            Call WriteDumbNoMore(UserIndex)
        End If

        'Posicion de comienzo
        If .Pos.Map = 0 Then
            Select Case .Hogar
            Case eCiudad.cNix
                .Pos = Nix
            Case eCiudad.cUllathorpe
                .Pos = Ullathorpe
            Case eCiudad.cBanderbill
                .Pos = Banderbill
            Case eCiudad.cLindos
                .Pos = Lindos
            Case eCiudad.cArghal
                .Pos = Arghal
            Case Else
66              Call LogEditPacket(.Name & " .Hogar = " & .Hogar)
67              .Hogar = eCiudad.cUllathorpe
                .Pos = Ullathorpe
            End Select
        Else
68          If Not MapaValido(.Pos.Map) Then
69              Call WriteErrorMsg(UserIndex, "El PJ se encuenta en un mapa inválido.")
                Call LogError(.Name & " logueó en pos invalida: " & .Pos.Map & "-" & .Pos.X & "-" & .Pos.Y)
                'Call Flushbuffer(UserIndex)
                Call CloseSocket(UserIndex)
                Exit Function
            End If
        End If

        'Tratamos de evitar en lo posible el "Telefrag". Solo 1 intento de loguear en pos adjacentes.
        'Codigo por Pablo (ToxicWaste) y revisado por Nacho (Integer), corregido para que realmetne ande y no tire el server por Juan Martín Sotuyo Dodero (Maraxus)
        If MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex <> 0 Or MapData(.Pos.Map, .Pos.X, .Pos.Y).NpcIndex <> 0 Then
            Dim FoundPlace As Boolean
            Dim esAgua As Boolean
            Dim tX As Long
            Dim tY As Long

            FoundPlace = False
            esAgua = HayAgua(.Pos.Map, .Pos.X, .Pos.Y)

70          For tY = .Pos.Y - 1 To .Pos.Y + 1
                For tX = .Pos.X - 1 To .Pos.X + 1
                    If esAgua Then
                        'reviso que sea pos legal en agua, que no haya User ni NPC para poder loguear.
                        If LegalPos(.Pos.Map, tX, tY, True, False) Then
                            FoundPlace = True
                            Exit For
                        End If
                    Else
                        'reviso que sea pos legal en tierra, que no haya User ni NPC para poder loguear.
                        If LegalPos(.Pos.Map, tX, tY, False, True) Then
                            FoundPlace = True
                            Exit For
                        End If
                    End If
                Next tX

                If FoundPlace Then _
                   Exit For
            Next tY

71          If FoundPlace Then        'Si encontramos un lugar, listo, nos quedamos ahi
                .Pos.X = tX
                .Pos.Y = tY
            Else
                'Si no encontramos un lugar, sacamos al usuario que tenemos abajo, y si es un NPC, lo pisamos.
72              If MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex <> 0 Then
                    'Si no encontramos lugar, y abajo teniamos a un usuario, lo pisamos y cerramos su comercio seguro
73                  If UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu > 0 Then
                        'Le avisamos al que estaba comerciando que se tuvo que ir.
74                      If UserList(UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu).flags.UserLogged Then
75                          Call FinComerciarUsu(UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu)
76                          Call WriteConsoleMsg(UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu, "Comercio cancelado. El otro usuario se ha desconectado.", FontTypeNames.FONTTYPE_TALK)
77                          'Call Flushbuffer(UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).ComUsu.DestUsu)
                        End If
                        'Lo sacamos.
78                      If UserList(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex).flags.UserLogged Then
79                          Call FinComerciarUsu(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex)
80                          Call WriteErrorMsg(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex, "Alguien se ha conectado donde te encontrabas, por favor reconéctate...")
81                          'Call Flushbuffer(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex)
                        End If
                    End If

82                  Call CloseSocket(MapData(.Pos.Map, .Pos.X, .Pos.Y).UserIndex)
                End If
            End If
        End If

        'Nombre de sistema
83      .Name = Name

        .showName = True        'Por default los nombres son visibles

        'If in the water, and has a boat, equip it!
        If Not .flags.Privilegios >= PlayerType.RoleMaster Then

84          If .Invent.BarcoObjIndex > 0 And (HayAgua(.Pos.Map, .Pos.X, .Pos.Y) Or BodyIsBoat(.Char.body)) Then
                .Char.Head = 0
                If .flags.Muerto = 0 Then
85                  Call ToogleBoatBody(UserIndex)
                Else
                    .Char.body = iFragataFantasmal
                    .Char.ShieldAnim = NingunEscudo
                    .Char.WeaponAnim = NingunArma
                    .Char.CascoAnim = NingunCasco
                End If
                .flags.Navegando = 1
            End If

        End If

        ' ¿Esta navegando?
186     If .flags.Navegando = 1 Then
187         Call WriteNavigateToggle(UserIndex)
        End If


        'Info
86      Call WriteUserIndexInServer(UserIndex)        'Enviamos el User index
887     Call WriteChangeMap(UserIndex, .Pos.Map)        ', MapInfo(.Pos.map).MapVersion  , MapInfo(.Pos.map).Name)

        If Not val(ReadField(1, MapInfo(.Pos.Map).music, 45)) = 0 Then
87          Call WritePlayMidi(UserIndex, val(ReadField(1, MapInfo(.Pos.Map).music, 45)))
        End If

        .flags.ChatColor = vbWhite

        If Not EsGM(UserIndex) Then
            If .faccion.Status = FaccionType.RoyalCouncil Then
                .flags.ChatColor = RGB(0, 255, 255)
            ElseIf .faccion.Status = FaccionType.ChaosCouncil Then
                .flags.ChatColor = RGB(244, 70, 50)
            End If
        End If

        #If ConUpTime Then
            .LogOnTime = Now
        #End If

        'Crea  el personaje del usuario
89      Call MakeUserChar(True, .Pos.Map, UserIndex, .Pos.Map, .Pos.X, .Pos.Y)

92      Call WriteUserCharIndexInServer(UserIndex)

9100    If EsGM(UserIndex) Then
90          Call DoAdminInvisible(UserIndex)
91          'Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageCharacterChange(0, 0, .Char.Heading, .Char.CharIndex, 0, 0, 0, 0, 0))
        End If

93      Call DoTileEvents(UserIndex, .Pos.Map, .Pos.X, .Pos.Y)

94      Call CheckUserLevel(UserIndex)
95      Call WriteUpdateUserStats(UserIndex)

96      Call WriteUpdateHungerAndThirst(UserIndex)
97      Call WriteUpdateStrenghtAndDexterity(UserIndex)

98      If haciendoBK Then
99          Call WritePauseToggle(UserIndex)
            WriteMensajes UserIndex, e_Mensajes.Mensaje_52
        End If

        If EnPausa Then
            Call WritePauseToggle(UserIndex)
            WriteMensajes UserIndex, e_Mensajes.Mensaje_53
        End If

        NumUsers = NumUsers + 1

        If NumUsers > 100 Then
            DesctivarGlobal
        End If

        .flags.UserLogged = True

        'Call EstadisticasWeb.Informar(CANTIDAD_ONLINE, NumUsers)

102     MapInfo(.Pos.Map).NumUsers = MapInfo(.Pos.Map).NumUsers + 1

104     Call GenerateOnlineString

105     If OnlineNum > RecordUsuarios Then
106         Call SendData(SendTarget.ToAll, 0, PrepareMessageConsoleMsg("Record de usuarios conectados simultaneamente." & "Hay " & NumUsers & " usuarios.", FontTypeNames.FONTTYPE_INFO))
            RecordUsuarios = NumUsers
            Call WriteVar(IniPath & "Server.ini", "INIT", "Record", Str(RecordUsuarios))

        End If

        ' ToDo
        Call WriteConsoleMsg(UserIndex, "TDS Legacy:", FontTypeNames.FONTTYPE_INFO)
        Call WriteConsoleMsg(UserIndex, "Para activar el chat global escriba /activar. Y para hablar escribi " & Chr(34) & ".hola" & Chr(34), FontTypeNames.FONTTYPE_GUILD)
        Call WriteConsoleMsg(UserIndex, "Por favor, cuidá tu vocabulario por el chat general y chat global, evita ser penalizado. Saludos viajero!", FontTypeNames.FONTTYPE_GUILD)


109     If criminal(UserIndex) Then
            Call WriteMultiMessage(UserIndex, eMessages.SafeModeOff)        'Call WriteSafeModeOff(UserIndex)
            .flags.Seguro = False
        Else
            .flags.Seguro = True
            Call WriteMultiMessage(UserIndex, eMessages.SafeModeOn)        'Call WriteSafeModeOn(UserIndex)
        End If

        If .GuildIndex > 0 Then
            'welcome to the show baby...
111         If Not modGuilds.m_ConectarMiembroAClan(UserIndex, .GuildIndex) Then
112             Call WriteMensajes(UserIndex, Mensaje_406)
            End If
        End If

        Call WriteIntervalos(UserIndex)    'ACA NO PASA

113     Call modGuilds.SendGuildNews(UserIndex)

114     Call WriteUpdateEnvenenado(UserIndex)

        ' Esta protegido del ataque de npcs por 5 segundos, si no realiza ninguna accion
1616    Call IntervaloPermiteSerAtacado(UserIndex, True)

116     Call WriteLoggedMessage(UserIndex)

        If .Stats.SkillPts > 0 Then
117         Call WriteSendSkills(UserIndex)
        End If

118     Call WriteLevelUp(UserIndex, .Stats.SkillPts)

119     Call WriteUpdateFaccion(UserIndex)

120     CheckRankingUser UserIndex, TopNivel
121     CheckRankingUser UserIndex, TopRetos

        If .flags.BlockDragItems = False Then
110         Call WriteMultiMessage(UserIndex, eMessages.SafeDragModeOff)
        End If

        'Dim tmpGuerra As String
        'if .guildindex > 0 then
        '   modGuilds.SendGuildWarList userindex
        'end if

        'Load the user statistics
123     Call Statistics.UserConnected(UserIndex)

124     Call MostrarNumUsers

125     tStr = modGuilds.a_ObtenerRechazoDeChar(.Name)

        If LenB(tStr) <> 0 Then
126         Call WriteShowMessageBox(UserIndex, "Tu solicitud de ingreso al clan ha sido rechazada. Motivo:" & vbCrLf & tStr)
        End If

        Call SendData(SendTarget.ToIndex, UserIndex, PrepareMessageRainToggle(Lloviendo And Not MapInfo(.Pos.Map).Terreno = "DUNGEON" And Not MapInfo(.Pos.Map).Zona = "EVENTOS" And Not MapInfo(.Pos.Map).Terreno = "RETOS" And Not MapInfo(.Pos.Map).Zona = "RETOS" And Not MapInfo(.Pos.Map).Zona = "DUNGEON"))

        'Call WriteBonifStatus(UserIndex)

128     Call Update_DataBase_UserIndex(UserIndex, .Pin, .Pass)
        'usado para borrar Pjs
100     Call WriteVar(CharPath & .Name & ".chr", "INIT", "Logged", "1")

        ' @@ Efecto nick
        Call WriteSetEfectoNick(UserIndex, CONFIG_INI_ESTRELLAENNICK)

        If .flags.AdminInvisible = 0 Then
        
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(.Char.CharIndex, FXIDs.FXWARP, 0))
            Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessagePlayWave(SND_WARP, .Pos.X, .Pos.Y))

        End If

        If EsNewbie(UserIndex) And CONFIG_INI_SHOWRESETMESSAGE = 1 Then
            If Not val(GetVar(IniPath & "server.ini", "INIT", "ResetearPersonajes")) = 0 Then
                Dim limite As Byte
                limite = val(GetVar(IniPath & "server.ini", "INIT", "ResetearPersonajes_NivelMax"))

                If limite = 0 Then limite = 13

                Call WriteConsoleMsg(UserIndex, "Recuerda que puedes resetear tu personaje hasta el nivel " & limite & " en el NPC que se encuentra en Ullathorpe.", FontTypeNames.FONTTYPE_GUILD)

            End If
        End If

    End With

    Exit Function
Errhandler:
    Call LogError("error en ConnectUser en " & Erl & ". Err " & Err.Number & " " & Err.Description)
130 Call WriteShowMessageBox(UserIndex, "El personaje contiene un error. Comuníquese con un miembro del staff.")
135 Call CloseSocket(UserIndex)

End Function

Sub ResetFacciones(ByVal UserIndex As Integer)

    UserList(UserIndex).faccion.ArmadaReal = 0
    UserList(UserIndex).faccion.CiudadanosMatados = 0
    UserList(UserIndex).faccion.CriminalesMatados = 0
    UserList(UserIndex).faccion.FuerzasCaos = 0
    UserList(UserIndex).faccion.FechaIngreso = "No ingresó a ninguna Facción"
    UserList(UserIndex).faccion.RecibioArmaduraCaos = 0
    UserList(UserIndex).faccion.RecibioArmaduraReal = 0
    UserList(UserIndex).faccion.RecibioExpInicialCaos = 0
    UserList(UserIndex).faccion.RecibioExpInicialReal = 0
    UserList(UserIndex).faccion.RecompensasCaos = 0
    UserList(UserIndex).faccion.RecompensasReal = 0
    UserList(UserIndex).faccion.Reenlistadas = 0
    UserList(UserIndex).faccion.NivelIngreso = 0
    UserList(UserIndex).faccion.MatadosIngreso = 0

End Sub

Sub ResetContadores(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknown
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'05/20/2007 Integer - Agregue todas las variables que faltaban.
'*************************************************

    UserList(UserIndex).Counters.AGUACounter = 0

    UserList(UserIndex).Counters.failedUsageAttempts = 0
    UserList(UserIndex).Counters.LastPoteo = 0

    UserList(UserIndex).Counters.AttackCounter = 0
    UserList(UserIndex).Counters.Ceguera = 0
    UserList(UserIndex).Counters.COMCounter = 0
    UserList(UserIndex).Counters.Estupidez = 0
    UserList(UserIndex).Counters.Frio = 0
    UserList(UserIndex).Counters.HPCounter = 0
    UserList(UserIndex).Counters.IdleCount = 0
    UserList(UserIndex).Counters.Invisibilidad = 0
    UserList(UserIndex).Counters.Paralisis = 0
    UserList(UserIndex).Counters.Pena = 0
    UserList(UserIndex).Counters.PiqueteC = 0
    UserList(UserIndex).Counters.tBonif = 0
    UserList(UserIndex).Counters.LeveleandoTick = 0
    UserList(UserIndex).Counters.STACounter = 0
    UserList(UserIndex).Counters.Veneno = 0
    UserList(UserIndex).Counters.Trabajando = 0
    UserList(UserIndex).Counters.Ocultando = 0

    UserList(UserIndex).Counters.TimeLastReset = 0
    UserList(UserIndex).Counters.PacketCount = 0
148 UserList(UserIndex).Counters.TimerMagiaGolpe = 0
150 UserList(UserIndex).Counters.TimerGolpeMagia = 0
152 UserList(UserIndex).Counters.TimerLanzarSpell = 0
154 UserList(UserIndex).Counters.TimerPuedeAtacar = 0
156 UserList(UserIndex).Counters.TimerPuedeUsarArco = 0
158 UserList(UserIndex).Counters.TimerPuedeTrabajar = 0
160 UserList(UserIndex).Counters.TimerUsar = 0
161 UserList(UserIndex).Counters.TimerUsarClick = 0


    UserList(UserIndex).Counters.bPuedeMeditar = False
    UserList(UserIndex).Counters.Lava = 0
    UserList(UserIndex).Counters.Mimetismo = 0
    UserList(UserIndex).Counters.Saliendo = False
    UserList(UserIndex).Counters.ForceDeslog = 0

    UserList(UserIndex).Counters.Salir = 0
    UserList(UserIndex).Counters.TiempoOculto = 0
    UserList(UserIndex).Counters.ultimoIntentoOcultar = 0
    UserList(UserIndex).Counters.TimerMagiaGolpe = 0
    UserList(UserIndex).Counters.TimerGolpeMagia = 0
    UserList(UserIndex).Counters.TimerLanzarSpell = 0
    UserList(UserIndex).Counters.TimerPuedeAtacar = 0
    UserList(UserIndex).Counters.TimerPuedeUsarArco = 0
    UserList(UserIndex).Counters.TimerPuedeTrabajar = 0
    UserList(UserIndex).Counters.TimerUsar = 0
    UserList(UserIndex).Counters.goHome = 0
    UserList(UserIndex).Counters.CooldownCentinela = 0
    UserList(UserIndex).Counters.AsignedSkills = 0

End Sub

Sub ResetCharInfo(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknown
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'*************************************************

    UserList(UserIndex).Char.body = 0
    UserList(UserIndex).Char.CascoAnim = 0
    UserList(UserIndex).Char.CharIndex = 0
    UserList(UserIndex).Char.FX = 0
    UserList(UserIndex).Char.Head = 0
    UserList(UserIndex).Char.loops = 0
    UserList(UserIndex).Char.Heading = 0
    UserList(UserIndex).Char.loops = 0
    UserList(UserIndex).Char.ShieldAnim = 0
    UserList(UserIndex).Char.WeaponAnim = 0

End Sub

Sub ResetBasicUserInfo(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknown
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'*************************************************


    UserList(UserIndex).CountDetectionErr = 0
    UserList(UserIndex).ErrSpell = 0
    UserList(UserIndex).CantErr = 0

    UserList(UserIndex).InBotID = 0

    UserList(UserIndex).LastHechiSelected = 0

    UserList(UserIndex).mLastKeyUseItem = 0
    UserList(UserIndex).mLastKeyDrop = 0

    UserList(UserIndex).IsFull_MANA = 0
    UserList(UserIndex).CountAutoBlues = 0

    UserList(UserIndex).IsFull_HP = 0
    UserList(UserIndex).CountAutoRed = 0

    UserList(UserIndex).StaticHD(1) = 0
    UserList(UserIndex).StaticHD(2) = 0
    UserList(UserIndex).StaticHD(3) = 0
    UserList(UserIndex).StaticHD(4) = 0
    UserList(UserIndex).StaticHD(5) = 0
    UserList(UserIndex).HD_Check = 0
    UserList(UserIndex).HD_Creator = 0
    UserList(UserIndex).HD_Last = 0
    UserList(UserIndex).HD_TmpName = vbNullString

    UserList(UserIndex).DelayBuy = 0
    UserList(UserIndex).Account = vbNullString

    UserList(UserIndex).Pass = vbNullString
    UserList(UserIndex).Pin = vbNullString
    UserList(UserIndex).LastHP = 0
    UserList(UserIndex).LastMAN = 0
    UserList(UserIndex).LastSTA = 0
    UserList(UserIndex).LastGLD = 0
    UserList(UserIndex).LastEXP = 0

    UserList(UserIndex).Name = vbNullString
    UserList(UserIndex).Desc = vbNullString
    UserList(UserIndex).DescRM = vbNullString
    UserList(UserIndex).Pos.Map = 0
    UserList(UserIndex).Pos.X = 0
    UserList(UserIndex).Pos.Y = 0
    UserList(UserIndex).IP = vbNullString
    UserList(UserIndex).Clase = 0
    UserList(UserIndex).Email = vbNullString
    UserList(UserIndex).Genero = 0
    UserList(UserIndex).Hogar = 0
    UserList(UserIndex).raza = 0

    UserList(UserIndex).PartyIndex = 0

    UserList(UserIndex).Stats.Banco = 0
    UserList(UserIndex).Stats.ELV = 0
    UserList(UserIndex).Stats.elu = 0
    UserList(UserIndex).Stats.Exp = 0
    UserList(UserIndex).Stats.def = 0
    UserList(UserIndex).Stats.NPCsMuertos = 0
    UserList(UserIndex).Stats.UsuariosMatados = 0
    UserList(UserIndex).Stats.SkillPts = 0
    UserList(UserIndex).Stats.GLD = 0
    UserList(UserIndex).Stats.UserAtributos(1) = 0
    UserList(UserIndex).Stats.UserAtributos(2) = 0
    UserList(UserIndex).Stats.UserAtributos(3) = 0
    UserList(UserIndex).Stats.UserAtributos(4) = 0
    UserList(UserIndex).Stats.UserAtributos(5) = 0
    UserList(UserIndex).Stats.UserAtributosBackUP(1) = 0
    UserList(UserIndex).Stats.UserAtributosBackUP(2) = 0
    UserList(UserIndex).Stats.UserAtributosBackUP(3) = 0
    UserList(UserIndex).Stats.UserAtributosBackUP(4) = 0
    UserList(UserIndex).Stats.UserAtributosBackUP(5) = 0


    UserList(UserIndex).Stats.OroGanado = 0
    UserList(UserIndex).Stats.OroPerdido = 0
    UserList(UserIndex).Stats.RetosGanados = 0
    UserList(UserIndex).Stats.RetosPerdidos = 0
    UserList(UserIndex).Stats.CriminalesMatados = 0
    UserList(UserIndex).Stats.ParticipoClanes = 0
    UserList(UserIndex).Stats.DisolvioClan = 0
    UserList(UserIndex).Stats.FundoClan = 0
    UserList(UserIndex).Stats.PuntosFotodenuncia = 0
    UserList(UserIndex).Stats.UsuariosMatados = 0

    Dim i As Long
    For i = 1 To NUMSKILLS
        UserList(UserIndex).Stats.UserSkills(i) = 0
        UserList(UserIndex).Stats.EluSkills(i) = 0
    Next i

End Sub

Sub ResetReputacion(ByVal UserIndex As Integer)
'*************************************************
'Author: Unknown
'Last modified: 03/15/2006
'Resetea todos los valores generales y las stats
'*************************************************

    UserList(UserIndex).Reputacion.AsesinoRep = 0
    UserList(UserIndex).Reputacion.BandidoRep = 0
    UserList(UserIndex).Reputacion.BurguesRep = 0
    UserList(UserIndex).Reputacion.LadronesRep = 0
    UserList(UserIndex).Reputacion.NobleRep = 0
    UserList(UserIndex).Reputacion.PlebeRep = 0
    UserList(UserIndex).Reputacion.NobleRep = 0
    UserList(UserIndex).Reputacion.Promedio = 0

End Sub

Sub ResetGuildInfo(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    If UserList(UserIndex).EscucheClan > 0 Then
        Call modGuilds.GMDejaDeEscucharClan(UserIndex, UserList(UserIndex).EscucheClan)
        UserList(UserIndex).EscucheClan = 0
    End If
    If UserList(UserIndex).GuildIndex > 0 Then
        Call modGuilds.m_DesconectarMiembroDelClan(UserIndex, UserList(UserIndex).GuildIndex)
    End If
    UserList(UserIndex).GuildIndex = 0
End Sub

Sub ResetUserFlags(ByVal UserIndex As Integer)

    UserList(UserIndex).flags.MenuCliente = 0
    UserList(UserIndex).flags.LastSlotClient = 0
    UserList(UserIndex).flags.LastSlotPotion = 0
    UserList(UserIndex).flags.CuentaPq = 0
    UserList(UserIndex).flags.EnEvento = 0
    UserList(UserIndex).flags.lastPos.Map = 0
    UserList(UserIndex).flags.lastPos.Y = 0
    UserList(UserIndex).flags.lastPos.X = 0
    UserList(UserIndex).flags.Puntos = 0
    UserList(UserIndex).flags.GlobalOn = False
    UserList(UserIndex).flags.GlobalTick = 0
    UserList(UserIndex).flags.CuentaPq = 0
    UserList(UserIndex).flags.Comerciando = False
    UserList(UserIndex).flags.Ban = 0
    UserList(UserIndex).flags.Escondido = 0
    UserList(UserIndex).flags.DuracionEfecto = 0
    UserList(UserIndex).flags.TargetNPC = 0
    UserList(UserIndex).flags.TargetNpcTipo = eNPCType.Comun
    UserList(UserIndex).flags.TargetObj = 0
    UserList(UserIndex).flags.TargetObjMap = 0
    UserList(UserIndex).flags.TargetObjX = 0
    UserList(UserIndex).flags.TargetObjY = 0
    UserList(UserIndex).flags.TargetUser = 0
    UserList(UserIndex).flags.TipoPocion = 0
    UserList(UserIndex).flags.TomoPocion = False
    UserList(UserIndex).flags.char_locked_in_mao = 0

    UserList(UserIndex).flags.commerce_npc_slot_index = 0
    UserList(UserIndex).flags.mao_index = 0

    UserList(UserIndex).flags.Hambre = 0
    UserList(UserIndex).flags.Sed = 0
    UserList(UserIndex).flags.Descansar = False

    UserList(UserIndex).flags.Navegando = 0
    UserList(UserIndex).flags.oculto = 0
    UserList(UserIndex).flags.Envenenado = 0
    UserList(UserIndex).flags.invisible = 0
    UserList(UserIndex).flags.Paralizado = 0
    UserList(UserIndex).flags.Inmovilizado = 0
    UserList(UserIndex).flags.Meditando = 0
    UserList(UserIndex).flags.Privilegios = 0
    UserList(UserIndex).flags.OldBody = 0
    UserList(UserIndex).flags.OldHead = 0
    UserList(UserIndex).flags.AdminInvisible = 0
    UserList(UserIndex).flags.Hechizo = 0
    UserList(UserIndex).flags.TimesWalk = 0
    UserList(UserIndex).flags.StartWalk = 0
    UserList(UserIndex).flags.CountSH = 0
    UserList(UserIndex).flags.Silenciado = 0
    UserList(UserIndex).flags.CentinelaOK = False
    UserList(UserIndex).flags.CentinelaReaction = 0

    UserList(UserIndex).flags.AdminPerseguible = False
    UserList(UserIndex).flags.lastMap = 0
    UserList(UserIndex).flags.AtacadoPorNpc = 0
    UserList(UserIndex).flags.AtacadoPorUser = 0
    UserList(UserIndex).flags.NoPuedeSerAtacado = False
    UserList(UserIndex).flags.OwnedNpc = 0
    UserList(UserIndex).flags.ShareNpcWith = 0
    UserList(UserIndex).flags.ModoCombate = False

    UserList(UserIndex).flags.EnConsulta = False
    UserList(UserIndex).flags.Ignorado = False
    UserList(UserIndex).flags.ParalizedBy = vbNullString
    UserList(UserIndex).flags.ParalizedByIndex = 0
    UserList(UserIndex).flags.ParalizedByNpcIndex = 0

    If UserList(UserIndex).flags.OwnedNpc <> 0 Then
        Call PerdioNpc(UserIndex)
    End If

End Sub

Sub ResetUserSpells(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long
    For LoopC = 1 To MAXUSERHECHIZOS
        UserList(UserIndex).Stats.UserHechizos(LoopC) = 0
    Next LoopC
End Sub

Sub ResetUserPets(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    UserList(UserIndex).nroMascotas = 0

    For LoopC = 1 To MAXMASCOTAS
        UserList(UserIndex).MascotasIndex(LoopC) = 0
        UserList(UserIndex).MascotasType(LoopC) = 0
    Next LoopC
End Sub

Sub ResetUserBanco(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    For LoopC = 1 To MAX_BANCOINVENTORY_SLOTS
        UserList(UserIndex).BancoInvent.Object(LoopC).Amount = 0
        UserList(UserIndex).BancoInvent.Object(LoopC).Equipped = 0
        UserList(UserIndex).BancoInvent.Object(LoopC).ObjIndex = 0
    Next LoopC

    'UserList(UserIndex).BancoInvent.NroItems = 0
End Sub

Public Sub LimpiarComercioSeguro(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    With UserList(UserIndex).ComUsu
        If .DestUsu > 0 Then
            Call FinComerciarUsu(.DestUsu)
            Call FinComerciarUsu(UserIndex)
        End If
    End With
End Sub

Sub ResetUserSlot(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim i As Long

    UserList(UserIndex).flags.CuentaPq = 0
    UserList(UserIndex).Counters.IdleCount = 0

    With UserList(UserIndex).sReto
        .Accept_Count = 0
        .Nick_Sender = vbNullString
        .Reto_Index = 0
        .Team_Index = 0
        .ReturnHome = 0
        .AcceptedOK = False
        .AcceptLimitCount = 0
    End With

    With UserList(UserIndex).mReto
        .Tmp_Gold = 0
        .Tmp_Drop = 0
        .Tmp_Potions = 0
        .Tmp_Planted = 0
        .Tmp_CascoEscu = 0
        .IndexRecieve = 0
        .IndexSender = 0
        .ReturnHome = 0
        .Reto_Index = 0
        .AcceptLimitCount = 0
    End With

    For i = 1 To UBound(UserList(UserIndex).Stats.Penas())
        UserList(UserIndex).Stats.Penas(i) = ""
        UserList(UserIndex).Stats.CantPenas = 0
    Next i

    UserList(UserIndex).flags.ExClan = 0

    UserList(UserIndex).Stats.RetosGanados = 0
    UserList(UserIndex).Stats.RetosPerdidos = 0
    UserList(UserIndex).Stats.OroPerdido = 0
    UserList(UserIndex).Stats.OroGanado = 0

    UserList(UserIndex).ConnIDValida = False

    UserList(UserIndex).faccion.Status = 0

    Call LimpiarComercioSeguro(UserIndex)
    Call ResetFacciones(UserIndex)
    Call ResetContadores(UserIndex)
    Call ResetGuildInfo(UserIndex)
    Call ResetCharInfo(UserIndex)
    Call ResetBasicUserInfo(UserIndex)
    Call ResetReputacion(UserIndex)
    Call ResetUserFlags(UserIndex)
    Call LimpiarInventario(UserIndex)
    Call ResetUserSpells(UserIndex)
    Call ResetUserPets(UserIndex)
    Call ResetUserBanco(UserIndex)
    Call ResetAntiFrags(UserIndex)
    Call ResetQuestStats(UserIndex)

    UserList(UserIndex).PartyIndex = 0
    Call mod_Party.ResetPartyRequest(UserIndex)

    With UserList(UserIndex).ComUsu
        .Acepto = False

        For i = 1 To MAX_OFFER_SLOTS
            .Cant(i) = 0
            .objeto(i) = 0
        Next i

        .goldAmount = 0
        .DestNick = vbNullString
        .DestUsu = 0
    End With

End Sub

Sub CloseUser(ByVal UserIndex As Integer)
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    On Error GoTo Errhandler

    Dim Map As Integer
    Dim Name As String
    Dim i As Long

    Dim aN As Integer

1   aN = UserList(UserIndex).flags.AtacadoPorNpc
2   If aN > 0 Then
3       Npclist(aN).Movement = Npclist(aN).flags.OldMovement
4       Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
5       Npclist(aN).flags.AttackedBy = vbNullString
    End If
6   aN = UserList(UserIndex).flags.NPCAtacado
7   If aN > 0 Then
8       If Npclist(aN).flags.AttackedFirstBy = UserList(UserIndex).Name Then
9           Npclist(aN).flags.AttackedFirstBy = vbNullString
        End If
    End If
10  UserList(UserIndex).flags.AtacadoPorNpc = 0
11  UserList(UserIndex).flags.NPCAtacado = 0

111 Map = UserList(UserIndex).Pos.Map
12  Name = UCase$(UserList(UserIndex).Name)

13  UserList(UserIndex).Char.FX = 0
14  UserList(UserIndex).Char.loops = 0
15  Call SendData(SendTarget.ToPCArea, UserIndex, PrepareMessageCreateFX(UserList(UserIndex).Char.CharIndex, 0, 0))


    UserList(UserIndex).flags.UserLogged = False
    UserList(UserIndex).Counters.Saliendo = False

    'Le devolvemos el body y head originales
16  If UserList(UserIndex).flags.AdminInvisible = 1 Then
        Call DoAdminInvisible(UserIndex)
    End If

17  Call Statistics.UserDisconnected(UserIndex)

188 Call mod_DB.Update_DataBase_UserIndex(UserIndex, UserList(UserIndex).Pin, UserList(UserIndex).Pass)

    ' Grabamos el personaje del usuario
18  Call SaveUser(UserIndex, CharPath & Name & ".chr")

    'usado para borrar Pjs
19  Call WriteVar(CharPath & UserList(UserIndex).Name & ".chr", "INIT", "Logged", "0")

20  If MapInfo(Map).NumUsers > 0 Then
21      Call SendData(SendTarget.ToPCAreaButIndex, UserIndex, PrepareMessageRemoveCharDialog(UserList(UserIndex).Char.CharIndex))
    End If

    'Borrar el personaje
22  If UserList(UserIndex).Char.CharIndex > 0 Then
23      Call EraseUserChar(UserIndex, UserList(UserIndex).flags.AdminInvisible = 1)
    End If

    If UserList(UserIndex).flags.AdminInvisible = 1 Then
        UserList(UserIndex).Char.body = UserList(UserIndex).flags.OldBody
        UserList(UserIndex).Char.Head = UserList(UserIndex).flags.OldHead
        'UserList(UserIndex).Char.WeaponAnim = UserList(UserIndex).Char.OldWeapon
        'UserList(UserIndex).Char.ShieldAnim = UserList(UserIndex).Char.OldShield
        UserList(UserIndex).flags.AdminInvisible = 0
    End If

    'Borrar mascotas
    For i = 1 To MAXMASCOTAS
        If UserList(UserIndex).MascotasIndex(i) > 0 Then
            If Npclist(UserList(UserIndex).MascotasIndex(i)).flags.NPCActive Then
                Call QuitarNPC(UserList(UserIndex).MascotasIndex(i))
            End If
        End If
    Next i

    'Update Map Users
27  MapInfo(Map).NumUsers = MapInfo(Map).NumUsers - 1
    If MapInfo(Map).NumUsers < 0 Then
        MapInfo(Map).NumUsers = 0
    End If

    ' Si el usuario habia dejado un msg en la gm's queue lo borramos
28  If Ayuda.Existe(UserList(UserIndex).Name) Then Call Ayuda.Quitar(UserList(UserIndex).Name)

29  Call ResetUserSlot(UserIndex)

30  Call MostrarNumUsers
31  Call GenerateOnlineString
    'n = FreeFile(1)
    'Open App.path & "\logs\Connect.log" For Append Shared As #n
    'Print #n, Name & " ha dejado el juego. " & "User Index:" & UserIndex & " " & Time & " " & Date
    'Close #n

    Exit Sub

Errhandler:
    Call LogError("Error en CloseUser en " & Erl & ". Err: " & Err.Number & " Descripción: " & Err.Description)

End Sub

Public Sub EcharPjsNoPrivilegiados()
'***************************************************
'Author: Unknown
'Last Modification: -
'
'***************************************************

    Dim LoopC As Long

    For LoopC = 1 To LastUser
        If UserList(LoopC).flags.UserLogged And UserList(LoopC).ConnIDValida Then
            If UserList(LoopC).flags.Privilegios < PlayerType.Consejero Then
                Call CloseSocket(LoopC)
            End If
        End If
    Next LoopC

End Sub


