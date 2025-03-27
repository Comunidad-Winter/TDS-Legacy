<?php 
	
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
	
	if (isset($_SESSION['verified'])) {
		
		if ($_SESSION['verified'] == 1)
			redirect_to_panel();
		else
			redirect_to_verification();
	}

    $conn = connect();

 ?>

<!DOCTYPE html	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="csrf_token" content="<?php echo createToken(); ?>" />
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
<title>AO Legacy - Cuentas Premium</title>
<meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Premium, Cuentas Premium, Panel de personaje" />

<!--[if lt IE 7.]>
        <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
        <![endif]-->

<link href='/general.css' rel='stylesheet' type='text/css' />
<link href='/caja.css' rel='stylesheet' type='text/css' />
<link href='/cuentas-premium.css' rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="menu_desplegable.css" type="text/css" />
<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
<script type="text/javascript" src="/scripts/animated_header.js"></script>
<script type="text/javascript" src="/scripts/header.js"></script>
<link href="/header.css" rel='stylesheet' type='text/css'>

<script type="text/javascript">
		function Recordar() {
			var checkbox = document.getElementById("checkbox");
			var r = document.getElementById("recordar");

			checkbox.className = (checkbox.className == "") ? "On" : "";
			r.value = (r.value == "0") ? "1" : "0";
		}

		function nuevoAjax() {
			var xmlhttp = false;
			try {
				xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (E) {
					xmlhttp = false;
				}
			}

			if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
				xmlhttp = new XMLHttpRequest();
			}

			return xmlhttp;
		}

	</script>
</head>
<body id="seccion_premium" onload="init();">


<div id='bg_top'>
<div id='pagina'>

<div id='header'>
<div id="animation_container" style="background:none; width:700px; height:197px">
<canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
<div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
</div>
</div>
<div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
<span style='display: inline-block; height: 100%; vertical-align: middle;'></span>
<img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' />
</div>
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
<h1>Registr&aacute; tu cuenta!</h1>
<div class="contenedor">
<div class="der">
<div id="login">
<h4>Acceder</h4>

<form name="login-cuenta" method="post" id="login-cuenta">
<small id="errs" style="color:red;font-size:8pt;font-weight:bold;"><?php 

	if(isset($_GET['rid']) && $_GET['rid'] !== '' && isset($_GET['rh']) && $_GET['rh'] !== '') {
		$C = connect();
		if($C) {
			$res = sqlSelect($C, 'SELECT user,hash,timestamp FROM requests WHERE id=? AND type=0', 'i', $_GET['rid']);
			if($res && $res->num_rows === 1) {
				$request = $res->fetch_assoc();
				if($request['timestamp'] > time() - 60*60*24) {
					if(password_verify(urlSafeDecode($_GET['rh']), $request['rh'])) {
						if(sqlUpdate($C, 'UPDATE cuentas SET verified=1 WHERE id=?', 'i', $request['user'])) {
							sqlUpdate($C, 'DELETE FROM requests WHERE user=? AND type=0', 'i', $request['user']);
							echo 'Email validado, puede ingresar';
						}
						else {
							echo 'No se pudo updatear la DB, avise a un ADMIN!';
						}
					}
					else {
						echo 'Invalid request.';
					}
				}
				else {
					echo 'Solicitación de renovación obsoleta.';
				}
				$res->free_result();
			}
			else {
				echo 'Invalid request.';
			}
			$C->close();
		}
		else {
			echo 'No me pude conectar al server.';
		}		
	}

?></small>
<br>
<p>
<label for="usuario">Usuario</label>
</p>
<div class="input-bg">
<input type="text" name="usuario" id="usuario" class="input" maxlength="30" required />
</div>
<p>
<label for="contrasena">Contraseña</label>
</p>
<div class="input-bg">
<input type="password" name="contrasena" id="contrasena" class="input" maxlength="30" required />
<input type="hidden" name="redirect" value="" />
</div>
<label for="recordar" class="rLabel">
<input type="hidden" name="recordar" id="recordar" value="0" />
<span id="checkbox" onclick="Recordar()">Recordarme</span>
</label>
<p class="entrar">
<a name="entrar" id="entrar" style="
    background: url(/imagenes/cuentas/entrar.gif) no-repeat;
    height: 21px;
    width: 48px;
    padding-bottom: 2px;
    color: #ffe263;
    font-weight: 700;
    font-family: trebuchet ms;
    font-size: 13px;
    cursor: pointer
" onclick="login();">Entrar</a>

</p>
<p style="margin-top:10px;">
<a href="/recupass.php">Olvidé mi contraseña</a>
</p>
</form>
</div>
</div>

<div class="clear"></div>

<div>
<a href="/crea-cuenta-premium.php" class="crea-tu-cuenta" title="Creá tu Cuenta">
<span>Creá tu Cuenta Premium</span>
</a>
</div>
</div>
</div>
</div>

<script src="/php/script.js"></script>


<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>