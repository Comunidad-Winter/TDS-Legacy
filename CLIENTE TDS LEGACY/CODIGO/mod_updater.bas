Attribute VB_Name = "mod_updater"
Option Explicit

Private Declare Function FindWindow Lib "user32.dll" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Long

Public directorio As String
Public bDone As Boolean
Public dError As Boolean
Private F As Integer
Private Checked As Boolean
Public updaterMd5 As String

Private Const HostingWeb As String = "https://tdslegacy.store/"


Public Function GetFileMD5(ByVal FileName As String) As String
    Dim MD5 As New clsMD5, FF As Integer, Buff() As Byte
    Const BuffSize As Long = 65536        ' (64 KBytes)

    On Error GoTo ErrExit
    FF = FreeFile
    Open FileName For Binary Access Read As FF
    MD5.MD5Init

    Do Until Loc(FF) >= LOF(FF)
        If Loc(FF) + BuffSize > LOF(FF) Then
            ReDim Buff(LOF(FF) - Loc(FF) - 1)
        Else
            ReDim Buff(BuffSize - 1)
        End If

        Get FF, , Buff
        MD5.MD5Update UBound(Buff) + 1, Buff
    Loop

    MD5.MD5Final
    GetFileMD5 = MD5.GetValues
    Close FF

    Exit Function
ErrExit:
    Err.Clear
    GetFileMD5 = ""
End Function


' Función principal que inicia la verificación y actualización
Sub VerificarYActualizar()
    If Checked Then Exit Sub    ' Si ya se ha verificado, salir

' Verificar y descargar el updater
    If Not VerificarYDescargarUpdater() Then Exit Sub

    ' Verificar y actualizar el cliente
    If Not VerificarYActualizarCliente() Then Exit Sub

    ' Verificar y actualizar el cliente faciil
    If Not VerificarYActualizarCliente_FACIL() Then Exit Sub

    ' Verificar y ejecutar actualización general
    Call VerificarYEjecutarActualizacionGeneral

    Checked = True    ' Marcar como verificado al finalizar
End Sub

' Función para verificar y descargar el updater
Function VerificarYDescargarUpdater() As Boolean
    Dim webMD5 As String
    Dim updaterMd5 As String
    Dim result As Long

    ' Obtener MD5 del updater remoto
    webMD5 = ObtenerMD5Remoto(HostingWeb & "updater/verexe_updater.txt")

    ' Verificar si el updater local existe
    If Not FileExist(App.Path & "/updater.exe", vbNormal) Then
        If MsgBox("El updater no se encuentra en la carpeta, deseas descargarlo?.", vbYesNo) = vbYes Then
            DescargarUpdater HostingWeb & "updater/updater.zip"
        End If
    End If

    ' Obtener MD5 del updater local
    updaterMd5 = GetFileMD5(App.Path & "/updater.exe")

    Debug.Print updaterMd5

    ' Verificar MD5
    If Len(webMD5) = 32 And Len(updaterMd5) = 32 And StrComp(Left(webMD5, 32), Left(updaterMd5, 32), vbTextCompare) = 0 Then
        ' MD5 coincide, no es necesario actualizar
        VerificarYDescargarUpdater = True
    Else

        ' @@HARDCODED!
        VerificarYDescargarUpdater = True
        Exit Function

        ' MD5 no coincide, descargar el nuevo updater
        If MsgBox("Puede que tengas un updater desactualizado (si tienes Windows 11 ignora éste mensaje)", vbYesNo) = vbYes Then
            DescargarUpdater HostingWeb & "updater/updater.zip"
            VerificarYDescargarUpdater = False
            'Else
            ' MsgBox "No se pudo revisar el juego correctamente."
            'End
        End If
    End If
End Function

' Función para descargar el updater desde una URL
Sub DescargarUpdater(URL As String)
    frmCargando.Inet1.AccessType = icUseDefault
    frmCargando.Inet1.URL = URL

    Dim directorio As String
    directorio = App.Path & "\Updater.zip"

    If FileExist(directorio, vbArchive) Then Kill directorio

    frmCargando.Inet1.Execute , "GET"
    Do While frmCargando.Inet1.StillExecuting
        DoEvents
    Loop

    If Not frmCargando.Inet1.ResponseCode = 200 Then
        MsgBox "ERROR: No se pudo descargar el Updater."
        Exit Sub
    End If

    ' Descomprimir el archivo descargado
    UnZip directorio, App.Path & "\"
    Kill directorio
End Sub

