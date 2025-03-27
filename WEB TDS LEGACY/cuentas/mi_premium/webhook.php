<?php

	$status = (isset($_GET['status'])) ? $_GET['status'] : 'pending';
 	
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
	$conn = connect();
	$id = intval($_GET['payment_id']);

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
	 
	$textoStatus = "PAGO RECHAZADO O INEXISTENTE";
	$classStatus = "alert alert-danger";
	$mensagemStatus = "Su pago fue rechazado o es inexistente. Intente nuevamente.";

	switch($status){
		case "success": case "approved":
			
			if ($payment["status"] === "approved") {		
				
				$ip=$payment["additional_info"]["ip_address"];
				$ip=$payment["additional_info"]["ip_address"];
				$amount=$payment["transaction_amount"];
				$dni=$payment["payer"]["identification"]["number"];
				$email=$payment["payer"]["email"];
				$account_id = $payment["external_reference"];

				$textoStatus = "PAGO APROBADO";
				$classStatus = "alert alert-success";

				if (intval($account_id) > 0 ) {
					sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos + ? WHERE id=?', 'ii',$amount, $payment['external_reference']);

					$mensagemStatus = 'El pago <code><small>#'.$id.'</small></code> de '.$amount.' TD$L fue confirmado! Se han acreditado en su cuenta!';
					
					$insertSql = "INSERT INTO autopix_pendings (id, account_id, estado, amount, ip) " 
							. "VALUES ('" . $id . "', '" . $account_id . "', '1', $amount, $ip);";
					 
					if ($conn->query($insertSql)) {
						$conn->close();
						//http_response_code(201);
					} else {
						//http_response_code(500);
						$conn->close();
					} 
				}
				
				
			}
			
			break;

		case "pending":
			$textoStatus = "PAGO PENDENTE";
			$classStatus = "alert alert-warning";
			$mensagemStatus = 'Pago <code><small>#'.$id.'</small></code> pendiente. Para acreditar los puntos escriba el codigo de referencia en la cuenta, y si está acreditado se le sumarán los TD$L.';
			break;

	}

?><div class="col-sm" align="center">
	    <h4>TDS Legacy | STATUS</h4>
	<hr>
	    <div><?php echo $textoStatus;?></div>
	    <hr>
	    <div class='<?php echo $classStatus;?>'><?php echo $mensagemStatus;?></div>
	    <p align="right"><a href="/cpremium.php?a=mi-premium" class="btn btn-outline-primary btn-lg">Volver al inicio</a></p>
	    <hr>
	</div>
</div>