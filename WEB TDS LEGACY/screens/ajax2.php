<?php 

//obtener X foto
// from=" + num 

$from=1; //latest;
$get=1; //latest;

$desc="Some desc";
$views=500;

if (isset($_GET['from']) && isset($_GET['p'])) {
	$from=intval($_GET['from']);
	$get=intval($_GET['p']);
}

$numeros = array(5,2,2,2,5,5,5,5,3,5,5);
//$numeros = array($OBTENIDo,$DATO);

$votos=count($numeros);
$votoprom = round(array_sum($numeros)/count($numeros));

$stars="";
for ($i=0; $i < $votoprom; $i++) { 
	$stars.='<a href="#" title="'.$votoprom.'/5 - '.$votos.' votos."><img src="/imagenes/fotos/rating_1.gif" style="border:0;"></a>';
}


	$resultado="";
	$resultado.="<|>";
	$resultado.=$desc;
	$resultado.="<|>";
	$resultado.=$views;//vistas
	$resultado.="<|>";
	$resultado.="0";//categoria
	$resultado.="<|>";
	$resultado.="foto nombre";
	$resultado.="<|>";
	$resultado.="usuario_upload";
	$resultado.="<|>";
	$resultado.=$stars;
	$resultado.="<|>";
	$resultado.=date('j-m-y', time());
	#echo $resultado;



?>