<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();

require_banned();

if (isset($_GET['a'])) {
    switch ($_GET['a']) {
         case 'salir':          
            if(isset($_COOKIE['rememberme'])) {
                setcookie('rememberme', '', time()-7000000, '/');                    
                
                $sql = "DELETE FROM auth_tokens WHERE user_email=? AND auth_type='remember_me';";
                $stmt = mysqli_stmt_init($conn);
                if (mysqli_stmt_prepare($stmt, $sql)){
                    mysqli_stmt_bind_param($stmt, "s", $_SESSION['email']);
                    mysqli_stmt_execute($stmt);                        
                    if (isset($_SESSION['auth'])){
                        $_SESSION['auth'] = '';
                    }
                }
            }
            session_unset();
            session_destroy();
            header("Location: index.php");
            break;
        
        case 'pre_soporte':
            header("Location: pre-soporte.php");
            break;
        case 'mis-soportes':            
            include_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/soportes.php';
            break;  
       case 'soporte':
            include_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/soporte.php';   
            break;       
       case 'contrasena':
            include_once $_SERVER['DOCUMENT_ROOT'].'/contrasena.php';
            break;                  
       default:
            //include_once 'cuentas/mi_premium/mi-premium.php';
            break;
    }
 }else{
    //header("Location: banned.php?a=mi-premium");
 }
 
?>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
    <!--[if lt IE 7.]>
<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
<![endif]-->
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
                            <p class="necesario">
                                <a href="/banned.php?a=mi-premium">Panel</a> | <a href="/banned.php?a=mis_personajes" title="Todo sobre tus personajes.">Mis personajes</a> | <a href="/banned.php?a=mercado" title="Publicá, comprá y vendé personajes de modo rápido, fácil y seguro.">Mercado Ao</a> | <a href="/banned.php?a=apuestas" title="Apostá por quien creés que va a ganar los torneos y quests.">Apuestas</a> | <a href="/banned.php?a=tdstube" title="Subi tus propias fotos">TDSTube</a> | <a href="/banned.php?a=salir" title="Salir de la Cuenta">Salir</a>
                            </p>
                        </div>
                        <div id="centro_panel">
                            <div class="izq" style="width: 500px;">
                                <ul class="beneficios">
                                    <li>
                                        <h2>Su cuenta ha sido bloqueada</h2>
                                     
                                        <h5 style="color: #fff9d2;">Su cuenta ha sido bloqueada por <?php echo $_SESSION['ban_reason'] ?>. El bloqueo de la cuenta es permanente.<br>
                                        Ante cualquier duda puede consultarnos a través del sistema de <a href="/banned.php?a=pre_soporte">soporte</a> o revisar tus <a href="/banned.php?a=mis-soportes" >soportes abiertos</a>.</h5>
                                    </li>
                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>