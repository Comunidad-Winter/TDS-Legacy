VERSION 5.00
Begin VB.UserControl getGitHubData 
   ClientHeight    =   1260
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   1320
   InvisibleAtRuntime=   -1  'True
   ScaleHeight     =   1260
   ScaleWidth      =   1320
End
Attribute VB_Name = "getGitHubData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Const m_ksProp_Data         As String = "Data"

Private m_bAsync                    As Boolean
Private m_sURL                      As String

Public Event AsyncReadProgress(ByRef the_abytData() As Byte)
Public Event AsyncReadComplete(ByRef the_abytData() As Byte)

Public Property Let Async(ByVal the_bValue As Boolean)
    m_bAsync = the_bValue
End Property

Public Property Get Async() As Boolean
    Async = m_bAsync
End Property

Public Property Let URL(ByVal the_sValue As String)
    m_sURL = the_sValue
End Property

Public Property Get URL() As String
    URL = m_sURL
End Property

Public Sub ReadGitHub()

    UserControl.AsyncRead m_sURL, vbAsyncTypeByteArray, m_ksProp_Data, IIf(m_bAsync, 0&, vbAsyncReadSynchronousDownload)

End Sub

Private Sub UserControl_AsyncReadComplete(AsyncProp As AsyncProperty)

    If AsyncProp.PropertyName = m_ksProp_Data Then
        RaiseEvent AsyncReadComplete(AsyncProp.Value)
    End If

End Sub

Private Sub UserControl_AsyncReadProgress(AsyncProp As AsyncProperty)

    If AsyncProp.PropertyName = m_ksProp_Data Then
        Select Case AsyncProp.StatusCode
        Case vbAsyncStatusCodeBeginDownloadData, vbAsyncStatusCodeDownloadingData, vbAsyncStatusCodeEndDownloadData
            RaiseEvent AsyncReadProgress(AsyncProp.Value)
        End Select
    End If

End Sub
