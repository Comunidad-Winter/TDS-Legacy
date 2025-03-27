<?php 
        
require_once $_SERVER['DOCUMENT_ROOT'] . '/php/utils.php';

$conn = connect();
require_logged();
require_once $_SERVER['DOCUMENT_ROOT'] . '/cuentas/mis_personajes/seg.php';

?>

<img src="/imagenes/personajes-en-venta.gif" border="0" alt="Personajes en venta">
<br />
<div id="busquedamao">
    <form name="form1" method="post" action="">
        <div align="center"><big>Filtrar:</big>
            <label>
                <select name="condicion" id="condicion" onchange="return filtrar(1)" class="selectmao">
                    <option value="Todas">Todos los niveles</option>
                    <option value="Mayor">Mayor a nivel</option>
                    <option value="Menor">Menor a nivel</option>
                </select>
            </label>

            <label>
                <select name="nivel" id="nivel" onchange="return filtrar(1)" class="selectmao">
                    <option value="--">--</option>
                    <option value="13">13</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                    <option value="25">25</option>
                    <option value="30">30</option>
                    <option value="35">35</option>
                    <option value="40">40</option>
                </select>
            </label>
            <select name="clase" id="clase" onChange="return filtrar(0)" class="selectmao">
                <option value="Todas">Todas</option>
                <option value="ASESINO">Asesino</option>
                <option value="BARDO">Bardo</option>
                <option value="CARPINTERO">Carpintero</option>
                <option value="CAZADOR">Cazador</option>
                <option value="CLERIGO">Clerigo</option>
                <option value="DRUIDA">Druida</option>
                <option value="GUERRERO">Guerrero</option>
                <option value="LEÑADOR">Le&ntilde;ador</option>
                <option value="MAGO">Mago</option>
                <option value="MINERO">Minero</option>
                <option value="PALADIN">Paladin</option>
                <option value="PESCADOR">Pescador</option>
                <option value="PIRATA">Pirata</option>
            </select>
            <select name="tipo" id="tipo" onchange="javascript:return filtrar(0)" class="selectmao">
                <option value="Todas">Todas</option>
                <option value="2">Cambio</option>
                <option value="1">Oro</option>
            </select>
        </div>
    </form>
    <form name="form2" method="post" action="" onsubmit="return false;">
        <big>Personaje:</big>
        <input type="text" name="searchmao" value="" class="inp" /><input type="submit" class="boton" value="Buscar" name="btnsearch" style="display:inline" onclick="return buscarmao();" />
        <input type="submit" class="boton" value="Ver todos" name="btnsearch" style="display:inline" onclick="seccionespecial(5);" />
    </form>
</div>
<div style="text-align:center;" id="listamercado">
    <table cellpadding="1" cellspacing="1" height="7" id="tabla_lista_pjs">
    <tbody>
        <tr bgcolor="#FFFFCC">
            <td width="112"><strong>Personaje</strong></td>
            <td><strong>Nivel</strong></td>
            <td><strong>Clase</strong></td>
            <td><strong>Condición</strong></td>
            <td><strong>Comprar</strong></td>
            <td></td>
            <td></td>
        </tr>
        <?php 
           
 
            $sql = "SELECT * FROM mercado LIMIT 100;";

            $stmt = mysqli_stmt_init($conn);
            $tipo = '';

            if (!mysqli_stmt_prepare($stmt, $sql)) {
                exit('sql error');
            } else {
                mysqli_stmt_execute($stmt);
                $result = mysqli_stmt_get_result($stmt);
                $curVenta = 0;
                
                while ($row = mysqli_fetch_array($result)) {
                    $curVenta++;

                    if ($row['tipo'] == "2") {
                        $tipo = '<td align="center" style="width:90px;">Cambio PJ</td>';
                    } elseif ($row['tipo'] == "3") {
                        $tipo = '<td align="center" style="width:90px;">Subasta</td>';
                    } elseif ($row['tipo'] == "1") {
                        $formattedOro = number_format($row['oro'], 0, ",", ".");
                        $tipo = '<td align="left" style="width:90px"><img src="/imagenes/cuentas/monedas.gif"> ' . $formattedOro . '</td>';
                    }

                    $conpass = (strlen($row['contrasena']) > 0) ? '<img src="/imagenes/llave.png">' : '';
                    $candado = ($row['candado'] > 0) ? '<img src="/imagenes/candado.gif">' : '';

                    //Tabla 1 o 2
                    $tableClass = 'tabla' . ($curVenta % 2 == 0 ? '2' : '1');

                    echo '<tr id="' . $curVenta . '" class="' . $tableClass . '"><td width="150">';
                    if (strpos($row['pjs'], '-') > 0) {
                        $nick = explode('-', $row['pjs']);
                        $nivel = array();
                        $clase = array(); 
                        foreach ($nick as $n) {
                            $sql2 = "SELECT nivel,clase FROM user WHERE nick = ?;";
                            $stmt2 = mysqli_stmt_init($conn);

                            if (!mysqli_stmt_prepare($stmt2, $sql2)) {
                                exit('sql error');// . mysqli_stmt_error($stmt2));
                            }

                            mysqli_stmt_bind_param($stmt2, "s", $n);
                            mysqli_stmt_execute($stmt2);
                            $result2 = mysqli_stmt_get_result($stmt2);
                            $datapjs = mysqli_fetch_array($result2);

                            $nivel[] = $datapjs['nivel'];
                            $clase[] = $datapjs['clase']; 
                        }
                        
                        foreach ($nick as $n) {
                            
                            echo '<a title="Ver estadisticas completas de este personaje" href="?a=mercado&amp;s=e&amp;p=' . $n . '" onclick="return verest(\'' . $n . '\')"><strong>' . $n . '</strong></a><br>';
                        }


                        echo '</td><td width="57">';
                        foreach ($nivel as $n) {
                            echo $n . '<br>';
                        }

                        echo '</td><td id="1c" width="100" height="2">';
                        foreach ($clase as $c) {
                            echo $c . '<br>';
                        }
                        echo '</td>';
                    } else {
                        $sql2 = "SELECT nivel,clase FROM user WHERE nick = ?;";
                        $stmt2 = mysqli_stmt_init($conn);

                        if (!mysqli_stmt_prepare($stmt2, $sql2)) {
                            exit('sql error');// . mysqli_stmt_error($stmt2));
                        }

                        mysqli_stmt_bind_param($stmt2, "s", $row['pjs']);
                        mysqli_stmt_execute($stmt2);
                        $result2 = mysqli_stmt_get_result($stmt2);
                        $datapj = mysqli_fetch_array($result2);

                        echo '<a title="Ver estadisticas completas de este personaje" href="?a=mercado&amp;s=e&amp;p=' . $row['pjs'] . '" onclick="return verest(\'' . $row['pjs'] . '\')"><strong>' . $row['pjs'] . '</strong></a><br></td><td width="57">' . $datapj['nivel'] . '<br></td><td id="1c" width="100" height="2">' . $datapj['clase'] . '<br></td>';
                    }

                    echo $tipo . '<td width="66"><a href="?a=mercado&amp;s=c&amp;p=' . $row['pjs'] . '" onclick="return comprar(\'' . $row['pjs'] . '\')">Comprar</a></td>
                                <td width="16" height="2">' . $conpass . '</td>
                                <td width="16" height="2">' . $candado . '</td>
                            </tr>';
                }
            }

        ?>

    </tbody>
</table>
    
</div>
<p align="center"><a href="#" onclick="JavaScript:seccion(7)"><img src="/imagenes/volver.gif" width="136" height="27" border="0" alt="Volver" /></a>