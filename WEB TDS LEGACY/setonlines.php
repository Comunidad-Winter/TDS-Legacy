<?php

// validar   
require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();

if (isset($_POST['ons'])) {
	
	$onlines=intval($_POST['ons']); 
 	
    $onlines = clear_string($onlines);
    $sv_on = clear_string($sv_on);

	$result = $conn->query("UPDATE `world` SET `onlines`=?");

    $sql = 'UPDATE world SET onlines=?';

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo -1;
            return;
        }else{
            mysqli_stmt_bind_param($stmt, "i",$onlines);
            mysqli_stmt_execute($stmt); 
        }
         
}

?>