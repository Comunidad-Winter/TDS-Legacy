<?php

if (  !isset($_POST['NombreCuenta']) && !isset($_POST['g']) ) { 
    echo 0;
    return;
}
    $nick=trim($_POST['NombreCuenta']);

    if (strlen($nick )>30 || strlen($nick)<3) { 
        echo 0; 
        return;
    }


    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    $nick = $conn->real_escape_string($nick); 

    $sql = "SELECT * FROM cuentas WHERE username = ?";

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo 0;
            return;
        }else{
            mysqli_stmt_bind_param($stmt, "s",$nick);
            mysqli_stmt_execute($stmt); 
        }
        
        $result = mysqli_stmt_get_result($stmt);
                            
        if(mysqli_num_rows($result) > 0){
            echo 0;
            return;
        }
        
        echo 1;


?>