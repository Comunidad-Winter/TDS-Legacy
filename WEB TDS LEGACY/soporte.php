<?php   
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

    require_logged();
    
    $subbmited=false;

    if ( isset($_POST['nick']) && isset($_POST['sector']) && isset($_POST['nombre']) && isset($_POST['asunto']) && isset($_POST['email']) && isset($_POST['mensaje'])   ) {
        $subbmited=true;
        $ticketid=0;
        $quit = false;
        $sector=0;

        if (!isset($_POST['nick']) || !isset($_POST['sector']) || !isset($_POST['nombre']) || !isset($_POST['asunto']) || !isset($_POST['email']) || !isset($_POST['mensaje'])) {
            $result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Solicitud de ticket invalido.</b>';$quit=true;goto end;
        }else if (strlen(($_POST['nick']))<3  || empty($_POST['sector']) || empty($_POST['asunto']) || empty($_POST['nombre']) || empty($_POST['email']) || empty($_POST['mensaje'])) {
            $result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un sector válido.</b>'; $quit=true;goto end;
        } else if (!preg_match('/^[a-zA-Z- ]+$/', $_POST['nick'])) {
            $result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un nick valido.</b>';$quit=true;goto end;
        } else if (!filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
            $result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un email valido</b>';$quit=true; goto end;
        } 
        
        require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
        $conn = connect();
        $nick = $conn->real_escape_string($_POST['nick']); 
        $email = $conn->real_escape_string($_POST['email']); 
        $nombre = $conn->real_escape_string($_POST['nombre']); 
        $sector = intval($_POST['sector']);
        $asunto = $conn->real_escape_string(trim($_POST['asunto']));
        $mensaje = $conn->real_escape_string(trim($_POST['mensaje']));

        $nombre = htmlentities($nombre, ENT_QUOTES, "UTF-8");
        $asunto = htmlentities($asunto, ENT_QUOTES, "UTF-8");
        $mensaje = htmlentities($mensaje, ENT_QUOTES, "UTF-8");
                    
        switch ($sector) {case 0: case 1:case 2:case 7:case 9:case 11:case 15:case 16:case 17:case 20:case 21:case 22:case 23:break;
            default:$sector=0;break;}

        if (personajeExiste($nick)) {
            
            if (mb_strlen($asunto)>30) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del asunto debe ser menor a 30 caracteres!</b>';goto end;}
            if (mb_strlen($mensaje)>2500) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe ser menor a 600 caracteres!</b>';goto end;}
            if (mb_strlen($asunto)<5) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 5 caracteres!</b>';goto end;}
            if (mb_strlen($mensaje)<15) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 15 caracteres!</b>';goto end;}
    
            require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
            $conn = connect();

            $asunto = $conn->real_escape_string($asunto); 
            $mensaje = $conn->real_escape_string($mensaje); 

            $sql = "insert into soportes2 (nombre, nick, email, sector, asunto, mensaje) VALUES (?,?,?,?,?,?);";
            $stmt = mysqli_stmt_init($conn);

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $result='<b style="color: #ed1c1c;
                text-shadow: 1px 1px black;
                font-size: medium;
                display: block;
                margin: 10px;">Hubo un error al crear el soporte.</b>';
                exit;
            }else{
                mysqli_stmt_bind_param($stmt, "sssiss", $nombre, $nick, $email, $sector, $asunto, $mensaje);
                mysqli_stmt_execute($stmt);
            } 

            $ticketid =$conn->insert_id;
            if ($ticketid>0) {			
                
                $msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
                <div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$nombre.'!</strong></p><p>Hemos recibido tu petición de soporte. Si tu no pediste esto puedes ignorar este mensaje. <br />
                                <br/>
                                Tu numero de ticket es: '. $ticketid .' <br />
                                Personaje involucrado: '. $nick .' <br />
                                Asunto: '. $asunto .' <br />
                                Mensaje: '. $mensaje .' <br />
                                <br/>
                                Cuando un GM responda tu soporte te avisaremos a traves de éste email.</p>';
                
                if(!sendEmail($email, $email, 'Soporte Nro.' . $ticketid , $msg)) {								
                    $result=$result='<b style="color: #ed1c1c;
                        text-shadow: 1px 1px black;
                        font-size: medium;
                        display: block;
                        margin: 10px;">Hubo un error al enviarte el correo pero el ticket N°'.$ticketid.' fue creado.</b>';
                }else                
                    $result='<b style="margin:10px;">Gracias por usar el sistema de soporte de AO Legacy.<br>
                    Se ha creado el Ticket de soporte Nº'.$ticketid.'<br>
                    Cuando un GM responda a tu soporte se te será notificado via el email que nos has proporcionado.<br>' ;
                
                
            }else{
                $result='<b style="color: #ed1c1c;
                text-shadow: 1px 1px black;
                font-size: medium;
                display: block;
                margin: 10px;">Hubo un error al crear el soporte.</b>';
            }            
            
        }else {			
            $result='<b style="color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El personaje seleccionado no existe en nuestra base de datos.</b><br>';
        }

        end:
    }
 ?>

