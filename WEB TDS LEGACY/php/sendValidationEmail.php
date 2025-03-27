<?php
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    //check_logged_in_butnot_verified();

	function sendValidationEmail($email) {
		$C = connect();

		if($C) {
			$oneDayAgo = time() - 60 * 60 * 24;
			$res = sqlSelect($C, 'SELECT cuentas.id, username, verified, COUNT(requests.id) FROM cuentas LEFT JOIN requests ON cuentas.id = requests.user AND type=0 AND timestamp>? WHERE cuentas.email=? GROUP BY cuentas.id', 'is', $oneDayAgo, $email);

			if($res && $res->num_rows === 1) {
				$user = $res->fetch_assoc();

				if($user['verified'] === 0) {

					if($user['COUNT(requests.id)'] <= MAX_EMAIL_VERIFICATION_REQUESTS_PER_DAY) {
						
						$verifyCode = random_bytes(32);
						$hash = password_hash($verifyCode, PASSWORD_DEFAULT);

						$requestID = -1;#sqlInsert($C, 'INSERT INTO requests VALUES (NULL, ?, ?, ?, 0)', 'isi', $user['id'], $hash, time());
						$now=time();

						$sql = "INSERT INTO requests(user,hash,timestamp) VALUES (?, ?,?)";
						$stmt = mysqli_stmt_init($C);
						if (mysqli_stmt_prepare($stmt, $sql)) {
							mysqli_stmt_bind_param($stmt, "iss", $user['id'], $hash,$now);
							mysqli_stmt_execute($stmt);
							mysqli_stmt_store_result($stmt);
							$requestID = $stmt->insert_id;							
						}else {
							echo 'no pudew insertar';
						}
							
						if($requestID !== -1) {
							
							$url=VALIDATE_EMAIL_ENDPOINT . '/' . $requestID . '/' . urlSafeEncode($verifyCode);

							$username=$user['username'];
							$msg='<head> <meta charset="iso-8859-1"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Verifica tu email</title> <style type="text/css"> body {width: 100%; background-color: #ffffff; margin: 0; margin-top: 70px; padding: 0; -webkit-font-smoothing: antialiased; } p, h1, h2, h3, h4 {margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; } span.preheader {display: none; font-size: 1px; } html {width: 100%; } table {font-size: 14px; border: 0; }  @media only screen and (max-width: 640px) { .main-header {font-size: 20px !important; } .main-section-header {font-size: 28px !important; } .show {display: block !important; } .hide {display: none !important; } .align-center {text-align: center !important; } .no-bg {background: none !important; } .main-image img {width: 440px !important; height: auto !important; }  .divider img {width: 440px !important; }  .container590 {width: 440px !important; } .container580 {width: 400px !important; } .main-button {width: 220px !important; }  .section-img img {width: 320px !important; height: auto !important; } .team-img img {width: 100% !important; height: auto !important; } } @media only screen and (max-width: 479px) { .main-header {font-size: 18px !important; } .main-section-header {font-size: 26px !important; } .divider img {width: 280px !important; } .container590 {width: 280px !important; } .container590 {width: 280px !important; } .container580 {width: 260px !important; }  .section-img img {width: 280px !important; height: auto !important; } } </style> </head> <body class="respond" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color"> <tr> <td align="center"> <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590"> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #343434; font-size: 24px; font-family: Quicksand, Calibri, sans-serif; font-weight:700;letter-spacing: 3px; line-height: 35px;"class="main-header"> <div style="line-height: 35px"> <span style="color: #5caad2;">TDS Legacy:</span> Hola '.$username.'! Por favor activa tu cuenta </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="40" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee"> <tr> <td height="2" style="font-size: 2px; line-height: 2px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Por favor apreta el boton de abajo para verificar tu mail y activar la cuenta. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" align="center" width="160" cellpadding="0" cellspacing="0" bgcolor="5caad2"> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #ffffff; font-size: 14px; font-family: "Work Sans", Calibri, sans-serif; line-height: 26px;"> <div style="line-height: 26px;"> <a href="'.$url.'" style="color: #ffffff; text-decoration: none;">Verificar mail</a> </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Si el botón no funciona copia el link y pegalo en el navegador. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> '.$url.' </div> </td> </tr> </table> </td> </tr> </table> </td> </tr> <tr class="hide"> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td height="40" style="font-size: 40px; line-height: 40px;">&nbsp;</td> </tr> </table></body>';
							
							if(sendEmail($email, $user['username'], 'Verifica tu email', $msg,false)) {
								#echo 'email sent.';return 0;
							}
							else {								
								echo 'email not sent.';return 1;// return 'failed to send email';
							}
						}
						else {							
							echo 'failed to insert request';return 2;// return 'failed to insert request';
						}
					}
					else {
						echo 'muchas requuest.';return 3;
					}
				}
				else {
					#echo 'ya validaste tu mail bobo.';return 4;
				}
				#$res->free_result();
			}
			else {
				echo 'no encontré nada en db. ';return 5;
			}
			#$C->close();
		}
		else {
			echo 'no me deja conectarme a la base de datos panflin';return 6;
		}
		#return -1;
	}
	