
<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

    $onlines= file_get_contents('numusers.log');

    $result = $conn->query('SELECT * FROM world');
    $onlines=0;
    $online=0;
    
	if ($result->num_rows > 0) 
	  while($row = $result->fetch_assoc()) {
      $onlines=$row['onlines'];
      $online=$row['sv_on'];
    }

 ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Estado de los servidores</title>
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/noticia.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body onload="init();">
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
                <h1>Estado de los servidores</h1>
            </div>
            <div id='main'>
                <div id='contenido'>
                    <div class='caja_margen'>
                        <div class='caja'>
                            <div class='caja_shadow_t'>
                                <div class='caja_shadow_b'>
                                    <div class='caja_l'>
                                        <div class='caja_r'>
                                            <div class='caja_t'>
                                                <div class='caja_b'>
                                                    <div class='caja_noticia'> 
                                                        <h2>Estado</h2>
                                                        <p style="text-align:center;"><?php if ($online==0) echo 'Servidor Offline'; else echo 'Jugadores Online: '.$onlines?></p>
                                                        <div class='por_l'>
                                                            <div class='por_r'>
                                                                <div class='por_contenido'> <span class='dato'>AO Legacy</span></div>
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
                </div>
                <div class="link_volver"><br /><a href="javascript:history.back()">Volver</a></div>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>