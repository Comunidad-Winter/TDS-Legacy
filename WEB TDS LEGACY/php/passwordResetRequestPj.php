<?php
	 
	$result="";
	$success=false;

	$errors = [];
	$errors[] = 0;
	
	if (isset($_POST['rid']) && isset($_POST['hash'])) {			 
		
		require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

		$errors = [];
		
		$id=trim($_POST['rid']);
		$hash=trim($_POST['hash']); 
		
		if (empty($_POST['rid']) || empty($_POST['hash']) ) {
			$errors[] = 13;
		}
		
		if(count($errors) === 0) {
			if(isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
				$C = connect();
				if($C) {
					$res = sqlSelect($C, 'SELECT * FROM requests WHERE id=? LIMIT 1', 'i', $id);
					if($res && $res->num_rows === 1) {
						$request = $res->fetch_assoc();
						
						if(password_verify(urlSafeDecode($hash), $request['hash'])) {// password_verify hash
							
							if($request['timestamp'] >= time() - PASSWORD_RESET_REQUEST_EXPIRY_TIME) {// check if request is expired
								
								
								$palabras = file($_SERVER['DOCUMENT_ROOT'] .'/php/words.txt', FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

								// Función para eliminar acentos y caracteres especiales
								function limpiarPalabra($palabra) {
									$limpia = str_replace(
										array('á', 'é', 'í', 'ó', 'ú', 'ñ', 'Á', 'É', 'Í', 'Ó', 'Ú', 'Ñ'),
										array('a', 'e', 'i', 'o', 'u', 'n', 'A', 'E', 'I', 'O', 'U', 'N'),
										$palabra
									);
									return preg_replace('/[^a-zA-Z]/', '', $limpia);
								}

								// Filtra palabras limpias
								$palabrasLimpias = array_map('limpiarPalabra', $palabras);
								$palabrasLimpias = array_filter($palabrasLimpias);

								// Selecciona dos palabras aleatorias
								$palabrasAleatorias = array_rand($palabrasLimpias, 2);

								// Convierte a mayúsculas
								$palabra1 = strtoupper($palabrasLimpias[$palabrasAleatorias[0]]);
								$palabra2 = strtoupper($palabrasLimpias[$palabrasAleatorias[1]]);

								// Muestra las palabras generadas
								$password= $palabra1 . ' ' . $palabra2;
								
								
								$hash = $password;//password_hash($_POST['password'], PASSWORD_DEFAULT);
								
								$line = "|15|".$ip."|".$request['name']."|" .$request['email']."|" .$password ;
								$data ="";

								server_getdata($line,$data);
								
								if ($data == "") {
									$errors[] = 10;
								}else {
									if ($ret===0) {
										if(sqlUpdate($C, 'UPDATE user SET password=? WHERE name=?', 'ss', $password, $request['name'])) {
											sqlUpdate($C, 'DELETE FROM requests WHERE id=?', 'i', $request['id']);
											$errors[] = 0;
										}
										else {								
											$errors[] = 6;// $errors[] = 'Failed to update password';
										}
									}
									else {
										$errors[] = (int)$ret; 	
									}	
								}
							}
							else {							
								$errors[] = 7;// $errors[] = 'This reset request has expired';
							}
						}
						else {						
							$errors[] = 9;// $errors[] = 'Invalid password reset request';
						}

						$res->free_result();
					}
					else {					
						$errors[] = 7;// $errors[] = 'Invalid password reset request';
					}
					$C->close();
				}
				else {				
					$errors[] = 8;// $errors[] = 'Failed to connect to database';
				}
			}
			else {			
				$errors[] = 8;// $errors[] = 'Invalid CSRF token';
			}
		}
	}else {
		die();
	}

	echo json_encode($errors);