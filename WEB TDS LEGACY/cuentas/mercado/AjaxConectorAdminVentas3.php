<?php 

    // cancelarOfrecimiento

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    $conn = connect();
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
   
    if (!isset($_POST['id'])) die('Muy mal!');

    $offer_id=intval($_POST['id']);

    /*
    $line = "|11|". $ip ."|". $_SESSION['id'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'. $offer_id;
    $data="";
    $server= bserver_getdata($line,$data);
            
    if (!$server) {
        echo "Server off";
        exit();
    }
    if ($data[0]=="|") {
        #'ta todo bien.'
    }else {
        switch ($data) {
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
                echo '¡No te pertenece';
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
                echo "Error desconocido";
                exit();
        }
    } 
    */

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
        }else {
            echo 'No existe esa oferta.';
            exit();
        }
    }    

    $stmt = mysqli_stmt_init($conn);    
    if (mysqli_stmt_prepare($stmt, "DELETE FROM mercado_ofertas WHERE offer_id=?")){
        mysqli_stmt_bind_param($stmt, "i", $offer_id);
        mysqli_stmt_execute($stmt);
    }
       
    $stmt = mysqli_stmt_init($conn);
    if (mysqli_stmt_prepare($stmt, "DELETE FROM anuncios WHERE mao_anun=?")){
        mysqli_stmt_bind_param($stmt, "i", $offer_id);
        mysqli_stmt_execute($stmt);
    }
    echo 0;

