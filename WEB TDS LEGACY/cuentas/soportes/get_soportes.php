<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_gm();

$conn = connect();

$statusType = array(
	0 => 'No leído',
	1 => 'Leído',
	2 => 'Respondido',
	3 => 'Cerrado',
    4 => 'Reabierto'		
);

$sectorType = array(
	0 => 'Normal',
	1 => 'Bug',
	2 => 'Ban',
	5 => 'Otros',
	7 => 'Problema Técnico',
	9 => 'Denuncia GMs',
	11 => 'Robo de PJ/Estafa',
	15 => 'Otro',
	16 => 'Cuentas',
	17 => 'Nick inapropiado',
	20 => 'Denuncia de cheater',
	21 => 'Foro',
	22 => 'Quite T0 ingame',
	23 => 'Discord'
);

$columns = ['ticket','pj_id', 'sector', 'asunto', 'mensaje', 'estado', 'fecha_creacion','username'];
$table = "soportes INNER JOIN cuentas ON soportes.account_id = cuentas.id";
$id = 'account_id';/* La clave principal de la tabla. */

$campo = isset($_POST['campo']) ? $conn->real_escape_string($_POST['campo']) : null;
$estado = isset($_POST['estado']) ? $conn->real_escape_string($_POST['estado']) : null;
$sector = isset($_POST['sector']) ? $conn->real_escape_string($_POST['sector']) : null;

if ($estado == "%") {
	$estado ='';
}

if ($sector == "%") {
	$sector ='';
}

$where = '';

if ($estado != null) {
	$where ="WHERE (estado = " . $estado . ")";
}

if ($sector != null) {
	if ($where != null)
		$where .= " AND (sector = " . $sector . ")";
	else
    	$where = "WHERE (sector = " .$sector . ")";
}

if ($campo != null) {

	if ($where != null)
		$where .= " AND (username LIKE '%" .$campo . "%')";
	else
    	$where = "WHERE (username LIKE '%" .$campo . "%')";

    //$cont = count($columns);
    //for ($i = 0; $i < $cont; $i++) {
    //    $where .= $columns[$i] . " LIKE '%" . $campo . "%' OR ";
    //}
    //$where .= "username LIKE '%" .$campo . "%')";
    //$where = substr_replace($where, "", -3);
    //$where .= ")";
}


/* Limit */
$limit = isset($_POST['registros']) ? $conn->real_escape_string($_POST['registros']) : 10;
$pagina = isset($_POST['pagina']) ? $conn->real_escape_string($_POST['pagina']) : 0;

$limit=10;

if (!$pagina) {
    $inicio = 0;
    $pagina = 1;
} else {
    $inicio = ($pagina - 1) * $limit;
}

$sLimit = "ORDER BY fecha_creacion DESC LIMIT $inicio , $limit";


//$query = "SELECT soportes.*, cuentas.username FROM soportes INNER JOIN cuentas ON soportes.account_id = cuentas.id WHERE asunto LIKE '%".$condition."%' ORDER BY fecha_creacion DESC";

/* Consulta */
$sql = "SELECT SQL_CALC_FOUND_ROWS " . implode(", ", $columns) . "
FROM $table
$where
$sLimit";

$resultado = $conn->query($sql);


$num_rows = $resultado->num_rows;

/* Consulta para total de registro filtrados */
$sqlFiltro = "SELECT FOUND_ROWS()";
$resFiltro = $conn->query($sqlFiltro);
$row_filtro = $resFiltro->fetch_array();
$totalFiltro = $row_filtro[0];

/* Consulta para total de registro filtrados */
$sqlTotal = "SELECT count($id) FROM $table ";
$resTotal = $conn->query($sqlTotal);
$row_total = $resTotal->fetch_array();
$totalRegistros = $row_total[0];

/* Mostrado resultados */
$output = [];
$output['totalRegistros'] = $totalRegistros;
$output['totalFiltro'] = $totalFiltro;
$output['data'] = '';
$output['paginacion'] = '';

