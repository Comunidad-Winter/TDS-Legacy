<?php

    # Disabled for now.
    header("Location: /cpremium.php?a=mi-premium");
    exit;

    require_once $_SERVER['DOCUMENT_ROOT'] . '/php/utils.php';
    $conn = connect();
    require_logged();

    $nick = "";
    $valida = 0;
    $codigo = "";
    $found = false;
    $i=0;

    if (!empty($_GET['i'])) {
        $i=intval($_GET['i']);
    }
    
    if (empty($_GET['n'])){
        header("Location: /cpremium.php?a=mi-premium");
        exit();
    }
    
    switch ($i) {
        case 1: // enviar mail
            // Coloca aquí la lógica para enviar el correo
            break;
        case 2:case 3:
            if (empty($_GET['c'])) {
                header("Location: /cpremium.php?a=mi-premium");exit();
            }
            $codigo = clear_string(preg_replace("/[^a-zA-Z0-9]+/", '', trim($_GET['c'])));
            if (mb_strlen($codigo) == 12) {
                $codigovalido = true;
                $valida = 1;
            }
            break;
        default:            
            header("Location: /cpremium.php?a=mi-premium");
            exit();
    }
    
    require_once $_SERVER['DOCUMENT_ROOT'] . '/cuentas/mis_personajes/seg.php';
    
    $nick = clear_nick($_GET['n']);
    if (mb_strlen($nick) < 3 || mb_strlen($nick) > 20) {
        $nick = "";
    }

    $nick = $conn->real_escape_string($nick);
    $sql = "SELECT * FROM user WHERE nick=? and account_id=?";                 

    $stmt = mysqli_prepare($conn, $sql);

    if ($stmt && mb_strlen($nick) > 2) {
        mysqli_stmt_bind_param($stmt, "si", $nick, $_SESSION['id']);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if (mysqli_num_rows($result) > 0) {
            $row = mysqli_fetch_assoc($result);
            $email = $row['email'];
            $found = true;
            $code = random_bytes(32);
            $hash = password_hash($code, PASSWORD_DEFAULT);
        }
    }
   
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, de TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor de TDS Legacy, Server de TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje">
    <!--[if lt IE 7.]>
<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
<![endif]-->
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/cuentas/mis-personajes.js"></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <!-- no se xq no anda-->
    <style type="text/css">
    td {
        font-size: 9pt;
        text-align: left;
        color: #ccc;
    }
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
            <div id='menu'>
                <div class='arriba'>
                    <ul>
                        <li><a href='/index.php' id='inicio' title='Inicio TDS Legacy'>Inicio</a></li>
                        <li><a href='/cuenta-premium.php' id='premium' title='Accede a tu cuenta'>Cuenta</a></li>
                        <li><a href='#wiki' id='manual' title='Manual TDSL'>Manual</a></li>
                        <li><a href='#foro' id='toforo' title='Foro oficial TDSL'>Foro</a></li>
                        <li><a href='/soportes.php' id='soporte' title='Soporte TDSL'>Soporte</a></li>
                        <li class='ultimo'><a href='/staff.php' id='staff' title='Staff TDSL'>Staff</a></li>
                    </ul>
                </div>
                <div class='abajo'>
                    <ul>
                        <li><a href='/ranking.php' id='ranking' title='Ranking TDSL'>Ranking</a></li>
                        <li><a href='/top50.php' id='top50' title='Top 50 TDSL'>Top 50</a></li>
                        <li><a href='/retos.php' id='retos' title='Retos TDSL'>Retos</a></li>
                        <li><a href='/reglamento.php' id='reglamento' title='Reglamento del juego'>Reglas</a></li>
                        <li class='ultimo jugadores_online'>
                            <div id="online"><a href="/online.php" rel="nofollow" title="Ver estado de los servidores" style="color:#FFC000;font-family:'Trebuchet MS';font-size:10.5pt;font-weight:bold;">Jugadores Onlines</a></div>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="titulo_seccion">
                <h1>Borrar personaje en TDS Legacy</h1>
            </div>
            <div id="main">
                <div id="panel-premium">
                    <div class="cuentas_premium" style="text-align:left;">
                        
                        <?php 

                        function insertOrUpdateDeleteCharacter($conn, $nick, $codigo, $id, $ip) {
                            $exists = false;
                            $result = false;

                            $sql = "SELECT `key` FROM deletechar WHERE `nick`=?";
                            $stmt2 = mysqli_stmt_init($conn);

                            if (mysqli_stmt_prepare($stmt2, $sql)) {
                                mysqli_stmt_bind_param($stmt2, "s", $nick);
                                mysqli_stmt_execute($stmt2);
                                $result2 = mysqli_stmt_get_result($stmt2);
                                if ($row2 = mysqli_fetch_assoc($result2)) {
                                    $exists = true;
                                }
                            }

                            if (!$exists) {
                                $sql = "INSERT INTO deletechar(`user_id`, `nick`,`key`,`ip`) VALUES (?,?,?,?)";
                            } else {
                                $sql = "UPDATE `deletechar` SET nick=?,`key`=?,`ip`=? WHERE user_id=?";
                            }

                            $stmt3 = mysqli_stmt_init($conn);
                            if (mysqli_stmt_prepare($stmt3, $sql)) {
                                if (!$exists) {
                                    mysqli_stmt_bind_param($stmt3, "isss", $id, $nick, $codigo, $ip);
                                } else {
                                    mysqli_stmt_bind_param($stmt3, "sssi", $nick, $codigo, $ip, $id);
                                }

                                mysqli_stmt_execute($stmt3);

                                $result = true;
                            }

                            return $result;
                        } 
