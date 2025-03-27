<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

 ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Ranking de personajes</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/ranking.css' rel='stylesheet' type='text/css' />
    <link rel="stylesheet" type="text/css" href="menu/menu.css" />
    <script type="text/javascript" src="/menu/menu.js"></script>
    <script type="text/javascript" src="/scripts/verclase.js"></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body id="seccion_ranking" onload="init();">
    <div id='bg_top'>
        <div id='pagina'>
            <div id='header'>
                <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div>
                </div>
                <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1 id="titulo_seccion">Ranking de niveles</h1>
            </div>
            <div id='main'>
                <div>
                    <div class="ranking">
                        <div class="ranking_bg">
                            <div class="elegi_clase">
                                <div class="chromestyle" id="chromemenu">
                                    <ul>
                                        <li><a href="#" rel="dropmenu1"><span style="display:none">Elegi la Clase</span></a></li>
                                    </ul>
                                </div>
                                <div id="dropmenu1" class="dropmenudiv" style="width:133px;">
                                    <div class="dropmenudiv_top"><span style="display:none">top</span></div>
                                    <span class="clases_combate">Clases de Combate</span>
                                    <a href="JavaScript:verclase('3')">Guerrero</a>
                                    <a href="JavaScript:verclase('9')">Cazador</a>
                                    <a href="JavaScript:verclase('8')">Palad&iacute;n</a>
                                    <a href="JavaScript:verclase('1')">Mago</a>
                                    <a href="JavaScript:verclase('7')">Druida</a>
                                    <a href="JavaScript:verclase('6')">Bardo</a>
                                    <a href="JavaScript:verclase('5')">Ladr&oacute;n</a>
                                    <a href="JavaScript:verclase('2')">Cl&eacute;rigo</a>
                                    <a href="JavaScript:verclase('4')">Asesino</a>
                                    <a href="JavaScript:verclase('15')">Pirata</a>
                                    <span class="clases_trabajadoras">Clases Trabajadoras</span>
                                    <a href="JavaScript:verclase('14')">Carpintero</a>
                                    <a href="JavaScript:verclase('12')">Le&ntilde;ador</a>
                                    <a href="JavaScript:verclase('11')">Herrero</a>
                                    <a href="JavaScript:verclase('13')">Minero</a>
                                    <a href="JavaScript:verclase('10')">Pescador</a>
                                    <div class="dropmenudiv_bottom"><span style="display:none">bottom</span></div>
                                </div>
                                <script type="text/javascript">
                                cssdropdown.startchrome("chromemenu")
                                </script>
                            </div>
                        </div>
                        <div id="tabla_ranking">
                            <script type="text/javascript">
                            verclase('1');
                            </script>
                        </div>
                    </div>
                </div>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>