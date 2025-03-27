Attribute VB_Name = "Declaraciones"
Option Explicit

Public FUN As Boolean

Public Enum eRate
    cOro
    cExp
End Enum

Public FUN_Rates(1) As Single

Public GlobalActivo As Boolean

Public Enum eVentanas
    vInventario = 1
    vHechizos = 2
End Enum

Public IntClickU As Byte

Public ratePesca As Single
Public rateTala As Single
Public rateConstruccion As Single

Public useAntiCheatblock As Byte

Public MinutosLloviendo As Long
Public MinutosSinLluvia As Long

Public NOMBRE_TORNEO_ACTUAL As String
Public TOURNAMENT_ACTIVE As Byte

Public Administradores As clsIniManager
Public NPCS_Dat As clsIniManager
Public HoraMundo As Long
Public HoraActual As Integer
Public DuracionDia As Long

Public LluviaActiva As Byte
Public NewbiesCanDoPartyWithNoNewbies As Byte
Public CONFIG_INI_BONUSELVMIN As Byte
Public CONFIG_INI_BONUSNEEDACCOUNT As Byte
Public CONFIG_INI_MULTIEXP As Byte
Public CONFIG_INI_BONUSALLOWWORKERS As Byte
Public CONFIG_INI_ITEMS_SKILL_REQUIRED As Byte
Public CONFIG_INI_ALLOWMULTIWORKERS As Byte
Public CONFIG_INI_ALLOWMULTIWORKERS_STRICT As Byte
Public CONFIG_INI_IDLEKICKTOLERANCE As Integer
Public CONFIG_INI_IDLECREATEKICKTOLERANCE As Integer
Public CONFIG_INI_OROABILLE As Byte
Public CONFIG_INI_OROABILLE_Only10k As Byte
Public CONFIG_INI_INTMEDITAR As Integer
Public CONFIG_INI_SHOWONLINENAME As Byte
Public CONFIG_INI_RANDOMDICES As Byte
Public CONFIG_INI_SHOWRESETMESSAGE As Byte
Public CONFIG_INI_ESTRELLAENNICK As Byte
Public CONFIG_INI_STAREDUCTION As Byte



Public CONFIG_INI_DRUIDADMGMULTIPLIER As Double    '1.04
Public CONFIG_INI_BARDODMGMULTIPLIER As Double    '1.04
Public CONFIG_INI_HABILITARTORNEOS As Byte
Public CONFIG_INI_MULTIFIANZA As Integer

Public CONFIG_INI_RNDAPUCOMUN As Integer
Public CONFIG_INI_RNDAPUASE As Integer
Public CONFIG_INI_RNDAPUNPC As Integer

Public CONFIG_INI_DMGAPUCOMUN As Single
Public CONFIG_INI_DMGAPUASE As Single

Public CONFIG_INI_DMGAPUNPC As Single
Public CONFIG_INI_DMGAPUNPCASE As Single

Public CONFIG_INI_BORRARPJ As Byte



Public CONFIG_INI_RNDQUITAHAM As Integer
Public CONFIG_INI_RNDQUITASED As Integer

'// Retos 1.1 Plantes
Public RingData() As Position
Public RingCenter() As Position
Public PlantedData() As Position

'// Retos 2.2
Public RetoPos() As Position

Public aClon As New clsAntiMassClon

Public Const MAXSPAWNATTEMPS = 60
Public Const INFINITE_LOOPS As Integer = -1
Public Const FXSANGRE = 14

''
' The color of chats over head of dead characters.
Public Const CHAT_COLOR_DEAD_CHAR As Long = &HC0C0C0

''
' The color of yells made by any kind of game administrator.
Public Const CHAT_COLOR_GM_YELL As Long = &HF82FF

''
' Coordinates for normal sounds (not 3D, like rain)
Public Const NO_3D_SOUND As Byte = 0

Public Const iFragataFantasmal = 87
Public Const iFragataReal = 190
Public Const iFragataCaos = 189
Public Const iBarca = 84
Public Const iGalera = 85
Public Const iGaleon = 86
Public Const iBarcaCiuda = 395
Public Const iBarcaPk = 396
Public Const iGaleraCiuda = 397
Public Const iGaleraPk = 398
Public Const iGaleonCiuda = 399
Public Const iGaleonPk = 400

Public Enum iMinerales
    hierrocrudo = 192
    platacruda = 193
    orocrudo = 194
    LingoteDeHierro = 386
    LingoteDePlata = 387
    LingoteDeOro = 388
End Enum

Public Enum FaccionType
    ChaosCouncil = 1
    RoyalCouncil = 2
End Enum

Public Enum PlayerType
    User = 1        '&H1
    RoleMaster = 2      '= &H8
    Consejero = 3      '= &H10
    SemiDios = 4      '= &H20
    Dios = 5      '= &H40
    Admin = 6      '= &H80
End Enum

Public Enum eClass
    Mage = 1        'Mago
    Cleric = 2        'Clerigo
    Warrior = 3        'Guerrero
    Assasin = 4        'Asesino
    Thief = 5        'Ladrón
    Bard = 6        'Bardo
    Druid = 7        'Druida
    Paladin = 8        'Paladin
    Hunter = 9        'Cazador
    Fisherman = 10        'Pescador
    Blacksmith = 11        'Herrero
    Woodcutter = 12     'Leñador
    Miner = 13    'Minero
    Carpenter = 14    'Carpintero
    Pirat = 15     'Pirata
End Enum

Public Enum eCiudad
    cUllathorpe = 1
    cNix
    cBanderbill
    cLindos
    cArghal
End Enum

Public Enum eRaza
    Humano = 1
    Elfo
    Drow
    Gnomo
    Enano
End Enum

Enum eGenero
    Hombre = 1
    Mujer = 2
End Enum

Public Enum eClanType
    ct_RoyalArmy
    ct_Evil
    ct_Neutral
    ct_GM
    ct_Legal
    ct_Criminal
End Enum

Public Const LimiteNewbie As Byte = 12

Public Type tCabecera        'Cabecera de los con
    Desc As String * 255
    crc As Long
    MagicWord As Long
End Type

Public MiCabecera As tCabecera

Public Const NingunEscudo As Integer = 2
Public Const NingunCasco As Integer = 2
Public Const NingunArma As Integer = 2



Public Const IMPLORARAYUDA As Integer = 29
Public Const ESPIRITUINDOMABLE As Integer = 33



Public Const EspadaMataDragonesIndex As Integer = 402
Public Const LAUDMAGICO As Integer = 643
Public Const LAUDELFICO As Integer = 643
Public Const ESPADADEPLATA As Integer = 403


Public Const SABLE As Integer = 125
Public Const KATANA As Integer = 124

'Public Const FLAUTAMAGICA As Integer = 208
'Public Const FLAUTAELFICA As Integer = 1050

Public Const ANILLOMAGICO As Integer = 648

