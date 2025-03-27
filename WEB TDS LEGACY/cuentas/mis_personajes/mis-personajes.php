<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_logged();

?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>    
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta name="csrf_token" content="<?php echo createToken(); ?>" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, de TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor de TDS Legacy, Server de TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje">
    <!--[if lt IE 7.]>
<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
<![endif]-->
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
      
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>

    <script type="text/javascript" src="/cuentas/mis-personajes.js"></script>

    <style type="text/css">
        td {font-size: 9pt;text-align: left;color: #ccc;}
        .image-container {position: relative;width: 300px;height: 300px;}
        .follow-image {position: absolute;width: 100px;height: 100px;}
    </style>
    <link href="/header.css" rel="stylesheet" type="text/css">

    
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: block; background: none; width: 700px; height: 197px;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top: 0px; left: 0px; display: none; height: 197px; width: 700px; text-align: center;"> <span style="display: inline-block; height: 100%; vertical-align: middle;"></span> <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%"></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>            
            <div class="titulo_seccion">
                <h1>Panel de Cuenta</h1>
            </div>
            <div id="main">
                <div id="panel-premium">
                    <div class="cuentas_premium" style="text-align:left;">
                        <div class="tit">
                            <h1>Panel de <?php echo $_SESSION['username'] ?></h1>
                            <?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
                        </div>
                        <div id="centro_panel" style="width:500px;">
                            <div style="text-align: center;padding:8px;" id="panel-premium">
                                <h1>Mis personajes</h1>
                            </div>
                            <div id="panel-premium">
                                <div class="pjsf">
                                    <?php


            $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
            $seconds_diff = $ts2 - $ts1;
            $premium=false;
            if($seconds_diff > 0) $premium=true;


 $sql = "SELECT * FROM user WHERE account_id=?;";
    $stmt = mysqli_stmt_init($conn);
    $tengopj=false;
                
if (!mysqli_stmt_prepare($stmt, $sql)) {

        $_SESSION['ERRORS']['err'] = 'SQL ERROR';
    } 

    else {    
        mysqli_stmt_bind_param($stmt, "s", $_SESSION['id']);
        mysqli_stmt_execute($stmt);
        
        $result = mysqli_stmt_get_result($stmt); 

        if (mysqli_num_rows($result) > 0) {
             
             while($row = mysqli_fetch_assoc($result)){
                $tengopj=true;
                
                $usernick = $row['nick'];
                
                if ($row['ban'] == 1) {
                    $usernick= '<s >'.$usernick."</s>";
                    
                    if (strlen($row['unbandate'])>0) 
                        $usernick.=' <small >[BANEADO HASTA EL '.$row['unbandate'] .']</small>';
                    else                        
                        $usernick.=' <small >[BANEADO PERMANENTE]</small>';
                }  

                switch ($row['raza']) {
                    case 'HUMANO':
                        $cabeza='cHumano';
                        break;
                    case 'ELFO':
                        $cabeza='cElfo';
                        break;
                    case 'ELFO OSCURO':
                        $cabeza='cEO';
                        break;
                    case 'GNOMO':
                        $cabeza='cGnomo';
                        break;
                    case 'ENANO':            
                    default:
                        $cabeza='cEnano';                        
                        break;
                }
               echo '<a class="cabeza '.$cabeza.'" href="?a=info&nick=' .$row['nick'] .'" title="Ver estadisticas de el personaje" style="margin-top:10px"> ' .$usernick .' </a>' ;
 
               echo '<table style="width:100%""><tbody><tr><td>' .$row['clase'] .' ' .$row['raza'] .' nivel ' .$row['nivel'] .'<br>Estado: ';

               $ups=intval($row['ups']);
                $tmp="";
                if ($ups> 0) {
                     $color='#00ff22';
                     $tmp="+";
                }elseif ($ups < 0) {
                   $color='#e50000';
                }else
                    $color= '#fff';

               if ($row['logged'] <> 0) {
                echo '<b id="log" style="color:#29da30">Online</b>';
               }else{
                echo '<b id="log">Offline</b>';
                }
                echo '<br>Vida: ' . $row['min_hp'] .' <b style="color:' .$color .'">[' .$tmp .$ups.']</b>';

                if ($row['exp'] ==0 || $row['elu'] ==0) {
                    echo '<br>Exp: 0/'.number_format($row['elu'], 0, ",", ".").' [0%]' ;
                }else
                    echo '<br>Exp: ' . number_format($row['exp'], 0, ",", ".") . '/' .number_format($row['elu'], 0, ",", ".") .' ['  . Round($row['exp'] * 100 / $row['elu'],2)  .'%]' ;
    

                echo '<br>Oro: ' . (number_format($row['oro']+ $row['boveda'], 0, ",", ".")) . ' ('.number_format($row['oro'], 0, ",", ".") .' en billetera y ' .number_format($row['boveda'], 0, ",", ".") .' en banco)</td>';
             
                //ucasear

                

                echo '<td style="text-align:right;width:150px;">';
                echo '<form name="m_'. strtoupper($row['nick']) .'" id="m_'.$row['nick'].'" onsubmit="return false">
                <input id="r_'.$row['nick'].'" class="input" type="text" maxlength="2" name="nick" value="'.$row['nick'].'" style="display:none;" />';
                if ($row['ban'] == 0)  {
                    
                    if ($row['locked'] > 0)
                        if($premium) echo '<a id="b' .$row['nick'] .'" style="font-size:12px;display:inline;" href="#" onclick="return bloquear(' ."'" .$row['nick'] . "')" .'" title="Si desbloqueas el personaje podrás loguear éste personaje">Desbloquear</a><br>';
                    else
                        if($premium) echo '<a id="b' .$row['nick'] .'" style="font-size:12px;display:inline;" href="#" onclick="return bloquear(' ."'" .$row['nick'] . "')" .'" title="Si bloqueas el personaje no podrias ingresar con este al juego hasta que lo desbloquees">Bloquear</a><br>';

                    if ($row['logged'] <> 0) {
                        if($premium) echo '<a id="l' .$row['nick'] .'" style="font-size:12px;display:inline;" href="#" onclick="return desloguear(' ."'" .$row['nick'] . "')" .'">Desloguear</a><br>';
                    }
                    echo '<a style="font-size:12px;padding:0;height:13px;display:inline;" href="?a=info&nick=' .$row['nick'] .'" title="Ver estadisticas de el personaje">Ver estadisticas</a>';
                    if($premium) echo '<br><a id="r' .$row['nick'] .'" style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" onclick="return recuperarpj(' ."'" .$row['nick'] . "')" .'">Recuperar clave</a>';
                    if($premium) echo '<br><a style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" href="?a=transferir&de=' .$row['nick'] .'">Transferir items y oro</a>';
                     
                    echo '<br><a style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" href="?a=quitar-personaje&i=1&n=' .$row['nick'] .'">Quitar personaje</a>'; 
                    
                    
                    if ($row['logged'] == 0 && $row['nivel'] < 14 ) {
                        echo '<br><a style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" href="?a=borrar-personaje&i=1&n=' .$row['nick'] .'">Borrar personaje</a>';
                    }
                    
                    echo '</td></tr></tbody></table>'; 
                }                     
                else{
                    if (strlen($row['unbandate'])>0) echo '<a id="b' .$row['nick'] .'" style="font-size:12px;display:inline;" href="#" onclick="return bloquear(' ."'" .$row['nick'] . "')" .'" title="Si bloqueas el personaje no podrias ingresar con este al juego hasta que lo desbloquees">Bloquear</a><br><a style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" href="?a=rec-clave&i=1&n=' .$row['nick'] .'">Recuperar clave</a>';
                    echo '<br><a style="font-size:12px;margin:0;padding:0;height:13px;display:inline;" href="?a=quitar-personaje&i=1&n=' .$row['nick'] .'">Quitar personaje</a></td></tr></tbody></table>'; 
                }
                echo '</form>';
             }
        }
    } 
?></div>                                
                                <?php 
                                if ($tengopj) {
                                    echo '<big id="cuentasPremium"><a href="?a=agregar-personaje" id="Submit" style="text-align:center">Agregar PJ</a></big>';
                                }else
                                    echo '<div id="panel-premium">No tenés ningún personaje adherido a tu cuenta. Para agregar un personaje haz click en <a href="?a=agregar-personaje" id="Submit">Agregar Personaje</a>.</div>';
                                ?></div>

<script>
                                    var imageContainers = document.querySelectorAll(".image-container");

                                    imageContainers.forEach(function(container) {
                                        var followImage = container.querySelector(".follow-image");

                                        container.addEventListener("mousemove", function(event) {
                                            var offsetX = event.clientX - container.getBoundingClientRect().left - container.clientWidth / 2;
                                            var offsetY = event.clientY - container.getBoundingClientRect().top - container.clientHeight / 2;

                                            var angle = Math.atan2(offsetY, offsetX);
                                            var angleDeg = angle * (180 / Math.PI);

                                            followImage.style.transform = "translate(-50%, -50%) rotate(" + angleDeg + "deg)";
                                        });
                                    });
                                </script>
                        </div>
                    </div>
                </div>
               