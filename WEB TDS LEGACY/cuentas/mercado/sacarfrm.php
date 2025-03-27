<?php     
   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();?>

<h2>Tus publicaciones</h2>
<?php     
   
    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();

    $sql = "SELECT * FROM mercado WHERE account_id=?";
    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) exit("No puedo setear la consulta! No estás logueado");
    mysqli_stmt_bind_param($stmt, "i", $_SESSION['id']);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);
    $id=0;
    $tot=0;
    $str="";

    while ($row = mysqli_fetch_assoc($result)) {
        
        $tot++;
        if ($row['tipo'] == 2) {
            $tipo_text = "Intercambio";
        } elseif ($row['tipo'] == 1) {
            $tipo_text = '<img src="/imagenes/cuentas/monedas.gif"> ' . number_format($row['oro'], 0, ",", ".");
        } else {
            $tipo_text = "Subasta";
        }
        $password="";
        if (strlen($row['contrasena'])>0) {
            $password='<img src="/imagenes/llave.png">';
        }
        $str.= '<tr id="fila'.$id.'">
                    <td align="left">'.$row['pjs'].'</td><td align="left">'.$tipo_text.'</td><td align="center">'.$password.'</td>
                <td id="boton'.$id.'">
                    <a title="Quita de la lista de ventas y cancela todos los intercambios posibles de esta publicacion" href="#" onclick="return quitarVenta(' .$row['mao_index'] . "," .$id.');">(Quitar)</a>
                </td>
            </tr>';
        $id++;
    }
    
    if ($tot==0) {
        echo '<p>No tienes ninguna publicaci&oacute;n.</p>';
    }else{
        echo '<table id="tabla_publicaciones" name="tabla_publicaciones" width="500" border="0"><tbody>
        <tr>
            <td align="left" width="150"><strong>Personajes</strong></td>
            <td align="left" width="90"><strong>Tipo de venta</strong></td>
            <td align="right" width="30"><strong></strong></td>
            <td align="center" width="60"></td>
        </tr>
        '.$str.'</tbody></table>';
    }

    $sql = "SELECT * FROM mercado_ofertas WHERE account_id_offer=?";

    $stmt = mysqli_stmt_init($conn);
    if (!mysqli_stmt_prepare($stmt, $sql)) die('param');
    mysqli_stmt_bind_param($stmt, "i", $_SESSION['id']);
    mysqli_stmt_execute($stmt);
    $resultoffer = mysqli_stmt_get_result($stmt);
    $tot=0;
    $str="";

    while ($rowoffer = mysqli_fetch_assoc($resultoffer)) {
        $tot++;

        $sql = "SELECT * FROM mercado WHERE mao_index=?";
        $stmt = mysqli_stmt_init($conn);
        if (!mysqli_stmt_prepare($stmt, $sql)) die(mysqli_stmt_error($stmt));
        mysqli_stmt_bind_param($stmt, "i", $rowoffer['mao_index']);
        mysqli_stmt_execute($stmt);
        $result = mysqli_stmt_get_result($stmt);
        $nick ="-";

        if ($rowmao = mysqli_fetch_assoc($result)) {
            $nick=$rowmao['pjs'];
        }
        if ($rowoffer['aceptada'] == 0) {
            $tipo = "Aún no aceptada";
        } elseif ($rowoffer['aceptada'] == 1) {
            $tipo='<span style="color:#09ff00;text-shadow: 1px 1px 6px #dbcb0a;">Aceptado</span>';
        } elseif ($rowoffer['aceptada'] == 2) {
            $tipo='<span style="color:#ff2222;">Rechazado</span>';
        } else {
            $tipo = "Aún no aceptada";
        }
        $str.= '<tr>
        <td align="left">'.$nick.'</td>
        <td align="left">'.$rowoffer['la_oferta'].'</td><td>'.$tipo.'</td>
        <td id="ofre'.$tot.'"><a title="Cancela este ofrecimiento" href="#" onclick="return cancelarOfrecimiento('.$rowoffer['offer_id'].','.$tot.');">(Cancelar)</a></td></tr>';
    }
    if ($tot > 0) {
        echo '<h2>Ofertas realizadas</h2>
        <table id="tabla_ofertas_realizadas" name="tabla_ofertas_realizadas" width="500" border="0">
        <tbody>
        <tr>
            <td align="left" width="150"><strong>Publicados</strong></td>
            <td align="left" width="90"><strong>Tu oferta</strong></td>
            <td align="center" width="90"><strong>Estado</strong></td>
            <td align="center" width="60"></td>
        </tr>
        ' .$str. '</tbody></table>';

    }


?><p><a href="#"><img src="/imagenes/volver.gif" width="136" height="27" border="0"  onclick="JavaScript:seccion(7)" /></a></p>

