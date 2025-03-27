Attribute VB_Name = "Mod_Declaraciones"
Option Explicit

Public CVC_GuildRequest As String
Public CVC_maxSel As Byte
Public CVC_totSel As Byte
Public Enum mCVC_Accion
    
    cvc_EnviarSolicitud = 1
    
    cvc_AceptarSolicitud = 2
    cvc_RechazarSolicitud = 3
    
    cvc_CambiarSeleccion = 4
    cvc_ConfirmarSeleccion = 5
    
    cvc_Cancelar = 6
    cvc_EstoyListo = 7
    cvc_Iniciar = 8
End Enum

Public hlst As clsGraphicalList

Public LastScroll As Byte

Public AccionYesOrNo As Byte


Public MovimientoDefault As E_Heading
Public LastKeyPress As E_Heading

Public LastPanel As Byte

' @@ Los paso a public
Public Enum eVentanas
    vInventario = 1
    vHechizos = 2
End Enum

Public InventoryMainHwnd As Long
Public MainWindowState As Byte

Public LastMAN As Integer
Public LastSpell As Integer
Public LastPotion As Byte

Public SegActive As Boolean
Public CharSeg As Integer

Public Typing As Boolean

Public CountFinish As Byte
Public CountTime As Integer

Public IntClickU As Integer

Public selEvent As Byte

Public Warping As Boolean
Public LlegaronSkills As Boolean
Public LlegaronAtrib As Boolean
Public LlegoFama As Boolean


Public SoyGM As Boolean

Public EfectoEspecialNick As Boolean

Public MainVisible As Boolean
Public OldPersonajeVisible As Boolean
Public ConnectVisible As Boolean

Public SpriteBatch As clsBatch

Public CPJ_iHead As Integer
Public CPJ_iBody As Integer
Public PMSG As Boolean
Public CMSG As Boolean

Public CPJ_heading As E_Heading
Public LoginNormal As Boolean
Public GuardarContra As Boolean
Public CambiandoRes As Boolean

Public Enum eCargos
    c_Rolmaster
    c_Consejero
    c_Semidios
    c_Dios
End Enum

Public Enum eAcciones
    a_Listar
    a_Agregar
    a_Quitar
End Enum

Public Type tIndiceFx
    Animacion As Integer
    OffSetX As Integer
    OffSetY As Integer
End Type

Public EnParty As Boolean
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long

'Objetos públicos
Public DialogosClanes As New ClsDialogsGuild
Public Dialogos As New clsDialogs
Public Audio As New clsAudio
Public Inventario As New clsGraphInv
Public InvBanco(1) As New clsGraphInv

'Inventarios de comercio con usuario
Public InvComUsu As New clsGraphInv        ' Inventario del usuario visible en el comercio
Public InvOfferComUsu(1) As New clsGraphInv        ' Inventarios de ofertas (ambos usuarios)
Public InvComNpc As New clsGraphInv        ' Inventario con los items que ofrece el npc

'Inventarios de herreria
Public Const MAX_LIST_ITEMS As Byte = 4
Public InvLingosHerreria(1 To MAX_LIST_ITEMS) As New clsGraphInv
Public InvMaderasCarpinteria(1 To MAX_LIST_ITEMS) As New clsGraphInv

Public SurfaceDB As clsSurfaceManager        'No va new porque es una interfaz, el new se pone al decidir que clase de objeto es
Public Teclas As New clsTeclas

''
'The main timer of the game.
Public MainTimer As New clsTimer

Public Const DegreeToRadian As Single = 0.01745329251994        'Pi / 180
Public Const RadianToDegree As Single = 57.2958279087977        '180 / Pi


