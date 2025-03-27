<?php
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
	
	if(isset($_POST['usuario']) && isset($_POST['contrasena']) && isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
		$usuario = $_POST['usuario'];
		$password = $_POST['contrasena'];

		$C = connect();
		if($C) {
			
			$hourAgo = time() - 60*60;
			$res = sqlSelect($C, 'SELECT cuentas.*, password, verified, COUNT(loginattempts.id) 
                    FROM cuentas 
                    LEFT JOIN loginattempts ON cuentas.id = loginattempts.id AND timestamp > ? 
                    WHERE username = ? 
                    GROUP BY cuentas.id', 'is', $hourAgo, $usuario);
				
				if($res && $res->num_rows === 1) {

					$row = $res->fetch_assoc();

					if($row['COUNT(loginattempts.id)'] <= MAX_LOGIN_ATTEMPTS_PER_HOUR) {
						if($password === $row['password']) { //if(password_verify($password, $user['password'])) {
							
							session_unset();
							$_SESSION['id'] = $row['id'];
							$_SESSION['verified'] = $row['verified'];
							$_SESSION['password'] = $row['password'];
							$_SESSION['pin'] = $row['pin'];
							$_SESSION['id'] = $row['id'];
							$_SESSION['username'] = $row['username'];
							$_SESSION['email'] = $row['email'];
							$_SESSION['apodo'] = $row['apodo'];
							$_SESSION['first_name'] = $row['nombre'];
							$_SESSION['last_name'] = $row['apellido'];
							$_SESSION['banned'] = intval($row['banned']);
							$_SESSION['updated_at'] = $row['updated_at'];
							$_SESSION['last_login_at'] = $row['last_login_at'];
							$_SESSION['gm'] = $row['GM'] ;
							#$_SESSION['tdspesos'] = $row['tdspesos'] ;
							$_SESSION['oro'] = $row['oro'] ;
							$_SESSION['premium_at'] = date('d-m-Y h:i:s',strtotime($row['premium_at'])) ;

							sqlUpdate($C, 'DELETE FROM loginattempts WHERE user=?', 'i', $row['id']);

							if(!$row['verified']) {
								//echo 4;
							}

							echo 0;
						}
						else {
							$id = sqlInsert($C, 'INSERT INTO loginattempts VALUES (NULL, ?, ?, ?)', 'isi', $row['id'], $_SERVER['REMOTE_ADDR'], time());
							if($id !== -1) {
								echo 1;
							}
							else {
								echo 2;
							}
						}
					}
					else {
						echo 3;
					}

					
				$res->free_result();
			}
			else {
				echo 1;
			}
			$C->close();
		}
		else {
			echo 2;
		}
	}
	else {
		echo 1;
	}