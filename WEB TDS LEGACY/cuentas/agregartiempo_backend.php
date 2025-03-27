<?php


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php';     
    require_logged();
    $conn = connect();
    $sql = "SELECT * FROM productos WHERE addtimepremium > 0";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        echo json_encode(array("error" => "No se pudo preparar la consulta."));
        return;
    }    
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);    
    $productos = array();
    if (mysqli_num_rows($result) > 0) {        
        while ($row = mysqli_fetch_assoc($result)) {
            $producto = array(
                "id" => $row["id"],
                "nombre" => $row["nombre"],
                "precio" => $row["precio"],
                "descripcion" => $row["descripcion"],
                "imagen" => $row["imagen"]
            );
            $productos[] = $producto;
        }        
        echo json_encode($productos);
        return;
    } else {
        echo json_encode(array("mensaje" => "No se encontraron productos."));
        return;
    } 
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php';     
    require_logged();
    $conn = connect();
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);
    if(isset($data['productId'])) {
        
        http_response_code(200);

        $productId = intval($data['productId']);

        $sql = "SELECT * FROM productos WHERE id=?";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo json_encode(array("error" => "No se pudo preparar la consulta a la base de datoides."));
            return;
        }    
        mysqli_stmt_bind_param($stmt, "i", $productId);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);    
        $productos = array();
        if (mysqli_num_rows($result) == 0) {        
            http_response_code(400);
            echo json_encode(['error' => "Producto no encontrado"]);
            return;            
        }     

        $row = mysqli_fetch_assoc($result);

        if ($row["addtimepremium"] == 0) {
            echo json_encode(array("error" => "Elegiste un producto inválido. -UN ADMIN HA SIDO NOTIFICADO-"));
            return;
        }
        $tdspesos=get_tdspesos();

        if ($row["precio"] > $tdspesos) {
            echo json_encode(array("error" => "No tienes la cantidad de TD$ suficientes"));
            return;
        }

        $days=$row["addtimepremium"];

        $currentDate = date('Y-m-d H:i:s');
        $expirationDate = $_SESSION['premium_at'];

        if ($expirationDate < $currentDate || empty($expirationDate)) {
            $extendedExpirationDate = date('Y-m-d H:i:s', strtotime("$currentDate +$days days"));
        } else {
            $extendedExpirationDate = date('Y-m-d H:i:s', strtotime("$expirationDate +$days days"));
        }
        
        if (sqlUpdate($conn, 'UPDATE cuentas SET premium_at=?, tdspesos=tdspesos-? WHERE id=?', 'sii', $extendedExpirationDate, $row["precio"], $_SESSION['id'])) {
            echo json_encode(['message' => 'Compra procesada exitosamente']);
        
            $mailstring="<strong>Hola!</strong><br><br>Has acreditado $days dias en tu Cuenta Premium! Muchas gracias por colaborar con el equipo de TDS Legacy<br>";	

            if ($_SESSION["email"] != ADMIN_EMAIL) {
                sendEmail(ADMIN_EMAIL, "Cuenta Premium", $_SESSION['username'] .' adquirio tiempo premium por ' . $days .' dias', $mailstring);
            }

            sendEmail($_SESSION["email"], "Cuenta Premium", "¡Has acreditado tiempo en tu cuenta premium!", $mailstring);
            
            $_SESSION['premium_at']=$extendedExpirationDate;
        }else {
            echo json_encode(['error' => "No se pudo actualizar la base de datos, contacta con un Administrador!"]);
        }
        
            
    } else {
        
        http_response_code(400);
        echo json_encode(['error' => "ID de producto no proporcionado"]);
    }
    
}
