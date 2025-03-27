<?php
    
    // Quitar pj // ELIMINAR PUBLICACION
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    
    $conn = connect();
    
    if (!isset($_POST['id_publicacion'])) die("Publicacion erronea");
    $mao_index =intval($_POST['id_publicacion']);
    
    $pjs = $conn->real_escape_string($pj); 
    $sql = "SELECT * FROM mercado WHERE mao_index=? AND account_id=?;";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo 'El sistema no funciona.';
    } else {
        mysqli_stmt_bind_param($stmt, "ii", $mao_index, $_SESSION['id']);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        if (mysqli_num_rows($result) > 0) {
            while ($row = mysqli_fetch_assoc($result)) {
                
                #if (strlen($pjs)<=2) die("Publicacion erronea");
                
                $data="";
                $line = "|14|". $ip ."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'. $row['pjs'];                
               
                $server= bserver_getdata($line,$data);
            
                if (!$server) {
                    echo "Server off";
                    exit();
                }

                switch ($data[0]) {
                    case '|':               
                        $data = substr($data, 1);              
                        break; // Valid!!! 
                    case 1:
                        echo 'No es tu cuenta';
                        exit();
                    case 2:
                        echo 'ASCII invalidos';
                        exit();
                    case 3:
                        echo 'No existe alguno de los pj';
                        exit();
                    case 4:
                        echo '¡Datos incorrectos de algun pj';
                        exit();
                    case 5:
                        echo 'Alguno de esos personajes no se encuentra en el MAO!';
                        exit();
                    case 6:
                        echo 'El personaje se encuentra baneado!';
                        exit();
                    case 7:
                        echo 'Alguno de esos personajes no se encuentra en el MAO!';
                        exit();                    
                    default:
                        echo 'Error desconocido';
                        exit();
                }

                $sql = "SELECT * FROM mercado_ofertas WHERE offer_id=?;";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo 'El sistema no funciona.';
                    exit();
                } else {
                    mysqli_stmt_bind_param($stmt, "i", $offer_id);
                    mysqli_stmt_execute($stmt);
                    $result = mysqli_stmt_get_result($stmt);
                    if (mysqli_num_rows($result) > 0) {
                        while ($row = mysqli_fetch_assoc($result)) {
                            if ($row['account_id_offer'] != $_SESSION['id'] ) {
                                echo "No es tu oferta.";
                                exit();
                            }
                        }
                    
                    }
                }   
                if (!strpos($pjs,'-')) {
                    $sth = mysqli_query($conn, 'UPDATE user SET mao_index="0" WHERE mao_index="' .$mao_index .'"');
                }else {
                    $pjarray=explode('-',$pjs);
                    for ($i=0; $i < count($pjarray) ; $i++) { 
                        $pjarray[$i] = $conn->real_escape_string($pjarray[$i]);
                        $sth = mysqli_query($conn, 'UPDATE user SET mao_index="0" WHERE mao_index="' .$mao_index.'"');
                    }
                }
                $sth = mysqli_query($conn, 'DELETE FROM mercado WHERE mao_index='.$mao_index);
                echo '0';
                
                

            }
        }
    }