$fecha_actual = date('Y-m-d H:i:s');
$timestamp_actual = strtotime($fecha_actual);
$fecha='';

if ($num_rows > 0) {

    while ($row = $resultado->fetch_assoc()) {
    	
    	$timestamp_final = strtotime($row['fecha_creacion']);
    	$diferencia = $timestamp_actual - $timestamp_final;
    	$dias = $diferencia / 86400;
    	$dias = floor($dias);
		if ($dias >= 2) {
		  $fecha= "Hace $dias días";
		} elseif ($dias == 1) {
		  $fecha= "Ayer";
		} elseif ($dias == 0) {
		  $fecha= "Hoy";
		}else
		$fecha=$dias;

		$fecha = '<abbr style="text-decoration: none;" title="' . $row['fecha_creacion'] .  '">' . $fecha . '</abbr>';

        $output['data'] .= '<tr>';
        $output['data'] .= '<td>' . $row['username'] . '</td>';
        $output['data'] .= '<td style="font-size:x-small;">' . $sectorType[$row['sector']] . '</td>';
        $output['data'] .= '<td style="width:250px;max-width:100px;overflow:hidden;">' . $row['asunto'] . '</td>';
        $output['data'] .= '<td style="font-size:x-small;">' . $statusType[$row['estado']] . '</td>';
        $output['data'] .= '<td style="font-size:x-small;width:250px;max-width:76px;overflow:hidden;">' . $fecha . '</td>';
        $output['data'] .= '<td><a href="?a=responder-soporte-gm&ticket=' . $row['ticket'] . '">Ver</a></td>';
        $output['data'] .= '</tr>';
    }
} else {
    $output['data'] .= '<tr>';
    $output['data'] .= '<td colspan="7">Sin resultados</td>';
    $output['data'] .= '</tr>';
}

if ($output['totalRegistros'] > 0) {
    $totalPaginas = ceil($output['totalRegistros'] / $limit);

    $output['paginacion'] .= '<nav>';
    $output['paginacion'] .= '<ul class="pagination">';

    $numeroInicio = 1;

    if(($pagina - 4) > 1){
        $numeroInicio = $pagina - 4;
    }

    $numeroFin = $numeroInicio + 9;

    if($numeroFin > $totalPaginas){
        $numeroFin = $totalPaginas;
    }

    for ($i = $numeroInicio; $i <= $numeroFin; $i++) {
        if ($pagina == $i) {
            $output['paginacion'] .= '<li class="page-item active"><a class="page-link"  >' . $i . '</a></li>';
        } else {
            $output['paginacion'] .= '<li class="page-item"><a class="page-link"   onclick="getData(' . $i . ')">' . $i . '</a></li>';
        }
    }

    $output['paginacion'] .= '</ul>';
    $output['paginacion'] .= '</nav>';
}


























$campo = isset($_POST['campo2']) ? $campo= $_POST['campo2'] : null;
$estado = isset($_POST['estado2']) ? $conn->real_escape_string($_POST['estado2']) : null;
$sector = isset($_POST['sector2']) ? $conn->real_escape_string($_POST['sector2']) : null;


if ($estado == "%") {
	$estado =null;
}

if ($sector == "%") {
	$sector =null;
}
if ($campo == "%") {
	$campo =null;
} 
 
$where = null;

if ($estado != null) {
	$where ="WHERE (estado = " . $estado . ")";
}

if ($sector != null) {
	if ($where != null)
		$where .= " AND (sector = " . $sector . ")";
	else
    	$where = "WHERE (sector = " .$sector . ")";
}

if ($campo != null) {

	if ($where != null)
		$where .= " AND (nick LIKE '%" .$campo . "%')";
	else
    	$where = "WHERE (nick LIKE '%" .$campo . "%')";
}


$inicio = 0;
$limit = isset($_POST['registros2']) ? $conn->real_escape_string($_POST['registros2']) : 10;
$pagina = isset($_POST['pagina2']) ? intval($_POST['pagina2']) : 0;

$limit=10;

