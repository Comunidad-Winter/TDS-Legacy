VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAudio"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Const NumSoundBuffers As Byte = 30

Private Const MAX_DISTANCE_TO_SOURCE As Integer = 150

Private Const DELTA_FQ As Integer = 75

Private Type SoundBuffer
    FileName As String
    Looping As Boolean
    X As Byte
    Y As Byte
    normalFq As Long
    Buffer As DirectSoundSecondaryBuffer8
End Type

Public Enum LoopStyle
    Default = 0
    Disabled = 1
    Enabled = 2
End Enum

Dim inited As Boolean

Dim DirectSound As DirectSound8

Dim DSBuffers(1 To NumSoundBuffers) As SoundBuffer

Dim SoundPath As String

Dim SndVolume As Long

Dim Performance As DirectMusicPerformance8

Dim Segment As DirectMusicSegment8

Dim Loader As DirectMusicLoader8

Dim SegState As DirectMusicSegmentState8

Dim music As Boolean

Dim MusicPath As String

Dim CurrentMusicFile As String

Dim mActivated As Boolean

Dim sActivated As Boolean

Dim lastPosX As Integer

Dim lastPosY As Integer

Dim sEffectsActivated As Boolean

Private LastPlayMP3 As Boolean

Dim IMC As IMediaControl

Dim IBA As IBasicAudio

Dim IME As IMediaEvent

Dim IMPos As IMediaPosition

Private Sub Class_Terminate()
    Dim LoopC As Long
    For LoopC = 1 To NumSoundBuffers
        If LenB(DSBuffers(LoopC).FileName) <> 0 Then
            Call DSBuffers(LoopC).Buffer.Stop
        End If
        Set DSBuffers(LoopC).Buffer = Nothing
    Next LoopC
    Call StopWave
    If Not Segment Is Nothing Then Call Performance.StopEx(Segment, 0, DMUS_SEGF_DEFAULT)
    Set DirectSound = Nothing
    Set Segment = Nothing
    Set Performance = Nothing
    Set Loader = Nothing
    inited = False
End Sub

Public Function Initialize(ByRef dX As DirectX8, ByVal hwnd As Long, ByVal sound_path As String, ByVal music_path As String) As Boolean
    On Error GoTo ErrHandler
    If inited Then Exit Function
    If dX Is Nothing Then GoTo ErrHandler
    Set DirectSound = dX.DirectSoundCreate("")
    Call DirectSound.SetCooperativeLevel(hwnd, DSSCL_PRIORITY)
    SoundPath = sound_path
    SndVolume = 0
    music = InitializedirectMusic(dX, hwnd)
    MusicPath = music_path
    mActivated = True
    sActivated = True
    CurrentMusicFile = vbNullString
    MusicTempo = 0
    Call Performance.SetMasterVolume(200)
    inited = True
    Initialize = True
    Exit Function
ErrHandler:
End Function

Public Function ResetMidi()
    CurrentMusicFile = ""
    MusicMP3Stop
End Function

Private Function InitializedirectMusic(ByRef dX As DirectX8, ByVal hwnd As Long) As Boolean
    On Error GoTo ErrHandler
    Dim mus_Params As DMUS_AUDIOPARAMS
    Set Loader = DirectX.DirectMusicLoaderCreate()
    Set Performance = dX.DirectMusicPerformanceCreate()
    Call Performance.InitAudio(hwnd, DMUS_AUDIOF_ALL, mus_Params, Nothing, DMUS_APATH_DYNAMIC_STEREO, 128)
    Call Performance.SetMasterAutoDownload(True)
    Performance.SetMasterTempo 1
    Performance.SetMasterVolume 1
    InitializedirectMusic = True
    Exit Function
ErrHandler:
End Function