' Función para verificar y actualizar el cliente
Function VerificarYActualizarCliente() As Boolean
    Dim webMD5 As String
    Dim clientMd5 As String
    Dim result As Long

    ' Obtener MD5 del cliente remoto
    webMD5 = ObtenerMD5Remoto(HostingWeb & "updater/verexe_cliente.txt")

    ' Obtener MD5 del cliente local
    clientMd5 = GetVar(App.Path & "/INIT/Configs.ini", "INIT", "md5")

    If Len(clientMd5) < 2 Then
        clientMd5 = GetFileMD5(App.Path & "/TDSLF.exe")
        Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", "md5", clientMd5)
    End If

    ' Verificar MD5
    If Len(webMD5) = 32 And Len(clientMd5) = 32 And StrComp(Left(webMD5, 32), Left(clientMd5, 32), vbTextCompare) = 0 Then
        ' MD5 coincide, no es necesario actualizar
        VerificarYActualizarCliente = True
    Else
        ' MD5 no coincide, preguntar al usuario si desea actualizar
        If MsgBox("El ejecutable del juego está desactualizado, ¿desea actualizarlo?", vbYesNo) = vbYes Then
            result = ShellExecute(0, "runas", "updater.exe", "", CurDir$(), vbNormalFocus)
            If Not (result < 0 Or result > 32) Then
                MsgBox "Surgió un error al momento de ejecutar el Updater. Pruebe ejecutando el programa Updater.exe de manera manual", vbCritical
            End If
            Call Mod_General.CloseClient    'End
        End If
        VerificarYActualizarCliente = False
    End If
End Function

Function VerificarYActualizarCliente_FACIL() As Boolean
    Dim webMD5f As String
    Dim clientMd5f As String
    Dim result As Long

    ' Obtener MD5 del cliente remoto
    webMD5f = ObtenerMD5Remoto(HostingWeb & "updater/verexe_cliente_facil.txt")

    ' Obtener MD5 del cliente local
    clientMd5f = GetVar(App.Path & "/INIT/Configs.ini", "INIT", "md5f")

    If Len(clientMd5f) < 2 Then
        clientMd5f = GetFileMD5(App.Path & "/TDSLF.exe")
        Call WriteVar(App.Path & "/INIT/Configs.ini", "INIT", "md5f", clientMd5f)
    End If

    ' Verificar MD5
    If Len(webMD5f) = 32 And Len(clientMd5f) = 32 And StrComp(Left(webMD5f, 32), Left(clientMd5f, 32), vbTextCompare) = 0 Then
        ' MD5 coincide, no es necesario actualizar
        VerificarYActualizarCliente_FACIL = True
    Else
        ' MD5 no coincide, preguntar al usuario si desea actualizar
        If MsgBox("El ejecutable del juego está desactualizado, ¿desea actualizarlo?", vbYesNo) = vbYes Then
            result = ShellExecute(0, "runas", "updater.exe", "", CurDir$(), vbNormalFocus)
            If Not (result < 0 Or result > 32) Then
                MsgBox "Surgió un error al momento de ejecutar el Updater. Pruebe ejecutando el programa Updater.exe de manera manual", vbCritical
            End If
            Call Mod_General.CloseClient    'End
        End If
        VerificarYActualizarCliente_FACIL = False
    End If
End Function

' Función para verificar y ejecutar actualización general
Sub VerificarYEjecutarActualizacionGeneral()
    Dim currentPatch As String
    Dim webPatch As String
    Dim result As Long

    ' Obtener MD5 de la versión actualizada
    currentPatch = Val(LeerInt(App.Path & "\INIT\Update.ini"))
    webPatch = frmCargando.Inet1.OpenURL(HostingWeb & "updater/verexe.txt")

    If webPatch = vbNullString Or Len(webPatch) > 255 Then
        Call MsgBox("ERROR: No se pudo revisar si hay parches nuevos!.")
    End If

    If currentPatch <> webPatch Then
        If MsgBox("Cliente desactualizado, desea ejecutar el updater?", vbYesNo) = vbYes Then
            If FileExist(App.Path & "/updater.exe", vbArchive) Then
                result = ShellExecute(0, "runas", "updater.exe", "", CurDir$(), vbNormalFocus)
                Call Mod_General.CloseClient
            End If
        End If
    End If

End Sub

' Función para obtener MD5 de una URL remota
Function ObtenerMD5Remoto(URL As String) As String
    Dim webMD5 As String
    webMD5 = frmCargando.Inet1.OpenURL(URL)

    If webMD5 = vbNullString Or Len(webMD5) > 33 Or Len(webMD5) < 20 Then
        MsgBox "ERROR: No se pudo revisar si hay updater nuevo!."
        'End
    End If

    ObtenerMD5Remoto = Left(webMD5, 32)
End Function

