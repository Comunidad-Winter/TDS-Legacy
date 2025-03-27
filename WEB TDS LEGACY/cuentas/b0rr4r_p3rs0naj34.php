<?php

if (isset($_POST['BORRAR_PJ_WEB'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php';  
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
    $nick = $_POST['nick'];    

    $conn->query("DELETE FROM user WHERE nick='$nick';");
        
}
        