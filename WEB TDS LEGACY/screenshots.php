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
    <!--[if lt IE 7.]>
    <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
    <![endif]-->
    
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="fotos.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="/comentarios/coments.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/scripts/fotos.js"></script>
    <script type="text/javascript" src="/comentarios/comentarios.js"></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
    </head>
    <body onload="init();">
         
    
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
    <h1>Fotos del juego</h1>
    </div>
    
    
    <div id="main">
    
    <div>
    <div class="fotos_nav">
    <div id="f_izq" class="fotos_flecha_izq"></div>
    <div class="fotos_thumbs" style="clear:right;">
    <ul>
    <li onclick="javascript:con(0)" id="pj0" class=""><a href="javascript:show('2205032458w')"><img src="/screens/undefinedt.jpg" alt="titanazooo" border="0"></a></li>
    <li onclick="javascript:con(1)" id="pj1" class=""><a href="javascript:show('undefinedt')"><img src="/screens/undefinedt.jpg" alt="Gracias Tirri !!!" border="0"></a></li>
    <li onclick="javascript:con(2)" id="pj2" class=""><a href="javascript:show('undefinedt')"><img src="/screens/undefinedt.jpg" alt="C/V> Pjsss" border="0"></a></li>
    <li onclick="javascript:con(3)" id="pj3" class=""><a href="javascript:show('undefinedt')"><img src="/screens/undefinedt.jpg" alt="Nos Vemos R.G el Colo" border="0"></a></li>
    <li onclick="javascript:con(4)" id="pj4" class=""><a href="javascript:show('undefinedt')"><img src="/screens/undefinedt.jpg" alt="Boqueas para perder 2-0?" border="0"></a></li>
    </ul>
    </div>
    <div id="f_der" class="fotos_flecha_der"><a href="javascript:move(2)"></a></div>
    </div>
    <div class="fotos_tit">
    <div class="fotos_tit_l">
    <div class="fotos_tit_r">
    <div class="fotos_tit_t">
    <div class="fotos_tit_b">
    <div class="contenido">
    <h2><span id="nombre_foto">titanazooo</span></h2>
    </div>
    </div>
    </div>
    </div>
    </div>
    </div>
    <div class="fotos_big_bottom">
    <div class="fotos_big_top">
    <div class="foto_big">
    <div id="imagen"><a href="#" title="Ver imagen en tamaño real" onclick="return verimagen('2205032458w')"><img src="/screens/2205032458w.jpg" width="556" height="417" border="0"></a></div>
    <div class="fotos_big_top">
    <table cellpadding="0" cellspacing="0" border="0">
    <tbody><tr>
    <td valign="top" align="center" class="fotos_desc_tit">Descripción:<br><img src="/imagenes/fotos/fotos_desc_img.gif" alt="" style="margin-top:5px;"></td>
    <td rowspan="2" valign="top" id="descripcion" class="fotos_desc"><p> .................................................</p></td>
    <td class="fotos_desc_sep" valign="top"><img src="/imagenes/fotos/fotos_desc_sep_top.gif" alt=""></td>
    <td rowspan="2" style="padding:5px;">
    <table cellpadding="0" cellspacing="0" border="0">
    <tbody><tr>
    <td class="fotos_desc_tit">Posteada por:</td>
    <td id="usuario" class="fotos_desc_txt">tomsxd</td>
    </tr>
    <tr>
    <td class="fotos_desc_tit">Categoría:</td>
    <td id="categoria" class="fotos_desc_txt">Todas</td>
    </tr>
    <tr>
    <td class="fotos_desc_tit">Vista:</td>
    <td id="vista" class="fotos_desc_txt">7542 veces</td>
    </tr>
    <tr>
    <td class="fotos_desc_tit">Fecha</td>
    <td id="fecha" class="fotos_desc_txt">09/08/21</td>
    </tr>
    <tr>
    <td class="fotos_desc_tit">Calificación:</td>
    <td id="valoracion" class="fotos_desc_txt"><a href="#" title="2/5 - 2 votos."><img src="/imagenes/fotos/rating_1.gif" style="border:0;"></a><a href="#" title="2/5 - 2 votos."><img src="/imagenes/fotos/rating_1.gif" style="border:0;"></a><br></td>
    </tr>
    </tbody></table></td>
    </tr>
    <tr>
    <td></td>
    <td valign="top"><img src="/imagenes/fotos/fotos_desc_sep_bottom.gif" alt=""></td>
    </tr>
    </tbody></table>
    </div>
    </div>
    </div>
    </div>
    </div>
    <div id="comentarios">10</div>
    <div align="left" onclick="javascript:ocultar();" id="imagengrande" style=" cursor:hand; left:1%; position:absolute; display:none;"></div>
<script type="text/javascript">move(0);</script>
    

<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>