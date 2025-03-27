<?php

if (isset($_SESSION['pin_posted'])) {

    require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
    require_logged();
    require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';
    $conn = connect();

    $premiumspam="";
    if (isset($_SESSION['premium_at'])) {
            $ts1 = date(time());$ts2 = strtotime($_SESSION['premium_at']);
            $seconds_diff = $ts2 - $ts1;
            if ($seconds_diff > 0)
                $premiumspam='<p>¡Hacete premium! Una Cuenta Premium te permite acceder a una gran cantidad de beneficios exclusivos.</p>';}
        
    $codigo=$_SESSION['tmpcodigo'];
    $msg='<h1 style="text-align: center;color:#a71111;font-family: fantasy;">TDS Legacy</h1><strong>Hola '.$_SESSION['first_name'].'!</strong><br><br>

    Estás en proceso de realizar una publicacion en el Mercado de personajes de TDS Legacy,<br>para confirmar dicha acción deberás copiar este código <strong><b>'.$codigo.'</b></strong> en el formulario de publicación.
    Este código tiene una validez de una hora.<br>';

    if (!sendEmail($_SESSION['email'], $_SESSION['username'],'Codigo de confirmacion para el mercado', $msg, true )) {
        $_SESSION['ERRORS']['err'] = '<div id="panel-premium">Debido a una falla tecnica no se ha podido enviar la clave de confirmacion. Por favor intente en otro momento.</div>';
            header('Location: ventapj.php');        
            exit();
    };
};

?>