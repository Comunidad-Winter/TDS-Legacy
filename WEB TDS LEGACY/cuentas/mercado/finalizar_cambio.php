<?php 

    if (!isset($_GET['c'])) {
        die(-1);
    }

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    require_logged();
          
    if(strlen($_GET['c'])> 32) die(-1);
    
    $codigo=$_GET['c'];

    $codigo = $conn->real_escape_string($codigo); 
    $sql = "SELECT mercado_ofertas.*, cuentas.email, cuentas.password, cuentas.pin, cuentas.username FROM mercado_ofertas JOIN cuentas ON mercado_ofertas.account_id_offer = cuentas.id WHERE codigo=?;";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) exit(-2);
    
    mysqli_stmt_bind_param($stmt, "s", $codigo);
    mysqli_stmt_execute($stmt);
    
    $result = mysqli_stmt_get_result($stmt);
    if (mysqli_num_rows($result) > 0) {
        while ($rowOferta = mysqli_fetch_assoc($result)) {
            $mao_index= $rowOferta['mao_index'];
 
            if ($rowOferta['aceptada'] ==0 ) {
                #exit(); #Intentó hacer trampita..
            }
            
            $sql = "SELECT mercado.*, cuentas.email, cuentas.password, cuentas.pin, cuentas.username
            FROM mercado
            JOIN cuentas ON mercado.account_id = cuentas.id
            WHERE mercado.mao_index = ?;";
            
            $stmt2 = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt2, $sql))
            {
                header('Location: cpremium.php');                
                exit();
            }
            
            mysqli_stmt_bind_param($stmt2, "s", $mao_index);
            mysqli_stmt_execute($stmt2);
            $result2 = mysqli_stmt_get_result($stmt2);
            if (mysqli_num_rows($result2) > 0) {
                
                while ($rowMercado = mysqli_fetch_assoc($result2)) {
                    if ($rowOferta['account_id_offer'] != $_SESSION['id']) {
                        header('Location: cpremium.php');
                        exit();
                    }
                                            
                    $Param1 =  $rowMercado['username'] . ";;;" . $rowMercado['pin'] . ";;;". $rowMercado['password'] .";;;". $rowMercado['email'];
                    $Param2 =  $rowOferta['username'] . ";;;" . $rowOferta['pin'] . ";;;". $rowOferta['password'] .";;;". $rowOferta['email'];

                    $line = "|4|".$ip."|". $_SESSION['username'] ."|" .$_SESSION['password'] .'|'. $_SESSION['pin'] .'|'. $rowMercado['pjs'] .'|'. $rowOferta['la_oferta'] .'|' . $Param1 .'|' . $Param2;
                                       
                    $data="";

                    $server= bserver_getdata($line,$data);
            
                    if (!$server) {
                        echo "Server off";
                        exit();
                    }

                    switch ($data[0]) {
                        case 1:
                            echo 'Esa oferta no existe';
                            exit();
                        case 2:
                            echo 'Esa no es tu cuenta';
                            exit();   
                        case 3:
                            echo 'Esa oferta no existe';
                            exit();                        		
                        default:
                            echo "Error desconocido";
                            exit;
                        case '|':case 0: 
                            $data = substr($data, 1);  
                            break;			
                    }
                    

                    $pjscomprador=array();
                    $pjscomprador=explode('-',$rowMercado['pjs']); 
                    foreach ($pjscomprador as $pj) {
                        $sql = 'UPDATE user SET mao_index=0, pin=?, password=?, email=?, account_id=? WHERE nick=?;';     
                        $stmt = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($stmt, $sql)) exit("Terrible error");                        
                        mysqli_stmt_bind_param($stmt, "sssis", $rowOferta['pin'],$rowOferta['password'],$rowOferta['email'],$rowOferta['account_id_offer'],$pj);
                        mysqli_stmt_execute($stmt);                        
                    }

                    $pjsvendedor=array();
                    $pjsvendedor=explode('-',$rowOferta['la_oferta']); 
                    foreach ($pjsvendedor as $pj) {
                        $sql = 'UPDATE user SET mao_index=0, pin=?, password=?, email=?, account_id=? WHERE nick=?;';     
                        $stmt = mysqli_stmt_init($conn);
                        if (!mysqli_stmt_prepare($stmt, $sql)) exit("Terrible error");                        
                        mysqli_stmt_bind_param($stmt, "sssis", $rowMercado['pin'],$rowMercado['password'],$rowMercado['email'],$rowMercado['account_id'],$pj);
                        mysqli_stmt_execute($stmt);
                    } 


######################################### ANUNCIOS ############################################

                    $sql = "insert into anuncios(account_id,tipo,texto) values (?,?,?)";
                    $msg="¡Intercambio realizado!: ".$rowOferta['la_oferta']." por ".$rowMercado['pjs'].".";                     
                    $tipo=9;

                    $stmt = mysqli_stmt_init($conn);
                    if (mysqli_stmt_prepare($stmt, $sql)){
                        mysqli_stmt_bind_param($stmt, "iis", $rowMercado['account_id'],$tipo,$msg);
                        mysqli_stmt_execute($stmt);
                    }

                    $stmt = mysqli_stmt_init($conn);
                    if (mysqli_stmt_prepare($stmt, $sql)){
                        mysqli_stmt_bind_param($stmt, "iis", $_SESSION['id'],$tipo,$msg);
                        mysqli_stmt_execute($stmt);
                    }


                    $sql = 'DELETE FROM mercado WHERE mao_index=?;';                    
                    $stmt = mysqli_stmt_init($conn);                    
                    if (mysqli_stmt_prepare($stmt, $sql)){
                        mysqli_stmt_bind_param($stmt, "i", $mao_index);
                        mysqli_stmt_execute($stmt);
                    }
                    

######################################### EMAIL ############################################

                    $mailstring='<strong>Hola!</strong><br><br>Felicitaciones!!!. Se ha completado la oferta de intercambio <br>
                    <strong>'.$rowOferta['la_oferta'].' por '.$rowMercado['pjs'].'</strong>.
                    <br><br>Los datos de los personajes ahora son los mismos que los de tu cuenta!<br>';
                    sendEmail($rowOferta['email'],$rowOferta['username'],"Intercambio realizado!",$mailstring);
                    sendEmail($rowMercado['email'],$rowMercado['username'],"Intercambio realizado!",$mailstring);

                }
            }            
        } 
    }

    header('Location: cpremium.php?a=mi-premium');
