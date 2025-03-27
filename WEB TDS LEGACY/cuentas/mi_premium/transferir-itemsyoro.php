<?php                   
    
    if(isset($_GET['de'])){
        $currentNick = $_GET['de'];
    } else {
        header("Location: cpremium.php");  
        return; 
    }

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();
    
    require_logged();

         
    $sql = "SELECT nick,boveda FROM user WHERE account_id = ?";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) {
        header("Location: cpremium.php");                
        return;
    } 
    mysqli_stmt_bind_param($stmt, "i", $_SESSION['id']);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);    
    if (mysqli_num_rows($result) == 0) {        
        header("Location: cpremium.php");  
        return;            
    }
    
    $valid=false;
    $pjs = array();
    while ($row = mysqli_fetch_assoc($result)) {
        if (strtoupper($row['nick']) !== strtoupper($currentNick)) {
            $pjs[] = $row;
        }else {
            $valid=true;
            $oroenbanco= $row['boveda'];
        }        
    }    

    if (!$valid) {
        header("Location: cpremium.php");  
        return;  
    }


?><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta</title>
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

    .listbox {
  list-style-type: none;
  padding: 1px;
  margin: 1px 1px 1px;
  border: 1px solid #ccc;
  -webkit-user-select: none;
  -moz-user-select: none;     
  -ms-user-select: none;      
  user-select: none; 
  /*max-height: 200px;
  overflow-y: auto;*/
}

.listbox li {
  padding: 8px;
  cursor: pointer;
  color: #f5e3bc;
}

.listbox li:hover {
  background-color: #363636;
}

.listbox .selected {
  background-color: #007bff;
  color: #fff;
}

button {
  padding: 10px 20px;
  background-color: #4CAF50; 
  color: white;
  border: none;
  border-radius: 5px; 
  cursor: pointer; 
  transition: background-color 0.3s; 
}

button:hover {
  background-color: #45a049;
}
button:active {
  background-color: #3e8e41;
}

.custom-select {
  position: relative;
  display: inline-block;
  width: 200px;
  height: 30px; 
  background-color: #f1f1f1;
  border-radius: 5px;
  overflow: hidden; 
}

.custom-select select {
  width: 100%;
  height: 100%;
  padding: 5px 10px;
  border: none;
  background-color: transparent;
  outline: none;
  cursor: pointer;
}

.custom-select .select-arrow {
  position: absolute;
  top: 0;
  right: 0;
  width: 30px;
  height: 100%;
  background-color: #ddd;
  text-align: center;
  line-height: 30px; 
  pointer-events: none; 
}

