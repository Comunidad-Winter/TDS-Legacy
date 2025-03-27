<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<title>AO Legacy - Manual</title>
<meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />

<!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->

<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/manual.css' rel='stylesheet' type='text/css' />
<link href="/hz.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='/scripts/manual.js'></script>
<script type='text/javascript' src='/hz.js'></script>
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'></style>
</head>
<body id="seccion_manual" onload="init();">

<div id='bg_top'>

<div id='pagina'>

<div id='header'> <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas> <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div> </div> <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div> </div>
<?php
    require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>

<div class='titulo_seccion'>
<h1>Manual oficial para jugadores <br />
<span class="ultima_actualizacion">Actualizado en tiempo real</span></h1>
</div>


<div id='main'>

<div>

<?php include 'manual_header.php';?>


<?php

    $tipo=array();

    // Comenzando
    $tipo[0]='clasessociales'; // prologo o clases sociales, cual pongo¿ na, re feo

    // Lo basico 
    $tipo[2]='vidaymuerte'; // vida y muerte
    $tipo[3]='leyes'; // leyes
    $tipo[4]='comidaybebida'; // comida y bebida
    $tipo[5]='subirdenivel'; // subir de nivel
    $tipo[6]='unjugadorconhonor'; // un jugador con honor

    // Entrenamiento
    $tipo[7]='criaturashostiles'; // criaturas hostiles
    $tipo[8]='domar';  // Domar animales 
    $tipo[9]='party'; // Party

     // Equipamento
    $tipo[10]="vestimentas";
    $tipo[11]="tunicas";
    $tipo[12]="armaduras";
    $tipo[13]="cascosyescudos";
    $tipo[14]="pociones";
    $tipo[15]="magicos";
    $tipo[16]="armas";
    $tipo[17]="magia";

    // Mundo
    $tipo[18]="ciudades";
    $tipo[19]="dungeons";
    $tipo[20]="mapa";

    //facciones
    $tipo[21]="armada";
    $tipo[22]="caos";

    // Avanzado
    $tipo[23]="clanes";
    $tipo[24]="retos";
    $tipo[25]="navegacion";
    $tipo[26]="mercadoao";

    // Dinero
    $tipo[27]="dinero";//introducción
    $tipo[28]="comercio";
    $tipo[29]="comercioseguro";
    $tipo[30]="bancos";

    // Profesiones
    $tipo[31]='talador';
    $tipo[32]='minero';
    $tipo[33]='pescador';
    $tipo[34]='carpintero'; 
    $tipo[35]='herrero'; 

    if (isset($_GET['s'])) {
        $manual_id=intval($_GET['s']);
        if ($manual_id >35 || $manual_id < 1) {
            $manual_id = 1;
        }
        include_once 'manual/'.$tipo[$manual_id] .'.html';
    }else 
        include_once 'manual/1.1.html';

    

?>

</div>

<div class="ventana_emergente" id="divemergente">
                    <div class="ventana_emergente_bg_top" onclick="javascript:ocultar_emergente();" title="Cerrar">
                    <h4 id="e_titulo"></h4>
                    </div>
                    <div class="ventana_emergente_desc">
                    <span id="e_contenido"></span>
                    </div>
                    <div class="ventana_emergente_bg_bottom"></div>
                    </div>

                <div class="hz" onclick="javascript:ocultarhechizo();" id="divhechi">
                    <div class="hz_r">
                    <div class="hz_l">
                    <div class="hz_tit">
                    <h4 id="nombre">Cargando..</h4>
                    </div>
                    </div>
                    </div>
                    <div class="hz_info">
                    <div class="hz_desc">
                    <h5>DESCRIPCIÓN</h5>
                    </div>
                    <div class="hz_desc_bg">
                    <img src="../imagenes/hz/hz_img.gif" alt="">
                    <div class="hz_desc_txt">
                    <p id="descripcion"></p>
                    </div>
                    <div style="clear:both"></div>
                    <div class="hz_desc_bg_bottom"></div>
                    </div>
                    <ul>
                    <li>Precio: <span id="valor" class="hz_info_dato"></span><img src="../imagenes/hz/hz_oro.gif" alt="Monedas de Oro con 0 skill en comerciar"></li>
                    <li>Se lanza sobre: <span id="afecta" class="hz_info_dato"></span></li>
                    <li>Skill en magia requerido: <span id="skill" class="hz_info_dato"></span></li>
                    <li>Mana: <span id="manar" class="hz_info_dato"></span></li>
                    <li>Energia: <span id="star" class="hz_info_dato"></span></li>
                    <li>Clases prohibidas: <span id="clasesp" class="hz_info_dato"></span></li>
                    </ul>

                    <div class="hz_info_bg_bottom"></div>
                    </div>
                    </div>
               <div class="info_item" id="info_item" onclick="javascript:ocultaritem();">
                    <div class="info_item_bg_top">
                    <h4 id="i_nombre">Nombre del item</h4>
                    </div>
                    <div class="info_item_desc" id="i_desc">
                    <p>Descripcion del item asd sadda as d asds</p>
                    <p>sdasdkjalk a</p>
                    <p>sdjasdjlkasjdlkajslkd. por si hay un <a href="#">link</a></p>
                    </div>
                    <div class="info_item_bg_bottom"></div>
                    </div></div> 

                    
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>