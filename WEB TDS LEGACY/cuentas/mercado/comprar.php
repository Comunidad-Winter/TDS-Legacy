<?php 

 require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
 $conn = connect();
 require_logged();
 
    if (isset($_GET['pj'])) { 
        if (empty($_GET['pj'])) exit("Nick invalido");

        $multi = (strpos($_GET['pj'],'-') >  0) ? true : false ;
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, "SELECT nick FROM user WHERE account_id = ?;")) {
            echo("Error en consulta 1");
            exit();
        }
        mysqli_stmt_bind_param($stmt, "i", $_SESSION['id']);
        mysqli_stmt_execute($stmt);
        $resultpjs = mysqli_stmt_get_result($stmt);

        if ($multi) {
            
            $nick = explode('-', strtoupper($_GET['pj']), 3);
            $cleanedNicks = array();

            foreach ($nick as $value) {
                $cleanedNick = $conn->real_escape_string(clear_nick($value));
                $cleanedNicks[] = strtoupper($cleanedNick);
            }
            
            while ($rowpjs = mysqli_fetch_array($resultpjs)) {                
                foreach ($nick as $value) {
                    if (strcmp(strtoupper($rowpjs['nick']), $value) === 0) {
                        echo("No puedes comprar tu propio personaje.");
                        exit();
                    }
                }                
            }
            
            $sqlnick = $conn->real_escape_string(strtoupper($_GET['pj'])); 
            
        }else{
            $nick = clear_nick(strtoupper($_GET['pj']));
            $nick = $conn->real_escape_string($nick);  
            $sqlnick =$conn->real_escape_string($_GET['pj']);

            while ($rowpjs = mysqli_fetch_array($resultpjs)) {
                if (strcmp(strtoupper($rowpjs['nick']), $nick) === 0) {
                    echo("No puedes comprar tu propio personaje.");
                    exit();
                }
            }
        }
        
        $sql = "SELECT * FROM mercado WHERE pjs=?;";
        $stmt = mysqli_stmt_init($conn);
        
        if (!mysqli_stmt_prepare($stmt, $sql)) {
                echo 'SQL ERROR'.mysqli_stmt_error($stmt);
                exit();
        }else {    

            mysqli_stmt_bind_param($stmt, "s", $sqlnick);
            mysqli_stmt_execute($stmt);        
            $result = mysqli_stmt_get_result($stmt); 

            if (mysqli_num_rows($result) > 0) {
                $row = mysqli_fetch_assoc($result);
                }
            else 
                exit('<p class="form-tit">La publicación que deseas ver no existe.</p>');
        }

        $sql2= "SELECT * FROM user WHERE mao_index=?";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql2)) 
                exit('SQL ERROR'.mysqli_stmt_error($stmt));
        else {
            mysqli_stmt_bind_param($stmt, "i", $row['mao_index']);
            mysqli_stmt_execute($stmt);        
            $result = mysqli_stmt_get_result($stmt); 
            if (mysqli_num_rows($result) > 0) {
                $row2 = mysqli_fetch_assoc($result);
                }
            else 
                exit('<p class="form-tit">La publicación que deseas ver no existe..</p>');
        }

    }

?>

<h1>Comprar</h1><form name="form2" method="post" action="" onClick="return false" id="cuentasPremium">
<div class="campos">

    <p class="form-tit">Personajes en venta:
        <ul>
            
            <?php
                if ($multi) {
                    for ($i=0; $i < count($nick); $i++) { 
                        echo '<li><a href="?a=mercado&s=e&p='.$nick[$i].'" title="Ver estad&iacute;sticas" onclick="return verest('."'".$nick[$i]."'".')">'.$nick[$i].'</a></li>';
                    }
                }else
                    echo '<li><a href="?a=mercado&s=e&p='.$nick.'" title="Ver estad&iacute;sticas" onclick="return verest('."'".$nick."'".')">'.$nick.'</a></li>';
                
            ?>

        </ul>
    </p>

<?php 

// Comentario
if (strlen($row['comentario'])>0) echo '<p class="form-tit">El usuario dej&oacute el siguiente comentario:</p><em>'.$row['comentario'].'</em>';
 

