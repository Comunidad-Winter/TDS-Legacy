<?php
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();

    if (!isset($_POST['pin'])) exit();

    $_SESSION['pin_posted'] = trim($_POST['pin']);

    if ($_SESSION['pin'] !== $_POST['pin']){
        echo '<p class="negritaError">La clave PIN ingresada no es correcta. </p>';
        include('ventapj.php');
        exit();
    }

    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=? AND mao_index=0', 'i', $_SESSION['id']);
    if($res&& $res->num_rows === 0) { //
        $pj = $res->fetch_assoc();
        echo '<h1>No hay personajes disponibles</h1><div id="panel-premium">Tus personajes ya están publicados o no tenés ningún personaje adherido a tu cuenta!! </br>Para agregar un personaje haz click en <a href="/cpremium.php?a=agregar-personaje" id="Submit">Agregar Personaje</a>.</div>';
        exit();
    }elseif (!$res) {
        echo '<h1>Vender Personaje/s</h1><div id="panel-premium">Hubo un error al obtener la lista de personajes.</div>';
        exit();
    }

    $_SESSION['tmpcodigo']=substr(str_shuffle(str_repeat($x='0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(6/strlen($x)) )),1,6);

    //include($_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/ventapj_sendmail.php');
    
    $premium=false;

    if (isset($_SESSION['premium_at'])) {
        $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
        $seconds_diff = $ts2 - $ts1;if ($seconds_diff > 0)$premium=true;
    }
    
?>

<form action="#" method="post" onsubmit="return false" name="form1" id="cuentasPremium">
<div class="campos">
<fieldset>
<p class="form-tit">Se ha enviado un e-mail al correo de la cuenta, revisa tu casilla para copiar el código de confirmación.</p>
<label for="confirmacion">Confirmación:</label><span class="input" style="margin-bottom:0px;">
<input name="confirmacion" type="text" id="confirmacion" value="<?php echo $_SESSION['tmpcodigo']; ?>"></span><div class="clear"></div>
</fieldset>
<fieldset>
<p class="form-tit">Personajes:</p>
<table width="441" border="0">
<tbody><tr>
<td width="270"><span style="font-style: italic">(tus personajes)</span></td>
<td width="161"><span style="font-style: italic">(personajes a publicar)</span></td>
</tr>
</tbody></table>
<select name="misPjs" size="5" id="misPjs" ondblclick="pasar()" style="width:150px;">

<?php
    $res = sqlSelect($conn, 'SELECT nick FROM user WHERE account_id=? AND mao_index=0', 'i', $_SESSION['id']);

    if($res && $res->num_rows > 0) { //&& $res->num_rows === 1
        while ($pj = $res->fetch_assoc()) {
            echo '<option value="' . $pj['nick'] . '">' . $pj['nick'] . '</option>';
        }
    }

?>

</select>
<input name="button" type="button" onclick="pasar()" value="Pasar">
<input type="button" name="Quitar" value="Quitar" onclick="quitar()" id="Quitar">
<select name="aVender" size="5" id="aVender" ondblclick="quitar()" style="width:150px;">
</select>
<p class="simple" id="precio_publicacicon" style="display:none"><strong>IMPORTANTE:</strong> Para publicar este personaje deberás <strong>pagar monedas de oro</strong>. Estas deben estar en tu bóveda y serán retiradas cuando se haga la publicación.</p><p>
</p></fieldset>
<fieldset>
<p class="form-tit">Seleccioná el modo:</p>
<table width="527" border="0" style="left:0">
<tbody><tr>
<td width="143" height="25"><label for="rb1"><input name="rb" type="radio" value="1" checked="" id="rb1" onclick="cambiar(1)">
Venta por oro </label></td>
<td width="374" rowspan="4" align="left" valign="top">
<div align="left"><span id="ccambio" style="display:none;">
<span>Poné los requerimientos que buscás:</span>
<span class="textarea" style="margin-bottom:0px;">
<textarea name="pedido" cols="40" rows="4" id="pedido"></textarea>
</span>
</span>

<span id="cmoneda">
    <span>Ingresá la cantidad de oro que pides para vender el personaje. Max: 50.000.000<br></span>
    <span class="input" style="margin-bottom:0px;">
        <input name="monedas" type="text" id="monedas" value="0" size="17" maxlength="10">
    </span>
    <br><br>
   <!--<span>Escribí el personaje que recibirá el oro:</span>
    <span class="input" style="margin-bottom:0px;">
        <input name="deposito" type="text" id="deposito" maxlength="20">
    </span>-->
</span> 

<div style="display:none;text-align:left;" id="subastaform">
Fecha de finalización:
<select name="fechaFin" id="fechaFin">
    <?php 
    for ($i=1; $i <= 5; $i++) {         
        echo '<option value="'.date("d-m-Y", time()+(86400* $i)).'">' .date("d-m-Y", time()+(86400* $i)).'</option>';
    }
    ?>
</select>

a las <select name="hora" id="label3"><option value="00">00</option><option value="01">01</option><option value="03">02</option><option value="05">04</option><option value="06">06</option><option value="07">07</option><option value="08">08</option><option value="09">09</option><option value="10">10</option><option value="12">11</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option><option value="21">21</option><option value="22">22</option><option value="23">23</option></select> horas<br>
Precio inicial:<br>
<span class="input" style="margin-bottom:0px;"><input name="precioInicial" type="text" id="label" maxlength="8"></span>
<br><br>Subida mínima:<br>
<span class="input" style="margin-bottom:0px;"><input name="subidaMinima" type="text" id="subidaMinima" maxlength="8"></span>
<br><br>
<!--Personaje que recibirá el oro:<br>
<span class="input" style="margin-bottom:0px;"><input name="depositos" type="text" id="depositos" maxlength="20"></span>
<br><br>-->
<input type="checkbox" name="avisarme" value="checkbox" id="avisarme">Avisarme cuando alguien me oferte
</div>
</div></td>
</tr>
<tr>
<td height="25" width="143"><label for="rb2"><input name="rb" type="radio" value="2" id="rb2" onclick="cambiar(2)">Intercambio de personajes</label></td>
</tr>
</tbody></table>
</fieldset>
<fieldset>
<p class="form-tit">Completá:</p>
<label for="textarea2">Comentarios extra de tu personaje:</label><span class="textarea" style="margin-bottom:0px;"><textarea name="tcoment" cols="40" rows="4" id="textarea2"></textarea></span><div class="clear"></div>
<label for="passpriv">&nbsp;</label><small>(dejar en blanco si se quiere hacer pública la venta) </small><div class="clear"></div>
<label for="passpriv">Contraseña de venta:</label><span class="input" style="margin-bottom:0px;"><input name="passpriv" type="password" id="passpriv"></span><div class="clear"></div>
</fieldset>

<fieldset>
<p class="form-tit">Modo candado</p>
<span>Sí activás esta opción no podrás entrar al personaje hasta que sea vendido o lo retires del comercio</span>.<br>
<label for="mc"><input name="mc" type="checkbox" id="mc" value="1">
<span class="simple">Activado</span></label>
</fieldset>
 
<div class="clear"></div><p class="form-tit">Comentarios</p>
Si lo permites otros usuarios podrán comentar esta publicación. Vos podrás eliminar los comentarios que te parezcan inapropiados o reportarlos para que un moderador los revise, los elimine y pene al infractor.<br>
<label for="permitirComentarios">
<input name="permitirComentarios" type="checkbox" id="permitirComentarios" <?php if (!$premium) echo 'disabled="disabled"'; ?> value="1" checked="checked">
<span class="simple">Permitir <?php if(!$premium)echo '(opcional sólo para premium)'; ?></span>
</label>

<div class="clear"></div>
<input name="Submit" id="Submit" type="submit" onclick="venderpj(2)" value="Publicar Venta" style="border:0;">
</div>
</form>