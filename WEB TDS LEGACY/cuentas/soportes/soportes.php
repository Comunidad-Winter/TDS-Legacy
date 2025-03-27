<?php
	
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
	$conn = connect();
	require_logged();
	require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
	$print ='';

	if (!isset($_GET['ticket'])) {
		 
		$account_id=$_SESSION['id'];

		$sql = "select * from soportes where (account_id=?) ORDER BY fecha_creacion DESC;";
		$stmt = mysqli_stmt_init($conn);
		if (!mysqli_stmt_prepare($stmt, $sql)) {
			$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Hubo un error al obtener todos los tickets.</b>';
			goto Errorazo;
		}else{
			mysqli_stmt_bind_param($stmt, "i",$account_id);
			mysqli_stmt_execute($stmt);
		}

		$result = mysqli_stmt_get_result($stmt);

		if(mysqli_num_rows($result) > 0){
			$print.= '<h2>Lista de Tickets de soporte:</h2><ul class="beneficios">';
			while($row = mysqli_fetch_assoc($result)){
				$print.= '<li class="coment"><a href="?a=mis-soportes&amp;ticket='.$row['ticket'].'">'.$row['ticket'].': ' .$row['asunto'].'</a></li>';
			}
		}else $print.= '<h2>No tienes soportes abiertos.</h2><ul >';

		$print.= '</ul>';

	}elseif (isset($_POST['cerrar'])) {
		
		if (!isset($_POST['ticket'])) die();
		$ticketid=intval($_POST['ticket']);
		if (!$ticketid>0) die();
		
		$account_id=$_SESSION['id'];

		$sql = "select * from soportes where (account_id=? and ticket=?);";
 
		$stmt = mysqli_stmt_init($conn);
		if (!mysqli_stmt_prepare($stmt, $sql)) {
			$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket '. $ticketid.'.</b>';
			goto Errorazo;
		}else{
			mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
			mysqli_stmt_execute($stmt);
		}
		$result = mysqli_stmt_get_result($stmt);
		if (!$rowSoporte = mysqli_fetch_assoc($result)) {
			$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';
			goto Errorazo;
		}
		
		if ($_POST['cerrar'] =="S" || $_POST['cerrar'] =="s") {
			
			if ($rowSoporte['estado'] == 3) {
				$print.= '<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				goto printea;
			}
			$sql = 'UPDATE soportes SET estado="3" where (account_id=? AND ticket=?);';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				$print .= '<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				goto printea;
			}else{
				mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			
			if (!$err) {			
				$print .= '<b style="color:ff00ff;margin:10px;">Ticket cerrado!</b><br><a href="?a=mis-soportes&ticket=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ';
				goto printea;
			}else{
				$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Error!</b>';
				goto printea;	
			}

		}elseif(isset($_POST['r']) || isset($_POST['R'])) {
			if ($rowSoporte['estado'] <> 3) die();

			$sql = 'UPDATE soportes SET estado="4" where (account_id=? AND ticket=?);';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				goto Errorazo;
			}else{
				mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			 
			if (!$err) {			
				$print .= '<b style="color:ff00ff;margin:10px;">Ticket re-abierto!</b><br><a href="?a=mis-soportes&ticket=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ';
				goto printea;			
			}else{
				$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Error</b>';
				goto Errorazo;
			}
		}
		elseif (!isset($_POST['mensaje'])) {
			$_SESSION['err'] = '<b style="color:ff00ff;margin:10px;">Bad Gateway</b>';
			goto Errorazo;
		}
		$msj=html_entity_decode(trim($_POST['mensaje']));	
		$msj = filter_var($msj, FILTER_SANITIZE_STRING);
		
		$msj = clear_string($msj);

		$userid=$_SESSION['username'];

		if (strlen($msj)>600) {die("Mensaje muy largo");}
		elseif (strlen($msj)<2){die("Mensaje muy corto");}
		if (!isset($_POST['ticket'])) {die();}
		if (!intval($_POST['ticket']>0)) {die();}
		$ticketid=intval($_POST['ticket']);
		$mensaje = $conn->real_escape_string($msj); 
		$account_id=$_SESSION['id'];

		$sql = "insert into soportes_comment (ticketid, mensaje,replyfrom) VALUES (?,?,?);";
		$stmt = mysqli_stmt_init($conn);
		
		if (!mysqli_stmt_prepare($stmt, $sql)) {
			$_SESSION['err']='<b style="color:ff00ff;margin:10px;">Hubo un error al crear el comentario del soporte.</b>';
			goto Errorazo;
		}else{
			mysqli_stmt_bind_param($stmt, "iss", $ticketid,$mensaje,$userid);
			mysqli_stmt_execute($stmt);
		} 
 
		$commentid =$conn->insert_id;

		if ($commentid> 0 ){
			$sql = 'UPDATE soportes SET estado="0" where (account_id=? AND ticket=?);';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				$_SESSION['err']='<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				goto Errorazo;
			}else{
				mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
				mysqli_stmt_execute($stmt);
			} 
		}

		$print.=('<b style="color:ff00ff;margin:10px;">Comentario creado. <br><a href="?a=mis-soportes&ticket=' .$ticketid .'"> Pulse aqui para regresar al soporte.</a></b>');
		
	}elseif (isset($_GET['ticket'])) {

		$ticketid=intval(trim(($_GET['ticket'])));
		$account_id=$_SESSION['id'];

		if ($ticketid > 0 ) {
			$sql = "select * from soportes where (account_id=? and ticket=?);";
			$stmt = mysqli_stmt_init($conn);

			if (!mysqli_stmt_prepare($stmt, $sql)) {

				$_SESSION['err']='<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
				goto Errorazo;
			}else{
				mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

            if (!$rowSoporte = mysqli_fetch_assoc($result)) {
				$_SESSION['err']='<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';
				goto Errorazo;
			}
			
			$pjID = $rowSoporte['pj_id'];

			$valido='<p class="form-tit">El representante no ha dado como terminado este soporte.<br>Puede enviarle un mensaje completando el siguiente campo:</p><span class="textarea" style="margin-bottom:0px;"><textarea name="mensaje" id="mensaje" cols="35" rows="4" style="overflow:auto;"></textarea></span>
			<input id="Submit" type="button" onclick="enviarPost()" value="Enviar" class="enviar" style="border:0;float:right;">
			</div></td></tr>
			<tr><td><p class="form-tit">Si esta conforme con la respuesta <a href="#" onclick="enviarPost(true); return false;"> pulse aqui para cerrar el soporte.</a></p></td></tr>
			</tbody></table>
			</fieldset>';
 
			switch ($rowSoporte['estado']) {
				case '0':$estado="No Leido"; $estado2=$valido;break;
				case '1':$estado="Leido"; $estado2=$valido;break;
				case '2':$estado="Respondido"; $estado2=$valido;break;
				case '4':$estado="Reabierto"; $estado2=$valido;break;
				case '3':$estado="Cerrado"; $estado2='<fieldset>
				<table><tbody><tr><td><input type="hidden" name="r" id="r" value="1"><input id="Submit" type="button" onclick="document.forms[0].submit()" name="r" value="Reabrir" class="enviar" style="border:0;float:right;"></td>
				</tr></tbody></table>
				<b>El soporte está cerrado. Si quieres reabrirlo, presiona el boton "Reabrir".</b><br><br></fieldset>';break;
				default:$estado="Error"; $estado2="-";break;
			}

			switch ($rowSoporte['sector']) {
				case '2':$sector="Ban";break;
				case '7':$sector="Problema Técnico";break;
				case '9':$sector="Denuncia GMs";break;
				case '11':$sector="Robo de PJ/Estafa";break;
				case '15':$sector="Otro";break;
				case '16':$sector="Cuentas";break;
				case '17':$sector="Nick inapropiado";break;
				case '20':$sector="Denuncia de cheater";break;
				case '21':$sector="Foro";break;
				case '22':$sector="Quite T0 ingame";break;
				case '23':$sector="Discord";break;
				default:$sector="Normal";break;
			}
	
			$pjNick = $pjID;
			
			$mensajeOriginal=$rowSoporte['mensaje'];
			$print.='<div id="centro_panel"><div class="izq" style="width:500px;"><big style="margin-left:15px;"><big>Ticket Nº'. $rowSoporte['ticket'] .'</big></big><ul class="beneficios"><li><p><span style="float:left;">Asunto: <b>'.$rowSoporte['asunto'] .'</b></span><small style="float:right;">' .$rowSoporte['fecha_creacion'].'</small><br>Escrito por: <b>'.$pjNick.' ('.$_SESSION['username'].')</b><br>Estado: <b>'.$estado.'</b><br>Sector: <b>'.$sector.'</b><br><br>Mensaje original:<br>'.$mensajeOriginal.'</p></li>';
			
			$sql = "select * from soportes_comment where (ticketid=?);";
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {

				$_SESSION['err']='<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
				goto Errorazo;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

			if(mysqli_num_rows($result) > 0){
				while($row = mysqli_fetch_assoc($result)){
				//
					if (strcmp($_SESSION['username'],$row['replyfrom'])==0){$replyfrom="Usuario";$user=true;}
					else{$replyfrom="Staff";$user=false;}

					if ($user) {$print.='<li class="'.$replyfrom .'"'.'><b style="float:left;">' .$_SESSION['username'] .' (' .$replyfrom .')</b><small style="float:right;">' .$row['fecha'].'</small><br><p>'. $row['mensaje'].'</p></li>';}
					else{$print.='<li class="GameMaster"'.'><b style="float:left;">' .$row['replyfrom'] .' (' .$replyfrom .')</b><small style="float:right;">' .$row['fecha'].'</small><br><p>'. $row['mensaje'].'</p></li>';}
				//

				}
			}
			
			$print.='</ul><form name="soporte_tds" method="post" action="" id="cuentasPremium"><input type="hidden" name="ticket" value="' .$rowSoporte['ticket'] .'"> <input type="hidden" name="a" value="mis-soportes"><input type="hidden" name="cerrar" id="cerrar" value="">
				<fieldset><table><tbody><tr><td colspan="2"><div class="campos">'.$estado2;
			$print.='</div></td></tr></tbody></table></fieldset></form></div></div>';

		}
	}else {
		$print.='<form name="soporte_tds" method="post" onsubmit="return validarpremium()" action="#" id="cuentasPremium">
		<fieldset>
		<div class="campos">
		<p class="form-tit">Completá el formulario con información verdadera, a la brevedad será respondido.</p>
		<input type="hidden" name="a" value="soporte">
		<label for="nick">Nick del personaje:</label>
		<select name="nick" id="nick" style="color:#fff;background-color:#1c1c1c;border:1px solid #DBD4C0;">';

	$res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
	if($res) { //&& $res->num_rows === 1
		while ($pj = $res->fetch_assoc()) {
			echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
		}
	}

	$print.='<option value="0">Ninguno</option></select><div class="clear"></div>
	<label for="sector">Sector:</label>
	<select name="sector" id="sector" style="color:#fff;background-color:#1c1c1c;border:1px solid #DBD4C0;"><option value="">-</option> <option value="1">Bug</option>
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
	</form>';
	}

	printea:
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
	<script type="text/javascript" src="/scripts/tipo_soporte.js"></script>
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
<h1>Panel <?php   if(isset($_SESSION['username'])) echo ("de ".$_SESSION['username']); else echo ("soporte");  ?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><br>
<h1 align="center">Soporte premium - Mis tickets</h1>

<!-- 

 fgkerstkhkertthksertkh


-->

<?php 


echo $print; 
goto Cya;

Errorazo:
echo $_SESSION['err'];
unset($_SESSION['err']);
Cya:

?>

<?php //} ?>
</div>
</div>