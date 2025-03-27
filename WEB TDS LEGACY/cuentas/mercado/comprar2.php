<?php

	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
	require_logged();
	$conn = connect();
	
	$codigo=generateRandomString(32);
	
    $cheque=substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(6/strlen($x)) )),1,15);

	$date=date('Y-m-j H-i-s', time());

	require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

	if (isset($_POST['passpriv']) && isset($_POST['pass']) && isset($_POST['aCambiar']) && isset($_POST['pjc']) && isset($_POST['comentario'])) {
		
		$passpriv=htmlspecialchars(trim($_POST['passpriv']));
		$pass=htmlspecialchars(trim($_POST['pass']));
		$aCambiar=htmlspecialchars(trim($_POST['aCambiar']));
		$pjssql=trim($_POST['aCambiar']);
		$pjc=htmlspecialchars(trim($_POST['pjc']));
		$comentario=htmlspecialchars(clear_string(trim($_POST['comentario'])));
		$multi=false;
		$tmplist="";
		$tmpstring="";

        $passpriv = $conn->real_escape_string($passpriv); 
        $pass = $conn->real_escape_string($pass); 
        $aCambiar = $conn->real_escape_string($aCambiar); 
        $comentario = $conn->real_escape_string($comentario); 
		if (strlen($comentario)>0) $comentario="El comprador te ha dejado un comentario: $comentario<br>";

		if (!isset($_SESSION['id'])) {
			echo 'Debes volver a loguear';
			exit();
		}		
		if (empty($pjc) || empty($aCambiar)){
			echo 'Empty data.';
			exit();
		}
		if (isset($_POST['oferta'])){ 
			$oferta=abs(intval($_POST['oferta']));
			if ($oferta > 20000000)$oferta=20000000;			
		}
		else $oferta=0;
		
		// si son varios pjs (si es premium solo pickeo al primero)
	    if (strpos($aCambiar,'-')>0) {
	        $nick=explode('-',$aCambiar,3);
	        
			$multi=true;
			$ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
			$seconds_diff = $ts2 - $ts1;
			 
			if ($seconds_diff <= 0) {
				$multi=false;
				$nick=$nick[0];
			}
			
	    }else $nick=trim($aCambiar);

		// Superó la cantidad de pjs maximos x cuenta
		$AccData = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);

		$tot=0;
		$nivel =array();
		$clase=array();

		// MI PJ/PJS BAN?
		if ($multi) {
			
			for ($i=0; $i < count($nick); $i++) { 
				
				$sql = "SELECT ban,logged,account_id,nivel,clase,raza FROM user WHERE nick=?;";
				$nick[$i]=clear_string($nick[$i]); //sanitizamos el nick acá directamente				
        		$nick[$i] = $conn->real_escape_string($nick[$i]);
		        $stmt = mysqli_stmt_init($conn);
		        if (!mysqli_stmt_prepare($stmt, $sql)) exit("sql error"); 
		        else {
		            mysqli_stmt_bind_param($stmt, "s", $nick[$i]);
		            mysqli_stmt_execute($stmt);
		            $result = mysqli_stmt_get_result($stmt);
		            $pjexiste=mysqli_num_rows($result);
		            if ($pjexiste>0) {
		            	while($rowpjs = mysqli_fetch_array($result)){
		            		if ($rowpjs['ban'] > 0 || $rowpjs['logged'] > 0 || $rowpjs['account_id'] != $_SESSION['id'] ){ 
								echo("Pj logueado o baneado o no te pertenece: " .$rowpjs['nick']);
								exit();
							}
							$nivel[]=$rowpjs['nivel'];
							$clase[]=$rowpjs['clase']; 
						}
					}
		            else{ 
						echo "PJ inexistente " . $nick[$i];
						exit();
					}
		        }
				 
			}
		}else{
			
			$sql = "SELECT * FROM user WHERE nick=?;";
			$nick=clear_string($nick);
        	$nick = $conn->real_escape_string($nick); 
	        $stmt = mysqli_stmt_init($conn);
	        if (!mysqli_stmt_prepare($stmt, $sql)){ 
				echo "sql error";
				exit(); 
			}
	        else {
	            mysqli_stmt_bind_param($stmt, "s", $nick);
	            mysqli_stmt_execute($stmt);
	            $result = mysqli_stmt_get_result($stmt);
	            $pjexiste=mysqli_num_rows($result);
	            if ($pjexiste>0) {
					$rowpjs = mysqli_fetch_array($result);
					$nivel[0]=$rowpjs['nivel'];
					$clase[0]=$rowpjs['clase'];
					
					if ($rowpjs['ban'] > 0 || $rowpjs['account_id'] != $_SESSION['id']){ 
						echo "El personaje que seleccionaste está baneado o no te pertenece: $nick";
						exit();
					}
				}				
	            else { 
					echo "PJ inexistente: $nick";
					exit();
				}
	        }
		}

		// Existe ese mao?
		$sql = "SELECT M.*, C.email, C.username FROM `mercado` AS M INNER JOIN cuentas AS C ON M.account_id=C.id WHERE M.pjs=?";
		 
    	$pjc = $conn->real_escape_string($pjc); 
		
        $stmt = mysqli_stmt_init($conn);
		
        if (!mysqli_stmt_prepare($stmt, $sql)) {
			echo "sql error";
			exit(); 
		}
        else { 
            mysqli_stmt_bind_param($stmt, "s", $pjc);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            $maoexiste=mysqli_num_rows($result);
            if ($maoexiste>0)
				$rowmao = mysqli_fetch_array($result);
            else {
				echo 'MAO Inexistente.';
				exit();
			}
        }

		if (!strcmp($passpriv,$rowmao['contrasena']) ==0) {
			echo("Contraseña del MAO incorrecta.");
			exit();
		}; 
		
		if($AccData && $AccData->num_rows === 15) {
			echo 'No podes tener más personajes';
			exit();
		}

		$vendedorEmail = ADMIN_EMAIL; #en caso de bug?

		// Obtenemos el email del vendedor por si se concreta la venta.
		$sql = "SELECT email, username FROM `cuentas` WHERE id=?";		 
    	$pjc = $conn->real_escape_string($pjc); 
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
			echo "no pude obtener el mail de la cuenta";
			exit(); 
		}
        else { 
            mysqli_stmt_bind_param($stmt, "i", $rowmao['account_id']);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            if (mysqli_num_rows($result)>0){
				$vendedorData = mysqli_fetch_array($result);
				$vendedorEmail = $vendedorData['email'];
            }
        }

		$data="";

		switch ($rowmao['tipo']) {
			case 1:
				if ($multi) exit("No puedes ofertar oro con muchos personajes!");
					 	
				$line = "|3|". $ip ."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'. $nick .'|'. $pjc .'|'. $rowmao['oro'] .'|'. $cheque;
		
				$server= bserver_getdata($line,$data);
            
				if (!$server) {
					echo "Server off";
					exit();
				}
				
				if ($data[0] == "|") {
										
					$nick=explode('-',$aCambiar,3);

					foreach ($nick as $n) {                            
						
						$sql = "UPDATE user SET is_locked_in_mao=0, mao_index=0, account_id=?, pin=?,password=?,email=? WHERE mao_index=?";
						$stmt = mysqli_stmt_init($conn);
						if (!mysqli_stmt_prepare($stmt, $sql)) {
							echo 'Error al actualizar los personajes. Reportar a los GM';
							exit();					
						} else {
							mysqli_stmt_bind_param($stmt, "isssi",$_SESSION['id'],$_SESSION['pin'], $_SESSION['password'], $_SESSION['email'],$rowmao['mao_index']);
							mysqli_stmt_execute($stmt);
						}
						#$conn->query("UPDATE user set is_locked_in_mao=0,mao_index=0,account_id='". $_SESSION['id'] ."', pin=". $_SESSION['pin'] .", password='". $_SESSION['password'] .", email=". $_SESSION['email'] ."  WHERE mao_index=".$rowmao['mao_index']);
					}

					echo "¡¡ Has comprado a $pjc!!<br>La contraseña de $pjc es la misma que la de tu cuenta!!";
					#$sql = "UPDATE cuentas SET oro=oro+? WHERE id=?";
					#$stmt = mysqli_stmt_init($conn);
					#if (!mysqli_stmt_prepare($stmt, $sql)) {
				#		echo 'SQL error::'.$stmt->error;
				#		error_log("Comprar2.php - Oro a la cuenta: " . $rowmao['account_id'] . " monto: " .$rowmao['oro'] . " -  SQL error::".$stmt->error, 0);							
				#	} else {
				#		mysqli_stmt_bind_param($stmt, "ii",$rowmao['oro'],$rowmao['account_id']);
				#		mysqli_stmt_execute($stmt);
				#	}
					
					$conn->query("DELETE FROM mercado WHERE mao_index=".$rowmao['mao_index']);

					# Email
					$mailstringComprador="<strong>Hola!</strong><br><br>Has comprado a ".$pjc." por ".$rowmao['oro']." monedas de oro.<br>Los datos de los personajes ahora coinciden con tu cuenta.";

					# Anuncio al comprador
					$texto="Has comprado a ".$pjc." por ".$rowmao['oro'] .' monedas de oro';
					$anun_type=5;

					$sql = "insert into anuncios(account_id, tipo,texto,fecha) values (?,?,?,?)";
					$stmt = mysqli_stmt_init($conn);			
					if (mysqli_stmt_prepare($stmt, $sql)) {
						mysqli_stmt_bind_param($stmt, "iiss", $_SESSION['id'],$anun_type,$texto,$date);
						mysqli_stmt_execute($stmt);
						$anun_id =$conn->insert_id;
					}

					# Anuncio al vendedor
					$mailstringVendedor="<strong>Hola!</strong><br><br>Has vendido a $pjc por ".$rowmao['oro']." monedas de oro.<br>$comentario<br>El oro ahora se encuentra en tu cuenta, para retirarlo ve a un banquero, clickealo y escribe el comando: /CHEQUE $cheque";
					$texto="Has vendido a ".$pjc." por ".$rowmao['oro'] .' monedas de oro';
					$anun_type=5;

					$sql = "insert into anuncios(account_id, tipo,texto,fecha) values (?,?,?,?)";
					$stmt = mysqli_stmt_init($conn);			
					if (mysqli_stmt_prepare($stmt, $sql)) {
						mysqli_stmt_bind_param($stmt, "iiss", $rowmao['account_id'],$anun_type,$texto,$date);
						mysqli_stmt_execute($stmt);
						$anun_id =$conn->insert_id;
					}

					sendEmail($_SESSION['email'], "MercadoAO", "Compra realizada de ".$pjc." por ".$rowmao['oro'] .' monedas de oro', $mailstringComprador);
					sendEmail($vendedorEmail, "MercadoAO", "Venta realizada de $pjc por ".$rowmao['oro'] .' monedas de oro', $mailstringVendedor);
					
					sendEmail(ADMIN_EMAIL, "MercadoAO", "Venta realizada de $pjc por ".$rowmao['oro'] .' monedas de oro', $mailstringVendedor);

					exit();

				}else{
					switch ($data) {
						case 1:
							echo 'No es tu cuenta';
							break;
						case 2:
							echo 'El personaje a comprar está baneado';
							break;
						case 3:
							echo 'Compra inexistente';
							break;
						case 4:
							echo 'Tu personaje no tiene el oro suficiente';
							break;
						case 5:
							echo 'Tu personaje debe estar en zona segura.';
							break;
						case 6:
							echo 'Tu personaje se encuentra en la cárcel.';
							break;
						case 7:
							echo 'Tu personaje se encuentra en un mapa inválido.';
							break;
						case 8:
							echo 'No podes comprar tu propio personaje!';
							break;
						default:
							echo "Error desconocido";
							break;						
					}
				}

				break;				

			case 2: ##### CAMBIO DE PERSONAJES
				
				// Obtenemos el email del vendedor por si se concreta la venta.
				$sql = "SELECT * FROM `mercado_ofertas` WHERE la_oferta=?";		 
				
				if ($multi) {
					
					$texto = "Propuesta: Te ofrecen a $aCambiar por " .$rowmao['pjs'];

					sort($nick);
					$aCambiar = implode("-", $nick);

					for ($i=0; $i < (count($nick)-1); $i++) { 
						
						$stmt = mysqli_stmt_init($conn);
						if (!mysqli_stmt_prepare($stmt, $sql)) {
							echo "No pude comprobar si existe la misma oferta.";
							exit(); 
						}
						else { 
							mysqli_stmt_bind_param($stmt, "s", $aCambiar);
							mysqli_stmt_execute($stmt);
							$result = mysqli_stmt_get_result($stmt);
							if (mysqli_num_rows($result)>0){
								echo 'Ya le has hecho ésta oferta!';
								exit();
							}
						}

						$tmplist.='<li><a href="' .TDS_URL. '/cpremium.php?a=mercado&s=e&p='.$nick[$i].'">'.$nick[$i]. '</a> ('.$clase[$i].' nivel <span style="color:red;">'.$nivel[$i].'</span>)</li>';
					}

				}else {
					
					$texto="Propuesta: Te ofrecen a ".$nick." por ".$rowmao['pjs'];

					$pjc = $conn->real_escape_string($nick); 
					$stmt = mysqli_stmt_init($conn);
					if (!mysqli_stmt_prepare($stmt, $sql)) {
						echo "No pude comprobar si existe la misma oferta.";
						exit(); 
					}
					else { 
						mysqli_stmt_bind_param($stmt, "s", $nick);
						mysqli_stmt_execute($stmt);
						$result = mysqli_stmt_get_result($stmt);
						if (mysqli_num_rows($result)>0){
							echo 'Ya le has hecho ésta oferta!';
							exit();
						}
					}
				}
				
				$anun_type=9;


				######################################

				$sql = "insert into mercado_ofertas(mao_index, account_id_offer,la_oferta,date,codigo) values (?,?,?,?,?)";
				$stmt = mysqli_stmt_init($conn);			
				if (mysqli_stmt_prepare($stmt, $sql)) {
					mysqli_stmt_bind_param($stmt, "iisss", $rowmao['mao_index'],$_SESSION['id'],$aCambiar,$date,$codigo);
					mysqli_stmt_execute($stmt);
					$offer_id =$conn->insert_id;
				}
				
				$sql = "insert into anuncios(account_id, tipo,texto,fecha,mao_anun) values (?,?,?,?,?)";
				$stmt = mysqli_stmt_init($conn);			
				if (mysqli_stmt_prepare($stmt, $sql)) {
					mysqli_stmt_bind_param($stmt, "iissi", $rowmao['account_id'],$anun_type,$texto,$date,$offer_id);
					mysqli_stmt_execute($stmt);
				}
				
				if ($multi) {
					$tmplist='<ul>';
					for ($i = 0; $i < (count($nick) - 1); $i++) { 
						$tmpstring .= $nick[$i] . ', ';                        
						$tmplist .= '<li><a href="' . TDS_URL . '/cpremium.php?a=mercado&s=e&p=' . $nick[$i] . '">' . $nick[$i] . '</a> (' . $clase[$i] . ' nivel <span style="color:red;">' . $nivel[$i] . '</span>)</li>';
					}
					
					$tmpstring = rtrim($tmpstring, ", ");
					$tmpstring .= ' y ' . $nick[count($nick) - 1];
					
					$tmplist .= '<li><a href="' . TDS_URL . '/cpremium.php?a=mercado&s=e&p=' . $nick[count($nick) - 1] . '">' . $nick[count($nick) - 1] . '</a> (' . $clase[count($nick) - 1] . ' nivel <span style="color:red;">' . $nivel[count($nick) - 1] . '</span>)</li></ul><br>';
					
					$mailstring = '<strong>Hola!</strong><br><br>' . $_SESSION['username'] . ' te ofrece los siguientes personajes:<br>' . $tmplist;	
				
				}else {
					$tmpstring=$nick;
					$mailstring='<strong>Hola!</strong><br><br>'.$_SESSION['username'] . ' te ofrece su personaje: <a href="' .TDS_URL. '/cpremium.php?a=mercado&s=e&p='.$nick.'">'.$nick. '</a> ('.$clase[0].' nivel <span style="color:red;">'.$nivel[0].'</span>) ';			
				
				}
				
				$mailstring.= 'a cambio de <strong>'.$pjc.'</strong>.<br><br>';
				
				if (strlen($comentario)> 0 && $rowmao['permitirComentarios']>0) {
					$mailstring.='El usuario dejó el siguiente comentario:<br><i>'.$comentario .'</i><br><br>';
				}
				$mailstring.='Haz click en cada personaje para ver sus estadísticas.<br><br>';
				$mailstring.='Si deseas aceptar el intercambio ingrese <a href="' .TDS_URL. '/cpremium.php?a=aceptar_cambio&n='.$offer_id.'&c='.$codigo.'">aquí</a>.<br><br>';
				$mailstring.='Si deseas rechazar el intercambio ingrese <a href="' .TDS_URL. '/cpremium.php?a=rechazar_cambio&n='.$offer_id.'&c='.$codigo.'">aquí</a>.<br><br>';
				$mailstring.='Ésta propuesta tiene una validez de 48 horas. Pasado éste tiempo la oferta será rechazada automaticamente.<br><br>';
				
				if (!sendEmail($rowmao['email'], $rowmao['username'], 'Propuesta de cambio de ' .$tmpstring .' por ' .$pjc, $mailstring)) {
					echo '<div id="panel-premium">Debido a una falla tecnica no se ha podido enviar el mail con el codigo. Por favor intente en otro momento.</div>';
					
					$sql = "DELETE FROM mercado_ofertas WHERE offer_id=?";
					$stmt = mysqli_stmt_init($conn);
					if (mysqli_stmt_prepare($stmt, $sql)) {
						mysqli_stmt_bind_param($stmt, "i", $offer_id);
						mysqli_stmt_execute($stmt);
					}
					
					exit();
				};
				echo '<span class="negrita">Se le ha enviado al vendedor tu ofrecimiento junto con tu comentario y las estadisticas de tu/s personaje/s. Ahora debes esperar la respuesta de él. Si te arrepentis podes cancelar la oferta ingresando a la seccion Quitar de la venta.</span>';

				break;
			default:
				exit('<span class="negrita">Se le ha enviado al vendedor tu ofrecimiento junto con tu comentario y las estadisticas de tu/s personaje/s. Ahora debes esperar la respuesta de él. Si te arrepentis podes cancelar la oferta ingresando a la seccion Quitar de la venta.</span>');
		}
	}
	