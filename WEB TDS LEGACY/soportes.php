<?php 
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
 ?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>AO Legacy - Soporte</title>
    <meta name="keywords" content="Sistema de soporte, Soporte AOI, Problemas tecnicos, Robo de personajes, Errores, Run time, Run time error" />
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/soportes.css' rel='stylesheet' type='text/css' />
    <script type='text/javascript' src='/soportes.js'></script>
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
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div>
                </div>
                <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class='titulo_seccion'>
                <h1>Soporte Online AO Legacy</h1>
            </div>
            <div id='main'>
                <div id='contenido'>
                    <div class='contenido_soporte'>
                        <p>Bienvenido a la secci&oacute;n de soporte. Aqu&iacute; encontrar&aacute;s respuestas a los problemas m&aacute;s comunes. Si tienes alguna duda sobre la interfaz del juego o como realizar alguna acci&oacute;n dentro del mismo, por favor ve a la secci&oacute;n <a href="manual.php">Manual</a>.</p>
                        <p><strong>Si posees una Cuenta y tenes acceso a ella debes enviar soporte desde <a href="/cpremium.php?a=soporte">aqu&iacute;</a>.</strong></p>
                        <p>Aqu&iacute; tienes una lista por categor&iacute;as de las respuestas a las preguntas y soluciones a los problemas m&aacute;s frecuentes.</p>
                        <p>
                            <div id="col1" class="tablasoporte"><br /><b>Problemas Técnicos</b><br /> - <a href="soportes.php?entrada=76.problemas-tcnicos-no-se-conecta-al-juego">No se conecta al juego</a><br /> - <a href="soportes.php?entrada=79.problemas-tcnicos-the-setup-are-corrupted-o-el-archivo-esta-corrupto">The setup are corrupted o el archivo esta corrupto</a><br /> - <a href="soportes.php?entrada=80.problemas-tcnicos-la-pantalla-se-ve-corrida">La pantalla se ve corrida</a><br /> - <a href="soportes.php?entrada=81.problemas-tcnicos-no-se-inicia-el-juego-en-vista7-">No se inicia el juego en Vista/7 </a><br /> - <a href="soportes.php?entrada=82.problemas-tcnicos-no-funciona-crear-personajes">No funciona crear personajes</a><br /> - <a href="soportes.php?entrada=83.problemas-tcnicos-no-se-guardan-las-fotosvideos-w-vista7810">No se guardan las fotos/videos W. Vista/7/8/10</a><br /> - <a href="soportes.php?entrada=97.problemas-tcnicos-no-llegan-los-mails-a-mi-casilla-de-correo">No llegan los mails a mi casilla de correo</a><br /> - <a href="soportes.php?entrada=101.problemas-tcnicos-errores-de-run-time">Errores de RUN TIME</a><br /> - <a href="soportes.php?entrada=134.problemas-tcnicos-franjas-negras-">Franjas Negras </a><br /> - <a href="soportes.php?entrada=144.problemas-tcnicos-windows-810">Windows 8/10</a><br /> - <a href="soportes.php?entrada=147.problemas-tcnicos-virus">Virus</a><br /> - <a href="soportes.php?entrada=152.problemas-tcnicos-error-b101">Error B101</a><br /> - <a href="soportes.php?entrada=153.problemas-tcnicos-error-runtime-70">Error RUNTIME 70</a><br /> - <a href="soportes.php?entrada=154.problemas-tcnicos-error-runtime-7576">Error RUNTIME 75/76</a><br /> - <a href="soportes.php?entrada=156.problemas-tcnicos-latencia-alta-lag">Latencia alta (lag)</a><br /> - <a href="soportes.php?entrada=157.problemas-tcnicos-lag-al-mover-el-mouse">Lag al mover el mouse</a><br /> - <a href="soportes.php?entrada=159.problemas-tcnicos-no-se-inicia-el-juego">No se inicia el juego</a><br /> - <a href="soportes.php?entrada=160.problemas-tcnicos-error-3a35756">Error 3A35756</a><br /> - <a href="soportes.php?entrada=161.problemas-tcnicos-no-funciona-el-click-en-items-del-inventario">No funciona el click en items del inventario</a><br /> - <a href="soportes.php?entrada=163.problemas-tcnicos-algunos-detalles-se-ven-borrosos">Algunos detalles se ven borrosos</a><br /> - <a href="soportes.php?entrada=176.problemas-tcnicos-bajos-fps">Bajos FPS</a><br /> - <a href="soportes.php?entrada=180.problemas-tcnicos-franjas-naranjas">Franjas naranjas</a><br /> - <a href="soportes.php?entrada=182.problemas-tcnicos-se-borra-AOIexe">Se borra AOI.exe</a><br /> - <a href="soportes.php?entrada=184.problemas-tcnicos-posible-solucin-provisoria-fps">Posible solución provisoria: FPs</a><br /><br /><b>Protege tu cuenta</b><br /> - <a href="soportes.php?entrada=167.protege-tu-cuenta-robo-de-identidad-o-phishing">Robo de identidad o Phishing</a><br /> - <a href="soportes.php?entrada=168.protege-tu-cuenta-consejos-de-seguridad">Consejos de seguridad</a><br /> - <a href="soportes.php?entrada=169.protege-tu-cuenta-keylogger">Keylogger</a><br /><br /><b>Comunidad</b><br /> - <a href="soportes.php?entrada=175.comunidad-foro-quite-de-t0">Foro: Quite de T0</a><br /><br /><b>Usuarios</b><br /> - <a href="soportes.php?entrada=174.usuarios-denunciar-a-un-jugador">Denunciar a un jugador</a><br /></div>
                            <div id="col2" class="tablasoporte"><br /><b>Cuenta Premium</b><br /> - <a href="soportes.php?entrada=71.cuenta-premium-no-se-me-acredita-el-tiempo">No se me acredita el tiempo</a><br /> - <a href="soportes.php?entrada=72.cuenta-premium-crear-personaje-en-TDSLfcil">Crear personaje en TDSLFácil</a><br /> - <a href="soportes.php?entrada=135.cuenta-premium-que-son-los-TDSL">¿Que son los $TDSL?</a><br /> - <a href="soportes.php?entrada=137.cuenta-premium-adquirir-tiempo-con-TDSL">Adquirir tiempo con $TDSL</a><br /> - <a href="soportes.php?entrada=138.cuenta-premium-adquirir-monedas-de-oro-con-TDSL">Adquirir monedas de ORO con $TDSL</a><br /> - <a href="soportes.php?entrada=141.cuenta-premium-promo-regal-tiempo-premium">Promo: Regalá tiempo premium</a><br /> - <a href="soportes.php?entrada=158.cuenta-premium-no-me-anda-la-impresora">No me anda la impresora</a><br /><br /><b>Problemas con el Personaje</b><br /> - <a href="soportes.php?entrada=68.problemas-con-el-personaje-me-asignaron-los-skills">Me asignaron los skills</a><br /> - <a href="soportes.php?entrada=70.problemas-con-el-personaje-recuperar-la-contrasea">Recuperar la contraseña</a><br /> - <a href="soportes.php?entrada=77.problemas-con-el-personaje-listado-de-pjs-del-mail">Listado de PJs del Mail</a><br /> - <a href="soportes.php?entrada=78.problemas-con-el-personaje-pena-por-fotodenuncia">Pena por Fotodenuncia</a><br /> - <a href="soportes.php?entrada=136.problemas-con-el-personaje-cambio-de-nick">Cambio de Nick</a><br /> - <a href="soportes.php?entrada=179.problemas-con-el-personaje-quite-de-t0-ingame">Quite de T0 ingame</a><br /><br /><b>Tutoriales</b><br /> - <a href="soportes.php?entrada=73.tutoriales-como-pagar-fianza">Como pagar fianza</a><br /> - <a href="soportes.php?entrada=75.tutoriales-como-pedir-perdn-a-las-facciones">Como pedir perdón a las Facciones</a><br /> - <a href="soportes.php?entrada=146.tutoriales-como-votar-en-las-encuestas">Como votar en las encuestas</a><br /> - <a href="soportes.php?entrada=151.tutoriales-como-actualizar-el-juego">Como actualizar el juego</a><br /> - <a href="soportes.php?entrada=165.tutoriales-cmo-subir-un-video-a-mediafire">¿Cómo subir un video a mediafire?</a><br /><br /><b>Mi cuenta</b><br /> - <a href="soportes.php?entrada=84.mi-cuenta-olvid-la-clave">Olvidó la clave</a><br /> - <a href="soportes.php?entrada=119.mi-cuenta-que-es-y-como-crear-una-cuenta">Que es y como crear una Cuenta</a><br /> - <a href="soportes.php?entrada=172.mi-cuenta-problemas-al-intentar-ingresar-a-la-cuenta">Problemas al intentar ingresar a la cuenta</a><br /> - <a href="soportes.php?entrada=173.mi-cuenta-cambiar-el-e-mail-de-mi-cuenta">Cambiar el E-Mail de mi cuenta</a><br /><br /><b>TÉRMINOS Y CONDICIONES</b><br /> - <a href="soportes.php?entrada=178.trminos-y-condiciones-trminos-y-condiciones-del-servicio">Términos y Condiciones del Servicio</a><br /><br /><b>Cuenta Estandar</b><br /> - <a href="soportes.php?entrada=177.cuenta-estandar-crear-una-cuenta">Crear una cuenta</a><br /></div>
                        </p>
                        <div class='clear'></div>
                        <p>Si no has podido encontrar la soluci&oacute;n a tu problema (<u>en caso de que la soluci&oacute;n este en la lista superior el soporte no ser&aacute; contestado</u>) puedes comunicarte con nosotros utilizando el <a href="soporte.php">formulario de contacto</a>.</p>
                    </div>
                    <div class="link_volver"><a href="javascript:history.back()">Volver</a></div>
                </div>
                <div onclick="javascript:ocultar();" id="imagengrande" style="z-index:1000;cursor:pointer; left:1%; position:absolute; display:none;"></div>

                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>