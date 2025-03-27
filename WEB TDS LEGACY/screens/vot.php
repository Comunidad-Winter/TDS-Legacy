<?php

//ajax.send("rank=" + num + "&foto=" + actnum );


if (!isset($_POST['rank']) || !isset($_POST['foto']) || !isset($_POST['p'])) {
	echo('<a href="#" title="0/5 - 0 votos."></a>');
}else{

	echo('<a href="#" title="2/5 - 2 votos."><img src="/imagenes/fotos/rating_1.gif" style="border:0;"></a>');

	}



?>