.custom-select .select-arrow::after {
  content: '\25BC'; 
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
                <h1>Transferencia de items y oro</h1>
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

                                <li class="monedas">
                                        <b><a>Selecciona los items y oro a transferir</a></b><br>
                                        <ul class="beneficios subpen">
                                    
                                            <div class="col-sm" align="center">
                                            

                                            <div style="display: flex; justify-content: center;">
                                            
  <div style="margin-right: 20px;">
    <div id="bov">
        <h2>Tu Bóveda</h2>
        <ul id="inventory" class="listbox"></ul>
        <br><span>Cantidad</span><input type="number" min="1" max="10000" value="1" id="cantidad" placeholder="Cantidad a transferir" style="height:20px;">
        <h2>Items a transferir</h2>
        <ul id="otherinventory" class="listbox"></ul>
    </div>
  </div>

  <div>
    
    <div>
    
    <?php if ($oroenbanco>0) {?>
    <h2>Tu oro en bóveda</h2>
    <h4>Actualmente tienes <?php echo number_format($oroenbanco, 0, ',', '.'); ?> monedas de oro</h4>
    <div style="display: flex; justify-content: center;">
        <div style="margin-right: 20px;">         
        <input type="number" min="0" id="oro" placeholder="Oro a transferir" style="height:20px;">
        </div>
    </div>
    <?php }?>

        <h2>Selecciona el destino:</h2>
        <select id="destino" class="custom-select">
            <?php
            foreach ($pjs as $val) {
                echo '<option value="' . $val['nick'] . '">' . $val['nick'] . '</option>';
                
            }
        ?></select>
    </div>
         
    <div style="margin-top:40px">
        <button onclick="transferir()" >TRANSFERIR</button>
    </div>
  </div>
</div>
    
     

    <script>
        $(document).ready(function(){
            cargarLista();
        });

        function cargarLista() {
            var urlParams = new URLSearchParams(window.location.search);
            var nick = urlParams.get('de');
            $.ajax({
                type: "POST",
                url: "cuentas/obtener_items_char.php",
                data: {nick: nick},
                dataType: "json",
                success: function(data) {
                    $('#inventory').empty();
                    
                    if (data === null ) {
                        console.log("No hay items!");
                        return;
                    }
                    
                    if (data.error ) {
                        console.log(data.error);
                        $('#bov').remove();
                        return;
                    }
                    

                    data.forEach(function(item) {
                       
                        $('#inventory').append('<li item_id="' + item.item_id + '" slot="' + item.number + '" style="    padding: 0px 11px 0px;">' + item.amount + ' - ' + item.name + '</li>');
                    });
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        }

        function agregarItem() {
    var cantidad = parseInt($('#cantidad').val());
    var selected_item = $('#inventory .selected');
    var slot = selected_item.attr('slot');
    var item_id = selected_item.attr('item_id');
    var item_nombre = selected_item.text().split('-')[1].trim();
    var item_cantidad = parseInt(selected_item.text().split('-')[0].trim());
    
    if (cantidad > item_cantidad) {
        cantidad = item_cantidad;
    }

    var existing_item = $('#otherinventory li[slot="' + slot + '"]');
    if (existing_item.length > 0) {
        var existing_cantidad = parseInt(existing_item.text().split('-')[0].trim());
        existing_item.text((existing_cantidad + cantidad) + ' - ' + item_nombre);
    } else {
        if (cantidad >= 1) {
            $('#otherinventory').append('<li item_id="' + item_id + '" slot="' + slot + '" style="    padding: 0px 11px 0px;">' + cantidad + ' - ' + item_nombre + '</li>');
        }
    }

    if (cantidad >= 1) {
        if (cantidad >= item_cantidad) {
            selected_item.remove();
        } else {
            var nueva_cantidad = item_cantidad - cantidad;
            selected_item.text(nueva_cantidad + ' - ' + item_nombre);
        }
    }
}

function removerItem() {
    var cantidad = parseInt($('#cantidad').val());
    var selected_item = $('#otherinventory .selected');
    var slot = selected_item.attr('slot');
    var item_id = selected_item.attr('item_id');
    var item_nombre = selected_item.text().split('-')[1].trim();
    var item_cantidad = parseInt(selected_item.text().split('-')[0].trim());
    
    if (cantidad > item_cantidad) {
        cantidad = item_cantidad;
    }

    var existing_item = $('#inventory li[slot="' + slot + '"]');
    if (existing_item.length > 0) {
        var existing_cantidad = parseInt(existing_item.text().split('-')[0].trim());
        existing_item.text((existing_cantidad + cantidad) + ' - ' + item_nombre);
    } else {
        if (cantidad >= 1) {
            $('#inventory').append('<li item_id="' + item_id + '" slot="' + slot + '" style="    padding: 0px 11px 0px;">' + cantidad + ' - ' + item_nombre + '</li>');
        }
    }

    if (cantidad >= 1) {
        if (cantidad >= item_cantidad) {
            selected_item.remove();
        } else {
            var nueva_cantidad = item_cantidad - cantidad;
            selected_item.text(nueva_cantidad + ' - ' + item_nombre);
        }
    }
}

        function transferir() {
            var items = [];
            var selectedItems = $('#otherinventory li');
            var oro = $('#oro').val();
            var destino = $('#destino').val();
            var urlParams = new URLSearchParams(window.location.search);
            var nick = urlParams.get('de');

            selectedItems.each(function(index) {
                var slot = $(this).attr('slot');
                var item_id = $(this).attr('item_id');
                var cantidad = parseInt($(this).text().split('-')[0].trim());
                items.push({slot: slot, cantidad: cantidad, item_id: item_id});
            });

            $.ajax({
                type: "POST",
                url: "cuentas/transferir_items.php",
                data: {items: items, oro: oro, destino: destino, origen: nick},
                dataType: "json",
                success: function(data) {
                    if (data == null) {
                        return;
                    }
                    if (data.success) {
                        alert("Transferencia exitosa");
                        window.location.href = "cpremium.php";
                    } else {
                        alert("Error en la transferencia: " + data.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        }

        $('#inventory').on('click', 'li', function(){
            $(this).addClass('selected').siblings().removeClass('selected');
            agregarItem();
        });

        $('#otherinventory').on('click', 'li', function(){
            $(this).addClass('selected').siblings().removeClass('selected');
            removerItem();
        });
    </script>
                                                    
                                            </div>
                                    </li>                                    
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>