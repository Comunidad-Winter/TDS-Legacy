<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_logged();

?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>    
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Quitar personaje</title>
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
    <style type="text/css">td {font-size: 9pt;text-align: left;color: #ccc;}</style>


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
<br>
<div id="contenido" style="text-align:center">

<b id="response" style="color:008000;margin:10px;"></b>

    <?php 
        if(isset($_GET['n'])){
    ?>
<div name="form1" id="cuentasPremium">
<fieldset>
<div class="campos">
<p class="form-tit">Completá este formulario para quitar a <?php echo ($_GET['n']);  ?> de tu cuenta.</p>

<label for="pass">*Contraseña de la cuenta</label>
<span class="input"><input name="pass" type="password" id="pass" size="10" maxlength="30" autocomplete="off" required value=""></span>
<label for="pni">*Pin de la cuenta</label>
<span class="input"><input name="pin" type="password" id="pin" size="10" maxlength="30" autocomplete="off" required value=""></span>
<div class="clear"></div>
</div>
<div class="clear"></div>

<input type="hidden" value="<?php echo $_GET['n'];?>" name="nick" id="nick">
<input type="hidden" value="quitar-personaje" name="a">
<a id="Submit"  href="#" onclick="return quitarpj()">Quitar PJ</a><br>
</fieldset></div>
<?php } ?>
</div>
</div>
                    </div>
                </div>
                


<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>