'Sonidos
Public Const SND_CAIDA As String = "cadenas.wav"
Public Const SND_CLICK As String = "click.Wav"
Public Const SND_LOGIN As String = "78.MID"
Public Const SND_PASOS1 As String = "23.Wav"
Public Const SND_PASOS2 As String = "24.Wav"
Public Const SND_NAVEGANDO As String = "50.wav"
Public Const SND_OVER As String = "click2.Wav"
Public Const SND_DICE As String = "cupdice.Wav"
Public Const SND_LLUVIAINEND As String = "lluviainend.wav"
Public Const SND_LLUVIAOUTEND As String = "lluviaoutend.wav"

' Head index of the casper. Used to know if a char is killed


Public MAXFPS As Boolean


' Constantes de intervalo
Public INT_MACRO_HECHIS As Integer
Public INT_MACRO_TRABAJO As Integer

Public INT_ATTACK As Integer
Public INT_ARROWS As Integer
Public INT_CAST_SPELL As Integer
Public INT_CAST_ATTACK As Integer
Public INT_ATTACK_CAST As Integer
Public INT_WORK As Integer
Public INT_USEITEMU As Integer
Public INT_USEITEMDCK As Integer
Public INT_SENTRPU As Integer
Public Const INT_CHANGE_HEADING As Integer = 120

Public MacroBltIndex As Integer

Public Const CASPER_HEAD_CIUDA As Integer = 500
Public Const CASPER_BODY_CIUDA As Integer = 8

Public Const CASPER_HEAD_PK As Integer = 501
Public Const CASPER_BODY_PK As Integer = 145

Public Const FRAGATA_FANTASMAL As Integer = 87

Public Const NUMATRIBUTES As Byte = 5

Public Const HUMANO_H_PRIMER_CABEZA As Integer = 1
Public Const HUMANO_H_ULTIMA_CABEZA As Integer = 26        'En verdad es hasta la 51, pero como son muchas estas las dejamos no seleccionables
Public Const HUMANO_H_CUERPO_DESNUDO As Integer = 21

Public Const ELFO_H_PRIMER_CABEZA As Integer = 102
Public Const ELFO_H_ULTIMA_CABEZA As Integer = 111
Public Const ELFO_H_CUERPO_DESNUDO As Integer = 21

Public Const DROW_H_PRIMER_CABEZA As Integer = 201
Public Const DROW_H_ULTIMA_CABEZA As Integer = 205
Public Const DROW_H_CUERPO_DESNUDO As Integer = 32

Public Const ENANO_H_PRIMER_CABEZA As Integer = 301
Public Const ENANO_H_ULTIMA_CABEZA As Integer = 305
Public Const ENANO_H_CUERPO_DESNUDO As Integer = 53

Public Const GNOMO_H_PRIMER_CABEZA As Integer = 401
Public Const GNOMO_H_ULTIMA_CABEZA As Integer = 406
Public Const GNOMO_H_CUERPO_DESNUDO As Integer = 53
'**************************************************
Public Const HUMANO_M_PRIMER_CABEZA As Integer = 72
Public Const HUMANO_M_ULTIMA_CABEZA As Integer = 79
Public Const HUMANO_M_CUERPO_DESNUDO As Integer = 39

Public Const ELFO_M_PRIMER_CABEZA As Integer = 170
Public Const ELFO_M_ULTIMA_CABEZA As Integer = 176
Public Const ELFO_M_CUERPO_DESNUDO As Integer = 39

Public Const DROW_M_PRIMER_CABEZA As Integer = 270
Public Const DROW_M_ULTIMA_CABEZA As Integer = 279
Public Const DROW_M_CUERPO_DESNUDO As Integer = 40

Public Const ENANO_M_PRIMER_CABEZA As Integer = 370
Public Const ENANO_M_ULTIMA_CABEZA As Integer = 371
Public Const ENANO_M_CUERPO_DESNUDO As Integer = 60

Public Const GNOMO_M_PRIMER_CABEZA As Integer = 470
Public Const GNOMO_M_ULTIMA_CABEZA As Integer = 476
Public Const GNOMO_M_CUERPO_DESNUDO As Integer = 60

'Musica
Public Const MP3_Inicio As Byte = 101

