<?php
  
if (isset($_POST['CAMBIARNOMBRE_PJ'])) {
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    
    $conn = connect();

    foreach($_POST as $key => $value){
        $_POST[$key] = $conn->real_escape_string($_POST[$key]);        
    }

    if (empty($_POST['nick'])) {
        echo 'Se está intentando actualizar pj pero no hay nick ';        
        exit();
    }

    $nick = trim(strtoupper($_POST['nick']));
    $newNick = trim(strtoupper($_POST['newNick']));
    $ip = $_POST['IP'];
    
    if (empty($nick) || empty($ip) || empty($newNick)) {
        echo "Nick $nick - Peticion invalida, faltan datos!!";
        exit();
    } else if (!preg_match('/^[\p{L}\s]+$/u', $nick)) {
        echo "Nick $nick - No es un nick válido supuestamente";
        exit();
    }else {
                          
        $sql = "SELECT id,email FROM user WHERE nick = ?";

        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, 's', $nick);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if (mysqli_num_rows($result) === 0) {    
            echo "El personaje '$nick' no existe";
            exit();
        }

        $row = mysqli_fetch_assoc($result);

        sqlUpdate($conn, "DELETE FROM mercado WHERE pjs LIKE '$nick-%' OR pjs LIKE '%-$nick' OR pjs LIKE '%-$nick-%'");
        sqlUpdate($conn, "DELETE FROM mercado_ofertas WHERE la_oferta LIKE '$nick-%' OR la_oferta LIKE '%-$nick' OR la_oferta LIKE '%-$nick-%'");
        sqlUpdate($conn, "UPDATE user SET nick = '$newNick' WHERE nick = '$nick'");

        $mailstring="<strong>Hola!</strong><br><br>Has cambiado el nick del personaje '<strong>$nick</strong>' por el nick '<strong>$newNick</strong>'<br>Si no realizaste esto, habla con el equipo de TDS Legacy!<br>";	
             
        $mailstring.='<p><em>Esta solicitud fue generada desde la IP: '.$ip.'</em> </p>';

        sendEmail($row["email"], "Cambio de nick", "¡CAMBIO DE NICK!", $mailstring );
        
    }
}
