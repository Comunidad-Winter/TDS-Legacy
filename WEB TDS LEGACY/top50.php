
<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

 ?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<title>AO Legacy - Top 50 de personajes</title>

<!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->

<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/caja.css' rel='stylesheet' type='text/css' />
<link href='/top50.css' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'></style>
</head>
<body id="seccion_top50" onload="init();">

<div id='bg_top'>

<div id='pagina'>

<div id='header'> <div id="animation_container" style="background:none; width:700px; height:197px"> <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas> <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div> </div> <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div> </div>

<?php
    require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>

<div class='titulo_seccion'>
<h1 id="titulo_seccion">Ranking de los 50 personajes m&aacute;s poderosos </h1>
</div>

<div id='main'>

    <div>

         <?php                    
            
            $result = $conn->query("SELECT nick, nivel, clase, clan, (exp / elu) * 100 AS porcentaje FROM user WHERE privilegios = 1 ORDER BY nivel DESC LIMIT 50");

            echo '<div id="tabla_top50"><div class="top50_bg"></div>';
            $puesto=0;
            while ($row = $result->fetch_array()) {
                $puesto++;
                if (strlen($row['clan'] )<=0) 
                    $clan=" ";
                else
                    $clan = $row['clan'];

                if ($row['nivel'] == 47) 
                    $porc = '-';
                else{
                    if ($row['porcentaje'] > 100) $row['porcentaje'] = 100;
                    $porc= number_format($row['porcentaje'],0) .'%';
                }

                echo '<div class="puesto"><ul>';
                echo '<li class="nro">' . $puesto . 'º</li>';
                echo '<li class="nick"><a rel="nofollow" href="mini_estadisticas.php?nick=' . $row['nick'] . '" title="Ver estadísticas de ' . $row['nick'] . '">' . $row['nick'] . '</a></li>';
                echo '<li class="lvl">' . $row['nivel'] . '</li>';
                echo '<li class="clase">' . $row['clase'] . '</li>';
                echo '<li class="clan">' . $clan. '</li>';
                echo '<li class="exp">' . $porc . '</li>';
                echo '</ul></div>';
            }
            echo '</div>';
         
         ?>

    </div>


    <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>