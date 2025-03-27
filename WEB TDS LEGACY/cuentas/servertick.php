<?php
        
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

    $sv_on=1;

    $onlines=5;
    if (isset($_POST['ons'])) {
        $onlines=intval($_POST['ons']); 
        if ($onlines > 1500) $onlines=0;
    }


    $sql = 'UPDATE world SET `sv_on`=?, `onlines`=?';
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo "Error::". $stmt->error;
        return;
    }else{
        mysqli_stmt_bind_param($stmt, "ii",$sv_on,$onlines);
        mysqli_stmt_execute($stmt); 
    }
        
?>