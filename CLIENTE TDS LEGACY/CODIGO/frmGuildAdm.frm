VERSION 5.00
Begin VB.Form frmGuildAdm 
   BackColor       =   &H000040C0&
   BorderStyle     =   0  'None
   Caption         =   "Lista de Clanes Registrados"
   ClientHeight    =   3900
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4140
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   260
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   276
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.ListBox GuildsList 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   1980
      ItemData        =   "frmGuildAdm.frx":0000
      Left            =   420
      List            =   "frmGuildAdm.frx":0002
      TabIndex        =   0
      Top             =   1065
      Width           =   3165
   End
   Begin VB.Image imgDetalles 
      Height          =   495
      Left            =   2760
      Tag             =   "1"
      Top             =   3240
      Width           =   1095
   End
   Begin VB.Image imgCerrar 
      Height          =   495
      Left            =   1560
      Tag             =   "1"
      Top             =   3240
      Width           =   975
   End
End
Attribute VB_Name = "frmGuildAdm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Argentum Online 0.11.6
'
'Copyright (C) 2002 Márquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'Copyright (C) 2002 Matías Fernando Pequeño
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
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 número 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Código Postal 1900
'Pablo Ignacio Márquez

Option Explicit

Private clsFormulario As clsFrmMovMan

Public LastPressed As clsGraphicalButton

Private Sub Form_Load()
' Handles Form movement (drag and drop).
    Set clsFormulario = New clsFrmMovMan
    clsFormulario.Initialize Me

    Call forms_load_pic(Me, "975.bmp", False)

End Sub



Private Sub imgCerrar_Click()
    Unload Me
    frmMain.SetFocus
End Sub

Private Sub imgDetalles_Click()

    If guildslist.ListIndex = -1 Then
        MsgBox "Selecciona un clan primero"
        Exit Sub
    End If

    frmGuildBrief.EsLeader = False
    frmGuildBrief.ClanSeleccionado = guildslist.ListIndex + 1
    frmGuildBrief.ClanSeleccionado_Nombre = guildslist.List(guildslist.ListIndex + 1)

    Call WriteGuildRequestDetails(guildslist.ListIndex + 1)

End Sub
