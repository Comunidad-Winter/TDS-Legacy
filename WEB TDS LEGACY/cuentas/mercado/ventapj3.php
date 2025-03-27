<?php
 

 if (!isset($_POST['confirmacion'])) {header('Location: index.php');exit();}

 require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 

 $conn = connect();
 
 #require_logged();
 #require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

// CODIGO EQUIVOCADO REY
if ($_SESSION['tmpcodigo'] !== $_POST['confirmacion']) {
    unset($_SESSION['tmpcodigo']);
    $_SESSION['ERRORS']['err'] = '<div id="panel-premium">El Código de confirmación es incorrecto. Intentelo nuevamente.</div>';
    header('Location: ventapj.php');
    die();
}

if (!isset($_POST['pjs']) || !isset($_POST['rb'])) { //tipo mercado, y nicks.
    exit("no pjs no rb");
}


$mc=0;if (isset($_POST['mc']))$mc=intval($_POST['mc']);// Modo Candado
$passpriv="";if (isset($_POST['passpriv']))$passpriv=trim($_POST['passpriv']);// pass de la venta
$tcoment="";if (isset($_POST['tcoment']))$tcoment=trim($_POST['tcoment']); // mi comment
$permitirComentarios=0;if (isset($_POST['permitirComentarios']))$permitirComentarios=intval($_POST['permitirComentarios']); // permito comentarios de ellos?

$pjs=trim($_POST['pjs']);


                $ts1 = date(time());
                $ts2 = strtotime($_SESSION['premium_at']);               
                $premium = (($ts2 - $ts1) > 0) ? true : false ;
 

$rb=intval($_POST['rb']);