Public Const APOCALIPSIS_SPELL_INDEX As Integer = 25
Public Const DESCARGA_SPELL_INDEX As Integer = 23

Public Const SLOTS_POR_FILA As Byte = 5

Public Const PROB_ACUCHILLAR As Byte = 20
Public Const DAÑO_ACUCHILLAR As Single = 0.2

Public Const MAXMASCOTASENTRENADOR As Byte = 7

Public Enum FXIDs
    FXWARP = 1
    FXMEDITARCHICO = 4
    FXMEDITARMEDIANO = 5
    FXMEDITARGRANDE = 6
    FXMEDITARXGRANDE = 16
    FXMEDITARXXGRANDE = 16
End Enum

Public Const TIEMPO_CARCEL_PIQUETE As Long = 10

''
' TRIGGERS
'
' @param NADA nada
' @param BAJOTECHO bajo techo
' @param trigger_2 ???
' @param POSINVALIDA los npcs no pueden pisar tiles con este trigger
' @param ZONASEGURA no se puede robar o pelear desde este trigger
' @param ANTIPIQUETE
' @param ZONAPELEA al pelear en este trigger no se caen las cosas y no cambia el estado de ciuda o crimi
'
Public Enum eTrigger
    NADA = 0
    BajoTecho = 1
    trigger_2 = 2
    POSINVALIDA = 3
    ZONASEGURA = 4
    ANTIPIQUETE = 5
    ZONAPELEA = 6

    AutoResu = 7
    BAJOTECHO_Y_AUTO_RESU = 8
End Enum

''
' constantes para el trigger 6
'
' @see eTrigger
' @param TRIGGER6_PERMITE TRIGGER6_PERMITE
' @param TRIGGER6_PROHIBE TRIGGER6_PROHIBE
' @param TRIGGER6_AUSENTE El trigger no aparece
'
Public Enum eTrigger6
    TRIGGER6_PERMITE = 1
    TRIGGER6_PROHIBE = 2
    TRIGGER6_AUSENTE = 3
End Enum

'TODO : Reemplazar por un enum
Public Const Bosque As String = "BOSQUE"
Public Const Nieve As String = "NIEVE"
Public Const Desierto As String = "DESIERTO"
Public Const Ciudad As String = "CIUDAD"
Public Const Campo As String = "CAMPO"
Public Const Dungeon As String = "DUNGEON"
Public Const Retos As String = "RETOS"

' <<<<<< Targets >>>>>>
Public Enum TargetType
    uUsuarios = 1
    uNPC = 2
    uUsuariosYnpc = 3
    uTerreno = 4
End Enum

' <<<<<< Acciona sobre >>>>>>
Public Enum TipoHechizo
    uPropiedades = 1
    uEstado = 2
    uMaterializa = 3        'Nose usa
    uInvocacion = 4
End Enum

Public Const MAXUSERHECHIZOS As Byte = 35
Public Const MAXPENAS As Byte = 8


' TODO: Y ESTO ? LO CONOCE GD ?
Public Const EsfuerzoTalarGeneral As Byte = 5
Public Const EsfuerzoTalarLeñador As Byte = 3

Public Const EsfuerzoPescarPescador As Byte = 3
Public Const EsfuerzoPescarGeneral As Byte = 5

Public Const EsfuerzoExcavarMinero As Byte = 3
Public Const EsfuerzoExcavarGeneral As Byte = 5

Public Const FX_TELEPORT_INDEX As Integer = 1

Public Const PORCENTAJE_MATERIALES_UPGRADE As Single = 0.85

' La utilidad de esto es casi nula, sólo se revisa si fue a la cabeza...
Public Enum PartesCuerpo
    bCabeza = 1
    bPiernaIzquierda = 2
    bPiernaDerecha = 3
    bBrazoDerecho = 4
    bBrazoIzquierdo = 5
    bTorso = 6
End Enum

Public Const Guardias As Integer = 6

Public Const MAX_ORO_EDIT As Long = 500000000

Public Const STANDARD_BOUNTY_HUNTER_MESSAGE As String = "Se te ha otorgado un premio por ayudar a TDS Legacy reportando bugs, el mismo está disponible en tu bóveda."
Public Const TAG_USER_INVISIBLE As String = "|"
Public Const TAG_USER_OCULTO As String = "#"
Public Const TAG_CONSULT_MODE As String = "[CONSULTA]"

Public Const MAXREP As Long = 500000000
Public Const MAXORO As Long = 500000000
Public Const MAXEXP As Long = 1670680721

Public Const MAXUSERMATADOS As Long = 1000000

Public Const MAXATRIBUTOS As Byte = 38
Public Const MINATRIBUTOS As Byte = 6

Public Const LingoteHierro As Integer = 386
Public Const LingotePlata As Integer = 387
Public Const LingoteOro As Integer = 388
Public Const Leña As Integer = 58
Public Const LeñaTejo As Integer = 642

Public Const MAXNPCS As Integer = 10000
Public Const MAXCHARS As Integer = 10000

Public Const HACHA_LEÑADOR As Integer = 127
Public Const HACHA_DORADA As Integer = 630
Public Const PIQUETE_MINERO As Integer = 187
Public Const PIQUETE_MINERO_ORO As Integer = 685

Public Const DAGA As Integer = 15
Public Const FOGATA_APAG As Integer = 136
Public Const FOGATA As Integer = 63
Public Const ORO_MINA As Integer = 194
Public Const PLATA_MINA As Integer = 193
Public Const HIERRO_MINA As Integer = 192
Public Const MARTILLO_HERRERO As Integer = 389
Public Const SERRUCHO_CARPINTERO As Integer = 198
Public Const ObjArboles As Integer = 4
Public Const RED_PESCA As Integer = 543
Public Const CAÑA_PESCA As Integer = 138

Public Enum eNPCType
    Comun = 0
    Revividor = 1
    GuardiaReal = 2
    Entrenador = 3
    Banquero = 4
    Noble = 5
    DRAGON = 6
    Timbero = 7
    Guardiascaos = 8
    ResucitadorNewbie = 9
    Pretoriano = 10
    Gobernador = 11
    BorradorDePersonaje = 12
    ReseteadorDePersonaje = 13
End Enum

Public Const MIN_APUÑALAR As Byte = 10

'********** CONSTANTANTES ***********

''
' Cantidad de skills
Public Const NUMSKILLS As Byte = 21

''
' Cantidad de Atributos
Public Const NUMATRIBUTOS As Byte = 5

''
' Cantidad de Clases
Public Const NUMCLASES As Byte = 15

''
' Cantidad de Razas
Public Const NUMRAZAS As Byte = 5


''
' Valor maximo de cada skill
Public Const MAXSKILLPOINTS As Byte = 100

''
' Cantidad de Ciudades
Public Const NUMCIUDADES As Byte = 5


