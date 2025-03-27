<?php 
	require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
	<title>TDS Legacy - Cuenta - Cambiar clave</title>
	<meta name="csrf_token" content="<?php echo createToken(); ?>" />
	<!--[if lt IE 7.]>
	<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
	<![endif]-->
	<link href="/general.css" rel="stylesheet" type="text/css">
	<link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
	<script type="text/javascript" src="/scripts/cambiarcontrasena.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <script type="text/javascript" src="/php/script.js"></script>
    <link href="/header.css" rel="stylesheet" type="text/css">
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;">
                    <span style="display: inline-block; height: 100%; vertical-align: middle;"></span>
                    <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%">
                </div>
            </div>
			<?php
				require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
			?>
            <div class="titulo_seccion"><h1>Utility</h1></div>
<div id="main">
<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;">
<div class="tit">
<h1>Reestablece tu contraseña</h1><p class="necesario">
<a href="/cuenta-premium.php">Volver al inicio</a>
</p>
</div>
	<form name="cuentasPremium" id="cuentasPremium">
	<?php 
		$hash="";
		$id=0;
		if (isset($_GET['rid'])) $id=$_GET['rid'];
		if (isset($_GET['hash']))$hash=$_GET['hash'];
		echo '<input name="hash" type="text" id="hash" style="display: none;" value="'. $hash .'">';
		echo '<input name="rid" type="text" id="rid" style="display: none;" value="'. $id .'">';
	?>
	<div class="campos">
	<div class="avisos" id="ayuda2a" style="display:inline">
	<p>La contraseña debe contener entre 8 y 30 caracteres. Para obtener un nivel alto de seguridad <strong>alterna entre minúsculas, mayúsculas y números</strong>.</p>
	</div>
	<p class="form-tit">Completá este formulario para cambiar la contraseña</p>

	<span class="noerr" id="errpassword"><span class="p">Por favor, ingresá la nueva contraseña.</span></span>
	<label for="password">*Contraseña nueva</label>
	<span class="input">
	<input name="password" type="password" id="password" size="10" maxlength="30" value="" onkeyup="mostrarPoderClave(this)">
	</span>
	
	<label><em>Seguridad de la contraseña</em></label>
	<div class="seguridad">
	<div class="nivel-actual" style="width:0px;" id="barra"><span id="txt_barra"></span>
	</div>
	</div>
	
	<div class="clear"></div>
	
	<span class="noerr" id="errpassword2"><span id="errorpassword2" class="p">Por favor, ingresá una Contraseña válida.</span></span>
	<label for="password2">*Repita la nueva contraseña</label>
	<span class="input">
	<input name="password2" type="password" id="password2" onblur="chequearReIngreso()" size="10" maxlength="30" value="">
	</span>

	<div class="clear"></div>
	<a onclick="changePasswordAccount()" id="Submit">Cambiar</a>
	
	</div>
	</form>
	<div id="errs" class="errcontainer"></div>
</div>
</div>

<?php  require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php'; ?>