if ($rb == 1 || $rb == 2) {
    $oro=abs(intval($_POST['monedas']));

    if ($oro <= 0 && $rb == 1) exit("Debes insertar minimo 1 monedita de oro");
    if ($oro > 50000000) $oro=50000000;

    // requisitos
    $requisitos="";if (isset($_POST['pedido'])) {$requisitos=trim($_POST['pedido']);}if (strlen($requisitos) > 255) $requisitos=substr($requisitos,0,255);

    // No es premium y posteó algo raro? chau nos vimo 

    $arrPjs = explode('-',$pjs,3);
    sort($arrPjs);
    $pjs = implode("-", $arrPjs);

    if (count($arrPjs)> 1 && !$premium) {            
        $_SESSION['ERRORS']['err'] = '<div id="panel-premium">'.$arrPjs.' > 1 y no soy premium.</div>';
        header('Location: ventapj.php');
        exit();
    }
    
    for ($i=0; $i < count($arrPjs); $i++) { 
        $arrPjs[$i] = clear_nick(strtoupper($arrPjs[$i]));        
        $arrPjs[$i]=  $conn->real_escape_string($arrPjs[$i]);

        $sql = "SELECT account_id,ban,logged,carceltime,privilegios,mao_index FROM user WHERE nick=?;";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql))die();

        mysqli_stmt_bind_param($stmt, "s", $arrPjs[$i]);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        if (mysqli_num_rows($result) > 0) {
            while ($row = mysqli_fetch_assoc($result)) {
                if (intval($row['account_id']) !== intval($_SESSION['id'])) exit("El personaje no te pertenece.");
                if (intval($row['ban'])>0 || intval($row['carceltime'])>0) exit("Personaje baneado o penado.");
                if (intval($row['logged'])>0) exit("Personaje logueado, debes desloguear para publicar el personaje.");
                if (intval($row['mao_index'])>0) exit("Personaje ya publicado: ".$arrPjs[$i]);
            }
        }
    }
    
    $pjsstr = implode('-', $arrPjs);

    $sql = "insert into mercado(account_id, tipo,pjs,oro,comentario,requisitos,candado,contrasena,permitirComentarios) values (?,?,?,?,?,?,?,?,?)";        
        
    $date=date('Y-m-j H-i-s', time());
    $stmt = mysqli_stmt_init($conn);

    if (mysqli_stmt_prepare($stmt, $sql)){            
        mysqli_stmt_bind_param($stmt, "ississisi", $_SESSION['id'],$rb,$pjs,$oro,$tcoment,$requisitos,$mc,$passpriv,$permitirComentarios);
        mysqli_stmt_execute($stmt);
        $mao_index =$conn->insert_id;

        if (($mao_index) > 0 ) {            
            $sql = "UPDATE user SET mao_index=? WHERE nick=?;";
            for ($i=0; $i < count($arrPjs); $i++) { 
                $stmt = mysqli_stmt_init($conn);
                if (mysqli_stmt_prepare($stmt, $sql)) {            
                    mysqli_stmt_bind_param($stmt, "is", $mao_index,$arrPjs[$i]);
                    mysqli_stmt_execute($stmt);                    
                }else {
                    echo "Step 3) No pude insertar en el MAO a " . $arrPjs[$i];
                    exit(-1);
                }                
            }
                        
            $echostr = ($rb != 2) ? "$oro monedas" : 'Cambio PJ';    
            $response= '<p align="center"> <span class="negrita"> <font size="5">Personaje adherido a la lista de ventas</font></span><font size="5"><span class="simple"></span></font></p>Puedes ver la lista de personajes en venta haciendo click <a href="#" onclick="seccion(5)">aquí</a>. Puedes quitar los personajes de la venta desde <a href="#" onclick="seccion(6)">aquí</a>.<div align="left"><br><br><strong>Código para el foro del link de la venta:</strong><br><textarea style="background-color:#666666; color:#CCCCCC" cols="65" rows="3">[URL="'.TDS_URL.'/cpremium.php?a=mercado&s=c&p='.$pjsstr.'"]
                MercadoAo - '.$echostr.': '.$pjsstr.'[/URL]</textarea></div></div>';

            $line = "|10|$ip|{$_SESSION['username']}|{$_SESSION['password']}|{$_SESSION['pin']}|$oro|$rb|$pjsstr|$mao_index";
             

            $data="";
            
            $server= bserver_getdata($line,$data);
            
            if (!$server) {
                $response = "Server off";
            }
            else {
                
                if ($data['0'] == '|' && $server) {
                    echo $response;
                    exit();
                }else {
                        
                    switch ($data) {
                        case 1:
                            echo 'Esa no es tu cuenta';
                            break;
                        case 2:
                            echo 'No hay slot libre';
                            break; 
                        case 3:
                            echo 'Algun nick es invalido';
                            break;  
                        case 4:
                            echo 'Algunos de los personajes no existen';
                            break;          
                        case 5:
                            echo 'Algunos de los personajes no está en alguna cuenta o no te pertenecen';
                            break;  
                        case 6:
                            echo 'Algunos de los personajes se encuentran baneados';
                            break;  
                        case 7:
                            echo 'Alguno de los personajes ya está en una publicación del Mercado';
                            break;
                        case 10:
                            echo 'Algun personaje se encuentra en zona insegura!';
                            break;
                        default:
                            echo "Algunos de los personajes NO cumplen con los requisitos: $data";
                            break;                	
                    }
                }
            }

            # un error!
            $sql = "DELETE FROM mercado WHERE mao_index=?";
            $current++;
            $stmt = mysqli_stmt_init($conn);
            if (mysqli_stmt_prepare($stmt, $sql)) {
                mysqli_stmt_bind_param($stmt, "i", $mao_index);
                mysqli_stmt_execute($stmt);
            }
            
            $sql = "UPDATE user SET mao_index=0 WHERE mao_index=?;";
            for ($i=0; $i < count($arrPjs); $i++) { 
                $stmt = mysqli_stmt_init($conn);
                if (mysqli_stmt_prepare($stmt, $sql)) {            
                    mysqli_stmt_bind_param($stmt, "i", $mao_index);
                    mysqli_stmt_execute($stmt);    
                }                
            }
                
        }else {
            echo 'Step 2) No pude insertar tu personaje en el mercadoAO.';
        }

    }else {
        echo 'Step 1) No pude insertar tu personaje en el mercadoAO.';
    }
}
