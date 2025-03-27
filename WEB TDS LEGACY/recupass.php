<?php
	 
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    $err=null;
	if(!empty($_POST['mail']) && !empty($_POST['pin'])) {
		
		if(!checkdnsrr(substr($_POST['mail'], strpos($_POST['mail'], '@') + 1), 'MX')) {
			$err = "Tu email no es valido";
		}

		if(strlen($_POST['pin']) > 255 || !strlen($_POST['pin']) > 2 || !preg_match('/^[a-zA-Z- ]+$/', $_POST['pin'])) {
			$err = "Tu pin es invalido";
		}

		$sql = "SELECT * FROM account WHERE (email=? AND pin=?) ;";
		
		//if(!empty($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
			$C = connect();
			if($C) {
				
				$dayago = time() - 60 * 60 * 24;
				$res = sqlSelect($C, 'SELECT cuentas.*, COUNT(requests_account.id) 
                      FROM cuentas 
                      LEFT JOIN requests_account ON cuentas.id = requests_account.account_id AND requests_account.type = 1 
                      WHERE cuentas.email = ? AND cuentas.pin = ? 
                      GROUP BY cuentas.id', 'ss', $_POST['mail'], $_POST['pin']);
				
				if($res && $res->num_rows === 1) {
					$acc = $res->fetch_assoc();
					
					if($acc['COUNT(requests_account.id)'] < MAX_PASSWORD_RESET_REQUESTS_PER_DAY) {						

						$code = random_bytes(32);
						$hash = password_hash($code, PASSWORD_DEFAULT);
						$insertID = sqlInsert($C, 'INSERT INTO requests_account VALUES (NULL, ?, ?, ?, ?, ?, 1)', 'isiss', $acc['id'], $hash, time(),$_POST['pin'], $_POST['mail']);
						if($insertID !== -1) {
							
							$msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
							<div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$acc['username'].'!</strong></p><p>Has solicitado restablecer la contrase&ntilde;a de tu cuenta. Si tu no pediste esto puedes ignorar este mensaje. <br />
											<br/>
											Para restablecer tu contrase&ntilde;a por favor visit&aacute; la siguiente p&aacute;gina: <br />
											<a href="'. RESET_ACC_PASSWORD_ENDPOINT . 'rid=' . $insertID . '&hash=' . urlSafeEncode($code) .'">Haz click aqui para recuperar tu clave.</a><br/>
											<br/>
											Cuando visites esa p&aacute;gina tu contrase&ntilde;a se cambiar&aacute; y te enviaremos una nueva.</p>';
							
							if(sendEmail($_POST['mail'], $acc['username'], 'Reseteo de contraseña', $msg, true)) {								
								$err = "Un email ha sido enviado para resetear tu contraseña";// echo 'An email has been sent if an acc with that email exists';
								
							}
							else {								
								$err = 'No pude enviarte el correo. Valida tu email fácilmente acá: <a href="'. RESET_ACC_PASSWORD_ENDPOINT . 'rid=' . $insertID . '&hash=' . urlSafeEncode($code) .'">';
							}
						}
						else {							
							$err = "Error al crear la solicitud de recuperar contraseña";
						}
					}
					else {						
						$err = "Haz realizado muchos intentos en las últimas 24 horas, intentelo en otro momento.";// echo 'Too many requests in the last 24 hours... try again later';
					}
				}
				else {					
					if ($err != null) {
						$err = "Un email ha sido enviado para resetear tu contraseña";
					}					
				}
				$C->close();
			}
			else {				
				$err = "No me pude conectar con la base de datos";// echo 'Failed to connect to database';
			}
	}else {			
		//	$err = 5;// echo 'Invalid CSRF token';
		//}
	}


?>

<!DOCTYPE html	PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta name="csrf_token" content="<?php echo createToken(); ?>" />
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>AO Legacy - Recuperar Clave</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Juego online, Juegos Online, Online, Juegos, Premium, Cuentas Premium, Panel de personaje" />

    <!--[if lt IE 7.]>
    <script defer type="text/javascript" src="/scripts/pngfix.js"></script>
    <![endif]-->
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/scripts/thumbs.js"></script>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel='stylesheet' type='text/css'>
</style>
</head>
<body id="seccion_inicio" onload="init();">

<div id='bg_top'>
<div id='pagina'>

<div id='header'>
<div id="animation_container" style="background:none; width:700px; height:197px">
<canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
<div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
</div>
</div>
<div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'>
<span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' />
</div>
</div>

<?php
	require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
?>

<div class='titulo_seccion'>
    <h1>Cuenta</h1></div>
    <div id="main">
    
    <div id="panel-premium">
    <div class="cuentas_premium" style="text-align:left;">
    <div class="tit">
		<h1>Recuperar cuenta</h1>
		<p class="necesario"></p>
	</div>
    <div style="margin:30px;">
	
	<?php
	if ($err != null) {
		print_r($err);
	}
	
?>
	<h1>Paso 1</h1><form method="post" action="recupass.php" name="cuentasPremium" id="cuentasPremium"><fieldset><div class="campos"><p class="form-tit">Completá este formulario para recuperar tu contraseña</p><label for="mail">*E-Mail</label><span class="input"><input name="mail" type="text" id="mail" size="10" maxlength="40" value=""></span><label for="pin">*Pin</label><span class="input"><input name="pin" type="text" id="pin" size="10" maxlength="40" value=""></span><input name="a" type="hidden" value="recupass"><input name="i" type="hidden" value="1"><input name="s" type="hidden" value="recupass"><div class="clear"></div><input id="Submit" type="submit" value="Enviar" name="Submit" style="border:0"></div></fieldset></form>
                        

</div></div>
    </div>
    
    <?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>