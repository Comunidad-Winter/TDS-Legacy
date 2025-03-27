<?php

if (isset($_POST['nick']) && isset($_POST['pass']) && isset($_POST['pin']) ) {
 
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    
    foreach($_POST as $key => $value){
        $_POST[$key] = _cleaninjections(trim($value));
    }
    
    $nick = clear_nick($_POST['nick']);
    $pass = $_POST['pass']; 
    $pin = $_POST['pin']; 

    if (empty($nick) || empty($pass)|| empty($pin)) {
        echo '¡¡Rellena los casilleros!!';
        exit();
    } else if (!preg_match('/^[a-zA-Z\s]+$/', $nick)) {
        echo 'Nombre invalido';
        exit();
    } else if (strlen($pass) < 2 || strlen($pass) > 20 ) {
        echo 'La contraseña no es correcta';
        exit();
    } else if (strlen($pin) < 2 || strlen($pin) > 20 ) {
        echo 'El pin no es correcto';
        exit();
    } else {
     
        $nick = $conn->real_escape_string($nick);
        $pass = $conn->real_escape_string($pass);
        $pin = $conn->real_escape_string($pin);

        $nick = strtoupper($nick);

        $sql = 'SELECT * FROM user WHERE nick=?;';
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo 'SQL ERROR';
            exit();
        } 
        else {

            mysqli_stmt_bind_param($stmt, "s", $nick);
            mysqli_stmt_execute($stmt);

            $result = mysqli_stmt_get_result($stmt);

            if (!$row = mysqli_fetch_assoc($result)) {
                echo "2";
                exit();
                
            }elseif ($row['ban'] == 1) {
                echo "4";
                exit();
            }
            else {

                $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
                
                $ts1 = date(time());
                $ts2 = strtotime($_SESSION['premium_at']);               
                $premium = (($ts2 - $ts1) > 0) ? true : false ;

                if ($premium ) {
                    if ($res && $res->num_rows > 14) {
                        echo "9";
                        exit();
                    }
                }else {
                    if ($res && $res->num_rows > 2) {
                        echo "10";
                        exit();
                    }
                }
                

                if (!strcmp($row['password'], $pass) == 0 || !strcmp($row['pin'], $pin) == 0) {
                    echo "3";
                    exit();
                }
                
                $line = "|2|".$ip."|".$_SESSION['username'] ."|" .$nick .'|' . $pass . '|' . $pin. '|' . $_SESSION['password']. '|' . $_SESSION['pin'];
                $data="";
                server_getdata($line,$data); 
                
                if ($data[0] == 0) {
                                            
                    $sql = 'UPDATE user SET account_id=?,email=?,pin=?,password=? WHERE nick=?;';

                    $stmt = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt, $sql)) {
                        echo '¡Error al updatear a tu personaje!';                            
                    }else{
                        mysqli_stmt_bind_param($stmt, "issss", $_SESSION['id'],$_SESSION['email'],$_SESSION['pin'],$_SESSION['password'], $nick);
                        mysqli_stmt_execute($stmt);
                        mysqli_stmt_close($stmt);
                        echo 0;

                        $msg='<div align="center"><span>TDS Legacy</span></div><p><strong>Hola!</strong></p><p>¡¡Has agregado a tu personaje <strong><u>'.$nick.'</u></strong> a tu cuenta!! </p>';
                        sendEmail($_SESSION['email'], $nick, 'Personaje agregado en TDS Legacy', $msg,true );
                    }
                }
                else
                    echo $data; // nunca va a entrar acá        
            }                
        }
    }
}


?>