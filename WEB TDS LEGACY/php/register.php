<?php
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/sendValidationEmail.php'; 

	$errors = [];
	$errno="";
	$errstr="";
				
	if(!isset($_POST['username']) || strlen($_POST['username']) > 255 || strlen($_POST['username']) < 3 || !preg_match('/^[a-zA-Z0-9]+$/', $_POST['username'])) {
		$errors[] = 1;
	}	
	if(!isset($_POST['nombre']) || strlen($_POST['nombre']) > 255 || strlen($_POST['nombre']) < 3 || !preg_match('/^[a-zA-Z- ]+$/', $_POST['nombre'])) {
		$errors[] = 17;
	}	
	if(!isset($_POST['apellido']) || strlen($_POST['apellido']) > 255 || strlen($_POST['apellido']) < 3 || !preg_match('/^[a-zA-Z- ]+$/', $_POST['apellido'])) {
		$errors[] = 18;
	}	
	if(!isset($_POST['pin']) || strlen($_POST['pin']) > 255 || strlen($_POST['pin']) < 3 || !preg_match('/^[a-zA-Z0-9- ]+$/', $_POST['pin'])) {
		$errors[] = 19;
	}	
	if(!isset($_POST['email']) || strlen($_POST['email']) > 255 || !filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)) {
		$errors[] = 2;
	}
	else if(!checkdnsrr(substr($_POST['email'], strpos($_POST['email'], '@') + 1), 'MX')) {
		$errors[] = 3;
	}
	if (!isset($_POST['password'])) {
		$errors[] = 4;//"La contraseña es obligatoria";
	} else {
		$password = $_POST['password'];
    
		if (strlen($password) < 3) {
			$errors[] = 4;//"La contraseña debe tener al menos 6 caracteres";
		}

		if (!preg_match('/[a-z]/', $password)) {
	#		$errors[] = 4;//"La contraseña debe contener al menos una letra minúscula";
		}

		if (!preg_match('/[A-Z]/', $password)) {
		#	$errors[] = 4;//"La contraseña debe contener al menos una letra mayúscula";
		}

		if (!preg_match('/[0-9]/', $password)) {
		#	$errors[] = 4;//"La contraseña debe contener al menos un número";
		}
	}
	if (strlen($password) < 3) {
		$errors[] = 4;//"La contraseña debe tener al menos 6 caracteres";
	}
 	
	if(!isset($_POST['password2']) || $_POST['password2'] !== $_POST['password']) {
		$errors[] = 5;
	}
	if(!isset($_POST['password']) || strlen($_POST['password']) > 255 || strlen($_POST['password']) < 3) {
		$errors[] = 19;
	}	
	if(count($errors) === 0) {
		#if(isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
			
			if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}
						
			$C = connect();
			if($C) {				
				$res = sqlSelect($C, 'SELECT id FROM cuentas WHERE email=?', 's', $_POST['email']);
				if($res && $res->num_rows === 0) {
																
					$sql = "insert into cuentas(username, email, password, nombre, apellido, pin, created_at, premium_at,verified) values (?,?,?,?,?,?,NOW() ,now() - interval 55 second,1)";
					$stmt = mysqli_stmt_init($C);
					$id=-1;
					if (!mysqli_stmt_prepare($stmt, $sql)) {
						$errors[] = 6;
					} 
					else {

						mysqli_stmt_bind_param($stmt, "ssssss", $_POST['username'], $_POST['email'], $_POST['password'], $_POST['nombre'], $_POST['apellido'], $_POST['pin']);
						mysqli_stmt_execute($stmt);
						mysqli_stmt_store_result($stmt);
						$id = $stmt->insert_id;

						if($id !== -1) {
							$data="";
							$fields = [
								'username' => $_POST['username'],
								'ip' => $ip,
								'email' => $_POST['email'],
								'password' => $_POST['password'],
								'full_name' => $_POST['nombre'],
								'last_name' => $_POST['apellido'],
								'pin' => $_POST['pin'],
								'id' => $id,
							];							
							$line = "|8|{$fields['ip']}|{$fields['username']}|{$fields['password']}|{$fields['email']}|{$fields['pin']}|{$fields['id']}";			
							server_getdata($line,$data);
							if ($data == "0") {								
								$_SESSION['username'] = $_POST['username'];
								$_SESSION['email'] = $_POST['email'];
								$_SESSION['password'] = $_POST['password'];
								$_SESSION['pin']=$_POST['pin'];
								$_SESSION['auth'] = 'loggedin';
								$_SESSION['id'] = $id;
								$_SESSION['first_name'] = $_POST['nombre'];
								$_SESSION['last_name'] = $_POST['apellido'];
								$_SESSION['user_level'] = 0;
								$_SESSION['banned'] = 0;
								$_SESSION['ban_reason'] = "";
								$_SESSION['cantidadpjs']=0;
								$_SESSION['verified'] = 0;
								$_SESSION['created_at'] = time();
								$_SESSION['updated_at'] = time();
								$_SESSION['last_login_at'] = time();
								$_SESSION['gm'] = 0 ;
								$_SESSION['premium_at'] = time();								
								
								#sendValidationEmail($_POST['email']);

								$errors[] = 0;	
								
							}
						}else {
							$errors[] = 6;
						}
					}						
					$res->free_result();		
				}
				else {					
					$errors[] = 7;//This nick/email is already in use
				}
			}
			else {				
				$errors[] = 8;//Failed to connect to database
			}
		#}
		#else {			
			#$errors[] = 9;//Invalid CSRF Token
		#}
	}
	
	echo json_encode($errors);

	$log  = "IP= ".$_SERVER['REMOTE_ADDR'].' - UserName=' .$_POST['username'] . ' - Email='. $_POST['email'] . ' '.date("F j, Y, g:i a").PHP_EOL.
			json_encode($errors).PHP_EOL.
			"-------------------------".PHP_EOL;		
	file_put_contents('./logs/log_'.date("j.n.Y").'.log', $log, FILE_APPEND);
