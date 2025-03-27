Attribute VB_Name = "m_RegistrarLibrerias"
Option Explicit


Private Declare Function LoadLibrary Lib "kernel32" Alias "LoadLibraryA" (ByVal lpLibFileName As String) As Long
Private Declare Function GetProcAddress Lib "kernel32" (ByVal hModule As Long, ByVal lpProcName As String) As Long
Private Declare Function CreateThread Lib "kernel32" (lpThreadAttributes As Any, ByVal dwStackSize As Long, ByVal lpStartAddress As Long, ByVal lParameter As Long, ByVal dwCreationFlags As Long, lpThreadID As Long) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function GetExitCodeThread Lib "kernel32" (ByVal hThread As Long, lpExitCode As Long) As Long
Private Declare Sub ExitThread Lib "kernel32" (ByVal dwExitCode As Long)
Private Declare Function FreeLibrary Lib "kernel32" (ByVal hLibModule As Long) As Long
Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long

Public Function RegisterDLLorOCX(ByVal File As String) As Boolean

    On Error Resume Next

    Dim LoadedLib As Long
    Dim EntryPoint As Long
    Dim ExitCode As Long
    Dim newThread As Long
    Dim newThreadID As Long

    If Dir$(File, vbNormal) = "" Then
        MsgBox "El archivo " & File & " no existe.", vbCritical, "DLL/OCX Register"
        Exit Function
    End If

    LoadedLib = LoadLibrary(File)

    If LoadedLib = 0 Then
        Call MsgBox("Ocurrió un error al cargar el archivo: " & File, vbCritical, "DLL/OCX Register")
        Exit Function
    End If

    EntryPoint = GetProcAddress(LoadedLib, "DllRegisterServer")

    If EntryPoint = vbNull Then
        Call MsgBox("Ocurrió un error al ubicar el punto de entrada para el archivo: " & vbNewLine & File, vbCritical, "DLL/OCX Register")
        Call FreeLibrary(LoadedLib)
        Exit Function
    End If

    Screen.MousePointer = vbHourglass
    newThread = CreateThread(ByVal 0, 0, ByVal EntryPoint, ByVal 0, 0, newThreadID)

    If newThread = 0 Then
        Screen.MousePointer = vbDefault
        Call MsgBox("Ocurrió un error al intentar crear un nuevo hilo.", vbCritical, "DLL/OCX Register")
        Call FreeLibrary(LoadedLib)
        Exit Function
    End If

    If WaitForSingleObject(newThread, 10000) <> 0 Then
        Screen.MousePointer = vbDefault
        Call MsgBox("Ocurrió un error al intentar registrar el archivo: " & vbNewLine & File, vbCritical, "DLL/OCX Register")

        ExitCode = GetExitCodeThread(newThread, ExitCode)
        Call ExitThread(ExitCode)
        Call FreeLibrary(LoadedLib)
        Exit Function
    End If

    Call CloseHandle(newThread)
    Call FreeLibrary(LoadedLib)

    Screen.MousePointer = vbDefault
    RegisterDLLorOCX = True

End Function


