<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/DB/env.php';

$conn = mysqli_connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_DATABASE);

if (!$conn)
{
    die('COnnection failed.');//"Connection failed: ". mysqli_connect_error());
}
