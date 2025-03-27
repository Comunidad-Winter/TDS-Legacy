<?php 
	require_once 'php/utils.php';
   
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <meta name="csrf_token" content="<?php echo createToken(); ?>" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Cuentas - Registro</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <!--[if lt IE 7.]>
        <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
        <![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/cuentas-premium.css' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="/cuentas/crearcuenta.js"></script>
    <script type="text/javascript" src="/cuentas/funciones.js"></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>  
    
    <link href="/header.css" rel='stylesheet' type='text/css'>
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
            <div class='titulo_seccion'>
                <h1>Cuenta</h1>
            </div>
            <div id='main'>
                <div class="cuentas_premium">
                    <div class="tit">
                        <h1>Cre&aacute; tu Cuenta ahora!</h1>
                    </div>
                                             
                    <div id="errs" class="errcontainer"></div>

                    <form id="cuentasPremium">

                    <input type="hidden" id="uAyuda" />
                        <fieldset>
                            <div class="campos">
                                <p class="form-tit">Elegí el nombre de tu cuenta</p>
                                <span class="noerr" id="errusername">
                                    <span id="txtusername" class="p">Por favor, ingres&aacute; un nombre para tu cuenta v&aacute;lido.</span>
                                    <label for="username">*Nombre de cuenta</label>
                                    <span class="input" style="margin-bottom:0px;">
                                        <input name="username" required autofocus type="text" id="username" size="10" maxlength="30" value="" onfocus="mostrarAyuda('ayuda1a')" onblur="ocultarAyuda('ayuda1a')" />
                                    </span>
                                </span>
                                <div class="clear"></div>
                                <div id="imgCargando" class="" style="margin-top:10px;">
                                    <input type="button" value="Comprobar disponibilidad" onclick="nombreDisponible()" id="comprobar" />
                                </div>
                                <span class="noerr" id="errmail">
                                    <span class="p">Por favor, ingres&aacute; un E-MAIL v&aacute;lido.</span>
                                    <label for="email">*E-mail</label>
                                    <span class="input"><input required name="email" type="email" id="email" size="10" minlength="7" maxlength="30" onfocus="mostrarAyuda('ayuda1b')" onblur="ocultarAyuda('ayuda1b')" />
                                    </span>
                                </span>
                            </div>
                            <div class="avisos" id="ayuda1a">
                                <p>Con este nombre vas a iniciar la sesión de tu cuenta.<br /> Mínimo 3 caracteres. <br />Máximo 30 caracteres.</p>
                            </div>
                            <div class="avisos" id="ayuda1b">
                                <p><br /><br />A est&aacute; direcci&oacute;n de correo electronico te enviaremos un mail para activar la cuenta y tamb&iacute;en te servira para recuperar tu contrase&ntilde;a.</p>
                            </div>
                            <div class="clear"></div>
                        </fieldset>
                        <fieldset>
                            <div class="campos">
                                <p class="form-tit">Elegí tu contraseña y PIN</p>
                                <span class="noerr" id="errpassword">
                                    <span class="p">Por favor, ingres&aacute; una Contrase&ntilde;a v&aacute;lida.</span>
                                    <label for="password">*Contraseña</label>
                                    <span class="input">
                                        <input required type="password" autocomplete="off" onkeyup="mostrarPoderClave(this,'barraPassword')" name="password" id="password" maxlength="30" onfocus="mostrarAyuda('ayuda2a')" onblur="ocultarAyuda('ayuda2a')" />
                                    </span>
                                </span>
                                <div class="clear"></div>
                                <label><em>Seguridad de la contraseña</em></label>
                                <div class="seguridad">
                                    <div class="nivel-actual" style="width:0px;" id="barraPassword">
                                        <span id="txt_barraPassword"></span>
                                    </div>
                                </div>
                                <div class="clear"></div>
                                <span class="noerr" id="errpassword2">
                                    <span id="errorpassword2" class="p">Por favor, re-ingresa la contraseña.</span>
                                    <label for="password2" style="margin-top:10px;">*Volvé a escribir la contraseña</label>
                                    <span class="input" style="margin-top:10px;">
                                        <input required type="password" autocomplete="off" name="password2" id="password2" maxlength="30" onchange="chequearReIngreso()" />
                                    </span>
                                </span>
                                <div class="clear"></div>
                                <span class="noerr" id="errpin">
                                    <span id="errorpin" class="p">Por favor, ingres&aacute; una PIN v&aacute;lida.</span>
                                    <label for="pin">*Clave PIN</label>
                                    <span class="input cols"><input required type="password" name="pin" id="pin" maxlength="20" onfocus="mostrarAyuda('ayuda2b')" onblur="ocultarAyuda('ayuda2b')" onkeyup="mostrarPoderClave(this,'barraPIN')" onclick="alert('¡ATENCIÓN! La clave PIN es una clave muy importante, por favor, no la olvides.')" />
                                    </span>
                                </span>
                                <div class="clear"></div>
                                <label><em>Seguridad del PIN</em></label>
                                <div class="seguridad">
                                    <div class="nivel-actual" style="width:0px;" id="barraPIN"><span id="txt_barraPIN"></span></div></div></div>
                                    <div class="avisos" id="ayuda2a">
                                        <p>La contrase&ntilde;a debe contener entre 8 y 30 caracteres. Para obtener un nivel alto de seguridad alterna entre min&uacute;sculas, may&uacute;sculas y n&uacute;meros.</p>
                                    </div>
                                    <div class="avisos" id="ayuda2b">
                                        <p><br /><br /><br />El PIN es una clave de seguridad necesaria para realizar distintas operaciones importantes con tu cuenta. Est&aacute; clave <strong>no se puede recuperar</strong>, debes tener cuidado de no olvidarla. M&iacute;nimo 8 caracteres, m&aacute;ximo 20. [a-Z,0-9]</p>
                                    </div>
                            <div class="clear"></div>
                        </fieldset>
                        <fieldset>
                            <div class="campos">
                                <p class="form-tit">Ingres&aacute; tus datos personales</p>
                                <span class="noerr" id="errNombre">
                                    <span class="p">Por favor, ingres&aacute; tu nombre y apellido.</span>
                                    <label for="nombre">*Nombre</label>
                                    <span class="input"><input required type="text" name="nombre" id="nombre" minlength="2" maxlength="30"  onfocus="mostrarAyuda('ayuda3')" onblur="ocultarAyuda('ayuda3')" value="" /></span>
                                    <label for="apellido">*Apellido</label>
                                    <span class="input"><input required type="text" name="apellido" id="apellido" minlength="2" maxlength="30"  onfocus="mostrarAyuda('ayuda3')" onblur="ocultarAyuda('ayuda3')" value="" /></span>
                                    </span>
                            </div>
                            <div class="avisos" id="ayuda3">
                                <p>Por favor, ingres&aacute; informaci&oacute;n ver&iacute;dica.<br /><br />Est&aacute; informaci&oacute;n nos permite relacionar una Cuenta con una persona f&iacute;sica y as&iacute; en caso de perdida y/o robo de una Cuenta poder identificar r&aacute;pidamente al due&ntilde;o de la misma.</p>
                            </div>
                            <div class="clear"></div>
                        </fieldset>
                        <div class="terminar">
                            <p class="form-tit">Para terminar</p>
                            
                            <div class="clear" style="height:0; visibility:hidden; overflow:hidden; width:0;"></div>
                            <p><input required type="hidden" name="acepto" id="acepto" value="0" />
                                <span class="checkbox" onclick="check(this)">He leido y estoy de acuerdo con los <a href="terminos-condiciones.php" target="_blank">términos y condiciones</a> del servicio. En caso contrario no crear&eacute; ninguna cuenta.</span></p>
                            <div style="clear:both;"><br /></div>
                            
                            <input   name="Submit" value="Crear Cuenta" id="Submit" style="border:0;margin-top:15px;margin-bottom:30px;" onclick="register();" />                            
                        </div>
                    </form>

                </div>
                
<script src="/php/script.js"></script>

                <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>