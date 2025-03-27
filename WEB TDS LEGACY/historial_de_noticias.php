
<!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

    <meta charset="iso-8859-1">
    <meta http-equiv="Content-Language" content="es" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <meta name="title" content="AO Legacy - MMORPG Juego de Rol Multijugador Online Gratuito" />

    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Historial de Noticias</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />

    <link href="/general.css" rel="stylesheet" type="text/css" />
    <link href="/caja.css" rel="stylesheet" type="text/css" />
    <link href="historial_de_noticias.css" rel="stylesheet" type="text/css" />
    <link href="/header.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
</head>

<body id="seccion_historial" onload="init();">
    
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;">
                    <span style="display: inline-block; height: 100%; vertical-align: middle;"></span> <img src=/header_images/_preloader.gif style="vertical-align: middle; max-height: 100%" />
                </div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class="titulo_seccion">
                <h1>Todas las noticias de AO Legacy</h1>
            </div>
            <div id="main">
                <div class="contenido">
                    <div class="caja_margen">
                        <div class="caja">
                            <div class="caja_shadow_t">
                                <div class="caja_shadow_b">
                                    <div class="caja_l">
                                        <div class="caja_r">
                                            <div class="caja_t">
                                                <div class="caja_b">
                                                    <div class="caja_noticia">
                                                        <h1 class="h2">Historial de noticias</h1>
                                                        <div class="contenido_historial"><h1 style="font-size: 13pt;" title="Noticias del año 2024">Año 2024</h1><h2 title="Sin historial"></h2><h3 title=""><a title="" href="noticia.php?n=1"></a></h3></div>
      <br/></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <div class='clear'></div>
                </div>
            </div></div>
        <div class='bottom'><img src='/imagenes/bg_pagina_bottom.png' alt='Todos los derechos reservados - AO Legacy - AOI - Argentum Online' /></div>
    </div>
    
</body>

</html>