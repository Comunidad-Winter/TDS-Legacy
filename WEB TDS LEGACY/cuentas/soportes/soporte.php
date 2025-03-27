<?php

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    $conn = connect();


?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <title>TDS Legacy - Cuentas - Soporte premium</title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
    <!--[if lt IE 7.]>
        <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
        <![endif]-->
    <link href='/general.css' rel='stylesheet' type='text/css' />
    <link href='/caja.css' rel='stylesheet' type='text/css' />
    <link href='/panel-premium.css' rel='stylesheet' type='text/css' />
    <link href='/cuentas-premium.css' rel='stylesheet' type='text/css' />
    <link href='/soporte.css' rel='stylesheet' type='text/css' />
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
            <div class='titulo_seccion'><h1>Soporte premium</h1></div>
<div id="main">
<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;"> 
<div class="tit">
<h1>Panel de Soportes</h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><br>
<h1 align="center">Soporte</h1>

<?php

	if (isset($_POST['SendSup'])) {

		$ticketid=0;
		if (!isset($_POST['nick']) || !isset($_POST['sector']) || !isset($_POST['asunto']) || !isset($_POST['mensaje'])) {
			$result="1) no";
		}
		if (strlen(($_POST['nick']))<1  || empty($_POST['sector']) || empty($_POST['asunto']) || empty($_POST['mensaje'])) {
			$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Por favor elige un sector válido.</b>';
		}

		$quit=false;

		$pjNick = clear_nick($_POST['nick']);
		$sector = intval($_POST['sector']);
		$asunto = trim($_POST['asunto']);
		$mensaje = trim($_POST['mensaje']);

        $valid=false;

        $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
        if($res) { //&& $res->num_rows === 1
            while ($pj = $res->fetch_assoc() && $valid == false) {
                if (strtoupper($pj['nick']) ===  strtoupper($pjNick)) {
                    $valid =true;
                }
            }
        }

		if (empty($_POST['sector'])) $sector=0; 
	
		if ($pjID <= 15 || $pjID = 0 && $valid ) {
			
			switch ($sector) {case 0: case 1:case 2:case 7:case 9:case 11:case 15:case 16:case 17:case 20:case 21:case 22:case 23:break;
				default:$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">Seleccionaste un sector equivocado my boy.</b>';$quit=true;break;}
					
			if (mb_strlen($asunto)>30) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del asunto debe ser menor a 30 caracteres!</b>';$quit=true;}
			if (mb_strlen($mensaje)>600) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe ser menor a 600 caracteres!</b>';$quit=true;}
			if (mb_strlen($asunto)<5) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 5 caracteres!</b>';$quit=true;}
			if (mb_strlen($mensaje)<15) {$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">El largo del mensaje debe tener al menos 15 caracteres!</b>';$quit=true;}
		
			if (!$quit) {

				$asunto = $conn->real_escape_string($asunto); 
				$mensaje = $conn->real_escape_string($mensaje); 

				$account_id=$_SESSION['id'];
				$sql = "insert into soportes (pj_id, account_id, sector, asunto, mensaje) VALUES (?,?,?,?,?);";
				$stmt = mysqli_stmt_init($conn);

				if (!mysqli_stmt_prepare($stmt, $sql)) {

					$result='<b style="color:ff00ff;margin:10px;">Hubo un error al crear el soporte.</b>';
					exit;
				}else{
					mysqli_stmt_bind_param($stmt, "siiss", $pjNick,$account_id,$sector,$asunto,$mensaje);
					mysqli_stmt_execute($stmt);
				} 

				$ticketid =$conn->insert_id;
				if ($ticketid>0) {			
					$result='<b style="color:#0f0;margin:10px;">Gracias por usar el sistema de soporte de TDS Legacy.<br>
						Se ha creado el Ticket de soporte Nº'.$ticketid.'<br>
						Para ver el estado de tu soporte, podés seguir el siguiente vinculo: <br>' ;
					$result.= '<a href="cpremium.php?a=mis-soportes&ticket=' . $ticketid .'">https://tdslegacy.com.ar/cpremium.php?a=mis-soportes&ticket=' .$ticketid .'</a></b>';
				}else{
					$result='<b style="color:ff00ff;margin:10px;">Hubo un error al crear el soporte.</b>';
				}
			}
			
		}else {			
			$result='<b color: #ed1c1c;
            text-shadow: 1px 1px black;
            font-size: medium;
            display: block;
            margin: 10px;">No seleccionaste ningun personaje.<br>';
		}

		echo($result);

	}else{

?>

<form name="soporte_tds" method="post" onsubmit="return validarpremium()" action="#" id="cuentasPremium">
<fieldset>
<div class="campos">
<p class="form-tit">Completá el formulario con información verdadera, a la brevedad será respondido.</p>
<input type="hidden" name="a" value="soporte">
<label for="nick">Nick del personaje:</label>
<select name="nick" id="nick" style="color:#fff;background-color:#1c1c1c;border:1px solid #DBD4C0;">

<?php 

    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
    if($res) { //&& $res->num_rows === 1
        while ($pj = $res->fetch_assoc()) {
            echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
        }
    }

?>

<option value="0">Ninguno</option></select><div class="clear"></div>
<label for="sector">Sector:</label>
<select name="sector" id="sector" style="color:#fff;background-color:#1c1c1c;border:1px solid #DBD4C0;"><option value="">---------------------</option> <option value="1">Bug</option>
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
</select><div class="clear"></div>
<div><table cellpadding="0" cellspacing="0" border="0" style="background:url(/imagenes/bg_input.gif); width:480px; display:none" align="center" id="alerta">
<tbody><tr>
<td id="txt_alerta"></td>
</tr>
</tbody></table></div>
<label for="asunto">Asunto:</label>
<span class="input" style="margin-bottom:0px;">
<input type="text" name="asunto" id="asunto" size="40" value="">
</span>
<div class="clear"></div>
<label for="mensaje">Mensaje:</label>
<span class="textarea" style="margin-bottom:0px;">
<textarea cols="25" rows="5" name="mensaje" id="mensaje" style="overflow:auto;"></textarea></span>
</div></fieldset>
<p>
<input type="submit" value="Enviar" name="SendSup" id="Submit" style="border:0"></p>
</form>

<?php } ?>
</div>
</div>