Public Type tTorneos
    Activo As Boolean
    EmpezoPelea As Boolean
    Cupos As Byte        'Cupos del torneo
    ActualCupos As Byte        'Cuantos cupos estan llenos?
    CuentaRegresiva As Byte
    ListaUsers() As Integer
    MaxRojas As Integer
    ClaseProhibida(1 To NUMCLASES) As Boolean
    NumProhibidas As Byte
End Type
''
'Direccion
'
' @param NORTH Norte
' @param EAST Este
' @param SOUTH Sur
' @param WEST Oeste
'
Public Enum eHeading
    NORTH = 1
    EAST = 2
    SOUTH = 3
    WEST = 4
End Enum

''
' Cantidad maxima de mascotas
Public Const MAXMASCOTAS As Byte = 3
Public Const FUEGOFATUO As Integer = 111

'%%%%%%%%%% CONSTANTES DE INDICES %%%%%%%%%%%%%%%
Public Const vlASALTO As Integer = 100
Public Const vlASESINO As Integer = 1000
Public Const vlCAZADOR As Integer = 5
Public Const vlNoble As Integer = 5
Public Const vlLadron As Integer = 25
Public Const vlProleta As Integer = 2

'%%%%%%%%%% CONSTANTES DE INDICES %%%%%%%%%%%%%%%
Public Const iCuerpoMuerto As Integer = 8
Public Const iCabezaMuerto As Integer = 500


Public Const iORO As Byte = 12
Public Const Pescado As Byte = 139

Public Enum PECES_POSIBLES
    PESCADO1 = 139
    PESCADO2 = 544
    PESCADO3 = 545
    PESCADO4 = 546
    PESCADO5 = 732
End Enum

'%%%%%%%%%% CONSTANTES DE INDICES %%%%%%%%%%%%%%%
Public Enum eSkill
    Magia = 1
    Robar = 2
    Tacticas = 3
    Armas = 4
    Meditar = 5
    Apuñalar = 6
    Ocultarse = 7
    Supervivencia = 8
    Talar = 9
    Comerciar = 10
    Defensa = 11
    Pesca = 12
    Mineria = 13
    Carpinteria = 14
    Herreria = 15
    Liderazgo = 16
    Domar = 17
    proyectiles = 18
    Wrestling = 19
    Navegacion = 20
    ResistenciaMagica = 21
End Enum

Public Const FundirMetal = 88

Public Enum eAtributos
    Fuerza = 1
    Agilidad = 2
    Inteligencia = 3
    Carisma = 4
    Constitucion = 5
End Enum

Public Const AdicionalHPGuerrero As Byte = 2        'HP adicionales cuando sube de nivel
Public Const AdicionalHPCazador As Byte = 1        'HP adicionales cuando sube de nivel

Public Const AumentoSTDef As Byte = 15
Public Const AumentoSTLadron As Byte = AumentoSTDef + 3
Public Const AumentoSTMago As Byte = AumentoSTDef - 1
Public Const AumentoSTTrabajador As Byte = AumentoSTDef + 25

'Tamaño del mapa
Public Const XMaxMapSize As Byte = 100
Public Const XMinMapSize As Byte = 1
Public Const YMaxMapSize As Byte = 100
Public Const YMinMapSize As Byte = 1

'Tamaño del tileset
Public Const TileSizeX As Byte = 32
Public Const TileSizeY As Byte = 32

'Tamaño en Tiles de la pantalla de visualizacion
Public Const XWindow As Byte = 17
Public Const YWindow As Byte = 13

'Sonidos
Public Const SND_SWING As Byte = 2
Public Const SND_TALAR As Byte = 13
Public Const SND_PESCAR As Byte = 14
Public Const SND_MINERO As Byte = 15
Public Const SND_WARP As Byte = 3
Public Const SND_PUERTA As Byte = 5
Public Const SND_NIVEL As Byte = 6

Public Const SND_USERMUERTE As Byte = 11
Public Const SND_IMPACTO As Byte = 10
Public Const SND_IMPACTO2 As Byte = 12
Public Const SND_LEÑADOR As Byte = 13
Public Const SND_FOGATA As Byte = 14
Public Const SND_AVE As Byte = 21
Public Const SND_AVE2 As Byte = 22
Public Const SND_AVE3 As Byte = 34
Public Const SND_GRILLO As Byte = 28
Public Const SND_GRILLO2 As Byte = 29
Public Const SND_SACARARMA As Byte = 25
Public Const SND_ESCUDO As Byte = 37
Public Const MARTILLOHERRERO As Byte = 41
Public Const LABUROCARPINTERO As Byte = 42
Public Const SND_BEBER As Byte = 46

''
' Cantidad maxima de objetos por slot de inventario
Public Const MAX_INVENTORY_OBJS As Integer = 10000

''
Public Const MAX_INVENTORY_SLOTS As Byte = 30

''
' Cantidad de "slots" en el inventario sin mochila
Public Const MAX_NORMAL_INVENTORY_SLOTS As Byte = 20

''
' Constante para indicar que se esta usando ORO
Public Const FLAGORO As Integer = MAX_INVENTORY_SLOTS + 1


' CATEGORIAS PRINCIPALES
Public Enum eOBJType
    otUseOnce = 1
    otWeapon = 2
    otArmadura = 3
    otArboles = 4
    otGuita = 5
    otPuertas = 6
    otContenedores = 7
    otCarteles = 8
    otLlaves = 9
    otPociones = 11
    otBebidas = 13
    otLeña = 14
    otFogata = 15
    otEscudo = 16
    otCASCO = 17
    otAnillo = 18
    otTeleport = 19
    otYacimiento = 22
    otMinerales = 23
    otPergaminos = 24
    otInstrumentos = 26
    otYunque = 27
    otFragua = 28
    otBarcos = 31
    otFlechas = 32
    otBotellaVacia = 33
    otBotellaLlena = 34
    otManchas = 35        'No se usa
    otArbolElfico = 36
    otAnillo2 = 38
    otCualquiera = 1000
End Enum

'Texto
Public Const FONTTYPE_TALK As String = "~255~255~255~0~0"
Public Const FONTTYPE_FIGHT As String = "~255~0~0~1~0"
Public Const FONTTYPE_WARNING As String = "~32~51~223~1~1"
Public Const FONTTYPE_INFO As String = "~65~190~156~0~0"
Public Const FONTTYPE_INFOBOLD As String = "~65~190~156~1~0"
Public Const FONTTYPE_EJECUCION As String = "~130~130~130~1~0"
Public Const FONTTYPE_VENENO As String = "~0~255~0~0~0"
Public Const FONTTYPE_GUILD As String = "~255~255~255~1~0"
Public Const FONTTYPE_SERVER As String = "~0~185~0~0~0"
Public Const FONTTYPE_GUILDMSG As String = "~228~199~27~0~0"
Public Const FONTTYPE_CONSEJO As String = "~130~130~255~1~0"
Public Const FONTTYPE_CONSEJOCAOS As String = "~255~60~00~1~0"
Public Const FONTTYPE_CONSEJOVesA As String = "~0~200~255~1~0"
Public Const FONTTYPE_CONSEJOCAOSVesA As String = "~255~50~0~1~0"
Public Const FONTTYPE_CENTINELA As String = "~0~255~0~1~0"

