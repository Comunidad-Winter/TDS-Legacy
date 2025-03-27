<?php
	
	// recover pass character - aca ponemos la pw que quieremos
	$result="";
	$success=false;

	$errors = [];
	$errors[] = 1;
	
	if (isset($_POST['rid']) && isset($_POST['hash']) && isset($_POST['password']) && isset($_POST['password2']) && (!empty($_POST['csrf_token']))) {			 
		
		require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

		$errors = [];
		
		$id=trim($_POST['rid']);
		$hash=trim($_POST['hash']);
		$password=trim($_POST['password']);
		$password2=trim($_POST['password2']);

		if (empty($id) || empty($hash) || empty($_POST['csrf_token']) || empty($password) || empty($password2)) {
			$errors[] = 1;
		}
		if(!preg_match('/^[a-zA-Z0-9\s]+$/', $password)) {
			$errors[] = 2;
		}
		if(strlen($password) > 255 || !strlen($password) > 3 || !preg_match('/^[a-zA-Z0-9- ]+$/', $password)) {
			$errors[] = 3; // invalid len or letters
		}	
		if($password2 !== $password) {
			$errors[] = 4; // password doesn't match
		}	
		if(count($errors) === 0) {
			if(isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
				$C = connect();
				if($C) {
					$res = sqlSelect($C, 'SELECT * FROM requests WHERE id=? AND TYPE=1 LIMIT 1', 'i', $id);
					if($res && $res->num_rows === 1) {
						$request = $res->fetch_assoc();
						
						if(password_verify(urlSafeDecode($hash), $request['hash'])) {// password_verify hash
							
							if($request['timestamp'] >= time() - PASSWORD_RESET_REQUEST_EXPIRY_TIME) {// check if request is expired
								$hash = $password;//password_hash($_POST['password'], PASSWORD_DEFAULT);
								
								$data="";
								$line = "|16|".$ip."|".$request['name']."|" .$request['email']."|" .$password;
								server_getdata($line,$data);

								if ($data == "") {
									$errors[] = 10;
								}else {
									if ($data===0) {
										if(sqlUpdate($C, 'UPDATE user SET password=? WHERE id=?', 'si', $hash, $request['user'])) {
											sqlUpdate($C, 'DELETE FROM requests WHERE user=? AND type=1', 'i', $request['user']);
											$errors[] = 0;
										}
										else {								
											$errors[] = 5;// $errors[] = 'Failed to update password';
										}
									}
									else {
										$errors[] = (int)$data; 	
									}
								}
							}
							else {							
								$errors[] = 6;// $errors[] = 'This reset request has expired';
							}
						}
						else {						
							$errors[] = 7;// $errors[] = 'Invalid password reset request';
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
				$errors[] = 9;// $errors[] = 'Invalid CSRF token';
			}
		}
	}else {
		die();
	}

	echo json_encode($errors);