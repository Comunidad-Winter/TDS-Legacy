<?php 

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();

 ?>
<!DOCTYPE html
  PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<title>TDS Legacy - Mini Estad&iacute;sticas</title>
<meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
<meta http-equiv="Content-Language" content="es" />
<meta name="Author" content="TDS Legacy" />
<meta name="copyright" content="TDS Legacy" />
<link rel="alternate" href="https://tdslegacy.com.ar/noticias/rss.php?fn_category=1" title="TDS Legacy RSS" />
<link rel="start" href="https://tdslegacy.com.ar/mini_estadisticas.php" title="TDS Legacy | Mini Estad&iacute;sticas" />
<!--[if lt IE 7.]>
<script defer type='text/javascript' src='/scripts/pngfix.js'></script>
<![endif]-->

<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/caja.css' rel='stylesheet' type='text/css' />
<link href='/mini_estadisticas.css' rel='stylesheet' type='text/css' />
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'>
</style>
</head>
<body id="seccion_recupass" onload="init();">


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

<?php
    require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>

<div class='titulo_seccion'>
<h1>Mini estad&iacute;sticas</h1>
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
<div class='mini_est'>
<h2>TDS Legacy</h2>
<h3>Mini estadísticas</h3>
<div class='contenido'>
<?php 
if (!$conn) {
    echo ("No hay conexión a la base de datos");
}else{

    //include 'cuentas/mis_personajes/seg.php';

    if(isset($_POST['nick'])) {
        $nick = $_POST['nick'];
    }
    elseif(isset($_POST['nick_m'])) {
        $nick = $_POST['nick_m'];
    }
    elseif(isset($_GET['nick'])) {
        $nick = $_GET['nick'];
    }
    else{
        $nick="-";
    }
    
    $nick=mb_strtoupper($nick);
    
    if (mb_strlen($nick) > 2 || mb_strlen($nick) < 21) {

        $nick = $conn->real_escape_string($nick); 

        $sql = "SELECT * FROM user WHERE nick=?;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo 'El sistema no funciona.';
        } else {
            mysqli_stmt_bind_param($stmt, "s", $nick);
            mysqli_stmt_execute($stmt);

            $result = mysqli_stmt_get_result($stmt);

            if (mysqli_num_rows($result) > 0) {
                while ($row = mysqli_fetch_assoc($result)) {

                    $showrecordatorio = true;
                    $reputacion = round(((-$row['asesino']) + (-$row['bandido']) + $row['burgue'] + (-$row['ladron']) + $row['noble'] + $row['plebe']) / 6);

                    if ($row['ban'] == 0) $ban = "No";
                    else $ban = "Si";
                    $add = "";

                    switch ($row['status']) {
                        case 2:
                            $flag = 'armada';
                            $showrecordatorio = false;
                            $manorepu = "rep_p";
                            $add = 'es miembro de la <strong>Armada Real</strong>';
                            break;
                        case 1:
                            $flag = 'caos';
                            $showrecordatorio = false;
                            $manorepu = "rep_n";
                            $add = 'es miembro de la <strong>Legión Oscura</strong>';
                            break;
                        default:

                            if ($reputacion < 0) {
                                $manorepu = "rep_n";
                                $flag = 'neutro_crimi';
                            } else {
                                $manorepu = "rep_p";
                                $flag = 'neutro';
                            }
                            break;
                    }

                    if ($reputacion < 0) $manorepu = "rep_n";
                    else $manorepu = "rep_p";
                    
                    if ($row['privilegios'] != 1){
                            $flag = 'neutro';
                            $showrecordatorio = false;
                            #$manorepu = "rep_p";
                            $add = '<strong style="font-size:0.6em;">(Game Master)</strong>';
                    }

                    $recordatorio="";
                    if ($showrecordatorio) {
                        $recordatorio= '<div class="miniest"><ul class="recordatorio"><li class="ra_tit">Recuerde que para entrar a la Armada Real necesita:</li><li>Matar mas de 100 criminales.<br>Ciudadanos matados deben ser 0, de lo contrario, ya no podra ingresar nunca mas. Nivel debe ser 25 o mas.</li><li class="rc_tit">Recuerde que para entrar a las Fuerzas del caos necesita:</li><li>Ciudadanos matados deben ser 150 o mas <br> Nivel debe ser 25 o mas.</li></ul></div>';
                    }

                    echo('<div id="'.$flag.
                        '"><div class="bandera_l"><div class="bandera_r"><div class="contenido"><div class="borde"></div><table summary="Mini Estadísticas TDS" align="center" border="0" cellpadding="0" cellspacing="0" id="tabla_miniest"><tbody><tr><td colspan="3" align="center" title="Estadísticas de '.$nick.
                        '"><h4><span class="nick">'.$nick.
                        ' </span>'.$add.
                        '</h4></td></tr><tr><td class="titulo">Clase:</td><td title="'.$row['clase'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/laud.gif" alt="'.$row['clase'].
                        '"></td><td class="dato">'.$row['clase'].
                        '</td></tr><tr><td class="titulo">Raza:</td><td title="'.$row['raza'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/cara_1.gif" alt="'.$row['raza'].
                        '"></td><td class="dato">'.$row['raza'].
                        '</td></tr><td class="titulo">Reputación:</td><td title="'.$reputacion.
                        '" class="img"><img src="../imagenes/mini_estadisticas/'.$manorepu.
                        '.gif" alt="172"></td><td class="dato"><strong>'.$reputacion.
                        '</strong></td></tr><tr><td class="titulo">Ciudadanos matados:</td><td title="'.$row['ciudas_matados'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/ciudadanos_matados.gif" alt="'.$row['ciudas_matados'].
                        '"></td><td class="dato">'.$row['ciudas_matados'].
                        '</td></tr><tr><td class="titulo">Criminales matados:</td><td title="'.$row['crimis_matados'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/criminales_matados.gif" alt="'.$row['crimis_matados'].
                        '"></td><td class="dato">'.$row['crimis_matados'].
                        '</td></tr><tr><td class="titulo">Usuarios matados:</td><td title="'.$row['total_matados'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/usuarios_matados.gif" alt="'.$row['total_matados'].
                        '"></td><td class="dato">'.$row['total_matados'].
                        '</td></tr><tr><td class="titulo">Npcs matados:</td><td title="'.$row['criaturas_matadas'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/npcs_matados.gif" alt="'.$row['criaturas_matadas'].
                        '"></td><td class="dato">'.$row['criaturas_matadas'].
                        '</td></tr><tr><td class="titulo">Tiempo de carcel:</td><td title="'.$row['carceltime'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/tiempo_carcel.gif" alt="'.$row['carceltime'].
                        '"></td><td class="dato">'.$row['carceltime'].'</td></tr><tr><td class="titulo">Clan:</td><td title="'.$row['clan'].
                        '" class="img"><img src="../imagenes/mini_estadisticas/clan.gif" alt="'.$row['clan'].
                        '"></td><td class="dato">'.$row['clan'].
                        '</td></tr><tr><td class="titulo">Baneado:</td><td title="'.$ban.
                        '" class="img"><img src="../imagenes/mini_estadisticas/ban.gif" alt="'.$ban.
                        '"></td><td class="dato">'.$ban.
                        '&nbsp;</td></tr></tbody></table>'.$recordatorio.'</div></div></div></div>');

                }
            } else {
                echo 'El personaje '.$nick.' no se encuentra en nuestra base de datos.';
            }        
        }
    }
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

<div class="link_volver" style="margin-top:20px;"><a href="javascript:history.back()">Volver</a></div>
</div>


<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>