'Estadisticas
Public Const STAT_MAXELV As Byte = 47
Public Const STAT_MAXHP As Integer = 999
Public Const STAT_MAXSTA As Integer = 999
Public Const STAT_MAXMAN As Integer = 9999

Public Const STAT_MAXDEF As Byte = 99

Public Const ELU_SKILL_INICIAL As Byte = 200
Public Const EXP_ACIERTO_SKILL As Byte = 50
Public Const EXP_FALLO_SKILL As Byte = 20

' **************************************************************
' **************************************************************
' ************************ TIPOS *******************************
' **************************************************************
' **************************************************************

Public Type tHechizo
    Nombre As String
    Desc As String
    PalabrasMagicas As String

    HechizeroMsg As String
    TargetMsg As String
    PropioMsg As String

    '    Resis As Byte

    tipo As TipoHechizo

    WAV As Integer
    FXgrh As Integer
    GrhTravel As Integer
    loops As Byte

    SubeHP As Byte
    MinHP As Integer
    MaxHP As Integer

    SubeMana As Byte
    MiMana As Integer
    MaMana As Integer

    SubeSta As Byte
    minSta As Integer
    MaxSta As Integer

    SubeHam As Byte
    MinHam As Integer
    MaxHam As Integer

    SubeSed As Byte
    MinSed As Integer
    MaxSed As Integer

    SubeAgilidad As Byte
    MinAgilidad As Integer
    MaxAgilidad As Integer

    SubeFuerza As Byte
    MinFuerza As Integer
    MaxFuerza As Integer

    SubeCarisma As Byte
    MinCarisma As Integer
    MaxCarisma As Integer

    Invisibilidad As Byte
    Paraliza As Byte
    Inmoviliza As Byte
    RemoverParalisis As Byte
    RemoverEstupidez As Byte
    CuraVeneno As Byte
    Envenena As Byte
    Estupidez As Byte
    Ceguera As Byte
    Revivir As Byte
    Morph As Byte
    Mimetiza As Byte
    RemueveInvisibilidadParcial As Byte

    Warp As Byte
    Invoca As Byte
    NumNpc As Integer
    Cant As Long

    '    Materializa As Byte
    '    ItemIndex As Byte

    MinSkill As Integer
    ManaRequerido As Integer

    'Barrin 29/9/03
    StaRequerido As Integer

    Target As TargetType

    NeedStaff As Integer
    StaffAffected As Boolean
End Type

Public Const NPC_CENTINELA As Integer = 117

Public Type LevelSkill
    LevelValue As Integer
End Type


Public Enum eTrabajos
    Ninguno = 0
    Pesca = 1
    Tala = 2
    Mineria = 3
    Fundicion = 4
    Herreria = 5
    Carpinteria = 6
End Enum

Public Type UserOBJ
    ObjIndex As Integer
    Amount As Integer
    Equipped As Byte
    RareDrop As Byte
End Type

Public Type Inventario
    Object(1 To MAX_INVENTORY_SLOTS) As UserOBJ
    WeaponEqpObjIndex As Integer
    WeaponEqpSlot As Byte
    ArmourEqpObjIndex As Integer
    ArmourEqpSlot As Byte
    EscudoEqpObjIndex As Integer
    EscudoEqpSlot As Byte
    CascoEqpObjIndex As Integer
    CascoEqpSlot As Byte
    MunicionEqpObjIndex As Integer
    MunicionEqpSlot As Byte
    AnilloEqpObjIndex As Integer
    AnilloEqpSlot As Byte
    AnilloEqpObjIndex2 As Integer
    AnilloEqpSlot2 As Byte
    BarcoObjIndex As Integer
    BarcoSlot As Byte
    NroItems As Integer        'npc only..
End Type

Public Type Position
    X As Integer
    Y As Integer
End Type

Public Type WorldPos
    Map As Integer
    X As Integer
    Y As Integer
    Radio As Integer
End Type

Public Type FXdata
    Nombre As String
    GrhIndex As Integer
    Delay As Integer
End Type

'Datos de user o npc
Public Type Char

    CharIndex As Integer
    Head As Integer
    body As Integer

    WeaponAnim As Integer
    ShieldAnim As Integer
    CascoAnim As Integer

    FX As Integer
    loops As Integer

    Heading As eHeading
End Type

Public Type tmp_tObj
    ObjIndex As Integer
    Amount As Long
End Type

Public Type tCofresObj
    Cant As Byte        'max 255 items dropeables

    Obj() As tmp_tObj        'este struct guarda .ObjIndex y .Amount
    prob() As Byte        'probabilidad de cada objeto
End Type

'Tipos de objetos
Public Type ObjData
    Cofre As tCofresObj

    abriga As Byte
    Name As String        'Nombre del obj

    WavAlCrear As Integer

    OBJType As eOBJType        'Tipo enum que determina cuales son las caract del obj
    LeñaIndex As Integer

    GrhIndex As Integer        ' Indice del grafico que representa el obj
    GrhSecundario As Integer

    'Solo contenedores
    MaxItems As Integer
    Conte As Inventario
    Apuñala As Byte
    Acuchilla As Byte

    ' @@ Nuevos
    MagiaSkill As Byte
    RMSkill As Byte
    ArmaSkill As Byte
    ArcoSkill As Byte
    EscudoSkill As Byte
    ArmaduraSkill As Byte
    DagaSkill As Byte
    QuitaEnergia As Integer
    ' @@ Nuevos

    isDosManos As Byte

    HechizoIndex As Integer

    MinHP As Integer
    MaxHP As Integer

    MineralIndex As Integer
    LingoteInex As Integer


    proyectil As Integer
    Municion As Integer

    Crucial As Byte
    Newbie As Integer

    Alineacion As Byte

    'Puntos de Stamina que da
    minSta As Integer        ' Minimo puntos de stamina

    'Pociones
    TipoPocion As Byte
    MaxModificador As Integer
    MinModificador As Integer
    DuracionEfecto As Long
    MinSkill As Integer
    LingoteIndex As Integer

    MinHIT As Integer        'Minimo golpe
    MaxHIT As Integer        'Maximo golpe

    MinHam As Integer
    MinSed As Integer

    def As Integer
    MinDef As Integer        ' Armaduras
    MaxDef As Integer        ' Armaduras

    Ropaje As Integer        'Indice del grafico del ropaje

    WeaponAnim As Integer        ' Apunta a una anim de armas
    WeaponRazaEnanaAnim As Integer
    ShieldAnim As Integer        ' Apunta a una anim de escudo
    CascoAnim As Integer

    Valor As Long        ' Precio

    Cerrada As Integer
    Llave As Byte
    clave As Long        'si clave=llave la puerta se abre o cierra

    Radio As Integer        ' Para teleps: El radio para calcular el random de la pos destino



    Guante As Byte        ' Indica si es un guante o no.

    IndexAbierta As Integer
    IndexCerrada As Integer
    IndexCerradaLlave As Integer

    RazaEnana As Byte
    RazaDrow As Byte
    RazaElfa As Byte
    RazaGnoma As Byte
    RazaHumana As Byte

    Mujer As Byte
    Hombre As Byte

    Envenena As Byte
    Paraliza As Byte

    Agarrable As Byte

    LingH As Integer
    LingO As Integer
    LingP As Integer
    Madera As Integer
    MaderaDeTejo As Integer

    SkHerreria As Integer
    SkCarpinteria As Integer

    texto As String

    'Clases que no tienen permitido usar este obj
    ClaseProhibida(1 To NUMCLASES) As eClass

    Snd1 As Integer
    Snd2 As Integer
    Snd3 As Integer

    Real As Integer
    Caos As Integer

    NoSeCae As Integer
    NoSeSaca As Byte

    StaffPower As Integer
    StaffDamageBonus As Integer
    DefensaMagicaMax As Integer
    DefensaMagicaMin As Integer
    Refuerzo As Byte

    Log As Byte        'es un objeto que queremos loguear? Pablo (ToxicWaste) 07/09/07
    NoLog As Byte        'es un objeto que esta prohibido loguear?

    Upgrade As Integer
    Numero As Integer
