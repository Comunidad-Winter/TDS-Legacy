<?php                   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    require_logged();

    $success=false;

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['apodo'])) {

        $success=true; 
        $apodo = htmlspecialchars($_POST['apodo'], ENT_QUOTES, 'UTF-8');
    
        $_SESSION['apodo']=$apodo;

        $response = "Se ha actualizado tu apodo por el siguiente: <strong>$apodo</strong>. Puedes cambiarlo cuando quieras."; 


        sqlUpdate($conn, 'UPDATE cuentas SET apodo=? WHERE id=?', 'si',$apodo, $_SESSION['id']);
        

    }    
?><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
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
                <h1>Actualizar apodo</h1>
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
                                <li><b>Información de cuenta:</b></br>
                                Apodo actual: <?php echo $_SESSION['apodo'];?></li>

                               

                                <li class="candado">
                                        <b><a>Cambiar apodo de tu cuenta</a></b><br>
                                        <ul class="beneficios subpen">
                                    
                                        <?php if ($success) {?>

                                            <div class="col-sm" align="center">                                                
                                                    <div><p><?php echo $response;?></p></div>
                                                    
                                                    <p align="right"><a href="/cpremium.php?a=mi-premium" class="btn btn-outline-primary btn-lg">Volver al inicio</a></p>
                                                     
                                                </div>
                                            </div>

                                        <?php } else {require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';?>      
                                            <form action="" method="POST">
                                                <label for="apodo">Ingresa tu nuevo apodo</label>
                                                <input type="text" name="apodo" id="apodo" required>
                                                <input type="submit" value="Cambiar apodo">
                                            </form>                                    
                                        
                                        <?php } ?>
                                    </li>                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>