Public RawServersList As String

Public Type tColor
    r As Byte
    g As Byte
    b As Byte
End Type

Public ColoresPJ(1 To 10) As tColor

Public CreandoClan As Boolean
Public ClanName As String
Public Site As String

Public UserCiego As Boolean
Public UserEstupido As Boolean

Public NoRes As Boolean        'no cambiar la resolucion

Public RainBufferIndex As Long
Public FogataBufferIndex As Long

Public Const bCabeza = 1
Public Const bPiernaIzquierda = 2
Public Const bPiernaDerecha = 3
Public Const bBrazoDerecho = 4
Public Const bBrazoIzquierdo = 5
Public Const bTorso = 6

'Timers de (GetTickCount+130311893)
Public Const tAt = 2000
Public Const tUs = 600

Public Const PrimerBodyBarco = 84
Public Const UltimoBodyBarco = 87

Public NumEscudosAnims As Integer

Public ArmasHerrero() As tItemsConstruibles
Public ArmadurasHerrero() As tItemsConstruibles
Public ObjCarpintero() As tItemsConstruibles

Public UsaMacro As Boolean
Public CnTd As Byte


Public Const MAX_BANCOINVENTORY_SLOTS As Byte = 40
Public UserBancoInventory(1 To MAX_BANCOINVENTORY_SLOTS) As Inventory

Public TradingUserName As String
Public Const LoopAdEternum As Integer = 999
Public DragToUser As Boolean

'Direcciones
Public Enum E_Heading
    NONE = 0
    NORTH = 1
    EAST = 2
    SOUTH = 3
    WEST = 4
End Enum


'Objetos
Public Const MAX_INVENTORY_OBJS As Integer = 10000
Public Const MAX_INVENTORY_SLOTS As Byte = 30
Public Const MAX_NORMAL_INVENTORY_SLOTS As Byte = 20
Public Const MAX_NPC_INVENTORY_SLOTS As Byte = 50
Public Const MAXHECHI As Byte = 35

Public Const INV_OFFER_SLOTS As Byte = 20
Public Const INV_GOLD_SLOTS As Byte = 1

Public Const MAXSKILLPOINTS As Byte = 100

Public Const MAXATRIBUTOS As Byte = 38

Public Const FLAGORO As Integer = MAX_INVENTORY_SLOTS + 1
Public Const GOLD_OFFER_SLOT As Integer = INV_OFFER_SLOTS + 1

Public Const FOgata As Integer = 1521

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
    Woodcutter = 12        'Leñador
    Miner = 13        'Minero
    Carpenter = 14        'Carpintero
    Pirat = 15        'Pirata
End Enum

Public Enum eCiudad
    cUllathorpe = 1
    cNix
    cBanderbill
    cLindos
    cArghal
End Enum

Enum eRaza
    Humano = 1
    Elfo
    ElfoOscuro
    Gnomo
    Enano
End Enum

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
    Proyectiles = 18
    Wrestling = 19
    Navegacion = 20
    ResistenciaMagica = 21
End Enum

Public Enum eAtributos
    Fuerza = 1
    Agilidad = 2
    Inteligencia = 3
    Carisma = 4
    Constitucion = 5
End Enum

Enum eGenero
    Hombre = 1
    Mujer = 2
End Enum

Public Enum FaccionType
    ChaosCouncil = 1
    RoyalCouncil = 2
End Enum

Public Enum PlayerType
    User = 1
    RoleMaster = 2
    Consejero = 3
    SemiDios = 4
    Dios = 5
    Admin = 6
End Enum


Public Enum eObjType
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
    otescudo = 16
    otcasco = 17
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
    otMochilas = 37
    otAnillo2 = 38
    otCualquiera = 1000
End Enum

Public Enum eMochilas
    Mediana = 1
    GRANDE = 2
End Enum

Public MaxInventorySlots As Byte

Public ShowChatInConsole As Boolean


Public Const FundirMetal As Integer = 88

