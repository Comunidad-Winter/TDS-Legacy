<?php

// no se está usando todavía

if (isset($_POST['U_PJ_INV'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
        
    $inv = array(30);
    $invamount = array(30);
    $invequipped = array(30);
    
    for ($i=1; $i <= 30; $i++) { 
        $inv[$i]=  intval($_POST['inv'.$i]); 
        $invamount[$i]= intval($_POST['ia'.$i]); 
        $invequipped[$i]= intval($_POST['ie'.$i]); 
    }

    $nick = strtoupper($_POST['nick']);

    if (empty($nick) || empty($pass) || empty($email) || empty($email)) {
        exit();
    }else {
        
        // existe ese pj?
        $sql = "SELECT * FROM user WHERE nick=?;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {
            exit();
        }else {
            mysqli_stmt_bind_param($stmt, "s", $nick);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);
            if ($rowpj = mysqli_fetch_assoc($result)) {               
                $current=0;
                for ($i=0; $i < 30; $i++) {                     
                    $sql = "UPDATE inventory_item set number=?,item_id=?,amount=?,is_equipped WHERE user_id=?";
                    $current++;
                    $stmt = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt, $sql)) {
                        //exit();
                    }else{
                        mysqli_stmt_bind_param($stmt, "iiiii",$current,$inv[$current],$invamount[$current],$invequipped[$current],$rowpj['id']);
                        mysqli_stmt_execute($stmt);                
                    }
                }        
                // INV = 35
            }

        }
    }
}

?>