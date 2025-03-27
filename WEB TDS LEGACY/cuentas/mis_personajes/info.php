<?php

require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
require_logged();

?>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">

<head>    
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <title>TDS Legacy - Cuenta - Estadisticas de <?php echo $_GET['nick'] ?></title>
    <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, de TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor de TDS Legacy, Server de TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje">
    <!--[if lt IE 7.]>
<script defer type="text/javascript" src="/scripts/pngfix.js"></script>
<![endif]-->
    <link href="/general.css" rel="stylesheet" type="text/css">
    <link href="/cuentas-premium.css" rel="stylesheet" type="text/css">
    <link href="panel-premium.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/cuentas/mis-personajes.js"></script>      
    <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
    <script type="text/javascript" src="/scripts/animated_header.js"></script>
    <script type="text/javascript" src="/scripts/header.js"></script>
    <style type="text/css">p{margin-left:20px;}</style>

    <!-- no se xq no anda-->
    <style type="text/css">td {font-size: 9pt;text-align: left;color: #ccc;}</style>
    <link href="hz.css" rel="stylesheet" type="text/css">
<script defer="" type="text/javascript" src="/hz.js"></script>

    <link href="/header.css" rel="stylesheet" type="text/css">
</head>

<body id="seccion_premium" onload="init();">
    <div id="bg_top">
        <div id="pagina">
            <div id="header">
                <div id="animation_container" style="background:none; width:700px; height:197px">
                    <canvas id="canvas" width="700" height="197" style="position: absolute; display: block; background: none; width: 700px; height: 197px;"></canvas>
                    <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;">
                    </div>
                </div>
                <div id="_preload_div_" style="position:absolute; top: 0px; left: 0px; display: none; height: 197px; width: 700px; text-align: center;"> <span style="display: inline-block; height: 100%; vertical-align: middle;"></span> <img src="/header_images/_preloader.gif" style="vertical-align: middle; max-height: 100%"></div>
            </div>
            <?php
                require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
            ?>
<div class="titulo_seccion">
<h1>Información de tu personaje</h1></div>
<div id="main">

<div id="panel-premium">
<div class="cuentas_premium" style="text-align:left;">
<div class="tit">
<h1>Panel de <?php echo( $_SESSION['username'] ); ?></h1>
<?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
</div><div id="centro_panel" style="width:500px;">
<div id="contenido" style="text-align:center">
<div align="center">
<?php

if (!isset($_GET['nick'])) {
    $_SESSION['ERRORS']['err'] = 'SQL ERROR';
    die();
}

$conn = connect();

require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/seg.php';

$data=$_GET['nick'];

$nick = clear_nick($data);

if (mb_strlen($nick) < 3) {
    echo 'nick invalido';
    die();
}

$sql = "SELECT * FROM user WHERE (account_id=? and nick=?);";
    $stmt = mysqli_stmt_init($conn);

    if (!mysqli_stmt_prepare($stmt, $sql)) {


        exit('Hubo un error al buscar tu personaje, por favor avisa a un Administrador de este mensaje. ErrCode:59500');
    } 
    else {    

        mysqli_stmt_bind_param($stmt, "ss", $_SESSION['id'], $nick);
        mysqli_stmt_execute($stmt);
        
        $result = mysqli_stmt_get_result($stmt); 

        if (mysqli_num_rows($result) > 0) {
            $rowINIT = mysqli_fetch_assoc($result);

            // @@ cuicui: attrib
            $sql = "SELECT * FROM attribute WHERE user_id=?;";
            $stmt = mysqli_stmt_init($conn);

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                header("Location: /");
                exit();
            } 
            else {    
                mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                mysqli_stmt_execute($stmt);
                
                $result = mysqli_stmt_get_result($stmt); 

                if (mysqli_num_rows($result) > 0) {
                    $rowATTRIBUTES = mysqli_fetch_assoc($result);                    
                }
            }

            
            // @@ cuicui: penas
            $sql = "SELECT * FROM punishment WHERE user_id=?";
            $stmt = mysqli_stmt_init($conn);
            $totPenas=0;

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                header("Location: /");
                exit();
            } 
            else {    
                mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                mysqli_stmt_execute($stmt);
                
                $resultp = mysqli_stmt_get_result($stmt); 
                $rowPENAS = array ();
                while($rowp = mysqli_fetch_array($resultp))
                {
                    $rowPENAS [] = $rowp; 
                    if(mb_strlen($rowPENAS[$totPenas]['reason'])> 0) 
                        $totPenas++;
                }


            } 
            
            // @@ cuicui: bank
            $sql = "SELECT * FROM bank_item WHERE user_id=?;";
            $stmt = mysqli_stmt_init($conn);

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                header("Location: /");
                exit();
            } 
            else {    
                mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                mysqli_stmt_execute($stmt);
                
                $result = mysqli_stmt_get_result($stmt); 

                if (mysqli_num_rows($result) > 0) {
                    $rowBANK = mysqli_fetch_assoc($result);                    
                }
            }
                $usernick = $rowINIT['nick'];
 
                
                if ($rowINIT['ban'] == 1) {
                    $usernick= '<s >'.$usernick."</s>";
                    
                    if (strlen($rowINIT['unbandate'])>0) 
                        $usernick.=' <small >[BANEADO HASTA EL DIA '.$rowINIT['unbandate'] .']</small>';
                    else                        
                        $usernick.=' <small >[BANEADO PERMANENTE]</small>';
                }  
 

               echo '<div id="centro_panel" style="width:500px;">
                <div id="contenido" style="text-align:center">
                <div align="center">
                <h1>' .$usernick .'</h1> 
                </div>
                <div align="left">
                <h3>General</h3>
                <p>Nivel: ' .$rowINIT['nivel'] .'<br>';
 

                if ($rowINIT['elu'] ==0 || $rowINIT['exp'] ==0  ) {
                    echo 'Exp: 0/0 [0%]<br>' ;
                }else{
                    echo 'Exp: ' . $rowINIT['exp'] . '/' .$rowINIT['elu'] .' ['  . Round($rowINIT['exp'] * 100 / $rowINIT['elu'],2)  .'%]<br>' ;
                }
                echo 'Clase: ' .$rowINIT['clase'] .'<br>';
                echo 'Raza: ' .$rowINIT['raza'] .'<br>';
                echo 'Genero: ' .$rowINIT['genero'] .'<br>';
                echo 'Mana: ' .$rowINIT['max_man'] .'<br>';

                 
                $ups=intval($rowINIT['ups']);
                $tmp="";

                if ($ups> 0) {
                     $color='#00ff22';
                     $tmp="+";
                }elseif ($ups < 0) {
                    $color='#e50000';
                }else
                    $color= '#fff';


                $repu = round(((-$rowINIT['asesino']) + (-$rowINIT['bandido']) + $rowINIT['burgue'] + (-$rowINIT['ladron']) + $rowINIT['noble'] + $rowINIT['plebe']) / 6);
                $repu = ($repu > 0) ? "Ciudadano" : "Criminal" ;
                
                    
                echo 'Vida: ' .$rowINIT['min_hp'] .'/' .$rowINIT['max_hp'] .' <b style="color:' .$color .'">[' .$tmp .$ups.']</b><br>';

                echo 'Ciudadanos Matados: ' .$rowINIT['ciudas_matados'] .'<br>';
                echo 'Criminales Matados: ' .$rowINIT['crimis_matados'] .'<br>';
                echo 'Criaturas Matadas: ' .$rowINIT['criaturas_matadas'] .'<br>';
                echo 'Estado: ' .$repu .'<br>';

               

                $pos=explode("-",$rowINIT['posicion'],3);

                echo 'Oro: ' . (number_format($rowINIT['oro']+ $rowINIT['boveda'], 0, ",", ".")) . ' ('.number_format($rowINIT['oro'], 0, ",", ".") .' en billetera y ' .number_format($rowINIT['boveda'], 0, ",", ".") .' en banco)<br>';
                echo 'Posicion: Mapa ' .$pos[0] .' (' .$pos[1] .',' .$pos[2] .') <a title="Al hacer clic aqui se te abrira el mapa del juego" target="_blank" href="imagenes/manual/mapa.jpg">(Ver mapa)</a><br>';
                echo 'Ultima IP: ' .$rowINIT['lastip'] .'<br></p>';

                echo '<h3>Atributos</h3>
                    <p>Fuerza:'.$rowATTRIBUTES['strength'] .'<br>
                    Agilidad: '.$rowATTRIBUTES['agility'].'<br>
                    Inteligencia: '.$rowATTRIBUTES['intelligence'].'<br>
                    Carisma: '.$rowATTRIBUTES['constitution'].'<br>
                    Constitución: '.$rowATTRIBUTES['charisma'].'</p>
                    <h3>Reputación</h3>
                    <p>Asesino:'.number_format($rowINIT['asesino'], 0, ",", ".").'<br>
                    Noble: '.number_format($rowINIT['noble'], 0, ",", ".").'<br>
                    Burgue: '.number_format($rowINIT['burgue'], 0, ",", ".").'<br>
                    Bandido: '.number_format($rowINIT['bandido'], 0, ",", ".").'<br>
                    Plebe: '.number_format($rowINIT['plebe'], 0, ",", ".").'<br>
                    Ladron: '.number_format($rowINIT['ladron'], 0, ",", ".").'<br>
                    </p>
                    <h3>Retos</h3>
                    <p>Ganados: '.$rowINIT['retos_ganados'].'<br>
                    Perdidos: '.$rowINIT['retos_perdidos'].'<br>
                    Oro Ganado: '.number_format($rowINIT['retos_oro_ganado'], 0, ",", ".").'<br>
                    Oro Perdido: '.number_format($rowINIT['retos_oro_perdido'], 0, ",", ".").'<br>
                    </p>
                    <h3>Información de Clan</h3><p>';

                    if (strlen($rowINIT['fundoclan']) == 0) 
                        echo 'No fundó ningún clan';
                    else
                        echo 'Fundó el clan ' .$rowINIT['fundoclan'];
                    
                    if ($rowINIT['participoclanes'] == 0)
                        echo ' y nunca participó en uno.';
                    else{
                        echo ', participó en ' .$rowINIT['participoclanes'];
                        if (strlen($rowINIT['clan']) < 2)  
                            echo ' y actualmente no pertenece a ningúno.';
                        else
                            echo ' y actualmente pertenece al clan '.$rowINIT['clan'] .'.';

                    }
                    
                    if (strlen($rowINIT['disolvioclan'])<2) 
                        echo ' No disolvió ningun clan.';
                    else
                        echo ' Disolvió el clan ' . $rowINIT['disolvioclan'];
                        

                    echo '</p><h3>Facción</h3><p>';
                    if ($rowINIT['ciudas_matados']>0) {
                        echo ' y no puede pertenecer a la armada ya que mato a ciudadanos. Para poder ingresar debe perdile perdon al Consejo de Banderbille..</p>';
                    }else 
                        echo 'No pertenece a ninguna faccion.</p>'; 
 
                    echo '<h3>Penas</h3><p>' ;

                        if ($totPenas ==0 ) {
                            echo 'No posee.';
                        }else{
                            echo '<ul>'; 
                            for ($i=0; $i < $totPenas ; $i++) { 
                                echo '<li>' . $rowPENAS[$i]['reason'] .'</li>';
                            }                             
                            echo '</ul>';
                        }
                    

                    echo'</p><p>';
 
                    if ($rowINIT['puntosfotodenuncia'] ==0 ) {
                        echo 'El personaje no posee puntos por fotodenuncias.';
                    }else echo 'El personaje posee '.$rowINIT['puntosfotodenuncia'].' puntos por fotodenuncias.';

                    echo '</p><p></p>
                    <h3>Historial de baneos</h3><p>
                    Nunca fue baneado.</p>
                    <h3>Skills</h3>';



