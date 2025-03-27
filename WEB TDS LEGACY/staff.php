<?php 
  require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
  #$conn = connect();
 ?><!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<title>TDS Legacy - Staff</title>
<meta name="keywords" content="Staff TDS Legacy, Desarollo, Desarrollo TDS Legacy, Ingresar Staff, Staff TDSL, Equipo TDSL, Trabajo TDSL, Programacion, Diseño web, Sonido" />

<!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->

<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/staff.css' rel='stylesheet' type='text/css' />
<script type='text/javascript' src='/scripts/staff.js'></script>
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'>
</style>
<body id="seccion_staff" onload="init();">

<div id='bg_top'>
</head>
<body id="seccion_staff" onload="init();">

<div id='bg_top'>

<div id='pagina'>

<div id='header'>
<div id="animation_container" style="background:none; width:700px; height:197px">
<canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
<div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
</div>
</div>
<div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
<span style='display: inline-block; height: 100%; vertical-align: middle;'></span>
<img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' />
</div>
</div>
<?php
    require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>
<div class='titulo_seccion'>
<h1>Staff de TDS Legacy</h1>
</div>


<div id='main'>

<div id='contenido'>

<div class="contenido_staff">

<fieldset>
<legend>Dirección del proyecto</legend>
<ul>
<li>Cuicui
</li>
</ul>
</fieldset>

<fieldset>
<legend>Co-Dirección</legend>
<ul>
<li>Cuicui
</li>
</ul>
</fieldset>

<fieldset>
<legend>Team Manager</legend>
<ul>
<li>Cuicui</li>
</ul>
</fieldset>
<fieldset>
<legend>Director de Soporte</legend>
<ul>
<li>Cuicui</li>
</ul>
</fieldset>

<fieldset>
<legend>Redes Sociales</legend>
<ul>
<li>Rowne</li>
<li>Cuicui</li>
</ul>
</fieldset>

<fieldset>
<legend>Game Masters y Consejeros </legend>
<div id="gms">
<ul>
<li>Betatester Administrador</li>
<li>Rowne Dios</li>
<li>Naroth Consejero</li>
<li>Esmeray Consejero</li>
</ul>
</div>
</fieldset>

<div class="busca_staff">
<em>El servidor se encuentra constantemente
<strong>incorporando</strong>
<strong>staff</strong> de desarrollo. Si ten&eacute;s habilidad para programar, graficar,
dise&ntilde;ar o mapear
podes
<strong>comunicarte</strong> con nosotros.
Por favor llena éste formulario para que podamos contactar contigo.

<strong><a style="color:#ff000a;" href="https://forms.gle/kLpkTfQRyDaFMpcr8" >Haz click aqui</a></strong>
 
</em>
</div>
</div>

</div>

<div class="link_volver">
<a href="javascript:history.back()">Volver</a>
</div>
<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>