<?php

	$status = (isset($_GET['status'])) ? $_GET['status'] : 'pending';
 	
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
	$conn = connect();
	$id = intval($_GET['id']);

	$curl = curl_init();

	curl_setopt_array($curl, array(
			CURLOPT_URL => 'https://api.mercadopago.com/v1/payments/' . $id,
			CURLOPT_RETURNTRANSFER => true,
			CURLOPT_ENCODING => '',
			CURLOPT_MAXREDIRS => 10,
			CURLOPT_TIMEOUT => 0,
			CURLOPT_FOLLOWLOCATION => true,
			CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
			CURLOPT_CUSTOMREQUEST => 'GET',
			CURLOPT_HTTPHEADER => array(
				'Authorization: Bearer ' . ACCESS_TOKEN
			)
	));

	$payment = json_decode(curl_exec($curl), true);

    if ($payment["status"] === "approved") {		
		        
        $amount=$payment["transaction_amount"];
        $dni=$payment["payer"]["identification"]["number"];
        $email=$payment["payer"]["email"];
        $textoStatus = "PAGO APROBADO";
        $classStatus = "alert alert-success";

        $res = sqlSelect($conn, "SELECT * FROM autopix_pendings WHERE id=? and estado=1", "s", $payment['id']);
        if($res && $res->num_rows === 0) {
            
            $account_id = intval($payment["external_reference"]);

            if ($account_id === 0) {
                echo "Acreditacion rara" , "$email acreditó $$amount desde $dni! ";
                #http_response_code(200);
                #sendEmail(ADMIN_EMAIL, "WEIRDVentas", "Acreditacion rara" , "$email acreditó $$amount desde $dni! ", true);
                return;
            }

            $res = sqlSelect($conn, "SELECT * FROM cuentas WHERE id=?", "i", $account_id);
            
            $accData = $res->fetch_assoc();

            if($res && $res->num_rows === 0) {
                http_response_code(500);
                echo 'Account inexistente';
                return;
            }

            if (sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos + ? WHERE id=?', 'ii',$amount, $account_id)){

                $mensagemStatus = 'El pago <code><small>#'.$id.'</small></code> de '.$amount.' TD$L fue confirmado! Se han acreditado en su cuenta!';   
                                                 
                $id = sqlInsert($conn, 'INSERT INTO autopix_pendings (id, account_id, amount, estado) VALUES (?, ?, ?, "1")', 'iiis', $payment['id'], $account_id,$amount);
                
                if($id === -1) {
                    http_response_code(400);
                    sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos - ? WHERE id=?', 'ii',$amount, $account_id);
                    echo 'No pude insertar la venta!';
                    return;                    
                }
                
                sendEmail($accData['email'], $accData['username'], "PAGO DE $$amount ACREDITADO" , "Hola " . $accData['username'] . "!!</br></br> Has acreditado el pago por el monto de <strong>$$amount</strong> desde el panel Premium!", true);
                
                if ($accData['email'] != ADMIN_EMAIL) sendEmail(ADMIN_EMAIL, "Ventas", $accData['username'] ." acreditó $$amount" , "El usuario " . $accData['username'] . " acreditó $$amount desde el panel Premium! ", true);

                $fecha = date('Y-m-d H:i:s');

                $res->free_result();

                $id = sqlInsert($conn, 'INSERT INTO ventas (monto, fecha,account_id) VALUES (?, ?, ?)', 'isi', $amount, $fecha,$accData['id']);
                if($id !== -1) {
                    http_response_code(200);
                    echo "Venta $id realizada!";
                }
                else {
                    http_response_code(500);
                    echo "Venta NO realizada!";
                }
                
            }else {
                echo 'No pude actualizar la cuenta';#http_response_code(500);
            }
        }else {
            echo 'Esa donación ya fue cobrada!';#http_response_code(500);
        }

    }else {
        echo 'Esa donación no existe';#http_response_code(500);
    }