' Determina el color del nick
Public Enum eNickColor
    ieCriminal = &H1
    ieCiudadano = &H2
    ieAtacable = &H4
End Enum

Public Const MENSAJE_CRIATURA_FALLA_GOLPE As String = "¡¡¡La criatura falló el golpe!!!"
Public Const MENSAJE_CRIATURA_MATADO As String = "¡¡¡La criatura te ha matado!!!"
Public Const MENSAJE_RECHAZO_ATAQUE_ESCUDO As String = "¡¡¡Has rechazado el ataque con el escudo!!!"
Public Const MENSAJE_USUARIO_RECHAZO_ATAQUE_ESCUDO As String = "¡¡¡El usuario rechazó el ataque con su escudo!!!"
Public Const MENSAJE_FALLADO_GOLPE As String = "¡¡¡Has fallado el golpe!!!"
Public Const MENSAJE_SEGURO_ACTIVADO As String = ">SEGURO ACTIVADO<<"
Public Const MENSAJE_SEGURO_DESACTIVADO As String = ">SEGURO DESACTIVADO<<"
Public Const MENSAJE_SEGURODRAG_ACTIVADO As String = ">SEGURO DRAG ACTIVADO<<"
Public Const MENSAJE_SEGURODRAG_DESACTIVADO As String = ">SEGURO DRAG DESACTIVADO<<"
Public Const MENSAJE_PIERDE_NOBLEZA As String = "¡¡Has perdido puntaje de nobleza y ganado puntaje de criminalidad!! Si sigues ayudando a criminales te convertirás en uno de ellos y serás perseguido por las tropas de las ciudades."
Public Const MENSAJE_USAR_MEDITANDO As String = "¡Estás meditando! Debes dejar de meditar para usar objetos."

Public Const MENSAJE_SEGURO_RESU_ON As String = "SEGURO DE RESURRECCION ACTIVADO"
Public Const MENSAJE_SEGURO_RESU_OFF As String = "SEGURO DE RESURRECCION DESACTIVADO"

Public Const MENSAJE_GOLPE_CABEZA As String = "¡¡La criatura te ha pegado en la cabeza por "
Public Const MENSAJE_GOLPE_BRAZO_IZQ As String = "¡¡La criatura te ha pegado el brazo izquierdo por "
Public Const MENSAJE_GOLPE_BRAZO_DER As String = "¡¡La criatura te ha pegado el brazo derecho por "
Public Const MENSAJE_GOLPE_PIERNA_IZQ As String = "¡¡La criatura te ha pegado la pierna izquierda por "
Public Const MENSAJE_GOLPE_PIERNA_DER As String = "¡¡La criatura te ha pegado la pierna derecha por "
Public Const MENSAJE_GOLPE_TORSO As String = "¡¡La criatura te ha pegado en el torso por "

' MENSAJE_[12]: Aparecen antes y despues del valor de los mensajes anteriores (MENSAJE_GOLPE_*)
Public Const MENSAJE_1 As String = "¡¡"
Public Const MENSAJE_2 As String = "!!"
Public Const MENSAJE_11 As String = "¡"
Public Const MENSAJE_22 As String = "!"

Public Const MENSAJE_GOLPE_CRIATURA_1 As String = "¡¡Le has pegado a la criatura por "

Public Const MENSAJE_ATAQUE_FALLO As String = " te atacó y falló!!"
Public RAYOS_X As Boolean

Public Const MENSAJE_RECIVE_IMPACTO_CABEZA As String = " te ha pegado en la cabeza por "
Public Const MENSAJE_RECIVE_IMPACTO_BRAZO_IZQ As String = " te ha pegado el brazo izquierdo por "
Public Const MENSAJE_RECIVE_IMPACTO_BRAZO_DER As String = " te ha pegado el brazo derecho por "
Public Const MENSAJE_RECIVE_IMPACTO_PIERNA_IZQ As String = " te ha pegado la pierna izquierda por "
Public Const MENSAJE_RECIVE_IMPACTO_PIERNA_DER As String = " te ha pegado la pierna derecha por "
Public Const MENSAJE_RECIVE_IMPACTO_TORSO As String = " te ha pegado en el torso por "

