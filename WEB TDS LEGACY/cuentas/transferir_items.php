<?php                  
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    return;
    require_logged();

    if ($_SERVER['REQUEST_METHOD'] === 'POST') {

        $oro=0;
        $items = array(); // Los del banco
        $transferItems=array();  // Array de los que transfiero
        $itemsStr =""; // El string que mandaría al server
        
        if (isset($_POST['oro']) ) {
            $oro=intval($_POST['oro']);
        }
        
        if (!isset($_POST['destino']) ) {
            echo json_encode(array("error" => "ToUser not found."));
            return;
        }
        if (!isset($_POST['origen']) ) {
            echo json_encode(array("error" => "FromOrigin user not found."));
            return;
        }

        // REVISO SI EL USUARIO ORIGEN ES DE MI PERTENENCIA
        $origen = $conn->real_escape_string($_POST['origen']);
        $res = sqlSelect($conn, 'SELECT id FROM user WHERE nick=? AND account_id=? LIMIT 1', 'si', $origen,$_SESSION['id'] );
        $rowChamp = $res->fetch_assoc();        
        if ($res && $res->num_rows === 0) {
            echo json_encode(array("error" => "El personaje seleccionado no existe o no pertenece a tu cuenta!!"));
            return;
        }
        $res->free_result();

        // REVISO SI EL USUARIO POSTEADO ES DE MI PERTENENCIA
        $destino = $conn->real_escape_string($_POST['destino']);
        $res = sqlSelect($conn, 'SELECT id FROM user WHERE nick=? AND account_id=? LIMIT 1', 'si', $destino,$_SESSION['id'] );
        $rowChamp = $res->fetch_assoc();        
        if ($res && $res->num_rows === 0) {
            echo json_encode(array("error" => "El personaje seleccionado no existe o no pertenece a tu cuenta!!"));
            return;
        }
        $res->free_result();

        // REVISO DE QUE TENGA ITEMS, EN CASO DE TENER, GUARDO EN $items y OBTENGO LO POSTEADO
        $res = sqlSelect($conn, "SELECT * FROM bank_item WHERE user_id = ? LIMIT 40", 'i', $_SESSION['id'] );
        $rowBove = $res->fetch_assoc();        
        if ($res && $res->num_rows != 0) {
            
            while ($row = mysqli_fetch_assoc($res)) {
                $items[] = $row;
            }
            sort($items);
            if (isset($_POST['items']) ) {          
                $transferItems = $_POST['items'];
                sort($transferItems);
                #foreach ($transferItems as $item) {                    
                #    if ($slot >= 0 && $slot < 40) {                                           
                #        $items[$slot]['amount'] = min($cantidad, $items[$slot]['amount']);                         
                #    }       
                #}
                
                foreach($transferItems as $result) {
                    if ($result['item_id'] > 0) {
                        if ($result['cantidad'] > $items[$result['slot'] - 1]['amount'] && $result['item_id'] == $items[$result['slot'] - 1]['item_id']) {                
                            $result['cantidad'] = $items[$result['slot'] - 1]['amount'];                
                        }
                        
                        $itemsStr .=  $result['slot'] . '-' . $result['cantidad'] . '#';

                        #echo $result['slot'] . "-" . $result['cantidad'] . "-" . $result['item_id'] . '###';           
                        #echo $items[$result['slot']-1]['number'] . "-" . $items[$result['slot']-1]['amount'] . "-" .  $items[$result['slot']-1]['item_id']  . '<br>';                
                    }
                }

                if (strlen($itemsStr)>0) 
                    $itemsStr = rtrim($itemsStr, '#');

            }
            $res->free_result();

        }

        $numItems=count($transferItems);

        if ($numItems == 0 && $oro == 0) {
            echo json_encode(array("error" => "Debes enviar algo!"));
            return; // ÉSTE MUCHACHO NO POSTEÓ UN CULO.
        }
        
        

        $line = "|11|". $ip ."|". $_SESSION['username'] ."|". $_SESSION['password'] ."|". $_SESSION['pin'] .'|'.  $origen .'|'. $destino .'|'. $oro .'|'. $numItems .'|'. $itemsStr;
		
        $server= bserver_getdata($line,$data);
    
        if (!$server) {
            echo json_encode(array("error" => "Servidor offline!"));
            exit();
        }
          
        if ($data[0] == "0") {
            echo json_encode(array("success" => "Transferencia realizada!"));
            
        } else{
            switch ($data) {
                case 1:
                    $ErrStr= '¡No es tu cuenta!';
                    break;
                case 2:
                    $ErrStr= '¡Nombre invalido del personaje!';
                    break;
                case 3:
                    $ErrStr= '¡El personaje no existe!';
                    break;
                case 4:
                    $ErrStr= '¡El personaje está baneado!';
                    break;
                case 5:
                    $ErrStr= '¡El personaje no te pertenece!';
                    break;
                case 6:
                    $ErrStr= '¡Debes enviar al menos 1 item o al menos 1 de oro!';
                    break;
                case 7:
                    $ErrStr= '¡Solicitud inválida! Chitero';
                    break;
                case 8:
                    $ErrStr= '¡No podes enviarle a tu propio personaje!';
                    break;
                case 9:
                    $ErrStr= '¡No tenes el oro suficiente!';
                    break;
                case 10:
                    $ErrStr= '¡No tenes la cantidad suficiente de items!';
                    break;
                case 11:
                    $ErrStr= '¡El personaje no tiene espacio en su boveda!';
                    break;
                default:
                    $ErrStr= "Error - $data";
                    break;						
                }
            echo json_encode(array("error" => $ErrStr));
        }

    }else {
        echo json_encode(array("error" => "Invalid request method or missing parameters."));
    }
    