<?php                   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    require_logged();

    include_once $_SERVER['DOCUMENT_ROOT']. "/vendor/autoload.php";
    $id =0;

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['monto'])) {
        
        $url= TDS_URL;

        #if (server_on() == true) {
            MercadoPago\SDK::setAccessToken(ACCESS_TOKEN);
            $monto = round(floatval($_POST['monto']));
            $preference = new MercadoPago\Preference();
            $preference->back_urls = array(
                "success" => TDS_URL ."/cpremium.php?a=agregar-tdsl&action=success",
                "failure" => TDS_URL ."/cpremium.php?a=agregar-tdsl&action=failure",
                "pending" => TDS_URL ."/cpremium.php?a=agregar-tdsl&action=pending"
            );
            $preference->binary_mode = true;    
            
            #$notification_url->  $url."/cpremium.php?a=agregar-tdsl&action=pending";

            $preference->external_reference = $_SESSION["id"];
            $preference->auto_return = "approved";
            $preference->binary_mode = true;             
            $item = new MercadoPago\Item();
            $item->title = "Acreditar puntos";
            $item->quantity = 1;
            $item->currency_id = "ARS";
            $payer = new MercadoPago\Payer();
            $payer->email = $_SESSION["email"];
            $preference->payer = $payer;
            $item->unit_price = $monto;
            $preference->items = [$item];
            $preference->save();
        #}    
    
    }else {
        goto asd;
        $status = (isset($_GET['status'])) ? $_GET['status'] : 'pending';
        if (isset($_GET['payment_id']) && isset($_GET['action']) ) {
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
                        $amount=$payment["transaction_amount"];
                        $dni=$payment["payer"]["identification"]["number"];
                        $email=$payment["payer"]["email"];
                        $textoStatus = "PAGO APROBADO";
                        $classStatus = "alert alert-success";
 
                        $res = sqlSelect($conn, "SELECT * FROM autopix_pendings WHERE id=? and estado=1", "s", $payment['id']);
				        if($res && $res->num_rows === 0) {
                            
                            $account_id = $payment["external_reference"];

                            if (sqlUpdate($conn, 'UPDATE cuentas SET tdspesos=tdspesos + ? WHERE id=?', 'ii',$amount, $account_id)){

                                $mensagemStatus = 'El pago <code><small>#'.$id.'</small></code> de '.$amount.' AO$I fue confirmado! Se han acreditado en su cuenta!';   
                                                               
                                $insertSql = "INSERT INTO autopix_pendings (id, account_id, estado, amount, ip) VALUES ('" . $payment['id'] . "', '" . $account_id . "', '1', '$amount', '$ip');";
                                
                                sendEmail($_SESSION['email'], $_SESSION['username'], "PAGO DE $$amount ACREDITADO" , "Hola " . $_SESSION['username'] . "!!</br></br> Has acreditado el pago por el monto de <strong>$$amount</strong> desde el panel Premium!", true);

                                sendEmail(ADMIN_EMAIL, "Ventas", $_SESSION['username'] ." acreditó $$amount" , "El usuario " . $_SESSION['username'] . " acreditó $$amount desde el panel Premium! ", true);

                                $fecha = date('Y-m-d H:i:s');

                                $sql = "INSERT INTO ventas (monto, fecha,account_id) VALUES (?, ?, ?)";
                                $stmt = mysqli_stmt_init($conn);
                                if (!mysqli_stmt_prepare($stmt, $sql)) {
                                    $mensagemStatus = "No se pudo preparar la consulta para insertar la donación/compra.";
                                }else {
                                    mysqli_stmt_bind_param($stmt, "isi", $amount, $fecha,$_SESSION['id']);
                                    if (mysqli_stmt_execute($stmt)) {
                                        #$mensagemStatus = "Donación registrada exitosamente";
                                    } else {
                                        $mensagemStatus = "Error al registrar la compra, contacta con un Administrador!";
                                    }
                                }
                                
                                if ($conn->query($insertSql)) {
                                #    $conn->close();
                                    //http_response_code(201);
                                } else {
                                    http_response_code(500);
                                # $conn->close();
                                }  
                            }else {
                                $mensagemStatus="Hubo un error al actualizar la base de datos, contacta con un Administrador!";
                            }
                        }else {
                            #header("Location: /cpremium.php?a=mi-premium");
                            $mensagemStatus="Ya has acreditado éste pago!";
                        }
                        
                    }                    
                    break;
                case "pending":
                    $textoStatus = "PAGO PENDIENTE";
                    $classStatus = "alert alert-warning";
                    $mensagemStatus = 'Pago <code><small>#'.$id.'</small></code> pendiente. Para acreditar los puntos escriba el codigo de referencia en la cuenta, y si está acreditado se le sumarán los AO$I.';
                    break;

            }
        }

    }

    asd:

