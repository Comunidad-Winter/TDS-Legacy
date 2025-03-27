<?php
        
   require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
   $conn = connect();

   if (!$conn) {
        exit();
   }

    $onlines=0;
    if (isset($_POST['ons'])) {
        $onlines=intval($_POST['ons']); 
        if ($onlines > 1500) $onlines=0;
    }

    $exp=0;
    if (isset($_POST['exp'])) {
        $exp=intval($_POST['exp']); 
        if ($exp > 1500) $exp=1;
    }

    $oro=0;
    if (isset($_POST['oro'])) {
        $oro=intval($_POST['oro']); 
        if ($oro > 1500) $oro=1;
    }

    $sv_on=0;
    if (isset($_POST['sv_on'])) {
        $sv_on=intval($_POST['sv_on']); 
        if ($sv_on > 1500) $sv_on=1;
    }

    $sql = 'UPDATE world SET `onlines`=?, `exp`=?, `oro`=?, `sv_on`=?';
    $stmt = mysqli_stmt_init($conn);
    if (mysqli_stmt_prepare($stmt, $sql)) {
        mysqli_stmt_bind_param($stmt, "iiii",$onlines,$exp,$oro,$sv_on);
        mysqli_stmt_execute($stmt);         
    }