if (!$pagina) {
    $inicio = 0;
    $pagina = 1;
} else {
    $inicio = ($pagina - 1) * $limit;
}


$sLimit = "ORDER BY fecha_creacion DESC LIMIT $inicio , $limit";

/* Consulta */
$sql = "SELECT * FROM soportes2 $where $sLimit";
 
$resultado = $conn->query($sql);

$num_rows = $resultado->num_rows;

/* Consulta para total de registro filtrados */
$sqlFiltro = "SELECT FOUND_ROWS()";
$resFiltro = $conn->query($sqlFiltro);
$row_filtro = $resFiltro->fetch_array();
$totalFiltro = $row_filtro[0];

/* Consulta para total de registro filtrados */
$sqlTotal = "SELECT count(*) FROM soportes2 ";
$resTotal = $conn->query($sqlTotal);
$row_total = $resTotal->fetch_array();
$totalRegistros = $row_total[0];


$output['totalRegistros2'] = $totalRegistros;
$output['totalFiltro2'] = $totalFiltro;
$output['data2'] = '';
$output['paginacion2'] = '';

$fecha_actual = date('Y-m-d H:i:s');
$timestamp_actual = strtotime($fecha_actual);
$fecha='';

if ($num_rows > 0) {

    while ($row = $resultado->fetch_assoc()) {
    	
    	$timestamp_final = strtotime($row['fecha_creacion']);
    	$diferencia = $timestamp_actual - $timestamp_final;
    	$dias = $diferencia / 86400;
    	$dias = floor($dias);
		if ($dias >= 2) {
		  $fecha= "Hace $dias días";
		} elseif ($dias == 1) {
		  $fecha= "Ayer";
		} elseif ($dias == 0) {
		  $fecha= "Hoy";
		}else
		$fecha=$dias;

		$fecha = '<abbr style="text-decoration: none;" title="' . $row['fecha_creacion'] .  '">' . $fecha . '</abbr>';

        $output['data2'] .= '<tr>';
        $output['data2'] .= '<td>' . $row['nick'] . '</td>';
        $output['data2'] .= '<td style="font-size:x-small;">' . $sectorType[$row['sector']] . '</td>';
        $output['data2'] .= '<td style="width:250px;max-width:100px;overflow:hidden;">' . $row['asunto'] . '</td>';
        $output['data2'] .= '<td style="font-size:x-small;">' . $statusType[$row['estado']] . '</td>';
        $output['data2'] .= '<td style="font-size:x-small;width:250px;max-width:76px;overflow:hidden;">' . $fecha . '</td>';
        $output['data2'] .= '<td><a href="?a=responder-soporte-gm&ticket2=' . $row['ticket'] . '">Ver</a></td>';
        $output['data2'] .= '</tr>';
    }
} else {
    $output['data2'] .= '<tr>';
    $output['data2'] .= '<td colspan="7">Sin resultados</td>';
    $output['data2'] .= '</tr>';
}

if ($output['totalRegistros2'] > 0) {
    $totalPaginas = ceil($output['totalRegistros2'] / $limit);

    $output['paginacion2'] .= '<nav>';
    $output['paginacion2'] .= '<ul class="pagination">';

    $numeroInicio = 1;

    if(($pagina - 4) > 1){
        $numeroInicio = $pagina - 4;
    }

    $numeroFin = $numeroInicio + 9;

    if($numeroFin > $totalPaginas){
        $numeroFin = $totalPaginas;
    }

    for ($i = $numeroInicio; $i <= $numeroFin; $i++) {
        if ($pagina == $i) {
            $output['paginacion2'] .= '<li class="page-item active"><a class="page-link"  >' . $i . '</a></li>';
        } else {
            $output['paginacion2'] .= '<li class="page-item"><a class="page-link"   onclick="getData(' . $i . ')">' . $i . '</a></li>';
        }
    }

    $output['paginacion2'] .= '</ul>';
    $output['paginacion2'] .= '</nav>';
}






echo json_encode($output, JSON_UNESCAPED_UNICODE);