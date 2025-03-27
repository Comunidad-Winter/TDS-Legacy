<?php

// no se está usando todavía

if (isset($_POST['U_PJ_MAO_DELETE'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
    $mao_index = intval($_POST['mao_index']);    
    if ($mao_index < 1 ) exit();

    $conn->query("DELETE FROM mercado WHERE mao_index=".$mao_index);
    $conn->query("UPDATE user set is_locked_in_mao=0,mao_index=0  WHERE mao_index=".$mao_index);

        
}
        