<?php
// cargar_listas.php

// Simulación de las listas, se pueden reemplazar con una base de datos
$lista1 = array(
    array("slot" => 1, "nombre" => "item1", "cantidad" => 100),
    array("slot" => 2, "nombre" => "item2", "cantidad" => 200),
    array("slot" => 3, "nombre" => "item3", "cantidad" => 150)
);

echo json_encode($lista1);
?>
