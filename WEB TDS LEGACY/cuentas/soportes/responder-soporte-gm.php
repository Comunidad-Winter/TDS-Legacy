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
            <div class='titulo_seccion'><h1>GM - Soportes</h1></div>
<div id="main">

<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;"> 
<div class="tit">
<h1>Panel <?php   if(isset($_SESSION['username'])) echo ("de ".$_SESSION['username']); else echo ("soporte");  ?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><br>
<h1 align="center">Responder Soporte</h1>

<?php
 
	if (isset($_POST['cerrar']) && isset($_POST['ticket'])) {
		
		if (!isset($_POST['ticket'])) die();
		$ticketid=intval($_POST['ticket']);
		if (!$ticketid>0) die();
		
		$account_id=$_SESSION['id'];

		$sql = "select * from soportes where ticket=?;";
 
		$stmt = mysqli_stmt_init($conn);
		if (!mysqli_stmt_prepare($stmt, $sql)) {
			$error='<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
			echo $error;
			exit;
		}else{
			mysqli_stmt_bind_param($stmt, "i",$ticketid);
			mysqli_stmt_execute($stmt);
		}
		$result = mysqli_stmt_get_result($stmt);
		if (!$rowSoporte = mysqli_fetch_assoc($result)) {
			echo '<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';;
			exit;
		}
		
		if ($_POST['cerrar'] =="S" || $_POST['cerrar'] =="s") {
			
			if ($rowSoporte['estado'] == 3) {
				echo'<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				die();
			}
			$sql = 'UPDATE soportes SET estado="3" where (account_id=? AND ticket=?);';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "ii", $account_id,$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			
			if (!$err) {			
				die('<b style="color:ff00ff;margin:10px;">Ticket cerrado!</b><br><a href="?a=mis-soportes&ticket=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ');
			}else
				die("Error");

		}elseif(isset($_POST['r']) || isset($_POST['R'])) {
			if ($rowSoporte['estado'] <> 3)
				die();

			$sql = 'UPDATE soportes SET estado="4" where ticket=?;';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			 
			if (!$err) {			
				die('<b style="color:ff00ff;margin:10px;">Ticket re-abierto!</b><br><a href="?a=responder-soporte-gm&ticket=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ');
			}else
				die("Error");
		}
		elseif (!isset($_POST['mensaje'])) {
			die("Te falta el mensaje");
		}
		$msj=html_entity_decode(trim($_POST['mensaje']));
		
		$msj = clear_string($msj);

		$userid=$_SESSION['username'];

		if (strlen($msj)>1500) {die("Mensaje muy largo");}
		elseif (strlen($msj)<2){die("Mensaje muy corto");}
		if (!isset($_POST['ticket'])) {die();}
		if (!intval($_POST['ticket']>0)) {die();}
		$ticketid=intval($_POST['ticket']);
		$mensaje = $conn->real_escape_string($msj); 
		$account_id=$_SESSION['id'];

		$sql = "insert into soportes_comment (ticketid, mensaje,replyfrom) VALUES (?,?,?);";
		$stmt = mysqli_stmt_init($conn);
		
		if (!mysqli_stmt_prepare($stmt, $sql)) {

			echo('<b style="color:ff00ff;margin:10px;">Hubo un error al responder el soporte.</b>');
			echo(mysqli_stmt_error($stmt));
			exit;
		}else{
			mysqli_stmt_bind_param($stmt, "iss", $ticketid,$mensaje,$userid);
			mysqli_stmt_execute($stmt);
		} 
 
		$commentid =$conn->insert_id;

		if ($commentid> 0 ){
			$sql = 'UPDATE soportes SET estado="2" where ticket=?;';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				$error='<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				echo $error;
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
		}

		echo('<b style="color:ff00ff;margin:10px;">Comentario creado. <br><a href="?a=responder-soporte-gm&ticket=' .$ticketid .'"> Pulse aqui para regresar al soporte.</a></b>');
		
	}elseif (isset($_GET['ticket'])) {

		$ticketid=intval(trim(($_GET['ticket'])));

		if ($ticketid > 0 ) {
			$sql = "select * from soportes INNER JOIN cuentas ON soportes.account_id = cuentas.id where ticket=?;";
			$stmt = mysqli_stmt_init($conn);

			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un errorsql al obtener el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

            if (!$rowSoporte = mysqli_fetch_assoc($result)) {
				echo '<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';
				exit;
			}
			
			$pjID = $rowSoporte['pj_id'];

			$valido='<p class="form-tit">El soporte sigue abierto.<br>Puede enviarle un mensaje completando el siguiente campo:</p><span class="textarea" style="margin-bottom:0px;"><textarea name="mensaje" id="mensaje" cols="35" rows="4" style="overflow:auto;"></textarea></span>
			<input id="Submit" type="button" onclick="enviarPost()" value="Responder" class="enviar" style="border:0;float:right;">
			</div></td></tr>
			
			</tbody></table>
			</fieldset>';
			
 
			switch ($rowSoporte['estado']) {
				case '0':$estado="No Leido"; $estado2=$valido;break;
				case '1':$estado="Leido"; $estado2=$valido;break;
				case '2':$estado="Respondido"; $estado2=$valido;break;
				case '4':$estado="Reabierto"; $estado2=$valido;break;
				case '3':$estado="Cerrado"; $estado2='<p class="form-tit">- SOPORTE CERRADO POR EL USUARIO -</p>';break;
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
	
			$pjNick = (strlen($pjID)>0) ? $pjID : 'Ninguno' ;
			
			$fecha_actual = date('Y-m-d H:i:s');
			$timestamp_actual = strtotime($fecha_actual);
			$fecha='';
			$timestamp_final = strtotime($rowSoporte['fecha_creacion']);
			$diferencia = $timestamp_actual - $timestamp_final;
			$dias = $diferencia / 86400;
			$dias = floor($dias);
			if ($dias >= 2) {
				$fecha= "Hace $dias días";
			} elseif ($dias == 1) {
				$fecha= "Ayer";
			} elseif ($dias == 0) {
				$fecha= "Hoy";
			}else
				$fecha=$dias;			
			$fecha = '<abbr style="text-decoration: none;" title="' . $rowSoporte['fecha_creacion'] .  '">' . $fecha . '</abbr>';
			
			$mensajeOriginal=$rowSoporte['mensaje'];
			// Éste mensaje contiene informacion sensible. Por seguridad no es visible desde aqui. Si lo es para el equipo de Soporte que verá y contestará tu mensaje.
			echo('<div id="centro_panel"><div class="izq" style="width:500px;"><big style="margin-left:15px;"><big>Ticket Nº'. $rowSoporte['ticket'] .'</big></big><ul class="beneficios"><li><p><span style="float:left;">Asunto: <b>'.$rowSoporte['asunto'] .'</b></span><small style="float:right;">' .$fecha.'</small><br>Escrito por: <b>'.$pjNick.' ('.$rowSoporte['username'].')</b><br>Estado: <b>'.$estado.'</b><br>Sector: <b>'.$sector.'</b><br><br>Mensaje original:<br>'.$mensajeOriginal.'</p></li>');
			
			$sql = "select * from soportes_comment where (ticketid=?);";
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

			if(mysqli_num_rows($result) > 0){
				while($row = mysqli_fetch_assoc($result)){
				//
					if (strcmp($rowSoporte['username'],$row['replyfrom'])==0){$replyfrom="Usuario";$user=true;}
					else{$replyfrom="Staff";$user=false;}
					
					$timestamp_final = strtotime($row['fecha']);
					$diferencia = $timestamp_actual - $timestamp_final;
					$dias = $diferencia / 86400;
					$dias = floor($dias);
					if ($dias >= 2) {
						$fecha= "Hace $dias días";
					} elseif ($dias == 1) {
						$fecha= "Ayer";
					} elseif ($dias == 0) {
						$fecha= "Hoy";
					}else
						$fecha=$dias;			
					$fecha = '<abbr style="text-decoration: none;" title="' . $row['fecha'] .  '">' . $fecha . '</abbr>';

					if ($user) {echo('<li class="'.$replyfrom .'"'.'><b style="float:left;">' .$rowSoporte['username'] .' (' .$replyfrom .')</b><small style="float:right;">' .$fecha.'</small><br><p>'. $row['mensaje'].'</p></li>');}
					else{echo('<li class="GameMaster"'.'><b style="float:left;">' .$row['replyfrom'] .' (' .$replyfrom .')</b><small style="float:right;">' .$fecha.'</small><br><p>'. $row['mensaje'].'</p></li>');}

				}
			}
			 
			echo('</ul><form name="soporte_tds" method="post" action="" id="cuentasPremium"><input type="hidden" name="ticket" value="' .$rowSoporte['ticket'] .'"> <input type="hidden" name="a" value="mis-soportes"><input type="hidden" name="cerrar" id="cerrar" value="">
				<fieldset><table><tbody><tr><td colspan="2"><div class="campos">'.$estado2);
			echo('</div></td></tr></tbody></table></fieldset></form></div></div>');

		}
	}




	//////////////////////////////////


	if (isset($_POST['cerrar']) && isset($_POST['ticket2'])) {
		
		$ticketid=intval($_POST['ticket2']);
		if (!$ticketid>0) die();
		
		$account_id=$_SESSION['id'];

		$sql = "select * from soportes2 where ticket=?;";
 
		$stmt = mysqli_stmt_init($conn);
		if (!mysqli_stmt_prepare($stmt, $sql)) {
			$error='<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
			echo $error;
			exit;
		}else{
			mysqli_stmt_bind_param($stmt, "i",$ticketid);
			mysqli_stmt_execute($stmt);
		}
		$result = mysqli_stmt_get_result($stmt);
		if (!$rowSoporte = mysqli_fetch_assoc($result)) {
			echo '<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';;
			exit;
		}
		
		if ($_POST['cerrar'] =="S" || $_POST['cerrar'] =="s") {
			
			if ($rowSoporte['estado'] == 3) {
				echo'<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				die();
			}
			$sql = 'UPDATE soportes2 SET estado="3" where ticket=?);';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al cerrar el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			
			if (!$err) {			
				die('<b style="color:ff00ff;margin:10px;">Ticket cerrado!</b><br><a href="?a=mis-soportes&ticket2=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ');
			}else
				die("Error");

		}elseif(isset($_POST['r']) || isset($_POST['R'])) {
			if ($rowSoporte['estado'] <> 3)
				die();

			$sql = 'UPDATE soportes2 SET estado="4" where ticket=?;';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
			 
			if (!$err) {			
				die('<b style="color:ff00ff;margin:10px;">Ticket re-abierto!</b><br><a href="?a=responder-soporte-gm&ticket2=' .$ticketid . '"> Pulse aqui para regresar al soporte.</a> ');
			}else
				die("Error");
		}
		elseif (!isset($_POST['mensaje'])) {
			die("Te falta el mensaje");
		}
				
		$msj=html_entity_decode(trim($_POST['mensaje']));	
		$msj = filter_var($msj, FILTER_SANITIZE_STRING);
		
		$msj = clear_string($msj);

		$userid=$_SESSION['username'];

		if (strlen($msj)>600) {die("Mensaje muy largo");}
		elseif (strlen($msj)<2){die("Mensaje muy corto");}
		if (!isset($_POST['ticket2'])) {die();}
		if (!intval($_POST['ticket2']>0)) {die();}
		$ticketid=intval($_POST['ticket2']);
		$mensaje = $conn->real_escape_string($msj);

		$sql = "insert into soportes_comment2 (ticketid, mensaje,replyfrom) VALUES (?,?,?);";
		$stmt = mysqli_stmt_init($conn);
		
		if (!mysqli_stmt_prepare($stmt, $sql)) {

			echo('<b style="color:ff00ff;margin:10px;">Hubo un error al responder el soporte.</b>');
			echo(mysqli_stmt_error($stmt));
			exit;
		}else{
			mysqli_stmt_bind_param($stmt, "iss", $ticketid,$mensaje,$userid);
			mysqli_stmt_execute($stmt);
		} 
 
		$commentid =$conn->insert_id;

		if ($commentid> 0 ){
			$sql = 'UPDATE soportes2 SET estado="2" where ticket=?;';
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				$error='<b style="color:ff00ff;margin:10px;">Hubo un error al re-abrir el ticket.</b>';
				echo $error;
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			} 
			$err=mysqli_stmt_error($stmt);
		}

		echo('<b style="color:ff00ff;margin:10px;">Comentario creado. <br><a href="?a=responder-soporte-gm&ticket2=' .$ticketid .'"> Pulse aqui para regresar al soporte.</a></b>');
		
	}elseif (isset($_GET['ticket2'])) {

		$ticketid=intval(trim(($_GET['ticket2'])));

		if ($ticketid > 0 ) {
			$sql = "select * from soportes2 where ticket=?;";
			$stmt = mysqli_stmt_init($conn);

			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un errorsql al obtener el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

            if (!$rowSoporte = mysqli_fetch_assoc($result)) {
				echo '<b style="color:ff00ff;margin:10px;">No existe el ticket '.  $ticketid .'.</b>';
				exit;
			}
			
			$pjNick = $rowSoporte['nick'];

			$valido='<p class="form-tit">El soporte sigue abierto.<br>Puede enviarle un mensaje completando el siguiente campo:</p><span class="textarea" style="margin-bottom:0px;"><textarea name="mensaje" id="mensaje" cols="35" rows="4" style="overflow:auto;"></textarea></span>
			<input id="Submit" type="button" onclick="enviarPost()" value="Responder" class="enviar" style="border:0;float:right;">
			</div></td></tr>
			
			</tbody></table>
			</fieldset>';
			 
			switch ($rowSoporte['estado']) {
				case '0':$estado="No Leido"; $estado2=$valido;break;
				case '1':$estado="Leido"; $estado2=$valido;break;
				case '2':$estado="Respondido"; $estado2=$valido;break;
				case '4':$estado="Reabierto"; $estado2=$valido;break;
				case '3':$estado="Cerrado"; $estado2='<p class="form-tit">- SOPORTE CERRADO POR EL USUARIO -</p>';break;
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
	
			
			$fecha_actual = date('Y-m-d H:i:s');
			$timestamp_actual = strtotime($fecha_actual);
			$fecha='';
			$timestamp_final = strtotime($rowSoporte['fecha_creacion']);
			$diferencia = $timestamp_actual - $timestamp_final;
			$dias = $diferencia / 86400;
			$dias = floor($dias);
			if ($dias >= 2) {
				$fecha= "Hace $dias días";
			} elseif ($dias == 1) {
				$fecha= "Ayer";
			} elseif ($dias == 0) {
				$fecha= "Hoy";
			}else
				$fecha=$dias;			
			$fecha = '<abbr style="text-decoration: none;" title="' . $rowSoporte['fecha_creacion'] .  '">' . $fecha . '</abbr>';
			
			$mensajeOriginal=$rowSoporte['mensaje'];
			// Éste mensaje contiene informacion sensible. Por seguridad no es visible desde aqui. Si lo es para el equipo de Soporte que verá y contestará tu mensaje.			
			echo('<div id="centro_panel"><div class="izq" style="width:500px;"><big style="margin-left:15px;"><big>Ticket Nº'. $rowSoporte['ticket'] .'</big></big><ul class="beneficios"><li><p><span style="float:left;">Asunto: <b>'.$rowSoporte['asunto'] .'</b></span><small style="float:right;">' .$fecha.'</small><br>Escrito por: <b>'.$rowSoporte['nombre'].' (PJ afectado: '.$rowSoporte['nick'].')</b><br>Estado: <b>'.$estado.'</b><br>Sector: <b>'.$sector.'</b><br><br>Mensaje original:<br>'.$mensajeOriginal.'</p></li>');
			
			$sql = "select * from soportes_comment2 where (ticketid=?);";
			$stmt = mysqli_stmt_init($conn);
			if (!mysqli_stmt_prepare($stmt, $sql)) {
				echo '<b style="color:ff00ff;margin:10px;">Hubo un error al obtener el ticket.</b>';
				exit;
			}else{
				mysqli_stmt_bind_param($stmt, "i",$ticketid);
				mysqli_stmt_execute($stmt);
			}

			$result = mysqli_stmt_get_result($stmt);

			if(mysqli_num_rows($result) > 0){
				while($row = mysqli_fetch_assoc($result)){
				//
					if (strcmp($rowSoporte['nombre'],$row['replyfrom'])==0){$replyfrom="Usuario";$user=true;}
					else{$replyfrom="Staff";$user=false;}
					
					$timestamp_final = strtotime($row['fecha']);
					$diferencia = $timestamp_actual - $timestamp_final;
					$dias = $diferencia / 86400;
					$dias = floor($dias);
					if ($dias >= 2) {
						$fecha= "Hace $dias días";
					} elseif ($dias == 1) {
						$fecha= "Ayer";
					} elseif ($dias == 0) {
						$fecha= "Hoy";
					}else
						$fecha=$dias;			
					$fecha = '<abbr style="text-decoration: none;" title="' . $row['fecha'] .  '">' . $fecha . '</abbr>';

					if ($user) {echo('<li class="'.$replyfrom .'"'.'><b style="float:left;">' .$rowSoporte['nombre'] .' (' .$replyfrom .')</b><small style="float:right;">' .$fecha.'</small><br><p>'. $row['mensaje'].'</p></li>');}
					else{echo('<li class="GameMaster"'.'><b style="float:left;">' .$row['replyfrom'] .' (' .$replyfrom .')</b><small style="float:right;">' .$fecha.'</small><br><p>'. $row['mensaje'].'</p></li>');}

				}
			}
			 
			echo('</ul><form name="soporte_tds" method="post" action="" id="cuentasPremium"><input type="hidden" name="ticket2" value="' .$rowSoporte['ticket'] .'"> <input type="hidden" name="a" value="mis-soportes"><input type="hidden" name="cerrar" id="cerrar" value="">
				<fieldset><table><tbody><tr><td colspan="2"><div class="campos">'.$estado2);
			echo('</div></td></tr></tbody></table></fieldset></form></div></div>');

		}
	}
	
	?>
</div>
</div>