<?php 
        
require_once $_SERVER['DOCUMENT_ROOT'] . '/php/utils.php';

$conn = connect();
require_logged();
require_once $_SERVER['DOCUMENT_ROOT'] . '/cuentas/mis_personajes/seg.php';

?>

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

    

    $pagina=1;
    $limit = isset($_POST['registros']) ? intval($conn->real_escape_string($_POST['registros'])) : 10;
    $pagina = isset($_POST['mostrar']) ? intval($conn->real_escape_string($_POST['mostrar'])) : 0;
    if ($pagina <= 0) $pagina =1;
    $limit=20;

    if (!$pagina) {
        $inicio = 0;
        $pagina = 1;
    } else {
        $inicio = ($pagina - 1) * $limit;
    }

    if (isset($_POST['buscar']) && isset($_POST['mostrar']) && isset($_POST['clase']) && isset($_POST['tipo']) && isset($_POST['nivel']) && isset($_POST['condi'])) {
        
        $where = '';
        
        if ($_POST['buscar'] != null) {
            $nombres = explode('-', $_POST['buscar']);
            $nombreConditions = [];
            foreach ($nombres as $nombre) {
                $nombre = trim($nombre); // Limpiar espacios en blanco
                $nombreConditions[] = "(nick LIKE '%$nombre%')";
            }
            
            // Combinar todas las condiciones con OR
            $nombreWhere = "(" . implode(" OR ", $nombreConditions) . ")";
            
            if ($where != null) {
                $where .= " AND ($nombreWhere)";
            } else {
                $where = "WHERE ($nombreWhere)";
            }
            

        }
         

        if ($_POST['clase'] != null) {
            if (array_key_exists($_POST['clase'], $clasesStrToByte)) {
                $clase= $_POST['clase'];
                if ($where != null)
                    $where .= " AND (clase = LIKE '%" . $clase . "%')";
                else
                    $where = "WHERE (clase = LIKE '%" .$clase . "%')";                
            }             
        }
 
        switch ($_POST['condi']) {
            case 'Mayor':
                $order =">";
                break;
            case 'Menor':
                $order ="<";
                break;
            case 'Todas':
            default:
                $order =null;
                break;
        }

        $tipo=intval($_POST['tipo']);

        if ($_POST['tipo'] == 1 || $_POST['tipo'] == 2 || $_POST['tipo'] == 3) {
            $tipo="(tipo=$tipo)";
            if ($where != null)
                $where .= " AND $tipo";
            else
                $where = "WHERE $tipo";            
        }        
        $nivel=$_POST['nivel'];   
        if ($nivel != '--' && $nivel != '13' && $nivel != '15' && $nivel != '20' && $nivel != '25' && $nivel != '30' && $nivel != '35' && $nivel != '40' ) {
            $nivel="40";
        }elseif (!is_numeric($nivel)) {
            $nivel=null;
        }     

        if ($nivel != null && $order !=null) {
            if ($where != null){                
                $where .= " AND (u.nivel $order " .$nivel . ")";
            }
            else
                $where = "WHERE (u.nivel $order " .$nivel . ")";
        }

    } 
    
    $sql = "SELECT m.*, u.nivel, u.clase         FROM mercado AS m        INNER JOIN user AS u ON (    m.pjs = u.nick  OR u.nick = CONCAT(SUBSTRING_INDEX(m.pjs, '-', 1), '-')    )        $where        ORDER BY m.mao_index DESC        LIMIT $inicio, $limit";
    
    $resultado = $conn->query($sql);
    $num_rows = $resultado->num_rows;
   
    /* Consulta para total de registro filtrados */
    $sqlFiltro = "SELECT FOUND_ROWS()";
    $resFiltro = $conn->query($sqlFiltro);
    $row_filtro = $resFiltro->fetch_array();
    $totalFiltro = $row_filtro[0];

    /* Consulta para total de registro filtrados */
    $sqlTotal = "SELECT count(mao_index) FROM mercado ";
    $resTotal = $conn->query($sqlTotal);
    
    $row_total = $resTotal->fetch_array();
    $totalRegistros = $row_total[0];

    /* Mostrado resultados */
    $output = [];
    $output['totalRegistros'] = $totalRegistros;
    $output['totalFiltro'] = $totalFiltro;
    $output['data'] = '';
    $output['paginacion'] = '';
 
    $stmt = mysqli_stmt_init($conn);
    $tipo='';

    if (!mysqli_stmt_prepare($stmt, $sql)) {
        exit('sql error');
    } 
    else {
        //mysqli_stmt_bind_param($stmt, "i", $_SESSION['id']);
        mysqli_stmt_execute($stmt);

        $result = mysqli_stmt_get_result($stmt);
        $curVenta=0;
        
        while($row = mysqli_fetch_array($result)){       
            
           
            $curVenta++;
            
            if ($row['tipo'] =="2") {
                $tipo ='<td align="center" style="width:90px;">Cambio PJ</td>';
            }elseif ($row['tipo'] == "3") {
                $tipo = '<td align="center" style="width:90px;">Subasta</td>';
            }elseif ($row['tipo'] == "1") {
                $tipo = '<td align="left" style="width:90px;"><img src="/imagenes/cuentas/monedas.gif"> '.number_format($row['oro'], 0, ",", ".") .'</td>';
            }

            if (strlen($row['contrasena']) > 0) $conpass= '<img src="/imagenes/llave.png">';
            else $conpass="";

            if ($row['candado'] > 0) $candado= '<img src="/imagenes/candado.gif">';
            else $candado="";

            //Tabla 1 o 2
            echo '<tr id="'.$curVenta.'" class="tabla';
            if ($curVenta % 2 == 0) echo '2';
            else echo '1';                            
            echo '"><td width="150">';

            if (strpos($row['pjs'],'-')>0) {
                $nick=explode('-',$row['pjs']);
                 
                for ($i=0; $i < count($nick); $i++) { 
                    echo '<a title="Ver estadisticas completas de este personaje" href="?a=mercado&amp;s=e&amp;p=' . $nick[$i] .'" onclick="return verest('. "'".$nick[$i]. "'" . ')"><strong>' . $nick[$i] .'</strong></a><br>';
                }
                $sql2 = "SELECT nivel,clase FROM user WHERE nick=?;";                
                $nivel=array();
                $clase=array();                
                for ($i=0; $i < count($nick); $i++) { 
                    $stmt2 = mysqli_stmt_init($conn);
                    if (!mysqli_stmt_prepare($stmt2, $sql2)) exit('sql error'.mysqli_stmt_error($stmt2));
                    mysqli_stmt_bind_param($stmt2, "s", $nick[$i]);                                
                    mysqli_stmt_execute($stmt2);
                    $result2 = mysqli_stmt_get_result($stmt2);
                    $datapjs = mysqli_fetch_array($result2);
                    $nivel[] = $datapjs['nivel'];
                    $clase[] = $datapjs['clase'];
                }
                foreach ($nick as $n) {
                    echo $n . '<br>';
                }
                echo '</td><td width="57">';
                for ($i=0; $i < count($nick); $i++) { 
                    echo $nivel[$i].'<br>';                    
                }
                echo '</td><td id="1c" width="100" height="2">';
                for ($i=0; $i < count($nick); $i++) { 
                    echo $clase[$i].'<br>';
                }
                echo '</td>';
            }else{
                $sql2 = "SELECT nivel,clase FROM user WHERE nick=?;";
                $stmt2 = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt2, $sql2)) 
                    exit('sql error');
                mysqli_stmt_bind_param($stmt2, "s", $row['pjs']);                                
                mysqli_stmt_execute($stmt2);
                $result2 = mysqli_stmt_get_result($stmt2);
                $datapj = mysqli_fetch_array($result2);                                
                echo '<a title="Ver estadisticas completas de este personaje" href="?a=mercado&amp;s=e&amp;p=' . $row['pjs'] .'" onclick="return verest('. "'".$row['pjs']. "'" . ')"><strong>' . $row['pjs'] .'</strong></a><br></td><td width="57">'.$datapj['nivel'].'<br></td><td id="1c" width="100" height="2">'.$datapj['clase'].'<br></td>';
            }

            echo $tipo.'<td width="66"><a href="?a=mercado&amp;s=c&amp;p='.$row['pjs'].'" onclick="return comprar(' ."'". $row['pjs'] . "'" .'")">Comprar</a></td>
                        <td width="16" height="2">'.$conpass.'</td>
                        <td width="16" height="2">'.$candado.'</td>
                    </tr>';
        }
    }
?>
    </tbody>
</table>