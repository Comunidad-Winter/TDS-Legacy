<?php

   $fichero = 'historial_de_noticias_count.txt';

   $actual = file_get_contents($fichero);

   $sth = mysqli_query($conn, 'SELECT * FROM noticias ORDER BY fecha DESC');

   $tot= mysqli_num_rows($sth);
   $htmlfile= file_exists('historial_de_noticias.php');
   
   if (!$htmlfile) {$actual=0;$tot=0;} //no hay noticias, generamos html

   setlocale(LC_ALL, "es_ES", 'Spanish_Spain', 'Spanish'); 
   
   if (!($tot == $actual && $htmlfile) ){
      $html='
<!DOCTYPE html
   PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Historial de Noticias</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />

    <link href="" rel="stylesheet" type="text/css" />
    <link href="/caja.css" rel="stylesheet" type="text/css" />
    <link href="historial_de_noticias.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
    </style>
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
            <div id="menu">
                <div class="arriba">
                    <ul>
                        <li><a href="/index.php" id="inicio" title="Inicio AO Legacy">Inicio</a></li>
                        <li><a href="/cuenta-premium.php" id="premium" title="Accede a tu cuenta">Cuenta</a></li>
                        <li><a href="#wiki" id="manual" title="Manual Legacy">Manual</a></li>
                        <li><a href="#foro"  id="foro" title="Foro oficial Legacy">Foro</a></li>
                        <li><a href="/soportes.php" id="soporte" title="Soporte Legacy">Soporte</a></li>
                        <li class="ultimo"><a href="staff.php" id="staff" title="Staff Legacy">Staff</a></li>
                    </ul>
                </div>
                <div class="abajo">
                    <ul>
                        <li><a href="/ranking.php" id="ranking" title="Ranking Legacy">Ranking</a></li>
                        <li><a href="/top50.php" id="top50" title="Top 50 Legacy">Top 50</a></li>
                        <li><a href="/retos.php" id="retos" title="Retos Legacy">Retos</a></li>
                        <li><a href="/reglamento.php" id="reglamento" title="Reglamento del juego">Reglas</a></li>
                        <li class="ultimo jugadores_online">
                            <div id="online"><a href="online.php" rel="nofollow" title="Ver estado de los servidores" style="color:#FFC000;font-family:"Trebuchet MS";font-size:10.5pt;font-weight:bold;">Jugadores Onlines</a></div>
                        </li>
                    </ul>
                </div>
            </div>
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
                                                        <div class="contenido_historial">';

      $curYear=0;
      $curMonth=0;
      $tot=0;
      $rowsNews = array (); 
      while($row = mysqli_fetch_assoc($sth)){
        
        $tot++;
        $rowsNews [] = $row; 

         $DAY_NAME=ucfirst(iconv('ISO-8859-2', 'UTF-8', strftime("%A" ,strtotime($row['fecha']))));
         $DAY_NUMBER=iconv('ISO-8859-2', 'UTF-8', strftime("%d" ,strtotime($row['fecha'])));
         $MONTH=ucfirst(iconv('ISO-8859-2', 'UTF-8', strftime("%B" ,strtotime($row['fecha']))));
         $MONTH_NUMBER=iconv('ISO-8859-2', 'UTF-8', strftime("%m" ,strtotime($row['fecha'])));
         $YEAR=iconv('ISO-8859-2', 'UTF-8', strftime("%Y" ,strtotime($row['fecha'])));
         $NEWS_ID=$row['number'];
         $AUTHOR=$row['autor'];
         $TITLE=$row['titulo'];

         if ($curYear <> $YEAR ) {

            $html.='<h1 style="font-size: 13pt;" title="Noticias del año ' .$YEAR .'">Año ' .$YEAR .'</h1>';
            $curYear=$YEAR;
            $curMonth=0;

         }

         if ($curMonth <> $MONTH_NUMBER ) {

            $html.='<h2 title="' .$MONTH .' del año ' .$YEAR .'">' .$MONTH .'</h2>';
            $curMonth=$MONTH_NUMBER;
         }
         

         $html .= '<h3 title="' .$TITLE .' posteada el ' .$DAY_NAME .' ' .$DAY_NUMBER .' de ' .$MONTH .' por ' .$AUTHOR .'"><a title="' .$TITLE .' posteada el ' .$DAY_NAME .' ' .$DAY_NUMBER .' de ' .$MONTH .' por ' .$AUTHOR .'" href="noticia.php?n=' .$NEWS_ID .'">' .$DAY_NAME .' ' .$DAY_NUMBER .' - ' .$TITLE .'</a></h3>';
      }
      //end of news

      $html .= "</div>
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

</html>";
 

      //echo $html;
      file_put_contents('historial_de_noticias.php',$html);
      file_put_contents($fichero,$tot);

   }
 
 ?>