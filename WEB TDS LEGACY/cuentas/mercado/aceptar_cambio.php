<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    $conn = connect();

    if (!isset($_GET['n']) ) {
        die("Oferta invalida!");
    }

    if (!isset($_GET['c']) ) {
        die("Codigo invalido");
    }

    $offer_id=intval($_GET['n']);
    $codigo=$_GET['c'];
    
    $sql = "SELECT * FROM mercado_ofertas WHERE offer_id=? AND codigo=?;";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo 'Error en la consulta 1.';
        die();
    }
    
    mysqli_stmt_bind_param($stmt, "is", $offer_id,$codigo);
    mysqli_stmt_execute($stmt);
    
    $result = mysqli_stmt_get_result($stmt);
    if (mysqli_num_rows($result) > 0) {
         
        while ($row = mysqli_fetch_assoc($result)) {
            

            if ( $row['aceptada'] == 1 ) {
                header('Location: cpremium.php');
                exit();
            }
            
            $sql = "SELECT * FROM mercado WHERE mao_index=?;";
            $stmt2 = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt2, $sql)) {
                echo 'Error en la consulta 2';
                die();
            }
            
            mysqli_stmt_bind_param($stmt2, "i", $row['mao_index']);
            mysqli_stmt_execute($stmt2);
            $result2 = mysqli_stmt_get_result($stmt2);
            if (mysqli_num_rows($result2) > 0) {
                
                while ($row_mao = mysqli_fetch_assoc($result2)) {
                    if ($row_mao['account_id'] != $_SESSION['id']) {
                        echo 'No es tu cuenta!';
                        die();
                    } 
                    
                    $sql = 'UPDATE mercado_ofertas SET aceptada=1 WHERE offer_id=?';
                    
                    $stmt = mysqli_stmt_init($conn);
                    
                    if (!mysqli_stmt_prepare($stmt, $sql)){
                        echo 'Error al updatear la oferta.';
                        #die();
                    }else {
                        mysqli_stmt_bind_param($stmt, "i", $offer_id);
                        mysqli_stmt_execute($stmt);
                    }

                    $tipo=6;

                    $sql = "insert into anuncios(account_id,tipo,texto,mao_anun) values (?,?,?,?)";
                    $ofertaaceptada="Oferta aceptada: ".$row_mao['pjs']." por ".$row['la_oferta'].". Ahora debes finalizar el intercambio.";
                    $account_id=$row['account_id_offer'];

                    $stmt = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt, $sql)){
                        echo 'Error al insertar el anuncio.';                            
                    }else {
                        mysqli_stmt_bind_param($stmt, "iisi", $account_id,$tipo,$ofertaaceptada,$tipo);
                        mysqli_stmt_execute($stmt);
                    }
                                
                    $sql = "SELECT username,email FROM cuentas WHERE id=?";
                    
                    $stmt3 = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt3, $sql)) exit("ERR");
                    
                    mysqli_stmt_bind_param($stmt3, "i", $account_id);
                    mysqli_stmt_execute($stmt3);
                    $result3 = mysqli_stmt_get_result($stmt3);
                    if (!mysqli_num_rows($result3) > 0) {
                        echo 'result3=0';
                        exit();
                    }

                    $row_acc = mysqli_fetch_assoc($result3);    

                    $mailstring='<strong>Hola ' .$row_acc['username'].'!</strong><br><br>Felicitaciones!!!. Se ha aceptado tu oferta de intercambiar.<br>
                            <strong>'.$row_mao['pjs'].'</strong> por <strong>'.$row['la_oferta'].'</strong>.
                            <br><br>Si quieres finalmente realizar el intercambio deberas ingresar a <a href="'. TDS_URL .'/cpremium.php?a=finalizar_cambio&c='.$codigo.'">aqui</a>. Tenes 24 horas para finalizar el cambio o la aceptacion del usuario perdera validez.';

                    sendEmail($row_acc['email'],$row_acc['username'],'Ultima etapa para finalizar el cambio de ' .$row_mao['pjs'] .' por ' .$row['la_oferta'],$mailstring); 
                                                   
                    }

                    header('Location: cpremium.php');

                }else die("Esa venta no existe.");
            } 
        } else die("Oferta inválida.");
