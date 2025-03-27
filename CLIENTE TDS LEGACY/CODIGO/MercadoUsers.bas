Attribute VB_Name = "MercadoUsers"
Option Explicit

Private Type tUserPublicado
    precio As Long        'Valor del pj
    'Subasta         As Boolean  'Es una subasta o un precio fijo?
    Nivel As Byte        'Level del pj
    Porcentaje As Byte        'Porcentaje del pj
    Nick As String        'Nick
    'Clan            As Integer 'Clan del pj, clanindex
    Vida As Integer        'Vida
    Clase As eClass        'Clase
    Raza As eRaza        'Raza
    Ocupado As Boolean        'Esta libre el slot?
    Privado As Boolean
End Type

Public UserMercado(1 To 50) As tUserPublicado
