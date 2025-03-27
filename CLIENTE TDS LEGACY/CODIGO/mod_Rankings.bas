Attribute VB_Name = "mod_Rankings"
Option Explicit

Private Type tUserRanking '' Estructura de datos para cada puesto del ranking
    Nick As String
    Value As Long
End Type
 
Private Type tRanking '' Estructura de 10 usuarios, cada tipo de ranking esta declarado con esta estructura
    user(1 To 10) As tUserRanking
End Type
 
Public Enum eRankings '' Cada ranking tiene un identificador.
    Retos1vs1 = 1
    Retos2vs2 = 2
    Retos3vs3 = 3
    Nivel = 4
    Matados = 5
End Enum
 
Public Const NumRanks As Byte = 5 ''Cuantos tipos de rankings existen (r1vs1, r2vs2, nivel, etc)


Public Rankings(1 To NumRanks) As tRanking ''Array con todos los tipos de ranking, _
                                            para identificar cada uno se usa el enum eRankings
                                            
                                            

