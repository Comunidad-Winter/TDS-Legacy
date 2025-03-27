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
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/inicio.css' rel='stylesheet' type='text/css' />
    <title>TDS Legacy - Calculadora de criaturas (NPCs)</title>

    <!--[if lt IE 7.]>
    <script defer type='text/javascript'src='/scripts/pngfix.js'></script>
    <![endif]-->

    <meta name="abstract" content="Con esta aplicación podrás calcular cuantas criaturas (NPCs) necesitas para pasar al siguiente nivel." />

    <link href="/general.css" rel="stylesheet" type="text/css" />

    <link href="/caja.css" rel="stylesheet" type="text/css" />

    <link href="/apu.css" rel="stylesheet" type="text/css" />
    <link href="/calculador.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <script type="text/javascript" src="/scripts/calcu_npcs.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>

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


<div id="titulo_seccion" class="titulo_seccion">
<h1>Calculadora de experiencia</h1>
</div>


<div id="main">
<div id="calculador">

<h2>Calculá las criaturas que tenés que matar para pasar de nivel</h2>
<div style="background:transparent url(/imagenes/calculador/lineaH.gif) repeat-x;padding-top:15px;margin-bottom:25px;">
<div class="submit">
<form name="exp" action="" method="post" id="exp" onsubmit="return false">
<table style="float:left;background:transparent url(/imagenes/fotos/fotos_desc_sep.gif) repeat-y right;padding-right:5px;margin:5px;">
<tr>
<td colspan="2">
<select name="npc" id="npc" style="background-color:black;color:white;border:1px solid gray;font-family:trebuchet ms;">
<option value="0">Acechadores Invisibles</option>
    <option value="1">Aguilas</option>
    <option value="2">Arañas</option>
    <option value="3">Árboles De La Jungla</option>
    <option value="4">Asesinos</option>
    <option value="5">Bandidos</option>
    <option value="6">Beholders</option>
    <option value="7">Brujas</option>
    <option value="8">Calamares</option>
    <option value="9">Cthulus</option>
    <option value="10">Cuervos</option>
    <option value="11">Demonios</option>
    <option value="12">Dragónes Rojos (DMagma)</option>
    <option value="13">Duendes</option>
    <option value="14">Duendes Molestos</option>
    <option value="15">Escorpiones</option>
    <option value="16">Esqueletos</option>
    <option value="17">Esqueletos guerreros</option>
    <option value="18">Galeónes Fantasmales</option>
    <option value="19">Gallos salvajes</option>
    <option value="20">Goblins</option>
    <option value="21">Golems</option>
    <option value="22">Golems de hielo</option>
    <option value="23">Gran Dragon Rojo (DD)</option>
    <option value="24">Hormigas</option>
    <option value="25">Hormigas Gigantes</option>
    <option value="26">Jabalíes salvajes</option>
    <option value="27">Leviatanes</option>
    <option value="28">Liches</option>
    <option value="29">Lobos</option>
    <option value="30">Lobos Invernales</option>
    <option value="31">Lord Orco</option>
    <option value="32">Lord Zombie</option>
    <option value="33">Mago Malvado</option>
    <option value="34">Medusas</option>
    <option value="35">Murcielagos</option>
    <option value="36">Ogros</option>
    <option value="37">Orcos</option>
    <option value="38">Orcos brujos</option>
    <option value="39">Osos pardos</option>
    <option value="40">Osos polares</option>
    <option value="41">Pequeños Dragónes Rojos</option>
    <option value="42">Pingüinos</option>
    <option value="43">Quarcks</option>
    <option value="44">Ratas</option>
    <option value="45">Serpientes</option>
    <option value="46">Servidores del Mal</option>
    <option value="47">Tigres salvajes</option>
    <option value="48">Tortugas gigantes</option>
    <option value="49">Ucornos</option>
    <option value="50">Viudas negras</option>
    <option value="51">Zombies</option>
</select>
</td>
</tr>
<tr>
<td>
<label for="lvl">Nivel </label>
</td>
<td>
<input id="lvl" class="input" type="text" maxlength="2" name="lvl" value="" />
</td>
</tr>
<tr>
<td>
<label for="pors">Porcentaje </label>
</td>
<td>
<input id="pors" type="text" class="input" name="pors" value="" maxlength="5" />
</td>
</tr>
<tr>
<td colspan="2">
<a href="#res" onclick="calcular()" class="botonCalcu">Calcular</a>
</td>
</tr>
</table>
</form>
<br />
</div>
<span style="color:#FED968;display:block;">
<small id="alert" style="color:#00dcff;">
    
</small>
<strong id="resultados">
    Seleccioná la criatura, tu nivel y porcentaje, para saber cuantas tenés que matar.
</strong>

</span>
</div>

<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>