<?php
	
	// recover char - send mail

	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    $errors = [];

	if(!empty($_POST['email']) && !empty($_POST['nick'])) {
		if ($_POST['email'] == 'm@h.com') {
			echo 6;
			return 6;
		}
		
		if(!checkdnsrr(substr($_POST['email'], strpos($_POST['email'], '@') + 1), 'MX')) {
			echo 6;return 6;
		}

		if ($_POST['nick'] == 'Nick') {
			echo 9;return 9;
		}

		if(strlen($_POST['nick']) > 255 || !strlen($_POST['nick']) > 2 || !preg_match('/^[a-zA-Z- ]+$/', $_POST['nick'])) {
			echo 9;return 9;
		}
		$sql = "SELECT * FROM user WHERE (email=? AND nick=?) ;";

		if(!empty($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
			$C = connect();
			if($C) {
				$dayago = time() - 60 * 60 * 24;
				$res = sqlSelect($C, 'SELECT user.id, user.account_id, COUNT(requests.id) 
                      FROM user 
                      LEFT JOIN requests ON user.id = requests.user AND requests.type = 1 
                      WHERE user.email = ? AND user.nick = ? 
                      GROUP BY user.id', 'ss', $_POST['email'], $_POST['nick']);
				
				if($res && $res->num_rows === 1) {
					$user = $res->fetch_assoc();
					
					if($user['COUNT(requests.id)'] < MAX_PASSWORD_RESET_REQUESTS_PER_DAY) {						

						$accountname = "";
						$stmt = mysqli_stmt_init($conn);
						if (mysqli_stmt_prepare($stmt, "SELECT username FROM cuentas WHERE id=?;"))
						mysqli_stmt_bind_param($stmt, "s", $user['account_id']);
						mysqli_stmt_execute($stmt);
						$result = mysqli_stmt_get_result($stmt);            
						if ($acc = mysqli_fetch_assoc($result)) $accountname = $acc['username'];
						mysqli_stmt_close($stmt);

						$code = random_bytes(32);
						$hash = password_hash($code, PASSWORD_DEFAULT);
						$insertID = sqlInsert($C, 'INSERT INTO requests VALUES (NULL, ?, ?, ?, ?, ?, 1)', 'isiss', $user['id'], $hash, time(),$_POST['nick'], $_POST['email']);
						if($insertID !== -1) {
							
							$msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
							<div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$accountname.'!</strong></p><p>Has solicitado restablecer la contrase&ntilde;a de '. $_POST['nick'] .'. Si tu no pediste esto puedes ignorar este mensaje. <br />
											<br/>
											Para restablecer tu contrase&ntilde;a por favor visit&aacute; la siguiente p&aacute;gina: <br />
											<a href="'. RESET_PASSWORD_ENDPOINT . 'id=' . $insertID . '&hash=' . urlSafeEncode($code) .'">Haz click aqui para recuperar tu clave.</a><br/>
											<br/>
											Cuando visites esa p&aacute;gina tu contrase&ntilde;a se cambiar&aacute; y te enviaremos una nueva.</p>';
							
							if(sendEmail($_POST['email'], $accountname, 'Reseteo de contraseña', $msg)) {								
								echo 0;return 0;//$errors[] = 0;// echo 'An email has been sent if an user with that email exists';
							}
							else {								
								echo 1;return 1;//$errors[] = 1;// echo 'Failed to send email';
							}
						}
						else {							
							echo 2;return 2;//$errors[] = 2;// echo 'Failed to create request in database';
						}
					}
					else {						
						echo 3;return 3;//$errors[] = 3;// echo 'Too many requests in the last 24 hours... try again later';
					}
				}
				else {					
					echo 0;return 0;//$errors[] = 0;// echo 'An email has been sent if an user with that email exists';
				}
				$C->close();
			}
			else {				
				echo 4;return 4;//$errors[] = 4;// echo 'Failed to connect to database';
			}
		}
		else {			
			echo 5;return 5;//$errors[] = 5;// echo 'Invalid CSRF token';
		}
	}elseif (!empty($_POST['nick'])) { //////////////////////// PANEL PREM

		require_logged();

		if(strlen($_POST['nick']) > 255 || !strlen($_POST['nick']) > 2 || !preg_match('/^[a-zA-Z- ]+$/', $_POST['nick'])) {
			$errors[] = 9; // invalid len or letters
			echo json_encode($errors);
			return;
		}	


		$sql = "SELECT * FROM user WHERE (email=? AND nick=?) ;";
		 
		if(!empty($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
			$C = connect();
			if($C) {
				$dayago = time() - 60 * 60 * 24;
				$res = sqlSelect($C, 'SELECT user.id, user.account_id, COUNT(requests.id) 
                      FROM user 
                      LEFT JOIN requests ON user.id = requests.user AND requests.type = 1 
                      WHERE user.email = ? AND user.nick = ? 
                      GROUP BY user.id', 'ss', $_SESSION['email'], $_POST['nick']);
				
				if($res && $res->num_rows === 1) {
					$user = $res->fetch_assoc();
					
					if($user['COUNT(requests.id)'] < MAX_PASSWORD_RESET_REQUESTS_PER_DAY) {						

						$accountname = $_SESSION['username'];
						
						$code = random_bytes(32);
						$hash = password_hash($code, PASSWORD_DEFAULT);
						$insertID = sqlInsert($C, 'INSERT INTO requests VALUES (NULL, ?, ?, ?, ?, ?, 1)', 'isiss', $user['id'], $hash, time(),$_POST['nick'], $_SESSION['email']);
						if($insertID !== -1) {
							
							$msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
							<div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$accountname.'!</strong></p><p>Has solicitado restablecer la contrase&ntilde;a de '. $_POST['nick'] .'. Si tu no pediste esto puedes ignorar este mensaje. <br />
											<br/>
											Para restablecer tu contrase&ntilde;a por favor visit&aacute; la siguiente p&aacute;gina: <br />
											<a href="'. RESET_PASSWORD_ENDPOINT . 'id=' . $insertID . '&hash=' . urlSafeEncode($code) .'">Haz click aqui para recuperar tu clave.</a><br/>
											<br/>
											Cuando visites esa p&aacute;gina tu contrase&ntilde;a se cambiar&aacute; y te enviaremos una nueva.</p>';
							
							if(sendEmail($_SESSION['email'], $accountname, 'Reseteo de contraseña', $msg)) {								
								$errors[] = 0;// echo 'An email has been sent if an user with that email exists';
							}
							else {								
								$errors[] = 1;// echo 'Failed to send email';
							}
						}
						else {							
							$errors[] = 2;// echo 'Failed to create request in database';
						}
					}
					else {						
						$errors[] = 3;// echo 'Too many requests in the last 24 hours... try again later';
					}
				}
				else {					
					$errors[] = 0;// echo 'An email has been sent if an user with that email exists';
				}
				$C->close();
			}
			else {				
				$errors[] = 4;// echo 'Failed to connect to database';
			}
		}
		else {			
			$errors[] = 5;// echo 'Invalid CSRF token';
		}

	}
	else {		
		$errors[] = 6;// echo 'You must enter an email';
	}	

	echo json_encode($errors);