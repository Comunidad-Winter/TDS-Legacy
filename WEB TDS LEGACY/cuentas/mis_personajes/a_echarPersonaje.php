<?php 

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
$conn = connect();
require_logged();
require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

if (!isset($_POST['nick'])) {
    return 4;
}

$nick=clear_string($_POST['nick']);

if (mb_strlen($nick) > 2 || mb_strlen($nick) < 21) {

    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
    
    if (!$res) {
        return 4;
    } 

    if ($res && $res->num_rows === 0) {
        return 5;
    } 
    
    $found=false; 
    
    while ($pj = $res->fetch_assoc()) {        
        if (strcmp(strtoupper($nick), strtoupper($pj['nick'])) === 0) { 
            $found=true; 
            break;
        } 
    }

    if($found){
        
        
        $nick = $conn->real_escape_string($nick); 

        $sql = "SELECT logged,id FROM user WHERE nick=?";

        $nick=$conn->real_escape_string($nick);

        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, 's', $nick);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);

        if (!mysqli_num_rows($result) > 0) {    
            return 4;
        }

        $row = mysqli_fetch_assoc($result);

        if ($row['logged'] == 0 ) {
            return 'Pj OFF';
        }

        $data="";
        
        $line = "|1|".$ip."|". $nick .'|'. $_SESSION['username'] ."|" .$_SESSION['password'] . '|'.$_SESSION['pin'];        
        
        server_getdata($line,$data);

        $err=null;

        switch ($data[0]) {
            case 1:
                $err="Nick equivocado";
                break;
            case 2:
                $err="Cuenta equivocada."; // account_id > cuentas_totales Or account_id <= 0
                break;
            case 3:
                $err="Cuenta equivocada."; // trully equivocated
                break;
            case 4:
                $err="Alguno de los datos son incorrectos."; // pw
                break;
            case 5:
                $err="Alguno de los datos son incorrectos."; // pin
                break;
            case 6:
                $err="Cuenta equivocada."; // account_id <> UserList(tindex).account_id
                break;
            case 7:
                $err="El personaje está paralizado.";
                break;
            case 8:
                $err="El personaje no se encuentra online";
                break;
            default:
                $err="Error desconocido";
                break;
        }

        if (intval($data) == 0 || intval($data) == 3) {
            
            sleep(10);
            
            $sql = 'UPDATE user SET logged=0 WHERE id=?;';
            $stmt = mysqli_stmt_init($conn);
            
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                return 4;
            }else{
                mysqli_stmt_bind_param($stmt, "i",$row['id']);
                mysqli_stmt_execute($stmt);
                mysqli_stmt_close($stmt); // está bien?
            } 
            echo $data;
        }else {
            echo $err;
        }
        return;
    }
}
exit (-1);

?>
