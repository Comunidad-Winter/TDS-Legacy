<?php 
$titulonoticia="";
$id=0;
$found=false;

if (isset($_GET['n'])){

    $explode=explode('.',$_GET['n'],2);

    if (count($explode) == 2){
        $titulonoticia=$explode[1];
        $id=intval($explode[0]);
    }elseif (count($explode) == 1){
        $id=intval($explode[0]);
        $titulonoticia='Noticia Nº'.$id;
    }
}

if (file_exists("noticias/$id.php")){
    $found=true;
}
 

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - <?php echo $titulonoticia;?>
    </title>
    <meta name="keywords" content="Sistema de soporte, Soporte, Soporte TDSL, Problemas tecnicos, Robo de personajes, Errores, Run time, Run time error" />
    <!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/noticia.css' rel='stylesheet' type='text/css' />
    <link href="/comentarios/coments.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/scripts/funciones.js"></script>
    <script type="text/javascript" src="/comentarios/comentarios.js"></script>
    <script type='text/javascript' src='/soportes.js'></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
    </style>
</head>

<body onload="init();">
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
            <?php if($found) include "noticias/$id.php"; else include "noticias/0.php"; ?>
                    <!--<div id="comentarios">
                        <div class="comentarios">
                            <h3>No hay comentarios</h3>
                        </div>
                        <div id="ncomentario" style="display: none;">
                            <div id="c0" class="comentario">
                                <div class="top_left_corner">
                                    <div class="top_right_corner">
                                        <div class="bottom_left_corner">
                                            <div class="bottom_right_corner">
                                                <div class="vot_com_inv" {d_v}="" id="vtb0">
                                                    <div class="bloke_vot3">[<b id="vot0">0</b>]</div>
                                                    <a onclick="return votar_comentario(1,0)" style="text-decoration: none;" title="Opinar a favor de este comentario." href="#">
                                                        <div class="bloke_vot1">&nbsp;</div>
                                                    </a>
                                                    <a onclick="return votar_comentario(-1,0)" style="text-decoration: none;" title="Opinar en contra de este comentario." href="#">
                                                        <div class="bloke_vot2">&nbsp;</div>
                                                    </a>
                                                </div>
                                                <div class="fecha">21/09/22 15:27</div>
                                                <div class="opciones">
                                                </div>
                                                <div class="info">
                                                    <span class="nro-comentario">[ 1 ]</span>&nbsp;<span class="usuario-comentario"></span>
                                                    <span id="result0" class="small_s"></span>
                                                </div>
                                                <div class="borde-separador-box">
                                                    <div class="borde-separador"></div>
                                                </div>
                                                <div id="texto0" class="texto">
                                                    <span id="texto_coment"></span>
                                                    <div class="clear"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <h4 class="error">Para poder dejar tu comentario necesitas tener una <a href="/cuenta-premium.php">Cuenta Premium</a> y estar logueado en ella.</h4>
                    </div>
                -->
                </div>
                <!--- <script type="text/javascript">
                cargarComent("comentarios", 477357)
                </script> -->
                <br>
                <div class="link_volver"><a href="javascript:history.back()">Volver</a></div>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>