Public Function PlayWave(ByVal FileName As String, Optional ByVal srcX As Byte = 0, Optional ByVal srcY As Byte = 0, Optional ByVal LoopSound As LoopStyle = LoopStyle.Default) As Long
    On Error GoTo ErrHandler
    If Not SoundActivated Then Exit Function
    Dim BufferIndex As Long
    BufferIndex = LoadWave(FileName, LoopSound)
    If BufferIndex = 0 Then Exit Function
    With DSBuffers(BufferIndex)
        If .Looping Then
            .Buffer.Play DSBPLAY_LOOPING
        Else
            .Buffer.Play DSBPLAY_DEFAULT
        End If
        Call .Buffer.SetVolume(SndVolume)
        .X = srcX
        .Y = srcY
        .normalFq = .Buffer.GetFrequency()
    End With
    PlayWave = BufferIndex
    If sEffectsActivated Then
        If srcX <> 0 And srcY <> 0 Then
            Call Update3DSound(BufferIndex, 0, 0)        ', IsPaso)
        End If
    End If
    Exit Function
ErrHandler:
End Function

Private Sub ResetSoundValues()
    Dim i As Long
    For i = 1 To NumSoundBuffers
        If Not DSBuffers(i).Buffer Is Nothing Then
            With DSBuffers(i)
                Call .Buffer.SetFrequency(.normalFq)
                Call .Buffer.SetVolume(SndVolume)
                Call .Buffer.SetPan(0)
            End With
        End If
    Next i
End Sub

Private Sub Update3DSound(ByVal BufferIndex As Long, ByVal deltaX As Integer, ByVal deltaY As Integer)
    Dim linearDistanceOld As Single
    Dim linearDistanceNew As Single
    Dim deltaDistance As Single
    Dim distanceXOld As Long
    Dim distanceYOld As Long
    Dim distanceXNew As Long
    Dim distanceYNew As Long
    Dim perceivedFq As Long
    With DSBuffers(BufferIndex)
        distanceXOld = .X - lastPosX
        distanceYOld = .Y - lastPosY
        distanceXNew = distanceXOld + deltaX
        distanceYNew = distanceYOld + deltaY
        linearDistanceOld = Sqr(distanceXOld * distanceXOld + distanceYOld * distanceYOld)
        linearDistanceNew = Sqr(distanceXNew * distanceXNew + distanceYNew * distanceYNew)
        deltaDistance = linearDistanceNew - linearDistanceOld
        perceivedFq = .normalFq * (1 - deltaDistance / DELTA_FQ)
        If perceivedFq < DSBFREQUENCY_MIN Then perceivedFq = DSBFREQUENCY_MIN
        Call .Buffer.SetFrequency(perceivedFq)
        If linearDistanceNew > MAX_DISTANCE_TO_SOURCE Then
            Call .Buffer.SetVolume(SndVolume + (DSBVOLUME_MIN - SndVolume))
        Else
            Call .Buffer.SetVolume(SndVolume + (linearDistanceNew / MAX_DISTANCE_TO_SOURCE) * (DSBVOLUME_MIN - SndVolume))
        End If
        If linearDistanceNew = 0 Then linearDistanceNew = 1
        Call .Buffer.SetPan((distanceXNew / linearDistanceNew) * DSBPAN_RIGHT)
    End With
End Sub
Public Sub MoveListener(ByVal X As Integer, ByVal Y As Integer)
    If Not sEffectsActivated Then Exit Sub
    Dim i As Long
    Dim deltaX As Integer
    Dim deltaY As Integer
    On Error GoTo ErrHandler
    deltaX = X - lastPosX
    deltaY = Y - lastPosY
    For i = 1 To NumSoundBuffers
        If Not DSBuffers(i).Buffer Is Nothing Then
            If DSBuffers(i).Buffer.GetStatus And DSBSTATUS_PLAYING Then
                If DSBuffers(i).X <> 0 And DSBuffers(i).Y <> 0 Then
                    Call Update3DSound(i, deltaX, deltaY)        ', 1)
                End If
            End If
        End If
    Next i
    lastPosX = X
    lastPosY = Y
    'Exit Sub
ErrHandler:
    sEffectsActivated = False
