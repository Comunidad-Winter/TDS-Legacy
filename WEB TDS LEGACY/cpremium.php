<?php

   require_once $_SERVER['DOCUMENT_ROOT'].'/php/utils.php'; 
   $conn = connect();
   
   if (isset($_SESSION['id'])) {
      if ($_SESSION['banned'] == '1') { 
           
         $tm="";
         if (isset($_GET['a'])) $tm="a=".$_GET['a'];
         header("Location: banned.php?".$tm);
         exit; 
      } 
   }

   
   
   if (isset($_SESSION['id'])) {
      if ($_SESSION['verified'] == '0') { 
        
         #require_once $_SERVER['DOCUMENT_ROOT'] .'/cuentas/validar.php';
         #exit;
         #header("Location: /cuentas/validar.php");
         #exit; 
      }
   }

   if (isset($_GET['borrara'])) {
      require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/anuncios/a_borraranuncio.php';
   }

   if (isset($_GET['a'])) {
      switch ($_GET['a']) {
         case 'salir':            
            session_unset();
            session_destroy();
            header("Location: cuenta-premium.php");
            break;
         case 'mi_premium':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mi_premium/mi-premium.php';        
            break;
         case 'pre_soporte':
            header("Location: pre-soporte.php");
            break;
         case 'mis-soportes':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/soportes.php';
            break;  
         case 'listar-soportes':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/listar-soportes.php';
            break;   
         case 'responder-soporte-gm':
            if (!validsession()) exit();    
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/responder-soporte-gm.php';
            break;  
         case 'recupass':
            //require_once '/recupass.php';  //de cuenta    
            break;
         case 'mis_personajes':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/mis-personajes.php';
            break;
         case 'rec-clave':
            require_once $_SERVER['DOCUMENT_ROOT'].'/php/passwordResetRequest.php';
            break;
         //case 'transferir':
            //require_once 'mis-personajes_Transferir_Items.php';
            //break;
         case 'info':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/info.php';
            break;
         case 'agregar-personaje':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/agregar-personaje.php';
            break;
         case 'soporte':
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/soportes/soporte.php';   
            break;
         case 'mercado':
            if (!validsession()) exit();
            if (isset($_GET['s'])) {
               if ($_GET['s'] == 'e') {
                  if (isset($_GET['p'])) {           
                     require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/est_full.php';   
                     break;
                  }
               }else {
                  if (isset($_GET['p'])) {
                     // acá compro
                  }else {
                     // acá veo lista de mis pjs?
                  }
               }
               
            }
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/menu_principal.php';  
            break;
         case 'aceptar_cambio':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/aceptar_cambio.php'; 
            break;
         case 'finalizar_cambio':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/finalizar_cambio.php'; 
            break;
         case 'rechazar_cambio':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mercado/rechazar_cambio.php'; 
            break;            
         case 'contrasena':
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/contrasena/contrasena.php';
            break;
         case 'recover-pass':
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/contrasena/cambiar-contrasena.php';
            break;
         case 'resetpass-acc':
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/contrasena/cambiar-contrasena_acc.php';
            break;
         case 'resetpass-pj':
            require_once $_SERVER['DOCUMENT_ROOT'].'/php/passwordResetRequestPj.php';
            break;
         case 'borrar-personaje':
            
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/a_BorrarPersonaje.php';
            break;
         case 'borrar-personaje2':
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/a_BorrarPersonaje2.php';
            break;
         case 'quitar-personaje':
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mis_personajes/quitar-personaje.php';
            break;
         case 'agregar-tdsl':
            if (!validsession()) exit();
            include_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mi_premium/agregar-tdsl.php';
            break;  
         case 'reportar-bug':
            if (!validsession()) exit();
            include_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/reportar-bug/index.php';
            break;
         case 'validar-email':
            include_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/validar.php';
            break;
         default:
            if (!validsession()) exit();
            require_once $_SERVER['DOCUMENT_ROOT'].'/cuentas/mi_premium/mi-premium.php';
            break;
      }

      // FOOTER!
      require_once $_SERVER['DOCUMENT_ROOT'].'/footer.php';

   }else{
      header("Location: cpremium.php?a=mi-premium");
   }

?>