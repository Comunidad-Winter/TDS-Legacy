<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es" lang="es">
   <head>
      <?php 
         require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
         $conn = connect();
         require_gm();
         
         ?>
      <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
      <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
      <title>TDS Legacy - GM - Soportes</title>
      <meta name="keywords" content="Argentum Online, Argentum, AO, AO TDSL, AOTDSL, TDSL, TDS Legacy, Servidor Argentum Online, Servidor Argentum, Servidor AO, Server Argentum Online, Server Argentum, Server AO, Servidor TDS Legacy, Server TDS Legacy, Server TDSL, Servidor TDSL, Server AO TDSL, Servidor AO TDSL, Server AOTDSL, Servidor AOTDSL, Juego online, Juegos Online, Online, Juegos, Quest, Mini Estadisticas, Panel de personaje" />
      <!--[if lt IE 7.]>
      <script defer type='text/javascript' src='/scripts/pngfix.js'></script>
      <![endif]-->
      <link href='/general.css' rel='stylesheet' type='text/css' />
      <link href='/caja.css' rel='stylesheet' type='text/css' />
      <link href='/panel-premium.css' rel='stylesheet' type='text/css' />
      <link href='/cuentas-premium.css' rel='stylesheet' type='text/css' />
      <link href='/soporte.css' rel='stylesheet' type='text/css' />
      <link href='/soporte-gm.css' rel='stylesheet' type='text/css' />
      <script type="text/javascript" src="/cuentas/crearcuenta.js"></script>
      <script type="text/javascript" src="/cuentas/funciones.js"></script>
      <script type="text/javascript" src="/scripts/createjs-2015.11.26.min.js"></script>
      <script type="text/javascript" src="/scripts/animated_header.js"></script>
      <script type="text/javascript" src="/scripts/header.js"></script>
      <script type="text/javascript" src="/scripts/tipo_soporte.js"></script>
      <link href="/header.css" rel='stylesheet' type='text/css'>
   <body onload="init();">
      <div id='bg_top'>
      <div id='pagina'>
      <div id='header'>
         <div id="animation_container" style="background:none; width:700px; height:197px">
            <canvas id="canvas" width="700" height="197" style="position: absolute; display: none; background:none;"></canvas>
            <div id="dom_overlay_container" style="pointer-events:none; overflow:hidden; width:700px; height:197px; position: absolute; left: 0px; top: 0px; display: none;"> </div>
         </div>
         <div id='_preload_div_' style='position:absolute; top:0; left:0; display: inline-block; height:197px; width: 700px; text-align: center;'> <span style='display: inline-block; height: 100%; vertical-align: middle;'></span> <img src=/header_images/_preloader.gif style='vertical-align: middle; max-height: 100%' /></div>
      </div>
      <?php
         require_once $_SERVER['DOCUMENT_ROOT']. "/navbar.php";
      ?>
      <div class='titulo_seccion'>
         <h1>GM - Soportes</h1>
      </div>
      <div id="main">
      <div id="panel-premium">
         <div class="cuentas_premium" style="text-align:left;">
            <div class="tit">
               <h1>Panel <?php   if(isset($_SESSION['username'])) echo ("de ".$_SESSION['username']); else echo ("soporte");  ?></h1>
               <?php include $_SERVER['DOCUMENT_ROOT'].'/account-nav.php'; ?>
            </div>
            <br>
            <h1 align="center">Lista de soportes</h1>
            <br>
            <?php
               $sectorType = array(1 => 'Bug',2 => 'Ban',7 => 'Problema Técnico',9 => 'Denuncia GMs',11 => 'Robo de PJ/Estafa',15 => 'Otro',16 => 'Cuentas',17 => 'Nick inapropiado',20 => 'Denuncia de cheater',21 => 'Foro',22 => 'Quite T0 ingame',23 => 'Discord');
               $statusType = array(0 => 'No leído',1 => 'Respondido',2 => 'Abierto',3 => 'Cerrado');
               
               
               //$sql = "SELECT s.*, c.email, c.username FROM `soportes` AS S INNER JOIN cuentas AS C ON S.account_id=C.id   ORDER BY fecha_creacion DESC LIMIT 10";
               //echo '<tr><td>'.$sectorType[$row['sector']].'</td><td>'.$row['asunto'].'</td><td class="status_'.$row['estado'].'">'.$statusType[$row['estado']].'</td><td>'.$row['username'].'</td</tr>';
               ?>
            <div class="container py-4 text-center">
               <div class="card">
                  <div id="filtrar">
                     <form name="form1" method="post" action="">
                        <div align="center">
                           <big>Filtrar:</big>
                           <label>
                              <select name="sector" id="sector" onchange="return getData(1)">
                                 <option value="%">Cualquier sector</option>
                                 <option value="1">Bug</option>
                                 <option value="2">Ban</option>
                                 <option value="15">Otro</option>
                                 <option value="7">Problema Técnico</option>
                                 <option value="9">Denuncia GMs</option>
                                 <option value="11">Robo de PJ/Estafa</option>
                                 <option value="16">Cuentas</option>
                                 <option value="17">Nick inapropiado</option>
                                 <option value="20">Denuncia de cheater</option>
                                 <option value="21">Foro</option>
                                 <option value="22">Quite T0 ingame</option>
                                 <option value="23">Discord</option>
                              </select>
                           </label>
                           <select name="estado" id="estado" onchange="javascript:return getData(1)">
                              <option value="%">Cualquier estado</option>
                              <option value="0">No leído</option>
                              <option value="1">Leído</option>
                              <option value="2">Respondido</option>
                              <option value="3">Cerrado</option>
                              <option value="4">Reabierto</option>
                           </select>
                        </div>
                        <div align="center">
                           <label for="campo" class="col-form-label">Filtrar por cuenta: </label> <input type="text" name="campo" id="campo" class="form-control" value="">
                        </div>
                     </form>
                  </div>
                  <div class="card-header">Soportes</div>
               </div>
               <div class="card-body">
                  <div class="col">
                     <table class="table-concept">
                        <thead>
                           <th style="max-width:15%;">Cuenta</th>
                           <th style="max-width:20%;">Sector</th>
                           <th style="max-width:45%;">Asunto</th>
                           <th style="max-width:15%;">Estado</th>
                           <th style="max-width:15%;">Fecha</th>
                           <th style="max-width:10%;"></th>
                           <th style="max-width:10%;"></th>
                        </thead>
                        <tbody id="content">
                        </tbody>
                     </table>
                  </div>
               </div>
               <div class="row">
                  <div class="col-6">
                     <label id="lbl-total"></label>
                  </div>
               </div>
               <div class="center">
                  <div class="pagination" id="nav-paginacion"></div>
               </div>
            </div>


            <div class="container py-4 text-center">
               <div class="card">
                  <div id="filtrar2">
                     <form name="form2" method="post" action="">
                        <div align="center">
                           <big>Filtrar:</big>
                           <label>
                              <select name="sector2" id="sector2" onchange="return getData(1)">
                                 <option value="%">Cualquier sector</option>
                                 <option value="1">Bug</option>
                                 <option value="2">Ban</option>
                                 <option value="15">Otro</option>
                                 <option value="7">Problema Técnico</option>
                                 <option value="9">Denuncia GMs</option>
                                 <option value="11">Robo de PJ/Estafa</option>
                                 <option value="16">Cuentas</option>
                                 <option value="17">Nick inapropiado</option>
                                 <option value="20">Denuncia de cheater</option>
                                 <option value="21">Foro</option>
                                 <option value="22">Quite T0 ingame</option>
                                 <option value="23">Discord</option>
                              </select>
                           </label>
                           <select name="estado2" id="estado2" onchange="javascript:return getData(1)">
                              <option value="%">Cualquier estado</option>
                              <option value="0">No leído</option>
                              <option value="1">Leído</option>
                              <option value="2">Respondido</option>
                              <option value="3">Cerrado</option>
                              <option value="4">Reabierto</option>
                           </select>
                        </div>
                        <div align="center">
                           <label for="campo2" class="col-form-label">Filtrar por cuenta: </label> <input type="text" name="campo2" id="campo2" class="form-control" value="">
                        </div>
                     </form>
                  </div>
                  <div class="card-header">Soportes</div>
               </div>
               <div class="card-body">
                  <div class="col">
                     <table class="table-concept">
                        <thead>
                           <th style="max-width:15%;">Cuenta</th>
                           <th style="max-width:20%;">Sector</th>
                           <th style="max-width:45%;">Asunto</th>
                           <th style="max-width:15%;">Estado</th>
                           <th style="max-width:15%;">Fecha</th>
                           <th style="max-width:10%;"></th>
                           <th style="max-width:10%;"></th>
                        </thead>
                        <tbody id="content2">
                        </tbody>
                     </table>
                  </div>
               </div>
               <div class="row">
                  <div class="col-6">
                     <label id="lbl-total2"></label>
                  </div>
               </div>
               <div class="center">
                  <div class="pagination" id="nav-paginacion2"></div>
               </div>
            </div>




         </div>
      </div>
      <script type="text/javascript" src="/scripts/gm_soporte.js"></script>
      