End Type

Public Type Obj
    ObjIndex As Integer
    Amount As Integer
End Type

'[Pablo ToxicWaste]
Public Type ModClase
    Evasion As Double
    AtaqueArmas As Double
    AtaqueProyectiles As Double
    AtaqueWrestling As Double
    DañoArmas As Double
    DañoProyectiles As Double
    DañoWrestling As Double
    Escudo As Double
    Magia As Double
End Type

Public Type ModRaza
    Fuerza As Single
    Agilidad As Single
    Inteligencia As Single
    Carisma As Single
    Constitucion As Single
End Type

'[/Pablo ToxicWaste]

'[KEVIN]
'Banco Objs
Public Const MAX_BANCOINVENTORY_SLOTS As Byte = 40
'[/KEVIN]

'[KEVIN]
Public Type BancoInventario
    Object(1 To MAX_BANCOINVENTORY_SLOTS) As UserOBJ
    'NroItems As Integer
End Type
'[/KEVIN]

' Determina el color del nick
Public Enum eNickColor
    ieCriminal = &H1
    ieCiudadano = &H2
End Enum

Public Type tReputacion        'Fama del usuario
    NobleRep As Long
    BurguesRep As Long
    PlebeRep As Long
    LadronesRep As Long
    BandidoRep As Long
    AsesinoRep As Long
    Promedio As Long
End Type

Public Type tQuestNpc
    NpcIndex As Integer
    Amount As Long
End Type

Public Type tUserQuest        '
    NPCsKilled() As Integer
    UsersKilled As Integer
    QuestIndex As Integer
End Type

Public Type tQuestStats

    Quests(1 To MAXUSERQUESTS) As tUserQuest
    NumQuestsDone As Integer
    QuestsDone() As Integer

End Type

Public Type tQuest        ' Configuración de la Quest
    Nombre As String
    Desc As String
    RequiredLevel As Byte
    RequiredOBJs As Byte
    RequiredOBJ() As Obj
    RequiredNPCs As Byte
    RequiredNPC() As tQuestNpc
    RequiredKills As Integer
    RequiredFaccion As Byte
    RequiredFaccion_Rango As Byte

    RewardPoints As Long
    RewardGLD As Long
    RewardEXP As Long
    RewardOBJs As Byte
    RewardOBJ() As Obj

    AvisaConsola As Byte
    AvisaConsolaMsg As String

End Type

Public QuestList() As tQuest        ' GSZAO

'Estadisticas de los usuarios
Public Type UserStats
    Penas(1 To 8) As String
    CantPenas As Byte

    RetosGanados As Long
    RetosPerdidos As Long

    PuntosFotodenuncia As Long
    FundoClan As Long
    DisolvioClan As Long

    OroGanado As Double
    OroPerdido As Double

    GLD As Long        'Dinero
    Banco As Long

    MaxHP As Long
    MinHP As Long

    MaxSta As Long
    minSta As Long
    MaxMAN As Long
    MinMAN As Long
    MaxHIT As Long
    MinHIT As Long

    MaxHam As Integer
    MinHam As Integer

    MaxAGU As Integer
    MinAGU As Integer

    def As Integer
    Exp As Double
    ELV As Byte
    elu As Long
    UserSkills(1 To NUMSKILLS) As Byte
    UserAtributos(1 To NUMATRIBUTOS) As Byte
    UserAtributosBackUP(1 To NUMATRIBUTOS) As Byte
    UserHechizos(1 To MAXUSERHECHIZOS) As Integer

    ParticipoClanes As Byte

    UsuariosMatados As Long
    CriminalesMatados As Long
    NPCsMuertos As Long

    SkillPts As Integer
    AsignoSkills As Integer

    ExpSkills(1 To NUMSKILLS) As Long
    EluSkills(1 To NUMSKILLS) As Long

End Type

