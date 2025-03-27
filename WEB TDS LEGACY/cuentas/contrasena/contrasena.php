<?php 

$result="";
$success=false;

foreach($_POST as $key => $value){

    $_POST[$key] = _cleaninjections(trim($value));
	//echo $key . "=" .$_POST[$key];
}

if (isset($_POST['Submit'])) {	
	if (isset($_POST['Password'])) {		
		if (isset($_POST['Password2'])) {			
			 if (isset($_POST['cactual'])) {			 
			 	if (empty($_POST['cactual']) || empty($_POST['Password']) || empty($_POST['pin']) || empty($_POST['Password2'])) {
			 		die("Bad Gateway");
			 	}
			 	
				require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
				$conn = connect();
				require_logged();
				require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
				
			 	$cactual= trim($_POST['cactual']);
			 	$pin= trim($_POST['pin']);
			 	$pass= trim($_POST['Password']);
			 	$pass2= trim($_POST['Password2']);
			
				$cactual = $conn->real_escape_string($cactual);
				$pin = $conn->real_escape_string($pin);
				$pass = $conn->real_escape_string($pass);
				$pass2 = $conn->real_escape_string($pass2); 
				
				if ((strlen($pin) < 4)||(strlen($pin) > 30)||(strlen($pass) > 30)||(strlen($cactual) < 4)||(strlen($cactual) > 30)||(strlen($pass) < 4)||(strlen($pass2) < 4)||(strlen($pass2) > 30)) {
					$_SESSION['err'] = '<div><h2 style="text-align:center;">Datos invalidos.</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
					header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
					exit();
			 	}

			 	if (strcmp($pass, $pass2) !== 0) {
		 			$pwdCheck=false;
					 $_SESSION['err'] = '<div><h2 style="text-align:center;">Como te salteaste la otra comprobación pilluelo? Hacé las cosas bien.!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
					header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
					exit();
		 		}else{

			 		$pwdCheck =  strcmp($cactual, $_SESSION['password']);//password_verify($cactual, $_SESSION['password']);
					
			 		if ($pwdCheck === 0) {
						
			 			if (strcmp($pin, $_SESSION['pin']) == 0) {
								
							$line = "|5|". $ip ."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'. $pass;
								
							$data="";
							
							server_getdata($line,$data); 

							switch ($data[0]) {
								case '0':
									$_SESSION['err'] = '<div><h2 style="text-align:center;">Contraseña actualizada!</h2></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									break; // valid
								case '1':
									$_SESSION['err'] = '<div><h2 style="text-align:center;">La cuenta no existe!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									exit;
								case '2': case '3':
									$_SESSION['err'] = '<div><h2 style="text-align:center;">Email invalido!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									exit;
								case '4':
									$_SESSION['err'] = '<div><h2 style="text-align:center;">Cuenta invalida!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									exit;
								case '5':
									$_SESSION['err'] = '<div><h2 style="text-align:center;">Contraseña muy larga!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									exit;
								default:
									$_SESSION['err'] = '<div><h2 style="text-align:center;">Error: '. $data .'</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
									header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
									exit;
							}

							$sql = "UPDATE cuentas SET password=? WHERE id=" .$_SESSION['id'] .";";

							$stmt = mysqli_stmt_init($conn);
							if (!mysqli_stmt_prepare($stmt, $sql)) {
								$_SESSION['err'] = '<div><h2 style="text-align:center;">SQL ERROR!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
								header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
								exit();
							}
							else {
								
								mysqli_stmt_bind_param($stmt, "s", $pass);
								mysqli_stmt_execute($stmt);
							}
							$success=true;
							$_SESSION['password']=$pass;

							$_SESSION['err'] ='<div><h2 style="text-align:center;">Contraseña cambiada correctamente!</h2> <div class="link_volver"><a href="javascript:history.back()">Volver</a></div></div>';
							header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
							exit();
							
			 			}else {
							$_SESSION['err'] = '<div><h2 style="text-align:center;">Datos incorrectos!</h2> <div class="link_volver"><a style="color: #101010;" href="javascript:history.back()">Volver</a></div></div>';
							header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
							exit();
						}

			 		}else{
						$_SESSION['err'] = '<div><h2 style="text-align:center;">Datos incorrectos!</h2> <div class="link_volver"><a style="color: #101010;" href="javascript:history.back()">Volver</a></div></div>';
						header("Location: " . $_SERVER['PHP_SELF']. '?a=contrasena');
						exit();
	 				}
			 	}
			}
		}
	}
}

?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<title>TDS Legacy - Cuenta - Cambiar clave</title>
	<!--[if lt IE 7.]>
	<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
	<![endif]-->
	<link href="/general.css" rel="stylesheet" type="text/css">
	<link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/scripts/funciones.js"></script>
	<script type="text/javascript" src="/scripts/cambiarcontrasena.js"></script>
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
            <div class="titulo_seccion"><h1>Panel premium</h1></div>
<div id="main">
<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;">
<div class="tit">
<h1>Panel de <?php echo $_SESSION['username'] ?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>

</div>
<?php

if (isset($_SESSION['err'])){ 
	echo $_SESSION['err'];
	unset($_SESSION['err']);
}
else{ ?>
<form method="post" action="?a=contrasena" name="cuentasPremium" id="cuentasPremium" onsubmit="return validarFormulario()">
<div class="campos">
<p class="form-tit">Completá este formulario para cambiar la contraseña</p>
<div class="avisos" id="ayuda2a" style="display:inline">
<p>La contraseña debe contener entre 8 y 30 caracteres. Para obtener un nivel alto de seguridad <strong>alterna entre minúsculas, mayúsculas y números</strong>.</p>
</div>
<span class="noerr" id="errPasswordActual"><span class="p">Por favor, ingresá la contraseña actual de la cuenta.</span></span>
<label for="cActual">*Contraseña actual</label>
<span class="input">
<input name="cactual" type="password" id="cActual" size="10" maxlength="30" value="">
</span>
<span class="noerr" id="errPassworNuevo"><span class="p">Por favor, ingresá una contraseña nueva válida.</span></span>
<label for="Password">*Contraseña nueva</label>
<span class="input">
<input name="Password" type="password" id="Password" size="10" maxlength="30" value="" onkeyup="mostrarPoderClave(this)">
</span>
<label><em>Seguridad de la contraseña</em></label>
<div class="seguridad">
<div class="nivel-actual" style="width:0px;" id="barra"><span id="txt_barra"></span>
</div>
</div>
<div class="clear"></div>
<span class="noerr" id="errPassword2"><span id="errorRePass" class="p">Por favor, ingresá una Contraseña válida.</span></span>
<label for="Password2">*Repita la nueva contraseña</label>
<span class="input">
<input name="Password2" type="password" id="Password2" onblur="chequearReIngreso()" size="10" maxlength="30" value="">
</span>

<span class="noerr" id="errPIN"><span class="p">Por favor, ingresá la PIN de la cuenta.</span></span>
<label for="pin">*Clave PIN</label>
<span class="input">
<input name="pin" type="password" id="pin" size="10" maxlength="20" value="">
</span>
<div class="clear"></div>
<input id="Submit" type="submit" value="Cambiar" name="Submit" style="border:0">
</div>
</form>
	
<?php } ?>

</div>
</div>