End Sub
Private Function LoadWave(ByVal FileName As String, ByVal Looping As LoopStyle) As Long
    On Error GoTo ErrHandler
    Dim bufferDesc As DSBUFFERDESC
    Dim waveFormat As WAVEFORMATEX
    Dim i As Long
    FileName = UCase$(FileName)
    If Not FileExist(SoundPath & FileName, vbArchive) Then Exit Function
    For i = 1 To NumSoundBuffers
        If DSBuffers(i).FileName = FileName Then
            If DSBuffers(i).Buffer.GetStatus = 0 Or DSBuffers(i).Buffer.GetStatus() = DSBSTATUS_BUFFERLOST Then
                LoadWave = i
                If Looping <> LoopStyle.Default Then DSBuffers(i).Looping = (Looping = LoopStyle.Enabled)
                Call DSBuffers(i).Buffer.SetFrequency(DSBuffers(i).normalFq)
                Exit Function
            End If
        End If
    Next i
    For i = 1 To NumSoundBuffers
        If DSBuffers(i).Buffer Is Nothing Then
            Exit For
        End If
    Next i
    If i > NumSoundBuffers Then
        For i = 1 To NumSoundBuffers
            If DSBuffers(i).Buffer.GetStatus() = DSBSTATUS_BUFFERLOST Or DSBuffers(i).Buffer.GetStatus() = 0 Then
                Exit For
            End If
        Next i
    End If
    If i > NumSoundBuffers Then
        For i = 1 To NumSoundBuffers
            If Not (DSBuffers(i).Buffer.GetStatus() And DSBSTATUS_LOOPING) Then
                Call DSBuffers(i).Buffer.Stop
                Exit For
            End If
        Next i
    End If
    If i > NumSoundBuffers Then
        If Not Looping Then Exit Function
        i = 1
    End If
    bufferDesc.lFlags = DSBCAPS_CTRLFREQUENCY Or DSBCAPS_CTRLPAN Or DSBCAPS_CTRLVOLUME Or DSBCAPS_STATIC
    waveFormat.nFormatTag = WAVE_FORMAT_PCM
    waveFormat.nChannels = 2
    waveFormat.lSamplesPerSec = 44100        '22050 (44k GSZAO TEST)
    waveFormat.nBitsPerSample = 16
    waveFormat.nBlockAlign = waveFormat.nBitsPerSample / 8 * waveFormat.nChannels
    waveFormat.lAvgBytesPerSec = waveFormat.lSamplesPerSec * waveFormat.nBlockAlign
    With DSBuffers(i)
        Set .Buffer = Nothing

        .FileName = FileName
        .Looping = (Looping = LoopStyle.Enabled)
        Set .Buffer = DirectSound.CreateSoundBufferFromFile(SoundPath & FileName, bufferDesc)
    End With
    LoadWave = i
    Exit Function
ErrHandler:
End Function

Public Sub StopWave(Optional ByVal BufferIndex As Long = 0)
    If BufferIndex > 0 And BufferIndex <= NumSoundBuffers Then
        If DSBuffers(BufferIndex).Buffer.GetStatus() And DSBSTATUS_PLAYING Then
            Call DSBuffers(BufferIndex).Buffer.Stop
        End If
    ElseIf BufferIndex = 0 Then
        Dim i As Long
        For i = 1 To NumSoundBuffers
            If Not DSBuffers(i).Buffer Is Nothing Then
                If DSBuffers(i).Buffer.GetStatus() <> 0 And DSBuffers(i).Buffer.GetStatus() <> DSBSTATUS_BUFFERLOST Then
                    Call DSBuffers(i).Buffer.Stop
                End If
            End If
        Next i
    End If
End Sub

Public Property Get PlayingSound() As Boolean
    Dim i As Long
    For i = 1 To NumSoundBuffers
        If Not DSBuffers(i).Buffer Is Nothing Then
            If DSBuffers(i).Buffer.GetStatus() And DSBSTATUS_PLAYING Then
                PlayingSound = True
                Exit Property
            End If
        End If
    Next i
End Property

Public Property Let SoundVolume(ByVal Volume As Integer)
    Dim i As Long
    If Volume > 100 Then Exit Property
    SndVolume = Volume * (DSBVOLUME_MAX - DSBVOLUME_MIN) / 100 + DSBVOLUME_MIN
    For i = 1 To NumSoundBuffers
        If Not DSBuffers(i).Buffer Is Nothing Then
            If DSBuffers(i).Buffer.GetStatus And DSBSTATUS_PLAYING Then
                Call DSBuffers(i).Buffer.SetVolume(SndVolume)
            End If
        End If
    Next i