//  ////  ////  ////  ////  ////  ////  ////  ////  ////  ////  ////  ////  ////  ////  //

                        if ($found ) {
                                                
                            if ($valida == 0 ) {
                                
                                $sql = "SELECT `logged` FROM user WHERE nick=?";
                                $stmt = mysqli_stmt_init($conn);

                                if (!mysqli_stmt_prepare($stmt, $sql)) {
                                    echo 'La sentencia SQL tiró un error.';
                                } else {
                                    mysqli_stmt_bind_param($stmt, "s", $nick);
                                    mysqli_stmt_execute($stmt);

                                    $result = mysqli_stmt_get_result($stmt);

                                    if (mysqli_num_rows($result) > 0) {
                                        $row5 = mysqli_fetch_assoc($result);

                                        if ($row5['logged'] > 0) {
                                            echo '<p align="center">
                                                <b style="color:red;font-size:10pt;">El personaje está logueado!!!</b>
                                            </p><div class="link_volver"><a style="color:black;text-decoration:none;" href="javascript:history.back()">Volver</a></div>';                                            
                                        } else {
                                            $codigo = substr(str_shuffle('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), 0, 12);

                                            $msg ='<div align="center"><span>TDS Legacy</span></div><p><strong>Hola!</strong></p><p>Has solicitado <strong>BORRAR TU PERSONAJE <u>'.$nick.'</u></strong> en TDS Legacy. Si tu no pediste esto puedes ignorar este mensaje. <strong>Si borras el personaje no tendrás forma de recuperarlo en un futuro</strong>.<br><br>Para borrar tu personaje por favor visitá la siguiente página: <br><a href="http://'.$host.'/cpremium.php?a=borrar-personaje&i=2&n='.$nick.'&c='.$codigo.'" target="_blank">http://'.$host.'/cpremium.php?a=borrar-personaje&i=2&n='.$nick.'&c='.$codigo.'</a><br><br>Cuando visites esa página recibiras indicaciones para finalizar el tramite de borrado de tu personaje.</p>';

                                            if (insertOrUpdateDeleteCharacter($conn, $nick, $codigo, $row['id'], $ip)) {
                                                if (!sendEmail($email, $nick, 'Borrar personaje en TDS Legacy', $msg)) {
                                                    echo '<p align="center"><b style="color:green;font-size:10pt;">[No se pudo mandar el correo, contacte con un Administrador].</b></p>';
                                                    //$conn->query("DELETE FROM user WHERE nick='" . $nick ."';"); // return.!
                                                } else {
                                                    echo '<p align="center"><b style="color:green;font-size:10pt;">Se ha enviado un correo electrónico a la dirección de correo del personaje. Para hacer efectivo el borrado del personaje, debes ingresar al enlace que se encuentra en el correo.</b></p><p><b style="color:green;font-size:10pt;"><u>IMPORTANTE</u>: Si tienes una cuenta en Hotmail o en un servidor que tiene la opción de Anti-Spam, es posible que el correo llegue a la carpeta de "Correo no deseado". Te recomendamos revisar esa carpeta.</b></p>';
                                                }
                                            } else {
                                                echo '<p align="center"><b style="color:green;font-size:10pt;">[ERROR AL INSERTAR EN LA BASE DE DATOS].</b></p>';
                                            }
                                        }
                                    }else {
                                        echo '<p align="center"><b style="color:green;font-size:10pt;">No encontré a ese usuario.</b></p>';
                                    }
                                }
                            }else{
                                
                                // validar posta
                                if ($codigovalido) {  
                                    $codigovalido=false;                                
                                    $sql = "SELECT * FROM deletechar WHERE user_id=?";
                                    $stmt = mysqli_stmt_init($conn);

                                    if (!mysqli_stmt_prepare($stmt, $sql)) {
                                        echo 'El sistema no funciona.';
                                    } else {
                                        mysqli_stmt_bind_param($stmt, "s", $row['id']);
                                        mysqli_stmt_execute($stmt);

                                        $result = mysqli_stmt_get_result($stmt);

                                        if (mysqli_num_rows($result) > 0) { 
                                            while ($row5 = mysqli_fetch_assoc($result)) {
                                                if (strcmp($row5['key'],$codigo) == 0){
                                                    $codigovalido=true;
                                                    break;
                                                }
                                            }
                                        }
                                    }
                                }

                                if (!$codigovalido) {
                                    echo '<p align="center">
                                        <b style="color:red;font-size:10pt;">The submitted code is invalid, try again.</b>
                                    </p>';
                                }else{                    
                                    
                                    $data="";
                                    $password = $_SESSION['password'];
                                    $pin = $_SESSION['pin'];
                                    $account_id = $_SESSION['id'];
                                    $line = "|17|$ip|$nick|$account_id|$password|$pin";

                                    server_getdata($line,$data); 
                                    
                                    switch ($data[0]) {
                                        case '0':
                                            $string =date('j-m-y, H:i a'). "|".$row['id']. "|" .$row['account_id']. "|" .$row['nick']. "|" .$row['nivel']. "|" .$row['pin']. "|" .$row['password']. "|" .$row['email']. "|" .$row['exp']. "|" .$row['clase']. "|" .$row['raza']. "|" .$row['genero']. "|" .$row['logged']. "|" .$row['min_hp']. "|" .$row['max_hp']. "|" .$row['min_man']. "|" .$row['max_man']. "|" .$row['elu']. "|" .$row['ciudas_matados']. "|" .$row['crimis_matados']. "|" .$row['status']. "|" .$row['carceltime']. "|" .$row['clan']. "|" .$row['total_matados']. "|" .$row['oro']. "|" .$row['boveda']. "|" .$row['posicion']. "|" .$row['lastip']. "|" .$row['asesino']. "|" .$row['noble']. "|" .$row['burgue']. "|" .$row['bandido']. "|" .$row['plebe']. "|" .$row['ladron']. "|" .$row['retos_ganados']. "|" .$row['retos_perdidos']. "|" .$row['retos_oro_ganado']. "|" .$row['retos_oro_perdido']. "|" .$row['is_locked_in_mao']. "|" .$row['skillslibres']. "|" .$row['ups']. "|" .$row['ban'] .chr(0x0D).chr(0x0A);
                                        
                                            $myfile = fopen($_SERVER['DOCUMENT_ROOT']."/cuentas/mis_personajes/pjs_borrados.txt", "a") or die("Unable to open file!");
                                            fwrite($myfile, $string);
                                            fclose($myfile);
                                            $ses=$_SESSION['id'];

                                            $msg='<div align="center"><span>TDS Legacy</span></div><p><strong>Hola!</strong></p><p>¡¡Has borrado a tu personaje <strong><u>'.$nick.'</u></strong> en TDS Legacy!! </p>';
                                           
                                            $conn->query("DELETE FROM user WHERE nick='" . $nick ."';");
                                            $conn->query("DELETE FROM deletechar WHERE nick='" . $nick ."';");                                            
                                            sendEmail($email, $nick, 'Borrar personaje en TDS Legacy', $msg, true);
                                            echo '<p align="center"><b style="color:green;font-size:10pt;">Has borrado tu personaje!!.</b></p>';

                                            break;
                                        case '1':
                                            echo '<p align="center"><b style="color:red;font-size:10pt;">Datos de la cuenta invalidos.</b></p>';
                                            break;
                                        case '2':
                                            echo '<p align="center"><b style="color:red;font-size:10pt;">¡¡El personaje se encuentra logueado!!</b></p>';
                                            break;
                                        default:
                                            echo '<p align="center"><b style="color:red;font-size:10pt;">Hubo un response error!</b></p>';
                                            break;
                                    }
                                }
                            }
                        }else {
                            echo '<p align="center"><b style="color:green;font-size:10pt;">Se ha enviado un correo electrónico a la dirección de correo del personaje. Para hacer efectivo el borrado del personaje, debes ingresar al enlace que se encuentra en el correo.</b></p><p><b style="color:green;font-size:10pt;"><u>IMPORTANTE</u>: Si tienes una cuenta en Hotmail o en un servidor que tiene la opción de Anti-Spam, es posible que el correo llegue a la carpeta de "Correo no deseado". Te recomendamos revisar esa carpeta.</b></p>';
                        }

                        ?>
                    </div>

                    <!-- why? -->
                    <b style="color:green;font-size:10pt;"></b>

                </div><b style="color:green;font-size:10pt;">
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>