if ($row['tipo'] == "1") {
    echo '<p class="form-tit">El usuario solicita <b>'.number_format($row['oro'], 0, ",", ".").'</b> monedas de oro. Si dispones de esa cantidad selecciona el personaje, ingresa su password y la compra será inmediata.</p><select name="pjSelect" size="5" id="pjSelect" style="width:150px;">';

    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
    if($res) { //&& $res->num_rows === 1        
        while ($pj = $res->fetch_assoc()) {
            echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
        }        
    }


echo '</select>';
}elseif($row['tipo'] == "2"){

// requisitos
if (strlen($row['requisitos'])>0) echo '<p class="form-tit">El usuario vende su personaje a cambio de uno o varios personajes que cumplan los siguientes requisitos:</p><em>'.$row['requisitos'].'</em>';

echo '<p class="form-tit">Si cumples con estos requerimientos solicitados por el vendedor seleccion&aacute; los personajes que deseas ofrecer y la password de tu cuenta y se enviar&aacute; un email al vendedor con los datos de los personajes ofrecidos y un peque&ntilde;o comentario tuyo, el vendedor tendr&aacute; la opci&oacute;n de aceptar el cambio o no durante las pr&oacute;ximas 24 horas.</p><select name="misPjs" size="5" id="misPjs" ondblclick="pasar()" style="width:150px;">';
 

    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
    if($res) { //&& $res->num_rows === 1
        while ($pj = $res->fetch_assoc()) {
            echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
        }
    }
    
echo '</select></label>
<input name="button" type="button" onClick="pasar()" value="Pasar">
<input type="button" name="Quitar" value="Quitar" onClick="quitar()" id="Quitar">
<select name="aVender" size="5" id="aVender" ondblclick="quitar()" style="width:150px;">
</select>';
}else{
    
    die("SUBASTA ANULADA");
    /*$sqlsub = "SELECT * FROM subastas WHERE mao_id=?;";
        $stmtsub = mysqli_stmt_init($conn);
 
        if (!mysqli_stmt_prepare($stmtsub, $sqlsub)) 
                exit('SQL ERROR');//.mysqli_stmt_error($stmtsub));
        else {    

            mysqli_stmt_bind_param($stmtsub, "s", $row['mao_index']);
            mysqli_stmt_execute($stmtsub);        
            $resultsub = mysqli_stmt_get_result($stmtsub); 
            if (mysqli_num_rows($resultsub) > 0) {
                $rowsub = mysqli_fetch_assoc($resultsub);
            }
        }

        $sqlofer = "SELECT * FROM subastas_ofertas WHERE subasta_id=?;";
        $stmtofer = mysqli_stmt_init($conn);
 
        if (!mysqli_stmt_prepare($stmtofer, $sqlofer)) 
                exit('SQL ERROR'.mysqli_stmt_error($stmtofer));
        else {    

            mysqli_stmt_bind_param($stmtofer, "s", $row['mao_index']);
            mysqli_stmt_execute($stmtofer);        
            //$resultofer = mysqli_stmt_get_result($stmtofer); 

            //if (mysqli_num_rows($resultofer) > 0) {
            //    $rowofer[] = mysqli_fetch_assoc($resultofer);
            //}

            $rowoffers = array(); 
            $resultoffers = mysqli_stmt_get_result($stmtofer);
            $tot=0;
            if (mysqli_num_rows($resultoffers) > 0) {
                while($rowoffer = mysqli_fetch_array($resultoffers)){
                    $tot++;
                    $rowoffers[] = $rowoffer;
                }
            }

        }

    echo '<p></p><p>Esto es una <strong>Subasta</strong>. Par participar en ella debes realizar una oferta que supere al precio actual + el monto de subida mínimo. Al realizar la oferta el oro que ofertes será retirado de tu billetera. En caso de que otro usuario realice una oferta mejor que la tuya, el oro que vos ofertaste se te acreditará en tu bóveda. Si nadie realiza una mejor oferta, al finalizar la subasta el/los personajes pasarán a ser tuyos.</p><p>Si alguien supera tu oferta te avisaremos mediante un anuncio en tu panel principal.</p><p class="form-tit">Información de la subasta:</p>
    <ul>
<li><strong>Fecha de incio:</strong> '.$rowsub['inicio'].'.</li>
<li><strong>Fecha de finalización:</strong> '.$rowsub['finalizacion'].'</li>
<li><strong>Precio actual:</strong> '.$rowsub['precioactual'].' monedas de oro.</li>
<li><strong>Subida mínima:</strong> '.$rowsub['apuestaminima'].' monedas de oro.</li>
<li><strong>Cantidad de ofertas hasta el momento:</strong> '.$tot.'.</li>
</ul>
<p class="form-tit">Seleccioná el personaje con el cual vas a ofertar:</p><select name="misPjs" size="5" id="misPjs" ondblclick="pasar()" style="width:150px;">';

$res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=?', 'i', $_SESSION['id']);
    if($res) { //&& $res->num_rows === 1
        while ($pj = $res->fetch_assoc()) {
            echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
        }
    }
echo '</select><p class="form-tit">Ingresá:</p><label for="oferta">Tu oferta</label><span class="input" style="margin-bottom:0px;"><input name="oferta" id="oferta"></span><br><br>';
 */
}
 
if ($row['candado'] == 0) {
    echo '<p><img src="/imagenes/cuentas/anunSAlert.gif" /> <strong> Importante:</strong> Esta publicaci&oacute;n no se encuentra en Modo Candado. Antes de finalizar el intercambio el usuario podr&aacute; ingresar a los personajes ofertados y causarles modificaciones.</p>';
}

?>
<br/><br/>
<label for="pass">Clave de la cuenta</label>
<span class="input" style="margin-bottom:0px;"><input name="pass" type="password" id="pass"></span><div class="clear"></div>

<?php 
    if (strlen($row['contrasena'])> 0) {
echo '<label for="passpriv">Contraseña privada</label>
<span class="input" style="margin-bottom:0px;"><input name="passpriv" type="password" id="passpriv"></span><div class="clear"></div>';}
?>
<label for="comentario">Comentario para el vendedor</label>
<span class="textarea" style="margin-bottom:0px;"><textarea name="comentario" id="comentario" cols="40" rows="5" style="overflow:auto;"></textarea></span><div class="clear"></div><p align="center">
<div class="clear"></div><input id="Submit" type="submit" name="Submit" value="Ofrecer" onClick="return comprar2('<?php  echo $_GET['pj']; ?>')" style="border:0" />
</p>
</form>
<div style="text-align:center;"><a href="#"><img src="/imagenes/volver.gif" width="136" height="27" border="0" onclick="JavaScript:seccion(5)" /></a></div>