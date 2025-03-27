<?php

    // Carga la biblioteca de SwiftMailer
    require_once $_SERVER['DOCUMENT_ROOT'].'/vendor/autoload.php';

    if (isset($_SESSION['email'])) {
        $email=$_SESSION['email'];
    }

    if (isset($_SESSION['username'])) {
        $username=$_SESSION['username'];
    }
    // Crea una nueva instancia de la clase Swift_SmtpTransport
        $transport = new Swift_SmtpTransport('smtp.ionos.es', 587, 'tls');
        $transport->setUsername('soporte@tdslegacy.com');
        $transport->setPassword('enL#L7ewae)LIC9B');
        $mailer = new Swift_Mailer($transport);
        $message = new Swift_Message();
    // instancia nueva

    $selector = bin2hex(random_bytes(8));
    $token = random_bytes(32);
    $url = "https://tdslegacy.com.ar/cuenta_activada.php?a=validar&s=" . $selector . "&v=" . bin2hex($token);
    $expires = 'DATE_ADD(NOW(), INTERVAL 1 HOUR)';

    $sql = "DELETE FROM auth_tokens WHERE user_email=? AND auth_type='account_verify';";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
   
        $_SESSION['ERRORS']['err'] = 'SQL ERROR';
        header("Location: /crea-cuenta-premium.php");
        exit();
    }
    else {
        mysqli_stmt_bind_param($stmt, "s", $email);
        mysqli_stmt_execute($stmt);
    }
    $sql = "INSERT INTO auth_tokens (user_email, auth_type, selector, token, expires_at) 
            VALUES (?, 'account_verify', ?, ?, " . $expires . ");";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {

        $_SESSION['ERRORS']['err'] = 'SQL ERROR';
        header("Location: /crea-cuenta-premium.php");
        exit();
    }
    else {
        
        $hashedToken = password_hash($token, PASSWORD_DEFAULT);
        mysqli_stmt_bind_param($stmt, "sss", $email, $selector, $hashedToken);
        mysqli_stmt_execute($stmt);
    }
    mysqli_stmt_close($stmt);
    mysqli_close($conn);

// Establece el asunto del mensaje
$message->setSubject('Valida tu cuenta');

// Obtenemos la IP del que solicita
if (!empty($_SERVER['HTTP_CLIENT_IP'])) {$ip = $_SERVER['HTTP_CLIENT_IP'];} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];} else {$ip = $_SERVER['REMOTE_ADDR'];}

$body='<head> <meta charset="iso-8859-1"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Verifica tu email</title> <style type="text/css"> body {width: 100%; background-color: #ffffff; margin: 0; margin-top: 70px; padding: 0; -webkit-font-smoothing: antialiased; } p, h1, h2, h3, h4 {margin-top: 0; margin-bottom: 0; padding-top: 0; padding-bottom: 0; } span.preheader {display: none; font-size: 1px; } html {width: 100%; } table {font-size: 14px; border: 0; }  @media only screen and (max-width: 640px) { .main-header {font-size: 20px !important; } .main-section-header {font-size: 28px !important; } .show {display: block !important; } .hide {display: none !important; } .align-center {text-align: center !important; } .no-bg {background: none !important; } .main-image img {width: 440px !important; height: auto !important; }  .divider img {width: 440px !important; }  .container590 {width: 440px !important; } .container580 {width: 400px !important; } .main-button {width: 220px !important; }  .section-img img {width: 320px !important; height: auto !important; } .team-img img {width: 100% !important; height: auto !important; } } @media only screen and (max-width: 479px) { .main-header {font-size: 18px !important; } .main-section-header {font-size: 26px !important; } .divider img {width: 280px !important; } .container590 {width: 280px !important; } .container590 {width: 280px !important; } .container580 {width: 260px !important; }  .section-img img {width: 280px !important; height: auto !important; } } </style> </head> <body class="respond" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> <table border="0" width="100%" cellpadding="0" cellspacing="0" bgcolor="ffffff" class="bg_color"> <tr> <td align="center"> <table border="0" align="center" width="590" cellpadding="0" cellspacing="0" class="container590"> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #343434; font-size: 24px; font-family: Quicksand, Calibri, sans-serif; font-weight:700;letter-spacing: 3px; line-height: 35px;"class="main-header"> <div style="line-height: 35px"> <span style="color: #5caad2;">TDS Legacy:</span> Hola '.$username.'! Por favor activa tu cuenta </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="40" align="center" cellpadding="0" cellspacing="0" bgcolor="eeeeee"> <tr> <td height="2" style="font-size: 2px; line-height: 2px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="20" style="font-size: 20px; line-height: 20px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Por favor apreta el boton de abajo para verificar tu mail y activar la cuenta. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" align="center" width="160" cellpadding="0" cellspacing="0" bgcolor="5caad2"> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> <tr> <td align="center" style="color: #ffffff; font-size: 14px; font-family: "Work Sans", Calibri, sans-serif; line-height: 26px;"> <div style="line-height: 26px;"> <a href="'.$url.'" style="color: #ffffff; text-decoration: none;">Verificar mail</a> </div> </td> </tr> <tr> <td height="10" style="font-size: 10px; line-height: 10px;">&nbsp;</td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> Si el botón no funciona copia el link y pegalo en el navegador. </div> </td> </tr> </table> </td> </tr> <tr> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td align="center"> <table border="0" width="400" align="center" cellpadding="0" cellspacing="0" class="container590"> <tr> <td align="center" style="color: #888888; font-size: 16px; font-family: "Work Sans", Calibri, sans-serif; line-height: 24px;"> <div style="line-height: 24px"> '.$url.' </div> </td> </tr> </table> </td> </tr> </table> </td> </tr> <tr class="hide"> <td height="25" style="font-size: 25px; line-height: 25px;">&nbsp;</td> </tr> <tr> <td height="40" style="font-size: 40px; line-height: 40px;">&nbsp;</td> </tr> </table> </body>';

// Establece el cuerpo del mensaje
$message->setBody($body,'text/html');

// Establece la dirección de correo electrónico del remitente
$message->setFrom('soporte@tdslegacy.com');


// Establece la dirección de correo electrónico del destinatario
$message->setTo($email);

// Envía el mensaje utilizando el mailer
//$result = $mailer->send($message);

// Si el envío falla, muestra un mensaje de error
if (isset($_SESSION['ERRORS']['err'])) {
    unset($_SESSION['ERRORS']['err']);
}
if (isset($_SESSION['STATUS'])) {
    unset($_SESSION['STATUS']);
}

try {
        $mailer->send($message);
        $_SESSION['STATUS']='¡¡La cuenta ha sido creada exitosamente!!. Para poder comenzar a utilizarla deberás ingresar al link que te hemos enviado a ' .$email;
    }
    catch (\Swift_TransportException $e) {
        $_SESSION['ERRORS']['err']=$e->getMessage();
        $result=0;
    }

header("Location: /crea-cuenta-premium.php");


?>