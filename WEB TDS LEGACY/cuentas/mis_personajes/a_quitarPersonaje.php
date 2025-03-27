<?php
 
 require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
 $conn = connect();
 require_logged();
 require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
$err="";

if (isset($_POST['nick']) && isset($_POST['nick']) && isset($_POST['pin']) && isset($_POST['pass'])) { 
    
    foreach($_POST as $key => $value){
        $_POST[$key] = _cleaninjections(trim($value));
    }  
    
    $nick = clear_nick($_POST['nick']);
    $pass = $_POST['pass']; 
    $pin = $_POST['pin']; 

    if (empty($nick) || empty($pass)|| empty($pin)) {
        $err= '¡¡Rellena los casilleros!!';
    } else if (!preg_match("/[^a-zA-Z\s]+/", $nick) == 0) { // acá no debería de llegar total usé clear_nick
        $err= 'Nombre invalido';
    } else if (strlen($pass) < 2 || strlen($pass) > 20 ) {
        $err= 'La contraseña no es correcta';
    } else if (strlen($pin) < 2 || strlen($pin) > 20 ) {
        $err= 'El pin no es correcto';
    } else {

        $nick = $conn->real_escape_string($nick);
        $pass = $conn->real_escape_string($pass);
        $pin = $conn->real_escape_string($pin);
 
        $res = sqlSelect($conn, 'SELECT id,ban,email,nick FROM user WHERE account_id=? AND nick=? AND password=? AND pin=?', 'isss', $_SESSION['id'], $nick, $pass, $pin);
    
        if (!$res) {
            echo 'No pude establecer la conexión con la DB';
            exit();
        } 

        if ($res && $res->num_rows === 1) {
            $found=false; 
            $acc_id=0;
            
            while ($pj = $res->fetch_assoc()) {        
                if (strcmp(strtoupper($nick), strtoupper($pj['nick'])) === 0) { 
                    $acc_id=$pj['account_id'];
                    $found=true; 
                    break;
                } 
            }

            if ($pj['ban'] === 1 ) {
                echo '4';
                exit();
            }

            #if ($acc_id != $_SESSION['id']) {
            #    echo '2' ;
            #    exit();
            #}
            
            $data="";
            $line = "|6|".$ip."|". $nick .'|'. $_SESSION['username'] ."|" . $_SESSION['password'] .'|'. $_SESSION['pin'] ;   
            server_getdata($line,$data); 

            if ($data[0] == 0){
                    
                if(sqlUpdate($conn, 'UPDATE user SET account_id=? WHERE nick=?', 'is', '0', $nick)) {                    
                    $msg = '<style type="text/css">.style1 {color: #FF0000;font-weight: bold;font-family: Geneva, Arial, Helvetica, sans-serif;font-size: 18px;}</style>
                            <div align="center"><span class="style1">'.APP_NAME.' </span></div><p><strong>Hola '.$_SESSION['first_name'].'!</strong></p><p>Has eliminado a tu personaje "'.$nick.'" de la cuenta correctamente!. <br />
                                <br/>
                                Si no realizaste ésta acción contacta ya mismo con un Administrador.</p>';                
                    sendEmail($pj['email'], $nick, 'Personaje removido!' , $msg,true);
                }
                else {
                    $err= 'Failed to update user account!!';
                }
            
            }else {        
                
                if ($data[0] == 9 ) {
                    sqlUpdate($conn, 'UPDATE user SET account_id=? WHERE nick=?', 'is', '0', $nick);
                }
                $err = $data[0] ;  
            }    
        } else
            $err ='2';             
    }
}
if ($err != null) {
    echo $err;
}else {
    echo $data;
}

?>