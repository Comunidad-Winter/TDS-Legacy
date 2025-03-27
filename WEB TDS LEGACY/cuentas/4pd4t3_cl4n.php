<?php
  
if (isset($_POST['CAMBIARNOMBRE_CLAN'])) {
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    
    $conn = connect();

    foreach($_POST as $key => $value){
        $_POST[$key] = $conn->real_escape_string($_POST[$key]);        
    }

    if (empty($_POST['nick'])) {
        echo 'Se está intentando actualizar clan pero no hay nombre ';        
        exit();
    }

    $nick = trim(strtoupper($_POST['nick']));
    $newNick = trim(strtoupper($_POST['newNick']));
       
    if (empty($nick)) {
        echo "Nick $nick - Peticion invalida, faltan datos!!";
        exit();
    } else if (!preg_match('/^[\p{L}\s]+$/u', $nick)) {
        echo "Nick $nick - No es un nick válido supuestamente";
        exit();
    }else {
        
        sqlUpdate($conn, "UPDATE user SET clan = '$newNick' WHERE clan = '$nick'");

        
    }
}