// @@ cuicui: skills
            $sql = "SELECT * FROM skillpoint WHERE user_id=?;";
            $stmt = mysqli_stmt_init($conn);

            if (!mysqli_stmt_prepare($stmt, $sql)) {

                $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                header("Location: /");
                exit();
            } 
            else {    
                mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                mysqli_stmt_execute($stmt);
                
                $result = mysqli_stmt_get_result($stmt); 
                $tot=0;

                // @@ cuicui: head
                echo '<table><tbody><tr>';

                if (mysqli_num_rows($result) > 0) {

                    while ($rowSKILLS = mysqli_fetch_assoc($result)){ 
    $tot++; 
    ($tot==2 ? $print1='<td height="20" class="simple">&nbsp;</td><td height="20" class="simple"><div align="left">Apuñalar: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==1 ? $print2='<td width="222" class="simple"><div align="left">Mágia: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==14 ? $print3='<td height="20" class="simple">&nbsp;</td><td height="20" class="simple"><div align="left">Carpinteria: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==3 ? $print4='<td class="simple"><div align="left">Tácticas de combate: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==4 ? $print5='<td height="20" class="simple">&nbsp;</td><td height="20" class="simple"><div align="left">Combate con armas: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==5 ? $print6='<td class="simple"><div align="left">Meditar: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==10 ? $print7='<td height="20" class="simple">&nbsp;</td><td height="20" class="simple"><div align="left">Comercio: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==7 ? $print8='<td class="simple"><div align="left">Ocultarse: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==17 ? $print9='<td height="20" class="simple">&nbsp;</td><td height="20" class="simple"><div align="left">Domar animales: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==9 ? $print10='<td class="simple"><div align="left">Talar arboles: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==15 ? $print11='<td class="simple">&nbsp;</td><td class="simple"><div align="left">Herreria: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==11 ? $print12='<td class="simple"><div align="left">Defensa con escudos: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==12 ? $print13='<td class="simple">&nbsp;</td><td class="simple"><div align="left">Pesca: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==13 ? $print14='<td class="simple"><div align="left">Mineria: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==16 ? $print15='<td class="simple">&nbsp;</td><td class="simple"><div align="left">Liderazgo: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==21 ? $print16='<td class="simple"><div align="left">Resistencia Mágica: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==2 ? $print17='<td width="59" class="simple">&nbsp;</td><td width="196" class="simple"><div align="left">Robar: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==8 ? $print18='<td class="simple"><div align="left">Supervivencia: '.$rowSKILLS['value'].'</div></td></tr><tr>' : '');
    ($tot==18 ? $print19='<td class="simple">&nbsp;</td><td class="simple"><div align="left">Armas de proyectiles: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==19 ? $print20='<td class="simple"><div align="left">Wresterling: '.$rowSKILLS['value'].'</div></td>' : '');
    ($tot==20 ? $print21='</tr><tr><td class="simple">&nbsp;</td><td class="simple"><div align="left">Navegación: '.$rowSKILLS['value'].'</div></td>' : '');
                    }

                // @@ cuicui: viva la negrada, si, ordeno los skills asi kjj
                echo $print1 .$print2 .$print3 .$print4 .$print5 .$print6 .$print7 .$print8 .$print9 .$print10 .$print11 .$print12 .$print13 .$print14 .$print15 .$print16 .$print17 .$print18 .$print19 .$print20 .$print21;
                }
            }

                echo '<td class="simple"><div align="left">Skills Libres: '.$rowINIT['skillslibres'].'</div></td></tr></tbody></table>';
                // @@ cuicui: end_of_skills


                // @@ cuicui: inv
                $sql = "SELECT * FROM inventory_item WHERE (user_id=? AND  item_id>0);";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {

                    $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                    header("Location: /");
                    exit();
                } 
                else {    
                    mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                    mysqli_stmt_execute($stmt);
                    
                    $result = mysqli_stmt_get_result($stmt); 
                    $RowsInv = array ();
                    while($row = mysqli_fetch_array($result))
                    {
                        $RowsInv [] = $row;
                    }
                }

                $consulta = 'SELECT * FROM objectdata';
                $NumObjs=0;
                 if ($resultado = $conn->query($consulta)) {
                    $RowsDataObj = array ();
                    while($row = mysqli_fetch_array($resultado))
                    {
                        $RowsDataObj [] = $row;
                        $NumObjs++;
                    }
                     $resultado->close();
                 }

                echo '<h3>Inventario</h3><p>';

                $totitem=0;
                foreach ($RowsInv as $i) {
                    echo '<a href="#" title="Ver Ficha Ténica" class="simple" onclick="return verobjeto(' .($i['item_id']-1) .')">' .$RowsDataObj[$i['item_id']-1]['name'] . ' - ' .$i['amount'] .'</a><br>';
                        $totitem++;
                }
                if ($totitem == 0) {
                    echo 'No posee items en su inventario.';
                }

                $totitem=0;

                /////////////////////////////

                // @@ cuicui: bov
                $sql = "SELECT * FROM bank_item WHERE (user_id=? AND item_id > 0) ;"; 
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {

                    $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                    header("Location: /");
                    exit();
                } 
                else {    
                    mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                    mysqli_stmt_execute($stmt);
                    
                    $result = mysqli_stmt_get_result($stmt); 
                    $RowsBov = array ();
                    while($row2 = mysqli_fetch_array($result))
                    {
                        $RowsBov [] = $row2; 
                    }
                }

                echo '<h3>Boveda</h3><p>';

                $totitem=0;
                foreach ($RowsBov as $i) {
                    echo '<a href="#" title="Ver Ficha Ténica" class="simple" onclick="return verobjeto(' .$i['item_id'] .')">' .$RowsDataObj[$i['item_id']-1]['name'] . ' - ' .$i['amount'] .'</a><br>';
                        $totitem++;
                }
                if ($totitem == 0) {
                    echo 'No posee items en su inventario.';
                }
                

                // @@ cuicui: spells
                $sql = "SELECT * FROM spell WHERE (user_id=? AND spell_id>0);";
                $stmt = mysqli_stmt_init($conn);
                if (!mysqli_stmt_prepare($stmt, $sql)) {

                    $_SESSION['ERRORS']['err'] = 'SQL ERROR';
                    header("Location: /");
                    exit();
                } 
                else {    
                    mysqli_stmt_bind_param($stmt, "s",$rowINIT['id']);
                    mysqli_stmt_execute($stmt);
                    
                    $result = mysqli_stmt_get_result($stmt); 
                    $RowsSpells = array ();
                    while($row2 = mysqli_fetch_array($result))
                    {
                        $RowsSpells [] = $row2; 
                    }
                }


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


                echo '</p><h3>Hechizos</h3><p>';


                $totspell=0;
                foreach ($RowsSpells as $i) {
                    echo 

    '<a href="#" title="Ver Ficha Ténica" onclick="return verhechizo(' .($i['spell_id']) .')" class="simple">' .$RowsDataSpells[$i['spell_id']-1]['name'] .'</a><br>';
                        $totspell++;
                }
                if ($totspell == 0) {
                    echo 'No posee ningún hechizo.';
                }

                // @@ cuicui: VENTANA EMERGENTE!!!
                echo '<div class="ventana_emergente" id="divemergente">
                    <div class="ventana_emergente_bg_top" onclick="javascript:ocultar_emergente();" title="Cerrar">
                    <h4 id="e_titulo"></h4>
                    </div>
                    <div class="ventana_emergente_desc">
                    <span id="e_contenido"></span>
                    </div>
                    <div class="ventana_emergente_bg_bottom"></div>
                    </div>';

                echo '<div class="hz" onclick="javascript:ocultarhechizo();" id="divhechi">
                    <div class="hz_r">
                    <div class="hz_l">
                    <div class="hz_tit">
                    <h4 id="nombre">Cargando..</h4>
                    </div>
                    </div>
                    </div>
                    <div class="hz_info">
                    <div class="hz_desc">
                    <h5>DESCRIPCIÓN</h5>
                    </div>
                    <div class="hz_desc_bg">
                    <img src="../imagenes/hz/hz_img.gif" alt="">
                    <div class="hz_desc_txt">
                    <p id="descripcion"></p>
                    </div>
                    <div style="clear:both"></div>
                    <div class="hz_desc_bg_bottom"></div>
                    </div>
                    <ul>
                    <li>Precio: <span id="valor" class="hz_info_dato"></span><img src="../imagenes/hz/hz_oro.gif" alt="Monedas de Oro con 0 skill en comerciar"></li>
                    <li>Se lanza sobre: <span id="afecta" class="hz_info_dato"></span></li>
                    <li>Skill en magia requerido: <span id="skill" class="hz_info_dato"></span></li>
                    <li>Mana: <span id="manar" class="hz_info_dato"></span></li>
                    <li>Energia: <span id="star" class="hz_info_dato"></span></li>
                    <li>Clases prohibidas: <span id="clasesp" class="hz_info_dato"></span></li>
                    </ul>

                    <div class="hz_info_bg_bottom"></div>
                    </div>
                    </div>';
                echo '<div class="info_item" id="info_item" onclick="javascript:ocultaritem();">
                    <div class="info_item_bg_top">
                    <h4 id="i_nombre">Nombre del item</h4>
                    </div>
                    <div class="info_item_desc" id="i_desc">
                    <p>Descripcion del item asd sadda as d asds</p>
                    <p>sdasdkjalk a</p>
                    <p>sdjasdjlkasjdlkajslkd. por si hay un <a href="#">link</a></p>
                    </div>
                    <div class="info_item_bg_bottom"></div>
                    </div></div></div></div></div>';
            
        }
    }?>

</div>
</div>
</div>
</div>
