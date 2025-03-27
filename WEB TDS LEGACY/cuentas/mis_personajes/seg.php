<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_logged();
$conn = connect();

    $_SESSION['last_action'] = time();
    if (!isset($_SESSION['last_action'])) {
        die('Aguarda un instante!');
    }

    if ($conn->connect_error) {
        die("Error de conexión: " . $conn->connect_error);
    }

   $tick=date_timestamp_get(date_create());

    // Preparar la consulta SQL
    $stmt = $conn->prepare("SELECT last_action, attempts FROM cuentas WHERE id = ?");
    if ($stmt === false) {
        die("Error en la preparación de la consulta: " . $conn->error);
    }
    $stmt = $conn->prepare("SELECT last_action, attempts FROM cuentas WHERE id = ?");
    $stmt->bind_param("i", $_SESSION['id']);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $ts1 = intval($row['last_action']);
    $ts2 = $tick;
    
    $attempts = intval($row['attempts']);
    $attempts++;
    $seconds_diff = $ts2 - $ts1;   

    if ($seconds_diff < 1) {
        echo("Aguarda un instante!");
        if ($attempts > 4) {
            // Spam behavior
            $stmt = $conn->prepare("UPDATE cuentas SET spam = spam + 1 WHERE id = ?");
            $stmt->bind_param("i", $_SESSION['id']);$stmt->execute();
            die();
        }
        $stmt = $conn->prepare("UPDATE cuentas SET attempts = attempts + 1, last_action = " . $tick . " WHERE id = ?");
        $stmt->bind_param("i", $_SESSION['id']);$stmt->execute();        
        die();
    }

    $stmt = $conn->prepare("UPDATE cuentas SET attempts = 0, last_action = " . $tick . " WHERE id = ?");
    
    $stmt->bind_param("i", $_SESSION['id']);$stmt->execute();

    $stmt = $conn->prepare("UPDATE cuentas SET spam = spam + 1 WHERE id = ?");
    $stmt->bind_param("i", $_SESSION['id']);$stmt->execute();

?>