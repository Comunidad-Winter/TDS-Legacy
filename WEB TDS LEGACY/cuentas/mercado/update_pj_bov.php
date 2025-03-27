<?php

// no se está usando todavía


if (isset($_POST['U_PJ_BOV'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
    $bov = array(40);
    $bovamount = array(40);
    
    for ($i=1; $i <= 40; $i++) { 
        $bov[$i]=  intval($_POST['b'.$i]); 
        $bovamount[$i]= intval($_POST['ba'.$i]); 
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
                for ($i=0; $i < 40; $i++) {                     
                    $sql = "UPDATE bank_item set number=?,item_id=?,amount=? WHERE user_id=?";
                    $current++;
                    $stmt = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt, $sql)) {
                        //exit();
                    }else{
                        mysqli_stmt_bind_param($stmt, "iiii",$current,$bov[$current],$bovamount[$current],$rowpj['id']);
                        mysqli_stmt_execute($stmt);                
                    }
                }        
                // BANCO = 40
            }

        }
    }
}

?>