<!DOCTYPE html	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Formulario de contacto</title>
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
                if (document.getElementById("nombre").value == "") {
                    mensaje += "- Debe completar el nombre\n";
                }

                if (document.getElementById("nick").value == "") {
                    mensaje += "- Debe completar el nick del PJ\n";
                }

                if (document.getElementById("email").value == "") {
                    mensaje += "- Debe completar el e-mail\n";
                }

                if (document.getElementById("sector").options[0].selected == true) {
                    mensaje += "- Debe seleccionar el sector\n";
                }

                if (document.getElementById("tema").value == "") {
                    mensaje += "- Debe completar el tema\n";
                }

                if (document.getElementById("mensaje").value == "") {
                    mensaje += "- Debe completar el mensaje\n";
                }

                if (document.getElementById("captcha").value == "") {
                    mensaje += "- Debe completar el digito de verificacion\n";
                }

                if (mensaje != "") {
                    alert(mensaje);
                    return false;
                } else {
                    document.getElementById("origen").value = "0";
                    return true;
                }
            }

            function validar2() {
                var mensaje = "";
                if (document.getElementById("ticket").value == "") {
                    mensaje += "- Debe completar el nro. de ticket\n";
                }

                if (document.getElementById("email2").value == "") {
                    mensaje += "- Debe completar el e-mail\n";
                }

                if (mensaje != "") {
                    alert(mensaje);
                    return false;
                } else {
                    return true;
                }
            }
            </script>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1>Soporte Online AO Legacy</h1>
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
                                                        <h2>Soporte</h2><?php  
                                                            
                                                            if ($subbmited) {
                                                                echo '<br /><div>';
                                                                echo($result);
                                                                echo '</div><br />';
                                                            }else{                                                     
                                                        ?>
                                                        <h3>Complet&aacute; el formulario con informaci&oacute;n
                                                            verdadera, a la brevedad ser&aacute; respondido.</h3>
                                                        <div class="form_soporte">
                                                            <form name="soporte_TDSL" onsubmit="return validar(this)" method="post" action="/soporte.php">
                                                                <input type="hidden" name="origen" id="origen" value="-1">
                                                                <p><label for="nombre">Nombre:<br /><input type="text" name="nombre" id="nombre" class="input" value="" /></label>
                                                                </p>
                                                                <p>
                                                                    <label for="nick">Nick del personaje
                                                                        involucrado:<br /><input type="text" name="nick" id="nick" class="input" value="" /></label>
                                                                </p>
                                                                <p><label for="email">Email:<br /><input type="text" name="email" id="email" class="input" value="" /></label>
                                                                </p>
                                                                <p><label for="sector">Sector:<br />
                                                                        <select name="sector" id="sector">
                                                                            <option value="0">-</option>
                                                                            <option value="1">Bug</option>
                                                                            <option value="2">Ban</option>
                                                                            <option value="7">Problema Técnico</option>
                                                                            <option value="9">Denuncia GMs</option>
                                                                            <option value="11">Robo de PJ/Estafa</option>
                                                                            <option value="15">Otro</option>
                                                                            <option value="16">Cuentas</option>
                                                                            <option value="17">Nick inapropiado</option>
                                                                            <option value="20">Denuncia de cheater</option>
                                                                            <option value="21">Foro</option>
                                                                            <option value="22">Quite T0 ingame</option>
                                                                            <option value="23">Discord</option>
                                                                        </select></label></p>
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
                                                               
                                                                <p><input type="submit" value="Enviar" class="enviar" />
                                                                </p><br />
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