<?php
require_once $_SERVER['DOCUMENT_ROOT'] ."/php/utils.php";

$conn = connect();
?>

<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
<meta charset="iso-8859-1">
<meta name="csrf_token" content="<?php echo createToken(); ?>" />
<meta http-equiv="Content-Language" content="es" />
<meta name="title" content="AO Legacy - MMORPG Juego de Rol Multijugador Online Gratuito" />
<meta name="keywords" content="Argentum Online, Argentum, AO, AO Legacy, Legacy, Online, Legacy Online, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor Legacy, Server Online, Juego online, Juegos Online, Online, Juegos, Quest, Legacy, Panel de personaje" />
<meta name="description" content="AO Legacy es un juego online del tipo MMORPG en el cual te esperan increibles aventuras de rol junto a una gran comunidad de jugadores" />
<meta name="abstract" content="AO Legacy es un juego online del tipo MMORPG en el cual te esperan increibles aventuras de rol junto a una gran comunidad de jugadores" />
<meta name="Author" content="AO Legacy" />
<meta name="copyright" content="AO Legacy" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<link rel="bookmark" href="#noticias" title="Noticias" />
<link rel="start" href="http://aoLegacy.com" title="AO Legacy" />
<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/caja.css' rel='stylesheet' type='text/css' />
<link href='/inicio.css' rel='stylesheet' type='text/css' />
<title>AO Legacy - Argentum Online - Juego de Rol Multijugador Gratuito</title>

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

<div class='titulo_seccion'>
<h1>&Uacute;ltimas <a href="#noticias">noticias</a> en AO Legacy</h1>
</div>


<div id='main'>

<div id='left'>

<div class='caja_margen'>
<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido'>
<h2>AO Legacy</h2>
<ul>
<li class='link_jugar'><a href='/comenzar_a_jugar_legacy.php' title='Comienza a jugar AO Legacy'>Comenzar a Jugar <br>AO Legacy</a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido'>
<h2 class="dos_lineas"><a href="/cuenta-premium.php" title="
<?php
$nick = "";

if (isset($_SESSION["username"])) {
    $nick = $_SESSION["username"];
}
if (mb_strlen($nick) > 0) {
    echo "Cuenta " . $nick . '"> Premium de <br>' . $nick;
} else {
    echo 'Cuenta premium">Ingresa a <br>tu Cuenta';
}
?>
</a>
</h2>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido'>
<h2 style="letter-spacing:1px;" class="dos_lineas"><a href="#" onclick="hideallExcept('miniest_div'); return false" title='Mini Estad&iacute;sticas'>Mini
Estad&iacute;sticas</a></h2>
<div id='miniest_div' style='display:none;'>
<form name="mini_est_form" action="mini_estadisticas.php" onsubmit="return miniest(nick_m)" method="post">
<fieldset>
<p><label for='nick_m'>Nick
<input type='text' id='nick_m' name='nick_m' class='input' accesskey="t" value="Nick" onfocus="borrar(this)" /></label></p>
</fieldset>
<p><input type='submit' value='Ver' class='ver' accesskey="v" /></p>
</form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido'>
<h2 class="dos_lineas"><a href="<?php echo TDS_URL; ?>" onclick="hideallExcept('recupass_div'); return false" title='Recuperar Contrase&ntilde;a'>Recuperar
Contrase&ntilde;a</a></h2>
<script src="/php/script.js"></script>
<div id='recupass_div' style='display:none'>
<div id="errs" class="errcontainer"></div>
<form name="form_recu_pass" id="form_recu_pass">
<fieldset>
<p><label for='nick'>Nick
<input type='text' id='nick' name='nick' class='input' value="Nick" onfocus="borrar(this)" /></label></p>
<p><label for='mail'>Email
<input type='text' id='email' name='email' class='input' value="m@h.com" onfocus="borrar(this)" /></label></p>
</fieldset>
<p><input value='Enviar' readonly class='enviar' onclick="passwordResetRequest();" />
</p>

</form>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido caja_ayuda'>
<h2 class="dos_lineas"><a href="calculador_vida.php" title='Calculadora de vida'>Calculadora de vida</a></h2>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>


<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido caja_ayuda'>
<h2 class="dos_lineas"><a href="calculador_npcs.php" title='Esta herramienta te permite calcular cuantos npcs te faltan para pasar de nivel.'>Calculadora
de NPCs</a></h2>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<?php if (isset($_SESSION["gm"])) {
    if ($_SESSION["gm"] == 1) { ?>

	<div class='caja'>
		<div class='caja_shadow_t'>
		<div class='caja_shadow_b'>
		<div class='caja_l'>
		<div class='caja_r'>
		<div class='caja_t'>
		<div class='caja_b'>
		<div class='caja_contenido caja_ayuda'>
		<h2 class="dos_lineas"><a href="/agregar_noticia.php" title='Agregar noticia'>[GM] <br>Agregar noticia</a></h2>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div>
		</div>
	<?php }
} ?>
</div>


<div id='right'>
<div>

<a name="noticias"></a>
<div align="left" onclick="javascript:ocultar();" id="imagengrande" style="z-index:1000;cursor:pointer; left:1%; position:absolute; display:none;"></div>
<?php
$tot = 0;
$consulta = "SELECT * FROM noticias ORDER BY fecha DESC LIMIT 6";

