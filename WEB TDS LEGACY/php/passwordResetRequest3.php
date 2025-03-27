<?php
	
	// recover pass ACCOUNT!! - aca ponemos la pw que quieremos
	$result="";
	$success=false;

	$errors = [];
	$errors[] = 0;
	
	if (isset($_POST['rid']) && isset($_POST['hash']) && isset($_POST['password']) && isset($_POST['password2']) && (!empty($_POST['csrf_token']))) {			 
		
		require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

		$errors = [];
		
		$id=trim($_POST['rid']);
		$hash=trim($_POST['hash']);
		$password=trim($_POST['password']);
		$password2=trim($_POST['password2']);
		
		if (empty($_POST['rid']) || empty($_POST['hash']) || empty($_POST['csrf_token']) || empty($password) || empty($password2)) {
			$errors[] = 13;
		}
		if(!preg_match('/^[a-zA-Z0-9\s]+$/', $password)) {
			$errors[] = 13;
		}
		if(strlen($password) > 255 || !strlen($password) > 2 || !preg_match('/^[a-zA-Z0-9- ]+$/', $password)) {
			$errors[] = 11; // invalid len or letters
		}	
		if($password2 !== $password) {
			$errors[] = 12; // password doesn't match
		}	
		if(count($errors) === 0) {
			if(isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
				$C = connect();
				if($C) {
					$res = sqlSelect($C, 'SELECT * FROM requests_account WHERE id=? AND TYPE=1 LIMIT 1', 'i', $id);
					if($res && $res->num_rows === 1) {
						$request = $res->fetch_assoc();
						
						if(password_verify(urlSafeDecode($hash), $request['hash'])) {// password_verify hash
							
							if($request['timestamp'] >= time() - PASSWORD_RESET_REQUEST_EXPIRY_TIME) {// check if request is expired
								$hash = $password;//password_hash($_POST['password'], PASSWORD_DEFAULT);
								
								$line = "|16|".$ip."|".$request['account_id']."|" .$request['email']."|" .$password ;
								$data ="";

												
								$server= bserver_getdata($line,$data);
							
								if (!$server) {
									$errors[] = 10;
									exit();
								}								
								
								if ($data == "") {
									$errors[] = 10;
								}else {
									if ($ret===0) {
										if(sqlUpdate($C, 'UPDATE cuentas SET password=? WHERE id=?', 'si', $hash, $request['account_id'])) {
											sqlUpdate($C, 'DELETE FROM requests_account WHERE account_id=? AND type=1', 'i', $request['account_id']);
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