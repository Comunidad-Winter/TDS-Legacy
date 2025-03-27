<?php                   

    #require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/sendValidationEmail.php'; 
    $conn = connect();

    require_loggedandunverified();

    if (!isset($_SESSION['username'])) {
        exit();
    }
    
    if (isset($_GET['a'])) {
        switch ($_GET['a']) {
            case 'salir':
                session_unset();
                session_destroy();
                header("Location: cuenta-premium.php");
                break;
        }
    }
      
    $insertID = $_GET['id'] ?? null;
    $verifyCode = $_GET['code'] ?? null;

    $errValidation="";

    if ($insertID !== null && $verifyCode !== null) {
        $query = "SELECT * FROM requests WHERE id = ? AND hash = ? AND type = 1";
        
        $stmt = $conn->prepare($query);
        $stmt->bind_param('is', $insertID, $verifyCode);
        $stmt->execute();
        $result = $stmt->get_result();
        
        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $storedHash = $row['hash'];
            
            if (strcmp($verifyCode, $storedHash) === 0) {                
                 
                if(sqlUpdate($conn, 'UPDATE cuentas SET verified=1 WHERE username=?', 's',  $row['name'])) {  
                    sqlUpdate($conn, 'DELETE FROM requests WHERE name=? AND type=1', 's', $row['name']);
                    $_SESSION['verified']=1;
                    header("Location: cpremium.php");                  
                    exit();
                }else {
                    $errValidation="No se ha podido actualizar tu cuenta, contacta con el Administrador por Discord.";
                }

            } else {
                $errValidation= "Tu código de validación es obsoleto o erróneo.";
            }
        } else {
            $errValidation= "Tu código de validación es obsoleto o erróneo.";
        }
        $stmt->close();        
    }
    
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/comun/js/jquery-min.js"></script>
    
    <script>

        function reenviarCodigo() {
            var p = document.getElementById('perror');
            p.innerHTML = 'Espere...';

            var ajax = new XMLHttpRequest();
            ajax.open("GET", "cuentas/validar_backend.php");
            ajax.onreadystatechange = function () {
                if (ajax.readyState === 4 && ajax.status === 200) {
                    p.innerHTML = ajax.responseText;
                }
            };
            ajax.send();
        }
    </script>
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
                                        <b>Información de cuenta:</b>
                                        
                                        
                                        <p></p><table cellpadding="0" cellspacing="0" border="0" style="width:480px;" align="center" id="alerta"><tbody><tr>
                                            <td id="alerta_critico"><img src="/imagenes/cuentas/alerta_critico.gif" alt="">
                                            <p id="perror">
                                            <?php 
                                            
                                            if (strlen($errValidation)) {
                                                echo $errValidation;
                                            }else
                                                echo '¡Alerta! Debes validar el email para usar tu Cuenta Premium. Si no te llegó nada a tu correo puedes solicitar otro link para validar tu cuenta haciendo <a onclick="reenviarCodigo();" title="¡Reenviar codigo!">click aquí</a>.';
                                            ?>
                                             </p></td></tr></tbody></table><br>
                                                        
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <?php include $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>

                