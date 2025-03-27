<?php                   
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/sendValidationEmail.php'; 

    $C = connect();

    require_loggedandunverified();
    
    $oneDayAgo = time() - 60 * 60 * 24;
    $res = sqlSelect($C, 'SELECT 
                                c.id, 
                                c.username, 
                                c.verified, 
                                COUNT(r.id) AS request_count 
                            FROM 
                                cuentas c
                            LEFT JOIN 
                                requests r ON c.id = r.user 
                                        AND r.type = 1 
                                        AND r.timestamp > ? 
                            WHERE 
                                c.email = ? 
                            GROUP BY 
                                c.id, 
                                c.username, 
                                c.verified', 'si', $oneDayAgo, $_SESSION['email']);


    if($res && $res->num_rows === 1) {
        $user = $res->fetch_assoc();
         
        if($user['request_count'] < MAX_PASSWORD_RESET_REQUESTS_PER_DAY) {						

            $accountname = "";
            $stmt = mysqli_stmt_init($C);
            if (mysqli_stmt_prepare($stmt, "SELECT username FROM cuentas WHERE id=?;"))
            mysqli_stmt_bind_param($stmt, "s", $user['account_id']);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);            
            if ($acc = mysqli_fetch_assoc($result)) $accountname = $acc['username'];
            mysqli_stmt_close($stmt);

            $verifyCode = random_bytes(32);
            $saved=base64_encode($verifyCode);
            
            $insertID = sqlInsert($C, 'INSERT INTO requests VALUES (NULL, ?, ?, ?, ?, ?, 1)', 'isiss', $user['id'], $saved, time(),$_SESSION['username'], $_SESSION['email']);
            
            if($insertID !== -1) {
                
                $params = [
                    'id' => $insertID,
                    'code' => $saved,
                ];

                $url=VALIDATE_EMAIL_ENDPOINT . '&' . http_build_query($params);
                $msg='<head> <meta charset="iso-8859-1"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Verifica tu email</title> <style type="text/css"> body {width: 100%; background-color: #ffffff; margin: 0; margin-top: 70px; padding: 0; -webkit-font-smoothing: antialiased; } p, h1, h2, h3, h4 {margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; } span.preheader {display: none; font-size: 1px; } html {width: 100%; } table {font-size: 14px; border: 0; }  @media only screen and (max-width: 640px) { .main-header {font-size: 20px !important; } .main-section-header {font-size: 28px !important; } .show {display: block !important; } .hide {display: none !important; } .align-center {text-align: center !important; } .no-bg {background: none !important; } .main-image img {width: 440px !important; height: auto !important; }  .divider img {width: 440px !important; }  .container590 {width: 440px !important; } .container580 {width: 400px !important; } .main-button {width: 220px !important; }  .section-img img {width: 320px !important; height: auto !important; } .team-img img {width: 100% !important; height: auto !important; } } @media only screen and (max-width: 479px) { .main-header {font-size: 18px !important; } .main-section-header {font-size: 26px !important; } .divider img {width: 280px !important; } .container590 {width: 280px !important; } .container590 {width: 280px !important; } .container580 {width: 260px !important; }  .section-img img {width: 280px !important; height: auto !important; } } </style> </head> <body class="respond" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color"> <tr> <td align="center"> <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590"> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #343434; font-size: 24px; font-family: Quicksand, Calibri, sans-serif; font-weight:700;letter-spacing: 3px; line-height: 35px;"class="main-header"> <div style="line-height: 35px"> <span style="color: #5caad2;">TDS Legacy:</span> Hola '.$_SESSION['username'].'! Por favor activa tu cuenta </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="40" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee"> <tr> <td height="2" style="font-size: 2px; line-height: 2px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Por favor apreta el boton de abajo para verificar tu mail y activar la cuenta. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" align="center" width="160" cellpadding="0" cellspacing="0" bgcolor="5caad2"> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #ffffff; font-size: 14px; font-family: "Work Sans", Calibri, sans-serif; line-height: 26px;"> <div style="line-height: 26px;"> <a href="'.$url.'" style="color: #ffffff; text-decoration: none;">Verificar mail</a> </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Si el botón no funciona copia el link y pegalo en el navegador. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> '.$url.' </div> </td> </tr> </table> </td> </tr> </table> </td> </tr> <tr class="hide"> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td height="40" style="font-size: 40px; line-height: 40px;">&nbsp;</td> </tr> </table></body>';
                if(sendEmail($_SESSION['email'], $_SESSION['username'], 'Verifica tu email', $msg)) {
                    echo 'Email enviado correctamente, revise su casilla de correos.';
                } else {
                    echo 'Error al enviar el mail. Notifique al Admin.';
                }
            }
            else {							
                echo "No se pudo insertar en la base de datos.";return 2;//$errors[] = 2;// echo 'Failed to create request in database';
            }
        }
        else {						
            echo "Demasiadas peticiones en menos de 24 horas, intentelo luego.";return 3;//$errors[] = 3;// echo 'Too many requests in the last 24 hours... try again later';
        }
    }
    else {		
        
        $accountname = "";
        $stmt = mysqli_stmt_init($C);
        if (mysqli_stmt_prepare($stmt, "SELECT username FROM cuentas WHERE id=?;"))
        mysqli_stmt_bind_param($stmt, "s", $user['account_id']);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);            
        if ($acc = mysqli_fetch_assoc($result)) $accountname = $acc['username'];
        mysqli_stmt_close($stmt);

        $verifyCode = random_bytes(32);
        $saved=base64_encode($verifyCode);
        
        $insertID = sqlInsert($C, 'INSERT INTO requests VALUES (NULL, ?, ?, ?, ?, ?, 1)', 'isiss', $_SESSION['id'], $saved, time(),$_SESSION['username'], $_SESSION['email']);
        
        if($insertID !== -1) {
            
            $params = [
                'id' => $insertID,
                'code' => $saved,
            ];

            $url=VALIDATE_EMAIL_ENDPOINT . '&' . http_build_query($params);
            $msg='<head> <meta charset="iso-8859-1"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Verifica tu email</title> <style type="text/css"> body {width: 100%; background-color: #ffffff; margin: 0; margin-top: 70px; padding: 0; -webkit-font-smoothing: antialiased; } p, h1, h2, h3, h4 {margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; } span.preheader {display: none; font-size: 1px; } html {width: 100%; } table {font-size: 14px; border: 0; }  @media only screen and (max-width: 640px) { .main-header {font-size: 20px !important; } .main-section-header {font-size: 28px !important; } .show {display: block !important; } .hide {display: none !important; } .align-center {text-align: center !important; } .no-bg {background: none !important; } .main-image img {width: 440px !important; height: auto !important; }  .divider img {width: 440px !important; }  .container590 {width: 440px !important; } .container580 {width: 400px !important; } .main-button {width: 220px !important; }  .section-img img {width: 320px !important; height: auto !important; } .team-img img {width: 100% !important; height: auto !important; } } @media only screen and (max-width: 479px) { .main-header {font-size: 18px !important; } .main-section-header {font-size: 26px !important; } .divider img {width: 280px !important; } .container590 {width: 280px !important; } .container590 {width: 280px !important; } .container580 {width: 260px !important; }  .section-img img {width: 280px !important; height: auto !important; } } </style> </head> <body class="respond" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color"> <tr> <td align="center"> <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590"> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #343434; font-size: 24px; font-family: Quicksand, Calibri, sans-serif; font-weight:700;letter-spacing: 3px; line-height: 35px;"class="main-header"> <div style="line-height: 35px"> <span style="color: #5caad2;">TDS Legacy:</span> Hola '.$_SESSION['username'].'! Por favor activa tu cuenta </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="40" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee"> <tr> <td height="2" style="font-size: 2px; line-height: 2px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Por favor apreta el boton de abajo para verificar tu mail y activar la cuenta. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" align="center" width="160" cellpadding="0" cellspacing="0" bgcolor="5caad2"> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #ffffff; font-size: 14px; font-family: "Work Sans", Calibri, sans-serif; line-height: 26px;"> <div style="line-height: 26px;"> <a href="'.$url.'" style="color: #ffffff; text-decoration: none;">Verificar mail</a> </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Si el botón no funciona copia el link y pegalo en el navegador. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> '.$url.' </div> </td> </tr> </table> </td> </tr> </table> </td> </tr> <tr class="hide"> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td height="40" style="font-size: 40px; line-height: 40px;">&nbsp;</td> </tr> </table></body>';
            
            if(sendEmail($_SESSION['email'], $_SESSION['username'], 'Verifica tu email', $msg)) {
                echo 'Email enviado correctamente, revise su casilla de correos.';
            } else {
                echo 'Error al enviar el mail. Notifique al Admin.';
            }
        }
        else {							
            echo "No se pudo insertar en la base de datos.";return 2;//$errors[] = 2;// echo 'Failed to create request in database';
        }

        #echo "No existe ese email";return 0;//$errors[] = 0;// echo 'An email has been sent if an user with that email exists';
    }
    $C->close();
    

?> 