?><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>AO Legacy - Cuenta</title>
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/caja.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="/encuestas.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/cuentas/encuestas/encuestas.js"></script>
    <script type="text/javascript" src="/comun/js/jquery-min.js"></script>
    <style type="text/css">
    .subpen li {
        height: 16px;
        padding-bottom: 2px;
    }

    .anuevo {
        color: #0f5;
    }
    </style>
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;">
                    <span style="display: inline-block; height: 100%; vertical-align: middle;"></span>
                    <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%">
                </div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
            <div class="titulo_seccion">
                <h1>Agregar puntos AO$I</h1>
            </div>
            <div id="main">
                <div id="panel-premium">
                    <div class="cuentas_premium" style="text-align:left;">
                        <div class="tit">
                            <h1>Panel de <?php echo $_SESSION['username'] ?></h1>
                            <?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
                        </div>
                        <div id="centro_panel">
                            <div class="izq" style="width: 500px;">
                                <ul class="beneficios">
                                <li><b>Información de cuenta:</b>
                                
                                <?php        
                      $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
                      $seconds_diff = $ts2 - $ts1;

                      if ($seconds_diff <= 0) {
                        echo '<p></p><table cellpadding="0" cellspacing="0" border="0" style="width:480px;" align="center" id="alerta"><tbody><tr><td id="alerta_critico"><img src="/imagenes/cuentas/alerta_critico.gif" alt=""><p>¡Alerta! Tu Cuenta Premium está vencida. Para poder disfrutar de todos los beneficios exclusivos debes adquirir tiempo haciendo click <a href="?a=adquirirtiempo" title="¡Adquirí más tiempo para tu Premium!">aquí</a>.</p></td></tr></tbody></table><br>';}else echo '<p>Tu premium vence el día: ' .$_SESSION['premium_at'] .'<br>' ; {
                      }?>Última conexión:
                      <?php echo date("d-m-Y h:i:s", strtotime($_SESSION['last_login_at']));?>
                      <br>Saldo actual: $ <?php echo get_tdspesos();?></li>
                                <li class="monedas">
                                        <b><a>Cargar puntos AO$I</a></b><br>
                                        <ul class="beneficios subpen">
                                    
                                        <?php if ($id) {?>

                                            <div class="col-sm" align="center">
                                                    <h4>AO Legacy | STATUS</h4>
                                                <hr>
                                                    <div><?php echo $textoStatus;?></div>
                                                    <hr>
                                                    <div class='<?php echo $classStatus;?>'><?php echo $mensagemStatus;?></div>
                                                    <p align="right"><a href="/cpremium.php?a=mi-premium" class="btn btn-outline-primary btn-lg">Volver al inicio</a></p>
                                                    <hr>
                                                </div>
                                            </div>

                                        <?php } else {require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
                                    
                                    if (!isset($preference) && server_on() == true){ ?>       
                                    
                                        <form action="" method="POST">
                                        <label for="monto">Monto a pagar:</label>
                                        <input type="number" step="1.00" name="monto" id="monto" required>
                                        <input type="submit" value="Generar Botón de Pago">
                                    </form>
                                    <?php }elseif (server_on() == false) echo 'Servidor offline, no se puede realizar donaciones.';  ?>
                                    
                                    <?php if (isset($preference)): ?>
                                        <script type="text/javascript" src="https://secure.mlstatic.com/mptools/render.js"></script>
                                        <form action="<?php echo $preference->init_point; ?>" method="POST">
                                        <input type="submit" value="Pagar con MercadoPago">
                                    </form>
                                    <?php endif;} ?>
                                    </li>                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>