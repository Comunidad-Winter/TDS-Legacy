<?php 

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();

 ?>

<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Ranking de Retos</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/retos.css' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body id="seccion_retos" onload="init();">
    <div id='bg_top'>
        <div id='pagina'>
            <div id='header'>
                <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
                    <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1 id="titulo_seccion">Ranking de Retos </h1>
            </div>
            <div id='main'>
                <div>
                    <div id="tabla_retos">
                        <div class="retos_bg"></div>
                         
                        <?php
                            // Consulta para obtener los datos de los duelistas
                            $result = $conn->query("SELECT nick, nivel, retos_ganados, retos_perdidos, retos_oro_ganado, retos_oro_perdido FROM user WHERE privilegios = 1 ORDER BY retos_ganados DESC LIMIT 9");
                            // Almacenamos los resultados de la consulta en un arreglo
                            $duelistas = array();
                            while ($row = $result->fetch_assoc()) {
                                $duelistas[] = $row;
                            } 
                            // Recorremos el arreglo de duelistas y generamos una fila para cada uno
                            foreach ($duelistas as $i => $duelista) {
                                $puesto = "puesto";
                                if ($i == 0) {
                                    $puesto = "primer_puesto";
                                } else if ($i == 1) {
                                    $puesto = "segundo_puesto";
                                } else if ($i == 2) {
                                    $puesto = "tercer_puesto";
                                }

                                $oro_ganado = '';
                                if ($duelista['retos_oro_ganado'] >= 1000000) {
                                    $oro_ganado = number_format($duelista['retos_oro_ganado'] / 1000000, 1, '.', '') . 'kk';
                                } else if ($duelista['retos_oro_ganado'] >= 1000) {
                                    $oro_ganado = number_format($duelista['retos_oro_ganado'] / 1000, 0, '.', '') . 'k';
                                } else {
                                    $oro_ganado = $duelista['retos_oro_ganado'];
                                }
                                $oro_perdido = '';
                                if ($duelista['retos_oro_perdido'] >= 1000000) {
                                    $oro_perdido = number_format($duelista['retos_oro_perdido'] / 1000000, 1, '.', '') . 'kk';
                                } else if ($duelista['retos_oro_perdido'] >= 1000) {
                                    $oro_perdido = number_format($duelista['retos_oro_perdido'] / 1000, 0, '.', '') . 'k';
                                } else {
                                    $oro_perdido = $duelista['retos_oro_perdido'];
                                }

                                echo '<div class="' . $puesto . '">';
                                echo '<ul>';
                                if ($i < 3) {
                                    echo '<li class="nick" title="Personaje: ' . $duelista['nick'] . '">' . $duelista['nick'] . '</li>';
                                } else {
                                    echo '<li class="nro">' . ($i + 1) . 'º</li>';
                                    echo '<li class="nick" title="Personaje: ' . $duelista['nick'] . '">' . $duelista['nick'] . '</li>';
                                }
                                echo '<li class="lvl">' . $duelista['nivel'] . '</li>';
                                echo '<li class="rg">' . $duelista['retos_ganados'] . '</li>';
                                echo '<li class="og">' . $oro_ganado . '</li>';
                                echo '<li class="rp">' . $duelista['retos_perdidos'] . '</li>';
                                echo '<li class="op">' . $oro_perdido . '</li>';
                                echo '</ul>';
                                echo '</div>';
                            }
                             
                        ?>
                        <div class="aclaracion"><span>Ultima actualizaci&oacute;n: <?php echo date('d/m/Y H:i:s T') . ' GMT'; ?></span></div>
                    </div>
                </div>
                <div class="aclaracion"><span>(*)Valido para retos 1vs1. El ranking se ordena teniendo en cuenta la diferencia
                        de los retos ganados menos los retos perdidos. Solo se cuentan, por dia (desde las 00 hasta las 23:59), los
                        primeros dos retos que se realizan entre personajes de la misma cuenta. El Nivel es el promedio de los
                        niveles de todos los personajes utilizados por la cuenta en los retos. Puedes ver el nombre de los
                        personajes poniendo el mouse arriba del nombre de la cuenta.<br />
                        (*) Cada 'k' equivale a multiplicar por 1000 el n&uacute;mero.</span></div>
<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>