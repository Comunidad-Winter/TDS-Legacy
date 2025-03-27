VERSION 5.00
Begin VB.Form Eventos 
   Caption         =   "Evento"
   ClientHeight    =   7095
   ClientLeft      =   120
   ClientTop       =   450
   ClientWidth     =   9615
   LinkTopic       =   "Eventos"
   ScaleHeight     =   7095
   ScaleWidth      =   9615
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame f_Test 
      Caption         =   "Test"
      Height          =   6735
      Left            =   5760
      TabIndex        =   1
      Top             =   120
      Width           =   3735
   End
   Begin VB.Frame f_Events 
      Caption         =   "Eventos"
      Height          =   6735
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5415
      Begin VB.ComboBox Combo1 
         Height          =   315
         ItemData        =   "Eventos.frx":0000
         Left            =   240
         List            =   "Eventos.frx":0022
         TabIndex        =   4
         Text            =   "EVENTOS"
         Top             =   720
         Width           =   1575
      End
      Begin TdslClient.lvButtons_H lvButtons_H2 
         Height          =   495
         Left            =   360
         TabIndex        =   2
         Top             =   6000
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   873
         CapAlign        =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Mode            =   0
         Value           =   0   'False
         cBack           =   -2147483633
      End
      Begin TdslClient.lvButtons_H lvButtons_H1 
         Height          =   495
         Left            =   2760
         TabIndex        =   3
         Top             =   6000
         Width           =   1935
         _ExtentX        =   3413
         _ExtentY        =   873
         CapAlign        =   2
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Mode            =   0
         Value           =   0   'False
         cBack           =   -2147483633
      End
      Begin VB.Label Label1 
         Caption         =   "Round Robin"
         Height          =   255
         Left            =   480
         TabIndex        =   5
         Top             =   480
         Width           =   1095
      End
   End
End
Attribute VB_Name = "Eventos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