'Flags
Public Type UserFlags

    ' 0.13.3
    ParalizedBy As String
    ParalizedByIndex As Integer
    ParalizedByNpcIndex As Integer

    LastSlotPotion As Byte
    LastSlotClient As Byte
    MenuCliente As Byte

    Trabajando As Boolean

    serialHD As Long

    T2vs2 As tTorneoUserStruct
    EnEvento As Byte
    
    commerce_npc_slot_index As Byte
    commerce_npc_npcindex As Integer
    mao_index As Long
    char_locked_in_mao As Byte
    ups As Byte

    lastPos As WorldPos
    GlobalOn As Boolean
    GlobalTick As Long

    CuentaPq As Long

    UserInEvent As Boolean
    ModoCombate As Boolean
    Puntos As Integer
    ExClan As Integer
    Muerto As Byte        '¿Esta muerto?
    Escondido As Byte        '¿Esta escondido?
    Comerciando As Boolean        '¿Esta comerciando?
    UserLogged As Boolean        '¿Esta online?
    Meditando As Boolean
    Hambre As Byte
    Sed As Byte
    PuedeTrabajar As Byte
    Envenenado As Byte
    Paralizado As Byte
    Inmovilizado As Byte
    Estupidez As Byte
    Ceguera As Byte
    invisible As Byte
    oculto As Byte
    Desnudo As Byte
    Descansar As Boolean
    Hechizo As Integer
    TomoPocion As Boolean
    TipoPocion As Byte

    NoPuedeSerAtacado As Boolean
    ShareNpcWith As Integer

    Navegando As Byte
    Seguro As Boolean
    SeguroResu As Boolean
    BlockDragItems As Boolean

    DuracionEfecto As Long
    TargetNPC As Integer        ' Npc señalado por el usuario
    TargetNpcTipo As eNPCType        ' Tipo del npc señalado
    OwnedNpc As Integer        ' Npc que le pertenece (no puede ser atacado)

    Ban As Byte

    TargetUser As Integer        ' Usuario señalado
    
    TargetGuildIndex As Integer        ' Usuario señalado
    
    TargetObj As Integer        ' Obj señalado
    TargetObjMap As Integer
    TargetObjX As Integer
    TargetObjY As Integer

    TargetBot As Byte

    TargetMap As Integer
    TargetX As Integer
    TargetY As Integer

    TargetObjInvIndex As Integer
    TargetObjInvSlot As Integer

    AttackedFirstBy As String

    AtacadoPorNpc As Integer
    AtacadoPorUser As Integer
    NPCAtacado As Integer
    Ignorado As Boolean

    EnConsulta As Boolean

    Privilegios As PlayerType

    LastCrimMatado As String
    LastCiudMatado As String

    OldBody As Integer
    OldHead As Integer
    AdminInvisible As Byte
    AdminPerseguible As Boolean

    ChatColor As Long

    TimesWalk As Long
    StartWalk As Long
    CountSH As Long

    UltimoMensaje As Byte

    Silenciado As Byte

    Mimetizado As Byte
    Mimetizado_Nick As String
    Mimetizado_Color As Byte

    CentinelaOK As Boolean        'Centinela
    CentinelaReaction As Long

    lastMap As Integer

End Type

Private Type tSeguridad
    Poteo As Long
    Dck As Long
    Lanzar As Long
    Tirar As Long
End Type

Public Type UserCounters


    TickSoundPotions As Long
    TickReactionRemoInv As Long
    TickVelocityMenu As Long
    TickReactionInv As Long


    OnConnectTimeStamp As Long

    PacketCount As Long
    TimerLanzarSpell As Long

    TimeLastReset As Long
    TimerUsarClick As Long
    TimerCaminar As Long
    TimerTirar As Long



    tBonif As Long
    LeveleandoTick As Long

    Seguridad As tSeguridad

    tInicioMeditar As Long
    IdleCount As Long
    AttackCounter As Long
    HPCounter As Long
    STACounter As Long
    Frio As Long
    Lava As Long
    COMCounter As Long
    AGUACounter As Long
    Veneno As Long
    Paralisis As Long
    Ceguera As Long
    Estupidez As Long

    Invisibilidad As Long
    TiempoOculto As Long
    ultimoIntentoOcultar As Long

    Mimetismo As Integer
    PiqueteC As Long
    Pena As Long
    lastPos As Long
    SendMapCounter As WorldPos
    '[Gonzalo]
    Saliendo As Boolean
    ForceDeslog As Long

    Salir As Integer
    '[/Gonzalo]

    'Barrin 3/10/03
    bPuedeMeditar As Boolean
    'Barrin

    TimerPuedeAtacar As Long
    TimerPuedeUsarArco As Long
    TimerPuedeTrabajar As Long
    TimerUsar As Long
    TimerMagiaGolpe As Long
    TimerGolpeMagia As Long
    TimerGolpeUsar As Long
    TimerPuedeSerAtacado As Long
    TimerPerteneceNpc As Long

    CooldownCentinela As Long

    Trabajando As Long        ' Para el centinela
    Ocultando As Long        ' Unico trabajo no revisado por el centinela

    failedUsageAttempts As Long
    LastPoteo As Long

    goHome As Long
    AsignedSkills As Byte
End Type

'Cosas faccionarias.
Public Type tFacciones
    ArmadaReal As Byte
    FuerzasCaos As Byte
    CriminalesMatados As Long
    CiudadanosMatados As Long
    RecompensasReal As Long
    RecompensasCaos As Long
    RecibioExpInicialReal As Byte
    RecibioExpInicialCaos As Byte
    RecibioArmaduraReal As Byte
    RecibioArmaduraCaos As Byte
    Reenlistadas As Byte
    NivelIngreso As Integer
    FechaIngreso As String
    MatadosIngreso As Long        'Para Armadas nada mas

    Status As FaccionType

End Type

Public Type tCrafting
    cantidad As Long
    PorCiclo As Integer
End Type

Public Type UserReto_Struct
    Reto_Index As Byte

    IndexRecieve As Integer
    IndexSender As Integer
    ReturnHome As Byte
    AcceptLimitCount As Byte

    Tmp_Gold As Long
    Tmp_Planted As Byte
    Tmp_Drop As Byte
    Tmp_Potions As Integer
    Tmp_Aim As Byte
    Tmp_CascoEscu As Byte
    Tmp_Rounds As Byte
End Type

Private Type eXvsX
    Team_ID As Byte
    Slot_ID As Byte
    Respawn_Time As Byte
End Type


Public Type tRango
    minimo As Integer
    maximo As Integer
End Type



' @@ TDS Extraction
Type tTrabajo
    tipo As eSkill    'Tipo de trabajo
    modo As Integer    'Red de pesca o caña, hacha dorada o comun
    cantidad As Integer    'Cantidad para hacer. Necesesario en
    modificador As Integer    'Probabilidad de que el trabajo de sus frutos, o cantidad (maxima) que puede hacer cada vez que trabaja
    rangoGeneracion As tRango    'Minimo y maximo de elementos que puede generar
End Type

