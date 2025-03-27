<?php                   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

    require_logged();

?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>AO Legacy - Cuenta</title>
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="/encuestas.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/cuentas/encuestas/encuestas.js"></script>
    <script type="text/javascript" src="/comun/js/jquery-min.js"></script>
    <style type="text/css">
    .subpen li {
        height: 16px;
        padding-bottom: 2px;
    }

    .anuevo {
        color: #0f5;
    }
    </style>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;">
                    <span style="display: inline-block; height: 100%; vertical-align: middle;"></span>
                    <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%">
                </div>
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
                        <div id="centro_panel">
                            <div class="izq" style="width: 500px;">
                                <ul class="beneficios">
                                    <li>
                                        <b>Información de cuenta:</b><?php 
                    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';


                    $sql = "SELECT * FROM cuentas WHERE username=?;";
                    $stmt = mysqli_stmt_init($conn);

                    if (!mysqli_stmt_prepare($stmt, $sql)) {

                        $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                        header("Location: /cuenta-premium.php");
                        exit();
                    } 
                    else {

                        mysqli_stmt_bind_param($stmt, "s", $username);
                        mysqli_stmt_execute($stmt);

                        $result = mysqli_stmt_get_result($stmt);

                        if ($row = mysqli_fetch_assoc($result)) {
                            $pwdCheck = (strcmp($password,$row['password'])==0);//password_verify($password, $row['password']);
                            if ($pwdCheck) {
                                $_SESSION['oro']= $row['oro'];
                                $_SESSION['premium_at']= $row['premium_at'];
                                
                                $_SESSION['user_level'] = $row['user_level'];
                                $_SESSION['banned'] = intval($row['banned']);
                                $_SESSION['ban_reason'] = $row['ban_reason'];
                                
                                $_SESSION['updated_at'] = $row['updated_at'];
                                $_SESSION['oro'] = intval($row['oro']);
                                $_SESSION['gm'] = intval($row['GM']) ;
                                $_SESSION['tdspesos'] = intval($row['tdspesos']) ;
                                $_SESSION['premium_at'] = $row['premium_at'] ;
                            }
                        }
                    }
                    
                      $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
                      $seconds_diff = $ts2 - $ts1;

                      if ($seconds_diff <= 0) {
                        echo '<p></p><table cellpadding="0" cellspacing="0" border="0" style="width:480px;" align="center" id="alerta"><tbody><tr><td id="alerta_critico"><img src="/imagenes/cuentas/alerta_critico.gif" alt=""><p>¡Alerta! Tu Cuenta Premium está vencida. Para poder disfrutar de todos los beneficios exclusivos debes adquirir tiempo haciendo click <a href="?a=adquirirtiempo" title="¡Adquirí más tiempo para tu Premium!">aquí</a>.</p></td></tr></tbody></table><br>';}else echo '<p>Tu premium vence el día: ' .$_SESSION['premium_at'] .' <a href="?a=adquirirtiempo"><small>>Adquirir tiempo premium<</small></a><br>' ; {
                      }
                                            $now = new DateTime();
                                            $newcolor=' style="color:#00ff5feb;" ';
                                            
                                            $fecha_actual = date('d-m-Y h:i:s',time());
                                            $timestamp_actual = strtotime($fecha_actual);

                                            $fecha='';

                      ?>Última conexión:
                                        <?php echo date("d-m-Y h:i:s", strtotime($_SESSION['last_login_at'])); 
                                         $saldo = get_tdspesos();
                                        ?>
                                        <br>Saldo actual: $ <?php echo $saldo;?> <a href="?a=agregar-tdsl"><small>>Adquirir AO$<</small></a>
                                        
                                    </li>
                                    <li>
                                        <b>Anuncios:</b><br>
                                        <ul class="beneficios subpen">
                                            <?php

                                                $sectorType = array(
                                                    0 => 'Normal',
                                                    1 => 'Bug',
                                                    2 => 'Ban',
                                                    7 => 'Problema Técnico',
                                                    9 => 'Denuncia GMs',
                                                    11 => 'Robo de PJ/Estafa',
                                                    15 => 'Otro',
                                                    16 => 'Cuentas',
                                                    17 => 'Nick inapropiado',
                                                    20 => 'Denuncia de cheater',
                                                    21 => 'Foro',
                                                    22 => 'Quite T0 ingame',
                                                    23 => 'Discord',
                                                    5 => 'random'
                                                );

                                                $consulta = 'SELECT * FROM anuncios WHERE account_id=' .$_SESSION['id'] .' AND tipo IN (1, 2, 3, 4) AND deleted=0 ORDER BY fecha DESC LIMIT 15';
                                                if ($resultado = $conn->query($consulta)) {
                                                
                                                    $anunType = array(
                                                        1 => 'anunAlert',
                                                        2 => 'anunInfo',
                                                        3 => 'anunCrit',
                                                        4 => 'anunSAlert'
                                                    );   

                                                    while ($fila = $resultado->fetch_row()) {
 
                                                        $color=$newcolor;
                                                        $timestamp_final = strtotime($fila[5]);
                                                        $diferencia = $timestamp_final - $timestamp_actual;
                                                        $dias = $diferencia / 86400;
                                                        $dias = abs(floor($dias));
                                                        
                                                        if (abs($diferencia) > 86400*2 ) {
                                                            $fecha= "Hace " . floor(abs($diferencia)/86400) . " días";
                                                            $color="";
                                                        } elseif (abs($diferencia) > 86400*1) {
                                                            $fecha= "Ayer";
                                                            $color="";
                                                        } else {
                                                          $fecha= "Hoy";
                                                          $color=$newcolor;
                                                        }
                                                        $fecha = '<abbr style="text-decoration: none;" title="' . $fila[5] .  '">' . $fecha . '</abbr>';


                                                        echo '<li class="' .$anunType[$fila[3]] .'" '.$color.'><b>' .$fila[4] .'</b> <small >' .$fecha . ' [<a title="Borrar" href="?a=mi-premium&amp;borrara=' .$fila[0] .'">X</a>]</small></li>';
                                                    }                          
                                                    if (mysqli_num_rows($resultado) == 0) echo '<li class="anunInfo"><b>No hay anuncios.</b></li>';
                                                    $resultado->close();
                                                }
                                            ?>
                                        </ul>
                                        <p style="height:3px!important;font-size:1px;">&nbsp;</p>
                                    </li>
                                    <li class="monedas">
                                        <b><a href="?a=tienda">Tienda (NUEVO)</a></b><br>
                                        <ul class="beneficios subpen" style="display:inline;">
                                            <li><a href="?a=tienda">Haz click aqui para ingresar a la tienda online.</a></li>
                                        </ul>
                                        <p style="height:3px!important;font-size:1px;">&nbsp;</p>
                                    </li>
                                    <li class="medalla">
                                        <b><a href="?a=mercado">MercadoAO</a></b><br>
                                        <ul class="beneficios subpen">
                                            <?php 
                                                $tot=0;
                                                $consulta = 'SELECT * FROM anuncios WHERE account_id=' .$_SESSION['id'] .' AND tipo IN (5, 6, 7, 8, 9) AND deleted=0 ORDER BY fecha DESC LIMIT 7';
                                                if ($resultado = $conn->query($consulta)) {                            
                                                    $anunMAOTypes = array(
                                                        5 => 'rCompra',
                                                        6 => 'fInter',
                                                        7 => 'aInter',
                                                        8 => 'rInter',
                                                        9 => 'pInter'
                                                    );
                                                    while ($fila = $resultado->fetch_row()) {


                                                        $color="";
                                                        $timestamp_final = strtotime($fila[5]);
                                                        $diferencia = $timestamp_final -$timestamp_actual;
                                                        $dias = $diferencia / 86400;
                                                        $dias = abs(floor($dias)); 

                                                        if (abs($diferencia) > 86400*2 ) {
                                                            $fecha= "Hace " . floor(abs($diferencia)/86400) . " días";
                                                            $color="";
                                                        } elseif (abs($diferencia) > 86400*1) {
                                                            $fecha= "Ayer";
                                                            $color="";
                                                        } else {
                                                          $fecha= "Hoy";
                                                          $color=$newcolor;
                                                        }
                                                        $fecha = '<abbr style="text-decoration: none;" title="' . $fila[5] .  '">' . $fecha . '</abbr>';
                                                        $tot++;
                                                        echo '<li class="' .$anunMAOTypes[$fila[3]] .'" '.$color.'><b>' .$fila[4] .'</b> <small>' .$fecha . '[<a title="Borrar" href="?a=mi-premium&amp;borrara=' .$fila[0] .'">X</a>]</small></li>';                               
                                                    }
                                                
                                                    if (mysqli_num_rows($resultado) == 0) echo '<li><b>No hay avisos.</b></li>';
                                                    $resultado->close();
                                                }
                                            ?>
                                        </ul>
                                        <p style="height:3px!important;font-size:1px;">&nbsp;</p>
                                    </li>
                                    <li class="monedas">
                                        <b><a href="?a=apuestas">Sistema de Apuestas</a></b><br>
                                        <ul class="beneficios subpen" style="display:inline;">
                                            <li>No hay eventos.</li>
                                        </ul>
                                        <p style="height:3px!important;font-size:1px;">&nbsp;</p>
                                    </li>
                                    <li class="estrella">
                                        <b>Soporte</b><br><b><a href="?a=pre_soporte" style="height:16px">Nuevo soporte</a></b>
                                        <?php 
                                                
                                                $sql = "select * from soportes where account_id=? ORDER BY fecha_creacion DESC LIMIT 4;";
                                                $stmt = mysqli_stmt_init($conn);
                                                
                                                $account_id=$_SESSION['id'];

                                                if (!mysqli_stmt_prepare($stmt, $sql)) {?>
                                                    <b style="color:ff00ff;margin:10px;">Hubo un error al obtener los soportes.</b>
                                                    <?php exit;
                                                }else{
                                                    mysqli_stmt_bind_param($stmt, "i", $account_id);
                                                    mysqli_stmt_execute($stmt);
                                                }
                                                $result = mysqli_stmt_get_result($stmt);
                                                if(mysqli_num_rows($result) > 0){?>
                                                    <br><b style="line-height:17px;">Últimos soportes:</b><ul class="beneficios subpen" style="display: inline;">
                                                    <?php
                                                    while($row = mysqli_fetch_assoc($result)){
                                                        echo '
                                                        <li class="coment" style="height:13px;padding-bottom:0;padding-top:0;margin-top:0;">
                                                        <a href="?a=mis-soportes&amp;ticket='.$row['ticket'].
                                                        '" style="float:left;">'.$sectorType[$row['sector']].
                                                        ': ' .$row['asunto'] .'</a>
                                                        <small style="float:right;">'.$row['fecha_creacion'] .'</small>';

                                                    }
                                                    ?>
                                                    </li><li><b><a href="?a=mis-soportes">Ver todos</a></b></li></ul>
                                                    <?php
                                                }
                                        ?>
                                        <p style="height:3px!important;font-size:1px;">&nbsp;</p>
                                    </li>
                                    <li class="transferencia">
                                        <div>
                                            <b>Ayuda a la comunidad</b><br>                                            
                                            <a href="?a=reportar-bug">Reportar un error</a><br>
                                        </div>
                                        </br>
                                    </li> 
                                    <li class="candado">
                                        <div>
                                            <b>Configuración de la cuenta</b><br>
                                            
                                            <a href="?a=contrasena">Cambiar contraseña</a><br>
                                            <a href="?a=apodo">Cambiar apodo de la cuenta</a><br>
                                            <a href="/terminos-condiciones.php">Términos y Condiciones</a>
                                        </div>
                                        </br>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                