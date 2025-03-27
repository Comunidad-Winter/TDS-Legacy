<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

    if (!isset($_POST['nick']) || !isset($_POST['pin'])) {
        echo("5");
        exit();
    }

    $nick = clear_nick(trim($_POST['nick']));
    $pin = trim($_POST['pin']);

    if (strlen($nick) < 4 || strlen($nick) >20 || strlen($pin) < 4 || strlen($pin) >20) {
        echo("5");
        exit();
    }

    $data="";
    $line = "|9|".$ip."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $pin . "|" .$nick;

    server_getdata($line, $data);
    
    if ($data == 4 || $data == 0) {
        $lockedValue = ($data == 4) ? 1 : 0;
    
        $sql = 'UPDATE user SET locked=? WHERE nick=?';
        $stmt = mysqli_stmt_init($conn);
    
        if (mysqli_stmt_prepare($stmt, $sql)) {
            mysqli_stmt_bind_param($stmt, "is", $lockedValue, $nick);
            mysqli_stmt_execute($stmt);
            mysqli_stmt_close($stmt);
        } else {
            echo ('Error al actualizar tu cuenta.');
            exit();
        }
    }

    echo $data;
                    
?>