'Tipo de los Usuarios
Public Type User
    
    ' @@ Feo feo..
    InCVCID As Byte
    cvc_MaxUsers As Byte
        
    InBotID As Byte
    
    QuestStats As tQuestStats

    CountDetectionErr As Byte
    CantErr As Byte
    ErrSpell As Byte

    LastHechiSelected As Byte

    IsFull_MANA As Byte
    CountAutoBlues As Byte

    IsFull_HP As Byte
    CountAutoRed As Byte

    Trabajo As tTrabajo

    UserIndex As Integer

    HD_Check As Byte

    HD_Creator As Long
    HD_Last As Long

    HD_TmpName As String
    StaticHD(1 To 5) As Long

    IP_LastKill As String
    AntiFrags(0 To MAX_CONTROL_FRAGS) As tAntiFrags

    BadPackets As Long
    DelayBuy As Long

    Account As String

    Pin As String
    Pass As String
    LastSTA As Integer
    LastMAN As Integer
    LastHP As Long
    LastGLD As Long
    LastEXP As Long

    EnEvento As Boolean
    ACht As tAnticheat
    PartyIndex As Byte        'index a la party q es miembro
    PartyRequest As Byte        'index a la party q solicito

    LastMedit As Long
    Name As String
    ID As Long

    ' @@ Events
    Slot_ID As Long
    XvsX As eXvsX
    ' @@ Events

    ' ++ Mas power xd
    mLastKeyDrop As Byte
    mLastKeyUseItem As Byte


    showName As Boolean        'Permite que los GMs oculten su nick con el comando /SHOWNAME

    Char As Char        'Define la apariencia
    CharMimetizado As Char
    OrigChar As Char

    Desc As String        ' Descripcion
    DescRM As String

    Clase As eClass
    raza As eRaza
    Genero As eGenero
    Email As String
    Hogar As eCiudad

    Invent As Inventario

    Pos As WorldPos

    ConnIDValida As Boolean
    ConnID As Long        'ID

    '[KEVIN]
    BancoInvent As BancoInventario
    '[/KEVIN]

    Counters As UserCounters

    Construir As tCrafting

    MascotasIndex(1 To MAXMASCOTAS) As Integer
    MascotasType(1 To MAXMASCOTAS) As Integer
    TargetUserID As Integer

    nroMascotas As Integer

    Stats As UserStats
    flags As UserFlags

    Reputacion As tReputacion

    faccion As tFacciones

    #If ConUpTime Then
    LogOnTime As Date
    UpTime As Long
    #End If

    IP As String

    ComUsu As tCOmercioUsuario

    GuildIndex As Integer        'puntero al array global de guilds
    FundandoGuildAlineacion As ALINEACION_GUILD        'esto esta aca hasta que se parchee el cliente y se pongan cadenas de datos distintas para cada alineacion
    EscucheClan As Integer

    KeyCrypt As Integer

    AreasInfo As AreaInfo

    sReto As UserStruct        '2vs2
    mReto As UserReto_Struct

    CurrentInventorySlots As Byte
    
    Connection As Network_Client
    
End Type


'*********************************************************
'*********************************************************
'*********************************************************
'*********************************************************
'**  T I P O S   D E    N P C S **************************
'*********************************************************
'*********************************************************
'*********************************************************
'*********************************************************

Public Type NPCStats
    Alineacion As Integer
    MaxHP As Long
    MinHP As Long
    MaxHIT As Integer
    MaxHITInvocable As Integer
    MinHIT As Integer
    def As Integer
    defM As Integer
End Type

Public Type NpcCounters
    Paralisis As Integer
    TiempoExistencia As Long
    Ataque As Long
End Type

Public Type NPCFlags
    TargetUserID As Integer
    AttackedFirstBy As String
    AttackedBy As String

    AfectaParalisis As Byte
    Domable As Integer
    Respawn As Byte
    NPCActive As Boolean        '¿Esta vivo?
    Follow As Boolean
    faccion As Byte
    LanzaSpells As Byte

    ExpCount As Long

    OldMovement As TipoAI
    OldHostil As Byte

    AguaValida As Byte
    TierraInvalida As Byte
    OscuroInvalido As Byte

    Sound As Integer

    backup As Byte
    RespawnOrigPos As Byte

    Envenenado As Byte
    Paralizado As Byte
    Inmovilizado As Byte
    invisible As Byte
    Snd1 As Integer
    Snd2 As Integer
    Snd3 As Integer
End Type

Public Type tCriaturasEntrenador
    NpcIndex As Integer
    NpcName As String
End Type

' New type for holding the pathfinding info
Public Type NpcPathFindingInfo
    path() As tVertice        ' This array holds the path
    Target As Position        ' The location where the NPC has to go
    PathLenght As Integer        ' Number of steps *
    CurPos As Integer        ' Current location of the npc
    TargetUser As Integer        ' UserIndex chased
    NoPath As Boolean        ' If it is true there is no path to the target location

    '* By setting PathLenght to 0 we force the recalculation
    '  of the path, this is very useful. For example,
    '  if a NPC or a User moves over the npc's path, blocking
    '  its way, the function NpcLegalPos set PathLenght to 0
    '  forcing the seek of a new path.

End Type
' New type for holding the pathfinding info

Public Type tDrops
    ObjIndex As Integer
    Amount As Long
End Type

Private Type tSpell
    SpellID As Integer
    Probability As Byte
End Type

Public Const MAX_NPC_DROPS As Byte = 5

Public Type npc

    QuestNumber As Integer

    GolpeExacto As Byte    'TDS

    Name As String
    Char As Char        'Define como se vera
    Desc As String

    NPCtype As eNPCType
    Numero As Integer

    InvReSpawn As Byte

    Comercia As Integer
    Target As Long
    TargetNPC As Long
    TipoItems As Integer

    Veneno As Byte

    Pos As WorldPos        'Posicion
    Orig As WorldPos
    SkillDomar As Integer

    Movement As TipoAI
    Attackable As Byte
    Hostile As Byte
    PoderAtaque As Long
    PoderEvasion As Long

    Owner As Integer

    GiveEXP As Long
    GiveEXP_Orig As Long
    GiveGLD As Long
    GiveGLD_Orig As Long
    Drop(1 To MAX_NPC_DROPS) As tDrops

    Stats As NPCStats
    flags As NPCFlags
    Contadores As NpcCounters

    Invent As Inventario

    NroExpresiones As Byte
    Expresiones() As String        ' le da vida ;)

    NroSpells As Byte

    Spells() As tSpell

    '<<<<Entrenadores>>>>>
    NroCriaturas As Integer
    Criaturas() As tCriaturasEntrenador
    MaestroUser As Integer
    MaestroNpc As Integer
    Mascotas As Integer

    ' New!! Needed for pathfindig
    PFINFO As NpcPathFindingInfo
    AreasInfo As AreaInfo

    'Hogar
    Ciudad As Byte
    npcTradingArray() As Integer
    HasUserInCommerce As Boolean

    Invocable As Byte

End Type

'**********************************************************
'**********************************************************
'******************** Tipos del mapa **********************
'**********************************************************
'**********************************************************
'Tile
Public Type MapBlock
    Blocked As Byte
    Graphic(1 To 4) As Integer
    UserIndex As Integer
    NpcIndex As Integer
    ObjInfo As Obj
    TileExit As WorldPos
    trigger As eTrigger
    limpSlot As Long

    BotIndex As Integer
    DeQuienEs As String
End Type

'Info del mapa
Type MapInfo
    NumUsers As Integer
    music As String
    Name As String
    StartPos As WorldPos
    MapVersion As Integer
    pk As Boolean
    MagiaSinEfecto As Byte
    NoEncriptarMP As Byte
    InviSinEfecto As Byte
    ResuSinEfecto As Byte

    InvocarSinEfecto As Byte

    RoboNpcsPermitido As Byte        'PermiteRoboNPC=1

    Terreno As String
    Zona As String
    Restringir As String
    backup As Byte

    WarpOnDisconnect As WorldPos

    Nivel As Byte
    Frio As Byte

End Type


'********** V A R I A B L E S     P U B L I C A S ***********