End Property

Public Function SetSound(ByVal Volume As Byte)
    Dim i As Long
    Volume = Volume
    If Volume > 100 Then Exit Function
    SndVolume = Volume * (DSBVOLUME_MAX - DSBVOLUME_MIN) / 100 + DSBVOLUME_MIN
    For i = 1 To NumSoundBuffers
        If Not DSBuffers(i).Buffer Is Nothing Then
            If DSBuffers(i).Buffer.GetStatus And DSBSTATUS_PLAYING Then
                Call DSBuffers(i).Buffer.SetVolume(SndVolume)
            End If
        End If
    Next i
End Function
Public Property Get SoundVolume() As Integer
    SoundVolume = CByte((SndVolume - DSBVOLUME_MIN) * 100 / (DSBVOLUME_MAX - DSBVOLUME_MIN))
End Property
Public Function PlayMIDI(Optional ByVal File As String = vbNullString, Optional ByVal Loops As Long = -1) As Boolean
    On Error GoTo ErrHandler
    If CurrentMusicFile = File And PlayingMusic Then Exit Function
    If LenB(File) > 0 Then CurrentMusicFile = File
    LastPlayMP3 = False
    If Not MusicActivated Then Exit Function
    If Not music Then Exit Function
    If PlayingMusic Then StopMidi
    If LenB(File) > 0 Then
        If Not LoadMidi(File) Then Exit Function
    Else
        If Segment Is Nothing Then Exit Function
    End If
    MusicMP3Stop
    Call Segment.SetRepeats(Loops)
    Set SegState = Performance.PlaySegmentEx(Segment, DMUS_SEGF_DEFAULT, 0)
    PlayMIDI = True
    Exit Function
ErrHandler:
End Function

Private Function LoadMidi(ByVal File As String) As Boolean
    On Error GoTo ErrHandler
    If Not FileExist(MusicPath & File, vbArchive) Then Exit Function
    Call StopMidi
    Set Segment = Nothing
    Set Segment = Loader.LoadSegment(MusicPath & File)
    If Segment Is Nothing Then Exit Function
    Call Segment.SetStandardMidiFile
    LoadMidi = True
    Exit Function
ErrHandler:
End Function

Public Sub StopMidi()
    On Error GoTo ErrHandler
    If PlayingMusic Then Call Performance.StopEx(Segment, 0, DMUS_SEGF_DEFAULT)
    Exit Sub
ErrHandler:
End Sub

Public Property Let MusicTempo(ByVal Tempo As Single)
    If Not music Then Exit Property
    If Tempo < 0.25 Or Tempo > 2# Then Exit Property
    Call Performance.SetMasterTempo(Tempo)
End Property

Public Property Let MusicVolume(ByVal Volume As Long)
    If Not music Then Exit Property
    If Volume < 0 Or Volume > 100 Then Exit Property
    Call Performance.SetMasterVolume((Volume / 100) * 3200 - 3200)
End Property

Public Function SetMusic(ByVal Volume As Long)
    If Not music Then Exit Function
    If Volume < 0 Or Volume > 100 Then Exit Function
    Call Performance.SetMasterVolume((Volume / 100) * 3200 - 3200)
End Function

Public Property Get MusicTempo() As Single
    If Not music Then Exit Property
    MusicTempo = Performance.GetMasterTempo()
End Property

Public Property Get MusicVolume() As Long
    If Not music Then Exit Property
    MusicVolume = (Performance.GetMasterVolume() + 10000) / 100
End Property

Public Property Get PlayingMusic() As Boolean
    If Not music Or Segment Is Nothing Then Exit Property
    PlayingMusic = Performance.IsPlaying(Segment, SegState)
End Property

Public Property Get Musiclength() As Long
    If Not music Then Exit Property
    Musiclength = Segment.GetLength()
End Property

Public Function MusicMP3Empty() As Boolean
    On Error GoTo ErrorHandl
    If ObjPtr(IMC) > 0 Then Call MusicMP3Stop
    Set IBA = Nothing
    Set IME = Nothing
    Set IMPos = Nothing
    Set IMC = Nothing
    MusicMP3Empty = True
    Exit Function
