<?php

if ($_SERVER['HTTP_USER_AGENT'] !== "GrJiAb") {
    echo 'Bad gatway';
    exit();
}

require_once $_SERVER['DOCUMENT_ROOT'].'/DB/env.php';

// Conexión a la base de datos (reemplaza con tus credenciales)
$pdo = new PDO("mysql:host=".DB_HOST.";dbname=".DB_DATABASE, DB_USERNAME, DB_PASSWORD);

// Consulta para obtener los correos en la cola
$stmt = $pdo->query("SELECT * FROM email_queue");
$emails = $stmt->fetchAll(PDO::FETCH_ASSOC);

require_once $_SERVER['DOCUMENT_ROOT'].'/vendor/autoload.php';

$transport = new Swift_SmtpTransport(SMTP_HOST, SMTP_PORT, 'ssl');
$transport->setUsername(SMTP_USERNAME);
$transport->setPassword(SMTP_PASSWORD);
$mailer = new Swift_Mailer($transport);

foreach ($emails as $email) {
    $message = new Swift_Message();
    $message->setSubject($email['subject']);
    $message->setBody($email['message'], 'text/html');
    $message->setFrom(array(SMTP_USERNAME => APP_NAME));
    $message->setTo(array($email['to_email'] => $email['to_name']));

    try {
                
        $result = $mailer->send($message);
        if ($result) {
            $deleteStmt = $pdo->prepare("DELETE FROM email_queue WHERE id = ?");
            $deleteStmt->execute([$email['id']]);
            
            exit();

        }
    } catch (\Swift_TransportException $e) {
        echo "Error sending email: " . $e->getMessage();

        $fp = fopen('zzzz_emailerror.txt', 'a');
        fwrite($fp, date("Your date format").' ' .$e->getMessage());
        fclose($fp);


    }
}
