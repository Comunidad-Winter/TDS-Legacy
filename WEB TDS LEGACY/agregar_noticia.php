<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    require_gm();

    $valid=false;

    $noticia_id=0;

    if (isset($_POST['cuerpo']) & isset($_POST['titulo']) ) {
        if (!empty($_POST['cuerpo']) && !empty($_POST['titulo']) ) {        
            $autor=$_SESSION['username'];
            $cuerpo=$_POST['cuerpo'];
            $titulo=trim($_POST['titulo']);         
            
            if ((mb_strlen($cuerpo) > 1 && mb_strlen($cuerpo) < 10001) && (mb_strlen($titulo) > 2 && mb_strlen($titulo) < 100) ) {
                
                $sql = "insert into noticias(titulo, texto,autor) values (?,?,?)";        
                $date=date('Y-m-j H-i-s', time());
                $stmt = mysqli_stmt_init($conn);
                if (mysqli_stmt_prepare($stmt, $sql)) {
                    mysqli_stmt_bind_param($stmt, "sss", $titulo,$cuerpo,$autor);
                    mysqli_stmt_execute($stmt);        
                }

                $noticia_id =$conn->insert_id;

                if (!($noticia_id) > 0 ) {
                    echo'Hubo un error al insertar la noticia.';
                    exit();
                }
                
                $html ='<div class="titulo_seccion"><h1>'.$titulo.'</h1></div><div id="main"><div id="contenido"><div class="caja_margen"><div class="caja"><div class="caja_shadow_t"><div class="caja_shadow_b"><div class="caja_l"><div class="caja_r"><div class="caja_t"><div class="caja_b"><div class="caja_noticia"><h2>'.$titulo.'</h2><p>'.$cuerpo.'</p><div class="por_l"><div class="por_r"><div class="por_contenido"> <span class="dato">Fecha: '. $date .'</span> - Por: <span class="dato">'. $autor .'</span></div></div></div></div></div></div></div></div></div></div></div></div>';    
                
                file_put_contents('noticias/'.intval($noticia_id) .'.php',$html);
                require_once 'generador_historial-de-noticias.php';            
                
            }
        }
        exit;
    }

 ?>

<!DOCTYPE html
	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <title>TDS Legacy - Crear noticia</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
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
                if (document.getElementById("titulo").value == "") {
                    mensaje += "- Debe completar el titulo de la noticia\n";
                }

                if (document.getElementById("cuerpo").value == "") {
                    mensaje += "- Debe completar el cuerpo de la noticia\n";
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
                <h1>Publicar noticia</h1>
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
                                                        <h2>Noticia</h2>
                                                        <?php
                                                        if ($noticia_id> 0) {
                                                            echo "<h3>Noticia Nº".$noticia_id." agregada!</h3>".'<div class="form_soporte">';                                                            
                                                        }else{
                                                        ?>
                                                        <h3>Llena el formulario de la noticia</h3>
                                                        <div class="form_soporte">
                                                            <form name="agregarnoticia_TDSL" onsubmit="return validar(this)" method="post" action="/agregar_noticia.php">
                                                                <input type="hidden" name="origen" id="origen" value="-1">
                                                                <input type="hidden" name="idSoporte" value="0">
                                                                
                                                                <p>
                                                                <label for="titulo">Titulo de la noticia:<br /><input type="text" name="titulo" id="titulo" class="input" value="" /></label>
                                                                </p>
                                                                
                                                                <table cellpadding="0" cellspacing="0" border="0" style="background:url(/imagenes/bg_input.gif); width:430px; display:none;" align="center" id="alerta">
                                                                    <tr>
                                                                        <td id="txt_alerta"></td>
                                                                    </tr>
                                                                </table>

                                                                <p><label for="cuerpo"><br />
                                                                        Mensaje [5.000 caracteres maximo]:<br/>
                                                                        
                                                                        <textarea rows="4" cols="30" maxlength=5000 name="cuerpo" id="cuerpo"></textarea></label>
                                                                </p>
                                                                <p><input type="submit" value="Enviar" class="enviar" />
                                                                </p><br />
                                                            </form>
                                                        </div>
                                                        <?php echo '</div>';} ?>
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
                <div class="link_volver"><a href="javascript:history.back()">Volver</a></div>
                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>