ErrorHandl:
    MusicMP3Empty = False
    MsgBox "MusicMP3Empty"
    End
End Function

Public Function MusicMP3Load(ByVal FilePath As String, Optional ByVal Volume As Long = 0, Optional ByVal Balance As Long = 0) As Boolean
    On Error GoTo ErrorHandl
    If Not FileExist(FilePath, vbArchive) Then Exit Function
    If Not MusicMP3Empty() Then GoTo ErrorHandl
    Set IMC = New FilgraphManager
    Call IMC.RenderFile(FilePath)
    Set IBA = IMC
    If Volume > 0 Then Volume = 0
    If Volume < -4000 Then Volume = -4000
    IBA.Volume = Volume
    If Balance > 5000 Then Balance = 5000
    If Balance < -5000 Then Balance = -5000
    IBA.Balance = Balance
    Set IME = IMC
    Set IMPos = IMC
    If ObjPtr(IMPos) Then IMPos.Rate = 1#
    IMPos.CurrentPosition = 0
    MusicMP3Load = True
    Exit Function
ErrorHandl:
    MusicMP3Load = False
End Function

Public Function MusicMP3Play(Optional ByVal FilePath As String = vbNullString) As Boolean
    On Error GoTo ErrorHandle
    If LenB(FilePath) > 0 Then CurrentMusicFile = FilePath
    LastPlayMP3 = True
    If Not MusicActivated Then Exit Function
    If Not music Then Exit Function
    If LenB(FilePath) > 0 Then
        If Not MusicMP3Load(FilePath) Then Exit Function
    Else
        If IMC Is Nothing Then Exit Function
    End If
    StopMidi
    Call IMC.Run
    MusicMP3Play = True
    Exit Function

ErrorHandle:
    MusicMP3Play = False
End Function


Public Sub MusicMP3GetLoop()
    On Error GoTo ErrorHandle
    'If IMPos.StopTime = IMPos.CurrentPosition Then
    '  IMPos.CurrentPosition = 0
    '  IMC.Run
    ' End If
ErrorHandle:
End Sub


Public Function MusicMP3Stop() As Boolean
    On Error GoTo ErrorHandle
    If ObjPtr(IMC) > 0 Then
        IMC.Stop
        IMPos.CurrentPosition = 0
    End If
    MusicMP3Stop = True
    Exit Function
ErrorHandle:
    MusicMP3Stop = False
End Function

Public Function MusicMP3Pause() As Boolean
    On Error GoTo ErrorHandle
    Call IMC.Pause
    MusicMP3Pause = True
    Exit Function
ErrorHandle:
    MusicMP3Pause = False
End Function

Public Function MusicMP3VolumeSet(ByVal Volume As Long) As Boolean
    On Error GoTo ErrorHandle
    If Volume > 0 Then Volume = 0
    If Volume < -4000 Then Volume = -4000
    IBA.Volume = Volume
    MusicMP3VolumeSet = True
    Exit Function
ErrorHandle:
    MusicMP3VolumeSet = False
End Function

Public Property Get MusicActivated() As Boolean
    MusicActivated = mActivated
End Property

Public Property Let MusicActivated(ByVal nValue As Boolean)
    If mActivated = nValue Then Exit Property
    mActivated = nValue
    If nValue Then
        If LastPlayMP3 Then
            Call MusicMP3Play(CurrentMusicFile)
        Else
            Call PlayMIDI(CurrentMusicFile)
        End If
    Else
        If LastPlayMP3 Then
            Call MusicMP3Stop
        Else
            Call StopMidi
        End If
    End If
End Property

Public Property Get SoundActivated() As Boolean
    SoundActivated = sActivated
End Property

Public Property Let SoundActivated(ByVal nValue As Boolean)
    If sActivated = nValue Then Exit Property
    sActivated = nValue
    If Not nValue Then
        Call StopWave
    End If
End Property

Public Property Let SoundEffectsActivated(ByVal nValue As Boolean)
    sEffectsActivated = nValue
    If Not nValue Then
        Call ResetSoundValues
    End If
End Property

Public Property Get SoundEffectsActivated() As Boolean
    SoundEffectsActivated = sEffectsActivated
End Property


