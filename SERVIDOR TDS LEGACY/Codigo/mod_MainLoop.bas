Attribute VB_Name = "mod_MainLoop"
Option Explicit
Type tMainLoop
    MAXINT As Long
    LastCheck As Long
End Type
Private Const NumTimers As Byte = 2 '//Aca la cantidad de timers.
Private MainLoops(1 To NumTimers) As tMainLoop
 

 
Private Enum eTimers
    GameTimer = 1
    packetResend = 2
End Enum
Public prgRun As Boolean
 
Public Sub MainLoop()
    Dim LoopC As Long
    MainLoops(eTimers.GameTimer).MAXINT = 40
    MainLoops(eTimers.packetResend).MAXINT = 10
    prgRun = True
    
    ''Do While prgRun
      ''  For LoopC = 1 To NumTimers
          ''  With MainLoops(LoopC)
            ''    If GetTickCount - .LastCheck >= .MAXINT Then
             ''       Call MakeProcces(LoopC)
            ''    End If
         ''   End With
         ''   DoEvents
       '' Next LoopC
      ''  SleepNew 1
       '' DoEvents
    ''Loop
End Sub

 
Private Sub MakeProcces(ByVal index As Integer)
    Select Case index
        Case eTimers.GameTimer
            Call frmMain.GameTimer_Timer
 
        Case eTimers.packetResend
            Call frmMain.packetResend_Timer
    End Select
    MainLoops(index).LastCheck = GetTickCount
End Sub
 
