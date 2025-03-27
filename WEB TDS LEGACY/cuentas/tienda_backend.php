<?php

$fecha =date("Y-m-d");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php';     
    require_logged();
    $conn = connect();

    $sql = "SELECT * FROM productos WHERE addtimepremium = 0";
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
                "adhonorem" => $row["adhonorem"],
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
    if(isset($data['productId']) && isset($data['pjSeleccionado'])) {
        
        ########### VAR ###########
        $productId = intval($data['productId']);
        $pjSeleccionado = $data['pjSeleccionado'];


        ########### PROD VALIDATION ###########
        $sql = "SELECT * FROM productos WHERE id=?";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo json_encode(array("error" => "No se pudo preparar la consulta sobre los productos a la base de datoides."));
            return;
        }    
        mysqli_stmt_bind_param($stmt, "i", $productId);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);    
        $productos = array();
        if (mysqli_num_rows($result) == 0) {       
            
            echo json_encode(['error' => "Producto no encontrado"]);
            return;            
        }     
        $row = mysqli_fetch_assoc($result);
        if ($row["addtimepremium"] != 0) {
            echo json_encode(array("error" => "Elegiste un producto inválido. -UN ADMIN HA SIDO NOTIFICADO-"));
            return;
        }
        $tdspesos=get_tdspesos();

        if ($row["precio"] > $tdspesos) {
            echo json_encode(array("error" => "No tienes la cantidad de TD$ suficientes"));
            return;
        }

        $adhonorem=0;

        if ($row["adhonorem"] == 1 && $row["precio"] == 0 ) {       

            if (!isset($data['adhonorem'])){
                echo json_encode(array("error" => "Hubo un error al generar la solicitud!"));
                return;
            }

            $monto=intval($data['adhonorem']);
            $adhonorem=1;

            if ($monto > $tdspesos) {
                echo json_encode(array("error" => "No tienes la cantidad de TD$ suficientes"));
                return;
            }
                
            http_response_code(200);
                   
            
            if (sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos-? WHERE id=?', 'ii', $monto, $_SESSION['id'])) {
                $mailstring="<strong>Hola!</strong><br><br>Has donado $$monto!<br>Muchas gracias por colaborar con el equipo de TDS Legacy!<br>";	

                sendEmail($_SESSION["email"], "Cuenta Premium", "¡Donación realizada correctamente!", $mailstring);

                if ($_SESSION["email"] != ADMIN_EMAIL ) sendEmail(ADMIN_EMAIL, "Cuenta Premium", $_SESSION['username'] .' donó $' . $monto, $mailstring);
                
                $sql = "INSERT INTO donaciones (monto, fecha,account_id,adhonorem) VALUES (?, ?, ?,?)";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {
                    echo json_encode(array("error" => "No se pudo preparar la consulta para insertar la donación/compra."));
                    return;
                }
                mysqli_stmt_bind_param($stmt, "isii", $monto, $fecha,$_SESSION['id'],$adhonorem);
                if (mysqli_stmt_execute($stmt)) {
                    echo json_encode(array("message" => "Donación registrada exitosamente"));
                } else {
                    echo json_encode(array("error" => "Error al registrar la donación/compra"));
                }
            }else {
                echo json_encode(array("error" => "Error al actualizar la base de datos, contacta con un Administrador!!"));
            }
             
            
            return;

            
        }
        ########### // PROD VALIDATION ###########


        ########### CHAR VALIDATION ###########

        if (empty($pjSeleccionado)) {
            echo json_encode(array("error" => "Debes escribir el nombre del personaje al que quieres darle el beneficio."));
            return;
        }    

        $sql = "SELECT * FROM user WHERE nick=?";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) {
            echo json_encode(array("error" => "No se pudo preparar la consulta sobre el char a la base de datoides."));
            return;
        }    
        mysqli_stmt_bind_param($stmt, "s", $pjSeleccionado);
        mysqli_stmt_execute($stmt);
        $resultPj = mysqli_stmt_get_result($stmt);            
        if (mysqli_num_rows($result) == 0) {     
            echo json_encode(['error' => "Personaje no encontrado"]);
            return;            
        }
        $rowPj = mysqli_fetch_assoc($resultPj);
        if ($rowPj["account_id"] > 0) {
            if ($_SESSION["id"] != $rowPj["account_id"] ) {
                echo json_encode(array("error" => "El personaje seleccionado no te pertenece. -UN ADMIN HA SIDO NOTIFICADO-"));
                return;
            }
        }                
        ########### // CHAR VALIDATION ###########


        $data="";
        $line = "|18|". $ip ."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'. $pjSeleccionado.'|'.$productId;                
       
        $server= bserver_getdata($line,$data);
    
        if (!$server) {
            echo "Server off";
            http_response_code(201);
            return;
        }

        switch ($data[0]) {
            case 0:                           
                break;
            case 1:
                echo json_encode(array("error" => 'Nick invalido'));
                exit();
            case 2:
                echo json_encode(array("error" => 'No existe ese personaje'));
                exit();
            case 3:
                echo json_encode(array("error" => 'El personaje se encuentra baneado!'));
                exit();
            case 4:
                echo json_encode(array("error" => '¡Datos incorrectos de la cuenta o no te pertenece!'));
                exit();
            case 5:
                echo json_encode(array("error" => 'El personaje no tiene espacio en su bóveda!'));
                exit();            
            default:
                echo json_encode(array("error" => 'Error desconocido - Notifique al GM'));
                exit();
        }
        
        if (sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos-? WHERE id=?', 'ii', $row["precio"], $_SESSION['id'])) {
            ########### LOGIC ###########        

            $mailstring="<strong>Hola!</strong><br><br>Has comprado 1 " .$row["nombre"]  ."!<br>Este objeto estará en la boveda del personaje que haz seleccionado.<br> Muchas gracias por colaborar con el equipo de TDS Legacy<br>";	

            sendEmail($_SESSION["email"], "Cuenta Premium", "¡Compra realizada correctamente!", $mailstring);

            if ($_SESSION["email"] != ADMIN_EMAIL ) sendEmail(ADMIN_EMAIL, "Cuenta Premium", $_SESSION['username'] .' compro 1 ' . $row["nombre"] . ' por  '.$row["precio"]. " en el personaje: $pjSeleccionado", $mailstring);

            $sql = "INSERT INTO ventas (monto, fecha,account_id) VALUES (?, ?, ?)";
            $stmt = mysqli_stmt_init($conn);
            if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo json_encode(array("error" => "No se pudo preparar la consulta para insertar la donación/compra."));
                return;
            }
            mysqli_stmt_bind_param($stmt, "isi", $row["precio"], $fecha,$_SESSION['id']);
            if (mysqli_stmt_execute($stmt)) {
                echo json_encode(['message' => 'Compra registrada exitosamente']);
            } else {
                echo json_encode(array("error" => "Error al registrar la compra"));
            }
        }else {
            echo json_encode(array("error" => "Error al actualizar la base de datos, contacta con un Administrador!!"));
        }
                    
    } else {
        
        http_response_code(400);
        echo json_encode(['error' => "ID de producto no proporcionado"]);
    }
    
}
