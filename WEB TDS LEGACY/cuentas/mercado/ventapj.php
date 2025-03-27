<?php 

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();

    if (isset($_SESSION['ERRORS']['err'])) {
        echo $_SESSION['ERRORS']['err'];
        unset($_SESSION['ERRORS']['err']);
    }

?>

<form action=""  onClick="return false" method="post" name="form1" >
<h1>Vender personaje/s</h1>
<p><span class="simple">Clave PIN</span><br>
<input name="pin" type="password" id="pin">
<br />
<input name="Submit" type="submit" onClick="venderpj(1)" value="Enviar Confirmaci&oacute;n">
</p>
</form>
<a href="#"><img src="/imagenes/volver.gif" width="136" height="27" border="0"  onclick="JavaScript:seccion(7)" /></a>