Public Const MENSAJE_PRODUCE_IMPACTO_1 As String = "¡¡Le has pegado a "
Public Const MENSAJE_PRODUCE_IMPACTO_CABEZA As String = " en la cabeza por "
Public Const MENSAJE_PRODUCE_IMPACTO_BRAZO_IZQ As String = " en el brazo izquierdo por "
Public Const MENSAJE_PRODUCE_IMPACTO_BRAZO_DER As String = " en el brazo derecho por "
Public Const MENSAJE_PRODUCE_IMPACTO_PIERNA_IZQ As String = " en la pierna izquierda por "
Public Const MENSAJE_PRODUCE_IMPACTO_PIERNA_DER As String = " en la pierna derecha por "
Public Const MENSAJE_PRODUCE_IMPACTO_TORSO As String = " en el torso por "

Public Const MENSAJE_TRABAJO_MAGIA As String = "Haz click sobre el objetivo..."
Public Const MENSAJE_TRABAJO_PESCA As String = "Haz click sobre el sitio donde quieres pescar..."
Public Const MENSAJE_TRABAJO_ROBAR As String = "Haz click sobre la víctima..."
Public Const MENSAJE_TRABAJO_TALAR As String = "Haz click sobre el árbol..."
Public Const MENSAJE_TRABAJO_MINERIA As String = "Haz click sobre el yacimiento..."
Public Const MENSAJE_TRABAJO_FUNDIRMETAL As String = "Haz click sobre la fragua..."
Public Const MENSAJE_TRABAJO_PROYECTILES As String = "Haz click sobre la victima..."

Public Const MENSAJE_ENTRAR_PARTY_1 As String = "Si deseas entrar en una party con "
Public Const MENSAJE_ENTRAR_PARTY_2 As String = ", escribe /entrarparty"

Public Const MENSAJE_NENE As String = "Cantidad de NPCs: "

Public Const MENSAJE_FRAGSHOOTER_TE_HA_MATADO As String = "te ha matado!"
Public Const MENSAJE_FRAGSHOOTER_HAS_MATADO As String = "Has matado a"
Public Const MENSAJE_FRAGSHOOTER_HAS_GANADO As String = "Has ganado "
Public Const MENSAJE_FRAGSHOOTER_PUNTOS_DE_EXPERIENCIA As String = "puntos de experiencia."

Public Const MENSAJE_NO_VES_NADA_INTERESANTE As String = "No ves nada interesante."
Public Const MENSAJE_HAS_MATADO_A As String = "Has matado a "
Public Const MENSAJE_HAS_GANADO_EXPE_1 As String = "Has ganado "
Public Const MENSAJE_HAS_GANADO_EXPE_2 As String = " puntos de experiencia."
Public Const MENSAJE_TE_HA_MATADO As String = " te ha matado!"

Public MacroCant As Long

Public Const MENSAJE_HOGAR As String = "Has llegado a tu hogar. El viaje ha finalizado."
Public Const MENSAJE_HOGAR_CANCEL As String = "Tu viaje ha sido cancelado."

Public Enum eMessages
    DontSeeAnything
    NPCSwing
    NPCKillUser
    BlockedWithShieldUser
    BlockedWithShieldOther
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

'Inventario
Type Inventory
    ObjIndex As Integer
    Name As String
    GrhIndex As Integer
    '[Alejo]: tipo de datos ahora es Long
    amount As Long
    '[/Alejo]
    Equipped As Byte
    Valor As Single
    ObjType As Integer
    MaxDef As Integer
    MinDef As Integer        'Budi
    MaxHit As Integer
    MinHit As Integer

    MinDefMagic As Integer
    MaxDefMagic As Integer