Public SERVERONLINE As Boolean
Public ULTIMAVERSION As String
Public backup As Boolean        ' TODO: Se usa esta variable ?

Public ListaRazas(1 To NUMRAZAS) As String
Public SkillsNames(1 To NUMSKILLS) As String
Public ListaClases(1 To NUMCLASES) As String
Public ListaAtributos(1 To NUMATRIBUTOS) As String

Public Const MATRIX_INITIAL_MAP As Integer = 1


Public RecordUsuarios As Long

'
'Directorios
'

''
'Ruta base del server, en donde esta el "server.ini"
Public IniPath As String

''
'Ruta base para guardar los chars
Public CharPath As String

'Ruta base para borrar los chars
Public CharPathDeleted As String

''
'Ruta base para los archivos de mapas
Public MapPath As String

''
'Ruta base para los DATs
Public DatPath As String

''
'Ruta base para las cuentas
Public AccPath As String


Public LogUserPath As String

''
'Bordes del mapa
Public MinXBorder As Byte
Public MaxXBorder As Byte
Public MinYBorder As Byte
Public MaxYBorder As Byte

''
'Numero de usuarios actual
Public NumUsers As Integer
Public LastUser As Integer
Public LastChar As Integer
Public NumChars As Integer
Public LastNPC As Integer
Public NumNPCs As Integer
Public NumFX As Integer
Public NumMaps As Integer
Public NumObjDatas As Integer
Public NumeroHechizos As Integer
Public AllowMultiLogins As Byte
Public IdleLimit As Integer
Public maxUsers As Integer
Public HideMe As Byte
Public LastBackup As String
Public Minutos As String
Public haciendoBK As Boolean
Public PuedeCrearPersonajes As Integer
Public ServerSoloGMs As Integer

''
'Esta activada la verificacion MD5 ?
Public MD5ClientesActivado As Byte


Public EnPausa As Boolean


'*****************ARRAYS PUBLICOS*************************
Public BanHDs As Collection

Public UserList() As User        'USUARIOS

Public PjsAUpdatear() As User
Public totPjsAUpdatear As Long

Public PjsAUpdatear_MAO() As User
Public totPjsAUpdatear_MAO As Long

Public Npclist(1 To MAXNPCS) As npc
Public NpcInfo(1 To MAXNPCS) As npc
Public MapData() As MapBlock
Public MapInfo() As MapInfo

Public Hechizos() As tHechizo
Public CharList(1 To MAXCHARS) As Integer
Public ObjData() As ObjData
Public FX() As FXdata
Public SpawnList() As tCriaturasEntrenador
Public LevelSkill(1 To 50) As LevelSkill
Public ForbidenNames() As String
Public ArmasHerrero() As Integer
Public ArmadurasHerrero() As Integer
Public ObjCarpintero() As Integer
Public MD5s() As String

Public Parties(1 To MAX_PARTIES) As clsParty
Public ModClase(1 To NUMCLASES) As ModClase
Public ModRaza(1 To NUMRAZAS) As ModRaza
Public ModVida(1 To NUMCLASES) As Double
Public DistribucionEnteraVida(1 To 5) As Integer
Public DistribucionSemienteraVida(1 To 4) As Integer
Public Ciudades(1 To NUMCIUDADES) As WorldPos
Public distanceToCities() As HomeDistance
'*********************************************************

Type HomeDistance
    distanceToCity(1 To 5) As Integer
End Type

Public Nix As WorldPos
Public Ullathorpe As WorldPos
Public Banderbill As WorldPos
Public Lindos As WorldPos
Public Arghal As WorldPos

Public Prision As WorldPos
Public Libertad As WorldPos

Public Ayuda As New cCola

Public SonidosMapas As New SoundMapInfo

Public Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nsize As Long, ByVal lpfilename As String) As Long

Public Declare Sub ZeroMemory Lib "kernel32.dll" Alias "RtlZeroMemory" (ByRef destination As Any, ByVal length As Long)

Public Enum e_ObjetosCriticos
    Manzana = 1
    Manzana2 = 2
    ManzanaNewbie = 467
End Enum

Public Enum eMessages
    DontSeeAnything
    NPCSwing
    NPCKillUser
    BlockedWithShieldUser
    BlockedWithShieldother
    UserSwing
    SafeModeOn
    SafeModeOff
    ResuscitationSafeOff
    ResuscitationSafeOn
    NobilityLost
    CantUseWhileMeditating
    NPCHitUser
    UserHitNPC
    UserAttackedSwing
    UserHittedByUser
    UserHittedUser
    WorkRequestTarget
    HaveKilledUser
    UserKill
    EarnExp
    SafeDragModeOn
    SafeDragModeOff

    Hechizo_TargetMSG
    Hechizo_PropioMSG
    Hechizo_HechiceroMSG_NOMBRE
    Hechizo_HechiceroMSG_ALGUIEN
    Hechizo_HechiceroMSG_CRIATURA

End Enum


Public OnlineString As String
Public OnlineNum As Integer

Public Const GOHOME_PENALTY As Integer = 5
Public Const GM_MAP As Integer = 49

Public Const TELEP_OBJ_INDEX As Integer = 378

Public Const HUMANO_H_PRIMER_CABEZA As Integer = 1
Public Const HUMANO_H_ULTIMA_CABEZA As Integer = 25        'En verdad es hasta la 51, pero como son muchas estas las dejamos no seleccionables

Public Const ELFO_H_PRIMER_CABEZA As Integer = 102
Public Const ELFO_H_ULTIMA_CABEZA As Integer = 111

Public Const DROW_H_PRIMER_CABEZA As Integer = 201
Public Const DROW_H_ULTIMA_CABEZA As Integer = 205

Public Const ENANO_H_PRIMER_CABEZA As Integer = 301
Public Const ENANO_H_ULTIMA_CABEZA As Integer = 305

Public Const GNOMO_H_PRIMER_CABEZA As Integer = 401
Public Const GNOMO_H_ULTIMA_CABEZA As Integer = 404
'**************************************************
Public Const HUMANO_M_PRIMER_CABEZA As Integer = 72
Public Const HUMANO_M_ULTIMA_CABEZA As Integer = 77

Public Const ELFO_M_PRIMER_CABEZA As Integer = 170
Public Const ELFO_M_ULTIMA_CABEZA As Integer = 176

Public Const DROW_M_PRIMER_CABEZA As Integer = 270
Public Const DROW_M_ULTIMA_CABEZA As Integer = 279

Public Const ENANO_M_PRIMER_CABEZA As Integer = 370
Public Const ENANO_M_ULTIMA_CABEZA As Integer = 371

Public Const GNOMO_M_PRIMER_CABEZA As Integer = 470
Public Const GNOMO_M_ULTIMA_CABEZA As Integer = 475

Public ArrayMascotas(1 To MAXMASCOTAS, eHeading.NORTH To eHeading.WEST) As Position