if ($resultado = $conn->query($consulta)) {
    /* obtener el array de objetos */
    while ($fila = $resultado->fetch_row()) {
        $tot++; ?>
<div class="caja_margen">
<div class="caja">
   <div class="caja_shadow_t">
	  <div class="caja_shadow_b">
		 <div class="caja_l">
			<div class="caja_r">
			   <div class="caja_t">
				  <div class="caja_b">
					 <div class="caja_noticia">
						<h2><a title="Leer noticia completa - <?php echo $fila[3]; ?>" href="noticia.php?n=<?php echo $fila[0]; ?>"><?php echo $fila[3]; ?></a></h2>
						<p><?php
      $cantidad_caracteres = 1000; //1031;

      // Verificamos si el texto es mayor a la cantidad de caracteres que queremos mostrar
      if (strlen($fila[2]) > $cantidad_caracteres) {
          // Si el texto es mayor, lo achicamos y agregamos puntos suspensivos
          $texto_achicado =
              substr($fila[2], 0, $cantidad_caracteres) .
              '<a href="noticia.php?n=' .
              $fila[0] .
              '">...(Click aquí para ver la noticia completa)</a>';
      } else {
          // Si el texto es menor o igual a la cantidad de caracteres, lo dejamos tal cual
          $texto_achicado = $fila[2];
      }

      echo $texto_achicado;
      ?></p>
						<div class="por_l">
						   <div class="por_r">
							  <div class="por_contenido"> <span class="dato">Fecha: <?php echo $fila[4]; ?></span> - Por: <span class="dato"><?php echo $fila[1]; ?></span></div>
						   </div>
						</div>
					 </div>
				  </div>
			   </div>
			</div>
		 </div>
	  </div>
   </div>
</div>
</div>
<?php
    }

    if ($tot == 0) { ?>
   <div class="caja_margen">
	  <div class="caja">
		 <div class="caja_shadow_t">
			<div class="caja_shadow_b">
			   <div class="caja_l">
				  <div class="caja_r">
					 <div class="caja_t">
						<div class="caja_b">
						   <div class="caja_noticia">
							  <h2><a title="">Noticias</a></h2>
							  <p>No hay ninguna noticia por ahora.</p>
							  <div class="por_l">
								 <div class="por_r">
									<div class="por_contenido"> <span class="dato">Fecha:</span> - Por: <span class="dato"></span></div>
								 </div>
							  </div>
						   </div>
						</div>
					 </div>
				  </div>
			   </div>
			</div>
		 </div>
	  </div>
   </div>
<?php }
}
?>
 
</div>

<div class='historial'>
	<div class='cadenas'></div>
	<div class='caja caja_historial'>
	<div class='caja_shadow_t'>
	<div class='caja_shadow_b'>
	<div class='caja_l'>
	<div class='caja_r'>
	<div class='caja_t'>
	<div class='caja_b'>
	<div class='caja_contenido caja_historial'>
	<ul>
	<li><a href='/historial_de_noticias.php' title='Historial de Noticias' class="historial_de_noticias">Historial de
	Noticias</a></li>
	</ul>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
</div>

<div class='clear'></div>

<div id='screenshots'>
<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido contenido_screenshots'>
<ul>
<li>
<h3><a title="&Uacute;ltimos Screenshots de Legacy">&Uacute;ltimos Screenshots</a></h3>
</li>
</ul>
<div class='fotos'>
<ul>
<li class='foto'><a><img src='/screens/2205032458wt.jpg' width='100' height='100' border='0' alt='titanazooo - Ver imagen' /></a></li>
<li class='foto'><a><img src='/screens/16420060ct.jpg' width='100' height='100' border='0' alt='Gracias Tirri !!! - Ver imagen' /></a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div> </div>


<div id='videos'>
<div class='caja'>
<div class='caja_shadow_t'>
<div class='caja_shadow_b'>
<div class='caja_l'>
<div class='caja_r'>
<div class='caja_t'>
<div class='caja_b'>
<div class='caja_contenido contenido_videos'>
<ul><li><h3><a title='&Uacute;ltimos Videos de Legacy'>&Uacute;ltimos Videos</a></h3></li></ul>
<script type='text/javascript'>
stat['EELCzh8ntTM']=0;
pic['EELCzh8ntTM']=new Array();
pics['EELCzh8ntTM']=new Array(1,1,1,1);
stat['DtOo-TM2IzE']=0;
pic['DtOo-TM2IzE']=new Array();
pics['DtOo-TM2IzE']=new Array(1,1,1,1);
</script>
<div class='videos'>
<ul>
<li class='video'>
<a >
<img src="https://i4.ytimg.com/vi/EELCzh8ntTM/default.jpg" width='100' height='100' border='0' alt='M E Z C L A D I T O  - Ver video' id='EELCzh8ntTM' onmouseout='endm("EELCzh8ntTM"); this.src="http://i4.ytimg.com/vi/EELCzh8ntTM/default.jpg";' onmouseover='startm("EELCzh8ntTM","http://i4.ytimg.com/vi/EELCzh8ntTM/",".jpg");' />
</a>
</li>
<li class='video'>
<a >
<img src="https://i4.ytimg.com/vi/DtOo-TM2IzE/default.jpg" width='100' height='100' border='0' alt='Torneo de Titanes - Ver video' id='DtOo-TM2IzE' onmouseout='endm("DtOo-TM2IzE"); this.src="http://i4.ytimg.com/vi/DtOo-TM2IzE/default.jpg";' onmouseover='startm("DtOo-TM2IzE","http://i4.ytimg.com/vi/DtOo-TM2IzE/",".jpg");' />
</a>
</li>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>

<?php require_once $_SERVER["DOCUMENT_ROOT"] . "/footer.php"; ?>
