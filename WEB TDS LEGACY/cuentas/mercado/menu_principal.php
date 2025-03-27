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
<link href='/hz.css' rel='stylesheet' type='text/css' />
<link href='/comentarios/coments.css' rel='stylesheet' type='text/css' />
<link href='/mao.css' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="/comentarios/comentarios.js"></script>

<?php 
require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_logged(); 
$conn = connect();

if (isset($_SESSION['premium_at'])) {
    $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
    $seconds_diff = $ts2 - $ts1;
    if ($seconds_diff <= 0) {
        echo '<script type="text/javascript" src="/cuentas/mercado/mercado.js.php"></script>';}
    else {
        echo '<script type="text/javascript" src="/cuentas/mercado/mercado_premium.js.php"></script>';}
}
?>

<script defer="" type="text/javascript" src="/hz.js"></script>

<title>TDS Legacy - Cuenta Premium - Panel - Mercado</title>

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

<div class="titulo_seccion"><h1>Panel de Cuenta</h1></div>

<div id='main'>

 <div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;">
<div class="tit">
<h1>Panel de <?php  echo $_SESSION['username' ]?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><div id="centro_panel" style="width:500px;">
<div id="contenido" style="text-align:center">
<img src="/imagenes/opciones.gif" alt="Opciones"><br>
<br>
<a onclick="seccionespecial(5);return false;" href="?a=mercado&amp;s=l&amp;p=as"><img src="/imagenes/personajes-en-venta.gif" border="0" alt="Personajes en venta"></a><br>
<a onclick="seccion(4);return false;" href="?a=mercado&amp;s=p&amp;p=as"><img src="/imagenes/publicar-personaje.gif" border="0" alt="Publicar personaje"></a><br>
<a onclick="seccion(6);return false;" href="?a=mercado&amp;s=q&amp;p=as"><img src="/imagenes/quitar-de-la-venta.gif" border="0" alt="Quitar de la venta"></a><br>
<a onclick="seccion(1);return false;" href="?a=mercado&amp;s=h&amp;p=as"><img src="/imagenes/ayuda.gif" border="0" alt="Ayuda"></a><br><br>
</div>
</div>
</div>
</div> 
 