End Type

Type NpCinV
    ObjIndex As Integer
    Name As String
    GrhIndex As Integer
    amount As Integer
    Valor As Single
    ObjType As Integer
    MaxDef As Integer
    MinDef As Integer
    MaxHit As Integer
    MinHit As Integer
    C1 As String
    C2 As String
    C3 As String
    C4 As String
    C5 As String
    C6 As String
    C7 As String
End Type

Type tReputacion        'Fama del usuario
    NobleRep As Long
    BurguesRep As Long
    PlebeRep As Long
    LadronesRep As Long
    BandidoRep As Long
    AsesinoRep As Long
    Promedio As Long
    ArmadaReal As Byte
    FuerzasCaos As Byte
End Type

Type tEstadisticasUsu
    CiudadanosMatados As Long
    CriminalesMatados As Long
    UsuariosMatados As Long
    NpcsMatados As Long
    Clase As String
    PenaCarcel As Long
End Type

Type tItemsConstruibles
    ObjIndex As Integer
End Type

Public Nombres As Boolean
Public LockedWalk As Boolean

'User status vars
Global OtroInventario(1 To MAX_INVENTORY_SLOTS) As Inventory
Public UserHechizos(1 To MAXHECHI) As Integer
Public NPCInventory(1 To MAX_NPC_INVENTORY_SLOTS) As NpCinV
Public UserMeditar As Boolean
Public UserName As String
Public UserPassword As String
Public UserMaxHP As Integer
Public UserMinHP As Integer
Public UserMaxMAN As Integer
Public UserMinMAN As Integer
Public UserMaxSTA As Integer
Public UserMinSTA As Integer
Public UserMaxAGU As Byte
Public UserMinAGU As Byte
Public UserMaxHAM As Byte
Public UserMinHAM As Byte
Public UserGLD As Long
Public BankGLD As Long
Public UserDiam As Long
Public UserLvl As Integer
Public UserEstado As Byte        '0 = Vivo & 1 = Muerto
Public UserPasarNivel As Long
Public UserExp As Long
Public UserReputacion As tReputacion
Public UserEstadisticas As tEstadisticasUsu
Public UserDescansar As Boolean
Public pausa As Boolean
Public UserParalizado As Boolean
Public UserNavegando As Boolean
Public UserHogar As eCiudad

Public UserFuerza As Byte
Public UserAgilidad As Byte
Public DuracionPociones As Integer
Public bLastBrightBlink As Boolean


Public UserWeaponEqpSlot As Byte
Public UserArmourEqpSlot As Byte
Public UserHelmEqpSlot As Byte
Public UserShieldEqpSlot As Byte

'<-------------------------NUEVO-------------------------->
Public Comerciando As Boolean

Public LoggedByReturn As Boolean
Public MirandoAsignarSkills As Boolean
Public MirandoEstadisticas As Boolean
Public MirandoParty As Boolean
'<-------------------------NUEVO-------------------------->

Public UserClase As eClass
Public UserSexo As eGenero
Public UserRaza As eRaza
Public UserEmail As String
Public UserPin As String
Public SKAssigned As String

Public Const NUMCIUDADES As Byte = 5
Public Const NUMSKILLS As Byte = 21
Public Const NUMATRIBUTOS As Byte = 5
Public Const NUMCLASES As Byte = 15
Public Const NUMRAZAS As Byte = 5

Public UserSkills(1 To NUMSKILLS) As Byte
Public PorcentajeSkills(1 To NUMSKILLS) As Byte
Public SkillsNames(1 To NUMSKILLS) As String

Public UserAtributos(1 To NUMATRIBUTOS) As Byte
Public AtributosNames(1 To NUMATRIBUTOS) As String

Public Ciudades(1 To NUMCIUDADES) As String
Public CityDesc(1 To NUMCIUDADES) As String

Public ListaRazas(1 To NUMRAZAS) As String
Public ListaClases(1 To NUMCLASES) As String

