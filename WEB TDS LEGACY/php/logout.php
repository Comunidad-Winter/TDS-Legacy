<?php
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    
	if(isset($_POST['csrf_token']) && validateToken($_POST['csrf_token'])) {
		session_destroy();
		echo 0;
	}
	else {
		echo 1;
	}

	header("Location: /cuenta-premium.php");