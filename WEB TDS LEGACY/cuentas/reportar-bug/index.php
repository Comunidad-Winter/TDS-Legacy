<?php   
     
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

    require_logged();
    
    $subbmited=false;
    $msg="";
    $response="";

    if ( isset($_POST['nick']) && isset($_POST['asunto']) && isset($_POST['email']) && isset($_POST['mensaje'])   ) {
        $subbmited=true;
        $ticketid=0;        
        $sector=0;

        if (!isset($_POST['nick']) || !isset($_POST['asunto']) || !isset($_POST['email']) || !isset($_POST['mensaje'])) {
            $response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Solicitud de ticket invalido.</b>';
            goto end;
        } else if (!preg_match('/^[a-zA-Z- ]+$/', $_POST['nick'])) {
            $response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un nick valido.</b>';
            goto end;
        } else if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            $response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un email valido</b>';
            goto end;
        } 
        
        $nick = $conn->real_escape_string($_POST['nick']); 
        $email = $conn->real_escape_string($_POST['email']); 
        
        $asunto = $conn->real_escape_string(trim($_POST['asunto']));
        $mensaje = $conn->real_escape_string($_POST['mensaje']);

        $asunto = htmlentities($asunto, ENT_QUOTES, "UTF-8");
        $mensaje = htmlentities($mensaje, ENT_QUOTES, "UTF-8");

                    
        if (personajeExiste($nick)) {
            
            if (mb_strlen($asunto)>255) {$response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del asunto debe ser menor a 30 caracteres!</b>';
            goto end;
        }
            if (mb_strlen($mensaje)>2500) {$response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe ser menor a 600 caracteres!</b>';
            goto end;
        }
            if (mb_strlen($asunto)<3) {$response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 5 caracteres!</b>';
            goto end;
        }
            if (mb_strlen($mensaje)<4) {$response='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 15 caracteres!</b>';
            goto end;
        }
    

            $asunto = $conn->real_escape_string($asunto); 
            $mensaje = $conn->real_escape_string($mensaje); 

            $sql = "insert into reportes (nick, email, asunto, mensaje) VALUES (?,?,?,?);";
            $stmt = mysqli_stmt_init($conn);

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $response='<b style="color: #ed1c1c;
                text-shadow: 1px 1px black;
                font-size: medium;
                display: block;
                margin: 10px;">Hubo un error al crear el reporte.</b>';
                echo mysqli_stmt_error($stmt);
                goto end;
            }else{
                mysqli_stmt_bind_param($stmt, "ssss", $nick, $email, $asunto, $mensaje);
                mysqli_stmt_execute($stmt);

                $msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
                <div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$_SESSION['username'] .'!</strong></p><p>Hemos recibido tu petición de soporte. Si tu no pediste esto puedes ignorar este mensaje. <br />
                                <br/>
                                Reporte generado<br />
                                Tu personaje: '. $nick .' <br />
                                Asunto: '. $asunto .' <br />
                                Mensaje: '. $mensaje .' <br />
                                <br/>
                                Cuando un GM responda tu soporte te avisaremos a traves de éste email.</p>';
                
                sendEmail($email, $email, 'REPORTE DE BUG' , $msg);          
                $response='<b style="margin:10px;">Gracias por usar el sistema de reportes de TDS Legacy.<br>
                Se ha creado el reporte.<br>
                Muchas gracias por contribuir con nosotros.<br>';
                    
                $msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
                <div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.APP_OWNER .'!</strong></p><p>La cuenta:'.$_SESSION['username'].' ha reportado un bug: <br />
                                <br/>
                                Supuesto personaje: '. $nick .' <br />
                                Asunto: '. $asunto .' <br />
                                Mensaje: '. $mensaje .' <br />
                                </p>';
                                
                sendEmail(ADMIN_EMAIL, "Report", 'REPORTE DE BUG' , $msg);
            } 
            
        }else {			
            $response='<b style="color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El personaje seleccionado no existe en nuestra base de datos.</b><br>';
        }
    }
    end:
    
 ?>

<!DOCTYPE html	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Reportar bug</title>
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/soporte.css' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body id="seccion_soporte" onload="init();">
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
            <script type='text/javascript'>
            function validar(formulario) {
                var mensaje = "";
                
                if (document.getElementById("nick").value == "") {
                    mensaje += "- Debe completar el nick del PJ\n";
                }

                if (document.getElementById("email").value == "") {
                    mensaje += "- Debe completar el e-mail\n";
                }

                if (document.getElementById("asunto").value == "") {
                    mensaje += "- Debe completar el asunto\n";
                }

                if (document.getElementById("mensaje").value == "") {
                    mensaje += "- Debe completar el mensaje\n";
                }

                if (mensaje != "") {
                    alert(mensaje);
                    return false;
                } else {
                    document.getElementById("origen").value = "0";
                    return true;
                }
            }
            </script>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1>Reportar un error</h1>
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
                                                    <div class='contenido_soporte'>
                                                        <br />
                                                        <h2>Reporte</h2>
                                                        
                                                        <?php  
                                                            
                                                            if ($subbmited) {
                                                                echo '<br /><div>';
                                                                echo($response);
                                                                echo '<br />';
                                                            }else{                                                     
                                                        ?>
                                                        <h3>Complet&aacute; el formulario con informaci&oacute;n
                                                            verdadera.</h3>
                                                        <div class="form_soporte">
                                                            <form name="soporte_TDSL" onsubmit="return validar(this)" method="post" action="">
                                                                <input type="hidden" name="origen" id="origen" value="-1">
                                                                
                                                                <p>
                                                                    <label for="nick">Tu nick<br /><input type="text" name="nick" id="nick" class="input" value="" /></label>
                                                                </p>
                                                                <p><label for="email">Tu email:<br /><input type="text" name="email" id="email" class="input" value="" /></label>
                                                                </p>
                                                                
                                                                <table cellpadding="0" cellspacing="0" border="0" style="background:url(/imagenes/bg_input.gif); width:430px; display:none;" align="center" id="alerta">
                                                                    <tr>
                                                                        <td id="txt_alerta"></td>
                                                                    </tr>
                                                                </table>
                                                                <p><label for="asunto">Asunto:<br /><input type="text" name="asunto" id="asunto" class="input" value="" /></label>
                                                                </p>
                                                                <p><label for="mensaje"><br />
                                                                        Mensaje:<br />
                                                                        [IMPORTANTE: el ingreso de informaci&oacute;n
                                                                        falsa con el objetivo <br />
                                                                        de obtener un benefcio esta penado] <br />
                                                                        <textarea rows="4" cols="30" name="mensaje" id="mensaje"></textarea></label>
                                                                </p>
                                                               
                                                                <p><input type="submit" value="Enviar report" class="enviar" />
                                                                </p>
                                                            </form>

                                                            <?php                                                             
                                                            
                                                            }                                                            
                                                        ?>
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
                <br />
                
    
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>