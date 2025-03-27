<?php
	
	if (isset($_GET['i']) && !empty($_GET['i'])) {
		$id = intval($_GET['i']);

		require_once $_SERVER['DOCUMENT_ROOT'] . '/php/utils.php';
		$conn = connect();

		$consulta = "SELECT * FROM objectdata";
		$resultado = $conn->query($consulta);

		if ($resultado) {
			$RowsDataObjs = array();
			while ($row = mysqli_fetch_array($resultado)) {
				$RowsDataObjs[] = $row;
			}
			$resultado->close();

			if ($id >= 1 && $id <= count($RowsDataObjs)) {
				
				$secae="";
				if ($RowsDataObjs[$id]['nosecae'] == 1 || $RowsDataObjs[$id]['objtype'] == 31) {
					$secae="EL ITEM NO SE CAE AL MORIR";
				}else {
					$secae="El item se cae al morir.";
				}
				$clasespermitidas="";
				if (strlen($RowsDataObjs[$id]['clasespermitidas'])>0) {
					$clasespermitidas='<span>Clases permitidas:</span><br>'.$RowsDataObjs[$id]['clasespermitidas'];
				}

				
				switch ($RowsDataObjs[$id]['objtype']) {
					case 2: // weapon						
						$info = "Daño minimo: ". $RowsDataObjs[$id]['MinHIT'] . "<br>Daño máximo: " .$RowsDataObjs[$id]['MaxHIT'];
						break;
					case 3:case 16:case 17:case 31: //Armadura
						$info = "Defensa minima: ". $RowsDataObjs[$id]['MinDEF'] . "<br>Defensa máxima: " .$RowsDataObjs[$id]['MaxDEF'];
						break;
					case 11:
						$info = "Modificador minimo: ". $RowsDataObjs[$id]['MinModificador'] . "<br>Modificador máximo: " .$RowsDataObjs[$id]['MaxModificador'];
						break;
					case 14:
						$info = "Te permite crear objetos";
						break;
					case 39: case 29:
						$info = "Objeto especial utilizado para quests.";
						break;
					default:
						$info = "No se ha cargado información sobre este item, no tiene utilidad o es un objeto de colección.";
						break;
				}
				
				switch ($id+1) {
					case 198:
						$info = "Éste objeto sirve para crear otros objetos utilizando leña común o leña de tejo como recurso.";
						break;
					case 630:
						$info = "Éste objeto sirve para talar árboles élficos y obtener leña de tejo.";
						break;
					case 389:
						$info = "Éste objeto sirve para crear otros objetos utilizando lingotes como recurso.";
						break;
					case 127:
						$info = "Éste objeto sirve para talar árboles comunes y obtener leña común.";
						break;
					case 187:case 562:
						$info = "Éste objeto sirve para picar yacimientos y obtener minerales de hierro y plata.";
						break;
					case 685:
						$info = "Éste objeto sirve para picar yacimientos y obtener minerales de oro.";
						break;
					default:						
						break;
				}
				

				$desc = '<p><span>Tipo de item:</span> '.eOBJType::toText($RowsDataObjs[$id]['objtype']) .'<br><span>Precio:</span> '.$RowsDataObjs[$id]['valor'].' <img src="/imagenes/hz/hz_oro.gif" alt="Monedas de Oro con 100 skill en comerciar"><br><br>'.$info.'<br>'.$secae.'<br><br>'.$clasespermitidas.'</p>';
				echo $RowsDataObjs[$id]['name'] . '|<' . $desc;
			} else {
				die("No válido.");
			}
		} else {
			die("Error en la consulta SQL.");
		}
	} else {
		die("Inválido.");
	}
?>