Private Type tPasajes
    nombre As String
    precio As String
End Type

Public Pasajes() As tPasajes
Public NumPasajes As Byte
Public SkillPoints As Integer
Public Alocados As Integer
Public Flags() As Integer
Public Oscuridad As Integer

Public UsingSkill As Integer

Public EsPartyLeader As Boolean

Public Enum E_MODO
    LoginChar = 1
    CrearNuevoPj = 2
    Dados = 3
End Enum

Public EstadoLogin As E_MODO

Public Enum FxMeditar
    CHICO = 4
    MEDIANO = 5
    GRANDE = 6
    XGRANDE = 16
    XXGRANDE = 34
End Enum

Public Enum eClanType
    ct_RoyalArmy
    ct_Evil
    ct_Neutral
    ct_GM
    ct_Legal
    ct_Criminal
End Enum

Public Enum eEditOptions
    eo_Gold = 1
    eo_Experience
    eo_Body
    eo_Head
    eo_CiticensKilled
    eo_CriminalsKilled
    eo_Level
    eo_Class
    eo_Skills
    eo_SkillPointsLeft
    eo_Nobleza
    eo_Asesino
    eo_Sex
    eo_Raza
    eo_addGold
End Enum

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
    nada = 0
    BAJOTECHO = 1
    trigger_2 = 2
    POSINVALIDA = 3
    ZONASEGURA = 4
    ANTIPIQUETE = 5
    ZONAPELEA = 6
    AUTO_RESU = 7
End Enum

'Server stuff
Public RequestPosTimer As Integer        'Used in main loop
Public stxtbuffer As String        'Holds temp raw data from server
Public stxtbuffercmsg As String        'Holds temp raw data from server
Public SendNewChar As Boolean        'Used during login
Public Connected As Boolean        'True when connected to server
Public DownloadingMap As Boolean        'Currently downloading a map from server
Public UserMap As Integer

'Control
Public prgRun As Boolean        'When true the program ends

'
'********** FUNCIONES API ***********
'
Public Declare Function timeGetTime Lib "winmm.dll" () As Long
Public Declare Function GetRealTickCount Lib "kernel32" Alias "GetTickCount" () As Long

'para escribir y leer variables
Public Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long
Public Declare Function getprivateprofilestring Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nSize As Long, ByVal lpfilename As String) As Long
Public Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Public Const GWL_EXSTYLE = -20
Public Const WS_EX_LAYERED = &H80000
Public Const WS_EX_TRANSPARENT As Long = &H20&

'Teclado
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Declare Function GetAsyncKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

'Para ejecutar el browser y programas externos
Public Const SW_SHOWNORMAL As Long = 1
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

'Lista de cabezas
Public Type tIndiceCabeza
    Head(1 To 4) As Integer
End Type

Public Type tIndiceCuerpo
    Body(1 To 4) As Integer
    HeadOffsetX As Integer
    HeadOffsetY As Integer
End Type

Public GuildNames() As String
Public GuildMembers() As String

Public Const OFFSET_HEAD As Integer = -34

Public Enum eSMType
    sResucitation
    sSafemode
    mSpells
    mWork
    sDSafemode
End Enum

Public Const SM_CANT As Byte = 4
Public SMStatus(SM_CANT) As Boolean

'Hardcoded grhs and items
Public Const GRH_INI_SM As Integer = 4978

Public Const ORO_INDEX As Integer = 12
Public Const ORO_GRH As Integer = 511

Public Const GRH_HALF_STAR As Integer = 5357
Public Const GRH_FULL_STAR As Integer = 5358
Public Const GRH_GLOW_STAR As Integer = 5359

Public Const LH_GRH As Integer = 724
Public Const LP_GRH As Integer = 725
Public Const LO_GRH As Integer = 723

Public Const MADERA_GRH As Integer = 550
Public Const MADERA_ELFICA_GRH As Integer = 4803

Public picMouseIcon As Picture
