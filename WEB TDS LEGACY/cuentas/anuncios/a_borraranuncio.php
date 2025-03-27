<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

require_logged();

$conn = connect();

require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

    if (!isset($_SESSION['banned'])) {exit(0);} 

    $id=0;
    $id = intval($_GET['borrara']);
    if ($id <= 0) {
        exit();
    }


    $query = 'UPDATE anuncios SET deleted=1 WHERE number = ? AND account_id = ?';
    $query = 'DELETE FROM anuncios WHERE number = ? AND account_id = ?';
    
    $stmt = $conn->prepare($query);
    $stmt->bind_param('ii', $id, $_SESSION['id']);
    $stmt->execute();
    header("Location: cpremium.php");
    exit();

?>