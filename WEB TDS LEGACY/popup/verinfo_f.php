<?php
	
	if (isset($_GET['i']) && !empty($_GET['i'])) {
		$id = intval($_GET['i']);

		require_once $_SERVER['DOCUMENT_ROOT'] . '/php/utils.php';
		$conn = connect();

		$consulta = "SELECT * FROM objectdata WHERE id = $id";
		$resultado = $conn->query($consulta);

		if ($resultado) {
			if ($resultado->num_rows > 0) {
				$row = $resultado->fetch_assoc();
				$desc = '<p><span>Tipo de item:</span> <br><span>Precio:</span> 0<img src="/imagenes/hz/hz_oro.gif" alt="Monedas de Oro con 100 skill en comerciar"><br><br>No se ha cargado información sobre este item, no tiene utilidad o es un objeto de colección.<br>El item se cae al morir<br><br><span>Clases permitidas:</span><br></p>';
				echo $row['name'] . '|<' . $desc;
			} else {
				die("No válido.");
			}
			$resultado->close();
		} else {
			die("Error en la consulta SQL.");
		}
	} else {
		die("Inválido.");
	}
?>
