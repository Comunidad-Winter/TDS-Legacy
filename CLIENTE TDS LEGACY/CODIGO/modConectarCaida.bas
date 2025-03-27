Attribute VB_Name = "modConectarCaida"
Option Explicit

Public AlphaB As Byte
Public Caida As Integer
Public ModoCaida As Byte
Public Const TOP_CAIDA_CONECTAR As Integer = 580
Public Const TOP_CAIDA_CREARPJ As Integer = 580

Public PanelQuitVisible As Boolean
Public PanelCrearPJVisible As Boolean

Public Sub IniciarCaida(Modo As Byte)
    If Modo = 0 Then
        Caida = 0
    End If
    ModoCaida = Modo

    Call modEngine_Audio.PlayEffect(SND_CAIDA)
End Sub

Public Sub EfectoCaida()

    If ModoCaida = 0 Then
        If Caida < IIf(frmConnect.visible, TOP_CAIDA_CONECTAR, TOP_CAIDA_CREARPJ) Then
            Caida = Caida + 10 * tSetup.EfectoCaida

            If Caida > IIf(frmConnect.visible, TOP_CAIDA_CONECTAR, TOP_CAIDA_CREARPJ) Then
                Caida = IIf(frmConnect.visible, TOP_CAIDA_CONECTAR, TOP_CAIDA_CREARPJ)
            End If

        Else
            Caida = IIf(frmConnect.visible, TOP_CAIDA_CONECTAR, TOP_CAIDA_CREARPJ)
        End If
    Else
        If Caida > 0 Then
            Caida = Caida - 10 * tSetup.EfectoCaida
        Else
            If Caida < 0 Then Caida = 0

            If frmCrearPersonaje.visible = True Then
                PanelCrearPJVisible = False
            ElseIf frmConnect.visible And Not frmOldPersonaje.visible Then
                If Not frmOldPersonaje.visible And Not frmConnect.QuieroCrearPj And Not frmMensaje.visible Then
                    PanelQuitVisible = True
                End If

                If frmConnect.QuieroCrearPj Then
                    EstadoLogin = E_MODO.Dados
                    Call LoginOrConnect(Dados)
                    frmConnect.QuieroCrearPj = False
                    ModoCaida = 0
                End If
            End If
        End If
    End If
End Sub
