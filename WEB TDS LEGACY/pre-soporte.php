<?php
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
?>

<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
<meta charset="iso-8859-1">

<meta http-equiv="Content-Language" content="es" />
<meta name="title" content="TDS Legacy - MMORPG Juego de Rol Multijugador Online Gratuito" />
<meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, TDSLegacy, Panel de personaje" />
<meta name="description" content="TDS Legacy es un juego online del tipo MMORPG en el cual te esperan increibles aventuras de rol junto a una gran comunidad de jugadores" />
<meta name="abstract" content="TDS Legacy es un juego online del tipo MMORPG en el cual te esperan increibles aventuras de rol junto a una gran comunidad de jugadores" />
<meta name="Author" content="TDS Legacy" />
<meta name="copyright" content="TDS Legacy" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="bookmark" href="#noticias" title="Noticias" />
<link rel="start" href="https://tdslegacy.com.ar" title="TDS Legacy" />
<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/panel-premium.css' rel='stylesheet' type='text/css' />
<link href='/cuentas-premium.css' rel='stylesheet' type='text/css' />
<link href='/soportes.css' rel='stylesheet' type='text/css' />
<title>TDS Legacy - Soporte</title>

<!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->

<script type="text/javascript" src="/scripts/hs_div.js"></script>
<script type="text/javascript" src="/scripts/funciones.js"></script>
<script type="text/javascript" src="/scripts/thumbs.js"></script>
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'>
</style>
</head>
<body id="seccion_inicio" onload="init();">

<div id='bg_top'>
<div id='pagina'>

<div id='header'>
<div id="animation_container" style="background:none; width:700px; height:197px">
<canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
<div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
</div>
</div>
<div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
<span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' />
</div>
</div>

<?php
	require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>

<div class="titulo_seccion">
<h1>Soporte Premium</h1>
</div>
<div id="main">

<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;">
<div class="tit">
<h1>Panel de <?php if (isset($_SESSION['username'])) {echo $_SESSION['username'];} ?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><div id="centro_panel">
<div id="contenido">
<div class="contenido_soporte">
<p>Bienvenido a la sección de soporte premium. Si tienes alguna duda sobre la interfaz del juego o como realizar alguna acción dentro del mismo, por favor ve a la sección <a href="manual.php">Manual</a>.</p>
<p>Por favor revisa en la siguiente lista si no se encuentra la solución a tu problema o la respuesta a tu duda. </p>
<div id="col1" class="tablasoporte"><br><b>Problemas Técnicos</b><br> - <a href="?a=pre_soporte&amp;entrada=105.problemas-tcnicos-no-se-conecta-al-juego">No se conecta al juego</a><br> - <a href="?a=pre_soporte&amp;entrada=106.problemas-tcnicos-the-setup-are-corrupted-o-el-archivo-esta-corrupto">The setup are corrupted o el archivo esta corrupto</a><br> - <a href="?a=pre_soporte&amp;entrada=108.problemas-tcnicos-la-pantalla-se-ve-corrida">La pantalla se ve corrida</a><br> - <a href="?a=pre_soporte&amp;entrada=109.problemas-tcnicos-no-funciona-crear-personajes">No funciona crear personajes</a><br> - <a href="?a=pre_soporte&amp;entrada=110.problemas-tcnicos-no-se-guardan-las-fotosvideos-w-vista7">No se guardan las fotos/videos W. Vista/7</a><br> - <a href="?a=pre_soporte&amp;entrada=111.problemas-tcnicos-no-llegan-los-mails-a-mi-casilla-de-correo">No llegan los mails a mi casilla de correo</a><br> - <a href="?a=pre_soporte&amp;entrada=112.problemas-tcnicos-errores-de-run-time">Errores de RUN TIME</a><br> - <a href="?a=pre_soporte&amp;entrada=113.problemas-tcnicos-no-se-inicia-el-juego-en-vista7-">No se inicia el juego en Vista/7 </a><br> - <a href="?a=pre_soporte&amp;entrada=114.problemas-tcnicos-no-funciona-la-descarga-del-juego">No funciona la descarga del juego</a><br> - <a href="?a=pre_soporte&amp;entrada=145.problemas-tcnicos-windows-8">Windows 8</a><br> - <a href="?a=pre_soporte&amp;entrada=162.problemas-tcnicos-no-funciona-el-click-en-items-del-inventario">No funciona el click en items del inventario</a><br> - <a href="?a=pre_soporte&amp;entrada=164.problemas-tcnicos-algunos-detalles-se-ven-borrosos">Algunos detalles se ven borrosos</a><br> - <a href="?a=pre_soporte&amp;entrada=181.problemas-tcnicos-franjas-naranjas">Franjas naranjas</a><br> - <a href="?a=pre_soporte&amp;entrada=183.problemas-tcnicos-se-borra-tdsfexe">Se borra TDSF.exe</a><br></div><div id="col2" class="tablasoporte"><br><b>Cuenta Premium</b><br> - <a href="?a=pre_soporte&amp;entrada=117.cuenta-premium-crear-personaje-en-tdsfcil">Crear personaje en TDSFácil</a><br> - <a href="?a=pre_soporte&amp;entrada=118.cuenta-premium-no-se-me-acredita-el-tiempo">No se me acredita el tiempo</a><br> - <a href="?a=pre_soporte&amp;entrada=139.cuenta-premium-adquirir-monedas-de-oro-con-tds">Adquirir monedas de ORO con $TDS</a><br> - <a href="?a=pre_soporte&amp;entrada=140.cuenta-premium-adquirir-tiempo-con-tds">Adquirir tiempo con $TDS</a><br> - <a href="?a=pre_soporte&amp;entrada=142.cuenta-premium-promo-regal-tiempo-premium">Promo: Regalá tiempo premium</a><br><br><b>Personajes</b><br> - <a href="?a=pre_soporte&amp;entrada=115.personajes-me-asignaron-los-skills">Me asignaron los skills</a><br> - <a href="?a=pre_soporte&amp;entrada=116.personajes-pena-por-fotodenuncia">Pena por Fotodenuncia</a><br><br><b>Tramites</b><br> - <a href="?a=pre_soporte&amp;entrada=87.tramites-transferir-personaje-de-cuenta-tdsf">Transferir personaje de cuenta (TDSF)</a><br> - <a href="?a=pre_soporte&amp;entrada=89.tramites-quitar-personajes-de-la-cuenta-tds">Quitar personajes de la cuenta (TDS)</a><br></div> <div class="clear"></div>
<p>Si no has podido encontrar en la lista superior la solucióna a tu problema puedes comunicarte con nosotros utilizando el <a href="cpremium.php?a=soporte">formulario de contacto</a>.</p>
</div>
</div> 
</div> 
</div> 
</div> 

<div class="link_volver"><a href="javascript:history.back()">Volver</a></div>
<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>