<?php


// no se está usando todavia


if (isset($_POST['U_PJ_MAO'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();
     
    foreach($_POST as $key => $value){

        $_POST[$key] = _cleaninjections(trim($value));
        $_POST[$key] = $conn->real_escape_string($_POST[$key]); 
    }
    
if (isset($_POST['borrar'])) {
    $id = intval($_POST['borrar']);
    if ($id <= 0) exit();
    // code que borra el Index!
}



if (!isset($_POST['id']) || !isset($_POST['activo']) || !isset($_POST['account_id']) || !isset($_POST['candado']) || !isset($_POST['totpjs']) || !isset($_POST['tipo'])) exit();

$contrasena="";
$comentario="";
$requisitos="";
$id=intval($_POST['id']);
$activo=intval($_POST['activo']);
$account_id=intval($_POST['account_id']);
$candado=intval($_POST['candado']);
$totpjs=intval($_POST['totpjs']);
$tipo=intval($_POST['tipo']);
$pjs=array($totpjs);
$oro='0';
$oro=abs($oro);

if (isset($_POST['contrasena'])) $contrasena=trim($_POST['contrasena']);
if (isset($_POST['comentario'])) $comentario=trim($_POST['comentario']);
if (isset($_POST['requisitos'])) $requisitos=trim($_POST['requisitos']);
if (strlen($contrasena) > 30) $contrasena=substr($contraena,0,30);
if (strlen($comentario) > 255) $comentario=substr($comentario,0,255);
if (strlen($requisitos) > 255) $requisitos=substr($requisitos,0,255);
if (empty($_POST['deposito'])) exit();
$deposito = $_POST['deposito'];
if (strlen(trim($deposito))> 20) exit();
if (!preg_match("/[^a-zA-Z\s]+/", $_POST['deposito'])) exit(); 

if ($oro > 50000000) $oro=50000000;
if (isset($_POST['oro'])) $oro=intval($_POST['oro']);

if ($id <= 0 || $account_id <= 0 || $totpjs <= 0 || $totpjs >15) exit();

for ($i=1; $i <= $totpjs; $i++) { 
    if (empty($_POST['pj'.$i])) exit();
    if (strlen(trim($_POST['pj'.$i]))> 20) exit();
    
    $pjs[$i]=$_POST['pj'.$i];
    if (!preg_match("/[^a-zA-Z\s]+/", $pjs[$i])) exit();
}


// Si el MAO no existe, es porque se está agregando:
$sql = "SELECT account_id FROM mercado WHERE mao_index=?;";
$stmt = mysqli_stmt_init($conn);

if (!mysqli_stmt_prepare($stmt, $sql)) exit();
mysqli_stmt_bind_param($stmt, "i", $id);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
$existe=false;
if ($rowmao = mysqli_fetch_assoc($result)) {if ($rowmao['account_id']> 0) {$existe=true;}}

switch ($tipo) {
    case 1:
        $tipo="1";
        break;
    case 2:
        $tipo="2";
        
        if ($oro <= 0) exit();
        if (!isset($_POST['deposito'])) exit();
        $deposito=strtoupper(trim($_POST['deposito']));
        if (strlen($deposito) > 20) $deposito=substr($deposito,0,20);
        
        // totPjs existe?
        for ($i=1; $i <= $totpjs; $i++) { 
            $sql = "SELECT id,ban,account_id,logged,ban FROM user WHERE nick=?;";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) exit();
            mysqli_stmt_bind_param($stmt, "s", $pjs[$i]);
            mysqli_stmt_execute($stmt);
            $result = mysqli_stmt_get_result($stmt);            
            if ($pj = mysqli_fetch_assoc($result)) {
                if ($pj['ban'] != 0) exit();
                if ($pj['logged'] > 0) exit();
                if ($pj['account_id'] == 0) exit();
            }else exit();
        }

        // deposito existe?
        $sql = "SELECT id,ban,account_id,logged,ban FROM user WHERE nick=?;";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) exit();
        mysqli_stmt_bind_param($stmt, "s", $deposito);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);            
        if ($pj = mysqli_fetch_assoc($result)) {
            if ($pj['ban'] != 0) exit();
            if ($pj['logged'] > 0) exit();
            if ($pj['account_id'] == 0) exit();
        }else exit();

        for ($i=1; $i <= $totpjs ; $i++) { 
            $pjsconcatenados .= $pjs[$i] .'-';
        }        
        $pjsconcatenados=substr($pjsconcatenados,0, (strlen($pjsconcatenados)-1));

        // Si el MAO no existe, es porque se está agregando:
        $sql = "SELECT account_id FROM mercado WHERE mao_index=?;";
        $stmt = mysqli_stmt_init($conn);

        if (!mysqli_stmt_prepare($stmt, $sql)) exit();

        mysqli_stmt_bind_param($stmt, "i", $id);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        
        if ($existe) {         
            $sql = "UPDATE `mercado` SET `account_id`=?,`tipo`=?,`deposito`=?,`pjs`=?,`oro`=?,`comentario`=?,`requisitos`=?,`candado`=?,`contrasena`=?";
        } else{
            $sql = "insert into mercado(account_id, tipo,deposito,pjs,oro,comentario,requisitos,candado,contrasena) values (?,?,?,?,?,?,?,?,?)";
        }

        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) exit();        
        mysqli_stmt_bind_param($stmt, "isssissis",$account_id,$tipo,$deposito,$pjsconcatenados,$oro,$comentario,$requisitos,$candado,$contrasena);
        mysqli_stmt_execute($stmt);
        break;
    case 3:
        $tipo="3";
        break;
    default: exit();break;
}












// exist?

    if (empty($nick) || empty($pass) || empty($email) || empty($email)) {
        exit();
    } else if (!preg_match("/[^a-zA-Z\s]+/", $nick)) {
        exit();
    } else if (strlen($pass) < 2 ) {
        exit();
    } else if (strlen($pin) < 2 ) {
        exit();
    } else if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
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
               
                //update
                $sql = 'UPDATE user set pin=?,password=?,email=?,account_id=?,logged=?,boveda=?,mao_index=? WHERE nick=?;';

                $stmt = mysqli_stmt_init($conn);

                if (!mysqli_stmt_prepare($stmt, $sql)) { 
                    //echo (htmlspecialchars($stmt->error));
                    exit();
                }else{
                    mysqli_stmt_bind_param($stmt, "sssiiiis",$pin,$pass,$email,$account_id,$logged,$boveda,$mao_index,$nick);
                    mysqli_stmt_execute($stmt);
                    mysqli_stmt_close($stmt);
                }
                exit();
            }

        }
    }
}

?>