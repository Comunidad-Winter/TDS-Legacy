<?php   


	if (!isset($_GET['i'])) {
		die("Hechizo invalido.");
	}

	if (empty($_GET['i'])) {
		die("Hechizo invalido.");
	}
 

	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    $conn = connect();

	$spell=intval($_GET['i']);
	
	$consulta = 'SELECT * FROM spelldata';
	$NumSpells=0;
	 if ($resultado = $conn->query($consulta)) {
	    $RowsDataObj = array ();
	    while($row = mysqli_fetch_array($resultado))
	    {
	        $RowsDataSpells [] = $row;
	        $NumSpells++;
	    }
	     $resultado->close();
	 }

	if ($spell > $NumSpells || $spell < 1) {
		die("Hechizo no valido.");
	}

	echo($RowsDataSpells[$spell-1]['name'] .'|<' .$RowsDataSpells[$spell-1]['precio'] .'|<' .$RowsDataSpells[$spell-1]['description'] .'|<' .$RowsDataSpells[$spell-1]['afecta'] .'|<' .$RowsDataSpells[$spell-1]['skill'].'|<'
	.$RowsDataSpells[$spell-1]['mana']	  .'|<' .$RowsDataSpells[$spell-1]['energia'] .'|<' .$RowsDataSpells[$spell-1]['clasesprohibidas']);	


?>